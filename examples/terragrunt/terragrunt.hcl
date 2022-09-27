locals {
  account     = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  pagerduty_key = yamldecode("${get_terragrunt_dir()}/pagerduty-api-key.yaml")
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"
}

inputs = {
  // PagerDuty Service
  name              = "DevOps: My-Critical-Service"
  escalation_policy = "Escalation: DevOps Engineering"
  resolve_timeout   = 14400
  ack_timeout       = 600
  alert_creation    = "create_alerts_and_incidents"
  token             = local.pagerduty_key.key

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

  // Scheduled Actions
  scheduled_actions = [{
    type       = "urgency_change"
    to_urgency = "high"
    at = [{
      type = "named_time"
      name = "support_hours_start"
    }]
  }]

  // Service Integration
  enable_service_integration = true
  vendor_name                = "CloudWatch"

  // SNS Topic
  create_sns_topic = true
  service_name     = "AcmeCorp-Elasticsearch"
  
  // PagerDuty Extension
  create_extension = true
  extension_name   = "DevOps: Slack"
  schema_name      = "Generic V1 Webhook" // Can use "Slack V2" or some other compatible Generic webhook.
  config = templatefile("${get_terragrunt_dir()}/slack/config.json.tpl", {
    app_id             = "A1AAAAAAA"
    authed_user        = "A11AAA11AAA"
    bot_user_id        = "A111AAAA11A"
    slack_team_id      = "AAAAAA11A"
    slack_team_name    = "AcmeCorp"
    slack_channel      = "#devops-pagerduty"
    slack_channel_id   = "A11AA1AAA1A"
    configuration_url  = "https://acme-corp.slack.com/services/A111AAAAAAAA"
    referer            = "https://acmecorp.pagerduty.com/services/A1AAAA1/integrations?service_profile=1"
    notify_resolve     = true
    notify_trigger     = true
    notify_escalate    = true
    notify_acknowledge = true
    notify_assignments = true
    notify_annotate    = true
    high_urgency       = true
    low_urgency        = true
  })
}