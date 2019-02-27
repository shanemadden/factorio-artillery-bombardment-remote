workflow "New workflow" {
  on = "push"
  resolves = ["Filters for GitHub Actions"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@24a566c2524e05ebedadef0a285f72dc9b631411"
  args = "tag"
}
