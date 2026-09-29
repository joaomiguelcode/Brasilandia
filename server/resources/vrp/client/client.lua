-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Sources = {}
Characters = {}
GlobalState.Players = {}
local Players = {}
AddEventHandler("onResourceStart", function(resourceName)
    print("[ Five Community #TOP1 ]")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Route",0,false)
LocalPlayer["state"]:set("Name","",false)
LocalPlayer["state"]:set("Passport",0,false)
LocalPlayer["state"]:set("Rope",false,false)
LocalPlayer["state"]:set("Cancel",false,true)
LocalPlayer["state"]:set("Active",false,false)
LocalPlayer["state"]:set("Handcuff",false,true)
LocalPlayer["state"]:set("Commands",false,true)
LocalPlayer["state"]:set("Spectate",false,false)
LocalPlayer["state"]:set("Invisible",false,false)
LocalPlayer["state"]:set("Invincible",false,false)
LocalPlayer["state"]:set("usingPhone",false,false)
LocalPlayer["state"]:set("Player",GetPlayerServerId(PlayerId()),false)

LocalPlayer["state"]:set("Admin",false,false)
LocalPlayer["state"]:set("Policia",false,false)
LocalPlayer["state"]:set("Paramedico",false,false)
LocalPlayer["state"]:set("Mecanico",false,false)
LocalPlayer["state"]:set("PizzaThis",false,false)
LocalPlayer["state"]:set("Uwucoffee",false,false)
LocalPlayer["state"]:set("BeanMachine",false,false)
LocalPlayer["state"]:set("Ballas",false,false)
LocalPlayer["state"]:set("Vagos",false,false)
LocalPlayer["state"]:set("Families",false,false)
LocalPlayer["state"]:set("Aztecas",false,false)
LocalPlayer["state"]:set("Altruists",false,false)
LocalPlayer["state"]:set("Triads",false,false)
LocalPlayer["state"]:set("Razors",false,false)

LocalPlayer["state"]:set("Buttons",false,true)
LocalPlayer["state"]:set("Cassino",false,false)
LocalPlayer["state"]:set("Race",false,false)
LocalPlayer["state"]:set("Target",false,false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
	SetDiscordAppId(1038053279806009344)
	SetDiscordRichPresenceAsset("Five Community #TOP1")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetSmall("2000x2000")		
	SetDiscordRichPresenceAssetText("Invoke Solution")
	SetDiscordRichPresenceAssetSmallText("Sua diversão começa aqui")
	SetDiscordRichPresenceAction(0,"Acesse noso Discord","Five Community #TOP1")
	SetDiscordRichPresenceAction(1,"Entrar no servidor","Five Community #TOP1")   
	SetDiscordRichPresenceAction(1,"Siga-nos no Instagram","Five Community #TOP1")
end)