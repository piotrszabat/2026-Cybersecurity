# Day 51 — Wazuh to Splunk Integration

## Objective

The goal of Day 51 was to integrate the **endpoint detection platform (Wazuh)** with the **SIEM platform (Splunk Enterprise)**.

Until this point, endpoint telemetry was only analyzed by Wazuh.

Previous telemetry flow:

```
Endpoints → Wazuh
```

After completing this integration, the architecture evolved into a full **SOC telemetry pipeline**:

```
Endpoints → Wazuh → Splunk
```

This step simulates a real-world **Security Operations Center architecture**, where endpoint detection data is centralized and analyzed inside a SIEM.

---

# Lab Environment

The SOC lab network consists of two main segments.

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

| System | Role                            |
| ------ | ------------------------------- |
| DC01   | Domain Controller               |
| PC01   | Windows endpoint                |
| SRV01  | Windows server                  |
| WAZ01  | Wazuh server (EDR/XDR platform) |
| SPLK01 | Splunk Enterprise SIEM          |

---

# Telemetry Architecture

The telemetry pipeline after the integration:

```
DC01 / PC01 / SRV01
        ↓
    Wazuh Agents
        ↓
       WAZ01
        ↓
/var/ossec/logs/alerts/alerts.json
        ↓
 Splunk Universal Forwarder
        ↓
       SPLK01
        ↓
        SIEM Analysis
```

Wazuh analyzes endpoint activity and generates alerts stored in:

```
/var/ossec/logs/alerts/alerts.json
```

These alerts are forwarded to Splunk for centralized analysis.

---

# Step 1 — Verify Wazuh Alerts

Before configuring the integration, it was necessary to confirm that Wazuh was generating alerts.

Command used on **WAZ01**:

```bash
ls -lh /var/ossec/logs/alerts/
tail -n 5 /var/ossec/logs/alerts/alerts.json
```

This verified:

* the alert file exists
* alerts are written in JSON format
* endpoint activity is being analyzed

---

# Step 2 — Verify Splunk Availability

On **SPLK01**, the Splunk web interface was verified.

```
http://<SPLK01-IP>:8000
```

The **Search & Reporting** app confirmed that the Splunk instance was operational.

---

# Step 3 — Configure Splunk Receiving Port

To allow log forwarding, Splunk was configured to receive data.

Navigation path:

```
Settings → Forwarding and receiving → Receive data
```

Receiving port configured:

```
9997/TCP
```

This port accepts data from **Splunk Universal Forwarders**.

---

# Step 4 — Create Splunk Index

A dedicated index was created for Wazuh alerts.

Navigation:

```
Settings → Indexes → New Index
```

Index name:

```
wazuh-alerts
```

This index stores all Wazuh telemetry inside Splunk.

---

# Step 5 — Configure Network Access

Firewall rules were verified to allow communication between the systems.

Required rule:

```
Source: WAZ01
Destination: SPLK01
Port: 9997/TCP
```

This allows the Splunk Forwarder to send telemetry to the SIEM.

---

# Step 6 — Install Splunk Universal Forwarder

The **Splunk Universal Forwarder** was installed on **WAZ01**.

Installation:

```bash
sudo dpkg -i splunkforwarder-<version>-linux-amd64.deb
```

Start and enable the forwarder:

```bash
sudo /opt/splunkforwarder/bin/splunk start --accept-license
sudo /opt/splunkforwarder/bin/splunk enable boot-start
```

The forwarder is installed in:

```
/opt/splunkforwarder
```

---

# Step 7 — Configure inputs.conf

The forwarder was configured to monitor Wazuh alerts.

File:

```
/opt/splunkforwarder/etc/system/local/inputs.conf
```

Configuration:

```ini
[monitor:///var/ossec/logs/alerts/alerts.json]
disabled = 0
host = WAZ01
index = wazuh-alerts
sourcetype = wazuh-alerts
```

This instructs Splunk to monitor the Wazuh alert file.

---

# Step 8 — Configure outputs.conf

Next, the forwarder was configured to send logs to Splunk.

File:

```
/opt/splunkforwarder/etc/system/local/outputs.conf
```

Configuration:

```ini
[tcpout]
defaultGroup = default-autolb-group

[tcpout:default-autolb-group]
server = <SPLK01-IP>:9997

[tcpout-server://<SPLK01-IP>:9997]
```

This defines the SIEM destination.

---

# Step 9 — Restart Forwarder

After configuration, the forwarder was restarted.

```bash
sudo /opt/splunkforwarder/bin/splunk restart
```

Connection verification:

```bash
sudo /opt/splunkforwarder/bin/splunk list forward-server
```

Expected output:

```
Active forwards:
<SPLK01-IP>:9997
```

---

# Step 10 — Generate Test Alerts

To validate the pipeline, endpoint activity was generated.

Example actions on **PC01**:

```
powershell -EncodedCommand YwBhAGwAYwA=
cmd.exe
```

These actions generated Wazuh alerts which were written to `alerts.json`.

---

# Step 11 — Verify Logs in Splunk

Splunk search query used:

```
index="wazuh-alerts"
```

Additional query for statistics:

```
index="wazuh-alerts"
| stats count by rule.description, agent.name
| sort - count
```

This confirmed:

* alerts are being ingested
* endpoint telemetry is searchable
* multiple hosts are reporting events

---

# Final Telemetry Pipeline

The completed telemetry pipeline:

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
Security Monitoring & Threat Hunting
```

---

# Skills Demonstrated

This lab step demonstrates several core SOC engineering skills:

* SIEM integration
* Endpoint telemetry forwarding
* Splunk Universal Forwarder configuration
* Log pipeline architecture
* Detection telemetry validation
* SOC infrastructure design

---

# Outcome

Wazuh alerts were successfully forwarded to Splunk, allowing endpoint security telemetry to be analyzed inside the SIEM.

This integration transformed the lab environment into a **multi-layer SOC detection architecture** rather than a collection of standalone security tools.

---

# Screenshots

Recommended screenshots for documentation:

```
day51_01_wazuh_alerts_json.png
day51_02_splunk_ready.png
day51_03_splunk_receiving_port.png
day51_04_wazuh_alerts_index.png
day51_05_fw_rule_wazuh_to_splunk.png
day51_06_splunk_uf_installed.png
day51_07_splunk_uf_started.png
day51_08_inputs_conf.png
day51_09_outputs_conf.png
day51_10_forward_server_status.png
day51_11_generate_wazuh_alerts.png
day51_12_splunk_wazuh_search.png
day51_13_splunk_wazuh_stats.png
day51_14_pipeline_validation.png
```

---

# Summary

Day 51 completed the integration of **Wazuh and Splunk**, enabling centralized security monitoring and extending the lab into a realistic **SOC telemetry pipeline**.
