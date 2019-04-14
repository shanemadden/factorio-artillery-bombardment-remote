local target_limit = 5000
local function position_to_chunk(position)
  return {
    x = math.floor(position.x / 32),
    y = math.floor(position.y / 32),
  }
end

local function on_player_selected_area(event)
  if event.item == "artillery-bombardment-remote" then
    if not global[event.player_index] then
      global[event.player_index] = {}
    end
    local settings = global[event.player_index]
    local surface = game.players[event.player_index].surface
    local force = game.players[event.player_index].force
    local count = 0
    local col_count = 0
    for x = event.area.left_top.x, event.area.right_bottom.x, (settings.x or 6) do
      for y = (event.area.left_top.y + ((settings.col_count or 2) * (col_count % (settings.col_count or 2)))), event.area.right_bottom.y, (settings.y or 4) do
        surface.create_entity({
          name = "artillery-flare",
          position = {x, y},
          force = force,
          movement = {0, 0},
          height = 0,
          vertical_speed = 0,
          frame_speed = 0,
        })
        count = count + 1
        if count > target_limit then
          break
        end
      end
      col_count = col_count + 1
      if count > target_limit then
        game.players[event.player_index].print({"artillery-bombardment-remote.shot_limit_reached", target_limit})
        break
      end
    end
  elseif event.item == "smart-artillery-bombardment-remote" then
    if not global[event.player_index] then
      global[event.player_index] = {}
    end
    local settings = global[event.player_index]
    local surface = game.players[event.player_index].surface
    local force = game.players[event.player_index].force
    local count = 0
    local points_hit = {}
    if event.area.left_top.x == event.area.right_bottom.x or
      event.area.left_top.y == event.area.right_bottom.y then
      return
    end

    local left_top_chunk = position_to_chunk(event.area.left_top)
    local right_bottom_chunk = position_to_chunk(event.area.right_bottom)
    for x = left_top_chunk.x, right_bottom_chunk.x do
      for y = left_top_chunk.y, right_bottom_chunk.y do
        if not force.is_chunk_charted(surface, {x, y}) then
          surface.create_entity({
            name = "artillery-flare",
            position = {(x*32) + 16, (y*32) + 16},
            force = force,
            movement = {0, 0},
            height = 0,
            vertical_speed = 0,
            frame_speed = 0,
          })
        end
      end
    end

    local spawners = surface.find_entities_filtered({
      area = event.area,
      force = "enemy",
      type = "unit-spawner",
    })
    for _, entity in ipairs(spawners) do
      if game.players[event.player_index].cheat_mode or
        force.is_chunk_charted(surface, position_to_chunk(entity.position)) then
        local skip = false
        local entity_position = entity.position
        for _, position in ipairs(points_hit) do
          local x_dist = math.abs(entity_position.x - position.x)
          local y_dist = math.abs(entity_position.y - position.y)
          if math.sqrt(x_dist * x_dist + y_dist * y_dist) < (settings.radius or 6) then
            skip = true
            break
          end
        end
        if not skip then
          surface.create_entity({
            name = "artillery-flare",
            position = entity_position,
            force = force,
            movement = {0, 0},
            height = 0,
            vertical_speed = 0,
            frame_speed = 0,
          })
          table.insert(points_hit, entity.position)
          count = count + 1
          if count > target_limit then
            break
          end
        end
      end
    end
    local turrets = surface.find_entities_filtered({
      area = event.area,
      force = "enemy",
      type = "turret",
    })
    for _, entity in ipairs(turrets) do
      if game.players[event.player_index].cheat_mode or
        force.is_chunk_charted(surface, position_to_chunk(entity.position)) then
        local skip = false
        local entity_position = entity.position
        for _, position in ipairs(points_hit) do
          local x_dist = math.abs(entity_position.x - position.x)
          local y_dist = math.abs(entity_position.y - position.y)
          if math.sqrt(x_dist * x_dist + y_dist * y_dist) < (settings.radius or 6) then
            skip = true
            break
          end
        end
        if not skip then
          surface.create_entity({
            name = "artillery-flare",
            position = entity_position,
            force = force,
            movement = {0, 0},
            height = 0,
            vertical_speed = 0,
            frame_speed = 0,
          })
          table.insert(points_hit, entity.position)
          count = count + 1
          if count > target_limit then
            break
          end
        end
      end
    end
    if count > target_limit then
      game.players[event.player_index].print({"artillery-bombardment-remote.shot_limit_reached", target_limit})
    end
  end
end
script.on_event(defines.events.on_player_selected_area, on_player_selected_area)

