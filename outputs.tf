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
output "pagerduty_service_integration_id" {
  description = "Id of the integration with PagerDuty."
  value       = var.enable_service_integration ? pagerduty_service_integration.this[0].id : "[INFO] Service Integration Not Enabled."
}
output "pagerduty_service_integration_key" {
  description = "Key of the integration with PagerDuty."
  value       = var.enable_service_integration ? pagerduty_service_integration.this[0].integration_key : "[INFO] Service Integration Not Enabled."
}
output "sns_service_topic" {
  description = "The name of the SNS topic that you can send CloudWatch alarms to."
  value       = aws_sns_topic.this[0].name
}
output "sns_topic_arn" {
  description = "The Arn of the SNS topic that you can send CloudWatch alarms to."
  value       = aws_sns_topic.this[0].arn
}
output "sns_subscription_url" {
  description = "Subscription URL for SNS."
  value       = var.create_sns_topic ? aws_sns_topic_subscription.this[0].endpoint : "[INFO] SNS Topic Skipped."
}
output "slack_extension_id" {
  description = "The Id of the Slack extension."
  value       = pagerduty_extension.this[*].id
}
output "slack_extension_url" {
  description = "URL at which the entity is uniquely displayed in the Web app."
  value       = pagerduty_extension.this[*].html_url
}
output "slack_connection_id" {
  description = "The ID of the slack connection."
  value       = var.create_slack_connection ? pagerduty_slack_connection.this[0].id : "[INFO] Slack Connection Skipped."
}
output "slack_connection_source_name" {
  description = "Name of the source (team or service) in Slack connection."
  value       = var.create_slack_connection ? pagerduty_slack_connection.this[0].source_name : "[INFO] Slack Connection Skipped."
}
output "slack_connection_channel_name" {
  description = "Name of the Slack channel in Slack connection."
  value       = var.create_slack_connection ? pagerduty_slack_connection.this[0].channel_name : "[INFO] Slack Connection Skipped."
}
output "maintenance_windows" {
  description = "Map of currently scheduled maintenance windows."
  value       = var.enable_maintenance_windows ? var.maintenance_windows : "[INFO] No Maintenance Windows Scheduled."
}
