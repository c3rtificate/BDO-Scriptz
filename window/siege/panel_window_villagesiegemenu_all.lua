PaGlobal_VillageSiegeMenu = {
  _ui = {
    _btn_close = nil,
    _rdo_applyParticipation = nil,
    _rdo_listParticipation = nil,
    _stc_tabSelectLine = nil,
    _stc_mapBg = nil,
    _txt_weekTitle = nil,
    _stc_balenosIcon = nil,
    _stc_serendiaIcon = nil,
    _stc_calpheonIcon = nil,
    _stc_kamasylviaIcon = nil,
    _stc_mediaIcon = nil,
    _stc_valenciaIcon = nil,
    _txt_notice = nil,
    _stc_applyResult = nil,
    _stc_applyResultTerritory = nil,
    _txt_applyResultMaxCount = nil,
    _txt_applyResultLimit = nil,
    _btn_applyResultOtherGuild = nil,
    _btn_startSiegeForQA = nil,
    _btn_stopSiegeForQA = nil,
    _btn_resetApplyCountForQA = nil,
    _btn_resetApplyCountAllForQA = nil,
    _btn_changeSiegeApplyNeedCountForQA = nil,
    _stc_guildListBg = nil,
    _stc_topDateBg = nil,
    _txt_topDate = nil,
    _txt_topDateDay = nil,
    _stc_contentBg = nil,
    _stc_noData = nil,
    _frm_listApply = nil,
    _stc_applyGroupTemplate = nil,
    _stc_applyGuildTemplate = nil,
    _stc_keyGuideBg = nil,
    _stc_keyGuideLB = nil,
    _stc_keyGuideRB = nil
  },
  _eTabType = {APPLY = 0, APPLY_LIST = 1},
  _eTerritoryGroupType = {
    BEGINNER = 0,
    ADVANCED = 1,
    INTERMEDIATE = 2,
    COUNT = 3
  },
  _eTerritoryKeyRaw = {
    BALENOS = 0,
    SERENDIA = 1,
    CALPHEON = 2,
    MEDIA = 3,
    VALENCIA = 4,
    KAMASYLVIA = 6
  },
  _territoryGroupList = nil,
  _territoryParticipationList = nil,
  _currentTabType = nil,
  _applyGroupDataList = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Siege/Panel_Window_VillageSiegeMenu_All_1.lua")
runLua("UI_Data/Script/Window/Siege/Panel_Window_VillageSiegeMenu_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_VillageSiegeMenuInit")
function FromClient_VillageSiegeMenuInit()
  PaGlobal_VillageSiegeMenu:initialize()
end
