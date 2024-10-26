function PaGlobalFunc_LightStoneBag_IsShow()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return nil
  end
  return self:isShowPanel()
end
function PaGlobalFunc_LightStoneBag_Open()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_LightStoneBag_Close()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_LightStoneBag_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:get():isLightStone() == true then
    return false
  end
  return true
end
function PaGlobalFunc_LightStoneBag_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  ToClient_requestPushItemToLightStoneBag(inventoryType, slotNo, count)
end
function PaGlobalFunc_ArtifactBag_Filter(slotNo, itemWrapper, count, inventoryType)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return true
  end
  if itemSSW:get():isArtifact() == true then
    return false
  end
  return true
end
function PaGlobalFunc_ArtifactBag_RClickFunction(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  ToClient_requestPushItemToArtifactBag(inventoryType, slotNo, count)
end
function PaGlobalFunc_LightStoneBag_OnClickedTab(tabIndex)
  local self = PaGlobal_LightStoneBag
  if self == nil or tabIndex == nil then
    return
  end
  self:onClickedTab(tabIndex)
end
function PaGlobalFunc_LightStoneBag_OnClickedSettingUIButton()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  if PaGlobalFunc_Artifacts_All_Open ~= nil then
    PaGlobalFunc_Artifacts_All_Open()
  end
end
function PaGlobalFunc_LightStoneBag_OnClickedMoveAllItemButton()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  if self._currentTabIndex == LightStoneBagTabIndex.LightStone then
    ToClient_requestPushAllLightStoneToLightStoneBag(CppEnums.ItemWhereType.eInventory)
  elseif self._currentTabIndex == LightStoneBagTabIndex.Artifact then
    ToClient_requestPushAllArtifactToArtifactBag(CppEnums.ItemWhereType.eInventory)
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 TabIndex\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function PaGlobalFunc_LightStoneBag_OnClickedLightStoneTypeButton(typeIndex)
  local self = PaGlobal_LightStoneBag
  if self == nil or typeIndex == nil then
    return
  end
  self:onClickedLightStoneTypeButton(typeIndex)
end
function PaGlobalFunc_LightStoneBag_MoveTab(isLeft)
  local self = PaGlobal_LightStoneBag
  if self == nil or isLeft == nil then
    return
  end
  if isLeft == true then
    self:onClickedTab(self._currentTabIndex - 1)
  else
    self:onClickedTab(self._currentTabIndex + 1)
  end
  if PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false, nil)
  end
end
function PaGlobalFunc_ArtifactBag_ToggleEditMode()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.Artifact then
    return
  end
  if self._isConsole == true then
    self._ui._btn_editPreset:SetCheck(not self._ui._btn_editPreset:IsCheck())
  end
  self:resyncArtifactBagEditMode()
end
function PaGlobalFunc_LightStoneBag_OnCreateLightStoneBagListContent(content, key)
  local self = PaGlobal_LightStoneBag
  if self == nil or content == nil or key == nil then
    return
  end
  self:createLightStoneBagListContent(content, key)
end
function PaGlobalFunc_LightStoneBag_OnCreateArtifactBagListContent(content, key)
  local self = PaGlobal_LightStoneBag
  if self == nil or content == nil or key == nil then
    return
  end
  self:createArtifactBagListContent(content, key)
end
function PaGlobalFunc_LightStoneBag_OnCreateArtifactPresetListContent(content, key)
  local self = PaGlobal_LightStoneBag
  if self == nil or content == nil or key == nil then
    return
  end
  self:createArtifactPresetListContent(content, key)
end
function PaGlobalFunc_ArtifactPreset_SetFocusEdit(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or s64_key == nil then
    return
  end
  local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local editName = UI.getChildControl(btn_preset, "Edit_ItemName")
  SetFocusEdit(editName)
end
function PaGlobalFunc_LightStoneTypeButton_OnPadSnap()
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false then
    return
  end
  self._lastPadSnappedPresetIndex_s64 = nil
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobalFunc_LightStoneBag_OnPadSnap(isOn)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isOn == nil then
    return
  end
  self._lastPadSnappedPresetIndex_s64 = nil
  Panel_Tooltip_Item_hideTooltip()
  if isOn == true then
    self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag)
  end
