local function openPrisonStashPolice()
    local input = lib.inputDialog('Podaj SSN Gracza', {'Wpisz SSN Gracza np - 606'})

    if not input then return end
    local playerSSN = input[1]
    ESX.TriggerServerCallback('police:ids', function(playerL , playerIden)
        exports.ox_inventory:openInventory('stash', { id = 'szafka_wiez:' ..tostring(playerL), owner = tostring(playerIden) })
    end, playerSSN)
end



local function openJailStash()
    ESX.TriggerServerCallback('police:returnStash', function(dt , dt2)
        exports.ox_inventory:openInventory('stash', { id = 'szafka_wiez:' ..tostring(dt), owner = tostring(dt2) })
    end)
end

Citizen.CreateThread(function()
    exports['qtarget']:AddCircleZone("police_prison_stash", vector3(473.07, -1006.99, 26.47), 0.6, {
        name="police_prison_stash",
        useZ=true,
        --debugPoly=true
    }, {
        options = {
            {
                action = function()
                    openPrisonStashPolice()
                end,
                icon = "fa-solid fa-box",
                label = "Szafka Więzienna",
                job = "police",
            },
        },
        distance = 2.0
    })
    exports['qtarget']:AddCircleZone("stash_jail", vector3(474.13, -1014.37, 26.27), 0.9, {
        name="stash_jail",
        useZ=true,
        --debugPoly=true
    }, {
        options = {
            {
                action = function()
                    openJailStash()
                end,
                icon = "fa-solid fa-box-open",
                label = "Szafka Więzienna",
            },
        },
        distance = 2.0
    })
end)
