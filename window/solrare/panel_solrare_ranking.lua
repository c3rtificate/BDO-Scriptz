PaGlobal_Solrare_Ranking = {
  _ui = {
    _btn_Close = nil,
    _btn_TierList = nil,
    _stc_TierListBg = nil,
    _frame_RankingBg = nil,
    _frame_Content = nil,
    _big_RecordTemp = nil,
    _frame_Scroll = nil,
    _small_RecordTemp = nil,
    _mostDetailTemp = nil,
    _txt_NoRank = nil,
    _classFilter = nil,
    _classTypeList = {},
    _consoleUI = nil,
    _consoleKeyX = nil,
    _consoleKeyB = nil,
    _consoleKeyA = nil
  },
  _recordControl = Array.new(),
  _recordInfo = Array.new(),
  _frameControlSize = 0,
  _maxShowingRecordCount = 100,
  _currentRecordCount = 0,
  _scrollIndex = 0,
  _normalBgSize = 0,
  _detailBgSize = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_All_Init")
registerEvent("FromClient_SolareRankingLoad", "FromClient_SolareRankingLoad")
function FromClient_Solrare_All_Init()
  PaGlobal_Solrare_Ranking:initialize()
end
function FromClient_SolareRankingLoad()
  PaGlobalFunc_Solrare_Ranking_Open()
end
function PaGlobal_Solrare_Ranking:initialize()
  local topBg = UI.getChildControl(Panel_Solrare_Ranking, "Static_Title_Bg")
  self._ui._btn_Close = UI.getChildControl(topBg, "Button_Close")
  local topArea = UI.getChildControl(Panel_Solrare_Ranking, "Static_Top_Area")
  self._ui._btn_TierList = UI.getChildControl(topArea, "Static_Tierlist_Btn")
  self._ui._stc_TierListBg = UI.getChildControl(Panel_Solrare_Ranking, "Static_TierList_BG")
  self._ui._frame_RankingBg = UI.getChildControl(Panel_Solrare_Ranking, "Frame_1")
  self._ui._frame_Content = UI.getChildControl(self._ui._frame_RankingBg, "Frame_1_Content")
  self._ui._frame_Scroll = UI.getChildControl(self._ui._frame_RankingBg, "Frame_1_VerticalScroll")
  self._ui._big_RecordTemp = UI.getChildControl(self._ui._frame_Content, "Static_Top_Rank_Tamplate")
  self._ui._small_RecordTemp = UI.getChildControl(self._ui._frame_Content, "Static_Other_Rank_Tamplate")
  self._ui._mostDetailTemp = UI.getChildControl(self._ui._frame_Content, "Static_Most_Detail_BG")
  self._ui._txt_NoRank = UI.getChildControl(Panel_Solrare_Ranking, "StaticText_Desc")
  self._ui._txt_NoRank:SetShow(false)
  local filterBg = UI.getChildControl(Panel_Solrare_Ranking, "Static_Filter_BG")
  self._ui._classFilter = UI.getChildControl(filterBg, "Combobox_Filter_Character")
  self._ui._consoleUI = UI.getChildControl(Panel_Solrare_Ranking, "Static_KeyGuide_ConsoleUI")
  self._ui._consoleKeyX = UI.getChildControl(self._ui._consoleUI, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui._consoleKeyB = UI.getChildControl(self._ui._consoleUI, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._consoleKeyA = UI.getChildControl(self._ui._consoleUI, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._consoleUI:SetShow(_ContentsGroup_UsePadSnapping)
  if _ContentsGroup_UsePadSnapping == true then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui._consoleKeyX,
      self._ui._consoleKeyA,
      self._ui._consoleKeyB
    }, self._ui._consoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_Solrare_Ranking:registerEvent()
  PaGlobal_Solrare_Ranking:createControl()
end
function PaGlobal_Solrare_Ranking:createControl()
  self._normalBgSize = self._ui._frame_Content:GetSizeY()
  self._detailBgSize = UI.getChildControl(self._ui._frame_Content, "Static_Most_Detail_BG"):GetSizeY()
  self._detailBgSize = self._detailBgSize / 3
  self._ui._classFilter:DeleteAllItem()
  self._ui._classFilter:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYEPALETTE_TAB_ALL"))
  local classCount = getCharacterClassCount()
  local count = 1
  for index = 0, classCount - 1 do
    local classType = getCharacterClassTypeByIndex(index)
    local className = getCharacterClassName(classType)
    if nil ~= className and "" ~= className and " " ~= className then
      self._ui._classFilter:AddItem(className)
      self._ui._classTypeList[count] = index
      count = count + 1
    end
  end
  local frameBg = self._ui._frame_Content
  local prevSizeY = 0
  local totalSize = 0
  local gap = 1
  for index = 1, self._maxShowingRecordCount do
    local tempTable = {
      stc_bg = nil,
      stc_classBg = nil,
      stc_tier = nil,
      stc_rank = nil,
      stc_classIcon = nil,
      txt_name = nil,
      txt_winRate = nil,
      txt_winLoseDraw = nil,
      txt_totalRating = nil,
      txt_recentRecord = nil,
      roundResultControlList = nil,
      slashControlList = nil,
      txt_rating = nil,
      stc_SuccessionIcon = nil,
      stc_AwakenIcon = nil,
      stc_ShyIcon = nil,
      stc_ArcherIcon = nil,
      stc_ScholarIcon = nil,
      chk_mostDetail = nil,
      btn_detail = nil,
      mostDetail = Array.new(),
      mostBg,
      isDetailControlShow = false
    }
    local clonedControl
    if index < 4 then
      clonedControl = UI.cloneControl(self._ui._big_RecordTemp, frameBg, "Static_SolareRecord_" .. tostring(index))
      if index == 2 then
        clonedControl:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 132, 1506, 262)
        clonedControl:getBaseTexture():setUV(x1, y1, x2, y2)
        clonedControl:setRenderTexture(clonedControl:getBaseTexture())
        clonedControl:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 525, 1506, 655)
        clonedControl:getOnTexture():setUV(x1, y1, x2, y2)
        clonedControl:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 918, 1506, 1048)
        clonedControl:getClickTexture():setUV(x1, y1, x2, y2)
      elseif index == 3 then
        clonedControl:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 263, 1506, 393)
        clonedControl:getBaseTexture():setUV(x1, y1, x2, y2)
        clonedControl:setRenderTexture(clonedControl:getBaseTexture())
        clonedControl:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 656, 1506, 786)
        clonedControl:getOnTexture():setUV(x1, y1, x2, y2)
        clonedControl:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(clonedControl, 1, 1049, 1506, 1179)
        clonedControl:getClickTexture():setUV(x1, y1, x2, y2)
      end
    else
      clonedControl = UI.cloneControl(self._ui._small_RecordTemp, frameBg, "Static_SolareRecord_" .. tostring(index))
    end
    if nil == cloneControl then
      return
    end
    tempTable.stc_bg = clonedControl
    if index == 1 then
      tempTable.stc_bg:SetPosY(0)
    else
      tempTable.stc_bg:SetPosY(prevSizeY + gap)
    end
    totalSize = totalSize + tempTable.stc_bg:GetSizeY()
    prevSizeY = prevSizeY + tempTable.stc_bg:GetSizeY()
    tempTable.stc_classBg = UI.getChildControl(clonedControl, "Static_Character_BG")
    tempTable.stc_tier = UI.getChildControl(clonedControl, "Static_Tier")
    tempTable._branch = UI.getChildControl(clonedControl, "StaticText_Type")
    tempTable.stc_rank = UI.getChildControl(clonedControl, "Static_Rank")
    tempTable.stc_classIcon = UI.getChildControl(clonedControl, "Static_Class")
    tempTable.txt_name = UI.getChildControl(clonedControl, "StaticText_Name")
    tempTable.txt_winRate = UI.getChildControl(clonedControl, "StaticText_Win_Rate")
    tempTable.txt_winLoseDraw = UI.getChildControl(clonedControl, "StaticText_Result")
    tempTable.txt_totalRating = UI.getChildControl(clonedControl, "StaticText_Score")
    tempTable.stc_SuccessionIcon = UI.getChildControl(clonedControl, "Static_Symbol_Succession")
    tempTable.stc_AwakenIcon = UI.getChildControl(clonedControl, "Static_Symbol_Awaken")
    tempTable.stc_ShyIcon = UI.getChildControl(clonedControl, "Static_Symbol_Shy")
    tempTable.stc_ArcherIcon = UI.getChildControl(clonedControl, "Static_Symbol_Archer")
    tempTable.stc_ScholarIcon = UI.getChildControl(clonedControl, "Static_Symbol_Scholar")
    local recentBg = UI.getChildControl(clonedControl, "Static_Recent_Record")
    tempTable.txt_recentRecord = UI.getChildControl(recentBg, "Static_RecordArea")
    tempTable.roundResultControlList = Array.new()
    tempTable.roundResultControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_0"))
    tempTable.roundResultControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_1"))
    tempTable.roundResultControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_2"))
    tempTable.roundResultControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_3"))
    tempTable.roundResultControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_4"))
    tempTable.slashControlList = Array.new()
    tempTable.slashControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_Slash_0"))
    tempTable.slashControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_Slash_1"))
    tempTable.slashControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_Slash_2"))
    tempTable.slashControlList:push_back(UI.getChildControl(tempTable.txt_recentRecord, "StaticText_Record_Slash_3"))
    tempTable.chk_mostDetail = UI.getChildControl(clonedControl, "CheckButton_Most_Detail")
    tempTable.btn_detail = UI.getChildControl(clonedControl, "Button_Detail")
    if _ContentsGroup_UsePadSnapping == true then
      tempTable.stc_bg:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_Ranking_DetailToggle(" .. tostring(index) .. ")")
    else
      tempTable.chk_mostDetail:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_Ranking_DetailToggle(" .. tostring(index) .. ")")
    end
    tempTable.chk_mostDetail:setNotImpactScrollEvent(true)
    local clonedMostControl = UI.cloneControl(self._ui._mostDetailTemp, frameBg, "Static_SolareMostDetail_" .. tostring(index))
    if nil == clonedMostControl then
      return
    end
    tempTable.mostBg = clonedMostControl
    for idx = 1, 3 do
      local tempMostDetail = {
        stc_bg = nil,
        stc_classBg = nil,
        stc_classIcon = nil,
        stc_branch = nil,
        btn_detail = nil,
        txt_winRate = nil,
        txt_result = nil,
        txt_recentRecord = nil,
        roundResultControlList = nil,
        slashControlList = nil
      }
      tempMostDetail.stc_bg = UI.getChildControl(clonedMostControl, "Static_Most" .. tostring(idx) .. "_BG")
      tempMostDetail.stc_classBg = UI.getChildControl(tempMostDetail.stc_bg, "Static_Character_BG")
      tempMostDetail.stc_classIcon = UI.getChildControl(tempMostDetail.stc_bg, "Static_Class")
      tempMostDetail.stc_branch = UI.getChildControl(tempMostDetail.stc_bg, "StaticText_Type")
      tempMostDetail.btn_detail = UI.getChildControl(tempMostDetail.stc_bg, "Button_Detail")
      tempMostDetail.txt_winRate = UI.getChildControl(tempMostDetail.stc_bg, "StaticText_Win_Rate")
      tempMostDetail.txt_result = UI.getChildControl(tempMostDetail.stc_bg, "StaticText_Result")
      local recentBg = UI.getChildControl(tempMostDetail.stc_bg, "Static_Recent_Record")
      tempMostDetail.txt_recentRecord = UI.getChildControl(recentBg, "Static_RecordArea")
      tempMostDetail.roundResultControlList = Array.new()
      tempMostDetail.roundResultControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_0"))
      tempMostDetail.roundResultControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_1"))
      tempMostDetail.roundResultControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_2"))
      tempMostDetail.roundResultControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_3"))
      tempMostDetail.roundResultControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_4"))
      tempMostDetail.slashControlList = Array.new()
      tempMostDetail.slashControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_Slash_0"))
      tempMostDetail.slashControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_Slash_1"))
      tempMostDetail.slashControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_Slash_2"))
      tempMostDetail.slashControlList:push_back(UI.getChildControl(tempMostDetail.txt_recentRecord, "StaticText_Record_Slash_3"))
      tempMostDetail.btn_detail:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_Ranking_Detail(" .. tostring(idx - 1) .. ")")
      tempTable.mostDetail:push_back(tempMostDetail)
    end
    self._recordControl:push_back(tempTable)
  end
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), totalSize)
  self._ui._frame_RankingBg:ComputePos()
  self._ui._frame_RankingBg:UpdateContentPos()
  self._ui._big_RecordTemp:SetShow(false)
  self._ui._small_RecordTemp:SetShow(false)
