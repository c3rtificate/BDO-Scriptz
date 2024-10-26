function PaGlobal_LightStoneBag:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping == true or ToClient_isConsole() == true
  self._artifactInventorySlotCountMax = ToClient_getArtifactInventorySlotCountMax()
  self._artifactInventoryPresetCountMax = ToClient_getArtifactInventoryPresetCountMax()
  self:initializeTitleArea()
  self:initializeTopTabArea()
  self:initializeArtifactArea()
  self:initializeLightStoneArea()
  self:initializeBottomButtonArea()
  self:initializeBottomKeyGuideArea()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_LightStoneBag:initializeTitleArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local stc_titleBg = UI.getChildControl(Panel_Window_LightStoneBag, "StaticText_TitleBg")
  local btn_close = UI.getChildControl(stc_titleBg, "Button_Win_Close")
  if self._isConsole == false then
    btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_Close()")
  end
  btn_close:SetShow(not self._isConsole)
end
function PaGlobal_LightStoneBag:initializeTopTabArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local stc_topArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_TabGroup")
  self._ui._btn_tab_artifact = UI.getChildControl(stc_topArea, "RadioButton_Tab_Artifacts")
  self._ui._stc_selectedLine_artifact = UI.getChildControl(self._ui._btn_tab_artifact, "Static_SelectedLine")
  self._ui._btn_tab_lightStone = UI.getChildControl(stc_topArea, "RadioButton_Tab_LightStone")
  self._ui._stc_selectedLine_lightStone = UI.getChildControl(self._ui._btn_tab_lightStone, "Static_SelectedLine")
  self._ui._stc_keyGuide_LB = UI.getChildControl(stc_topArea, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuide_RB = UI.getChildControl(stc_topArea, "Static_RB_ConsoleUI")
  self._ui._btn_tab_artifact:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedTab(" .. LightStoneBagTabIndex.Artifact .. ")")
  self._ui._btn_tab_lightStone:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedTab(" .. LightStoneBagTabIndex.LightStone .. ")")
  if self._isConsole == true then
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_LightStoneBag_MoveTab(true)")
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_LightStoneBag_MoveTab(false)")
  end
  self._ui._stc_keyGuide_LB:SetShow(self._isConsole)
  self._ui._stc_keyGuide_RB:SetShow(self._isConsole)
end
function PaGlobal_LightStoneBag:initializeArtifactArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_artifactBagArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_ArtifactBagArea")
  self._ui._btn_editPreset = UI.getChildControl(self._ui._stc_artifactBagArea, "CheckButton_Preset")
  self._ui._txt_slotCount = UI.getChildControl(self._ui._stc_artifactBagArea, "StaticText_SlotCount")
  self._ui._btn_buyItem = UI.getChildControl(self._ui._stc_artifactBagArea, "Button_BuyItem")
  self._ui._txt_editPreset = nil
  local btn_editPreset_PC = UI.getChildControl(self._ui._btn_editPreset, "StaticText_String")
  local btn_editPreset_Console = UI.getChildControl(self._ui._btn_editPreset, "StaticText_LT_ConsoleUI")
  btn_editPreset_PC:SetShow(not self._isConsole)
  btn_editPreset_Console:SetShow(self._isConsole)
  if self._isConsole == true then
    self._ui._txt_editPreset = btn_editPreset_Console
  else
    self._ui._txt_editPreset = btn_editPreset_PC
  end
  self._ui._artifactBagList = UI.getChildControl(self._ui._stc_artifactBagArea, "List2_ArtifactList")
  local artifactBag_content = UI.getChildControl(self._ui._artifactBagList, "List2_1_Content")
  local artifactBag_btn = UI.getChildControl(artifactBag_content, "Button_Artifact")
  local artifactBag_mainSlotBG = UI.getChildControl(artifactBag_btn, "Static_ItemSlotBG")
  local artifactBag_mainItemSlot = UI.getChildControl(artifactBag_mainSlotBG, "Static_ItemIcon")
  local artifactBag_subItemSlot_0_BG = UI.getChildControl(artifactBag_btn, "Static_Artifact_BG_0")
  local artifactBag_subItemSlot_0 = UI.getChildControl(artifactBag_subItemSlot_0_BG, "Static_Icon")
  local artifactBag_subItemSlot_1_BG = UI.getChildControl(artifactBag_btn, "Static_Artifact_BG_1")
  local artifactBag_subItemSlot_1 = UI.getChildControl(artifactBag_subItemSlot_1_BG, "Static_Icon")
  local artifactBag_artifactSlot = {}
  SlotItem.new(artifactBag_artifactSlot, "Artifact_Item_Slot_", 0, artifactBag_mainItemSlot, self._slotConfig)
  artifactBag_artifactSlot:createChild()
  artifactBag_artifactSlot:clearItem()
  artifactBag_artifactSlot.icon:SetPosX(0)
  artifactBag_artifactSlot.icon:SetPosY(0)
  artifactBag_artifactSlot.border:SetSize(44, 44)
  local artifactBag_subSlot_0 = {}
  SlotItem.new(artifactBag_subSlot_0, "Artifact_SubItem_Slot_0_", 0, artifactBag_subItemSlot_0, self._subSlotConfig)
  artifactBag_subSlot_0:createChild()
  artifactBag_subSlot_0:clearItem()
  artifactBag_subSlot_0.icon:SetPosX(0)
  artifactBag_subSlot_0.icon:SetPosY(0)
  artifactBag_subSlot_0.icon:SetSize(20, 20)
  local artifactBag_subSlot_1 = {}
  SlotItem.new(artifactBag_subSlot_1, "Artifact_SubItem_Slot_1_", 0, artifactBag_subItemSlot_1, self._subSlotConfig)
  artifactBag_subSlot_1:createChild()
  artifactBag_subSlot_1:clearItem()
  artifactBag_subSlot_1.icon:SetPosX(0)
  artifactBag_subSlot_1.icon:SetPosY(0)
  artifactBag_subSlot_1.icon:SetSize(20, 20)
  self._ui._artifactBagList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_LightStoneBag_OnCreateArtifactBagListContent")
  self._ui._artifactBagList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_buyItem:addInputEvent("Mouse_LUp", "PaGlobal_EasyBuy:Open( 126 )")
  if self._isConsole == true then
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_ArtifactBag_ToggleEditMode()")
  else
    self._ui._btn_editPreset:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_ToggleEditMode()")
  end
  self._ui._artifactPresetList = UI.getChildControl(self._ui._stc_artifactBagArea, "List2_PresetList")
  local artifactPreset_content = UI.getChildControl(self._ui._artifactPresetList, "List2_1_Content")
  local artifactPreset_rdoBtn = UI.getChildControl(artifactPreset_content, "RadioButton_ArtifactPreset")
  local artifactPreset_leftSlotBG = UI.getChildControl(artifactPreset_rdoBtn, "Static_ItemSlotBG_L")
  local artifactPreset_leftSlotIcon = UI.getChildControl(artifactPreset_leftSlotBG, "Static_ItemIcon")
  local artifactPreset_leftPushedSlot_0_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_L_0")
  local artifactPreset_leftPushedSlot_0 = UI.getChildControl(artifactPreset_leftPushedSlot_0_BG, "Static_Icon")
  local artifactPreset_leftPushedSlot_1_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_L_1")
  local artifactPreset_leftPushedSlot_1 = UI.getChildControl(artifactPreset_leftPushedSlot_1_BG, "Static_Icon")
  local artifactPreset_rightSlotBG = UI.getChildControl(artifactPreset_rdoBtn, "Static_ItemSlotBG_R")
  local artifactPreset_rightSlotIcon = UI.getChildControl(artifactPreset_rightSlotBG, "Static_ItemIcon")
  local artifactPreset_rightPushedSlot_0_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_R_0")
  local artifactPreset_rightPushedSlot_0 = UI.getChildControl(artifactPreset_rightPushedSlot_0_BG, "Static_Icon")
  local artifactPreset_rightPushedSlot_1_BG = UI.getChildControl(artifactPreset_rdoBtn, "Static_LightStone_BG_R_1")
  local artifactPreset_rightPushedSlot_1 = UI.getChildControl(artifactPreset_rightPushedSlot_1_BG, "Static_Icon")
  local artifactPreset_leftArtifactSlot = {}
  SlotItem.new(artifactPreset_leftArtifactSlot, "ArtufactPreset_Left_Slot_", 0, artifactPreset_leftSlotIcon, self._slotConfig)
  artifactPreset_leftArtifactSlot:createChild()
  artifactPreset_leftArtifactSlot:clearItem()
  artifactPreset_leftArtifactSlot.icon:SetPosX(0)
  artifactPreset_leftArtifactSlot.icon:SetPosY(0)
  artifactPreset_leftArtifactSlot.border:SetSize(44, 44)
  local artifactPreset_leftSubSlot_0 = {}
  SlotItem.new(artifactPreset_leftSubSlot_0, "ArtufactPreset_Left_SubSlot_0_", 0, artifactPreset_leftPushedSlot_0, self._subSlotConfig)
  artifactPreset_leftSubSlot_0:createChild()
  artifactPreset_leftSubSlot_0:clearItem()
  artifactPreset_leftSubSlot_0.icon:SetPosX(0)
  artifactPreset_leftSubSlot_0.icon:SetPosY(0)
  artifactPreset_leftSubSlot_0.icon:SetSize(20, 20)
  local artifactPreset_leftSubSlot_1 = {}
  SlotItem.new(artifactPreset_leftSubSlot_1, "ArtufactPreset_Left_SubSlot_1_", 0, artifactPreset_leftPushedSlot_1, self._subSlotConfig)
  artifactPreset_leftSubSlot_1:createChild()
  artifactPreset_leftSubSlot_1:clearItem()
  artifactPreset_leftSubSlot_1.icon:SetPosX(0)
  artifactPreset_leftSubSlot_1.icon:SetPosY(0)
  artifactPreset_leftSubSlot_1.icon:SetSize(20, 20)
  local artifactPreset_rightArtifactSlot = {}
  SlotItem.new(artifactPreset_rightArtifactSlot, "ArtufactPreset_Right_Slot_", 0, artifactPreset_rightSlotIcon, self._slotConfig)
  artifactPreset_rightArtifactSlot:createChild()
  artifactPreset_rightArtifactSlot:clearItem()
  artifactPreset_rightArtifactSlot.icon:SetPosX(0)
  artifactPreset_rightArtifactSlot.icon:SetPosY(0)
  artifactPreset_rightArtifactSlot.border:SetSize(44, 44)
  local artifactPreset_rightSubSlot_0 = {}
  SlotItem.new(artifactPreset_rightSubSlot_0, "ArtufactPreset_Right_SubSlot_0_", 0, artifactPreset_rightPushedSlot_0, self._subSlotConfig)
  artifactPreset_rightSubSlot_0:createChild()
  artifactPreset_rightSubSlot_0:clearItem()
  artifactPreset_rightSubSlot_0.icon:SetPosX(0)
  artifactPreset_rightSubSlot_0.icon:SetPosY(0)
  artifactPreset_rightSubSlot_0.icon:SetSize(20, 20)
  local artifactPreset_rightSubSlot_1 = {}
  SlotItem.new(artifactPreset_rightSubSlot_1, "ArtufactPreset_Right_SubSlot_1_", 0, artifactPreset_rightPushedSlot_1, self._subSlotConfig)
  artifactPreset_rightSubSlot_1:createChild()
  artifactPreset_rightSubSlot_1:clearItem()
  artifactPreset_rightSubSlot_1.icon:SetPosX(0)
  artifactPreset_rightSubSlot_1.icon:SetPosY(0)
  artifactPreset_rightSubSlot_1.icon:SetSize(20, 20)
  self._ui._artifactPresetList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_LightStoneBag_OnCreateArtifactPresetListContent")
  self._ui._artifactPresetList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_LightStoneBag:initializeLightStoneArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_lightStoneBagArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_LightStoneBagArea")
  self._ui._stc_lightStoneSubTabGroup = UI.getChildControl(self._ui._stc_lightStoneBagArea, "Static_SubTabGroup")
  self._ui._lightStoneTypeCheckButtonList = Array.new()
  for lightStoneSubTypeIndex = 0, __eLightStoneItemSubType_Count - 1 do
    self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex] = UI.getChildControl(self._ui._stc_lightStoneSubTabGroup, "CheckButton_Type_" .. tostring(lightStoneSubTypeIndex))
    self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex]:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedLightStoneTypeButton(" .. lightStoneSubTypeIndex .. ")")
    if self._isConsole == true then
      self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex]:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneTypeButton_OnPadSnap()")
    end
    self._lightStoneTypeFilter[lightStoneSubTypeIndex] = true
  end
  self._ui._lightStoneBagList = UI.getChildControl(self._ui._stc_lightStoneBagArea, "List2_LightStoneList")
  local content = UI.getChildControl(self._ui._lightStoneBagList, "List2_1_Content")
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local tempSlot = {}
  SlotItem.new(tempSlot, "LightStone_Item_Slot_", 0, stc_itemIcon, self._slotConfig)
  tempSlot:createChild()
  tempSlot:clearItem()
  tempSlot.icon:SetPosX(0)
  tempSlot.icon:SetPosY(0)
  tempSlot.border:SetSize(44, 44)
  self._ui._lightStoneBagList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_LightStoneBag_OnCreateLightStoneBagListContent")
  self._ui._lightStoneBagList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_LightStoneBag:initializeBottomButtonArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_bottomButtonArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_BottomSelectedArea")
  self._ui._btn_showEquipLightStoneUI = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_Setting")
  self._ui._btn_getAllItemFromInventory = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_MoveAll")
  self._ui._btn_showEquipLightStoneUI:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedSettingUIButton()")
  self._ui._btn_getAllItemFromInventory:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedMoveAllItemButton()")
