function PaGlobal_ClothInventory_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_BlackBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_BG")
  self._ui.stc_TitleBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_TitleBg")
  self._ui.stc_DescBg = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_DescBg")
  self._ui.stc_itemSlotFrame = UI.getChildControl(Panel_Window_ClothInventory_All, "Frame_ItemSlot")
  self._ui.stc_itemSlotFrameContent = UI.getChildControl(self._ui.stc_itemSlotFrame, "Frame_1_Content")
  self._ui.stc_itemSlotFrameScroll = UI.getChildControl(self._ui.stc_itemSlotFrame, "Frame_1_VerticalScroll")
  self._ui.stc_SlotArea = UI.getChildControl(self._ui.stc_itemSlotFrameContent, "Static_ItemSlotArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleBg, "StaticText_Title")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBg, "StaticText_Desc")
  self._ui.stc_SlotBg = UI.getChildControl(self._ui.stc_SlotArea, "Static_SlotBg_Template")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBg, "Button_Close_PCUI")
  self._ui.btn_ChangeAll = UI.getChildControl(Panel_Window_ClothInventory_All, "Button_ChangeAll_PCUI")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_Window_ClothInventory_All, "Static_KeyGuideBg_ConsoleUI")
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.btn_ChangeAll:SetShow(not self._isConsole)
  local descStr = ""
  if self._isConsole == true then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_CONSOLE_DESC")
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_DESC")
  end
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(descStr)
  self:setKeyGuide()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ClothInventory_All:setKeyGuide()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local bottomKeyGuideY = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI")
  local bottomKeyGuideA = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_A_ConsoleUI")
  local bottomKeyGuideB = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_B_ConsoleUI")
  local keyGuideAlignY = {bottomKeyGuideY}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlignY, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if false == bottomKeyGuideY:GetShow() then
    bottomKeyGuideA:SetPosY(bottomKeyGuideY:GetPosY())
    bottomKeyGuideB:SetPosY(bottomKeyGuideY:GetPosY())
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
  else
    bottomKeyGuideA:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 7)
    bottomKeyGuideB:SetPosY(bottomKeyGuideY:GetPosY() + bottomKeyGuideY:GetTextSizeY() + 7)
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  end
  local keyGuideAlign = {bottomKeyGuideA, bottomKeyGuideB}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideAlign, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_ClothInventory_All:resizePanel()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  local intervalSize = 10
  local startPos = 10
  local slotSize = self._ui.stc_SlotBg:GetSizeY()
  for slotIndex = 0, #self._slotBg do
    self._slotBg[slotIndex]:SetShow(slotIndex < self._bagSize)
    self._slot[slotIndex].icon:SetShow(slotIndex < self._bagSize)
    self._slotBg[slotIndex]:SetPosX(startPos + slotIndex % self._slotColCount * (slotSize + intervalSize))
    self._slotBg[slotIndex]:SetPosY(startPos + math.floor(slotIndex / self._slotColCount) * (slotSize + intervalSize))
  end
  local contentSizeX = self._slotColCount * (slotSize + intervalSize) + startPos
  local contentSizeY = math.ceil(self._bagSize / self._slotColCount) * (slotSize + intervalSize) + startPos
  local frameSizeX = contentSizeX
  local frameSizeY = contentSizeY
  local frameVScroll = self._ui.stc_itemSlotFrame:GetVScroll()
  local frameMaxRowCount = 8
  local frameMaxSizeY = frameMaxRowCount * (slotSize + intervalSize) + startPos
  if frameSizeY > frameMaxSizeY then
    frameSizeY = frameMaxSizeY
    frameSizeX = frameSizeX + 10
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
  self._ui.stc_itemSlotFrame:SetSize(frameSizeX, frameSizeY)
  self._ui.stc_itemSlotFrameContent:SetSize(frameSizeX, contentSizeY)
  self._ui.stc_itemSlotFrameScroll:SetSize(self._ui.stc_itemSlotFrameScroll:GetSizeX(), frameSizeY - 20)
  self._ui.stc_SlotArea:SetSize(frameSizeX, contentSizeY)
  frameVScroll:SetControlPos(0)
  self._ui.stc_itemSlotFrame:UpdateContentPos()
  local panelSizeX = self._ui.stc_itemSlotFrame:GetSizeX()
  local panelSizeY = 0
  if self._ui.stc_DescBg:GetShow() == true then
    self._ui.stc_DescBg:SetSize(panelSizeX, self._ui.txt_Desc:GetTextSizeY() + 10)
    self._ui.txt_Desc:SetSize(self._ui.stc_DescBg:GetSizeX() - 20, self._ui.stc_DescBg:GetSizeY())
    self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
    self._ui.stc_DescBg:SetPosY(self._ui.stc_itemSlotFrame:GetPosY() + self._ui.stc_itemSlotFrame:GetSizeY() + 10)
    panelSizeY = self._ui.stc_DescBg:GetPosY() + self._ui.stc_DescBg:GetSizeY()
  else
    panelSizeY = self._ui.stc_itemSlotFrame:GetPosY() + self._ui.stc_itemSlotFrame:GetSizeY()
  end
  panelSizeX = self._ui.stc_itemSlotFrame:GetSizeX()
  if self._ui.btn_ChangeAll:GetShow() == true then
    panelSizeY = panelSizeY + self._ui.btn_ChangeAll:GetSizeY() + 20
    self._ui.btn_ChangeAll:SetSize(panelSizeX - 20, self._ui.btn_ChangeAll:GetSizeY())
  end
  self._ui.stc_BlackBg:SetSize(panelSizeX, self._ui.stc_itemSlotFrame:GetPosY() + self._ui.stc_itemSlotFrame:GetSizeY() + 10)
  self._ui.stc_TitleBg:SetSize(panelSizeX, self._ui.stc_TitleBg:GetSizeY())
  if self._isConsole == true then
    self._ui.stc_KeyGuide:SetSize(panelSizeX, self._ui.stc_KeyGuide:GetSizeY())
  end
  Panel_Window_ClothInventory_All:SetSize(panelSizeX + 2, panelSizeY)
  Panel_Window_ClothInventory_All:ComputePosAllChild()
