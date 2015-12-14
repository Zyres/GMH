function GMHMinimap_Show()
    GameTooltip:SetOwner( this, "ANCHOR_LEFT" );
    GameTooltip:AddLine( "|cFF00FF00GMH "..gmhversion.." r"..gmhbuild.."|r" );
    GameTooltip:AddLine( "|cFFFFFC00Left click to show/hide|r" );
    GameTooltip:AddLine( "|cFFFFFFFFRight click to drag this|r" );
    GameTooltip:Show();
end

function GMHMinimap_Initialize()
    if not GMHMinimapPosition then
        GMHMinimapPosition = -25;
    end
end

function GMHMinimap_BeingDragged()
    local xpos,ypos = GetCursorPosition();
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();
    xpos = xmin-xpos/UIParent:GetScale()+70;
    ypos = ypos/UIParent:GetScale()-ymin-70;
    GMHMinimap_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function GMHMinimap_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end
    GMHMinimapPosition = v;
    GMHMinimap_UpdatePosition();
end

function GMHMinimap_UpdatePosition()
    GMHelper_MinimapButton:SetPoint(
        "TOPLEFT",
        "Minimap",
        "TOPLEFT",
        54 - (78 * cos(GMHMinimapPosition)),
        (78 * sin(GMHMinimapPosition)) - 55
    );
end