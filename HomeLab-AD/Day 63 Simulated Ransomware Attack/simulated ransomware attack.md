# Day 63 - Simulated Ransomware Behavior Validation

## Overview

On Day 63, I performed a controlled ransomware-style simulation in my homelab to validate whether my monitoring stack could detect behaviors commonly associated with ransomware activity. The objective was not to build or execute real malware, but to safely reproduce the types of signals that a SOC analyst would investigate during a ransomware incident.

This exercise focused on three core behaviors:

- suspicious process execution
- mass file modification
- outbound HTTP activity simulating beaconing

The activity was executed in a controlled test environment and reviewed through **Wazuh** and **Splunk** to assess detection visibility and investigation value.

---

## Lab Environment

The simulation was performed in my homelab environment with the following relevant systems:

- **PC01** - attack simulation target
- **WAZ01** - Wazuh server
- **SPLK01** - Splunk server
- **FW01** - firewall between lab segments

The primary detection pipeline used during this exercise was:

- **Sysmon telemetry**
- **Wazuh alerting**
- **Splunk search and investigation**

---

## Objective

The goal of this lab was to simulate ransomware-like activity in a safe way and validate whether my detection stack could observe:

1. command execution associated with suspicious behavior
2. rapid file changes in a controlled directory
3. simple outbound network activity
4. corresponding alerts and searchable events in Wazuh and Splunk

---

## Step-by-Step Breakdown

### Step 1 - Defined the scope of the simulation

I started by planning a safe ransomware-style test that would generate realistic telemetry without causing any destructive impact. The simulation was intentionally limited to a test directory and harmless outbound web requests.

This step was important because it ensured the activity stayed controlled and focused on detection engineering rather than malware execution.

**What this step was about:**
- creating a realistic but safe attack simulation
- limiting all activity to a non-production test path
- generating telemetry that could be reviewed by a SOC analyst

**How it was performed:**
- selected **PC01** as the target system
- decided to simulate process execution, file modification, and outbound requests
- avoided encryption, persistence, and destructive actions

---

### Step 2 - Prepared the endpoint for the simulation

I created a dedicated test folder and generated multiple harmless files on the Windows endpoint. This folder served as the controlled environment for simulating ransomware-like file impact.

**What this step was about:**
- preparing a safe target for mass file activity
- making it easier to observe file changes in logs
- keeping the simulation organized and repeatable

**How it was performed:**
- created a dedicated test directory on the endpoint
- populated it with multiple text files
- ensured only test files would be modified during the simulation

---

### Step 3 - Verified logging visibility before execution

Before running the simulation, I confirmed that telemetry from the endpoint was reaching the monitoring stack. This helped establish a baseline and ensured that any detections seen later were tied to the simulation window.

**What this step was about:**
- validating that the endpoint was actively sending logs
- checking that Wazuh alerts were searchable in Splunk
- creating a baseline for later comparison

**How it was performed:**
- reviewed recent events from **PC01**
- confirmed that the **wazuh-alerts** index was receiving data
- checked alert volume and event visibility before the simulation started

---

### Step 4 - Simulated suspicious process execution

I generated execution telemetry using PowerShell and command-line activity to simulate the initial stage of a ransomware-style attack chain. This was intended to create process creation logs and command-line visibility.

**What this step was about:**
- simulating suspicious execution behavior
- generating process and command-line telemetry
- validating whether execution artifacts were visible in Splunk and Wazuh

**How it was performed:**
- launched a PowerShell-based command from the endpoint
- used command-line activity that would appear in event telemetry
- generated execution logs that could later be correlated with file activity

---

### Step 5 - Simulated mass file modification

After process execution, I modified multiple files inside the dedicated test directory. This stage simulated one of the most recognizable indicators of ransomware behavior: rapid changes to many files in a short period of time.

**What this step was about:**
- reproducing ransomware-style file impact safely
- generating file-related telemetry without encryption
- validating whether file activity was detectable through Wazuh and Splunk

**How it was performed:**
- appended content to multiple test files in sequence
- performed repeated file changes within a short time window
- kept all activity restricted to the controlled test folder

---

### Step 6 - Simulated file renaming activity

To make the simulation more realistic, I also renamed files in the same test directory. This behavior resembles common ransomware patterns where files are modified and then renamed with a new extension.

**What this step was about:**
- simulating a second layer of ransomware-like file behavior
- creating stronger indicators for timeline reconstruction
- increasing the realism of the test without adding unsafe functionality

**How it was performed:**
- renamed files after modification
- applied changes only to the files created for the lab
- used this activity to produce additional event context during investigation

