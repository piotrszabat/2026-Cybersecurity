# Detection Coverage Mapping

## Objective

The objective of this document is to map existing homelab detections to the MITRE ATT&CK framework in order to measure current defensive coverage and identify detection gaps.

This exercise helps answer three important blue-team questions:

* What attacker behaviors are currently detectable in the lab?
* Which ATT&CK tactics and techniques are covered by existing detections?
* Which areas require future detection engineering work?

This mapping is based on detections created and tested in a Windows-focused homelab using Wazuh and Splunk, with supporting telemetry from Sysmon and Windows Event Logs.

---

## Environment Context

* **SIEM / Analytics Platform:** Splunk
* **Endpoint Detection / Log Collection:** Wazuh
* **Telemetry Sources:** Sysmon, Windows Event Logs
* **Primary Hosts:** PC01, SRV01, DC01
* **Attacker System Used in Simulations:** KALI01

---

## Why Detection Coverage Mapping Matters

Detection coverage mapping is useful because it turns individual detections into a broader defensive picture.

Instead of only asking whether a single alert works, this process helps answer:

* what the SOC can currently see
* which attacker techniques are being monitored
* where meaningful blind spots still exist

MITRE ATT&CK is designed to organize adversary behavior by tactic and technique, and ATT&CK Navigator is intended to help visualize coverage and related defensive use cases. ([attack.mitre.org][2])

---

## Detection Inventory

The following detections and investigative use cases currently exist in the homelab:

* Multiple Failed Login Attempts
* Credential Attack Detection
* PowerShell Suspicious Network Activity
* Admin Account Creation
* Lateral Movement Detection
* SMB-Based Remote Execution Detection
* WMI / Remote Execution Detection
* IOC / Threat Intelligence Match Detection

These detections were developed through previous lab exercises involving credential abuse, endpoint execution, remote administration activity, and threat hunting.

---

## Detection Mapping Methodology

The mapping process followed a simple workflow:

1. Inventory the detections currently implemented in the lab
2. Review the detection logic or investigation use case
3. Map each item to the closest relevant MITRE ATT&CK technique
4. Group detections by ATT&CK tactic
5. Identify strengths and gaps in current visibility

The goal was not to force every alert into ATT&CK, but to map detections honestly and document where some detections act as enrichment rather than direct behavioral coverage.

---

## ATT&CK Mapping Table

| Detection Name                            | Detection Logic / Focus                                                        | ATT&CK Technique                                                                                | ATT&CK Tactic          | Notes                                                                                                    |
| ----------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------- | ---------------------- | -------------------------------------------------------------------------------------------------------- |
| Multiple Failed Login Attempts            | Repeated failed Windows logons across one or more hosts                        | **T1110 – Brute Force**                                                                         | **Credential Access**  | Covers repeated failed authentication attempts consistent with brute force or password spraying          |
| Credential Attack Detection               | High-volume or patterned authentication failures targeting multiple users      | **T1110 – Brute Force**                                                                         | **Credential Access**  | Strong fit for password spraying and account validation attempts                                         |
| PowerShell Suspicious Network Activity    | Suspicious PowerShell execution, encoded commands, or download behavior        | **T1059.001 – PowerShell**                                                                      | **Execution**          | Focused on suspicious PowerShell behavior on Windows endpoints                                           |
| Admin Account Creation                    | Detection of newly created administrative or suspicious accounts               | **T1136.001 – Create Account: Local Account** or **T1136.002 – Create Account: Domain Account** | **Persistence**        | Mapping depends on whether the simulated account creation was local or domain-based                      |
| Lateral Movement Detection                | Remote execution or service-based movement between hosts                       | **T1021 – Remote Services**                                                                     | **Lateral Movement**   | Covers remote administration and host-to-host movement                                                   |
| SMB-Based Remote Execution Detection      | PsExec-like behavior, admin shares, service creation, remote command execution | **T1021.002 – SMB/Windows Admin Shares**                                                        | **Lateral Movement**   | Best fit when the behavior used SMB admin shares or PsExec-like activity                                 |
| WMI / Remote Execution Detection          | Remote execution through Windows management interfaces or DCOM-style activity  | **T1021.003 – Distributed Component Object Model**                                              | **Lateral Movement**   | Useful when remote execution is performed through WMI/DCOM-related mechanisms                            |
| IOC / Threat Intelligence Match Detection | IP, domain, hash, or other IOC correlation                                     | **Supporting / Enrichment Detection**                                                           | **Contextual Support** | Helpful for prioritization and investigation, but not always a clean one-to-one ATT&CK technique mapping |

