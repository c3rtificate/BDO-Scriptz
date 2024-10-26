function PaGlobal_GuildMatch:initialize()
  if self._initialize == true then
    return
  end
  self._ui._txt_record = UI.getChildControl(Panel_GuildMatch_All, "StaticText_Record")
  self._ui._txt_rankPoint = UI.getChildControl(Panel_GuildMatch_All, "StaticText_Point")
  self._ui._txt_mainState = UI.getChildControl(Panel_GuildMatch_All, "StaticText_State")
  self._ui._txt_subState = UI.getChildControl(Panel_GuildMatch_All, "StaticText_State_SubDesc")
  self._ui._btn_gameRecord = UI.getChildControl(Panel_GuildMatch_All, "Button_Record")
  self._ui._btn_gameRanking = UI.getChildControl(Panel_GuildMatch_All, "Button_Ranking")
  self._ui._btn_join = UI.getChildControl(Panel_GuildMatch_All, "Button_Reservation")
  self._ui._btn_enter = UI.getChildControl(Panel_GuildMatch_All, "Button_Enterance")
  self._ui._btn_exit = UI.getChildControl(Panel_GuildMatch_All, "Button_Quit")
  self._ui._stc_rewardIcon = UI.getChildControl(Panel_GuildMatch_All, "StaticText_RewardIcon")
  self._ui._stc_tooltipBg = UI.getChildControl(Panel_GuildMatch_All, "Static_ToolTipBg")
  local blueBg = UI.getChildControl(Panel_GuildMatch_All, "Static_BlueFlag")
  local myGuildBg = UI.getChildControl(blueBg, "Static_MyGuildMarkBG")
  self._ui._stc_myGuildMark = UI.getChildControl(myGuildBg, "Static_GuildMark")
  self._ui._txt_myGuildName = UI.getChildControl(myGuildBg, "StaticText_GuildName")
  local redBg = UI.getChildControl(Panel_GuildMatch_All, "Static_RedFlag")
  local enemyGuildBg = UI.getChildControl(redBg, "Static_OpponentGuildMarkBG")
  self._ui._stc_enemyGuildMark = UI.getChildControl(enemyGuildBg, "Static_GuildMark")
  self._ui._txt_enemyGuildName = UI.getChildControl(enemyGuildBg, "StaticText_GuildName")
  self._ui._stc_penalty = UI.getChildControl(self._ui._btn_join, "StaticText_PenaltyIcon")
  self._ui._frm_desc = UI.getChildControl(Panel_GuildMatch_All, "Frame_Desc")
  self:initialize_rewardTooltip()
  self:initialize_descFrame()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildMatch:registEventHandler()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._btn_gameRecord:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleGameRecord()")
  self._ui._btn_gameRanking:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleGameRanking()")
  self._ui._btn_join:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_JoinMatch()")
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_EnterInstanceField()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatch_LeaveInstanceField()")
  self._ui._stc_rewardIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatch_ToggleRewardTooltip()")
  self._ui._stc_penalty:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_ShowPenaltyToolTip(true)")
  self._ui._stc_penalty:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_ShowPenaltyToolTip(false)")
  registerEvent("FromClient_RefreshParticipatedCount", "FromClient_RefreshParticipatedCount")
  registerEvent("FromClient_RefreshGuildMatchRecordText", "FromClient_RefreshGuildMatchRecordText")
  registerEvent("FromClient_RefreshGuildMatchButtonUI", "FromClient_RefreshGuildMatchButtonUI")
  registerEvent("FromClient_UpdateGuildMatchRecord", "FromClient_UpdateGuildMatchRecord")
  registerEvent("FromClient_LoadCompleteGuildMatchRankInfo", "FromClient_LoadCompleteGuildMatchRankInfo")
end
function PaGlobal_GuildMatch:prepareOpen()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._frm_desc:GetVScroll():SetControlPos(0)
  self._ui._frm_desc:UpdateContentPos()
  self:requestGuildMatchRoomList()
  self:requestUpdateServerData()
  self:updateStateText()
  self:updateButtonShowState()
  self:updateMyGuildInfo()
  self:updateEnemyGuildInfo()
  self:hideRewardTooltip()
  self:open()
