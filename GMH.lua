-- SavedVariables
TicketChannel = "gm_sync_channel";
savedannflag = {};
savedannmsg = {};
gmhversion = GetAddOnMetadata("GMH", "Version");
gmhbuild = GetAddOnMetadata("GMH", "X-Revision");

function OpenMain()
    if(gmhview == 2) then
        MinipForm:Show();
    elseif(gmhview == 3) then
        MiniForm:Show();
    else
        FullForm:Show();
    end
end

function ToggleAddon()
    if addonopen then
        FullForm:Hide();
        MiniForm:Hide();
        MinipForm:Hide();
        AnnounceForm:Hide();
        BanForm:Hide();
        BattlegroundForm:Hide();
        CommForm:Hide()
        EventForm:Hide();
        IPBanForm:Hide();
        ItemForm:Hide();
        ItemFormSearch:Hide();
        MiscForm:Hide();
        ModifyForm:Hide();
        NPCForm:Hide();
        ObjectForm:Hide();
        OverridesForm:Hide();
        PlayerForm:Hide();
        ProfessionsForm:Hide();
        QuestForm:Hide();
        QuickItemForm:Hide();
        ItemsetArena8:Hide();
        ItemsetTier10:Hide();
        QuickPortalForm:Hide();
        SkillForm:Hide();
        SpellForm:Hide();
        TeleForm:Hide();
        WepskForm:Hide();
        TicketView:Hide();
        TicketTracker:Hide();
        PSound("INTERFACESOUND_CHARWINDOWCLOSE");
        addonopen = false;
    else
        OpenMain();
        PSound("INTERFACESOUND_CHARWINDOWOPEN");
        addonopen = true;
    end
end

function outSAY(text, BoolChat)
local sendto = "GUILD";
    if BoolChat then
        SendChatMessage(text, sendto);
    else
        SendChatMessage("."..text, sendto);
    end
end

--[[ ShowMessage Syntax == ShowMessage("Message", "Hex Color", Chat Frame(0) or UIErrorsFrame(1) or RaidNotice(2));
Chat Frame = 0 || UIErrorsFrame = 1 || Raid Notice = 2
Ex. ShowMessage("GM Helper v1.1.0 loaded!", "00FF00", 1);  Sends GM Helper v1.1.0 loaded! to UI Errors Frame in the color Green ]]
function ShowMessage(StrMsg, StrHex, BoolFrame)
    if not StrHex then StrHex = "FF0000" end
    local StrHex1,StrHex2,StrHex3 = string.match(StrHex, "(..)(..)(..)");
    local IntCol1 = (tonumber(StrHex1, 16) / 255);
    local IntCol2 = (tonumber(StrHex2, 16) / 255);
    local IntCol3 = (tonumber(StrHex3, 16) / 255);-- local decstr = tostring(number)
    local color = {r = IntCol1, g = IntCol2, b = IntCol3}
    if(BoolFrame == 1) then
        UIErrorsFrame:AddMessage(StrMsg, IntCol1, IntCol2, IntCol3);
    elseif(BoolFrame == 2) then
        RaidNotice_AddMessage(RaidBossEmoteFrame, StrMsg, color);
    else
        DEFAULT_CHAT_FRAME:AddMessage(StrMsg, IntCol1, IntCol2, IntCol3);
    end
end

function GMHelperOnLoad(self)
    self:RegisterForDrag("RightButton");
end

function GMH_VersionCheck()
local wowbuild = select(4, GetBuildInfo());
if (wowbuild == 30100 or wowbuild == 30200) then 
    GMHelper_Loaded()
else
    _ERRORMESSAGE("Your WoW Client ("..select(1, GetBuildInfo())..") is not supported by GMH!")
end

end

function GMHelper_Loaded()
    ShowMessage("GM Helper "..gmhversion.." r"..gmhbuild.." loaded!", "00FF00");
end

function PSound(sound)
    PlaySound(sound);
end

function GMH_EmptyField()
    ShowMessage("Please complete the required fields!");
end

-- Binding Variables
BINDING_HEADER_GMHelper = "GM Helper";
BINDING_NAME_ToggleAddon = "Toggles GM Helper";
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ban Script
function BanPlayer()
    outSAY("ban char "..CharName:GetText().." "..BanReason:GetText().." "..BanLength:GetText());
end

function BanAccount()
    outSAY("ban account "..CharName:GetText().." "..BanReason:GetText().." "..BanLength:GetText());
end

function BanAll()
    outSAY("ban all "..CharName:GetText().." "..BanReason:GetText().." "..BanLength:GetText());
end

function UnBanPlayer()
    outSAY("unban char "..CharName:GetText());
end

function UnBanAccount()
    outSAY("unban account "..CharName:GetText());
end

function AddIPBan()
    outSAY("ban ip "..IPAddress1:GetText().." "..Duration1:GetText());
end

function DelIPBan()
    outSAY("unban ip "..IPAddress1:GetText());
end

function KickPlayer()
    outSAY("kickplayer "..CharName:GetText().." "..BanReason:GetText());
