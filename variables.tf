######################
# PagerDuty API Token
######################
variable "token" {
  type        = string
  description = "Pagerduty token"
}

#####################
# PagerDuty Service
#####################
variable "escalation_policy" {
  type        = string
  default     = null
  description = "(Required) The escalation policy used by this service."
}
variable "name" {
  type        = string
  default     = null
  description = "(Required) The name of the service."
}
variable "description" {
  type        = string
  default     = null
  description = "(Optional) A human-friendly description of the service. If not set, a placeholder of `Managed by Terraform` will be set."
}
variable "resolve_timeout" {
  type        = number
  default     = 14400
  description = "(Optional) Time in seconds that an incident is automatically resolved if left open for that long. Disabled if set to the `null` string."
}
variable "ack_timeout" {
  type        = number
  default     = 600
  description = "(Optional) Time in seconds that an incident changes to the Triggered State after being Acknowledged. Disabled if set to the `null` string. If not passed in, will default to `1800`."
}
variable "alert_creation" {
  type        = string
  default     = "create_alerts_and_incidents"
  description = "(Optional) Must be one of two values. PagerDuty receives events from your monitoring systems and can then create incidents in different ways. Value `create_incidents` is default: events will create an incident that cannot be merged. Value `create_alerts_and_incidents` is the alternative: events will create an alert and then add it to a new incident, these incidents can be merged. This option is recommended."
}
variable "incident_urgency_rule" {
  type = any
}
variable "support_hours" {
  type = set(object(
    {
      type         = string
      start_time   = string
      end_time     = string
      days_of_week = list(number)
      time_zone    = string
    }
  ))
  default = []
}
variable "scheduled_actions" {
  type = any
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
  type        = string
  default     = null
  description = "Default prefix for all PagerDuty subscribed SNS topics"
}

variable "service_name" {
  type        = string
  default     = null
  description = "Name of service to append to SNS topic prefix for all PagerDuty subscribed SNS topics"
}

#############################
# PagerDuty Slack Extension
#############################
variable "create_slack_extension" {
  description = "Decide to create the Slack integration or not."
  type        = bool
  default     = false
}
variable "extension_name" {
  description = "(Optional) The name of the service extension."
  type        = string
  default     = null
}
variable "schema_webhook" {
  type        = string
  default     = null
  description = "(Required|Optional) The url of the extension. Note: The endpoint URL is Optional API wise in most cases. But in some cases it is a Required parameter. For example, pagerduty_extension_schema named Generic V2 Webhook doesn't accept pagerduty_extension with no endpoint_url, but one with named Slack accepts."
}
variable "app_id" {
  type        = string
  default     = null
  description = "(Required) Id of the PagerDuty Slack app. (e.g. A1KKEUENN)"
}
variable "authed_user" {
  type        = string
  default     = null
  description = "Id of the auth user. This can be empty probably since auto authorizations for Slack are not working. (e.g. A11OKE11NNY)"
}
variable "bot_user_id" {
  type        = string
  default     = null
  description = "(Required) Id of the bot user from Slack. (e.g. A11OKE11NNY)"
}
variable "slack_channel" {
  type        = string
  default     = null
  description = "(Required) The name of the Slack channel (e.g. #devops-pagerduty)."
}
variable "slack_channel_id" {
  type        = string
  default     = null
  description = "(Required) The name of the Slack channel Id (e.g. ABC123XYZ456)."
}
variable "configuration_url" {
  type        = string
  default     = null
  description = "(Required) The URL of your slack space. (e.g. https://acme-corp.slack.com/services/A111AAAAAAAA)"
}
variable "endpoint_url" {
  type        = string
  default     = null
  description = "(Required) The url that the webhook payload will be sent to for this Extension. (e.g. https://hooks.slack.com/services/A1AAAA11A/A11AAAAAAAA/AaAAaAaAAaaAaAAaaAAAA1AA)"
}
variable "notify_resolve" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when status = resolved."
}
variable "notify_trigger" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when a trigger occurs."
}
variable "notify_escalate" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when an incident is escalated."
}
variable "notify_acknowledge" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when an incident is acknowledged."
}
variable "notify_assignments" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when an incident is assigned."
}
variable "notify_annotate" {
  type        = bool
  default     = "true"
  description = "(Required) Tells PagerDuty to notify Slack when an incident has been updated."
}
variable "referer" {
  type        = string
  default     = null
  description = "(Required) URL of the PagerDuty Slack integration. (e.g. https://acmecorp.pagerduty.com/services/A1AAAA1/integrations?service_profile=1)"
}
variable "slack_team_id" {
  type        = string
  default     = null
  description = "(Required) The Slack team Id (e.g. AB456XYZ)."
}
variable "slack_team_name" {
  type        = string
  default     = null
  description = "(Required) The Slack team name (e.g. ACMECORP)."
}
variable "high_urgency" {
  type        = bool
  default     = "true"
  description = "(Required) Alerts Slack on high urgency incidents."
}
variable "low_urgency" {
  type        = bool
  default     = "true"
  description = "(Required) Alerts Slack on low urgency incidents."
}
