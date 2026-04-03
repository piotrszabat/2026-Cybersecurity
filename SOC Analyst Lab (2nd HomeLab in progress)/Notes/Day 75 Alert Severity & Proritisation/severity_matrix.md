# SOC Severity Matrix

## Objective

This document defines how alert severity is assigned in my SOC home lab.

The goal is to prioritize alerts consistently based on:
- threat likelihood
- potential impact
- affected asset value
- user privilege
- evidence of compromise
- need for response urgency

Severity must be assigned using evidence, not assumptions.

This matrix prepares me to think like a Junior SOC Analyst in a real SOC environment.

## Severity Levels

### Informational
Alerts that provide visibility but do not indicate suspicious or malicious activity by themselves.

**Examples:**
- normal service start
- expected scheduled task
- successful login from known user and host

**SOC action:**
- monitor only
- no escalation required
- retain for context

---

### Low
Alerts with minor suspicious indicators but low confidence of malicious activity and low immediate impact.

**Examples:**
- single failed login
- connection to a newly seen internal host
- low-risk policy violation

**SOC action:**
- validate event
- check surrounding context
- close if benign

---

### Medium
Alerts showing meaningful suspicious behavior that may indicate attacker activity, misuse, or early-stage compromise.

**Examples:**
- repeated failed logins
- PowerShell execution with unusual arguments
- suspicious process spawned by Office application
- brute force attempts without confirmed success

**SOC action:**
- investigate promptly
- enrich with user, host, IP, and process context
- determine if escalation is needed

---

### High
Alerts with strong indicators of compromise, attacker success, privileged activity, or significant risk to business systems.

**Examples:**
- brute force followed by successful login
- admin account creation
- lateral movement behavior
- suspicious service creation
- confirmed malicious script execution

**SOC action:**
- immediate investigation
- containment consideration
- escalate if compromise is likely

---

### Critical
Alerts indicating confirmed compromise, major business impact, widespread malicious activity, or threat to privileged/core infrastructure.

**Examples:**
- domain admin compromise
- ransomware behavior
- malware spreading across hosts
- confirmed data exfiltration
- attacker persistence on domain controller

**SOC action:**
- urgent response
- immediate escalation
- containment and incident response required

## Severity Assignment Rules

Severity is assigned using the following decision factors:

### 1. Confidence
How sure am I that this activity is suspicious or malicious?

- Low confidence → lower severity
- High confidence → higher severity

### 2. Impact
What would happen if this activity were real?

- no meaningful impact → informational / low
- user account impact → medium
- privileged account or business system impact → high / critical

### 3. Asset Value
Which system is affected?

- standard workstation → lower severity
- server / domain controller / SIEM / security tooling → higher severity

### 4. Privilege Level
Who or what is involved?

- normal user → lower severity
- local admin / domain admin / service account → higher severity

### 5. Evidence of Success
Did the suspicious action fail or succeed?

- failed attempt only → low / medium
- successful execution / login / persistence → medium / high / critical

### 6. Scope
How many users, systems, or events are affected?

- single isolated event → lower severity
- multiple hosts or repeated pattern → higher severity

### 7. Business Risk
Could this affect operations, security monitoring, identity systems, or sensitive data?

- limited business risk → lower severity
- major operational or security risk → higher severity

## Example Severity Mapping

| Alert Example | Suggested Severity | Reason |
|---|---|---|
| 1 failed login | Low | Common event, low confidence, no evidence of compromise |
| 5–10 failed logins from one source | Medium | Repeated suspicious authentication behavior |
| Brute force attempt with no success | Medium | Suspicious pattern, but no confirmed access |
| Brute force followed by successful login | High | Strong indicator of account compromise |
| Admin account creation | High | Privileged change with major security impact |
| New local admin added to endpoint | High | Potential privilege escalation or persistence |
| PowerShell encoded command | Medium / High | Depends on context, user, host, and parent process |
| Suspicious process on workstation | Medium | Requires enrichment and validation |
| Suspicious process on domain controller | High | Higher asset value and business impact |
| Malware execution confirmed | High | Confirmed malicious activity on a host |
| Ransomware-like mass file modification | Critical | High impact, likely incident in progress |
| Domain admin compromise | Critical | Identity infrastructure at immediate risk |
| Data exfiltration confirmed | Critical | Confidentiality impact and likely incident escalation |

## Response Priority by Severity

| Severity | Expected SOC Response |
|---|---|
| Informational | Record for visibility, no active response |
| Low | Validate and close if benign |
| Medium | Investigate within normal analyst workflow |
| High | Prioritize investigation immediately and consider containment |
| Critical | Escalate immediately and initiate incident response actions |

## Important Analyst Notes

- Severity is not based on fear or unusual appearance alone.
- A noisy alert is not always a high-severity alert.
- A single event on a critical asset may be more severe than many events on a normal workstation.
- Successful attacker activity is usually more severe than failed attacker activity.
- Context can raise or lower severity.
- False positives should be documented to improve future triage.

## How I Will Use This Matrix

When an alert is received:

1. Validate the alert
2. Identify the affected user and host
3. Determine whether the action failed or succeeded
4. Check if privilege or critical assets are involved
5. Estimate impact and business risk
6. Assign severity
7. Investigate or escalate based on severity

## Personal Triage Principle

I will not assign severity only from the detection title.

I will assign severity based on:
- what happened
- who was involved
- what system was affected
- whether the action succeeded
- what the impact could be

This helps reduce overreaction, improve consistency, and support evidence-based SOC decisions.