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

# Homelab Day 74 — SOC Workflow Reset

## Overview

Day 74 was a major shift in how I approach my cybersecurity homelab. Up to this point, I had mainly been thinking like a Detection Engineer, focused on building and testing detections. Today, I changed my mindset and started thinking like a **Junior SOC Analyst working on shift**.

This was an important transition because a SOC Analyst is not only responsible for seeing alerts, but also for validating them, investigating activity, making evidence-based decisions, and documenting findings clearly.

My main goal today was to redesign my lab workflow so it reflects how a real SOC environment operates.

---

## Objective

The purpose of today’s work was to build a structured SOC workflow inside my homelab and create documentation that mirrors real-world analyst operations.

I wanted to make my lab more realistic by simulating the responsibilities of a SOC Analyst, including:

- monitoring alerts
- validating suspicious activity
- classifying severity
- enriching events with context
- investigating incidents
- escalating when necessary
- documenting findings professionally

This helps me move closer to my goal of getting my first **SOC Analyst job** by showing recruiters that I am not only learning tools, but also developing the mindset and workflow used in real SOC teams.

---

## Step-by-Step Work Completed Today

### 1. Redefined my lab role as a Junior SOC Analyst

I started by creating a new file:

`SOC/soc_workflow.md`

In this file, I documented the purpose of my SOC lab and clearly defined my role as a **Junior SOC Analyst**. I wrote down the key responsibilities I want to practice in my homelab:

- monitor alerts from SIEM platforms such as Splunk, Wazuh, and Suricata
- validate whether alerts are true positives or false positives
- investigate suspicious behavior
- enrich logs and alerts with additional context
- make decisions based on evidence
- escalate incidents when required
- report findings clearly

This step was important because it changed the lab from being a detection playground into a workflow-driven analyst environment.

---

### 2. Built a structured SOC workflow

Next, I added a full SOC workflow to the same markdown file.

I documented the alert lifecycle step by step:

1. Alert received  
2. Validation  
3. Classification  
4. Enrichment  
5. Investigation  
6. Containment or escalation  
7. Reporting  

By writing this out, I created a standard process that I can follow every time I investigate an alert in the lab. This helps me practice consistency, which is critical in a real SOC environment.

The key lesson from this part of the day was learning that every alert must be treated as a potential threat until the data proves otherwise.

---

### 3. Created a SOC folder structure for investigations

To make my lab more organized and portfolio-ready, I created the following folders in my repository:

- `soc/`
- `alerts/`
- `cases/`
- `playbooks/`
- `reports/`

I also documented the purpose of each folder:

- **alerts/** for raw alerts and initial observations
- **cases/** for full investigations and evidence timelines
- **playbooks/** for repeatable response procedures
- **reports/** for final summaries and incident documentation

This structure makes the project look more like a real SOC environment and shows that I understand case handling and analyst documentation, not just detection creation.

---

### 4. Created my first alert template

I created:

`alerts/alert_template.md`

This template gives me a standard format for recording alerts consistently. It includes:

- alert ID
- source
- alert name
- detection time
- severity
- initial observation
- raw log evidence
- analyst notes
- status

This was an important step because analysts need to document alerts in a repeatable way. A good alert record helps with triage, investigation, escalation, and reporting.

---

### 5. Created my first case template

I then created:

`cases/case_template.md`

This file acts as a reusable incident investigation template. It includes:

- case ID
- related alert
- summary
- timeline
- investigation details
- findings
- conclusion
- response actions
- recommendations

This was one of the most valuable parts of the day because it introduced a proper case management mindset into my lab. Instead of just looking at logs, I now have a structured method for tracking incidents from start to finish.

---

### 6. Built my first SOC playbook

I created:

`playbooks/failed_login_playbook.md`

This playbook focuses on handling **multiple failed logins**, which can indicate brute-force attempts or possible account compromise.

The playbook includes:

- identifying the affected user
- counting failed login attempts
- checking the source IP
- determining whether the activity is internal or external
- verifying whether a successful login happened after the failures
- investigating related host activity
- deciding whether to escalate or contain the issue

This helped me begin building repeatable analyst procedures, which is a core SOC skill. Playbooks reduce uncertainty and help analysts respond faster and more consistently.

---

### 7. Added analyst principles to reinforce the SOC mindset

To make the workflow more realistic, I also added a short set of principles for myself as an analyst:

- trust logs, not assumptions
- always verify before escalating
- document everything
- if it is not written, it did not happen
- context is everything

This helped reinforce the mindset shift I wanted to achieve today. The technical work was important, but the biggest outcome was learning to think and operate like an analyst rather than only like a builder.

---

## Skills Practiced Today

Today’s work helped me practice and strengthen the following skills:

- SOC workflow design
- alert triage methodology
- incident documentation
- case management structure
- playbook development
- analyst decision-making
- portfolio project organization
- professional markdown documentation

---

## Key Takeaways

Day 74 was a critical milestone in my homelab journey.

I did not focus on building new detections today. Instead, I focused on building the **workflow, structure, and mindset** needed to function like a real SOC Analyst.

The most important takeaway was this:

> A SOC Analyst does not just react to alerts. A SOC Analyst validates, investigates, documents, and makes evidence-based decisions.

This shift is important for my career because I want recruiters to see that I understand not only cybersecurity tools, but also the operational thinking and documentation standards used in real security teams.

---

## Why This Matters for My SOC Analyst Goal

My goal is to land my first SOC Analyst job, and today’s work directly supports that goal.

This project demonstrates that I can:

- think like an analyst under uncertainty
- follow a structured investigation process
- create professional documentation
- organize alerts, cases, and playbooks in a realistic way
- build a portfolio that reflects real SOC responsibilities

This makes my homelab more than a technical lab. It becomes evidence that I am preparing for real blue team work.

---

## Files Created Today

- `soc/soc_workflow.md`
- `alerts/alert_template.md`
- `cases/case_template.md`
- `playbooks/failed_login_playbook.md`

---

## Final Reflection

Day 74 was a mindset reset.

I moved from detection-focused thinking into a SOC operations mindset. I now have the beginning of a structured analyst environment inside my homelab, including workflow documentation, case templates, alert templates, and a starter playbook.

This gives me a strong foundation for future investigations and makes my portfolio more attractive to recruiters looking for entry-level SOC talent.

Tomorrow, I plan to use this workflow to process my first alert like a real SOC shift investigation.