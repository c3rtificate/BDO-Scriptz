function PaGlobal_Memo_All:createStickyMemoWrapper(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local memoInfo = ToClient_getMemo(id)
  local content = memoInfo:getContent()
  if "" == content or "Content" == content then
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT")
  end
  PaGlobal_Memo_All._stickyMemoList[id] = PaGlobal_Memo_All:createStickyMemo(id, content)
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if nil == stickyMemo._mainPanel then
    return
  end
  stickyMemo._mainPanel:SetShow(true)
  stickyMemo._ui._Slider:SetControlPos(memoInfo:getAlpha() * 100)
  PaGlobal_Memo_All:ComputeControlShape(id, memoInfo:getPositionX(), memoInfo:getPositionY(), memoInfo:getSizeX(), memoInfo:getSizeY())
  PaGlobal_Memo_All:ComputeControlAlpha(id)
  PaGlobal_Memo_All:StickyApplyColor(id, memoInfo:getColor())
  stickyMemo._ui._MultiLineText:SetEditText(stickyMemo._content)
  stickyMemo._ui._MultiLineText:SetModified(false)
  PaGlobal_Memo_All:StickyClickedContent(stickyMemo._id)
end
function PaGlobal_Memo_All:createStickyMemo(stickyMemoId, content)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local sticky = {
    _ui = {
      _stc_EditTitleImg = nil,
      _btn_Close = nil,
      _Slider = nil,
      _btn_SliderButton = nil,
      _btn_SizeControl = nil,
      _btn_SizeControlInSticker = nil,
      _frm_Sticky = nil,
      _frame_Content = nil,
      _frm_Scroll = nil,
      _frm_ScrollBtn = nil,
      _MultiLineText = nil,
      _btn_Save = nil,
      _btn_AddMemo = nil,
      _checkBox_Popup = nil,
      _btn_ColorChange = nil,
      _colorChange = {
        _frame = nil,
        _frameContent = nil,
        _title = nil,
        _bg = nil,
        _Button = {}
      }
    },
    _id = stickyMemoId,
    _content = content,
    _isOn = true,
    _mainPanel = nil,
    _stickyMemoAlpha = 1,
    _stickyMemoColor = 0,
    _isSubAppMode = false
  }
  function sticky:initialize(stickyMemoId, content)
    sticky:createPanel(stickyMemoId)
    sticky:prepareControl(stickyMemoId)
  end
  function sticky:clear()
    if true == sticky._ui._checkBox_Popup:IsCheck() then
      sticky._mainPanel:CloseUISubApp()
    end
    UI.deletePanel(sticky._mainPanel:GetID())
    sticky._mainPanel = nil
  end
  function sticky:createPanel(stickyMemoId)
    local newName = "Panel_Memo_Sticky_All" .. stickyMemoId
    sticky._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_Dialog)
    sticky._mainPanel:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
      Defines.CloseType.eCloseType_CantClose
    }), "")
    CopyBaseProperty(Panel_Memo_Sticky_All, sticky._mainPanel)
    sticky._mainPanel:SetDragAll(true)
    sticky._mainPanel:SetShow(true)
  end
  function sticky:prepareControl(stickyMemoId)
    local stc_TitleImg = UI.getChildControl(Panel_Memo_Sticky_All, "Static_TitleImage")
    local frm_ColorChange = UI.getChildControl(Panel_Memo_Sticky_All, "Frame_Sticky_ColorChange")
    local framContent = frm_ColorChange:GetFrameContent()
    sticky._ui._stc_EditTitleImg = sticky:createControl(__ePAUIControl_Static, Panel_Memo_Sticky_All, sticky._mainPanel, "Static_TitleImage", 0)
    sticky._ui._btn_Close = sticky:createControl(__ePAUIControl_Button, stc_TitleImg, sticky._ui._stc_EditTitleImg, "Button_Close", 0)
    sticky._ui._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyClose(" .. stickyMemoId .. ")")
    sticky._ui._btn_Close:addInputEvent("Mouse_On", "HandleEventMOn_Memo_Main_All_Tooltip_Show(" .. 0 .. ")")
    sticky._ui._btn_Close:addInputEvent("Mouse_Out", "HandleEventMOut_Memo_Main_All_Tooltip_Hide()")
    sticky._ui._Slider = UI.createControl(__ePAUIControl_Slider, sticky._ui._stc_EditTitleImg, "Slider_Alpha")
    sticky._ui._btn_SliderButton = sticky._ui._Slider:GetControlButton()
    sticky._ui._btn_SliderButton:addInputEvent("Mouse_On", "HandleEventMOn_Memo_Main_All_Tooltip_Show(" .. 1 .. ")")
    sticky._ui._btn_SliderButton:addInputEvent("Mouse_Out", "HandleEventMOut_Memo_Main_All_Tooltip_Hide()")
    local style = UI.getChildControl(stc_TitleImg, "Slider_Alpha")
    CopyBaseProperty(style, sticky._ui._Slider)
    sticky._ui._Slider:SetInterval(100)
    sticky._ui._btn_SliderButton:addInputEvent("Mouse_LPress", "HandleEventLPress_Memo_Main_All_StickyAlpahSlider( " .. stickyMemoId .. ")")
    sticky._ui._Slider:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyAlpahSlider( " .. stickyMemoId .. ")")
    sticky._ui._Slider:SetControlPos(100)
    sticky._ui._btn_SizeControl = sticky:createControl(__ePAUIControl_Button, Panel_Memo_Sticky_All, sticky._ui._stc_EditTitleImg, "Button_SizeControl", 0)
    sticky._ui._btn_SizeControl:addInputEvent("Mouse_LDown", "HandleEventLDown_Memo_Main_All_StickyResizeStartPos( " .. stickyMemoId .. " )")
    sticky._ui._btn_SizeControl:addInputEvent("Mouse_LPress", "HandleEventLPress_Memo_Main_All_StickyResize( " .. stickyMemoId .. " )")
    sticky._ui._btn_SizeControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyEnd( " .. stickyMemoId .. " )")
    sticky._ui._btn_SizeControl:setClickMouseCursorType(__eMouseCursorType_ResizeRight)
    sticky._ui._btn_SizeControl:setOnMouseCursorType(__eMouseCursorType_ResizeRight)
    sticky._ui._btn_SizeControlInSticker = sticky:createControl(__ePAUIControl_Button, Panel_Memo_Sticky_All, sticky._ui._stc_EditTitleImg, "Button_SizeControlInSticky", 0)
    if _ContentsGroup_MemoRenewal == true then
      sticky._ui._btn_SizeControlInSticker:addInputEvent("Mouse_LDown", "HandleEventLDown_Memo_Main_All_StickyResizeStartPos( " .. stickyMemoId .. " )")
      sticky._ui._btn_SizeControlInSticker:addInputEvent("Mouse_LPress", "HandleEventLPress_Memo_Main_All_StickyResize( " .. stickyMemoId .. " )")
      sticky._ui._btn_SizeControlInSticker:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyEnd( " .. stickyMemoId .. " )")
      sticky._ui._btn_SizeControlInSticker:setClickMouseCursorType(__eMouseCursorType_ResizeRight)
      sticky._ui._btn_SizeControlInSticker:setOnMouseCursorType(__eMouseCursorType_ResizeRight)
    end
    sticky._ui._frm_Sticky = sticky:createControl(__ePAUIControl_Frame, Panel_Memo_Sticky_All, sticky._mainPanel, "Frame_Sticky", 0)
    sticky._ui._frm_Sticky:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyClickedContent(" .. stickyMemoId .. ")")
    sticky._ui._frm_Sticky:setClickMouseCursorType(__eMouseCursorType_Text)
    sticky._ui._frm_Sticky:setOnMouseCursorType(__eMouseCursorType_Text)
    sticky._ui._frame_Content = sticky._ui._frm_Sticky:GetFrameContent()
    sticky._ui._frm_Scroll = sticky._ui._frm_Sticky:GetVScroll()
    local styleFrame = UI.getChildControl(Panel_Memo_Sticky_All, "Frame_Sticky")
    local styleScroll = UI.getChildControl(styleFrame, "Frame_1_VerticalScroll")
    CopyBaseProperty(styleScroll, sticky._ui._frm_Scroll)
    sticky._ui._frm_ScrollBtn = sticky._ui._frm_Scroll:GetControlButton()
    local multilinestyle = UI.getChildControl(Panel_Memo_Sticky_All, "MultilineEdit_Content")
    sticky._ui._MultiLineText = UI.createControl(__ePAUIControl_MultiLineEdit, sticky._ui._frame_Content, "MultilineEdit_Content" .. 0)
    CopyBaseProperty(multilinestyle, sticky._ui._MultiLineText)
    sticky._ui._MultiLineText:SetMaxEditLine(PaGlobal_Memo_All._MAX_LINE)
    sticky._ui._MultiLineText:SetMaxInput(PaGlobal_Memo_All._MAX_TEXT)
    sticky._ui._MultiLineText:SetTextVerticalTop(true)
    sticky._ui._MultiLineText:SetFontColor(Defines.Color.C_FFC4BEBE)
    sticky._ui._MultiLineText:SetMemoNo(stickyMemoId)
    sticky._ui._MultiLineText:RegistAllKeyEvent("HandleEventAllkeyEvent_Memo_Main_All_StickyClickedContent(" .. stickyMemoId .. ")")
    sticky._ui._btn_Save = sticky:createControl(__ePAUIControl_Button, Panel_Memo_Sticky_All, sticky._mainPanel, "Button_SaveMemo", 0)
    sticky._ui._btn_Save:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_MemoSave(" .. PaGlobal_Memo_All._SaveMode.ALL .. "," .. stickyMemoId .. ")")
    sticky._ui._btn_AddMemo = sticky:createControl(__ePAUIControl_Button, stc_TitleImg, sticky._ui._stc_EditTitleImg, "Button_AddMemo", 0)
    sticky._ui._btn_AddMemo:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_AddMemo()")
    sticky._ui._btn_AddMemo:addInputEvent("Mouse_On", "HandleEventMOn_Memo_Main_All_Tooltip_Show(" .. 2 .. ")")
    sticky._ui._btn_AddMemo:addInputEvent("Mouse_Out", "HandleEventMOut_Memo_Main_All_Tooltip_Hide()")
    sticky._ui._checkBox_Popup = sticky:createControl(__ePAUIControl_CheckButton, stc_TitleImg, sticky._ui._stc_EditTitleImg, "CheckButton_PopUp", 0)
    sticky._ui._checkBox_Popup:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_Check_PopUI(" .. stickyMemoId .. ")")
    sticky._ui._checkBox_Popup:addInputEvent("Mouse_On", "HandleEventMOn_Memo_Main_All_Tooltip_Show(" .. 3 .. ")")
    sticky._ui._checkBox_Popup:addInputEvent("Mouse_Out", "HandleEventMOut_Memo_Main_All_Tooltip_Hide()")
    sticky._ui._checkBox_Popup:SetShow(_ContentsGroup_PopUp)
    sticky._ui._btn_ColorChange = sticky:createControl(__ePAUIControl_Button, stc_TitleImg, sticky._ui._stc_EditTitleImg, "Button_ColorChange", 0)
    sticky._ui._btn_ColorChange:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyToggleChangeColor( " .. stickyMemoId .. " )")
    sticky._ui._btn_ColorChange:addInputEvent("Mouse_On", "HandleEventMOn_Memo_Main_All_Tooltip_Show(" .. 4 .. ")")
    sticky._ui._btn_ColorChange:addInputEvent("Mouse_Out", "HandleEventMOut_Memo_Main_All_Tooltip_Hide()")
    sticky._ui._colorChange._frame = sticky:createControl(__ePAUIControl_Frame, Panel_Memo_Sticky_All, sticky._mainPanel, "Frame_Sticky_ColorChange", 0)
    sticky._ui._colorChange._frameContent = sticky._ui._colorChange._frame:GetFrameContent()
    for color = 0, 5 do
      local colorStyle = UI.getChildControl(framContent, "Button_Color_" .. tostring(color))
      sticky._ui._colorChange._Button[color] = UI.createControl(__ePAUIControl_Button, sticky._ui._colorChange._frameContent, "Button_Color_" .. color)
      CopyBaseProperty(colorStyle, sticky._ui._colorChange._Button[color])
      sticky._ui._colorChange._Button[color]:addInputEvent("Mouse_LUp", "HandleEventLUp_Memo_Main_All_StickyChangeColorEnd(" .. stickyMemoId .. "," .. color .. ")")
      sticky._ui._colorChange._Button[color]:SetShow(true)
    end
    sticky._ui._colorChange._frame:SetShow(false)
    sticky._mainPanel:addInputEvent("Mouse_UpScroll", "HandleEventScrollUp_Memo_Main_All_OnMouseWheel( " .. stickyMemoId .. ", true )")
    sticky._mainPanel:addInputEvent("Mouse_DownScroll", "HandleEventScrollDown_Memo_Main_All_OnMouseWheel( " .. stickyMemoId .. ", false )")
    sticky._ui._MultiLineText:addInputEvent("Mouse_UpScroll", "HandleEventScrollUp_Memo_Main_All_OnMouseWheel( " .. stickyMemoId .. ", true )")
    sticky._ui._MultiLineText:addInputEvent("Mouse_DownScroll", "HandleEventScrollDown_Memo_Main_All_OnMouseWheel( " .. stickyMemoId .. ", false )")
  end
  function PaGlobal_Memo_All:Tooltip_Show(uiType)
    local uiControl, name, desc
    if 0 == uiType then
      uiControl = sticky._ui._btn_Close
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_CLOSE")
    elseif 1 == uiType then
      uiControl = sticky._ui._btn_SliderButton
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_TRANSPARENCY")
    elseif 2 == uiType then
      uiControl = sticky._ui._btn_AddMemo
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_ADD")
    elseif 3 == uiType then
      uiControl = sticky._ui._checkBox_Popup
      name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
      if sticky._ui._checkBox_Popup:IsCheck() then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
      else
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
      end
    elseif 4 == uiType then
      uiControl = sticky._ui._btn_ColorChange
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_COLORCHANGE")
    end
    TooltipSimple_Show(uiControl, name, desc)
  end
  function PaGlobal_Memo_All:Tooltip_Hide()
    TooltipSimple_Hide()
  end
  function sticky:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  sticky:initialize(stickyMemoId)
  return sticky
