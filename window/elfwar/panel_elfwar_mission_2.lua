function PaGlobalFunc_ElfWarMission_Open(openMode, param)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  local doRecalcPanelPos = true
  if PaGlobalFunc_ElfWarMission_IsShow() == true then
    doRecalcPanelPos = false
  end
  self:prepareOpen(openMode, param, doRecalcPanelPos)
  PaGlobal_ElfWarMiniMap._ui._chk_toggleElfWarMission:SetCheck(true)
end
function PaGlobalFunc_ElfWarMission_Close()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobal_ElfWarMiniMap._ui._chk_toggleElfWarMission:SetCheck(false)
  if Panel_ElfWar_MiniMap ~= nil then
    Panel_ElfWar_MiniMap:ResetRadiobutton(1)
  end
end
function PaGlobalFunc_ElfWarMission_IsShow()
  if Panel_ElfWar_Mission == nil then
    return false
  end
  return Panel_ElfWar_Mission:GetShow()
end
function PaGlobalFunc_ElfWarMission_AddParty(partyDataKey)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  self:addPartyData(partyDataKey)
end
function HandleEventLUp_ElfWarMission_SelectMissionType(elfWarMissionType, doSetDefaultIndex)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  self._selectedMissionType = elfWarMissionType
  self:deactivateTargetComboBox(doSetDefaultIndex)
  self:activateTargetComboBox()
  if self._selectedMissionType == __eElfWarMissionType_FierceAttack or self._selectedMissionType == __eElfWarMissionType_CastleAttack or self._selectedMissionType == __eElfWarMissionType_GimmikAttack then
    self._ui._btn_missionTypeAttack:SetCheck(true)
    self._ui._btn_missionTypeDefense:SetCheck(false)
    self._ui._btn_missionTypeKill:SetCheck(false)
  elseif self._selectedMissionType == __eElfWarMissionType_FierceDefence or self._selectedMissionType == __eElfWarMissionType_CastleDefence then
    self._ui._btn_missionTypeAttack:SetCheck(false)
    self._ui._btn_missionTypeDefense:SetCheck(true)
    self._ui._btn_missionTypeKill:SetCheck(false)
  elseif self._selectedMissionType == __eElfWarMissionType_Kill then
    self._ui._btn_missionTypeAttack:SetCheck(false)
    self._ui._btn_missionTypeDefense:SetCheck(false)
    self._ui._btn_missionTypeKill:SetCheck(true)
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
end
function HandleEventOnOut_ElfWarMission_ShowMissionTypeTooltip(isShow, elfWarMissionType)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_MISSIONLIST")
  local desc
  if elfWarMissionType == __eElfWarMissionType_FierceAttack then
    control = self._ui._btn_missionTypeAttack
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_ATTACK_TOOLTIP")
  elseif elfWarMissionType == __eElfWarMissionType_FierceDefence then
    control = self._ui._btn_missionTypeDefense
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_DEFENSE_TOOLTIP")
  elseif elfWarMissionType == __eElfWarMissionType_Kill then
    control = self._ui._btn_missionTypeKill
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_KILL_TOOLTIP")
  elseif elfWarMissionType == __eElfWarMissionType_CastleAttack then
    control = self._ui._btn_missionTypeAttack
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_ATTACK_TOOLTIP")
  elseif elfWarMissionType == __eElfWarMissionType_CastleDefence then
    control = self._ui._btn_missionTypeDefense
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_DEFENSE_TOOLTIP")
  elseif elfWarMissionType == __eElfWarMissionType_GimmikAttack then
    control = self._ui._btn_missionTypeAttack
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_ATTACK_TOOLTIP")
  else
    return
  end
  if control == nil or name == nil or desc == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ElfWarMission_ShowMissionRewardTooltip(isShow, totalMemberCount, cost)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._txt_missionRewardCount
  local name = ""
  local desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_COIN_TOOLTIP", "count", totalMemberCount, "cost", cost)
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ElfWarMission_ShowAddPartyTooltip(isShow, buttonIndex)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local partyButtonData = self._addPartyButtonDataList[buttonIndex]
  if partyButtonData == nil then
    return
  end
  local control = partyButtonData._button
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_MISSION_MEMSELECT_TOOLTIP")
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ElfWarMission_RequestCreateMission()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  local selectedTargetFierceBattleKeyRaw = 0
  if self._selectedMissionType == __eElfWarMissionType_FierceAttack or self._selectedMissionType == __eElfWarMissionType_FierceDefence or self._selectedMissionType == __eElfWarMissionType_GimmikAttack then
    if self._selectedTargetFierceBattleKeyRaw == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistSelectedRoseWarMissionTarget"))
      return
    end
    selectedTargetFierceBattleKeyRaw = self._selectedTargetFierceBattleKeyRaw
  elseif self._selectedMissionType == __eElfWarMissionType_Kill or self._selectedMissionType == __eElfWarMissionType_CastleAttack or self._selectedMissionType == __eElfWarMissionType_CastleDefence then
    selectedTargetFierceBattleKeyRaw = 0
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistSelectedRoseWarMissionType"))
    return
  end
  if self:getAddPartyDataCount() == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistSelectedRoseWarMissionParty"))
    return
  end
  for index = 0, self._addPartyButtonCount - 1 do
    local buttonData = self._addPartyButtonDataList[index]
    if buttonData ~= nil and buttonData._partyDataKey ~= nil then
      ToClient_RequestCreateElfWarMission(selectedTargetFierceBattleKeyRaw, self._selectedMissionType, buttonData._partyDataKey)
    end
  end
  PaGlobalFunc_ElfWarMission_Close()
