function PaGlobal_ImperialSupplyMSG_Open()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ImperialSupplyMSG:prepareOpen()
  PaGlobal_ServantList_All:subMenuClose()
  PaGlobal_ImperialSupplyMSG:update()
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
