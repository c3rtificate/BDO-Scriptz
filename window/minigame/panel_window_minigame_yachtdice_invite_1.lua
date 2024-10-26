function PaGlobal_YachtDice_Invite:initialize()
  if true == PaGlobal_YachtDice_Invite._initialize then
    return
  end
  self._isConsole = true == ToClient_isConsole()
  self._isPadMode = true == self._isConsole or true == _ContentsGroup_UsePadSnapping
  local firstGameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByIndex(self._gameBoardInitIndex)
  if nil ~= firstGameBoardSSW then
    self._selectedGameBoardKey = firstGameBoardSSW:getKey()
  end
  if true == self._isPadMode then
    self:initializeConsoleKeyGuides()
  end
  self:initializeSelectArea()
  self:initializeButton()
  self:initializeMainBoardArea()
  self:initializeInputArea()
  self._defaultSearchText = self._ui._edt_searchText:GetText()
  self:updateMainBoardArea()
  self:refreshArrowControl(0)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_YachtDice_Invite:initializeSelectArea()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  self._gameBoardIconTotalCount = ToClient_getYachtGameBoardDataCount()
  local originalRadioButton = UI.getChildControl(self._ui._stc_selectArea, "RadioButton_1")
  for index = 0, self._gameBoardIconTotalCount - 1 do
    local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByIndex(index)
    if nil ~= gameBoardSSW then
      do
        local gameBoardIconData = {
          button = nil,
          buttonInitX = nil,
          gameBoardKey = gameBoardSSW:getKey()
        }
        function gameBoardIconData:moveLeft()
          gameBoardIconData.button:SetPosX(gameBoardIconData.button:GetPosX() - gameBoardIconData.button:GetSizeX() - 10)
        end
        function gameBoardIconData:moveRight()
          gameBoardIconData.button:SetPosX(gameBoardIconData.button:GetPosX() + gameBoardIconData.button:GetSizeX() + 10)
        end
        function gameBoardIconData:resetPosX()
          if nil ~= gameBoardIconData.buttonInitX then
            gameBoardIconData.button:SetPosX(gameBoardIconData.buttonInitX)
          end
        end
        gameBoardIconData.button = UI.cloneControl(originalRadioButton, self._ui._stc_selectArea, "GameBoard_RadioButton_Clone_" .. tostring(gameBoardIconData.gameBoardKey:get()))
        if index > 0 then
          local beforeIcon = self._gameBoardIconList[index - 1].button
          local initPosX = beforeIcon:GetPosX() + beforeIcon:GetSizeX() + 10
          gameBoardIconData.button:SetPosX(initPosX)
          gameBoardIconData.buttonInitX = initPosX
        end
        gameBoardIconData.button:ChangeTextureInfoTextureIDAsync(gameBoardSSW:getIconNormalTextureId(), 0)
        gameBoardIconData.button:ChangeTextureInfoTextureIDAsync(gameBoardSSW:getIconOverTextureId(), 1)
        gameBoardIconData.button:ChangeTextureInfoTextureIDAsync(gameBoardSSW:getIconClickTextureId(), 2)
        gameBoardIconData.button:setRenderTexture(gameBoardIconData.button:getBaseTexture())
        gameBoardIconData.button:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Invite_OnClickedRadioButton(" .. tostring(Int64toInt32(gameBoardIconData.gameBoardKey:get())) .. ")")
        local starParent = UI.getChildControl(gameBoardIconData.button, "Static_Stars")
        local maxlevel = gameBoardSSW:getLevel()
        if maxlevel > 0 then
          for levelIndex = 1, maxlevel do
            local starBg = UI.getChildControl(starParent, "Static_Star_Bg_" .. tostring(levelIndex))
            local starControl = UI.getChildControl(starBg, "Static_Star_On_" .. tostring(levelIndex))
            starControl:SetShow(true)
          end
        end
        if self._selectedGameBoardKey:get() == gameBoardIconData.gameBoardKey:get() then
          gameBoardIconData.button:SetCheck(true)
        end
        self._gameBoardIconList[index] = gameBoardIconData
      end
    end
  end
  for index = 0, self._gameBoardIconTotalCount - 1 do
    if index < self._gameBoardIconShowCountMax then
      self._gameBoardIconList[index].button:SetShow(true)
    else
      self._gameBoardIconList[index].button:SetShow(false)
    end
  end
  self._currentLeftIconIndex = 0
  self._ui._btn_left = UI.getChildControl(self._ui._stc_selectArea, "Button_TurnLeft")
  self._ui._btn_right = UI.getChildControl(self._ui._stc_selectArea, "Button_TurnRight")
  if true == self._isPadMode then
    self._ui._btn_left:SetShow(false)
    self._ui._btn_right:SetShow(false)
    self._ui._console_keyGuideLB:SetShow(false)
    if self._gameBoardIconShowCountMax < self._gameBoardIconTotalCount then
      self._ui._console_keyGuideRB:SetShow(true)
    end
  else
    self._ui._btn_left:SetShow(false)
    if self._gameBoardIconShowCountMax < self._gameBoardIconTotalCount then
      self._ui._btn_right:SetShow(true)
    end
    self._ui._btn_left:addInputEvent("Mouse_LUp", "PaGlobal_YachtDice_Invite:moveLeftGameBoardIcon()")
    self._ui._btn_right:addInputEvent("Mouse_LUp", "PaGlobal_YachtDice_Invite:moveRightGameBoardIcon()")
  end
