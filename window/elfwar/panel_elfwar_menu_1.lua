function PaGlobal_ElfWarMenu:initialize()
  if self._initialize == true then
    return
  end
  self._prevUIMode = Defines.UIMode.eUIMode_Default
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_ElfWarMenu
  }, false)
  self._renderMode:setClosefunctor(nil, PaGlobalFunc_ElfWarMenu_Close)
  self._ui._stc_mainBG = UI.getChildControl(Panel_ElfWar_Menu, "Static_ElfWar_BG")
  self._ui._stc_dimmed = UI.getChildControl(Panel_ElfWar_Menu, "Static_ElfWar_Dimmed")
  local symbolBox = UI.getChildControl(self._ui._stc_mainBG, "Static_SymbolBox")
  self._ui._stc_symbolSword = UI.getChildControl(symbolBox, "Static_Symbol_1_Sword")
  self._ui._stc_symbolGuildChoice = UI.getChildControl(symbolBox, "Static_Symbol_1")
  self._ui._stc_symbolMercenaryChoice = UI.getChildControl(symbolBox, "Static_Symbol_2")
  self._ui._stc_symbolElfWar = UI.getChildControl(symbolBox, "Static_Symbol_3")
  self._ui._stc_leaderBox = UI.getChildControl(self._ui._stc_mainBG, "Static_LeaderBox")
  self._ui._stc_kamaFlag = UI.getChildControl(self._ui._stc_leaderBox, "Static_KamaFlag")
  self._ui._stc_odilFlag = UI.getChildControl(self._ui._stc_leaderBox, "Static_OdilFlag")
  self._ui._stc_kamasylviaCamp = UI.getChildControl(self._ui._stc_kamaFlag, "StaticText_Kama")
  self._ui._stc_odyllitaCamp = UI.getChildControl(self._ui._stc_odilFlag, "StaticText_Odil")
  self._ui._stc_leaderBoxKamaGuildName = UI.getChildControl(self._ui._stc_kamaFlag, "StaticText_Kama_Commander")
  self._ui._stc_leaderBoxOdilGuildName = UI.getChildControl(self._ui._stc_odilFlag, "StaticText_Odil_Commander")
  self._ui._stc_mainDesc = UI.getChildControl(self._ui._stc_mainBG, "MultilineText_Main_Desc")
  self._ui._btn_appoint = UI.getChildControl(self._ui._stc_mainBG, "Button_Appoint")
  self._ui._stc_appointDone = UI.getChildControl(self._ui._stc_mainBG, "Static_Appoint_Done")
  self._ui._stc_commanderName = UI.getChildControl(self._ui._stc_appointDone, "MultilineText_UserName")
  local bottomArea = UI.getChildControl(self._ui._stc_mainBG, "Static_BottomArea")
  self._ui._applyGuild._btn_applyGuildArea = UI.getChildControl(bottomArea, "RadioButton_Step_1")
  self._ui._applyGuild._stc_title = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "MultilineText_Title")
  self._ui._applyGuild._stc_date = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "MultilineText_Date")
  self._ui._applyGuild._btn_applyGuild = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "Button_Apply")
  self._ui._applyGuild._btn_returnMoney = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "Button_ReturnMoney")
  self._ui._applyGuild._btn_cancelApply = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "Button_CancelApply")
  self._ui._applyGuild._stc_dateOver = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "StaticText_Not_Period")
  self._ui._applyGuild._stc_leaderBox = UI.getChildControl(self._ui._applyGuild._btn_applyGuildArea, "Static_LeaderBox_Mini")
  local applyGuildKamaFlag = UI.getChildControl(self._ui._applyGuild._stc_leaderBox, "Static_KamaFlag")
  local applyGuildOdilFlag = UI.getChildControl(self._ui._applyGuild._stc_leaderBox, "Static_OdilFlag")
  self._ui._applyGuild._stc_kama = UI.getChildControl(applyGuildKamaFlag, "StaticText_Kama")
  self._ui._applyGuild._stc_odil = UI.getChildControl(applyGuildOdilFlag, "StaticText_Odil")
  self._ui._applyGuild._stc_kamaCommander = UI.getChildControl(applyGuildKamaFlag, "StaticText_Kama_Commander")
  self._ui._applyGuild._stc_odilCommander = UI.getChildControl(applyGuildOdilFlag, "StaticText_Odil_Commander")
  self._ui._applyGuild._stc_unAppointCommander = UI.getChildControl(self._ui._applyGuild._stc_leaderBox, "StaticText_Unselect")
  self._ui._applyMercenary._btn_applyMercenaryArea = UI.getChildControl(bottomArea, "RadioButton_Step_2")
  self._ui._applyMercenary._stc_title = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "MultilineText_Title")
  self._ui._applyMercenary._stc_date = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "MultilineText_Date")
  self._ui._applyMercenary._btn_applyMercenary = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "Button_Apply")
  self._ui._applyMercenary._btn_returnMoney = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "Button_ReturnMoney")
  self._ui._applyMercenary._btn_cancelApply = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "Button_CancelApply")
  self._ui._applyMercenary._stc_dateOver = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "StaticText_Not_Period")
  self._ui._applyMercenary._stc_campKama = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "Static_Camp_Kama")
  self._ui._applyMercenary._stc_campOdil = UI.getChildControl(self._ui._applyMercenary._btn_applyMercenaryArea, "Static_Camp_Odyl")
  self._ui._readyElfWar._btn_readyElfWarArea = UI.getChildControl(bottomArea, "RadioButton_Step_3")
  self._ui._readyElfWar._stc_title = UI.getChildControl(self._ui._readyElfWar._btn_readyElfWarArea, "MultilineText_Title")
  self._ui._readyElfWar._stc_date = UI.getChildControl(self._ui._readyElfWar._btn_readyElfWarArea, "MultilineText_Date")
  self._ui._readyElfWar._btn_campList = UI.getChildControl(self._ui._readyElfWar._btn_readyElfWarArea, "Button_CampList")
  self._ui._readyElfWar._btn_elfWarLive = UI.getChildControl(self._ui._readyElfWar._btn_readyElfWarArea, "Button_ElfWar_Live")
  self._ui._readyElfWar._stc_dateOver = UI.getChildControl(self._ui._readyElfWar._btn_readyElfWarArea, "StaticText_Not_Period")
  self._ui._stc_bottomButtonArea = UI.getChildControl(self._ui._stc_mainBG, "Static_BottomButton")
  self._ui._btn_elfWarReward = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_Reward")
  self._ui._btn_elfWarRule = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_Rule")
  self._ui._btn_elfWarHistory = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_History")
  self._ui._btn_elfWarObserveMode = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_SetObserveMode")
  self._ui._btn_elfWarTeamScoreBoard = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_TeamScoreBoard")
  self._ui._stc_preSeasonGuide = UI.getChildControl(self._ui._stc_mainBG, "MultilineText_FreeSeason")
  self:registEventHandler()
  self:validate()
  self._ui._btn_appoint:SetShow(false)
  self._initialize = true
