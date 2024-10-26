function PaGlobalFunc_ElfWarMissionAccept_Update(deltaTime)
  local self = PaGlobal_ElfWarMissionAccept
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_ElfWarMissionAccept_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarMissionAccept
  if self == nil then
    return
  end
  if state == __eElfWar_Stop then
    self:prepareClose()
  end
end
function FromClient_ElfWarMissionAccept_ReceivedNewElfWarMission(missionKey)
  local self = PaGlobal_ElfWarMissionAccept
  if self == nil then
    return
  end
  self:prepareOpen(missionKey)
end