end
function PaGlobal_YachtDice_Invite:refreshArrowControl(leftIndex)
  if nil == leftIndex then
    return
  end
  self._currentLeftIconIndex = leftIndex
  local leftBtn, rightBtn
  if true == self._isPadMode then
    leftBtn = self._ui._console_keyGuideLB
    rightBtn = self._ui._console_keyGuideRB
  else
    leftBtn = self._ui._btn_left
    rightBtn = self._ui._btn_right
  end
  if self._currentLeftIconIndex > 0 then
    leftBtn:SetShow(true)
  else
    leftBtn:SetShow(false)
  end
  if self._currentLeftIconIndex < self._gameBoardIconTotalCount - self._gameBoardIconShowCountMax then
    rightBtn:SetShow(true)
  else
    rightBtn:SetShow(false)
  end
end
function PaGlobal_YachtDice_Invite:moveLeftGameBoardIcon()
  if 0 == self._currentLeftIconIndex then
    return
  end
  local beforeLeftIndex = self._currentLeftIconIndex
  self:refreshArrowControl(beforeLeftIndex - 1)
  for index = 0, self._gameBoardIconTotalCount - 1 do
    if index < self._currentLeftIconIndex then
      self._gameBoardIconList[index].button:SetShow(false)
    elseif index > self._currentLeftIconIndex + (self._gameBoardIconShowCountMax - 1) then
      self._gameBoardIconList[index].button:SetShow(false)
    else
      self._gameBoardIconList[index].button:SetShow(true)
    end
    self._gameBoardIconList[index]:moveRight()
  end
end
function PaGlobal_YachtDice_Invite:moveRightGameBoardIcon()
  if self._gameBoardIconTotalCount - 1 < self._currentLeftIconIndex + self._gameBoardIconShowCountMax then
    return
  end
  local beforeLeftIndex = self._currentLeftIconIndex
  self:refreshArrowControl(beforeLeftIndex + 1)
  for index = 0, self._gameBoardIconTotalCount - 1 do
    if index < self._currentLeftIconIndex then
      self._gameBoardIconList[index].button:SetShow(false)
    elseif index > self._currentLeftIconIndex + (self._gameBoardIconShowCountMax - 1) then
      self._gameBoardIconList[index].button:SetShow(false)
    else
      self._gameBoardIconList[index].button:SetShow(true)
    end
    local posX = self._gameBoardIconList[index].button:GetPosX()
    self._gameBoardIconList[index]:moveLeft()
  end
end
function PaGlobal_YachtDice_Invite:initializeButton()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if true == self._isPadMode then
    self._ui._btn_close:SetShow(false)
  else
    self._ui._btn_close:SetShow(true)
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Invite_Close()")
  end
  if true == self._isPadMode then
    self._ui._btn_invite:SetShow(false)
  else
    self._ui._btn_invite:SetShow(true)
    self._ui._btn_invite:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Invite_OnClickedInviteButton()")
  end
