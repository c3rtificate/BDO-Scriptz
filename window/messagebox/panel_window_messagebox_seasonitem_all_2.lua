function PaGlobalFunc_MessageBox_SeasonItem_All_Open()
  PaGlobal_MessageBox_SeasonItem_All:prepareOpen()
end
function PaGlobalFunc_MessageBox_SeasonItem_All_Close()
  PaGlobal_MessageBox_SeasonItem_All:prepareClose()
end
function HandleEventLUp_MessageBox_SeasonItem_All_Close()
  PaGlobalFunc_MessageBox_SeasonItem_All_Close()
end
function FromClient_MessageBox_SeasonItem_All_OnScreenResize()
  PaGlobal_MessageBox_SeasonItem_All:resize()
end
