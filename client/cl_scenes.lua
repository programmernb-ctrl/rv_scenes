local sceneClass = require 'class.scenes'

---@type table <number, rv_scenes>
local Scenes = {}

---@param self rv_scenes
local function createScene(self)
    if self.animDict then
        lib.requestAnimDict(self.animDict)
    end

    if self.animDictCam then
        lib.requestAnimDict(self.animDictCam);
    end

    local scene = NetworkCreateSynchronisedScene(self.coords.x, self.coords.y, self.coords.z, self.rotation.x,
        self.rotation.y, self.rotation.z, 2, true, false, 1.0, 0.0, 1.0);

    NetworkAddPedToSynchronisedScene(cache.ped, scene, self.animDict, self.animName, self.blendIn, self.blendOut,
        self.syncedSceneFlags, self.ragdollFlags, self.blendInDelta, 0);

    if self.peds then
        for i = 1, #self.peds do
            local _ped = self.peds[i]
            if _ped then
                lib.requestAnimDict(_ped.animDict);
                NetworkAddPedToSynchronisedScene(_ped.entityId, scene, _ped.animDict, _ped.animName, self.blendIn,
                    self.blendOut, self.syncedSceneFlags, self.ragdollFlags, self.blendInDelta, 0);
            end
        end
    end

    if self.objects then
        for i, entity in pairs(self.objects) do
            NetworkAddEntityToSynchronisedScene(entity, scene, self.animDict, self.animName, 8.0, -8.0, 16384);
        end
    end

    NetworkAddSynchronisedSceneCamera(scene, self.animDictCam, self.animNameCam);

    self.scene = scene
    self.id = 'scene_' .. scene
end

---@param self rv_scenes
local function startScene(self)
    if not self.id or self.id == 'scene_none' then return end

    NetworkStartSynchronisedScene(self.scene);
    Wait(GetAnimDuration(self.animDict, self.animName) * 1000);
    NetworkStopSynchronisedScene(self.scene);
    RemoveAnimDict(self.animDict);
end

---@param payload rv_scenes | rv_scenes[]
---@return string
exports('createScene', function(payload)
    payload = table.type(payload) == 'array' and payload or { payload }

    for i = 1, #payload do
        ---@diagnostic disable-next-line: invisible
        local scene = sceneClass:new(payload[i])

        scene.resource = GetInvokingResource() or GetCurrentResourceName()
        scene.onCreate = createScene
        scene.startScene = startScene

        Scenes[#Scenes + 1] = scene
    end
end)

---@param id string
---@return rv_scenes | nil
exports('getSceneById', function(id)
    for i = 1, #Scenes do
        local scene = Scenes[i]
        if scene then
            if scene.id == id then
                return scene
            end

            return nil
        end
    end
end)
