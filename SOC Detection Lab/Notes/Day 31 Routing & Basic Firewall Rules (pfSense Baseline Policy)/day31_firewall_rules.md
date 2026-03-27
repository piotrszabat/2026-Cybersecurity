Day 31 focused on implementing the baseline firewall policy and routing validation in the HomeLab environment using pfSense (FW01).

The objective of this lab was to enforce network segmentation between security zones, establish controlled communication paths, enable logging of security events, and validate the firewall policy through practical connectivity testing.

The environment consists of three internal zones routed through the firewall:

| Zone | Network         | Purpose                            |
| ---- | --------------- | ---------------------------------- |
| EXT  | 10.0.0.0/24     | External / attacker simulation     |
| INT  | 192.168.10.0/24 | Internal corporate network         |
| SOC  | 192.168.50.0/24 | Security monitoring infrastructure |

This exercise introduced a realistic security model used in enterprise networks, where communication between zones is strictly controlled by firewall policies.

The lab followed a structured workflow:
configure routing → create firewall rules → enable logging → perform segmentation tests → validate results

🌐 Outbound NAT Configuration

To allow internal systems to access the internet through the firewall, Outbound NAT was configured.

Path:
Firewall → NAT → Outbound

Configuration mode:
Hybrid Outbound NAT

This allows automatic NAT rules while still enabling manual rule customization if needed.

The firewall automatically created NAT translations for:

| Network         | NAT Interface | Translation |
| --------------- | ------------- | ----------- |
| 10.0.0.0/24     | WAN           | WAN address |
| 192.168.10.0/24 | WAN           | WAN address |
| 192.168.50.0/24 | WAN           | WAN address |

Outcome:
Internal networks can now reach external destinations using the firewall's WAN interface.

Skills practiced:
* NAT configuration
* Firewall traffic translation
* Internet access routing

---

🛡️ Firewall Segmentation Policy

A baseline segmentation policy was implemented to restrict communication between networks.

The policy enforces deny-by-default behavior for untrusted zones, while allowing specific traffic required for monitoring and operations.

🚫 EXT → INT / SOC (Blocked)

Traffic originating from the EXT network (attacker simulation zone) was blocked from accessing both the internal network and the SOC network.

Firewall rules created on interface:
Firewall → Rules → EXT

Rule: Block EXT → INT
Action: Block
Source: EXT net
Destination: 192.168.10.0/24
Logging: Enabled
Description: BLOCK_EXT_to_INT

Rule: Block EXT → SOC
Action: Block
Source: EXT net
Destination: 192.168.50.0/24
Logging: Enabled
Description: BLOCK_EXT_to_SOC

Purpose:

Prevent simulated attacker systems from accessing sensitive internal infrastructure.

Skills practiced:
* Network segmentation
* Firewall rule creation
* Security event logging

📊 INT → SOC (Allowed for Splunk Telemetry)
To support centralized logging and monitoring, the internal network was allowed to send data to the Splunk SIEM system.

Firewall rules configured on:
Firewall → Rules → INT

Rule: Allow INT → Splunk (TCP 9997)
Action: Pass
Protocol: TCP
Source: INT net
Destination: 192.168.50.10
Port: 9997
Logging: Enabled
Description: ALLOW_INT_to_SPLUNK_9997

Purpose:

Allow Windows endpoints and servers to forward logs to Splunk.

Skills practiced:

* Controlled inter-zone communication
* SIEM telemetry routing
* Firewall rule logging

🌍 INT → Internet Access
Internal systems were granted controlled internet access for updates and connectivity testing.

Firewall rule:
Action: Pass
Source: INT net
Destination: any
Description: ALLOW_INT_to_ANY

This rule allows outbound connectivity while still preventing unauthorized inbound access.

🖥️ SOC → INT (Monitoring Access)
The SOC network requires limited access to internal systems for monitoring and troubleshooting.

Firewall rules created on:
Firewall → Rules → SOC

Rule: Allow SOC → INT (ICMP)
Action: Pass
Protocol: ICMP
Source: SOC net
Destination: INT net
Description: ALLOW_SOC_to_INT_ICMP

Purpose:
Allow network diagnostics and monitoring.

Rule: Allow SOC → DC01 (DNS)
Action: Pass
Protocol: TCP/UDP
Source: SOC net
Destination: 192.168.10.10
Port: 53
Description: ALLOW_SOC_to_DC01_DNS

Purpose:
Allow SOC systems to resolve internal domain names using the domain controller.

Rule: Allow SOC → Internet
Action: Pass
Source: SOC net
Destination: any
Description: ALLOW_SOC_to_ANY

Purpose:
Allow security tools to download updates and threat intelligence feeds.

🔍 Connectivity & Segmentation Testing
Connectivity tests were performed from each network zone to validate firewall rule enforcement.

EXT Network Tests (KALI01)
Host:
KALI01
IP: 10.0.0.50
Gateway: 10.0.0.1

Tests performed:
ping 192.168.10.20
ping 192.168.50.10
nmap -Pn 192.168.10.20

Expected result:
Blocked / Filtered

Outcome:

Traffic from EXT to INT and SOC was successfully blocked by the firewall.
INT → SOC (Splunk Port Test)

Host:
PC01
Network: INT

Command used:
Test-NetConnection 192.168.50.10 -Port 9997

Expected:
TcpTestSucceeded : True

Outcome:

Successful connection confirmed correct firewall rule configuration.
INT → Internet

Tests performed:
ping 1.1.1.1

Outcome:
Internal hosts successfully accessed the internet through firewall NAT.

SOC → INT (Monitoring Access)
Host:
SPLK01
Network: SOC

Commands:
ping 192.168.10.1
ping 192.168.10.10
nslookup dc01.corp.lab 192.168.10.10

Outcome:
SOC systems were able to monitor and resolve internal infrastructure.

📜 Firewall Log Verification

Firewall logs were reviewed to confirm blocked traffic attempts.
Location:
Status → System Logs → Firewall

Observed events:
BLOCK_EXT_to_INT
BLOCK_EXT_to_SOC

This confirms that segmentation policies are actively enforced by the firewall.

🧠 Knowledge Gained
Implementing zone-based firewall policies
Designing segmented network architectures
Configuring NAT for internal networks
Understanding pfSense rule evaluation logic
Validating firewall rules through active testing
Analyzing firewall logs for security events
Simulating attacker network behavior

✅ Day 31 Checklist
EXT → INT blocked and logged
EXT → SOC blocked and logged
INT → SOC allowed for Splunk port 9997
SOC → INT allowed for ICMP and DNS
INT and SOC networks have internet access through NAT
Firewall logs confirm blocked traffic attempts
Connectivity tests validated segmentation policy

🔜 Next Steps (Day 32)

The next phase will focus on migrating virtual machines into their dedicated network zones, including:

* Assigning final static IP addresses
* Connecting each VM to the correct VirtualBox network
* Verifying routing between firewall zones
* Performing additional segmentation validation tests

This step will finalize the operational network architecture of the HomeLab environment.
