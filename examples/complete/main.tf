provider "github" {
  token = var.github_token
}

module "complete" {
  source = "../../"

  create                      = var.create
  name                        = "complete"
  description                 = "An complete example repository."
  homepage_url                = "https://example.com"
  visibility                  = "private"
  has_issues                  = true
  has_discussions             = false
  has_projects                = false
  has_wiki                    = false
  is_template                 = false
  allow_merge_commit          = true
  allow_squash_merge          = true
  allow_rebase_merge          = true
  allow_auto_merge            = false
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  merge_commit_message        = "COMMIT_MESSAGES"
  merge_commit_title          = "COMMIT_OR_PR_TITLE"
  delete_branch_on_merge      = false
  web_commit_signoff_required = true
  has_downloads               = false
  auto_init                   = true
  gitignore_template          = "Terraform"
  license_template            = "mit"
  archived                    = false
  archive_on_destroy          = true

  pages = {
    source = {
      branch = "gh-pages"
      path   = "/docs"
    }
    build_type = "legacy"
    cname      = "example.com"
  }

  security_and_analysis = {
    advanced_security = {
      status = "enabled"
    }
    secret_scanning = {
      status = "enabled"
    }
    secret_scanning_push_protection = {
      status = "enabled"
    }
  }

  topics = ["terraform", "github"]

  vulnerability_alerts                    = true
  ignore_vulnerability_alerts_during_read = true
  allow_update_branch                     = true

  files = [
    {
      file                = ".github/pull_request_template.md"
      content             = <<-EOT
Just an pull request template.

- [ ] Are you OK?
EOT
      branch              = "main"
      commit_author       = "some-username"
      commit_email        = "some-email@example.com"
      commit_message      = "Add pull request template"
      overwrite_on_create = false
    }
  ]

  collaborators = {
    non_authoritative = [
      {
        username = "some-username"
      }
    ]
  }
  collaborators_authoritative = false

  webhooks = [
    {
      events = ["issue_comment"]
      configuration = {
        url          = "https://some.webhook.url/path/to/receiver"
        content_type = "json"
        secret       = "some-secret"
        insecure_ssl = false
      }
    }
  ]

  default_branch        = "main"
  default_branch_rename = false

  branches = {
    develop = {}
    gh-pages = {
      source_branch = "main"
    }
  }

  branch_protections = [
    {
      pattern                         = "develop"
      enforce_admins                  = true
      require_signed_commits          = true
      required_linear_history         = false
      require_conversation_resolution = true
      required_status_checks = {
        strict   = true
        contexts = ["ci/circleci"]
      }
      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        restrict_dismissals             = true
        dismissal_restrictions          = ["/some-username", "my-org/team"]
        pull_request_bypassers          = ["/some-username"]
        require_code_owner_reviews      = true
        required_approving_review_count = 2
        require_last_push_approval      = true
      }
      restrict_pushes = {
        blocks_creations = false
        push_allowances  = ["/some-username"]
      }
      force_push_bypassers = ["/some-username"]
      allows_deletions     = false
      allows_force_pushes  = false
      lock_branch          = false
    }
  ]

  rulesets = [
    {
      enforcement = "active"
      name        = "example"
      rules = {
        branch_name_pattern = {
          operator = "regex"
          pattern  = "^(feature|bugfix)/"
          name     = "branch-name-pattern"
          negate   = false
        }
        commit_author_email_pattern = {
          operator = "regex"
          pattern  = ".*@example.com"
          name     = "commit-author-email-pattern"
          negate   = false
        }
        commit_message_pattern = {
          operator = "regex"
          pattern  = "^(feat|fix|chore|docs|style|refactor|perf|test|build|ci|chore|revert):"
          name     = "commit-message-pattern"
          negate   = false
        }
        committer_email_pattern = {
          operator = "regex"
          pattern  = ".*@example.com"
          name     = "commit-email-pattern"
          negate   = false
        }
        creation         = true
        deletion         = true
        non_fast_forward = true
        pull_request = {
          dismiss_stale_reviews_on_push     = true
          require_code_owner_review         = true
          require_last_push_approval        = true
          required_approving_review_count   = 2
          required_review_thread_resolution = true
        }
        required_deployments = {
          required_deployment_environments = ["test"]
        }
        required_linear_history = true
        required_signatures     = true
        required_status_checks = {
          required_check = [
            {
              context        = "ci/circleci"
              integration_id = 13473
            }
          ]
          strict_required_status_checks_policy = true
        }
        tag_name_pattern = {
          operator = "regex"
          pattern  = "^v[0-9]+"
          name     = "tag-name-pattern"
          negate   = false
        }
        update                        = true
        update_allows_fetch_and_merge = true
      }
      target = "branch"
      bypass_actors = [
        {
          actor_id    = 13473
          actor_type  = "Integration"
          bypass_mode = "always"
        }
      ]
      conditions = {
        ref_name = {
          exclude = []
          include = ["~ALL"]
        }
      }
    }
  ]

  actions_repository_access_level = "user"
  actions_repository_permissions = {
    allowed_actions = "all"
    enabled         = true
    allowed_actions_config = {
      github_owned_allowed = true
      patterns_allowed     = ["actions/cache@*", "actions/checkout@*"]
      verified_allowed     = true
    }
  }

  environments = {
    prod = {
      wait_timer          = 10
      can_admins_bypass   = false
      prevent_self_review = true
      reviewers = {
        teams = ["my-org/team"]
        users = ["/some-username"]
      }
      deployment_branch_policy = {
        protected_branches     = true
        custom_branch_policies = true
      }
    }
  }

  deployment_branch_policies = [
    {
      environment    = "prod"
      branch_pattern = "main"
    }
  ]

  deploy_keys = [
    {
      title     = "Deploy Key"
      key       = "some-ssh-key"
      read_only = true
    }
  ]

  secrets = [
    {
      subjects        = ["actions", "codespaces", "dependabot"]
      secret_name     = "SENSITIVE_API_KEY"
      plaintext_value = "secret-for-all-env"
    },
    {
      subjects        = ["actions"]
      environment     = "prod"
      secret_name     = "SENSITIVE_API_KEY"
      plaintext_value = "secret-for-prod-only"
    }
  ]

  variables = [
    {
      variable_name = "SOME_VAR"
      value         = "sweet-potato"
    },
    {
      environment   = "prod"
      variable_name = "SOME_VAR"
      value         = "potato-chips"
    }
  ]

  dependabot_security_updates_enabled = true

  issue_labels = [
    {
      name        = "Urgent"
      color       = "#FF0000"
      description = "Something urgent"
    }
  ]
  issue_labels_authoritative = false

  autolink_references = [
    {
      key_prefix          = "JIRA-"
      target_url_template = "https://domain.jira/?issue_key=<num>"
      is_alphanumeric     = false
    }
  ]
}
