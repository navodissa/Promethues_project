variable "prefix" {
  description = "Project Code or Name"
  type        = string
  default = "csc-mon"
}

variable env {
  description = "Environment where VMs will be provisioned"
  type        = string
  default     = "dev"
}

variable region {
  description = "Management Console Region"
  type        = string
  default     = "eu"
}

variable location {
  description = "Azure Region"
  type        = string
  default     = "West Europe"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default = "subscription_id"
}

variable "client_id" {
  description = "Client ID"
  type        = string
  default = "client_id"
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
  default = "client_secret"
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default = "tenant_id"
}

variable "rg" {
  description = "Resource Group"
  type        = string
  default = "csc-proj-tcs-moni-poc-rg"
}

variable "lb_subnet" {
  description = "Subnet"
  type        = string
  default = "promdev"
}

variable "vnet" {
  description = "Virtual Network"
  type        = string
  default = "csc-proj-tcs-moni-poc-euwe-vnet"
}

variable cust_code {
  description = "Customer Code"
  type        = string
  default     = "TESTmon"
}

variable mysql_user {
  description = "MySQL User ID"
  type        = string
  default     = "mysqladmin"
}

data "azurerm_key_vault" "keyvault" {
  name                = "csc-proj-tcs-moni-poc-kv"
  resource_group_name = "csc-proj-tcs-moni-poc-rg"
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}

data "azurerm_key_vault_secret" "mysql_password" {
  name         = "vm-password"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}