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

## Structure

- `main.tf`: root module orchestration
- `backend.tf`: AzureRM backend stub for remote state
- `modules/networking`: VNet, subnet, and NSG
- `modules/compute`: public IP, NIC, and Linux VM
- `modules/platform`: storage, Function App, SQL, and Logic App

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the SSH public key placeholder with your real key.
3. Authenticate to Azure with `az login`.
4. Run `terraform init`.
5. Run `terraform plan`.
6. Run `terraform apply`.

If you want to use Azure remote state locally, run `terraform init` with backend config values:

```bash
terraform init \
  -backend-config="resource_group_name=<tfstate-rg>" \
  -backend-config="storage_account_name=<tfstatestorage>" \
  -backend-config="container_name=<tfstate-container>" \
  -backend-config="key=github-showcase.tfstate"
```

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
- `TF_STATE_RESOURCE_GROUP`
- `TF_STATE_STORAGE_ACCOUNT`
- `TF_STATE_CONTAINER`
- `TF_STATE_KEY`

The workflow:

- Runs `terraform fmt`, `terraform init`, and `terraform validate` on pull requests and pushes to `main`
- Uses Azure remote state automatically when the `TF_STATE_*` secrets are configured
- Runs `terraform plan` when Azure credentials and the SSH public key secret are configured
- Posts the Terraform plan into the pull request as a comment
- Runs `terraform apply` only through manual `workflow_dispatch` when you choose `apply=true`

## Azure OIDC Setup

Create a federated identity credential in Azure AD for the GitHub repository and branch/environment you want to trust.

1. Create or choose an Azure AD application/service principal.
2. Add a federated credential for this repository, for example `repo:balakrishnav171/terraform:ref:refs/heads/main`.
3. Grant that service principal the required Azure RBAC roles on the subscription or resource group.
4. Save these values as GitHub secrets:
   `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and `AZURE_SUBSCRIPTION_ID`.

For remote state, create a separate storage account/container for Terraform state and store the backend values in:
`TF_STATE_RESOURCE_GROUP`, `TF_STATE_STORAGE_ACCOUNT`, `TF_STATE_CONTAINER`, and `TF_STATE_KEY`.

The workflow uses GitHub OIDC plus Azure AD auth for both the provider and the `azurerm` backend, so you do not need to store an Azure client secret in GitHub.
