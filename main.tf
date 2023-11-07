terraform {
  required_providers {
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "3.1.1"
    }
  }
}
provider "pagerduty" {
  token      = var.token
  user_token = var.pagerduty_user_token
}
data "pagerduty_escalation_policy" "this" {
  name = var.escalation_policy
}
resource "pagerduty_service" "this" {
  name                    = var.name
  description             = var.description
  auto_resolve_timeout    = var.resolve_timeout
  acknowledgement_timeout = var.ack_timeout
  escalation_policy       = data.pagerduty_escalation_policy.this.id
  alert_creation          = var.alert_creation
  dynamic "incident_urgency_rule" {
    for_each = var.incident_urgency_rule
    content {
      type    = incident_urgency_rule.value["type"]
      urgency = incident_urgency_rule.value["urgency"]
      dynamic "during_support_hours" {
        for_each = incident_urgency_rule.value.during_support_hours
        content {
          type    = during_support_hours.value["type"]
          urgency = during_support_hours.value["urgency"]
        }
      }
      dynamic "outside_support_hours" {
        for_each = incident_urgency_rule.value.outside_support_hours
        content {
          type    = outside_support_hours.value["type"]
          urgency = outside_support_hours.value["urgency"]
        }
      }
    }
  }
  dynamic "alert_grouping_parameters" {
    for_each = var.alert_grouping_parameters
    content {
      type = alert_grouping_parameters.value["type"]
      dynamic "config" {
        for_each = alert_grouping_parameters.value.config
        content {
          timeout   = each.value.timeout
          aggregate = each.value.aggregate
          fields    = each.value.fields
        }
      }
    }
  }
  dynamic "auto_pause_notifications_parameters" {
    for_each = var.auto_pause_notifications_parameters
    content {
      enabled = auto_pause_notifications_parameters.value["enabled"]
      timeout = auto_pause_notifications_parameters.value["timeout"]
    }
  }
  dynamic "support_hours" {
    for_each = var.support_hours
    content {
      type         = support_hours.value["type"]
      start_time   = support_hours.value["start_time"]
      end_time     = support_hours.value["end_time"]
      time_zone    = support_hours.value["time_zone"]
      days_of_week = support_hours.value["days_of_week"]
    }
  }
  dynamic "scheduled_actions" {
    for_each = var.scheduled_actions
    content {
      to_urgency = scheduled_actions.value["to_urgency"]
      type       = scheduled_actions.value["type"]
      dynamic "at" {
        for_each = scheduled_actions.value.at
        content {
          name = at.value["name"]
          type = at.value["type"]
        }
      }
    }
  }
}
data "pagerduty_vendor" "this" {
  name = var.vendor_name
}

resource "pagerduty_service_integration" "this" {
  count = var.enable_service_integration ? 1 : 0

  name    = data.pagerduty_vendor.this.name
  vendor  = data.pagerduty_vendor.this.id
  service = pagerduty_service.this.id
  # type    = (do not use for Datadog or Cloudwatch "vendor" integrations..only for generic service integrations)
}
resource "aws_sns_topic" "this" {
  count = var.create_sns_topic ? 1 : 0

  name = var.service_name
}
resource "aws_sns_topic_subscription" "this" {
  count = var.create_sns_topic ? 1 : 0

  topic_arn              = aws_sns_topic.this[0].arn
  protocol               = "https"
  endpoint_auto_confirms = true #required or the subscription won't auto-confirm
  endpoint               = "https://events.pagerduty.com/integration/${pagerduty_service_integration.this[0].integration_key}/enqueue"

}
data "pagerduty_extension_schema" "this" {
  count = var.create_extension ? 1 : 0

  name = var.schema_name
}
resource "pagerduty_extension" "this" {
  count = var.create_extension ? 1 : 0

  name              = var.extension_name
  endpoint_url      = var.endpoint_url
  extension_schema  = data.pagerduty_extension_schema.this[count.index].id
  extension_objects = [pagerduty_service.this.id]
  config            = var.config
}

resource "pagerduty_maintenance_window" "this" {
  for_each = {
    for k, v in var.maintenance_windows : k => v if var.enable_maintenance_windows == true
  }
  start_time  = each.value.start_time
  end_time    = each.value.end_time
  description = each.value.description
  services    = [pagerduty_service.this.id]
}

resource "pagerduty_slack_connection" "this" {
  for_each = {
    for type in var.slack_connections : type.source_type => {
      source_id         = type.source_type == "service_reference" ? pagerduty_service.this.id : type.source_id
      source_type       = type.source_type
      workspace_id      = type.workspace_id
      channel_id        = type.channel_id
      notification_type = type.notification_type
      config            = type.config
    }
    if var.create_slack_connection == true
  }
  source_id         = each.value.source_id
  source_type       = each.value.source_type
  workspace_id      = each.value.workspace_id
  channel_id        = each.value.channel_id
  notification_type = each.value.notification_type
  dynamic "config" {
    for_each = each.value.config
    content {
      events     = config.value.events
      priorities = config.value.priorities
      urgency    = config.value.urgency
    }
  }
}

data "pagerduty_vendor" "datadog" {
  count = var.enable_datadog_integration ? 1 : 0

  name = "Datadog"
}

resource "pagerduty_service_integration" "datadog" {
  count = var.enable_datadog_integration ? 1 : 0

  name    = data.pagerduty_vendor.datadog.name
  service = pagerduty_service.this.id
  vendor  = data.pagerduty_vendor.datadog.id
}
