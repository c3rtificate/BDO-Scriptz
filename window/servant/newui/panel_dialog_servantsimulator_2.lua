function PaGlobal_ServantSimulator:initGrowUpControl()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_growUpBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_GrowupRate")
  self._ui._growUp._stc_growUpLeft = UI.getChildControl(self._ui._growUp._stc_growUpBg, "Static_LeftBg")
  local growUpSelectImageBg = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Static_HorseImageBG")
  local growUpSelectImage = UI.getChildControl(growUpSelectImageBg, "Static_HorseImage")
  self._ui._growUp._stc_horseImage = UI.getChildControl(growUpSelectImage, "Static_RealImage")
  self._ui._growUp._stc_selectHorse = UI.getChildControl(growUpSelectImage, "Static_SelectHorse")
  self._ui._growUp._btn_changeHorse = UI.getChildControl(growUpSelectImage, "Button_ChangeHorse")
  self._ui._growUp._txt_selectHorseName = UI.getChildControl(growUpSelectImage, "StaticText_Name")
  self._ui._growUp._stc_horseGender = UI.getChildControl(growUpSelectImageBg, "Static_Gender")
  self._ui._growUp._btn_reset = UI.getChildControl(growUpSelectImageBg, "Button_Reset")
  self._ui._growUp._cbx_horseLevel = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Combobox_HorseLevel")
  self._ui._growUp._cbx_lifeLevel = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Combobox_LifeLevel")
  self._ui._growUp._chk_imprint = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "CheckButton_Seal")
  self._ui._growUp._chk_equipAvatar = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "CheckButton_CashEquip")
  local growUpDefaultStatBg = UI.getChildControl(self._ui._growUp._stc_growUpLeft, "Static_DefaultStat")
  self._ui._growUp._txt_hp = UI.getChildControl(growUpDefaultStatBg, "StaticText_VehicleHP_Value")
  self._ui._growUp._txt_mp = UI.getChildControl(growUpDefaultStatBg, "StaticText_VehicleStemina_Value")
  self._ui._growUp._txt_acceleration = UI.getChildControl(growUpDefaultStatBg, "StaticText_Acceleration_Value")
  self._ui._growUp._txt_speed = UI.getChildControl(growUpDefaultStatBg, "StaticText_Speed_Value")
  self._ui._growUp._txt_cornering = UI.getChildControl(growUpDefaultStatBg, "StaticText_CorneringSpeed_Value")
  self._ui._growUp._txt_brake = UI.getChildControl(growUpDefaultStatBg, "StaticText_Brake_Value")
  self._ui._growUp._txt_shape = UI.getChildControl(growUpDefaultStatBg, "StaticText_Shape_Value")
  self._ui._growUp._stc_growUpRight = UI.getChildControl(self._ui._growUp._stc_growUpBg, "Static_RightBg")
  self._ui._growUp._stc_emptyText = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_NoData")
  self._ui._growUp._stc_vitalityHelpIcon = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_LifeAbilityHelp")
  self._ui._growUp._stc_skillHelpIcon = UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_StudySkillHelp")
  self._ui._growUp._lst_vitality = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_VitalityList")
  self._ui._growUp._lst_ability = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_AbilityList")
  self._ui._growUp._lst_skill = UI.getChildControl(self._ui._growUp._stc_growUpRight, "List2_SkillList")
  local vitalityStatTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat")
  local abillityStatTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat")
  local skillTitle = UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat")
  vitalityStatTitle:SetText(vitalityStatTitle:GetText())
  vitalityStatTitle:SetSize(vitalityStatTitle:GetTextSizeX(), vitalityStatTitle:GetSizeY())
  vitalityStatTitle:ComputePos()
  abillityStatTitle:SetText(abillityStatTitle:GetText())
  abillityStatTitle:SetSize(abillityStatTitle:GetTextSizeX(), abillityStatTitle:GetSizeY())
  abillityStatTitle:ComputePos()
  skillTitle:SetText(skillTitle:GetText())
  skillTitle:SetSize(skillTitle:GetTextSizeX(), skillTitle:GetSizeY())
  skillTitle:ComputePos()
  self._ui._growUp._stc_vitalityHelpIcon:SetSpanSize(vitalityStatTitle:GetSpanSize().x + vitalityStatTitle:GetSizeX() + 5, self._ui._growUp._stc_vitalityHelpIcon:GetSpanSize().y)
  self._ui._growUp._stc_skillHelpIcon:SetSpanSize(skillTitle:GetSpanSize().x + skillTitle:GetSizeX() + 5, self._ui._growUp._stc_skillHelpIcon:GetSpanSize().y)
