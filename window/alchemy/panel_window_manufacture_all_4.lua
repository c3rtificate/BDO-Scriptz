function FromClient_Manufacture_All_OnScreenResize()
  local invenPosX = 0
  local invenPosY = 0
  if true == _ContentsGroup_NewUI_Inventory_All then
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    else
      invenPosX = Panel_Window_Inventory_All:GetPosX()
      invenPosY = Panel_Window_Inventory_All:GetPosY()
    end
  elseif true == Panel_Window_Inventory:IsUISubApp() then
    invenPosX = Panel_Window_Inventory:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory:GetScreenParentPosY()
  else
    invenPosX = Panel_Window_Inventory:GetPosX()
    invenPosY = Panel_Window_Inventory:GetPosY()
  end
  Panel_Window_Manufacture_All:SetPosX(invenPosX - Panel_Window_Manufacture_All:GetSizeX() - 5)
  Panel_Window_Manufacture_All:SetPosY(invenPosY)
end
function FromClient_Manufacture_All_EmergencyEvadeActionStart()
  PaGlobalFunc_Manufacture_All_Close()
end
function FromClient_Manufacture_All_EventEquipmentUpdate()
  if nil == Panel_Window_Manufacture_All or false == Panel_Window_Manufacture_All:GetShow() then
    return
  end
  if nil == PaGlobal_Manufacture_All._actionIndex then
    return
  end
  PaGlobal_Manufacture_All:refreshIsMassCheckButton(PaGlobal_Manufacture_All._actionIndex)
