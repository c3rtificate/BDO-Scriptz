function PaGlobal_Quest_All:resetDataArray()
  self._questSortArrayRegion = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_AbyssOne] = {},
    [CppEnums.QuestRegionType.eQuestRegionType_MorningLand] = {},
    [CppEnums.QuestRegionType.eQeustRegionType_Ulukita] = {}
  }
  self._questArrayRegionCount = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_AbyssOne] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_MorningLand] = 0,
    [CppEnums.QuestRegionType.eQeustRegionType_Ulukita] = 0
  }
  self._questSortArrayType = {
    [__eQuestType_BlackSpirit] = {},
    [__eQuestType_Main] = {},
    [__eQuestType_Sub] = {},
    [__eQuestType_Repeat] = {},
    [__eQuestType_Adventure] = {},
    [__eQuestType_BaseLife] = {},
    [__eQuestType_OceanLife] = {},
    [__eQuestType_CraftLife] = {},
    [__eQuestType_Contents] = {},
    [__eQuestType_Event] = {},
    [__eQuestType_Guild] = {},
    [__eQuestType_DirectAccept] = {},
    [__eQuestType_Sudden] = {},
    [__eQuestType_SeasonPass] = {},
    [__eQuestType_GrowthPass] = {},
    [__eQuestType_DirectClear] = {},
    [__eQuestType_Journal] = {}
  }
  self._questArrayTypeCount = {
    [__eQuestType_BlackSpirit] = 0,
    [__eQuestType_Main] = 0,
    [__eQuestType_Sub] = 0,
    [__eQuestType_Repeat] = 0,
    [__eQuestType_Adventure] = 0,
    [__eQuestType_BaseLife] = 0,
    [__eQuestType_OceanLife] = 0,
    [__eQuestType_CraftLife] = 0,
    [__eQuestType_Contents] = 0,
    [__eQuestType_Event] = 0,
    [__eQuestType_Guild] = 0,
    [__eQuestType_DirectAccept] = 0,
    [__eQuestType_Sudden] = 0,
    [__eQuestType_SeasonPass] = 0,
    [__eQuestType_GrowthPass] = 0,
    [__eQuestType_DirectClear] = 0,
    [__eQuestType_Journal] = 0
  }
  self._questArrayRegionProgressCount = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_AbyssOne] = 0,
    [CppEnums.QuestRegionType.eQuestRegionType_MorningLand] = 0,
    [CppEnums.QuestRegionType.eQeustRegionType_Ulukita] = 0
  }
  self._questArrayTypeProgressCount = {
    [__eQuestType_BlackSpirit] = 0,
    [__eQuestType_Main] = 0,
    [__eQuestType_Sub] = 0,
    [__eQuestType_Repeat] = 0,
    [__eQuestType_Adventure] = 0,
    [__eQuestType_BaseLife] = 0,
    [__eQuestType_OceanLife] = 0,
    [__eQuestType_CraftLife] = 0,
    [__eQuestType_Contents] = 0,
    [__eQuestType_Event] = 0,
    [__eQuestType_Guild] = 0,
    [__eQuestType_DirectAccept] = 0,
    [__eQuestType_Sudden] = 0,
    [__eQuestType_SeasonPass] = 0,
    [__eQuestType_GrowthPass] = 0,
    [__eQuestType_DirectClear] = 0,
    [__eQuestType_Journal] = 0
  }
