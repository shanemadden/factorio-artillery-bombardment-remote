workflow "Publish" {
  on = "push"
  resolves = ["shanemadden/factorio-mod-portal-publish"]
}

action "shanemadden/factorio-mod-portal-publish" {
  uses = "shanemadden/factorio-mod-portal-publish@master"
  secrets = ["FACTORIO_PASSWORD", "FACTORIO_USER"]
}