end
function PaGlobalFunc_ArtifactPreset_OnPadSnap(isOn, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isOn == nil or s64_key == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  if self._isConsole == true then
    local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
    local editName = UI.getChildControl(btn_preset, "Edit_ItemName")
    local keyGuideX = UI.getChildControl(editName, "Static_X_ConsoleUI")
    if isOn == true and self._isEditMode == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ArtifactPreset_SetFocusEdit(" .. tostring(s64_key) .. ")")
      keyGuideX:SetShow(true)
    else
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      keyGuideX:SetShow(false)
    end
  end
  if isOn == true then
    self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnPreset)
    self._lastPadSnappedPresetIndex_s64 = toInt64(0, s64_key)
  elseif PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    local presetNo = Int64toInt32(s64_key)
    PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false, presetNo)
  end
end
function PaGlobalFunc_ArtifactBag_OnPadSnap(isOn)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isOn == nil then
    return
  end
  self._lastPadSnappedPresetIndex_s64 = nil
  Panel_Tooltip_Item_hideTooltip()
  if isOn == true then
    self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag)
  end
end
function PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(isShow, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or s64_key == nil then
    return
  end
  local content = self._ui._artifactBagList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_slot = UI.getChildControl(content, "Button_Artifact")
  local stc_guide = UI.getChildControl(btn_slot, "Static_Icon_RMB")
  if stc_guide ~= nil then
    stc_guide:SetShow(isShow)
  end
end
function PaGlobalFunc_ArtifactBag_ShowItemTooltip(isShow, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or s64_key == nil then
    return
  end
  local content = self._ui._artifactBagList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_slot = UI.getChildControl(content, "Button_Artifact")
  local mainSlotBG = UI.getChildControl(btn_slot, "Static_ItemSlotBG")
  local mainItemSlot = UI.getChildControl(mainSlotBG, "Static_ItemIcon")
  local bagIndex = Int64toInt32(s64_key)
  local itemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if itemSSW == nil then
    return
  end
  self._currentMouseOnArtifactBagIndex = bagIndex
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "ArtifactBag")
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_LightStoneBag, true, false, nil, nil, nil, nil, nil, nil, "ArtifactBag")
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactPreset_ShowItemTooltip(isShow, isLeftArtifact, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or isLeftArtifact == nil or s64_key == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local stc_artifactSlotBg
  if isLeftArtifact == true then
    stc_artifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_L")
  else
    stc_artifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_R")
  end
  local stc_artifactSlotIcon = UI.getChildControl(stc_artifactSlotBg, "Static_ItemIcon")
  local presetNo = Int64toInt32(s64_key)
  local itemSSW
  if isLeftArtifact == true then
    itemSSW = tempWrapper:getArtifactPresetLeftArtifactItemStaticStatusWrapper(presetNo)
  else
    itemSSW = tempWrapper:getArtifactPresetRightArtifactItemStaticStatusWrapper(presetNo)
  end
  if itemSSW == nil then
    return
  end
  self._currentMouseOnArtifactPresetInfo.presetNo = presetNo
  self._currentMouseOnArtifactPresetInfo.isLeft = isLeftArtifact
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "ArtifactPreset")
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_LightStoneBag, true, false, nil, nil, nil, nil, nil, nil, "ArtifactPreset")
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(isShow, isLeftArtifact, s64_key, subIndex)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or isLeftArtifact == nil or s64_key == nil or subIndex == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local subItemSlotBG, subItemSlot
  if subIndex == 0 then
    if isLeftArtifact == true then
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_0")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    else
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_0")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    end
  elseif subIndex == 1 then
    if isLeftArtifact == true then
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_1")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    else
      subItemSlotBG = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_1")
      subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
    end
  end
  local presetNo = Int64toInt32(s64_key)
  local itemSSW
  if subIndex == 0 then
    if isLeftArtifact == true then
      itemSSW = tempWrapper:getArtifactPresetLeftFirstPushedItemItemStaticStatusWrapper(presetNo)
    else
      itemSSW = tempWrapper:getArtifactPresetRightFirstPushedItemStaticStatusWrapper(presetNo)
    end
  elseif subIndex == 1 then
    if isLeftArtifact == true then
      itemSSW = tempWrapper:getArtifactPresetLeftSecondPushedItemItemStaticStatusWrapper(presetNo)
    else
      itemSSW = tempWrapper:getArtifactPresetRightSecondPushedItemStaticStatusWrapper(presetNo)
    end
  end
  if itemSSW == nil then
    return
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_LightStoneBag, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactPreset_CurrentMouseOverPresetNo()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  return self._currentMouseOnArtifactPresetInfo
end
function PaGlobalFunc_ArtifactBag_CurrentMouseOverBagIndex()
  local self = PaGlobal_LightStoneBag
  if self == nil then
    return
  end
  return self._currentMouseOnArtifactBagIndex
