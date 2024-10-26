PaGlobal_MakeGoonWang = {
  _ui = {
    rdo_Method1 = nil,
    rdo_Method2 = nil,
    rdo_Method3 = nil,
    stc_Mat1 = nil,
    stc_Mat2 = nil,
    stc_Result = nil,
    txt_Result = nil,
    btn_Make = nil,
    btn_Close = nil,
    stc_matListBg = nil,
    list2_MatList = nil,
    btn_SelectMat = nil,
    btn_CloseMat = nil,
    stc_KeyGuideBg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  },
  _targetItemList = Array.new(),
  _selectSlotIndex = -1,
  _doImprove = false,
  _doAnimation = false,
  _animationTime = 0,
  _animationPlayTime = 0,
  _methodType = 0,
  _selectedMainItemType = -1,
  _selected_MainItemSlotNo = -1,
  _selected_SubMatSelectSlotNo = -1,
  _selected_BossWeaponSelectSlotNo = -1,
  _resultItemKey = -1,
  _blackStarKeyForIcon = ItemEnchantKey(715001, 20),
  _fireOfPremitiveKeyForIcon = ItemEnchantKey(767076, 0),
  _twilightGemKeyForIcon = ItemEnchantKey(767077, 0),
  _bossWeaponKeyForIcon = ItemEnchantKey(11360, 20),
  _initialize = false,
  _doPlaySequence = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MakeGoonWang_Init")
function FromClient_MakeGoonWang_Init()
  PaGlobal_MakeGoonWang:initialize()
end
function PaGlobal_MakeGoonWang:initialize()
  if true == PaGlobal_MakeGoonWang._initialize or nil == Panel_Window_MakeGoonWang then
    return
  end
  local topBg = UI.getChildControl(Panel_Window_MakeGoonWang, "Static_TabArea")
  self._tabSelectCircle = UI.getChildControl(topBg, "Static_SelectedCircle")
  self._ui.rdo_Method1 = UI.getChildControl(topBg, "RadioButton_1")
  self._ui.rdo_Method2 = UI.getChildControl(topBg, "RadioButton_2")
  self._ui.rdo_Method3 = UI.getChildControl(topBg, "RadioButton_3")
  self._ui._midBg = UI.getChildControl(Panel_Window_MakeGoonWang, "Static_SelectBG")
  self._ui.stc_Mat1Bg = UI.getChildControl(self._ui._midBg, "Static_ItemSlot_Material_1")
  self._ui.stc_Mat1 = UI.getChildControl(self._ui.stc_Mat1Bg, "Static_Icon")
  self._ui.stc_Mat1Plus = UI.getChildControl(self._ui.stc_Mat1Bg, "Static_PlusIcon")
  self._ui.stc_Mat1Slot = {}
  SlotItem.new(self._ui.stc_Mat1Slot, "MakeGoonWang_All_Mat1", 0, self._ui.stc_Mat1, self._slotConfig)
  self._ui.stc_Mat1Slot:createChild()
  self._ui.stc_Mat2Bg = UI.getChildControl(self._ui._midBg, "Static_ItemSlot_Material_2")
  self._ui.stc_Mat2 = UI.getChildControl(self._ui.stc_Mat2Bg, "Static_Icon")
  self._ui.stc_Mat2Plus = UI.getChildControl(self._ui.stc_Mat2Bg, "Static_PlusIcon")
  self._ui.stc_Mat2Slot = {}
  SlotItem.new(self._ui.stc_Mat2Slot, "MakeGoonWang_All_Mat2", 0, self._ui.stc_Mat2, self._slotConfig)
  self._ui.stc_Mat2Slot:createChild()
  self._ui.stc_Mat3Bg = UI.getChildControl(self._ui._midBg, "Static_ItemSlot_Material_3")
  self._ui.stc_Mat3 = UI.getChildControl(self._ui.stc_Mat3Bg, "Static_Icon")
  self._ui.stc_Mat3Slot = {}
  SlotItem.new(self._ui.stc_Mat3Slot, "MakeGoonWang_All_Mat3", 0, self._ui.stc_Mat3, self._slotConfig)
  self._ui.stc_Mat3Slot:createChild()
  self._ui.stc_Mat3Slot.enchantText:SetFontColor(Defines.Color.C_FFEBC467)
  self._ui.stc_ResultBg = UI.getChildControl(self._ui._midBg, "Static_ItemSlot_Result")
  self._ui.stc_Result = UI.getChildControl(self._ui.stc_ResultBg, "Static_Icon")
  self._ui.stc_ResultSlot = {}
  SlotItem.new(self._ui.stc_ResultSlot, "MakeGoonWang_All_Result", 0, self._ui.stc_Result, self._slotConfig)
  self._ui.stc_ResultSlot:createChild()
  self._ui.stc_ResultSlot.icon:SetPosX(1)
  self._ui.stc_ResultSlot.icon:SetPosY(1)
  self._ui.txt_Result = UI.getChildControl(Panel_Window_MakeGoonWang, "StaticText_Congraturation")
  self._ui.btn_Make = UI.getChildControl(Panel_Window_MakeGoonWang, "Button_Do")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_MakeGoonWang, "Button_Close")
  self._ui.stc_KeyGuideBg = UI.getChildControl(Panel_Window_MakeGoonWang, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuideBg, "StaticText_X_ConsoleUI")
  self._ui.stc_matListBg = UI.getChildControl(Panel_Window_MakeGoonWang, "Static_SelectBox")
  self._ui.list2_MatList = UI.getChildControl(self._ui.stc_matListBg, "List2_MeterialItem")
  local list2_content = UI.getChildControl(self._ui.list2_MatList, "List2_1_Content")
  local rdo_content = UI.getChildControl(list2_content, "RadioButton_Box_1")
  local stc_slot = UI.getChildControl(rdo_content, "Static_ItemSlotBg")
  local itemSlot = {}
  SlotItem.new(itemSlot, "MakeGoonWang_All_List2Slot", 0, stc_slot, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetPosX(1)
  itemSlot.icon:SetPosY(1)
  itemSlot.border:SetSize(44, 44)
  self._ui.btn_SelectMat = UI.getChildControl(self._ui.stc_matListBg, "Button_Apply")
  self._ui.btn_CloseMat = UI.getChildControl(self._ui.stc_matListBg, "Button_Cancel")
  self._ui.stc_ReadyBg = UI.getChildControl(Panel_Window_MakeGoonWang, "Static_ReadyBg")
  PaGlobal_MakeGoonWang:registEventHandler()
  PaGlobal_MakeGoonWang._initialize = true
end
function PaGlobal_MakeGoonWang:registEventHandler()
  self._ui.rdo_Method1:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:initSlotForMethod( 0 )")
  self._ui.rdo_Method2:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:initSlotForMethod( 1 )")
  self._ui.rdo_Method3:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:initSlotForMethod( 2 )")
  self._ui.btn_Make:addInputEvent("Mouse_LUp", "HandleEventLUp_MakeGoonWang_MessageBox()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MakeGoonWang_Close()")
  registerEvent("FromClient_ResponseMakeGoonWangItem", "FromClient_ResponseMakeGoonWangItem")
  registerEvent("FromClient_StopSequence", "FromClient_StopSequence_MakeGoonWangItem")
  self._ui.list2_MatList:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MakeGoonWang_List2Update")
  self._ui.list2_MatList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_SelectMat:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:closeList2Bg()")
  self._ui.btn_CloseMat:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:closeList2Bg()")
  self._ui.stc_Mat1Slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_MakeGoonWang_OpenFilteredItemList(1)")
  self._ui.stc_Mat1Slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MakeGoonWang_ShowToolTip( false )")
  self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MakeGoonWang_ShowToolTip( false )")
  self._ui.stc_Mat3Slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MakeGoonWang_ShowToolTip( false )")
  Panel_Window_MakeGoonWang:addInputEvent("Mouse_LUp", "PaGlobal_MakeGoonWang:closeList2Bg()")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_MakeGoonWang:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_MakeGoonWang:initSlotForMethodForPad( false )")
    Panel_Window_MakeGoonWang:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_MakeGoonWang:initSlotForMethodForPad( true )")
  else
    self._ui.stc_Mat1Slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_MakeGoonWang_ClearItem( 1 )")
  end
end
function PaGlobal_MakeGoonWang:prepareOpen()
  self._doPlaySequence = false
  self._ui.txt_Result:SetShow(false)
  self._ui.btn_Make:SetShow(true)
  self._ui.btn_Close:SetShow(false)
  self._ui.rdo_Method1:SetIgnore(false)
  self._ui.rdo_Method2:SetIgnore(false)
  self._ui.rdo_Method3:SetIgnore(false)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_MakeGoonWang:open()
  PaGlobal_MakeGoonWang:resize()
  PaGlobal_MakeGoonWang:initSlotForMethod(self._methodType)
  Panel_Window_MakeGoonWang:RegisterUpdateFunc("FromClient_MakeGoonWang_UpdatePerframe")
end
function PaGlobal_MakeGoonWang:resize()
  Panel_Window_MakeGoonWang:ComputePosAllChild()
  if _ContentsGroup_UsePadSnapping then
    local temp = {
      self._ui.stc_KeyGuide_X,
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(temp, self._ui.stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobal_MakeGoonWang:open()
  Panel_Window_MakeGoonWang:SetShow(true)
end
function PaGlobal_MakeGoonWang:closeList2Bg()
  PaGlobal_MakeGoonWang._ui.stc_matListBg:SetShow(false)
end
function PaGlobal_MakeGoonWang:prepareClose()
  Panel_Tooltip_Item_hideTooltip()
  Panel_Window_MakeGoonWang:ClearUpdateLuaFunc()
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_MakeGoonWang:close()
end
function PaGlobal_MakeGoonWang:close()
  Panel_Window_MakeGoonWang:SetShow(false)
end
function PaGlobal_MakeGoonWang:initSlotForMethodForPad(isUp)
  local temp = self._methodType
  if isUp == true then
    temp = temp + 1
  else
    temp = temp - 1
  end
  if temp >= 3 then
    temp = 0
  elseif temp <= -1 then
    temp = 2
  end
  PaGlobal_MakeGoonWang:initSlotForMethod(temp)
end
function PaGlobal_MakeGoonWang:initSlotForMethod(type)
  self._methodType = type
  self._ui.stc_Mat1Slot:clearItem()
  self._ui.stc_Mat2Slot:clearItem()
  self._ui.stc_Mat3Slot:clearItem()
  self._ui.stc_ResultSlot:clearItem()
  self._selectedMainItemType = -1
  self._selectSlotIndex = -1
  self._selected_MainItemSlotNo = -1
  self._selected_SubMatSelectSlotNo = -1
  self._selected_BossWeaponSelectSlotNo = -1
  self._resultItemKey = -1
  self._ui.txt_Result:SetShow(false)
  self._ui.stc_matListBg:SetShow(false)
  self._ui.stc_ResultBg:SetIgnore(true)
  self._ui.stc_Mat1Bg:SetShow(true)
  self._ui.stc_Mat2Bg:SetShow(true)
  self._ui.stc_Mat3Bg:SetShow(self._methodType == 2)
  self._ui.stc_ResultBg:SetShow(false)
  Panel_Tooltip_Item_hideTooltip()
  self._ui.rdo_Method1:SetCheck(self._methodType == 0)
  self._ui.rdo_Method2:SetCheck(self._methodType == 1)
  self._ui.rdo_Method3:SetCheck(self._methodType == 2)
  if self._methodType == 0 then
    self._tabSelectCircle:SetSpanSize(self._ui.rdo_Method1:GetSpanSize().x, self._tabSelectCircle:GetSpanSize().y)
  elseif self._methodType == 1 then
    self._tabSelectCircle:SetSpanSize(self._ui.rdo_Method2:GetSpanSize().x, self._tabSelectCircle:GetSpanSize().y)
  else
    self._tabSelectCircle:SetSpanSize(self._ui.rdo_Method3:GetSpanSize().x, self._tabSelectCircle:GetSpanSize().y)
  end
  PaGlobal_MakeGoonWang:update()
end
function PaGlobal_MakeGoonWang:update()
  PaGlobal_MakeGoonWang:updateMat1Slot()
  PaGlobal_MakeGoonWang:updateMat2SlotForSubMat()
  PaGlobal_MakeGoonWang:updateMat2SlotForBossWeapon()
  self._ui.stc_Mat1Plus:SetShow(self._selected_MainItemSlotNo == -1)
  self._ui.stc_Mat1Slot.icon:SetMonoTone(self._selected_MainItemSlotNo == -1)
  self._ui.stc_Mat2Slot.icon:SetMonoTone(self._selected_SubMatSelectSlotNo == -1)
  self._ui.stc_Mat3Slot.icon:SetMonoTone(self._selected_SubMatSelectSlotNo == -1)
  self._ui.stc_ReadyBg:SetShow(self._selected_MainItemSlotNo ~= -1 and self._selected_SubMatSelectSlotNo ~= -1)
  if self._methodType == 1 then
    self._ui.stc_Mat2Plus:SetShow(false)
  elseif self._methodType == 2 then
    self._ui.stc_Mat2Plus:SetShow(self._selected_BossWeaponSelectSlotNo == -1)
    self._ui.stc_Mat2Slot.icon:SetMonoTone(self._selected_BossWeaponSelectSlotNo == -1)
    self._ui.stc_ReadyBg:SetShow(self._selected_MainItemSlotNo ~= -1 and self._selected_SubMatSelectSlotNo ~= -1 and self._selected_BossWeaponSelectSlotNo ~= -1)
  else
    self._ui.stc_Mat2Plus:SetShow(self._selected_SubMatSelectSlotNo == -1)
  end
end
function PaGlobal_MakeGoonWang:updateMat1Slot()
  if self._selected_MainItemSlotNo ~= -1 then
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_MainItemSlotNo)
    if itemWrapper ~= nil then
      self._ui.stc_Mat1Slot:setItem(itemWrapper, 1)
      self._ui.stc_Mat1Slot.icon:SetMonoTone(false, false)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat1Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-1,1,true)")
      else
        self._ui.stc_Mat1Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-1,1,true)")
      end
    end
  else
    local blackStartItemSSW = getItemEnchantStaticStatus(self._blackStarKeyForIcon)
    if nil == blackStartItemSSW then
      return
    end
    self._ui.stc_Mat1Slot:setItemByStaticStatus(blackStartItemSSW, 1)
    if _ContentsGroup_UsePadSnapping == false then
      self._ui.stc_Mat1Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(0,nil,1,true)")
    else
      self._ui.stc_Mat1Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(0,nil,1,true)")
    end
  end
