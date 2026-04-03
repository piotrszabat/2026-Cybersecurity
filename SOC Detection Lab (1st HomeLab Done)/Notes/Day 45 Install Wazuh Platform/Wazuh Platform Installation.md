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

