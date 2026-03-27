Day 35 — SOC Network Isolation Test (Enterprise Perimeter Validation)

Day 35 focused on validating the network segmentation and security perimeter implemented in the HomeLab environment.

The objective of this lab was to prove that the SOC monitoring infrastructure is fully isolated from attacker networks, while still allowing the minimal telemetry traffic required for security monitoring.

This test confirms that the firewall architecture behaves like a real enterprise perimeter, where:

* **External networks cannot access internal infrastructure**
* **External networks cannot access SOC monitoring systems**
* **Only authorized telemetry flows are permitted**

The lab followed a structured validation workflow:

```
verify firewall policy → simulate attacker activity → confirm blocks → validate telemetry flow → analyze logs → document evidence
```

---

# 🧩 Network Scope

The test was performed across the three main security zones in the HomeLab architecture.

| Zone | Network         | Example Host | Role                       |
| ---- | --------------- | ------------ | -------------------------- |
| EXT  | 10.0.0.0/24     | KALI01       | Attacker simulation        |
| INT  | 192.168.10.0/24 | DC01 / PC01  | Corporate network          |
| SOC  | 192.168.50.0/24 | SPLK01       | Security monitoring (SIEM) |

Firewall gateway:

| Device         | Role                                          |
| -------------- | --------------------------------------------- |
| FW01 (pfSense) | Central firewall and segmentation enforcement |

---

# 🛡️ Firewall Policy Verification

Before performing attack simulations, the firewall configuration was verified.

### EXT Interface Rules

Rules confirmed:

```
BLOCK_EXT_to_INT
BLOCK_EXT_to_SOC
```

These rules ensure that systems located in the attacker network **cannot reach internal or SOC infrastructure**.

---

### INT → SOC Telemetry Rule

Firewall rule verified:

| Action | Source  | Destination   | Port     |
| ------ | ------- | ------------- | -------- |
| PASS   | INT net | 192.168.50.10 | TCP 9997 |

Description:

```
ALLOW_INT_to_SPLUNK_9997
```

Purpose:

Allow endpoint telemetry to reach the SIEM while keeping the SOC network isolated.

---

### SOC Access Rules

Minimal monitoring rules were confirmed on the SOC interface.

Examples include:

* SOC → INT ICMP (diagnostics)
* SOC → DC01 DNS queries
* SOC → Internet for updates

This configuration maintains **restricted but functional monitoring access**.

---

# ⚔️ Test Set A — EXT Cannot Access SOC

Attack simulation was performed from **KALI01** located in the EXT network.

### Test: Ping Splunk Server

Command:

```
ping 192.168.50.10
```

Expected result:

```
Request timed out / 100% packet loss
```

Outcome:

External network could not reach the SOC monitoring server.

---

### Test: Port Scan of SOC Services

Command:

```
nmap -Pn -p 8000,9997 192.168.50.10
```

Expected result:

```
filtered
```

Outcome:

SOC services (Splunk Web and receiving port) were not accessible from the attacker network.

---

### Test: Network Path Verification

Command:

```
traceroute 192.168.50.10
```

Outcome:

Traffic stopped at the firewall boundary, confirming segmentation enforcement.

Skills practiced:

* Attack simulation
* Network reconnaissance testing
* Firewall perimeter validation

---

# ⚔️ Test Set B — EXT Cannot Access INT

Additional tests confirmed that attacker systems cannot reach corporate infrastructure.

### Test: Ping Corporate Workstation

Command:

```
ping 192.168.10.20
```

Outcome:

No response received.

---

### Test: Internal Host Port Scan

Command:

```
nmap -Pn -p 135,139,445,3389 192.168.10.20
```

Expected result:

```
filtered
```

Outcome:

Corporate services were fully hidden from the attacker network.

Skills practiced:

* Network reconnaissance defense
* Enterprise perimeter validation
* Security segmentation testing

---

# 📡 Test Set C — Telemetry Flow Validation

While external access was blocked, authorized telemetry traffic was tested.

### Test: Connectivity to Splunk Port

From **PC01** (INT network):

PowerShell command:

```
Test-NetConnection 192.168.50.10 -Port 9997
```

Expected result:

```
TcpTestSucceeded : True
```

