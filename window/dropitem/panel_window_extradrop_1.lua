function PaGlobal_ExtraDrop:initialize()
  if PaGlobal_ExtraDrop._initialize == true then
    return
  end
  self._ui.stc_TitleArea = UI.getChildControl(Panel_Window_ExtraDrop, "Static_TitleArea")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TitleArea, "StaticText_Title")
  self._ui.list2_ExtraDropList = UI.getChildControl(Panel_Window_ExtraDrop, "List2_ExtraDropList")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleArea, "Button_Close")
  local tmpUI = UI.getChildControl(Panel_Window_ExtraDrop, "Static_DescBG")
  self._ui.txt_Desc = UI.getChildControl(tmpUI, "StaticText_Desc")
  self._ui.stc_consoleBtnGroup = UI.getChildControl(Panel_Window_ExtraDrop, "Static_BottomGroup_ConsoleUI")
  self._ui.stc_console_A = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_A_ConsoleUI")
  self._ui.stc_console_B = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_B_ConsoleUI")
  self._ui.stc_console_Y = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  for index = 0, __eExtraDropType_Count - 1 do
    local string = ToClient_ExtraDropString(index)
    self._extraDropData[index].string = string
  end
  PaGlobal_ExtraDrop:registEventHandler()
  PaGlobal_ExtraDrop:validate()
  PaGlobal_ExtraDrop._initialize = true
end
function PaGlobal_ExtraDrop:registEventHandler()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  self._ui.list2_ExtraDropList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ExtraDrop_addExtraDropListContent")
  self._ui.list2_ExtraDropList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_ExtraDrop_Close()")
  registerEvent("FromClient_ExtraDropUpdateSwitch", "PaGlobal_ExtraDrop_ExtraDropUpdateSwitch")
  registerEvent("FromClient_ExtraDropUpdatePoint", "PaGlobal_ExtraDrop_ExtraDropUpdatePoint")
end
function PaGlobal_ExtraDrop:validate()
  self._ui.stc_TitleArea:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.list2_ExtraDropList:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.stc_consoleBtnGroup:isValidate()
  self._ui.stc_console_A:isValidate()
  self._ui.stc_console_B:isValidate()
  self._ui.stc_console_Y:isValidate()
end
function PaGlobal_ExtraDrop:prepareOpen()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_ExtraDrop:open()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  Panel_Window_ExtraDrop:SetShow(true)
end
function PaGlobal_ExtraDrop:prepareClose()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  self:close()
end
function PaGlobal_ExtraDrop:close()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  Panel_Window_ExtraDrop:SetShow(false)
end
function PaGlobal_ExtraDrop:update()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  self:updateExtraDropData()
  self:updateExtraDropContentsLit()
end
function PaGlobal_ExtraDrop:updateExtraDropData()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  for index = 0, __eExtraDropType_Count - 1 do
    self._extraDropData[index].currentPoint = ToClient_ExtraDrop_GetCurrentPoint(index)
    self._extraDropData[index].switch = ToClient_ExtraDrop_GetCurrentSwitch(index)
  end
end
function PaGlobal_ExtraDrop:updateExtraDropContentsLit()
  if Panel_Window_ExtraDrop == nil then
    return
  end
  self._ui.list2_ExtraDropList:getElementManager():clearKey()
  local keyCount = math.floor((__eExtraDropType_Count - 1) / 2)
  for key = 0, keyCount do
    self._ui.list2_ExtraDropList:getElementManager():pushKey(key)
  end
end
function PaGlobal_ExtraDrop_addExtraDropListContent(control, InputKey)
  if nil == Panel_Window_ExtraDrop then
    return
  end
  if nil == control or nil == InputKey then
    return
  end
  local self = PaGlobal_ExtraDrop
  if self == nil then
    return
  end
  local key = Int64toInt32(InputKey)
  local button_0 = UI.getChildControl(control, "Static_Bg_1")
  local button_1 = UI.getChildControl(control, "Static_Bg_2")
  local listControl = {
    [0] = {
      button = button_0,
      checkBox = UI.getChildControl(button_0, "CheckButton_Use"),
      txt_Name = UI.getChildControl(button_0, "StaticText_HuntingName"),
      txt_Point = UI.getChildControl(button_0, "StaticText_CurrentPoint")
    },
    [1] = {
      button = button_1,
      checkBox = UI.getChildControl(button_1, "CheckButton_Use"),
      txt_Name = UI.getChildControl(button_1, "StaticText_HuntingName"),
      txt_Point = UI.getChildControl(button_1, "StaticText_CurrentPoint")
    }
  }
  local firstType = key * 2
  local secondType = key * 2 + 1
  if firstType < __eExtraDropType_Count then
    listControl[0].button:SetShow(true)
    listControl[0].checkBox:SetIgnore(true)
    listControl[0].checkBox:SetCheck(self._extraDropData[firstType].switch)
    listControl[0].txt_Name:SetText(self._extraDropData[firstType].string)
    listControl[0].txt_Point:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTRADROP_CURRENTPOINT", "point", self._extraDropData[firstType].currentPoint))
    if self._extraDropData[firstType].switch == true then
      listControl[0].button:addInputEvent("Mouse_LUp", "ToClient_ExtraDrop_SetCurrentSwitch(" .. firstType .. ", false)")
    else
      listControl[0].button:addInputEvent("Mouse_LUp", "ToClient_ExtraDrop_SetCurrentSwitch(" .. firstType .. ", true)")
    end
  else
    listControl[0].button:SetShow(false)
  end
  if secondType < __eExtraDropType_Count then
    listControl[1].button:SetShow(true)
    listControl[1].checkBox:SetIgnore(true)
    listControl[1].checkBox:SetCheck(self._extraDropData[secondType].switch)
    listControl[1].txt_Name:SetText(self._extraDropData[secondType].string)
    listControl[1].txt_Point:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTRADROP_CURRENTPOINT", "point", self._extraDropData[secondType].currentPoint))
    if self._extraDropData[secondType].switch == true then
      listControl[1].button:addInputEvent("Mouse_LUp", "ToClient_ExtraDrop_SetCurrentSwitch(" .. secondType .. ", false)")
    else
      listControl[1].button:addInputEvent("Mouse_LUp", "ToClient_ExtraDrop_SetCurrentSwitch(" .. secondType .. ", true)")
    end
  else
    listControl[1].button:SetShow(false)
  end
end
