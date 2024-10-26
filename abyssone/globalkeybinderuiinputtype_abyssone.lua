local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
function Process_UIMode_CommonWindow_MentalKnowledge()
  if GlobalValue_MiniGame_Value_HorseDrop == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAMING_DO_NOT_USE"))
    return
  end
  if false == _ContentsGroup_RenewUI_Knowledge then
    Panel_Knowledge_Show()
  elseif PaGlobalFunc_Window_Knowledge_GetShow() then
    PaGlobalFunc_Window_Knowledge_Exit()
  else
    PaGlobalFunc_Window_Knowledge_Show()
  end
end
function Process_UIMode_CommonWindow_PositionNotify(fastPinDelta)
  local isGuild = false == isKeyPressed(VCK.KeyCode_SHIFT)
  local targetPosition = crossHair_GetTargetPosition()
  local isOthilitaDungeon = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon)
  if true == isOthilitaDungeon then
    isGuild = false
  end
  if true == isGuild then
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    if nil ~= Panel_Widget_Ping_All and nil ~= PaGlobal_Ping_All_Open then
      PaGlobal_Ping_All_Open(true)
      return
    end
  else
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    if false == selfPlayer:hasParty() then
      return
    end
  end
  if true == ToClient_IsViewSelfPlayer(targetPosition) or true == isOthilitaDungeon then
    if fastPinDelta < 0.5 then
      ToClient_RequestSendPositionGuide(isGuild, true, false, targetPosition, __eNotifyPingTypeBDO_None)
      fastPinDelta = 10
    else
      ToClient_RequestSendPositionGuide(isGuild, false, false, targetPosition, __eNotifyPingTypeBDO_None)
      fastPinDelta = 0
    end
  end
end
function Process_UIMode_CommonWindow_PingTypeSelect()
  if nil ~= Panel_Widget_Ping_All and nil ~= PaGlobal_Ping_All_Open then
    PaGlobal_Ping_All_Open(true)
    return
  end
end
function Process_UIMode_CommonWindow_CashShop()
  if getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_Commercial or isGameTypeTaiwan() then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    InGameShop_Open()
  end
end
function Process_UIMode_CommonWindow_BlackSpirit()
  if _contentsGroup_summonBlackSpiritWhenMove == false then
    if IsSelfPlayerWaitAction() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
  elseif IsSelfPlayerWaitAction() == false and ToClient_isCanSummonBlackSpirit() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
    return
  end
  if PaGlobal_TutorialManager ~= nil and PaGlobal_TutorialManager:isDoingTutorial() == true and PaGlobal_TutorialManager:isAllowCallBlackSpirit() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if _ContentsGroup_HarvestList_All == true and PaGlobal_Worldmap_TentInfo_All_Close ~= nil then
    PaGlobal_Worldmap_TentInfo_All_Close()
  elseif FGlobal_TentTooltipHide ~= nil then
    FGlobal_TentTooltipHide()
  end
  if PaGlobalFunc_AbyssOneMenu_GetShow() == true then
    PaGlobalFunc_AbyssOneMenu_ShowToggle()
  end
  ToClient_AddBlackSpiritFlush()
end
function Process_UIMode_CommonWindow_Chatting()
  if PaGlobalFunc_AbyssOneMenu_GetShow() == true then
    PaGlobalFunc_AbyssOneMenu_ShowToggle()
  end
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Open()
  else
    ChatInput_Show()
  end
end
function Process_UIMode_CommonWindow_ProductionNote()
  if nil ~= Panel_ProductNote and not Panel_ProductNote:IsUISubApp() then
    Panel_ProductNote_ShowToggle()
  end
end
function Process_UIMode_CommonWindow_ExpirienceWiki()
  if true == _ContentsGroup_ExpirienceWiki_All and true == _ContentsGroup_ExpirienceWiki_KorVersion then
    if nil == Panel_Window_ExpirienceWiki_All then
      _PA_ASSERT_NAME(false, "\235\170\168\237\151\152\234\176\128 \235\133\184\237\138\184\234\176\128 \235\161\156\235\147\156 \235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164")
      return
    end
    PaGlobal_ExpirienceWiki_All_Open()
  else
    if nil == Panel_Window_ExpirienceWiki then
      _PA_ASSERT_NAME(false, "\235\170\168\237\151\152\234\176\128 \235\133\184\237\138\184\234\176\128 \235\161\156\235\147\156 \235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164")
      return
    end
    PaGlobal_ExpirienceWiki_Open()
  end
