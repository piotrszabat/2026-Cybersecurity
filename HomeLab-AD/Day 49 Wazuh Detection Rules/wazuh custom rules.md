# Wazuh Custom Detection Rules

## Objective

The objective of Day 49 was to begin **detection engineering** in the homelab by creating custom **Wazuh** rules for suspicious Windows activity.

Until this point, the lab had already been collecting endpoint telemetry through:

* Wazuh agents
* Sysmon
* Windows Security logs
* PowerShell operational logs
* File Integrity Monitoring

The next step was to use that telemetry to build custom detections for high-signal behaviors.

The detection scenarios implemented during this day were:

1. PowerShell encoded command execution
2. Suspicious process execution
3. Windows user account creation

---

## Lab Architecture

Current lab architecture:

```text
NET-CORP
├─ DC01
├─ PC01
└─ SRV01

NET-SOC
├─ WAZ01
└─ SPLK01
```

Detection flow for Day 49:

```text
Windows Endpoint
   ↓
Sysmon + Windows Logs
   ↓
Wazuh Agent
   ↓
WAZ01
   ↓
Custom Detection Rules
   ↓
Alert
```

This day focused on transforming collected telemetry into actionable detections.

---

## Step 1 — Confirm Telemetry Visibility

Before creating custom rules, the first step was to confirm that endpoint telemetry was still reaching Wazuh correctly.

In the Wazuh dashboard, events from individual systems were reviewed using filters such as:

```text
agent.name: PC01
```

Visible telemetry included:

* Sysmon events
* Windows Security logs
* PowerShell activity

This step confirmed that the data pipeline was working and that detection rules would have the required log sources to evaluate.

---

## Step 2 — Access the Wazuh Custom Rule File

Custom detection rules in Wazuh were added on the Wazuh manager host (**WAZ01**).

The local custom rule file used for this purpose was:

```text
/var/ossec/etc/rules/local_rules.xml
```

The file was opened on WAZ01 using:

```bash
sudo nano /var/ossec/etc/rules/local_rules.xml
```

This file is used for custom rule development so that user-created detections are preserved separately from built-in Wazuh rules.

---

## Step 3 — Create a Rule for PowerShell Encoded Commands

The first custom rule was designed to detect **PowerShell encoded command execution**.

This is an important detection because attackers frequently use:

* `-enc`
* `-EncodedCommand`

to hide PowerShell payloads and make command lines less readable.

The following rule was added:

```xml
<group name="windows,powershell,attack">
  <rule id="100001" level="10">
    <if_sid>61603</if_sid>
    <match>-enc</match>
    <description>PowerShell encoded command execution detected</description>
    <mitre>
      <id>T1059.001</id>
    </mitre>
  </rule>
</group>
```

This rule detects encoded PowerShell execution and maps the behavior to **MITRE ATT&CK T1059.001**.

---

## Step 4 — Create a Rule for Suspicious Process Execution

The second custom rule focused on suspicious command-line activity.

A simple but effective starting point was to detect execution of:

* `cmd.exe`

The rule added was:

```xml
<group name="windows,process_monitoring,attack">
  <rule id="100002" level="8">
    <match>cmd.exe</match>
    <description>Suspicious command shell execution detected</description>
    <mitre>
      <id>T1059</id>
    </mitre>
  </rule>
</group>
```

This rule provides a basic process execution detection and maps to **MITRE ATT&CK T1059**.

In a larger environment this rule would later be tuned further to reduce false positives, but for the lab it provided a strong initial proof of concept.

---

## Step 5 — Create a Rule for Windows Account Creation

The third custom rule was designed to detect **new Windows account creation**.

Windows logs **Event ID 4720** when a new user account is created, making it a good event for detection engineering practice.

The following rule was added:

```xml
<group name="windows,account_management,attack">
  <rule id="100003" level="12">
    <if_sid>60103</if_sid>
    <field name="win.system.eventID">4720</field>
    <description>New Windows user account created</description>
    <mitre>
      <id>T1136</id>
    </mitre>
  </rule>
</group>
```

This detection identifies account creation activity and maps to **MITRE ATT&CK T1136**.

Because account creation is a high-value event in a SOC environment, this rule was assigned a higher severity level.

---

## Step 6 — Restart the Wazuh Manager

After adding the new rules, the Wazuh manager was restarted so the changes could be loaded.

The following command was used on WAZ01:

```bash
sudo systemctl restart wazuh-manager
```

The service status was then verified:

```bash
sudo systemctl status wazuh-manager
```

This confirmed that the manager restarted successfully and that the new custom detection rules were active.

---

