Jenkins server using Terraform

This folder contains a small, best-practice-focused Terraform scaffold to create an Azure VM and install Jenkins, OpenJDK and Docker using cloud-init.

What is included
- `versions.tf` - Terraform and provider constraints
- `provider.tf` - Provider configuration and backend example (local)
- `variables.tf` - Root variables for location, VM name, credentials etc.
- `main.tf` - Root module that creates a resource group and calls the `azure_vm` module
- `outputs.tf` - Helpful outputs such as public IP and Jenkins URL
- `terraform.tfvars.example` - Example values for quick start
- `modules/azure_vm` - Reusable module that creates networking, public IP, VM and runs cloud-init to install Jenkins

Security note
- This example uses password authentication for the VM. Do NOT commit real passwords into source control. Use environment variables, a secure vault, or Terraform Cloud variable sets for production.

Quick start
1. Copy the example tfvars file and edit values:

```powershell
cp .\terraform.tfvars.example .\terraform.tfvars
# Edit terraform.tfvars and replace placeholders (subscription_id, admin_password)
```

2. Initialize and apply Terraform:

```powershell
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

3. After apply, Terraform outputs `public_ip` and `jenkins_url`. Open the Jenkins URL in your browser.

Next steps / improvements
- Use `azurerm` backend for shared state (example uses local backend).
- Replace password auth with SSH key or Azure AD login for improved security.
- Configure managed identities and Key Vault to avoid storing secrets in tfvars.

