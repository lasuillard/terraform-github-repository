resource "github_actions_secret" "this" {
  for_each = {
    for v in var.actions_secrets : v.secret_name => v
    if var.create && v.environment == null
  }

  repository      = var.repository
  secret_name     = each.value.secret_name
  encrypted_value = try(each.value.encrypted_value, null)
  plaintext_value = try(each.value.plaintext_value, null)
}

resource "github_actions_environment_secret" "this" {
  for_each = {
    for v in var.actions_secrets : "${v.environment}/${v.secret_name}" => v
    if var.create && v.environment != null
  }

  repository      = var.repository
  environment     = each.value.environment
  secret_name     = each.value.secret_name
  encrypted_value = try(each.value.encrypted_value, null)
  plaintext_value = try(each.value.plaintext_value, null)
}

resource "github_actions_variable" "this" {
  for_each = {
    for v in var.actions_variables : v.variable_name => v
    if var.create && v.environment == null
  }

  repository    = var.repository
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_actions_environment_variable" "this" {
  for_each = {
    for v in var.actions_variables : "${v.environment}/${v.variable_name}" => v
    if var.create && v.environment != null
  }

  repository    = var.repository
  environment   = each.value.environment
  variable_name = each.value.variable_name
  value         = each.value.value
}

resource "github_codespaces_secret" "this" {
  for_each = {
    for v in var.codespaces_secrets : v.secret_name => v
    if var.create
  }

  repository      = var.repository
  secret_name     = each.value.secret_name
  encrypted_value = try(each.value.encrypted_value, null)
  plaintext_value = try(each.value.plaintext_value, null)
}

resource "github_dependabot_secret" "this" {
  for_each = {
    for v in var.dependabot_secrets : v.secret_name => v
    if var.create
  }

  repository      = var.repository
  secret_name     = each.value.secret_name
  encrypted_value = try(each.value.encrypted_value, null)
  plaintext_value = try(each.value.plaintext_value, null)
}
