PaGlobal_Quest_All = {
  _ui = {
    stc_titleBg = nil,
    stc_contentBg = nil,
    stc_radioButtonGroup = nil,
    radio_progressing = nil,
    radio_main = nil,
    radio_recommend = nil,
    radio_repeat = nil,
    radio_new = nil,
    stc_selectBar = nil,
    stc_groupTypeBG = nil,
    txt_questCnt = nil,
    radio_questType = nil,
    radio_questTerritory = nil,
    chk_emptyGroupHide = nil,
    stc_groupFilterBg = nil,
    chk_complteHide = nil,
    btn_questBranch = nil,
    stc_eff_complete0 = nil,
    stc_eff_complete1 = nil,
    _listGroup = {},
    _listTemplate = {},
    _listScroll = {},
    stc_favorTypeBg = nil,
    txt_favorType = nil,
    _favorType = {},
    stc_DoneQuestBg = nil,
    txt_DoneQuest = nil,
    stc_DoneDescCH = nil
  },
  _ui_pc = {
    btn_question = nil,
    chk_popUp = nil,
    btn_close = nil
  },
  _ui_console = {
    stc_menuGuideLB = nil,
    stc_menuGuideRB = nil,
    stc_keyGuideBG = nil,
    stc_guideSortType = nil,
    stc_guideHideEmpty = nil,
    stc_guideSelect = nil,
    stc_guideClose = nil,
    stc_guidePreferRT = nil,
    stc_guidePreferPlus = nil,
    stc_guidePreferY = nil,
    _focusMenu = {}
  },
  _regionString = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_99"),
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_1"),
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_2"),
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_3"),
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_4"),
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_5"),
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_6"),
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_7"),
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_8"),
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_9"),
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_10"),
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_11"),
    [CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_12"),
    [CppEnums.QuestRegionType.eQuestRegionType_AbyssOne] = PAGetString(Defines.StringSheet_GAME, "LUA_ABYSSONE_MSG_SERVERSELECT_TITLE"),
    [CppEnums.QuestRegionType.eQuestRegionType_MorningLand] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_13"),
    [CppEnums.QuestRegionType.eQeustRegionType_Ulukita] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_14")
  },
  _regionOpen = {
    [CppEnums.QuestRegionType.eQuestRegionType_None] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Balenos] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Serendia] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Keplan] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Media] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Valencia] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Drigan] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Odilita] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_AbyssOne] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_MorningLand] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQeustRegionType_Ulukita] = {isOpen = true, isLoading = false},
    [CppEnums.QuestRegionType.eQuestRegionType_Count] = {isOpen = false, isLoading = false}
  },
  _typeString = {
    [__eQuestType_BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_1"),
    [__eQuestType_Main] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_2"),
    [__eQuestType_Sub] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_3"),
    [__eQuestType_Repeat] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_4"),
    [__eQuestType_Adventure] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_5"),
    [__eQuestType_BaseLife] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_6"),
    [__eQuestType_OceanLife] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_7"),
    [__eQuestType_CraftLife] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_8"),
    [__eQuestType_Contents] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_9"),
    [__eQuestType_Event] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_10"),
    [__eQuestType_Guild] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_11"),
    [__eQuestType_DirectAccept] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_12"),
    [__eQuestType_Sudden] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_13"),
    [__eQuestType_SeasonPass] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_14"),
    [__eQuestType_GrowthPass] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_15"),
    [__eQuestType_DirectClear] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_16"),
    [__eQuestType_Journal] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_TYPE_17")
  },
  _typeOpen = {
    [__eQuestType_BlackSpirit] = {isOpen = true, isLoading = false},
    [__eQuestType_Main] = {isOpen = true, isLoading = false},
    [__eQuestType_Sub] = {isOpen = true, isLoading = false},
    [__eQuestType_Repeat] = {isOpen = true, isLoading = false},
    [__eQuestType_Adventure] = {isOpen = true, isLoading = false},
    [__eQuestType_BaseLife] = {isOpen = true, isLoading = false},
    [__eQuestType_OceanLife] = {isOpen = true, isLoading = false},
    [__eQuestType_CraftLife] = {isOpen = true, isLoading = false},
    [__eQuestType_Contents] = {isOpen = true, isLoading = false},
    [__eQuestType_Event] = {isOpen = true, isLoading = false},
    [__eQuestType_Guild] = {isOpen = false, isLoading = false},
    [__eQuestType_DirectAccept] = {isOpen = false, isLoading = false},
    [__eQuestType_Sudden] = {isOpen = false, isLoading = false},
    [__eQuestType_SeasonPass] = {isOpen = false, isLoading = false},
    [__eQuestType_GrowthPass] = {isOpen = false, isLoading = false},
    [__eQuestType_DirectClear] = {isOpen = false, isLoading = false},
    [__eQuestType_Journal] = {isOpen = false, isLoading = false}
  },
  _isContentsEnableMedia = ToClient_IsContentsGroupOpen("3"),
  _isContentsEnableValencia = ToClient_IsContentsGroupOpen("4"),
  _isContentsEnableKamasilvia = ToClient_IsContentsGroupOpen("5"),
  _isContentsEnableDragan = ToClient_IsContentsGroupOpen("6"),
  _TABTYPE = {
    PROGRESS = 1,
    MAIN = 2,
    RECOMMEND = 3,
    REPEAT = 4,
    NEW = 5,
    COUNT = 6
  },
  _config = {checkFavorTypeLv = 56, slotMaxCount = 11},
  _uiPool = {
    questFavorType = {},
    groupTitle = {},
    listMain = {}
  },
  _selectWay = {
    groupID = "",
    questID = "",
    isAuto = false
  },
  _radioTabs = {},
  _currentTab = nil,
  _progressQuestCount = 0,
  _startSlotIndex = 1,
  _listCount = 0,
  _useArray = {},
  _questSortArrayRegion = {},
  _questArrayRegionCount = {},
  _questArrayRegionProgressCount = {},
  _questArrayRegionSort = {
    [0] = CppEnums.QuestRegionType.eQuestRegionType_Balenos,
    [1] = CppEnums.QuestRegionType.eQuestRegionType_Serendia,
    [2] = CppEnums.QuestRegionType.eQuestRegionType_NorthCalpheon,
    [3] = CppEnums.QuestRegionType.eQuestRegionType_CalpheonBigCity,
    [4] = CppEnums.QuestRegionType.eQuestRegionType_Keplan,
    [5] = CppEnums.QuestRegionType.eQuestRegionType_SouthWestCalpheon,
    [6] = CppEnums.QuestRegionType.eQuestRegionType_Media,
    [7] = CppEnums.QuestRegionType.eQuestRegionType_Valencia,
    [8] = CppEnums.QuestRegionType.eQuestRegionType_Kamasylvia,
    [9] = CppEnums.QuestRegionType.eQuestRegionType_Drigan,
    [10] = CppEnums.QuestRegionType.eQuestRegionType_Odilita,
    [11] = CppEnums.QuestRegionType.eQuestRegionType_MountainOfEternalWinter,
    [12] = CppEnums.QuestRegionType.eQuestRegionType_AbyssOne,
    [13] = CppEnums.QuestRegionType.eQuestRegionType_MorningLand,
    [14] = CppEnums.QuestRegionType.eQeustRegionType_Ulukita,
    [15] = CppEnums.QuestRegionType.eQuestRegionType_None
  },
  _questSortArrayType = {},
  _questArrayTypeCount = {},
  _questArrayTypeProgressCount = {},
  _questSelectTypeString = {
    [__eQuestSelectType_Main] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_1"),
    [__eQuestSelectType_BlackSpirit] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_2"),
    [__eQuestSelectType_Sub] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_3"),
    [__eQuestSelectType_Adventure] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_4"),
    [__eQuestSelectType_Life] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_5"),
    [__eQuestSelectType_Contents] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_6"),
    [__eQuestSelectType_Event] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_7"),
    [__eQuestSelectType_Etc] = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_QUESTSELECTTYPE_TXT_TYPE_8")
  },
  _groupOpen = {
    _recommendation = {},
    _repetitive = {},
    _main = {},
    _new = {}
  },
  _questLoadingDataList = nil,
  _progessQuestLoadingGroup = nil,
  _questArrayGroupCount = {},
  _questArrayGroupCompleteCount = {},
  _selectQuestInfo = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_2.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Quest_All_Init")
function FromClient_Quest_All_Init()
  PaGlobal_Quest_All:initialize()
end
