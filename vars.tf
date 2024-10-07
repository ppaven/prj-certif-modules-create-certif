variable  domain_names {}
variable  dns_subscription {}
variable  dns_resource_group {} 
variable  dns_zone {}
variable  subscription {}
variable  resource_group {}
variable  resource_type {}
variable  resources {}
variable  endpoint_listener {
    default = ""
}
variable  keyvault {
    default = ""
}
variable  test {
    default = false
}

variable aaa_subs_id {
}
variable aaa_rgp {
}
variable aaa_name {
}
variable runbook_name {
  default = "CreateCert-LetsEncrypt"
}
