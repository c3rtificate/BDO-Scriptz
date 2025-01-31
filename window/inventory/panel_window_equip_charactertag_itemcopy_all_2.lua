function PaGlobal_Equip_CharacterTag_ItemCopy_Open()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip then
    return
  end
  if true == PaGlobal_Equip_CharacterTag_ItemCopy._isEffectStart then
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_copyAllTap:SetCheck(true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_itemCopyBg:GetShow())
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_changeCopy:SetCheck(true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_addCopyBg:GetShow())
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_exitCopy:SetCheck(true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_exitCopyBg:GetShow())
    return
  end
  if nil ~= PaGlobalFunc_CharacterTag_All_Close then
    PaGlobalFunc_CharacterTag_All_Close()
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:prepareOpen()
end
function PaGlobal_Equip_CharacterTag_ItemCopy_Close(isTagShow, isDirectClose)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip and nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() and nil ~= PaGlobalFunc_TooltipInfo_Close then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if true == PaGlobal_Equip_CharacterTag_ItemCopy._isConsole and nil ~= Panel_Window_DescBox_ItemCopy and true == Panel_Window_DescBox_ItemCopy:GetShow() then
    PaGlobal_DescBox_ItemCopy_Close_AnotherPanel()
    PaGlobal_Equip_CharacterTag_ItemCopy._lastShowDescState = false
    if nil == isDirectClose or false == isDirectClose then
      return
    end
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:prepareClose()
  PaGlobal_Equip_CharacterTag_ItemCopy:setInventoryOpen(false)
  if nil ~= isTagShow and true == isTagShow and nil ~= PaGlobalFunc_CharacterTag_All_Open then
    PaGlobalFunc_CharacterTag_All_Open()
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy_ChangeDescIcon(isOn)
  PaGlobal_Equip_CharacterTag_ItemCopy:setDescIcon(isOn)
  PaGlobal_Equip_CharacterTag_ItemCopy._lastShowDescState = isOn
end
function PaGlobalFunc_Equip_CharacterTag_ItemCopy_FilterForAddCopy(slotNo, notUse_itemWrappers, whereType)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return true
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip or false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return true
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if false == itemWrapper:canCopyItemForDuel() then
    return true
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return true
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if false == PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(equipSlotNo) then
    return true
  end
  local isOriginalItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == isOriginalItem then
    return true
  end
  return false
end
function PaGlobal_Equip_CharacterTag_ItemCopy_RClickAddCopyItem(slotNo, itemWrapper, Count, inventoryType)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip or false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if false == itemWrapper:isMaxEndurance() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAuctionEndurance"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopySlotItem(nil, nil)
    return
  end
  if PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ADD_COPY ~= PaGlobal_Equip_CharacterTag_ItemCopy._currentTap then
    return
  end
  local rv = ToClient_PrePareAddCopyItemOnlyOne(inventoryType, slotNo)
  if 0 ~= rv then
    Proc_ShowMessage_Ack(PAGetStringSymNo(rv), 3)
  end
end
function PaGlobalFunc_Equip_CharacterTag_ItemCopy_FilterForReleaseCopy(slotNo, notUse_itemWrappers, whereType)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return true
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip or false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return true
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return true
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if false == PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(equipSlotNo) then
    return true
  end
  local isOriginalItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == isOriginalItem then
    return false
  end
  return true
end
function PaGlobal_Equip_CharacterTag_ItemCopy_RClickReleaseCopyItem(slotNo, itemWrapper, Count, inventoryType)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip or false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.RELEASE_COPY ~= PaGlobal_Equip_CharacterTag_ItemCopy._currentTap then
    return
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:setReleaseCopySlotItem(inventoryType, slotNo)
end
function PaGlobal_Equip_CharacterTag_ItemCopy_CanOpenInventory()
  if Panel_Window_Equip_CharacterTag_ItemCopy:GetShow() == false then
    return true
  end
  if _ContentsGroup_DuelCharacterCopyEquip == false then
    return true
  end
  if _ContentsGroup_DuelCharacterCopyChangeEquip == false then
    return true
  end
  if _ContentsGroup_ShyClassAwakenWeaponItemCopy == true and PaGlobal_Equip_CharacterTag_ItemCopy._selfClassType == __eClassType_ShyWaman then
    return true
  elseif PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ALL_COPY == PaGlobal_Equip_CharacterTag_ItemCopy._currentTap then
    return false
  end
  return true
