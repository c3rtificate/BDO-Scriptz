PaGlobal_GrowthPass = {
  _ui = {
    _stc_titleArea = UI.getChildControl(Panel_Window_GrowthPass, "Static_TitleArea"),
    _stc_mainTabTypeBG = UI.getChildControl(Panel_Window_GrowthPass, "Static_MainTabTypeBg"),
    _stc_categoryReward = UI.getChildControl(Panel_Window_GrowthPass, "Static_Category_Reward"),
    _frame_mainBG = UI.getChildControl(Panel_Window_GrowthPass, "Frame_Main_BG"),
    _stc_startBG = UI.getChildControl(Panel_Window_GrowthPass, "Static_Start_BG"),
    _stc_totalRewardBG = UI.getChildControl(Panel_Window_GrowthPass, "Static_TotalReward_BG"),
    _stc_questLoading_icon = nil,
    _stc_questLoading_texture = nil,
    _stc_questLoading_desc = nil,
    _frame_totalRewardBG = nil,
    _frame_totalRewardContent = nil,
    _btn_startOnIntroScreen = nil,
    _stc_keyguideBG = nil
  },
  _isPadMode = false,
  _isConsole = false,
  _consoleUi = {
    _stc_keyguideArea = UI.getChildControl(Panel_Window_GrowthPass, "Static_KeyGuide_ConsoleUI_Import"),
    _txt_keyguide_Y = nil,
    _txt_keyguide_B = nil,
    _txt_keyguide_A = nil,
    _txt_keyguide_X = nil,
    _txt_keyguide_LT = nil,
    _txt_keyguide_DPad_Vertical = nil,
    _txt_keyguide_DPad_Horizon = nil,
    _txt_keyguide_RS = nil,
    _txt_keyguide_LC = nil,
    _txt_keyguide_RC = nil
  },
  _linkType = {
    GUIDE = 1,
    MARKET = 2,
    QUEST = 3,
    MANUFACTURE = 4
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _questLoadingDataList = nil,
  _animationFrame = 999,
  _layout_gapX = 40,
  _layout_gapY_Top = 15,
  _layout_gapY_Bottom = 40,
  _totalReward_gapX = 80,
  _categoryRewardCount = 5,
  _currentSelectedCategoryIndex = 0,
  _categoryCount = 0,
  _isScrollShadowMode_Category = false,
  _isScrollShadowMode_TotalReward = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_1.lua")
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GrowthPassInit")
function FromClient_GrowthPassInit()
  PaGlobal_GrowthPass:initialize()
end
