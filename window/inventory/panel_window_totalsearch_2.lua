function PaGlobalFunc_TotalSearch_Open()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self._isWareHouseOpen = false
  self._isWorldMapOpen = false
  self:prepareOpen()
end
function PaGlobalFunc_TotalSearch_OpenByWareHouse()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self._isWareHouseOpen = true
  self._isWorldMapOpen = ToClient_WorldMapIsShow()
  if self._isWorldMapOpen == true then
    self:recalcPanelPosition()
    WorldMapPopupManager:push(Panel_Window_TotalSearch, true)
  else
    self:prepareOpen()
  end
end
function PaGlobalFunc_TotalSearch_Close()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_TotalSearch_GetShow()
  local panel = Panel_Window_TotalSearch
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_TotalSearch_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_TotalSearch:createContent(content, key)
end
function PaGlobalFunc_TotalSearch_SetFocusEdit()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self._lastMouseOnListIndex = nil
  self._ui._stc_keyGuide_Y:SetShow(false)
  self._ui._stc_keyGuide_A:SetShow(false)
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  if Panel_Window_NumberPad_All:GetShow() == false then
    SetFocusEdit(self._ui._edt_search)
  end
end
function PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened()
  if PaGlobalFunc_TotalSearch_GetShow() == false then
    return
  end
  PaGlobalFunc_TotalSearch_SetFocusEdit()
end
function HandleEventLUp_TotalSearch_SearchAndUpdateTotalListByConsole(str)
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self._ui._edt_search:SetEditText(str)
  self:searchAndUpdateTotalList()
end
function HandleEventLUp_TotalSearch_SearchAndUpdateTotalList()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self:searchAndUpdateTotalList()
end
function HandleEventLUp_TotalSearch_DoReset()
  local self = PaGlobal_TotalSearch
  if self == nil then
    return
  end
  self:clear()
end
function HandleEventLUp_TotalSearch_ShowDetailInfo(questGroupNo, questNo, groupTitle, questGroupCount)
  if groupTitle == "" then
    groupTitle = "nil"
  end
  PaGlobalFunc_QuestInfo_All_Detail(questGroupNo, questNo, 0, groupTitle, questGroupCount, nil, nil, true, nil, nil, nil)
end
function HandleEventLUp_TotalSearch_SetSearchType(searchType)
  if nil == Panel_Window_TotalSearch then
    return
  end
  PaGlobal_TotalSearch:setSearchType(searchType)
end
function HandleEventKeyGuideY_TotalSearch_ShowItemTooltip()
  local self = PaGlobal_TotalSearch
  if self == nil or self._lastMouseOnListIndex == nil then
    return
  end
  local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(self._lastMouseOnListIndex)
  if searchResultData == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if itemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  elseif self._isPadMode == true then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_TotalSearch, true, false)
  end
end
function HandleEventLOnOut_TotalSearch_SearchItem(isShow, s64_key)
  local self = PaGlobal_TotalSearch
  if self == nil or isShow == nil or s64_key == nil then
    return
  end
  local index = Int64toInt32(s64_key)
  local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(index)
  if searchResultData == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if itemSSW == nil then
    return
  end
  local content = self._ui._searchedResultList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  local stc_get = UI.getChildControl(subContent, "StaticText_Get")
  if _ContentsGroup_MyItemSearchTakeOut == false or self._isPadMode == true then
    stc_get:SetShow(false)
  else
    stc_get:SetShow(isShow)
  end
  if isShow == false then
    self._ui._stc_keyGuide_Y:SetShow(false)
    self._ui._stc_keyGuide_A:SetShow(false)
    self._lastMouseOnListIndex = nil
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if self._isPadMode == true then
    self._lastMouseOnListIndex = Int64toInt32(s64_key)
    self._ui._stc_keyGuide_Y:SetShow(true)
    self._ui._stc_keyGuide_A:SetShow(true)
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, Panel_Window_TotalSearch, true, false)
end
function HandleEventLOnOut_TotalSearch_ShowWhereName(isShow, s64_key)
  local self = PaGlobal_TotalSearch
  if self == nil or isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local content = self._ui._searchedResultList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  local stc_itemSlotBg = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local stc_itemLocate = UI.getChildControl(stc_itemSlotBg, "StaticText_Locate")
  TooltipSimple_Show(stc_itemLocate, "", stc_itemLocate:GetText())
