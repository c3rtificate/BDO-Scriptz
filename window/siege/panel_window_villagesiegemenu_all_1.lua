function PaGlobal_VillageSiegeMenu:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBg = UI.getChildControl(Panel_Window_VillageSiegeMenu_All, "Static_TitleBg")
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Close")
  local tabBg = UI.getChildControl(Panel_Window_VillageSiegeMenu_All, "Static_TabBg")
  self._ui._rdo_applyParticipation = UI.getChildControl(tabBg, "RadioButton_Request")
  self._ui._rdo_listParticipation = UI.getChildControl(tabBg, "RadioButton_SelectionGuild")
  self._ui._stc_tabSelectLine = UI.getChildControl(tabBg, "Static_SelectLine")
  self._ui._stc_mapBg = UI.getChildControl(Panel_Window_VillageSiegeMenu_All, "Static_MapBg")
  self._ui._txt_weekTitle = UI.getChildControl(self._ui._stc_mapBg, "StaticText_Date")
  self._territoryGroupList = Array.new()
  self._territoryParticipationList = Array.new()
  for index = self._eTerritoryGroupType.BEGINNER, self._eTerritoryGroupType.COUNT - 1 do
    local territoryGroupData = {
      _control = UI.getChildControl(self._ui._stc_mapBg, "Static_Territory_" .. tostring(index)),
      _groupType = index
    }
    self._territoryGroupList:push_back(territoryGroupData)
    local territoryApplyData = {
      _control = UI.getChildControl(self._ui._stc_mapBg, "Static_ApplyTerritory_" .. tostring(index)),
      _groupType = index,
      _txt_maxCount = nil,
      _txt_limitAD = nil,
      _btn_applyOrCancel = nil,
      _btn_cantApply = nil
    }
    territoryApplyData._txt_maxCount = UI.getChildControl(territoryApplyData._control, "StaticText_MaxCount")
    territoryApplyData._txt_limitAD = UI.getChildControl(territoryApplyData._control, "StaticText_ADLimit")
    territoryApplyData._btn_applyOrCancel = UI.getChildControl(territoryApplyData._control, "Button_Request")
    territoryApplyData._btn_cantApply = UI.getChildControl(territoryApplyData._control, "StaticText_CantRequest")
    local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(territoryApplyData._groupType)
    local day = ToClient_GetDayOfWeekByVillageSiege()
    if siegeOptionStatic ~= nil then
      territoryApplyData._txt_maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_MAXMEMBER", "count", siegeOptionStatic:getLimitMemberCount(day)))
      if siegeOptionStatic:isUnlimitedDDPV() == true then
        territoryApplyData._txt_limitAD:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_UNLIMITVALUE"))
      else
        local maxDD = siegeOptionStatic._siegeMaxDDForUI
        local maxPV = siegeOptionStatic._siegeMaxPVForUI
        territoryApplyData._txt_limitAD:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_LIMITVALUE", "sum", maxDD + maxPV))
      end
      territoryApplyData._txt_limitAD:SetSize(territoryApplyData._txt_limitAD:GetTextSizeX(), territoryApplyData._txt_limitAD:GetSizeY())
      territoryApplyData._txt_limitAD:ComputePos()
      if ToClient_isConsole() == true then
        local consoleTerritoryKeyRaw = siegeOptionStatic:getConsoleTerritoryKeyRaw()
        if index == self._eTerritoryGroupType.BEGINNER then
          local serendiaFlag = UI.getChildControl(territoryApplyData._control, "Static_SerendiaFlag")
          local balenosFlag = UI.getChildControl(territoryApplyData._control, "Static_BalenosFlag")
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.BALENOS then
            serendiaFlag:SetShow(false)
            balenosFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - balenosFlag:GetSizeX() * 0.5)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.SERENDIA then
            balenosFlag:SetShow(false)
            serendiaFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - serendiaFlag:GetSizeX() * 0.5)
          end
        elseif index == self._eTerritoryGroupType.ADVANCED then
          local valenciaFlag = UI.getChildControl(territoryApplyData._control, "Static_ValenciaFlag")
          local mediaFlag = UI.getChildControl(territoryApplyData._control, "Static_MediaFlag")
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.MEDIA then
            valenciaFlag:SetShow(false)
            mediaFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - mediaFlag:GetSizeX() * 0.5)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.VALENCIA then
            mediaFlag:SetShow(false)
            valenciaFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - valenciaFlag:GetSizeX() * 0.5)
          end
        elseif index == self._eTerritoryGroupType.INTERMEDIATE then
          local calpheonFlag = UI.getChildControl(territoryApplyData._control, "Static_KamasylviaFlag")
          local kamasylviaFlag = UI.getChildControl(territoryApplyData._control, "Static_CalpheonFlag")
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.CALPHEON then
            calpheonFlag:SetShow(false)
            kamasylviaFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - kamasylviaFlag:GetSizeX() * 0.5)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
            kamasylviaFlag:SetShow(false)
            calpheonFlag:SetPosX(territoryApplyData._control:GetSizeX() * 0.5 - calpheonFlag:GetSizeX() * 0.5)
          end
        end
      end
    end
    territoryApplyData._btn_applyOrCancel:SetShow(true)
    territoryApplyData._btn_cantApply:SetShow(false)
    self._territoryParticipationList:push_back(territoryApplyData)
  end
  self._ui._stc_balenosIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_BalenosIcon")
  self._ui._stc_serendiaIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_SerendiaIcon")
  self._ui._stc_calpheonIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_CalpheonIcon")
  self._ui._stc_kamasylviaIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_KamasylviaIcon")
  self._ui._stc_mediaIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_MediaIcon")
  self._ui._stc_valenciaIcon = UI.getChildControl(self._ui._stc_mapBg, "Static_ValenciaIcon")
  self._ui._txt_notice = UI.getChildControl(self._ui._stc_mapBg, "StaticText_Notice")
  self._ui._stc_applyResult = UI.getChildControl(self._ui._stc_mapBg, "Static_Result")
  self._ui._stc_applyResultTerritory = UI.getChildControl(self._ui._stc_applyResult, "Static_SelectedFlag")
  self._ui._txt_applyResultMaxCount = UI.getChildControl(self._ui._stc_applyResult, "StaticText_MaxCount")
  self._ui._txt_applyResultLimit = UI.getChildControl(self._ui._stc_applyResult, "StaticText_ADLimit")
  self._ui._btn_applyResultOtherGuild = UI.getChildControl(self._ui._stc_applyResult, "Button_OtherGuild")
  self._ui._btn_startSiegeForQA = UI.getChildControl(self._ui._stc_mapBg, "Button_StartSiegeForQA")
  self._ui._btn_stopSiegeForQA = UI.getChildControl(self._ui._stc_mapBg, "Button_StopSiegeForQA")
  self._ui._btn_resetApplyCountForQA = UI.getChildControl(self._ui._stc_mapBg, "Button_ResetApplyCountForQA")
  self._ui._btn_resetApplyCountAllForQA = UI.getChildControl(self._ui._stc_mapBg, "Button_ResetApplyCountAllForQA")
  self._ui._btn_changeSiegeApplyNeedCountForQA = UI.getChildControl(self._ui._stc_mapBg, "Button_ChangeSiegeApplyNeedCountForQA")
  self._ui._stc_guildListBg = UI.getChildControl(Panel_Window_VillageSiegeMenu_All, "Static_GuildListBg")
  self._ui._stc_topDateBg = UI.getChildControl(self._ui._stc_guildListBg, "Static_DateBg")
  self._ui._txt_topDate = UI.getChildControl(self._ui._stc_topDateBg, "StaticText_Date")
  self._ui._txt_topDateDay = UI.getChildControl(self._ui._stc_topDateBg, "StaticText_Day")
  self._ui._stc_contentBg = UI.getChildControl(self._ui._stc_guildListBg, "Static_ContentBg")
  self._ui._stc_noData = UI.getChildControl(self._ui._stc_contentBg, "StaticText_NoData")
  self._ui._frm_listApply = UI.getChildControl(self._ui._stc_contentBg, "Frame_JoinGuildList")
  self._ui._stc_applyGroupTemplate = UI.getChildControl(self._ui._frm_listApply:GetFrameContent(), "Static_TerritoryBg_Template")
  self._ui._stc_applyGuildTemplate = UI.getChildControl(self._ui._stc_applyGroupTemplate, "Static_GuildTemplate")
  self._ui._stc_keyGuideBg = UI.getChildControl(Panel_Window_VillageSiegeMenu_All, "Static_BottomBG_ConsoleUI")
  self._ui._stc_keyGuideLB = UI.getChildControl(tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuideRB = UI.getChildControl(tabBg, "Static_RB_ConsoleUI")
  self._ui._stc_applyGroupTemplate:SetShow(false)
  self._ui._stc_applyGuildTemplate:SetShow(false)
  self._ui._btn_startSiegeForQA:SetShow(false)
  self._ui._btn_stopSiegeForQA:SetShow(false)
  self._ui._btn_resetApplyCountForQA:SetShow(false)
  self._ui._btn_resetApplyCountAllForQA:SetShow(false)
  self._ui._btn_changeSiegeApplyNeedCountForQA:SetShow(false)
  self._ui._stc_keyGuideBg:SetShow(self._isConsole)
  self._ui._stc_keyGuideLB:SetShow(self._isConsole)
  self._ui._stc_keyGuideRB:SetShow(self._isConsole)
  self._ui._btn_close:SetShow(self._isConsole == false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_VillageSiegeMenu:registEventHandler()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_VillageSiegeMenu_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY .. ")")
    Panel_Window_VillageSiegeMenu_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY_LIST .. ")")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_VillageSiegeMenu_Close()")
  end
  if ToClient_isConsole() == true then
    self._ui._rdo_applyParticipation:addInputEvent("Mouse_LUp", "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY .. ")")
    self._ui._rdo_listParticipation:addInputEvent("Mouse_LUp", "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY_LIST .. ")")
    self._ui._stc_balenosIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.BEGINNER .. ", " .. self._eTerritoryKeyRaw.BALENOS .. ")")
    self._ui._stc_balenosIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_serendiaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.BEGINNER .. ", " .. self._eTerritoryKeyRaw.SERENDIA .. ")")
    self._ui._stc_serendiaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_calpheonIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.INTERMEDIATE .. ", " .. self._eTerritoryKeyRaw.CALPHEON .. ")")
    self._ui._stc_calpheonIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_kamasylviaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.INTERMEDIATE .. ", " .. self._eTerritoryKeyRaw.KAMASYLVIA .. ")")
    self._ui._stc_kamasylviaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_mediaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.ADVANCED .. ", " .. self._eTerritoryKeyRaw.MEDIA .. ")")
    self._ui._stc_mediaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_valenciaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.ADVANCED .. ", " .. self._eTerritoryKeyRaw.VALENCIA .. ")")
    self._ui._stc_valenciaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
  else
    self._ui._rdo_applyParticipation:addInputEvent("Mouse_LUp", "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY .. ")")
    self._ui._rdo_listParticipation:addInputEvent("Mouse_LUp", "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY_LIST .. ")")
    self._ui._stc_balenosIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.BEGINNER .. ", nil)")
    self._ui._stc_balenosIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_serendiaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.BEGINNER .. ", nil)")
    self._ui._stc_serendiaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_calpheonIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.INTERMEDIATE .. ", nil)")
    self._ui._stc_calpheonIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_kamasylviaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.INTERMEDIATE .. ", nil)")
    self._ui._stc_kamasylviaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_mediaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.ADVANCED .. ", nil)")
    self._ui._stc_mediaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._stc_valenciaIcon:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. self._eTerritoryGroupType.ADVANCED .. ", nil)")
    self._ui._stc_valenciaIcon:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
  end
  if ToClient_IsDevelopment() == true or isRealServiceMode() == false then
    self._ui._stc_balenosIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.BEGINNER .. "," .. self._eTerritoryKeyRaw.BALENOS .. ")")
    self._ui._stc_serendiaIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.BEGINNER .. "," .. self._eTerritoryKeyRaw.SERENDIA .. ")")
    self._ui._stc_calpheonIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.INTERMEDIATE .. "," .. self._eTerritoryKeyRaw.CALPHEON .. ")")
    self._ui._stc_kamasylviaIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.INTERMEDIATE .. "," .. self._eTerritoryKeyRaw.KAMASYLVIA .. ")")
    self._ui._stc_mediaIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.ADVANCED .. "," .. self._eTerritoryKeyRaw.MEDIA .. ")")
    self._ui._stc_valenciaIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(" .. self._eTerritoryGroupType.ADVANCED .. "," .. self._eTerritoryKeyRaw.VALENCIA .. ")")
  end
  for key, value in pairs(self._territoryParticipationList) do
    if value ~= nil then
      if ToClient_isConsole() == true then
        local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(value._groupType)
        if siegeOptionStatic ~= nil then
          value._control:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. value._groupType .. ", " .. siegeOptionStatic:getConsoleTerritoryKeyRaw() .. ")")
          value._control:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
          value._btn_applyOrCancel:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancel(" .. value._groupType .. ")")
          value._btn_applyOrCancel:addInputEvent("Mouse_On", "HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(true, " .. value._groupType .. ", " .. siegeOptionStatic:getConsoleTerritoryKeyRaw() .. ")")
          value._btn_applyOrCancel:addInputEvent("Mouse_Out", "HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(false, " .. value._groupType .. ", " .. siegeOptionStatic:getConsoleTerritoryKeyRaw() .. ")")
          value._btn_cantApply:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. value._groupType .. ", " .. siegeOptionStatic:getConsoleTerritoryKeyRaw() .. ")")
          value._btn_cantApply:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
        end
      else
        value._control:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. value._groupType .. ", nil)")
        value._control:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
        value._btn_applyOrCancel:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ApplyOrCancel(" .. value._groupType .. ")")
        value._btn_applyOrCancel:addInputEvent("Mouse_On", "HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(true, " .. value._groupType .. ", nil)")
        value._btn_applyOrCancel:addInputEvent("Mouse_Out", "HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(false, " .. value._groupType .. ", nil)")
        value._btn_cantApply:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. value._groupType .. ", nil)")
        value._btn_cantApply:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
      end
    end
  end
  self._ui._btn_applyResultOtherGuild:addInputEvent("Mouse_LUp", "PaGlobal_VillageSiegeMenu:changeTab(" .. self._eTabType.APPLY_LIST .. ")")
  if ToClient_IsDevelopment() == true or isRealServiceMode() == false then
    self._ui._btn_startSiegeForQA:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_StartSiegeForQA()")
    self._ui._btn_stopSiegeForQA:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_StopSiegeForQA()")
    self._ui._btn_resetApplyCountForQA:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ResetApplyCountForQA()")
    self._ui._btn_resetApplyCountAllForQA:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ResetApplyCountAllForQA()")
    self._ui._btn_changeSiegeApplyNeedCountForQA:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeMenu_ChangeSiegeApplyNeedCountForQA()")
  end
  if ToClient_isConsole() == true then
    for index = self._eTerritoryGroupType.BEGINNER, self._eTerritoryGroupType.COUNT - 1 do
      local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(index)
      if siegeOptionStatic ~= nil then
        local consoleTerritoryKeyRaw = siegeOptionStatic:getConsoleTerritoryKeyRaw()
        if index == self._eTerritoryGroupType.BEGINNER then
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.BALENOS then
            self._ui._stc_serendiaIcon:SetShow(false)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.SERENDIA then
            self._ui._stc_balenosIcon:SetShow(false)
          end
        elseif index == self._eTerritoryGroupType.ADVANCED then
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.MEDIA then
            self._ui._stc_valenciaIcon:SetShow(false)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.VALENCIA then
            self._ui._stc_mediaIcon:SetShow(false)
          end
        elseif index == self._eTerritoryGroupType.INTERMEDIATE then
          if consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.CALPHEON then
            self._ui._stc_kamasylviaIcon:SetShow(false)
          elseif consoleTerritoryKeyRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
            self._ui._stc_calpheonIcon:SetShow(false)
          end
        end
      end
    end
  end
  registerEvent("FromClient_UpdateVillageSiegeMenuUI", "FromClient_UpdateVillageSiegeMenuUI")
