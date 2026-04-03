# Day 1 Lab Setup Notes
Virtualization tool:
Host machine specs (CPU/RAM) - In Screenshots

Lab network:
VM1 (DC01): RAM/CPU/Disk/Network - In Screenshots
VM2 (PC01): RAM/CPU/Disk/Network - In Screenshots
Issues + fixes: no issues for now

# Day 2 – DC01 Installation and Active Directory Deployment
## Objective
Deploy a Windows Server instance and configure it as a Domain Controller for a private lab environment.
---
## Lab Environment
Hypervisor: Oracle VirtualBox  
Server Name: DC01  
Operating System: Windows Server 2022 Standard (Desktop Experience)  
Network Type: Host-Only Adapter  
Domain Name: lab.local  
---
## Step 1 – Windows Server Installation
- Created VM named **DC01**
- Allocated 4GB RAM, 2 CPUs, 60GB disk
- Installed Windows Server 2022 Standard (Desktop Experience)
- Configured local Administrator password
- Installed latest available updates
---
## Step 2 – Server Configuration
### Renamed Server
Renamed computer to:
DC01
Restarted system to apply changes.
---
### Configured Static IP Address
Set manual IPv4 configuration:
IP Address: 192.168.56.10  
Subnet Mask: 255.255.255.0  
Default Gateway: (blank – isolated lab network)  
Preferred DNS: 192.168.56.10  
Verified configuration using:
ipconfig /all
---
## Step 3 – Active Directory Domain Services Installation
Installed role:
- Active Directory Domain Services (AD DS)
Via:
Server Manager → Add Roles and Features
---
## Step 4 – Promoted Server to Domain Controller
Selected:
- Add a new forest
Domain name:
lab.local
Set Directory Services Restore Mode (DSRM) password.
Server rebooted automatically after promotion.
---
## Step 5 – Validation
After reboot:
Verified the following tools were available:
- Active Directory Users and Computers
- DNS Manager
- Group Policy Management
=============
Tested DNS resolution:
nslookup lab.local
Confirmed successful name resolution.
---
## Outcome
Successfully deployed a fully functional Domain Controller for lab.local domain with:
- Static IP configuration
- Integrated DNS
- Active Directory forest
This environment will be used to simulate real-world IT Support and SOC scenarios.

# Day 3 – PC01 Installation and Domain Join
## Objective
Deploy a Windows 11 Pro client and join it to the lab.local Active Directory domain.
---
## Lab Environment
Client Name: PC01  
Operating System: Windows 11 Pro  
Network Type: Host-Only Adapter  
Domain Controller: DC01 (192.168.56.10) 
---
## Step 1 – Windows 11 Pro Installation
- Created VM named PC01
- Allocated 4GB RAM, 2 CPUs, 60GB disk
- Installed Windows 11 Pro (Pro edition required for domain join)
- Configured initial local user account
---
## Step 2 – Renamed Computer
Renamed computer to:
PC01
Restarted system to apply changes.
---
## Step 3 – Network Configuration
Configured static IPv4 settings:
IP Address: 192.168.56.20  
Subnet Mask: 255.255.255.0  
Default Gateway: (blank – internal lab)  
Preferred DNS Server: 192.168.56.10  
Initial issue encountered:
Client received APIPA address (169.254.x.x) due to no DHCP.
Resolved by manually assigning correct IP address.
Verified connectivity:
ping 192.168.56.10
nslookup lab.local
Successful communication confirmed.
---
## Step 4 – Domain Join Process
Joined PC01 to domain:
lab.local
Used domain administrator credentials:
lab\Administrator
System rebooted successfully.
---
## Step 5 – Login Verification
Logged in using:
lab\Administrator
Confirmed:
- Domain profile creation
- Proper communication with Domain Controller
- Computer object created in Active Directory
---
## Issues Encountered & Resolution
Issue:
Domain Administrator account was disabled.
Resolution:
Re-enabled account in Active Directory Users and Computers.
Lesson:
Proper account management is critical when managing domain authentication.
---
## Outcome
Successfully deployed domain-joined client machine.
PC01 is now fully integrated into lab.local domain and ready for:
- User management simulations
- Group Policy testing
- Security log analysis
- IT support troubleshooting scenarios

