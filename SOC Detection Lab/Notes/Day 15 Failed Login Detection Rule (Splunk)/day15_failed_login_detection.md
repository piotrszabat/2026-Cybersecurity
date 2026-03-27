Day 15 marked the beginning of the Detection Engineering phase within the HomeLab environment by focusing on the creation and validation of a failed authentication detection rule.  
The objective of this lab was to design a practical detection mechanism for identifying repeated failed login attempts using Windows Security telemetry ingested into Splunk.

This exercise simulated a common Tier 1 SOC detection use case where analysts monitor authentication failures to identify password spraying, brute-force attempts, or misconfigured authentication activity. The lab emphasized data exploration, query development, detection logic construction, controlled event generation, and rule persistence within the SIEM platform.

🔎 Telemetry Validation & Field Exploration  
Initial validation was performed to confirm availability of failed authentication telemetry and identify relevant event fields required for detection logic.

Actions performed  
Executed searches for Windows Security EventCode 4625  
Inspected individual events to identify available metadata fields  
Reviewed user, source, logon type, host, and timestamp attributes  
Validated field naming consistency across events  

Outcome  
Confirmed presence of failed authentication telemetry and established understanding of available detection-relevant fields.

Skills practiced  
Telemetry validation  
Field discovery  
Event schema interpretation  

📊 Failed Authentication Visibility Query  
A baseline visibility query was constructed to summarize failed login activity across the environment.

Actions performed  
Developed SPL query aggregating failed authentication events  
Grouped events by user account and host context  
Reviewed authentication failure distribution  

Outcome  
Created situational awareness of authentication failure patterns across the monitored endpoint.

Skills practiced  
Aggregation query design  
Authentication telemetry analysis  
SIEM search development  

🚨 Detection Logic Development — Failed Login Burst  
A detection query was engineered to identify clusters of repeated authentication failures indicative of brute-force behavior.

Actions performed  
Normalized user and source identity fields using coalesce logic  
Applied time bucketing to group events into defined intervals  
Aggregated failure counts per user and source context  
Defined threshold condition to trigger detection  
Validated query output formatting and sorting  

Outcome  
Developed functional detection logic capable of identifying suspicious authentication failure bursts.

Skills practiced  
Detection engineering fundamentals  
Threshold-based detection design  
Field normalization techniques  

🧪 Detection Validation Through Event Simulation  
Controlled failed authentication activity was generated to validate detection effectiveness.

Actions performed  
Performed multiple consecutive failed login attempts on endpoint  
Executed detection query within appropriate time window  
Observed detection triggering based on simulated activity  

Outcome  
Confirmed detection rule successfully identified simulated authentication failure pattern.

Skills practiced  
Detection validation methodology  
Controlled attack simulation  
Detection tuning awareness  

💾 Detection Persistence & Operationalization  
The detection query was saved within Splunk to support recurring monitoring workflows.

Actions performed  
Saved detection query as Saved Search / Alert within Splunk  
Configured execution context and naming convention  
Documented detection purpose and scope  

Outcome  
Established persistent detection artifact representing first HomeLab detection engineering rule.

Skills practiced  
SIEM detection operationalization  
Alert lifecycle awareness  
Detection documentation  

🧠 Knowledge Gained  
Detection engineering workflow from telemetry validation to rule deployment  
Importance of field discovery prior to rule creation  
Use of time bucketing for behavioral pattern detection  
Threshold-based detection for authentication abuse scenarios  
Value of controlled simulation for detection validation  
Operational process for persisting detections within SIEM platforms  

✅ Day 15 Checklist  
Validated ingestion of failed authentication telemetry (EventCode 4625)  
Inspected failed authentication event structure and fields  
Created baseline failed login visibility query  
Developed burst-based failed login detection logic  
Generated controlled failed login attempts for validation  
Confirmed detection query successfully triggered  
Saved detection as persistent search or alert  
Captured representative screenshots for documentation  
Documented detection logic and workflow within repository  