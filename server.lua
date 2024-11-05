local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("sorte_revez", emP)


function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id, "ficha", 1) then
            local sorteio = math.random(1, 100)
            local mensagem = ""
            
            if sorteio <= 60 then
                mensagem = "Você não ganhou nada desta vez, tente novamente!"
            
            elseif sorteio <= 70 then
                mensagem = sortearItem(user_id, {"agua", "pizza", "nitro", "energetico", "sanduiche"}, "Você ganhou um ")

            elseif sorteio <= 75 then
                mensagem = sortearItem(user_id, {"militec", "nitro", "sanduiche", "lockpick", "masterpick"}, "Você ganhou um ")

            elseif sorteio <= 80 then
                mensagem = sortearItem(user_id, {"mochila", "roupas"}, "Você ganhou um ")

            elseif sorteio <= 85 then
                local valor_ganho = math.random(15000, 35000)
                vRP.giveInventoryItem(user_id, "dinheirosujo", valor_ganho)
                mensagem = "Você ganhou $" .. valor_ganho .. " de dinheiro sujo!"

            elseif sorteio <= 90 then
                vRP.giveBankMoney(user_id, 25000)
                mensagem = "Você ganhou 25 mil reais no banco!"

            elseif sorteio <= 95 then
                mensagem = sortearCarro(user_id, {"vwgolf", "fox", "fusca"})

            elseif sorteio <= 98 then
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL", 1)
                mensagem = "Você ganhou uma arma!"

            else
                mensagem = "Você não ganhou nada desta vez, tente novamente!"
            end

            TriggerClientEvent("Notify", source, "sucesso", mensagem)
            return true
        else
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de uma ficha para usar esta função!")
        end
    end
end


function sortearItem(user_id, itens, mensagem_inicial)
    local item_aleatorio = itens[math.random(1, #itens)]
    vRP.giveInventoryItem(user_id, item_aleatorio, 1)
    return mensagem_inicial .. item_aleatorio .. "!"
end


function sortearCarro(user_id, carros)
    local carro_aleatorio = carros[math.random(1, #carros)]
    
    if not vRP.hasVehicle(user_id, carro_aleatorio) then
        vRP.execute("INSERT INTO vrp_user_vehicles (user_id, vehicle, detido, time, engine, body, fuel, ipva, alugado, data_alugado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
            {user_id, carro_aleatorio, 0, '0', 1000, 1000, 100, 0, 0, NULL})
        return "Você ganhou um " .. carro_aleatorio .. "!"
    else
        vRP.giveBankMoney(user_id, 30000)
        return "Você já possui este carro, então recebeu 30 mil reais no banco!"
    end
end


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