end
function PaGlobal_GuildMatch:open()
  if Panel_GuildMatch_All == nil then
    return
  end
  Panel_GuildMatch_All:SetShow(true)
end
function PaGlobal_GuildMatch:validate()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._txt_record:isValidate()
  self._ui._txt_rankPoint:isValidate()
  self._ui._btn_gameRecord:isValidate()
  self._ui._btn_gameRanking:isValidate()
  self._ui._btn_join:isValidate()
  self._ui._btn_enter:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._stc_rewardIcon:isValidate()
  self._ui._stc_tooltipBg:isValidate()
  self._ui._frm_desc:isValidate()
end
function PaGlobal_GuildMatch:initialize_rewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  local stc_rewardDesc = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_Desc")
  local bgSizeX = 0
  local bgSizeY = 0
  stc_rewardDesc:SetSize(stc_rewardDesc:GetSizeX(), stc_rewardDesc:GetTextSizeY())
  stc_rewardDesc:ComputePos()
  local winnerTeamplate = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Template1")
  local winnerItemName = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_ItemName1")
  local winnerRewardItemCount = ToClient_GetGuildMatchVictoryRewardCount()
  local winnerRewardValidCount = 0
  local showWinnerItemName = winnerRewardItemCount == 1
  for index = 0, winnerRewardItemCount - 1 do
    local rewardItemKey = ToClient_GetGuildMatchVictoryRewardItemKey(index)
    local itemCount_s64 = ToClient_GetGuildMatchVictoryRewardItemCount(index)
    local winnerRewardItemBg = UI.cloneControl(winnerTeamplate, self._ui._stc_tooltipBg, "Static_SlotBg_Winner_" .. tostring(index))
    local winnerRewardItemSlot = {}
    SlotItem.new(winnerRewardItemSlot, "RewardIcon", 0, winnerRewardItemBg, self._slotConfig)
    winnerRewardItemSlot:createChild()
    winnerRewardItemSlot:clearItem()
    winnerRewardItemSlot.icon:SetPosX(0)
    winnerRewardItemSlot.icon:SetPosY(0)
    winnerRewardItemSlot.icon:SetSize(44, 44)
    winnerRewardItemSlot.icon:SetHorizonLeft()
    winnerRewardItemSlot.icon:SetVerticalTop()
    local itemSSW = getItemEnchantStaticStatus(rewardItemKey)
    if itemSSW ~= nil then
      winnerRewardItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, nil)
      winnerRewardItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_RewardItem(true, true, " .. tostring(index) .. ")")
      winnerRewardItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_RewardItem(true, false, " .. tostring(index) .. ")")
      winnerRewardItemBg:SetShow(true)
      winnerRewardItemBg:SetSpanSize(10 * (winnerRewardValidCount + 1) + winnerRewardValidCount * 44, winnerRewardItemBg:GetSpanSize().y)
      winnerRewardItemBg:ComputePos()
      winnerRewardValidCount = winnerRewardValidCount + 1
    else
      winnerRewardItemBg:SetShow(false)
    end
    if showWinnerItemName == true then
      winnerItemName:SetText(itemSSW:getName() .. " x " .. tostring(itemCount_s64))
      winnerItemName:SetSize(winnerItemName:GetTextSizeX(), winnerItemName:GetSizeY())
      winnerItemName:ComputePos()
      winnerItemName:SetShow(true)
    else
      winnerItemName:SetShow(false)
    end
  end
  local loserTeamplate = UI.getChildControl(self._ui._stc_tooltipBg, "Static_SlotBg_Template2")
  local loserItemName = UI.getChildControl(self._ui._stc_tooltipBg, "StaticText_ItemName2")
  local loserRewardItemCount = ToClient_GetGuildMatchDepeatRewardCount()
  local loserRewardValidCount = 0
  local showLoserItemName = loserRewardItemCount == 1
  for index = 0, loserRewardItemCount - 1 do
    local rewardItemKey = ToClient_GetGuildMatchDepeatRewardItemKey(index)
    local itemCount_s64 = ToClient_GetGuildMatchDepeatRewardItemCount(index)
    local loserRewardItemBg = UI.cloneControl(loserTeamplate, self._ui._stc_tooltipBg, "Static_SlotBg_Loser_" .. tostring(index))
    local loserRewardItemSlot = {}
    SlotItem.new(loserRewardItemSlot, "RewardIcon", 0, loserRewardItemBg, self._slotConfig)
    loserRewardItemSlot:createChild()
    loserRewardItemSlot:clearItem()
    loserRewardItemSlot.icon:SetPosX(0)
    loserRewardItemSlot.icon:SetPosY(0)
    loserRewardItemSlot.icon:SetSize(44, 44)
    loserRewardItemSlot.icon:SetHorizonLeft()
    loserRewardItemSlot.icon:SetVerticalTop()
    local itemSSW = getItemEnchantStaticStatus(rewardItemKey)
    if itemSSW ~= nil then
      loserRewardItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true, nil)
      loserRewardItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildMatch_RewardItem(false, true, " .. tostring(index) .. ")")
      loserRewardItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildMatch_RewardItem(false, false, " .. tostring(index) .. ")")
      loserRewardItemBg:SetShow(true)
      loserRewardItemBg:SetSpanSize(10 * (loserRewardValidCount + 1) + loserRewardValidCount * 44, loserRewardItemBg:GetSpanSize().y)
      loserRewardItemBg:ComputePos()
      loserRewardValidCount = loserRewardValidCount + 1
    else
      loserRewardItemBg:SetShow(false)
    end
    if showLoserItemName == true then
      loserItemName:SetText(itemSSW:getName() .. " x " .. tostring(itemCount_s64))
      loserItemName:SetSize(loserItemName:GetTextSizeX(), loserItemName:GetSizeY())
      loserItemName:ComputePos()
      loserItemName:SetShow(true)
    else
      loserItemName:SetShow(false)
    end
  end
  local rewardCountMax = math.max(winnerRewardValidCount, loserRewardValidCount)
  bgSizeX = winnerTeamplate:GetSizeX() * rewardCountMax + winnerTeamplate:GetSpanSize().x * (rewardCountMax + 1)
  bgSizeX = math.max(bgSizeX, stc_rewardDesc:GetSpanSize().x * 2 + stc_rewardDesc:GetSizeX())
  if showWinnerItemName == true then
    bgSizeX = math.max(bgSizeX, winnerItemName:GetSpanSize().x * 2 + winnerItemName:GetSizeX())
  end
  if showLoserItemName == true then
    bgSizeX = math.max(bgSizeX, loserItemName:GetSpanSize().x * 2 + loserItemName:GetSizeX())
  end
  bgSizeY = stc_rewardDesc:GetSpanSize().y + stc_rewardDesc:GetSizeY() + 10
  self._ui._stc_tooltipBg:SetSize(bgSizeX, bgSizeY)
  self._ui._stc_tooltipBg:SetSpanSize((self._ui._stc_tooltipBg:GetSizeX() + 10) * -1, self._ui._stc_tooltipBg:GetSpanSize().y)
  self._ui._stc_tooltipBg:ComputePos()