end
function PaGlobal_LightStoneBag:initializeBottomKeyGuideArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_LightStoneBag, "Static_KeyGuide_Bg")
  self._ui._stc_keyGuideBG:SetShow(true)
  self._ui._stc_keyGuide_LTA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LT_MoveAll_ConsoleUI")
  self._ui._stc_keyGuide_RTY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_RT_LightStone_ConsoleUI")
  self._ui._stc_keyGuide_RTX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_RT_ArtifactPreset_ConsoleUI")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
end
function PaGlobal_LightStoneBag:registEventHandler()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "PaGlobalFunc_LightStoneBag_OnClickedMoveAllItemButton()")
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_LightStoneBag_OnClickedSettingUIButton()")
  end
  registerEvent("FromClient_UpdateLightStoneBag", "FromClient_UpdateLightStoneBag")
  registerEvent("FromClient_UpdateArifactBag", "FromClient_UpdateArifactBag")
  registerEvent("FromClient_UpdateArtifactPresetData", "FromClient_UpdateArtifactPresetData")
  registerEvent("FromClient_UpdateAtifactBagVariedCount", "FromClient_UpdateAtifactBagVariedCount")
end
function PaGlobal_LightStoneBag:validate()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._btn_tab_artifact:isValidate()
  self._ui._stc_selectedLine_artifact:isValidate()
  self._ui._btn_tab_lightStone:isValidate()
  self._ui._stc_selectedLine_lightStone:isValidate()
  self._ui._stc_keyGuide_LB:isValidate()
  self._ui._stc_keyGuide_RB:isValidate()
  self._ui._stc_artifactBagArea:isValidate()
  self._ui._btn_editPreset:isValidate()
  self._ui._artifactBagList:isValidate()
  self._ui._artifactPresetList:isValidate()
  self._ui._txt_slotCount:isValidate()
  self._ui._btn_buyItem:isValidate()
  self._ui._stc_lightStoneBagArea:isValidate()
  self._ui._stc_lightStoneSubTabGroup:isValidate()
  self._ui._lightStoneBagList:isValidate()
  self._ui._stc_bottomButtonArea:isValidate()
  self._ui._btn_showEquipLightStoneUI:isValidate()
  self._ui._btn_getAllItemFromInventory:isValidate()
  if self._isConsole == true then
    self._ui._stc_keyGuideBG:isValidate()
    self._ui._stc_keyGuide_LTA:isValidate()
    self._ui._stc_keyGuide_RTY:isValidate()
    self._ui._stc_keyGuide_RTX:isValidate()
    self._ui._stc_keyGuide_Y:isValidate()
    self._ui._stc_keyGuide_A:isValidate()
    self._ui._stc_keyGuide_B:isValidate()
    self._ui._stc_keyGuide_X:isValidate()
  end
