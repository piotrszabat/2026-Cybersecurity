Day 38 — Suricata Log Integration with Splunk

## Objective

The objective of Day 38 was to integrate **Suricata IDS telemetry** with **Splunk SIEM**, validate that Suricata events were successfully searchable in Splunk, and build a basic SOC-style dashboard for security monitoring.

This day focused on turning raw IDS output into actionable SIEM visibility by:

* forwarding Suricata logs into Splunk
* validating event ingestion
* reviewing parsed security events
* creating a dashboard to visualize IDS activity

---

## Lab Environment

| System     | Role                                       |
| ---------- | ------------------------------------------ |
| **FW01**   | pfSense firewall                           |
| **IDS01**  | Suricata IDS sensor                        |
| **SPLK01** | Splunk Enterprise SIEM                     |
| **KALI01** | attack simulation / test traffic generator |

---

## Day 38 Goal

At the end of this day, the lab was expected to provide:

* Suricata log flow into Splunk
* searchable events in a dedicated Splunk index
* visibility into IDS alerts and network activity
* a basic dashboard showing attack and traffic patterns

The target Splunk search for validation was:

```spl
index=suricata
```

---

## Architecture Overview

The telemetry pipeline for this phase of the lab was:

```text
KALI01
   │
   │ generated test traffic / scans
   ▼
FW01 (pfSense)
   │
   ▼
IDS01 (Suricata)
   │
   │ eve.json / Suricata event logs
   ▼
Splunk ingestion path
   │
   ▼
SPLK01 (Splunk SIEM)
```

This provided an end-to-end detection path from attack simulation to centralized SIEM visibility.

---

## Work Completed

### 1. Verified Suricata Log Availability

The first task was to confirm that **Suricata was actively generating logs** before attempting SIEM ingestion.

Validation focused on:

* confirming that Suricata was running correctly
* confirming that log output existed
* confirming that structured Suricata events were available for onboarding into Splunk

This step was necessary to ensure that Splunk would receive real IDS telemetry rather than an empty or misconfigured input source.

---

### 2. Selected the Log Ingestion Method

A log onboarding method was chosen for sending Suricata data into Splunk.

The selected approach was based on **structured ingestion of Suricata event data**, with emphasis on maintaining:

* clean parsing
* easier field extraction
* better dashboard usability
* simpler detection logic in Splunk

This decision was important because structured security logs provide more useful visibility than unstructured plain-text alerts.

---

### 3. Created a Dedicated Splunk Index

A dedicated Splunk index was created for Suricata telemetry:

```text
suricata
```

Using a separate index made the environment cleaner and more professional by:

* isolating IDS data from other lab logs
* improving search accuracy
* simplifying dashboard creation
* making future detections easier to maintain

---

### 4. Configured Splunk Data Input

Splunk was configured to ingest the Suricata log source and assign it to the new index.

Configuration included:

* assigning the **suricata** index
* using a custom sourcetype for Suricata events
* validating that Splunk could read and process the selected log source

Recommended sourcetype used in the lab:

```text
suricata:eve:json
```

This naming convention helps make the lab look more realistic and enterprise-style.

---

### 5. Generated Test Traffic from Kali

To validate the ingestion pipeline, controlled attack traffic was generated from **KALI01**.

Test activity included safe reconnaissance-style traffic designed to trigger Suricata detections and populate Splunk with relevant fields such as:

* source IP
* destination IP
* protocol
* event type
* signature name

This step ensured that the dashboard would be built from real detection data instead of empty placeholder events.

---

### 6. Verified Searchable Events in Splunk

After enabling ingestion, Splunk searches were used to confirm that events were successfully indexed.

Validation searches included:

```spl
index=suricata
```

and:

```spl
index=suricata sourcetype=suricata:eve:json
```

This confirmed that:

* Suricata events were reaching Splunk
* the index was populated
* event data was searchable
* parsing was sufficient for dashboard work

