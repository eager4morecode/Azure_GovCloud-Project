# Security Baseline & Operational Controls (Azure Government)

This security baseline lists controls and operational recommendations for the Azure Gov platform this repo will provision.

Identity & Access
- Use Azure AD (Gov) with Conditional Access and PIM for elevated roles.
- Prefer Managed Identities for Azure resources. Use workload identity federation (GitHub OIDC) for GH Actions to avoid long-lived secrets.
- Enforce least privilege for service principals and role assignments (use custom roles with minimum required permissions where necessary).

Networking
- Default to private AKS clusters with private API server and private ACR endpoints.
- Deploy hub-and-spoke VNet architecture; place shared services (firewall, bastion, central logging) in hub.
- Use Azure Firewall or NGFW (hub) and NSGs at subnets; use Application Gateway with WAF for ingress if needed.
- Use service endpoints and private endpoints for PaaS (Key Vault, Storage, ACR) where supported.

Secrets & Keys
- Store all secrets in Azure Key Vault (soft-delete & purge protection enabled).
- Use Key Vault RBAC + Key Vault access policies for least privilege.
- Integrate Key Vault into AKS via Secrets Store CSI driver where appropriate.
- Rotate keys and secrets on a schedule and after any suspected exposure.

CI/CD / Build Security
- Use GitHub OIDC for short-lived tokens for Azure login (recommended).
- Implement image scanning in CI (Trivy/Clair) and fail builds on critical vulnerabilities.
- Sign images and enable content trust if possible (ACR Content Trust).
- Store build artifacts in private ACR and limit pull access via AAD/Azure RBAC.

Infrastructure as Code
- Use Terraform Enterprise/TFC remote backend with VCS integration.
- Enforce Sentinel policies in TFE policy sets to block high-risk changes (no public IPs, enforce tagging, require log diagnostics).
- Run IaC static analysis (tflint, checkov, terrascan) on PRs.

Runtime Security & Observability
- Enable Azure Defender for Containers / Defender for Cloud.
- Enable Container insights (Log Analytics) and Application Insights for apps.
- Implement resource-level monitoring and alerts for suspicious activity.
- Use network policies and pod security policies / Pod Security Admission (PSA) to restrict capabilities.

Vulnerability Management
- Automate image builds with updated base images and OS patches.
- Periodically scan running nodes and images; remediate critical/High CVEs immediately according to risk policy.

Compliance & Audit
- Configure Azure Policy assignments for required controls. Use an initiative containing policies to enforce platform standards.
- Maintain audit logs in a secured Log Analytics workspace with retention matching compliance requirements.
- Keep evidence of control enforcement (TFE runs, policy evaluations) for audits.

Operational Procedures
- Incident response playbook and runbook: define detection, triage, containment, eradication, recovery, and lessons learned steps.
- Backup and restore targets for critical components (e.g., etcd backups for AKS if self-managed; store charts and manifests in Git).
- On-call rotations and escalation procedures for platform availability and security incidents.

CI workflow example notes
- Use the workflow in `.github/workflows/build-and-push.yml` with:
  - Login to Azure using OIDC or short-lived service principal
  - Run SCA and container scanning (Trivy)
  - Push only signed/validated images to ACR
  - Promote images across environments via pipeline or GitOps (avoid pushing dev images directly to prod registries)

Secrets and GitHub
- Do not store secrets in repo. Use GitHub Secrets or integrate with Azure Key Vault via the GitHub Actions plug-in.
- If using GitHub Secrets, use repository-level protection and require PR reviews for secret changes.

Contact & escalation
- Platform Security Owner: [enter name/email]
- Incident Response: [enter pager / security distribution list]
