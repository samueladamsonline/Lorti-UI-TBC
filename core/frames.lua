  --get the addon namespace
  local addon, ns = ...
  --get the config values
  local cfg = ns.cfg
  local dragFrameList = ns.dragFrameList

  ---------------------------------------
  -- ACTIONS
  ---------------------------------------

  -- REMOVING UGLY PARTS OF UI
  
	local event_frame = CreateFrame('Frame')
	local errormessage_blocks = {
	  'Способность пока недоступна',
	  'Выполняется другое действие',
	  'Невозможно делать это на ходу',
	  'Предмет пока недоступен',
	  'Недостаточно',
	  'Некого атаковать',
	  'Заклинание пока недоступно',
	  'У вас нет цели',
	  'Вы пока не можете этого сделать',

	  'Ability is not ready yet',
 	  'Another action is in progress',
	  'Can\'t attack while mounted',
	  'Can\'t do that while moving',
	  'Item is not ready yet',
	  'Not enough',
	  'Nothing to attack',
	  'Spell is not ready yet',
	  'You have no target',
	  'You can\'t do that yet',
	}
	local enable
	local onevent
	local uierrorsframe_addmessage
	local old_uierrosframe_addmessage
	function enable ()
  		old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
  		UIErrorsFrame.AddMessage = uierrorsframe_addmessage
	end

	function uierrorsframe_addmessage (frame, text, red, green, blue, id)
  		for i,v in ipairs(errormessage_blocks) do
    			if text and text:match(v) then
      				return
    			end
  		end
  		old_uierrosframe_addmessage(frame, text, red, green, blue, id)
	end

	function onevent (frame, event, ...)
  		if event == 'PLAYER_LOGIN' then
    			enable()
  		end
	end
	event_frame:SetScript('OnEvent', onevent)
	event_frame:RegisterEvent('PLAYER_LOGIN')
	

  -- COLORING FRAMES
	local CF=CreateFrame("Frame")
	CF:RegisterEvent("PLAYER_ENTERING_WORLD")
	CF:RegisterEvent("GROUP_ROSTER_UPDATE")
	
	hooksecurefunc('TargetFrame_CheckClassification', function(self, forceNormalTexture)
		 local classification = UnitClassification(self.unit);
		if ( classification == "minus" ) then
			self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
			self.borderTexture:SetVertexColor(.05, .05, .05)
			self.nameBackground:Hide();
			self.manabar.pauseUpdates = true;
			self.manabar:Hide();
			self.manabar.TextString:Hide();
			self.manabar.LeftText:Hide();
			self.manabar.RightText:Hide();
			forceNormalTexture = true;
		elseif ( classification == "worldboss" or classification == "elite" ) then
			self.borderTexture:SetTexture("Interface\\AddOns\\Lorti UI Classic\\textures\\target\\elite")
			self.borderTexture:SetVertexColor(1, 1, 1)
		elseif ( classification == "rareelite" ) then
			self.borderTexture:SetTexture("Interface\\AddOns\\Lorti UI Classic\\textures\\target\\rare-elite")
			self.borderTexture:SetVertexColor(1, 1, 1)
		elseif ( classification == "rare" ) then
			self.borderTexture:SetTexture("Interface\\AddOns\\Lorti UI Classic\\textures\\target\\rare")
			self.borderTexture:SetVertexColor(1, 1, 1)
		else
			self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
			self.borderTexture:SetVertexColor(.05, .05, .05)
		end
	end)
	
	function ColorRaid()
		for g = 1, NUM_RAID_GROUPS do
			local group = _G["CompactRaidGroup"..g.."BorderFrame"]
			if group then
				for _, region in pairs({group:GetRegions()}) do
					if region:IsObjectType("Texture") then
						region:SetVertexColor(.05, .05, .05)
					end
				end
			end
			for m = 1, 5 do
				local frame = _G["CompactRaidGroup"..g.."Member"..m]
				if frame then
					groupcolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(.05, .05, .05)
						end
					end
				end
				local frame = _G["CompactRaidFrame"..m]
				if frame then
					singlecolored = true
					for _, region in pairs({frame:GetRegions()}) do
						if region:GetName():find("Border") then
							region:SetVertexColor(.05, .05, .05)
						end
					end
				end
			end
		end
		for _, region in pairs({CompactRaidFrameContainerBorderFrame:GetRegions()}) do
			if region:IsObjectType("Texture") then
				region:SetVertexColor(.05, .05, .05)
			end
		end
	end
	
	CF:SetScript("OnEvent", function(self, event)
		ColorRaid()
		CF:SetScript("OnUpdate", function()
			if CompactRaidGroup1 and not groupcolored == true then
				ColorRaid()
			end
			if CompactRaidFrame1 and not singlecolored == true then
				ColorRaid()
			end
		end)
		if event == "GROUP_ROSTER_UPDATE" then return end
		if not (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or IsAddOnLoaded("X-Perl UnitFrames")) then
                	for i,v in pairs({
				PlayerFrameTexture,
				PlayerFrameAlternateManaBarBorder,
				PlayerFrameAlternateManaBarLeftBorder,
				PlayerFrameAlternateManaBarRightBorder,
				AlternatePowerBarBorder,
				AlternatePowerBarLeftBorder,
				AlternatePowerBarRightBorder,
  				PetFrameTexture,
				PartyMemberFrame1Texture,
				PartyMemberFrame2Texture,
				PartyMemberFrame3Texture,
				PartyMemberFrame4Texture,
				PartyMemberFrame1PetFrameTexture,
				PartyMemberFrame2PetFrameTexture,
				PartyMemberFrame3PetFrameTexture,
				PartyMemberFrame4PetFrameTexture,
   				TargetFrameToTTextureFrameTexture,
				CastingBarFrame.Border,
				TargetFrameSpellBar.Border,

			}) do
                 		v:SetVertexColor(.05, .05, .05)
			end

		
			for _, region in pairs({CompactRaidFrameManager:GetRegions()}) do
				if region:IsObjectType("Texture") then
					region:SetVertexColor(.05, .05, .05)
				end
			end
			for _, region in pairs({CompactRaidFrameManagerContainerResizeFrame:GetRegions()}) do
				if region:GetName():find("Border") then
					region:SetVertexColor(.05, .05, .05)
				end
			end
			CompactRaidFrameManagerToggleButton:SetNormalTexture("Interface\\AddOns\\Lorti UI Classic\\textures\\raid\\RaidPanel-Toggle")
			
			hooksecurefunc("GameTooltip_ShowCompareItem", function(self, anchorFrame)
				if self then
					local shoppingTooltip1, shoppingTooltip2 = unpack(self.shoppingTooltips)
					shoppingTooltip1:SetBackdropBorderColor(.05, .05, .05)
					shoppingTooltip2:SetBackdropBorderColor(.05, .05, .05)
				end
			end)
			
			
			GameTooltip:SetBackdropBorderColor(.05, .05, .05)
			GameTooltip.SetBackdropBorderColor = function() end
			
			for i,v in pairs({
				PlayerPVPIcon,
				TargetFrameTextureFramePVPIcon,
			}) do
				v:SetAlpha(0)
			end
			for i=1,4 do 
				_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
				_G["PartyMemberFrame"..i.."NotPresentIcon"]:Hide()
				_G["PartyMemberFrame"..i.."NotPresentIcon"].Show = function() end
			end
			PlayerFrameGroupIndicator:SetAlpha(0)
			PlayerHitIndicator:SetText(nil) 
			PlayerHitIndicator.SetText = function() end
			PetHitIndicator:SetText(nil) 
			PetHitIndicator.SetText = function() end

		else
			CastingBarFrameBorder:SetVertexColor(.05,.05,.05)    
		end
	end)
   
 -- COLORING THE MAIN BAR
