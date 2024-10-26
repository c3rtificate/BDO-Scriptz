function PaGlobal_GuildWarfareNew_All:initialize()
  if true == PaGlobal_GuildWarfareNew_All._initialize then
    return
  end
  self._ui.stc_SelectBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_SelectArea")
  self._ui.list_history = UI.getChildControl(self._ui.stc_SelectBG, "List2_History")
  self._ui.btn_history = UI.getChildControl(self._ui.stc_SelectBG, "Button_HistoryToggle")
  self._ui.txt_WarType = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_WarType")
  self._ui.txt_Region = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_Region")
  self._ui.txt_Result = UI.getChildControl(self._ui.stc_SelectBG, "StaticText_Result")
  self._ui.btn_Refresh = UI.getChildControl(self._ui.stc_SelectBG, "Button_Refresh")
  self._ui.stc_TopBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_TopArea")
  self._ui.txt_CharName = UI.getChildControl(self._ui.stc_TopBG, "StaticText_M_CharName")
  self._ui.stc_CommadCenter = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CommandCenter")
  self._ui.stc_Tower = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Tower")
  self._ui.stc_CastleGate = UI.getChildControl(self._ui.stc_TopBG, "Static_M_CastleGate")
  self._ui.stc_Summons = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Summons")
  self._ui.stc_Installation = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Installation")
  self._ui.stc_Member = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Member")
  self._ui.stc_Death = UI.getChildControl(self._ui.stc_TopBG, "Static_M_Death")
  self._ui.txt_Sort = UI.getChildControl(self._ui.stc_TopBG, "StaticText_Sort")
  self._ui.stc_MainBG = UI.getChildControl(Panel_GuildWarfareNew_All, "Static_MainArea")
  self._ui.stc_LeftBG = UI.getChildControl(self._ui.stc_MainBG, "Static_LeftBG")
  self._ui.stc_RightBG = UI.getChildControl(self._ui.stc_MainBG, "Static_RIghtBG")
  self._ui.list2_Warfare = UI.getChildControl(self._ui.stc_MainBG, "List2_Warfare")
  self._ui.txt_IconHelper = UI.getChildControl(Panel_GuildWarfareNew_All, "StaticText_IconHelper")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._icons = {
    [0] = self._ui.txt_CharName,
    self._ui.stc_CommadCenter,
    self._ui.stc_Tower,
    self._ui.stc_CastleGate,
    self._ui.stc_Summons,
    self._ui.stc_Installation,
    self._ui.stc_Member,
    self._ui.stc_Death
  }
  self._isListDescSort = {
    name = false,
    command = false,
    tower = false,
    castlegate = false,
    summons = false,
    installation = false,
    member = false,
    death = false,
    killBySiege = false
  }
  self._ui.list2_Warfare:changeAnimationSpeed(50)
  if false == self._isConsole then
    self._ui.list2_Warfare:changeScrollMoveIndex(10)
  end
  PaGlobal_GuildWarfareNew_All:validate()
  PaGlobal_GuildWarfareNew_All:registEventHandler(self._isConsole)
  PaGlobal_GuildWarfareNew_All._initialize = true
  self._isFirstOpenTab = true
