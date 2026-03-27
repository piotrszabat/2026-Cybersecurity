# Day 58 - IOC Hunting

## Overview

On Day 58, I moved from passive monitoring to proactive threat hunting in my homelab environment.  
After integrating threat intelligence into Splunk on Day 57, the next logical step was to use that intelligence operationally by hunting for Indicators of Compromise (IOCs) across my telemetry.

The main objective of this lab day was to search Wazuh alerts in Splunk for suspicious:

- IP addresses
- file hashes
- domains

This exercise helped simulate the workflow of a SOC analyst or threat hunter who is not only waiting for alerts, but actively searching the environment for known malicious artifacts.

---

## Lab Environment

My homelab at this stage included the following systems:

- **KALI01** - attacker/testing machine
- **FW01** - firewall between network segments
- **DC01** - domain controller
- **PC01** - user workstation
- **SRV01** - server
- **WAZ01** - Wazuh management server
- **SPLK01** - Splunk server

### Telemetry Flow

The hunting workflow for this day was:

```text
Endpoints / network activity
   ↓
Wazuh agents and alerts
   ↓
Splunk ingestion
   ↓
IOC lookups
   ↓
Hunt searches and result analysis
````

This day focused on using telemetry that was already available in Splunk and validating whether known suspicious indicators appeared anywhere in the environment.

---

## Objective

The objective for Day 58 was to perform a structured IOC hunt and document the process step by step.

By the end of the lab, I wanted to:

* prepare custom IOC lists
* upload them into Splunk as lookup tables
* validate that the lookup files worked correctly
* identify useful fields in Wazuh telemetry
* perform separate hunts for IPs, hashes, and domains
* create at least one controlled test hit
* document findings and limitations

---

## Step 1 - Preparing IOC Lists

The first task was to prepare small, curated IOC datasets instead of using a very large feed.
For learning and portfolio purposes, a smaller list made the process easier to understand and validate.

I created three IOC files:

* `ioc_ips.csv`
* `ioc_hashes.csv`
* `ioc_domains.csv`

Each file included the following columns:

* `indicator`
* `type`
* `description`
* `source`

### Example IP IOC list

```csv
indicator,type,description,source
192.168.10.20,ip,Lab test attacker IP,Manual
1.2.3.4,ip,Known suspicious IP,Threat Intel
5.6.7.8,ip,Credential abuse IP,Threat Intel
```

### Example hash IOC list

```csv
indicator,type,description,source
44d88612fea8a8f36de82e1278abb02f,hash,Example malicious MD5,Threat Intel
eicar_test_hash_placeholder,hash,Lab placeholder hash,Manual
```

### Example domain IOC list

```csv
indicator,type,description,source
malicious-example.com,domain,Suspicious domain,Threat Intel
evil-lab.local,domain,Lab test domain,Manual
```

This step established the data that would later be used for matching inside Splunk.

---

## Step 2 - Uploading IOC Files into Splunk

After creating the IOC files, I uploaded them into Splunk.

In Splunk Web, I navigated to:

```text
Settings → Lookups → Lookup table files
```

I uploaded all three CSV files:

* `ioc_ips.csv`
* `ioc_hashes.csv`
* `ioc_domains.csv`

Then I created or prepared lookup definitions with names such as:

* `ioc_ips_lookup`
* `ioc_hashes_lookup`
* `ioc_domains_lookup`

This turned the IOC files into reusable reference datasets that could be called directly from Splunk searches.

This was an important step because it made the hunting process more realistic and repeatable.

---

## Step 3 - Validating the Lookup Files

Before starting the hunt, I verified that Splunk could read the uploaded IOC files correctly.

I used the following searches:

```spl
| inputlookup ioc_ips.csv
```

```spl
| inputlookup ioc_hashes.csv
```

```spl
| inputlookup ioc_domains.csv
```

This validation confirmed that:

* the files were successfully uploaded
* the structure was correct
* the IOC values were visible inside Splunk
* the data was ready for use in lookup-based searches

Without this step, later hunt queries could fail silently due to formatting or upload issues.

---

## Step 4 - Discovering Relevant Fields in Telemetry

Before writing hunt queries, I needed to understand which fields in my Wazuh data actually contained IPs, hashes, and domains.

Instead of guessing field names, I explored the telemetry first.

### IP field discovery

```spl
index="wazuh-alerts"
| table _time agent.name src_ip data.srcip source.ip destination.ip rule.description
| head 20
```

This helped me identify whether the environment was using fields such as:

* `agent.ip`
* `data.srcip`
* `source.ip`
* `destination.ip`

### Hash field discovery

```spl
index="wazuh-alerts"
| table _time agent.name data.win.eventdata.hashes hashes file.hash rule.description
| head 20
```

This helped verify whether hash-related data was present in fields such as:

* `data.win.eventdata.hashes`
* `hashes`
* `file.hash`

### Domain and command-line field discovery

```spl
index="wazuh-alerts"
| table _time agent.name data.win.eventdata.commandLine data.win.eventdata.commandline rule.description
| head 20
```

This was useful because domain hunting in a small lab is often easiest through command-line telemetry, especially from PowerShell activity.

This field discovery phase was important because it allowed me to tailor the hunt logic to the actual data in my environment.

---

## Step 5 - Hunting for Malicious IPs

The first IOC type I hunted for was IP addresses.

This was the easiest starting point because IP fields were already visible in Wazuh alerts and usually easier to correlate than hashes or domains.

I used the following search:

```spl
index="wazuh-alerts" src_ip=*
| lookup ioc_ips_lookup indicator AS src_ip OUTPUT type description source
| search description=*
| table _time agent.name src_ip type description source rule.description
| sort - _time
```

### What this query did

* searched Wazuh alerts for events containing `src_ip`
* compared the source IP value to my uploaded IOC list
* returned only events where a match was found
* displayed the time, host, matching IP, IOC metadata, and rule description

### Outcome

This was the clearest and most successful IOC hunt in the lab.

It showed that:

* Splunk lookup matching was working correctly
* IP-based threat hunting was practical in my environment
* I could directly correlate suspicious IPs to hosts and events

When necessary, I could adapt the query to other fields such as `data.srcip`.

---

## Step 6 - Hunting for Hashes

Next, I attempted to hunt for suspicious file hashes.

Hash hunting is useful for identifying known malicious files or artifacts, but it depends heavily on the quality of endpoint telemetry and how fields are parsed.

I first checked for hash-related events using:

```spl
index="wazuh-alerts" (hash OR hashes OR md5 OR sha1 OR sha256)
| table _time agent.name rule.description data.win.eventdata.hashes
| head 50
```

This search helped determine whether hashes were actually available in my data.

If a direct hash field existed, the intended lookup-based hunt would look like this:

```spl
index="wazuh-alerts" data.win.eventdata.hashes=*
| lookup ioc_hashes_lookup indicator AS data.win.eventdata.hashes OUTPUT type description source
| search description=*
| table _time agent.name data.win.eventdata.hashes type description source rule.description
| sort - _time
```

### Outcome

Hash hunting was more limited than IP hunting.

This part of the lab highlighted that:

* hash-based investigations require appropriate event sources
* Sysmon or FIM-related telemetry must be configured properly
* not every environment will expose hashes in a clean field by default

Even if no strong match was found, this step was valuable because it showed where telemetry limitations existed.

---

## Step 7 - Hunting for Suspicious Domains

The third part of the hunt focused on domains.

In a homelab, domain indicators often appear in:

* PowerShell command lines
* script execution logs
* browser-related commands
* downloaded content references

I first used a direct search approach, which is often more realistic in a small environment:

```spl
index="wazuh-alerts" ("malicious-example.com" OR "evil-lab.local")
| table _time agent.name rule.description data.win.eventdata.commandLine data.win.eventdata.commandline
| sort - _time
```

I also considered the command-line fields using a normalized version:

```spl
index="wazuh-alerts" (data.win.eventdata.commandLine=* OR data.win.eventdata.commandline=*)
| eval cmd=coalesce(data.win.eventdata.commandLine,data.win.eventdata.commandline)
| table _time agent.name cmd rule.description
| head 50
```

### Outcome

Domain hunting was practical through command-line telemetry.

This part of the exercise showed that:

* suspicious domains can often be found in PowerShell or command execution logs
* domain hunting may require string matching rather than exact field equality
* a smaller lab still allows realistic hunting workflows if telemetry is available

---

## Step 8 - Generating a Controlled Test Hit

To make the IOC hunt meaningful, I created at least one controlled match in the lab.

This was important because a hunt with zero results does not confirm that the logic works.
A controlled hit proves that the workflow is functional.

I used a safe and deliberate test approach.

### Example domain test

On **PC01**, I executed a harmless PowerShell command containing a test domain string:

```powershell
powershell "Write-Output 'malicious-example.com'"
```

This gave me a known string that could later appear in command-line telemetry.

### Alternative IP test

Another option was to take a real IP already present in telemetry and add it to `ioc_ips.csv`, then rerun the lookup-based search.

### Why this mattered

This step validated that:

* Splunk was ingesting the relevant events
* the IOC string could be observed in telemetry
* the hunt queries were capable of returning expected matches

Controlled validation is an important part of both detection engineering and threat hunting.

---

## Step 9 - Building a Combined Hunt View

After testing individual IOC types, I created a broader hunt view that could summarize IOC-related activity more efficiently.

Example search:

```spl
index="wazuh-alerts"
| eval hunt_ip=src_ip
| lookup ioc_ips_lookup indicator AS hunt_ip OUTPUT description AS ip_description
| eval cmd=coalesce(data.win.eventdata.commandLine,data.win.eventdata.commandline)
| eval domain_match=if(like(cmd,"%malicious-example.com%") OR like(cmd,"%evil-lab.local%"),"yes","no")
| eval ip_match=if(isnotnull(ip_description),"yes","no")
| where ip_match="yes" OR domain_match="yes"
| table _time agent.name src_ip cmd ip_description rule.description
| sort - _time
```

### Purpose of this step

This search provided a more analyst-friendly summary by:

* checking for IP matches using the lookup table
* checking for domain matches in command-line activity
* returning only events related to IOC logic
* creating one place to review interesting hits

This simulated the process of building a hunt dashboard or a compact analyst review query.

---

## Step 10 - Reviewing and Interpreting Results

Once the searches were complete, I analyzed the results for each IOC type.

### IP hunting results

IP hunting produced the clearest matches in the lab.
This was the most reliable IOC category because source IP fields were already visible and easy to compare against the lookup file.

### Hash hunting results

Hash hunting was less productive because it depended on whether my telemetry included consistent hash fields.
This highlighted a telemetry maturity issue rather than a hunt failure.

### Domain hunting results

Domain hunting successfully demonstrated that command-line telemetry could reveal suspicious strings.
The controlled test domain was useful for validating the process end to end.

### Key lesson from result analysis

Not every match has the same importance.
Part of the analyst workflow is determining whether a hit is:

* a real suspicious event
* a test artifact
* a false positive
* a telemetry issue
* an indication that logging needs improvement

This interpretation step made the exercise more realistic and portfolio-worthy.

---

## Findings

The IOC hunt produced several useful conclusions:

* IP-based hunting was the easiest and most effective method in my environment
* domain hunting worked well through PowerShell and command-line logs
* hash hunting depended heavily on telemetry quality and field parsing
* small curated IOC lists were sufficient for learning and validation
* controlled test hits were essential to confirm that hunt logic worked

---

## Limitations

This lab also revealed some practical limitations:

* a small homelab does not generate the same volume and variety of telemetry as a production environment
* hash-based hunting is only as good as the endpoint logging configuration
* domain hunting may require partial string matching instead of exact lookups
* IOC datasets were intentionally small and curated for demonstration purposes

These limitations were still valuable because they highlighted where further lab improvements could be made.

---

## Skills Demonstrated

This day demonstrated the following practical skills:

* proactive threat hunting
* IOC-based investigation
* Splunk lookup usage
* field discovery in Wazuh telemetry
* validation of hunt logic with controlled test data
* correlation of telemetry across hosts and alert sources
* understanding of detection limitations and logging gaps

---

## Conclusion

Day 58 was an important milestone in the development of my SOC homelab because it moved beyond alert enrichment and into proactive security operations.

By preparing IOC lists, uploading them into Splunk, validating lookup functionality, identifying relevant fields, and performing separate hunts for IPs, hashes, and domains, I built a complete introductory IOC hunting workflow.

The strongest results came from IP and domain hunting, while hash hunting showed the importance of telemetry quality and parsing.
Overall, this lab day demonstrated how threat intelligence can be operationalized in Splunk to proactively search for suspicious activity rather than waiting for detections alone.

---

## Portfolio Summary

Performed proactive IOC hunting in Splunk using Wazuh telemetry by preparing custom IOC lookup files, validating field mappings, hunting for suspicious IPs, hashes, and domains, and confirming the workflow through controlled test indicators.