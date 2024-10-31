local MessageData = {
  _Msg = {}
}
local curIndex = 0
local processIndex = 0
local animationEndTime = 2.3
local elapsedTime = 2.3
local _text_Msg = UI.getChildControl(Panel_RewardSelect_NakMessage, "MsgText")
local _text_MsgSub = UI.getChildControl(Panel_RewardSelect_NakMessage, "MsgSubText")
local _text_AddMsg = UI.getChildControl(Panel_RewardSelect_NakMessage, "TradeSubText")
local bigNakMsg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigNakMsg")
local nakItemIconBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_IconBG")
local nakItemIcon = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Icon")
local localwarMsg = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Localwar")
local localwarMsgSmallBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_LocalwarSmall")
local localwarMsgBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_LocalwarBG")
local _text_localwarMsg = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_LocalwarText")
local competitionBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_CompetitionGameBg")
local competitionMsg = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_CompetitionGameMsg")
local competitionCount = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_CompetitonGameCount")
local nationSiegeBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_NationSiege")
local nationSiegeText = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_NationSiegeText")
local stallionIcon = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_iconStallion")
local blackSpiritEffect = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_blackSpiritEffect")
local belmornBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BelmornBG")
local belmornText = UI.getChildControl(belmornBG, "StaticText_BelmornDesc")
local eventUI = {
  _stc_eventBossNewJin = nil,
  _stc_eventBossImage = nil,
  _txt_eventBossName = nil,
  _txt_eventBossDesc = nil,
  _stc_eventBossEffect = nil
}
local drawEventUI = {
  _stc_drawEventBG = nil,
  _stc_drawEventItemIcon = nil,
  _txt_drawEventitemName = nil,
  _txt_drawEventDesc = nil
}
local stc_worldBossNewJin = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_WorldBoss_New_Jin")
local stc_worldBossImage = UI.getChildControl(stc_worldBossNewJin, "Static_BossImage")
local txt_worldBossName = UI.getChildControl(stc_worldBossNewJin, "StaticText_BossName")
local txt_worldBossDesc = UI.getChildControl(stc_worldBossNewJin, "StaticText_Desc")
local stc_worldBossEffect = UI.getChildControl(stc_worldBossNewJin, "Static_Effect")
eventUI._stc_eventBossNewJin = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_EventBoss_New")
eventUI._stc_eventBossImage = UI.getChildControl(eventUI._stc_eventBossNewJin, "Static_BossImage")
eventUI._txt_eventBossName = UI.getChildControl(eventUI._stc_eventBossNewJin, "StaticText_BossName")
eventUI._txt_eventBossDesc = UI.getChildControl(eventUI._stc_eventBossNewJin, "StaticText_Desc")
eventUI._stc_eventBossEffect = UI.getChildControl(eventUI._stc_eventBossNewJin, "Static_Effect")
drawEventUI._stc_drawEventBG = UI.getChildControl(Panel_Event_TicketShop_Nak, "Static_Desc_BG")
drawEventUI._stc_drawEventItemIcon = UI.getChildControl(drawEventUI._stc_drawEventBG, "Static_ItemSlot")
drawEventUI._txt_drawEventitemName = UI.getChildControl(drawEventUI._stc_drawEventBG, "StaticText_ItemName")
drawEventUI._txt_drawEventDesc = UI.getChildControl(drawEventUI._stc_drawEventBG, "MultilineText_Desc")
local slotConfig = {
  createIcon = true,
  createBorder = false,
  createCount = true,
  createCash = false,
  createEnchant = true
}
local resultItemSlot = {}
SlotItem.new(resultItemSlot, "ItemSlot", 0, drawEventUI._stc_drawEventItemIcon, slotConfig)
resultItemSlot:createChild()
resultItemSlot.empty = true
resultItemSlot:clearItem()
resultItemSlot.icon:SetSize(drawEventUI._stc_drawEventItemIcon:GetSizeX(), drawEventUI._stc_drawEventItemIcon:GetSizeY())
local stc_NoticeImage = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Notice")
local txt_notice = UI.getChildControl(stc_NoticeImage, "StaticText_Notice")
local stc_bossImage = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Boss")
local txt_boss = UI.getChildControl(stc_bossImage, "StaticText_Boss")
local stc_centerMessage = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_CenterMessage")
local txt_centerMessage = UI.getChildControl(stc_centerMessage, "StaticText_CenterMessage")
local stc_blackBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BlackBG")
local stc_leftNPC = UI.getChildControl(stc_centerMessage, "Static_LeftNPC")
local txt_leftNPCMessage = UI.getChildControl(stc_leftNPC, "StaticText_LeftDesc")
local txt_leftNPCIcon = UI.getChildControl(stc_leftNPC, "Static_BG")
local stc_rightNPC = UI.getChildControl(stc_centerMessage, "Static_RightNPC")
local txt_rightNPCMessage = UI.getChildControl(stc_rightNPC, "StaticText_RightDesc")
local txt_rightNPCIcon = UI.getChildControl(stc_rightNPC, "Static_BG")
local stc_rewardItemBG = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_RewardItemBG")
local stc_rewardItemIcon = UI.getChildControl(stc_rewardItemBG, "Static_RewardItemIcon")
local stc_rewardItemTitle = UI.getChildControl(stc_rewardItemBG, "StaticText_Title")
local stc_rewardItemDesc = UI.getChildControl(stc_rewardItemBG, "StaticText_Desc")
local stc_solareRankgame = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Solare_Rankgame")
local txt_solareTitle = UI.getChildControl(stc_solareRankgame, "StaticText_1")
local txt_solareDesc = UI.getChildControl(stc_solareRankgame, "StaticText_2")
local stc_arbitrationGuildWar = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Guild_Arbitration")
local txt_arbitrationGuildWar_Desc = UI.getChildControl(stc_arbitrationGuildWar, "MultilineText_Desc")
local stc_bigShip = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
local txt_bigShipTitle = UI.getChildControl(stc_bigShip, "StaticText_Title")
local txt_bigShipDesc = UI.getChildControl(stc_bigShip, "StaticText_Desc")
local stc_morningBoss = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_AttrBossBG")
local txt_morningBossTitle = UI.getChildControl(stc_morningBoss, "StaticText_Title")
local txt_morningBossDesc = UI.getChildControl(stc_morningBoss, "StaticText_Desc")
local stc_thousandInsam = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_GetWildGinsengBG")
local txt_thousandInsamTitle = UI.getChildControl(stc_thousandInsam, "MultiLineText_Title")
local thousandInsamIcon = UI.getChildControl(stc_thousandInsam, "Static_ItemIcon")
local stc_babyBell = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_DragonPalace_Babybell")
local txt_babyBellName = UI.getChildControl(stc_babyBell, "StaticText_BossName")
local txt_babyBellDesc = UI.getChildControl(stc_babyBell, "MultilineText_Desc")
local stc_dragonPalaceCommon = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_DragonPalace_CommonNak")
local stc_dragonPalaceDesc = UI.getChildControl(stc_dragonPalaceCommon, "MultilineText_Desc")
local stc_morningLandWorldBossCommon = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_MorningLandWorldBoss")
local stc_morningLandWorldBossDesc = UI.getChildControl(stc_morningLandWorldBossCommon, "MultilineText_Desc")
local bgBaseSizeX = bigNakMsg:GetSizeX()
local bgBaseSizeY = bigNakMsg:GetSizeY()
local increesePointSizeX = 500
local baseTextPosY = _text_Msg:GetPosY()
local changeSizeX = 0
local changeSizeY = 0
local changeTextPosY = 0
local isServantStallion = false
local currentMessageType = -1
local npcMessageIndex = 1
local npcMessageTime = 5
local totalMessageTime = 0
local elapsedTotalMessageTime = 0
local elapsedMessageTime = 5.4
local isForceShowMessage = false
local npcShowTime = 0.4
local huntingRanker = {
  [1] = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Hunting_1"),
  [2] = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Hunting_2"),
  [3] = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Hunting_3"),
  [4] = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Hunting_4"),
  [5] = UI.getChildControl(Panel_RewardSelect_NakMessage, "StaticText_Hunting_5")
}
local PanOkSeonWorld = {
  stc_PanOkSeonWorld = nil,
  stc_PanOkSeonPersonal = nil,
  stc_PanOkSeonPersonal_LeftNpc = nil,
  stc_PanOkSeonPersonal_RightNpc = nil,
  txt_PanOkSeonPersonal_LeftDesc = nil,
  txt_PanOkSeonPersonal_RightDesc = nil,
  stc_PanOkSeonPersonal_LeftBG = nil,
  stc_PanOkSeonPersonal_RightBG = nil,
  stc_PanOkSeonPersonal_MultiDesc = nil
}
PanOkSeonWorld.stc_PanOkSeonWorld = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Panokseon_WolrdMsg")
PanOkSeonWorld.stc_PanOkSeonPersonal = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Panokseon_PersonalMsg")
PanOkSeonWorld.stc_PanOkSeonPersonal_LeftNpc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal, "Static_LeftNPC")
PanOkSeonWorld.stc_PanOkSeonPersonal_RightNpc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal, "Static_RightNPC")
PanOkSeonWorld.txt_PanOkSeonPersonal_LeftDesc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal_LeftNpc, "StaticText_LeftDesc")
PanOkSeonWorld.txt_PanOkSeonPersonal_RightDesc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal_RightNpc, "StaticText_RightDesc")
PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal_LeftNpc, "Static_BG")
PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal_RightNpc, "Static_BG")
PanOkSeonWorld.stc_PanOkSeonPersonal_MultiDesc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonPersonal, "MultilineText_Panokseon_PersonalMsg")
local crogdalog = {
  _bg = nil,
  _txt_sub = nil,
  _txt_main = nil,
  _icon = nil
}
crogdalog._bg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Krogdalo_SpecialStable")
crogdalog._txt_sub = UI.getChildControl(crogdalog._bg, "StaticText_Sub")
crogdalog._txt_main = UI.getChildControl(crogdalog._bg, "MultilineText")
crogdalog._icon = UI.getChildControl(crogdalog._bg, "Static_ItemIcon")
local telescope = {
  _bg = nil,
  _txt_sub = nil,
  _txt_main = nil,
  _icon = nil
}
telescope._bg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Telescope")
telescope._txt_sub = UI.getChildControl(telescope._bg, "StaticText_Sub")
telescope._txt_main = UI.getChildControl(telescope._bg, "MultilineText")
telescope._icon = UI.getChildControl(telescope._bg, "Static_ItemIcon")
local elementalBossBuff = {
  _bg = nil,
  _txt_main = nil,
  _txt_sub = nil
}
elementalBossBuff._bg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElementalBoss_Buff")
elementalBossBuff._txt_main = UI.getChildControl(elementalBossBuff._bg, "StaticText_Title")
elementalBossBuff._txt_sub = UI.getChildControl(elementalBossBuff._bg, "StaticText_Desc")
local kingAccessory = {
  _bg = nil,
  _txt_sub = nil,
  _txt_main = nil,
  _icon = nil
}
kingAccessory._bg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_Krogdalo_SpecialStable")
kingAccessory._txt_sub = UI.getChildControl(kingAccessory._bg, "StaticText_Sub")
kingAccessory._txt_main = UI.getChildControl(kingAccessory._bg, "MultilineText")
kingAccessory._icon = UI.getChildControl(kingAccessory._bg, "Static_ItemIcon")
local elfWarGuild = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Leader")
local elfWarMercenary = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Mercenary")
local elfWarStart = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Start")
local elfWarWin = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Result_Win")
local elfWarLose = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Result_Lose")
local elfWarTie = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_ElfWar_Result_Draw")
local siege2024Raffle = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_NodeWarSelection")
bigNakMsg:SetShow(false)
localwarMsg:SetShow(false)
localwarMsgSmallBG:SetShow(false)
localwarMsgBG:SetShow(false)
_text_localwarMsg:SetShow(false)
competitionBg:SetShow(false)
competitionMsg:SetShow(false)
competitionCount:SetShow(false)
nakItemIconBG:SetShow(false)
nakItemIcon:SetShow(false)
stallionIcon:SetShow(false)
nationSiegeBG:SetShow(false)
nationSiegeText:SetShow(false)
belmornBG:SetShow(false)
belmornText:SetShow(false)
stc_morningBoss:SetShow(false)
stc_thousandInsam:SetShow(false)
thousandInsamIcon:SetShow(false)
stc_babyBell:SetShow(false)
stc_dragonPalaceCommon:SetShow(false)
stc_morningLandWorldBossCommon:SetShow(false)
crogdalog._bg:SetShow(false)
crogdalog._txt_sub:SetShow(false)
crogdalog._txt_main:SetShow(false)
telescope._bg:SetShow(false)
telescope._txt_sub:SetShow(false)
telescope._txt_main:SetShow(false)
telescope._icon:SetShow(false)
kingAccessory._bg:SetShow(false)
kingAccessory._txt_sub:SetShow(false)
kingAccessory._txt_main:SetShow(false)
elementalBossBuff._bg:SetShow(false)
elementalBossBuff._txt_main:SetShow(false)
elementalBossBuff._txt_sub:SetShow(false)
elfWarGuild:SetShow(false)
elfWarMercenary:SetShow(false)
elfWarStart:SetShow(false)
elfWarWin:SetShow(false)
elfWarLose:SetShow(false)
elfWarTie:SetShow(false)
siege2024Raffle:SetShow(false)
local messageType = {
  safetyArea = 0,
  combatArea = 1,
  challengeComplete = 2,
  normal = 3,
  selectReward = 4,
  territoryTradeEvent = 5,
  npcTradeEvent = 6,
  royalTrade = 7,
  supplyTrade = 8,
  fitnessLevelUp = 9,
  territoryWar_Start = 10,
  territoryWar_End = 11,
  territoryWar_Add = 12,
  territoryWar_Destroy = 13,
  territoryWar_Attack = 14,
  guildWar_Start = 15,
  guildWar_End = 16,
  roulette = 17,
  anotherPlayerGotItem = 18,
  itemMarket = 19,
  inSiegeArea = 20,
  outSiegeArea = 21,
  guildMsg = 22,
  lifeLevUp = 23,
  characterHPwarning = 24,
  servantWarning = 25,
  alchemyFail = 26,
  cookFail = 27,
  whaleShow = 28,
  whaleHide = 29,
  defeatBoss = 30,
  guildNotify = 31,
  changeSkill = 32,
  alchemyStoneGrowUp = 33,
  localWarJoin = 34,
  localWarExit = 35,
  raceFail = 36,
  raceFinish = 37,
  raceMoveStart = 38,
  raceReady = 39,
  raceStart = 40,
  raceWaiting = 41,
  worldBossShow = 42,
  raceAnother = 43,
  enchantFail = 44,
  localWarWin = 45,
  localWarLose = 46,
  localWarTurnAround = 47,
  localWarCriticalBlack = 48,
  localWarCriticalRed = 49,
  desertArea = 50,
  playerKiller = 51,
  huntingLandShow = 52,
  huntingLandHide = 53,
  goldenBell = 54,
  getValenciaItem = 55,
  competitionStart = 56,
  competitionStop = 57,
  guildServantRegist = 58,
  competitionRound = 59,
  eventBossTurking = 60,
  fieldBoss = 61,
  arshaSpearCountDown = 62,
  horseNineTier = 63,
  servantMarket = 64,
  workerMarket = 65,
  arshaNotify = 66,
  savageDefence = 67,
  itemAuctionStart = 68,
  itemAuctionEnd = 69,
  timeAttackSuccess = 70,
  timeAttackFail = 71,
  SavageDefenceWin = 72,
  SavageDefenceLose = 73,
  SavageDefenceStart = 74,
  militiaRecruitStart = 75,
  militiaReponseMsg = 76,
  savageDefenceBoss = 77,
  guildBattleNormal = 78,
  guildBattleStart = 79,
  guildBattleEnd = 80,
  bellBoss = 81,
  eventBossMamos = 82,
  eventBossIsabella = 83,
  enchantSuccess = 84,
  fieldBossOpin = 85,
  worldBossNuver = 86,
  worldBossKaranda = 87,
  worldBossKutum = 88,
  worldBossGamos = 89,
  wolfAppear = 90,
  wolfNotAppear = 91,
  termianEvent_1 = 100,
  termianEvent_2 = 101,
  termianEvent_3 = 102,
  termianNineShark = 103,
  secrid = 104,
  horseNineTier_dine = 105,
  horseNineTier_Doom = 106,
  xmasGoldenBell = 107,
  personalMonster = 108,
  nationSiegeStart = 109,
  nationSiegeStop = 110,
  nationSiegeCalpheonWin = 111,
  nationSeigeValenciaWin = 112,
  fluctuationDown = 113,
  fluctuationUp = 114,
  freeBell = 115,
  restrictedArea_Normal = 116,
  restrictedArea_Warning = 117,
  restrictedArea_Kill = 118,
  register_Succees = 119,
  register_Fail = 120,
  berserk_Zod = 121,
  sailControl = 122,
  createSpecialBarter = 123,
  thousandWar = 124,
  agrisPointOpen = 125,
  belmorn = 126,
  worldBossjinKzaka = 127,
  fantasyMix_Aduanatt = 128,
  worldBossJinNuver = 129,
  ocean = 130,
  invasion = 131,
  noti = 132,
  worldBossJinKaranda = 133,
  fieldBossBlackShadow = 134,
  nuberu = 135,
  worldBossJinKutum = 136,
  guildDrillInstall = 137,
  guildDrillComplete = 138,
  guildDrillDelete = 139,
  startVote = 140,
  endVote = 141,
  activePolicy = 142,
  richMerchantRing = 143,
  reportLocationBadPlayer = 144,
  reportWantedBadPlayer = 145,
  getGrowthPassRewardItem = 146,
  eventBossDongSim12 = 147,
  eventDraw = 148,
  fantasyMix_Dine = 149,
  fantasyMix_Doom = 150,
  train = 151,
  solareStart = 152,
  solareEnd = 153,
  arbitrationGuildWar = 154,
  whaleAlarm = 155,
  whaleTimeOut = 156,
  huntingLandAlarm = 157,
  huntingLandTimeOut = 158,
  LauLauShow = 159,
  LauLauHide = 160,
  bigShip = 161,
  morningBoss = 162,
  thousandInsam = 163,
  PanOkSeonPersonal = 164,
  PanOkSeonWorld = 165,
  BabyBell = 166,
  DragonPalaceCommon = 167,
  CrogdaloStable = 168,
  Telescope = 169,
  ElementalBossBuffSun = 170,
  ElementalBossBuffMoon = 171,
  ElementalBossBuffLand = 172,
  ElfWarApplyGuild = 173,
  ElfWarApplyMercenary = 174,
  ElfWarRaffleGuild = 175,
  ElfWarRaffleMercenary = 176,
  ElfWarStart = 177,
  ElfWarKamasylviaWin = 178,
  ElfWarOdylitaWin = 179,
  ElfWarTie = 180,
  Siege2024Raffle = 181,
  SiegeGravityMagicianDead = 182,
  morningLandWorldBossBulgasal = 183,
  morningLandWorldBossUturi = 184,
  morningLandWorldBossSangun = 185,
  morningLandWorldBossDuoksini = 186,
  morningLandWorldBossGoldenPig = 187,
  KingAccessory = 188
}
local messageTexture = {
  [messageType.normal] = "New_UI_Common_forLua/Widget/NakMessage/Alert_01.dds",
  [messageType.selectReward] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_RewardAlert_01.dds",
  [messageType.combatArea] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Combat_01.dds",
  [messageType.safetyArea] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Safety_01.dds",
  [messageType.challengeComplete] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_RewardAlert_01.dds",
  [messageType.territoryTradeEvent] = "New_UI_Common_forLua/Widget/NakMessage/Trade_GlobalEvent_01.dds",
  [messageType.npcTradeEvent] = "New_UI_Common_forLua/Widget/NakMessage/Trade_LocalEvent_01.dds",
  [messageType.royalTrade] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryAuth_Message01.dds",
  [messageType.supplyTrade] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryAuth_Message01.dds",
  [messageType.fitnessLevelUp] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Train.dds",
  [messageType.territoryWar_Start] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_Start.dds",
  [messageType.territoryWar_End] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_End.dds",
  [messageType.territoryWar_Add] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_addGuildTent.dds",
  [messageType.territoryWar_Destroy] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_destroyGuildTent.dds",
  [messageType.territoryWar_Attack] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_attackGuildTent.dds",
  [messageType.guildWar_Start] = "New_UI_Common_forLua/Widget/NakMessage/guildWar_start.dds",
  [messageType.guildWar_End] = "New_UI_Common_forLua/Widget/NakMessage/guildWar_End.dds",
  [messageType.roulette] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Roulette.dds",
  [messageType.anotherPlayerGotItem] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_anotherPlayerGotItem.dds",
  [messageType.itemMarket] = "New_UI_Common_forLua/Widget/NakMessage/Alert_01.dds",
  [messageType.inSiegeArea] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar.dds",
  [messageType.outSiegeArea] = "New_UI_Common_forLua/Widget/NakMessage/Non_TerritoryWar.dds",
  [messageType.guildMsg] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Guild.dds",
  [messageType.lifeLevUp] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_RewardAlert_01.dds",
  [messageType.characterHPwarning] = "New_UI_Common_forLua/Widget/NakMessage/Character_HPwarning.dds",
  [messageType.servantWarning] = "New_UI_Common_forLua/Widget/NakMessage/Horse_Warning.dds",
  [messageType.cookFail] = "New_UI_Common_forLua/Widget/NakMessage/Fail_Cooking.dds",
  [messageType.alchemyFail] = "New_UI_Common_forLua/Widget/NakMessage/Fail_Alchemy.dds",
  [messageType.whaleShow] = "Combine/Etc/HuntingWorldboss_Blue_BigWhale.dds",
  [messageType.whaleHide] = "Combine/Etc/HuntingWorldboss_Red_BigWhale.dds",
  [messageType.defeatBoss] = "New_UI_Common_forLua/Widget/NakMessage/boss.dds",
  [messageType.guildNotify] = "New_UI_Common_forLua/Widget/NakMessage/Guild_Call.dds",
  [messageType.changeSkill] = "New_UI_Common_forLua/Widget/NakMessage/Horse_skillchange.dds",
  [messageType.alchemyStoneGrowUp] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_anotherPlayerGotItem.dds",
  [messageType.localWarJoin] = "New_UI_Common_forLua/Widget/NakMessage/LocalWar_Intro.dds",
  [messageType.localWarExit] = "New_UI_Common_forLua/Widget/NakMessage/LocalWar_Exit.dds",
  [messageType.raceFail] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_Fail.dds",
  [messageType.raceFinish] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_Finish.dds",
  [messageType.raceMoveStart] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_MoveStart.dds",
  [messageType.raceReady] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_Ready.dds",
  [messageType.raceStart] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_Start.dds",
  [messageType.raceWaiting] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_Waitting.dds",
  [messageType.worldBossShow] = "New_UI_Common_forLua/Widget/NakMessage/WorldBoss_Show.dds",
  [messageType.raceAnother] = "New_UI_Common_forLua/Widget/NakMessage/RaceMatch_AnotherPoint.dds",
  [messageType.enchantFail] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_FailEnchant.dds",
  [messageType.localWarWin] = "New_UI_Common_forLua/Widget/LocalWar/LocalWar_Win.dds",
  [messageType.localWarLose] = "New_UI_Common_forLua/Widget/LocalWar/LocalWar_Lose.dds",
  [messageType.localWarTurnAround] = "New_UI_Common_forLua/Widget/NakMessage/Turnaround.dds",
  [messageType.localWarCriticalBlack] = "New_UI_Common_forLua/Widget/NakMessage/BlackdesertScore.dds",
  [messageType.localWarCriticalRed] = "New_UI_Common_forLua/Widget/NakMessage/ReddesertScore.dds",
  [messageType.desertArea] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Danger.dds",
  [messageType.playerKiller] = "New_UI_Common_forLua/Widget/NakMessage/Kill_Murderer.dds",
  [messageType.huntingLandShow] = "Combine/Etc/HuntingWorldboss_Blue_Kalkeu.dds",
  [messageType.huntingLandHide] = "Combine/Etc/HuntingWorldboss_Red_Kalkeu.dds",
  [messageType.goldenBell] = "New_UI_Common_forLua/Widget/NakMessage/GoldenBell.dds",
  [messageType.getValenciaItem] = "New_UI_Common_forLua/Widget/NakMessage/CombineComplete.dds",
  [messageType.competitionStart] = "New_UI_Common_forLua/Widget/NakMessage/Competition_Start.dds",
  [messageType.competitionStop] = "New_UI_Common_forLua/Widget/NakMessage/Competition_Stop.dds",
  [messageType.guildServantRegist] = "New_UI_Common_forLua/Widget/NakMessage/Guild_Production_Complete.dds",
  [messageType.competitionRound] = "New_UI_Common_forLua/Widget/NakMessage/PvP_RoundMessage.dds",
  [messageType.eventBossTurking] = "New_UI_Common_forLua/Widget/NakMessage/Turking_Show.dds",
  [messageType.fieldBoss] = "New_UI_Common_forLua/Widget/NakMessage/WorldBoss2_Show.dds",
  [messageType.arshaSpearCountDown] = "New_UI_Common_forLua/Widget/NakMessage/pvp_countdown.dds",
  [messageType.horseNineTier] = "New_UI_Common_forLua/Widget/NakMessage/Adu.dds",
  [messageType.servantMarket] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_HorseAuction.dds",
  [messageType.workerMarket] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_WorkerAuction.dds",
  [messageType.arshaNotify] = "New_UI_Common_forLua/Widget/NakMessage/PvP_Megaphone.dds",
  [messageType.savageDefence] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Crackofbarbarism.dds",
  [messageType.itemAuctionStart] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_MasterpieceAuction.dds",
  [messageType.timeAttackSuccess] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_TimeAttack_Success.dds",
  [messageType.timeAttackFail] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_TimeAttack_Fail.dds",
  [messageType.SavageDefenceWin] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_TimeAttack_Success.dds",
  [messageType.SavageDefenceLose] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_TimeAttack_Fail.dds",
  [messageType.SavageDefenceStart] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Crackofbarbarism.dds",
  [messageType.militiaRecruitStart] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_MilitiaStart.dds",
  [messageType.militiaReponseMsg] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_MilitiaEnd.dds",
  [messageType.savageDefenceBoss] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_CrackofbarbarismBoss.dds",
  [messageType.guildBattleNormal] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_GuildwarReservation.dds",
  [messageType.guildBattleStart] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_GuildwarStart.dds",
  [messageType.guildBattleEnd] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_GuildwarEnd.dds",
  [messageType.bellBoss] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Bell.dds",
  [messageType.eventBossMamos] = "New_UI_Common_forLua/Widget/NakMessage/BigBearMessage.dds",
  [messageType.eventBossIsabella] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Holloween_Isabella.dds",
  [messageType.enchantSuccess] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_anotherPlayerGotItem.dds",
  [messageType.fieldBossOpin] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Opin.dds",
  [messageType.worldBossNuver] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Nouver.dds",
  [messageType.worldBossKaranda] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Karanda.dds",
  [messageType.worldBossKutum] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_AncientKutum.dds",
  [messageType.worldBossGamos] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Gamos.dds",
  [messageType.wolfAppear] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Truth.dds",
  [messageType.wolfNotAppear] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_False.dds",
  [messageType.termianEvent_1] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Termian_Start.dds",
  [messageType.termianEvent_2] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Termian_Lapse.dds",
  [messageType.termianEvent_3] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Termian_End.dds",
  [messageType.termianNineShark] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_NineShark.dds",
  [messageType.secrid] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Sycreeth.dds",
  [messageType.horseNineTier_dine] = "New_UI_Common_forLua/Widget/NakMessage/Dine.dds",
  [messageType.horseNineTier_Doom] = "New_UI_Common_forLua/Widget/NakMessage/Doom.dds",
  [messageType.xmasGoldenBell] = "New_UI_Common_forLua/Widget/NakMessage/ChristmasGoldenBell.dds",
  [messageType.personalMonster] = "New_UI_Common_forLua/Widget/NakMessage/AutoBoss.dds",
  [messageType.nationSiegeStart] = "New_UI_Common_forLua/Widget/NakMessage/NationWar_Nak_Draw.dds",
  [messageType.nationSiegeStop] = "New_UI_Common_forLua/Widget/NakMessage/NationWar_Nak_Draw.dds",
  [messageType.nationSiegeCalpheonWin] = "New_UI_Common_forLua/Widget/NakMessage/NationWar_Nak_CalpheonWin.dds",
  [messageType.nationSeigeValenciaWin] = "New_UI_Common_forLua/Widget/NakMessage/NationWar_Nak_ValenciaWin.dds",
  [messageType.fluctuationDown] = "New_UI_Common_forLua/Widget/NakMessage/MarketPlace_down.dds",
  [messageType.fluctuationUp] = "New_UI_Common_forLua/Widget/NakMessage/MarketPlace_up.dds",
  [messageType.freeBell] = "New_UI_Common_forLua/Widget/NakMessage/FreeBell.dds",
  [messageType.restrictedArea_Normal] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Safety_01.dds",
  [messageType.restrictedArea_Warning] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_MonsterDanger.dds",
  [messageType.restrictedArea_Kill] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_MonsterDanger.dds",
  [messageType.register_Succees] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_EmploymentSuccess.dds",
  [messageType.register_Fail] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_EmploymentFail.dds",
  [messageType.berserk_Zod] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Berserk_Zod.dds",
  [messageType.sailControl] = "Combine/Etc/Combine_Etc_SailNak_BG.dds",
  [messageType.createSpecialBarter] = "New_UI_Common_forLua/Widget/NakMessage/NackBG_SpecialBarter.dds",
  [messageType.thousandWar] = "Combine/Etc/Combine_Etc_ThousandWar_Nak.dds",
  [messageType.agrisPointOpen] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_AgrisOpen.dds",
  [messageType.worldBossjinKzaka] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.fantasyMix_Aduanatt] = "New_UI_Common_forLua/Widget/NakMessage/Nak_9genHorse_00.dds",
  [messageType.worldBossJinNuver] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.worldBossJinKaranda] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.fieldBossBlackShadow] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.nuberu] = "New_UI_Common_forLua/Widget/NakMessage/TerritoryWar_AwesomeFighter.dds",
  [messageType.worldBossJinKutum] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.guildDrillInstall] = "New_UI_Common_forLua/Widget/NakMessage/GuildManufactrue_Start.dds",
  [messageType.guildDrillComplete] = "New_UI_Common_forLua/Widget/NakMessage/GuildManufactrue_Complete.dds",
  [messageType.guildDrillDelete] = "New_UI_Common_forLua/Widget/NakMessage/GuildManufactrue_Fail.dds",
  [messageType.startVote] = "Combine/Etc/Combine_Etc_StrongholdWar_Point_Nak_01.dds",
  [messageType.endVote] = "Combine/Etc/Combine_Etc_StrongholdWar_Point_Nak_02.dds",
  [messageType.activePolicy] = "Combine/Etc/Combine_Etc_StrongholdWar_Point_Nak_01.dds",
  [messageType.richMerchantRing] = "Combine/Etc/Combine_ETC_Nak_MerchantRing.dds",
  [messageType.reportLocationBadPlayer] = "New_UI_Common_forLua/Widget/NakMessage/Sheriff_Villain.dds",
  [messageType.reportWantedBadPlayer] = "New_UI_Common_forLua/Widget/NakMessage/Sheriff_Wanted.dds",
  [messageType.getGrowthPassRewardItem] = "Combine/Etc/Combine_Etc_Nak_GrowthSupport.dds",
  [messageType.eventBossDongSim12] = "Combine/Etc/Combine_Etc_WorldBoss_Nak.dds",
  [messageType.fantasyMix_Dine] = "New_UI_Common_forLua/Widget/NakMessage/Nak_DreamDine.dds",
  [messageType.fantasyMix_Doom] = "New_UI_Common_forLua/Widget/NakMessage/Nak_DreamDoom.dds",
  [messageType.train] = "New_UI_Common_forLua/Widget/NakMessage/NakBG_Train.dds",
  [messageType.solareStart] = "Combine/Etc/Combine_Etc_Nak_SolareWar_Matching_01.dds",
  [messageType.solareEnd] = "Combine/Etc/Combine_Etc_Nak_SolareWar_Matching_02.dds",
  [messageType.arbitrationGuildWar] = "new_ui_common_forlua/widget/nakmessage/nakbg_guildsignup.dds",
  [messageType.whaleAlarm] = "Combine/Etc/HuntingWorldboss_Blue_BigWhale_01.dds",
  [messageType.whaleTimeOut] = "Combine/Etc/HuntingWorldboss_Red_BigWhale_01.dds",
  [messageType.huntingLandAlarm] = "Combine/Etc/HuntingWorldboss_Blue_Kalkeu_01.dds",
  [messageType.huntingLandTimeOut] = "Combine/Etc/HuntingWorldboss_Red_Kalkeu_01.dds",
  [messageType.LauLauShow] = "Combine/Etc/HuntingWorldboss_Blue_LauLau.dds",
  [messageType.LauLauHide] = "Combine/Etc/HuntingWorldboss_Red_LauLau.dds",
  [messageType.bigShip] = "new_ui_common_forlua/widget/nakmessage/guild_greateperia_register.dds",
  [messageType.morningBoss] = "combine/etc/combine_etc_morning_boss_kill_nak_01.dds",
  [messageType.thousandInsam] = "new_ui_common_forlua/widget/nakmessage/collection_nak_wildginseng.dds",
  [messageType.PanOkSeonPersonal] = "new_ui_common_forlua/widget/nakmessage/collection_nak_wildginseng.dds",
  [messageType.PanOkSeonWorld] = "new_ui_common_forlua/widget/nakmessage/collection_nak_wildginseng.dds",
  [messageType.BabyBell] = "new_ui_common_forlua/widget/nakmessage/morningland_nakbg_bell.dds",
  [messageType.DragonPalaceCommon] = "combine/etc/combine_etc_morningland_dragonplace_nak_bg.dds",
  [messageType.CrogdaloStable] = "new_ui_common_forlua/widget/nakmessage/Collection_Nak_SpecialStable.dds",
  [messageType.Telescope] = "New_UI_Common_forLua/widget/nakmessage/Collection_Nak_Telescope.dds",
  [messageType.ElementalBossBuffSun] = "Combine/Etc/Combine_Etc_Morning_Boss_Stage_Nak_1.dds",
  [messageType.ElementalBossBuffMoon] = "Combine/Etc/Combine_Etc_Morning_Boss_Stage_Nak_2.dds",
  [messageType.ElementalBossBuffLand] = "Combine/Etc/Combine_Etc_Morning_Boss_Stage_Nak_3.dds",
  [messageType.ElfWarApplyGuild] = "Combine/Etc/Combine_Etc_Nak_Elfwar_BattleReady_1.dds",
  [messageType.ElfWarApplyMercenary] = "Combine/Etc/Combine_Etc_Nak_Elfwar_BattleReady_2.dds",
  [messageType.ElfWarRaffleGuild] = "Combine/Etc/Combine_Etc_Nak_Elfwar_BattleReady_1.dds",
  [messageType.ElfWarRaffleMercenary] = "Combine/Etc/Combine_Etc_Nak_Elfwar_BattleReady_2.dds",
  [messageType.ElfWarStart] = "Combine/Etc/Combine_Etc_Nak_Elfwar_BattleStart.dds",
  [messageType.ElfWarKamasylviaWin] = "Combine/Etc/Combine_Etc_Nak_Elfwar_Result_1.dds",
  [messageType.ElfWarOdylitaWin] = "Combine/Etc/Combine_Etc_Nak_Elfwar_Result_4.dds",
  [messageType.ElfWarTie] = "Combine/Etc/Combine_Etc_Nak_Elfwar_Result_3.dds",
  [messageType.Siege2024Raffle] = "Combine/Etc/Combine_Etc_Strongholdwar_nak.dds",
  [messageType.SiegeGravityMagicianDead] = "new_ui_common_forlua/widget/nakmessage/nationwar_nak_waggondestroy.dds",
  [messageType.morningLandWorldBossBulgasal] = "new_ui_common_forlua/widget/nakmessage/MorningLand2_Boss_Bulgasal.dds",
  [messageType.morningLandWorldBossUturi] = "new_ui_common_forlua/widget/nakmessage/MorningLand2_Boss_Uturi.dds",
  [messageType.morningLandWorldBossSangun] = "new_ui_common_forlua/widget/nakmessage/MorningLand2_Boss_Sangun.dds",
  [messageType.morningLandWorldBossDuoksini] = "new_ui_common_forlua/widget/nakmessage/MorningLand2_Boss_Duoksini.dds",
  [messageType.morningLandWorldBossGoldenPig] = "new_ui_common_forlua/widget/nakmessage/MorningLand2_Boss_GoldenPigKing.dds",
  [messageType.KingAccessory] = "new_ui_common_forlua/widget/nakmessage/Collection_Nak_SpecialStable.dds"
}
local npcTexture = {
  [messageType.richMerchantRing] = {
    leftNPC = {
      texture = "Combine/Etc/Combine_ETC_Nak_MerchantRing.dds",
      uv = {
        x1 = 1,
        y1 = 320,
        x2 = 171,
        y2 = 585
      },
      size = {x = 170, y = 264}
    },
    rightNPC = {
      texture = "Combine/Etc/Combine_ETC_Nak_MerchantRing.dds",
      uv = {
        x1 = 172,
        y1 = 320,
        x2 = 422,
        y2 = 585
      },
      size = {x = 250, y = 264}
    }
  }
}
local npcMessage = {
  [messageType.richMerchantRing] = {messageCount = 0},
  [messageType.PanOkSeonPersonal] = {messageCount = 0},
  [messageType.BabyBell] = {messageCount = 0}
}
local gameOptionIgnoreMessageType = {
  messageType.challengeComplete,
  messageType.normal,
  messageType.selectReward,
  messageType.guildMsg,
  messageType.guildNotify,
  messageType.cookFail,
  messageType.alchemyFail,
  messageType.characterHPwarning,
  messageType.servantWarning,
  messageType.changeSkill,
  messageType.alchemyStoneGrowUp,
  messageType.localWarJoin,
  messageType.localWarExit,
  messageType.raceFail,
  messageType.raceFinish,
  messageType.raceMoveStart,
  messageType.raceReady,
  messageType.raceStart,
  messageType.raceWaiting,
  messageType.worldBossShow,
  messageType.raceAnother,
  messageType.localWarWin,
  messageType.localWarLose,
  messageType.localWarTurnAround,
  messageType.localWarCriticalBlack,
  messageType.localWarCriticalRed,
  messageType.playerKiller,
  messageType.whaleShow,
  messageType.huntingLandShow,
  messageType.whaleHide,
  messageType.huntingLandHide,
  messageType.goldenBell,
  messageType.getValenciaItem,
  messageType.competitionStart,
  messageType.competitionStop,
  messageType.guildServantRegist,
  messageType.competitionRound,
  messageType.eventBossTurking,
  messageType.fieldBoss,
  messageType.arshaNotify,
  messageType.savageDefence,
  messageType.itemAuctionStart,
  messageType.itemAuctionEnd,
  messageType.timeAttackSuccess,
  messageType.timeAttackFail,
  messageType.SavageDefenceWin,
  messageType.SavageDefenceLose,
  messageType.SavageDefenceStart,
  messageType.militiaRecruitStart,
  messageType.militiaReponseMsg,
  messageType.militiaReponseMsg,
  messageType.guildBattleNormal,
  messageType.guildBattleStart,
  messageType.guildBattleEnd,
  messageType.bellBoss,
  messageType.eventBossMamos,
  messageType.eventBossIsabella,
  messageType.fieldBossOpin,
  messageType.worldBossNuver,
  messageType.worldBossKaranda,
  messageType.worldBossKutum,
  messageType.worldBossGamos,
  messageType.wolfAppear,
  messageType.wolfNotAppear,
  messageType.termianEvent_1,
  messageType.termianEvent_2,
  messageType.termianEvent_3,
  messageType.termianNineShark,
  messageType.secrid,
  messageType.xmasGoldenBell,
  messageType.personalMonster,
  messageType.nationSiegeStart,
  messageType.nationSiegeStop,
  messageType.nationSiegeCalpheonWin,
  messageType.nationSeigeValenciaWin,
  messageType.freeBell,
  messageType.berserk_Zod,
  messageType.createSpecialBarter,
  messageType.thousandWar,
  messageType.agrisPointOpen,
  messageType.belmorn,
  messageType.worldBossjinKzaka,
  messageType.worldBossJinNuver,
  messageType.worldBossJinKaranda,
  messageType.fieldBossBlackShadow,
  messageType.nuberu,
  messageType.worldBossJinKutum,
  messageType.guildDrillInstall,
  messageType.guildDrillComplete,
  messageType.guildDrillDelete,
  messageType.startVote,
  messageType.endVote,
  messageType.activePolicy,
  messageType.register_Succees,
  messageType.register_Fail,
  messageType.richMerchantRing,
  messageType.reportLocationBadPlayer,
  messageType.reportWantedBadPlayer,
  messageType.getGrowthPassRewardItem,
  messageType.eventBossDongSim12,
  messageType.eventDraw,
  messageType.train,
  messageType.solareStart,
  messageType.solareEnd,
  messageType.whaleAlarm,
  messageType.whaleTimeOut,
  messageType.huntingLandAlarm,
  messageType.huntingLandTimeOut,
  messageType.LauLauShow,
  messageType.LauLauHide,
  messageType.bigShip,
  messageType.morningBoss,
  messageType.thousandInsam,
  messageType.PanOkSeonPersonal,
  messageType.BabyBell,
  messageType.DragonPalaceCommon,
  messageType.CrogdaloStable,
  messageType.Telescope,
  messageType.ElementalBossBuffSun,
  messageType.ElementalBossBuffMoon,
  messageType.ElementalBossBuffLand,
  messageType.ElfWarApplyGuild,
  messageType.ElfWarApplyMercenary,
  messageType.ElfWarRaffleGuild,
  messageType.ElfWarRaffleMercenary,
  messageType.ElfWarStart,
  messageType.ElfWarKamasylviaWin,
  messageType.ElfWarOdylitaWin,
  messageType.ElfWarTie,
  messageType.Siege2024Raffle,
  messageType.SiegeGravityMagicianDead,
  messageType.morningLandWorldBossBulgasal,
  messageType.morningLandWorldBossUturi,
  messageType.morningLandWorldBossSangun,
  messageType.morningLandWorldBossDuoksini,
  messageType.morningLandWorldBossGoldenPig,
  messageType.KingAccessory
}
local worldBossName = {
  [messageType.worldBossjinKzaka] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDBOSS_JINKZAKA_NAME"),
  [messageType.worldBossJinNuver] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDBOSS_JINNUVER_NAME"),
  [messageType.worldBossJinKaranda] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDBOSS_JINKRARANDA_NAME"),
  [messageType.fieldBossBlackShadow] = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSALERT_SETTING_BLACKSHADOW"),
  [messageType.worldBossJinKutum] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDBOSS_KUTUM_NAME"),
  [messageType.eventBossDongSim12] = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTBOSS_DONGSIM12_NAME")
}
local _territoryName = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_EVENTMSG_AREANAME_BALENOS"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_EVENTMSG_AREANAME_SERENDIA"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_EVENTMSG_AREANAME_CALPHEON"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_EVENTMSG_AREANAME_MEDIA")
}
local npcKey = {
  [40715] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY1"),
  [40026] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY2"),
  [40025] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY3"),
  [40024] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY4"),
  [40031] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY5"),
  [40101] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY6"),
  [40609] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY7"),
  [40028] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY8"),
  [40010] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY9"),
  [41090] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY10"),
  [41223] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY11"),
  [41221] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY12"),
  [41085] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY13"),
  [41032] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY14"),
  [41030] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY15"),
  [41045] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY16"),
  [41222] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY17"),
  [41225] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY18"),
  [41224] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY19"),
  [41051] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY20"),
  [42301] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY21"),
  [42205] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY22"),
  [43433] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY23"),
  [50411] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY24"),
  [50415] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY25"),
  [50403] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY26"),
  [43449] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY27"),
  [43440] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY28"),
  [43446] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY29"),
  [43448] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY30"),
  [43510] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY31"),
  [42026] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY32"),
  [43010] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY33"),
  [43210] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY34"),
  [50428] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY35"),
  [50432] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY36"),
  [50430] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY37"),
  [50433] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY38"),
  [50418] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY39"),
  [50440] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY40"),
  [50434] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY41"),
  [50437] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY42"),
  [50438] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY43"),
  [50443] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY44"),
  [43310] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY45"),
  [43402] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY46"),
  [50456] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY47"),
  [43501] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY48"),
  [50455] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY49"),
  [50451] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY50"),
  [50459] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY51"),
  [42103] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY52"),
  [50466] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY53"),
  [50461] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY54"),
  [43407] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY55"),
  [42013] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY56"),
  [42005] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY57"),
  [44613] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY58"),
  [50551] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY59"),
  [50493] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY60"),
  [50550] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY61"),
  [50548] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY62"),
  [50475] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY63"),
  [44010] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY64"),
  [44110] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY65"),
  [44210] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY66"),
  [44610] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NPCKEY67")
}
local _commerceType = {
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_1"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_2"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_3"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_4"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_5"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_6"),
  [7] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_7"),
  [8] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_8"),
  [9] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_COMMERCETYPE_9")
}
local _tradeMsgType = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_0"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_1"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_2"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_3"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_4"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_5"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_TRADEMSGTYPE_6")
}
local huntingRankingFont = {
  size = {
    [0] = "BaseFont_18_Glow",
    [1] = "SubTitleFont_14_Glow",
    [2] = "BaseFont_12_Glow",
    [3] = "BaseFont_10_Glow",
    [4] = "BaseFont_10_Glow"
  },
  baseColor = {
    [0] = 4294958334,
    [1] = 4292673503,
    [2] = 4292408319,
    [3] = 4293848814,
    [4] = 4293848814
  },
  glowColor = {
    [0] = 4285794145,
    [1] = 4280382471,
    [2] = 4280235448,
    [3] = 4278190080,
    [4] = 4278190080
  }
}
_text_Msg:SetText("")
_text_MsgSub:SetText("")
local _msgType
function setEventBossName()
  eventUI._txt_eventBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
  eventUI._txt_eventBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
  eventUI._stc_eventBossEffect:AddEffect("fUI_HalloweenBoss_Nak_01A", false, 0, 0)
