Day 32 focused on migrating all virtual machines to their final segmented networks and implementing static IP addressing across the HomeLab environment.

The objective of this lab was to transition the infrastructure from a temporary deployment configuration to a fully segmented enterprise-style network architecture, where each system operates within a dedicated security zone.

This step finalized the network design by assigning systems to the appropriate segments and validating communication paths through the pfSense firewall (FW01).

The lab followed a structured deployment workflow:

```
assign VM networks → configure static IPs → verify routing → validate firewall segmentation → document architecture
```

---

# 🌐 Final Network Architecture

The environment now follows a three-zone security architecture connected through the firewall.

| Zone | Network         | Purpose                            |
| ---- | --------------- | ---------------------------------- |
| EXT  | 10.0.0.0/24     | External / attacker simulation     |
| INT  | 192.168.10.0/24 | Corporate internal network         |
| SOC  | 192.168.50.0/24 | Security monitoring infrastructure |

The pfSense firewall acts as the default gateway for all networks.

| Network | Gateway      |
| ------- | ------------ |
| EXT     | 10.0.0.1     |
| INT     | 192.168.10.1 |
| SOC     | 192.168.50.1 |

This architecture mirrors real enterprise network segmentation, separating attacker infrastructure, corporate systems, and security monitoring tools.

---

# 🖥️ Domain Controller Network Configuration (DC01)

The domain controller was migrated to the INT network representing the internal corporate infrastructure.

VirtualBox network configuration:

```
Adapter 1
Internal Network
NET-INT
```

Static IP configuration:

```
IP Address: 192.168.10.10
Subnet Mask: 255.255.255.0
Gateway: 192.168.10.1
DNS Server: 192.168.10.10
```

The domain controller also functions as the primary DNS server for the internal network.

Outcome:

DC01 is now reachable within the corporate network and provides domain services.

Skills practiced:

* Static IP configuration
* Internal infrastructure deployment
* DNS server configuration

---

# 💻 Corporate Workstation Configuration (PC01)

The Windows workstation representing a corporate endpoint was connected to the INT network.

VirtualBox network configuration:

```
Adapter 1
Internal Network
NET-INT
```

Static IP configuration:

```
IP Address: 192.168.10.20
Subnet Mask: 255.255.255.0
Gateway: 192.168.10.1
DNS Server: 192.168.10.10
```

Outcome:

PC01 can now communicate with the domain controller and resolve domain services through DNS.

Skills practiced:

* Endpoint network configuration
* Internal DNS usage
* Corporate workstation setup

---

# ⚔️ Attacker Network Configuration (KALI01)

The Kali Linux system used for offensive testing was migrated to the EXT network, representing an external attacker environment.

VirtualBox network configuration:

```
Adapter 1
Internal Network
NET-EXT
```

Static IP configuration:

```
IP Address: 10.0.0.50
Subnet Mask: 255.255.255.0
Gateway: 10.0.0.1
DNS Server: 1.1.1.1
```

Outcome:

KALI01 operates as an attacker simulation system outside the corporate network.

Skills practiced:

* Attacker network simulation
* Linux network configuration
* Segmentation testing preparation

---

# 📊 Security Monitoring Network Configuration (SPLK01)

The Splunk server responsible for centralized logging and monitoring was migrated to the **SOC network**.

VirtualBox network configuration:

```
Adapter 1
Internal Network
NET-SOC
```

Static IP configuration (Netplan):

```
IP Address: 192.168.50.10
Gateway: 192.168.50.1
DNS Server: 192.168.10.10
```

Outcome:

The SOC network is now able to monitor corporate infrastructure while remaining isolated from attacker systems.

Skills practiced:

* Linux server network configuration
* SOC infrastructure deployment
* Security monitoring architecture

---

# 🔍 Internal Network Connectivity Tests

Connectivity tests were performed to confirm that internal systems communicate correctly.

### PC01 → DC01

Command used:

```
ping 192.168.10.10
```

Result:

```
Reply from 192.168.10.10
```

Outcome:

Confirmed successful communication between workstation and domain controller.

---

DNS Resolution Test

Command:
nslookup dc01.corp.lab

Outcome:
Domain name resolution confirmed correct DNS configuration.

Skills practiced:
* DNS verification
* Active Directory connectivity testing


🛡️ Firewall Segmentation Validation

Security segmentation policies implemented on Day 31 were validated after the network migration.

EXT → INT Test

Host:
KALI01

Command:
ping 192.168.10.20

Expected result:
Request timed out

Outcome:
Firewall successfully blocked attacker network access to the internal network.

---

Network Scan from EXT

Command:
nmap -Pn 192.168.10.20

Expected result:
filtered

Outcome:
Firewall segmentation policies successfully prevented reconnaissance attempts.

Skills practiced:
* Attack simulation
* Firewall rule validation
* Network security testing

---

📡 SOC Monitoring Network Test

From the Splunk server:

```
ping 192.168.10.10
```

Outcome:

SOC infrastructure can communicate with corporate systems for monitoring purposes.

This configuration allows:

* Security monitoring
* Log collection
* Network diagnostics

---

📑 Infrastructure Documentation

The network architecture and addressing plan were documented in the repository.

Example IP plan:

| Host   | Network | IP Address    | Role              |
| ------ | ------- | ------------- | ----------------- |
| FW01   | EXT     | 10.0.0.1      | Firewall          |
| FW01   | INT     | 192.168.10.1  | Gateway           |
| FW01   | SOC     | 192.168.50.1  | Gateway           |
| DC01   | INT     | 192.168.10.10 | Domain Controller |
| PC01   | INT     | 192.168.10.20 | Workstation       |
| KALI01 | EXT     | 10.0.0.50     | Attacker          |
| SPLK01 | SOC     | 192.168.50.10 | SIEM              |

This documentation ensures the lab environment is reproducible and clearly structured.

---

🧠 Knowledge Gained

Implementing segmented enterprise-style network architecture
Configuring static IP addressing across Windows and Linux systems
Understanding network zones and security boundaries
Testing firewall segmentation through attack simulation
Validating DNS resolution within Active Directory environments
Documenting infrastructure architecture for reproducibility

---

✅ Day 32 Checklist

All VMs connected to correct network segments
Static IP addresses configured for all systems
PC01 communicates with DC01
DNS resolution through domain controller confirmed
KALI01 isolated from corporate network
SOC network can monitor internal systems
IP addressing plan documented in repository

🔜 Next Steps (Day 33)
The next phase will focus on validating Active Directory and DNS functionality, including:

* Domain services verification
* DNS troubleshooting
* Domain join validation
* Group Policy testing
* Preparing Windows log telemetry for Splunk

This step will prepare the environment for security monitoring and SIEM integration.

