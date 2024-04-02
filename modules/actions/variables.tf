variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "repository" {
  description = "The name of the repository."
  type        = string
}

variable "repository_access_level" {
  description = <<-EOT
Where the actions or reusable workflows of the repository may be used. Possible values are `"none"`, `"user"`, `"organization"`, or `"enterprise"`.

If `null`, skip creation of `github_actions_repository_access_level` resource.
EOT
  type        = string
  nullable    = true
  default     = null
}

variable "repository_permissions" {
  description = "GitHub Actions permissions for a given repository."
  type = object({
    allowed_actions = optional(string)
    enabled         = optional(bool)
    allowed_actions_config = optional(object({
      github_owned_allowed = bool
      patterns_allowed     = optional(set(string))
      verified_allowed     = optional(bool)
    }))
  })
  nullable = true
  default  = null
}

variable "environments" {
  description = "List of GitHub repository environments."
  type = map(object({
    wait_timer          = optional(number)
    can_admins_bypass   = optional(bool)
    prevent_self_review = optional(bool)
    reviewers = optional(object({
      teams = optional(set(string))
      users = optional(set(string))
    }))
    deployment_branch_policy = optional(object({
      protected_branches     = bool
      custom_branch_policies = bool
    }))
  }))
  default = {}
}

variable "deployment_branch_policies" {
  description = "Deployment branch policies."
  type = list(object({
    environment    = string
    branch_pattern = string
  }))
  default = []
}

variable "deploy_keys" {
  description = "Deploy keys."
  type = list(object({
    key       = string
    read_only = bool
    title     = string
  }))
  default = []
}

variable "secrets" {
  description = "GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified."
  type = list(object({
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
