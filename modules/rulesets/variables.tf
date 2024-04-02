variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "repository" {
  description = "The name of the repository."
  type        = string
}

variable "rulesets" {
  description = "Repository rulesets."
  type = list(object({
    enforcement = string
    name        = string
    rules = object({
      branch_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_author_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_message_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      committer_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      creation         = optional(bool)
      deletion         = optional(bool)
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
      }))
      required_deployments = optional(object({
        required_deployment_environments = set(string)
      }))
      required_linear_history = optional(bool)
      required_signatures     = optional(bool)
      required_status_checks = optional(object({
        required_check = list(object({
          context        = string
          integration_id = optional(number)
        }))
        strict_required_status_checks_policy = optional(bool)
      }))
      tag_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      update                        = optional(bool)
      update_allows_fetch_and_merge = optional(bool)
    })
    target = string
    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = string
      bypass_mode = optional(string)
    })))
    conditions = optional(object({
      ref_name = object({
        exclude = set(string)
        include = set(string)
      })
    }))
  }))
  default = []
}