end
function PaGlobal_Solrare_Ranking:registerEvent()
  Panel_Solrare_Ranking:SetDragEnable(true)
  UIScroll.InputEvent(self._ui._frame_Scroll, "HandleEventScroll_Solrare_Ranking_Update")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_Ranking_Close()")
  self._ui._classFilter:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_Ranking_ToggleClassList()")
  self._ui._classFilter:GetListControl():AddSelectEvent("PaGlobalFunc_Solrare_Ranking_SelectClassList()")
  self._ui._btn_TierList:addInputEvent("Mouse_On", "PaGlobalFunc_PaGlobal_Solrare_Ranking_TierListShow(true)")
  self._ui._btn_TierList:addInputEvent("Mouse_Out", "PaGlobalFunc_PaGlobal_Solrare_Ranking_TierListShow(false)")
end
function PaGlobal_Solrare_Ranking:open()
  self._ui._stc_TierListBg:SetShow(false)
  self._ui._classFilter:SetSelectItemIndex(0)
  self._ui._classFilter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYEPALETTE_TAB_ALL"))
  Panel_Solrare_Ranking:ComputePos()
  PaGlobal_Solrare_Ranking:updateAllRanking()
  PaGlobal_Solrare_Ranking:reAlignFrameControl()
  self._ui._frame_Scroll:SetControlTop()
  self._ui._frame_Scroll:SetControlPos(0)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Solrare_Ranking:ignorePadSnapMoveToOtherPanel(true)
    ToClient_padSnapSetTargetPanel(Panel_Solrare_Ranking)
  end
  Panel_Solrare_Ranking:SetShow(true)
