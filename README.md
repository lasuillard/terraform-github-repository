# terraform-github-repository

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/lasuillard/terraform-github-repository/actions/workflows/ci.yaml/badge.svg)](https://github.com/lasuillard/terraform-github-repository/actions/workflows/ci.yaml)
![GitHub Release](https://img.shields.io/github/v/release/lasuillard/terraform-github-repository)

Terraform module to create GitHub repository and relevant resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_actions"></a> [actions](#module\_actions) | ./modules/actions | n/a |
| <a name="module_rulesets"></a> [rulesets](#module\_rulesets) | ./modules/rulesets | n/a |
| <a name="module_secrets_and_variables"></a> [secrets\_and\_variables](#module\_secrets\_and\_variables) | ./modules/secrets-and-variables | n/a |

## Resources

| Name | Type |
|------|------|
| [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_issue_label.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_labels.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_autolink_reference.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_autolink_reference) | resource |
| [github_repository_collaborator.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_dependabot_security_updates.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates) | resource |
| [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_repository_access_level"></a> [actions\_repository\_access\_level](#input\_actions\_repository\_access\_level) | Where the actions or reusable workflows of the repository may be used. Possible values are `"none"`, `"user"`, `"organization"`, or `"enterprise"`.<br/><br/>If `null`, skip creation of `github_actions_repository_access_level` resource. | `string` | `null` | no |
| <a name="input_actions_repository_permissions"></a> [actions\_repository\_permissions](#input\_actions\_repository\_permissions) | GitHub Actions permissions for a given repository. | <pre>object({<br/>    allowed_actions = optional(string)<br/>    enabled         = optional(bool)<br/>    allowed_actions_config = optional(object({<br/>      github_owned_allowed = bool<br/>      patterns_allowed     = optional(set(string))<br/>      verified_allowed     = optional(bool)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Set to `true` to allow auto-merging pull requests on the repository. | `bool` | `false` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | Set to `false` to disable merge commits on the repository. | `bool` | `true` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | Set to `false` to disable rebase merges on the repository. | `bool` | `true` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | Set to `false` to disable squash merges on the repository. | `bool` | `true` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | Set to `true` to always suggest updating pull request branches. | `bool` | `null` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Set to `true` to archive the repository instead of deleting on destroy. | `bool` | `true` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | Specifies if the repository should be archived.<br/><br/>**NOTE** Currently, the API does not support unarchiving. | `bool` | `false` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | Set to `true` to produce an initial commit in the repository. | `bool` | `null` | no |
| <a name="input_autolink_references"></a> [autolink\_references](#input\_autolink\_references) | Autolink references. | <pre>list(object({<br/>    key_prefix          = string<br/>    target_url_template = string<br/>    is_alphanumeric     = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_branch_protections"></a> [branch\_protections](#input\_branch\_protections) | Branch protection rules. | <pre>list(object({<br/>    pattern                         = string<br/>    enforce_admins                  = optional(bool)<br/>    require_signed_commits          = optional(bool)<br/>    required_linear_history         = optional(bool)<br/>    require_conversation_resolution = optional(bool)<br/>    required_status_checks = optional(object({<br/>      strict   = optional(bool)<br/>      contexts = optional(set(string))<br/>    }))<br/>    required_pull_request_reviews = optional(object({<br/>      dismiss_stale_reviews           = optional(bool)<br/>      restrict_dismissals             = optional(bool)<br/>      dismissal_restrictions          = optional(set(string))<br/>      pull_request_bypassers          = optional(set(string))<br/>      require_code_owner_reviews      = optional(bool)<br/>      required_approving_review_count = optional(number)<br/>      require_last_push_approval      = optional(bool)<br/>    }))<br/>    restrict_pushes = optional(object({<br/>      blocks_creations = optional(bool)<br/>      push_allowances  = optional(set(string))<br/>    }))<br/>    force_push_bypassers = optional(set(string))<br/>    allows_deletions     = optional(bool)<br/>    allows_force_pushes  = optional(bool)<br/>    lock_branch          = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | Map of branch name and configuration to create. | <pre>map(object({<br/>    source_branch = optional(string)<br/>    source_sha    = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_collaborators"></a> [collaborators](#input\_collaborators) | List of collaboratos. | <pre>object({<br/>    non_authoritative = optional(list(object({<br/>      username                    = string<br/>      permission                  = optional(string)<br/>      permission_diff_suppression = optional(bool)<br/>    })))<br/>    authoritative = optional(object({<br/>      users = optional(list(object({<br/>        username   = string<br/>        permission = optional(string)<br/>      })))<br/>      teams = optional(list(object({<br/>        team_id    = string<br/>        permission = optional(string)<br/>      })))<br/>    }))<br/>  })</pre> | `{}` | no |
| <a name="input_collaborators_authoritative"></a> [collaborators\_authoritative](#input\_collaborators\_authoritative) | Whether collaborators should be managed in authoritative way. If set `true`, `github_repository_collaborators` resource will be used. | `bool` | `false` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The name of the default branch of the repository. | `string` | `"main"` | no |
| <a name="input_default_branch_rename"></a> [default\_branch\_rename](#input\_default\_branch\_rename) | Indicate if it should rename the branch rather than use an existing branch. | `bool` | `false` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | Automatically delete head branch after a pull request is merged. | `bool` | `false` | no |
| <a name="input_dependabot_security_updates_enabled"></a> [dependabot\_security\_updates\_enabled](#input\_dependabot\_security\_updates\_enabled) | Whether to enable Dependabot security updates. | `bool` | `false` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | Deploy keys. | <pre>list(object({<br/>    key       = string<br/>    read_only = bool<br/>    title     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_deployment_branch_policies"></a> [deployment\_branch\_policies](#input\_deployment\_branch\_policies) | Deployment branch policies. | <pre>list(object({<br/>    environment    = string<br/>    branch_pattern = string<br/>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the repository. | `string` | `null` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | List of GitHub repository environments. | <pre>map(object({<br/>    wait_timer          = optional(number)<br/>    can_admins_bypass   = optional(bool)<br/>    prevent_self_review = optional(bool)<br/>    reviewers = optional(object({<br/>      teams = optional(set(string))<br/>      users = optional(set(string))<br/>    }))<br/>    deployment_branch_policy = optional(object({<br/>      protected_branches     = bool<br/>      custom_branch_policies = bool<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_files"></a> [files](#input\_files) | Repository files. | <pre>list(object({<br/>    file                = string<br/>    content             = string<br/>    branch              = optional(string)<br/>    commit_author       = optional(string)<br/>    commit_email        = optional(string)<br/>    commit_message      = optional(string)<br/>    overwrite_on_create = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | Use the [name of the template](https://github.com/github/gitignore) without the extension. For example, `"Haskell"`. | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Set to `true` to enable GitHub Discussions on the repository. | `bool` | `false` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | Set to `true` to enable the (deprecated) downloads features on the repository. | `bool` | `null` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Set to `true` to enable the GitHub Issues features on the repository. | `bool` | `true` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Set to `true` to enable the GitHub Projects features on the repository.<br/><br/>Per the GitHub [documentation](https://developer.github.com/v3/repos/#create) when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`.<br/>If you specify `true` when it has been disabled it will return an error. | `bool` | `false` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Set to `true` to enable the GitHub Wiki features on the repository. | `bool` | `false` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | URL of a page describing the project. | `string` | `null` | no |
| <a name="input_ignore_vulnerability_alerts_during_read"></a> [ignore\_vulnerability\_alerts\_during\_read](#input\_ignore\_vulnerability\_alerts\_during\_read) | Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read. | `bool` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Set to `true` to tell GitHub that this is a template repository. | `bool` | `false` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | Issue labels. Starting prefix "#" in `color` will be ignored. | <pre>list(object({<br/>    name        = string<br/>    color       = string<br/>    description = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_issue_labels_authoritative"></a> [issue\_labels\_authoritative](#input\_issue\_labels\_authoritative) | Whether issue labels managed in authoritative ways. If `true`, issue labels will be created using `github_issue_labels` resource type, possibly causing all the labels not listed removed. | `bool` | `false` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | Use the [name of the template](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses) without the extension. For example, `"mit"` or `"mpl-2.0"`. | `string` | `null` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | Can be `"PR_BODY"`, `"PR_TITLE"`, or `"BLANK"` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | Can be `"PR_TITLE"` or `"MERGE_MESSAGE"` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_pages"></a> [pages](#input\_pages) | The repository's GitHub Pages configuration.<br/><br/>See [GitHub Pages Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#github-pages-configuration) for details. | <pre>object({<br/>    source = optional(object({<br/>      branch = string<br/>      path   = optional(string)<br/>    }))<br/>    build_type = optional(string)<br/>    cname      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | Repository rulesets. | <pre>list(object({<br/>    enforcement = string<br/>    name        = string<br/>    rules = object({<br/>      branch_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_author_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_message_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      committer_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      creation         = optional(bool)<br/>      deletion         = optional(bool)<br/>      non_fast_forward = optional(bool)<br/>      pull_request = optional(object({<br/>        dismiss_stale_reviews_on_push     = optional(bool)<br/>        require_code_owner_review         = optional(bool)<br/>        require_last_push_approval        = optional(bool)<br/>        required_approving_review_count   = optional(number)<br/>        required_review_thread_resolution = optional(bool)<br/>      }))<br/>      required_deployments = optional(object({<br/>        required_deployment_environments = set(string)<br/>      }))<br/>      required_linear_history = optional(bool)<br/>      required_signatures     = optional(bool)<br/>      required_status_checks = optional(object({<br/>        required_check = list(object({<br/>          context        = string<br/>          integration_id = optional(number)<br/>        }))<br/>        strict_required_status_checks_policy = optional(bool)<br/>      }))<br/>      tag_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      update                        = optional(bool)<br/>      update_allows_fetch_and_merge = optional(bool)<br/>    })<br/>    target = string<br/>    bypass_actors = optional(list(object({<br/>      actor_id    = number<br/>      actor_type  = string<br/>      bypass_mode = optional(string)<br/>    })))<br/>    conditions = optional(object({<br/>      ref_name = object({<br/>        exclude = set(string)<br/>        include = set(string)<br/>      })<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | GitHub Actions secrets for this repository.<br/><br/>- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`.<br/>- `github_actions_environment_secret` resource will be created if `environment` key specified. | <pre>list(object({<br/>    subjects        = set(string)<br/>    environment     = optional(string)<br/>    secret_name     = string<br/>    encrypted_value = optional(string)<br/>    plaintext_value = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_security_and_analysis"></a> [security\_and\_analysis](#input\_security\_and\_analysis) | The repository's [security and analysis](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository) configuration.<br/><br/>See [Security and Analysis Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#security-and-analysis-configuration) for details. | <pre>object({<br/>    advanced_security = optional(object({<br/>      status = string<br/>    }))<br/>    secret_scanning = optional(object({<br/>      status = string<br/>    }))<br/>    secret_scanning_push_protection = optional(object({<br/>      status = string<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | Can be `"PR_BODY"`, `"COMMIT_MESSAGES"`, or `"BLANK"` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | Can be `"PR_TITLE"` or `"COMMIT_OR_PR_TITLE"` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_template"></a> [template](#input\_template) | Use a template repository to create this resource.<br/><br/>See [Template Repositories](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#template-repositories) for details. | <pre>object({<br/>    owner                = string<br/>    repository           = string<br/>    include_all_branches = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | The list of topics of the repository.<br/><br/>NOTE: This attribute is not compatible with the `github_repository_topics` resource. Use one of them.<br/>`github_repository_topics` is only meant to be used if the repository itself is not handled via terraform, for example if it's only read as a datasource (see issue [#1845](https://github.com/integrations/terraform-provider-github/issues/1845)). | `set(string)` | `null` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified. | <pre>list(object({<br/>    environment   = optional(string)<br/>    variable_name = string<br/>    value         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Can be `"public"` or `"private"`.<br/><br/>If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be `"internal"`.<br/>The `visibility` parameter overrides the `private` parameter." | `string` | `"private"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Set to `true` to enable security alerts for vulnerable dependencies.<br/><br/>Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.)<br/>See [GitHub Documentation](https://help.github.com/en/github/managing-security-vulnerabilities/about-security-alerts-for-vulnerable-dependencies) for details.<br/>Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings. | `bool` | `true` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | Require contributors to sign off on web-based commits. See more [here](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/managing-the-commit-signoff-policy-for-your-repository). | `bool` | `false` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | List of webhooks. | <pre>list(object({<br/>    events = set(string)<br/>    configuration = object({<br/>      url          = string<br/>      content_type = string<br/>      secret       = optional(string)<br/>      insecure_ssl = optional(bool)<br/>    })<br/>    active = optional(bool)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions"></a> [actions](#output\_actions) | GitHub Actions module outputs. |
| <a name="output_autolink_references"></a> [autolink\_references](#output\_autolink\_references) | Autolink references. |
| <a name="output_branch_default"></a> [branch\_default](#output\_branch\_default) | Default branch name. |
| <a name="output_branch_protections"></a> [branch\_protections](#output\_branch\_protections) | Branch protection rules. |
| <a name="output_branches"></a> [branches](#output\_branches) | Branches in repository. |
| <a name="output_collaborators"></a> [collaborators](#output\_collaborators) | List of repository collaborators. |
| <a name="output_dependabot_security_updates_enabled"></a> [dependabot\_security\_updates\_enabled](#output\_dependabot\_security\_updates\_enabled) | Whether dependabot security updates enabled for this repository. |
| <a name="output_files"></a> [files](#output\_files) | Files managed by this module. |
| <a name="output_issue_labels"></a> [issue\_labels](#output\_issue\_labels) | Repository issue labels. |
| <a name="output_repository"></a> [repository](#output\_repository) | Repository details. |
| <a name="output_rulesets"></a> [rulesets](#output\_rulesets) | Repository rulesets. |
| <a name="output_secrets_and_variables"></a> [secrets\_and\_variables](#output\_secrets\_and\_variables) | Repository Actions, Codespaces and Dependabot secrets and variables. |
| <a name="output_webhooks"></a> [webhooks](#output\_webhooks) | Repository webhooks. |
<!-- END_TF_DOCS -->