---

## ATT&CK Technique Notes

### T1110 — Brute Force

MITRE ATT&CK describes **T1110 Brute Force** as adversaries using brute force techniques to gain access to accounts when passwords are unknown. That makes it a strong mapping for detections based on repeated failed authentication attempts and password spraying patterns. ([attack.mitre.org][1])

### T1059.001 — PowerShell

MITRE ATT&CK identifies **T1059.001 PowerShell** as a sub-technique of Command and Scripting Interpreter and notes that adversaries may abuse PowerShell commands and scripts for execution. This is the best fit for PowerShell-based suspicious command execution in a Windows lab. ([attack.mitre.org][3])

### T1136 — Create Account

MITRE ATT&CK defines **T1136 Create Account** as adversaries creating accounts on a local system, within a domain, or in cloud environments. For this lab, the most relevant mappings are **T1136.001 Local Account** and **T1136.002 Domain Account** depending on the test scenario used. ([attack.mitre.org][4])

### T1021 — Remote Services

MITRE ATT&CK defines **T1021 Remote Services** as a family of techniques related to using remote services to move laterally. This fits detection logic involving remote execution, administrative access paths, and movement across Windows systems. The sub-techniques **T1021.002 SMB/Windows Admin Shares** and **T1021.003 Distributed Component Object Model** are especially relevant for PsExec-like or WMI/DCOM-style activity. ([attack.mitre.org][5])

---

## Coverage Grouped by ATT&CK Tactic

### Credential Access

* **T1110 – Brute Force**

  * Multiple Failed Login Attempts
  * Credential Attack Detection

This is one of the strongest areas of current detection coverage. The lab already includes detection logic for failed login patterns, account targeting, and suspicious authentication behavior.

### Execution

* **T1059.001 – PowerShell**

  * PowerShell Suspicious Network Activity

This is another strong area of visibility because PowerShell execution is both common in real intrusions and highly valuable for Windows-focused monitoring.

### Persistence

* **T1136.001 – Create Account: Local Account**
* **T1136.002 – Create Account: Domain Account**

  * Admin Account Creation

Persistence coverage currently exists, but it is narrow and mainly focused on account creation behavior rather than broader persistence methods.

### Lateral Movement

* **T1021 – Remote Services**

  * Lateral Movement Detection
* **T1021.002 – SMB/Windows Admin Shares**

  * SMB-Based Remote Execution Detection
* **T1021.003 – Distributed Component Object Model**

  * WMI / Remote Execution Detection

Lateral movement is currently one of the best-developed parts of the lab, especially for Windows remote execution techniques.

### Supporting / Enrichment Logic

* IOC / Threat Intelligence Match Detection

This detection logic supports investigations and prioritization, but it should be treated as contextual enrichment rather than a single ATT&CK behavior mapping.

---

## Coverage Summary

### Strongest Current Coverage

The strongest current detection coverage in the lab is:

* **Credential Access**
* **Execution**
* **Lateral Movement**

These are the most mature areas because the lab already includes tested detections for:

* repeated failed authentication attempts
* suspicious PowerShell execution
* remote service usage and lateral movement activity

This gives the homelab a realistic defensive focus around multi-stage Windows intrusion activity.

### Moderate Coverage

