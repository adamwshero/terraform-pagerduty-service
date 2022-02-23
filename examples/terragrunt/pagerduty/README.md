# Complete Plan Example

```
locals {
  account     = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  region      = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  environment = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

include {
  path = find_in_parent_folders()
}

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
  notify_resolve     = true
  notify_trigger     = true
  notify_escalate    = true
  notify_acknowledge = true
  notify_assignments = true
  notify_annotate    = true
  high_urgency       = true
  low_urgency        = true
  slack_channel      = "#devops-pagerduty" #Required Input
  slack_channel_id   = "A11AA1AAA1A"       #TODO# not sure if this can be a list
}
```