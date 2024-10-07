locals {
  cert_name = length(split(",",var.domain_names)) == 0 ? replace(replace(var.domain_names,"*","wildcard"),".","-") : replace(replace(split(",",var.domain_names)[0],"*","wildcard"),".","-")

}

output "certificate_name" {
  value = var.test == true ? "${local.cert_name}-test" : local.cert_name
}