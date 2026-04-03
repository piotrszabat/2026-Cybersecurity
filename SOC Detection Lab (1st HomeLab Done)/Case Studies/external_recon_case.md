Day 22 marked the beginning of the Network Security & Attacks phase by introducing structured network reconnaissance using Nmap within the HomeLab environment.  
The objective of this lab was to perform methodical host discovery, service enumeration, and deep scanning across internal assets to establish a baseline understanding of network exposure and attack surface.

This exercise simulated an attacker reconnaissance workflow where internal infrastructure is systematically profiled prior to exploitation. The lab emphasized multi-stage scanning methodology, output preservation, service identification, safe enumeration using NSE scripts, and security-oriented analysis of discovered services.

🌐 Asset Identification & Scan Preparation  
The lab began with identification of target assets and preparation of a structured scanning workspace.

Actions performed  
Documented IP addresses and roles of DC01, PC01, and SPLK01 hosts  
Created dedicated directory structure for scan outputs and screenshots  
Validated network connectivity from Kali attacker VM to target hosts  

Outcome  
Established organized scanning environment and confirmed reachability of target systems.

Skills practiced  
Asset inventory awareness  
Lab organization and artifact management  
Pre-scan reconnaissance preparation  

🔎 Host Discovery & Network Mapping  
Network discovery techniques were applied to identify active hosts within the lab subnet.

Actions performed  
Executed ICMP-based host discovery scan across local subnet  
Validated responsive hosts and correlated results with known asset inventory  
Confirmed visibility of HomeLab systems from attacker perspective  

Outcome  
Generated network-level awareness of reachable hosts and verified scanning scope.

Skills practiced  
Host discovery techniques  
Network visibility assessment  
Reconnaissance workflow development  

📡 TCP Service Enumeration — Top Ports Scan  
A baseline TCP scan targeting commonly exposed services was performed across all hosts.

Actions performed  
Executed SYN-based scan targeting top 1000 TCP ports  
Identified open services across domain controller, workstation, and SIEM host  
Captured results to persistent output files for later analysis  

Outcome  
Established initial service exposure baseline across lab infrastructure.

Skills practiced  
Service enumeration  
TCP scanning methodology  
Attack surface identification  

🧠 Deep TCP Scanning & Version Detection  
Comprehensive TCP scanning and service fingerprinting were performed to gain deeper insight into exposed services.

Actions performed  
Executed full TCP port scans against individual hosts  
Performed version detection and default script scanning on identified open ports  
Reviewed results to identify infrastructure roles and service characteristics  

Outcome  
Obtained detailed service fingerprinting enabling infrastructure profiling and security assessment.

Skills practiced  
Deep scanning methodology  
Service fingerprint interpretation  
Infrastructure role inference  

📦 UDP Scan Exploration  
A targeted UDP scan was conducted to identify additional services not observable through TCP enumeration.

Actions performed  
Executed top-port UDP scan against selected host  
Reviewed UDP response behavior and open|filtered results  
Documented potential UDP-based services  

Outcome  
Expanded network visibility to include UDP-based service exposure.

Skills practiced  
UDP scanning awareness  
Protocol diversity in reconnaissance  
Scan result interpretation  

🛡️ NSE-Based Safe Enumeration  
Safe enumeration scripts were leveraged to gather contextual service information without exploitation.

Actions performed  
Executed SMB enumeration scripts to identify OS and SMB configuration details  
Executed HTTP enumeration scripts against web-exposed services  
Reviewed script outputs for environmental context and security-relevant configuration data  

Outcome  
Collected enriched reconnaissance intelligence supporting infrastructure understanding.

Skills practiced  
Nmap NSE utilization  
Service enumeration techniques  
Configuration visibility analysis  

💾 Scan Output Preservation & Artifact Generation  
All scanning activities were documented through persistent output artifacts to support investigation and reporting workflows.

Actions performed  
Saved scan outputs in multiple formats including standard and XML  
Organized artifacts within structured directory hierarchy  
Verified completeness of scan evidence  

Outcome  
Produced reusable reconnaissance artifacts suitable for documentation and future analysis.

Skills practiced  
Artifact preservation  
Operational documentation practices  
Investigation readiness  

🧩 Security Analysis & Attack Surface Reflection  
Scan results were analyzed from a defensive perspective to identify exposed services and potential risk areas.

Actions performed  
Reviewed discovered services on each host relative to system role  
Identified management interfaces and infrastructure-critical services  
Reflected on potential hardening opportunities such as service restriction and firewall controls  

Outcome  
Developed security-oriented understanding of internal network exposure and asset attack surface.

Skills practiced  
Attack surface analysis  
Defensive security reasoning  
Infrastructure exposure assessment  

🧠 Knowledge Gained  
Structured multi-phase network reconnaissance methodology  
Differences between discovery, baseline scanning, and deep enumeration  
Importance of preserving reconnaissance artifacts for investigation workflows  
Role of safe enumeration in understanding infrastructure configuration  
Relationship between exposed services and potential attack surface  
Defensive insights derived from attacker-style reconnaissance  

