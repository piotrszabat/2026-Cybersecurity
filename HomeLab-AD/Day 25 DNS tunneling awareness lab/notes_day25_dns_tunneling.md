Day 25 focused on understanding and detecting DNS tunneling behavior through controlled simulation inside the HomeLab environment.

The objective of this lab was to generate tunneling-like DNS activity (long, high-entropy subdomains with burst behavior), capture the traffic at packet level, analyze DNS query patterns, and implement a basic Suricata detection rule based on abnormal QNAME structure.

This exercise followed a structured SOC workflow:

baseline → simulate anomaly → capture → analyze → detect → validate → document

The lab emphasized DNS visibility, anomaly recognition, entropy awareness, detection engineering fundamentals, and structured evidence collection.

🛠️ DNS Sensor Preparation & Logging Configuration

The lab began by configuring SPLK01 as the central DNS resolver and logging sensor node.

Actions performed
Installed and configured dnsmasq
Enabled query logging (log-queries)
Configured local lab domain (*.lab)
Forced internal resolution for lab domains
Verified logging functionality

Outcome
Created full visibility into DNS query behavior within the lab environment.

Skills practiced
DNS resolver configuration
Query logging validation
Controlled internal DNS architecture
Security-focused service configuration

📡 Baseline DNS Activity (Normal Behavior)

Before generating suspicious traffic, a baseline was established.

Actions performed

Generated normal DNS queries:

google.com

microsoft.com

ubuntu.com

Reviewed dnsmasq logs
Captured DNS traffic via tcpdump

Outcome
Observed normal DNS characteristics:

Short QNAME values

Low query frequency

Standard resolution patterns

Skills practiced
Baseline behavior establishment
Normal traffic profiling
Protocol behavior comparison

🚨 Simulated DNS Tunneling-Like Activity

To simulate DNS exfiltration behavior safely, high-entropy and long subdomain queries were generated within the internal *.lab domain.

Actions performed

Executed scripted query bursts using randomized 40–55 character subdomains:

<randomstring>.exfil.lab
<randomstring>.<counter>.exfil.lab

Generated multiple rapid DNS requests in short time window

Outcome
Produced observable tunneling-like indicators:

Abnormally long subdomain labels

High-entropy alphanumeric patterns

Burst-style DNS query frequency

Skills practiced
Behavioral anomaly simulation
High-entropy pattern recognition
Controlled suspicious traffic generation

🔍 PCAP Analysis in Wireshark

The DNS capture file was analyzed using structured filtering methodology.

📊 DNS Query Isolation

Filters applied:

dns
dns.flags.response == 0
dns.qry.name contains "exfil.lab"

Actions performed
Isolated DNS query packets
Reviewed QNAME length
Compared baseline vs simulated traffic
Observed repetition and timing patterns

Outcome
Identified key Indicators of Compromise (IOCs):

Excessive subdomain length

High entropy structure

Burst query behavior

Patterned labeling (<random>.<counter>.domain)

Skills practiced
DNS packet inspection
Display filtering
IOC extraction
Traffic pattern comparison

🛡️ Suricata Detection Engineering

A custom detection rule was created to identify long suspicious DNS labels.

Rule added to local.rules:

alert dns any any -> any any (msg:"HOMELAB DNS - Suspicious long subdomain (tunneling-like)"; dns.query; pcre:"/([a-z0-9]{35,})\./i"; sid:1000025; rev:1;)

Actions performed
Validated configuration using:

sudo suricata -T

Restarted Suricata service
Regenerated suspicious DNS traffic
Monitored fast.log and eve.json

Outcome
Successfully triggered alerts on tunneling-like DNS patterns.

Skills practiced
Detection rule writing
Regex-based traffic inspection
IDS validation workflow
Alert verification and log review

🧵 Evidence Collection

Evidence gathered included:

dnsmasq query logs showing long subdomains

PCAP file with tunneling-like burst activity

Wireshark filtered DNS views

Suricata fast.log alert entries

Suricata eve.json alert records

Screenshot of local.rules detection rule

This mirrors SOC investigation documentation standards.

🕒 Timeline Construction

A structured activity timeline was created based on DNS logs and PCAP timestamps:

Baseline DNS queries observed
High-entropy burst DNS queries initiated
Suricata rule triggered
Alert logged in fast.log and eve.json

Outcome
Demonstrated ability to correlate DNS activity, detection logic, and IDS output into a coherent investigative sequence.

Skills practiced
Temporal correlation
Alert-to-traffic mapping
Structured investigation documentation

🧠 Knowledge Gained

Understanding of DNS tunneling indicators and behavior patterns
Ability to distinguish normal DNS resolution from exfiltration-like activity
Practical experience analyzing QNAME entropy and subdomain length
Experience writing basic Suricata detection rules using PCRE
Improved awareness of DNS as a covert data exfiltration channel
Confidence in documenting detection engineering workflow

✅ Day 25 Checklist

Configured dnsmasq with query logging
Verified PC01/KALI01 DNS resolution via SPLK01
Captured DNS traffic using tcpdump
Established normal DNS baseline
Generated tunneling-like DNS burst activity
Analyzed PCAP in Wireshark
Extracted DNS-related IOCs
Created Suricata detection rule
Validated rule with suricata -T
Triggered alert successfully
Collected and documented evidence
Built structured timeline