variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the repository."
  type        = string
}

variable "description" {
  description = "A description of the repository."
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "URL of a page describing the project."
  type        = string
  default     = null
}

variable "visibility" {
  description = <<-EOT
Can be `"public"` or `"private"`.

If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be `"internal"`.
The `visibility` parameter overrides the `private` parameter."
EOT
  type        = string
  default     = "private"
}

variable "has_issues" {
  description = "Set to `true` to enable the GitHub Issues features on the repository."
  type        = bool
  default     = true
}

variable "has_discussions" {
  description = "Set to `true` to enable GitHub Discussions on the repository."
  type        = bool
  default     = false
}

variable "has_projects" {
  description = <<-EOT
Set to true to enable the GitHub Projects features on the repository.

Per the GitHub documentation when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`.
If you specify `true` when it has been disabled it will return an error.
EOT
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Set to `true` to enable the GitHub Wiki features on the repository."
  type        = bool
  default     = false
}

variable "is_template" {
  description = "Set to `true` to tell GitHub that this is a template repository."
  type        = bool
  default     = false
}

variable "allow_merge_commit" {
  description = "Set to `false` to disable merge commits on the repository."
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Set to `false` to disable squash merges on the repository."
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Set to `false` to disable rebase merges on the repository."
  type        = bool
  default     = true
}

variable "allow_auto_merge" {
  description = "Set to `true` to allow auto-merging pull requests on the repository."
  type        = bool
  default     = false
}

variable "squash_merge_commit_title" {
  description = <<-EOT
Can be `"PR_TITLE"` or `"COMMIT_OR_PR_TITLE"` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`.
EOT
  type        = string
  default     = null
}

variable "squash_merge_commit_message" {
  description = <<-EOT
Can be `"PR_BODY"`, `"COMMIT_MESSAGES"`, or `"BLANK"` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`.
EOT
  type        = string
  default     = null
}

variable "merge_commit_title" {
  description = <<-EOT
Can be `"PR_TITLE"` or `"MERGE_MESSAGE"` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`.
EOT
  type        = string
  default     = null
}

