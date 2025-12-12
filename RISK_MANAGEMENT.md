# Risk Management Framework (project-level) — Azure Gov

This document describes a project-level Risk Management Framework (RMF) tailored for an Azure Government environment provisioning AKS and related platform services. It's based on the NIST Risk Management Framework concepts and adapted into a practical project playbook.

Scope
- Applies to infra and platform components provisioned by Terraform + TFE: networks, AKS clusters, ACR, Key Vault, monitoring.
- Covers CI/CD artifacts (images, pipelines), secrets handling, and operations.

Framework overview (NIST-inspired tasks)
1. Categorize (Identify)
   - Identify assets: clusters, registries, Key Vaults, VMs, networking components, identities.
   - Classify data sensitivity (e.g., Controlled Unclassified Information, PII, etc.)
   - Map to applicable control baseline (FedRAMP Moderate/High, DoD CC SRG, etc.)

2. Select (Security Controls)
   - Select baseline controls (Azure Policy, AKS, Key Vault, RBAC, logging).
   - Define acceptance criteria for each control (private endpoint enabled, diagnostic logs sent to Log Analytics, etc.)

3. Implement (Apply Controls)
   - Implement via Terraform modules and Sentinel/Azure Policy.
   - Ensure Key Vault-backed secrets, managed identities, and private endpoints.

4. Assess (Validate)
   - Automated checks: Sentinel policies, Azure Policy compliance, image scanning, automated IaC linting (tflint/checkov).
   - Manual audits: periodic architecture review and control validation.

5. Authorize (Risk Acceptance)
   - Risk Owners review residual risks and accept or require remediation.
   - Authorization decisions recorded in the Risk Register.

6. Monitor (Continuous)
   - 24/7 monitoring via Azure Monitor / Log Analytics.
   - Regular re-assessment after significant change or every X months (define cadence).

Roles & responsibilities
- Project Sponsor / Authorizing Official (AO): final acceptance for residual risk.
- Project Manager: ensures RMF activities are scheduled/executed.
- Security Architect / ISSO: defines controls and acceptance criteria.
- Platform Engineers: implement controls in IaC and CI/CD.
- DevOps / App Teams: follow secure build and deployment practices, remediate vulnerabilities in images.

Risk Register (template)
| ID | Title | Description | Likelihood | Impact | Risk Rating | Owner | Mitigation | Status | Review Date |
|----|-------|-------------|------------|--------|-------------|-------|------------|--------|-------------|
| R001 | Public IP exposure | Creation of public IPs for AKS nodes or LB | Medium | High | High | Platform Eng | Deny public IP via Sentinel/Azure Policy; use private AKS + internal LB | Mitigated | 2025-01-10 |

(Keep the register in an auditable location — e.g., a protected Confluence page or a secure repo with limited write permissions.)

Risk acceptance workflow
- For each residual risk, the owner fills the register entry, assigns mitigation timeline, and routes to the AO for sign-off.
- If AO rejects, changes must be implemented before production deployment.

RMF Practices & Tooling
- Integrate Sentinel policies in TFE to block non-compliant Terraform plans.
- Use Azure Policy initiatives assigned at the subscription/management-group level for continuous enforcement.
- Use automated CI checks (tflint, checkov) and container scans (Trivy) as gate checks.
- Use GitHub OIDC for short-lived credentials and avoid long-lived service principals where possible.

Incident Response & Remediation
- Triage: Security on-call receives alerts from Azure Defender/Monitor.
- Containment: Use AKS network policies and Azure Firewall to isolate affected resources.
- Eradication: Rebuild compromised images from known-good sources and rotate secrets.
- Lessons Learned: Update RMF and controls based on root cause.

Cadence and Reporting
- Weekly operational security review for open high-severity items.
- Quarterly RMF re-assessment (controls, policy effectiveness, risk register review).
- Annual formal authorization decision (AO sign-off) for production environment.

Appendix: Useful mapping
- TFE Sentinel policies <-> Prevent non-compliant Terraform
- Azure Policy <-> Continuous enforcement across subscriptions
- Logging (Log Analytics) <-> Evidence for audits and retrospective analysis
