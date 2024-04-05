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
            local sorteio = math.random(1, 100) -- Sorteia um número entre 1 e 100 (porcentagem)
        
            if sorteio <= 60 then 
                TriggerClientEvent("Notify", source, "aviso", "Você não ganhou nada desta vez, tente novamente!")


            elseif sorteio <= 70 then
                local itens = {"agua", "pizza", "nitro", "energetico", "sanduiche"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")



            elseif sorteio <= 75 then -- 10% de chance de ganhar um item da lista
                local itens = {"militec","nitro","sanduiche","lockpick","masterpick"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")       


            elseif sorteio <= 80 then -- 10% de chance de ganhar um item da lista
                local itens = {"mochila","roupas"}
                local item_aleatorio = itens[math.random(1, #itens)]
                vRP.giveInventoryItem(user_id, item_aleatorio, 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. item_aleatorio .. "!")       



            elseif sorteio <= 85 then -- 10% de chance de ganhar entre 15 mil e 35 mil no banco
                local valor_ganho = math.random(15000, 35000) -- Sorteia um valor entre 15000 e 35000
                vRP.giveInventoryItem(user_id, "dinheirosujo", valor_ganho) -- Adiciona o item "dinheirosujo" ao inventário do jogador com a quantidade igual ao valor sorteado
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou $" .. valor_ganho .. "de dinheiro sujo !")


            elseif sorteio <= 90 then -- 5% de chance de ganhar 25 mil no banco
                vRP.giveBankMoney(user_id, 25000)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou 25 mil reais no banco!")
            elseif sorteio <= 95 then -- 5% de chance de ganhar um carro
                local carros = {"vwgolf", "fox", "fusca"}
                local carro_aleatorio = carros[math.random(1, #carros)]
                -- Verificar se o jogador já possui o carro
                if not vRP.hasVehicle(user_id, carro_aleatorio) then
                    -- Adicionar o carro ao banco de dados
                    vRP.execute("INSERT INTO vrp_user_vehicles (user_id, vehicle, detido, time, engine, body, fuel, ipva, alugado, data_alugado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", {user_id, carro_aleatorio, 0, '0', 1000, 1000, 100, 0, 0, NULL})
                    TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. carro_aleatorio .. "!")
                else
                    -- Converter em dinheiro
                    vRP.giveBankMoney(user_id, 30000)
                    TriggerClientEvent("Notify", source, "sucesso", "Você já possui este carro, então recebeu 30 mil reais no banco!")
                end
            elseif sorteio <= 98 then -- 5% de chance de ganhar a arma
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL", 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou uma arma!")
            else
                -- Se o jogador não ganhou nada
                TriggerClientEvent("Notify", source, "aviso", "Você não ganhou nada desta vez, tente novamente!")
            end
            return true
        else
            -- Se o jogador não tem a ficha necessária
            TriggerClientEvent("Notify", source, "aviso", "Você precisa de uma ficha para usar esta função!")
        end
    end
end

local horaNotificacao = 3600000 -- Notificar a cada 60 minutos de jogo
local itemFicha = "ficha" -- Nome do item a ser dado

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3600000) -- Verifica a cada minuto (60 segundos)

        for _, player in ipairs(GetPlayers()) do
            local user_id = vRP.getUserId(player)
            if user_id then
                -- Dá o item "FICHA" ao jogador
                vRP.giveInventoryItem(user_id, itemFicha, 1, true)
                TriggerClientEvent('notificarItemFicha', player)
            end
        end
    end
end)




--[[
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.tryGetInventoryItem(user_id, "isca", 1) then
            local sorteio = math.random(1, 100) -- Sorteia um número entre 1 e 100 (porcentagem)
            
            if sorteio <= 90 then -- 90% de chance de ganhar 15 mil no bank
                vRP.giveBankMoney(user_id, 15000)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou 15 mil reais no banco!")
            elseif sorteio <= 80 then -- 80% de chance de ganhar 25 mil no bank
                vRP.giveBankMoney(user_id, 25000)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou 25 mil reais no banco!")
            elseif sorteio <= 85 then -- 5% de chance de ganhar um carro
                local carros = {"vwgolf", "fox", "fusca"}
                local carro_aleatorio = carros[math.random(1, #carros)]
                -- Verificar se o jogador já possui o carro
                if not vRP.hasVehicle(user_id, carro_aleatorio) then
                    -- Adicionar o carro ao banco de dados
                    vRP.execute("INSERT INTO player_vehicles (user_id, vehicle) VALUES (?, ?)", {user_id, carro_aleatorio})
                    TriggerClientEvent("Notify", source, "sucesso", "Você ganhou um " .. carro_aleatorio .. "!")
                else
                    -- Converter em dinheiro
                    vRP.giveBankMoney(user_id, 30000)
                    TriggerClientEvent("Notify", source, "sucesso", "Você já possui este carro, então recebeu 30 mil reais no banco!")
                end
            elseif sorteio <= 87 then -- 2% de chance de ganhar a arma
                vRP.giveInventoryItem(user_id, "wbody|WEAPON_PISTOL", 1)
                TriggerClientEvent("Notify", source, "sucesso", "Você ganhou uma arma!")
            else
                -- Se o jogador não ganhou nada
                TriggerClientEvent("Notify", source, "aviso", "Você não ganhou nada desta vez, tente novamente!")
            end
            
            return true
        end
    end
end

]]--