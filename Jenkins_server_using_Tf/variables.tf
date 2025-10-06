variable "subscription_id" {
  type        = string
  description = "Azure subscription id to deploy resources into."
  default     = ""
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources into."
  default     = "eastus"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create/use."
  default     = "rg-jenkins-tf"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine."
  default     = "jenkins-vm"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM (password auth)."
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "VM size to create."
  default     = "Standard_DS1_v2"
}

variable "public_ssh_key" {
  type        = string
  description = "Optional public SSH key (not used if password auth)."
  default     = ""
}

variable "jenkins_admin_port" {
  type        = number
  description = "Port to expose Jenkins web UI."
  default     = 8080
}
