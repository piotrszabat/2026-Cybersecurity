Day 13 focused on developing packet-level visibility and foundational network traffic analysis skills using Wireshark.  
The objective of this lab was to build packet literacy by capturing and interpreting DNS and HTTP traffic, applying practical filtering techniques, and validating the ability to extract meaningful evidence from raw network communications.

This exercise simulated common SOC workflows where analysts inspect packet captures to validate suspicious activity, confirm network behavior, and support investigations with protocol-level evidence. The lab emphasized capture setup, traffic generation, filtering methodology, and basic stream reconstruction.

🛠️ Wireshark Setup & Capture Preparation  
Wireshark was installed and configured to enable packet capture from the Windows endpoint.

Actions performed  
Installed Wireshark on PC01  
Installed Npcap to enable packet capture capabilities  
Identified the active network interface based on traffic activity indicators  
Started a live capture session to observe baseline network traffic  

Outcome  
Established a working packet capture environment capable of collecting live network telemetry from the endpoint.

Skills practiced  
Packet capture setup  
Interface selection  
Endpoint-based network visibility  

🔎 DNS Traffic Capture & Analysis  
DNS traffic was generated and analyzed to understand name resolution behavior and identify key DNS transaction fields.

Actions performed  
Flushed local DNS cache to ensure fresh resolution traffic  
Generated DNS requests using nslookup for controlled domains  
Applied Wireshark display filter: dns  
Reviewed DNS query and response packets  
Inspected DNS fields including queried domain, answer records, and responding server  

Outcome  
Successfully captured and interpreted DNS resolution traffic, reinforcing understanding of how endpoints translate domain names into IP addresses.

Skills practiced  
DNS protocol awareness  
Query/response identification  
Network telemetry filtering  

🌐 HTTP Traffic Capture & Inspection  
HTTP traffic was generated to observe cleartext web requests and responses at the packet level.

Actions performed  
Generated HTTP traffic by visiting a non-HTTPS website endpoint  
Applied Wireshark display filter: http  
Identified HTTP GET requests and server responses  
Inspected HTTP headers and response codes within captured packets  

Outcome  
Confirmed ability to identify web activity at the protocol level and extract relevant metadata such as host, URI, and response status.

Skills practiced  
HTTP protocol interpretation  
Request/response identification  
Web traffic visibility  

🧵 Stream Reconstruction (Follow HTTP Stream)  
Packet stream reconstruction was performed to demonstrate how multiple packets form a complete application-layer exchange.

Actions performed  
Selected relevant HTTP packet within capture  
Used Follow → HTTP Stream to reconstruct the full request/response session  
Reviewed reconstructed content for context and evidence  

Outcome  
Demonstrated ability to reconstruct application-layer context from packet-level telemetry, a key SOC investigation skill.

Skills practiced  
Stream reconstruction  
Session context interpretation  
Evidence extraction from PCAP  

🔍 Filtering Techniques & Query Mindset  
Common Wireshark display filters were tested to improve investigation efficiency and precision.

Actions performed  
Used protocol filters: dns, http, tcp, udp, tls  
Applied port-based filters (e.g., port 53, 80, 443)  
Applied IP-based filters (source and destination)  
Validated filtering effectiveness by isolating only relevant packets  

Outcome  
Developed filtering discipline and improved speed in isolating actionable traffic within noisy captures.

Skills practiced  
Filter-driven investigation  
Protocol and port identification  
Targeted packet analysis  

💾 Capture Preservation (PCAP)  
The capture session was saved to support portfolio evidence and repeatable analysis.

Actions performed  
Saved capture as a .pcapng file for later review  
Organized artifacts into HomeLab repository structure  

Outcome  
Produced reusable investigation artifact suitable for documentation and portfolio demonstrations.

Skills practiced  
Investigation artifact handling  
Evidence preservation  
Documentation workflow  

🧠 Knowledge Gained  
Practical workflow for packet capture and investigation  
DNS query and response structure and investigative value  
HTTP request and response visibility at packet level  
How to reconstruct context using Follow Stream  
Importance of filtering to isolate relevant traffic  
Value of PCAP files as investigation evidence and portfolio artifacts  

✅ Day 13 Checklist  
Installed Wireshark and Npcap on PC01  
Started capture on the correct active interface  
Generated DNS traffic and captured query/response packets  
Applied DNS filtering and inspected DNS record fields  
Generated HTTP traffic and captured request/response packets  
Applied HTTP filtering and inspected headers and response codes  
Performed Follow HTTP Stream reconstruction  
Saved capture file as PCAPNG for future analysis  
Captured representative screenshots for portfolio evidence  
Documented filters and observations for GitHub notes  