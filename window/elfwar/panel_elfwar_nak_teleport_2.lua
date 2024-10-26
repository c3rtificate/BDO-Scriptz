function FromClient_ShowElfWarRecallAlarmUI(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
  local self = PaGlobal_ElfWarNakTeleport
  if self == nil then
    return
  end
  self:prepareOpen(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
end
function PaGlobalFunc_ElfWarNakTeleport_Update(deltaTime)
  local self = PaGlobal_ElfWarNakTeleport
  if self == nil then
    return
  end
  self:update(deltaTime)
end
