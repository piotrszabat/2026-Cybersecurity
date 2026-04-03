# Case 01 — Simulated Internal Intrusion Investigation

## Executive Summary

This case study documents the investigation of a simulated internal intrusion conducted within a homelab environment. The attack scenario involved credential abuse, lateral movement across Windows systems, and PowerShell-based execution.

The investigation leveraged telemetry from Wazuh and analysis performed in Splunk to identify suspicious activity, reconstruct the attack timeline, and evaluate detection capabilities. The results demonstrate how endpoint logs and SIEM correlation can be used to detect and analyze multi-stage attack behavior.

---

## Environment

* **Attacker System:** KALI01
* **Target Systems:** PC01, SRV01
* **Domain Controller:** DC01
* **Detection Stack:** Wazuh + Splunk
* **Telemetry Sources:** Sysmon, Windows Event Logs

---

## Scope

The investigation focused on identifying and analyzing:

* Suspicious authentication activity
* Lateral movement between internal systems
* Endpoint execution activity (primarily PowerShell)

The analysis covered events observed on PC01 and SRV01 during a controlled attack simulation.

---

## Investigation Trigger

The investigation was initiated after identifying:

* Multiple failed authentication attempts
* Suspicious PowerShell execution activity

These events were observed in Splunk during routine review of Wazuh alerts, prompting deeper investigation into potential malicious behavior.

---

## Attack Chain

### 1. Initial Access

The earliest suspicious activity consisted of repeated failed authentication attempts across internal systems.

This behavior is consistent with:

* Password spraying
* SMB-based credential abuse

**Example Splunk Query:**

```spl
index="wazuh-alerts" ("4625" OR "failed" OR "authentication")
| stats count by agent.name src_ip data.win.eventdata.targetUserName
| sort - count
```

**Observations:**

* Multiple login failures across different accounts
* Repeated attempts from a single source system
* Targeting of administrative and standard user accounts

This indicates an attempt to identify valid credentials before further attack stages.

---

### 2. Lateral Movement

Following authentication attempts, telemetry indicated activity consistent with lateral movement.

Indicators included:

* Execution of system-level processes
* Service-related activity
* Cross-host behavior between endpoints

**Example Splunk Query:**

```spl
index="wazuh-alerts" (psexec OR wmiexec OR services.exe OR cmd.exe)
| table _time agent.name rule.description data.win.eventdata.image data.win.eventdata.commandLine
| sort _time
```

**Observations:**

* Execution of administrative tools and system processes
* Activity spanning multiple hosts (PC01 → SRV01)
* Evidence of remote execution techniques

This suggests the attacker successfully leveraged credentials to move laterally within the environment.

---

### 3. Execution

The final phase involved direct command execution on compromised systems, primarily via PowerShell.

**Example Splunk Query:**

```spl
index="wazuh-alerts" (powershell OR pwsh OR "PowerShell")
| table _time agent.name rule.description data.win.eventdata.image data.win.eventdata.commandLine
| sort _time
```

**Observations:**

* PowerShell execution on target systems
* Suspicious or unusual command-line arguments
* Activity occurring after authentication and lateral movement

This phase confirms successful post-authentication execution on endpoints.

---

## Timeline

| Time | Event                                                    |
| ---- | -------------------------------------------------------- |
| T1   | Failed logon attempts detected on PC01                   |
| T2   | Additional failed authentication activity on SRV01       |
| T3   | Suspicious process/service activity observed             |
| T4   | PowerShell execution detected on endpoint                |
| T5   | Splunk detections correlated and investigation completed |

---

## Affected Assets

* PC01
* SRV01

---

## Affected Accounts

* Administrator

---

## Evidence Summary

The investigation was based on the following evidence sources:

* Failed authentication events (Windows Event ID 4625)
* Endpoint process creation logs (Sysmon / Windows logs)
* PowerShell execution telemetry
* Wazuh alerts and rule triggers
* Splunk correlation and timeline searches

---

## MITRE ATT&CK Mapping

The observed activity aligns with the following MITRE ATT&CK techniques:

* **T1110 — Brute Force**
* **T1021 — Remote Services**
* **T1059.001 — PowerShell**
* **T1078 — Valid Accounts**

---

## Detection Coverage

Detection capabilities were provided through:

* Wazuh endpoint monitoring
* Splunk SIEM correlation and analysis

Key detections included:

* Failed authentication attempts
* Suspicious PowerShell execution
* Process and service-related activity

The combination of endpoint telemetry and SIEM analysis allowed for effective reconstruction of the attack chain.

---

## Findings

* The incident began with repeated failed authentication attempts across internal systems.
* Activity was consistent with password spraying or credential abuse.
* Lateral movement was observed through process and service execution across hosts.
* PowerShell activity confirmed post-authentication command execution.
* Wazuh and Splunk together provided sufficient visibility to reconstruct the full attack timeline.

---

## Recommendations

* Enforce stricter account lockout policies
* Limit administrative account usage across endpoints
* Restrict and monitor remote administration mechanisms
* Improve PowerShell logging and alerting
* Continuously tune detection rules for authentication and execution activity
* Conduct regular threat hunting exercises

---

## Lessons Learned

* Authentication logs provide strong early indicators of attack activity
* Endpoint telemetry is critical for understanding attacker behavior
* Timeline reconstruction is essential in multi-stage investigations
* SIEM correlation improves detection but must be supplemented with manual analysis
* Threat hunting methodologies significantly enhance investigation quality

---

## Outcome

A complete investigation case study was developed based on a simulated intrusion scenario. The case demonstrates the ability to:

* Identify suspicious activity
* Analyze endpoint telemetry
* Reconstruct attack timelines
* Map activity to MITRE ATT&CK
* Produce a professional SOC-style incident report

This case study serves as a portfolio artifact showcasing practical incident investigation skills in a controlled homelab environment.