end
function PaGlobal_MakeGoonWang:updateMat2SlotForSubMat()
  if self._selected_SubMatSelectSlotNo ~= -1 then
    local itemWrapper
    if self._methodType == 2 then
      itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_BossWeaponSelectSlotNo)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-3,2,true)")
      else
        self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-3,2,true)")
      end
    else
      itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_SubMatSelectSlotNo)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,2,true)")
      else
        self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,2,true)")
      end
    end
    if itemWrapper ~= nil then
      self._ui.stc_Mat2Slot:setItem(itemWrapper, itemWrapper:get():getCount_s64())
      self._ui.stc_Mat2Slot.icon:SetMonoTone(false, false)
    end
  elseif self._methodType == 0 then
    local blackStartItemSSW = getItemEnchantStaticStatus(self._blackStarKeyForIcon)
    self._ui.stc_Mat2Slot:setItemByStaticStatus(blackStartItemSSW, 1)
    if _ContentsGroup_UsePadSnapping == false then
      self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(0,nil,2,true)")
    else
      self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(0,nil,2,true)")
    end
    self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_MakeGoonWang_OpenFilteredItemList(2)")
    self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_MakeGoonWang_ClearItem( 2 )")
  elseif self._methodType == 1 then
    self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_LUp", "")
    self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_RUp", "")
    local fireOfPremitiveItemWrapper, slotNo = PaGlobal_MakeGoonWang:findItemWrapper(self._fireOfPremitiveKeyForIcon:getItemKey())
    if fireOfPremitiveItemWrapper ~= nil then
      self._ui.stc_Mat2Slot:setItem(fireOfPremitiveItemWrapper, slotNo)
      self._ui.stc_Mat2Slot.icon:SetMonoTone(false, false)
      self._selected_SubMatSelectSlotNo = slotNo
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,2,true )")
      else
        self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,2,true )")
      end
    else
      fireOfPremitiveItemWrapper = getItemEnchantStaticStatus(self._fireOfPremitiveKeyForIcon)
      if nil == fireOfPremitiveItemWrapper then
        return
      end
      self._ui.stc_Mat2Slot:setItemByStaticStatus(fireOfPremitiveItemWrapper, 1)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(1,nil,2,true)")
      else
        self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(1,nil,2,true)")
      end
    end
  elseif self._methodType == 2 then
    local twilghtWrapper, slotNo = PaGlobal_MakeGoonWang:findItemWrapper(self._twilightGemKeyForIcon:getItemKey())
    if twilghtWrapper ~= nil then
      self._ui.stc_Mat3Slot:setItem(twilghtWrapper, slotNo)
      self._ui.stc_Mat3Slot.icon:SetMonoTone(false, false)
      self._selected_SubMatSelectSlotNo = slotNo
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat3Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,3,true )")
      else
        self._ui.stc_Mat3Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-2,3,true )")
      end
    else
      local twilghtWrapper = getItemEnchantStaticStatus(self._twilightGemKeyForIcon)
      if nil == twilghtWrapper then
        return
      end
      self._ui.stc_Mat3Slot:setItemByStaticStatus(twilghtWrapper, 1)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat3Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(3,nil,3,true )")
      else
        self._ui.stc_Mat3Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(3,nil,3,true )")
      end
    end
  end
