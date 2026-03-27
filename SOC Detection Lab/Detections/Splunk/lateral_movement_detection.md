Day 20 introduced lateral movement simulation into the HomeLab environment, marking a transition from isolated detection engineering toward full attack chain awareness.  
The objective of this lab was to simulate internal attacker movement between hosts and observe the resulting telemetry across Windows Security logs, Sysmon endpoint telemetry, and SIEM correlation within Splunk.

This exercise replicated a common adversary workflow where authenticated access is leveraged to move laterally within a network. The lab emphasized connectivity validation, remote authentication activity, simulated remote command execution, telemetry validation across multiple log sources, and timeline-based investigation within the SIEM.

🌐 Connectivity Validation & Attack Surface Confirmation  
Initial reconnaissance and connectivity validation were performed from the attacker VM to ensure target reachability prior to lateral movement attempts.

Actions performed  
Validated ICMP connectivity from KALI01 to PC01  
Executed targeted port scan to confirm SMB service exposure  
Confirmed target host accessibility required for lateral movement simulation  

Outcome  
Established verified network reachability between attacker and target systems.

Skills practiced  
Network reconnaissance  
Service exposure validation  
Attack surface awareness  

🔐 Remote Authentication Simulation (SMB)  
Authenticated access attempts were performed to simulate credential-based lateral movement behavior.

Actions performed  
Executed SMB authentication attempt from Kali attacker VM  
Observed authentication success indicators within attack tooling output  
Confirmed generation of network logon telemetry on target endpoint  

Outcome  
Successfully simulated credential-based remote authentication indicative of lateral movement preparation.

Skills practiced  
Credential-based access simulation  
Authentication telemetry generation  
Lateral movement workflow awareness  

💻 Remote Command Execution Simulation  
Remote execution capability was simulated to emulate attacker post-authentication activity on the target system.

Actions performed  
Executed remote command invocation against target endpoint  
Observed command execution feedback within attacker tooling  
Confirmed creation of process and network telemetry on target host  

Outcome  
Successfully simulated remote command execution behavior consistent with lateral movement techniques.

Skills practiced  
Remote execution simulation  
Execution telemetry generation  
Adversary behavior modeling  

📊 Windows Security Log Validation  
Windows Security logs were reviewed to confirm authentication artifacts produced during the simulation.

Actions performed  
Reviewed Security log for network logon events (EventCode 4624)  
Inspected privilege assignment and process-related events  
Validated account context and logon type associated with simulated activity  

Outcome  
Confirmed visibility of lateral authentication behavior within Windows Security telemetry.

Skills practiced  
Authentication log analysis  
Logon type interpretation  
Identity-based investigation  

🖥️ Sysmon Telemetry Validation  
Sysmon endpoint telemetry was analyzed to capture process and network activity generated during lateral movement.

Actions performed  
Reviewed Sysmon Process Create events for remotely executed processes  
Reviewed Sysmon Network Connection events associated with attacker host  
Analyzed parent-child process relationships for contextual awareness  

Outcome  
Validated endpoint-level behavioral visibility supporting lateral movement detection.

Skills practiced  
Endpoint behavioral analysis  
Process relationship interpretation  
Network-process correlation  

🔎 SIEM Correlation & Timeline Construction  
Splunk was used to correlate multi-source telemetry and construct a chronological view of the simulated attack.

Actions performed  
Queried authentication events within Splunk to identify network logons  
Queried Sysmon process creation telemetry associated with remote execution  
Queried network connection telemetry for attacker-target communications  
Constructed timeline view combining authentication, process, and network events  

Outcome  
Produced correlated investigation timeline representing simulated lateral movement activity.

Skills practiced  
SIEM correlation  
Timeline-based investigation  
Multi-source telemetry analysis  

🧠 Knowledge Gained  
Conceptual workflow of credential-based lateral movement within enterprise environments  
Importance of authentication telemetry in identifying remote access behavior  
Role of Sysmon in exposing execution context following remote authentication  
Value of correlating authentication, process, and network telemetry for investigation completeness  
Practical SOC workflow for reconstructing attacker activity through timeline analysis  

✅ Day 20 Checklist  
Validated attacker-to-target connectivity and SMB exposure  
Performed remote authentication attempt from Kali attacker VM  
Simulated remote command execution against target endpoint  
Observed authentication artifacts within Windows Security logs  
Observed process and network telemetry within Sysmon logs  
Queried authentication telemetry in Splunk  
Queried process and network telemetry in Splunk  
Constructed correlated investigation timeline within SIEM  
Captured representative screenshots across attack and analysis stages  
Documented lateral movement workflow and observations  