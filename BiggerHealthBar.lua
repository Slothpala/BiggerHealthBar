--[[
    MODIFICATION NOTICE:
    Changed by Danderlion on February 1, 2026.
    Fixes:
    - Updated frame paths for the Midnight (12.0) API.
    - Replaced the global 'Delay' callback with PLAYER_REGEN_ENABLED to prevent UI taints.
    - Adjusted HealthBarsContainer references for compatibility with TWW/Midnight UI.
]]

-- Original Author: Slothpala
-- Maintained by: Danderlion

local function ApplyPlunderstyle()
    -- Safety check: If we are in combat, wait until out of combat to resize
    if InCombatLockdown() then return end

    -- 1. Corrected Frame Paths for 12.0
    local container = PlayerFrame.PlayerFrameContent and PlayerFrame.PlayerFrameContent.PlayerFrameContentMain
    if not container then return end

    local healthBar = container.HealthBarsContainer.HealthBar
    local healthBarMask = container.HealthBarsContainer.HealthBarMask
    local frameTexture = PlayerFrame.PlayerFrameContainer.FrameTexture
    local frameFlash = PlayerFrame.PlayerFrameContainer.FrameFlash

    -- 2. Apply Textures
    frameTexture:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton")
    frameFlash:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton-incombat", true)
    
    -- 3. Resize Health (The "Big Bar" look)
    healthBar:SetHeight(32)
    healthBarMask:SetAtlas("plunderstorm-ui-hud-unitframe-player-portraiton-bar-health-mask")
    healthBarMask:SetHeight(37)

    -- 4. Corrected Resource Bar Hiding (12.0 Safe Method)
    local resourceBars = {
        container.ManaBarArea, -- Targets the whole area including Mana/Energy
        InsanityBarFrame,
        AlternatePowerBar,
        MonkStaggerBar,
    }

    for _, bar in ipairs(resourceBars) do
        if bar then
            bar:SetAlpha(0)
            if not bar.hooked then
                bar:HookScript("OnShow", function(s) s:SetAlpha(0) end)
                bar.hooked = true
            end
        end
    end
end

-- 5. Tactical Hooking
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_REGEN_ENABLED") -- Fixes things after combat
f:SetScript("OnEvent", ApplyPlunderstyle)

-- Secure Hooks to catch Vehicle/Normal swaps
hooksecurefunc("PlayerFrame_ToPlayerArt", ApplyPlunderstyle)
hooksecurefunc("PlayerFrame_ToVehicleArt", ApplyPlunderstyle)
