function PaGlobal_ImperialSupplyMSG:initialize()
  if PaGlobal_ImperialSupplyMSG._initialize == true then
    return
  end
  PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_BottomBG")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot1 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot1")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot2 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot2")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot3 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot3")
  PaGlobal_ImperialSupplyMSG._ui._stc_moneyBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_DescEdge")
  PaGlobal_ImperialSupplyMSG._ui._stc_money = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_moneyBG, "StaticText_Desc")
  PaGlobal_ImperialSupplyMSG._ui._btn_supply = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Button_Supply")
  PaGlobal_ImperialSupplyMSG._ui._stc_title = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_TitleArea")
  PaGlobal_ImperialSupplyMSG._ui._btn_X = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_title, "Button_Close")
  PaGlobal_ImperialSupplyMSG._ui._btn_close = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Button_Cancel")
  PaGlobal_ImperialSupplyMSG._ui._stc_bottomDescBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_BottomDesc")
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomDescBG, "StaticText_Desc")
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_DESC"))
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_KeyGuide_ConsoleUI_Import")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_X_ConsoleUI")
  PaGlobal_ImperialSupplyMSG:controlSetShow()
  if nil ~= self._ui._stc_slot1 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot1
    SlotItem.new(slot, "ItemSlot1", 0, self._ui._stc_slot1, self._slotConfig)
    slot:createChild()
    self._Slot1 = slot
  end
  if nil ~= self._ui._stc_slot2 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot2
    SlotItem.new(slot, "ItemSlot2", 0, self._ui._stc_slot2, self._slotConfig)
    slot:createChild()
    self._Slot2 = slot
  end
  if nil ~= self._ui._stc_slot3 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot3
    SlotItem.new(slot, "ItemSlot3", 0, self._ui._stc_slot3, self._slotConfig)
    slot:createChild()
    self._Slot3 = slot
  end
  PaGlobal_ImperialSupplyMSG:registEventHandler()
  PaGlobal_ImperialSupplyMSG:validate()
  PaGlobal_ImperialSupplyMSG._initialize = true
end
function PaGlobal_ImperialSupplyMSG:registEventHandler()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  PaGlobal_ImperialSupplyMSG._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:close()")
  PaGlobal_ImperialSupplyMSG._ui._btn_X:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:close()")
  PaGlobal_ImperialSupplyMSG._ui._btn_supply:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:SupplyMsg()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_ImperialSupply_Horse_Confirm:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ImperialSupplyMSG:SupplyMsg()")
  end
end
function PaGlobal_ImperialSupplyMSG:prepareOpen()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  PaGlobal_ImperialSupplyMSG:open()
end
function PaGlobal_ImperialSupplyMSG:open()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  Panel_ImperialSupply_Horse_Confirm:SetShow(true)
end
function PaGlobal_ImperialSupplyMSG:prepareClose()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ImperialSupplyMSG:close()
end
function PaGlobal_ImperialSupplyMSG:close()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  Panel_ImperialSupply_Horse_Confirm:SetShow(false)
end
function PaGlobal_ImperialSupplyMSG_Close()
  PaGlobal_ImperialSupplyMSG:prepareClose()
end
function PaGlobal_ImperialSupplyMSG:SupplyMsg()
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_TEXT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALMSG_DESC")
  local servantInfo = PaGlobalFunc_ServantList_All_ServantInfo()
  if servantInfo ~= nil and servantInfo:isUsedAnyAddStatItem() == true then
    _desc = _desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_BUFF_USE_WARN")
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = PaGlobal_ImperialSupplyMSG_SoupplyHorse,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_ImperialSupplyMSG:update()
  local servantInfo = PaGlobalFunc_ServantList_All_ServantInfo()
  if nil == servantInfo then
    return
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  local _isMutationHorse = servantInfo:getVehicleType() == __eVehicleType_Horse and servantInfo:getVehicleSubType() == __eTVehicleSubType_MutationHorse
  local horseTier = servantInfo:getTier()
  local currentServantNo = PaGlobalFunc_ServantList_All_CurrentSelectSlotNo()
  PaGlobal_ImperialSupplyMSG:item1(horseTier)
  PaGlobal_ImperialSupplyMSG:item2(horseTier)
  PaGlobal_ImperialSupplyMSG._ui._stc_money:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_MONEY", "money", resultMoney))
  PaGlobal_ImperialSupplyMSG:itemSlotAlign(0)
  if _isMutationHorse == true then
    _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABLE_SUPPLY_TWINS", "resultMoney", resultMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
    PaGlobal_ImperialSupplyMSG:item3()
    PaGlobal_ImperialSupplyMSG:itemSlotAlign(1)
  elseif 9 == horseTier then
    PaGlobal_ImperialSupplyMSG:itemSlotAlign(2)
  end
end
function PaGlobal_ImperialSupplyMSG:MouseLupEvent_supplyHorse()
  local currentServantNo = PaGlobalFunc_ServantList_All_CurrentSelectSlotNo()
  stable_changeToReward(currentServantNo, CppEnums.ServantToRewardType.Type_Money)
  PaGlobal_ServantList_All._SellCheck = true
  PaGlobal_ImperialSupplyMSG:prepareClose()
