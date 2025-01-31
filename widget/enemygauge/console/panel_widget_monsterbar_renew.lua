local UI_color = Defines.Color
local blackBg = UI.getChildControl(Panel_Monster_Bar, "Static_blackBG")
local lua_TargetInfo_Name = UI.getChildControl(Panel_Monster_Bar, "Static_Name_TargetName")
local lua_TargetInfo_NormalEnemyGauge = UI.getChildControl(Panel_Monster_Bar, "EnemyGauge_Back")
local lua_TargetInfo_NormalHpRate = UI.getChildControl(Panel_Monster_Bar, "Progress2_TargetHP_Rate")
local lua_TargetInfo_NormalHpRate_Later = UI.getChildControl(Panel_Monster_Bar, "Progress2_TargetHP_Rate_Later")
local lua_TargetInfo_BossEnemyGauge = UI.getChildControl(Panel_Monster_Bar, "BossEnemyGauge_Back")
local lua_TargetInfo_BossHpRate = UI.getChildControl(Panel_Monster_Bar, "BossProgress2_TargetHP_Rate")
local lua_TargetInfo_BossHpRate_Later = UI.getChildControl(Panel_Monster_Bar, "BossProgress2_TargetHP_Rate_Later")
local lua_TargetInfo_PlayerEnemyGauge = UI.getChildControl(Panel_Monster_Bar, "PlayerEnemyGauge_Back")
local lua_TargetInfo_PlayerHpRate = UI.getChildControl(Panel_Monster_Bar, "PlayerProgress2_TargetHP_Rate")
local lua_TargetInfo_PlayerHpRate_Later = UI.getChildControl(Panel_Monster_Bar, "PlayerProgress2_TargetHP_Rate_Later")
local lua_TargetInfo_StunRate_Back = UI.getChildControl(Panel_Monster_Bar, "EnemyGaugeStun_Back")
local lua_TargetInfo_StunRate = UI.getChildControl(Panel_Monster_Bar, "Progress2_TargetStun_Rate")
local _stunEffect = UI.getChildControl(Panel_Monster_Bar, "Static_StunMaxEffect")
local lua_EnemyTypeIcon = UI.getChildControl(Panel_Monster_Bar, "Static_Enemy_TypeIcon")
local lua_EnemyTypeText = UI.getChildControl(Panel_Monster_Bar, "StaticText_Type")
local monsterBuffIcon_Base = UI.getChildControl(Panel_Monster_Bar, "Static_EnemyBuffIcon")
local EnemyBuffListBoarder = UI.getChildControl(Panel_Monster_Bar, "Static_EnemyBuffListBoarder")
local _darkSpirit = UI.getChildControl(Panel_Monster_Bar, "Static_Darkspirit")
local _helpBubble = UI.getChildControl(Panel_Monster_Bar, "Static_HelpBubble")
local _helpMsg = UI.getChildControl(Panel_Monster_Bar, "StaticText_HelpMsg")
local _RunawayBG = UI.getChildControl(Panel_Monster_Bar, "Static_Runaway")
local _txt_Runaway = UI.getChildControl(Panel_Monster_Bar, "StaticText_Runaway")
local _checkBtnAlert = UI.getChildControl(Panel_Monster_Bar, "CheckButton_Alert")
local _noKnowledgeText = UI.getChildControl(Panel_Monster_Bar, "StaticText_NoKnowledge")
local lua_EnemyNightIcon = UI.createControl(__ePAUIControl_Static, EnemyBuffListBoarder, "monsterNightIcon")
CopyBaseProperty(monsterBuffIcon_Base, lua_EnemyNightIcon)
local elapsedTime = 0
local monsterList = {}
local appliedBuff_UIPool = {}
local appliedBuff_UIPool_Last = 0
local appliedBuff_DATAPool = {}
local targetActorKey = 0
isMonsterBarShow = false
local isXbox = _ContentsGroup_UsePadSnapping
local hpColor = {
  _75 = 4293444145,
  _50 = 4292647697,
  _25 = 4292442624,
  _10 = 4290660864,
  _5 = 4293676845,
  _base = 4294955350
}
if true == _ContentsOption_CH_HPMP_Bar_Color then
  hpColor._10 = 4290669312
  hpColor._5 = 4294345518
