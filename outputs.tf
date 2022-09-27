output "pagerduty_service_name" {
  description = "The name of the PagerDuty service."
  value       = pagerduty_service.this.name
}
output "pagerduty_service_id" {
  description = "Id of PagerDuty Service."
  value       = pagerduty_service.this.id
}
output "pagerduty_service_url" {
  description = "The URL of the PagerDuty service."
  value       = pagerduty_service.this.html_url
}
output "pagerduty_service_topic" {
  description = "The name of the SNS topic that you can send CloudWatch alarms to."
  value       = aws_sns_topic.this.name
}
output "pagerduty_service_topic_arn" {
  description = "The Arn of the SNS topic that you can send CloudWatch alarms to."
  value       = aws_sns_topic.this.arn
}
output "slack_extension_id" {
  description = "The Id of the Slack extension."
  value = pagerduty_extension.this[*].id
}
output "slack_extension_url" {
  description = "URL at which the entity is uniquely displayed in the Web app."
  value = pagerduty_extension.this[*].html_url
}
output "pagerduty_service_integration_id" {
  description = "Id of the integration with PagerDuty."
  value       = var.enable_service_integration ? pagerduty_service_integration.this[0].id : "[INFO] Service Integration Not Enabled."
}
output "pagerduty_service_integration_key" {
  description = "Key of the integration with PagerDuty."
  value       = var.enable_service_integration ? pagerduty_service_integration.this[0].integration_key : "[INFO] Service Integration Not Enabled."
}
output "subscription_url" {
  description = "Subscription URL for SNS."
  value       = var.create_sns_topic ? aws_sns_topic_subscription.this.endpoint : "[INFO] SNS Topic Not Created."
}