end
function PaGlobal_LightStoneBag:prepareOpen()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self:resetData()
  self:openUISetting()
  self:onClickedTab(self._currentTabIndex)
  self:open()
end
function PaGlobal_LightStoneBag:open()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  Panel_Window_LightStoneBag:SetShow(true)
end
function PaGlobal_LightStoneBag:prepareClose()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == true then
  elseif _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_ShowEquipUI()
  else
    Inventory_ShowEquipUI()
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false, nil)
  end
  Panel_Tooltip_Item_hideTooltip()
  self:hideMouseRClickGuide()
  self:close()
end
function PaGlobal_LightStoneBag:close()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  Panel_Window_LightStoneBag:SetShow(false)
end
function PaGlobal_LightStoneBag:openUISetting()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if self._isConsole == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_LightStoneBag:SetPosX(inventoryPanelPosX - Panel_Window_LightStoneBag:GetSizeX() - 5)
      Panel_Window_LightStoneBag:SetPosY(inventoryPanelPosY)
    end
  else
    if Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
      local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
      local posX = inventoryPanelPosX - Panel_Window_LightStoneBag:GetSizeX() - 5
      if posX < 0 then
        posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_LightStoneBag:SetPosX(posX)
      Panel_Window_LightStoneBag:SetPosY(inventoryPanelPosY)
    end
    if _ContentsGroup_NewUI_Inventory_All == true then
      if Panel_Window_Inventory_All:GetShow() == false then
        Panel_Window_Inventory_All:SetShow(true)
      end
    elseif Panel_Window_Inventory:GetShow() == false then
      Panel_Window_Inventory:SetShow(true)
    end
  end
end
function PaGlobal_LightStoneBag:isShowPanel()
  if Panel_Window_LightStoneBag == nil then
    return false
  end
  return Panel_Window_LightStoneBag:GetShow()