end
lua_TargetInfo_NormalEnemyGauge:SetShow(false)
lua_TargetInfo_NormalHpRate:SetShow(false)
lua_TargetInfo_NormalHpRate_Later:SetShow(false)
lua_TargetInfo_BossEnemyGauge:SetShow(false)
lua_TargetInfo_BossHpRate:SetShow(false)
lua_TargetInfo_BossHpRate_Later:SetShow(false)
lua_TargetInfo_PlayerEnemyGauge:SetShow(false)
lua_TargetInfo_PlayerHpRate:SetShow(false)
lua_TargetInfo_PlayerHpRate_Later:SetShow(false)
_checkBtnAlert:addInputEvent("Mouse_LUp", "GameOption_NearMonsterAlertOff()")
local function getMaxLevel()
  local level = 0
  for actorKey, monsterLevel in pairs(monsterList) do
    if monsterLevel > level then
      level = monsterLevel
    end
  end
  return level
end
local function updateStunGauge(targetActor, stun, maxStun)
  local percents = stun / maxStun * 100
  if targetActor:hasStun() and stun > 0 then
    EnemyBuffListBoarder:SetSpanSize(-15, 0)
    lua_TargetInfo_StunRate:SetShow(true)
    lua_TargetInfo_StunRate_Back:SetShow(true)
    lua_TargetInfo_StunRate:SetProgressRate(percents)
    lua_TargetInfo_StunRate:SetCurrentProgressRate(percents)
    return true
  else
    EnemyBuffListBoarder:SetSpanSize(-15, 15)
    lua_TargetInfo_StunRate:SetShow(false)
    lua_TargetInfo_StunRate_Back:SetShow(false)
    return false
  end
end
local nowTarget = {}
function Panel_MonsterInfo_UpdateStun(actorKey, stun, maxStun)
  if targetActorKey == actorKey then
    local targetActor = getCharacterActor(actorKey)
    updateStunGauge(targetActor:get(), stun, maxStun)
  end
