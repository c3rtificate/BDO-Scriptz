CppEnums.SiegeNotifyType = {
  Insert = 0,
  Unbuild = 1,
  Destroy = 2,
  DestroyGate = 3
}
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
Panel_WarInfoMessage:SetShow(false, false)
Panel_WarInfoMessage:RegisterShowEventFunc(true, "WarInfoMessageShowAni()")
Panel_WarInfoMessage:RegisterShowEventFunc(false, "WarInfoMessageHideAni()")
local panel_BG = UI.getChildControl(Panel_WarInfoMessage, "Static_BGTexture")
local panel_MainMessage = UI.getChildControl(Panel_WarInfoMessage, "StaticText_MainMessage")
local panel_SubMessage = UI.getChildControl(Panel_WarInfoMessage, "StaticText_SubMessage")
local panel_Effect = UI.getChildControl(Panel_WarInfoMessage, "Static_Effect")
local onTime = 0
local chanege_BG = function(control, type)
  if 0 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/destroyGuildTent.dds")
  elseif 1 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/addGuildTent.dds")
  elseif 2 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/newTerritoryOwner.dds")
  elseif 3 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/attackGuildTent.dds")
  elseif 4 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/newTerritoryOwner.dds")
  elseif 5 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/startWars.dds")
  elseif 6 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/guildWarStart.dds")
  elseif 7 == type then
    control:ChangeTextureInfoName("New_UI_Common_forLua/Widget/WarInfoMessage/guildWarEnd.dds")
  end
  local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 562, 128)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  return control
