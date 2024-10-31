PaGlobal_CharacterSelect_All = {
  _ui = {
    stc_BackGroundBg = nil,
    stc_RightBg = nil,
    txt_Title = nil,
    txt_CharacterCount = nil,
    stc_CharacterCountGuide = nil,
    rdo_Normal = nil,
    rdo_Special = nil,
    rdo_HardCore = nil,
    btn_Delete = nil,
    btn_ChangePosition = nil,
    btn_CreateCharacter = nil,
    btn_CreateFreeSeasonCharacter = nil,
    btn_BackToServer = nil,
    txt_SubDesc = nil,
    chk_Ghost = nil,
    stc_SelectLine = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    stc_KeyGuide_LB = nil,
    stc_KeyGuide_RB = nil,
    txt_FamilyName = nil,
    txt_CharacterName = nil,
    txt_CharacterStatus = nil,
    list2_Character = nil,
    stc_RightClick = nil,
    stc_MouseWheel = nil,
    stc_Fade = nil,
    txt_version = nil,
    stc_FreeSeasonArea = nil,
    stc_FreeSeasonCountBox = nil,
    stc_FreeSeasonCountCircle = {},
    _rdoTables = {},
    _btn_EnterTable = {},
    _originNameSpanX = 0,
    btn_GamePlay = nil
  },
  _eKeyGuideType = {
    NOT_SELECT = 0,
    SELECTED = 1,
    DELETING = 2,
    CHANGEINGSLOT_SELECTED = 3,
    CHANGEINGSLOT_NOT_SELECTED = 4,
    ADD_NEWCHARACTER = 5
  },
  _TABTYPE = {
    _NORMAL = 1,
    _PREMIUM = 2,
    _HARDCORE = 3
  },
  _currentTab = nil,
  _eServantView = {
    vehicle = CppEnums.ServantType.Type_Vehicle,
    ship = CppEnums.ServantType.Type_Ship,
    max = 1
  },
  _playerData = {
    maxSlot = 0,
    haveCount = 0,
    useAbleCount = 0,
    isWaitLine = false
  },
  _selectedCharIdx = -1,
  _prevSelectedCharIdx = -1,
  _currentOveredCharIdx = 0,
  _listContents = {},
  _listContentsCount = 0,
  _listContentsBaseX = 0,
  _listContentsSlideFlag = {},
  _listContentsSlideTarget = {},
  _listContentsAlphaTarget = {},
  _listContentsAlphaFlag = {},
  _listContentsShowAniFlag = false,
  _listContentsLaunchedCount = 0,
  _listContentsLaunchTimeTable = {},
  _listContentsLaunchElapsed = 0,
  _allAnimationFinished = false,
  _enteringGameFadeOutTime = 1,
  _enteringGameFadeOutFlag = false,
  _animationPlayed = false,
  _animationDelay = 0.7,
  _timeElapsed = 0,
  _updateDelay = 0,
  _list2OriginY = 0,
  _seaIconOriginX = 0,
  _canMakeSeason = true,
  _skippableLevel = 50,
  _curKeyGuideIdx = 0,
  _isBlockServerBack = false,
  _playerCreateType = __ePlayerCreateNormal,
  _isPremiumCharacterOpen = ToClient_IsContentsGroupOpen("281"),
  _isSelectDeletingChar = false,
  _seasonCharacterCount = 0,
  _firstSeasonOriPosX = 0,
  _firstSeasonOriSizeX = 0,
  _firstSeasonPosX = 0,
  _firstSeasonSizeX = 0,
  _MAX_CIRCLE_COUNT = 5,
  _isFirstEnter = false,
  _isConsole = false,
  _isUsePadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_CharacterSelect_All_1.lua")
runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_CharacterSelect_All_2.lua")
function FromClient_CharacterSelect_All_Init()
  PaGlobal_CharacterSelect_All:initialize()
end
FromClient_CharacterSelect_All_Init()
