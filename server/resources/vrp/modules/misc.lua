------------------------------------------NATION FUNCTION--------------------------------------
vKEYBOARD = Tunnel.getInterface("keyboard")

vRP.getUserSource             = vRP.Source
vRP.getUserId                 = vRP.Passport
vRP.prepare                   = vRP.Prepare
vRP.getUserIdentity           = vRP.Identity
vRP.userInventory             = vRP.Inventory
vRP.getWeight                 = vRP.GetWeight
vRP.setWeight                 = vRP.SetWeight
vRP.userIdentity              = vRP.Identity
vRP.registerDrivers           = vRP.Drivers
vRP.query                     = vRP.Query
vRP.execute                   = vRP.Query
vRP.Execute                   = vRP.Query
vRP.checkBroken               = vRP.CheckDamaged
vRP.userPlate                 = vRP.PassportPlate
vRP.getIdentities             = vRP.Identities
vRP.characterChosen           = vRP.CharacterChosen
vRP.infoAccount               = vRP.Account
vRP.insertReputation          = vRP.PutExperience
vRP.checkReputation           = vRP.GetExperience
vRP.nearVehicle               = vRP.ClosestVehicle
vRP.userPremium               = vRP.UserPremium
vRP.steamPremium              = vRP.LicensePremium
vRP.userList                  = vRP.Players
vRP.tryChest                  = vRP.TakeChest
vRP.removeInventoryItem       = vRP.RemoveItem
vRP.falseIdentity             = vRP.FalseIdentity
vRP.giveInventoryItem         = vRP.GiveItem
vRP.checkMaxItens             = vRP.MaxItens
vRP.tryGetInventoryItem       = vRP.TakeItem
vRP.generatePlate             = vRP.GeneratePlate
vRP.numPermission             = vRP.NumPermission
vRP.getInventoryItemAmount    = vRP.InventoryItemAmount
vRP.getHealth                 = vRP.GetHealth
vRP.paymentFull               = vRP.PaymentFull
vRP.upgradeHunger             = vRP.UpgradeHunger
vRP.upgradeThirst             = vRP.UpgradeThirst
vRP.upgradeStress             = vRP.UpgradeStress
vRP.downgradeThirst           = vRP.DowngradeThirst
vRP.downgradeHunger           = vRP.DowngradeHunger
vRP.downgradeStress           = vRP.DowngradeStress
vRP.modelPlayer               = vRP.ModelPlayer
vRP.addBank                   = vRP.GiveBank
vRP.delBank                   = vRP.RemoveBank
vRP.getBank                   = vRP.GetBank
vRP.UpdateChest               = vRP.Update
vRP.checkBanned               = vRP.Banned
vRP.userData                  = vRP.UserData
vRP.getUData                  = vRP.UserData
vRP.updateHomePosition        = vRP.InsidePropertys
vRP.getDatatable              = vRP.Datatable
vRP.consultItem               = vRP.ConsultItem
vRP.getFines                  = vRP.GetFine
vRP.addFines                  = vRP.GiveFine
vRP.delFines                  = vRP.RemoveFine
vRP.generateStringNumber      = vRP.GenerateString
vRP.UserSource                = vRP.Source
vRP.userSource                = vRP.Source
vRP.getInfos                  = vRP.infoAccount
vRP.getUserDataTable          = vRP.Datatable
vRP.hasPermission             = vRP.HasPermission


------------------------------------------------------------------------------------------------

function vRP.setUData(user_id, key, value)
    vRP.Query("playerdata/SetData",{ Passport = parseInt(user_id), dkey = key, dvalue = value })
end

vRP.playerDropped             = playerDropped

function vRP.format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

exports("getvRP", function() return vRP end)

------------------------------------------------------------------------------------------------
---NATION SELLDRUGS
vRP.prompt = function (...)
    local r = vKEYBOARD.keyArea(...)
    return r and r[1]
end
------------------------------------------------------------------------------------------------
vRP.prompt =  vRP.Prompt


