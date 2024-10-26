function PaGlobal_TotalSearch:initialize()
  if self._initialize == true then
    return
  end
  self._isPadMode = _ContentsGroup_UsePadSnapping
  self._isConsole = self._isPadMode and ToClient_isConsole()
  if _ContentsGroup_TotalSearch_Quest == false then
    self:contentsGroupSetting()
  end
  self:initialize_titleArea()
  self:initialize_editBoxArea()
  self:initialize_radioButtonGroup()
  self:initialize_searchResultArea()
  self:initialize_bottomArea()
  self:initialize_keyGuideArea()
  self:setDefaultValue()
  self:registEventHandler()
  self:validate()
  self:clear()
  self._initialize = true
end
function PaGlobal_TotalSearch:initialize_titleArea()
  if Panel_Window_TotalSearch == nil then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_TotalSearch, "Static_TitleArea")
  local btn_close = UI.getChildControl(titleArea, "Button_Close")
  if self._isPadMode == true then
    btn_close:SetShow(false)
  else
    btn_close:SetShow(true)
    btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_TotalSearch_Close()")
  end
end
function PaGlobal_TotalSearch:initialize_editBoxArea()
  if Panel_Window_TotalSearch == nil then
    return
  end
  self._ui._edt_search = UI.getChildControl(Panel_Window_TotalSearch, "Edit_SearchText")
  self._ui._stc_keyGuideX = UI.getChildControl(self._ui._edt_search, "StaticText_XButton")
  self._ui._btn_search = UI.getChildControl(self._ui._edt_search, "Button_Search")
  self._ui._btn_reset = UI.getChildControl(self._ui._edt_search, "Button_Reset")
  self._ui._edt_search:SetMaxInput(30)
  if self._isConsole == true then
    self._ui._edt_search:setXboxVirtualKeyBoardEndEvent("HandleEventLUp_TotalSearch_SearchAndUpdateTotalListByConsole")
  else
    self._ui._edt_search:RegistReturnKeyEvent("HandleEventLUp_TotalSearch_SearchAndUpdateTotalList()")
  end
  if self._isPadMode == true then
    Panel_Window_TotalSearch:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_TotalSearch_SetFocusEdit()")
  else
    self._ui._btn_search:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalSearch_SearchAndUpdateTotalList()")
    self._ui._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalSearch_DoReset()")
  end
end
function PaGlobal_TotalSearch:initialize_radioButtonGroup()
  local stc_radioButtonGroup = UI.getChildControl(Panel_Window_TotalSearch, "Static_RadioButtonGroup")
  self._ui._stc_selectBar = UI.getChildControl(stc_radioButtonGroup, "Static_SelectLine")
  self._ui._radioTabs[self._SEARCHTYPE.ITEM] = UI.getChildControl(stc_radioButtonGroup, "RadioButton_Tab_Item")
  self._ui._radioTabs[self._SEARCHTYPE.QUEST] = UI.getChildControl(stc_radioButtonGroup, "RadioButton_Tab_Quest")
end
function PaGlobal_TotalSearch:initialize_searchResultArea()
  if Panel_Window_TotalSearch == nil then
    return
  end
  self._ui._searchedResultList = UI.getChildControl(Panel_Window_TotalSearch, "List2_SearchedResultList")
  self._ui._stc_emptyResult = UI.getChildControl(self._ui._searchedResultList, "StaticText_SearchNoResult")
  self._ui._stc_defaultGuideText = UI.getChildControl(self._ui._searchedResultList, "MultilineText_Defalt")
  self:initialize_itemContent()
  self:initialize_questContent()
  self._ui._searchedResultList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_TotalSearch_CreateContent")
  self._ui._searchedResultList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_TotalSearch:initialize_itemContent()
  local content = UI.getChildControl(self._ui._searchedResultList, "List2_2_Content")
  local subContent = UI.getChildControl(content, "SubContent_Item")
  local itemSlotBg = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local searchItemSlot = {}
  SlotItem.new(searchItemSlot, "SearchResult_ItemSlot_", 0, itemSlotBg, self._slotConfig)
  searchItemSlot:createChild()
  searchItemSlot:clearItem()
  searchItemSlot.icon:SetPosX(0)
  searchItemSlot.icon:SetPosY(0)
  searchItemSlot.icon:SetShow(false)
  searchItemSlot.border:SetSize(44, 44)
  local searchSilverSlot = {}
  SlotItem.new(searchSilverSlot, "SearchResult_SilverSlot_", 0, itemSlotBg, self._silverSlotConfig)
  searchSilverSlot:createChild()
  searchSilverSlot:clearItem()
  searchSilverSlot.icon:SetPosX(0)
  searchSilverSlot.icon:SetPosY(0)
  searchSilverSlot.icon:SetShow(false)
  searchSilverSlot.border:SetSize(44, 44)
