-- Simple texture path display addon that activates immediately on load
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
local isHooked = false

f:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" then
    -- Keep the slash command for activating if needed
    SLASH_WHATTEXTURE1 = "/whattexture"
    SlashCmdList["WHATTEXTURE"] = function(msg)
      if not isHooked then
        -- Hook GameTooltip only if not already hooked
        local originalSetBagItem = GameTooltip.SetBagItem
        GameTooltip.SetBagItem = function(self, container, slot)
          originalSetBagItem(self, container, slot)
          
          -- Get the item's texture directly from GetContainerItemInfo
          local texture = GetContainerItemInfo(container, slot)
          
          if texture then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("Texture: " .. texture, 0, 1, 1)
            GameTooltip:Show()
          end
        end
        
        isHooked = true
        DEFAULT_CHAT_FRAME:AddMessage("Texture Path Display activated!")
      else
        DEFAULT_CHAT_FRAME:AddMessage("Texture Path Display is already active!")
      end
    end
    
    -- Automatically run the command on load
    SlashCmdList["WHATTEXTURE"]("")
  end
end)