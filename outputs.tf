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
  value       = var.create_sns_topic ? aws_sns_topic.this[0].name : "[INFO] SNS Topic Skipped."
}
output "sns_topic_arn" {
  description = "The Arn of the SNS topic that you can send CloudWatch alarms to."
  value       = var.create_sns_topic ? aws_sns_topic.this[0].arn : "[INFO] SNS Topic Skipped."
}
output "sns_subscription_url" {
  description = "Subscription URL for SNS."
  value       = var.create_sns_topic ? aws_sns_topic_subscription.this[0].endpoint : "[INFO] SNS Topic Skipped."
}
output "extension_id" {
  description = "The Id of the extension."
  value       = var.create_extension ? pagerduty_extension.this[*].id : "[INFO] PagerDuty Extension Skipped."
}
output "extension_url" {
  description = "URL at which the entity is uniquely displayed in the Web app."
  value       = var.create_extension ? pagerduty_extension.this[*].html_url : "[INFO] PagerDuty Extension Skipped."
}

output "slack_connections" {
  description = "Map of Slack connections."
  value = tomap({
    for k, slack_connection in pagerduty_slack_connection.this : k => {
      id           = slack_connection.id
      source_type  = slack_connection.source_type
      channel_name = slack_connection.channel_name
    }
  })
}

output "maintenance_windows_in_effect" {
  description = "Map of maintenance windows scheduled."
  value = tomap({
    for k, windows in pagerduty_maintenance_window.this : k => {
      start_time  = windows.start_time
      end_time    = windows.end_time
      description = windows.description
    }
  })
}