end
function HandleEventOnOut_Manufacture_All_IconTooltip(isShow, idx)
  if isShow == true then
    audioPostEvent_SystemUi(1, 13)
    local name = PaGlobal_Manufacture_All.MANUFACTURE_INFO[idx].name
    local desc = PaGlobal_Manufacture_All.MANUFACTURE_INFO[idx].desc
    if false == PaGlobal_Manufacture_All._isEnableBtn[idx] then
      desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NEED_KNOWLEDGE")
    end
    registTooltipControl(PaGlobal_Manufacture_All._listAction[idx]._radioBtn, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(PaGlobal_Manufacture_All._listAction[idx]._radioBtn, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Manufacture_All_MaterialTooltip(isShow, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper
  if CppEnums.ItemWhereType.eInventory == PaGlobal_Manufacture_All._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == PaGlobal_Manufacture_All._materialItemWhereType then
    itemWrapper = getInventoryItemByType(PaGlobal_Manufacture_All._materialItemWhereType, PaGlobal_Manufacture_All._materialSlotNoList[index])
  else
    itemWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper():getItem(PaGlobal_Manufacture_All._materialSlotNoList[index])
  end
  if itemWrapper == nil then
    return
  end
  local slot = PaGlobal_Manufacture_All._ui._slotList[index].icon
  Panel_Tooltip_Item_Show(itemWrapper, slot, false, true, nil, nil, nil)
end
function HandleEventOnOut_Manufacture_All_KnowledgeListTooltip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local mentalCardStaticWrapper = getAlchemyKnowledge(index)
  if nil ~= mentalCardStaticWrapper then
    local name = mentalCardStaticWrapper:getName()
    local desc = mentalCardStaticWrapper:getDesc()
    TooltipSimple_Show(Panel_Window_Manufacture_All, name, desc)
  end
end
function HandleEventOnOut_Manufacture_All_KnowledgeDescTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(PaGlobal_Manufacture_All._ui.txt_knowledgeDesc, "", PaGlobal_Manufacture_All._ui.txt_knowledgeDesc:GetText())
end
function HandleEventLUp_Manufacture_All_SelectKnowledge(index)
  if MessageBoxGetShow() then
    return
  end
  local knowledgeIndex = PaGlobal_Manufacture_All._startKnowledgeIndex + index
  local mentalCardStaticWrapper = getAlchemyKnowledge(knowledgeIndex)
  if nil ~= mentalCardStaticWrapper then
    PaGlobal_Manufacture_All:setKnowledgeDesc(mentalCardStaticWrapper:getDesc())
  end
  local prevSelectIndex = PaGlobal_Manufacture_All._selectIndex
  PaGlobal_Manufacture_All._selectIndex = index
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:requestUpdateByKey(toInt64(0, index))
  PaGlobal_Manufacture_All._ui.list2_knowledgeList:requestUpdateByKey(toInt64(0, prevSelectIndex))
end
function HandleEventLUp_Manufacture_All_SelectKnowledgeAndTooltip(isShow, index)
  HandleEventLUp_Manufacture_All_SelectKnowledge(index)
  HandleEventOnOut_Manufacture_All_KnowledgeListTooltip(isShow, index)
end
function HandleEventLUp_Manufacture_All_CheckNoneStackItem()
  if true == Panel_Window_Manufacture_All:GetShow() then
    PaGlobal_Manufacture_All._noneStackItemCheck = PaGlobal_Manufacture_All._ui.chk_identicalItem:IsCheck()
  end
end
function HandleEventLUp_Manufacture_All_OpenCraftingNote()
  if MessageBoxGetShow() then
    return
  end
  Panel_ProductNote_ShowToggle()
end
function HandleEventOn_Manufacture_All_BtnTooltip(isShow, isType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control, iconControl
  if 1 == isType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANUFACTURE_MASSBUTTON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_MASSMANUFACTURE_NOTICE")
    control = PaGlobal_Manufacture_All._ui.btn_massManufacture
  elseif 2 == isType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PRODUCTNOTE_BTN")
    desc = ""
    control = PaGlobal_Manufacture_All._ui.btn_craftingNote
    iconControl = PaGlobal_Manufacture_All._ui.stc_craftingNoteIcon
  end
  TooltipSimple_Show(control, name, desc, iconControl)
  HandleEventOn_Manufacture_All_ButtonMouseOverSound()
end
function HandleEventOn_Manufacture_All_ButtonMouseOverSound()
  audioPostEvent_SystemUi(1, 13)
end
function HandleEventLUp_Manufacture_All_ImpossibleMassManufacture()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_MASSMANUFACTURE_NOTICE"))
end
function HandleEventLUp_Manufacture_All_RepeatAction(isMassManufacture)
  if MessageBoxGetShow() then
    return
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
    return
  end
  local self = PaGlobal_Manufacture_All
  self._isMassManufacture = isMassManufacture
  if true == self._isConsole and true == self._canRepeat then
    local function consoleRepeatSelect(selectedButtonIndex)
      if 2 == selectedButtonIndex then
        self._noneStackItemCheck = true
      else
        self._noneStackItemCheck = false
      end
      for idx = 0, self._slotMaxCount - 1 do
        if nil ~= #self._noneStackItemList[idx] and 0 < #self._noneStackItemList[idx] then
          local repeatItemWrapper
          if CppEnums.ItemWhereType.eInventory == self._materialItemWhereType then
            repeatItemWrapper = getInventoryItemByType(inventoryType, self._noneStackItemList[idx][1])
          else
            local warehouseWrapper = warehouse_get(self._waypointKey_ByWareHouse)
            if nil ~= warehouseWrapper then
              repeatItemWrapper = warehouseWrapper:getItem(self._targetWarehouseSlotNo[idx])
            end
          end
          if nil ~= repeatItemWrapper then
            self._currentRepeatItemKey[idx] = repeatItemWrapper:get():getKey():getItemKey()
          else
            PaGlobal_Manufacture_All:clearCurrentRepeatItemKey()
          end
        end
      end
      HandleEventLUp_Manufacture_All_StartManufacture()
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "PANEL_WINDOW_MANUFACTURE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_ASK_MULTIPLE_TIMES"),
      functionApply = consoleRepeatSelect,
      functionCancel = MessageBox_Empty_function,
      buttonStrings = {
        PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_BUTTON_TEXT_ONE_TIME"),
        PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_BUTTON_TEXT_MULTIPLE_TIMES")
      },
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBoxCheck.showMessageBox(messageBoxData, "middle")
    return
  end
  if nil ~= #self._noneStackItemList[0] and 0 < #self._noneStackItemList[0] and true == self._noneStackItemCheck or true == self._hasNoneStackItem and true == self._noneStackItemCheck then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_CONTINUEGRIND_MSGBOX_DESC"),
      functionYes = HandleEventLUp_Manufacture_All_StartManufacture,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    HandleEventLUp_Manufacture_All_StartManufacture()
  end
end
function HandleEventLUp_Manufacture_All_StartManufacture()
  local self = PaGlobal_Manufacture_All
  if self._actionIndex == -1 then
    return
  end
  if true == ToClient_IsInClientInstanceDungeon() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoClientDungeon"))
    return
  end
  if self._listAction[3]._radioBtn:IsCheck() then
    local terraintype = selfPlayerNaviMaterial()
    local onBoat = selfplayerIsCurrentlyOnShip()
    if (2 == terraintype or 4 == terraintype or 6 == terraintype or 8 == terraintype or getSelfPlayer():getCurrentRegionInfo():isOcean()) and not onBoat then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_DONT_WARTER_ACK"))
      return
    end
  end
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == houseWrapper and 12 == self._actionIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_INNTER_GUILDHOUSE_USE"))
    return
  end
  local RGManufacture = self.MANUFACTURE_TYPE.RGCOOK == self._actionIndex or self.MANUFACTURE_TYPE.RGALCHEMY == self._actionIndex
  if true == RGManufacture then
    if true == ToClient_IsInstanceField() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoClientDungeon"))
      return
    end
    if true == _ContentsGroup_isOepnImmortalHell or true == _ContentsGroup_isOpenImmortalHellForConsole then
      local selfPlayer = getSelfPlayer():get()
      if nil == selfPlayer then
        return
      end
      local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
      if nil ~= regionInfo and nil ~= regionInfo:get() and true == regionInfo:get():isPVEArenaZone() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
        return
      end
    end
  end
  local inventory = getSelfPlayer():get():getInventory()
  local cashInventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eCashInventory)
  local freeCount = inventory:getFreeCount()
  local size = 0
  if CppEnums.ItemWhereType.eInventory == self._materialItemWhereType then
    size = inventory:size()
  elseif CppEnums.ItemWhereType.eCashInventory == self._materialItemWhereType then
    size = cashInventory:size()
  else
    local warehouseWrapper = warehouse_get(self._waypointKey_ByWareHouse)
    size = warehouseWrapper:getSize()
  end
  if freeCount < 2 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_INVENTORY_LEAST_ONE"))
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local playerWeightPercent = allWeight / maxWeight * 100
  local s64_moneyWeight = selfPlayer:getMoneyInventory():getMoneyWeight_s64()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local moneyWeight = Int64toInt32(s64_moneyWeight) / 10000
  local equipmentWeight = Int64toInt32(s64_equipmentWeight) / 10000
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local invenWeight = allWeight - equipmentWeight - moneyWeight
  local playerFairyWeight = ToClient_getDecreaseWeightByFairy() / 10000
  if playerFairyWeight < 0 then
    playerFairyWeight = 0
  end
  local totalWeight = allWeight / maxWeight * 100
  if totalWeight >= 100 + playerFairyWeight then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_INVENTORY_WEIGHTOVER"))
    return
  end
  local sum_MaterialSlot = {}
  PaGlobal_Manufacture_Notify_All:clear()
  local doHaveNonStackableItem = false
  for index = 0, self._usingSlotCount - 1 do
    if true == self._materialSlotNoListItemIn[index] and size >= self._materialSlotNoList[index] then
      sum_MaterialSlot[#sum_MaterialSlot + 1] = self._materialSlotNoList[index]
      local itemWrapper
      if CppEnums.ItemWhereType.eInventory == self._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == self._materialItemWhereType then
        itemWrapper = getInventoryItemByType(self._materialItemWhereType, self._materialSlotNoList[index])
      else
        local warehouseWrapper = warehouse_get(self._waypointKey_ByWareHouse)
        itemWrapper = warehouseWrapper:getItem(self._materialSlotNoList[index])
      end
      PaGlobalFunc_Manufacture_Notify_All_SetResourceData(self._materialSlotNoList[index], itemWrapper)
      local itemStaticWrapper = itemWrapper:getStaticStatus()
      if false == itemStaticWrapper:isStackable() then
        doHaveNonStackableItem = true
      end
    end
  end
  if true == self._isMassManufacture and true == doHaveNonStackableItem then
    local message = PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_MASSMANUFACTURE_BTN_TOOLTIP")
    Proc_ShowMessage_Ack(message)
    return
  end
  if #sum_MaterialSlot == 0 then
    if self._actionIndex == 0 or self._actionIndex == 5 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_SLOT_LEAST_ONE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "ALCHEMY_MANUFACTURE_SLOT_EMPTY"))
    end
    return
  end
  if self._actionIndex ~= 7 and self:checkEquipCrystal() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_CRYSTAL_ALERT"))
    return
  end
  if false == ToClient_WorldMapIsShow() then
    Panel_Window_Warehouse:SetShow(false)
  end
  self._ui.stc_circle:AddEffect("UI_ItemInstall_Spin", true, 0, 0)
  if 7 == self._actionIndex then
    for key, value in pairs(sum_MaterialSlot) do
      local rv = repair_RepairItemBySelf(value)
      if rv == 0 then
        break
      end
    end
  else
    if CppEnums.ItemWhereType.eWarehouse == self._materialItemWhereType then
      PaGlobalFunc_DialogMain_All_Close()
    end
    local current_actionName = self._listAction[self._actionIndex]._actionName
    if true == _ContentsGroup_LifeStatManufacturing and true == self._isMassManufacture then
      current_actionName = self._listAction[self._actionIndex]._actionName .. "_MASS"
    end
    if self._isConsole == true then
      for idx = 0, self._slotMaxCount - 1 do
        if self._materialSlotNoList[idx] ~= nil and self._materialSlotNoList[idx] ~= self._defaultSlotNo and ToClient_Inventory_CheckItemLock(self._materialSlotNoList[0], self._materialItemWhereType) == true then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MANUFACTURE_NOMATERIAL"))
          PaGlobal_Manufacture_All:clearCurrentRepeatItemKey()
          return
        end
      end
    end
    Manufacture_Do(self._usingInstallationType, current_actionName, self._materialItemWhereType, self._materialSlotNoList[0], self._materialSlotNoList[1], self._materialSlotNoList[2], self._materialSlotNoList[3], self._materialSlotNoList[4])
  end
  audioPostEvent_SystemUi(0, 0)
  PaGlobalFunc_Manufacture_Notify_All_ResetCount()
  PaGlobalFunc_Manufacture_All_Close()
  if Panel_Window_WareHouseHistory ~= nil then
    PaGlobal_WareHouseHistory:close()
  end
  if Panel_WareHouseFunctionPanel_All ~= nil then
    PaGlobalFunc_WareHouseFunctionPanel_All_Close()
  end
  Interaction_Close()
  audioPostEvent_SystemUi(13, 11)
end
function HandleEventRUp_Manufacture_All_ClearMaterial(index)
  if MessageBoxGetShow() then
    return
  end
  audioPostEvent_SystemUi(13, 12)
  StopManufactureAction()
  PaGlobal_Manufacture_All:resetGrindJewelSetting()
  local defaultSlotNo = PaGlobal_Manufacture_All._defaultSlotNo
  if index < PaGlobal_Manufacture_All._usingSlotCount then
    PaGlobal_Manufacture_All._materialSlotNoList[index] = defaultSlotNo
    PaGlobal_Manufacture_All._materialSlotNoListItemIn[index] = false
    for ii = index, PaGlobal_Manufacture_All._usingSlotCount - 1 - 1 do
      if defaultSlotNo == PaGlobal_Manufacture_All._materialSlotNoList[ii] and defaultSlotNo ~= PaGlobal_Manufacture_All._materialSlotNoList[ii + 1] then
        PaGlobal_Manufacture_All._materialSlotNoList[ii] = PaGlobal_Manufacture_All._materialSlotNoList[ii + 1]
        PaGlobal_Manufacture_All._materialSlotNoList[ii + 1] = defaultSlotNo
      else
        break
      end
    end
  end
  Panel_Tooltip_Item_hideTooltip()
  if CppEnums.ItemWhereType.eInventory == PaGlobal_Manufacture_All._materialItemWhereType or CppEnums.ItemWhereType.eCashInventory == PaGlobal_Manufacture_All._materialItemWhereType then
    PaGlobal_Manufacture_All:updateSlot()
  else
    PaGlobal_Manufacture_All:updateSlotWarehouse()
  end
  PaGlobal_Manufacture_All_UpdateManufactureButton()
  if _ContentsGroup_LifeSimulator == true then
    local currentActionName = PaGlobal_Manufacture_All._listAction[PaGlobal_Manufacture_All._actionIndex]._actionName
    if PaGloabl_Alchemy_RateViewList_CalculateManufacture ~= nil then
      PaGloabl_Alchemy_RateViewList_CalculateManufacture(currentActionName, PaGlobal_Manufacture_All._materialSlotNoList[0], PaGlobal_Manufacture_All._materialSlotNoList[1], PaGlobal_Manufacture_All._materialSlotNoList[2], PaGlobal_Manufacture_All._materialSlotNoList[3], PaGlobal_Manufacture_All._materialSlotNoList[4])
    end
  end
end
function PaGlobalFunc_Manufacture_All_ShowRateView(isShow)
  if Panel_Window_Manufacture_All == nil or Panel_Window_Manufacture_All:GetShow() == false then
    return
  end
  if isShow == true then
    PaGlobal_Manufacture_All._ui.btn_rateView:SetShow(true)
  else
    PaGlobal_Manufacture_All._ui.btn_rateView:SetShow(false)
  end
end
function HandleEventLUp_Manufacture_All_OpenRateViewList()
  if _ContentsGroup_LifeSimulator == false then
    return
  end
  if PaGloabl_Alchemy_RateViewList_Open ~= nil then
    PaGloabl_Alchemy_RateViewList_Open()
  end
end
