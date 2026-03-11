# Day 44 — WAZ01 VM Deployment

## Overview

On Day 44, I deployed **WAZ01**, the Linux server that will host the **Wazuh platform** in my SOC homelab.  
This step followed the architecture planning completed on Day 43.

The goal of this day was to create and prepare the Ubuntu server in the **SOC network**, configure networking, and ensure the system was fully updated before installing Wazuh in the next phase.

---

## Homelab Architecture

Current environment:

```

Internet
│
KALI01
│
NET-EXT
│
FW01 (pfSense + Suricata)
├── NET-CORP
│    ├── DC01
│    ├── PC01
│    └── SRV01
│
└── NET-SOC
├── SPLK01
└── WAZ01

```

WAZ01 is placed in **NET-SOC**, where all security monitoring infrastructure resides.

---

# Deployment Process

## 1. Prepared Ubuntu Server Installation Media

Downloaded and prepared the **Ubuntu Server 22.04 LTS ISO**.

Chosen operating system:

- Ubuntu Server 22.04 LTS  
- Minimal server installation  
- OpenSSH enabled for remote administration

---

## 2. Created the WAZ01 Virtual Machine

A new VM named **WAZ01** was created in the hypervisor with the following configuration:

- **Name:** WAZ01
- **OS:** Ubuntu Server 22.04
- **CPU:** 4 vCPU
- **RAM:** 8 GB
- **Disk:** 60 GB
- **Network:** NET-SOC

This VM will serve as the **central Wazuh platform host**.

---

## 3. Connected WAZ01 to the SOC Network

The network adapter of WAZ01 was connected exclusively to:

```

NET-SOC

````

This ensures proper **network segmentation** between:

- corporate systems (NET-CORP)
- security infrastructure (NET-SOC)
- external attacker network (NET-EXT)

---

## 4. Installed Ubuntu Server 22.04

The system was installed with a minimal server configuration.

System identity:

- **Hostname:** WAZ01
- **Administrative user:** WAZ01

During installation, **OpenSSH Server** was enabled to allow remote management.

---

## 5. Verified Initial System Configuration

After installation, the system was rebooted and initial checks were performed.

Commands used:

```bash
hostname
ip a
````

This confirmed that the system was correctly configured with hostname **WAZ01**.

---

## 6. Configured Static IP Address

A static IP address was configured using **Netplan**.

Example configuration:

```
IP address: 192.168.50.20
Subnet: /24
Gateway: 192.168.50.1
DNS: 192.168.50.1
```

Netplan configuration file:

```
/etc/netplan/00-installer-config.yaml
```

Changes were applied using:

```bash
sudo netplan apply
```

This ensures stable addressing for Wazuh server communication.

---

## 7. Validated Network Connectivity

Connectivity tests were performed to verify proper network placement.

Test commands:

```bash
ping -c 4 192.168.50.1
ping -c 4 8.8.8.8
ping -c 4 google.com
```

Results confirmed:

* connectivity to the SOC gateway
* internet access for package installation
* working DNS resolution

---

## 8. Updated the System

The Ubuntu server was updated to ensure a stable baseline before installing Wazuh.

Commands used:

```bash
sudo apt update
sudo apt upgrade -y
```

Optional administration tools were installed:

```bash
sudo apt install -y curl wget unzip net-tools
```

---

## 9. Final Validation

Final checks confirmed that the system was fully operational.

Commands used:

```bash
hostname
ip a
ip route
ping -c 4 192.168.50.1
```

Validation results:

* VM successfully deployed
* Ubuntu Server installed
* static IP configured
* gateway connectivity confirmed
* system fully updated

---

# Outcome

At the end of Day 44:

* WAZ01 was successfully deployed
* Ubuntu Server 22.04 was installed
* the server was placed in the **SOC network**
* static IP configuration was applied
* system connectivity was validated
* the system was updated and ready for Wazuh installation

This prepares the environment for the next step:

**Day 45 — Install Wazuh Platform**

---

# Skills Demonstrated

* Linux server deployment
* Ubuntu Server installation
* virtual machine provisioning
* network segmentation alignment
* static IP configuration with Netplan
* system administration and updates

---

# GitHub Summary

```
Deployed WAZ01 as an Ubuntu Server 22.04 VM in the SOC network, configured static networking using Netplan, validated connectivity, and prepared the system for Wazuh platform installation.
