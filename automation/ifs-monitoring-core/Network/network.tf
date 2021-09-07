provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "=1.36.0"
}

# Create template from network Powershell Script
data "template_file" "network" {
  template = file("network.tpl")
  // populate the template variables with these values
  vars = {
    custcode = "${var.custcode}"
    TESTversion = "${var.TESTversion}"
    subscription_id = "${var.azure_subscription_id}"
    tenant_id          = "${var.azure_tenant_id}"
    client_id          = "${var.azure_client_id}"
    client_secret      = "${var.azure_client_secret}"
    ResourceGroupName  = "${var.ResourceGroupName}"
    

  }
}

//  Create the Powershell file.
resource "local_file" "network" {
  content  = data.template_file.network.rendered
  filename = "network.ps1"
}