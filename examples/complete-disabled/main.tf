module "disabled" {
  source = "../complete"

  github_token = var.github_token
  create       = false
}