end
function PaGlobal_GuildWarfareNew_All:registEventHandler(isConsole)
  if nil == Panel_GuildWarfareNew_All then
    return
  end
  self._ui.btn_Refresh:addInputEvent("Mouse_LUp", "PaGlobal_GuildWarfareNew_All_HistoryRefresh()")
  self._ui.btn_Refresh:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(true)")
  self._ui.btn_Refresh:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarfareNew_All_RefershShowTooltip(false)")
  self._ui.list2_Warfare:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWarfareNew_CreateContents_All")
  self._ui.list2_Warfare:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list2_Warfare:addInputEvent("Mouse_UpScroll", "PaGlobal_GuildWarfare_All_SaveScrollData()")
  self._ui.list2_Warfare:addInputEvent("Mouse_DownScroll", "PaGlobal_GuildWarfare_All_SaveScrollData()")
  self._ui.list2_Warfare:getElementManager():clearKey()
  self._ui.list_history:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWarfareNew_All_HistoryList")
  self._ui.list_history:createChildContent(__ePAUIList2ElementManagerType_List)
  for idx, control in pairs(self._icons) do
    control:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarfareNew_Select_SortType( " .. idx .. ")")
    if 0 ~= idx then
      control:addInputEvent("Mouse_On", "HandleEventLUp_GuildWarfareNew_IconToolTip_Show(" .. idx .. ", true)")
      control:addInputEvent("Mouse_Out", "HandleEventLUp_GuildWarfareNew_IconToolTip_Show(" .. idx .. ", false)")
    end
  end
  self._ui.btn_history:addInputEvent("Mouse_LUp", "PaGlobal_GuildWarfare_All_ToggleList()")
  registerEvent("FromClient_GuildSiegeHistoryListAck", "PaGlobal_GuildWarfareNew_All_HistoryRecordUpdate")
  registerEvent("FromClient_GuildSiegePersonalRecordListAck", "PaGlobal_GuildWarfareNew_All_PersonalRecordUpdate")
  registerEvent("FromClient_ResponseParticipateSiege", "PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate")
  registerEvent("FromClient_GuildSiegeProgressingPersonalScoreUpdate", "PaGlobal_GuildWarfareNew_All_ProgressingScoreUpdate")
  registerEvent("FromClient_GuildSelfJoin", "PaGlobalFunc_GuildWarfareNew_All_ResetAll")
end
function PaGlobal_GuildWarfareNew_All:prepareOpen()
  if false == self._initialize then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_GuildWarfareNew_All:prepareClose()
  if nil == Panel_GuildWarfareNew_All then
    return
  end
  if self._ui.btn_history:IsCheck() == true then
    self._ui.btn_history:SetCheck(false)
    self._ui.list_history:SetShow(false)
  end
  PaGlobal_GuildWarfareNew_All:close()
end
function PaGlobal_GuildWarfareNew_All:close()
  if nil == Panel_GuildWarfareNew_All then
    return
  end
  Panel_GuildWarfareNew_All:SetShow(false)
end
function PaGlobal_GuildWarfareNew_All:open()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  PaGlobal_GuildWarfareNew_All:SetShow(true)
end
function PaGlobal_GuildWarfareNew_All:update()
  if false == self._initialize then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  self:updateSiegeRecordList()
  self:updateSiegePersonalRecordList()
  self:sortDataList()
  PaGlobal_GuildWarfare_All_LoadScrollData()
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordState()
  self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST
  local isProgressingSiege = ToClient_isAnySiegeBeingForRecord()
  local historyRecordCount = ToClient_getGuildSiegeHistoryRecordCount()
  local loadLast = ToClient_isLoadLastGuildSiegeHistoryRecord()
  local moreRequestButton = loadLast == true or historyRecordCount >= 30
  if isProgressingSiege == false then
    if historyRecordCount == 0 then
      if moreRequestButton == false then
        self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST
      else
        self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA
      end
    elseif moreRequestButton == false then
      self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_NOLAST
    else
      self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_LAST
    end
  elseif moreRequestButton == false then
    self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_NOLAST
  else
    self._currentSiegeHistoryState = self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_LAST
  end
end
function PaGlobal_GuildWarfareNew_All:onChangeSiegeRecordListSelect()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type == self._type.eJustToday then
  elseif data._type == self._type.eProgressing then
  elseif data._type == self._type.eHistory then
    local siegeHistoryRecordIndex = data._historyIndex
    local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(siegeHistoryRecordIndex)
    if siegeHistoryWrapper ~= nil then
      local siegeScoreNo = siegeHistoryWrapper:getSiegeScoreNo()
      local personalRecordLoaded = ToClient_getGuildSiegePersonalRecordLoaded(siegeHistoryRecordIndex)
      if personalRecordLoaded == false then
        local callSuccess = ToClient_reqestPersonalRecord(siegeHistoryRecordIndex)
        if callSuccess == false then
          self._currentHistoryListIndex = 0
        end
      end
    end
  elseif data._type == self._type.eRequestHistory then
    local success = ToClient_reqestRecentSiegeHistory()
    if success == true then
      self:updateSiegeRecordList()
    end
  end
  self:updateSiegePersonalRecordList()