## Step 7 — Test PowerShell Encoded Command Detection

The first detection test was performed on **PC01**.

A PowerShell encoded command was executed:

```powershell
powershell -EncodedCommand YwBhAGwAYwA=
```

This simulated suspicious PowerShell behavior and was expected to trigger the custom encoded command rule.

After running the command, the Wazuh dashboard was checked for the alert:

```text
PowerShell encoded command execution detected
```

The detection appeared successfully, confirming that the first rule worked as intended.

---

## Step 8 — Test Suspicious Process Detection

The second validation test focused on suspicious process execution.

On **PC01**, a command shell was launched:

```powershell
cmd.exe
```

This activity triggered the custom process execution rule.

The resulting alert confirmed that Wazuh was successfully identifying the monitored process behavior.

---

## Step 9 — Test Windows Account Creation Detection

The third validation scenario was performed on **DC01**.

A new local account was created:

```powershell
net user labadmin Password123! /add
```

The account was then added to the administrators group:

```powershell
net localgroup administrators labadmin /add
```

This generated a Windows account creation event and triggered the corresponding Wazuh detection.

The alert confirmed successful detection of the new user creation activity.

---

## Step 10 — Verify Detection Coverage in Wazuh

After all three tests were completed, the Wazuh dashboard was reviewed to verify that each rule had fired correctly.

Confirmed detections:

| Detection Scenario           | Trigger Example              |
| ---------------------------- | ---------------------------- |
| PowerShell encoded command   | `powershell -EncodedCommand` |
| Suspicious process execution | `cmd.exe`                    |
| Windows account creation     | `net user ... /add`          |

This step confirmed that custom rules were successfully processing endpoint telemetry and generating alerts for the desired behaviors.

---

## Step 11 — MITRE ATT&CK Mapping

The custom detections were mapped to relevant MITRE ATT&CK techniques:

| Activity                   | MITRE ATT&CK Technique |
| -------------------------- | ---------------------- |
| PowerShell encoded command | T1059.001              |
| Command shell execution    | T1059                  |
| Account creation           | T1136                  |

Including MITRE ATT&CK references improves the quality of detection documentation and aligns the homelab more closely with real SOC and detection engineering practices.

---

## Outcome

Day 49 successfully introduced **custom detection engineering** into the SOC homelab.

Instead of only collecting logs, the lab now actively detects suspicious Windows behaviors through custom Wazuh rules.

The environment can now identify:

* encoded PowerShell command execution
* suspicious command shell activity
* creation of new Windows user accounts

This represents an important shift from telemetry collection to alert logic development.

---

## Skills Demonstrated

* Wazuh custom rule creation
* detection engineering
* Windows event analysis
* PowerShell telemetry analysis
* account activity monitoring
* MITRE ATT&CK mapping
* alert validation in a SOC workflow

---

## Day 49 Summary

Custom Wazuh detection rules were created to identify PowerShell encoded commands, suspicious process execution, and Windows account creation. The rules were added to `local_rules.xml`, the Wazuh manager was restarted, and each detection was validated through simulated activity on Windows endpoints. This day established a practical foundation for detection engineering in the homelab.

---

## Example Detection Rules

```xml
<group name="windows,powershell,attack">
  <rule id="100001" level="10">
    <if_sid>61603</if_sid>
    <match>-enc</match>
    <description>PowerShell encoded command execution detected</description>
    <mitre>
      <id>T1059.001</id>
    </mitre>
  </rule>
</group>

<group name="windows,process_monitoring,attack">
  <rule id="100002" level="8">
    <match>cmd.exe</match>
    <description>Suspicious command shell execution detected</description>
    <mitre>
      <id>T1059</id>
    </mitre>
  </rule>
</group>

<group name="windows,account_management,attack">
  <rule id="100003" level="12">
    <if_sid>60103</if_sid>
    <field name="win.system.eventID">4720</field>
    <description>New Windows user account created</description>
    <mitre>
      <id>T1136</id>
    </mitre>
  </rule>
</group>
```

---

## Validation Commands

### PowerShell Encoded Command

```powershell
powershell -EncodedCommand YwBhAGwAYwA=
```

### Suspicious Process Execution

```powershell
cmd.exe
```

### Windows Account Creation

```powershell
net user labadmin Password123! /add
net localgroup administrators labadmin /add
```

---

## GitHub Summary Sentence

```text
Created custom Wazuh detection rules to identify PowerShell encoded commands, suspicious process execution, and Windows account creation, then validated each rule through simulated activity on Windows endpoints.
```

If you want, I can also prepare a matching **LinkedIn post for Day 49** in the same style as your earlier homelab posts.