end
function PaGlobal_VillageSiegeMenu:validate()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._rdo_applyParticipation:isValidate()
  self._ui._rdo_listParticipation:isValidate()
  self._ui._stc_tabSelectLine:isValidate()
  self._ui._stc_mapBg:isValidate()
  self._ui._stc_guildListBg:isValidate()
  self._ui._stc_topDateBg:isValidate()
  self._ui._txt_topDate:isValidate()
  self._ui._txt_topDateDay:isValidate()
  self._ui._stc_contentBg:isValidate()
  self._ui._stc_noData:isValidate()
  self._ui._frm_listApply:isValidate()
  self._ui._stc_applyGroupTemplate:isValidate()
  self._ui._stc_applyGuildTemplate:isValidate()
  self._ui._txt_weekTitle:isValidate()
  for key, value in pairs(self._territoryGroupList) do
    if value ~= nil then
      value._control:isValidate()
    end
  end
  for key, value in pairs(self._territoryParticipationList) do
    if value ~= nil then
      value._control:isValidate()
    end
  end
  self._ui._stc_balenosIcon:isValidate()
  self._ui._stc_serendiaIcon:isValidate()
  self._ui._stc_calpheonIcon:isValidate()
  self._ui._stc_kamasylviaIcon:isValidate()
  self._ui._stc_mediaIcon:isValidate()
  self._ui._stc_valenciaIcon:isValidate()
  self._ui._txt_notice:isValidate()
  self._ui._stc_applyResult:isValidate()
  self._ui._stc_applyResultTerritory:isValidate()
  self._ui._txt_applyResultMaxCount:isValidate()
  self._ui._txt_applyResultLimit:isValidate()
  self._ui._btn_applyResultOtherGuild:isValidate()
  self._ui._btn_startSiegeForQA:isValidate()
  self._ui._btn_stopSiegeForQA:isValidate()
  self._ui._btn_resetApplyCountForQA:isValidate()
  self._ui._btn_resetApplyCountAllForQA:isValidate()
  self._ui._btn_changeSiegeApplyNeedCountForQA:isValidate()