end
function PaGlobal_Quest_All:makeProgressGroup(questGroupIndex)
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local questGroupInfo = questListInfo:getQuestGroupAt(questGroupIndex)
  if true == questGroupInfo:isGroupQuest() then
    local questCount = questGroupInfo:getQuestCount()
    local startIdx = 0
    if 1 == questCount then
      local uiQuestInfo = questGroupInfo:getQuestAt(startIdx)
      if uiQuestInfo:isNormalQuest() == true then
        if uiQuestInfo:isHaveBackEndData() == true then
          local dataRegionIdx = uiQuestInfo:getQuestRegion()
          local questType = uiQuestInfo:getQuestType()
          local regionIdx = self._questArrayRegionCount[dataRegionIdx]
          local typeIdx = self._questArrayTypeCount[questType]
          self._questSortArrayRegion[dataRegionIdx][regionIdx] = {
            questRegion = dataRegionIdx,
            questType = uiQuestInfo:getQuestType(),
            questTitle = uiQuestInfo:getTitle(),
            groupNo = uiQuestInfo:getQuestNo()._group,
            questNo = uiQuestInfo:getQuestNo()._quest,
            posCount = uiQuestInfo:getQuestPositionCount(),
            conditionComp = uiQuestInfo:isSatisfied(),
            completeCount = 0,
            isShowWidget = questGroupInfo:isCheckShow(),
            isCleared = true,
            isNext = false,
            isGroupQuest = true,
            groupIdx = questGroupIndex,
            groupCount = questCount,
            resetTime = uiQuestInfo:getResetTime(),
            repeatTime = uiQuestInfo:getRepeatTime()
          }
          self._questSortArrayType[questType][typeIdx] = {
            questRegion = dataRegionIdx,
            questType = uiQuestInfo:getQuestType(),
            questTitle = uiQuestInfo:getTitle(),
            groupNo = uiQuestInfo:getQuestNo()._group,
            questNo = uiQuestInfo:getQuestNo()._quest,
            posCount = uiQuestInfo:getQuestPositionCount(),
            conditionComp = uiQuestInfo:isSatisfied(),
            completeCount = 0,
            isShowWidget = questGroupInfo:isCheckShow(),
            isCleared = true,
            isNext = false,
            isGroupQuest = true,
            groupIdx = questGroupIndex,
            groupCount = questCount,
            resetTime = uiQuestInfo:getResetTime(),
            repeatTime = uiQuestInfo:getRepeatTime()
          }
          self._questArrayRegionCount[dataRegionIdx] = self._questArrayRegionCount[dataRegionIdx] + 1
          self._questArrayTypeCount[questType] = self._questArrayTypeCount[questType] + 1
        else
          self:pushLoadingData(self._TABTYPE.PROGRESS, 9999, uiQuestInfo)
        end
      end
    elseif questCount >= 2 then
      startIdx = questCount - 2
    end
    for questIdx = startIdx, questCount - 1 do
      local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
      if true == uiQuestInfo:isNormalQuest() then
        if uiQuestInfo:isHaveBackEndData() == true then
          local dataRegionIdx = uiQuestInfo:getQuestRegion()
          local questType = uiQuestInfo:getQuestType()
          local regionIdx = self._questArrayRegionCount[dataRegionIdx]
          local typeIdx = self._questArrayTypeCount[questType]
          if dataRegionIdx > CppEnums.QuestRegionType.eQuestRegionType_Count or dataRegionIdx < CppEnums.QuestRegionType.eQuestRegionType_None then
            dataRegionIdx = CppEnums.QuestRegionType.eQuestRegionType_None
          end
          self._questSortArrayRegion[dataRegionIdx][regionIdx] = {
            questRegion = dataRegionIdx,
            questType = uiQuestInfo:getQuestType(),
            questTitle = uiQuestInfo:getTitle(),
            groupNo = uiQuestInfo:getQuestNo()._group,
            questNo = uiQuestInfo:getQuestNo()._quest,
            posCount = uiQuestInfo:getQuestPositionCount(),
            conditionComp = uiQuestInfo:isSatisfied(),
            completeCount = questIdx + 1,
            isShowWidget = questGroupInfo:isCheckShow(),
            isCleared = uiQuestInfo._isCleared,
            isNext = not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing,
            isGroupQuest = true,
            groupIdx = questGroupIndex,
            groupCount = questCount,
            resetTime = uiQuestInfo:getResetTime(),
            repeatTime = uiQuestInfo:getRepeatTime()
          }
          self._questSortArrayType[questType][typeIdx] = {
            questRegion = dataRegionIdx,
            questType = uiQuestInfo:getQuestType(),
            questTitle = uiQuestInfo:getTitle(),
            groupNo = uiQuestInfo:getQuestNo()._group,
            questNo = uiQuestInfo:getQuestNo()._quest,
            posCount = uiQuestInfo:getQuestPositionCount(),
            conditionComp = uiQuestInfo:isSatisfied(),
            completeCount = questIdx + 1,
            isShowWidget = questGroupInfo:isCheckShow(),
            isCleared = uiQuestInfo._isCleared,
            isNext = not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing,
            isGroupQuest = true,
            groupIdx = questGroupIndex,
            groupCount = questCount,
            resetTime = uiQuestInfo:getResetTime(),
            repeatTime = uiQuestInfo:getRepeatTime()
          }
          self._questArrayRegionCount[dataRegionIdx] = self._questArrayRegionCount[dataRegionIdx] + 1
          self._questArrayTypeCount[questType] = self._questArrayTypeCount[questType] + 1
          if true == uiQuestInfo._isProgressing then
            self._progressQuestCount = self._progressQuestCount + 1
            self._questArrayRegionProgressCount[dataRegionIdx] = self._questArrayRegionProgressCount[dataRegionIdx] + 1
            self._questArrayTypeProgressCount[questType] = self._questArrayTypeProgressCount[questType] + 1
          end
        else
          self:pushLoadingData(self._TABTYPE.PROGRESS, 9999, uiQuestInfo)
        end
      end
    end
  else
    local uiQuestInfo = questGroupInfo:getQuestAt(0)
    if true == uiQuestInfo:isNormalQuest() then
      if uiQuestInfo:isHaveBackEndData() == true then
        local dataRegionIdx = uiQuestInfo:getQuestRegion()
        local questType = uiQuestInfo:getQuestType()
        local regionIdx = self._questArrayRegionCount[dataRegionIdx]
        local typeIdx = self._questArrayTypeCount[questType]
        if dataRegionIdx > CppEnums.QuestRegionType.eQuestRegionType_Count or dataRegionIdx < CppEnums.QuestRegionType.eQuestRegionType_None then
          dataRegionIdx = CppEnums.QuestRegionType.eQuestRegionType_None
        end
        self._questSortArrayRegion[dataRegionIdx][regionIdx] = {
          questRegion = dataRegionIdx,
          questType = uiQuestInfo:getQuestType(),
          questTitle = uiQuestInfo:getTitle(),
          groupNo = uiQuestInfo:getQuestNo()._group,
          questNo = uiQuestInfo:getQuestNo()._quest,
          conditionComp = uiQuestInfo:isSatisfied(),
          completeCount = 0,
          isShowWidget = questGroupInfo:isCheckShow(),
          isCleared = uiQuestInfo._isCleared,
          isNext = false,
          isGroupQuest = false,
          groupIdx = questGroupIndex,
          groupCount = 1,
          resetTime = uiQuestInfo:getResetTime(),
          repeatTime = uiQuestInfo:getRepeatTime(),
          isSubQuest = false
        }
        self._questSortArrayType[questType][typeIdx] = {
          questRegion = dataRegionIdx,
          questType = uiQuestInfo:getQuestType(),
          questTitle = uiQuestInfo:getTitle(),
          groupNo = uiQuestInfo:getQuestNo()._group,
          questNo = uiQuestInfo:getQuestNo()._quest,
          conditionComp = uiQuestInfo:isSatisfied(),
          completeCount = 0,
          isShowWidget = questGroupInfo:isCheckShow(),
          isCleared = uiQuestInfo._isCleared,
          isNext = false,
          isGroupQuest = false,
          groupIdx = questGroupIndex,
          groupCount = 1,
          resetTime = uiQuestInfo:getResetTime(),
          repeatTime = uiQuestInfo:getRepeatTime(),
          isSubQuest = false
        }
        self._questArrayRegionCount[dataRegionIdx] = self._questArrayRegionCount[dataRegionIdx] + 1
        self._questArrayTypeCount[questType] = self._questArrayTypeCount[questType] + 1
        if true == uiQuestInfo._isProgressing then
          self._progressQuestCount = self._progressQuestCount + 1
          self._questArrayRegionProgressCount[dataRegionIdx] = self._questArrayRegionProgressCount[dataRegionIdx] + 1
          self._questArrayTypeProgressCount[questType] = self._questArrayTypeProgressCount[questType] + 1
        end
      else
        self:pushLoadingData(self._TABTYPE.PROGRESS, 9999, uiQuestInfo)
      end
    end
  end
