--Object Globals
local Names = {};
local Views = {};
local Prev;
local Next;

--Cache vars
local Tickets = {};
local TicketNames = {};
local LastIndex= -1;

--Other
local CurrentPage = 0;
TT_Get = false;
TT_Name = nil;
local PageCount;
TT_Alert = false;

local function Clear()
    for i=0,14 do
        Names[i]:Clear();
        Views[i]:Hide();
    end
end

local function GotoPage(id)
    begin = id*15;
    finish = begin+14;
    Clear();
    for i=begin,finish do
        if Tickets[i] then
            Names[i-begin]:AddMessage(Tickets[i].Name);
            Views[i-begin]:Show();
        end
    end
    Prev:Enable();
    Next:Enable();
    if (begin < 1) then
        Prev:Disable();
    end
    if finish > LastIndex then
        Next:Disable();
    end
    CurrentPage = id;
    TicketTrackerPanel1Bar:Clear();
    if (not PageCount or PageCount > 1) then local PageCount=1;end
    TicketTrackerPanel1Bar:AddMessage(""..(CurrentPage+1).." / "..PageCount);
end



local function Refresh()
    Tickets={};
    TicketNames={};
    LastIndex=-1;
    Clear();
end



local function Reticket()
    outSAY( "gmTicket get" );
end

function TT_Refresh()
    Refresh();
    Reticket();
end

local function AddTicket(name)
    if not TicketNames[name] then
        LastIndex = LastIndex+1;
        Tickets[LastIndex] = {Name=name};
        TicketNames[name] = LastIndex;
        PageCount = math.ceil(LastIndex/15);
    end
end

function TT_Delete(name)
    outSAY( "gmTicket del "..name );
    Refresh();
    Reticket();
end

function GMH_ChatFrameChannelMsgSuppressor(...)
    if(select(9,...)==TicketChannel) then
        return true;
    end
    return false;
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",GMH_ChatFrameChannelMsgSuppressor);

function GMH_ChatFrame_MessageEventHandler(...)
    local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9=...;
    if arg9 == TicketChannel then
        junk,msg = strsplit(" ",arg1)
        args = {strsplit(",",msg)};
        if args[1] == "2" and arg2 == PlayerName:GetText() then
            Refresh();
        elseif args[1] == "5" then
            if not TT_Alert then
                ShowMessage( "New Ticket", "FFFFFF", 1 );
                TT_Alert = true;
            end
            Refresh();
            Reticket();
        elseif args[1] == "0" and args[5] ~= "0" and arg2 == PlayerName:GetText() then
            AddTicket(args[2],0);
            GotoPage(CurrentPage);
        elseif args[1] == "3" and arg2 == PlayerName:GetText() and TT_Get then
            TT_Get = false;
            TT_Name = args[2];
            len = string.len(args[2])+13;
            tt_text="|Hplayer:"..args[2].."|h["..args[2].."]|h: "..string.sub(arg1,len)
            TicketViewPanel1Message:Clear();
            TicketViewPanel1Message:AddMessage(tt_text);
        elseif args[1] == "4" and arg2 == PlayerName:GetText() and not TT_Get then
            tt_text=tt_text.."\n"..string.sub(arg1,len);
            TicketViewPanel1Message:Clear();
            TicketViewPanel1Message:AddMessage(tt_text);
        elseif args and args[1] == "1" then
            TT_Alert = false;
            Refresh();
            Reticket();
        end
    end
end

function TT_Page(up)
    if up then
        GotoPage(CurrentPage+1);
    else
        GotoPage(CurrentPage-1);
    end
    PSound("INTERFACESOUND_CHARWINDOWTAB");
end

function TT_Click(index)
    TT_Get = true;
    TicketViewPanel1Message:Clear();
    outSAY( "gmTicket getid "..Tickets[(CurrentPage*15)+index].Name );
    outSAY( "gm allowwhispers "..Tickets[(CurrentPage*15)+index].Name );
    TicketTracker:Hide();
    TicketView:Show();
    PSound("QUESTLOGOPEN");
end

local function Setup()
    for i=0,14 do
        Names[i] = getglobal("TicketTrackerPanel1Component"..i);
    end
    for i=30,44 do
        Views[i-30] = getglobal("TicketTrackerPanel1Component"..i);
        Views[i-30]:Hide();
    end
    Prev = TicketTrackerPanel1Prev;
    Next = TicketTrackerPanel1Next;
    Prev:Disable();
    Next:Disable();
end

function TT_JoinChannel()
    JoinChannelByName(""..TicketChannel);
end

function TT_LeaveChannel()
    LeaveChannelByName(""..TicketChannel);
end

function TT_Setup(event,...)
    if event == "VARIABLES_LOADED" then
        Setup();
    if GMH_ShowOnLoad then OpenMain(); end
    GMH_CancelOrLoad();
    VIEW_CancelOrLoad();
    elseif event == "PLAYER_LEAVING_WORLD" or event == "PLAYER_LOGOUT" then
        TT_LeaveChannel();
    elseif event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        TT_JoinChannel();
    elseif event == "CHAT_MSG_CHANNEL" then
        GMH_ChatFrame_MessageEventHandler(...);
    end
end

function TT_Show()
    TicketTracker:Show();
    Refresh();
    Reticket();
    PSound("INTERFACESOUND_CHARWINDOWOPEN");
    TT_Alert = false;
end

function TT_SetChannel(msg)
    TT_LeaveChannel();
    TicketChannel=msg;
    ReloadUI();
end

TicketTrackerPanel1Bar:AddMessage("1 / 1");
SlashCmdList["TICKETTRACKER"] = TT_Show;
SLASH_TICKETTRACKER1="/tt";
SlashCmdList["TICKETCHANNEL"] = TT_SetChannel;
SLASH_TICKETCHANNEL1="/ticketchannel";
TicketTracker:RegisterEvent("VARIABLES_LOADED");
TicketTracker:RegisterEvent("PLAYER_LEAVING_WORLD");
TicketTracker:RegisterEvent("PLAYER_ENTERING_WORLD");
TicketTracker:RegisterEvent("PLAYER_LOGOUT");
TicketTracker:RegisterEvent("PLAYER_LOGIN");
TicketTracker:RegisterEvent("CHAT_MSG_CHANNEL");