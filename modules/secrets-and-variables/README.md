# secrets-and-variables

Submodule for creating GitHub Actions variables and secrets for Actions, Codespaces and Dependabot.

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

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_codespaces_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/codespaces_secret) | resource |
| [github_dependabot_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The name of the repository. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | GitHub Actions secrets for this repository.<br/><br/>- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`.<br/>- `github_actions_environment_secret` resource will be created if `environment` key specified. | <pre>list(object({<br/>    subjects        = set(string)<br/>    environment     = optional(string)<br/>    secret_name     = string<br/>    encrypted_value = optional(string)<br/>    plaintext_value = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified. | <pre>list(object({<br/>    environment   = optional(string)<br/>    variable_name = string<br/>    value         = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions_environment_secrets"></a> [actions\_environment\_secrets](#output\_actions\_environment\_secrets) | Actions environment secrets. |
| <a name="output_actions_environment_variables"></a> [actions\_environment\_variables](#output\_actions\_environment\_variables) | Actions environment variables. |
| <a name="output_actions_secrets"></a> [actions\_secrets](#output\_actions\_secrets) | Actions secrets. |
| <a name="output_actions_variables"></a> [actions\_variables](#output\_actions\_variables) | Actions variables. |
| <a name="output_codespaces_secrets"></a> [codespaces\_secrets](#output\_codespaces\_secrets) | Codespaces secrets. |
| <a name="output_dependabot_secrets"></a> [dependabot\_secrets](#output\_dependabot\_secrets) | Dependabot secrets. |
<!-- END_TF_DOCS -->