end
function targetHpInfo_Update_Monster(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    PaGlobalFunc_MainStatusInfo_DangerAlertShow(false)
    return
  end
  local monsterLevel = targetActor:get():getCharacterStaticStatus().level
  local playerLevel = getSelfPlayer():get():getLevel()
  local levelDiff = monsterLevel - playerLevel + 6
  levelDiff = math.max(levelDiff, 1)
  levelDiff = math.min(levelDiff, 11)
  _darkSpirit:EraseAllEffect()
  _darkSpirit:SetShow(false)
  _RunawayBG:SetShow(false)
  _txt_Runaway:SetShow(false)
  _checkBtnAlert:SetShow(false)
  _noKnowledgeText:SetShow(false)
  if 4 ~= targetActor:getCharacterGradeType() then
    if checkActiveCondition(targetActor:getCharacterKey()) == true then
      _darkSpirit:SetShow(false)
      _helpBubble:SetShow(false)
      _helpMsg:SetShow(false)
      lua_TargetInfo_NormalHpRate:SetProgressRate(nowHP)
      lua_TargetInfo_NormalHpRate_Later:SetProgressRate(nowHP)
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._base)
    else
      if _darkSpirit:GetShow() then
        _darkSpirit:SetShow(false)
        _helpBubble:SetShow(false)
        _helpMsg:SetShow(false)
      end
      if not isXbox and playerLevel <= 20 then
        _darkSpirit:SetShow(true)
        _helpBubble:SetShow(true)
        _helpMsg:SetShow(true)
        _helpMsg:SetTextMode(__eTextMode_AutoWrap)
        _helpMsg:SetAutoResize(true)
        _helpMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENEMYGAUGE_DARKSPIRIT"))
        _helpBubble:SetSize(_helpBubble:GetSizeX(), _helpMsg:GetSizeY() + 37)
        _helpMsg:SetPosY(_helpBubble:GetPosY() + 27)
      end
      lua_TargetInfo_NormalHpRate:SetProgressRate(100)
      _noKnowledgeText:SetShow(true)
      if nowHP > 75 then
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._75)
      elseif nowHP > 50 then
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._50)
      elseif nowHP > 25 then
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._25)
      elseif nowHP > 10 then
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._10)
      elseif nowHP > 5 then
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._5)
      else
        lua_TargetInfo_NormalHpRate:SetColor(hpColor._5)
      end
    end
  elseif checkActiveCondition(targetActor:getCharacterKey()) == true then
    _darkSpirit:SetShow(false)
    _helpBubble:SetShow(false)
    _helpMsg:SetShow(false)
    lua_TargetInfo_BossHpRate:SetProgressRate(nowHP)
    lua_TargetInfo_BossHpRate_Later:SetProgressRate(nowHP)
    lua_TargetInfo_BossHpRate:SetColor(hpColor._base)
  else
    if _darkSpirit:GetShow() then
      _darkSpirit:SetShow(false)
      _helpBubble:SetShow(false)
      _helpMsg:SetShow(false)
    end
    if not isXbox and playerLevel <= 20 then
      _darkSpirit:SetShow(true)
      _helpBubble:SetShow(true)
      _helpMsg:SetShow(true)
      _helpMsg:SetTextMode(__eTextMode_AutoWrap)
      _helpMsg:SetAutoResize(true)
      _helpMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENEMYGAUGE_DARKSPIRIT"))
      _helpBubble:SetSize(_helpBubble:GetSizeX(), _helpMsg:GetSizeY() + 37)
      _helpMsg:SetPosY(_helpBubble:GetPosY() + 27)
    end
    lua_TargetInfo_BossHpRate:SetProgressRate(100)
    if nowHP > 75 then
      lua_TargetInfo_BossHpRate:SetColor(hpColor._75)
    elseif nowHP > 50 then
      lua_TargetInfo_BossHpRate:SetColor(hpColor._50)
    elseif nowHP > 25 then
      lua_TargetInfo_BossHpRate:SetColor(hpColor._25)
    elseif nowHP > 10 then
      lua_TargetInfo_BossHpRate:SetColor(hpColor._10)
    elseif nowHP > 5 then
      lua_TargetInfo_BossHpRate:SetColor(hpColor._5)
    else
      lua_TargetInfo_BossHpRate:SetColor(hpColor._5)
    end
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
end
function targetHpInfo_Update_Player(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  _darkSpirit:SetShow(false)
  _helpBubble:SetShow(false)
  _helpMsg:SetShow(false)
  local playerLevel = getSelfPlayer():get():getLevel()
  lua_TargetInfo_PlayerHpRate:SetProgressRate(nowHP)
  lua_TargetInfo_PlayerHpRate_Later:SetProgressRate(nowHP)
  lua_TargetInfo_PlayerHpRate:SetColor(hpColor._base)
end
function targetHpInfo_Update_Other(actorKey, nowHP)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    return
  end
  local playerLevel = getSelfPlayer():get():getLevel()
  if checkActiveCondition(targetActor:getCharacterKey()) == true then
    _darkSpirit:SetShow(false)
    _helpBubble:SetShow(false)
    _helpMsg:SetShow(false)
    lua_TargetInfo_NormalHpRate:SetProgressRate(nowHP)
    lua_TargetInfo_NormalHpRate_Later:SetProgressRate(nowHP)
    lua_TargetInfo_NormalHpRate:SetColor(hpColor._base)
  else
    if not isXbox then
      if playerLevel <= 20 then
        _darkSpirit:SetShow(true)
        _helpBubble:SetShow(true)
        _helpMsg:SetShow(true)
        _darkSpirit:EraseAllEffect()
        _darkSpirit:AddEffect("fUI_DarkSpirit_Tutorial", true, 0, 0)
        _helpMsg:SetTextMode(__eTextMode_AutoWrap)
        _helpMsg:SetAutoResize(true)
        _helpMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENEMYGAUGE_DARKSPIRIT"))
        _helpBubble:SetSize(_helpBubble:GetSizeX(), _helpMsg:GetSizeY() + 37)
        _helpMsg:SetPosY(_helpBubble:GetPosY() + 27)
      else
        _darkSpirit:SetShow(false)
        _helpBubble:SetShow(false)
        _helpMsg:SetShow(false)
      end
    end
    lua_TargetInfo_NormalHpRate:SetProgressRate(100)
    if nowHP > 75 then
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._75)
    elseif nowHP > 50 then
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._50)
    elseif nowHP > 25 then
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._25)
    elseif nowHP > 10 then
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._10)
    elseif nowHP > 5 then
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._5)
    else
      lua_TargetInfo_NormalHpRate:SetColor(hpColor._5)
    end
  end
