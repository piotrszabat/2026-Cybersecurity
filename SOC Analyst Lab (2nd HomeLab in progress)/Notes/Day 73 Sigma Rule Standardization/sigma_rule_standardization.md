# Day 73 — Sigma Rule Standardization

## Objective

Rewrite existing lab detections into Sigma format and validate which log fields are required for effective detection logic.

## Detections Selected

- brute force / repeated failed logons
- PowerShell abuse

## Detection 1 — Brute Force

### Purpose
Detect failed logon events associated with brute force or password spraying activity.

### Log Source

```yaml
logsource:
  product: windows
  service: security
```

### Important Fields

- EventID
- TargetUserName
- IpAddress
- ComputerName

### Sigma Rule

```yaml
title: Multiple Failed Logon Attempts
id: DET-001
status: experimental
description: Detects repeated failed logon attempts that may indicate brute force or password spraying activity.
author: <your name>
date: 2026-04-01
logsource:
  product: windows
  service: security
detection:
  selection:
    EventID: 4625
  condition: selection
fields:
  - TargetUserName
  - IpAddress
  - WorkstationName
  - ComputerName
level: medium
tags:
  - attack.credential_access
  - attack.t1110
```

## Detection 2 — PowerShell Abuse

### Purpose
Detect suspicious PowerShell execution using process image and command-line indicators.

### Log Source

```yaml
logsource:
  product: windows
  category: process_creation
```

### Important Fields

- Image
- CommandLine
- ParentImage
- User

### Sigma Rule

```yaml
title: Suspicious PowerShell Execution
id: DET-002
status: experimental
description: Detects suspicious PowerShell execution based on process image and command-line content.
author: <your name>
date: 2026-04-01
logsource:
  product: windows
  category: process_creation
detection:
  selection_img:
    Image|endswith:
      - '\powershell.exe'
      - '\pwsh.exe'
  selection_cmd:
    CommandLine|contains:
      - 'EncodedCommand'
      - 'Invoke-WebRequest'
      - 'IEX'
      - 'DownloadString'
  condition: selection_img and selection_cmd
fields:
  - Image
  - CommandLine
  - ParentImage
  - User
level: high
tags:
  - attack.execution
  - attack.t1059
  - attack.t1059.001
```

## Field Validation Notes

- Sigma uses normalized field names such as EventID, Image, and CommandLine.
- In the lab backend, these may appear under platform-specific paths such as `data.win.eventdata.image` or `data.win.eventdata.commandLine`.
- Field mapping is required when converting Sigma logic into backend-specific detections.

## Engineering Notes

- Brute force thresholding is often implemented in the SIEM backend rather than the base Sigma rule.
- PowerShell detection depends on high-quality process creation telemetry with command-line visibility.

## Outcome

Two core detections were standardized in Sigma format, improving understanding of log sources, metadata, and field requirements for platform-independent detection logic.

## Skills Demonstrated

- Sigma rule authoring
- detection standardization
- ATT&CK metadata tagging
- field validation
- backend field mapping awareness
- detection engineering methodology