end
function PaGlobal_GuildMatch:initialize_descFrame()
  if Panel_GuildMatch_All == nil then
    return
  end
  local frameContent = UI.getChildControl(self._ui._frm_desc, "Frame_1_Content")
  local txt_title_1 = UI.getChildControl(frameContent, "StaticText_Title_1")
  local txt_desc_1 = UI.getChildControl(frameContent, "StaticText_Desc_1")
  local txt_title_2 = UI.getChildControl(frameContent, "StaticText_Title_2")
  local txt_desc_2 = UI.getChildControl(frameContent, "StaticText_Desc_2")
  local txt_desc_3 = UI.getChildControl(frameContent, "StaticText_Desc_3")
  local txt_desc_4 = UI.getChildControl(frameContent, "StaticText_Desc_4")
  local txt_desc_5 = UI.getChildControl(frameContent, "StaticText_Desc_5")
  local txt_desc_6 = UI.getChildControl(frameContent, "StaticText_Desc_6")
  local txt_desc_7 = UI.getChildControl(frameContent, "StaticText_Desc_7")
  local txtArray = Array.new()
  txtArray:push_back(txt_title_1)
  txtArray:push_back(txt_desc_1)
  txtArray:push_back(txt_title_2)
  txtArray:push_back(txt_desc_2)
  txtArray:push_back(txt_desc_3)
  txtArray:push_back(txt_desc_4)
  txtArray:push_back(txt_desc_5)
  txtArray:push_back(txt_desc_6)
  txtArray:push_back(txt_desc_7)
  local spanY = 0
  local frameSizeY = 0
  for key, value in pairs(txtArray) do
    if value ~= nil then
      value:SetSpanSize(value:GetSpanSize().x, spanY)
      value:SetSize(value:GetSizeX(), value:GetTextSizeY())
      value:ComputePos()
      spanY = value:GetSpanSize().y + value:GetSizeY()
    end
  end
  frameContent:SetSize(frameContent:GetSizeX(), spanY)
