# Day 40 — Controlled Exposure Test

## Overview
Day 40 focused on simulating a **controlled external attack against a publicly exposed web server** within the SOC Home Lab environment.
The goal of this exercise was to validate the **full detection pipeline** by exposing an internal web server to the external network and performing reconnaissance attacks from an attacker machine.

This test allowed verification of how malicious activity travels through the infrastructure and how it is detected by security monitoring tools.

The exercise simulated a real-world scenario where an attacker performs **web reconnaissance against a publicly accessible HTTP service**.

---

# Lab Architecture

The attack simulation used the following network architecture:

```
KALI01 (10.0.0.50)
        │
      NET-EXT
        │
FW01 (pfSense Firewall + Suricata IDS)
        │
      NET-INT
        │
SRV01 (192.168.10.30)
        │
Suricata Logs → Splunk SIEM
```

**Components used during the test:**

| System | Role                                      |
| ------ | ----------------------------------------- |
| KALI01 | Attacker machine                          |
| FW01   | Firewall and IDS (Suricata)               |
| SRV01  | Internal Windows Server running IIS       |
| Splunk | Security Information and Event Management |

---

# Objective

The objective of this exercise was to simulate an external reconnaissance attack and confirm that the SOC monitoring pipeline correctly detects and logs malicious activity.

The following goals were defined:

* expose an internal HTTP service to the external network
* simulate attacker reconnaissance activity
* generate IDS alerts
* investigate the generated telemetry in Splunk

---

# Step 1 — Preparing the Web Server (SRV01)

A Windows Server machine **SRV01** was configured as the internal web server.

Network configuration:

```
Hostname: SRV01
IP Address: 192.168.10.30
Network: NET-INT
```

The server was also **joined to the Active Directory domain** managed by DC01 to simulate a realistic enterprise environment.

---

# Step 2 — Installing IIS Web Server

The **IIS Web Server role** was installed using Server Manager.

```
Server Manager → Add Roles and Features → Web Server (IIS)
```

After installation the default IIS page was successfully accessible locally.

To improve the realism of the simulation, a **custom test web page** was created.

Location:

```
C:\inetpub\wwwroot
```

Example content added:

```html
<h1>SRV01 Corporate Web Portal</h1>
<p>Internal Web Application</p>

<a href="/admin">Admin Panel</a>
<a href="/backup">Backup Files</a>
<a href="/login">Login</a>
```

These endpoints allow reconnaissance tools to detect possible directories during scanning.

---

# Step 3 — Exposing the Web Server

To simulate a **public web server scenario**, port **80 (HTTP)** on SRV01 was exposed through the firewall.

On **pfSense**, a NAT Port Forward rule was created.

Configuration:

```
Interface: WAN
Protocol: TCP
External Port: 80
Destination: 192.168.10.30
Destination Port: 80
Description: SRV01_HTTP
```

This rule allowed external systems to reach the internal server.

---

# Step 4 — External Access Test

Before performing the attack simulation, connectivity was verified from the attacker machine.

From **KALI01 (10.0.0.50)**:

```
curl http://<FW01_WAN_IP>
```

The request successfully returned the **IIS web page hosted on SRV01**, confirming that the server was externally reachable.

---

# Step 5 — Web Reconnaissance Attack

Two reconnaissance tools were used from the attacker machine:

### DIRB — Directory Bruteforce

Command executed on Kali:

```
dirb http://<FW01_WAN_IP>
```

DIRB attempted to discover hidden directories such as:

```
/admin
/login
/backup
/config
/uploads
```

This generated multiple HTTP requests toward the server, simulating typical attacker reconnaissance behavior.

---

### NIKTO — Web Vulnerability Scanner

The second tool used was **Nikto**, a web server vulnerability scanner.

Command used:

```
nikto -h http://<FW01_WAN_IP>
```

Nikto performs tests for:

* default files
* insecure headers
* outdated configurations
* web server misconfigurations

The scan generated numerous HTTP requests and signatures recognizable by IDS rules.

---

# Step 6 — IDS Detection (Suricata)

During the scans, **Suricata IDS running on pfSense** generated alerts indicating suspicious activity.

Example alert types included:

```
ET SCAN Nikto Scan
ET WEB_SERVER suspicious HTTP request
ET WEB_SERVER possible directory traversal
```

These alerts confirmed that the IDS successfully detected reconnaissance activity originating from the attacker machine.

---

# Step 7 — Investigation in Splunk

All Suricata alerts were forwarded to **Splunk SIEM** for analysis.

Example search query used:

```
index=suricata src_ip=10.0.0.50
```

This query returned multiple events generated during the attack simulation.

Key fields analyzed:

* source IP
* destination IP
* HTTP request details
* IDS signature
* timestamp

The events clearly showed reconnaissance traffic from **KALI01 (10.0.0.50)** targeting **SRV01 (192.168.10.30)**.

---

# Detection Chain

The following detection pipeline was successfully validated during the test:

```
KALI01 (attacker)
      ↓
pfSense firewall
      ↓
Suricata IDS detection
      ↓
Alert forwarding
      ↓
Splunk SIEM ingestion
      ↓
SOC investigation
```

This confirmed that the monitoring infrastructure is capable of detecting and logging external reconnaissance activity.

---

# Results

The Controlled Exposure Test successfully demonstrated that the SOC monitoring stack is functioning as intended.

Key results:

* external access to SRV01 was successfully simulated
* reconnaissance tools generated realistic attack traffic
* Suricata detected scanning activity
* alerts were forwarded to Splunk
* investigation confirmed attacker source IP and activity timeline

---

# Conclusion

This exercise simulated a common real-world attack scenario where an external attacker performs reconnaissance against a publicly exposed web server.

The test confirmed that the SOC lab environment is capable of:

* detecting suspicious web scanning activity
* generating IDS alerts
* forwarding security events to the SIEM
* supporting investigation of attacker behavior

Day 40 provided a valuable validation of the **end-to-end detection pipeline**, demonstrating that the lab infrastructure can effectively simulate real SOC monitoring and incident investigation workflows.