end
local warMsgCheckPanel = UI.createPanel("warMsgCheckPanel", Defines.UIGroup.PAGameUIGroup_ModalDialog)
warMsgCheckPanel:SetSize(1, 1)
warMsgCheckPanel:SetIgnore(true)
warMsgCheckPanel:SetHorizonCenter()
warMsgCheckPanel:SetVerticalTop()
local send_WarMsgPool = Array.new()
function send_WarMsgHandle(deltaTime)
  if not Panel_WarInfoMessage:GetShow() then
    local msg = send_WarMsgPool:pop_front()
    if nil == msg then
      warMsgCheckPanel:SetShow(false)
      return
    else
      panel_Effect:EraseAllEffect()
      if 0 == msg[0] then
        panel_Effect:AddEffect("UI_CastleMinusLight", false, 0, 0)
        audioPostEvent_SystemUi(15, 2)
        _AudioPostEvent_SystemUiForXBOX(15, 2)
      elseif 1 == msg[0] then
        panel_Effect:AddEffect("UI_CastlePlusLight", false, 0, 0)
        audioPostEvent_SystemUi(15, 1)
        _AudioPostEvent_SystemUiForXBOX(15, 1)
      elseif 2 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Win", false, -19, 0)
        panel_Effect:AddEffect("fUI_SkillAwakenBoom", false, -19, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif 3 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Alarm", true, -16, -22)
        audioPostEvent_SystemUi(15, 3)
        _AudioPostEvent_SystemUiForXBOX(15, 3)
      elseif 4 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Win", false, -19, 0)
        panel_Effect:AddEffect("fUI_SkillAwakenBoom", false, -19, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif 5 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Win_Green", false, -19, 0)
        panel_Effect:AddEffect("fui_skillawakenboom_green", false, -19, 0)
        audioPostEvent_SystemUi(15, 0)
        _AudioPostEvent_SystemUiForXBOX(15, 0)
      elseif 6 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Win_Red", false, -19, 0)
        panel_Effect:AddEffect("fui_skillawakenboom_red", false, -19, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      elseif 7 == msg[0] then
        panel_Effect:AddEffect("UI_SiegeWarfare_Win_Red", false, -19, 0)
        panel_Effect:AddEffect("fui_skillawakenboom_red", false, -19, 0)
        audioPostEvent_SystemUi(15, 4)
        _AudioPostEvent_SystemUiForXBOX(15, 4)
      end
      chanege_BG(panel_BG, msg[0])
      panel_MainMessage:SetText(msg[1])
      panel_SubMessage:SetText(msg[2])
      Panel_WarInfoMessage:SetShow(true, true)
    end
  end
end
warMsgCheckPanel:RegisterUpdateFunc("send_WarMsgHandle")
function WarInfoMessageShowAni()
  local aniInfo1 = Panel_WarInfoMessage:addScaleAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.8)
  aniInfo1:SetEndScale(1.3)
  aniInfo1.AxisX = Panel_WarInfoMessage:GetSizeX() / 2
  aniInfo1.AxisY = Panel_WarInfoMessage:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_WarInfoMessage:addScaleAnimation(0.05, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.3)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_WarInfoMessage:GetSizeX() / 2
  aniInfo2.AxisY = Panel_WarInfoMessage:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function WarInfoMessageHideAni()
  local aniInfo1 = Panel_WarInfoMessage:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_NotifyOccupySiege(regionKeyRaw, guildName, isAlliance)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  local msg_type = 4
  local msg_Main, areaName
  if regionInfoWrapper:get():isMainTown() then
    areaName = regionInfoWrapper:getTerritoryName()
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPYSIEGE_END_MAIN", "territoryName", areaName)
  else
    areaName = regionInfoWrapper:getVillageSiegeAreaName()
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPY_VILLAGESIEGE_END_MAIN", "territoryName", areaName)
  end
  local msg_Sub = ""
  if true == isAlliance then
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPYSIEGE_ALLIANCE_END_SUB", "territoryName", areaName, "guildName", guildName)
  else
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPYSIEGE_END_SUB", "territoryName", areaName, "guildName", guildName)
  end
  local message = {
    main = msg_Main,
    sub = msg_Sub,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 11)
end
function FromClient_NotifyReleaseSiege(regionKeyRaw, isSystemRelease)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  local areaName
  if regionInfoWrapper:get():isMainTown() then
    areaName = regionInfoWrapper:getTerritoryName()
  else
    areaName = regionInfoWrapper:getVillageSiegeAreaName()
  end
  local msg_type = 2
  local msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPYSIEGE_RELEASE_MAIN", "territoryName", areaName)
  local msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYOCCUPYSIEGE_RELEASE_SUB", "territoryName", areaName)
  if isSystemRelease == true then
    msg_Sub = ""
  end
  local message = {
    main = msg_Main,
    sub = msg_Sub,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 11)
end
function FromClient_NotifyKingOrLordTentChange(notifyType, regionKeyRaw, guildName, guildNamePeer, isMilitia, isAlliance, attackerNickname)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  local areaName, warInfoName
  local isMinorSiege = false
  if regionInfoWrapper:get():isMainTown() then
    areaName = regionInfoWrapper:getTerritoryName()
    warInfoName = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TERRITORYWAR")
    isMinorSiege = false
  else
    areaName = regionInfoWrapper:getVillageSiegeAreaName()
    warInfoName = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_NODEWAR")
    isMinorSiege = true
  end
  local count_CompleteTent = ToClient_GetCompleteSiegeTentCount(regionKeyRaw)
  local msg_type, msg_Main, msg_Sub
  if CppEnums.SiegeNotifyType.Insert == notifyType then
    msg_type = 1
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_INSERT_MAIN", "guildName", guildName)
    msg_Sub = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_INSERT_SUB", "territoryName", areaName, "warInfoName", warInfoName, "count_CompleteTent", count_CompleteTent)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 12)
  elseif CppEnums.SiegeNotifyType.Unbuild == notifyType then
    msg_type = 0
    if false == isMinorSiege then
      msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_UNBUILD_MAIN", "guildName", guildName)
    else
      msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGEWARINFOMESSAGE_NOTIFYTENTCHANGE_UNBUILD_MAIN", "guildName", guildName)
    end
    msg_Sub = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_UNBUILD_SUB", "territoryName", areaName, "warInfoName", warInfoName, "count_CompleteTent", count_CompleteTent)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 13)
  elseif CppEnums.SiegeNotifyType.Destroy == notifyType then
    msg_type = 0
    if true == isMilitia then
      msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_MILITIA", "guildName", guildName)
    elseif true == _ContentsGroup_guildAlliance then
      if nil ~= attackerNickname and "" ~= attackerNickname then
        msg_Main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_DESTROY_MAIN_NEW", "guildNamePeer", guildNamePeer, "famillyName", attackerNickname, "guildName", guildName)
      elseif true == isAlliance then
        msg_Main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_ALLIANCE_MAIN", "guildNamePeer", guildNamePeer, "guildName", guildName)
      else
        msg_Main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_GUILD_MAIN", "guildNamePeer", guildNamePeer, "guildName", guildName)
      end
    else
      msg_Main = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_MAIN", "guildNamePeer", guildNamePeer, "guildName", guildName)
    end
    if 1 == count_CompleteTent then
      msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_ONLYONE_SUB", "territoryName", areaName, "warInfoName", warInfoName)
    else
      msg_Sub = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORY_SUB", "territoryName", areaName, "warInfoName", warInfoName, "count_CompleteTent", count_CompleteTent)
    end
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 13)
  elseif CppEnums.SiegeNotifyType.DestroyGate == notifyType then
    msg_type = 0
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORYGATE_MAIN", "territoryName", areaName)
    msg_Sub = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTORYGATE_SUB", "territoryName", areaName, "warInfoName", warInfoName, "count_CompleteTent", count_CompleteTent)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 13)
  else
    return
  end
end
Panel_WarInfoMessage:RegisterUpdateFunc("warInfoMessage_check")
function warInfoMessage_check(deltaTime)
  onTime = onTime + deltaTime
  if onTime > 4 and Panel_WarInfoMessage:GetShow() then
    Panel_WarInfoMessage:SetShow(false, false)
    onTime = 0
  end
  if onTime > 6 then
    onTime = 0
  end
end
function FromClient_NotifyAttackedKingOrLoadTent(percent, areaName)
  if percent < 0 then
    return
  end
  local msg_type = 3
  local msg_Main
  if percent <= 600000 and percent >= 300001 then
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTNOTIFY", "areaName", areaName) .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_ATTACKEDKINGORLOADTENT_UNDER", "Percent", 60, "left_HP", string.format("%.1f", percent / 10000))
  elseif percent <= 300000 then
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTNOTIFY", "areaName", areaName) .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_ATTACKEDKINGORLOADTENT_DANGER", "Percent", 30, "left_HP", string.format("%.1f", percent / 10000))
  else
    msg_Main = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTNOTIFY", "areaName", areaName) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_ATTACKEDKINGORLOADTENT_NOTY", "Percent", string.format("%.1f", percent / 10000))
  end
  if _ContentsOption_CH_GameType == true then
    msg_Main = "<PAColor0xfff5ba3a>" .. msg_Main .. "<PAOldColor>"
  else
    msg_Main = "<PAColor0xffaf1426>" .. msg_Main .. "<PAOldColor>"
  end
  local msg_Sub = ""
  if _ContentsOption_CH_GameType == true then
    msg_Sub = "<PAColor0xfff5ba3a>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTNOTIFY2", "areaName", areaName) .. " " .. PAGetString(Defines.StringSheet_GAME, "Lua_Guild_AttackedKingOrLoadTent") .. "<PAOldColor>"
  else
    msg_Sub = "<PAColor0xfff14152>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTNOTIFY2", "areaName", areaName) .. " " .. PAGetString(Defines.StringSheet_GAME, "Lua_Guild_AttackedKingOrLoadTent") .. "<PAOldColor>"
  end
  local message = {
    main = msg_Main,
    sub = msg_Sub,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 14)