end
function eventBossUIOff()
  eventUI._stc_eventBossNewJin:SetShow(false)
  eventUI._txt_eventBossName:SetShow(false)
  eventUI._txt_eventBossDesc:SetShow(false)
  eventUI._stc_eventBossEffect:SetShow(false)
end
function eventBossUIOn()
  eventUI._stc_eventBossNewJin:SetShow(true)
  eventUI._txt_eventBossName:SetShow(true)
  eventUI._txt_eventBossDesc:SetShow(true)
  eventUI._stc_eventBossEffect:SetShow(true)
  eventUI._stc_eventBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
  local x1, y1, x2, y2 = setTextureUV_Func(eventUI._stc_eventBossImage, 1, 1417, 333, 1599)
  eventUI._stc_eventBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
  eventUI._stc_eventBossImage:setRenderTexture(eventUI._stc_eventBossImage:getBaseTexture())
end
function eventDrawUIOff()
  drawEventUI._stc_drawEventItemIcon:SetShow(false)
  drawEventUI._txt_drawEventitemName:SetShow(false)
  drawEventUI._txt_drawEventDesc:SetShow(false)
  Panel_Event_TicketShop_Nak:SetShow(false)
end
function eventDrawUIOn(message)
  if message.param == nil then
    return
  end
  local drawStaticStatusWrapper = getDrawItemStaticStatus(Int64toInt32(message.param))
  if drawStaticStatusWrapper == nil then
    return
  end
  local itemIconSlot = {}
  SlotItem.reInclude(itemIconSlot, "ItemSlot", 0, drawEventUI._stc_drawEventItemIcon, slotConfig)
  itemIconSlot:clearItem()
  drawEventUI._txt_drawEventDesc:SetText(message.main)
  local itemStaticStatusWrapper = getItemEnchantStaticStatus(drawStaticStatusWrapper:getItemkey())
  if itemStaticStatusWrapper == nil then
    return
  end
  drawEventUI._txt_drawEventitemName:SetText(FGlobal_ChangeItemNameColorByGrade(drawStaticStatusWrapper:getItemkey()))
  itemIconSlot:setItemByStaticStatus(itemStaticStatusWrapper, drawStaticStatusWrapper:getItemCount())
  Panel_Event_TicketShop_Nak:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Event_TicketShop_Nak:ComputePos()
  drawEventUI._stc_drawEventBG:ComputePos()
  drawEventUI._stc_drawEventItemIcon:SetShow(true)
  drawEventUI._txt_drawEventitemName:SetShow(true)
  drawEventUI._txt_drawEventDesc:SetShow(true)
  Panel_Event_TicketShop_Nak:SetShow(true)
