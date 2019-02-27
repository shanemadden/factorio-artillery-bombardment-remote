workflow "Publish" {
  on = "push"
  resolves = ["publish-to-portal"]
}

action "publish-to-portal" {
  uses = "shanemadden/factorio-mod-portal-publish@1.0.0"
  secrets = ["FACTORIO_USER", "FACTORIO_PASSWORD"]
}