end
function FromClient_KingOrLordTentDestroy(notifyType, regionKeyRaw)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  local areaName, msg_Main
  if regionInfoWrapper:get():isMainTown() then
    areaName = regionInfoWrapper:getTerritoryName()
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTDESTORY_MAIN")
  else
    local explorationWrapper = regionInfoWrapper:getExplorationStaticStatusWrapper()
    if nil ~= explorationWrapper then
      areaName = regionInfoWrapper:getVillageSiegeAreaName()
      msg_Main = ""
    end
  end
  local msg_type = 3
  local msg_Sub = ""
  if 1 == notifyType then
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTDESTORY_SUB1", "territoryName", areaName)
  else
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KINGORLORDTENTDESTORY_SUB2", "territoryName", areaName)
  end
  local message = {
    main = msg_Main,
    sub = msg_Sub,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 14)
end
function FromClient_NotifyPayWarPenaltyCost(penaltyCost_s64)
  if penaltyCost_s64 <= Defines.s64_const.s64_0 then
    return
  end
  local msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAR_CONTINUE_COST", "money", makeDotMoney(penaltyCost_s64))
  Proc_ShowMessage_Ack(msg)
end
function FromClient_NotifyGuildWar(msgType, guildName, targetGuildName)
  local msg_type, msg_Main, msg_Sub
  if 1 == msgType and "" == targetGuildName then
    return
  end
  if 0 == msgType then
    msg_type = 6
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTART_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WAIT_WARSTART_NACK_SUB", "guildName", guildName, "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 1 == msgType then
    msg_type = 7
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTOP_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTOP_NACK_SUB", "guildName", guildName, "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 16)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 2 == msgType then
    msg_type = 7
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARBRAKEUP_NACK_MAIN")
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARBRAKEUP_NACK_SUB", "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 16)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 3 == msgType then
    msg_type = 6
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTART_NACK_MAIN")
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WAIT_DECLAREWAR_NACK_SUB", "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 4 == msgType then
    msg_type = 6
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTART_NACK_MAIN")
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WAIT_DECLAREWAR_TARGET_NACK_SUB", "guildName", guildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 5 == msgType then
    msg_type = 6
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTART_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_RESPONSE_WARSTART_NACK_SUB", "guildName", guildName, "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 6 == msgType then
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_WARSTOP_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NAK_GUILD_ARBITATION_DESC", "guild0", guildName, "guild1", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 154)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  end
end
function FromClient_NotifyStartSiege(msgtype, regionKeyRaw)
  if 0 == msgtype then
    local msg_type = 5
    local msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGESTART_MAIN")
    local msg_Sub = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGESTART_SUB")
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 10)
    local msg_Main2 = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGEPROGRESS_PLUNDER")
    local message = {
      main = msg_Main2,
      sub = "",
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 10)
  elseif 1 == msgtype then
    local msg_type = 5
    local msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGEPROGRESS_MAIN")
    local msg_Sub = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGEPROGRESS_SUB")
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 10)
  elseif 2 == msgtype then
    local msg_type = 5
    local msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTNODESIEGE_SIEGESTART_MAIN")
    local msg_Sub = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGESTART_SUB")
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 10)
  elseif 3 == msgtype then
    local msg_type = 5
    local msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTNODESIEGE_SIEGEPROGRESS_MAIN")
    local msg_Sub = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTARTSIEGE_SIEGEPROGRESS_SUB")
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 10)
  end
