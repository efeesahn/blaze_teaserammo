--Credit 'Efe#2630
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(5)
    end
end) 

--- Config ---

maxTaserAmmo = 5 -- Bir kişinin sahip olabileceği tazer kapsüllerinin miktarı.
refillCommand = "kapsul" -- Tazer Kapsül İtemi
longerTazeTime = true -- Daha Uzun Süre İstiyorsanız True
longerTazeSecTime = 20 -- Süreyi Uzatmak İsteyenler İçin
local muhittin = false
local taserModel = GetHashKey("WEAPON_STUNGUN")
local taserAmmoLeft = maxTaserAmmo
local tirrek = false

--- Kod ---


RegisterNetEvent('blaze:taserreload')
AddEventHandler('blaze:taserreload', function()
  local ped = PlayerPedId()
  local finished = exports['reload-skillbar']:taskBar(2500,math.random(5,15))
  if finished == 100 then
    muhittin = true
    taserAmmoLeft = 5
    TaskReloadWeapon(ped)
  else
    exports['mythic_notify']:DoHudText('inform', 'Doldurulamadı!?!?!? ')
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
     if tirrek then
      exports['mythic_notify']:DoHudText('error', 'Kapsül Yok')
      tirrek = false
      Citizen.Wait(3000)
     end
    
  end
  
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        local player =PlayerId()
       
     
        
        if HasPedGotWeapon(ped, taserModel, false) and not muhittin then
          DisablePlayerFiring(ped, true)
          if IsPlayerFreeAiming(player) and IsControlPressed(0,18) then
            
            DisablePlayerFiring(ped, true)
            
           tirrek = true
           
         end
            
         
        elseif  muhittin then
           
           
     
       

           if GetSelectedPedWeapon(ped) == taserModel then
                if IsPedShooting(ped) then
                   taserAmmoLeft = taserAmmoLeft - 1
                   exports['mythic_notify']:DoHudText('inform', 'Kapsul sayisi : '..taserAmmoLeft)
                end
           end

            if taserAmmoLeft <= 0 then
               if GetSelectedPedWeapon(ped) == taserModel then
                  SetPlayerCanDoDriveBy(ped, false)
                  DisablePlayerFiring(ped, true)
                  exports['mythic_notify']:DoHudText('error', 'Kapsul Kalmadi ')
                  muhittin = false
               
                end
           end

            if longerTazeTime then
                SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
            end
       end
       
    end
    
end)
