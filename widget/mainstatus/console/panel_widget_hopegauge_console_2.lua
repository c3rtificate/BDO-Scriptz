function PaGlobalFunc_HopeGauge_Console_Close()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  PaGlobal_HopeGauge_Console:prepareClose()
end
function PaGlobalFunc_HopeGauge_Console_Open()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  PaGlobal_HopeGauge_Console:prepareOpen()
end
function FromClient_HopeGaugeConsole_Update()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  if Panel_Widget_HopeGauge_Console:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:update()
  PaGlobal_HopeGauge_Console:updateButtons()
  PaGlobal_HopeGauge_Console:updateFeedItem()
end
function FromClient_HopeGaugeConsole_UpdateTimer()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  if Panel_Widget_HopeGauge_Console:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:updateTimerOnly()
end
function HandleClicked_HopeGuage_Console_SelectFeedItem(idx)
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge_Console:selectFeedItem(idx)
end
function PaGlobalFunc_HopeGauge_Console_ChargeScroll(inputNumber)
  if nil == Panel_Widget_HopeGauge then
    return
  end
  local self = PaGlobal_HopeGauge_Console
  if self._selectItemIndex == nil then
    return
  end
  local function charrgeScroll()
    ToClient_ChargeItemCollectionScroll(self._selectItemIndex, self._selectedCount)
  end
  self._selectedCount = Int64toInt32(inputNumber)
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMGETSCROLL_WARNING", "count", tostring(self._selectedCount), "chargeCount", Util.Time.timeFormatting(self._selectedCount * self._selectedPoint))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    content = contentString,
    functionYes = charrgeScroll,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if nil ~= self._selectItemIndex then
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_HopeGaugeConsole_InventoryUpdate()
  if Panel_Widget_HopeGauge == nil then
    return
  end
  if Panel_Widget_HopeGauge:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:updateFeedItem()
end