end
function PaGlobal_MakeGoonWang:updateMat2SlotForBossWeapon()
  if self._methodType ~= 2 then
    return
  end
  self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_MakeGoonWang_OpenFilteredItemList(2)")
  self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_MakeGoonWang_ClearItem( 2 )")
  if self._selected_BossWeaponSelectSlotNo ~= -1 then
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_BossWeaponSelectSlotNo)
    if itemWrapper ~= nil then
      self._ui.stc_Mat2Slot:setItem(itemWrapper, itemWrapper:get():getCount_s64())
      self._ui.stc_Mat2Slot.icon:SetMonoTone(false, false)
      if _ContentsGroup_UsePadSnapping == false then
        self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-3,2,true)")
      else
        self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil,-3,2,true)")
      end
    end
  else
    local BossWeaponKeyItemSSW = getItemEnchantStaticStatus(self._bossWeaponKeyForIcon)
    if BossWeaponKeyItemSSW == nil then
      return
    end
    self._ui.stc_Mat2Slot:setItemByStaticStatus(BossWeaponKeyItemSSW)
    if _ContentsGroup_UsePadSnapping == false then
      self._ui.stc_Mat2Slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(2,nil,2,true )")
    else
      self._ui.stc_Mat2Bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(2,nil,2,true )")
    end
  end
