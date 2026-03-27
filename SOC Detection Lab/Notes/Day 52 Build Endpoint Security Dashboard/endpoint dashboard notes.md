# Day 52 — Endpoint Security Dashboard

## Objective

The goal of Day 52 was to transform raw Wazuh telemetry in Splunk into a **visual monitoring dashboard** that allows quick analysis of endpoint activity.

After integrating Wazuh with Splunk on Day 51, the next step was to build a **SOC-style dashboard** for monitoring endpoint alerts and activity.

Telemetry pipeline at this stage:

```
Endpoints → Wazuh → Splunk → Security Dashboard
```

This step demonstrates the ability to **visualize security data and build analyst-friendly dashboards**, which is a key SOC skill.

---

# Lab Environment

The homelab environment consists of two network segments.

```
NET-INT
├── DC01
├── PC01
└── SRV01

NET-SOC
├── WAZ01
└── SPLK01
```

Components:

| System | Role                     |
| ------ | ------------------------ |
| DC01   | Domain Controller        |
| PC01   | Windows endpoint         |
| SRV01  | Windows server           |
| WAZ01  | Wazuh detection platform |
| SPLK01 | Splunk Enterprise SIEM   |

---

# Telemetry Pipeline

The data flow used by the dashboard:

```
Endpoints
   ↓
Wazuh Agents
   ↓
WAZ01 Detection Engine
   ↓
alerts.json
   ↓
Splunk Universal Forwarder
   ↓
SPLK01 SIEM
   ↓
Endpoint Security Dashboard
```

Wazuh alerts are written to:

```
/var/ossec/logs/alerts/alerts.json
```

and forwarded to Splunk where they are indexed under:

```
wazuh-alerts
```

---

# Step 1 — Verify Wazuh Data in Splunk

Before building the dashboard, Wazuh data ingestion was verified.

Query used:

```spl
index="wazuh-alerts"
```

This confirmed:

* alerts are present in the index
* events are recent
* fields such as `agent.name` and `rule.description` are available

---

# Step 2 — Identify Relevant Fields

Several Wazuh fields were inspected to determine which ones would be used in the dashboard.

Key fields used:

```
agent.name
rule.description
Image
```

These fields provide information about:

* endpoint generating alerts
* type of detection triggered
* process activity on endpoints

---

# Step 3 — Create a New Dashboard

A new dashboard was created in **Splunk Dashboard Studio**.

Dashboard configuration:

```
Title: Endpoint Security Dashboard
Description: Wazuh-based endpoint monitoring dashboard
```

The dashboard visualizes endpoint activity for:

```
DC01
PC01
SRV01
```

---

# Step 4 — Plan Dashboard Layout

The dashboard was designed using a **2×2 panel layout** to keep it clean and readable.

Layout structure:

```
Top Endpoints by Alert Volume | Top Alert Types
Top Process Activity          | PowerShell Executions
```

This structure allows analysts to quickly identify:

* which systems generate alerts
* which alerts occur most frequently
* which processes are active
* whether PowerShell activity is present

---

# Step 5 — Panel 1: Top Endpoints by Alert Volume

This panel shows which endpoints generate the highest number of Wazuh alerts.

Search query:

```spl
index="wazuh-alerts"
| stats count by agent.name
| sort - count
```

Visualization type:

```
Bar chart
```

Purpose:

* identify noisy hosts
* highlight systems requiring investigation

---

# Step 6 — Panel 2: Top Alert Types

This panel displays the most common alert types detected by Wazuh.

Search query:

```spl
index="wazuh-alerts"
| stats count by rule.description
| sort - count
```

Visualization type:

```
Pie chart / Bar chart
```

Purpose:

* understand dominant alert categories
* identify detection trends

---

# Step 7 — Panel 3: Top Process Activity

This panel highlights the most frequently observed processes in endpoint telemetry.

Search query:

```spl
index="wazuh-alerts"
| stats count by Image
| sort - count
| head 15
```

Visualization type:

```
Bar chart
```

Purpose:

* identify commonly executed processes
* highlight suspicious binaries if present

---

# Step 8 — Panel 4: PowerShell Executions

This panel monitors PowerShell activity across endpoints.

Search query:

```spl
index="wazuh-alerts" ("powershell" OR "pwsh" OR "PowerShell")
| stats count by agent.name rule.description
| sort - count
```

Visualization type:

```
Table
```

Purpose:

* detect PowerShell usage
* highlight potentially suspicious script activity

---

# Step 9 — Configure Dashboard Time Range

The global dashboard time range was configured to show recent activity.

Default range:

```
Last 24 hours
```

This ensures the dashboard displays current endpoint behavior.

---

# Step 10 — Generate Test Activity

Endpoint activity was generated to populate the dashboard.

Examples executed on **PC01**:

```powershell
powershell -EncodedCommand YwBhAGwAYwA=
cmd.exe
notepad.exe
```

These actions produced Wazuh alerts which were forwarded to Splunk.

---

# Step 11 — Final Dashboard Review

The dashboard was validated to confirm it provides useful visibility for analysts.

The dashboard allows quick answers to questions such as:

```
Which endpoints generate the most alerts?
Which detection types appear most frequently?
What processes are active on endpoints?
Is PowerShell activity occurring?
```

---

# Final Dashboard Structure

```
Top Endpoints by Alert Volume
Top Alert Types
Top Process Activity
PowerShell Executions
```

This dashboard provides a clear **SOC-style overview of endpoint activity**.

---

# Skills Demonstrated

This lab step demonstrates several SOC and SIEM skills:

* Splunk Dashboard Studio usage
* security data visualization
* Wazuh alert analysis
* SPL query development
* endpoint telemetry monitoring
* SOC dashboard design

---

# Outcome

A functional **Endpoint Security Dashboard** was built in Splunk using Wazuh telemetry.
The dashboard provides clear visibility into endpoint alerts, process activity, and PowerShell usage across the environment.

This step completes the transition from **log ingestion to operational security monitoring** in the homelab SOC pipeline.

---

# Screenshot

```
detections/endpoint_dashboard.png
```

---

# Summary

Day 52 focused on building a **Splunk dashboard for endpoint monitoring** using Wazuh alerts.
The dashboard provides analysts with visual insights into endpoint activity, alert trends, and PowerShell executions, completing the visualization layer of the SOC telemetry pipeline.