end
function PaGlobal_Solrare_Ranking:updateAllRanking()
  PaGlobal_Solrare_Ranking:closeMostDetail()
  self._maxShowingRecordCount = 100
  self._currentRecordCount = ToClient_GetSolareRankingInfoCount()
  self._scrollIndex = 0
  local isShowAble = self._currentRecordCount > 0
  self._ui._txt_NoRank:SetShow(not isShowAble)
  self._ui._frame_Scroll:SetShow(isShowAble)
  for idx = 1, self._maxShowingRecordCount do
    if nil ~= self._recordControl[idx] then
      self._recordControl[idx].stc_bg:SetShow(false)
    end
  end
  if self._currentRecordCount <= 0 then
    return
  end
  self._recordInfo = Array.new()
  local totalSize = 0
  for idx = 0, self._currentRecordCount - 1 do
    local recordInfo = ToClient_GetSolareRankingByIndex(idx)
    if nil ~= recordInfo then
      local tempTable = {
        _name = nil,
        _branch = nil,
        _rankRating = nil,
        _winCount = 0,
        _loseCount = 0,
        _drawCount = 0,
        _winRate = 0,
        _classTypeRaw = 0,
        _mostCount = 0,
        _topClassType = {},
        _topBranch = {},
        _topWinCount = {},
        _topLoseCount = {},
        _topDrawCount = {},
        _topPlayCount = {},
        _topWinRate = {}
      }
      tempTable._name = recordInfo:getName()
      tempTable._branch = recordInfo:getSkillBranch(0)
      tempTable._rankRating = recordInfo:getRankRating()
      tempTable._winCount = recordInfo:getUserWinCount()
      tempTable._loseCount = recordInfo:getUserLoseCount()
      tempTable._drawCount = recordInfo:getUserDrawCount()
      tempTable._classTypeRaw = recordInfo:getClassTypeRaw(0)
      for index = 0, 2 do
        tempTable._topClassType[index] = recordInfo:getClassTypeRaw(index)
        tempTable._topBranch[index] = recordInfo:getSkillBranch(index)
        tempTable._topWinCount[index] = recordInfo:getWinCount(index)
        tempTable._topLoseCount[index] = recordInfo:getLoseCount(index)
        tempTable._topDrawCount[index] = recordInfo:getDrawCount(index)
        tempTable._topPlayCount[index] = recordInfo:getPlayCount(index)
        local winRate = 0
        local totalGameCount = tempTable._topWinCount[index] + tempTable._topLoseCount[index] + tempTable._topDrawCount[index]
        if totalGameCount > 0 then
          winRate = tempTable._topWinCount[index] / totalGameCount * 100
        end
        tempTable._topWinRate[index] = winRate
      end
      local winRate = 0
      local totalGameCount = tempTable._winCount + tempTable._loseCount + tempTable._drawCount
      if totalGameCount > 0 then
        winRate = tempTable._winCount / totalGameCount * 100
        tempTable._winRate = winRate
      end
      local controlIdx = idx + 1
      if nil ~= self._recordControl[controlIdx] then
        local control = self._recordControl[controlIdx]
        local isTop = controlIdx == 1
        PaGlobalFunc_Util_SetSolrareRankingClassBigBG(control.stc_classBg, tempTable._classTypeRaw)
        PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(control.stc_tier, tempTable._rankRating, isTop)
        PaGlobalFunc_Solrare_Ranking_SetRankBg(control.stc_rank, controlIdx)
        PaGlobalFunc_Util_ChangeTextureClass(control.stc_classIcon, tempTable._classTypeRaw)
        control.txt_name:SetText(tempTable._name)
        control._branch:SetText(PaGlobalFunc_Solrare_Ranking_GetBranchText(tempTable._classTypeRaw, tempTable._branch))
        control.txt_winRate:SetText(string.format("%.2f", tempTable._winRate) .. "%")
        control.txt_winLoseDraw:SetText(tempTable._winCount .. " / " .. tempTable._drawCount .. " / " .. tempTable._loseCount)
        control.txt_totalRating:SetText(tempTable._rankRating)
        if _ContentsGroup_UsePadSnapping == true then
          control.stc_bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Solrare_OtherInfo_OpenByRanking(" .. tostring(idx) .. "," .. "0" .. ")")
        else
          control.btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRanking(" .. tostring(idx) .. "," .. "0" .. ")")
        end
        control.stc_SuccessionIcon:SetShow(false)
        control.stc_AwakenIcon:SetShow(false)
        control.stc_ShyIcon:SetShow(false)
        control.stc_ArcherIcon:SetShow(false)
        control.stc_ScholarIcon:SetShow(false)
        if tempTable._classTypeRaw == __eClassType_ShyWaman then
          control.stc_ShyIcon:SetShow(true)
        elseif tempTable._classTypeRaw == __eClassType_RangerMan then
          control.stc_ArcherIcon:SetShow(true)
        elseif tempTable._classTypeRaw == __eClassType_Scholar then
          control.stc_ScholarIcon:SetShow(true)
        elseif PaGlobalFunc_Solrare_Ranking_GetBranch(tempTable._classTypeRaw, tempTable._branch) == __eSkillTypeParam_Awaken then
          control.stc_AwakenIcon:SetShow(true)
        else
          control.stc_SuccessionIcon:SetShow(true)
        end
        control.isDetailControlShow = false
        control.mostBg:SetShow(false)
        control.chk_mostDetail:SetCheck(false)
        local winTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Win"
        local loseTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Lose"
        local drawTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Draw"
        local slashCount = 0
        local recordCount = 0
        for key, value in pairs(control.roundResultControlList) do
          if value ~= nil then
            local roundResultValue = recordInfo:getUserRecentResultByIndex(key - 1)
            if roundResultValue ~= __eSolareRoundResult_Count then
              local roundResultTextureID
              if __eSolareRoundResult_Win == roundResultValue then
                roundResultTextureID = winTextureID
              elseif __eSolareRoundResult_Lose == roundResultValue then
                roundResultTextureID = loseTextureID
              elseif __eSolareRoundResult_Draw == roundResultValue then
                roundResultTextureID = drawTextureID
              end
              if roundResultTextureID ~= nil then
                value:ChangeTextureInfoTextureIDAsync(roundResultTextureID)
                value:setRenderTexture(value:getBaseTexture())
                recordCount = recordCount + 1
                value:SetShow(true)
              end
            else
              value:SetShow(false)
            end
          end
        end
        slashCount = recordCount - 1
        local allCount = slashCount + recordCount
        local middlePos = 275
        local sizeIcon = 20
        local startPos = middlePos - allCount / 2 * 20
        local iconIdx = 0
        for key, value in pairs(control.roundResultControlList) do
          if value ~= nil and recordCount >= key then
            value:SetPosX(startPos + sizeIcon * iconIdx)
            iconIdx = iconIdx + 2
          end
        end
        iconIdx = 1
        for key, value in pairs(control.slashControlList) do
          if value ~= nil and key <= slashCount then
            value:SetPosX(startPos + sizeIcon * iconIdx)
            iconIdx = iconIdx + 2
            value:SetShow(true)
          else
            value:SetShow(false)
          end
        end
        for index = 1, 3 do
          if control.mostDetail[index] ~= nil then
            if tempTable._topClassType[index - 1] == __eClassType_Count then
              control.mostDetail[index].stc_bg:SetShow(false)
            else
              control.mostDetail[index].stc_bg:SetShow(true)
              PaGlobalFunc_Util_ChangeTextureClass(control.mostDetail[index].stc_classIcon, tempTable._topClassType[index - 1])
              PaGlobalFunc_Util_SetSolrareRankingClassBigBG(control.mostDetail[index].stc_classBg, tempTable._topClassType[index - 1])
              control.mostDetail[index].stc_branch:SetText(PaGlobalFunc_Solrare_Ranking_GetBranchText(tempTable._topClassType[index - 1], tempTable._topBranch[index - 1]))
              if _ContentsGroup_UsePadSnapping == true then
                control.mostDetail[index].stc_bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_Solrare_OtherInfo_OpenByRanking(" .. tostring(idx) .. "," .. tostring(index - 1) .. ")")
              else
                control.mostDetail[index].btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByRanking(" .. tostring(idx) .. "," .. tostring(index - 1) .. ")")
              end
              control.mostDetail[index].txt_winRate:SetText(string.format("%.2f", tempTable._topWinRate[index - 1]) .. "%")
              control.mostDetail[index].txt_result:SetText(tempTable._topWinCount[index - 1] .. " / " .. tempTable._topDrawCount[index - 1] .. " / " .. tempTable._topLoseCount[index - 1])
              slashCount = 0
              recordCount = 0
              for key, value in pairs(control.mostDetail[index].roundResultControlList) do
                if value ~= nil then
                  local roundResultValue = recordInfo:getRecentResultByIndex(index - 1, key - 1)
                  if __eSolareRoundResult_Win ~= roundResultValue and __eSolareRoundResult_Lose ~= roundResultValue and __eSolareRoundResult_Draw ~= roundResultValue then
                    value:SetShow(false)
                  else
                    local roundResultTextureID
                    if __eSolareRoundResult_Win == roundResultValue then
                      roundResultTextureID = winTextureID
                    elseif __eSolareRoundResult_Lose == roundResultValue then
                      roundResultTextureID = loseTextureID
                    elseif __eSolareRoundResult_Draw == roundResultValue then
                      roundResultTextureID = drawTextureID
                    end
                    if roundResultTextureID ~= nil then
                      value:ChangeTextureInfoTextureIDAsync(roundResultTextureID)
                      value:setRenderTexture(value:getBaseTexture())
                      recordCount = recordCount + 1
                      value:SetShow(true)
                    end
                  end
                end
              end
              slashCount = recordCount - 1
              allCount = slashCount + recordCount
              middlePos = 280
              sizeIcon = 20
              startPos = middlePos - allCount / 2 * 20
              iconIdx = 0
              for key, value in pairs(control.mostDetail[index].roundResultControlList) do
                if value ~= nil and key <= recordCount then
                  value:SetPosX(startPos + sizeIcon * iconIdx)
                  iconIdx = iconIdx + 2
                end
              end
              iconIdx = 1
              for key, value in pairs(control.mostDetail[index].slashControlList) do
                if value ~= nil and key <= slashCount then
                  value:SetPosX(startPos + sizeIcon * iconIdx)
                  iconIdx = iconIdx + 2
                  value:SetShow(true)
                else
                  value:SetShow(false)
                end
              end
              tempTable._mostCount = tempTable._mostCount + 1
            end
          end
        end
        control.stc_bg:SetShow(true)
        totalSize = totalSize + control.stc_bg:GetSizeY()
      end
      self._recordInfo:push_back(tempTable)
    end
  end
  UIScroll.SetButtonSize(self._ui._frame_Scroll, self._maxShowingRecordCount, totalSize)
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), totalSize)
  self._ui._frame_RankingBg:ComputePos()
  self._ui._frame_RankingBg:UpdateContentPos()
  self._ui._frame_RankingBg:UpdateContentScroll()