end

function DiscPlayer()
    outSAY("kick player "..CharName:GetText());
end

function ParPlayer()
    outSAY("paralyze "..CharName:GetText());
end

function UnParPlayer()
    outSAY("unparalyze "..CharName:GetText());
end

function PInfo()
    outSAY("playerinfo "..CharName:GetText());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BattlegroundScript
function BGStart()
    outSAY("battleground startbg");
end

function BGForceStart()
    outSAY("battleground forcestart");
end

function BGInfo()
    outSAY("battleground bginfo");
end

function BGLeave()
    outSAY("battleground leave");
end

function BGGetQueue()
    outSAY("battleground getqueue");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CommScript
function AnnounceChecked()
    if AnnounceCheck:GetChecked() or ScreenCheck:GetChecked() or GMAnnounceCheck:GetChecked() then
        Announce();
    else
        ShowMessage("Please choose where to Announce!");
    end
end

function Announce()
    local ArrCheck = { AnnounceCheck:GetChecked(), ScreenCheck:GetChecked(), GMAnnounceCheck:GetChecked() };
    local ArrChan = { "announce ", "wannounce ", "gmannounce " };
    for a = 1, 3 do
        if(ArrCheck[a]) then
            outSAY(ArrChan[a]..AnnounceText:GetText());
        end
    end
end

function WhisperOn()
    outSAY("gm allowwhispers "..PlayerName2:GetText());
end

function WhisperOff()
    outSAY("gm blockwhispers "..PlayerName2:GetText());
end

function SaveAnnSend(a)
    local b = savedannflag[a];
    if savedannmsg[a] then
        if(b >= 4) then outSAY("gmannounce "..savedannmsg[a]); b = b - 4; end
        if(b >= 2) then outSAY("wannounce "..savedannmsg[a]); b = b - 2; end
        if(b >= 1) then outSAY("announce "..savedannmsg[a]); b = b - 1; end
    else
        ShowMessage("Announcement not set! Please set it in the AnnounceForm.");
    end
end

function ShowSavedAnn(a)
    if savedannmsg[a] then
        ShowMessage("Saved Announcement #"..a..": "..savedannmsg[a], "FFFFFF");
    else
        ShowMessage("Announcement not set! Please set it in the AnnounceForm.");
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- AnnounceScript
function SetAnnouncementChecked()
    if AnnounceCheck:GetChecked() or ScreenCheck:GetChecked() or GMAnnounceCheck:GetChecked() then
        Announce();
    else
        ShowMessage("Please choose where to Announce!")
    end
end

function SaveAnnStore(a)
    local b = 0;
    if(AnnounceSetCheck:GetChecked()) then b = b + 1; end
    if(ScreenAnnounceSetCheck:GetChecked()) then b = b + 2; end
    if(GMAnnounceSetCheck:GetChecked()) then b = b + 4; end
    if(b > 0) then
        savedannmsg[a] = SetAnnounceText:GetText();
        savedannflag[a] = (b);
        ShowMessage("Announcement #"..a.." Saved!", "00FF00");
    else
        ShowMessage("Please choose where to Announce!");
    end
end

function GoDownButtonCheck()
local a = SavAnnTxtShow:GetNumber();
    if (a >= 2) then
        SavAnnTxtShow:SetNumber(a - 1);
    end
end

function PreviewAnnTxt()
local a = SavAnnTxtShow:GetNumber();
if savedannmsg[a] then
GMH_ShowMessage(savedannmsg[a])
else
ShowMessage("Announcement #"..a.." has not been set yet!")
end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ItemScript
function RemoveItem()
    outSAY("char removeitem "..ItemNumber:GetText());
end

function AddItem()
    outSAY("char add item "..ItemNumber:GetText().." "..ItemQuantity1:GetText());
end

function AddItemSet()
    outSAY("char add itemset "..ItemSetNumber:GetText());
end

function SearchItem()
    outSAY("lookup item "..ItemNumber:GetText());
end

function AddMoney()
    IntGold = Gold:GetNumber() * 10000;
    IntSilver = Silver:GetNumber() * 100;
    IntCopper = Copper:GetNumber();
    outSAY("modify gold " ..(IntGold + IntSilver + IntCopper));
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MiscScript
function SInfo()
    outSAY("server info");
end

function Invis()
    outSAY("invisible");
end

function Invince()
    outSAY("invincible");
end

function SRestart()
    outSAY("server restart "..AdminEditBox:GetText());
end

function SShutdown()
    outSAY("server shutdown "..AdminEditBox:GetText());
end

function CancelShutdown()
    outSAY("server cancelshutdown");
end

function SaveAll()
    outSAY("server saveall "..AdminEditBox:GetText());
end

function MassSummon()
    outSAY("admin masssummon "..AdminEditBox:GetText()); -- EditBox not neccessary, but there is an optional argument for the command.
end

function PlayAll()
    outSAY("admin playall "..AdminEditBox:GetText());
end

function CastAll()
    outSAY("admin castall "..AdminEditBox:GetText());
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ModifyScript

