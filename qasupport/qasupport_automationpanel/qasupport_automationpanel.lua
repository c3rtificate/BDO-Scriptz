QASupport_AutomationPanel:SetShow(false)
local itemIndex = -1
local boxValue = false
local _qaCommandParam
local btn_index = 0
local cmd_edit_list = {
  [1] = UI.getChildControl(QASupport_AutomationPanel, "QA_Edit_Command"),
  [2] = UI.getChildControl(QASupport_AutomationPanel, "QA_Edit_param1"),
  [3] = UI.getChildControl(QASupport_AutomationPanel, "QA_Edit_param2"),
  [4] = UI.getChildControl(QASupport_AutomationPanel, "QA_Edit_param3"),
  [5] = UI.getChildControl(QASupport_AutomationPanel, "QA_Edit_param4"),
  [6] = UI.getChildControl(QASupport_AutomationPanel, "QA_Enter_Btn"),
  [7] = UI.getChildControl(QASupport_AutomationPanel, "QA_Search_Edit")
}
local search_enter = UI.getChildControl(QASupport_AutomationPanel, "QA_Search_Enter_Btn")
local table_tab_list = {
  [1] = {},
  [2] = {},
  [3] = {},
  [4] = {},
  [5] = {},
  [6] = {},
  [7] = {},
  [8] = {},
  [9] = {},
  [10] = {},
  [11] = {}
}
local table_desc_list = {
  [1] = {},
  [2] = {},
  [3] = {},
  [4] = {},
  [5] = {},
  [6] = {},
  [7] = {},
  [8] = {},
  [9] = {},
  [10] = {},
  [11] = {}
}
local btn_info_list = {}
local QASupport_AutomationPanel_SafeCheck = function()
  if nil == getSelfPlayer() then
    return false
  end
  if nil == QASupport_AutomationPanel then
    return false
  end
  return true
end
function add_btn_info(col, row, name, clickEvent, tabNumber, descTooltip, chineseName, chineseDescTooltip)
  local btn_info = {
    _col = col,
    _row = row,
    _name = name,
    _clickEvent = clickEvent,
    _tabNumber = tabNumber,
    _descTooltip = descTooltip,
    _chineseName = chineseName,
    _chineseDescTooltip = chineseDescTooltip
  }
  btn_info_list[btn_index] = btn_info
  btn_index = btn_index + 1
end
function find_text(text)
  rv = {}
  for idx, btn_info in pairs(btn_info_list) do
    if string.find(btn_info._name, text) then
      table.insert(rv, btn_info)
    end
  end
  if rv == {} then
    return nil
  else
    return rv
  end
end
function QASupport_AutomationPanel_Open()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  QASupport_AutomationPanel_Reset()
  QASupport_AutomationPanel:SetShow(true)
end
function QASupport_AutomationPanel_Close()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  QASupport_AutomationPanel_Reset()
  QASupport_AutomationPanel:SetShow(false)
end
function clickTab(index)
  index = index + 1
  for idx, table_tab in pairs(table_tab_list) do
    if idx == index then
      for _, control in pairs(table_tab_list[idx]) do
        control:SetShow(true)
      end
    else
      for _, control in pairs(table_tab_list[idx]) do
        control:SetShow(false)
      end
    end
  end
end
function QASupport_AutomationPanel_Reset()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab0"):SetCheck(true)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab1"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab2"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab3"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab4"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab5"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab6"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab7"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab8"):SetCheck(false)
  UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab9"):SetCheck(false)
  clickTab(0)
end
function FromClient_QASupport_AutomationPanel_Toggle()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  local showCheck = not QASupport_AutomationPanel:GetShow()
  _PA_SVC_LOG("*************ToggleQASupport(" .. tostring(showCheck) .. ")*************")
  if true == showCheck then
    QASupport_AutomationPanel_Reset()
  end
  QASupport_AutomationPanel:SetShow(showCheck)
