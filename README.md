# Azure_GovCloud-Project
# Azure Gov Kubernetes + Terraform Enterprise starter (with RMF & Security)

This repository is a starter scaffold to provision Azure Government resources using Terraform Enterprise (TFE) and deploy workloads to AKS (Azure Government). It now includes an explicit Risk Management Framework (NIST RMF tailored) and a project security baseline.

Highlights
- Azure Government compatibility (AKS, ACR, Key Vault, private endpoints)
- Terraform Enterprise as the remote backend & policy engine (Sentinel)
- NIST-based Risk Management Framework and risk register template
- Security baseline (private clusters, managed identities, Key Vault, logging, image scanning)
- GitHub Actions integrated for build + image scanning + push to ACR (supports Azure Gov)
- Example Sentinel and Azure Policy artifacts to prevent public IPs being created

Files added
- RISK_MANAGEMENT.md — RMF, roles, cadence, risk register template
- SECURITY.md — security baseline, secrets & CI/CD recommendations
- sentinel/policies/deny_public_ip.sentinel — sample TFE Sentinel policy
- azure_policy/deny-public-ip.json — Azure Policy sample to block public IP creation
- .github/workflows/build-and-push.yml — build + trivy scan + push (Azure Gov-aware)

How this fits together
1. GitHub repo contains infra and application code. Developers open PRs per standard GitHub workflow.
2. Terraform roots (per environment) are connected to TFE as VCS workspaces. Sentinel policies are attached in TFE policy sets.
3. GitHub Actions build images, run static security checks and vulnerability scans, and push images to private ACR in Azure Gov.
4. Deployments to AKS are done via GitOps (ArgoCD/Flux) or pipeline-driven Helm/ kubectl with Kubernetes RBAC and Azure AD integration.
5. Continuous monitoring and risk review: the RMF defines risk owners and cadence for reassessment.

Next actions I can take (pick one)
- A) Scaffold env-specific Terraform roots (dev/prod) and open a PR with these files and the updated workflows.
- B) Add additional Sentinel policies (Key Vault must be used, AKS must be private, no public IPs, tagging enforcement).
- C) Add GitOps scaffolding (ArgoCD manifest repo) and sample app deployment.

Tell me which one and, if you want a PR, name the branch to use and confirm you want these files committed to the repository.
