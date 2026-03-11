# Day 43 — Wazuh Architecture Planning

## Overview

On Day 43, I planned the integration of **Wazuh** into my SOC homelab.  
The goal of this phase was not installation yet, but to design how Wazuh would fit into my existing enterprise-style lab architecture.

At this stage, my homelab already included:

- **PC01** – Windows 11 endpoint
- **DC01** – Windows Server 2022 domain controller
- **SRV01** – Windows Server for services/testing
- **KALI01** – attacker machine
- **FW01** – pfSense firewall with Suricata
- **SPLK01** – Splunk SIEM

Current network layout:

- **WAN**
- **EXT**
- **INT**
- **SOC**

The objective for Day 43 was to define where **WAZ01** should be placed, how endpoint telemetry would flow, which hosts would receive Wazuh agents, and what firewall connectivity would be required before deployment.

---

## Goal of the Day

The goal of Day 43 was to design the future Wazuh deployment in a clean and scalable way.

Planned telemetry pipeline:

```text
Windows endpoints → Wazuh → Splunk
````

Main tasks for the day:

* update the architecture design
* define the role of Wazuh in the lab
* decide where WAZ01 should be placed
* plan IP addressing
* identify agent coverage
* define telemetry flow
* document connectivity requirements

---

## Objective

Wazuh will provide **endpoint detection and telemetry collection** for Windows systems in the internal network, while **Splunk** will remain the central SIEM used for broader monitoring, correlation, dashboards, and investigations.

This creates a layered security monitoring model:

* **pfSense + Suricata** = network monitoring and IDS
* **Wazuh** = endpoint detection and host telemetry
* **Splunk** = centralized SIEM and correlation

---

## Architecture Decision

I decided to deploy a dedicated Wazuh server named **WAZ01** inside the **SOC network**.

### Why WAZ01 belongs in SOC

WAZ01 is part of the monitoring and security operations stack, not a regular corporate workload.
Placing it in the SOC segment keeps the architecture more realistic and better aligned with enterprise design principles.

This results in a clearer separation of roles:

* **EXT** = external / attacker simulation
* **INT** = corporate assets
* **SOC** = security monitoring infrastructure

---

## Planned Wazuh Deployment Model

For this homelab, I selected a **single-node / all-in-one Wazuh deployment**.

This means WAZ01 will host:

* **Wazuh server**
* **Wazuh indexer**
* **Wazuh dashboard**

### Reason for this choice

A single-node design is the best fit for this lab because:

* the environment is relatively small
* the number of monitored endpoints is low
* deployment is simpler
* administration is easier
* it is a practical model for a home SOC lab

---

## Planned WAZ01 VM Configuration

The future WAZ01 server will be deployed with the following specifications:

* **Hostname:** WAZ01
* **Operating System:** Ubuntu Server 22.04
* **CPU:** 4 vCPU
* **RAM:** 8 GB
* **Disk:** 60 GB
* **Network:** SOC

This configuration should be sufficient for a small Wazuh deployment supporting several Windows agents.

---

## Network Placement

WAZ01 will be placed in the **SOC** network together with existing security infrastructure.

### Planned SOC addressing

* **FW01 SOC interface:** 192.168.50.1
* **SPLK01:** 192.168.50.10
* **WAZ01:** 192.168.50.20

### Corporate systems

* **DC01:** 192.168.10.10
* **PC01:** 192.168.10.20
* **SRV01:** 192.168.10.30

This addressing plan keeps security infrastructure and monitored business systems clearly separated.

---

## Endpoint Coverage

I decided that Wazuh agents will be deployed on the following Windows systems:

* **DC01**
* **PC01**
* **SRV01**

These systems will provide host-level telemetry into Wazuh and later into Splunk.

### Why these endpoints

* **DC01** is the most critical identity and authentication system
* **PC01** represents a user workstation
* **SRV01** provides additional server-side telemetry and detection opportunities

This gives the lab better visibility across different host roles.

---

## Telemetry Flow

The planned telemetry path is:

```text
DC01 / PC01 / SRV01
   ↓
