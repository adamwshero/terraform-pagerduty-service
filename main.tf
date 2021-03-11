#######################
##  PagerDuty Service
#######################

data "pagerduty_escalation_policy" "pd_escalation" {
  name = "${var.escalation_policy}"
}

resource "pagerduty_service" "pd_service" {
  name                    = var.name
  auto_resolve_timeout    = var.resolve_timeout
  acknowledgement_timeout = var.ack_timeout
  escalation_policy       = data.pagerduty_escalation_policy.pd_escalation.id
  alert_creation          = var.alert_creation
  alert_grouping          = var.alert_grouping
  alert_grouping_timeout  = var.alert_grouping_timeout
}

######################################
##  PagerDuty CloudWatch Integration
######################################

data "pagerduty_vendor" "cloudwatch" {
  name = "CloudWatch"
}

resource "pagerduty_service_integration" "cloudwatch" {
  name    = data.pagerduty_vendor.cloudwatch.name
  service = pagerduty_service.pd_service.id
  vendor  = data.pagerduty_vendor.cloudwatch.id
  # type    = (do not use for Datadog or Cloudwatch "vendor" integrations..only for generic service integrations)
}

#############################
##  SNS Topic For PagerDuty
#############################

resource "aws_sns_topic" "pd_topic" {
  name = "${var.prefix}-${var.service_name}"
}

######################################
##  SNS/PagerDuty Topic Subscription
######################################

resource "aws_sns_topic_subscription" "pd-topic-subscription" {
  topic_arn              = aws_sns_topic.pd_topic.arn
  protocol               = "https"
  endpoint_auto_confirms = true  #required or the subscription won't auto-confirm
  endpoint               = "https://events.pagerduty.com/integration/${pagerduty_service_integration.cloudwatch.integration_key}/enqueue"

}

###############################
##  PagerDuty Slack Extension
###############################

data "pagerduty_extension_schema" "webhook" {
  name = "Slack V2"
}

resource "pagerduty_extension" "slack" {
  name              = "DevOps: Slack"
  extension_schema  = data.pagerduty_extension_schema.webhook.id
  extension_objects = [pagerduty_service.pd_service.id]

  config = <<EOF
  {
      "app_id": "${var.app_id}",
      "authed_user": {
        "id": "${var.authed_user}"
      },
      "bot_user_id": "${var.bot_user_id}",
      "enterprise": "null",
      "incoming_webhook": {
        "channel": "${var.slack_channel}",
        "channel_id": "${var.slack_channel_id}",
        "configuration_url": "${var.configuration_url}",
        "url": "${var.url}"
      },
      "restrict": "any",
      "is_enterprise_install": "false",
      "notify_types": {
        "resolve": "${var.notify_resolve}",
        "trigger": "${var.notify_trigger}",
        "escalate": "${var.notify_escalate}",
        "acknowledge": "${var.notify_acknowledge}",
        "assignments": "${var.notify_assignments}",
        "annotate": "${var.notify_annotate}"
      },
      "ok": true,
      "referer": "${var.referer}",
      "scope": "app_mentions:read,channels:join,channels:manage,channels:read,chat:write,chat:write.public,commands,groups:read,groups:write,im:read,im:write,incoming-webhook,pins:write,team:read,users:read,workflow.steps:execute",
      "team": {
        "id": "${var.slack_team_id}",
        "name": "${var.slack_team_name}"
      },
      "token_type": "bot",
      "urgency": {
        "high": "${var.high_urgency}",
        "low": "${var.low_urgency}"
      }
    }
EOF

}
