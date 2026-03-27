Day 10 marked a major milestone in the HomeLab by introducing centralized log collection through SIEM integration.  
The objective of this lab was to deploy Splunk Enterprise as a central logging platform and connect the Windows endpoint using Splunk Universal Forwarder to enable aggregated visibility across host telemetry sources.

This exercise simulated real SOC ingestion workflows, where endpoint telemetry is forwarded to a SIEM for monitoring, detection engineering, and investigation. The lab focused on infrastructure deployment, network configuration, forwarder setup, and ingestion validation to establish a functional telemetry pipeline.

🖥️ SIEM Infrastructure Deployment  
A dedicated Linux virtual machine was provisioned to host the Splunk Enterprise SIEM platform.

Actions performed  
Downloaded Ubuntu Desktop LTS ISO  
Created SPLK01 virtual machine within VirtualBox  
Configured NAT Network to enable VM-to-VM communication  
Installed Ubuntu and configured hostname as SPLK01  
Validated network connectivity between PC01 and SPLK01  

Outcome  
Successfully provisioned a dedicated SIEM host within the HomeLab environment.

Skills practiced  
Virtual machine provisioning  
Virtual networking configuration  
Infrastructure segmentation awareness  

📦 Splunk Enterprise Installation  
Splunk Enterprise was installed on the SPLK01 Linux host to serve as the centralized log aggregation platform.

Actions performed  
Downloaded Splunk Enterprise Linux package  
Extracted Splunk binaries and deployed to /opt directory  
Executed initial Splunk startup with license acceptance  
Created administrative credentials  
Verified splunkd service operational status  

Outcome  
Established a functioning Splunk Enterprise SIEM instance within the lab.

Skills practiced  
Linux application deployment  
Service lifecycle management  
SIEM platform initialization  

🌐 Splunk Web Interface Activation  
The Splunk Web interface was enabled and validated to provide operational access to the SIEM platform.

Actions performed  
Enabled Splunk webserver component  
Restarted Splunk services  
Verified listening state on port 8000  
Tested local and remote browser connectivity  

Outcome  
Confirmed availability of Splunk Web UI for analysis and administration.

Skills practiced  
Service troubleshooting  
Port validation  
Web interface accessibility testing  

📡 Data Receiver Configuration  
Splunk was configured to accept inbound telemetry from forwarders.

Actions performed  
Navigated to Forwarding and Receiving configuration within Splunk Web  
Enabled receiving port 9997  
Validated receiver readiness for endpoint ingestion  

Outcome  
Prepared SIEM infrastructure to accept forwarded endpoint telemetry.

Skills practiced  
SIEM ingestion configuration  
Forwarding architecture understanding  
Data pipeline preparation  

💻 Splunk Universal Forwarder Deployment  
Splunk Universal Forwarder was installed on the Windows endpoint to transmit telemetry to the SIEM.

Actions performed  
Downloaded Splunk Universal Forwarder for Windows  
Installed forwarder service on PC01  
Configured forwarding target to SPLK01 receiver  
Verified network connectivity to ingestion port  

Outcome  
Established endpoint forwarding capability toward centralized SIEM.

Skills practiced  
Endpoint agent deployment  
Forwarder configuration  
Telemetry routing awareness  

📥 Windows & Sysmon Log Ingestion Configuration  
Forwarder inputs were configured to collect both native Windows and Sysmon telemetry sources.

Actions performed  
Created custom inputs.conf configuration  
Enabled Security Event Log ingestion  
Enabled Sysmon Operational log ingestion  
Restarted forwarder service to apply configuration  

Outcome  
Activated host telemetry collection pipeline for both authentication and advanced endpoint activity logs.

Skills practiced  
Forwarder input configuration  
Telemetry source selection  
Agent-based log collection  

🔎 Ingestion Verification & Validation  
Telemetry flow from endpoint to SIEM was validated through Splunk search operations.

Actions performed  
Queried Splunk index for host visibility  
Executed searches for Windows Security events  
Executed searches for Sysmon telemetry  
Generated fresh endpoint activity to validate real-time ingestion  

Outcome  
Confirmed successful end-to-end telemetry pipeline from endpoint to SIEM platform.

Skills practiced  
SIEM query validation  
Telemetry pipeline verification  
Operational monitoring mindset  

🧠 Knowledge Gained  
Architecture of centralized log collection within SOC environments  
Role of SIEM as aggregation and analysis platform  
Forwarder-based telemetry collection methodology  
Importance of network configuration in telemetry pipelines  
Operational workflow for validating ingestion success  
Correlation potential between Security logs and Sysmon telemetry  

✅ Day 10 Checklist  
Provisioned SPLK01 Linux virtual machine  
Installed and initialized Splunk Enterprise  
Enabled Splunk Web interface  
Configured Splunk receiver port 9997  
Installed Splunk Universal Forwarder on PC01  
Configured forward-server connectivity  
Created inputs.conf for Windows Security and Sysmon logs  
Restarted forwarder service  
Validated host visibility within Splunk  
Confirmed ingestion of Security and Sysmon telemetry  
Captured representative SIEM ingestion screenshots  

