# SOC Metrics Dashboard

## Objective

Build a SOC metrics dashboard in Splunk to measure alert volume, detection quality, and detection coverage in a homelab SOC environment.

This project extends previous work (telemetry, detections, triage) by introducing:

- measurement
- reporting
- analyst performance visibility

---

## Metrics Defined

### 1. Alerts per Day

Alerts per Day measures how many alerts are triggered in the environment each day.

Why it matters:
- shows overall alert volume
- helps identify spikes and noisy periods
- helps estimate SOC workload

---

### 2. False Positives

False Positives measures how many alerts were reviewed and classified as benign, expected, or incorrect.

Why it matters:
- reflects detection quality
- highlights rules requiring tuning
- reduces analyst fatigue

---

### 3. Detection Coverage

Detection Coverage measures which attack behaviors have detections implemented.

Why it matters:
- shows detection maturity
- highlights coverage gaps
- maps detections to attacker techniques

---

## Homelab Context

This dashboard operates within a homelab SOC environment:

```text
Internet
   │
KALI01
   │
FW01
   │
NET-CORP
├─ DC01
├─ PC01
└─ SRV01

NET-SOC
├─ WAZ01
├─ SPLK01
└─ VAS01
````

Data sources include:

* Wazuh alerts
* Splunk indexed events
* detection rules
* analyst classification (CSV)
* detection inventory (CSV)

---

## Data Sources

Each metric is mapped to a specific data source:

| Metric             | Source                      | Type           |
| ------------------ | --------------------------- | -------------- |
| Alerts per Day     | Wazuh alerts in Splunk      | Live telemetry |
| False Positives    | false_positive_tracking.csv | Manual lookup  |
| Detection Coverage | detection_coverage.csv      | Manual lookup  |

### Design Choice

Because no ticketing system is used, SOC metrics are implemented using:

* Splunk alert telemetry
* manual lookup files
* simulated analyst workflow

This provides a realistic but lightweight SOC reporting model.

---

## Supporting Files

### false_positive_tracking.csv

Tracks analyst classification outcomes.

Fields:

* alert_name
* date
* classification (False Positive / True Positive / Benign)
* severity
* host
* notes

Purpose:

* simulate alert review workflow
* measure detection quality

---

### detection_coverage.csv

Tracks implemented detections.

Fields:

* detection_name
* category
* technique
* enabled
* status
* notes

Purpose:

* maintain detection inventory
* measure coverage across attack techniques

---

## Dashboard Panels

### 1. Alerts per Day

```spl
index="wazuh-alerts" (rule.description=* OR agent.name=*)
| timechart span=1d count
```

Visualization:

* Line chart

Purpose:

* track alert volume trends
* identify spikes from attack simulation
* measure SOC workload

---

### 2. Alert Classification Breakdown

```spl
| inputlookup false_positive_tracking.csv
| stats count by classification
| sort - count
```

Visualization:

* Pie chart / Bar chart

Purpose:

* distinguish false positives, true positives, and benign activity
* evaluate detection quality
* support tuning decisions

---

### 3. Detection Coverage by Category

```spl
| inputlookup detection_coverage.csv
| stats count by category
```

Visualization:

* Bar chart

Purpose:

* show coverage across attack categories
* visualize detection maturity

---

### 4. Coverage by Technique

```spl
| inputlookup detection_coverage.csv
| stats count by technique
```

Purpose:

* map detections to ATT&CK-style techniques
* improve detection engineering visibility

---

## Validation

The dashboard was tested using simulated attack activity from Kali Linux, including:

* brute-force authentication attempts
* SMB login attempts
* network scanning (Nmap)

Validation confirmed:

* alerts are generated and ingested into Splunk
* dashboard updates dynamically
* classification reflects analyst input
* detection coverage matches implemented rules

---

## Dashboard Interpretation

The dashboard provides a unified view of SOC performance:

* Alert volume increases during simulated attacks
* Classification data highlights false positives and benign activity
* Detection coverage shows visibility across authentication, execution, persistence, and lateral movement

This demonstrates a full SOC workflow:

```text
Telemetry → Detection → Classification → Measurement → Reporting
```

---

## Outcome

A SOC Metrics Dashboard was successfully built to measure:

* alert volume
* detection quality
* detection coverage

The dashboard combines real telemetry with analyst-maintained data to provide a realistic SOC monitoring and reporting view.

---

## Skills Demonstrated

* Splunk dashboard creation
* SOC metrics design
* detection coverage tracking
* false positive analysis
* Wazuh + Splunk integration
* SOC workflow simulation

---

## Portfolio Summary

Built a SOC Metrics Dashboard in Splunk to track alerts per day, false positives, and detection coverage, using Wazuh telemetry and analyst-maintained lookup data to measure operational visibility and detection quality.

---

## Key Takeaways

* Alert volume alone does not indicate detection quality
* Classification is essential for understanding alert usefulness
* Detection coverage improves visibility into attack surface
* Even a small homelab can simulate real SOC reporting

