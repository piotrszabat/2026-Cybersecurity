Day 12 introduced network-based threat detection capabilities into the HomeLab environment through the deployment of Suricata IDS.  
The objective of this lab was to establish visibility into network traffic patterns, detect suspicious activity, and understand how IDS-generated alerts complement host telemetry already collected via Sysmon and Windows Security logs.

This exercise simulated SOC network monitoring workflows, where IDS platforms provide signature-based and behavioral detection across network communications. The lab focused on installation, interface configuration, service validation, alert generation, and log analysis to confirm operational network detection capability.

🖥️ Suricata IDS Deployment  
Suricata was installed on the SPLK01 Linux host to extend the HomeLab detection stack with network telemetry capabilities.

Actions performed  
Updated system repositories  
Installed Suricata package via apt package manager  
Verified successful installation and build information  
Confirmed availability of Suricata binaries  

Outcome  
Successfully deployed Suricata IDS engine within the HomeLab infrastructure.

Skills practiced  
Linux package management  
IDS platform deployment  
Network security tooling integration  

🌐 Network Interface Identification  
The network interface responsible for traffic monitoring was identified to enable packet inspection.

Actions performed  
Enumerated network interfaces using ip command  
Identified active interface associated with VirtualBox NAT Network  
Documented interface name for Suricata configuration  

Outcome  
Established correct monitoring interface enabling network traffic visibility.

Skills practiced  
Network interface enumeration  
Virtual networking awareness  
Packet capture preparation  

⚙️ Suricata Service Validation  
Suricata was tested and activated as a system service to ensure persistent IDS operation.

Actions performed  
Executed Suricata in test mode on selected interface  
Validated absence of configuration errors  
Started Suricata system service  
Verified operational service status  

Outcome  
Confirmed stable IDS operation and readiness for network monitoring.

Skills practiced  
Service lifecycle management  
IDS runtime validation  
Configuration troubleshooting  

📁 Log Pipeline Verification  
Suricata logging pipeline was reviewed to confirm proper telemetry generation.

Actions performed  
Navigated to Suricata log directory  
Validated presence of fast.log, eve.json, and statistics logs  
Reviewed baseline logging activity  

Outcome  
Confirmed operational alert and telemetry logging infrastructure.

Skills practiced  
Log pipeline verification  
IDS telemetry awareness  
Security log source exploration  

🚨 Alert Generation & Detection Validation  
Controlled network activity was generated to validate IDS detection capabilities.

Actions performed  
Initiated outbound HTTP request to IDS testing resource from endpoint  
Monitored Suricata alert logs in real time  
Observed triggered IDS signature within fast.log  

Outcome  
Successfully generated and captured IDS alert confirming functional detection pipeline.

Skills practiced  
Detection validation  
Controlled attack simulation  
Real-time alert monitoring  

📊 Structured Alert Inspection  
Structured JSON telemetry produced by Suricata was reviewed to understand enriched detection data.

Actions performed  
Inspected eve.json output  
Reviewed alert metadata including timestamp, source, destination, and signature details  
Compared structured telemetry with fast.log output  

Outcome  
Developed familiarity with structured IDS alert formats suitable for SIEM ingestion.

Skills practiced  
Structured log analysis  
JSON telemetry interpretation  
Detection context enrichment  

🧠 Knowledge Gained  
Role of IDS within layered SOC detection architecture  
Difference between host-based and network-based telemetry sources  
Importance of network visibility for detecting malicious communications  
Operational workflow for validating IDS deployment  
Structured alert formats enabling SIEM integration  
Correlation potential between Suricata alerts and endpoint telemetry  

✅ Day 12 Checklist  
Installed Suricata IDS on SPLK01  
Identified active network monitoring interface  
Executed Suricata test run successfully  
Started and verified Suricata service operation  
Validated Suricata logging directory and files  
Generated controlled network traffic to trigger IDS detection  
Observed alert within fast.log  
Reviewed structured alert data within eve.json  
Captured representative IDS alert screenshots  
Documented detection workflow and observations  

Day 37 Suricata IDS Deployment and Splunk Integration

Objective
Deploy a network intrusion detection system (IDS) using Suricata on the IDS01 server and integrate it with Splunk SIEM (SPLK01) for centralized log collection and analysis.

The goal of this day was to:
Deploy and configure Suricata
Enable Emerging Threats detection rules
Generate IDS alerts
Forward Suricata logs to Splunk
Validate the detection pipeline using simulated attacks from Kali Linux

