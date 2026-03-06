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