end
function PaGlobalFunc_PaGlobal_Equip_ChacterTag_UpdateEffect(deltaTime)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    Panel_Window_Equip_CharacterTag_ItemCopy:ClearUpdateLuaFunc()
    return
  end
  PaGlobal_Equip_CharacterTag_ItemCopy._curEffectTime = PaGlobal_Equip_CharacterTag_ItemCopy._curEffectTime + deltaTime
  if PaGlobal_Equip_CharacterTag_ItemCopy._maxEffectTime < PaGlobal_Equip_CharacterTag_ItemCopy._curEffectTime then
    PaGlobal_Equip_CharacterTag_ItemCopy._isEffectStart = false
    local successString
    local messageBoxYesFunc = MessageBox_Empty_function
    if PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ALL_COPY == PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType then
      local toCharacterName = PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName
      if nil ~= toCharacterName and "" ~= toCharacterName then
        successString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_CONFIRM", "name", toCharacterName)
      end
      PaGlobal_Equip_CharacterTag_ItemCopy_Open()
    elseif PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ADD_COPY == PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType then
      local toCharacterName = PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName
      if nil ~= toCharacterName and "" ~= toCharacterName then
        successString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_CONFIRM", "name", toCharacterName)
      end
      local slot = PaGlobal_Equip_CharacterTag_ItemCopy._changeCopySlot
      if nil ~= slot and nil ~= slot.originalForDuelIcon then
        slot.originalForDuelIcon:SetShow(true)
      end
      PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopyItemFirst()
      PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopyItemSecond(true)
    elseif PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.RELEASE_COPY == PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType then
      successString = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_DELETE_COMPLETE")
      local slot = PaGlobal_Equip_CharacterTag_ItemCopy._releaseCopySlot
      if nil ~= slot and nil ~= slot.originalForDuelIcon then
        slot.originalForDuelIcon:SetShow(false)
      end
      PaGlobal_Equip_CharacterTag_ItemCopy._hasCopyOriginItem = ToClient_hasCopyOriginItem()
      if false == PaGlobal_Equip_CharacterTag_ItemCopy._hasCopyOriginItem then
        messageBoxYesFunc = PaGlobal_Equip_CharacterTag_ItemCopy_Open
      end
    end
    if nil ~= successString then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = successString,
        functionYes = messageBoxYesFunc,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    Panel_Window_Equip_CharacterTag_ItemCopy:ClearUpdateLuaFunc()
  end
