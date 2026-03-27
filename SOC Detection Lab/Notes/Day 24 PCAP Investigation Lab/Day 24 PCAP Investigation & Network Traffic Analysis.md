Day 24 focused on developing packet-level investigation skills through controlled traffic capture and analysis within the HomeLab environment.

The objective of this lab was to simulate a real SOC investigation workflow by capturing live network traffic, identifying reconnaissance behavior, analyzing DNS and HTTP activity, and building a structured timeline from raw packet data.

This exercise represented a core SOC analyst methodology:

capture → pivot → filter → interpret → evidence → timeline

The lab emphasized traffic visibility, protocol inspection, behavioral recognition, and structured investigative thinking.

🛠️ Packet Capture Preparation & Interface Validation

The lab began with identifying correct network interfaces and understanding traffic paths inside the lab architecture.

Actions performed
Verified active network interfaces using ip a
Reviewed routing table using ip route
Identified separation between Host-Only and NAT networks
Selected appropriate capture method using tcpdump -i any

Outcome
Ensured full traffic visibility across internal lab communication and internet-bound activity, avoiding interface-based blind spots.

Skills practiced
Network interface identification
Routing awareness
Capture placement validation
Multi-interface environment analysis

📡 Traffic Capture Using tcpdump

A controlled packet capture was initiated to simulate analyst-level evidence collection.

Actions performed
Started capture using:
sudo tcpdump -i any -w day24_lab.pcap
Allowed capture to run during traffic generation
Stopped capture and verified PCAP file integrity

Outcome
Produced structured packet evidence for Wireshark-based investigation.

Skills practiced
Live packet acquisition
PCAP generation
Evidence collection methodology

🚨 Controlled Traffic Generation (Attack Simulation)

Three traffic types were generated to simulate real investigative scenarios.

Actions performed

Generated SYN scan using Nmap:
sudo nmap -sS <target_ip>

Generated HTTP request:
curl http://testmyids.com

Generated DNS lookup:
nslookup google.com

Outcome
Produced distinct traffic categories:

Reconnaissance activity (SYN scan)

Application-layer HTTP traffic

DNS resolution activity

Skills practiced
Attack simulation
Protocol-level traffic differentiation
Behavioral traffic modeling

🔍 Wireshark Investigation Workflow

The captured PCAP file was analyzed using structured SOC methodology.

📊 Conversation Pivot Analysis

Wireshark → Statistics → Conversations → IPv4

Actions performed
Identified top talkers based on packet volume
Observed source IP generating multiple connections
Pivoted into suspicious traffic patterns

Outcome
Recognized attacker behavior through traffic concentration and abnormal connection patterns.

Skills practiced
Traffic pivoting
Behavioral analysis
Volume-based anomaly detection

🧠 SYN Scan Identification

Display filter applied:

tcp.flags.syn==1 && tcp.flags.ack==0

Actions performed
Filtered SYN-only packets
Observed single source targeting multiple destination ports
Identified rapid sequential port attempts

Outcome
Confirmed reconnaissance behavior:
Single source scanning multiple ports indicates active probing.

Skills practiced
TCP flag analysis
Reconnaissance detection
Attack pattern recognition

🌐 DNS Query Analysis

Display filter applied:

dns

Actions performed
Identified DNS standard queries
Reviewed queried domain names
Verified corresponding DNS responses
Inspected DNS packet structure

Outcome
Confirmed successful domain resolution activity and validated DNS visibility within capture.

Skills practiced
DNS protocol inspection
Query-response validation
Application-layer analysis

🌍 HTTP Request Investigation

Display filter applied:

http

Actions performed
Identified HTTP GET request
Reviewed Host header
Analyzed User-Agent string (curl)
Validated server response (HTTP 200 OK)

Outcome
Confirmed clear-text HTTP session and extracted full request metadata.

Skills practiced
HTTP header analysis
Client fingerprinting
Application-layer inspection

🧵 Follow TCP Stream (Session Reconstruction)

Used: Right click → Follow → TCP Stream

Actions performed
Reconstructed full client-server HTTP conversation
Validated request and response sequence
Confirmed session completeness

Outcome
Demonstrated ability to reconstruct complete network sessions from packet-level evidence.

Skills practiced
Session reconstruction
Evidence extraction
End-to-end traffic analysis

🕒 Timeline Construction

Based on packet timestamps, a structured activity timeline was built:

SYN scan initiated
DNS lookup performed
HTTP GET request executed

Outcome
Created a mini incident-style activity sequence derived directly from packet data.

Skills practiced
Temporal correlation
Event sequencing
Incident timeline development

🧠 Knowledge Gained

Understanding of packet capture workflows in multi-interface environments
Ability to identify reconnaissance patterns using TCP flag analysis
Practical experience filtering and pivoting traffic in Wireshark
Confidence in reconstructing HTTP sessions using TCP stream analysis
Awareness of capture placement importance in NAT vs Host-Only architectures
Improved investigative thinking aligned with SOC analyst responsibilities

✅ Day 24 Checklist

Verified network interfaces and routing
Captured live traffic using tcpdump
Generated SYN scan traffic
Generated HTTP request traffic
Generated DNS lookup traffic
Opened PCAP in Wireshark
Identified top talkers
Detected SYN scan behavior
Analyzed DNS queries and responses
Identified HTTP GET request
Used Follow TCP Stream
Built structured activity timeline
Documented investigation workflow

Day 24 marked a transition from alert-based detection analysis to full packet-level investigation, strengthening foundational SOC analyst capabilities in network traffic analysis and behavioral interpretation.