end
function PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredWrapper, targetSlotNo1, targetSlotNo2, targetTable)
  if filteredWrapper == nil then
    return
  end
  local count = filteredWrapper:getCount()
  for i = 0, count - 1 do
    local slotNo = filteredWrapper:getByIndex(i)
    if targetSlotNo1 == -1 and targetSlotNo2 == -1 then
      targetTable:push_back(slotNo)
    elseif targetSlotNo1 ~= -1 and targetSlotNo2 ~= -1 then
      if targetSlotNo1 ~= slotNo and targetSlotNo2 ~= slotNo then
        targetTable:push_back(slotNo)
      end
    elseif targetSlotNo1 ~= -1 then
      if targetSlotNo1 ~= slotNo then
        targetTable:push_back(slotNo)
      end
    elseif targetSlotNo2 ~= -1 and targetSlotNo2 ~= slotNo then
      targetTable:push_back(slotNo)
    end
  end
end
function PaGlobal_MakeGoonWang:getTargetListForBlackStar()
  local slotNoTable = Array.new()
  local selectedSlotNo = -1
  if self._methodType == 0 then
    if self._selected_MainItemSlotNo ~= -1 then
      selectedSlotNo = self._selected_MainItemSlotNo
    elseif self._selected_SubMatSelectSlotNo ~= -1 then
      selectedSlotNo = self._selected_SubMatSelectSlotNo
    end
    if selectedSlotNo == -1 then
      local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarMain, true, false)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
      filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarAwaken, true, false)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
    else
      local filteredSlotList = ToClient_getFilteredItemListForGoonWang(self._selectedMainItemType, true, false)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
    end
  elseif self._methodType == 1 then
    local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarMain, true, false)
    PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
    filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarAwaken, true, false)
    PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
  elseif self._methodType == 2 then
    if self._selected_BossWeaponSelectSlotNo == -1 then
      local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarMain, true, false)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
      filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarAwaken, true, false)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
    else
      local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_BossWeaponSelectSlotNo)
      if itemWrapper == nil then
        return slotNoTable
      end
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW == nil then
        return slotNoTable
      end
      if itemSSW:get():isWeapon() == true then
        local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarMain, true, false)
        PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
      elseif itemSSW:get():isAwakenWeapon() == true then
        local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_BlackStarAwaken, true, false)
        PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_MainItemSlotNo, self._selected_SubMatSelectSlotNo, slotNoTable)
      end
    end
  end
  return slotNoTable
