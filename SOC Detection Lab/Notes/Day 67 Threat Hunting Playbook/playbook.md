# Threat Hunting Playbook

## Objective

The objective of this playbook is to define a structured and repeatable threat hunting methodology using Splunk and Wazuh in a segmented SOC homelab environment.

This playbook is based on real attack simulations and incident response activities performed in the lab, including ransomware simulation, lateral movement, and credential abuse scenarios.

---

## Definition

Threat hunting is a proactive process of searching for signs of malicious activity that may not trigger automated alerts.

In this lab, threat hunting is performed using:

- Splunk (SIEM)
- Wazuh (EDR/XDR)
- Windows Event Logs
- Sysmon telemetry

The goal is to identify suspicious behavior such as:

- PowerShell abuse
- credential attacks
- lateral movement
- abnormal file activity (ransomware-like behavior)

---

## Hunting Workflow

The following methodology is used for all hunts:

1. **Define hypothesis**  
   Example: attacker is using PowerShell to create malicious files

2. **Identify data sources**
   - Wazuh alerts
   - Windows logs
   - Sysmon logs
   - Splunk index: `wazuh-alerts`

3. **Build detection logic (SPL query)**  
   Create targeted searches in Splunk

4. **Analyze results**
   - Identify patterns
   - Detect anomalies
   - Correlate events

5. **Document findings**
   - Confirm or reject hypothesis
   - Record evidence
   - Escalate if needed

---

## Data Sources

The following data sources are used in this lab:

- Wazuh (endpoint detection and alerts)
- Windows Security Logs
- Sysmon (process and command-line visibility)
- Splunk SIEM (centralized analysis)
- pfSense (network segmentation and firewall logs)
- Threat Intelligence feeds (AbuseIPDB, OTX)

---

## Hunting Scenarios

---

### 1. Credential Abuse

**Hypothesis:**  
An attacker is performing password spraying or repeated authentication attempts.

**MITRE ATT&CK:**  
T1110 — Brute Force

**Splunk Query:**

```spl
index="wazuh-alerts" ("4625" OR "failed" OR "authentication")
| stats count by agent.name src_ip data.win.eventdata.targetUserName
| sort - count
````

**Analysis Focus:**

* High number of failed logins
* One IP targeting multiple users
* Abnormal login patterns

**Outcome:**

Helps detect brute force or password spraying attempts across the environment.

---

### 2. Lateral Movement

**Hypothesis:**
An attacker is moving laterally using remote execution tools.

**MITRE ATT&CK:**
T1021 — Remote Services

**Splunk Query:**

```spl
index="wazuh-alerts" (psexec OR wmiexec OR services.exe OR cmd.exe)
| stats count by agent.name data.win.eventdata.image
| sort - count
```

**Analysis Focus:**

* Remote command execution
* Service creation
* Activity across multiple hosts

**Outcome:**

Identifies movement between systems such as PC01 → SRV01 or DC01.

---

### 3. Suspicious PowerShell Activity

**Hypothesis:**
PowerShell is being used to execute malicious commands or create payloads.

**MITRE ATT&CK:**
T1059.001 — PowerShell

**Splunk Query:**

```spl
index="wazuh-alerts" (powershell OR pwsh)
| table _time agent.name data.win.eventdata.commandLine
| sort - _time
```

**Analysis Focus:**

* Encoded commands
* File creation activity
* Web requests (download attempts)

**Outcome:**

Detects script-based execution and attacker tooling.

---

### 4. Ransomware-like File Activity (Day 63–64 Case Study)

**Hypothesis:**
A host is exhibiting ransomware-like behavior through rapid file modification and script execution.

**MITRE ATT&CK:**
T1486 — Data Encrypted for Impact

**Splunk Query:**

```spl
index="wazuh-alerts" agent.name=PC01 (modified OR created OR deleted OR "file integrity")
| table _time rule.description data.win.eventdata.processName data.win.eventdata.commandLine
| sort _time
```

**Observed Behavior:**

* Executable dropped in Windows root folder
* PowerShell created multiple files
* Repeated file modification activity
* Malware-like directory usage

**Outcome:**

Confirmed simulated ransomware activity on PC01.

---

## Incident Response Integration (Day 64)

Threat hunting results were escalated into a full incident response workflow:

### 1. Identification

Suspicious PowerShell execution and file activity detected in Splunk/Wazuh.

### 2. Timeline Creation

A pre-containment timeline was built:

* executable dropped
* PowerShell execution
* file modifications

### 3. Containment

PC01 was isolated using a pfSense firewall rule:

* Source: 192.168.10.20
* Action: Block all traffic

This prevented lateral movement and further execution.

### 4. Eradication

* Removed files from:
  `C:\Users\Public\ransomware_test\`
* Deleted `.locked` and test artifacts
* Verified no active malicious processes

### 5. Validation

* No new suspicious activity observed
* Endpoint remained isolated and stable

---

## IOC-Based Hunting

IOC-based hunting is used to detect known malicious indicators.

**Example:**

```spl
index="wazuh-alerts" src_ip=*
| lookup ioc_ips_lookup indicator AS src_ip OUTPUT description
| search description=*
```

**Purpose:**

* Identify known malicious IPs/domains
* Validate alerts against threat intelligence

---

## Threat Intelligence Enrichment

Threat intelligence is used to prioritize findings.

**Example:**

```spl
index="wazuh-alerts"
| lookup abuseipdb_lookup ip AS src_ip OUTPUT abuse_confidence_score
| search abuse_confidence_score=*
```

**Purpose:**

* Add context to alerts
* Identify high-risk sources
* Improve triage decisions

---

## Investigation Workflow

If suspicious activity is identified:

1. Build timeline
2. Identify affected host(s)
3. Identify involved user accounts
4. Correlate events across systems
5. Validate detections and rules
6. Escalate to incident response if confirmed

---

## When to Perform Threat Hunting

Threat hunting should be performed:

* After alerts are triggered
* After new threat intelligence is received
* After suspicious behavior is observed
* On a scheduled basis (weekly/monthly)

---

## Tools Used

* Splunk (SIEM)
* Wazuh (EDR/XDR)
* Sysmon
* pfSense (firewall + segmentation)
* Kali Linux (attack simulation)
* Greenbone/OpenVAS (vulnerability scanning)

---

## Lessons Learned

* Threat hunting requires strong visibility across endpoints
* Correlating multiple data sources improves detection quality
* File activity is a strong indicator of ransomware behavior
* SIEM queries must be tuned to reduce noise
* Incident response depends on fast and accurate scoping
* Network isolation is an effective containment strategy

---

## Outcome

A structured threat hunting methodology was developed and validated using real attack simulations in the lab environment.

The playbook demonstrates the ability to:

* perform hypothesis-driven threat hunting
* analyze endpoint telemetry
* correlate events across systems
* integrate threat intelligence
* escalate findings into incident response

---

## Skills Demonstrated

* Threat hunting methodology
* Splunk (SPL querying)
* Wazuh investigation
* MITRE ATT&CK mapping
* Incident response integration
* Endpoint analysis
* IOC hunting