end
function checkTableGameOptionIgnoreMessageType(msgType)
  for idx, val in ipairs(gameOptionIgnoreMessageType) do
    if msgType == val then
      return true
    end
  end
  return false
end
function NoShowMessageReturn(msgType, isSelfPlayer)
  if true == isSelfPlayer then
    return false
  end
  if true == _ContentsGroup_isNewOption then
    local showJudgment = false
    local msgCheck = checkTableGameOptionIgnoreMessageType(msgType)
    local normalCheck = true
    if true == msgCheck then
      showJudgment = false
    else
      if messageType.safetyArea == msgType or messageType.combatArea == msgType or messageType.desertArea == msgType then
        msgTypeNum = 0
        normalCheck = false
      elseif messageType.territoryTradeEvent == msgType or messageType.npcTradeEvent == msgType then
        msgTypeNum = 1
      elseif messageType.royalTrade == msgType or messageType.supplyTrade == msgType then
        msgTypeNum = 2
      elseif messageType.fitnessLevelUp == msgType then
        msgTypeNum = 3
        normalCheck = false
      elseif messageType.territoryWar_Start == msgType or messageType.territoryWar_End == msgType or messageType.territoryWar_Add == msgType or messageType.territoryWar_Destroy == msgType or messageType.territoryWar_Attack == msgType or messageType.inSiegeArea == msgType or messageType.outSiegeArea == msgType or messageType.Siege2024Raffle == msgType then
        msgTypeNum = 4
        normalCheck = false
      elseif messageType.guildWar_Start == msgType or messageType.guildWar_End == msgType or messageType.arbitrationGuildWar == msgType then
        msgTypeNum = 5
        normalCheck = false
      elseif msgType == messageType.roulette or msgType == messageType.horseNineTier or msgType == messageType.anotherPlayerGotItem or msgType == messageType.horseNineTier_dine or msgType == messageType.horseNineTier_Doom or msgType == messageType.fantasyMix_Aduanatt or msgType == messageType.fantasyMix_Dine or msgType == messageType.fantasyMix_Doom then
        msgTypeNum = 6
      elseif messageType.itemMarket == msgType or messageType.fluctuationDown == msgType or messageType.fluctuationUp == msgType then
        msgTypeNum = 7
      elseif messageType.lifeLevUp == msgType then
        msgTypeNum = 8
      elseif messageType.servantMarket == msgType or messageType.workerMarket == msgType then
        msgTypeNum = 11
      elseif messageType.enchantSuccess == msgType then
        msgTypeNum = 12
      elseif messageType.enchantFail == msgType then
        msgTypeNum = 13
      end
      showJudgment = ToClient_GetMessageFilter(msgTypeNum)
      if true == normalCheck and nil ~= GetUIMode and Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
        showJudgment = true
      end
    end
    return showJudgment
  else
    local showJudgment = false
    local msgCheck = checkTableGameOptionIgnoreMessageType(msgType)
    local normalCheck = true
    if true == msgCheck then
      showJudgment = false
    else
      if messageType.safetyArea == msgType or messageType.combatArea == msgType or messageType.desertArea == msgType then
        msgTypeNum = 0
        normalCheck = false
      elseif messageType.territoryTradeEvent == msgType or messageType.npcTradeEvent == msgType then
        msgTypeNum = 1
      elseif messageType.royalTrade == msgType or messageType.supplyTrade == msgType then
        msgTypeNum = 2
      elseif messageType.fitnessLevelUp == msgType then
        msgTypeNum = 3
        normalCheck = false
      elseif messageType.territoryWar_Start == msgType or messageType.territoryWar_End == msgType or messageType.territoryWar_Add == msgType or messageType.territoryWar_Destroy == msgType or messageType.territoryWar_Attack == msgType or messageType.inSiegeArea == msgType or messageType.outSiegeArea == msgType or messageType.Siege2024Raffle == msgType then
        msgTypeNum = 4
        normalCheck = false
      elseif messageType.guildWar_Start == msgType or messageType.guildWar_End == msgType then
        msgTypeNum = 5
        normalCheck = false
      elseif msgType == messageType.roulette or msgType == messageType.horseNineTier or msgType == messageType.anotherPlayerGotItem or msgType == messageType.horseNineTier_dine or msgType == messageType.horseNineTier_Doom or msgType == messageType.fantasyMix_Aduanatt or msgType == messageType.fantasyMix_Dine or msgType == messageType.fantasyMix_Doom then
        msgTypeNum = 6
      elseif messageType.itemMarket == msgType then
        msgTypeNum = 7
      elseif messageType.lifeLevUp == msgType then
        msgTypeNum = 8
      elseif messageType.servantMarket == msgType or messageType.workerMarket == msgType then
        msgTypeNum = 11
      elseif messageType.enchantSuccess == msgType then
        msgTypeNum = 12
      elseif messageType.enchantFail == msgType then
        msgTypeNum = 13
      end
      showJudgment = ToClient_GetMessageFilter(msgTypeNum)
      if true == normalCheck and nil ~= GetUIMode and Defines.UIMode.eUIMode_NpcDialog == GetUIMode() then
        showJudgment = true
      end
    end
    return showJudgment
  end
end
function WhaleHuntingEvent(message, noticeMsgType, noticeValue)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local msgType
  if CppEnums.EChatNoticeType.HuntingStart == noticeMsgType then
    if 0 == noticeValue then
      msgType = messageType.whaleShow
    elseif 1 == noticeValue then
      msgType = messageType.huntingLandShow
    end
  elseif CppEnums.EChatNoticeType.HuntingEnd == noticeMsgType then
    if 0 == noticeValue then
      msgType = messageType.whaleHide
    elseif 1 == noticeValue then
      msgType = messageType.huntingLandHide
    end
    local temporaryWrapper = getTemporaryInformationWrapper()
    local killContributeCount = temporaryWrapper:getKillContributeCount()
    local huntingRankerName = {}
    local isNameless = ToClient_namelessPVPServer()
    for index = 0, killContributeCount - 1 do
      huntingRankerName[index] = temporaryWrapper:getKillContributeNameByIndex(index)
      if temporaryWrapper:getKillContributePartyByIndex(index) then
        local isSelfPlayer = selfPlayer:getUserNickname() == huntingRankerName[index] or selfPlayer:getOriginalName() == huntingRankerName[index]
        if isSelfPlayer == false and isNameless == true then
          huntingRankerName[index] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HUNTING_RESULT_PARTY", "rankerName", PaGlobalFunc_getAnonymousNameString(0))
        else
          huntingRankerName[index] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HUNTING_RESULT_PARTY", "rankerName", huntingRankerName[index])
        end
      end
      huntingRanker[index + 1]:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HUNTING_RESULT_RANK", "rank", index + 1, "rankerName", huntingRankerName[index]))
      huntingRanker[index + 1]:SetFontColor(huntingRankingFont.baseColor[index])
      huntingRanker[index + 1]:useGlowFont(true, huntingRankingFont.size[index], huntingRankingFont.glowColor[index])
    end
  elseif CppEnums.EChatNoticeType.HuntingAlarm == noticeMsgType then
    if 0 == noticeValue then
      msgType = messageType.whaleAlarm
    elseif 1 == noticeValue then
      msgType = messageType.huntingLandAlarm
    end
  elseif CppEnums.EChatNoticeType.HuntingTimeOut == noticeMsgType then
    if 0 == noticeValue then
      msgType = messageType.whaleTimeOut
    elseif 1 == noticeValue then
      msgType = messageType.huntingLandTimeOut
    end
  end
  if CppEnums.EChatNoticeType.HuntingStart == noticeMsgType or CppEnums.EChatNoticeType.HuntingEnd == noticeMsgType then
    local msg = {
      main = message,
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_HUNTING_RULE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, msgType)
  else
    local msg = {
      main = message,
      sub = " ",
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, msgType)
  end
  if false == _ContentsGroup_RemasterUI_Main_RightTop and false == _ContentsGroup_RenewUI then
    FGlobal_WhaleConditionCheck()
  end
  if true == _ContentsGroup_RemasterUI_Main_Alert then
    PaGlobalFunc_Widget_Alert_Check_Hunting()
  end
end
function FGlobal_WorldBossShow(message, noticeType, noticeValue)
  local msg = {
    main = message,
    sub = " ",
    addMsg = ""
  }
  local msgType = messageType.worldBossShow
  if 11 == noticeType then
    if 0 == noticeValue then
      audioPostEvent_SystemUi(19, 0)
      _AudioPostEvent_SystemUiForXBOX(19, 0)
    elseif 1 == noticeValue then
      audioPostEvent_SystemUi(19, 0)
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 0)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.worldBossjinKzaka
    end
  elseif 12 == noticeType then
    if 0 == noticeValue then
      audioPostEvent_SystemUi(19, 1)
      _AudioPostEvent_SystemUiForXBOX(19, 1)
      msgType = messageType.worldBossNuver
    elseif 1 == noticeValue then
      audioPostEvent_SystemUi(19, 4)
      _AudioPostEvent_SystemUiForXBOX(19, 4)
      msgType = messageType.worldBossKaranda
    elseif 2 == noticeValue then
      audioPostEvent_SystemUi(19, 5)
      _AudioPostEvent_SystemUiForXBOX(19, 5)
      msgType = messageType.worldBossKutum
    elseif 3 == noticeValue or 4 == noticeValue or 5 == noticeValue or 6 == noticeValue then
      audioPostEvent_SystemUi(19, 6)
      _AudioPostEvent_SystemUiForXBOX(19, 6)
      msgType = messageType.fieldBoss
    elseif 7 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.eventBossTurking
    elseif 8 == noticeValue or 9 == noticeValue then
      audioPostEvent_SystemUi(19, 8)
      _AudioPostEvent_SystemUiForXBOX(19, 8)
    elseif 10 == noticeValue then
      audioPostEvent_SystemUi(19, 9)
      _AudioPostEvent_SystemUiForXBOX(19, 9)
      msgType = messageType.bellBoss
    elseif 11 == noticeValue then
      audioPostEvent_SystemUi(19, 10)
      _AudioPostEvent_SystemUiForXBOX(19, 10)
      msgType = messageType.eventBossMamos
    elseif 12 == noticeValue then
      audioPostEvent_SystemUi(19, 11)
      _AudioPostEvent_SystemUiForXBOX(19, 11)
      msgType = messageType.eventBossIsabella
    elseif 13 == noticeValue then
      audioPostEvent_SystemUi(19, 12)
      _AudioPostEvent_SystemUiForXBOX(19, 12)
      msgType = messageType.fieldBossOpin
    elseif 14 == noticeValue then
      audioPostEvent_SystemUi(19, 13)
      _AudioPostEvent_SystemUiForXBOX(19, 13)
      msgType = messageType.worldBossGamos
    elseif 15 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.wolfAppear
    elseif 16 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.wolfNotAppear
    elseif 17 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.termianNineShark
    elseif 18 == noticeValue then
      audioPostEvent_SystemUi(19, 14)
      _AudioPostEvent_SystemUiForXBOX(19, 14)
      msgType = messageType.secrid
    elseif 19 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.berserk_Zod
    elseif 20 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.thousandWar
    elseif 22 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.belmorn
    elseif 23 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.worldBossJinNuver
    elseif 24 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.worldBossJinKaranda
    elseif 25 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.fieldBossBlackShadow
    elseif 26 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.nuberu
    elseif 27 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.worldBossJinKutum
    elseif 28 == noticeValue then
      audioPostEvent_SystemUi(19, 15)
      _AudioPostEvent_SystemUiForXBOX(19, 15)
      msgType = messageType.eventBossDongSim12
    elseif 29 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.train
    elseif 30 == noticeValue then
      audioPostEvent_SystemUi(19, 16)
      _AudioPostEvent_SystemUiForXBOX(19, 16)
      msgType = messageType.BabyBell
    elseif 31 == noticeValue then
      audioPostEvent_SystemUi(25, 4)
      _AudioPostEvent_SystemUiForXBOX(25, 4)
      msgType = messageType.DragonPalaceCommon
    elseif 100 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.termianEvent_1
    elseif noticeValue >= 101 and noticeValue <= 105 then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.termianEvent_2
    elseif 106 == noticeValue then
      audioPostEvent_SystemUi(19, 7)
      _AudioPostEvent_SystemUiForXBOX(19, 7)
      msgType = messageType.termianEvent_3
    elseif 200 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.morningLandWorldBossBulgasal
    elseif 201 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.morningLandWorldBossUturi
    elseif 202 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.morningLandWorldBossSangun
    elseif 203 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.morningLandWorldBossDuoksini
    elseif 204 == noticeValue then
      audioPostEvent_SystemUi(19, 51)
      _AudioPostEvent_SystemUiForXBOX(19, 51)
      msgType = messageType.morningLandWorldBossGoldenPig
    end
  elseif 16 == noticeType then
    audioPostEvent_SystemUi(19, 7)
    _AudioPostEvent_SystemUiForXBOX(19, 7)
    msgType = messageType.savageDefenceBoss
  elseif 13 == noticeType then
  elseif CppEnums.EChatNoticeType.LauLauShow == noticeType then
    msgType = messageType.LauLauShow
  elseif CppEnums.EChatNoticeType.LauLauEnd == noticeType then
    msgType = messageType.LauLauHide
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 6, msgType)
end
function FromClient_ShowGuildMatchPlayNak(nakType)
  local msgType
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if nakType == __eGuildMatchNakUIType_JoinMatching then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_1")
    msgType = messageType.guildBattleNormal
  elseif nakType == __eGuildMatchNakUIType_CancelMatching then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_2")
    msgType = messageType.guildBattleNormal
  elseif nakType == __eGuildMatchNakUIType_CompleteMatching then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_3")
    msgType = messageType.guildBattleNormal
  elseif nakType == __eGuildMatchNakUIType_StartGame then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_4")
    msgType = messageType.guildBattleStart
  elseif nakType == __eGuildMatchNakUIType_StopGame then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_5")
    msgType = messageType.guildBattleEnd
  elseif nakType == __eGuildMatchNakUIType_FailedMatchingByNotRoom then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_7")
    msgType = messageType.guildBattleEnd
  elseif nakType == __eGuildMatchNakUIType_FailedMatchingByNotTarget then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_6")
    msgType = messageType.guildBattleEnd
  elseif nakType == __eGuildMatchNakUIType_FailedMatchingByUnknown then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_BIGNAK_8")
    msgType = messageType.guildBattleEnd
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\130\152\237\129\172 \237\131\128\236\158\133\236\157\180 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164. \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\133\168\235\130\152\236\154\148?", "\236\157\180\236\163\188")
    return
  end
  if msgType ~= nil then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, msgType)
  end
end
function Proc_ShowMessage_Ack_For_RewardSelect(message, showRate, msgType, exposure, isSelfPlayer)
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, showRate, msgType, exposure, isSelfPlayer)
  if CppEnums.EChatNoticeType.Ocean == msgType or CppEnums.EChatNoticeType.Invasion == msgType or CppEnums.EChatNoticeType.Noti == msgType then
    return
  end
  if messageType.itemMarket == msgType then
    return
  end
  for index = 1, 5 do
    huntingRanker[index]:SetShow(false)
  end
  if messageType.itemMarket == msgType or messageType.guildMsg == msgType or messageType.lifeLevUp == msgType or messageType.alchemyStoneGrowUp == msgType or msgType >= messageType.territoryWar_Start and msgType <= messageType.guildWar_End or messageType.raceAnother == msgType or messageType.localWarJoin == msgType or messageType.goldenBell == msgType or messageType.guildServantRegist == msgType or messageType.competitionRound == msgType or messageType.guildBattleStart == msgType or messageType.guildBattleEnd == msgType or messageType.xmasGoldenBell == msgType or messageType.freeBell == msgType or messageType.reportLocationBadPlayer == msgType or messageType.reportWantedBadPlayer == msgType or messageType.getGrowthPassRewardItem == msgType or messageType.morningBoss == msgType or messageType.thousandInsam == msgType then
    chatting_sendMessage("", message.main .. " " .. message.sub, CppEnums.ChatType.System)
  elseif messageType.getValenciaItem == msgType or messageType.anotherPlayerGotItem == msgType or messageType.enchantSuccess == msgType then
  elseif messageType.enchantFail == msgType then
  elseif messageType.playerKiller == msgType then
    if "" == message.sub then
      chatting_sendMessage("", message.main, CppEnums.ChatType.System)
    else
      chatting_sendMessage("", message.main .. "(" .. message.sub .. ")", CppEnums.ChatType.System)
    end
  elseif messageType.servantMarket == msgType then
    if "" == message.sub then
      chatting_sendMessage("", message.main, CppEnums.ChatType.System)
    else
      chatting_sendMessage("", message.main .. "(" .. message.sub .. ")", CppEnums.ChatType.System)
    end
  elseif messageType.workerMarket == msgType then
    if "" == message.sub then
      chatting_sendMessage("", message.main, CppEnums.ChatType.System)
    else
      chatting_sendMessage("", message.main .. "(" .. message.sub .. ")", CppEnums.ChatType.System)
    end
  elseif messageType.guildBattleNormal == msgType or messageType.guildBattleStart == msgType or messageType.guildBattleEnd == msgType then
    chatting_sendMessage("", message.main, CppEnums.ChatType.System)
  elseif messageType.guildDrillInstall == msgType or messageType.guildDrillComplete == msgType or messageType.guildDrillDelete == msgType then
    chatting_sendMessage("", message.main, CppEnums.ChatType.System)
  elseif messageType.startVote == msgType or messageType.endVote == msgType then
    chatting_sendMessage("", message.main, CppEnums.ChatType.System)
  elseif messageType.activePolicy == msgType then
    chatting_sendMessage("", message.sub .. " " .. message.main, CppEnums.ChatType.System)
  elseif msgType == messageType.eventDraw then
    isForceShowMessage = true
  elseif "" == message.sub then
    chatting_sendMessage("", message.main, CppEnums.ChatType.System)
  else
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  end
  if messageType.richMerchantRing == msgType then
    isForceShowMessage = true
  end
end
function Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, showRate, msgType, exposure, isSelfPlayer)
  if nil ~= message.onlyChat and true == message.onlyChat then
    return
  end
  if true == isForceShowMessage then
    return
  end
  if TutorialQuestCompleteCheck ~= nil and not TutorialQuestCompleteCheck() and (msgType >= 10 and msgType < 22 or msgType > 32) then
    return
  end
  if true == _ContentsGroup_UsePadSnapping and messageType.characterHPwarning == msgType then
    return
  end
  if true == PaGlobalFunc_NakMessage_CheckReturnMiniGame() then
    return
  end
  if NoShowMessageReturn(msgType, isSelfPlayer) then
    return
  end
  if msgType == messageType.eventDraw and isSelfPlayer == true then
    return
  end
  if 0 < ToClient_GetMyTeamNoLocalWar() and (nil == exposure or true == exposure) then
    return
  end
  if ToClient_IsMyselfInArena() and (nil == exposure or true == exposure) then
    return
  end
  if ToClient_getPlayNowSavageDefence() and (nil == exposure or true == exposure) then
    return
  end
  if true == ToClient_getJoinGuildBattle() and (nil == exposure or true == exposure) then
    return
  end
  local elfWarState = ToClient_GetElfWarState()
  local isParticipateInElfWar = ToClient_IsParticipateInElfWar()
  if elfWarState == __eElfWar_Start and isParticipateInElfWar == true and msgType ~= messageType.ElfWarStart and msgType ~= messageType.ElfWarKamasylviaWin and msgType ~= messageType.ElfWarOdylitaWin and msgType ~= messageType.ElfWarTie and msgType ~= messageType.guildNotify then
    return
  end
  if _ContentsGroup_GuildMatch == true and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_GuildMatch) == true and msgType ~= messageType.guildBattleNormal and msgType ~= messageType.guildBattleStart and msgType ~= messageType.guildBattleEnd and msgType ~= messageType.guildNotify then
    return
  end
  if nil == showRate then
    animationEndTime = 2.3
    elapsedTime = 2.3
  else
    animationEndTime = showRate
    elapsedTime = showRate
  end
  curIndex = curIndex + 1
  MessageData._Msg[curIndex] = {}
  MessageData._Msg[curIndex].msg = message
  MessageData._Msg[curIndex].type = msgType
  Panel_RewardSelect_NakMessage:SetShow(true, false)
  stc_blackBG:SetShow(false)
  NakMessagePanel_Resize_For_RewardSelect()
  if msgType == messageType.PanOkSeonPersonal then
    isForceShowMessage = true
  end
