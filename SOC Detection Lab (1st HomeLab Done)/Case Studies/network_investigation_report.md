Day 27 Network Investigation Report

Incident Type: Suspicious DNS Activity + HTTP Executable Download
Date of Investigation: 28 Feb 2026
Analyst: Piotr Szabat / SOC Lab

Executive Summary
During a controlled SOC lab simulation, suspicious DNS activity followed by an HTTP executable download was observed originating from internal host PC01 (192.168.56.20).

The activity included:
High-entropy DNS queries resembling tunneling behavior
Download of executable file invoice_update.exe
Use of custom User-Agent EvilDownloader/1.0
Multiple Suricata IDS alerts triggered
The behavior pattern is consistent with potential malware staging or command-and-control preparation.
Scope of Investigation

Analysis was conducted using:
PCAP traffic capture (Wireshark)
dnsmasq DNS query logs

Suricata IDS logs:
fast.log
eve.json

Affected Hosts
Host	IP Address	Role
PC01	192.168.56.20	Internal client
KALI01	192.168.57.5	Simulated malicious HTTP server
Timeline of Events
Time (Approx)	Event	Source	Evidence
10:12	Multiple long DNS queries to *.exfil.lab	PC01	dnsmasq log
10:13	Suricata alert: DNS long subdomain	IDS	SID 1000025
10:15	HTTP GET /invoice_update.exe	PC01 → 192.168.57.5	PCAP
10:15	Suspicious User-Agent detected	Suricata	SID 1000027
10:16	Executable download alert	Suricata	SID 1000026
Note: Minor timestamp differences may exist due to host clock variations.

Technical Findings
1. DNS Activity Analysis
Host 192.168.56.20 generated DNS queries toward domain:
*.exfil.lab
Queries contained unusually long subdomains.
Burst-like query behavior observed.
Suricata triggered alert:
SID: 1000025
Description: DNS Long Subdomain Detected
Assessment
Pattern consistent with:
DNS tunneling simulation
Potential data exfiltration channel
C2 beaconing behavior (lab simulation context)

2. HTTP Activity Analysis
Observed HTTP Request
GET /invoice_update.exe HTTP/1.1
Host: 192.168.57.5:8000
User-Agent: EvilDownloader/1.0
Source: 192.168.56.20
Destination: 192.168.57.5:8000
File downloaded: invoice_update.exe
Content-Type: application/x-msdos-program
HTTP Status: 200 OK

Suricata Alerts
SID	Description
1000026	Executable file download detected
1000027	Suspicious User-Agent detected
1000025	DNS long subdomain detected
TCP Stream Review
TCP stream reconstruction confirms successful transfer of the executable payload.
Payload content (lab simulation):
This is a fake malware payload for SOC lab
Indicators of Compromise (IOCs)
IP Addresses
192.168.56.20 (PC01)
192.168.57.5 (KALI01)

Domains
*.exfil.lab
URL
http://192.168.57.5:8000/invoice_update.exe
File Name
invoice_update.exe
User-Agent
EvilDownloader/1.0

Suricata SIDs
1000025 — DNS long subdomain
1000026 — EXE download
1000027 — Suspicious User-Agent

Analysis
The investigation shows the following correlated sequence:
PC01 initiated anomalous DNS queries with long subdomains.
Shortly after, the same host initiated an HTTP request to download an executable file.
A custom User-Agent string was used.
IDS alerts confirm detection of both DNS anomaly and executable transfer.
This behavior pattern is consistent with:
Malware staging
Command-and-control preparation
DNS-based covert channel
Dropper download sequence
No evidence of execution was observed within available telemetry.

Impact Assessment
No confirmed malware execution detected.
No lateral movement observed.
Executable file successfully transferred.
Activity represents elevated risk behavior.
If this were a production environment, immediate containment of host 192.168.56.20 would be recommended.

Recommendations
Block high-entropy DNS queries and suspicious subdomains.
Restrict outbound HTTP downloads of executable files.
Implement DNS query length threshold alerts.
Enforce proxy logging for HTTP traffic.
Deploy endpoint detection and response (EDR) to monitor file execution.
Enable TLS inspection (future improvement).
Monitor for abnormal User-Agent strings.

Conclusion
Combined DNS anomaly and suspicious HTTP executable download indicate behavior consistent with malware staging activity.

This investigation demonstrates the ability to:
Correlate network telemetry
Analyze PCAP traffic
Interpret IDS alerts
Extract IOCs
Build incident timeline
Produce structured SOC-style documentation
Evidence Screenshots (To Be Included)

Place screenshots inside:
screenshots/evidence/