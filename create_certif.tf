
# resource "random_string" "token1" {
#   length  = 10
#   upper   = true
#   lower   = true
#   number  = true
#   special = false
# }

# resource "random_string" "token2" {
#   length  = 31
#   upper   = true
#   lower   = true
#   number  = true
#   special = false
# }

resource "random_string" "suffix" {
  length  = 5
  upper   = true
  lower   = true
  numeric = true
  special = false
}

locals {
  # webhook_uri = "https://s2events.azure-automation.net/webhooks?token=%2b${random_string.token1.result}%2b${random_string.token2.result}%3d"
  webhook_name = "${var.aaa_name}_wh_${random_string.suffix.result}"
  expiry_time = timeadd(timestamp(),"24h")

}


####
# Creation du Webhook

resource "azurerm_automation_webhook" "webhook_createcert" {
  name                    = local.webhook_name
  resource_group_name     = var.aaa_rgp
  automation_account_name = var.aaa_name
  expiry_time             = local.expiry_time
  enabled                 = true
  runbook_name            = var.runbook_name
  # uri                     = local.webhook_uri

  parameters = {
    DomainNames         = var.domain_names
    DNSSubscriptionName = var.dns_subscription
    DNSResourceGroup    = var.dns_resource_group
    DNSzone             = var.dns_zone
    SubscriptionName    = var.subscription
    ResourceGroupName   = var.resource_group
    ResourceType        = var.resource_type
    Resources           = var.resources
    EndPoint_Listener   = var.endpoint_listener
    KeyVault            = var.keyvault
    Test                = var.test
  }

  lifecycle {ignore_changes = [expiry_time]}
}

####
# Appel du Webhook
resource "null_resource" "exec_webhook" {
  provisioner "local-exec" {
    command = "curl -X POST ${azurerm_automation_webhook.webhook_createcert.uri} --header \"content-type: application/json\" -d \"\" && sleep 30"
  }

  depends_on = [azurerm_automation_webhook.webhook_createcert]
}

