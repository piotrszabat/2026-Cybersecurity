# SOC Architecture Documentation

## Objective

Document the full SOC homelab architecture, including network segmentation, security tooling, and key data flows.

## Architecture Summary

This homelab was designed as a segmented enterprise-style SOC environment with separate external, internal, and security operations networks. The lab supports monitoring, detection engineering, threat hunting, vulnerability management, and incident investigation.

## Network Segments

### NET-EXT
External segment used for attack simulation and perimeter testing.

### NET-INT
Internal segment containing business systems and monitored endpoints.

### NET-SOC
Security operations segment containing monitoring and analysis infrastructure.

## Systems

### FW01
- Platform: pfSense
- Role: Perimeter firewall, routing, segmentation, Suricata IDS/IPS

### KALI01
- Platform: Kali Linux
- Role: Controlled attack simulation platform

### DC01
- Platform: Windows Server 2022
- Role: Active Directory, DNS, core identity infrastructure

### PC01
- Platform: Windows 11
- Role: User endpoint for telemetry and attack simulation

### SRV01
- Platform: Internal server
- Role: Service hosting and monitored server workload

### SPLK01
- Platform: Ubuntu + Splunk
- Role: SIEM, dashboards, detections, investigations

### WAZ01
- Platform: Ubuntu + Wazuh
- Role: Endpoint detection and telemetry platform

### VAS01
- Platform: Ubuntu + Greenbone/OpenVAS
- Role: Vulnerability management and internal scanning

## Security Tools

### Perimeter Security
- pfSense
- Suricata

### Endpoint Detection
- Wazuh agents
- Wazuh server

### SIEM and Analysis
- Splunk

### Vulnerability Management
- Greenbone / OpenVAS

### Attack Simulation
- Kali Linux

## Data Flows

### Endpoint Telemetry Flow

```text
DC01 / PC01 / SRV01
   ↓
Wazuh agents
   ↓
WAZ01
   ↓
alerts.json
   ↓
Splunk Universal Forwarder
   ↓
SPLK01
```

### Network Monitoring Flow

```text
KALI01 / network traffic
   ↓
FW01 / Suricata
   ↓
Splunk
```

### Vulnerability Management Flow

```text
VAS01
   ↓
DC01 / PC01 / SRV01
   ↓
scan results
   ↓
reports
```

## Lab Use Cases

- Active Directory monitoring
- detection engineering
- SIEM dashboarding
- credential attack detection
- lateral movement analysis
- IOC hunting
- vulnerability scanning
- incident investigation

## Outcome

The homelab provides a realistic blue-team environment for practicing monitoring, detection, investigation, and security assessment across a segmented enterprise-style architecture.

## Skills Demonstrated

- SOC architecture design
- network segmentation
- SIEM integration
- endpoint telemetry design
- threat hunting workflow
- vulnerability management integration
- security documentation