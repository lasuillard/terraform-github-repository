resource "github_repository" "this" {
  count = var.create ? 1 : 0

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

resource "github_branch_default" "this" {
  repository = github_repository.this[0].name
  branch     = var.default_branch
  rename     = var.default_branch_rename
}

resource "github_actions_secret" "this" {
  for_each = {
    for v in var.actions_secrets : v.secret_name => v
    if !contains(keys(v), "environment")
  }

  repository      = github_repository.this[0].name
  secret_name     = each.value.secret_name
  encrypted_value = lookup(each.value, "encrypted_value", null)
  plaintext_value = lookup(each.value, "plaintext_value", null)
}

resource "github_actions_environment_secret" "this" {
  for_each = {
    for v in var.actions_secrets : "${v.environment}/${v.secret_name}" => v
    if contains(keys(v), "environment")
  }

  repository      = github_repository.this[0].name
  environment     = each.value.environment
  secret_name     = each.value.secret_name
  encrypted_value = lookup(each.value, "encrypted_value", null)
  plaintext_value = lookup(each.value, "plaintext_value", null)
}

resource "github_actions_variable" "this" {
  for_each = {
    for v in var.actions_variables : v.variable_name => v
    if !contains(keys(v), "environment")
  }

  repository    = github_repository.this[0].name
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_actions_environment_variable" "this" {
  for_each = {
    for v in var.actions_variables : "${v.environment}/${v.variable_name}" => v
    if contains(keys(v), "environment")
  }

  repository    = github_repository.this[0].name
  environment   = each.value.environment
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_repository_file" "this" {
  for_each = { for v in var.files : v.file => v }

  repository          = github_repository.this[0].name
  branch              = lookup(each.value, "branch", github_branch_default.this.branch)
  file                = each.value.file
  content             = each.value.content
  commit_message      = lookup(each.value, "commit_message", null)
  commit_author       = lookup(each.value, "commit_author", null)
  commit_email        = lookup(each.value, "commit_email", null)
  overwrite_on_create = lookup(each.value, "overwrite_on_create", false)
}

resource "github_issue_label" "this" {
  for_each = { for v in(var.issue_labels_authoritative ? [] : var.issue_labels) : v.name => v }

  repository = github_repository.this[0].name

  name        = each.value.name
  description = lookup(each.value, "description", null)
  color       = trimprefix(each.value.color, "#")
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
