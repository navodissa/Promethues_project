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

data "azurerm_key_vault_secret" "mws_TEST_password" {
  name         = "mws-TEST"
  key_vault_id = data.azurerm_key_vault.tst_keyvault.id
}

data "template_file" "install_get_xml_infor" {
  template = file("get_weblogic_file.ps1.tpl")

  // populate the template variables with these values
  vars = {

    mws_TEST_password = data.azurerm_key_vault_secret.mws_TEST_password.value
    TESTversion = "${var.TESTversion}"
    subscription_id = "${var.azure_subscription_id}"
    tenant_id          = "${var.azure_tenant_id}"
    client_id          = "${var.azure_client_id}"
    client_secret      = "${var.azure_client_secret}"
    region             = "${var.region}"
    host_ip_local = data.azurerm_network_interface.mws.private_ip_address
    custcode           = "${var.custcode}"
    environmenttype    = "${var.environmenttype}"
    region = "${var.region}"
    hostname = "${var.Hostname}"

  }
}



resource "local_file" "install_get_xml_infor" {
  content  = data.template_file.install_get_xml_infor.rendered
  filename = "get_weblogic_file.ps1"
}


data "template_file" "get_weblogic_vars_file" {
  template = file("get_weblogic_vars_file.yml.tpl")

  // populate the template variables with these values
  vars = {
    
    custcode           = "${var.custcode}"
    environmenttype    = "${var.environmenttype}"
    
  }
}



resource "local_file" "get_weblogic_vars_file" {
  content  = data.template_file.get_weblogic_vars_file.rendered
  filename = "get_weblogic_vars_file.yml"
}