end
function PaGlobal_GuildMatch:showRewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._stc_tooltipBg:SetShow(true)
end
function PaGlobal_GuildMatch:hideRewardTooltip()
  if Panel_GuildMatch_All == nil then
    return
  end
  self._ui._stc_tooltipBg:SetShow(false)
end
function PaGlobal_GuildMatch:updateButtonShowState()
  if Panel_GuildMatch_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfPlayerProxy = selfPlayer:get()
  if selfPlayerProxy == nil then
    return
  end
  local isHaveGuildMatchAuthority = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isHaveGuildMatchAuthority = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_GuildDuel)
  else
    local isGuildMemberGrade_Master = selfPlayerProxy:isGuildMaster()
    local isGuildMemberGrade_SubMaster = selfPlayerProxy:isGuildSubMaster()
    local isGuildMemberGrade_Adviser = selfPlayerProxy:isGuildAdviser()
    local isGuildMemberGrade_ChiefOfStaff = selfPlayerProxy:isGuildChiefOfStaff()
    local isGuildMemberGrade_Scribe = selfPlayerProxy:isGuildScribe()
    isHaveGuildMatchAuthority = isGuildMemberGrade_Master == true or isGuildMemberGrade_SubMaster == true or isGuildMemberGrade_Adviser == true or isGuildMemberGrade_ChiefOfStaff == true or isGuildMemberGrade_Scribe == true
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true then
    self._ui._btn_join:SetShow(false)
    self._ui._btn_enter:SetShow(false)
    self._ui._btn_exit:SetShow(true)
  elseif ToClient_IsGuildMatchPlaying() == true then
    self._ui._btn_join:SetShow(false)
    self._ui._btn_enter:SetShow(true)
    self._ui._btn_exit:SetShow(false)
  else
    self._ui._btn_enter:SetShow(false)
    self._ui._btn_exit:SetShow(false)
    if isHaveGuildMatchAuthority == true then
      local state = ToClient_GetGuildMachPlayState()
      if state == __eGuildMatchPlayState_None then
        self._ui._btn_join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_REQUESTMATCH_BTN"))
        self._ui._btn_join:SetShow(true)
      elseif state == __eGuildMatchPlayState_Join then
        self._ui._btn_join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_CANCELMATCH_BTN"))
        self._ui._btn_join:SetShow(true)
      else
        self._ui._btn_join:SetShow(false)
      end
    else
      self._ui._btn_join:SetShow(false)
    end
  end
end
function PaGlobal_GuildMatch:requestUpdateServerData()
  if Panel_GuildMatch_All == nil then
    return
  end
  local currentTickCount = getTickCount32()
  if self._serverDataUpdateTimeSec * 1000 < currentTickCount - self._lastRequestServerTickCount then
    ToClient_RequestUpdateGuildMatchRecordFromServer()
    ToClient_RequestUpdateGuildMatchPersonalRecordFromServer()
    self._lastRequestServerTickCount = currentTickCount
  end
