---@class scenePed
---@field entityId number
---@field model number
---@field animDict string
---@field animName string

---@class rv_scenes : OxClass
---@field id string?
---@field scene number | nil
---@field peds table<number, scenePed>?
---@field objects table<number, number>?
---@field coords vector3
---@field rotation vector3
---@field heading number
---@field animNameCam string?
---@field animDictCam string?
---@field animDict string
---@field animName string
---@field animFlags AnimationFlags
---@field blendIn number
---@field blendOut number
---@field blendInDelta number
---@field syncedSceneFlags number
---@field ragdollFlags number
---@field onCreate function
---@field startScene function
---@field resource string
local scenes_class = lib.class('rv_scenes')

---@param payload rv_scenes
function scenes_class:constructor(payload)
    self.id = payload.id or 'scene_none'
    self.peds = payload.peds or nil
    self.objects = payload.objects or nil

    self.coords = payload.coords
    self.rotation = payload.rotation
    self.heading = payload.heading or 0
    self.animName = payload.animName
    self.animDict = payload.animDict
    self.animDictCam = payload.animDictCam or nil
    self.animNameCam = payload.animNameCam or nil
    self.animFlags = payload.animFlags
    self.blendIn = payload.blendIn or 8.0
    self.blendOut = payload.blendOut or -8.0
    self.blendInDelta = payload.blendInDelta or 1000.0
    self.syncedSceneFlags = payload.syncedSceneFlags or (64|128|16384)
    self.ragdollFlags = payload.ragdollFlags or 0

    self.onCreate = payload.onCreate
    self.startScene = payload.startScene;
end

return scenes_class