end
function HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_Confirm()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_copyConfirm:IsIgnore() then
    return
  end
  local itemCount = PaGlobal_Equip_CharacterTag_ItemCopy._needItemCount
  local itemSlotNo = PaGlobal_Equip_CharacterTag_ItemCopy._needItemSlotNo
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfPlayerName = selfPlayer:getName()
  if nil == selfPlayerName or "" == selfPlayerName or nil == PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName or "" == PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName then
    return
  end
  local function yesFunction()
    ToClient_CopyMyEquipItems(CppEnums.ItemWhereType.eInventory, itemSlotNo, itemCount)
  end
  local titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY")
  local duelCharacterString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_POPUP_ITEMCOPY_ALERT", "name", selfPlayerName, "name1", PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName)
  local messageBoxData = {
    title = titleString,
    content = duelCharacterString,
    functionYes = yesFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ChangeCopyConfirm()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_addConfirm:IsIgnore() then
    return
  end
  local selfPlayerName = selfPlayer:getName()
  local toCharacterName = PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName
  if nil == selfPlayerName or "" == selfPlayerName or nil == toCharacterName or "" == toCharacterName then
    return
  end
  local yesFunction = function()
    local selectItemSlotNo = PaGlobal_Equip_CharacterTag_ItemCopy._selectSlotNo
    local needItemSlotNo1 = PaGlobal_Equip_CharacterTag_ItemCopy._addCopyNeedItemSlotNo
    local needItemCount1 = PaGlobal_Equip_CharacterTag_ItemCopy._addCopyNeedItemCount
    local needItemSlotNo2 = PaGlobal_Equip_CharacterTag_ItemCopy._addCopyNeedItemSlotNo2
    local needItemCount2 = PaGlobal_Equip_CharacterTag_ItemCopy._addCopyNeedItemCount2
    ToClient_AddCopyItemOnlyOne(CppEnums.ItemWhereType.eInventory, selectItemSlotNo, needItemSlotNo1, needItemCount1, CppEnums.ItemWhereType.eInventory, needItemSlotNo2, needItemCount2, CppEnums.ItemWhereType.eCashInventory)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_addConfirm:SetMonoTone(true)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_addConfirm:SetIgnore(true)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideY:SetMonoTone(true)
  end
  local titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY")
  local duelCharacterString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_POPUP_ITEMCOPY_ALERT", "name", selfPlayerName, "name1", toCharacterName)
  local messageBoxData = {
    title = titleString,
    content = duelCharacterString,
    functionYes = yesFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ReleaseCopyConfirm()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_exitConfirm:IsIgnore() then
    return
  end
  local selfPlayerName = selfPlayer:getName()
  local toCharacterName = PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName
  if nil == selfPlayerName or "" == selfPlayerName or nil == toCharacterName or "" == toCharacterName then
    return
  end
  local yesFunction = function()
    ToClient_ReleaseCopyItemOnlyOne(CppEnums.ItemWhereType.eInventory, PaGlobal_Equip_CharacterTag_ItemCopy._selectSlotNo)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_exitConfirm:SetMonoTone(true)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._btn_exitConfirm:SetIgnore(true)
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideY:SetMonoTone(true)
  end
  local titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMCOPY_COPYEXIT")
  local duelCharacterString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_POPUP_ITEMCOPY_DELETE_ALERT", "name", selfPlayerName, "name1", toCharacterName)
  local messageBoxData = {
    title = titleString,
    content = duelCharacterString,
    functionYes = yesFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_OpenDesc()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  local isShowDescPopup = Panel_Window_DescBox_ItemCopy:GetShow()
  local setShowPanel = false
  if true == isShowDescPopup then
    setShowPanel = false
  else
    setShowPanel = true
  end
  if nil ~= PaGlobal_DescBox_ItemCopy_SetPanelPosition then
    PaGlobal_DescBox_ItemCopy_SetPanelPosition(Panel_Window_Equip_CharacterTag_ItemCopy:GetPosX(), Panel_Window_Equip_CharacterTag_ItemCopy:GetPosY())
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:setDescIcon(setShowPanel)
  Panel_Window_DescBox_ItemCopy:SetShow(setShowPanel)
  PaGlobal_Equip_CharacterTag_ItemCopy._lastShowDescState = setShowPanel
end
function HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(isOn, isInventoryType, slotNo)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == isOn or nil == slotNo then
    Panel_Tooltip_Item_hideTooltip()
  else
    if true == ToClient_isConsole() then
      if true == _ContentsGroup_RenewUI_Tooltip then
        if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() and nil ~= PaGlobalFunc_TooltipInfo_Close then
          PaGlobalFunc_TooltipInfo_Close()
          return
        end
      elseif nil ~= Panel_Tooltup_Item_isShow and true == Panel_Tooltup_Item_isShow() and nil ~= Panel_Tooltip_Item_hideTooltip then
        Panel_Tooltip_Item_hideTooltip()
        return
      end
    end
    if true == _ContentsGroup_RenewUI_Tooltip then
      if true == isInventoryType then
        local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
        if nil ~= itemWrapper then
          local targetX = 0
          if nil ~= Panel_Window_Inventory and true == Panel_Window_Inventory:GetShow() then
            targetX = Panel_Window_Inventory:GetPosX() - (getOriginScreenSizeX() - getScreenSizeX()) / 2
          end
          PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, targetX)
        end
      else
        local curIndex = PaGlobal_Equip_CharacterTag_ItemCopy._currentTap
        if curIndex == PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ALL_COPY then
          local itemWrapper = ToClient_getEquipmentItem(slotNo)
          if nil ~= itemWrapper and nil ~= PaGlobalFunc_TooltipInfo_Open then
            PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
          end
        elseif nil ~= Input_InventoryInfo_ShowEquipTooltip then
          Input_InventoryInfo_ShowEquipTooltip(slotNo, true)
        end
      end
    elseif true == isInventoryType then
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
      if nil ~= itemWrapper then
        Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_Equip_CharacterTag_ItemCopy, false, true, nil, nil, nil)
      end
    else
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "equipment", true, false, 0, 0, Panel_Window_Equip_CharacterTag_ItemCopy)
    end
  end