end
function PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(isShow, s64_key, subIndex)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or s64_key == nil or subIndex == nil then
    return
  end
  local content = self._ui._artifactBagList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_slot = UI.getChildControl(content, "Button_Artifact")
  local subItemSlotBG, subItemSlot
  if subIndex == 0 then
    subItemSlotBG = UI.getChildControl(btn_slot, "Static_Artifact_BG_0")
    subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
  elseif subIndex == 1 then
    subItemSlotBG = UI.getChildControl(btn_slot, "Static_Artifact_BG_1")
    subItemSlot = UI.getChildControl(subItemSlotBG, "Static_Icon")
  end
  local bagIndex = Int64toInt32(s64_key)
  local itemSSW
  if subIndex == 0 then
    itemSSW = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  elseif subIndex == 1 then
    itemSSW = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  else
    return
  end
  if itemSSW == nil then
    return
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_LightStoneBag, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactBag_OnClickedEquipButton(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(s64_key)
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PRESET_NOT_CHANGE"))
    return
  end
  local presetNo = Int64toInt32(s64_key)
  ToClient_requestEquipArtifactPreset(presetNo)
end
function PaGlobalFunc_ArtifactBag_OnClickedClearPreset(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(s64_key)
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:clearArtifactSlotAll(presetNo)
end
function PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or s64_key == nil then
    return
  end
  if self._currentSelectedPresetIndex_s64 ~= nil and self._currentSelectedPresetIndex_s64 ~= s64_key then
    PaGlobalFunc_ArtifactPreset_SetPresetName(self._currentSelectedPresetIndex_s64)
  end
  self:setCurrentSelectedPresetIndex(s64_key)
end
function PaGlobalFunc_ArtifactBag_OnClickedPresetButton(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or s64_key == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(s64_key)
  if self._isConsole ~= true or self._isEditMode == true then
  else
    PaGlobalFunc_ArtifactBag_OnClickedEquipButton(s64_key)
  end
end
function PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(isShow, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or s64_key == nil then
    return
  end
  local content = self._ui._lightStoneBagList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_guide = UI.getChildControl(btn_item, "Static_Icon_RMB")
  if stc_guide ~= nil then
    stc_guide:SetShow(isShow)
  end
end
function PaGlobalFunc_LightStoneBag_ShowItemTooltip(isShow, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isShow == nil or s64_key == nil then
    return
  end
  local content = self._ui._lightStoneBagList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local subTypeIndex = getLightBagSubIndex(s64_key)
  local bagIndex = getLightBagIndex(s64_key)
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local itemSSW = ToClient_GetLightStoneBagItemStaticStatusWrapper(subTypeIndex, bagIndex)
  if itemSSW == nil then
    return
  end
  if self._isConsole == true and ToClient_isConsole() == true then
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif isShow == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_LightStoneBag, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_ArtifactBag_AddArtifactPresetItem(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or s64_key == nil then
    return
  end
  if self._isConsole == true and isPadPressed(__eJoyPadInputType_RightTrigger) == true then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  if self._currentSelectedPresetIndex_s64 == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNeedSelectArtifactPresetControl"))
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    return
  end
  local pushedItemKey_0 = ItemEnchantKey(0, 0)
  local pushedItemSSW_0 = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  if pushedItemSSW_0 ~= nil then
    pushedItemKey_0 = pushedItemSSW_0:get()._key
  end
  local pushedItemKey_1 = ItemEnchantKey(0, 0)
  local pushedItemSSW_1 = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  if pushedItemSSW_1 ~= nil then
    pushedItemKey_1 = pushedItemSSW_1:get()._key
  end
  local presetNo = Int64toInt32(self._currentSelectedPresetIndex_s64)
  tempWrapper:pushArtifactPresetData(presetNo, artifactItemSSW:get()._key, pushedItemKey_0, pushedItemKey_1)
end
function PaGlobalFunc_ArtifactBag_RequestPopArtifactItem(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or s64_key == nil then
    return
  end
  if self._isConsole == true and isPadPressed(__eJoyPadInputType_RightTrigger) == true then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local inputMaxCount = ToClient_GetArtifactBagItemCount64(bagIndex)
  local popableMaxCount = ToClient_getPopableMaxCountFromLightStoneBag()
  if popableMaxCount < Int64toInt32(inputMaxCount) then
    inputMaxCount = toInt64(0, popableMaxCount)
  end
  Panel_NumberPad_Show(true, inputMaxCount, s64_key, PaGlobalFunc_ArtifactBag_ReqeustPopItem)
end
function PaGlobalFunc_LightStoneBag_RequestPopLightStoneItem(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or s64_key == nil then
    return
  end
  if self._isConsole == true and isPadPressed(__eJoyPadInputType_RightTrigger) == true then
    return
  end
  local subTypeIndex = getLightBagSubIndex(s64_key)
  local bagIndex = getLightBagIndex(s64_key)
  local inputMaxCount = ToClient_GetLightStoneBagItemCount64(subTypeIndex, bagIndex)
  local popableMaxCount = ToClient_getPopableMaxCountFromLightStoneBag()
  if popableMaxCount < Int64toInt32(inputMaxCount) then
    inputMaxCount = toInt64(0, popableMaxCount)
  end
  Panel_NumberPad_Show(true, inputMaxCount, s64_key, PaGlobalFunc_LightStoneBag_RequestPopItem)
end
function PaGlobalFunc_ArtifactBag_ReqeustPopItem(popCount, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or popCount == nil or s64_key == nil then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    return
  end
  local pushedLightStoneItemSSW_0 = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local pushedLightStoneItemKey_0 = ItemEnchantKey(0, 0)
  if pushedLightStoneItemSSW_0 ~= nil then
    pushedLightStoneItemKey_0 = pushedLightStoneItemSSW_0:get()._key
  end
  local pushedLightStoneItemSSW_1 = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local pushedLightStoneItemKey_1 = ItemEnchantKey(0, 0)
  if pushedLightStoneItemSSW_1 ~= nil then
    pushedLightStoneItemKey_1 = pushedLightStoneItemSSW_1:get()._key
  end
  ToClient_requestPopItemFromArtifactBag(CppEnums.ItemWhereType.eInventory, artifactItemSSW:get()._key, pushedLightStoneItemKey_0, pushedLightStoneItemKey_1, popCount)
end
function PaGlobalFunc_LightStoneBag_RequestPopItem(popCount, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or popCount == nil or s64_key == nil then
    return
  end
  local subTypeIndex = getLightBagSubIndex(s64_key)
  local bagIndex = getLightBagIndex(s64_key)
  local itemSSW = ToClient_GetLightStoneBagItemStaticStatusWrapper(subTypeIndex, bagIndex)
  if itemSSW == nil then
    return
  end
  ToClient_requestPopItemFromLightStoneBag(CppEnums.ItemWhereType.eInventory, itemSSW:get()._key, popCount)
end
function PaGlobalFunc_ArtifactPreset_ClearPresetSlotOnce(isLeftArtifact, s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or isLeftArtifact == nil or s64_key == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  PaGlobalFunc_ArtifactPreset_ShowItemTooltip(false, isLeftArtifact, s64_key)
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:clearArtifactSlotOnce(isLeftArtifact, presetNo)
end
function PaGlobalFunc_ArtifactPreset_SetPresetName(s64_key)
  local self = PaGlobal_LightStoneBag
  if self == nil or s64_key == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local txt_presetNameEditBox = UI.getChildControl(btn_preset, "Edit_ItemName")
  local presetNo = Int64toInt32(s64_key)
  tempWrapper:setArtifactPresetName(presetNo, txt_presetNameEditBox:GetEditText())
  ClearFocusEdit()
end
function FromClient_UpdateLightStoneBag(isFullReload)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isFullReload == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.LightStone then
    return
  end
  self:fromClient_reloadLightStoneBagList(isFullReload)
end
function FromClient_UpdateArifactBag(isFullReload)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isFullReload == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.Artifact then
    return
  end
  self:fromClient_reloadArtifactBagList(isFullReload)
end
function FromClient_UpdateArtifactPresetData(isFullReload)
  local self = PaGlobal_LightStoneBag
  if self == nil or self:isShowPanel() == false or isFullReload == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.Artifact then
    return
  end
  self:fromClient_reloadArtifactPresetList(isFullReload)
end
function FromClient_UpdateAtifactBagVariedCount()
  if PaGlobal_LightStoneBag == nil then
    return
  end
  local self = PaGlobal_LightStoneBag
  self._artifactInventorySlotCountMax = ToClient_getArtifactInventorySlotCountMax()
  local currentSlotCount = ToClient_GetArtifactBagSize()
  if currentSlotCount >= self._artifactInventorySlotCountMax then
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FFD05D48)
  else
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FF83A543)
  end
  self._ui._txt_slotCount:SetText(tostring(ToClient_GetArtifactBagSize()) .. " / " .. tostring(self._artifactInventorySlotCountMax))
end
