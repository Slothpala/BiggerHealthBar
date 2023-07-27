--[[
	Created by Slothpala 
--]]

local PlayerFrameHealthBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar
local PowerBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar
-- inital setup to never show the manabar
for _,ressourcebar in pairs({
	PowerBar,
	InsanityBarFrame,
}) do
	ressourcebar:Hide()
	ressourcebar:HookScript("OnShow",ressourcebar.Hide)
end

--coords left,right,top,bottom
local textures = {
	FrameTexture = {
		path = "Interface\\AddOns\\BiggerHealthBar\\Textures\\BiggerHealthBar_FrameTexture.tga",
		coords = {26.5/256, 223.5/256, 27/128, 97/128}
	},
	FrameFlash = {
		path = "Interface\\AddOns\\BiggerHealthBar\\Textures\\BiggerHealthBar_FrameFlash.tga",
		coords = {27.5/256, 219/256, 26/128, 96/128}
	},
	AlternateFrameTexture = {
		path = "Interface\\AddOns\\BiggerHealthBar\\Textures\\BiggerHealthBar_AlternateFrameTexture.tga",
		coords = {26.5/256, 223.5/256, 27/128, 100/128}
	},
	AlternateFrameFlash = {
		path = "Interface\\AddOns\\BiggerHealthBar\\Textures\\BiggerHealthBar_AlternateFrameFlash.tga",
		coords = {27.5/256, 219/256, 26/128, 96.5/128}
	},
	Mask = {
		path = "Interface\\AddOns\\BiggerHealthBar\\Textures\\BiggerHealthBar_PlayerFrameHealthMask.tga",
		coords = {2/128, 126/128, 15/64, 52/64}
	},
} 

hooksecurefunc("PlayerFrame_ToPlayerArt", function()
	local frameContainer = PlayerFrame.PlayerFrameContainer
	local isAlterntePowerFrame = PlayerFrame.activeAlternatePowerBar
	local frameTexture = isAlterntePowerFrame and frameContainer.AlternatePowerFrameTexture or frameContainer.FrameTexture
	if isAlterntePowerFrame then
		frameTexture:SetTexture(textures["AlternateFrameTexture"].path)
		frameTexture:SetTexCoord(unpack(textures["AlternateFrameTexture"].coords))
		frameContainer.FrameFlash:SetTexture(textures["AlternateFrameFlash"].path)
		frameContainer.FrameFlash:SetTexCoord(unpack(textures["AlternateFrameFlash"].coords))
		PlayerFrameHealthBar.HealthBarMask:SetPoint("TOPLEFT",PlayerFrameHealthBar,-2,9)
		PlayerFrameHealthBar.HealthBarMask:SetPoint("BOTTOMRIGHT",PlayerFrameHealthBar,2,-10)
	else
		frameTexture:SetTexture(textures["FrameTexture"].path)
		frameTexture:SetTexCoord(unpack(textures["FrameTexture"].coords))
		frameContainer.FrameFlash:SetTexture(textures["FrameFlash"].path)
		frameContainer.FrameFlash:SetTexCoord(unpack(textures["FrameFlash"].coords))
		PlayerFrameHealthBar.HealthBarMask:SetTexture(textures["Mask"].path)
		PlayerFrameHealthBar.HealthBarMask:SetPoint("TOPLEFT",PlayerFrameHealthBar,-3,7)
		PlayerFrameHealthBar.HealthBarMask:SetPoint("BOTTOMRIGHT",PlayerFrameHealthBar,2,-12)
	end
	PlayerFrameHealthBar:SetHeight(31)
end)


