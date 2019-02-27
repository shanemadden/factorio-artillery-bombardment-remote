workflow "New workflow" {
  on = "push"
  resolves = ["shanemadden/factorio-mod-portal-publish@master"]
}

action "shanemadden/factorio-mod-portal-publish@master" {
  uses = "shanemadden/factorio-mod-portal-publish@master"
  secrets = ["FACTORIO_PASSWORD", "FACTORIO_USER"]
}
