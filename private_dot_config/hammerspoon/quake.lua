-- Dropdown terminal: show/hide Ghostty with alt+` (top 45% of the screen).
local APP = "Ghostty"

hs.hotkey.bind({ "alt" }, "`", function()
  local app = hs.application.get(APP)
  if app and app:isFrontmost() then
    app:hide()
    return
  end
  if not app then
    hs.application.launchOrFocus(APP)
    return
  end
  app:activate()
  local win = app:mainWindow()
  if win then
    local f = win:screen():frame()
    win:setFrame(hs.geometry.rect(f.x, f.y, f.w, f.h * 0.45))
  end
end)
