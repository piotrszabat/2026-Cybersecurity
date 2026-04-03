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


# Wazuh Platform Installation (Day 45)

## Objective

The objective of this lab was to deploy the **Wazuh all-in-one security platform** on the **WAZ01 Ubuntu server** and verify that the Wazuh dashboard is accessible via HTTPS.

The Wazuh platform provides:

* Endpoint Detection and Response (EDR)
* Security monitoring
* Log collection and analysis
* Threat detection

This installation prepares the environment for **endpoint monitoring in the next lab stages**.

---

# Lab Environment

The lab network is segmented into multiple zones to simulate a realistic enterprise infrastructure.

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

The **WAZ01 server is located in the NET-SOC network**, which hosts security monitoring infrastructure.

---

# Step 1 — Verify Server Configuration

Before installing the platform, the server configuration was verified.

Commands used:

```bash
hostname
ip a
ip route
```

These checks confirmed:

* Hostname was set correctly to **WAZ01**
* The server had a valid **SOC network IP address**
* A default gateway was configured

Network connectivity was tested using:

```bash
ping -c 4 192.168.50.1
ping -c 4 8.8.8.8
ping -c 4 google.com
```

Successful responses confirmed that the server had **internet access required for downloading packages**.

---

# Step 2 — Update the System

The operating system packages were updated to ensure a clean installation environment.

```bash
sudo apt update
sudo apt upgrade -y
```

Additional required tools were installed:

```bash
sudo apt install curl tar -y
```

These utilities are required for downloading the installer and extracting credential files generated during the installation.

---

# Step 3 — Download the Wazuh Installation Script

The Wazuh installation assistant was downloaded from the official Wazuh package repository.

```bash
curl -O https://packages.wazuh.com/4.14/wazuh-install.sh
```

The downloaded file was verified:

```bash
ls -l wazuh-install.sh
```

This script automates the installation of the Wazuh platform components.

---

# Step 4 — Install the Wazuh Platform

The all-in-one installation mode was executed using the following command:

```bash
sudo bash ./wazuh-install.sh -a
```

This deployment installs the following components on a single server:

* **Wazuh Manager**
* **Wazuh Indexer**
* **Wazuh Dashboard**
* **Filebeat**

During the installation process the script:

* Configured system services
* Generated security certificates
* Created authentication credentials
* Installed required dependencies

The installation process took several minutes to complete.

---

# Step 5 — Capture Installation Credentials

After the installation finished, the script displayed the credentials required to access the Wazuh dashboard.

Important information captured:

```
Dashboard URL
Username
Generated password
```

For security reasons, credentials were **redacted in screenshots before publishing to GitHub**.

---

# Step 6 — Retrieve Stored Credentials

The installation script stores generated credentials inside an archive file.

To retrieve the credentials later, the following command was executed:

```bash
sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
```

This file contains:

* dashboard administrator credentials
* internal service credentials

---

# Step 7 — Verify Installed Services

After installation, the main Wazuh services were verified.

Commands used:

```bash
sudo systemctl status wazuh-manager
sudo systemctl status wazuh-dashboard
sudo systemctl status wazuh-indexer
sudo systemctl status filebeat
```

All services were confirmed to be **running successfully**.

An additional service check was performed:

```bash
sudo systemctl --type=service | grep -E 'wazuh|filebeat'
```

---

# Step 8 — Verify Local Dashboard Access

Local connectivity to the dashboard service was verified using:

```bash
curl -k https://localhost
```

The successful response confirmed that the HTTPS service was active.

---

# Step 9 — Access the Wazuh Dashboard

The dashboard was accessed from another machine in the lab network using:

```
https://<WAZ01-IP>
```

Example:
https://192.168.50.20
```

The browser displayed a **certificate warning** because the default installation uses a self-signed certificate.

After accepting the warning, the Wazuh login page appeared.

Login credentials:

```
Username: admin
Password: <generated password>
```

Successful authentication confirmed that the **dashboard was working correctly**.

---

# Platform Components Installed

The all-in-one deployment installed the following components:

| Component       | Purpose                               |
| --------------- | ------------------------------------- |
| Wazuh Manager   | Central security monitoring engine    |
| Wazuh Indexer   | Data indexing and storage             |
| Wazuh Dashboard | Web interface for security monitoring |
| Filebeat        | Log forwarding service                |

---

# Outcome

The **Wazuh security platform was successfully installed on WAZ01**.

The system is now capable of:

* collecting security logs
* monitoring endpoints
* detecting threats
* visualizing alerts through the dashboard

This server will serve as the **central EDR platform** for the lab environment.

---

# Skills Demonstrated

This lab demonstrated practical skills in:

* Linux server administration
* security platform deployment
* SOC infrastructure setup
* Wazuh installation and configuration
* service validation and troubleshooting
* security monitoring architecture

---

# Next Steps

The next phase of the lab will focus on:

* deploying **Wazuh agents**
* connecting **Windows endpoints (DC01, PC01, SRV01)**
* generating security events
* analyzing alerts inside the Wazuh dashboard

# Summary

The Wazuh all-in-one platform was deployed successfully on the **WAZ01 server**.
All required services were verified, credentials were captured securely, and the Wazuh dashboard was confirmed to be accessible via HTTPS.

This installation prepares the lab environment for **endpoint monitoring and threat detection in future exercises**.

