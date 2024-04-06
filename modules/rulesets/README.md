# rulesets

Submodule for repository rulesets.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_ruleset.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The name of the repository. | `string` | n/a | yes |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | Repository rulesets. | <pre>list(object({<br>    enforcement = string<br>    name        = string<br>    rules = object({<br>      branch_name_pattern = optional(object({<br>        operator = string<br>        pattern  = string<br>        name     = optional(string)<br>        negate   = optional(bool)<br>      }))<br>      commit_author_email_pattern = optional(object({<br>        operator = string<br>        pattern  = string<br>        name     = optional(string)<br>        negate   = optional(bool)<br>      }))<br>      commit_message_pattern = optional(object({<br>        operator = string<br>        pattern  = string<br>        name     = optional(string)<br>        negate   = optional(bool)<br>      }))<br>      committer_email_pattern = optional(object({<br>        operator = string<br>        pattern  = string<br>        name     = optional(string)<br>        negate   = optional(bool)<br>      }))<br>      creation         = optional(bool)<br>      deletion         = optional(bool)<br>      non_fast_forward = optional(bool)<br>      pull_request = optional(object({<br>        dismiss_stale_reviews_on_push     = optional(bool)<br>        require_code_owner_review         = optional(bool)<br>        require_last_push_approval        = optional(bool)<br>        required_approving_review_count   = optional(number)<br>        required_review_thread_resolution = optional(bool)<br>      }))<br>      required_deployments = optional(object({<br>        required_deployment_environments = set(string)<br>      }))<br>      required_linear_history = optional(bool)<br>      required_signatures     = optional(bool)<br>      required_status_checks = optional(object({<br>        required_check = list(object({<br>          context        = string<br>          integration_id = optional(number)<br>        }))<br>        strict_required_status_checks_policy = optional(bool)<br>      }))<br>      tag_name_pattern = optional(object({<br>        operator = string<br>        pattern  = string<br>        name     = optional(string)<br>        negate   = optional(bool)<br>      }))<br>      update                        = optional(bool)<br>      update_allows_fetch_and_merge = optional(bool)<br>    })<br>    target = string<br>    bypass_actors = optional(list(object({<br>      actor_id    = number<br>      actor_type  = string<br>      bypass_mode = optional(string)<br>    })))<br>    conditions = optional(object({<br>      ref_name = object({<br>        exclude = set(string)<br>        include = set(string)<br>      })<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rulesets"></a> [rulesets](#output\_rulesets) | Repository rulesets. |
<!-- END_TF_DOCS -->