Wazuh agent
   ↓
WAZ01 (Wazuh server)
   ↓
Wazuh dashboard / alerts
   ↓
Splunk integration
```

Simplified pipeline:

```text
Windows endpoints → Wazuh agents → WAZ01 → Wazuh alerts/events → Splunk
```

### Planned data sources

Wazuh will later collect endpoint telemetry such as:

* Windows Security logs
* Sysmon events
* PowerShell activity
* process creation events
* file integrity monitoring events
* registry-related changes

This will improve host visibility and support detection engineering and threat hunting in later lab phases.

---

## Connectivity Requirements

Because the monitored Windows systems are in the **INT** network and WAZ01 will be in the **SOC** network, endpoint traffic must pass through **FW01**.

Planned required access from corporate endpoints to WAZ01:

* **TCP 1514** – agent communication
* **TCP 1515** – agent enrollment
* **TCP 55000** – Wazuh API / management-related communication

### Firewall principle

Only the required Wazuh communication ports should be allowed from internal endpoints to WAZ01.
This keeps the segmentation model clean and reduces unnecessary exposure between network zones.

---

## Updated Target Architecture

The intended architecture after Wazuh integration is:

```text
Internet
   │
KALI01
   │
EXT
   │
FW01 (pfSense + Suricata)
   │
INT
   ├─ DC01
   ├─ PC01
   ├─ SRV01
   │
SOC
   ├─ SPLK01
   └─ WAZ01
```

Telemetry relationships:

```text
DC01 / PC01 / SRV01 → WAZ01
WAZ01 → Splunk
FW01 / Suricata → Splunk
```

This creates a layered SOC monitoring model with both **network telemetry** and **endpoint telemetry** feeding into the broader monitoring environment.

---

## What I Completed on Day 43

During Day 43, I completed the following planning tasks step by step:

### 1. Defined the role of Wazuh in the homelab

I documented Wazuh as the endpoint detection and telemetry platform for Windows systems.

### 2. Decided where WAZ01 should be deployed

I placed WAZ01 in the **SOC** network instead of the internal corporate network.

### 3. Selected the deployment model

I chose a **single-node Wazuh architecture** for simplicity and suitability to lab scale.

### 4. Planned VM specifications

I documented the hardware and operating system requirements for WAZ01.

### 5. Planned IP addressing

I assigned a future static IP address to WAZ01 and aligned it with the existing SOC subnet plan.

### 6. Defined endpoint coverage

I selected **DC01**, **PC01**, and **SRV01** as the initial Wazuh-monitored systems.

### 7. Mapped telemetry flow

I documented how endpoint logs will travel from Windows hosts into Wazuh and later into Splunk.

### 8. Documented firewall requirements

I identified the communication ports that must be allowed through FW01 between the INT and SOC networks.

### 9. Clarified monitoring roles

I defined the role split between Suricata, Wazuh, and Splunk.

### 10. Prepared for Day 44 deployment

I completed the design work needed before creating the WAZ01 VM and starting installation.

---

## Key Design Outcome

The key result of Day 43 is that Wazuh is now fully planned as an **endpoint security platform** inside the SOC segment of the lab.

This design keeps the lab:

* segmented
* realistic
* scalable
* easier to manage
* stronger for portfolio presentation

It also prepares the environment for the next implementation steps:

* **Day 44:** deploy WAZ01 VM
* **Day 45:** install Wazuh platform
* **Day 46:** deploy Wazuh agents to endpoints

---

## GitHub Portfolio Summary

Planned the Wazuh integration into the SOC homelab by defining a dedicated WAZ01 server in the SOC network, selecting a single-node deployment model, identifying Windows endpoints for agent coverage, documenting required firewall connectivity, and mapping the telemetry flow from endpoints to Wazuh and Splunk.

