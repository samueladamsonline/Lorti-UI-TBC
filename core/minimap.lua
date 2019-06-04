
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(mp, input)
local zoom = Minimap:GetZoom()
    if input > 0 and zoom < 5 then
		mp:SetZoom(zoom +1)
    elseif input < 0 and zoom > 0 then
		mp:SetZoom(zoom -1)
    end
end)

for i, v in pairs({
	MinimapBorderTop,
	MinimapToggleButton,
	MiniMapWorldMapButton,
	GameTimeFrame,
	MinimapZoomIn,
	MinimapZoomOut
    }) do
        v:Hide()
    end