end
function PaGlobal_Solrare_Ranking:updateClassRanking(type)
  PaGlobal_Solrare_Ranking:closeMostDetail()
  self._maxShowingRecordCount = 20
  self._currentRecordCount = ToClient_GetSolareClassRankingInfoCount(type)
  self._scrollIndex = 0
  local isShowAble = self._currentRecordCount > 0
  self._ui._txt_NoRank:SetShow(not isShowAble)
  self._ui._frame_Scroll:SetShow(isShowAble)
  for idx = 1, 100 do
    if nil ~= self._recordControl[idx] then
      self._recordControl[idx].stc_bg:SetShow(false)
    end
  end
  if self._currentRecordCount <= 0 then
    return
  end
  self._recordInfo = Array.new()
  local totalSize = 0
  for idx = 0, self._currentRecordCount - 1 do
    local recordInfo = ToClient_GetSolareClassRankingByIndex(type, idx)
    if nil ~= recordInfo then
      local tempTable = {
        _name = nil,
        _branch = nil,
        _rankRating = nil,
        _winCount = 0,
        _loseCount = 0,
        _drawCount = 0,
        _winRate = 0,
        _classTypeRaw = 0,
        _mostCount = 0,
        _topClassType = {},
        _topBranch = {},
        _topWinCount = {},
        _topLoseCount = {},
        _topDrawCount = {},
        _topPlayCount = {},
        _topWinRate = {}
      }
      tempTable._name = recordInfo:getName()
      tempTable._branch = recordInfo:getSkillBranch(0)
      tempTable._rankRating = recordInfo:getRankRating()
      tempTable._winCount = recordInfo:getWinCount(0)
      tempTable._loseCount = recordInfo:getLoseCount(0)
      tempTable._drawCount = recordInfo:getDrawCount(0)
      tempTable._classTypeRaw = recordInfo:getClassTypeRaw(0)
      for index = 0, 2 do
        tempTable._topClassType[index] = recordInfo:getClassTypeRaw(index)
        tempTable._topBranch[index] = recordInfo:getSkillBranch(index)
        tempTable._topWinCount[index] = recordInfo:getWinCount(index)
        tempTable._topLoseCount[index] = recordInfo:getLoseCount(index)
        tempTable._topDrawCount[index] = recordInfo:getDrawCount(index)
        tempTable._topPlayCount[index] = recordInfo:getPlayCount(index)
        local winRate = 0
        local totalGameCount = tempTable._topWinCount[index] + tempTable._topLoseCount[index] + tempTable._topDrawCount[index]
        if totalGameCount > 0 then
          winRate = tempTable._topWinCount[index] / totalGameCount * 100
        end
        tempTable._topWinRate[index] = winRate
      end
      local winRate = 0
      local totalGameCount = tempTable._winCount + tempTable._loseCount + tempTable._drawCount
      if totalGameCount > 0 then
        winRate = tempTable._winCount / totalGameCount * 100
        tempTable._winRate = winRate
      end
      local controlIdx = idx + 1
      if nil ~= self._recordControl[controlIdx] then
        local control = self._recordControl[controlIdx]
        local isTop = controlIdx == 1
        PaGlobalFunc_Util_SetSolrareRankingClassBigBG(control.stc_classBg, tempTable._classTypeRaw)
        PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(control.stc_tier, tempTable._rankRating, isTop)
        PaGlobalFunc_Solrare_Ranking_SetRankBg(control.stc_rank, controlIdx)
        PaGlobalFunc_Util_ChangeTextureClass(control.stc_classIcon, tempTable._classTypeRaw)
        control.txt_name:SetText(tempTable._name)
        control._branch:SetText(PaGlobalFunc_Solrare_Ranking_GetBranchText(tempTable._classTypeRaw, tempTable._branch))
        control.txt_winRate:SetText(string.format("%.2f", tempTable._winRate) .. "%")
        control.txt_winLoseDraw:SetText(tempTable._winCount .. " / " .. tempTable._drawCount .. " / " .. tempTable._loseCount)
        control.txt_totalRating:SetText(tempTable._rankRating)
        control.btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByClassRanking(" .. tostring(idx) .. "," .. tostring(tempTable._classTypeRaw) .. "," .. "0" .. ")")
        control.stc_SuccessionIcon:SetShow(false)
        control.stc_AwakenIcon:SetShow(false)
        control.stc_ShyIcon:SetShow(false)
        control.stc_ArcherIcon:SetShow(false)
        control.stc_ScholarIcon:SetShow(false)
        if tempTable._classTypeRaw == __eClassType_ShyWaman then
          control.stc_ShyIcon:SetShow(true)
        elseif tempTable._classTypeRaw == __eClassType_RangerMan then
          control.stc_ArcherIcon:SetShow(true)
        elseif tempTable._classTypeRaw == __eClassType_Scholar then
          control.stc_ScholarIcon:SetShow(true)
        elseif PaGlobalFunc_Solrare_Ranking_GetBranch(tempTable._classTypeRaw, tempTable._branch) == __eSkillTypeParam_Awaken then
          control.stc_AwakenIcon:SetShow(true)
        else
          control.stc_SuccessionIcon:SetShow(true)
        end
        control.isDetailControlShow = false
        control.mostBg:SetShow(false)
        control.chk_mostDetail:SetCheck(false)
        local winTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Win"
        local loseTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Lose"
        local drawTextureID = "Combine_Etc_Solare_War_Ingame_Icon_Result_Draw"
        local slashCount = 0
        local recordCount = 0
        for key, value in pairs(control.roundResultControlList) do
          if value ~= nil then
            local roundResultValue = recordInfo:getRecentResultByIndex(0, key - 1)
            if __eSolareRoundResult_Win ~= roundResultValue and __eSolareRoundResult_Lose ~= roundResultValue and __eSolareRoundResult_Draw ~= roundResultValue then
              value:SetShow(false)
            else
              local roundResultTextureID
              if __eSolareRoundResult_Win == roundResultValue then
                roundResultTextureID = winTextureID
              elseif __eSolareRoundResult_Lose == roundResultValue then
                roundResultTextureID = loseTextureID
              elseif __eSolareRoundResult_Draw == roundResultValue then
                roundResultTextureID = drawTextureID
              end
              if roundResultTextureID ~= nil then
                value:ChangeTextureInfoTextureIDAsync(roundResultTextureID)
                value:setRenderTexture(value:getBaseTexture())
                recordCount = recordCount + 1
                value:SetShow(true)
              end
            end
          end
        end
        slashCount = recordCount - 1
        local allCount = slashCount + recordCount
        local middlePos = 275
        local sizeIcon = 20
        local startPos = middlePos - allCount / 2 * 20
        local iconIdx = 0
        for key, value in pairs(control.roundResultControlList) do
          if value ~= nil and recordCount >= key then
            value:SetPosX(startPos + sizeIcon * iconIdx)
            iconIdx = iconIdx + 2
          end
        end
        iconIdx = 1
        for key, value in pairs(control.slashControlList) do
          if value ~= nil and key <= slashCount then
            value:SetPosX(startPos + sizeIcon * iconIdx)
            iconIdx = iconIdx + 2
            value:SetShow(true)
          else
            value:SetShow(false)
          end
        end
        for index = 1, 3 do
          if control.mostDetail[index] ~= nil then
            if tempTable._topClassType[index - 1] == __eClassType_Count then
              control.mostDetail[index].stc_bg:SetShow(false)
            else
              control.mostDetail[index].stc_bg:SetShow(true)
              PaGlobalFunc_Util_ChangeTextureClass(control.mostDetail[index].stc_classIcon, tempTable._topClassType[index - 1])
              PaGlobalFunc_Util_SetSolrareRankingClassBigBG(control.mostDetail[index].stc_classBg, tempTable._topClassType[index - 1])
              control.mostDetail[index].stc_branch:SetText(PaGlobalFunc_Solrare_Ranking_GetBranchText(tempTable._topClassType[index - 1], tempTable._topBranch[index - 1]))
              control.mostDetail[index].btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_OpenByClassRanking(" .. tostring(idx) .. "," .. tostring(tempTable._classTypeRaw) .. "," .. tostring(index - 1) .. ")")
              control.mostDetail[index].txt_winRate:SetText(string.format("%.2f", tempTable._topWinRate[index - 1]) .. "%")
              control.mostDetail[index].txt_result:SetText(tempTable._topWinCount[index - 1] .. " / " .. tempTable._topDrawCount[index - 1] .. " / " .. tempTable._topLoseCount[index - 1])
              slashCount = 0
              recordCount = 0
              for key, value in pairs(control.mostDetail[index].roundResultControlList) do
                if value ~= nil then
                  local roundResultValue = recordInfo:getRecentResultByIndex(index - 1, key - 1)
                  if __eSolareRoundResult_Win ~= roundResultValue and __eSolareRoundResult_Lose ~= roundResultValue and __eSolareRoundResult_Draw ~= roundResultValue then
                    value:SetShow(false)
                  else
                    local roundResultTextureID
                    if __eSolareRoundResult_Win == roundResultValue then
                      roundResultTextureID = winTextureID
                    elseif __eSolareRoundResult_Lose == roundResultValue then
                      roundResultTextureID = loseTextureID
                    elseif __eSolareRoundResult_Draw == roundResultValue then
                      roundResultTextureID = drawTextureID
                    end
                    if roundResultTextureID ~= nil then
                      value:ChangeTextureInfoTextureIDAsync(roundResultTextureID)
                      value:setRenderTexture(value:getBaseTexture())
                      recordCount = recordCount + 1
                      value:SetShow(true)
                    end
                  end
                end
              end
              slashCount = recordCount - 1
              allCount = slashCount + recordCount
              middlePos = 280
              sizeIcon = 20
              startPos = middlePos - allCount / 2 * 20
              iconIdx = 0
              for key, value in pairs(control.mostDetail[index].roundResultControlList) do
                if value ~= nil and key <= recordCount then
                  value:SetPosX(startPos + sizeIcon * iconIdx)
                  iconIdx = iconIdx + 2
                end
              end
              iconIdx = 1
              for key, value in pairs(control.mostDetail[index].slashControlList) do
                if value ~= nil and key <= slashCount then
                  value:SetPosX(startPos + sizeIcon * iconIdx)
                  iconIdx = iconIdx + 2
                  value:SetShow(true)
                else
                  value:SetShow(false)
                end
              end
              tempTable._mostCount = tempTable._mostCount + 1
            end
          end
        end
        control.stc_bg:SetShow(true)
        totalSize = totalSize + control.stc_bg:GetSizeY()
      end
      self._recordInfo:push_back(tempTable)
    end
  end
  UIScroll.SetButtonSize(self._ui._frame_Scroll, self._maxShowingRecordCount, totalSize)
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), totalSize)
  self._ui._frame_RankingBg:ComputePos()
  self._ui._frame_RankingBg:UpdateContentPos()
  self._ui._frame_RankingBg:UpdateContentScroll()
