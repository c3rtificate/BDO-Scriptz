function PaGlobal_Artifacts_List_All:initialize()
  if true == PaGlobal_Artifacts_List_All._initialize then
    return
  end
  PaGlobal_Artifacts_List_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Artifacts_List_All._listCount = ToClient_getLightStoneSetCount()
  PaGlobal_Artifacts_List_All:controlInit()
  PaGlobal_Artifacts_List_All:controlSetShow()
  PaGlobal_Artifacts_List_All:registEventHandler()
  PaGlobal_Artifacts_List_All:validate()
  PaGlobal_Artifacts_List_All._initialize = true
end
function PaGlobal_Artifacts_List_All:controlInit()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  self._ui.stc_search = UI.getChildControl(Panel_Window_Artifacts_List_All, "Edit_Search")
  self._ui.txt_search = UI.getChildControl(self._ui.stc_search, "StaticText_Desc")
  self._ui.btn_search = UI.getChildControl(self._ui.stc_search, "Button_Search")
  local stc_list = UI.getChildControl(Panel_Window_Artifacts_List_All, "Static_List_All")
  self._ui.frame_item = UI.getChildControl(stc_list, "Frame_ItemLog")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_item, "Frame_1_Content")
  self._ui.frame_vscroll = UI.getChildControl(self._ui.frame_item, "Frame_1_VerticalScroll")
  self._ui.btn_radio = UI.getChildControl(self._ui.frame_content, "RadioButton")
  local stc_topGroup = UI.getChildControl(Panel_Window_Artifacts_List_All, "Static_TopGroup")
  self._ui_pc.btn_close = UI.getChildControl(stc_topGroup, "Button_Close")
  self._ui_console.stc_guide = UI.getChildControl(stc_list, "Static_HistoryGuide_ConsoleUI")
  for idx = 0, 3 do
    self._ui.stc_itemSlot[idx] = UI.getChildControl(self._ui.btn_radio, "Static_ItemSlotBG" .. idx)
  end
  self:createFrameList()
  self:update()
end
function PaGlobal_Artifacts_List_All:updateAllList()
  self._nextY = 0
  local count = 0
  local key = 1
  while count < self._listCount do
    local lightStoneSSW = ToClient_getLightStoneSetStaticStatusWrapper(key)
    if nil ~= lightStoneSSW then
      count = count + 1
      self:setInfo(count, lightStoneSSW)
    end
    key = key + 1
  end
  self._ui.frame_content:SetSize(self._ui.frame_item:GetSizeX(), self._nextY)
  self._ui.frame_vscroll:SetControlPos(0)
  self:frameUpdate()
end
function PaGlobal_Artifacts_List_All:updateSearchedList()
  self._nextY = 0
  local count = getSocketInformation():getSearchedListCount()
  for idx = 0, count - 1 do
    local key = getSocketInformation():getSearchedKey(idx)
    local lightStoneSSW = ToClient_getLightStoneSetStaticStatusWrapper(key)
    if nil ~= lightStoneSSW then
      self:setInfo(idx + 1, lightStoneSSW)
    end
  end
  self._ui.frame_content:SetSize(self._ui.frame_item:GetSizeX(), self._nextY)
  self._ui.frame_vscroll:SetControlPos(0)
  self:frameUpdate()