end
function PaGlobal_ElfWarMenu:registEventHandler()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self._ui._btn_appoint:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_AppointLeader()")
  self._ui._applyGuild._btn_applyGuildArea:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_SelectMenu(" .. tostring(self._applyGuildMenu) .. ")")
  self._ui._applyMercenary._btn_applyMercenaryArea:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_SelectMenu(" .. tostring(self._applyMercenaryMenu) .. ")")
  self._ui._readyElfWar._btn_readyElfWarArea:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_SelectMenu(" .. tostring(self._readyElfWarMenu) .. ")")
  self._ui._applyGuild._btn_applyGuild:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ApplyGuild()")
  self._ui._applyGuild._btn_cancelApply:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_CancelApplyGuild()")
  self._ui._applyGuild._btn_returnMoney:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ReturnGuildMoney()")
  self._ui._applyMercenary._btn_applyMercenary:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ApplyMercenary()")
  self._ui._applyMercenary._btn_returnMoney:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ReturnMercenaryMoney()")
  self._ui._applyMercenary._btn_cancelApply:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_CancelApplyMercenary()")
  self._ui._readyElfWar._btn_campList:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_OpenElfWarEditParty()")
  self._ui._btn_elfWarRule:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"WaroftheRoses\" )")
  self._ui._btn_elfWarObserveMode:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ToggleElfWarObserveMode()")
  self._ui._btn_elfWarObserveMode:addInputEvent("Mouse_On", "HandleEventOnOut_ElfWarMenu_ShowElfWarObserveModeToolTip(true)")
  self._ui._btn_elfWarObserveMode:addInputEvent("Mouse_Out", "HandleEventOnOut_ElfWarMenu_ShowElfWarObserveModeToolTip(false)")
  self._ui._btn_elfWarTeamScoreBoard:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMenu_ToggleElfWarTeamScoreBoard()")
  registerEvent("FromClient_UpdateElfWarState", "FromClient_ElfWarMenu_UpdateMenu")
  registerEvent("FromClient_UpdateElfWarTeamNo", "FromClient_ElfWarMenu_UpdateMenu")
  registerEvent("FromClient_RecievedElfWarMemberInfo", "FromClient_ElfWarMenu_ReceivedElfWarMemberInfo")
  registerEvent("FromClient_ChangeElfWarCommander", "FromClient_ElfWarMenu_UpdateMenu")
  registerEvent("FromClient_UpdateCanReturnMoney", "FromClient_ElfWarMenu_UpdateMenu")
  registerEvent("onScreenResize", "FromClient_ElfWarMenu_OnScreenResize")
  registerEvent("FromClient_SetElfWarObserveMode", "FromClient_ElfWarMenu_SetElfWarObserveMode")
  registerEvent("FromClient_UnsetElfWarObserveMode", "FromClient_ElfWarMenu_UnsetElfWarObserveMode")
