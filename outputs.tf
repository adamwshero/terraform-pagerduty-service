output "PagerDuty_Service_Name" {
  description = "The name of the PagerDuty service."
  value       = pagerduty_service.this.name
}
output "AWS_SNS_Topic" {
  description = "The name of the SNS topic that you can send CloudWatch alarms to."
  value       = aws_sns_topic.this.name
}
