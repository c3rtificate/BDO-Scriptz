function PaGlobal_SailControl:initialize()
  if true == PaGlobal_SailControl._initialize then
    return
  end
  self._ui.btn_SailControl = UI.getChildControl(Panel_Widget_SailControl, "Button_SailControl")
  self._ui.stc_BubbleBoxSlot = UI.getChildControl(self._ui.btn_SailControl, "Static_BubbleBoxSlot")
  self._ui.stc_Bubble = UI.getChildControl(self._ui.stc_BubbleBoxSlot, "Static_BubbleBox")
  self._ui.txt_Bubble = UI.getChildControl(self._ui.stc_Bubble, "StaticText_BubbleBox")
  self._ui.txt_Bubble:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAILING_HELP_GUIDE"))
  self._ui.stc_Bubble:SetSize(self._ui.txt_Bubble:GetTextSizeX() + 20, self._ui.txt_Bubble:GetTextSizeY() + 35)
  self._ui.stc_Bubble:ComputePos()
  PaGlobal_SailControl:registEventHandler()
  PaGlobal_SailControl:validate()
  PaGlobal_SailControl:reposition()
  self._initialize = true
end
function PaGlobal_SailControl:registEventHandler()
  if nil == Panel_Widget_SailControl then
    return
  end
  registerEvent("EventSelfPlayerRideOn", "FromClient_SailControl_PlayerRideOn")
  registerEvent("EventSelfPlayerRideOff", "FromClient_SailControl_PlayerRideOff")
  registerEvent("onScreenResize", "FromClient_SailControl_OnScreenResize")
  if ToClient_isConsole() == false then
    self._ui.btn_SailControl:addInputEvent("Mouse_LUp", "HandleEventLUp_SetSailControl()")
    self._ui.btn_SailControl:addInputEvent("Mouse_On", "HandleEventOn_SetSailControlTooltip()")
    self._ui.btn_SailControl:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    if _ContentsGroup_UsePadSnapping == true then
      registerEvent("EventSetSailControlForConsole", "HandleEventLUp_SetSailControl")
    end
  else
    registerEvent("EventSetSailControlForConsole", "HandleEventLUp_SetSailControl")
  end
  self._ui.btn_SailControl:setButtonShortcuts("PANEL_SAILCONTROL_SHORTKEY")
end
function PaGlobal_SailControl:validate()
  if nil == Panel_Widget_SailControl then
    return
  end
  self._ui.btn_SailControl:isValidate()
end
function PaGlobal_SailControl:updateCheckSail()
  if nil == Panel_Widget_SailControl then
    return
  end
  if false == self._isFoldable then
    return
  end
  if true == ToClient_GetRideShipSpread() then
    self._ui.btn_SailControl:ChangeTextureInfoName("combine/etc/combine_etc_riding.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_SailControl, 234, 441, 270, 477)
    self._ui.btn_SailControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.btn_SailControl:ChangeClickTextureInfoName("combine/etc/combine_etc_riding.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_SailControl, 308, 441, 344, 477)
    self._ui.btn_SailControl:getClickTexture():setUV(x1, y1, x2, y2)
  else
    self._ui.btn_SailControl:ChangeTextureInfoName("combine/etc/combine_etc_riding.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_SailControl, 308, 441, 344, 477)
    self._ui.btn_SailControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.btn_SailControl:ChangeClickTextureInfoName("combine/etc/combine_etc_riding.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_SailControl, 234, 441, 270, 477)
    self._ui.btn_SailControl:getClickTexture():setUV(x1, y1, x2, y2)
  end
  self._ui.btn_SailControl:setRenderTexture(self._ui.btn_SailControl:getBaseTexture())
end
function PaGlobal_SailControl:reposition()
  if nil ~= Panel_Widget_ShipSpeedGauge then
    Panel_Widget_SailControl:SetPosX(Panel_Widget_ShipSpeedGauge:GetPosX() - Panel_Widget_SailControl:GetSizeX() * 0.5 + 19)
    Panel_Widget_SailControl:SetPosY(Panel_Widget_ShipSpeedGauge:GetPosY() - Panel_Widget_SailControl:GetSizeY() * 0.5 + 19)
  end
end
function PaGlobal_SailControl:BubbleHelp(isShow)
  if isShow == nil then
    return
  end
  self._ui.stc_BubbleBoxSlot:SetShow(isShow)
end
