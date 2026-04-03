Day 33 focused on validating Active Directory and DNS functionality in the INT corporate network after completing the segmented network migration.

The objective of this lab was to confirm that the HomeLab behaves like a real enterprise Windows environment, where:

* **DC01 provides DNS + AD services**
* **PC01 is correctly joined to the domain**
* **Kerberos prerequisites (time + DNS)** are correct
* **Group Policy applies successfully** and produces verifiable results
* Evidence is documented in a SOC-style manner for reproducibility

This lab followed a structured validation workflow:

```
baseline checks → DNS validation → domain join validation → GPO verification → evidence collection → documentation
```

---

# 🧩 Environment

| Host | Network | IP Address    | Role                      |
| ---- | ------- | ------------- | ------------------------- |
| DC01 | INT     | 192.168.10.10 | Domain Controller + DNS   |
| PC01 | INT     | 192.168.10.20 | Domain-joined workstation |
| FW01 | INT GW  | 192.168.10.1  | Default gateway           |

Domain:

* `corp.lab` *(or your configured AD domain)*

---

# ✅ Baseline Network Validation

Before testing AD services, baseline network configuration was confirmed because AD heavily depends on correct DNS and time synchronization.

### DC01 IP Configuration

Command:

```
ipconfig /all
```

Verified:

* IPv4 address matches design (**192.168.10.10**)
* Default gateway is **192.168.10.1**
* DNS points to itself (**192.168.10.10**)

---

### PC01 IP Configuration

Command:

```
ipconfig /all
```

Verified:

* IPv4 address matches design (**192.168.10.20**)
* Default gateway is **192.168.10.1**
* DNS is set to **192.168.10.10** *(critical for AD)*

---

### Time Validation (Kerberos requirement)

Command:

```
w32tm /query /status
```

Verified:

* Time service is active
* No significant clock drift

This confirms the workstation is not blocked by time-based Kerberos authentication failures.

Skills practiced:

* Enterprise baseline validation
* DNS dependency verification
* Kerberos prerequisites awareness

---

# 🌐 DNS Validation (DC01 as DNS Authority)

DNS functionality was validated to ensure that DC01 correctly resolves internal names and forwards external queries.

### DNS Zone Verification (DC01)

On DC01, DNS Manager was checked to confirm:

* The forward lookup zone exists (e.g., `corp.lab`)
* DC01 host records are present

Outcome:

DC01 is confirmed as the authoritative DNS server for the domain.

---

### Internal Name Resolution (PC01)

Commands:

```
nslookup dc01
nslookup dc01.corp.lab
```

Expected / Observed:

* DC01 resolves to **192.168.10.10**
* DNS server used is **192.168.10.10**

Outcome:

Internal DNS resolution works as expected for enterprise naming.

---

### External Forward DNS Resolution (PC01)

Command:

```
nslookup google.com
```

Outcome:

External domain resolution succeeded, confirming that DNS forwarding on DC01 is working properly *(either via configured forwarders or default recursion settings depending on implementation)*.

Skills practiced:

* DNS troubleshooting methodology
* Internal vs external resolution validation
* Enterprise DNS verification

---

# 🏢 Domain Join Validation (PC01 in Active Directory)

After DNS validation, domain trust and membership were confirmed.

### Confirm Domain Membership (PC01)

Command:

```
systeminfo | findstr /B /C:"Domain"
```

Outcome:

PC01 reports membership in the correct domain.

---

### Secure Channel Validation (PC01)

Command:

```
Test-ComputerSecureChannel -Verbose
```

Expected / Observed:

* `True`

Outcome:

PC01 has a valid secure channel to the domain controller.

---

### ADUC Validation (DC01)

On DC01, Active Directory Users and Computers was used to verify:

* PC01 computer object exists in AD (Computers container or correct OU)

Outcome:

PC01 is correctly registered and managed in Active Directory.

Skills practiced:

* Domain trust verification
* Secure channel troubleshooting workflow
* AD object validation

---

# 📜 Group Policy Validation (GPO Evidence)

Group Policy processing was tested to confirm that domain policy enforcement is functioning correctly.

### Force Policy Refresh (PC01)

Command:

```
gpupdate /force
```

Outcome:

Group Policy update completed successfully.

---

### Verify Applied Policies (PC01)

Commands:

```
gpresult /r
gpresult /h C:\Temp\gpresult.html
```

Outcome:

The generated gpresult output confirmed that:

* GPOs are being applied from the domain
* Computer policy processing is working
* (Optional) User policies also apply depending on scope

---

### Proof-of-Effect Validation (Visible GPO Outcome)

A visible GPO effect was validated to prove the policy is not only detected but also enforced on the endpoint.

Example implemented:

* Interactive Logon Banner via GPO
  (displayed on PC01 logon screen after gpupdate)

Outcome:

A clear visual artifact confirmed Group Policy enforcement end-to-end.

Skills practiced:

* Policy enforcement validation
* Evidence-based GPO verification
* Enterprise endpoint configuration confirmation

---

# 🧾 Evidence & Documentation Collected

Evidence gathered and stored under:

```
telemetry/day33-ad-dns-validation/screenshots/
```

Artifacts include:

* DC01 and PC01 `ipconfig /all`
* PC01 `w32tm` status
* DNS Manager zone screenshot
* nslookup results (internal + external)
* systeminfo domain output
* Test-ComputerSecureChannel result
* ADUC showing PC01 object
* gpupdate output
* gpresult report output (CLI + HTML)
* visible GPO effect (logon banner)
* (Optional) Event Viewer logs for GroupPolicy Operational

This documentation style mirrors real SOC / infrastructure validation reporting.

---

# 🧠 Knowledge Gained

Understanding AD dependencies: DNS + time synchronization
Validating DNS authority and forward resolution
Confirming domain join and secure channel trust
Verifying AD objects inside ADUC
Proving Group Policy processing using gpupdate + gpresult
Producing portfolio-grade evidence of enterprise Windows functionality

---

# ✅ Day 33 Checklist

DC01 and PC01 IP configuration verified
PC01 uses DC01 as DNS server
Internal name resolution works (dc01 / FQDN)
External DNS resolution works (google.com)
PC01 confirms correct domain membership
Secure channel validation returns True
PC01 computer object exists in ADUC
gpupdate completes successfully
gpresult confirms applied policies
Visible GPO effect confirmed (banner/wallpaper)
Evidence captured and committed to repository

---

# 🔜 Next Steps (Day 34)

Next, the lab will move toward security telemetry and SIEM operations, including:

* Splunk forwarder configuration on endpoints
* Firewall validation for Splunk ingestion (9997)
* Confirming logs flow from INT → SOC
* Building initial Splunk searches/dashboards for visibility

This will transition the HomeLab into a true SOC-style environment with centralized detection and monitoring.