end
function Process_UIMode_CommonWindow_PlayerInfo()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil ~= Panel_CharacterInfo_All then
    if true == Panel_CharacterInfo_All:GetShow() then
      HandleEventLUp_ChracterInfo_All_CloseAll()
    else
      PaGlobalFunc_ChracterInfo_All_Open()
    end
    return
  end
  local selfProxy = selfPlayer:get()
  if nil ~= selfProxy then
    local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
    local temporaryWrapper = getTemporaryInformationWrapper()
    local unsealCacheData = getServantInfoFromActorKey(actorKeyRaw)
    if nil ~= unsealCacheData then
      local inventory = unsealCacheData:getInventory()
      local invenSize = inventory:size()
      if 0 ~= actorKeyRaw then
        if true == _ContentsGroup_UsePadSnapping then
          return
        end
        if true == PaGlobal_VehicleInfo_All_GetPanelShow() then
          PaGlobal_VehicleInfo_All_Close()
        elseif true == PaGlobal_ShipInfo_All_GetShowPanel() then
          PaGlobal_ShipInfo_All_Close()
        end
        Panel_Tooltip_Item_hideTooltip()
        TooltipSimple_Hide()
        requestInformationFromServant()
        PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
      end
    end
  end
end
function Process_UIMode_CommonWindow_Skill()
  if PaGlobalFunc_AbyssOneMenu_GetShow() == true then
    PaGlobalFunc_AbyssOneMenu_ShowToggle()
  end
  if true == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobalFunc_SkillGroup_HotKeyToggle()
  elseif false == _ContentsGroup_RenewUI then
    if nil ~= Panel_Window_Skill then
      if true == Panel_Window_Skill:IsShow() then
        audioPostEvent_SystemUi(1, 17)
        _AudioPostEvent_SystemUiForXBOX(1, 17)
        HandleMLUp_SkillWindow_Close()
      else
        audioPostEvent_SystemUi(1, 18)
        PaGlobal_Skill:SkillWindow_Show()
      end
    end
  elseif true == PaGlobalFunc_Skill_GetShow() then
    audioPostEvent_SystemUi(1, 17)
    _AudioPostEvent_SystemUiForXBOX(1, 17)
    PaGlobalFunc_Skill_Close()
  else
    audioPostEvent_SystemUi(1, 18)
    _AudioPostEvent_SystemUiForXBOX(1, 18)
    PaGlobalFunc_Skill_Open()
  end
end
function Process_UIMode_CommonWindow_PossessionByBlackSpirit()
  if PaGlobal_AutoManager._ActiveState then
    FGlobal_MouseclickTest()
  end
end
function Process_UIMode_CommonWindow_Inventory()
  if PaGlobal_AbyssOne_Inventory_All_GetOpen() == true then
    PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Close()
  else
    if PaGlobalFunc_AbyssOneMenu_GetShow() == true then
      PaGlobalFunc_AbyssOneMenu_ShowToggle()
    end
    PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_PrePareOpen()
  end
end
function Process_UIMode_CommonWindow_Dyeing()
  if PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if MiniGame_Manual_Value_FishingStart == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
    return
  elseif true == _ContentsGroup_RenewUI_Dyeing then
    audioPostEvent_SystemUi(1, 24)
    _AudioPostEvent_SystemUiForXBOX(1, 24)
    if _ContentsGroup_NewUI_Dye_All then
      if nil ~= Panel_Widget_Dye_All and not Panel_Widget_Dye_All:GetShow() then
        PaGlobal_Dye_All_Open()
      end
    else
      PaGlobalFunc_Dyeing_Open()
    end
  else
    audioPostEvent_SystemUi(1, 24)
    _AudioPostEvent_SystemUiForXBOX(1, 24)
    if _ContentsGroup_NewUI_Dye_All then
      if nil ~= Panel_Widget_Dye_All and not Panel_Widget_Dye_All:GetShow() then
        PaGlobal_Dye_All_Open()
      end
    elseif nil ~= Panel_Dye_ReNew and not Panel_Dye_ReNew:GetShow() then
      FGlobal_Panel_Dye_ReNew_Open()
    end
  end
