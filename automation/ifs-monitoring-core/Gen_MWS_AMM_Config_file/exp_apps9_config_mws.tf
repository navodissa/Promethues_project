
# create AMM Config yaml file for MWS host
data "template_file" "varfile" {
  template = file("config_TESTversion_APPS10_MWS.yaml.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_local = data.azurerm_network_interface.mws.private_ip_address
    mws_TEST_password = data.azurerm_key_vault_secret.mws_TEST_password.value
    custid = "${var.custcode}"
    envtype = "${var.environmenttype}"
    adminport = "${var.Adminserverport}"
  }
}

//  Create the varfile.
resource "local_file" "varfile" {
  depends_on = [local_file.varfile]
  content  = data.template_file.varfile.rendered
  filename = "config_TESTversion_APPS10_MWS_${var.custcode}_${var.environmenttype}.yaml"
}

# create MWS Config yaml file for Central AMM
data "template_file" "cenvarfile" {
  template = file("config_TESTversion_APPS10_Central.yaml.tpl")

  // populate the template variables with these values
  vars = {
    host_ip_local = "${var.App9host_ip}"
    mws_TEST_password = "${var.MWS1_PASSWORD}"
    custid = "${var.custcode}"
    envtype = "${var.environmenttype}"
    adminport = "${var.Adminserverport}"
    fqdn = "${var.FQDN}"
  }
}

//  Create the varfile.
resource "local_file" "cenvarfile" {
  depends_on = [local_file.cenvarfile]
  content  = data.template_file.cenvarfile.rendered
  filename = "config_TESTversion_APPS10_Central_${var.custcode}_${var.environmenttype}.yaml"
}