function Modify()
local selection = UIDropDownMenu_GetText(ModifyComboBox)
    if selection == "Armor" then
        modify = "armor";
    elseif selection == "HP" then
        modify = "hp";
    elseif selection == "Runic" then
        modify = "runic";
    elseif selection == "Rage" then
        modify = "rage";
    elseif selection == "Mana" then
        modify = "mana";
    elseif selection == "Energy" then
        modify = "energy";
    elseif selection == "Damage" then
        modify = "damage";
    elseif selection == "Spirit" then
        modify = "spirit";
    elseif selection == "Speed" then
        modify = "speed";
    elseif selection == "Scale" then
        modify = "scale";
    elseif selection == "Faction" then
        modify = "faction";
    elseif selection == "Display" then
        modify = "displayid";
    elseif selection == "Talents" then
        modify = "talentpoints";
    elseif selection == "Holy Resist" then
        modify = "holy";
    elseif selection == "Fire Resist" then
        modify = "fire";
    elseif selection == "Nature Resist" then
        modify = "nature";
    elseif selection == "Frost Resist" then
        modify = "frost";
    elseif selection == "Shadow Resist" then
        modify = "shadow";
    elseif selection == "Arcane Resist" then
        modify = "arcane";
    end
    outSAY("modify "..modify.." "..ModifyEditBox:GetText());
end

function Demorph()
    outSAY("demorph");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NPCScript
function AddItemVendor()
    outSAY("npc vendoradditem "..NPCItemNumber:GetText());
end

function RemoveItemVendor()
    outSAY("npc vendorremoveitem "..NPCItemNumber:GetText());
end

function SpawnNPC()
    outSAY("npc spawn "..NPCNumber:GetText().." 1");
end

function LookupNPC()
    outSAY("lookup creature "..NPCNumber:GetText());
end

function DeleteNPC()
    outSAY("npc delete");
end

function NPCCome()
    outSAY("npc come");
end

function NPCPos()
    outSAY("npc possess");
end

function NPCUnPos()
    outSAY("npc unpossess");
end

function NPCInfo()
    outSAY("npc info");
end

function WaypointsAdd()
    outSAY("waypoint add");
end

function WaypointsDel()
    outSAY("waypoint delete");
end

function WaypointsShow()
    outSAY("waypoint show");
end

function WaypointsHide()
    outSAY("waypoint hide");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ObjectScript
function TargetObject()
    outSAY("go select");
end

function LookupObject()
    outSAY("lookup object "..ObjectNumber:GetText());
end

function ObjectScale()
    outSAY("go scale "..ObjectNumber:GetText());
end

function ObjectInfo()
    outSAY("go info");
end

function DeleteObject()
    outSAY("go delete");
end

function PlaceObject()
    PlaceObjectTrue();
end

function PlaceObjectTrue()
    if NoSaveCheck:GetChecked() then a = "" else a = "1" end
    outSAY("go spawn "..ObjectNumber:GetText().." "..a);
end

function ObjectInfo()
    outSAY("go info");
end

function ActivateObject()
    outSAY("go activate");
end

function EnableObject()
    outSAY("go enable");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OverridesScript
function CheatStatus()
    outSAY("cheat status");
end

function CheatUpdate()
    if(FlyCheck:GetChecked()) then a = "on"; else a = "off"; end--fly
    outSAY("cheat fly "..a);
    if(GodCheck:GetChecked()) then a = "on"; else a = "off"; end--god
    outSAY("cheat god "..a);
    if(NCDCheck:GetChecked()) then a = "on"; else a = "off"; end--cooldown
    outSAY("cheat cooldown "..a);
    if(NCTCheck:GetChecked()) then a = "on"; else a = "off"; end--casttime
    outSAY("cheat casttime "..a);
    if(PowCheck:GetChecked()) then a = "on"; else a = "off"; end--power
    outSAY("cheat power "..a);
    if(AuraCheck:GetChecked()) then a = "on"; else a = "off"; end--stack
    outSAY("cheat stack "..a);
    if(TrigCheck:GetChecked()) then a = "on"; else a = "off"; end--triggers
    outSAY("cheat triggerpass "..a);
end 

function FlySpeed()
if FlyEntry:GetText() == "" then
Fly_Speed = 7.5;
elseif(FlyEntry:GetNumber() < 2) then
Fly_Speed = FlyEntry:GetNumber();
else
Fly_Speed = FlyEntry:GetNumber() / 2; --Divide it before it's sent to get the actual desired speed. .mod speed doubles your input for flying.
end
outSAY("mod speed "..Fly_Speed);
end

function FlightPath()
    if(TaxiCheck:GetChecked()) then a = "on"; else a = "off"; end --Taxi
        outSAY("cheat taxi "..a);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerScript
function CreateGuild()
    outSAY("guild create "..PlayerFormBox:GetText());
end

function LevelPlayer()
    outSAY("mod level "..PlayerFormBox:GetText());
end

function RevivePlayer2()
    outSAY("reviveplr "..PlayerFormBox:GetText());