end
function PaGlobal_ImperialSupplyMSG_SoupplyHorse()
  PaGlobal_ImperialSupplyMSG:MouseLupEvent_supplyHorse()
end
function PaGlobal_ImperialSupplyMSG:itemSlotAlign(index)
  if 1 == index then
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetShow(false)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetShow(false)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetSpanSize(0, 80)
  elseif 2 == index then
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetSpanSize(0, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetShow(false)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetShow(false)
  elseif _ContentsGroup_ServantFantasyMix == false then
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetSpanSize(0, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetShow(false)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetShow(false)
  elseif true == self._event then
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetSpanSize(-50, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetSpanSize(0, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetSpanSize(50, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetShow(true)
  else
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetSpanSize(-25, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetSpanSize(25, 80)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot1:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot2:SetShow(true)
    PaGlobal_ImperialSupplyMSG._ui._stc_slot3:SetShow(false)
  end
end
function PaGlobal_ImperialSupplyMSG:item1(horseTier)
  local itemCount, item1
  itemCount = horseTier
  item1 = getItemEnchantStaticStatus(ItemEnchantKey(1020))
  if nil ~= item1 then
    self._Slot1:setItemByStaticStatus(item1, itemCount)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._stc_slot1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 1)")
      self._ui._stc_slot1:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    else
      self._Slot1.icon:addInputEvent("Mouse_On", "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 1," .. horseTier .. ")")
      self._Slot1.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    end
  end
  local itemCount, item3
  if 9 ~= horseTier and true == self._event then
    itemCount = horseTier * 2
    item3 = getItemEnchantStaticStatus(ItemEnchantKey(768897))
  end
  if nil ~= item3 then
    self._Slot3:setItemByStaticStatus(item1, itemCount)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._stc_slot3:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 4)")
      self._ui._stc_slot3:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    else
      self._Slot3.icon:addInputEvent("Mouse_On", "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 4," .. horseTier .. ")")
      self._Slot3.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    end
  end
end
function PaGlobal_ImperialSupplyMSG:item2(horseTier)
  local itemCount = 0
  if 1 == horseTier then
    itemCount = 1
  elseif 2 == horseTier then
    itemCount = 2
  elseif 3 == horseTier then
    itemCount = 3
  elseif 4 == horseTier then
    itemCount = 4
  elseif 5 == horseTier then
    itemCount = 5
  elseif 6 == horseTier then
    itemCount = 10
  elseif 7 == horseTier then
    itemCount = 15
  elseif 8 == horseTier then
    itemCount = 20
  elseif 9 == horseTier then
    itemCount = 0
  end
  if true == self._event then
    itemCount = itemCount * 2
  end
  local item2 = getItemEnchantStaticStatus(ItemEnchantKey(757003))
  if nil ~= item2 then
    self._Slot2:setItemByStaticStatus(item2, itemCount)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._stc_slot2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 2)")
      self._ui._stc_slot2:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    else
      self._Slot2.icon:addInputEvent("Mouse_On", "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 2)")
      self._Slot2.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    end
  end
end
function PaGlobal_ImperialSupplyMSG:item3()
  local item3 = getItemEnchantStaticStatus(ItemEnchantKey(752379))
  if nil ~= item3 then
    self._Slot3:setItemByStaticStatus(item3, 1)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._stc_slot3:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 3)")
      self._ui._stc_slot3:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    else
      self._Slot3.icon:addInputEvent("Mouse_On", "PaGlobal_ImperialSupplyMSG:showItemTooltip(true, 3)")
      self._Slot3.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    end
  end
end
function PaGlobal_ImperialSupplyMSG:validate()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
end
function PaGlobal_ImperialSupplyMSG:showItemTooltip(isShow, index, horseTier)
  if nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local isControl, itemSSW
  if 1 == index then
    isControl = self._Slot1.icon
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(1020))
  elseif 2 == index then
    isControl = self._Slot2.icon
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(757003))
  elseif 3 == index then
    isControl = self._Slot3.icon
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(752379))
  elseif 4 == index then
    isControl = self._Slot3.icon
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(768897))
  end
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
  else
    Panel_Tooltip_Item_Show_ImperialHorse(itemSSW, isControl, true)
  end
end
function PaGlobal_ImperialSupplyMSG:controlSetShow()
  if nil == Panel_ImperialSupply_Horse_Confirm then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._stc_keyGuideBg:SetShow(false)
    Panel_ImperialSupply_Horse_Confirm:SetSize(500, 655)
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
  else
    Panel_ImperialSupply_Horse_Confirm:SetSize(500, 600)
    self._ui._btn_supply:SetShow(false)
    self._ui._btn_close:SetShow(false)
    self._ui._btn_X:SetShow(false)
    self._ui._stc_keyGuideBg:SetShow(true)
    local keyGuide = {
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X
    }
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if true == _ContentsGroup_ServantFantasyMix then
    PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_DESC"))
  else
    PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_CONSOLE_DESC"))
  end
end