end
function PaGlobal_MakeGoonWang:updateForBossWeapon()
  local slotNoTable = Array.new()
  if self._selected_MainItemSlotNo == -1 then
    local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_KzakaMain, true, true)
    PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
    filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_OpinMain, true, true)
    PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
    filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_DandelionAwaken, true, true)
    PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
  else
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, self._selected_MainItemSlotNo)
    if itemWrapper == nil then
      return slotNoTable
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if itemSSW == nil then
      return slotNoTable
    end
    if itemSSW:get():isWeapon() == true then
      local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_KzakaMain, true, true)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
      filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_OpinMain, true, true)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
    elseif itemSSW:get():isAwakenWeapon() == true then
      local filteredSlotList = ToClient_getFilteredItemListForGoonWang(__eItemGroupType_DandelionAwaken, true, true)
      PaGlobal_MakeGoonWang:insertFilteredSlotNoToTable(filteredSlotList, self._selected_BossWeaponSelectSlotNo, nil, slotNoTable)
    end
  end
  return slotNoTable
end
function PaGlobal_MakeGoonWang:findItemWrapper(targetItemKey, targetEnchantLevel)
  local inventory = getSelfPlayer():get():getInventoryByType(__eItemWhereTypeInventory)
  if inventory == nil then
    return nil
  end
  local invenMaxSize = inventory:sizeXXX()
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(itemWhereType, ii)
    if itemWrapper ~= nil then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
      if itemKey == targetItemKey then
        if nil == targetEnchantLevel then
          return itemWrapper, ii
        elseif nil ~= targetEnchantLevel and enchantLevel == targetEnchantLevel then
          return itemWrapper, ii
        end
      end
    end
  end
  return nil