end
function PaGlobal_Quest_All:setProgressGroup()
  local arrayIdx = 1
  local emptyHide = self._ui.chk_emptyGroupHide:IsCheck()
  self._useArray = {}
  if self._ui.radio_questTerritory:IsCheck() == true then
    local regionCount = CppEnums.QuestRegionType.eQuestRegionType_Count - 1
    for index = 0, regionCount do
      do
        local regionIdx = self._questArrayRegionSort[index]
        local count = self._questArrayRegionCount[regionIdx]
        local function doInsertData()
          if not self._isContentsEnableMedia and CppEnums.QuestRegionType.eQuestRegionType_Media - 1 == index then
            return
          end
          if not self._isContentsEnableValencia and CppEnums.QuestRegionType.eQuestRegionType_Valencia - 1 == index then
            return
          end
          if not self._isContentsEnableKamasilvia and CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia - 1 == index then
            return
          end
          if not self._isContentsEnableDragan and CppEnums.QuestRegionType.eQuestRegionType_Drigan - 1 == index then
            return
          end
          if false == _ContentsGroup_Othilita and CppEnums.QuestRegionType.eQuestRegionType_Odilita - 1 == index then
            return
          end
          if false == _ContentsGroup_MountainOfEternalWinter and CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter - 1 == index then
            return
          end
          if false == _ContentsGroup_ProjectAbyssOne and CppEnums.QuestRegionType.eQuestRegionType_AbyssOne - 1 == index then
            return
          end
          if false == _ContentsGroup_MorningLand and CppEnums.QuestRegionType.eQuestRegionType_MorningLand - 1 == index then
            return
          end
          if false == _ContentsGroup_Ulukita and CppEnums.QuestRegionType.eQeustRegionType_Ulukita - 1 == index then
            return
          end
          self._useArray[arrayIdx] = {
            isQuest = false,
            isNext = false,
            isCleared = false,
            questRegion = regionIdx,
            questType = nil,
            title = self._regionString[regionIdx],
            groupNo = nil,
            questNo = nil,
            conditionComp = nil,
            isShowWidget = nil,
            groupIdx = nil,
            isGroupQuest = nil,
            groupCount = nil,
            resetTime = nil,
            repeatTime = nil,
            isSubQuest = nil
          }
          arrayIdx = arrayIdx + 1
          if self._regionOpen[regionIdx].isOpen == true and count > 0 then
            if self:isExistLoadingDataAnyOne() == true then
              self._regionOpen[regionIdx].isOpen = false
              self._regionOpen[regionIdx].isLoading = true
              self:pushProgressQuestLoadingGroup(regionIdx)
            else
              for questIdx = 0, count - 1 do
                self._useArray[arrayIdx] = {
                  isQuest = true,
                  isNext = self._questSortArrayRegion[regionIdx][questIdx].isNext,
                  isCleared = self._questSortArrayRegion[regionIdx][questIdx].isCleared,
                  questRegion = self._questSortArrayRegion[regionIdx][questIdx].questRegion,
                  questType = self._questSortArrayRegion[regionIdx][questIdx].questType,
                  title = self._questSortArrayRegion[regionIdx][questIdx].questTitle,
                  groupNo = self._questSortArrayRegion[regionIdx][questIdx].groupNo,
                  questNo = self._questSortArrayRegion[regionIdx][questIdx].questNo,
                  posCount = self._questSortArrayRegion[regionIdx][questIdx].posCount,
                  conditionComp = self._questSortArrayRegion[regionIdx][questIdx].conditionComp,
                  completeCount = self._questSortArrayRegion[regionIdx][questIdx].completeCount,
                  isShowWidget = self._questSortArrayRegion[regionIdx][questIdx].isShowWidget,
                  groupIdx = self._questSortArrayRegion[regionIdx][questIdx].groupIdx,
                  isGroupQuest = self._questSortArrayRegion[regionIdx][questIdx].isGroupQuest,
                  groupCount = self._questSortArrayRegion[regionIdx][questIdx].groupCount,
                  resetTime = self._questSortArrayRegion[regionIdx][questIdx].resetTime,
                  repeatTime = self._questSortArrayRegion[regionIdx][questIdx].repeatTime,
                  isSubQuest = self._questSortArrayRegion[regionIdx][questIdx].isSubQuest
                }
                arrayIdx = arrayIdx + 1
              end
              self._regionOpen[regionIdx].isLoading = false
            end
          end
        end
        if true == emptyHide then
          if count > 0 then
            doInsertData()
          end
        else
          doInsertData()
        end
      end
    end
  else
    local typeCount = __eQuestType_Guild
    for typeIdx = 0, typeCount do
      do
        local count = self._questArrayTypeCount[typeIdx]
        local function doInsertData()
          self._useArray[arrayIdx] = {
            isQuest = false,
            isNext = false,
            isCleared = false,
            questRegion = nil,
            questType = typeIdx,
            title = self._typeString[typeIdx],
            groupNo = nil,
            questNo = nil,
            conditionComp = nil,
            isShowWidget = nil,
            groupIdx = nil,
            isGroupQuest = nil,
            groupCount = nil,
            resetTime = nil,
            repeatTime = nil,
            isSubQuest = nil
          }
          arrayIdx = arrayIdx + 1
          if self._typeOpen[typeIdx].isOpen == true and count > 0 then
            if self:isExistLoadingDataAnyOne() == true then
              self._typeOpen[typeIdx].isOpen = false
              self._typeOpen[typeIdx].isLoading = true
              self:pushProgressQuestLoadingGroup(typeIdx)
            else
              for questIdx = 0, count - 1 do
                self._useArray[arrayIdx] = {
                  isQuest = true,
                  isNext = self._questSortArrayType[typeIdx][questIdx].isNext,
                  isCleared = self._questSortArrayType[typeIdx][questIdx].isCleared,
                  questRegion = self._questSortArrayType[typeIdx][questIdx].questRegion,
                  questType = self._questSortArrayType[typeIdx][questIdx].questType,
                  title = self._questSortArrayType[typeIdx][questIdx].questTitle,
                  groupNo = self._questSortArrayType[typeIdx][questIdx].groupNo,
                  questNo = self._questSortArrayType[typeIdx][questIdx].questNo,
                  posCount = self._questSortArrayType[typeIdx][questIdx].posCount,
                  conditionComp = self._questSortArrayType[typeIdx][questIdx].conditionComp,
                  completeCount = self._questSortArrayType[typeIdx][questIdx].completeCount,
                  isShowWidget = self._questSortArrayType[typeIdx][questIdx].isShowWidget,
                  groupIdx = self._questSortArrayType[typeIdx][questIdx].groupIdx,
                  isGroupQuest = self._questSortArrayType[typeIdx][questIdx].isGroupQuest,
                  groupCount = self._questSortArrayType[typeIdx][questIdx].groupCount,
                  resetTime = self._questSortArrayType[typeIdx][questIdx].resetTime,
                  repeatTime = self._questSortArrayType[typeIdx][questIdx].repeatTime,
                  isSubQuest = self._questSortArrayType[typeIdx][questIdx].isSubQuest
                }
                arrayIdx = arrayIdx + 1
              end
              self._typeOpen[typeIdx].isLoading = false
            end
          end
        end
        if true == emptyHide then
          if count > 0 then
            doInsertData()
          end
        else
          doInsertData()
        end
      end
    end
  end
end
function PaGlobal_Quest_All:setRecommendGroup(questGroupCount)
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local arrayIdx = 1
  local completeHide = self._ui.chk_complteHide:IsCheck()
  self._useArray = {}
  for groupIdx = 0, questGroupCount - 1 do
    do
      local questGroupInfo = questListInfo:getRecommendationQuestGroupAt(groupIdx)
      local groupTitle = questGroupInfo:getTitle()
      local questCount = questGroupInfo:getQuestCount()
      local completeChkCount = 0
      local hideCount = 0
      local sumHideCount = 0
      local recommandCount = 0
      for chkIdx = 0, questCount - 1 do
        local uiQuestInfo = questGroupInfo:getQuestAt(chkIdx)
        if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
          local isCleared = uiQuestInfo._isCleared
          if true == isCleared then
            completeChkCount = completeChkCount + 1
          end
        else
          hideCount = hideCount + 1
        end
      end
      sumHideCount = questCount - hideCount
      local function makeRecommandArray()
        self._questArrayGroupCount[groupIdx] = 0
        self._questArrayGroupCompleteCount[groupIdx] = 0
        self._useArray[arrayIdx] = {
          isQuest = false,
          isNext = false,
          isCleared = false,
          questRegion = arrayIdx,
          questType = 8,
          title = groupTitle,
          groupNo = nil,
          questNo = nil,
          posCount = 0,
          conditionComp = nil,
          completeCount = 0,
          isShowWidget = nil,
          isGroupQuest = nil,
          groupIdx = groupIdx,
          groupCount = questCount,
          resetTime = nil,
          repeatTime = nil,
          isSubQuest = nil
        }
        arrayIdx = arrayIdx + 1
        for questIdx = 0, questCount - 1 do
          do
            local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
            if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
              local function setQuestData()
                if self._groupOpen._recommendation[groupIdx].isOpen == true then
                  if uiQuestInfo:isHaveBackEndData() == true then
                    local dataRegionIdx = uiQuestInfo:getQuestRegion()
                    if dataRegionIdx > 8 or dataRegionIdx < 0 then
                      dataRegionIdx = 0
                    end
                    self._useArray[arrayIdx] = {
                      isQuest = true,
                      isNext = not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing,
                      isCleared = uiQuestInfo._isCleared,
                      questRegion = dataRegionIdx,
                      questType = uiQuestInfo:getQuestType(),
                      title = uiQuestInfo:getTitle(),
                      groupNo = uiQuestInfo:getQuestNo()._group,
                      questNo = uiQuestInfo:getQuestNo()._quest,
                      posCount = uiQuestInfo:getQuestPositionCount(),
                      conditionComp = uiQuestInfo:isSatisfied(),
                      completeCount = 0,
                      isShowWidget = uiQuestInfo:getAcceptConditionText(),
                      isGroupQuest = true,
                      groupIdx = groupIdx,
                      groupCount = questGroupCount,
                      resetTime = uiQuestInfo:getResetTime(),
                      repeatTime = uiQuestInfo:getRepeatTime(),
                      isSubQuest = uiQuestInfo._isSubQuest
                    }
                    arrayIdx = arrayIdx + 1
                  else
                    self:pushLoadingData(self._TABTYPE.RECOMMEND, groupIdx, uiQuestInfo)
                  end
                end
                if true == uiQuestInfo._isCleared then
                  self._questArrayGroupCompleteCount[groupIdx] = self._questArrayGroupCompleteCount[groupIdx] + 1
                end
              end
              local doSetQuestData = false
              if completeHide == true then
                if uiQuestInfo._isCleared == false then
                  doSetQuestData = true
                end
              else
                doSetQuestData = true
              end
              if doSetQuestData == true then
                setQuestData()
                recommandCount = recommandCount + 1
              end
            end
          end
        end
        self._questArrayGroupCount[groupIdx] = recommandCount
        if self:isExistLoadingDataAnyOne() == true and self._groupOpen._recommendation[groupIdx].isOpen == true then
          self._groupOpen._recommendation[groupIdx].isOpen = false
          self._groupOpen._recommendation[groupIdx].isLoading = true
        else
          self._groupOpen._recommendation[groupIdx].isLoading = false
        end
      end
      if completeChkCount < sumHideCount then
        makeRecommandArray()
      elseif not completeHide and 0 ~= sumHideCount then
        makeRecommandArray()
      end
    end
  end
