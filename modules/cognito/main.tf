resource "aws_cognito_user_pool" "main" {
  name = "video-processor-api-pool"
}

resource "aws_cognito_user_pool_client" "main" {
  name         = "video-processor-api-client"
  user_pool_id = aws_cognito_user_pool.main.id
  generate_secret = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["client_credentials"]
  allowed_oauth_scopes = ["video/process"]
}