# Detection Gap Analysis

## Objective

The purpose of this document is to evaluate current detection coverage across the homelab environment using Splunk, Wazuh, and Suricata. The analysis focuses on identifying which attacker behaviors are currently detectable, how detections map to MITRE ATT&CK, and where coverage gaps exist.

This document reflects a detection engineering perspective, focusing not only on the existence of alerts, but also on detection quality, coverage depth, and future improvement priorities.

---

## Environment Context

The homelab is designed as a segmented SOC environment with the following components:

* **KALI01** — attacker simulation system
* **FW01** — pfSense firewall with Suricata IDS
* **DC01, PC01, SRV01** — corporate Windows systems
* **WAZ01** — Wazuh endpoint detection platform
* **SPLK01** — Splunk SIEM
* **VAS01** — OpenVAS vulnerability scanner

### Security Stack

* **Suricata** → network detection
* **Wazuh** → endpoint detection
* **Splunk** → correlation and investigation
* **OpenVAS** → vulnerability visibility (supporting context)

---

## Detection Sources

Detection capabilities in this lab are based on:

* Splunk correlation searches and alerts
* Wazuh default and custom rules (Sysmon, Windows logs, FIM)
* Suricata IDS alerts (network-level visibility)
* Previous attack simulations and investigation workflows

---

## Detection Inventory

The following detections are currently implemented in the lab:

| Detection Name                               | Platform | Category            | Description                                                        | ATT&CK Technique | Status | Notes                           |
| -------------------------------------------- | -------- | ------------------- | ------------------------------------------------------------------ | ---------------- | ------ | ------------------------------- |
| Multiple Failed Login Attempts               | Splunk   | Authentication      | Detects repeated failed authentication attempts                    | T1110            | Active | Core credential abuse detection |
| Multiple Failed Login Attempts 1             | Splunk   | Authentication      | Variation of failed login detection (possibly different threshold) | T1110            | Active | Needs tuning review             |
| Admin Account Creation                       | Splunk   | Persistence         | Detects new account creation activity                              | T1136            | Active | High confidence signal          |
| PowerShell Suspicious Network Activity       | Splunk   | Process Execution   | Detects PowerShell with network activity                           | T1059.001        | Active | Strong detection                |
| Threat Intel Matched Authentication Activity | Splunk   | Authentication / TI | Matches authentication events with threat intel                    | Contextual       | Active | Enrichment-based detection      |

### Wazuh Coverage (Observed from Dashboard)

Based on Wazuh telemetry and dashboards:

* Sysmon process activity
* Windows security events
* File integrity monitoring (FIM)
* Failed authentication attempts
* Suspicious process execution

### Suricata Coverage

* Network scanning detection (Nmap / SYN scans)
* Suspicious traffic signatures
* External reconnaissance visibility

---

## Detection Categories

### Authentication

Strong baseline coverage for authentication-based attacks.

Includes:

* Multiple Failed Login Attempts
* Credential Attack Detection (Splunk + Wazuh)
* Threat Intel Matched Authentication Activity

Assessment:
Authentication is one of the strongest areas in the lab.

---

### Process Execution

Covers endpoint execution, especially PowerShell activity.

Includes:

* PowerShell Suspicious Network Activity
* Sysmon-based process visibility (Wazuh)

Assessment:
PowerShell detection is one of the most mature and validated detections.

---

### Network

Provides visibility into external activity and reconnaissance.

Includes:

* Suricata scan detection
* Network-based alerts
* IOC matching (Splunk)

Assessment:
Good visibility for obvious recon, weaker for stealth traffic.

---

### Persistence

Focused mainly on account creation and system changes.

Includes:

* Admin Account Creation
* File Integrity Monitoring (Wazuh)

Assessment:
Moderate coverage — needs expansion beyond account-based persistence.

---

### Lateral Movement

Detected indirectly via:

* process execution
* service activity
* authentication patterns

Assessment:
Present but should be strengthened with more explicit detections.

---

## MITRE ATT&CK Mapping

| Detection                                    | Platform | Category       | ATT&CK Technique        | Notes                            |
| -------------------------------------------- | -------- | -------------- | ----------------------- | -------------------------------- |
| Multiple Failed Login Attempts               | Splunk   | Authentication | T1110 – Brute Force     | Detects password spraying        |
| Admin Account Creation                       | Splunk   | Persistence    | T1136 – Create Account  | Detects persistence via accounts |
| PowerShell Suspicious Network Activity       | Splunk   | Execution      | T1059.001 – PowerShell  | Strong execution visibility      |
| Threat Intel Matched Authentication Activity | Splunk   | Authentication | Contextual              | Enrichment detection             |
| Suricata Scan Detection                      | Suricata | Network        | T1595 – Active Scanning | Detects recon activity           |

---

## Coverage Table

| Category          | Detection                                    | Platform | Coverage Quality | Notes                       |
| ----------------- | -------------------------------------------- | -------- | ---------------- | --------------------------- |
| Authentication    | Multiple Failed Login Attempts               | Splunk   | Medium           | Needs tuning for thresholds |
| Authentication    | Threat Intel Matched Authentication Activity | Splunk   | Low / Contextual | Useful but not behavioral   |
| Process Execution | PowerShell Suspicious Network Activity       | Splunk   | High             | Strong detection            |
| Persistence       | Admin Account Creation                       | Splunk   | High             | Reliable detection          |
| Network           | Suricata Scan Detection                      | Suricata | Medium           | Good for recon              |
| Endpoint          | Wazuh Process & Sysmon Data                  | Wazuh    | High             | Strong telemetry            |

---

## Detection Strengths

The strongest detection areas are:

* authentication attack detection
* PowerShell execution monitoring
* account creation detection
* endpoint telemetry via Wazuh
* basic network reconnaissance detection

These detections were validated through attack simulations and investigation exercises.

---

## Missing Coverage

The following areas are currently weak or missing:

* credential dumping
* scheduled task persistence
* registry persistence
* defense evasion techniques
* living-off-the-land binaries (LOLBins)
* privilege escalation detection
* data staging before exfiltration
* command and control behavior

---

## Priority Areas

### Priority 1 — High Value

* credential dumping detection
* LOLBins detection
* scheduled task detection

### Priority 2 — Medium

* registry persistence
* service tampering
* privilege escalation monitoring

### Priority 3 — Advanced

* stealthy C2 detection
* defense evasion chaining
* SIEM correlation improvements

---

## Detection Quality Review

Detection quality varies across the environment:

* Failed login detection is useful but requires tuning
* PowerShell detection is strong and validated
* Suricata provides good visibility but limited for stealth attacks
* Threat intel detection is useful for enrichment, not primary detection

---

## OpenVAS Context

OpenVAS (VAS01) provides:

* vulnerability visibility
* asset exposure awareness
* support for prioritizing detections

It is not a behavioral detection tool, but strengthens the overall security architecture.

---

## Outcome

The current lab provides strong baseline detection coverage for:

* authentication attacks
* PowerShell execution
* account creation
* network reconnaissance

The gap analysis highlights the need to expand detection into post-compromise and stealth-based attacker techniques.

---

## Skills Demonstrated

* detection engineering mindset
* MITRE ATT&CK mapping
* SIEM analysis (Splunk)
* endpoint detection (Wazuh)
* network detection (Suricata)
* gap analysis and prioritization
* SOC-level security evaluation

---

## GitHub-Ready Summary

Performed a detection gap analysis across Splunk, Wazuh, and Suricata by inventorying detections, mapping them to MITRE ATT&CK, evaluating coverage quality, identifying missing techniques, and defining future detection engineering priorities.
