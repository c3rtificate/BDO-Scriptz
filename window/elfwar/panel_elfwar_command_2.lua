function PaGlobalFunc_ElfWarCommand_Open(openPlayerGradeType)
  local self = PaGlobal_ElfWarCommand
  if self == nil then
    return
  end
  if openPlayerGradeType ~= __eElfWarPlayerGradeType_Commander then
    return
  end
  if self._lastPosXY_gameScene == nil then
    local posX = Panel_Radar:GetPosX() - Panel_ElfWar_Command:GetSizeX() - 20
    local posY = Panel_Radar:GetPosY() + 100
    self._lastPosXY_gameScene = float2(posX, posY)
  end
  self._openWorldPosition = float3(0, 0, 0)
  self._openByMiniMap = false
  self:prepareOpen(openPlayerGradeType, self._lastPosXY_gameScene.x, self._lastPosXY_gameScene.y)
end
function PaGlobalFunc_ElfWarCommand_OpenByMiniMap(openPlayerGradeType, worldPosition)
  local self = PaGlobal_ElfWarCommand
  if self == nil then
    return
  end
  if openPlayerGradeType ~= __eElfWarPlayerGradeType_Commander then
    return
  end
  local posX = getMousePosX()
  local posY = getMousePosY()
  if self._openByMiniMap == false then
    self._lastPosXY_gameScene = float2(Panel_ElfWar_Command:GetPosX(), Panel_ElfWar_Command:GetPosY())
  end
  self._openWorldPosition = worldPosition
  self._openByMiniMap = true
  self:prepareOpen(openPlayerGradeType, posX, posY)
end
function PaGlobalFunc_ElfWarCommand_Close()
  local self = PaGlobal_ElfWarCommand
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarCommand_IsShow()
  if Panel_ElfWar_Command == nil then
    return false
  end
  return Panel_ElfWar_Command:GetShow()
end
function HandleEventLUp_ElfWarCommand_ProcessCommand(commandEventType)
  local self = PaGlobal_ElfWarCommand
  if self == nil or commandEventType == nil then
    return
  end
  if self._openByMiniMap == false then
    self._openWorldPosition = getSelfPlayer():get3DPos()
  end
  ToClient_ProcessElfWarCommandEvent(commandEventType, self._openWorldPosition, true)
  if self._openByMiniMap == true then
    self:prepareClose()
  end
end
function FromClient_ElfWarCommand_ReceivedElfWarCommand(fromUserNo, commandEventType, worldPosition)
  local self = PaGlobal_ElfWarCommand
  if self == nil or fromUserNo == nil or commandEventType == nil or worldPosition == nil then
    return
  end
  if commandEventType == __eElfWarCommandEventType_RequestAttackSupport or commandEventType == __eElfWarCommandEventType_RequestDefenceSupport or commandEventType == __eElfWarCommandEventType_FightingNow or commandEventType == __eElfWarCommandEventType_SafePosition or commandEventType == __eElfWarCommandEventType_Ping_Red or commandEventType == __eElfWarCommandEventType_Ping_Blue or commandEventType == __eElfWarCommandEventType_Ping_Green or commandEventType == __eElfWarCommandEventType_Ping_Yellow then
    PaGlobalFunc_ElfWarMiniMap_AddPingAndMarker(commandEventType, worldPosition)
  elseif commandEventType == __eElfWarCommandEventType_Move then
    ElfWarMiniMap_SetNavigation(fromUserNo, worldPosition)
  else
    UI.ASSERT_NAME(false, "ElfWarCommandEventType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function FromClient_ElfWarCommand_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarCommand
  if self == nil or state == nil then
    return
  end
  if IsSelfPlayerElfWarGrade_SubCommander() == false then
    return
  end
  if state == __eElfWar_Start then
    PaGlobalFunc_ElfWarCommand_Open(__eElfWarPlayerGradeType_SubCommander)
  else
    PaGlobalFunc_ElfWarCommand_Close()
  end
end
