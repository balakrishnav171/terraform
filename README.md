# GitHub Showcase Infrastructure

This Terraform project provisions an Azure showcase environment for portfolio or GitHub demos.

Resources included:

- Resource group
- Virtual network and VM subnet
- Network security group with SSH access
- Linux virtual machine
- Storage account and private blob container
- Linux Function App on a consumption plan
- Azure SQL Server and SQL Database
- Logic App workflow

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the SSH public key placeholder with your real key.
3. Authenticate to Azure with `az login`.
4. Run `terraform init`.
5. Run `terraform plan`.
6. Run `terraform apply`.

## Notes

- `terraform.tfvars`, `.terraform/`, and local state files are ignored so secrets and state do not get pushed.
- The SQL admin password is generated automatically and exposed as a sensitive Terraform output.
- Restrict `allowed_ssh_cidr` before deploying this outside a demo environment.

## GitHub Actions

The repository includes a workflow at `.github/workflows/terraform.yml`.

Add these GitHub repository secrets before using the workflow:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `TF_VAR_VM_ADMIN_SSH_PUBLIC_KEY`

The workflow:

- Runs `terraform fmt`, `terraform init`, and `terraform validate` on pull requests and pushes to `main`
- Runs `terraform plan` when Azure credentials and the SSH public key secret are configured
- Runs `terraform apply` only through manual `workflow_dispatch` when you choose `apply=true`
