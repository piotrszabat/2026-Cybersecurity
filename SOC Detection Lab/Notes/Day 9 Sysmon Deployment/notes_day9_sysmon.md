Day 9 introduced advanced host telemetry capabilities through the deployment of Sysmon within the HomeLab environment.  
The objective of this lab was to enhance endpoint visibility beyond native Windows logging by capturing detailed process, file, and network activity.

This exercise simulated real SOC telemetry enrichment workflows, where Sysmon is commonly deployed to support threat detection, investigation, and behavioral analysis. The lab focused on installation, configuration using a community baseline, and controlled event generation to validate telemetry collection.

⚙️ Sysmon Deployment Preparation  
Prior to installation, required binaries and configuration files were transferred into the virtual machine environment.

Actions performed  
Downloaded Sysmon (Sysinternals) package  
Transferred files from host to VM using VirtualBox Guest Additions  
Organized Sysmon binaries within dedicated tools directory  
Downloaded SwiftOnSecurity Sysmon configuration baseline  

Outcome  
Prepared structured deployment environment enabling controlled Sysmon installation.

Skills practiced  
Artifact transfer between host and VM  
Tool staging and organization  
Operational readiness for endpoint instrumentation  

🛠️ Sysmon Installation & Configuration  
Sysmon was deployed using an established community configuration to ensure meaningful telemetry collection.

Actions performed  
Executed Sysmon64 installer with configuration file  
Accepted license and completed installation  
Verified Sysmon service status  
Navigated to Sysmon Operational log within Event Viewer  

Outcome  
Successfully deployed Sysmon service and confirmed operational telemetry pipeline.

Skills practiced  
Endpoint instrumentation  
Service verification  
Advanced logging enablement  

📊 Sysmon Telemetry Exploration  
The Sysmon Operational channel was reviewed to understand event structure and metadata richness compared to native Windows logs.

Activities performed  
Opened Applications and Services Logs → Microsoft → Windows → Sysmon → Operational  
Observed initial system activity events  
Reviewed event schema and available metadata fields  

Outcome  
Developed baseline awareness of Sysmon event structure and logging behavior.

Skills practiced  
Log source familiarization  
Telemetry schema awareness  
Advanced event inspection  

🧪 Process Creation Monitoring  
Process execution telemetry was generated to validate process visibility.

Actions performed  
Executed Notepad and Calculator processes  
Filtered Sysmon log for Event ID 1 (Process Create)  
Reviewed key event attributes including image path, command line, parent process, user, and hashes  

Outcome  
Confirmed detailed process execution visibility including parent-child relationships and execution context.

Skills practiced  
Process telemetry analysis  
Execution context interpretation  
Behavioral monitoring foundations  

📁 File Creation Monitoring  
File system activity telemetry was validated through controlled artifact creation.

Actions performed  
Created temporary test file within user temp directory  
Modified file contents  
Filtered Sysmon log for Event ID 11 (File Create)  
Reviewed target filename and initiating process  

Outcome  
Confirmed visibility into file creation activity and associated process context.

Skills practiced  
File activity monitoring  
Artifact tracking  
Host-based behavioral visibility  

🌐 Network Connection Monitoring  
Network telemetry generation was performed to validate outbound connection logging.

Actions performed  
Generated outbound connectivity using curl and ICMP traffic  
Filtered Sysmon log for Event ID 3 (Network Connection)  
Analyzed destination IP, port, protocol, and initiating process  

Outcome  
Validated host-level network visibility including process-to-network correlation.

Skills practiced  
Network telemetry analysis  
Process-network correlation  
Endpoint network monitoring awareness  

💻 PowerShell Log Querying  
Sysmon telemetry was queried programmatically to reinforce automation and SIEM-aligned workflows.

Actions performed  
Queried Sysmon Operational log using Get-WinEvent  
Retrieved recent events across categories  
Filtered specifically for process creation events  

Outcome  
Demonstrated ability to extract Sysmon telemetry outside GUI tools and prepare for SIEM ingestion scenarios.

Skills practiced  
PowerShell telemetry querying  
Automation mindset  
Query-driven investigation  

🧠 Knowledge Gained  
Sysmon as an advanced endpoint telemetry source  
Importance of community-driven configurations for detection readiness  
Enhanced visibility into process execution and parent-child relationships  
File creation telemetry for artifact tracking  
Host-based network telemetry for process-to-destination mapping  
PowerShell as an alternative telemetry access method  
Operational workflow for endpoint instrumentation and validation  

✅ Day 9 Checklist  
Transferred Sysmon artifacts from host to VM  
Installed Sysmon with SwiftOnSecurity configuration  
Verified Sysmon service operational status  
Reviewed Sysmon Operational log baseline  
Generated and analyzed process creation telemetry (Event ID 1)  
Generated and analyzed file creation telemetry (Event ID 11)  
Generated and analyzed network connection telemetry (Event ID 3)  
Queried Sysmon telemetry via PowerShell  
Captured representative Sysmon event examples  