end
function panel_Update_Monster_Info(actorKey)
  blackBg:SetShow(false)
  lua_TargetInfo_NormalEnemyGauge:SetShow(false)
  lua_TargetInfo_NormalHpRate:SetShow(false)
  lua_TargetInfo_NormalHpRate_Later:SetShow(false)
  lua_TargetInfo_BossEnemyGauge:SetShow(false)
  lua_TargetInfo_BossHpRate:SetShow(false)
  lua_TargetInfo_BossHpRate_Later:SetShow(false)
  lua_TargetInfo_PlayerEnemyGauge:SetShow(false)
  lua_TargetInfo_PlayerHpRate:SetShow(false)
  lua_TargetInfo_PlayerHpRate_Later:SetShow(false)
  lua_TargetInfo_Name:SetShow(false)
  local targetActor = getCharacterActor(actorKey)
  if nil == targetActor then
    for buffIcon_idx = 0, appliedBuff_UIPool_Last do
      if appliedBuff_UIPool[buffIcon_idx] then
        appliedBuff_UIPool[buffIcon_idx]:SetShow(false)
      end
    end
    return
  end
  targetActorKey = actorKey
  local monsterLevel = targetActor:get():getCharacterStaticStatus().level
  local playerLevel = getSelfPlayer():get():getLevel()
  monsterList[targetActorKey] = monsterLevel
  local maxLevel = getMaxLevel()
  elapsedTime = 0
  local modecheck = GetUIMode()
  if Defines.UIMode.eUIMode_NpcDialog ~= modecheck then
    Panel_Monster_Bar:SetShow(true, false)
    FGlobal_Panel_Monster_Bar_RePos()
  else
    isMonsterBarShow = true
  end
  if targetActor:get():isHiddenName() then
    lua_TargetInfo_Name:SetShow(false)
  else
    lua_TargetInfo_Name:SetShow(true)
  end
  updateStunGauge(targetActor:get(), targetActor:get():getStun(), targetActor:get():getMaxStun())
  EnemyBuffListBoarder:SetShow(true)
  for buffIcon_idx = 0, appliedBuff_UIPool_Last do
    if appliedBuff_UIPool[buffIcon_idx] then
      appliedBuff_UIPool[buffIcon_idx]:SetShow(false)
    end
  end
  local appliedBuff = targetActor:getAppliedBuffBeginNotSort()
  local appliedBuff_Idx = 0
  appliedBuff_DATAPool = {}
  while nil ~= appliedBuff do
    local appliedBuffType
    if nil == appliedBuff_UIPool[appliedBuff_Idx] then
      local buffIcon = UI.createControl(__ePAUIControl_Static, EnemyBuffListBoarder, "monsterBuffIcon_" .. appliedBuff_Idx)
      CopyBaseProperty(monsterBuffIcon_Base, buffIcon)
      appliedBuff_UIPool[appliedBuff_Idx] = buffIcon
      if appliedBuff_Idx > appliedBuff_UIPool_Last then
        appliedBuff_UIPool_Last = appliedBuff_Idx
      end
    end
    appliedBuff_UIPool[appliedBuff_Idx]:ChangeTextureInfoNameAsync("icon/" .. appliedBuff:getIconName())
    local x1, y1, x2, y2 = setTextureUV_Func(appliedBuff_UIPool[appliedBuff_Idx], 0, 0, 32, 32)
    appliedBuff_UIPool[appliedBuff_Idx]:getBaseTexture():setUV(x1, y1, x2, y2)
    appliedBuff_UIPool[appliedBuff_Idx]:setRenderTexture(appliedBuff_UIPool[appliedBuff_Idx]:getBaseTexture())
    appliedBuff_UIPool[appliedBuff_Idx]:SetShow(true)
    appliedBuff_UIPool[appliedBuff_Idx]:SetSpanSize(appliedBuff_UIPool[appliedBuff_Idx]:GetSizeX() * appliedBuff_Idx, appliedBuff_UIPool[appliedBuff_Idx]:GetSpanSize().y)
    EnemyBuffListBoarder:SetSize(monsterBuffIcon_Base:GetSizeX() * appliedBuff_Idx, EnemyBuffListBoarder:GetSizeY())
    EnemyBuffListBoarder:ComputePos()
    appliedBuff_DATAPool[appliedBuff_Idx] = appliedBuff
    appliedBuff_Idx = appliedBuff_Idx + 1
    appliedBuff = targetActor:getAppliedBuffNextNotSort()
  end
  appliedBuff_Idx = 0
  local mentalCardKey = ToClient_getMentalCardKey(actorKey)
  local selfPlayerWrapper = getSelfPlayer()
  local mentalLevel = -1
  local mentalLevelString = ""
  if nil ~= selfPlayerWrapper then
    local selfPlayer = selfPlayerWrapper:get()
    if nil ~= selfPlayer then
      local mentalCard = selfPlayer:getMentalKnowledge():getCardByKeyRaw(mentalCardKey)
      if nil ~= mentalCard then
        mentalLevel = mentalCard:getLevel()
      end
      mentalLevelString = PAGetString(Defines.StringSheet_GAME, "MENTAL_OBJECTCARD_" .. tostring(mentalLevel - 1))
    end
  end
  if targetActor:get():isPlayer() then
    local playerActorProxyWrapper = getPlayerActor(actorKey)
    if playerActorProxyWrapper:get():isVolunteer() then
      lua_TargetInfo_Name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    else
      lua_TargetInfo_Name:SetText(targetActor:getName() .. mentalLevelString)
    end
  else
    lua_TargetInfo_Name:SetText(targetActor:getName() .. mentalLevelString)
  end
  if isGameServiceTypeDev() == true then
    local elementSSW = ToClient_getElementalMonsterInfoByCharacterKey(targetActor:getCharacterKey())
    if elementSSW ~= nil then
      lua_TargetInfo_Name:SetText(lua_TargetInfo_Name:GetText() .. "(\236\134\141\236\132\177: " .. tostring(elementSSW:getElementalStatType()) .. " ,\234\179\181: " .. tostring(elementSSW:getOffenceStat()) .. " ,\235\176\169: " .. tostring(elementSSW:getDffenceStat()) .. ")")
    end
  end
  local curHP = targetActor:get():getHp()
  local maxHP = targetActor:get():getMaxHp()
  local nowHP = curHP * 100 / maxHP
  if curHP < 1 then
    Panel_Monster_Bar:SetShow(false, false)
    monsterList = {}
    PaGlobalFunc_MainStatusInfo_DangerAlertShow(false)
  end
  if targetActor:get():isMonster() then
    targetHpInfo_Update_Monster(actorKey, nowHP)
    _recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  elseif targetActor:get():isPlayer() then
    targetHpInfo_Update_Player(actorKey, nowHP)
  else
    targetHpInfo_Update_Other(actorKey, nowHP)
    _recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  end
  if targetActor:get():getCharacterStaticStatus()._isHiddenHp then
    lua_TargetInfo_NormalEnemyGauge:SetShow(false)
    lua_TargetInfo_NormalHpRate:SetShow(false)
    lua_TargetInfo_NormalHpRate_Later:SetShow(false)
    lua_TargetInfo_StunRate_Back:SetShow(false)
    lua_TargetInfo_StunRate:SetShow(false)
    _darkSpirit:SetShow(false)
    _helpBubble:SetShow(false)
    _helpMsg:SetShow(false)
  elseif targetActor:get():isMonster() then
    if 4 == targetActor:getCharacterGradeType() then
      lua_TargetInfo_BossEnemyGauge:SetShow(true)
      lua_TargetInfo_BossHpRate:SetShow(true)
      lua_TargetInfo_BossHpRate_Later:SetShow(true)
    else
      lua_TargetInfo_NormalEnemyGauge:SetShow(true)
      lua_TargetInfo_NormalHpRate:SetShow(true)
      lua_TargetInfo_NormalHpRate_Later:SetShow(true)
    end
  elseif targetActor:get():isPlayer() then
    lua_TargetInfo_PlayerEnemyGauge:SetShow(true)
    lua_TargetInfo_PlayerHpRate:SetShow(true)
    lua_TargetInfo_PlayerHpRate_Later:SetShow(true)
  else
    lua_TargetInfo_NormalEnemyGauge:SetShow(true)
    lua_TargetInfo_NormalHpRate:SetShow(true)
    lua_TargetInfo_NormalHpRate_Later:SetShow(true)
  end
  lua_EnemyTypeIcon:SetShow(false)
  lua_EnemyTypeText:SetShow(false)
  if targetActor:get():isMonster() then
    lua_EnemyTypeText:SetShow(false)
    lua_EnemyTypeText:SetPosX(lua_EnemyTypeIcon:GetPosX() / 2 + 27)
    lua_EnemyTypeText:SetPosY(lua_EnemyTypeIcon:GetPosY() + 11)
    local monsterType = ""
    local checkMonsterType = targetActor:getCharacterStaticStatusWrapper():getTribeType()
    if CppEnums.TribeType.eTribe_Human == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/human.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_HUMAN"))
    elseif CppEnums.TribeType.eTribe_Ain == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/ain.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_AIN"))
    elseif CppEnums.TribeType.eTribe_ETC == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/animal.dds")
      lua_EnemyTypeText:SetText("")
    elseif CppEnums.TribeType.eTribe_Boss == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/KamasylviaMonster.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_UNDEAD"))
    elseif CppEnums.TribeType.eTribe_Reptile == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/Violent.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_ETRIBEREPTILE"))
    elseif CppEnums.TribeType.eTribe_Untribe == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/etc.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_UNTRIBE"))
    elseif CppEnums.TribeType.eTribe_Hunting == checkMonsterType then
      lua_EnemyTypeIcon:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/EnemyGauge/hunt.dds")
      lua_EnemyTypeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_HUNT"))
    end
    lua_EnemyTypeText:SetText("")
    local x1, y1, x2, y2 = setTextureUV_Func(lua_EnemyTypeIcon, 0, 0, 32, 32)
    lua_EnemyTypeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    lua_EnemyTypeIcon:setRenderTexture(lua_EnemyTypeIcon:getBaseTexture())
    lua_EnemyTypeIcon:SetShow(true)
    local hour = math.floor(getIngameTime_minute() / 60)
    local darkNightPowerUp = targetActor:get():getCharacterStaticStatus()._isPowerUpInNight
    if (22 == hour or 0 == hour or 1 == hour) and darkNightPowerUp then
      lua_EnemyTypeIcon:EraseAllEffect()
      lua_EnemyTypeIcon:AddEffect("UI_Monster_Emergency", true, 0, 0)
    else
      lua_EnemyTypeIcon:EraseAllEffect()
    end
  end
