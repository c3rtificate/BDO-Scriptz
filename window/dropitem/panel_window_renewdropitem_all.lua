PaGlobal_RenewDropItem_All = {
  _ui = {
    _stc_titleName = nil,
    _stc_mainCategoryArea = nil,
    _stc_mainCategoryUnderLine = nil,
    _stc_subCategoryArea = nil,
    _btn_subCategoryTemplate = nil,
    _stc_keyGuide_LT = nil,
    _stc_keyGuide_RT = nil,
    _stc_huntingGroundList = nil,
    _edt_searchEditBox = nil,
    _btn_searchResultClear = nil,
    _stc_searchIcon = nil,
    _cbx_sortOption = nil,
    _stc_sortOptionList = nil,
    _stc_tagArea = nil,
    _stc_mainArea = nil,
    _btn_navi = nil,
    _btn_adventure = nil,
    _txt_huntingGroundName = nil,
    _txt_needAP = nil,
    _txt_needDP = nil,
    _txt_myAP = nil,
    _txt_myAwakenAP = nil,
    _txt_myDP = nil,
    _stc_myDPIcon = nil,
    _txt_dropRate = nil,
    _chk_detailInfo = nil,
    _txt_infoText = nil,
    _frm_dropInfo = nil,
    _frameConent_dropInfo = nil,
    _frameVerticalScroll = nil,
    _stc_dropEquipItemGroup = nil,
    _stc_dropEtcItemGroup = nil,
    _stc_repeatQuestGroup = nil,
    _stc_suddenQuestGroup = nil,
    _stc_knowledgeThemeGroup = nil,
    _stc_titleGroup = nil,
    _stc_keyGuideArea = nil
  },
  _slotConfig = {createIcon = true, createBorder = true},
  _eSEARCH_TYPE = {TEXT = 0, TAG = 1},
  _mainCategoryDataList = nil,
  _subCategoryDataList = nil,
  _tagIconList = nil,
  _dropEquipableItemIconList = nil,
  _dropEtcItemIconList = nil,
  _dropRepeatQuestIconList = nil,
  _dropSuddenQuestIconList = nil,
  _dropKnowledgeIconList = nil,
  _dropTitleIconList = nil,
  _currentMainCategoryKey = nil,
  _currentSubCategoryKey = nil,
  _currentHuntingGroundKey = nil,
  _originalMainAreaPosY = nil,
  _originalMainAreaSizeY = nil,
  _originalFrameSizeY = nil,
  _originalRegionNameSizeX = nil,
  _originalRegionContentNameSizeX = nil,
  _searchResultTable = nil,
  _questLoadingDataList = nil,
  _lastSnapItemInfo = {
    _huntingGroundKeyRaw = nil,
    _dropItemIndex = nil,
    _iconIndex = nil
  },
  _isResetPadSnap = false,
  _isWorldMapOpen = false,
  _isConsole = nil,
  _initialize = nil
}
runLua("UI_Data/Script/Window/DropItem/Panel_Window_RenewDropItem_All_1.lua")
runLua("UI_Data/Script/Window/DropItem/Panel_Window_RenewDropItem_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Init_RenewDropItem_All")
function FromClient_Init_RenewDropItem_All()
  PaGlobal_RenewDropItem_All:initialize()
end
