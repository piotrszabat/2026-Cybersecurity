# SOC Detection Lab

Enterprise-style SOC homelab built to simulate a realistic blue team and detection engineering environment.

## Project Overview

This homelab was created to develop practical skills for a SOC Analyst / Security Engineer path through hands-on work in:

- Active Directory administration
- Windows endpoint telemetry
- SIEM engineering and log analysis
- IDS monitoring and network investigation
- Detection engineering
- Threat hunting
- Incident response
- Security architecture documentation

The lab evolved from a flat internal network into a segmented enterprise-style environment with dedicated corporate, perimeter, and SOC monitoring zones.

## Lab Goals

The main goals of this project are:

- build a realistic SOC environment
- collect and analyze endpoint and network telemetry
- create and tune detections in Splunk, Wazuh, and Suricata
- investigate simulated attacks
- document architecture, detections, hunts, and response workflows
- create a portfolio of practical blue team work

## Final Lab Architecture

### Core Systems

- **FW01** — pfSense firewall and network perimeter
- **DC01** — Windows Server 2022 domain controller
- **PC01** — Windows 11 workstation
- **KALI01** — attacker simulation box
- **SPLK01** — Splunk SIEM
- **WAZ01** — Wazuh detection platform
- **VAS01** — OpenVAS / Greenbone vulnerability scanner

### Network Segments

- **NET-EXT** — external / attacker zone
- **NET-CORP** — corporate network
- **NET-SOC** — monitoring and security tooling network

### Security Tooling

- **pfSense** for firewalling and segmentation
- **Suricata** for IDS monitoring
- **Splunk** for SIEM ingestion, dashboards, and correlation
- **Wazuh** for endpoint monitoring and detections
- **Sysmon** for Windows telemetry
- **Wireshark** for packet inspection
- **OpenVAS** for vulnerability management

## Architecture Evolution

This lab was built in stages:

1. Base virtual environment setup
2. Active Directory and Windows administration fundamentals
3. Telemetry and visibility setup
4. Initial detection engineering in Splunk
5. Network investigation and IDS exposure
6. Enterprise architecture redesign with segmented networks
7. Perimeter monitoring with pfSense and Suricata
8. Endpoint detection with Wazuh
9. SIEM correlation and dashboards
10. Threat hunting, case studies, and SOC workflows

## Repository Structure

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

Folder Description
Architecture/
Network diagrams, IP plans, segmentation, and architecture documentation.
Assets/
Screenshots, diagrams, dashboards, and supporting images used across the repository.
Case Studies/
Detailed investigations of attack simulations and incident response exercises.
Detections/
Detection logic, correlation rules, rule tuning, MITRE mapping, and dashboard notes across Splunk, Wazuh, and Suricata.
Docs/
Lab setup documentation, telemetry pipeline notes, integrations, and implementation details.
Playbooks/
SOC workflows such as triage, incident response, and operational procedures.
Threat Hunting/
Hypothesis-driven hunts, IOC searches, and endpoint/network hunting investigations.
Tools/
Helper scripts, validation utilities, and reusable lab commands.
Implemented Capabilities
Endpoint Telemetry
Windows Event Log collection
Sysmon deployment and monitoring
Wazuh agent deployment
File integrity monitoring
PowerShell and process execution visibility
SIEM and Detection Engineering
Splunk log ingestion from Windows and security tools
Correlation rules for authentication, PowerShell, and account creation
Detection tuning and validation
Dashboard creation for alerts and endpoint monitoring
MITRE ATT&CK mapping
Network Visibility
Suricata IDS deployment
pfSense perimeter monitoring
Wireshark packet analysis
PCAP investigation
DNS tunneling awareness testing
Nmap and reconnaissance simulation
Security Operations
Alert triage workflow
Incident investigation timeline building
Ransomware simulation
Threat intelligence integration
IOC hunting
Vulnerability scanning with OpenVAS
Example Detection Areas

This project currently includes work in the following detection areas:

failed login detection
brute force detection
admin account creation detection
suspicious PowerShell execution
suspicious process execution
lateral movement activity
credential attack detection
Suricata alert analysis
Wazuh custom rule development
endpoint and SIEM correlation logic
Example Case Studies

The lab includes practical security investigations such as:

external reconnaissance from Kali against perimeter systems
PCAP investigation and network analysis
credential attack simulation
lateral movement investigation
ransomware simulation
incident response reporting
Key Learning Outcomes

Through this project I developed hands-on experience in:

designing and documenting a segmented SOC lab
deploying and integrating blue team tooling
building detections from real telemetry
correlating logs across multiple sources
investigating attacks from initial access through execution
turning lab exercises into portfolio-ready documentation
Current Status

Completed through Day 66 of the SOC homelab roadmap.

Major completed milestones include:

base AD and Windows lab setup
telemetry and visibility implementation
initial Splunk detections
network attack investigation labs
enterprise architecture redesign
pfSense and Suricata integration
Wazuh deployment and endpoint monitoring
SIEM dashboards and correlation
SOC playbooks and portfolio documentation
Planned Next Steps

Planned future improvements include:
- deeper detection engineering workflows
- additional Sigma-style rule standardization
- extended threat hunting content
- Linux telemetry coverage
- phishing / email-based detections
- cloud security and Microsoft Sentinel integration
- 
Screenshots and Diagrams
Repository screenshots and diagrams are stored in the Assets/ directory and referenced throughout the documentation.

Disclaimer
This lab is intended for educational purposes only.
All attack simulations and detection tests were performed in an isolated personal lab environment.

Author
Built and documented by Piotr Szabat as part of a long-term SOC Analyst / Security Engineer portfolio project.