end
function Proc_ShowMessage_FrameEvent_For_RewardSelect(messageNum)
  local msg = {
    main = PAGetString(Defines.StringSheet_GAME, frameEventMessageIds[messageNum]),
    sub = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 4, 4)
end
local tradeEvent, _npcKey
function FGlobal_TradeEventInfo()
  return tradeEvent
end
function FGlobal_TradeEvent_Npckey_Return()
  return _npcKey
end
function FGlobal_FitnessLevelUp(addSp, addWeight, addHp, addMp, _type)
  audioPostEvent_SystemUi(3, 15)
  _AudioPostEvent_SystemUiForXBOX(3, 15)
  local playerWrapper = getSelfPlayer()
  local classType = playerWrapper:getClassType()
  local set_subString = ""
  if addSp > 0 then
    set_subString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_LvupStatus1", "AddSp", addSp, "GetMaxSp", getSelfPlayer():get():getStamina():getMaxSp())
  end
  if addWeight > 0 then
    local comma = ", "
    if "" == set_subString then
      comma = ""
    end
    set_subString = set_subString .. comma .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_LvupStatus2", "AddWeight", addWeight / 10000, "UserWeight", Int64toInt32(getSelfPlayer():get():getPossessableWeight_s64()) / 10000)
    Inventory_updateSlotData()
    FromClient_CharInfoBasic_All_WeightUpdate()
  end
  if addHp > 0 then
    local comma = ", "
    if "" == set_subString then
      comma = ""
    end
    set_subString = set_subString .. comma .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXHPUP") .. "<PAColor0xFFFFBD2E>+" .. addHp .. "<PAOldColor>"
  end
  if addMp > 0 then
    local comma = ", "
    if "" == set_subString then
      comma = ""
    end
    local mpType = CppEnums.ClassType_MpType[classType]
    if mpType == nil then
      mpType = CppEnums.MpBarColor.MP
    end
    if mpType == CppEnums.MpBarColor.EP or mpType == CppEnums.MpBarColor.MP then
      set_subString = set_subString .. comma .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXMPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    elseif mpType == CppEnums.MpBarColor.DARKELF then
      set_subString = set_subString .. comma .. "" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXEPUP", "ep", addMp)
    elseif mpType == CppEnums.MpBarColor.FP then
      set_subString = set_subString .. comma .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXFPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    elseif mpType == CppEnums.MpBarColor.BP then
      set_subString = set_subString .. comma .. PAGetString(Defines.StringSheet_GAME, "LUA_LEVELUP_REWARD_MAXBPUP") .. "<PAColor0xFFFFBD2E>+" .. addMp .. "<PAOldColor>"
    end
  end
  local mainTitle = ""
  if 0 == _type then
    mainTitle = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DEX")
  elseif 1 == _type then
    mainTitle = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_STR")
  elseif 2 == _type then
    mainTitle = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_CON")
  end
  local message = {
    main = mainTitle,
    sub = set_subString,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 3.5, 9)
