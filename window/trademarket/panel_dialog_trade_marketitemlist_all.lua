PaGlobal_TradeMarketItemList_All = {
  _ui = {
    _stc_TitleBar = nil,
    _txt_Title = nil,
    _list2_TradeItem_Buy = nil,
    _list2_TradeItem_Contents = nil,
    _list2_Buy_ListSlotBg = nil,
    _list2_Buy_SlotBg = nil,
    _list2_Buy_ItemPrice = nil,
    _list2_Buy_ItemName = nil,
    _list2_Buy_RemainTime = nil,
    _list2_Buy_RemainCountTitle = nil,
    _list2_Buy_RamainCountValue = nil,
    _list2_Buy_StateText = nil,
    _list2_Buy_BuyButton = nil,
    _list2_Buy_VertiScroll = nil,
    _list2_Buy_HoriScrool = nil,
    _list2_Buy_RoyalSupplyIcon = nil,
    _list2_TradeItem_Sell = nil,
    _list2_TradeItemSell_Content = nil,
    _list2_Sell_ListSlotBg = nil,
    _list2_Sell_Slot = nil,
    _list2_Sell_itemName = nil,
    _list2_Sell_itemPrice = nil,
    _list2_Sell_VetiScroll = nil,
    _list2_Sell_HoriScroll = nil,
    _list2_Sell_LeftCount = nil,
    _list2_Category = nil,
    _list2_Category_Contents = nil,
    _list2_Category_rdoButton = nil,
    _list2_Category_SupplyLeftBg = nil,
    _list2_Category_SupplyLeftTitle = nil,
    _list2_Category_SupplyLeftValue = nil,
    _list2_slotBg = nil,
    _list2_slotBg_Icon = {},
    _stc_KeyGuides = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_X = nil,
    _stc_KeyGuide_B = nil,
    _categoryBtnGroups = {}
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true
  },
  _commerceStringTable = {
    [enCommerceType.enCommerceType_Luxury_Miscellaneous] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_MISCELL"),
    [enCommerceType.enCommerceType_Luxury] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_LUXURY"),
    [enCommerceType.enCommerceType_Grocery] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_GROCERY"),
    [enCommerceType.enCommerceType_Cloth] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_GRAPH_BTN_CLOTH"),
    [enCommerceType.enCommerceType_ObjectSaint] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_OBJECT"),
    [enCommerceType.enCommerceType_MilitarySupplies] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_GRAPH_BTN_MILITARYSUPPLIES"),
    [enCommerceType.enCommerceType_Medicine] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_MEDICINE"),
    [enCommerceType.enCommerceType_SeaFood] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_SEAFOOD"),
    [enCommerceType.enCommerceType_RawMaterial] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_GRAPH_BTN_RAWMATERIAL"),
    [enCommerceType.enCommerceType_Max] = PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_GRAPH_BTN_ALL")
  },
  _currentCategoryIdx = nil,
  _currentCategoryBtnCount = 0,
  _currentNpcType = nil,
  _originPanelSizeY = 0,
  _originlist2_Sell = 0,
  _originlist2_Buy = 0,
  _itemSlotTable = {},
  _itemKeyTable = {},
  _shopItemIndexTable = {},
  _currentItemKeyForTrendPriceView = nil,
  _isFishingSupply = false,
  _initialize = false,
  _isConsole = false,
  _currShopType = nil
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MarketItemList_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MarketItemList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Trade_MarketItemList_All_init")
function FromClient_Trade_MarketItemList_All_init()
  PaGlobal_TradeMarketItemList_All:initialize()
end
