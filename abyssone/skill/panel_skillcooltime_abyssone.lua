Panel_CoolTime_Effect:SetShow(false, false)
Panel_SkillCooltime:SetShow(true)
Panel_SkillCooltime:SetIgnore(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local EmergencySkillKey = 6029313
Panel_CoolTime_Effect:RegisterShowEventFunc(true, "SkillCoolTime_Effect_HideAni()")
function SkillCoolTime_Effect_HideAni()
  Panel_CoolTime_Effect:SetShowWithFade(UI_PSFT.PAUI_ANI_TYPE_FADE_OUT)
  local coolTime = Panel_CoolTime_Effect:addColorAnimation(0, 0.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  coolTime:SetStartColor(UI_color.C_FFFFFFFF)
  coolTime:SetEndColor(UI_color.C_00FFFFFF)
  coolTime:SetStartIntensity(3)
  coolTime:SetEndIntensity(1)
  coolTime.IsChangeChild = true
  coolTime:SetHideAtEnd(true)
  coolTime:SetDisableWhileAni(true)
end
local skillCooltime = {
  config = {
    slotGapX = 50,
    slotGapY = 50,
    screenPosX = 0.33,
    screenPosY = 0.42
  },
  slotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  slots = {},
  slots_description = {},
  slotPool = Array.new(),
  slotPool_desc = Array.new(),
  slotCount = 0,
  slotCount_desc = 0,
  textRemainTime = 1.5,
  textTemplate = UI.getChildControl(Panel_SkillCooltime, "StaticText_CoolTimeTitle")
}
local showToggle = true
function skillCooltime:createNewSlot()
  self.slotCount = self.slotCount + 1
  local slot = {}
  SlotSkill.new(slot, self.slotCount, Panel_SkillCooltime, self.slotConfig)
  slot.icon:SetIgnore(true)
  slot.iconBg = UI.createAndCopyBasePropertyControl(Panel_SkillCooltime, "Static_Icon_GuildSkillBG", slot.icon, "GuildSkillCoolTimeBG_" .. self.slotCount)
  slot.iconBg:SetPosX(slot.icon:GetPosX() - 6)
  slot.iconBg:SetPosY(slot.icon:GetPosY() - 6)
  return slot
end
function skillCooltime:createNewSlot_Desc()
end
function skillCooltime:getSlot()
  if 0 < self.slotPool:length() then
    return self.slotPool:pop_back()
  else
    return self:createNewSlot()
  end
end
local skillReuseTime
function SkillCooltime_Add(TSkillKey, TSkillNo)
  local isPlayingReplay = ToClient_IsPlayingReplay()
  if true == isPlayingReplay then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper or true == skillTypeStaticWrapper:isGuildSkill() then
    return
  end
  local self = skillCooltime
  local slot = self.slots[TSkillKey]
  if nil == slot then
    slot = self:getSlot()
    self.slots[TSkillKey] = slot
  end
  slot.iconBg:SetShow(false)
  local slotDesc = self.slots_description[TSkillKey]
  if nil == slotDesc then
    slotDesc = {
      remainTime = self.textRemainTime,
      skillNo = TSkillNo
    }
    self.slots_description[TSkillKey] = slotDesc
  end
  local isReplayObserver = ToClient_IsReplayObserver()
  local level = 0
  if true == isReplayObserver then
    level = 1
  else
    level = getLearnedSkillLevel(skillTypeStaticWrapper)
  end
  local skillSS = getSkillStaticStatus(TSkillNo, level)
  if nil == skillSS then
    return
  end
  skillReuseTime = skillSS:get()._reuseCycle / 1000
  slot:clearSkill()
  slot:setSkillTypeStatic(skillTypeStaticWrapper)
  slotDesc.remainTime = self.textRemainTime
  if true == _ContentsGroup_SkillEffect and nil ~= Panel_SkillCommand and nil ~= SkillCommand_SetSkillShow then
    SkillCommand_SetSkillShow(TSkillNo, false)
  end
end
function SkillCooltime_OnResize()
  local self = skillCooltime
  local sizeX = getOriginScreenSizeX()
  local sizeY = getOriginScreenSizeY()
  Panel_SkillCooltime:SetPosX(sizeX * self.config.screenPosX)
  Panel_SkillCooltime:SetPosY(sizeY * self.config.screenPosY)
  FGlobal_PanelRepostionbyScreenOut(Panel_SkillCooltime)
end
function SkillCooltime_UpdatePerFrame(deltaTime)
  if false == showToggle then
    return
  end
  local self = skillCooltime
  local remainTime = 0
  local row = 0
  local col = 0
  local count = 0
  local readyCount = 0
  for tSkillKey, slot_desc in pairs(self.slots_description) do
    local slot = self.slots[tSkillKey]
    local isReplayObserver = ToClient_IsReplayObserver()
    if false == isReplayObserver then
      remainTime = getSkillCooltime(tSkillKey)
    else
      remainTime = ToClient_getOtherSkillCooltimeForReplay(ToClient_getObserverPlayerActorKey(), tSkillKey)
    end
    local realRemainTime = 0
    local intRemainTime = 0
    local skillReuseTime = 0
    local skillStaticWrapper = getSkillStaticStatus(slot_desc.skillNo, 1)
    if nil ~= skillStaticWrapper then
      skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
    end
    local isEmmergencySkill = false
    if EmergencySkillKey == tSkillKey then
      local selfPlayer = getSelfPlayer()
      if nil ~= selfPlayer then
        remainTime = Int64toInt32(selfPlayer:get():getEmergencyAvoidReusable()) / 1000
        isEmmergencySkill = true
      end
    end
    if 0 < slot_desc.remainTime then
      row = count % 2
      col = math.floor(count / 2)
    end
    if remainTime > 0 and nil ~= slot then
      slot.icon:SetShow(true)
      local updateCoolTimeValue = remainTime
      if true == isEmmergencySkill then
        updateCoolTimeValue = remainTime / skillReuseTime
      end
      slot.cooltime:UpdateCoolTime(updateCoolTimeValue)
      slot.cooltime:SetShow(true)
      realRemainTime = remainTime * skillReuseTime
      intRemainTime = realRemainTime - realRemainTime % 1 + 1
      if true == isEmmergencySkill then
        realRemainTime = remainTime
        intRemainTime = remainTime
      end
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if skillReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
      slot:setPos(col * self.config.slotGapX, row * self.config.slotGapY)
    elseif nil ~= slot then
      slot.icon:SetShow(false)
      local slotPosX = slot.icon:GetParentPosX()
      local slotPosY = slot.icon:GetParentPosY()
      audioPostEvent_SystemUi(2, 1)
      _AudioPostEvent_SystemUiForXBOX(2, 1)
      Panel_CoolTime_Effect:SetShow(true, true)
      Panel_CoolTime_Effect:SetIgnore(true)
      Panel_CoolTime_Effect:AddEffect("fUI_Light", false, 0, 0)
      Panel_CoolTime_Effect:SetPosX(slotPosX - 5)
      Panel_CoolTime_Effect:SetPosY(slotPosY - 5)
      slot:clearSkill()
      self.slotPool:push_back(slot)
      self.slots[tSkillKey] = nil
      if true == _ContentsGroup_SkillEffect and nil ~= Panel_SkillCommand and nil ~= SkillCommand_SetSkillShow then
        SkillCommand_SetSkillShow(slot_desc.skillNo, true)
      end
    end
    if nil == self.slots[tSkillKey] then
      slot_desc.remainTime = slot_desc.remainTime - deltaTime
    end
    if 0 < slot_desc.remainTime then
      count = count + 1
    end
  end
end
function SkillCooltime_Reload()
  local coolTimeSkillList = getCoolTimeSkillList()
  if nil ~= coolTimeSkillList then
    for index = 0, coolTimeSkillList:size() - 1 do
      local skillInfo = coolTimeSkillList:atPointer(index)
      local skillKey = skillInfo._skillKey:get()
      local skillNo = skillInfo._skillKey:getSkillNo()
      SkillCooltime_Add(skillKey, skillNo)
    end
  end
end
function FromClient_SkillCoolTime_DecreaseSkillCooltime(skillNo)
  for tSkillKey, slot_desc in pairs(skillCooltime.slots_description) do
    if skillNo == slot_desc.skillNo then
      local slot = skillCooltime.slots[tSkillKey]
      if nil ~= slot and nil ~= slot.cooltimeText then
        slot.cooltimeText:EraseAllEffect()
        slot.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
        break
      end
    end
  end
end
function FromClient_SkillCoolTime_DecreaseAllSkillCooltime(exceptSkillNo)
  if nil == skillCooltime then
    return
  end
  for tSkillKey, slot_desc in pairs(skillCooltime.slots_description) do
    if exceptSkillNo ~= slot_desc.skillNo then
      local slot = skillCooltime.slots[tSkillKey]
      if nil ~= slot and nil ~= slot.cooltimeText then
        local skillStaticWrapper = getSkillStaticStatus(slot_desc.skillNo, 1)
        if nil ~= skillStaticWrapper and false == skillStaticWrapper:isExceptCoolTime() and EmergencySkillKey ~= skillStaticWrapper:getKey() then
          slot.cooltimeText:EraseAllEffect()
          slot.cooltimeText:AddEffect("fUI_SkillCoolTime_01A", false, 0, 0)
        end
      end
    end
  end
end
function skillCooltime:registEventHandler()
  Panel_SkillCooltime:RegisterUpdateFunc("SkillCooltime_UpdatePerFrame")
end
function FromClient_SkillCoolTime_luaLoadComplete()
  Panel_SkillCooltime:SetShow(true)
end
function skillCooltime:registMessageHandler()
  registerEvent("EventSkillCooltime", "SkillCooltime_Add")
  registerEvent("onScreenResize", "SkillCooltime_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "SkillCooltime_OnResize")
  registerEvent("FromClient_luaLoadComplete", "FromClient_SkillCoolTime_luaLoadComplete")
  registerEvent("FromClient_DecreaseSkillCooltime", "FromClient_SkillCoolTime_DecreaseSkillCooltime")
  registerEvent("FromClient_DecreaseAllSkillCooltime", "FromClient_SkillCoolTime_DecreaseAllSkillCooltime")
end
SkillCooltime_Reload()
skillCooltime:registEventHandler()
skillCooltime:registMessageHandler()
function Panel_SkillCooltime_ShowToggle()
  local isShow = Panel_SkillCooltime:IsShow()
  if isShow then
    showToggle = false
    Panel_SkillCooltime:SetShow(false, false)
  else
    showToggle = true
    Panel_SkillCooltime:SetShow(true, true)
  end
end
registerEvent("FromClient_RenderModeChangeState", "SkillCooltime_OnResize")