end
function PaGlobal_ServantSimulator:registEventHandler_GrowUp()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_selectHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, true)")
  self._ui._growUp._btn_changeHorse:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, false)")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ResetGrowUpSelectInfo()")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(0, true)")
  self._ui._growUp._btn_reset:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowSelectInfoResetButtonTooltip(0, false)")
  self._ui._growUp._cbx_horseLevel:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBoxItem()")
  self._ui._growUp._cbx_horseLevel:setListTextHorizonCenter()
  self._ui._growUp._cbx_horseLevel:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_GrowUpHorseLevelComboBox()")
  self._ui._growUp._cbx_lifeLevel:GetListControl():AddSelectEvent("HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBoxItem()")
  self._ui._growUp._cbx_lifeLevel:setListTextHorizonCenter()
  self._ui._growUp._cbx_lifeLevel:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_GrowUpLifeLevelComboBox()")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ChangeGrowUpImprint()")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpImprintTooltip(true)")
  self._ui._growUp._chk_imprint:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpImprintTooltip(false)")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ChangeGrowUpEquipAvatar()")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpEquipAvatarTooltip(true)")
  self._ui._growUp._chk_equipAvatar:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpEquipAvatarTooltip(false)")
  self._ui._growUp._stc_vitalityHelpIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(true)")
  self._ui._growUp._stc_vitalityHelpIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(false)")
  self._ui._growUp._stc_skillHelpIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(true)")
  self._ui._growUp._stc_skillHelpIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(false)")
  self._ui._growUp._lst_vitality:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpVitalityContent")
  self._ui._growUp._lst_vitality:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._growUp._lst_ability:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpAbilityContent")
  self._ui._growUp._lst_ability:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._growUp._lst_skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ServantSimulator_OnCreateGrowUpSkillContent")
  self._ui._growUp._lst_skill:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ServantSimulator:validate_GrowUp()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_growUpBg:isValidate()
  self._ui._growUp._stc_growUpLeft:isValidate()
  self._ui._growUp._stc_horseImage:isValidate()
  self._ui._growUp._stc_selectHorse:isValidate()
  self._ui._growUp._btn_changeHorse:isValidate()
  self._ui._growUp._txt_selectHorseName:isValidate()
  self._ui._growUp._stc_horseGender:isValidate()
  self._ui._growUp._btn_reset:isValidate()
  self._ui._growUp._cbx_horseLevel:isValidate()
  self._ui._growUp._cbx_lifeLevel:isValidate()
  self._ui._growUp._chk_imprint:isValidate()
  self._ui._growUp._chk_equipAvatar:isValidate()
  self._ui._growUp._txt_hp:isValidate()
  self._ui._growUp._txt_mp:isValidate()
  self._ui._growUp._txt_acceleration:isValidate()
  self._ui._growUp._txt_speed:isValidate()
  self._ui._growUp._txt_cornering:isValidate()
  self._ui._growUp._txt_brake:isValidate()
  self._ui._growUp._txt_shape:isValidate()
  self._ui._growUp._stc_growUpRight:isValidate()
  self._ui._growUp._stc_emptyText:isValidate()
  self._ui._growUp._stc_vitalityHelpIcon:isValidate()
  self._ui._growUp._stc_skillHelpIcon:isValidate()
  self._ui._growUp._lst_vitality:isValidate()
  self._ui._growUp._lst_ability:isValidate()
  self._ui._growUp._lst_skill:isValidate()
