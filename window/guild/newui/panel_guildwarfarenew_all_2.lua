function HandleEventLUp_GuildWarfareNew_IconToolTip_Show(iconNo, isOn)
  local mouse_posX = getMousePosX()
  local mouse_posY = getMousePosY()
  local panel_posX = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosX()
  local panel_posY = PaGlobal_GuildMain_All._ui.stc_Warfare_Bg:GetParentPosY()
  local _iconHelper = PaGlobal_GuildWarfareNew_All._ui.txt_IconHelper
  if iconNo == 1 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_COMMAND"))
  elseif iconNo == 2 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_TOWER"))
  elseif iconNo == 3 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DOOR"))
  elseif iconNo == 4 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_SUMMON"))
  elseif iconNo == 5 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_OBJECT"))
  elseif iconNo == 6 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_MEMBER"))
  elseif iconNo == 7 then
    _iconHelper:SetShow(true)
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TXT_WARFARE_HELP_DEATH"))
  elseif iconNo == 8 then
    _iconHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFARE_RIDEMACHINE_KILL"))
  end
  _iconHelper:SetSize(_iconHelper:GetTextSizeX() + 20, _iconHelper:GetSizeY())
  _iconHelper:SetPosX(mouse_posX - panel_posX)
  _iconHelper:SetPosY(mouse_posY - panel_posY + 15)
  _iconHelper:SetShow(isOn)
end
function HandleEventLUp_GuildWarfareNew_Select_SortType(sortType)
  PaGlobal_GuildWarfareNew_All:selectSortType(sortType)
end
function PaGlobalFunc_GuildWarfareNew_All_Update()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local isShowList = self._ui.list_history:GetShow()
  if isShowList == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
    ToClient_padSnapChangeToTarget(self._ui.btn_history)
  end
  PaGlobal_GuildWarfareNew_All:initPersonalRecordListSort()
  PaGlobal_GuildWarfareNew_All:update()
  ToClient_padSnapChangeToTarget(PaGlobal_GuildWarfareNew_All._ui.btn_history)
  PaGlobal_GuildWarfareNew_All_ResetScrollData()
  if self._currentHistoryListIndex ~= 0 then
    self._currentHistoryListIndex = 0
    self:onChangeSiegeRecordListSelect()
  end
  if self._isFirstOpenTab == true then
    self._isFirstOpenTab = false
    ToClient_reqestRecentSiegeHistory()
  end
end
function PaGlobalFunc_GuildWarfareNew_All_ResetAll()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  self._isFirstOpenTab = true
  local isShow = false
  if nil ~= Panel_GuildWarfareNew_All then
    isShow = Panel_GuildWarfareNew_All:GetShow()
  end
  if isShow == true then
    PaGlobalFunc_GuildWarfareNew_All_Update()
  end
end
function PaGlobal_GuildWarfareNew_CreateContents_All(contents, key)
  PaGlobal_GuildWarfareNew_All:createListContents(contents, key)
end
function PaGlobal_GuildWarfareNew_All_HistoryList(contents, key)
  PaGlobal_GuildWarfareNew_All:createHistoryListContents(contents, key)
end
function PaGlobal_GuildWarfareNew_All_ResetScrollData()
  PaGlobal_GuildWarfareNew_All._scrollData._pos = nil
  PaGlobal_GuildWarfareNew_All._scrollData._idx = nil
end
function PaGlobal_GuildWarfare_All_SaveScrollData()
  PaGlobal_GuildWarfareNew_All._scrollData._pos = PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:GetVScroll():GetControlPos()
  PaGlobal_GuildWarfareNew_All._scrollData._idx = PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:getCurrenttoIndex()
end
function PaGlobal_GuildWarfareNew_All_LoadScrollData()
  if nil == PaGlobal_GuildWarfareNew_All._scrollData._pos or nil == PaGlobal_GuildWarfareNew_All._scrollData._idx then
    return
  end
  PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:GetVScroll():SetControlPos(PaGlobal_GuildWarfareNew_All._scrollData._pos)
  PaGlobal_GuildWarfareNew_All._ui.list2_Warfare:setCurrenttoIndex(PaGlobal_GuildWarfareNew_All._scrollData._idx)
end
function PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type ~= self._type.eProgressing then
    return
  end
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfareNew_All_LoadScrollData()
end
function HandleEventLUp_GuildWarfareNew_UpdateRecordList(key)
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local index = Int64toInt32(key)
  if self._currentHistoryListIndex == index then
    PaGlobal_GuildWarfare_All_ToggleList()
    return
  end
  self._currentHistoryListIndex = index
  self:onChangeSiegeRecordListSelect()
  PaGlobal_GuildWarfare_All_ToggleList()
end
function PaGlobal_GuildWarfareNew_All_HistoryRefresh()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  ToClient_reqestNewestSiegeHistory()
end
function PaGlobal_GuildWarfareNew_All_HistoryRecordUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_NOTICE_REFRESH"))
  self._currentHistoryListIndex = -1
  PaGlobalFunc_GuildWarfareNew_All_Update()
end
function PaGlobal_GuildWarfareNew_All_PersonalRecordUpdate()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfare_All_LoadScrollData()
end
function HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(isShow)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = Panel_GuildWarfareNew_All
  name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_REFRESH_BTN")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARFAREINFO_REFRESH_DESC")
  if isShow == true then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_GuildWarfare_All_ToggleList()
  local self = PaGlobal_GuildWarfareNew_All
  if self == nil then
    return
  end
  local isShowList = self._ui.list_history:GetShow()
  if isShowList == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
    ToClient_padSnapChangeToTarget(self._ui.btn_history)
  else
    self._ui.btn_history:SetCheck(true)
    self._ui.list_history:SetShow(true)
    ToClient_padSnapChangeToTarget(self._ui.list_history)
  end
end