end
function PaGlobalFunc_MakeGoonWang_Open()
  if _ContentsGroup_ItemSkillOption == false then
    return
  end
  PaGlobal_MakeGoonWang:prepareOpen()
end
function PaGlobalFunc_MakeGoonWang_OnScreenResize()
  Panel_Window_MakeGoonWang:ComputePos()
end
function PaGlobalFunc_MakeGoonWang_Close()
  PaGlobal_MakeGoonWang:prepareClose()
end
function FromClient_MakeGoonWang_UpdatePerframe(deltaTime)
  PaGlobal_MakeGoonWang._animationTime = PaGlobal_MakeGoonWang._animationTime + deltaTime
  if PaGlobal_MakeGoonWang._doImprove == true then
    PaGlobal_MakeGoonWang._ui.btn_Make:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BUILDING_WORKMANAGER_BTN_CANCEL"))
  else
    PaGlobal_MakeGoonWang._ui.btn_Make:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAKEGOONWANG_BUTTON"))
  end
  if PaGlobal_MakeGoonWang._doAnimation == true then
    PaGlobal_MakeGoonWang._ui.btn_Make:SetIgnore(true)
  else
    PaGlobal_MakeGoonWang._ui.btn_Make:SetIgnore(false)
  end
  if PaGlobal_MakeGoonWang._animationPlayTime < PaGlobal_MakeGoonWang._animationTime and PaGlobal_MakeGoonWang._doImprove == true then
    ToClient_requestMakeGoonWangItem(PaGlobal_MakeGoonWang._methodType, PaGlobal_MakeGoonWang._selected_MainItemSlotNo, PaGlobal_MakeGoonWang._selected_SubMatSelectSlotNo, PaGlobal_MakeGoonWang._selected_BossWeaponSelectSlotNo)
    PaGlobal_MakeGoonWang._ui.stc_ResultSlot.icon:EraseAllEffect()
    PaGlobal_MakeGoonWang._ui.stc_ResultSlot.icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
    PaGlobal_MakeGoonWang._doImprove = false
    PaGlobal_MakeGoonWang._doAnimation = true
    PaGlobal_MakeGoonWang._animationTime = 0
  end
  if PaGlobal_MakeGoonWang._animationTime > 3 and PaGlobal_MakeGoonWang._doAnimation == true then
    PaGlobal_MakeGoonWang._animationTime = 0
    PaGlobal_MakeGoonWang._doAnimation = false
  end
end
function HandleEventLUp_MakeGoonWang_MessageBox()
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MAKEGOONWANG_ALERT"),
    functionYes = HandleEventLUp_MakeGoonWang_Do,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function HandleEventLUp_MakeGoonWang_Do()
  if PaGlobal_MakeGoonWang._doImprove == true then
    PaGlobal_MakeGoonWang._doImprove = false
    PaGlobal_MakeGoonWang._ui._midBg:EraseAllEffect()
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    PaGlobal_MakeGoonWang._animationTime = 0
    return
  end
  if PaGlobal_MakeGoonWang._methodType == -1 then
    return
  end
  if PaGlobal_MakeGoonWang._selected_MainItemSlotNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
    return
  end
  if PaGlobal_MakeGoonWang._selected_SubMatSelectSlotNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
    return
  end
  if PaGlobal_MakeGoonWang._methodType == 2 and PaGlobal_MakeGoonWang._selected_BossWeaponSelectSlotNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
    return
  end
  PaGlobal_MakeGoonWang._ui._midBg:EraseAllEffect()
  PaGlobal_MakeGoonWang._animationTime = 0
  PaGlobal_MakeGoonWang._doImprove = true
end
function HandleEventLUp_MakeGoonWang_SelectItem(slotNo, selectedSlotIndex)
  HandleEventOnOut_MakeGoonWang_ShowToolTip(false)
  local self = PaGlobal_MakeGoonWang
  if self._doImprove == true then
    return
  end
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local ItemKey = itemSSW:get()._key:getItemKey()
  if self._methodType == 0 and self._selected_MainItemSlotNo == -1 and self._selected_SubMatSelectSlotNo == -1 then
    local type = ToClient_getItemKeyGroupTypeByTItemKey(ItemKey)
    if type == __eItemGroupType_Count then
      return
    end
    self._selectedMainItemType = type
  end
  if selectedSlotIndex == 1 then
    self._selected_MainItemSlotNo = slotNo
  elseif selectedSlotIndex == 2 then
    if self._methodType == 0 then
      self._selected_SubMatSelectSlotNo = slotNo
    elseif self._methodType == 2 then
      self._selected_BossWeaponSelectSlotNo = slotNo
    end
  end
  self._ui.stc_matListBg:SetShow(false)
  PaGlobal_MakeGoonWang:update()
