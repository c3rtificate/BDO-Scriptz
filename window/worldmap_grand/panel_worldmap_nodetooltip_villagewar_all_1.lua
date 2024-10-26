function PaGlobal_WorldMapNodeTooltip_VillageWar:initialize()
  if true == PaGlobal_WorldMapNodeTooltip_VillageWar._initialize then
    return
  end
  self._ui._txt_gradeTop = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "StaticText_NeedCP")
  self._ui._txt_nodeName = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "StaticText_NodeName")
  self._ui._txt_nodeName:SetTextMode(__eTextMode_LimitText)
  local nodeBG = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_NodeBG")
  self._ui._stc_guildMarkBG = UI.getChildControl(nodeBG, "Static_GuildMarkBG")
  self._ui._stc_guildMark = UI.getChildControl(nodeBG, "Static_GuildMark")
  self._ui._txt_guildName = UI.getChildControl(nodeBG, "StaticText_GuildName")
  self._ui._txt_guildMaster = UI.getChildControl(nodeBG, "StaticText_GuildMaster")
  self._ui._txt_victoryDay = UI.getChildControl(nodeBG, "StaticText_VictoryDay")
  self._ui._txt_nodeState = UI.getChildControl(nodeBG, "StaticText_NodeState")
  self._ui._txt_tentCountBeingSiege = UI.getChildControl(nodeBG, "StaticText_SiegeTentCount_ING")
  self._ui._txt_tentCount = UI.getChildControl(nodeBG, "StaticTex_SiegeTentCount")
  self._ui._stc_line = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_Line1")
  local warInfo = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_WarInfo")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_MainBg")
  self._ui._txt_grade = UI.getChildControl(warInfo, "StaticText_Title")
  self._ui._txt_memberLimit = UI.getChildControl(warInfo, "StaticText_TaxGrade")
  self._ui._txt_adLimit = UI.getChildControl(warInfo, "StaticText_ADLimit")
  self._ui._txt_mercenaryLimit = UI.getChildControl(warInfo, "StaticText_MercenaryLimit")
  self._ui._txt_mercenaryLimit:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_guildWarDay = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "StaticText__GuildWarDay")
  local allianceInfo = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_Alli_Info")
  self._ui._stc_allianceInfo = allianceInfo
  local allianceInfoBG = UI.getChildControl(allianceInfo, "Static_Black_BG")
  self._ui._stc_allianceInfoBG = allianceInfoBG
  self._ui._stc_allianceLeader = UI.getChildControl(allianceInfoBG, "Static_GuildInfo_Leader")
  self._ui._stc_guildTemplate = UI.getChildControl(allianceInfoBG, "Static_GuildInfo_Normal")
  for ii = 1, self._MAX_MEMBER_COUNT do
    self._ui._stc_guildList[ii] = UI.cloneControl(self._ui._stc_guildTemplate, allianceInfoBG, "Static_GuildInfo_Normal_" .. ii)
    self._ui._stc_guildList[ii]:SetSpanSize(0, 50 * ii)
  end
  self._ui._stc_siegeLimitBg = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_StatLimit")
  local limitStatBG = UI.getChildControl(self._ui._stc_siegeLimitBg, "Static_Black_BG")
  self._ui._stc_siegeLimitBlackBg = limitStatBG
  self._ui._txt_adLimitNew = UI.getChildControl(limitStatBG, "StaticText_Att_Title")
  self._ui._txt_myAD = UI.getChildControl(limitStatBG, "StaticText_Att_Mystat")
  self._ui._txt_myADToHuman = UI.getChildControl(limitStatBG, "StaticText_Human_Attack")
  self._ui._txt_dvLimitNew = UI.getChildControl(limitStatBG, "StaticText_HDV_Title")
  self._ui._txt_myDV = UI.getChildControl(limitStatBG, "StaticText_HDV_Mystat")
  self._ui._txt_dvRateLimitNew = UI.getChildControl(limitStatBG, "StaticText_HDV_Title_1")
  self._ui._txt_myDVRate = UI.getChildControl(limitStatBG, "StaticText_HDV_1_Mystat")
  self._ui._txt_pvLimitNew = UI.getChildControl(limitStatBG, "StaticText_HPV_Title")
  self._ui._txt_myPV = UI.getChildControl(limitStatBG, "StaticText_HPV_Mystat")
  self._ui._txt_pvpLimitNew = UI.getChildControl(limitStatBG, "StaticText_HPVP_Title")
  self._ui._txt_myPVPStat = UI.getChildControl(limitStatBG, "StaticText_HPVP_Mystat")
  self._ui._txt_hitLimitNew = UI.getChildControl(limitStatBG, "StaticText_Hit_Title")
  self._ui._txt_myHitStat = UI.getChildControl(limitStatBG, "StaticText_Hit_Mystat")
  self._ui._txt_hitRateLimitNew = UI.getChildControl(limitStatBG, "StaticText_Hit_1_Title")
  self._ui._txt_hitRateStat = UI.getChildControl(limitStatBG, "StaticText_Hit_1_Mystat")
  self._ui._txt_resistLimitNew = UI.getChildControl(limitStatBG, "StaticText_Reg_Title")
  self._ui._txt_myResistStat = UI.getChildControl(limitStatBG, "StaticText_Reg_Mystat")
  self._ui._txt_maxHPLimit = UI.getChildControl(limitStatBG, "StaticText_Reg_Special")
  self._ui._txt_myMaxHP = UI.getChildControl(limitStatBG, "StaticText_Reg_Special_Mystat")
  self._ui._stc_benefit = UI.getChildControl(Panel_Worldmap_NodeTooltip_VillageWar_All, "Static_SiegeBenefit")
  self._ui._stc_benefitline = UI.getChildControl(self._ui._stc_benefit, "Static_Line")
  self._ui._txt_benefitTitle = UI.getChildControl(self._ui._stc_benefit, "StaticText_Title")
  self._ui._txt_benefitDesc = UI.getChildControl(self._ui._stc_benefit, "StaticText_Desc")
  self._ui._txt_siegeLimitDesc = UI.getChildControl(limitStatBG, "StaticText_Desc")
  self._ui._stc_guildTemplate:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._adLimitNewBasePos = self._ui._txt_adLimitNew:GetPosY()
  self._myADBasePos = self._ui._txt_myAD:GetPosY()
  self._myADToHumanBasePos = self._ui._txt_myADToHuman:GetPosY()
  self._dvLimitNewBasePos = self._ui._txt_dvLimitNew:GetPosY()
  self._myDVBasePos = self._ui._txt_myDV:GetPosY()
  self._dvRateLimitNewBasePos = self._ui._txt_dvRateLimitNew:GetPosY()
  self._myDVRateBasePos = self._ui._txt_myDVRate:GetPosY()
  self._pvLimitNewBasePos = self._ui._txt_pvLimitNew:GetPosY()
  self._myPVBasePos = self._ui._txt_myPV:GetPosY()
  self._pvpLimitNewBasePos = self._ui._txt_pvpLimitNew:GetPosY()
  self._myPVPStatBasePos = self._ui._txt_myPVPStat:GetPosY()
  self._hitLimitNewBasePos = self._ui._txt_hitLimitNew:GetPosY()
  self._myHitStatBasePos = self._ui._txt_myHitStat:GetPosY()
  self._hitRateLimitNewBasePos = self._ui._txt_hitRateLimitNew:GetPosY()
  self._hitRateStatBasePos = self._ui._txt_hitRateStat:GetPosY()
  self._resistLimitNewBasePos = self._ui._txt_resistLimitNew:GetPosY()
  self._myResistStatBasePos = self._ui._txt_myResistStat:GetPosY()
  self._limitMaxHPPos = self._ui._txt_maxHPLimit:GetPosY()
  self._myMaxHPPos = self._ui._txt_myMaxHP:GetPosY()
  self._siegeLimitDescBasePos = self._ui._txt_siegeLimitDesc:GetPosY()
  self._defaultBGSizeY = self._ui._stc_siegeLimitBg:GetSizeY()
  self._defaultBlackBGSizeY = self._ui._stc_siegeLimitBlackBg:GetSizeY()
  self._defaultDescSpanSizeY = self._ui._txt_siegeLimitDesc:GetSpanSize().y
  self._defaultMyPvSizeY = self._ui._txt_myPV:GetSizeY()
  self._defaultMyPvPSizeY = self._ui._txt_myPVPStat:GetSizeY()
  self._defaultLineSpanSizeY = self._ui._stc_line:GetSpanSize().y
  self._defaultGradeTextSpanSizeY = self._ui._txt_grade:GetSpanSize().y
  self._defaultMemberCountTextSpanSizeY = self._ui._txt_memberLimit:GetSpanSize().y
  self._defaultDayTextSpanSizeY = self._ui._txt_guildWarDay:GetSpanSize().y
  self._defaultMainBGSizeY = self._ui._stc_mainBG:GetSizeY()
  self._defaultPanelSizeY = Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeY()
  self._defaultLimitPanelPosY = self._ui._stc_siegeLimitBg:GetPosY()
  self._ui._txt_adLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myAD:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myADToHuman:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_dvLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myDV:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_dvRateLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myDVRate:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_pvLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myPV:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_pvpLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myPVPStat:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_hitLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myHitStat:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_hitRateLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_hitRateStat:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_resistLimitNew:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myResistStat:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_maxHPLimit:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_myMaxHP:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_benefitDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_adLimit:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_guildWarDay:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_siegeLimitDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_siegeLimitDesc:SetText(self._ui._txt_siegeLimitDesc:GetText())
  self._defaultAllianceInfoPosX = allianceInfo:GetPosX()
  self._defaultMercenaryLimitY = self._ui._txt_mercenaryLimit:GetSpanSize().y
  self._defaultPvpTitlePosY = self._ui._txt_pvpLimitNew:GetPosY()
  self._defaultmyPvpValuePosY = self._ui._txt_myPVPStat:GetPosY()
  self._ui._stc_siegeLimitBg:SetShow(false)
  if true == _ContentsGroup_NewCharacterStatInfo then
    self._defaultMercenaryLimitY = self._defaultMercenaryLimitY + 15
  end
  self._initialize = true
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:registEventHandler()
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:prepareOpen(nodeBtn, isConsole)
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  local nodeInfo = nodeBtn:FromClient_getExplorationNodeInClient()
  local nodeX = nodeBtn:GetPosX()
  local nodeY = nodeBtn:GetPosY()
  local sizeX = nodeBtn:GetSizeX()
  local posX = nodeX + sizeX + 10
  if true == isConsole then
    posX = 20
    nodeY = getScreenSizeY() / 2 - Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeY() / 2
  end
  Panel_Worldmap_NodeTooltip_VillageWar_All:SetPosX(posX)
  Panel_Worldmap_NodeTooltip_VillageWar_All:SetPosY(nodeY)
  self._ui._txt_nodeName:SetText(ToClient_getNodeName(nodeInfo))
  local siegeNode = nodeBtn:FromClient_getExplorationNodeInClient():getStaticStatus():getMinorSiegeRegion()
  local siegeTerritoryOptionWrapper
  if _ContentsGroup_Siege2024 == true and siegeNode ~= nil then
    siegeTerritoryOptionWrapper = ToClient_GetSiegeTerritoryOptionStaticStatusWrapperByRegionKey(siegeNode._regionKey:get())
  end
  self._ui._txt_adLimit:SetShow(false)
  self._ui._stc_siegeLimitBg:SetShow(false)
  self._ui._txt_tentCount:SetTextMode(__eTextMode_AutoWrap)
  if nil ~= siegeNode then
    local taxGrade = siegeNode:getVillageTaxLevel()
    local tempString = "LUA_NODEGRADE_"
    tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxGrade + 1))
    if true == _ContentsGroup_NewCharacterStatInfo then
      local regionKey = siegeNode._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      if 0 == taxGrade then
        local grade = regionWrapper:getSiegeOptionTypeByRegion()
        tempString = "LUA_NODEGRADE_"
        tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(grade))
      end
      self._ui._stc_siegeLimitBg:SetShow(true)
      local noExistString = PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TXT_FILTER_0")
      local maxDD = ToClient_getLimitSiegeDDByRegionKey(siegeNode._regionKey:get())
      local maxPV = ToClient_getLimitSiegePVByRegionKey(siegeNode._regionKey:get())
      local maxDV = ToClient_getLimitSiegeDVByRegionKey(siegeNode._regionKey:get())
      local maxDVRate = ToClient_getLimitSiegeDVRateByRegionKey(siegeNode._regionKey:get())
      PaGlobal_Window_Stat_All_NotCheck_Update()
      local myDD = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DD)
      local myADD = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_ADD)
      local myAttackToHuman = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_Tribe, 0)
      myDD = myDD + myAttackToHuman
      myADD = myADD + myAttackToHuman
      local myDDstr = GetLimitFontColor(maxDD, myDD)
      local myADDstr = GetLimitFontColor(maxDD, myADD)
      self._ui._txt_adLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_ATT", "attack", makeDotString(maxDD, 0, 1)))
      self._ui._txt_myAD:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_ATT_MYSTAT", "attackstat", tostring(myDDstr .. "/" .. myADDstr)))
      self._ui._txt_myADToHuman:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_ADDITIONAL_MYSTAT", "attack", tostring(myAttackToHuman)))
      local myDDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DDV)
      local myRDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RDV)
      local myMDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MDV)
      local myDDVstr = GetLimitFontColor(maxDV, myDDV)
      local myRDVstr = GetLimitFontColor(maxDV, myRDV)
      local myMDVstr = GetLimitFontColor(maxDV, myMDV)
      self._ui._txt_dvLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV", "evade", makeDotString(maxDV, 0, 1)))
      self._ui._txt_myDV:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_MYSTAT", "Pevade", tostring(myDDVstr), "Revade", tostring(myRDVstr), "Mevade", tostring(myMDVstr)))
      local myDDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DDV_RATE)
      local myRDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RDV_RATE)
      local myMDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MDV_RATE)
      local myDDVRateStr = GetRateLimitFontColor(maxDVRate, myDDVRate)
      local myRDVRateStr = GetRateLimitFontColor(maxDVRate, myRDVRate)
      local myMDVRateStr = GetRateLimitFontColor(maxDVRate, myMDVRate)
      if maxDVRate < CppDefine.e100Percent then
        self._ui._txt_dvRateLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_1", "evade1", tostring(PaGlobal_Window_Stat_All:getRateText(maxDVRate) .. "%")))
      else
        self._ui._txt_dvRateLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_1", "evade1", noExistString))
      end
      self._ui._txt_myDVRate:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_1_MYSTAT", "Pevade1", tostring(myDDVRateStr), "Revade1", tostring(myRDVRateStr), "Mevade1", tostring(myMDVRateStr)))
      local myDPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DPV)
      local myRPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RPV)
      local myMPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MPV)
      local myDPVstr = GetLimitFontColor(maxPV, myDPV)
      local myRPVstr = GetLimitFontColor(maxPV, myRPV)
      local myMPVstr = GetLimitFontColor(maxPV, myMPV)
      self._ui._txt_pvLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HPV", "reduce", makeDotString(maxPV, 0, 1)))
      self._ui._txt_myPV:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HPV_MYSTAT", "Preduce", tostring(myDPVstr), "Rreduce", tostring(myRPVstr), "Mreduce", tostring(myMPVstr)))
      local maxDamageReduce = regionWrapper:getMinorSiegeDamageReduction()
      local myDamageReduce = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_REDUCE)
      local myDamageReduceString = GetRateLimitFontColor(maxDamageReduce, myDamageReduce)
      if 0 ~= maxDamageReduce then
        maxDamageReduce = maxDamageReduce / 10000
      end
      if maxDamageReduce < 100 then
        self._ui._txt_pvpLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_DAMAGE_REDUCE", "reduction", tostring(maxDamageReduce)) .. "%")
      else
        self._ui._txt_pvpLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_DAMAGE_REDUCE", "reduction", noExistString))
      end
      self._ui._txt_myPVPStat:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_DAMAGE_REDUCE_MYSTAT", "reduction", myDamageReduceString))
      local limitHit = ToClient_getLimitSiegeHitByRegionKey(siegeNode._regionKey:get())
      local limitHitRate = ToClient_getLimitSiegeHitRateByRegionKey(siegeNode._regionKey:get())
      local limitResist = ToClient_getLimitSiegeStunResistByRegionKey(siegeNode._regionKey:get())
      local myHit = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_HIT)
      local myHitRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_HIT_RATE)
      local myStunResist = PaGlobal_CharInfoBasic_All._selfPlayer:getStunResistance()
      local myCatchResist = PaGlobal_CharInfoBasic_All._selfPlayer:getCatchResistance()
      local myKnockdownResist = PaGlobal_CharInfoBasic_All._selfPlayer:getKnockdownResistance()
      local myKnockbackResist = PaGlobal_CharInfoBasic_All._selfPlayer:getKnockbackResistance()
      local myHitStr = GetLimitFontColor(limitHit, myHit)
      local myHitRateStr = GetRateLimitFontColor(limitHitRate, myHitRate)
      local myStunResistStr = GetRateLimitFontColor(limitResist, myStunResist)
      local myCatchResistStr = GetRateLimitFontColor(limitResist, myCatchResist)
      local myKnockdownResistStr = GetRateLimitFontColor(limitResist, myKnockdownResist)
      local myKnockbackResistStr = GetRateLimitFontColor(limitResist, myKnockbackResist)
      if limitHit <= 0 then
        self._ui._txt_hitLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT", "hit", makeDotString(limitHit, 0, 1)))
        myHitStr = GetLimitFontColor(0, myHit)
      elseif limitHit >= 10000 then
        self._ui._txt_hitLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT", "hit", noExistString))
        myHitStr = GetLimitFontColor(0, myHit)
      else
        self._ui._txt_hitLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT", "hit", tostring(limitHit)))
      end
      if limitHitRate <= 0 then
        self._ui._txt_hitRateLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1", "hit1", PaGlobal_Window_Stat_All:getRateText(limitHitRate)) .. "%")
        myHitRateStr = GetRateLimitFontColor(0, myHitRate)
      elseif limitHitRate >= CppDefine.e100Percent then
        self._ui._txt_hitRateLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1", "hit1", noExistString))
        myHitRateStr = GetRateLimitFontColor(0, myHitRate)
      else
        self._ui._txt_hitRateLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1", "hit1", PaGlobal_Window_Stat_All:getRateText(limitHitRate)) .. "%")
      end
      if limitResist <= 0 then
        self._ui._txt_resistLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG", "stun", PaGlobal_Window_Stat_All:getRateText(limitResist)) .. "%")
        myStunResistStr = GetRateLimitFontColor(0, myStunResist)
        myCatchResistStr = GetRateLimitFontColor(0, myCatchResist)
        myKnockdownResistStr = GetRateLimitFontColor(0, myKnockdownResist)
        myKnockbackResistStr = GetRateLimitFontColor(0, myKnockbackResist)
      elseif limitResist >= CppDefine.e100Percent then
        self._ui._txt_resistLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG", "stun", noExistString))
        myStunResistStr = GetRateLimitFontColor(0, myStunResist)
        myCatchResistStr = GetRateLimitFontColor(0, myCatchResist)
        myKnockdownResistStr = GetRateLimitFontColor(0, myKnockdownResist)
        myKnockbackResistStr = GetRateLimitFontColor(0, myKnockbackResist)
      else
        self._ui._txt_resistLimitNew:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG", "stun", PaGlobal_Window_Stat_All:getRateText(limitResist)) .. "%")
      end
      self._ui._txt_myHitStat:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_MYSTAT", "hit", myHitStr))
      self._ui._txt_hitRateStat:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1_MYSTAT", "hit1", myHitRateStr))
      self._ui._txt_myResistStat:SetText(PAGetStringParam4(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG_MYSTAT", "stun", myStunResistStr, "grab", myCatchResistStr, "down", myKnockdownResistStr, "air", myKnockbackResistStr))
      local limitMaxHP = ToClient_getLimitSiegeMaxHP(siegeNode._regionKey:get())
      local myMaxHP = 0
      local selfPlayer = getSelfPlayer():get()
      if selfPlayer ~= nil then
        myMaxHP = selfPlayer:getMaxHp()
      end
      if limitMaxHP >= 1000000 then
        self._ui._txt_maxHPLimit:SetText(noExistString)
      else
        self._ui._txt_maxHPLimit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HP", "HP", makeDotString(limitMaxHP, 0, 1)))
      end
      self._ui._txt_myMaxHP:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HP_MYSTAT", "HP", GetLimitFontColor(limitMaxHP, myMaxHP)))
      self._ui._txt_siegeLimitDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_NODETOOLTIP_STATLIMIT_DESC"))
      local wrapCount = 0
      local padding = 20
      local descPadding = 0
      if self._defaultTextSizeY < self._ui._txt_adLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myAD:SetPosY(self._myADBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myAD:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myADToHuman:SetPosY(self._myADToHumanBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myADToHuman:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_dvLimitNew:SetPosY(self._dvLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_dvLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myDV:SetPosY(self._myDVBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myDV:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_dvRateLimitNew:SetPosY(self._dvRateLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_dvRateLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myDVRate:SetPosY(self._myDVRateBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myDVRate:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_pvLimitNew:SetPosY(self._pvLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_pvLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myPV:SetPosY(self._myPVBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myPV:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_pvpLimitNew:SetPosY(self._pvpLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_pvpLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myPVPStat:SetPosY(self._myPVPStatBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myPVPStat:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_hitLimitNew:SetPosY(self._hitLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_hitLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myHitStat:SetPosY(self._myHitStatBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myHitStat:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_hitRateLimitNew:SetPosY(self._hitRateLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_hitRateLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_hitRateStat:SetPosY(self._hitRateStatBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_hitRateStat:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_resistLimitNew:SetPosY(self._resistLimitNewBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_resistLimitNew:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myResistStat:SetPosY(self._myResistStatBasePos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myResistStat:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_siegeLimitDesc:SetPosY(self._siegeLimitDescBasePos + wrapCount * padding)
      self._ui._txt_maxHPLimit:SetPosY(self._limitMaxHPPos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_maxHPLimit:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_myMaxHP:SetPosY(self._myMaxHPPos + wrapCount * padding)
      if self._defaultTextSizeY < self._ui._txt_myMaxHP:GetTextSizeY() then
        wrapCount = wrapCount + 1
      end
      self._ui._txt_siegeLimitDesc:SetPosY(self._siegeLimitDescBasePos + wrapCount * padding)
      local descEndY = self._ui._txt_siegeLimitDesc:GetPosY() + self._ui._txt_siegeLimitDesc:GetTextSizeY() + 60
      local limitPanelSize = descEndY - self._defaultLimitPanelPosY
      self._ui._stc_siegeLimitBg:SetSize(self._ui._stc_siegeLimitBg:GetSizeX(), limitPanelSize)
      self._ui._stc_siegeLimitBlackBg:SetSize(self._ui._stc_siegeLimitBg:GetSizeX(), limitPanelSize - 50)
      if isConsole == true then
        local limitPanelEndPosY = Panel_Worldmap_NodeTooltip_VillageWar_All:GetPosY() + self._defaultLimitPanelPosY + limitPanelSize
        local diff = limitPanelEndPosY - getScreenSizeY()
        if diff > 0 then
          self._ui._stc_siegeLimitBg:SetPosY(self._defaultLimitPanelPosY - diff - 20)
        end
      end
      if maxDD >= 9999 then
        self._ui._stc_siegeLimitBg:SetShow(false)
      else
        self._ui._stc_siegeLimitBg:SetShow(true)
      end
    elseif 0 == taxGrade then
      local regionKey = siegeNode._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      local grade = regionWrapper:getSiegeOptionTypeByRegion()
      self._ui._txt_adLimit:SetShow(true)
      if 0 == grade then
        self._ui._txt_adLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 210, "defence", 250))
      elseif 1 == grade then
        self._ui._txt_adLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 230, "defence", 270))
      elseif 2 == grade then
        self._ui._txt_adLimit:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_ADLIMIT", "attack", 240, "defence", 300))
      end
    end
    local maxMemberAtSiege = 0
    if siegeTerritoryOptionWrapper ~= nil then
      local day = ToClient_GetDayOfWeekByVillageSiege()
      maxMemberAtSiege = siegeTerritoryOptionWrapper:getLimitMemberCount(day)
    else
      maxMemberAtSiege = siegeNode:getMaxMemberAtSiege()
    end
    if maxMemberAtSiege ~= 0 then
      self._ui._txt_memberLimit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SIEGENODE_MINMAX_PARTICIPANT", "MaxMember", tostring(maxMemberAtSiege)))
    end
    self._ui._txt_grade:SetText(tempString)
    self._ui._txt_gradeTop:SetText(tempString)
    self._ui._txt_grade:SetShow(true)
    self._ui._txt_gradeTop:SetShow(true)
  else
    self._ui._txt_grade:SetShow(false)
    self._ui._txt_gradeTop:SetShow(false)
  end
  if siegeTerritoryOptionWrapper ~= nil then
    local cutDayCount = 4
    local dayCount = siegeTerritoryOptionWrapper:getStartDayListCount()
    if dayCount == 0 then
      self._ui._txt_guildWarDay:SetShow(false)
    else
      local isIncludeDayString = true
      local eraseComma = true
      local resultDayList = Array.new()
      local addedDayString = ""
      if cutDayCount > dayCount then
        isIncludeDayString = true
        for index = 0, dayCount - 1 do
          local day = siegeTerritoryOptionWrapper:getStartDay(index)
          if day ~= __eVillageSiegeType_Count then
            resultDayList:push_back(day)
          end
        end
      else
        isIncludeDayString = false
        for dayIndex = 0, __eVillageSiegeType_Count - 1 do
          resultDayList:push_back(dayIndex)
        end
        for index = 0, dayCount - 1 do
          local day = siegeTerritoryOptionWrapper:getStartDay(index)
          if day ~= __eVillageSiegeType_Count then
            for dayIndex = #resultDayList, 1, -1 do
              if resultDayList[dayIndex] == day then
                table.remove(resultDayList, dayIndex)
                break
              end
            end
          end
        end
      end
      for key, dayValue in pairs(resultDayList) do
        if dayValue ~= nil then
          local dayString = self._dayStringList[dayValue]
          if dayString ~= nil then
            if eraseComma == true then
              eraseComma = false
              addedDayString = addedDayString .. dayString
            else
              addedDayString = addedDayString .. ", " .. dayString
            end
          else
            UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164! VillageSiegeType \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
          end
        end
      end
      local resultDayString = ""
      if isIncludeDayString == true then
        resultDayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", addedDayString)
      else
        resultDayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY_EXCEPT", "day", addedDayString)
      end
      self._ui._txt_guildWarDay:SetShow(true)
      self._ui._txt_guildWarDay:SetText(resultDayString)
      self._ui._txt_guildWarDay:SetSize(self._ui._txt_guildWarDay:GetSizeX(), self._ui._txt_guildWarDay:GetTextSizeY())
      self._ui._txt_guildWarDay:ComputePos()
    end
  else
    local _dayString = ""
    local villageSiegeType = nodeBtn:getVillageSiegeType()
    if villageSiegeType >= 0 and villageSiegeType < 7 then
      _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", self._dayStringList[villageSiegeType])
      self._ui._txt_guildWarDay:SetText(_dayString)
      self._ui._txt_guildWarDay:SetShow(true)
      self._ui._txt_guildWarDay:ComputePos()
    else
      self._ui._txt_guildWarDay:SetShow(false)
    end
    if nil ~= siegeNode then
      _dayString = ""
      local regionKey = siegeNode._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      if nil ~= regionWrapper then
        local villageSiegeType = regionWrapper:getVillageSiegeType()
        if _ContentsGroup_MinorSiege2022 == true then
          _dayString = self._dayStringList[villageSiegeType]
        else
          local territoryKey = regionWrapper:getTerritoryKeyRaw()
          for i = 0, self._UI_VT.eVillageSiegeType_Count - 1 do
            if true == ToClient_checkSiegeDayByRawKey(territoryKey, i) then
              _dayString = _dayString .. self._dayStringList[i] .. "/"
            end
          end
          if 0 ~= string.len(_dayString) then
            _dayString = string.sub(_dayString, 1, string.len(_dayString) - 1)
          end
        end
      end
      if "" ~= _dayString then
        _dayString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", _dayString)
        self._ui._txt_guildWarDay:SetText(_dayString)
        self._ui._txt_guildWarDay:SetShow(true)
        self._ui._txt_guildWarDay:ComputePos()
      else
        self._ui._txt_guildWarDay:SetShow(false)
      end
    end
  end
  if nil ~= siegeNode then
    local regionKey = siegeNode._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local maxMecenary = 0
    if siegeTerritoryOptionWrapper ~= nil then
      maxMecenary = siegeTerritoryOptionWrapper._limitVolunteerCount
    else
      maxMecenary = regionWrapper:getSiegeGuildVolunteerLimitCount()
    end
    if maxMecenary >= 0 and maxMecenary <= 100 then
      local maxMecenaryString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDMAXMECENARY", "count", maxMecenary)
      self._ui._txt_mercenaryLimit:SetText(maxMecenaryString)
      self._ui._txt_mercenaryLimit:SetShow(_ContentsGroup_BattleFieldVolunteer)
      if true == self._ui._txt_adLimit:GetShow() then
        self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._defaultMercenaryLimitY)
      else
        self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._ui._txt_adLimit:GetSpanSize().y)
      end
    else
      self._ui._txt_mercenaryLimit:SetShow(false)
    end
  end
  local nodeStaticStatus = nodeInfo:getStaticStatus()
  local regionInfo = nodeStaticStatus:getMinorSiegeRegion()
  if nil ~= regionInfo then
    local regionKey = regionInfo._regionKey
    local regionWrapper = getRegionInfoWrapper(regionKey:get())
    local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
    local siegeWrapper = ToClient_GetSiegeWrapperByRegionKey(regionKey:get())
    local siegeTentCount = ToClient_GetCompleteSiegeTentCount(regionKey:get())
    local isShowTentCount = siegeTentCount ~= -1
    if nil ~= minorSiegeWrapper then
      if minorSiegeWrapper:isSiegeBeing() then
        self._ui._stc_allianceInfo:SetShow(false)
        self._ui._stc_guildMarkBG:SetShow(false)
        self._ui._stc_guildMark:SetShow(false)
        self._ui._txt_guildName:SetShow(false)
        self._ui._txt_guildMaster:SetShow(false)
        self._ui._txt_guildMaster:SetText("")
        self._ui._txt_guildName:SetText("")
        self._ui._txt_victoryDay:SetShow(false)
        self._ui._txt_nodeState:SetShow(true)
        self._ui._txt_tentCount:SetShow(false)
        self._ui._txt_nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_ISBEIGN"))
        local minorSiegeDoing = ToClient_doMinorSiegeInTerritory(regionWrapper:getTerritoryKeyRaw())
        if minorSiegeDoing == true and _ContentsGroup_Siege2024 == false then
          self._ui._txt_tentCountBeingSiege:SetShow(true)
        else
          self._ui._txt_tentCountBeingSiege:SetShow(false)
        end
        self._ui._txt_tentCountBeingSiege:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_JOINGUILD", "count", siegeTentCount))
        local addSpanSize = 0
        if true == self._ui._txt_tentCount:GetShow() then
          addSpanSize = math.max(0, self._ui._txt_tentCount:GetTextSizeY() - self._ui._txt_tentCount:GetSizeY() - 10)
        end
        self._ui._stc_line:SetSpanSize(self._ui._stc_line:GetSpanSize().x, self._defaultLineSpanSizeY + addSpanSize)
        self._ui._txt_grade:SetSpanSize(self._ui._txt_grade:GetSpanSize().x, self._defaultGradeTextSpanSizeY + addSpanSize)
        self._ui._txt_memberLimit:SetSpanSize(self._ui._txt_memberLimit:GetSpanSize().x, self._defaultMemberCountTextSpanSizeY + addSpanSize)
        self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._defaultMercenaryLimitY + addSpanSize)
        if true == self._ui._txt_adLimit:GetShow() then
          self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._defaultMercenaryLimitY + addSpanSize)
        else
          self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._ui._txt_adLimit:GetSpanSize().y + addSpanSize)
        end
        self._ui._stc_mainBG:SetSize(self._ui._stc_mainBG:GetSizeX(), self._defaultMainBGSizeY + addSpanSize)
        Panel_Worldmap_NodeTooltip_VillageWar_All:SetSize(Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeX(), self._defaultPanelSizeY + addSpanSize)
        self._ui._txt_guildWarDay:ComputePos()
      else
        self._ui._txt_tentCountBeingSiege:SetShow(false)
        if true == siegeWrapper:doOccupantExist() then
          self._ui._stc_guildMarkBG:SetShow(true)
          self._ui._stc_guildMark:SetShow(true)
          self._ui._txt_guildName:SetShow(true)
          self._ui._stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
          self._ui._stc_guildMark:setRenderTexture(self._ui._stc_guildMark:getBaseTexture())
          self._ui._txt_guildName:SetText(siegeWrapper:getGuildName())
          if 0 == siegeTentCount then
            self._ui._txt_tentCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
          else
            self._ui._txt_tentCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
          end
          if isShowTentCount == false then
            self._ui._txt_tentCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPTOOPTIP_BUILDLOCK"))
          end
          self._ui._txt_tentCount:SetShow(_ContentsGroup_Siege2024 == false)
          local isAlliance = true == _ContentsGroup_guildAlliance and true == siegeWrapper:isOccupantGuildAlliance()
          local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(siegeWrapper:getGuildNo())
          if false == _ContentsOption_CH_NoCustomGuildMark then
            if true == isAlliance and nil ~= guildWrapper then
              self._ui._stc_allianceInfo:SetShow(true)
              self:setGuildAllianceInfo(siegeWrapper:getGuildNo())
              setGuildTextureByAllianceNo(siegeWrapper:getGuildNo(), self._ui._stc_guildMark)
            else
              self._ui._stc_allianceInfo:SetShow(false)
              setGuildTextureByGuildNo(siegeWrapper:getGuildNo(), self._ui._stc_guildMark)
            end
          elseif nil ~= PaGlobalFunc_ConsoleGuildMarkSet then
            PaGlobalFunc_ConsoleGuildMarkSet(siegeWrapper:getGuildNo(), self._ui._stc_guildMark, self._ui._stc_guildMarkBG)
          end
          if true == self._ui._stc_siegeLimitBg:GetShow() then
            self._ui._stc_allianceInfo:SetPosX(self._defaultAllianceInfoPosX + self._ui._stc_siegeLimitBg:GetSizeX() + 5)
          else
            self._ui._stc_allianceInfo:SetPosX(self._defaultAllianceInfoPosX)
          end
          self._ui._txt_nodeState:SetShow(false)
          self._ui._txt_guildMaster:SetShow(true)
          self._ui._txt_guildMaster:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_GUILDMASTER", "name", siegeWrapper:getGuildMasterName()))
          self._ui._txt_victoryDay:SetShow(true)
          local paDate = siegeWrapper:getOccupyingDate()
          local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(paDate:GetYear()))
          local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(paDate:GetMonth()))
          local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(paDate:GetDay()))
          local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(paDate:GetHour()))
          local d_date = year .. month .. day .. hour
          self._ui._txt_victoryDay:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_OCCUPYINGDATE", "date", d_date))
        else
          if 0 == siegeTentCount then
            self._ui._txt_tentCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_NO"))
          else
            self._ui._txt_tentCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOLTIP_JOINNODEWAR_COUNT", "siegeTentCount", siegeTentCount))
          end
          if isShowTentCount == false then
            self._ui._txt_tentCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPTOOPTIP_BUILDLOCK"))
          end
          self._ui._txt_tentCount:SetShow(_ContentsGroup_Siege2024 == false)
          self._ui._stc_allianceInfo:SetShow(false)
          self._ui._stc_guildMarkBG:SetShow(false)
          self._ui._stc_guildMark:SetShow(false)
          self._ui._txt_guildName:SetShow(false)
          self._ui._txt_guildMaster:SetShow(false)
          self._ui._txt_victoryDay:SetShow(false)
          self._ui._txt_guildName:SetText("")
          self._ui._txt_guildMaster:SetText("")
          self._ui._txt_victoryDay:SetText("")
          self._ui._txt_nodeState:SetShow(true)
          self._ui._txt_nodeState:SetTextMode(__eTextMode_AutoWrap)
          self._ui._txt_nodeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODE_MINUSIEGETOOLTIP_NOTYETOCCUPY"))
        end
        local addSpanSize = 0
        if true == self._ui._txt_tentCount:GetShow() then
          addSpanSize = math.max(0, self._ui._txt_tentCount:GetTextSizeY() - self._ui._txt_tentCount:GetSizeY() - 10)
        end
        self._ui._stc_line:SetSpanSize(self._ui._stc_line:GetSpanSize().x, self._defaultLineSpanSizeY + addSpanSize)
        self._ui._txt_grade:SetSpanSize(self._ui._txt_grade:GetSpanSize().x, self._defaultGradeTextSpanSizeY + addSpanSize)
        self._ui._txt_memberLimit:SetSpanSize(self._ui._txt_memberLimit:GetSpanSize().x, self._defaultMemberCountTextSpanSizeY + addSpanSize)
        self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._defaultMercenaryLimitY + addSpanSize)
        if true == self._ui._txt_adLimit:GetShow() then
          self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._defaultMercenaryLimitY + addSpanSize)
        else
          self._ui._txt_mercenaryLimit:SetSpanSize(self._ui._txt_mercenaryLimit:GetSpanSize().x, self._ui._txt_adLimit:GetSpanSize().y + addSpanSize)
        end
        self._ui._stc_mainBG:SetSize(self._ui._stc_mainBG:GetSizeX(), self._defaultMainBGSizeY + addSpanSize)
        Panel_Worldmap_NodeTooltip_VillageWar_All:SetSize(Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeX(), self._defaultPanelSizeY + addSpanSize)
        self._ui._txt_guildWarDay:ComputePos()
      end
    else
      self._ui._stc_guildMarkBG:SetShow(false)
      self._ui._stc_guildMark:SetShow(false)
      self._ui._txt_guildName:SetShow(false)
      self._ui._txt_guildMaster:SetShow(false)
      self._ui._txt_victoryDay:SetShow(false)
      self._ui._txt_guildName:SetText("")
      self._ui._txt_guildMaster:SetText("")
      self._ui._txt_victoryDay:SetText("")
      self._ui._txt_nodeState:SetShow(true)
    end
  end
  local count = ToClient_getBettleGroundCountBySiegeRegionKey(siegeNode._regionKey:get())
  local waypointKey = -1
  local huntingGroundSS
  local huntingGroundString = ""
  for index = 0, count - 1 do
    waypointKey = ToClient_getBettleGroundKeyByIndex(siegeNode._regionKey:get(), index)
    if waypointKey ~= -1 then
      huntingGroundSS = ToClient_getDropUIHuntingGroundStaticStatusWrapper(waypointKey)
      if huntingGroundSS ~= nil then
        huntingGroundString = huntingGroundString .. huntingGroundSS:getName()
        if index ~= count - 1 then
          huntingGroundString = huntingGroundString .. ","
        end
      end
    end
  end
  if huntingGroundString ~= "" then
    huntingGroundString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_SIEGEBENEFIT", "base", self._ui._txt_nodeName:GetText(), "region", huntingGroundString)
    self._ui._txt_benefitDesc:SetText(huntingGroundString)
    self._ui._stc_benefit:SetShow(true)
  else
    self._ui._stc_benefit:SetShow(false)
  end
  if self._ui._stc_benefit:GetShow() == true then
    local benefitSize = self._ui._stc_benefitline:GetSizeY() + self._ui._txt_benefitTitle:GetTextSizeY() + self._ui._txt_benefitDesc:GetTextSizeY()
    self._ui._stc_benefit:SetPosY(self._ui._txt_guildWarDay:GetPosY() + self._ui._txt_guildWarDay:GetSizeY() + 10)
    self._ui._stc_mainBG:SetSize(self._ui._stc_mainBG:GetSizeX(), self._ui._stc_mainBG:GetSizeY() + benefitSize + 15)
    Panel_Worldmap_NodeTooltip_VillageWar_All:SetSize(Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeX(), Panel_Worldmap_NodeTooltip_VillageWar_All:GetSizeY() + benefitSize + 15)
  end
  PaGlobal_WorldMapNodeTooltip_VillageWar:open()
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:open()
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  Panel_Worldmap_NodeTooltip_VillageWar_All:SetShow(true)
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:prepareClose()
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  self._ui._stc_siegeLimitBg:SetShow(false)
  PaGlobal_WorldMapNodeTooltip_VillageWar:close()
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:close()
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  Panel_Worldmap_NodeTooltip_VillageWar_All:SetShow(false)
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:validate()
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  self._ui._txt_gradeTop:isValidate()
  self._ui._txt_nodeName:isValidate()
  self._ui._stc_guildMarkBG:isValidate()
  self._ui._stc_guildMark:isValidate()
  self._ui._txt_guildName:isValidate()
  self._ui._txt_guildMaster:isValidate()
  self._ui._txt_victoryDay:isValidate()
  self._ui._txt_nodeState:isValidate()
  self._ui._txt_tentCount:isValidate()
  self._ui._txt_tentCountBeingSiege:isValidate()
  self._ui._txt_grade:isValidate()
  self._ui._txt_memberLimit:isValidate()
  self._ui._txt_adLimit:isValidate()
  self._ui._txt_mercenaryLimit:isValidate()
  self._ui._txt_guildWarDay:isValidate()
  self._ui._stc_allianceInfo:isValidate()
  self._ui._stc_allianceLeader:isValidate()
  self._ui._stc_guildTemplate:isValidate()
  self._ui._stc_allianceInfoBG:isValidate()
  self._ui._stc_siegeLimitBlackBg:isValidate()
  for ii = 1, self._MAX_MEMBER_COUNT do
    self._ui._stc_guildList[ii]:isValidate()
  end
  self._ui._stc_siegeLimitBg:isValidate()
  self._ui._txt_adLimitNew:isValidate()
  self._ui._txt_myAD:isValidate()
  self._ui._txt_myADToHuman:isValidate()
  self._ui._txt_dvLimitNew:isValidate()
  self._ui._txt_myDV:isValidate()
  self._ui._txt_pvLimitNew:isValidate()
  self._ui._txt_dvRateLimitNew:isValidate()
  self._ui._txt_myDVRate:isValidate()
  self._ui._txt_myPV:isValidate()
  self._ui._txt_siegeLimitDesc:isValidate()
  self._ui._txt_hitLimitNew:isValidate()
  self._ui._txt_myHitStat:isValidate()
  self._ui._txt_hitRateLimitNew:isValidate()
  self._ui._txt_hitRateStat:isValidate()
  self._ui._txt_resistLimitNew:isValidate()
  self._ui._txt_myResistStat:isValidate()
end
function PaGlobal_WorldMapNodeTooltip_VillageWar:setGuildAllianceInfo(allianceNo)
  if nil == Panel_Worldmap_NodeTooltip_VillageWar_All then
    return
  end
  local name, mark, leaderName
  name = UI.getChildControl(self._ui._stc_allianceLeader, "StaticText_AliiName_LeaderGuild")
  mark = UI.getChildControl(self._ui._stc_allianceLeader, "Static_GuildIcon")
  leaderName = UI.getChildControl(self._ui._stc_allianceLeader, "StaticText_LeaderName")
  local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(allianceNo)
  if nil ~= guildWrapper then
    if nil ~= name then
      name:SetText(guildWrapper:getName())
    end
    if nil ~= leaderName then
      leaderName:SetText(guildWrapper:getGuildMasterName())
    end
    if nil ~= mark then
      mark:getBaseTexture():setUV(0, 0, 1, 1)
      mark:setRenderTexture(mark:getBaseTexture())
      setGuildTextureByGuildNo(allianceNo, mark)
    end
  end
  local guildAlliance = ToClient_GetGuildAllianceWrapperbyNo(allianceNo)
  local memberCount = 0
  for ii = 1, self._MAX_MEMBER_COUNT do
    self._ui._stc_guildList[ii]:SetShow(false)
  end
  if nil ~= guildAlliance then
    local guildInfoIndex = 1
    for index = 0, guildAlliance:getMemberCount() - 1 do
      guildWrapper = guildAlliance:getMemberGuild(index)
      if nil ~= guildWrapper and guildWrapper:getGuildNo_s64() ~= allianceNo and nil ~= self._ui._stc_guildList[guildInfoIndex] then
        name = UI.getChildControl(self._ui._stc_guildList[guildInfoIndex], "StaticText_AliiName_NormalGuild")
        mark = UI.getChildControl(self._ui._stc_guildList[guildInfoIndex], "Static_GuildIcon")
        leaderName = UI.getChildControl(self._ui._stc_guildList[guildInfoIndex], "StaticText_LeaderName")
        if nil ~= name then
          name:SetText(guildWrapper:getName())
        end
        if nil ~= leaderName then
          leaderName:SetText(guildWrapper:getGuildMasterName())
        end
        if nil ~= mark then
          mark:getBaseTexture():setUV(0, 0, 1, 1)
          mark:setRenderTexture(mark:getBaseTexture())
          setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), mark)
        end
        self._ui._stc_guildList[guildInfoIndex]:SetShow(true)
        guildInfoIndex = guildInfoIndex + 1
      end
    end
    local sizeY = self._ui._stc_guildTemplate:GetSizeY() * guildInfoIndex + 20
    self._ui._stc_allianceInfo:SetSize(self._ui._stc_allianceInfo:GetSizeX(), sizeY + 50)
    self._ui._stc_allianceInfoBG:SetSize(self._ui._stc_allianceInfoBG:GetSizeX(), sizeY)
  end
end
function GetLimitFontColor(max, current)
  if max <= current then
    return "<PAColor0xff6cf000>" .. makeDotString(current, 0, 1) .. "<PAOldColor>"
  else
    return "<PAColor0xffd05d48>" .. makeDotString(current, 0, 1) .. "<PAOldColor>"
  end
end
function GetRateLimitFontColor(max, current)
  if max <= current or max >= CppDefine.e100Percent then
    return "<PAColor0xff6cf000>" .. tostring(PaGlobal_Window_Stat_All:getRateText(current)) .. "%" .. "<PAOldColor>"
  else
    return "<PAColor0xffd05d48>" .. tostring(PaGlobal_Window_Stat_All:getRateText(current)) .. "%" .. "<PAOldColor>"
  end
end
