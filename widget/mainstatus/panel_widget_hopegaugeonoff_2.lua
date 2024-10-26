function HandleEventLUp_HopeGaugeOnOff_ChargeOpen()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  if infoUI._btn_charge:isPlayAnimation() then
    return
  end
  PaGlobal_HopeGauge:prepareOpen()
end
function HandleEventLUp_HopeGaugeOnOff_Open()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  if true == Panel_Widget_HopeGaugeOnOff:GetShow() then
    return
  end
  PaGlobal_HopeGaugeOnOff:prepareOpen()
end
function HandleEventRUp_HopeGaugeOnOff_Close()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  if false == Panel_Widget_HopeGaugeOnOff:GetShow() then
    return
  end
  local CloseXXX = function()
    PaGlobal_HopeGaugeOnOff:prepareClose()
    PaGlobalFunc_MessageBox_HopeGaugeDayShowCheck()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_MSG_WIDGETCLOSE")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxDesc,
    functionYes = CloseXXX,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle", false, true, 8)
end
function HandleEventLUp_HopeGaugeOnOff_ApplyItemScroll(idx)
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  local coolTime = ToClient_getItemCollectionScrollCoolTime()
  if 0 ~= coolTime then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_SymbolNo, "eErrNoHopeGaugeCoolTime", "cooltime", Util.Time.timeFormatting(coolTime)))
    return
  end
  local function buffOn()
    if infoUI._btn_off:isPlayAnimation() or infoUI._btn_1set:isPlayAnimation() or infoUI._btn_2set:isPlayAnimation() then
      return
    end
    ToClient_ApplyItemCollectionScroll(idx, false)
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE")
  if 0 == idx then
    contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_OFF_INFO")
  elseif 1 == idx then
    contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON_MSG", "grade", idx, "drop", ToClient_GetHopeDropByGrade(idx), "count", ToClient_GetHopeCountByGrade(idx))
  elseif 2 == idx then
    contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON_MSG", "grade", idx, "drop", ToClient_GetHopeDropByGrade(idx), "count", ToClient_GetHopeCountByGrade(idx))
  end
  contentString = contentString .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_DESC")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    content = contentString,
    functionYes = buffOn,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if -1 ~= PaGlobal_HopeGaugeOnOff._selectItemIndex then
    MessageBox.showMessageBox(messageboxData)
  end