end
function PaGlobal_Quest_All:setRepeatGroup(questGroupCount)
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local arrayIdx = 1
  local completeHide = self._ui.chk_complteHide:IsCheck()
  self._useArray = {}
  for groupIdx = 0, questGroupCount - 1 do
    do
      local questGroupInfo = questListInfo:getRepetitionQuestGroupAt(groupIdx)
      local groupTitle = questGroupInfo:getTitle()
      local questCount = questGroupInfo:getQuestCount()
      local completeChkCount = 0
      local hideCount = 0
      local sumHideCount = 0
      local repetiveCount = 0
      for chkIdx = 0, questCount - 1 do
        local uiQuestInfo = questGroupInfo:getQuestAt(chkIdx)
        if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
          local isCleared = uiQuestInfo._isCleared
          if true == isCleared then
            completeChkCount = completeChkCount + 1
          end
        else
          hideCount = hideCount + 1
        end
      end
      sumHideCount = questCount - hideCount
      local function makeRepetitiveArray()
        self._questArrayGroupCount[groupIdx] = 0
        self._questArrayGroupCompleteCount[groupIdx] = 0
        self._useArray[arrayIdx] = {
          isQuest = false,
          isNext = false,
          isCleared = false,
          questRegion = arrayIdx,
          questType = 8,
          title = groupTitle,
          groupNo = nil,
          questNo = nil,
          posCount = 0,
          conditionComp = nil,
          completeCount = 0,
          isShowWidget = nil,
          isGroupQuest = nil,
          groupIdx = groupIdx,
          groupCount = questCount,
          resetTime = nil,
          repeatTime = nil,
          isSubQuest = nil
        }
        arrayIdx = arrayIdx + 1
        for questIdx = 0, questCount - 1 do
          do
            local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
            if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
              local function setQuestData()
                if self._groupOpen._repetitive[groupIdx].isOpen == true then
                  if uiQuestInfo:isHaveBackEndData() == true then
                    local questInfoResetTime = uiQuestInfo:getResetTime()
                    local questInfoRepeatTime = uiQuestInfo:getRepeatTime()
                    local questInfoIsNext = not uiQuestInfo._isProgressing and not uiQuestInfo._isCleared
                    local questInfoTitle = uiQuestInfo:getTitle()
                    local questInfoIsCleared = uiQuestInfo._isCleared
                    if true == uiQuestInfo._isCleared and questInfoRepeatTime > 0 then
                      if 0 < Int64toInt32(getLeftSecond_TTime64(questInfoResetTime)) then
                        questInfoIsNext = false
                      else
                        questInfoIsCleared = false
                        questInfoIsNext = true
                      end
                    end
                    if not completeHide or questInfoRepeatTime > 0 or not questInfoIsCleared then
                      local dataRegionIdx = uiQuestInfo:getQuestRegion()
                      if dataRegionIdx > 8 or dataRegionIdx < 0 then
                        dataRegionIdx = 0
                      end
                      self._useArray[arrayIdx] = {
                        isQuest = true,
                        isNext = questInfoIsNext,
                        isCleared = questInfoIsCleared,
                        questRegion = dataRegionIdx,
                        questType = uiQuestInfo:getQuestType(),
                        title = questInfoTitle,
                        groupNo = uiQuestInfo:getQuestNo()._group,
                        questNo = uiQuestInfo:getQuestNo()._quest,
                        posCount = uiQuestInfo:getQuestPositionCount(),
                        conditionComp = uiQuestInfo:isSatisfied(),
                        completeCount = 0,
                        isShowWidget = uiQuestInfo:getAcceptConditionText(),
                        isGroupQuest = true,
                        groupIdx = groupIdx,
                        groupCount = questGroupCount,
                        resetTime = questInfoResetTime,
                        repeatTime = questInfoRepeatTime,
                        isSubQuest = uiQuestInfo._isSubQuest
                      }
                      arrayIdx = arrayIdx + 1
                    end
                  else
                    self:pushLoadingData(self._TABTYPE.REPEAT, groupIdx, uiQuestInfo)
                  end
                end
                if true == uiQuestInfo._isCleared then
                  self._questArrayGroupCompleteCount[groupIdx] = self._questArrayGroupCompleteCount[groupIdx] + 1
                end
              end
              setQuestData()
              repetiveCount = repetiveCount + 1
            end
          end
        end
        self._questArrayGroupCount[groupIdx] = repetiveCount
        if self:isExistLoadingDataAnyOne() == true and self._groupOpen._repetitive[groupIdx].isOpen == true then
          self._groupOpen._repetitive[groupIdx].isOpen = false
          self._groupOpen._repetitive[groupIdx].isLoading = true
        else
          self._groupOpen._repetitive[groupIdx].isLoading = false
        end
      end
      if 0 ~= sumHideCount then
        makeRepetitiveArray()
      end
    end
  end
