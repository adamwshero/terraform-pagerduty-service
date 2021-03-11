#####################
# PagerDuty Service
#####################

variable "escalation_policy" {
  type = string
  default = ""
  description = "Escalation policy for which the PagerDuty service needs to be attached to."
}
variable "name" {
  type        = string
  default     = "DevOps: Test Service"
  description = "This is the display name of the PagerDuty service."
}
variable "resolve_timeout" {
  type        = number
  default     = 14400
  description = "The threshold an incident announcement is made if not yet resolved."
}
variable "ack_timeout" {
  type        = number
  default     = 600
  description = "The threshold an incident announcement is made if not yet accepted."
}

variable "alert_creation" {
  type        = string
  default     = "create_alerts_and_incidents"
  description = "Tells PagerDuty to create both alerts for the alarm and an incident."
}
variable "alert_grouping" {
  type        = string
  default     = "intelligent"
  description = "Tells PagerDuty how to group similar incidents, if at all."
}
variable "alert_grouping_timeout" {
  type        = number
  default     = 0
  description = "Tells PagerDuty how long to continue grouping incidents."
}

#################################
# PagerDuty Service Integration
#################################

variable "type" {
  type        = string
  default     = "aws_cloudwatch_inbound_integration"
  description = "Tells PagerDuty what type of integration this is."
}

#############################
# AWS SNS Topic
#############################

variable "prefix" {
  type = string
  default = "PagerDuty-DevOps"
  description = "Default prefix for all PagerDuty subscribed SNS topics"
}

variable "service_name" {
  type = string
  default = ""
  description = "Name of service to append to SNS topic prefix for all PagerDuty subscribed SNS topics"
}

#############################
# PagerDuty Slack Extension
#############################
variable "app_id" {
  type        = string
  default     = "##TODO##"
  description = "TODO"
}
variable "authed_user" {
  type        = string
  default     = "##TODO##"
  description = "TODO"
}
variable "bot_user_id" {
  type    = string
  default = "##TODO##"
  description = "##TODO##"
}
variable "slack_channel" {
  type        = string
  default     = ""
  description = "The name of the Slack channel (e.g. #devops-pagerduty)."
}
variable "slack_channel_id" {
  type        = string
  default     = ""
  description = "The name of the Slack channel Id (e.g. ABC123XYZ456)."
}
variable "configuration_url" {
  type        = string
  default     = "https://##TODO##.slack.com/services/##TODO##"
  description = "TODO"
}
variable "url" {
  type        = string
  default     = "https://hooks.slack.com/services/##TODO##/##TODO##/##TODO##"
  description = "Used to establish a webhook."
}
variable "notify_resolve" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when status = resolved."
}
variable "notify_trigger" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when a trigger occurs."
}
variable "notify_escalate" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when an incident is escalated."
}
variable "notify_acknowledge" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when an incident is acknowledged."
}
variable "notify_assignments" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when an incident is assigned."
}
variable "notify_annotate" {
  type        = bool
  default     = "true"
  description = "Tells PagerDuty to notify Slack when an incident has been updated."
}
variable "referer" {
  type = string
  default = "https://##TODO##.pagerduty.com/services/##TODO##/integrations?service_profile=1"
}
variable "slack_team_id" {
  type        = string
  default     = "##TODO##"
  description = "The Slack team Id (e.g. AB456XYZ)."
}
variable "slack_team_name" {
  type        = string
  default     = "##TODO##"
  description = "The Slack team name (e.g. MYCOMPANY)."
}
variable "high_urgency" {
  type        = bool
  default     = "true"
  description = "Alerts Slack on high urgency incidents."
}
variable "low_urgency" {
  type        = bool
  default     = "true"
  description = "Alerts Slack on low urgency incidents."
}

