# Day 34 — Splunk Reintegration (Log Telemetry Pipeline)

## Goal for Day 34

Re-establish centralized logging in the segmented architecture:

**DC01 / PC01 → FW01 → SPLK01 (Splunk SIEM)**

You will:

✅ Install **Splunk Universal Forwarder**
✅ Configure **log forwarding to port 9997**
✅ Verify **firewall rule for telemetry traffic**
✅ Validate **log ingestion in Splunk**
✅ Document results

Output file:

```
telemetry/splunk_v2.md
```

---

# 1) Prepare GitHub Workspace

Create folders:

```
telemetry/day34-splunk-reintegration/
  screenshots/
  notes/
```

Create documentation file:

```
telemetry/splunk_v2.md
```

Optional notes file:

```
telemetry/day34-splunk-reintegration/notes/day34_notes.md
```

Template for the report:

```
Date: 2026-03-05
Objective: Reintegrate endpoint telemetry into Splunk SIEM after network segmentation.

Tasks Completed:
- Installed Splunk Universal Forwarder
- Configured log forwarding
- Verified firewall rules
- Validated log ingestion

Result: PASS / FAIL
Next Step: Day 35 — SOC Network Isolation Test
```

---

# 2) Verify Splunk Server Status (SPLK01)

Login to **SPLK01**.

Check Splunk service:

```bash
sudo systemctl status splunk
```

Or:

```bash
sudo /opt/splunk/bin/splunk status
```

Expected:

```
splunkd is running
```

Access Splunk Web:

```
http://192.168.50.10:8000
```

Login with your Splunk admin account.

✅ Screenshot:

```
01-splunk-dashboard-running.png
```

---

# 3) Enable Receiving Port for Forwarders

Splunk must listen on **port 9997**.

Navigate:

```
Settings → Forwarding and Receiving
```

Click:

```
Configure Receiving
```

Add new port:

```
9997
```

Save.

Expected result:

```
Listening on port 9997
```

This port receives logs from:

```
Universal Forwarders
```

✅ Screenshot:

```
02-splunk-receiving-port-9997.png
```

---

# 4) Verify Firewall Rule (INT → SOC)

Your firewall must allow:

```
INT network → SPLK01 → TCP 9997
```

Open **pfSense (FW01)**.

Navigate:

```
Firewall → Rules → INT
```

Verify rule:

| Action | Source  | Destination   | Port |
| ------ | ------- | ------------- | ---- |
| PASS   | INT net | 192.168.50.10 | 9997 |

If missing → create it.

Enable logging for the rule.

Description:

```
ALLOW_INT_to_SPLUNK_9997
```

Apply changes.

✅ Screenshot:

```
03-pfsense-splunk-firewall-rule.png
```

---

# 5) Install Splunk Universal Forwarder (DC01)

Download **Splunk Universal Forwarder for Windows**.

Recommended version:

```
Splunk Universal Forwarder 9.x
```

Install on **DC01**.

During installation choose:

```
Forward data to another Splunk instance
```

Server:

```
192.168.50.10
```

Port:

```
9997
```

Finish installation.

Verify service:

```
SplunkForwarder service running
```

Command (PowerShell):

```
Get-Service SplunkForwarder
```

Expected:

```
Running
```

✅ Screenshot:

```
04-dc01-forwarder-service.png
```

---

# 6) Configure DC01 Log Inputs

Open:

```
C:\Program Files\SplunkUniversalForwarder\etc\system\local\inputs.conf
```

Add:

```
[WinEventLog://Security]
disabled = false

[WinEventLog://System]
disabled = false

[WinEventLog://Application]
disabled = false
```

Restart forwarder:

```
Restart-Service SplunkForwarder
```

Expected logs sent:

```
Security
System
Application
```

✅ Screenshot:

```
05-dc01-inputs-conf.png
```

---

# 7) Install Universal Forwarder on PC01

Repeat same installation on **PC01**.

Forward to:

```
192.168.50.10:9997
```

Verify service:

```
Get-Service SplunkForwarder
```

Expected:

```
Running
```

✅ Screenshot:

```
06-pc01-forwarder-service.png
```

---

# 8) Generate Test Logs

To confirm ingestion, generate events.

On **PC01** run:

```
eventcreate /T INFORMATION /ID 1000 /L APPLICATION /D "SOC Lab Test Event"
```

On **DC01** run:

```
eventcreate /T ERROR /ID 2000 /L SYSTEM /D "Domain Controller Test Event"
```

These events should appear in Splunk.

✅ Screenshot:

```
07-windows-test-event.png
```

---

# 9) Verify Log Ingestion in Splunk

Go to Splunk Web.

Navigate:

```
Search & Reporting
```

Run query:

```
index=* host=PC01
```

Then:

```
index=* host=DC01
```

Expected results:

```
Windows Event Logs visible
```

Example event types:

```
WinEventLog:Security
WinEventLog:System
WinEventLog:Application
```

✅ Screenshot:

```
08-splunk-search-pc01-logs.png
```

---

# 10) Validate Firewall Log Traffic

Open **pfSense**.

Navigate:

```
Status → System Logs → Firewall
```

Filter for:

```
9997
```

Expected:

```
Allowed traffic from INT → SPLK01
```

This confirms firewall rule working.

✅ Screenshot:

```
09-pfsense-firewall-log-9997.png
```

---

# 11) Validate Host Visibility in Splunk

Run query:

```
| metadata type=hosts
```

Expected hosts:

```
DC01
PC01
```

This confirms forwarders registered.

✅ Screenshot:

```
10-splunk-host-list.png
```

---

# 12) Update Documentation (GitHub Output)

Update:

```
telemetry/splunk_v2.md
```

Suggested structure:

### Overview

Description of Splunk reintegration.

### Architecture

```
Endpoints → Firewall → Splunk
```

### Forwarder Deployment

* DC01 forwarder installed
* PC01 forwarder installed

### Firewall Configuration

Rule allowing TCP 9997.

### Log Ingestion Test

Commands used to generate events.

### Results

Logs successfully received by Splunk.

### Evidence

List of screenshots.

---

# 13) Screenshot List (Day 34)

Save under:

```
telemetry/day34-splunk-reintegration/screenshots/
```

Recommended names:

```
01-splunk-dashboard-running.png
02-splunk-receiving-port.png
03-pfsense-firewall-rule.png
04-dc01-forwarder-service.png
05-dc01-inputs-conf.png
06-pc01-forwarder-service.png
07-windows-test-event.png
08-splunk-search-pc01.png
09-firewall-log-9997.png
10-splunk-host-list.png
```

---

# 14) End-of-Day 34 Validation Checklist

Your SOC telemetry pipeline works if:

✅ Splunk service running
✅ Port **9997 receiving logs**
✅ Forwarder installed on **DC01 and PC01**
✅ Firewall allows **INT → SOC port 9997**
✅ Test events appear in Splunk
✅ Both hosts visible in Splunk metadata
✅ Documentation committed to GitHub
