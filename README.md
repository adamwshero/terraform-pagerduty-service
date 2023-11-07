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

[Pagerduty Service](https://support.pagerduty.com/docs/services-and-integrations) represents something you monitor (like a web service, email service, or database service). It is a container for related incidents that associates them with escalation policies. Through its SaaS-based platform, PagerDuty empowers developers, DevOps, IT operations and business leaders to prevent and resolve business-impacting incidents for exceptional customer experience. When revenue and brand reputation depends on customer satisfaction, PagerDuty arms organizations with the insight to proactively manage events that may impact customers across their IT environment. With hundreds of native integrations, on-call scheduling and escalations, machine learning, business-wide response orchestration, analytics, and much more, PagerDuty gets the right data in the hands of the right people in real time, every time.
<br>

## Module Capabilities
- Creates a Pagerduty Service
- Creates 0, 1, or many maintenance windows
- Creates 0, 1, or many Slack Connections (team and/or service)
- Optional SNS Topic for integration notifications
- Automatically Subscribes the Pagerduty service to an SNS topic (if SNS is enabled)
- Optional Service integration (e.g. CloudWatch, DataDog, etc.)
- Optional Auto Pause Notifications
- Optional extension
- Optional Incident Urgency Rule
- Optional Support Hours
- Optional Scheduled Actions
<br>

## Examples
Look at our complete [Terraform examples](latest/examples/terraform/) where you can get a better context of usage for various scenarios. The Terragrunt example can be viewed directly from GitHub.
<br>

## Assumptions
  * You already have access to a PagerDuty account-level API key to create the service.
  * You already have access to a user-level API key to create Slack Connections.
  * You have access to Slack to acquire the team, bot, and other information need for the extension to work.
<br>

## Usage
You can create the most basic PagerDuty service or one that comes with its own SNS topic and a subcription to that topic. The module can also create the CloudWatch integration for you as well as an extension using your webhook of choice. It has the capability of creating many Slack Connections for teams or services, and many other optional configurations.
<br>

## Open Issues
* PagerDuty is currently aware that the Slack extension must be manually authorized in the PagerDuty Service page to connect to a given Slack channel once the service is created. There is no ETA on this fix
* A scheduled_actions block is required when using type = `use_support_hours` in incident_urgency_rule. However, when this value is used, the urgency attribute must also be removed. Upon removing this attribute, we encounter an index error. This is on our list of fixes to make soon. As a workaround, you can still use `support_hours` and `incident_urgency_rule` using `constant`.
<br>

## Special Notes
* (Slack Connections)
  * When using Slack Connections, it is important to understand that when `service_reference` is used for the `source_type` attribute, the `source_id` will automatically pick the id of `pagerduty_service.this`. If `team_reference` is used as the value for `source_type`, the value for `source_id` (Slack team id) must be provided by the user. This example is included for reference.
* (Scheduled Actions)
  * A scheduled_actions block is required when using type = `use_support_hours` in incident_urgency_rule.
* (Incident Urgency Rule)
  * When using type = `use_support_hours` in `incident_urgency_rule` you must specify exactly one (otherwise optional) `support_hours` block. Your PagerDuty account must have the `service_support_hours` ability to assign support hours. The block contains the following arguments:
  * Note that it is currently only possible to define the scheduled action when urgency is set to high for `during_support_hours` and to low for `outside_support_hours` in `incident_urgency_rule`.
* Generic V1 Webook
  * This webhook is no longer available after 10/31/2022. Users are encouraged to migrate to V3 webhooks.
<br>

## Upcoming Improvements
* Re-introduce alarm grouping options.
* Support many integrations and extensions.
* Create resource to handle runbook names and URL's.
* <s>Make module compatible with Terraform =>0.14.0</s>
<br>

### Terraform Basic Example
```
module "pagerduty-service" {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=2.0.0"

  // PagerDuty Service
  name              = "My Critical Service"
  description       = "Service for all prod services."
  escalation_policy = "My Escalation Policy Name"
  alert_creation    = "create_alerts_and_incidents"
  resolve_timeout   = 14400
  ack_timeout       = 600
  token             = file("${path.module}/my_pagerduty_api_key.yaml")

  alert_grouping_parameters = [{
    type   = "intelligent"
    config = {}
  }]
}
```

### Terragrunt Basic Example
```
terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=2.0.0"
}

inputs = {
  // PagerDuty Service
  name              = "My Critical Service"
  description       = "Service for all prod services."
  escalation_policy = "My Escalation Policy Name"
  alert_creation    = "create_alerts_and_incidents"
  resolve_timeout   = 14400
  ack_timeout       = 600
  token             = local.pagerduty_key.key

  alert_grouping_parameters = [{
    type   = "intelligent"
    config = {}
  }]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.67.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 
| <a name="requirement_terragrunt"></a> [terragrunt](#requirement\_terragrunt) | >= 0.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.67.0 |
| <a name="provider_pagerduty"></a> [pagerduty](#provider\_pagerduty) | >= 3.1.1 |

## Resources

| Name                                                                                                                                             | Type     |
|------------------------------------------------------------------------------------------------------------------------------------------------- | ---------|
| [pagerduty_service.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/service)                               | resource |
| [pagerduty_extension.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/extension)                           | resource |
| [pagerduty_service_integration.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/service_integration)    | resource |
| [pagerduty_service_maintenance_window.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/maintenance_window) | resource |
| [pagerduty_slack_connection.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/slack_connection)             | resource |
| [aws_sns_topic.rsm](https://registry.terraform.io/providers/aaronfeng/aws/latest/docs/resources/sns_topic)                                       | resource |
| [aws_sns_topic_subscription.rsm](https://registry.terraform.io/providers/aaronfeng/aws/latest/docs/resources/sns_topic_subscription)             | resource |

## Data Sources
| Name                                                                                                                                    | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------- | ---------|
| [pagerduty_escalation_policy.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/escalation_policy)  | resource |
| [pagerduty_vendor.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/vendor)                     | resource |
| [pagerduty_extension_schema.rsm](https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/data-sources/extension_schema) | resource |

## Available Inputs

| Name                  | Resource            | Variable                | Data Type     | Default                         | Required? |
| --------------------- | --------------------|------------------------ | ------------- | ------------------------------- | ----------|
| Service Name          | pagerduty_service   | `name`                  | `string`      | `DevOps: Test Service`          | No        |
| Escalation Policy     | pagerduty_service   | `escalation_policy`     | `string`      | `null`                          | Yes       |
| Description           | pagerduty_service   | `description `          | `string`      | `null`                          | No        |
| Resolve Timeout       | pagerduty_service   | `resolve_timeout`       | `number`      | `14400`                         | No        | 
| Acknowledge Timeout   | pagerduty_service   | `ack_timeout`           | `number`      | `600`                           | No        |
| Alert Creation        | pagerduty_service   | `alert_creation`        | `string`      | `"create_alerts_and_incidents"` | Yes       |
| Escalation Policy     | pagerduty_service   | `escalation_policy`     | `string`      | `null`                          | Yes       |
| Incident Urgency Rule | pagerduty_service   | `incident_urgency_rule` | `any`         | `[]`                            | No        |
| Support Hours         | pagerduty_service   | `support_hours`         | `set(object)` | `[]`                            | No        |
| Scheduled Actions     | pagerduty_service   | `scheduled_actions`     | `any`         | `[]`                            | No        |
| Autopause notifications| pagerduty_service  | `autopause_notifications_parameters` | `any` | `[]`                       | No        |
| Vendor Name           | pagerduty_service_integration | `vendor_name` | `string`      | `null`                          | No        |
| Prefix                | aws_sns_topic       | `prefix`                | `string`      | `null`                          | No        |
| Name                  | aws_sns_topic       | `name`                  | `string`      | `null`                          | Yes       |
| Schema Name           | pagerduty_extension_schema | `schema_name`    | `string`      | `null`                          | Yes       |
| Create Extension      | pagerduty_extension | `create_extention`      | `bool`        | `false`                         | No        |
| Extension Name        | pagerduty_extension | `extention_name`        | `string`      | `null`                          | Yes       |
| Endpoint URL          | pagerduty_extension | `endpoint_url`          | `string`      | `null`                          | Yes       |
| App Id                | pagerduty_extension | `app_id`                | `string`      | `null`                          | Yes       |
| Authorized User       | pagerduty_extension | `authed_user`           | `string`      | `null`                          | No        |
| Bot UserId            | pagerduty_extension | `bot_user_id`           | `string`      | `null`                          | Yes       |
| Channel               | pagerduty_extension | `slack_channel`         | `string`      | `null`                          | Yes       |
| Channel Id            | pagerduty_extension | `slack_channel_id`      | `string`      | `null`                          | Yes       |
| Configuration URL     | pagerduty_extension | `configuration_url`     | `string`      | `null`                          | Yes       | 
| Webhook URL           | pagerduty_extension | `url`                   | `string`      | `null`                          | Yes       |
| Notify on Resolve     | pagerduty_extension | `notify_resolve`        | `bool`        | `"true"`                        | No        |
| Notify on Trigger     | pagerduty_extension | `notify_trigger`        | `bool`        | `"true"`                        | No        |
| Notify on Escalate    | pagerduty_extension | `notify_escalate`       | `bool`        | `"true"`                        | No        |
| Notify on Acknowledge | pagerduty_extension | `notify_acknowledge`    | `bool`        | `"true"`                        | No        |
| Notify on Assignment  | pagerduty_extension | `notify_assignments`    | `bool`        | `"true"`                        | No        |
| Notify on Annotate    | pagerduty_extension | `notify_annotate`       | `bool`        | `"true"`                        | No        |
| Referer URL           | pagerduty_extension | `referer`               | `string`      | `null`                          | Yes       |
| Team Id               | pagerduty_extension | `slack_team_id`         | `string`      | `null`                          | Yes       |
| Team Name             | pagerduty_extension | `slack_team_name`       | `string`      | `null`                          | Yes       |
| Alert on High Urgency | pagerduty_extension | `high_urgency`          | `bool`        | `"true"`                        | No        |
| Alert on High Urgency | pagerduty_extension | `low_urgency`           | `bool`        | `"true"`                        | No        |
| Maintenance Windows   | pagerduty_maintenance_window | `maintenance_windows` | `any`  | `[]`                            | No        |
| DataDog API Key       | pagerduty_service_integration | `datadog_api_key` | `string`  | `null`                          | No        |
| DataDog APP Key       | pagerduty_service_integration | `datadog_app_key` | `string`  | `null`                          | No        |





## Predetermined Inputs

| Name          | Resource                      | Variable      | Data Type | Default                                | Required? |
| --------------| ------------------------------|-------------- | --------- | -------------------------------------- | ----------|
| Name          | pagerduty_service_integration | `name`        | `string`  | `data.pagerduty_vendor.this.name`      | Yes       |
| Service       | pagerduty_service_integration | `service`     | `string`  | `pagerduty_service.this.id`            | Yes       |
| Vendor        | pagerduty_service_integration | `vendor`      | `string`  | `data.pagerduty_vendor.this.id`        | Yes       |
| Service       | pagerduty_maintenance_window  | `service`     | `string`  | `pagerduty_service.this.id`            | Yes       |

## Outputs

| Name                              | Description                                                       |
|---------------------------------- | ----------------------------------------------------------------- | 
| pagerduty_service_name            | The name of the PagerDuty service.                                |
| pagerduty_service_id              | Id of PagerDuty Service.                                          |
| pagerduty_service_url             | The URL of the PagerDuty service.                                 |
| pagerduty_service_integration_id  | Id of the integration with PagerDuty.                             |
| pagerduty_service_integration_key | Key of the integration with PagerDuty.                            |
| sns_service_topic                 | The name of the SNS topic that you can send CloudWatch alarms to. |
| sns_topic_arn                     | The Arn of the SNS topic that you can send CloudWatch alarms to.  |
| sns_subscription_url              | Subscription URL for SNS.                                         |
| extension_id                      | The Id of the Slack extension.                                    |
| extension_url                     | URL at which the entity is uniquely displayed in the Web app.     |
| slack_connections                 | Map of Slack connections for teams or services.                   |
| maintenance_windows_in_effect     | Map of maintenance windows that are in effect.                    |

## PagerDuty/Slack Extension Schema
 * https://developer.pagerduty.com/api-reference/YXBpOjExMjA5NTQ0-pager-duty-slack-integration-api (See /slack_schema.json)
 * https://developer.pagerduty.com/api-reference/b3A6Mjc0ODEzMg-list-extensions