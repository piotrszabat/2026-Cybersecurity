Day 8 continued the development of core SOC telemetry analysis skills by performing a deep dive into Windows Security Event Logs.  
The objective of this lab was to intentionally generate key authentication, privilege, and account management events within the HomeLab environment and analyze their structure, context, and investigative value.

This exercise reinforced the importance of Windows Security logs as a primary identity and host telemetry source while strengthening event filtering, interpretation, and timeline reconstruction skills aligned with SOC analyst workflows.

🔎 Security Audit Policy Validation  
Before analyzing events, Windows audit policies were reviewed and configured to ensure sufficient logging coverage.

Actions performed  
Executed `auditpol /get /category:*` to review current audit configuration  
Enabled success and failure auditing for:  
Logon/Logoff  
Account Logon  
Account Management  
Privilege Use  

Outcome  
Confirmed that the system was generating authentication and account management telemetry required for SOC monitoring.

Skills practiced  
Audit policy verification  
Telemetry readiness validation  
Host logging configuration awareness  

🔐 Targeted Security Event Filtering  
To streamline analysis, targeted filtering of high-value Security events was performed.

Actions performed  
Opened Event Viewer (eventvwr.msc)  
Navigated to Windows Logs → Security  
Applied filter for Event IDs:  
4624 Successful logon  
4625 Failed logon  
4634 Logoff  
4672 Special privileges assigned  
4720 User account created  
Created custom view SOC-Day8-CoreSecurity

Outcome  
Established rapid access to core authentication and identity lifecycle telemetry.

Skills practiced  
Event filtering techniques  
Custom view creation  
SOC workflow optimization  

🧪 Controlled Event Generation  
Relevant security events were intentionally generated to ensure predictable telemetry for analysis.

Actions performed  
Performed interactive login and logoff sequence  
Executed multiple failed authentication attempts  
Initiated administrative session triggering privilege assignment event  
Created local test user account  

Outcome  
Successfully produced representative authentication and account management telemetry within the lab environment.

Skills practiced  
Telemetry generation methodology  
Lab-driven behavioral simulation  
Security event reproducibility  

🔍 Authentication Event Field Analysis  
Detailed inspection of authentication events was conducted to understand key investigative attributes.

Activities performed  
Reviewed Event 4624 and 4625 details  
Analyzed Account Name, Subject, Target, and Source fields  
Examined Failure Reason and Status codes for failed authentication  
Compared contextual metadata across events  

Outcome  
Developed deeper understanding of authentication context and investigative data points contained within Windows Security events.

Skills practiced  
Event field interpretation  
Authentication context analysis  
Identity telemetry understanding  

🛡️ Privilege Assignment Visibility  
Administrative activity was analyzed through privilege assignment telemetry.

Actions performed  
Triggered administrative session  
Reviewed Event 4672 details  
Examined associated account and timestamp correlation with logon activity  

Outcome  
Confirmed visibility of privileged session initiation within Security logs.

Skills practiced  
Privilege monitoring awareness  
Administrative session detection  
Event correlation techniques  

👤 Account Creation Monitoring  
Identity lifecycle telemetry was explored through account creation simulation.

Actions performed  
Created local test account via administrative command  
Located corresponding Event 4720  
Reviewed Subject vs Target account fields  

Outcome  
Validated monitoring capability for identity provisioning events.

Skills practiced  
Identity lifecycle monitoring  
Administrative activity auditing  
Security event interpretation  

💻 PowerShell Security Log Querying  
Security logs were queried programmatically to simulate SIEM style analysis.

Actions performed  
Executed PowerShell queries using Get-WinEvent  
Filtered Security log by multiple Event IDs  
Retrieved recent failed authentication events  
Formatted output for analysis  

Outcome  
Demonstrated ability to perform automated log extraction and targeted querying outside GUI tools.

Skills practiced  
PowerShell log querying  
Automation mindset development  
SIEM preparation skills  

📊 Activity Timeline Reconstruction  
A structured sequence of generated events was correlated to form a behavioral timeline.

Activities performed  
Generated failed authentication attempts  
Performed successful login  
Observed privilege assignment event  
Created user account  
Performed logoff  
Ordered events chronologically  

Outcome  
Constructed a coherent activity timeline representing user authentication and administrative behavior.

Skills practiced  
Event correlation  
Timeline based investigation  
Behavioral reconstruction  

🧠 Knowledge Gained  
Windows audit policy configuration impact on telemetry visibility  
Importance of targeted event filtering for analyst efficiency  
Contextual interpretation of authentication events  
Visibility of privilege assignment within administrative sessions  
Identity provisioning monitoring through Security logs  
PowerShell as an alternative log analysis interface  
Correlation of discrete events into investigative timelines  

✅ Day 8 Checklist  
Validated Windows audit policy configuration  
Created targeted Security event filter and custom view  
Generated successful authentication telemetry  
Generated failed authentication telemetry  
Observed logoff activity  
Detected privilege assignment event  
Detected user account creation event  
Queried Security logs using PowerShell  
Constructed activity timeline from correlated events 

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