end
function HandleEventLUp_MakeGoonWang_ClearItem(selectedSlotIndex)
  if PaGlobal_MakeGoonWang._doImprove == true then
    return
  end
  local self = PaGlobal_MakeGoonWang
  if selectedSlotIndex == 1 then
    self._selected_MainItemSlotNo = -1
    self._ui.stc_Mat1Slot:clearItem()
  elseif selectedSlotIndex == 2 then
    self._ui.stc_Mat2Slot:clearItem()
    if self._methodType == 0 then
      self._selected_SubMatSelectSlotNo = -1
    elseif self._methodType == 2 then
      self._selected_BossWeaponSelectSlotNo = -1
    end
  end
  PaGlobal_MakeGoonWang:closeList2Bg()
  PaGlobal_MakeGoonWang:update()
end
function HandleEventLUp_MakeGoonWang_OpenFilteredItemList(slotIdx)
  local self = PaGlobal_MakeGoonWang
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  selfPlayer:sortInventorySlotNoNew(0, 2, 1)
  if self._methodType == 0 then
    self._targetItemList = PaGlobal_MakeGoonWang:getTargetListForBlackStar()
  elseif self._methodType == 1 then
    if slotIdx == 1 then
      self._targetItemList = PaGlobal_MakeGoonWang:getTargetListForBlackStar()
    end
  elseif self._methodType == 2 then
    if slotIdx == 1 then
      self._targetItemList = PaGlobal_MakeGoonWang:getTargetListForBlackStar()
    elseif slotIdx == 2 then
      self._targetItemList = PaGlobal_MakeGoonWang:updateForBossWeapon()
    end
  end
  if 0 >= #self._targetItemList then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_NO_MATERIAL"))
    return
  end
  self._selectSlotIndex = slotIdx
  local posX = self._ui._midBg:GetPosX() + self._ui.stc_Mat1Bg:GetPosX() - self._ui.stc_matListBg:GetSizeX() - 100
  local posY = self._ui._midBg:GetSpanSize().y + self._ui.stc_Mat1Bg:GetSpanSize().y + self._ui.stc_Mat1Bg:GetSizeY() - 6
  if slotIdx == 1 then
    self._ui.stc_matListBg:SetSpanSize(-posX, posY)
  elseif slotIdx == 2 then
    self._ui.stc_matListBg:SetSpanSize(posX, posY)
  end
  self._ui.stc_matListBg:SetShow(true)
  self._ui.stc_matListBg:ComputePosAllChild()
  self._ui.list2_MatList:getElementManager():clearKey()
  for idx = 1, #self._targetItemList do
    self._ui.list2_MatList:getElementManager():pushKey(toInt64(0, idx))
  end
end
function FromClient_MakeGoonWang_List2Update(content, key)
  local _key = Int64toInt32(key)
  if nil == PaGlobal_MakeGoonWang._targetItemList[_key] then
    return
  end
  if PaGlobal_MakeGoonWang._ui.stc_matListBg:GetShow() == false then
    PaGlobal_MakeGoonWang._ui.stc_matListBg:SetShow(true)
  end
  local slotNo = PaGlobal_MakeGoonWang._targetItemList[_key]
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
  if itemWrapper == nil then
    return
  end
  local rdo_content = UI.getChildControl(content, "RadioButton_Box_1")
  local stc_slot = UI.getChildControl(rdo_content, "Static_ItemSlotBg")
  local txt_name = UI.getChildControl(rdo_content, "StaticText_ItemName")
  local slot = {}
  SlotItem.reInclude(slot, "MakeGoonWang_All_List2Slot", 0, stc_slot, PaGlobal_ItemSkillOption_All._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper, itemWrapper:get():getCount_s64())
  local itemSSW = itemWrapper:getStaticStatus()
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(itemSSW:getName())
  PaGlobalFunc_Util_GetItemGradeColorName(itemSSW:get()._key)
  rdo_content:addInputEvent("Mouse_LUp", "HandleEventLUp_MakeGoonWang_SelectItem(" .. tostring(slotNo) .. "," .. tostring(PaGlobal_MakeGoonWang._selectSlotIndex) .. ")")
  rdo_content:addInputEvent("Mouse_Out", "HandleEventOnOut_MakeGoonWang_ShowToolTip(false)")
  if _ContentsGroup_UsePadSnapping == false then
    rdo_content:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil," .. tostring(slotNo) .. ",5,true)")
  else
    rdo_content:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(nil," .. tostring(slotNo) .. ",5,true)")
  end
