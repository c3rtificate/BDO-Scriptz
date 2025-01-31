function PaGlobalFunc_Widget_Party_All_Open()
  PaGlobal_Party_All:prepareOpen()
end
function PaGlobalFunc_Widget_Party_All_Close()
  PaGlobal_Party_All:prepareClose()
end
function HandleEventLUp_Party_All_ChangeType(isMini)
  PaGlobal_Party_All:changeType(isMini)
end
function HandleEventLUp_Party_All_SetLootingOption(isMini)
  PaGlobal_Party_All:setLootingType(isMini)
end
function HandleEventLUp_Party_All_SelectLootingType(lootType)
  PaGlobal_Party_All:selectLootingType(lootType)
end
function HandleEventLUp_Party_All_SelectPartyOption(index)
  PaGlobal_Party_All:selectPartyOption(index)
end
function HandleEventLUp_Party_All_SelectWithdrawMemeber(index)
  PaGlobal_Party_All:selectWithdrawMember(index)
end
function HandleEventLUp_Party_All_SelectBanishMember(index)
  PaGlobal_Party_All:banishMemeber(index)
end
function HandleEventLUp_Party_All_SelectChangeLeader(index)
  PaGlobal_Party_All:selectChangeLeader(index)
end
function HandleEventLUp_Party_All_SetGrade(index)
  PaGlobal_Party_All:setGrade(index)
end
function HandleEventLUp_Party_All_ShowGradeListToggle()
  PaGlobal_Party_All:showGradeListToggle()
end
function HandleEventLUp_Party_All_ShowMarketOptionToggle()
  PaGlobal_Party_All:showMarketOptionToggle()
end
function HandleEventLUp_Party_All_ChangeMoney()
  Panel_NumberPad_Show(true, PaGlobal_Party_All._config.maxMoney, nil, PaGlobalFunc_Widget_Party_All_SetMoney)
end
function HandleEventLUp_Party_All_SetRegistItem()
  PaGlobal_Party_All:setRegistItem()
end
function HandleEventOnOut_Party_All_ShowSepcialGoodsToolTip(btnType, isShow)
  PaGlobal_Party_All:showSpecialGoodsTooltip(btnType, isShow)
end
function HandleEventLUp_Party_All_SelectPartyFollow(index)
  PaGlobal_Party_All:selectPartyFollow(index)
end
function HandleEventOnOut_Party_All_ShowSimpleTooltip(isShow, tipType, index)
  if 4 == tipType then
    if true == isShow then
      PaGlobal_Party_All._isRootShowFlag = true
    else
      PaGlobal_Party_All._isRootShowFlag = false
    end
  end
  PaGlobal_Party_All:showSimpleTooltip(isShow, tipType, index)
end
function HandleEventOnOut_Party_All_ShowNameTooltip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local control = PaGlobal_Party_All._ui.stc_members[index].control
  if true == PaGlobal_Party_All._ui_pc.stc_optionBG_Mini:GetShow() then
    control = PaGlobal_Party_All._ui.stc_members_Mini[index].control
  end
  local partyData = PaGlobal_Party_All._partyData[index]
  if nil == partyData then
    return
  end
  TooltipSimple_Show(control, "", partyData._name)
end
function HandleEventRUp_Party_All_NaviGuide(index)
  PaGlobal_Party_All:partymemberNaviGuide(index)
end
function FromClient_Party_All_createPartyList()
  PaGlobal_Party_All:createPartyList()
  if false == PaGlobal_Party_All._isConsole then
    local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
    PaGlobal_Party_All:changeType(isMiniPartyUI)
  end
  FromClient_Party_All_UpdatePartyMatchingState()
end
function FromClient_Party_All_updatePartyList()
  PaGlobal_Party_All:updatePartyList(false)
  if false == PaGlobal_Party_All._isConsole then
    local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
    PaGlobal_Party_All:changeType(isMiniPartyUI)
  end
  FromClient_Party_All_UpdatePartyMatchingState()
end
function FromClient_Party_All_OnScreenResize()
  PaGlobal_Party_All:onScreenSize()
end
function FromClient_Party_All_Invite(hostName, invitePartyType)
  PaGlobal_Party_All:invite(hostName, invitePartyType)
end
function FromClient_Party_All_Refuse(reason)
  PaGlobal_Party_All:refuse(reason)
end
function PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  local worldServerCount = getGameWorldServerDataCount()
  for ii = 1, worldServerCount do
    local worldServerData = getGameWorldServerDataByIndex(ii - 1)
    local lastServerName = getChannelName(worldServerData._worldNo, serverNo)
    if nil ~= lastServerName then
      return lastServerName
    end
  end
  return nil