end
function PaGlobal_YachtDice_Invite:initializeMainBoardArea()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  self._ui._stc_mainBoard = UI.getChildControl(self._ui._stc_mainBoardArea, "Static_Board_Menu")
  self._ui._lst_handRankList = UI.getChildControl(self._ui._stc_mainBoardArea, "List2_1")
  self._ui._lst_handRankList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_MiniGameYacht_Invite_CreateListContent")
  self._ui._lst_handRankList:createChildContent(__ePAUIList2ElementManagerType_List)
  local listManager = self._ui._lst_handRankList:getElementManager()
  if nil == listManager then
    UI.ASSERT_NAME(false, "\236\149\188\235\165\180 \236\161\177\235\179\180 \236\139\160\236\178\173 UI\236\157\152 UIList2 Manager\234\176\128 nullptr\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\237\149\152\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164. \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  listManager:clearKey()
  local handRankTotalCount = ToClient_getYachtHandRankDataCount()
  for index = 0, handRankTotalCount - 1 do
    local handRankSSW = ToClient_getYachtHandRankStaticStatusWrapperByIndex(index)
    if nil ~= handRankSSW then
      local handRankKey = handRankSSW:getKey()
      listManager:pushKey(toInt64(0, handRankKey:get()))
    end
  end
end
function PaGlobal_YachtDice_Invite:createListContent(content, key)
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  local stc_title = UI.getChildControl(content, "Static_Title")
  local txt_name = UI.getChildControl(stc_title, "StaticText_Dice")
  local txt_desc = UI.getChildControl(content, "StaticText_Dice_Desc")
  local handRankKey = YachtHandRankKey(Int64toInt32(key))
  local handRankSSW = ToClient_getHandRankStaticStatusWrapper(handRankKey)
  if nil == handRankSSW then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(handRankSSW:getName())
  txt_name:ChangeTextureInfoTextureIDKey(handRankSSW:getIconTextureName())
  txt_name:setRenderTexture(txt_name:getBaseTexture())
  txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_desc:setLineCountByLimitAutoWrap(3)
  txt_desc:SetText(handRankSSW:getDesc())
  if true == txt_desc:IsLimitText() then
    content:SetIgnore(false)
    content:addInputEvent("Mouse_On", "PaGlobal_YachtDice_Invite:showSimpleDescToolTip(true," .. tostring(key) .. ")")
    content:addInputEvent("Mouse_Out", "PaGlobal_YachtDice_Invite:showSimpleDescToolTip(false," .. tostring(key) .. ")")
  else
    content:SetIgnore(true)
    content:addInputEvent("Mouse_On", "")
    content:addInputEvent("Mouse_Out", "")
  end
  if nil ~= self._selectedGameBoardKey then
    local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByKey(self._selectedGameBoardKey)
    if nil ~= gameBoardSSW and true == gameBoardSSW:isHaveHandRankKey(handRankKey) then
      content:setRenderTexture(content:getOnTexture())
    else
      content:setRenderTexture(content:getBaseTexture())
    end
  else
    content:setRenderTexture(content:getBaseTexture())
  end
end
function PaGlobal_YachtDice_Invite:showSimpleDescToolTip(isShow, listItemKey)
  if true == isShow then
    local control = self._ui._lst_handRankList:GetContentByKey(listItemKey)
    if nil ~= control then
      local handRankKey = YachtHandRankKey(Int64toInt32(listItemKey))
      local handRankSSW = ToClient_getHandRankStaticStatusWrapper(handRankKey)
      if nil == handRankSSW then
        return
      end
      TooltipSimple_Show(control, handRankSSW:getDesc(), "")
    end
  else
    TooltipSimple_Hide()
    if nil ~= self._selectedGameBoardKey then
      local content = self._ui._lst_handRankList:GetContentByKey(listItemKey)
      local handRankKey = YachtHandRankKey(Int64toInt32(listItemKey))
      local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByKey(self._selectedGameBoardKey)
      if nil ~= gameBoardSSW and true == gameBoardSSW:isHaveHandRankKey(handRankKey) then
        content:setRenderTexture(content:getOnTexture())
      else
        content:setRenderTexture(content:getBaseTexture())
      end
    end
  end
end
function PaGlobal_YachtDice_Invite:initializeInputArea()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  self._ui._edt_searchText = UI.getChildControl(self._ui._stc_inputArea, "Edit_Search_Txt")
  self._ui._edt_searchText:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Invite_OnClickedEditBox()")
  if true == self._isPadMode then
  end
end
function PaGlobal_YachtDice_Invite:initializeConsoleKeyGuides()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if false == self._isPadMode then
    return
  end
  self._ui._console_keyGuideX = UI.getChildControl(self._ui._stc_inputArea, "Static_Console_KeyGuide_X")
  self._ui._console_keyGuideX:SetShow(true)
  local parent = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Console_KeyGuide_RB_LB")
  parent:SetShow(true)
  self._ui._console_keyGuideLB = UI.getChildControl(parent, "Static_LB")
  self._ui._console_keyGuideRB = UI.getChildControl(parent, "Static_RB")
  self._ui._console_keyGuideLB:SetShow(true)
  self._ui._console_keyGuideRB:SetShow(true)
  local bottom_keyGuides = UI.getChildControl(Panel_Window_MiniGame_YachtDice_PVP_Invite, "Static_Invite_ConsoleUI")
  bottom_keyGuides:SetShow(true)
  self._ui._console_keyGuideRS = UI.getChildControl(bottom_keyGuides, "StaticText_Console_KeyGuide_RS")
  self._ui._console_keyGuideY = UI.getChildControl(bottom_keyGuides, "StaticText_Console_KeyGuide_Y")
  self._ui._console_keyGuideB = UI.getChildControl(bottom_keyGuides, "StaticText_Console_KeyGuide_B")
  self._ui._console_keyGuideRS:SetShow(true)
  self._ui._console_keyGuideY:SetShow(true)
  self._ui._console_keyGuideB:SetShow(true)
  local keyGuides = {
    self._ui._console_keyGuideRS,
    self._ui._console_keyGuideY,
    self._ui._console_keyGuideB
  }
  for index = 1, #keyGuides do
    keyGuides[index]:SetShow(true)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, bottom_keyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_YachtDice_Invite:registEventHandler()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if true == self._isConsole then
    registerEvent("FromClient_responseYachtDiceBattle", "PaGlobal_YachtDice_Invite_SetChangeMode_AcceptMode")
    registerEvent("FromClient_responseCanceledYachtDiceBattleRequest", "PaGlobal_YachtDice_Invite_SetChangeMode_InviteMode")
  end
  if true == self._isPadMode then
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_YachtDice_Invite:moveLeftGameBoardIcon()")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_YachtDice_Invite:moveRightGameBoardIcon()")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_MiniGameYacht_Invite_OnClickedEditBox()")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MiniGameYacht_Invite_OnClickedInviteButton()")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_MiniGameYacht_Invite_Close()")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobalFunc_MiniGameYacht_Invite_MoveScroll(1)")
    Panel_Window_MiniGame_YachtDice_PVP_Invite:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobalFunc_MiniGameYacht_Invite_MoveScroll(-1)")
  end
  registerEvent("FromClient_SuccessInviteYatchDiceGame", "FromClient_SuccessInviteYatchDiceGame")
