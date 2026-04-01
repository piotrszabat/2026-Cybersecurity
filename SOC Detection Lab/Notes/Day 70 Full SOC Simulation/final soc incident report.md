# Final SOC Simulation — End-to-End Incident Investigation

## Overview

This project simulates a full attack chain in a segmented SOC homelab environment and demonstrates end-to-end detection, investigation, and reporting using:

* **Suricata (Network IDS)**
* **Wazuh (Endpoint Detection)**
* **Splunk (SIEM)**
* **OpenVAS (VAS01 — Vulnerability Management)**

The goal was to replicate a realistic SOC workflow:

```text
Attack → Detection → Correlation → Investigation → Reporting
```

---

## Lab Architecture

* **Attacker:** KALI01
* **Firewall / IDS:** FW01 (pfSense + Suricata)
* **Corporate Hosts:** DC01, PC01, SRV01
* **SOC Stack:** WAZ01 (Wazuh), SPLK01 (Splunk)
* **Vulnerability Scanner:** VAS01 (OpenVAS)

### Network Segmentation

* **NET-EXT** — attacker network
* **NET-CORP** — internal systems
* **NET-SOC** — monitoring and security tools

---

## Simulated Attack Chain

The following attack scenario was executed:

1. **Reconnaissance**

   * Nmap scanning from external attacker

2. **Initial Access**

   * Password spraying / SMB authentication attempts

3. **Persistence**

   * Local admin account creation

4. **Lateral Movement**

   * Remote execution (PsExec / WMI)

5. **Execution**

   * Suspicious PowerShell commands

6. **Simulated Exfiltration**

   * Outbound PowerShell web requests

---

## Detection Coverage

### Network Layer — Suricata

* Detected scanning activity (Nmap / SYN scans)
* Identified suspicious external source (KALI01)

```spl
index=suricata
| stats count by src_ip, alert.signature
```

---

### Endpoint Layer — Wazuh

Detected multiple attack stages:

* Failed authentication attempts (Event ID 4625)
* Account creation and privilege escalation
* Process and service execution
* PowerShell activity

```spl
index="wazuh-alerts" (4625 OR powershell OR "user created")
```

---

### SIEM Correlation — Splunk

Used to:

* correlate network + endpoint events
* build attack timeline
* identify affected hosts
* validate detections

```spl
index="wazuh-alerts" OR index=suricata
| sort _time
```

---

## Timeline (Simplified)

| Stage        | Description                    |
| ------------ | ------------------------------ |
| Recon        | External scan from KALI01      |
| Access       | Failed logins across hosts     |
| Persistence  | New admin account created      |
| Movement     | Remote execution between hosts |
| Execution    | PowerShell activity detected   |
| Exfiltration | Outbound request simulation    |

---

## Role of VAS01 (OpenVAS)

VAS01 was deployed as part of the SOC network to provide:

* vulnerability scanning of internal systems
* visibility into asset exposure
* support for security posture assessment

While not used for real-time detection, it represents an important **enterprise SOC component**, showing integration of:

```text
Detection + Investigation + Vulnerability Management
```

---

## Key Findings

* Multi-stage attack successfully detected across **network + endpoint layers**
* Clear correlation between reconnaissance → access → execution
* Lateral movement between hosts was visible and traceable
* PowerShell telemetry provided strong insight into attacker activity
* Splunk enabled full timeline reconstruction
* The lab demonstrates realistic SOC visibility across an attack lifecycle

---

## Detection Strengths

* Credential attack detection (failed logins / brute force)
* PowerShell monitoring
* Lateral movement visibility
* Network reconnaissance detection

---

## Identified Gaps

* Limited exfiltration detection depth
* Weak privilege escalation coverage
* Minimal defense evasion detection
* No automated correlation chaining multi-stage attacks

---

## Improvements & Next Steps

* Improve detection for:

  * privilege escalation
  * defense evasion
  * data exfiltration
* Enhance SIEM correlation rules
* Integrate vulnerability data (OpenVAS) into alert prioritization
* Continue full attack simulations for validation

---

## Outcome

This project demonstrates the ability to:

* simulate realistic cyber attacks
* detect activity across multiple layers
* investigate incidents using SIEM
* reconstruct attack timelines
* document findings in a SOC-ready format
* design and operate a segmented enterprise-style lab

---

## Skills Demonstrated

* SOC analysis & incident investigation
* SIEM (Splunk) correlation
* Wazuh (EDR / HIDS) analysis
* Suricata (IDS) monitoring
* Windows security event analysis
* MITRE ATT&CK understanding
* Attack simulation (Kali Linux)
* Network segmentation & architecture
* Vulnerability management (OpenVAS)

---

## Portfolio Summary

Simulated a full attack chain (recon → credential abuse → lateral movement → PowerShell execution → exfiltration) and investigated it using Suricata, Wazuh, and Splunk in a segmented SOC homelab, with additional vulnerability assessment using OpenVAS to represent enterprise-level defensive capabilities.