end
function PaGlobal_ClothInventory_All:registEventHandler()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  if _ContentsGroup_RenewUI_Tooltip == true then
    Panel_Window_ClothInventory_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ClothInventory_All_ShowDetailToolTip()")
  end
  self._ui.btn_ChangeAll:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_All_ChangeAllItem()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ClothInventory_All_Close()")
  registerEvent("FromClient_ShowInventoryBag", "FromClient_ClothInventory_All_ShowInventoryBag")
  registerEvent("FromClient_UpdateInventoryBag", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
  registerEvent("EventEquipItem", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
  registerEvent("EventUnEquipItemToInventory", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
  registerEvent("FromClient_ChangeItemExpirationDate", "PaGlobalFunc_ClothInventory_All_UpdateInventoryBag")
end
function PaGlobal_ClothInventory_All:prepareOpen()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  if false == self._isConsole then
    self:setOpenPos()
    PaGlobalFunc_Equipment_All_SetShow(false)
  end
  self:open()
end
function PaGlobal_ClothInventory_All:open()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  Panel_Window_ClothInventory_All:SetShow(true)
end
function PaGlobal_ClothInventory_All:prepareClose()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  if Panel_Window_ClothInventory_All:GetShow() == false then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  if self._isConsole == true then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    PaGlobalFunc_Equipment_All_SetShow(true)
  end
  self:close()
end
function PaGlobal_ClothInventory_All:close()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  Panel_Window_ClothInventory_All:SetShow(false)
end
function PaGlobal_ClothInventory_All:validate()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  self._ui.stc_BlackBg:isValidate()
  self._ui.stc_TitleBg:isValidate()
  self._ui.stc_DescBg:isValidate()
  self._ui.stc_itemSlotFrame:isValidate()
  self._ui.stc_itemSlotFrameContent:isValidate()
  self._ui.stc_SlotArea:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_SlotBg:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_ChangeAll:isValidate()
  self._ui.stc_KeyGuide:isValidate()
end
function PaGlobal_ClothInventory_All:setOpenPos()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    if Panel_Window_Inventory_All:IsUISubApp() == true then
      Panel_Window_ClothInventory_All:SetPosXY(getScreenSizeX() * 0.5, getScreenSizeY() * 0.5)
    else
      local posX = Panel_Window_Inventory_All:GetPosX() - Panel_Window_ClothInventory_All:GetSizeX() - 5
      if posX < 0 then
        posX = Panel_Window_Inventory_All:GetPosX() + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_ClothInventory_All:SetPosX(posX)
      Panel_Window_ClothInventory_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
    end
  else
    Panel_Window_ClothInventory_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ClothInventory_All:GetSizeX() - 5)
    Panel_Window_ClothInventory_All:SetPosY(Panel_Window_Inventory:GetPosY())
  end
end
function PaGlobal_ClothInventory_All:showInventoryBag(bagType, bagSize, fromWhereType, fromSlotNo)
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  self._bagSize = bagSize
  self._inventoryBagType = bagType
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  self._slotColCount = 4
  local bottomKeyGuideY = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_Y_ConsoleUI")
  local titleStr = ""
  if CppEnums.InventoryBagType.eInventoryBagType_Cash == bagType then
    bagType = CppEnums.ItemWhereType.eCashInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_PEARLTITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(true)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(true)
    else
      bottomKeyGuideY:SetShow(true)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_Equipment == bagType then
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(true)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(true)
    else
      bottomKeyGuideY:SetShow(true)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_Misc == bagType then
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_MISC_INVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(false)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(false)
    end
  elseif CppEnums.InventoryBagType.eInventoryBagType_MiscForCash == bagType then
    bagType = CppEnums.ItemWhereType.eCashInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_MISC_INVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(false)
    if false == self._isConsole then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(false)
    end
  elseif bagType == CppEnums.InventoryBagType.eInventoryBagType_CollectUnion then
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_CLOTHINVENTORY_TITLE_WITHOUTNAME")
    self._ui.stc_DescBg:SetShow(true)
    if self._isConsole == false then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(true)
    end
  elseif bagType == CppEnums.InventoryBagType.eInventoryBagType_Fish then
    local bagFreeCount = getInventoryBagFreeCount(self._fromWhereType, self._fromSlotNo)
    self._slotColCount = 8
    bagType = CppEnums.ItemWhereType.eInventory
    titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_FISH_INVENTORY_BAG_TITLE") .. " (" .. tostring(self._bagSize - bagFreeCount) .. "/" .. tostring(self._bagSize) .. ")"
    self._ui.stc_DescBg:SetShow(false)
    if self._isConsole == false then
      self._ui.btn_ChangeAll:SetShow(false)
    else
      bottomKeyGuideY:SetShow(false)
    end
  end
  self._bagType = bagType
  self._ui.txt_Title:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Title:SetText(titleStr)
  for index = 0, self._bagSize - 1 do
    if self._slotBg[index] == nil then
      self._slotBg[index] = UI.createControl(__ePAUIControl_Static, self._ui.stc_SlotArea, "ClothInventory_SlotBg_" .. index)
      CopyBaseProperty(self._ui.stc_SlotBg, self._slotBg[index])
      self._slotBg[index]:SetShow(true)
      if self._slot[index] == nil then
        self._slot[index] = {}
        SlotItem.new(self._slot[index], "ClothInventory_", index, self._slotBg[index], self._config)
        self._slot[index]:createChild()
      end
    end
    local itemWrapper = getInventoryBagItemByType(fromWhereType, fromSlotNo, index)
    if itemWrapper ~= nil then
      self._slot[index]:setItem(itemWrapper, index)
      if self._isConsole == true then
        self._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. bagType .. ")")
      else
        self._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ", " .. bagType .. ")")
      end
    else
      self._slot[index]:clearItem()
      self._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._slot[index].icon:removeInputEvent("Mouse_RUp")
    end
    self._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(true, " .. fromWhereType .. ", " .. fromSlotNo .. ", " .. index .. ")")
    self._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(false)")
  end
  Inventory_SetFunctor(PaGloablFunc_ClothInventory_All_SetFilter, HandleEventRUp_ClothInventory_All_InvenRClick, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  if self._isConsole == true then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  self:resizePanel()
  self:setKeyGuide()
  self:prepareOpen()
end
function PaGlobal_ClothInventory_All:updateInventoryBag()
  if Panel_Window_ClothInventory_All == nil then
    return
  end
  for index = 0, self._bagSize - 1 do
    self._slot[index]:clearItem()
    local itemWrapper = getInventoryBagItemByType(self._fromWhereType, self._fromSlotNo, index)
    if itemWrapper ~= nil then
      self._slot[index]:setItem(itemWrapper, index)
      if self._isConsole == true then
        self._slot[index].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      else
        self._slot[index].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ClothInventory_All_ClothInvenRClick(" .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ", " .. self._bagType .. ")")
      end
    else
      self._currSlotInfo.index = nil
      self._slot[index]:clearItem()
      self._slot[index].icon:removeInputEvent("Mouse_LUp")
      self._slot[index].icon:removeInputEvent("Mouse_RUp")
    end
    self._slot[index].icon:addInputEvent("Mouse_On", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(true, " .. self._fromWhereType .. ", " .. self._fromSlotNo .. ", " .. index .. ")")
    self._slot[index].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ClothInventory_All_ShowFloatingTooltip(false)")
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_UpdateInventoryWeight()
  else
    FGlobal_UpdateInventoryWeight()
  end
  if self._inventoryBagType == CppEnums.InventoryBagType.eInventoryBagType_Fish then
    local bagFreeCount = getInventoryBagFreeCount(self._fromWhereType, self._fromSlotNo)
    local titleStr = PAGetString(Defines.StringSheet_GAME, "LUA_FISH_INVENTORY_BAG_TITLE") .. " (" .. tostring(self._bagSize - bagFreeCount) .. "/" .. tostring(self._bagSize) .. ")"
    self._ui.txt_Title:SetText(titleStr)
  end
end
