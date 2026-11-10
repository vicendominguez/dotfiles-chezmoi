-- Window management (Rectangle-style) with ctrl+alt.
local mod = { "ctrl", "alt" }
local function place(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    if win then win:moveToUnit(hs.geometry.rect(x, y, w, h)) end
  end
end

hs.hotkey.bind(mod, "left",  place(0,   0,   0.5, 1))
hs.hotkey.bind(mod, "right", place(0.5, 0,   0.5, 1))
hs.hotkey.bind(mod, "up",    place(0,   0,   1,   0.5))
hs.hotkey.bind(mod, "down",  place(0,   0.5, 1,   0.5))
hs.hotkey.bind(mod, "return", function()
  local win = hs.window.focusedWindow()
  if win then win:toggleFullScreen() end
end)
hs.hotkey.bind(mod, "m", place(0, 0, 1, 1))
hs.hotkey.bind(mod, "c", place(0.15, 0.1, 0.7, 0.8))
hs.hotkey.bind(mod, "u", place(0,   0,   0.5, 0.5))
hs.hotkey.bind(mod, "i", place(0.5, 0,   0.5, 0.5))
hs.hotkey.bind(mod, "j", place(0,   0.5, 0.5, 0.5))
hs.hotkey.bind(mod, "k", place(0.5, 0.5, 0.5, 0.5))

-- Move window to next/previous screen
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "right", function()
  local win = hs.window.focusedWindow()
  if win then win:moveToScreen(win:screen():next(), true, true) end
end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "left", function()
  local win = hs.window.focusedWindow()
  if win then win:moveToScreen(win:screen():previous(), true, true) end
end)
