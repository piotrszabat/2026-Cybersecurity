# Detection Test Plan

## Objective
Validate that repository detections can be tested against lab activity.

## Planned Test Cases
- failed login attempts
- PowerShell encoded command
- admin account creation
- nmap reconnaissance

## Expected Results
Each detection should generate expected telemetry and be reviewable in Splunk and/or Wazuh.