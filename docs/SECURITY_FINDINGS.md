
# Lab 02 — Security Findings Report

**Organisation:** SkynetAI-Labs  
**Project:** Automated Security Scanning with GitHub Actions  
**Initial assessment date:** 16 October 2026  
**Remediation verification:** 23 October 2026  
**Current runtime:** Python 3.14 on Alpine Linux 3.23

## 1. Executive Summary

This laboratory demonstrates automated security scanning, vulnerability identification, remediation, rescanning and verification using GitHub Actions.

The original Docker image used Debian 13.7 and produced HIGH-severity vulnerability findings. Subsequent remediation removed runtime pip and its bundled libraries, followed by replacement of the Debian-based runtime with Python 3.14 on Alpine Linux 3.23.

The current Alpine image passed the configured Trivy HIGH/CRITICAL vulnerability gate. All five GitHub Actions workflows also passed during verification on 23 October 2026.

**Important:** The Debian vulnerability counts in this report are historical findings from the previous container image. They must not be presented as outstanding vulnerabilities in the current Alpine image.

## 2. Objective

Implement an automated DevSecOps security pipeline capable of:

- Running Python application tests.
- Performing static application security testing.
- Detecting exposed secrets.
- Auditing Python dependencies.
- Scanning Docker images for vulnerabilities.
- Enforcing security failure conditions.
- Documenting remediation and verification evidence.

## 3. Security Tools

| Tool | Purpose |
|---|---|
| pytest | Automated Python application testing |
| Semgrep | Static application security testing (SAST) |
| Gitleaks | Secret detection |
| pip-audit | Python dependency vulnerability auditing |
| Trivy | Docker container vulnerability scanning |
| GitHub Actions | Automated workflow execution |
| Docker | Container image building and runtime verification |

## 4. Historical Initial Vulnerability Assessment

The original Debian-based Docker image was assessed using Trivy.

### Initial findings

| Component | HIGH | CRITICAL |
|---|---:|---:|
| Debian 13.7 | 44 | 0 |
| Python libraries | 4 | 0 |
| **Total** | **48** | **0** |

The Python findings involved libraries bundled with pip:

- `msgpack` 1.1.2
- `urllib3` 2.7.0
- `setuptools` 70.3.0

These results describe the original image, not the current Alpine image.

## 5. Initial Remediation — Runtime Pip Removal

The demonstration application was tested and confirmed to operate without pip at runtime.

The Dockerfile was modified to remove pip and its bundled Python libraries from the final image.

The image was rebuilt and rescanned.

### Historical rescan results

| Component | HIGH | CRITICAL |
|---|---:|---:|
| Debian 13.7 | 44 | 0 |
| Python libraries | 0 | 0 |
| **Total** | **44** | **0** |

**Result:** Four HIGH-severity Python library findings were eliminated.

The remaining 44 HIGH findings related to packages in the previous Debian operating-system image.

## 6. Historical Debian Findings

The earlier Debian image continued to report 44 HIGH-severity operating-system findings after runtime pip removal.

A separate Trivy assessment using `--ignore-unfixed` reported no Debian findings with available fixes under that assessment.

These findings were not resolved by patching the affected Debian packages. Instead, the project subsequently replaced the Debian-based runtime with an Alpine-based image.

**Historical status:** The 44 HIGH findings belong to the retired Debian image. They are retained in this report as evidence of the original assessment and remediation process.

They are not outstanding findings in the current Alpine image.

## 7. Current Container Remediation

The Docker runtime was changed to:

`python:3.14-alpine3.23`

The current Dockerfile:

- Applies available Alpine package updates during image building.
- Removes pip from the runtime image.
- Creates a dedicated application user with UID `10001`.
- Copies the demonstration application into the image.
- Executes the application as a non-root user.

The GitHub Actions container workflow also verifies:

1. The Docker image builds successfully.
2. The application produces the expected greeting.
3. The container executes using UID `10001`.
4. Trivy completes its configured vulnerability scan.

## 8. Current Trivy Security Policy

The Trivy workflow uses the following security settings:

| Setting | Configuration |
|---|---|
| Scanner | Vulnerabilities |
| Severity threshold | HIGH, CRITICAL |
| Failure on matching findings | Enabled |
| Unfixed vulnerabilities | Included |
| Container runtime | Python 3.14 / Alpine 3.23 |

The workflow retains `--exit-code 1` and `--ignore-unfixed=false`.

A successful result means the scanned image did not trigger the configured HIGH/CRITICAL vulnerability failure condition at scan time.

It does not establish that the image is vulnerability-free. Lower-severity vulnerabilities and risks outside the configured scan remain outside this verification.

## 9. GitHub Actions Verification

The following automated checks passed during verification on 23 October 2026:

| Workflow | Verified result |
|---|---|
| Python application tests | Passed |
| Semgrep security scan | Passed |
| Gitleaks secrets scan | Passed |
| Python dependency audit | Passed |
| Trivy container security scan | Passed |

The remediation pull request also recorded successful push and pull request checks, with ten successful workflow checks in total.

The previous Debian-based Trivy failure was expected under the configured security policy because that earlier image contained HIGH-severity findings.

**Current status:** The replacement Alpine image passed the configured Trivy gate. The historical Debian failure must not be confused with the current workflow result.

## 10. Remediation Evidence

The remediation work is documented in:

[Pull Request #2 — Container Security Remediation](https://github.com/SkynetAI-Labs/lab-02-automated-security-scanning/pull/2)

The current repository contains:

- Python demonstration application.
- Automated Python test.
- Dockerfile using the Alpine-based runtime.
- GitHub Actions workflows for testing and security scanning.
- Security findings documentation.
- Lab 02 project banner.

## 11. Limitations and Ongoing Security Considerations

The following limitations apply:

- Vulnerability scan results represent the image and vulnerability data available at the time of scanning.
- The Trivy workflow checks vulnerabilities at HIGH and CRITICAL severity; lower severities do not trigger its configured failure condition.
- Passing automated checks does not replace comprehensive application security testing.
- The demonstration application and test suite are intentionally small.
- Dependency and scanner versions should be reviewed and maintained over time.
- The retired Debian findings remain historical evidence rather than current Alpine vulnerabilities.

The project must not be described as completely vulnerability-free or as having undergone comprehensive penetration testing.

## 12. Conclusion

Lab 02 successfully demonstrates an automated DevSecOps security workflow covering application testing, static analysis, secret detection, dependency auditing, container scanning, remediation and verification.

The original Debian-based image produced 48 HIGH-severity findings. Removing runtime pip eliminated four Python library findings, leaving 44 historical Debian findings. The Debian runtime was subsequently replaced with an Alpine-based image.

**Final status — Current Alpine image:** All five GitHub Actions workflows passed during verification on 23 October 2026. The Alpine container passed the configured Trivy HIGH/CRITICAL vulnerability gate, including unfixed findings, and the workflow verified non-root execution as UID `10001`.

The 44 HIGH Debian findings are historical findings from the previous image, not outstanding findings in the current Alpine image.

**SkynetAI-Labs | GitHub DevSecOps Lab 02**