end

function LookupFaction()
    outSAY("lookup faction "..PlayerFormBox:GetText());
end

function AchieveComplete()
    outSAY("achieve complete "..PlayerFormBox:GetText());
end

function LookupAchievement()
    outSAY("lookup achievement "..PlayerFormBox:GetText());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ProfessionsForm

function LearnProfession()
local selection = UIDropDownMenu_GetText(ProfComboBox)
    if selection == "Alchemy" then
        profession = 171;
    elseif selection == "BSing" then
        profession = 164;
    elseif selection == "Enchanting" then
        profession = 333;
    elseif selection == "Engineering" then
        profession = 202;
    elseif selection == "Herbalism" then
        profession = 182;
    elseif selection == "Tailoring" then
        profession = 197;
    elseif selection == "Fishing" then
        profession = 356;
    elseif selection == "Poisons" then
        profession = 40;
    elseif selection == "Jewelcraft" then
        profession = 755;
    elseif selection == "LWing" then
        profession = 165;
    elseif selection == "Mining" then
        profession = 186;
    elseif selection == "Inscription" then
        profession = 773;
    elseif selection == "Skinning" then
        profession = 393;
    elseif selection == "Cooking" then
        profession = 185;
    elseif selection == "First Aid" then
        profession = 129;
    end
    outSAY("char advancesk "..profession);
    outSAY("char advancesk "..profession.." "..SkillLevel:GetText());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--QuestScript

function LookupQuest()
    outSAY("lookup quest "..QuestFormBox:GetText());
end

function QuestComplete()
    outSAY("quest complete "..QuestFormBox:GetText());
end

function QuestStart()
    outSAY("quest start "..QuestFormBox:GetText());
end

function QuestRemove()
    outSAY("quest remove "..QuestFormBox:GetText());
end

function QuestStatus()
    outSAY("quest status "..QuestFormBox:GetText());
end

function QuestReward()
    outSAY("quest reward "..QuestFormBox:GetText());
end

function QuestSpawn()
if StartCheckButton:GetChecked() and FinishCheckButton:GetChecked() then
    ShowMessage("Please select Start or Finish! Not Both!", "FF0000", 1);
elseif FinishCheckButton:GetChecked() then
    outSAY("quest finishspawn "..QuestFormBox:GetText());
elseif StartCheckButton:GetChecked() then
    outSAY("quest startspawn "..QuestFormBox:GetText());
else
    ShowMessage("Please select Start or Finish!", "FF0000", 1);
end
end

function QuestAdd()
if StartCheckButton:GetChecked() and FinishCheckButton:GetChecked() then
    outSAY("quest addboth "..QuestFormBox:GetText());
elseif FinishCheckButton:GetChecked() then
    outSAY("quest addfinish "..QuestFormBox:GetText());
elseif StartCheckButton:GetChecked() then
    outSAY("quest addstart "..QuestFormBox:GetText());
else
    ShowMessage("Please select Start, Finish, or Both!", "FF0000", 1);
end
end

function QuestDel()
if StartCheckButton:GetChecked() and FinishCheckButton:GetChecked() then
    outSAY("quest delboth "..QuestFormBox:GetText());
elseif FinishCheckButton:GetChecked() then
    outSAY("quest delfinish "..QuestFormBox:GetText());
elseif StartCheckButton:GetChecked() then
    outSAY("quest delstart "..QuestFormBox:GetText());
else
    ShowMessage("Please select Start, Finish, or Both!", "FF0000", 1);
end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--QuickItemScript
function GmOutfit()
    outSAY("char add item 192");--Martin Thunder
    outSAY("char add item 2586");--Gamemaster's Robe
    outSAY("char add item 11508");--Gamemaster's Slippers
    outSAY("char add item 12064");--Gamemaster's Hood
    outSAY("char add item 19879");--Alex's Test Beatdown Staff
    outSAY("char add item 19160");--Contest Winner's Tabbard
    outSAY("char add item 12947 2");--Alex's Ring of Audacity X2
    outSAY("char add item 23162 4");--Foror's Crate of Endless Resist Gear Storage X4
end

function Food()
    outSAY("char add item 45932 20");--Black Jelly
end

function Potion()
    outSAY("char add item 41166 20");--Runic Healing Injector X20
    outSAY("char add item 42545 20");--Runic Mana Injector X20
end

function Gold()
    outSAY("char add gold 5000");--Gold
end

-------- Item Set Arena 8 --------
function MageA8R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -280"); -- Wrathful Gladiator's Regalia
end

function DeathKnightA8D()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -269"); -- Wrathful Gladiator's Desecration
end

function HunterA8P()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -273"); -- Wrathful Gladiator's Pursuit
end

function RogueA8V()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -277"); -- Wrathful Gladiator's Vestments
end

function WarlockA8F()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -281"); -- Wrathful Gladiator's Felshroud
end

function WarriorA8B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -266"); -- Wrathful Gladiator's Battlegear
end

function PriestA8I()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -278"); -- Wrathful Gladiator's Investiture
end

