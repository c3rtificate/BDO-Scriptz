function PaGlobal_LocalWarInfo_All_New:initialize()
  if true == self._initialize then
    return
  end
  PaGlobal_LocalWarInfo_All_New:controlAll_Init()
  PaGlobal_LocalWarInfo_All_New:controlPc_Init()
  PaGlobal_LocalWarInfo_All_New:controlConsole_Init()
  PaGlobal_LocalWarInfo_All_New:controlSetShow()
  PaGlobal_LocalWarInfo_All_New:registEventHandler()
  PaGlobal_LocalWarInfo_All_New:validate()
  PaGlobal_LocalWarInfo_All_New:setDescriptionString(false)
  FromClient_LocalWarInfo_All_ResizePanel()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._isOccupationDesc = _ContentsGroup_LocalWarOccupation
  self._initialize = true
end
function PaGlobal_LocalWarInfo_All_New:controlAll_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui._stc_titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui._stc_leftBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_LeftBG")
  local subTitleBg = UI.getChildControl(self._ui._stc_leftBG, "Static_SubTitleGroup")
  self._ui._list2_serverList = UI.getChildControl(subTitleBg, "List2_ServerList")
  self._ui._stc_banner = UI.getChildControl(self._ui._stc_leftBG, "Static_EventBanner")
  self._ui._stc_banner:SetShow(_ContentsGroup_LocalWarPapuCrio)
  self._ui._stc_picTooltip = UI.getChildControl(Panel_LocalWarInfo_All, "Static_PictureTooltip")
  local eventDate = UI.getChildControl(self._ui._stc_banner, "StaticText_Date")
  if false == isGameTypeKorea() then
    eventDate:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TERMIAN_PVSC_DATE_GLOBAL"))
  end
  self._ui._frame_desc = UI.getChildControl(Panel_LocalWarInfo_All, "Frame_Description")
  local content = self._ui._frame_desc:GetFrameContent()
  local vScroll = self._ui._frame_desc:GetVScroll()
  self._ui._rule._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Rule")
  self._ui._rule._stc_background = UI.getChildControl(content, "Static_BG_1")
  for index = 1, self._ruleCount do
    self._ui._rule._txt_content[index - 1] = UI.getChildControl(self._ui._rule._stc_background, "StaticText_Desc_Rule_" .. tostring(index))
  end
  self._ui._reward._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Reward")
  self._ui._reward._stc_background = UI.getChildControl(content, "Static_BG_2")
  for index = 1, self._rewardCount do
    self._ui._reward._txt_content[index - 1] = UI.getChildControl(self._ui._reward._stc_background, "StaticText_Desc_Reward_" .. tostring(index))
  end
  self._ui._explanation._txt_title = UI.getChildControl(content, "StaticText_LocalWar_Explanation")
  self._ui._explanation._stc_background = UI.getChildControl(content, "Static_BG_3")
  for index = 1, self._explanationCount do
    self._ui._explanation._txt_content[index - 1] = UI.getChildControl(self._ui._explanation._stc_background, "StaticText_Desc_Explanation_" .. tostring(index))
  end
  if false == _ContentsGroup_LocalWarPapuCrio then
    Panel_LocalWarInfo_All:SetSize(Panel_LocalWarInfo_All:GetSizeX(), 510)
    self._ui._stc_leftBG:SetSize(self._ui._stc_leftBG:GetSizeX(), 460)
    subTitleBg:SetSize(subTitleBg:GetSizeX(), 50)
    subTitleBg:SetSpanSize(0, 0)
    self._ui._list2_serverList:SetSize(self._ui._list2_serverList:GetSizeX(), 400)
  end