end
function PaGlobal_ElfWarMenu:validate()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self._ui._stc_dimmed:isValidate()
  self._ui._stc_symbolSword:isValidate()
  self._ui._stc_symbolGuildChoice:isValidate()
  self._ui._stc_symbolMercenaryChoice:isValidate()
  self._ui._stc_symbolElfWar:isValidate()
  self._ui._stc_leaderBox:isValidate()
  self._ui._stc_kamaFlag:isValidate()
  self._ui._stc_odilFlag:isValidate()
  self._ui._stc_kamasylviaCamp:isValidate()
  self._ui._stc_odyllitaCamp:isValidate()
  self._ui._stc_leaderBoxKamaGuildName:isValidate()
  self._ui._stc_leaderBoxOdilGuildName:isValidate()
  self._ui._stc_mainDesc:isValidate()
  self._ui._btn_appoint:isValidate()
  self._ui._stc_appointDone:isValidate()
  self._ui._stc_commanderName:isValidate()
  self._ui._applyGuild._btn_applyGuildArea:isValidate()
  self._ui._applyGuild._stc_title:isValidate()
  self._ui._applyGuild._stc_date:isValidate()
  self._ui._applyGuild._btn_applyGuild:isValidate()
  self._ui._applyGuild._btn_returnMoney:isValidate()
  self._ui._applyGuild._btn_cancelApply:isValidate()
  self._ui._applyGuild._stc_dateOver:isValidate()
  self._ui._applyGuild._stc_leaderBox:isValidate()
  self._ui._applyGuild._stc_kama:isValidate()
  self._ui._applyGuild._stc_odil:isValidate()
  self._ui._applyGuild._stc_kamaCommander:isValidate()
  self._ui._applyGuild._stc_odilCommander:isValidate()
  self._ui._applyGuild._stc_unAppointCommander:isValidate()
  self._ui._applyMercenary._btn_applyMercenary:isValidate()
  self._ui._applyMercenary._stc_title:isValidate()
  self._ui._applyMercenary._stc_date:isValidate()
  self._ui._applyMercenary._btn_applyMercenary:isValidate()
  self._ui._applyMercenary._btn_returnMoney:isValidate()
  self._ui._applyMercenary._btn_cancelApply:isValidate()
  self._ui._applyMercenary._stc_dateOver:isValidate()
  self._ui._readyElfWar._btn_readyElfWarArea:isValidate()
  self._ui._readyElfWar._stc_title:isValidate()
  self._ui._readyElfWar._stc_date:isValidate()
  self._ui._readyElfWar._btn_campList:isValidate()
  self._ui._readyElfWar._btn_elfWarLive:isValidate()
  self._ui._readyElfWar._stc_dateOver:isValidate()
  self._ui._stc_bottomButtonArea:isValidate()
  self._ui._btn_elfWarReward:isValidate()
  self._ui._btn_elfWarRule:isValidate()
  self._ui._btn_elfWarHistory:isValidate()
  self._ui._btn_elfWarObserveMode:isValidate()
  self._ui._btn_elfWarTeamScoreBoard:isValidate()
end
function PaGlobal_ElfWarMenu:prepareOpen()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self:setElfWarObserveModeButton()
  self:onScreenResize()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_ElfWarMenu)
  self._renderMode:set()
  self:updateApplyTimeText()
  local elfWarState = ToClient_GetElfWarState()
  if self:isApplyGuildTime() == true then
    self:setMenuForApplyingGuild()
  elseif self:isApplyMercenaryTime() == true then
    self:setMenuForApplyingMercenary()
  elseif self:isElfWarReadyTime() == true then
    self:setMenuForReadyElfWar()
  end
  if _ContentsGroup_ElfWarPreSeason == true then
    self._ui._stc_preSeasonGuide:SetShow(true)
  else
    self._ui._stc_preSeasonGuide:SetShow(false)
  end
  self._ui._stc_mainBG:EraseAllEffect()
  self._ui._stc_mainBG:AddEffect("fUI_RoseWar_BackGround_01A", true, 0, 0)
  self:open()
end
function PaGlobal_ElfWarMenu:open()
  if Panel_ElfWar_Menu == nil then
    return
  end
  Panel_ElfWar_Menu:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_ElfWar_Menu:ComputePosAllChild()
  Panel_ElfWar_Menu:SetShow(true)
end
function PaGlobal_ElfWarMenu:prepareClose()
  if Panel_ElfWar_Menu == nil then
    return
  end
  TooltipSimple_Hide()
  SetUIMode(self._prevUIMode)
  self._prevUIMode = Defines.UIMode.eUIMode_Default
  self._renderMode:reset()
  self:close()
end
function PaGlobal_ElfWarMenu:close()
  if Panel_ElfWar_Menu == nil then
    return
  end
  if PaGlobalFunc_ElfWarEditParty_IsShow() == true then
    PaGlobalFunc_ElfWarEditParty_Close()
  end
  Panel_ElfWar_Menu:SetShow(false)
end
function PaGlobal_ElfWarMenu:setElfWarObserveModeButton()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local isShowButton = ToClient_IsHaveElfWarObserveAuthority()
  if isShowButton == true then
    if ToClient_IsElfWarObserveMode() == true then
      self._ui._btn_elfWarObserveMode:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAR_CORRESPONDENT_OFF"))
    else
      self._ui._btn_elfWarObserveMode:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WAR_CORRESPONDENT_ON"))
    end
    self._ui._btn_elfWarObserveMode:SetShow(true)
  else
    self._ui._btn_elfWarObserveMode:SetShow(false)
  end
