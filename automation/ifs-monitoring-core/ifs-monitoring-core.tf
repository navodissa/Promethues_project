######################## CONFIGURE MS AZURE PROVIDER ############################

provider "azurerm" {
        subscription_id = var.subscription_id
        client_id = var.client_id
        client_secret = var.client_secret
        tenant_id = var.tenant_id

        version = "~>2.0"
        features {}
}



########################## Create Azure Invork Power shell script #######################


data "template_file" "Invoke_az_command" {
  template = file("Invoke_az_command.tpl")

  // populate the template variables with these values
  vars = {
    tenant_id = "${var.tenant_id}"
    client_secret = "${var.client_secret}"
    subscription_id = "${var.subscription_id}"
    Resource_Group = "${var.rg}"
    name = "${var.prefix}-${var.env}-${var.region}-amm"
    client_id = "${var.client_id}"

    
  }
}

//  Create the Powershell file.
resource "local_file" "Invoke_az_command" {
  content  = data.template_file.Invoke_az_command.rendered
  filename = "Invoke_az_command.ps1"
}