Day 11 focused on SIEM exploration and developing operational familiarity with Splunk as a primary analysis platform within the HomeLab environment.  
The objective of this lab was to understand how telemetry is structured, searched, filtered, and visualized within a SIEM, enabling foundational SOC analyst workflows centered on log analysis and situational awareness.

This exercise simulated Tier 1 SOC daily activities, including telemetry discovery, authentication monitoring, process analysis, and dashboard creation. The lab emphasized query development, data interpretation, and visualization to strengthen analytical confidence within the SIEM environment.

🔎 Data Discovery & Environment Orientation  
Initial exploration was performed to understand available telemetry sources and host visibility within Splunk.

Actions performed  
Executed host discovery queries to identify indexed endpoints  
Reviewed sourcetype distribution across collected telemetry  
Validated ingestion coverage for Windows Security and Sysmon logs  

Outcome  
Established situational awareness of indexed telemetry sources and data structure within the SIEM.

Skills practiced  
SIEM data discovery  
Telemetry source identification  
Operational environment orientation  

⏱️ Time Range Exploration  
Temporal filtering capabilities were explored to understand how time selection impacts log visibility and analysis context.

Actions performed  
Adjusted Splunk time picker across multiple ranges  
Compared event volume across short and extended time windows  
Observed temporal patterns in telemetry generation  

Outcome  
Developed awareness of time-scoped analysis and its importance in incident investigation.

Skills practiced  
Time-based filtering  
Temporal context analysis  
Investigation scoping techniques  

🔐 Authentication Telemetry Analysis  
Authentication-related events were analyzed to simulate common SOC monitoring scenarios.

Actions performed  
Queried successful authentication events (EventCode 4624)  
Queried failed authentication events (EventCode 4625)  
Aggregated authentication events by account name  
Observed authentication patterns across the endpoint  

Outcome  
Validated ability to monitor authentication behavior and detect anomalous login activity.

Skills practiced  
Authentication monitoring  
Event aggregation techniques  
Identity telemetry analysis  

🛡️ Privilege & Account Monitoring  
Privilege assignment and account lifecycle telemetry were explored to understand administrative activity visibility.

Actions performed  
Queried privilege assignment events (EventCode 4672)  
Queried account creation events (EventCode 4720)  
Reviewed associated account metadata  

Outcome  
Confirmed visibility into administrative activity and identity lifecycle events.

Skills practiced  
Privilege monitoring awareness  
Administrative action detection  
Identity lifecycle analysis  

💻 Sysmon Telemetry Exploration  
Advanced endpoint telemetry collected via Sysmon was explored to enhance behavioral monitoring capabilities.

Actions performed  
Queried process creation events (EventCode 1)  
Analyzed top executed processes across the endpoint  
Queried network connection events (EventCode 3)  
Queried file creation events (EventCode 11)  

Outcome  
Developed operational familiarity with behavioral telemetry and process-driven activity analysis.

Skills practiced  
Process telemetry exploration  
Host-based network monitoring  
File activity awareness  

🧭 Field-Level Event Inspection  
Individual events were inspected to understand available metadata and contextual fields.

Actions performed  
Opened raw event views within Splunk  
Reviewed common metadata fields such as host, source, sourcetype, and EventCode  
Observed enriched event attributes from Sysmon telemetry  

Outcome  
Improved ability to interpret event structure and leverage field-level context during investigations.

Skills practiced  
Field discovery  
Event schema interpretation  
Metadata contextualization  

🔍 Filtering & Targeted Search  
Focused filtering techniques were applied to locate specific activity within the dataset.

Actions performed  
Filtered Sysmon process events for specific applications  
Applied field-based search constraints  
Validated ability to locate previously generated lab activity  

Outcome  
Confirmed capability to perform targeted telemetry searches and isolate relevant activity.

Skills practiced  
Search refinement  
Pattern matching  
Targeted investigation workflow  

📊 Dashboard Creation & Visualization  
A simple dashboard panel was created to visualize authentication activity and introduce SIEM visualization workflows.

Actions performed  
Constructed query aggregating failed authentication events  
Saved query output as dashboard panel  
Configured visualization for authentication overview  

Outcome  
Established baseline dashboard demonstrating authentication monitoring use case.

Skills practiced  
SIEM visualization  
Dashboard panel creation  
Operational monitoring design  

🧠 Knowledge Gained  
Importance of data discovery when entering new SIEM environments  
Role of time scoping in investigation workflows  
Authentication telemetry as a primary SOC monitoring source  
Administrative activity visibility through Windows Security logs  
Behavioral monitoring enabled by Sysmon telemetry  
Value of field-level inspection for contextual understanding  
Dashboarding as a mechanism for operational awareness  

✅ Day 11 Checklist  
Executed host discovery queries  
Reviewed sourcetype distribution  
Explored multiple time ranges within Splunk  
Analyzed successful authentication events  
Analyzed failed authentication events  
Reviewed privilege assignment telemetry  
Reviewed account creation telemetry  
Explored Sysmon process creation events  
Explored Sysmon network connection events  
Explored Sysmon file creation events  
Inspected individual event fields and metadata  
Performed targeted filtered searches  
Created authentication monitoring dashboard panel  
Captured representative SIEM exploration screenshots  

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
