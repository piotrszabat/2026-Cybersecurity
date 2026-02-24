Day 14 introduced the attacker perspective into the HomeLab by deploying a Kali Linux virtual machine and validating connectivity across the lab infrastructure.  
The objective of this lab was to prepare an offensive testing node capable of interacting with internal assets, performing reconnaissance, and supporting future attack simulation activities.

This exercise simulated the initial stages of adversary presence within a network environment, where connectivity validation and reconnaissance are essential prerequisites for subsequent exploitation or lateral movement. The lab focused on virtual machine provisioning, network integration, connectivity validation, and baseline port scanning to confirm attacker reachability within the SOC HomeLab topology.

🖥️ Kali Attacker VM Deployment  
A dedicated Kali Linux virtual machine was provisioned to represent an attacker workstation within the HomeLab environment.

Actions performed  
Downloaded Kali Linux installation media  
Created KALI01 virtual machine within VirtualBox  
Allocated appropriate compute and storage resources  
Configured network adapter to join existing NAT Network segment  
Completed Kali installation and initial system configuration  

Outcome  
Successfully deployed an attacker simulation platform within the lab environment.

Skills practiced  
Virtual machine provisioning  
Offensive tooling environment preparation  
Lab infrastructure expansion  

🌐 Network Integration & Addressing Validation  
The Kali VM was integrated into the HomeLab network to enable communication with existing infrastructure components.

Actions performed  
Enumerated network interfaces and routing configuration  
Identified assigned IP address for KALI01  
Confirmed default gateway configuration  
Validated network placement alongside PC01, DC01, and SPLK01  

Outcome  
Established correct network positioning of attacker VM within the shared lab segment.

Skills practiced  
Network interface inspection  
Virtual networking validation  
Endpoint addressing awareness  

📡 Connectivity Testing Across Lab Assets  
Basic connectivity testing was performed to confirm reachability between the attacker VM and internal hosts.

Actions performed  
Executed ICMP connectivity tests from Kali to PC01  
Executed ICMP connectivity tests from Kali to SPLK01  
Executed ICMP connectivity tests from Kali to DC01  
Verified successful bidirectional network communication  

Outcome  
Confirmed attacker VM reachability to critical lab infrastructure components.

Skills practiced  
Connectivity validation  
Internal network reconnaissance  
Host reachability verification  

🔎 Baseline Reconnaissance via Port Scanning  
Initial reconnaissance was conducted using Nmap to identify exposed services on internal hosts.

Actions performed  
Executed TCP SYN scan against PC01 using top ports profile  
Executed TCP SYN scan against DC01 to enumerate available services  
Observed open ports and service indicators  
Saved scan results to output files for documentation  

Outcome  
Established baseline understanding of accessible network services from attacker perspective.

Skills practiced  
Network reconnaissance  
Port scanning methodology  
Service exposure awareness  

📊 Topology Visualization & Documentation  
The HomeLab architecture was documented to reflect the addition of the attacker node and network relationships.

Actions performed  
Identified key infrastructure components within lab environment  
Mapped relationships between DC01, PC01, SPLK01, and KALI01  
Created visual topology diagram representing network segmentation and roles  

Outcome  
Produced architecture artifact illustrating lab layout and attacker positioning.

Skills practiced  
Infrastructure documentation  
Topology visualization  
Architecture awareness  

🧠 Knowledge Gained  
Role of attacker simulation within SOC HomeLab environments  
Importance of connectivity validation prior to offensive operations  
Baseline reconnaissance as an initial adversary activity  
Visibility of exposed services from internal network perspective  
Value of topology documentation for understanding attack surface and monitoring coverage  

✅ Day 14 Checklist  
Provisioned Kali Linux virtual machine (KALI01)  
Integrated Kali VM into shared NAT Network segment  
Validated IP addressing and routing configuration  
Confirmed connectivity to PC01, SPLK01, and DC01  
Executed baseline Nmap scan against PC01  
Executed baseline Nmap scan against DC01  
Saved scan output artifacts for documentation  
Created HomeLab topology diagram including attacker node  
Captured representative screenshots of connectivity and scan results  
Documented connectivity and reconnaissance observations  