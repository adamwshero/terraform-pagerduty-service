## Basic Terragrunt Example
```
locals {
  external_deps = read_terragrunt_config(find_in_parent_folders("external-deps.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars  = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  product       = local.product_vars.locals.product_name
  prefix        = local.product_vars.locals.prefix
  account       = local.account_vars.locals.account_id
  env           = local.env_vars.locals.env
  pagerduty_key = yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/sops/api-key.sops.yaml"))
  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )

  # Customize if needed
  additional_tags = {

  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"
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

  // SNS Topic
  prefix       = "my-prefix"
  service_name = "AcmeCorp-Elasticsearch"
}
```

## Complete Terragrunt Example w/Incident Urgency Rules & Slack Extension

```
locals {
  external_deps = read_terragrunt_config(find_in_parent_folders("external-deps.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars  = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  product       = local.product_vars.locals.product_name
  prefix        = local.product_vars.locals.prefix
  account       = local.account_vars.locals.account_id
  env           = local.env_vars.locals.env
  pagerduty_key = yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/sops/api-key.sops.yaml"))
  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )

  # Customize if needed
  additional_tags = {

  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"
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

  incident_urgency_rule = [{
    type    = "constant"
    urgency = "low"

    during_support_hours = [{
      type    = "constant"
      urgency = "low"
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
```
## Complete Terragrunt Example w/Scheduled Actions & Slack Extension

```
locals {
  external_deps = read_terragrunt_config(find_in_parent_folders("external-deps.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  product_vars  = read_terragrunt_config(find_in_parent_folders("product.hcl"))
  env_vars      = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  product       = local.product_vars.locals.product_name
  prefix        = local.product_vars.locals.prefix
  account       = local.account_vars.locals.account_id
  env           = local.env_vars.locals.env
  pagerduty_key = yamldecode(sops_decrypt_file("${get_terragrunt_dir()}/sops/api-key.sops.yaml"))
  tags = merge(
    local.env_vars.locals.tags,
    local.additional_tags
  )

  # Customize if needed
  additional_tags = {

  }
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:adamwshero/terraform-pagerduty-service.git//.?ref=1.1.0"
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

  // Scheduled Actions
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
```