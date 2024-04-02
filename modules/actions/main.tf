resource "github_actions_repository_access_level" "this" {
  count = var.create && var.repository_access_level != null ? 1 : 0

  repository   = var.repository
  access_level = var.repository_access_level
}

resource "github_actions_repository_permissions" "this" {
  count = var.create && var.repository_permissions != null ? 1 : 0

  repository      = var.repository
  allowed_actions = try(var.repository_permissions.allowed_actions, null)
  enabled         = try(var.repository_permissions.enabled, null)

  dynamic "allowed_actions_config" {
    for_each = var.repository_permissions.allowed_actions_config != null ? [var.repository_permissions.allowed_actions_config] : []

    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = try(allowed_actions_config.value.patterns_allowed, null)
      verified_allowed     = try(allowed_actions_config.value.verified_allowed, null)
    }
  }
}

resource "github_repository_environment" "this" {
  for_each = { for k, v in var.environments : k => v if var.create }

  repository          = var.repository
  environment         = each.key
  wait_timer          = try(each.value.wait_timer, null)
  can_admins_bypass   = try(each.value.can_admins_bypass, null)
  prevent_self_review = try(each.value.prevent_self_review, null)

  dynamic "reviewers" {
    for_each = each.value.reviewers != null ? [each.value.reviewrs] : []

    content {
      teams = try(reviewers.value.teams, null)
      users = try(reviewers.value.users, null)
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = each.value.deployment_branch_policy != null ? [each.value.deployment_branch_policy] : []

    content {
      protected_branches     = deployment_branch_policy.value.protected_branches
      custom_branch_policies = deployment_branch_policy.value.custom_branch_policies
    }
  }
}

resource "github_repository_environment_deployment_policy" "this" {
  for_each = { for i, v in var.deployment_branch_policies : i => v }

  repository     = var.repository
  environment    = each.value.environment
  branch_pattern = each.value.branch_pattern
}

module "secrets_and_variables" {
  source = "../secrets-and-variables"

  repository        = var.repository
  actions_secrets   = var.secrets
  actions_variables = var.variables
}

resource "github_repository_deploy_key" "this" {
  for_each = toset(var.deploy_keys)

  repository = var.repository
  key        = each.value.key
  read_only  = each.value.read_only
  title      = each.value.title
}