end
function _recentTargetInfo_TendencyOnDead_MSG(targetActor, actorKey)
  if targetActor:get():hasVehicleOwner() then
    return
  end
  local targetName = targetActor:getCharacterStaticStatusWrapper():getName()
  local characterTOD = targetActor:getCharacterStaticStatusWrapper():getTendencyOnDead()
  if nil ~= characterTOD and characterTOD < 0 then
    if nil ~= nowTarget[actorKey] then
      if nowTarget[actorKey] < 10 then
        nowTarget[actorKey] = nowTarget[actorKey] + 1
      else
        nowTarget[actorKey] = 0
        if ToClient_isDontPvPDecreaseTendency() == false and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == false then
          if _ContentsOption_CH_Tendency == nil or _ContentsOption_CH_Tendency == false then
            Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD", "getName", targetName))
          else
            Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD_CH", "getName", targetName))
          end
        end
      end
    else
      nowTarget[actorKey] = 0
      if ToClient_isDontPvPDecreaseTendency() == false and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == false then
        if _ContentsOption_CH_Tendency == nil or _ContentsOption_CH_Tendency == false then
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD", "getName", targetName))
        else
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECENTTARGETINFO_CHARACTERTOD_CH", "getName", targetName))
        end
      end
    end
  end
end
function updateTargetInfoCheckTime(fDeltatime)
  elapsedTime = elapsedTime + fDeltatime
  if elapsedTime > 20 then
    elapsedTime = 0
    monsterList = {}
    Panel_Monster_Bar:SetShow(false, false)
    clearTargetActor()
    PaGlobalFunc_MainStatusInfo_DangerAlertShow(false)
  end
end
function FGlobal_Panel_Monster_Bar_RePos()
  if Panel_LocalWar:GetShow() then
    Panel_Monster_Bar:SetPosY(Panel_LocalWar:GetPosY() + Panel_LocalWar:GetSizeY() - 5)
    blackBg:SetShow(false)
  else
    Panel_Monster_Bar:SetPosY(5)
    blackBg:SetShow(true)
  end
end
function hideRecentTargetInfo()
  monsterList = {}
  Panel_Monster_Bar:SetShow(false, false)
  PaGlobalFunc_MainStatusInfo_DangerAlertShow(false)
end
function GameOption_NearMonsterAlertOff()
  ToClient_SetMessageFilter(10, true)
end
registerEvent("EvnetLeaveInstanceDungeon", "hideRecentTargetInfo")
registerEvent("update_Monster_Info_Req", "panel_Update_Monster_Info")
registerEvent("stunChanged", "Panel_MonsterInfo_UpdateStun")
Panel_Monster_Bar:RegisterUpdateFunc("updateTargetInfoCheckTime")