function PriestA8R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -279"); -- Wrathful Gladiator's Raiment
end

function PaladinA8R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -268"); -- Wrathful Gladiator's Redemption
end

function PaladinA8V()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -267"); -- Wrathful Gladiator's Vindication
end

function ShamanA8E()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -271"); -- Wrathful Gladiator's Earthshaker
end

function ShamanA8T()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -270"); -- Wrathful Gladiator's Thunderfist
end

function ShamanA8W()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -272"); -- Wrathful Gladiator's Wartide
end

function DruidA8R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -274"); -- Wrathful Gladiator's Refuge
end

function DruidA8S()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -276"); -- Wrathful Gladiator's Sanctuary
end

function DruidA8W()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -275"); -- Wrathful Gladiator's Wildhide
end

-------- Item Set Tier 10 --------
function MageT10R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -247");--Sanctified Bloodmage's Regalia
end

function HunterT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -255");--Sanctified Ahn'Kahar Blood Hunter's Battlegear
end

function RogueT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -254");--Sanctified Shadowblade's Battlegear
end

function WarlockT10R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -248");--Sanctified Dark Coven's Regalia
end

function DeathKnightT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -261");--Sanctified Scourgelord's Battlegear
end

function DeathKnightT10P()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -262");--Sanctified Scourgelord's Plate
end

function PriestT10R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -249");--Sanctified Crimson Acolyte's Raiment
end

function PriestT10R2()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -250");--Sanctified Crimson Acolyte's Regalia
end

function WarriorT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -259");--Sanctified Ymirjar Lord's Battleplate
end

function WarriorT10P()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -260");--Sanctified Ymirjar Lord's Plate
end

function DruidT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -253");--Sanctified Lasherweave Battlegear
end

function DruidT10G()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -251");--Sanctified Lasherweave Garb
end

function DruidT10R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -252");--Sanctified Lasherweave Regalia
end

function ShamanT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -258");--Sanctified Frost Witch's Battlegear
end

function ShamanT10G()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -256");--Sanctified Frost Witch's Garb
    outSAY("char add item 50464");--Totem of the Surging Sea
end

function ShamanT10R()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -257");--Sanctified Frost Witch's Regalia
end

function PaladinT10B()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -264");--Sanctified Lightsworn Battlegear
end

function PaladinT10G()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -263");--Sanctified Lightsworn Garb
end

function PaladinT10P()
    outSAY("modify level 80");--Levels Up To 80
    outSAY("char add itemset -265");--Sanctified Lightsworn Plate
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QuickPortalScript
function QPStormwind()
    outSAY("go spawn 176296 1");
end

function QPIronforge()
    outSAY("go spawn 176497 1");
end

function QPDarnassus()
    outSAY("go spawn 176498 1");
end

function QPExodar()
    outSAY("go spawn 182351 1");
end

function QPOrgrimmar()
    outSAY("go spawn 176499 1");
end

function QPUndercity()
    outSAY("go spawn 176501 1");
end

function QPThunderbluff()
    outSAY("go spawn 176500 1");
end

function QPSilvermoon()
    outSAY("go spawn 182352 1");
end

function QPShattrath()
    outSAY("go spawn 183384 1");
end

function QPDalaran()
    outSAY("go spawn 191164 1");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SkillScript
function LookupSkill()
    outSAY("lookup skill "..SkillNumber:GetText());
end

function LearnSkill()
    outSAY("char advancesk "..SkillNumber:GetText().." "..SkillLvl:GetText().." "..SkillMax:GetText());
end

function UnLearnSkill()
    outSAY("char removesk "..SkillNumber:GetText());
end

function AdvanceAll()
    outSAY("char advanceallskills "..SkillsBy:GetText());
end

function LearnRiding()
    outSAY("char learn 33388");--Apprentice Riding
    outSAY("char learn 33391");--Journeyman Riding
    outSAY("char learn 34090");--Expert Riding
    outSAY("char learn 34091");--Artisan Riding
    outSAY("char learn 54197");--Cold Weather Flying
    outSAY("char add item 32458"); -- Ashes of Al'ar
    outSAY("char add item 43962"); -- Reins of the White Polar Bear
    outSAY("char add item 49290"); -- Magic Rooster Egg
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SpellScript
function LearnSpell()
    outSAY("char learn "..SpellNumber:GetText());
end

function UnlearnSpell()
    outSAY("char unlearn "..SpellNumber:GetText());
end

function LearnAll()
    outSAY("char learn all");
end

function LookupSpell()
    outSAY("lookup spell "..SpellNumber:GetText());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TeleScript
function GoName()
    outSAY("appear "..ToPlayerName:GetText());
end

function NameGo()
    outSAY("summon "..ToPlayerName:GetText());
end

function SearchTele()
    outSAY("recall list "..ZoneName:GetText());
end

function Tele()
    outSAY("recall port "..ZoneName:GetText());
end

function AddPort()
    outSAY("recall add "..ZoneName:GetText());
end

