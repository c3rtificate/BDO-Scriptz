local battleFocusModeMinimapSpanX = getScreenSizeX() / 2 - 500
local battleFocusModeMinimapSpanY = getScreenSizeY() / 2
local originRadarSpanX = Panel_Radar:GetSpanSize().x
local originRadarSpanY = Panel_Radar:GetSpanSize().y
function PaGlobal_UIModify:initialize()
  if true == PaGlobal_UIModify._initialize then
    return
  end
  self._ui.panelBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_PanelBG")
  self._ui.titleBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_TitleArea")
  self._ui.chk_Collapse = UI.getChildControl(self._ui.titleBG, "CheckButton_Collapse")
  self._ui.btn_win_close = UI.getChildControl(self._ui.titleBG, "Button_Win_Close")
  self._ui.balckBG = UI.getChildControl(Panel_Window_UIModify_All, "Static_BlackBG")
  self._ui.grid_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_Grid")
  self._ui.main_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_MainBG")
  self._ui.btn_UIFreeSet1 = UI.getChildControl(self._ui.main_BG, "Button_Preset1")
  self._ui.btn_UIFreeSet2 = UI.getChildControl(self._ui.main_BG, "Button_Preset2")
  self._ui.btn_UIFreeSet3 = UI.getChildControl(self._ui.main_BG, "Button_Preset3")
  self._ui.btn_CleanMode = UI.getChildControl(self._ui.main_BG, "Button_CleanMode")
  self._ui.btn_RevertMod = UI.getChildControl(self._ui.main_BG, "Button_ReturnClean")
  self._ui.sub_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_SubBG")
  self._ui.txt_UISize = UI.getChildControl(self._ui.sub_BG, "StaticText_SubTitle")
  self._ui.txt_UI_LOW = UI.getChildControl(self._ui.sub_BG, "StaticText_UI_LOW")
  self._ui.txt_UI_HIGH = UI.getChildControl(self._ui.sub_BG, "StaticText_UI_HIGH")
  self._ui.slider_UI_Scale = UI.getChildControl(self._ui.sub_BG, "Slider_UI_Scaling")
  self._ui.btn_Scale = UI.getChildControl(self._ui.slider_UI_Scale, "Slider_UI_Scaling_Button")
  self._ui.chk_remsaterUI = UI.getChildControl(self._ui.sub_BG, "CheckButton_HP")
  self._ui.chk_FieldView = UI.getChildControl(self._ui.sub_BG, "CheckButton_CameraPosition")
  self._ui.chk_QuickSlotMagnetic = UI.getChildControl(self._ui.sub_BG, "CheckButton_QuickSlotMagnet")
  self._ui.chk_GridView = UI.getChildControl(self._ui.sub_BG, "CheckButton_Grid")
  self._ui.desc_BG = UI.getChildControl(Panel_Window_UIModify_All, "Static_BottomDescBG")
  self._ui.txt_Desc = UI.getChildControl(self._ui.desc_BG, "StaticText_1")
  self._ui.btn_save = UI.getChildControl(Panel_Window_UIModify_All, "Button_Save")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_UIModify_All, "Button_Reset")
  self._ui.chk_FieldView:SetEnableArea(0, 0, self._ui.chk_FieldView:GetTextSizeX() + 25, self._ui.chk_FieldView:GetSizeY())
  self._ui.chk_QuickSlotMagnetic:SetEnableArea(0, 0, self._ui.chk_QuickSlotMagnetic:GetTextSizeX() + 25, self._ui.chk_QuickSlotMagnetic:GetSizeY())
  self._ui.chk_GridView:SetEnableArea(0, 0, self._ui.chk_GridView:GetTextSizeX() + 25, self._ui.chk_GridView:GetSizeY())
  self._ui.chk_remsaterUI:SetEnableArea(0, 0, self._ui.chk_remsaterUI:GetTextSizeX() + 25, self._ui.chk_remsaterUI:GetSizeY())
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    self._ui.tabGroup = UI.getChildControl(Panel_Window_UIModify_All, "Static_TapGroup")
    self._ui.rdo_normal = UI.getChildControl(self._ui.tabGroup, "RadioButton_Normal")
    self._ui.rdo_battle = UI.getChildControl(self._ui.tabGroup, "RadioButton_Clean")
    self._ui.stc_selectLine = UI.getChildControl(self._ui.tabGroup, "Static_UnderBar_Select")
    self._ui.chk_useBattleMode = UI.getChildControl(Panel_Window_UIModify_All, "CheckButton_UseCleanMode")
    local isUseMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode)
    self._ui.chk_useBattleMode:SetCheck(isUseMode)
    self._panelOriPosY = Panel_Window_UIModify_All:GetPosY() - 80
    self._subControlPosY.chk_remsaterUI = self._ui.chk_remsaterUI:GetPosY()
    self._subControlPosY.chk_FieldView = self._ui.chk_FieldView:GetPosY()
    self._subControlPosY.chk_QuickSlotMagnetic = self._ui.chk_QuickSlotMagnetic:GetPosY()
    self._subControlPosY.chk_GridView = self._ui.chk_GridView:GetPosY()
    self._isLoadPreset = false
  else
    self:updateModifyPanelSize()
  end
  self._uiSave.txt_Desc = UI.getChildControl(Panel_Window_SavePreset_All, "StaticText_Desc")
  self._uiSave.btn_SaveClose = UI.getChildControl(Panel_Window_SavePreset_All, "Button_Win_Close")
  self._uiSave.btn_SaveDefault = UI.getChildControl(Panel_Window_SavePreset_All, "Button_DefaultUI")
  self._uiSave.btn_SaveUI1 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI1")
  self._uiSave.btn_SaveUI2 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI2")
  self._uiSave.btn_SaveUI3 = UI.getChildControl(Panel_Window_SavePreset_All, "Button_UI3")
  self._uiSave.bg_Block = UI.getChildControl(Panel_Window_SavePreset_All, "Static_Block")
  self._uiSave.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._uiSave.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVEFREESET_DESC"))
  local panelControl = self._panelControl
  local panelID = self._panelID
  self._swapPanelList[0] = panelID.ExpGage
  self._swapPanelList[1] = panelID.Pvp
  self._swapPanelList[2] = panelID.Adrenallin
  self._swapPanelList[3] = panelID.HPBar
  self._swapPanelList[4] = panelID.MainStatusRemaster
  panelControl[panelID.ExpGage] = {
    control = Panel_SelfPlayerExpGage,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SelfPlayer_ExpGage,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_1"),
    isShow = true
  }
  panelControl[panelID.ServantIcon] = {
    control = Panel_Window_Servant,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ServantWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_2"),
    isShow = true
  }
  panelControl[panelID.Radar] = {
    control = Panel_Radar,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_3"),
    isShow = true
  }
  panelControl[panelID.Quest] = {
    control = Panel_CheckedQuest,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_CheckedQuest,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_4"),
    isShow = true
  }
  panelControl[panelID.Chat0] = {
    control = Panel_Chat0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_5"),
    isShow = true
  }
  panelControl[panelID.Chat1] = {
    control = Panel_Chat1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_6"),
    isShow = false
  }
  panelControl[panelID.Chat2] = {
    control = Panel_Chat2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_7"),
    isShow = false
  }
  panelControl[panelID.Chat3] = {
    control = Panel_Chat3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_8"),
    isShow = false
  }
  panelControl[panelID.Chat4] = {
    control = Panel_Chat4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_9"),
    isShow = false
  }
  panelControl[panelID.GameTip] = {
    control = Panel_GameTips,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_GameTips,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_10"),
    isShow = true
  }
  panelControl[panelID.QuickSlot] = {
    control = Panel_QuickSlot,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_QuickSlot,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_11"),
    isShow = true
  }
  panelControl[panelID.HPBar] = {
    control = Panel_MainStatus_User_Bar,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusBar,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_12"),
    isShow = false
  }
  panelControl[panelID.Pvp] = {
    control = Panel_PvpMode,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_PvpMode,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_13"),
    isShow = true
  }
  panelControl[panelID.ClassResource] = {
    control = Panel_ClassResource,
    showFixed = true,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ClassResource,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_14"),
    isShow = true
  }
  panelControl[panelID.Adrenallin] = {
    control = Panel_Adrenallin,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Adrenallin,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_15"),
    isShow = true
  }
  panelControl[panelID.UIMain] = {
    control = Panel_UIMain,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_UIMenu,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_16"),
    isShow = true
  }
  panelControl[panelID.House] = {
    control = Panel_MyHouseNavi,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MyHouseNavi,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_17"),
    isShow = false
  }
  panelControl[panelID.NewEquip] = {
    control = Panel_NewEquip,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewEquipment,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_18"),
    isShow = true
  }
  panelControl[panelID.Party] = {
    control = Panel_Party,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
    isShow = true
  }
  panelControl[panelID.TimeBar] = {
    control = Panel_TimeBar,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_20"),
    isShow = true
  }
  panelControl[panelID.ActionGuide] = {
    control = Panel_SkillCommand,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_21"),
    isShow = true
  }
  panelControl[panelID.KeyGuide] = {
    control = Panel_Movie_KeyViewer,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_KeyViewer,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_22"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot0] = {
    control = Panel_NewQuickSlot_0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_0,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_1"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot1] = {
    control = Panel_NewQuickSlot_1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_1,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_2"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot2] = {
    control = Panel_NewQuickSlot_2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_2,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_3"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot3] = {
    control = Panel_NewQuickSlot_3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_3,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_4"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot4] = {
    control = Panel_NewQuickSlot_4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_4,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_5"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot5] = {
    control = Panel_NewQuickSlot_5,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_5,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_6"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot6] = {
    control = Panel_NewQuickSlot_6,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_6,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_7"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot7] = {
    control = Panel_NewQuickSlot_7,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_7,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_8"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot8] = {
    control = Panel_NewQuickSlot_8,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_8,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_9"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot9] = {
    control = Panel_NewQuickSlot_9,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_9,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_10"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot10] = {
    control = Panel_NewQuickSlot_10,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_10,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_11"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot11] = {
    control = Panel_NewQuickSlot_11,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_11,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_12"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot12] = {
    control = Panel_NewQuickSlot_12,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_12,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_13"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot13] = {
    control = Panel_NewQuickSlot_13,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_13,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_14"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot14] = {
    control = Panel_NewQuickSlot_14,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_14,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_15"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot15] = {
    control = Panel_NewQuickSlot_15,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_15,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_16"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot16] = {
    control = Panel_NewQuickSlot_16,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_16,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_17"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot17] = {
    control = Panel_NewQuickSlot_17,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_17,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_18"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot18] = {
    control = Panel_NewQuickSlot_18,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_18,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_19"),
    isShow = false
  }
  panelControl[panelID.NewQuickSlot19] = {
    control = Panel_NewQuickSlot_19,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_NewQuickSlot_19,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_QUICKSLOT_20"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTime] = {
    control = Panel_SkillCooltime,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLCOOLTIME"),
    isShow = false
  }
  panelControl[panelID.MainQuest] = {
    control = Panel_MainQuest,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_MAINQUEST_TITLE"),
    isShow = false
  }
  panelControl[panelID.LargeParty] = {
    control = Panel_LargeParty,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
    isShow = true
  }
  panelControl[panelID.SkillCoolTimeQuickSlot0] = {
    control = Panel_SkillCoolTimeQuickSlot_0,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_0,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_1"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot1] = {
    control = Panel_SkillCoolTimeQuickSlot_1,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_1,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_2"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot2] = {
    control = Panel_SkillCoolTimeQuickSlot_2,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_2,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_3"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot3] = {
    control = Panel_SkillCoolTimeQuickSlot_3,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_3,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_4"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot4] = {
    control = Panel_SkillCoolTimeQuickSlot_4,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_4,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_5"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot5] = {
    control = Panel_SkillCoolTimeQuickSlot_5,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_5,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_6"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot6] = {
    control = Panel_SkillCoolTimeQuickSlot_6,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_6,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_7"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot7] = {
    control = Panel_SkillCoolTimeQuickSlot_7,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_7,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_8"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot8] = {
    control = Panel_SkillCoolTimeQuickSlot_8,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_8,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_9"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot9] = {
    control = Panel_SkillCoolTimeQuickSlot_9,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_9,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT_10"),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot10] = {
    control = Panel_SkillCoolTimeQuickSlot_10,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_10,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(11),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot11] = {
    control = Panel_SkillCoolTimeQuickSlot_11,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_11,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(12),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot12] = {
    control = Panel_SkillCoolTimeQuickSlot_12,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_12,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(13),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot13] = {
    control = Panel_SkillCoolTimeQuickSlot_13,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_13,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(14),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot14] = {
    control = Panel_SkillCoolTimeQuickSlot_14,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_14,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(15),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot15] = {
    control = Panel_SkillCoolTimeQuickSlot_15,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_15,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(16),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot16] = {
    control = Panel_SkillCoolTimeQuickSlot_16,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_16,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(17),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot17] = {
    control = Panel_SkillCoolTimeQuickSlot_17,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_17,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(18),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot18] = {
    control = Panel_SkillCoolTimeQuickSlot_18,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_18,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(19),
    isShow = false
  }
  panelControl[panelID.SkillCoolTimeQuickSlot19] = {
    control = Panel_SkillCoolTimeQuickSlot_19,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTimeQuickSlot_19,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLCOLLTIMEQUICKSLOT") .. tostring(20),
    isShow = false
  }
  panelControl[panelID.MainStatusRemaster] = {
    control = Panel_MainStatus_Remaster,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_1"),
    isShow = true
  }
  panelControl[panelID.ServantIconRemaster] = {
    control = Panel_Widget_ServantIcon,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_2"),
    isShow = true
  }
  panelControl[panelID.AppliedBuffList] = {
    control = Panel_AppliedBuffList,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "BUFF_LIST"),
    isShow = true
  }
  panelControl[panelID.LeftIcon] = {
    control = Panel_PersonalIcon_Left,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_FAMILYBUFF_NAME"),
    isShow = true
  }
  panelControl[panelID.RightIcon] = {
    control = Panel_Widget_Function,
    showFixed = false,
    posFixed = true,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_FUNCTIONBUTTON_NAME"),
    isShow = true
  }
  panelControl[panelID.Stamina] = {
    control = Panel_Stamina,
    showFixed = true,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Stamina,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_STAMINA"),
    isShow = true
  }
  panelControl[panelID.killLog] = {
    control = Panel_Widget_KillLog,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_KillLog,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_KILLLOG_NAME"),
    isShow = true
  }
  panelControl[panelID.SkillLog] = {
    control = Panel_Widget_SkillLog,
    showFixed = false,
    posFixed = false,
    isChange = false,
    PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_SkillLog,
    prePos = {x = 0, y = 0},
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLLOG"),
    isShow = true
  }
  if true == _ContentsGroup_ConsoleGetItemForPC then
    panelControl[panelID.ItemLogReNew] = {
      control = Panel_Widget_ItemLog_Renew,
      showFixed = false,
      posFixed = false,
      isChange = false,
      PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_ItemLogRenew,
      prePos = {x = 0, y = 0},
      name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_OPTION_ITEM_ALARM"),
      isShow = true
    }
  end
  if false == ToClient_isConsole() then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      panelControl[panelID.LargeParty] = {
        control = Panel_Widget_Raid_All,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
        isShow = true
      }
      panelControl[panelID.Party] = {
        control = Panel_Widget_Party_All,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
        isShow = true
      }
    else
      panelControl[panelID.LargeParty] = {
        control = Panel_Widget_Raid,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_LargeParty,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE"),
        isShow = true
      }
      panelControl[panelID.Party] = {
        control = Panel_Widget_Party,
        showFixed = false,
        posFixed = false,
        isChange = false,
        PAGameUIType = CppEnums.PAGameUIType.PAGameUIPanel_Party,
        prePos = {x = 0, y = 0},
        name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_19"),
        isShow = true
      }
    end
  end
  local swapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  if true == swapRadar then
    setChangeUiSettingRadarUI(Panel_WorldMiniMap, CppEnums.PAGameUIType.PAGameUIPanel_WorldMiniMap)
  end
  self._panelCount = #self._panelControl
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    for idx = 1, self._panelCount do
      if false == self._panelControl[idx].posFixed then
        table.insert(self._posFixedNormalTab, idx)
      end
    end
  end
  PaGlobal_UIModify:initializePanelPool()
  if true == _ContentsGroup_RenewUI_Main then
    Panel_SkillCommand:SetShow(false)
    Panel_UIMain:SetShow(false)
  end
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_UISetting
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, FGlobal_UiSet_Close)
  self._ui.slider_UI_Scale:SetInterval(160)
  local remasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
  self._ui.chk_remsaterUI:SetCheck(not remasterUIOption)
  self._prevRemasterUI = remasterUIOption
  self._isShowRemasterUI = remasterUIOption
  PaGlobal_UIModify:registEventHandler()
  PaGlobal_UIModify:validate()
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    local isUseMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode)
    local isEmptyPreset
    if true == isUseMode then
      isEmptyPreset = ToClient_getGameUIManagerWrapper():isPresetListEmpty(__eUISetting_BattlePreset)
      if true == isEmptyPreset then
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
    isEmptyPreset = ToClient_getGameUIManagerWrapper():isPresetListEmpty(__eUISetting_Revert)
    if true == isEmptyPreset then
      self:savePresetInfo(__eUISetting_Revert, false)
    end
    self:applyPresetInfo(__eUISetting_Revert, false)
  end
  self._initialize = true
