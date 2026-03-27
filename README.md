# SOC Detection Lab

Enterprise-style SOC homelab designed to simulate a realistic **Blue Team** and **Detection Engineering** environment.

---

## 📌 Project Overview

This homelab was created to develop practical skills for a **SOC Analyst / Security Engineer** career path through hands-on experience in:

* Active Directory administration
* Windows endpoint telemetry
* SIEM engineering and log analysis
* IDS monitoring and network investigation
* Detection engineering
* Threat hunting
* Incident response
* Security architecture documentation

The lab evolved from a flat internal network into a **segmented, enterprise-style environment** with dedicated:

* Corporate network
* Perimeter network
* SOC monitoring zone

---

## 🎯 Lab Goals

The main objectives of this project are:

* Build a realistic SOC environment
* Collect and analyze endpoint and network telemetry
* Create and tune detections in **Splunk**, **Wazuh**, and **Suricata**
* Investigate simulated attacks
* Document architecture, detections, hunting activities, and response workflows
* Build a portfolio of practical Blue Team work

---

## 🏗️ Final Lab Architecture

### 🔧 Core Systems

* **FW01** — pfSense firewall (network perimeter)
* **DC01** — Windows Server 2022 domain controller
* **PC01** — Windows 11 workstation
* **KALI01** — attacker simulation machine
* **SPLK01** — Splunk SIEM
* **WAZ01** — Wazuh detection platform
* **VAS01** — OpenVAS / Greenbone vulnerability scanner

---

### 🌐 Network Segments

* **NET-EXT** — External / attacker network
* **NET-CORP** — Corporate network
* **NET-SOC** — Monitoring and security tooling network

---

### 🛡️ Security Tooling

* **pfSense** — firewalling and segmentation
* **Suricata** — IDS monitoring
* **Splunk** — SIEM ingestion, dashboards, and correlation
* **Wazuh** — endpoint monitoring and detection
* **Sysmon** — Windows telemetry collection
* **Wireshark** — packet inspection
* **OpenVAS** — vulnerability management

---

## 🔄 Architecture Evolution

This lab was built in structured stages:

1. Base virtual environment setup
2. Active Directory and Windows fundamentals
3. Telemetry and visibility implementation
4. Initial detection engineering in Splunk
5. Network investigation and IDS exposure
6. Enterprise architecture redesign (segmentation)
7. Perimeter monitoring with pfSense and Suricata
8. Endpoint detection with Wazuh
9. SIEM correlation and dashboards
10. Threat hunting, case studies, and SOC workflows

---

## 📁 Repository Structure

```
SOC-Detection-Lab/
├── Architecture/
├── Assets/
├── Case Studies/
├── Detections/
├── Docs/
├── Playbooks/
├── Threat Hunting/
├── Tools/
└── README.md
```

### 📂 Folder Description

* **Architecture/**
  Network diagrams, IP addressing plans, segmentation, and architecture documentation

* **Assets/**
  Screenshots, diagrams, dashboards, and visual materials

* **Case Studies/**
  Detailed investigations of simulated attacks and incident response scenarios

* **Detections/**
  Detection logic, correlation rules, tuning, MITRE ATT&CK mapping, and dashboards

* **Docs/**
  Lab setup, telemetry pipelines, integrations, and implementation details

* **Playbooks/**
  SOC workflows: triage, incident response, and operational procedures

* **Threat Hunting/**
  Hypothesis-driven hunts, IOC searches, and investigation reports

* **Tools/**
  Helper scripts, utilities, and reusable lab commands

---

## ⚙️ Implemented Capabilities

### 🖥️ Endpoint Telemetry

* Windows Event Log collection
* Sysmon deployment and monitoring
* Wazuh agent deployment
* File integrity monitoring
* PowerShell and process execution visibility

---

### 📊 SIEM & Detection Engineering

* Splunk log ingestion (Windows + security tools)
* Correlation rules for:

  * Authentication events
  * PowerShell activity
  * Account creation
* Detection tuning and validation
* Dashboard creation (alerts + monitoring)
* MITRE ATT&CK mapping

---

### 🌐 Network Visibility

* Suricata IDS deployment
* pfSense perimeter monitoring
* Wireshark packet analysis
* PCAP investigation
* DNS tunneling detection testing
* Nmap reconnaissance simulation

---

### 🚨 Security Operations

* Alert triage workflows
* Incident timeline reconstruction
* Ransomware simulation
* Threat intelligence integration
* IOC-based hunting
* Vulnerability scanning (OpenVAS)

---

## 🔍 Example Detection Areas

This project includes detection logic for:

* Failed login attempts
* Brute-force activity
* Admin account creation
* Suspicious PowerShell execution
* Suspicious process execution
* Lateral movement
* Credential-based attacks
* Suricata alert analysis
* Wazuh custom rule development
* Endpoint and SIEM correlation

---

## 🧪 Example Case Studies

* External reconnaissance from Kali against perimeter systems
* PCAP analysis and network investigation
* Credential attack simulation
* Lateral movement analysis
* Ransomware simulation
* Incident response reporting

---

## 🧠 Key Learning Outcomes

Through this project, I gained hands-on experience in:

* Designing and documenting a segmented SOC environment
* Deploying and integrating Blue Team tooling
* Building detections from real telemetry
* Correlating logs across multiple sources
* Investigating attacks from initial access to execution
* Creating portfolio-ready security documentation

---

## 📈 Current Status

✅ Completed through **Day 66** of the SOC homelab roadmap

### ✔️ Major Milestones

* Active Directory and Windows lab setup
* Telemetry and visibility implementation
* Initial Splunk detections
* Network attack investigation labs
* Enterprise architecture redesign
* pfSense and Suricata integration
* Wazuh deployment and monitoring
* SIEM dashboards and correlation
* SOC playbooks and documentation

---

## 🚀 Planned Next Steps

* Advanced detection engineering workflows
* Sigma-style rule standardization
* Expanded threat hunting scenarios
* Linux telemetry integration
* Phishing and email-based detections
* Cloud security (Microsoft Sentinel) integration

---

## 🖼️ Screenshots & Diagrams

All screenshots and diagrams are stored in the **Assets/** directory and referenced throughout the documentation.

---

## ⚠️ Disclaimer

This lab is intended for **educational purposes only**.
All attack simulations were performed in a fully isolated lab environment.

---

## 👤 Author

**Piotr Szabat**
SOC Detection Lab — Blue Team Portfolio Project
