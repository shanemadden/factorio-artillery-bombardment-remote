local item = {
  type = "selection-tool",
  name = "artillery-bombardment-remote",
  subgroup = "capsule",
  order = "zzz[artillery-bombardment-remote]",
  icons = {
    {
      icon = "__artillery-bombardment-remote__/graphics/icons/artillery-bombardment-remote.png",
      icon_size = 32,
    }
  },
  flags = {"goes-to-quickbar"},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 1, g = 0.28, b = 0, a = 1 },
  alt_selection_color = { r = 0, g = 0, b = 1, a = 1 },
  selection_mode = { "matches-force" },
  alt_selection_mode = { "matches-force" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
}

local recipe = {
  type = "recipe",
  name = "artillery-bombardment-remote",
  enabled = false,
  ingredients = {
    {"artillery-targeting-remote", 5},
    {"satellite", 1},
  },
  result = "artillery-bombardment-remote",
}

local technology = {
  type = "technology",
  name = "artillery-bombardment-remote",
  icon_size = 128,
  icon = "__base__/graphics/technology/artillery.png",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "artillery-bombardment-remote",
    },
  },
  prerequisites = { "artillery" },
  unit = {
    ingredients = {
      {"science-pack-1", 1},
      {"science-pack-2", 1},
      {"science-pack-3", 1},
      {"military-science-pack", 1},
      {"high-tech-science-pack", 1},
      {"space-science-pack", 1},
    },
    time = 60,
    count = 2500,
  },
  order = "d-e-f-z"
}

data:extend{item, recipe, technology}