end
function PaGlobal_ElfWarMenu:onScreenResize()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local panelSizeX = screenSizeX
  local panelSizeY = panelSizeX * 9 / 16
  if screenSizeY < panelSizeY then
    panelSizeY = screenSizeY
  end
  Panel_ElfWar_Menu:SetSize(screenSizeX, screenSizeY)
  self._ui._stc_dimmed:SetSize(screenSizeX, screenSizeY)
  Panel_ElfWar_Menu:ComputePos()
  local bottomButtonList = Array.new()
  bottomButtonList:push_back(self._ui._btn_elfWarReward)
  bottomButtonList:push_back(self._ui._btn_elfWarRule)
  bottomButtonList:push_back(self._ui._btn_elfWarTeamScoreBoard)
  bottomButtonList:push_back(self._ui._btn_elfWarHistory)
  bottomButtonList:push_back(self._ui._btn_elfWarObserveMode)
  local isCheckFirst = false
  for index = 1, bottomButtonList:length() do
    local button = bottomButtonList[index]
    if button ~= nil and button:GetShow() == true then
      if isCheckFirst == false then
        local spanX = self._ui._stc_bottomButtonArea:GetSizeX() / 2 - button:GetSizeX() / 2
        button:SetSpanSize(spanX, button:GetSpanSize().y)
        button:ComputePos()
        isCheckFirst = true
      else
        local spanX
        for innerIndex = 1, index - 1 do
          local innerButton = bottomButtonList[innerIndex]
          if innerButton ~= nil and innerButton:GetShow() == true then
            spanX = innerButton:GetSpanSize().x - innerButton:GetSizeX() / 2 - 10
            innerButton:SetSpanSize(spanX, innerButton:GetSpanSize().y)
            innerButton:ComputePos()
          end
        end
        if spanX ~= nil then
          button:SetSpanSize(spanX + button:GetSizeX() + 10, button:GetSpanSize().y)
          button:ComputePos()
        end
      end
    end
  end
end
function PaGlobal_ElfWarMenu:applyGuild()
  if Panel_ElfWar_Menu == nil then
    return
  end
  ToClient_ApplyElfWarByGuild()
end
function PaGlobal_ElfWarMenu:applyMercenary()
  if Panel_ElfWar_Menu == nil then
    return
  end
  ToClient_ApplyElfWarByMercenary()
