local ROUTING_BUCKET_OFFSET <const> = 1000
local inside = {}

lib.callback.register('lunar_garage:enterInterior', function(source, type)
    local player = Framework.GetPlayerFromId(source)
    
    if not player then return end

    local bucketId = ROUTING_BUCKET_OFFSET + source
    inside[source] = true

    SetPlayerRoutingBucket(source, bucketId)
    SetRoutingBucketPopulationEnabled(bucketId, false)

    local vehicles = MySQL.query.await(Queries.getStoredGarage, { player:GetIdentifier(), type })
end)

RegisterNetEvent('lunar_garage:exitInterior', function()
    local source = source

    if inside[source] then
        SetPlayerRoutingBucket(source, 0)
        inside[source] = false
    end
end)