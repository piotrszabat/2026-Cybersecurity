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
- **NET-INT** — internal network
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

```text
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