end
function PaGlobal_LocalWarInfo_All_New:controlMapList_Init()
  PaGlobal_LocalWarInfo_All_New:setInstanceRoomList()
  self._ui._list2_serverList:createChildContent(__ePAUIList2ElementManagerType_Tree)
  self._ui._list2_serverList:changeAnimationSpeed(11)
  self._ui._list2_serverList:getElementManager():clearKey()
  local mainElement = self._ui._list2_serverList:getElementManager():getMainElement()
  self._treeMainIndex = 1
  self._treeKeyIndex = 1
  self._treeMapTable = Array.new()
  self._mapList._COUNT = 0
  PaGlobal_LocalWarInfo_All_New:addPapuCrio()
  PaGlobal_LocalWarInfo_All_New:addOccupation()
  PaGlobal_LocalWarInfo_All_New:addNormal()
  PaGlobal_LocalWarInfo_All_New:addGamos()
end
function PaGlobal_LocalWarInfo_All_New:addPapuCrio()
  if false == _ContentsGroup_LocalWarPapuCrio then
    return
  end
  self._mapList._COUNT = self._mapList._COUNT + 1
  local mapName = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_3")
  self._treeMapTable[self._treeKeyIndex] = {
    _isMain = true,
    _keyIndex = self._treeKeyIndex,
    _mapInfo = nil,
    _string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERLIST_TAP", "name", mapName),
    _mapKey = self._eMapKeyIndex._PAPUCRIO
  }
  local treeElement = self._ui._list2_serverList:getElementManager():getMainElement():createChild(toInt64(0, self._treeKeyIndex))
  treeElement:setIsOpen(false)
  self._treeKeyIndex = self._treeKeyIndex + 1
  for subIndex = 1, #self._mapList._PAPUCRIO do
    local subTreeElement = treeElement:createChild(toInt64(0, self._treeKeyIndex))
    self._treeMapTable[self._treeKeyIndex] = {
      _isMain = false,
      _keyIndex = self._treeKeyIndex,
      _mapInfo = self._mapList._PAPUCRIO[subIndex],
      _string = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_3"),
      _mapKey = self._eMapKeyIndex._PAPUCRIO,
      _subIndex = subIndex - 1
    }
    self._treeKeyIndex = self._treeKeyIndex + 1
  end
  self._treeMainIndex = self._treeMainIndex + 1
end
function PaGlobal_LocalWarInfo_All_New:addOccupation()
  if false == _ContentsGroup_LocalWarOccupation then
    return
  end
  self._mapList._COUNT = self._mapList._COUNT + 1
  local mapName = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_2")
  self._treeMapTable[self._treeKeyIndex] = {
    _isMain = true,
    _keyIndex = self._treeKeyIndex,
    _mapInfo = nil,
    _string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERLIST_TAP", "name", mapName),
    _mapKey = self._eMapKeyIndex._OCCUPATION
  }
  local treeElement = self._ui._list2_serverList:getElementManager():getMainElement():createChild(toInt64(0, self._treeKeyIndex))
  treeElement:setIsOpen(false)
  self._treeKeyIndex = self._treeKeyIndex + 1
  for subIndex = 1, #self._mapList._OCCUPATION do
    local subTreeElement = treeElement:createChild(toInt64(0, self._treeKeyIndex))
    self._treeMapTable[self._treeKeyIndex] = {
      _isMain = false,
      _keyIndex = self._treeKeyIndex,
      _mapInfo = self._mapList._OCCUPATION[subIndex],
      _string = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_2"),
      _mapKey = self._eMapKeyIndex._OCCUPATION,
      _subIndex = subIndex - 1
    }
    self._treeKeyIndex = self._treeKeyIndex + 1
  end
  self._treeMainIndex = self._treeMainIndex + 1
end
function PaGlobal_LocalWarInfo_All_New:addGamos()
  if false == ToClient_IsContentsGroupOpen("709") then
    return
  end
  self._mapList._COUNT = self._mapList._COUNT + 1
  local mapName = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_1")
  self._treeMapTable[self._treeKeyIndex] = {
    _isMain = true,
    _keyIndex = self._treeKeyIndex,
    _mapInfo = nil,
    _string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERLIST_TAP", "name", mapName),
    _mapKey = self._eMapKeyIndex._GAMOSNEST
  }
  local treeElement = self._ui._list2_serverList:getElementManager():getMainElement():createChild(toInt64(0, self._treeKeyIndex))
  treeElement:setIsOpen(false)
  self._treeKeyIndex = self._treeKeyIndex + 1
  for subIndex = 1, #self._mapList._GAMOSNEST do
    local subTreeElement = treeElement:createChild(toInt64(0, self._treeKeyIndex))
    self._treeMapTable[self._treeKeyIndex] = {
      _isMain = false,
      _keyIndex = self._treeKeyIndex,
      _mapInfo = self._mapList._GAMOSNEST[subIndex],
      _string = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_1"),
      _mapKey = self._eMapKeyIndex._GAMOSNEST,
      _subIndex = subIndex - 1
    }
    self._treeKeyIndex = self._treeKeyIndex + 1
  end
  self._treeMainIndex = self._treeMainIndex + 1