end
function HandleEventLUp_HopeGaugeOnOff_SaveHopeGaugePos()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  PaGlobal_HopeGaugeOnOff:saveHopeGaugePos()
end
function HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(isShow, type)
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_HopeGaugeOnOff)
  if isShow == false then
    TooltipSimple_Hide()
    PaGlobal_HopeGaugeOnOff._isOver = false
    PaGlobal_HopeGaugeOnOff:ChangeButtonTexture()
    return
  end
  local name, desc, control
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local player = selfPlayer:get()
  local grade = player:getItemCollectionScrollGrade()
  local point = Util.Time.timeFormatting(Int64toInt32(player:getItemCollectionScrollPoint()))
  local drop = ToClient_AppliedHopeDrop()
  local count = ToClient_AppliedHopeCount()
  local tooltip = PaGlobal_HopeGaugeOnOff._tooltip
  name = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE")
  if tooltip._slot == type then
    desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_DESC", "point", point, "grade", grade, "drop", drop, "count", count)
    if 0 == grade then
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_DESC_OFF", "point", point)
    elseif 2 == grade then
      desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_DESC2", "point", point, "grade", grade, "drop", drop, "count", count)
    end
  elseif tooltip._charge == type then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_TOOLTIP_CHARGE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_CHARGE_INFO")
  elseif tooltip._off == type then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_OFF")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_OFF_INFO")
    PaGlobal_HopeGaugeOnOff_buttonOn_Renew(0)
  elseif tooltip._1set == type then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_1")
    desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON", "grade", type, "drop", ToClient_GetHopeDropByGrade(type), "count", ToClient_GetHopeCountByGrade(type))
    PaGlobal_HopeGaugeOnOff_buttonOn_Renew(1)
  elseif tooltip._2set == type then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_2")
    desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON2", "grade", type, "drop", ToClient_GetHopeDropByGrade(type), "count", ToClient_GetHopeCountByGrade(type))
    PaGlobal_HopeGaugeOnOff_buttonOn_Renew(2)
  end
  if selfPlayer:isUseDropItemGroupList() == true then
    local zeroPercentString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_NONE")
    for groupIndex = 0, __eEfficiencyOfDropItemGroup_Count - 1 do
      local addString = ""
      local itemDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercent(groupIndex)
      local maxDropGroupPercent = selfPlayer:getEfficiencyOfDropItemPercentMax(groupIndex)
      if itemDropGroupPercent > maxDropGroupPercent then
        itemDropGroupPercent = maxDropGroupPercent
      end
      if groupIndex == __eEfficiencyOfDropItemGroup_Normal then
        addString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_DESC1", "item", itemDropGroupPercent) .. "%" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_ITEMDROP_MAX_COUNT", "count", maxDropGroupPercent)
      elseif groupIndex == __eEfficiencyOfDropItemGroup_Special then
        local currentArshaServerBuffPercent = selfPlayer:getCurrentArshaServerItemDropBuffPercent()
        local currentMajorSiegeBuffPercent = selfPlayer:getCurrentMajorSiegeItemDropBuffPercent()
        local elementalMonsterBuffPercent = selfPlayer:getElementalMonsterItemDropBuffPercent()
        if _ContentsOption_CH_GameType == true then
          if itemDropGroupPercent == 0 then
            addString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_PART_CH", "item2", zeroPercentString)
          elseif currentMajorSiegeBuffPercent > 0 then
            addString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT_PART_CH", "item2", currentMajorSiegeBuffPercent)
          else
            UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\160\129\236\157\184 \236\188\128\236\157\180\236\138\164\236\158\133\235\139\136\235\139\164. \236\149\132\237\154\141 \237\136\180\237\140\129 \237\145\156\234\184\176\236\151\144 \236\139\164\237\140\168\236\178\152\235\166\172\235\144\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
          end
        elseif itemDropGroupPercent == 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", zeroPercentString, "item2", zeroPercentString, "item3", zeroPercentString)
        elseif currentArshaServerBuffPercent > 0 and currentMajorSiegeBuffPercent > 0 and elementalMonsterBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", currentArshaServerBuffPercent .. "%", "item2", currentMajorSiegeBuffPercent .. "%", "item3", elementalMonsterBuffPercent .. "%")
        elseif currentArshaServerBuffPercent > 0 and currentMajorSiegeBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", currentArshaServerBuffPercent .. "%", "item2", currentMajorSiegeBuffPercent .. "%", "item3", zeroPercentString)
        elseif currentArshaServerBuffPercent > 0 and elementalMonsterBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", currentArshaServerBuffPercent .. "%", "item2", zeroPercentString, "item3", elementalMonsterBuffPercent .. "%")
        elseif currentMajorSiegeBuffPercent > 0 and elementalMonsterBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", zeroPercentString, "item2", currentMajorSiegeBuffPercent .. "%", "item3", elementalMonsterBuffPercent .. "%")
        elseif currentArshaServerBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", currentArshaServerBuffPercent .. "%", "item2", zeroPercentString, "item3", zeroPercentString)
        elseif currentMajorSiegeBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", zeroPercentString, "item2", currentMajorSiegeBuffPercent .. "%", "item3", zeroPercentString)
        elseif elementalMonsterBuffPercent > 0 then
          addString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEMDROPEFFECT_EXTRAEFFECT", "item1", zeroPercentString, "item2", zeroPercentString, "item3", elementalMonsterBuffPercent .. "%")
        else
          UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\160\129\236\157\184 \236\188\128\236\157\180\236\138\164\236\158\133\235\139\136\235\139\164. \236\149\132\237\154\141 \237\136\180\237\140\129 \237\145\156\234\184\176\236\151\144 \236\139\164\237\140\168\236\178\152\235\166\172\235\144\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
        end
      else
        _PA_ASSERT(false, "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \237\153\149\235\165\160 \234\183\184\235\163\185 enum(" .. tostring(groupIndex) .. ")\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 string \236\160\149\236\157\152\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
      end
      desc = desc .. "\n" .. addString
    end
  end
  TooltipSimple_Show(Panel_Widget_HopeGaugeOnOff, name, desc)
end
function FromClient_HopeGaugeOnOff_updateHopeGrade(isAlarm)
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local grade = player:getItemCollectionScrollGrade()
  local isTown = player:getIsItemCollectionBuffInTown()
  if false == Panel_Widget_HopeGaugeOnOff:GetShow() and 0 ~= grade then
    PaGlobal_HopeGaugeOnOff:prepareOpen()
  elseif true == isAlarm then
    local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_UPDATE_GRADE", "grade", grade)
    if true == isTown then
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_UPDATE_GRADE_INTOWN")
    elseif 0 == grade then
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_POINT_ZERO")
    end
    Proc_ShowMessage_Ack(msg)
  end
  if 2 == grade then
    ToClient_UpdateOpenUICondition(__eCheckOpenUIType_ItemCollectionBuffLv2)
  end
  PaGlobal_HopeGaugeOnOff:update()
end
function FromCLient_HopeGaugeOnOff_changeScreen()
  PaGlobal_HopeGaugeOnOff:updatePos()
end
function FromClient_HopeGaugeOnOff_updateHopePoint()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local point = Int64toInt32(player:getItemCollectionScrollPoint())
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_CHARGE", "point", Util.Time.timeFormatting(point))
  if 0 == point then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_POINT_ZERO")
  end
  Proc_ShowMessage_Ack(msg)
  PaGlobal_HopeGaugeOnOff:update()
end
function FromClient_updateItemCollectionTimer()
  PaGlobal_HopeGaugeOnOff:update()
end
function FromClient_HopeGauge_PointIsFull(maxPoint)
  if nil == maxPoint or 0 == maxPoint then
    return
  end
  local fullPoint = Int64toInt32(maxPoint)
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local message = PAGetStringParam1(Defines.StringSheet_SymbolNo, "eErrNoHopeGaugePointisFull", "max", Util.Time.timeFormatting(fullPoint))
  local messageboxData = {
    title = titleText,
    content = message,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = false
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_HopeGauge_OnScreenResize()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_Widget_HopeGaugeOnOff)
end
function PaGloabl_HopeGaugeOnOff_ShowAni()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
end
function PaGloabl_HopeGaugeOnOff_HideAni()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
end
function PaGlobal_HopeGaugeOnOff_Close(isForce)
  PaGlobal_HopeGaugeOnOff:prepareClose(isForce)
end
function PaGlobal_HopeGaugeOnOff_buttonOn()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local grade = selfPlayer:get():getItemCollectionScrollGrade()
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  infoUI._btn_off:setRenderTexture(infoUI._btn_off:getBaseTexture())
  infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getBaseTexture())
  infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getBaseTexture())
  if 1 == grade then
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getClickTexture())
  elseif 2 == grade then
    infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getClickTexture())
  else
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getClickTexture())
  end
