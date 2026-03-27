# Incident Response Report — Day 64

## Objective

Respond to a simulated ransomware-style attack in a homelab environment using a structured incident response workflow:

```text
identify → scope → contain → eradicate → recover
```

The goal was to demonstrate real SOC/IR analyst capabilities beyond detection, including active response and recovery validation.

---

## Environment

* SIEM: Splunk
* Endpoint Detection: Wazuh + Sysmon
* Firewall: pfSense (FW01)
* Affected host: PC01 (Windows 11)
* Supporting systems:
  * WAZ01 (Wazuh)
  * SPLK01 (Splunk)

---

# Phase 1 — Identification

## What was done

The incident was defined based on suspicious activity observed during a simulated ransomware attack (Day 63).

Detection was performed using Splunk queries on Wazuh alerts:

```spl
index="wazuh-alerts" (powershell OR cmd.exe OR "file integrity" OR modified OR created OR deleted)
| sort - _time
```

Indicators observed:

* PowerShell execution
* File creation and modification spikes
* Suspicious executable activity

## Result

A ransomware-like incident was confirmed on PC01.

---

# Phase 2 — Initial Alert Analysis

## What was done

Initial investigation focused on identifying the first alert and validating suspicious activity.

Early searches were too narrow and returned only single events (e.g., privilege-related alerts).

## Problem encountered

* Initial queries were overly specific
* Only one event was visible, which did not provide enough context
* Needed to broaden search scope to understand the full incident

## Resolution

Expanded queries to include multiple behaviors:

* process execution
* file modifications
* PowerShell activity

This allowed proper identification of the incident.

---

# Phase 3 — Scope Analysis

## What was done

Determined whether the incident affected multiple hosts:

```spl
index="wazuh-alerts" (PC01 OR SRV01 OR DC01)
| stats count by agent.name, rule.description
```

## Result

* Activity was limited to **PC01**
* No evidence of lateral movement to DC01 or SRV01

## Conclusion

This was a **single-host incident**, simplifying containment strategy.

---

# Phase 4 — Pre-Containment Timeline

## What was done

A timeline was built using Splunk:

```spl
index="wazuh-alerts" agent.name=PC01 (modified OR created OR deleted OR "file integrity")
| table _time rule.description data.win.eventdata.processName data.win.eventdata.commandLine
| sort _time
```

## Key Observations

* Executable dropped in Windows directory
* PowerShell creating multiple files
* Repeated file creation activity
* Malware-like folder usage

## Result

A clear sequence of events was established:

```text
Execution → File Drop → PowerShell Activity → Repeated File Changes
```

## Problem encountered

* Initial timeline attempts were noisy (repeated identical events)
* Needed to filter out irrelevant alerts (e.g., privilege spam)

## Resolution

Refined queries to focus on:

* file activity
* PowerShell execution
* relevant behavioral indicators

---

# Phase 5 — Containment

## What was done

The affected endpoint (PC01) was isolated using pfSense.

Firewall rule applied:

```text
Source: 192.168.10.20 (PC01)
Destination: Any
Action: Block
```

## Result

* PC01 lost connectivity to:

  * internal network (DC01, SRV01)
  * external network (internet)
* System remained powered on for analysis

## Why this approach

Network-level isolation:

* prevents lateral movement
* preserves system state
* mirrors real SOC response procedures

---

# Phase 6 — Containment Validation

## What was done

Validated containment using:

* connectivity tests (ping, web requests)
* Splunk queries for new activity

## Result

* No further network communication possible
* No new suspicious alerts observed
* Malicious activity effectively stopped

## Conclusion

Containment was successful.

---

# Phase 7 — Eradication

## What was done

Removed all simulated ransomware artifacts:

```powershell
Remove-Item "C:\Users\Public\ransomware_test\" -Recurse -Force
```

Additional checks:

* running processes (Get-Process)
* scheduled tasks (schtasks)
* local users (net user)

## Result

* All malicious test files deleted
* No suspicious processes remained
* No persistence mechanisms identified

## Problem encountered

* Needed to verify whether activity was still running before deletion
* Ensured no residual artifacts remained outside target directory

---

# Phase 8 — Persistence Check

## What was done

Verified no persistence mechanisms remained:

* user accounts
* scheduled tasks
* running processes
* remaining files (.locked)

## Result

System confirmed clean.

---

# Phase 9 — Recovery

## What was done

* Removed pfSense block rule
* Restored network connectivity
* Verified system usability

## Validation

* PC01 successfully reconnected
* User login functional
* System stable

---

# Phase 10 — Post-Recovery Validation

## What was done

Confirmed telemetry flow:

```spl
index="wazuh-alerts" agent.name=PC01
| sort - _time
```

## Result

* Logs successfully received in Splunk
* Wazuh agent operational
* No new suspicious activity detected

## Key Insight

Recovery is only complete when **visibility is restored**.

---

# Timeline Summary

```text
Detection → Alert Review → Scope Analysis → Timeline Creation → Containment → Eradication → Recovery → Validation
```

---

# Key Challenges

* Initial searches were too narrow (single-event visibility)
* Noise from repetitive alerts (privilege events)
* Required refinement of Splunk queries
* Needed to distinguish real signal from telemetry noise

---

# Key Findings

* Wazuh + Splunk provided strong visibility into endpoint behavior
* File activity was the strongest indicator of ransomware simulation
* Network isolation via pfSense was the most effective containment method
* Structured IR workflow significantly improved response clarity

---

# Outcome

The simulated ransomware incident was successfully:

* detected
* analyzed
* contained
* eradicated
* recovered

This demonstrates a full incident response lifecycle in a realistic SOC environment.

---

# Skills Demonstrated

* Incident Response (IR workflow)
* SIEM investigation (Splunk)
* Endpoint monitoring (Wazuh)
* Network containment (pfSense)
* Threat eradication
* Timeline analysis
* Recovery validation

---

# GitHub Summary

Responded to a simulated ransomware attack by building a pre-containment timeline, isolating the affected endpoint using pfSense, removing malicious artifacts, and validating full recovery through Wazuh and Splunk telemetry.
