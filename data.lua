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
  flags = { "mod-openable" },
  stack_size = 1,
  stackable = false,
  selection_color = { r = 1, g = 0.28, b = 0, a = 1 },
  alt_selection_color = { r = 0, g = 0, b = 1, a = 1 },
  selection_mode = { "enemy" },
  alt_selection_mode = { "enemy" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
}

local smart_item = {
  type = "selection-tool",
  name = "smart-artillery-bombardment-remote",
  subgroup = "capsule",
  order = "zzz[smart-artillery-bombardment-remote]",
  icons = {
    {
      icon = "__artillery-bombardment-remote__/graphics/icons/smart-artillery-bombardment-remote.png",
      icon_size = 32,
    }
  },
  flags = { "mod-openable" },
  stack_size = 1,
  stackable = false,
  selection_color = { r = 1, g = 0.28, b = 0, a = 1 },
  alt_selection_color = { r = 0, g = 0, b = 1, a = 1 },
  selection_mode = { "enemy" },
  alt_selection_mode = { "enemy" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
}


local exploration_item = {
  type = "selection-tool",
  name = "smart-artillery-exploration-remote",
  subgroup = "capsule",
  order = "zzz[smart-artillery-exploration-remote]",
  icons = {
    {
      icon = "__artillery-bombardment-remote__/graphics/icons/smart-artillery-exploration-remote.png",
      icon_size = 32,
    }
  },
  flags = {},
  stack_size = 1,
  stackable = false,
  selection_color = { r = 1, g = 0.28, b = 0, a = 1 },
  alt_selection_color = { r = 0, g = 0, b = 1, a = 1 },
  selection_mode = { "same-force" },
  alt_selection_mode = { "enemy" },
  selection_cursor_box_type = "entity",
  alt_selection_cursor_box_type = "entity",
  entity_filters = {"artillery-turret", "artillery-wagon"}
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

local smart_recipe = {
  type = "recipe",
  name = "smart-artillery-bombardment-remote",
  enabled = false,
  ingredients = {
    {"artillery-bombardment-remote", 5}
  },
  result = "smart-artillery-bombardment-remote",
}

local exploration_recipe = {
  type = "recipe",
  name = "smart-artillery-exploration-remote",
  enabled = false,
  ingredients = {
    {"smart-artillery-bombardment-remote", 5}
  },
  result = "smart-artillery-exploration-remote",
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
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"military-science-pack", 1},
      {"utility-science-pack", 1},
      {"space-science-pack", 1},
    },
    time = 60,
    count = 2500,
  },
  order = "d-e-f-y"
}

local smart_technology = {
  type = "technology",
  name = "smart-artillery-bombardment-remote",
  icon_size = 128,
  icon = "__base__/graphics/technology/artillery.png",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-artillery-bombardment-remote",
    },
  },
  prerequisites = { "artillery-bombardment-remote" },
  unit = {
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
      {"military-science-pack", 1},
      {"utility-science-pack", 1},
      {"space-science-pack", 1},
    },
    time = 60,
    count = 25000,
  },
  order = "d-e-f-z"

}
local exploration_technology = {
  type = "technology",
  name = "smart-artillery-exploration-remote",
  icon_size = 128,
  icon = "__base__/graphics/technology/artillery.png",
  effects = {
    {
      type = "unlock-recipe",
      recipe = "smart-artillery-exploration-remote",
    },
  },
  prerequisites = { "smart-artillery-bombardment-remote" },
  unit = {
    ingredients = {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
      {"production-science-pack", 1},
      {"military-science-pack", 1},
      {"utility-science-pack", 1},
      {"space-science-pack", 1},
    },
    time = 60,
    count = 50000,
  },
  order = "d-e-f-z"
}

data:extend{item, smart_item, exploration_item, recipe, smart_recipe, exploration_recipe, technology, smart_technology, exploration_technology}
