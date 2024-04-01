resource "github_repository" "this" {
  count = var.create ? 1 : 0

  lifecycle {
    ignore_changes = [description]
  }

  name                        = var.name
  description                 = var.description
  homepage_url                = var.homepage_url
  visibility                  = var.visibility
  has_issues                  = var.has_issues
  has_discussions             = var.has_discussions
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  is_template                 = var.is_template
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_auto_merge            = var.allow_auto_merge
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  merge_commit_title          = var.merge_commit_title
  merge_commit_message        = var.merge_commit_message
  delete_branch_on_merge      = var.delete_branch_on_merge
  web_commit_signoff_required = var.web_commit_signoff_required
  has_downloads               = var.has_downloads
  auto_init                   = var.auto_init
  gitignore_template          = var.gitignore_template
  license_template            = var.license_template
  archived                    = var.archived
  archive_on_destroy          = var.archive_on_destroy

  dynamic "pages" {
    for_each = length(var.pages) > 0 ? [var.pages] : []

    content {
      dynamic "source" {
        for_each = length(pages.value.source) > 0 ? [pages.value.source] : []

        content {
          branch = source.value.branch
          path   = source.value.path
        }
      }
      build_type = pages.value.build_type
      cname      = pages.value.cname
    }
  }

  dynamic "security_and_analysis" {
    for_each = length(var.security_and_analysis) > 0 ? [var.security_and_analysis] : []

    content {
      dynamic "advanced_security" {
        for_each = length(security_and_analysis.value.advanced_security) > 0 ? [security_and_analysis.value.advanced_security] : []

        content {
          status = advanced_security.value.status
        }
      }

      dynamic "secret_scanning" {
        for_each = length(security_and_analysis.value.secret_scanning) > 0 ? [security_and_analysis.value.secret_scanning] : []

        content {
          status = secret_scanning.value.status
        }
      }

      dynamic "secret_scanning_push_protection" {
        for_each = length(security_and_analysis.value.secret_scanning_push_protection) > 0 ? [security_and_analysis.value.secret_scanning_push_protection] : []

        content {
          status = secret_scanning_push_protection.value.status
        }
      }
    }
  }

  topics = var.topics

  dynamic "template" {
    for_each = length(var.template) > 0 ? [var.template] : []

    content {
      owner                = template.value.owner
      repository           = template.value.repository
      include_all_branches = template.value.include_all_branches
    }
  }

  vulnerability_alerts                    = var.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read
  allow_update_branch                     = var.allow_update_branch
}

resource "github_repository_collaborator" "this" {
  count = length(var.collaborators_authoritative ? [] : var.collaborators)

  repository                  = github_repository.this[0].name
  username                    = var.collaborators[count.index].username
  permission                  = lookup(var.collaborators[count.index], "permission", null)
  permission_diff_suppression = lookup(var.collaborators[count.index], "permission_diff_suppression", null)
}

resource "github_repository_collaborators" "this" {
  count = length(var.collaborators_authoritative ? var.collaborators : [])

  repository = github_repository.this[0].name

  dynamic "user" {
    for_each = lookup(var.collaborators[count.index], "users", [])

    content {
      permission = lookup(user.value, "permission", null)
      username   = user.value.username
    }
  }

  dynamic "team" {
    for_each = lookup(var.collaborators[count.index], "teams", [])

    content {
      team_id    = team.value.team_id
      permission = lookup(team.value, "permission", null)
    }
  }
}

resource "github_repository_file" "this" {
  for_each = { for v in var.files : v.file => v }

  lifecycle {
    # https://github.com/integrations/terraform-provider-github/issues/689
    ignore_changes = [commit_message, commit_author, commit_email]
  }

  repository          = github_repository.this[0].name
  branch              = lookup(each.value, "branch", github_branch_default.this[0].branch)
  file                = each.value.file
  content             = each.value.content
  commit_message      = lookup(each.value, "commit_message", null)
  commit_author       = lookup(each.value, "commit_author", null)
  commit_email        = lookup(each.value, "commit_email", null)
  overwrite_on_create = lookup(each.value, "overwrite_on_create", false)
}

