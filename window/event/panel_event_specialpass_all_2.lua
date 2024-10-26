function PaGlobal_Event_SpecialPass_Open()
  PaGlobal_SpecialPass:prepareOpen()
  PaGlobal_SpecialPass._totalRewardOpenFlag = false
end
function PaGlobal_Event_SpecialPass_Close()
  PaGlobal_SpecialPass:prepareClose()
end
function PaGlobal_GetSpecialPassKey()
  if Panel_Event_SpecialPass_All == nil then
    return false
  end
  return ToClient_GetCurrentSpecialPassKey()
end
function HandleEventOnOut_RewardItem_ShowSlotToolTip(isShow, isPassItem, idx)
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if isShow == nil or idx == nil or isPassItem == nil then
    return
  end
  if isShow == false then
    if PaGlobal_SpecialPass._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local itemEnchantKey = ToClient_GetSpecialPassItemEnchantKey(isPassItem, idx)
  if itemEnchantKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    return
  end
  local slotBG = PaGlobal_SpecialPass._itemList[idx]
  if slotBG == nil then
    return
  end
  local itemBG
  if isPassItem == true then
    itemBG = UI.getChildControl(slotBG, "Static_ItemIcon_Special_BG")
  else
    itemBG = UI.getChildControl(slotBG, "Static_ItemIcon_Basic_BG")
  end
  if itemBG == nil then
    return
  end
  local control = UI.getChildControl(itemBG, "Static_IconSlot")
  if control == nil then
    return
  end
  if PaGlobal_JewelInven._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true, false)
  end
end
function HandleEventLUp_GetBasicReward(idx)
  if Panel_Event_SpecialPass_All == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if #PaGlobal_SpecialPass._itemList ~= PaGlobal_SpecialPass._itemCount - 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx ~= PaGlobal_SpecialPass._currentRewardIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  ToClient_RequestSpecialPassReward(false, idx)
end
function HandleEventLUp_GetPassReward(idx)
  if Panel_Event_SpecialPass_All == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if #PaGlobal_SpecialPass._itemList ~= PaGlobal_SpecialPass._itemCount - 1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  if idx ~= PaGlobal_SpecialPass._currentPassRewardIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotAvailableSpecialItem"))
    return
  end
  ToClient_RequestSpecialPassReward(true, idx)
end
function HandleEventLUp_ShowSpecialPassPearlShop()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  if PaGlobal_SpecialPass._ui.btn_PearlShop:GetShow() == false then
    return
  end
  if isGameServiceTypeConsole() == true then
    PaGlobal_Event_SpecialPass_Close()
    HandleEventLUp_MenuRemake_CashShop()
  else
    PaGlobal_EasyBuy:Open(92)
  end
end
function HandleEventLUp_OpenTotalReward()
  if PaGlobal_TotalReward_All_Open ~= nil then
    PaGlobal_TotalReward_All_Open()
    PaGlobal_SpecialPass._totalRewardOpenFlag = true
    PaGlobal_Event_SpecialPass_Close()
  end
end
function PaGlobal_CheckifCloseByTotalReward()
  if Panel_Event_SpecialPass_All == nil then
    return
  end
  return PaGlobal_SpecialPass._totalRewardOpenFlag
end
function HandleEventLUp_SpecialPass_OpenRateViewByLink()
  PaGlobalFunc_Util_OpenRateView(PaGlobal_Event_SpecialPass_Close)
end
function HandleEventOnOut_SpecialPass_ChangeRateViewButtonText(isOn)
  if isOn == true then
    PaGlobal_SpecialPass._ui.txt_RateView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK_ON"))
  else
    PaGlobal_SpecialPass._ui.txt_RateView:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK"))
  end
end