end
function PaGlobal_Memo_All:ComputeControlAlpha(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local panel = stickyMemo._mainPanel
  local frame = stickyMemo._ui._frm_Sticky
  local titlebar = stickyMemo._ui._stc_EditTitleImg
  stickyMemo._stickyMemoAlpha = stickyMemo._ui._Slider:GetControlPos()
  local realAlpha = math.max(stickyMemo._stickyMemoAlpha, 0.1)
  panel:SetAlpha(realAlpha)
  frame:SetAlpha(realAlpha)
  stickyMemo._ui._btn_Save:SetAlpha(realAlpha)
  stickyMemo._ui._btn_Save:SetFontAlpha(realAlpha)
end
function PaGlobal_Memo_All:StickyAlphaSlider(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:ComputeControlAlpha(id)
end
function PaGlobal_Memo_All:StickyClose(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleMessageBox(id)
  TooltipSimple_Hide()
end
function PaGlobal_Memo_All:StickyToggleMessageBox(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if isGameTypeKR2() == true then
    local function applyFunc()
      PaGlobal_Memo_All:StickyToggleShow(PaGlobal_Memo_All._SaveMode.ALL, id)
      self._isClose = true
    end
    local function rejectFunc()
      PaGlobal_Memo_All:StickyToggleShow(PaGlobal_Memo_All._SaveMode.SETTING, id)
    end
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_TEXTMODIFIED_SAVE_TITLE")
    local _content = PAGetString(Defines.StringSheet_GAME, "LUA_TEXTMODIFIED_SAVE_CONTENT")
    local messageBoxData = {
      title = _title,
      content = _content,
      functionYes = applyFunc,
      functionNo = rejectFunc,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if stickyMemo ~= nil and stickyMemo._ui._MultiLineText:GetModified() == true then
      MessageBox.showMessageBox(messageBoxData)
    else
      PaGlobal_Memo_All:StickyToggleShow(PaGlobal_Memo_All._SaveMode.SETTING, id)
    end
  elseif stickyMemo ~= nil and stickyMemo._ui._MultiLineText:GetModified() == true then
    PaGlobal_Memo_All:StickyToggleShow(PaGlobal_Memo_All._SaveMode.ALL, id)
  else
    PaGlobal_Memo_All:StickyToggleShow(PaGlobal_Memo_All._SaveMode.SETTING, id)
  end
end
function PaGlobal_Memo_All:StickyToggleShow(saveMode, id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local memoInfo = ToClient_getMemo(id)
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if true == memoInfo:isOn() then
    stickyMemo._isOn = false
    stickyMemo._mainPanel:SetShow(false)
    stickyMemo._mainPanel:CloseUISubApp()
    stickyMemo._ui._checkBox_Popup:SetCheck(false)
  elseif nil == stickyMemo then
    PaGlobal_Memo_All:createStickyMemoWrapper(id)
  else
    stickyMemo._isOn = true
    stickyMemo._mainPanel:SetShow(true)
    local sizeX = stickyMemo._mainPanel:GetSizeX()
    local sizeY = stickyMemo._mainPanel:GetSizeY()
    if sizeX > 600 then
      sizeX = 600
    elseif sizeX < 300 then
      sizeX = 300
    end
    if sizeY > 600 then
      sizeY = 600
    elseif sizeY < 212 then
      sizeY = 212
    end
    PaGlobal_Memo_All:ComputeControlShape(id, stickyMemo._mainPanel:GetPosX(), stickyMemo._mainPanel:GetPosY(), sizeX, sizeY)
    stickyMemo._ui._btn_SizeControlInSticker:SetIgnore(true)
    stickyMemo._ui._btn_SizeControl:SetIgnore(false)
    stickyMemo._ui._MultiLineText:SetCursorPosIndex(0)
  end
  PaGlobal_Memo_All:Save(saveMode, id)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    PaGlobal_Memo_All:StickyClearFocus()
  end
  if true == Panel_Window_Memo_Main_All:IsShow() then
    PaGlobal_Memo_All._ui._List2:requestUpdateByKey(toInt64(0, id))
  end
end
function PaGlobal_Memo_All:StickyResizeStartPos(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local panel = stickyMemo._mainPanel
  PaGlobal_Memo_All._orgMouseX = getMousePosX()
  PaGlobal_Memo_All._orgMouseY = getMousePosY()
  PaGlobal_Memo_All._orgPanelPosX = panel:GetPosX()
  if _ContentsGroup_MemoRenewal == true and stickyMemo._ui._checkBox_Popup:IsCheck() == true then
    local panelSize = ToClient_getSizeSubAppUI(stickyMemo._ui._MultiLineText)
    PaGlobal_Memo_All._orgSubPanelSizeX = panelSize.x
    PaGlobal_Memo_All._orgSubPanelSizeY = panelSize.y
  end
  PaGlobal_Memo_All._orgPanelSizeX = panel:GetSizeX()
  PaGlobal_Memo_All._orgPanelSizeY = panel:GetSizeY()
end
function PaGlobal_Memo_All:StickyResize(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local scaleUI = getGlobalScale()
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local panel = stickyMemo._mainPanel
  local currentPosX = panel:GetPosX()
  local currentPosY = panel:GetPosY()
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  local deltaX = currentX - PaGlobal_Memo_All._orgMouseX
  local deltaY = currentY - PaGlobal_Memo_All._orgMouseY
  local subSizeX, subSizeY
  if _ContentsGroup_MemoRenewal == true and stickyMemo._ui._checkBox_Popup:IsCheck() == true then
    local subDeltaX = deltaX * getGlobalScale()
    local subDeltaY = deltaY * getGlobalScale()
    subSizeX = PaGlobal_Memo_All._orgSubPanelSizeX + subDeltaX
    subSizeY = PaGlobal_Memo_All._orgSubPanelSizeY + subDeltaY
    if subSizeX < 300 * scaleUI then
      subSizeX = 300 * scaleUI
    end
    if subSizeY < 212 * scaleUI then
      subSizeY = 212 * scaleUI
    end
  end
  local sizeX = PaGlobal_Memo_All._orgPanelSizeX + deltaX
  local sizeY = PaGlobal_Memo_All._orgPanelSizeY + deltaY
  if stickyMemo._ui._checkBox_Popup:IsCheck() == false then
    if sizeX > 600 then
      sizeX = 600
    elseif sizeX < 300 then
      sizeX = 300
    end
    if sizeY > 600 then
      sizeY = 600
    elseif sizeY < 212 then
      sizeY = 212
    end
  end
  if _ContentsGroup_MemoRenewal == true and stickyMemo._ui._checkBox_Popup:IsCheck() == true then
    ToClient_setSizeSubAppUI(stickyMemo._ui._MultiLineText, int2(subSizeX, subSizeY))
    PaGlobal_Memo_All:ComputeControlShape(id, 0, 0, sizeX, sizeY)
  else
    PaGlobal_Memo_All:ComputeControlShape(id, currentPosX, currentPosY, sizeX, sizeY)
  end
  stickyMemo._ui._MultiLineText:SetSubAppModified(true)
end
function PaGlobal_Memo_All:StickyResizeEnd(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if _ContentsGroup_MemoRenewal == true and stickyMemo._ui._checkBox_Popup:IsCheck() then
    local uiScale = getGlobalScale()
    local panelSize = ToClient_getSizeSubAppUI(stickyMemo._ui._MultiLineText)
    local panelPos = ToClient_getPosSubAppUI(stickyMemo._ui._MultiLineText)
    stickyMemo._mainPanel:SetPosX(panelPos.x)
    stickyMemo._mainPanel:SetPosY(panelPos.y)
    stickyMemo._mainPanel:SetSize(panelSize.x / uiScale, panelSize.y / uiScale)
    ToClient_refreshSubAppWindowSize(stickyMemo._mainPanel)
    PaGlobal_Memo_All:ComputeControlShape(id, 0, 0, panelSize.x / uiScale, panelSize.y / uiScale, true)
    stickyMemo._ui._btn_SizeControlInSticker:ComputePos()
    stickyMemo._ui._btn_SizeControlInSticker:SetPosY(stickyMemo._ui._btn_SizeControl:GetPosY() - 5)
    stickyMemo._ui._btn_SizeControlInSticker:SetPosX(stickyMemo._ui._btn_SizeControl:GetPosX() - 5)
    stickyMemo._ui._MultiLineText:SetSubAppModified(false)
  end
  local isFocused = PaGlobal_Memo_All._currentFocusId ~= nil
  if true == isFocused then
    SetFocusEdit(stickyMemo._ui._MultiLineText)
  end
end
function PaGlobal_Memo_All:ComputeControlShape(id, posX, posY, sizeX, sizeY, isRefresh)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local memoInfo = ToClient_getMemo(id)
  local panel = stickyMemo._mainPanel
  if (isRefresh == nil or isRefresh == false) and stickyMemo._ui._checkBox_Popup:IsCheck() == true then
    local posY = stickyMemo._ui._stc_EditTitleImg:GetPosY()
    stickyMemo._ui._btn_SizeControlInSticker:ComputePos()
    stickyMemo._ui._btn_SizeControlInSticker:SetPosY(posY + sizeY - stickyMemo._ui._btn_SizeControlInSticker:GetSizeY() - 5)
    stickyMemo._ui._btn_SizeControlInSticker:SetPosX(sizeX - stickyMemo._ui._btn_SizeControlInSticker:GetSizeX() - 5)
    return
  end
  panel:SetSize(sizeX, sizeY)
  panel:SetPosX(posX)
  panel:SetPosY(posY)
  stickyMemo._ui._stc_EditTitleImg:SetSize(sizeX, stickyMemo._ui._stc_EditTitleImg:GetSizeY())
  stickyMemo._ui._btn_Close:SetPosX(panel:GetSizeX() - stickyMemo._ui._btn_Close:GetSizeX() - 5)
  stickyMemo._ui._colorChange._frame:SetPosX(panel:GetSizeX() - stickyMemo._ui._colorChange._frame:GetSizeX() - 10)
  local posY = stickyMemo._ui._stc_EditTitleImg:GetPosY()
  stickyMemo._ui._btn_SizeControl:ComputePos()
  stickyMemo._ui._btn_SizeControl:SetPosY(posY + panel:GetSizeY() - stickyMemo._ui._btn_SizeControl:GetSizeY())
  stickyMemo._ui._btn_SizeControlInSticker:ComputePos()
  stickyMemo._ui._btn_SizeControlInSticker:SetPosY(stickyMemo._ui._btn_SizeControl:GetPosY() - 5)
  stickyMemo._ui._btn_SizeControlInSticker:SetPosX(stickyMemo._ui._btn_SizeControl:GetPosX() - 5)
  stickyMemo._ui._btn_ColorChange:ComputePos()
  stickyMemo._ui._MultiLineText:SetSize(panel:GetSizeX() - 30, 5)
  stickyMemo._ui._MultiLineText:SetMaxEditLine(PaGlobal_Memo_All._MAX_LINE)
  stickyMemo._ui._MultiLineText:SetEditText(stickyMemo._ui._MultiLineText:GetEditText(), false)
  PaGlobal_Memo_All:updateResize(id)
  stickyMemo._ui._btn_Save:ComputePos()
  stickyMemo._ui._Slider:ComputePos()
  stickyMemo._ui._checkBox_Popup:ComputePos()
end
function PaGlobal_Memo_All:StickyClickedContent(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if PaGlobal_Memo_All._currentFocusId ~= nil and PaGlobal_Memo_All._currentFocusId ~= id then
    PaGlobal_Memo_All:Save()
  end
  PaGlobal_Memo_All._currentFocusId = id
  PaGlobal_Memo_All._currentFocusContent = stickyMemo._ui._MultiLineText:GetEditText()
  local default_text = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT")
  if PaGlobal_Memo_All._currentFocusContent == default_text then
    stickyMemo._ui._MultiLineText:SetEditText("")
    stickyMemo._ui._MultiLineText:SetModified(false)
  end
  SetFocusEdit(stickyMemo._ui._MultiLineText)
  PaGlobal_Memo_All:updateResize(id)
end
function PaGlobal_Memo_All:updateResize(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = self._stickyMemoList[id]
  stickyMemo._ui._frm_Sticky:SetSize(stickyMemo._mainPanel:GetSizeX(), stickyMemo._mainPanel:GetSizeY() - 110)
  stickyMemo._ui._frame_Content:SetSize(stickyMemo._mainPanel:GetSizeX() - 15, stickyMemo._ui._MultiLineText:GetTextSizeY())
  stickyMemo._ui._frm_Sticky:UpdateContentScroll()
  local scrollSize = stickyMemo._ui._frm_Sticky:GetSizeY() * (stickyMemo._ui._frm_Sticky:GetSizeY() / stickyMemo._ui._frame_Content:GetSizeY())
  stickyMemo._ui._frm_ScrollBtn:SetSize(stickyMemo._ui._frm_ScrollBtn:GetSizeX(), scrollSize)
  stickyMemo._ui._frm_Sticky:UpdateContentPos()
end
function PaGlobal_Memo_All:StickyTextUpdate(id)
  local stickyMemo = self._stickyMemoList[id]
  if nil == stickyMemo then
    return
  end
  local memo = ToClient_getMemo(id)
  if nil == memo then
    return
  end
  local content = memo:getContent()
  stickyMemo._ui._MultiLineText:SetEditText(content)
end
function PaGlobal_Memo_All:ComputeFrameContentSizeY(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local memoInfo = ToClient_getMemo(id)
  stickyMemo._ui._frame_Content:SetSize(stickyMemo._ui._frame_Content:GetSizeX(), memoInfo:getFrameContentY())
end
function PaGlobal_Memo_All:Check_PopUI(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if true == stickyMemo._ui._checkBox_Popup:IsCheck() then
    stickyMemo._isSubAppMode = true
    stickyMemo._mainPanel:OpenUISubApp()
    stickyMemo._ui._btn_SizeControlInSticker:SetIgnore(false)
    stickyMemo._ui._btn_SizeControl:SetIgnore(true)
  else
    stickyMemo._isSubAppMode = false
    stickyMemo._mainPanel:CloseUISubApp()
    stickyMemo._ui._btn_SizeControlInSticker:SetIgnore(true)
    stickyMemo._ui._btn_SizeControl:SetIgnore(false)
    local sizeX = stickyMemo._mainPanel:GetSizeX()
    local sizeY = stickyMemo._mainPanel:GetSizeY()
    if sizeX > 600 then
      sizeX = 600
    elseif sizeX < 300 then
      sizeX = 300
    end
    if sizeY > 600 then
      sizeY = 600
    elseif sizeY < 212 then
      sizeY = 212
    end
    PaGlobal_Memo_All:ComputeControlShape(id, stickyMemo._mainPanel:GetPosX(), stickyMemo._mainPanel:GetPosY(), sizeX, sizeY)
  end
end
function PaGlobal_Memo_All:StickyToggleChangeColor(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  local isShow = stickyMemo._ui._colorChange._frame:GetShow()
  if true == isShow then
    isShow = false
  else
    isShow = true
  end
  stickyMemo._ui._colorChange._frame:SetShow(isShow)
end
function PaGlobal_Memo_All:StickyChangeColorEnd(id, color)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyApplyColor(id, color)
  PaGlobal_Memo_All._stickyMemoList[id]._ui._colorChange._frame:SetShow(false)
  PaGlobal_Memo_All:Save(PaGlobal_Memo_All._SaveMode.SETTING, id)
end
function PaGlobal_Memo_All:StickyApplyColor(id, color)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All._stickyMemoList[id]._stickyMemoColor = color
  local control = PaGlobal_Memo_All._stickyMemoList[id]._ui._stc_EditTitleImg
  if 0 == color then
    control:SetColor(Defines.Color.C_FF59473B)
  elseif 1 == color then
    control:SetColor(Defines.Color.C_FF4D4256)
  elseif 2 == color then
    control:SetColor(Defines.Color.C_FF5A393B)
  elseif 3 == color then
    control:SetColor(Defines.Color.C_FF3E4558)
  elseif 4 == color then
    control:SetColor(Defines.Color.C_FF43503E)
  elseif 5 == color then
    control:SetColor(Defines.Color.C_FF3F3F46)
  end
end
function PaGlobal_Memo_All:OnMouseWheel(stickyMemoId, isUp)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[stickyMemoId]
  local targetScroll = stickyMemo._ui._frm_Scroll
  if nil == targetScroll then
    return
  end
  if isUp then
    targetScroll:ControlButtonUp()
  else
    targetScroll:ControlButtonDown()
  end
  stickyMemo._ui._frm_Sticky:UpdateContentPos()
end
function PaGlobal_Memo_All:StickySetDefaultPos(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local lsitPosX = Panel_Window_Memo_Main_All:GetPosX()
  local lsitPosY = Panel_Window_Memo_Main_All:GetPosY()
  local lsitSizeX = Panel_Window_Memo_Main_All:GetSizeX()
  local panel = PaGlobal_Memo_All._stickyMemoList[id]._mainPanel
  if nil == panel then
    return
  end
  local centerX = getScreenSizeX() * 0.5
  if lsitPosX > centerX then
    panel:SetPosX(lsitPosX - panel:GetSizeX() - 10)
  else
    panel:SetPosX(lsitPosX + lsitSizeX + 10)
  end
  panel:SetPosY(lsitPosY + 15)
  PaGlobal_Memo_All:Save(PaGlobal_Memo_All._SaveMode.SETTING, id)
end
function PaGlobal_Memo_All:CheckProhibitedWord(saveMode, inputId)
  if inputId ~= nil then
    self._currentFocusId = inputId
  end
  self._currentSaveMode = saveMode
  local stickyMemo = self._stickyMemoList[self._currentFocusId]
  if stickyMemo == nil then
    return
  end
  local conetnt = stickyMemo._ui._MultiLineText:GetEditText()
  if conetnt == nil and self._currentFocusContent == nil then
    return
  end
  if content == nil then
    content = self._currentFocusContent
  end
  ToClient_CheckChinaProhibitedWord(conetnt, __eSceneIdMemo)
end
function PaGlobal_Memo_All:StickyMouseLUPContent(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if PaGlobal_Memo_All._currentFocusId ~= nil and PaGlobal_Memo_All._currentFocusId ~= id then
    PaGlobal_Memo_All:Save()
  end
  PaGlobal_Memo_All._currentFocusId = id
  PaGlobal_Memo_All._currentFocusContent = stickyMemo._ui._MultiLineText:GetEditText()
  local default_text = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT")
  if PaGlobal_Memo_All._currentFocusContent == default_text then
    stickyMemo._ui._MultiLineText:SetEditText("")
    stickyMemo._ui._MultiLineText:SetModified(false)
  end
  SetFocusEdit(stickyMemo._ui._MultiLineText)
  PaGlobal_Memo_All:updateResize(id)
end