✅ Day 22 Checklist  
Documented target asset inventory and IP addresses  
Validated connectivity from attacker VM to targets  
Performed subnet host discovery scan  
Executed top-port TCP enumeration across hosts  
Performed full TCP port scans per host  
Executed version detection and default script scans  
Conducted targeted UDP scanning  
Executed safe NSE-based enumeration (SMB/HTTP)  
Saved scan outputs in persistent formats  
Captured representative screenshots of scanning stages  
Documented security observations and attack surface analysis  

# Day 39 — External Reconnaissance Simulation

## Objective

The goal of this exercise was to simulate an external reconnaissance attack from an attacker machine and investigate the activity using multiple security monitoring layers within the homelab environment.

The attack was performed from **KALI01 (NET-EXT)** against **PC01 located in the internal corporate network**.  
The activity was analyzed using:

- pfSense firewall logs
- Suricata IDS alerts
- Splunk log analysis

This scenario simulates a common task performed by **SOC analysts during the investigation of external reconnaissance activity**.

---

# Lab Topology

Attacker machine:
KALI01 (10.0.0.50)


Firewall and IDS:
FW01 (pfSense + Suricata)

Internal corporate network:
NET-CORP (192.168.10.0/24)
PC01 (192.168.10.20)

SIEM platform:
SPLK01 (Splunk)

# Attack Simulation

The reconnaissance activity was performed from the attacker machine **KALI01**.

Source IP:
10.0.0.50

Target host:
PC01 — 192.168.10.20

The attacker used **Nmap** to perform network reconnaissance and port scanning against the internal host.

# Commands Used

The following commands were executed on **KALI01**.

### Basic port scan

bash
nmap 192.168.10.20

This scan checks the most common 1000 ports on the target host.

### SYN stealth scan

bash
sudo nmap -sS 192.168.10.20


This scan performs a **TCP SYN scan**, which is commonly used by attackers because it is faster and more stealthy than a full TCP connect scan.

---

### Full port scan

bash
sudo nmap -sS -p- 192.168.10.20


This command scans **all 65535 ports** on the target system to identify additional open services.


# Detection and Investigation

The attack activity was detected and investigated across multiple monitoring layers.

---

# pfSense Firewall Logs

The firewall logs recorded traffic generated by the Nmap scans originating from:

```
Source IP: 10.0.0.50
Destination IP: 192.168.10.20
```

The logs confirmed that traffic from the external network was reaching the internal host through the firewall.

Firewall logs provide visibility into:

* source IP addresses
* destination hosts
* connection attempts
* allowed or blocked traffic

---

# Suricata IDS Alerts

Suricata detected suspicious traffic patterns generated by the port scanning activity.

Example alert types observed:

```
Generic Protocol Command Decode
Potential scanning behavior
Suspicious TCP traffic
```

Suricata analyzed the packets passing through the firewall and generated alerts when the traffic matched IDS signatures from the **Emerging Threats rule set**.

The alerts showed:

```
src_ip: 10.0.0.50
dest_ip: 192.168.10.20
protocol: TCP / ICMP
```

This confirmed that the scanning activity was successfully detected by the IDS.

---

# Splunk Investigation

All Suricata logs were forwarded to **Splunk** for centralized analysis.

The logs were stored under:


index=main
sourcetype=suricata:json


Example search used in Splunk:

spl
index=main sourcetype=suricata:json src_ip=10.0.0.50


This query allowed filtering all IDS alerts generated by the attacker machine.

Additional analysis can be performed using queries such as:

spl
index=main sourcetype=suricata:json
| stats count by src_ip dest_ip alert.signature


This helps identify:

* top attackers
* most targeted hosts
* most frequent IDS alerts

# Investigation Summary

The simulated external reconnaissance attack generated observable events across all monitoring systems.

Timeline example:

```
KALI01 initiated Nmap scan against PC01
Traffic passed through pfSense firewall
Suricata analyzed packets and generated IDS alerts
Logs were forwarded to Splunk for investigation
```

This demonstrates how a SOC analyst can correlate events across:

* network firewall logs
* IDS alerts
* SIEM log analysis

---

# Key Learning Outcomes

This exercise demonstrated several important SOC analyst skills.

### Attack Techniques

* Network reconnaissance
* Port scanning
* TCP SYN stealth scanning
* Service discovery

### Detection Mechanisms

* Firewall traffic logging
* Intrusion Detection System alerts
* SIEM log correlation

### Investigation Skills

* Log analysis
* Identifying attacker source IP
* Correlating events across multiple systems
* Using SIEM queries to analyze security events

---

# Conclusion

The simulated reconnaissance attack from **KALI01 (10.0.0.50)** against **PC01 (192.168.10.20)** successfully generated detectable activity across the security monitoring stack.

The homelab environment demonstrated how external scanning behavior can be:

* logged by a firewall
* detected by an IDS
* investigated in a SIEM platform

This scenario closely reflects real-world tasks performed by **SOC analysts during the early stages of attack detection and investigation**.