variable "merge_commit_message" {
  description = <<-EOT
Can be `"PR_BODY"`, `"PR_TITLE"`, or `"BLANK"` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`.
EOT
  type        = string
  default     = null
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branch after a pull request is merged."
  type        = bool
  default     = false
}

variable "web_commit_signoff_required" {
  description = "Require contributors to sign off on web-based commits. See more here."
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Set to `true` to enable the (deprecated) downloads features on the repository."
  type        = bool
  default     = null
}

variable "auto_init" {
  description = "Set to `true` to produce an initial commit in the repository."
  type        = bool
  default     = null
}

variable "gitignore_template" {
  description = <<-EOT
Use the name of the template without the extension. For example, `"Haskell"`.
EOT
  type        = string
  default     = null
}

variable "license_template" {
  description = <<-EOT
Use the name of the template without the extension. For example, `"mit"` or `"mpl-2.0"`.
EOT
  type        = string
  default     = null
}

variable "archived" {
  description = <<-EOT
Specifies if the repository should be archived.

NOTE Currently, the API does not support unarchiving.
EOT
  type        = bool
  default     = false
}

variable "archive_on_destroy" {
  description = "Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = true
}

variable "pages" {
  description = <<-EOT
The repository's GitHub Pages configuration.

See [GitHub Pages Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#github-pages-configuration) for details.
EOT
  type = object({
    source = optional(object({
      branch = string
      path   = optional(string)
    }))
    build_type = optional(string)
    cname      = optional(string)
  })
  nullable = true
  default  = null
}

variable "security_and_analysis" {
  description = <<-EOT
The repository's security and analysis configuration.

See [Security and Analysis Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#security-and-analysis-configuration) for details.
EOT
  type = object({
    advanced_security = optional(object({
      status = string
    }))
    secret_scanning = optional(object({
      status = string
    }))
    secret_scanning_push_protection = optional(object({
      status = string
    }))
  })
  nullable = true
  default  = null
}

variable "topics" {
  description = <<-EOT
The list of topics of the repository.

NOTE: This attribute is not compatible with the `github_repository_topics` resource. Use one of them.
`github_repository_topics` is only meant to be used if the repository itself is not handled via terraform, for example if it's only read as a datasource (see issue [#1845](https://github.com/integrations/terraform-provider-github/issues/1845)).
EOT
  type        = set(string)
  default     = null
}

variable "template" {
  description = <<-EOT
Use a template repository to create this resource.

See [Template Repositories](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#template-repositories) for details.
EOT
  type = object({
    owner                = string
    repository           = string
    include_all_branches = optional(bool)
  })
  nullable = true
  default  = null
}

variable "vulnerability_alerts" {
  description = <<-EOT
Set to `true` to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.) See GitHub Documentation for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings.
EOT
  type        = bool
  default     = true
}

variable "ignore_vulnerability_alerts_during_read" {
  description = "Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read."
  type        = bool
  default     = null
}

variable "allow_update_branch" {
  description = "Set to `true` to always suggest updating pull request branches."
  type        = bool
  default     = null
}

variable "files" {
  description = "Repository files."
  type = list(object({
    file                = string
    content             = string
    branch              = optional(string)
    commit_author       = optional(string)
    commit_email        = optional(string)
    commit_message      = optional(string)
    overwrite_on_create = optional(bool)
  }))
  default = []
}

variable "collaborators" {
  description = "List of collaboratos."
  type = object({
    non_authoritative = optional(list(object({
      username                    = string
      permission                  = optional(string)
      permission_diff_suppression = optional(bool)
    })))
    authoritative = optional(object({
      users = optional(list(object({
        username   = string
        permission = optional(string)
      })))
      teams = optional(list(object({
        team_id    = string
        permission = optional(string)
      })))
    }))
  })
  default = {}
}

variable "collaborators_authoritative" {
  description = "Whether collaborators should be managed in authoritative way. If set `true`, `github_repository_collaborators` resource will be used."
  type        = bool
  default     = false
}

variable "webhooks" {
  description = "List of webhooks."
  type = list(object({
    events = set(string)
    configuration = object({
      url          = string
      content_type = string
      secret       = optional(string)
      insecure_ssl = optional(bool)
    })
    active = optional(bool)
  }))
  default = []
}

variable "codespaces_secrets" {
  description = "Codespaces secrets for this repository."
  type = list(object({
    environment     = optional(string)
    secret_name     = string
    encrypted_value = optional(string)
    plaintext_value = optional(string)
  }))
  default = []
}

variable "dependabot_secrets" {
  description = "Dependabot secrets for this repository."
  type = list(object({
    environment     = optional(string)
    secret_name     = string
    encrypted_value = optional(string)
    plaintext_value = optional(string)
  }))
  default = []
}

# Branches & Tags
# ============================================================================
variable "default_branch" {
  description = "The name of the default branch of the repository."
  type        = string
  default     = "main"
}

variable "default_branch_rename" {
  description = "Indicate if it should rename the branch rather than use an existing branch."
  type        = bool
  default     = false
}

variable "branches" {
  description = "Map of branch name and configuration to create."
  type = map(object({
    source_branch = optional(string)
    source_sha    = optional(string)
  }))
  default = {}
}

variable "branch_protections" {
  description = "Branch protection rules."
  type = list(object({
    pattern                         = string
    enforce_admins                  = optional(bool)
    require_signed_commits          = optional(bool)
    required_linear_history         = optional(bool)
    require_conversation_resolution = optional(bool)
    required_status_checks = optional(object({
      strict   = optional(bool)
      contexts = optional(set(string))
    }))
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool)
      restrict_dismissals             = optional(bool)
      dismissal_restrictions          = optional(set(string))
      pull_request_bypassers          = optional(set(string))
      require_code_owner_reviews      = optional(bool)
      required_approving_review_count = optional(number)
      require_last_push_approval      = optional(bool)
    }))
    restrict_pushes = optional(object({
      blocks_creations = optional(bool)
      push_allowances  = optional(set(string))
    }))
    force_push_bypassers = optional(set(string))
    allows_deletions     = optional(bool)
    allows_force_pushes  = optional(bool)
    lock_branch          = optional(bool)
  }))
  default = []
}

variable "rulesets" {
  description = "Repository rulesets."
  type = list(object({
    enforcement = string
    name        = string
    rules = object({
      branch_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_author_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_message_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      committer_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      creation         = optional(bool)
      deletion         = optional(bool)
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
      }))
      required_deployments = optional(object({
        required_deployment_environments = set(string)
      }))
      required_linear_history = optional(bool)
      required_signatures     = optional(bool)
      required_status_checks = optional(object({
        required_check = list(object({
          context        = string
          integration_id = optional(number)
        }))
        strict_required_status_checks_policy = optional(bool)
      }))
      tag_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      update                        = optional(bool)
      update_allows_fetch_and_merge = optional(bool)
    })
    target = string
    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = string
      bypass_mode = optional(string)
    })))
    conditions = optional(object({
      ref_name = object({
        exclude = set(string)
        include = set(string)
      })
    }))
  }))
  default = []
}

variable "tag_protections" {
  description = "Tag protection rules."
  type        = list(string)
  default     = []
}

# GitHub Actions
# ============================================================================
variable "actions_repository_access_level" {
  description = <<-EOT
Where the actions or reusable workflows of the repository may be used. Possible values are `"none"`, `"user"`, `"organization"`, or `"enterprise"`.

If `null`, skip creation of `github_actions_repository_access_level` resource.
EOT
  type        = string
  nullable    = true
  default     = null
}

variable "actions_repository_permissions" {
  description = "GitHub Actions permissions for a given repository."
  type = object({
    allowed_actions = optional(string)
    enabled         = optional(bool)
    allowed_actions_config = optional(object({
      github_owned_allowed = bool
      patterns_allowed     = optional(set(string))
      verified_allowed     = optional(bool)
    }))
  })
  nullable = true
  default  = null
}

variable "environments" {
  description = "List of GitHub repository environments."
  type = map(object({
    wait_timer          = optional(number)
    can_admins_bypass   = optional(bool)
    prevent_self_review = optional(bool)
    reviewers = optional(object({
      teams = optional(set(string))
      users = optional(set(string))
    }))
    deployment_branch_policy = optional(object({
      protected_branches     = bool
      custom_branch_policies = bool
    }))
  }))
  default = {}
}

variable "deployment_branch_policies" {
  description = "Deployment branch policies."
  type = list(object({
    environment    = string
    branch_pattern = string
  }))
  default = []
}

variable "deploy_keys" {
  description = "Deploy keys."
  type = list(object({
    key       = string
    read_only = bool
    title     = string
  }))
  default = []
}

variable "actions_secrets" {
  description = "GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified."
  type = list(object({
    environment     = optional(string)
    secret_name     = string
    encrypted_value = optional(string)
    plaintext_value = optional(string)
  }))
  default = []
}

variable "actions_variables" {
  description = "GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified."
  type = list(object({
    environment   = optional(string)
    variable_name = string
    value         = optional(string)
  }))
  default = []
}

# Dependabot
# ============================================================================
variable "dependabot_security_updates_enabled" {
  description = "Whether to enable Dependabot security updates."
  type        = bool
  default     = false
}

# Issues and Pull Requests
# ============================================================================
variable "issue_labels" {
  description = "Issue labels. Starting prefix \"#\" in `color` will be ignored."
  type = list(object({
    name        = string
    color       = string
    description = optional(string)
  }))
  default = []
}

variable "issue_labels_authoritative" {
  description = "Whether issue labels managed in authoritative ways. If `true`, issue labels will be created using `github_issue_labels` resource type, possibly causing all the labels not listed removed."
  type        = bool
  default     = false
}

variable "autolink_references" {
  description = "Autolink references."
  type = list(object({
    key_prefix          = string
    target_url_template = string
    is_alphanumeric     = optional(bool)
  }))
  default = []
}