end
function FromClient_FinishVillageSiege()
  local msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYSTOPNODESIEGE_SIEGESTOP_MAIN")
  local message = {
    main = msg_Main,
    sub = "",
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 11)
end
function FromClient_OccupySiege2024(regionKeyRaw, guildName, userNickName)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if regionInfoWrapper == nil then
    return
  end
  local areaName = regionInfoWrapper:getVillageSiegeAreaName()
  local message = {
    main = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_OCCUPY_SIEGE_2024", "region", areaName, "guild", guildName, "userNickName", userNickName),
    sub = "",
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 11)
end
function FromClient_ResponseSiege2024Raffle(territoryName)
  local message = {
    main = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BIGNAK_SIEGESELECT_TITLE", "teritoryName", territoryName),
    sub = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BIGNAK_SIEGESELECT_DESC"),
    addMsg = ""
  }
  Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 181, false)
end
local killDeathScore = {
  content = UI.getChildControl(Panel_TerritoryWarKillingScore, "Static_Content")
}
local TWKScore_PosIndex = 0
local TWKScore_PanelCount = 3
local TWKScore_PanelUIPool = {}
local TWKScore_AlertList = {}
local RenderModeWorldMapBitSet = PAUIRenderModeBitSet({
  Defines.RenderMode.eRenderMode_Default,
  Defines.RenderMode.eRenderMode_WorldMap,
  Defines.RenderMode.eRenderMode_ElfWar
})
local function create_TWKScore_Panel()
  for panel_idx = 1, TWKScore_PanelCount do
    local panel = UI.createPanelAndSetPanelRenderMode("territoryWar_KillDeathScore_Panel_" .. panel_idx, Defines.UIGroup.PAGameUIGroup_ModalDialog + panel_idx, RenderModeWorldMapBitSet)
    panel:SetSize(370, 35)
    panel:SetIgnore(true)
    panel:SetHorizonCenter()
    panel:SetShow(false, false)
    local panel_StaticText = UI.createAndCopyBasePropertyControl(Panel_TerritoryWarKillingScore, "Static_Content", panel, "territoryWar_KillDeathScore_Panel_" .. panel_idx .. "_StaticText")
    CopyBaseProperty(killDeathScore.content, panel_StaticText)
    panel_StaticText:SetIgnore(true)
    panel_StaticText:SetShow(true)
    panel_StaticText:SetSize(370, 35)
    TWKScore_PanelUIPool[panel_idx] = panel
    TWKScore_AlertList[panel_idx] = panel_StaticText
  end
