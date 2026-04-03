# Day 59 — Deploying a Vulnerability Scanner (Greenbone / OpenVAS)

## Overview

Day 59 marks a major milestone in the homelab progression — transitioning from **security monitoring and detection** into **vulnerability management**.

Up to this point, the lab focused on:

```

logs → detections → hunting → investigations

```

With the addition of a vulnerability scanner, the lab now includes:

```

exposure assessment → vulnerability discovery → remediation visibility

```

This expands the lab into a more complete **blue team and security operations environment**, enabling proactive identification of weaknesses before exploitation.

---

## Objective

The goal of this day was to:

- Deploy a dedicated vulnerability scanner VM
- Install Greenbone / OpenVAS Community Edition
- Ensure all services are operational
- Validate access to the web interface
- Prepare internal targets for future scans

---

## Lab Architecture Update

A new system was added to the SOC network:

```

NET-SOC
├─ WAZ01
├─ SPLK01
└─ VAS01  ← Vulnerability Scanner

````

This keeps vulnerability management aligned with monitoring infrastructure and reflects a realistic enterprise SOC design.

---

## VM Deployment

A new virtual machine was created:

- **Hostname:** VAS01
- **OS:** Ubuntu 24.04 LTS
- **CPU:** 4 vCPU
- **RAM:** 8 GB
- **Disk:** 60 GB
- **Network:** NET-SOC
- **IP Address:** Static (SOC range)

This configuration aligns with recommended requirements for Greenbone Community Edition.

---

## Installation Approach

Greenbone Community Edition was deployed using the **container-based (Docker) installation method**, which provides:

- Modular architecture
- Easier service management
- Closer alignment with modern production environments

---

## System Preparation

The system was prepared with required dependencies:

- `ca-certificates`
- `curl`
- `gnupg`

Docker and Docker Compose were installed and verified:

```bash
docker --version
docker compose version
````

The user was added to the Docker group to enable container management.

---

## Deployment Process

A dedicated working directory was created:

```bash
~/greenbone-community-container
```

The Greenbone Community Edition container configuration was downloaded and deployed using:

```bash
docker compose up -d
```

All required services were successfully started, including:

* gsad (web interface)
* gvmd (manager)
* openvas (scanner)
* ospd-openvas
* redis

---

## Validation and Troubleshooting

During initial deployment:

* The VM experienced performance issues due to high resource usage during feed synchronization
* A temporary UI error occurred due to frontend instability after a VM freeze

Resolution steps included:

* Restarting Docker containers
* Clearing browser cache
* Allowing full feed synchronization to complete

---

## Feed Synchronization

The vulnerability feeds (NVT, SCAP, CERT, GVMD_DATA) were initialized and synchronized.

Final validation confirmed:

* All feeds marked as **Current**
* No ongoing updates
* Scanner fully operational

---

## Web Interface Access

The Greenbone Security Assistant (web UI) was successfully accessed via:

```
https://<VAS01-IP>
```

Administrative login was verified, confirming full platform readiness.

---

## Internal Target Preparation

To prepare for Day 60, internal scan targets were documented:

### DC01

* Hostname: DC01
* IP Address: 192.168.10.10
* Operating System: Windows Server 2022
* Role: Domain Controller

### PC01

* Hostname: PC01
* IP Address: 192.168.10.20
* Operating System: Windows 11
* Role: Workstation

### SRV01

* Hostname: SRV01
* IP Address: 192.168.10.30
* Operating System: Windows Server 2022
* Role: Internal Application Server

This step establishes a basic **asset inventory**, which is a critical prerequisite for vulnerability management.

---

## Outcome

By the end of Day 59:

* A dedicated vulnerability scanner VM was deployed
* Greenbone / OpenVAS was successfully installed and configured
* All scanner services were operational
* Vulnerability feeds were fully synchronized
* Web interface access was validated
* Internal targets were prepared for scanning

---

## Skills Demonstrated

* Vulnerability management deployment
* Greenbone / OpenVAS installation (Docker-based)
* Ubuntu server configuration
* Container-based security tooling
* Troubleshooting service and UI issues
* Feed synchronization validation
* Asset inventory preparation
* SOC architecture expansion

---

## Key Takeaway

Day 59 transforms the lab from a **reactive security environment** into a **proactive one**.

Before:

```
Detecting and investigating threats
```

After:

```
Identifying vulnerabilities before exploitation
```

This significantly increases the realism and completeness of the homelab.

Internal Scan Targets

 DC01
- Hostname: DC01
- IP Address: 192.168.10.10
- Operating System: Windows Server 2022
- Role: Domain Controller

PC01
- Hostname: PC01
- IP Address: 192.168.10.20
- Operating System: Windows 11
- Role: Workstation

SRV01
- Hostname: SRV01
- IP Address: 192.168.10.30
- Operating System: Windows Server 2022
- Role: Internal Application Server