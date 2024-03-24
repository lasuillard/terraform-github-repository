# terraform-github-repository

Terraform module to create GitHub repository and relevant resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_secret.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_issue_label.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_issue_labels.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_labels) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_secrets"></a> [actions\_secrets](#input\_actions\_secrets) | GitHub Actions secrets for this repository. Create `github_actions_environment_secret` resource if `environment` key specified. | `list(map(string))` | `[]` | no |
| <a name="input_actions_variables"></a> [actions\_variables](#input\_actions\_variables) | GitHub Actions variables for this repository. Create `github_actions_environment_variable` resource if `environment` key specified. | `list(map(string))` | `[]` | no |
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Set to `true` to allow auto-merging pull requests on the repository. | `bool` | `false` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | Set to `false` to disable merge commits on the repository. | `bool` | `true` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | Set to `false` to disable rebase merges on the repository. | `bool` | `true` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | Set to `false` to disable squash merges on the repository. | `bool` | `true` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | Set to `true` to always suggest updating pull request branches. | `bool` | `null` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Set to `true` to archive the repository instead of deleting on destroy. | `bool` | `true` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | Specifies if the repository should be archived.<br><br>NOTE Currently, the API does not support unarchiving. | `bool` | `false` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | Set to `true` to produce an initial commit in the repository. | `bool` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The name of the default branch of the repository. | `string` | `"main"` | no |
| <a name="input_default_branch_rename"></a> [default\_branch\_rename](#input\_default\_branch\_rename) | Indicate if it should rename the branch rather than use an existing branch. | `bool` | `false` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | Automatically delete head branch after a pull request is merged. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the repository. | `string` | `null` | no |
| <a name="input_files"></a> [files](#input\_files) | Repository files. | `list(map(string))` | `[]` | no |
| <a name="input_gitignore_template"></a> [gitignore\_template](#input\_gitignore\_template) | Use the name of the template without the extension. For example, `"Haskell"`. | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Set to `true` to enable GitHub Discussions on the repository. | `bool` | `false` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | Set to `true` to enable the (deprecated) downloads features on the repository. | `bool` | `null` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Set to `true` to enable the GitHub Issues features on the repository. | `bool` | `true` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Set to true to enable the GitHub Projects features on the repository.<br><br>Per the GitHub documentation when in an organization that has disabled repository projects it will default to `false` and will otherwise default to `true`.<br>If you specify `true` when it has been disabled it will return an error. | `bool` | `false` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Set to `true` to enable the GitHub Wiki features on the repository. | `bool` | `false` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | URL of a page describing the project. | `string` | `null` | no |
| <a name="input_ignore_vulnerability_alerts_during_read"></a> [ignore\_vulnerability\_alerts\_during\_read](#input\_ignore\_vulnerability\_alerts\_during\_read) | Set to `true` to not call the vulnerability alerts endpoint so the resource can also be used without admin permissions during read. | `bool` | `null` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Set to `true` to tell GitHub that this is a template repository. | `bool` | `false` | no |
| <a name="input_issue_labels"></a> [issue\_labels](#input\_issue\_labels) | Issue labels. Starting prefix "#" in `color` will be ignored. | `list(map(string))` | `[]` | no |
| <a name="input_issue_labels_authoritative"></a> [issue\_labels\_authoritative](#input\_issue\_labels\_authoritative) | Whether issue labels managed in authoritative ways. If `true`, issue labels will be created using `github_issue_labels` resource type, possibly causing all the labels not listed removed. | `bool` | `false` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | Use the name of the template without the extension. For example, `"mit"` or `"mpl-2.0"`. | `string` | `null` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | Can be `"PR_BODY"`, `"PR_TITLE"`, or `"BLANK"` for a default merge commit message. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | Can be `"PR_TITLE"` or `"MERGE_MESSAGE"` for a default merge commit title. Applicable only if `allow_merge_commit` is `true`. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_pages"></a> [pages](#input\_pages) | The repository's GitHub Pages configuration.<br><br>See [GitHub Pages Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#github-pages-configuration) for details. | `map(any)` | `{}` | no |
| <a name="input_security_and_analysis"></a> [security\_and\_analysis](#input\_security\_and\_analysis) | The repository's security and analysis configuration.<br><br>See [Security and Analysis Configuration](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#security-and-analysis-configuration) for details. | `map(any)` | `{}` | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | Can be `"PR_BODY"`, `"COMMIT_MESSAGES"`, or `"BLANK"` for a default squash merge commit message. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | Can be `"PR_TITLE"` or `"COMMIT_OR_PR_TITLE"` for a default squash merge commit title. Applicable only if `allow_squash_merge` is `true`. | `string` | `null` | no |
| <a name="input_template"></a> [template](#input\_template) | Use a template repository to create this resource.<br><br>See [Template Repositories](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository#template-repositories) for details. | `map(any)` | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | The list of topics of the repository.<br><br>NOTE: This attribute is not compatible with the `github_repository_topics` resource. Use one of them.<br>`github_repository_topics` is only meant to be used if the repository itself is not handled via terraform, for example if it's only read as a datasource (see issue [#1845](https://github.com/integrations/terraform-provider-github/issues/1845)). | `list(string)` | `null` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Can be `"public"` or `"private"`.<br><br>If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be `"internal"`.<br>The `visibility` parameter overrides the `private` parameter." | `string` | `"private"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Set to `true` to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.) See GitHub Documentation for details. Note that vulnerability alerts have not been successfully tested on any GitHub Enterprise instance and may be unavailable in those settings. | `bool` | `true` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | Require contributors to sign off on web-based commits. See more here. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_branch_default"></a> [repository\_branch\_default](#output\_repository\_branch\_default) | Default branch name. |
| <a name="output_repository_full_name"></a> [repository\_full\_name](#output\_repository\_full\_name) | A string of the form "orgname/reponame". |
| <a name="output_repository_git_clone_url"></a> [repository\_git\_clone\_url](#output\_repository\_git\_clone\_url) | URL that can be provided to git clone to clone the repository anonymously via the git protocol. |
| <a name="output_repository_html_url"></a> [repository\_html\_url](#output\_repository\_html\_url) | URL to the repository on the web. |
| <a name="output_repository_http_clone_url"></a> [repository\_http\_clone\_url](#output\_repository\_http\_clone\_url) | URL that can be provided to git clone to clone the repository via HTTPS. |
| <a name="output_repository_node_id"></a> [repository\_node\_id](#output\_repository\_node\_id) | GraphQL global node id for use with v4 AP. |
| <a name="output_repository_pages"></a> [repository\_pages](#output\_repository\_pages) | The block consisting of the repository's GitHub Pages configuration with the following additional attributes:<br><br>- `custom_404`: Whether the rendered GitHub Pages site has a custom 404 page.<br>- `html_url`: The absolute URL (including scheme) of the rendered GitHub Pages site e.g. https://username.github.io.<br>- `status`: The GitHub Pages site's build status e.g. building or built. |
| <a name="output_repository_primary_language"></a> [repository\_primary\_language](#output\_repository\_primary\_language) | The primary language used in the repository. |
| <a name="output_repository_repo_id"></a> [repository\_repo\_id](#output\_repository\_repo\_id) | GitHub ID for the repositor. |
| <a name="output_repository_ssh_clone_url"></a> [repository\_ssh\_clone\_url](#output\_repository\_ssh\_clone\_url) | URL that can be provided to git clone to clone the repository via SSH. |
| <a name="output_repository_svn_url"></a> [repository\_svn\_url](#output\_repository\_svn\_url) | URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation. |
<!-- END_TF_DOCS -->
