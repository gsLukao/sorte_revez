local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
Tunnel.bindInterface("sorte_revez")
emP = Tunnel.getInterface("sorte_revez")

local processo = false
local segundos = 1

RegisterCommand("box", function()
    gsales()
end)

function gsales()
    if not processo then
        if emP.checkPayment() then
            processo = true
            TriggerEvent("Notify", "success", "Você tentou a sorte!") 
            print('GSLUKÂO| Comunidade')
        end
    else
        local tempo_restante = segundos / 60 
        local minutos = math.floor(tempo_restante)
        local segundos_restantes = math.floor((tempo_restante - minutos) * 60)
        local mensagem = string.format("Você já tentou a sorte recentemente. Tente novamente depois!.", minutos, segundos_restantes)
        TriggerEvent("Notify", "aviso", mensagem) 
    end
end


RegisterNetEvent('notificarItemFicha')
AddEventHandler('notificarItemFicha', function()
    
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"[Servidor]", "Você recebeu uma ficha!"}
    })
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if segundos > 0 then
            segundos = segundos - 1
            if segundos == 0 then
                processo = false
            end
        end
    end
end)

