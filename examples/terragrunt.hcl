locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  common_tags       = local.common_vars.locals.tags
  env              = local.environment_vars.locals.environment
  vpn_cidr         = local.common_vars.locals.VPN_destination_cidr_block
  tags = merge(local.common_tags, {
    Environment = local.env
  })
}

include {
  path = find_in_parent_folders()
}
