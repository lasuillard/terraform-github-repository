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
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.1 |

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
| <a name="input_actions_secrets"></a> [actions\_secrets](#input\_actions\_secrets) | GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified. | <pre>list(object({<br>    environment     = optional(string)<br>    secret_name     = string<br>    encrypted_value = optional(string)<br>    plaintext_value = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_actions_variables"></a> [actions\_variables](#input\_actions\_variables) | GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified. | <pre>list(object({<br>    environment   = optional(string)<br>    variable_name = string<br>    value         = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_codespaces_secrets"></a> [codespaces\_secrets](#input\_codespaces\_secrets) | Codespaces secrets for this repository. | <pre>list(object({<br>    environment     = optional(string)<br>    secret_name     = string<br>    encrypted_value = optional(string)<br>    plaintext_value = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_dependabot_secrets"></a> [dependabot\_secrets](#input\_dependabot\_secrets) | Dependabot secrets for this repository. | <pre>list(object({<br>    environment     = optional(string)<br>    secret_name     = string<br>    encrypted_value = optional(string)<br>    plaintext_value = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The name of the repository. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
