Day 23 continued the Network Security & Attacks phase by focusing on Suricata rule analysis and custom rule development within the HomeLab environment.  
The objective of this lab was to understand how Suricata detection rules operate, analyze generated alerts, locate corresponding rule definitions, and create a custom rule to validate detection capabilities through controlled network activity.

This exercise simulated real SOC and detection engineering workflows where analysts investigate IDS alerts, interpret rule logic, and develop tailored detections aligned with environmental context. The lab emphasized alert inspection, rule structure comprehension, configuration validation, custom detection implementation, and alert verification across multiple Suricata log formats.

🛠️ Suricata Service Validation & Log Inspection  
The lab began by confirming operational readiness of the Suricata IDS and availability of logging artifacts.

Actions performed  
Verified Suricata service status using systemd  
Confirmed presence of Suricata log directory and key log files  
Reviewed fast.log and eve.json to understand alert storage formats  

Outcome  
Established confidence in Suricata operational state and log pipeline availability.

Skills practiced  
Service validation  
Log source identification  
IDS operational awareness  

🚨 Alert Observation & Baseline Review  
Existing alerts were examined to understand detection output and contextual metadata.

Actions performed  
Reviewed recent alert entries within fast.log  
Generated controlled IDS-triggering web traffic to produce sample alerts  
Correlated alert entries between fast.log and structured JSON representation in eve.json  

Outcome  
Developed familiarity with Suricata alert presentation and cross-log visibility.

Skills practiced  
Alert interpretation  
Structured vs unstructured log comparison  
Detection validation workflow  

🧠 Suricata Rule Anatomy Analysis  
The structure and components of Suricata detection rules were studied to understand detection logic.

Actions performed  
Examined example rule format and syntax  
Identified rule components including action, protocol, direction, and option fields  
Documented purpose of rule options such as msg, content, sid, and revision identifiers  

Outcome  
Built foundational understanding of rule composition and detection semantics.

Skills practiced  
Rule syntax interpretation  
Detection logic comprehension  
IDS rule literacy  

📂 Rule Source Identification & Configuration Review  
The Suricata configuration was analyzed to determine rule loading behavior and file locations.

Actions performed  
Reviewed Suricata configuration file to identify rule loading configuration  
Enumerated rule directories and available rule files  
Searched rule files to locate definitions corresponding to observed alerts  

Outcome  
Established visibility into Suricata rule management and rule-to-alert relationships.

Skills practiced  
Configuration analysis  
Rule source discovery  
Detection traceability  

🧪 Custom Rule Development & Deployment  
A custom Suricata detection rule was developed to identify HTTP requests containing a specific User-Agent string.

Actions performed  
Created local.rules file containing custom HTTP detection rule  
Added local.rules to Suricata rule loading configuration  
Validated configuration syntax using Suricata test mode  
Restarted Suricata service to activate new detection rule  

Outcome  
Successfully deployed environment-specific detection rule within Suricata.

Skills practiced  
Custom IDS rule development  
Configuration management  
Detection deployment workflow  

📡 Detection Validation Through Controlled Traffic  
Controlled network traffic was generated to trigger the custom detection rule.

Actions performed  
Generated HTTP request containing test User-Agent string from attacker host  
Monitored Suricata logs for detection output  
Confirmed alert visibility in both fast.log and eve.json  

Outcome  
Validated functional operation of custom rule and end-to-end detection pipeline.

Skills practiced  
Detection validation methodology  
Traffic simulation for IDS testing  
Alert verification  

🧠 Knowledge Gained  
Operational workflow for investigating Suricata alerts across multiple log formats  
Understanding of Suricata rule structure and detection semantics  
Relationship between IDS alerts and underlying rule definitions  
Process of safely developing and deploying custom detection rules  
Importance of configuration validation prior to service restart  
Practical methodology for testing IDS detections using controlled traffic  

✅ Day 23 Checklist  
Verified Suricata service operational status  
Confirmed availability of fast.log and eve.json alert logs  
Observed and analyzed baseline Suricata alert output  
Studied Suricata rule structure and syntax components  
Identified rule directories and configuration rule loading behavior  
Created custom detection rule within local.rules  
Updated Suricata configuration to include custom rule file  
Validated configuration using Suricata test mode  
Restarted Suricata service to activate custom rule  
Generated controlled network traffic to trigger detection  
Confirmed alert visibility in both fast.log and eve.json  
Captured representative screenshots and documented workflow  