end
function PaGlobal_LightStoneBag:createArtifactBagListContent(content, s64_key)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:createArtifactBagListContent] \236\156\160\235\172\188 \234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local subItem_0_SSW = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local subItem_1_SSW = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local bagItemCount_s64 = ToClient_GetArtifactBagItemCount64(bagIndex)
  local btn_slot = UI.getChildControl(content, "Button_Artifact")
  local mainSlotBG = UI.getChildControl(btn_slot, "Static_ItemSlotBG")
  local mainItemSlot = UI.getChildControl(mainSlotBG, "Static_ItemIcon")
  local mainItemName = UI.getChildControl(mainSlotBG, "StaticText_ItemName")
  if self._isConsole == true then
    if self._isEditMode == true then
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_AddArtifactPresetItem(" .. tostring(s64_key) .. ")")
    else
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_RequestPopArtifactItem(" .. tostring(s64_key) .. ")")
    end
  elseif self._isEditMode == true then
    btn_slot:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactBag_AddArtifactPresetItem(" .. tostring(s64_key) .. ")")
  else
    btn_slot:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactBag_RequestPopArtifactItem(" .. tostring(s64_key) .. ")")
  end
  local itemGrade = artifactItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  mainItemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  mainItemName:setLineCountByLimitAutoWrap(2)
  mainItemName:SetText(artifactItemSSW:getName())
  mainItemName:SetFontColor(itemGradeColor)
  local mainSlot = {}
  SlotItem.reInclude(mainSlot, "Artifact_Item_Slot_", 0, mainItemSlot, self._slotConfig)
  mainSlot:clearItem()
  mainSlot:setItemByStaticStatus(artifactItemSSW, bagItemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
  if self._isConsole == true then
    btn_slot:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_OnPadSnap(true)")
    btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_OnPadSnap(false)")
    if ToClient_isConsole() == true then
      mainSlot.icon:addInputEvent("Mouse_On", "")
      mainSlot.icon:addInputEvent("Mouse_Out", "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleArtifactItemTooltip(" .. tostring(s64_key) .. ")")
    else
      btn_slot:addInputEvent("Mouse_On", "PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(true," .. tostring(s64_key) .. ")")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(false," .. tostring(s64_key) .. ")")
    end
  else
    btn_slot:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(true," .. tostring(s64_key) .. ")")
    btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(false," .. tostring(s64_key) .. ")")
    mainSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowItemTooltip(true," .. tostring(s64_key) .. ")")
    mainSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowItemTooltip(false," .. tostring(s64_key) .. ")")
  end
  local subItemSlot_0_BG = UI.getChildControl(btn_slot, "Static_Artifact_BG_0")
  local subItemSlot_0 = UI.getChildControl(subItemSlot_0_BG, "Static_Icon")
  local subSlot_0 = {}
  SlotItem.reInclude(subSlot_0, "Artifact_SubItem_Slot_0_", 0, subItemSlot_0, self._subSlotConfig)
  if subItem_0_SSW ~= nil then
    subSlot_0:setItemByStaticStatus(subItem_0_SSW)
  else
    subSlot_0:clearItem()
  end
  if ToClient_isConsole() == false then
    if subItem_0_SSW ~= nil then
      subSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      subSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    else
      subSlot_0.icon:addInputEvent("Mouse_On", "")
      subSlot_0.icon:addInputEvent("Mouse_Out", "")
    end
  end
  local subItemSlot_1_BG = UI.getChildControl(btn_slot, "Static_Artifact_BG_1")
  local subItemSlot_1 = UI.getChildControl(subItemSlot_1_BG, "Static_Icon")
  local subSlot_1 = {}
  SlotItem.reInclude(subSlot_1, "Artifact_SubItem_Slot_1_", 0, subItemSlot_1, self._subSlotConfig)
  if subItem_1_SSW ~= nil then
    subSlot_1:setItemByStaticStatus(subItem_1_SSW)
  else
    subSlot_1:clearItem()
  end
  if ToClient_isConsole() == false then
    if subItem_1_SSW ~= nil then
      subSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      subSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    else
      subSlot_1.icon:addInputEvent("Mouse_On", "")
      subSlot_1.icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_LightStoneBag:createArtifactPresetListContent(content, s64_key)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  local presetNo = Int64toInt32(s64_key)
  local isExistPresetData = tempWrapper:isExistArtifactPresetData(presetNo)
  local isSameBoth = tempWrapper:isSameArtifactPresetSlotBoth(presetNo)
  local btn_preset = UI.getChildControl(content, "RadioButton_ArtifactPreset")
  local btn_showEffect = UI.getChildControl(btn_preset, "Button_ShowEffect")
  local btn_equip = UI.getChildControl(btn_preset, "Button_Equip")
  local txt_presetNameEditBox = UI.getChildControl(btn_preset, "Edit_ItemName")
  local keyGuideX = UI.getChildControl(txt_presetNameEditBox, "Static_X_ConsoleUI")
  txt_presetNameEditBox:SetMaxInput(12)
  if self._isConsole == true and self._isEditMode == true and self._lastPadSnappedPresetIndex_s64 == s64_key then
    btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_ArtifactPreset_SetFocusEdit(" .. tostring(s64_key) .. ")")
    keyGuideX:SetShow(true)
  else
    btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    keyGuideX:SetShow(false)
  end
  local stc_presetNumber = UI.getChildControl(btn_preset, "StaticText_NoTag")
  stc_presetNumber:SetText(tostring(presetNo))
  local stc_leftRedEffect = UI.getChildControl(btn_preset, "Static_Slot_Red_L")
  local stc_rightRedEffect = UI.getChildControl(btn_preset, "Static_Slot_Red_R")
  btn_preset:SetChildIndex(stc_leftRedEffect, 9999)
  btn_preset:SetChildIndex(stc_rightRedEffect, 9999)
  btn_preset:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_OnClickedPresetButton(" .. tostring(s64_key) .. ")")
  if self._isConsole == true then
    btn_preset:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_OnPadSnap(true," .. tostring(s64_key) .. ")")
    btn_preset:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_OnPadSnap(false," .. tostring(s64_key) .. ")")
    if self._isEditMode == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_ArtifactBag_OnClickedClearPreset(" .. tostring(s64_key) .. ")")
    else
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    end
  end
  if PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    if self._isConsole == true then
      btn_preset:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_ArtifactTooltip_ToggleArtifactPresetInfo(" .. tostring(presetNo) .. ")")
    else
      btn_showEffect:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(true," .. tostring(presetNo) .. ")")
      btn_showEffect:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false," .. tostring(presetNo) .. ")")
    end
  end
  local stc_leftArtifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_L")
  local stc_leftArtifactIcon = UI.getChildControl(stc_leftArtifactSlotBg, "Static_ItemIcon")
  local stc_leftPushedItemSlotBg_0 = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_0")
  local stc_leftPushedItemIcon_0 = UI.getChildControl(stc_leftPushedItemSlotBg_0, "Static_Icon")
  local stc_leftPushedItemSlotBg_1 = UI.getChildControl(btn_preset, "Static_LightStone_BG_L_1")
  local stc_leftPushedItemIcon_1 = UI.getChildControl(stc_leftPushedItemSlotBg_1, "Static_Icon")
  local stc_rightArtifactSlotBg = UI.getChildControl(btn_preset, "Static_ItemSlotBG_R")
  local stc_rightArtifactIcon = UI.getChildControl(stc_rightArtifactSlotBg, "Static_ItemIcon")
  local stc_rightPushedItemSlotBg_0 = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_0")
  local stc_rightPushedItemIcon_0 = UI.getChildControl(stc_rightPushedItemSlotBg_0, "Static_Icon")
  local stc_rightPushedItemSlotBg_1 = UI.getChildControl(btn_preset, "Static_LightStone_BG_R_1")
  local stc_rightPushedItemIcon_1 = UI.getChildControl(stc_rightPushedItemSlotBg_1, "Static_Icon")
  btn_equip:SetTextMode(__eTextMode_LimitText)
  if self._isEditMode == true then
    btn_equip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_PRESET_CLEAR"))
    btn_equip:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_OnClickedClearPreset(" .. tostring(s64_key) .. ")")
    txt_presetNameEditBox:SetIgnore(false)
  else
    btn_equip:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN_USE"))
    btn_equip:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactBag_OnClickedEquipButton(" .. tostring(s64_key) .. ")")
    txt_presetNameEditBox:SetIgnore(true)
  end
  if self._currentSelectedPresetIndex_s64 == nil then
    btn_preset:SetCheck(false)
  elseif Int64toInt32(self._currentSelectedPresetIndex_s64) == Int64toInt32(s64_key) then
    btn_preset:SetCheck(true)
  else
    btn_preset:SetCheck(false)
  end
  txt_presetNameEditBox:SetEditText(tempWrapper:getArtifactPresetName(presetNo))
  txt_presetNameEditBox:RegistReturnKeyEvent("PaGlobalFunc_ArtifactPreset_SetPresetName(" .. tostring(s64_key) .. ")")
  local leftArtifactItemSSW = tempWrapper:getArtifactPresetLeftArtifactItemStaticStatusWrapper(presetNo)
  local leftArtifactFirstPushedItemSSW = tempWrapper:getArtifactPresetLeftFirstPushedItemItemStaticStatusWrapper(presetNo)
  local leftArtifactSecondPushedItemSSW = tempWrapper:getArtifactPresetLeftSecondPushedItemItemStaticStatusWrapper(presetNo)
  local isExistLeftArtifact = false
  if leftArtifactItemSSW ~= nil then
    local leftPushedItemKey_0 = ItemEnchantKey(0, 0)
    if leftArtifactFirstPushedItemSSW ~= nil then
      leftPushedItemKey_0 = leftArtifactFirstPushedItemSSW:get()._key
    end
    local leftPushedItemKey_1 = ItemEnchantKey(0, 0)
    if leftArtifactSecondPushedItemSSW ~= nil then
      leftPushedItemKey_1 = leftArtifactSecondPushedItemSSW:get()._key
    end
    local currentLeftArtifactCount = tempWrapper:getArtifactItemCountFromArtifactBag(leftArtifactItemSSW:get()._key, leftPushedItemKey_0, leftPushedItemKey_1)
    if isSameBoth == true then
      if currentLeftArtifactCount > 0 then
        isExistLeftArtifact = true
      end
    elseif currentLeftArtifactCount > 0 then
      isExistLeftArtifact = true
    end
    stc_leftRedEffect:SetShow(not isExistLeftArtifact)
  else
    stc_leftRedEffect:SetShow(false)
  end
  local artifactPreset_leftArtifactSlot = {}
  SlotItem.reInclude(artifactPreset_leftArtifactSlot, "ArtufactPreset_Left_Slot_", 0, stc_leftArtifactIcon, self._slotConfig)
  if leftArtifactItemSSW ~= nil then
    artifactPreset_leftArtifactSlot:setItemByStaticStatus(leftArtifactItemSSW, 1)
    if ToClient_isConsole() == false then
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowItemTooltip(true, true," .. tostring(s64_key) .. ")")
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowItemTooltip(false, true," .. tostring(s64_key) .. ")")
    end
    if self._isEditMode == true then
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_ClearPresetSlotOnce(true," .. tostring(s64_key) .. ")")
    else
      artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    end
  else
    artifactPreset_leftArtifactSlot:clearItem()
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_leftSubSlot_0 = {}
  SlotItem.reInclude(artifactPreset_leftSubSlot_0, "ArtufactPreset_Left_SubSlot_0_", 0, stc_leftPushedItemIcon_0, self._subSlotConfig)
  if leftArtifactFirstPushedItemSSW ~= nil then
    artifactPreset_leftSubSlot_0:setItemByStaticStatus(leftArtifactFirstPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(true, true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(false, true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    end
  else
    artifactPreset_leftSubSlot_0:clearItem()
    artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_leftSubSlot_1 = {}
  SlotItem.reInclude(artifactPreset_leftSubSlot_1, "ArtufactPreset_Left_SubSlot_1_", 0, stc_leftPushedItemIcon_1, self._subSlotConfig)
  if leftArtifactSecondPushedItemSSW ~= nil then
    artifactPreset_leftSubSlot_1:setItemByStaticStatus(leftArtifactSecondPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(true, true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(false, true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    end
  else
    artifactPreset_leftSubSlot_1:clearItem()
    artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_On", "")
    artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_Out", "")
  end
  local rightArtifactItemSSW = tempWrapper:getArtifactPresetRightArtifactItemStaticStatusWrapper(presetNo)
  local rightArtifactFirstPushedItemSSW = tempWrapper:getArtifactPresetRightFirstPushedItemStaticStatusWrapper(presetNo)
  local rightArtifactSecondPushedItemSSW = tempWrapper:getArtifactPresetRightSecondPushedItemStaticStatusWrapper(presetNo)
  local isExistRightArtifact = false
  if rightArtifactItemSSW ~= nil then
    local rightPushedItemKey_0 = ItemEnchantKey(0, 0)
    if rightArtifactFirstPushedItemSSW ~= nil then
      rightPushedItemKey_0 = rightArtifactFirstPushedItemSSW:get()._key
    end
    local rightPushedItemKey_1 = ItemEnchantKey(0, 0)
    if rightArtifactSecondPushedItemSSW ~= nil then
      rightPushedItemKey_1 = rightArtifactSecondPushedItemSSW:get()._key
    end
    local currentRightArtifactCount = tempWrapper:getArtifactItemCountFromArtifactBag(rightArtifactItemSSW:get()._key, rightPushedItemKey_0, rightPushedItemKey_1)
    if isSameBoth == true then
      if currentRightArtifactCount > 1 then
        isExistRightArtifact = true
      end
    elseif currentRightArtifactCount > 0 then
      isExistRightArtifact = true
    end
    stc_rightRedEffect:SetShow(not isExistRightArtifact)
  else
    stc_rightRedEffect:SetShow(false)
  end
  local artifactPreset_rightArtifactSlot = {}
  SlotItem.reInclude(artifactPreset_rightArtifactSlot, "ArtufactPreset_Right_Slot_", 0, stc_rightArtifactIcon, self._slotConfig)
  if rightArtifactItemSSW ~= nil then
    artifactPreset_rightArtifactSlot:setItemByStaticStatus(rightArtifactItemSSW, 1)
    if ToClient_isConsole() == false then
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowItemTooltip(true, false," .. tostring(s64_key) .. ")")
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowItemTooltip(false, false," .. tostring(s64_key) .. ")")
    end
    if self._isEditMode == true then
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_ClearPresetSlotOnce(false," .. tostring(s64_key) .. ")")
    else
      artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    end
  else
    artifactPreset_rightArtifactSlot:clearItem()
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_RUp", "")
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_rightSubSlot_0 = {}
  SlotItem.reInclude(artifactPreset_rightSubSlot_0, "ArtufactPreset_Right_SubSlot_0_", 0, stc_rightPushedItemIcon_0, self._subSlotConfig)
  if rightArtifactFirstPushedItemSSW ~= nil then
    artifactPreset_rightSubSlot_0:setItemByStaticStatus(rightArtifactFirstPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(true, false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(false, false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    end
  else
    artifactPreset_rightSubSlot_0:clearItem()
    artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_Out", "")
  end
  local artifactPreset_rightSubSlot_1 = {}
  SlotItem.reInclude(artifactPreset_rightSubSlot_1, "ArtufactPreset_Right_SubSlot_1_", 0, stc_rightPushedItemIcon_1, self._subSlotConfig)
  if rightArtifactSecondPushedItemSSW ~= nil then
    artifactPreset_rightSubSlot_1:setItemByStaticStatus(rightArtifactSecondPushedItemSSW)
    if ToClient_isConsole() == false then
      artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(true, false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactPreset_ShowSubItemTooltip(false, false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    end
  else
    artifactPreset_rightSubSlot_1:clearItem()
    artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_On", "")
    artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_Out", "")
  end
  txt_presetNameEditBox:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  btn_showEffect:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftArtifactSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftSubSlot_0.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_leftSubSlot_1.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightArtifactSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightSubSlot_0.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
  artifactPreset_rightSubSlot_1.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_OnClickedPresetControl(" .. tostring(s64_key) .. ")")
end
function PaGlobal_LightStoneBag:createLightStoneBagListContent(content, s64_key)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local subTypeIndex = getLightBagSubIndex(s64_key)
  local bagIndex = getLightBagIndex(s64_key)
  local lightStoneItemSSW = ToClient_GetLightStoneBagItemStaticStatusWrapper(subTypeIndex, bagIndex)
  if lightStoneItemSSW == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:createLightStoneBagListContent] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local txt_itemName = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local txt_itemDesc = UI.getChildControl(stc_itemSlotBg, "StaticText_Desc")
  if self._isConsole == true then
    btn_item:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_RequestPopLightStoneItem(" .. tostring(s64_key) .. ")")
  else
    btn_item:addInputEvent("Mouse_RUp", "PaGlobalFunc_LightStoneBag_RequestPopLightStoneItem(" .. tostring(s64_key) .. ")")
  end
  if self._isConsole == true then
    btn_item:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_OnPadSnap(true)")
    btn_item:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_OnPadSnap(false)")
    if ToClient_isConsole() == true then
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(" .. tostring(s64_key) .. ")")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(true," .. tostring(s64_key) .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(false," .. tostring(s64_key) .. ")")
    end
  else
    btn_item:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(true," .. tostring(s64_key) .. ")")
    btn_item:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(false," .. tostring(s64_key) .. ")")
  end
  local itemGrade = lightStoneItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  txt_itemName:SetTextMode(__eTextMode_LimitText)
  txt_itemName:SetText(lightStoneItemSSW:getName())
  txt_itemName:SetFontColor(itemGradeColor)
  local classType = getSelfPlayer():getClassType()
  local jewelSkillStaticWrapper = lightStoneItemSSW:getSkillByIdx(classType)
  if jewelSkillStaticWrapper ~= nil then
    local buffCount = jewelSkillStaticWrapper:getBuffCount()
    local descText = ""
    for buffIdx = 0, buffCount - 1 do
      local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
      if descCurrent == "" then
        break
      end
      if buffIdx == 0 then
        descText = descCurrent
      else
        descText = descText .. ", " .. descCurrent
      end
    end
    txt_itemDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    txt_itemDesc:setLineCountByLimitAutoWrap(2)
    txt_itemDesc:SetText(descText)
  end
  local slot = {}
  SlotItem.reInclude(slot, "LightStone_Item_Slot_", 0, stc_itemIcon, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(lightStoneItemSSW, ToClient_GetLightStoneBagItemCount64(subTypeIndex, bagIndex), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
  if ToClient_isConsole() == true then
    slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(" .. tostring(s64_key) .. ")")
  else
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_ShowItemTooltip(true," .. tostring(s64_key) .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_ShowItemTooltip(false," .. tostring(s64_key) .. ")")
  end
end
function PaGlobal_LightStoneBag:resetData()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._btn_editPreset:SetCheck(false)
  self._currentSelectedPresetIndex_s64 = nil
  self._lastPadSnappedPresetIndex_s64 = nil
  self._currentMouseOnArtifactBagIndex = nil
  self._currentMouseOnArtifactPresetInfo.presetNo = nil
  self._currentMouseOnArtifactPresetInfo.isLeft = nil
  if self._isConsole == true then
    self._beforePadSnapState = nil
    self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag)
  end
  self:syncLightStoneTypeFilterButton()
  self:resyncArtifactBagEditMode()
end
function PaGlobal_LightStoneBag:changePadSnapState(newState, isForceChange)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if newState ~= LightStoneBagConsoleSnapState.SnapOnBag and newState ~= LightStoneBagConsoleSnapState.SnapOnPreset and newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 PadSnapState \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isChangedState = self._currentPadSnapState ~= newState or self._beforePadSnapState ~= newState
  if newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._beforePadSnapState = newState
  end
  if self._currentPadSnapState ~= LightStoneBagConsoleSnapState.SnapOnEditMode or isForceChange ~= nil and isForceChange == true then
    self._currentPadSnapState = newState
  end
  if isChangedState == true then
    self:resyncKeyGuideState()
  end
end
function PaGlobal_LightStoneBag:resyncKeyGuideState()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local showKeyGuideList = Array.new()
  local hideKeyGuideList = Array.new()
  if self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnBag then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    showKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
    if ToClient_isConsole() == true then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    end
    showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
    if ToClient_isConsole() == false then
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    end
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
  elseif self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN_USE"))
    showKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
  elseif self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    if self._beforePadSnapState == LightStoneBagConsoleSnapState.SnapOnBag then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
    elseif self._beforePadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    else
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    end
  else
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 self._currentPadSnapState\236\157\152 \234\176\146\236\151\144 \235\140\128\237\149\156 \236\178\152\235\166\172\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  for key, control in pairs(showKeyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  for key, control in pairs(hideKeyGuideList) do
    if control ~= nil then
      control:SetShow(false)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(showKeyGuideList, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_LightStoneBag:resyncArtifactBagEditMode()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local prevEditMode = self._isEditMode
  self._isEditMode = self._ui._btn_editPreset:IsCheck()
  if prevEditMode == true and self._isEditMode == false then
    for index = 1, self._artifactInventoryPresetCountMax do
      PaGlobalFunc_ArtifactPreset_SetPresetName(toInt64(0, index))
    end
  end
  if self._isEditMode == true then
    self._ui._txt_editPreset:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ARTIFACTS_PRESET_SAVE"))
  else
    self._ui._txt_editPreset:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN"))
  end
  local centerPosX = 0
  if self._isConsole == true then
    local stc_innerKeyGuide_Plus = UI.getChildControl(self._ui._txt_editPreset, "Static_Plus_ConsoleUI")
    local stc_innerKeyGuide_Y = UI.getChildControl(self._ui._txt_editPreset, "Static_Y")
    local editButtonSizeX = self._ui._btn_editPreset:GetSizeX()
    local editRealControlSizeX = self._ui._txt_editPreset:GetSizeX() + self._ui._txt_editPreset:GetTextSizeX() + stc_innerKeyGuide_Plus:GetSizeX() + stc_innerKeyGuide_Y:GetSizeX()
    centerPosX = (editButtonSizeX - editRealControlSizeX) / 2
  else
    local editButtonSizeX = self._ui._btn_editPreset:GetSizeX()
    local editRealControlSizeX = self._ui._txt_editPreset:GetSizeX() + self._ui._txt_editPreset:GetTextSizeX()
    centerPosX = (editButtonSizeX - editRealControlSizeX) / 2
  end
  if centerPosX < 0 then
    centerPosX = 0
  end
  self._ui._txt_editPreset:SetPosX(centerPosX)
  self:simpleReloadList_artifactPresetList()
  self:simpleReloadList_artifactBagList()
  if self._isConsole == true and self._isEditMode ~= prevEditMode then
    if self._isEditMode == true then
      self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnEditMode)
    else
      self:changePadSnapState(self._beforePadSnapState, true)
    end
  end
  ClearFocusEdit()
end
function PaGlobal_LightStoneBag:updateArtifactBagSlotCount()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local currentSlotCount = ToClient_GetArtifactBagSize()
  if currentSlotCount >= self._artifactInventorySlotCountMax then
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FFD05D48)
  else
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FF83A543)
  end
  self._ui._txt_slotCount:SetText(tostring(ToClient_GetArtifactBagSize()) .. " / " .. tostring(self._artifactInventorySlotCountMax))
end
function PaGlobal_LightStoneBag:onClickedTab(tabIndex)
  if Panel_Window_LightStoneBag == nil or tabIndex == nil then
    return
  end
  if tabIndex < 0 then
    tabIndex = 0
  elseif tabIndex >= LightStoneBagTabIndex.TabCount then
    tabIndex = LightStoneBagTabIndex.TabCount - 1
  end
  if tabIndex == LightStoneBagTabIndex.Artifact then
    self._ui._stc_lightStoneSubTabGroup:SetShow(false)
    self._ui._stc_artifactBagArea:SetShow(true)
    self._ui._stc_lightStoneBagArea:SetShow(false)
    self._ui._stc_selectedLine_artifact:SetShow(true)
    self._ui._stc_selectedLine_lightStone:SetShow(false)
    self:resyncArtifactBagEditMode()
    self:reloadList_artifactBagList(false)
    self:reloadList_artifactPresetList(false)
    Inventory_SetFunctor(PaGlobalFunc_ArtifactBag_Filter, PaGlobalFunc_ArtifactBag_RClickFunction, nil, nil)
    self._ui._btn_tab_artifact:SetCheck(true)
    self._ui._btn_tab_lightStone:SetCheck(false)
  elseif tabIndex == LightStoneBagTabIndex.LightStone then
    self._ui._stc_lightStoneSubTabGroup:SetShow(true)
    self._ui._stc_artifactBagArea:SetShow(false)
    self._ui._stc_lightStoneBagArea:SetShow(true)
    self._ui._stc_selectedLine_artifact:SetShow(false)
    self._ui._stc_selectedLine_lightStone:SetShow(true)
    self:reloadList_lightStoneBagList(false)
    self._ui._btn_editPreset:SetCheck(false)
    if self._isConsole == true then
      self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag, true)
    end
    Inventory_SetFunctor(PaGlobalFunc_LightStoneBag_Filter, PaGlobalFunc_LightStoneBag_RClickFunction, nil, nil)
    self._ui._btn_tab_artifact:SetCheck(false)
    self._ui._btn_tab_lightStone:SetCheck(true)
  else
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:onClickedTab] Tab Index\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  ClearFocusEdit()
  self._currentTabIndex = tabIndex
end
function PaGlobal_LightStoneBag:reloadList_lightStoneBagList(isHoldScroll)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._lightStoneBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:reloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentScrollIndex = self._ui._lightStoneBagList:getCurrenttoIndex()
  local currentControlPos = self._ui._lightStoneBagList:GetVScroll():GetControlPos()
  listManager:clearKey()
  for subTypeIndex = 0, __eLightStoneItemSubType_Count - 1 do
    if self._lightStoneTypeFilter[subTypeIndex] ~= nil and self._lightStoneTypeFilter[subTypeIndex] == true then
      local subBagCount = ToClient_GetLightStoneBagSize(subTypeIndex)
      for index = 0, subBagCount - 1 do
        listManager:pushKey(toInt64(subTypeIndex, index))
      end
    end
  end
  local stc_emptyGuide = UI.getChildControl(self._ui._lightStoneBagList, "StaticText_Empty_LightStone")
  if stc_emptyGuide ~= nil then
    if Int64toInt32(listManager:getSize()) == 0 then
      stc_emptyGuide:SetShow(true)
    else
      stc_emptyGuide:SetShow(false)
    end
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._lightStoneBagList:moveIndex(currentScrollIndex)
    self._ui._lightStoneBagList:GetVScroll():SetControlPos(currentControlPos)
  end
end
function PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._lightStoneBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentLightStoneBagContentCount = Int64toInt32(listManager:getSize())
  for index = 0, currentLightStoneBagContentCount - 1 do
    local s64_key = self._ui._lightStoneBagList:getKeyByIndex(index)
    local content = self._ui._lightStoneBagList:GetContentByKey(s64_key)
    if content ~= nil then
      self:createLightStoneBagListContent(content, s64_key)
    end
  end
end
function PaGlobal_LightStoneBag:reloadList_artifactBagList(isHoldScroll)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:reloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentScrollIndex = self._ui._artifactBagList:getCurrenttoIndex()
  local currentControlPos = self._ui._artifactBagList:GetVScroll():GetControlPos()
  listManager:clearKey()
  local currentArtifactBagSize = ToClient_GetArtifactBagSize()
  for index = 0, currentArtifactBagSize - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  local stc_emptyGuide = UI.getChildControl(self._ui._artifactBagList, "StaticText_Empty_Artifacts")
  if stc_emptyGuide ~= nil then
    if Int64toInt32(listManager:getSize()) == 0 then
      stc_emptyGuide:SetShow(true)
    else
      stc_emptyGuide:SetShow(false)
    end
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._artifactBagList:moveIndex(currentScrollIndex)
    self._ui._artifactBagList:GetVScroll():SetControlPos(currentControlPos)
  end
  self:updateArtifactBagSlotCount()
end
function PaGlobal_LightStoneBag:simpleReloadList_artifactBagList()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentArtifactBagContentCount = Int64toInt32(listManager:getSize())
  for index = 0, currentArtifactBagContentCount - 1 do
    local s64_key = self._ui._artifactBagList:getKeyByIndex(index)
    local content = self._ui._artifactBagList:GetContentByKey(s64_key)
    if content ~= nil then
      self:createArtifactBagListContent(content, s64_key)
    end
  end
  self:updateArtifactBagSlotCount()
end
function PaGlobal_LightStoneBag:reloadList_artifactPresetList(isHoldScroll)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactPresetList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:reloadList_artifactPresetList] \236\156\160\235\172\188 \237\148\132\235\166\172\236\133\139\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentScrollIndex = self._ui._artifactPresetList:getCurrenttoIndex()
  local currentControlPos = self._ui._artifactPresetList:GetVScroll():GetControlPos()
  listManager:clearKey()
  for index = 1, self._artifactInventoryPresetCountMax do
    listManager:pushKey(toInt64(0, index))
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._artifactPresetList:setCurrenttoIndex(currentScrollIndex)
    self._ui._artifactPresetList:GetVScroll():SetControlPos(currentControlPos)
  end
end
function PaGlobal_LightStoneBag:simpleReloadList_artifactPresetList()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactPresetList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_artifactPresetList] \236\156\160\235\172\188 \237\148\132\235\166\172\236\133\139\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentContentCount = Int64toInt32(listManager:getSize())
  for index = 0, currentContentCount - 1 do
    local s64_key = self._ui._artifactPresetList:getKeyByIndex(index)
    local content = self._ui._artifactPresetList:GetContentByKey(s64_key)
    if content ~= nil then
      self:createArtifactPresetListContent(content, s64_key)
    end
  end
end
function PaGlobal_LightStoneBag:hideMouseRClickGuide()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._currentTabIndex == LightStoneBagTabIndex.LightStone then
    local listManager = self._ui._lightStoneBagList:getElementManager()
    if listManager == nil then
      UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local currentLightStoneBagContentCount = Int64toInt32(listManager:getSize())
    for index = 0, currentLightStoneBagContentCount - 1 do
      local s64_key = self._ui._lightStoneBagList:getKeyByIndex(index)
      PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(false, s64_key)
    end
  elseif self._currentTabIndex == LightStoneBagTabIndex.Artifact then
    local listManager = self._ui._artifactBagList:getElementManager()
    if listManager == nil then
      UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local currentArtifactBagContentCount = Int64toInt32(listManager:getSize())
    for index = 0, currentArtifactBagContentCount - 1 do
      local s64_key = self._ui._artifactBagList:getKeyByIndex(index)
      PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(false, s64_key)
    end
  end
end
function PaGlobal_LightStoneBag:onClickedLightStoneTypeButton(typeIndex)
  if Panel_Window_LightStoneBag == nil or typeIndex == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.LightStone then
    return
  end
  if self._ui._lightStoneTypeCheckButtonList[typeIndex] == nil or self._lightStoneTypeFilter[typeIndex] == nil then
    return
  end
  self._lightStoneTypeFilter[typeIndex] = self._ui._lightStoneTypeCheckButtonList[typeIndex]:IsCheck()
  self:syncLightStoneTypeFilterButton()
  self:reloadList_lightStoneBagList(false)
end
function PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(isShow, s64_key)
  PaGlobalFunc_ArtifactBag_OnPadSnap(isShow)
  PaGlobalFunc_ArtifactBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(isShow, s64_key)
  PaGlobalFunc_LightStoneBag_OnPadSnap(isShow)
  PaGlobalFunc_LightStoneBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:syncLightStoneTypeFilterButton()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  for typeIndex, control in pairs(self._ui._lightStoneTypeCheckButtonList) do
    if control ~= nil and self._lightStoneTypeFilter[typeIndex] ~= nil and control:IsCheck() ~= self._lightStoneTypeFilter[typeIndex] then
      control:SetCheck(self._lightStoneTypeFilter[typeIndex])
    end
  end
end
function PaGlobal_LightStoneBag:fromClient_reloadLightStoneBagList(isFullReload)
  if Panel_Window_LightStoneBag == nil or isFullReload == nil then
    return
  end
  if isFullReload == true then
    self:reloadList_lightStoneBagList(true)
  else
    self:simpleReloadList_lightStoneBagList()
  end
end
function PaGlobal_LightStoneBag:fromClient_reloadArtifactBagList(isFullReload)
  if Panel_Window_LightStoneBag == nil or isFullReload == nil then
    return
  end
  if isFullReload == true then
    self:reloadList_artifactBagList(true)
  else
    self:simpleReloadList_artifactBagList()
  end
end
function PaGlobal_LightStoneBag:fromClient_reloadArtifactPresetList(isFullReload)
  if Panel_Window_LightStoneBag == nil or isFullReload == nil then
    return
  end
  if isFullReload == nil then
    self:reloadList_artifactPresetList(true)
  else
    self:simpleReloadList_artifactPresetList()
  end
end
function PaGlobal_LightStoneBag:setCurrentSelectedPresetIndex(s64_key)
  if Panel_Window_LightStoneBag == nil or s64_key == nil then
    return
  end
  self._currentSelectedPresetIndex_s64 = s64_key
end
function PaGlobal_LightStoneBag:toggleArtifactItemTooltip(s64_key)
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif PaGlobalFunc_Tooltip_Item_All_GetShow() == true then
    isShow = false
  end
  PaGlobalFunc_ArtifactBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(s64_key)
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif PaGlobalFunc_Tooltip_Item_All_GetShow() == true then
    isShow = false
  end
  PaGlobalFunc_LightStoneBag_ShowItemTooltip(isShow, s64_key)
end
