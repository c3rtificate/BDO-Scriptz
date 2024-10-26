PaGlobal_ElfWarMiniMapPartyList = {
  _ui = {
    _stc_titleArea = UI.getChildControl(Panel_ElfWar_MiniMapPartyList, "Static_TitleArea"),
    _stc_alphaSlider = nil,
    _btn_alphaSlider = nil,
    _btn_close = nil,
    _chk_simpleMode = UI.getChildControl(Panel_ElfWar_MiniMapPartyList, "CheckButton_SimpleMode"),
    _frm_original = UI.getChildControl(Panel_ElfWar_MiniMapPartyList, "Frame_PartyList_Original"),
    _frm_content_original = nil,
    _stc_original_guild_line = nil,
    _stc_original_mercenary_line = nil,
    _frm_simple = UI.getChildControl(Panel_ElfWar_MiniMapPartyList, "Frame_PartyList_Simple"),
    _frm_content_simple = nil,
    _stc_simple_guild_line = nil,
    _stc_simple_mercenary_line = nil,
    _stc_rClickMenu = UI.getChildControl(Panel_ElfWar_MiniMapPartyList, "Static_RClick_Menu"),
    _btn_rClickMenu_forceComplete = nil
  },
  _rClickMenuData = nil,
  _originalFrameControlPool = nil,
  _originalPoolCount = 0,
  _simpleFrameControlPool = nil,
  _simplePoolCount = 0,
  _partyDataList = nil,
  _lastAlphaSliderControlPos = 100,
  _initialize = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_MiniMapPartyList_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_MiniMapPartyList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarMiniMapPartyListInit")
function FromClient_ElfWarMiniMapPartyListInit()
  PaGlobal_ElfWarMiniMapPartyList:initialize()
end