end
function PaGlobal_LocalWarInfo_All_New:addNormal()
  self._mapList._COUNT = self._mapList._COUNT + 1
  local mapName = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_0")
  self._treeMapTable[self._treeKeyIndex] = {
    _isMain = true,
    _keyIndex = self._treeKeyIndex,
    _mapInfo = nil,
    _string = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERLIST_TAP", "name", mapName),
    _mapKey = self._eMapKeyIndex._NORMAL
  }
  local treeElement = self._ui._list2_serverList:getElementManager():getMainElement():createChild(toInt64(0, self._treeKeyIndex))
  treeElement:setIsOpen(false)
  self._treeKeyIndex = self._treeKeyIndex + 1
  for subIndex = 1, #self._mapList._NORMAL do
    local subTreeElement = treeElement:createChild(toInt64(0, self._treeKeyIndex))
    self._treeMapTable[self._treeKeyIndex] = {
      _isMain = false,
      _keyIndex = self._treeKeyIndex,
      _mapInfo = self._mapList._NORMAL[subIndex],
      _string = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_MAP_0"),
      _mapKey = self._eMapKeyIndex._NORMAL,
      _subIndex = subIndex - 1
    }
    self._treeKeyIndex = self._treeKeyIndex + 1
  end
  self._treeMainIndex = self._treeMainIndex + 1
