# Day 56 — Attack Investigation & Incident Timeline Reconstruction

## 🎯 Objective

The goal of Day 56 was to perform a full investigation of previously simulated attack activity and reconstruct a complete incident timeline using telemetry from **Wazuh** and **Splunk**.

This stage represents a transition from detection to investigation:

```text
collect → correlate → investigate → explain
```

The objective was to analyze authentication events, lateral movement activity, and endpoint telemetry, then combine them into a coherent incident narrative.

---

## 🧪 Lab Environment

### Infrastructure

* **Attacker:** KALI01
* **Targets:** PC01, SRV01
* **Detection Stack:** Wazuh + Splunk

### Investigation Scope

The investigation focused on activity generated during:

* credential attacks (Day 55)
* lateral movement (Day 54)

---

## 🔗 Attack Chain Overview

```text
KALI01
   ↓
Credential Abuse (SMB / Password Spraying)
   ↓
Failed Authentication Events (Windows)
   ↓
Remote Execution (PsExec / WMI / PowerShell)
   ↓
Lateral Movement (PC01 → SRV01)
   ↓
Telemetry → Wazuh → Splunk
```

---

## 🔍 Investigation Process

### 1. Broad Event Collection

Started with a wide search in Splunk to gather all potentially relevant activity:

```spl
index="wazuh-alerts" (powershell OR wmiexec OR psexec OR "4625" OR authentication OR services.exe OR cmd.exe)
| sort _time
```

This provided a baseline dataset including:

* failed authentication events
* process creation activity
* PowerShell execution
* remote execution traces

---

### 2. Initial Access Analysis (Credential Abuse)

Focused on failed authentication events:

```spl
index="wazuh-alerts" ("4625" OR "failed" OR "authentication")
| table _time agent.name rule.description src_ip data.win.eventdata.targetUserName
| sort _time
```

#### Findings:

* multiple failed login attempts observed
* activity consistent with **password spraying / SMB login attempts**
* repeated targeting of specific accounts
* authentication attempts across multiple endpoints

---

### 3. Authentication Pattern Correlation

Grouped authentication events:

```spl
index="wazuh-alerts" ("4625" OR "failed")
| stats count by agent.name, data.win.eventdata.targetUserName, src_ip
| sort - count
```

#### Insights:

* high concentration of failed logins on specific hosts (PC01)
* repeated attempts against multiple usernames
* evidence of automated or scripted behavior

---

### 4. Execution Phase Investigation

Analyzed process and command execution:

```spl
index="wazuh-alerts" (services.exe OR cmd.exe OR powershell OR pwsh)
| table _time agent.name rule.description data.win.eventdata.image data.win.eventdata.commandLine
| sort _time
```

#### Findings:

* process execution following authentication attempts
* service-related activity consistent with PsExec behavior
* command-line execution traces on endpoints

---

### 5. Lateral Movement Evidence

Focused on cross-host activity:

```spl
index="wazuh-alerts" (powershell OR wmiexec OR psexec OR services.exe OR cmd.exe)
| table _time agent.name rule.description data.win.eventdata.image
| sort _time
```

#### Findings:

* activity observed on multiple endpoints (PC01, SRV01)
* remote execution patterns consistent with lateral movement
* sequence aligned with attacker moving between hosts

---

### 6. PowerShell Activity Analysis

Investigated PowerShell-specific telemetry:

```spl
index="wazuh-alerts" (powershell OR pwsh OR "PowerShell")
| table _time agent.name rule.description data.win.eventdata.commandLine
| sort _time
```

#### Findings:

* PowerShell execution on target systems
* correlation with remote activity timeline
* strong indicator of post-authentication execution

---

### 7. SIEM Detection Validation

Reviewed triggered alerts in Splunk:

* Multiple Failed Login Attempts
* Suspicious PowerShell Activity

#### Outcome:

* correlation rules successfully detected parts of the attack
* confirmed alignment between raw telemetry and SIEM alerts

---

## 🧠 Incident Timeline

### Phase 1 — Initial Access

* repeated failed authentication attempts detected
* multiple usernames targeted
* activity consistent with password spraying

---

### Phase 2 — Lateral Movement

* remote execution indicators observed
* process/service creation on endpoints
* activity expanded across multiple hosts

---

### Phase 3 — Execution

* PowerShell and command execution detected
* endpoint activity aligned with attacker behavior
* telemetry confirms post-authentication access

---

## 🔎 Key Findings

* authentication abuse was clearly visible in endpoint telemetry
* failed login patterns provided early attack indicators
* lateral movement activity was observable across multiple systems
* PowerShell and process execution confirmed attacker progression
* Splunk enabled correlation across hosts and attack phases

---

## ⚠️ Challenges & Observations

* SMB communication required troubleshooting during attack simulation
* authentication attempts did not always immediately produce expected results
* resource constraints (RAM / services) impacted lab stability
* field parsing differences required adapting Splunk queries

---

## 📊 Outcome

```text
[+] full incident investigation completed
[+] authentication activity analyzed
[+] lateral movement identified
[+] execution phase confirmed
[+] SIEM detections validated
[+] timeline reconstructed
```

---

## 🧰 Skills Demonstrated

* incident investigation and triage
* timeline reconstruction
* authentication log analysis (Event ID 4625)
* lateral movement detection
* PowerShell activity analysis
* SIEM querying (Splunk SPL)
* Wazuh telemetry correlation
* multi-host event correlation
* troubleshooting detection pipelines

---

## 🏁 Final Summary

This lab demonstrated the ability to investigate a simulated cyber attack end-to-end by correlating authentication events, remote execution activity, and SIEM alerts into a structured incident timeline.

The investigation confirmed that:

```text
attack behavior → endpoint telemetry → Wazuh → Splunk → investigation
```

This represents a real-world SOC workflow, where analysts must connect multiple signals into a single, understandable incident narrative.

---

## ➡️ Next Step

**Day 57 — Threat Intelligence Integration**

Planned focus:

* enrich events with threat intelligence
* identify suspicious IPs / indicators
* improve detection context