end
function PaGlobal_ServantSimulator:clearGrowUpSelectInfo()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._growUp._stc_selectHorse:SetShow(true)
  self._ui._growUp._stc_horseImage:SetShow(false)
  self._ui._growUp._btn_changeHorse:SetShow(false)
  self._ui._growUp._stc_horseGender:SetShow(false)
  self._ui._growUp._cbx_horseLevel:DeleteAllItem(0)
  self._ui._growUp._cbx_horseLevel:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LEVEL"))
  self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(0)
  self._lastGrowUpHorseLevelComboBoxToIndex = nil
  self._ui._growUp._lst_vitality:moveTopIndex()
  self._ui._growUp._lst_vitality:SetShow(false)
  self._ui._growUp._lst_ability:moveTopIndex()
  self._ui._growUp._lst_ability:SetShow(false)
  self._ui._growUp._lst_skill:moveTopIndex()
  self._ui._growUp._lst_skill:SetShow(false)
  self._ui._growUp._cbx_lifeLevel:DeleteAllItem(0)
  self._ui._growUp._cbx_lifeLevel:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SELECT_HORSE_LIFELEVEL"))
  local maxLifeLevel = ToClient_GetHorseSimulateGrowUpSelectLifeLevelMax()
  for lifeLevel = 1, maxLifeLevel do
    self._ui._growUp._cbx_lifeLevel:AddItem(PaGlobalFunc_Util_CraftLevelColorReplace(lifeLevel))
  end
  self._ui._growUp._cbx_lifeLevel:SetSelectItemIndex(0)
  self._lastGrowUpLifeLevelComboBoxToIndex = nil
  self._ui._growUp._chk_imprint:SetCheck(false)
  self._ui._growUp._chk_equipAvatar:SetCheck(false)
  self._ui._growUp._stc_emptyText:SetShow(true)
  self._ui._growUp._stc_vitalityHelpIcon:SetShow(false)
  self._ui._growUp._stc_skillHelpIcon:SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine1"):SetShow(false)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine2"):SetShow(false)
  self._ui._growUp._txt_selectHorseName:SetText("-")
  self._ui._growUp._txt_hp:SetText("-")
  self._ui._growUp._txt_mp:SetText("-")
  self._ui._growUp._txt_acceleration:SetText("-")
  self._ui._growUp._txt_speed:SetText("-")
  self._ui._growUp._txt_cornering:SetText("-")
  self._ui._growUp._txt_brake:SetText("-")
  self._ui._growUp._txt_shape:SetText("-")
  self._growUpSelectInfo._dataIndex = nil
  self._growUpSelectInfo._isMyHorse = nil
  self._selectGrowUpSkillIndexList = nil
  if self._isConsole == true then
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_horseLevel)
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_lifeLevel)
  end
end
function PaGlobal_ServantSimulator:updateRightBg_GrowUpSelectInfo(index, isOnlyMyHorse)
  if Panel_Dialog_ServantSimulator == nil or index == nil then
    return false
  end
  local dataWrapper
  if isOnlyMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(index)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(index)
  end
  if dataWrapper == nil then
    return false
  end
  self._growUpSelectInfo._dataIndex = index
  self._growUpSelectInfo._isMyHorse = isOnlyMyHorse
  self._ui._growUp._stc_selectHorse:SetShow(false)
  if self._isConsole == false then
    self._ui._growUp._btn_changeHorse:SetShow(true)
  end
  local horseName = "-"
  if dataWrapper:isMyHorse() == true then
    horseName = dataWrapper:getMyHorseNameForLua()
  else
    horseName = dataWrapper:getHorseTitleNameForLua()
  end
  if ToClient_IsDevelopment() == true then
    horseName = horseName .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  self._ui._growUp._txt_selectHorseName:SetText(horseName)
  self._ui._growUp._stc_emptyText:SetShow(false)
  self._ui._growUp._stc_vitalityHelpIcon:SetShow(true)
  self._ui._growUp._stc_skillHelpIcon:SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_DefaultStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_AbilityStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "StaticText_SkillStat"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine1"):SetShow(true)
  UI.getChildControl(self._ui._growUp._stc_growUpRight, "Static_HorizonLine2"):SetShow(true)
  self._ui._growUp._lst_vitality:SetShow(true)
  self._ui._growUp._lst_ability:SetShow(true)
  self._ui._growUp._lst_skill:SetShow(true)
  self._ui._growUp._stc_horseImage:ChangeTextureInfoName(dataWrapper:getIconPath1())
  self._ui._growUp._stc_horseImage:setRenderTexture(self._ui._growUp._stc_horseImage:getBaseTexture())
  self._ui._growUp._stc_horseImage:SetShow(true)
  local genderTextureId
  if dataWrapper:isMale() == true then
    genderTextureId = "Combine_Etc_Stable_Male"
  else
    genderTextureId = "Combine_Etc_Stable_Female"
  end
  self._ui._growUp._stc_horseGender:ChangeTextureInfoTextureIDAsync(genderTextureId)
  self._ui._growUp._stc_horseGender:setRenderTexture(self._ui._growUp._stc_horseGender:getBaseTexture())
  self._ui._growUp._stc_horseGender:SetShow(true)
  self._ui._growUp._cbx_horseLevel:DeleteAllItem(0)
  local maxLevel = ToClient_GetHorseSimulateGrowUpVariableStatLevelMax()
  for level = 1, maxLevel do
    if dataWrapper:isExistExperienceStatic(level) == true then
      self._ui._growUp._cbx_horseLevel:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LEVEL", "level", level))
    end
  end
  self._ui._growUp._cbx_horseLevel:SetSelectItemIndex(0)
  self._lastGrowUpHorseLevelComboBoxToIndex = nil
  if self._isConsole == true then
    ToClient_padSnapRefreshTarget(self._ui._growUp._cbx_horseLevel)
  end
  self:updateGrowUpResult()
  return true