Expanded event review was also performed to inspect the event structure and confirm availability of useful fields.

---

### 7. Reviewed Parsed Suricata Fields

A sample event was expanded in Splunk to inspect available fields.

The lab confirmed visibility into important security fields such as:

* `src_ip`
* `dest_ip`
* `proto`
* `event_type`
* `alert.signature`

This step was important because field validation determines whether the data is ready for dashboards, detections, and SOC workflows.

---

### 8. Built a SOC-Style Suricata Dashboard

After ingestion was confirmed, a small **IDS monitoring dashboard** was created in Splunk to provide visibility into security activity.

The dashboard focused on three core views:

#### Top Signatures

This panel highlighted the most common IDS alert signatures triggered in the lab.

Example search:

```spl
index=suricata sourcetype=suricata:eve:json alert.signature=*
| stats count by alert.signature
| sort - count
| head 10
```

#### Top Source IPs

This panel showed which source IP addresses generated the most Suricata events.

Example search:

```spl
index=suricata sourcetype=suricata:eve:json src_ip=*
| stats count by src_ip
| sort - count
| head 10
```

#### Protocol Distribution

This panel visualized which protocols were most frequently observed in Suricata telemetry.

Example search:

```spl
index=suricata sourcetype=suricata:eve:json proto=*
| stats count by proto
| sort - count
```

These three panels together created a simple but effective SOC analyst view of network security activity.

---

## Validation Results

The Day 38 objectives were successfully completed.

Confirmed outcomes:

* Suricata logs were successfully integrated into Splunk
* events were searchable with `index=suricata`
* raw and structured event data could be reviewed
* relevant fields were available for analysis
* a working dashboard was created to visualize IDS activity

This validated that the IDS-to-SIEM pipeline in the homelab was working correctly.

---

## Detection Value

This day significantly improved the realism of the lab by moving from simple log generation to **centralized security monitoring**.

The project now demonstrates practical experience with:

* IDS telemetry onboarding
* SIEM data ingestion
* log validation
* field inspection
* dashboard creation
* SOC-style data analysis

These are highly relevant skills for entry-level SOC Analyst, Cybersecurity Analyst, and Blue Team roles.

---

## Evidence and Screenshots

Recommended evidence stored for this day:

```text
screenshots/day38/
├── 01_suricata_logs_present.png
├── 02_log_export_method_selected.png
├── 03_splunk_data_input.png
├── 04_search_index_suricata.png
├── 05_sample_suricata_event.png
├── 06_top_signatures_panel.png
├── 07_top_source_ip_panel.png
├── 08_protocol_distribution_panel.png
└── 09_final_dashboard.png
```

Final dashboard image:

```text
detections/suricata_dashboard.png
```

---

## Key Searches Used

### Event Validation

```spl
index=suricata
```

```spl
index=suricata sourcetype=suricata:eve:json
```

### Top Signatures

```spl
index=suricata sourcetype=suricata:eve:json alert.signature=*
| stats count by alert.signature
| sort - count
| head 10
```

### Top Source IP

```spl
index=suricata sourcetype=suricata:eve:json src_ip=*
| stats count by src_ip
| sort - count
| head 10
```

### Protocol Distribution

```spl
index=suricata sourcetype=suricata:eve:json proto=*
| stats count by proto
| sort - count
```

---

## Issues / Notes

A key design decision during this phase was to use a **structured ingestion path** for Suricata logs, which makes Splunk analysis cleaner and better suited for dashboards and detections.

Additional tuning may still be required in future days, including:

* improved field extraction
* better alert filtering
* reduction of noisy events
* more advanced Splunk visualizations
* creation of correlation searches

---

## Outcome

Day 38 successfully transformed Suricata output into searchable SIEM telemetry and established a visual monitoring layer inside Splunk.

This day marked the transition from **IDS deployment** to **operational security visibility**, which is a core capability in any SOC environment.
