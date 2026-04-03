# SOC Workflow — Junior SOC Analyst Lab

## Objective

This lab simulates a real Security Operations Center (SOC) environment.

My role: Junior SOC Analyst

Primary responsibilities:
- Monitor alerts from SIEM (Splunk)
- Validate if alerts are true or false positives
- Investigate suspicious activity
- Enrich events with additional data
- Make evidence-based decisions
- Escalate incidents when necessary
- Document findings clearly

---

## SOC Mindset

Every alert is treated as:
- Potential threat
- Requires validation
- Must be supported with evidence

No assumptions.
Only data-driven conclusions.

## SOC Workflow

1. Alert Received
   - Alert triggered in SIEM (Splunk / Wazuh / Suricata)

2. Validation
   - Is the alert real?
   - Check raw logs
   - Remove obvious false positives

3. Classification (Severity)
   - Low → informational
   - Medium → suspicious
   - High → likely malicious

4. Enrichment
   - Add context:
     - IP reputation
     - user account
     - host details
     - geolocation
     - process details

5. Investigation
   - Build timeline of activity
   - Identify:
     - what happened
     - when
     - where
     - how

6. Containment / Escalation
   - Contain (lab simulation):
     - isolate host
     - block IP
   - OR escalate to senior analyst

7. Reporting
   - Document:
     - summary
     - evidence
     - decision
     - recommendations

     ## SOC Folder Structure

alerts/
- Raw alerts from SIEM
- Initial observations

cases/
- Full investigations
- Timeline + evidence

playbooks/
- Standard procedures
- How to handle specific alerts

reports/
- Final incident reports
- Executive-style summaries

notes/
- Details of each day of my homelab