end
function PaGlobal_GuildWarfareNew_All:updateSelectTitle()
  self._ui.txt_WarType:SetShow(false)
  self._ui.txt_Region:SetShow(false)
  self._ui.txt_Result:SetShow(false)
  self._ui.btn_history:SetText("---")
  self._ui.btn_history:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(self._ui.btn_history)
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  self._ui.btn_history:SetText(data._text)
  if data._type == self._type.eJustToday then
    self._ui.txt_WarType:SetShow(false)
    self._ui.txt_Region:SetShow(false)
    self._ui.txt_Result:SetShow(false)
  elseif data._type == self._type.eProgressing then
    local siegeBeing = ToClient_isAnySiegeBeingForRecord()
    if siegeBeing == false then
      self._ui.txt_WarType:SetShow(false)
      self._ui.txt_Region:SetShow(false)
    else
      self._ui.txt_WarType:SetShow(true)
      self._ui.txt_Region:SetShow(true)
      local isMinorSiegeBeing = ToClient_isMinorSiegeBeingForRecord()
      if isMinorSiegeBeing == true then
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SIEGEWAR"))
      else
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_TERRITORYWAR"))
      end
      local progressingTerritoryName = ToClient_isAnySiegeBeingTerritoryName()
      self._ui.txt_Region:SetText(progressingTerritoryName)
    end
  elseif data._type == self._type.eHistory then
    local historyIndex = data._historyIndex
    local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
    if siegeHistoryWrapper == nil then
      self._ui.txt_WarType:SetShow(false)
      self._ui.txt_Region:SetShow(false)
    else
      self._ui.txt_WarType:SetShow(true)
      self._ui.txt_Region:SetShow(true)
      if siegeHistoryWrapper:isVilliageSiege() then
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SIEGEWAR"))
      else
        self._ui.txt_WarType:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_TERRITORYWAR"))
      end
      local territoryName = ToClient_getTerritoryNameByTerritoryKey(siegeHistoryWrapper:getTerritoryKeyRaw())
      self._ui.txt_Region:SetText(territoryName)
      local siegeResult = siegeHistoryWrapper:isOccupied()
      if siegeResult == 0 then
        self._ui.txt_Result:SetShow(false)
      elseif siegeResult == 1 then
        self._ui.txt_Result:SetShow(true)
        self._ui.txt_Result:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_FAIL"))
      elseif siegeResult == 2 then
        self._ui.txt_Result:SetShow(true)
        self._ui.txt_Result:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_WARFAIR_SUCCESS"))
      end
    end
  end
