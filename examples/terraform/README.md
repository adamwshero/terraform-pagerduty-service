## Basic Terraform Example
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
  token             = file("${path.module}/my_pagerduty_api_key.yaml")
```
## Terraform Example w/CloudWatch & SNS Integration
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
  token             = file("${path.module}/my_pagerduty_api_key.yaml")
  // Service Integration
  enable_service_integration = true
  vendor_name                = "CloudWatch"

  // SNS Topic
  create_sns_topic = true
  service_name     = "AcmeCorp-Elasticsearch"
}
```
## Terraform Example w/CloudWatch & SNS Integration + Incident Urgency Rules + Support Hours

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
  token             = file("${path.module}/my_pagerduty_api_key.yaml")

  // Incident Urgency Rules
  incident_urgency_rule = [{
    type    = "constant"
    urgency = "low"

    during_support_hours = [
      {
      type    = "constant"
      urgency = "high"
    }]
    outside_support_hours = [
      {
      type    = "constant"
      urgency = "low"
    }]
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
}
```
## Terraform Example w/CloudWatch & SNS Integration + Incident Urgency Rules + Support Hours + Maintenance Windows
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
  token             = file("${path.module}/my_pagerduty_api_key.yaml")
  
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

    during_support_hours = [
      {
      type    = "constant"
      urgency = "high"
    }]
    outside_support_hours = [
      {
      type    = "constant"
      urgency = "low"
    }]
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
}
```
## Terragrunt Example w/CloudWatch & SNS Integration + Incident Urgency Rules + Support Hours + Maintenance Windows + Slack Extension
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
  token             = file("${path.module}/my_pagerduty_api_key.yaml")
  
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

    during_support_hours = [
      {
      type    = "constant"
      urgency = "high"
    }]
    outside_support_hours = [
      {
      type    = "constant"
      urgency = "low"
    }]
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
  create_extension       = true
  extension_name         = "DevOps: Slack"
  schema_webhook         = "Generic V1 Webhook"
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