end
function PaGlobal_VillageSiegeMenu:prepareOpen()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  self:changeTab(self._eTabType.APPLY)
  self:updatePanelPosition()
  self:open()
end
function PaGlobal_VillageSiegeMenu:open()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  Panel_Window_VillageSiegeMenu_All:SetShow(true)
end
function PaGlobal_VillageSiegeMenu:prepareClose()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  self:close()
end
function PaGlobal_VillageSiegeMenu:close()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  Panel_Window_VillageSiegeMenu_All:SetShow(false)
end
function PaGlobal_VillageSiegeMenu:updatePanelPosition()
end
function PaGlobal_VillageSiegeMenu:changeTab(tabType)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  self._ui._stc_mapBg:SetShow(false)
  self._ui._stc_guildListBg:SetShow(false)
  self._ui._rdo_applyParticipation:SetCheck(false)
  self._ui._rdo_listParticipation:SetCheck(false)
  self:showFocusGroup(nil, nil)
  local selectedTabButton
  if tabType == self._eTabType.APPLY then
    self._ui._stc_mapBg:SetShow(true)
    self._ui._rdo_applyParticipation:SetCheck(true)
    selectedTabButton = self._ui._rdo_applyParticipation
    self:refreshApplyScene()
  elseif tabType == self._eTabType.APPLY_LIST then
    self._ui._stc_guildListBg:SetShow(true)
    self._ui._rdo_listParticipation:SetCheck(true)
    selectedTabButton = self._ui._rdo_listParticipation
    self:refreshApplyListScene()
  else
    UI.ASSERT_NAME(false, "TabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
    return
  end
  if selectedTabButton ~= nil then
    self._ui._stc_tabSelectLine:SetSpanSize(selectedTabButton:GetSpanSize().x, self._ui._stc_tabSelectLine:GetSpanSize().y)
    self._ui._stc_tabSelectLine:ComputePos()
  end
  self._currentTabType = tabType
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  Panel_Window_VillageSiegeMenu_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_VillageSiegeMenu_All:GetSizeX() / 2)
  if self._isConsole == true then
    Panel_Window_VillageSiegeMenu_All:SetPosY((getScreenSizeY() - Panel_Window_VillageSiegeMenu_All:GetSizeY() - self._ui._stc_keyGuideBg:GetSizeY()) / 2)
  else
    Panel_Window_VillageSiegeMenu_All:SetPosY((getScreenSizeY() - Panel_Window_VillageSiegeMenu_All:GetSizeY()) / 2)
  end
