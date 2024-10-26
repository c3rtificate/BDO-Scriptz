function HandleEventLUp_TrashBoxConfirm_All_RequestDelete()
  if PaGlobal_TrashBoxConfirm_All == nil then
    return
  end
  if PaGlobal_TrashBoxConfirm_All._deleteMode == PaGlobal_TrashBoxMode.InventoryMode then
    PaGlobal_Inventory_All_RequestDeleteItemList()
    PaGlobalFunc_TrashBoxConfirm_All_ClearItemList()
    PaGlobalFunc_TrashBoxConfirm_All_Close()
  elseif PaGlobal_TrashBoxConfirm_All._deleteMode == PaGlobal_TrashBoxMode.JewelInvenMode then
    ToClient_PopJewelNoDeleteList()
    PaGlobalFunc_TrashBoxConfirm_All_ClearItemList()
    PaGlobalFunc_TrashBoxConfirm_All_Close()
    if PaGlobalFunc_JewelInven_ResetListIndex ~= nil then
      PaGlobalFunc_JewelInven_ResetListIndex()
    end
  end
end
function FromClient_TrashBoxConfirm_All_UpdateItemList(control, key)
  if PaGlobal_TrashBoxConfirm_All == nil then
    return
  end
  if control == nil then
    _PA_ASSERT(false, "[FromClient_TrashBoxConfirm_All_UpdateItemList] control == nil")
    return
  end
  local slotNo = Int64toInt32(key)
  if slotNo >= PaGlobal_TrashBoxConfirm_All._config._INVEN_MAX_SLOTNO then
    _PA_ASSERT(false, "[FromClient_TrashBoxConfirm_All_UpdateItemList] invalid slotNo == " .. slotNo)
    return
  end
  local isChecked, deleteCount, inventoryType = PaGlobal_Inventory_All_DeleteItemSlotInfo(slotNo)
  if isChecked == false then
    return
  end
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemStaticStatus = itemWrapper:getStaticStatus()
  if itemStaticStatus == nil then
    return
  end
  local stc_imgBG = UI.getChildControl(control, "Static_SlotBG")
  local stc_img = UI.getChildControl(stc_imgBG, "StaticText_Slot")
  local txt_enchant = UI.getChildControl(stc_imgBG, "StaticText_Enchant")
  stc_img:ChangeTextureInfoNameDefault("Icon/" .. itemStaticStatus:getIconPath())
  local itemStatic = itemStaticStatus:get()
  local enchantLevel = itemStatic._key:getEnchantLevel()
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemStatic._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemStatic._key)
  end
  if itemStatic:isEquipable() and enchantLevel > 0 and enchantLevel < 16 then
    txt_enchant:SetText("+" .. tostring(enchantLevel))
    txt_enchant:SetShow(true)
  elseif itemStatic:isEquipable() and 16 == enchantLevel then
    txt_enchant:SetText("I")
    if true == _ContentsGroup_KoreanEnchantGrade then
      txt_enchant:SetText("\236\158\165")
    end
    txt_enchant:SetShow(true)
  elseif itemStatic:isEquipable() and 17 == enchantLevel then
    txt_enchant:SetText("II")
    if true == _ContentsGroup_KoreanEnchantGrade then
      txt_enchant:SetText("\234\180\145")
    end
    txt_enchant:SetShow(true)
  elseif itemStatic:isEquipable() and 18 == enchantLevel then
    txt_enchant:SetText("III")
    if true == _ContentsGroup_KoreanEnchantGrade then
      txt_enchant:SetText("\234\179\160")
    end
    txt_enchant:SetShow(true)
  elseif itemStatic:isEquipable() and 19 == enchantLevel then
    txt_enchant:SetText("IV")
    if true == _ContentsGroup_KoreanEnchantGrade then
      txt_enchant:SetText("\236\156\160")
    end
    txt_enchant:SetShow(true)
  elseif itemStatic:isEquipable() and 20 == enchantLevel then
    txt_enchant:SetText("V")
    if true == _ContentsGroup_KoreanEnchantGrade then
      txt_enchant:SetText("\235\143\153")
    end
    txt_enchant:SetShow(true)
  else
    txt_enchant:SetText("")
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemStaticStatus:getItemClassify() and (itemStaticStatus:isSpecialEnchantItem() == false or itemStaticStatus:isKingAccessory() == true) then
    if 1 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("I")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\236\158\165")
      end
      txt_enchant:SetShow(true)
    elseif 2 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("II")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\234\180\145")
      end
      txt_enchant:SetShow(true)
    elseif 3 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("III")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\234\179\160")
      end
      txt_enchant:SetShow(true)
    elseif 4 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("IV")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\236\156\160")
      end
      txt_enchant:SetShow(true)
    elseif 5 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("V")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\235\143\153")
      end
      txt_enchant:SetShow(true)
    elseif 6 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("VI")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\236\154\180")
      end
      txt_enchant:SetShow(true)
    elseif 7 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("VII")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\236\154\176")
      end
      txt_enchant:SetShow(true)
    elseif 8 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("VIII")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\237\146\141")
      end
      txt_enchant:SetShow(true)
    elseif 9 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("IX")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\235\139\168")
      end
      txt_enchant:SetShow(true)
    elseif 10 == itemStatic._key:getEnchantLevel() then
      txt_enchant:SetText("X")
      if true == _ContentsGroup_KoreanEnchantGrade then
        txt_enchant:SetText("\237\153\152")
      end
      txt_enchant:SetShow(true)
    end
  end
  if itemStatic:isCash() then
    txt_enchant:SetShow(false)
  end
  local txt_itemName = UI.getChildControl(control, "StaticText_ItemName")
  txt_itemName:SetTextMode(__eTextMode_LimitText)
  local nameColorGrade = itemStaticStatus:getGradeType()
  if 0 == nameColorGrade then
    txt_itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
  elseif 1 == nameColorGrade then
    txt_itemName:SetFontColor(Defines.Color.C_FF83A543)
  elseif 2 == nameColorGrade then
    txt_itemName:SetFontColor(Defines.Color.C_FF438DCC)
  elseif 3 == nameColorGrade then
    txt_itemName:SetFontColor(Defines.Color.C_FFF5BA3A)
  elseif 4 == nameColorGrade then
    txt_itemName:SetFontColor(Defines.Color.C_FFD05D48)
  else
    txt_itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
  end
  local showItemKey = itemStaticStatus:get()._key:getItemKey()
  local devShowItemKey = PaGlobal_showKey(showItemKey)
  enchantLevel = itemStaticStatus:get()._key:getEnchantLevel()
  if itemStaticStatus:getItemType() == 1 and enchantLevel > 15 then
    local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemStaticStatus:getName() .. devShowItemKey
    txt_itemName:SetText(itemAndEnchantName)
  elseif enchantLevel > 0 and itemStaticStatus:getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory and (itemStaticStatus:isSpecialEnchantItem() == false or itemStaticStatus:isKingAccessory() == true) then
    local itemAndEnchantName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemStaticStatus:getName() .. devShowItemKey
    txt_itemName:SetText(itemAndEnchantName)
  else
    txt_itemName:SetText(itemStaticStatus:getName() .. devShowItemKey)
  end
  local txt_count = UI.getChildControl(control, "StaticText_count")
  local count32 = Int64toInt32(deleteCount)
  txt_count:SetText("X " .. count32)
