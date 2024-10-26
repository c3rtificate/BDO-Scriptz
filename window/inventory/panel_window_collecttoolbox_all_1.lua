function PaGlobal_CollectToolBox_All:initialize()
  if PaGlobal_CollectToolBox_All._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_Window_CollectToolBox_All, "StaticText_TitleBg")
  self._isConsole = _ContentsGroup_UsePadSnapping == true or ToClient_isConsole() == true
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Win_Close")
  local descriptionBG = UI.getChildControl(Panel_Window_CollectToolBox_All, "Static_Desc_BG")
  local descriptionMain = UI.getChildControl(descriptionBG, "StaticText_1")
  descriptionMain:SetTextMode(__eTextMode_AutoWrap)
  descriptionMain:SetAutoResize(true)
  descriptionMain:SetText(descriptionMain:GetText())
  self:initializeBottomKeyGuideArea()
  self:initializeSlots()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CollectToolBox_All:initializeSlots()
  local mainBg = UI.getChildControl(Panel_Window_CollectToolBox_All, "Static_MainBG")
  local subBg = UI.getChildControl(mainBg, "Static_SubBG")
  local slotInfoTemplate = UI.getChildControl(subBg, "Button_EquipTool_0")
  slotInfoTemplate:SetShow(false)
  for idx = 1, #self._collectTypeList do
    local toolBg = UI.getChildControl(subBg, "Static_ToolBG_" .. idx - 1)
    local defaultPanelSpan = toolBg:GetSpanSize()
    local slotInfo = UI.cloneControl(slotInfoTemplate, subBg, "Static_ToolBG_Info_" .. idx - 1)
    slotInfo:SetSpanSize(defaultPanelSpan.x, defaultPanelSpan.y)
    local slotBg = UI.getChildControl(slotInfo, "Static_ItemSlotBG")
    local slotIcon = UI.getChildControl(slotBg, "Static_ItemIcon")
    local itemName = UI.getChildControl(slotBg, "StaticText_ItemName")
    local endurance = UI.getChildControl(slotBg, "StaticText_Endurance")
    self._defaultPanel[idx] = toolBg
    self._activatePanel[idx] = slotInfo
    if self._slots[idx] == nil then
      local slot = {}
      SlotItem.new(slot, "CollectToolBoxIcon_" .. idx, idx, slotIcon, self._slotConfig)
      slot:createChild()
      self._slots[idx] = slot
      self._slots[idx]._itemName = itemName
      self._slots[idx]._endurance = endurance
    end
    if self._isConsole == false then
      self._slots[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip( " .. idx .. ", true )")
      self._slots[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip( " .. idx .. ", false )")
      slotInfo:addInputEvent("Mouse_RUp", "HandleEventRUp_CollectToolBox_All_SlotRClick( " .. idx .. " )")
      self._slots[idx].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_CollectToolBox_All_SlotRClick( " .. idx .. " )")
    else
      self._slots[idx].icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip( " .. idx .. ", true )")
      slotInfo:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip( " .. idx .. ", true )")
      self._slots[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_CollectToolBox_All_ShowFloatingTooltip( " .. idx .. ", false )")
      slotInfo:addInputEvent("Mouse_LUp", "HandleEventRUp_CollectToolBox_All_SlotRClick( " .. idx .. " )")
      self._slots[idx].icon:addInputEvent("Mouse_LUp", "HandleEventRUp_CollectToolBox_All_SlotRClick( " .. idx .. " )")
    end
  end
end
function PaGlobal_CollectToolBox_All:registEventHandler()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  registerEvent("FromClient_CollectToolBoxUpdate", "FromClient_CollectToolBoxUpdate")
  registerEvent("FromClient_EquipEnduranceChanged", "FromClient_CollectToolBoxUpdate")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CollectToolBox_All_Close()")
end
function PaGlobal_CollectToolBox_All:prepareOpen()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  if self._isConsole == false then
    InventoryFunctionUI_Close()
  end
  self:update()
  Inventory_SetFunctor(PaGloablFunc_CollectToolBox_All_SetFilter, HandleEventRUp_CollectToolBox_All_InvenRClick, nil, nil)
  if Panel_Window_Inventory_All ~= nil then
    if false == Panel_Window_Inventory_All:IsUISubApp() then
      local posX = Panel_Window_Inventory_All:GetPosX() - Panel_Window_CollectToolBox_All:GetSizeX() - 5
      if posX < 0 then
        posX = Panel_Window_Inventory_All:GetPosX() + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_CollectToolBox_All:SetPosX(posX)
      Panel_Window_CollectToolBox_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
    end
  else
    Panel_Window_CollectToolBox_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_CollectToolBox_All:GetSizeX() - 5)
    Panel_Window_CollectToolBox_All:SetPosY(Panel_Window_Inventory:GetPosY())
  end
  PaGlobal_CollectToolBox_All:open()
end
function PaGlobal_CollectToolBox_All:open()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  Panel_Window_CollectToolBox_All:SetShow(true)
end
function PaGlobal_CollectToolBox_All:prepareClose()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  if self._isConsole == true then
  elseif _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_ShowEquipUI()
  else
    Inventory_ShowEquipUI()
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_CollectToolBox_All:close()
end
function PaGlobal_CollectToolBox_All:close()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  Panel_Window_CollectToolBox_All:SetShow(false)
end
function PaGlobal_CollectToolBox_All:update()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  for idx = 1, #self._collectTypeList do
    local itemWrapper = ToClient_GetCollectToolInCollectToolBag(self._collectTypeList[idx])
    if itemWrapper ~= nil then
      self._defaultPanel[idx]:SetShow(false)
      self._activatePanel[idx]:SetShow(true)
      self._slots[idx]:setItem(itemWrapper, idx)
      local itemStaticStatus = itemWrapper:getStaticStatus()
      if itemStaticStatus == nil then
        return
      end
      self._slots[idx]._itemName:SetTextMode(__eTextMode_LimitText)
      local nameColorGrade = itemStaticStatus:getGradeType()
      if 0 == nameColorGrade then
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
      elseif 1 == nameColorGrade then
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FF83A543)
      elseif 2 == nameColorGrade then
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FF438DCC)
      elseif 3 == nameColorGrade then
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FFF5BA3A)
      elseif 4 == nameColorGrade then
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FFD05D48)
      else
        self._slots[idx]._itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
      end
      local showItemKey = itemStaticStatus:get()._key:getItemKey()
      local devShowItemKey = PaGlobal_showKey(showItemKey)
      enchantLevel = itemStaticStatus:get()._key:getEnchantLevel()
      if itemStaticStatus:getItemType() == 1 and enchantLevel > 15 then
        local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemStaticStatus:getName() .. devShowItemKey
        self._slots[idx]._itemName:SetText(itemAndEnchantName)
      elseif 0 < enchantLevel and itemStaticStatus:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory and (itemStaticStatus:isSpecialEnchantItem() == false or itemStaticStatus:isKingAccessory() == true) then
        local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemStaticStatus:getName() .. devShowItemKey
        self._slots[idx]._itemName:SetText(itemAndEnchantName)
      else
        self._slots[idx]._itemName:SetText(itemStaticStatus:getName() .. devShowItemKey)
      end
      local maxEndurance = itemWrapper:getMaxEndurance()
      local endurance = itemWrapper:getEndurance()
      self._slots[idx]._endurance:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_TOOLBOX_ENDURANCE", "endurance", endurance, "max", maxEndurance))
    else
      self._defaultPanel[idx]:SetShow(true)
      self._activatePanel[idx]:SetShow(false)
      self._slots[idx]:clearItem()
    end
  end
  if self._isConsole == true and self._popToolBagItem == true then
    ToClient_padSnapChangeToTarget(self._defaultPanel[self._popToolBagItemIdx])
    self._popToolBagItem = false
    self._popToolBagItemIdx = 0
  end