end
function PaGlobal_YachtDice_Invite:validate()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  self._ui._stc_mainBg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_selectArea:isValidate()
  self._ui._btn_left:isValidate()
  self._ui._btn_right:isValidate()
  self._ui._stc_mainBoardArea:isValidate()
  self._ui._stc_mainBoard:isValidate()
  self._ui._lst_handRankList:isValidate()
  self._ui._stc_inputArea:isValidate()
  self._ui._edt_searchText:isValidate()
  self._ui._btn_invite:isValidate()
  if true == self._isPadMode then
    self._ui._console_keyGuideX:isValidate()
    self._ui._console_keyGuideLB:isValidate()
    self._ui._console_keyGuideRB:isValidate()
    self._ui._console_keyGuideRS:isValidate()
    self._ui._console_keyGuideY:isValidate()
    self._ui._console_keyGuideB:isValidate()
  end
end
function PaGlobal_YachtDice_Invite:prepareOpen(userNickname)
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if userNickname ~= nil then
    self._ui._edt_searchText:SetEditText(userNickname)
  end
  self:resizeBg()
  self:open()
end
function PaGlobal_YachtDice_Invite:open()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  Panel_Window_MiniGame_YachtDice_PVP_Invite:RegisterUpdateFunc("PaGlobalFunc_MiniGameYacht_Invite_Update")
  Panel_Window_MiniGame_YachtDice_PVP_Invite:SetShow(true)
end
function PaGlobal_YachtDice_Invite:prepareClose()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  local firstGameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByIndex(self._gameBoardInitIndex)
  if nil ~= firstGameBoardSSW then
    self:setSelectedGameBoardKey(firstGameBoardSSW:getKey():get())
  end
  for index = 0, self._gameBoardIconTotalCount - 1 do
    if self._gameBoardInitIndex == index then
      self._gameBoardIconList[index].button:SetCheck(true)
    else
      self._gameBoardIconList[index].button:SetCheck(false)
    end
    if index < self._gameBoardIconShowCountMax then
      self._gameBoardIconList[index].button:SetShow(true)
    else
      self._gameBoardIconList[index].button:SetShow(false)
    end
    self._gameBoardIconList[index]:resetPosX()
  end
  self:refreshArrowControl(0)
  Panel_Window_MiniGame_YachtDice_PVP_Invite:ClearUpdateLuaFunc()
  self:clearEditText()
  self:close()
