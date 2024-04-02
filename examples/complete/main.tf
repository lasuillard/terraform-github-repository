provider "github" {
  token = var.github_token
}

module "simple" {
  source = "../../"

  name = "simple"
}

module "disabled" {
  source = "../.."

  name   = "do-not-create"
  create = false
}

module "complete" {
  source = "../../"

  name                        = "complete"
  description                 = "An complete example repository."
  allow_auto_merge            = false
  allow_merge_commit          = true
  allow_rebase_merge          = true
  allow_update_branch         = null
  archive_on_destroy          = true
  delete_branch_on_merge      = false
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  visibility                  = "public"

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

  files = [
    {
      file    = ".github/pull_request_template.md"
      content = <<-EOT
Just an pull request template.

- [ ] Are you OK?
EOT
    }
  ]

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

  actions_secrets = [
    {
      secret_name     = "SENSITIVE_API_KEY"
      plaintext_value = "secret-for-all-env"
    },
    {
      environment     = "prod"
      secret_name     = "SENSITIVE_API_KEY"
      plaintext_value = "secret-for-prod-only"
    }
  ]

  actions_variables = [
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
