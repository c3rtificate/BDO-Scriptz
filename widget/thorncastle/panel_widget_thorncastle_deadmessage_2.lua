function PaGlobal_FromClient_Widget_ThornCastle_SetDead(killerActorKey, reviveCoolTime)
  if false == PaGlobal_ThornCastle_DeadMessage._initialize then
    return
  end
  PaGlobal_ThornCastle_DeadMessage:prepareOpen(killerActorKey, reviveCoolTime)
end
function PaGlobal_FromClient_Widget_ThornCastle_SetRevive()
  if false == PaGlobal_ThornCastle_DeadMessage._initialize then
    return
  end
  PaGlobal_ThornCastle_DeadMessage:prepareClose()
end
function HandleEventLUp_Widget_ThornCastle_Reqest_Revive()
  deadMessage_Revival(__eRespawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false, false, 0, __eElfWarRespawnPositionType_Count, false, 0)
end
