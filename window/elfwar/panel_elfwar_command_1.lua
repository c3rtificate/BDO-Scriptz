function PaGlobal_ElfWarCommand:initialize()
  if self._initialize == true then
    return
  end
  self:createCommandButtonList()
  self:registEventHandler()
  self:validate()
  if ToClient_IsParticipateInElfWar() == true then
    FromClient_ElfWarCommand_ChangeElfWarState(ToClient_GetElfWarState())
  end
  self._initialize = true
end
function PaGlobal_ElfWarCommand:createCommandButtonList()
  if Panel_ElfWar_Command == nil then
    return
  end
  self._commandButtonList = Array.new()
  for index = 0, __eElfWarCommandEventType_Count - 1 do
    local commandButtonData = {
      _isUseable = false,
      _commandEventType = index,
      _buttonControl = nil
    }
    commandButtonData._buttonControl = UI.cloneControl(self._ui._btn_template, Panel_ElfWar_Command, "ElfWar_Command_Button_" .. tostring(index))
    if commandButtonData._buttonControl == nil then
      return
    end
    local normalTextureKey, onTextureKey, clickTextureKey
    if commandButtonData._commandEventType == __eElfWarCommandEventType_RequestAttackSupport then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Yellow_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Yellow_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Yellow_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_RequestDefenceSupport then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Blue_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Blue_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Blue_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_FightingNow then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_SafePosition then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Green_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Green_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Green_Click"
      hotKeyString = "S+Shift+4"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_Move then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Support_Orange_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_Ping_Red then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Orange_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Orange_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Orange_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_Ping_Blue then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Blue_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Blue_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Blue_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_Ping_Green then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Green_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Green_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Green_Click"
    elseif commandButtonData._commandEventType == __eElfWarCommandEventType_Ping_Yellow then
      normalTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Yellow_Normal"
      onTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Yellow_Over"
      clickTextureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Ping_Yellow_Click"
    else
      UI.ASSERT_NAME(false, "ElfWarCommandEventType\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    if normalTextureKey == nil or onTextureKey == nil or clickTextureKey == nil then
      return
    end
    local iconControl = UI.getChildControl(commandButtonData._buttonControl, "Static_Icon")
    if iconControl == nil then
      return
    end
    iconControl:ChangeTextureInfoTextureIDKey(normalTextureKey)
    iconControl:ChangeTextureInfoTextureIDKey(onTextureKey, 1)
    iconControl:ChangeTextureInfoTextureIDKey(clickTextureKey, 2)
    iconControl:setRenderTexture(iconControl:getBaseTexture())
    commandButtonData._buttonControl:SetShow(false)
    commandButtonData._buttonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarCommand_ProcessCommand(" .. tostring(commandButtonData._commandEventType) .. ")")
    self._commandButtonList:push_back(commandButtonData)
  end
  self._ui._btn_template:SetShow(false)
end
function PaGlobal_ElfWarCommand:registEventHandler()
  if Panel_ElfWar_Command == nil then
    return
  end
  registerEvent("FromClient_ReceivedElfWarCommand", "FromClient_ElfWarCommand_ReceivedElfWarCommand")
  registerEvent("FromClient_ChangeElfWarState", "FromClient_ElfWarCommand_ChangeElfWarState")
end
function PaGlobal_ElfWarCommand:prepareOpen(openPlayerGradeType, posX, posY)
  if Panel_ElfWar_Command == nil then
    return
  end
  if openPlayerGradeType == nil or openPlayerGradeType >= __eElfWarPlayerGradeType_Count then
    return
  end
  if posX == nil or posY == nil then
    return
  end
  self:setButtonList(openPlayerGradeType)
  self:setPanelPos(posX, posY)
  self:open()
end
function PaGlobal_ElfWarCommand:open()
  if Panel_ElfWar_Command == nil then
    return
  end
  audioPostEvent_SystemUi(35, 8)
  _AudioPostEvent_SystemUiForXBOX(35, 8)
  Panel_ElfWar_Command:SetShow(true)
end
function PaGlobal_ElfWarCommand:prepareClose()
  if Panel_ElfWar_Command == nil then
    return
  end
  self._openWorldPosition = float3(0, 0, 0)
  self:close()
end
function PaGlobal_ElfWarCommand:close()
  if Panel_ElfWar_Command == nil then
    return
  end
  Panel_ElfWar_Command:SetShow(false)
end
function PaGlobal_ElfWarCommand:validate()
  if Panel_ElfWar_Command == nil then
    return
  end
  self._ui._btn_template:isValidate()
end
function PaGlobal_ElfWarCommand:setButtonList(openPlayerGradeType)
  if Panel_ElfWar_Command == nil or openPlayerGradeType == nil or openPlayerGradeType >= __eElfWarPlayerGradeType_Count then
    return
  end
  if self._commandButtonList == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_ElfWarCommand:setButtonList] \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local spanX = 0
  local termX = 15
  local showCount = 0
  for index = 0, __eElfWarCommandEventType_Count - 1 do
    if index ~= __eElfWarCommandEventType_Move then
      local buttonData = self._commandButtonList[index + 1]
      if buttonData ~= nil then
        local isUseable = ToClient_IsUseableElfWarCommandEventType(openPlayerGradeType, buttonData._commandEventType)
        if isUseable == true then
          spanX = 10 + (self._ui._btn_template:GetSizeX() + termX) * showCount
          showCount = showCount + 1
          buttonData._buttonControl:SetSpanSize(spanX, 0)
          buttonData._buttonControl:ComputePos()
          buttonData._buttonControl:SetShow(true)
          buttonData._isUseable = true
        else
          buttonData._buttonControl:SetSpanSize(0, 0)
          buttonData._buttonControl:ComputePos()
          buttonData._buttonControl:SetShow(false)
          buttonData._isUseable = false
        end
      end
    end
  end
  Panel_ElfWar_Command:SetSize(spanX + self._ui._btn_template:GetSizeX() + 20, Panel_ElfWar_Command:GetSizeY())
end
function PaGlobal_ElfWarCommand:setPanelPos(posX, posY)
  if Panel_ElfWar_Command == nil or posX == nil or posY == nil then
    return
  end
  Panel_ElfWar_Command:SetPosX(posX)
  Panel_ElfWar_Command:SetPosY(posY)
end
