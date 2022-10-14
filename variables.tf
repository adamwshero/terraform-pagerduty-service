######################
# PagerDuty API Token
######################
variable "token" {
  type        = string
  description = "The account-level token needed to create PagerDuty Services."
}

variable "pagerduty_user_token" {
  description = "User-level token needed to create Slack connections."
  type        = string
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
  type    = any
  default = []
}
variable "support_hours" {
  type    = any
  default = []
}
variable "scheduled_actions" {
  type    = any
  default = []
}

#################################
# PagerDuty Service Integration
#################################
variable "enable_service_integration" {
  description = "Decide to create a service integration or not (e.g. `Cloudwatch`, `DataDog`)"
  type        = bool
  default     = false
}
variable "vendor_name" {
  description = "(Required) The vendor name to use to find a vendor in the PagerDuty API."
  type        = string
  default     = null
}
variable "type" {
  type        = string
  default     = "aws_cloudwatch_inbound_integration"
  description = "Tells PagerDuty what type of integration this is."
}

#############################
# AWS SNS Topic
#############################
variable "create_sns_topic" {
  description = "Decide if we want to use SNS for message delivery to our tool of choice (e.g. CloudWatch/DataDog)"
  type        = bool
  default     = false
}
variable "service_name" {
  type        = string
  default     = null
  description = "Name of service to append to SNS topic prefix for all PagerDuty subscribed SNS topics"
}

################################
# PagerDuty Maintenance Windows
################################
variable "enable_maintenance_windows" {
  description = "Decide to create maintenance window(s) for this service."
  type        = bool
  default     = false
}
variable "maintenance_windows" {
  description = "value"
  type        = any
  default     = []
}

#############################
# PagerDuty Extension Schema
#############################
variable "schema_name" {
  type        = string
  default     = null
  description = "(Required) The extension name to use to find an extension vendor in the PagerDuty API."
}

######################
# PagerDuty Extension
######################
variable "create_extension" {
  description = "Decide to create a PagerDuty extension or not."
  type        = bool
  default     = false
}
variable "extension_name" {
  description = "(Optional) The name of the service extension."
  type        = string
  default     = null
}
variable "config" {
  description = "(Optional) The configuration of the service extension as string containing plain JSON-encoded data."
  type        = string
  default     = null
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
  description = "(Required|Optional) The url of the extension. Note: The endpoint URL is Optional API wise in most cases. But in some cases it is a Required parameter. For example, pagerduty_extension_schema named Generic V2 Webhook doesn't accept pagerduty_extension with no endpoint_url, but one with named Slack accepts. (e.g. https://hooks.slack.com/services/A1AAAA11A/A11AAAAAAAA/AaAAaAaAAaaAaAAaaAAAA1AA)"
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

#############################
# PagerDuty Slack Connection
#############################
variable "create_slack_connection" {
  description = "Decide to create the Slack connection or not."
  type        = bool
  default     = false
}

variable "slack_connection" {
  description = "value"
  type        = any
}
variable "source_id" {
  description = "(Required) The ID of the source in PagerDuty. Valid sources are `service` or `team` ids."
  type        = string
}

variable "source_type" {
  description = "(Required) The type of the source. Either `team_reference` or `service_reference`."
  type        = string
  default     = null
}

variable "workspace_id" {
  description = "(Required) The ID of the connected Slack workspace. Can also be defined by the `SLACK_CONNECTION_WORKSPACE_ID` environment variable."
  type        = string
  default     = null
}

variable "channel_id" {
  description = "(Required) The ID of a Slack channel in the workspace."
  type        = string
  default     = null
}

variable "notification_type" {
  description = "(Required) Type of notification. Either `responder` or `stakeholder`."
  type        = string
  default     = null
}
variable "events" {
  description = "(Required) A list of strings to filter events by PagerDuty event type. `incident.triggered` is required. The follow event types are also possible:."
  type        = any
}

variable "priorities" {
  description = "(Optional) Allows you to filter events by priority. Needs to be an array of PagerDuty priority IDs. Available through pagerduty_priority data source. When omitted or set to an empty array (`[]`) in the configuration for a Slack Connection, its default behaviour is to set `priorities` to `No Priority` value. When set to `['*']` its corresponding value for `priorities` in Slack Connection's configuration will be `Any Priority`."
  type        = list(string)
  default     = []
}

variable "urgency" {
  description = "(Optional) Allows you to filter events by urgency. Either high or low."
  type        = string
  default     = null

}