end
function HandleEventRUp_TotalSearch_TransportToMyBag(index)
  local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(index)
  if searchResultData == nil then
    return
  end
  local searchItemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if searchItemSSW == nil then
    return
  end
  local whereName = searchResultData:getWhereName()
  local itemEnchantKey = searchItemSSW:get()._key
  local searchWhereType = searchResultData:getSearchWhereType()
  local isSealed = searchResultData:getItemIsSealed()
  if searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventory then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, false, false, false, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventory then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(2)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, true, false, false, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyEquipment then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
    else
      if InventoryWindow_Show ~= nil then
        InventoryWindow_Show(true, false, false, false, false)
      end
      if PaGlobalFunc_Equipment_All_SetShow ~= nil then
        PaGlobalFunc_Equipment_All_SetShow(true, false, false, false, false)
      end
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_FamilyInventory then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
      if _ContentsGroup_changeFamilyInvenOpenAction == false and PaGlobal_FamilyInvnetoryShowToggle ~= nil then
        PaGlobal_FamilyInvnetoryShowToggle()
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, false, false, true, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherInventory then
    local characterNo_s64 = ToClient_findCharacterNo(whereName)
    local invenWrapper = ToClient_SimpleInventoryWrapper(characterNo_s64)
    if invenWrapper == nil then
      return
    end
    local itemWrapper = invenWrapper:getSimpleItemWrapperByItemEnchantKey(CppEnums.ItemWhereType.eInventory, itemEnchantKey, isSealed)
    if itemWrapper == nil then
      return
    end
    PaGlobal_SimpleInventory._selectedCharacterNo = characterNo_s64
    local countString = tostring(itemWrapper:getItemCount_s64())
    PaGlobalFunc_SimpleInventory_TransportItemToBag(itemEnchantKey:get(), CppEnums.ItemWhereType.eInventory, itemWrapper:getInventorySlotNo(), countString, isSealed)
    ClearFocusEdit()
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherCashInventory then
    local characterNo_s64 = ToClient_findCharacterNo(whereName)
    local invenWrapper = ToClient_SimpleInventoryWrapper(characterNo_s64)
    if invenWrapper == nil then
      return
    end
    local itemWrapper = invenWrapper:getSimpleItemWrapperByItemEnchantKey(CppEnums.ItemWhereType.eCashInventory, itemEnchantKey, isSealed)
    if itemWrapper == nil then
      return
    end
    PaGlobal_SimpleInventory._selectedCharacterNo = characterNo_s64
    local countString = tostring(itemWrapper:getItemCount_s64())
    PaGlobalFunc_SimpleInventory_TransportItemToBag(itemEnchantKey:get(), CppEnums.ItemWhereType.eCashInventory, itemWrapper:getInventorySlotNo(), countString, isSealed)
    ClearFocusEdit()
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherEquipment then
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_WareHouse then
    do
      local wayPointKey = ToClient_findWayPoint(whereName)
      if wayPointKey == 0 then
        return
      end
      PaGlobal_WareHouse_All._currentWaypointKey = wayPointKey
      local slotNo = ToClient_findSlotNo(wayPointKey, itemEnchantKey, isSealed)
      if slotNo == __eTInventorySlotNoUndefined then
        return
      end
      local actorKey = getSelfPlayer():getActorKey()
      local itemWrapper = PaGlobal_Warehouse_All_GetItem(slotNo)
      if itemWrapper == nil then
        return
      end
      local itemCount_s64 = itemWrapper:get():getCount_s64()
      if itemCount_s64 == 0 then
        return
      end
      local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      if itemSSW == nil then
        return
      end
      local weight = Int64toInt32(itemSSW:get()._weight) / 10000
      local dividedByWeight = 0
      if weight > 0 then
        dividedByWeight = math.floor(100 / weight)
      end
      itemCount_s64 = toInt64(0, math.min(dividedByWeight, Int64toInt32(itemCount_s64)))
      local function transportItemToMyBag()
        Panel_NumberPad_Show(true, itemCount_s64, slotNo, PaGlobal_Warehouse_All_PopItemFromItemSearch, nil, actorKey, nil, wayPointKey)
      end
      local cancelFunction = function()
        if PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened ~= nil then
          PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened()
        end
      end
      local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(false)))
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = messageBoxMemo,
        functionYes = transportItemToMyBag,
        functionNo = cancelFunction,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      ClearFocusEdit()
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MarketWallet then
    do
      local itemMysilverInfo = getWorldMarketSilverInfo()
      local silverEnchantKey = itemMysilverInfo:getEnchantKey()
      if itemEnchantKey:get() == silverEnchantKey:get() then
        InputMRUp_MarketWallet_WithdrawMoney_WithCaution()
        return
      end
      local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(index)
      if searchResultData == nil then
        return
      end
      local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      if itemSSW == nil then
        return
      end
      local isCashItem = itemSSW:isCash()
      local isSealed = false
      if isCashItem == true then
        isSealed = searchResultData:getItemIsSealed()
      end
      local index = ToClient_findWalletIndex(itemEnchantKey, isSealed)
      if index == -1 then
        return
      end
      if InputMRUp_MarketWallet_MoveWalletToInven ~= nil then
        local function transportItemToMyBag()
          if isCashItem == true then
            PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eCashInventory)
          else
            PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eInventory)
          end
          InputMRUp_MarketWallet_MoveWalletToInven(index)
        end
        local cancelFunction = function()
          if PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened ~= nil then
            PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened()
          end
        end
        local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(true)))
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
          content = messageBoxMemo,
          functionYes = transportItemToMyBag,
          functionNo = cancelFunction,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
        ClearFocusEdit()
      end
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventoryBag then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, false, false, false, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventoryBag then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(2)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, true, false, false, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_BlackSpiritBag then
    local itemIdx = ToClient_findRewardItemIdx(whereName, itemEnchantKey)
    local itemKey = ToClient_GetPendingRewardItemKeyByIndex(itemIdx)
    if nil == itemKey then
      return
    end
    ToClient_ReceivePendingReward(itemIdx, false)
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_JewelBag then
    if Panel_Window_StackExtraction_All:IsShow() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMFIND_CRYSTALALERT"))
      return
    end
    PaGlobalFunc_TotalSearch_Close()
    if Panel_Window_JewelPreset_All ~= nil and Panel_Window_JewelPreset_All:GetShow() == true then
      PaGlobalFunc_JewelPreset_Close()
    end
    PaGlobalFunc_JewelPreset_SelectPreset(ToClient_GetCurrentJewelPresetNo())
    PaGlobalFunc_JewelInven_Open(JewelInvenMode.InventoryMode)
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MoneyInventoryForUser then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, false, false, false, false)
    end
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_NewbieInventory then
    if PaGlobal_TotalSearch._isPadMode == true then
      if PaGlobalFunc_InventoryInfo_Open ~= nil then
        PaGlobalFunc_InventoryInfo_Open(1)
      end
    elseif InventoryWindow_Show ~= nil then
      InventoryWindow_Show(true, false, false, false, false)
    end
    PaGlobalFunc_NewbieInventory_Open()
  else
    _PA_ASSERT(false, "searchWhereType\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164!. \235\130\180 \234\176\128\235\176\169\236\156\188\235\161\156 \234\176\128\236\160\184\236\152\164\235\138\148 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\152\235\169\180 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148!")
  end
