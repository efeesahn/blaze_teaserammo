--Credit 'Efe#2630

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('kapsul', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('kapsul', 1)

	TriggerClientEvent('blaze:taserreload', source)
end)