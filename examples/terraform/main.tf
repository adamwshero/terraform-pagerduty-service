module "pagerduty-service" {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"

  // PagerDuty Service
  name              = "My Critical Service"
  description       = "Service for all prod services."
  escalation_policy = "My Escalation Policy Name"
  alert_creation    = "create_alerts_and_incidents"
  resolve_timeout   = 14400
  ack_timeout       = 600
  token             = local.token
  user_token        = local.user_token
  datadog_api_key   = local.datadog_api_key
  datadog_app_key   = local.datadog_app_key

  alert_grouping_parameters = [{
    type   = "intelligent"
    config = {}
  }]

  // Maintenance Windows
  enable_maintenance_windows = true
  maintenance_windows = [
    {
      description = "Overnight Maintenance"
      start_time  = "2022-11-09T20:00:00-05:00"
      end_time    = "2022-11-09T22:00:00-05:00"
    },
    {
      description = "Weekend Maintenance"
      start_time  = "2022-12-09T20:00:00-05:00"
      end_time    = "2022-12-09T22:00:00-05:00"
    }
  ]

  // Incident Urgency Rules
  incident_urgency_rule = [{
    type    = "constant"
    urgency = "low"

    during_support_hours = [{
      type    = "constant"
      urgency = "high"
    }]
    outside_support_hours = [{
      type    = "constant"
      urgency = "low"
    }]
  }]

  // Auto-Pause Notifications
  auto_pause_notifications_parameters = [{
    enabled = true
    timeout = 300
  }]

  // Support Hours
  support_hours = [
    {
      type         = "fixed_time_per_day"
      time_zone    = "America/Lima"
      days_of_week = [1, 2, 3, 4, 5]
      start_time   = "05:00:00"
      end_time     = "16:00:00"
    }
  ]

  // Service Integration
  enable_service_integration = true
  vendor_name                = "CloudWatch"

  // SNS Topic
  create_sns_topic = true
  service_name     = "AcmeCorp-Elasticsearch"

  // PagerDuty Extension
  create_extension = true
  extension_name   = "My_V3_Extension"
  schema_webhook   = "V3 Webhook"
  config = templatefile("${path.module}/extension/config.json.tpl", {
    my_var1 = value1
    my_var2 = value2
  })

  // Slack Connection
  create_slack_connection = true
  pagerduty_user_token    = local.pagerduty_key.user_token
  events                  = ["incident.triggered"]
  slack_connections = [
    {
      source_type       = "service_reference"
      workspace_id      = "A04AA6A27"
      channel_id        = "A042A0AAAA2"
      notification_type = "responder"
      config = [{
        priorities = ["*"]
        urgency    = "low"
        events = [
          "incident.triggered",
          "incident.acknowledged",
          "incident.escalated",
          "incident.resolved",
          "incident.reassigned",
          "incident.annotated",
          "incident.unacknowledged",
          "incident.delegated",
          "incident.priority_updated",
          "incident.responder.added",
          "incident.responder.replied",
          "incident.status_update_published",
          "incident.reopened"
        ]
      }]
    },
    {
      source_id         = "AA1A6AA"
      source_type       = "team_reference"
      workspace_id      = "A04AA6A27"
      channel_id        = "A042A0AAAA2"
      notification_type = "responder"
      config = [{
        priorities = ["*"]
        urgency    = "low"
        events = [
          "incident.triggered",
          "incident.acknowledged",
          "incident.escalated",
          "incident.resolved",
          "incident.reassigned",
          "incident.annotated",
          "incident.unacknowledged",
          "incident.delegated",
          "incident.priority_updated",
          "incident.responder.added",
          "incident.responder.replied",
          "incident.status_update_published",
          "incident.reopened"
        ]
      }]
    }
  ]
}