end
function PaGlobal_CollectToolBox_All:validate()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
end
function PaGlobal_CollectToolBox_All:initializeBottomKeyGuideArea()
  if Panel_Window_CollectToolBox_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_CollectToolBox_All, "Static_KeyGuide_Bg")
  self._ui._stc_keyGuideBG:SetShow(true)
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  local bgXSize = self._ui._stc_keyGuideBG:GetSizeX()
  local bgYSize = self._ui._stc_keyGuideBG:GetSizeY()
  local xSize = self._ui._stc_keyGuide_X:GetTextSpan().x + self._ui._stc_keyGuide_X:GetTextSizeX()
  local aSize = self._ui._stc_keyGuide_A:GetTextSpan().x + self._ui._stc_keyGuide_A:GetTextSizeX()
  local bSize = self._ui._stc_keyGuide_B:GetTextSpan().x + self._ui._stc_keyGuide_B:GetTextSizeX()
  local gap = 5
  if bgXSize < xSize + gap + aSize and bgXSize < aSize + gap + bSize then
    self._ui._stc_keyGuideBG:SetSize(bgXSize, bgYSize * 3)
    self._ui._stc_keyGuide_X:SetPosXY(bgXSize - xSize - gap, 0)
    self._ui._stc_keyGuide_A:SetPosXY(bgXSize - aSize - gap, bgYSize)
    self._ui._stc_keyGuide_B:SetPosXY(bgXSize - bSize - gap, bgYSize * 2)
  elseif bgXSize < xSize + gap + aSize + gap + bSize then
    self._ui._stc_keyGuideBG:SetSize(bgXSize, bgYSize * 2)
    self._ui._stc_keyGuide_A:SetPosXY(bgXSize - aSize - gap, 0)
    self._ui._stc_keyGuide_X:SetPosXY(bgXSize - aSize - gap - xSize - gap, 0)
    self._ui._stc_keyGuide_B:SetPosXY(bgXSize - bSize - gap, bgYSize)
  else
    self._ui._stc_keyGuide_B:SetPosXY(bgXSize - bSize - gap, 0)
    self._ui._stc_keyGuide_A:SetPosXY(bgXSize - bSize - gap - aSize - gap, 0)
    self._ui._stc_keyGuide_X:SetPosXY(bgXSize - bSize - gap - aSize - gap - xSize - gap, 0)
  end
end
