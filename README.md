# Cloud & Container Security Lab

A personal AWS and Kubernetes lab, built in two stages between 2023 and 2024. The code is unchanged since February 2024. This README was added in October 2026, when the repo was prepared for sharing.

## 2023: Cloud security exercise

I built a deliberately insecure AWS environment in Terraform as a cloud security exercise:

- VPC, subnets and routing
- EKS cluster running Jenkins as the web application (Helm)
- MongoDB on an EC2 VM, with database backups to S3
- IAM roles for the VM and Kubernetes service accounts

The insecure parts were intentional:

- Highly privileged EC2 instance
- Publicly accessible S3 bucket
- Exposed Jenkins front end
- Highly privileged Kubernetes service accounts

The original Terraform for this stage is in commit `3d6ec83`.

## 2024: Runtime and supply-chain test environment

At Sysdig, I reused the same EKS and Jenkins platform as my demo and test environment for runtime threat detection and image scanning. I used it to deploy and validate tooling before putting it in front of customers.

| Path | What it is |
|---|---|
| `*.tf` | EKS cluster, networking and an EC2 proxy (`proxy.tf`) for testing tooling that connects out through a proxy |
| `jenkins_deployments/` | Jenkins in the cluster for build-and-scan jobs, with its service account and storage |
| `test_image/` | A deliberately vulnerable test image (old Ubuntu base, outdated curl built from source) used to exercise image scanning in CI |
| `nginx_deployments/` | The same nginx app deployed four ways (baseline, privileged, running as root, host `/etc` mount) to test runtime detection rules |

## Deploying

```bash
terraform init
terraform plan
```

This deploys intentionally risky workloads. Use an isolated AWS account and tear it down when finished.

## History

Before publishing, these were removed from the full git history:

- `terraform.tfvars`, which contained a credential
- Terraform state files
- A vendored third-party Helm chart
- Scanner logs and SBOM output with vendor tenant links
- The AWS account ID and security group ID
