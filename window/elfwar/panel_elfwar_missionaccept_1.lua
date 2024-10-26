function PaGlobal_ElfWarMissionAccept:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ElfWarMissionAccept:registEventHandler()
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  registerEvent("FromClient_ChangeElfWarState", "FromClient_ElfWarMissionAccept_ChangeElfWarState")
  registerEvent("FromClient_ReceivedNewElfWarMission", "FromClient_ElfWarMissionAccept_ReceivedNewElfWarMission")
end
function PaGlobal_ElfWarMissionAccept:validate()
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  self._ui._txt_missionName:isValidate()
end
function PaGlobal_ElfWarMissionAccept:prepareOpen(missionKey)
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  local missionDataWrapper = ToClient_GetElfWarMissionDataWrapper(missionKey)
  if missionDataWrapper == nil then
    return
  end
  local missionNameString
  local missionType = missionDataWrapper:getMissionType()
  if missionType == __eElfWarMissionType_FierceAttack then
    local targetFierceBattleObjectWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ATTACK", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 49)
      _AudioPostEvent_SystemUiForXBOX(36, 49)
    end
  elseif missionType == __eElfWarMissionType_FierceDefence then
    local targetFierceBattleObjectWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_DEFENSE", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 70)
      _AudioPostEvent_SystemUiForXBOX(36, 70)
    end
  elseif missionType == __eElfWarMissionType_Kill then
    missionNameString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_KILL", "current", missionDataWrapper:getCondition(), "max", missionDataWrapper:getMaxCondition())
    audioPostEvent_SystemUi(36, 48)
    _AudioPostEvent_SystemUiForXBOX(36, 48)
  elseif missionType == __eElfWarMissionType_CastleAttack then
    missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_ATTACK")
    audioPostEvent_SystemUi(35, 14)
    _AudioPostEvent_SystemUiForXBOX(35, 14)
  elseif missionType == __eElfWarMissionType_CastleDefence then
    missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_DEFENSE")
    audioPostEvent_SystemUi(35, 14)
    _AudioPostEvent_SystemUiForXBOX(35, 14)
  elseif missionType == __eElfWarMissionType_GimmikAttack then
    local targetFierceBattleObjectWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
    if targetFierceBattleObjectWrapper ~= nil then
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ACTIVE", "SPOT", targetFierceBattleObjectWrapper:getName())
      audioPostEvent_SystemUi(36, 50)
      _AudioPostEvent_SystemUiForXBOX(36, 50)
    end
  else
    return
  end
  if missionNameString == nil then
    return
  end
  self._timeAcc = 0
  self._ui._txt_missionName:SetText(missionNameString)
  self:open()
end
function PaGlobal_ElfWarMissionAccept:open()
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  Panel_ElfWar_MissionAccept:AddEffect("fUI_RoseWar_Nak_Arrow_01A", true, 0, 0)
  Panel_ElfWar_MissionAccept:RegisterUpdateFunc("PaGlobalFunc_ElfWarMissionAccept_Update")
  Panel_ElfWar_MissionAccept:ComputePos()
  Panel_ElfWar_MissionAccept:SetShow(true)
end
function PaGlobal_ElfWarMissionAccept:prepareClose()
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  self:close()
end
function PaGlobal_ElfWarMissionAccept:close()
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  Panel_ElfWar_MissionAccept:EraseAllEffect()
  Panel_ElfWar_MissionAccept:ClearUpdateLuaFunc()
  Panel_ElfWar_MissionAccept:SetShow(false)
end
function PaGlobal_ElfWarMissionAccept:update(deltaTime)
  if Panel_ElfWar_MissionAccept == nil then
    return
  end
  self._timeAcc = self._timeAcc + deltaTime
  if self._showTime <= self._timeAcc then
    self._timeAcc = 0
    self:prepareClose()
    return
  end
end