end
function Process_UIMode_CommonWindow_Present()
  if nil ~= Panel_CharacterInfo_All then
    if true == Panel_CharacterInfo_All:GetShow() then
      if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
        HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
        HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      else
        PaGlobalFunc_ChracterInfo_All_Close()
      end
    else
      PaGlobalFunc_ChracterInfo_All_Open(true)
      HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
      HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      if true == _ContentsGroup_RenewUI and nil ~= PaGlobalFunc_CharInfoChallenge_All_OpenWithReward then
        PaGlobalFunc_CharInfoChallenge_All_OpenWithReward()
      end
    end
  end
end
function Process_UIMode_CommonWindow_Manufacture()
  if MiniGame_Manual_Value_FishingStart == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_FISHING_ACK"))
    return
  elseif 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  elseif true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  else
    if not IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
      return
    end
    if _ContentsGroup_RenewUI_Manufacture then
      local isManufactureOpen = false
      if false == Panel_Window_Manufacture_All:GetShow() then
        audioPostEvent_SystemUi(1, 26)
        _AudioPostEvent_SystemUiForXBOX(1, 26)
        PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
      else
        audioPostEvent_SystemUi(1, 25)
        _AudioPostEvent_SystemUiForXBOX(1, 25)
        PaGlobalFunc_Manufacture_All_Close()
      end
    else
      local isInvenOpen = false
      if true == _ContentsGroup_NewUI_Inventory_All then
        isInvenOpen = Panel_Window_Inventory_All:GetShow()
      else
        isInvenOpen = Panel_Window_Inventory:GetShow()
      end
      local isManufactureOpen = false
      if nil ~= Panel_Window_Manufacture_All then
        isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
      end
      if isManufactureOpen == false or isInvenOpen == false then
        audioPostEvent_SystemUi(1, 26)
        _AudioPostEvent_SystemUiForXBOX(1, 26)
        PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
      else
        audioPostEvent_SystemUi(1, 25)
        _AudioPostEvent_SystemUiForXBOX(1, 25)
        if not _ContentsGroup_RenewUI_Manufacture then
          PaGlobalFunc_Manufacture_All_Close()
        end
      end
    end
  end
end
function Process_UIMode_CommonWindow_Guild()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if false == _ContentsGroup_RenewUI_Guild then
    if nil ~= guildWrapper then
      local guildGrade = guildWrapper:getGuildGrade()
      if 0 == guildGrade then
        if false == Panel_Window_ClanList_All:IsShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobal_ClanList_All_Open()
        else
          audioPostEvent_SystemUi(1, 31)
          _AudioPostEvent_SystemUiForXBOX(1, 31)
          PaGlobal_ClanList_All_Close()
        end
      elseif nil ~= Panel_GuildMain_All then
        if true == Panel_GuildMain_All:GetShow() then
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Close()
        else
          audioPostEvent_SystemUi(1, 36)
          _AudioPostEvent_SystemUiForXBOX(1, 36)
          PaGlobalFunc_GuildMain_All_Open()
        end
      end
    elseif false == _ContentsGroup_RenewUI then
      if true == _ContentsGroup_Guild_JoinRequest then
        if nil ~= Panel_Guild_NoneGuild and true == Panel_Guild_NoneGuild:GetShow() then
          PaGlobal_Guild_NoneGuild_SetShow(false)
        else
          PaGlobal_Guild_NoneGuild_SetShow(true)
        end
      else
        PaGlobal_GuildNonJoinMember_SetShow(true)
      end
    end
  elseif nil ~= guildWrapper then
    local guildGrade = guildWrapper:getGuildGrade()
    if 0 == guildGrade then
      if false == Panel_Window_ClanList_All:IsShow() then
        audioPostEvent_SystemUi(1, 36)
        _AudioPostEvent_SystemUiForXBOX(1, 36)
        PaGlobal_ClanList_All_Open()
      else
        audioPostEvent_SystemUi(1, 31)
        _AudioPostEvent_SystemUiForXBOX(1, 31)
        PaGlobal_ClanList_All_Close()
      end
    elseif nil ~= Panel_GuildMain_All then
      if true == Panel_GuildMain_All:GetShow() then
        audioPostEvent_SystemUi(1, 36)
        _AudioPostEvent_SystemUiForXBOX(1, 36)
        PaGlobalFunc_GuildMain_All_Close()
      else
        audioPostEvent_SystemUi(1, 36)
        _AudioPostEvent_SystemUiForXBOX(1, 36)
        PaGlobalFunc_GuildMain_All_Open()
      end
    end
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NO_GUILD"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function Process_UIMode_CommonWindow_Mail()
  local isMailMain = false
  if false == _ContentsGroup_NewUI_Mail_All then
    if Panel_Window_Mail_Renew ~= nil and Panel_Window_MailDetail_Renew ~= nil then
      isMailMain = Panel_Window_Mail_Renew:IsShow()
      if isMailMain == false then
        audioPostEvent_SystemUi(1, 22)
        _AudioPostEvent_SystemUiForXBOX(1, 22)
        Mail_Open()
      else
        audioPostEvent_SystemUi(1, 21)
        _AudioPostEvent_SystemUiForXBOX(1, 21)
        Mail_Close()
      end
    end
  else
    isMailMain = Panel_Window_Mail_All:IsShow()
    if isMailMain == false then
      audioPostEvent_SystemUi(1, 22)
      _AudioPostEvent_SystemUiForXBOX(1, 22)
      PaGlobal_Window_Mail_All_Open()
    else
      audioPostEvent_SystemUi(1, 21)
      _AudioPostEvent_SystemUiForXBOX(1, 22)
      PaGlobal_Window_Mail_All_Close()
    end
  end
