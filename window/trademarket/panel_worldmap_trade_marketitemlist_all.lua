PaGlobal_WorldMap_TradeItemList_All = {
  _ui = {
    _stc_TitleBar = nil,
    _txt_Title = nil,
    _stc_TabGroup = nil,
    _rdo_Tab_Buy = nil,
    _rdo_Tab_Sell = nil,
    _stc_Selected_Line = nil,
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
    _list2_Buy_VertiScroll = nil,
    _list2_Buy_HoriScrool = nil,
    _list2_Buy_RoyalSupplyIcon = nil,
    _list2_Buy_GraphBg = nil,
    _list2_Buy_GraphLow = nil,
    _list2_Buy_GraphHigh = nil,
    _list2_Buy_GraphCurrnet = nil,
    _list2_Buy_GraphCenter = nil,
    _list2_TradeItem_Sell = nil,
    _list2_TradeItemSell_Content = nil,
    _list2_Sell_ListSlotBg = nil,
    _list2_Sell_Slot = nil,
    _list2_Sell_itemName = nil,
    _list2_Sell_itemPrice = nil,
    _list2_Sell_VetiScroll = nil,
    _list2_Sell_HoriScroll = nil,
    _list2_Sell_GraphBg = nil,
    _list2_Sell_GraphLow = nil,
    _list2_Sell_GraphHigh = nil,
    _list2_Sell_GraphCurrnet = nil,
    _list2_Sell_GraphCenter = nil,
    _list2_Category = nil,
    _list2_Category_Contents = nil,
    _list2_Category_rdoButton = nil,
    _stc_KeyGuides = nil,
    _stc_KeyGuide_B = nil,
    _categoryBtnGroups = {},
    _tabBtnGroups = {},
    _keyguide = {}
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
  _maxPricePosX = -1,
  _minPricePosX = -1,
  _maxPricePosY = 0,
  _minPricePosY = 9999999,
  _graphIntervalValue = 8,
  _currentTab = 0,
  _currentCategoryIdx = nil,
  _currentCategoryBtnCount = 0,
  _currentNpcType = nil,
  _itemKeyTable = {},
  _shopItemIndexTable = {},
  _itemSlotTable = {},
  _isNodeLinked = false,
  _buyFromNPCOrSellToNPCOrAll = 3,
  _currentCommerce = {_index = nil, _size = nil},
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All_1.lua")
runLua("UI_Data/Script/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_TradeItemList_All_Init")
function FromClient_WorldMap_TradeItemList_All_Init()
  PaGlobal_WorldMap_TradeItemList_All:initialize()
end