end
function PaGlobal_LocalWarInfo_All_New:setInstanceRoomList()
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_LocalWar)
  self._mapList._NORMAL = Array.new()
  self._mapList._GAMOSNEST = Array.new()
  self._mapList._OCCUPATION = Array.new()
  self._mapList._PAPUCRIO = Array.new()
  for index = 0, roomCount - 1 do
    local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_LocalWar, index)
    if nil == roomInfoWrapper then
      return
    end
    local currentFieldMapKey = roomInfoWrapper:getFieldMapKey()
    local isSeasonOnly = ToClient_isSeasonLocalWar(currentFieldMapKey)
    local isDisableCamouflage = ToClient_isDisableCamouflageLocalWar(currentFieldMapKey)
    if true == isSeasonOnly and false == isDisableCamouflage then
      local tempTable = {_index = index, _mapKey = currentFieldMapKey}
      if self._eMapKeyIndex._PAPUCRIO == currentFieldMapKey then
        self._mapList._PAPUCRIO:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONNORMAL == currentFieldMapKey then
        self._mapList._NORMAL:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONGAMOSE == currentFieldMapKey then
        self._mapList._GAMOSNEST:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONOCCUPATION == currentFieldMapKey then
        self._mapList._OCCUPATION:push_back(tempTable)
      end
    end
  end
  for index = 0, roomCount - 1 do
    local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_LocalWar, index)
    if nil == roomInfoWrapper then
      return
    end
    local currentFieldMapKey = roomInfoWrapper:getFieldMapKey()
    local isSeasonOnly = ToClient_isSeasonLocalWar(currentFieldMapKey)
    local isDisableCamouflage = ToClient_isDisableCamouflageLocalWar(currentFieldMapKey)
    if false == isSeasonOnly and false == isDisableCamouflage then
      local tempTable = {_index = index, _mapKey = currentFieldMapKey}
      if self._eMapKeyIndex._PAPUCRIO == currentFieldMapKey then
        self._mapList._PAPUCRIO:push_back(tempTable)
      elseif self._eMapKeyIndex._NORMAL == currentFieldMapKey then
        self._mapList._NORMAL:push_back(tempTable)
      elseif self._eMapKeyIndex._GAMOSNEST == currentFieldMapKey then
        self._mapList._GAMOSNEST:push_back(tempTable)
      elseif self._eMapKeyIndex._OCCUPATION == currentFieldMapKey then
        self._mapList._OCCUPATION:push_back(tempTable)
      end
    end
  end
  for index = 0, roomCount - 1 do
    local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_LocalWar, index)
    if nil == roomInfoWrapper then
      return
    end
    local currentFieldMapKey = roomInfoWrapper:getFieldMapKey()
    local isSeasonOnly = ToClient_isSeasonLocalWar(currentFieldMapKey)
    local isDisableCamouflage = ToClient_isDisableCamouflageLocalWar(currentFieldMapKey)
    if true == isSeasonOnly and true == isDisableCamouflage then
      local tempTable = {_index = index, _mapKey = currentFieldMapKey}
      if self._eMapKeyIndex._PAPUCRIO == currentFieldMapKey then
        self._mapList._PAPUCRIO:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONDISABLECAMONORMAL == currentFieldMapKey then
        self._mapList._NORMAL:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONDISABLECAMOGAMOSE == currentFieldMapKey then
        self._mapList._GAMOSNEST:push_back(tempTable)
      elseif self._eMapKeyIndex._SEASONDISABLEOCCUPATION == currentFieldMapKey then
        self._mapList._OCCUPATION:push_back(tempTable)
      end
    end
  end
  for index = 0, roomCount - 1 do
    local roomInfoWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_LocalWar, index)
    if nil == roomInfoWrapper then
      return
    end
    local currentFieldMapKey = roomInfoWrapper:getFieldMapKey()
    local isSeasonOnly = ToClient_isSeasonLocalWar(currentFieldMapKey)
    local isDisableCamouflage = ToClient_isDisableCamouflageLocalWar(currentFieldMapKey)
    if false == isSeasonOnly and true == isDisableCamouflage then
      local tempTable = {_index = index, _mapKey = currentFieldMapKey}
      if self._eMapKeyIndex._PAPUCRIO == currentFieldMapKey then
        self._mapList._PAPUCRIO:push_back(tempTable)
      elseif self._eMapKeyIndex._DISABLECAMONORMAL == currentFieldMapKey then
        self._mapList._NORMAL:push_back(tempTable)
      elseif self._eMapKeyIndex._DISABLECAMOGAMOS == currentFieldMapKey then
        self._mapList._GAMOSNEST:push_back(tempTable)
      elseif self._eMapKeyIndex._DISABLEOCCUPATION == currentFieldMapKey then
        self._mapList._OCCUPATION:push_back(tempTable)
      end
    end
  end
end
function PaGlobal_LocalWarInfo_All_New:controlPc_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local titleBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_TitleBG")
  self._ui_pc._btn_close = UI.getChildControl(titleBG, "Button_Win_Close")
end
function PaGlobal_LocalWarInfo_All_New:controlConsole_Init()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_console._stc_keyguideBG = UI.getChildControl(Panel_LocalWarInfo_All, "Static_KeyGuide_Console")
  self._ui_console._stc_keyguideA = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_A_ConsoleUI")
  self._ui_console._stc_keyguideB = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_B_ConsoleUI")
  self._ui_console._stc_keyguideY = UI.getChildControl(self._ui_console._stc_keyguideBG, "StaticText_Y_ConsoleUI")
  self._ui_console._stc_keyguideY:SetShow(true)
  PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
  Panel_LocalWarInfo_All:SetChildIndex(self._ui._stc_picTooltip, 9999)
