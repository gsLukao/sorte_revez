local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
Tunnel.bindInterface("sorte_revez")
emP = Tunnel.getInterface("sorte_revez")

local cooldown = 60 
local segundos = 0 


RegisterCommand("box", function()
    tentarSorte()
end)

function tentarSorte()
    if segundos == 0 then
        if emP.checkPayment() then
            segundos = cooldown
            TriggerEvent("Notify", "success", "Você tentou a sorte!") 
            print('GSLUKÂO| Comunidade')
        end
    else

        local minutos = math.floor(segundos / 60)
        local segundos_restantes = segundos % 60
        local mensagem = string.format("Você já tentou a sorte recentemente. Tente novamente em %d minutos e %d segundos.", minutos, segundos_restantes)
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
        if segundos > 0 then
            segundos = segundos - 1
            Citizen.Wait(1000)
        else
            Citizen.Wait(5000)
        end
    end
end)
