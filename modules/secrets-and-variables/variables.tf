variable "repository" {
  description = "The name of the repository."
  type        = string
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