end
function PaGlobal_UIModify:initializePanelPool()
  if 0 == self._panelCount then
    UI.ASSERT_NAME(0 < self._panelCount, "Panel_Window_UIModify_All\236\157\152 _panelCount\234\176\128 0\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\236\134\161\235\175\188\236\160\149")
    return
  end
  self._panelPoolBG = UI.createPanelAndSetPanelRenderMode("Panel_modifyPool", Defines.UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_UISetting
  }))
  if nil == self._panelPoolBG then
    UI.ASSERT_NAME(0 < self._panelCount, "Panel_Window_UIModify_All\236\157\152 _panelPoolBG\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\236\134\161\235\175\188\236\160\149")
    return
  end
  self._panelPoolBG:SetAlpha(0)
  self._panelPoolBG:SetIgnore(true)
  for idx = 1, self._panelCount do
    local orignalControl = self._panelControl[idx].control
    local slot = {}
    local fixedType = ""
    if self._panelControl[idx].posFixed then
      fixedType = "StaticText_Disable"
    else
      fixedType = "StaticText_Able"
    end
    slot.control = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All, fixedType, self._panelPoolBG, "txt_createControl_" .. idx)
    slot.control:SetShow(true)
    slot.control:SetSize(orignalControl:GetSizeX(), orignalControl:GetSizeY())
    slot.control:SetPosX(orignalControl:GetPosX())
    slot.control:SetPosY(orignalControl:GetPosY())
    slot.control:addInputEvent("Mouse_LDown", "HandleEventLUp_UiSet_MoveControlSet_Start( " .. idx .. " )")
    slot.control:addInputEvent("Mouse_LPress", "HandleEventLUp_UiSet_MoveControl( " .. idx .. " )")
    slot.control:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_PositionCheck( " .. idx .. " )")
    if idx >= self._panelID.SkillCoolTimeQuickSlot0 and idx <= self._panelID.SkillCoolTimeQuickSlot9 or idx >= self._panelID.SkillCoolTimeQuickSlot10 and idx <= self._panelID.SkillCoolTimeQuickSlot19 then
      slot.control:addInputEvent("Mouse_On", "PaGlobal_SimpleTooltips_Index(true, " .. idx .. ")")
      slot.control:addInputEvent("Mouse_Out", "PaGlobal_SimpleTooltips_Index(false, " .. idx .. ")")
    end
    slot.close = UI.createAndCopyBasePropertyControl(Panel_Window_UIModify_All, "Button_ShowToggle", slot.control, "btn_createClose_" .. idx)
    slot.close:SetShow(true)
    slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
    slot.close:SetPosY(3)
    slot.close:SetCheck(orignalControl:GetShow())
    if idx >= PaGlobal_UIModify._panelID.NewQuickSlot0 and idx <= PaGlobal_UIModify._panelID.NewQuickSlot19 then
      slot.close:addInputEvent("Mouse_LUp", "HandleEventLUp_UiModify_NewQuickSlotShowToggle( " .. idx .. " )")
    else
      slot.close:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_ControlShowToggle( " .. idx .. " )")
    end
    self._panelPool[idx] = slot
    if true == self._panelControl[idx].showFixed then
      self._panelControl[idx].isShow = true
      slot.close:SetShow(false)
    else
      self._panelControl[idx].isShow = self._panelControl[idx].control:GetShow()
      slot.close:SetShow(true)
    end
    if self._panelControl[idx].isShow then
      if self._panelControl[idx].posFixed then
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panelControl[idx].name))
      else
        slot.control:SetText(self._panelControl[idx].name)
      end
    elseif 21 == idx then
      slot.control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
    else
      slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panelControl[idx].name))
    end
    local stateValue = 0
    if not self._panelControl[idx].isShow then
      stateValue = 1
    elseif self._panelControl[idx].posFixed then
      stateValue = 3
    else
      stateValue = 2
    end
    self:changePanelBGTexture(idx, stateValue)
    if 0 < ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
      local relativePosX, relativePosY
      if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
        relativePosX = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, idx - self._panelID.Chat0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        relativePosY = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, idx - self._panelID.Chat0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      else
        relativePosX = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
        relativePosY = ToClient_GetUiInfo(self._panelControl[idx].PAGameUIType, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
      end
      if relativePosX == -1 or relativePosY == -1 then
        if 0 < orignalControl:GetRelativePosX() or 0 < orignalControl:GetRelativePosY() then
          self._panelControl[idx].isChange = true
        else
          self._panelControl[idx].isChange = false
        end
      elseif relativePosX > 0 or relativePosY > 0 then
        self._panelControl[idx].isChange = true
      end
      if self._panelControl[idx].posFixed == true then
        self._panelControl[idx].isChange = false
        Panel_Window_UIModify_All:SetChildIndex(slot.control, 0)
      end
      orignalControl:SetRelativePosX(relativePosX)
      orignalControl:SetRelativePosY(relativePosY)
      self._panelPool[idx].control:SetRelativePosX(relativePosX)
      self._panelPool[idx].control:SetRelativePosY(relativePosY)
    end
  end
end
function PaGlobal_UIModify:registEventHandler()
  if nil == Panel_Window_UIModify_All then
    return
  end
  registerEvent("FromClient_getUiSettingPanelInfo", "FromClient_getUiSettingPanelInfo")
  registerEvent("FromClient_getUiSettingChattingPanelInfo", "FromClient_getUiSettingChattingPanelInfo")
  if false == _ContentsGroup_ChatOption_All then
    registerEvent("FromClient_applyChattingOptionToLua", "FromClient_applyChattingOptionToLua")
  end
  registerEvent("onScreenResize", "FromClient_UISetting_Resize")
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    registerEvent("FromClient_refreshBattleFocusMode", "FromClient_refreshBattleFocusMode")
  end
  self._ui.chk_Collapse:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:updateModifyPanelSize()")
  self._ui.chk_Collapse:addInputEvent("Mouse_On", "PaGlobal_UIModify:showCollapseTooltip()")
  self._ui.chk_Collapse:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  self._ui.btn_win_close:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:prepareClose()")
  self._ui.btn_save:addInputEvent("Mouse_LUp", "UiSet_FreeSet_Open()")
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleClicked_Reset_UiSetting_Msg()")
  self._ui.chk_GridView:addInputEvent("Mouse_LUp", "HandleLUp_ToggleGrid()")
  self._ui.btn_Scale:addInputEvent("Mouse_LDown", "HandleEventLDown_UiSet_ChangeScale()")
  self._ui.slider_UI_Scale:addInputEvent("Mouse_LDown", "HandleEventLDown_UiSet_ChangeScale()")
  self._ui.btn_Scale:addInputEvent("Mouse_LPress", "HandleEventLPress_UiSet_ChangeScale()")
  self._ui.slider_UI_Scale:addInputEvent("Mouse_LPress", "HandleEventLPress_UiSet_ChangeScale()")
  self._ui.chk_FieldView:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_FieldViewToggle()")
  self._ui.chk_remsaterUI:addInputEvent("Mouse_LUp", "HandleEventLUp_UiSet_SwapRemasterUI()")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset0 .. ", false)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset1 .. ", false)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset2 .. ", false)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_LUp", "HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Revert .. ", false)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_LUp", "HandleLUp_UiSetting_DefaultSet(false)")
  self._ui.btn_UIFreeSet1:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset0 .. ", true)", "PANEL_SAVEFREESET_FREESET1")
  self._ui.btn_UIFreeSet2:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset1 .. ", true)", "PANEL_SAVEFREESET_FREESET2")
  self._ui.btn_UIFreeSet3:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Preset2 .. ", true)", "PANEL_SAVEFREESET_FREESET3")
  self._ui.btn_RevertMod:setButtonShortcutsWithEvent("HandleEventLUp_ApplyPresetInfo( " .. __eUISetting_Revert .. ", true)", "PANEL_UISETTING_REVERT_MODE")
  self._ui.btn_CleanMode:setButtonShortcutsWithEvent("HandleLUp_UiSetting_DefaultSet(true)", "PANEL_UISETTING_COMBAT_FOCUS_MODE")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset1 .. ", true)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset2 .. ", true)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset3 .. ", true)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.battleMode .. ", true)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_On", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.revertMode .. ", true)")
  self._ui.btn_UIFreeSet1:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset1 .. ", false)")
  self._ui.btn_UIFreeSet2:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset2 .. ", false)")
  self._ui.btn_UIFreeSet3:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.preset3 .. ", false)")
  self._ui.btn_CleanMode:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.battleMode .. ", false)")
  self._ui.btn_RevertMod:addInputEvent("Mouse_Out", "PaGlobal_UIModify_ButtonTooltip(" .. PaGlobal_UIModify._eBtnType.revertMode .. ", false)")
  self._uiSave.btn_SaveClose:addInputEvent("Mouse_LUp", "PaGlobal_UiSet_FreeSet_Close()")
  self._uiSave.btn_SaveDefault:addInputEvent("Mouse_LUp", "HandleClicked_UiSet_ConfirmSetting(false)")
  self._uiSave.btn_SaveUI1:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:savePresetInfo( " .. __eUISetting_Preset0 .. ", true)")
  self._uiSave.btn_SaveUI2:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:savePresetInfo( " .. __eUISetting_Preset1 .. ", true)")
  self._uiSave.btn_SaveUI3:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:savePresetInfo( " .. __eUISetting_Preset2 .. ", true)")
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    self._ui.rdo_normal:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:selectNormalTab()")
    self._ui.rdo_battle:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:selectBattleTab()")
    self._ui.chk_useBattleMode:addInputEvent("Mouse_LUp", "PaGlobal_UIModify:checkBattleMode()")
  end