end
function PaGlobal_Quest_All:setNewGroup(questGroupCount)
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local arrayIdx = 1
  local completeHide = self._ui.chk_complteHide:IsCheck()
  self._useArray = {}
  for groupIdx = 0, questGroupCount - 1 do
    do
      local questGroupInfo = questListInfo:getNewQuestGroupAt(groupIdx)
      local groupTitle = questGroupInfo:getTitle()
      local questCount = questGroupInfo:getQuestCount()
      local completeChkCount = 0
      local hideCount = 0
      local sumHideCount = 0
      local newCount = 0
      local isShowQuestFromTime = questGroupInfo:checkShowQuestFromTime()
      if true == isShowQuestFromTime then
        for chkIdx = 0, questCount - 1 do
          local uiQuestInfo = questGroupInfo:getQuestAt(chkIdx)
          if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
            local isCleared = uiQuestInfo._isCleared
            if true == isCleared then
              completeChkCount = completeChkCount + 1
            end
          else
            hideCount = hideCount + 1
          end
        end
        sumHideCount = questCount - hideCount
        local function makeNewArray()
          self._questArrayGroupCount[groupIdx] = 0
          self._questArrayGroupCompleteCount[groupIdx] = 0
          self._useArray[arrayIdx] = {
            isQuest = false,
            isNext = false,
            isCleared = false,
            questRegion = arrayIdx,
            questType = 8,
            title = groupTitle,
            groupNo = nil,
            questNo = nil,
            posCount = 0,
            conditionComp = nil,
            completeCount = 0,
            isShowWidget = nil,
            isGroupQuest = nil,
            groupIdx = groupIdx,
            groupCount = questCount,
            resetTime = nil,
            repeatTime = nil,
            isSubQuest = nil
          }
          arrayIdx = arrayIdx + 1
          for questIdx = 0, questCount - 1 do
            do
              local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
              if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
                local function setQuestData()
                  if self._groupOpen._new[groupIdx].isOpen == true then
                    if uiQuestInfo:isHaveBackEndData() == true then
                      local questInfoResetTime = uiQuestInfo:getResetTime()
                      local questInfoRepeatTime = uiQuestInfo:getRepeatTime()
                      local questInfoIsNext = not uiQuestInfo._isProgressing and not uiQuestInfo._isCleared
                      local questInfoTitle = uiQuestInfo:getTitle()
                      local questInfoIsCleared = uiQuestInfo._isCleared
                      if uiQuestInfo._isCleared and questInfoRepeatTime > 0 then
                        if 0 < Int64toInt32(getLeftSecond_TTime64(questInfoResetTime)) then
                          questInfoIsNext = false
                        else
                          questInfoIsCleared = false
                          questInfoIsNext = true
                        end
                      end
                      if not completeHide or questInfoRepeatTime > 0 or not questInfoIsCleared then
                        local dataRegionIdx = uiQuestInfo:getQuestRegion()
                        if dataRegionIdx > 8 or dataRegionIdx < 0 then
                          dataRegionIdx = 0
                        end
                        self._useArray[arrayIdx] = {
                          isQuest = true,
                          isNext = questInfoIsNext,
                          isCleared = questInfoIsCleared,
                          questRegion = dataRegionIdx,
                          questType = uiQuestInfo:getQuestType(),
                          title = questInfoTitle,
                          groupNo = uiQuestInfo:getQuestNo()._group,
                          questNo = uiQuestInfo:getQuestNo()._quest,
                          posCount = uiQuestInfo:getQuestPositionCount(),
                          conditionComp = uiQuestInfo:isSatisfied(),
                          completeCount = 0,
                          isShowWidget = uiQuestInfo:getAcceptConditionText(),
                          isGroupQuest = true,
                          groupIdx = groupIdx,
                          groupCount = questGroupCount,
                          resetTime = questInfoResetTime,
                          repeatTime = questInfoRepeatTime,
                          isSubQuest = uiQuestInfo._isSubQuest
                        }
                        arrayIdx = arrayIdx + 1
                      end
                    else
                      self:pushLoadingData(self._TABTYPE.NEW, groupIdx, uiQuestInfo)
                    end
                  end
                  if true == uiQuestInfo._isCleared then
                    self._questArrayGroupCompleteCount[groupIdx] = self._questArrayGroupCompleteCount[groupIdx] + 1
                  end
                end
                setQuestData()
                newCount = newCount + 1
              end
            end
          end
          self._questArrayGroupCount[groupIdx] = newCount
          if self:isExistLoadingDataAnyOne() == true and self._groupOpen._new[groupIdx].isOpen == true then
            self._groupOpen._new[groupIdx].isOpen = false
            self._groupOpen._new[groupIdx].isLoading = true
          else
            self._groupOpen._new[groupIdx].isLoading = false
          end
        end
        if 0 ~= sumHideCount then
          makeNewArray()
        end
      end
    end
  end
end
function PaGlobal_Quest_All:setMainGroup(questGroupCount)
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local arrayIdx = 1
  local completeHide = self._ui.chk_complteHide:IsCheck()
  self._useArray = {}
  for groupIdx = 0, questGroupCount - 1 do
    do
      local questGroupInfo = questListInfo:getMainQuestGroupAt(groupIdx)
      local groupTitle = questGroupInfo:getTitle()
      local questCount = questGroupInfo:getQuestCount()
      local completeChkCount = 0
      local hideCount = 0
      local sumHideCount = 0
      local mainCount = 0
      if true == PaGlobal_questBranch_IsLeafCleared() then
        self._ui.btn_questBranch:SetShow(true)
      else
        self._ui.btn_questBranch:SetShow(false)
      end
      for chkIdx = 0, questCount - 1 do
        local uiQuestInfo = questGroupInfo:getQuestAt(chkIdx)
        if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
          local isCleared = uiQuestInfo._isCleared
          if true == isCleared then
            completeChkCount = completeChkCount + 1
          end
        else
          hideCount = hideCount + 1
        end
      end
      sumHideCount = questCount - hideCount
      local function makeMainArray()
        self._questArrayGroupCount[groupIdx] = 0
        self._questArrayGroupCompleteCount[groupIdx] = 0
        self._useArray[arrayIdx] = {
          isQuest = false,
          isNext = false,
          isCleared = false,
          questRegion = arrayIdx,
          questType = 8,
          title = groupTitle,
          groupNo = nil,
          questNo = nil,
          posCount = 0,
          conditionComp = nil,
          completeCount = 0,
          isShowWidget = nil,
          isGroupQuest = nil,
          groupIdx = groupIdx,
          groupCount = questCount,
          resetTime = nil,
          repeatTime = nil,
          isSubQuest = nil
        }
        arrayIdx = arrayIdx + 1
        for questIdx = 0, questCount - 1 do
          do
            local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
            if false == uiQuestInfo:checkHideCondition() and true == uiQuestInfo:checkVisibleCondition() then
              local function setQuestData()
                if self._groupOpen._main[groupIdx].isOpen == true then
                  if uiQuestInfo:isHaveBackEndData() == true then
                    local dataRegionIdx = uiQuestInfo:getQuestRegion()
                    if dataRegionIdx > 8 or dataRegionIdx < 0 then
                      dataRegionIdx = 0
                    end
                    self._useArray[arrayIdx] = {
                      isQuest = true,
                      isNext = not uiQuestInfo._isCleared and not uiQuestInfo._isProgressing,
                      isCleared = uiQuestInfo._isCleared,
                      questRegion = dataRegionIdx,
                      questType = uiQuestInfo:getQuestType(),
                      title = uiQuestInfo:getTitle(),
                      groupNo = uiQuestInfo:getQuestNo()._group,
                      questNo = uiQuestInfo:getQuestNo()._quest,
                      posCount = uiQuestInfo:getQuestPositionCount(),
                      conditionComp = uiQuestInfo:isSatisfied(),
                      completeCount = 0,
                      isShowWidget = uiQuestInfo:getAcceptConditionText(),
                      isGroupQuest = true,
                      groupIdx = groupIdx,
                      groupCount = questGroupCount,
                      resetTime = uiQuestInfo:getResetTime(),
                      repeatTime = uiQuestInfo:getRepeatTime(),
                      isSubQuest = uiQuestInfo._isSubQuest
                    }
                    arrayIdx = arrayIdx + 1
                  else
                    self:pushLoadingData(self._TABTYPE.MAIN, groupIdx, uiQuestInfo)
                  end
                end
                if true == uiQuestInfo._isCleared then
                  self._questArrayGroupCompleteCount[groupIdx] = self._questArrayGroupCompleteCount[groupIdx] + 1
                end
              end
              local doSetQuestData = false
              if completeHide == true then
                if uiQuestInfo._isCleared == false then
                  doSetQuestData = true
                end
              else
                doSetQuestData = true
              end
              if doSetQuestData == true then
                setQuestData()
                mainCount = mainCount + 1
              end
            end
          end
        end
        self._questArrayGroupCount[groupIdx] = mainCount
        if self:isExistLoadingDataAnyOne() == true and self._groupOpen._main[groupIdx].isOpen == true then
          self._groupOpen._main[groupIdx].isOpen = false
          self._groupOpen._main[groupIdx].isLoading = true
        else
          self._groupOpen._main[groupIdx].isLoading = false
        end
      end
      if completeChkCount < sumHideCount then
        makeMainArray()
      elseif not completeHide and 0 ~= sumHideCount then
        makeMainArray()
      end
    end
  end
