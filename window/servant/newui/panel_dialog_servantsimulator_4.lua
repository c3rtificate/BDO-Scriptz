function PaGlobalFunc_ServantSimulator_Open()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ServantSimulator_Close()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ServantSimulator_CloseIfNotStikerModeUI()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if Panel_Dialog_ServantSimulator:IsUISubApp() == true then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ServantSimulator_IsShow()
  local panel = Panel_Dialog_ServantSimulator
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_ServantSimulator_SetGrowUpSelectResult(tabType, isOnlyMyHorse, maleType, index)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:updateResult(tabType, isOnlyMyHorse, maleType, index)
  PaGlobalFunc_ServantSimulatorSubView_Close()
end
function PaGlobalFunc_ServantSimulator_OnCreateGrowUpVitalityContent(content, key)
  local self = PaGlobal_ServantSimulator
  if self == nil or content == nil or key == nil then
    return
  end
  self:onCreateGrowUpVitalityContent(content, key)
end
function PaGlobalFunc_ServantSimulator_OnCreateGrowUpAbilityContent(content, key)
  local self = PaGlobal_ServantSimulator
  if self == nil or content == nil or key == nil then
    return
  end
  self:onCreateGrowUpAbilityContent(content, key)
end
function PaGlobalFunc_ServantSimulator_OnCreateGrowUpSkillContent(content, key)
  local self = PaGlobal_ServantSimulator
  if self == nil or content == nil or key == nil then
    return
  end
  self:onCreateGrowUpSkillContent(content, key)
end
function PaGlobalFunc_ServantSimulator_OnCreateMaleMatingSkillContent(content, key)
  local self = PaGlobal_ServantSimulator
  if self == nil or content == nil or key == nil then
    return
  end
  self:onCreateMaleMatingSkillContent(content, key)
end
function PaGlobalFunc_ServantSimulator_OnCreateFemaleMatingSkillContent(content, key)
  local self = PaGlobal_ServantSimulator
  if self == nil or content == nil or key == nil then
    return
  end
  self:onCreateFemaleMatingSkillContent(content, key)
end
function PaGlobalFunc_ServantSimulator_InputStat(inputValue)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self._ui._mating._txt_proficiency:SetText(tostring(inputValue))
  self:updateMatingResult()
end
function HandleEventLUp_ServantSimulator_InputStat()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  Panel_NumberPad_Show(true, toInt64(0, 2000), nil, PaGlobalFunc_ServantSimulator_InputStat)
end
function HandleEventLUp_ServantSimulator_ClearMatingEditText()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:clearMatingEditText()
  self:updateMatingResult()
end
function HandleEventLUp_ServantSimulator_PopUpUI()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if Panel_Dialog_ServantSimulator:IsUISubApp() == true then
    Panel_Dialog_ServantSimulator:CloseUISubApp()
    if Panel_Dialog_ServantFunction_All:GetShow() == true then
      PaGlobalFunc_ServantFunction_All_ChangeTab(PaGlobal_ServantFunction_All._ENUM._HORSESIMULATOR)
    end
    self:changeCloseButtonInputEvent(Panel_Dialog_ServantFunction_All:GetShow())
  else
    Panel_Dialog_ServantSimulator:OpenUISubApp()
    if Panel_Dialog_ServantFunction_All:GetShow() == true then
      PaGlobalFunc_ServantFunction_All_ChangeTab(0)
    end
    self:changeCloseButtonInputEvent(false)
  end
  if PaGlobalFunc_ServantSimulatorSubView_IsShow() == true then
    PaGlobalFunc_ServantSimulatorSubView_Close()
  end
  TooltipSimple_Hide()
end
function HandleEventLOnOut_ServantSimulator_PopUpUI(isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._btn_stickerUI
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
  local desc
  if Panel_Dialog_ServantSimulator:IsUISubApp() == true then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantSimulator_ToggleSubView(maleType)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if maleType == nil then
    if self._currentTabType ~= self._tabType.GROWUP then
      return
    end
  elseif self._currentTabType ~= self._tabType.MATING then
    return
  end
  if PaGlobalFunc_ServantSimulatorSubView_IsShow() == true then
    PaGlobalFunc_ServantSimulatorSubView_Close()
  else
    PaGlobalFunc_ServantSimulatorSubView_Open(self._currentTabType, maleType)
  end
end
function HandleEventLUp_ServantSimulator_ResetGrowUpSelectInfo()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:clearGrowUpSelectInfo()
end
function HandleEventLUp_ServantSimulator_ResetMatingSelectInfo(maleType)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:clearMatingSelectInfo(maleType)
end
function HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBoxItem()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self._lastGrowUpHorseLevelComboBoxToIndex = self._ui._growUp._cbx_horseLevel:GetListControl():GetToIndex()
  self:updateGrowUpResult()
end
function HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBox()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self._ui._growUp._cbx_horseLevel:ToggleListbox()
  local isOpen = self._ui._growUp._cbx_horseLevel:GetListControl():GetShow()
  if isOpen == true and self._lastGrowUpHorseLevelComboBoxToIndex ~= nil then
    self._ui._growUp._cbx_horseLevel:GetListControl():SetToIndex(self._lastGrowUpHorseLevelComboBoxToIndex)
  end
  if isOpen == true and self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui._growUp._cbx_horseLevel)
  end
