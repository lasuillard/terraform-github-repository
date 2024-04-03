output "access_level" {
  description = "Actions repository access level."
  value       = try(github_actions_repository_access_level.this[0].access_level, null)
}

output "permissions" {
  description = "Actions repository permissions."
  value       = try(github_actions_repository_permissions.this[0], null)
}

output "environments" {
  description = "List of repository environments."
  value       = github_repository_environment.this
}

output "environment_deployment_policies" {
  description = "List of environment deployment policies."
  value       = github_repository_environment_deployment_policy.this
}

output "secrets_and_variables" {
  description = "Actions secrets and variables."
  value       = module.secrets_and_variables
}

output "deploy_keys" {
  description = "Deploy keys."
  value       = github_repository_deploy_key.this
}
