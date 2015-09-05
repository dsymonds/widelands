dirname = path.dirname(__file__)

animations = {
   idle = {
      pictures = path.list_directory(dirname, "idle_\\d+.png"),
      hotspot = { 7, 21 }
   }
}
add_worker_animations(animations, "walk", dirname, "walk", {18, 25}, 10)
add_worker_animations(animations, "walkload", dirname, "walkload", {8, 27}, 10)


tribes:new_worker_type {
   msgctxt = "barbarians_worker",
   name = "barbarians_smelter",
   -- TRANSLATORS: This is a worker name used in lists of workers
   descname = pgettext("barbarians_worker", "Smelter"),
   icon = dirname .. "menu.png",
   vision_range = 2,

   buildcost = {
		barbarians_carrier = 1,
		fire_tongs = 1
	},

	-- TRANSLATORS: Helptext for a worker: Smelter
   helptext = pgettext("barbarians_worker", "Smelts ores into metal."),
   animations = animations,
}