end
function PaGlobal_UIModify:prepareOpen(isShortcuts)
  if nil == Panel_Window_UIModify_All then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  local levelLimit = 10
  if ToClient_CheckFamilyCharacterLevel(10) == false then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_LEVELLIMIT_ACK", "level", levelLimit))
    return
  end
  if nil == isShortcuts then
    isShortcuts = false
  end
  self._beforeUiMode = GetUIMode()
  close_force_WindowPanelList()
  ToClient_SaveUiInfo(false)
  self._ui.grid_BG:SetShow(false)
  self._ui.chk_GridView:SetCheck(false)
  if true == _ContentsGroup_RemasterUI_Radar then
    FGlobal_ResetTimeBar()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  local remasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
  self._ui.chk_remsaterUI:SetCheck(not remasterUIOption)
  self._prevRemasterUI = remasterUIOption
  self._isShowRemasterUI = remasterUIOption
  Panel_FieldViewMode:SetShow(false)
  self:UiSet_Panel_ShowValueUpdate()
  SetUIMode(Defines.UIMode.eUIMode_UiSetting)
  self._renderMode:set()
  self._ui.chk_FieldView:SetCheck(false)
  self._ui.chk_QuickSlotMagnetic:SetCheck(true)
  PaGlobal_UIModify:scaleSet()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.TimeBar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    end
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(chattingPanelindex)
    if chatPanel:isOpen() then
      self._chatPanelIsOpenState[chattingPanelindex + 1] = true
    else
      self._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_UIEDIT")
  end
  PaGlobal_UIModify:update()
  if isShortcuts == false then
    PaGlobal_UIModify:open()
  end
