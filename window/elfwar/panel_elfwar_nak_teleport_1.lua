function PaGlobal_ElfWarNakTeleport:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_normalBG = UI.getChildControl(Panel_ElfWar_Nak_Teleport, "Static_ElfWar_Teleport_Normal")
  self._ui._txt_normalTime = UI.getChildControl(self._ui._stc_normalBG, "StaticText_2")
  self._ui._stc_vehicleBG = UI.getChildControl(Panel_ElfWar_Nak_Teleport, "Static_ElfWar_Teleport_Vehicle")
  self._ui._txt_vehicleTime = UI.getChildControl(self._ui._stc_vehicleBG, "StaticText_2")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ElfWarNakTeleport:registEventHandler()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  registerEvent("FromClient_ShowElfWarRecallAlarmUI", "FromClient_ShowElfWarRecallAlarmUI")
end
function PaGlobal_ElfWarNakTeleport:prepareOpen(showTimeSec, fierceBattleKeyRaw, isVehicleMode)
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  if ToClient_IsParticipateInElfWar() == false then
    return
  end
  self._accumulatedDeltaTime = 0
  self._remainTimeSec = 0
  self._showTimeSec = showTimeSec
  self._targetFierceBattleKeyRaw = fierceBattleKeyRaw
  self._isVehicleMode = isVehicleMode
  self._ui._stc_normalBG:SetShow(self._isVehicleMode == false)
  self._ui._stc_vehicleBG:SetShow(self._isVehicleMode == true)
  self:open()
end
function PaGlobal_ElfWarNakTeleport:open()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  Panel_ElfWar_Nak_Teleport:RegisterUpdateFunc("PaGlobalFunc_ElfWarNakTeleport_Update")
  Panel_ElfWar_Nak_Teleport:SetShow(true)
end
function PaGlobal_ElfWarNakTeleport:prepareClose()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  self._accumulatedDeltaTime = 0
  self._showTimeSec = 0
  self:close()
end
function PaGlobal_ElfWarNakTeleport:close()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  Panel_ElfWar_Nak_Teleport:ClearUpdateLuaFunc()
  Panel_ElfWar_Nak_Teleport:SetShow(false)
end
function PaGlobal_ElfWarNakTeleport:validate()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  self._ui._stc_normalBG:isValidate()
  self._ui._txt_normalTime:isValidate()
  self._ui._stc_vehicleBG:isValidate()
  self._ui._txt_vehicleTime:isValidate()
end
function PaGlobal_ElfWarNakTeleport:update(deltaTime)
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  self._accumulatedDeltaTime = self._accumulatedDeltaTime + deltaTime
  if self._showTimeSec <= self._accumulatedDeltaTime then
    self:prepareClose()
    return
  end
  local remainTimeSec = math.floor(self._showTimeSec - self._accumulatedDeltaTime) + 1
  if self._remainTimeSec ~= remainTimeSec then
    self._remainTimeSec = remainTimeSec
    self:updateText()
  end
end
function PaGlobal_ElfWarNakTeleport:updateText()
  if Panel_ElfWar_Nak_Teleport == nil then
    return
  end
  local targetFierceBattleObjectName = ""
  local targetFierceBattleObjectWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(self._targetFierceBattleKeyRaw)
  if targetFierceBattleObjectWrapper ~= nil then
    targetFierceBattleObjectName = targetFierceBattleObjectWrapper:getName()
  end
  if self._isVehicleMode == true then
    self._ui._txt_vehicleTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ELFWAR_NAK_TELEPORT_VEHICLE", "second", self._remainTimeSec))
  else
    self._ui._txt_normalTime:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ELFWAR_NAK_TELEPORT_NORMAL", "second", self._remainTimeSec, "sanctum", targetFierceBattleObjectName))
  end
end
