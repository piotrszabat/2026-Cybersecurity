# Day 72 — Detection-as-Code Setup

## Objective

Create a structured GitHub repository for detection engineering content and organize detections as code.

## Repository Name

```text
detection-engineering-lab
```

## Repository Structure

```text
detection-engineering-lab/
├── sigma/
├── kql/
├── splunk/
├── tests/
└── docs/
```

## Expanded Structure

```text
sigma/windows/
sigma/network/
kql/identity/
kql/endpoint/
splunk/authentication/
splunk/execution/
splunk/network/
splunk/persistence/
```

## README Content

The README documents:

- what is detected
- lab architecture
- tools used
- repository structure
- project objectives

## Naming Convention

Detections use the following format:

```text
DET-###-short-name
```

Examples:

```text
DET-001-bruteforce.yaml
DET-002-powershell.yaml
DET-003-admin-account-creation.yaml
```

## Initial Content Added

Example starter files were created for:

- Splunk detections
- Sigma detections
- test planning
- repository documentation

## Outcome

A dedicated Detection-as-Code repository was created to organize, document, and version-control detection content from the homelab.

## Skills Demonstrated

- detection-as-code setup
- repository structure design
- GitHub project organization
- detection naming standardization
- security content management
- portfolio documentation