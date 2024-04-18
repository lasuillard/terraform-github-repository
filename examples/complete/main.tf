provider "github" {
  token = var.github_token
}

module "simple" {
  source = "../../"

  name                 = "simple"
  vulnerability_alerts = false
}

module "disabled" {
  source = "../../"

  create = false
  name   = "do-not-create"
}

module "complete" {
  source = "../../"

  name                        = "complete"
  description                 = "An complete example repository."
  visibility                  = "private"
  allow_auto_merge            = false
  allow_merge_commit          = true
  allow_rebase_merge          = true
  archive_on_destroy          = true
  delete_branch_on_merge      = false
  web_commit_signoff_required = true
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"

  pages = {
    source = {
      branch = "gh-pages"
      path   = "/docs"
    }
  }

  security_and_analysis = {
    advanced_security = {
      status = "enabled"
    }
    secret_scanning = {
      status = "enabled"
    }
  }

  topics = ["terraform", "github"]

  vulnerability_alerts = true
  allow_update_branch  = true

  files = [
    {
      file    = ".github/pull_request_template.md"
      content = <<-EOT
Just an pull request template.

- [ ] Are you OK?
EOT
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
      }
    }
  ]

  default_branch = "main"

  branches = {
    develop = {}
    gh-pages = {
      source_branch = "main"
    }
  }

  branch_protections = [
    {
      pattern                = "develop"
      require_signed_commits = true
    }
  ]

  rulesets = [
    {
      name        = "example"
      target      = "branch"
      enforcement = "active"

      conditions = {
        ref_name = {
          include = ["~ALL"]
          exclude = []
        }
      }

      rules = {
        creation                = true
        update                  = true
        deletion                = true
        required_linear_history = true
        required_signatures     = true

        required_deployments = {
          required_deployment_environments = ["test"]
        }
      }

      bypass_actors = [
        {
          actor_id    = 13473
          actor_type  = "Integration"
          bypass_mode = "always"
        }
      ]
    }
  ]

  tag_protections = ["v*"]

  actions_repository_access_level = "user"
  actions_repository_permissions = {
    allowed_actions = "all"
  }

  environments = {
    dev  = {}
    prod = {}
  }

  deployment_branch_policies = [
    {
      environment    = "dev"
      branch_pattern = "develop"
    },
    {
      environment    = "prod"
      branch_pattern = "main"
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

module "authoritatve" {
  source = "../../"

  name = "authoritative"

  collaborators = {
    authoritative = {
      users = [
        {
          username = "some-username"
        }
      ],
      teams = [
        {
          team_id = "some-team-id"
        }
      ]
    }
  }
  collaborators_authoritative = true

  issue_labels = [
    {
      name        = "Urgent"
      color       = "#FF0000"
      description = "Something urgent"
    }
  ]
  issue_labels_authoritative = true
}
