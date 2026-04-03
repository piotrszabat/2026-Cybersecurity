# Endpoint Threat Hunting — Hunt 01

## Objective

The objective of Day 50 was to move from alert-based detection into **proactive endpoint threat hunting** using telemetry collected in **Wazuh**.

By this stage, the homelab already included:

* Wazuh agents on Windows endpoints
* Sysmon telemetry
* Windows Security logs
* PowerShell operational logs
* File Integrity Monitoring
* custom Wazuh detection rules

The goal for this day was to manually investigate endpoint activity and search for suspicious behavior even when no specific alert had been triggered yet.

The hunting scenarios performed during this day focused on:

1. Rare process execution
2. PowerShell download activity
3. Credential dumping indicators

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

Telemetry sources available for hunting:

```text
Sysmon
Windows Security Logs
PowerShell Logs
Wazuh Alerts
File Integrity Monitoring
```

Threat hunting workflow:

```text
Windows Endpoints
   ↓
Sysmon / Windows Logs
   ↓
Wazuh Agent
   ↓
WAZ01
   ↓
Wazuh Dashboard
   ↓
Threat Hunting Queries
```

This day focused on using existing telemetry to identify suspicious patterns through manual analysis.

---

## Step 1 — Access the Wazuh Dashboard

The first step was to access the **Wazuh dashboard** and open the main event analysis view.

Navigation path:

```text
Security events
```

This view was used as the primary interface for all threat hunting activity.

The dashboard provided visibility into:

* endpoint events
* Sysmon process creation logs
* PowerShell operational logs
* Windows Security telemetry

---

## Step 2 — Set an Investigation Time Window

Threat hunting was performed over a broader time window than a normal alert review.

The investigation timeframe was adjusted to:

```text
Last 24 hours
```

or, when needed:

```text
Last 7 days
```

Using a wider time range made it easier to identify low-frequency behaviors and compare normal versus unusual endpoint activity.

---

## Step 3 — Hunt for Rare Processes

The first hunting scenario focused on identifying **rare or uncommon processes**.

Rare process execution can indicate:

* attacker tooling
* administrative misuse
* one-off suspicious activity
* unusual binaries running on endpoints

To investigate this, Sysmon process creation events were reviewed using queries such as:

```text
rule.groups: sysmon
```

or:

```text
sysmon.event_id:1
```

The analysis then focused on process names and command-line activity to identify low-frequency events.

Special attention was given to processes such as:

* `certutil.exe`
* `wmic.exe`
* `rundll32.exe`
* `powershell.exe`
* `cmd.exe`

These utilities are commonly used in legitimate administration but are also frequently abused by attackers.

---

## Step 4 — Simulate Rare Process Activity

To validate the hunting workflow, a test command was executed on **PC01**.

Example test activity included:

```powershell
whoami
```

and optionally:

```powershell
certutil -urlcache -f http://example.com test.txt
```

After generating the activity, the Wazuh dashboard was reviewed again and the process creation event became visible in endpoint telemetry.

This validated that the environment was capable of supporting rare process hunting.

---

## Step 5 — Hunt for PowerShell Download Activity

The second hunting scenario focused on suspicious **PowerShell download behavior**.

Attackers frequently use PowerShell to download payloads, scripts, or remote tools through commands such as:

* `Invoke-WebRequest`
* `DownloadString`
* `IEX`
* `New-Object Net.WebClient`

To investigate this behavior, PowerShell-related telemetry was searched using filters such as:

```text
powershell
```

or:

```text
win.system.providerName: Microsoft-Windows-PowerShell
```

The analysis looked for suspicious strings within PowerShell execution logs, especially evidence of remote content retrieval.

---

## Step 6 — Simulate PowerShell Download Activity

To test this hunting scenario, PowerShell download behavior was simulated on **PC01**.

Example command:

```powershell
Invoke-WebRequest http://example.com -OutFile test.txt
```

Another possible test:

```powershell
(New-Object Net.WebClient).DownloadString("http://example.com")
```

After running the command, the Wazuh dashboard was searched again and PowerShell activity related to network retrieval became visible.

This confirmed that the telemetry pipeline provided enough visibility for PowerShell hunting.

---

## Step 7 — Hunt for Credential Dumping Indicators

The third hunting scenario focused on possible **credential dumping behavior**.

In Windows environments, credential dumping commonly involves interaction with:

* `lsass.exe`
* memory dumping tools
* suspicious process access
* utilities such as `procdump` or `rundll32`

To investigate this, searches were performed for terms such as:

```text
lsass.exe
```

and:

```text
process.command_line: lsass
```

The objective was to identify telemetry suggesting access to credential-related processes or activity that could resemble reconnaissance or credential theft preparation.

---

## Step 8 — Simulate Credential Access Activity

To safely simulate credential-related process visibility, a lightweight test was executed on **PC01**.

Example:

```powershell
tasklist | findstr lsass
```

Additional process-related activity such as launching:

```powershell
rundll32.exe
```

could also be used to generate related telemetry.

After the test was executed, the Wazuh dashboard was reviewed again and LSASS-related process visibility was confirmed in the endpoint logs.

This did not perform credential dumping, but it created a safe hunting scenario for identifying credential-access-related artifacts.

---

## Step 9 — Document the Hunting Results

Each hunt scenario was documented with the following structure:

* objective
* query used
* simulated activity
* telemetry observed
* analyst conclusion

Summary of observed results:

| Hunt Scenario                | Result                                                                        |
| ---------------------------- | ----------------------------------------------------------------------------- |
| Rare processes               | uncommon process activity such as `whoami` and optionally `certutil` observed |
| PowerShell downloads         | download-related PowerShell execution successfully identified                 |
| Credential access indicators | LSASS-related activity visible in endpoint telemetry                          |

This step reinforced an important SOC workflow principle: threat hunting should always produce an investigation record, not just screenshots or ad hoc searches.

---

## Step 10 — MITRE ATT&CK Mapping

The hunt scenarios were mapped to relevant MITRE ATT&CK techniques:

| Activity                         | MITRE ATT&CK Technique |
| -------------------------------- | ---------------------- |
| PowerShell execution             | T1059.001              |
| PowerShell download activity     | T1105                  |
| Credential dumping investigation | T1003                  |
| Process discovery                | T1057                  |

This mapping improves the quality of the documentation and better reflects real-world threat hunting methodology.

---

## Outcome

Day 50 successfully introduced **endpoint threat hunting** into the homelab workflow.

Instead of relying only on prebuilt alerts or custom detection rules, the lab was used to proactively search for suspicious patterns across endpoint telemetry.

The environment provided sufficient visibility to investigate:

* rare process execution
* suspicious PowerShell download behavior
* potential credential access indicators

This marked an important progression from log collection and rule writing into analyst-driven security investigation.

---

## Skills Demonstrated

* endpoint threat hunting
* Wazuh telemetry analysis
* process investigation
* PowerShell activity analysis
* credential access investigation
* manual log review
* MITRE ATT&CK mapping
* SOC analytical workflow

---

## Day 50 Summary

Endpoint threat hunting was performed using Wazuh telemetry collected from Windows endpoints. The investigation focused on rare process execution, suspicious PowerShell download activity, and credential-access-related behavior. Test activity was generated on lab endpoints, relevant telemetry was identified in the Wazuh dashboard, and the results were documented as a structured hunting exercise.

---

## Hunt Scenario 1 — Rare Processes

### Objective

Identify uncommon or low-frequency process execution across Windows endpoints.

### Query Used

```text
sysmon.event_id:1
```

### Test Activity

```powershell
whoami
```

Optional additional test:

```powershell
certutil -urlcache -f http://example.com test.txt
```

### Result

Rare process activity was visible in Sysmon process creation telemetry and could be reviewed in Wazuh for further analysis.

---

## Hunt Scenario 2 — PowerShell Download Activity

### Objective

Identify PowerShell commands consistent with file download or remote content retrieval.

### Query Used

```text
win.system.providerName: Microsoft-Windows-PowerShell
```

### Test Activity

```powershell
Invoke-WebRequest http://example.com -OutFile test.txt
```

Alternative:

```powershell
(New-Object Net.WebClient).DownloadString("http://example.com")
```

### Result

PowerShell download-related activity was successfully observed in endpoint telemetry and validated in the Wazuh dashboard.

---

## Hunt Scenario 3 — Credential Dumping Indicators

### Objective

Investigate activity involving LSASS or process behavior associated with credential access.

### Query Used

```text
process.command_line: lsass
```

### Test Activity

```powershell
tasklist | findstr lsass
```

### Result

LSASS-related process visibility was confirmed, demonstrating that the telemetry pipeline supports credential-access-oriented hunting.

---

## GitHub Summary Sentence

```text
Performed endpoint threat hunting using Wazuh telemetry by investigating rare processes, suspicious PowerShell download activity, and credential-access-related behavior across Windows endpoints.
```