function DelPort()
    outSAY("recall del "..ZoneName:GetText());
end

function PortPlayer()
    outSAY("recall portplayer "..ToPlayerName:GetText().." "..ZoneName:GetText());
end

function PortUs()
    outSAY("recall portus "..ZoneName:GetText());
end

function WorldPort()
    outSAY("worldport "..MapID:GetText().." "..XCord:GetText().." "..YCord:GetText().." "..ZCord:GetText());
end

function GPS()
    outSAY("gps");
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WepskScript

function LearnWepsk()
local selection = UIDropDownMenu_GetText(WepskComboBox)
    if selection == "Swords" then
        wepsk = 43;
    elseif selection == "Unarmed" then
        wepsk = 136;
    elseif selection == "Thrown" then
        wepsk = 176;
    elseif selection == "Daggers" then
        wepsk = 173;
    elseif selection == "Maces" then
        wepsk = 54;
    elseif selection == "Dual Wield" then
        wepsk = 118;
    elseif selection == "Crossbow" then
        wepsk = 226;
    elseif selection == "Staves" then
        wepsk = 136;
    elseif selection == "Axes" then
        wepsk = 44;
    elseif selection == "Wand" then
        wepsk = 228;
    elseif selection == "Guns" then
        wepsk = 46;
    elseif selection == "Bows" then
        wepsk = 45;
    elseif selection == "Fist" then
        wepsk = 473;
    elseif selection == "Polearm" then
        wepsk = 229;
    elseif selection == "2H Axe" then
        wepsk = 172;
    elseif selection == "2H Mace" then
        wepsk = 160;
    elseif selection == "2H Swords" then
        wepsk = 55;
    end
    outSAY("char advancesk "..wepsk.." "..WeaponSkillLvl:GetText());
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GMH_Main(msg)
msg = string.lower(msg)
if msg == "show" or msg == "hide" then
    ToggleAddon()
else
    GMH_MainMsg("GMH Version "..gmhversion.." r"..gmhbuild);
    GMH_MainMsg("/gmh - displays this menu");
    GMH_MainMsg("/gmh (show or hide) - Shows or Hides GMH");
    GMH_MainMsg("/gm (on or off) - Toggles GM");
    GMH_MainMsg("/revive - revives yourself");
    GMH_MainMsg("/recallport or /recall or /port - Ports yourself to location");
    GMH_MainMsg("/npcspawn - spawns NPC - e.g. /npcspawn 1");
    GMH_MainMsg("/npcdelete - deleted targeted NPC");
    GMH_MainMsg("/add item - adds item to you or target - e.g. /add item 1");
    GMH_MainMsg("/announce or /an - broadcasts message to server in chatbox");
    GMH_MainMsg("/wannounce or /wan - broadcasts message to server on the screen");
    GMH_MainMsg("/gmannounce or /gman - broadcasts message to other GMs in chatbox");
    GMH_MainMsg("/savedannounce or /sa - broadcasts saved message");
    GMH_MainMsg("/showsavedannounce, /showsaved, or /ssa - Shows you Saved Announcement");
    GMH_MainMsg("/advanceall or /advanceallskills - Advances all of your or your target's skills by X.");
    GMH_MainMsg("/revive - revives yourself");
    GMH_MainMsg("/reviveplr - revives plr x");
    GMH_MainMsg("/learn - learns spells to you or targeted player - e.g. /learn all - Learns all spells for your class");
    GMH_MainMsg("/unlearn - unlearns spell id on you or targeted player - e.g. /unlearn 1");
    GMH_MainMsg("/achievecomplete - Completes achievement on targeted player - e.g. /achievecomplete 1");
    GMH_MainMsg("/lookup - Looks up term under specified subject - e.g. /lookup item Gamemaster");
    GMH_MainMsg("/kickplayer - Kicks specified player with or without reason. - e.g. /kickplayer Name Reason");
end
end

function GMH_MainMsg(msg)
    ShowMessage(msg, "00FF00");
end

function GMH_GMToggle(msg)
msg = string.lower(msg)
    if msg == "on" or msg == "off" then
        outSAY("gm "..msg);
    else
        ShowMessage("Available options: on or off");
    end
end

function GMH_Revive()
    outSAY("revive");
end

function GMH_NPCSpawn(msg)
    outSAY("npc spawn "..msg);
end

function GMH_NPCDelete()
    outSAY("npc delete");
end

function GMH_AddItem(msg)
    outSAY("char add item "..msg);
end

function GMH_Announce(msg)
    outSAY("announce "..msg);
end

function GMH_WAnnounce(msg)
    outSAY("wannounce "..msg);
end

function GMH_GMAnnounce(msg)
    outSAY("gmannounce "..msg);
end

function GMH_RecallPort(msg)
    outSAY("recall port "..msg);
end

function GMH_SavedAnnounce(msg)
    SaveAnnSend(tonumber(msg));
end

function GMH_ShowSavedAnn(msg)
    ShowSavedAnn(tonumber(msg));
end

function GMH_Learn(msg)
    outSAY("char learn "..msg);