end
local function MessageOpen()
  if true == isForceShowMessage then
    local aniInfo = stc_centerMessage:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
    aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
    local aniInfo2 = stc_centerMessage:addColorAnimation(animationEndTime - 0.15, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
    aniInfo2:SetEndColor(Defines.Color.C_00FFFFFF)
    local aniInfo3 = txt_centerMessage:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
    aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
    local aniInfo4 = txt_centerMessage:addColorAnimation(animationEndTime - 0.15, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
    aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
    local aniInfo = PanOkSeonWorld.stc_PanOkSeonPersonal:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
    aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
    local aniInfo2 = PanOkSeonWorld.stc_PanOkSeonPersonal:addColorAnimation(animationEndTime - 0.15, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
    aniInfo2:SetEndColor(Defines.Color.C_00FFFFFF)
    local aniInfo3 = PanOkSeonWorld.stc_PanOkSeonPersonal_MultiDesc:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
    aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
    local aniInfo4 = PanOkSeonWorld.stc_PanOkSeonPersonal_MultiDesc:addColorAnimation(animationEndTime - 0.15, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
    aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
    aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
    return
  end
  local axisX = Panel_RewardSelect_NakMessage:GetSizeX() / 2
  local axisY = Panel_RewardSelect_NakMessage:GetSizeY() / 2
  local aniInfo = Panel_RewardSelect_NakMessage:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  if 0 == changeTextPosY then
    local aniInfo2 = Panel_RewardSelect_NakMessage:addScaleAnimation(0.15, animationEndTime - 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
    aniInfo2:SetStartScale(1)
    aniInfo2:SetEndScale(1)
    aniInfo2.AxisX = axisX
    aniInfo2.AxisY = axisY
    aniInfo2.ScaleType = 2
    aniInfo2.IsChangeChild = true
  end
  local aniInfo3 = Panel_RewardSelect_NakMessage:addColorAnimation(animationEndTime - 0.15, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
end
local function Boss_MessageOpen()
  local axisX = Panel_RewardSelect_NakMessage:GetSizeX() / 2
  local axisY = Panel_RewardSelect_NakMessage:GetSizeY() / 2
  local aniInfo = Panel_RewardSelect_NakMessage:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = Panel_RewardSelect_NakMessage:addScaleAnimation(0.15, animationEndTime - 1.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_PI)
  aniInfo2:SetStartScale(1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = axisX
  aniInfo2.AxisY = axisY
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  local aniInfo3 = Panel_RewardSelect_NakMessage:addColorAnimation(animationEndTime - 1.25, animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
end
function NakMessage_SetDefaultRewardItemState()
  bigNakMsg:SetShow(false)
  _text_Msg:SetShow(false)
  _text_MsgSub:SetShow(false)
  competitionBg:SetShow(false)
  competitionMsg:SetShow(false)
  competitionCount:SetShow(false)
  stc_worldBossNewJin:SetShow(false)
  stc_NoticeImage:SetShow(false)
  stc_bossImage:SetShow(false)
  eventUI._stc_eventBossNewJin:SetShow(false)
  stc_rewardItemBG:SetShow(true)
  stc_solareRankgame:SetShow(false)
  stc_arbitrationGuildWar:SetShow(false)
  local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
  stc_HuntingBg:SetShow(false)
  stc_HuntingBg:EraseAllEffect()
  local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
  stc_bigShipBg:SetShow(false)
  stc_bigShipBg:EraseAllEffect()
  UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
end
function NakMessage_UpdateRewardItemState(titleText, descText, iconPath)
  if nil == titleText or nil == descText or nil == iconPath then
    return
  end
  if nil == stc_rewardItemBG then
    return
  end
  stc_rewardItemIcon:ChangeTextureInfoName(iconPath)
  stc_rewardItemTitle:SetFontColor(Defines.Color.C_FFFFEF82)
  stc_rewardItemTitle:SetText(titleText)
  stc_rewardItemDesc:SetFontColor(Defines.Color.C_FFFFEF82)
  stc_rewardItemDesc:SetText(descText)
end
function PaGlobalFunc_NakMessage_SetChangeNakSize(msgData)
  if msgData == nil then
    return
  end
  if msgData.type == messageType.thousandWar then
    changeSizeX = 600
    changeSizeY = 235
    changeTextPosY = 105
  end
end
local tempMsg
function NakMessageUpdate_For_RewardSelect(updateTime)
  if isLuaLoadingComplete and Panel_Acquire ~= nil and Panel_Acquire:GetShow() then
    return
  end
  if false == _ContentsGroup_RenewUI_Tutorial then
    local isShow = false
    if true == _ContentsGroup_Tutorial_Renewal then
      isShow = Panel_Tutorial_Renew ~= nil and Panel_Tutorial_Renew:GetShow() == true
    else
      isShow = Panel_Tutorial ~= nil and Panel_Tutorial:GetShow() == true
    end
    if true == isShow then
      return
    end
    if Panel_LifeTutorial ~= nil and Panel_LifeTutorial:GetShow() then
      return
    end
  elseif Panel_Tutorial_Renew ~= nil and Panel_Tutorial_Renew:GetShow() then
    return
  end
  if Panel_IngameCashShop ~= nil and Panel_IngameCashShop:GetShow() or Panel_Cash_Customization ~= nil and Panel_Cash_Customization:GetShow() or Panel_IngameCashShop_Controller ~= nil and Panel_IngameCashShop_Controller:GetShow() then
    return
  end
  if false == _ContentsGroup_RenewUI_Dyeing then
    if _ContentsGroup_NewUI_Dye_All then
      if nil ~= Panel_Widget_CharacterController_All and Panel_Widget_CharacterController_All:GetShow() then
        return
      end
    elseif Panel_Dye_ReNew ~= nil and Panel_Dye_ReNew:GetShow() or Panel_DyeNew_CharacterController ~= nil and Panel_DyeNew_CharacterController:GetShow() then
      return
    end
  end
  if Defines.UIMode.eUIMode_InGameCustomize == GetUIMode() or Defines.UIMode.eUIMode_ScreenShotMode == GetUIMode() then
    return
  end
  elapsedTime = elapsedTime + updateTime
  if animationEndTime <= elapsedTime then
    if processIndex < curIndex then
      PaGlobalFunc_NakMessage_SetChangeNakSize(MessageData._Msg[processIndex + 1])
      if messageType.defeatBoss == MessageData._Msg[processIndex + 1].type then
        Boss_MessageOpen()
      else
        MessageOpen()
      end
      processIndex = processIndex + 1
      NakMessagePanel_Resize_For_RewardSelect()
      PaGlobal_RewardSelect_SetDefault()
      if messageType.localWarWin == MessageData._Msg[processIndex].type or messageType.localWarLose == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        localwarMsg:SetShow(true)
        localwarMsgSmallBG:SetShow(false)
        localwarMsgBG:SetShow(true)
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(true)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        localwarMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
      elseif messageType.nationSiegeStart == MessageData._Msg[processIndex].type or messageType.nationSiegeStop == MessageData._Msg[processIndex].type or messageType.nationSiegeCalpheonWin == MessageData._Msg[processIndex].type or messageType.nationSeigeValenciaWin == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        localwarMsg:SetShow(false)
        localwarMsgSmallBG:SetShow(false)
        localwarMsgBG:SetShow(false)
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        nationSiegeBG:SetShow(true)
        nationSiegeText:SetShow(true)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        nationSiegeBG:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
      elseif messageType.localWarTurnAround == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        bigNakMsg:SetShow(false)
        localwarMsg:SetShow(false)
        localwarMsgSmallBG:SetShow(true)
        _text_localwarMsg:SetShow(true)
        localwarMsgBG:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        localwarMsgSmallBG:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
      elseif messageType.localWarCriticalBlack == MessageData._Msg[processIndex].type or messageType.localWarCriticalRed == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        localwarMsg:SetShow(false)
        localwarMsgSmallBG:SetShow(true)
        localwarMsgBG:SetShow(false)
        _text_localwarMsg:SetShow(true)
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(true)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        localwarMsgSmallBG:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
      elseif messageType.arshaSpearCountDown == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        localwarMsg:SetShow(false)
        localwarMsgSmallBG:SetShow(false)
        localwarMsgBG:SetShow(false)
        _text_localwarMsg:SetShow(false)
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(true)
        competitionMsg:SetShow(true)
        competitionCount:SetShow(true)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.belmorn == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(true)
        belmornText:SetShow(true)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.worldBossjinKzaka == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
        stc_worldBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_worldBossImage, 334, 778, 666, 960)
        stc_worldBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_worldBossImage:setRenderTexture(stc_worldBossImage:getBaseTexture())
      elseif messageType.worldBossJinNuver == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
        stc_worldBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_worldBossImage, 667, 778, 999, 960)
        stc_worldBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_worldBossImage:setRenderTexture(stc_worldBossImage:getBaseTexture())
      elseif messageType.worldBossJinKaranda == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
        stc_worldBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_worldBossImage, 1000, 595, 1332, 777)
        stc_worldBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_worldBossImage:setRenderTexture(stc_worldBossImage:getBaseTexture())
      elseif messageType.fieldBossBlackShadow == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
        stc_worldBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_worldBossImage, 1000, 229, 1332, 411)
        stc_worldBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_worldBossImage:setRenderTexture(stc_worldBossImage:getBaseTexture())
      elseif messageType.nuberu == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_bossImage:SetShow(true)
        stc_bossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
      elseif messageType.LauLauShow == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        stc_centerMessage:SetShow(false)
        stc_leftNPC:SetShow(false)
        stc_rightNPC:SetShow(false)
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        local stc_HuntingTiTle = UI.getChildControl(stc_HuntingBg, "StaticText_Title")
        local stc_HuntingDesc = UI.getChildControl(stc_HuntingBg, "StaticText_Desc")
        stc_HuntingBg:SetShow(true)
        stc_HuntingTiTle:SetShow(true)
        stc_HuntingDesc:SetShow(true)
        stc_HuntingTiTle:SetText(MessageData._Msg[processIndex].msg.main)
        stc_HuntingDesc:SetText(MessageData._Msg[processIndex].msg.sub)
        stc_HuntingBg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_HuntingBg, 1, 1, 945, 370)
        stc_HuntingBg:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_HuntingBg:setRenderTexture(stc_HuntingBg:getBaseTexture())
        stc_HuntingBg:SetSize(945, 370)
        stc_HuntingTiTle:SetSpanSize(0, 225)
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        stc_HuntingBg:EraseAllEffect()
        stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
        stc_bigShipBg:SetShow(false)
        stc_bigShipBg:EraseAllEffect()
        audioPostEvent_SystemUi(19, 51)
        _AudioPostEvent_SystemUiForXBOX(19, 51)
      elseif messageType.LauLauHide == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        stc_centerMessage:SetShow(false)
        stc_leftNPC:SetShow(false)
        stc_rightNPC:SetShow(false)
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        local stc_HuntingTiTle = UI.getChildControl(stc_HuntingBg, "StaticText_Title")
        local stc_HuntingDesc = UI.getChildControl(stc_HuntingBg, "StaticText_Desc")
        stc_HuntingBg:SetShow(true)
        stc_HuntingTiTle:SetShow(true)
        stc_HuntingDesc:SetShow(true)
        stc_HuntingTiTle:SetText(MessageData._Msg[processIndex].msg.main)
        stc_HuntingDesc:SetText(MessageData._Msg[processIndex].msg.sub)
        stc_HuntingBg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_HuntingBg, 1, 1, 945, 370)
        stc_HuntingBg:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_HuntingBg:setRenderTexture(stc_HuntingBg:getBaseTexture())
        stc_HuntingBg:SetSize(945, 370)
        stc_HuntingTiTle:SetSpanSize(0, 225)
        local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
        stc_bigShipBg:SetShow(false)
        stc_bigShipBg:EraseAllEffect()
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        stc_HuntingBg:EraseAllEffect()
        stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        audioPostEvent_SystemUi(19, 52)
        _AudioPostEvent_SystemUiForXBOX(19, 52)
      elseif messageType.worldBossJinKutum == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
        stc_worldBossImage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_worldBossImage, 1000, 778, 1332, 960)
        stc_worldBossImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_worldBossImage:setRenderTexture(stc_worldBossImage:getBaseTexture())
      elseif messageType.train == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(true)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        bigNakMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
      elseif messageType.ocean == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(true)
        if nil ~= MessageData._Msg[processIndex].msg then
          txt_notice:SetText(MessageData._Msg[processIndex].msg)
        end
        stc_NoticeImage:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Notification_Nak.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(stc_NoticeImage, 0, 0, 990, 230)
        stc_NoticeImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_NoticeImage:setRenderTexture(stc_NoticeImage:getBaseTexture())
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_bossImage:SetShow(false)
      elseif messageType.invasion == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(true)
        if nil ~= MessageData._Msg[processIndex].msg then
          txt_notice:SetText(MessageData._Msg[processIndex].msg)
        end
        stc_NoticeImage:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Notification_Nak.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(stc_NoticeImage, 0, 231, 990, 461)
        stc_NoticeImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_NoticeImage:setRenderTexture(stc_NoticeImage:getBaseTexture())
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_bossImage:SetShow(false)
      elseif messageType.noti == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(true)
        if nil ~= MessageData._Msg[processIndex].msg then
          txt_notice:SetText(MessageData._Msg[processIndex].msg)
        end
        stc_NoticeImage:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Notification_Nak.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(stc_NoticeImage, 0, 462, 990, 692)
        stc_NoticeImage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_NoticeImage:setRenderTexture(stc_NoticeImage:getBaseTexture())
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_bossImage:SetShow(false)
      elseif messageType.guildDrillInstall == MessageData._Msg[processIndex].type or messageType.guildDrillComplete == MessageData._Msg[processIndex].type or messageType.guildDrillDelete == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(true)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        bigNakMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
      elseif messageType.startVote == MessageData._Msg[processIndex].type or messageType.startVote == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(true)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        bigNakMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
      elseif messageType.activePolicy == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(true)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(true)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        bigNakMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
      elseif messageType.richMerchantRing == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        stc_centerMessage:SetShow(true)
        stc_leftNPC:SetShow(true)
        stc_rightNPC:SetShow(true)
        stc_centerMessage:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_centerMessage, 1, 1, 1919, 117)
        stc_centerMessage:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_centerMessage:setRenderTexture(stc_centerMessage:getBaseTexture())
        stc_centerMessage:SetSize(1919, 117)
        txt_centerMessage:ComputePos()
        stc_leftNPC:SetSpanSize(stc_leftNPC:GetSpanSize().x, 116)
        stc_rightNPC:SetSpanSize(stc_rightNPC:GetSpanSize().x, 116)
        Panel_RewardSelect_NakMessage:ResetVertexAni()
        if true == PaGlobal_RewardSelect_RichMerchantRing_CheckLanguage() then
          PaGlobal_RewardSelect_RichMerchantRing_ChangeMessageSize()
        end
      elseif messageType.getGrowthPassRewardItem == MessageData._Msg[processIndex].type then
        eventDrawUIOff()
        NakMessage_SetDefaultRewardItemState()
      elseif messageType.eventBossDongSim12 == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOn()
        eventDrawUIOff()
      elseif messageType.eventDraw == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(false)
        eventBossUIOff()
        eventDrawUIOn(MessageData._Msg[processIndex].msg)
      elseif messageType.morningBoss == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOn(MessageData._Msg[processIndex].msg)
      elseif messageType.thousandInsam == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOn(MessageData._Msg[processIndex].msg)
      elseif messageType.PanOkSeonPersonal == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_PanOkSeonPersonal_First(MessageData._Msg[processIndex].msg)
      elseif messageType.PanOkSeonWorld == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_PanOkSeonWorld_First(MessageData._Msg[processIndex].msg)
      elseif messageType.BabyBell == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOn(MessageData._Msg[processIndex].msg)
      elseif messageType.DragonPalaceCommon == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.CrogdaloStable == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.Telescope == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.ElementalBossBuffSun == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.ElementalBossBuffMoon == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.ElementalBossBuffLand == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.ElfWarApplyGuild == MessageData._Msg[processIndex].type or messageType.ElfWarApplyMercenary == MessageData._Msg[processIndex].type or messageType.ElfWarRaffleGuild == MessageData._Msg[processIndex].type or messageType.ElfWarRaffleMercenary == MessageData._Msg[processIndex].type or messageType.ElfWarStart == MessageData._Msg[processIndex].type or messageType.ElfWarKamasylviaWin == MessageData._Msg[processIndex].type or messageType.ElfWarOdylitaWin == MessageData._Msg[processIndex].type or messageType.ElfWarTie == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.Siege2024Raffle == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        siege2024Raffle:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.morningLandWorldBossBulgasal == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossUturi == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossSangun == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossDuoksini == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossGoldenPig == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      elseif messageType.KingAccessory == MessageData._Msg[processIndex].type then
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        belmornBG:SetShow(false)
        belmornText:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        bigNakMsg:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        Panel_RewardSelect_NakMessage:SetShow(true)
        eventBossUIOff()
        eventDrawUIOff()
      else
        bigNakMsg:SetShow(true)
        _text_Msg:SetShow(true)
        _text_MsgSub:SetShow(true)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        bigNakMsg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
      end
      _text_AddMsg:SetShow(false)
      nakItemIconBG:SetShow(false)
      nakItemIcon:SetShow(false)
      for index = 1, 5 do
        huntingRanker[index]:SetShow(false)
      end
      if messageType.safetyArea == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_ffdeff6d)
        _text_MsgSub:SetFontColor(Defines.Color.C_ffdeff6d)
      elseif messageType.combatArea == MessageData._Msg[processIndex].type then
        if true == _ContentsGroup_ChinaFontColor then
          _text_Msg:SetFontColor(Defines.Color.C_FFFFEDD4)
          _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEDD4)
        else
          _text_Msg:SetFontColor(Defines.Color.C_ffff8181)
          _text_MsgSub:SetFontColor(Defines.Color.C_ffff8181)
        end
      elseif messageType.desertArea == MessageData._Msg[processIndex].type then
        if true == _ContentsGroup_ChinaFontColor then
          _text_Msg:SetFontColor(Defines.Color.C_FFFFEDD4)
          _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEDD4)
        else
          _text_Msg:SetFontColor(Defines.Color.C_ffff8181)
          _text_MsgSub:SetFontColor(Defines.Color.C_ffff8181)
        end
      elseif messageType.challengeComplete == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
      elseif messageType.normal == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
      elseif messageType.itemMarket == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
      elseif messageType.CrogdaloStable == MessageData._Msg[processIndex].type then
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(false)
      elseif messageType.servantMarket == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        stallionIcon:SetShow(isServantStallion)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.workerMarket == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.territoryTradeEvent == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_AddMsg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_AddMsg:SetShow(true)
      elseif messageType.npcTradeEvent == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_AddMsg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_AddMsg:SetShow(true)
      elseif messageType.royalTrade == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        audioPostEvent_SystemUi(3, 18)
        _AudioPostEvent_SystemUiForXBOX(3, 18)
        bigNakMsg:AddEffect("UI_ImperialLight", false, 0, 15)
        bigNakMsg:AddEffect("fUI_ImperialStart", false, 0, -10)
      elseif messageType.supplyTrade == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        audioPostEvent_SystemUi(3, 18)
        _AudioPostEvent_SystemUiForXBOX(3, 18)
        bigNakMsg:AddEffect("UI_ImperialLight", false, 0, 15)
        bigNakMsg:AddEffect("fUI_ImperialStart", false, 0, -10)
      elseif messageType.territoryWar_Start == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_SiegeWarfare_Win_Green", false, -2, 0)
        bigNakMsg:AddEffect("fui_skillawakenboom_green", false, -2, 0)
        audioPostEvent_SystemUi(15, 0)
        _AudioPostEvent_SystemUiForXBOX(15, 0)
      elseif messageType.territoryWar_End == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_SiegeWarfare_Win", false, -2, 0)
        bigNakMsg:AddEffect("fUI_SkillAwakenBoom", false, -2, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif messageType.territoryWar_Add == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_CastlePlusLight", false, 0, 0)
        audioPostEvent_SystemUi(15, 1)
        _AudioPostEvent_SystemUiForXBOX(15, 1)
      elseif messageType.territoryWar_Destroy == MessageData._Msg[processIndex].type then
        bigNakMsg:EraseAllEffect()
        bigNakMsg:AddEffect("UI_CastleMinusLight", false, 0, 0)
        audioPostEvent_SystemUi(15, 2)
        _AudioPostEvent_SystemUiForXBOX(15, 2)
      elseif messageType.territoryWar_Attack == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_SiegeWarfare_Alarm", true, 3, -22)
        audioPostEvent_SystemUi(15, 3)
        _AudioPostEvent_SystemUiForXBOX(15, 3)
      elseif messageType.guildWar_Start == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_SiegeWarfare_Win_Red", false, 3, 0)
        bigNakMsg:AddEffect("fui_skillawakenboom_red", false, 3, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif messageType.guildWar_End == MessageData._Msg[processIndex].type then
        bigNakMsg:AddEffect("UI_SiegeWarfare_Win_Red", false, 3, 0)
        bigNakMsg:AddEffect("fui_skillawakenboom_red", false, 3, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif messageType.roulette == MessageData._Msg[processIndex].type then
        audioPostEvent_SystemUi(11, 11)
        _AudioPostEvent_SystemUiForXBOX(11, 11)
        bigNakMsg:AddEffect("UI_Gacha_Message", false, 0.5, 0)
      elseif messageType.anotherPlayerGotItem == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.enchantSuccess == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.horseNineTier == MessageData._Msg[processIndex].type or messageType.horseNineTier_dine == MessageData._Msg[processIndex].type or messageType.horseNineTier_Doom == MessageData._Msg[processIndex].type or messageType.fantasyMix_Aduanatt == MessageData._Msg[processIndex].type or messageType.fantasyMix_Dine == MessageData._Msg[processIndex].type or messageType.fantasyMix_Doom == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.enchantFail == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.alchemyStoneGrowUp == MessageData._Msg[processIndex].type then
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.characterHPwarning == MessageData._Msg[processIndex].type then
        if true == _ContentsGroup_ChinaFontColor then
          _text_Msg:SetFontColor(Defines.Color.C_FFFFEDD4)
          _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEDD4)
        else
          _text_Msg:SetFontColor(Defines.Color.C_ffff8181)
          _text_MsgSub:SetFontColor(Defines.Color.C_ffff8181)
        end
        audioPostEvent_SystemUi(8, 15)
        _AudioPostEvent_SystemUiForXBOX(8, 15)
      elseif messageType.servantWarning == MessageData._Msg[processIndex].type then
        if true == _ContentsGroup_ChinaFontColor then
          _text_Msg:SetFontColor(Defines.Color.C_FFFFEDD4)
          _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEDD4)
        else
          _text_Msg:SetFontColor(Defines.Color.C_ffff8181)
          _text_MsgSub:SetFontColor(Defines.Color.C_ffff8181)
        end
        audioPostEvent_SystemUi(8, 14)
        _AudioPostEvent_SystemUiForXBOX(8, 14)
      elseif messageType.defeatBoss == MessageData._Msg[processIndex].type then
        if true == _ContentsGroup_ChinaFontColor then
          _text_Msg:SetFontColor(Defines.Color.C_FFFFEDD4)
        else
          _text_Msg:SetFontColor(Defines.Color.C_ffff8181)
        end
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
        bigNakMsg:AddEffect("UI_SiegeWarfare_Win_Red", false, 3, 0)
        bigNakMsg:AddEffect("fui_skillawakenboom_red", false, 3, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif messageType.whaleShow == MessageData._Msg[processIndex].type or messageType.huntingLandShow == MessageData._Msg[processIndex].type or messageType.whaleAlarm == MessageData._Msg[processIndex].type or messageType.huntingLandAlarm == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        stc_centerMessage:SetShow(false)
        stc_leftNPC:SetShow(false)
        stc_rightNPC:SetShow(false)
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        local stc_HuntingTiTle = UI.getChildControl(stc_HuntingBg, "StaticText_Title")
        local stc_HuntingDesc = UI.getChildControl(stc_HuntingBg, "StaticText_Desc")
        stc_HuntingBg:SetShow(true)
        stc_HuntingTiTle:SetShow(true)
        stc_HuntingDesc:SetShow(true)
        stc_HuntingTiTle:SetText(MessageData._Msg[processIndex].msg.main)
        stc_HuntingDesc:SetText(MessageData._Msg[processIndex].msg.sub)
        stc_HuntingBg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_HuntingBg, 1, 1, 945, 370)
        stc_HuntingBg:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_HuntingBg:setRenderTexture(stc_HuntingBg:getBaseTexture())
        stc_HuntingBg:SetSize(945, 370)
        stc_HuntingBg:EraseAllEffect()
        local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
        stc_bigShipBg:SetShow(false)
        stc_bigShipBg:EraseAllEffect()
        if messageType.whaleShow == MessageData._Msg[processIndex].type or messageType.whaleAlarm == MessageData._Msg[processIndex].type then
          stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        else
          stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        end
        if messageType.whaleAlarm == MessageData._Msg[processIndex].type or messageType.huntingLandAlarm == MessageData._Msg[processIndex].type then
          stc_HuntingTiTle:SetSpanSize(0, 225)
        else
          stc_HuntingTiTle:SetSpanSize(0, 210)
        end
        if messageType.whaleShow == MessageData._Msg[processIndex].type or messageType.whaleAlarm == MessageData._Msg[processIndex].type then
          audioPostEvent_SystemUi(19, 3)
          _AudioPostEvent_SystemUiForXBOX(19, 3)
        else
          audioPostEvent_SystemUi(19, 2)
          _AudioPostEvent_SystemUiForXBOX(19, 2)
        end
      elseif messageType.whaleHide == MessageData._Msg[processIndex].type or messageType.huntingLandHide == MessageData._Msg[processIndex].type or messageType.whaleTimeOut == MessageData._Msg[processIndex].type or messageType.huntingLandTimeOut == MessageData._Msg[processIndex].type then
        bigNakMsg:SetShow(false)
        _text_Msg:SetShow(false)
        _text_MsgSub:SetShow(false)
        competitionBg:SetShow(false)
        competitionMsg:SetShow(false)
        competitionCount:SetShow(false)
        stc_worldBossNewJin:SetShow(false)
        eventBossUIOff()
        eventDrawUIOff()
        stc_NoticeImage:SetShow(false)
        stc_bossImage:SetShow(false)
        stc_centerMessage:SetShow(false)
        stc_leftNPC:SetShow(false)
        stc_rightNPC:SetShow(false)
        local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
        local stc_HuntingTiTle = UI.getChildControl(stc_HuntingBg, "StaticText_Title")
        local stc_HuntingDesc = UI.getChildControl(stc_HuntingBg, "StaticText_Desc")
        stc_HuntingBg:SetShow(true)
        stc_HuntingTiTle:SetShow(true)
        stc_HuntingDesc:SetShow(true)
        stc_HuntingTiTle:SetText(MessageData._Msg[processIndex].msg.main)
        stc_HuntingDesc:SetText(MessageData._Msg[processIndex].msg.sub)
        stc_HuntingBg:ChangeTextureInfoNameAsync(messageTexture[MessageData._Msg[processIndex].type])
        local x1, y1, x2, y2 = setTextureUV_Func(stc_HuntingBg, 1, 1, 945, 370)
        stc_HuntingBg:getBaseTexture():setUV(x1, y1, x2, y2)
        stc_HuntingBg:setRenderTexture(stc_HuntingBg:getBaseTexture())
        stc_HuntingBg:SetSize(945, 370)
        local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
        stc_bigShipBg:SetShow(false)
        stc_bigShipBg:EraseAllEffect()
        local rankCount = getTemporaryInformationWrapper():getKillContributeCount()
        for index = 1, rankCount do
          huntingRanker[index]:SetShow(true)
        end
        stc_HuntingBg:EraseAllEffect()
        if messageType.whaleHide == MessageData._Msg[processIndex].type or messageType.whaleTimeOut == MessageData._Msg[processIndex].type then
          stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        else
          stc_HuntingBg:AddEffect("fUI_ingame_message_01A", false, 3, 0)
        end
        if messageType.whaleTimeOut == MessageData._Msg[processIndex].type or messageType.huntingLandTimeOut == MessageData._Msg[processIndex].type then
          stc_HuntingTiTle:SetSpanSize(0, 225)
        else
          stc_HuntingTiTle:SetSpanSize(0, 210)
        end
        audioPostEvent_SystemUi(19, 52)
        _AudioPostEvent_SystemUiForXBOX(19, 52)
      elseif messageType.localWarJoin == MessageData._Msg[processIndex].type then
        bigNakMsg:EraseAllEffect()
        bigNakMsg:AddEffect("UI_LocalWar_Start01", false, 3, -1)
        audioPostEvent_SystemUi(15, 1)
        _AudioPostEvent_SystemUiForXBOX(15, 1)
      elseif messageType.localWarExit == MessageData._Msg[processIndex].type then
        bigNakMsg:EraseAllEffect()
        audioPostEvent_SystemUi(15, 2)
        _AudioPostEvent_SystemUiForXBOX(15, 2)
      elseif messageType.raceFail == MessageData._Msg[processIndex].type then
        audioPostEvent_SystemUi(17, 3)
        _AudioPostEvent_SystemUiForXBOX(17, 3)
      elseif messageType.raceStart == MessageData._Msg[processIndex].type then
        audioPostEvent_SystemUi(17, 0)
        _AudioPostEvent_SystemUiForXBOX(17, 0)
      elseif messageType.localWarWin == MessageData._Msg[processIndex].type then
        localwarMsg:EraseAllEffect()
        localwarMsg:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        _text_Msg:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_WIN"))
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.localWarLose == MessageData._Msg[processIndex].type then
        localwarMsg:EraseAllEffect()
        localwarMsg:AddEffect("fUI_RedWar_Lose01", false, 0, 195)
        _text_Msg:SetFontColor(Defines.Color.C_FFD70000)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFD70000)
        _text_localwarMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_LOSE"))
        audioPostEvent_SystemUi(18, 1)
        _AudioPostEvent_SystemUiForXBOX(18, 1)
      elseif messageType.localWarTurnAround == MessageData._Msg[processIndex].type then
        localwarMsgSmallBG:EraseAllEffect()
        localwarMsgSmallBG:AddEffect("fUI_RedWar_Turnaround01", false, 0, 6)
        _text_localwarMsg:SetFontColor(Defines.Color.C_FFD70000)
        _text_localwarMsg:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 2)
        _AudioPostEvent_SystemUiForXBOX(18, 2)
      elseif messageType.SavageDefenceWin == MessageData._Msg[processIndex].type then
        localwarMsg:EraseAllEffect()
        localwarMsg:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        _text_Msg:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_WIN"))
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.SavageDefenceLose == MessageData._Msg[processIndex].type then
        localwarMsg:EraseAllEffect()
        localwarMsg:AddEffect("fUI_RedWar_Lose01", false, 0, 195)
        _text_Msg:SetFontColor(Defines.Color.C_FFD70000)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFD70000)
        _text_MsgSub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_LOSE"))
        audioPostEvent_SystemUi(18, 1)
        _AudioPostEvent_SystemUiForXBOX(18, 1)
      elseif messageType.SavageDefenceStart == MessageData._Msg[processIndex].type then
        localwarMsg:EraseAllEffect()
        localwarMsg:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        _text_Msg:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetFontColor(Defines.Color.C_FF00FFFC)
        _text_MsgSub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_UI_START"))
      elseif messageType.localWarCriticalBlack == MessageData._Msg[processIndex].type then
        localwarMsgSmallBG:EraseAllEffect()
        localwarMsgSmallBG:AddEffect("fUI_RedWar_BlackScore01", false, 0, 0)
        _text_localwarMsg:SetFontColor(Defines.Color.C_FFD29A04)
        _text_Msg:SetFontColor(Defines.Color.C_FF74CB0E)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFD29A04)
        _text_localwarMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_CRITICALATTACK"))
      elseif messageType.localWarCriticalRed == MessageData._Msg[processIndex].type then
        localwarMsgSmallBG:EraseAllEffect()
        localwarMsgSmallBG:AddEffect("fUI_RedWar_RedScore01", false, 0, 0)
        _text_localwarMsg:SetFontColor(Defines.Color.C_FFE50D0D)
        _text_Msg:SetFontColor(Defines.Color.C_FFD29A04)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFE50D0D)
        _text_localwarMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_CRITICALATTACK"))
      elseif messageType.goldenBell == MessageData._Msg[processIndex].type then
        if isGameTypeTaiwan() or _ContentsOption_CH_GameType then
          audioPostEvent_SystemUi(20, 1)
          _AudioPostEvent_SystemUiForXBOX(20, 1)
        else
          audioPostEvent_SystemUi(20, 0)
          _AudioPostEvent_SystemUiForXBOX(20, 0)
        end
        bigNakMsg:AddEffect("fUI_GoldenBell_01A", false, 0, 0)
      elseif messageType.xmasGoldenBell == MessageData._Msg[processIndex].type then
        if isGameTypeTaiwan() or _ContentsOption_CH_GameType then
          audioPostEvent_SystemUi(20, 1)
          _AudioPostEvent_SystemUiForXBOX(20, 1)
        else
          audioPostEvent_SystemUi(20, 0)
          _AudioPostEvent_SystemUiForXBOX(20, 0)
        end
        bigNakMsg:AddEffect("fUI_GoldenBell_01A", false, 0, 0)
      elseif messageType.freeBell == MessageData._Msg[processIndex].type then
        if isGameTypeTaiwan() or _ContentsOption_CH_GameType then
          audioPostEvent_SystemUi(20, 1)
          _AudioPostEvent_SystemUiForXBOX(20, 1)
        else
          audioPostEvent_SystemUi(20, 0)
          _AudioPostEvent_SystemUiForXBOX(20, 0)
        end
      elseif messageType.getValenciaItem == MessageData._Msg[processIndex].type then
        audioPostEvent_SystemUi(3, 20)
        _AudioPostEvent_SystemUiForXBOX(3, 20)
        nakItemIconBG:SetShow(false)
        nakItemIcon:SetShow(true)
        nakItemIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.arshaSpearCountDown == MessageData._Msg[processIndex].type then
        competitionMsg:SetText(MessageData._Msg[processIndex].msg.main)
        competitionCount:SetText(MessageData._Msg[processIndex].msg.sub)
      elseif messageType.personalMonster == MessageData._Msg[processIndex].type then
        blackSpiritEffect:SetShow(true)
        blackSpiritEffect:AddEffect("fUI_Personal_Monster_DarkSpirit_01A", false, 0, 0)
      elseif messageType.nationSiegeStart == MessageData._Msg[processIndex].type then
        nationSiegeBG:EraseAllEffect()
        nationSiegeBG:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        nationSiegeText:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.nationSiegeStop == MessageData._Msg[processIndex].type then
        nationSiegeBG:EraseAllEffect()
        nationSiegeBG:AddEffect("fUI_RedWar_Lose01", false, 0, 195)
        nationSiegeText:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 1)
        _AudioPostEvent_SystemUiForXBOX(18, 1)
      elseif messageType.nationSiegeCalpheonWin == MessageData._Msg[processIndex].type then
        nationSiegeBG:EraseAllEffect()
        nationSiegeBG:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        nationSiegeText:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.nationSeigeValenciaWin == MessageData._Msg[processIndex].type then
        nationSiegeBG:EraseAllEffect()
        nationSiegeBG:AddEffect("fUI_RedWar_Win01", false, 0, 195)
        nationSiegeText:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.thousandWar == MessageData._Msg[processIndex].type then
        nationSiegeText:SetText(MessageData._Msg[processIndex].msg.main)
        audioPostEvent_SystemUi(18, 0)
        _AudioPostEvent_SystemUiForXBOX(18, 0)
      elseif messageType.agrisPointOpen == MessageData._Msg[processIndex].type then
      elseif messageType.belmorn == MessageData._Msg[processIndex].type then
        belmornText:SetTextMode(__eTextMode_AutoWrap)
        belmornText:SetText(MessageData._Msg[processIndex].msg.main)
      elseif messageType.worldBossjinKzaka == MessageData._Msg[processIndex].type then
        txt_worldBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_worldBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
        stc_worldBossEffect:AddEffect("fUI_JinBoss_Nak_01A", false, 0, 0)
      elseif messageType.worldBossJinNuver == MessageData._Msg[processIndex].type then
        txt_worldBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_worldBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
        stc_worldBossEffect:AddEffect("fUI_JinBoss_Nak_01A", false, 0, 0)
      elseif messageType.worldBossJinKaranda == MessageData._Msg[processIndex].type then
        txt_worldBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_worldBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
        stc_worldBossEffect:AddEffect("fUI_JinBoss_Nak_01A", false, 0, 0)
      elseif messageType.fieldBossBlackShadow == MessageData._Msg[processIndex].type then
        txt_worldBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_worldBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
        stc_worldBossEffect:AddEffect("fUI_JinBoss_Nak_01A", false, 0, 0)
      elseif messageType.nuberu == MessageData._Msg[processIndex].type then
        txt_boss:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_boss:SetText(MessageData._Msg[processIndex].msg.main)
      elseif messageType.worldBossJinKutum == MessageData._Msg[processIndex].type then
        txt_worldBossName:SetText(worldBossName[MessageData._Msg[processIndex].type])
        txt_worldBossDesc:SetText(MessageData._Msg[processIndex].msg.main)
        stc_worldBossEffect:AddEffect("fUI_JinBoss_Nak_01A", false, 0, 0)
      elseif messageType.richMerchantRing == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_RichMerchantRing(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg.main)
      elseif messageType.getGrowthPassRewardItem == MessageData._Msg[processIndex].type then
        audioPostEvent_SystemUi(3, 2)
        _AudioPostEvent_SystemUiForXBOX(3, 2)
        NakMessage_UpdateRewardItemState(MessageData._Msg[processIndex].msg.main, MessageData._Msg[processIndex].msg.sub, MessageData._Msg[processIndex].msg.addMsg)
      elseif messageType.eventBossDongSim12 == MessageData._Msg[processIndex].type then
        setEventBossName()
      elseif messageType.solareStart == MessageData._Msg[processIndex].type or messageType.solareEnd == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_Solare(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg.main, MessageData._Msg[processIndex].msg.sub)
      elseif messageType.arbitrationGuildWar == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_Arbitration(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg.main, MessageData._Msg[processIndex].msg.sub)
      elseif messageType.bigShip == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_BigShip(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg.main, MessageData._Msg[processIndex].msg.sub)
      else
        _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
        _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
      end
      tempMsg = MessageData._Msg[processIndex].msg
      _text_Msg:SetText(MessageData._Msg[processIndex].msg.main)
      _text_MsgSub:SetText(MessageData._Msg[processIndex].msg.sub)
      if messageType.characterHPwarning == MessageData._Msg[processIndex].type then
        _text_Msg:SetSpanSize(_text_Msg:GetSpanSize().x, 15)
        _text_MsgSub:SetSpanSize(_text_MsgSub:GetSpanSize().x, 42)
      elseif messageType.localWarWin == MessageData._Msg[processIndex].type or messageType.localWarLose == MessageData._Msg[processIndex].type or messageType.nationSiegeStart == MessageData._Msg[processIndex].type or messageType.nationSiegeStop == MessageData._Msg[processIndex].type or messageType.nationSiegeCalpheonWin == MessageData._Msg[processIndex].type or messageType.nationSeigeValenciaWin == MessageData._Msg[processIndex].type then
        _text_Msg:SetSpanSize(0, -375)
        _text_MsgSub:SetSpanSize(0, -350)
      elseif messageType.localWarTurnAround == MessageData._Msg[processIndex].type then
        _text_Msg:SetSpanSize(0, 0)
        _text_MsgSub:SetSpanSize(0, 25)
        _text_localwarMsg:SetSpanSize(0, 80)
      elseif messageType.localWarCriticalBlack == MessageData._Msg[processIndex].type or messageType.localWarCriticalRed == MessageData._Msg[processIndex].type then
        _text_Msg:SetSpanSize(0, -15)
        _text_MsgSub:SetSpanSize(0, -45)
        _text_localwarMsg:SetSpanSize(0, 70)
      elseif messageType.sailControl == MessageData._Msg[processIndex].type then
        _text_Msg:SetSpanSize(0, 8)
      elseif messageType.morningBoss == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_morningLand(MessageData._Msg[processIndex].msg)
      elseif messageType.thousandInsam == MessageData._Msg[processIndex].type then
        thousandInsamIcon:SetShow(true)
        thousandInsamIcon:ChangeTextureInfoName(MessageData._Msg[processIndex].msg.addMsg)
        PaGlobal_RewardSelect_SetNak_thousandInsam(MessageData._Msg[processIndex].msg)
      elseif messageType.BabyBell == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_BabyBell(MessageData._Msg[processIndex].msg)
      elseif messageType.DragonPalaceCommon == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_DragonPalaceCommon(MessageData._Msg[processIndex].msg)
      elseif messageType.CrogdaloStable == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_Crogdalo(MessageData._Msg[processIndex].msg)
      elseif messageType.Telescope == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_Telescope(MessageData._Msg[processIndex].msg)
      elseif messageType.ElementalBossBuffSun == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_ElementalBossBuffSun(MessageData._Msg[processIndex].msg)
      elseif messageType.ElementalBossBuffMoon == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_ElementalBossBuffMoon(MessageData._Msg[processIndex].msg)
      elseif messageType.ElementalBossBuffLand == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_ElementalBossBuffLand(MessageData._Msg[processIndex].msg)
      elseif messageType.ElfWarApplyGuild == MessageData._Msg[processIndex].type or messageType.ElfWarApplyMercenary == MessageData._Msg[processIndex].type or messageType.ElfWarRaffleGuild == MessageData._Msg[processIndex].type or messageType.ElfWarRaffleMercenary == MessageData._Msg[processIndex].type or messageType.ElfWarStart == MessageData._Msg[processIndex].type or messageType.ElfWarKamasylviaWin == MessageData._Msg[processIndex].type or messageType.ElfWarOdylitaWin == MessageData._Msg[processIndex].type or messageType.ElfWarTie == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_ElfWar(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg)
      elseif messageType.Siege2024Raffle == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_Siege2024Raffle(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg)
      elseif messageType.morningLandWorldBossBulgasal == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossUturi == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossSangun == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossDuoksini == MessageData._Msg[processIndex].type or messageType.morningLandWorldBossGoldenPig == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_MorningLandWorldBoss(MessageData._Msg[processIndex].type, MessageData._Msg[processIndex].msg)
      elseif messageType.KingAccessory == MessageData._Msg[processIndex].type then
        PaGlobal_RewardSelect_SetNak_KingAccessory(MessageData._Msg[processIndex].msg)
      elseif "" == MessageData._Msg[processIndex].msg.sub then
        _text_Msg:SetSpanSize(_text_Msg:GetSpanSize().x, 25)
        _text_MsgSub:SetSpanSize(_text_MsgSub:GetSpanSize().x, 38)
      else
        _text_Msg:SetSpanSize(_text_Msg:GetSpanSize().x, 15)
        _text_MsgSub:SetSpanSize(_text_MsgSub:GetSpanSize().x, 38)
      end
      if ToClient_isPS() then
        _text_Msg:SetSize(250, 30)
        _text_MsgSub:SetSize(250, 30)
      end
      _text_Msg:ComputePos()
      _text_MsgSub:ComputePos()
      if 0 ~= changeSizeX and 0 ~= changeSizeY then
        bigNakMsg:SetSize(changeSizeX, changeSizeY)
      elseif 0 ~= changeSizeX then
        bigNakMsg:SetSize(changeSizeX, bigNakMsg:GetSizeY())
      elseif 0 ~= changeSizeY then
        bigNakMsg:SetSize(bigNakMsg:GetSizeX(), changeSizeY)
      else
        bigNakMsg:SetSize(bgBaseSizeX, bgBaseSizeY)
      end
      changeSizeX = 0
      changeSizeY = 0
      bigNakMsg:ComputePos()
      bigNakMsg:SetPosY(0)
      if 0 ~= changeTextPosY then
        _text_Msg:SetPosY(baseTextPosY + changeTextPosY)
        changeTextPosY = 0
      else
        _text_Msg:SetPosY(baseTextPosY)
      end
      if messageType.itemMarket == MessageData._Msg[processIndex].type then
        local mainTextSizeX = _text_Msg:GetTextSizeX()
        if mainTextSizeX > increesePointSizeX then
          bigNakMsg:SetSize(bgBaseSizeX + mainTextSizeX - increesePointSizeX, bgBaseSizeY)
        end
      end
      local centerPosY = 0
      if stc_centerMessage:GetShow() == true then
        centerPosY = stc_leftNPC:GetSizeY() - Panel_RewardSelect_NakMessage:GetPosY() + 45
        stc_centerMessage:SetPosY(centerPosY)
      end
      if messageType.territoryTradeEvent == MessageData._Msg[processIndex].type or messageType.npcTradeEvent == MessageData._Msg[processIndex].type then
        _text_AddMsg:SetText(MessageData._Msg[processIndex].msg.addMsg)
      end
      currentMessageType = MessageData._Msg[processIndex].type
      if nil ~= npcMessage[currentMessageType] then
        totalMessageTime = npcMessage[currentMessageType].messageCount * npcMessageTime + npcShowTime * 2 + 0.5
      end
      MessageData._Msg[processIndex].msg = nil
      MessageData._Msg[processIndex].type = nil
      elapsedTime = 0
    else
      Panel_RewardSelect_NakMessage:SetShow(false, false)
      if Panel_Event_TicketShop_Nak ~= nil then
        Panel_Event_TicketShop_Nak:SetShow(false)
      end
      _text_AddMsg:SetShow(false)
      nakItemIconBG:SetShow(false)
      nakItemIcon:SetShow(false)
      curIndex = 0
      processIndex = 0
      isForceShowMessage = false
    end
  else
    NakMessagePanel_Resize_For_RewardSelect()
    if processIndex < curIndex and tempMsg == MessageData._Msg[processIndex + 1].msg then
      processIndex = processIndex + 1
      MessageData._Msg[processIndex].msg = nil
      MessageData._Msg[processIndex].type = nil
    end
  end
  if messageType.richMerchantRing == currentMessageType then
    PaGlobal_RewardSelect_ShowNPCMessage(updateTime)
  end
  if messageType.PanOkSeonPersonal == currentMessageType then
    PaGlobal_RewardSelect_ShowNPCMessage_PanOkSeonPersonal(updateTime)
  end
