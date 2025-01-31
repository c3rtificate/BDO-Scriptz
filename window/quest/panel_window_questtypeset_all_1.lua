function PaGlobal_QuestTypeSet_All:initialize()
  if true == PaGlobal_QuestTypeSet_All._initialize then
    return
  end
  PaGlobal_QuestTypeSet_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_QuestTypeSet_All:ControlAll_Init()
  PaGlobal_QuestTypeSet_All:registEventHandler()
  PaGlobal_QuestTypeSet_All:validate()
  PaGlobal_QuestTypeSet_All._initialize = true
end
function PaGlobal_QuestTypeSet_All:ControlAll_Init()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self._ui.stc_desc = UI.getChildControl(Panel_Window_QuestTypeSet_All, "StaticText_Desc")
  self._ui.stc_centerBg = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_CenterBg")
  self._ui.stc_deco = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_Deco")
  self._ui.stc_selectedTypeDesc = UI.getChildControl(Panel_Window_QuestTypeSet_All, "StaticText_SelectedTypeDesc")
  self._ui.stc_selectedTypeNameBg = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_SelectedTypeName")
  self._ui.txt_selectedTypeName = UI.getChildControl(self._ui.stc_selectedTypeNameBg, "StaticText_SelectedTypeTitle")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_Window_QuestTypeSet_All, "Static_BottomBG_ConsoleUI")
  self._ui_console.stc_confirm = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Confirm_ConsoleUI")
  self._ui_console.stc_cancle = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Close_ConsoleUI")
  local selectTypeGroupList = {
    [__eQuestSelectType_Count] = "Static_Deco_All",
    [__eQuestSelectType_Main] = nil,
    [__eQuestSelectType_BlackSpirit] = "Static_BlackSpirit",
    [__eQuestSelectType_Sub] = "Static_Sub",
    [__eQuestSelectType_Adventure] = "Static_Adventure",
    [__eQuestSelectType_Life] = "Static_Life",
    [__eQuestSelectType_Contents] = "Static_Contents",
    [__eQuestSelectType_Event] = "Static_Event",
    [__eQuestSelectType_Etc] = "Static_ETC"
  }
  for ii = 0, __eQuestSelectType_Count do
    if selectTypeGroupList[ii] ~= nil then
      self._questTypeGroup[ii] = {}
      self._questTypeGroup[ii].bg = UI.getChildControl(self._ui.stc_deco, selectTypeGroupList[ii])
      self._questTypeGroup[ii].slot = UI.getChildControl(self._questTypeGroup[ii].bg, "Static_SelectSlot")
      self._questTypeGroup[ii].icon = UI.getChildControl(self._questTypeGroup[ii].bg, "CheckButton_Icon")
      self._questTypeGroup[ii].check = UI.getChildControl(self._questTypeGroup[ii].bg, "CheckButton_1")
      self._questTypeGroup[ii].slot:addInputEvent("Mouse_LUp", "HandleEventLUp_QuestTypeSet_All_CheckButton(" .. ii .. ")")
      self._questTypeGroup[ii].slot:addInputEvent("Mouse_On", "HandlePadEventOn_QuestTypeSet_All_ShowDescription(" .. ii .. ")")
    else
      self._questTypeGroup[ii] = nil
    end
  end
  self._ui.stc_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_desc:SetText(self._ui.stc_desc:GetText())
  self._ui.txt_selectedTypeName:SetText(__eTextMode_AutoWrap)
  self._ui.stc_selectedTypeDesc:SetTextMode(__eTextMode_AutoWrap)
  if true == self._isConsole then
    PaGlobal_QuestTypeSet_All:setAlignKeyGuide()
  end
end
function PaGlobal_QuestTypeSet_All:prepareOpen()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  PaGlobalFunc_Quest_All_Close(false)
  PaGlobal_QuestTypeSet_All:update()
  PaGlobal_QuestTypeSet_All:open()
  PaGlobal_QuestTypeSet_All:resize()
end
function PaGlobal_QuestTypeSet_All:open()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  Panel_Window_QuestTypeSet_All:SetShow(true)
end
function PaGlobal_QuestTypeSet_All:prepareClose()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  PaGlobal_QuestTypeSet_All:close()
end
function PaGlobal_QuestTypeSet_All:close()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  Panel_Window_QuestTypeSet_All:SetShow(false)
end
function PaGlobal_QuestTypeSet_All:update()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self:favorTypeUpdate()
end
function PaGlobal_QuestTypeSet_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui_console.stc_confirm,
    self._ui_console.stc_cancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_QuestTypeSet_All:registEventHandler()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  registerEvent("EventSelfPlayerLevelUp", "FromClient_Quest_All_LevelFifty_SetFavorType")
end
function PaGlobal_QuestTypeSet_All:validate()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
  self._ui.stc_desc:isValidate()
  self._ui.stc_centerBg:isValidate()
  self._ui.stc_deco:isValidate()
  self._ui.stc_selectedTypeDesc:isValidate()
  self._ui.stc_selectedTypeNameBg:isValidate()
  self._ui.txt_selectedTypeName:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_confirm:isValidate()
  self._ui_console.stc_cancle:isValidate()
end
function PaGlobal_QuestTypeSet_All:resize()
  if nil == Panel_Window_QuestTypeSet_All then
    return
  end
end
function PaGlobal_QuestTypeSet_All:favorTypeUpdate()
  local allButtonCheck = true
  local QuestListInfo = ToClient_GetQuestList()
  for ii = 0, __eQuestSelectType_Count - 1 do
    if self._questTypeGroup[ii] ~= nil then
      local bChecked = QuestListInfo:isQuestSelectType(ii)
      self._questTypeGroup[ii].icon:SetCheck(bChecked)
      self._questTypeGroup[ii].check:SetCheck(bChecked)
      if false == bChecked then
        self._questTypeGroup[__eQuestSelectType_Count].icon:SetCheck(false)
        self._questTypeGroup[__eQuestSelectType_Count].check:SetCheck(false)
        allButtonCheck = false
      end
      if true == allButtonCheck then
        self._questTypeGroup[ii].icon:SetCheck(true)
        self._questTypeGroup[ii].check:SetCheck(true)
        self._questTypeGroup[__eQuestSelectType_Count].icon:SetCheck(true)
        self._questTypeGroup[__eQuestSelectType_Count].check:SetCheck(true)
      elseif true == bChecked then
        self._questTypeGroup[__eQuestSelectType_Count].icon:SetCheck(true)
        self._questTypeGroup[__eQuestSelectType_Count].check:SetCheck(true)
      else
        self._questTypeGroup[__eQuestSelectType_Count].icon:SetCheck(false)
        self._questTypeGroup[__eQuestSelectType_Count].check:SetCheck(false)
      end
    end
  end
  self._questTypeGroup[__eQuestSelectType_Count].icon:SetCheck(allButtonCheck)
  self._questTypeGroup[__eQuestSelectType_Count].check:SetCheck(allButtonCheck)
end
function PaGlobal_QuestTypeSet_All:checkButtonAll()
  local isCheck = not self._questTypeGroup[__eQuestSelectType_Count].check:IsCheck()
  for ii = 0, __eQuestSelectType_Count - 1 do
    if self._questTypeGroup[ii] ~= nil and isCheck ~= self._questTypeGroup[ii].check:IsCheck() then
      ToClient_ToggleQuestSelectType(ii)
      self._questTypeGroup[ii].icon:SetCheck(isCheck)
      self._questTypeGroup[ii].check:SetCheck(isCheck)
    end
  end
end