---

### Step 7 - Simulated outbound beaconing activity

I then generated repeated outbound HTTP requests to simulate simple beaconing behavior. This was used to test whether the detection stack could correlate file impact with network-related activity in the same investigation window.

**What this step was about:**
- simulating low-volume outbound communication
- producing network-related telemetry tied to the same host
- testing whether execution and network behaviors could be linked together

**How it was performed:**
- initiated repeated harmless HTTP requests from the endpoint
- kept the requests low volume and non-destructive
- ensured no payloads were downloaded or executed

---

### Step 8 - Reviewed Wazuh detections

Once the simulation was complete, I reviewed Wazuh alerts around the time of execution. I focused on process execution, command-line behavior, and file-related alerts that aligned with the controlled test.

**What this step was about:**
- validating that Wazuh captured the simulated behavior
- checking whether file and execution alerts aligned with the activity window
- confirming that the test produced useful security telemetry

**How it was performed:**
- searched Wazuh alerts for events from **PC01**
- reviewed alert descriptions related to PowerShell, files, and execution
- compared timestamps against the simulation timeline

---

### Step 9 - Investigated the activity in Splunk

I used Splunk to perform a more detailed review of the simulation. I searched the **wazuh-alerts** index to identify process execution, file change events, and suspicious command-line activity associated with the endpoint.

One of the views I used showed **Wazuh alert statistics and file-related events in Splunk**, which helped confirm that file activity from the simulated ransomware behavior was visible from the monitoring platform.

**What this step was about:**
- investigating the event chain in a SIEM workflow
- validating that alerts were searchable and useful for analysis
- reviewing the attack sequence from an analyst perspective

**How it was performed:**
- searched for events from **PC01** in Splunk
- filtered results using keywords such as PowerShell, cmd.exe, file activity, and HTTP-related behavior
- reviewed timestamps, rule descriptions, command-line fields, and raw logs

---

### Step 10 - Built an analyst timeline

After collecting the relevant events, I reconstructed a mini incident timeline to understand how the simulation appeared from a defender’s perspective. This was one of the most valuable parts of the exercise because it connected execution, file activity, and outbound traffic into a single investigation story.

**What this step was about:**
- turning raw logs into an analyst-readable incident timeline
- validating whether the monitoring stack provided enough context
- improving my ability to document attack flow clearly

**How it was performed:**
- sorted events chronologically in Splunk
- grouped related activity by execution, file changes, and network behavior
- mapped the progression of the simulation step by step

---

### Step 11 - Assessed detection quality

I then evaluated which parts of the simulation were most visible and which areas would benefit from better tuning or correlation rules. This step helped translate raw telemetry into detection engineering insight.

**What this step was about:**
- measuring the practical detection value of the lab
- identifying strengths and gaps in current visibility
- determining where future tuning would improve ransomware detection coverage

**How it was performed:**
- compared visibility across Wazuh and Splunk
- reviewed whether execution, file activity, and network behavior were equally observable
- noted where a dedicated ransomware correlation rule would improve coverage

---

## Results

The simulation successfully generated telemetry associated with ransomware-like behavior while remaining fully controlled and safe. The most useful findings were:

- PowerShell and command-line execution were visible in the monitoring stack
- file modification activity generated meaningful alerts and searchable events
- file-related behavior was especially useful for timeline reconstruction
- Splunk provided a strong investigation view through searchable Wazuh alert data
- current detections offered partial coverage, but a dedicated ransomware correlation rule would improve visibility

---

## Key Takeaways

This day significantly improved my homelab portfolio because it demonstrated the ability to:

- simulate adversary behavior safely
- validate endpoint and SIEM visibility
- investigate a multi-stage attack scenario
- correlate execution, file impact, and network activity
- document findings like a SOC analyst

This exercise moved beyond simple alert testing and into **behavioral attack simulation and detection validation**, which is much closer to real-world blue team work.

---

## Skills Demonstrated

- ransomware behavior simulation
- PowerShell telemetry analysis
- file integrity monitoring validation
- Splunk investigation workflow
- Wazuh alert review
- attack timeline reconstruction
- detection coverage assessment
- SOC-style documentation

---

## Conclusion

Day 63 was focused on simulating a controlled ransomware-style attack chain and validating whether my homelab could detect the resulting behavior. By combining suspicious execution, rapid file modification, and outbound HTTP activity, I created a realistic investigation scenario that could be analyzed through Wazuh and Splunk.

This lab demonstrated that my environment can capture meaningful telemetry for high-impact attack patterns and helped identify opportunities for future detection tuning and ransomware-specific correlation logic.