Day 4 — Active Directory Operations & Group Policy Fundamentals
📅 Overview

Day 4 focused on building practical operational skills within Active Directory and gaining hands-on experience with Group Policy. The goal was to move beyond installation and begin performing tasks that reflect real IT Support responsibilities in enterprise environments.

This lab simulated daily administrative work including OU design, user and group management, and deployment of security policies through GPO.
🏗️ OU Structure Implementation
A professional Organizational Unit structure was created to replace the default flat layout.
Implemented structure:
lab.local
├── London
│   ├── Users
│   ├── Computers
│   └── Groups
└── IT
    ├── Admins
    └── ServiceAccounts
Objectives achieved:
Logical separation of resources
Preparation for targeted GPO deployment
Alignment with enterprise AD design practices
Improved manageability and scalability

👤 User Management
Multiple realistic user accounts were created within the London → Users OU to simulate an operational environment.
Configuration applied to each account:
Strong password assignment
Forced password change at first logon
Naming aligned with corporate conventions
This activity reinforced daily Service Desk tasks such as account provisioning and identity lifecycle management.

👥 Security Group Management
Security groups were created inside London → Groups to model role-based access control.
Groups created:
SG-London-Users
SG-Finance
SG-HR
SG-Sales
SG-IT-Support
SG-Local-Admins-PCs
Skills practiced:
Logical group design
User membership assignment
Understanding access management via groups

🔐 Group Policy Configuration
✅ GPO 1  Account Lockout Policy (Domain Level)
The Default Domain Policy was configured to simulate account lockout behaviour.
Settings applied:
Account lockout threshold: 5 attempts
Lockout duration: 15 minutes
Reset counter after: 15 minutes
This enabled realistic testing of account lock scenarios and introduced domain-level policy scope concepts.

✅ GPO 2 Corporate Login Warning (OU Level)
A new GPO named Corporate Login Warning was created and linked to the London OU.
Configured settings:
Interactive logon message title
Interactive logon message text (security banner)
Policy deployment was validated on a domain-joined workstation using:
gpupdate /force
Following system reboot, the logon banner appeared successfully, confirming policy application.

🧠 Knowledge Gained
Difference between domain and OU-level policies
Purpose and structure of Organizational Units
Role of security groups in access control
Basic GPO lifecycle (create → configure → link → apply → verify)
Use of gpupdate for policy refresh

✅ Day 4 Checklist
Designed and implemented professional OU structure
Created realistic domain user accounts
Configured password change at first logon
Created and organized security groups
Assigned users to appropriate groups
Configured domain Account Lockout Policy
Created and linked OU-level GPO
Deployed corporate logon warning banner
Forced and verified Group Policy update

📅 Overview
Day 5 focused on practical IT Support operations through simulated Service Desk tickets. The objective was to develop troubleshooting mindset, understand common enterprise incidents, and practice resolution workflows within an Active Directory environment.
This lab emphasized hands on problem solving across identity management, group membership, infrastructure dependency, event analysis, and remote access.

🎫 Ticket 1 Account Locked
Scenario
A user account became locked after multiple failed login attempts.
Actions performed
Simulated lockout on PC01 by entering incorrect password five times
Located the affected user in Active Directory Users and Computers
Unlocked the account via Account tab in user properties
Outcome
User successfully regained access to domain resources.
Skills practiced
Account lockout troubleshooting
Understanding domain lockout policy behavior

🎫 Ticket 2 Disabled Account
Scenario
User was unable to sign in due to account being disabled.
Actions performed
Disabled user account in ADUC to simulate incident
Verified login failure on PC01
Re-enabled account in ADUC
Outcome
User authentication restored.
Skills practiced
Account state management
Common onboarding/offboarding workflow

