# Day 55 — Credential Attack Detection

## Objective

The objective of Day 55 was to simulate credential-based attacks in a controlled homelab environment and validate whether authentication abuse was visible across the detection pipeline using **Wazuh** and **Splunk**.

This lab focused on one of the most common SOC investigation patterns:

```text
credential attack → authentication telemetry → SIEM visibility → analyst investigation
````

The goal was not only to generate failed authentication activity, but also to confirm that the telemetry could be searched, grouped, and investigated in a realistic SOC workflow.

---

## Lab Environment

### Attack Infrastructure

* **Attacker:** `KALI01`
* **Targets:** `PC01`, `SRV01`
* **Identity Infrastructure:** `DC01`

### Detection Stack

* **Wazuh** for endpoint telemetry and alerting
* **Splunk** for SIEM analysis, searching, and validation

### Detection Flow

```text
Credential attack
   ↓
Windows authentication events
   ↓
Wazuh agent
   ↓
WAZ01
   ↓
alerts.json
   ↓
Splunk
   ↓
search / correlation / investigation
```

---

## Step 1 — Prepare Test Scope

Before generating credential attack telemetry, the lab environment was reviewed to ensure that:

* the attacker machine (`KALI01`) could reach the Windows endpoint
* SMB was exposed on the target host
* authentication-related events were already being ingested into Wazuh and Splunk

This ensured that any failed login attempts generated during the simulation would be observable inside the SIEM pipeline.

---

## Step 2 — Verify Network and SMB Connectivity

From `KALI01`, I verified connectivity to the target system with:

```bash
ping 192.168.10.20
nmap -p 445 192.168.10.20
```

### Result

```text
445/tcp open microsoft-ds
```

This confirmed that the target host was reachable and listening on SMB, which is required for credential attack simulation over TCP/445.

---

## Step 3 — Simulate Password Spraying Behavior

To simulate password spraying, I attempted to authenticate to the Windows host using one password across multiple usernames.

Example approach:

```bash
crackmapexec smb 192.168.10.20 -u users.txt -p 'test123!'
```

This represents the classic pattern:

```text
one password → many usernames
```

The purpose of this step was to generate failed SMB authentication attempts that would appear in Windows authentication logs and then flow into Wazuh and Splunk.

---

## Step 4 — Simulate Direct SMB Login Attempts

I then simulated more direct SMB authentication attempts using a single username and an invalid password.

Example:

```bash
crackmapexec smb 192.168.10.20 -u Administrator -p 'test123!'
```

This generated repeated authentication failures against the target host and allowed me to validate failed-login visibility in the SIEM.

### Notable Observation

During testing, some SMB attempts returned connection errors such as NetBIOS timeouts. This required basic troubleshooting of SMB communication and host-side firewall behavior before continuing with the simulation.

That troubleshooting was useful on its own, because it reflected a realistic analyst/lab workflow: attack simulation often requires validating both offensive paths and telemetry paths.

---

## Step 5 — Observe Authentication Telemetry

After running the attack simulation, I reviewed the resulting authentication telemetry in Splunk.

### Example search used

```spl
index="wazuh-alerts" ("4625" OR "failed" OR "authentication")
| stats count by agent.name rule.description data.win.eventdata.targetUserName
| sort - count
```

### Observed results included

* failed logon events
* bad password / unknown user events
* successful and failed Windows logon activity
* remote logon-related detections
* NTLM authentication-related events

This confirmed that the environment was generating visible telemetry from the simulated credential abuse.

---

## Step 6 — Validate Event Visibility in Splunk

The Splunk output showed that authentication events were searchable and could be grouped by:

* endpoint
* rule description
* targeted username

This is a critical SOC validation step because it proves that analysts can pivot on:

* **which system saw the activity**
* **which user account was targeted**
* **how often the activity occurred**
* **whether suspicious authentication patterns can be identified quickly**

Example analyst view:

```spl
index="wazuh-alerts" ("4625" OR "failed" OR "authentication")
| table _time agent.name rule.description data.win.eventdata.targetUserName
| sort - _time
```

---

## Step 7 — Review Wazuh and SIEM Detection Coverage

This stage of the lab validated that the detection stack was able to observe the simulated credential attack path end to end.

### What was confirmed

* Windows hosts generated authentication telemetry
* Wazuh collected and parsed the relevant events
* Splunk indexed the events successfully
* failed authentication patterns were visible for investigation

This means the lab successfully demonstrated:

```text
attack activity → endpoint logs → Wazuh → Splunk → analyst visibility
```

---

## Step 8 — Compare Attack Patterns

A useful analyst takeaway from Day 55 was the difference between the two credential attack styles tested.

### Password Spraying

```text
one password
many accounts
lower-and-slower authentication abuse
```

### SMB Login Attempts

```text
direct SMB authentication to a target host
single or repeated login attempts
more obvious failed logon footprint
```

This comparison is important because both techniques can generate similar authentication failures, but their behavior patterns and investigation context can differ.

---

## Step 9 — Analyst Findings

Based on the simulation and Splunk review, the following analyst-relevant findings were confirmed:

* the target system (`PC01`) generated visible failed authentication activity
* authentication-related telemetry was searchable in Splunk
* suspicious authentication attempts could be grouped by user and endpoint
* remote login-related events were also visible during the test window
* the SIEM provided enough context to begin an investigation from raw failed-auth events

This reflects a realistic Tier 1 / Tier 2 SOC workflow, where the analyst starts with failed-login visibility and then pivots into endpoint, user, and attack-path context.

---

## Technical Challenges & Troubleshooting

During the lab, I encountered issues that required troubleshooting before the credential attack simulation worked as expected.

### Issues encountered

* SMB / NetBIOS timeout behavior during `crackmapexec` attempts
* credential testing required validation of Windows-side access path
* some authentication attempts produced connection errors before reaching full logon failure behavior

### Why this mattered

This improved the realism of the lab. In real environments, analysts and defenders do not only review detections — they also validate whether log sources, services, and network paths are functioning correctly.

---

## Outcome

Day 55 successfully demonstrated that credential attack activity in the homelab environment was visible across the security monitoring pipeline.

### Confirmed outcomes

```text
[+] simulated password spraying behavior
[+] simulated SMB login attempts
[+] generated failed authentication telemetry
[+] observed searchable Wazuh/Splunk events
[+] validated SIEM visibility for credential abuse
[+] documented findings for portfolio use
```

---

## Skills Demonstrated

* credential attack simulation in a controlled lab
* password spraying awareness
* SMB authentication analysis
* Splunk event investigation
* Wazuh alert validation
* failed logon telemetry analysis
* attack-to-detection workflow validation
* troubleshooting SMB/authentication issues in lab environments

---

## GitHub Portfolio Summary

Day 55 focused on simulating **credential attacks** against Windows systems and validating whether failed authentication activity was visible in the SIEM pipeline.

By generating SMB authentication attempts from `KALI01` toward `PC01`, I confirmed that authentication-related events were successfully collected by **Wazuh** and indexed in **Splunk**, where they could be grouped and investigated by endpoint, user, and rule description.

This lab demonstrated practical SOC skills in:

* attack simulation
* authentication telemetry analysis
* SIEM investigation
* detection validation
* troubleshooting data visibility issues

---

## Final Summary

Before Day 55, the homelab had basic detection capability.

After Day 55, the environment was validated against **identity-focused attack behavior**, showing that failed authentication attempts and credential abuse patterns could be observed and investigated through Wazuh and Splunk.

This is a strong SOC portfolio milestone because it demonstrates not only attack simulation, but also analyst-side validation of authentication telemetry in a realistic detection workflow.

---

## Next Step

**Day 56 — Attack Investigation Timeline**

Planned focus:

* correlate Day 54 and Day 55 activity
* build a timeline from attack execution to detection
* improve investigation and reporting workflow
