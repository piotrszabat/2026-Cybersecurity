# Day 48 — File Integrity Monitoring with Wazuh

## Objective

The objective of Day 48 was to enable **File Integrity Monitoring (FIM)** using **Wazuh** in order to detect unauthorized or unexpected changes to critical files and Windows registry locations across monitored endpoints.

At this stage of the lab, the environment already included:

* active Wazuh server (**WAZ01**)
* enrolled Windows agents (**DC01**, **PC01**, **SRV01**)
* endpoint telemetry from **Sysmon**
* Windows Security and PowerShell event collection

The goal for this day was to extend endpoint visibility by monitoring **file system and registry changes**.

---

# Lab Architecture

Current lab architecture:

```
NET-CORP
├─ DC01
├─ PC01
└─ SRV01

NET-SOC
├─ WAZ01
└─ SPLK01
```

Telemetry pipeline:

```
Windows Endpoint
   ↓
Wazuh Agent (FIM)
   ↓
WAZ01
   ↓
Wazuh Dashboard Alerts
```

---

# Step 1 — Verify Wazuh Agent Health

Before modifying the configuration, the status of the Wazuh agents was verified.

On each Windows endpoint the agent service was checked:

```powershell
Get-Service wazuhsvc
```

All endpoints returned the service status as **Running**, confirming that the agents were operational and ready to receive configuration updates.

Agents confirmed:

* DC01
* PC01
* SRV01

---

# Step 2 — Access Wazuh Agent Configuration

The Wazuh agent configuration file on Windows endpoints is located at:

```
C:\Program Files (x86)\ossec-agent\ossec.conf
```

The configuration file was opened with administrative privileges using:

```powershell
notepad "C:\Program Files (x86)\ossec-agent\ossec.conf"
```

This file contains configuration settings for multiple modules including:

* log collection
* Sysmon integration
* File Integrity Monitoring

---

# Step 3 — Configure the FIM Module

Wazuh File Integrity Monitoring is configured inside the `<syscheck>` section of the agent configuration.

The module was enabled and configured to monitor important Windows directories and registry locations.

Example configuration:

```xml
<syscheck>
  <disabled>no</disabled>
  <frequency>300</frequency>

  <directories realtime="yes">C:\Windows\System32</directories>
  <directories realtime="yes">C:\Users</directories>

  <windows_registry>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run</windows_registry>
  <windows_registry>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce</windows_registry>
  <windows_registry>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services</windows_registry>
  <windows_registry>HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon</windows_registry>

</syscheck>
```

Key configuration decisions:

* **Realtime monitoring enabled** for directories
* **Scan frequency reduced to 300 seconds** for faster lab validation
* Monitoring of **critical persistence-related registry keys**

---

# Step 4 — Restart the Wazuh Agent

After updating the configuration file, the Wazuh agent service was restarted to apply the changes.

```powershell
Restart-Service wazuhsvc
```

Service status was verified again:

```powershell
Get-Service wazuhsvc
```

The service returned **Running**, confirming that the updated configuration was successfully loaded.

---

# Step 5 — Baseline Initialization

After the restart, the Wazuh agent began performing an initial **baseline scan** of the monitored directories and registry locations.

During this phase the agent stores:

* file metadata
* file checksums
* file attributes
* registry key values

This baseline is later used to detect:

* file creation
* file modification
* file deletion
* registry changes

---

# Step 6 — Test File Change Detection

To validate the configuration, a test file was created in a monitored directory.

Test executed on **PC01**:

```powershell
New-Item -Path "C:\Users\Public\fim_test.txt" -ItemType File
```

File modification was then performed:

```powershell
Add-Content -Path "C:\Users\Public\fim_test.txt" -Value "FIM test on Day 48"
Add-Content -Path "C:\Users\Public\fim_test.txt" -Value "Second change"
```

These actions generated file creation and modification events within a monitored path.

---

# Step 7 — Verify Detection in Wazuh

After generating the test activity, the Wazuh dashboard was used to verify the detection.

Filtering by endpoint:

```
agent.name: PC01
```

The platform successfully generated alerts indicating:

* file added
* file modified

This confirmed that the File Integrity Monitoring module was functioning correctly and detecting changes in monitored directories.

---

# Outcome

File Integrity Monitoring was successfully implemented in the SOC homelab environment.

The system is now capable of detecting:

* unauthorized file changes
* suspicious file creation
* modification of important system directories
* changes in persistence-related Windows registry keys

This significantly improves endpoint visibility and detection capabilities within the lab.

---

# Skills Demonstrated

* Wazuh File Integrity Monitoring configuration
* Windows endpoint monitoring
* registry monitoring
* configuration validation and troubleshooting
* security alert verification
* SOC telemetry pipeline development

---

# Day 48 Summary

File Integrity Monitoring was enabled on Windows endpoints by configuring the **syscheck module** in the Wazuh agent. Critical directories and registry locations were added to the monitoring scope, and the configuration was validated by modifying a monitored file and confirming that the resulting alert appeared in the Wazuh dashboard.
