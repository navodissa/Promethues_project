provider "azurerm" {
        subscription_id = local.subscription_id
        client_id = var.azure_client_id
        client_secret = var.azure_client_secret
        tenant_id = var.azure_tenant_id
		skip_provider_registration = "true"
		
        version = "~>2.0"
        features {}
}


# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "${local.rg}"
}

# refer to a key vault
data "azurerm_key_vault" "tst_keyvault" {
  name                = "${local.kv}"
  resource_group_name = "${local.rg}"
}

data "azurerm_key_vault_secret" "mysqladmin_password" {
  name         = "mysqladmin-password"
  key_vault_id = data.azurerm_key_vault.tst_keyvault.id
}

//  Create the ansible variable file.

data "template_file" "ansible_vars_file" {
  template = file("ansible_vars_file.yml.tpl")

  // populate the template variables with these values
  vars = {
    #vm_password  = data.azurerm_key_vault_secret.vm_password.value
    snow_reader_client_id = "${var.snow_reader_client_id}"
    snow_reader_client_secret = "${var.snow_reader_client_secret}"
    mysqladmin_password = data.azurerm_key_vault_secret.mysqladmin_password.value
  }
}



resource "local_file" "ansible_vars_file" {
  content  = data.template_file.ansible_vars_file.rendered
  filename = "ansible_vars_file.yml"
}


resource "local_file" "export-vars" {
    content     = "#!/bin/bash\nexport PREFIX=${var.prefix}\nexport ENV=${var.env}\nexport RES_GP=${local.rg}\nexport SUBSCRIPTION_ID=${local.subscription_id}\nexport CLIENT_ID=${var.azure_client_id}\nexport CLIENT_SECRET=${var.azure_client_secret}\nexport TENANT_ID=${var.azure_tenant_id}\nexport ENTAPP_CLIENT_ID=${var.entapp_client_id}\nexport ENTAPP_CLIENT_SECRET=${var.entapp_client_secret}\nexport ALLREGION='${local.allregion}'\nexport ALLVMSSCOMP='${local.allvmsscomp}'\nexport ALLVMCOMP='${local.allvmcomp}'\nexport mysqladmin_password='${data.azurerm_key_vault_secret.mysqladmin_password.value}'\nexport ALLVMEXP='${local.allvmexp}'\nexport ALLWINEXP='${local.allwinexp}'\n"
    filename = "export-variables.sh"
}