end
function PaGlobalFunc_TotalSearch_UpdateItemList()
  if PaGlobalFunc_TotalSearch_GetShow() == false then
    return
  end
  PaGlobal_TotalSearch:updateItemList()
end
function HandleEventLOnOut_TotalSearch_ShowGetControl(isShow, s64_key)
  local self = PaGlobal_TotalSearch
  if self == nil or isShow == nil or s64_key == nil then
    return
  end
  local content = self._ui._searchedResultList:GetContentByKey(s64_key)
  if content == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  local stc_get = UI.getChildControl(subContent, "StaticText_Get")
  local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(s64_key)
  if searchResultData == nil then
    return
  end
  local searchWhereType = searchResultData:getSearchWhereType()
  if _ContentsGroup_MyItemSearchTakeOut == false or self._isPadMode == true or searchWhereType == __eUserBaseItemSearchResultWhereType_OtherEquipment then
    stc_get:SetShow(false)
  else
    stc_get:SetShow(isShow)
  end
end
function PaGlobalFunc_TotalSearch_UseShortCutKey()
  if PaGlobal_TotalSearch == nil then
    return false
  end
  return PaGlobal_TotalSearch._ui._chk_useShortCutKey:IsCheck()
end
function HandleEventLUp_TotalSearch_ClickShortCutKeyOnOff()
  if PaGlobal_TotalSearch == nil then
    return false
  end
  local isCheck = PaGlobal_TotalSearch._ui._chk_useShortCutKey:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eFindItemUIShortCutKeyOnOff, isCheck, CppEnums.VariableStorageType.eVariableStorageType_User)
end