🎫 Ticket 3 Password Reset
Scenario
User reported inability to sign in due to forgotten password.
Actions performed
Reset password in ADUC
Enabled User must change password at next logon
Verified successful login and password change
Outcome
User regained account access securely.
Skills practiced
Identity lifecycle management
Secure password reset process

🎫 Ticket 4 Add User to Security Group
Scenario
User required access aligned with Finance role.
Actions performed
Added user to SG-Finance security group
Confirmed membership in ADUC
Outcome
User assigned appropriate role-based access.
Skills practiced
Role-based access control
Group membership administration

🎫 Ticket 5 Local Administrator Rights
Scenario
User required temporary local administrative privileges.
Actions performed
Added user to SG-Local-Admins-PCs
Forced policy refresh on workstation using gpupdate /force
Validated elevated privileges
Removed user from group after testing
Outcome
Temporary administrative access granted and revoked successfully.
Skills practiced
Privilege elevation workflow
Least privilege principle

🎫 Ticket 6 DNS Misconfiguration
Scenario
User unable to authenticate to domain due to incorrect DNS configuration.
Actions performed
Modified PC01 DNS settings to external resolver (simulation)
Observed authentication failure
Restored DNS to Domain Controller IP
Outcome
Domain authentication functionality restored.
Skills practiced
DNS dependency awareness in Active Directory
Network troubleshooting fundamentals

🎫 Ticket 7 Service Dependency Issue
Scenario
Authentication disruption caused by infrastructure service failure.
Actions performed
Stopped DNS Server service on DC01
Observed login failures from workstation
Restarted DNS service
Outcome
Authentication services resumed successfully.
Skills practiced
Service dependency understanding
Infrastructure troubleshooting

🎫 Ticket 8  Event Viewer Investigation
Scenario
Investigation of authentication events for security awareness.
Actions performed
Accessed Event Viewer → Windows Logs → Security
Identified Event ID 4625 (failed logon)
Identified Event ID 4624 (successful logon)
Reviewed key event fields
Outcome
Improved understanding of authentication logging.
Skills practiced
Security log analysis
Basic SOC investigative workflow

🎫 Ticket 9  Remote Desktop Enablement
Scenario
User required remote access to workstation.
Actions performed
Enabled Remote Desktop on PC01
Verified firewall rule configuration
Initiated RDP session from DC01 using mstsc
Outcome
Remote connectivity established successfully.
Skills practiced
Remote access configuration
Endpoint management fundamentals

🧠 Knowledge Gained
Common Service Desk incident patterns
Active Directory operational troubleshooting
Infrastructure dependencies impacting authentication
Role-based access implementation
Security event visibility and interpretation
Remote management workflow

✅ Day 5 Checklist (Tickets 1–9)
Resolved account lockout incident
Managed disabled account scenario
Performed secure password reset
Assigned user to role-based security group
Granted and revoked local administrator rights
Diagnosed DNS-related authentication issue
Investigated service dependency failure
Reviewed authentication events in Event Viewer
Enabled and validated Remote Desktop access

📅 Overview
Day 6 focused on developing practical networking skills within the HomeLab environment. The objective was to understand how network services support Active Directory operations and to practice diagnosing common connectivity and authentication issues.
The lab covered baseline network verification, DNS record validation, DHCP configuration and testing, as well as multiple simulated network-related Service Desk scenarios.

🌐 Baseline Network Validation
Initial network health checks were performed on PC01 to establish a reference state prior to troubleshooting activities.
Commands executed
ipconfig /all
ping DC01
ping <DC01-IP>
tracert DC01
nslookup lab.local
nslookup dc01.lab.local
nltest /dsgetdc:lab.local
Outcome
Verified domain connectivity
Confirmed DNS resolution functionality
Validated workstation discovery of domain controller
Established baseline outputs for documentation and comparison
Skills practiced
Network state verification
Active Directory discovery validation
Basic connectivity troubleshooting