end
function PaGlobal_Artifacts_List_All:setInfo(index, lightStoneSSW)
  if nil == lightStoneSSW then
    return
  end
  local stc = self._ui.frame_list[index]
  if nil == stc then
    return
  end
  stc.btn_radio:SetShow(true)
  local classType = getSelfPlayer():getClassType()
  local lightStoneCount = lightStoneSSW:getLightStoneCount()
  stc.txt_title:SetText(lightStoneSSW:getDesc())
  for slotIdx = 0, 3 do
    local slotStc = stc.slotInfo[slotIdx]
    if lightStoneCount > slotIdx then
      local itemSSW = lightStoneSSW:getItemEnchantStaticStatusWrapper(slotIdx)
      if nil ~= itemSSW then
        slotStc.stc_bg:SetShow(true)
        slotStc.txt_itemName:SetText(itemSSW:getName())
        PAGlobalFunc_SetItemTextColor(slotStc.txt_itemName, itemSSW)
        slotStc.stc_itemIcon:ChangeTextureInfoName("icon/" .. itemSSW:getIconPath())
        local skillSSW = itemSSW:getSkillByIdx(classType)
        if nil ~= skillSSW then
          local buffCount = skillSSW:getBuffCount()
          local descText = ""
          for buffIdx = 0, buffCount - 1 do
            local descCurrent = skillSSW:getBuffDescription(buffIdx)
            if "" == descCurrent then
              break
            end
            if 0 == buffIdx then
              descText = descCurrent
            else
              descText = descText .. "\n" .. descCurrent
            end
          end
          slotStc.txt_itemDesc:SetTextMode(__eTextMode_AutoWrap)
          slotStc.txt_itemDesc:SetText(descText)
        end
      else
        slotStc.stc_bg:SetShow(false)
      end
    else
      slotStc.stc_bg:SetShow(false)
    end
  end
  if lightStoneCount ~= 4 then
    local bgSize = stc.btn_radio:GetSizeY() - stc.slotInfo[0].stc_bg:GetSizeY() - 5
    stc.btn_radio:SetSize(stc.btn_radio:GetSizeX(), bgSize)
  end
  stc.btn_radio:SetPosY(self._nextY)
  self._nextY = self._nextY + stc.btn_radio:GetSizeY() + 5
end
function PaGlobal_Artifacts_List_All:controlSetShow()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  if false == self._isConsole then
    self._ui_pc.btn_close:SetShow(true)
    self._ui_console.stc_guide:SetShow(false)
  else
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_guide:SetShow(true)
  end
end
function PaGlobal_Artifacts_List_All:clearFrameList()
  for idx = 1, self._listCount do
    local stc = self._ui.frame_list[idx]
    stc.btn_radio:SetPosY(self._ui.btn_radio:GetPosY() + self._ui.btn_radio:GetSizeY() * (idx - 1) + 5)
    stc.btn_radio:SetSize(self._ui.btn_radio:GetSizeX(), self._ui.btn_radio:GetSizeY())
    stc.btn_radio:SetShow(false)
  end
end
function PaGlobal_Artifacts_List_All:createFrameList()
  for idx = 1, self._listCount do
    local tempListInfo = {}
    tempListInfo.btn_radio = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "RadioButton", self._ui.frame_content, "RadioButton_" .. idx)
    tempListInfo.stc_titleIcon = UI.createAndCopyBasePropertyControl(self._ui.btn_radio, "Static_TitleIcon", tempListInfo.btn_radio, "Static_TitleIcon_" .. idx)
    tempListInfo.txt_title = UI.createAndCopyBasePropertyControl(self._ui.btn_radio, "StaticText_Title", tempListInfo.btn_radio, "StaticText_Title_" .. idx)
    tempListInfo.stc_line = UI.createAndCopyBasePropertyControl(self._ui.btn_radio, "Static_Line", tempListInfo.btn_radio, "Static_Line_" .. idx)
    tempListInfo.stc_slotBg = UI.createAndCopyBasePropertyControl(self._ui.btn_radio, "Static_Slot1_BG", tempListInfo.btn_radio, "Static_Slot1_BG_" .. idx)
    tempListInfo.slotInfo = {}
    for slotIdx = 0, 3 do
      local slotInfo = {}
      slotInfo.stc_bg = UI.createAndCopyBasePropertyControl(self._ui.btn_radio, "Static_ItemSlotBG" .. slotIdx, tempListInfo.btn_radio, "Static_ItemSlotBG_" .. idx .. "_" .. slotIdx)
      slotInfo.stc_itemIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_itemSlot[slotIdx], "Static_ItemIcon", slotInfo.stc_bg, "Static_ItemIcon_" .. idx .. "_" .. slotIdx)
      slotInfo.txt_itemName = UI.createAndCopyBasePropertyControl(self._ui.stc_itemSlot[slotIdx], "StaticText_ItemName", slotInfo.stc_bg, "StaticText_ItemName_" .. idx .. "_" .. slotIdx)
      slotInfo.txt_itemDesc = UI.createAndCopyBasePropertyControl(self._ui.stc_itemSlot[slotIdx], "StaticText_ItemDesc", slotInfo.stc_bg, "StaticText_ItemDesc_" .. idx .. "_" .. slotIdx)
      tempListInfo.slotInfo[slotIdx] = slotInfo
    end
    tempListInfo.btn_radio:SetPosY(self._ui.btn_radio:GetPosY() + self._ui.btn_radio:GetSizeY() * (idx - 1) + 5)
    tempListInfo.stc_titleIcon:SetShow(true)
    tempListInfo.txt_title:SetShow(true)
    self._ui.frame_list[idx] = tempListInfo
  end
  local contentSizeY = self._ui.btn_radio:GetSizeY() * self._listCount + 5 * (self._listCount - 1)
  self._ui.frame_content:SetSize(self._ui.frame_item:GetSizeX(), contentSizeY)