end
function PaGlobal_GuildWarfareNew_All:updateSiegePersonalRecordList()
  local myGuildWarfareListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWarfareListInfo then
    return
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  self:updateSelectTitle()
  local historyRecordCount = ToClient_getGuildSiegeHistoryRecordCount()
  if self._currentHistoryListIndex < 0 then
    for key, control in pairs(self._personalDataList) do
      control = nil
    end
    self._personalDataListSize = 0
  end
  if self._currentHistoryListIndex < 0 then
    return
  end
  local data = self._listData[self._currentHistoryListIndex]
  if data == nil then
    return
  end
  if data._type == self._type.eJustToday then
    for key, control in pairs(self._personalDataList) do
      control = nil
    end
    self._personalDataListSize = 0
  elseif data._type == self._type.eProgressing then
    ToClient_refreshProgressingGuildSiegePersonalRecord()
    local progressCount = ToClient_getProgressingGuildSiegePersonalRecordCount()
    for personalIndex = 0, progressCount - 1 do
      local presonalRecordWrapper = ToClient_getProgressingGuildSiegePersonalRecord(personalIndex)
      self._personalDataList[personalIndex] = {
        idx = personalIndex,
        name = presonalRecordWrapper:getUserNickname(),
        userNo = presonalRecordWrapper:getUserNo(),
        command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
        tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
        castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
        help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
        summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
        installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
        master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
        commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
        member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
        death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
        killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon)
      }
      local killCount = self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
      self._personalDataList[personalIndex].member = killCount
    end
    self._personalDataListSize = progressCount
  elseif data._type == self._type.eHistory then
    local siegeHistoryRecordIndex = data._historyIndex
    local personalRecordCount = ToClient_getGuildSiegePersonalRecordCount(siegeHistoryRecordIndex)
    if personalRecordCount == 0 then
      for key, control in pairs(self._personalDataList) do
        control = nil
      end
      self._personalDataListSize = 0
    else
      for personalIndex = 0, personalRecordCount - 1 do
        local presonalRecordWrapper = ToClient_getGuildSiegePersonalRecord(siegeHistoryRecordIndex, personalIndex)
        self._personalDataList[personalIndex] = {
          idx = personalIndex,
          name = presonalRecordWrapper:getUserNickname(),
          userNo = presonalRecordWrapper:getUserNo(),
          command = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeSymbol),
          tower = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSiegeTent),
          castlegate = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeCastleGate),
          help = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeAssist),
          summons = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSummon),
          installation = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeInstallation),
          master = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeGuildMaster),
          commander = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadCaptain),
          member = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeSquadMember),
          death = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeDeath),
          killBySiege = presonalRecordWrapper:getKillCount(__eSiegeImportantTypeKillBySiegeWeapon)
        }
        local killCount = self._personalDataList[personalIndex].master + self._personalDataList[personalIndex].commander + self._personalDataList[personalIndex].member + self._personalDataList[personalIndex].killBySiege
        self._personalDataList[personalIndex].member = killCount
      end
      self._personalDataListSize = personalRecordCount
    end
  else
    _PA_LOG("\234\184\184\235\147\156\237\152\132\237\153\169", " \236\157\180\235\159\176 \234\178\189\236\154\176\234\176\128 \236\158\136\236\156\188\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.Type :" .. data._type)
  end
  for index = 0, self._personalDataListSize - 1 do
    if nil ~= self._personalDataList[index] then
      self._ui.list2_Warfare:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_GuildWarfareNew_All:createListContents(contents, key)
  contents:SetIgnore(not self._isConsole)
  if self._currentHistoryListIndex < 0 then
    return
  end
  local index = Int64toInt32(key)
  local dataIdx = self._personalDataList[index].idx
  local txt_CharName = UI.getChildControl(contents, "StaticText_V_CharName")
  local txt_CommandCenter = UI.getChildControl(contents, "StaticText_V_CommandCenter")
  local txt_Tower = UI.getChildControl(contents, "StaticText_V_Tower")
  local txt_CastleGate = UI.getChildControl(contents, "StaticText_V_CastleGate")
  local txt_Summons = UI.getChildControl(contents, "StaticText_V_Summons")
  local txt_Installation = UI.getChildControl(contents, "StaticText_V_Installation")
  local txt_Member = UI.getChildControl(contents, "StaticText_V_Member")
  local txt_Death = UI.getChildControl(contents, "StaticText_V_Death")
  local txt_PlatformIcon = UI.getChildControl(contents, "Static_CrossPlay")
  txt_CommandCenter:SetText(self._personalDataList[index].command)
  txt_Tower:SetText(self._personalDataList[index].tower)
  txt_CastleGate:SetText(self._personalDataList[index].castlegate)
  txt_Summons:SetText(self._personalDataList[index].summons)
  txt_Installation:SetText(self._personalDataList[index].installation)
  txt_Member:SetText(self._personalDataList[index].member)
  txt_Death:SetText(self._personalDataList[index].death)
  txt_CharName:SetText(self._personalDataList[index].name)
  txt_PlatformIcon:SetShow(false)
  if self._personalDataList[index].userNo == getSelfPlayer():get():getUserNo() then
    txt_CharName:SetFontColor(Defines.Color.C_FFEF9C7F)
  else
    txt_CharName:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  if true == ToClient_isTotalGameClient() then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    local selfPlayerPlatformType = ToClient_getGamePlatformType()
    local myGuildMemberInfo = myGuildInfo:getMemberByUserNo(self._personalDataList[index].userNo)
    if myGuildMemberInfo == nil then
      myGuildMemberInfo = myGuildInfo:getVolunteerMemberByUserNo(self._personalDataList[index].userNo)
    end
    if myGuildMemberInfo == nil then
      local guildOut = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMEMBER_WITHDRAW_GUILD")
      txt_CharName:SetText(guildOut)
    else
      local isOnline = myGuildMemberInfo:isOnline()
      local memberPlatformType = myGuildMemberInfo:getPlatformType()
      local platformID
      if isOnline == true and selfPlayerPlatformType == memberPlatformType then
        if true == ToClient_isPS() then
          platformID = " / ( " .. tostring(ToClient_getOnlineId(self._personalDataList[index].userNo)) .. " )"
        elseif true == ToClient_isXBox() then
          platformID = " / ( " .. tostring(ToClient_getXboxGuildUserGamerTag(self._personalDataList[index].userNo)) .. " )"
        end
      end
      if nil == platformID then
        platformID = " / ( - )"
      end
      txt_CharName:SetText(self._personalDataList[index].name .. platformID)
      self:setCrossPlayIcon(txt_PlatformIcon, memberPlatformType, txt_CharName)
    end
  end
  txt_CharName:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(txt_CharName)