end
function PaGlobal_VillageSiegeMenu:getCurrentWeekString()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return ""
  end
  local paTime = PATime(getServerUtc64())
  local month = paTime:GetMonth()
  local week = string.format("%.0f", paTime:GetDay() / 7 + 1)
  local monthString = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_8"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_9"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_10"),
    [11] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_11"),
    [12] = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_FULLSTRING_MONTH_12")
  }
  return PAGetStringParam2(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_PERIODTITLE", "month", monthString[month], "week", week)
end
function PaGlobal_VillageSiegeMenu:getCurrentDayString()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return ""
  end
  local day = ToClient_GetDayOfWeekByVillageSiege()
  local dayString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY")
  }
  return dayString[day]
end
function PaGlobal_VillageSiegeMenu:updateStateString(isSiegeBeing, isRecruitmentTime, isParticipated, isMatched)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if isSiegeBeing == true then
    self._ui._txt_notice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_SIEGEBEING"))
    return
  end
  if isParticipated == true and isMatched == true then
    self._ui._txt_notice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_ENDRECRUITMENTTIME"))
  else
    if isRecruitmentTime == false then
      self._ui._txt_notice:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_ENDRECRUITMENTTIME"))
      return
    end
    self._ui._txt_notice:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_REQUESTDESC", "day", self:getCurrentDayString()))
  end
  return