end
function HandleEventLUp_ElfWarMission_AddMissionParty()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMiniMapPartyList_IsShow() == false then
    PaGlobalFunc_ElfWarMiniMapPartyList_Open(true)
  else
    PaGlobalFunc_ElfWarMiniMapPartyList_AddEffectToMissionAcceptableParty()
  end
end
function HandleEventLUp_ElfWarMission_RemoveSelectedParty(buttonIndex)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  local buttonData = self._addPartyButtonDataList[buttonIndex]
  if buttonData == nil then
    return
  end
  self:removePartyData(buttonData._partyDataKey)
  if PaGlobalFunc_ElfWarMiniMapPartyList_IsShow() == true then
    PaGlobalFunc_ElfWarMiniMapPartyList_AddEffectToMissionAcceptableParty()
  end
end
function HandleEventLUp_ElfWarMission_SelectTarget()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  local selectedIndex = self._ui._cbx_target:GetSelectIndex()
  local findIndex = 0
  local targetCount = ToClient_GetElfWarFierceBattleObjectCount()
  if self._selectedMissionType == __eElfWarMissionType_FierceAttack then
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and selfPlayerTeamNo ~= fierceBattleObjectInfoWrapper:getTeamNo() and ToClient_IsElfWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == false then
        if findIndex == selectedIndex then
          self:setSelectedTargetFierceBattleKeyRaw(fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw())
          break
        end
        findIndex = findIndex + 1
      end
    end
  elseif self._selectedMissionType == __eElfWarMissionType_FierceDefence then
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and selfPlayerTeamNo == fierceBattleObjectInfoWrapper:getTeamNo() and ToClient_IsElfWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == false then
        if findIndex == selectedIndex then
          self:setSelectedTargetFierceBattleKeyRaw(fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw())
          break
        end
        findIndex = findIndex + 1
      end
    end
  elseif self._selectedMissionType == __eElfWarMissionType_Kill then
    self:setSelectedTargetFierceBattleKeyRaw(nil)
  elseif self._selectedMissionType == __eElfWarMissionType_CastleAttack then
    self:setSelectedTargetFierceBattleKeyRaw(nil)
  elseif self._selectedMissionType == __eElfWarMissionType_CastleDefence then
    self:setSelectedTargetFierceBattleKeyRaw(nil)
  elseif self._selectedMissionType == __eElfWarMissionType_GimmikAttack then
    for index = 0, targetCount - 1 do
      local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapperByIndex(index)
      if fierceBattleObjectInfoWrapper ~= nil and ToClient_IsElfWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == true then
        local fierceBattleKeyRaw = fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw()
        local gimmickFierceBattleObjectWrapper = ToClient_GetElfWarGimicFierceBattleBuffStaticStatusWrapper(fierceBattleKeyRaw)
        if gimmickFierceBattleObjectWrapper ~= nil then
          self:setSelectedTargetFierceBattleKeyRaw(fierceBattleKeyRaw)
          break
        end
        findIndex = findIndex + 1
      end
    end
  else
    return
  end
end
function HandleEventLUp_ElfWarMission_ToggleTargetList()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  self._ui._cbx_target:ToggleListbox()
  if self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui._cbx_target)
  end
end
function FromClient_ElfWarMission_ReceivedNewMission(partyDataKey)
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  local randomSoundIndex = math.floor(math.random(1, 3))
  if randomSoundIndex == 1 then
    audioPostEvent_SystemUi(36, 67)
    _AudioPostEvent_SystemUiForXBOX(36, 67)
  elseif randomSoundIndex == 2 then
    audioPostEvent_SystemUi(36, 68)
    _AudioPostEvent_SystemUiForXBOX(36, 68)
  elseif randomSoundIndex == 3 then
    audioPostEvent_SystemUi(36, 69)
    _AudioPostEvent_SystemUiForXBOX(36, 69)
  end
end
function FromClient_ElfWarMission_UpdateTeamCoinCount()
  local self = PaGlobal_ElfWarMission
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMission_IsShow() == false then
    return
  end
  self:updateBottomText()
end
