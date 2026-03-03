Day 29 Enterprise Network Redesign & Architecture Modernization

Day 29 marks the beginning of the HomeLab modernization phase.

The objective of this lab was to redesign the existing flat network architecture into a segmented, enterprise-style infrastructure with clear security zones, structured IP addressing, perimeter control planning, and defined traffic flow logic.

This redesign transitions the lab from a functional SOC environment into a realistic enterprise security architecture.

This phase followed a structured engineering workflow:

assess current state → define security zones → design segmentation → create IP plan → model traffic flow → document architecture

The lab emphasized network segmentation principles, perimeter security planning, structured addressing methodology, and SOC network isolation strategy.

---

# 🧠 Current State Assessment

The original HomeLab architecture consisted of:

* DC01 (Windows Server 2022)
* PC01 (Windows 11)
* KALI01 (Debian-based attacker)
* SPLK01 (Ubuntu 22.04 SIEM)

All systems were operating within a flat network model without logical segmentation or perimeter enforcement.

Identified limitations:

* No external vs internal separation
* No perimeter firewall
* No monitoring isolation
* No structured IP allocation
* Limited simulation of real enterprise attack surfaces

Outcome:
A redesign was required to simulate enterprise-grade infrastructure.

Skills practiced:
Architecture evaluation
Security gap identification
Threat surface assessment

---

# 🏗 Enterprise Segmentation Design

Three security zones were defined to replicate a corporate environment.

## 🌍 Zone 1 — External (Untrusted)

Purpose:
Simulate the Internet and external attacker environment.

Network Name:
NET-EXT

Subnet:
10.0.0.0/24

Assigned Systems:
KALI01 – 10.0.0.50
FW01 (WAN interface) – 10.0.0.1

Security Model:
Untrusted network
No direct access to internal or SOC networks

---

## 🏢 Zone 2 — Corporate Network

Purpose:
Simulate internal business infrastructure.

Network Name:
NET-CORP

Subnet:
192.168.10.0/24

Assigned Systems:
FW01 (LAN-CORP) – 192.168.10.1
DC01 – 192.168.10.10
PC01 – 192.168.10.20
(Future SRV01) – 192.168.10.30

Gateway:
192.168.10.1

DNS:
192.168.10.10 (Active Directory DNS)

Security Model:
Protected internal network
Domain-controlled infrastructure
Controlled outbound access

---

## 🛡 Zone 3 — SOC Monitoring Network

Purpose:
Isolate monitoring and security infrastructure.

Network Name:
NET-SOC

Subnet:
192.168.50.0/24

Assigned Systems:
FW01 (LAN-SOC) – 192.168.50.1
SPLK01 – 192.168.50.10
(Future IDS01) – 192.168.50.20
(Future VAS01) – 192.168.50.30

Security Model:
Restricted access
No direct external exposure
Receives logs from corporate network

---

# 📡 Planned Traffic Flow Model

The redesigned architecture enforces structured communication paths.

Primary attack simulation path:

KALI01 (External)
→ FW01 (Perimeter)
→ NET-CORP (Internal hosts)
→ Log generation
→ NET-SOC (Splunk SIEM)

Firewall policy design principles:

* EXT → CORP = Block (default deny)
* EXT → SOC = Block
* CORP → SOC = Allow (log forwarding only)
* SOC → CORP = Allow (monitoring & scanning)
* CORP → Internet = Controlled allow

Outcome:
Defined enforceable security boundaries prior to firewall deployment.

Skills practiced:
Security zone modeling
Zero-trust boundary planning
Traffic control design
Enterprise routing logic

---

# 📐 Architecture Documentation

A new enterprise diagram was created illustrating:

* Perimeter firewall (FW01)
* Segmented internal network
* Isolated SOC monitoring network
* External attacker zone
* Structured routing relationships

Documentation created:

architecture/network_v2_diagram.png
architecture/ip_plan_v2.md

This documentation mirrors professional infrastructure design standards used in enterprise environments.

Skills practiced:
Infrastructure documentation
Network blueprint creation
IP planning methodology
Enterprise architecture modeling

---

# 🔐 Security Principles Applied

The redesign implements real-world security architecture concepts:

Network segmentation
Perimeter enforcement
Monitoring isolation
Controlled routing
Centralized logging strategy
Zero-trust between zones
Structured address allocation

This marks the transition from “flat lab” to “enterprise security model.”

---

# 🧠 Knowledge Gained

Understanding of enterprise network segmentation
Ability to design multi-zone architecture
IP address planning in structured environments
Security boundary definition before implementation
Traffic flow modeling for SOC monitoring
Foundational perimeter security strategy

---

# 📈 Why This Matters

Most home labs operate in flat networks.

This redesign introduces:

* Realistic attack surface modeling
* Perimeter security simulation
* SOC network isolation
* Enterprise-grade structure
* Scalable architecture for future IDS, firewall, and vulnerability integration

Day 29 establishes the foundation for firewall deployment (Day 30) and full infrastructure modernization.

---

# ✅ Day 29 Checklist

Current architecture assessed
Security gaps identified
Three security zones defined
IP addressing plan created
Traffic flow rules documented
Enterprise diagram created
SOC isolation strategy designed
Preparation completed for FW01 deployment
