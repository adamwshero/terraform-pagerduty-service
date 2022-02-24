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
- Pagerduty Service
- SNS Topic
- Subscribes the Pagerduty service to the SNS topic
- Creates a Slack extension to a specified Slack channel
- Creates a CloudWatch integration

[Pagerduty Service](https://support.pagerduty.com/docs/services-and-integrations) represents something you monitor (like a web service, email service, or database service). It is a container for related incidents that associates them with escalation policies.

## Examples

Look at our [Terraform example](latest/examples/terraform/) where you can get a better context of usage for both Terraform. The Terragrunt example can be viewed directly from GitHub.

## Usage

You can create a PagerDuty service that comes with its own SNS topic and a subcription to that topic. The module also creates the CloudWatch integration for you as well as a Slack extension for notifications to blast to your channel of choice.

### Terraform Example
```
module "pagerduty-service" {
    source = "git@github.com:adamwshero/terraform-pagerduty-service.git//?ref=1.0.0"

    ### PagerDuty Inputs
    name              = "DevOps: My-Critical-Service"    #Required Input
    escalation_policy = "Escalation: DevOps Engineering" #Required Input
    resolve_timeout   = 14400
    ack_timeout       = 600
    alert_creation    = "create_alerts_and_incidents"
    alert_grouping    = "intelligent"

    ### AWS SNS Topic Inputs
    service_name = "AcmeCorp-Elasticsearch" #Prefixed with "PagerDuty-DevOps-" in the module

    ### Slack Extension Inputs
    app_id             = "A1AAAAAAA"
    authed_user        = "A11AAA11AAA"
    bot_user_id        = "A111AAAA11A"
    configuration_url  = "https://acme-corp.slack.com/services/A111AAAAAAAA"
    notify_resolve     = true
    notify_trigger     = true
    notify_escalate    = true
    notify_acknowledge = true
    notify_assignments = true
    notify_annotate    = true
    high_urgency       = true
    low_urgency        = true
    referer            = "https://acmecorp.pagerduty.com/services/A1AAAA1/integrations?service_profile=1"
    slack_team_id      = "AAAAAA11A"
    slack_team_name    = "AcmeCorp"
    slack_channel      = "#devops-pagerduty" #Required Input
    slack_channel_id   = "A11AA1AAA1A"       #TODO# not sure if this can be a list
}
```

### Terragrunt Example
```
terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//?ref=1.0.0"
}

inputs = {
  ### PagerDuty Inputs
  name              = "DevOps: My-Critical-Service"    #Required Input
  escalation_policy = "Escalation: DevOps Engineering" #Required Input
  resolve_timeout   = 14400
  ack_timeout       = 600
  alert_creation    = "create_alerts_and_incidents"
  alert_grouping    = "intelligent"
  
  ### AWS SNS Topic Inputs
  service_name = "AcmeCorp-Elasticsearch" #Prefixed with "PagerDuty-DevOps-" in the module
  
  ### Slack Extension Inputs
    app_id             = "A1AAAAAAA"
    authed_user        = "A11AAA11AAA"
    bot_user_id        = "A111AAAA11A"
    configuration_url  = "https://acme-corp.slack.com/services/A111AAAAAAAA"
    notify_resolve     = true
    notify_trigger     = true
    notify_escalate    = true
    notify_acknowledge = true
    notify_assignments = true
    notify_annotate    = true
    high_urgency       = true
    low_urgency        = true
    referer            = "https://acmecorp.pagerduty.com/services/A1AAAA1/integrations?service_profile=1"
    slack_team_id      = "AAAAAA11A"
    slack_team_name    = "AcmeCorp"
    slack_channel      = "#devops-pagerduty" #Required Input
    slack_channel_id   = "A11AA1AAA1A"       #TODO# not sure if this can be a list
}
```

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


## Available Inputs

| PagerDuty Property               | Variable                 | Data Type |
| -------------------------------- | ------------------------ | --------- |
| PagerDuty Service Name           | `name`                   | String    |
| PagerDuty Escalation Policy      | `escalation_policy`      | String    |
| PagerDuty Resolve Timeout        | `resolve_timeout`        | Number    |
| PagerDuty Acknowledge Timeout    | `ack_timeout`            | Number    |
| PagerDuty Alert Creation         | `alert_creation`         | String    |
| PagerDuty Escalation Policy      | `escalation_policy`      | String    |
| PagerDuty Alert Creation         | `alert_creation`         | String    |
| PagerDuty Alert Grouping         | `alert_grouping`         | String    |
| PagerDuty Alert Grouping Timeout | `alert_grouping_timeout` | Number    |
<br>

| AWS SNS Topic Property       | Variable             | Data Type |
| ---------------------------- | -------------------- | ---------
| AWS SNS Prefix               | `prefix`             | String    |
| AWS SNS Name                 | `service_name`       | String    |
<br>

| Slack Extension Property     | Variable             | Data Type |
| ---------------------------- | -------------------- | ---------
| Slack App Id                 | `app_id`             | String    |
| Slack Authorized User        | `authed_user`        | String    |
| Slack Bot UserId             | `bot_user_id`        | String    |
| Slack Channel                | `slack_channel`      | String    |
| Slack Channel Id             | `slack_channel_id`   | String    |
| Slack Configuration URL      | `configuration_url`  | String    |
| Slack Webhook URL            | `url`                | String    |
| Slack Notify on Resolve      | `notify_resolve`     | Bool      |
| Slack Notify on Trigger      | `notify_trigger`     | Bool      |
| Slack Notify on Escalate     | `notify_escalate`    | Bool      |
| Slack Notify on Acknowledge  | `notify_acknowledge` | Bool      |
| Slack Notify on Assignment   | `notify_assignments` | Bool      |
| Slack Notify on Annotate     | `notify_annotate`    | Bool      |
| Slack Referer URL            | `referer`            | String    |
| Slack Team Id                | `slack_team_id`      | String    |
| Slack Team Name              | `slack_team_name`    | String    |
| Slack Alert on High Urgency  | `high_urgency`       | Bool      |
| Slack Alert on High Urgency  | `low_urgency`        | Bool      |
<br>

## PagerDuty/Slack Extension Schema
https://developer.pagerduty.com/api-reference/YXBpOjExMjA5NTQ0-pager-duty-slack-integration-api (See /slack_schema.json)

## To-Do:
* Create resource to handle runbook names and URL's.
* Create resource to handle service dependencies.
* Create CloudWatch metric alarm. (maybe)
* <s>Make module compatible with Terraform =>0.14.0</s>

## Known Issues
- PagerDuty is currently aware that the Slack extension must be manually authorized to connect to a given Slack channel once the service is created. There is no ETA on this fix.

