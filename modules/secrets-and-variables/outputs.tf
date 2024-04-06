output "actions_secrets" {
  description = "Actions secrets."
  value = [
    for e in github_actions_secret.this :
    {
      for k, v in e : k => v
      if k != "plaintext_value" && k != "encrypted_value"
    }
  ]
}

output "actions_environment_secrets" {
  description = "Actions environment secrets."
  value = [
    for e in github_actions_environment_secret.this :
    {
      for k, v in e : k => v
      if k != "plaintext_value" && k != "encrypted_value"
    }
  ]
}

output "actions_variables" {
  description = "Actions variables."
  value       = github_actions_variable.this
}

output "codespaces_secrets" {
  description = "Codespaces secrets."
  value = [
    for e in github_codespaces_secret.this :
    {
      for k, v in e : k => v
      if k != "plaintext_value" && k != "encrypted_value"
    }
  ]
}

output "dependabot_secrets" {
  description = "Dependabot secrets."
  value = [
    for e in github_dependabot_secret.this :
    {
      for k, v in e : k => v
      if k != "plaintext_value" && k != "encrypted_value"
    }
  ]
}