end
function PaGlobal_GuildMatch:updateStateText()
  if Panel_GuildMatch_All == nil then
    return
  end
  local state = ToClient_GetGuildMachPlayState()
  local mainStateString, subStateString
  if _ContentsGroup_GuildMatchSeason == false then
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_6")
    subStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_DESC_10")
  elseif self._isAppliedPenalty == true then
    local leftTimeString = ""
    local currentTime_s64 = getUtc64()
    local remainTimeSecond = Int64toInt32(self._penaltyTime - currentTime_s64)
    local oneDay = 86400
    local oneHour = 3600
    local oneMinute = 60
    local day = math.floor(remainTimeSecond / oneDay)
    if day <= 0 then
      day = 0
    end
    remainTimeSecond = remainTimeSecond - day * oneDay
    local hour = math.floor(remainTimeSecond / oneHour)
    if hour <= 0 then
      hour = 0
    end
    remainTimeSecond = remainTimeSecond - hour * oneHour
    local min = math.floor(remainTimeSecond / oneMinute)
    if min <= 0 then
      min = 0
    end
    remainTimeSecond = remainTimeSecond - min * oneMinute
    local sec = math.floor(remainTimeSecond)
    if sec <= 0 then
      sec = 0
    end
    if day > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_AGREEMENT_MASTER_DAY", "day", day) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", hour)
    elseif hour > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", hour) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", min)
    elseif min > 0 then
      leftTimeString = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", min)
    elseif sec > 0 then
      leftTimeString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_UNDER_ONEMINUTE")
    else
      UI.ASSERT_NAME(false, "\234\184\184\235\147\156 \234\178\176\236\160\132 \237\142\152\235\132\144\237\139\176 \236\162\133\235\163\140\234\185\140\236\167\128 \235\130\168\236\157\128\236\139\156\234\176\132\236\157\180 \236\157\180\236\131\129\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_5")
    subStateString = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_3", "leftTime", leftTimeString)
  elseif state == __eGuildMatchPlayState_None or state == __eGuildMatchPlayState_Join then
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_4")
    subStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_1")
  elseif state == __eGuildMatchPlayState_Play then
    local currentEnterCount = ToClient_GetGuildMatchParticipatedCount()
    local maxEnterCount = ToClient_GetGuildMatchParticipatedMaxCount()
    mainStateString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_2")
    subStateString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_STATE_SUB_2", "currentCount", currentEnterCount, "maxCount", maxEnterCount)
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \236\131\129\237\131\156\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    mainStateString = ""
    subStateString = ""
  end
  self._ui._txt_mainState:SetText(mainStateString)
  self._ui._txt_subState:SetText(subStateString)
end
function PaGlobal_GuildMatch:requestGuildMatchRoomList()
  if Panel_GuildMatch_All == nil then
    return
  end
  ToClient_requestInstanceFieldRoomList()
end
function PaGlobal_GuildMatch:updateMyGuildInfo()
  if Panel_GuildMatch_All == nil then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildInfo == nil then
    self._ui._stc_myGuildMark:SetShow(false)
    self._ui._txt_myGuildName:SetText("")
    UI.ASSERT_NAME(false, "\235\130\180 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui._stc_myGuildMark:SetShow(true)
  self:setGuildMark(myGuildInfo:getGuildNo_s64(), self._ui._stc_myGuildMark)
  self._ui._txt_myGuildName:SetText(myGuildInfo:getName())
end
function PaGlobal_GuildMatch:updateEnemyGuildInfo()
  if Panel_GuildMatch_All == nil then
    return
  end
  local state = ToClient_GetGuildMachPlayState()
  if state == __eGuildMatchPlayState_None or state == __eGuildMatchPlayState_Join then
    self._ui._stc_enemyGuildMark:SetShow(false)
    self:setGuildMark(nil, self._ui._stc_enemyGuildMark)
    self._ui._txt_enemyGuildName:SetShow(false)
  elseif state == __eGuildMatchPlayState_Play then
    self._ui._stc_enemyGuildMark:SetShow(true)
    self:setGuildMark(ToClient_GetGuildMatchEnemyGuildNoRaw(), self._ui._stc_enemyGuildMark)
    self._ui._txt_enemyGuildName:SetText(ToClient_getGuildMatchEnemyGuildName())
    self._ui._txt_enemyGuildName:SetShow(true)
  end
end
function PaGlobal_GuildMatch:setGuildMark(guildNoRaw, control)
  if Panel_GuildMatch_All == nil then
    return
  end
  local isSet = false
  if guildNoRaw ~= nil then
    isSet = setGuildTextureByGuildNo(guildNoRaw, control)
  end
  if isSet == false then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 183, 1, 188, 6)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  else
    control:getBaseTexture():setUV(0, 0, 1, 1)
  end
  control:setRenderTexture(control:getBaseTexture())
end
