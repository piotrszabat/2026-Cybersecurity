Day 21 concluded the Detection Engineering phase by focusing on MITRE ATT&CK mapping of previously developed detections within the HomeLab environment.  
The objective of this lab was to translate implemented detection capabilities into a structured threat-informed defense perspective by aligning each detection with corresponding MITRE ATT&CK techniques and tactics.

This exercise simulated a core detection engineering responsibility where security controls and analytics are evaluated against known adversary behaviors to measure defensive coverage, identify gaps, and support strategic SOC visibility. The lab emphasized retrospective detection analysis, technique attribution, coverage documentation, and reflection on detection maturity.

🧭 Detection Inventory Review  
An inventory review was conducted across previously implemented detection rules to establish the mapping scope.

Actions performed  
Reviewed detection engineering activities completed during Days 15–20  
Identified primary detection objectives and monitored behaviors  
Documented detection logic and telemetry sources for each rule  

Outcome  
Established a structured detection inventory ready for ATT&CK mapping.

Skills practiced  
Detection cataloging  
Threat-informed analysis preparation  
Detection lifecycle awareness  

🧠 MITRE ATT&CK Framework Familiarization  
The MITRE ATT&CK framework structure was reviewed to understand how detections align with adversary tactics and techniques.

Actions performed  
Reviewed ATT&CK tactical categories relevant to implemented detections  
Examined technique definitions corresponding to authentication abuse, account manipulation, execution, and lateral movement  
Established mapping methodology linking detection behavior to adversary technique  

Outcome  
Developed foundational understanding of threat-informed defense mapping workflows.

Skills practiced  
MITRE ATT&CK interpretation  
Technique-to-detection alignment  
Threat modeling mindset  

🔎 Detection-to-Technique Mapping  
Each detection rule was analyzed and mapped to relevant ATT&CK techniques based on observed behavior and monitored telemetry.

Actions performed  
Mapped failed authentication monitoring to brute-force techniques  
Mapped account creation and privilege assignment monitoring to identity persistence techniques  
Mapped suspicious PowerShell execution detection to execution techniques  
Mapped suspicious process detection to living-off-the-land execution techniques  
Mapped lateral movement simulation telemetry to remote services techniques  

Outcome  
Produced structured alignment between HomeLab detection capabilities and known adversary behaviors.

Skills practiced  
Threat-informed detection analysis  
Behavioral attribution  
Detection coverage mapping  

📊 ATT&CK Coverage Documentation  
A formal mapping table was created to document detection coverage across ATT&CK tactics and techniques.

Actions performed  
Constructed mapping table correlating detection day, detection focus, ATT&CK technique, and tactic category  
Validated mapping accuracy against ATT&CK documentation  
Prepared mapping artifact suitable for portfolio documentation  

Outcome  
Generated reusable ATT&CK coverage artifact demonstrating detection maturity within the HomeLab.

Skills practiced  
Security documentation  
Coverage analysis  
Portfolio artifact development  

🧩 Detection Coverage Reflection  
A reflective analysis was performed to identify strengths and gaps in detection coverage across the ATT&CK matrix.

Actions performed  
Reviewed distribution of detections across tactics  
Identified strong coverage areas such as authentication abuse and execution monitoring  
Recognized potential future coverage expansion areas including persistence, command-and-control, and data exfiltration  

Outcome  
Developed strategic awareness of detection posture and opportunities for future lab evolution.

Skills practiced  
Detection gap analysis  
Strategic security thinking  
SOC capability evaluation  

🧠 Knowledge Gained  
Importance of mapping detections to adversary behaviors rather than tools or logs  
MITRE ATT&CK as a framework for measuring detection maturity and coverage  
How authentication, execution, privilege escalation, and lateral movement detections align with ATT&CK tactics  
Value of structured documentation for communicating SOC detection capability  
Role of coverage reflection in guiding future detection engineering priorities  

---

## 📊 MITRE ATT&CK Mapping Table

| Day | Detection Focus | MITRE Technique | Technique Name | Tactic |
|-----|----------------|-----------------|---------------|--------|
| Day 15 | Failed login monitoring | T1110 | Brute Force | Credential Access |
| Day 16 | Admin account creation & privilege assignment | T1136 / T1098 | Create Account / Account Manipulation | Persistence / Privilege Escalation |
| Day 17 | Suspicious PowerShell execution | T1059.001 | Command and Scripting Interpreter: PowerShell | Execution |
| Day 18 | Brute force burst & password spray detection | T1110 | Brute Force | Credential Access |
| Day 19 | Suspicious LOLBin process execution | T1218 | Signed Binary Proxy Execution | Defense Evasion / Execution |
| Day 20 | Lateral movement simulation via remote services | T1021 | Remote Services | Lateral Movement |

---

✅ Day 21 Checklist  
Reviewed detection inventory from Days 15–20  
Studied relevant MITRE ATT&CK tactics and techniques  
Mapped each detection to corresponding ATT&CK techniques  
Constructed MITRE ATT&CK coverage mapping table  
Documented detection coverage within repository  
Reflected on strengths and gaps in detection coverage  
Produced MITRE mapping artifact for portfolio documentation  