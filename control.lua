local target_limit = 5000
local function on_player_selected_area(event)
  if event.item == "artillery-bombardment-remote" then
    local surface = game.players[event.player_index].surface
    local force = game.players[event.player_index].force
    local count = 0
    local col_count = 0
    for x = event.area.left_top.x, event.area.right_bottom.x, 6 do
      for y = (event.area.left_top.y + (2 * (col_count % 2))), event.area.right_bottom.y, 4 do
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
    local surface = game.players[event.player_index].surface
    local force = game.players[event.player_index].force
    local count = 0
    if event.area.left_top.x == event.area.right_bottom.x or
      event.area.left_top.y == event.area.right_bottom.y then
      return
    end
    local spawners = surface.find_entities_filtered({
      area = event.area,
      force = "enemy",
      type = "unit-spawner",
    })
    for _, entity in ipairs(spawners) do
      surface.create_entity({
        name = "artillery-flare",
        position = entity.position,
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
    local turrets = surface.find_entities_filtered({
      area = event.area,
      force = "enemy",
      type = "turret",
    })
    for _, entity in ipairs(turrets) do
      surface.create_entity({
        name = "artillery-flare",
        position = entity.position,
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
    if count > target_limit then
      game.players[event.player_index].print({"artillery-bombardment-remote.shot_limit_reached", target_limit})
    end
  end
end
script.on_event(defines.events.on_player_selected_area, on_player_selected_area)

local function on_player_alt_selected_area(event)
  if event.item == "artillery-bombardment-remote" or event.item == "smart-artillery-bombardment-remote" then
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
