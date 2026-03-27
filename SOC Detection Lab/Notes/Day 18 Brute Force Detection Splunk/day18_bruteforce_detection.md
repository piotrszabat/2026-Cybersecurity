Day 18 expanded the Detection Engineering phase by focusing on brute-force authentication detection within the HomeLab environment.  
The objective of this lab was to design, validate, and operationalize SIEM detections capable of identifying repeated failed authentication patterns consistent with brute-force and password spraying behavior using Windows Security telemetry in Splunk.

This exercise simulated a high-frequency authentication abuse scenario commonly handled by SOC analysts. The lab emphasized pattern-based detection logic, time-window aggregation, threshold selection, controlled event generation, higher-fidelity correlation techniques, and persistence of detections as SIEM rules.

🔎 Telemetry Validation & Event Readiness  
Initial validation was performed to confirm availability of authentication telemetry required for brute-force detection.

Actions performed  
Verified ingestion of failed logon events (EventCode 4625)  
Verified ingestion of successful logon events (EventCode 4624)  
Inspected raw events to confirm presence of key fields such as user, source context, host, and timestamps  
Validated field naming consistency for correlation logic  

Outcome  
Confirmed authentication telemetry readiness for brute-force detection engineering.

Skills practiced  
Telemetry validation  
Authentication event inspection  
Field discovery and normalization  

🧪 Controlled Brute-Force Simulation  
Authentication failure patterns were intentionally generated to produce repeatable telemetry for detection validation.

Actions performed  
Generated multiple consecutive failed login attempts within a short time window  
Validated that the failed authentication burst was visible in Splunk  
Prepared dataset for threshold-based detection testing  

Outcome  
Successfully generated brute-force-like telemetry suitable for validating detection logic.

Skills practiced  
Controlled event generation  
Detection validation preparation  
Attack pattern simulation (safe)  

🚨 Detection Rule A — Brute Force Burst (Source → User)  
A detection query was engineered to identify repeated failed logins targeting a single user from a consistent source context within a defined time window.

Actions performed  
Developed SPL query targeting EventCode 4625  
Normalized user and source fields for reliability  
Applied time bucketing to aggregate failures per interval  
Defined threshold condition to flag suspicious bursts  
Returned investigation-ready context for analyst triage  

Outcome  
Built a functional brute-force burst detection capable of flagging high-volume failed login activity.

Skills practiced  
Threshold-based detection engineering  
Time window aggregation  
Authentication anomaly detection  

🚨 Detection Rule B — Password Spray Pattern (Source → Many Users)  
A detection query was engineered to identify password spraying behavior where a single source attempts authentication against multiple distinct accounts.

Actions performed  
Aggregated failed authentication attempts by source context  
Calculated distinct user count per time window  
Applied thresholds for both attempts and unique targets  
Reviewed outputs to validate spray-like behavior patterns  

Outcome  
Established detection capability for password spraying scenarios, complementing brute-force burst detection.

Skills practiced  
Behavioral pattern detection  
Distinct count analysis  
SOC-focused aggregation logic  

⭐ High-Fidelity Correlation — Success After Failures  
A higher-confidence detection approach was implemented to highlight scenarios where successful authentication follows a sequence of failures.

Actions performed  
Combined failed and successful logon telemetry within a correlation window  
Correlated events by user and source context  
Identified sequences where EventCode 4624 followed repeated EventCode 4625 events  
Reviewed correlated timelines for investigation readiness  

Outcome  
Improved detection fidelity by identifying authentication compromise indicators (success after repeated failures).

Skills practiced  
Event correlation  
Timeline-based detection logic  
High-fidelity alert design  

💾 Detection Operationalization in Splunk  
Detection logic was saved as persistent SIEM rules to support recurring monitoring workflows.

Actions performed  
Saved detection queries as Alerts / Saved Searches within Splunk  
Applied SOC-aligned naming conventions  
Configured schedule and trigger conditions based on results presence  
Documented detection purpose and expected alert behavior  

Outcome  
Established reusable brute-force detection rules within the SIEM platform.

Skills practiced  
SIEM rule operationalization  
Detection lifecycle management  
Alert readiness and documentation  

🧠 Knowledge Gained  
Brute-force and password spray patterns within authentication telemetry  
Effective use of time-window aggregation and thresholds in detection engineering  
Importance of field normalization for reliable detection logic  
Higher-fidelity detection through success-after-failure correlation  
Operational process for saving and scheduling detections within a SIEM  
SOC triage context required for investigation-ready alerts  

✅ Day 18 Checklist  
Validated ingestion of failed logon events (4625)  
Validated ingestion of successful logon events (4624)  
Generated controlled brute-force-like failed login bursts for testing  
Built brute-force burst detection query (source → user)  
Built password spray detection query (source → many users)  
Implemented success-after-failures correlation logic  
Validated detections against generated telemetry  
Saved detections as persistent Alerts / Saved Searches in Splunk  
Captured representative screenshots of results and rule configuration  
Documented detection logic and tuning considerations in repository  