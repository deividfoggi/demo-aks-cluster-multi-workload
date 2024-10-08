// create the API Management service
resource "azurerm_api_management" "apim" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  location             = var.location
  sku_name             = var.sku_name
  publisher_name       = var.publisher_name
  publisher_email      = var.publisher_email
  virtual_network_type = var.virtual_network_type
  virtual_network_configuration {
    subnet_id = var.subnet_id
  }

  identity {
    type = var.identity_type
  }
}

// create a api management logger
resource "azurerm_api_management_logger" "apim_logger" {
  name                = "${var.name}-apim-logger"
  resource_group_name = var.resource_group_name
  api_management_name = var.name
  
  application_insights {
    instrumentation_key = var.applicationinsights_instrumentation_key
  }

  depends_on = [ 
    azurerm_api_management.apim
  ]

}

// create the api management diagnostic
resource "azurerm_api_management_diagnostic" "apim_diagnostic" {
  identifier               = "applicationinsights"
  resource_group_name      = var.resource_group_name
  api_management_name      = var.name
  api_management_logger_id = azurerm_api_management_logger.apim_logger.id
  
   sampling_percentage       = 100
   always_log_errors         = true
   log_client_ip             = true
   verbosity                 = "verbose"
   http_correlation_protocol = "W3C" 

   frontend_request {
     body_bytes = 32
     headers_to_log = [
       "content-type",
       "accept",
       "origin",
     ]
   }

   frontend_response {
     body_bytes = 32
     headers_to_log = [
       "content-type",
       "accept",
       "origin"
     ]
   }

   backend_request {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "accept",
        "origin"
      ]
   }

   backend_response {
      body_bytes = 32
      headers_to_log = [
        "content-type",
        "accept",
        "origin"
      ]
   }

  depends_on = [ 
    azurerm_api_management.apim,
    azurerm_api_management_logger.apim_logger
  ]
}