🧭 DNS Infrastructure Validation
DNS configuration was reviewed directly on DC01.
Actions performed
Accessed DNS Manager
Inspected Forward Lookup Zone for lab.local
Confirmed presence of A records and AD-integrated SRV records
Client-side validation
On PC01, SRV records were queried:
nslookup dc01.lab.local
nslookup -type=SRV _ldap._tcp.dc._msdcs.lab.local
Outcome
Successful resolution of A and SRV records confirmed proper AD-integrated DNS functionality.
Skills practiced
Understanding SRV record role in Active Directory
DNS validation techniques
Domain service discovery mechanisms

📡 DHCP Deployment & Validation
A DHCP role was installed and configured on DC01 to simulate enterprise IP address management.
Actions performed
Installed DHCP Server role
Authorized DHCP server in Active Directory
Created IPv4 scope
Configured scope options:
DNS Server → DC01
Domain Name → lab.local
Default gateway (where applicable)
Activated scope
Client testing
On PC01:
ipconfig /release
ipconfig /renew
ipconfig /all
Outcome
PC01 successfully obtained dynamic IP configuration with correct DNS and domain suffix settings.
Skills practiced
DHCP scope creation
Dynamic IP lifecycle
DHCP–DNS integration awareness

🎫 Network Troubleshooting Ticket Simulations
🎫 Ticket A — Incorrect DNS Configuration
Scenario
Workstation configured with external DNS server causing domain service failure.
Actions
Modified PC01 DNS to external resolver
Observed failure in name resolution and domain discovery
Restored DNS configuration to DC01
Outcome
Domain connectivity restored.
Skills
DNS dependency troubleshooting
Name resolution failure analysis

🎫 Ticket B — DHCP Service Unavailable
Scenario
DHCP server outage resulted in inability to obtain valid IP configuration.
Actions
Stopped DHCP Server service on DC01
Performed release/renew on PC01
Observed failure to obtain address
Restarted DHCP service
Renewed lease successfully
Outcome
Dynamic addressing restored.
Skills
APIPA and DHCP failure recognition
Service dependency troubleshooting

🎫 Ticket C — Domain Service Port Connectivity
Scenario
Validation of required domain service ports between workstation and domain controller.
Actions (PowerShell)
Test-NetConnection dc01.lab.local -Port 53
Test-NetConnection dc01.lab.local -Port 88
Test-NetConnection dc01.lab.local -Port 389
Outcome
Confirmed reachability of DNS, Kerberos, and LDAP services.
Skills
Port-level connectivity testing
Understanding AD protocol requirements

🎫 Ticket D — Connectivity vs Name Resolution Analysis
Scenario
Diagnosis methodology for general connectivity complaints.
Actions
ping 8.8.8.8
ping google.com
Outcome
Practiced interpretation logic distinguishing routing issues from DNS failures.
Skills
Layered troubleshooting methodology
Network diagnostic reasoning

🎫 Ticket E — Active Network Connection Review
Scenario
Inspection of active connections and listening ports.
Actions
netstat -ano
Get-NetTCPConnection
Outcome
Observed active network sessions and local port usage patterns.
Skills
Connection monitoring
Endpoint network visibility

🧠 Knowledge Gained
DNS as a core dependency for Active Directory functionality
DHCP role in endpoint configuration consistency
Practical methodology for network incident triage
Importance of SRV records in domain service discovery
Port-level awareness of authentication protocols
Techniques for distinguishing connectivity vs resolution problems

✅ Day 6 Checklist
Captured baseline network configuration and connectivity state
Validated AD-integrated DNS records and SRV functionality
Deployed and tested DHCP scope
Simulated DNS misconfiguration scenario
Simulated DHCP service outage
Tested domain service ports (53, 88, 389)
Practiced connectivity vs resolution diagnostic workflow
Reviewed active endpoint network connections

