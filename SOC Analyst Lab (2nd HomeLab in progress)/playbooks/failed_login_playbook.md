# Playbook — Multiple Failed Logins

## Goal
Detect and respond to potential brute force attacks

## Steps
1. Identify affected user
2. Count failed attempts
3. Check source IP
4. Verify:
   - internal or external?
5. Check:
   - successful login after failures?
6. Investigate host activity

## Decision
IF:
- many failures + no success → possible brute force

IF:
- success after failures → possible compromise


## Response
- Reset password
- Lock account
- Block IP (lab simulation)

## Escalation
Escalate if:
- admin account targeted
- multiple hosts affected