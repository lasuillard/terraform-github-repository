resource "github_repository_ruleset" "this" {
  for_each = { for v in var.rulesets : v.name => v if var.create }

  repository  = var.repository
  enforcement = each.value.enforcement
  name        = each.value.name

  dynamic "rules" {
    for_each = [each.value.rules]

    content {
      dynamic "branch_name_pattern" {
        for_each = rules.value.branch_name_pattern != null ? [rules.value.branch_name_pattern] : []

        content {
          operator = branch_name_pattern.value.operator
          pattern  = branch_name_pattern.value.pattern
          name     = try(branch_name_pattern.value.name, null)
          negate   = try(branch_name_pattern.value.negate, null)
        }
      }

      dynamic "commit_author_email_pattern" {
        for_each = rules.value.commit_author_email_pattern != null ? [rules.value.commit_author_email_pattern] : []

        content {
          operator = commit_author_email_pattern.value.operator
          pattern  = commit_author_email_pattern.value.pattern
          name     = try(commit_author_email_pattern.value.name, null)
          negate   = try(commit_author_email_pattern.value.negate, null)
        }
      }

      dynamic "commit_message_pattern" {
        for_each = rules.value.commit_message_pattern != null ? [rules.value.commit_message_pattern] : []

        content {
          operator = commit_message_pattern.value.operator
          pattern  = commit_message_pattern.value.pattern
          name     = try(commit_message_pattern.value.name, null)
          negate   = try(commit_message_pattern.value.negate, null)
        }
      }

      dynamic "committer_email_pattern" {
        for_each = rules.value.committer_email_pattern != null ? [rules.value.committer_email_pattern] : []

        content {
          operator = committer_email_pattern.value.operator
          pattern  = committer_email_pattern.value.pattern
          name     = try(committer_email_pattern.value.name, null)
          negate   = try(committer_email_pattern.value.negate, null)
        }
      }

      creation         = try(rules.value.creation, null)
      deletion         = try(rules.value.deletion, null)
      non_fast_forward = try(rules.value.non_fast_forward, null)

      dynamic "pull_request" {
        for_each = rules.value.pull_request != null ? [rules.value.pull_request] : []

        content {
          dismiss_stale_reviews_on_push     = try(pull_request.value.dismiss_stale_reviews_on_push, null)
          require_code_owner_review         = try(pull_request.value.require_code_owner_review, null)
          require_last_push_approval        = try(pull_request.value.require_last_push_approval, null)
          required_approving_review_count   = try(pull_request.value.required_approving_review_count, null)
          required_review_thread_resolution = try(pull_request.value.required_review_thread_resolution, null)
        }
      }

      dynamic "required_deployments" {
        for_each = rules.value.required_deployments != null ? [rules.value.required_deployments] : []

        content {
          required_deployment_environments = required_deployments.value.required_deployment_environments
        }
      }

      required_linear_history = try(rules.value.required_linear_history, null)
      required_signatures     = try(rules.value.required_signatures, null)

      dynamic "required_status_checks" {
        for_each = rules.value.required_status_checks != null ? [rules.value.required_status_checks] : []

        content {
          dynamic "required_check" {
            for_each = toset(required_status_checks.value.required_check)

            content {
              context        = required_check.value.context
              integration_id = try(required_check.value.integration_id, null)
            }
          }

          strict_required_status_checks_policy = try(required_status_checks.value.strict_required_status_checks_policy, null)
        }
      }

      dynamic "tag_name_pattern" {
        for_each = rules.value.tag_name_pattern != null ? [rules.value.tag_name_pattern] : []

        content {
          operator = tag_name_pattern.value.operator
          pattern  = tag_name_pattern.value.pattern
          name     = try(tag_name_pattern.value.name, null)
          negate   = try(tag_name_pattern.value.negate, null)
        }
      }

      update                        = try(rules.value.update, null)
      update_allows_fetch_and_merge = try(rules.value.update_allows_fetch_and_merge, null)
    }
  }

  target = each.value.target

  dynamic "bypass_actors" {
    for_each = each.value.bypass_actors != null ? each.value.bypass_actors : []

    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  dynamic "conditions" {
    for_each = each.value.conditions != null ? [each.value.conditions] : []

    content {
      dynamic "ref_name" {
        for_each = [conditions.value.ref_name]

        content {
          exclude = ref_name.value.exclude
          include = ref_name.value.include
        }
      }
    }
  }
}