end
function PaGlobal_UIModify:prepareForReplay()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if nil == getSelfPlayer() or nil == getSelfPlayer():get() then
    return
  end
  close_force_WindowPanelList()
  ToClient_SaveUiInfo(false)
  if true == _ContentsGroup_RemasterUI_Radar then
    FGlobal_ResetTimeBar()
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  Panel_FieldViewMode:SetShow(false)
  self:UiSet_Panel_ShowValueUpdate()
  SetUIMode(Defines.UIMode.eUIMod3e_UiSetting)
  PaGlobal_UIModify:scaleSet()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.TimeBar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    end
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(chattingPanelindex)
    if chatPanel:isOpen() then
      self._chatPanelIsOpenState[chattingPanelindex + 1] = true
    else
      self._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_UIEDIT")
  end
  PaGlobal_UIModify:update()
end
function PaGlobal_UIModify:open()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    self:selectNormalTab()
    if true == ToClient_isBattleFocusModeOn() then
      self._ui.chk_useBattleMode:SetCheck(true)
    else
      self._ui.chk_useBattleMode:SetCheck(false)
    end
    _cacheScale = PaGlobal_UIModify._currentScale / 100
    self._isNormalTab = true
  end
  Panel_Window_UIModify_All:SetShow(true)
  self._panelPoolBG:SetShow(true)
end
function PaGlobal_UIModify:prepareClose()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if false == Panel_Window_UIModify_All:IsShow() then
    return
  end
  if true == _ContentsGroup_RemasterUI_Radar then
    PaGlobalFunc_Radar_Resize()
  end
  PaGlobal_UiSet_FreeSet_Close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  self._renderMode:reset()
  if self._isMenu then
    Panel_Menu_ShowToggle()
  elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
    Panel_Window_Skill:SetShow(true, true)
    PaGlobal_Window_Skill_CoolTimeSlot:showFunc()
  else
    SetUIMode(self._beforeUiMode)
  end
  local count = ToClient_getChattingPanelCount()
  for chattingPanelindex = 0, count - 1 do
    Chatting_setIsOpenValue(chattingPanelindex, self._chatPanelIsOpenState[chattingPanelindex + 1])
    self._chatPanelIsOpenState[chattingPanelindex + 1] = false
  end
  for idx = 0, 4 do
    if self._closePanelState[idx] == true then
      HandleClicked_Chatting_Close(idx, 0)
    end
    self._closePanelState[idx] = false
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    FromClient_BloodAltar_OnScreenResize()
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, self._prevRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_UIModify:close()
end
function PaGlobal_UIModify:close()
  if nil == Panel_Window_UIModify_All then
    return
  end
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    if true == ToClient_isBattleFocusModeOn() then
      ToClient_SetBattleFocusMode(false)
      ToClient_SetBattleFocusMode(true)
    else
      self:refreshBattleFocusUI(false)
    end
  end
  Panel_Window_UIModify_All:SetShow(false)
  self._panelPoolBG:SetShow(false)
end
function PaGlobal_UIModify:update(isRemasterSwap)
  if nil == Panel_Window_UIModify_All then
    return
  end
  FromClient_UISetting_Resize()
  if true == isRemasterSwap then
    if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
      for _, pID in pairs(self._swapPanelList) do
        if nil ~= self._panelControl[pID] and true == self._panelPool[pID].close:IsCheck() then
          self._panelControl[pID].isShow = true
        else
          self._panelControl[pID].isShow = false
        end
      end
    else
      for _, pID in pairs(self._swapPanelList) do
        if nil ~= self._panelControl[pID] then
          self._panelControl[pID].isShow = true
        end
      end
    end
  else
    self._ui.slider_UI_Scale:SetControlPos(self._nowCurrentPercent)
  end
  local scaleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SCALETEXT", "currentScale", self._currentScale)
  self._ui.txt_UISize:SetText(tostring(scaleText))
  self._ui.txt_UI_LOW:SetText(self._minScale)
  self._ui.txt_UI_HIGH:SetText(self._maxScale)
  self:updatePanelPool(isRemasterSwap)
end
function PaGlobal_UIModify:validate()
  if nil == Panel_Window_UIModify_All then
    return
  end
  self._ui.grid_BG:isValidate()
  self._ui.balckBG:isValidate()
  self._ui.main_BG:isValidate()
  self._ui.btn_UIFreeSet1:isValidate()
  self._ui.btn_UIFreeSet2:isValidate()
  self._ui.btn_UIFreeSet3:isValidate()
  self._ui.btn_CleanMode:isValidate()
  self._ui.btn_RevertMod:isValidate()
  self._ui.sub_BG:isValidate()
  self._ui.txt_UISize:isValidate()
  self._ui.txt_UI_LOW:isValidate()
  self._ui.txt_UI_HIGH:isValidate()
  self._ui.slider_UI_Scale:isValidate()
  self._ui.btn_Scale:isValidate()
  self._ui.chk_remsaterUI:isValidate()
  self._ui.chk_FieldView:isValidate()
  self._ui.chk_QuickSlotMagnetic:isValidate()
  self._ui.chk_GridView:isValidate()
  self._ui.btn_save:isValidate()
  self._ui.btn_reset:isValidate()
  for idx = 1, self._panelCount do
    self._panelControl[idx].control:isValidate()
    self._panelPool[idx].control:isValidate()
  end
end
function PaGlobal_UIModify:UiSet_Panel_ShowValueUpdate()
  for idx = 1, self._panelCount do
    if true == self._panelControl[idx].showFixed then
      self._panelControl[idx].isShow = true
    else
      self._panelControl[idx].isShow = self._panelControl[idx].control:GetShow()
    end
    self._panelControl[idx].prePos.x = self._panelControl[idx].control:GetPosX()
    self._panelControl[idx].prePos.y = self._panelControl[idx].control:GetPosY()
  end
end
function PaGlobal_UIModify:checkOldMainStatus()
  if true == _ContentsGroup_RemasterUI_Main then
    self._panelControl[self._panelID.MainStatusRemaster].control:SetShow(self._panelControl[self._panelID.MainStatusRemaster].isShow and PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.ExpGage].control:SetShow(self._panelControl[self._panelID.ExpGage].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.Adrenallin].control:SetShow(self._panelControl[self._panelID.Adrenallin].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.Pvp].control:SetShow(self._panelControl[self._panelID.Pvp].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.HPBar].control:SetShow(self._panelControl[self._panelID.HPBar].isShow and not PaGlobalFunc_IsRemasterUIOption())
    self._panelControl[self._panelID.House].control:SetShow(false)
    self._panelControl[self._panelID.ServantIcon].control:SetShow(false)
    self._panelControl[self._panelID.NewEquip].control:SetShow(false)
  end
end
function PaGlobal_UIModify:scaleSet()
  local scaleValue = FGlobal_getUIScale()
  self._minScale = scaleValue.min
  self._maxScale = scaleValue.max
  self._currentScale = FGlobal_returnUIScale() * 100
  self._replaceScale = self._maxScale - self._minScale
  self._preScale = FGlobal_returnUIScale()
  self._nowCurrentPercent = math.ceil((self._currentScale - self._minScale) / self._replaceScale * 100)
  if true == UI.checkResolution4KForXBox() then
    self._nowCurrentPercent = 200
  end
