module "disabled" {
  source = "../.."

  name   = "do-not-create"
  create = false
}
