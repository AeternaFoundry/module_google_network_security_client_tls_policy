variable "network_security_client_tls_policies" {
  description = <<EOT
Map of network_security_client_tls_policies, attributes below
Required:
    - name
Optional:
    - deletion_policy
    - description
    - labels
    - location
    - project
    - sni
    - client_certificate (block):
        - certificate_provider_instance (optional, block):
            - plugin_instance (required)
        - grpc_endpoint (optional, block):
            - target_uri (required)
    - server_validation_ca (block):
        - certificate_provider_instance (optional, block):
            - plugin_instance (required)
        - grpc_endpoint (optional, block):
            - target_uri (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    name            = string
    deletion_policy = optional(string)
    description     = optional(string)
    labels          = optional(map(string))
    location        = optional(string)
    project         = optional(string)
    sni             = optional(string)
    client_certificate = optional(object({
      certificate_provider_instance = optional(object({
        plugin_instance = string
      }))
      grpc_endpoint = optional(object({
        target_uri = string
      }))
    }))
    server_validation_ca = optional(list(object({
      certificate_provider_instance = optional(object({
        plugin_instance = string
      }))
      grpc_endpoint = optional(object({
        target_uri = string
      }))
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
}

