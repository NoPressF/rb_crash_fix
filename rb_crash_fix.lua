script_name('Remove Building Fix')
script_description('Game crashes when player uses RemoveBuildingForPlayer more than 1000!')
script_author('EOS')
script_moonloader(25)

local hook = require('lib.samp.events')
local sampfuncs = require('lib.sampfuncs')
local vkeys = require('vkeys')

local remove_building_index = 1
local data_remove_buildings = {}

function main()
	if not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
	
	for i = 1, sampfuncs.MAX_OBJECTS do
		data_remove_buildings[i] = {}
	end
	
	wait(-1)
end

function GetRemoveBuildingModelid(index)
	return data_remove_buildings[index]['modelId']
end

function GetRemoveBuildingPositionX(index)
	return data_remove_buildings[index]['position']['x']
end

function GetRemoveBuildingPositionY(index)
	return data_remove_buildings[index]['position']['y']
end

function GetRemoveBuildingPositionZ(index)
	return data_remove_buildings[index]['position']['z']
end

function GetRemoveBuildingRadius(index)
	return data_remove_buildings[index]['radius']
end

function IsRemoveObjectRemoved(modelId, position, radius)
	for i = 1, remove_building_index do
		if GetRemoveBuildingModelid(i) == modelId and GetRemoveBuildingPositionX(i) == position['x'] and GetRemoveBuildingPositionY(i) == position['y'] and GetRemoveBuildingPositionZ(i) == position['z'] and GetRemoveBuildingRadius(i) == radius then
			return true
		end
	end
	
	return false
end

function hook.onRemoveBuilding(modelId, position, radius)
	if IsRemoveObjectRemoved(modelId, position, radius) == false then
	
		data_remove_buildings[remove_building_index]['modelId'] = modelId
		data_remove_buildings[remove_building_index]['position'] = position
		data_remove_buildings[remove_building_index]['radius'] = radius
		remove_building_index = remove_building_index + 1
		return true
	end
	
	return false
end