end
function HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip(isInventoryType, slotNo)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == PaGlobal_Equip_CharacterTag_ItemCopy._isConsole then
    return
  end
  if false == ToClient_isConsole() then
    return
  end
  if nil == isInventoryType or nil == slotNo then
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideX:SetShow(false)
    Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  else
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideX:SetShow(true)
    Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(true," .. tostring(isInventoryType) .. "," .. slotNo .. ")")
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:setKeyGuideAlign()
end
function HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_MoveTap(isNext)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  local curIndex = PaGlobal_Equip_CharacterTag_ItemCopy._currentTap
  if true == isNext then
    curIndex = curIndex + 1
    if curIndex >= PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.TAP_COUNT then
      curIndex = PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ALL_COPY
    end
  else
    curIndex = curIndex - 1
    if curIndex < 0 then
      curIndex = PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.TAP_COUNT - 1
    end
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:changeTap(curIndex)
end
function HandleEventOnOut_Equip_CharacterTag_ItemCopy_ToggleToolTipForShyClass(isShow)
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_SHAI_WAKEN_TITLE_TOOLTIP")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERTAG_SHAI_WAKEN_TITLE_DESC")
  TooltipSimple_Show(self._ui._btn_selectAwakenWeaponForShy, name, desc)
end
function HandleEventLUp_Equip_CharacterTag_ItemCopy_ShowInventoryForShyClass()
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  if _ContentsGroup_RenewUI_Inventory == false then
    if PaGlobalFunc_Inventory_All_OpenWithItemCopy ~= nil then
      PaGlobalFunc_Inventory_All_OpenWithItemCopy(false)
    end
  elseif InventoryWindow_Show ~= nil then
    InventoryWindow_Show()
  end
  if _ContentsGroup_NewUI_Equipment_All == true then
    if PaGlobalFunc_Equipment_All_SetShow ~= nil then
      PaGlobalFunc_Equipment_All_SetShow(false)
    end
  elseif FGlobal_Equipment_SetHide ~= nil then
    FGlobal_Equipment_SetHide(false)
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    if PaGlobalFunc_Inventory_All_SetInventoryDragNoUse ~= nil then
      PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Equip_CharacterTag_ItemCopy)
    end
  elseif FGlobal_SetInventoryDragNoUse ~= nil then
    FGlobal_SetInventoryDragNoUse(Panel_Window_Equip_CharacterTag_ItemCopy)
  end
  Inventory_SetFunctor(PaGlobal_Equip_CharacterTag_ItemCopy_FilterForShyClass, PaGlobal_Equip_CharacterTag_ItemCopy_RClickForShyClass, FGlobal_NpcGift_Close, nil)