local function on_player_alt_selected_area(event)
  if event.item == "artillery-bombardment-remote" or event.item == "smart-artillery-bombardment-remote" then
    if event.area.left_top.x == event.area.right_bottom.x or
      event.area.left_top.y == event.area.right_bottom.y then
      return
    end
    local flares = game.players[event.player_index].surface.find_entities_filtered({
      area = event.area,
      name = "artillery-flare",
      force = game.players[event.player_index].force,
    })
    for _, flare in ipairs(flares) do
      flare.destroy()
    end
  end
end
script.on_event(defines.events.on_player_alt_selected_area, on_player_alt_selected_area)

local draw_gui_functions = {
  ["artillery-bombardment-remote"] = function(event)
    local player = game.players[event.player_index]
    local settings = global[event.player_index]
    local frame = player.gui.center.add({
      name = "artillery_bombardment_config",
      type = "frame",
      direction = "vertical",
    })
    local config_flow = frame.add({
      name = "artillery_bombardment_config_flow",
      type = "flow",
      direction = "vertical",
    })

    local x_slider_label = config_flow.add({
      name = "artillery_bombardment_x_slider_label",
      type = "label",
      caption = {"artillery-bombardment-remote.config-x-label"},
    })
    local x_slider_flow = config_flow.add({
      name = "artillery_bombardment_x_slider_flow",
      type = "flow",
      direction = "horizontal",
    })
    local x_slider = x_slider_flow.add({
      name = "artillery_bombardment_x_slider",
      type = "slider",
      minimum_value = 1,
      maximum_value = 50,
      value = settings.x or 6,
      tooltip = {"artillery-bombardment-remote.config-x-spacing-tooltip"},
    })
    local x_slider_text = x_slider_flow.add({
      name = "artillery_bombardment_x_textbox",
      type = "textfield",
      text = settings.x or 6,
      tooltip = {"artillery-bombardment-remote.config-x-spacing-tooltip"},
    })

    local y_slider_label = config_flow.add({
      name = "artillery_bombardment_y_slider_label",
      type = "label",
      caption = {"artillery-bombardment-remote.config-y-label"},
    })
    local y_slider_flow = config_flow.add({
      name = "artillery_bombardment_y_slider_flow",
      type = "flow",
      direction = "horizontal",
    })
    local y_slider = y_slider_flow.add({
      name = "artillery_bombardment_y_slider",
      type = "slider",
      minimum_value = 1,
      maximum_value = 50,
      value = settings.y or 4,
      tooltip = {"artillery-bombardment-remote.config-y-spacing-tooltip"},
    })
    local y_slider_text = y_slider_flow.add({
      name = "artillery_bombardment_y_textbox",
      type = "textfield",
      text = settings.y or 4,
      tooltip = {"artillery-bombardment-remote.config-y-spacing-tooltip"},
    })

    local column_slider_label = config_flow.add({
      name = "artillery_bombardment_column_slider_label",
      type = "label",
      caption = {"artillery-bombardment-remote.config-column-label"},
    })
    local column_slider_flow = config_flow.add({
      name = "artillery_bombardment_column_slider_flow",
      type = "flow",
      direction = "horizontal",
    })
    local column_slider = column_slider_flow.add({
      name = "artillery_bombardment_column_slider",
      type = "slider",
      minimum_value = 1,
      maximum_value = 10,
      value = settings.col_count or 2,
      tooltip = {"artillery-bombardment-remote.config-column-offset-tooltip"},
    })
    local column_slider_text = column_slider_flow.add({
      name = "artillery_bombardment_column_textbox",
      type = "textfield",
      text = settings.col_count or 2,
      tooltip = {"artillery-bombardment-remote.config-column-offset-tooltip"},
    })
    player.opened = frame
  end,
  ["smart-artillery-bombardment-remote"] = function(event)
    local player = game.players[event.player_index]
    local settings = global[event.player_index]
    local frame = player.gui.center.add({
      name = "artillery_bombardment_config",
      type = "frame",
      direction = "vertical",
    })
    local config_flow = frame.add({
      name = "artillery_bombardment_config_flow",
      type = "flow",
      direction = "vertical",
    })
    local radius_slider_label = config_flow.add({
      name = "artillery_bombardment_radius_slider_label",
      type = "label",
      caption = {"artillery-bombardment-remote.config-radius-label"},
    })
    local radius_slider_flow = config_flow.add({
      name = "artillery_bombardment_radius_slider_flow",
      type = "flow",
      direction = "horizontal",
    })
    local radius_slider = radius_slider_flow.add({
      name = "artillery_bombardment_radius_slider",
      type = "slider",
      minimum_value = 0,
      maximum_value = 10,
      value = settings.radius or 6,
      tooltip = {"artillery-bombardment-remote.config-radius-tooltip"},
    })
    local radius_slider_text = radius_slider_flow.add({
      name = "artillery_bombardment_radius_textbox",
      type = "textfield",
      text = settings.radius or 6,
      tooltip = {"artillery-bombardment-remote.config-radius-tooltip"},
    })
    player.opened = frame
  end,
}

