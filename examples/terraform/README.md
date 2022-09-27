## Basic Terraform Example
```
module "pagerduty-service" {
    source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"

    // PagerDuty Service
    name              = "DevOps: My-Critical-Service"
    escalation_policy = "Escalation: DevOps Engineering"
    resolve_timeout   = 14400
    ack_timeout       = 600
    alert_creation    = "create_alerts_and_incidents"
    token             = file(./my_pagerduty_api_key.yaml)

    // SNS Topic
    prefix       = "my-prefix"
    service_name = "AcmeCorp-Elasticsearch"
}
```
## Complete Terraform Example w/Incident Urgency Rules & Slack Extension

```
module "pagerduty-service" {
    source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"

    // PagerDuty Service
    name              = "DevOps: My-Critical-Service"
    escalation_policy = "Escalation: DevOps Engineering"
    resolve_timeout   = 14400
    ack_timeout       = 600
    alert_creation    = "create_alerts_and_incidents"
    token             = file(./my_pagerduty_api_key.yaml)

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

    // SNS Topic
    prefix       = "my-prefix"
    service_name = "AcmeCorp-Elasticsearch"

  // Slack Extension
  create_slack_extension = true

  extension_name     = "DevOps: Slack"
  schema_webhook     = "Generic V1 Webhook"
  config = templatefile("${path.module}/slack/config.json.tpl", {
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
```
## Complete Terraform Example w/Scheduled Actions & Slack Extension

```
module "pagerduty-service" {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"

  // PagerDuty Service
  name              = "My Critical Service"
  description       = "Service for all prod services."
  escalation_policy = "My Escalation Policy Name"
  alert_creation    = "create_alerts_and_incidents"
  resolve_timeout   = 14400
  ack_timeout       = 600
  token             = file(./my_pagerduty_api_key.yaml)

  scheduled_actions = [{
    type       = "urgency_change"
    to_urgency = "high"
    at = [{
      type = "named_time"
      name = "support_hours_start"
    }]
  }]

  // SNS Topic
  prefix       = "my-prefix"
  service_name = "AcmeCorp-Elasticsearch"

  // Slack Extension
  create_slack_extension = true

  extension_name     = "DevOps: Slack"
  schema_webhook     = "Generic V1 Webhook"
  config = templatefile("${path.module}/slack/config.json.tpl", {
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
```