Outcome:

Endpoint systems can still forward logs to the SIEM.

---

### Test: Generate Windows Events

Test logs were generated to confirm SIEM ingestion.

Example commands:

PC01:

```
eventcreate /T INFORMATION /ID 1035 /L APPLICATION /D "Day35 SOC isolation test event"
```

DC01:

```
eventcreate /T WARNING /ID 2035 /L SYSTEM /D "Day35 SOC isolation test event"
```

These events were designed to appear in Splunk.

---

# 📊 Splunk Telemetry Verification

Splunk searches confirmed that logs continued to arrive despite strict network segmentation.

Example query:

```
index=* "Day35 SOC isolation test event"
```

Observed results:

Events from both **PC01 and DC01** appeared in the SIEM.

Additional verification:

```
| metadata type=hosts
```

Confirmed hosts reporting to Splunk:

```
PC01
DC01
```

Outcome:

The SOC telemetry pipeline remained fully operational.

---

# 📜 Firewall Log Evidence

Firewall logs were inspected to confirm both blocked and allowed traffic.

Location:

```
pfSense → Status → System Logs → Firewall
```

### Blocked Traffic

Observed events:

```
BLOCK_EXT_to_SOC
BLOCK_EXT_to_INT
```

These entries correspond to Kali attack attempts.

---

### Allowed Telemetry

Observed events:

```
ALLOW_INT_to_SPLUNK_9997
```

This confirms the firewall correctly allows telemetry traffic while blocking all other access.

Skills practiced:

* Firewall log analysis
* Security event correlation
* SOC evidence collection

---

# 🧠 Knowledge Gained

Validating enterprise-style network segmentation
Testing firewall perimeter security through attack simulation
Confirming SOC network isolation
Ensuring telemetry pipelines function across segmented networks
Analyzing firewall logs to confirm policy enforcement
Correlating network events with SIEM telemetry

---

# 📑 Evidence Collected

Evidence collected during the lab includes:

* pfSense firewall rule configuration
* Kali attack attempts (ping, nmap, traceroute)
* Splunk log ingestion results
* Windows event generation
* Firewall logs showing blocked traffic
* Firewall logs showing allowed telemetry
* Splunk host metadata results

This evidence demonstrates a **fully functioning enterprise-style security perimeter**.

---

# ✅ Day 35 Checklist

EXT network cannot access SOC systems
EXT network cannot access INT systems
Firewall blocks attacker scans and pings
INT hosts can send logs to Splunk on port 9997
Splunk successfully ingests Day35 test events
Splunk shows both endpoint hosts reporting
pfSense firewall logs confirm both blocked and allowed traffic
Documentation and screenshots committed to the repository


# Day 42 — Detection Pipeline Review

## Objective

The goal of Day 42 was to validate the **security telemetry pipeline** in my SOC homelab and confirm that security events can be observed across multiple monitoring layers.

The main objective was to verify that telemetry flows correctly through the security stack:

```

Endpoint → Firewall → IDS → SIEM

```

This process reflects how real Security Operations Centers (SOC) monitor and investigate security events.

---

# Lab Architecture

The test was performed in a segmented SOC lab environment consisting of multiple network zones.

```

KALI01 (Attacker Simulation)
│
│  EXT Network
▼
FW01 (pfSense Firewall)
│
│  INT Network
▼
SRV01 / PC01 / DC01 (Endpoints)

```

Security monitoring stack:

```

Suricata IDS (running on pfSense)
Splunk SIEM (SPLK01)

```

Network segments in the lab:

```

WAN
EXT
INT
SOC

```

The SOC network contains the **Splunk SIEM server**, which receives logs from pfSense and Suricata.

---

# Step 1 — Environment Preparation

Before testing the detection pipeline, I verified that all monitoring components were operational.

### Suricata IDS

Location:

```

pfSense → Services → Suricata

```

Status confirmed:

```

RUNNING

```

Suricata rules used:

```

Emerging Threats Open (ET Open)

```

This ruleset provides detection signatures for:

- reconnaissance
- suspicious HTTP requests
- scanning activity
- protocol anomalies

---

### Splunk SIEM

The Splunk web interface was verified:

```

http://<splunk_ip>:8000

```

