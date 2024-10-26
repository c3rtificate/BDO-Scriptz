function PaGlobalFunc_CollectToolBox_All_Open()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  PaGlobal_CollectToolBox_All:prepareOpen()
end
function PaGlobalFunc_CollectToolBox_All_Close()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  PaGlobal_CollectToolBox_All:prepareClose()
end
function PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip(index, setShow)
  if setShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local self = PaGlobal_CollectToolBox_All
  local itemWrapper = ToClient_GetCollectToolInCollectToolBag(self._collectTypeList[index])
  if itemWrapper == nil then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, self._slots[index].icon)
  else
    Panel_Tooltip_Item_Show(itemWrapper, self._slots[index].icon, false, true, nil, nil, nil, nil, "InventoryBag", "index")
  end
end
function HandleEventRUp_CollectToolBox_All_SlotRClick(index)
  local self = PaGlobal_CollectToolBox_All
  if self._isConsole == true then
    self._popToolBagItem = true
    self._popToolBagItemIdx = index
  end
  ToClient_ReqPopToolBagItemToInventory(self._collectTypeList[index])
end
function FromClient_CollectToolBoxUpdate()
  if Panel_Window_CollectToolBox_All:GetShow() == false then
    return
  end
  PaGlobal_CollectToolBox_All:update()
end
function PaGloablFunc_CollectToolBox_All_SetFilter(slotNo, itemWrapper, count, inventoryType)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return true
  end
  if itemWrapper == nil then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if isDuplicatedForDuel == true then
    return true
  end
  local isOriginalForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if isOriginalForDuel == true then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW:get():checkToPushToInventoryBag() == false then
    return true
  end
  if Inventory_GetCurrentInventoryType() ~= CppEnums.ItemWhereType.eInventory then
    return true
  end
  if ToClient_CheckToPushToToolBag(CppEnums.ItemWhereType.eInventory, slotNo) == false then
    return true
  end
  if itemSSW:isPcRoomOnly() == true then
    return true
  end
  local myClass = selfPlayer:getClassType()
  local isEquipItem = itemSSW:isEquipable()
  local isUsableItem = itemSSW:get()._usableClassType:isOn(myClass)
  local isPushableItem = itemWrapper:isPushableInventoryBag()
  local isCollectTool = itemSSW:isCollectTool()
  if isEquipItem == true and isUsableItem == true and isPushableItem == true and isCollectTool == true then
    return false
  end
  return true
end
function HandleEventRUp_CollectToolBox_All_InvenRClick(slotNo, itemWrapper, count, inventoryType)
  local itemStatic = itemWrapper:getStaticStatus()
  if itemWrapper == nil then
    return
  end
  ToClient_ReqPushInventoryItemToToolBag(slotNo)
end
function PaGlobalFunc_CollectToolBox_All_IsShow()
  if Panel_Window_CollectToolBox_All == nil then
    return false
  end
  return Panel_Window_CollectToolBox_All:GetShow()
end