* **Persistence**

Persistence is partially covered through account creation detection, but the current coverage is still limited compared to more mature detection programs.

---

## Current Coverage Gaps

The mapping exercise also highlighted several important areas that are not yet strongly covered in the homelab:

* **Privilege Escalation**
* **Defense Evasion**
* **Credential Access beyond failed logons**
* **Discovery**
* **Command and Control**
* **Exfiltration**
* **Impact**
* **Persistence beyond account creation**

These should not be treated as weaknesses in a negative sense. Instead, they represent the next stage of the lab’s detection engineering roadmap.

A realistic detection program is built iteratively, and this mapping helps identify which ATT&CK areas should be prioritized next.

---

## Analyst Assessment

The current detection set provides meaningful visibility into attacker behavior associated with:

* credential abuse
* suspicious command execution
* host-to-host movement in Windows environments

This is a strong foundation for a homelab because these techniques are common in both real-world intrusions and blue-team investigations.

The mapping also shows that current coverage is centered around a specific attack chain, which is actually a strength from a portfolio perspective. It demonstrates focused and validated defensive engineering rather than broad but untested claims.

At the same time, the exercise clearly identifies the next areas for development, especially:

* defense evasion detections
* privilege escalation use cases
* command-and-control behaviors
* exfiltration monitoring

---

## Recommended Next Detection Engineering Priorities

Based on the current gaps, the next high-value detection areas for the lab are:

1. **Defense Evasion**

   * suspicious disabling of logging
   * tampering with security tools
   * encoded or obfuscated execution patterns

2. **Privilege Escalation**

   * abnormal privilege assignments
   * suspicious use of elevated tokens
   * local group membership changes

3. **Discovery**

   * host, account, or network enumeration commands
   * suspicious administrative reconnaissance

4. **Command and Control**

   * unusual outbound connections
   * suspicious PowerShell web requests
   * beaconing-like patterns

5. **Exfiltration**

   * archive creation before transfer
   * suspicious outbound data movement
   * staging directories and compression behavior

---

## Portfolio Value

This document demonstrates more than alert creation. It shows the ability to:

* inventory security detections
* map detection logic to MITRE ATT&CK
* organize coverage by tactic
* assess defensive strengths
* identify realistic detection gaps
* document future engineering priorities

This is valuable for SOC analyst, detection engineering, and blue-team roles because it reflects how detection maturity is measured in real environments.

---

## Outcome

Existing homelab detections were mapped to the MITRE ATT&CK framework in order to measure current defensive coverage and identify missing visibility areas.

The exercise showed the strongest current coverage in:

* Credential Access
* Execution
* Lateral Movement

It also identified future detection opportunities in:

* Defense Evasion
* Privilege Escalation
* Discovery
* Command and Control
* Exfiltration
* Broader Persistence

This mapping provides a portfolio-ready view of current blue-team capability and serves as a practical roadmap for future detection development.

---

## Skills Demonstrated

* Detection engineering
* ATT&CK mapping
* Defensive coverage analysis
* Gap analysis
* Splunk detection documentation
* Wazuh detection review
* Blue-team reporting

---

## GitHub-Ready Summary

Mapped existing Splunk and Wazuh detections to MITRE ATT&CK techniques to measure current defensive coverage, highlight strengths in credential access, PowerShell execution, and lateral movement detection, and identify future detection gaps for continued homelab development.

[1]: https://attack.mitre.org/techniques/T1110 "Brute Force, Technique T1110 - Enterprise"
[2]: https://attack.mitre.org/techniques/enterprise "Enterprise Techniques"
[3]: https://attack.mitre.org/techniques/T1059 "Command and Scripting Interpreter: PowerShell"
[4]: https://attack.mitre.org/techniques/T1136 "Create Account, Technique T1136 - Enterprise"
[5]: https://attack.mitre.org/techniques/T1021 "Remote Services, Technique T1021 - Enterprise"
