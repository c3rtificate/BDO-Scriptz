PaGlobal_GuildWarfareNew_All = {
  _ui = {
    stc_SelectBG = nil,
    txt_WarType = nil,
    txt_Region = nil,
    txt_Result = nil,
    btn_Refresh = nil,
    stc_TopBG = nil,
    txt_CharName = nil,
    stc_CommadCenter = nil,
    stc_Tower = nil,
    stc_Summons = nil,
    stc_CastleGate = nil,
    stc_Installation = nil,
    stc_Member = nil,
    stc_Death = nil,
    txt_Sort = nil,
    list_history = nil,
    btn_history = nil,
    stc_MainBG = nil,
    stc_LeftArea = nil,
    list2_Warfare = nil
  },
  ENUM_SIEGE_RECORD_COMBOBOX_STATE = {
    NOTPROGRESSING_NODATA_NOLAST = 0,
    NOTPROGRESSING_NODATA = 1,
    NOTPROGRESSING_DATA_NOLAST = 2,
    NOTPROGRESSING_DATA_LAST = 3,
    PROGRESSING_NOLAST = 4,
    PROGRESSING_LAST = 5
  },
  _icons = {},
  _personalDataList = {},
  _personalDataListSize = 0,
  _isListDescSort = {},
  _selectedSortType = -1,
  _isFirstOpenTab = true,
  _currentSiegeHistoryState = 0,
  _scrollData = {_pos = nil, _idx = nil},
  _initialize = false,
  _isConsole = false,
  _dayStringList = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY_COLOR"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY_COLOR"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY_COLOR"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY_COLOR"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY_COLOR"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY_COLOR"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY_COLOR")
  },
  _type = {
    eJustToday = 0,
    eProgressing = 1,
    eHistory = 2,
    eRequestHistory = 3
  },
  _listData = {},
  _listDataSize = 0,
  _currentHistoryListIndex = -1
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfareNew_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfareNew_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarfareNew_All_Init")
function FromClient_GuildWarfareNew_All_Init()
  PaGlobal_GuildWarfareNew_All:initialize()
end
