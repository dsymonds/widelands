dirname = path.dirname(__file__)

animations = {
   idle = {
      pictures = path.list_directory(dirname, "idle_\\d+.png"),
      hotspot = { 2, 24 }
   }
}
add_worker_animations(animations, "walk", dirname, "walk", {9, 25}, 10)
add_worker_animations(animations, "walkload", dirname, "walkload", {6, 23}, 10)


tribes:new_worker_type {
   msgctxt = "barbarians_worker",
   name = "barbarians_miner_master",
   -- TRANSLATORS: This is a worker name used in lists of workers
   descname = pgettext("barbarians_worker", "Master Miner"),
   icon = dirname .. "menu.png",
   vision_range = 2,

	-- TRANSLATORS: Helptext for a worker: Master Miner
   helptext = pgettext("barbarians_worker", "Works deep in the mines to obtain coal, iron, gold or granite."),
   animations = animations,
}
