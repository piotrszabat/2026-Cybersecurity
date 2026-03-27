# Day 60 — Internal Vulnerability Scan (Step-by-Step Summary)

## Overview

Day 60 focused on performing a full internal vulnerability assessment using the previously deployed Greenbone/OpenVAS scanner. This exercise marked the transition from tool deployment to practical security analysis.

The process followed a structured workflow:

```
target definition → scan execution → findings analysis → report generation
```

---

## Step 1 — Scanner Health Verification

Before starting any scans, the health of the vulnerability scanner (VAS01) was verified.

* Confirmed Docker containers were running
* Checked that all services (gvmd, openvas, gsad) were operational
* Verified that vulnerability feeds were fully synchronized

This ensured the scanner was ready for reliable assessment.

---

## Step 2 — Access to Web Interface

The Greenbone web interface was accessed via browser.

* Successfully authenticated using admin credentials
* Verified dashboard visibility
* Confirmed ability to create targets and scan tasks

---

## Step 3 — Target Preparation

The internal scan targets were defined based on lab infrastructure:

* DC01 – Domain Controller (192.168.10.10)
* PC01 – Windows 11 Workstation (192.168.10.20)
* SRV01 – Internal Server (192.168.10.30)

This step established a clear asset inventory for the vulnerability assessment.

---

## Step 4 — Scan Structure Design

A structured scanning approach was defined:

* One target per host
* One scan task per host

This approach improves:

* result clarity
* troubleshooting
* reporting quality

---

## Step 5 — Target Creation

Individual targets were created in Greenbone:

* Target: DC01
* Target: PC01
* Target: SRV01

Each target included:

* host IP address
* default port list
* default discovery settings

---

## Step 6 — Configuration Validation

Before scanning, the system was checked for:

* missing port lists
* missing scan configurations
* incomplete feed data

No blocking issues were identified, allowing the scan process to continue.

---

## Step 7 — Scan Task Creation

Three separate scan tasks were created:

* Scan PC01 – Full and Fast
* Scan SRV01 – Full and Fast
* Scan DC01 – Full and Fast

Each task was linked to:

* its corresponding target
* the "Full and Fast" scan configuration
* the default OpenVAS scanner

---

## Step 8 — Controlled Scan Execution Strategy

Instead of launching all scans simultaneously, a staged approach was used:

1. PC01 (first test scan)
2. SRV01
3. DC01

This prevented resource overload and allowed validation of results before scaling.

---

## Step 9 — First Scan Execution

The first scan was initiated on PC01.

* Scan status was monitored in real time
* Confirmed host reachability
* Verified that findings were being generated

---

## Step 10 — Initial Results Review

After completion of the PC01 scan:

* Verified that results were populated
* Reviewed severity distribution (Medium / Low)
* Confirmed scan accuracy and relevance

This step ensured that the scanning process was functioning correctly before proceeding.

---

## Step 11 — Remaining Scans Execution

Following successful validation:

* SRV01 scan was executed
* DC01 scan was executed last

All scans were completed sequentially to maintain stability.

---

## Step 12 — Findings Review by Severity

Findings were reviewed and categorized by severity:

* Medium findings identified key weaknesses (e.g., TLS configuration, RPC exposure)
* Low findings included information disclosure issues (timestamps)

Focus was placed on the most relevant and impactful findings.

---

## Step 13 — Vulnerability Analysis

Each key finding was analyzed using a structured approach:

* description of the vulnerability
* impact assessment
* security relevance
* remediation recommendations

This step transformed raw scan data into meaningful security insights.

---

## Step 14 — Report Export

Scan results were exported from Greenbone:

* Format: PDF
* Purpose: documentation and evidence

This provided a tangible artifact for portfolio and review.

---

## Step 15 — Summary Table Creation

A consolidated findings table was created to compare all hosts.

This included:

* severity levels
* key findings
* risk assessment
* prioritization

This step enabled quick comparison of system exposure.

---

## Step 16 — Security Conclusions

Final conclusions were drawn based on all results:

* PC01 had the largest attack surface
* DC01 carried the highest risk due to its role
* SRV01 was the most hardened system

The analysis emphasized that risk depends on both vulnerability severity and system criticality.

---

## Final Outcome

By the end of Day 60:

* Internal vulnerability scans were successfully completed
* Key weaknesses were identified and analyzed
* Reports were generated and documented
* A structured vulnerability assessment workflow was demonstrated

---

## Key Takeaway

Day 60 demonstrates the ability to move beyond tool setup and perform a complete vulnerability assessment lifecycle:

```
deployment → validation → scanning → analysis → reporting
```

This reflects real-world cybersecurity practice and significantly strengthens a professional security portfolio.