end
function PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
  local keyGuides = {
    self._ui_console._stc_keyguideY,
    self._ui_console._stc_keyguideA,
    self._ui_console._stc_keyguideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console._stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_LocalWarInfo_All_New:controlSetShow()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._ui_pc._btn_close:SetShow(not self._isConsole)
  self._ui_console._stc_keyguideBG:SetShow(self._isConsole)
end
function PaGlobal_LocalWarInfo_All_New:registEventHandler()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_LocalWarInfo_All_ResizePanel")
  registerEvent("FromClient_UpdateLocalWarStatus", "FromClient_LocalWarInfo_All_New_UpdateLocalWarStatus")
  registerEvent("FromClient_responseInstancePrivateRoomIndexByType", "FromClient_LocalWarInfo_All_New_UpdateInstanceRoom")
  self._ui._list2_serverList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_LocalWarInfo_All_New_UpdateServerList")
  if true == self._isConsole then
  else
    self._ui_pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_LocalWarInfo_All_New_Close()")
    self._ui._rule._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(0)")
    self._ui._reward._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(1)")
    self._ui._explanation._txt_title:addInputEvent("Mouse_LUp", "HandleEventLUp_LocalWarInfo_All_DescriptionCheck(2)")
  end
end
function PaGlobal_LocalWarInfo_All_New:makeRoomTitle()
  self._roomTitle = Array.new()
  local titleIndex = 1
  local maxTitleCount = 10
  for idx = 1, maxTitleCount do
    for subIdx = 1, 3 do
      local title = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SERVERNAME_" .. tostring(idx) .. "") .. "-" .. tostring(subIdx)
      self._roomTitle:push_back(title)
      self._maxRoomTitleCount = self._maxRoomTitleCount + 1
    end
  end
end
function PaGlobal_LocalWarInfo_All_New:prepareOpen()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  ToClient_requestInstanceFieldRoomList()
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 6)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 18)
  end
  Panel_LocalWarInfo_All:RegisterUpdateFunc("PaGlobal_LocalWarInfo_All_New_InformationUpdate")
  self._ui._rule._txt_title:SetCheck(true)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._reward._txt_title:SetCheck(false)
  self._ui._reward._stc_background:SetShow(false)
  self._ui._reward._stc_background:SetSize(self._ui._reward._stc_background:GetSizeX(), 1)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  if true == PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:GetShow() then
    PaGlobal_LocalWarInfo_All_New._ui._stc_picTooltip:SetShow(false)
  end
  PaGlobal_LocalWarInfo_All_New:ToggleTree(true)
  PaGlobal_LocalWarInfo_All_New:open()
end
function PaGlobal_LocalWarInfo_All_New:ToggleTree(isOn)
  local tree2 = self._ui._list2_serverList
  if nil == tree2:getElementManager() then
    self._ui._list2_serverList:createChildContent(__ePAUIList2ElementManagerType_Tree)
  end
  for idx = 1, #self._treeMapTable do
    if nil ~= self._treeMapTable[idx] and true == self._treeMapTable[idx]._isMain then
      local keyElement = tree2:getElementManager():getByKey(toInt64(0, self._treeMapTable[idx]._keyIndex), false)
      keyElement:setIsOpen(isOn)
      local uiContent = PaGlobal_LocalWarInfo_All_New._ui._list2_serverList:GetContentByKey(toInt64(0, self._treeMapTable[idx]._keyIndex))
      if nil ~= uiContent then
        UI.getChildControl(uiContent, "StaticText_LocalWar_Rule"):SetCheck(isOn)
      end
    end
  end
  tree2:getElementManager():refillKeyList()
end
function PaGlobal_LocalWarInfo_All_New:open()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(true, true)
end
function PaGlobal_LocalWarInfo_All_New:prepareClose()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  if false == self._isConsole then
    audioPostEvent_SystemUi(1, 1)
  else
    _AudioPostEvent_SystemUiForXBOX(1, 17)
  end
  self._openDesc = -1
  self._ui._rule._txt_title:SetCheck(false)
  self._ui._reward._txt_title:SetCheck(false)
  self._ui._explanation._txt_title:SetCheck(false)
  self._ui._rule._stc_background:SetShow(false)
  self._ui._reward._stc_background:SetShow(false)
  self._ui._explanation._stc_background:SetShow(false)
  self._ui._rule._stc_background:SetSize(self._ui._rule._stc_background:GetSizeX(), 1)
  self._ui._reward._stc_background:SetSize(self._ui._reward._stc_background:GetSizeX(), 1)
  self._ui._explanation._stc_background:SetSize(self._ui._explanation._stc_background:GetSizeX(), 1)
  TooltipSimple_Hide()
  Panel_LocalWarInfo_All:ClearUpdateLuaFunc()
  PaGlobal_LocalWarInfo_All_New:close()
