# Day 53 — SIEM Correlation Rules (Splunk)

## Objective

The goal of Day 53 was to move from passive log monitoring to active detection by creating SIEM correlation rules in Splunk. These rules identify suspicious behavior patterns across multiple events using telemetry collected from Wazuh agents.

---

## Step 1 — Verified Authentication Events

I began by confirming that authentication-related events were being ingested into Splunk.

Search used:

```
index="wazuh-alerts" ("failed" OR "logon")
| head 20
```

This confirmed visibility of failed login attempts (Windows Event ID 4625), which are required for brute force detection.

---

## Step 2 — Created Detection Rule: Multiple Failed Logins

To detect brute force attacks, I built a correlation rule that counts failed login attempts per source IP.

Search:

```
index="wazuh-alerts" rule.description="*failed*login*"
| stats count by agent.name
| where count > 5
```

I converted this into a Splunk alert with the following configuration:

* Title: Multiple Failed Login Attempts
* Type: Scheduled
* Frequency: Every 5 minutes
* Trigger: Number of results > 0
* Severity: Medium

---

## Step 3 — Tested Brute Force Detection

I generated failed login attempts from an endpoint by entering incorrect credentials multiple times.

After exceeding the threshold, the alert successfully triggered in Splunk under:

```
Activity → Triggered Alerts
```

---

## Step 4 — Created Detection Rule: PowerShell Suspicious Activity

Next, I created a detection for suspicious PowerShell usage involving network activity.

Search:

```
index="wazuh-alerts" data.win.eventdata.image="*powershell*"
("download" OR "http" OR "iex" OR "invoke-webrequest")
```

Alert configuration:

* Title: PowerShell Suspicious Network Activity
* Frequency: Every 5 minutes
* Trigger: Number of results > 0
* Severity: High

---

## Step 5 — Tested PowerShell Detection

I simulated suspicious activity using PowerShell:

```
powershell Invoke-WebRequest http://example.com
```

The detection rule successfully identified the activity and triggered an alert.

---

## Step 6 — Created Detection Rule: Admin Account Creation

To detect persistence techniques, I created a rule to identify new user creation and privilege escalation.

Search:

```
index="wazuh-alerts" rule.description="*user*created*"
```

Alert configuration:

* Title: Admin Account Creation
* Frequency: Every 5 minutes
* Trigger: Number of results > 0
* Severity: Critical

---

## Step 7 — Tested Admin Account Detection

I created a new user and added it to the administrators group:

```
net user testadmin Password123! /add
net localgroup administrators testadmin /add
```

The alert successfully triggered in Splunk, confirming detection capability.

---

## Step 8 — Verified All Alerts

I reviewed all triggered alerts in Splunk:

```
Activity → Triggered Alerts
```

Confirmed detections:

* Multiple Failed Login Attempts
* PowerShell Suspicious Network Activity
* Admin Account Creation

---

## Outcome

Successfully implemented three SIEM correlation rules in Splunk that detect:

* Brute force login attempts
* Suspicious PowerShell activity
* Administrative account creation

This marks the transition from log monitoring to real-time detection in the SOC environment.

---

## Skills Demonstrated

* SIEM correlation rule creation
* Splunk alert configuration
* Windows security event analysis
* Detection engineering fundamentals
* Attack simulation and validation

---

## Key Takeaway

Day 53 introduced the detection layer in my SOC lab:

```
Before: Logs → Dashboards  
After:  Logs → Detections → Alerts  
```

This is a critical step toward building a fully functional SOC and developing detection engineering skills.