end
function PaGlobal_UIModify:confrimSetting_Sub()
  local panelControl = self._panelControl
  local scale = self._currentScale / 100
  local preScale = self._preScale
  local panelID = self._panelID
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  local preScreenSize = {
    x = currentScreenSize.x / preScale,
    y = currentScreenSize.y / preScale
  }
  local changeScreenSize = {
    x = currentScreenSize.x / scale,
    y = currentScreenSize.y / scale
  }
  for idx = 1, self._panelCount do
    local controlPosX = self._panelPool[idx].control:GetPosX()
    local controlPosY = self._panelPool[idx].control:GetPosY()
    local slot = self._panelPool[idx].control
    local posX = slot:GetPosX()
    local posY = slot:GetPosY()
    local rateX = 0
    local rateY = 0
    local isUseNewQuickSlot = isUseNewQuickSlot()
    rateX = posX + slot:GetSizeX() / 2
    rateY = posY + slot:GetSizeY() / 2
    if panelControl[idx].isChange == false then
      panelControl[idx].control:SetRelativePosX(0)
      panelControl[idx].control:SetRelativePosY(0)
      slot:SetRelativePosX(0)
      slot:SetRelativePosY(0)
    else
      panelControl[idx].control:SetRelativePosX(rateX / currentScreenSize.x)
      panelControl[idx].control:SetRelativePosY(rateY / currentScreenSize.y)
      slot:SetRelativePosX(rateX / currentScreenSize.x)
      slot:SetRelativePosY(rateY / currentScreenSize.y)
    end
    local classType = getSelfPlayer():getClassType()
    if idx == panelID.Pvp then
      if isPvpEnable() and true == ToClient_isAdultUser() then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      end
    elseif idx == panelID.Adrenallin then
      panelControl[idx].control:SetShow(getSelfPlayer():isEnableAdrenalin())
    elseif idx == panelID.GameTip then
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
      if false == _ContentsGroup_RenewUI then
        Panel_GameTipMask:SetShow(panelControl[idx].isShow)
        Panel_GameTipMask:SetPosX(controlPosX + 15)
        Panel_GameTipMask:SetPosY(controlPosY - 7)
      end
    elseif idx == panelID.ClassResource then
      if PaGlobal_ClassResource_CanUseResourceIcon ~= nil and PaGlobal_ClassResource_CanUseResourceIcon(classType) == true then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      end
    elseif idx == panelID.ActionGuide then
      setShowSkillCmd(panelControl[idx].isShow)
      if true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All_SetSkillCommandPanel(panelControl[idx].isShow)
      else
        isChecked_SkillCommand = panelControl[idx].isShow
      end
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
      GameOption_UpdateOptionChanged()
      FGlobal_SkillCommand_Show(panelControl[idx].isShow)
    elseif idx == panelID.KeyGuide then
      if true == panelControl[idx].isShow then
        FGlobal_KeyViewer_Show()
      else
        FGlobal_KeyViewer_Hide()
      end
      isChecked_KeyViewer = panelControl[idx].isShow
      GameOption_UpdateOptionChanged()
    elseif idx == panelID.UIMain then
      if true == _ContentsGroup_RenewUI_Main then
        panelControl[idx].control:SetShow(false)
      else
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      end
    elseif idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
      if false == panelControl[idx].isShow and isUseNewQuickSlot then
        quickSlot_Clear(idx - panelID.NewQuickSlot0)
      end
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    elseif idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 or idx >= panelID.SkillCoolTimeQuickSlot10 and idx <= panelID.SkillCoolTimeQuickSlot19 then
      panelControl[idx].control:SetPosX(controlPosX)
      panelControl[idx].control:SetPosY(controlPosY)
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    elseif idx == panelID.Stamina then
      panelControl[idx].control:SetShow(true)
      panelControl[idx].control:SetPosX(controlPosX)
      panelControl[idx].control:SetPosY(controlPosY)
    else
      panelControl[idx].control:SetShow(panelControl[idx].isShow)
    end
    if idx == panelID.RightIcon then
      if true == panelControl[idx].isShow then
        if nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Update then
          PaGlobalFunc_Widget_TownSimpleNavi_All_Update()
        end
      elseif nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Close then
        PaGlobalFunc_Widget_TownSimpleNavi_All_Close()
      end
    end
  end
  PaGlobal_UIModify:checkOldMainStatus()
  ToClient_SaveUiInfo(true)
  return scale
end
function PaGlobal_UIModify:getLuaCacheDataIndex(presetIndex)
  local remasterUIIndex = 0
  if 0 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset0
  elseif 1 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset1
  elseif 2 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingPreset2
  elseif 3 == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingRevert
  elseif __eUISetting_BattlePreset == presetIndex then
    remasterUIIndex = __eSwapRemasterUISettingBattlePreset
  end
  return remasterUIIndex
end
function PaGlobal_UIModify:getLuaCacheDataIndexSwapRadar(presetIndex)
  local swapRadarIndex = 0
  if 0 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset0
  elseif 1 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset1
  elseif 2 == presetIndex then
    swapRadarIndex = __eRadarSwapPreset2
  elseif 3 == presetIndex then
    swapRadarIndex = __eRadarSwapPresetRevert
  elseif __eUISetting_BattlePreset == presetIndex then
    swapRadarIndex = __eRadarSwapBattlePreset
  end
  return swapRadarIndex
end
function PaGlobal_UIModify:savePresetInfo(presetIndex, isClosePanel)
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  for idx = 1, self._panelCount do
    local slot
    slot = self._panelPool[idx].control
    local controlPos = float2()
    controlPos.x = slot:GetPosX()
    controlPos.y = slot:GetPosY()
    local rateX = controlPos.x + slot:GetSizeX() / 2
    local rateY = controlPos.y + slot:GetSizeY() / 2
    local relativePos = float2()
    relativePos.x = rateX / currentScreenSize.x
    relativePos.y = rateY / currentScreenSize.y
    local isShow = self._panelControl[idx].isShow
    local controlShowToggle = self._panelPool[idx].close:IsCheck()
    local uiType = self._panelControl[idx].PAGameUIType
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
      local chatPanelSize = float2()
      chatPanelSize.x = chatPanel:getPanelSizeX()
      chatPanelSize.y = chatPanel:getPanelSizeY()
      ToClient_setUISettingChattingPanelInfo(presetIndex, chatWindowIndex, chatPanel:isOpen(), chatPanel:isCombinedToMainPanel(), uiType, controlPos, controlShowToggle, relativePos, chatPanelSize, setUISettingChattingPanelInfo)
      ToClient_setUISettingChattingOption(presetIndex, chatWindowIndex, Chatting_getUsedSmoothChattingUp())
    end
    ToClient_setUISettingPanelInfo(uiType, controlPos.x, controlPos.y, controlShowToggle, chatWindowIndex, relativePos.x, relativePos.y)
  end
  ToClient_getGameUIManagerWrapper():saveUISettingPresetInfo(presetIndex)
  ToClient_getGameUIManagerWrapper():saveUISettingChattingPresetInfo(presetIndex)
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    if true == isClosePanel then
      HandleClicked_UiSet_ConfirmSetting(__eUISetting_BattlePreset == presetIndex)
    end
  else
    HandleClicked_UiSet_ConfirmSetting(__eUISetting_Revert == presetIndex)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex), not self._ui.chk_remsaterUI:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
  local swapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex), swapRadar, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_UIModify:savePresetInfoByPanelControl(presetIndex, isClosePanel)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  for idx = 1, self._panelCount do
    local slot
    slot = self._panelControl[idx].control
    local controlPos = float2()
    controlPos.x = slot:GetPosX()
    controlPos.y = slot:GetPosY()
    local rateX = controlPos.x + slot:GetSizeX() / 2
    local rateY = controlPos.y + slot:GetSizeY() / 2
    local relativePos = float2()
    relativePos.x = rateX / currentScreenSize.x
    relativePos.y = rateY / currentScreenSize.y
    local isShow = self._panelControl[idx].isShow
    local controlShowToggle = self._panelPool[idx].close:IsCheck()
    local uiType = self._panelControl[idx].PAGameUIType
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
      local chatPanelSize = float2()
      chatPanelSize.x = chatPanel:getPanelSizeX()
      chatPanelSize.y = chatPanel:getPanelSizeY()
      ToClient_setUISettingChattingPanelInfo(presetIndex, chatWindowIndex, chatPanel:isOpen(), chatPanel:isCombinedToMainPanel(), uiType, controlPos, isShow, relativePos, chatPanelSize, setUISettingChattingPanelInfo)
      ToClient_setUISettingChattingOption(presetIndex, chatWindowIndex, Chatting_getUsedSmoothChattingUp())
    end
    ToClient_setUISettingPanelInfo(uiType, controlPos.x, controlPos.y, isShow, chatWindowIndex, relativePos.x, relativePos.y)
  end
  ToClient_getGameUIManagerWrapper():saveUISettingPresetInfo(presetIndex)
  ToClient_getGameUIManagerWrapper():saveUISettingChattingPresetInfo(presetIndex)
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    if true == isClosePanel then
      HandleClicked_UiSet_ConfirmSetting(__eUISetting_BattlePreset == presetIndex)
    end
  else
    HandleClicked_UiSet_ConfirmSetting(__eUISetting_Revert == presetIndex)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex), not self._ui.chk_remsaterUI:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
  local swapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex), swapRadar, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_UIModify:applyPresetInfo(presetIndex, isShortcuts)
  if ToClient_getGameUIManagerWrapper():isPresetListEmpty(presetIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_NOPRESET"))
    return
  end
  local isSetRemasterUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
  self._prevRemasterUI = self._isShowRemasterUI
  self._isShowRemasterUI = isSetRemasterUI
  self._ui.chk_remsaterUI:SetCheck(not isSetRemasterUI)
  local swapRadarPreset = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex))
  local currentswapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  if swapRadarPreset ~= currentswapRadar then
    PaGlobal_changeRadarUI()
    FGlobal_ResetTimeBar()
  end
  for idx = 1, self._panelCount do
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      ToClient_getUISettingChattingPanelInfo(presetIndex, chatWindowIndex)
    end
    ToClient_getUISettingPanelInfo(presetIndex, idx, self._panelControl[idx].PAGameUIType, chatWindowIndex)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex), self._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  FromClient_MainStatus_SwapUIOption(self._isShowRemasterUI, false)
  self:scaleSet()
  self:update()
  self:confrimSetting_Sub(false)
  ToClient_CopyEditUiInfo()
  FGlobal_PackageIconUpdate()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 and __eUISetting_Revert == presetIndex then
    HandleClicked_UiSet_ConfirmSetting(isShortcuts)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  else
  end
  if true == isShortcuts and nil ~= Chatting_OnResize then
    Chatting_OnResize()
  end
