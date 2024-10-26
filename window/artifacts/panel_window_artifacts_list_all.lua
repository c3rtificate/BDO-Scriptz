PaGlobal_Artifacts_List_All = {
  _ui = {
    stc_search = nil,
    txt_search = nil,
    btn_search = nil,
    frame_item = nil,
    frame_content = nil,
    frame_vscroll = nil,
    frame_list = {},
    btn_radio = nil,
    stc_titleIcon = nil,
    txt_title = nil,
    stc_line = nil,
    stc_slotBg = nil,
    stc_itemSlot = {}
  },
  _ui_pc = {btn_close = nil},
  _ui_console = {stc_guide = nil},
  _listCount = 0,
  _nextY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_List_All_1.lua")
runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Artifacts_List_All_Init")
function FromClient_Artifacts_List_All_Init()
  PaGlobal_Artifacts_List_All:initialize()
end