end
function PaGlobal_VillageSiegeMenu:showFocusGroup(groupType, territoryKeyRaw)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if self._territoryGroupList == nil then
    return
  end
  for key, value in pairs(self._territoryGroupList) do
    if value ~= nil then
      value._control:SetShow(value._groupType == groupType)
      local childCount = value._control:getChildControlCount()
      if childCount > 0 then
        for childIdx = 0, childCount - 1 do
          local child = UI.getChildControlByIndex(value._control, childIdx)
          if territoryKeyRaw == nil then
            child:SetShow(true)
          else
            local childName = child:GetID()
            if territoryKeyRaw == self._eTerritoryKeyRaw.BALENOS then
              child:SetShow(childName == "Static_Balenos")
            elseif territoryKeyRaw == self._eTerritoryKeyRaw.SERENDIA then
              child:SetShow(childName == "Static_Serendia")
            elseif territoryKeyRaw == self._eTerritoryKeyRaw.CALPHEON then
              child:SetShow(childName == "Static_Calpheon")
            elseif territoryKeyRaw == self._eTerritoryKeyRaw.MEDIA then
              child:SetShow(childName == "Static_Media")
            elseif territoryKeyRaw == self._eTerritoryKeyRaw.VALENCIA then
              child:SetShow(childName == "Static_Valencia")
            elseif territoryKeyRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
              child:SetShow(childName == "Static_Kamasylvia")
            else
              child:SetShow(true)
            end
          end
        end
      end
    end
  end
end
function PaGlobal_VillageSiegeMenu:changeTexture(control, textureId, textureType)
  if control == nil or textureId == nil or textureType == nil then
    return
  end
  control:ChangeTextureInfoTextureIDAsync(textureId, textureType)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_VillageSiegeMenu:getTerritoryParticipationData(groupType)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return nil
  end
  if self._territoryParticipationList == nil then
    return nil
  end
  for key, value in pairs(self._territoryParticipationList) do
    if value ~= nil and value._groupType == groupType then
      return value
    end
  end
  return nil
