Day 10 marked a major milestone in the HomeLab by introducing centralized log collection through SIEM integration.  
The objective of this lab was to deploy Splunk Enterprise as a central logging platform and connect the Windows endpoint using Splunk Universal Forwarder to enable aggregated visibility across host telemetry sources.

This exercise simulated real SOC ingestion workflows, where endpoint telemetry is forwarded to a SIEM for monitoring, detection engineering, and investigation. The lab focused on infrastructure deployment, network configuration, forwarder setup, and ingestion validation to establish a functional telemetry pipeline.

🖥️ SIEM Infrastructure Deployment  
A dedicated Linux virtual machine was provisioned to host the Splunk Enterprise SIEM platform.

Actions performed  
Downloaded Ubuntu Desktop LTS ISO  
Created SPLK01 virtual machine within VirtualBox  
Configured NAT Network to enable VM-to-VM communication  
Installed Ubuntu and configured hostname as SPLK01  
Validated network connectivity between PC01 and SPLK01  

Outcome  
Successfully provisioned a dedicated SIEM host within the HomeLab environment.

Skills practiced  
Virtual machine provisioning  
Virtual networking configuration  
Infrastructure segmentation awareness  

📦 Splunk Enterprise Installation  
Splunk Enterprise was installed on the SPLK01 Linux host to serve as the centralized log aggregation platform.

Actions performed  
Downloaded Splunk Enterprise Linux package  
Extracted Splunk binaries and deployed to /opt directory  
Executed initial Splunk startup with license acceptance  
Created administrative credentials  
Verified splunkd service operational status  

Outcome  
Established a functioning Splunk Enterprise SIEM instance within the lab.

Skills practiced  
Linux application deployment  
Service lifecycle management  
SIEM platform initialization  

🌐 Splunk Web Interface Activation  
The Splunk Web interface was enabled and validated to provide operational access to the SIEM platform.

Actions performed  
Enabled Splunk webserver component  
Restarted Splunk services  
Verified listening state on port 8000  
Tested local and remote browser connectivity  

Outcome  
Confirmed availability of Splunk Web UI for analysis and administration.

Skills practiced  
Service troubleshooting  
Port validation  
Web interface accessibility testing  

📡 Data Receiver Configuration  
Splunk was configured to accept inbound telemetry from forwarders.

Actions performed  
Navigated to Forwarding and Receiving configuration within Splunk Web  
Enabled receiving port 9997  
Validated receiver readiness for endpoint ingestion  

Outcome  
Prepared SIEM infrastructure to accept forwarded endpoint telemetry.

Skills practiced  
SIEM ingestion configuration  
Forwarding architecture understanding  
Data pipeline preparation  

💻 Splunk Universal Forwarder Deployment  
Splunk Universal Forwarder was installed on the Windows endpoint to transmit telemetry to the SIEM.

Actions performed  
Downloaded Splunk Universal Forwarder for Windows  
Installed forwarder service on PC01  
Configured forwarding target to SPLK01 receiver  
Verified network connectivity to ingestion port  

Outcome  
Established endpoint forwarding capability toward centralized SIEM.

Skills practiced  
Endpoint agent deployment  
Forwarder configuration  
Telemetry routing awareness  

📥 Windows & Sysmon Log Ingestion Configuration  
Forwarder inputs were configured to collect both native Windows and Sysmon telemetry sources.

Actions performed  
Created custom inputs.conf configuration  
Enabled Security Event Log ingestion  
Enabled Sysmon Operational log ingestion  
Restarted forwarder service to apply configuration  

Outcome  
Activated host telemetry collection pipeline for both authentication and advanced endpoint activity logs.

Skills practiced  
Forwarder input configuration  
Telemetry source selection  
Agent-based log collection  

🔎 Ingestion Verification & Validation  
Telemetry flow from endpoint to SIEM was validated through Splunk search operations.

Actions performed  
Queried Splunk index for host visibility  
Executed searches for Windows Security events  
Executed searches for Sysmon telemetry  
Generated fresh endpoint activity to validate real-time ingestion  

Outcome  
Confirmed successful end-to-end telemetry pipeline from endpoint to SIEM platform.

Skills practiced  
SIEM query validation  
Telemetry pipeline verification  
Operational monitoring mindset  

🧠 Knowledge Gained  
Architecture of centralized log collection within SOC environments  
Role of SIEM as aggregation and analysis platform  
Forwarder-based telemetry collection methodology  
Importance of network configuration in telemetry pipelines  
Operational workflow for validating ingestion success  
Correlation potential between Security logs and Sysmon telemetry  

✅ Day 10 Checklist  
Provisioned SPLK01 Linux virtual machine  
Installed and initialized Splunk Enterprise  
Enabled Splunk Web interface  
Configured Splunk receiver port 9997  
Installed Splunk Universal Forwarder on PC01  
Configured forward-server connectivity  
Created inputs.conf for Windows Security and Sysmon logs  
Restarted forwarder service  
Validated host visibility within Splunk  
Confirmed ingestion of Security and Sysmon telemetry  
Captured representative SIEM ingestion screenshots  