# Alert Triage Playbook

## Objective
This playbook defines a structured workflow for triaging security alerts within a homelab SOC environment, covering alert review, event enrichment, classification, and response.

---

## Why This Playbook Exists
Security alerts in a homelab environment may represent:

- benign test activity  
- expected administrative actions  
- potentially malicious behavior  

This playbook ensures that all alerts are handled consistently, supported by evidence, and properly documented before a conclusion is made.

---

## Scope
This playbook applies to alerts generated from:

- Splunk correlation rules  
- Wazuh detections  
- Threat intelligence enrichment matches  
- Other suspicious events observed in the homelab  

---

## Homelab Environment
The workflow is implemented in a SOC-style homelab consisting of:

- Splunk (SIEM and detection platform)  
- Wazuh (endpoint detection and alerting)  
- Windows endpoints and servers  
- Threat intelligence integrations  
- Vulnerability scanning data  

---

## Core Question
> What should an analyst do when a new alert appears in the SIEM?

---

## Expected Outcome
Each alert triaged using this playbook should result in:

- validated alert review  
- enriched contextual data  
- classification decision  
- severity assessment  
- response action  
- documented analyst notes  

---

# Alert Triage Workflow

## Workflow Overview
The following workflow is used to handle alerts:

1. Alert is triggered in SIEM (Splunk/Wazuh)  
2. Analyst reviews alert metadata (host, user, IP, rule)  
3. Alert is validated against raw event data  
4. Event enrichment is performed  
5. Alert is classified  
6. Severity is assigned  
7. Response action is selected  
8. Findings are documented  
9. Alert is closed or escalated  

---

## Workflow Diagram
[Alert]
↓
[Review]
↓
[Enrichment]
↓
[Classification]
↓
[Response]
↓
[Documentation]
↓
[Close / Escalate]


---

# Classification Model

## Classification Categories
- True Positive  
- False Positive  
- Benign / Expected Activity  
- Suspicious / Needs Investigation  

## Severity Levels
- Low  
- Medium  
- High  
- Critical  

---

# Response Workflow

## Response Actions by Classification

### False Positive
- Close alert  
- Document reason  

### Benign / Expected Activity
- Close alert  
- Document justification  
- No escalation  

### Suspicious Activity
- Investigate further  
- Review related events  
- Monitor for escalation  

### True Positive (Malicious)
- Escalate incident  
- Collect evidence  
- Isolate host (in real environment)  
- Continue investigation  

---

# Example Use Case — Failed Login Alert
**Alert Name:** Multiple Failed Login Attempts  
**Host:** PC01  
**User:** Administrator  
**Source IP:** 127.0.0.1  

## Summary
Multiple failed login attempts were detected targeting the Administrator account.

## Enrichment
- Reviewed Windows Security logs (Event ID 4625)  
- Identified source IP as localhost (127.0.0.1)  
- Confirmed interactive logon attempts  
- Observed repeated authentication failures  

## Classification
Benign / Expected Activity  

## Severity
Low  

## Response
Alert closed with documentation  

## Analyst Notes
Activity originated from localhost, indicating local authentication attempts rather than an external attack. Behavior is consistent with user error or lab testing.

---

# Triage Notes Template

```text
Alert Name:
Time:
Host:
User:
Source IP:

Summary:
Brief description of the alert

Enrichment Performed:
Logs, IPs, processes, related events

Classification:
True Positive / False Positive / Benign / Suspicious

Severity:
Low / Medium / High / Critical

Response Action:
Close / Monitor / Investigate / Escalate

Notes:
Analyst reasoning and conclusion

Minimum Evidence Requirements

Each triage must include:
alert name and timestamp
affected host
username
source IP
raw event data
event ID or detection rule
related activity (if applicable)
analyst conclusion
Decision Support Guide

Alert Type	Classification	Response
Failed login burst	Suspicious	Investigate / Monitor
PowerShell encoded command	True Positive	Escalate / Investigate
Threat intel match	Suspicious	Enrich and investigate
Single failed login	Benign	Close
Lab testing activity	Benign / Expected	Close with documentation
Lessons Learned
Alert validation prevents false positives caused by poor detection logic
Event enrichment is critical for accurate classification
Source IP context (local vs external) significantly impacts severity
Not all alerts indicate malicious activity
Structured workflows improve consistency
Proper documentation improves investigation quality
Validation Checklist

Before completing triage:

[ ] Alert reviewed and validated  
[ ] Raw event data analyzed  
[ ] Enrichment completed  
[ ] Classification assigned  
[ ] Severity assigned  
[ ] Response action selected  
[ ] Evidence documented  
[ ] Triage notes completed  
[ ] Decision justified  
Outcome

A structured SOC alert triage workflow was designed and implemented in a homelab environment, enabling consistent, evidence-based handling of security alerts.

Skills Demonstrated
SOC alert triage
SIEM analysis (Splunk, Wazuh)
Windows event log analysis
Event enrichment and investigation
Alert classification and prioritization
Incident response decision-making
Security documentation and workflow design

---

I improved:

✔ structure (clear SOC sections)  
✔ language (professional, not “lab notes”)  
✔ consistency (same terminology everywhere)  
✔ readability (GitHub-ready)  
✔ realism (looks like real SOC documentation)