end
function PaGlobal_VillageSiegeMenu:refreshApplyScene()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if self._isConsole == true then
    local keyGuideList = Array.new()
    local selectButton = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
    local exitButton = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
    selectButton:SetShow(true)
    exitButton:SetShow(true)
    keyGuideList:push_back(selectButton)
    keyGuideList:push_back(exitButton)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  end
  local isSiegeBeing = ToClient_IsAnySiegeBeingOfMyChannel()
  local isRecruitmentTime = ToClient_IsAbleToApplyOrCancelSiege2024()
  local currentGroupNo = ToClient_GetParicipateGroupNoVillageSiege2024()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyVillageSiege2024()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw >= 0
  local isMatched = isParticipated == true and currentTerritoryRaw < ToClient_GetNotMatchedTerritoryKeyVillageSiege2024()
  self._ui._txt_weekTitle:SetShow(true)
  self._ui._txt_weekTitle:SetText(self:getCurrentWeekString())
  self:updateStateString(isSiegeBeing, isRecruitmentTime, isParticipated, isMatched)
  self._ui._stc_applyResult:SetShow(false)
  self._ui._stc_applyResult:removeInputEvent("Mouse_On")
  self._ui._stc_applyResult:removeInputEvent("Mouse_Out")
  self._ui._btn_applyResultOtherGuild:removeInputEvent("Mouse_On")
  self._ui._btn_applyResultOtherGuild:removeInputEvent("Mouse_Out")
  if ToClient_IsDevelopment() == true or isRealServiceMode() == false then
    self._ui._btn_startSiegeForQA:SetShow(true)
    self._ui._btn_stopSiegeForQA:SetShow(true)
    self._ui._btn_resetApplyCountForQA:SetShow(true)
    self._ui._btn_resetApplyCountAllForQA:SetShow(true)
    self._ui._btn_changeSiegeApplyNeedCountForQA:SetShow(true)
  end
  for key, value in pairs(self._territoryParticipationList) do
    if value ~= nil then
      if isMatched == true then
        value._control:SetShow(false)
      else
        local isPlayableGroup = ToClient_IsStartDaySiege2024(value._groupType)
        value._control:SetShow(isPlayableGroup)
        if isPlayableGroup == true then
          if isRecruitmentTime == true then
            if isParticipated == true then
              if value._groupType == currentGroupNo then
                value._btn_applyOrCancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ELFWAR_APPLYCANCLE"))
                value._btn_cantApply:SetShow(false)
                value._btn_applyOrCancel:SetIgnore(false)
              else
                value._btn_applyOrCancel:SetText("")
                value._btn_cantApply:SetShow(true)
                value._btn_applyOrCancel:SetIgnore(true)
              end
            else
              value._btn_applyOrCancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_HORSERACING_MATCH_MATCHING"))
              value._btn_cantApply:SetShow(false)
              value._btn_applyOrCancel:SetIgnore(false)
            end
          else
            value._btn_applyOrCancel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_CANT_APPLY"))
            value._btn_cantApply:SetShow(false)
            value._btn_applyOrCancel:SetIgnore(true)
          end
        end
      end
      local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(value._groupType)
      local day = ToClient_GetDayOfWeekByVillageSiege()
      if siegeOptionStatic ~= nil then
        value._txt_maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_MAXMEMBER", "count", siegeOptionStatic:getLimitMemberCount(day)))
      end
    end
  end
  if isMatched == true then
    local siegeOptionStatic = ToClient_GetSiegeTerritoryOptionStaticStatusWrapper(currentGroupNo)
    local day = ToClient_GetDayOfWeekByVillageSiege()
    if siegeOptionStatic ~= nil then
      self._ui._txt_applyResultMaxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_MAXMEMBER", "count", siegeOptionStatic:getLimitMemberCount(day)))
      if siegeOptionStatic:isUnlimitedDDPV() == true then
        self._ui._txt_applyResultLimit:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_UNLIMITVALUE"))
      else
        local maxDD = siegeOptionStatic._siegeMaxDDForUI
        local maxPV = siegeOptionStatic._siegeMaxPVForUI
        self._ui._txt_applyResultLimit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_LIMITVALUE", "sum", maxDD + maxPV))
      end
      self._ui._txt_applyResultLimit:SetSize(self._ui._txt_applyResultLimit:GetTextSizeX(), self._ui._txt_applyResultLimit:GetSizeY())
      self._ui._txt_applyResultLimit:ComputePos()
    end
    self._ui._stc_applyResult:SetShow(true)
    self._ui._stc_applyResultTerritory:SetShow(true)
    self._ui._stc_applyResult:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. currentGroupNo .. "," .. currentTerritoryRaw .. ")")
    self._ui._stc_applyResult:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    self._ui._btn_applyResultOtherGuild:addInputEvent("Mouse_On", "PaGlobal_VillageSiegeMenu:showFocusGroup(" .. currentGroupNo .. "," .. currentTerritoryRaw .. ")")
    self._ui._btn_applyResultOtherGuild:addInputEvent("Mouse_Out", "PaGlobal_VillageSiegeMenu:showFocusGroup(nil, nil)")
    if currentTerritoryRaw == self._eTerritoryKeyRaw.BALENOS then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Balenos", 0)
    elseif currentTerritoryRaw == self._eTerritoryKeyRaw.SERENDIA then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Serendia", 0)
    elseif currentTerritoryRaw == self._eTerritoryKeyRaw.CALPHEON then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Calpheon", 0)
    elseif currentTerritoryRaw == self._eTerritoryKeyRaw.MEDIA then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Media", 0)
    elseif currentTerritoryRaw == self._eTerritoryKeyRaw.VALENCIA then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Valencia", 0)
    elseif currentTerritoryRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
      self:changeTexture(self._ui._stc_applyResultTerritory, "Combine_Etc_StrongholdWar_Territory_Kamasylvia", 0)
    else
      self._ui._stc_applyResultTerritory:SetShow(false)
    end
  end