end
function PaGlobal_UIModify:applyDefaultSet(isShortcuts, isReplay)
  local isUseMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode)
  if false == isUseMode then
    self:savePresetInfo(__eUISetting_Revert, true)
  end
  local hideControl = {
    self._panelID.ServantIcon,
    self._panelID.Quest,
    self._panelID.Chat0,
    self._panelID.Chat1,
    self._panelID.Chat2,
    self._panelID.Chat3,
    self._panelID.Chat4,
    self._panelID.GameTip,
    self._panelID.UIMain,
    self._panelID.House,
    self._panelID.NewEquip,
    self._panelID.ActionGuide,
    self._panelID.KeyGuide,
    self._panelID.MainQuest,
    self._panelID.ServantIconRemaster,
    self._panelID.LeftIcon,
    self._panelID.RightIcon,
    self._panelID.SkillLog
  }
  for _, v in pairs(hideControl) do
    if true == self._panelControl[v].isShow then
      HandleEventLUp_UiSet_ControlShowToggle(v)
    end
  end
  if true == _ContentsGroup_NewUI_GameOption_All then
    PaGlobal_GameOption_All_SetSkillCommandPanel(false)
  else
    isChecked_SkillCommand = false
  end
  if false == self._ui.chk_remsaterUI:IsCheck() then
    self._ui.chk_remsaterUI:SetCheck(true)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, false, CppEnums.VariableStorageType.eVariableStorageType_User)
    HandleEventLUp_UiSet_SwapRemasterUI()
  end
  if true == self._panelControl[self._panelID.ExpGage].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.ExpGage)
  end
  if true == self._panelControl[self._panelID.Radar].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.Radar)
  end
  if true == self._panelControl[self._panelID.TimeBar].isShow then
    HandleEventLUp_UiSet_ControlShowToggle(self._panelID.TimeBar)
  end
  HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  if true ~= isReplay then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_MSGBOX_BATTLEMODE")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_UIModify:activateBattleFocusMode()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if true == ToClient_isBattleFocusModeOn() and true == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UIMODE_BATTLEFOCUS_ALREADYSET"))
    return
  end
  self:savePresetInfo(__eUISetting_Revert, true)
  self._cachedRemasterUICheckValue = self._ui.chk_remsaterUI:IsCheck()
  if true == ToClient_getCurrentBattleFocusCondition() then
    PaGlobal_UIModify:hideDefaultUI()
  end
  HandleClicked_UiSet_ConfirmSetting(false)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_SetBattleFocusMode(true)
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_MSGBOX_BATTLEMODE")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_UIModify:deactivateBattleFocusMode()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if false == ToClient_isBattleFocusModeOn() and false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUiSetting_useMode) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_NOMODESETTING"))
    return
  end
  for idx = 1, self._panelCount do
    local chatWindowIndex = 0
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      ToClient_getUISettingChattingPanelInfo(__eUISetting_Revert, chatWindowIndex)
    end
    ToClient_getUISettingPanelInfo(__eUISetting_Revert, idx, self._panelControl[idx].PAGameUIType, chatWindowIndex)
  end
  self._ui.chk_remsaterUI:SetCheck(self._cachedRemasterUICheckValue)
  self._prevRemasterUI = self._isShowRemasterUI
  self._isShowRemasterUI = not self._cachedRemasterUICheckValue
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, self._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  FromClient_MainStatus_SwapUIOption(self._isShowRemasterUI, false)
  self:update()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
  self:confrimSetting_Sub(false)
  ToClient_CopyEditUiInfo()
  FGlobal_PackageIconUpdate()
  HandleClicked_UiSet_ConfirmSetting(false)
  ToClient_SetBattleFocusMode(false)
  self._ui.chk_remsaterUI:SetIgnore(false)
end
function PaGlobal_UIModify:refreshBattleFocusUI(currentBattleFocusMode)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if true == currentBattleFocusMode then
    self:hideDefaultUI()
  else
    self:showDefaultUI()
  end
end
function PaGlobal_UIModify:hideDefaultUI()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  self:applyPresetInfoWithChat(__eUISetting_BattlePreset)
end
function PaGlobal_UIModify:showDefaultUI()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  self:applyPresetInfoWithChat(__eUISetting_Revert)
end
function PaGlobal_UIModify:getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  if self._panelControl[panelIndex].posFixed == false then
    self._panelPool[panelIndex].control:SetPosX(posX)
    self._panelPool[panelIndex].control:SetPosY(posY)
    self._panelPool[panelIndex].control:SetRelativePosX(relativePosX)
    self._panelPool[panelIndex].control:SetRelativePosY(relativePosY)
    self._panelControl[panelIndex].control:SetPosX(posX)
    self._panelControl[panelIndex].control:SetPosY(posY)
    self._panelControl[panelIndex].control:SetRelativePosX(relativePosX)
    self._panelControl[panelIndex].control:SetRelativePosY(relativePosY)
    self._panelControl[panelIndex].isChange = true
  else
    self._panelControl[panelIndex].isChange = false
  end
  if panelIndex == self._panelID.ClassResource then
    isShow = true
  end
  self._panelPool[panelIndex].control:SetShow(isShow)
  self._panelControl[panelIndex].control:SetShow(isShow)
  if true == _ContentsGroup_RenewUI_Main then
    self._panelControl[panelID.UIMain].control:SetShow(false)
  end
  if self._closeEmptyPanelState[panelIndex - self._panelID.Chat0] == false then
    self._panelControl[panelIndex].control:SetShow(isShow)
  end
  if false == _ContentsGroup_RenewUI and panelIndex == self._panelID.GameTip then
    Panel_GameTipMask:SetShow(isShow)
  end
  if self._panelPool[panelIndex].close:IsCheck() ~= isShow then
    if panelIndex == self._panelID.ActionGuide then
      if true == _ContentsGroup_NewUI_GameOption_All then
        PaGlobal_GameOption_All_SetSkillCommandPanel(isShow)
      else
        isChecked_SkillCommand = isShow
      end
    end
    if panelIndex ~= self._panelID.House and panelIndex ~= self._panelID.NewEquip and panelIndex ~= self._panelID.Party and panelIndex ~= self._panelID.QuickSlot and panelIndex ~= self._panelID.Adrenallin and panelIndex ~= self._panelID.LargeParty then
      HandleEventLUp_UiSet_ControlShowToggle(panelIndex)
    end
  end