end
function PaGlobal_Quest_All:questListUpdate()
  for uiIdx = 0, self._config.slotMaxCount - 1 do
    self._uiPool.groupTitle[uiIdx].bg:SetShow(false)
    self._uiPool.listMain[uiIdx].bg:SetShow(false)
  end
  self._listCount = #self._useArray
  UIScroll.SetButtonSize(self._ui._listScroll.stc_bg, self._config.slotMaxCount, self._listCount)
  local uiCount = 0
  for questIdx = self._startSlotIndex, self._listCount do
    if uiCount > self._config.slotMaxCount - 1 then
      break
    end
    if 0 < self._listCount then
      local countBase = 0
      if self._TABTYPE.PROGRESS == self._currentTab then
        if not self._ui.radio_questTerritory:IsCheck() then
          countBase = self._questArrayTypeProgressCount[self._useArray[questIdx].questType]
        else
          countBase = self._questArrayRegionProgressCount[self._useArray[questIdx].questRegion]
        end
      else
        countBase = self._questArrayGroupCompleteCount[self._useArray[questIdx].groupIdx] .. "/" .. self._questArrayGroupCount[self._useArray[questIdx].groupIdx]
      end
      if false == self._useArray[questIdx].isQuest then
        local isOpenTypeCheck = 0
        local typeKey = 0
        local clearedQuestCnt = 0
        local totalQuestCnt = 0
        local progressRate = 0
        local iconType = 0
        local isBarExpand = false
        local expandCheckKey = 0
        local isLoading = false
        self._uiPool.groupTitle[uiCount].loading:SetSpanSize(50, 0)
        self._uiPool.groupTitle[uiCount].completePercent:SetShow(false)
        if self._TABTYPE.PROGRESS == self._currentTab then
          if true == self._ui.radio_questTerritory:IsCheck() then
            isOpenTypeCheck = 0
            typeKey = self._useArray[questIdx].questRegion
            clearedQuestCnt = ToClient_GetClearedQuestCountByQuestRegion(typeKey)
            totalQuestCnt = ToClient_GetTotalQuestCountByQuestRegion(typeKey)
            iconType = __eQuestType_Count
            isBarExpand = self._regionOpen[typeKey].isOpen
            isLoading = self._regionOpen[typeKey].isLoading
          else
            isOpenTypeCheck = 1
            typeKey = self._useArray[questIdx].questType
            clearedQuestCnt = ToClient_GetClearedQuestCountByQuestType(typeKey)
            totalQuestCnt = ToClient_GetTotalQuestCountByQuestType(typeKey)
            iconType = typeKey
            isBarExpand = self._typeOpen[typeKey].isOpen
            isLoading = self._typeOpen[typeKey].isLoading
          end
          if 0 ~= clearedQuestCnt or 0 ~= totalQuestCnt then
            progressRate = clearedQuestCnt / totalQuestCnt * 100
          end
          self._uiPool.groupTitle[uiCount].completePercent:SetShow(true)
          self._uiPool.groupTitle[uiCount].completePercent:SetText(string.format("%.2f", progressRate) .. "%")
          self._uiPool.groupTitle[uiCount].loading:SetSpanSize(self._uiPool.groupTitle[uiCount].completePercent:GetSpanSize().x + self._uiPool.groupTitle[uiCount].completePercent:GetSizeX() + 15, 0)
        elseif self._TABTYPE.RECOMMEND == self._currentTab then
          isOpenTypeCheck = 2
          iconType = __eQuestType_Count
          typeKey = self._useArray[questIdx].groupIdx
          isBarExpand = self._groupOpen._recommendation[typeKey].isOpen
          isLoading = self._groupOpen._recommendation[typeKey].isLoading
        elseif self._TABTYPE.REPEAT == self._currentTab then
          isOpenTypeCheck = 3
          iconType = __eQuestType_Count
          typeKey = self._useArray[questIdx].groupIdx
          isBarExpand = self._groupOpen._repetitive[typeKey].isOpen
          isLoading = self._groupOpen._repetitive[typeKey].isLoading
        elseif self._TABTYPE.MAIN == self._currentTab then
          isOpenTypeCheck = 4
          iconType = __eQuestType_Count
          typeKey = self._useArray[questIdx].groupIdx
          isBarExpand = self._groupOpen._main[typeKey].isOpen
          isLoading = self._groupOpen._main[typeKey].isLoading
        elseif self._TABTYPE.NEW == self._currentTab then
          isOpenTypeCheck = 5
          iconType = __eQuestType_Count
          typeKey = self._useArray[questIdx].groupIdx
          isBarExpand = self._groupOpen._new[typeKey].isOpen
          isLoading = self._groupOpen._new[typeKey].isLoading
        end
        if iconType == __eQuestType_Count then
          self._uiPool.groupTitle[uiCount].typeIcon:ChangeTextureInfoNameAsync("Combine/Icon/Combine_Basic_Icon_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self._uiPool.groupTitle[uiCount].typeIcon, 293, 135, 306, 148)
          self._uiPool.groupTitle[uiCount].typeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          self._uiPool.groupTitle[uiCount].typeIcon:setRenderTexture(self._uiPool.groupTitle[uiCount].typeIcon:getBaseTexture())
          self._uiPool.groupTitle[uiCount].typeIcon:SetSize(15, 15)
          self._uiPool.groupTitle[uiCount].typeIcon:SetSpanSize(17, 0)
        else
          ToClient_ChangeQuestIconByQuestType(self._uiPool.groupTitle[uiCount].typeIcon, iconType)
          self._uiPool.groupTitle[uiCount].typeIcon:SetSize(40, 40)
          self._uiPool.groupTitle[uiCount].typeIcon:SetSpanSize(10, 0)
        end
        self._uiPool.groupTitle[uiCount].bg:SetShow(true)
        self._uiPool.groupTitle[uiCount].bg:SetCheck(isBarExpand)
        self._uiPool.groupTitle[uiCount].name:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_GROUPTITLE", "title", self._useArray[questIdx].title, "count", countBase))
        self._uiPool.groupTitle[uiCount].bg:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_GroupTitleSimpleTooltip(true, " .. questIdx .. ", " .. uiCount .. ", " .. tostring(countBase) .. ")")
        self._uiPool.groupTitle[uiCount].bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_GroupTitleSimpleTooltip(false)")
        self._uiPool.groupTitle[uiCount].bg:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GroupTitleUpdateExpand( " .. isOpenTypeCheck .. ", " .. typeKey .. ", " .. uiCount .. " )")
        self._uiPool.groupTitle[uiCount].loading:SetShow(isLoading)
      else
        local questListInfo, questGroupInfo, isGroup, groupTotalCount
        local nextCheck = 0
        self._uiPool.listMain[uiCount].bg:SetShow(true)
        self._uiPool.listMain[uiCount].showBtn:SetShow(false)
        self._uiPool.listMain[uiCount].btnAuto:SetShow(false)
        self._uiPool.listMain[uiCount].btnNavi:SetShow(false)
        self._uiPool.listMain[uiCount].btnGiveUp:SetShow(false)
        self._uiPool.listMain[uiCount].completeCount:SetShow(false)
        self._uiPool.listMain[uiCount].remainTime:SetShow(false)
        self._uiPool.listMain[uiCount].name:SetIgnore(false)
        self._uiPool.listMain[uiCount].remainTime:SetIgnore(false)
        self._uiPool.listMain[uiCount].showBtn:SetCheck(false)
        self._uiPool.listMain[uiCount].showBtn:addInputEvent("Mouse_LUp", "")
        self._uiPool.listMain[uiCount].btnAuto:addInputEvent("Mouse_LUp", "")
        self._uiPool.listMain[uiCount].btnNavi:addInputEvent("Mouse_LUp", "")
        self._uiPool.listMain[uiCount].btnGiveUp:addInputEvent("Mouse_LUp", "")
        ToClient_ChangeQuestIconByQuestType(self._uiPool.listMain[uiCount].typeIcon, self._useArray[questIdx].questType)
        if self._TABTYPE.PROGRESS == self._currentTab then
          questListInfo = ToClient_GetQuestList()
          questGroupInfo = questListInfo:getQuestGroupAt(self._useArray[questIdx].groupIdx)
          isGroup = questGroupInfo:isGroupQuest()
          if true == isGroup then
            groupTotalCount = questGroupInfo:getTotalQuestCount()
          end
        end
        if not self._useArray[questIdx].isNext then
          local questInfo = questList_getQuestStatic(self._useArray[questIdx].groupNo, self._useArray[questIdx].questNo)
          local posCount = questInfo:getQuestPositionCount()
          self._uiPool.listMain[uiCount].typeIcon:SetShow(true)
          self._uiPool.listMain[uiCount].typeIcon:SetSpanSize(40, 0)
          self._uiPool.listMain[uiCount].name:SetSpanSize(75, 0)
          if self._TABTYPE.PROGRESS == self._currentTab then
            self._uiPool.listMain[uiCount].showBtn:SetShow(false == self._isConsole)
            self._uiPool.listMain[uiCount].showBtn:SetCheck(self._useArray[questIdx].isShowWidget)
            local showCheckKey = self._useArray[questIdx].questNo
            if true == isGroup then
              showCheckKey = 0
            end
            self._uiPool.listMain[uiCount].showBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_QuestShowCheck(" .. self._useArray[questIdx].groupNo .. "," .. showCheckKey .. ")")
          end
          if true == self._useArray[questIdx].isCleared then
            local groupTitle = self._useArray[questIdx].title
            local stringColor = Defines.Color.C_FF888888
            if self._TABTYPE.PROGRESS == self._currentTab and true == isGroup then
              local replaceTitle = questGroupInfo:getTitle() .. "(" .. self._useArray[questIdx].completeCount + 1 .. "/" .. groupTotalCount .. ")"
              groupTitle = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWIDGET_GROUPTITLEINFO", "titleinfo", replaceTitle)
              stringColor = Defines.Color.C_FFEEBA3E
            end
            self._uiPool.listMain[uiCount].name:SetTextMode(__eTextMode_LimitText)
            self._uiPool.listMain[uiCount].name:SetText(groupTitle)
            self._uiPool.listMain[uiCount].name:SetIgnore(false)
            self._uiPool.listMain[uiCount].name:SetFontColor(stringColor)
            if 0 < Int64toInt32(getLeftSecond_TTime64(self._useArray[questIdx].resetTime)) then
              local remainTime = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTINFO_REMAINTIME", "time", convertStringFromDatetime(getLeftSecond_TTime64(self._useArray[questIdx].resetTime)))
              self._uiPool.listMain[uiCount].remainTime:SetShow(true)
              self._uiPool.listMain[uiCount].remainTime:SetText(remainTime)
            end
          else
            local groupTitle = self._useArray[questIdx].title
            if __eQuestType_BlackSpirit == self._useArray[questIdx].questType then
              self._uiPool.listMain[uiCount].name:SetFontColor(4290209076)
            else
              self._uiPool.listMain[uiCount].name:SetFontColor(4287405590)
            end
            if self._TABTYPE.PROGRESS == self._currentTab and true == isGroup then
              local beforIdx = uiCount - 1
              self._uiPool.listMain[uiCount].typeIcon:SetSpanSize(70, 0)
              self._uiPool.listMain[uiCount].name:SetSpanSize(100, 0)
              self._uiPool.listMain[uiCount].showBtn:SetShow(false)
              if beforIdx >= 0 then
                ToClient_ChangeQuestIconByQuestType(self._uiPool.listMain[beforIdx].typeIcon, self._useArray[questIdx].questType)
                self._uiPool.listMain[uiCount].typeIcon:SetSpanSize(40, 0)
                self._uiPool.listMain[uiCount].name:SetSpanSize(75, 0)
                self._uiPool.listMain[uiCount].typeIcon:SetShow(false)
              end
            end
            if ToClient_IsDevelopment() == true and ToClient_CheckQuestInfoTitleQuestNoForDebug() == 1 then
              local devGroupNo = self._useArray[questIdx].groupNo
              local devQuestNo = self._useArray[questIdx].questNo
              self._uiPool.listMain[uiCount].name:SetText(groupTitle .. " [" .. devGroupNo .. ", " .. devQuestNo .. "]")
            else
              self._uiPool.listMain[uiCount].name:SetText(groupTitle)
            end
            if true == self._useArray[questIdx].conditionComp then
              self._uiPool.listMain[uiCount].name:SetFontColor(Defines.Color.C_FFEE5555)
              self._uiPool.listMain[uiCount].name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "WORLDMAP_WOKRPROGRESS_TXT_PROGRESS_2") .. " : " .. self._useArray[questIdx].title)
            end
          end
          self._uiPool.listMain[uiCount].btnAuto:SetShow(0 ~= posCount and not self._useArray[questIdx].isCleared)
          self._uiPool.listMain[uiCount].btnNavi:SetShow(0 ~= posCount and not self._useArray[questIdx].isCleared)
          self._uiPool.listMain[uiCount].btnGiveUp:SetShow(not self._useArray[questIdx].isCleared)
        else
          self._uiPool.listMain[uiCount].showBtn:SetShow(false)
          if true == isGroup then
            local beforIdx = uiCount - 1
            if beforIdx >= 0 then
              self._uiPool.listMain[beforIdx].showBtn:SetShow(false)
            end
          end
          if ToClient_IsDevelopment() == true and ToClient_CheckQuestInfoTitleQuestNoForDebug() == 1 then
            local devGroupNo = self._useArray[questIdx].groupNo
            local devQuestNo = self._useArray[questIdx].questNo
            self._uiPool.listMain[uiCount].name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_NOTACCEPTTITLE", "title", self._useArray[questIdx].title) .. " [" .. devGroupNo .. ", " .. devQuestNo .. "]")
          else
            self._uiPool.listMain[uiCount].name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUESTWINDOW_NOTACCEPTTITLE", "title", self._useArray[questIdx].title))
          end
          self._uiPool.listMain[uiCount].name:SetFontColor(Defines.Color.C_FFEDE699)
          self._uiPool.listMain[uiCount].typeIcon:SetShow(true)
          ToClient_ChangeQuestIconByQuestType(self._uiPool.listMain[uiCount].typeIcon, self._useArray[questIdx].questType)
          if not self._useArray[questIdx].isSubQuest then
            self._uiPool.listMain[uiCount].typeIcon:SetSpanSize(40, 0)
            self._uiPool.listMain[uiCount].name:SetSpanSize(75, 0)
          else
            self._uiPool.listMain[uiCount].typeIcon:SetSpanSize(75, 0)
            self._uiPool.listMain[uiCount].name:SetSpanSize(105, 0)
          end
          self._uiPool.listMain[uiCount].btnAuto:SetShow(true)
          self._uiPool.listMain[uiCount].btnNavi:SetShow(true)
        end
        local questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
        if true == self._useArray[questIdx].conditionComp then
          questCondition = QuestConditionCheckType.eQuestConditionCheckType_Complete
        elseif not self._useArray[questIdx].isCleared then
          if self._useArray[questIdx].isNext then
            questCondition = QuestConditionCheckType.eQuestConditionCheckType_NotAccept
          else
            questCondition = QuestConditionCheckType.eQuestConditionCheckType_Progress
          end
        end
        self._uiPool.listMain[uiCount].btnNavi:SetCheck(false)
        self._uiPool.listMain[uiCount].btnAuto:SetCheck(false)
        if _QuestWidget_ReturnQuestState ~= nil then
          local _questGroupId, _questId, _naviInfoAgain, _naviIsAutoRun = _QuestWidget_ReturnQuestState()
          if _questGroupId == self._useArray[questIdx].groupNo and _questId == self._useArray[questIdx].questNo then
            if true == _naviInfoAgain then
              self._uiPool.listMain[uiCount].btnNavi:SetCheck(false)
              self._uiPool.listMain[uiCount].btnAuto:SetCheck(false)
            else
              self._uiPool.listMain[uiCount].btnNavi:SetCheck(true)
              if true == _naviIsAutoRun then
                self._uiPool.listMain[uiCount].btnAuto:SetCheck(true)
              end
            end
          end
        end
        if not self._useArray[questIdx].isNext then
          nextCheck = 1
        end
        if false == self._isConsole then
          self._uiPool.listMain[uiCount].name:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_ShowDetailInfo(  " .. self._useArray[questIdx].groupNo .. ", " .. self._useArray[questIdx].questNo .. ", " .. questCondition .. ", " .. self._useArray[questIdx].groupIdx .. ", " .. nextCheck .. ", " .. tostring(self._useArray[questIdx].isCleared) .. ", " .. uiCount .. ")")
          if true == isGameServiceTypeDev() then
            self._uiPool.listMain[uiCount].name:addInputEvent("Mouse_RUp", "questQAComplete(" .. self._useArray[questIdx].groupNo .. ", " .. self._useArray[questIdx].questNo .. ")")
          end
        end
        self._uiPool.listMain[uiCount].name:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_ShowCondition( true, " .. questIdx .. ", " .. uiCount .. " )")
        self._uiPool.listMain[uiCount].name:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_ShowCondition( false, " .. questIdx .. ", " .. uiCount .. " )")
        if true == self._uiPool.listMain[uiCount].btnAuto:GetShow() then
          self._uiPool.listMain[uiCount].btnAuto:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._useArray[questIdx].groupNo .. ", " .. self._useArray[questIdx].questNo .. ", " .. questCondition .. ", true, " .. uiCount .. ")")
          self._uiPool.listMain[uiCount].btnAuto:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_ShowCondition( true, " .. questIdx .. ", " .. uiCount .. ", " .. 0 .. " )")
          self._uiPool.listMain[uiCount].btnAuto:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_ShowCondition( false, " .. questIdx .. ", " .. uiCount .. ", " .. 0 .. " )")
        end
        if true == self._uiPool.listMain[uiCount].btnNavi:GetShow() then
          self._uiPool.listMain[uiCount].btnNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_FindWayPrepare( " .. self._useArray[questIdx].groupNo .. ", " .. self._useArray[questIdx].questNo .. ", " .. questCondition .. ", false, " .. uiCount .. ")")
          self._uiPool.listMain[uiCount].btnNavi:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_ShowCondition( true, " .. questIdx .. ", " .. uiCount .. ", " .. 1 .. " )")
          self._uiPool.listMain[uiCount].btnNavi:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_ShowCondition( false, " .. questIdx .. ", " .. uiCount .. ", " .. 1 .. " )")
        end
        if true == self._uiPool.listMain[uiCount].btnGiveUp:GetShow() then
          self._uiPool.listMain[uiCount].btnGiveUp:addInputEvent("Mouse_LUp", "HandleEventLUp_Quest_All_GiveUp(" .. self._useArray[questIdx].groupNo .. "," .. self._useArray[questIdx].questNo .. ")")
          self._uiPool.listMain[uiCount].btnGiveUp:addInputEvent("Mouse_On", "HandleEventOnOut_Quest_All_ShowCondition( true, " .. questIdx .. ", " .. uiCount .. ", " .. 2 .. " )")
          self._uiPool.listMain[uiCount].btnGiveUp:addInputEvent("Mouse_Out", "HandleEventOnOut_Quest_All_ShowCondition( false, " .. questIdx .. ", " .. uiCount .. ", " .. 2 .. " )")
        end
        if true == self._isConsole then
          self._uiPool.listMain[uiCount].bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventA_Quest_All_ShowSubMenu(  " .. self._useArray[questIdx].groupNo .. ", " .. self._useArray[questIdx].questNo .. ", " .. questCondition .. ", " .. self._useArray[questIdx].groupIdx .. ", " .. nextCheck .. ", " .. tostring(self._useArray[questIdx].isCleared) .. ", " .. uiCount .. " )")
        end
      end
      uiCount = uiCount + 1
    end
  end
  if true == _ContentsGroup_ChinaFontColor then
    self._ui.stc_DoneDescCH:SetShow(uiCount <= 0)
  end
  local totalListCount = uiCount
  local posY = self._ui._listScroll.stc_bg:GetControlButton():GetPosY()
  local maxPosY = self._ui._listScroll.stc_bg:GetSizeY() - self._ui._listScroll.stc_bg:GetControlButton():GetSizeY()
  if posY > maxPosY then
    self._ui._listScroll.stc_bg:GetControlButton():SetPosY(maxPosY)
  end
  self:resetDataArray()
  local familyQuestCount = ToClient_GetQuestClearUserBaseCount()
  local characterQuestCount = ToClient_GetQuestClearDuplicateCount()
  local totalCount = familyQuestCount + characterQuestCount
  self._ui.txt_DoneQuest:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_NEW_FAMILYCOUNT", "totalCount", tostring(totalCount), "familyQuestCount", tostring(familyQuestCount), "characterQuestCount", tostring(characterQuestCount)))
end
