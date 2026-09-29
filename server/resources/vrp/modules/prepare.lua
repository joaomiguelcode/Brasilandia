-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT * FROM characters WHERE id = @id")
vRP.Prepare("characters/SetVisa","UPDATE characters SET visa = @visa WHERE id = @id")
vRP.Prepare("characters/getPhone","SELECT id FROM characters WHERE phone = @phone")
vRP.Prepare("characters/updatePhone","UPDATE characters SET phone = @phone WHERE id = @id")
vRP.Prepare("characters/removeCharacter","UPDATE characters SET deleted = 1 WHERE id = @id")
vRP.Prepare("characters/addFines","UPDATE characters SET fines = fines + @fines WHERE id = @id")
vRP.Prepare("characters/setPrison","UPDATE characters SET prison = @prison WHERE id = @Passport")
vRP.Prepare("characters/removeFines","UPDATE characters SET fines = fines - @fines WHERE id = @id")
vRP.Prepare("characters/addBank","UPDATE characters SET bank = bank + @amount WHERE id = @Passport")
vRP.Prepare("characters/remBank","UPDATE characters SET bank = bank - @amount WHERE id = @Passport")
vRP.Prepare("characters/UserLicense","SELECT * FROM characters WHERE id = @id and license = @license")
vRP.Prepare("characters/Characters","SELECT * FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/removePrison","UPDATE characters SET prison = prison - @prison WHERE id = @Passport")
vRP.Prepare("characters/updateName","UPDATE characters SET name = @name, name2 = @name2 WHERE id = @Passport")
vRP.Prepare("characters/Tracking","UPDATE characters SET tracking = tracking + @tracking WHERE id = @Passport")
vRP.Prepare("characters/UpgradeSpending","UPDATE characters SET spending = spending + @spending WHERE id = @Passport")
vRP.Prepare("characters/DowngradeSpending","UPDATE characters SET spending = spending - @spending WHERE id = @Passport")
vRP.Prepare("characters/ResetSpending","UPDATE characters SET spending = 0 WHERE id = @Passport")
vRP.Prepare("characters/lastCharacters","SELECT id FROM characters WHERE license = @license ORDER BY id DESC LIMIT 1")
vRP.Prepare("characters/UpgradeCardlimit","UPDATE characters SET cardlimit = cardlimit + @cardlimit WHERE id = @Passport")
vRP.Prepare("characters/DowngradeCardlimit","UPDATE characters SET cardlimit = cardlimit - @cardlimit WHERE id = @Passport")
vRP.Prepare("characters/countPersons","SELECT COUNT(license) as qtd FROM characters WHERE license = @license and deleted = 0")
vRP.Prepare("characters/newCharacter","INSERT INTO characters(license,name,name2,sex,phone,blood) VALUES(@license,@name,@name2,@sex,@phone,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/Account","SELECT * FROM accounts WHERE license = @license")
vRP.Prepare("accounts/newAccount","INSERT INTO accounts(license,discord) VALUES(@license,@discord)")
vRP.Prepare("accounts/AddGems","UPDATE accounts SET gems = gems + @gems WHERE license = @license")
vRP.Prepare("accounts/Rolepass","UPDATE accounts SET rolepass = @rolepass WHERE license = @license")
vRP.Prepare("accounts/Initial","UPDATE accounts SET initial = 1 WHERE id = @id")
vRP.Prepare("accounts/setPremium","UPDATE accounts SET premium = @premium WHERE license = @license")
vRP.Prepare("accounts/RemoveGems","UPDATE accounts SET gems = gems - @gems WHERE license = @license")
vRP.Prepare("accounts/infosUpdatechars","UPDATE accounts SET chars = chars + 1 WHERE license = @license")
vRP.Prepare("accounts/updatePremium","UPDATE accounts SET premium = premium + 2592000 WHERE license = @license")
vRP.Prepare("accounts/updateMedicPlan","UPDATE characters SET medicplan = medicplan + 2592000 WHERE license = @license")
vRP.Prepare("accounts/SetMedicPlan","UPDATE characters SET medicplan = @medicplan WHERE license = @license")
vRP.Prepare("accounts/updateWhitelist","UPDATE accounts SET whitelist = @whitelist WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT * FROM playerdata WHERE Passport = @Passport AND dkey = @dkey")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,dkey,dvalue) VALUES(@Passport,@dkey,@dvalue)")
vRP.Prepare("playerdata/getUserdata","SELECT dvalue FROM playerdata WHERE Passport = @user_id AND dkey = @key")
vRP.Prepare("playerdata/setUserdata","REPLACE INTO playerdata(Passport,dkey,dvalue) VALUES(@user_id,@key,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT * FROM entitydata WHERE dkey = @dkey")
vRP.Prepare("entitydata/getData","SELECT * FROM entitydata WHERE dkey = @dkey")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE dkey = @dkey")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@dvalue)")
vRP.Prepare("entitydata/setData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.Prepare("vehicles/UserVehicles","SELECT * FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, health = @health, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE Passport = @Passport AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds/GetBanned","SELECT * FROM banneds WHERE license = @license")
vRP.Prepare("banneds/RemoveBanned","DELETE FROM banneds WHERE license = @license")
vRP.Prepare("banneds/InsertBanned","INSERT INTO banneds(license,time) VALUES(@license,UNIX_TIMESTAMP() + 86400 * @time)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT * FROM chests WHERE name = @name")
vRP.Prepare("chests/UpdateChests","UPDATE chests SET weight = weight + 50 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("races/Result","SELECT * FROM races WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Ranking","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 5")
vRP.Prepare("races/TopFive","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 1")
vRP.Prepare("races/Records","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Insert","INSERT INTO races(Race,Passport,Name,Vehicle,Points) VALUES(@Race,@Passport,@Name,@Vehicle,@Points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fidentity/Result","SELECT * FROM fidentity WHERE id = @id")
vRP.Prepare("fidentity/GetIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.Prepare("fidentity/NewIdentity","INSERT INTO fidentity(name,name2,blood) VALUES(@name,@name2,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("summerz/Playerdata","DELETE FROM playerdata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.Prepare("summerz/Entitydata","DELETE FROM entitydata WHERE dvalue = '[]' OR dvalue = '{}'")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warehouse/Informations","SELECT * FROM warehouse WHERE name = @name")
vRP.Prepare("warehouse/Upgrade","UPDATE warehouse SET weight = weight + 10 WHERE name = @name")
vRP.Prepare("warehouse/Password","UPDATE warehouse SET password = @password WHERE name = @name")
vRP.Prepare("warehouse/Acess","SELECT * FROM warehouse WHERE name = @name AND password = @password")
vRP.Prepare("warehouse/Tax","UPDATE warehouse SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name")
vRP.Prepare("warehouse/Buy","INSERT INTO warehouse(name,password,Passport,tax) VALUES(@name,@password,@Passport,UNIX_TIMESTAMP() + 2592000)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT * FROM propertys")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/Exist","SELECT * FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/Serial","SELECT * FROM propertys WHERE Serial = @serial")
vRP.Prepare("propertys/Garages","SELECT * FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/AllUser","SELECT * FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @garage WHERE Name = @name")
vRP.Prepare("propertys/Keys","UPDATE propertys SET Keys = Keys + @keys WHERE Name = @name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @serial WHERE Name = @name")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = Vault + @weight WHERE Name = @name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = Fridge + @weight WHERE Name = @name")
vRP.Prepare("propertys/Check","SELECT * FROM propertys WHERE Name = @name AND Passport = @passport")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = UNIX_TIMESTAMP() + 2592000 WHERE Name = @name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys(Name,Interior,Passport,Serial,Vault,Fridge,Tax) VALUES(@name,@interior,@passport,@serial,@vault,@fridge,@tax)")
vRP.Prepare("propertys/totalHomes","SELECT Name as name, Tax as tax FROM propertys")
vRP.Prepare("propertys/permissions","SELECT * FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/userOwnermissions","SELECT * FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/userPermissions","SELECT * FROM propertys WHERE Name = @name AND Passport = @user_id")
vRP.Prepare("propertys/countUsers","SELECT COUNT(*) as qtd FROM propertys WHERE Passport = @user_id")
vRP.Prepare("propertys/countPermissions","SELECT COUNT(*) as qtd FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/userList","SELECT Name as name FROM propertys WHERE Passport = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/DowngradeChests","UPDATE chests SET weight = weight / 2 WHERE name = @Name")
vRP.Prepare("chests/UpgradeChests2","UPDATE chests SET weight = weight + weight WHERE name = @Name")
vRP.Prepare("painel/GetInformations","SELECT * FROM organizations WHERE name = @Name")
vRP.Prepare("painel/UpdateBuff","UPDATE organizations SET buff = @Buff WHERE name = @Name")
vRP.Prepare("painel/DowngradeBank","UPDATE organizations SET bank = bank - @Value WHERE name = @Name")
vRP.Prepare("painel/UpgradeBank","UPDATE organizations SET bank = bank + @Value WHERE name = @Name")
vRP.Prepare("painel/GetTransactions","SELECT * FROM org_transactions WHERE name = @Name ORDER BY id DESC LIMIT 12")
vRP.Prepare("painel/InsertTransaction","INSERT INTO org_transactions (`name`, `Type`, `Value`) VALUES (@Name, @Type, @Value)")
vRP.Prepare("painel/UpdateBuff","UPDATE organizations SET buff = @Buff WHERE name = @Name")
vRP.Prepare("painel/SetPremium","UPDATE organizations SET premium = @Seconds WHERE name = @Name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT * FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/List","SELECT * FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Check","SELECT * FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Value,Balance) VALUES(@Passport,@Type,@Date,@Value,@Balance)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("dependents/List","SELECT * FROM dependents WHERE Passport = @Passport")
vRP.Prepare("dependents/Remove","DELETE FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Check","SELECT * FROM dependents WHERE Passport = @Passport AND Dependent = @Dependent")
vRP.Prepare("dependents/Add","INSERT INTO dependents(Passport,Dependent,Name) VALUES(@Passport,@Dependent,@Name)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("invoices/Remove","DELETE FROM invoices WHERE id = @id")
vRP.Prepare("invoices/Check","SELECT * FROM invoices WHERE id = @id")
vRP.Prepare("invoices/List","SELECT * FROM invoices WHERE Passport = @Passport")
vRP.Prepare("invoices/Add","INSERT INTO invoices(Passport,Received,Type,Reason,Holder,Value) VALUES(@Passport,@Received,@Type,@Reason,@Holder,@Value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT * FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments(Passport,Deposit,Last) VALUES(@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = Deposit + @Value, Last = UNIX_TIMESTAMP() + 86400 WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = Monthly + FLOOR((Deposit + Liquid) * 0.10), Liquid = Liquid + FLOOR((Deposit + Liquid) * 0.025), Last = UNIX_TIMESTAMP() + 86400 WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query("summerz/Playerdata")
	vRP.Query("summerz/Entitydata")
end)