end
function HandleEventRUp_PaGlobal_Equip_CharacterTag_ItemCopy_ClearEquipSlot(equipSlotNo, isForShy)
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  local slot = self._equipSlot[equipSlotNo]
  local slotBG = self._equipSlotBG[equipSlotNo]
  if slot ~= nil and slotBG ~= nil then
    slot:clearItem()
    slot.icon:SetEnable(true)
    slotBG:SetShow(true)
    if __eEquipSlotNoAwakenWeapon == slotNo then
      slotBG:SetShow(self._awakenWeaponContentsOpen)
      slot.icon:SetEnable(self._awakenWeaponContentsOpen)
      slot.icon:SetShow(self._awakenWeaponContentsOpen)
    elseif __eEquipSlotNoAvatarAwakenWeapon == slotNo then
      local isShow = self._awakenWeaponContentsOpen
      if nil ~= self._selfClassType then
        if __eClassType_ShyWaman == self._selfClassType then
          isShow = false
        end
        slotBG:SetShow(isShow)
        slot.icon:SetEnable(isShow)
        slot.icon:SetShow(isShow)
      end
    end
    if __eEquipSlotNoLantern == slotNo then
      slot.icon:SetShow(false)
      slotBG:SetShow(false)
    end
    slot.icon:removeInputEvent("Mouse_On")
    slot.icon:removeInputEvent("Mouse_Out")
    slot.icon:removeInputEvent("Mouse_LUp")
    slot.icon:removeInputEvent("Mouse_RUp")
    if true == ToClient_isConsole() then
      slot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip()")
    end
    if _ContentsGroup_ShyClassAwakenWeaponItemCopy == true and self._selfClassType == __eClassType_ShyWaman and equipSlotNo == __eEquipSlotNoAwakenWeapon and slot ~= nil and slot.icon ~= nil and slot.icon:GetShow() == true then
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Equip_CharacterTag_ItemCopy_ToggleToolTipForShyClass(true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equip_CharacterTag_ItemCopy_ToggleToolTipForShyClass(false)")
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Equip_CharacterTag_ItemCopy_ShowInventoryForShyClass()")
    end
  end
  if isForShy ~= nil and isForShy == true then
    ToClient_ClearAwakenWeaponCopyItemForShyClass()
    ToClient_PrePareCopyMyEquipItems()
  end
  HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(false)
end
function PaGlobal_Equip_CharacterTag_ItemCopy_FilterForShyClass(slotNo, notUse_itemWrappers, whereType)
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return true
  end
  if Panel_Window_Equip_CharacterTag_ItemCopy == nil then
    return true
  end
  if _ContentsGroup_DuelCharacterCopyEquip == false or _ContentsGroup_DuelCharacterCopyChangeEquip == false or _ContentsGroup_ShyClassAwakenWeaponItemCopy == false then
    return true
  end
  if self._selfClassType ~= __eClassType_ShyWaman then
    return true
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if itemWrapper == nil then
    return true
  end
  if itemWrapper:canCopyItemForDuel() == false then
    return true
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if itemEnchantWrapper == nil then
    return true
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if self:checkUsableSlot(equipSlotNo) == false then
    return true
  end
  if equipSlotNo ~= __eEquipSlotNoAwakenWeapon then
    return true
  end
  local isOriginalItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if isOriginalItem == true then
    return true
  end
  return false
end
function PaGlobal_Equip_CharacterTag_ItemCopy_RClickForShyClass(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return
  end
  if itemWrapper:canCopyItemForDuel() == false then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if itemEnchantWrapper == nil then
    return
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if self:checkUsableSlot(equipSlotNo) == false then
    return
  end
  if equipSlotNo ~= __eEquipSlotNoAwakenWeapon then
    return
  end
  local isSet = ToClient_SetAwakenWeaponCopyItemForShyClass(slotNo, inventoryType)
  if isSet == false then
    return
  end
  local slot = self._equipSlot[equipSlotNo]
  local slotBG = self._equipSlotBG[equipSlotNo]
  if slot ~= nil and slotBG ~= nil then
    self:setEquipSlotBGIcon(equipSlotNo)
    self:setItemInfoUseWrapper(slot, itemWrapper, false, false, equipSlotNo, true)
    slotBG:SetShow(false)
    slot.icon:SetEnable(true)
    slot.icon:SetShow(true)
    if ToClient_isConsole() == true then
      slot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip(true, " .. slotNo .. ")")
    else
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(true, true, " .. slotNo .. ")")
    end
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(false)")
    if ToClient_isConsole() == true then
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_PaGlobal_Equip_CharacterTag_ItemCopy_ClearEquipSlot(" .. tostring(equipSlotNo) .. ", true)")
    else
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_PaGlobal_Equip_CharacterTag_ItemCopy_ClearEquipSlot(" .. tostring(equipSlotNo) .. ", true)")
    end
  end
  ToClient_PrePareCopyMyEquipItems()
end
function PaGlobal_Equip_CharacterTag_ItemCopy_CloseForShyClass()
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  PaGlobal_Equip_CharacterTag_ItemCopy_Close(true, true)
end
function FromClient_PaGlobal_Equip_CharacterTag_SelectAddCopyItem(whereType, slotNo)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ADD_COPY ~= PaGlobal_Equip_CharacterTag_ItemCopy._currentTap then
    return
  end
  PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopySlotItem(whereType, slotNo)
end
function FromClient_PaGlobal_Equip_ChacterTag_CopyItemOnlyOneSuccess(isReleaseItem)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if false == isReleaseItem then
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_addItemEffect:EraseAllEffect()
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_addItemEffect:AddEffect("fUI_ItemTransfer_01A", false, 0, 0)
    audioPostEvent_SystemUi(5, 87)
    _AudioPostEvent_SystemUiForXBOX(5, 87)
    PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType = PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ADD_COPY
  else
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_exitItemEffect:EraseAllEffect()
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_exitItemEffect:AddEffect("fUI_ItemTransfer_02A", false, 0, 0)
    audioPostEvent_SystemUi(5, 88)
    _AudioPostEvent_SystemUiForXBOX(5, 88)
    PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType = PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.RELEASE_COPY
  end
  PaGlobal_Equip_CharacterTag_ItemCopy._maxEffectTime = 4
  PaGlobal_Equip_CharacterTag_ItemCopy._curEffectTime = 0
  PaGlobal_Equip_CharacterTag_ItemCopy._isEffectStart = true
  Panel_Window_Equip_CharacterTag_ItemCopy:RegisterUpdateFunc("PaGlobalFunc_PaGlobal_Equip_ChacterTag_UpdateEffect")
end
function FromClient_PaGlobal_Equip_ChacterTag_CopyItemSuccess(isExistAddCopyItemInfo)
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    if true == Panel_Window_Equip_CharacterTag_ItemCopy:GetShow() then
      PaGlobal_Equip_CharacterTag_ItemCopy:prepareOpen()
    end
    if nil == PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName or "" == PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName then
      return
    end
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMCOPY_COMPLETEMSG_TITLE")
    local successString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_CONFIRM", "name", PaGlobal_Equip_CharacterTag_ItemCopy._toCharacterName)
    local messageBoxData = {
      title = titleString,
      content = successString,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_itemCopyEffect:EraseAllEffect()
    PaGlobal_Equip_CharacterTag_ItemCopy._ui._stc_itemCopyEffect:AddEffect("fUI_ItemTransfer_03A", true, 0, 0)
    for slotNo = PaGlobal_Equip_CharacterTag_ItemCopy._EquipNoMin, PaGlobal_Equip_CharacterTag_ItemCopy._EquipNoMax do
      if PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(slotNo) == true then
        local itemWrapper = ToClient_getEquipmentItem(slotNo)
        local slot = PaGlobal_Equip_CharacterTag_ItemCopy._equipSlot[slotNo]
        local doAddEffect = true
        if _ContentsGroup_ShyClassAwakenWeaponItemCopy == true and slotNo == __eEquipSlotNoAwakenWeapon and PaGlobal_Equip_CharacterTag_ItemCopy._selfClassType == __eClassType_ShyWaman then
          doAddEffect = false
          if isExistAddCopyItemInfo ~= nil and isExistAddCopyItemInfo == true then
            doAddEffect = true
          end
        end
        if doAddEffect == true and slot ~= nil and slot.icon ~= nil then
          slot.icon:EraseAllEffect()
          slot.icon:AddEffect("fUI_ItemTransfer_04A", true, 0, 0)
        end
      end
    end
    audioPostEvent_SystemUi(5, 86)
    _AudioPostEvent_SystemUiForXBOX(5, 86)
    PaGlobal_Equip_CharacterTag_ItemCopy._copyEffectType = PaGlobal_Equip_CharacterTag_ItemCopy.eTabIndex.ALL_COPY
    PaGlobal_Equip_CharacterTag_ItemCopy._maxEffectTime = 3
    PaGlobal_Equip_CharacterTag_ItemCopy._curEffectTime = 0
    PaGlobal_Equip_CharacterTag_ItemCopy._isEffectStart = true
    Panel_Window_Equip_CharacterTag_ItemCopy:RegisterUpdateFunc("PaGlobalFunc_PaGlobal_Equip_ChacterTag_UpdateEffect")
  end
end
function FromClient_PaGlobal_Equip_CharacterTag_OnScreenSize()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  Panel_Window_Equip_CharacterTag_ItemCopy:ComputePos()
end
function FromClient_PaGlobal_Equip_CharacterTag_UpdateNeedMaterialItemCount()
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  if self == nil then
    return
  end
  self:updateCopyEquipItemMaterialItemCount()
end