end
function PaGlobal_ServantSimulator:updateGrowUpResult()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil then
    return
  end
  local level = self._ui._growUp._cbx_horseLevel:GetSelectIndex() + 1
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  self:updateGrowUpResult_Vitality(dataWrapper, level)
  self:updateGrowUpResult_Ability(dataWrapper, level)
  self:updateGrowUpResult_Skill(dataWrapper, level)
  self:updateGrowUpResult_DefaultStat(dataWrapper, level)
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Vitality(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  if dataWrapper:isExistExperienceStatic(level) == false then
    return
  end
  local listManager = self._ui._growUp._lst_vitality:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  listManager:pushKey(toInt64(0, self._list_subject_vitality))
  local hpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, true, level, true)
  local hpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, false, level, true)
  local mpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, true, level, true)
  local mpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, false, level, true)
  local vitalityMin = math.min(hpMin, mpMin)
  local vitalityMax = math.max(hpMax, mpMax)
  for vitalityValue = vitalityMin, vitalityMax do
    listManager:pushKey(toInt64(level, vitalityValue))
  end
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Ability(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  if dataWrapper:isExistExperienceStatic(level) == false then
    return
  end
  local listManager = self._ui._growUp._lst_ability:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  listManager:pushKey(toInt64(0, self._list_subject_ability))
  local accelerationMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, true, level, false)
  local accelerationMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, true, level, true)
  local accelerationMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, false, level, true)
  local speedMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, true, level, false)
  local speedMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, true, level, true)
  local speedMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, false, level, true)
  local corneringMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, true, level, false)
  local corneringMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, true, level, true)
  local corneringMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, false, level, true)
  local brakeMinNotBonus = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, true, level, false)
  local brakeMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, true, level, true)
  local brakeMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, false, level, true)
  local abilityMinNotBonus = math.min(math.min(accelerationMinNotBonus, speedMinNotBonus), math.min(corneringMinNotBonus, brakeMinNotBonus)) * 10
  local abilityMin = math.min(math.min(accelerationMin, speedMin), math.min(corneringMin, brakeMin)) * 10
  local abilityMax = math.max(math.max(accelerationMax, speedMax), math.max(corneringMax, brakeMax)) * 10
  local isAppliedAbilityMin = abilityMinNotBonus == abilityMin
  for abilityValue = abilityMinNotBonus, abilityMax do
    if abilityMin > abilityValue then
    elseif isAppliedAbilityMin == false then
      listManager:pushKey(toInt64(level, abilityMin))
      isAppliedAbilityMin = true
    else
      local realValue = math.floor(abilityValue)
      if realValue % 10 == 0 then
        listManager:pushKey(toInt64(level, realValue))
      end
    end
  end