end
function PaGlobal_UIModify:changePanelBGTexture(idx, state)
  local control = self._panelPool[idx].control
  control:ChangeTextureInfoName("combine/etc/combine_etc_uicontrolpanel.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, self._BG_Texture[state][1], self._BG_Texture[state][2], self._BG_Texture[state][3], self._BG_Texture[state][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_UIModify:updatePanelPool(isRemasterSwap)
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    if nil ~= slot and nil ~= slot.control then
      slot.control:SetScale(1, 1)
      slot.control:SetShow(true)
      if idx == self._panelID.LargeParty and false == _ContentsGroup_LargeParty then
        slot.control:SetShow(false)
      end
      local originalControl = self._panelControl[idx].control
      if true ~= isRemasterSwap then
        slot.originPosX = originalControl:GetPosX()
        slot.originPosY = originalControl:GetPosY()
        slot.originSizeX = originalControl:GetSizeX()
        slot.originSizeY = originalControl:GetSizeY()
        slot.control:SetPosX(slot.originPosX)
        slot.control:SetPosY(slot.originPosY)
        slot.control:SetSize(slot.originSizeX, slot.originSizeY)
      end
      slot.close:SetScale(1, 1)
      slot.close:SetShow(false == self._panelControl[idx].showFixed)
      slot.close:SetPosX(slot.control:GetSizeX() - slot.close:GetSizeX() - 3)
      slot.close:SetPosY(3)
      slot.close:SetCheck(self._panelControl[idx].isShow)
      if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
        local chatPanel = ToClient_getChattingPanel(idx - self._panelID.Chat0)
        if chatPanel:isOpen() then
          if idx == self._panelID.Chat0 then
            slot.control:SetShow(true)
            slot.close:SetShow(true)
          elseif chatPanel:isCombinedToMainPanel() then
            slot.control:SetShow(false)
            slot.close:SetShow(false)
          else
            slot.control:SetShow(true)
            slot.close:SetShow(true)
          end
        elseif chatPanel:isCombinedToMainPanel() == false or idx == self._panelID.Chat0 then
          slot.control:SetShow(true)
          slot.close:SetShow(true)
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
        end
      elseif idx == self._panelID.ClassResource then
        slot.close:SetShow(false)
        local classType = getSelfPlayer():getClassType()
        if PaGlobal_ClassResource_CanUseResourceIcon ~= nil and PaGlobal_ClassResource_CanUseResourceIcon(classType) == true then
          slot.control:SetShow(true)
          if pID ~= nil then
            self._panelControl[pID].isShow = true
          end
          if _ContentsGroup_UseBattleFocusUIModeVer2 == true and self._panelPool[idx].close:IsCheck() == true then
            self._panelControl[idx].control:SetShow(true)
          end
          if __eClassType_Sorcerer == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_14")
          elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTERTITLE")
          elseif __eClassType_ShyWaman == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_NAME")
          elseif __eClassType_BladeMasterWoman == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW_NAME")
          elseif __eClassType_Nova == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA_NAME")
          elseif __eClassType_Corsair == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_4")
          elseif __eClassType_Kunoichi == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_KUNOICHI_NAME")
          elseif __eClassType_Drakania == classType then
            if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Drakania) == true then
              self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_NAME")
            elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Drakania) == true then
              self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_PQW_TAG")
            end
          elseif __eClassType_Giant_Reserved0 == classType then
            if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_Giant_Reserved0) == true then
              self._panelControl[self._panelID.ClassResource].name = "\236\160\132\236\138\185"
            elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_Giant_Reserved0) == true then
              self._panelControl[self._panelID.ClassResource].name = "\234\176\129\236\132\1771"
            end
          elseif __eClassType_Giant_Reserved2 == classType then
            self._panelControl[self._panelID.ClassResource].name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_COPYCHARACTER_MAEGU")
          elseif __eClassType_KunoichiOld == classType then
            if PaGlobal_ClassResource_CanSuccessionIconEnable(__eClassType_KunoichiOld) == true then
              self._panelControl[self._panelID.ClassResource].name = "\236\160\132\236\138\1853"
            elseif PaGlobal_ClassResource_CanAwakenIconEnable(__eClassType_KunoichiOld) == true then
              self._panelControl[self._panelID.ClassResource].name = "\234\176\129\236\132\1773"
            end
          end
          _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. UI\237\142\184\236\167\145 \236\132\156\235\184\140\236\158\144\236\155\144", "\236\161\176\234\180\145\235\175\188")
          slot.close:ComputePos()
        else
          slot.control:SetShow(false)
          if pID ~= nil then
            self._panelControl[pID].isShow = false
          end
        end
      elseif idx == self._panelID.ActionGuide then
        local isCheckSkillCommand = FGlobal_IsChecked_SkillCommand()
        if true == isCheckSkillCommand then
          self:changePanelBGTexture(idx, 2)
        else
          self:changePanelBGTexture(idx, 1)
        end
        slot.close:SetCheck(isCheckSkillCommand)
        self._panelControl[idx].isShow = isCheckSkillCommand
      elseif idx == self._panelID.KeyGuide then
        if true == isChecked_KeyViewer then
          self:changePanelBGTexture(idx, 2)
        else
          self:changePanelBGTexture(idx, 1)
        end
        if true == _ContentsGroup_UsePadSnapping then
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          if pID ~= nil then
            self._panelControl[pID].isShow = false
          end
        else
          slot.control:SetShow(true)
          slot.close:SetShow(true)
          if pID ~= nil then
            self._panelControl[pID].isShow = true
          end
        end
      elseif idx == self._panelID.Adrenallin then
        if getSelfPlayer():isEnableAdrenalin() then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          if pID ~= nil then
            self._panelControl[pID].isShow = not self._isShowRemasterUI
          end
          if true == _ContentsGroup_UseBattleFocusUIModeVer2 and true == self._panelPool[idx].close:IsCheck() then
            self._panelControl[idx].control:SetShow(not self._isShowRemasterUI)
          end
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          if pID ~= nil then
            self._panelControl[pID].isShow = false
          end
        end
      elseif idx == self._panelID.Pvp then
        if isPvpEnable() and true == ToClient_isAdultUser() then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          if pID ~= nil then
            self._panelControl[pID].isShow = not self._isShowRemasterUI
          end
          if true == _ContentsGroup_UseBattleFocusUIModeVer2 and true == self._panelPool[idx].close:IsCheck() then
            self._panelControl[idx].control:SetShow(not self._isShowRemasterUI)
          end
        else
          slot.control:SetShow(false)
          slot.close:SetShow(false)
          if pID ~= nil then
            self._panelControl[idx].isShow = false
          end
        end
      elseif idx == self._panelID.UIMain and true == _ContentsGroup_RenewUI_Main then
        slot.control:SetShow(false)
      end
      if self._panelControl[idx].isShow then
        if self._panelControl[idx].posFixed then
          slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", self._panelControl[idx].name))
        else
          slot.control:SetText(self._panelControl[idx].name)
        end
      elseif 21 == idx then
        slot.control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
      else
        slot.control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", self._panelControl[idx].name))
      end
      local stateValue = 0
      if not self._panelControl[idx].isShow then
        stateValue = 1
      elseif self._panelControl[idx].posFixed then
        stateValue = 3
      else
        stateValue = 2
      end
      self:changePanelBGTexture(idx, stateValue)
      if true == _ContentsGroup_RemasterUI_Main then
        if idx == self._panelID.House or idx == self._panelID.NewEquip or idx == self._panelID.ServantIcon then
          slot.control:SetShow(false)
        elseif idx == self._panelID.ExpGage or idx == self._panelID.HPBar then
          slot.control:SetShow(not self._isShowRemasterUI)
          slot.close:SetShow(not self._isShowRemasterUI)
          if pID ~= nil then
            self._panelControl[pID].isShow = not self._isShowRemasterUI
          end
          if true == _ContentsGroup_UseBattleFocusUIModeVer2 and true == self._panelPool[idx].close:IsCheck() then
            self._panelControl[idx].control:SetShow(not self._isShowRemasterUI)
          end
        elseif idx == self._panelID.MainStatusRemaster then
          slot.control:SetShow(self._isShowRemasterUI)
          slot.close:SetShow(self._isShowRemasterUI)
          if pID ~= nil then
            self._panelControl[pID].isShow = self._isShowRemasterUI
          end
          if true == _ContentsGroup_UseBattleFocusUIModeVer2 and true == self._panelPool[idx].close:IsCheck() then
            self._panelControl[idx].control:SetShow(self._isShowRemasterUI)
          end
        end
      end
    end
  end
end
function PaGlobal_UIModify:changePanelPoolScale(scale)
  local screensizeX = getScreenSizeX()
  local screensizeY = getScreenSizeY()
  for idx = 1, self._panelCount do
    local slot = self._panelPool[idx]
    local parentsPosX = self._cachePosX[idx]
    if nil == parentsPosX then
      parentsPosX = slot.originPosX
    end
    local parentsPosY = self._cachePosY[idx]
    if nil == parentsPosY then
      parentsPosY = slot.originPosY
    end
    local sizeX = self._cacheSizeX[idx]
    if nil == sizeX then
      sizeX = slot.originSizeX
    end
    local sizeY = self._cacheSizeY[idx]
    if nil == sizeY then
      sizeY = slot.originSizeY
    end
    local preScale = self._cachePreScale[idx]
    if nil == preScale then
      preScale = self.preScale
    end
    local rateX = parentsPosX / (screensizeX - sizeX)
    local rateY = parentsPosY / (screensizeY - sizeY)
    slot.control:SetSize(sizeX * (1 / preScale) * scale, sizeY * (1 / preScale) * scale)
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    else
      slot.control:SetPosX(parentsPosX + rateX * sizeX - rateX * slot.control:GetSizeX())
      slot.control:SetPosY(parentsPosY + rateY * sizeY - rateY * slot.control:GetSizeY())
    end
    slot.control:ComputePos()
    slot.close:ComputePos()
  end
end
function PaGlobal_UIModify:changePaneControlScale(scale)
  local screensizeX = getScreenSizeX()
  local screensizeY = getScreenSizeY()
  for idx = 1, self._panelCount do
    local slot = self._panelControl[idx]
    local parentsPosX = self._cachePosX[idx]
    if nil == parentsPosX then
      parentsPosX = slot.originPosX
    end
    local parentsPosY = self._cachePosY[idx]
    if nil == parentsPosY then
      parentsPosY = slot.originPosY
    end
    local sizeX = self._cacheSizeX[idx]
    if nil == sizeX then
      sizeX = slot.originSizeX
    end
    local sizeY = self._cacheSizeY[idx]
    if nil == sizeY then
      sizeY = slot.originSizeY
    end
    local preScale = self._cachePreScale[idx]
    if nil == preScale then
      preScale = self.preScale
    end
    local rateX = parentsPosX / (screensizeX - sizeX)
    local rateY = parentsPosY / (screensizeY - sizeY)
    slot.control:SetSize(sizeX * (1 / preScale) * scale, sizeY * (1 / preScale) * scale)
    if idx == self._panelID.ExpGage then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalTop()
    elseif idx == self._panelID.Radar then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalTop()
      slot.control:SetSpanSize(0, 20)
    elseif idx == self._panelID.GameTip then
      slot.control:SetHorizonLeft()
      slot.control:SetVerticalBottom()
    elseif idx == self._panelID.UIMain then
      slot.control:SetHorizonRight()
      slot.control:SetVerticalBottom()
    else
      slot.control:SetPosX(parentsPosX + rateX * sizeX - rateX * slot.control:GetSizeX())
      slot.control:SetPosY(parentsPosY + rateY * sizeY - rateY * slot.control:GetSizeY())
    end
    slot.control:ComputePos()
    slot.close:ComputePos()
  end
end
function PaGlobal_UIModify:updateModifyPanelSize()
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    self:updateModifyPanelSize_New()
  else
    self:updateModifyPanelSize_Old()
  end