resource "github_repository_webhook" "this" {
  count = length(var.webhooks)

  repository = github_repository.this[0].name
  events     = var.webhooks[count.index].events

  dynamic "configuration" {
    for_each = length(var.webhooks[count.index].configuration) > 0 ? [var.webhooks[count.index].configuration] : []

    content {
      url          = configuration.value.url
      content_type = configuration.value.content_type
      secret       = lookup(configuration.value, "secret", null)
      insecure_ssl = lookup(configuration.value, "insecure", null)
    }
  }

  active = lookup(var.webhooks[count.index], "active", null)
}

module "secrets_and_variables" {
  source = "./modules/secrets-and-variables"
  count  = var.create ? 1 : 0

  repository         = github_repository.this[0].name
  actions_secrets    = var.actions_secrets
  actions_variables  = var.actions_variables
  codespaces_secrets = var.codespaces_secrets
  dependabot_secrets = var.dependabot_secrets
}

# Branches & Tags
# ============================================================================
resource "github_branch_default" "this" {
  count      = var.create ? 1 : 0
  repository = github_repository.this[0].name
  branch     = var.default_branch
  rename     = var.default_branch_rename
}

resource "github_branch" "this" {
  for_each = { for k, v in var.branches : k => v if var.create }

  repository    = github_repository.this[0].name
  branch        = each.key
  source_branch = try(each.value.source_branch, null)
  source_sha    = try(each.value.source_sha, null)
}

resource "github_branch_protection" "this" {
  for_each = { for k, v in var.branch_protections : v.pattern => v if var.create }

  repository_id                   = github_repository.this[0].name
  pattern                         = each.value.pattern
  enforce_admins                  = try(each.value.enforce_admins, null)
  require_signed_commits          = try(each.value.require_signed_commits, null)
  required_linear_history         = try(each.value.required_linear_history, null)
  require_conversation_resolution = try(each.value.require_conversation_resolution, null)

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [each.value.required_status_checks] : []

    content {
      strict   = try(required_status_checks.value.strict, null)
      contexts = try(required_status_checks.value.contexts, null)
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [each.value.required_pull_request_reviews] : []

    content {
      dismiss_stale_reviews           = try(required_pull_request_reviews.value.dismiss_stale_reviews, null)
      restrict_dismissals             = try(required_pull_request_reviews.value.restrict_dismissals, null)
      dismissal_restrictions          = try(required_pull_request_reviews.value.dismissal_restrictions, null)
      pull_request_bypassers          = try(required_pull_request_reviews.value.pull_request_bypassers, null)
      require_code_owner_reviews      = try(required_pull_request_reviews.value.require_code_owner_reviews, null)
      required_approving_review_count = try(required_pull_request_reviews.value.required_approving_review_count, null)
      require_last_push_approval      = try(required_pull_request_reviews.value.require_last_push_approval, null)
    }
  }

  dynamic "restrict_pushes" {
    for_each = each.value.restrict_pushes != null ? [each.value.restrict_pushes] : []

    content {
      blocks_creations = try(restrict_pushes.value["blocks_creations"], null)
      push_allowances  = try(restrict_pushes.value["push_allowances"], null)
    }
  }

  force_push_bypassers = try(each.value.force_push_bypassers, null)
  allows_deletions     = try(each.value.allows_deletions, null)
  allows_force_pushes  = try(each.value.allows_force_pushes, null)
  lock_branch          = try(each.value.lock_branch, null)
}

# TODO
# resource "github_repository_ruleset" "this" {
#   repository = github_repository.this[0].name
# }

