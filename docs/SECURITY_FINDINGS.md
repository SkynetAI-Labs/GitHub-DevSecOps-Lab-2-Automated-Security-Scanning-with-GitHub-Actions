# Lab 2 — Security Findings Report

## Current Remediation Status

The replacement Python 3.14 Alpine 3.23 image passed both Trivy runs in remediation pull request #2. All 10 workflow checks succeeded. The workflow verified application output and non-root UID 10001.

The HIGH/CRITICAL failure policy remains enforced, including unfixed findings. These results apply to the replacement image at scan time, not to the old Debian image. Lower severities are outside this gate.

[Remediation and check evidence](https://github.com/SkynetAI-Labs/GitHub-DevSecOps-Lab-2-Automated-Security-Scanning-with-GitHub-Actions/pull/2)

## Historical Assessment — Previous Debian Image

The original assessment below is retained as history. Its outstanding findings and failure status describe the previous Debian image, not the current Alpine replacement.

**Organisation:** SkynetAI-Labs
**Project:** Automated Security Scanning with GitHub Actions
**Assessment date:** 16 October 2026

## 1. Objective

Implement automated security scanning using GitHub Actions and demonstrate vulnerability identification, remediation, rescanning and verification.

## 2. Security Tools

- pytest — Python application testing
- Semgrep — Static application security testing
- Gitleaks — Secret detection
- pip-audit — Python dependency auditing
- Trivy — Docker container vulnerability scanning

## 3. Initial Trivy Findings

| Component | HIGH | CRITICAL |
|---|---:|---:|
| Debian 13.7 | 44 | 0 |
| Python packages | 4 | 0 |
| Total | 48 | 0 |

## 4. Remediation

Trivy identified vulnerabilities in Python libraries bundled with pip:

- msgpack 1.1.2
- urllib3 2.7.0
- setuptools 70.3.0

The application was tested and confirmed to run without pip at runtime.

The Dockerfile was modified to remove pip and its bundled libraries from the final image.

The image was rebuilt and rescanned.

## 5. Verified Results

| Component | HIGH | CRITICAL |
|---|---:|---:|
| Debian 13.7 | 44 | 0 |
| Python packages | 0 | 0 |
| Total | 44 | 0 |

Four HIGH Python findings were eliminated.

## 6. Outstanding Security Findings

The remaining 44 HIGH findings relate to Debian operating-system packages.

A Trivy scan using `--ignore-unfixed` reported zero Debian findings with available fixes.

These findings remain unresolved and require continued monitoring, assessment and remediation when appropriate fixes become available.

The container must not be described as vulnerability-free.

## 7. CI/CD Verification

GitHub Actions successfully built the Docker image and executed Trivy.

The Trivy workflow returned a non-zero exit code because HIGH vulnerabilities remain.

This is expected behaviour under the configured security policy and must not be bypassed merely to obtain a passing workflow.

## 8. Conclusion

The laboratory demonstrated automated security scanning, vulnerability analysis, targeted remediation, repeat scanning and security reporting.

**Final status (current Alpine image):** All five GitHub Actions workflows passed on 23 October 2026. The replacement Alpine container passed the configured Trivy HIGH/CRITICAL vulnerability scan, including unfixed findings. The 44 HIGH Debian findings documented above belong to the previous image and remain historical findings, not outstanding findings in the current Alpine image. Lower-severity vulnerabilities and security risks outside the configured scans are not ruled out.
