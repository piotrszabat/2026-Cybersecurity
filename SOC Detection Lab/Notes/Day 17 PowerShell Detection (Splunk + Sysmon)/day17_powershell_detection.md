Day 17 continued the Detection Engineering phase by focusing on PowerShell detection within the HomeLab environment.  
The objective of this lab was to engineer and validate a practical detection rule for identifying suspicious PowerShell executions using Sysmon telemetry ingested into Splunk.

This exercise simulated a common SOC detection use case where PowerShell is leveraged for execution, obfuscation, and payload delivery. The lab emphasized baseline visibility, suspicious command-line pattern detection, controlled activity simulation, detection tuning considerations, and operationalization as a persistent SIEM rule.

🔎 Telemetry Validation & PowerShell Visibility  
Initial validation was performed to confirm that Sysmon process creation telemetry captured PowerShell execution activity.

Actions performed  
Queried Sysmon Process Create events (EventCode 1) for powershell.exe / pwsh.exe  
Inspected raw events to confirm presence of key fields such as Image, CommandLine, ParentImage, User, and timestamps  
Validated that PowerShell executions were searchable within Splunk  

Outcome  
Confirmed availability of PowerShell execution telemetry required for detection engineering.

Skills practiced  
Telemetry validation  
Event field inspection  
Sysmon process telemetry analysis  

📊 Baseline Query — PowerShell Execution Overview  
A baseline query was developed to establish visibility into PowerShell usage patterns.

Actions performed  
Built SPL query summarizing PowerShell executions by host and user  
Reviewed execution volume and parent process context  
Established baseline expectations for legitimate PowerShell activity within the lab  

Outcome  
Created operational awareness of PowerShell execution patterns before applying suspicious detection logic.

Skills practiced  
Baseline building  
Aggregation query design  
Operational telemetry interpretation  

🧪 Controlled PowerShell Activity Simulation  
PowerShell activity was intentionally generated to validate detection capability under realistic execution patterns.

Actions performed  
Executed standard PowerShell commands to generate benign activity  
Simulated suspicious execution patterns using command-line flags and behaviors commonly seen in attacks  
Generated EncodedCommand-style execution to emulate obfuscation techniques  

Outcome  
Successfully created representative PowerShell telemetry suitable for detection validation and tuning.

Skills practiced  
Controlled telemetry generation  
Adversary behavior simulation (safe)  
Detection validation preparation  

🚨 Detection Rule Development — Suspicious PowerShell Command Lines  
A detection query was engineered to identify suspicious PowerShell executions based on high-signal command-line indicators.

Actions performed  
Constructed SPL query targeting Sysmon EventCode 1 PowerShell executions  
Normalized command-line content for pattern matching  
Detected suspicious indicators including EncodedCommand, obfuscation, hidden window execution, and download/execution patterns  
Returned investigation-ready context fields including host, user, parent process, image, and full command line  

Outcome  
Developed functional detection logic that reliably identified suspicious PowerShell executions generated during the lab.

Skills practiced  
Detection engineering fundamentals  
Command-line pattern detection  
Field normalization and enrichment  

🔧 Detection Tuning Considerations  
Basic tuning mindset was applied to reduce noise and improve detection fidelity.

Actions performed  
Reviewed detection results for benign PowerShell executions  
Confirmed suspicious matching focused on high-signal indicators rather than generic PowerShell usage  
Considered allowlisting approaches based on parent processes and known-safe patterns  

Outcome  
Improved detection quality by emphasizing high-confidence indicators and minimizing baseline noise.

Skills practiced  
Detection tuning mindset  
False positive awareness  
Rule quality improvement  

💾 Detection Operationalization in Splunk  
The detection logic was persisted as a reusable SIEM rule to simulate production SOC workflows.

Actions performed  
Saved the detection query as a Saved Search / Alert in Splunk  
Applied SOC-style naming conventions  
Documented detection scope and expected trigger conditions  

Outcome  
Established a persistent SIEM detection artifact for suspicious PowerShell execution monitoring.

Skills practiced  
SIEM operationalization  
Detection lifecycle management  
Detection documentation  

🧠 Knowledge Gained  
PowerShell as a high-value detection surface in SOC environments  
Sysmon process creation telemetry as a primary source for PowerShell monitoring  
Common high-signal PowerShell indicators such as EncodedCommand and hidden execution  
Importance of baseline visibility before building detections  
Workflow for detection engineering: validate → build → simulate → tune → operationalize  

✅ Day 17 Checklist  
Validated Sysmon Process Create telemetry for PowerShell executions  
Built baseline PowerShell visibility query  
Generated benign PowerShell activity for baseline comparison  
Simulated suspicious PowerShell behavior (safe)  
Simulated EncodedCommand execution pattern  
Developed suspicious PowerShell detection query in Splunk  
Validated detection successfully triggered on simulated activity  
Saved detection as a persistent Saved Search / Alert  
Captured representative screenshots and documented detection workflow  