end
function PaGlobal_Artifacts_List_All:registEventHandler()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  UIScroll.InputEvent(self._ui.frame_vscroll, "HandleEventScroll_Artifacts_List_All_Scroll")
  self._ui.frame_content:addInputEvent("Mouse_UpScroll", "HandleEventScroll_Artifacts_List_All_Scroll(true)")
  self._ui.frame_content:addInputEvent("Mouse_DownScroll", "HandleEventScroll_Artifacts_List_All_Scroll(false)")
  self._ui.txt_search:addInputEvent("Mouse_LUp", "HandleEventLUp_Artifacts_List_All_SelectSearchText()")
  self._ui.txt_search:RegistReturnKeyEvent("HandleEventKeyBoard_Artifacts_List_All_SearchLightStoneSet()")
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Artifacts_List_All_Close()")
  else
  end
end
function PaGlobal_Artifacts_List_All:update()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  self:frameUpdate()
end
function PaGlobal_Artifacts_List_All:frameUpdate()
  self._ui.frame_item:UpdateContentScroll()
  self._ui.frame_item:UpdateContentPos()
  self._ui.frame_vscroll:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_Artifacts_List_All:prepareOpen()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  if nil == Panel_Window_Artifacts_All then
    return
  end
  Panel_Window_Artifacts_List_All:SetPosX(Panel_Window_Artifacts_All:GetPosX() + Panel_Window_Artifacts_All:GetSizeX() + 5)
  Panel_Window_Artifacts_List_All:SetPosY(Panel_Window_Artifacts_All:GetPosY())
  getSocketInformation():clearSearchedData()
  self:clearFrameList()
  self:updateAllList()
  self._ui.frame_vscroll:SetControlPos(0)
  self:frameUpdate()
  PaGlobal_Artifacts_List_All:open()
end
function PaGlobal_Artifacts_List_All:open()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  Panel_Window_Artifacts_List_All:SetShow(true)
end
function PaGlobal_Artifacts_List_All:prepareClose()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  ClearFocusEdit()
  self._ui.txt_search:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_NEW_EDIT_GOODSNAME"))
  PaGlobal_Artifacts_List_All:close()
end
function PaGlobal_Artifacts_List_All:close()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  Panel_Window_Artifacts_List_All:SetShow(false)
end
function PaGlobal_Artifacts_List_All:selectSearchText()
  self._ui.txt_search:SetEditText("")
  SetFocusEdit(self._ui.txt_search)
end
function PaGlobal_Artifacts_List_All:searchLightStoneSet()
  local searchText = self._ui.txt_search:GetEditText()
  ClearFocusEdit()
  self:clearFrameList()
  local socketInfo = getSocketInformation()
  if nil == searchText or "" == searchText then
    getSocketInformation():clearSearchedData()
    self:updateAllList()
    return
  end
  getSocketInformation():requestSearchLightStoneSet(searchText)
  self:updateSearchedList()
end
function PaGlobal_Artifacts_List_All:validate()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
end