end
function HandleEventOnOut_MakeGoonWang_ShowToolTip(SSWIndex, selectedSlotIndex, controlIndex, isShow)
  if PaGlobal_MakeGoonWang._doPlaySequence == true then
    return
  end
  if false == isShow or nil == isShow then
    if false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  local self = PaGlobal_MakeGoonWang
  local itemWrapper, control, key
  if SSWIndex ~= nil then
    if SSWIndex == 0 then
      key = self._blackStarKeyForIcon
    elseif SSWIndex == 1 then
      key = self._fireOfPremitiveKeyForIcon
    elseif SSWIndex == 2 then
      key = self._bossWeaponKeyForIcon
    elseif SSWIndex == 3 then
      key = self._twilightGemKeyForIcon
    elseif SSWIndex == 4 then
      key = ItemEnchantKey(self._resultItemKey, 0)
    end
    itemWrapper = getItemEnchantStaticStatus(key)
  else
    local slotIdx
    if selectedSlotIndex == -1 then
      slotIdx = self._selected_MainItemSlotNo
    elseif selectedSlotIndex == -2 then
      slotIdx = self._selected_SubMatSelectSlotNo
    elseif selectedSlotIndex == -3 then
      slotIdx = self._selected_BossWeaponSelectSlotNo
    else
      slotIdx = selectedSlotIndex
    end
    itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
  end
  if nil == itemWrapper then
    return
  end
  if controlIndex == 1 then
    control = self._ui.stc_Mat1
  elseif controlIndex == 2 then
    control = self._ui.stc_Mat2
  elseif controlIndex == 3 then
    control = self._ui.stc_Mat3
  elseif controlIndex == 4 then
    control = self._ui.stc_Result
  elseif controlIndex == 5 then
    control = self._ui.stc_matListBg
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    if _ContentsGroup_UsePadSnapping == true and Panel_Tooltup_Item_isShow() == true then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(itemWrapper, control, SSWIndex ~= nil)
  else
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    if SSWIndex ~= nil then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    end
  end
end
function FromClient_ResponseMakeGoonWangItem(resultItemKey)
  if Panel_Window_MakeGoonWang == nil then
    return
  end
  local self = PaGlobal_MakeGoonWang
  self._doPlaySequence = true
  PaGlobal_MakeGoonWang:initSlotForMethod(self._methodType)
  Panel_Window_MakeGoonWang:SetShow(false)
  PaGlobalFunc_DialogMain_All_CloseWithDialog()
  PaGlobalFunc_DialogMain_All_Close()
  self._resultItemKey = resultItemKey
end
function FromClient_StopSequence_MakeGoonWangItem()
  if Panel_Window_MakeGoonWang == nil then
    return
  end
  local self = PaGlobal_MakeGoonWang
  if self._doPlaySequence == false then
    return
  end
  local goonWangKeyItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._resultItemKey, 0))
  if nil == goonWangKeyItemSSW then
    return
  end
  self._ui.stc_ResultSlot.icon:SetMonoTone(false, false)
  self._ui.stc_ResultSlot:setItemByStaticStatus(goonWangKeyItemSSW, 1)
  self._ui.stc_ResultSlot.icon:EraseAllEffect()
  Panel_Window_MakeGoonWang:SetShow(true)
  self._ui.txt_Result:SetShow(true)
  self._ui.stc_ResultBg:SetIgnore(false)
  self._ui.stc_ResultBg:SetShow(true)
  self._ui.btn_Make:SetShow(false)
  self._ui.btn_Close:SetShow(true)
  self._ui.rdo_Method1:SetIgnore(true)
  self._ui.rdo_Method2:SetIgnore(true)
  self._ui.rdo_Method3:SetIgnore(true)
  self._ui.stc_Mat1Bg:SetShow(false)
  self._ui.stc_Mat2Bg:SetShow(false)
  self._ui.stc_Mat3Bg:SetShow(false)
  self._ui.stc_ResultSlot.icon:AddEffect("fUI_ItemEnchant_01A", true, 0, 0)
  self._doPlaySequence = false
  if _ContentsGroup_UsePadSnapping == false then
    self._ui.stc_ResultSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MakeGoonWang_ShowToolTip(4,nil,4,true)")
  else
    self._ui.stc_ResultSlot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_MakeGoonWang_ShowToolTip(4,nil,4,true)")
  end
  self._ui.stc_ResultSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MakeGoonWang_ShowToolTip( false )")
end