Lab Environment
Component	Role
FW01 (pfSense)	Network firewall
IDS01	Suricata IDS sensor
SPLK01	Splunk SIEM
KALI01	Attack simulation host

Network monitoring flow:

Attack traffic → IDS01 (Suricata) → eve.json → Splunk Forwarder → SPLK01
Architecture Overview
KALI01
   │
   │ attack traffic
   ▼
FW01 (pfSense Firewall)
   │
   ▼
IDS01 (Suricata IDS)
   │
   │ eve.json logs
   ▼
Splunk Universal Forwarder
   │
   ▼
SPLK01 (Splunk SIEM)
Step 1 — Suricata Installation

Suricata was installed on IDS01 and configured as a network intrusion detection system.

Verification:
suricata --build-info

Service status check:
sudo systemctl status suricata

Result:
active (running)

Step 2 — Updating Suricata Rules

Emerging Threats rules were installed and updated.

Command:
sudo suricata-update

Rule location:
/var/lib/suricata/rules/

These rules allow Suricata to detect:
reconnaissance scans
malware activity
exploit attempts
suspicious network behavior

Step 3 — Verifying Suricata Logging

Suricata generates several log files.
Log directory:
/var/log/suricata

Key files:
File	Purpose
eve.json	structured JSON logs for SIEM
fast.log	alert log
stats.log	performance statistics

To monitor alerts in real time:

sudo tail -f /var/log/suricata/fast.log
Step 4 — Splunk Universal Forwarder Deployment

Because Suricata runs on IDS01 and Splunk runs on SPLK01, a Splunk Universal Forwarder was installed on IDS01 to send logs to the SIEM.

Installation steps:

Download forwarder

Extract package

Move to /opt/splunkforwarder

Start the forwarder

Start command:

sudo /opt/splunkforwarder/bin/splunk start --accept-license
Step 5 — Configuring Forwarder Connection

The forwarder was configured to send logs to Splunk.

Command:

sudo /opt/splunkforwarder/bin/splunk add forward-server 192.168.50.10:9997

Verification:

sudo /opt/splunkforwarder/bin/splunk list forward-server

Result:

Active forwards:
192.168.50.10:9997
Step 6 — Monitoring Suricata Logs

The forwarder was configured to monitor Suricata’s JSON log file.

Command:

sudo /opt/splunkforwarder/bin/splunk add monitor /var/log/suricata/eve.json -sourcetype suricata:json -index main

This configuration enables:

continuous monitoring of Suricata events

forwarding logs to Splunk in near real time

Step 7 — Splunk Configuration

Splunk was configured to receive forwarded data.

Location:

Settings → Forwarding and Receiving

Receiving port enabled:

9997

This allows the Splunk server to accept events from remote forwarders.

Step 8 — Verifying Log Ingestion in Splunk

Search query used in Splunk:

index=main sourcetype=suricata:json

This confirmed that Suricata events were successfully ingested.

Events included:

HTTP connections

DNS queries

network flows

Suricata alerts

Step 9 — Simulating an Attack

To test detection capabilities, a network scan was performed from KALI01.

Command:

nmap -sS -Pn 192.168.50.20

Explanation:

Option	Meaning
-sS	SYN stealth scan
-Pn	skip host discovery

This generated network traffic detectable by Suricata.

Step 10 — IDS Alert Verification

Alerts were monitored on IDS01 using:

sudo tail -f /var/log/suricata/fast.log

Example alert:

ET SCAN Nmap Scripting Engine User-Agent Detected

This confirms that Suricata successfully detected the scan activity.

Step 11 — Alert Verification in Splunk

The IDS alert was also visible in Splunk.

Query:

index=main "ET SCAN"

Result:

Splunk displayed Suricata alerts generated by the Nmap scan.

This confirms full pipeline functionality.

Detection Pipeline Validation

The full security monitoring pipeline was successfully validated:

Attack (Kali)
     ↓
Network traffic
     ↓
Suricata IDS (IDS01)
     ↓
eve.json logs
     ↓
Splunk Forwarder
     ↓
Splunk SIEM (SPLK01)
Key Achievements

Successfully implemented:

Network IDS deployment

Suricata rule management

Security event generation

SIEM log ingestion

Attack detection validation

SOC monitoring pipeline

