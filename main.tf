resource "github_repository" "this" {
  count = var.create ? 1 : 0

  lifecycle {
    ignore_changes = [description, homepage_url, topics]
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
    for_each = var.pages != null ? [var.pages] : []

    content {
      dynamic "source" {
        for_each = pages.value.source != null ? [pages.value.source] : []

        content {
          branch = source.value.branch
          path   = try(source.value.path, null)
        }
      }
      build_type = try(pages.value.build_type, null)
      cname      = try(pages.value.cname, null)
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.security_and_analysis != null ? [var.security_and_analysis] : []

    content {
      dynamic "advanced_security" {
        for_each = security_and_analysis.value.advanced_security != null ? [security_and_analysis.value.advanced_security] : []

        content {
          status = advanced_security.value.status
        }
      }

      dynamic "secret_scanning" {
        for_each = security_and_analysis.value.secret_scanning != null ? [security_and_analysis.value.secret_scanning] : []

        content {
          status = secret_scanning.value.status
        }
      }

      dynamic "secret_scanning_push_protection" {
        for_each = security_and_analysis.value.secret_scanning_push_protection != null ? [security_and_analysis.value.secret_scanning_push_protection] : []

        content {
          status = secret_scanning_push_protection.value.status
        }
      }
    }
  }

  topics = var.topics

  dynamic "template" {
    for_each = var.template != null ? [var.template] : []

    content {
      owner                = template.value.owner
      repository           = template.value.repository
      include_all_branches = try(template.value.include_all_branches, null)
    }
  }

  vulnerability_alerts                    = var.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read
  allow_update_branch                     = var.allow_update_branch
}

resource "github_repository_collaborator" "this" {
  for_each = {
    for v in(var.collaborators_authoritative ? [] : coalesce(var.collaborators.non_authoritative, [])) :
    v.username => v
  }

  repository                  = github_repository.this[0].name
  username                    = each.value.username
  permission                  = try(each.value.permission, null)
  permission_diff_suppression = try(each.value.permission_diff_suppression, null)
}

resource "github_repository_collaborators" "this" {
  count = var.collaborators_authoritative ? 1 : 0

  repository = github_repository.this[0].name

  dynamic "user" {
    for_each = try(var.collaborators.authoritative.users, [])

    content {
      username   = user.value.username
      permission = try(user.value.permission, null)
    }
  }

  dynamic "team" {
    for_each = try(var.collaborators.authoritative.teams, [])

    content {
      team_id    = team.value.team_id
      permission = try(team.value.permission, null)
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
  branch              = try(each.value.branch, github_branch_default.this[0].branch)
  file                = each.value.file
  content             = each.value.content
  commit_message      = try(each.value.commit_message, null)
  commit_author       = try(each.value.commit_author, null)
  commit_email        = try(each.value.commit_email, null)
  overwrite_on_create = try(each.value.overwrite_on_create, null)
}

resource "github_repository_webhook" "this" {
  for_each = { for index, v in var.webhooks : index => v if var.create }

  repository = github_repository.this[0].name
  events     = each.value.events

  dynamic "configuration" {
    for_each = each.value.configuration != null ? [each.value.configuration] : []

    content {
      url          = configuration.value.url
      content_type = configuration.value.content_type
      secret       = try(configuration.value.secret, null)
      insecure_ssl = try(configuration.value.insecure_ssl, null)
    }
  }

  active = try(each.value.active, null)
}

module "secrets_and_variables" {
  source = "./modules/secrets-and-variables"
  count  = var.create ? 1 : 0

  repository = github_repository.this[0].name
  secrets    = var.secrets
  variables  = var.variables
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

module "rulesets" {
  source = "./modules/rulesets"
  count  = var.create ? 1 : 0

  repository = github_repository.this[0].name
  rulesets   = var.rulesets
}

# GitHub Actions
# ============================================================================
module "actions" {
  source = "./modules/actions"
  count  = var.create ? 1 : 0

  repository                 = github_repository.this[0].name
  repository_access_level    = var.actions_repository_access_level
  repository_permissions     = var.actions_repository_permissions
  environments               = var.environments
  deployment_branch_policies = var.deployment_branch_policies
  deploy_keys                = var.deploy_keys
}

# Dependabot
# ============================================================================
resource "github_repository_dependabot_security_updates" "this" {
  count      = var.create && var.vulnerability_alerts ? 1 : 0
  repository = github_repository.this[0].name
  enabled    = var.dependabot_security_updates_enabled
}

# Issues and Pull Requests
# ============================================================================
# NOTE: Skipped milestone, project and pull request resources
resource "github_issue_label" "this" {
  for_each = {
    for index, v in var.issue_labels_authoritative ? [] : var.issue_labels :
    index => v
  }

  repository  = github_repository.this[0].name
  name        = each.value.name
  color       = trimprefix(each.value.color, "#")
  description = try(each.value.description, null)
}

resource "github_issue_labels" "this" {
  count = var.issue_labels_authoritative ? 1 : 0

  repository = github_repository.this[0].name

  dynamic "label" {
    for_each = var.issue_labels

    content {
      name        = label.value.name
      color       = label.value.color
      description = try(label.value.description, null)
    }
  }
}

resource "github_repository_autolink_reference" "this" {
  for_each = { for v in var.autolink_references : v.key_prefix => v }

  repository          = github_repository.this[0].name
  key_prefix          = each.value.key_prefix
  target_url_template = each.value.target_url_template
  is_alphanumeric     = try(each.value.is_alphanumeric, null)
}
