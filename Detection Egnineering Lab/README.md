Second part of my HomeLab, SOC Detection Lab is finished. 

Detection engineering lab repository containing Splunk, Sigma, and KQL detections, supporting documentation, and test content for a SOC homelab.

# Detection Engineering Lab

## Overview
This repository contains detection engineering content developed in a SOC homelab environment.

## Objectives
- build and manage detections as code
- organize detections by platform and category
- document detection logic and testing
- support continuous improvement of detection coverage

## Lab Architecture
- FW01: pfSense + Suricata
- WAZ01: Wazuh
- SPLK01: Splunk
- KALI01: attacker system
- DC01 / PC01 / SRV01: lab endpoints

## Tools Used
- Splunk
- Wazuh
- Suricata
- Sigma
- KQL
- Sysmon
- GitHub

## Repository Structure
- /sigma
- /kql
- /splunk
- /tests
- /docs

## Detection Categories
- Authentication
- Process Execution
- Network
- Persistence

## Status
This repository is being built as part of a detection engineering homelab.
