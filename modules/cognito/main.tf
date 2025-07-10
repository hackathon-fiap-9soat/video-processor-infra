resource "aws_cognito_user_pool" "main" {
  name = "video-processor-api-pool"
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "aws_cognito_user_pool_domain" "default_domain" {
  domain       = "video-processor-${random_string.suffix.result}"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_resource_server" "m2m_resource" {
  identifier = "default-m2m-resource-server-wtmeg5"
  name       = "M2M Resource Server"
  user_pool_id = aws_cognito_user_pool.main.id

  scope {
    scope_name        = "read"
    scope_description = "Read-only access to M2M protected resource"
  }
}

resource "aws_cognito_user_pool_client" "main" {
  name                                  = "video-processor-api-client"
  user_pool_id                          = aws_cognito_user_pool.main.id
  generate_secret                       = true
  allowed_oauth_flows_user_pool_client  = true
  allowed_oauth_flows                   = ["client_credentials"]
  allowed_oauth_scopes                = [
    "${aws_cognito_resource_server.m2m_resource.identifier}/read"
  ]
  supported_identity_providers         = ["COGNITO"]
}