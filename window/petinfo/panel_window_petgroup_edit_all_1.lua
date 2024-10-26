function PaGlobal_PetGroupEdit:initialize()
  if self._initialize == true then
    return
  end
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  self._ui.btn_Close = UI.getChildControl(Panel_Window_GroupEdit_All, "Button_Close")
  self._ui.rdo_Button1 = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_1")
  self._ui.rdo_Button2 = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_2")
  self._ui.rdo_Button3 = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_3")
  self._ui.rdo_Button4 = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_4")
  self._ui.rdo_Button5 = UI.getChildControl(Panel_Window_GroupEdit_All, "RadioButton_5")
  self._ui.txt_GroupName = UI.getChildControl(Panel_Window_GroupEdit_All, "StaticText_RegistItemName")
  self._ui.edit_Name = UI.getChildControl(Panel_Window_GroupEdit_All, "Edit_Naming")
  self._ui.edit_Name:SetMaxInput(getGameServiceTypeCharacterNameLength())
  local bottomButton = UI.getChildControl(Panel_Window_GroupEdit_All, "Static_BottomButton")
  self._ui.btn_Confirm = UI.getChildControl(bottomButton, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(bottomButton, "Button_Cancel")
  self._ui.stc_BottomBG = UI.getChildControl(Panel_Window_GroupEdit_All, "Static_Bottombg")
  self._ui.txt_ChangeName = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_ChangeName")
  self._ui.txt_Confirm = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Confirm_ConsoleUI")
  self._ui.txt_Cancel = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_Cancel_ConsoleUI")
  self._ui.txt_SelectGroup = UI.getChildControl(self._ui.stc_BottomBG, "StaticText_GroupSelect_ConsoleUI")
  self._isConsole = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_PetGroupEdit:registEventHandler()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  registerEvent("FromClient_SavePetGroupName", "FromClient_SavePetGroupName")
  if self._isConsole == true then
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(true)")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(false)")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_PetGroupEdit:setFocusEditText(false)")
    self._ui.edit_Name:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
    Panel_Window_GroupEdit_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_PetGroupEdit:saveGroupName()")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_Close()")
    self._ui.rdo_Button1:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(0)")
    self._ui.rdo_Button2:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(1)")
    self._ui.rdo_Button3:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(2)")
    self._ui.rdo_Button4:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(3)")
    self._ui.rdo_Button5:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_ClickGroup(4)")
    self._ui.edit_Name:addInputEvent("Mouse_LUp", "PaGlobal_PetGroupEdit:setFocusEditText(false)")
    self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_PetGroupEdit:saveGroupName()")
    self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_PetGroupEdit_Close()")
  end
  registerEvent("FromClient_CheckChinaProhibitedWord_SavePetGroupName", "FromClient_CheckChinaProhibitedWord_SavePetGroupName")
