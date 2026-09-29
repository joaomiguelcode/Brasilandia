create_extension('megatron/creativeV5', function()
    
    vRP.Passport = vRP.getUserId
    vRP.HasGroup = vRP.hasGroup
    vRP.Identity = vRP.userIdentity
    mathLength = mathLegth
    vRP.InventoryWeight = vRP.inventoryWeight
    vRP.GetWeight = vRP.getWeight
    vRP.TakeItem = vRP.tryGetInventoryItem
    vRP.InventoryItemAmount = vRP.getInventoryItemAmount
    vRP.GenerateItem = vRP.generateItem
    vRP.Query = vRP.query
    vRP.PassportPlate = vRP.getUserByRegistration
    vRP.NumPermission = vRP.hasPermission
    vRP.GetEntityCoords = vRP.getPosition
    vRP.Source = vRP.getUserSource

end)