end
function PaGlobal_TotalSearch:initialize_questContent()
end
function PaGlobal_TotalSearch:initialize_bottomArea()
  self._ui._stc_bottomArea = UI.getChildControl(Panel_Window_TotalSearch, "Static_BottomArea")
  self._ui._stc_left = UI.getChildControl(self._ui._stc_bottomArea, "Static_Left")
  self._ui._stc_right = UI.getChildControl(self._ui._stc_bottomArea, "Static_Right")
  self._ui._stc_leftIcon = UI.getChildControl(self._ui._stc_left, "Static_Icon")
  self._ui._stc_rightIcon = UI.getChildControl(self._ui._stc_right, "Static_1")
  self._ui._txt_warehouseMaidCount = UI.getChildControl(self._ui._stc_left, "StaticText_Count")
  self._ui._txt_marketPlaceMaidCount = UI.getChildControl(self._ui._stc_right, "StaticText_1")
  if _ContentsGroup_MyItemSearchTakeOut == false then
    Panel_Window_TotalSearch:SetSize(Panel_Window_TotalSearch:GetSizeX(), Panel_Window_TotalSearch:GetSizeY() - 50)
  end
  self._ui._stc_bottomArea:SetShow(_ContentsGroup_MyItemSearchTakeOut == true)
  local useShortCut = true
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eFindItemUIShortCutKeyOnOff) == true then
    useShortCut = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eFindItemUIShortCutKeyOnOff)
  end
  self._ui._chk_useShortCutKey = UI.getChildControl(Panel_Window_TotalSearch, "CheckButton_Shortcut_Use")
  self._ui._chk_useShortCutKey:SetCheck(useShortCut)
  self._ui._chk_useShortCutKey:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalSearch_ClickShortCutKeyOnOff()")
  if self._isConsole == true then
    self._ui._chk_useShortCutKey:SetShow(false)
  end
end
function PaGlobal_TotalSearch:initialize_keyGuideArea()
  if Panel_Window_TotalSearch == nil then
    return
  end
  self._ui._stc_keyGuideArea = UI.getChildControl(Panel_Window_TotalSearch, "Static_KeyGuide_Bg")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_A_ConsoleUI")
  if self._isPadMode == true then
    self._ui._stc_keyGuideArea:SetShow(true)
  else
    self._ui._stc_keyGuideArea:SetShow(false)
    return
  end
  local keyGuideB = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_B_ConsoleUI")
  local keyGuideList = Array.new()
  keyGuideList:push_back(self._ui._stc_keyGuide_A)
  keyGuideList:push_back(self._ui._stc_keyGuide_Y)
  keyGuideList:push_back(keyGuideB)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  self._ui._stc_keyGuide_A:SetShow(false)
  self._ui._stc_keyGuide_Y:SetShow(false)
  Panel_Window_TotalSearch:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventKeyGuideY_TotalSearch_ShowItemTooltip()")
