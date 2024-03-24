provider "github" {
  token = var.github_token
}

module "repository" {
  source = "../../"

  name                        = "example-repository"
  description                 = "An example repository."
  allow_auto_merge            = false
  allow_merge_commit          = true
  allow_rebase_merge          = true
  allow_update_branch         = null
  archive_on_destroy          = true
  delete_branch_on_merge      = false
  squash_merge_commit_message = "COMMIT_MESSAGES"
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  visibility                  = "public"
}