resource "github_repository_tag_protection" "this" {
  for_each = { for tp in var.tag_protections : tp.pattern => tp }

  repository = github_repository.this[0].name
  pattern    = each.value.pattern
}

# GitHub Actions
# ============================================================================
resource "github_actions_repository_access_level" "this" {
  count        = var.create ? 1 : 0
  repository   = github_repository.this[0].name
  access_level = var.actions_repository_access_level
}

resource "github_actions_repository_permissions" "this" {
  count           = var.create ? 1 : 0
  repository      = github_repository.this[0].name
  allowed_actions = lookup(var.actions_repository_permissions, "allowed_actions", "all")
  enabled         = lookup(var.actions_repository_permissions, "enabled", true)

  dynamic "allowed_actions_config" {
    for_each = length(lookup(var.actions_repository_permissions, "allowed_actions_config", [])) > 0 ? [var.actions_repository_permissions.allowed_actions_config] : []

    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = lookup(allowed_actions_config.value, "patterns_allowed")
      verified_allowed     = lookup(allowed_actions_config.value, "verified_allowed")
    }
  }
}

# Dependabot
# ============================================================================
resource "github_repository_dependabot_security_updates" "this" {
  count      = var.create ? 1 : 0
  repository = github_repository.this[0].name
  enabled    = var.dependabot_security_updates_enabled
}

# Environments & Deployments
# ============================================================================
resource "github_repository_deploy_key" "this" {
  count = length(var.deploy_keys)

  repository = github_repository.this[0].name
  key        = var.deploy_keys[count.index].key
  read_only  = var.deploy_keys[count.index].read_only
  title      = var.deploy_keys[count.index].title
}

resource "github_repository_environment" "this" {
  for_each = { for v in var.environments : v.environment => v }

  repository          = github_repository.this[0].name
  environment         = each.value.environment
  wait_timer          = lookup(each.value, "wait_timer", null)
  can_admins_bypass   = lookup(each.value, "can_admins_bypass", null)
  prevent_self_review = lookup(each.value, "prevent_self_review", null)

  dynamic "reviewers" {
    for_each = length(lookup(each.value, "reviewers", [])) > 0 ? [each.value.reviewers] : []

    content {
      teams = lookup(reviewers.value, "teams")
      users = lookup(reviewers.value, "users")
    }
  }

  dynamic "deployment_branch_policy" {
    for_each = length(lookup(each.value, "deployment_branch_policy", [])) > 0 ? [each.value.reviewers] : []

    content {
      protected_branches     = each.value.protected_branches
      custom_branch_policies = each.value.custom_branch_policies
    }
  }
}

resource "github_repository_environment_deployment_policy" "this" {
  for_each = { for v in var.environment_deployment_policies : v.name => v }

  repository     = github_repository.this[0].name
  environment    = each.value.environment_name
  branch_pattern = each.value.branch_pattern
}

# Issues and Pull Requests
# ============================================================================
# NOTE: Skipped milestone, project and pull request resources
resource "github_issue_label" "this" {
  count = length(var.issue_labels_authoritative ? [] : var.issue_labels)

  repository = github_repository.this[0].name

  name        = var.issue_labels[count.index].name
  description = lookup(var.issue_labels[count.index], "description", null)
  color       = trimprefix(var.issue_labels[count.index].color, "#")
}

resource "github_issue_labels" "this" {
  count = var.issue_labels_authoritative ? 1 : 0

  repository = github_repository.this[0].name

  dynamic "label" {
    for_each = var.issue_labels

    content {
      name        = label.value.name
      color       = label.value.color
      description = lookup(label.value, "description", null)
    }
  }
}

resource "github_repository_autolink_reference" "this" {
  for_each = { for v in var.autolink_references : v.key_prefix => v }

  repository          = github_repository.this[0].name
  key_prefix          = each.value.key_prefix
  target_url_template = each.value.target_url_template
  is_alphanumeric     = lookup(each.value, "is_alphanumeric")
}
