-- ctrl+t: translate clipboard text to English via local oMLX, result back to clipboard.
-- Port of ~/Scripts/omlx_rephrase.sh. API key lives in the macOS Keychain, never here:
--   security add-generic-password -a "$USER" -s omlx-api-key -w
local MODEL = "translategemma-4b-it-4bit_immersive"
local URL = "http://localhost:8000/v1/chat/completions"
local SYSTEM_PROMPT = "Tienes un tono de entorno laboral, no muy formal pero correcto. "
  .. "Quiero una sola una respuesta directa que sea para copiar y pegar."
local USER_PROMPT = "Translate this text to english. One answer. Just for copying and paste:\n\n"

local TITLE = "oMLX Rephrase"

local function fail(msg)
  hs.focus() -- bring the alert in front
  hs.dialog.blockAlert(TITLE .. " — Error", msg, "OK", nil, "critical")
end

local function apiKey()
  local out = hs.execute("/usr/bin/security find-generic-password -s omlx-api-key -w 2>/dev/null")
  return out and out:gsub("%s+$", "") or ""
end

local function trim(s)
  return (s:gsub("<end_of_turn>", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function rephrase()
  local text = hs.pasteboard.getContents()
  if not text or text:match("^%s*$") then
    hs.notify.show(TITLE, "", "Clipboard is empty. Copy some text first.")
    return
  end

  local key = apiKey()
  if key == "" then
    return fail("oMLX API key not found in Keychain (service: omlx-api-key).")
  end

  -- hs.json/hs.http both work in UTF-8, so accents and smart quotes survive as-is.
  local body = hs.json.encode({
    model = MODEL,
    messages = {
      { role = "system", content = SYSTEM_PROMPT },
      { role = "user", content = USER_PROMPT .. text },
    },
    stream = false,
    temperature = 0.1,
    max_tokens = 512,
    top_p = 0.7,
  })

  hs.http.asyncPost(URL, body, {
    ["Content-Type"] = "application/json; charset=utf-8",
    ["Authorization"] = "Bearer " .. key,
  }, function(status, resp)
    if status <= 0 then
      return fail("Request to oMLX failed or timed out.\n\nCheck that the oMLX server is running (omlx serve) and the model " .. MODEL .. " is loaded.")
    end
    local ok, data = pcall(hs.json.decode, resp)
    if not ok or type(data) ~= "table" then
      return fail("oMLX returned an unreadable response (HTTP " .. status .. ").")
    end
    if data.error then
      local msg = type(data.error) == "table" and data.error.message or tostring(data.error)
      return fail("oMLX returned an error:\n\n" .. tostring(msg))
    end
    local content = data.choices and data.choices[1] and data.choices[1].message
      and data.choices[1].message.content
    if type(content) ~= "string" or trim(content) == "" then
      return fail("oMLX returned an empty response.\n\nTry again or check the model.")
    end
    hs.pasteboard.setContents(trim(content))
    hs.notify.new({ title = TITLE .. " ✓", informativeText = "Text rephrased and copied to clipboard!", soundName = "Pop" }):send()
  end)
end

hs.hotkey.bind({ "ctrl" }, "t", rephrase)
