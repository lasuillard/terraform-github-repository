provider "github" {
  token = var.github_token
}

module "authoritative" {
  source = "../../"

  name = "authoritative"

  collaborators = {
    authoritative = {
      users = [
        {
          username = "some-username"
        }
      ],
      teams = [
        {
          team_id = "some-team-id"
        }
      ]
    }
  }
  collaborators_authoritative = true

  issue_labels = [
    {
      name        = "Urgent"
      color       = "#FF0000"
      description = "Something urgent"
    }
  ]
  issue_labels_authoritative = true
}
