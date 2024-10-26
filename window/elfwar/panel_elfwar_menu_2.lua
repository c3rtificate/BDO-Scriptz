function PaGlobalFunc_ElfWarMenu_Open()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ElfWarMenu_Close()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarMenu_IsShow()
  if Panel_ElfWar_Menu == nil then
    return false
  end
  return Panel_ElfWar_Menu:GetShow()
end
function HandleEventLUp_ElfWarMenu_OpenElfWarEditParty()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarEditParty_IsShow() == true then
    PaGlobalFunc_ElfWarEditParty_Close()
  else
    PaGlobalFunc_ElfWarEditParty_Open()
  end
end
function HandleEventLUp_ElfWarMenu_ApplyGuild()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:applyGuild()
end
function HandleEventLUp_ElfWarMenu_ApplyMercenary()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:applyMercenary()
end
function HandleEventLUp_ElfWarMenu_SelectMenu(menuIndex)
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  if menuIndex == self._applyGuildMenu then
    self:setMenuForApplyingGuild()
  elseif menuIndex == self._applyMercenaryMenu then
    self:setMenuForApplyingMercenary()
  elseif menuIndex == self._readyElfWarMenu then
    self:setMenuForReadyElfWar()
  else
    return
  end
end
function HandleEventLUp_ElfWarMenu_AppointLeader()
  ToClient_RequestElfWarMemberInfo()
end
function HandleEventLUp_ElfWarMenu_ReturnGuildMoney()
  ToClient_RequestReturnElfWarMoney(true)
end
function HandleEventLUp_ElfWarMenu_ReturnMercenaryMoney()
  ToClient_RequestReturnElfWarMoney(false)
end
function HandleEventLUp_ElfWarMenu_CancelApplyGuild()
  local requestCancelElfWarByGuild = function()
    ToClient_CancelElfWarByGuild()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CANCLEAPPLY_CONFIRM_LEADER")
  local messageBoxData = {
    title = nil,
    content = messageBoxMemo,
    functionYes = requestCancelElfWarByGuild,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, false, false)
end
function HandleEventLUp_ElfWarMenu_CancelApplyMercenary()
  local requestCancelElfWarByMercenary = function()
    ToClient_CancelElfWarByMercenary()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CANCLEAPPLY_CONFIRM_MERCENARY")
  local messageBoxData = {
    title = nil,
    content = messageBoxMemo,
    functionYes = requestCancelElfWarByMercenary,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, false, false)
end
function HandleEventLUp_ElfWarMenu_ToggleElfWarObserveMode()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  ToClient_RequestToggleElfWarObserveMode()
end
function HandleEventLUp_ElfWarMenu_ToggleElfWarTeamScoreBoard()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarTeamScoreBoard_IsShow() == true then
    PaGlobalFunc_ElfWarTeamScoreBoard_Close()
  else
    PaGlobalFunc_ElfWarTeamScoreBoard_Open()
  end
end
function HandleEventOnOut_ElfWarMenu_ShowElfWarObserveModeToolTip(isShow)
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._btn_elfWarObserveMode
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_WAR_CORRESPONDENT_TOOLTIP")
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function FromClient_ElfWarMenu_SetElfWarObserveMode()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:setElfWarObserveModeButton()
end
function FromClient_ElfWarMenu_UnsetElfWarObserveMode()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:setElfWarObserveModeButton()
end
function FromClient_ElfWarMenu_OnScreenResize()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  self:onScreenResize()
end
function FromClient_ElfWarMenu_ReceivedElfWarMemberInfo()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarPartyList_IsShow() == true then
    PaGlobalFunc_ElfWarPartyList_Close()
  end
  PaGlobalFunc_ElfWarPartyList_Open()
end
function FromClient_ElfWarMenu_UpdateMenu()
  local self = PaGlobal_ElfWarMenu
  if self == nil then
    return
  end
  HandleEventLUp_ElfWarMenu_SelectMenu(self._selectedMenuIndex)
end
