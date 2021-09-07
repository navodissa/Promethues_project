provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
  version         = "=1.36.0"
}


# refer to a resource group
#data "azurerm_resource_group" "rg" {
#  name = "${var.ResourceGroupName}"
#}


# create var yml file
data "template_file" "varfile" {
  template = file("customer-oracledb-vars.yml.tpl")

  // populate the template variables with these values
  vars = {
    subscription_id = "${var.azure_subscription_id}"
    eu_client_id = "${var.azdiscovery_eu_client_id}"
    eu_client_secret = "${var.azdiscovery_eu_client_secret}"
    na_client_id = "${var.azdiscovery_na_client_id}"
    na_client_secret = "${var.azdiscovery_na_client_secret}"    
    tenant_id = "${var.azure_tenant_id}"
    TESTversion = "${var.TESTversion}"
  

  }
}

//  Create the varfile.
resource "local_file" "varfile" {
  depends_on = [local_file.varfile]
  content  = data.template_file.varfile.rendered
  filename = "customer-oracledb-vars_${var.custcode}_${var.environmenttype}.yml"
}

# create DBA var yml file
#data "template_file" "dbvarfile" {
#  template = file("config_DBA_APPS10.yml.tpl")

  // populate the template variables with these values
#  vars = {
#    custid = "${var.custcode}"
#    envtype = "${var.environmenttype}"
#    subscription_id = "${var.azure_subscription_id}"
#    eu_client_id = "${var.azdiscovery_eu_client_id}"
#    eu_client_secret = "${var.azdiscovery_eu_client_secret}"
#    na_client_id = "${var.azdiscovery_na_client_id}"
#    na_client_secret = "${var.azdiscovery_na_client_secret}"    
#    tenant_id = "${var.azure_tenant_id}"
#    TESTversion = "${var.TESTversion}"

 # }

#//  Create the varfile.
#resource "local_file" "dbvarfile" {
#  depends_on = [local_file.dbvarfile]
#  content  = data.template_file.dbvarfile.rendered
#  filename = "config_DBA_APPS10_${var.custcode}_${var.environmenttype}.yml"
#}


resource "local_file" "export-vars" {
    content     = "#!/bin/bash\nlocation=europe\nif [ `echo $location|grep europe|wc -l` == 1 ];then\n ALLREGION=eu\nelif [ `echo $location|grep us|wc -l` == 1 ];then\n ALLREGION=us\nelse\n ALLREGION=eu\nfi\nexport ALLREGION\n"
    filename = "export-cust-variables.sh"
}
