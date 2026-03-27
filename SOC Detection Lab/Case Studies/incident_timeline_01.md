Day 20 introduced lateral movement simulation into the HomeLab environment, marking a transition from isolated detection engineering toward full attack chain awareness.  
The objective of this lab was to simulate internal attacker movement between hosts and observe the resulting telemetry across Windows Security logs, Sysmon endpoint telemetry, and SIEM correlation within Splunk.

This exercise replicated a common adversary workflow where authenticated access is leveraged to move laterally within a network. The lab emphasized connectivity validation, remote authentication activity, simulated remote command execution, telemetry validation across multiple log sources, and timeline-based investigation within the SIEM.

🌐 Connectivity Validation & Attack Surface Confirmation  
Initial reconnaissance and connectivity validation were performed from the attacker VM to ensure target reachability prior to lateral movement attempts.

Actions performed  
Validated ICMP connectivity from KALI01 to PC01  
Executed targeted port scan to confirm SMB service exposure  
Confirmed target host accessibility required for lateral movement simulation  

Outcome  
Established verified network reachability between attacker and target systems.

Skills practiced  
Network reconnaissance  
Service exposure validation  
Attack surface awareness  

🔐 Remote Authentication Simulation (SMB)  
Authenticated access attempts were performed to simulate credential-based lateral movement behavior.

Actions performed  
Executed SMB authentication attempt from Kali attacker VM  
Observed authentication success indicators within attack tooling output  
Confirmed generation of network logon telemetry on target endpoint  

Outcome  
Successfully simulated credential-based remote authentication indicative of lateral movement preparation.

Skills practiced  
Credential-based access simulation  
Authentication telemetry generation  
Lateral movement workflow awareness  

💻 Remote Command Execution Simulation  
Remote execution capability was simulated to emulate attacker post-authentication activity on the target system.

Actions performed  
Executed remote command invocation against target endpoint  
Observed command execution feedback within attacker tooling  
Confirmed creation of process and network telemetry on target host  

Outcome  
Successfully simulated remote command execution behavior consistent with lateral movement techniques.

Skills practiced  
Remote execution simulation  
Execution telemetry generation  
Adversary behavior modeling  

📊 Windows Security Log Validation  
Windows Security logs were reviewed to confirm authentication artifacts produced during the simulation.

Actions performed  
Reviewed Security log for network logon events (EventCode 4624)  
Inspected privilege assignment and process-related events  
Validated account context and logon type associated with simulated activity  

Outcome  
Confirmed visibility of lateral authentication behavior within Windows Security telemetry.

Skills practiced  
Authentication log analysis  
Logon type interpretation  
Identity-based investigation  

🖥️ Sysmon Telemetry Validation  
Sysmon endpoint telemetry was analyzed to capture process and network activity generated during lateral movement.

Actions performed  
Reviewed Sysmon Process Create events for remotely executed processes  
Reviewed Sysmon Network Connection events associated with attacker host  
Analyzed parent-child process relationships for contextual awareness  

Outcome  
Validated endpoint-level behavioral visibility supporting lateral movement detection.

Skills practiced  
Endpoint behavioral analysis  
Process relationship interpretation  
Network-process correlation  

🔎 SIEM Correlation & Timeline Construction  
Splunk was used to correlate multi-source telemetry and construct a chronological view of the simulated attack.

Actions performed  
Queried authentication events within Splunk to identify network logons  
Queried Sysmon process creation telemetry associated with remote execution  
Queried network connection telemetry for attacker-target communications  
Constructed timeline view combining authentication, process, and network events  

Outcome  
Produced correlated investigation timeline representing simulated lateral movement activity.

Skills practiced  
SIEM correlation  
Timeline-based investigation  
Multi-source telemetry analysis  

🧠 Knowledge Gained  
Conceptual workflow of credential-based lateral movement within enterprise environments  
Importance of authentication telemetry in identifying remote access behavior  
Role of Sysmon in exposing execution context following remote authentication  
Value of correlating authentication, process, and network telemetry for investigation completeness  
Practical SOC workflow for reconstructing attacker activity through timeline analysis  

✅ Day 20 Checklist  
Validated attacker-to-target connectivity and SMB exposure  
Performed remote authentication attempt from Kali attacker VM  
Simulated remote command execution against target endpoint  
Observed authentication artifacts within Windows Security logs  
Observed process and network telemetry within Sysmon logs  
Queried authentication telemetry in Splunk  
Queried process and network telemetry in Splunk  
Constructed correlated investigation timeline within SIEM  
Captured representative screenshots across attack and analysis stages  
Documented lateral movement workflow and observations  

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