end
function NakMessagePanel_Resize_For_RewardSelect()
  if Panel_LocalWar ~= nil and Panel_LocalWar:GetShow() then
    Panel_RewardSelect_NakMessage:SetPosY(50)
  elseif nil ~= Panel_Arsha_TeamWidget and Panel_Arsha_TeamWidget:GetShow() then
    Panel_RewardSelect_NakMessage:SetPosY(Panel_Arsha_TeamWidget:GetPosY() + Panel_Arsha_TeamWidget:GetSizeY() - 30)
  else
    Panel_RewardSelect_NakMessage:SetPosY(30)
  end
  Panel_RewardSelect_NakMessage:SetPosX((getOriginScreenSizeX() - Panel_RewardSelect_NakMessage:GetSizeX()) * 0.5)
  localwarMsg:ComputePos()
  localwarMsgBG:ComputePos()
  _text_localwarMsg:ComputePos()
end
function FGlobal_NakMessagePanel_CheckLeftMessageCount()
  return curIndex
end
function check_LeftNakMessage()
  if processIndex < curIndex then
    Panel_RewardSelect_NakMessage:SetShow(true, false)
    stc_blackBG:SetShow(false)
    NakMessagePanel_Resize_For_RewardSelect()
  end
end
function renderModeChange_check_LeftNakMessage(prevRenderModeList, nextRenderModeList)
  local currentRenderMode = {
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_Dialog,
    Defines.RenderMode.eRenderMode_WorldMap
  }
  if CheckRenderMode(prevRenderModeList, currentRenderMode) or CheckRenderModebyGameMode(nextRenderModeList) then
    check_LeftNakMessage()
  end
end
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_check_LeftNakMessage")
function FromClient_notifyGetItem(notifyType, playerName, fromName, iconPath, param1, itemStaticWrapper, isPickedFromShip, isEnchantDown)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isSelfPlayer = false
  local nameType = ToClient_getChatNameType()
  if __eChatNameType_NickName == nameType then
    isSelfPlayer = selfPlayer:getUserNickname() == playerName
  else
    isSelfPlayer = selfPlayer:getOriginalName() == playerName
  end
  if ToClient_namelessPVPServer() == true then
    playerName = PaGlobalFunc_getAnonymousNameString(0)
  end
  local message = ""
  local subMessage = ""
  local itemIcon
  local itemName = ""
  local itemClassify, itemKey
  local isSpecialItem = false
  local isKingAccessory = false
  local isSkipNak = false
  if nil ~= itemStaticWrapper and itemStaticWrapper:isSet() then
    itemName = itemStaticWrapper:getName()
    itemClassify = itemStaticWrapper:getItemClassify()
    enchantLevel = itemStaticWrapper:get()._key:getEnchantLevel()
    itemKey = itemStaticWrapper:get()._key:getItemKey()
    isSpecialItem = itemStaticWrapper:isSpecialEnchantItem()
    isKingAccessory = itemStaticWrapper:isKingAccessory()
  end
  for index = 1, 5 do
    huntingRanker[index]:SetShow(false)
  end
  if notifyType == __eBroadCastNotifyType_PickupDroppedItem then
    if isPickedFromShip then
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_GUILDSHIPLOOTING_MSG", "playerName", playerName, "itemName", itemName)
    else
      message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
    end
    subMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_GETITEM_SUBMSG", "fromName", fromName)
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotifyType_OpenItemBox then
    if false == _ContentsGroup_ItemBigNakMessage then
      if 59418 == itemKey then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN_KROGDALO", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB_KROGDALO")
      else
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_OPENBOX_SUBMSG", "fromName", fromName)
      end
    else
      local itemBigNakSSW = getItemNakMessageStaticStatus(ItemEnchantKey(itemKey))
      if nil ~= itemBigNakSSW then
        local mainStringKey = itemBigNakSSW:getItemNakMainStringKey()
        local subStringKey = itemBigNakSSW:getItemNakSubStringKey()
        message = PAGetStringParam2(Defines.StringSheet_GAME, mainStringKey, "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, subStringKey)
      else
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_OPENBOX_SUBMSG", "fromName", fromName)
      end
    end
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotifyType_EnchantItem or notifyType == __eBroadCastNotifyType_PromotionItem then
    if nil ~= Int64toInt32(param1) and 0 ~= Int64toInt32(param1) then
      enchantLevel = Int64toInt32(param1)
      if notifyType == __eBroadCastNotifyType_EnchantItem and (CppEnums.ItemClassifyType.eItemClassify_Accessory ~= itemClassify or CppEnums.ItemClassifyType.eItemClassify_Accessory == itemClassify and isSpecialItem == true and isKingAccessory == false) and nil ~= enchantLevel and 0 ~= enchantLevel and enchantLevel < 19 then
        isSkipNak = true
      end
      if 0 ~= enchantLevel then
        if itemClassify == CppEnums.ItemClassifyType.eItemClassify_Accessory then
          enchantLevel = enchantLevel + 15
        end
        if enchantLevel > 15 then
          itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
        else
          itemName = "+" .. tostring(enchantLevel) .. " " .. itemName
        end
      end
    end
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
    if notifyType == __eBroadCastNotifyType_EnchantItem then
      subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_SUCCESSENCHANT_SUBMSG")
    elseif notifyType == __eBroadCastNotifyType_PromotionItem then
      subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_PROMOTION_SUBMSG_CAPHRAS")
    end
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotifyType_GetServant then
    message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_GOODHORSE_MSG", "playerName", playerName)
    subMessage = ""
    itemIcon = iconPath
  elseif notifyType == __eBroadCastNotifyType_EnchantItemFail then
    if itemClassify == 11 then
      return
    end
    if isSpecialItem == true and isKingAccessory == false then
      enchantLevel = 0
    end
    if enchantLevel ~= 0 then
      if itemClassify == CppEnums.ItemClassifyType.eItemClassify_Accessory then
        enchantLevel = enchantLevel + 15
      end
      if enchantLevel > 15 then
        itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
      else
        itemName = "+" .. tostring(enchantLevel) .. " " .. itemName
      end
    end
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_ENCHANTFAIL_MSG", "playerName", playerName, "itemName", itemName)
    subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_ENCHANTENCHANT_SUBMSG")
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
    if CppEnums.ItemClassifyType.eItemClassify_Accessory ~= itemClassify and Int64toInt32(param1) ~= nil and Int64toInt32(param1) ~= 0 then
      if false == isEnchantDown then
        if Int64toInt32(param1) < 19 then
          isSkipNak = true
        end
      elseif Int64toInt32(param1) < 18 then
        isSkipNak = true
      end
    end
  elseif notifyType == __eBroadCastNotifyType_MakePuzzle then
    if false == _ContentsGroup_ItemBigNakMessage then
      if 16016 == itemKey or 16019 == itemKey then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      elseif 40712 == itemKey or 40713 == itemKey then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN2", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      elseif 59321 == itemKey then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN3", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      elseif 12034 == itemKey then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN3", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      elseif itemKey == 65299 then
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_MAIN2", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_LUXURYFIND_SUB")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      else
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_ITEMCOMBINATION")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      end
    else
      local itemBigNakSSW = getItemNakMessageStaticStatus(ItemEnchantKey(itemKey))
      if nil ~= itemBigNakSSW then
        local mainStringKey = itemBigNakSSW:getItemNakMainStringKey()
        local subStringKey = itemBigNakSSW:getItemNakSubStringKey()
        message = PAGetStringParam2(Defines.StringSheet_GAME, mainStringKey, "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, subStringKey)
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      else
        message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
        subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_ITEMCOMBINATION")
        itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
      end
    end
  elseif notifyType == __eBroadCastNotifyType_AwakenServant then
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_HORSE9Tier_MSG", "playerName", playerName, "servantName", fromName)
    subMessage = ""
    itemIcon = iconPath
  elseif notifyType == __eBroadCastNotifyType_GetItem then
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_COMMON_MSG", "playerName", playerName, "itemName", itemName)
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotifyType_FantasyMixSuccess then
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_HORSE9Tier_MSG", "playerName", playerName, "servantName", fromName)
    subMessage = ""
    itemIcon = iconPath
  elseif notifyType == __eBroadCastNotifyType_WinDrawItem then
    message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENT_TICKETSHOP_NAK_DESC", "name", playerName)
    subMessage = ""
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotiFyType_GetThousandInsam then
    message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOOLTIP_SANSAM_NAKMSG", "userNickName", playerName)
    subMessage = ""
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  elseif notifyType == __eBroadCastNotiFyType_SuccessManufacture then
    if enchantLevel ~= 0 then
      enchantLevel = enchantLevel + 15
      if enchantLevel > 15 then
        itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemName
      else
        itemName = "+" .. tostring(enchantLevel) .. " " .. itemName
      end
    end
    local resultItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemStaticWrapper)
    message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDNAKMESSAGE_KARAZAD_MSG_2", "name", playerName, "itemName", resultItemName)
    subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDNAKMESSAGE_KARAZAD_MSG_1")
    itemIcon = "Icon/" .. itemStaticWrapper:getIconPath()
  end
  local msg = {
    main = message,
    sub = subMessage,
    addMsg = itemIcon,
    onlyChat = isSkipNak,
    param = param1
  }
  if notifyType == __eBroadCastNotifyType_OpenItemBox then
    if 59418 == itemKey then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.CrogdaloStable, nil, isSelfPlayer)
    end
  elseif notifyType == __eBroadCastNotifyType_EnchantItemFail then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.enchantFail, nil, isSelfPlayer)
  elseif notifyType == __eBroadCastNotifyType_MakePuzzle then
    if false == _ContentsGroup_ItemBigNakMessage then
      if 16016 == itemKey or 16019 == itemKey or 40712 == itemKey or 40713 == itemKey or 59321 == itemKey or 12034 == itemKey then
        Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.getValenciaItem, nil, isSelfPlayer)
      else
        Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, messageType.anotherPlayerGotItem, nil, isSelfPlayer)
      end
    else
      local itemBigNakSSW = getItemNakMessageStaticStatus(ItemEnchantKey(itemKey))
      if nil ~= itemBigNakSSW then
        if 12034 == itemKey then
          local npcMessageData = npcMessage[messageType.richMerchantRing]
          if nil ~= npcMessageData then
            npcMessageData.message = {
              [1] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_1"),
              [2] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_1"),
              [3] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_2", "familyName", playerName),
              [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_2_1") .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_2_2", "familyName", playerName),
              [5] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_3_1", "familyName", playerName) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_3_2"),
              [6] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_3_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_3_2")
            }
            npcMessageData.messageCount = 6
          end
          totalMessageTime = npcMessageTime * npcMessageData.messageCount + npcShowTime * 2 + 0.5
          Proc_ShowMessage_Ack_For_RewardSelect(msg, totalMessageTime, messageType.richMerchantRing, nil, isSelfPlayer)
          elapsedTotalMessageTime = 0
          elapsedMessageTime = 5.4
        elseif itemKey == 65299 then
          Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.Telescope, false)
        else
          Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.getValenciaItem, nil, isSelfPlayer)
        end
      else
        Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, messageType.anotherPlayerGotItem, nil, isSelfPlayer)
      end
    end
  elseif notifyType == __eBroadCastNotifyType_AwakenServant then
    if toInt64(0, 9989) == param1 or toInt64(0, 9889) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.horseNineTier, nil, isSelfPlayer)
    elseif toInt64(0, 9988) == param1 or toInt64(0, 9888) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.horseNineTier_dine, nil, isSelfPlayer)
    elseif toInt64(0, 9987) == param1 or toInt64(0, 9887) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.horseNineTier_Doom, nil, isSelfPlayer)
    end
  elseif notifyType == __eBroadCastNotifyType_EnchantItem or notifyType == __eBroadCastNotifyType_PromotionItem then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, messageType.enchantSuccess, nil, isSelfPlayer)
  elseif notifyType == __eBroadCastNotifyType_FantasyMixSuccess then
    if toInt64(0, 31539) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.fantasyMix_Aduanatt, nil, isSelfPlayer)
    elseif toInt64(0, 31557) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.fantasyMix_Dine, nil, isSelfPlayer)
    elseif toInt64(0, 31575) == param1 then
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.fantasyMix_Doom, nil, isSelfPlayer)
    end
  elseif notifyType == __eBroadCastNotifyType_WinDrawItem then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.eventDraw, nil, isSelfPlayer)
  elseif notifyType == __eBroadCastNotiFyType_GetThousandInsam then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.thousandInsam, nil, isSelfPlayer)
  elseif notifyType == __eBroadCastNotiFyType_SuccessManufacture then
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.KingAccessory, nil, isSelfPlayer)
  else
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 2.5, messageType.anotherPlayerGotItem, nil, isSelfPlayer)
  end
end
Panel_RewardSelect_NakMessage:RegisterUpdateFunc("NakMessageUpdate_For_RewardSelect")
Panel_Event_TicketShop_Nak:RegisterUpdateFunc("NakMessageUpdate_For_RewardSelect")
function FromClient_notifyBroadcastLifeLevelUp(_notifyType, userNickName, characterName, _param1, _param2)
  local lifeType_s32 = Int64toInt32(_param2)
  local lifeLevel_s32 = Int64toInt32(_param1)
  local lifeType = CppEnums.LifeExperienceString[lifeType_s32]
  local lifeLev = PaGlobalFunc_Util_CraftLevelReplace(lifeLevel_s32)
  local message = userNickName .. "(" .. characterName .. ")"
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isSelfPlayer = selfPlayer:getUserNickname() == playerName or selfPlayer:getOriginalName() == playerName
  if isSelfPlayer == false and ToClient_namelessPVPServer() == true then
    message = PaGlobalFunc_getAnonymousNameString(0)
  end
  local subMessage = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_LIFELEVEL_SUBMSG", "lifeType", lifeType, "lifeLev", lifeLev)
  local itemIcon = ""
  local msg = {
    main = message,
    sub = subMessage,
    addMsg = itemIcon
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 3, messageType.lifeLevUp)
end
function FromClient_EventDieInstanceMonster(bossName)
  local msg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_HUNTTINGBOSS_TITLE", "bossName", bossName),
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_HUNTTINGBOSS_SUBTITLE", "territoryName", selfPlayerCurrentTerritory()),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 6, messageType.defeatBoss)
end
function FromClient_NoticeChatMessageUpdate(_noticeSender, _noticeContent)
  local msg = {
    main = _noticeContent,
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GUILDNOTIFY_SENDER", "guildMasterName", _noticeSender),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.guildNotify)
end
function FromClient_NoticeChatMessageUpdate_Arsha(_noticeSender, _noticeContent)
  local msg = {
    main = _noticeContent,
    sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_ARSHANOTIFY_SENDER", "hostName", _noticeSender),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.arshaNotify, false)
end
function FromClient_Notify_VehicleRegister(_noticeSender, characterKey, isMe)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isSelfPlayer = selfPlayer:getUserNickname() == playerName or selfPlayer:getOriginalName() == playerName
  if isSelfPlayer == false and ToClient_namelessPVPServer() == true then
    _noticeSender = PaGlobalFunc_getAnonymousNameString(0)
  end
  if characterKey == 31025 then
    if isMe == true then
      local npcMessageData = npcMessage[messageType.PanOkSeonPersonal]
      if nil ~= npcMessageData then
        npcMessageData.message = {
          [1] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_1", "playerName", _noticeSender),
          [2] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_1", "playerName", _noticeSender),
          [3] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_2"),
          [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_2"),
          [5] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_3"),
          [6] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_3")
        }
        npcMessageData.messageCount = 6
      end
      totalMessageTime = npcMessageTime * npcMessageData.messageCount + npcShowTime * 2 + 0.5
      local msg = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_PANOKSEON1"),
        sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_PANOKSEON2", "playerName", _noticeSender),
        addMsg = ""
      }
      Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, totalMessageTime, messageType.PanOkSeonPersonal, false)
      elapsedTotalMessageTime = 0
      elapsedMessageTime = 5
    else
      local msg = {
        main = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_PANOKSEON1"),
        sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_PANOKSEON2", "playerName", _noticeSender),
        addMsg = ""
      }
      Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.PanOkSeonWorld, false)
    end
  else
    local msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_BIGSHIP1"),
      sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_NOTIFY_BIGSHIP2", "playerName", _noticeSender),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.bigShip, false)
  end
end
function FromClient_Notify_GuildPresent(_noticeSender, _itemName)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isSelfPlayer = selfPlayer:getUserNickname() == playerName or selfPlayer:getOriginalName() == playerName
  if isSelfPlayer == false and ToClient_namelessPVPServer() == true then
    _noticeSender = PaGlobalFunc_getAnonymousNameString(0)
  end
  local msg = {
    main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDPRESENT_NAKMESSAGE", "Name", _noticeSender, "ItemName", _itemName),
    sub = "",
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 3.5, messageType.guildMsg, false)
  PaGlobal_GuildPresent_All_Close_FromWarehouse()
end
function FromClient_ElementalMonsterBuffNakMessage(userNickname, monsterKeyRaw)
  local conquestLevel = ToClient_GetElementalBossMaxOpenLevel()
  local monsterSS = getCharacterStaticStatusWarpper(monsterKeyRaw)
  if monsterSS == nil then
    return
  end
  local monsterName = monsterSS:getName()
  local elementalStatSS = ToClient_getElementalMonsterInfoByCharacterKey(monsterKeyRaw)
  if elementalStatSS == nil then
    return
  end
  local elementalStatType = elementalStatSS:getElementalStatType()
  local levelString = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(conquestLevel))
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isSelfPlayer = selfPlayer:getUserNickname() == playerName or selfPlayer:getOriginalName() == playerName
  if isSelfPlayer == false and ToClient_namelessPVPServer() == true then
    userNickname = PaGlobalFunc_getAnonymousNameString(0)
  end
  if elementalStatType == 0 then
    local msg = {
      main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_BUFF", "familyname", userNickname, "bossname", monsterName, "difficulty", levelString),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_SUN"),
      addMsg = ""
    }
    audioPostEvent_SystemUi(34, 33)
    _AudioPostEvent_SystemUiForXBOX(34, 33)
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 10, messageType.ElementalBossBuffSun, false)
  elseif elementalStatType == 1 then
    local msg = {
      main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_BUFF", "familyname", userNickname, "bossname", monsterName, "difficulty", levelString),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_MOON"),
      addMsg = ""
    }
    audioPostEvent_SystemUi(34, 33)
    _AudioPostEvent_SystemUiForXBOX(34, 33)
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 10, messageType.ElementalBossBuffMoon, false)
  elseif elementalStatType == 2 then
    local msg = {
      main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_BUFF", "familyname", userNickname, "bossname", monsterName, "difficulty", levelString),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_ELEMENTALBOSS_HIGHDIFFICULTY_SOIL"),
      addMsg = ""
    }
    audioPostEvent_SystemUi(34, 33)
    _AudioPostEvent_SystemUiForXBOX(34, 33)
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, 10, messageType.ElementalBossBuffLand, false)
  else
    return
  end
