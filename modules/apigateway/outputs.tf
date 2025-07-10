output "api_gateway_url" {
  value = aws_apigatewayv2_api.api.api_endpoint
}

output "api_authorizer_id" {
  value = aws_apigatewayv2_authorizer.jwt.id
}