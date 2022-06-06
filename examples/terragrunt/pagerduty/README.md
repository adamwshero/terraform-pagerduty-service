# Complete Plan Example

```
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
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.0.10"
}

inputs = {
  ### PagerDuty Inputs
  name              = "DevOps: My-Critical-Service"
  escalation_policy = "Escalation: DevOps Engineering"
  resolve_timeout   = 14400
  ack_timeout       = 600
  alert_creation    = "create_alerts_and_incidents"
  token             = local.pagerduty_key.key

    incident_urgency_rule = [{
      type    = "use_support_hours"
      urgency = ""

      during_support_hours = [{
        type    = "constant"
        urgency = "high"
      }]

      outside_support_hours = [{
        type    = "constant"
        urgency = "low"
      }]
    }]

    support_hours = [{
      type         = "fixed_time_per_day"
      start_time   = "09:00:00"
      end_time     = "17:00:00"
      time_zone    = "America/Denver"
      days_of_week = [1, 2, 3, 4, 5]
    }]

    scheduled_actions = [{
      type       = "urgency_change"
      to_urgency = "high"
      at = [{
        type = "named_time"
        name = "support_hours_start"
      }]
    }]

  ### AWS SNS Topic Inputs
  prefix       = "my-prefix"
  service_name = "AcmeCorp-Elasticsearch"

  ### Slack Extension Inputs
  schema_webhook     = "Slack V2"
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
}
```