function PaGlobalFunc_ElfWarRegion_Update(deltaTime)
  local self = PaGlobal_ElfWarRegion
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_ElfWarRegion_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarRegion
  if self == nil then
    return
  end
  if state == __eElfWar_Stop then
    self:prepareClose()
    PaGlobalFunc_Radar_ClearRegionSubNameText()
    PaGlobalFunc_WorldMinimap_ClearRegionSubNameText()
  end
end
function FromClient_ElfWarRegion_ChangeNearRegion(fierceBattleKeyRaw)
  local self = PaGlobal_ElfWarRegion
  if self == nil then
    return
  end
  self:prepareOpen(fierceBattleKeyRaw)
end
function FromClient_ElfWarRegion_FindNearRegion(fierceBattleKeyRaw)
  local self = PaGlobal_ElfWarRegion
  if self == nil then
    return
  end
  self:prepareOpen(fierceBattleKeyRaw)
end
function FromClient_ElfWarRegion_RemoveNearRegion()
  local self = PaGlobal_ElfWarRegion
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobalFunc_Radar_ClearRegionSubNameText()
  PaGlobalFunc_WorldMinimap_ClearRegionSubNameText()
end