end
function FromClient_ElfWarNakMessage(elfWarEventType)
  if elfWarEventType == nil then
    return
  end
  local mainStr = ""
  local subStr = ""
  local addStr = ""
  local showTime = 5
  local msgTypeParam
  if elfWarEventType == __eElfWarEventType_ApplyGuild then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_READER_RECRUIT")
    msgTypeParam = messageType.ElfWarApplyGuild
  elseif elfWarEventType == __eElfWarEventType_ApplyMercenary then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_MERCENARY_RECRUIT")
    msgTypeParam = messageType.ElfWarApplyMercenary
  elseif elfWarEventType == __eElfWarEventType_RaffleGuild then
    local guildName1 = ToClient_GetElfWarGuildName(__eElfWarTeam_Kamasylvia)
    local guildName2 = ToClient_GetElfWarGuildName(__eElfWarTeam_Odyllita)
    if guildName1 == "" or guildName2 == "" then
      mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_READER_NOGUILD")
    else
      mainStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_READER_PICK", "guildname1", guildName1, "guildname2", guildName2)
    end
    msgTypeParam = messageType.ElfWarRaffleGuild
  elseif elfWarEventType == __eElfWarEventType_RaffleMercenary then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_MERCENARY_PICK")
    msgTypeParam = messageType.ElfWarRaffleMercenary
  elseif elfWarEventType == __eElfWarEventType_Start then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_WARSTART")
    msgTypeParam = messageType.ElfWarStart
  elseif elfWarEventType == __eElfWarEventType_KamasylviaWin then
    local guildName = ToClient_GetElfWarGuildName(__eElfWarTeam_Kamasylvia)
    if guildName == "" then
      mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_KAMA_WIN_NOGUILD")
    else
      mainStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_KAMA_WIN", "guildname", guildName)
    end
    msgTypeParam = messageType.ElfWarKamasylviaWin
  elseif elfWarEventType == __eElfWarEventType_OdylitaWin then
    local guildName = ToClient_GetElfWarGuildName(__eElfWarTeam_Odyllita)
    if guildName == "" then
      mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_ODYL_WIN_NOGUILD")
    else
      mainStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_ODYL_WIN", "guildname", guildName)
    end
    msgTypeParam = messageType.ElfWarOdylitaWin
  elseif elfWarEventType == __eElfWarEventType_Tie then
    mainStr = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NAK_DRAW")
    msgTypeParam = messageType.ElfWarTie
  else
    UI.ASSERT_NAME(false, "ElfWarEventType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148!", "\236\157\180\236\163\188")
    return
  end
  local msg = {
    main = mainStr,
    sub = subStr,
    addMsg = addStr
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(msg, showTime, msgTypeParam, false)
end
function FromClient_ArrestAToB(attacker, attackee)
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == true then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  if ToClient_namelessPVPServer() == true then
    local tempName = PaGlobalFunc_getAnonymousNameString(0)
    attacker = tempName
    attackee = tempName
  end
  if true == curChannelData._isBalanceChannel then
    local msg = {
      main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DESERTCHAOKILL_MSG_MAIN", "attacker", attacker, "attackee", attackee),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DESERTCHAOKILL_MSG_SUB_BALANCE"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.playerKiller)
  else
    local msg = {
      main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DESERTCHAOKILL_MSG_MAIN", "attacker", attacker, "attackee", attackee),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REWARDSELECT_NAKMESSAGE_DESERTCHAOKILL_MSG_SUB"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.playerKiller)
  end
end
function FromClient_RegistGuildServant(vehicleType, guildName)
  if ToClient_namelessPVPServer() == true then
    guildName = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDNAME_COLOR_UNKNOWN")
  end
  local msg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_MAIN", "guildName", guildName),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_COMMON"),
    addMsg = ""
  }
  if CppEnums.VehicleType.Type_Elephant == vehicleType then
    msg = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_ELEPHANT_MAIN", "guildName", guildName),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_COMMON"),
      addMsg = ""
    }
  elseif CppEnums.VehicleType.Type_SailingBoat == vehicleType then
    msg = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_SAILINGBOAT_MAIN", "guildName", guildName),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_COMMON"),
      addMsg = ""
    }
  else
    msg = {
      main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_MAIN", "guildName", guildName),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REGISTGUILDSERVANT_DEFAULT_COMMON"),
      addMsg = ""
    }
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 58)
end
function FromClient_notifyRegisterServantAtAuction(characterkey, servantStateType, servantTier, isStallion, price, iconPath)
  if 9 == servantTier then
    servantTier = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SERVANTMARKET_9TIER")
    isServantStallion = false
  else
    servantTier = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SERVANTMARKET_TIER", "servantTier", servantTier)
    stallionIcon:SetMonoTone(not isStallion)
    isServantStallion = true
  end
  message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SERVANTMARKET_REGISTER_PRICE_MSG", "servantTier", servantTier, "price", tostring(makeDotMoney(price)))
  subMessage = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SERVANTMARKET_REGISTER_MSG")
  itemIcon = iconPath
  local msg = {
    main = message,
    sub = subMessage,
    addMsg = itemIcon
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.servantMarket)
end
function FromClient_notifyRegisterWorkerAtAuction(workerKey, gradeType, price, iconPath, workerName, regionKeyRaw)
  local regionInfo = getRegionInfoByRegionKey(RegionKey(regionKeyRaw))
  local regionName = regionInfo:getAreaName()
  if nil == regionName then
    return
  end
  message = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_WORKERMARKET_REGISTER_PRICE_MSG", "workerName", workerName, "price", tostring(makeDotMoney(price)))
  subMessage = tostring(regionName) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_WORKERMARKET_REGISTER_MSG")
  itemIcon = iconPath
  local msg = {
    main = message,
    sub = subMessage,
    addMsg = itemIcon
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.workerMarket)
end
function FromClient_UpdateRestrictedArea(state)
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if __eRestrictedArea_Normal == state then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_SAFETYZONE_MAIN")
    msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_SAFETYZONE_SUB")
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.restrictedArea_Normal)
  elseif __eRestrictedArea_Warning == state then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_WARNNINGZONE_MAIN")
    msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_WARNNINGZONE_SUB")
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.restrictedArea_Warning)
  else
    if __eRestrictedArea_Kill == state then
      msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_DESTROYZONE_MAIN")
      msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_SAIL_DESTROYZONE_SUB")
      Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.restrictedArea_Kill)
    else
    end
  end
end
function FromClient_EmployeeRegisterAck(isSuccess, nameKey, isSpecial)
  local employeeName = ""
  if isSpecial then
    employeeName = ToClient_GetSpecialEmployeeName(nameKey)
  else
    employeeName = ToClient_GetEmployeeName(nameKey)
  end
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if true == isSuccess then
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYSAILER_SUCCESS_MAIN", "name", employeeName)
    msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYSAILER_SUCCESS_SUB")
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.register_Succees)
  else
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYSAILER_FAIL_MAIN", "name", employeeName)
    msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYSAILER_FAIL_SUB")
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.register_Fail)
  end
end
function FromClient_GuildDrillNotify(guildName, isInstall, isComplete, isDelete)
  if nil == isInstall or nil == isComplete or nil == isDelete or nil == guildName or "" == guildName then
    return
  end
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if true == isInstall then
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAK_MINING_CONSTRUCT", "name", guildName)
    msg.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.guildDrillInstall)
  elseif true == isComplete then
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAK_MINING_COMPLETE", "name", guildName)
    msg.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.guildDrillComplete)
  elseif true == isDelete then
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAK_MINING_DESTROY", "name", guildName)
    msg.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.guildDrillDelete)
  end
end
function FromClient_StartOrFinishVote(isFinish)
  if nil == isFinish then
    return
  end
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if true == isFinish then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_NAK_GUILD_VOTE_END")
    msg.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.endVote)
  else
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_NAK_GUILD_VOTE_START")
    msg.sub = ""
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.startVote)
  end
end
function FromClient_UseGuildActivePolicy(territoryKey, skillNo)
  local skillSS = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillSS then
    local msg = {
      main = "",
      sub = "",
      addMsg = ""
    }
    msg.main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POLICY_NAK_SKILLACTIVE_SKILLNAME", "SkillName", skillSS:getName())
    msg.sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POLICY_NAK_SKILLACTIVE", "territory", getTerritoryNameByKey(getTerritoryByIndex(territoryKey)))
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.activePolicy)
  end
end
function FromClient_GetGrowthPassRewardItem(itemName, itemCount, itemIconPath)
  if nil == itemName or nil == itemIconPath then
    return
  end
  local msg = {
    main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GROWTHPASS_REWARD_DESC", "item", itemName),
    sub = PAGetString(Defines.StringSheet_GAME, "LUA_GROWTHPASS_REWARD_DESC_1"),
    addMsg = "Icon/" .. itemIconPath
  }
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 3, messageType.getGrowthPassRewardItem)
end
function FromClient_SolareStartEndMessage(isSolareEnter)
  if _ContentsGroup_SolareMatching == false and _ConstentsGroup_SolareNormalMatching == false then
    return
  end
  if isSolareEnter == nil then
    return
  end
  local solareMessageType = 0
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if isSolareEnter == true then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_MATCHSTART_NAK_TITLE_OPEN")
    msg.sub = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_MATCHSTART_NAK_DESC_OPEN")
    solareMessageType = messageType.solareStart
  else
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_MATCHSTART_NAK_TITLE_CLOSE")
    msg.sub = ""
    solareMessageType = messageType.solareEnd
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, solareMessageType)
end
function FromClient_DragonPalaceInstanceEndMessage(isEnter)
  if _ContentsGroup_DragonPalace == false then
    return
  end
  if isEnter == nil then
    return
  end
  local dragonPalaceMessageType = 0
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if isEnter == true then
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_RABBITLIVERSCRAMBLE_MATCHING_STR")
    dragonPalaceMessageType = messageType.DragonPalaceCommon
  else
    msg.main = PAGetString(Defines.StringSheet_GAME, "LUA_RABBITLIVERSCRAMBLE_MATCHING_END")
    dragonPalaceMessageType = messageType.DragonPalaceCommon
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, dragonPalaceMessageType)
end
function FromClient_MorningLandBossClearAck(name, classType, BossCharacterKey, group, level)
  if Panel_RewardSelect_NakMessage == nil then
    return
  end
  if _ContentsGroup_MorningLand == false then
    return
  end
  local wrapper = ToClient_getGameOptionControllerWrapper()
  if wrapper == nil then
    return
  end
  if wrapper:getAlertElementalBoss() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isSelfPlayer = selfPlayer:getUserNickname() == name or selfPlayer:getOriginalName() == name
  if isSelfPlayer == false and ToClient_namelessPVPServer() == true then
    name = PaGlobalFunc_getAnonymousNameString(0)
  end
  local msg = {
    main = "",
    sub = "",
    addMsg = "",
    groupIdx = nil
  }
  local className = getCharacterClassName(classType)
  local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(BossCharacterKey)
  local bossName = ""
  local levelStr = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(level))
  if nil ~= characterStaticStatusWarpper then
    bossName = characterStaticStatusWarpper:getName()
  end
  local morningLandPart2Boss = ToClient_getElementalMonsterInfoByCharacterKey(BossCharacterKey)
  if morningLandPart2Boss ~= nil then
    local part = morningLandPart2Boss:getMorningLandMonsterPartRaw()
    if part == __eMorningLandMosterPart2 then
      if level == 0 then
        levelStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY")
      else
        levelStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD")
      end
    end
  end
  msg.main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_WORLDMSG_TXT_0", "class", className, "charname", name)
  msg.sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_WORLDMSG_TXT_1", "bossname", bossName, "difficulty", levelStr)
  msg.groupIdx = group
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, messageType.morningBoss)
end
function PaGlobal_RewardSelect_GetNoiceMessageType(noticeType)
  local msgType = messageType.ocean
  if CppEnums.EChatNoticeType.Ocean == noticeType then
    msgType = messageType.ocean
  elseif CppEnums.EChatNoticeType.Invasion == noticeType then
    msgType = messageType.invasion
  elseif CppEnums.EChatNoticeType.Noti == noticeType then
    msgType = messageType.noti
  end
  return msgType
