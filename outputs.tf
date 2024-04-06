output "repository" {
  description = "Repository details."
  value       = try(github_repository.this[0], null)
}

output "collaborators" {
  description = "List of repository collaborators."
  value       = try(github_repository_collaborator.this, github_repository_collaborators.this[0], null)
}

output "files" {
  description = "Files managed by this module."
  value       = github_repository_file.this
}

output "webhooks" {
  description = "Repository webhooks."
  value       = github_repository_webhook.this
}

output "secrets_and_variables" {
  description = "Repository Actions, Codespaces and Dependabot secrets and variables."
  value       = module.secrets_and_variables
}

output "branch_default" {
  description = "Default branch name."
  value       = try(github_branch_default.this[0].branch, null)
}

output "branches" {
  description = "Branches in repository."
  value       = github_branch.this
}

output "branch_protections" {
  description = "Branch protection rules."
  value       = github_branch_protection.this
}

output "rulesets" {
  description = "Repository rulesets."
  value       = module.rulesets
}

output "tag_protections" {
  description = "Tag protection rules."
  value       = github_repository_tag_protection.this
}

output "actions" {
  description = "GitHub Actions module outputs."
  value       = module.actions
}

output "dependabot_security_updates_enabled" {
  description = "Whether dependabot security updates enabled for this repository."
  value       = try(github_repository_dependabot_security_updates.this[0].enabled, null)
}

output "issue_labels" {
  description = "Repository issue labels."
  value       = try(github_issue_label.this, github_issue_labels.this[0], null)
}

output "autolink_references" {
  description = "Autolink references."
  value       = github_repository_autolink_reference.this
}