end
registerEvent("FromClient_QASupport_AutomationPanel_Toggle", "FromClient_QASupport_AutomationPanel_Toggle()")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_QASupport_AutomationPanel")
local control_validate = function(col, row, name, clickEvent, tabNumber)
  if row > 4 then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() row\234\176\146\236\157\128 3\236\157\132 \235\132\152\236\150\180\236\132\156\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if tabNumber > 9 then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() tabNumber\234\176\146\236\157\128 9\236\157\132 \235\132\152\236\150\180\236\132\156\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if nil == col then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() col nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if nil == row then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() row nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if nil == name then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() name\236\157\180 nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if nil == clickEvent then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() clickEvent\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  if nil == tabNumber then
    _PA_ASSERT_NAME(false, "CREATE_BUTTON() tabNumber\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
end
local function CREATE_BUTTON(col, row, name, clickEvent, tabNumber, descTooltip, chineseName, chineseDescTooltip, flag)
  if flag == true then
    add_btn_info(col, row, name, clickEvent, tabNumber, descTooltip, chineseName, chineseDescTooltip)
  end
  itemIndex = itemIndex + 1
  local btn = UI.createAndCopyBasePropertyControl(QASupport_AutomationPanel, "ButtonTemp", QASupport_AutomationPanel, "ButtonTemp_" .. itemIndex)
  if nil == btn then
    _PA_ASSERT_NAME(nil ~= clickEvent, "CREATE_BUTTON() clickEvent\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "QA\237\140\128 \235\172\184\236\132\184\236\152\129 / \236\161\176\236\132\177\235\175\188")
  end
  local localizedName = ""
  local localizedDescTooltip = ""
  if isGameTypeKR2() == true then
    localizedName = chineseName
    localizedDescTooltip = chineseDescTooltip
  else
    localizedName = name
    localizedDescTooltip = descTooltip
  end
  if nil == localizedDescTooltip then
    localizedDescTooltip = "No Desc"
  end
  btn:SetShow(true)
  btn:SetText(localizedName)
  btn:SetPosX(10 + row * (btn:GetSizeX() + 6))
  btn:SetPosY(155 + col * (btn:GetSizeY() + 10))
  if 11 ~= tabNumber then
    btn:addInputEvent("Mouse_LUp", "QASupport_Automation_CallClickEvent(" .. itemIndex .. "," .. tabNumber .. ",\"" .. clickEvent .. "\")")
    btn:addInputEvent("Mouse_On", "QASupport_Automation_Tooltip(" .. itemIndex .. "," .. tabNumber .. ")")
    btn:addInputEvent("Mouse_Out", "QASupport_Automation_Tooltip_Hide()")
  else
    btn:addInputEvent("Mouse_LUp", "SetTrSleepTick()")
  end
  table_tab_list[tabNumber + 1][itemIndex] = btn
  table_desc_list[tabNumber + 1][itemIndex] = localizedDescTooltip
end
function Search_Button(value)
  clickTab(10)
  for _, control in pairs(table_tab_list[11]) do
    control:SetShow(false)
  end
  local _btn_info_list = find_text(value)
  if nil ~= _btn_info_list then
    col = 0
    row = 0
    for _, _btn_info in pairs(_btn_info_list) do
      CREATE_BUTTON(col, row, _btn_info._name, _btn_info._clickEvent, 10, _btn_info._descTooltip, _btn_info._chineseName, _btn_info._chineseDescTooltip, false)
      row = row + 1
      if row == 4 then
        row = 0
        col = col + 1
      end
    end
  end
end
function QASupport_Automation_CallClickEvent(index, tabNumber, clickEvent)
  local name
  uiControl = table_tab_list[tabNumber + 1][index]
  name = table_tab_list[tabNumber + 1][index]:GetText()
  if nil == name then
    return
  end
  _PA_SVC_LOG("*************QASupport_Automation_CallClickEvent : " .. name .. "*************")
  ToClient_ChatProcess("/doLua " .. clickEvent)
end
function QASupport_Automation_Tooltip_Hide()
  TooltipSimple_Hide()
end
function QASupport_Automation_Tooltip(index, tabNumber)
  local uiControl, name, desc
  for idx, table_tab in pairs(table_tab_list) do
    if idx == tabNumber + 1 then
      uiControl = table_tab_list[idx][index]
      name = table_tab_list[idx][index]:GetText()
      desc = table_desc_list[idx][index]
      break
    end
  end
  local reversePosX = true
  if nil == Panel_Tooltip_SimpleText then
    return
  end
  if nil == uiControl then
    return
  end
  TooltipSimple_Show(uiControl, name, desc, nil, reversePosX)
end
function FromClient_luaLoadComplete_QASupport_AutomationPanel()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  local btn_tab0 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab0")
  local btn_tab1 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab1")
  local btn_tab2 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab2")
  local btn_tab3 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab3")
  local btn_tab4 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab4")
  local btn_tab5 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab5")
  local btn_tab6 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab6")
  local btn_tab7 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab7")
  local btn_tab8 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab8")
  local btn_tab9 = UI.getChildControl(QASupport_AutomationPanel, "RadioButton_Tab9")
  local stc_title = UI.getChildControl(QASupport_AutomationPanel, "StaticText_Title")
  local btn_popUp = UI.getChildControl(stc_title, "QA_Button_Popup")
  local btn_close = UI.getChildControl(stc_title, "Button_Win_Close")
  btn_popUp:addInputEvent("Mouse_LUp", "QASupport_Automation_Popup()")
  btn_close:addInputEvent("Mouse_LUp", "QASupport_AutomationPanel_Close()")
  btn_tab0:addInputEvent("Mouse_LUp", "clickTab(0)")
  btn_tab1:addInputEvent("Mouse_LUp", "clickTab(1)")
  btn_tab2:addInputEvent("Mouse_LUp", "clickTab(2)")
  btn_tab3:addInputEvent("Mouse_LUp", "clickTab(3)")
  btn_tab4:addInputEvent("Mouse_LUp", "clickTab(4)")
  btn_tab5:addInputEvent("Mouse_LUp", "clickTab(5)")
  btn_tab6:addInputEvent("Mouse_LUp", "clickTab(6)")
  btn_tab7:addInputEvent("Mouse_LUp", "clickTab(7)")
  btn_tab8:addInputEvent("Mouse_LUp", "clickTab(8)")
  btn_tab9:addInputEvent("Mouse_LUp", "clickTab(9)")
  cmd_edit_list[1]:addInputEvent("Mouse_LUp", "ClearEdit(1)")
  cmd_edit_list[2]:addInputEvent("Mouse_LUp", "ClearEdit(2)")
  cmd_edit_list[3]:addInputEvent("Mouse_LUp", "ClearEdit(3)")
  cmd_edit_list[4]:addInputEvent("Mouse_LUp", "ClearEdit(4)")
  cmd_edit_list[5]:addInputEvent("Mouse_LUp", "ClearEdit(5)")
  cmd_edit_list[6]:addInputEvent("Mouse_LUp", "QASupport_Automation_EnterFunc(1)")
  cmd_edit_list[7]:addInputEvent("Mouse_LUp", "ClearEdit(7)")
  search_enter:addInputEvent("Mouse_LUp", "QASupport_Automation_SearchFunc()")
  QASupport_AutomationPanel_CreateControl_Tab0()
  QASupport_AutomationPanel_CreateControl_Tab1()
  QASupport_AutomationPanel_CreateControl_Tab2()
  QASupport_AutomationPanel_CreateControl_Tab3()
  QASupport_AutomationPanel_CreateControl_Tab4()
  QASupport_AutomationPanel_CreateControl_Tab5()
  QASupport_AutomationPanel_CreateControl_Tab6()
  QASupport_AutomationPanel_CreateControl_Tab7()
  QASupport_AutomationPanel_CreateControl_Tab8()
  QASupport_AutomationPanel_CreateControl_Tab9()
  QASupport_AutomationPanel_Reset()
  if isGameTypeKR2() == true then
    btn_tab0:SetText("\234\176\132\237\142\184 \235\170\133\235\160\185\236\150\180\n\231\174\128\229\141\149\230\140\135\228\187\164")
    btn_tab1:SetText("\236\157\180\235\143\153\n\231\167\187\229\138\168")
    btn_tab2:SetText("\236\186\144\235\166\173\237\132\176 \236\132\184\237\140\133\n\232\174\190\231\189\174\232\167\146\232\137\178")
    btn_tab3:SetText("\236\187\168\237\133\144\236\184\160 \236\132\184\237\140\133\n\232\174\190\231\189\174\230\184\184\230\136\143\229\134\133\229\174\185")
    btn_tab4:SetText("\236\130\172\235\131\165\237\132\176, \237\149\132\235\179\180\n\229\136\183\230\128\170\231\130\185, \229\140\186\229\159\159\233\166\150\233\162\134")
    btn_tab5:SetText("\236\155\148\235\147\156\235\179\180\236\138\164\n\228\184\150\231\149\140\229\164\180\231\155\174")
    btn_tab6:SetText("\237\131\145\236\138\185\235\172\188\n\229\157\144\233\170\145")
    btn_tab7:SetText("\234\184\184\235\147\156, \234\179\181\234\177\176\236\160\144\n\229\133\172\228\188\154, \230\141\174\231\130\185\230\136\152")
    btn_tab8:SetText("\235\140\128\236\150\145\n\229\164\167\230\180\139")
    btn_tab9:SetText("\236\186\144\235\166\173\237\132\176 QA\n\232\167\146\232\137\178 QA")
  else
    btn_tab0:SetText("\234\176\132\237\142\184 \235\170\133\235\160\185\236\150\180\nCommands")
    btn_tab1:SetText("\236\157\180\235\143\153\nMove")
    btn_tab2:SetText("\236\186\144\235\166\173\237\132\176 \236\132\184\237\140\133\nCharacter")
    btn_tab3:SetText("\236\187\168\237\133\144\236\184\160 \236\132\184\237\140\133\nContents")
    btn_tab4:SetText("\236\130\172\235\131\165\237\132\176, \237\149\132\235\179\180\nMonster")
    btn_tab5:SetText("\236\155\148\235\147\156\235\179\180\236\138\164\nWorldBoss")
    btn_tab6:SetText("\237\131\145\236\138\185\235\172\188\nServant")
    btn_tab7:SetText("\234\184\184\235\147\156, \234\179\181\234\177\176\236\160\144\nGuild")
    btn_tab8:SetText("\235\140\128\236\150\145\nSea")
    btn_tab9:SetText("\236\186\144\235\166\173\237\132\176 QA\nCharacter")
  end
end
function QASupport_AutomationPanel_CheckCurrentUiEdit(targetUI)
  if targetUI ~= nil then
    for i in pairs(cmd_edit_list) do
      if cmd_edit_list[i] == nil then
        return false
      end
    end
    for i in pairs(cmd_edit_list) do
      if targetUI:GetKey() == cmd_edit_list[i]:GetKey() then
        return true
      end
    end
  end
  return false
end
function ClearEdit(param1)
  cmd_edit_list[param1]:SetEditText("")
end
function QASupport_Automation_SearchFunc()
  local find_text = cmd_edit_list[7]:GetEditText()
  if find_text ~= "" and find_text ~= " " then
    Search_Button(find_text)
  end
end
function QASupport_Automation_EnterFunc(param)
  if param == 1 then
    local cmd = cmd_edit_list[1]:GetEditText()
    if cmd == "/dolua" then
      str = cmd .. " " .. cmd_edit_list[2]:GetEditText() .. "("
      for i = 3, 5 do
        if cmd_edit_list[i]:GetEditText() ~= "" then
          if i == 3 then
            str = str .. cmd_edit_list[i]:GetEditText()
          else
            str = str .. "," .. cmd_edit_list[i]:GetEditText()
          end
        end
      end
      str = str .. ")"
      ToClient_ChatProcess(str)
    else
      str = ""
      for i = 1, 5 do
        if cmd_edit_list[i]:GetEditText() ~= "" then
          if i == 1 then
            str = str .. cmd_edit_list[i]:GetEditText()
          else
            str = str .. " " .. cmd_edit_list[i]:GetEditText()
          end
        end
      end
      ToClient_ChatProcess(str)
    end
  elseif param == 2 then
    if true == cmd_edit_list[7]:GetFocusEdit() then
      QASupport_Automation_SearchFunc()
    else
      QASupport_Automation_EnterFunc(1)
    end
  end
end
function QASupport_Automation_PressRightKey(uiEdit)
  for i in pairs(cmd_edit_list) do
    if uiEdit:GetKey() == cmd_edit_list[i]:GetKey() then
      if i < 5 then
        ClearEdit(i + 1)
        SetFocusEdit(cmd_edit_list[i + 1])
        return
      elseif i == 5 then
        ClearEdit(7)
        SetFocusEdit(cmd_edit_list[7])
      end
    end
  end
end
function QASupport_Automation_PressDownKey(uiEdit)
  SetFocusEdit(cmd_edit_list[7])
end
function QASupport_Automation_PressUpKey(uiEdit)
  SetFocusEdit(cmd_edit_list[1])
end
function QASupport_Automation_PressLeftKey(uiEdit)
  for i in pairs(cmd_edit_list) do
    if uiEdit:GetKey() == cmd_edit_list[i]:GetKey() then
      if 7 == i then
        ClearEdit(5)
        SetFocusEdit(cmd_edit_list[5])
      elseif i > 1 then
        ClearEdit(i - 1)
        SetFocusEdit(cmd_edit_list[i - 1])
        return
      end
    end
  end
end
function QASupport_Automation_Popup()
  if QASupport_AutomationPanel == nil then
    return
  end
  if QASupport_AutomationPanel:GetShow() == false then
    return
  end
  if QASupport_AutomationPanel:IsUISubApp() == false then
    QASupport_AutomationPanel:OpenUISubApp()
  else
    QASupport_AutomationPanel:CloseUISubApp()
  end
end
function QASupport_AutomationPanel_CreateControl_Tab0()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\236\154\180\236\152\129\236\158\144 \236\158\165\235\185\132\nOperator gear", "SetGMItem()", 0, "\236\154\180\236\152\129\236\158\144 \235\176\152\236\167\128, \237\136\172\234\181\172. \234\176\145\236\152\183, \236\158\165\234\176\145, \236\139\160\235\176\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nCreates Operator Ring, Helmet, Armor, Gloves, and Shoes.", "\236\154\180\236\152\129\236\158\144 \236\158\165\235\185\132\nGM\232\163\133\229\164\135", "\236\154\180\236\152\129\236\158\144 \235\176\152\236\167\128, \237\136\172\234\181\172. \234\176\145\236\152\183, \236\158\165\234\176\145, \236\139\160\235\176\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144GM\230\136\146\230\140\135\239\188\140\229\164\180\231\155\148\239\188\140\233\147\160\231\148\178\239\188\140\230\137\139\229\165\151\239\188\140\233\158\139\229\173\144", true)
  CREATE_BUTTON(1, 0, "\237\157\145\235\182\132 \236\177\132\236\154\176\234\184\176\nMax BS Rage", "UpAdrenalin()", 0, "\237\157\145\236\160\149\235\160\185\236\157\152 \235\182\132\235\133\184 \236\136\152\236\185\152\235\165\188 500% \236\152\172\235\160\164\236\164\141\235\139\136\235\139\164.\nFills Black Spirit's Rage up to 500%.", "\237\157\145\235\182\132 \236\177\132\236\154\176\234\184\176\n\229\161\171\230\187\161\233\187\145\231\178\190\231\129\181\231\154\132\230\132\164\230\128\146", "\237\157\145\236\160\149\235\160\185\236\157\152 \235\182\132\235\133\184 \236\136\152\236\185\152\235\165\188 500% \236\152\172\235\160\164\236\164\141\235\139\136\235\139\164.\n\233\187\145\231\178\190\231\129\181\231\154\132\230\132\164\230\128\146\230\149\176\229\128\188\229\138\160500%", true)
  CREATE_BUTTON(2, 0, "\236\163\188\235\179\128\235\170\172\236\138\164\237\132\176 \236\178\152\236\185\152\nKill nearby mob", "KillNearAllMonster()", 0, "\235\130\180 \236\163\188\235\179\128\236\157\152 \235\170\168\235\147\160 \235\170\172\236\138\164\237\132\176\235\147\164\236\157\132 \236\178\152\236\185\152\237\149\169\235\139\136\235\139\164.\nKill nearby mob.", "\236\163\188\235\179\128\235\170\172\236\138\164\237\132\176 \236\178\152\236\185\152\n\230\184\133\233\153\164\229\145\168\229\155\180\230\137\128\230\156\137\230\128\170\231\137\169", "\235\130\180 \236\163\188\235\179\128\236\157\152 \235\170\168\235\147\160 \235\170\172\236\138\164\237\132\176\235\147\164\236\157\132 \236\178\152\236\185\152\237\149\169\235\139\136\235\139\164.\n\230\184\133\233\153\164\229\145\168\229\155\180\231\154\132\230\137\128\230\156\137\230\128\170\231\137\169", true)
  CREATE_BUTTON(3, 0, "\236\163\188\235\179\128 \236\139\156\236\178\180 \235\163\168\237\140\133\nLoot nearby", "LootNearAll()", 0, "\236\163\188\235\179\128 \235\170\168\235\147\160 \236\160\132\235\166\172\237\146\136\235\147\164\236\157\132 \235\163\187\237\149\169\235\139\136\235\139\164.\nLoot everything nearby.", "\236\163\188\235\179\128 \236\139\156\236\178\180 \235\163\168\237\140\133\n\230\141\161\229\143\150\229\145\168\229\155\180\229\176\184\228\189\147\231\154\132\230\142\137\232\144\189\231\137\169\227\128\129", "\236\163\188\235\179\128 \235\170\168\235\147\160 \236\160\132\235\166\172\237\146\136\235\147\164\236\157\132 \235\163\187\237\149\169\235\139\136\235\139\164.\n\230\141\161\229\143\150\229\145\168\229\155\180\229\176\184\228\189\147\231\154\132\230\137\128\230\156\137\230\142\137\232\144\189\231\137\169", true)
  CREATE_BUTTON(4, 0, "\235\170\172\236\138\164\237\132\176\236\178\152\236\185\152\236\136\152 \236\157\152\235\162\176\nKill quests", "killmonsterquest()", 0, "\236\160\132 \236\167\128\236\151\173\236\157\132 \235\140\128\236\131\129\236\156\188\235\161\156 \237\149\156 \235\170\172\236\138\164\237\132\176 \236\178\152\236\185\152\236\136\152 \237\153\149\236\157\184 \236\157\152\235\162\176\235\165\188 \236\136\152\236\163\188\237\149\169\235\139\136\235\139\164.\nAccepts kill quest", "\235\170\172\236\138\164\237\132\176\236\178\152\236\185\152\236\136\152 \236\157\152\235\162\176\n\229\135\187\230\157\128\230\128\170\231\137\169\230\149\176\233\135\143\228\187\187\229\138\161", "\236\160\132 \236\167\128\236\151\173\236\157\132 \235\140\128\236\131\129\236\156\188\235\161\156 \237\149\156 \235\170\172\236\138\164\237\132\176 \236\178\152\236\185\152\236\136\152 \237\153\149\236\157\184 \236\157\152\235\162\176\235\165\188 \236\136\152\236\163\188\237\149\169\235\139\136\235\139\164.\n\230\142\165\229\143\151\229\175\185\229\133\168\229\156\176\229\140\186\231\154\132\229\135\187\230\157\128\230\128\170\231\137\169\230\149\176\233\135\143\231\161\174\232\174\164\231\154\132\228\187\187\229\138\161", true)
  CREATE_BUTTON(5, 0, "\235\130\180 HP \236\160\132\236\178\180\237\154\140\235\179\181\nRecover Max HP", "SetMyHp(100)", 0, "\236\158\144\236\139\160 \236\186\144\235\166\173\237\132\176\236\157\152 \236\178\180\235\160\165\236\157\132 \236\181\156\235\140\128\236\185\152\235\161\156 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\nYour character recovers full HP.", "\235\130\180 HP \236\160\132\236\178\180\237\154\140\235\179\181\n\230\129\162\229\164\141\232\135\170\229\183\177\231\154\132\229\133\168\233\131\168\231\148\159\229\145\189\229\128\188", "\236\158\144\236\139\160 \236\186\144\235\166\173\237\132\176\236\157\152 \236\178\180\235\160\165\236\157\132 \236\181\156\235\140\128\236\185\152\235\161\156 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\n\230\129\162\229\164\141\232\135\170\229\183\177\232\167\146\232\137\178\231\154\132\230\137\128\230\156\137\231\148\159\229\145\189\229\128\188", true)
  CREATE_BUTTON(6, 0, "\236\162\140\237\145\156 \237\153\149\236\157\184/\235\179\181\236\130\172\nRecord location", "PrintHereCopy()", 0, "\237\152\132\236\158\172 \237\148\140\235\160\136\236\157\180\236\150\180 \236\186\144\235\166\173\237\132\176 \236\162\140\237\145\156\235\165\188 \236\139\156\236\138\164\237\133\156 \235\169\148\236\132\184\236\167\128\235\161\156 \236\182\156\235\160\165\236\139\156\237\130\181\235\139\136\235\139\164. \235\152\144\237\149\156 \237\149\180\235\139\185 \236\162\140\237\145\156\235\138\148 \235\179\181\236\130\172\235\144\169\235\139\136\235\139\164.\nDisplay current character location coordinates as a system message and copies the info.", "\236\162\140\237\145\156 \237\153\149\236\157\184/\235\179\181\236\130\172\n\231\161\174\232\174\164/\229\164\141\229\136\182\229\157\144\230\160\135", "\237\152\132\236\158\172 \237\148\140\235\160\136\236\157\180\236\150\180 \236\186\144\235\166\173\237\132\176 \236\162\140\237\145\156\235\165\188 \236\139\156\236\138\164\237\133\156 \235\169\148\236\132\184\236\167\128\235\161\156 \236\182\156\235\160\165\236\139\156\237\130\181\235\139\136\235\139\164. \235\152\144\237\149\156 \237\149\180\235\139\185 \236\162\140\237\145\156\235\138\148 \235\179\181\236\130\172\235\144\169\235\139\136\235\139\164.\n\228\187\165\231\179\187\231\187\159\230\182\136\230\129\175\229\135\186\231\164\186\231\142\176\229\156\168\231\142\169\229\174\182\232\167\146\232\137\178\231\154\132\229\157\144\230\160\135\239\188\140\229\185\182\229\164\141\229\136\182\229\133\182\229\157\144\230\160\135", true)
  CREATE_BUTTON(7, 0, "\235\140\128\236\131\129 HP \237\153\149\236\157\184/\235\179\181\236\130\172\nRecord HP", "`HereCopy()", 0, "\237\131\128\234\178\159\236\157\152 \237\152\132\236\158\172 hp\236\153\128 %\235\165\188 \236\177\132\237\140\133\236\176\189\236\151\144 \236\182\156\235\160\165\236\139\156\237\130\181\235\139\136\235\139\164. \235\152\144\237\149\156 \237\149\180\235\139\185 \234\176\146\236\157\128 \235\179\181\236\130\172\235\144\169\235\139\136\235\139\164.\nDisplays the target's HP and HP % in the chat window and copies the info.", "\235\140\128\236\131\129 HP \237\153\149\236\157\184/\235\179\181\236\130\172\n\231\155\174\230\160\135\231\148\159\229\145\189\229\128\188\231\161\174\232\174\164/\229\164\141\229\136\182", "\237\131\128\234\178\159\236\157\152 \237\152\132\236\158\172 hp\236\153\128 %\235\165\188 \236\177\132\237\140\133\236\176\189\236\151\144 \236\182\156\235\160\165\236\139\156\237\130\181\235\139\136\235\139\164. \235\152\144\237\149\156 \237\149\180\235\139\185 \234\176\146\236\157\128 \235\179\181\236\130\172\235\144\169\235\139\136\235\139\164.\n\232\129\138\229\164\169\230\160\143\228\184\138\229\135\186\231\164\186\231\155\174\230\160\135\229\175\185\232\177\161\231\154\132\229\189\147\229\137\141\231\148\159\229\145\189\229\128\188\229\146\140\231\153\190\229\136\134\230\175\148\229\185\182\228\184\148\229\164\141\229\136\182\229\133\182\230\149\176\229\128\188", true)
  CREATE_BUTTON(8, 0, "\236\186\144\235\166\173\237\132\176 \237\130\164 \237\153\149\236\157\184\nCheck char key", "ShowCharacterKey()", 0, "\237\152\132\236\158\172 \236\157\184\237\132\176\235\158\153\236\133\152 \236\131\129\237\131\156 \236\186\144\235\166\173\237\132\176\236\157\152 \236\186\144\235\166\173\237\132\176 \237\130\164\234\176\146\236\157\132 \237\153\149\236\157\184\237\149\169\235\139\136\235\139\164.\nChecks the character key of the character you are currently interacting with.", "\236\186\144\235\166\173\237\132\176 \237\130\164 \237\153\149\236\157\184\n\231\161\174\232\174\164\230\184\184\230\136\143\232\167\146\232\137\178\231\154\132key", "\237\152\132\236\158\172 \236\157\184\237\132\176\235\158\153\236\133\152 \236\131\129\237\131\156 \236\186\144\235\166\173\237\132\176\236\157\152 \236\186\144\235\166\173\237\132\176 \237\130\164\234\176\146\236\157\132 \237\153\149\236\157\184\237\149\169\235\139\136\235\139\164.\n\230\159\165\231\156\139\229\189\147\229\137\141\228\186\146\229\138\168\231\138\182\230\128\129\231\154\132\232\167\146\232\137\178\231\154\132key\229\128\188", true)
  CREATE_BUTTON(9, 0, "\237\142\171 \237\150\137\235\143\153\235\160\165 \237\154\140\235\179\181\nRecover pet", "AddHungryFull()", 0, "\234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\176\152\235\160\164\235\143\153\235\172\188\235\147\164\236\157\152 \237\150\137\235\143\153\235\160\165\236\157\132 \235\170\168\235\145\144 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\nRecovers the stamina of all the pets you have out.", "\237\142\171 \237\150\137\235\143\153\235\160\165 \237\154\140\235\179\181\n\230\129\162\229\164\141\229\174\160\231\137\169\232\161\140\229\138\168\229\138\155", "\234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\176\152\235\160\164\235\143\153\235\172\188\235\147\164\236\157\152 \237\150\137\235\143\153\235\160\165\236\157\132 \235\170\168\235\145\144 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\n\230\129\162\229\164\141\229\183\178\229\143\150\229\135\186\231\154\132\230\137\128\230\156\137\229\174\160\231\137\169\231\154\132\232\161\140\229\138\168\229\138\155", true)
  CREATE_BUTTON(0, 1, "\236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148\nReset Cooldown", "ClearPlayerSkillCoolTime()", 0, "\234\184\176\236\136\160/\234\184\180\234\184\137\237\131\136\236\182\156/\237\148\132\235\166\172\236\133\139 \236\191\168\237\131\128\236\158\132\236\157\132 \236\180\136\234\184\176\237\153\148\237\149\169\235\139\136\235\139\164.\nResets the cooldown of Skills, Escape, and presets.", "\236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148\n\233\135\141\231\189\174CD", "\234\184\176\236\136\160/\234\184\180\234\184\137\237\131\136\236\182\156/\237\148\132\235\166\172\236\133\139 \236\191\168\237\131\128\236\158\132\236\157\132 \236\180\136\234\184\176\237\153\148\237\149\169\235\139\136\235\139\164.\n\233\135\141\231\189\174\230\138\128\230\156\175/\231\180\167\230\128\165\233\128\131\232\132\177/\233\162\132\232\174\190\231\154\132\229\134\183\229\141\180\230\151\182\233\151\180", true)
  CREATE_BUTTON(1, 1, "\235\178\132\237\148\132/\235\148\148\235\178\132\237\148\132 \236\160\156\234\177\176\nClear buff/debuff", "ClearBuff()", 0, "\235\178\132\237\148\132 \235\176\143 \235\148\148\235\178\132\237\148\132 \236\160\156\234\177\176(\236\158\172\236\160\145\236\134\141 \237\149\132\236\154\148)\nRemoves all applied buffs and debuffs. (you must re-login after clicking this.)", "\235\178\132\237\148\132/\235\148\148\235\178\132\237\148\132 \236\160\156\234\177\176\n\231\167\187\233\153\164\229\162\158\231\155\138/\229\135\143\231\155\138\230\149\136\230\158\156", "\235\178\132\237\148\132 \235\176\143 \235\148\148\235\178\132\237\148\132 \236\160\156\234\177\176(\236\158\172\236\160\145\236\134\141 \237\149\132\236\154\148)\n\231\167\187\233\153\164\229\162\158\231\155\138\229\146\140\229\135\143\231\155\138\230\149\136\230\158\156(\233\156\128\232\166\129\233\135\141\230\150\176\231\153\187\229\189\149)", true)
  CREATE_BUTTON(2, 1, "\234\179\181\237\151\140\235\143\132 Exp\nContribute EXP", "ContributionExp()", 0, "\234\179\181\237\151\140\235\143\132 \234\178\189\237\151\152\236\185\152\235\165\188 \237\154\141\235\147\157\237\149\169\235\139\136\235\139\164. \236\160\129\235\139\185\237\149\156 \236\160\149\235\143\132\234\185\140\236\167\128\235\167\140 \236\130\172\236\154\169 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.\nGain contribution EXP. Do not use this too much.", "\234\179\181\237\151\140\235\143\132 Exp\n\232\180\161\231\140\174\229\186\166\231\187\143\233\170\140\229\128\188", "\234\179\181\237\151\140\235\143\132 \234\178\189\237\151\152\236\185\152\235\165\188 \237\154\141\235\147\157\237\149\169\235\139\136\235\139\164. \236\160\129\235\139\185\237\149\156 \236\160\149\235\143\132\234\185\140\236\167\128\235\167\140 \236\130\172\236\154\169 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.\n\232\142\183\229\190\151\232\180\161\231\140\174\229\186\166\231\187\143\233\170\140\229\128\188\239\188\140\232\175\183\233\128\130\229\186\166\231\154\132\228\189\191\231\148\168", true)
  CREATE_BUTTON(3, 1, "\236\167\128\236\139\157 \237\154\141\235\147\157\nGet Knowledge", "CreateKnowledge()", 0, "\236\157\184\235\172\188 \235\176\143 \236\167\128\237\152\149 \236\167\128\236\139\157\236\157\132 \237\154\141\235\147\157\237\149\169\235\139\136\235\139\164. \234\184\176\236\154\180 \236\152\172\235\166\172\235\138\148 \236\154\169\235\143\132\nGain knowledge about people and geography.", "\236\167\128\236\139\157 \237\154\141\235\147\157\n\232\142\183\229\190\151\231\159\165\232\175\134", "\236\157\184\235\172\188 \235\176\143 \236\167\128\237\152\149 \236\167\128\236\139\157\236\157\132 \237\154\141\235\147\157\237\149\169\235\139\136\235\139\164. \234\184\176\236\154\180 \236\152\172\235\166\172\235\138\148 \236\154\169\235\143\132\n\232\142\183\229\190\151\228\187\187\229\138\161\229\146\140\229\156\176\229\189\162\231\159\165\232\175\134/\230\143\144\233\171\152\232\131\189\233\135\143\231\154\132\231\148\168\233\128\148", true)
  CREATE_BUTTON(4, 1, "\236\181\156\235\140\128 \234\184\176\236\154\180 +300\nMax energy +300", "Wp300()", 0, "\236\181\156\235\140\128 \234\184\176\236\154\180 300 \236\166\157\234\176\128, \236\158\172\236\160\145\236\134\141 \236\139\156 \236\180\136\234\184\176\237\153\148\nIncreases your max energy by +300. Resets when you re-login.", "\236\181\156\235\140\128 \234\184\176\236\154\180 +300\n\230\156\128\229\164\167\232\131\189\233\135\143\229\128\188 +300", "\236\181\156\235\140\128 \234\184\176\236\154\180 300 \236\166\157\234\176\128, \236\158\172\236\160\145\236\134\141 \236\139\156 \236\180\136\234\184\176\237\153\148\n\230\156\128\229\164\167\232\131\189\233\135\143\229\128\188\229\162\158\229\138\160300, \233\135\141\230\150\176\231\153\187\229\189\149\230\151\182\233\135\141\231\189\174", true)
  CREATE_BUTTON(5, 1, "\234\184\176\236\154\180 \236\160\132\236\178\180\237\154\140\235\179\181\nRecover Energy", "RecoverWp()", 0, "\234\184\176\236\154\180\236\157\132 \236\181\156\235\140\128\236\185\152\235\161\156 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\nRecovers to your max energy.", "\234\184\176\236\154\180 \236\160\132\236\178\180\237\154\140\235\179\181\n\230\129\162\229\164\141\230\137\128\230\156\137\232\131\189\233\135\143\229\128\188", "\234\184\176\236\154\180\236\157\132 \236\181\156\235\140\128\236\185\152\235\161\156 \237\154\140\235\179\181\237\149\169\235\139\136\235\139\164.\n\230\129\162\229\164\141\232\135\179\230\156\128\229\164\167\232\131\189\233\135\143\229\128\188", true)
  CREATE_BUTTON(6, 1, "\235\176\128\236\139\164 1\236\139\156\234\176\132 \236\182\169\236\160\132\nPersonal Field Time", "AgrisFieldChargeQA()", 0, "\235\176\128\236\139\164 \236\139\156\234\176\132 \236\182\169\236\160\132\nPersonal Field Time ADD.", "\235\176\128\236\139\164 1\236\139\156\234\176\132 \236\182\169\236\160\132\n\229\175\134\229\174\164\229\133\133\228\184\128\228\184\170\229\176\143\230\151\182", "\235\176\128\236\139\164 \236\139\156\234\176\132 \236\182\169\236\160\132\n\229\133\133\229\128\188\229\175\134\229\174\164\230\151\182\233\151\180", true)
  CREATE_BUTTON(7, 1, "\235\176\128\236\139\164 \237\140\168\235\132\144\237\139\176 \236\160\156\234\177\176\nPersonal Field Penalty", "AgrisFieldClearQA()", 0, "\235\176\128\236\139\164 \237\140\168\235\132\144\237\139\176 \236\160\156\234\177\176.\nPersonal Field Penalty Clear.", "\235\176\128\236\139\164 \237\140\168\235\132\144\237\139\176 \236\160\156\234\177\176\n\231\167\187\233\153\164\229\175\134\229\174\164\229\164\132\231\189\154", "\235\176\128\236\139\164 \237\140\168\235\132\144\237\139\176 \236\160\156\234\177\176.\n\231\167\187\233\153\164\229\175\134\229\174\164\229\164\132\231\189\154", true)
  CREATE_BUTTON(8, 1, "\236\149\132\234\183\184\235\166\172\236\138\164 \236\182\169\236\160\132\nAgris Point", "AgrisPointChargeQA()", 0, "\236\149\132\234\183\184\235\166\172\236\138\164 \237\143\172\236\157\184\237\138\184 \236\182\169\236\160\132.\nAgris Point Charge.", "\236\149\132\234\183\184\235\166\172\236\138\164 \236\182\169\236\160\132\n\229\133\133\229\128\188\233\152\191\230\136\136\233\135\140\230\150\175", "\236\149\132\234\183\184\235\166\172\236\138\164 \237\143\172\236\157\184\237\138\184 \236\182\169\236\160\132.\n\229\133\133\229\128\188\233\152\191\230\136\136\233\135\140\230\150\175\231\130\185\230\149\176", true)
  CREATE_BUTTON(0, 2, "\237\152\132\236\158\172\236\132\156\235\178\132\236\139\156\234\176\132\nCurrent time", "CheckServerTime()", 0, "\237\152\132\236\158\172 \236\132\156\235\178\132\236\139\156\234\176\132 \237\153\149\236\157\184\nShows the server time of the server you are currently in.", "\237\152\132\236\158\172\236\132\156\235\178\132\236\139\156\234\176\132\n\231\155\174\229\137\141\230\156\141\229\138\161\229\140\186\231\154\132\230\151\182\233\151\180", "\237\152\132\236\158\172 \236\132\156\235\178\132\236\139\156\234\176\132 \237\153\149\236\157\184\n\230\159\165\231\156\139\231\155\174\229\137\141\230\156\141\229\138\161\229\140\186\231\154\132\230\151\182\233\151\180", true)
  CREATE_BUTTON(1, 2, "\235\130\180\234\181\172\235\143\132 \234\176\144\236\134\140\nReduce dura", "decreaseendurance()", 0, "\236\158\165\236\176\169\237\149\156 \235\170\168\235\147\160 \236\149\132\236\157\180\237\133\156\236\157\152 \235\130\180\234\181\172\235\143\132\235\165\188 49 \234\176\144\236\134\140\236\139\156\237\130\181\235\139\136\235\139\164. \237\149\180\235\139\185 \235\178\132\237\138\188 \236\130\172\236\154\169 \236\139\156 \237\142\132\236\157\152\236\131\129 \235\130\180\234\181\172\235\143\132\234\176\128 \235\150\168\236\150\180\236\167\136 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.\nReduces the durability of all the gear you have equipped down to 49. This can reduce the durability of pearl outfits.", "\235\130\180\234\181\172\235\143\132 \234\176\144\236\134\140\n\229\135\143\229\176\145\232\128\144\228\185\133\229\186\166", "\236\158\165\236\176\169\237\149\156 \235\170\168\235\147\160 \236\149\132\236\157\180\237\133\156\236\157\152 \235\130\180\234\181\172\235\143\132\235\165\188 49 \234\176\144\236\134\140\236\139\156\237\130\181\235\139\136\235\139\164. \237\149\180\235\139\185 \235\178\132\237\138\188 \236\130\172\236\154\169 \236\139\156 \237\142\132\236\157\152\236\131\129 \235\130\180\234\181\172\235\143\132\234\176\128 \235\150\168\236\150\180\236\167\136 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.\n\229\135\143\229\176\145\230\137\128\230\156\137\228\189\169\230\136\180\232\163\133\229\164\135\231\154\132\232\128\144\228\185\133\229\186\166\232\135\17949\239\188\140\228\189\191\231\148\168\229\133\182\233\148\174\231\154\132\232\175\157\239\188\140\231\143\141\231\143\160\230\156\141\232\163\133\231\154\132\232\128\144\228\185\133\229\186\166\228\188\154\229\135\143\229\176\145", true)
  CREATE_BUTTON(2, 2, "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176 ON\nAuto-roll ON", "ItemBoxGo(1)", 0, "\235\163\176\235\160\155\236\157\132 \236\158\144\235\143\153\236\156\188\235\161\156 \234\185\157\235\139\136\235\139\164.\nAutomates the roulettes.", "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176 ON\n\232\135\170\229\138\168\232\189\174\231\155\152 ON", "\235\163\176\235\160\155\236\157\132 \236\158\144\235\143\153\236\156\188\235\161\156 \234\185\157\235\139\136\235\139\164.\n\229\188\128\229\144\175\232\135\170\229\138\168\232\189\174\231\155\152", true)
  CREATE_BUTTON(3, 2, "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176 OFF\nAuto-roll OFF", "ItemBoxGo(0)", 0, "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176\235\165\188 \236\162\133\235\163\140\237\149\169\235\139\136\235\139\164.\nTurns off the automated roulettes.", "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176 OFF\n\232\135\170\229\138\168\232\189\174\231\155\152 OFF", "\235\163\176\235\160\155 \236\158\144\235\143\153\234\185\140\234\184\176\235\165\188 \236\162\133\235\163\140\237\149\169\235\139\136\235\139\164.\n\231\187\147\230\157\159\232\135\170\229\138\168\232\189\174\231\155\152", true)
  CREATE_BUTTON(4, 2, "\234\177\176\235\158\152\236\134\140 \236\139\156\236\132\184 \234\176\177\236\139\160\nRefresh market", "AutoUpdateMarket(6)", 0, "\234\177\176\235\158\152\236\134\140 \236\139\156\236\132\184\235\165\188 \234\176\177\236\139\160\237\149\169\235\139\136\235\139\164.\nRefreshes the market prices.", "\234\177\176\235\158\152\236\134\140 \236\139\156\236\132\184 \234\176\177\236\139\160\n\230\155\180\230\150\176\228\186\164\230\152\147\230\137\128\229\184\130\228\187\183", "\234\177\176\235\158\152\236\134\140 \236\139\156\236\132\184\235\165\188 \234\176\177\236\139\160\237\149\169\235\139\136\235\139\164.\n\230\155\180\230\150\176\228\186\164\230\152\147\230\137\128\231\154\132\229\184\130\228\187\183", true)
  CREATE_BUTTON(5, 2, "\234\176\149\237\153\148 \237\133\140\236\138\164\237\138\184\nTest Enhancing", "enhancingtest()", 0, "\234\176\149\237\153\148 \237\133\140\236\138\164\237\138\184\237\149\160 \236\136\152 \236\158\136\235\143\132\235\161\157 \236\158\165\235\185\132\236\153\128 \234\176\149\237\153\148 \236\158\172\235\163\140\235\147\164\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nCreates gear and materials required to test enhancement.", "\234\176\149\237\153\148 \237\133\140\236\138\164\237\138\184\n\229\188\186\229\140\150\230\181\139\232\175\149", "\234\176\149\237\153\148 \237\133\140\236\138\164\237\138\184\237\149\160 \236\136\152 \236\158\136\235\143\132\235\161\157 \236\158\165\235\185\132\236\153\128 \234\176\149\237\153\148 \236\158\172\235\163\140\235\147\164\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\228\184\186\228\186\134\230\181\139\232\175\149\229\188\186\229\140\150\239\188\140\229\136\155\229\187\186\232\163\133\229\164\135\229\146\140\229\188\186\229\140\150\230\157\144\230\150\153", true)
  CREATE_BUTTON(0, 3, "\236\132\177\237\150\165\236\185\152 \236\166\157\234\176\128\nKarma +100k", "SetMyTendency(100000)", 0, "\236\186\144\235\166\173\237\132\176 \236\132\177\237\150\165\236\185\152 +100,000\nCharacter karma increased by +100,000", "\236\132\177\237\150\165\236\185\152 \236\166\157\234\176\128\n\229\162\158\229\138\160\229\128\190\229\144\145\229\128\188", "\236\186\144\235\166\173\237\132\176 \236\132\177\237\150\165\236\185\152 +100,000\n\232\167\146\232\137\178\229\128\190\229\144\145\229\128\188 +100,000", true)
  CREATE_BUTTON(1, 3, "\236\132\177\237\150\165\236\185\152 \234\176\144\236\134\140\nKarma -100k", "SetMyTendency(-100000)", 0, "\236\186\144\235\166\173\237\132\176 \236\132\177\237\150\165\236\185\152 -100,000\nCharacter karma decreased by -100,000", "\236\132\177\237\150\165\236\185\152 \234\176\144\236\134\140\n\229\135\143\229\176\145\229\128\190\229\144\145\229\128\188", "\236\186\144\235\166\173\237\132\176 \236\132\177\237\150\165\236\185\152 -100,000\n\232\167\146\232\137\178\229\128\190\229\144\145\229\128\188 -100,000", true)
  CREATE_BUTTON(2, 3, "\236\185\156\235\176\128\235\143\132 \236\166\157\234\176\128 +100\nIntimacy +100", "intimacy(100)", 0, "\236\161\176\236\164\128 \235\140\128\236\131\129 \236\185\156\235\176\128\235\143\132 100 \236\166\157\234\176\128\n", "\236\185\156\235\176\128\235\143\132 \236\166\157\234\176\128 +100\n\229\162\158\229\138\160\228\186\178\229\175\134\229\186\166 +100", "\236\161\176\236\164\128 \235\140\128\236\131\129 \236\185\156\235\176\128\235\143\132 100 \236\166\157\234\176\128\n\231\158\132\229\135\134\229\175\185\232\177\161\228\186\178\229\175\134\229\186\166\229\162\158\229\138\160100", true)
  CREATE_BUTTON(3, 3, "Reload UI", "ReloadUI()", 0, "UI\235\165\188 \235\166\172\235\161\156\235\147\156\237\149\169\235\139\136\235\139\164.\nReloads the UI.", "Reload UI", "UI\235\165\188 \235\166\172\235\161\156\235\147\156\237\149\169\235\139\136\235\139\164.\n\233\135\141\230\150\176\229\138\160\232\189\189UI", true)
  CREATE_BUTTON(4, 3, "\235\178\136\236\151\173 \237\130\164 \235\133\184\236\182\156(\236\189\152\236\134\148X)\nView LOC Key", "ToClient_ChatProcess(/displaylocalizedkey 1)", 0, "\235\178\136\236\151\173 \236\138\164\237\138\184\235\167\129 \237\130\164\235\165\188 \237\153\149\236\157\184\237\149\152\235\138\148 \235\170\133\235\160\185\236\150\180\236\158\133\235\139\136\235\139\164. \236\189\152\236\134\148\236\151\144\236\132\156\235\138\148 \236\160\136\235\140\128 \236\130\172\236\154\169\237\149\152\235\169\180 \236\149\136 \235\144\169\235\139\136\235\139\164.\nDisplays translation key values. NEVER USE FOR CONSOLE.", "\235\178\136\236\151\173 \237\130\164 \235\133\184\236\182\156(\236\189\152\236\134\148X)\n\230\152\190\231\164\186\231\191\187\232\175\145\233\148\174(\228\184\187\230\156\186\230\184\184\230\136\143X)", "\235\178\136\236\151\173 \236\138\164\237\138\184\235\167\129 \237\130\164\235\165\188 \237\153\149\236\157\184\237\149\152\235\138\148 \235\170\133\235\160\185\236\150\180\236\158\133\235\139\136\235\139\164. \236\189\152\236\134\148\236\151\144\236\132\156\235\138\148 \236\160\136\235\140\128 \236\130\172\236\154\169\237\149\152\235\169\180 \236\149\136 \235\144\169\235\139\136\235\139\164.\n\230\159\165\231\156\139\231\191\187\232\175\145\229\173\151\231\172\166\228\184\178\233\148\174\231\155\152\231\154\132\229\145\189\228\187\164\232\175\141. \228\184\187\230\156\186\228\184\138\231\187\157\229\175\185\228\184\141\232\166\129\228\189\191\231\148\168", true)
end
function QASupport_AutomationPanel_CreateControl_Tab1()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\235\170\169\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\nGo to location", "TeleportToDestination()", 1, "\235\170\169\236\160\129\236\167\128(\235\185\155\234\184\176\235\145\165)\235\161\156 \237\133\148\235\160\136\237\143\172\237\138\184\237\149\169\235\139\136\235\139\164.\nTeleports you to a selected location.", "\235\170\169\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\155\174\231\154\132\229\156\176", "\235\170\169\236\160\129\236\167\128(\235\185\155\234\184\176\235\145\165)\235\161\156 \237\133\148\235\160\136\237\143\172\237\138\184\237\149\169\235\139\136\235\139\164.\n\231\158\172\233\151\180\231\167\187\229\138\168\232\135\179\231\155\174\231\154\132\229\156\176(\229\133\137\230\159\177)", true)
  CREATE_BUTTON(1, 0, "\235\178\168\235\166\172\236\149\132\nVelia", "TeleportVelia1()", 1, "\235\178\168\235\166\172\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Velia Storage Keeper.", "\235\178\168\235\166\172\236\149\132\n\232\180\157\229\176\148\229\136\169\228\186\154", "\235\178\168\235\166\172\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\180\157\229\176\148\229\136\169\228\186\154\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(2, 0, "\237\149\152\236\157\180\235\141\184\nHeidel 1", "TeleportHeidel1()", 1, "\237\149\152\236\157\180\235\141\184 \236\130\188\234\177\176\235\166\172\235\161\156 \236\157\180\235\143\153\nTeleports you to Heidel tri-junction.", "\237\149\152\236\157\180\235\141\184\n\230\181\183\229\156\176\229\132\191", "\237\149\152\236\157\180\235\141\184 \236\130\188\234\177\176\235\166\172\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\181\183\229\156\176\229\176\148\228\184\137\229\178\148\232\183\175", true)
  CREATE_BUTTON(3, 0, "\236\185\188\237\142\152\236\152\168\nCalpheon", "TeleportCalpheon1()", 1, "\236\185\188\237\142\152\236\152\168 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Calpheon Storage Keeper.", "\236\185\188\237\142\152\236\152\168\n\229\141\161\229\176\148\228\189\169\230\129\169", "\236\185\188\237\142\152\236\152\168 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\229\176\148\228\189\169\230\129\169\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(4, 0, "\236\149\140\237\139\176\235\133\184\235\176\148\nAltinova", "TeleportAltinova1()", 1, "\236\149\140\237\139\176\235\133\184\235\176\148 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Altinova Storage Keeper.", "\236\149\140\237\139\176\235\133\184\235\176\148\n\233\152\191\230\143\144\232\175\186\231\147\166", "\236\149\140\237\139\176\235\133\184\235\176\148 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Altinova Storage Keeper.", true)
  CREATE_BUTTON(5, 0, "\235\176\156\235\160\140\236\139\156\236\149\132\nValencia", "TeleportValencia1()", 1, "\235\176\156\235\160\140\236\139\156\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Valencia Storage Keeper.", "\235\176\156\235\160\140\236\139\156\236\149\132\nValencia", "\235\176\156\235\160\140\236\139\156\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Valencia Storage Keeper.", true)
  CREATE_BUTTON(6, 0, "\234\183\184\235\157\188\235\130\152\nGrana", "TeleportGrana1()", 1, "\234\183\184\235\157\188\235\130\152 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Gr\195\161na Storage Keeper.", "\234\183\184\235\157\188\235\130\152\n\230\160\188\230\139\137\231\186\179", "\234\183\184\235\157\188\235\130\152 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\160\188\230\139\137\231\186\179\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(7, 0, "\235\147\156\235\178\164\237\129\172\235\163\172\nDuvencrune", "TeleportDuvencrune1()", 1, "\235\147\156\235\178\164\237\129\172\235\163\172 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Duvencrune Storage Keeper.", "\235\147\156\235\178\164\237\129\172\235\163\172\n\229\190\183\230\156\172\229\133\139\228\188\166", "\235\147\156\235\178\164\237\129\172\235\163\172 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\190\183\230\156\172\229\133\139\228\188\166\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(8, 0, "\236\152\164\235\147\156\235\157\189\236\139\156\236\149\132\nO'draxxia", "ToClient_qaTeleport(-172407,19586,-611464)", 1, "\236\152\164\235\147\156\235\157\189\236\139\156\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to O'draxxia Storage Keeper.", "\236\152\164\235\147\156\235\157\189\236\139\156\236\149\132\n\229\165\165\229\190\183\231\189\151\232\165\191\228\186\154", "\236\152\164\235\147\156\235\157\189\236\139\156\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\229\190\183\231\189\151\232\165\191\228\186\154\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(9, 0, "\236\151\144\236\157\188 \235\167\136\236\157\132\nEilton", "ToClient_qaTeleport(168755,16659,-389175)", 1, "\236\151\144\236\157\188 \235\167\136\236\157\132 \236\157\180\235\143\153\nTeleports you to Eilton.", "\236\151\144\236\157\188 \235\167\136\236\157\132\n\229\159\131\229\176\148\230\157\145", "\236\151\144\236\157\188 \235\167\136\236\157\132 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\159\131\229\176\148\230\157\145", true)
  CREATE_BUTTON(10, 0, "\236\152\164\237\130\172\235\163\168\236\149\132\nOquilla", "ToClient_qaTeleport(-101905,-7373,631539)", 1, "\236\152\164\237\130\172\235\163\168\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Oquilla Storage Keeper.", "\236\152\164\237\130\172\235\163\168\236\149\132\n\229\165\165\229\159\186\233\178\129\233\152\191", "\236\152\164\237\130\172\235\163\168\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\229\159\186\233\178\129\233\152\191\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(11, 0, "\235\130\168\237\143\172 \235\167\136\236\157\132\nNamPo", "TeleportNamPo()", 1, "\235\130\168\237\143\172 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153\nTeleports you to NamPo.", "\235\130\168\237\143\172 \235\167\136\236\157\132\n\229\141\151\230\181\166\230\157\145", "\235\130\168\237\143\172 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\151\230\181\166\230\157\145", true)
  CREATE_BUTTON(12, 0, "\236\149\132\236\138\164\237\142\152\235\165\180\236\185\184 \236\154\148\236\131\136\nAsparkan", "TeleportAsparkan()", 1, "\236\149\132\236\138\164\237\142\152\235\165\180\236\185\184 \236\154\148\236\131\136 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Asparkan Storage Keeper.", "\236\149\132\236\138\164\237\142\152\235\165\180\236\185\184 \236\154\148\236\131\136\n\233\152\191\230\150\175\228\189\169\229\157\142\232\166\129\229\161\158", "\236\149\132\236\138\164\237\142\152\235\165\180\236\185\184 \236\154\148\236\131\136 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\233\152\191\230\150\175\228\189\169\229\157\142\232\166\129\229\161\158\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(0, 1, "\237\148\132\235\166\172\236\186\160\nFreecam", "FreecamQA()", 1, "\237\148\132\235\166\172\236\186\160 \236\130\172\236\154\169\nFreecam.", "\237\148\132\235\166\172\236\186\160\n\232\135\170\231\148\177\232\167\134\232\167\146", "\237\148\132\235\166\172\236\186\160 \236\130\172\236\154\169\n\228\189\191\231\148\168\232\135\170\231\148\177\232\167\134\232\167\146", true)
  CREATE_BUTTON(1, 1, "\236\152\172\235\185\132\236\149\132\nOlvia", "TeleportOlvia()", 1, "\236\152\172\235\185\132\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Olvia Storage Keeper.", "\236\152\172\235\185\132\236\149\132\n\229\165\165\229\176\148\230\175\148\228\186\154", "\236\152\172\235\185\132\236\149\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\229\176\148\230\175\148\228\186\154\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(2, 1, "\237\149\152\236\157\180\235\141\184 \234\178\176\237\136\172\236\158\165\nHeidel 2", "TeleportHeidel2()", 1, "\237\149\152\236\157\180\235\141\184 \234\178\176\237\136\172\236\158\165\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Heidel Duel Arena.", "\237\149\152\236\157\180\235\141\184 \234\178\176\237\136\172\236\158\165\n\230\181\183\229\156\176\229\176\148\229\134\179\230\150\151\229\156\186", "\237\149\152\236\157\180\235\141\184 \234\178\176\237\136\172\236\158\165\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\181\183\229\156\176\229\176\148\229\134\179\230\150\151\229\156\186", true)
  CREATE_BUTTON(3, 1, "\236\188\128\237\148\140\235\158\128\nKeplan", "TeleportKeplan()", 1, "\236\188\128\237\148\140\235\158\128 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Keplan Storage Keeper.", "\236\188\128\237\148\140\235\158\128\n\229\135\175\230\179\162\229\178\154", "\236\188\128\237\148\140\235\158\128 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\135\175\230\179\162\229\178\154\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(4, 1, "\237\131\128\235\166\172\237\148\132 \235\167\136\236\157\132\nTarif", "TeleportTarif()", 1, "\237\131\128\235\166\172\237\148\132 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Tarif Storage Keeper.", "\237\131\128\235\166\172\237\148\132 \235\167\136\236\157\132\n\229\161\148\229\136\169\230\179\162\230\157\145", "\237\131\128\235\166\172\237\148\132 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\229\136\176\229\161\148\229\136\169\230\179\162\230\157\145\228\187\147\229\186\147\229\174\136\229\141\171\229\137\141", true)
  CREATE_BUTTON(5, 1, "\236\149\132\235\160\136\237\149\152\236\158\144 \235\167\136\236\157\132\nArehaza", "TeleportArehaza()", 1, "\236\149\132\235\160\136\237\149\152\236\158\144 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153\nTeleports you to Arehaza.", "\236\149\132\235\160\136\237\149\152\236\158\144 \235\167\136\236\157\132\n\229\165\165\233\155\183\229\147\136\230\137\142\230\157\145", "\236\149\132\235\160\136\237\149\152\236\158\144 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\233\155\183\229\147\136\230\137\142\230\157\145", true)
  CREATE_BUTTON(6, 1, "\236\167\128\237\152\156\236\157\152 \234\179\160\235\170\169\nOld Wisdom Tree", "TeleportWisdomTree()", 1, "\236\167\128\237\152\156\236\157\152 \234\179\160\235\170\169\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Old Wisdom Tree.", "\236\167\128\237\152\156\236\157\152 \234\179\160\235\170\169\n\230\153\186\230\133\167\231\154\132\229\143\164\230\156\168", "\236\167\128\237\152\156\236\157\152 \234\179\160\235\170\169\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\153\186\230\133\167\231\154\132\229\143\164\230\156\168", true)
  CREATE_BUTTON(11, 1, "\235\139\172\235\178\140 \235\167\136\236\157\132\nDalbeol", "TeleportDalbeol()", 1, "\235\139\172\235\178\140 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153.\nTeleports you to Dalbeol", "\235\139\172\235\178\140 \235\167\136\236\157\132\n\230\156\136\232\156\130\230\157\145", "\235\139\172\235\178\140 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153.\n\231\167\187\229\138\168\232\135\179\230\156\136\232\156\130\230\157\145", true)
  CREATE_BUTTON(12, 1, "\235\172\180\236\166\136\234\176\128\235\165\180 \235\167\136\236\157\132\nMuzgal", "TeleportMuzgal()", 1, "\235\172\180\236\166\136\234\176\128\235\165\180 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153.\nTeleports you to Muzgal", "\235\172\180\236\166\136\234\176\128\235\165\180 \235\167\136\236\157\132\n\231\169\134\229\133\185\229\141\161\229\176\148\230\157\145", "\235\172\180\236\166\136\234\176\128\235\165\180 \235\167\136\236\157\132\235\161\156 \236\157\180\235\143\153.\n\231\167\187\229\138\168\232\135\179\231\169\134\229\133\185\229\141\161\229\176\148\230\157\145", true)
  CREATE_BUTTON(1, 2, "\236\157\188\235\166\172\236\149\188\236\132\172\nIliya Island", "TeleportIliya()", 1, "\236\157\188\235\166\172\236\149\188\236\132\172 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Iliya Island Storage Keeper.", "\236\157\188\235\166\172\236\149\188\236\132\172\n\228\188\138\229\136\169\228\186\154\229\178\155", "\236\157\188\235\166\172\236\149\188\236\132\172 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\228\188\138\229\136\169\228\186\154\229\178\155\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(2, 2, "\234\184\128\235\166\172\236\139\156\nGlish", "TeleportGlish()", 1, "\234\184\128\235\166\172\236\139\156 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Glish Storage Keeper.", "\234\184\128\235\166\172\236\139\156\n\230\136\136\233\135\140\229\184\140", "\234\184\128\235\166\172\236\139\156 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\136\136\233\135\140\229\184\140\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(3, 2, "\236\151\144\237\142\152\235\166\172\236\149\132 \237\149\173\234\181\172 \235\167\136\236\157\132\nPort Epheria", "TeleportEpheria()", 1, "\236\151\144\237\142\152\235\166\172\236\149\132 \237\149\173\234\181\172 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Port Epheria Storage Keeper.", "\236\151\144\237\142\152\235\166\172\236\149\132 \237\149\173\234\181\172 \235\167\136\236\157\132\n\232\137\190\232\163\180\232\142\137\233\155\133\230\184\175\229\143\163\230\157\145", "\236\151\144\237\142\152\235\166\172\236\149\132 \237\149\173\234\181\172 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\137\190\232\163\180\232\142\137\233\155\133\230\184\175\229\143\163\230\157\145\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(5, 2, "\236\157\180\235\178\168\235\158\141 \236\152\164\236\149\132\236\139\156\236\138\164\nIbellab Oasis", "TeleportIbellab()", 1, "\236\157\180\235\178\168\235\158\141 \236\152\164\236\149\132\236\139\156\236\138\164\235\161\156 \236\157\180\235\143\153\nTeleports you to Ibellab Oasis.", "\236\157\180\235\178\168\235\158\141 \236\152\164\236\149\132\236\139\156\236\138\164\n\228\188\138\229\159\185\230\139\137\231\187\191\230\180\178", "\236\157\180\235\178\168\235\158\141 \236\152\164\236\149\132\236\139\156\236\138\164\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\228\188\138\229\159\185\230\139\137\231\187\191\230\180\178", true)
  CREATE_BUTTON(11, 2, "\235\134\146\236\131\136 \235\179\143\234\179\168\235\167\136\236\157\132\nByeot County", "TeleportByeot()", 1, "\235\134\146\236\131\136 \235\179\143\234\179\168\235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Byeot County.", "\235\134\146\236\131\136 \235\179\143\234\179\168\235\167\136\236\157\132\n\231\132\154\233\163\142\231\168\187\232\176\183\230\157\145", "\235\134\146\236\131\136 \235\179\143\234\179\168\235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\132\154\233\163\142\231\168\187\232\176\183\230\157\145\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(12, 2, "\235\178\160\235\158\128\235\148\148\235\165\180 \235\167\136\236\157\132\nVelandir County", "TeleportVelandir()", 1, "\235\178\160\235\158\128\235\148\148\235\165\180 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Velandir County.", "\235\178\160\235\158\128\235\148\148\235\165\180 \235\167\136\236\157\132\n\232\180\157\229\133\176\232\191\170\229\176\148\230\157\145", "\235\178\160\235\158\128\235\148\148\235\165\180 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\180\157\229\133\176\232\191\170\229\176\148\230\157\145\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(3, 3, "\237\138\184\235\160\140\237\138\184\nTrent", "TeleportTrent()", 1, "\237\138\184\235\160\140\237\138\184 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Trent Storage Keeper.", "\237\138\184\235\160\140\237\138\184\n\231\137\185\229\133\176\231\137\185", "\237\138\184\235\160\140\237\138\184 \235\167\136\236\157\132 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\137\185\229\133\176\231\137\185\228\187\147\229\186\147\229\174\136\229\141\171", true)
  CREATE_BUTTON(5, 3, "\235\172\180\236\157\180\236\191\164\nMuiquun", "TeleportMuiquun()", 1, "\235\172\180\236\157\180\236\191\164 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Muiquun Storage Keeper.", "\235\172\180\236\157\180\236\191\164\n\231\169\134\228\186\166\232\130\175", "\235\172\180\236\157\180\236\191\164 \236\176\189\234\179\160\236\167\128\234\184\176 \236\149\158\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\169\134\228\186\166\232\130\175\228\187\147\229\186\147\229\174\136\229\141\171", true)
end
function QASupport_AutomationPanel_CreateControl_Tab2()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\236\130\172\235\131\165 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\nPvE Test Set", "pvetest()", 2, "\236\130\172\235\131\165 \237\133\140\236\138\164\237\138\184\235\165\188 \236\156\132\237\149\156 \236\155\144\235\178\132\237\138\188 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\nGives you what you the entire PvE test set.", "\236\130\172\235\131\165 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\n\231\139\169\231\140\142\230\181\139\232\175\149\232\174\190\231\189\174", "\236\130\172\235\131\165 \237\133\140\236\138\164\237\138\184\235\165\188 \236\156\132\237\149\156 \236\155\144\235\178\132\237\138\188 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n\228\184\128\233\148\174\232\174\190\231\189\174\231\139\169\231\140\142\230\181\139\232\175\149", true)
  CREATE_BUTTON(1, 0, "PVP \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\nPvP Test Set", "pvptest()", 2, "301/303/370 PVP \237\148\188\237\149\180\235\159\137 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n301/303/370 PVP Damage test set.", "PVP \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\nPVP \230\181\139\232\175\149\232\174\190\231\189\174", "301/303/370 PVP \237\148\188\237\149\180\235\159\137 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n301/303/370 PVP \228\188\164\229\174\179\233\135\143\230\181\139\232\175\149\232\174\190\231\189\174", true)
  CREATE_BUTTON(2, 0, "\235\176\169\236\150\180\234\181\172 \236\182\148\234\176\128\nAddArmor", "addArmortest()", 2, "\235\169\184\234\178\129\237\149\152\235\138\148 \237\131\156\234\179\160\236\157\152 \235\176\169\236\150\180\234\181\172 \236\131\157\236\132\177", "\235\176\169\236\150\180\234\181\172 \236\182\148\234\176\128\n\233\152\178\229\133\183\232\191\189\229\138\160", "\231\148\159\230\136\144\230\182\136\231\129\173\231\154\132\229\164\170\229\143\164\231\154\132\233\152\178\229\133\183", true)
  CREATE_BUTTON(3, 0, "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\235\170\169,\237\151\136)", "addAccTest1()", 2, "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \235\170\169\234\177\184\236\157\180, \237\151\136\235\166\172\235\157\160 \236\131\157\236\132\177", "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\235\170\169,\237\151\136)\n\230\183\187\229\138\160\230\148\185\232\137\175\233\165\176\229\147\129(\233\161\185\233\147\190, \232\133\176\229\184\166)", "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \235\170\169\234\177\184\236\157\180, \237\151\136\235\166\172\235\157\160 \236\131\157\236\132\177\n\231\148\159\230\136\144\228\184\156\233\152\182\230\174\181\231\154\132\230\148\185\232\137\175\233\161\185\233\147\190\239\188\140\232\133\176\229\184\166", true)
  CREATE_BUTTON(4, 0, "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\234\183\128\234\177\184\236\157\180)", "addAccTest2()", 2, "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \234\183\128\234\177\184\236\157\180 \236\131\157\236\132\177", "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\234\183\128\234\177\184\236\157\180)\n\230\183\187\229\138\160\230\148\185\232\137\175\233\165\176\229\147\129 (\232\128\179\231\142\175)", "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \234\183\128\234\177\184\236\157\180 \236\131\157\236\132\177\n\231\148\159\230\136\144\228\184\156\233\152\182\230\174\181\231\154\132\230\148\185\232\137\175\232\128\179\231\142\175", true)
  CREATE_BUTTON(5, 0, "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\235\176\152\236\167\128)", "addAccTest3()", 2, "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \235\176\152\236\167\128 \236\131\157\236\132\177", "\234\176\156\235\159\137 \236\149\133\236\132\184\236\182\148\234\176\128(\235\176\152\236\167\128)\n\230\183\187\229\138\160\230\148\185\232\137\175\233\165\176\229\147\129 (\230\136\146\230\140\135)", "\235\143\153 \235\139\168\234\179\132\236\157\152 \234\176\156\235\159\137 \235\176\152\236\167\128 \236\131\157\236\132\177\n\231\148\159\230\136\144\228\184\156\233\152\182\230\174\181\231\154\132\230\148\185\232\137\175\230\136\146\230\140\135", true)
  CREATE_BUTTON(6, 0, "\236\160\144\237\148\132 \237\146\128 \236\132\184\237\140\133\nJump Test Set", "jumpitem()", 2, "\236\160\144\237\148\132 \236\132\184\237\140\133 \236\131\157\236\132\177\nCreates a jump set.", "\236\160\144\237\148\132 \237\146\128 \236\132\184\237\140\133\n\232\183\179\232\183\131\232\174\190\231\189\174", "\236\160\144\237\148\132 \236\132\184\237\140\133 \236\131\157\236\132\177\n\231\148\159\230\136\144\232\183\179\232\183\131\232\174\190\231\189\174", true)
  CREATE_BUTTON(8, 0, "\236\156\160\235\172\188 \236\131\157\236\132\177\nArtifact", "createRelics()", 2, "\236\160\132\237\136\172 \236\156\160\235\172\188 \236\131\157\236\132\177\nCreates artifacts used for combat.", "\236\156\160\235\172\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\129\151\231\137\169", "\236\160\132\237\136\172 \236\156\160\235\172\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\136\152\230\150\151\233\129\151\231\137\169", true)
  CREATE_BUTTON(9, 0, "\234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\nLightstone", "createStone()", 2, "\236\160\132\237\136\172 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\nCreates lightstones used for combat.", "\234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\133\137\230\152\142\231\159\179", "\236\160\132\237\136\172 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\136\152\230\150\151\229\133\137\230\152\142\231\159\179", true)
  CREATE_BUTTON(10, 0, "\236\151\176\234\184\136\236\132\157\nAlchemy Stone", "CreateAlchemyStone()", 2, "\236\163\188\236\154\148 \236\151\176\234\184\136\236\132\157 \236\131\157\236\132\177. ( \235\178\168\236\139\172, \236\152\136\235\166\172\237\140\140\234\180\180, \236\152\136\235\166\172\236\136\152\237\152\184, \236\152\136\235\166\172\236\131\157\235\170\133, \236\152\129\235\161\177\237\140\140\234\180\180, \236\152\129\235\161\177\236\136\152\237\152\184, \236\152\129\235\161\177\236\131\157\235\170\133)\nCreates alchemy stones.", "\236\151\176\234\184\136\236\132\157\n\231\130\188\233\135\145\231\159\179", "\236\163\188\236\154\148 \236\151\176\234\184\136\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\228\184\187\232\166\129\231\130\188\233\135\145\231\159\179", true)
  CREATE_BUTTON(11, 0, "\236\136\152\236\160\149\nMagic Crystal", "createCrystal2()", 2, "\236\163\188\236\154\148 \236\136\152\236\160\149 \236\131\157\236\132\177\nCreates main magic crystals.", "\236\136\152\236\160\149\n\230\176\180\230\153\182", "\236\163\188\236\154\148 \236\136\152\236\160\149 \236\131\157\236\132\177\n\231\148\159\230\136\144\228\184\187\232\166\129\230\176\180\230\153\182", true)
  CREATE_BUTTON(12, 0, "\234\176\156\235\159\137\236\132\157\nReform Stone", "createUpgradeItem()", 2, "\234\176\156\235\159\137\236\132\157 \236\131\157\236\132\177\nCreates reform stones.", "\234\176\156\235\159\137\236\132\157\n\230\148\185\232\137\175\231\159\179", "\234\176\156\235\159\137\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\148\185\232\137\175\231\159\179", true)
  CREATE_BUTTON(0, 1, "\236\160\132\236\138\185 \234\184\176\236\136\160 \236\138\181\235\147\157\nLearn Succ", "LearnAllSkill(1)", 2, "\236\160\132\236\138\185 \234\184\176\236\136\160 \236\138\181\235\147\157\nLearn succession skills.", "\236\160\132\236\138\185 \234\184\176\236\136\160 \236\138\181\235\147\157\n\228\185\160\229\190\151\231\187\167\230\137\191\230\138\128\230\156\175", "\236\160\132\236\138\185 \234\184\176\236\136\160 \236\138\181\235\147\157\n\228\185\160\229\190\151\231\187\167\230\137\191\230\138\128\230\156\175", true)
  CREATE_BUTTON(1, 1, "\234\176\129\236\132\177 \234\184\176\236\136\160 \236\138\181\235\147\157\nLearn Awaken", "LearnAllSkill(2)", 2, "\234\176\129\236\132\177 \234\184\176\236\136\160 \236\138\181\235\147\157\nLearn awakening skills.", "\234\176\129\236\132\177 \234\184\176\236\136\160 \236\138\181\235\147\157\n\228\185\160\229\190\151\232\167\137\233\134\146\230\138\128\230\156\175", "\234\176\129\236\132\177 \234\184\176\236\136\160 \236\138\181\235\147\157\n\228\185\160\229\190\151\232\167\137\233\134\146\230\138\128\230\156\175", true)
  CREATE_BUTTON(2, 1, "\237\148\132\235\166\172\236\133\139 \237\153\149\236\158\165\n+ Presets", "AddPresets()", 2, "\237\148\132\235\166\172\236\133\139 \237\153\149\236\158\165(\234\184\176\236\136\160,\236\136\152\236\160\149,\236\136\152\236\160\149 \236\185\184)\nCreates 2 Skill Preset Coupons.", "\237\148\132\235\166\172\236\133\139 \237\153\149\236\158\165\n\230\137\169\229\188\160\233\162\132\232\174\190", "\237\148\132\235\166\172\236\133\139 \237\153\149\236\158\165\n\230\137\169\229\188\160\233\162\132\232\174\190", true)
  CREATE_BUTTON(3, 1, "\234\184\176\236\136\160 \237\143\172\236\157\184\237\138\184 \237\154\141\235\147\157\n+ Skill Points", "CreateSkillPoint()", 2, "\234\184\176\236\136\160\237\143\172\236\157\184\237\138\184 1500\nCreates 1,500 skill points.", "\234\184\176\236\136\160 \237\143\172\236\157\184\237\138\184 \237\154\141\235\147\157\n\232\142\183\229\190\151\230\136\152\230\150\151\230\138\128\232\131\189\231\130\185\230\149\176", "\234\184\176\236\136\160\237\143\172\236\157\184\237\138\184 1500\n\230\136\152\230\150\151\230\138\128\232\131\189\231\130\185\230\149\176 1500", true)
  CREATE_BUTTON(4, 1, "\234\176\129\236\132\177\235\167\140\237\149\152\234\184\176\nAwaken", "awakening()", 2, "\237\149\180\235\139\185 \237\129\180\235\158\152\236\138\164 \236\160\132\236\138\185/\234\176\129\236\132\177 \236\161\176\234\177\180 \236\153\132\235\163\140.\nCompletes the requirement needed for awakening for that class.", "\234\176\129\236\132\177\235\167\140\237\149\152\234\184\176\n\232\167\137\233\134\146\229\174\140\230\136\144", "\237\149\180\235\139\185 \237\129\180\235\158\152\236\138\164 \236\160\132\236\138\185/\234\176\129\236\132\177 \236\161\176\234\177\180 \236\153\132\235\163\140.\n\229\133\182\232\129\140\228\184\154\231\187\167\230\137\191/\232\167\137\233\134\146\230\157\161\228\187\182\232\190\190\230\136\144", true)
  CREATE_BUTTON(5, 1, "\237\138\156\237\134\160\235\166\172\236\150\188 \236\153\132\235\163\140\nTutorial Skip", "QuestClearTutorial()", 2, "\236\157\188\235\160\136\236\166\136\235\157\188 \237\138\156\237\134\160\235\166\172\236\150\188 \236\138\164\237\130\181 \234\176\128\235\138\165.\nTutorial Quest Clear", "\237\138\156\237\134\160\235\166\172\236\150\188 \236\153\132\235\163\140\n\232\183\179\232\191\135\230\149\153\231\168\139\229\188\149\229\175\188", "\236\157\188\235\160\136\236\166\136\235\157\188 \237\138\156\237\134\160\235\166\172\236\150\188 \236\138\164\237\130\181 \234\176\128\235\138\165.\n\229\143\175\232\183\179\232\191\135\228\188\138\232\149\190\229\133\185\230\139\137\230\149\153\231\168\139\229\188\149\229\175\188", true)
  CREATE_BUTTON(8, 1, "\236\157\188\234\190\188(\236\136\153\236\134\140\237\149\132\236\154\148)\nHire(Req Lodge)", "workerready(30)", 2, "\236\163\188\236\157\152! \236\136\153\236\134\140\234\176\128 \235\130\168\236\149\132 \236\158\136\236\150\180\236\149\188 \236\157\188\234\190\188\236\157\180 \236\131\157\236\132\177\235\144\169\235\139\136\235\139\164. \234\176\129 \236\163\188\236\154\148 \235\143\132\236\139\156 \235\179\132 3\235\167\136\235\166\172\236\148\169 \236\131\157\236\132\177\235\144\152\235\169\176, \236\131\157\236\132\177 \237\155\132 \234\176\128\236\167\128\234\179\160 \236\158\136\235\138\148 \235\170\168\235\147\160 \236\157\188\234\190\188\236\157\180 30\235\160\136\235\178\168\235\161\156 \236\152\172\235\157\188\234\176\145\235\139\136\235\139\164.\nCreates 3 workers for each major city. After creating the workers, they all get leveled up to lv. 30. (WARNING! You must have lodging for the workers before using the function for it to create the workers.)", "\236\157\188\234\190\188(\236\136\153\236\134\140\237\149\132\236\154\148)\n\228\189\163\229\183\165(\233\156\128\232\166\129\229\174\191\232\136\141)", "\236\163\188\236\157\152! \236\136\153\236\134\140\234\176\128 \235\130\168\236\149\132 \236\158\136\236\150\180\236\149\188 \236\157\188\234\190\188\236\157\180 \236\131\157\236\132\177\235\144\169\235\139\136\235\139\164. \234\176\129 \236\163\188\236\154\148 \235\143\132\236\139\156 \235\179\132 3\235\167\136\235\166\172\236\148\169 \236\131\157\236\132\177\235\144\152\235\169\176, \236\131\157\236\132\177 \237\155\132 \234\176\128\236\167\128\234\179\160 \236\158\136\235\138\148 \235\170\168\235\147\160 \236\157\188\234\190\188\236\157\180 30\235\160\136\235\178\168\235\161\156 \236\152\172\235\157\188\234\176\145\235\139\136\235\139\164.\n\230\179\168\230\132\143\239\188\129 \229\174\191\232\136\141\230\156\137\231\169\186\228\189\141\230\137\141\229\143\175\231\148\159\230\136\144\228\189\163\229\183\165\239\188\140 \230\175\143\228\184\187\232\166\129\229\159\142\229\184\130\229\144\132\231\148\159\230\136\1443\228\184\170\239\188\140\231\148\159\230\136\144\229\144\142\230\139\165\230\156\137\231\154\132\230\137\128\230\156\137\228\189\163\229\183\165\231\173\137\231\186\167\230\143\144\229\141\135\232\135\17930\231\186\167", true)
  CREATE_BUTTON(9, 1, "\235\169\148\236\157\180\235\147\156\nMaids", "maidtest()", 2, "\235\169\148\236\157\180\235\147\156 \234\179\132\236\149\189\236\132\156 \236\131\157\236\132\177 \237\155\132 \236\158\144\235\143\153\236\130\172\236\154\169, \236\176\189\234\179\160 \235\169\148\236\157\180\235\147\156 10\234\176\156, \234\177\176\235\158\152\236\134\140 \235\169\148\236\157\180\235\147\156 10\234\176\156 (\236\163\188\236\157\152! \236\186\144\235\166\173\237\132\176\235\165\188 \234\176\128\235\167\140\237\158\136 \235\134\148\235\145\172\236\149\188 \236\158\144\235\143\153 \236\130\172\236\154\169\235\144\169\235\139\136\235\139\164.)\nCreates and automatically uses maid contracts. 5 storage maids, 5 market maids (WARNING! You character must be standing still for the contracts to be used automatically.)", "\235\169\148\236\157\180\235\147\156\n\229\138\169\230\137\139", "\235\169\148\236\157\180\235\147\156 \234\179\132\236\149\189\236\132\156 \236\131\157\236\132\177 \237\155\132 \236\158\144\235\143\153\236\130\172\236\154\169, \236\176\189\234\179\160 \235\169\148\236\157\180\235\147\156 10\234\176\156, \234\177\176\235\158\152\236\134\140 \235\169\148\236\157\180\235\147\156 10\234\176\156 (\236\163\188\236\157\152! \236\186\144\235\166\173\237\132\176\235\165\188 \234\176\128\235\167\140\237\158\136 \235\134\148\235\145\172\236\149\188 \236\158\144\235\143\153 \236\130\172\236\154\169\235\144\169\235\139\136\235\139\164.)\n\229\138\169\230\137\139\229\165\145\231\186\166\228\185\166\231\148\159\230\136\144\229\144\142\232\135\170\229\138\168\228\189\191\231\148\168\239\188\140 , \228\187\147\229\186\147\231\174\161\231\144\134\229\138\169\230\137\139 10\228\184\170, \228\186\164\230\152\147\231\174\161\231\144\134\229\138\169\230\137\139 10\228\184\170 (\230\179\168\230\132\143! \232\175\183\228\184\141\232\166\129\229\138\168\230\184\184\230\136\143\232\167\146\232\137\178\239\188\140\230\137\141\228\188\154\232\135\170\229\138\168\228\189\191\231\148\168", true)
  CREATE_BUTTON(10, 1, "\237\152\184\237\157\161,\237\158\152,\234\177\180\234\176\149\n+ Fitness EXP", "SetPhysical30()", 2, "\237\152\184\237\157\161, \237\158\152, \234\177\180\234\176\149 \234\178\189\237\151\152\236\185\152\235\165\188 \236\152\172\235\166\189\235\139\136\235\139\164. 1\235\160\136\235\178\168 \234\184\176\236\164\128 30 \234\185\140\236\167\128 \236\152\172\235\157\188\234\176\145\235\139\136\235\139\164.\nIncreases Breath, Strength, Health EXP. Raises up to 30, at lv.1.", "\237\152\184\237\157\161,\237\158\152,\234\177\180\234\176\149\n\229\145\188\229\144\184\227\128\129\229\138\155\233\135\143\227\128\129\229\129\165\229\186\183", "\237\152\184\237\157\161, \237\158\152, \234\177\180\234\176\149 \234\178\189\237\151\152\236\185\152\235\165\188 \236\152\172\235\166\189\235\139\136\235\139\164. 1\235\160\136\235\178\168 \234\184\176\236\164\128 30 \234\185\140\236\167\128 \236\152\172\235\157\188\234\176\145\235\139\136\235\139\164.\n\230\143\144\229\141\135\226\128\152\229\145\188\229\144\184\227\128\129\229\138\155\233\135\143\227\128\129\229\129\165\229\186\183\226\128\153\231\154\132\231\187\143\233\170\140\229\128\188\239\188\140\228\187\1651\231\173\137\231\186\167\228\184\186\230\160\135\229\135\134\239\188\140\230\143\144\229\141\135\232\135\17930", true)
  CREATE_BUTTON(11, 1, "\234\184\176\236\136\160\237\138\185\237\153\148 NPC\nSkill Addon NPC", "CreateSkillinstructor()", 2, "\234\184\176\236\136\160 \237\138\185\237\153\148\235\165\188 \235\179\128\234\178\189\237\149\180\236\163\188\235\138\148 NPC\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nCreates an NPC that will allow you to change your skill add-ons.", "\234\184\176\236\136\160\237\138\185\237\153\148 NPC\n\230\138\128\232\131\189\229\188\186\229\140\150 NPC", "\234\184\176\236\136\160 \237\138\185\237\153\148\235\165\188 \235\179\128\234\178\189\237\149\180\236\163\188\235\138\148 NPC\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\229\143\152\230\155\180\230\138\128\232\131\189\229\188\186\229\140\150NPC", true)
  CREATE_BUTTON(12, 1, "\236\136\152\235\166\172 NPC\nRepair NPC", "CreateEqiupRepairNPC()", 2, "\236\136\152\235\166\172\236\153\128 \236\182\148\236\182\156 \235\147\177\236\157\180 \234\176\128\235\138\165\237\149\156 \235\140\128\236\158\165\236\158\165\236\157\180\235\165\188 NPC\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nCreates an NPC that repairs, extracts, and performs other tasks.", "\236\136\152\235\166\172 NPC\n\228\191\174\231\144\134 NPC", "\236\136\152\235\166\172\236\153\128 \236\182\148\236\182\156 \235\147\177\236\157\180 \234\176\128\235\138\165\237\149\156 \235\140\128\236\158\165\236\158\165\236\157\180\235\165\188 NPC\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\229\143\175\228\191\174\231\144\134\229\143\138\230\143\144\229\143\150\231\154\132\233\147\129\229\140\160NPC", true)
  CREATE_BUTTON(0, 2, "\236\139\160\236\178\180 \234\176\149\237\153\148\235\178\149\nBody Enhance", "SetFullBuff()", 2, "[\235\179\132\236\177\132] \236\139\160\236\178\180 \234\176\149\237\153\148\235\178\149 (\235\179\132\236\177\132 \235\178\132\237\148\132), \235\179\132\235\175\184 \237\129\172\235\161\160 \236\160\149\236\139\157 1, \236\154\169\234\184\176\236\157\152 \237\150\165\236\136\152 2, \234\177\176\236\157\184\236\157\152 \236\152\129\236\149\189 2, \234\180\145\235\182\132\236\157\152 \236\152\129\236\149\189 2 \237\154\141\235\147\157\nGives [Villa] Body Enhancement (Villa buff), Exquisite Cron Meal x1, Perfume of Courage x2, Giant's Draught x2, Frenzy Draught x2.", "\236\139\160\236\178\180 \234\176\149\237\153\148\235\178\149\n\232\186\171\228\189\147\229\188\186\229\140\150\230\150\185\230\179\149", "[\235\179\132\236\177\132] \236\139\160\236\178\180 \234\176\149\237\153\148\235\178\149 (\235\179\132\236\177\132 \235\178\132\237\148\132), \235\179\132\235\175\184 \237\129\172\235\161\160 \236\160\149\236\139\157 1, \236\154\169\234\184\176\236\157\152 \237\150\165\236\136\152 2, \234\177\176\236\157\184\236\157\152 \236\152\129\236\149\189 2, \234\180\145\235\182\132\236\157\152 \236\152\129\236\149\189 2 \237\154\141\235\147\157\n\232\142\183\229\190\151[\229\136\171\229\162\133]\232\186\171\228\189\147\229\188\186\229\140\150\230\150\185\230\179\149(\229\136\171\229\162\133\229\162\158\231\155\138), \233\163\142\229\145\179\231\139\172\231\137\185\231\154\132\229\133\139\231\189\151\230\129\169\229\165\151\233\164\144 1\228\184\170, \229\139\135\230\176\148\228\185\139\233\166\153\230\176\1802\228\184\170, \229\183\168\228\186\186\228\185\139\231\129\181\232\141\1752\228\184\170, \231\139\130\229\165\148\228\185\139\231\129\181\232\141\1752\228\184\170", true)
  CREATE_BUTTON(1, 2, "\234\184\136\234\180\180 \235\178\132\237\148\132\nGold bar Buff", "SetGoldbarBuff()", 2, "\234\184\136\234\180\180 \234\181\144\237\153\152 \235\178\132\237\148\132 \237\154\141\235\147\157\nGives buffs obtain by exchanging gold bars. (like a church buff).", "\234\184\136\234\180\180 \235\178\132\237\148\132\n\233\135\145\229\157\151\229\162\158\231\155\138", "\234\184\136\234\180\180 \234\181\144\237\153\152 \235\178\132\237\148\132 \237\154\141\235\147\157\n\232\142\183\229\190\151\233\135\145\229\157\151\228\186\164\230\141\162\229\162\158\231\155\138", true)
  CREATE_BUTTON(2, 2, "\236\157\140\236\139\157 \236\152\129\236\149\189 \234\176\128\234\181\172\nFood+Draught", "createBuffItem()", 2, "\235\143\132\237\149\145\236\154\169 \236\157\140\236\139\157 \236\152\129\236\149\189 \236\131\157\236\132\177\nCreates buff food and draughts/elixirs.", "\236\157\140\236\139\157 \236\152\129\236\149\189 \234\176\128\234\181\172\n\230\150\153\231\144\134\239\188\140\231\129\181\232\141\175\239\188\140\229\174\182\229\133\183", "\235\143\132\237\149\145\236\154\169 \236\157\140\236\139\157 \236\152\129\236\149\189 \236\131\157\236\132\177\n\229\162\158\231\155\138\231\148\168\230\150\153\231\144\134\239\188\140\231\129\181\232\141\175", true)
  CREATE_BUTTON(3, 2, "\237\154\140\235\179\181\236\160\156\nPotions", "createPotion()", 2, "\236\167\129\236\151\133\235\179\132 \237\154\140\235\179\181\236\151\144 \237\149\132\236\154\148\237\149\156 \237\154\140\235\179\181\236\160\156 \236\131\157\236\132\177\nCreates potions for each class.", "\237\154\140\235\179\181\236\160\156\n\230\129\162\229\164\141\232\141\175\229\137\130", "\236\167\129\236\151\133\235\179\132 \237\154\140\235\179\181\236\151\144 \237\149\132\236\154\148\237\149\156 \237\154\140\235\179\181\236\160\156 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\144\132\232\129\140\228\184\154\230\137\128\233\156\128\232\166\129\231\154\132\230\129\162\229\164\141\232\141\175\229\137\130", true)
  CREATE_BUTTON(4, 2, "\235\185\132\236\149\189 \236\132\184\237\140\133\n22Elixir", "buff16()", 2, "22\235\185\132\236\149\189 \236\132\184\237\140\133\nCreates 22Elixir", "\235\185\132\236\149\189 \236\132\184\237\140\133\n\232\174\190\231\189\174\231\167\152\232\141\175", "22\235\185\132\236\149\189 \236\132\184\237\140\133\n\232\174\190\231\189\17422\231\167\152\232\141\175", true)
  CREATE_BUTTON(5, 2, "\236\139\160\234\183\156 \236\152\129\236\149\189 \236\132\184\237\140\133\nNewElixir", "NewElixirQA()", 2, "\236\139\160\234\183\156 \236\152\129\236\149\189 \236\132\184\237\140\133\nCreates NewElixir", "\236\139\160\234\183\156 \236\152\129\236\149\189 \236\132\184\237\140\133\n\230\150\176\231\129\181\232\141\175\232\174\190\229\174\154", "\236\139\160\234\183\156 \236\152\129\236\149\189 \236\132\184\237\140\133\n\230\150\176\231\129\181\232\141\175\232\174\190\229\174\154", true)
  CREATE_BUTTON(8, 2, "\235\179\180\235\172\188 \236\131\157\236\132\177\nCreate Treasure", "CreateTreasure()", 2, "\236\167\128\235\143\132, \235\130\152\236\185\168\235\176\152, \235\167\157\236\155\144\234\178\189, \nCreate Treasure.", "\235\179\180\235\172\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\174\157\231\137\169", "\236\167\128\235\143\132, \235\130\152\236\185\168\235\176\152, \235\167\157\236\155\144\234\178\189, \n\229\156\176\229\155\190\239\188\140\230\150\185\229\144\145\231\155\152\239\188\140\230\156\155\232\191\156\233\149\156", true)
  CREATE_BUTTON(9, 2, "5\236\132\184\235\140\128 \236\154\148\236\160\149 \236\138\164\237\130\172 \236\132\184\237\140\133\nT5 Fairy", "Set5thFairySkill()", 2, "5\236\132\184\235\140\128 \236\154\148\236\160\149 \236\138\164\237\130\172 \236\132\184\237\140\133\nSkill Setting a Tier 5 fairy.", "5\236\132\184\235\140\128 \236\154\148\236\160\149 \236\138\164\237\130\172 \236\132\184\237\140\133\n\232\174\190\231\189\1745\228\187\163\229\166\150\231\178\190\230\138\128\232\131\189", "5\236\132\184\235\140\128 \236\154\148\236\160\149 \236\138\164\237\130\172 \236\132\184\237\140\133\n\232\174\190\231\189\1745\228\187\163\229\166\150\231\178\190\230\138\128\232\131\189", true)
  CREATE_BUTTON(10, 2, "\236\154\148\236\160\149 \236\131\157\236\132\177\nSummon Fairy", "Set5thFairy()", 2, "5\236\132\184\235\140\128 \236\154\148\236\160\149\236\157\132 \236\131\157\236\132\177\237\149\152\236\151\172 \236\134\140\237\153\152\237\149\169\235\139\136\235\139\164.\nCreates and summons a Tier 5 fairy.", "\236\154\148\236\160\149 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\166\150\231\178\190", "5\236\132\184\235\140\128 \236\154\148\236\160\149\236\157\132 \236\131\157\236\132\177\237\149\152\236\151\172 \236\134\140\237\153\152\237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\239\188\140\229\143\172\229\148\1645\228\187\163\229\166\150\231\178\190", true)
  CREATE_BUTTON(11, 2, "5\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133\nT5 Pet", "Set5thPet()", 2, "5\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133, 4\236\132\184\235\140\128 \237\142\171 \237\149\132\236\154\148\237\149\168\nCreates a Tier 5 pet. You need a Tier 4 pet to use this.", "5\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133\n\232\174\190\231\189\1745\228\187\163\229\174\160\231\137\169", "5\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133, 4\236\132\184\235\140\128 \237\142\171 \237\149\132\236\154\148\237\149\168\n\232\174\190\231\189\1745\228\187\163\229\174\160\231\137\169\239\188\140\233\156\128\232\166\1294\228\187\163\229\174\160\231\137\169", true)
  CREATE_BUTTON(12, 2, "4\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133\nT4 Pet", "Set4thPets()", 2, "5\236\132\184\235\140\128 1\235\167\136\235\166\172 4\236\132\184\235\140\128 \235\176\152\235\160\164\235\143\153\235\172\188 5\235\167\136\235\166\172\235\165\188 \236\131\157\236\132\177\237\149\152\236\151\172 \236\134\140\237\153\152\237\149\169\235\139\136\235\139\164. (\237\142\171\236\138\164\237\130\172: \235\130\154\236\139\156,\236\177\132\236\167\145,\237\150\137\236\154\180 5\235\139\168\234\179\132)\nCreates and summons 5 Tier 4 pets. (Skills: Fishing, Gathering, Luck 5).", "4\236\132\184\235\140\128 \237\142\171 \236\132\184\237\140\133\n\232\174\190\231\189\1744\228\187\163\229\174\160\231\137\169", "5\236\132\184\235\140\128 1\235\167\136\235\166\172 4\236\132\184\235\140\128 \235\176\152\235\160\164\235\143\153\235\172\188 5\235\167\136\235\166\172\235\165\188 \236\131\157\236\132\177\237\149\152\236\151\172 \236\134\140\237\153\152\237\149\169\235\139\136\235\139\164. (\237\142\171\236\138\164\237\130\172: \235\130\154\236\139\156,\236\177\132\236\167\145,\237\150\137\236\154\180 5\235\139\168\234\179\132)\n\231\148\159\230\136\1445\228\187\1631\228\184\170\239\188\1404\228\187\1635\228\184\170\229\174\160\231\137\169\229\185\182\229\143\172\229\148\164 (\229\174\160\231\137\169\230\138\128\232\131\189: \233\146\147\233\177\188\239\188\140\233\135\135\233\155\134\239\188\140\229\185\184\232\191\1445\231\186\167)", true)
  CREATE_BUTTON(0, 3, "\234\176\128\235\176\169 \235\185\132\236\154\176\234\184\176\nClear Inv", "ToClient_qaClearInventory()", 2, "\236\158\160\234\184\180 \236\149\132\236\157\180\237\133\156\236\157\132 \236\160\156\236\153\184\237\149\152\234\179\160 \234\176\128\235\176\169 \236\185\184\236\157\132 \235\170\168\235\145\144 \235\185\132\236\155\129\235\139\136\235\139\164. cleaninventory\236\153\128 \235\143\153\236\157\188\237\149\156 \234\184\176\235\138\165\nRemoves all items in your inventory, other than the items that are locked.", "\234\176\128\235\176\169 \235\185\132\236\154\176\234\184\176\n\231\169\186\229\135\186\232\131\140\229\140\133", "\236\158\160\234\184\180 \236\149\132\236\157\180\237\133\156\236\157\132 \236\160\156\236\153\184\237\149\152\234\179\160 \234\176\128\235\176\169 \236\185\184\236\157\132 \235\170\168\235\145\144 \235\185\132\236\155\129\235\139\136\235\139\164. cleaninventory\236\153\128 \235\143\153\236\157\188\237\149\156 \234\184\176\235\138\165\n\233\153\164\228\186\134\232\162\171\233\148\129\229\174\154\231\154\132\233\129\147\229\133\183\230\132\143\229\164\150\239\188\140\231\169\186\229\135\186\232\131\140\229\140\133", true)
  CREATE_BUTTON(1, 3, "\235\170\168\235\147\160 \236\158\165\235\185\132 \237\149\180\236\160\156\nUnequip All", "UnEquipAll()", 2, "\237\142\132 \236\157\152\236\131\129 \237\143\172\237\149\168 \235\170\168\235\147\160 \236\158\165\235\185\132\235\165\188 \237\149\180\236\160\156\237\149\169\235\139\136\235\139\164.\nUnequips all gear, including pearl outfits.", "\235\170\168\235\147\160 \236\158\165\235\185\132 \237\149\180\236\160\156\n\232\167\163\233\153\164\230\137\128\230\156\137\232\163\133\229\164\135", "\237\142\132 \236\157\152\236\131\129 \237\143\172\237\149\168 \235\170\168\235\147\160 \236\158\165\235\185\132\235\165\188 \237\149\180\236\160\156\237\149\169\235\139\136\235\139\164.\n\229\140\133\230\139\172\231\143\141\231\143\160\230\156\141\232\163\133\239\188\140\232\167\163\233\153\164\230\137\128\230\156\137\232\163\133\229\164\135", true)
  CREATE_BUTTON(2, 3, "\234\176\128\235\172\184 \234\176\128\235\176\169\nFamily Inv", "FamilyBag()", 2, "\234\176\128\235\172\184\234\176\128\235\176\169 \236\132\184\237\140\133\nSets up Family Inventory.", "\234\176\128\235\172\184 \234\176\128\235\176\169\n\229\174\182\233\151\168\232\131\140\229\140\133", "\234\176\128\235\172\184\234\176\128\235\176\169 \236\132\184\237\140\133\n\232\174\190\231\189\174\229\174\182\233\151\168\232\131\140\229\140\133", true)
  CREATE_BUTTON(3, 3, "\234\176\128\235\176\169/\235\172\180\234\178\140 \237\153\149\236\158\165\nInv+Weight Up", "EncreaseWeightBag()", 2, "\234\176\128\235\176\169/\235\172\180\234\178\140\235\165\188 \236\182\148\234\176\128\237\149\169\235\139\136\235\139\164. \235\172\180\234\178\140\235\138\148 3000LT\235\165\188 \236\180\136\234\179\188\237\149\152\236\151\172 \235\138\152\235\166\180 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.\nGives additional Inventory slots and weight. Weight can only go up to 3,000LT.", "\234\176\128\235\176\169/\235\172\180\234\178\140 \237\153\149\236\158\165\n\230\137\169\229\188\160\232\131\140\229\140\133\239\188\140\232\180\159\233\135\141", "\234\176\128\235\176\169/\235\172\180\234\178\140\235\165\188 \236\182\148\234\176\128\237\149\169\235\139\136\235\139\164. \235\172\180\234\178\140\235\138\148 3000LT\235\165\188 \236\180\136\234\179\188\237\149\152\236\151\172 \235\138\152\235\166\180 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.\n\230\183\187\229\138\160\232\131\140\229\140\133\239\188\140\232\180\159\233\135\141\227\128\130\232\180\159\233\135\141\230\156\128\229\164\167\229\128\188\228\184\1863000LT", true)
  CREATE_BUTTON(8, 3, "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \235\143\132\237\149\145\nLoot Buff", "ItemdropBuff()", 2, "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157\235\159\137\234\179\188 \237\153\149\235\165\160\236\157\132 \236\152\172\235\160\164\236\163\188\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nCreates items that can increase item drop amount and rate.", "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157 \235\143\132\237\149\145\n\233\129\147\229\133\183\232\142\183\229\190\151\229\135\160\231\142\135\229\162\158\231\155\138", "\236\149\132\236\157\180\237\133\156 \237\154\141\235\147\157\235\159\137\234\179\188 \237\153\149\235\165\160\236\157\132 \236\152\172\235\160\164\236\163\188\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\230\143\144\229\141\135\233\129\147\229\133\183\232\142\183\229\190\151\233\135\143\229\146\140\229\135\160\231\142\135\231\154\132\233\129\147\229\133\183", true)
  CREATE_BUTTON(9, 3, "\236\151\180\234\184\176 \236\160\156\234\177\176\nRemove Fever", "VaryFeverPoint(-30000)", 2, "\236\149\132\234\183\184\235\166\172\236\138\164\236\157\152 \236\151\180\234\184\176 -30000\nAgris Fever -30,000", "\236\151\180\234\184\176 \236\160\156\234\177\176\n\230\182\136\232\128\151\231\131\173\230\176\148", "\236\149\132\234\183\184\235\166\172\236\138\164\236\157\152 \236\151\180\234\184\176 -30000\n\233\152\191\230\136\136\233\135\140\230\150\175\231\154\132\231\131\173\230\189\174 -30000", true)
  CREATE_BUTTON(10, 3, "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\235\182\136)\nElvia Buff (F)", "HadumBuff1()", 2, "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \235\176\156\237\131\128\235\157\188\236\157\152 \236\182\149\235\179\181\nGives Blessing of Valtarra (an Elvia Realm awakening buff)", "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\235\182\136)\n\232\137\190\229\176\148\230\175\148\228\186\154\229\162\158\231\155\138(\231\129\171)", "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \235\176\156\237\131\128\235\157\188\236\157\152 \236\182\149\235\179\181\n\232\137\190\229\176\148\230\175\148\228\186\154\232\167\137\233\134\146\229\162\158\231\155\138\228\184\173\231\147\166\230\178\147\230\139\137\231\154\132\231\165\157\231\166\143", true)
  CREATE_BUTTON(11, 3, "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\235\172\188)\nElvia Buff (W)", "HadumBuff2()", 2, "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\182\149\235\179\181\nGives Blessing of Okiara (an Elvia Realm awakening buff)", "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\235\172\188)\n\232\137\190\229\176\148\230\175\148\228\186\154\229\162\158\231\155\138(\230\176\180)", "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\182\149\235\179\181\n\232\137\190\229\176\148\230\175\148\228\186\154\232\167\137\233\134\146\229\162\158\231\155\138\228\184\173\229\165\165\229\165\135\232\137\190\229\139\146\231\154\132\231\165\157\231\166\143", true)
  CREATE_BUTTON(12, 3, "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\236\160\132\234\184\176)\nElvia Buff (T)", "HadumBuff3()", 2, "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \235\130\152\237\129\172\236\157\152 \236\182\149\235\179\181\nGives Blessing of Narc (an Elvia Realm awakening buff)", "\236\151\152\235\185\132\236\149\132 \235\178\132\237\148\132(\236\160\132\234\184\176)\n\232\137\190\229\176\148\230\175\148\228\186\154\229\162\158\231\155\138(\231\148\181\230\181\129)", "\236\151\152\235\185\132\236\149\132 \234\176\129\236\132\177 \235\178\132\237\148\132 \236\164\145 \235\130\152\237\129\172\236\157\152 \236\182\149\235\179\181\n\232\137\190\229\176\148\230\175\148\228\186\154\232\167\137\233\134\146\229\162\158\231\155\138\228\184\173\231\186\179\229\133\139\231\154\132\231\165\157\231\166\143", true)
end
function QASupport_AutomationPanel_CreateControl_Tab3()
  CREATE_BUTTON(0, 0, "\236\139\156\236\166\140\237\140\168\236\138\164 \237\129\180\235\166\172\236\150\180\nClear Season", "QuestClearSeasonPass()", 3, "\236\139\156\236\166\140 \236\186\144\235\166\173\237\132\176\236\157\152 \236\139\156\236\166\140 \237\140\168\236\138\164\235\165\188 \236\153\132\235\163\140\236\139\156\237\130\181\235\139\136\235\139\164.\nCompletes the season pass of a season character.", "\236\139\156\236\166\140\237\140\168\236\138\164 \237\129\180\235\166\172\236\150\180\n\229\174\140\230\136\144\232\181\155\229\173\163\233\128\154\232\161\140", "\236\139\156\236\166\140 \236\186\144\235\166\173\237\132\176\236\157\152 \236\139\156\236\166\140 \237\140\168\236\138\164\235\165\188 \236\153\132\235\163\140\236\139\156\237\130\181\235\139\136\235\139\164.\n\229\174\140\230\136\144\232\181\155\229\173\163\232\167\146\232\137\178\231\154\132\232\181\155\229\173\163\233\128\154\232\161\140", true)
  CREATE_BUTTON(1, 0, "\237\136\172\235\176\156\235\157\188 \236\158\165\235\185\132 \236\132\184\237\140\133\nTuvala Set", "seasonitem()", 3, "\236\139\156\236\166\140\236\160\156 \236\160\132\236\154\169 \237\136\172\235\176\156\235\157\188 \236\158\165\235\185\132 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\nSeason-exclusive Tuvala gear set.", "\237\136\172\235\176\156\235\157\188 \236\158\165\235\185\132 \236\132\184\237\140\133\n\229\155\190\229\183\180\230\139\137\232\163\133\229\164\135\232\174\190\231\189\174", "\236\139\156\236\166\140\236\160\156 \236\160\132\236\154\169 \237\136\172\235\176\156\235\157\188 \236\158\165\235\185\132 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n\232\181\155\229\173\163\228\184\147\231\148\168\229\155\190\229\183\180\230\139\137\232\163\133\229\164\135\232\174\190\231\189\174", true)
  CREATE_BUTTON(2, 0, "\236\131\157\237\153\156 \236\156\160\235\172\188 \236\131\157\236\132\177\nLife Artifact", "createLifeRelics()", 3, "\236\131\157\237\153\156 \236\156\160\235\172\188 \236\131\157\236\132\177\nCreates Artifacts related to life skills.", "\236\131\157\237\153\156 \236\156\160\235\172\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\148\159\230\180\187\233\129\151\231\137\169", "\236\131\157\237\153\156 \236\156\160\235\172\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\148\159\230\180\187\233\129\151\231\137\169", true)
  CREATE_BUTTON(3, 0, "\236\131\157\237\153\156 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\nLife Lightstone", "createLifeStone()", 3, "\236\131\157\237\153\156 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\nCreates Lightstones related to life skills.", "\236\131\157\237\153\156 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\148\159\230\180\187\229\133\137\230\152\142\231\159\179", "\236\131\157\237\153\156 \234\180\145\235\170\133\236\132\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\148\159\230\180\187\229\133\137\230\152\142\231\159\179", true)
  CREATE_BUTTON(4, 0, "\235\167\165\236\163\188, \236\131\136\234\181\172\236\157\180\nWoker QA Setting", "createWorkerQA()", 3, "\235\167\165\236\163\188, \236\131\136\234\181\172\236\157\180, \236\157\188\234\190\188 \235\147\177\235\161\157\236\166\157 \236\131\157\236\132\177\nCreates Bear, Bird Meat, Worker Box.", "\235\167\165\236\163\188, \236\131\136\234\181\172\236\157\180\n\233\186\166\232\140\182\233\165\174, \231\131\164\233\184\159\232\130\137", "\235\167\165\236\163\188, \236\131\136\234\181\172\236\157\180, \236\157\188\234\190\188 \235\147\177\235\161\157\236\166\157 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\186\166\232\140\182\233\165\174\239\188\140\231\131\164\233\184\159\232\130\137\239\188\140\229\138\179\229\183\165\231\153\187\232\174\176\232\175\129", true)
  CREATE_BUTTON(5, 0, "\236\158\165\236\155\144 \236\157\180\235\143\153\nTeleport to Manor", "TeleportManor()", 3, "\237\145\184\235\165\184 \234\176\136\234\184\176 \236\130\172\236\158\144\236\157\152 \236\158\165\236\155\144 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\nTeleport to Manor", "\236\158\165\236\155\144 \236\157\180\235\143\153\n\232\191\129\231\167\187\229\186\132\229\155\173", "\237\145\184\235\165\184 \234\176\136\234\184\176 \236\130\172\236\158\144\236\157\152 \236\158\165\236\155\144 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\n\229\174\140\230\136\144\232\147\157\233\172\131\232\190\155\229\183\180\229\133\189\229\186\132\229\155\173\228\187\187\229\138\161\229\143\138\232\191\129\231\167\187", true)
  CREATE_BUTTON(6, 0, "\235\132\136\236\153\128\236\167\145 \236\157\180\235\143\153\nTeleport to Shingled House", "TeleportSingledHouse()", 3, "\236\134\148\235\176\148\235\158\140 \235\132\136\236\153\128\236\167\145 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\nTeleport to Shingled House", "\235\132\136\236\153\128\236\167\145 \236\157\180\235\143\153\n\232\191\129\231\167\187\230\157\190\233\163\142\230\156\168\231\147\166\230\136\191", "\236\134\148\235\176\148\235\158\140 \235\132\136\236\153\128\236\167\145 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\n\229\174\140\230\136\144\230\157\190\233\163\142\230\156\168\231\147\166\230\136\191\228\187\187\229\138\161\229\143\138\232\191\129\231\167\187", true)
  CREATE_BUTTON(7, 0, "\236\139\172\237\150\165\236\158\172 \236\157\180\235\143\153\nTeleport to Simhyangjae", "TeleportSimhyangjae()", 3, "\236\139\172\237\150\165\236\158\172 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\nTeleport to Simhyangjae", "\236\139\172\237\150\165\236\158\172 \236\157\180\235\143\153\n\232\191\129\231\167\187\229\191\131\228\185\161\230\150\139", "\236\139\172\237\150\165\236\158\172 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\n\229\174\140\230\136\144\229\191\131\228\185\161\230\150\139\228\187\187\229\138\161\229\143\138\232\191\129\231\167\187", true)
  CREATE_BUTTON(8, 0, "\237\152\132\235\161\157\235\139\185 \236\157\180\235\143\153\nTeleport to Hyunrokdang", "TeleportHyunrokdang()", 3, "\237\152\132\235\161\157\235\139\185 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\nTeleport to Hyunrokdang", "\237\152\132\235\161\157\235\139\185 \236\157\180\235\143\153\n\232\191\129\231\167\187\230\152\190\231\166\132\229\160\130", "\237\152\132\235\161\157\235\139\185 \236\157\152\235\162\176 \236\153\132\235\163\140 \235\176\143 \236\157\180\235\143\153\n\229\174\140\230\136\144\230\152\190\231\166\132\229\160\130\228\187\187\229\138\161\229\143\138\232\191\129\231\167\187", true)
  CREATE_BUTTON(0, 1, "\236\149\132\234\183\184\235\166\172\236\138\164 \235\170\168\237\151\152\236\157\188\236\167\128\nAgris Log", "VaryFeverUpgrade()", 3, "\236\149\132\234\183\184\235\166\172\236\138\164 \236\151\180\234\184\176 \234\180\128\235\160\168 \235\170\168\237\151\152\236\157\188\236\167\128 \237\129\180\235\166\172\236\150\180(\236\167\129\236\160\145 \236\153\132\235\163\140\237\149\180\236\149\188\237\149\168)\nClears all objectives of Agris Fever adventure logs (You still need to complete them yourself.)", "\236\149\132\234\183\184\235\166\172\236\138\164 \235\170\168\237\151\152\236\157\188\236\167\128\n\233\152\191\230\136\136\233\135\140\230\150\175\229\134\146\233\153\169\230\151\165\232\174\176", "\236\149\132\234\183\184\235\166\172\236\138\164 \236\151\180\234\184\176 \234\180\128\235\160\168 \235\170\168\237\151\152\236\157\188\236\167\128 \237\129\180\235\166\172\236\150\180(\236\167\129\236\160\145 \236\153\132\235\163\140\237\149\180\236\149\188\237\149\168)\n\229\174\140\230\136\144\233\152\191\230\136\136\233\135\140\230\150\175\231\155\184\229\133\179\229\134\146\233\153\169\230\151\165\232\174\176\239\188\136\233\156\128\232\166\129\228\186\178\232\135\170\229\174\140\230\136\144\239\188\137", true)
  CREATE_BUTTON(1, 1, "\235\167\136\234\183\184\235\136\132\236\138\164 \236\154\176\235\172\188 \nMagnus Setting", "SettingA1()", 3, "\235\167\136\234\183\184\235\136\132\236\138\164 \236\154\176\235\172\188 \237\153\156\236\132\177\237\153\148\nMagnus Well Active", "\235\167\136\234\183\184\235\136\132\236\138\164 \236\154\176\235\172\188 \n\233\169\172\230\160\188\229\138\170\230\150\175\230\176\180\228\186\149", "\235\167\136\234\183\184\235\136\132\236\138\164 \236\154\176\235\172\188 \237\153\156\236\132\177\237\153\148\n\230\191\128\230\180\187\233\169\172\230\160\188\229\138\170\230\150\175\230\176\180\228\186\149", true)
  CREATE_BUTTON(2, 1, "\236\132\164\237\153\148 \236\157\188\236\167\128 \236\132\184\237\140\133\nCollection of Tales Set", "QuestClearMorningLandNormalQuest()", 3, "\236\149\132\236\185\168\236\157\152\235\130\152\235\157\188 \235\133\184\235\167\144\236\157\152\235\162\176 \237\129\180\235\166\172\236\150\180\nMorningLand Quest Cear", "\236\132\164\237\153\148 \236\157\188\236\167\128 \236\132\184\237\140\133\n\232\174\190\231\189\174\228\188\160\232\175\180\230\151\165\232\174\176", "\236\149\132\236\185\168\236\157\152\235\130\152\235\157\188 \235\133\184\235\167\144\236\157\152\235\162\176 \237\129\180\235\166\172\236\150\180\n\229\174\140\230\136\144\230\153\168\230\155\166\228\185\139\229\155\189\230\153\174\233\128\154\228\187\187\229\138\161", true)
  CREATE_BUTTON(3, 1, "\234\178\128\236\157\128 \236\130\172\235\139\185\nBlack Sadang Set", "KnowledgeElementalBoss()", 3, "\234\178\128\236\157\128\236\130\172\235\139\185 \235\179\180\236\138\164 \236\167\128\236\139\157 \237\154\141\235\147\157. \235\185\155\236\157\152 \235\179\180\236\152\165 \237\130\164:66667\nBlack Sadang Knowledge", "\234\178\128\236\157\128 \236\130\172\235\139\185\n\233\187\145\232\137\178\231\165\160\229\160\130", "\234\178\128\236\157\128\236\130\172\235\139\185 \235\179\180\236\138\164 \236\167\128\236\139\157 \237\154\141\235\147\157. \235\185\155\236\157\152 \235\179\180\236\152\165 \237\130\164:66667\n\232\142\183\229\190\151\233\187\145\232\137\178\231\165\160\229\160\130\233\166\150\233\162\134\231\159\165\232\175\134. \229\133\137\228\185\139\229\174\157\231\142\137\228\187\163\231\160\129:66667", true)
  CREATE_BUTTON(4, 1, "\236\150\180\235\145\145\236\139\156\235\139\136\235\161\156 \236\157\180\235\143\153\nTeleport to Oduksini", "ToClient_qaTeleport(-1298377,-17875,1158498)", 3, "\234\178\128\236\157\128\236\130\172\235\139\185 \236\150\180\235\145\145\236\139\156\235\139\136 \236\160\132\237\136\172 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleport To Oduksini", "\236\150\180\235\145\145\236\139\156\235\139\136\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\154\151\233\173\133", "\234\178\128\236\157\128\236\130\172\235\139\185 \236\150\180\235\145\145\236\139\156\235\139\136 \236\160\132\237\136\172 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\233\187\145\232\137\178\231\165\160\229\160\130\230\154\151\233\173\133\230\136\152\230\150\151\229\156\176\229\140\186", true)
  CREATE_BUTTON(5, 1, "\237\148\188\236\157\152 \236\160\156\235\139\168 \236\158\133\236\158\165 \236\132\184\237\140\133\nSavageDefence Set", "QuestClearSavageDefence()", 3, "\237\148\188\236\157\152\236\160\156\235\139\168 \236\158\133\236\158\165 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\nAltar of Blood Quest Clear", "\237\148\188\236\157\152 \236\160\156\235\139\168 \236\158\133\236\158\165 \236\132\184\237\140\133\n\233\130\170\230\129\182\231\165\173\229\157\155\229\133\165\229\156\186\232\174\190\231\189\174", "\237\148\188\236\157\152\236\160\156\235\139\168 \236\158\133\236\158\165 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\n\229\174\140\230\136\144\233\130\170\230\129\182\231\165\173\229\157\155\229\133\165\229\156\186\228\187\187\229\138\161", true)
  CREATE_BUTTON(6, 1, "\235\182\136\235\169\184\236\157\152\235\130\152\235\157\189 \236\158\133\236\158\165 \236\132\184\237\140\133\nPvEArena Set", "QuestClearPvEArena()", 3, "\235\182\136\235\169\184\236\157\152\235\130\152\235\157\189 \236\158\133\236\158\165 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\nPit of the Undying Quest Clear", "\235\182\136\235\169\184\236\157\152\235\130\152\235\157\189 \236\158\133\236\158\165 \236\132\184\237\140\133\n\228\184\141\231\129\173\233\187\132\230\179\137\229\133\165\229\156\186\232\174\190\231\189\174", "\235\182\136\235\169\184\236\157\152\235\130\152\235\157\189 \236\158\133\236\158\165 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\n\229\174\140\230\136\144\228\184\141\231\129\173\233\187\132\230\179\137\229\133\165\229\156\186\228\187\187\229\138\161", true)
  CREATE_BUTTON(7, 1, "\235\167\136\235\165\180\235\139\136 \236\160\132\236\157\180 \236\157\152\235\162\176 \236\132\184\237\140\133\nClear Marni", "QuestClearMarni()", 3, "\235\167\136\235\165\180\235\139\136 \236\160\132\236\157\180 \236\157\152\235\162\176 \236\130\172\236\160\132 \236\132\184\237\140\133\nMarni Quest Clear", "\235\167\136\235\165\180\235\139\136 \236\160\132\236\157\180 \236\157\152\235\162\176 \236\132\184\237\140\133\n\231\142\155\229\139\146\229\176\188\232\189\172\231\167\187\228\187\187\229\138\161\232\174\190\231\189\174", "\235\167\136\235\165\180\235\139\136 \236\160\132\236\157\180 \236\157\152\235\162\176 \236\130\172\236\160\132 \236\132\184\237\140\133\n\230\143\144\229\137\141\232\174\190\231\189\174\231\142\155\229\139\146\229\176\188\232\189\172\231\167\187\228\187\187\229\138\161", true)
  CREATE_BUTTON(8, 1, "\236\149\132\237\134\160\235\157\189\236\139\156\236\152\168 \236\158\133\234\181\172 \236\157\180\235\143\153\nStart Atoraxxion", "AtoraxionTeleport()", 3, "\236\149\132\237\134\160\235\157\189\236\139\156\236\152\168 \236\158\133\236\158\165 \236\132\184\237\140\133\nAtoraxxion Teleport", "\236\149\132\237\134\160\235\157\189\236\139\156\236\152\168 \236\158\133\234\181\172 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\233\152\191\229\155\190\229\139\146\229\161\158\229\133\165\229\143\163", "\236\149\132\237\134\160\235\157\189\236\139\156\236\152\168 \236\158\133\236\158\165 \236\132\184\237\140\133\n\232\174\190\231\189\174\233\152\191\229\155\190\229\139\146\229\161\158\229\133\165\229\156\186", true)
  CREATE_BUTTON(9, 1, "\236\157\188\235\176\152 \234\182\164\236\167\157 \236\167\128\236\139\157\nChest", "NormalDokkebiChest()", 3, "\236\157\188\235\176\152 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\nDokkebi's Chest Knowledge", "\236\157\188\235\176\152 \234\182\164\236\167\157 \236\167\128\236\139\157\n\230\153\174\233\128\154\229\140\163\229\173\144\231\159\165\232\175\134", "\236\157\188\235\176\152 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\n\230\153\174\233\128\154\233\172\188\230\128\170\229\140\163\229\173\144\231\159\165\232\175\134", true)
  CREATE_BUTTON(10, 1, "\236\139\160\234\184\176 \234\182\164\236\167\157 \236\167\128\236\139\157\nMystery Chest", "MysteryDokkebiChest()", 3, "\236\139\160\234\184\176 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\nDokkebi's Mystery Chest Knowledge", "\236\139\160\234\184\176 \234\182\164\236\167\157 \236\167\128\236\139\157\n\231\165\158\231\167\152\229\140\163\229\173\144\231\159\165\232\175\134", "\236\139\160\234\184\176 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\n\231\165\158\231\167\152\233\172\188\230\128\170\229\140\163\229\173\144\231\159\165\232\175\134", true)
  CREATE_BUTTON(11, 1, "\237\157\172\234\183\128 \234\182\164\236\167\157 \236\167\128\236\139\157\nRarity Chest", "RarityDokkebiChest()", 3, "\237\157\172\234\183\128 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\nDokkebi's Rarity Chest Knowledge", "\237\157\172\234\183\128 \234\182\164\236\167\157 \236\167\128\236\139\157\n\231\168\128\230\156\137\229\140\163\229\173\144\231\159\165\232\175\134", "\237\157\172\234\183\128 \235\143\132\234\185\168\235\185\132 \234\182\164\236\167\157 \236\167\128\236\139\157\n\231\168\128\230\156\137\233\172\188\230\128\170\229\140\163\229\173\144\231\159\165\232\175\134", true)
  CREATE_BUTTON(0, 2, "\235\167\136\235\133\184\236\138\164 \236\149\133\236\132\184\nManos Acces.", "CreateManosAcc()", 3, "\236\131\157\237\153\156 \234\179\181\236\154\169 \235\167\136\235\133\184\236\138\164 \236\149\133\236\132\184\236\132\156\235\166\172 \236\131\157\236\132\177\nCreates Manos accessories used for all life skills.", "\235\167\136\235\133\184\236\138\164 \236\149\133\236\132\184\n\230\145\169\232\175\186\230\150\175\233\165\176\229\147\129", "\236\131\157\237\153\156 \234\179\181\236\154\169 \235\167\136\235\133\184\236\138\164 \236\149\133\236\132\184\236\132\156\235\166\172 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\148\159\230\180\187\233\128\154\231\148\168\230\145\169\232\175\186\230\150\175\233\165\176\229\147\129", true)
  CREATE_BUTTON(1, 2, "\236\177\132\236\167\145\nGathering", "gatheringtest()", 3, "\236\177\132\236\167\145\235\143\132\234\181\172 \235\176\143 \236\177\132\236\167\145\235\179\181 \236\131\157\236\132\177\nCreates gathering tools and Gatherer Clothes.", "\236\177\132\236\167\145\n\233\135\135\233\155\134", "\236\177\132\236\167\145\235\143\132\234\181\172 \235\176\143 \236\177\132\236\167\145\235\179\181 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\135\135\233\155\134\233\129\147\229\133\183\229\143\138\233\135\135\233\155\134\230\156\141", true)
  CREATE_BUTTON(2, 2, "\235\130\154\236\139\156\nFishing", "fishingtest()", 3, "\235\130\154\236\139\156 \237\133\140\236\138\164\237\138\184\236\151\144 \237\149\132\236\154\148\237\149\156 \235\143\132\234\181\172\235\147\164\236\157\132 \236\131\157\236\132\177\nCreates tool required to test fishing.", "\235\130\154\236\139\156\n\233\146\147\233\177\188", "\235\130\154\236\139\156 \237\133\140\236\138\164\237\138\184\236\151\144 \237\149\132\236\154\148\237\149\156 \235\143\132\234\181\172\235\147\164\236\157\132 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\146\147\233\177\188\230\181\139\232\175\149\228\184\138\230\137\128\233\156\128\232\166\129\231\154\132\233\129\147\229\133\183", true)
  CREATE_BUTTON(3, 2, "\236\158\145\236\130\180\235\130\154\236\139\156\nHarpoon", "harpoonfishing()", 3, "\236\158\145\236\130\180 \235\130\154\236\139\156 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153, \236\157\180\237\155\132 \235\139\164\236\139\156 \235\178\132\237\138\188 \235\136\140\235\159\172 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\nTeleports you to harpooning area. Press it again after teleporting.", "\236\158\145\236\130\180\235\130\154\236\139\156\n\233\177\188\229\143\137\233\146\147\233\177\188", "\236\158\145\236\130\180 \235\130\154\236\139\156 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153, \236\157\180\237\155\132 \235\139\164\236\139\156 \235\178\132\237\138\188 \235\136\140\235\159\172 \237\133\140\236\138\164\237\138\184 \236\132\184\237\140\133\n\231\167\187\229\138\168\232\135\179\233\177\188\229\143\137\233\146\147\233\177\188\229\156\176\229\140\186\239\188\140\228\187\165\229\144\142\229\134\141\230\172\161\230\140\137\233\148\174\232\191\155\232\161\140\230\181\139\232\175\149\232\174\190\231\189\174", true)
  CREATE_BUTTON(4, 2, "\236\136\152\235\160\181\nHunting", "huntingtest()", 3, "\236\136\152\235\160\181\236\180\157 \235\176\143 \236\136\152\235\160\181 \235\143\132\234\181\172 \236\131\157\236\132\177\nCreates hunting matchlock and hunting tools.", "\236\136\152\235\160\181\n\231\139\169\231\140\142", "\236\136\152\235\160\181\236\180\157 \235\176\143 \236\136\152\235\160\181 \235\143\132\234\181\172 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\139\169\231\140\142\230\158\170\229\143\138\231\139\169\231\140\142\233\129\147\229\133\183", true)
  CREATE_BUTTON(5, 2, "\236\154\148\235\166\172\nCooking", "cooktest(100)", 3, "\236\154\148\235\166\172 \237\133\140\236\138\164\237\138\184\236\151\144 \237\149\132\236\154\148\237\149\156 \236\158\172\235\163\140\236\153\128 \235\143\132\234\181\172 \236\131\157\236\132\177\nCreates cooking tools and materials required to test cooking.", "\236\154\148\235\166\172\n\230\150\153\231\144\134", "\236\154\148\235\166\172 \237\133\140\236\138\164\237\138\184\236\151\144 \237\149\132\236\154\148\237\149\156 \236\158\172\235\163\140\236\153\128 \235\143\132\234\181\172 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\150\153\231\144\134\230\181\139\232\175\149\228\184\138\230\137\128\233\156\128\232\166\129\231\154\132\233\129\147\229\133\183\229\143\138\233\129\147\229\133\183", true)
  CREATE_BUTTON(6, 2, "\236\151\176\234\184\136\nAlchemy", "alchemytest(100)", 3, "\236\151\176\234\184\136\236\136\160 \235\143\132\234\181\172 \235\176\143 \236\158\172\235\163\140 \236\131\157\236\132\177\nCreates alchemy tools and materials.", "\236\151\176\234\184\136\n\231\130\188\233\135\145", "\236\151\176\234\184\136\236\136\160 \235\143\132\234\181\172 \235\176\143 \236\158\172\235\163\140 \236\131\157\236\132\177\n\231\148\159\230\136\144\231\130\188\233\135\145\230\156\175\233\129\147\229\133\183\229\143\138\233\129\147\229\133\183", true)
  CREATE_BUTTON(7, 2, "\234\176\128\234\179\181\nProcessing", "processingtest()", 3, "\234\176\128\234\179\181\235\179\181, \234\176\128\234\179\181\236\132\157, \234\176\128\234\179\181 \236\158\172\235\163\140 \236\131\157\236\132\177\nCreates processing, processing stones, and processing materials.", "\234\176\128\234\179\181\n\229\138\160\229\183\165", "\234\176\128\234\179\181\235\179\181, \234\176\128\234\179\181\236\132\157, \234\176\128\234\179\181 \236\158\172\235\163\140 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\138\160\229\183\165\230\156\141\239\188\140\229\138\160\229\183\165\231\159\179\239\188\140\229\138\160\229\183\165\230\157\144\230\150\153", true)
  CREATE_BUTTON(8, 2, "\235\172\180\236\151\173\nTrading Quests", "tradetest()", 3, "\235\172\180\236\151\173 \234\180\128\235\160\168 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\nClears trade related quests.", "\235\172\180\236\151\173\n\232\180\184\230\152\147", "\235\172\180\236\151\173 \234\180\128\235\160\168 \237\128\152\236\138\164\237\138\184 \237\129\180\235\166\172\236\150\180\n\229\174\140\230\136\144\232\180\184\230\152\147\231\155\184\229\133\179\228\187\187\229\138\161", true)
  CREATE_BUTTON(9, 2, "\236\158\172\235\176\176\nFarming", "harvesttest()", 3, "\236\158\172\235\176\176 \237\133\140\236\138\164\237\138\184\236\154\169 \236\149\132\236\157\180\237\133\156 \236\131\157\236\132\177\nCreates items required to test farming.", "\236\158\172\235\176\176\n\230\160\189\229\159\185", "\236\158\172\235\176\176 \237\133\140\236\138\164\237\138\184\236\154\169 \236\149\132\236\157\180\237\133\156 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\160\189\229\159\185\230\181\139\232\175\149\233\129\147\229\133\183", true)
  CREATE_BUTTON(10, 2, "\237\149\173\237\149\180\nSailing", "createSailboat()", 3, "\235\178\148\236\132\160 \235\176\143 \235\178\148\236\132\160 \235\143\132\234\181\172 \236\131\157\236\132\177, \235\172\188\236\134\141\236\151\144\236\132\156 \236\130\172\236\154\169\237\149\180\236\149\188\237\149\168\nCreates a sailboat and sailboat tools. Must be used in the water.", "\237\149\173\237\149\180\n\232\136\170\230\181\183", "\235\178\148\236\132\160 \235\176\143 \235\178\148\236\132\160 \235\143\132\234\181\172 \236\131\157\236\132\177, \235\172\188\236\134\141\236\151\144\236\132\156 \236\130\172\236\154\169\237\149\180\236\149\188\237\149\168\n\231\148\159\230\136\144\229\184\134\232\136\185\229\143\138\229\184\134\232\136\185\233\129\147\229\133\183\239\188\140\233\156\128\232\166\129\229\156\168\230\176\180\233\135\140\228\189\191\231\148\168", true)
  CREATE_BUTTON(0, 3, "\236\151\144\235\160\136\237\133\140\236\149\132 \236\132\184\237\140\133\nErethea Set", "EretheaSet()", 3, "\236\151\144\235\160\136\237\133\140\236\149\132\236\157\152 \236\139\156\235\160\168, \235\167\157\234\176\129 \236\158\133\236\158\165\234\182\140 \236\131\157\236\132\177\nCreate Erethea's Trial, Limbo Ticket", "\236\151\144\235\160\136\237\133\140\236\149\132 \236\132\184\237\140\133\n\229\159\131\233\155\183\229\191\146\228\186\154\232\174\190\231\189\174", "\236\151\144\235\160\136\237\133\140\236\149\132\236\157\152 \236\139\156\235\160\168, \235\167\157\234\176\129 \236\158\133\236\158\165\234\182\140 \236\131\157\236\132\177\n\229\159\131\233\155\183\229\191\146\228\186\154\232\175\149\231\130\188\239\188\140\233\129\151\229\191\152\229\133\165\229\156\186\229\136\184\231\148\159\230\136\144", true)
  CREATE_BUTTON(1, 3, "\236\130\172\235\167\137/\236\132\164\236\130\176 \236\167\128\236\155\144\nDesert/Snow Aid", "DesertSupport()", 3, "\235\130\152\236\185\168\235\176\152, \236\130\172\235\167\137 \236\156\132\236\158\165\235\179\181, \236\160\149\236\160\156\236\136\152, \237\140\148\234\176\129\236\176\168, \236\130\172\235\167\137 \236\151\172\236\154\176 \237\142\171\nCompass, Desert Camouflage, Purified Water, Star Anise Tea, Pet (Desert Fox).", "\236\130\172\235\167\137/\236\132\164\236\130\176 \236\167\128\236\155\144\n\230\178\153\230\188\160/\233\155\170\229\177\177\230\148\175\230\143\180", "\235\130\152\236\185\168\235\176\152, \236\130\172\235\167\137 \236\156\132\236\158\165\235\179\181, \236\160\149\236\160\156\236\136\152, \237\140\148\234\176\129\236\176\168, \236\130\172\235\167\137 \236\151\172\236\154\176 \237\142\171\n\230\150\185\229\144\145\231\155\152\239\188\140\230\178\153\230\188\160\228\188\170\232\163\133\229\164\171\239\188\140\231\186\175\230\176\180\239\188\140\229\133\171\232\167\146\232\140\182\239\188\140\230\178\153\230\188\160\229\188\151\230\150\175\229\133\189", true)
  CREATE_BUTTON(2, 3, "\235\140\128\236\150\145 \236\167\128\236\155\144\nOcean Aid", "OceanSupport()", 3, "\235\130\152\236\185\168\235\176\152, \235\185\160\235\176\164\235\185\160\235\176\164 \236\158\160\236\136\152\235\179\181, \236\151\172\237\150\137\236\158\144\236\157\152 \236\167\128\235\143\132, \234\183\184\235\175\144\235\139\172 \234\181\172\236\161\176 \236\139\160\237\152\184\237\131\132\nCompass, Da-Dum Da-Dum Diving Suit, Traveler's Map, Old Moon Flare.", "\235\140\128\236\150\145 \236\167\128\236\155\144\n\229\164\167\230\180\139\230\148\175\230\143\180", "\235\130\152\236\185\168\235\176\152, \235\185\160\235\176\164\235\185\160\235\176\164 \236\158\160\236\136\152\235\179\181, \236\151\172\237\150\137\236\158\144\236\157\152 \236\167\128\235\143\132, \234\183\184\235\175\144\235\139\172 \234\181\172\236\161\176 \236\139\160\237\152\184\237\131\132\n\230\150\185\229\144\145\231\155\152\239\188\140\229\153\148\230\132\163\229\153\148\230\132\163\230\189\156\230\176\180\230\156\141\239\188\140\230\151\133\232\161\140\232\128\133\229\156\176\229\155\190, \230\174\139\230\156\136\230\149\145\229\138\169\228\191\161\229\143\183\229\188\185", true)
  CREATE_BUTTON(3, 3, "\236\149\132\235\165\180\236\131\164\236\157\152 \236\176\189 \234\182\140\237\149\156\nArsha Authorization", "ArshaAdminQA()", 3, "\236\149\132\235\165\180\236\131\164\236\157\152 \236\176\189 \234\180\128\235\166\172\236\158\144 \234\182\140\237\149\156\nArena of Arsha Authorization.", "\236\149\132\235\165\180\236\131\164\236\157\152 \236\176\189 \234\182\140\237\149\156\n\233\152\191\229\139\146\232\142\142\231\154\132\230\157\131\233\153\144", "\236\149\132\235\165\180\236\131\164\236\157\152 \236\176\189 \234\180\128\235\166\172\236\158\144 \234\182\140\237\149\156\n\233\152\191\229\139\146\230\178\153\228\185\139\231\159\155\231\174\161\231\144\134\232\128\133\230\157\131\233\153\144", true)
end
function QASupport_AutomationPanel_CreateControl_Tab4()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\236\180\136\236\138\185\nCrescent Shrine", "TeleportCrescent()", 4, "\236\180\136\236\138\185\235\139\172 \236\136\152\237\152\184\236\158\144 \236\139\160\236\160\132\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Crescent Guardian shrine.", "\236\180\136\236\138\185\n\230\150\176\230\156\136", "\236\180\136\236\138\185\235\139\172 \236\136\152\237\152\184\236\158\144 \236\139\160\236\160\132\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\150\176\230\156\136\229\174\136\230\138\164\232\128\133\231\165\158\230\174\191", true)
  CREATE_BUTTON(1, 0, "\236\149\132\237\129\172\235\167\140\nAakman Temple", "TeleportAakman()", 4, "\236\149\132\237\129\172\235\167\140 \236\130\172\236\155\144\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Aakman Temple.", "\236\149\132\237\129\172\235\167\140\n\228\186\154\229\133\139\230\155\188", "\236\149\132\237\129\172\235\167\140 \236\130\172\236\155\144\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\228\186\154\229\133\139\230\155\188\229\175\186\229\186\153", true)
  CREATE_BUTTON(2, 0, "\237\158\136\236\138\164\237\138\184\235\166\172\236\149\132\nHystria Ruins", "TeleportHystria()", 4, "\237\158\136\236\138\164\237\138\184\235\166\172\236\149\132 \237\143\144\237\151\136\235\161\156 \236\157\180\235\143\153\nTeleports you to Hystria Ruins.", "\237\158\136\236\138\164\237\138\184\235\166\172\236\149\132\n\232\181\171\230\150\175\231\137\185\233\135\140\228\186\154", "\237\158\136\236\138\164\237\138\184\235\166\172\236\149\132 \237\143\144\237\151\136\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\181\171\230\150\175\231\137\185\233\135\140\228\186\154\229\186\159\229\162\159", true)
  CREATE_BUTTON(3, 0, "\237\149\132\235\157\188\236\191\160\nPila Ku Jail", "TeleportPilaKu()", 4, "\237\149\132\235\157\188 \236\191\160 \234\176\144\236\152\165\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Pila Ku Jail.", "\237\149\132\235\157\188\236\191\160\n\231\154\174\230\139\137\233\133\183", "\237\149\132\235\157\188 \236\191\160 \234\176\144\236\152\165\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\154\174\230\139\137\233\133\183\231\155\145\231\139\177", true)
  CREATE_BUTTON(4, 0, "\236\156\160\237\153\169\nRoud Sulfur Mine", "TeleportSulfur()", 4, "\235\163\168\235\147\156 \236\156\160\237\153\169 \234\180\145\236\130\176\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to oud Sulfur Mine.", "\236\156\160\237\153\169\n\232\183\175\229\190\183\231\161\171\231\163\186\231\159\191\229\177\177", "\235\163\168\235\147\156 \236\156\160\237\153\169 \234\180\145\236\130\176\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\183\175\229\190\183\231\161\171\231\163\186\231\159\191\229\177\177", true)
  CREATE_BUTTON(5, 0, "\235\175\184\235\163\168\235\170\169\nMirumok Ruins", "TeleportMirumok()", 4, "\235\175\184\235\163\168\235\170\169 \236\156\160\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\nTeleports you to Mirumok Ruins.", "\235\175\184\235\163\168\235\170\169\n\231\177\179\232\183\175\230\133\149\233\129\151\229\157\128", "\235\175\184\235\163\168\235\170\169 \236\156\160\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\177\179\232\183\175\230\133\149\233\129\151\229\157\128", true)
  CREATE_BUTTON(6, 0, "\236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \236\131\129\236\184\181\nSycraia Upper", "TeleportUnderwater()", 4, "\237\149\180\236\160\128 \235\141\152\236\160\132 \236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \236\131\129\236\184\181\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Sycraia Upper zone.", "\236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \236\131\129\236\184\181\n\229\184\140\229\133\139\230\139\137\228\190\157\228\186\154\228\184\138\229\177\130", "\237\149\180\236\160\128 \235\141\152\236\160\132 \236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \236\131\129\236\184\181\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\181\183\229\186\149\229\156\176\228\184\139\229\159\142\229\184\140\229\133\139\230\139\137\228\190\157\228\186\154\228\184\138\229\177\130", true)
  CREATE_BUTTON(7, 0, "\236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \237\149\152\236\184\181\nSycraia Abyssal", "TeleportSycraia()", 4, "\237\149\180\236\160\128 \235\141\152\236\160\132 \236\139\172\237\149\180 \236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \237\149\152\236\184\181\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Sycraia abyssal zone.", "\236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \237\149\152\236\184\181\n\229\184\140\229\133\139\230\139\137\228\190\157\228\186\154\228\184\139\229\177\130", "\237\149\180\236\160\128 \235\141\152\236\160\132 \236\139\172\237\149\180 \236\139\156\237\129\172\235\157\188\236\157\180\236\149\132 \237\149\152\236\184\181\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\181\183\229\186\149\229\156\176\228\184\139\229\159\142\229\184\140\229\133\139\230\139\137\228\190\157\228\186\154\228\184\139\229\177\130", true)
  CREATE_BUTTON(8, 0, "\235\179\132\235\172\180\235\141\164\nStar's End", "TeleportStarGrave()", 4, "\235\179\132\235\172\180\235\141\164\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Star's End.", "\235\179\132\235\172\180\235\141\164\n\231\185\129\230\152\159\228\185\139\229\162\147", "\235\179\132\235\172\180\235\141\164\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\185\129\230\152\159\228\185\139\229\162\147", true)
  CREATE_BUTTON(9, 0, "\237\148\132\235\161\156\237\139\176\nProtty Cave", "TeleportProtty()", 4, "\237\148\132\235\161\156\237\139\176 \235\143\153\234\181\180\235\161\156 \236\157\180\235\143\153\nTeleports you to Protty Cave.", "\237\148\132\235\161\156\237\139\176\n\230\153\174\231\189\151\230\143\144", "\237\148\132\235\161\156\237\139\176 \235\143\153\234\181\180\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\153\174\231\189\151\230\143\144\230\180\158\231\169\180", true)
  CREATE_BUTTON(0, 1, "\236\152\172\235\163\172\236\157\152 \234\179\132\234\179\161\nOlun's Valley", "TeleportOlun()", 4, "\236\152\172\235\163\172\236\157\152 \234\179\132\234\179\161\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Olun's Valley.", "\236\152\172\235\163\172\236\157\152 \234\179\132\234\179\161\n\229\165\165\228\188\166\231\154\132\229\179\161\232\176\183", "\236\152\172\235\163\172\236\157\152 \234\179\132\234\179\161\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\228\188\166\231\154\132\229\179\161\232\176\183", true)
  CREATE_BUTTON(1, 1, "\237\136\176\237\129\172\237\131\128\nTunkta", "TeleportTunkta()", 4, "\237\136\176\237\129\172\237\131\128\235\161\156 \236\157\180\235\143\153\nTeleports you to Tunkuta.", "\237\136\176\237\129\172\237\131\128\n\229\177\175\229\133\139\229\161\148", "\237\136\176\237\129\172\237\131\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\177\175\229\133\139\229\161\148", true)
  CREATE_BUTTON(2, 1, "\234\176\128\236\139\156\235\130\152\235\172\180 \236\136\178\nThornwood Forest", "TeleportThornwood()", 4, "\234\176\128\236\139\156\235\130\152\235\172\180 \236\136\178\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Thornwood Forest.", "\234\176\128\236\139\156\235\130\152\235\172\180 \236\136\178\n\229\136\186\230\160\145\228\184\155", "\234\176\128\236\139\156\235\130\152\235\172\180 \236\136\178\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\136\186\230\160\145\228\184\155", true)
  CREATE_BUTTON(3, 1, "\236\131\157\234\176\129\236\157\180 \236\158\160\235\147\160 \235\172\152\nSilent Grave", "TeleportSilent()", 4, "\236\131\157\234\176\129\236\157\180 \236\158\160\235\147\160 \235\172\152\235\161\156 \236\157\180\235\143\153\nTeleports you to Silent Grave.", "\236\131\157\234\176\129\236\157\180 \236\158\160\235\147\160 \235\172\152\n\229\176\152\229\191\181\228\185\139\229\162\147", "\236\131\157\234\176\129\236\157\180 \236\158\160\235\147\160 \235\172\152\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\176\152\229\191\181\228\185\139\229\162\147", true)
  CREATE_BUTTON(4, 1, "\236\158\191\235\185\155 \236\136\178\nAsh Forest", "TeleportAsh()", 4, "\236\158\191\235\185\155 \236\136\178\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Ash Forest.", "\236\158\191\235\185\155 \236\136\178\n\231\129\176\232\137\178\230\163\174\230\158\151", "\236\158\191\235\185\155 \236\136\178\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\129\176\232\137\178\230\163\174\230\158\151", true)
  CREATE_BUTTON(5, 1, "\237\149\143\235\185\155 \236\136\152\235\143\132\236\155\144\nBloody Monastery", "TeleportBloodyMonastery()", 4, "\237\149\143\235\185\155 \236\136\152\235\143\132\236\155\144 \235\130\180\235\182\128\235\161\156 \236\157\180\235\143\153\nTeleports you to Bloody Monastery.", "\237\149\143\235\185\155 \236\136\152\235\143\132\236\155\144\n\232\181\164\231\186\162\228\191\174\232\161\140\233\153\162", "\237\149\143\235\185\155 \236\136\152\235\143\132\236\155\144 \235\130\180\235\182\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\181\164\231\186\162\228\191\174\232\161\140\233\153\162", true)
  CREATE_BUTTON(6, 1, "\237\151\165\236\132\184 \236\132\177\236\151\173\nHexe Sanctuary", "TeleportHexe()", 4, "\237\151\165\236\132\184\235\161\156 \236\157\180\235\143\153\nTeleports you to Hexe Sanctuary.", "\237\151\165\236\132\184 \236\132\177\236\151\173\n\232\181\171\229\176\148\232\181\155\229\156\163\229\156\176", "\237\151\165\236\132\184\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\181\171\229\176\148\232\181\155\229\156\163\229\156\176", true)
  CREATE_BUTTON(7, 1, "\234\176\128\236\157\180\237\149\128\235\157\188\236\139\156\236\149\132\nGyfin", "TeleportGyfin()", 4, "\234\176\128\236\157\180\237\149\128\235\157\188\236\139\156\236\149\132\235\161\156 \236\157\180\235\143\153\nTeleports you to Gyfin.", "\234\176\128\236\157\180\237\149\128\235\157\188\236\139\156\236\149\132\n\231\155\150\232\138\172\230\139\137\232\165\191\228\186\154", "\234\176\128\236\157\180\237\149\128\235\157\188\236\139\156\236\149\132\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\155\150\232\138\172\230\139\137\232\165\191\228\186\154", true)
  CREATE_BUTTON(8, 1, "\236\153\184\235\136\136\235\176\149\236\157\180 \234\177\176\236\157\184\nCyclops", "TeleportCyclops()", 4, "\236\153\184\235\136\136\235\176\149\236\157\180 \234\177\176\236\157\184 \236\138\164\237\143\176 \236\156\132\236\185\152\235\161\156 \236\157\180\235\143\153\nTeleports you to Cyclops.", "\236\153\184\235\136\136\235\176\149\236\157\180 \234\177\176\236\157\184\n\231\139\172\231\156\188\229\183\168\228\186\186", "\236\153\184\235\136\136\235\176\149\236\157\180 \234\177\176\236\157\184 \236\138\164\237\143\176 \236\156\132\236\185\152\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\139\172\231\156\188\229\183\168\228\186\186\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(9, 1, "\236\185\168\236\134\140\nDarkseekers Retreat", "TeleportRetreat()", 4, "\236\150\180\235\145\160 \236\182\148\236\162\133\236\158\144\236\157\152 \236\185\168\236\134\140\235\161\156 \236\157\180\235\143\153\nTeleports you to Darkseekers Retreat.", "\236\185\168\236\134\140\n\228\189\143\229\164\132", "\236\150\180\235\145\160 \236\182\148\236\162\133\236\158\144\236\157\152 \236\185\168\236\134\140\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\233\187\145\230\154\151\232\191\189\233\154\143\232\128\133\228\189\143\229\164\132", true)
  CREATE_BUTTON(10, 1, "\234\179\160\236\155\144\nIsrahid Plateau", "TeleportIsrahid()", 4, "\236\157\180\236\138\164\235\157\188\237\158\136\235\147\156 \234\179\160\236\155\144\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Darkseekers Retreat.", "\234\179\160\236\155\144\n\233\171\152\229\142\159", "\236\157\180\236\138\164\235\157\188\237\158\136\235\147\156 \234\179\160\236\155\144\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\228\188\138\230\150\175\230\139\137\229\184\140\229\190\183\233\171\152\229\142\159", true)
  CREATE_BUTTON(11, 1, "\237\136\176\234\183\184\235\157\188\235\147\156 \236\156\160\236\160\129\236\167\128\nTungrad Ruins", "TeleportTungradRuins()", 4, "\237\136\176\234\183\184\235\157\188\235\147\156 \236\156\160\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\nTeleports you to Tungrad Ruins.", "\237\136\176\234\183\184\235\157\188\235\147\156 \236\156\160\236\160\129\236\167\128\n\231\137\185\230\129\169\230\139\137\229\190\183\233\129\151\229\157\128", "\237\136\176\234\183\184\235\157\188\235\147\156 \236\156\160\236\160\129\236\167\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\229\136\176\231\137\185\230\129\169\230\139\137\229\190\183\233\129\151\229\157\128", true)
  CREATE_BUTTON(0, 2, "\235\141\176\237\130\164\236\149\132 \236\149\132\236\157\180\237\133\156 \236\132\184\237\140\133\nDehkia Item Setting", "DehkiaItemSetting()", 4, "\235\141\176\237\130\164\236\149\132\236\157\152 \235\147\177\235\182\136 \236\149\132\236\157\180\237\133\156 \236\132\184\237\140\133\nDehkia's Lantern Setting.", "\235\141\176\237\130\164\236\149\132 \236\149\132\236\157\180\237\133\156 \236\132\184\237\140\133\n\228\187\163\229\159\186\228\186\154\233\129\147\229\133\183\232\174\190\231\189\174", "\235\141\176\237\130\164\236\149\132\236\157\152 \235\147\177\235\182\136 \236\149\132\236\157\180\237\133\156 \236\132\184\237\140\133\n\228\187\163\229\159\186\228\186\154\231\154\132\231\129\175\231\129\171\233\129\147\229\133\183\232\174\190\231\189\174", true)
  CREATE_BUTTON(1, 2, "\235\141\176\237\130\164\236\149\132 \236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148 \nDehkia CoolTimeReset", "DehkiaCoolTimeReset()", 4, "\235\141\176\237\130\164\236\149\132\236\157\152 \235\147\177\235\182\136 \236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148\nDehkia's Lantern CoolTimeReset.", "\235\141\176\237\130\164\236\149\132 \236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148 \n\233\135\141\231\189\174\228\187\163\229\159\186\228\186\154\233\129\147\229\133\183\231\154\132\229\134\183\229\141\180\230\151\182\233\151\180", "DehkiaCoolTimeReset()", "\235\141\176\237\130\164\236\149\132\236\157\152 \235\147\177\235\182\136 \236\191\168\237\131\128\236\158\132 \236\180\136\234\184\176\237\153\148\n\233\135\141\231\189\174\228\187\163\229\159\186\228\186\154\231\154\132\231\129\175\231\129\171\233\129\147\229\133\183\229\134\183\229\141\180\230\151\182\233\151\180", true)
  CREATE_BUTTON(0, 3, "\235\185\168\234\176\132\236\189\148\nRed Nose", "RednoseTest()", 4, "\235\185\168\234\176\132 \236\189\148(23061) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Red Nose(23061) spawn location.", "\235\185\168\234\176\132\236\189\148\n\231\186\162\233\188\187\229\173\144", "\235\185\168\234\176\132\236\189\148(23061) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\186\162\233\188\187\229\173\144(23061)\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(1, 3, "\236\154\176\235\145\148\237\149\156 \235\130\152\235\172\180 \236\160\149\235\160\185\nDim Tree Spirit", "DimTreeSpiritTest()", 4, "\236\154\176\235\145\148\237\149\156 \235\130\152\235\172\180 \236\160\149\235\160\185(23006) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Dim Tree Spirit(23006) spawn location.", "\236\154\176\235\145\148\237\149\156 \235\130\152\235\172\180 \236\160\149\235\160\185\n\230\132\154\233\146\157\231\154\132\230\160\145\231\178\190\231\129\181", "\236\154\176\235\145\148\237\149\156 \235\130\152\235\172\180 \236\160\149\235\160\185(23006) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\132\154\233\146\157\231\154\132\230\160\145\231\178\190\231\129\181(23006)\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(2, 3, "\235\178\160\234\183\184\nBheg", "BhegTest()", 4, "\235\178\160\234\183\184(23703) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Bheg(23703) spawn location.", "\235\178\160\234\183\184\n\232\180\157\229\133\139", "\235\178\160\234\183\184(23703) \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\180\157\229\133\139(23703)\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(3, 3, "\236\167\132\237\157\153\234\180\180\235\172\188\nMudster", "MudTest()", 4, "\236\167\132\237\157\153\234\180\180\235\172\188 \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Mudster spawn location.", "\236\167\132\237\157\153\234\180\180\235\172\188\n\230\179\165\229\156\159\230\128\170\231\137\169", "\236\167\132\237\157\153\234\180\180\235\172\188 \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\179\165\229\156\159\230\128\170\231\137\169\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(4, 3, "\235\176\148\236\149\132\235\167\136\237\130\164\236\149\132\nVahmalkea", "TeleportAtoraxxion1()", 4, "\235\176\148\236\149\132\235\167\136\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757164, \236\151\152\235\185\132\236\149\132:757204\nVahmalkea, normal key:757164, Elvia:757204.", "\235\176\148\236\149\132\235\167\136\237\130\164\236\149\132\n\229\183\180\229\176\148\231\142\155\229\133\139", "\235\176\148\236\149\132\235\167\136\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757164, \236\151\152\235\185\132\236\149\132:757204\n\229\183\180\229\176\148\231\142\155\229\133\139\239\188\140\233\146\165\229\140\153 \230\153\174\233\128\154:757164, \232\137\190\229\176\148\230\175\148\228\186\154:757204", true)
  CREATE_BUTTON(5, 3, "\236\139\156\236\185\180\235\157\188\237\130\164\236\149\132\nSycrakea", "TeleportAtoraxxion2()", 4, "\236\139\156\236\185\180\235\157\188\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757272, \236\151\152\235\185\132\236\149\132:757280\nSycrakea, normal key:757272, Elvia:757280.", "\236\139\156\236\185\180\235\157\188\237\130\164\236\149\132\n\229\184\140\229\141\161\230\139\137\229\133\139", "\236\139\156\236\185\180\235\157\188\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757272, \236\151\152\235\185\132\236\149\132:757280\n\229\184\140\229\141\161\230\139\137\229\133\139\239\188\140\233\146\165\229\140\153 \230\153\174\233\128\154:757272, \232\137\190\229\176\148\230\175\148\228\186\154:757280", true)
  CREATE_BUTTON(6, 3, "\236\154\148\235\163\168\235\130\152\237\130\164\236\149\132\nYolunakea", "TeleportAtoraxxion3()", 4, "\236\154\148\235\163\168\235\130\152\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757324, \236\151\152\235\185\132\236\149\132:757331\nYolunakea, normal key: 757324, Elvia:757331.", "\236\154\148\235\163\168\235\130\152\237\130\164\236\149\132\n\231\186\166\233\178\129\231\186\179\229\133\139", "\236\154\148\235\163\168\235\130\152\237\130\164\236\149\132,\236\151\180\236\135\160 \236\157\188\235\176\152:757324, \236\151\152\235\185\132\236\149\132:757331\n\231\186\166\233\178\129\231\186\179\229\133\139\239\188\140\233\146\165\229\140\153 \230\153\174\233\128\154:757324, \232\137\190\229\176\148\230\175\148\228\186\154:757331", true)
end
function QASupport_AutomationPanel_CreateControl_Tab5()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\237\129\172\236\158\144\236\185\180 \236\157\180\235\143\153\nKzarka Tele", "KzarkaTest()", 5, "\237\129\172\236\158\144\236\185\180(23001) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Kzarka(23001) spawn location.", "\237\129\172\236\158\144\236\185\180 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\159\175\230\137\142\229\141\161", "\237\129\172\236\158\144\236\185\180(23001) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\159\175\230\137\142\229\141\161(23001) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(1, 0, "\235\136\132\235\178\160\235\165\180 \236\157\180\235\143\153\nNouver Tele", "NouverTest()", 5, "\235\136\132\235\178\160\235\165\180(23032) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153,\nTeleports you to Nouver(23032) spawn location.", "\235\136\132\235\178\160\235\165\180 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\189\151\232\163\180\229\139\146", "\235\136\132\235\178\160\235\165\180(23032) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153,\n\231\167\187\229\138\168\232\135\179\231\189\151\232\163\180\229\139\146(23032) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(2, 0, "\236\185\180\235\158\128\235\139\164 \236\157\180\235\143\153\nKaranda Tele", "KarandaTest()", 5, "\236\185\180\235\158\128\235\139\164(23060) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Karanda(23060) spawn location.", "\236\185\180\235\158\128\235\139\164 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\229\178\154\232\190\190", "\236\185\180\235\158\128\235\139\164(23060) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\229\178\154\232\190\190(23060) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(3, 0, "\236\191\160\237\136\188 \236\157\180\235\143\153\nKutum", "KutumTest()", 5, "\236\191\160\237\136\188(23073) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Kutum(23073) spawn location.", "\236\191\160\237\136\188 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\186\147\229\177\175", "\236\191\160\237\136\188(23073) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\186\147\229\177\175(23073) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(4, 0, "\234\176\128\235\170\168\236\138\164 \236\157\180\235\143\153\nGarmoth Tele", "GarmothTest()", 5, "\234\176\128\235\170\168\236\138\164(23120) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Garmoth(23120) spawn location.", "\234\176\128\235\170\168\236\138\164 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\232\142\171\230\150\175", "\234\176\128\235\170\168\236\138\164(23120) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\232\142\171\230\150\175(23120) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(5, 0, "\236\152\164\237\149\128 \236\157\180\235\143\153\nOffin Tele", "OpinTest()", 5, "\236\152\164\237\149\128(23809) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Offin Tet(23809) spawn location.@", "\236\152\164\237\149\128 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\229\185\179", "\236\152\164\237\149\128(23809) \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\165\165\229\185\179(23809) \231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(6, 0, "\234\183\132\237\138\184 \236\157\180\235\143\153\nQuint Tele", "QuintTest()", 5, "\234\183\132\237\138\184 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Quint spawn location.", "\234\183\132\237\138\184 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\130\175\230\129\169\231\137\185", "\234\183\132\237\138\184 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\130\175\230\129\169\231\137\185\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(7, 0, "\235\172\180\235\157\188\236\185\180 \236\157\180\235\143\153\nMuraka Tele", "MurakaTest()", 5, "\235\172\180\235\157\188\236\185\180 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Muraka spawn location.", "\235\172\180\235\157\188\236\185\180 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\156\168\230\139\137\229\141\161", "\235\172\180\235\157\188\236\185\180 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\230\156\168\230\139\137\229\141\161\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(8, 0, "\235\178\168 \236\157\180\235\143\153\nVell Tele", "VellTest()", 5, "\235\178\168 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153, \235\178\168 \236\166\137\236\139\156 \236\131\157\236\132\177\236\157\128 [\235\178\168 \236\134\140\237\153\152] \235\178\132\237\138\188 \236\157\180\236\154\169\nTeleports you to Vell spawn location. To create Vell, press the [Summon Vell] button.", "\235\178\168 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\184\183\233\179\132", "\235\178\168 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153, \235\178\168 \236\166\137\236\139\156 \236\131\157\236\132\177\236\157\128 [\235\178\168 \236\134\140\237\153\152] \235\178\132\237\138\188 \236\157\180\236\154\169\n\231\167\187\229\138\168\232\135\179\229\184\183\233\179\132\231\148\159\230\136\144\229\140\186, \229\184\183\233\179\132\231\171\139\229\141\179\231\148\159\230\136\144\228\189\191\231\148\168[\229\184\183\233\179\132\229\143\172\229\148\164]\233\148\174\229\141\179\229\143\175", true)
  CREATE_BUTTON(9, 0, "\236\185\184 \236\157\180\235\143\153\nKhan Tele", "TeleportOkillua()", 5, "\236\185\184 \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Khan spawn location.", "\236\185\184 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\130\175\230\129\169", "\236\185\184 \236\131\157\236\132\177 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\232\130\175\230\129\169\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(0, 1, "\237\129\172\236\158\144\236\185\180 \236\131\157\236\132\177 23001\nKzarka Spawn", "CreateKzarka()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \237\129\172\236\158\144\236\185\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Kzaraka on your current location.", "\237\129\172\236\158\144\236\185\180 \236\131\157\236\132\177 23001\n\231\148\159\230\136\144\230\159\175\230\137\142\229\141\161 23001", "\235\130\180 \236\156\132\236\185\152\236\151\144 \237\129\172\236\158\144\236\185\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\230\159\175\230\137\142\229\141\161", true)
  CREATE_BUTTON(1, 1, "\235\136\132\235\178\160\235\165\180 \236\131\157\236\132\177 23032\nNouver Spawn", "CreateNouver()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \235\136\132\235\178\160\235\165\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Nouver on your current location.", "\235\136\132\235\178\160\235\165\180 \236\131\157\236\132\177 23032\n\231\148\159\230\136\144\231\189\151\232\163\180\229\139\146 23032", "\235\130\180 \236\156\132\236\185\152\236\151\144 \235\136\132\235\178\160\235\165\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\231\189\151\232\163\180\229\139\146", true)
  CREATE_BUTTON(2, 1, "\236\185\180\235\158\128\235\139\164 \236\131\157\236\132\177 23060\nKaranda Spawn", "CreateKaranda()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\185\180\235\158\128\235\139\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Karanda on your current location.", "\236\185\180\235\158\128\235\139\164 \236\131\157\236\132\177 23060\n\231\148\159\230\136\144\229\141\161\229\178\154\232\190\190 23060", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\185\180\235\158\128\235\139\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\229\141\161\229\178\154\232\190\190", true)
  CREATE_BUTTON(3, 1, "\236\191\160\237\136\188 \236\131\157\236\132\177 23073\nKutum Spawn", "CreateKutum()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\191\160\237\136\188\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Kutum on your current location.", "\236\191\160\237\136\188 \236\131\157\236\132\177 23073\n\231\148\159\230\136\144\229\186\147\229\177\175 23073", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\191\160\237\136\188\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\229\186\147\229\177\175", true)
  CREATE_BUTTON(4, 1, "\234\176\128\235\170\168\236\138\164 \236\131\157\236\132\177 23120\nGarmoth Spawn", "CreateGarmoth()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \234\176\128\235\170\168\236\138\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Garmoth on your current location.", "\234\176\128\235\170\168\236\138\164 \236\131\157\236\132\177 23120\n\231\148\159\230\136\144\229\141\161\232\142\171\230\150\175 23120", "\235\130\180 \236\156\132\236\185\152\236\151\144 \234\176\128\235\170\168\236\138\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\229\141\161\232\142\171\230\150\175", true)
  CREATE_BUTTON(5, 1, "\236\152\164\237\149\128 \236\131\157\236\132\177 23809\nOffin Spawn", "CreateOffin()", 5, "\236\152\164\237\149\128 \236\138\164\237\143\176 \235\170\133\235\160\185\236\150\180\nSpawn Offin.", "\236\152\164\237\149\128 \236\131\157\236\132\177 23809\n\231\148\159\230\136\144\229\165\165\229\185\179 23809", "\236\152\164\237\149\128 \236\138\164\237\143\176 \235\170\133\235\160\185\236\150\180\n\231\148\159\230\136\144\229\165\165\229\185\179\230\140\135\228\187\164", true)
  CREATE_BUTTON(6, 1, "\234\183\132\237\138\184 \236\131\157\236\132\177 23102\nQuint Spawn", "CreateQuint()", 5, "\234\183\132\237\138\184 \236\132\157\236\131\129 \236\138\164\237\143\176. \236\132\157\236\131\129\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148. \nSpawn Quint.", "\234\183\132\237\138\184 \236\131\157\236\132\177 23102\n\231\148\159\230\136\144\232\130\175\230\129\169\231\137\185 23102", "\234\183\132\237\138\184 \236\132\157\236\131\129 \236\138\164\237\143\176. \236\132\157\236\131\129\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148.\n\231\148\159\230\136\144\232\130\175\230\129\169\231\137\185\231\159\179\229\131\143, \232\175\183\230\178\161\230\156\137\231\159\179\229\131\143\231\154\132\230\151\182\229\128\153\228\189\191\231\148\168", true)
  CREATE_BUTTON(7, 1, "\234\183\132\237\138\184 \237\153\156\236\132\177\237\153\148 23099\nQuint Acctive", "AcctiveQuint()", 5, "\234\183\132\237\138\184 \236\132\157\236\131\129 \237\153\156\236\132\177\237\153\148. \236\132\157\236\131\129\236\157\180 \236\158\136\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148. \nSpawn Offin on your current location.", "\234\183\132\237\138\184 \237\153\156\236\132\177\237\153\148 23099\n\230\191\128\230\180\187\232\130\175\230\129\169\231\137\185 23099", "\234\183\132\237\138\184 \236\132\157\236\131\129 \237\153\156\236\132\177\237\153\148. \236\132\157\236\131\129\236\157\180 \236\158\136\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148. \n\230\191\128\230\180\187\232\130\175\230\129\169\231\137\185\231\159\179\229\131\143. \232\175\183\230\156\137\231\159\179\229\131\143\231\154\132\230\151\182\229\128\153\228\189\191\231\148\168", true)
  CREATE_BUTTON(8, 1, "\235\178\168 \236\134\140\237\153\152\nSummon Vell", "SummonVell()", 5, "\236\130\172\236\154\169\236\151\144 \236\160\136\235\140\128 \236\163\188\236\157\152\237\149\152\236\132\184\236\154\148. \235\178\168\236\157\152 \236\152\129\236\151\173\236\151\144\236\132\156\235\167\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148.\nWARING: Take caution when using. Only use this in Vell's Realm.", "\235\178\168 \236\134\140\237\153\152\n\229\143\172\229\148\164\229\184\183\233\179\132", "\236\130\172\236\154\169\236\151\144 \236\160\136\235\140\128 \236\163\188\236\157\152\237\149\152\236\132\184\236\154\148. \235\178\168\236\157\152 \236\152\129\236\151\173\236\151\144\236\132\156\235\167\140 \236\130\172\236\154\169\237\149\180\236\163\188\236\132\184\236\154\148.\n\232\175\183\230\179\168\230\132\143\228\189\191\231\148\168\239\188\129\239\188\129.\228\187\133\229\156\168\229\184\183\233\179\132\233\162\134\229\159\159\228\184\138\228\189\191\231\148\168", true)
  CREATE_BUTTON(0, 2, "\236\167\132 \237\129\172\236\158\144\236\185\180 \236\131\157\236\132\177 23172\nAwake Kzarka Spawn", "CreateZKzarka()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \237\129\172\236\158\144\236\185\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Awake Kzaraka on your current location.", "\236\167\132 \237\129\172\236\158\144\236\185\180 \236\131\157\236\132\177 23172\n\231\148\159\230\136\144\231\156\159\230\159\175\230\137\142\229\141\16123172", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \237\129\172\236\158\144\236\185\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\231\156\159\230\159\175\230\137\142\229\141\161", true)
  CREATE_BUTTON(1, 2, "\236\167\132 \235\136\132\235\178\160\235\165\180 \236\131\157\236\132\177 23200\nAwake Nouver Spawn", "CreateZNouver()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \235\136\132\235\178\160\235\165\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Awake Nouver on your current location.", "\236\167\132 \235\136\132\235\178\160\235\165\180 \236\131\157\236\132\177 23200\n\231\148\159\230\136\144\231\156\159\231\189\151\232\163\180\229\139\14623200", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \235\136\132\235\178\160\235\165\180\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\231\156\159\231\189\151\232\163\180\229\139\146", true)
  CREATE_BUTTON(2, 2, "\236\167\132 \236\185\180\235\158\128\235\139\164 \236\131\157\236\132\177 23060\nAwake Karanda Spawn", "CreateZKaranda()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \236\185\180\235\158\128\235\139\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Awake Karanda on your current location.", "\236\167\132 \236\185\180\235\158\128\235\139\164 \236\131\157\236\132\177 23060\n\231\148\159\230\136\144\231\156\159\229\141\161\229\178\154\232\190\19023060", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \236\185\180\235\158\128\235\139\164\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\231\156\159\229\141\161\229\178\154\232\190\190", true)
  CREATE_BUTTON(3, 2, "\236\167\132 \236\191\160\237\136\188 \236\131\157\236\132\177 23073\nKutum Spawn", "CreateZKutum()", 5, "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \236\191\160\237\136\188\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\nSpawn Awake Kutum on your current location.", "\236\167\132 \236\191\160\237\136\188 \236\131\157\236\132\177 23073\n\231\148\159\230\136\144\231\156\159\229\186\147\229\177\17523073", "\235\130\180 \236\156\132\236\185\152\236\151\144 \236\167\132 \236\191\160\237\136\188\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164.\n\229\156\168\230\173\164\228\189\141\231\189\174\231\148\159\230\136\144\231\156\159\229\186\147\229\177\175", true)
  CREATE_BUTTON(0, 3, "\235\179\180\236\138\164\235\147\164 \236\167\128\236\139\157\237\154\141\235\147\157\nBoss Knowledge", "CreateAllBossKnowledge()", 5, "\235\170\168\235\147\160 \235\179\180\236\138\164\235\147\164\236\157\152 \236\167\128\236\139\157\236\157\132 \237\154\141\235\147\157\236\139\156\237\130\181\235\139\136\235\139\164.\nGain knowledge of all bosses.", "\235\179\180\236\138\164\235\147\164 \236\167\128\236\139\157\237\154\141\235\147\157\n\232\142\183\229\190\151\230\137\128\230\156\137\228\184\150\231\149\140\229\164\180\231\155\174\231\154\132\231\159\165\232\175\134", "\235\170\168\235\147\160 \235\179\180\236\138\164\235\147\164\236\157\152 \236\167\128\236\139\157\236\157\132 \237\154\141\235\147\157\236\139\156\237\130\181\235\139\136\235\139\164.\n\232\142\183\229\190\151\230\137\128\230\156\137\228\184\150\231\149\140\229\164\180\231\155\174\231\154\132\231\159\165\232\175\134", true)
  CREATE_BUTTON(1, 3, "\235\179\180\236\138\164 \236\158\144\236\151\176\236\130\172\nRemove Bosses", "DespawnAllBoss()", 5, "\235\170\168\235\147\160 \235\179\180\236\138\164\235\165\188 \236\158\144\236\151\176\236\130\172\236\139\156\237\130\181\235\139\136\235\139\164.\nMakes all the bosses disappear.", "\235\179\180\236\138\164 \236\158\144\236\151\176\236\130\172\n\228\184\150\231\149\140\229\164\180\231\155\174\232\135\170\231\132\182\230\173\187\228\186\161", "\235\170\168\235\147\160 \235\179\180\236\138\164\235\165\188 \236\158\144\236\151\176\236\130\172\236\139\156\237\130\181\235\139\136\235\139\164.\n\228\189\191\230\137\128\230\156\137\228\184\150\231\149\140\229\164\180\231\155\174\232\135\170\231\132\182\230\173\187\228\186\161", true)
  CREATE_BUTTON(2, 3, "\235\179\180\236\138\164 \236\178\180\235\160\165 \236\180\136\234\184\176\237\153\148\nReset Boss HP", "ResetAllBossHP()", 5, "\235\170\168\235\147\160 \235\179\180\236\138\164\236\157\152 \236\178\180\235\160\165\236\157\132 \236\180\136\234\184\176\237\153\148\237\149\169\235\139\136\235\139\164.\nResets the HP of all bosses.", "\235\179\180\236\138\164 \236\178\180\235\160\165 \236\180\136\234\184\176\237\153\148\n\233\135\141\231\189\174\228\184\150\231\149\140\229\164\180\231\155\174\231\154\132\231\148\159\229\145\189\229\138\155", "\235\170\168\235\147\160 \235\179\180\236\138\164\236\157\152 \236\178\180\235\160\165\236\157\132 \236\180\136\234\184\176\237\153\148\237\149\169\235\139\136\235\139\164.\n\233\135\141\231\189\174\230\137\128\230\156\137\228\184\150\231\149\140\229\164\180\231\155\174\231\154\132\231\148\159\229\145\189\229\128\188", true)
end
function QASupport_AutomationPanel_CreateControl_Tab6()
  if false == QASupport_AutomationPanel_SafeCheck() then
    return
  end
  CREATE_BUTTON(0, 0, "\235\167\136\234\181\172 \236\132\184\237\138\184\nHorse Set", "CreateHorseEquip()", 6, "\235\167\136\235\169\180, \235\167\136\234\176\145, \236\149\136\236\158\165, \235\147\177\236\158\144, \237\142\184\236\158\144, \235\167\136\237\142\184, \237\148\188\235\166\172 \236\131\157\236\132\177\nChampron, Barding, Saddle, Stirrups, Horseshoe, Riding Crop, Horse Flute.", "\235\167\136\234\181\172 \236\132\184\237\138\184\n\233\169\172\229\133\183\229\165\151\232\163\133", "\235\167\136\235\169\180, \235\167\136\234\176\145, \236\149\136\236\158\165, \235\147\177\236\158\144, \237\142\184\236\158\144, \235\167\136\237\142\184, \237\148\188\235\166\172 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\169\172\233\157\162\227\128\129\233\169\172\233\147\160\227\128\129\233\169\172\233\158\141\227\128\129\233\169\172\233\149\171, \233\169\172\232\185\132, \233\169\172\233\158\173, \231\172\155\229\173\144", true)
  CREATE_BUTTON(1, 0, "8\236\132\184\235\140\128 \236\149\148\235\167\144\nT8 F Horse", "CreateHorse()", 6, "8\236\132\184\235\140\128 \236\149\148\235\167\144 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a tier 8 female horse. WARNING! You must not have a horse taken out to use this.", "8\236\132\184\235\140\128 \236\149\148\235\167\144\n8\228\187\163\230\175\141\233\169\172", "8\236\132\184\235\140\128 \236\149\148\235\167\144 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\1448\228\187\163\230\175\141\233\169\172\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(2, 0, "8\236\132\184\235\140\128 \236\136\152\235\167\144\nT8 M Horse", "CreateMaleHorse()", 6, "8\236\132\184\235\140\128 \236\136\152\235\167\144 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a tier 8 male horse. WARNING! You must not have a horse taken out to use this.", "8\236\132\184\235\140\128 \236\136\152\235\167\144\n8\228\187\163\229\133\172\233\169\172", "8\236\132\184\235\140\128 \236\136\152\235\167\144 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\1448\228\187\163\229\133\172\233\169\172, \230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(3, 0, "\237\142\152\235\166\172\235\143\132\237\138\184 \236\136\178\234\184\184 \235\167\136\236\176\168\nPeridotForestPathWagon", "CreatePeridotForestPathWagon()", 6, "\237\142\152\235\166\172\235\143\132\237\138\184 \236\136\178\234\184\184 \235\167\136\236\176\168 \236\131\157\236\132\177.\nCreates a Peridot Forest Path Wagon.", "\237\142\152\235\166\172\235\143\132\237\138\184 \236\136\178\234\184\184 \235\167\136\236\176\168\n\231\143\141\232\180\181\230\169\132\230\166\132\231\159\179\230\163\174\230\158\151\233\169\172\232\189\166", "\237\142\152\235\166\172\235\143\132\237\138\184 \236\136\178\234\184\184 \235\167\136\236\176\168 \236\131\157\236\132\177.\n\231\148\159\230\136\144\231\143\141\232\180\181\230\169\132\230\166\132\231\159\179\230\163\174\230\158\151\233\169\172\232\189\166", true)
  CREATE_BUTTON(4, 0, "\237\131\145\236\138\185\235\172\188 15\235\160\136\235\178\168\nMount Lv.15", "ToClient_qaLevelUpRidingServant(15)", 6, "\237\131\145\236\138\185\235\172\188\236\157\152 \235\160\136\235\178\168\236\157\132 15\235\161\156 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.\nSet the mount's level to 15.", "\237\131\145\236\138\185\235\172\188 15\235\160\136\235\178\168\n\229\157\144\233\170\145 15\231\173\137\231\186\167", "\237\131\145\236\138\185\235\172\188\236\157\152 \235\160\136\235\178\168\236\157\132 15\235\161\156 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.\n\229\157\144\233\170\145\231\154\132\231\173\137\231\186\167\232\174\190\231\189\174\230\136\14415\231\173\137\231\186\167", true)
  CREATE_BUTTON(5, 0, "\237\131\145\236\138\185\235\172\188 30\235\160\136\235\178\168\nMount Lv.30", "ToClient_qaLevelUpRidingServant(30)", 6, "\237\131\145\236\138\185\235\172\188\236\157\152 \235\160\136\235\178\168\236\157\132 30\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.\nSet the mount's level to 30.", "\237\131\145\236\138\185\235\172\188 30\235\160\136\235\178\168\n\229\157\144\233\170\145 30\231\173\137\231\186\167", "\237\131\145\236\138\185\235\172\188\236\157\152 \235\160\136\235\178\168\236\157\132 30\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.\n\229\157\144\233\170\145\231\154\132\231\173\137\231\186\167\232\174\190\231\189\174\230\136\14430\231\173\137\231\186\167", true)
  CREATE_BUTTON(6, 0, "\236\163\188\237\150\137 \236\138\164\237\130\172 \236\138\181\235\147\157\nHorseMoveSkills", "LearnDrivingSkill()", 6, "\235\167\144 \236\154\180\236\160\132\236\151\144 \237\149\132\236\154\148\237\149\156 \236\138\164\237\130\172\235\147\164\235\167\140 \236\138\181\235\147\157\237\149\169\235\139\136\235\139\164. \235\147\156\235\166\172\237\148\132\237\138\184, \236\160\132\235\160\165\236\167\136\236\163\188, \236\139\156\236\158\145\234\176\128\236\134\141, \235\134\146\236\157\128\235\143\132\236\149\189, \234\184\137\236\160\149\236\167\128, \236\136\156\234\176\132\234\176\128\236\134\141, \235\143\140\236\167\132, \236\184\161\235\169\180\236\157\180\235\143\153, \235\185\160\235\165\184\235\146\183\234\177\184\236\157\140, \236\151\176\236\134\141\235\143\132\236\149\189, \235\185\160\235\165\184\237\131\145\236\138\185, \236\151\176:\236\136\156\234\176\132\234\176\128\236\134\141, \236\134\141:\236\184\161\235\169\180\236\157\180\235\143\153\nThe horse learns all the skills required for driving. (Drift, Sprint, Start Accel, High Jump, Quick Stop, Instant Accel, Charge, Sideways, Quick Back, Streak Leap, Quick Ride, S: Instant Accel, S: Sideways)", "\236\163\188\237\150\137 \236\138\164\237\130\172 \236\138\181\235\147\157\n\228\185\160\229\190\151\232\161\140\233\169\182\230\138\128\232\131\189", "\235\167\144 \236\154\180\236\160\132\236\151\144 \237\149\132\236\154\148\237\149\156 \236\138\164\237\130\172\235\147\164\235\167\140 \236\138\181\235\147\157\237\149\169\235\139\136\235\139\164. \235\147\156\235\166\172\237\148\132\237\138\184, \236\160\132\235\160\165\236\167\136\236\163\188, \236\139\156\236\158\145\234\176\128\236\134\141, \235\134\146\236\157\128\235\143\132\236\149\189, \234\184\137\236\160\149\236\167\128, \236\136\156\234\176\132\234\176\128\236\134\141, \235\143\140\236\167\132, \236\184\161\235\169\180\236\157\180\235\143\153, \235\185\160\235\165\184\235\146\183\234\177\184\236\157\140, \236\151\176\236\134\141\235\143\132\236\149\189, \235\185\160\235\165\184\237\131\145\236\138\185, \236\151\176:\236\136\156\234\176\132\234\176\128\236\134\141, \236\134\141:\236\184\161\235\169\180\236\157\180\235\143\153\n\228\185\160\229\190\151\233\170\145\233\169\172\230\151\182\233\156\128\232\166\129\231\154\132\230\138\128\232\131\189. \229\134\178\229\136\186, \232\181\183\230\173\165\229\138\160\233\128\159, \233\171\152\232\183\179\232\183\131, \230\128\165\229\129\156, \231\158\172\233\151\180\229\138\160\233\128\159, \233\163\152\231\167\187, \228\190\167\233\157\162\231\167\187\229\138\168, \229\191\171\233\128\159\229\144\142\233\128\128, \232\191\158\231\187\173\232\183\179\232\183\131, \232\191\158\239\188\154\231\158\172\233\151\180\229\138\160\233\128\159\227\128\129\233\128\159\239\188\154\228\190\167\233\157\162\231\167\187\229\138\168", true)
  CREATE_BUTTON(7, 0, "\236\138\164\237\130\172 \237\155\136\235\160\168 \236\153\132\235\163\140\nTrain Skills", "ServantSkillAllMaster()", 6, "\237\131\145\236\138\185\235\172\188\236\151\144 \237\131\145\236\138\185\237\149\156 \236\177\132\235\161\156 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164. \237\131\145\236\138\185\235\172\188 \235\170\168\235\147\160 \236\138\164\237\130\172 \237\155\136\235\160\168\235\143\132 100%\235\161\156 \236\132\164\236\160\149.\nTrain all the skills that mount has to 100%. You must be riding it to use this function.", "\236\138\164\237\130\172 \237\155\136\235\160\168 \236\153\132\235\163\140\n\229\174\140\230\136\144\230\138\128\232\131\189\232\174\173\231\187\131", "\237\131\145\236\138\185\235\172\188\236\151\144 \237\131\145\236\138\185\237\149\156 \236\177\132\235\161\156 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164. \237\131\145\236\138\185\235\172\188 \235\170\168\235\147\160 \236\138\164\237\130\172 \237\155\136\235\160\168\235\143\132 100%\235\161\156 \236\132\164\236\160\149.\n\228\185\152\229\157\144\229\156\168\229\157\144\233\170\145\228\184\138\228\189\191\231\148\168\239\188\140\229\157\144\233\170\145\230\137\128\230\156\137\232\174\173\231\187\131\233\131\189\232\174\190\231\189\174\230\136\144100%", true)
  CREATE_BUTTON(8, 0, "\237\129\172\237\136\172\235\158\128\236\157\152 \234\179\188\236\157\188\nQuturan's Fruit", "CreateQuturan()", 6, "\237\129\172\237\136\172\235\158\128\236\157\152 \234\179\188\236\157\188 \236\131\157\236\132\177\nCreate Qutura's Fruit", "\237\129\172\237\136\172\235\158\128\236\157\152 \234\179\188\236\157\188\n\229\133\139\229\155\190\229\133\176\231\154\132\230\158\156\229\174\158", "\237\129\172\237\136\172\235\158\128\236\157\152 \234\179\188\236\157\188 \236\131\157\236\132\177\n\231\148\159\230\136\144\229\133\139\229\155\190\229\133\176\231\154\132\230\158\156\229\174\158", true)
  CREATE_BUTTON(9, 0, "\236\164\128\235\167\136 \237\155\136\235\160\168 \236\158\172\235\163\140\nTraining Support", "CreateDreamHorse()", 6, "\236\164\128\235\167\136 \237\155\136\235\160\168 \236\158\172\235\163\140\235\147\164 \236\131\157\236\132\177\nCreates Traning Support", "\236\164\128\235\167\136 \237\155\136\235\160\168 \236\158\172\235\163\140\n\233\170\143\233\169\172\232\174\173\231\187\131\230\157\144\230\150\153", "\236\164\128\235\167\136 \237\155\136\235\160\168 \236\158\172\235\163\140\235\147\164 \236\131\157\236\132\177\n\231\148\159\230\136\144\233\170\143\233\169\172\232\174\173\231\187\131\230\157\144\230\150\153", true)
  CREATE_BUTTON(0, 1, "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\nArduanatt", "CreateAduahnott()", 6, "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates an Arduanatt. WARNING! You must not have a horse taken out to use this.", "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\n\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185", "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(1, 1, "\236\149\132\235\145\144 \236\160\132\236\154\169 \236\138\164\237\130\172\nArdu Skills", "LearnAduahnottSkill()", 6, "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\nLearns all Arduanatt exclusive skills. You must be riding it to use this function.", "\236\149\132\235\145\144 \236\160\132\236\154\169 \236\138\164\237\130\172\n\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185\228\184\147\231\148\168\230\138\128\232\131\189", "\236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\n\228\187\133\229\143\175\228\186\142\228\185\152\229\157\144\229\156\168\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185\228\184\138\230\151\182\228\189\191\231\148\168\227\128\130\228\185\160\229\190\151\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185\228\184\147\231\148\168\230\138\128\232\131\189", true)
  CREATE_BUTTON(2, 1, "\235\148\148\235\132\164\nDine", "CreateDine()", 6, "\235\148\148\235\132\164 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a Din\195\169. WARNING! You must not have a horse taken out to use this.", "\235\148\148\235\132\164\n\232\191\170\229\134\133", "\235\148\148\235\132\164 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\232\191\170\229\134\133, \230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(3, 1, "\235\148\148\235\132\164 \236\160\132\236\154\169 \236\138\164\237\130\172\nDin\195\169 Skills", "LearnDineSkill()", 6, "\235\148\148\235\132\164\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \235\148\148\235\132\164 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\nLearns all Din\195\169 exclusive skills. You must be riding it to use this function.", "\235\148\148\235\132\164 \236\160\132\236\154\169 \236\138\164\237\130\172\n\232\191\170\229\134\133\228\184\147\231\148\168\230\138\128\232\131\189", "\235\148\148\235\132\164\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \235\148\148\235\132\164 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\n\228\187\133\229\143\175\228\186\142\228\185\152\229\157\144\229\156\168\232\191\170\229\134\133\228\184\138\230\151\182\228\189\191\231\148\168\227\128\130\228\185\160\229\190\151\232\191\170\229\134\133\228\184\147\231\148\168\230\138\128\232\131\189", true)
  CREATE_BUTTON(4, 1, "\235\145\160\nDoom", "CreateDoom()", 6, "\235\145\160 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a Doom. WARNING! You must not have a horse taken out to use this.", "\235\145\160\n\230\157\156\229\167\134", "\235\145\160 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\230\157\156\229\167\134\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(5, 1, "\235\145\160 \236\160\132\236\154\169 \236\138\164\237\130\172\nDoom Skills", "LearnDoomSkill()", 6, "\235\145\160\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \235\145\160 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\nLearns all Doom exclusive skills. You must be riding it to use this function.", "\235\145\160 \236\160\132\236\154\169 \236\138\164\237\130\172\n\230\157\156\229\167\134\228\184\147\231\148\168\230\138\128\232\131\189", "\235\145\160\236\151\144 \237\131\145\236\138\185\237\149\180 \236\158\136\236\157\132 \235\149\140\236\151\144\235\167\140 \236\130\172\236\154\169\237\149\152\236\132\184\236\154\148. \235\145\160 \236\160\132\236\154\169 \236\138\164\237\130\172 \236\138\181\235\147\157.\n\228\187\133\229\143\175\228\186\142\228\185\152\229\157\144\229\156\168\230\157\156\229\167\134\228\184\138\230\151\182\228\189\191\231\148\168\227\128\130\228\185\160\229\190\151\230\157\156\229\167\134\228\184\147\231\148\168\230\138\128\232\131\189", true)
  CREATE_BUTTON(6, 1, "\234\191\136\234\178\176 \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\nMythical Arduanatt", "CreateMythicalAduahnott()", 6, " \234\191\136\234\178\176 \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a Mythical Arduanatt. WARNING! You must not have a horse taken out to use this.", "\234\191\136\234\178\176 \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184\n\230\162\166\229\162\131\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185", " \234\191\136\234\178\176 \236\149\132\235\145\144\236\149\132\235\130\152\237\138\184 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\230\162\166\229\162\131\233\152\191\229\155\190\233\152\191\229\168\156\231\137\185\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(7, 1, "\234\191\136\234\178\176 \235\148\148\235\132\164\nMythical Dine", "CreateMythicalDine()", 6, "\234\191\136\234\178\176 \235\148\148\235\132\164 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a Mythical Dine. WARNING! You must not have a horse taken out to use this.", "\234\191\136\234\178\176 \235\148\148\235\132\164\n\230\162\166\229\162\131\232\191\170\229\134\133", "\234\191\136\234\178\176 \235\148\148\235\132\164 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\230\162\166\229\162\131\232\191\170\229\134\133\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(8, 1, "\234\191\136\234\178\176 \235\145\160\nMythical Doom", "CreateMythicalDoom()", 6, "\234\191\136\234\178\176 \235\145\160 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\nCreates a Mythical Doom. WARNING! You must not have a horse taken out to use this.", "\234\191\136\234\178\176 \235\145\160\n\230\162\166\229\162\131\230\157\156\229\167\134", "\234\191\136\234\178\176 \235\145\160 \236\131\157\236\132\177, \234\186\188\235\130\180\236\160\184 \236\158\136\235\138\148 \235\167\144\236\157\180 \236\151\134\236\157\132 \235\149\140 \236\130\172\236\154\169\237\149\180\236\149\188 \237\149\169\235\139\136\235\139\164.\n\231\148\159\230\136\144\230\162\166\229\162\131\230\157\156\229\167\134\239\188\140\230\178\161\230\156\137\229\183\178\229\143\150\229\135\186\231\154\132\233\169\172\231\154\132\231\138\182\230\128\129\228\184\139\228\189\191\231\148\168", true)
  CREATE_BUTTON(0, 2, "\236\164\145\235\178\148\236\132\160 \236\158\165\235\185\132\nCarrack Equip", "CreateCarrackEquip()", 6, "\236\164\145\235\178\148\236\132\160\236\154\169 \236\158\165\235\185\132 \236\131\157\236\132\177.\nCreates a Carrack.", "\236\164\145\235\178\148\236\132\160 \236\158\165\235\185\132\n\233\135\141\229\184\134\232\136\185\232\163\133\229\164\135", "\236\164\145\235\178\148\236\132\160\236\154\169 \236\158\165\235\185\132 \236\131\157\236\132\177.\n\231\148\159\230\136\144\233\135\141\229\184\134\232\136\185\228\184\147\231\148\168\232\163\133\229\164\135", true)
  CREATE_BUTTON(1, 2, "\237\140\144\236\152\165\236\132\160 \236\158\165\235\185\132\nPanokseon Equip", "CreatePanokseonEquip()", 6, "\237\140\144\236\152\165\236\132\160\236\154\169 \236\158\165\235\185\132 \236\131\157\236\132\177.\nCreates a Panokseon.", "\237\140\144\236\152\165\236\132\160 \236\158\165\235\185\132\n\230\157\191\229\177\139\232\136\185\232\163\133\229\164\135", "\237\140\144\236\152\165\236\132\160\236\154\169 \236\158\165\235\185\132 \236\131\157\236\132\177.\n\231\148\159\230\136\144\230\157\191\229\177\139\232\136\185\228\184\147\231\148\168\232\163\133\229\164\135", true)
  CREATE_BUTTON(2, 2, "\236\164\145\235\178\148\236\132\160 \236\160\144\236\167\132\nAdvance", "CreateCarrackAdvance()", 6, "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \236\160\144\236\167\132 \236\131\157\236\132\177.\nCreates a Carrack - Advance.", "\236\164\145\235\178\148\236\132\160 \236\160\144\236\167\132\n\233\135\141\229\184\134\232\136\185 - \230\184\144\232\191\155", "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \236\160\144\236\167\132 \236\131\157\236\132\177.\n\231\148\159\230\136\144\232\137\190\232\163\180\233\135\140\228\186\154\233\135\141\229\184\134\232\136\185 - \230\184\144\232\191\155", true)
  CREATE_BUTTON(3, 2, "\236\164\145\235\178\148\236\132\160 \234\183\160\237\152\149\nBalance", "CreateCarrackBalance()", 6, "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \234\183\160\237\152\149 \236\131\157\236\132\177.\nCreates a Carrack - Balance.", "\236\164\145\235\178\148\236\132\160 \234\183\160\237\152\149\n\233\135\141\229\184\134\232\136\185 - \229\185\179\232\161\161", "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \234\183\160\237\152\149 \236\131\157\236\132\177.\n\231\148\159\230\136\144\232\137\190\232\163\180\233\135\140\228\186\154\233\135\141\229\184\134\232\136\185 - \229\185\179\232\161\161", true)
  CREATE_BUTTON(4, 2, "\236\164\145\235\178\148\236\132\160 \236\154\169\235\167\185\nValor", "CreateCarrackValor()", 6, "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \236\154\169\235\167\185 \236\131\157\236\132\177.\nCreates a Carrack - Valor.", "\236\164\145\235\178\148\236\132\160 \236\154\169\235\167\185\n\233\135\141\229\184\134\232\136\185 - \229\157\135\232\161\161", "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \236\154\169\235\167\185 \236\131\157\236\132\177.\n\231\148\159\230\136\144\232\137\190\232\163\180\233\135\140\228\186\154\233\135\141\229\184\134\232\136\185 - \229\157\135\232\161\161", true)
  CREATE_BUTTON(5, 2, "\236\164\145\235\178\148\236\132\160 \235\185\132\236\131\129\nVolante", "CreateCarrackVolante()", 6, "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \235\185\132\236\131\129 \236\131\157\236\132\177.\nCreates a Carrack - Volante.", "\236\164\145\235\178\148\236\132\160 \235\185\132\236\131\129\n\233\135\141\229\184\134\232\136\185 - \233\163\158\231\191\148", "\236\151\144\237\142\152\235\166\172\236\149\132 \236\164\145\235\178\148\236\132\160 - \235\185\132\236\131\129 \236\131\157\236\132\177.\n\231\148\159\230\136\144\232\137\190\232\163\180\233\135\140\228\186\154\233\135\141\229\184\134\232\136\185 - \233\163\158\231\191\148", true)
  CREATE_BUTTON(6, 2, "\237\140\144\236\152\165\236\132\160\nPanokseon", "CreatePanokseon()", 6, "\237\140\144\236\152\165\236\132\160 \236\131\157\236\132\177.\nCreates a Panokseon.", "\237\140\144\236\152\165\236\132\160\n\230\157\191\229\177\139\232\136\185", "\237\140\144\236\152\165\236\132\160 \236\131\157\236\132\177.\n\230\157\191\229\177\139\232\136\185\231\148\159\230\136\144", true)
  CREATE_BUTTON(7, 2, "\234\177\176\237\149\168\nGalleon", "CreateGalleon()", 6, "\236\151\144\237\142\152\235\166\172\236\149\132 \234\177\176\237\149\168 \236\131\157\236\132\177.\nCreates a Galleon.", "\234\177\176\237\149\168\n\229\183\168\232\136\176", "\236\151\144\237\142\152\235\166\172\236\149\132 \234\177\176\237\149\168 \236\131\157\236\132\177.\n\232\137\190\232\163\180\233\135\140\228\186\154\229\183\168\232\136\176\231\148\159\230\136\144", true)
  CREATE_BUTTON(8, 2, "\234\184\184\235\147\156 \234\176\164\235\166\172\236\132\160\nGalley", "CreateGalleyLicense()", 6, "\234\184\184\235\147\156 \234\176\164\235\166\172\236\132\160 \234\180\128\235\160\168 \236\158\172\235\163\140 \236\131\157\236\132\177.\nCreates a Gally License.", "\234\184\184\235\147\156 \234\176\164\235\166\172\236\132\160\n\229\133\172\228\188\154\230\161\168\229\184\134\232\136\185", "\234\184\184\235\147\156 \234\176\164\235\166\172\236\132\160 \234\180\128\235\160\168 \236\158\172\235\163\140 \236\131\157\236\132\177.\n\231\148\159\230\136\144\229\133\172\228\188\154\230\161\168\229\184\134\232\136\185\231\155\184\229\133\179\230\157\144\230\150\153", true)
  CREATE_BUTTON(9, 2, "\236\132\160\235\176\149 \235\147\177\235\161\157\236\166\157\nShip License", "CreateShipLicense()", 6, "\236\157\188\235\182\128 \235\147\177\235\161\157\236\166\157 \236\131\157\236\132\177.\nCreates a Ship License.", "\236\132\160\235\176\149 \235\147\177\235\161\157\236\166\157\n\232\136\185\232\136\182\231\153\187\232\174\176\232\175\129", "\236\157\188\235\182\128 \235\147\177\235\161\157\236\166\157 \236\131\157\236\132\177.\n\231\148\159\230\136\144\233\131\168\229\136\134\231\153\187\232\174\176\232\175\129", true)
  CREATE_BUTTON(0, 3, "\236\132\160\236\176\169\236\158\165 \234\180\128\235\166\172\236\157\184 \236\134\140\237\153\152\nCreate Kruwa", "CreateKruwa()", 6, "\236\132\160\236\176\169\236\158\165 \234\180\128\235\166\172\236\157\184 \237\129\172\235\163\168\236\153\128 \236\134\140\237\153\152.\nSummon Kruwa.", "\236\132\160\236\176\169\236\158\165 \234\180\128\235\166\172\236\157\184 \236\134\140\237\153\152\n\229\143\172\229\148\164\229\133\172\228\188\154\231\160\129\229\164\180\231\174\161\231\144\134\232\128\133", "\236\132\160\236\176\169\236\158\165 \234\180\128\235\166\172\236\157\184 \237\129\172\235\163\168\236\153\128 \236\134\140\237\153\152.\n\229\143\172\229\148\164\229\133\172\228\188\154\231\160\129\229\164\180\231\174\161\231\144\134\232\128\133:\229\133\139\233\178\129\231\147\166", true)
  CREATE_BUTTON(1, 3, "\236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\136\168\234\178\176 \236\182\169\236\160\132\nOkiara", "WaterRunFull()", 6, "\236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\136\168\234\178\176 \234\178\140\236\157\180\236\167\128 \236\181\156\235\140\128.\nOkiara Guage Full", "\236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\136\168\234\178\176 \236\182\169\236\160\132\n\229\133\133\229\128\188\229\165\165\229\165\135\232\137\190\229\139\146\231\154\132\230\176\148\230\129\175", "\236\152\164\234\184\176\236\151\144\235\165\180\236\157\152 \236\136\168\234\178\176 \234\178\140\236\157\180\236\167\128 \236\181\156\235\140\128.\n\229\133\133\230\187\161\229\165\165\229\165\135\232\137\190\229\139\146\231\154\132\230\176\148\230\129\175\229\128\188", true)
end
function QASupport_AutomationPanel_CreateControl_Tab7()
  CREATE_BUTTON(0, 0, "\234\184\184\235\147\156 \236\160\145\236\134\141\236\157\184\236\155\144 \236\132\184\237\140\133\nGuild Meber", "GuildMemberSet()", 7, "/changeSiegeApplyNeedCount 1 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n/changeSiegeApplyNeedCount 1.", "\234\184\184\235\147\156 \236\160\145\236\134\141\236\157\184\236\155\144 \236\132\184\237\140\133\n\232\174\190\231\189\174\229\133\172\228\188\154\231\153\187\229\189\149\228\186\186\230\149\176", "/changeSiegeApplyNeedCount 1 \236\132\184\237\140\133\236\158\133\235\139\136\235\139\164.\n/changeSiegeApplyNeedCount 1 \232\174\190\231\189\174", true)
  CREATE_BUTTON(1, 0, "\234\184\184\235\147\156 \235\160\136\236\157\180\235\147\156 \236\132\184\237\140\133\nGuild Raid", "GuildRaidSummon()", 7, "\234\184\184\235\147\156 \235\160\136\236\157\180\235\147\156 \236\132\184\237\140\133.\nGuild Raid.", "\234\184\184\235\147\156 \235\160\136\236\157\180\235\147\156 \236\132\184\237\140\133\n\229\133\172\228\188\154\232\174\168\228\188\144\232\174\190\231\189\174", "\234\184\184\235\147\156 \235\160\136\236\157\180\235\147\156 \236\132\184\237\140\133.\n\229\133\172\228\188\154\232\174\168\228\188\144\232\174\190\231\189\174", true)
  CREATE_BUTTON(2, 0, "\236\151\176\235\167\185 \236\157\184\236\155\144 \236\161\176\236\160\136\nAlliance Member Count", "GuildAlliMember()", 7, "\234\184\184\235\147\156 \236\151\176\235\167\185 \236\157\184\236\155\144 \236\136\152 \236\181\156\235\140\128 2\235\170\133, \236\181\156\236\134\140 1\235\170\133\236\156\188\235\161\156 \236\161\176\236\160\136.\nGuild Alliance Member Count.", "\236\151\176\235\167\185 \236\157\184\236\155\144 \236\161\176\236\160\136\n\232\176\131\230\149\180\232\129\148\231\155\159\228\186\186\230\149\176", "\234\184\184\235\147\156 \236\151\176\235\167\185 \236\157\184\236\155\144 \236\136\152 \236\181\156\235\140\128 2\235\170\133, \236\181\156\236\134\140 1\235\170\133\236\156\188\235\161\156 \236\161\176\236\160\136.\n\229\133\172\228\188\154\232\129\148\231\155\159\228\186\186\230\149\176\232\176\131\230\149\180\228\184\186\230\156\128\229\164\1542\229\144\141\239\188\140\230\156\128\229\176\1451\229\144\141", true)
  CREATE_BUTTON(3, 0, "\234\184\184\235\147\156 \236\158\144\234\184\136 \236\182\148\234\176\128\nGuild funds", "GuildFundsQA()", 7, "\234\184\184\235\147\156 \236\158\144\234\184\136 10\236\150\181 \236\182\148\234\176\128.\n10 Billion Guild funds", "\234\184\184\235\147\156 \236\158\144\234\184\136 \236\182\148\234\176\128\n\230\183\187\229\138\160\229\133\172\228\188\154\232\181\132\233\135\145", "\234\184\184\235\147\156 \236\158\144\234\184\136 10\236\150\181 \236\182\148\234\176\128.\n\229\133\172\228\188\154\232\181\132\233\135\145\228\184\138\230\183\187\229\138\16010\228\186\191", true)
  CREATE_BUTTON(4, 0, "\234\184\184\235\147\156\236\138\164\237\130\172\236\191\168\237\131\128\236\158\132\236\180\136\234\184\176\237\153\148\nGuild Skill Cooltime", "GuildSkillCooltimeReset()", 7, "\234\184\184\235\147\156 \236\138\164\237\130\172 \236\191\168\237\131\128\236\158\132 \235\166\172\236\133\139\nGuild Skill Cooltime Reset", "\234\184\184\235\147\156\236\138\164\237\130\172\236\191\168\237\131\128\236\158\132\236\180\136\234\184\176\237\153\148\n\233\135\141\231\189\174\229\133\172\228\188\154\230\138\128\232\131\189CD", "\234\184\184\235\147\156 \236\138\164\237\130\172 \236\191\168\237\131\128\236\158\132 \235\166\172\236\133\139\n\233\135\141\231\189\174\229\133\172\228\188\154\230\138\128\232\131\189CD", true)
  CREATE_BUTTON(5, 0, "\234\184\184\235\147\156\237\128\152\236\138\164\237\138\184\235\170\169\235\161\157\235\179\128\234\178\189\nGuild Quest Refresh", "GuildQuestChange()", 7, "\234\184\184\235\147\156 \237\128\152\236\138\164\237\138\184 \235\170\169\235\161\157 \235\179\128\234\178\189\nGuild Quest Refresh", "\234\184\184\235\147\156\237\128\152\236\138\164\237\138\184\235\170\169\235\161\157\235\179\128\234\178\189\n\229\143\152\230\155\180\229\133\172\228\188\154\228\187\187\229\138\161\231\155\174\229\189\149", "\234\184\184\235\147\156 \237\128\152\236\138\164\237\138\184 \235\170\169\235\161\157 \235\179\128\234\178\189\n\229\143\152\230\155\180\229\133\172\228\188\154\228\187\187\229\138\161\231\155\174\229\189\149", true)
  CREATE_BUTTON(6, 0, "\234\184\184\235\147\156\237\128\152\236\138\164\237\138\184\236\157\184\236\155\144\235\179\128\234\178\189\nGuild Quest Member", "GuildQuestMeberCountQA()", 7, "\234\184\184\235\147\156 \237\128\152\236\138\164\237\138\184 \236\136\152\235\157\189 \236\157\184\236\155\144 \236\136\152 \235\179\128\234\178\189\nGuild Quest Member Change", "\234\184\184\235\147\156\237\128\152\236\138\164\237\138\184\236\157\184\236\155\144\235\179\128\234\178\189\n\229\143\152\230\155\180\229\133\172\228\188\154\228\187\187\229\138\161\228\186\186\230\149\176", "\234\184\184\235\147\156 \237\128\152\236\138\164\237\138\184 \236\136\152\235\157\189 \236\157\184\236\155\144 \236\136\152 \235\179\128\234\178\189\n\229\143\152\230\155\180\230\142\165\229\143\151\229\133\172\228\188\154\228\187\187\229\138\161\228\186\186\230\149\176", true)
  CREATE_BUTTON(7, 0, "\235\176\156\235\160\136\235\133\184\236\138\164 \236\139\160\236\178\173\nApply For Balenos", "ApplyBalenosQA()", 7, "\235\176\156\235\160\136\235\133\184\236\138\164 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Balenos", "\235\176\156\235\160\136\235\133\184\236\138\164 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\183\180\233\155\183\232\175\186\230\150\175", "\235\176\156\235\160\136\235\133\184\236\138\164 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\183\180\233\155\183\232\175\186\230\150\175\233\162\134\229\156\176", true)
  CREATE_BUTTON(8, 0, "\236\132\184\235\160\140\235\148\148\236\149\132 \236\139\160\236\178\173\nApply For Serendia", "ApplySerendiaQA()", 7, "\236\132\184\235\160\140\235\148\148\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Serendia", "\236\132\184\235\160\140\235\148\148\236\149\132 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\161\158\230\158\151\232\191\170\228\186\154", "\236\132\184\235\160\140\235\148\148\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\161\158\230\158\151\232\191\170\228\186\154\233\162\134\229\156\176", true)
  CREATE_BUTTON(9, 0, "\236\185\188\237\142\152\236\152\168 \236\139\160\236\178\173\nApply For Calpheon", "ApplyCalpheonQA()", 7, "\236\185\188\237\142\152\236\152\168 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Calpheon", "\236\185\188\237\142\152\236\152\168 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\141\161\229\176\148\228\189\169\230\129\169", "\236\185\188\237\142\152\236\152\168 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\141\161\229\176\148\228\189\169\230\129\169\233\162\134\229\156\176", true)
  CREATE_BUTTON(10, 0, "\235\169\148\235\148\148\236\149\132 \236\139\160\236\178\173\nApply For Media", "ApplyMediaQA()", 7, "\235\169\148\235\148\148\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Media", "\235\169\148\235\148\148\236\149\132 \236\139\160\236\178\173\n\231\148\179\232\175\183\230\162\133\232\191\170\228\186\154", "\235\169\148\235\148\148\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\230\162\133\232\191\170\228\186\154\233\162\134\229\156\176", true)
  CREATE_BUTTON(11, 0, "\235\176\156\235\160\140\236\139\156\236\149\132 \236\139\160\236\178\173\nApply For Valencia", "ApplyValenciaQA()", 7, "\235\176\156\235\160\140\236\139\156\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Valencia", "\235\176\156\235\160\140\236\139\156\236\149\132 \236\139\160\236\178\173\n\231\148\179\232\175\183\231\147\166\228\188\166\232\165\191\228\186\154", "\235\176\156\235\160\140\236\139\156\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\231\147\166\228\188\166\232\165\191\228\186\154\233\162\134\229\156\176", true)
  CREATE_BUTTON(12, 0, "\236\185\180\235\167\136\236\139\164\235\185\132\236\149\132 \236\139\160\236\178\173\nApply For Kamasylvia", "ApplyKamasylviaQA()", 7, "\236\185\180\235\167\136\236\139\164\235\185\132\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\nApply For Kamasylvia", "\236\185\180\235\167\136\236\139\164\235\185\132\236\149\132 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\141\161\231\142\155\229\184\140\230\175\148\228\186\154", "\236\185\180\235\167\136\236\139\164\235\185\132\236\149\132 \236\152\129\236\167\128 \236\139\160\236\178\173\n\231\148\179\232\175\183\229\141\161\231\142\155\229\184\140\230\175\148\228\186\154\233\162\134\229\156\176", true)
  CREATE_BUTTON(0, 1, "\234\177\176\236\160\144\234\179\181\236\132\177\236\132\177\236\177\132 \236\131\157\236\132\177\nNode/Conq Fort", "siegeready1()", 7, "\234\177\176\236\160\144/\236\160\144\235\160\185\236\160\132 \236\154\169 \236\132\177\236\177\132\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164\nCreates a node/conquest war fort.", "\234\177\176\236\160\144\234\179\181\236\132\177\236\132\177\236\177\132 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\141\174\231\130\185\230\148\187\229\159\142\232\166\129\229\161\158", "\234\177\176\236\160\144/\236\160\144\235\160\185\236\160\132 \236\154\169 \236\132\177\236\177\132\235\165\188 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164\n\231\148\159\230\136\144\230\141\174\231\130\185/\229\141\160\233\162\134\230\136\152\228\184\147\231\148\168\232\166\129\229\161\158", true)
  CREATE_BUTTON(1, 1, "\234\177\176\236\160\144\234\179\181\236\132\177\235\182\128\236\134\141 \236\131\157\236\132\177\nNode/Conq Annex", "siegeready2()", 7, "\234\177\176\236\160\144/\236\160\144\235\160\185\236\160\132 \236\154\169 \235\182\128\236\134\141 \236\149\132\236\157\180\237\133\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164\nCreates node/conquest war annexes.", "\234\177\176\236\160\144\234\179\181\236\132\177\235\182\128\236\134\141 \236\131\157\236\132\177\n\231\148\159\230\136\144\230\141\174\231\130\185\230\148\187\229\159\142\233\153\132\229\177\158", "\234\177\176\236\160\144/\236\160\144\235\160\185\236\160\132 \236\154\169 \235\182\128\236\134\141 \236\149\132\236\157\180\237\133\156\236\157\132 \236\131\157\236\132\177\237\149\169\235\139\136\235\139\164\n\231\148\159\230\136\144\230\141\174\231\130\185/\229\141\160\233\162\134\230\136\152\228\184\147\231\148\168\233\153\132\229\177\158\229\187\186\231\137\169", true)
  CREATE_BUTTON(2, 1, "\237\152\132\236\158\172 \234\179\181\236\132\177 \236\167\128\236\151\173\nCurrent Siege", "CheckSiegeTerritory()", 7, "\237\152\132\236\158\172 \236\132\156\235\178\132\236\157\152 \234\179\181\236\132\177\236\167\128\236\151\173 \237\153\149\236\157\184\nChecks the Siege region on the current server.", "\237\152\132\236\158\172 \234\179\181\236\132\177 \236\167\128\236\151\173\n\231\155\174\229\137\141\230\148\187\229\159\142\229\156\176\229\140\186", "\237\152\132\236\158\172 \236\132\156\235\178\132\236\157\152 \234\179\181\236\132\177\236\167\128\236\151\173 \237\153\149\236\157\184\n\230\159\165\231\156\139\231\155\174\229\137\141\230\156\141\229\138\161\229\140\186\231\154\132\230\148\187\229\159\142\229\156\176\229\140\186", true)
  CREATE_BUTTON(3, 1, "\234\177\176\236\160\144\236\160\132 \237\142\152\236\157\180\235\176\177\nJoin Count Reset", "JoinSiegeCountReset()", 7, "\235\170\168\235\147\160 \234\184\184\235\147\156 \234\177\176\236\160\144\236\160\132 \236\176\184\236\151\172\234\184\176\237\154\140 \236\180\136\234\184\176\237\153\148\nAll Guild Join Siege Count Reset", "\234\177\176\236\160\144\236\160\132 \237\142\152\236\157\180\235\176\177\n\233\135\141\231\189\174\230\141\174\231\130\185\230\136\152\229\143\130\228\184\142\230\156\186\228\188\154", "\235\170\168\235\147\160 \234\184\184\235\147\156 \234\177\176\236\160\144\236\160\132 \236\176\184\236\151\172\234\184\176\237\154\140 \236\180\136\234\184\176\237\153\148\n\233\135\141\231\189\174\230\137\128\230\156\137\229\133\172\228\188\154\231\154\132\230\141\174\231\130\185\230\136\152\229\143\130\228\184\142\230\156\186\228\188\154", true)
  CREATE_BUTTON(4, 1, "\234\177\176\236\160\144\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\nStart Siege 1", "StratSiege1()", 7, "\234\177\176\236\160\144\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\nStart Siege 1", "\234\177\176\236\160\144\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\n\230\141\174\231\130\185\230\136\152\229\188\186\229\136\182\229\188\128\229\167\139", "\234\177\176\236\160\144\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\n\230\141\174\231\130\185\230\136\152\229\188\186\229\136\182\229\188\128\229\167\139", true)
  CREATE_BUTTON(5, 1, "\234\179\181\236\132\177\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\nStart Siege 0", "StratSiege0()", 7, "\234\179\181\236\132\177\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\nStart Siege 0", "\234\179\181\236\132\177\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\n\230\148\187\229\159\142\230\136\152\229\188\186\229\136\182\229\188\128\229\167\139", "\234\179\181\236\132\177\236\160\132 \234\176\149\236\160\156 \236\139\156\236\158\145\n\230\148\187\229\159\142\230\136\152\229\188\186\229\136\182\229\188\128\229\167\139", true)
  CREATE_BUTTON(6, 1, "\236\160\144\235\160\185\236\160\132 \236\132\177\236\177\132 \236\153\132\236\132\177\nCommand Post Building", "ConquestWarBuildingQA()", 7, "\236\160\144\235\160\185\236\160\132 \236\132\177\236\177\132 \236\153\132\236\132\177\nCommand Post Building", "\236\160\144\235\160\185\236\160\132 \236\132\177\236\177\132 \236\153\132\236\132\177\n\229\141\160\233\162\134\230\136\152\232\166\129\229\161\158\229\174\140\230\136\144", "\236\160\144\235\160\185\236\160\132 \236\132\177\236\177\132 \236\153\132\236\132\177\n\229\141\160\233\162\134\230\136\152\232\166\129\229\161\158\229\174\140\230\136\144", true)
  CREATE_BUTTON(7, 1, "\235\170\168\235\147\160 \236\152\129\236\167\128 \236\139\160\236\178\173 \236\160\156\234\177\176\nClear Apply", "ClearApplySiegeTerritoryQA()", 7, "\235\170\168\235\147\160 \236\152\129\236\167\128 \236\139\160\236\178\173 \236\160\156\234\177\176\nClear Apply", "\235\170\168\235\147\160 \236\152\129\236\167\128 \236\139\160\236\178\173 \236\160\156\234\177\176\n\230\137\128\230\156\137\233\162\134\229\156\176\232\167\163\233\153\164\231\148\179\232\175\183", "\235\170\168\235\147\160 \236\152\129\236\167\128 \236\139\160\236\178\173 \236\160\156\234\177\176\n\230\137\128\230\156\137\233\162\134\229\156\176\232\167\163\233\153\164\231\148\179\232\175\183", true)
  CREATE_BUTTON(0, 2, "\236\185\188\237\142\152\236\152\168 \236\132\177 \236\157\180\235\143\153\nCalpheon Castle", "TeleportCalpheonCastle()", 7, "\236\185\188\237\142\152\236\152\168 \236\132\177 \236\157\180\235\143\153\nTeleports you to Calpheon Castle.", "\236\185\188\237\142\152\236\152\168 \236\132\177 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\229\176\148\228\189\169\230\129\169\229\159\142", "\236\185\188\237\142\152\236\152\168 \236\132\177 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\141\161\229\176\148\228\189\169\230\129\169\229\159\142", true)
  CREATE_BUTTON(1, 2, "\235\176\156\235\160\140\236\139\156\236\149\132 \236\132\177 \236\157\180\235\143\153\nValencia Castle", "TeleportValenciaCastle()", 7, "\235\176\156\235\160\140\236\139\156\236\149\132 \236\132\177 \236\157\180\235\143\153\nTeleports you to Valencia Castle.", "\235\176\156\235\160\140\236\139\156\236\149\132 \236\132\177 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\147\166\228\188\166\232\165\191\228\186\154\229\159\142", "\235\176\156\235\160\140\236\139\156\236\149\132 \236\132\177 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\147\166\228\188\166\232\165\191\228\186\154\229\159\142", true)
  CREATE_BUTTON(0, 3, "\236\158\165\235\175\184\236\160\132\236\159\129 \237\131\128\236\157\180\235\168\184\236\160\156\234\177\176\nRoseWar Point", "RoseWarPointQA()", 7, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\176\184\236\151\172 \236\160\144\236\136\152 \236\132\184\237\140\133\nRoseWar Point Setting", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\160\144\236\136\152 \236\132\184\237\140\133\n\232\174\190\231\189\174\231\142\171\231\145\176\230\136\152\228\186\137\231\130\185\230\149\176", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\176\184\236\151\172 \236\160\144\236\136\152 \236\132\184\237\140\133\n\232\174\190\231\189\174\231\142\171\231\145\176\230\136\152\228\186\137\229\143\130\228\184\142\231\130\185\230\149\176", true)
  CREATE_BUTTON(1, 3, "\236\158\165\235\175\184\236\160\132\236\159\129 \234\184\184\235\147\156\236\139\156\236\158\145\235\139\168\234\179\132 \nRoseWar Point", "RoseWarStartQA1()", 7, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\176\184\236\151\172 \236\160\144\236\136\152 \236\132\184\237\140\133\nRoseWar Point Setting", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\160\144\236\136\152 \236\132\184\237\140\133\n\232\174\190\231\189\174\231\142\171\231\145\176\230\136\152\228\186\137\231\130\185\230\149\176", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\176\184\236\151\172 \236\160\144\236\136\152 \236\132\184\237\140\133\n\232\174\190\231\189\174\231\142\171\231\145\176\230\136\152\228\186\137\229\143\130\228\184\142\231\130\185\230\149\176", true)
  CREATE_BUTTON(2, 3, "\236\158\165\235\175\184\236\160\132\236\159\129 \234\184\184\235\147\156\236\176\184\234\176\128\nRoseWar Start", "RoseWarStartQA2()", 7, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132 \236\132\184\237\140\133\nRoseWar Start Setting", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132\n\231\142\171\231\145\176\230\136\152\228\186\137\229\188\128\229\167\139\233\152\182\230\174\181", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132 \236\132\184\237\140\133\n\231\142\171\231\145\176\230\136\152\228\186\137\229\188\128\229\167\139\233\152\182\230\174\181\232\174\190\231\189\174", true)
  CREATE_BUTTON(3, 3, "\236\158\165\235\175\184\236\160\132\236\159\129 \235\139\168\234\179\132\236\167\132\237\150\137\nRoseWar Start", "RoseWarStartQA3()", 7, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132 \236\132\184\237\140\133\nRoseWar Start Setting", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132\n\231\142\171\231\145\176\230\136\152\228\186\137\229\188\128\229\167\139\233\152\182\230\174\181", "\236\158\165\235\175\184\236\160\132\236\159\129 \236\139\156\236\158\145 \235\139\168\234\179\132 \236\132\184\237\140\133\n\231\142\171\231\145\176\230\136\152\228\186\137\229\188\128\229\167\139\233\152\182\230\174\181\232\174\190\231\189\174", true)
  CREATE_BUTTON(8, 3, "\234\184\184\235\147\156\235\166\172\234\183\184 \234\178\128\236\166\157 \237\149\180\236\160\156\nGuildLeague QAMode", "GuildQAModeQA()", 7, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \234\178\128\236\166\157 \237\149\180\236\160\156\nGuild League Matching Verification Off", "\234\184\184\235\147\156\235\166\172\234\183\184 \234\178\128\236\166\157 \237\149\180\236\160\156\n\232\167\163\233\153\164\229\133\172\228\188\154\232\129\148\232\181\155\233\170\140\232\175\129", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \234\178\128\236\166\157 \237\149\180\236\160\156\n\232\167\163\233\153\164\229\133\172\228\188\154\232\129\148\232\181\155\233\170\140\232\175\129", true)
  CREATE_BUTTON(9, 3, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\139\156\234\176\132\nGuildLeague Matching", "GuildLeagueMatchingTimeQA()", 7, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\139\156\234\176\132 30\236\180\136\235\161\156 \236\161\176\236\160\136\nGuild League MatchingTime 30s", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\139\156\234\176\132\n\229\133\172\228\188\154\232\129\148\232\181\155\229\140\185\233\133\141\230\151\182\233\151\180", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\139\156\234\176\132 30\236\180\136\235\161\156 \236\161\176\236\160\136\n\229\133\172\228\188\154\232\129\148\232\181\155\229\140\185\233\133\141\230\151\182\233\151\180\232\176\131\230\149\180\228\184\18630\231\167\146", true)
  CREATE_BUTTON(10, 3, "\234\184\184\235\147\156\235\166\172\234\183\184 \236\157\184\236\155\144 \236\132\184\237\140\133\nGuildLeague Count", "GuildLeagueCountQA()", 7, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\157\184\236\155\144 \236\161\176\236\160\149\nGuild League Matching Count 1", "\234\184\184\235\147\156\235\166\172\234\183\184 \236\157\184\236\155\144 \236\132\184\237\140\133\n\232\174\190\231\189\174\229\133\172\228\188\154\232\129\148\232\181\155\228\186\186\230\149\176", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\167\164\236\185\173 \236\157\184\236\155\144 \236\161\176\236\160\149\n\232\176\131\230\149\180\229\133\172\228\188\154\232\129\148\232\181\155\229\140\185\233\133\141\228\186\186\230\149\176", true)
  CREATE_BUTTON(11, 3, "\234\184\184\235\147\156\235\166\172\234\183\184 \236\160\149\236\131\129 \236\162\133\235\163\140\nGuildLeague State ", "GuildLeagueStateQA()", 7, "\234\184\184\235\147\156\235\166\172\234\183\184 \236\167\132\237\150\137 \236\131\129\237\131\156 \235\179\128\234\178\189\nGuild League State Change", "\234\184\184\235\147\156\235\166\172\234\183\184 \236\160\149\236\131\129 \236\162\133\235\163\140\n\229\133\172\228\188\154\232\129\148\232\181\155\230\173\163\229\184\184\231\187\147\230\157\159 ", "\234\184\184\235\147\156\235\166\172\234\183\184 \236\167\132\237\150\137 \236\131\129\237\131\156 \235\179\128\234\178\189\n\229\143\152\230\155\180\229\133\172\228\188\154\232\129\148\232\181\155\232\191\155\232\161\140\231\138\182\230\128\129", true)
  CREATE_BUTTON(12, 3, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\176\169 \236\160\149\235\179\180\nGuildLeague Roominfo", "GuildLeagueRoomInfoQA()", 7, "\234\184\184\235\147\156\235\166\172\234\183\184 \235\176\169 \236\160\149\235\179\180 \237\153\149\236\157\184\nGuild League Room Info", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\176\169 \236\160\149\235\179\180\n\229\133\172\228\188\154\232\129\148\232\181\155\230\136\191\233\151\180\228\191\161\230\129\175", "\234\184\184\235\147\156\235\166\172\234\183\184 \235\176\169 \236\160\149\235\179\180 \237\153\149\236\157\184\n\231\161\174\232\174\164\229\133\172\228\188\154\230\136\191\233\151\180\228\191\161\230\129\175", true)
end
function QASupport_AutomationPanel_CreateControl_Tab8()
  CREATE_BUTTON(0, 0, "\235\140\128\237\152\149 \237\149\180\236\153\149\235\165\152 \234\181\176\235\157\189\236\167\128\nSea Mon. Habitat", "TeleportSeaMonster()", 8, "\235\140\128\237\152\149 \237\149\180\236\153\149\235\165\152 \234\181\176\235\157\189\236\167\128\235\161\156 \236\157\180\235\143\153\nTeleports you to Sea Monster Habitat.", "\235\140\128\237\152\149 \237\149\180\236\153\149\235\165\152 \234\181\176\235\157\189\236\167\128\n\229\164\167\229\158\139\230\181\183\231\142\139\231\177\187\229\183\162\231\169\180", "\235\140\128\237\152\149 \237\149\180\236\153\149\235\165\152 \234\181\176\235\157\189\236\167\128\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\164\167\229\158\139\230\181\183\231\142\139\231\177\187\229\183\162\231\169\180", true)
  CREATE_BUTTON(1, 0, "\235\140\128\236\150\145 \237\149\168\235\140\128\nSea Fleet", "TeleportSeaFleet()", 8, "\235\140\128\236\150\145 \237\149\168\235\140\128 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to Sea Fleet Spawn Area.", "\235\140\128\236\150\145 \237\149\168\235\140\128\n\229\164\167\230\180\139\232\136\176\233\152\159", "\235\140\128\236\150\145 \237\149\168\235\140\128 \236\138\164\237\143\176 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\229\164\167\230\180\139\232\136\176\233\152\159\231\148\159\230\136\144\229\140\186", true)
  CREATE_BUTTON(0, 1, "\235\167\136\234\179\160\235\166\172\236\149\132 \235\182\129\235\182\128\nMagoria North", "TeleportNorthMagoria()", 8, "\235\167\136\234\179\160\235\166\172\236\149\132 \235\182\129\235\182\128\236\167\128\236\151\173 (\236\156\160\235\165\180 \237\149\180\236\151\173 \235\130\168\236\170\189) \236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to northern  Magoria. (South of Juur Sea).", "\235\167\136\234\179\160\235\166\172\236\149\132 \235\182\129\235\182\128\n\231\142\155\230\160\188\233\135\140\228\186\154\229\140\151\229\140\186", "\235\167\136\234\179\160\235\166\172\236\149\132 \235\182\129\235\182\128\236\167\128\236\151\173 (\236\156\160\235\165\180 \237\149\180\236\151\173 \235\130\168\236\170\189) \236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\142\155\230\160\188\233\135\140\228\186\154\229\140\151\233\131\168\229\156\176\229\140\186(\228\189\145\232\183\175\230\181\183\229\159\159\229\141\151\229\140\186)", true)
  CREATE_BUTTON(0, 2, "\235\167\136\234\179\160\235\166\172\236\149\132 \236\164\145\236\149\153\nMagoria Center", "TeleportMiddleMagoria()", 8, "\235\167\136\234\179\160\235\166\172\236\149\132 \236\164\145\236\149\153 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to the center of Magoria.", "\235\167\136\234\179\160\235\166\172\236\149\132 \236\164\145\236\149\153\n\232\135\179\231\142\155\230\160\188\233\135\140\228\186\154\228\184\173\229\164\174", "\235\167\136\234\179\160\235\166\172\236\149\132 \236\164\145\236\149\153 \236\167\128\236\151\173\236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\142\155\230\160\188\233\135\140\228\186\154\228\184\173\229\164\174\229\156\176\229\140\186", true)
  CREATE_BUTTON(0, 3, "\235\167\136\234\179\160\235\166\172\236\149\132 \235\130\168\235\182\128\nMagoria South", "TeleportSouthMagoria()", 8, "\235\167\136\234\179\160\235\166\172\236\149\132 \235\130\168\235\182\128\236\167\128\236\151\173 (\235\161\156\236\138\164 \237\149\180\236\151\173 \235\182\129\236\170\189) \236\156\188\235\161\156 \236\157\180\235\143\153\nTeleports you to southern Magoria. (North of Ross Sea)", "\235\167\136\234\179\160\235\166\172\236\149\132 \235\130\168\235\182\128\n\232\135\179\231\142\155\230\160\188\233\135\140\228\186\154\229\141\151\229\140\186", "\235\167\136\234\179\160\235\166\172\236\149\132 \235\130\168\235\182\128\236\167\128\236\151\173 (\235\161\156\236\138\164 \237\149\180\236\151\173 \235\182\129\236\170\189) \236\156\188\235\161\156 \236\157\180\235\143\153\n\231\167\187\229\138\168\232\135\179\231\142\155\230\160\188\233\135\140\228\186\154\229\141\151\233\131\168\229\156\176\229\140\186 (\230\180\155\230\150\175\230\181\183\229\159\159\229\140\151\229\140\186)", true)
end
function QASupport_AutomationPanel_CreateControl_Tab9()
  CREATE_BUTTON(0, 0, "\235\141\176\235\175\184\236\167\128 \237\145\156\234\184\176\nDmg Meter", "DmgMeterQA()", 9, "\235\141\176\235\175\184\236\167\128 \237\145\156\234\184\176\nDmg Meter.", "\235\141\176\235\175\184\236\167\128 \237\145\156\234\184\176\n\230\160\135\232\174\176\228\188\164\229\174\179\233\135\143", "\235\141\176\235\175\184\236\167\128 \237\145\156\234\184\176\n\230\160\135\232\174\176\228\188\164\229\174\179\233\135\143", true)
  CREATE_BUTTON(1, 0, [[
CC Test
CC Test]], "CCtsetQA()", 9, "CC \237\133\140\236\138\164\237\138\184\nCC Test.", [[
CC Test
CC Test]], "CC \237\133\140\236\138\164\237\138\184\nCC \230\181\139\232\175\149", true)
  CREATE_BUTTON(2, 0, "\236\160\128\237\149\173 \235\161\156\234\183\184\nDebug Immune", "DebugImmuneQA()", 9, "\236\160\128\237\149\173 \235\161\156\234\183\184\nDebug Immune Log", "\236\160\128\237\149\173 \235\161\156\234\183\184\n\230\138\181\230\138\151\230\151\165\229\191\151", "\236\160\128\237\149\173 \235\161\156\234\183\184\n\230\138\181\230\138\151\230\151\165\229\191\151", true)
  CREATE_BUTTON(3, 0, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \236\188\156\234\184\176\nDmg Log On", "DmgLogOnQA()", 9, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \236\188\156\234\184\176\nDmg Log On", "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \236\188\156\234\184\176\n\230\137\147\229\188\128\228\188\164\229\174\179\233\135\143\230\151\165\229\191\151", "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \236\188\156\234\184\176\n\230\137\147\229\188\128\228\188\164\229\174\179\233\135\143\230\151\165\229\191\151", true)
  CREATE_BUTTON(4, 0, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \235\129\132\234\184\176\nDmg Log Off", "DmgLogOffQA()", 9, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \235\129\132\234\184\176\nDmg Log Off", "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \235\129\132\234\184\176\n\229\133\179\233\151\173\228\188\164\229\174\179\233\135\143\230\151\165\229\191\151", "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \235\129\132\234\184\176\n\229\133\179\233\151\173\228\188\164\229\174\179\233\135\143\230\151\165\229\191\151", true)
  CREATE_BUTTON(5, 0, "\236\154\180\236\152\129\236\158\144 \236\134\141\236\152\183\nGM Underwear", "GMUnderwearQA()", 9, "\236\154\180\236\152\129\236\158\144 \236\134\141\236\152\183\nGM Underwear", "\236\154\180\236\152\129\236\158\144 \236\134\141\236\152\183\nGM\229\134\133\232\161\163", "\236\154\180\236\152\129\236\158\144 \236\134\141\236\152\183\nGM\229\134\133\232\161\163", true)
  CREATE_BUTTON(0, 1, "\236\134\141\235\143\132 50% \234\176\144\236\134\140\nSpeed Reduction By 50%", "SpeedReductionQA()", 9, "\236\134\141\235\143\132 50% \234\176\144\236\134\140\nSpeed Reduction By 50%", "\236\134\141\235\143\132 50% \234\176\144\236\134\140\n\233\128\159\229\186\166\229\135\143\229\176\14550%", "\236\134\141\235\143\132 50% \234\176\144\236\134\140\n\233\128\159\229\186\166\229\135\143\229\176\14550%", true)
  CREATE_BUTTON(1, 1, "\234\184\176\236\160\136\nStun", "StunQA()", 9, "\234\184\176\236\160\136\nStun", "\234\184\176\236\160\136\n\230\152\143\229\142\165", "\234\184\176\236\160\136\n\230\152\143\229\142\165", true)
  CREATE_BUTTON(2, 1, "\235\176\148\236\154\180\235\147\156\nBound", "BoundQA()", 9, "\235\176\148\236\154\180\235\147\156\nBound", "\235\176\148\236\154\180\235\147\156\n\229\143\141\229\188\185", "\235\176\148\236\154\180\235\147\156\n\229\143\141\229\188\185", true)
  CREATE_BUTTON(3, 1, "\234\178\189\236\167\129\nStiffness", "StiffnessQA()", 9, "\234\178\189\236\167\129\nStiffness", "\234\178\189\236\167\129\n\229\131\181\231\161\172", "\234\178\189\236\167\129\n\229\131\181\231\161\172", true)
  CREATE_BUTTON(4, 1, "\235\132\137\235\139\164\236\154\180\nKnockdown", "KnockdownQA()", 9, "\235\132\137\235\139\164\236\154\180\nKnockdown", "\235\132\137\235\139\164\236\154\180\n\229\135\187\229\128\146", "\235\132\137\235\139\164\236\154\180\n\229\135\187\229\128\146", true)
  CREATE_BUTTON(5, 1, "\235\185\153\234\178\176\nFreezing", "FreezingQA()", 9, "\235\185\153\234\178\176\nFreezing", "\235\185\153\234\178\176\n\229\134\187\231\187\147", "\235\185\153\234\178\176\n\229\134\187\231\187\147", true)
  CREATE_BUTTON(6, 1, "\235\157\132\236\154\176\234\184\176\nFloating", "FloatingQA()", 9, "\235\157\132\236\154\176\234\184\176\nFloating", "\235\157\132\236\154\176\234\184\176\n\229\135\187\233\163\158", "\235\157\132\236\154\176\234\184\176\n\229\135\187\233\163\158", true)
  CREATE_BUTTON(7, 1, "\235\132\137\235\176\177\nKnockback", "KnockbackQA()", 9, "\235\132\137\235\176\177\nKnockback", "\235\132\137\235\176\177\n\229\135\187\233\128\128", "\235\132\137\235\176\177\n\229\135\187\233\128\128", true)
  CREATE_BUTTON(8, 1, "\235\170\168\235\147\160 \236\160\128\237\149\173 +30%\nAll Resistance +30%", "AllResistanceQA()", 9, "\235\170\168\235\147\160 \236\160\128\237\149\173 +30%\nAll Resistance +30%", "\235\170\168\235\147\160 \236\160\128\237\149\173 +30%\n\230\137\128\230\156\137\230\138\181\230\138\151 +30%", "\235\170\168\235\147\160 \236\160\128\237\149\173 +30%\n\230\137\128\230\156\137\230\138\181\230\138\151 +30%", true)
  CREATE_BUTTON(9, 1, "\236\160\128\237\149\173 \235\172\180\236\139\156 +30%\nIgnore All Resistance +30%", "IgnoreAllResistanceQA()", 9, "\235\170\168\235\147\160 \236\160\128\237\149\173 \235\172\180\236\139\156 +30%\nIgnore All Resistance +30%", "\236\160\128\237\149\173 \235\172\180\236\139\156 +30%\n\230\151\160\232\167\134\230\138\181\230\138\151 +30%", "\235\170\168\235\147\160 \236\160\128\237\149\173 \235\172\180\236\139\156 +30%\n\230\151\160\232\167\134\230\137\128\230\156\137\230\138\181\230\138\151 +30%", true)
  CREATE_BUTTON(0, 2, "999 \237\151\136\236\136\152\236\149\132\235\185\132\ncreate 999", "Create999QA()", 9, "999 \237\151\136\236\136\152\236\149\132\235\185\132 \236\134\140\237\153\152\n999 Scarecrow Summon", "999 \237\151\136\236\136\152\236\149\132\235\185\132\n999 \231\168\187\232\141\137\228\186\186", "999 \237\151\136\236\136\152\236\149\132\235\185\132 \236\134\140\237\153\152\n\229\143\172\229\148\164999\231\168\187\232\141\137\228\186\186", true)
  CREATE_BUTTON(1, 2, "993 \237\151\136\236\136\152\236\149\132\235\185\132\ncreate 993", "Create993QA()", 9, "993 \237\151\136\236\136\152\236\149\132\235\185\132 \236\134\140\237\153\152\n993 Scarecrow Summon", "999 \237\151\136\236\136\152\236\149\132\235\185\132\n993 \231\168\187\232\141\137\228\186\186", "993 \237\151\136\236\136\152\236\149\132\235\185\132 \236\134\140\237\153\152\n\229\143\172\229\148\164993\231\168\187\232\141\137\228\186\186", true)
  CREATE_BUTTON(0, 3, "\237\140\140\237\145\184\236\149\132\237\129\172\235\166\172\235\139\136\235\161\156 \236\157\180\235\143\153\nTeleport Papua Crinea", "TPPapuaCrinea()", 9, "\237\140\140\237\145\184\236\149\132\237\129\172\235\166\172\235\139\136\235\161\156 \236\157\180\235\143\153\237\149\169\235\139\136\235\139\164.\nTeleport to Papua Crinea", "\237\140\140\237\145\184\236\149\132\237\129\172\235\166\172\235\139\136\235\161\156 \236\157\180\235\143\153\n\229\184\149\230\153\174\233\152\191\229\133\139\230\139\137\229\176\188\231\167\187\229\138\168", "\237\140\140\237\145\184\236\149\132\237\129\172\235\166\172\235\139\136\235\161\156 \236\157\180\235\143\153\237\149\169\235\139\136\235\139\164.\n\231\167\187\229\138\168\229\136\176\229\184\149\230\153\174\233\152\191\229\133\139\230\139\137\229\176\188", true)
  CREATE_BUTTON(12, 3, [[
QA PVP Test
QA PVP Test]], "qa_pvptest()", 9, [[
QA PVP Test
QA PVP Test]], [[
QA PVP Test
QA PVP Test]], [[
QA PVP Test
QA PVP Test]], true)
end
function TeleportVelia1()
  ToClient_qaTeleport(7469, -7815, 83716)
end
function TeleportVelia2()
  ToClient_qaTeleport(24271, -6276, 73371)
end
function TeleportHeidel1()
  ToClient_qaTeleport(37144, -2970, -45723)
end
function TeleportHeidel2()
  ToClient_qaTeleport(48114, 504, -23702)
end
function TeleportCalpheon1()
  ToClient_qaTeleport(-255487, -2714, -38003)
end
function TeleportCalpheon2()
  ToClient_qaTeleport(-265580, -1054, -63041)
end
function TeleportAltinova1()
  ToClient_qaTeleport(364090, -4955, -74319)
end
function TeleportValencia1()
  ToClient_qaTeleport(1032889, 11015, 191611)
end
function TeleportGrana1()
  ToClient_qaTeleport(-513551, 8993, -455350)
end
function TeleportDuvencrune1()
  ToClient_qaTeleport(-48357, 21828, -404589)
end
function TeleportArehaza()
  ToClient_qaTeleport(1270167, -3799, 176849)
end
function KutumTest()
  ToClient_qaTeleport(531159, 5820, 162207)
end
function NouverTest()
  ToClient_qaTeleport(729435, 12348, 4370)
end
function KarandaTest()
  Proc_ShowMessage_Ack("\236\185\180\235\158\128\235\139\164 : 23060")
  ToClient_qaTeleport(-142688, 18907, 47731)
end
function KzarkaTest()
  Proc_ShowMessage_Ack("\237\129\172\236\158\144\236\185\180 : 23001")
  ToClient_qaTeleport(52490, 652, -191068)
end
function OpinTest()
  ToClient_qaTeleport(-455712, 12045, -354960)
end
function MurakaTest()
  ToClient_qaTeleport(-400610, 9117, -106154)
end
function QuintTest()
  ToClient_qaTeleport(-333958, -61, 15014)
end
function GarmothTest()
  ToClient_qaTeleport(-23638, 9224, -324144)
end
function VellTest()
  ToClient_qaTeleport(-102400, -8150, 947200)
end
function SycridTest()
  ToClient_qaTeleport(159520, -27351, 431993)
end
function RednoseTest()
  ToClient_qaTeleport(-62791, -3745, 55418)
end
function BhegTest()
  Proc_ShowMessage_Ack("\235\178\160\234\183\184 : 23703")
  ToClient_qaTeleport(33357, -4306, 5408)
end
function AutolootTest()
  for i = 0, 100 do
    luaTimer_AddEvent(ToClient_ChatProcess, 2500 * i + 2000, false, 0, "/lootnearall")
  end
end
function MudTest()
  ToClient_qaTeleport(42367, -3304, 41283)
end
function DimTreeSpiritTest()
  ToClient_qaTeleport(-57721, -2872, 2341)
end
function CreateAllBossKnowledge()
  ToClient_qaCreateItem(34082, 0, 1)
  ToClient_qaCreateItem(34920, 0, 1)
  ToClient_qaCreateItem(34389, 0, 1)
  ToClient_qaCreateItem(34370, 0, 1)
  ToClient_qaCreateItem(35056, 0, 1)
  ToClient_qaCreateItem(35057, 0, 1)
  ToClient_qaCreateItem(35059, 0, 1)
  ToClient_qaCreateItem(35154, 0, 1)
  ToClient_qaCreateItem(34013, 0, 1)
  ToClient_qaCreateItem(34022, 0, 1)
  ToClient_qaCreateItem(34110, 0, 1)
end
function TeleportCrescent()
  ToClient_qaCreateItem(6656, 0, 20)
  ToClient_qaCreateItem(9306, 0, 5)
  ToClient_qaTeleport(729027, 25824, -193761)
end
function TeleportBasilisk()
  ToClient_qaTeleport(379581, -456, 58433)
end
function TeleportAakman()
  ToClient_qaCreateItem(6656, 0, 20)
  ToClient_qaCreateItem(9306, 0, 5)
  ToClient_qaTeleport(667229, -5758, 137024)
end
function TeleportHystria()
  ToClient_qaCreateItem(6656, 0, 20)
  ToClient_qaCreateItem(9306, 0, 5)
  ToClient_qaTeleport(975139, -7359, -36925)
end
function TeleportPilaKu()
  ToClient_qaCreateItem(6656, 0, 20)
  ToClient_qaCreateItem(9306, 0, 5)
  ToClient_qaTeleport(1173823, 16598, -94797)
end
function TeleportSulfur()
  ToClient_qaCreateItem(6656, 0, 20)
  ToClient_qaCreateItem(9306, 0, 5)
  ToClient_qaTeleport(1145794, 26819, 423460)
end
function TeleportMirumok()
  ToClient_qaTeleport(-462621, 12951, -340087)
end
function TeleportUnderwater()
  ToClient_qaTeleport(149967, -37602, 408723)
end
function TeleportSycraia()
  ToClient_qaTeleport(113194, -35505, 423754)
end
function TeleportStarGrave()
  ToClient_qaTeleport(-538788, -1206, -96536)
end
function TeleportProtty()
  ToClient_qaTeleport(50971, -20552, 252612)
end
function TeleportNamPo()
  ToClient_qaTeleport(-1312399.37, -7877.45, 1131501)
end
function TeleportAsparkan()
  ToClient_qaTeleport(270060, -2363, -190031)
end
function TeleportWisdomTree()
  ToClient_qaTeleport(-363075, 3607, -444072)
end
function TeleportDalbeol()
  ToClient_qaTeleport(-1122001, 12737, 1274828)
end
function TeleportMuzgal()
  ToClient_qaTeleport(356146, 1721, -308141)
end
function TeleportByeot()
  ToClient_qaTeleport(-1017476, -4438, 1299917)
end
function TeleportVelandir()
  ToClient_qaTeleport(394310, 17000, -399445)
end
function TeleportOlvia()
  ToClient_qaTeleport(-138786, 809, 122165)
end
function TeleportIliya()
  ToClient_qaTeleport(159563, -7900, 290874)
end
function TeleportGlish()
  ToClient_qaTeleport(-16337, 501, -123557)
end
function TeleportKeplan()
  ToClient_qaTeleport(-159247, -1227, -152599)
end
function TeleportEpheria()
  ToClient_qaTeleport(-358280, -7351, 31195)
end
function TeleportTrent()
  ToClient_qaTeleport(-384757, 9944, -229502)
end
function TeleportTarif()
  ToClient_qaTeleport(218053, -4665, -78294)
end
function TeleportMuiquun()
  ToClient_qaTeleport(1093500, 24339, -134238)
end
function TeleportASC()
  ToClient_qaTeleport(-45035, -3051, -9736)
end
function TeleportNorthMagoria()
  ToClient_qaTeleport(-1245782, -8208, 751261)
end
function TeleportMiddleMagoria()
  ToClient_qaTeleport(-1159354, -8208, 523806)
end
function TeleportSouthMagoria()
  ToClient_qaTeleport(-857164, -8208, 450816)
end
function TeleportAtoraxxion1()
  ToClient_qaTeleport(687613, 34514, -417016)
  ToClient_qaCreateItem(757164, 0, 1)
  ToClient_qaCreateItem(757204, 0, 1)
end
function TeleportAtoraxxion2()
  ToClient_qaTeleport(831478, 22409, -444387)
  ToClient_qaCreateItem(757272, 0, 1)
  ToClient_qaCreateItem(757280, 0, 1)
end
function TeleportAtoraxxion3()
  ToClient_qaTeleport(775641, 43684, -285121)
  ToClient_qaCreateItem(757324, 0, 1)
  ToClient_qaCreateItem(757331, 0, 1)
end
function TeleportValenciaCastle()
  ToClient_qaTeleport(1147705, 15888, 292641)
end
function TeleportOkillua()
  ToClient_qaTeleport(-99656, -7879, 613763)
  ToClient_ChatProcess("/setBossSpawnStatus 4 5 0")
end
function TeleportCalpheonCastle()
  ToClient_qaTeleport(-347334, 1550, -53300)
end
function TeleportIbellab()
  ToClient_qaTeleport(734906.06, 3415.91, 196715.73)
end
function TeleportGyfin()
  ToClient_qaTeleport(-498799, -552, -518480)
end
function TeleportOlun()
  ToClient_qaTeleport(-166057, 12894, -490136)
end
function TeleportTunkta()
  ToClient_qaTeleport(-296298, 16260, -534975)
end
function TeleportThornwood()
  ToClient_qaTeleport(-270958, 15378, -540235)
end
function TeleportAsh()
  ToClient_qaTeleport(-524130, 3841, -165092)
end
function TeleportSilent()
  ToClient_qaTeleport(-235011, 17500, -506779)
end
function TeleportCyclops()
  ToClient_qaTeleport(-365471, 12354, -260551)
end
function TeleportRetreat()
  ToClient_qaTeleport(478796, -1759, -313734)
end
function TeleportIsrahid()
  ToClient_qaTeleport(277787, 17398, -382822)
end
function TeleportTungradRuins()
  ToClient_qaTeleport(383970, 5806, -227050)
end
function SettingA1()
  ToClient_ChatProcess("/dolua ToClient_qaCreateKnowledgeList('11336~11356')")
  ToClient_ChatProcess("/dolua ToClient_qaCreateKnowledge(11358)")
end
function AddPresets()
  ToClient_qaCreateItem(756279, 0, 2)
  ToClient_qaCreateItem(59872, 0, 1)
  ToClient_qaCreateItem(59876, 0, 1)
  ToClient_qaCreateItem(830067, 0, 2)
  ToClient_qaCreateItem(16008, 0, 5)
  ToClient_qaCreateItem(830070, 0, 3)
  ToClient_qaCreateItem(830138, 0, 3)
end
function CheckServerTime()
  ToClient_ChatProcess("/checkservertime")
end
function CheckSiegeTerritory()
  ToClient_ChatProcess("/checksiegeTerritory")
end
function OpenWareHouseMaidForQA(param0)
  PaGlobalFunc_MaidList_All_SelectMaid(param0)
end
function SetForServantQA()
  ToClient_qaLevelUp(60)
  ToClient_qaCreateItem(1, 0, 1)
  ToClient_qaCreateItem(149003, 0, 1)
  luaTimer_AddEvent(ToClient_qaUseInventoryItem, 1000, false, 0, 149003, 0)
  luaTimer_AddEvent(Proc_ShowMessage_Ack, 2000, false, 0, "\"\235\167\136\234\181\172\234\176\132 \237\133\140\236\138\164\237\138\184 \236\160\132\236\151\144 \235\169\148\236\157\180\235\147\156\235\161\156 \236\176\189\234\179\160\236\151\144 1\236\157\128\237\153\148\235\165\188 \235\132\163\236\150\180\236\163\188\236\132\184\236\154\148\"")
  luaTimer_AddEvent(OpenWareHouseMaidForQA, 2000, false, 0, 1)
end
function Wp300()
  ToClient_qaCreateItem(753019, 0, 100)
end
function killmonsterquest()
  ToClient_qaCompleteQuest(11263, 2)
  ToClient_ChatProcess("/questaccept 11262 33")
end
function SetPhysical30()
  ToClient_qaCreateItem(65489, 0, 1)
  ToClient_qaCreateItem(65490, 0, 1)
  ToClient_qaCreateItem(65491, 0, 1)
end
function CreateKnowledge()
  ToClient_ChatProcess("/create item 30001~31200 1")
  ToClient_ChatProcess("/create item 33001~33500 1")
end
function ContributionExp()
  ToClient_qaCreateItem(440, 0, 10)
end
function SetGMItem()
  ToClient_qaCreateItem(65000, 0, 2)
  ToClient_qaCreateItem(65001, 0, 1)
  ToClient_qaCreateItem(65002, 0, 1)
  ToClient_qaCreateItem(65003, 0, 1)
  ToClient_qaCreateItem(65004, 0, 1)
end
function EncreaseWeightBag()
  ToClient_qaCreateItem(65488, 0, 2)
  local maxWeight_str = tostring(getSelfPlayer():get():getPossessableWeight_s64())
  local maxWeightLT = tonumber(maxWeight_str) / 10000
  if maxWeightLT < 3000 then
    ToClient_qaCreateItem(65487, 0, 1)
  end
end
function Set5thFairy()
  local FairyUnseal = ToClient_getFairyUnsealedList()
  local FairySeal = ToClient_getFairySealedList()
  if FairyUnseal == 0 then
    if FairySeal == 0 then
      ToClient_ChatProcess("/newpet create 55240")
    else
      Proc_ShowMessage_Ack("A fairy is already registered.")
      return
    end
  else
    Proc_ShowMessage_Ack("A fairy is already summoned.")
    return
  end
  luaTimer_AddEvent(InputMLClick_FairyInfo_SummonFairy_All, 1000, false, 0)
  luaTimer_AddEvent(ToClient_ChatProcess, 2000, false, 0, "/newpet lvup -1 50")
  luaTimer_AddEvent(ToClient_ChatProcess, 3000, false, 0, "/newpet learnskill -1 49130,49129,49110,49181,49120,49111")
end
function Set5thFairySkill()
  ToClient_ChatProcess("/newpet learnskill -1 49130,49129,49110,49181,49120,49111")
end
function Set5thPet()
  ToClient_qaCompleteQuest(893, 2)
  ToClient_qaCreateItem(59376, 0, 5)
  ToClient_qaTeleport(-358896, 3658, -438234)
end
function Set4thPets()
  local unSealPetCount = ToClient_getPetUnsealedList()
  if unSealPetCount > 30 then
    Proc_ShowMessage_Ack("You have too many pets to create more.")
    return
  else
    ToClient_ChatProcess("/pet create 55128")
    ToClient_ChatProcess("/pet create 55162")
    ToClient_ChatProcess("/pet create 55135")
    ToClient_ChatProcess("/pet create 55085")
    ToClient_ChatProcess("/pet create 55095")
    luaTimer_AddEvent(PaGlobal_PetList_AllUnSeal_ForQA, 0, false, 0)
    luaTimer_AddEvent(PaGlobal_PetList_ReverseAllUnSeal_ForQA, 2000, false, 0)
    luaTimer_AddEvent(ToClient_ChatProcess, 4000, false, 0, "/newpet learnskill 0 49001,49002,49003")
    luaTimer_AddEvent(ToClient_ChatProcess, 4000, false, 0, "/newpet learnskill 1 49001,49002,49003")
    luaTimer_AddEvent(ToClient_ChatProcess, 4000, false, 0, "/newpet learnskill 2 49001,49002,49003")
    luaTimer_AddEvent(ToClient_ChatProcess, 4000, false, 0, "/newpet learnskill 3 49001,49002,49003")
    luaTimer_AddEvent(ToClient_ChatProcess, 4000, false, 0, "/newpet learnskill 4 49001,49002,49003")
  end
end
function AddHungryFull()
  ToClient_ChatProcess("/newpet addhungry 0 400 0")
  ToClient_ChatProcess("/newpet addhungry 1 400 0")
  ToClient_ChatProcess("/newpet addhungry 2 400 0")
  ToClient_ChatProcess("/newpet addhungry 3 400 0")
  ToClient_ChatProcess("/newpet addhungry 4 400 0")
end
function CreateHorseEquip()
  ToClient_qaCreateItem(52512, 10, 1)
  ToClient_qaCreateItem(52612, 10, 1)
  ToClient_qaCreateItem(52712, 10, 1)
  ToClient_qaCreateItem(52812, 10, 1)
  ToClient_qaCreateItem(52912, 10, 1)
  ToClient_qaCreateItem(705156, 0, 1)
  ToClient_qaCreateItem(797, 0, 10)
  ToClient_qaCreateItem(47967, 0, 1)
  ToClient_qaCreateItem(54005, 0, 500)
  if true == CheckIsExistUnsealVehicle() then
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2000, false, 0, 52512, 10)
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2100, false, 0, 52612, 10)
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2200, false, 0, 52712, 10)
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2300, false, 0, 52812, 10)
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 2400, false, 0, 52912, 10)
  end
end
function CheckIsExistUnsealVehicle()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantInfo = temporaryWrapper:getUnsealVehicle(0)
  return nil ~= servantInfo
end
function CreateHorse()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(9883, 1)
  end
end
function CreateMaleHorse()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(9983, 1)
  end
end
function CreateAduahnott()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(9889, 1)
  end
end
function CreateDine()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(9888, 1)
  end
end
function CreateDoom()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(9887, 1)
  end
end
function CreateMythicalAduahnott()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(31539, 1)
  end
end
function CreateMythicalDine()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(31557, 1)
  end
end
function CreateMythicalDoom()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(31575, 1)
  end
end
function CreatePeridotForestPathWagon()
  if true == CheckIsExistUnsealVehicle() then
    Proc_ShowMessage_Ack("A horse is already summoned.")
  else
    ToClient_qaCreateServant(31011, 1)
  end
end
function CreateCarrack()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31045, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49021, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreateCarrackEquip()
  ToClient_ChatProcess("/create item 49742~49746 1 10")
  ToClient_ChatProcess("/create item 49746~49750 1 10")
  ToClient_ChatProcess("/create item 49762~49766 1 10")
  ToClient_ChatProcess("/create item 49766~49770 1 10")
  ToClient_ChatProcess("/create item 49770~49774 1 10")
  ToClient_ChatProcess("/create item 54025 1000")
  ToClient_ChatProcess("/create item 49721 1")
end
function CreatePanokseonEquip()
  ToClient_ChatProcess("/create item 59406~59410 1 10")
  ToClient_ChatProcess("/create item 54025 1000")
end
function CreateCarrackVolante()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31056, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49031, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreateCarrackValor()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31057, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49032, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreateCarrackBalance()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31055, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49030, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreateCarrackAdvance()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31054, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49029, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreatePanokseon()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31025, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  else
    ToClient_qaCreateItem(49037, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
  end
end
function CreateGalleon()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31020, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
    ToClient_ChatProcess("/acquireTitle 2705")
  else
    ToClient_qaCreateItem(49026, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
    ToClient_ChatProcess("/acquireTitle 2705")
  end
end
function CreateShipLicense()
  ToClient_qaCreateItem(49005, 0, 1)
  ToClient_qaCreateItem(49006, 0, 1)
  ToClient_qaCreateItem(49001, 0, 1)
  ToClient_qaCreateItem(49019, 0, 1)
end
function CreateGalleyLicense()
  ToClient_qaCreateItem(49008, 0, 1)
  ToClient_qaCreateItem(49038, 0, 1)
  ToClient_qaCreateItem(49701, 0, 1)
  ToClient_qaCreateItem(49702, 0, 1)
  ToClient_qaCreateItem(49703, 0, 1)
  ToClient_qaCreateItem(49704, 0, 1)
  ToClient_qaCreateItem(5842, 0, 10)
  ToClient_qaCreateItem(5843, 0, 100)
  ToClient_qaCreateItem(5844, 0, 100)
  ToClient_qaCreateItem(5845, 0, 100)
  ToClient_qaCreateItem(9965, 0, 100)
end
function CreateKruwa()
  ToClient_ChatProcess("/create monster 40071 1 1 1 1")
end
function LearnDrivingSkill()
  ToClient_qaLearnHorseSkill(3)
  ToClient_qaLearnHorseSkill(4)
  ToClient_qaLearnHorseSkill(5)
  ToClient_qaLearnHorseSkill(6)
  ToClient_qaLearnHorseSkill(7)
  ToClient_qaLearnHorseSkill(8)
  ToClient_qaLearnHorseSkill(9)
  ToClient_qaLearnHorseSkill(10)
  ToClient_qaLearnHorseSkill(11)
  ToClient_qaLearnHorseSkill(12)
  ToClient_qaLearnHorseSkill(15)
  ToClient_qaLearnHorseSkill(18)
  ToClient_qaLearnHorseSkill(19)
end
function LearnAduahnottSkill()
  ToClient_qaLearnHorseSkill(45)
  ToClient_qaLearnHorseSkill(52)
end
function LearnDineSkill()
  ToClient_qaLearnHorseSkill(45)
  ToClient_qaLearnHorseSkill(53)
end
function LearnDoomSkill()
  ToClient_qaLearnHorseSkill(45)
  ToClient_qaLearnHorseSkill(54)
  ToClient_qaLearnHorseSkill(30)
end
function ServantSkillAllMaster()
  ToClient_qaSetServantSkillExp(0, 1000000)
end
function harpoonfishing()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(9065, 1)
    ToClient_qaCreateItem(16154, 0, 1)
    ToClient_qaCreateItem(16155, 0, 1)
    ToClient_qaCreateItem(65424, 0, 100)
    ToClient_ChatProcess("/lifelvup 81 1")
  else
    ToClient_ChatProcess("/teleport 79264 -8208 256421")
    Proc_ShowMessage_Ack("Press it again after the teleport.")
  end
end
function createSailboat()
  if true == IsSelfPlayerSwimmingAction() then
    ToClient_qaCreateServant(31056, 1)
    ToClient_qaCreateItem(54027, 0, 50)
    ToClient_qaCreateItem(49766, 10, 1)
    ToClient_qaCreateItem(49767, 10, 1)
    ToClient_qaCreateItem(49768, 10, 1)
    ToClient_qaCreateItem(49769, 10, 1)
    ToClient_qaCreateItem(49721, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
    ToClient_qaCreateItem(44944, 0, 1)
    ToClient_qaCreateItem(6394, 0, 50)
    ToClient_qaCreateItem(6395, 0, 50)
  else
    ToClient_qaCreateItem(49031, 0, 1)
    ToClient_qaCreateItem(54027, 0, 50)
    ToClient_qaCreateItem(49766, 10, 1)
    ToClient_qaCreateItem(49767, 10, 1)
    ToClient_qaCreateItem(49768, 10, 1)
    ToClient_qaCreateItem(49769, 10, 1)
    ToClient_qaCreateItem(49721, 0, 1)
    ToClient_ChatProcess("/lifelvup 51 9")
    ToClient_qaCreateItem(44944, 0, 1)
    ToClient_qaCreateItem(6394, 0, 50)
    ToClient_qaCreateItem(6395, 0, 50)
  end
end
function DesertSupport()
  ToClient_qaCreateItem(16012, 0, 1)
  ToClient_qaCreateItem(44942, 0, 1)
  ToClient_qaCreateItem(6656, 0, 50)
  ToClient_qaCreateItem(9306, 0, 10)
  ToClient_qaCreateItem(9366, 0, 10)
  ToClient_qaCreateItem(17976, 0, 1)
end
function OceanSupport()
  ToClient_qaCreateItem(16012, 0, 1)
  ToClient_qaCreateItem(44944, 0, 1)
  ToClient_qaCreateItem(16017, 0, 10)
  ToClient_qaCreateItem(263, 0, 5)
end
function DespawnAllBoss()
  chatting_sendMessage("", "\235\170\168\235\147\160 \235\179\180\236\138\164 \236\158\144\236\151\176\236\130\172\236\139\156\237\130\164\234\178\160\236\138\181\235\139\136\235\139\164.", CppEnums.ChatType.World)
  ToClient_ChatProcess("/changeallmonsterai timeoutboss 0")
end
function ResetAllBossHP()
  chatting_sendMessage("", "\235\170\168\235\147\160 \235\179\180\236\138\164 \236\178\180\235\160\165 \236\180\136\234\184\176\237\153\148\237\149\169\235\139\136\235\139\164.", CppEnums.ChatType.World)
  ToClient_ChatProcess("/resetBossHpUpdateTime 23073")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23032")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23001")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23060")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23099")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23102")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23097")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23809")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23810")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23811")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23812")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23813")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23814")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23815")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23816")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23817")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23120")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23136")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23137")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23138")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23139")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23140")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23080")
  ToClient_ChatProcess("/resetBossHpUpdateTime 23085")
end
function SummonVell()
  luaTimer_AddEvent(chatting_sendMessage, 0, false, 0, "", "\235\178\168 \236\134\140\237\153\152\237\149\152\234\178\160\236\138\181\235\139\136\235\139\164.", CppEnums.ChatType.World)
  luaTimer_AddEvent(ToClient_ChatProcess, 200, false, 0, "/resetBossHpUpdate 23080")
  luaTimer_AddEvent(ToClient_ChatProcess, 400, false, 0, "/resetBossHpUpdate 23085")
  luaTimer_AddEvent(ToClient_ChatProcess, 600, false, 0, "/killnearallmonster")
  luaTimer_AddEvent(ToClient_ChatProcess, 750, false, 0, "/create monster 23080 1")
  luaTimer_AddEvent(ToClient_ChatProcess, 800, false, 0, "/create monster 23085 1")
  luaTimer_AddEvent(ToClient_ChatProcess, 8800, false, 0, "/changeallmonsterai ready 0")
  luaTimer_AddEvent(ToClient_ChatProcess, 14900, false, 0, "/changeallmonsterai comeonbell 0")
end
function HadumBuff1()
  ToClient_qaCreateItem(44786, 0, 1)
end
function HadumBuff2()
  ToClient_qaCreateItem(44787, 0, 1)
end
function HadumBuff3()
  ToClient_qaCreateItem(44788, 0, 1)
end
function CreateAlchemyStone()
  ToClient_qaCreateItem(45220, 0, 1)
  ToClient_qaCreateItem(45252, 0, 1)
  ToClient_qaCreateItem(45284, 0, 1)
  ToClient_qaCreateItem(45224, 0, 1)
  ToClient_qaCreateItem(45256, 0, 1)
  ToClient_qaCreateItem(45288, 0, 1)
  ToClient_qaCreateItem(45332, 0, 1)
  ToClient_qaCreateItem(768185, 0, 1)
  ToClient_qaCreateItem(768508, 0, 1)
  ToClient_qaCreateItem(45381, 0, 1)
  ToClient_qaCreateItem(45503, 0, 1)
  ToClient_qaCreateItem(45513, 0, 1)
  ToClient_qaCreateItem(45514, 0, 1)
  ToClient_qaCreateItem(750524, 0, 1)
  ToClient_qaCreateItem(8421, 0, 10)
  ToClient_qaCreateItem(8432, 0, 10)
  ToClient_qaCreateItem(4053, 0, 300)
  ToClient_qaCreateItem(5466, 0, 300)
  ToClient_qaCreateItem(4656, 0, 300)
  ToClient_qaCreateItem(4924, 0, 300)
end
function CreateManosAcc(enchantLevel)
  if nil == enchantLevel then
    for enchantLevel = 0, 5 do
      ToClient_qaCreateItem(705509, enchantLevel, 1)
      ToClient_qaCreateItem(705510, enchantLevel, 2)
      ToClient_qaCreateItem(705511, enchantLevel, 2)
      ToClient_qaCreateItem(705512, enchantLevel, 1)
    end
  elseif enchantLevel < 6 and enchantLevel >= 0 then
    ToClient_qaCreateItem(705509, enchantLevel, 1)
    ToClient_qaCreateItem(705510, enchantLevel, 2)
    ToClient_qaCreateItem(705511, enchantLevel, 2)
    ToClient_qaCreateItem(705512, enchantLevel, 1)
  else
    return
  end
end
function CreateAttAcc(enchantLevel)
  if nil == enchantLevel then
    CreateAttAcc(20)
    CreateAttAcc(19)
    return
  elseif enchantLevel < 15 then
    enchantLevel = 15
  end
  ToClient_qaCreateItem(12031, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11828, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11853, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12230, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11607, enchantLevel - 15, 1)
end
function CreateDefAcc(enchantLevel)
  if nil == enchantLevel then
    CreateDefAcc(20)
    CreateDefAcc(19)
    return
  elseif enchantLevel < 15 then
    enchantLevel = 15
  end
  ToClient_qaCreateItem(11662, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11856, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12032, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11926, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12229, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11611, enchantLevel - 15, 1)
end
function CreateBalAcc(enchantLevel)
  if nil == enchantLevel then
    CreateBalAcc(20)
    CreateBalAcc(19)
    return
  elseif enchantLevel < 15 then
    enchantLevel = 15
  end
  ToClient_qaCreateItem(11834, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12251, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12229, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11625, enchantLevel - 15, 1)
end
function CreateTunAcc(enchantLevel)
  if nil == enchantLevel then
    CreateTunAcc(20)
    CreateTunAcc(19)
    return
  elseif enchantLevel < 15 then
    enchantLevel = 15
  end
  ToClient_qaCreateItem(12061, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11828, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12237, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11629, enchantLevel - 15, 1)
end
function CreateAttAcc1(enchantLevel)
  if nil == enchantLevel then
    CreateAttAcc1(20)
    CreateAttAcc1(19)
    return
  elseif enchantLevel < 15 then
    enchantLevel = 15
  end
  ToClient_qaCreateItem(12060, enchantLevel - 15, 2)
  ToClient_qaCreateItem(12061, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11882, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11853, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11828, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11834, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11855, enchantLevel - 15, 2)
  ToClient_qaCreateItem(11653, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11629, enchantLevel - 15, 1)
  ToClient_qaCreateItem(11663, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12276, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12236, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12237, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12257, enchantLevel - 15, 1)
  ToClient_qaCreateItem(12282, enchantLevel - 15, 1)
end
function jumpitem()
  ToClient_qaCreateItem(10821, 20, 1)
  ToClient_qaCreateItem(10822, 20, 1)
  ToClient_qaCreateItem(10823, 20, 1)
  ToClient_qaCreateItem(11008, 20, 1)
  ToClient_qaCreateItem(622, 0, 50)
  ToClient_qaCreateItem(15213, 0, 2)
  ToClient_qaCreateItem(934, 0, 1)
  ToClient_qaCreateItem(44940, 0, 1)
  ToClient_qaCreateItem(9241, 0, 10)
  ToClient_qaCreateItem(735207, 0, 2)
  ToClient_qaCreateItem(758018, 0, 2)
  ToClient_qaCreateItem(762006, 0, 2)
end
function PriDuoWeapon()
  createBossWeapon(17)
  createBossWeapon(16)
end
function PriDuoArmor()
  createBossArmor(17)
  createBossArmor(16)
end
function PriDuoAcc()
  CreateAttAcc(17)
  CreateAttAcc(16)
end
function PriDuoDefAcc()
  CreateDefAcc(17)
  CreateDefAcc(16)
end
function PriDuoBalAcc()
  CreateBalAcc(17)
  CreateBalAcc(16)
end
function PriDuoTunAcc()
  CreateTunAcc(17)
  CreateTunAcc(16)
end
function TriTetPenWeapon()
  createBossWeapon(20)
  createBossWeapon(19)
  createBossWeapon(18)
end
function TriTetPenArmor()
  createBossArmor(20)
  createBossArmor(19)
  createBossArmor(18)
end
function TriTetPenAcc()
  CreateAttAcc(20)
  CreateAttAcc(19)
  CreateAttAcc(18)
end
function CreateSkillinstructor()
  ToClient_ChatProcess("/create monster 41009 1 1 1")
end
function CreateEqiupRepairNPC()
  ToClient_ChatProcess("/create monster 40008 1 1 1")
  ToClient_ChatProcess("/create item 1 1000000")
end
function KillNearAllMonster()
  ToClient_ChatProcess("/killnearallmonster")
end
function LootNearAll()
  ToClient_ChatProcess("/lootnearall")
end
function TeleportToDestination()
  ToClient_ChatProcess("/teleport")
end
function ShowCharacterKey()
  local interactableActor = interaction_getInteractable()
  local characterKeyRaw
  if interactableActor ~= nil then
    characterKeyRaw = interactableActor:getCharacterKeyRaw()
    Proc_ShowMessage_Ack("\236\186\144\235\166\173\237\132\176 \237\130\164 : " .. tostring(characterKeyRaw))
  else
    Proc_ShowMessage_Ack("Please try again after the interaction.")
    return
  end
end
function SetMyHp(value)
  local selfPlayer = getSelfPlayer()
  local mycharactername = selfPlayer:getName()
  ToClient_ChatProcess("/sethp " .. tostring(mycharactername) .. " " .. tostring(value))
end
function ClearPlayerSkillCoolTime()
  ToClient_ChatProcess("/clearplayerskillcooltime")
  ToClient_ChatProcess("/resetPresetCooltime")
  ToClient_ChatProcess("/dolua ToClient_ResetEmergencyEvade()")
  ToClient_ChatProcess("/clearEscapeCoolTime")
end
function ClearBuff()
  ToClient_ChatProcess("/clearSelfPlayerAllBuff")
end
function WarReady20()
  ToClient_ChatProcess("/dolua warready(20)")
end
function RecoverWp()
  local selfPlayer = getSelfPlayer()
  local myWp = selfPlayer:getWp()
  local myMaxWp = selfPlayer:getMaxWp()
  local emptyWp = myMaxWp - myWp
  if myMaxWp == myWp then
    Proc_ShowMessage_Ack("Your energy is at max.")
  elseif myWp < myMaxWp then
    ToClient_ChatProcess("/mentalup " .. tostring(emptyWp))
  else
    return
  end
end
function UpAdrenalin()
  ToClient_ChatProcess("/upadrenalin 50000")
end
function PrintHereCopy()
  ToClient_ChatProcess("/print herecopy")
end
function ReloadUI()
  ToClient_ChatProcess("/reloadui")
end
function GetHpHereCopy()
  ToClient_ChatProcess("/getHp")
end
function ItemBoxGo(isOn)
  if nil == isOn then
    return
  end
  if false == ToClient_IsDevelopment() then
    return
  end
  if 0 == isOn then
    boxValue = false
    HandleEventLUp_RandomBoxSelect_All_OnPressEscape()
  elseif 1 == isOn then
    boxValue = true
  end
end
function ItemBoxGoXXX()
  if false == ToClient_IsDevelopment() then
    return false
  end
  if nil == boxValue then
    return false
  end
  return boxValue
end
function OneButtonBuff()
  SetFullBuff()
  SetGoldbarBuff()
  criBuff()
  createBuffItem()
end
function SetFullBuff()
  ToClient_qaCreateItem(43706, 0, 1)
  ToClient_qaCreateItem(43934, 0, 1)
  ToClient_qaCreateItem(9693, 0, 1)
  ToClient_qaCreateItem(734, 0, 2)
  ToClient_qaCreateItem(795, 0, 2)
  ToClient_qaCreateItem(793, 0, 2)
  ToClient_qaCreateItem(752046, 0, 1)
  ToClient_qaCreateItem(47967, 0, 1)
end
function SetGoldbarBuff()
  ToClient_qaCreateItem(752017, 0, 1)
  ToClient_qaCreateItem(752018, 0, 1)
  ToClient_qaCreateItem(47967, 0, 1)
end
function ItemdropBuff()
  ToClient_qaCreateItem(17081, 0, 1)
  ToClient_qaCreateItem(17572, 0, 10)
  ToClient_qaCreateItem(46866, 0, 10)
  ToClient_qaCreateItem(750493, 0, 2)
  ToClient_qaCreateItem(752229, 0, 5)
  ToClient_qaCreateItem(750642, 0, 1)
end
function criBuff()
  ToClient_qaCreateItem(942, 0, 1)
end
function CreateKzarka()
  ToClient_ChatProcess("/create monster 23001 1")
end
function CreateZKzarka()
  ToClient_ChatProcess("/create monster 23172 1")
end
function CreateKaranda()
  ToClient_ChatProcess("/create monster 23060 1")
end
function CreateZKaranda()
  ToClient_ChatProcess("/create monster 23206 1")
end
function CreateNouver()
  ToClient_ChatProcess("/create monster 23032 1")
end
function CreateZNouver()
  ToClient_ChatProcess("/create monster 23200 1")
end
function CreateKutum()
  ToClient_ChatProcess("/create monster 23073 1")
end
function CreateZKutum()
  ToClient_ChatProcess("/create monster 23217 1")
end
function CreateGarmoth()
  ToClient_ChatProcess("/create monster 23120 1")
end
function CreateOffin()
  luaTimer_AddEvent(ToClient_ChatProcess, 0, false, 0, "/resetBossHpUpdate 23809")
  luaTimer_AddEvent(ToClient_ChatProcess, 200, false, 0, "/create monster 23809 1")
end
function CreateQuint()
  ToClient_ChatProcess("/create monster 23102 1")
end
function AcctiveQuint()
  ToClient_ChatProcess("/create monster 23099 1")
end
function VaryFeverPoint(point)
  ToClient_ChatProcess("/VaryFeverPoint " .. point)
end
function SetMyTendency(value)
  local selfPlayer = getSelfPlayer()
  local mycharactername = selfPlayer:getName()
  ToClient_ChatProcess("/tendency " .. tostring(mycharactername) .. " " .. tostring(value))
end
function TeleportSeaMonster()
  ToClient_ChatProcess("/create item 49770~49774 1 10")
  ToClient_ChatProcess("/create item 54025 1000")
  ToClient_qaTeleport(-486400, -8208, 1420800)
end
function TeleportSeaFleet()
  ToClient_ChatProcess("/create item 49770~49774 1 10")
  ToClient_ChatProcess("/create item 54025 1000")
  ToClient_qaTeleport(97099, -8150, 1078920)
end
function TeleportBloodyMonastery()
  ToClient_qaTeleport(-33666, 3579, -171435)
end
function TeleportHexe()
  ToClient_qaTeleport(-230743, 5946, -251172)
end
function SetTrSleepTick()
  local trID = UI.getChildControl(QASupport_AutomationPanel, "Edit_TrID"):GetEditText()
  local TickCount = UI.getChildControl(QASupport_AutomationPanel, "Edit_Tick"):GetEditText()
  local actionName = UI.getChildControl(QASupport_AutomationPanel, "Edit_ActionName"):GetEditText()
  ToClient_setTrSleepTick(trID, TickCount, tostring(actionName))
end
function siegeready1()
  EncreaseWeightBag()
  ToClient_qaCreateItem(44701, 0, 1)
  ToClient_qaCreateItem(56708, 0, 1)
  ToClient_qaCreateItem(56709, 0, 1)
  ToClient_qaCreateItem(56710, 0, 1)
  ToClient_qaCreateItem(56711, 0, 1)
  ToClient_qaCreateItem(56773, 0, 1)
  ToClient_qaCreateItem(56774, 0, 1)
  ToClient_qaCreateItem(56775, 0, 1)
  ToClient_qaCreateItem(56776, 0, 1)
  ToClient_qaCreateItem(56777, 0, 1)
end
function siegeready2()
  EncreaseWeightBag()
  ToClient_qaCreateItem(59791, 0, 20)
  ToClient_qaCreateItem(56122, 0, 10)
  ToClient_qaCreateItem(56171, 0, 1)
  ToClient_qaCreateItem(56173, 0, 1)
  ToClient_qaCreateItem(56003, 0, 10)
  ToClient_qaCreateItem(56051, 0, 10)
  ToClient_qaCreateItem(56052, 0, 10)
  ToClient_qaCreateItem(607028, 0, 10)
  ToClient_qaCreateItem(4077, 0, 200)
  ToClient_qaCreateItem(4257, 0, 200)
  ToClient_qaCreateItem(4068, 0, 200)
  ToClient_qaCreateItem(56067, 0, 10)
  ToClient_qaCreateItem(56068, 0, 10)
  ToClient_qaCreateItem(4052, 0, 200)
  ToClient_qaCreateItem(4057, 0, 200)
  ToClient_qaCreateItem(51014, 0, 1)
  ToClient_qaCreateItem(56080, 0, 30)
end
function siegeready3()
  ToClient_ChatProcess("/dolua siegeready(3)")
end
function siegeready4()
  ToClient_ChatProcess("/dolua siegeready(4)")
end
function siegeready0()
  ToClient_ChatProcess("/dolua siegeready(0)")
end
function decreaseendurance()
  ToClient_ChatProcess("/decreaseendurance 49")
end
function QuestClearMarni()
  ToClient_qaCompleteQuest(21418, 1)
  ToClient_qaCompleteQuest(21418, 2)
  ToClient_qaCompleteQuest(21418, 3)
  ToClient_qaCompleteQuest(21418, 4)
  ToClient_qaCompleteQuest(21418, 5)
  ToClient_qaCompleteQuest(21418, 6)
  ToClient_qaCreateItem(45026, 0, 1000)
  ToClient_qaCreateItem(320157, 0, 100)
end
function AtoraxionTeleport()
  ToClient_qaTeleport(-45035, -3051, -9736)
end
function AgrisFieldChargeQA()
  ToClient_ChatProcess("/addPersonalFieldTime 1 0")
end
function AgrisFieldClearQA()
  ToClient_ChatProcess("/clearPersonalFieldEnterDelay")
end
function DehkiaItemSetting()
  ToClient_qaCreateItem(790584, 0, 1)
  ToClient_qaCreateItem(790585, 0, 1)
  ToClient_qaCreateItem(820905, 0, 100)
end
function DehkiaCoolTimeReset()
  ToClient_ChatProcess("/clearmonsterbuffzoneitemcooltime")
end
function GuildRaidSummon()
  ToClient_ChatProcess("/setBossSpawnStatus 1 4 0")
  ToClient_ChatProcess("/setBossSpawnStatus 2 4 0")
  ToClient_ChatProcess("/setBossSpawnStatus 3 4 0")
  ToClient_ChatProcess("/setBossSpawnStatus 4 5 0")
end
function GuildAlliMember()
  ToClient_ChatProcess("/requestGuildAllianceCount 2 1")
end
function GuildFundsQA()
  ToClient_ChatProcess("/addguildmoney 1000000000")
end
function GuildSkillCooltimeReset()
  ToClient_ChatProcess("/clearGuildSkillCoolTime")
end
function GuildQuestChange()
  ToClient_ChatProcess("/refreshGuildQuest")
end
function GuildQuestMeberCountQA()
  ToClient_ChatProcess("/changeAcceptGuildQuestMemberCount 1")
end
function JoinSiegeCountReset()
  ToClient_ChatProcess("/resetMinorSiegeJoinableAllGuild")
end
function StratSiege1()
  ToClient_ChatProcess("/startSiege 1")
end
function StratSiege0()
  ToClient_ChatProcess("/startSiege 0")
end
function WaterRunFull()
  ToClient_ChatProcess("/setWaterRunGauge 1000000")
end
function CreateQuturan()
  ToClient_qaCreateItem(18500, 0, 1)
end
function CreateDreamHorse()
  ToClient_qaCreateItem(50815, 0, 1000)
  ToClient_qaCreateItem(50816, 0, 1000)
  ToClient_qaCreateItem(50817, 0, 1000)
  ToClient_qaCreateItem(757008, 0, 20)
end
function createWorkerQA()
  ToClient_qaCreateItem(768502, 0, 1)
  ToClient_qaCreateItem(9492, 0, 1000)
  ToClient_qaCreateItem(9213, 0, 1000)
end
function CreateTreasure()
  ToClient_qaCreateItem(16019, 0, 1)
  ToClient_qaCreateItem(16016, 0, 1)
  ToClient_qaCreateItem(65299, 0, 1)
  ToClient_qaCreateItem(12034, 0, 1)
  ToClient_qaCreateItem(59418, 0, 1)
end
function RoseWarPointQA()
  ToClient_ChatProcess("/EnableElfWarTimer 0")
end
function RoseWarStartQA1()
  ToClient_ChatProcess("/changeElfWarState 0")
end
function RoseWarStartQA2()
  ToClient_ChatProcess("/setElfWarApplyPoint 100")
  ToClient_ChatProcess("/applyOrCancelElfWarByGuild 1")
end
function RoseWarStartQA3()
  ToClient_ChatProcess("/changeElfWarState")
end
function FreecamQA()
  ToClient_ChatProcess("/freecam")
end
function MunitionsManagerQA()
  ToClient_ChatProcess("/create monster 40744 1 1 1 1")
end
function ConquestWarBuildingQA()
  ToClient_ChatProcess("/completeMySiegeBuilding 0")
end
function DmgMeterQA()
  ToClient_ChatProcess("/toggleDmgMeter")
end
function CCtsetQA()
  ToClient_ChatProcess("/setWritebufflog 1")
end
function DebugImmuneQA()
  ToClient_ChatProcess("/debugimmune 1")
end
function DmgLogOnQA()
  ToClient_ChatProcess("/setshowdamagelog 2 0")
end
function DmgLogOffQA()
  ToClient_ChatProcess("/setshowdamagelog 0")
end
function GMUnderwearQA()
  ToClient_qaCreateItem(65020, 0, 1)
  ToClient_qaCreateItem(65039, 0, 1)
  ToClient_qaCreateItem(65498, 0, 1)
  ToClient_qaCreateItem(65499, 0, 1)
  ToClient_qaCreateItem(65500, 0, 1)
end
function SpeedReductionQA()
  ToClient_ChatProcess("/gmbuff 2251 0 0")
end
function StunQA()
  ToClient_ChatProcess("/gmbuff 3133 0 0")
end
function BoundQA()
  ToClient_ChatProcess("/gmbuff 3134 0 0")
end
function StiffnessQA()
  ToClient_ChatProcess("/gmbuff 3136 0 0")
end
function KnockdownQA()
  ToClient_ChatProcess("/gmbuff 7187 0 0")
end
function FreezingQA()
  ToClient_ChatProcess("/gmbuff 3137 0 0")
end
function FloatingQA()
  ToClient_ChatProcess("/gmbuff 3146 0 0")
end
function KnockbackQA()
  ToClient_ChatProcess("/gmbuff 2199 0 0")
end
function AllResistanceQA()
  ToClient_qaCreateItem(720707, 0, 1)
end
function IgnoreAllResistanceQA()
  ToClient_qaCreateItem(720708, 0, 1)
end
function AgrisPointChargeQA()
  ToClient_ChatProcess("/VaryFeverPoint 100000")
end
function clearManorQuestQA()
  ToClient_ChatProcess("/questclear 2063 8")
  ToClient_ChatProcess("/questclear 2063 10")
  ToClient_ChatProcess("/questclear 8510 9")
  ToClient_ChatProcess("/questclear 8516 1")
end
function TeleportManor()
  ToClient_qaTeleport(94862, -2504, -35494)
  ToClient_qaCompleteQuest(2063, 10)
  ToClient_qaCompleteQuest(2063, 8)
end
function TeleportSingledHouse()
  ToClient_qaTeleport(-1241969, -1796, 1160515)
  ToClient_qaCompleteQuest(8510, 9)
  ToClient_qaCompleteQuest(8510, 8)
end
function TeleportSimhyangjae()
  ToClient_qaTeleport(-1136915, 23040, 1290460)
  ToClient_qaCompleteQuest(8516, 1)
end
function TeleportHyunrokdang()
  ToClient_qaTeleport(-1417848, 13210, 1347166)
  ToClient_qaCompleteQuest(8541, 3)
end
function GuildMemberSet()
  ToClient_ChatProcess("/changeSiegeApplyNeedCount 1")
end
function NormalDokkebiChest()
  ToClient_qaCreateKnowledgeList("11608~11708")
end
function MysteryDokkebiChest()
  ToClient_qaCreateKnowledgeList("11708~11713")
end
function RarityDokkebiChest()
  ToClient_qaCreateKnowledgeList("11718~11723")
end
function GuildQAModeQA()
  ToClient_ChatProcess("/setGuildMatchQAMode 1")
end
function GuildLeagueMatchingTimeQA()
  ToClient_ChatProcess("/changeGuildMatchIntervalTime 30")
end
function GuildLeagueCountQA()
  ToClient_ChatProcess("/ChangeGuildMatchMinPlayerCount 1 1")
end
function GuildLeagueStateQA()
  ToClient_ChatProcess("/changeGuildMatchState")
end
function GuildLeagueRoomInfoQA()
  ToClient_ChatProcess("/showGuildMatchRoomInfo")
end
function Create999QA()
  ToClient_ChatProcess("/create monster 999 1")
end
function Create993QA()
  ToClient_ChatProcess("/create monster 993 1")
end
function ArshaAdminQA()
  ToClient_ChatProcess("/setCompetitionManager 1")
end
function EretheaSet()
  ToClient_qaCreateItem(44799, 0, 3)
  ToClient_qaCreateItem(56284, 0, 3)
end
function TPPapuaCrinea()
  ToClient_qaTeleport(-678534, -8069.33, -186911.21)
end
function CreateSkillPoint()
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if -1 == skillPointInfo then
    return
  end
  self._acquireSkillPoint = skillPointInfo._acquirePoint
  if self._acquireSkillPoint > 5000 then
    Proc_ShowMessage_Ack("You have too many skill points to create more.")
    return
  else
    ToClient_qaCreateItem(60, 0, 150)
  end
end
function TestFunc()
  skillPointInfo = ToClient_getSkillPointInfo(0)
  self._acquireSkillPoint = skillPointInfo._acquirePoint
end
function qa_subWeapon()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  if isClassType == __eClassType_Warrior or isClassType == __eClassType_Valkyrie or isClassType == __eClassType_Guardian then
    ToClient_ChatProcess("/create item 701081 1 20 20")
  elseif isClassType == __eClassType_ElfRanger or isClassType == __eClassType_WizardWoman or isClassType == __eClassType_WizardMan then
    ToClient_ChatProcess("/create item 701083 1 20 20")
  elseif isClassType == __eClassType_Sorcerer or isClassType == __eClassType_Sage then
    ToClient_ChatProcess("/create item 701085 1 20 20")
  elseif isClassType == __eClassType_Giant or isClassType == __eClassType_DarkElf then
    ToClient_ChatProcess("/create item 701087 1 20 20")
  elseif isClassType == __eClassType_Tamer then
    ToClient_ChatProcess("/create item 701089 1 20 20")
  elseif isClassType == __eClassType_BladeMaster or isClassType == __eClassType_BladeMasterWoman then
    ToClient_ChatProcess("/create item 701091 1 20 20")
  elseif isClassType == __eClassType_Kunoichi then
    ToClient_ChatProcess("/create item 701093 1 20 20")
  elseif isClassType == __eClassType_NinjaMan then
    ToClient_ChatProcess("/create item 701095 1 20 20")
  elseif isClassType == __eClassType_Combattant or isClassType == __eClassType_Mystic then
    ToClient_ChatProcess("/create item 701097 1 20 20")
  elseif isClassType == __eClassType_Lhan then
    ToClient_ChatProcess("/create item 701099 1 20 20")
  elseif isClassType == __eClassType_RangerMan then
    ToClient_ChatProcess("/create item 701101 1 20 20")
  elseif isClassType == __eClassType_ShyWaman then
    ToClient_ChatProcess("/create item 719055 1 20 20")
  elseif isClassType == __eClassType_Hashashin then
    ToClient_ChatProcess("/create item 692531 1 20 20")
  elseif isClassType == __eClassType_Nova then
    ToClient_ChatProcess("/create item 730733 1 20 20")
  elseif isClassType == __eClassType_Corsair then
    ToClient_ChatProcess("/create item 733232 1 20 20")
  elseif isClassType == __eClassType_Drakania then
    ToClient_ChatProcess("/create item 735632 1 20 20")
  elseif isClassType == __eClassType_Giant_Reserved0 then
  elseif isClassType == __eClassType_Giant_Reserved2 then
    ToClient_ChatProcess("/create item 733994 1 20 20")
  elseif isClassType == __eClassType_KunoichiOld then
    ToClient_ChatProcess("/create item 733985 1 20 20")
  elseif isClassType == __eClassType_Scholar then
    ToClient_ChatProcess("/create item 742532 1 20 20")
  elseif isClassType == 33 then
    ToClient_ChatProcess("/create item 746828 1 20 20")
  end
end
function create_artifact()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isClassType = selfPlayer:getClassType()
  melle_char = {
    __eClassType_Warrior,
    __eClassType_Valkyrie,
    __eClassType_Guardian,
    __eClassType_Giant,
    __eClassType_BladeMaster,
    __eClassType_BladeMasterWoman,
    __eClassType_Kunoichi,
    __eClassType_NinjaMan,
    __eClassType_Combattant,
    __eClassType_Mystic,
    __eClassType_Lhan,
    __eClassType_ShyWaman,
    __eClassType_Nova,
    __eClassType_Corsair,
    __eClassType_Drakania,
    __eClassType_Scholar
  }
  missile_char = {__eClassType_ElfRanger, __eClassType_RangerMan}
  wizard_char = {
    __eClassType_WizardWoman,
    __eClassType_WizardMan,
    __eClassType_Sorcerer,
    __eClassType_Sage,
    __eClassType_DarkElf,
    __eClassType_Tamer,
    __eClassType_Hashashin,
    __eClassType_Giant_Reserved2,
    __eClassType_KunoichiOld,
    33
  }
  for _, value in ipairs(melle_char) do
    if value == isClassType then
      ToClient_qaCreateItem(735204, 0, 2)
      return
    end
  end
  for _, value in ipairs(missile_char) do
    if value == isClassType then
      ToClient_qaCreateItem(735205, 0, 2)
      return
    end
  end
  for _, value in ipairs(wizard_char) do
    if value == isClassType then
      ToClient_qaCreateItem(735206, 0, 2)
      return
    end
  end
end
function qa_pvptest()
  ToClient_qaLevelUp(64)
  ToClient_qaCreateItem(65488, 0, 2)
  ToClient_qaCreateItem(65487, 0, 1)
  mainWeapon(20)
  qa_subWeapon()
  awakenWeapon(20)
  CreateSkillPoint()
  ToClient_qaCreateItem(719897, 4, 1)
  ToClient_qaCreateItem(719898, 4, 1)
  ToClient_qaCreateItem(719899, 4, 1)
  ToClient_qaCreateItem(719955, 4, 1)
  ToClient_qaCreateItem(719900, 4, 1)
  ToClient_qaCreateItem(719956, 4, 1)
  ToClient_qaCreateItem(12096, 5, 2)
  ToClient_qaCreateItem(11669, 5, 1)
  ToClient_qaCreateItem(11872, 5, 1)
  ToClient_qaCreateItem(11884, 5, 1)
  ToClient_qaCreateItem(12278, 5, 1)
  ToClient_qaCreateItem(768508, 0, 1)
  ToClient_qaCreateItem(45561, 0, 1)
  ToClient_qaCreateItem(44980, 0, 1)
  ToClient_qaCreateItem(45881, 0, 1)
  ToClient_qaCreateItem(610335, 0, 1)
  ToClient_qaCreateItem(721003, 0, 100000)
  awakening()
  ToClient_qaCreateItem(15740, 0, 2)
  ToClient_qaCreateItem(15689, 0, 2)
  ToClient_qaCreateItem(15253, 0, 4)
  ToClient_qaCreateItem(15255, 0, 2)
  ToClient_qaCreateItem(15672, 0, 2)
  ToClient_qaCreateItem(15733, 0, 2)
  ToClient_qaCreateItem(15709, 0, 2)
  ToClient_qaCreateItem(15807, 0, 2)
  ToClient_qaCreateItem(9693, 0, 30)
  ToClient_qaCreateItem(1167, 0, 30)
  ToClient_qaCreateItem(1163, 0, 30)
  ToClient_qaCreateItem(40713, 0, 1)
  ToClient_qaCreateItem(40712, 0, 1)
  create_artifact()
  ToClient_qaCreateItem(758001, 0, 1)
  ToClient_qaCreateItem(758002, 0, 1)
  ToClient_qaCreateItem(758011, 0, 1)
  ToClient_qaCreateItem(762003, 0, 1)
  ToClient_qaCreateItem(59872, 0, 1)
  ToClient_qaCreateItem(59876, 0, 1)
  ToClient_qaCreateItem(16008, 0, 5)
  ToClient_ChatProcess("/create item 724051 1")
end
function ApplyBalenosQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 0")
end
function ApplySerendiaQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 1")
end
function ApplyCalpheonQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 2")
end
function ApplyMediaQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 3")
end
function ApplyValenciaQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 4")
end
function ApplyKamasylviaQA()
  ToClient_ChatProcess("/applyOrCancelSiege2024Territory 1 6")
end
function ClearApplySiegeTerritoryQA()
  ToClient_ChatProcess("/clearSiegeTerritoryList")
end
function NewElixirQA()
  ToClient_qaCreateItem(1389, 0, 20)
  ToClient_qaCreateItem(1390, 0, 20)
  ToClient_qaCreateItem(1391, 0, 20)
  ToClient_qaCreateItem(1392, 0, 20)
  ToClient_qaCreateItem(1393, 0, 20)
  ToClient_qaCreateItem(1394, 0, 20)
  ToClient_qaCreateItem(1395, 0, 20)
  ToClient_qaCreateItem(1396, 0, 20)
  ToClient_qaCreateItem(1397, 0, 20)
  ToClient_qaCreateItem(1398, 0, 20)
  ToClient_qaCreateItem(1399, 0, 20)
  ToClient_qaCreateItem(1400, 0, 20)
  ToClient_qaCreateItem(1401, 0, 20)
  ToClient_qaCreateItem(1402, 0, 20)
  ToClient_qaCreateItem(1403, 0, 20)
  ToClient_qaCreateItem(1404, 0, 20)
  ToClient_qaCreateItem(1405, 0, 20)
  ToClient_qaCreateItem(1406, 0, 20)
end
function cn_account_set(type)
  local cmd_list = {}
  if 1 == type then
    cmd_list = {
      "/lvup 62",
      "/dolua mainWeapon(19)",
      "/dolua PvEsubWeapon(19)",
      "/dolua awakenWeapon(19)",
      "/dolua awakening()",
      "/dolua createSkillPoint(3000)",
      "/create item 47111 3",
      "/dolua use_inventory_item(47111,0,3)",
      "/create item 695106 1 20",
      "/dolua use_inventory_item(695106,20,1)",
      "/create item 695107 1 20",
      "/dolua use_inventory_item(695107,20,1)",
      "/create item 695108 1 20",
      "/dolua use_inventory_item(695108,20,1)",
      "/create item 695105 1 20",
      "/dolua use_inventory_item(695105,20,1)",
      "/create item 695111 2 5",
      "/dolua use_inventory_item(695111,5,2)",
      "/create item 695110 2 5",
      "/dolua use_inventory_item(695110,5,2)",
      "/create item 695109 1 5",
      "/dolua use_inventory_item(695109,5,1)",
      "/create item 695112 1 5",
      "/dolua use_inventory_item(695112,5,1)",
      "/create item 590399 1",
      "/dolua use_inventory_item(590399,0,1)",
      "/create item 320181 1",
      "/dolua EncreaseWeightBag()"
    }
  end
  if 11 == type then
    cmd_list = {
      "/dolua use_inventory_item(47111,0,3)",
      "/dolua use_inventory_item(695106,20,1)",
      "/dolua use_inventory_item(695107,20,1)",
      "/dolua use_inventory_item(695108,20,1)",
      "/dolua use_inventory_item(695105,20,1)",
      "/dolua use_inventory_item(695111,5,2)",
      "/dolua use_inventory_item(695110,5,2)",
      "/dolua use_inventory_item(695109,5,1)",
      "/dolua use_inventory_item(695112,5,1)",
      "/dolua use_inventory_item(590399,0,1)"
    }
  end
  if 0 == type then
    cmd_list = {
      "/questclear 6802 1",
      "/questclear 6802 2",
      "/questclear 6802 3",
      "/questclear 6802 4",
      "/questclear 6802 5",
      "/create item 54031 1000",
      "/create item 320107 1000",
      "/create item 54030 1000",
      "/create item 18448 1000",
      "/create item 18447 1000",
      "/create item 18465 1",
      "/create item 16162 1 10",
      "/dolua use_inventory_item(16162,10,1)",
      "/create item 16168 1 10",
      "/dolua use_inventory_item(16168,10,1)",
      "/create item 440 600",
      "/create item 47122 1",
      "/dolua use_inventory_item(47122,0,1)",
      "/create item 17939 1",
      "/create item 17941 1",
      "/create item 17972 1",
      "/create item 17977 1",
      "/create item 17971 1",
      "/create item 17579 12",
      "/dolua use_inventory_item(17579,0,12)",
      "/create item 1 1000000000",
      "/create item 6 500000",
      "/create item 7 500000",
      "/create item 17756 15",
      "/create item 757422 100",
      "/create item 757423 100",
      "/create item 16490 100",
      "/create item 607551 3",
      "/create item 16008 1",
      "/create item 149002 40",
      "/dolua use_inventory_item(149002,0,40)",
      "/create item 149003 40",
      "/dolua use_inventory_item(149003,0,40)",
      "/create item 18408 1000",
      "/create item 9321 1",
      "/create item 40747 1",
      "/create item 40750 1",
      "/create item 17567 50",
      "/create item 320155 6",
      "/dolua use_inventory_item(320155,0,6)",
      "/create item 320152 5",
      "/dolua use_inventory_item(320152,0,5)",
      "/create item 49013 1",
      "/create item 18881 1",
      "/create item 18882 1",
      "/create item 18883 1",
      "/create item 18884 1",
      "/create item 60000~61000 1",
      "/dolua use_inventory_item(17756,0,15)",
      "/create item 15677 2",
      "/create item 15640 2",
      "/create item 768870 2",
      "/create item 15807 2",
      "/create item 15816 1",
      "/create item 15813 1",
      "/create item 15801 2"
    }
  end
  if 0 == type then
    cmd_list = {
      "/dolua use_inventory_item(16162,10,1)",
      "/dolua use_inventory_item(16168,10,1)",
      "/dolua use_inventory_item(47122,0,1)",
      "/dolua use_inventory_item(17579,0,12)",
      "/dolua use_inventory_item(149002,0,40)",
      "/dolua use_inventory_item(149003,0,40)",
      "/dolua use_inventory_item(320155,0,6)",
      "/dolua use_inventory_item(320152,0,5)",
      "/dolua use_inventory_item(17756,0,15)"
    }
  end
  for idx, cmd in ipairs(cmd_list) do
    ToClient_ChatProcess(tostring(cmd))
  end
end
function use_inventory_item(itemkey, enchant_level, loop)
  if enchant_level == nil then
    enchant_level = 0
  end
  if loop == nil then
    loop = 1
  end
  Proc_ShowMessage_Ack("enchant" .. tostring(enchant_level) .. "loop" .. tostring(loop))
  for i = 1, loop do
    luaTimer_AddEvent(ToClient_qaUseInventoryItem, 5000 + i * 500, false, 0, itemkey, enchant_level)
  end
end
function questcondition(QuestKey, Start, End)
  if End == nil then
    ToClient_ChatProcess("/QuestCondition " .. QuestKey .. " " .. Start)
  else
    for i = Start, End do
      ToClient_ChatProcess("/QuestCondition " .. QuestKey .. " " .. i)
    end
  end
end
function questclear(QuestKey, Start, End)
  if End == nil then
    ToClient_ChatProcess("/QuestClear " .. QuestKey .. " " .. Start)
  else
    for i = Start, End do
      ToClient_ChatProcess("/QuestClear " .. QuestKey .. " " .. i)
    end
  end
end