end
function PaGlobal_PetGroupEdit:prepareOpen()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  self._ui.rdo_Button1:SetCheck(false)
  self._ui.rdo_Button2:SetCheck(false)
  self._ui.rdo_Button3:SetCheck(false)
  self._ui.rdo_Button4:SetCheck(false)
  self._ui.rdo_Button5:SetCheck(false)
  self:clickGroup(0)
  if self._isConsole == true then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Confirm:SetShow(false)
    self._ui.btn_Cancel:SetShow(false)
    self._ui.stc_BottomBG:SetShow(true)
    local keyGuideTable = {
      self._ui.txt_ChangeName,
      self._ui.txt_Confirm,
      self._ui.txt_Cancel,
      self._ui.txt_SelectGroup
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_BottomBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  Panel_Window_GroupEdit_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self:open()
end
function PaGlobal_PetGroupEdit:open()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  Panel_Window_GroupEdit_All:SetShow(true)
end
function PaGlobal_PetGroupEdit:prepareClose()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  Panel_Window_GroupEdit_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self:close()
end
function PaGlobal_PetGroupEdit:close()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  Panel_Window_GroupEdit_All:SetShow(false)
end
function PaGlobal_PetGroupEdit:clickGroup(index)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if index == 0 then
    self._ui.rdo_Button1:SetCheck(true)
    self._ui.rdo_Button2:SetCheck(false)
    self._ui.rdo_Button3:SetCheck(false)
    self._ui.rdo_Button4:SetCheck(false)
    self._ui.rdo_Button5:SetCheck(false)
  elseif index == 1 then
    self._ui.rdo_Button1:SetCheck(false)
    self._ui.rdo_Button2:SetCheck(true)
    self._ui.rdo_Button3:SetCheck(false)
    self._ui.rdo_Button4:SetCheck(false)
    self._ui.rdo_Button5:SetCheck(false)
  elseif index == 2 then
    self._ui.rdo_Button1:SetCheck(false)
    self._ui.rdo_Button2:SetCheck(false)
    self._ui.rdo_Button3:SetCheck(true)
    self._ui.rdo_Button4:SetCheck(false)
    self._ui.rdo_Button5:SetCheck(false)
  elseif index == 3 then
    self._ui.rdo_Button1:SetCheck(false)
    self._ui.rdo_Button2:SetCheck(false)
    self._ui.rdo_Button3:SetCheck(false)
    self._ui.rdo_Button4:SetCheck(true)
    self._ui.rdo_Button5:SetCheck(false)
  elseif index == 4 then
    self._ui.rdo_Button1:SetCheck(false)
    self._ui.rdo_Button2:SetCheck(false)
    self._ui.rdo_Button3:SetCheck(false)
    self._ui.rdo_Button4:SetCheck(false)
    self._ui.rdo_Button5:SetCheck(true)
  end
  self._indexForConsole = index
  local groupName = ToClient_GetPetGroupName(index)
  if groupName == nil then
    if index == 0 then
      groupName = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP1_NAME")
    elseif index == 1 then
      groupName = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP2_NAME")
    elseif index == 2 then
      groupName = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP3_NAME")
    elseif index == 3 then
      groupName = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP4_NAME")
    elseif index == 4 then
      groupName = PAGetString(Defines.StringSheet_GAME, "LUA_PETLIST_TOOLTIP_BTN_GROUP5_NAME")
    end
  end
  self._ui.txt_GroupName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETGROUPNAME_EDIT", "name", groupName))
  self:setFocusEditText(true)
end
function PaGlobal_PetGroupEdit:setFocusEditText(isRefresh)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if isRefresh == true then
    self._ui.edit_Name:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE"))
    ClearFocusEdit()
  else
    self._ui.edit_Name:SetEditText("")
    SetFocusEdit(self._ui.edit_Name)
  end
end
function PaGlobal_PetGroupEdit:saveGroupName()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  if self._ui.edit_Name:GetText() == PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETGROUPNAMEEDIT_VALUE") then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    ToClient_CheckChinaProhibitedWord(self._ui.edit_Name:GetText(), __eSceneIdSavePetGroupName)
    return
  end
  local index = -1
  if self._ui.rdo_Button1:IsCheck() == true then
    index = 0
  elseif self._ui.rdo_Button2:IsCheck() == true then
    index = 1
  elseif self._ui.rdo_Button3:IsCheck() == true then
    index = 2
  elseif self._ui.rdo_Button4:IsCheck() == true then
    index = 3
  elseif self._ui.rdo_Button5:IsCheck() == true then
    index = 4
  end
  ToClient_SavePetGroupName(index, self._ui.edit_Name:GetText())
end
function PaGlobal_PetGroupEdit:validate()
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  self._ui.btn_Close:isValidate()
  self._ui.rdo_Button1:isValidate()
  self._ui.rdo_Button2:isValidate()
  self._ui.rdo_Button3:isValidate()
  self._ui.rdo_Button4:isValidate()
  self._ui.rdo_Button5:isValidate()
  self._ui.txt_GroupName:isValidate()
  self._ui.edit_Name:isValidate()
  self._ui.btn_Confirm:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.stc_BottomBG:isValidate()
  self._ui.txt_ChangeName:isValidate()
  self._ui.txt_Confirm:isValidate()
  self._ui.txt_Cancel:isValidate()
  self._ui.txt_SelectGroup:isValidate()
end
function FromClient_SavePetGroupName(groupName)
  if Panel_Window_GroupEdit_All == nil then
    return
  end
  PaGlobal_PetGroupEdit._ui.txt_GroupName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETGROUPNAME_EDIT", "name", groupName))
end
function FromClient_CheckChinaProhibitedWord_SavePetGroupName(filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_PetGroupEdit
  if self == nil then
    return
  end
  local index = -1
  if self._ui.rdo_Button1:IsCheck() == true then
    index = 0
  elseif self._ui.rdo_Button2:IsCheck() == true then
    index = 1
  elseif self._ui.rdo_Button3:IsCheck() == true then
    index = 2
  elseif self._ui.rdo_Button4:IsCheck() == true then
    index = 3
  elseif self._ui.rdo_Button5:IsCheck() == true then
    index = 4
  end
  ToClient_SavePetGroupName(index, filteredText)
end
