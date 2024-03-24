variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the repository."
  type        = string
}

variable "description" {
  description = "A description of the repository."
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "URL of a page describing the project."
  type        = string
  default     = null
}

variable "visibility" {
  description = <<-EOT
Can be `"public"` or `"private"`.

If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be `"internal"`.
The `visibility` parameter overrides the `private` parameter."
EOT
  type        = string
  default     = "private"
}

variable "has_issues" {
  description = "Set to `true` to enable the GitHub Issues features on the repository."
  type        = bool
  default     = true
}

variable "has_discussions" {
  description = "Set to `true` to enable GitHub Discussions on the repository."
  type        = bool
  default     = false
}

variable "has_projects" {
  description = <<-EOT
Set to true to enable the GitHub Projects features on the repository.

Per the GitHub documentation when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`.
If you specify `true` when it has been disabled it will return an error.
EOT
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Set to `true` to enable the GitHub Wiki features on the repository."
  type        = bool
  default     = false
}

variable "is_template" {
  description = "Set to `true` to tell GitHub that this is a template repository."
  type        = bool
  default     = false
}

variable "allow_merge_commit" {
  description = "Set to `false` to disable merge commits on the repository."
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Set to `false` to disable squash merges on the repository."
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Set to `false` to disable rebase merges on the repository."
  type        = bool
  default     = true
}

variable "allow_auto_merge" {
  description = "Set to `true` to allow auto-merging pull requests on the repository."
  type        = bool
  default     = false
}

variable "squash_merge_commit_title" {
  description = <<-EOT
Can be `"PR_TITLE"` or `"COMMIT_OR_PR_TITLE"` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`.
EOT
  type        = string
  default     = null
}

variable "squash_merge_commit_message" {
  description = <<-EOT
Can be `"PR_BODY"`, `"COMMIT_MESSAGES"`, or `"BLANK"` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`.
EOT
  type        = string
  default     = null
}

variable "merge_commit_title" {
  description = <<-EOT
Can be `"PR_TITLE"` or `"MERGE_MESSAGE"` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`.
EOT
  type        = string
  default     = null
}

variable "merge_commit_message" {
  description = <<-EOT
Can be `"PR_BODY"`, `"PR_TITLE"`, or `"BLANK"` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`.
EOT
  type        = string
  default     = null
}

variable "delete_branch_on_merge" {
  description = "Automatically delete head branch after a pull request is merged."
  type        = bool
  default     = false
}

variable "web_commit_signoff_required" {
  description = "Require contributors to sign off on web-based commits. See more here."
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Set to `true` to enable the (deprecated) downloads features on the repository."
  type        = bool
  default     = null
}

variable "auto_init" {
  description = "Set to `true` to produce an initial commit in the repository."
  type        = bool
  default     = null
}

variable "gitignore_template" {
  description = <<-EOT
Use the name of the template without the extension. For example, `"Haskell"`.
EOT
  type        = string
  default     = null
}

variable "license_template" {
  description = <<-EOT
Use the name of the template without the extension. For example, `"mit"` or `"mpl-2.0"`.
EOT
  type        = string
  default     = null
}

variable "default_branch" {
  description = "The name of the default branch of the repository."
  type        = string
  default     = "main"
}

variable "default_branch_rename" {
  description = "Indicate if it should rename the branch rather than use an existing branch."
  type        = bool
  default     = false
}

variable "archived" {
  description = <<-EOT
Specifies if the repository should be archived.

NOTE Currently, the API does not support unarchiving.
EOT
  type        = bool
  default     = false
}

variable "archive_on_destroy" {
  description = "Set to `true` to archive the repository instead of deleting on destroy."
  type        = bool
  default     = true
}

variable "pages" {
  description = <<-EOT
The repository's GitHub Pages configuration.

See [GitHub Pages Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#github-pages-configuration) for details.
EOT
  type        = map(any)
  default     = {}
}

variable "security_and_analysis" {
  description = <<-EOT
The repository's security and analysis configuration.

See [Security and Analysis Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#security-and-analysis-configuration) for details.
EOT
  type        = map(any)
  default     = {}
}

variable "topics" {
  description = <<-EOT
The list of topics of the repository.

NOTE: This attribute is not compatible with the `github_repository_topics` resource. Use one of them.
`github_repository_topics` is only meant to be used if the repository itself is not handled via terraform, for example if it's only read as a datasource (see issue [#1845](https://github.com/integrations/terraform-provider-github/issues/1845)).
EOT
  type        = list(string)
  default     = null
}

variable "template" {
  description = <<-EOT
Use a template repository to create this resource.

See [Template Repositories](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#template-repositories) for details.
EOT
  type        = map(any)
  default     = {}
}

variable "vulnerability_alerts" {
  description = <<-EOT
Set to `true` to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.) See GitHub Documentation for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings.
EOT
  type        = bool
  default     = true
}

variable "ignore_vulnerability_alerts_during_read" {
  description = "Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read."
  type        = bool
  default     = null
}

variable "allow_update_branch" {
  description = "Set to `true` to always suggest updating pull request branches."
  type        = bool
  default     = null
}

variable "actions_secrets" {
  description = "GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified."
  type        = list(map(string))
  default     = []
}

variable "actions_variables" {
  description = "GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified."
  type        = list(map(string))
  default     = []
}

variable "files" {
  description = "Repository files."
  type        = list(map(string))
  default     = []
}

variable "issue_labels" {
  description = "Issue labels. Starting prefix \"#\" in `color` will be ignored."
  type        = list(map(string))
  default     = []
}

variable "issue_labels_authoritative" {
  description = "Whether issue labels managed in authoritative ways. If `true`, issue labels will be created using `github_issue_labels` resource type, possibly causing all the labels not listed removed."
  type        = bool
  default     = false
}