Splunk was configured to receive logs from pfSense via **remote syslog**.

---

# Step 2 — Generating Security Telemetry

To simulate attacker activity, I generated network traffic from the **KALI01** machine targeting the internal web server **SRV01**.

Target:

```

192.168.10.30

````

Commands executed:

```bash
curl http://192.168.10.30
````

and

```bash
nmap -A 192.168.10.30
```

The purpose was to generate:

* HTTP requests
* service detection traffic
* network scan signatures

This activity simulates **reconnaissance performed by an attacker**.

---

# Step 3 — Firewall Visibility

Next, I verified that the traffic generated by Kali was visible at the **firewall layer**.

Location:

```
pfSense → Status → System Logs → Firewall
```

Observed events:

```
Source IP: 10.0.0.50 (KALI01)
Destination: 192.168.10.30 (SRV01)
Port: 80
Action: ALLOW
```

This confirms that the firewall correctly logged the network session.

This layer provides **network visibility** within the SOC monitoring pipeline.

---

# Step 4 — IDS Detection (Suricata)

After confirming firewall logs, I checked Suricata alerts.

Location:

```
pfSense → Services → Suricata → Alerts
```

Observed detections included:

```
SURICATA Applayer Detect protocol only one direction
SURICATA HTTP Host header ambiguous
SURICATA ICMPv4 unknown code
Generic Protocol Command Decode
```

These alerts confirm that Suricata inspected the network traffic generated by the scan.

Source:

```
10.0.0.50 (KALI01)
```

Destination:

```
192.168.10.30 (SRV01)
```

This step validated the **IDS detection layer**.

---

# Step 5 — Log Forwarding to SIEM

Suricata alerts were configured to be copied into the pfSense **system log**.

Configuration:

```
Suricata → Global Settings
```

Enabled option:

```
Copy Suricata messages to firewall system log
```

pfSense then forwards these logs to Splunk using **remote syslog**.

Configuration path:

```
Status → System Logs → Settings → Remote Logging
```

Remote syslog destination:

```
Splunk Server (SOC network)
```

Example configuration:

```
Remote Log Server: 192.168.50.10
Protocol: UDP
Port: 1514
```

---

# Step 6 — SIEM Ingestion Verification

To confirm that logs reached the SIEM layer, I searched for Suricata and pfSense events in Splunk.

Example search queries:

```
index=*
```

or

```
index=* 10.0.0.50
```

This search allows correlation between:

* attacker IP
* destination host
* IDS detection

This step confirms the **SIEM ingestion layer**.

---

# Detection Pipeline Mapping

The full detection pipeline observed during this test:

```
KALI01 generates scan traffic
        ↓
pfSense firewall allows and logs the connection
        ↓
Suricata IDS inspects network packets
        ↓
Suricata generates detection alerts
        ↓
pfSense forwards logs via syslog
        ↓
Splunk SIEM ingests the security events
        ↓
SOC analyst can investigate the event
```

Visual pipeline representation:

```
Attacker (Kali)
      ↓
Firewall (pfSense)
      ↓
Suricata IDS
      ↓
Splunk SIEM
      ↓
SOC Analyst
```

---

# Validation Results

The test successfully validated the **multi-layer detection pipeline**.

Security telemetry was observed at multiple layers:

| Layer     | Tool             | Evidence            |
| --------- | ---------------- | ------------------- |
| Endpoint  | Kali Linux       | Scan / HTTP request |
| Network   | pfSense Firewall | Firewall logs       |
| Detection | Suricata IDS     | IDS alerts          |
| SIEM      | Splunk           | Log ingestion       |

---

# Key Skills Demonstrated

This exercise demonstrates several core SOC analyst skills:

* Security telemetry validation
* Network traffic analysis
* IDS alert interpretation
* Log forwarding and SIEM ingestion
* Detection pipeline architecture
* Multi-layer security monitoring

---

# Key Takeaway

A functioning SOC environment requires **visibility across multiple layers of the infrastructure**.

By validating the detection pipeline end-to-end, this lab confirms that security events generated at the endpoint level can be detected, logged, and investigated through the complete monitoring stack.

This mirrors the workflow used by real-world SOC teams when analyzing suspicious network activity.
