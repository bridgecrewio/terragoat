data azurerm_subscription current_subscription {}

resource "azurerm_role_definition" "example" {
  # checkov:skip=BC_AZR_IAM_2:mor test3
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.current_subscription.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["*"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current_subscription.id
  ]
}