end
function PaGlobalFunc_TrashBoxConfirm_All_Open(trashBoxMode)
  if PaGlobal_TrashBoxConfirm_All == nil then
    return
  end
  if PaGlobal_Inventory_All_IsDeleteMode == false then
    return
  end
  PaGlobal_TrashBoxConfirm_All:prepareOpen(trashBoxMode)
end
function PaGlobalFunc_TrashBoxConfirm_All_Close()
  if PaGlobal_TrashBoxConfirm_All == nil then
    return
  end
  PaGlobal_TrashBoxConfirm_All:prepareClose()
end
function PaGlobalFunc_TrashBoxConfirm_All_PushItem(slotNo)
  PaGlobal_TrashBoxConfirm_All._ui._deleteItemList:getElementManager():removeKey(toInt64(0, slotNo))
  PaGlobal_TrashBoxConfirm_All._ui._deleteItemList:getElementManager():pushKey(toInt64(0, slotNo))
  PaGlobal_TrashBoxConfirm_All._ui._deleteItemList:moveBottomIndex()
end
function PaGlobalFunc_TrashBoxConfirm_All_PopItem(slotNo)
  PaGlobal_TrashBoxConfirm_All._ui._deleteItemList:getElementManager():removeKey(toInt64(0, slotNo))
end
function PaGlobalFunc_TrashBoxConfirm_All_ClearItemList()
  PaGlobal_TrashBoxConfirm_All._ui._deleteItemList:getElementManager():clearKey()
  PaGlobal_TrashBoxConfirm_All._ui._deleteJewelItemList:getElementManager():clearKey()
end
function FromClient_TrashBoxConfirm_All_UpdateJewelItemList(control, jewelNo)
  if PaGlobal_TrashBoxConfirm_All == nil then
    return
  end
  if control == nil then
    _PA_ASSERT(false, "[FromClient_TrashBoxConfirm_All_UpdateJewelItemList] control == nil")
    return
  end
  local itemStaticStatus = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
  if itemStaticStatus == nil then
    return
  end
  local stc_imgBG = UI.getChildControl(control, "Static_SlotBG")
  local stc_img = UI.getChildControl(stc_imgBG, "StaticText_Slot")
  local txt_enchant = UI.getChildControl(stc_imgBG, "StaticText_Enchant")
  txt_enchant:SetShow(false)
  stc_img:ChangeTextureInfoNameDefault("Icon/" .. itemStaticStatus:getIconPath())
  local txt_itemName = UI.getChildControl(control, "StaticText_ItemName")
  txt_itemName:SetTextMode(__eTextMode_LimitText)
  txt_itemName:SetText(itemStaticStatus:getName())
  local txt_count = UI.getChildControl(control, "StaticText_count")
  txt_count:SetText("X " .. "1")
end
function PaGlobalFunc_TrashBoxConfirm_All_PushJewelItem(jewelNo)
  PaGlobal_TrashBoxConfirm_All._ui._deleteJewelItemList:getElementManager():removeKey(jewelNo)
  PaGlobal_TrashBoxConfirm_All._ui._deleteJewelItemList:getElementManager():pushKey(jewelNo)
end