end
function PaGlobal_Solrare_Ranking:openMostDetail()
  for idx = 0, self._currentRecordCount - 1 do
    local controlIdx = idx + 1
    if nil ~= self._recordControl[controlIdx] then
      local control = self._recordControl[controlIdx]
      local isDetailOpen = control.isDetailControlShow
      if isDetailOpen == false then
        control.mostBg:SetShow(false)
      else
        control.mostBg:SetShow(true)
        control.mostBg:SetPosY(control.stc_bg:GetPosY() + control.stc_bg:GetSizeY())
      end
    end
  end
end
function PaGlobal_Solrare_Ranking:closeMostDetail()
  for idx = 0, self._currentRecordCount - 1 do
    local controlIdx = idx + 1
    if nil ~= self._recordControl[controlIdx] then
      local control = self._recordControl[controlIdx]
      control.mostBg:SetShow(false)
    end
  end
end
function PaGlobal_Solrare_Ranking:close()
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Solrare_Ranking:ignorePadSnapMoveToOtherPanel(Panel_Solrare_Ranking)
  end
  Panel_Solrare_Ranking:SetShow(false)
end
function PaGlobal_Solrare_Ranking:reAlignFrameControl()
  local prevPosY = 5
  local gap = 3
  local isDetailClicked = false
  local mostCount = 0
  local totalControlSize = 0
  local prevScrollControlPos = self._ui._frame_Scroll:GetControlPos()
  for idx = 1, self._currentRecordCount do
    if nil ~= self._recordControl[idx] then
      local controlList = self._recordControl[idx]
      local isDetailOpen = controlList.isDetailControlShow
      controlList.stc_bg:SetPosXY(controlList.stc_bg:GetPosX(), prevPosY)
      if true == isDetailOpen then
        isDetailClicked = true
        mostCount = self._recordInfo[idx]._mostCount
        prevPosY = prevPosY + (controlList.stc_bg:GetSizeY() + self._detailBgSize * mostCount + gap)
        totalControlSize = totalControlSize + controlList.stc_bg:GetSizeY() + self._detailBgSize * mostCount + gap
      else
        prevPosY = prevPosY + (controlList.stc_bg:GetSizeY() + gap)
        totalControlSize = totalControlSize + controlList.stc_bg:GetSizeY() + gap
      end
    end
  end
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), totalControlSize + 5)
  self._ui._frame_RankingBg:UpdateContentPos()
  self._ui._frame_Scroll:SetInterval(self._ui._frame_Content:GetSizeY() / 100 * 1.1)
  self._ui._frame_Scroll:SetControlPos(prevScrollControlPos)
  PaGlobal_Solrare_Ranking:openMostDetail()
