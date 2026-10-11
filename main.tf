resource "google_network_security_client_tls_policy" "network_security_client_tls_policies" {
  for_each = var.network_security_client_tls_policies

  name            = each.value.name
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  labels          = each.value.labels
  location        = each.value.location
  project         = each.value.project
  sni             = each.value.sni

  dynamic "client_certificate" {
    for_each = each.value.client_certificate != null ? [each.value.client_certificate] : []
    content {
      dynamic "certificate_provider_instance" {
        for_each = client_certificate.value.certificate_provider_instance != null ? [client_certificate.value.certificate_provider_instance] : []
        content {
          plugin_instance = certificate_provider_instance.value.plugin_instance
        }
      }
      dynamic "grpc_endpoint" {
        for_each = client_certificate.value.grpc_endpoint != null ? [client_certificate.value.grpc_endpoint] : []
        content {
          target_uri = grpc_endpoint.value.target_uri
        }
      }
    }
  }

  dynamic "server_validation_ca" {
    for_each = each.value.server_validation_ca != null ? each.value.server_validation_ca : []
    content {
      dynamic "certificate_provider_instance" {
        for_each = server_validation_ca.value.certificate_provider_instance != null ? [server_validation_ca.value.certificate_provider_instance] : []
        content {
          plugin_instance = certificate_provider_instance.value.plugin_instance
        }
      }
      dynamic "grpc_endpoint" {
        for_each = server_validation_ca.value.grpc_endpoint != null ? [server_validation_ca.value.grpc_endpoint] : []
        content {
          target_uri = grpc_endpoint.value.target_uri
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

