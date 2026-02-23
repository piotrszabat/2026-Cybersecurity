Day 11 focused on SIEM exploration and developing operational familiarity with Splunk as a primary analysis platform within the HomeLab environment.  
The objective of this lab was to understand how telemetry is structured, searched, filtered, and visualized within a SIEM, enabling foundational SOC analyst workflows centered on log analysis and situational awareness.

This exercise simulated Tier 1 SOC daily activities, including telemetry discovery, authentication monitoring, process analysis, and dashboard creation. The lab emphasized query development, data interpretation, and visualization to strengthen analytical confidence within the SIEM environment.

🔎 Data Discovery & Environment Orientation  
Initial exploration was performed to understand available telemetry sources and host visibility within Splunk.

Actions performed  
Executed host discovery queries to identify indexed endpoints  
Reviewed sourcetype distribution across collected telemetry  
Validated ingestion coverage for Windows Security and Sysmon logs  

Outcome  
Established situational awareness of indexed telemetry sources and data structure within the SIEM.

Skills practiced  
SIEM data discovery  
Telemetry source identification  
Operational environment orientation  

⏱️ Time Range Exploration  
Temporal filtering capabilities were explored to understand how time selection impacts log visibility and analysis context.

Actions performed  
Adjusted Splunk time picker across multiple ranges  
Compared event volume across short and extended time windows  
Observed temporal patterns in telemetry generation  

Outcome  
Developed awareness of time-scoped analysis and its importance in incident investigation.

Skills practiced  
Time-based filtering  
Temporal context analysis  
Investigation scoping techniques  

🔐 Authentication Telemetry Analysis  
Authentication-related events were analyzed to simulate common SOC monitoring scenarios.

Actions performed  
Queried successful authentication events (EventCode 4624)  
Queried failed authentication events (EventCode 4625)  
Aggregated authentication events by account name  
Observed authentication patterns across the endpoint  

Outcome  
Validated ability to monitor authentication behavior and detect anomalous login activity.

Skills practiced  
Authentication monitoring  
Event aggregation techniques  
Identity telemetry analysis  

🛡️ Privilege & Account Monitoring  
Privilege assignment and account lifecycle telemetry were explored to understand administrative activity visibility.

Actions performed  
Queried privilege assignment events (EventCode 4672)  
Queried account creation events (EventCode 4720)  
Reviewed associated account metadata  

Outcome  
Confirmed visibility into administrative activity and identity lifecycle events.

Skills practiced  
Privilege monitoring awareness  
Administrative action detection  
Identity lifecycle analysis  

💻 Sysmon Telemetry Exploration  
Advanced endpoint telemetry collected via Sysmon was explored to enhance behavioral monitoring capabilities.

Actions performed  
Queried process creation events (EventCode 1)  
Analyzed top executed processes across the endpoint  
Queried network connection events (EventCode 3)  
Queried file creation events (EventCode 11)  

Outcome  
Developed operational familiarity with behavioral telemetry and process-driven activity analysis.

Skills practiced  
Process telemetry exploration  
Host-based network monitoring  
File activity awareness  

🧭 Field-Level Event Inspection  
Individual events were inspected to understand available metadata and contextual fields.

Actions performed  
Opened raw event views within Splunk  
Reviewed common metadata fields such as host, source, sourcetype, and EventCode  
Observed enriched event attributes from Sysmon telemetry  

Outcome  
Improved ability to interpret event structure and leverage field-level context during investigations.

Skills practiced  
Field discovery  
Event schema interpretation  
Metadata contextualization  

🔍 Filtering & Targeted Search  
Focused filtering techniques were applied to locate specific activity within the dataset.

Actions performed  
Filtered Sysmon process events for specific applications  
Applied field-based search constraints  
Validated ability to locate previously generated lab activity  

Outcome  
Confirmed capability to perform targeted telemetry searches and isolate relevant activity.

Skills practiced  
Search refinement  
Pattern matching  
Targeted investigation workflow  

📊 Dashboard Creation & Visualization  
A simple dashboard panel was created to visualize authentication activity and introduce SIEM visualization workflows.

Actions performed  
Constructed query aggregating failed authentication events  
Saved query output as dashboard panel  
Configured visualization for authentication overview  

Outcome  
Established baseline dashboard demonstrating authentication monitoring use case.

Skills practiced  
SIEM visualization  
Dashboard panel creation  
Operational monitoring design  

🧠 Knowledge Gained  
Importance of data discovery when entering new SIEM environments  
Role of time scoping in investigation workflows  
Authentication telemetry as a primary SOC monitoring source  
Administrative activity visibility through Windows Security logs  
Behavioral monitoring enabled by Sysmon telemetry  
Value of field-level inspection for contextual understanding  
Dashboarding as a mechanism for operational awareness  

✅ Day 11 Checklist  
Executed host discovery queries  
Reviewed sourcetype distribution  
Explored multiple time ranges within Splunk  
Analyzed successful authentication events  
Analyzed failed authentication events  
Reviewed privilege assignment telemetry  
Reviewed account creation telemetry  
Explored Sysmon process creation events  
Explored Sysmon network connection events  
Explored Sysmon file creation events  
Inspected individual event fields and metadata  
Performed targeted filtered searches  
Created authentication monitoring dashboard panel  
Captured representative SIEM exploration screenshots  