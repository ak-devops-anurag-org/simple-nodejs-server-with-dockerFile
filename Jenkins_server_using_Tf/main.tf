resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "jenkins_vm" {
  source              = "./modules/azure_vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vm_name             = var.vm_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_size             = var.vm_size
  jenkins_admin_port  = var.jenkins_admin_port
}