end
function HandleEventScroll_Solrare_Ranking_Update(isUp)
  PaGlobal_Solrare_Ranking._scrollIdx = UIScroll.ScrollEvent(PaGlobal_Solrare_Ranking._ui._frame_Scroll, isUp, PaGlobal_Solrare_Ranking._maxShowingRecordCount, PaGlobal_Solrare_Ranking._currentRecordCount, PaGlobal_Solrare_Ranking._scrollIdx, 1)
end
function PaGlobalFunc_Solrare_Ranking_Open()
  PaGlobal_Solrare_Ranking:open()
end
function PaGlobalFunc_Solrare_Ranking_Close()
  PaGlobal_Solrare_Ranking:close()
end
function PaGlobalFunc_Solrare_Ranking_SetRankBg(control, rank)
  if nil == control then
    return
  end
  if rank == 1 then
    control:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1333, 141, 1433)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif rank == 2 then
    control:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1434, 141, 1534)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif rank == 3 then
    control:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1535, 141, 1635)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  else
    control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_OTHER_RANK", "rank", rank))
  end
end
function PaGlobalFunc_Solrare_Ranking_GetBranchText(classType, branch)
  local className = getCharacterClassName(classType)
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if classType == __eClassType_ShyWaman or classType == __eClassType_RangerMan or classType == __eClassType_Scholar then
    return className
  end
  if branch == __eSkillTypeParam_Awaken then
    return "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN") .. "]" .. className
  elseif branch == __eSkillTypeParam_Inherit or branch == __eSkillTypeParam_Normal then
    return "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION") .. "]" .. className
  end
  return className