local function on_mod_item_opened(event)
  if draw_gui_functions[event.item.name] then
    if not global[event.player_index] then
      global[event.player_index] = {}
    end
    draw_gui_functions[event.item.name](event)
  end
end
script.on_event(defines.events.on_mod_item_opened, on_mod_item_opened)

local gui_change_handlers = {
  artillery_bombardment_x_slider = function(event)
    local settings = global[event.player_index]
    event.element.slider_value = math.floor(event.element.slider_value)
    settings.x = event.element.slider_value
    event.element.parent.artillery_bombardment_x_textbox.text = event.element.slider_value
  end,
  artillery_bombardment_x_textbox = function(event)
    local settings = global[event.player_index]
    if tonumber(event.element.text) and math.floor(tonumber(event.element.text)) >= 1 then
      settings.x = math.floor(tonumber(event.element.text))
      event.element.parent.artillery_bombardment_x_slider.slider_value = tonumber(event.element.text)
    elseif not tonumber(event.element.text) and string.len(event.element.text) > 0 then
      event.element.text = settings.x or event.element.parent.artillery_bombardment_x_slider.slider_value
    end
  end,

  artillery_bombardment_y_slider = function(event)
    local settings = global[event.player_index]
    event.element.slider_value = math.floor(event.element.slider_value)
    settings.y = event.element.slider_value
    event.element.parent.artillery_bombardment_y_textbox.text = event.element.slider_value
  end,
  artillery_bombardment_y_textbox = function(event)
    local settings = global[event.player_index]
    if tonumber(event.element.text) and math.floor(tonumber(event.element.text)) >= 1 then
      settings.y = math.floor(tonumber(event.element.text))
      event.element.parent.artillery_bombardment_y_slider.slider_value = tonumber(event.element.text)
    elseif not tonumber(event.element.text) and string.len(event.element.text) > 0 then
      event.element.text = settings.y or event.element.parent.artillery_bombardment_y_slider.slider_value
    end
  end,

  artillery_bombardment_column_slider = function(event)
    local settings = global[event.player_index]
    event.element.slider_value = math.floor(event.element.slider_value)
    settings.col_count = event.element.slider_value
    event.element.parent.artillery_bombardment_column_textbox.text = event.element.slider_value
  end,
  artillery_bombardment_column_textbox = function(event)
    local settings = global[event.player_index]
    if tonumber(event.element.text) and math.floor(tonumber(event.element.text)) >= 1 then
      settings.col_count = math.floor(tonumber(event.element.text))
      event.element.parent.artillery_bombardment_column_slider.slider_value = tonumber(event.element.text)
    elseif not tonumber(event.element.text) and string.len(event.element.text) > 0 then
      event.element.text = settings.col_count or event.element.parent.artillery_bombardment_column_slider.slider_value
    end
  end,

  artillery_bombardment_radius_slider = function(event)
    local settings = global[event.player_index]
    event.element.slider_value = math.floor(event.element.slider_value)
    settings.radius = event.element.slider_value
    event.element.parent.artillery_bombardment_radius_textbox.text = event.element.slider_value
  end,
  artillery_bombardment_radius_textbox = function(event)
    local settings = global[event.player_index]
    if tonumber(event.element.text) and math.floor(tonumber(event.element.text)) >= 0 then
      settings.radius = math.floor(tonumber(event.element.text))
      event.element.parent.artillery_bombardment_radius_slider.slider_value = tonumber(event.element.text)
    elseif not tonumber(event.element.text) and string.len(event.element.text) > 0 then
      event.element.text = settings.radius or event.element.parent.artillery_bombardment_radius_slider.slider_value
    end
  end,
}
local function on_gui_event(event)
  if gui_change_handlers[event.element.name] then
    gui_change_handlers[event.element.name](event)
  end
end
script.on_event(defines.events.on_gui_text_changed, on_gui_event)
script.on_event(defines.events.on_gui_value_changed, on_gui_event)

local function on_gui_closed(event)
  local player = game.players[event.player_index]
  local frame = player.gui.center.artillery_bombardment_config
  if frame then
    frame.destroy()
  end
end
script.on_event(defines.events.on_gui_closed, on_gui_closed)