end
function PaGlobal_RewardSelect_ShowNPCMessage(deltaTime)
  if -1 == currentMessageType then
    return
  end
  local npcMessageData = npcMessage[currentMessageType]
  if nil == npcMessageData then
    return
  end
  elapsedTotalMessageTime = elapsedTotalMessageTime + deltaTime
  if elapsedTotalMessageTime < totalMessageTime then
    local npcMessageCount = npcMessageData.messageCount
    elapsedMessageTime = elapsedMessageTime + deltaTime
    if npcMessageTime + npcShowTime < elapsedMessageTime then
      if npcMessageCount < npcMessageIndex then
        return
      end
      if 1 == npcMessageIndex then
        if nil ~= txt_leftNPCIcon then
          txt_leftNPCIcon:SetShow(true)
          local showAni = txt_leftNPCIcon:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
          local moveAni = txt_leftNPCIcon:addMoveAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          moveAni:SetStartPosition(txt_leftNPCIcon:GetPosX() + 20, txt_leftNPCIcon:GetPosY())
          moveAni:SetEndPosition(txt_leftNPCIcon:GetPosX(), txt_leftNPCIcon:GetPosY())
        end
      elseif 2 == npcMessageIndex and nil ~= txt_rightNPCIcon then
        txt_rightNPCIcon:SetShow(true)
        local showAni = txt_rightNPCIcon:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = txt_rightNPCIcon:addMoveAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(txt_rightNPCIcon:GetPosX() - 20, txt_rightNPCIcon:GetPosY())
        moveAni:SetEndPosition(txt_rightNPCIcon:GetPosX(), txt_rightNPCIcon:GetPosY())
      end
      if npcMessageIndex >= 3 then
        npcShowTime = 0
      end
      local messageControl = txt_leftNPCMessage
      local startPosX = messageControl:GetPosX()
      if 1 == npcMessageIndex % 2 then
        messageControl = txt_leftNPCMessage
        startPosX = messageControl:GetPosX() - 20
      else
        messageControl = txt_rightNPCMessage
        startPosX = messageControl:GetPosX() + 20
      end
      local string = npcMessageData.message[npcMessageIndex]
      if nil ~= messageControl and nil ~= string then
        messageControl:SetTextMode(__eTextMode_AutoWrap)
        messageControl:SetText(string)
        messageControl:SetShow(true)
        if 0 ~= npcShowTime then
          local showAni = messageControl:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_00FFFFFF)
          luaTimer_AddEvent(PaGlobal_RewardSelect_RichMerchantRing_AudioEvent, npcShowTime * 1000, false, 0)
        else
          PaGlobal_RewardSelect_RichMerchantRing_AudioEvent()
        end
        local showAni = messageControl:addColorAnimation(0 + npcShowTime, 0.25 + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = messageControl:addMoveAnimation(0 + npcShowTime, 0.4 + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(startPosX, messageControl:GetPosY())
        moveAni:SetEndPosition(messageControl:GetPosX(), messageControl:GetPosY())
        local hideAni = messageControl:addColorAnimation(npcMessageTime - 0.25 + npcShowTime, npcMessageTime + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
        hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
        hideAni:SetHideAtEnd(true)
      end
      elapsedMessageTime = 0
      npcMessageIndex = npcMessageIndex + 1
    end
  else
    currentMessageType = -1
    npcMessageIndex = 1
    npcShowTime = 0.4
    elapsedTotalMessageTime = 0
    elapsedMessageTime = npcMessageTime + npcShowTime
    txt_leftNPCIcon:SetShow(false)
    txt_rightNPCIcon:SetShow(false)
  end
end
function PaGlobal_RewardSelect_ShowNPCMessage_PanOkSeonPersonal(deltaTime)
  if -1 == currentMessageType then
    return
  end
  local npcMessageData = npcMessage[currentMessageType]
  if nil == npcMessageData then
    return
  end
  elapsedTotalMessageTime = elapsedTotalMessageTime + deltaTime
  if elapsedTotalMessageTime < totalMessageTime then
    local npcMessageCount = npcMessageData.messageCount
    elapsedMessageTime = elapsedMessageTime + deltaTime
    if npcMessageTime + npcShowTime < elapsedMessageTime then
      if npcMessageCount < npcMessageIndex then
        return
      end
      if 1 == npcMessageIndex then
        if nil ~= PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG then
          PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:SetShow(true)
          local showAni = PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
          local moveAni = PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:addMoveAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          moveAni:SetStartPosition(PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:GetPosX() + 20, PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:GetPosY())
          moveAni:SetEndPosition(PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:GetPosX(), PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:GetPosY())
        end
      elseif 2 == npcMessageIndex and nil ~= PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG then
        PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:SetShow(true)
        local showAni = PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:addMoveAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:GetPosX() - 20, PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:GetPosY())
        moveAni:SetEndPosition(PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:GetPosX(), PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:GetPosY())
      end
      if npcMessageIndex >= 3 then
        npcShowTime = 0
      end
      local messageControl = PanOkSeonWorld.txt_PanOkSeonPersonal_LeftDesc
      local startPosX = messageControl:GetPosX()
      if 1 == npcMessageIndex % 2 then
        messageControl = PanOkSeonWorld.txt_PanOkSeonPersonal_LeftDesc
        startPosX = messageControl:GetPosX() - 20
      else
        messageControl = PanOkSeonWorld.txt_PanOkSeonPersonal_RightDesc
        startPosX = messageControl:GetPosX() + 20
      end
      local string = npcMessageData.message[npcMessageIndex]
      if nil ~= messageControl and nil ~= string then
        messageControl:SetTextMode(__eTextMode_AutoWrap)
        messageControl:SetText(string)
        messageControl:SetShow(true)
        if 0 ~= npcShowTime then
          local showAni = messageControl:addColorAnimation(0, npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_00FFFFFF)
          luaTimer_AddEvent(PaGlobal_RewardSelect_RichMerchantRing_AudioEvent, npcShowTime * 1000, false, 0)
        else
          PaGlobal_RewardSelect_RichMerchantRing_AudioEvent()
        end
        local showAni = messageControl:addColorAnimation(0 + npcShowTime, 0.25 + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = messageControl:addMoveAnimation(0 + npcShowTime, 0.4 + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(startPosX, messageControl:GetPosY())
        moveAni:SetEndPosition(messageControl:GetPosX(), messageControl:GetPosY())
        local hideAni = messageControl:addColorAnimation(npcMessageTime - 0.25 + npcShowTime, npcMessageTime + npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
        hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
        hideAni:SetHideAtEnd(true)
      end
      elapsedMessageTime = 0
      npcMessageIndex = npcMessageIndex + 1
    end
  else
    currentMessageType = -1
    npcMessageIndex = 1
    npcShowTime = 0.4
    elapsedTotalMessageTime = 0
    elapsedMessageTime = npcMessageTime + npcShowTime
    PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:SetShow(false)
    PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:SetShow(false)
  end
end
function PaGlobal_RewardSelect_RichMerchantRing_AudioEvent()
  audioPostEvent_SystemUi(1, 49)
  _AudioPostEvent_SystemUiForXBOX(1, 49)
end
function PaGlobal_RewardSelect_RichMerchantRing_CheckLanguage()
  local languageType = ToClient_getResourceType()
  local needChange = languageType == CppEnums.ServiceResourceType.eServiceResourceType_EN or languageType == CppEnums.ServiceResourceType.eServiceResourceType_DE or languageType == CppEnums.ServiceResourceType.eServiceResourceType_FR or languageType == CppEnums.ServiceResourceType.eServiceResourceType_ES or languageType == CppEnums.ServiceResourceType.eServiceResourceType_SP
  return needChange
end
function PaGlobal_RewardSelect_RichMerchantRing_ChangeMessageSize()
  txt_leftNPCMessage:SetSize(590, txt_leftNPCMessage:GetSizeY())
  txt_rightNPCMessage:SetSize(590, txt_rightNPCMessage:GetSizeY())
  txt_leftNPCMessage:ComputePos()
  txt_rightNPCMessage:ComputePos()
end
function PaGlobal_RewardSelect_SetNak_morningLand(msg)
  if msg == nil then
    return
  end
  local bossListUV = {
    [0] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_06.dds",
    [1] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_07.dds",
    [2] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_09.dds",
    [3] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_03.dds",
    [4] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_04.dds",
    [5] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_08.dds",
    [6] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_01.dds",
    [7] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_02.dds",
    [8] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_05.dds",
    [9] = "/Combine/Etc/Combine_Etc_Morning_Boss_Kill_Nak_10.dds"
  }
  txt_morningBossTitle:SetText(msg.main)
  txt_morningBossDesc:SetText(msg.sub)
  if bossListUV[msg.groupIdx] ~= nil then
    local bossTexture = bossListUV[msg.groupIdx]
    stc_morningBoss:ChangeTextureInfoNameDefault(bossTexture)
    stc_morningBoss:setRenderTexture(stc_morningBoss:getBaseTexture())
    stc_morningBoss:ComputePos()
    stc_morningBoss:SetShow(true)
  else
    return
  end
  stc_morningBoss:AddEffect("FUI_Morning_First_Clear_01A", false, 0, 0)
end
function PaGlobal_RewardSelect_SetNak_thousandInsam(msg)
  if msg == nil then
    return
  end
  txt_thousandInsamTitle:SetText(msg.main)
  stc_thousandInsam:ComputePos()
  stc_thousandInsam:SetShow(true)
  thousandInsamIcon:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_BabyBell(msg)
  if msg == nil then
    return
  end
  local characterStaticStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(21060)
  if characterStaticStatusWrapper ~= nil then
    txt_babyBellName:SetText(characterStaticStatusWrapper:getName())
  end
  txt_babyBellDesc:SetText(msg.main)
  stc_babyBell:ComputePos()
  stc_babyBell:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_Telescope(msg)
  if msg == nil then
    return
  end
  telescope._icon:ChangeTextureInfoName(msg.addMsg)
  telescope._icon:SetShow(false)
  telescope._bg:EraseAllEffect()
  telescope._bg:SetShow(true)
  telescope._txt_sub:SetText(msg.sub)
  telescope._txt_main:SetText(msg.main)
  telescope._txt_sub:SetShow(true)
  telescope._txt_main:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_ElementalBossBuffSun(msg)
  if msg == nil then
    return
  end
  elementalBossBuff._bg:ChangeTextureInfoName(messageTexture[messageType.ElementalBossBuffSun])
  elementalBossBuff._bg:EraseAllEffect()
  elementalBossBuff._bg:AddEffect("fUI_NakMessage_WorldBuff_01A", false, 0, 0)
  elementalBossBuff._bg:SetShow(true)
  elementalBossBuff._txt_sub:SetText(msg.sub)
  elementalBossBuff._txt_main:SetText(msg.main)
  elementalBossBuff._txt_sub:SetShow(true)
  elementalBossBuff._txt_main:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_ElementalBossBuffMoon(msg)
  if msg == nil then
    return
  end
  elementalBossBuff._bg:ChangeTextureInfoName(messageTexture[messageType.ElementalBossBuffMoon])
  elementalBossBuff._bg:EraseAllEffect()
  elementalBossBuff._bg:AddEffect("fUI_NakMessage_WorldBuff_01B", false, 0, 0)
  elementalBossBuff._bg:SetShow(true)
  elementalBossBuff._txt_sub:SetText(msg.sub)
  elementalBossBuff._txt_main:SetText(msg.main)
  elementalBossBuff._txt_sub:SetShow(true)
  elementalBossBuff._txt_main:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_ElementalBossBuffLand(msg)
  if msg == nil then
    return
  end
  elementalBossBuff._bg:ChangeTextureInfoName(messageTexture[messageType.ElementalBossBuffLand])
  elementalBossBuff._bg:EraseAllEffect()
  elementalBossBuff._bg:AddEffect("fUI_NakMessage_WorldBuff_01C", false, 0, 0)
  elementalBossBuff._bg:SetShow(true)
  elementalBossBuff._txt_sub:SetText(msg.sub)
  elementalBossBuff._txt_main:SetText(msg.main)
  elementalBossBuff._txt_sub:SetShow(true)
  elementalBossBuff._txt_main:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_Siege2024Raffle(msgType, msg)
  if msg == nil then
    return
  end
  local parentUI = siege2024Raffle
  parentUI:EraseAllEffect()
  parentUI:AddEffect("fUI_NakMessassage_03A", false, 0, 0)
  audioPostEvent_SystemUi(35, 3)
  _AudioPostEvent_SystemUiForXBOX(35, 3)
  parentUI:ChangeTextureInfoName(messageTexture[messageType.Siege2024Raffle])
  parentUI:SetShow(true)
  local text = UI.getChildControl(parentUI, "StaticText_Title")
  if text == nil then
    return
  end
  text:SetShow(true)
  text:SetText(msg.main)
end
function PaGlobal_RewardSelect_SetNak_Crogdalo(msg)
  if msg == nil then
    return
  end
  crogdalog._icon:ChangeTextureInfoName(msg.addMsg)
  crogdalog._icon:SetShow(true)
  crogdalog._bg:EraseAllEffect()
  crogdalog._bg:AddEffect("fUI_NakMessage_Crogdal_01A", false, 0, 0)
  crogdalog._bg:SetShow(true)
  crogdalog._txt_sub:SetText(msg.sub)
  crogdalog._txt_main:SetText(msg.main)
  crogdalog._txt_sub:SetShow(true)
  crogdalog._txt_main:SetShow(true)
  audioPostEvent_SystemUi(3, 27)
  _AudioPostEvent_SystemUiForXBOX(3, 27)
end
function PaGlobal_RewardSelect_SetNak_DragonPalaceCommon(msg)
  if msg == nil then
    return
  end
  stc_dragonPalaceDesc:SetText(msg.main)
  stc_dragonPalaceCommon:ComputePos()
  stc_dragonPalaceCommon:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_MorningLandWorldBoss(type, msg)
  if msg == nil then
    return
  end
  if type ~= messageType.morningLandWorldBossBulgasal and type ~= messageType.morningLandWorldBossUturi and type ~= messageType.morningLandWorldBossSangun and type ~= messageType.morningLandWorldBossDuoksini and type ~= messageType.morningLandWorldBossGoldenPig then
    return
  end
  stc_morningLandWorldBossDesc:SetText(msg.main)
  stc_morningLandWorldBossCommon:ChangeTextureInfoNameAsync(messageTexture[type])
  local x1, y1, x2, y2 = setTextureUV_Func(stc_morningLandWorldBossCommon, 3, 4, 1008, 400)
  stc_morningLandWorldBossCommon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_morningLandWorldBossCommon:setRenderTexture(stc_morningLandWorldBossCommon:getBaseTexture())
  stc_morningLandWorldBossCommon:ComputePos()
  stc_morningLandWorldBossCommon:SetShow(true)
end
function PaGlobal_RewardSelect_SetNak_RichMerchantRing(type, message)
  audioPostEvent_SystemUi(3, 20)
  _AudioPostEvent_SystemUiForXBOX(3, 20)
  txt_centerMessage:SetText(message)
  stc_blackBG:SetShow(true)
  stc_blackBG:SetColor(Defines.Color.C_FFFFFFFF)
  stc_blackBG:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  stc_blackBG:SetSpanSize(-Panel_RewardSelect_NakMessage:GetPosX(), -Panel_RewardSelect_NakMessage:GetPosY())
  local texutreInfo = npcTexture[type]
  if nil == texutreInfo then
    txt_leftNPCIcon:SetShow(false)
    txt_rightNPCIcon:SetShow(false)
    return
  end
  if nil ~= texutreInfo.leftNPC.texture then
    txt_leftNPCIcon:ChangeTextureInfoName(texutreInfo.leftNPC.texture)
  end
  if nil ~= texutreInfo.rightNPC.texture then
    txt_rightNPCIcon:ChangeTextureInfoName(texutreInfo.rightNPC.texture)
  end
  if nil ~= texutreInfo.leftNPC.uv then
    local x1, y1, x2, y2 = setTextureUV_Func(txt_leftNPCIcon, texutreInfo.leftNPC.uv.x1, texutreInfo.leftNPC.uv.y1, texutreInfo.leftNPC.uv.x2, texutreInfo.leftNPC.uv.y2)
    txt_leftNPCIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    txt_leftNPCIcon:setRenderTexture(txt_leftNPCIcon:getBaseTexture())
  end
  if nil ~= texutreInfo.rightNPC.uv then
    local x1, y1, x2, y2 = setTextureUV_Func(txt_rightNPCIcon, texutreInfo.rightNPC.uv.x1, texutreInfo.rightNPC.uv.y1, texutreInfo.rightNPC.uv.x2, texutreInfo.rightNPC.uv.y2)
    txt_rightNPCIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    txt_rightNPCIcon:setRenderTexture(txt_rightNPCIcon:getBaseTexture())
  end
  if nil ~= texutreInfo.leftNPC.size then
    txt_leftNPCIcon:SetSize(texutreInfo.leftNPC.size.x, texutreInfo.leftNPC.size.y)
  end
  if nil ~= texutreInfo.rightNPC.size then
    txt_rightNPCIcon:SetSize(texutreInfo.rightNPC.size.x, texutreInfo.rightNPC.size.y)
  end
  txt_leftNPCMessage:SetShow(false)
  txt_rightNPCMessage:SetShow(false)
end
function PaGlobal_RewardSelect_SetNak_Solare(type, title, desc)
  if _ContentsGroup_SolareMatching == false then
    return
  end
  audioPostEvent_SystemUi(3, 20)
  _AudioPostEvent_SystemUiForXBOX(3, 20)
  stc_NoticeImage:SetShow(false)
  stc_bossImage:SetShow(false)
  belmornBG:SetShow(false)
  belmornText:SetShow(false)
  _text_Msg:SetShow(false)
  _text_MsgSub:SetShow(false)
  bigNakMsg:SetShow(false)
  competitionBg:SetShow(false)
  competitionMsg:SetShow(false)
  competitionCount:SetShow(false)
  stc_worldBossNewJin:SetShow(false)
  stc_solareRankgame:SetShow(true)
  stc_solareRankgame:ChangeTextureInfoNameAsync(messageTexture[type])
  txt_solareTitle:SetText(title)
  txt_solareDesc:SetText(desc)
  local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
  stc_HuntingBg:SetShow(false)
  stc_HuntingBg:EraseAllEffect()
  local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
  stc_bigShipBg:SetShow(false)
  stc_bigShipBg:EraseAllEffect()
end
function PaGlobal_RewardSelect_SetNak_Arbitration(type, title, desc)
  stc_NoticeImage:SetShow(false)
  stc_bossImage:SetShow(false)
  belmornBG:SetShow(false)
  belmornText:SetShow(false)
  _text_Msg:SetShow(false)
  _text_MsgSub:SetShow(false)
  bigNakMsg:SetShow(false)
  competitionBg:SetShow(false)
  competitionMsg:SetShow(false)
  competitionCount:SetShow(false)
  stc_worldBossNewJin:SetShow(false)
  stc_arbitrationGuildWar:SetShow(true)
  txt_arbitrationGuildWar_Desc:SetText(desc)
  local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
  stc_HuntingBg:SetShow(false)
  stc_HuntingBg:EraseAllEffect()
  local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
  stc_bigShipBg:SetShow(false)
  stc_bigShipBg:EraseAllEffect()
end
function PaGlobal_RewardSelect_SetNak_BigShip(type, title, desc)
  stc_NoticeImage:SetShow(false)
  stc_bossImage:SetShow(false)
  belmornBG:SetShow(false)
  belmornText:SetShow(false)
  _text_Msg:SetShow(false)
  _text_MsgSub:SetShow(false)
  bigNakMsg:SetShow(false)
  competitionBg:SetShow(false)
  competitionMsg:SetShow(false)
  competitionCount:SetShow(false)
  stc_worldBossNewJin:SetShow(false)
  stc_bigShip:SetShow(true)
  txt_bigShipTitle:SetText(title)
  txt_bigShipDesc:SetText(desc)
  local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
  stc_HuntingBg:SetShow(false)
  stc_HuntingBg:EraseAllEffect()
end
function PaGlobal_RewardSelect_SetNak_KingAccessory(msg)
  if msg == nil then
    return
  end
  crogdalog._icon:ChangeTextureInfoName(msg.addMsg)
  crogdalog._icon:SetShow(true)
  crogdalog._bg:EraseAllEffect()
  crogdalog._bg:AddEffect("fUI_NakMessage_Crogdal_01A", false, 0, 0)
  crogdalog._bg:SetShow(true)
  crogdalog._txt_sub:SetText(msg.sub)
  crogdalog._txt_main:SetText(msg.main)
  crogdalog._txt_sub:SetShow(true)
  crogdalog._txt_main:SetShow(true)
  audioPostEvent_SystemUi(3, 27)
  _AudioPostEvent_SystemUiForXBOX(3, 27)
end
function PaGlobal_RewardSelect_IsForceShowMessage()
  return isForceShowMessage
end
function PaGlobal_RewardSelect_SetDefault()
  _text_Msg:SetFontColor(Defines.Color.C_FFFFEF82)
  _text_MsgSub:SetFontColor(Defines.Color.C_FFFFEF82)
  _text_Msg:SetSpanSize(0, 15)
  _text_MsgSub:SetSpanSize(0, 38)
  bigNakMsg:EraseAllEffect()
  localwarMsg:EraseAllEffect()
  localwarMsgSmallBG:EraseAllEffect()
  localwarMsg:SetShow(false)
  localwarMsgSmallBG:SetShow(false)
  localwarMsgBG:SetShow(false)
  _text_localwarMsg:SetShow(false)
  competitionBg:SetShow(false)
  competitionMsg:SetShow(false)
  competitionCount:SetShow(false)
  stallionIcon:SetShow(false)
  nationSiegeBG:EraseAllEffect()
  nationSiegeBG:SetShow(false)
  nationSiegeText:SetShow(false)
  belmornBG:SetShow(false)
  belmornText:SetShow(false)
  stc_worldBossNewJin:SetShow(false)
  stc_worldBossEffect:EraseAllEffect()
  stc_NoticeImage:SetShow(false)
  stc_bossImage:SetShow(false)
  stc_blackBG:SetShow(false)
  stc_centerMessage:SetShow(false)
  stc_leftNPC:SetShow(false)
  stc_rightNPC:SetShow(false)
  stc_rewardItemBG:SetShow(false)
  stc_solareRankgame:SetShow(false)
  stc_arbitrationGuildWar:SetShow(false)
  eventUI._stc_eventBossNewJin:SetShow(false)
  eventUI._stc_eventBossEffect:SetShow(false)
  local stc_HuntingBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_HuntingBg")
  stc_HuntingBg:SetShow(false)
  stc_HuntingBg:EraseAllEffect()
  local stc_bigShipBg = UI.getChildControl(Panel_RewardSelect_NakMessage, "Static_BigShipBG")
  stc_bigShipBg:SetShow(false)
  stc_bigShipBg:EraseAllEffect()
  stc_babyBell:SetShow(false)
  stc_thousandInsam:SetShow(false)
  stc_dragonPalaceCommon:SetShow(false)
  stc_morningLandWorldBossCommon:SetShow(false)
  stc_morningBoss:SetShow(false)
  stc_morningBoss:EraseAllEffect()
  PanOkSeonWorld.stc_PanOkSeonPersonal:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonWorld:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_LeftNpc:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_RightNpc:SetShow(false)
  PanOkSeonWorld.txt_PanOkSeonPersonal_LeftDesc:SetShow(false)
  PanOkSeonWorld.txt_PanOkSeonPersonal_RightDesc:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:SetShow(false)
  crogdalog._bg:SetShow(false)
  crogdalog._txt_sub:SetShow(false)
  crogdalog._txt_main:SetShow(false)
  telescope._bg:SetShow(false)
  telescope._txt_sub:SetShow(false)
  telescope._txt_main:SetShow(false)
  kingAccessory._bg:SetShow(false)
  kingAccessory._txt_sub:SetShow(false)
  kingAccessory._txt_main:SetShow(false)
  elementalBossBuff._bg:SetShow(false)
  elementalBossBuff._txt_main:SetShow(false)
  elementalBossBuff._txt_sub:SetShow(false)
  elfWarGuild:SetShow(false)
  elfWarMercenary:SetShow(false)
  elfWarStart:SetShow(false)
  elfWarWin:SetShow(false)
  elfWarLose:SetShow(false)
  elfWarTie:SetShow(false)
  siege2024Raffle:SetShow(false)
  stc_bigShip:SetShow(false)
  bigNakMsg:SetShow(false)
  _text_Msg:SetShow(false)
  _text_MsgSub:SetShow(false)
  eventBossUIOff()
  eventDrawUIOff()
end
function PaGlobal_RewardSelectNak_HidePanel()
  if nil == Panel_RewardSelect_NakMessage then
    _PA_ASSERT_NAME(false, "Panel_RewardSelect_NakMessage nil \236\158\133\235\139\136\235\139\164.", "\234\176\156\235\176\156\236\158\144")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_RewardSelect_NakMessage:SetRenderAndEventHide(true)
  else
    Panel_RewardSelect_NakMessage:SetRenderAndEventHide(false)
  end
end
function PaGlobalFunc_NakMessage_CheckReturnMiniGame()
  if _ContentsGroup_NewUI_Fishing_All == true then
    if PaGlobal_Fishing_All_GetShowPanel ~= nil and PaGlobal_Fishing_All_GetShowPanel() == true then
      return true
    end
  elseif Panel_Global_Manual ~= nil and Panel_Global_Manual:GetShow() == true or Panel_Fishing ~= nil and Panel_Fishing:GetShow() == true then
    return true
  end
  if true == _ContentsGroup_NewUI_Jaksal_All and nil ~= PaGlobal_Jaksal_All_GetShow and true == PaGlobal_Jaksal_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_Find_All_GetShow and true == PaGlobal_MiniGame_Find_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_PowerControl_All_GetShow and true == PaGlobal_PowerControl_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_Rhythm_All_GetShow and true == PaGlobal_MiniGame_Rhythm_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_Rhythm_Drum_All_GetShow and true == PaGlobal_MiniGame_Rhythm_Drum_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_Gradient_All_GetShow and true == PaGlobal_MiniGame_Gradient_All_GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_GradientY_All_GetShow and true == PaGlobal_MiniGame_GradientY_All_GetShow() then
    return true
  end
  if nil ~= Panel_MiniGame_Timing_All and true == Panel_MiniGame_Timing_All:GetShow() then
    return true
  end
  if nil ~= PaGlobal_MiniGame_BattleGauge_All_GetShow and true == PaGlobal_MiniGame_BattleGauge_All_GetShow() then
    return true
  end
  if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
    if nil ~= PaGlobal_MiniGame_SniperGame_All_GetShow and true == PaGlobal_MiniGame_SniperGame_All_GetShow() then
      return true
    end
    if nil ~= PaGlobal_MiniGame_SniperGame_Result_All_GetShow and true == PaGlobal_MiniGame_SniperGame_Result_All_GetShow() then
      return true
    end
  end
  return false
end
function PaGlobalFunc_NakMessage_ClearQueue()
  if Panel_RewardSelect_NakMessage == nil then
    return
  end
  local tempArray = Array.new()
  for index = 0, curIndex do
    if MessageData._Msg[index] ~= nil and MessageData._Msg[index].type ~= nil and MessageData._Msg[index].type == messageType.morningBoss then
      local msgData = {
        main = "",
        sub = "",
        addMsg = "",
        groupIdx = nil
      }
      msgData.main = MessageData._Msg[index].msg.main
      msgData.sub = MessageData._Msg[index].msg.sub
      msgData.addMsg = MessageData._Msg[index].msg.addMsg
      msgData.groupIdx = MessageData._Msg[index].msg.groupIdx
      local tempData = {
        msg = msgData,
        type = MessageData._Msg[index].type
      }
      tempArray:push_back(tempData)
    end
  end
  MessageData._Msg = {}
  curIndex = 0
  processIndex = 0
  for index = 1, #tempArray do
    local tempData = tempArray[index]
    if tempData ~= nil then
      curIndex = curIndex + 1
      MessageData._Msg[curIndex] = {}
      MessageData._Msg[curIndex].msg = tempData.msg
      MessageData._Msg[curIndex].type = tempData.type
    end
  end
end
function PaGlobal_RewardSelect_PanOkSeonPersonal_First(msg)
  audioPostEvent_SystemUi(3, 20)
  _AudioPostEvent_SystemUiForXBOX(3, 20)
  PanOkSeonWorld.stc_PanOkSeonPersonal:SetShow(true)
  PanOkSeonWorld.stc_PanOkSeonPersonal_MultiDesc:SetText(msg.main .. "\n" .. msg.sub)
  PanOkSeonWorld.stc_PanOkSeonPersonal_LeftNpc:SetShow(true)
  PanOkSeonWorld.stc_PanOkSeonPersonal_RightNpc:SetShow(true)
  PanOkSeonWorld.txt_PanOkSeonPersonal_LeftDesc:SetShow(false)
  PanOkSeonWorld.txt_PanOkSeonPersonal_RightDesc:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_LeftBG:SetShow(false)
  PanOkSeonWorld.stc_PanOkSeonPersonal_RightBG:SetShow(false)
  Panel_RewardSelect_NakMessage:ResetVertexAni()
end
function PaGlobal_RewardSelect_PanOkSeonWorld_First(msg)
  PanOkSeonWorld.stc_PanOkSeonWorld:SetShow(true)
  local txt_Title = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonWorld, "StaticText_Title")
  local txt_Desc = UI.getChildControl(PanOkSeonWorld.stc_PanOkSeonWorld, "StaticText_Desc")
  txt_Title:SetText(msg.main)
  txt_Desc:SetText(msg.sub)
end
function PaGlobal_RewardSelect_SetNak_ElfWar(msgType, msg)
  local parentUI
  if msgType == messageType.ElfWarApplyGuild then
    parentUI = elfWarGuild
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_03A", false, 0, 0)
    audioPostEvent_SystemUi(35, 3)
    _AudioPostEvent_SystemUiForXBOX(35, 3)
  elseif msgType == messageType.ElfWarApplyMercenary then
    parentUI = elfWarMercenary
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_03B", false, 0, 0)
    audioPostEvent_SystemUi(35, 3)
    _AudioPostEvent_SystemUiForXBOX(35, 3)
  elseif msgType == messageType.ElfWarRaffleGuild then
    parentUI = elfWarGuild
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_03A", false, 0, 0)
    audioPostEvent_SystemUi(35, 3)
    _AudioPostEvent_SystemUiForXBOX(35, 3)
  elseif msgType == messageType.ElfWarRaffleMercenary then
    parentUI = elfWarMercenary
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_03B", false, 0, 0)
    audioPostEvent_SystemUi(35, 3)
    _AudioPostEvent_SystemUiForXBOX(35, 3)
  elseif msgType == messageType.ElfWarStart then
    parentUI = elfWarStart
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_05A", false, 0, 0)
    audioPostEvent_SystemUi(35, 4)
    _AudioPostEvent_SystemUiForXBOX(35, 4)
  elseif msgType == messageType.ElfWarKamasylviaWin then
    parentUI = elfWarWin
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_06B", false, 0, 0)
    audioPostEvent_SystemUi(35, 5)
    _AudioPostEvent_SystemUiForXBOX(35, 5)
    audioPostEvent_SystemUi(36, 60)
    _AudioPostEvent_SystemUiForXBOX(36, 60)
    isForceShowMessage = true
  elseif msgType == messageType.ElfWarOdylitaWin then
    parentUI = elfWarWin
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_06B", false, 0, 0)
    audioPostEvent_SystemUi(35, 5)
    _AudioPostEvent_SystemUiForXBOX(35, 5)
    audioPostEvent_SystemUi(36, 61)
    _AudioPostEvent_SystemUiForXBOX(36, 61)
    isForceShowMessage = true
  elseif msgType == messageType.ElfWarTie then
    parentUI = elfWarTie
    parentUI:EraseAllEffect()
    parentUI:AddEffect("fUI_NakMessassage_06C", false, 0, 0)
    audioPostEvent_SystemUi(35, 7)
    _AudioPostEvent_SystemUiForXBOX(35, 7)
    audioPostEvent_SystemUi(36, 63)
    _AudioPostEvent_SystemUiForXBOX(36, 63)
    isForceShowMessage = true
  else
    UI.ASSERT(false, "ElfWarEventType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148!")
    return
  end
  parentUI:ChangeTextureInfoName(messageTexture[msgType])
  parentUI:SetShow(true)
  local text = UI.getChildControl(parentUI, "MultilineText_Desc")
  if text == nil then
    UI.ASSERT(false, "\235\173\148\234\176\128 \235\139\164\235\165\184 \237\152\149\236\139\157\236\157\152 UI\234\176\128 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164!")
    return
  end
  text:SetShow(true)
  text:SetText(msg.main)
end
registerEvent("FromClient_MorningLandBossClearAck", "FromClient_MorningLandBossClearAck")
registerEvent("FromClient_notifyBroadcastLifeLevelUp", "FromClient_notifyBroadcastLifeLevelUp")
registerEvent("FromClient_notifyGetItem", "FromClient_notifyGetItem")
registerEvent("EventDieInstanceMonster", "FromClient_EventDieInstanceMonster")
registerEvent("FromClient_NoticeChatMessageUpdate", "FromClient_NoticeChatMessageUpdate")
registerEvent("FromClient_NoticeChatMessageUpdate_Arsha", "FromClient_NoticeChatMessageUpdate_Arsha")
registerEvent("FromClient_ArrestAToB", "FromClient_ArrestAToB")
registerEvent("FromClient_RegistGuildServant", "FromClient_RegistGuildServant")
registerEvent("FromClient_notifyRegisterServantAtAuction", "FromClient_notifyRegisterServantAtAuction")
registerEvent("FromClient_notifyRegisterWorkerAtAuction", "FromClient_notifyRegisterWorkerAtAuction")
registerEvent("FromClient_UpdateRestrictedArea", "FromClient_UpdateRestrictedArea")
registerEvent("FromClient_EmployeeRegisterAck", "FromClient_EmployeeRegisterAck")
registerEvent("FromClient_GuildDrill_Notify", "FromClient_GuildDrillNotify")
registerEvent("FromClient_StartOrFinishVote", "FromClient_StartOrFinishVote")
registerEvent("FromClient_UseGuildActivePolicy", "FromClient_UseGuildActivePolicy")
registerEvent("onScreenResize", "NakMessagePanel_Resize_For_RewardSelect")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_RewardSelectNak_HidePanel")
registerEvent("FromClient_GetGrowthPassRewardItem", "FromClient_GetGrowthPassRewardItem")
registerEvent("FromClient_SolareStartEndMessage", "FromClient_SolareStartEndMessage")
registerEvent("FromClient_Notify_VehicleRegister", "FromClient_Notify_VehicleRegister")
registerEvent("FromClient_Notify_GuildPresent", "FromClient_Notify_GuildPresent")
registerEvent("FromClient_DragonPalaceInstanceEndMessage", "FromClient_DragonPalaceInstanceEndMessage")
registerEvent("FromClient_ElfWarNakMessage", "FromClient_ElfWarNakMessage")
registerEvent("FromClient_ElementalMonsterBuffNakMessage", "FromClient_ElementalMonsterBuffNakMessage")
registerEvent("FromClient_ShowGuildMatchPlayNak", "FromClient_ShowGuildMatchPlayNak")