end
create_TWKScore_Panel()
local function TWKScore_Open(panel)
  panel:SetShow(true, false)
  panel:ResetVertexAni()
  panel:SetScaleChild(1, 1)
  local aniInfo = panel:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo3 = panel:addColorAnimation(0.26, 8, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo3:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = panel:addScaleAnimation(8, 8.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo4:SetStartScale(1)
  aniInfo4:SetEndScale(0)
  aniInfo4.IsChangeChild = true
end
local function TWKScore_updatePosition()
  for index = 1, TWKScore_PanelCount do
    local realIndex = (index - TWKScore_PosIndex + 5) % TWKScore_PanelCount + 1
    local panel = TWKScore_PanelUIPool[index]
    if panel:IsShow() then
      panel:SetPosY(Panel_WarInfoMessage:GetPosY() + Panel_TerritoryWarKillingScore:GetSizeY() * realIndex + 5)
    end
  end
end
function FromClient_NotifyKillOrDeathPlayer()
  local data = ToClient_getKillOrDeathPlayerData()
  if nil == data then
    return
  end
  local isGuildMatch = ToClient_IsGuildMatchPlaying()
  if isGuildMatch == true then
    return
  end
  local notifyType = data:getNotifyType()
  local isKill = data:isKill()
  local characterName = data:getCharacterName()
  local characterNamePeer = data:getCharacterNamePeer()
  local guildNamePeer = data:getGuildNamePeer()
  local isInSiege = data:isInSiege()
  local isWarGuild = data:isWarGuild()
  local doPopup = data:doPopup()
  local militiaType = data:getSiegeKillType()
  local isAllianceName = data:isAllianceName()
  local killOrDeathMsg
  local colorValue = 0
  local textureDDS = ""
  local isSigeBeing = deadMessage_isSiegeBeingMyChannel()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  local guildNameLength = string.len(guildNamePeer)
  if isKill then
    if 1 == militiaType then
      characterName = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
    elseif 2 == militiaType then
      characterNamePeer = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
    elseif 3 == militiaType then
      characterName = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
      characterNamePeer = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
    end
  elseif 1 == militiaType then
    characterNamePeer = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
  elseif 2 == militiaType then
    characterName = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
  elseif 3 == militiaType then
    characterName = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
    characterNamePeer = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA")
  end
  if isKill then
    if 0 ~= guildNameLength then
      if isSigeBeing and isInSiege then
        if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
          killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_SiegeAttacker_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
        else
          if true == isAllianceName then
            killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_Alliance_SiegeAttacker", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
          else
            killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_SiegeAttacker", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
          end
          PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.siege, characterName, characterNamePeer, guildNamePeer)
        end
        textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
        colorValue = 4282165742
      elseif isWarGuild then
        if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
          killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttacker_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
        else
          killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttacker", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
          PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.guildWar, characterName, characterNamePeer, guildNamePeer)
        end
        textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
        colorValue = 4282165742
      elseif isGuildBattle then
        if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
          killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttacker_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
        else
          killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttacker", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
        end
        textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
        colorValue = 4282165742
      else
        killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NoGuildAttacker", "characterName", characterName, "characterNamePeer", characterNamePeer)
        textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
        colorValue = 4282165742
        PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.normal, characterName, characterNamePeer, guildNamePeer)
      end
    elseif isSigeBeing and isInSiege then
      killOrDeathMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_SiegeAttackerToNoSiegeAttackee", "characterName", characterNamePeer)
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
      colorValue = 4282165742
      PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.siege, characterName, characterNamePeer, guildNamePeer)
    else
      killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NoGuildAttacker", "characterName", characterName, "characterNamePeer", characterNamePeer)
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
      colorValue = 4282165742
      PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.normal, characterName, characterNamePeer, guildNamePeer)
    end
  elseif 0 ~= guildNameLength then
    if isSigeBeing and isInSiege then
      if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
        killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_SiegeAttackee_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
      elseif true == isAllianceName then
        killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_Alliance_SiegeAttackee", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
      else
        killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_SiegeAttackee", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
      end
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
      colorValue = 4294057271
    elseif isWarGuild then
      if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
        killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttackee_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
      else
        killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttackee", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
      end
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
      colorValue = 4294057271
    elseif isGuildBattle then
      if PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA") == characterNamePeer then
        killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttackee_Militia", "characterName", characterName, "characterNamePeer", characterNamePeer)
      else
        killOrDeathMsg = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_GuildAttackee", "characterName", characterName, "guildNamePeer", guildNamePeer, "characterNamePeer", characterNamePeer)
      end
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
      colorValue = 4294057271
    else
      killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NoGuildAttackee", "characterName", characterName, "characterNamePeer", characterNamePeer)
      textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
      colorValue = 4294057271
    end
  elseif 5 == notifyType then
    killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_KILL", "characterNamePeer", characterNamePeer, "characterName", characterName)
    textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
    colorValue = 4294057271
  else
    killOrDeathMsg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NoGuildAttackee", "characterName", characterName, "characterNamePeer", characterNamePeer)
    textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
    colorValue = 4294057271
  end
  if doPopup then
    TWKScore_PosIndex = TWKScore_PosIndex % TWKScore_PanelCount + 1
    local targetControl = TWKScore_AlertList[TWKScore_PosIndex]
    targetControl:SetText(killOrDeathMsg)
    targetControl:ChangeTextureInfoName(textureDDS)
    if _ContentsOption_CH_GameType == false then
      targetControl:SetFontColor(colorValue)
    end
    local x1, y1, x2, y2 = setTextureUV_Func(targetControl, 0, 0, 370, 35)
    targetControl:getBaseTexture():setUV(x1, y1, x2, y2)
    targetControl:setRenderTexture(targetControl:getBaseTexture())
    TWKScore_Open(TWKScore_PanelUIPool[TWKScore_PosIndex])
    TWKScore_updatePosition()
  end
  chatting_sendMessage("", killOrDeathMsg, CppEnums.ChatType.Battle)