end
function PaGlobal_UIModify:updateModifyPanelSize_Old()
  local isCollapseCkeck = PaGlobal_UIModify._ui.chk_Collapse:IsCheck()
  self._ui.main_BG:SetShow(not isCollapseCkeck)
  self._ui.sub_BG:SetShow(not isCollapseCkeck)
  self._ui.desc_BG:SetShow(not isCollapseCkeck)
  self._ui.btn_save:SetShow(not isCollapseCkeck)
  self._ui.btn_reset:SetShow(not isCollapseCkeck)
  if isCollapseCkeck then
    self._ui.panelBG:SetSize(self._ui.panelBG:GetSizeX(), self._ui.titleBG:GetSizeY())
    Panel_Window_UIModify_All:ComputePos()
  else
    local prevSizeY = self._ui.desc_BG:GetSizeY()
    local deffSizeY = 0
    self._ui.desc_BG:SetSize(self._ui.desc_BG:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
    self._ui.txt_Desc:ComputePos()
    deffSizeY = self._ui.desc_BG:GetSizeY() - prevSizeY
    self._ui.main_BG:SetSize(self._ui.main_BG:GetSizeX(), self._ui.main_BG:GetSizeY() + deffSizeY)
    self._ui.main_BG:ComputePos()
    self._ui.btn_save:SetPosY(self._ui.btn_save:GetPosY() + deffSizeY)
    self._ui.btn_reset:SetPosY(self._ui.btn_reset:GetPosY() + deffSizeY)
    self._ui.panelBG:SetSize(self._ui.panelBG:GetSizeX(), self._ui.main_BG:GetSizeY() + self._ui.titleBG:GetSizeY())
    Panel_Window_UIModify_All:ComputePos()
  end
end
function PaGlobal_UIModify:updateModifyPanelSize_New()
  local isCollapseCkeck = PaGlobal_UIModify._ui.chk_Collapse:IsCheck()
  if true == isCollapseCkeck then
    self._ui.tabGroup:SetShow(false)
    self._ui.main_BG:SetShow(false)
    self._ui.sub_BG:SetShow(false)
    self._ui.desc_BG:SetShow(false)
    self._ui.btn_save:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.chk_useBattleMode:SetShow(false)
    self._ui.panelBG:SetSize(self._ui.panelBG:GetSizeX(), self._ui.titleBG:GetSizeY())
    Panel_Window_UIModify_All:ComputePos()
  elseif true == self._ui.rdo_normal:IsCheck() then
    self:selectNormalTab()
  else
    self:selectBattleTab()
  end
end
function PaGlobal_UIModify:showCollapseTooltip()
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_UIMODIFYCOLLAPSE_TOOLTIP_DESC")
  TooltipSimple_Show(self._ui.chk_Collapse, "", desc)
end
function PaGlobal_UIModify:applyPresetInfoWithChat(presetIndex)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if ToClient_getGameUIManagerWrapper():isPresetListEmpty(presetIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_NOPRESET"))
    return
  end
  local isSetRemasterUI = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex))
  self._prevRemasterUI = self._isShowRemasterUI
  self._isShowRemasterUI = isSetRemasterUI
  local swapRadarPreset = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(self:getLuaCacheDataIndexSwapRadar(presetIndex))
  local currentswapRadar = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eRadarSwap)
  if swapRadarPreset ~= currentswapRadar then
    PaGlobal_changeRadarUI()
    FGlobal_ResetTimeBar()
  end
  for idx = 1, self._panelCount do
    local chatWindowIndex = 0
    local panelIndex = self._panelControl[idx].PAGameUIType
    local isChatPanel = false
    if idx >= self._panelID.Chat0 and idx <= self._panelID.Chat4 then
      chatWindowIndex = idx - self._panelID.Chat0
      isChatPanel = true
    end
    local info = ToClient_getPAUIPanelInfo(presetIndex, panelIndex, chatWindowIndex)
    if nil ~= info then
      local pos = info:getPosition()
      local isShow = info:isShow()
      if true == isChatPanel and presetIndex == __eUISetting_BattlePreset then
        isShow = false
      end
      if idx == self._panelID.Party then
        local partyNo = ToClient_GetPartyNo()
        if 0 == partyNo then
          isShow = false
        else
          isShow = true
        end
      end
      local relativePos = info:getRelativePosition()
      self:getUiSettingPanelInfo(idx, pos.x, pos.y, isShow, chatWindowIndex, relativePos.x, relativePos.y)
    end
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(self:getLuaCacheDataIndex(presetIndex), self._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  self:scaleSet()
  self:update()
end
function PaGlobal_UIModify:selectNormalTab()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  self._ui.rdo_normal:SetCheck(true)
  self._ui.rdo_battle:SetCheck(false)
  local addPosX = (self._ui.rdo_normal:GetSizeX() - self._ui.stc_selectLine:GetSizeX()) / 2
  self._ui.stc_selectLine:SetPosX(self._ui.rdo_normal:GetPosX() + addPosX)
  self._ui.tabGroup:SetShow(true)
  self._ui.main_BG:SetShow(true)
  self._ui.sub_BG:SetShow(true)
  self._ui.desc_BG:SetShow(true)
  self._ui.btn_save:SetShow(true)
  self._ui.btn_reset:SetShow(true)
  self._ui.chk_useBattleMode:SetShow(true)
  self._ui.slider_UI_Scale:SetShow(true)
  self._ui.btn_Scale:SetShow(true)
  self._ui.txt_UISize:SetShow(true)
  self._ui.txt_UI_LOW:SetShow(true)
  self._ui.txt_UI_HIGH:SetShow(true)
  self:computePosition(false)
  if true == self._isNormalTab and nil ~= PaGlobalFunc_Save_ChattingPanel then
    PaGlobalFunc_Save_ChattingPanel()
  end
  self:applyPresetInfo(__eUISetting_Revert, false)
  self._isNormalTab = true
end
function PaGlobal_UIModify:selectBattleTab()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  self._ui.rdo_normal:SetCheck(false)
  self._ui.rdo_battle:SetCheck(true)
  local addPosX = (self._ui.rdo_battle:GetSizeX() - self._ui.stc_selectLine:GetSizeX()) / 2
  self._ui.stc_selectLine:SetPosX(self._ui.rdo_battle:GetPosX() + addPosX)
  self._ui.tabGroup:SetShow(true)
  self._ui.main_BG:SetShow(false)
  self._ui.sub_BG:SetShow(true)
  self._ui.desc_BG:SetShow(false)
  self._ui.btn_save:SetShow(true)
  self._ui.btn_reset:SetShow(true)
  self._ui.chk_useBattleMode:SetShow(true)
  self._ui.slider_UI_Scale:SetShow(false)
  self._ui.btn_Scale:SetShow(false)
  self._ui.txt_UISize:SetShow(false)
  self._ui.txt_UI_LOW:SetShow(false)
  self._ui.txt_UI_HIGH:SetShow(false)
  self:computePosition(true)
  self:applyPresetInfo(__eUISetting_BattlePreset, false)
  self._isNormalTab = false
end
function PaGlobal_UIModify:ControlSetShowPanel(idx, isShow)
  if isShow == false then
    PaGlobal_UIModify._panelControl[idx].isShow = false
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(false)
    PaGlobal_UIModify:changePanelBGTexture(idx, 1)
    if 21 == idx then
      PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
    else
      PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", PaGlobal_UIModify._panelControl[idx].name))
    end
  else
    PaGlobal_UIModify._panelControl[idx].isShow = true
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(true)
    if PaGlobal_UIModify._panelControl[idx].posFixed then
      PaGlobal_UIModify:changePanelBGTexture(idx, 3)
    else
      PaGlobal_UIModify:changePanelBGTexture(idx, 2)
    end
    if PaGlobal_UIModify._panelControl[idx].posFixed then
      PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", PaGlobal_UIModify._panelControl[idx].name))
    else
      PaGlobal_UIModify._panelPool[idx].control:SetText(PaGlobal_UIModify._panelControl[idx].name)
    end
  end
end
function PaGlobal_UIModify:computePosition(isBattleTab)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  local controlList = {
    [1] = {
      self._ui.titleBG,
      0
    },
    [2] = {
      self._ui.tabGroup,
      0
    },
    [3] = {
      self._ui.main_BG,
      0
    },
    [4] = {
      self._ui.sub_BG,
      0
    },
    [5] = {
      self._ui.desc_BG,
      0
    },
    [6] = {
      self._ui.chk_useBattleMode,
      10
    },
    [7] = {
      self._ui.btn_save,
      10
    }
  }
  local panelSizeX = Panel_Window_UIModify_All:GetSizeX()
  local panelSizeY = 0
  local panelGap = 0
  local interFaceSize = 0
  if true == isBattleTab then
    panelGap = 145
    interFaceSize = 90
  end
  for ii = 1, #controlList do
    local info = controlList[ii]
    local control = info[1]
    local add = info[2]
    if true == control:GetShow() then
      control:SetPosY(panelSizeY - panelGap)
      if ii == 4 then
        panelSizeY = panelSizeY + control:GetSizeY() + add - interFaceSize
      else
        panelSizeY = panelSizeY + control:GetSizeY() + add
      end
    end
  end
  self._ui.chk_remsaterUI:SetPosY(self._subControlPosY.chk_remsaterUI - interFaceSize)
  self._ui.chk_FieldView:SetPosY(self._subControlPosY.chk_FieldView - interFaceSize)
  self._ui.chk_QuickSlotMagnetic:SetPosY(self._subControlPosY.chk_QuickSlotMagnetic - interFaceSize)
  self._ui.chk_GridView:SetPosY(self._subControlPosY.chk_GridView - interFaceSize)
  self._ui.btn_reset:SetPosY(self._ui.btn_save:GetPosY())
  self._ui.panelBG:SetSize(panelSizeX, panelSizeY)
  self._ui.panelBG:SetPosY(-panelGap)
  Panel_Window_UIModify_All:SetSize(panelSizeX, panelSizeY)
end
function PaGlobal_UIModify:checkBattleMode()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
end
function PaGlobal_UIModify:saveBattlePresetWithChange(scale)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if true == UI.checkResolution4KForXBox() then
    _cacheScale = 2
  end
  setUIScale(_cacheScale)
  self:applyPresetInfo(__eUISetting_BattlePreset)
  if true == UI.checkResolution4KForXBox() then
    scale = 2
  end
  setUIScale(scale)
  self:savePresetInfoByPanelControl(__eUISetting_BattlePreset, false)
  self:applyPresetInfo(__eUISetting_Revert)
end