end
function PaGlobal_ServantSimulator:updateGrowUpResult_Skill(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local listManager = self._ui._growUp._lst_skill:getElementManager()
  if listManager == nil then
    return
  end
  local topIndex = self._ui._growUp._lst_skill:getCurrenttoIndex()
  local scroll = self._ui._growUp._lst_skill:GetVScroll()
  local scrollPos = scroll:GetControlPos()
  listManager:clearKey()
  local selectedSkillKeyString = ""
  if self._selectGrowUpSkillIndexList ~= nil then
    for key, value in pairs(self._selectGrowUpSkillIndexList) do
      if value ~= nil then
        selectedSkillKeyString = selectedSkillKeyString .. tostring(value._skillKey) .. ","
      end
    end
  end
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  local isImprint = self._ui._growUp._chk_imprint:IsCheck()
  local isEquipAvatar = self._ui._growUp._chk_equipAvatar:IsCheck()
  local isValidResult = ToClient_MakeHorseSimulateGrowUpSkillInfo(horseCharacterKeyRaw, level, selectedSkillKeyString, isImprint, isEquipAvatar)
  if isValidResult == false then
    return
  end
  listManager:pushKey(toInt64(0, self._list_subject_skillCantLearn))
  local dataCount = ToClient_GetHorseSimulateGrowUpSkillInfoCount()
  for dataIndex = 0, dataCount - 1 do
    listManager:pushKey(toInt64(0, dataIndex))
  end
  self._ui._growUp._lst_skill:setCurrenttoIndex(topIndex)
  scroll:SetControlPos(scrollPos)
end
function PaGlobal_ServantSimulator:updateGrowUpResult_DefaultStat(dataWrapper, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  self._ui._growUp._txt_hp:SetText(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_HP))
  self._ui._growUp._txt_mp:SetText(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_MP))
  self._ui._growUp._txt_acceleration:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Acceleration) / 1000000, 1, true))
  self._ui._growUp._txt_speed:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Speed) / 1000000, 1, true))
  self._ui._growUp._txt_cornering:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Cornering) / 1000000, 1, true))
  self._ui._growUp._txt_brake:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Brake) / 1000000, 1, true))
  local horseNameString = dataWrapper:getHorseTitleNameForLua()
  if ToClient_IsDevelopment() == true then
    horseNameString = horseNameString .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  self._ui._growUp._txt_shape:SetText(horseNameString)
end
function PaGlobal_ServantSimulator:onCreateGrowUpVitalityContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil then
    return
  end
  local level = highFromUint64(key)
  local statValue = lowFromUint64(key)
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  if dataWrapper == nil then
    return
  end
  local hpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, true, level, true)
  local hpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_HP, false, level, true)
  local hpDiff = hpMax - hpMin + 1
  local mpMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, true, level, true)
  local mpMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_MP, false, level, true)
  local mpDiff = mpMax - mpMin + 1
  local txt_value1_small = UI.getChildControl(content, "StaticText_Value1_Small")
  local txt_value1_big = UI.getChildControl(content, "StaticText_Value1_Big")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3 = UI.getChildControl(content, "StaticText_Value3")
  if statValue == self._list_subject_vitality then
    txt_value1_small:SetShow(true)
    txt_value1_big:SetShow(false)
    txt_value1_small:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_RANGE_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_HP"))
    txt_value3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_STAMINA"))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
  else
    txt_value1_small:SetShow(false)
    txt_value1_big:SetShow(true)
    txt_value1_big:SetText(string.format("%.0f", statValue))
    txt_value2:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / hpDiff, 4, true))
    txt_value3:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / mpDiff, 4, true))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
  end
