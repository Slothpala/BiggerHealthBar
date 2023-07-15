--[[
	Created by Slothpala 
--]]
local PlayerFrameHealthBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar
local PlayerFrameManaBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar
-- inital setup to never show the manabar
for _,ressourcebar in pairs({
	PlayerFrameManaBar,
	InsanityBarFrame
}) do
	ressourcebar:Hide()
	ressourcebar:HookScript("OnShow",ressourcebar.Hide)
end

local function removeMaskTexture()
	for _,v in pairs ({
		PlayerFrameHealthBar:GetStatusBarTexture(),
		PlayerFrameHealthBar.MyHealPredictionBar,
		PlayerFrameHealthBar.OtherHealPredictionBar,
		PlayerFrameHealthBar.TotalAbsorbBar,
		PlayerFrameHealthBar.TotalAbsorbBarOverlay,
		PlayerFrameHealthBar.OverAbsorbGlow,
		PlayerFrameHealthBar.OverHealAbsorbGlow,
		PlayerFrameHealthBar.HealAbsorbBar,
		PlayerFrameHealthBar.HealAbsorbBarLeftShadow,
		PlayerFrameHealthBar.HealAbsorbBarRightShadow,
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.PlayerFrameHealthBarAnimatedLoss:GetStatusBarTexture()
	}) do
		if v:GetMaskTexture(1) ~= nil then
			v:RemoveMaskTexture(v:GetMaskTexture(1))
		end
	end
end
removeMaskTexture() -- we have to remove it as the game froces the texture to stay in its original state otherwise
-- imo the best function to hook as it get called very rarely but everytime when we need it i.e vehicle frame
hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
	PlayerFrameHealthBar:SetHeight(31) -- 31 = statusbar + manabar + seperator by trial and error
end)