for i,v in pairs({
      SlidingActionBarTexture0,
      SlidingActionBarTexture1,
      MainMenuBarTexture0,
      MainMenuBarTexture1,
      MainMenuBarTexture2,
      MainMenuBarTexture3,
      MainMenuMaxLevelBar0,
      MainMenuMaxLevelBar1, 
      MainMenuMaxLevelBar2,
      MainMenuMaxLevelBar3,
	  MainMenuXPBarTexture0,
      MainMenuXPBarTexture1,
	  MainMenuXPBarTexture2,
	  MainMenuXPBarTexture3,
	  MainMenuXPBarTexture4,
	  ReputationWatchBar.StatusBar.WatchBarTexture0,
      ReputationWatchBar.StatusBar.WatchBarTexture1,
      ReputationWatchBar.StatusBar.WatchBarTexture2,
      ReputationWatchBar.StatusBar.WatchBarTexture3,

}) do
   
   v:SetVertexColor(.2, .2, .2)
   
end 

 -- RECOLOR GRYPHONS    
for i,v in pairs({
      MainMenuBarLeftEndCap,
      MainMenuBarRightEndCap, 
      StanceBarLeft,
      StanceBarMiddle,
      StanceBarRight,

}) do
   v:SetVertexColor(.35, .35, .35)
