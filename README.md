# Module: PagerDuty

### What this module does:
This module creates necessary services and integrations so DevOps can deploy Pagerduty services and dependent resources to teams so that they can receive actionable alerts from AWS CloudWatch.
* Creates a Pagerduty service
* Creates an SNS topic
* Subscribes the Pagerduty service to the SNS topic
* Sets up a Slack extension to a given channel
* Sets up a CloudWatch integration
<br>
<br>

## Who this module is for:
Anyone team needs to send CloudWatch alarms to PagerDuty and Slack. 
<br>
<br>

## Prerequisites
* A PagerDuty escalation policy must already exist.
* A PagerDuty on-call schedule *should* exist but is not required for this module to work.
* You will likely want to create the PagerDuty service by hand along with the slack extension so that you can import this resource into Terraform. This is going to be the easiest way to find all of the values for everything marked `##TODO##` in this repo.
Import your PagerDuty service and Slack extension by:
```
terraform import pagerduty_extension.main {extension_id}
```
<br>
<br>

## Referencing This Module

```
module "data" {
  source = "git@github.com:your-github-space/your-repository.git//path/to/module"
}
```
<br>
<br>

## How to consume this module:
Use any of the inputs available that you wish. Once you deploy this module, you will still need to create your ALARMS and send those events to the topic that gets created here. To be useful, you get the SNS topic name in the output of this module.

Currently it is setup to accept the following inputs.
```
inputs = {
### PagerDuty Inputs
  name               = "DevOps: Service-SubService"
  escalation_policy  = "Escalation: DevOps"
  resolve_timeout    = 14400
  ack_timeout        = 600
  alert_creation     = "create_alerts_and_incidents"
  alert_grouping     = "intelligent"
### AWS SNS Topic Inputs
  service_name            = "MyService" #Prefixed with "PagerDuty-DevOps-" in the module
### Slack Extension Inputs
  notify_resolve     = true
  notify_trigger     = true
  notify_escalate    = true
  notify_acknowledge = true
  notify_assignments = true
  notify_annotate    = true
  high_urgency       = true
  low_urgency        = true
  slack_channel      = "#my-slack-channel"
  slack_channel_id   = "ABC123XYZ"
}
```
<br>
<br>

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
https://api.pagerduty.com/extension_schemas/PII3QUR (See /slack_schema.json)

Get current Slack extension schema anytime via curl command
```
curl -i https://api.pagerduty.com/extension_schemas/PII3QUR -H "Accept: application/vnd.pagerduty+json;version=2" -H "Content-Type: application/json" -H "Authorization: Token token=y_NbAkKc66ryYTWUXYEu"
```
<br>

## To-Do:
* Create resource to handle runbook names and URL's.
* Create resource to handle service dependencies.
* Create CloudWatch metric alarm. (maybe)

<br>

## Owner:
It's you!
<br>
<br>

## Helpful URL's
https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/extension
