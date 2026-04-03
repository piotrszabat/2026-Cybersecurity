Day 19 continued the Detection Engineering phase by focusing on suspicious process detection using Sysmon process creation telemetry ingested into Splunk.  
The objective of this lab was to design and validate detection logic capable of identifying high-risk Windows binaries (LOLBins), abnormal execution patterns, and suspicious process locations that are commonly associated with attacker tradecraft.

This exercise simulated SOC endpoint monitoring workflows where analysts detect malicious execution by correlating process metadata such as command line arguments, parent-child relationships, and execution paths. The lab emphasized baseline building, high-signal process detection, controlled event generation for validation, enrichment for investigation readiness, and SIEM rule operationalization.

🔎 Telemetry Validation & Process Creation Readiness  
Initial validation was performed to confirm that Sysmon Process Create telemetry (EventCode 1) was available and contained required investigative fields.

Actions performed  
Queried Sysmon Operational logs for EventCode 1  
Inspected raw process creation events for key fields (Image, CommandLine, ParentImage, User, Hashes)  
Validated that process telemetry was searchable and consistently ingested into Splunk  

Outcome  
Confirmed that Sysmon process creation telemetry was ready for detection engineering and investigation workflows.

Skills practiced  
Telemetry validation  
Sysmon event inspection  
Process telemetry awareness  

📊 Baseline Development — Top Executed Processes  
A baseline view of normal process activity was created to provide context for suspicious execution detection.

Actions performed  
Aggregated process creation events by executable image path  
Reviewed most frequently executed processes on the endpoint  
Established baseline expectations for common process behavior within the lab  

Outcome  
Built baseline awareness to support tuning decisions and reduce false positives during detection development.

Skills practiced  
Baseline building  
Process frequency analysis  
SOC context development  

🚨 Detection Rule A — Suspicious LOLBin Execution  
A detection query was engineered to identify executions of common LOLBins frequently abused for execution, proxying, and living-off-the-land techniques.

Actions performed  
Developed SPL query targeting Sysmon EventCode 1  
Matched high-signal binaries such as certutil, mshta, rundll32, regsvr32, wmic, bitsadmin, schtasks, sc, and related tools  
Returned investigation-ready context fields (host, user, image, command line, parent process)  
Validated results in Splunk over a defined time range  

Outcome  
Established detection capability to surface high-risk LOLBin executions for SOC triage and investigation.

Skills practiced  
LOLBins detection engineering  
Command-line visibility analysis  
Investigation context enrichment  

🚨 Detection Rule B — Execution from Suspicious Paths  
A complementary detection query was developed to identify processes executed from user-writable and commonly abused directories.

Actions performed  
Built SPL query to match executable paths in AppData, Temp, Downloads, and Public locations  
Reviewed results for non-standard execution behavior  
Confirmed query structure for identifying userland execution patterns  

Outcome  
Improved detection coverage for common malware staging and execution locations.

Skills practiced  
Execution path analysis  
Suspicious location detection  
Behavioral detection coverage  

🧪 Controlled Validation — Safe Suspicious-Like Activity Generation  
Controlled process executions were generated to validate that detection logic triggered correctly.

Actions performed  
Executed benign but suspicious-looking LOLBin commands (e.g., certutil, mshta, rundll32)  
Ensured commands remained non-malicious while producing realistic telemetry patterns  
Re-ran detection queries within the validation window to confirm capture  

Outcome  
Confirmed detection rules successfully identified controlled LOLBin activity and generated investigation-ready results.

Skills practiced  
Detection validation methodology  
Safe adversary technique simulation  
Telemetry-to-detection verification  

📌 Enrichment for Investigation Readiness  
Detection output was enhanced to better support analyst triage and investigation workflows.

Actions performed  
Included additional fields such as hashes, parent process context, user identity, and first/last seen timestamps  
Aggregated repeated executions to identify persistent or recurring patterns  
Formatted output to be alert-friendly and analyst-readable  

Outcome  
Produced enriched detection output suitable for SOC triage and escalation workflows.

Skills practiced  
Alert context enrichment  
Process relationship analysis  
Investigation-ready formatting  

💾 Detection Operationalization in Splunk  
Detection logic was saved as a persistent SIEM artifact to emulate production SOC workflows.

Actions performed  
Saved suspicious process detection queries as Saved Search / Alert  
Applied SOC-aligned naming conventions  
Documented detection purpose and expected trigger behavior  

Outcome  
Operationalized suspicious process detection as a reusable rule within the SIEM platform.

Skills practiced  
SIEM operationalization  
Detection lifecycle management  
Detection documentation  

🧠 Knowledge Gained  
Sysmon process creation telemetry as a primary endpoint detection source  
Value of baselining before building process-based detections  
LOLBins as a common attacker technique for living-off-the-land execution  
Suspicious execution paths as indicators of malware staging or userland execution  
Importance of enrichment (hashes, parents, command lines) for effective SOC triage  
Workflow for building, validating, and operationalizing detection rules in Splunk  

✅ Day 19 Checklist  
Validated Sysmon Process Create telemetry ingestion (EventCode 1)  
Built baseline view of top executed processes  
Developed LOLBin-based suspicious process detection query  
Developed suspicious path execution detection query  
Generated controlled suspicious-like process activity for validation  
Confirmed detections triggered on generated activity  
Enhanced detection output with enrichment fields and timestamps  
Saved detections as persistent Saved Searches / Alerts in Splunk  
Captured representative screenshots and documented detection workflow  