end
local makeElfWarTimeString = function(begin_month, begin_day, begin_dow, begin_hour, begin_minute, end_month, end_day, end_dow, end_hour, end_minute)
  if begin_hour < 10 then
    begin_hour = "0" .. tostring(begin_hour)
  end
  if end_hour < 10 then
    end_hour = "0" .. tostring(end_hour)
  end
  if begin_minute < 10 then
    begin_minute = "0" .. tostring(begin_minute)
  end
  if end_minute < 10 then
    end_minute = "0" .. tostring(end_minute)
  end
  local rvString = ""
  local dayOfWeekString = {
    [__eEDayOfWeek_eSunday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SUNDAY"),
    [__eEDayOfWeek_eMonday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_MONDAY"),
    [__eEDayOfWeek_eTuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_TUESDAY"),
    [__eEDayOfWeek_eWednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_WEDNESDAY"),
    [__eEDayOfWeek_eThursday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_THURSDAY"),
    [__eEDayOfWeek_eFriday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_FRIDAY"),
    [__eEDayOfWeek_eSaturday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SATURDAY")
  }
  local beginTimeStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_TIME", "hour", begin_hour, "minute", begin_minute)
  local endTimeStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BOSSALERT_ALARM_TIME", "hour", end_hour, "minute", end_minute)
  rvString = PAGetStringParam8(Defines.StringSheet_GAME, "LUA_COMMON_DATE_MONTH_DAY_WEEK_TIME", "month1", tostring(begin_month), "day1", tostring(begin_day), "week1", tostring(dayOfWeekString[begin_dow]), "time1", beginTimeStr, "month2", tostring(end_month), "day2", tostring(end_day), "week2", tostring(dayOfWeekString[end_dow]), "time2", endTimeStr)
  return rvString
end
function PaGlobal_ElfWarMenu:updateApplyTimeText()
  if PaGlobal_ElfWarMenu == nil then
    return
  end
  local currentTime_s64 = getServerUtc64()
  local currentPATime = PATime(currentTime_s64)
  local guildApplyStartTime = ToClient_GetElfWarGuildApplyStartTime(currentTime_s64)
  local guildApplyStartTimeValue = PATime(guildApplyStartTime)
  local guildApplyEndTime = ToClient_GetElfWarGuildApplyEndTime(currentTime_s64)
  local guildApplyEndTimeValue = PATime(guildApplyEndTime)
  local guildApplyTimeText = makeElfWarTimeString(guildApplyStartTimeValue:GetMonth(), guildApplyStartTimeValue:GetDay(), guildApplyStartTimeValue:GetDayOfWeek(), guildApplyStartTimeValue:GetHour(), guildApplyStartTimeValue:GetMinute(), guildApplyEndTimeValue:GetMonth(), guildApplyEndTimeValue:GetDay(), guildApplyEndTimeValue:GetDayOfWeek(), guildApplyEndTimeValue:GetHour(), guildApplyEndTimeValue:GetMinute())
  local mercenaryApplyStartTime = ToClient_GetElfWarMercenaryApplyStartTime(currentTime_s64)
  local mercenaryApplyStartTimeValue = PATime(mercenaryApplyStartTime)
  local mercenaryApplyEndTime = ToClient_GetElfWarMercenaryApplyEndTime(currentTime_s64)
  local mercenaryApplyEndTimeValue = PATime(mercenaryApplyEndTime)
  local mercenaryApplyTimeText = makeElfWarTimeString(mercenaryApplyStartTimeValue:GetMonth(), mercenaryApplyStartTimeValue:GetDay(), mercenaryApplyStartTimeValue:GetDayOfWeek(), mercenaryApplyStartTimeValue:GetHour(), mercenaryApplyStartTimeValue:GetMinute(), mercenaryApplyEndTimeValue:GetMonth(), mercenaryApplyEndTimeValue:GetDay(), mercenaryApplyEndTimeValue:GetDayOfWeek(), mercenaryApplyEndTimeValue:GetHour(), mercenaryApplyEndTimeValue:GetMinute())
  local elfWarStartTime = ToClient_GetElfWarStartTime(currentTime_s64)
  local elfWarStartTimeValue = PATime(elfWarStartTime)
  local elfWarEndTime = ToClient_GetElfWarEndTime(currentTime_s64)
  local elfWarEndTimeValue = PATime(elfWarEndTime)
  local elfWarTimeText = makeElfWarTimeString(elfWarStartTimeValue:GetMonth(), elfWarStartTimeValue:GetDay(), elfWarStartTimeValue:GetDayOfWeek(), elfWarStartTimeValue:GetHour(), elfWarStartTimeValue:GetMinute(), elfWarEndTimeValue:GetMonth(), elfWarEndTimeValue:GetDay(), elfWarEndTimeValue:GetDayOfWeek(), elfWarEndTimeValue:GetHour(), elfWarEndTimeValue:GetMinute())
  self._ui._applyGuild._stc_date:SetText(guildApplyTimeText)
  self._ui._applyGuild._stc_date:SetSize(self._ui._applyGuild._stc_date:GetTextSizeX(), self._ui._applyGuild._stc_date:GetSizeY())
  self._ui._applyGuild._stc_date:ComputePos()
  self._ui._applyMercenary._stc_date:SetText(mercenaryApplyTimeText)
  self._ui._applyMercenary._stc_date:SetSize(self._ui._applyMercenary._stc_date:GetTextSizeX(), self._ui._applyMercenary._stc_date:GetSizeY())
  self._ui._applyMercenary._stc_date:ComputePos()
  self._ui._readyElfWar._stc_date:SetText(elfWarTimeText)
  self._ui._readyElfWar._stc_date:SetSize(self._ui._readyElfWar._stc_date:GetTextSizeX(), self._ui._readyElfWar._stc_date:GetSizeY())
  self._ui._readyElfWar._stc_date:ComputePos()
end
function PaGlobal_ElfWarMenu:isApplyGuildTime()
  if Panel_ElfWar_Menu == nil then
    return false
  end
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState < __eElfWar_MercenaryApplying or elfWarState > __eElfWar_Start then
    return true
  end
  return false
end
function PaGlobal_ElfWarMenu:isApplyMercenaryTime()
  if Panel_ElfWar_Menu == nil then
    return false
  end
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState > __eElfWar_GuildStopApplying and elfWarState < __eElfWar_PreStart then
    return true
  end
  return false
end
function PaGlobal_ElfWarMenu:isElfWarReadyTime()
  if Panel_ElfWar_Menu == nil then
    return false
  end
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState > __eElfWar_MercenaryStopApplying and elfWarState < __eElfWar_Stop then
    return true
  end
  return false
end
function PaGlobal_ElfWarMenu:isElfWarPlaying()
  if Panel_ElfWar_Menu == nil then
    return false
  end
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState == __eElfWar_Start then
    return true
  end
  return false
end
function PaGlobal_ElfWarMenu:setMenuForDefault()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self._ui._btn_appoint:SetShow(false)
  self._ui._applyGuild._btn_applyGuildArea:SetCheck(false)
  self._ui._applyMercenary._btn_applyMercenaryArea:SetCheck(false)
  self._ui._readyElfWar._btn_readyElfWarArea:SetCheck(false)
  self._ui._stc_symbolGuildChoice:SetShow(false)
  self._ui._stc_symbolMercenaryChoice:SetShow(false)
  self._ui._stc_symbolElfWar:SetShow(false)
  self._ui._stc_leaderBox:SetShow(false)
  self._ui._stc_symbolSword:EraseAllEffect()
  self._ui._stc_symbolGuildChoice:EraseAllEffect()
  self._ui._stc_symbolMercenaryChoice:EraseAllEffect()
  self._ui._stc_symbolElfWar:EraseAllEffect()
  self._ui._stc_mainDesc:SetSpanSize(0, 470)
  self:setBottomGuildApplyingMenu()
  self:setBottomMercenaryApplyingMenu()
  self:setBottomReadyElfWarMenu()
end
function PaGlobal_ElfWarMenu:setMenuForApplyingGuild()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self._selectedMenuIndex = self._applyGuildMenu
  self:setMenuForDefault()
  self._ui._stc_mainBG:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Request_MainBG_1")
  self._ui._applyGuild._btn_applyGuildArea:SetCheck(true)
  local defaultDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_1")
  self._ui._stc_mainDesc:SetText(defaultDesc)
  self._ui._stc_symbolGuildChoice:SetShow(true)
  self._ui._stc_symbolSword:SetShow(false)
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState > __eElfWar_GuildApplying and elfWarState < __eElfWar_Stop then
    self._ui._stc_symbolGuildChoice:SetShow(false)
    self._ui._stc_leaderBox:SetShow(true)
    self._ui._stc_leaderBoxKamaGuildName:SetText(ToClient_GetElfWarGuildName(__eElfWarTeam_Kamasylvia))
    self._ui._stc_leaderBoxKamaGuildName:SetShow(true)
    self._ui._stc_leaderBoxOdilGuildName:SetText(ToClient_GetElfWarGuildName(__eElfWarTeam_Odyllita))
    self._ui._stc_leaderBoxOdilGuildName:SetShow(true)
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return
    end
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isAlliance = selfPlayer:get():isGuildAllianceMember()
    local isAllianceChair = selfPlayer:get():isGuildAllianceChair()
    if ToClient_IsParticipateGuildInElfWar(__eElfWarTeam_Kamasylvia) == true then
      self._ui._stc_kamasylviaCamp:SetFontColor(Defines.Color.C_FF438DCC)
      self._ui._stc_odyllitaCamp:SetFontColor(Defines.Color.C_FFD05D48)
      if (isAlliance == false and isGuildMaster == true or isAlliance == true and isAllianceChair == true) and ToClient_IsElfWarCommanderAppointed() == false and elfWarState < __eElfWar_PreStart then
        local spanSize = self._ui._stc_mainDesc:GetSpanSize()
        self._ui._stc_mainDesc:SetSpanSize(spanSize.x, 520)
        self._ui._btn_appoint:SetShow(true)
      end
    elseif ToClient_IsParticipateGuildInElfWar(__eElfWarTeam_Odyllita) == true then
      self._ui._stc_kamasylviaCamp:SetFontColor(Defines.Color.C_FFD05D48)
      self._ui._stc_odyllitaCamp:SetFontColor(Defines.Color.C_FF438DCC)
      if (isAlliance == false and isGuildMaster == true or isAlliance == true and isAllianceChair == true) and ToClient_IsElfWarCommanderAppointed() == false and elfWarState < __eElfWar_PreStart then
        local spanSize = self._ui._stc_mainDesc:GetSpanSize()
        self._ui._stc_mainDesc:SetSpanSize(spanSize.x, 520)
        self._ui._btn_appoint:SetShow(true)
      end
    end
    if elfWarState > __eElfWar_MercenaryApplying then
      self._ui._stc_mainBG:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Request_MainBG_2")
    end
  elseif elfWarState == __eElfWar_GuildApplying then
    if ToClient_IsApplyElfWar() == true then
      self._ui._stc_symbolSword:SetShow(true)
      self._ui._stc_symbolSword:AddEffect("fUI_RoseWar_Amulet_03A", false, 0, 0)
      self._ui._stc_symbolGuildChoice:AddEffect("fUI_RoseWar_Amulet_02B", false, 0, 0)
      self._ui._stc_symbolGuildChoice:AddEffect("fUI_RoseWar_Amulet_01A", true, 0, 0)
    else
      self._ui._stc_symbolGuildChoice:AddEffect("fUI_RoseWar_Amulet_01A", true, 0, 0)
    end
  end
end
function PaGlobal_ElfWarMenu:setMenuForApplyingMercenary()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  self._selectedMenuIndex = self._applyMercenaryMenu
  self:setMenuForDefault()
  self._ui._stc_mainBG:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Request_MainBG_3")
  self._ui._applyMercenary._btn_applyMercenaryArea:SetCheck(true)
  self._ui._stc_symbolMercenaryChoice:SetShow(true)
  local elfWarState = ToClient_GetElfWarState()
  local defaultDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_2_1")
  self._ui._stc_mainDesc:SetText(defaultDesc)
  if elfWarState == __eElfWar_MercenaryApplying then
    if selfPlayerTeamNo == __eElfWarTeam_Kamasylvia or selfPlayerTeamNo == __eElfWarTeam_Odyllita then
      return
    end
    local isParticipateInElfWar = ToClient_IsParticipateGuildInElfWar(0) or ToClient_IsParticipateGuildInElfWar(1)
    if isParticipateInElfWar == true then
      return
    end
    local isAlreadyApplied = ToClient_IsApplyElfWar()
    if isAlreadyApplied == true then
      self._ui._stc_symbolMercenaryChoice:AddEffect("fUI_RoseWar_Amulet_02A", true, 0, 0)
    end
  end
  if elfWarState == __eElfWar_Start then
    local defaultDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_2_2")
    self._ui._stc_mainDesc:SetText(defaultDesc)
  end
end
function PaGlobal_ElfWarMenu:setMenuForReadyElfWar()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  self._selectedMenuIndex = self._readyElfWarMenu
  self:setMenuForDefault()
  local defaultDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_1")
  self._ui._stc_mainDesc:SetText(defaultDesc)
  self._ui._stc_mainBG:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Request_MainBG_4")
  self._ui._readyElfWar._btn_readyElfWarArea:SetCheck(true)
  self._ui._stc_symbolElfWar:SetShow(true)
  local elfWarState = ToClient_GetElfWarState()
  if elfWarState == __eElfWar_PreStart then
    self._ui._stc_symbolElfWar:AddEffect("fUI_RoseWar_Amulet_01B", true, 0, 0)
    self._ui._stc_symbolElfWar:AddEffect("UI_RoseWar_Wing_01B", true, 0, 0)
  elseif elfWarState == __eElfWar_Start then
    self._ui._stc_symbolElfWar:AddEffect("fUI_RoseWar_Amulet_01B", true, 0, 0)
    self._ui._stc_symbolElfWar:AddEffect("UI_RoseWar_Wing_01A", true, 0, 0)
    local desc = ""
    if selfPlayerTeamNo == __eElfWarTeam_Kamasylvia or selfPlayerTeamNo == __eElfWarTeam_Odyllita then
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_3_1")
    else
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_DESC_3_2")
    end
    self._ui._stc_mainDesc:SetText(desc)
  end
end
function PaGlobal_ElfWarMenu:setBottomGuildApplyingMenu()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  local elfWarState = ToClient_GetElfWarState()
  local nowApplying = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_APPLY_STEP1")
  self._ui._applyGuild._stc_title:SetText(nowApplying)
  self._ui._applyGuild._stc_title:SetShow(false)
  self._ui._applyGuild._stc_date:SetShow(false)
  self._ui._applyGuild._btn_applyGuild:SetShow(false)
  self._ui._applyGuild._btn_cancelApply:SetShow(false)
  self._ui._applyGuild._stc_dateOver:SetShow(false)
  self._ui._applyGuild._stc_leaderBox:SetShow(false)
  self._ui._applyGuild._btn_returnMoney:SetShow(false)
  self._ui._applyGuild._stc_unAppointCommander:SetShow(false)
  if selfPlayer == nil then
    return
  end
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  local isAlliance = selfPlayer:get():isGuildAllianceMember()
  local isAllianceChair = selfPlayer:get():isGuildAllianceChair()
  local isLeaderGuildMaster = isAlliance == false and isGuildMaster == true or isAlliance == true and isAllianceChair == true
  if selfPlayer:getCanReturnElfWarMoneyForGuild() == true then
    self._ui._applyGuild._stc_title:SetShow(true)
    self._ui._applyGuild._stc_date:SetShow(true)
    self._ui._applyGuild._btn_returnMoney:SetShow(true)
    return
  end
  if elfWarState == __eElfWar_GuildApplying or elfwarState == __eElfWar_GuildStopApplying then
    self._ui._applyGuild._stc_title:SetShow(true)
    self._ui._applyGuild._stc_date:SetShow(true)
    self._ui._applyGuild._stc_dateOver:SetShow(false)
    if isLeaderGuildMaster == true then
      local isAlreadyApplied = ToClient_IsApplyElfWar()
      if isAlreadyApplied == true then
        self._ui._applyGuild._btn_applyGuild:SetShow(false)
        self._ui._applyGuild._btn_cancelApply:SetShow(true)
      else
        self._ui._applyGuild._btn_applyGuild:SetShow(true)
        self._ui._applyGuild._btn_cancelApply:SetShow(false)
      end
    else
      local cantApply = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_APPLY_NOADMIN")
      self._ui._applyGuild._stc_dateOver:SetText(cantApply)
      self._ui._applyGuild._stc_dateOver:SetShow(true)
    end
    return
  end
  if elfWarState < __eElfWar_Stop then
    local isParticipantForKama = ToClient_IsParticipateGuildInElfWar(__eElfWarTeam_Kamasylvia)
    local isParticipantForOdil = ToClient_IsParticipateGuildInElfWar(__eElfWarTeam_Odyllita)
    local isParticipantInElfWar = isParticipantForKama == true or isParticipantForOdil == true
    local applyingDone = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_STEP1")
    self._ui._applyGuild._stc_title:SetText(applyingDone)
    self._ui._applyGuild._stc_leaderBox:SetShow(true)
    self._ui._applyGuild._stc_kamaCommander:SetText(ToClient_GetElfWarGuildName(__eElfWarTeam_Kamasylvia))
    self._ui._applyGuild._stc_odilCommander:SetText(ToClient_GetElfWarGuildName(__eElfWarTeam_Odyllita))
    if isParticipantInElfWar == true and isLeaderGuildMaster == true and ToClient_IsElfWarCommanderAppointed() == false and elfWarState < __eElfWar_PreStart then
      self._ui._applyGuild._stc_unAppointCommander:SetShow(true)
    end
    if isParticipantForKama == true then
      self._ui._applyGuild._stc_kama:SetFontColor(Defines.Color.C_FF438DCC)
      self._ui._applyGuild._stc_odil:SetFontColor(Defines.Color.C_FFD05D48)
    elseif isParticipantForOdil == true then
      self._ui._applyGuild._stc_kama:SetFontColor(Defines.Color.C_FFD05D48)
      self._ui._applyGuild._stc_odil:SetFontColor(Defines.Color.C_FF438DCC)
    end
    return
  end
  local notPeriod = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_NOTPERIOD")
  self._ui._applyGuild._stc_title:SetShow(true)
  self._ui._applyGuild._stc_date:SetShow(true)
  self._ui._applyGuild._stc_dateOver:SetText(notPeriod)
  self._ui._applyGuild._stc_dateOver:SetShow(true)
end
function PaGlobal_ElfWarMenu:setBottomMercenaryApplyingMenu()
  if Panel_ElfWar_Menu == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local elfWarState = ToClient_GetElfWarState()
  local selfPlayerTeamNo = selfPlayer:getElfWarTeamNo()
  local nowApplying = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_APPLY_STEP2")
  self._ui._applyMercenary._stc_title:SetText(nowApplying)
  self._ui._applyMercenary._stc_title:SetShow(true)
  self._ui._applyMercenary._stc_date:SetShow(true)
  self._ui._applyMercenary._btn_applyMercenary:SetShow(false)
  self._ui._applyMercenary._btn_returnMoney:SetShow(false)
  self._ui._applyMercenary._btn_cancelApply:SetShow(false)
  self._ui._applyMercenary._stc_dateOver:SetShow(false)
  self._ui._applyMercenary._stc_campKama:SetShow(false)
  self._ui._applyMercenary._stc_campOdil:SetShow(false)
  if selfPlayer:getCanReturnElfWarMoneyForMercenary() == true then
    self._ui._applyMercenary._stc_title:SetShow(true)
    self._ui._applyMercenary._stc_date:SetShow(true)
    self._ui._applyMercenary._btn_returnMoney:SetShow(true)
    return
  end
  if elfWarState == __eElfWar_MercenaryApplying or elfwarState == __eElfWar_MercenaryStopApplying then
    if selfPlayerTeamNo == __eElfWarTeam_Kamasylvia or selfPlayerTeamNo == __eElfWarTeam_Odyllita then
      self._ui._applyMercenary._btn_applyMercenary:SetShow(false)
      self._ui._applyMercenary._btn_cancelApply:SetShow(false)
      local recruit = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_RECRUIT")
      self._ui._applyMercenary._stc_dateOver:SetText(recruit)
      self._ui._applyMercenary._stc_dateOver:SetShow(true)
      return
    end
    local isParticipateInElfWar = ToClient_IsParticipateGuildInElfWar(0) or ToClient_IsParticipateGuildInElfWar(1)
    if isParticipateInElfWar == true then
      self._ui._applyMercenary._btn_applyMercenary:SetShow(false)
      self._ui._applyMercenary._btn_cancelApply:SetShow(false)
      local recruit = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_RECRUIT")
      self._ui._applyMercenary._stc_dateOver:SetText(recruit)
      self._ui._applyMercenary._stc_dateOver:SetShow(true)
      return
    end
    local isAlreadyApplied = ToClient_IsApplyElfWar()
    if isAlreadyApplied == true then
      self._ui._applyMercenary._btn_applyMercenary:SetShow(false)
      self._ui._applyMercenary._btn_cancelApply:SetShow(true)
    else
      self._ui._applyMercenary._btn_applyMercenary:SetShow(true)
      self._ui._applyMercenary._btn_cancelApply:SetShow(false)
    end
    return
  end
  if elfWarState >= __eElfWar_MercenaryStopApplying and elfWarState < __eElfWar_Stop then
    local applyingDone = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_STEP2")
    self._ui._applyMercenary._stc_title:SetText(applyingDone)
    if selfPlayerTeamNo == __eElfWarTeam_Kamasylvia then
      self._ui._applyMercenary._stc_date:SetShow(false)
      self._ui._applyMercenary._stc_campKama:SetShow(true)
    elseif selfPlayerTeamNo == __eElfWarTeam_Odyllita then
      self._ui._applyMercenary._stc_date:SetShow(false)
      self._ui._applyMercenary._stc_campOdil:SetShow(true)
    else
      local cantApply = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_LIST_BTN_ENDTOSIEGEPARTICIPANT")
      self._ui._applyMercenary._stc_dateOver:SetText(cantApply)
      self._ui._applyMercenary._stc_dateOver:SetShow(true)
    end
    return
  end
  local notPeriod = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_NOTPERIOD")
  self._ui._applyMercenary._stc_dateOver:SetText(notPeriod)
  self._ui._applyMercenary._stc_dateOver:SetShow(true)
end
function PaGlobal_ElfWarMenu:setBottomReadyElfWarMenu()
  if Panel_ElfWar_Menu == nil then
    return
  end
  self._ui._readyElfWar._btn_elfWarLive:SetShow(false)
  self._ui._readyElfWar._btn_campList:SetShow(false)
  self._ui._readyElfWar._stc_dateOver:SetShow(false)
  local elfWarState = ToClient_GetElfWarState()
  local selfPlayer = getSelfPlayer()
  local elfWarTeamNo = selfPlayer:getElfWarTeamNo()
  local warReady = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_APPLY_STEP3")
  self._ui._readyElfWar._stc_title:SetText(warReady)
  if elfWarState > __eElfWar_MercenaryStopApplying and elfWarState < __eElfWar_Stop then
    if elfWarTeamNo == Defines.ElfWarTeamNo.KAMASYLVIA or elfWarTeamNo == Defines.ElfWarTeamNo.ODYLLITA then
      self._ui._readyElfWar._btn_campList:SetShow(true)
    else
      self._ui._readyElfWar._stc_dateOver:SetShow(true)
    end
    if elfWarState == __eElfWar_Start then
      local warStart = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_STEP3")
      self._ui._readyElfWar._stc_title:SetText(warStart)
    end
  else
    self._ui._readyElfWar._stc_dateOver:SetShow(true)
  end
end
