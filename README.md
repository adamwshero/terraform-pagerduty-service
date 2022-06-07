[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

![Terraform](https://cloudarmy.io/tldr/images/tf_aws.jpg)
<br>
<br>
<br>
<br>
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/adamwshero/terraform-pagerduty-service?color=lightgreen&label=latest%20tag%3A&style=for-the-badge)
<br>
<br>
# terraform-pagerduty-service

Terraform module that creates:
- Pagerduty Service w/optional Incident Urgency Rule
- SNS Topic
- Subscribes the Pagerduty service to the SNS topic
- Creates a Slack extension to a specified Slack channel
- Creates a CloudWatch integration

[Pagerduty Service](https://support.pagerduty.com/docs/services-and-integrations) represents something you monitor (like a web service, email service, or database service). It is a container for related incidents that associates them with escalation policies.

## Examples

Look at our complete [Terraform examples](latest/examples/terraform/) where you can get a better context of usage. The Terragrunt example can be viewed directly from GitHub.

## Usage

You can create a PagerDuty service that comes with its own SNS topic and a subcription to that topic. The module also creates the CloudWatch integration for you as well as a Slack extension for notifications to blast to your channel of choice.

### Terraform Example
```
module "pagerduty-service" {
    source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.0.10"

    ### PagerDuty Inputs
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

    support_hours = [{
      type         = "fixed_time_per_day"
      start_time   = "09:00:00"
      end_time     = "17:00:00"
      time_zone    = "America/Denver"
      days_of_week = [1, 2, 3, 4, 5]
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

### Terragrunt Example
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

## Special Notes (Alert Grouping):

The alert_grouping_parameters block contains the following arguments:

* type (Optional) - The type of alert grouping; one of intelligent, time or content_based.
* config (Optional) - Alert grouping parameters dependent on type. If type is set to intelligent or empty then config can be empty.
  * timeout - (Optional) The duration in minutes within which to automatically group incoming alerts. This setting applies only when type is set to time. To continue grouping alerts until the incident is resolved, set this value to 0.
  * aggregate - (Optional) One of any or all. This setting applies only when type is set to content_based. Group alerts based on one or all of fields value(s).
  * fields - (Optional) Alerts will be grouped together if the content of these fields match. This setting applies only when type is set to content_based.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.67.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.67.0 |
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >= 1.9.6 |


## Resources

| Name | Type |
|------|------|
| [pagerduty_service.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service) | resource |
| [pagerduty_extension.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/extension) | resource |
| [pagerduty_service_integration.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/service_integration) | resource |
| [pagerduty_vendor.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/vendor) | resource |
| [aws_sns_topic.rsm](https://registry.terraform.io/providers/aaronfeng/aws/latest/docs/resources/sns_topic) | resource |
<br>

## Available Inputs

| Name                  | Resource            | Variable                | Data Type     | Default                         | Required? |
| --------------------- | --------------------|------------------------ | ------------- | ------------------------------- | ----------|
| Service Name          | pagerduty_service   | `name`                  | `string`      | `DevOps: Test Service`          | No        |
| Escalation Policy     | pagerduty_service   | `escalation_policy`     | `string`      | `""`                            | Yes       |
| Description           | pagerduty_service   | `description `          | `string`      | `""`                            | No        |
| Resolve Timeout       | pagerduty_service   | `resolve_timeout`       | `number`      | `14400`                         | No        | 
| Acknowledge Timeout   | pagerduty_service   | `ack_timeout`           | `number`      | `600`                           | No        |
| Alert Creation        | pagerduty_service   | `alert_creation`        | `string`      | `"create_alerts_and_incidents"` | Yes       |
| Escalation Policy     | pagerduty_service   | `escalation_policy`     | `string`      | `""`                            | Yes       |
| Incident Urgency Rule | pagerduty_service   | `incident_urgency_rule` | `set(object)` | `[]`                            | No        |
| Support Hours         | pagerduty_service   | `escalation_policy`     | `set(object)` | `[]`                            | No        |
| Scheduled Actions     | pagerduty_service   | `escalation_policy`     | `set(object)` | `[]`                            | No        |
| Prefix                | aws_sns_topic       | `prefix`                | `string`      | `""`                            | No        |
| Name                  | aws_sns_topic       | `name`                  | `string`      | `""`                            | Yes       |
| App Id                | pagerduty_extension | `app_id`                | `string`      | `""`                            | Yes       |
| Authorized User       | pagerduty_extension | `authed_user`           | `string`      | `""`                            | No        |
| Bot UserId            | pagerduty_extension | `bot_user_id`           | `string`      | `""`                            | Yes       |
| Channel               | pagerduty_extension | `slack_channel`         | `string`      | `""`                            | Yes       |
| Channel Id            | pagerduty_extension | `slack_channel_id`      | `string`      | `""`                            | Yes       |
| Configuration URL     | pagerduty_extension | `configuration_url`     | `string`      | `""`                            | Yes       | 
| Webhook URL           | pagerduty_extension | `url`                   | `string`      | `""`                            | Yes       |
| Notify on Resolve     | pagerduty_extension | `notify_resolve`        | `bool`        | `"true"`                        | No        |
| Notify on Trigger     | pagerduty_extension | `notify_trigger`        | `bool`        | `"true"`                        | No        |
| Notify on Escalate    | pagerduty_extension | `notify_escalate`       | `bool`        | `"true"`                        | No        |
| Notify on Acknowledge | pagerduty_extension | `notify_acknowledge`    | `bool`        | `"true"`                        | No        |
| Notify on Assignment  | pagerduty_extension | `notify_assignments`    | `bool`        | `"true"`                        | No        |
| Notify on Annotate    | pagerduty_extension | `notify_annotate`       | `bool`        | `"true"`                        | No        |
| Referer URL           | pagerduty_extension | `referer`               | `string`      | `""`                            | Yes       |
| Team Id               | pagerduty_extension | `slack_team_id`         | `string`      | `""`                            | Yes       |
| Team Name             | pagerduty_extension | `slack_team_name`       | `string`      | `""`                            | Yes       |
| Alert on High Urgency | pagerduty_extension | `high_urgency`          | `bool`        | `"true"`                        | No        |
| Alert on High Urgency | pagerduty_extension | `low_urgency`           | `bool`        | `"true"`                        | No        |

<br>

## Predetermined Inputs

| Name          | Resource                      | Variable      | Data Type | Default                                | Required? |
| --------------| ------------------------------|-------------- | --------- | -------------------------------------- | ----------|
| Name          | pagerduty_service_integration | `name`        | `string`  | `data.pagerduty_vendor.this.name`      | Yes       |
| Service       | pagerduty_service_integration | `service`     | `string`  | `pagerduty_service.this.id`            | Yes       |
| Vendor        | pagerduty_service_integration | `vendor`      | `string`  | `data.pagerduty_vendor.this.id`        | Yes       |
| Type          | pagerduty_service_integration | `type`        | `string`  | `"aws_cloudwatch_inbound_integration"` | Yes       |
| Vendor Name   | pagerduty_vendor              | `name`        | `string`  | `"CloudWatch"`                         | Yes       |

<br>

## PagerDuty/Slack Extension Schema
 * https://developer.pagerduty.com/api-reference/YXBpOjExMjA5NTQ0-pager-duty-slack-integration-api (See /slack_schema.json)
 * https://developer.pagerduty.com/api-reference/b3A6Mjc0ODEzMg-list-extensions
<br>

## To-Do:
* Re-introduce alarm grouping options
* Create resource to handle runbook names and URL's.
* Create resource to handle service dependencies.
* Create CloudWatch metric alarm. (maybe)
* <s>Make module compatible with Terraform =>0.14.0</s>
<br>

## Known Issues
- PagerDuty is currently aware that the Slack extension must be manually authorized to connect to a given Slack channel once the service is created. There is no ETA on this fix.

