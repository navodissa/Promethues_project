variable "prefix" {
  description = "Project Code or Name"
  type        = string
  default = "csc-mon"
}

variable env {
  description = "Environment where VMs will be provisioned"
  type        = string
  default     = "tst"
}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "entapp_client_id" {}
variable "entapp_client_secret" {}
variable "snow_reader_client_id" {}
variable "snow_reader_client_secret" {}

locals {
  subscription_id                = "subscription_id"
  allregion                      = "eu us"
  allvmsscomp                    = "cassandra:TESTsrvadmin cortex:TESTsrvadmin grafana:TESTsrvadmin"
  allvmcomp                      = "prometheus-1:TESTsrvadmin prometheus-2:TESTsrvadmin prometheus-3:TESTsrvadmin"
  allvmexp                       = "exporter-1:TESTsrvadmin exporter-2:TESTsrvadmin"
  allwinexp                      = "win-0:TESTsrvadmin win-1:TESTsrvadmin"
  rg                             = "rg"
  kv                             = "kv"
}

variable passwords {
  description = "Password variables in Keyvault"
  type        = map
  default     = {
    vm-cortex-TESTsrvadmin = "",
    vm-cassandra-TESTsrvadmin = "",
    vm-grafana-TESTsrvadmin = "",
    vm-prometheus-TESTsrvadmin = "",
    mysqladmin-password = ""
  }
}