end
function PaGlobal_VillageSiegeMenu:refreshApplyListScene()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if self._isConsole == true then
    local keyGuideList = Array.new()
    local selectButton = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
    local exitButton = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
    selectButton:SetShow(false)
    exitButton:SetShow(true)
    keyGuideList:push_back(exitButton)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  end
  self._ui._stc_noData:SetShow(false)
  self._ui._frm_listApply:SetShow(false)
  self._ui._txt_topDate:SetText(self:getCurrentWeekString())
  self._ui._txt_topDateDay:SetText(self:getCurrentDayString())
  local count = ToClient_GetAppliedGuildCountSiege2024()
  if count == 0 then
    self._ui._stc_noData:SetShow(true)
    self._ui._stc_noData:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_APPLYLIST_NODATA"))
    return
  end
  self._ui._frm_listApply:SetShow(true)
  self:clearApplyGroupDataList()
  for index = 0, count - 1 do
    local territoryKeyRaw = ToClient_GetAppliedGuildTerritorySiege2024(index)
    local groupDataIndex = self:findApplyGroupDataIndex(territoryKeyRaw)
    local groupData
    if groupDataIndex == nil then
      groupData = self:makeApplyGroupData("ApplyGroup_", territoryKeyRaw)
      self._applyGroupDataList:push_back(groupData)
    else
      groupData = self._applyGroupDataList[groupDataIndex]
    end
    groupData._group:SetShow(true)
    groupData._flag:SetShow(true)
    groupData._name:SetShow(true)
    groupData._applyGuildCount = groupData._applyGuildCount + 1
    if territoryKeyRaw == self._eTerritoryKeyRaw.BALENOS then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Balenos", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_0"))
    elseif territoryKeyRaw == self._eTerritoryKeyRaw.SERENDIA then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Serendia", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_1"))
    elseif territoryKeyRaw == self._eTerritoryKeyRaw.CALPHEON then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Calpheon", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_2"))
    elseif territoryKeyRaw == self._eTerritoryKeyRaw.MEDIA then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Media", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_3"))
    elseif territoryKeyRaw == self._eTerritoryKeyRaw.VALENCIA then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Valencia", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_4"))
    elseif territoryKeyRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
      self:changeTexture(groupData._flag, "Combine_Etc_StrongholdWar_Territory_Kamasylvia", 0)
      groupData._name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6"))
    else
      groupData._flag:SetShow(false)
      groupData._name:SetShow(false)
    end
    local applyGuildData = groupData._applyGuildList[groupData._applyGuildCount]
    if applyGuildData == nil then
      applyGuildData = self:makeApplyGuildData(groupData._group, "Guild_" .. tostring(groupData._applyGuildCount))
      groupData._applyGuildList:push_back(applyGuildData)
    end
    applyGuildData._control:SetShow(true)
    applyGuildData._mark:SetShow(true)
    applyGuildData._name:SetShow(true)
    applyGuildData._name:SetText(ToClient_GetAppliedGuildNameSiege2024(index))
    applyGuildData._guildNoRaw = ToClient_GetAppliedGuildNoRawSiege2024(index)
    local myGuildNoRaw = getSelfPlayer():getGuildNo_s64()
    if myGuildNoRaw == applyGuildData._guildNoRaw then
      self:changeTexture(applyGuildData._control, "Combine_Etc_StrongholdWar_MyGuild_BG", 0)
      applyGuildData._name:SetFontColor(Defines.Color.C_FFF5BA3A)
    else
      self:changeTexture(applyGuildData._control, "Combine_Etc_StrongholdWar_Guild_BG", 0)
      applyGuildData._name:SetFontColor(Defines.Color.C_FFDDC39E)
    end
  end
  self:refreshApplyFrameSize()