end
function PaGlobal_ServantSimulator:onCreateGrowUpAbilityContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._growUpSelectInfo._dataIndex == nil or self._growUpSelectInfo._isMyHorse == nil then
    return
  end
  local level = highFromUint64(key)
  local statValue = lowFromUint64(key)
  local dataWrapper
  if self._growUpSelectInfo._isMyHorse == true then
    dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  else
    dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(self._growUpSelectInfo._dataIndex)
  end
  if dataWrapper == nil then
    return
  end
  local txt_value1_small = UI.getChildControl(content, "StaticText_Value1_Small")
  local txt_value1_big = UI.getChildControl(content, "StaticText_Value1_Big")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3 = UI.getChildControl(content, "StaticText_Value3")
  local txt_value4 = UI.getChildControl(content, "StaticText_Value4")
  local txt_value5 = UI.getChildControl(content, "StaticText_Value5")
  if statValue == self._list_subject_ability then
    txt_value1_small:SetShow(true)
    txt_value1_big:SetShow(false)
    txt_value1_small:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_RANGE_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION"))
    txt_value3:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED"))
    txt_value4:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING"))
    txt_value5:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE"))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
    txt_value5:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value5:setRenderTexture(txt_value5:getBaseTexture())
  else
    local realStat = math.floor(statValue) / 100
    local accelerationMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, true, level, true)
    local accelerationMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Acceleration, false, level, true)
    local accelerationDiff = accelerationMax - accelerationMin + 1
    local speedMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, true, level, true)
    local speedMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Speed, false, level, true)
    local speedDiff = speedMax - speedMin + 1
    local corneringMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, true, level, true)
    local corneringMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Cornering, false, level, true)
    local corneringDiff = corneringMax - corneringMin + 1
    local brakeMin = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, true, level, true)
    local brakeMax = dataWrapper:getVariedStat_MinMax(__eHorseSimulateGrowUpStatType_Brake, false, level, true)
    local brakeDiff = brakeMax - brakeMin + 1
    txt_value1_small:SetShow(false)
    txt_value1_big:SetShow(true)
    txt_value1_big:SetText(PaGlobalFunc_Util_MakeRateDotString(realStat / 100, 2, false))
    txt_value2:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / accelerationDiff, 4, true))
    txt_value3:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / speedDiff, 4, true))
    txt_value4:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / corneringDiff, 4, true))
    txt_value5:SetText(PaGlobalFunc_Util_MakeRateDotString(1 / brakeDiff, 4, true))
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value4:setRenderTexture(txt_value4:getBaseTexture())
    txt_value5:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
    txt_value5:setRenderTexture(txt_value5:getBaseTexture())
  end
end
function PaGlobal_ServantSimulator:onCreateGrowUpSkillContent(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local dataIndex = Int64toInt32(key)
  local cbx_skill = UI.getChildControl(content, "CheckButton_SkillName")
  local stc_icon = UI.getChildControl(cbx_skill, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(cbx_skill, "StaticText_SkillName")
  local txt_rate = UI.getChildControl(cbx_skill, "StaticText_SkillPercent")
  if dataIndex == self._list_subject_skillCantLearn then
    cbx_skill:SetIgnore(true)
    cbx_skill:SetCheck(false)
    stc_icon:SetShow(false)
    txt_skillName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_NO_SKILL_RATE"))
    txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateGrowUpCantLearnableRate(), 4, true))
  else
    local dataWrapper = ToClient_GetHorseSimulateGrowUpSkillInfoByIndex(dataIndex)
    if dataWrapper == nil then
      return
    end
    local skillWrapper = dataWrapper:getSkillWrapper()
    if skillWrapper == nil then
      return
    end
    local isDefaultSkill = dataWrapper:isDefaultSkill()
    local isSelect = dataWrapper:isSelected()
    if isDefaultSkill == true then
      cbx_skill:SetIgnore(true)
      cbx_skill:removeInputEvent("Mouse_LUp")
      cbx_skill:SetCheck(true)
    else
      cbx_skill:SetIgnore(false)
      cbx_skill:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_SelectGrowUpSkill(" .. tostring(dataIndex) .. "," .. tostring(dataWrapper:getSkillKey()) .. ")")
      cbx_skill:SetCheck(isSelect)
    end
    stc_icon:SetShow(true)
    stc_icon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    txt_skillName:SetText(skillWrapper:getName())
    txt_rate:SetShow(true)
    if isDefaultSkill == true or isSelect == true then
      if isDefaultSkill == true then
        txt_rate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_DEFAULT_SKILL"))
      else
        txt_rate:SetText("")
      end
    else
      txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(dataWrapper:getRate(), 4, true))
    end
  end
end