end
function PaGlobal_TotalSearch:registEventHandler()
  if Panel_Window_TotalSearch == nil then
    return
  end
  registerEvent("EventWarehouseUpdate", "PaGlobalFunc_TotalSearch_UpdateItemList")
  registerEvent("FromClient_TransportItemFromFindMyItem", "PaGlobalFunc_TotalSearch_UpdateItemList")
  for index = 1, self._SEARCHTYPE.COUNT - 1 do
    self._ui._radioTabs[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalSearch_SetSearchType(" .. index .. ")")
  end
end
function PaGlobal_TotalSearch:setDefaultValue()
  self._searchResultCount = {
    [self._SEARCHTYPE.ITEM] = 0,
    [self._SEARCHTYPE.QUEST] = 0
  }
  self:setSearchType(self._SEARCHTYPE.ITEM)
end
function PaGlobal_TotalSearch:prepareOpen()
  if Panel_Window_TotalSearch == nil then
    return
  end
  if self._isPadMode == false then
    SetFocusEdit(self._ui._edt_search)
  end
  self:recalcPanelPosition()
  if _ContentsGroup_MyItemSearchTakeOut == true then
    self._ui._txt_warehouseMaidCount:SetText(tostring(ToClient_getUsableMaidCountByType(false)) .. "/" .. tostring(ToClient_getMaidCount(false)))
    self._ui._txt_marketPlaceMaidCount:SetText(tostring(ToClient_getUsableMaidCountByType(true)) .. "/" .. tostring(ToClient_getMaidCount(true)))
    self._ui._stc_leftIcon:SetPosX(self._ui._txt_warehouseMaidCount:GetPosX() + self._ui._txt_warehouseMaidCount:GetSizeX() - self._ui._txt_warehouseMaidCount:GetTextSizeX() - self._ui._stc_leftIcon:GetSizeX())
    self._ui._stc_rightIcon:SetPosX(self._ui._txt_marketPlaceMaidCount:GetPosX() + self._ui._txt_marketPlaceMaidCount:GetSizeX() - self._ui._txt_marketPlaceMaidCount:GetTextSizeX() - self._ui._stc_rightIcon:GetSizeX())
  end
  self:open()
end
function PaGlobal_TotalSearch:open()
  if Panel_Window_TotalSearch == nil then
    return
  end
  Panel_Window_TotalSearch:SetShow(true)
  if self._isPadMode == true then
    Panel_Window_TotalSearch:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_TotalSearch:prepareClose()
  if Panel_Window_TotalSearch == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  HandleEventLOnOut_TotalSearch_ShowWhereName(false, nil)
  self._lastMouseOnListIndex = nil
  self._ui._stc_keyGuide_Y:SetShow(false)
  self._ui._stc_keyGuide_A:SetShow(false)
  self._isWareHouseOpen = false
  self._isWorldMapOpen = false
  self:clear()
  self:close()
end
function PaGlobal_TotalSearch:close()
  if Panel_Window_TotalSearch == nil then
    return
  end
  Panel_Window_TotalSearch:SetShow(false)
end
function PaGlobal_TotalSearch:validate()
  if Panel_Window_TotalSearch == nil then
    return
  end
  self._ui._edt_search:isValidate()
  self._ui._stc_keyGuideX:isValidate()
  self._ui._btn_search:isValidate()
  self._ui._btn_reset:isValidate()
  self._ui._stc_emptyResult:isValidate()
  self._ui._stc_defaultGuideText:isValidate()
  self._ui._stc_keyGuideArea:isValidate()
  self._ui._stc_keyGuide_Y:isValidate()
  self._ui._stc_keyGuide_A:isValidate()
  self._ui._stc_bottomArea:isValidate()
  self._ui._stc_left:isValidate()
  self._ui._stc_right:isValidate()
  self._ui._stc_leftIcon:isValidate()
  self._ui._stc_rightIcon:isValidate()
  self._ui._txt_warehouseMaidCount:isValidate()
  self._ui._txt_marketPlaceMaidCount:isValidate()
  self._ui._searchedResultList:isValidate()
end
function PaGlobal_TotalSearch:recalcPanelPosition()
  local panel = Panel_Window_TotalSearch
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = 0
  local calcPosY = 0
  if self._isWareHouseOpen == true and PaGlobalFunc_WareHouse_All_GetSortControlPosition ~= nil then
    local targetPosX, targetPosY = PaGlobalFunc_WareHouse_All_GetSortControlPosition()
    calcPosX = targetPosX - panelSizeX - 20
    calcPosY = targetPosY
  else
    calcPosX = screenCenterX - panelSizeX / 2
    calcPosY = screenCenterY - panelSizeY / 2
  end
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_TotalSearch:createContent(content, key)
  self:hideAllSubContent(content)
  if self._currentSearchType == self._SEARCHTYPE.ITEM then
    self:createItemContent(content, key)
  elseif self._currentSearchType == self._SEARCHTYPE.QUEST then
    self:createQuestContent(content, key)
  end
end
function PaGlobal_TotalSearch:hideAllSubContent(content)
  UI.getChildControl(content, "SubContent_Item"):SetShow(false)
  UI.getChildControl(content, "SubContent_Quest"):SetShow(false)
end
function PaGlobal_TotalSearch:createItemContent(content, key)
  if Panel_Window_TotalSearch == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local searchResultData = ToClient_getUserBaseITemSearchResultWrapper(index)
  if searchResultData == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Item")
  subContent:SetShow(true)
  local stc_itemSlotBg = UI.getChildControl(subContent, "Static_ItemSlotBG")
  local stc_itemName = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local stc_itemLocate = UI.getChildControl(stc_itemSlotBg, "StaticText_Locate")
  local stc_get = UI.getChildControl(subContent, "StaticText_Get")
  local searchItemSSW = getItemEnchantStaticStatus(searchResultData:getItemKey())
  if searchItemSSW == nil then
    return
  end
  local itemSlotIcon = UI.getChildControl(stc_itemSlotBg, "Static_SearchResult_ItemSlot_")
  local silverSlotIcon = UI.getChildControl(stc_itemSlotBg, "Static_SearchResult_SilverSlot_")
  local itemSlot = {}
  local isSilver = searchItemSSW:isMoney()
  if isSilver == true then
    SlotItem.reInclude(itemSlot, "SearchResult_SilverSlot_", 0, stc_itemSlotBg, self._silverSlotConfig)
    itemSlot:clearItem()
    itemSlot:setItemByStaticStatus(searchItemSSW)
    silverSlotIcon:SetShow(true)
    itemSlotIcon:addInputEvent("Mouse_On", "")
    itemSlotIcon:addInputEvent("Mouse_Out", "")
    itemSlotIcon:SetShow(false)
  else
    SlotItem.reInclude(itemSlot, "SearchResult_ItemSlot_", 0, stc_itemSlotBg, self._slotConfig)
    itemSlot:clearItem()
    local isSealed = searchResultData:getItemIsSealed()
    local isVested = searchResultData:getItemIsVested()
    local isTradeAble = requestIsRegisterItemForItemMarket(searchResultData:getItemKey())
    if isVested == true or isTradeAble == false then
      isSealed = false
    end
    itemSlot:setItemByStaticStatus(searchItemSSW, searchResultData:getItemCount(), nil, nil, nil, nil, nil, nil, nil, nil, isSealed, nil, nil, true)
    itemSlotIcon:SetShow(true)
    silverSlotIcon:addInputEvent("Mouse_On", "")
    silverSlotIcon:addInputEvent("Mouse_Out", "")
    silverSlotIcon:SetShow(false)
  end
  if self._isPadMode == false then
    itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_TotalSearch_SearchItem(true," .. tostring(key) .. ")")
    itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_TotalSearch_SearchItem(false," .. tostring(key) .. ")")
  else
    subContent:addInputEvent("Mouse_On", "HandleEventLOnOut_TotalSearch_SearchItem(true," .. tostring(key) .. ")")
    subContent:addInputEvent("Mouse_Out", "HandleEventLOnOut_TotalSearch_SearchItem(false," .. tostring(key) .. ")")
  end
  if _ContentsGroup_MyItemSearchTakeOut == true then
    if self._isPadMode == false then
      itemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_TotalSearch_TransportToMyBag(" .. index .. ")")
      subContent:addInputEvent("Mouse_RUp", "HandleEventRUp_TotalSearch_TransportToMyBag(" .. index .. ")")
      subContent:addInputEvent("Mouse_On", "HandleEventLOnOut_TotalSearch_ShowGetControl(true," .. tostring(key) .. ")")
      subContent:addInputEvent("Mouse_Out", "HandleEventLOnOut_TotalSearch_ShowGetControl(false," .. tostring(key) .. ")")
    else
      itemSlot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_TotalSearch_TransportToMyBag(" .. index .. ")")
      subContent:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_TotalSearch_TransportToMyBag(" .. index .. ")")
    end
  end
  local itemGrade = searchItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  stc_itemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  stc_itemName:setLineCountByLimitAutoWrap(1)
  if isSilver == true then
    stc_itemName:SetText(searchResultData:getItemName() .. " (" .. makeDotMoney(searchResultData:getItemCount()) .. ")")
  else
    local enchantLevel = searchItemSSW:get()._key:getEnchantLevel()
    local itemName = searchResultData:getItemName()
    if searchItemSSW:getItemType() == 1 and enchantLevel > 15 then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
    elseif enchantLevel > 0 and CppEnums.ItemClassifyType.eItemClassify_Accessory == searchItemSSW:getItemClassify() and (searchItemSSW:isSpecialEnchantItem() == false or searchItemSSW:isKingAccessory() == true) then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemName
    end
    stc_itemName:SetText(itemName)
  end
  stc_itemName:SetFontColor(itemGradeColor)
  local resultText
  local searchWhereType = searchResultData:getSearchWhereType()
  if searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventory then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventory then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_PEARL", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyEquipment then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_EQUIP_MY", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_FamilyInventory then
    resultText = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_FAMILLY")
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherInventory then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherCashInventory then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_PEARL", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_OtherEquipment then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_EQUIP", "character", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_WareHouse then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_WAREHOUSE", "region", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MarketWallet then
    resultText = PAGetString(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_MARKET")
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyInventoryBag then
    local splitWhere = string.split(searchResultData:getWhereName(), ";")
    resultText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_BAG", "itemname", splitWhere[2], "character", splitWhere[1])
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MyCashInventoryBag then
    local splitWhere = string.split(searchResultData:getWhereName(), ";")
    resultText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_CHARACTER_INVEN_MY_PEARL_BAG", "itemname", splitWhere[2], "character", splitWhere[1])
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_BlackSpiritBag then
    resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOTALSEARCH_RESULT_BLACKBAG", "groupName", searchResultData:getWhereName())
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_JewelBag then
    resultText = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CRYSTALBTN_TOOLTIPNAME")
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_MoneyInventoryForUser then
    resultText = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_TOOLTIP_INVEN_NAME")
  elseif searchWhereType == __eUserBaseItemSearchResultWhereType_NewbieInventory then
    resultText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NEWBIEINVEN_TITLE")
  else
    UI.ASSERT_NAME(false, "searchWhereType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \236\131\136\235\161\156\236\154\180 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\235\139\164\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if resultText ~= nil then
    stc_itemLocate:SetTextMode(__eTextMode_Limit_AutoWrap)
    stc_itemLocate:setLineCountByLimitAutoWrap(1)
    stc_itemLocate:SetText(resultText)
    if stc_itemLocate:IsLimitText() == true then
      stc_itemLocate:SetIgnore(false)
      stc_itemLocate:addInputEvent("Mouse_On", "HandleEventLOnOut_TotalSearch_ShowWhereName(true," .. tostring(key) .. ")")
      stc_itemLocate:addInputEvent("Mouse_Out", "HandleEventLOnOut_TotalSearch_ShowWhereName(false," .. tostring(key) .. ")")
    else
      stc_itemLocate:SetIgnore(true)
      stc_itemLocate:addInputEvent("Mouse_On", "")
      stc_itemLocate:addInputEvent("Mouse_Out", "")
    end
  end
  stc_get:SetShow(false)
  stc_get:SetPosX(subContent:GetSizeX() - stc_get:GetSizeX() - stc_get:GetTextSizeX() - 10)
end
function PaGlobal_TotalSearch:createQuestContent(content, key)
  if Panel_Window_TotalSearch == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local searchResultData = ToClient_GetQuestByIndex(index)
  if searchResultData == nil then
    return
  end
  local subContent = UI.getChildControl(content, "SubContent_Quest")
  subContent:SetShow(true)
  local stc_questSlotBg = UI.getChildControl(subContent, "Static_QuestSlotBG")
  local stc_questIcon = UI.getChildControl(stc_questSlotBg, "Static_QuestIcon")
  local stc_questName = UI.getChildControl(stc_questSlotBg, "StaticText_QuestName")
  local stc_questDescription = UI.getChildControl(stc_questSlotBg, "StaticText_Description")
  stc_questIcon:ChangeTextureInfoName(searchResultData:getIconPath())
  stc_questName:SetTextMode(__eTextMode_Limit_AutoWrap)
  stc_questName:setLineCountByLimitAutoWrap(1)
  stc_questName:SetText(searchResultData:getTitle())
  stc_questDescription:SetTextMode(__eTextMode_Limit_AutoWrap)
  stc_questDescription:setLineCountByLimitAutoWrap(1)
  stc_questDescription:SetText(ToClient_getReplaceDialog(searchResultData:getDesc()))
  subContent:addInputEvent("Mouse_LUp", "HandleEventLUp_TotalSearch_ShowDetailInfo(" .. searchResultData:getQuestGroupNo() .. ", " .. searchResultData:getQuestGroupQuestNo() .. ", " .. "\"" .. searchResultData:getQuestGroupTitle() .. "\"" .. ", " .. searchResultData:getQuestGroupQuestCount() .. ")")
end
function PaGlobal_TotalSearch:searchAndUpdateTotalList()
  self:searchItemList()
  if _ContentsGroup_TotalSearch_Quest == true then
    self:searchQuestList()
  end
  self:updateList(false)
end
function PaGlobal_TotalSearch:searchItemList()
  if Panel_Window_TotalSearch == nil then
    return
  end
  local inputText = self._ui._edt_search:GetEditText()
  if inputText == nil then
    return
  end
  ToClient_DoUserBaseItemSearch(inputText)
  self._searchResultCount[self._SEARCHTYPE.ITEM] = ToClient_getUserBaseItemSearchResultCount()
  self._ui._radioTabs[self._SEARCHTYPE.ITEM]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TAB_ITEM", "count", self._searchResultCount[self._SEARCHTYPE.ITEM]))
  if self._searchResultCount[self._SEARCHTYPE.ITEM] > 0 and self._isWareHouseOpen == true and Warehouse_updateSlotData ~= nil then
    Warehouse_updateSlotData()
  end
  if _ContentsGroup_MyItemSearchTakeOut == true then
    self._ui._txt_warehouseMaidCount:SetText(tostring(ToClient_getUsableMaidCountByType(false)) .. "/" .. tostring(ToClient_getMaidCount(false)))
    self._ui._txt_marketPlaceMaidCount:SetText(tostring(ToClient_getUsableMaidCountByType(true)) .. "/" .. tostring(ToClient_getMaidCount(true)))
    self._ui._stc_leftIcon:SetPosX(self._ui._txt_warehouseMaidCount:GetPosX() + self._ui._txt_warehouseMaidCount:GetSizeX() - self._ui._txt_warehouseMaidCount:GetTextSizeX() - self._ui._stc_leftIcon:GetSizeX())
    self._ui._stc_rightIcon:SetPosX(self._ui._txt_marketPlaceMaidCount:GetPosX() + self._ui._txt_marketPlaceMaidCount:GetSizeX() - self._ui._txt_marketPlaceMaidCount:GetTextSizeX() - self._ui._stc_rightIcon:GetSizeX())
  end
end
function PaGlobal_TotalSearch:searchQuestList()
  if Panel_Window_TotalSearch == nil then
    return
  end
  local inputText = self._ui._edt_search:GetEditText()
  if inputText == nil or inputText == "" then
    return
  end
  ToClient_SearchQuestByKeyword(inputText)
  self._searchResultCount[self._SEARCHTYPE.QUEST] = ToClient_GetSearchedQuestListSize()
  self._ui._radioTabs[self._SEARCHTYPE.QUEST]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TAB_QUEST", "count", self._searchResultCount[self._SEARCHTYPE.QUEST]))
end
function PaGlobal_TotalSearch:updateItemList()
  self:searchItemList()
  self:updateList(true)
  if self._isConsole == false then
    PaGlobalFunc_TotalSearch_SetFocusEdit()
  end
  if Panel_Window_StackExtraction_All ~= nil and Panel_Window_StackExtraction_All:GetShow() == true and PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
    PaGlobal_SpiritEnchant_All:retargetUI()
  end
end
function PaGlobal_TotalSearch:setSearchType(searchType)
  self._currentSearchType = searchType
  for index = 1, self._SEARCHTYPE.COUNT - 1 do
    self._ui._radioTabs[index]:SetCheck(false)
  end
  self._ui._radioTabs[searchType]:SetCheck(true)
  local targetControl = self._ui._radioTabs[self._currentSearchType]
  local selectBarPosX = targetControl:GetPosX() + targetControl:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2
  self._ui._stc_selectBar:SetPosX(selectBarPosX)
  self:updateList(false)
end
function PaGlobal_TotalSearch:updateList(keepPositionAfterUpdate)
  local currentScrollIndex = self._ui._searchedResultList:getCurrenttoIndex()
  local currentControlPos = self._ui._searchedResultList:GetVScroll():GetControlPos()
  local listManager = self._ui._searchedResultList:getElementManager()
  listManager:clearKey()
  for index = 0, self._searchResultCount[self._currentSearchType] - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  if self._searchResultCount[self._currentSearchType] == 0 then
    if self._isPadMode == true then
      self._ui._btn_reset:SetShow(false)
      self._ui._stc_keyGuideX:SetShow(true)
    else
      self._ui._btn_reset:SetShow(true)
      self._ui._stc_keyGuideX:SetShow(false)
    end
    self._ui._btn_search:SetShow(false)
    self._ui._stc_emptyResult:SetShow(true)
    self._ui._stc_defaultGuideText:SetShow(false)
  else
    if self._isPadMode == true then
      self._ui._btn_reset:SetShow(false)
      self._ui._stc_keyGuideX:SetShow(true)
    else
      self._ui._btn_reset:SetShow(true)
      self._ui._stc_keyGuideX:SetShow(false)
    end
    self._ui._btn_search:SetShow(false)
    self._ui._stc_emptyResult:SetShow(false)
    self._ui._stc_defaultGuideText:SetShow(false)
  end
  if keepPositionAfterUpdate == true then
    self._ui._searchedResultList:setCurrenttoIndex(currentScrollIndex)
    self._ui._searchedResultList:GetVScroll():SetControlPos(currentControlPos)
  end
end
function PaGlobal_TotalSearch:clear()
  if Panel_Window_TotalSearch == nil then
    return
  end
  self._ui._edt_search:SetEditText("")
  self._ui._btn_reset:SetShow(false)
  if self._isPadMode == true then
    self._ui._stc_keyGuideX:SetShow(true)
    self._ui._btn_search:SetShow(false)
  else
    self._ui._stc_keyGuideX:SetShow(false)
    self._ui._btn_search:SetShow(true)
  end
  self._ui._stc_emptyResult:SetShow(false)
  self._ui._stc_defaultGuideText:SetShow(true)
  self._ui._radioTabs[self._SEARCHTYPE.ITEM]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TAB_ITEM", "count", 0))
  self._ui._radioTabs[self._SEARCHTYPE.QUEST]:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TAB_QUEST", "count", 0))
  self._ui._searchedResultList:getElementManager():clearKey()
  ToClient_clearUserBaseItemSearchResult()
  ToClient_ClearSearchedQuestList()
  self:setDefaultValue()
end
function PaGlobal_TotalSearch:contentsGroupSetting()
  local radiobtnGroup = UI.getChildControl(Panel_Window_TotalSearch, "Static_RadioButtonGroup")
  local list2 = UI.getChildControl(Panel_Window_TotalSearch, "List2_SearchedResultList")
  local titleArea = UI.getChildControl(Panel_Window_TotalSearch, "Static_TitleArea")
  local titleName = UI.getChildControl(titleArea, "StaticText_Title")
  Panel_Window_TotalSearch:SetSize(Panel_Window_TotalSearch:GetSizeX(), Panel_Window_TotalSearch:GetSizeY() - 50)
  radiobtnGroup:SetShow(false)
  list2:SetSpanSize(0, 110)
  titleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_TOTALSEARCH_TITLE"))
  Panel_Window_TotalSearch:ComputePosAllChild()
end
