PaGlobal_AlchemyStone_All = {
  _ui = {
    stc_titleBg = nil,
    stc_radioGroup = nil,
    radio_Charge = nil,
    radio_Exp = nil,
    radio_Upgrade = nil,
    stc_radioSelectBar = nil,
    stc_guideBg = nil,
    txt_guideNormal = nil,
    txt_guideSuccess = nil,
    txt_guideFail = nil,
    txt_needMetarial = nil,
    stc_descDetailBg = nil,
    txt_descDetail = nil,
    stc_ContentTypeEffect = nil,
    stc_KeyGuideLB = nil,
    stc_KeyGuideRB = nil,
    chk_skipAni = nil,
    _recharge = {
      stc_rechargeBg = nil,
      stc_slotLeftBg = nil,
      stc_slotLeft = nil,
      stc_slotRight = nil,
      txt_chargeDesc = nil,
      txt_needCount = nil,
      stc_gaugeEnduranceBg = nil,
      progress_preEndurance = nil,
      progress_curEndurance = nil,
      txt_endurance = nil,
      stc_gaugeExpBg = nil,
      progress_preExp = nil,
      progress_curExp = nil,
      txt_expTitle = nil,
      txt_expValue = nil,
      txt_materialName = nil
    },
    _growth = {
      stc_growthBg = nil,
      stc_slotBg_1 = nil,
      stc_slotItemBG = nil,
      stc_slot_1 = nil,
      stc_slot_2 = nil,
      stc_slotResultBG = nil,
      stc_slotBg_3 = nil,
      stc_slot_3 = nil,
      txt_fail = nil,
      txt_success = nil
    }
  },
  _ui_pc = {
    btn_close = nil,
    btn_help = nil,
    stc_doitBg = nil,
    btn_apply = nil
  },
  _ui_console = {
    stc_consoleGuideBg = nil,
    stc_guideIconY = nil,
    stc_guideIconX = nil,
    stc_guideIconA = nil,
    stc_guideIconB = nil
  },
  _TAB_TYPE = {
    CHARGE = 1,
    EXP = 2,
    UPGRADE = 3
  },
  _DESC_TYPE = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_INFO")
  },
  _GUIDETEXT = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_CHARGE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_EXP"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_SELECT_UPGRADE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_SELECT_MATERIAL")
  },
  _READYTEXT = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_CHARGE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_EXP"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DOIT_UPGRADE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_READY")
  },
  _guideText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXP"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_BREAK_TITLE")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _SLOT_TYPE = {
    STONE = 0,
    MAT = 1,
    BLACKSTONE = 2
  },
  _resultSlot = {},
  _resultSlotBg = {},
  _radioTabs = {},
  _rechargeSlot = {
    [0] = {},
    [1] = {}
  },
  _growthSlot = {
    [0] = {},
    [1] = {}
  },
  _toWhereType = -1,
  _toSlotNo = -1,
  _selectedTabIdx = 0,
  _selectedStoneType = 0,
  _selectedStoneItemKey = nil,
  _fromWhereType = -1,
  _fromSlotNo = -1,
  _fromCount = toInt64(0, -1),
  _fromMaxCount = toInt64(0, -1),
  _recoverCount = 0,
  _currentEndurance = 0,
  _maxEndurance = 0,
  _toLostEndurance = 0,
  _maxRecoverCount = 0,
  _chargePoint = 0,
  _isPushDoit = false,
  _skipEffect = false,
  _startEffectPlay = false,
  _contentEffectPlay = false,
  _slotEffectPlay = false,
  _effectEnd = false,
  _resultItemIndex = -1,
  _resultMsg = {},
  _resultItemKey = {},
  _elapsTime = 0,
  _isUpgrade = false,
  _panel_OriginSizeY = 0,
  _panel_OriginPosY = 0,
  _descDetailBg_OriginPosY = 0,
  _descDetailBg_OriginSizeY = 0,
  _descDetail_OriginPosY = 0,
  _upgradeSlotBg_OriginPosY = 0,
  _upgradeSlotBg_OriginSizeY = 0,
  _doitBg_OriginPosY = 0,
  _doitBg_OriginSizeY = 0,
  _currentSlotType = -1,
  _isStoneEmpty = true,
  _isMatEmpty = true,
  _selectTabType = 1,
  _preTabType = 1,
  _DIRECTION = {BUTTON_RB = 0, BUTTON_LB = 1},
  _gGuideBg_OriginPosY = nil,
  _guideIconY_OriginPosX = nil,
  _guideIconA_OriginPosX = nil,
  _isTooltipShow = false,
  _blackStonSlotNo = nil,
  _isConsole = false,
  _initialize = false,
  _elapsedCenterEffectTime = 0
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AlchemyStone_All_Init")
function FromClient_AlchemyStone_All_Init()
  PaGlobal_AlchemyStone_All:initialize()
end
