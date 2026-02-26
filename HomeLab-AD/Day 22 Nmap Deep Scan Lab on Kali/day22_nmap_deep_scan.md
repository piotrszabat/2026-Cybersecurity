Day 22 marked the beginning of the Network Security & Attacks phase by introducing structured network reconnaissance using Nmap within the HomeLab environment.  
The objective of this lab was to perform methodical host discovery, service enumeration, and deep scanning across internal assets to establish a baseline understanding of network exposure and attack surface.

This exercise simulated an attacker reconnaissance workflow where internal infrastructure is systematically profiled prior to exploitation. The lab emphasized multi-stage scanning methodology, output preservation, service identification, safe enumeration using NSE scripts, and security-oriented analysis of discovered services.

🌐 Asset Identification & Scan Preparation  
The lab began with identification of target assets and preparation of a structured scanning workspace.

Actions performed  
Documented IP addresses and roles of DC01, PC01, and SPLK01 hosts  
Created dedicated directory structure for scan outputs and screenshots  
Validated network connectivity from Kali attacker VM to target hosts  

Outcome  
Established organized scanning environment and confirmed reachability of target systems.

Skills practiced  
Asset inventory awareness  
Lab organization and artifact management  
Pre-scan reconnaissance preparation  

🔎 Host Discovery & Network Mapping  
Network discovery techniques were applied to identify active hosts within the lab subnet.

Actions performed  
Executed ICMP-based host discovery scan across local subnet  
Validated responsive hosts and correlated results with known asset inventory  
Confirmed visibility of HomeLab systems from attacker perspective  

Outcome  
Generated network-level awareness of reachable hosts and verified scanning scope.

Skills practiced  
Host discovery techniques  
Network visibility assessment  
Reconnaissance workflow development  

📡 TCP Service Enumeration — Top Ports Scan  
A baseline TCP scan targeting commonly exposed services was performed across all hosts.

Actions performed  
Executed SYN-based scan targeting top 1000 TCP ports  
Identified open services across domain controller, workstation, and SIEM host  
Captured results to persistent output files for later analysis  

Outcome  
Established initial service exposure baseline across lab infrastructure.

Skills practiced  
Service enumeration  
TCP scanning methodology  
Attack surface identification  

🧠 Deep TCP Scanning & Version Detection  
Comprehensive TCP scanning and service fingerprinting were performed to gain deeper insight into exposed services.

Actions performed  
Executed full TCP port scans against individual hosts  
Performed version detection and default script scanning on identified open ports  
Reviewed results to identify infrastructure roles and service characteristics  

Outcome  
Obtained detailed service fingerprinting enabling infrastructure profiling and security assessment.

Skills practiced  
Deep scanning methodology  
Service fingerprint interpretation  
Infrastructure role inference  

📦 UDP Scan Exploration  
A targeted UDP scan was conducted to identify additional services not observable through TCP enumeration.

Actions performed  
Executed top-port UDP scan against selected host  
Reviewed UDP response behavior and open|filtered results  
Documented potential UDP-based services  

Outcome  
Expanded network visibility to include UDP-based service exposure.

Skills practiced  
UDP scanning awareness  
Protocol diversity in reconnaissance  
Scan result interpretation  

🛡️ NSE-Based Safe Enumeration  
Safe enumeration scripts were leveraged to gather contextual service information without exploitation.

Actions performed  
Executed SMB enumeration scripts to identify OS and SMB configuration details  
Executed HTTP enumeration scripts against web-exposed services  
Reviewed script outputs for environmental context and security-relevant configuration data  

Outcome  
Collected enriched reconnaissance intelligence supporting infrastructure understanding.

Skills practiced  
Nmap NSE utilization  
Service enumeration techniques  
Configuration visibility analysis  

💾 Scan Output Preservation & Artifact Generation  
All scanning activities were documented through persistent output artifacts to support investigation and reporting workflows.

Actions performed  
Saved scan outputs in multiple formats including standard and XML  
Organized artifacts within structured directory hierarchy  
Verified completeness of scan evidence  

Outcome  
Produced reusable reconnaissance artifacts suitable for documentation and future analysis.

Skills practiced  
Artifact preservation  
Operational documentation practices  
Investigation readiness  

🧩 Security Analysis & Attack Surface Reflection  
Scan results were analyzed from a defensive perspective to identify exposed services and potential risk areas.

Actions performed  
Reviewed discovered services on each host relative to system role  
Identified management interfaces and infrastructure-critical services  
Reflected on potential hardening opportunities such as service restriction and firewall controls  

Outcome  
Developed security-oriented understanding of internal network exposure and asset attack surface.

Skills practiced  
Attack surface analysis  
Defensive security reasoning  
Infrastructure exposure assessment  

🧠 Knowledge Gained  
Structured multi-phase network reconnaissance methodology  
Differences between discovery, baseline scanning, and deep enumeration  
Importance of preserving reconnaissance artifacts for investigation workflows  
Role of safe enumeration in understanding infrastructure configuration  
Relationship between exposed services and potential attack surface  
Defensive insights derived from attacker-style reconnaissance  

✅ Day 22 Checklist  
Documented target asset inventory and IP addresses  
Validated connectivity from attacker VM to targets  
Performed subnet host discovery scan  
Executed top-port TCP enumeration across hosts  
Performed full TCP port scans per host  
Executed version detection and default script scans  
Conducted targeted UDP scanning  
Executed safe NSE-based enumeration (SMB/HTTP)  
Saved scan outputs in persistent formats  
Captured representative screenshots of scanning stages  
Documented security observations and attack surface analysis  