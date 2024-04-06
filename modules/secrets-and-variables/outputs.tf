output "actions_secrets" {
  description = "Actions secrets."
  value       = github_actions_secret.this
}

output "actions_environment_secrets" {
  description = "Actions environment secrets."
  value       = github_actions_environment_secret.this
}

output "actions_variables" {
  description = "Actions variables."
  value       = github_actions_variable.this
}

output "codespaces_secrets" {
  description = "Codespaces secrets."
  value       = github_codespaces_secret.this
}

output "dependabot_secrets" {
  description = "Dependabot secrets."
  value       = github_dependabot_secret.this
}
