# actions

Submodule for managing GitHub Actions settings, secrets and variables, environments.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets_and_variables"></a> [secrets\_and\_variables](#module\_secrets\_and\_variables) | ../secrets-and-variables | n/a |

## Resources

| Name | Type |
|------|------|
| [github_actions_repository_access_level.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_access_level) | resource |
| [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_environment_deployment_policy.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_deploy_keys"></a> [deploy\_keys](#input\_deploy\_keys) | Deploy keys. | <pre>list(object({<br/>    key       = string<br/>    read_only = bool<br/>    title     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_deployment_branch_policies"></a> [deployment\_branch\_policies](#input\_deployment\_branch\_policies) | Deployment branch policies. | <pre>list(object({<br/>    environment    = string<br/>    branch_pattern = string<br/>  }))</pre> | `[]` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | List of GitHub repository environments. | <pre>map(object({<br/>    wait_timer          = optional(number)<br/>    can_admins_bypass   = optional(bool)<br/>    prevent_self_review = optional(bool)<br/>    reviewers = optional(object({<br/>      teams = optional(set(string))<br/>      users = optional(set(string))<br/>    }))<br/>    deployment_branch_policy = optional(object({<br/>      protected_branches     = bool<br/>      custom_branch_policies = bool<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The name of the repository. | `string` | n/a | yes |
| <a name="input_repository_access_level"></a> [repository\_access\_level](#input\_repository\_access\_level) | Where the actions or reusable workflows of the repository may be used. Possible values are `"none"`, `"user"`, `"organization"`, or `"enterprise"`.<br/><br/>If `null`, skip creation of `github_actions_repository_access_level` resource. | `string` | `null` | no |
| <a name="input_repository_permissions"></a> [repository\_permissions](#input\_repository\_permissions) | GitHub Actions permissions for a given repository. | <pre>object({<br/>    allowed_actions = optional(string)<br/>    enabled         = optional(bool)<br/>    allowed_actions_config = optional(object({<br/>      github_owned_allowed = bool<br/>      patterns_allowed     = optional(set(string))<br/>      verified_allowed     = optional(bool)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified. | <pre>list(object({<br/>    environment     = optional(string)<br/>    secret_name     = string<br/>    encrypted_value = optional(string)<br/>    plaintext_value = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified. | <pre>list(object({<br/>    environment   = optional(string)<br/>    variable_name = string<br/>    value         = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_level"></a> [access\_level](#output\_access\_level) | Actions repository access level. |
| <a name="output_deploy_keys"></a> [deploy\_keys](#output\_deploy\_keys) | Deploy keys. |
| <a name="output_environment_deployment_policies"></a> [environment\_deployment\_policies](#output\_environment\_deployment\_policies) | List of environment deployment policies. |
| <a name="output_environments"></a> [environments](#output\_environments) | List of repository environments. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | Actions repository permissions. |
| <a name="output_secrets_and_variables"></a> [secrets\_and\_variables](#output\_secrets\_and\_variables) | Actions secrets and variables. |
<!-- END_TF_DOCS -->
