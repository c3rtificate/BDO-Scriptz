function PaGlobal_Guild_SimpleInvite_Open()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if true == Panel_Window_Guild_SimpleInvite:GetShow() then
    return
  end
  PaGlobal_Guild_SimpleInvite:prepareOpen()
end
function PaGlobal_Guild_SimpleInvite_Close()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if false == Panel_Window_Guild_SimpleInvite:GetShow() then
    return
  end
  PaGlobal_Guild_SimpleInvite:prepareClose()
end
function FromClient_SimpleGuildInvite(index)
  if ToClient_getSimpleGuildInviteInfoSize() == 0 then
    return
  end
  PaGlobal_Guild_SimpleInvite._selectIndex = index
  PaGlobal_Guild_SimpleInvite_Open()
  PaGlobal_Guild_SimpleInvite:update()
end
function FromClient_SimpleGuildInviteReject()
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  if listSize > 0 then
    PaGlobal_Guild_SimpleInvite._selectIndex = 0
    PaGlobal_Guild_SimpleInvite_Open()
  end
end
function FromClient_SimpleGuildInviteRejectNoticeGuild(guildName, guestName)
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_REFUSE_GUILDINVITE", "name", guestName, "guild", guildName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_SimpleGuildInviteClear()
  PaGlobal_GuildInviteAlert_Close()
end
function PaGlobal_Guild_SimpleInvite_AcceptGuild()
  local self = PaGlobal_Guild_SimpleInvite
  if nil == self._selectIndex then
    return
  end
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  ToClient_requestAcceptSimpleGuildInvite(wrapper:getGuildNo())
  PaGlobal_Guild_SimpleInvite_Close()
end
function PaGlobal_Guild_SimpleInvite_RejectGuild()
  local self = PaGlobal_Guild_SimpleInvite
  if nil == self._selectIndex then
    return
  end
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  ToClient_requestRejectSimpleGuildInvite(wrapper:getGuildNo())
  PaGlobal_Guild_SimpleInvite_Close()
end
function PaGlobal_Guild_SimpleInvite_OpenGuildInfo()
  local self = PaGlobal_Guild_SimpleInvite
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  local strGuildNo = tostring(wrapper:getGuildNo())
  FGlobal_GuildWebInfoForGuildRank_Open(strGuildNo)
end
function PaGlobal_Guild_SimpleInvite_ShowSimpleToolTip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_Guild_SimpleInvite._ui.btn_guildInfo
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NONEGUILD_VIEW_GUILDINFO")
  if nil ~= control then
    TooltipSimple_Show(control, name, nil, false)
  end
end
function PaGlobal_Guild_SimpleInvite_NextShow()
  if nil == PaGlobal_Guild_SimpleInvite._selectIndex then
    return
  end
  local TotalSize = ToClient_getSimpleGuildInviteInfoSize()
  if TotalSize - 1 <= PaGlobal_Guild_SimpleInvite._selectIndex then
    PaGlobal_Guild_SimpleInvite._selectIndex = 0
  else
    PaGlobal_Guild_SimpleInvite._selectIndex = PaGlobal_Guild_SimpleInvite._selectIndex + 1
  end
  PaGlobal_Guild_SimpleInvite:update()
end
function PaGlobal_Guild_SimpleInvite_PreShow()
  if nil == PaGlobal_Guild_SimpleInvite._selectIndex then
    return
  end
  local TotalSize = ToClient_getSimpleGuildInviteInfoSize()
  if 0 == PaGlobal_Guild_SimpleInvite._selectIndex then
    PaGlobal_Guild_SimpleInvite._selectIndex = TotalSize - 1
  else
    PaGlobal_Guild_SimpleInvite._selectIndex = PaGlobal_Guild_SimpleInvite._selectIndex - 1
  end
  PaGlobal_Guild_SimpleInvite:update()
end
function PaGlobal_Guild_SimpleInvite_SetSelectIndex(index)
  PaGlobal_Guild_SimpleInvite._selectIndex = index
  PaGlobal_Guild_SimpleInvite:update()
end
function PaGlobal_Guild_SimpleInvite_Scroll(isUp)
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if true == isUp then
    PaGlobal_Guild_SimpleInvite._ui.frame_vertical:ControlButtonUp()
  elseif false == isUp then
    PaGlobal_Guild_SimpleInvite._ui.frame_vertical:ControlButtonDown()
  end
  PaGlobal_Guild_SimpleInvite._ui.frame:UpdateContentPos()
  PaGlobal_Guild_SimpleInvite._ui.frame:UpdateContentScroll()
end
function PaGlobal_Guild_SimpleInvite_ShowAni()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
end
function PaGlobal_Guild_SimpleInvite_HideAni()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
end
