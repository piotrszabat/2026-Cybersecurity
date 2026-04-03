Day 30 FW01 pfSense Deployment (Multi-Zone Firewall Architecture)

Day 30 focused on deploying the core firewall component (FW01) of the HomeLab security architecture using pfSense.
The objective of this lab was to build the foundation for a segmented multi-zone network, introduce centralized routing between zones, and prepare the environment for future firewall policy development and network security monitoring.

The firewall was deployed with four network interfaces, representing the external network and three internal security zones:

WAN – Internet connectivity (VirtualBox NAT)
EXT – External/DMZ network
INT – Internal corporate network
SOC – Security monitoring network

This deployment establishes the network segmentation model that will support later labs involving attack simulation, IDS monitoring, log ingestion, and firewall rule engineering.

The lab followed a structured infrastructure deployment workflow:

plan → deploy → configure interfaces → validate connectivity → document

The exercise emphasized network segmentation, firewall architecture design, interface mapping, and infrastructure documentation practices used in real SOC environments.

---

🛠️ Firewall VM Deployment (FW01)

A dedicated pfSense firewall virtual machine was created in VirtualBox to serve as the central routing and security gateway for the HomeLab environment.

VM configuration:

| Resource | Configuration          |
| -------- | ---------------------- |
| VM Name  | FW01-pfSense           |
| OS Type  | BSD / FreeBSD (64-bit) |
| CPU      | 2 vCPU                 |
| Memory   | 4 GB RAM               |
| Disk     | 20 GB VDI              |

The pfSense ISO image was mounted and installed using the default installer configuration.

Installation steps included:

* Booting from pfSense installer
* Selecting default keyboard layout
* Automatic disk partitioning (UFS)
* Completing installation and rebooting from disk

Outcome:

The FW01 firewall successfully booted into the pfSense console environment, ready for interface configuration and network segmentation setup.

Skills practiced:

* Firewall deployment in virtualized environments
* Infrastructure provisioning
* Secure network architecture preparation

---

🌐 Network Interface Architecture

The firewall was configured with four network adapters, representing separate security zones within the HomeLab infrastructure.

| VirtualBox Adapter | Network Type     | pfSense Interface | Network         |
| ------------------ | ---------------- | ----------------- | --------------- |
| Adapter 1          | NAT              | WAN               | DHCP (10.0.2.x) |
| Adapter 2          | Internal Network | EXT               | 10.0.0.0/24     |
| Adapter 3          | Internal Network | INT               | 192.168.10.0/24 |
| Adapter 4          | Internal Network | SOC               | 192.168.50.0/24 |

Each adapter connects to a dedicated VirtualBox internal network, allowing isolated traffic between lab segments.

This structure simulates real enterprise network segmentation, separating:

* External infrastructure
* Internal corporate systems
* Security monitoring infrastructure

Outcome:

The firewall now acts as the central routing point between all lab networks, enabling controlled communication between zones.

Skills practiced:

* Multi-interface firewall design
* Network segmentation architecture
* Virtual network topology configuration

---

🔧 Interface Configuration

After installation, pfSense prompted for manual interface assignment.

Interfaces were mapped according to the VirtualBox adapter order and configured with static addressing.

WAN Interface

Configuration:

* Mode: DHCP
* Address assigned by VirtualBox NAT
* Provides outbound internet access for the lab

Example:

```
WAN: 10.0.2.x
```

Outcome:

The firewall successfully obtained an IP address and internet connectivity through the NAT interface.

---

EXT Interface (External Network)

Configuration:

```
IP Address: 10.0.0.1
Subnet: /24
DHCP: Disabled
```

Purpose:

The EXT network will host systems simulating external or semi-trusted infrastructure.

---

INT Interface (Internal Corporate Network)

Configuration:

```
IP Address: 192.168.10.1
Subnet: /24
DHCP: Disabled
```

Purpose:

This network represents the internal enterprise environment, where systems such as domain controllers and user workstations will reside.

---

SOC Interface (Security Operations Network)

Configuration:

```
IP Address: 192.168.50.1
Subnet: /24
DHCP: Disabled
```

Purpose:

The SOC network will host security monitoring systems, including:

* Splunk
* Network sensors
* Security analysis tools

This separation ensures monitoring infrastructure remains isolated from production networks, reflecting common enterprise SOC design principles.

---

🌍 WebGUI Access & Firewall Management

After interface configuration, the pfSense WebGUI became accessible from the INT network.

Access URL:

```
https://192.168.10.1
```

Default credentials were used for the initial login:

```
Username: admin
Password: pfsense
```

Initial configuration steps included:

* Changing the default administrator password
* Verifying interface assignments
* Confirming network addressing
* Reviewing system status dashboard

Outcome:

The firewall management interface was successfully accessed and verified.

Skills practiced:

* Firewall administration
* Secure management interface access
* Configuration validation

---

# 📡 Connectivity Validation

Basic connectivity tests were performed from the firewall to confirm external network reachability.

Using the pfSense diagnostics tools:

Ping test:

```
1.1.1.1
```

Purpose:

* Verify WAN connectivity
* Confirm outbound routing functionality

Additional DNS tests were performed to validate name resolution.

Outcome:

The firewall successfully reached external hosts, confirming internet connectivity through the WAN interface.

Skills practiced:

* Network troubleshooting
* Firewall diagnostics
* Connectivity validation

---

# 🧾 Infrastructure Documentation

All deployment steps were documented in the repository, including:

* VM specifications
* Interface mapping
* Network addressing plan
* Deployment notes
* Screenshots of configuration steps

Evidence collected included:

* VirtualBox network configuration
* pfSense installer screen
* Interface assignment console output
* WebGUI dashboard
* Firewall interface configuration
* Connectivity validation tests

This mirrors real-world infrastructure documentation practices used in security engineering environments.

---

# 🧠 Knowledge Gained

Designing segmented network architectures using a firewall
Deploying pfSense in a virtualized lab environment
Configuring multi-interface firewall routing
Understanding security zone separation (EXT / INT / SOC)
Managing firewall infrastructure through CLI and WebGUI
Validating network connectivity and routing
Documenting infrastructure deployments for reproducibility

---

# ✅ Day 30 Checklist

FW01 pfSense VM created
pfSense installed successfully
4 network interfaces configured
WAN interface obtained DHCP address
EXT network configured (10.0.0.1/24)
INT network configured (192.168.10.1/24)
SOC network configured (192.168.50.1/24)
WebGUI access confirmed
Administrator password changed
Internet connectivity verified
Deployment documented in repository