end
function PaGlobal_VillageSiegeMenu:clearApplyGroupDataList()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  if self._applyGroupDataList == nil then
    self._applyGroupDataList = Array.new()
  else
    for key, value in pairs(self._applyGroupDataList) do
      if value ~= nil then
        value._group:SetShow(false)
        for dataKey, dataValue in pairs(value._applyGuildList) do
          if dataValue ~= nil then
            dataValue._control:SetShow(false)
            dataValue._guildNoRaw = nil
          end
        end
        value._applyGuildCount = 0
      end
    end
  end
end
function PaGlobal_VillageSiegeMenu:findApplyGroupDataIndex(territoryKeyRaw)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return nil
  end
  if self._applyGroupDataList == nil then
    return nil
  end
  for key, value in pairs(self._applyGroupDataList) do
    if value ~= nil and value._territoryKeyRaw == territoryKeyRaw then
      return key
    end
  end
  return nil
end
function PaGlobal_VillageSiegeMenu:makeApplyGroupData(name, territoryKeyRaw)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  local groupData = {
    _group = nil,
    _flag = nil,
    _name = nil,
    _territoryKeyRaw = nil,
    _applyGuildCount = nil,
    _applyGuildList = nil
  }
  groupData._group = UI.cloneControl(self._ui._stc_applyGroupTemplate, self._ui._frm_listApply:GetFrameContent(), name .. tostring(territoryKeyRaw))
  groupData._flag = UI.getChildControl(groupData._group, "Static_TerritoryFlag")
  groupData._name = UI.getChildControl(groupData._group, "StaticText_TerritoryName")
  groupData._territoryKeyRaw = territoryKeyRaw
  groupData._applyGuildCount = 0
  groupData._applyGuildList = Array.new()
  return groupData
end
function PaGlobal_VillageSiegeMenu:makeApplyGuildData(parent, name)
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  local guildData = {
    _control = nil,
    _mark = nil,
    _name = nil,
    _guildNoRaw = nil
  }
  guildData._control = UI.cloneControl(self._ui._stc_applyGuildTemplate, parent, name)
  guildData._mark = UI.getChildControl(guildData._control, "Static_GuildMark")
  guildData._name = UI.getChildControl(guildData._control, "StaticText_GuildName")
  guildData._guildNoRaw = nil
  return guildData
end
function PaGlobal_VillageSiegeMenu:refreshApplyFrameSize()
  if Panel_Window_VillageSiegeMenu_All == nil then
    return
  end
  local dataSizeX = self._ui._stc_applyGuildTemplate:GetSizeX()
  local dataSizeY = self._ui._stc_applyGuildTemplate:GetSizeY()
  local dataDefaultSpanX = self._ui._stc_applyGuildTemplate:GetSpanSize().x
  local dataDefaultSpanY = self._ui._stc_applyGuildTemplate:GetSpanSize().y
  local dataTermX = 5
  local dataTermY = 5
  local dataRowCountMax = math.floor((self._ui._stc_applyGroupTemplate:GetSizeX() - dataDefaultSpanX) / self._ui._stc_applyGuildTemplate:GetSizeX())
  local groupDefaultSizeY = self._ui._stc_applyGroupTemplate:GetSizeY()
  local groupSpanY = 0
  local groupSizeY = 0
  for key, value in pairs(self._applyGroupDataList) do
    if value ~= nil and value._group:GetShow() == true then
      local showDataCount = 0
      local dataColIndex = 0
      local dataSpanY = 0
      for dataKey, dataValue in pairs(value._applyGuildList) do
        if dataValue ~= nil and dataValue._control:GetShow() == true then
          if dataRowCountMax <= showDataCount then
            showDataCount = 0
            dataColIndex = dataColIndex + 1
          end
          local dataSpanX = dataDefaultSpanX + showDataCount * dataSizeX + dataTermX * (showDataCount + 1)
          dataSpanY = dataDefaultSpanY + dataColIndex * dataSizeY + dataTermY * (dataColIndex + 1)
          dataValue._control:SetSpanSize(dataSpanX, dataSpanY)
          dataValue._control:ComputePos()
          showDataCount = showDataCount + 1
        end
      end
      groupSpanY = groupSpanY + groupSizeY + dataTermY
      value._group:SetSpanSize(value._group:GetSpanSize().x, groupSpanY)
      groupSizeY = dataSpanY + dataSizeY + dataTermY
      if groupDefaultSizeY > groupSizeY then
        groupSizeY = groupDefaultSizeY
      end
      value._group:SetSize(value._group:GetSizeX(), groupSizeY)
      value._group:ComputePos()
    end
  end
  local frameContent = self._ui._frm_listApply:GetFrameContent()
  frameContent:SetSize(frameContent:GetSizeX(), groupSpanY + groupSizeY)
  local frameScroll = self._ui._frm_listApply:GetVScroll()
  frameScroll:SetControlPos(0)
  self._ui._frm_listApply:UpdateContentPos()
  if self._ui._frm_listApply:GetSizeY() < frameContent:GetSizeY() then
    frameScroll:SetShow(true)
  else
    frameScroll:SetShow(false)
  end
end
