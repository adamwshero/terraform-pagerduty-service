output "PagerDuty_Service_Name" {
  value = pagerduty_service.this.name
}
output "AWS_SNS_Topic" {
  value = aws_sns_topic.this.name
}
