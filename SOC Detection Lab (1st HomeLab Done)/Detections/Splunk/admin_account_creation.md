Day 16 continued the Detection Engineering phase by focusing on identifying privileged account creation activity within the HomeLab environment.  
The objective of this lab was to design and validate detection logic capable of identifying newly created user accounts and subsequent privilege escalation through administrative group membership changes using Windows Security telemetry ingested into Splunk.

This exercise simulated a high-impact SOC detection scenario where adversaries create or modify accounts to establish persistence or escalate privileges. The lab emphasized telemetry validation, detection query development, controlled event generation, correlation logic design, and rule operationalization within the SIEM platform.

🔎 Telemetry Validation & Event Familiarization  
Initial validation was performed to confirm availability of account lifecycle and group membership telemetry required for detection development.

Actions performed  
Executed searches for account creation events (EventCode 4720)  
Executed searches for group membership modification events (EventCode 4732, 4728, 4756)  
Inspected raw events to identify relevant metadata fields  
Reviewed subject account, target account, group name, and host context  

Outcome  
Confirmed ingestion and structure of identity lifecycle and privilege modification telemetry.

Skills practiced  
Telemetry validation  
Event schema interpretation  
Identity lifecycle awareness  

📊 Account Creation Detection Query  
A baseline detection query was developed to identify newly created user accounts across the monitored environment.

Actions performed  
Constructed SPL query targeting EventCode 4720  
Normalized created account and actor fields  
Aggregated account creation activity by user and host  
Validated detection output formatting and timestamps  

Outcome  
Established detection capability for monitoring new account provisioning events.

Skills practiced  
Detection query development  
Field normalization  
Identity lifecycle monitoring  

🧪 Controlled Account Creation Simulation  
Controlled account lifecycle activity was generated to validate detection accuracy.

Actions performed  
Created test user account on monitored endpoint  
Observed corresponding account creation event within Splunk  
Validated detection query successfully captured generated activity  

Outcome  
Confirmed functional account creation detection workflow.

Skills practiced  
Detection validation methodology  
Controlled event generation  
SIEM validation workflow  

🛡️ Privileged Group Membership Detection  
Detection logic was expanded to monitor administrative privilege assignment through group membership changes.

Actions performed  
Developed SPL query targeting group membership modification events  
Extracted member, group, and actor context from telemetry  
Aggregated privilege assignment activity across hosts  
Validated detection output against simulated activity  

Outcome  
Established detection capability for monitoring administrative privilege assignment events.

Skills practiced  
Privilege monitoring  
Group membership analysis  
Administrative activity detection  

🔗 Correlated Detection — Account Creation Followed by Privilege Assignment  
Correlation logic was implemented to identify suspicious sequences where newly created accounts were rapidly granted administrative privileges.

Actions performed  
Combined account creation and group membership events within unified query  
Applied temporal correlation window  
Identified sequences representing potential privilege escalation scenarios  
Validated correlation results against simulated activity timeline  

Outcome  
Developed higher-fidelity detection capturing chained identity lifecycle and privilege escalation behavior.

Skills practiced  
Detection correlation  
Temporal analysis  
Behavioral detection engineering  

💾 Detection Operationalization  
Detection artifacts were persisted within Splunk to support ongoing monitoring workflows.

Actions performed  
Saved detection queries as Saved Search / Alert  
Applied naming convention aligned with SOC detection catalog  
Documented detection logic and investigative context  

Outcome  
Established persistent detection rule representing privileged account creation monitoring capability.

Skills practiced  
Detection lifecycle management  
SIEM operationalization  
Detection documentation  

🧠 Knowledge Gained  
Importance of monitoring identity lifecycle events for persistence detection  
Role of administrative group membership monitoring in privilege escalation detection  
Value of correlating multiple security events to improve detection fidelity  
Operational workflow for detection engineering from telemetry validation to rule deployment  
Common adversary techniques involving account creation and privilege assignment  

✅ Day 16 Checklist  
Validated ingestion of account creation events (EventCode 4720)  
Validated ingestion of group membership modification events (EventCode 4732/4728/4756)  
Developed baseline account creation detection query  
Simulated user account creation activity  
Validated detection capturing account creation event  
Developed administrative group membership detection query  
Simulated privilege assignment through group membership change  
Implemented correlation between account creation and privilege escalation events  
Saved detection queries as persistent SIEM artifacts  
Captured representative screenshots and documented detection workflow  