end

function GMH_UnLearn(msg)
    outSAY("char unlearn "..msg);
end

function GMH_Revive(msg)
    outSAY("revive");
end

function GMH_RevivePlr(msg)
    outSAY("reviveplr "..msg);
end

function GMH_AdvanceAllSkills(msg)
    outSAY("char advanceallskills "..msg);
end

function GMH_AchievementComplete(msg)
    outSAY("achieve complete "..msg);
end

function GMH_Lookup(msg)
args = {strsplit(" ",msg)};
if args[2] then
outSAY("lookup "..args[1].." "..args[2]);
else
ShowMessage("Please enter a search term.");
end
end

function GMH_Kick(msg)
args = {strsplit(" ",msg)};
if args[2] then a2 = string.sub(msg,string.len(args[1])+2) else a2 = "" end
outSAY("kickplayer "..args[1].." "..a2);
end

--Plays sound files named in the DBC
function GMH_Sounds(msg)
    PSound(msg);
end

function GMH_TableReload(msg)
    outSAY("server reloadtable "..msg);
end

function GMH_ShowMessage(msg)
ShowMessage(msg, "FFFFFF")
end

if select(4, GetBuildInfo()) == 30100 then
    SLASH_GMHRELOAD1 = "/reload"
    SlashCmdList["GMHRELOAD"] = 
    function()
        ReloadUI()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SlashCmdList["GMH"] = GMH_Main;
SLASH_GMH1="/gmh";
SlashCmdList["GMHGMTOGGLE"] = GMH_GMToggle;
SLASH_GMHGMTOGGLE1="/gm";
SlashCmdList["REVIVE"] = GMH_Revive;
SLASH_REVIVE1="/revive";
SlashCmdList["GMHSPAWN"] = GMH_NPCSpawn;
SLASH_GMHSPAWN1="/npcspawn";
SlashCmdList["GMHDELETE"] = GMH_NPCDelete;
SLASH_GMHDELETE1="/npcdelete";
SlashCmdList["GMHADDITEM"] = GMH_AddItem;
SLASH_GMHADDITEM1="/add item";
SlashCmdList["GMHANNOUNCE"] = GMH_Announce;
SLASH_GMHANNOUNCE1="/announce";
SLASH_GMHANNOUNCE2="/an";
SlashCmdList["GMHGMANNOUNCE"] = GMH_GMAnnounce;
SLASH_GMHGMANNOUNCE1="/gmannounce";
SLASH_GMHGMANNOUNCE2="/gman";
SlashCmdList["GMHRECALLPORT"] = GMH_RecallPort;
SLASH_GMHRECALLPORT1="/recallport";
SLASH_GMHRECALLPORT2="/recall";
SLASH_GMHRECALLPORT3="/port";
SlashCmdList["GMHSAVEDANNOUNCE"] = GMH_SavedAnnounce;
SLASH_GMHSAVEDANNOUNCE1="/savedannounce";
SLASH_GMHSAVEDANNOUNCE2="/sa";
SlashCmdList["GMHSHOWSAVEDANNOUNCE"] = GMH_ShowSavedAnn;
SLASH_GMHSHOWSAVEDANNOUNCE1="/showsavedannounce";
SLASH_GMHSHOWSAVEDANNOUNCE2="/showsaved";
SLASH_GMHSHOWSAVEDANNOUNCE3="/ssa";
SlashCmdList["GMHLEARN"] = GMH_Learn;
SLASH_GMHLEARN1="/learn";
SlashCmdList["GMHUNLEARN"] = GMH_UnLearn;
SLASH_GMHUNLEARN1="/unlearn";
SlashCmdList["GMHREVIVE"] = GMH_Revive;
SLASH_GMHREVIVE1="/revive";
SlashCmdList["GMHREVIVEPLR"] = GMH_RevivePlr;
SLASH_GMHREVIVEPLR1="/reviveplr";
SlashCmdList["GMHADVANCEALL"] = GMH_AdvanceAllSkills;
SLASH_GMHADVANCEALL1="/advanceall";
SLASH_GMHADVANCEALL2="/advanceallskills";
SlashCmdList["GMHACHIEVECOMPLETE"] = GMH_AchievementComplete;
SLASH_GMHACHIEVECOMPLETE1="/achievecomplete";
SlashCmdList["GMHLOOKUP"] = GMH_Lookup;
SLASH_GMHLOOKUP1="/lookup";
SlashCmdList["GMHKICK"] = GMH_Kick;
SLASH_GMHKICK1="/kickplayer";
SlashCmdList["GMHSOUND"] = GMH_Sounds;
SLASH_GMHSOUND1="/ps";
SlashCmdList["GMHTR"] = GMH_TableReload;
SLASH_GMHTR1="/tr";
SLASH_GMHTR2="/table";
SlashCmdList["GMHSHOWMESSAGE"] = GMH_ShowMessage;
SLASH_GMHSHOWMESSAGE1="/showmessage";


---------------------------------------------
--          End of Advance Command         --
---------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ItemSearchScript

