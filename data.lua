local item = {
  type = 'selection-tool',
  name = 'artillery-bombardment-remote',
  subgroup = 'capsule',
  order = 'zzz[artillery-bombardment-remote]',
  icons = {
    {
      icon = '__artillery-bombardment-remote__/graphics/icons/artillery-bombardment-remote.png',
      icon_size = 32
    }
  },
  flags = {'mod-openable'},
  stack_size = 1,
  stackable = false,
  selection_color = {r = 1, g = 0.28, b = 0, a = 1},
  alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
  selection_mode = {'enemy'},
  alt_selection_mode = {'enemy'},
  selection_cursor_box_type = 'entity',
  alt_selection_cursor_box_type = 'entity'
}

local smart_item = {
  type = 'selection-tool',
  name = 'smart-artillery-bombardment-remote',
  subgroup = 'capsule',
  order = 'zzz[smart-artillery-bombardment-remote]',
  icons = {
    {
      icon = '__artillery-bombardment-remote__/graphics/icons/smart-artillery-bombardment-remote.png',
      icon_size = 32
    }
  },
  flags = {'mod-openable'},
  stack_size = 1,
  stackable = false,
  selection_color = {r = 1, g = 0.28, b = 0, a = 1},
  alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
  selection_mode = {'enemy'},
  alt_selection_mode = {'enemy'},
  selection_cursor_box_type = 'entity',
  alt_selection_cursor_box_type = 'entity'
}

local exploration_item = {
  type = 'selection-tool',
  name = 'smart-artillery-exploration-remote',
  subgroup = 'capsule',
  order = 'zzz[smart-artillery-exploration-remote]',
  icons = {
    {
      icon = '__artillery-bombardment-remote__/graphics/icons/smart-artillery-exploration-remote.png',
      icon_size = 32
    }
  },
  flags = {},
  stack_size = 1,
  stackable = false,
  selection_color = {r = 1, g = 0.28, b = 0, a = 1},
  alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
  selection_mode = {'same-force'},
  alt_selection_mode = {'enemy'},
  selection_cursor_box_type = 'entity',
  alt_selection_cursor_box_type = 'entity',
  entity_filters = {'artillery-turret', 'artillery-wagon'}
}

local recipe = {
  type = 'recipe',
  name = 'artillery-bombardment-remote',
  enabled = false,
  ingredients = {
    {'artillery-targeting-remote', 5},
    {'satellite', 1}
  },
  result = 'artillery-bombardment-remote'
}

local smart_recipe = {
  type = 'recipe',
  name = 'smart-artillery-bombardment-remote',
  enabled = false,
  ingredients = {
    {'artillery-bombardment-remote', 5}
  },
  result = 'smart-artillery-bombardment-remote'
}

local exploration_recipe = {
  type = 'recipe',
  name = 'smart-artillery-exploration-remote',
  enabled = false,
  ingredients = {
    {'smart-artillery-bombardment-remote', 5}
  },
  result = 'smart-artillery-exploration-remote'
}

local original_tech = table.deepcopy(data.raw.technology['artillery'])
original_tech.unit.ingredients = {
  {'automation-science-pack', 1},
  {'logistic-science-pack', 1},
  {'chemical-science-pack', 1},
  {'military-science-pack', 1},
  {'utility-science-pack', 1},
  {'space-science-pack', 1}
}
original_tech.icons = {
  {
    icon = table.deepcopy(original_tech.icon),
    icon_size = table.deepcopy(original_tech.icon_size)
  }
}

local technology = table.deepcopy(original_tech)
technology.name = 'artillery-bombardment-remote'
technology.effects = {
  {
    type = 'unlock-recipe',
    recipe = 'artillery-bombardment-remote'
  }
}
technology.prerequisites = {'artillery'}
technology.unit.count = 2500
technology.order = 'd-e-f-y'
table.insert(
  technology.icons,
  {
    icon = '__artillery-bombardment-remote__/graphics/icons/artillery-bombardment-remote.png',
    icon_size = 32,
    scale = 2,
    shift = {98, 98}
  }
)

local smart_technology = table.deepcopy(original_tech)
smart_technology.name = 'smart-artillery-bombardment-remote'
smart_technology.effects = {
  {
    type = 'unlock-recipe',
    recipe = 'smart-artillery-bombardment-remote'
  }
}
smart_technology.prerequisites = {'artillery-bombardment-remote'}
smart_technology.unit.count = 25000
smart_technology.order = 'd-e-f-z'
table.insert(
  smart_technology.icons,
  {
    icon = '__artillery-bombardment-remote__/graphics/icons/smart-artillery-bombardment-remote.png',
    icon_size = 32,
    scale = 2,
    shift = {98, 98}
  }
)

local exploration_technology = table.deepcopy(original_tech)
exploration_technology.name = 'smart-artillery-exploration-remote'
exploration_technology.effects = {
  {
    type = 'unlock-recipe',
    recipe = 'smart-artillery-exploration-remote'
  }
}
exploration_technology.prerequisites = {'artillery'}
exploration_technology.unit.count = 50000
exploration_technology.order = 'd-e-f-z'
table.insert(
  exploration_technology.icons,
  {
    icon = '__artillery-bombardment-remote__/graphics/icons/smart-artillery-exploration-remote.png',
    icon_size = 32,
    scale = 2,
    shift = {98, 98}
  }
)

data:extend {item, smart_item, exploration_item, recipe, smart_recipe, exploration_recipe, technology, smart_technology, exploration_technology}
