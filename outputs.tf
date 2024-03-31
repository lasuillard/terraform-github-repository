output "repository_full_name" {
  description = "A string of the form \"orgname/reponame\"."
  value       = github_repository.this[0].full_name
}

output "repository_html_url" {
  description = "URL to the repository on the web."
  value       = github_repository.this[0].html_url
}

output "repository_ssh_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via SSH."
  value       = github_repository.this[0].ssh_clone_url
}

output "repository_http_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via HTTPS."
  value       = github_repository.this[0].http_clone_url
}

output "repository_git_clone_url" {
  description = "URL that can be provided to git clone to clone the repository anonymously via the git protocol."
  value       = github_repository.this[0].git_clone_url
}

output "repository_svn_url" {
  description = "URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation."
  value       = github_repository.this[0].svn_url
}

output "repository_node_id" {
  description = "GraphQL global node id for use with v4 AP."
  value       = github_repository.this[0].node_id
}

output "repository_repo_id" {
  description = "GitHub ID for the repositor."
  value       = github_repository.this[0].repo_id
}

output "repository_primary_language" {
  description = "The primary language used in the repository."
  value       = github_repository.this[0].primary_language
}

output "repository_pages" {
  description = <<-EOT
The block consisting of the repository's GitHub Pages configuration with the following additional attributes:

- `custom_404`: Whether the rendered GitHub Pages site has a custom 404 page.
- `html_url`: The absolute URL (including scheme) of the rendered GitHub Pages site e.g. https://username.github.io.
- `status`: The GitHub Pages site's build status e.g. building or built.
EOT
  value       = github_repository.this[0].pages
}

output "repository_branch_default" {
  description = "Default branch name."
  value       = github_branch_default.this[0].branch
}