end
function PaGlobal_YachtDice_Invite:close()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  Panel_Window_MiniGame_YachtDice_PVP_Invite:SetShow(false)
end
function PaGlobal_YachtDice_Invite:resizeBg()
  local panel = Panel_Window_MiniGame_YachtDice_PVP_Invite
  if nil == panel then
    return
  end
  local offset = 10
  self._ui._stc_mainBg:SetPosX(-offset)
  self._ui._stc_mainBg:SetSize(getScreenSizeX() + offset, self._ui._stc_mainBg:GetSizeY())
  self._ui._stc_mainBg:ComputePos()
end
function PaGlobal_YachtDice_Invite:update(deltaTime)
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if true == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) and "" == self._ui._edt_searchText:GetEditText() then
    self:clearEditText()
  end
end
function PaGlobal_YachtDice_Invite:clearEditText()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  self._ui._edt_searchText:SetEditText("")
  self._ui._edt_searchText:SetText(self._defaultSearchText)
end
function PaGlobal_YachtDice_Invite:onClickedEditBox()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if true == self._isPadMode then
    SetFocusEdit(self._ui._edt_searchText)
  end
  if self._ui._edt_searchText:GetText() == self._defaultSearchText then
    self._ui._edt_searchText:SetText("")
  end
end
function PaGlobal_YachtDice_Invite:setSelectedGameBoardKey(keyRaw)
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  local newKey = YachtGameBoardKey(keyRaw)
  if self._selectedGameBoardKey ~= newKey then
    self._selectedGameBoardKey = newKey
    self:updateMainBoardArea()
  end
end
function PaGlobal_YachtDice_Invite:updateMainBoardArea()
  if nil == self._selectedGameBoardKey then
    return
  end
  self:refreshMainBoardDesc()
  self:refreshHandRankList()
end
function PaGlobal_YachtDice_Invite:refreshMainBoardDesc()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if nil == self._selectedGameBoardKey then
    return
  end
  local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByKey(self._selectedGameBoardKey)
  if nil == gameBoardSSW then
    return
  end
  local txt_desc = UI.getChildControl(self._ui._stc_mainBoard, "StaticText_Board_Desc")
  local stc_stars = UI.getChildControl(self._ui._stc_mainBoard, "Static_Big_Stars")
  txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_desc:setLineCountByLimitAutoWrap(3)
  txt_desc:SetText(gameBoardSSW:getDesc())
  self._ui._stc_mainBoard:ChangeTextureInfoTextureIDAsync(gameBoardSSW:getBigTextureId(), 0)
  self._ui._stc_mainBoard:setRenderTexture(self._ui._stc_mainBoard:getBaseTexture())
  local maxlevel = gameBoardSSW:getLevel()
  for starIndex = 1, 5 do
    local starBg = UI.getChildControl(stc_stars, "Static_Big_Star_Bg_" .. tostring(starIndex))
    local starControl = UI.getChildControl(starBg, "static_Big_Star_On_" .. tostring(starIndex))
    if starIndex <= maxlevel then
      starControl:SetShow(true)
    else
      starControl:SetShow(false)
    end
  end
end
function PaGlobal_YachtDice_Invite:refreshHandRankList()
  if nil == Panel_Window_MiniGame_YachtDice_PVP_Invite then
    return
  end
  if nil == self._selectedGameBoardKey then
    self:initializeMainBoardArea()
    return
  end
  local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByKey(self._selectedGameBoardKey)
  if nil == gameBoardSSW then
    return
  end
  local selectedHandRankCount = gameBoardSSW:getHandRankCount()
  local listManager = self._ui._lst_handRankList:getElementManager()
  if nil == listManager then
    UI.ASSERT_NAME(false, "\236\149\188\235\165\180 \236\161\177\235\179\180 \236\139\160\236\178\173 UI\236\157\152 UIList2 Manager\234\176\128 nullptr\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\237\149\152\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164. \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  listManager:clearKey()
  for index = 0, selectedHandRankCount - 1 do
    local handRankSSW = gameBoardSSW:getHandRankStaticStatusWrapper(index)
    if nil ~= handRankSSW then
      local handRankKey = handRankSSW:getKey()
      listManager:pushKey(toInt64(0, handRankKey:get()))
    end
  end
  local handRankTotalCount = ToClient_getYachtHandRankDataCount()
  for index = 0, handRankTotalCount - 1 do
    local handRankSSW = ToClient_getYachtHandRankStaticStatusWrapperByIndex(index)
    if nil ~= handRankSSW then
      local handRankKey = handRankSSW:getKey()
      if false == gameBoardSSW:isHaveHandRankKey(handRankKey) then
        listManager:pushKey(toInt64(0, handRankKey:get()))
      end
    end
  end
end