Day 7 marked the transition from system administration activities toward a Cybersecurity and SOC Analyst perspective. The focus of this lab was to generate security relevant activity within the HomeLab environment and analyze  the resulting Windows Security logs to understand authentication behavior, privilege changes, and account lifecycle events.
This hands-on approach simulated early stage SOC monitoring workflows, emphasizing log interpretation, pattern recognition, and timeline based investigation.

🔎 Security Log Baseline Review
An initial review of the Windows Security log was performed on PC01 to understand event volume and structure.
Actions performed
Opened Event Viewer (eventvwr.msc)
Navigated to Windows Logs → Security
Observed event distribution and recurring Event IDs
Captured baseline awareness of authentication related telemetry
Outcome
Established familiarity with the primary log source used for identity-related monitoring.
Skills practiced
Log source identification
Windows Security log navigation
SOC telemetry awareness

🔐 Authentication Event Analysis
Authentication activity was generated to analyze both successful and failed login events.
Actions performed
Simulated multiple failed login attempts
Performed successful login
Filtered Security log for:
4625 Failed logon
4624 Successful logon
Inspected key event fields:
Account Name
Logon Type
Source information
Outcome
Successfully correlated authentication activity with corresponding security events.
Skills practiced
Authentication telemetry analysis
Event filtering techniques
Understanding authentication context

🧭 Logon Type Interpretation
Logon type values were analyzed to distinguish between different authentication methods.
Activities performed
Generated interactive logon (local login)
Generated Remote Desktop logon
Compared Logon Type values within Event 4624

Observed mappings
Type 2 → Interactive logon
Type 3 → Network logon
Type 10 → Remote Desktop logon
Outcome
Developed ability to infer authentication method from event metadata.
Skills practiced
Logon behavior interpretation
Remote access visibility
Authentication context enrichment

🛡️ Privilege & Group Membership Monitoring
Group membership changes were simulated to observe privilege-related events.
Actions performed
Temporarily added user to privileged group
Reviewed Security log for group membership change events

Identified events such as:
4728
4732
4756
Removed user after testing
Outcome
Confirmed visibility of privilege modification activity within Security logs.
Skills practiced
Privilege escalation monitoring
Group change detection
Security event correlation

👤 Account Lifecycle Monitoring
User lifecycle operations were performed to analyze identity management telemetry.
Actions performed
Created new user account
Disabled account
Re-enabled account
Identified lifecycle events:
4720 User created
4722 Account enabled
4725 Account disabled
Outcome
Developed understanding of account lifecycle visibility within Windows Security logs.
Skills practiced
Identity lifecycle monitoring
Administrative action tracking
Event-based audit awareness

🚨 Brute Force Pattern Simulation
A repeated failed authentication scenario was generated to emulate brute force behavior.
Actions performed
Performed multiple consecutive failed logins
Filtered Security log for Event 4625
Observed repeated authentication failures for a single account
Outcome
Recognized basic brute force pattern characteristics within authentication logs.
Skills practiced
Attack pattern recognition
Authentication anomaly awareness
Security triage mindset

📊 Investigation Timeline Creation
A structured sequence of authentication and session activity was generated to simulate a mini investigation.
Activities performed
Failed login attempts
Successful login
Remote Desktop session
Logoff event
Filtered Security log for user-related events
Ordered events chronologically
Outcome
Constructed a basic activity timeline representing user behavior.
Skills practiced
Event correlation
Timeline-based investigation
Behavioral analysis

🧠 Knowledge Gained
Windows Security log as a primary SOC telemetry source
Authentication event interpretation and context analysis
Logon type significance in security monitoring
Visibility of privilege changes and account lifecycle actions
Recognition of brute force authentication patterns
Timeline construction for incident investigation

✅ Day 7 Checklist
Reviewed Windows Security log baseline
Generated and analyzed failed authentication events
Generated and analyzed successful authentication events
Compared Logon Type values across login methods
Simulated and detected group membership changes
Observed account lifecycle events (create/disable/enable)
Simulated brute force authentication behavior
Built activity timeline from correlated security events

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