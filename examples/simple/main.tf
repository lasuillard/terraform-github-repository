provider "github" {
  token = var.github_token
}

module "simple" {
  source = "../../"

  name                 = "simple"
  vulnerability_alerts = false
}