end
function FromClient_Party_All_Accept(joinCharacterName, serverNo)
  local serverName = PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  if nil == serverName then
    return
  end
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "PANEL_PARTY_INVITE_ACCEPT_OTHERSERVER", "serverName", serverName, "characterName", joinCharacterName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_Party_All_JoinOtherServer(hostCharacterName, serverNo)
  local serverName = PaGlobalFunc_Widget_Party_All_GetServerName(serverNo)
  if nil == serverName then
    return
  end
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_JOIN_OTHERSERVER", "serverName", serverName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = contentString,
    functionYes = HandleEventLUp_GameExit_All_ServerChange,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_Party_All_ChangeLeader(actorKey)
  PaGlobal_Party_All:changeLeader(actorKey)
end
function FromClient_Party_All_Withdraw(withdrawType, actorKey, isMe)
  PaGlobal_Party_All:withdraw(withdrawType, actorKey, isMe)
end
function FromClient_Party_All_PartyOption_Hide()
  if nil == Panel_Widget_Party_All then
    return false
  end
  PaGlobal_Party_All:showRegistItem(false)
  PaGlobal_Party_All:closePartyOption()
  PaGlobal_Party_All._ui_pc.chk_dropItem:SetCheck(false)
  PaGlobal_Party_All._ui_pc.chk_dropItem_Mini:SetCheck(false)
  PaGlobal_Party_All:showLootingType()
  return false
end
function FromClient_Party_All_NotifyPartyMemberPickupItem(userName, itemName)
  local message = ""
  message = PAGetStringParam2(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM", "userName", userName, "itemName", itemName)
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_NotifyPartyMemberPickupItemFromPartyInventory(userName, itemName, itemCount)
  local message = ""
  message = PAGetStringParam3(Defines.StringSheet_GAME, "GAME_MESSAGE_NOTIFY_PARTYMEMBER_PICKUP_ITEM_FOR_PARTYINVENTORY", "userName", userName, "itemName", itemName, "itemCount", tostring(itemCount))
  Proc_ShowMessage_Ack_With_ChatType(message, nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.PartyItem)
end
function FromClient_Party_All_RenderModeChange(prevRenderModeList, nextRenderModeList)
  PaGlobal_Party_All:renderModeChange(prevRenderModeList, nextRenderModeList)
end
function FromClient_Party_All_SetFollowActor(actorKey)
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local name = ""
  local nameType = ToClient_getChatNameType()
  local playerActorProxyWrapper
  playerActorProxyWrapper = getPlayerActor(actorKey)
  if __eChatNameType_NickName == nameType and nil ~= playerActorProxyWrapper then
    name = playerActorProxyWrapper:getUserNickname()
  else
    name = actorProxyWrapper:getName()
  end
  if nil ~= playerActorProxyWrapper and true == playerActorProxyWrapper:get():isHideCharacterName() and false == playerActorProxyWrapper:get():isFlashBanged() then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERNAME_CAMO")
  end
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SETFOLLOWACTOR_MSG", "name", tostring(name))
  Proc_ShowMessage_Ack(message)
end
function FromClient_Party_All_EndFollowActor()
end
function PaGlobalFunc_Widget_Party_All_GetMemberCount()
  return RequestParty_getPartyMemberCount()
end
function PaGlobalFunc_Widget_Party_All_GetShow()
  if nil == Panel_Widget_Party_All then
    return false
  end
  return Panel_Widget_Party_All:GetShow()
end
function PaGlobalFunc_Widget_Party_All_SetMoney(inputNum)
  PaGlobal_Party_All:setMoney(inputNum)
end
function PaGlobalFunc_Widget_Party_All_ConditionShow()
  PaGlobal_Party_All:partyConditionalShow()
end
function PaGlobalFunc_Widget_Party_All_SetMemberData(partyMemberCount)
  PaGlobal_Party_All:setPartyMember(partyMemberCount)
  return PaGlobal_Party_All._partyData
end
function PaGlobalFunc_Widget_Party_All_SetMemberDataConsole(partyMemberCount)
  PaGlobal_Party_All:setPartyMember(partyMemberCount)
  local partyData = {}
  for index = 0, partyMemberCount - 1 do
    partyData[index] = PaGlobal_Party_All._partyData[index + 1]
  end
  return partyData
end
function PaGlobalFunc_Widget_Party_All_CheckInParty(name)
  local retval = false
  for key, value in pairs(PaGlobal_Party_All._partyData) do
    if value._name == name then
      retval = true
      break
    end
  end
  return retval
end
function PaGlobalFunc_Widget_Party_All_Resize()
  PaGlobal_Party_All:onScreenSize()
end
function HandleEventOnOut_Party_All_ShowEnableValuepackToolTip(onoff)
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == _contentsGroup_valueBuffReduceTax then
    return
  end
  local control
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  if true == isMiniPartyUI then
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_mini_enable
  else
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_enable
  end
  if nil == control then
    return
  end
  if true == onoff then
    TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_ENABLE_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_ENABLE_DESC"))
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Party_All_ShowDisableValuepackToolTip(onoff)
  if nil == Panel_Widget_Party_All then
    return
  end
  if false == _contentsGroup_valueBuffReduceTax then
    return
  end
  local control
  local isMiniPartyUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMiniPartyUI)
  if true == isMiniPartyUI then
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_mini_disable
  else
    control = PaGlobal_Party_All._ui_pc.stc_valuePack_disable
  end
  if nil == control then
    return
  end
  if true == onoff then
    TooltipSimple_Show(control, PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_DISABLE_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_PARTYWIDGET_VALUEEFFECT_DISABLE_DESC"))
  else
    TooltipSimple_Hide()
  end
end
function FromClient_PartyUpdateValuePackageIcon()
  if nil == Panel_Widget_Party_All then
    return
  end
  PaGlobal_Party_All:updateValuePackageIcon()
end
function FromClient_updatePartyLootType(lootType)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local currentLootTypeString = CppEnums.PartyLootType2String[lootType]
  if self._preLootType ~= nil and self._preLootType ~= currentLootTypeString then
    local rottingMsg = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_CHANGE_LOOTING_RULE1", "plt2s_lootType", currentLootTypeString)
    Proc_ShowMessage_Ack(rottingMsg)
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  elseif self._preLootType == nil then
    self._ui_pc.chk_dropItem:SetText(currentLootTypeString)
  end
  self._preLootType = currentLootTypeString
end
function FromClient_updatePartyDistributionOption(price_s64, itemGradeRaw)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_CHANGE_OPTION"))
  if true == self._ui_pc.stc_marketOptionBg:GetShow() then
    self._currentMoney = RequestParty_getDistributionPrice()
    if toInt64(0, 0) ~= self._currentMoney then
      self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._currentMoney) .. "<PAOldColor>")
      self._ui_pc.chk_minCost:SetCheck(true)
    else
      self._ui_pc.txt_minCostValue:SetText("<PAColor0xffe7d583>" .. makeDotMoney(self._config.baseMoney) .. "<PAOldColor>")
      self._ui_pc.chk_minCost:SetCheck(false)
    end
    self._currentGrade = RequestParty_getDistributionGrade()
    if 0 < self._currentGrade and self._currentGrade <= #self._itemGradeString then
      HandleEventLUp_Party_All_SetGrade(self._currentGrade)
      self._ui_pc.chk_grade:SetCheck(true)
    else
      HandleEventLUp_Party_All_SetGrade(0)
      self._ui_pc.chk_grade:SetCheck(false)
    end
  end