end
function PaGlobal_GuildWarfareNew_All:setCrossPlayIcon(targetControl, platformType, nameControl)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordData()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  for index = 0, self._listDataSize - 1 do
    if self._listData[index] ~= nil then
      self._listData[index] = nil
    end
  end
  self._listDataSize = 0
  local addCurrentData = false
  local addProgressingSiege = false
  local addHistoryRecord = false
  local addRequestMoreList = false
  if self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA_NOLAST then
    addCurrentData = true
    addRequestMoreList = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_NODATA then
    addCurrentData = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_NOLAST then
    addHistoryRecord = true
    addRequestMoreList = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.NOTPROGRESSING_DATA_LAST then
    addHistoryRecord = true
  elseif self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_NOLAST then
    addProgressingSiege = true
    addHistoryRecord = true
    addRequestMoreList = true
  else
    if self._currentSiegeHistoryState == self.ENUM_SIEGE_RECORD_COMBOBOX_STATE.PROGRESSING_LAST then
      addProgressingSiege = true
      addHistoryRecord = true
    else
    end
  end
  if addCurrentData == true then
    local year = ToClient_GetThisYear()
    local month = ToClient_GetThisMonth()
    local day = ToClient_GetToday()
    local yearRear2 = year % 100
    local dayOfWeek = ToClient_GetDayOfWeekYearMonthDay(year, month, day)
    local dayString = self._dayStringList[dayOfWeek]
    local curTimeString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_DATE", "year", tostring(yearRear2), "month", tostring(month), "day", tostring(day))
    self._listData[self._listDataSize] = {
      _type = self._type.eJustToday,
      _text = curTimeString .. "(" .. dayString .. ")",
      _siegeScroeNo = nil,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
  if addProgressingSiege == true then
    self._listData[self._listDataSize] = {
      _type = self._type.eProgressing,
      _text = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDWARFAREINFO"),
      _siegeScroeNo = nil,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
  if addHistoryRecord == true then
    local dataText = ""
    local siegeScoreNo = 0
    local dataHistoryIndex = -1
    local historyRecordCount = ToClient_getGuildSiegeHistoryRecordCount()
    for historyIndex = 0, historyRecordCount - 1 do
      local siegeHistoryWrapper = ToClient_getGuildSiegeHistoryRecordRecord(historyIndex)
      if siegeHistoryWrapper == nil then
        dataText = "---"
      else
        siegeScoreNo = siegeHistoryWrapper:getSiegeScoreNo()
        local isYear = ToClient_getYearFromSiegeScoreNo(siegeScoreNo) % 100
        local isMonth = ToClient_getMonthFromSiegeScoreNo(siegeScoreNo)
        local isDay = ToClient_getDayFromSiegeScoreNo(siegeScoreNo)
        local day = ToClient_getDayOfWeekFromSiegeScroeNo(siegeScoreNo)
        local dayString = self._dayStringList[day]
        local curTimeString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_DATE", "year", tostring(isYear), "month", tostring(isMonth), "day", tostring(isDay))
        dataText = curTimeString .. "(" .. dayString .. ")"
      end
      self._listData[self._listDataSize] = {
        _type = self._type.eHistory,
        _text = dataText,
        _siegeScroeNo = siegeScoreNo,
        _historyIndex = historyIndex
      }
      self._listDataSize = self._listDataSize + 1
    end
  end
  if addRequestMoreList == true then
    self._listData[self._listDataSize] = {
      _type = self._type.eRequestHistory,
      _text = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_JOIN_REFRESHLIST"),
      _siegeScroeNo = 0,
      _historyIndex = -1
    }
    self._listDataSize = self._listDataSize + 1
  end
end
function PaGlobal_GuildWarfareNew_All:updateSiegeRecordList()
  if Panel_GuildWarfareNew_All == nil then
    return
  end
  self:updateSiegeRecordState()
  self:updateSiegeRecordData()
  self._ui.list_history:getElementManager():clearKey()
  for index = 0, self._listDataSize - 1 do
    self._ui.list_history:getElementManager():pushKey(index)
  end
end
function PaGlobal_GuildWarfareNew_All:createHistoryListContents(contents, key)
  local dataSize = self._listDataSize
  if dataSize <= 0 then
    return
  end
  local index = Int64toInt32(key)
  local text = UI.getChildControl(contents, "StaticText_History")
  contents:SetIgnore(false)
  text:SetText(self._listData[index]._text)
  text:SetTextMode(__eTextMode_LimitText)
  UI.setLimitTextAndAddTooltip(text)
  contents:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarfareNew_UpdateRecordList(" .. index .. ")")
end
function PaGlobal_GuildWarfareNew_All:validate()
  self._ui.stc_SelectBG:isValidate()
  self._ui.txt_WarType:isValidate()
  self._ui.txt_Region:isValidate()
  self._ui.txt_Result:isValidate()
  self._ui.btn_Refresh:isValidate()
  self._ui.stc_TopBG:isValidate()
  self._ui.txt_CharName:isValidate()
  self._ui.stc_CommadCenter:isValidate()
  self._ui.stc_Tower:isValidate()
  self._ui.stc_CastleGate:isValidate()
  self._ui.stc_Summons:isValidate()
  self._ui.stc_Installation:isValidate()
  self._ui.stc_Member:isValidate()
  self._ui.stc_Death:isValidate()
  self._ui.txt_Sort:isValidate()
  self._ui.stc_MainBG:isValidate()
  self._ui.list2_Warfare:isValidate()
  self._ui.list_history:isValidate()
  self._ui.btn_history:isValidate()
end
function PaGlobal_GuildWarfareNew_All:hideSortIcon()
  self._ui.txt_Sort:SetShow(false)
end
function PaGlobal_GuildWarfareNew_All:setSortIcon(index, isDsce)
  self._ui.txt_Sort:SetPosX(self._icons[index]:GetPosX() + self._icons[index]:GetSizeX())
  if 0 == index then
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFD8AD70)
  else
    self._ui.txt_Sort:SetFontColor(Defines.Color.C_FFFFFFFF)
  end
  if isDsce then
    self._ui.txt_Sort:SetText("\226\150\188")
  else
    self._ui.txt_Sort:SetText("\226\150\178")
  end
  self._ui.txt_Sort:SetShow(true)
end
function PaGlobal_GuildWarfareNew_All:selectSortType(sortType)
  self._selectedSortType = sortType
  local isDsce
  if 0 == sortType then
    self._isListDescSort.name = not self._isListDescSort.name
    isDsce = self._isListDescSort.name
  elseif 1 == sortType then
    self._isListDescSort.command = not self._isListDescSort.command
    isDsce = self._isListDescSort.command
  elseif 2 == sortType then
    self._isListDescSort.tower = not self._isListDescSort.tower
    isDsce = self._isListDescSort.tower
  elseif 3 == sortType then
    self._isListDescSort.castlegate = not self._isListDescSort.castlegate
    isDsce = self._isListDescSort.castlegate
  elseif 4 == sortType then
    self._isListDescSort.summons = not self._isListDescSort.summons
    isDsce = self._isListDescSort.summons
  elseif 5 == sortType then
    self._isListDescSort.installation = not self._isListDescSort.installation
    isDsce = self._isListDescSort.installation
  elseif 6 == sortType then
    self._isListDescSort.member = not self._isListDescSort.member
    isDsce = self._isListDescSort.member
  elseif 7 == sortType then
    self._isListDescSort.death = not self._isListDescSort.death
    isDsce = self._isListDescSort.death
  end
  self:setSortIcon(sortType, isDsce)
  self:update()
end
local guildListCompareCommandCenter = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.command then
    if w1.command < w2.command then
      return true
    end
  elseif w2.command < w1.command then
    return true
  end
end
local guildListCompareTower = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.tower then
    if w1.tower < w2.tower then
      return true
    end
  elseif w2.tower < w1.tower then
    return true
  end
end
local guildListCompareCastleGate = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.castlegate then
    if w1.castlegate < w2.castlegate then
      return true
    end
  elseif w2.castlegate < w1.castlegate then
    return true
  end
end
local guildListCompareSummons = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.summons then
    if w1.summons < w2.summons then
      return true
    end
  elseif w2.summons < w1.summons then
    return true
  end
end
local guildListCompareInstallation = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.installation then
    if w1.installation < w2.installation then
      return true
    end
  elseif w2.installation < w1.installation then
    return true
  end
end
local guildListCompareMember = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.member then
    if w1.member < w2.member then
      return true
    end
  elseif w2.member < w1.member then
    return true
  end
end
local guildListCompareDeath = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.death then
    if w1.death < w2.death then
      return true
    end
  elseif w2.death < w1.death then
    return true
  end
end
local guildListCompareCharName = function(w1, w2)
  if PaGlobal_GuildWarfareNew_All._isListDescSort.name then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
function PaGlobal_GuildWarfareNew_All:sortDataList()
  local personalDataListTemp = {}
  for index = 0, self._personalDataListSize - 1 do
    if nil ~= self._personalDataList[index] then
      personalDataListTemp[index + 1] = self._personalDataList[index]
    end
  end
  if 0 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareCharName)
  elseif 1 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareCommandCenter)
  elseif 2 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareTower)
  elseif 3 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareCastleGate)
  elseif 4 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareSummons)
  elseif 5 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareInstallation)
  elseif 6 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareMember)
  elseif 7 == self._selectedSortType then
    table.sort(personalDataListTemp, guildListCompareDeath)
  end
  self._ui.list2_Warfare:getElementManager():clearKey()
  for index = 0, self._personalDataListSize - 1 do
    if nil ~= personalDataListTemp[index + 1] then
      self._personalDataList[index] = personalDataListTemp[index + 1]
      self._ui.list2_Warfare:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_GuildWarfareNew_All:initPersonalRecordListSort()
  self._selectedSortType = 0
  self._isListDescSort.name = true
  self:setSortIcon(self._selectedSortType, self._isListDescSort.name)
end
