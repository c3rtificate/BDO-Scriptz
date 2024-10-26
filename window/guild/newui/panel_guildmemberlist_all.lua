PaGlobal_GuildMemberList_All = {
  _ui = {
    stc_listTitleBg = nil,
    _title = {
      txt_grade = nil,
      txt_level = nil,
      txt_class = nil,
      txt_name = nil,
      txt_activity = nil,
      txt_contribute = nil,
      txt_voice = nil,
      txt_warGrade = nil,
      txt_contract = nil
    },
    stc_listAreaBg = nil,
    frame_list = nil,
    frame_content = nil,
    stc_listMember = nil,
    btn_contract = nil,
    btn_document = nil,
    btn_approval = nil,
    stc_voiceListen = nil,
    stc_voiceTalk = nil,
    txt_contribute = nil,
    txt_activity = nil,
    txt_name = nil,
    txt_class = nil,
    txt_level = nil,
    stc_grade = nil,
    stc_guard = nil,
    btn_warGrade = nil,
    btn_warState = nil,
    scroll_vs = nil,
    scroll_vsCtrl = nil,
    stc_bottomAreaBg = nil,
    stc_guildFundBg = nil,
    txt_guildFund = nil,
    btn_guildFund = nil,
    btn_getFund = nil,
    btn_deposit = nil,
    btn_warReward = nil,
    btn_guildFundManage = nil,
    btn_guildPoint = nil,
    _titlelist = {},
    _memberlist = {},
    _buttonlist = {},
    _gradelist = {}
  },
  _ui_pc = {
    stc_funcBg = nil,
    stc_funcGradeBg = nil,
    btn_func = nil,
    stc_setVolumBg = nil,
    slider_listenVol = nil,
    slider_listenVolBtn = nil,
    chk_icon = nil,
    txt_volumVal = nil,
    btn_setVolumClose = nil
  },
  _ui_console = {},
  _config = {
    listMaxCount = 150,
    collectionY = 90,
    collectionX = 45,
    voiceBgY = 110,
    gradeSpanX = 0
  },
  _contentOpen = {
    voice = false,
    warGrade = true,
    newSiegeRule = true
  },
  _MenuButtonType = {
    WHISPER = 0,
    APPOINT_ADVISER = 1,
    APPOINT_CHIEFOFSTAFF = 2,
    APPOINT_SCRIBE = 3,
    APPOINT_COMMANDER = 4,
    APPOINT_GUNNER = 5,
    SUPPLY = 6,
    APPOINT_MISSIONOFFICER = 7,
    CANCLE_APPOINT = 8,
    CHANGE_MASTER = 9,
    PRICELIMIT = 10,
    PROTECT_MEMBER = 11,
    CANCLE_PROTECT_MEMBER = 12,
    PARTY_INVITE = 13,
    LARGEPARTY_INVITE = 14,
    DEPORTATION = 15,
    COUNT = 16
  },
  _MenuButtonStr = {
    [0] = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WHISPER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDADVISER"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_CHIEFOFSTAFF"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_SCRIBE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_2"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDGUNNER"),
    [6] = PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON7"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_MISSIONOFFICER"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_3"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_0"),
    [10] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_USEGUILDFUNDS_TITLE"),
    [11] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_4"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_5"),
    [13] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_6"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_1")
  },
  _MenuButtonRightType = {
    [0] = nil,
    [1] = __eGuildRightType_ChangeMemberGrade,
    [2] = __eGuildRightType_ChangeMemberGrade,
    [3] = __eGuildRightType_ChangeMemberGrade,
    [4] = __eGuildRightType_ChangeMemberGrade,
    [5] = __eGuildRightType_ChangeMemberGrade,
    [6] = __eGuildRightType_ChangeMemberGrade,
    [7] = __eGuildRightType_ChangeMemberGrade,
    [8] = __eGuildRightType_ChangeMemberGrade,
    [9] = __eGuildRightType_ChangeMemberGrade,
    [10] = __eGuildRightType_SetMemberLimitPrice,
    [11] = __eGuildRightType_SetProtectMember,
    [12] = __eGuildRightType_SetProtectMember,
    [13] = nil,
    [14] = nil,
    [15] = __eGuildRightType_Expel
  },
  _MenuButtonTypeNew = {
    WHISPER = 0,
    CHANGE_GRADE = 1,
    PRICELIMIT = 2,
    PROTECT_MEMBER = 3,
    CANCLE_PROTECT_MEMBER = 4,
    PARTY_INVITE = 5,
    LARGEPARTY_INVITE = 6,
    AUTHORITY = 7,
    DEPORTATION = 8,
    COUNT = 9
  },
  _MenuButtonStrNew = {
    [0] = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WHISPER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_RIGHT_CHANGE"),
    [2] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_USEGUILDFUNDS_TITLE"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_4"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_5"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_6"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_AUTHORITY"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_1")
  },
  _MenuButtonRightNew = {
    [0] = nil,
    [1] = __eGuildRightNew_ChangeMemberGrade,
    [2] = __eGuildRightNew_SetMemberLimitPrice,
    [3] = __eGuildRightNew_ProtectMember,
    [4] = __eGuildRightNew_ProtectMember,
    [5] = nil,
    [6] = nil,
    [7] = __eGuildRightNew_ChangeMemberRight,
    [8] = __eGuildRightNew_Expel
  },
  _GradeButtonType = {
    APPOINT_ADVISER = 0,
    APPOINT_CHIEFOFSTAFF = 1,
    APPOINT_SCRIBE = 2,
    APPOINT_COMMANDER = 3,
    APPOINT_GUNNER = 4,
    SUPPLY = 5,
    APPOINT_MISSIONOFFICER = 6,
    CANCLE_APPOINT = 7,
    CHANGE_MASTER = 8,
    COUNT = 9
  },
  _GradeButtonStr = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDADVISER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_CHIEFOFSTAFF"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_SCRIBE"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_2"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDGUNNER"),
    [5] = PAGetString(Defines.StringSheet_GAME, "GULD_BUTTON7"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_MISSIONOFFICER"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_3"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_BUTTONLIST_TEXT_0")
  },
  _SortType = {
    GRADE = 0,
    LEVEL = 1,
    CLASS = 2,
    NAME = 3,
    APOINT = 4,
    CONTACT = 5,
    WPOINT = 6,
    WGRADE = 7,
    VOICE = 8,
    COUNT = 9
  },
  _listSort = {
    [0] = false,
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = nil
  },
  _GuildGrade = {
    CLAN = CppEnums.GuildGrade.GuildGrade_Clan,
    GUILD = CppEnums.GuildGrade.GuildGrade_Guild
  },
  _ContractType = {
    recontactable = 0,
    contacting = 1,
    expiration = 2
  },
  _siegeGradeCount = {
    grade1 = 0,
    grade2 = 0,
    grade3 = 0,
    grade4 = 0,
    grade5 = 0
  },
  _memberlistData = {},
  _memberUserNolist = {},
  _sortingFunc = {},
  _menuButtonSize = {},
  _selectIndex = 0,
  _selectSortType = -1,
  _selectUserNo = -1,
  _myGuildIndex = nil,
  _inputGuildDepositNum_s64 = toInt64(0, 0),
  _inputGuildDepositMaxNum_s64 = toInt64(0, 0),
  _setVol_selectedMemberIdx = 0,
  _setVol_selectedMemberVol = 0,
  _prevVoiceChatListen = false,
  _dailyPayWhereType = nil,
  _characterName = "",
  _isConsole = false,
  _initialize = false,
  _isConsoleTooltipShow = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMemberList_All_Init")
function FromClient_GuildMemberList_All_Init()
  PaGlobal_GuildMemberList_All:initialize()
end
