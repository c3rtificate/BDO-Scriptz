PaGlobal_SpecialPass = {
  _ui = {
    stc_TitleArea = nil,
    stc_Title = nil,
    btn_Close = nil,
    stc_MainBG = nil,
    stc_ImageFont = nil,
    txt_Date = nil,
    btn_PearlShop = nil,
    btn_SpiritBox = nil,
    txt_Day = nil,
    list2 = nil,
    list2_Content = nil,
    stc_ProductBG = nil,
    stc_BottomDesc = nil,
    txt_Desc = nil,
    txt_RateView = nil,
    stc_KeyGuideConsole = nil,
    stc_B_Button = nil,
    stc_A_Button = nil,
    stc_X_Button = nil,
    stc_Y_Button = nil,
    stc_LTA_Button = nil
  },
  _itemList = {},
  _totalRewardOpenFlag = false,
  _currentRewardIndex = 0,
  _currentPassRewardIndex = 0,
  _maxRewardIndex = 0,
  _itemCount = 0,
  _isPassUser = false,
  _rowCount = 7,
  _isPurchasablePassItem = false,
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_SpecialPass_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_SpecialPass_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SpecialPassInit")
function FromClient_SpecialPassInit()
  PaGlobal_SpecialPass:initialize()
end
