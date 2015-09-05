dirname = path.dirname(__file__)

animations = {
   idle = {
      pictures = path.list_directory(dirname, "idle_\\d+.png"),
      hotspot = { 17, 22 }
   }
}
add_worker_animations(animations, "walk", dirname, "walk", {20, 22}, 10)

tribes:new_worker_type {
   msgctxt = "atlanteans_worker",
   name = "atlanteans_smoker",
   -- TRANSLATORS: This is a worker name used in lists of workers
   descname = pgettext("atlanteans_worker", "Smoker"),
   icon = dirname .. "menu.png",
   vision_range = 2,

   buildcost = {
		atlanteans_carrier = 1,
		hook_pole = 1
	},

	-- TRANSLATORS: Helptext for a worker: Smoker
   helptext = pgettext("atlanteans_worker", "Smokes meat and fish."),
   animations = animations,
}
