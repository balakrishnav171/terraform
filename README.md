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