end
function FromClient_ElfWarKillLog(attackerName, attackeeName, attackerTeamNo, attackeeTeamNo, isSelf)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isParticipateInElfWar() == false then
    return
  end
  local myTeamNo = selfPlayer:getElfWarTeamNo()
  if ToClient_IsElfWarObserveMode() == true then
    myTeamNo = ToClient_GetElfObserveTeamNo()
  end
  local mainMessage = ""
  local textureDDS = ""
  if attackerTeamNo == myTeamNo then
    local teamName = ""
    if attackeeTeamNo == __eElfWarTeam_Kamasylvia then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CHARTITLE_KAMA")
    elseif attackeeTeamNo == __eElfWarTeam_Odyllita then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CHARTITLE_ODYL")
    end
    mainMessage = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_ELFWARATTACKER", "characterName", attackerName, "regionPartyName", teamName, "characterNamePeer", attackeeName)
    textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_KillingEnemy.dds"
  else
    local teamName = ""
    if attackerTeamNo == __eElfWarTeam_Kamasylvia then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CHARTITLE_KAMA")
    elseif attackerTeamNo == __eElfWarTeam_Odyllita then
      teamName = PAGetString(Defines.StringSheet_GAME, "LUA_ELFWAR_CHARTITLE_ODYL")
    end
    mainMessage = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_ELFWARATTACKEE", "characterName", attackeeName, "regionPartyName", teamName, "characterNamePeer", attackerName)
    textureDDS = "New_UI_Common_forLua/Widget/WarInfoMessage/score_DeathAlly.dds"
  end
  chatting_sendMessage("", mainMessage, CppEnums.ChatType.Battle)
  TWKScore_PosIndex = TWKScore_PosIndex % TWKScore_PanelCount + 1
  local targetControl = TWKScore_AlertList[TWKScore_PosIndex]
  targetControl:SetText(mainMessage)
  targetControl:ChangeTextureInfoName(textureDDS)
  local x1, y1, x2, y2 = setTextureUV_Func(targetControl, 0, 0, 370, 35)
  targetControl:getBaseTexture():setUV(x1, y1, x2, y2)
  targetControl:setRenderTexture(targetControl:getBaseTexture())
  TWKScore_Open(TWKScore_PanelUIPool[TWKScore_PosIndex])
  TWKScore_updatePosition()
  if isSelf == true then
    PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.elfWar, attackerName, attackeeName, nil, false)
  end