end
function HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBoxItem()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  local curIndex = self._ui._growUp._cbx_lifeLevel:GetSelectIndex()
  if curIndex == 0 then
    curIndex = 1
  end
  ToClient_SetHorseSimulateGrowUpSelectLifeLevel(curIndex)
  self._lastGrowUpLifeLevelComboBoxToIndex = self._ui._growUp._cbx_lifeLevel:GetListControl():GetToIndex()
  self:updateGrowUpResult()
end
function HandleEventLUp_ServantSimulator_ChangeGrowUpImprint()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:updateGrowUpResult()
end
function HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(controlIndex, isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  if controlIndex == 0 then
    control = self._ui._growUp._btn_changeHorse
  elseif controlIndex == 1 then
    control = self._ui._mating._btn_changeHorseMale
  else
    control = self._ui._mating._btn_changeHorseFemale
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_SELECT_SKIN_TITLE")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(controlIndex, isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  if controlIndex == 0 then
    control = self._ui._growUp._btn_reset
  elseif controlIndex == 1 then
    control = self._ui._mating._btn_resetMale
  else
    control = self._ui._mating._btn_resetFemale
  end
  local name = ""
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_ARTIFACTS_LIST_REFRESH")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._growUp._stc_vitalityHelpIcon
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_HPMP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LIFE_TITLE_TOOLTIP")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._growUp._stc_vitalityHelpIcon
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_STUDYSKILL_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_STUDYSKILL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantSimulator_ShowGrowUpImprintTooltip(isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._growUp._chk_imprint
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTINFO_SEAL_BTN")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_SEAL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantSimulator_ChangeGrowUpEquipAvatar()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self:updateGrowUpResult()
end
function HandleEventOnOut_ServantSimulator_ShowGrowUpEquipAvatarTooltip(isShow)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._growUp._chk_equipAvatar
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_CASHEQUIP_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_CASHEQUIP_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBox()
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  self._ui._growUp._cbx_lifeLevel:ToggleListbox()
  local isOpen = self._ui._growUp._cbx_lifeLevel:GetListControl():GetShow()
  if isOpen == true and self._lastGrowUpLifeLevelComboBoxToIndex ~= nil then
    self._ui._growUp._cbx_lifeLevel:GetListControl():SetToIndex(self._lastGrowUpLifeLevelComboBoxToIndex)
  end
  if isOpen == true and self._isConsole == true then
    ToClient_padSnapChangeToTarget(self._ui._growUp._cbx_lifeLevel)
  end
end
function HandleEventLUp_ServantSimulator_MatingHorseLevelComboBoxItem(maleType)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if maleType == __eHorseSimulateHorseMaleType_Male then
    self._lastMatingHorseLevelMaleComboBoxToIndex = self._ui._mating._cbx_horseLevelMale:GetListControl():GetToIndex()
  elseif maleType == __eHorseSimulateHorseMaleType_Female then
    self._lastMatingHorseLevelFemaleComboBoxToIndex = self._ui._mating._cbx_horseLevelFemale:GetListControl():GetToIndex()
  else
    UI.ASSERT_NAME(false, "maleType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  self:updateMatingResult()
end
function HandleEventLUp_ServantSimulator_MatingHorseLevelComboBox(maleType)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  if maleType == __eHorseSimulateHorseMaleType_Male then
    self._ui._mating._cbx_horseLevelMale:ToggleListbox()
    local isOpen = self._ui._mating._cbx_horseLevelMale:GetListControl():GetShow()
    if isOpen == true and self._lastMatingHorseLevelMaleComboBoxToIndex ~= nil then
      self._ui._mating._cbx_horseLevelMale:GetListControl():SetToIndex(self._lastMatingHorseLevelMaleComboBoxToIndex)
    end
    if isOpen == true and self._isConsole == true then
      ToClient_padSnapChangeToTarget(self._ui._mating._cbx_horseLevelMale)
    end
  elseif maleType == __eHorseSimulateHorseMaleType_Female then
    self._ui._mating._cbx_horseLevelFemale:ToggleListbox()
    local isOpen = self._ui._mating._cbx_horseLevelFemale:GetListControl():GetShow()
    if isOpen == true and self._lastMatingHorseLevelFemaleComboBoxToIndex ~= nil then
      self._ui._mating._cbx_horseLevelFemale:GetListControl():SetToIndex(self._lastMatingHorseLevelFemaleComboBoxToIndex)
    end
    if isOpen == true and self._isConsole == true then
      ToClient_padSnapChangeToTarget(self._ui._mating._cbx_horseLevelFemale)
    end
  else
    UI.ASSERT_NAME(false, "maleType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
end
function HandleEventLUp_ServantSimulator_SelectMatingSkill(maleType, characterKeyRaw, skillIndex)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  local contentKey = toInt64(characterKeyRaw, skillIndex)
  local content
  local selectMatingSkillData = {_characterKeyRaw = characterKeyRaw, _skillIndex = skillIndex}
  if maleType == __eHorseSimulateHorseMaleType_Male then
    if self._selectMatingSkillList_Male == nil then
      self._selectMatingSkillList_Male = Array.new()
    end
    local isAdd = true
    for index = 1, #self._selectMatingSkillList_Male do
      local value = self._selectMatingSkillList_Male[index]
      if value ~= nil and value._characterKeyRaw == characterKeyRaw and value._skillIndex == skillIndex then
        table.remove(self._selectMatingSkillList_Male, index)
        isAdd = false
        break
      end
    end
    if isAdd == true then
      self._selectMatingSkillList_Male:push_back(selectMatingSkillData)
    end
    content = self._ui._mating._lst_horseSkillMale:GetContentByKey(contentKey)
  elseif maleType == __eHorseSimulateHorseMaleType_Female then
    if self._selectMatingSkillList_Female == nil then
      self._selectMatingSkillList_Female = Array.new()
    end
    local isAdd = true
    for index = 1, #self._selectMatingSkillList_Female do
      local value = self._selectMatingSkillList_Female[index]
      if value ~= nil and value._characterKeyRaw == characterKeyRaw and value._skillIndex == skillIndex then
        table.remove(self._selectMatingSkillList_Female, index)
        isAdd = false
        break
      end
    end
    if isAdd == true then
      self._selectMatingSkillList_Female:push_back(selectMatingSkillData)
    end
    content = self._ui._mating._lst_horseSkillFemale:GetContentByKey(contentKey)
  else
    UI.ASSERT_NAME(false, "maleType\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  self:updateMatingSkillButtonState(content, maleType, characterKeyRaw, skillIndex)
  self:updateMatingResult()
end
function HandleEventLUp_ServantSimulator_SelectGrowUpSkill(dataIndex, skillKey)
  local self = PaGlobal_ServantSimulator
  if self == nil then
    return
  end
  local contentKey = toInt64(0, dataIndex)
  local content = self._ui._growUp._lst_skill:GetContentByKey(contentKey)
  if content == nil then
    UI.ASSERT_NAME(false, "growUp\236\157\152 skill list content \234\176\157\236\178\180\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local checkBox = UI.getChildControl(content, "CheckButton_SkillName")
  local isSelected = checkBox:IsCheck()
  if self._selectGrowUpSkillIndexList == nil then
    self._selectGrowUpSkillIndexList = Array.new()
  end
  local findKey
  for key, value in pairs(self._selectGrowUpSkillIndexList) do
    if value ~= nil and value._skillKey == skillKey then
      findKey = key
      break
    end
  end
  if findKey == nil then
    if isSelected == true then
      local growUpSkillSelectData = {_skillKey = skillKey}
      self._selectGrowUpSkillIndexList:push_back(growUpSkillSelectData)
    else
      UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129 \235\161\156\236\167\129 \235\176\156\234\178\172. \236\157\180\235\175\184 \236\132\160\237\131\157\235\144\152\236\167\128 \236\149\138\236\157\128 \236\138\164\237\130\172\236\157\180\235\139\164.", "\236\157\180\236\163\188")
    end
  elseif isSelected == true then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129 \235\161\156\236\167\129 \235\176\156\234\178\172. \236\157\180\235\175\184 \236\132\160\237\131\157\235\144\156 \236\138\164\237\130\172\236\157\180\235\139\164.", "\236\157\180\236\163\188")
  else
    table.remove(self._selectGrowUpSkillIndexList, findKey)
  end
  self:updateGrowUpResult()
end