end
function FromClient_updatePartyMemberHp(actorKeyRaw, hp, maxHp)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:findPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._currentHp = hp * 100
  partyData._maxHp = maxHp
  _PA_ASSERT(maxHp > 0, "maxHp\234\176\128 0\236\157\180\237\149\152 \236\158\133\235\139\136\235\139\164.")
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  local isDead = partyData._currentHp <= 0
  member._stc_deadState:SetShow(isDead)
  member._progress_mp:SetShow(not isDead)
  member._progress_hp:SetShow(not isDead)
  member._progress_hp:SetProgressRate(partyData._currentHp / partyData._maxHp)
end
function FromClient_updatePartyMemberMp(actorKeyRaw, mp, maxMp)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:findPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._currentMp = mp * 100
  partyData._maxMp = maxMp
  _PA_ASSERT(maxMp > 0, "maxMp\234\176\128 0\236\157\180\237\149\152 \236\158\133\235\139\136\235\139\164.")
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  member._progress_mp:SetProgressRate(partyData._currentMp / partyData._maxMp)
end
function FromClient_updatePartyMemberLevel(actorKeyRaw, level)
  if false == Panel_Widget_Party_All:GetShow() then
    return
  end
  local self = PaGlobal_Party_All
  local partyData = self:findPartyDataByActorKeyRaw(actorKeyRaw)
  if nil == partyData then
    return
  end
  partyData._level = level
  local index = partyData._index
  local member
  if true == self._isMini then
    member = self._ui.stc_members_Mini[index + 1]
  else
    member = self._ui.stc_members[index + 1]
  end
  if nil == member then
    return
  end
  member._txt_level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. partyData._level)
  member._txt_name:SetPosX(member._txt_level:GetPosX() + member._txt_level:GetTextSizeX() + 3)
end
function FromClient_ChangeUserNicknameDirectly_Party()
  if Panel_Widget_Party_All:GetShow() == false then
    return
  end
  local self = PaGlobal_Party_All
  if self == nil then
    return
  end
  self:updatePartyList(false)
end
