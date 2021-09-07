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

data "template_file" "install_get_xml_infor" {
  template = file("get_xml_infor.ps1.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_local = data.azurerm_network_interface.mws.private_ip_address
    custcode           = "${var.custcode}"
    environmenttype    = "${var.environmenttype}"
    region = "${var.region}"
    hostname = "${var.Hostname}"

  }
}



resource "local_file" "install_get_xml_infor" {
  content  = data.template_file.install_get_xml_infor.rendered
  filename = "get_xml_infor.ps1"
}