end
function PaGlobalFunc_Solrare_Ranking_GetBranch(classType, branch)
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if branch == __eSkillTypeParam_Awaken then
    return __eSkillTypeParam_Awaken
  elseif branch == __eSkillTypeParam_Inherit or branch == __eSkillTypeParam_Normal then
    return __eSkillTypeParam_Inherit
  end
end
function PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(control, rankScore, isTop)
  if nil == control then
    return
  end
  if nil == isTop then
    isTop = false
  end
  local rankDefine = Defines.SolrareRank
  local myTier = CovertSolrareRankScoreToTierGrade(rankScore)
  local tierFileNumber = Defines.SolrareRankOrder[myTier]
  if nil == tierFileNumber then
    return
  end
  if tierFileNumber < 10 then
    tierFileNumber = "0" .. tostring(tierFileNumber)
  end
  local fileName = "Combine/Icon/Tier/Solare_Tier" .. tostring(tierFileNumber) .. ".dds"
  if isTop == true and Defines.SolrareRank.RANK1_1 == myTier then
    fileName = "Combine/Icon/Tier/Solare_Tier22.dds"
  end
  control:ChangeTextureInfoNameDefault(fileName)
  local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 120, 120)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobalFunc_Solrare_Ranking_ToggleClassList()
  PaGlobal_Solrare_Ranking._ui._classFilter:ToggleListbox()
