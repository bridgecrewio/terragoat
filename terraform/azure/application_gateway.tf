resource "azurerm_application_gateway" "network" {
  name                = "example-appgateway"
  resource_group_name = "example-resourceGroup"
  location            = "example --West-US"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = "your subnet id"
  }

  frontend_port {
    name = "name"
    port = "port-no"
  }
####Missing WAF block: As per azure best practices, it is important to have a web application firewall enabled at application gateway.


  frontend_ip_configuration {
    name                 = "name"
    public_ip_address_id = "Ip-address"
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