end
function FromClient_GuildMatchKillLog(attackerName, attackeeName, isKillerMyTeam, isKillerMe)
  local killLogMessage
  if isKillerMyTeam == true then
    killLogMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", attackerName, "deadPlayer", attackeeName) .. "<PAOldColor>"
  else
    killLogMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", attackerName, "deadPlayer", attackeeName) .. "<PAOldColor>"
  end
  if killLogMessage ~= nil then
    chatting_sendMessage("", killLogMessage, CppEnums.ChatType.Battle)
  end
  if isKillerMe == true then
    PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.guildMatch, attackerName, attackeeName, nil, false)
  end
end
function WarInfoMessage_IsBeingSiegeOrNodeWarNotify()
  local isFinishMinorSiege = ToClient_IsFinishMinorSiege()
  if false == isFinishMinorSiege then
    ToClient_SetSiegeAlertFlag(true)
    FromClient_NotifyStartSiege(3, 0)
    return
  end
  local isFinishMajorSiege = ToClient_IsFinishMajorSiege()
  if false == isFinishMajorSiege then
    ToClient_SetSiegeAlertFlag(true)
    FromClient_NotifyStartSiege(1, 0)
    return
  end
end
function FromClient_NotifyGuildDuel(msgType, guildName, targetGuildName)
  local msg_type, msg_Main, msg_Sub
  if 0 == msgType then
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTART_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTART_NACK_SUB", "guildName", guildName, "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 1 == msgType then
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_MAIN")
    msg_Sub = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_WIN", "guildName", guildName, "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 2 == msgType then
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_MAIN")
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_DRAW", "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  elseif 3 == msgType then
    msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_MAIN")
    msg_Sub = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DUELINFOMESSAGE_GUILDUELSTOP_NACK_TIMEOVER", "targetGuildName", targetGuildName)
    local message = {
      main = msg_Main,
      sub = msg_Sub,
      addMsg = ""
    }
    Proc_ShowMessage_Ack_WithOut_ChattingMessage_For_RewardSelect(message, 4, 15)
    chatting_sendMessage("", message.sub, CppEnums.ChatType.System)
  end
end
function FromClient_DestroyedSiegeGravityMagician()
  msg_Main = PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_NOTIFYKINGORLORDTENTCHANGE_DESTROYGRAVITY_MAIN")
  msg_Sub = ""
  local message = {
    main = msg_Main,
    sub = msg_Sub,
    addMsg = ""
  }
  Proc_ShowMessage_Ack_For_RewardSelect(message, 4, 182)
end
WarInfoMessage_IsBeingSiegeOrNodeWarNotify()
registerEvent("FromClient_KillOrDeathPlayer", "FromClient_NotifyKillOrDeathPlayer")
registerEvent("FromClient_KingOrLordTentChange", "FromClient_NotifyKingOrLordTentChange")
registerEvent("FromClient_OccupySiege", "FromClient_NotifyOccupySiege")
registerEvent("FromClient_ReleaseSiege", "FromClient_NotifyReleaseSiege")
registerEvent("FromClient_NotifyAttackedKingOrLordTent", "FromClient_NotifyAttackedKingOrLoadTent")
registerEvent("FromClient_KingOrLordTentDestroy", "FromClient_KingOrLordTentDestroy")
registerEvent("FromClient_NotifyGuildWar", "FromClient_NotifyGuildWar")
registerEvent("FromClient_NotifyStartSiege", "FromClient_NotifyStartSiege")
registerEvent("FromClient_FinishVillageSiege", "FromClient_FinishVillageSiege")
registerEvent("FromClient_OccupySiege2024", "FromClient_OccupySiege2024")
registerEvent("FromClient_ResponseSiege2024Raffle", "FromClient_ResponseSiege2024Raffle")
registerEvent("FromClient_NotifyPayWarPenaltyCost", "FromClient_NotifyPayWarPenaltyCost")
registerEvent("FromClient_ElfWarKillLog", "FromClient_ElfWarKillLog")
registerEvent("FromClient_GuildMatchKillLog", "FromClient_GuildMatchKillLog")
registerEvent("FromClient_DestroyedSiegeGravityMagician", "FromClient_DestroyedSiegeGravityMagician")