end
function PaGlobal_HopeGaugeOnOff_buttonOn_Renew(grade)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_HopeGaugeOnOff._isOver = true
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  infoUI._btn_off:setRenderTexture(infoUI._btn_off:getBaseTexture())
  infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getBaseTexture())
  infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getBaseTexture())
  if 1 == grade then
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getOnTexture())
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getOnTexture())
  elseif 2 == grade then
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getOnTexture())
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getOnTexture())
    infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getOnTexture())
  else
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getOnTexture())
  end
end
function PaGlobal_HopeGaugeOnOff_buttonOff(idx)
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  if 0 ~= idx then
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getBaseTexture())
  end
  if 1 ~= idx then
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getBaseTexture())
  end
  if 2 ~= idx then
    infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getBaseTexture())
  end
end
function PaGlobal_HopeGaugeOnOff_GetChargePosX()
  local infoUI = PaGlobal_HopeGaugeOnOff._ui
  return infoUI._btn_charge:GetPosX()
end
function PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(inventoryType, slotNo, itemGrade)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selectPoint = 0
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil ~= itemWrapper then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    if nil ~= itemEnchantWrapper then
      selectPoint = itemEnchantWrapper:getContentsEventParam1()
    end
  end
  local player = selfPlayer:get()
  local point = Int64toInt32(player:getItemCollectionScrollPoint())
  local ActiveHopeGaugeBuff = function()
    local selectIndex = MessageBoxCheck.getSelectedButtonIndex() - 1
    if selectIndex < 0 then
      selectIndex = 0
    elseif selectIndex > 2 then
      selectIndex = 2
    end
    ToClient_ApplyItemCollectionScroll(selectIndex, false)
  end
  local function ChargeHopeGagueBuff()
    ToClient_ChargeItemCollectionScrollByInventory(inventoryType, slotNo, 1)
    HandleEventLUp_HopeGaugeOnOff_Open()
  end
  local function ChargeHopeGagueBuff_dayCheck()
    ToClient_ChargeItemCollectionScrollByInventory(inventoryType, slotNo, 1)
    HandleEventLUp_HopeGaugeOnOff_Open()
    PaGlobalFunc_MessageBox_HopeGaugeDayCheck()
  end
  if point <= 0 then
    ChargeHopeGagueBuff()
    point = point + selectPoint
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_POPUP_UNCHARGE_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOPE_POPUP_UNCHARGE_DESC", "point", Util.Time.timeFormatting(point)),
      functionApply = ActiveHopeGaugeBuff,
      functionCancel = MessageBox_Empty_function,
      buttonStrings = {
        PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_OFF"),
        PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_1"),
        PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_2")
      },
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBoxCheck.showMessageBox(messageboxData, "middle")
    if itemGrade >= __eItemGradeUnique then
      MessageBoxCheck.setCheck(3)
    else
      MessageBoxCheck.setCheck(2)
    end
  else
    local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eItemCollectionScrollBuffShowToday)
    if nil ~= dayCheck then
      local _year = ToClient_GetThisYear()
      local _month = ToClient_GetThisMonth()
      local _day = ToClient_GetToday()
      local savedYear = dayCheck:GetYear()
      local savedMonth = dayCheck:GetMonth()
      local savedDay = dayCheck:GetDay()
      if _year == savedYear and _month == savedMonth and _day == savedDay then
        ChargeHopeGagueBuff()
        return
      end
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_POPUP_UNCHARGE_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOPE_POPUP_CHARGE_DESC", "point", Util.Time.timeFormatting(point)),
      functionApply = ChargeHopeGagueBuff_dayCheck,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "middle", false, true, 5)
  end
end
function FromClient_HopeGaugeOnOf_OnScreenResize_Console()
  if Panel_Widget_HopeGaugeOnOff == nil then
    return
  end
  PaGlobal_HopeGaugeOnOff:onScreenResizeForConsole()
end
function PaGlobal_HopeGaugeOnOff_showByToday()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return false
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eHopeGuageDontShowToday)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return false
    end
  end
  return true
end
