provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "=1.36.0"
  skip_provider_registration = true
}


# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "${var.ResourceGroupName}"
}


# refer to a key vault
data "azurerm_key_vault" "tst_keyvault" {
  #name                = "${var.custcode}-${var.TESTversion}-kv1"
  name                = "ITMB-TST-kv1"
  resource_group_name = "${var.ResourceGroupName}"
}

data "azurerm_key_vault_secret" "mws_TESTsrvadmin_password" {
  name         = "vm-${var.custcode}${var.environmenttype}01-TESTadmin"
  key_vault_id = data.azurerm_key_vault.tst_keyvault.id
}

# Oracle Inventory MWS Server
data "template_file" "inventory" {
  template = file("inventory.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_public = "${var.App9host_ip}"
    admin_password = data.azurerm_key_vault_secret.mws_TESTsrvadmin_password.value
  }
}

//  Create the inventory.
resource "local_file" "inventory" {
  depends_on = [local_file.inventory]
  content  = data.template_file.inventory.rendered
  filename = "inventory.cfg"
}

