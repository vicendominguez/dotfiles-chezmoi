-- Hammerspoon entrypoint. Config lives in ~/.config/hammerspoon (MJConfigFile).
hs.window.animationDuration = 0
hs.autoLaunch(true)

-- Auto-reload on save
-- Global on purpose: a local watcher gets garbage-collected and silently stops.
configReloader = hs.pathwatcher.new(hs.configdir, function(files)
  for _, f in ipairs(files) do
    if f:sub(-4) == ".lua" then hs.reload() return end
  end
end):start()

require("focus_follows_mouse").start()
require("windows")
require("quake")
require("rephrase")

hs.alert.show("Hammerspoon loaded", 0.6)