end
function Process_UIMode_CommonWindow_FriendList()
  if Panel_FriendList ~= nil then
    local isFriendList = Panel_FriendList:IsShow()
    if isFriendList == false then
      FriendList_show()
      audioPostEvent_SystemUi(1, 28)
      _AudioPostEvent_SystemUiForXBOX(1, 28)
    else
      FriendList_hide()
      audioPostEvent_SystemUi(1, 27)
      _AudioPostEvent_SystemUiForXBOX(1, 27)
    end
  end
  local isFriendList = Panel_FriendInfoList_All:IsShow()
  if isFriendList == false then
    PaGlobal_FriendInfoList_Show_All()
    audioPostEvent_SystemUi(1, 28)
    _AudioPostEvent_SystemUiForXBOX(1, 28)
  else
    PaGlobal_FriendInfoList_Hide_All()
    audioPostEvent_SystemUi(1, 27)
    _AudioPostEvent_SystemUiForXBOX(1, 27)
  end
end
function Process_UIMode_CommonWindow_QuestHistory()
  local QuestWindowSound = function(isOpen)
    if true == isOpen then
      if PaGlobalFunc_AbyssOneMenu_GetShow() == true then
        PaGlobalFunc_AbyssOneMenu_ShowToggle()
      end
      audioPostEvent_SystemUi(1, 29)
      _AudioPostEvent_SystemUiForXBOX(1, 29)
    elseif false == isOpen then
      audioPostEvent_SystemUi(1, 27)
      _AudioPostEvent_SystemUiForXBOX(1, 27)
    end
  end
  if true == _ContentsGroup_RenewUI then
    if Panel_Window_Quest_All:GetShow() then
      QuestWindowSound(false)
      PaGlobalFunc_Quest_All_Close()
    else
      QuestWindowSound(true)
      PaGlobalFunc_Quest_All_Open()
    end
  elseif Panel_Window_Quest_All:GetShow() and false == Panel_Window_Quest_All:IsUISubApp() then
    QuestWindowSound(false)
    PaGlobalFunc_Quest_All_Close()
  else
    QuestWindowSound(true)
    PaGlobalFunc_Quest_All_Open()
  end
  TooltipSimple_Hide()
end
function Process_UIMode_CommonWindow_BeautyShop()
  if false == _ContentsGroup_RenewUI_Customization then
    if not isKeyPressed(VCK.KeyCode_MENU) then
      if PaGlobal_TutorialManager:isDoingTutorial() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
        return
      end
      if not getCustomizingManager():isShow() then
        IngameCustomize_Show()
        return
      end
    end
  elseif not isKeyPressed(VCK.KeyCode_MENU) then
    if PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
      return
    end
    if false == PaGlobalFunc_Customization_GetShow() then
      IngameCustomize_Show()
    end
  end
end
function Process_UIMode_CommonWindow_WorldMap()
  if not Panel_Global_Manual:GetShow() or FGlobal_BulletCount_UiShowCheck() then
    if true == _ContentsGroup_RenewUI_WorldMap then
      PaGlobalFunc_WorldMap_Open()
    else
      PaGlobalFunc_MarketPlace_Close()
      FGlobal_PushOpenWorldMap()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_MINIGAMING_NOT_WORLDMAP"))
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_Panel_WorldMap_Open()
  end
end
function Process_UIMode_CommonWindow_House()
  if Panel_HousingList:GetShow() then
    HousingList_Close()
  else
    FGlobal_HousingList_Open()
  end