end
function PaGlobal_LocalWarInfo_All_New:close()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  Panel_LocalWarInfo_All:SetShow(false, true)
end
function PaGlobal_LocalWarInfo_All_New:validate()
  if nil == Panel_LocalWarInfo_All then
    return
  end
end
function PaGlobal_LocalWarInfo_All_New:setDescriptionString()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  self._maxRuleSize = 40
  local ruleStringHeader = "LUA_LOCALWARINFO_DESC_RULETEXT_"
  if true == self._isOccupationDesc then
    ruleStringHeader = "LUA_JOIN_LOCALWAR_1_RULE"
  end
  for index = 1, self._ruleCount do
    local control = self._ui._rule._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, ruleStringHeader .. tostring(index)))
    self._maxRuleSize = self._maxRuleSize + control:GetTextSizeY()
  end
  for index = 1, self._rewardCount do
    local control = self._ui._reward._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    if 1 == index then
      if true == _ContentsGroup_LocalwarReward2022 then
        control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_REWARD_1"))
      else
        control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_REWARD_4"))
      end
    else
      control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_REWARD_" .. tostring(index)))
    end
    self._maxRewardSize = self._maxRewardSize + control:GetTextSizeY()
  end
  for index = 1, self._explanationCount do
    local control = self._ui._explanation._txt_content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_DESC_EXPLANATION_" .. tostring(index)))
    self._maxExplanationSize = self._maxExplanationSize + control:GetTextSizeY()
  end
  for index = 0, #self._ui._rule._txt_content do
    self._ui._rule._txt_content[index]:SetPosX(5)
  end
  self._ui._rule._txt_content[0]:SetPosY(5)
  self._ui._rule._txt_content[1]:SetPosY(self._ui._rule._txt_content[0]:GetPosY() + self._ui._rule._txt_content[0]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[2]:SetPosY(self._ui._rule._txt_content[1]:GetPosY() + self._ui._rule._txt_content[1]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[3]:SetPosY(self._ui._rule._txt_content[2]:GetPosY() + self._ui._rule._txt_content[2]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[4]:SetPosY(self._ui._rule._txt_content[3]:GetPosY() + self._ui._rule._txt_content[3]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[5]:SetPosY(self._ui._rule._txt_content[4]:GetPosY() + self._ui._rule._txt_content[4]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[6]:SetPosY(self._ui._rule._txt_content[5]:GetPosY() + self._ui._rule._txt_content[5]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[7]:SetPosY(self._ui._rule._txt_content[6]:GetPosY() + self._ui._rule._txt_content[6]:GetTextSizeY() + 2)
  self._ui._rule._txt_content[8]:SetPosY(self._ui._rule._txt_content[7]:GetPosY() + self._ui._rule._txt_content[7]:GetTextSizeY() + 2)
  for index = 0, #self._ui._reward._txt_content do
    self._ui._reward._txt_content[index]:SetPosX(5)
  end
  self._ui._reward._txt_content[0]:SetPosY(5)
  self._ui._reward._txt_content[1]:SetPosY(self._ui._reward._txt_content[0]:GetPosY() + self._ui._reward._txt_content[0]:GetTextSizeY() + 2)
  for index = 0, #self._ui._explanation._txt_content do
    self._ui._explanation._txt_content[index]:SetPosX(5)
  end
  self._ui._explanation._txt_content[0]:SetPosY(5)
  self._ui._explanation._txt_content[1]:SetPosY(self._ui._explanation._txt_content[0]:GetPosY() + self._ui._explanation._txt_content[0]:GetTextSizeY() + 2)
  self._ui._explanation._txt_content[2]:SetPosY(self._ui._explanation._txt_content[1]:GetPosY() + self._ui._explanation._txt_content[1]:GetTextSizeY() + 2)
end
function PaGlobal_LocalWarInfo_All_New:setDescriptionSizeX()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local spaceSizeX = 60
  local originTextSizeX = self._ui._rule._txt_title:GetSizeX() - spaceSizeX
  local maxSizeX = originTextSizeX
  maxSizeX = math.max(maxSizeX, self._ui._rule._txt_title:GetTextSizeX())
  maxSizeX = math.max(maxSizeX, self._ui._reward._txt_title:GetTextSizeX())
  maxSizeX = math.max(maxSizeX, self._ui._explanation._txt_title:GetTextSizeX())
  if originTextSizeX == maxSizeX then
    return
  end
  local contentSizeX = maxSizeX + spaceSizeX
  local frameSizeX = contentSizeX + 30
  local panelSizeX = self._ui._stc_leftBG:GetSizeX() + frameSizeX
  self:changeSizeX(self._ui._rule._txt_title, contentSizeX)
  self:changeSizeX(self._ui._rule._stc_background, contentSizeX)
  for index = 0, #self._ui._rule._txt_content do
    self:changeSizeX(self._ui._rule._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._reward._txt_title, contentSizeX)
  self:changeSizeX(self._ui._reward._stc_background, contentSizeX)
  for index = 0, #self._ui._reward._txt_content do
    self:changeSizeX(self._ui._reward._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._explanation._txt_title, contentSizeX)
  self:changeSizeX(self._ui._explanation._stc_background, contentSizeX)
  for index = 0, #self._ui._explanation._txt_content do
    self:changeSizeX(self._ui._explanation._txt_content[index], contentSizeX)
  end
  self:changeSizeX(self._ui._frame_desc, frameSizeX)
  self:changeSizeX(self._ui._stc_titleBG, panelSizeX)
  self._ui._stc_titleBG:ComputePosAllChild()
  self._ui._stc_titleBG:SetPosX(0)
  self:changeSizeX(Panel_LocalWarInfo_All, panelSizeX)
  Panel_LocalWarInfo_All:ComputePosAllChild()
  PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
  self._ui._frame_desc:UpdateContentScroll()
  self._ui._frame_desc:UpdateContentPos()
end
function PaGlobal_LocalWarInfo_All_New:changeSizeX(control, sizeX)
  if nil == Panel_LocalWarInfo_All then
    return
  end
  control:SetSize(sizeX, control:GetSizeY())
end
function PaGlobal_LocalWarInfo_All_New:changeSizeY()
  if nil == Panel_LocalWarInfo_All then
    return
  end
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_LocalWar)
  if roomCount <= 0 then
    return
  end
  local originalListSize = self._ui._list2_serverList:GetSizeY()
  local listContent = UI.getChildControl(self._ui._list2_serverList, "List2_1_Content")
  local contentSizeY = listContent:GetSizeY()
  local newListSize = (roomCount + self._mapList._COUNT) * contentSizeY
  if originalListSize >= newListSize then
    return
  end
  local maxSize = self._maxListCount * contentSizeY
  local yGap = 0
  if newListSize <= maxSize then
    yGap = newListSize - originalListSize
  else
    yGap = maxSize - originalListSize
  end
  Panel_LocalWarInfo_All:SetSize(Panel_LocalWarInfo_All:GetSizeX(), Panel_LocalWarInfo_All:GetSizeY() + yGap)
  self._ui._stc_leftBG:SetSize(self._ui._stc_leftBG:GetSizeX(), self._ui._stc_leftBG:GetSizeY() + yGap)
  self._ui._list2_serverList:SetSize(self._ui._list2_serverList:GetSizeX(), originalListSize + yGap)
  self._ui._frame_desc:SetSize(self._ui._frame_desc:GetSizeX(), self._ui._frame_desc:GetSizeY() + yGap)
  Panel_LocalWarInfo_All:ComputePosAllChild()
  PaGlobal_LocalWarInfo_All_New:alignKeyGuides()
end
