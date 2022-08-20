# Common Variables
variable "resource_group" {
  description = "target resource group resource mask"
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = "deb-test-devops"
    location = "eastus"
  }
}

variable "storage_account" {
  description = "The storage account associated with the web-app"
  type = object({
    name    = string
    rg_name = string
  })

  default = null
}

variable "application_insights" {
    description = "The Application Insights associated with the function app"
    type = object ({
        name = string
        rg_name = string
    })
    default = null
}

variable "service_plan" {
  description = "The Service Plan associated with the web-app"
  type = object({
    name    = string
    rg_name = string
  })
}

variable "container_registry" {
  description = "The Container Registry associated with the web-app. Required only when application_stack = docker"
  type = object({
    name    = string
    rg_name = string
  })

  default = {
    name    = ""
    rg_name = ""
  }
}

variable "web_app_name" {
  description = "Name of the linux web-app"
  type        = string
}

variable "enabled" {
  description = "Switch to enable linux web-app. Default is true"
  type        = bool
  default     = true
}

variable "https_only" {
  description = "Switch for the flag https_only. Default is false"
  type        = bool
  default     = false
}

variable "storage_mounts" {
  description = "A map of storage mounts for the web-app. The account_name and access_key will be fetched from the storage_account variable. The share_name is either a blob or a fileshare in the storage_account. The mount_type can be either AzureFiles or AzureBlob"
  type = map(object({
    share_name = string
    mount_type = string
    mount_path = string
  }))
  default = {}
}

variable "application_stack" {
  description = "One of these options - docker, dotnet, java, node, python, php, ruby"
  default     = "docker"
  validation {
    condition     = contains(["docker", "dotnet", "java", "node", "python", "ruby", "php"], lower(var.application_stack))
    error_message = "The application_stack can take one of these values - docker, dotnet, java, node, python, php, ruby."
  }
}

variable "docker_image_name" {
  description = "The docker image name. Required only when application_stack = docker"
  default     = "sample-app"
}

variable "docker_image_tag" {
  description = "The docker image tag. Required only when application_stack = docker"
  default     = "1001"
}

variable "dotnet_version" {
  default     = null
  description = "Dotnet version for web-app runtime. Required only when application_stack = dotnet. Must be 3.1 or 5.0 or 6.0"
}

variable "java_version" {
  default     = null
  description = "Java version for web-app runtime. Required only when application_stack = java"
  type        = string
}

variable "java_server" {
  default     = null
  description = "Java Server for web-app runtime. Required only when application_stack = java. Use command 'az webapp list-runtimes --os-type=linux' for more details"
}

variable "java_server_version" {
  default     = null
  description = "Java server version for web-app runtime. Required only when application_stack = java. Use command 'az webapp list-runtimes --os-type=linux' for more details"
  type        = string
}

variable "node_version" {
  default     = null
  description = "Node version for web-app runtime. Required only when application_stack = node. Possible values are 12-lts, 14-lts, 16-lts"
  type        = string
}

variable "python_version" {
  default     = null
  description = "Python version for web-app runtime. Required only when application_stack = python. Possible values are 3.7, 3.8, 3.9."
  type        = string
}

variable "ruby_version" {
  default     = null
  description = "Ruby version for web-app runtime. Required only when application_stack = ruby. Possible values are 2.6 or 2.7."
  type        = string
}

variable "php_version" {
  default     = null
  description = "Php version for the web-app runtime. Required only when application_stack = php. Possible values are 7.4 or 8.0."
  type        = string
}

variable "site_config" {
  description = "All the site config mentioned in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app#site_config except application_stack"
  type        = any
  default     = {}
}

variable "application_settings" {
  description = "The environment variables passed in to the web-app"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "List of connection strings (name, type, value)"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "cors" {
  description = "CORS block (allowed_origins, support_credentials)"
  type = object({
    allowed_origins     = list(string)
    support_credentials = bool
  })
  default = null
}

# Variables related to the logs

variable "detailed_error_messages" {
  description = "Should detailed error messages be enabled?"
  type = bool
  default = false
}

variable "failed_request_tracing" {
  description = "Should failed request tracing be enabled?"
  type = bool
  default = false
}

variable "http_logs_file_system" {
  description = "HTTP Logs properties for type filesystem"
  type = object({
    retention_in_days = number
    retention_in_mb   = number
  })
  default = null
}

variable "http_logs_azure_blob_storage" {
  description = "HTTP Logs properties type for Azure Blob Storage"
  type = object({
    level             = string
    retention_in_days = string
    sas_url           = string
  })
  default = null
}

variable "enable_system_managed_identity" {
  description = "Should system_managed_identity be enabled"
  type = bool
  default = false
}

variable "enable_application_insights" {
  description = "Should app Insights be enabled for the web-app? If enabled, application_insights is required variable."
  type = bool
  default = false
}

variable "custom_tags" {
  description = "Custom Tags"
  type        = map(string)
  default     = {}
}
