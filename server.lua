local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("sorte_revez",emP)

function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id, "ficha", 1) then
            local sorteio = math.random(1, 100) 
        
            if sorteio <= 60 then 
                TriggerClientEvent("Notify", source, "aviso", "Você não ganhou nada desta vez, tente novamente!")


            elseif sorteio <= 70 then
                local itens = {"agua", "pizza", "nitro", "energetico", "sanduiche"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")



            elseif sorteio <= 75 then 
                local itens = {"militec","nitro","sanduiche","lockpick","masterpick"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")       


            elseif sorteio <= 80 then 
                local itens = {"mochila","roupas"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")       



            elseif sorteio <= 85 then 
                local valor_ganho = math.random(15000, 35000) 
                vRP.giveInventoryItem(user_id, "dinheirosujo", valor_ganho) 
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou $" .. valor_ganho .. "de dinheiro sujo !")


            elseif sorteio <= 90 then 
                vRP.giveBankMoney(user_id, 25000)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou 25 mil reais no banco!")
            elseif sorteio <= 95 then 
                local carros = {"vwgolf", "fox", "fusca"}
                local carro_aleatorio = carros[math.random(1, #carros)]
                
                if not vRP.hasVehicle(user_id, carro_aleatorio) then
                    
                    vRP.execute("INSERT INTO vrp_user_vehicles (user_id, vehicle, detido, time, engine, body, fuel, ipva, alugado, data_alugado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {user_id, carro_aleatorio, 0, '0', 1000, 1000, 100, 0, 0, NULL})
                    TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. carro_aleatorio .. "!")
                else
                    
                    vRP.giveBankMoney(user_id, 30000)
                    TriggerClientEvent("Notify", source, "sucesso", "Você já possui este carro, então recebeu 30 mil reais no banco!")
                end
            elseif sorteio <= 98 then 
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL", 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou uma arma!")
            else
                
                TriggerClientEvent("Notify", source, "aviso", "Você não ganhou nada desta vez, tente novamente!")
            end
            return true
        else
            
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de uma ficha para usar esta função!")
        end
    end
end

local horaNotificacao = 3600000
local itemFicha = "ficha" 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3600000)

        for _, player in ipairs(GetPlayers()) do
            local user_id = vRP.getUserId(player)
            if user_id then
                
                vRP.giveInventoryItem(user_id, itemFicha, 1, true)
                TriggerClientEvent('notificarItemFicha', player)
            end
        end
    end
end)