end 
 -- RECOLOR MINIMAP
for i,v in pairs({
      MinimapBorder,
	  MinimapBorderTop,
      MiniMapMailBorder,
}) do
   v:SetVertexColor(.05, .05, .05)
   end
 -- RECOLOR LOOT WINDOW
 for i,v in pairs({
      LootFrameBg,
	  LootFrameRightBorder,
      LootFrameLeftBorder,
      LootFrameTopBorder,
      LootFrameBottomBorder,
	  LootFrameTopRightCorner,
      LootFrameTopLeftCorner,
      LootFrameBotRightCorner,
      LootFrameBotLeftCorner,
	  LootFrameInsetInsetTopRightCorner,
	  LootFrameInsetInsetTopLeftCorner,
	  LootFrameInsetInsetBotRightCorner,
	  LootFrameInsetInsetBotLeftCorner,
      LootFrameInsetInsetRightBorder,
      LootFrameInsetInsetLeftBorder,
      LootFrameInsetInsetTopBorder,
      LootFrameInsetInsetBottomBorder,
	  LootFramePortraitFrame,
	  ContainerFrame1BackgroundTop,
}) do
   v:SetVertexColor(.35, .35, .35)
end

for i,v in pairs({
      LootFrameInsetBg,
      LootFrameTitleBg,
}) do
   v:SetVertexColor(.05, .05, .05)
end		

--ClassColor on the Unitframes

local ClassColorUnits = {
["target"] = {
   ["name"] = "TargetFrame",
   ["back"] = "TargetFrame",
   ["x-offset"] = -104,
   ["y-offset"] = 60,
   ["x-offset2"] = 6,
   ["y-offset2"] = -22,
},
["player"] = {
   ["name"] = "PlayerFrame",
   ["back"] = "PlayerFrameBackground",
   ["x-offset"] = 0,
   ["y-offset"] = 22,
   ["x-offset2"] = 0,
   ["y-offset2"] = 0,
},


}
local function updateClassColor(unit)
   if(unit and UnitExists(unit)) then
      local _,class = UnitClass(unit)
      if(class and RAID_CLASS_COLORS[class]) then
         if(ClassColorUnits[unit]) then
            local uf = _G[ClassColorUnits[unit]['name']]
            local bg = _G[ClassColorUnits[unit]['back']]
            if(not uf['unitClassColorBack']) then
               uf['unitClassColorBack'] = uf:CreateTexture(nil, "ARTWORK")
               uf['unitClassColorBack']:SetPoint("TOPLEFT", bg, ClassColorUnits[unit]['x-offset2'], ClassColorUnits[unit]['y-offset2'])
               uf['unitClassColorBack']:SetPoint("BOTTOMRIGHT", bg, ClassColorUnits[unit]['x-offset'], ClassColorUnits[unit]['y-offset'])
               uf['unitClassColorBack']:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
            end
            local col = RAID_CLASS_COLORS[class]
            uf['unitClassColorBack']:SetVertexColor(col['r'], col['g'], col['b'])
         end
      end
   end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
      if(event=="PLAYER_TARGET_CHANGED") then
         updateClassColor('target')
      elseif(event=="PLAYER_ENTERING_WORLD") then
         updateClassColor('player')
         self:UnregisterEvent(event)
      end
end)

