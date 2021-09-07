provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "=1.36.0"
}


# refer to a resource group
data "azurerm_resource_group" "rg" {
  name = "${var.ResourceGroupName}"
}


#refer to a db network interface to allow ipv4 (compatible with TEST10)
data "azurerm_network_interface" "mws" {
 name                = "${var.mws_vm_nic}"
 resource_group_name = "${var.ResourceGroupName}"
}

# refer to a key vault
data "azurerm_key_vault" "tst_keyvault" {
  name                = "${var.custcode}-${var.TESTversion}-${var.environmenttype}-kv1"
  resource_group_name = "${var.ResourceGroupName}"
}

data "azurerm_key_vault_secret" "db_dbmonitor_password" {
  name         = "db-dbmonitor"
  key_vault_id = data.azurerm_key_vault.tst_keyvault.id
}

# create var yml file
data "template_file" "varfile" {
  template = file("customer-oracledb-vars.yml.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_local = data.azurerm_network_interface.mws.private_ip_address
    db_password = data.azurerm_key_vault_secret.db_dbmonitor_password.value
    custid = "${var.custcode}"
    envtype = "${var.environmenttype}"
  }
}

//  Create the varfile.
resource "local_file" "varfile" {
  depends_on = [local_file.varfile]
  content  = data.template_file.varfile.rendered
  filename = "customer-oracledb-vars_${var.custcode}_${var.environmenttype}.yml"
}

# create DBA var yml file
data "template_file" "dbvarfile" {
  template = file("config_DBA_APPS10.yml.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_local = data.azurerm_network_interface.mws.private_ip_address
    host_name = "${var.Hostname}"
    db_password = data.azurerm_key_vault_secret.db_dbmonitor_password.value
    custid = "${var.custcode}"
    envtype = "${var.environmenttype}"
  }
}

//  Create the varfile.
resource "local_file" "dbvarfile" {
  depends_on = [local_file.dbvarfile]
  content  = data.template_file.dbvarfile.rendered
  filename = "config_DBA_APPS10_${var.custcode}_${var.environmenttype}.yml"
}