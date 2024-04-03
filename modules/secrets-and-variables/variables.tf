variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "repository" {
  description = "The name of the repository."
  type        = string
}

variable "secrets" {
  description = <<-EOT
GitHub Actions secrets for this repository.

- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`.
- `github_actions_environment_secret` resource will be created if `environment` key specified.
EOT
  type = list(object({
    subjects        = set(string)
    environment     = optional(string)
    secret_name     = string
    encrypted_value = optional(string)
    plaintext_value = optional(string)
  }))
  default = []
}

variable "variables" {
  description = "GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified."
  type = list(object({
    environment   = optional(string)
    variable_name = string
    value         = optional(string)
  }))
  default = []
}
