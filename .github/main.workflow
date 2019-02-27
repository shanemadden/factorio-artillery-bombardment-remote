workflow "Publish" {
  on = "push"
  resolves = ["mod-portal-publish"]
}

action "mod-portal-publish" {
  uses = "shanemadden/factorio-mod-portal-publish@master"
  secrets = ["FACTORIO_USER", "FACTORIO_PASSWORD"]
}
