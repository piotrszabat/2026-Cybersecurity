# Day 47 — Sysmon and Wazuh Integration

## Objective

The objective of Day 47 was to expand endpoint visibility in the lab by integrating **Sysmon telemetry** with **Wazuh**.

This was done by updating the Wazuh agent configuration on Windows endpoints so that Wazuh could collect and forward:

* Sysmon logs
* PowerShell operational logs
* default Windows Security logs

The goal was to improve telemetry quality and prepare the environment for more advanced detection and monitoring scenarios.

---

# Environment Overview

The current lab environment consists of the following systems:

```text
NET-CORP
├─ DC01
├─ PC01
└─ SRV01

NET-SOC
├─ WAZ01
└─ SPLK01
```

Telemetry flow after integration:

```text
Windows endpoints
   ↓
Wazuh agents
   ↓
WAZ01
   ↓
Wazuh dashboard
```

This configuration allows endpoint activity generated on Windows systems to be collected by the Wazuh agents and forwarded to the Wazuh platform for analysis and visualization.

---

# Step 1 — Confirm Sysmon installation on endpoints

The first step was to verify that **Sysmon** was already installed on the target Windows systems.

This was checked on:

* DC01
* PC01
* SRV01

PowerShell command used:

```powershell
Get-Service Sysmon64
```

Additionally, the Sysmon event channel was verified in Event Viewer:

```text
Applications and Services Logs
→ Microsoft
→ Windows
→ Sysmon
→ Operational
```

This confirmed that Sysmon was installed and generating logs locally on the endpoints.

---

# Step 2 — Verify Wazuh agent health

Before editing any configuration files, the Wazuh agents were checked to confirm they were active and still communicating with the Wazuh server.

Validation methods:

* confirmed agents were active in the Wazuh dashboard
* verified the Wazuh agent service locally on each endpoint

PowerShell command used:

```powershell
Get-Service wazuhsvc
```

This confirmed that the Wazuh agent service was running on all monitored systems.

---

# Step 3 — Review default Wazuh Windows log collection

Before making changes, it was noted that the Wazuh Windows agent already collects some event channels by default.

Default baseline collection includes:

* System
* Application
* Security

For this day, the configuration was extended by manually adding:

* Microsoft-Windows-Sysmon/Operational
* Microsoft-Windows-PowerShell/Operational

This expanded endpoint visibility beyond the default Windows event collection baseline.

---

# Step 4 — Locate the Wazuh agent configuration file

On each Windows endpoint, the Wazuh agent configuration file was opened and reviewed.

Configuration file path:

```text
C:\Program Files (x86)\ossec-agent\ossec.conf
```

The file was opened with administrative privileges to allow editing of the Windows event channel collection settings.

Example command:

```powershell
notepad "C:\Program Files (x86)\ossec-agent\ossec.conf"
```

---

# Step 5 — Add Sysmon event channel collection

To enable Sysmon log forwarding into Wazuh, the following block was added to the `ossec.conf` file:

```xml
<localfile>
  <location>Microsoft-Windows-Sysmon/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

This change allowed the Wazuh agent to read events from the Sysmon operational channel and forward them to the Wazuh server.

The configuration was applied on all planned Windows endpoints.

---

# Step 6 — Add PowerShell operational log collection

To improve visibility into PowerShell activity, the following block was also added to the Wazuh agent configuration:

```xml
<localfile>
  <location>Microsoft-Windows-PowerShell/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

This addition enabled collection of PowerShell operational logs, which are especially useful for monitoring command execution and script activity on Windows hosts.

---

# Step 7 — Preserve Security log collection baseline

The Windows Security log channel remained part of the standard Wazuh event collection baseline.

This means that Security logs did not require additional manual configuration, while Sysmon and PowerShell logs were explicitly added to enhance endpoint telemetry.

This provided a stronger Windows monitoring baseline across the lab.

---

# Step 8 — Restart the Wazuh agent

After updating the `ossec.conf` file, the Wazuh agent service was restarted on each endpoint so the new configuration could be applied.

PowerShell command used:

```powershell
Restart-Service -Name wazuh
```

Service validation command:

```powershell
Get-Service wazuhsvc
```

The service returned to the **Running** state after restart, confirming that the updated configuration was loaded successfully.

---

# Step 9 — Generate test telemetry

To validate the new telemetry collection, light activity was generated on the Windows endpoints.

Commands used included:

```powershell
whoami
hostname
Get-Process | Select-Object -First 10
ipconfig
```

Additional built-in tools were launched to generate clearer process-related events:

```powershell
notepad
cmd /c echo test
```

These actions created local events in the Sysmon and PowerShell channels, which were expected to be collected by Wazuh after the configuration update.

---

# Step 10 — Verify local events in Event Viewer

Before checking the Wazuh dashboard, logs were validated locally on the Windows systems using Event Viewer.

Reviewed channels:

### Sysmon

```
Applications and Services Logs
→ Microsoft
→ Windows
→ Sysmon
→ Operational
```

### PowerShell

```
Applications and Services Logs
→ Microsoft
→ Windows
→ PowerShell
→ Operational
```

### Security

```
Windows Logs
→ Security
```

This confirmed that the expected telemetry was being generated locally before validating collection in Wazuh.

---

# Step 11 — Verify events in Wazuh

After restarting the Wazuh agents and generating endpoint activity, the Wazuh dashboard was used to verify that the events were being collected successfully.

Relevant location in the dashboard:
Security events → Events

Search examples used:
agent.name:PC01
agent.name:DC01
agent.name:SRV01


The dashboard showed event data from the configured channels, confirming that Sysmon, PowerShell, and Security-related telemetry was reaching the Wazuh platform successfully.

---

# Step 12 — Troubleshooting and validation

During validation, the following troubleshooting points were used when needed:

* verify correct XML syntax in `ossec.conf`
* confirm exact event channel names
* restart the Wazuh agent after configuration changes
* confirm local events exist in Event Viewer first
* review the local Wazuh agent log if forwarding issues occur

Wazuh agent log path:

```text
C:\Program Files (x86)\ossec-agent\ossec.log
```

This troubleshooting approach helped confirm whether issues were related to Windows logging, Wazuh configuration, or agent service state.

---

# Outcome

Sysmon telemetry was successfully integrated into Wazuh across the Windows endpoints in the lab.

The following event sources are now part of the endpoint monitoring pipeline:

* Sysmon Operational logs
* PowerShell Operational logs
* Windows Security logs

As a result, the lab now provides significantly stronger endpoint visibility and a more realistic telemetry foundation for future detection engineering, threat hunting, and security monitoring exercises.

---

# Skills Demonstrated

* Wazuh Windows agent configuration
* Sysmon integration with Wazuh
* Windows event channel monitoring
* PowerShell telemetry collection
* endpoint visibility engineering
* validation and troubleshooting of telemetry pipelines

---

# Next Step

The next phase of the lab can build on this telemetry by implementing **File Integrity Monitoring (FIM)** in Wazuh or creating detection scenarios based on Sysmon and PowerShell events.

---

# Short GitHub-ready summary

Integrated Sysmon and PowerShell telemetry with Wazuh by updating the Windows agent configuration, restarting the agents, generating endpoint activity, and validating that Sysmon, Security, and PowerShell events were visible in the Wazuh dashboard.
