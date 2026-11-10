-- Focus follows mouse, with delay. NOTE: hs.window:focus() also raises the window;
-- true focus-without-raise needs private APIs (e.g. the AutoRaise tool).
local M = {}

local DELAY = 0.15          -- seconds the pointer must rest on a window
local enabled = true
local timer

local function windowUnderMouse()
  local pos = hs.geometry.point(hs.mouse.absolutePosition())
  for _, w in ipairs(hs.window.orderedWindows()) do
    if w:isStandard() and w:isVisible() and pos:inside(w:frame()) then
      return w
    end
  end
end

local function onMove()
  if not enabled or next(hs.mouse.getButtons()) ~= nil then return end
  if timer then timer:stop() end
  timer = hs.timer.doAfter(DELAY, function()
    local w = windowUnderMouse()
    if w and hs.window.focusedWindow() ~= w then w:focus() end
  end)
end

function M.start()
  M.tap = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function() onMove() return false end):start()
  hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "F", function()
    enabled = not enabled
    hs.alert.show("Focus follows mouse: " .. (enabled and "ON" or "OFF"), 0.8)
  end)
end

return M
