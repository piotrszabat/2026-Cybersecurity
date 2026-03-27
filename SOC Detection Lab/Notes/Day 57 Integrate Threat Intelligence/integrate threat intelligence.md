# Day 57 — Threat Intelligence Integration

## Objective

The objective of this lab was to integrate external threat intelligence into the Splunk SIEM workflow using AbuseIPDB and AlienVault OTX datasets. The goal was to enrich security events with external context and improve detection quality.

---

## Environment

The lab environment consisted of:

* Wazuh (log collection and alerting)
* Splunk (SIEM platform)
* Endpoint: PC01
* Network: NET-INT / NET-SOC

Data flow:

```
Endpoint logs → Wazuh → Splunk → Threat Intelligence Lookups → Enriched Events
```

---

## Step 1 — Understanding Threat Intelligence Sources

Two threat intelligence sources were introduced:

* **AbuseIPDB** — used for IP reputation (malicious/suspicious IP scoring)
* **AlienVault OTX** — used for IOC enrichment (indicators such as IPs, domains, hashes)

---

## Step 2 — Defining Enrichment Target

The enrichment focus was placed on IP addresses present in logs.
In this lab, the available field was:

```
agent.ip
```

This field represents the IP address of the Wazuh agent.

---

## Step 3 — Creating AbuseIPDB Dataset

A CSV lookup file was created:

```csv
ip,abuse_confidence_score,source,last_seen,comment
1.2.3.4,95,AbuseIPDB,2026-03-18,Known malicious IP
5.6.7.8,85,AbuseIPDB,2026-03-18,High confidence abuse
192.168.10.20,90,AbuseIPDB,2026-03-18,Lab test match
```

This dataset simulates IP reputation data.

---

## Step 4 — Creating OTX Dataset

A second CSV lookup file was created for IOC enrichment:

```csv
indicator,type,pulse_name,source,comment
192.168.10.20,ip,Lab Test Pulse,OTX,Test IOC match
```

This dataset simulates threat intelligence indicators.

---

## Step 5 — Uploading Lookups to Splunk

Both CSV files were uploaded into Splunk:

```
Settings → Lookups → Lookup table files
```

Files uploaded:

* abuseipdb_lookup.csv
* otx_lookup.csv

---

## Step 6 — Creating Lookup Definitions

Lookup definitions were created:

* **abuseipdb_lookup**

  * match field: `ip`

* **otx_lookup**

  * match field: `indicator`

Splunk successfully parsed the fields from both datasets.

---

## Step 7 — Lookup Validation

The datasets were validated using:

```spl
| inputlookup abuseipdb_lookup.csv
| inputlookup otx_lookup.csv
```

This confirmed that the lookup tables were readable and correctly formatted.

---

## Step 8 — Identifying IP Field in Logs

Log analysis was performed to identify relevant IP fields:

```spl
index="wazuh-alerts"
| table _time agent.name *ip*
| head 20
```

The field selected for enrichment:

```
agent.ip
```

---

## Step 9 — AbuseIPDB Enrichment

Wazuh events were enriched with IP reputation data:

```spl
index="wazuh-alerts" agent.ip=*
| lookup abuseipdb_lookup ip AS agent.ip OUTPUT abuse_confidence_score source comment
| search abuse_confidence_score=*
| table _time agent.name agent.ip abuse_confidence_score source comment rule.description
| sort - _time
```

Result:

* Events were successfully enriched with AbuseIPDB data
* IP matches added reputation context to logs

---

## Step 10 — OTX Enrichment

Events were enriched with IOC data:

```spl
index="wazuh-alerts" agent.ip=*
| lookup otx_lookup indicator AS agent.ip OUTPUT type pulse_name source
| search pulse_name=*
| table _time agent.name agent.ip type pulse_name source rule.description
| sort - _time
```

Result:

* Matching events were enriched with OTX pulse information
* IOC context was successfully added

---

## Step 11 — Combined Threat Intelligence Search

Both enrichment sources were combined:

```spl
index="wazuh-alerts" agent.ip=*
| lookup abuseipdb_lookup ip AS agent.ip OUTPUT abuse_confidence_score comment AS abuse_comment
| lookup otx_lookup indicator AS agent.ip OUTPUT pulse_name comment AS otx_comment
| eval ti_match=if(isnotnull(abuse_confidence_score) OR isnotnull(pulse_name),"yes","no")
| search ti_match="yes"
| table _time agent.name agent.ip abuse_confidence_score pulse_name abuse_comment otx_comment rule.description
| sort - _time
```

This provided a unified enriched view of events.

---

## Step 12 — Threat Intelligence Correlation

A correlation search was created:

```spl
index="wazuh-alerts" agent.ip=*
| lookup abuseipdb_lookup ip AS agent.ip OUTPUT abuse_confidence_score
| lookup otx_lookup indicator AS agent.ip OUTPUT pulse_name
| eval ti_match=if(isnotnull(abuse_confidence_score) OR isnotnull(pulse_name),"yes","no")
| search ti_match="yes"
| stats count by agent.ip agent.name abuse_confidence_score pulse_name rule.description
| sort - count
```

This demonstrates:

```
Behavior + Threat Intelligence = Enhanced Detection Context
```

---

## Step 13 — Alert Creation

The correlation search was saved as a Splunk alert:

* Title: Threat Intel Matched Activity
* Trigger: Number of results > 0
* Schedule: Every 5 minutes
* Severity: High

---

## Step 14 — Validation

To validate enrichment:

* A real IP from logs (`192.168.10.20`) was added to both lookup files
* The search was re-run
* Matching events were successfully enriched

---

## Outcome

Threat intelligence was successfully integrated into the Splunk workflow using CSV-based lookups. Events were enriched with external context, improving visibility and analysis capability.

---

## Key Skills Demonstrated

* Threat intelligence integration
* Splunk lookup configuration
* IOC enrichment
* SIEM data correlation
* IP reputation analysis
* Alert enrichment and prioritization

---

## Key Takeaway

This lab demonstrates the transition from:

```
Detection only
```

to:

```
Detection + Context + Prioritization
```

which is a core capability in real-world SOC operations.

