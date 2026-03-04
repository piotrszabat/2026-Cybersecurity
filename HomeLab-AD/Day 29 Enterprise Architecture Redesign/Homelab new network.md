🛡️ SOC Homelab Network Architecture

This repository documents my SOC homelab environment, built using VirtualBox, pfSense, and several virtual machines to simulate a small enterprise network with segmentation, monitoring, and attack simulation.

The goal of this lab is to practice:

- Network segmentation
- Firewall configuration
- Active Directory environments
- SIEM monitoring with Splunk
- Attack simulation using Kali Linux

---

🌐 Network Topology

My homelab network is segmented into three main zones:

- EXT (External / Attacker Network)
- INT (Internal Corporate Network)
- SOC (Security Operations Network)

All traffic between networks is routed and controlled by pfSense (FW01).

            Internet
                |
                |
            WAN (10.0.2.15)
                |
              FW01
         pfSense Firewall
    -------------------------
    |           |           |
   EXT         INT         SOC
 10.0.0.0     192.168.10.0 192.168.50.0
    |           |           |
  KALI       PC01        SPLK01
             DC01


🔥 Firewall (FW01)

The firewall is powered by pfSense and acts as the central router and security gateway for the entire lab.

| Interface | IP | Purpose |
|--------|--------|--------|
| WAN | 10.0.2.15 | Internet access via VirtualBox NAT |
| LAN | 10.0.0.1 | EXT network (attacker zone) |
| OPT1 | 192.168.10.1 | INT network (corporate network) |
| OPT2 | 192.168.50.1 | SOC network (security monitoring) |

FW01 performs:

- Network routing
- Firewall filtering
- NAT to the Internet
- Network segmentation between zones

---

🖥️ Internal Corporate Network (INT)

The INT network simulates a small corporate environment.

Network:

192.168.10.0/24


Hosts:

| Machine | IP | Role |
|-------|-------|-------|
| DC01 | 192.168.10.10 | Domain Controller / DNS |
| PC01 | 192.168.10.20 | Corporate workstation |

DC01 is the Active Directory Domain Controller responsible for:

- Domain services
- DNS
- Authentication
- Domain management

PC01
PC01 simulates a corporate user workstation that:

- Joins the domain
- Generates system logs
- Simulates user activity

These logs will later be forwarded to the SOC monitoring environment.

---

🐉 External Network (EXT)

The EXT network simulates an attacker environment.

Network:

```

10.0.0.0/24

```

Host:

| Machine | IP | Role |
|-------|-------|-------|
| KALI01 | 10.0.0.50 | Attacker machine |

Kali Linux is used to perform:

- Network scanning
- Vulnerability testing
- Attack simulation

The firewall blocks direct access from EXT → INT, simulating perimeter security.

---

🔎 Security Operations Center (SOC)

The SOC network hosts monitoring and security analysis tools.

Network:

192.168.50.0/24



Host:

| Machine | IP | Role |
|-------|-------|-------|
| SPLK01 | 192.168.50.10 | Splunk SIEM |

SPLK01

SPLK01 runs Splunk Enterprise and acts as a Security Information and Event Management (SIEM) system.

It collects logs from:

- Windows hosts
- Network infrastructure
- Security tools

The SOC network is allowed to access the internal network for monitoring purposes.

---

🔐 Network Segmentation

The lab uses network segmentation to simulate real-world enterprise security.

Firewall rules enforce the following model:

| Source | Destination | Policy |
|------|------|------|
| INT → ANY | Allowed |
| SOC → INT | Allowed |
| EXT → INT | Blocked |
| EXT → SOC | Blocked |

This creates a realistic perimeter security model where attacker networks cannot directly access corporate resources.

---

🌍 Internet Access

Internet connectivity is provided through:

pfSense WAN → VirtualBox NAT



All internal networks use Outbound NAT to access external resources such as:

- Software updates
- Package repositories
- Security tools


🎯 Goals of this Lab

This homelab allows me to practice and demonstrate:

- Firewall configuration
- Network segmentation
- SIEM monitoring
- Attack detection
- Blue team analysis
- Security event investigation

Future improvements will include:

- Sysmon logging
- Windows Event Forwarding
- Splunk dashboards
- Detection rules
- Attack simulations from Kali

🧪 Technologies Used

- pfSense
- VirtualBox
- Windows Server
- Windows Client
- Ubuntu Server
- Splunk
- Kali Linux

🚀 Future Improvements

Planned enhancements for the lab include:

- Suricata IDS
- Threat detection rules
- Automated log forwarding
- Detection engineering
- Security alerting

This homelab is an ongoing project focused on improving my blue team and defensive security skills.

