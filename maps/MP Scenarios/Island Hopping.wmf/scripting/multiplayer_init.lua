-- =================================
-- Island Hopping Fun Map Scripting
-- =================================
use("aux", "coroutine")
use("aux", "infrastructure")
use("aux", "formatting")
use("aux", "objective_utils")

-- ==========
-- Constants
-- ==========
set_textdomain("mp_scenario_island_hopping.wmf")

game = wl.Game()
map = game.map

_nplayers_finished_island = {0, 0}
_start_fields = {
   { -- Island 1
      map.player_slots[1].starting_field,
      map.player_slots[2].starting_field,
      map.player_slots[3].starting_field,
      map.player_slots[4].starting_field
   },
   { -- Island 2
      map:get_field(143, 148),
      map:get_field(142,  45),
      map:get_field( 51,  44),
      map:get_field( 49, 147)
   },
   { -- Island 3
      map:get_field(180, 182),
      map:get_field(180,  10),
      map:get_field( 13,   9),
      map:get_field( 13, 182)
   }
}

_finish_areas = {
   { -- Island 1
      map:get_field(136,125):region(3), -- player 1
      map:get_field(136, 70):region(3), -- player 2
      map:get_field( 57, 68):region(3), -- player 3
      map:get_field( 56,122):region(3)  -- player 4
   },
   { -- Island 2
      map:get_field(167,164):region(3), -- player 1
      map:get_field(167, 28):region(3), -- player 2
      map:get_field( 27, 27):region(3), -- player 3
      map:get_field( 26,161):region(3)  -- player 4
   }
}
_finish_rewards = {
   { -- Island 1
      { -- 1st to finish
         trunk = 25, planks = 15, stone = 10,
         spidercloth = 5, corn = 20,
      },
      { -- 2st to finish
         trunk = 45, planks = 30, stone = 20,
         spidercloth = 7, corn = 25,
      },
      { -- 3rd to finish
         trunk = 65, planks = 45, stone = 30,
         spidercloth = 9, corn = 30,
      },
      { -- 4th to finish
         trunk = 85, planks = 50, stone = 40,
         spidercloth = 11, corn = 35,
      }
   },
   { -- Island 2
      { -- 1st to finish
         coal = 20, ironore = 10, goldore = 10,
      },
      { -- 2st to finish
         coal = 30, ironore = 15, goldore = 15,
      },
      { -- 3rd to finish
         coal = 40, ironore = 20, goldore = 20,
      },
      { -- 4th to finish
         coal = 50, ironore = 25, goldore = 25,
      }
   }
}
hill = map:get_field(0,0):region(3)

-- ==================
-- Utility functions
-- ==================
function send_to_all(text)
   for idx,plr in ipairs(game.players) do
      plr:send_message(_ "Game Status", text, {popup=true})
   end
end

function format_rewards(r)
   rv = {}
   for name,count in pairs(r) do
      rv[#rv + 1] = (_"%i %s<br>\n"):format(count, name)
   end
   return table.concat(rv)
end


use("map", "texts")
use("map", "hop_island")
use("map", "first_island")

-- ===============
-- Initialization
-- ===============
-- Reveal the whole map for all players
function reveal_everything_for_everybody()
   local fields = {}
   local i = 1
   for x=0, map.width-1 do
      for y=0, map.height-1 do
         fields[i] = map:get_field(x,y)
         i = i + 1
      end
   end

   for idx, plr in ipairs(game.players) do
      plr:reveal_fields(fields)
   end
end

-- Place headquarters for all players
function place_headquarters()
   for idx, plr in ipairs(game.players) do
      local sf = map.player_slots[plr.number].starting_field

      prefilled_buildings(plr, {"headquarters", sf.x, sf.y,
         wares = {
            diamond = 7,
            ironore = 5,
            quartz = 9,
            stone = 50,
            spideryarn = 9,
            trunk = 20,
            coal = 12,
            gold = 4,
            goldyarn = 6,
            iron = 8,
            planks = 45,
            spidercloth = 5,
            blackroot = 5,
            blackrootflour = 12,
            bread = 8,
            corn = 5,
            cornflour = 12,
            fish = 3,
            meat = 3,
            smoked_fish = 6,
            smoked_meat = 6,
            water = 12,
            bakingtray = 2,
            bucket = 2,
            fire_tongs = 2,
            fishing_net = 4,
            hammer = 11,
            hunting_bow = 1,
            milking_tongs = 2,
            hook_pole = 2,
            pick = 12,
            saw = 9,
            scythe = 4,
            shovel = 9,
            tabard = 5,
            light_trident = 5,
         },
         workers = {
            armoursmith = 1,
            blackroot_farmer = 1,
            builder = 10,
            burner = 1,
            carrier = 40,
            fish_breeder = 1,
            geologist = 4,
            miner = 4,
            sawyer = 1,
            stonecutter = 2,
            toolsmith = 2,
            weaponsmith = 1,
            woodcutter = 3,
            horse = 5,
         },
         soldiers = {
            [{0,0,0,0}] = 35,
         }
      })
   end
end

-- Disable some Buildings for all players
function disable_unused_buildings()
   for idx, plr in ipairs(game.players) do
      plr:forbid_buildings{"shipyard"}
   end
end

-- Game initializations
function initialize()
   reveal_everything_for_everybody()
   place_headquarters()
   disable_unused_buildings()

   send_to_all(welcome_msg)

   for idx,plr in ipairs(game.players) do
      run(function() run_island(plr, 1) end)
   end

   run(watch_hill)
end


run(initialize)