end
function PaGlobalFunc_Solrare_Ranking_SelectClassList()
  local selectIndex = PaGlobal_Solrare_Ranking._ui._classFilter:GetSelectIndex()
  local filterName = ""
  if selectIndex == 0 then
    filterName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYEPALETTE_TAB_ALL")
    PaGlobal_Solrare_Ranking:updateAllRanking()
  else
    if PaGlobal_Solrare_Ranking._ui._classTypeList[selectIndex] == nil then
      return
    end
    local index = PaGlobal_Solrare_Ranking._ui._classTypeList[selectIndex]
    local classType = getCharacterClassTypeByIndex(index)
    local className = getCharacterClassName(classType)
    filterName = className
    PaGlobal_Solrare_Ranking:updateClassRanking(classType)
  end
  PaGlobal_Solrare_Ranking:reAlignFrameControl()
  PaGlobal_Solrare_Ranking._ui._classFilter:SetText(filterName)
  PaGlobal_Solrare_Ranking._ui._frame_Scroll:SetControlPos(0)
  PaGlobal_Solrare_Ranking._ui._frame_RankingBg:UpdateContentPos()
end
function HandleEventLUp_Solrare_Ranking_DetailToggle(index)
  if nil == PaGlobal_Solrare_Ranking._recordControl[index] then
    return
  end
  for idx = 1, PaGlobal_Solrare_Ranking._currentRecordCount do
    if nil ~= PaGlobal_Solrare_Ranking._recordControl[idx] then
      if index == idx then
        if true == PaGlobal_Solrare_Ranking._recordControl[idx].isDetailControlShow then
          PaGlobal_Solrare_Ranking._recordControl[idx].isDetailControlShow = false
          PaGlobal_Solrare_Ranking._recordControl[idx].chk_mostDetail:SetCheck(false)
        else
          PaGlobal_Solrare_Ranking._recordControl[idx].isDetailControlShow = true
          PaGlobal_Solrare_Ranking._recordControl[idx].chk_mostDetail:SetCheck(true)
        end
      else
        PaGlobal_Solrare_Ranking._recordControl[idx].isDetailControlShow = false
        PaGlobal_Solrare_Ranking._recordControl[idx].chk_mostDetail:SetCheck(false)
      end
    end
  end
  PaGlobal_Solrare_Ranking:reAlignFrameControl()
end
function PaGlobalFunc_PaGlobal_Solrare_Ranking_TierListShow(isShow)
  PaGlobal_Solrare_Ranking._ui._stc_TierListBg:SetShow(isShow)
end
