local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory
local playerL = nil

ESX.RegisterServerCallback('police:ids', function(source , cb , playerSSN)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
   local user = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `id` = @id", {
    ["@id"] = tonumber(playerSSN)
})[1] or false

if user == false then
    xPlayer.showNotification('Nie ma takiego gracza na serwerze!')
else
    ox_inventory:RegisterStash('szafka_wiez:' ..tostring(playerSSN), 'Szafka Więzienna', 100, 500000, false)
    Wait(100)
    cb(playerSSN , user.identifier)
end
end)




ESX.RegisterServerCallback('police:returnStash', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local user = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {
        ["@identifier"] = xPlayer.getIdentifier()
    })[1] or false
    if user == false then
        xPlayer.showNotification("Nie można załadować tego schowka!")
    else
        local ssn = user.id
        cb(ssn , xPlayer.getIdentifier())
    end
end)