-- Below vars are used throughout the item search
item_search_results = {}
itemName = {}
itemSearched = false

i = 1;

-- Fired when a server message is sent to the client
function Chat_OnEvent(event, text)
    if string.find(text, "Item") and ItemFormSearch:IsShown() and not itemSearched then
    if (i < 26) then
        -- If the detected string is an item result
        idlength, _, _, _ = string.find(text, ":");
        item_search_results[i] = string.sub(text, 6, idlength-1);
        itemName[i] = text;
        ProcessItemSearch(item_search_results[i]);
        i = i + 1;
    end    
    elseif string.find(text, "Search completed in ") then
    itemSearched = true
    elseif string.find(text, "Starting search of item ") then -- Reset if its a new search
        for i=1, 25 do
            getglobal("ItemFormSearchTexture"..i):Hide();
            getglobal("ItemFormSearchLabelItemID"..i):Hide();
            getglobal("ItemFormSearchButton"..i):Hide();
            itemSearched = false
        end
        i = 1;
    end
end

function GetItemInfoTexture(name)
_, _, _, _, _, _, _, _, _, texture = GetItemInfo(name);
return texture
end

-- Function to update each button when a result is recieved by the client
function ProcessItemSearch(itemid)
    getglobal("ItemFormSearchTexture"..i):Show();
    getglobal("ItemFormSearchLabelItemID"..i):Show();
    getglobal("ItemFormSearchButton"..i):Show();
    -- Update "number of results" text
    text = "Results Found: "..i;
    ItemFormSearchLabel2Label:SetText(text);
    getglobal("ItemFormSearchLabelItemID"..i.."Label"):SetText(itemName[i]);
    if(GetItemInfoTexture("item:"..itemid)) then
    getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture(GetItemInfoTexture("item:"..itemid));
    elseif(GetItemIcon("item:"..itemid)) then
    getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture(GetItemIcon("item:"..itemid));
    else
    getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
    end
end

-- When a button is rolled over, show tooltip and update vars based on user cache
function ResultButton_OnEnter(button_number, self)
    GameTooltip:ClearLines();
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -(self:GetWidth() / 2), 24)
    GameTooltip:SetHyperlink("item:"..item_search_results[button_number]..":0:0:0:0:0:0:0");
    GameTooltip:AddLine("Click to add to inventory");
    GameTooltip:Show();
end

function ResultButton_OnClick(button_number)
outSAY("char add item "..item_search_results[button_number]);
end
---------------------------------------------
--            End of Item search           --
---------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GMH Interface Options

function GMH_CancelOrLoad()
    GMHGUIFrame_ShowOnLoad:SetChecked(GMH_ShowOnLoad);
end

function GMH_Close()
    GMH_ShowOnLoad = GMHGUIFrame_ShowOnLoad:GetChecked();
end

function GMH_Defaults()
    GMHGUIFrame_ShowOnLoad:SetChecked(false); GMH_ShowOnLoad = false;
end

function GMHGUI_OnLoad(panel)
    GMHGUIFrame_ShowOnLoadText:SetText("Show on Load");
    panel.name = "GMH "..gmhversion.." r"..gmhbuild;
    panel.okay = function (self) GMH_Close(); end;
    panel.cancel = function (self)  GMH_CancelOrLoad(); end;
    panel.default = function (self) GMH_Defaults(); end;
    InterfaceOptions_AddCategory(panel);
end

function VIEWGUI_OnLoad(panel)
    VIEWGUIFrame_viewfullText:SetText("Full");
    VIEWGUIFrame_viewminipText:SetText("Mini P");
    VIEWGUIFrame_viewminilText:SetText("Mini L");
    panel.name = "Views"
    panel.okay = function (self) VIEW_Close(); end;
    panel.cancel = function (self)  VIEW_CancelOrLoad(); end;
    panel.default = function (self) VIEW_Defaults(); end;
    panel.parent = "GMH "..gmhversion.." r"..gmhbuild;
    InterfaceOptions_AddCategory(panel);
end

function VIEW_CancelOrLoad()
VIEWGUIFrame_viewfull:SetChecked(false);
VIEWGUIFrame_viewminip:SetChecked(false);
VIEWGUIFrame_viewminil:SetChecked(false);
    if(gmhview == 2) then
        VIEWGUIFrame_viewminip:SetChecked(true);
    elseif(gmhview == 3) then
        VIEWGUIFrame_viewminil:SetChecked(true);
    else
        VIEWGUIFrame_viewfull:SetChecked(true);
    end
end

function VIEW_Close()
if VIEWGUIFrame_viewfull:GetChecked() then gmhview=1
elseif VIEWGUIFrame_viewminip:GetChecked() then gmhview=2
elseif VIEWGUIFrame_viewminil:GetChecked() then gmhview=3 end
end

function VIEW_Defaults()
VIEWGUIFrame_viewfull:SetChecked(true);
VIEWGUIFrame_viewminip:SetChecked(false);
VIEWGUIFrame_viewminil:SetChecked(false);
end