end
function Process_UIMode_CommonWindow_WorkerManager()
  PaGlobalFunc_WorkerManager_All_ShowToggle()
end
function Process_UIMode_CommonWindow_Maid()
  if nil ~= Panel_Window_MaidList_All and true == Panel_Window_MaidList_All:GetShow() then
    PaGlobalFunc_MaidList_All_Close()
  else
    PaGlobalFunc_MaidList_All_Open()
  end
end
function Process_UIMode_CommonWindow_DeleteNavigation()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RADER_TUTORIAL_PROGRSS_ACK"))
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  Panel_NaviButton:SetShow(false)
  audioPostEvent_SystemUi(0, 15)
  _AudioPostEvent_SystemUiForXBOX(0, 15)
end
function Process_UIMode_CommonWindow_AdventureBook()
  if PaGlobalFunc_Achievement_BookShelf_All_ShowToggle ~= nil then
    PaGlobalFunc_Achievement_BookShelf_All_ShowToggle()
  end
end
function Process_UIMode_CommonWindow_BlackGift()
  PaGlobal_TotalReward_All_Open()
end
function Process_UIMode_CommonWindow_CallServantWater()
  ToClient_AutoRideOnShip()
end
function Process_UIMode_CommonWindow_BarterInfo()
  PaGlobal_BarterInfoSearch_OpenToggle()
end
function Process_UIMode_CommonWindow_FamilyInvenory()
  if false == _ContentsGroup_FamilyInventory then
    return
  end
  if false == ToClient_isOpenFamilyInventory() then
    return
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace and true == PaGlobalFunc_MarketPlace_MyInven_GetShow() then
    return
  end
  if true == _ContentsGroup_isFairy and true == _ContentsGroup_NewUI_Fairy_All and (true == PaGlobal_FairyInfo_IsGetShow() or true == PaGlobal_FairyChangeSkill_IsGetShow()) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYOPEN_NOUSE"))
    return
  end
  if false == PaGlobalFunc_Inventory_All_familyInventoryIsActive() then
    return
  end
  if false == _ContentsGroup_changeFamilyInvenOpenAction then
    PaGlobal_FamilyInvnetoryShowToggle()
    return
  end
  if true == _ContentsGroup_RenewUI_Inventory then
    if false == PaGlobalFunc_InventoryInfo_GetShow() then
      PaGlobal_FamilyInvnetoryShowToggle()
    else
      PaGlobalFunc_InventoryInfo_Close()
    end
    return
  end
  local isInvenOpen = Panel_Window_Inventory_All:IsShow()
  local isEquipOpen = Panel_Window_Equipment_All:GetShow()
  local isOpenFamilyInven = true == Panel_Window_FamilyInventory_All:GetShow() or CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType()
  if false == isInvenOpen or false == isOpenFamilyInven then
    if isEquipOpen == false then
      PaGlobalFunc_Equipment_All_SetShow(true)
    end
    audioPostEvent_SystemUi(1, 16)
    _AudioPostEvent_SystemUiForXBOX(1, 16)
    InventoryWindow_Show(true, false, false, true)
    if nil ~= PaGlobalFunc_ServantInventory_GetShow and true == PaGlobalFunc_ServantInventory_GetShow() then
      TooltipSimple_Hide()
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    local isInvenUISubApp = Panel_Window_Inventory_All:IsUISubApp()
    if true == isInvenUISubApp and isEquipOpen == false then
      PaGlobalFunc_Equipment_All_SetShow(true)
    else
      PaGlobalFunc_Equipment_All_SetShow(false)
    end
    audioPostEvent_SystemUi(1, 15)
    _AudioPostEvent_SystemUiForXBOX(1, 15)
    InventoryWindow_Close()
    PaGlobalFunc_ClothInventory_All_Close()
    TooltipSimple_Hide()
  end
end
function Process_UIMode_CommonWindow_PartySetting()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Normal)
end
function Process_UIMode_CommonWindow_PlatoonSetting()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
  PaGlobalFunc_PartySetting_Open(CppEnums.PartyType.ePartyType_Large)
end
function Process_UIMode_CommonWindow_SetPingType(pingType)
  if nil == pingType or pingType >= __eNotifyPingTypeBDO_Count then
    return
  end
  if nil ~= PaGlobal_Ping_All_SavePingType then
    PaGlobal_Ping_All_SavePingType(pingType)
  end
end
