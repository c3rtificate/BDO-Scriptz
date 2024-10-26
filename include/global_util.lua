Util = {}
local _math_floor = math.floor
local _math_sin = math.sin
local _math_cos = math.cos
local _math_pi = math.pi
local _math_sqrt = math.sqrt
local _math_atan2 = math.atan2
local function _time_Formatting(second)
  local formatter = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  }
  if second == 0 then
    return tostring(0) .. formatter[0]
  end
  local timeVal = {}
  timeVal[0] = second
  timeVal[1] = _math_floor(timeVal[0] / 60)
  timeVal[0] = timeVal[0] - timeVal[1] * 60
  timeVal[2] = _math_floor(timeVal[1] / 60)
  timeVal[1] = timeVal[1] - timeVal[2] * 60
  timeVal[3] = _math_floor(timeVal[2] / 24)
  timeVal[2] = timeVal[2] - timeVal[3] * 24
  local resultString = ""
  for i = 0, 3 do
    local isNone = true
    for j = i, 3 do
      if timeVal[j] > 0 then
        isNone = false
      end
    end
    if isNone == true then
      break
    end
    if 0 < string.len(resultString) then
      resultString = " " .. resultString
    end
    if timeVal[i] > 0 then
      resultString = tostring(timeVal[i]) .. formatter[i] .. resultString
    end
  end
  return resultString
end
local function _time_Formatting_Minute(second)
  local formatter = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  }
  if second < 60 then
    return " 0" .. formatter[1]
  end
  local timeVal = {}
  timeVal[0] = second
  timeVal[1] = _math_floor(timeVal[0] / 60)
  timeVal[0] = timeVal[0] - timeVal[1] * 60
  timeVal[2] = _math_floor(timeVal[1] / 60)
  timeVal[1] = timeVal[1] - timeVal[2] * 60
  timeVal[3] = _math_floor(timeVal[2] / 24)
  timeVal[2] = timeVal[2] - timeVal[3] * 24
  local resultString = ""
  for i = 1, 3 do
    if 0 < string.len(resultString) then
      resultString = " " .. resultString
    end
    if timeVal[i] > 0 then
      resultString = tostring(timeVal[i]) .. formatter[i] .. resultString
    end
  end
  return resultString
end
local u64_Zero = Defines.u64_const.u64_0
local u64_1000 = Defines.u64_const.u64_1000
local u64_Hour = toUint64(0, 3600)
local u64_Minute = toUint64(0, 60)
local function _time_Formatting_ShowTop(second_u64)
  if second_u64 > u64_Hour * toInt64(0, 2) then
    local recalc_time = second_u64 / u64_Hour
    local strHour = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", strHour)
  elseif second_u64 > u64_Minute then
    local recalc_time = second_u64 / u64_Minute
    local strMinute = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", strMinute)
  else
    local recalc_time = second_u64
    local strSecond = string.format("%d", Int64toInt32(recalc_time))
    return PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", strSecond)
  end
end
local function _time_GameTimeFormatting(inGameMinute)
  local clockMinute = inGameMinute % 60
  local clockHour = _math_floor(inGameMinute / 60)
  local calcMinute = "00"
  if clockMinute < 10 then
    calcMinute = "0" .. clockMinute
  else
    calcMinute = "" .. clockMinute
  end
  local calcHour = ""
  if clockHour < 12 or clockHour == 24 then
    calcHour = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_MORNING") .. " "
  else
    calcHour = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_TIME_AFTERNOON") .. " "
  end
  if clockHour > 12 then
    clockHour = clockHour - 12
  end
  calcHour = calcHour .. tostring(clockHour) .. " : " .. calcMinute
  return calcHour
end
Util.Time = {
  timeFormatting = _time_Formatting,
  timeFormatting_Minute = _time_Formatting_Minute,
  inGameTimeFormatting = _time_GameTimeFormatting,
  inGameTimeFormattingTop = _time_Formatting_ShowTop
}
local oneDay = 86400
local utcTimeWeekDayOffset = 4
local monthDays = {
  31,
  28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
}
local dateTime = {
  _year = 0,
  _month = 0,
  _day = 0,
  _hour = 0,
  _minute = 0,
  _second = 0,
  _week = 0,
  _weekday = 0
}
function getQuotient(divisor, dividend)
  local quotient = 0
  while dividend > 0 do
    dividend = dividend - divisor
    if dividend >= 0 then
      quotient = quotient + 1
    end
  end
  return quotient
end
function timestampToWeekday(second)
  local result = (getQuotient(oneDay, second) + utcTimeWeekDayOffset) % 7
  if result == 0 then
    result = 7
  end
  return result
end
function isLeapYear(year)
  if year % 4 == 0 and year % 100 ~= 0 or year % 400 == 0 then
    return true
  else
    return false
  end
end
function utcTimestampToDate(timestamp, isTimeZone)
  local tempTime = {
    _year = 0,
    _month = 0,
    _day = 0,
    _hour = 0,
    _minute = 0,
    _second = 0,
    _week = 0,
    _weekday = 0
  }
  local temp = 0
  local month = 0
  local days = 0
  local daysInYear = 0
  local year = 0
  local secondInDay = 0
  if true == isTimeZone then
    timestamp = timestamp + getTimeZoneForLua()
  end
  secondInDay = timestamp % oneDay
  tempTime._second = secondInDay % 60
  secondInDay = getQuotient(60, secondInDay)
  tempTime._minute = secondInDay % 60
  secondInDay = getQuotient(60, secondInDay)
  tempTime._hour = secondInDay % 24
  days = getQuotient(oneDay, timestamp)
  for i = 1970, 2200 do
    if true == isLeapYear(i) then
      daysInYear = 366
    else
      daysInYear = 365
    end
    if days >= daysInYear then
      days = days - daysInYear
    else
      year = i
      break
    end
  end
  tempTime._year = year
  tempTime._weekday = timestampToWeekday(timestamp)
  tempTime._week = getQuotient(7, days + 11 - tempTime._weekday)
  if true == isLeapYear(tempTime._year) then
    monthDays[2] = 29
  else
    monthDays[2] = 28
  end
  for j = 1, 12 do
    if days >= monthDays[j] then
      days = days - monthDays[j]
    else
      month = j
      break
    end
  end
  tempTime._month = month
  tempTime._day = days + 1
  return tempTime
end
local _math_calculateCross = function(lho, rho)
  local v = {}
  return float3(lho.y * rho.z - lho.z * rho.y, lho.z * rho.x - lho.x * rho.z, lho.x * rho.y - lho.y * rho.x)
end
local _math_calculateDot = function(lho, rho)
  return lho.x * rho.x + lho.y * rho.y + lho.z * rho.z
end
local function _math_calculateLength(vector)
  return _math_sqrt(_math_calculateDot(vector, vector))
end
local function _math_calculateDistance(from, to)
  return _math_calculateLength(float3(from.x - to.x, from.y - to.y, from.z - to.z))
end
local function _math_calculateNormalVector(vector)
  local len = _math_calculateLength(vector)
  return float3(vector.x / len, vector.y / len, vector.z / len)
end
local function _math_calculateSpinVector(axis, radian)
  local axisCorss = _math_calculateCross({
    x = 0,
    y = 1,
    z = 0
  }, axis)
  local axisUp = _math_calculateCross(axisCorss, axis)
  return _math_calculateNormalVector(float3(axisCorss.x * -_math_cos(radian) + axisUp.x * -_math_sin(radian), axisCorss.y * -_math_cos(radian) + axisUp.y * -_math_sin(radian), axisCorss.z * -_math_cos(radian) + axisUp.z * -_math_sin(radian)))
end
local _math_lerp = function(from, to, factor)
  return from * (1 - factor) + to * factor
end
local function _math_lerpVector(from, to, factor)
  return float3(_math_lerp(from.x, to.x, factor), _math_lerp(from.y, to.y, factor), _math_lerp(from.z, to.z, factor))
end
local function _math_calculateDirection(from, to)
  return _math_calculateNormalVector(float3(to.x - from.x, to.y - from.y, to.z - from.z))
end
local function _math_convertRotationToDirection(radian)
  return {
    x = -_math_sin(radian),
    y = 0,
    z = -_math_cos(radian)
  }
end
local function _math_convertDirectionToRotation(dir)
  return (_math_atan2(-dir.x, -dir.z))
end
local function _math_radianFix(radian)
  local fixRadian = radian
  if fixRadian < 0 then
    local nDivide = _math_floor(-fixRadian / (_math_pi * 2)) + 1
    fixRadian = fixRadian + nDivide * _math_pi * 2
  else
    local nDivide = _math_floor(fixRadian / (_math_pi * 2)) + 1
    fixRadian = fixRadian - nDivide * _math_pi * 2
  end
  return fixRadian
end
local function _math_calculateSinCurve(startPoint, endPoint, offset, height, rotate, lerpFactor)
  local SunHeight = _math_sin(lerpFactor * _math_pi)
  local resultPoint = float3(0, 0, 0)
  resultPoint.x = _math_lerp(startPoint.x, endPoint.x, lerpFactor)
  resultPoint.y = _math_lerp(startPoint.y, endPoint.y, lerpFactor)
  resultPoint.z = _math_lerp(startPoint.z, endPoint.z, lerpFactor)
  local spinAxis = _math_calculateDirection(endPoint, startPoint)
  spinAxis = _math_calculateSpinVector(spinAxis, _math_pi * rotate)
  resultPoint.x = resultPoint.x + offset.x + spinAxis.x * SunHeight * height
  resultPoint.y = resultPoint.y + offset.y + spinAxis.y * SunHeight * height
  resultPoint.z = resultPoint.z + offset.z + spinAxis.z * SunHeight * height
  return resultPoint
end
local _math_AddVectorToVector = function(lho, rho)
  return float3(lho.x + rho.x, lho.y + rho.y, lho.z + rho.z)
end
local _math_AddNumberToVector = function(lho, rho)
  return float3(lho.x + rho, lho.y + rho, lho.z + rho)
end
local _math_MulNumberToVector = function(lho, rho)
  return float3(lho.x * rho, lho.y * rho, lho.z * rho)
end
local function _math_calculateSinCurveList(startPoint, endPoint, offset, height, rotate, lerpCount)
  local spinAxis = _math_calculateDirection(endPoint, startPoint)
  spinAxis = _math_calculateSpinVector(spinAxis, _math_pi * rotate)
  local resultPointList = {}
  local lerpFactor
  for i = 0, lerpCount do
    lerpFactor = i / lerpCount
    resultPointList[i] = _math_AddVectorToVector(_math_AddVectorToVector(offset, _math_lerpVector(startPoint, endPoint, lerpFactor)), _math_MulNumberToVector(spinAxis, _math_sin(lerpFactor * _math_pi) * height))
  end
  return resultPointList
end
Util.Math = {
  calculateCross = _math_calculateCross,
  calculateDot = _math_calculateDot,
  calculateLength = _math_calculateLength,
  calculateDistance = _math_calculateDistance,
  calculateNormalVector = _math_calculateNormalVector,
  calculateSpinVector = _math_calculateSpinVector,
  Lerp = _math_lerp,
  LerpVector = _math_lerpVector,
  calculateDirection = _math_calculateDirection,
  convertRotationToDirection = _math_convertRotationToDirection,
  convertDirectionToRotation = _math_convertDirectionToRotation,
  radianFix = _math_radianFix,
  calculateSinCurve = _math_calculateSinCurve,
  AddVectorToVector = _math_AddVectorToVector,
  AddNumberToVector = _math_AddNumberToVector,
  MulNumberToVector = _math_MulNumberToVector,
  calculateSinCurveList = _math_calculateSinCurveList
}
local _table_sizeofDictionary = function(dictionary)
  local size = 0
  for key, values in pairs(dictionary) do
    size = size + 1
  end
  return size
end
local _table_isEmptyDictionary = function(dictionary)
  for key, values in pairs(dictionary) do
    return false
  end
  return true
end
local _table_fill = function(_table, _start, _end, _value)
  for ii = _start, _end do
    _table[ii] = _value
  end
end
Util.Table = {
  sizeofDictionary = _table_sizeofDictionary,
  isEmptyDictionary = _table_isEmptyDictionary,
  fill = _table_fill
}
Array = {}
Array.__index = Array
function Array.new()
  local arr = {}
  setmetatable(arr, Array)
  return arr
end
function Array:resize(_size, _value)
  if _size > #self then
    _table_fill(self, #self + 1, _size, _value)
  elseif _size < #self then
    _table_fill(self, _size + 1, #self, nil)
  end
end
function Array:fill(from, to, iter)
  local ii = 1
  iter = iter or 1
  for value = from, to, iter do
    self[ii] = value
    ii = ii + 1
  end
end
function Array:printi(f)
  f = f or print
  for k, v in ipairs(self) do
    f(v)
  end
end
function Array:length()
  return #self
end
function Array:push_back(msg)
  self[self:length() + 1] = msg
end
function Array:pop_back()
  local length = self:length()
  local v = self[length]
  self[length] = nil
  return v
end
function Array:pop_front()
  if 0 < self:length() then
    local tmp, _length
    tmp = self[1]
    _length = self:length()
    for ii = 2, _length do
      self[ii - 1] = self[ii]
    end
    self[_length] = nil
    return tmp
  end
  return
end
function Array:toString(deliminator)
  deliminator = deliminator or "\n"
  local tmpStr = ""
  for k, v in ipairs(self) do
    tmpStr = tmpStr .. v .. deliminator
  end
  return tmpStr
end
function Array:quicksort(f)
  if "function" ~= type(f) then
    return
  end
  self.compFunc = f
  self:_quicksort(1, #self)
  self.compFunc = nil
end
function Array:_quicksort(is, ie)
  local mid = self:_sortPartition(is, ie)
  if is < mid then
    self:_quicksort(is, mid - 1)
  end
  if ie > mid then
    self:_quicksort(mid + 1, ie)
  end
end
function Array:_sortPartition(is, ie)
  local ir = _math_floor((is + ie) / 2)
  self[ir], self[ie] = self[ie], self[ir]
  local i, j = is - 1, is
  while ie > j do
    if 0 < self.compFunc(self[j], self[ie]) then
      i = i + 1
      self[i], self[j] = self[j], self[i]
    end
    j = j + 1
  end
  self[i + 1], self[ie] = self[ie], self[i + 1]
  return i + 1
end
local __string_find = string.find
local __string_sub = string.sub
local __string_len = string.len
function string.split(str, pattern)
  local pattern_length = __string_len(pattern)
  local str_length = __string_len(str)
  if pattern_length <= 0 or pattern_length > str_length then
    return {str}
  end
  local fStart, fEnd
  local index = 1
  local ii = 1
  local res = {}
  while true do
    if str_length < index then
      break
    end
    fStart, fEnd = __string_find(str, pattern, index, true)
    if nil == fStart then
      res[ii] = __string_sub(str, index, str_length)
      break
    end
    res[ii] = __string_sub(str, index, fStart - 1)
    index = fEnd + 1
    ii = ii + 1
  end
  return res
end
function string.wlen(str)
  local len = string.len(str)
  local strwLen = 1
  local retVal = 0
  local byteVal = ""
  while len >= strwLen do
    byteVal = string.byte(str, strwLen)
    if byteVal >= 128 then
      strwLen = strwLen + 2
    else
      strwLen = strwLen + 1
    end
    retVal = retVal + 1
  end
  return retVal
end
function GlobalExitGameClient()
  exitGameClient(true)
end
function converStringFromLeftDateTime(s64_datetime)
  local leftDate = getLeftSecond_TTime64(s64_datetime)
  return convertStringFromDatetime(leftDate)
end
function convertStringFromDatetime(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local s64_minute = (s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle
  local s64_Second = s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 and s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. " " .. tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  elseif s64_Second >= Defines.s64_const.s64_0 then
    strDate = tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  else
    strDate = ""
  end
  return strDate
end
function convertStringFromDatetimeType2(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local s64_minute = (s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle
  local s64_Second = s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 and s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > Defines.s64_const.s64_0 then
    if s64_minute < toInt64(0, 10) then
      strDate = "0"
    end
    strDate = strDate .. tostring(s64_minute) .. " : "
    if s64_Second < toInt64(0, 10) then
      strDate = strDate .. "0"
    end
    strDate = strDate .. tostring(s64_Second)
  elseif s64_Second >= Defines.s64_const.s64_0 then
    strDate = "00 : "
    if s64_Second < toInt64(0, 10) then
      strDate = strDate .. "0"
    end
    strDate = strDate .. tostring(s64_Second)
  else
    strDate = ""
  end
  return strDate
end
function convertStringFromDatetimeType3(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local s64_minute = (s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 and s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  else
    strDate = "0" .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  end
  return strDate
end
function convertStringFromDatetimeAll(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local s64_minute = (s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle
  local s64_Second = s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 and s64_hour > Defines.s64_const.s64_0 and s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_day > Defines.s64_const.s64_0 and s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. " " .. tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  elseif s64_Second >= Defines.s64_const.s64_0 then
    strDate = tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  else
    strDate = ""
  end
  return strDate
end
function convertStringFromDatetimeAllByHour(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local s64_minute = (s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle
  local s64_Second = s64_datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local strDate = ""
  if s64_hour > Defines.s64_const.s64_0 and s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour + toInt64(0, 24) * s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " " .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. " " .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > Defines.s64_const.s64_0 then
    strDate = tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  elseif s64_Second >= Defines.s64_const.s64_0 then
    strDate = tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  else
    strDate = ""
  end
  return strDate
end
function convertStringFromDatetimeForSkillTooltip(datetime)
  local s64_dayCycle = 86400
  local s64_hourCycle = 3600
  local s64_minuteCycle = 60
  local s64_day = math.floor(datetime / s64_dayCycle)
  local s64_hour = math.floor((datetime - s64_dayCycle * s64_day) / s64_hourCycle)
  local s64_minute = math.floor((datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour) / s64_minuteCycle)
  local s64_Second = datetime - s64_dayCycle * s64_day - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local strDate = ""
  if s64_day > 0 and s64_hour > 0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif s64_day > 0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > 0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif s64_minute > 0 then
    strDate = tostring(s64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  elseif s64_Second >= 0 then
    strDate = tostring(s64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  else
    strDate = ""
  end
  return strDate
end
function calculateDayFromDateDay(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_day = s64_datetime / s64_dayCycle
  return s64_day
end
function convertStringFromDatetimeOverHour(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour > Defines.s64_const.s64_0 then
    strDate = tostring(s64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  else
    strDate = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR_IN")
  end
  return strDate
end
function convertStringFromDatetimeOverHourForMail(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  s64_hour = s64_hour + toInt64(0, 1)
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  else
    strDate = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBAL_INHOURTIME", "hour", tostring(s64_hour))
  end
  return strDate
end
function convertStringFromDatetimeOverHourForFriends(s64_datetime)
  local s64_dayCycle = toInt64(0, 86400)
  local s64_hourCycle = toInt64(0, 3600)
  local s64_day = s64_datetime / s64_dayCycle
  local s64_hour = (s64_datetime - s64_dayCycle * s64_day) / s64_hourCycle
  local strDate = ""
  if s64_day > Defines.s64_const.s64_0 then
    strDate = tostring(s64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
  elseif s64_hour <= toInt64(0, 24) then
    strDate = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_TODAY")
  end
  return strDate
end
function convertThirdSecondsToClockTime(seconds)
  local clockTime = ""
  local clockHours = math.floor(seconds / 3600)
  local clockMinutes = math.floor(seconds % 3600 / 60)
  local clockSeconds = seconds % 60
  if clockHours > 0 then
    if clockHours < 10 then
      clockTime = clockTime .. "0" .. tostring(clockHours)
    else
      clockTime = clockTime .. tostring(clockHours)
    end
    clockTime = clockTime .. ":"
  end
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockTime = clockTime .. "0" .. tostring(clockMinutes)
  else
    clockTime = clockTime .. tostring(clockMinutes)
  end
  clockTime = clockTime .. ":"
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockTime = clockTime .. "0" .. string.format("%.3f", clockSeconds)
  else
    clockTime = clockTime .. string.format("%.3f", clockSeconds)
  end
  return clockTime
end
function convertSecondsToClockTime(seconds)
  local clockTime = ""
  local clockHours = math.floor(seconds / 3600)
  local clockMinutes = math.floor(seconds % 3600 / 60)
  local clockSeconds = seconds % 60
  if clockHours > 0 then
    if clockHours < 10 then
      clockTime = clockTime .. "0" .. tostring(clockHours)
    else
      clockTime = clockTime .. tostring(clockHours)
    end
    clockTime = clockTime .. ":"
  end
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockTime = clockTime .. "0" .. tostring(clockMinutes)
  else
    clockTime = clockTime .. tostring(clockMinutes)
  end
  clockTime = clockTime .. ":"
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockTime = clockTime .. "0" .. tostring(clockSeconds)
  else
    clockTime = clockTime .. tostring(clockSeconds)
  end
  return clockTime
end
function convertMilliSecondsToClockTime(milliSeconds)
  local seconds = Uint64toUint32(milliSeconds / 1000)
  local clockTime = ""
  local clockHours = math.floor(seconds / 3600)
  local clockMinutes = math.floor(seconds % 3600 / 60)
  local clockSeconds = seconds % 60
  local clockMilliSeconds = Uint64toUint32(milliSeconds) % 1000
  if clockHours > 0 then
    if clockHours < 10 then
      clockTime = clockTime .. "0" .. tostring(clockHours)
    else
      clockTime = clockTime .. tostring(clockHours)
    end
    clockTime = clockTime .. ":"
  end
  if clockMinutes < 0 then
    clockMinutes = 0
  end
  if clockMinutes < 10 then
    clockTime = clockTime .. "0" .. tostring(clockMinutes)
  else
    clockTime = clockTime .. tostring(clockMinutes)
  end
  clockTime = clockTime .. ":"
  if clockSeconds < 0 then
    clockSeconds = 0
  end
  if clockSeconds < 10 then
    clockTime = clockTime .. "0" .. tostring(clockSeconds)
  else
    clockTime = clockTime .. tostring(clockSeconds)
  end
  clockTime = clockTime .. ":"
  if clockMilliSeconds < 0 then
    clockMilliSeconds = 0
  end
  if clockMilliSeconds < 10 then
    clockTime = clockTime .. "0" .. tostring(clockMilliSeconds)
  else
    clockTime = clockTime .. tostring(clockMilliSeconds)
  end
  return clockTime
end
function convertStringFromMillisecondtime(u64_Millisecondtime)
  local u64_dayCycle = toUint64(0, 86400000)
  local u64_houseCycle = toUint64(0, 3600000)
  local u64_minuteCycle = toUint64(0, 60000)
  local u64_day = u64_Millisecondtime / u64_dayCycle
  local u64_hour = (u64_Millisecondtime - u64_dayCycle * u64_day) / u64_houseCycle
  local u64_minute = (u64_Millisecondtime - u64_dayCycle * u64_day - u64_houseCycle * u64_hour) / u64_minuteCycle
  local u64_Second = (u64_Millisecondtime - u64_dayCycle * u64_day - u64_houseCycle * u64_hour - u64_minuteCycle * u64_minute) / toUint64(0, 1000)
  local strDate = ""
  if u64_day > Defines.u64_const.u64_0 then
    strDate = tostring(u64_day) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY") .. tostring(u64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
  elseif u64_hour > Defines.u64_const.u64_0 then
    strDate = tostring(u64_hour) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. tostring(u64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
  elseif u64_minute > Defines.u64_const.u64_0 then
    strDate = tostring(u64_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. tostring(u64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  elseif u64_Second > Defines.u64_const.u64_0 then
    strDate = tostring(u64_Second) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  else
    strDate = ""
  end
  return strDate
end
local UI_color = Defines.Color
local UI_CT = CppEnums.ChatType
local UI_CNT = CppEnums.EChatNoticeType
teamColorSettingList = {
  [0] = UI_color.C_FFff6922,
  UI_color.C_FF84FFF5,
  UI_color.C_FF5922a3,
  UI_color.C_FF160929,
  UI_color.C_FFfdc9c8,
  UI_color.C_FFfa5d59,
  UI_color.C_FF7c1311,
  UI_color.C_FF80b9e6,
  UI_color.C_FF55a1dd,
  UI_color.C_FF014d89,
  UI_color.C_FF003966,
  UI_color.C_FFfef2b2,
  UI_color.C_FFbea216,
  UI_color.C_FFc1f8d1,
  UI_color.C_FF09e447,
  UI_color.C_FF023912,
  UI_color.C_FFfc5b95,
  UI_color.C_FFfb2472,
  UI_color.C_FF3f091d,
  UI_color.C_FFff8f59,
  UI_color.C_FFa2a2a2,
  UI_color.C_FF000000,
  UI_color.C_FF906bc1,
  UI_color.C_FFfa6e6b,
  UI_color.C_FFa61a17,
  UI_color.C_FFa8cfee,
  UI_color.C_FF015699,
  UI_color.C_FFfee568,
  UI_color.C_FFfdd81e,
  UI_color.C_FFfd92b9
}
function FGlobal_TeamColorList(index)
  if index < 0 or index >= 30 then
    return UI_color.C_FFC4BEBE
  end
  return teamColorSettingList[index]
end
colorSettingList = {
  [0] = UI_color.C_FFd5c8e8,
  UI_color.C_FFc6b4e0,
  UI_color.C_FFac91d1,
  UI_color.C_FF906bc1,
  UI_color.C_FF8359ba,
  UI_color.C_FF5922a3,
  UI_color.C_FF43197a,
  UI_color.C_FF3c176d,
  UI_color.C_FF2c1151,
  UI_color.C_FF1e0c38,
  UI_color.C_FF160929,
  UI_color.C_FFfdc9c8,
  UI_color.C_FFfdb5b4,
  UI_color.C_FFfc9391,
  UI_color.C_FFfa6e6b,
  UI_color.C_FFfa5d59,
  UI_color.C_FFf82722,
  UI_color.C_FFba1d19,
  UI_color.C_FFa61a17,
  UI_color.C_FF7c1311,
  UI_color.C_FF550d0c,
  UI_color.C_FF3e0a09,
  UI_color.C_FFbfdcf2,
  UI_color.C_FFa8cfee,
  UI_color.C_FF80b9e6,
  UI_color.C_FF55a1dd,
  UI_color.C_FF4196d9,
  UI_color.C_FF0173cc,
  UI_color.C_FF015699,
  UI_color.C_FF014d89,
  UI_color.C_FF003966,
  UI_color.C_FF002746,
  UI_color.C_FF001d33,
  UI_color.C_FFfef5c7,
  UI_color.C_FFfef2b2,
  UI_color.C_FFfeec8f,
  UI_color.C_FFfee568,
  UI_color.C_FFfee256,
  UI_color.C_FFfdd81e,
  UI_color.C_FFbea216,
  UI_color.C_FFaa9114,
  UI_color.C_FF7e6c0f,
  UI_color.C_FF564a0a,
  UI_color.C_FF3f3608,
  UI_color.C_FFc1f8d1,
  UI_color.C_FFabf6c0,
  UI_color.C_FF84f2a3,
  UI_color.C_FF5aed84,
  UI_color.C_FF47eb75,
  UI_color.C_FF09e447,
  UI_color.C_FF07ab35,
  UI_color.C_FF069930,
  UI_color.C_FF047223,
  UI_color.C_FF034e18,
  UI_color.C_FF023912,
  UI_color.C_FFfec8dc,
  UI_color.C_FFfeb4cf,
  UI_color.C_FFfd92b9,
  UI_color.C_FFfc6ca0,
  UI_color.C_FFfc5b95,
  UI_color.C_FFfb2472,
  UI_color.C_FFbc1b55,
  UI_color.C_FFa8184c,
  UI_color.C_FF7d1239,
  UI_color.C_FF560c27,
  UI_color.C_FF3f091d,
  UI_color.C_FFffd9c8,
  UI_color.C_FFffccb4,
  UI_color.C_FFffb491,
  UI_color.C_FFff9a6b,
  UI_color.C_FFff8f59,
  UI_color.C_FFff6922,
  UI_color.C_FFbf4f19,
  UI_color.C_FFab4617,
  UI_color.C_FF7f3411,
  UI_color.C_FF57240c,
  UI_color.C_FF401a09,
  UI_color.C_FFfefefe,
  UI_color.C_FFcbcbcb,
  UI_color.C_FFa2a2a2,
  UI_color.C_FF828282,
  UI_color.C_FF656565,
  UI_color.C_FF474747,
  UI_color.C_FF323232,
  UI_color.C_FF232323,
  UI_color.C_FF181818,
  UI_color.C_FF111111,
  UI_color.C_FF000000
}
function FGlobal_ColorList(index)
  if index < 0 or index >= 88 then
    return UI_color.C_FFC4BEBE
  end
  return colorSettingList[index]
end
function Chatting_MessageColor(msgChatType, msgNoticeType, panelIndex)
  local msgColor = UI_color.C_FFE7E7E7
  if nil == msgChatType or msgChatType < -1 or msgChatType >= CppEnums.ChatType.Count then
    return UI_color.C_FFC4BEBE
  end
  local chatColorIndex = -1
  if nil ~= panelIndex then
    local chat = ToClient_getChattingPanel(panelIndex)
    if nil ~= chat then
      if UI_CT.System ~= msgChatType then
        chatColorIndex = chat:getChatColorIndex(msgChatType)
      else
        chatColorIndex = chat:getChatSystemColorIndex(msgChatType)
      end
    end
  end
  if UI_CT.Public == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFE7E7E7
      return msgColor
    end
  elseif UI_CT.Party == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF8EBD00
      return msgColor
    end
  elseif UI_CT.Guild == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF84FFF5
      return msgColor
    end
  elseif UI_CT.World == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFFF973A
      return msgColor
    end
  elseif UI_CT.Private == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFF601FF
      return msgColor
    end
  elseif UI_CT.System == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFC4BEBE
      return msgColor
    end
  elseif UI_CT.Notice == msgChatType and UI_CNT.Normal == msgNoticeType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFFFEF82
      return msgColor
    end
  elseif UI_CT.Notice == msgChatType and UI_CNT.Campaign == msgNoticeType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFBBFF84
      return msgColor
    end
  elseif UI_CT.Notice == msgChatType and UI_CNT.Emergency == msgNoticeType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFFF4B4B
      return msgColor
    end
  elseif UI_CT.Alliance == msgChatType then
    if -1 == chatColorIndex then
      msgColor = 4285842942
      return msgColor
    end
  elseif UI_CT.WorldWithItem == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF00F3A0
      return msgColor
    end
  elseif UI_CT.LocalWar == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFB97FEF
      return msgColor
    end
  elseif UI_CT.RolePlay == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF00B4FF
      return msgColor
    end
  elseif UI_CT.Arsha == msgChatType and UI_CNT.PvPHost == msgNoticeType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF00B4FF
      return msgColor
    end
  elseif UI_CT.Arsha == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFFFD237
      return msgColor
    end
  elseif UI_CT.Team == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FFB97FEF
      return msgColor
    end
  elseif UI_CT.Channel == msgChatType then
    if -1 == chatColorIndex then
      msgColor = UI_color.C_FF55a1dd
      return msgColor
    end
  elseif UI_CT.GuildManager == msgChatType and -1 == chatColorIndex then
    msgColor = UI_color.C_FFC694FF
    return msgColor
  end
  return FGlobal_ColorList(chatColorIndex)
end
function getUseMemory()
  return collectgarbage("count", 0)
end
function in_array(e, t)
  for _, v in pairs(t) do
    if v == e then
      return true
    end
  end
  return false
end
function getContryTypeLua()
  local returnValue = -1
  local gameServiceType = getGameServiceType()
  local eCountryType = CppEnums.CountryType
  if eCountryType.NONE == gameServiceType or eCountryType.DEV == gameServiceType or eCountryType.KOR_ALPHA == gameServiceType or eCountryType.KOR_REAL == gameServiceType or eCountryType.KOR_TEST == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_KOR
  elseif eCountryType.JPN_ALPHA == gameServiceType or eCountryType.JPN_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_JAP
  elseif eCountryType.RUS_ALPHA == gameServiceType or eCountryType.RUS_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_RUS
  elseif eCountryType.KR2_ALPHA == gameServiceType or eCountryType.KR2_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_KR2
  elseif eCountryType.NA_ALPHA == gameServiceType or eCountryType.NA_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_NA
  elseif eCountryType.TW_ALPHA == gameServiceType or eCountryType.TW_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_TW
  elseif eCountryType.SA_ALPHA == gameServiceType or eCountryType.SA_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_SA
  elseif eCountryType.TH_ALPHA == gameServiceType or eCountryType.TH_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_TH
  elseif eCountryType.ID_ALPHA == gameServiceType or eCountryType.ID_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_ID
  elseif eCountryType.TR_ALPHA == gameServiceType or eCountryType.TR_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_TR
  elseif eCountryType.GT_ALPHA == gameServiceType or eCountryType.GT_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_GT
  elseif eCountryType.ASIA_ALPHA == gameServiceType or eCountryType.ASIA_REAL == gameServiceType then
    returnValue = CppEnums.ContryCode.eContryCode_ASIA
  else
    returnValue = CppEnums.ContryCode.eContryCode_Count
  end
  return returnValue
end
function isGameTypeThisCountry(country)
  if country == getContryTypeLua() then
    return true
  end
  return false
end
function getGameContentsServiceType()
  local returnValue = -1
  local gameContentServiceType = getContentsServiceType()
  local eContentType = CppEnums.ContentsServiceType
  if eContentType.eContentsServiceType_Closed == gameContentServiceType then
    returnValue = eContentType.eContentsServiceType_Closed
  elseif eContentType.eContentsServiceType_CBT == gameContentServiceType then
    returnValue = eContentType.eContentsServiceType_CBT
  elseif eContentType.eContentsServiceType_Pre == gameContentServiceType then
    returnValue = eContentType.eContentsServiceType_Pre
  elseif eContentType.eContentsServiceType_OBT == gameContentServiceType then
    returnValue = eContentType.eContentsServiceType_OBT
  elseif eContentType.eContentsServiceType_Commercial == gameContentServiceType then
    returnValue = eContentType.eContentsServiceType_Commercial
  else
    returnValue = eContentType.eContentsServiceType_Count
  end
  return returnValue
end
function isGameContentServiceType(serviceType)
  if serviceType == getGameContentsServiceType() then
    return true
  end
  return false
end
function isGameTypeKorea()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KOR)
end
function isGameTypeRussia()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_RUS)
end
function isGameTypeJapan()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_JAP)
end
function isGameTypeEnglish()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_NA)
end
function isGameTypeTaiwan()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_TW)
end
function isGameTypeSA()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_SA)
end
function isGameTypeKR2()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KR2)
end
function isGameTypeTH()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_TH)
end
function isGameTypeID()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_ID)
end
function isGameTypeTR()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_TR)
end
function isGameTypeAE()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_AE)
end
function isGameTypeGT()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_GT)
end
function isGameTypeASIA()
  return isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_ASIA)
end
function isCommonGameType()
  local returnValue = false
  if isGameTypeJapan() then
    returnValue = true
  elseif isGameTypeRussia() then
    returnValue = true
  elseif isGameTypeEnglish() then
    returnValue = true
  elseif isGameTypeTaiwan() then
    returnValue = true
  elseif isGameTypeSA() then
    returnValue = true
  elseif isGameTypeKR2() then
    returnValue = true
  else
    returnValue = false
  end
  return returnValue
end
function isItemMarketSecureCode()
  local isSecureCode = false
  if (isGameTypeKorea() or isGameTypeJapan() or isGameTypeRussia() or isGameTypeEnglish() or isGameTypeTaiwan() or isGameTypeSA()) and true == isSecureCode then
    return true
  else
    return false
  end
end
local timerObject = {
  _timerNo = 0,
  _endTime = 0,
  _function = nil,
  _isRepeat = false,
  _repeatTime = 0
}
local g_TimerNo = 0
local g_Timerlist = {}
local g_TimerCount = 0
function luaTimer_UpdatePerFrame(fDelta)
  if g_TimerCount <= 0 then
    return
  end
  local currentTickCount = getTickCount32()
  local removeTimerList = {}
  local removeIndex = 1
  for index, timer in pairs(g_Timerlist) do
    if nil ~= timer then
      if currentTickCount >= timer._endTime then
        timer._function(timer._param0, timer._param1, timer._param2)
        if not timer._isRepeat then
          local tempIndex = timer._timerNo
          g_Timerlist[tempIndex] = nil
          g_TimerCount = g_TimerCount - 1
        else
          timer._endTime = currentTickCount + timer._repeatTime
        end
      end
    else
      _PA_LOG("LUA", "timer \234\176\128 nil \236\157\180\235\139\164~~!!!!")
    end
  end
end
function luaTimer_AddEvent(func, endTime, isRepeat, repeatTime, param0, param1, param2)
  g_TimerNo = g_TimerNo + 1
  local tempTimer = {}
  tempTimer._timerNo = g_TimerNo
  tempTimer._endTime = getTickCount32() + endTime
  tempTimer._function = func
  tempTimer._isRepeat = isRepeat
  tempTimer._repeatTime = repeatTime
  tempTimer._param0 = param0
  tempTimer._param1 = param1
  tempTimer._param2 = param2
  if nil == g_Timerlist then
    g_Timerlist = {}
  end
  g_Timerlist[g_TimerNo] = tempTimer
  g_TimerCount = g_TimerCount + 1
  return g_TimerNo
end
function RegisterTimerForQA(strFunc, inputTime)
  ToClient_qaExcuteEventHandler(strFunc, inputTime)
end
function luaTimer_RemoveEvent(timerNo)
  if nil ~= g_Timerlist[timerNo] then
    g_Timerlist[timerNo] = nil
    g_TimerCount = g_TimerCount - 1
  end
end
function getMpToActor(actorProxy)
  if nil == actorProxy then
    return 0
  end
  if false == actorProxy:get():isVehicle() then
    return actorProxy:get():getMp()
  end
  if false == _ContentsGroup_OceanCurrent then
    return actorProxy:get():getMp()
  end
  local vehicleType = actorProxy:get():getVehicleType()
  if false == ToClient_isVehicleTypeWarter(vehicleType) then
    return actorProxy:get():getMp()
  end
  return actorProxy:get():getFood()
end
function getMaxMpToActor(actorProxy)
  if nil == actorProxy then
    return 0
  end
  if false == actorProxy:get():isVehicle() then
    return actorProxy:get():getMaxMp()
  end
  if false == _ContentsGroup_OceanCurrent then
    return actorProxy:get():getMaxMp()
  end
  local vehicleType = actorProxy:get():getVehicleType()
  if false == ToClient_isVehicleTypeWarter(vehicleType) then
    return actorProxy:get():getMaxMp()
  end
  return actorProxy:get():getMaxFood()
end
function getMpToServantInfo(servantInfo)
  if nil == servantInfo then
    return 0
  end
  if false == _ContentsGroup_OceanCurrent then
    return servantInfo:getMp()
  end
  local vehicleType = servantInfo:getVehicleType()
  if false == ToClient_isVehicleTypeWarter(vehicleType) then
    return servantInfo:getMp()
  end
  return servantInfo:getFood()
end
function getMaxMpToServantInfo(servantInfo)
  if nil == servantInfo then
    return 0
  end
  if false == _ContentsGroup_OceanCurrent then
    return servantInfo:getMaxMp()
  end
  local vehicleType = servantInfo:getVehicleType()
  if false == ToClient_isVehicleTypeWarter(vehicleType) then
    return servantInfo:getMaxMp()
  end
  return servantInfo:getMaxFood()
end
function PAGlobalFunc_SetItemTextColor(targetControl, itemSSW)
  if nil == itemSSW or nil == targetControl then
    return
  end
  local itemGrade = itemSSW:getGradeType()
  local color = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  targetControl:SetFontColor(color)
end
function PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  if 0 == itemGrade then
    return Defines.Color.C_FFC4C4C4
  elseif 1 == itemGrade then
    return Defines.Color.C_FF83A543
  elseif 2 == itemGrade then
    return Defines.Color.C_FF438DCC
  elseif 3 == itemGrade then
    return Defines.Color.C_FFF5BA3A
  elseif 4 == itemGrade then
    return Defines.Color.C_FFD05D48
  elseif 5 == itemGrade then
    return Defines.Color.C_FFA070EF
  else
    return Defines.Color.C_FFC4C4C4
  end
end
function PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(originString, itemSSW)
  if nil == itemSSW then
    return
  end
  local itemGrade = itemSSW:getGradeType()
  local resultString = ""
  if 0 == itemGrade then
    resultString = "<PAColor0xFFC4C4C4>"
  elseif 1 == itemGrade then
    resultString = "<PAColor0xFF83A543>"
  elseif 2 == itemGrade then
    resultString = "<PAColor0xFF438DCC>"
  elseif 3 == itemGrade then
    resultString = "<PAColor0xFFF5BA3A>"
  elseif 4 == itemGrade then
    resultString = "<PAColor0xFFD05D48>"
  elseif 5 == itemGrade then
    resultString = "<PAColor0xFFA070EF>"
  else
    resultString = "<PAColor0xFFC4C4C4>"
  end
  resultString = resultString .. originString .. "<PAOldColor>"
  return resultString
end
function PaGlobalFunc_Util_GetNewClassType()
  if CppEnums.NewClassType == nil then
    return nil
  end
  if PaGlobalFunc_Util_GetIsContentsOpen(CppEnums.NewClassType) == false then
    return nil
  end
  return CppEnums.NewClassType
end
function PaGlobalFunc_Util_PearlShopClassTypeButtonOpenCheck(classType)
  if classType == nil then
    return false
  end
  if PaGlobalFunc_Util_GetIsContentsOpen(classType) == false then
    return false
  end
  if CppEnums.NewClassType == nil or CppEnums.NewClassType ~= classType then
    return true
  end
  if classType ~= __eClassType_PRSA or ToClient_IsContentsGroupOpen("2124") == false then
    _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\139\160\234\183\156 \237\129\180\235\158\152\236\138\164 \237\142\132\236\131\129\236\160\144 \236\157\152\236\131\129 \236\185\180\237\133\140\234\179\160\235\166\172 \237\145\156\236\139\156 \236\151\172\235\182\128", "\236\161\176\234\180\145\235\175\188")
    return false
  end
  return true
end
function PaGlobalFunc_Util_GetIsContentsOpen(classType)
  if classType == nil then
    return false
  end
  local classContentsOption = {
    [__eClassType_Warrior] = true,
    [__eClassType_Hashashin] = true,
    [__eClassType_Sage] = ToClient_IsContentsGroupOpen("1578"),
    [__eClassType_Warrior_Reserve2] = false,
    [__eClassType_ElfRanger] = true,
    [__eClassType_Guardian] = true,
    [__eClassType_Scholar] = ToClient_IsContentsGroupOpen("2096"),
    [__eClassType_Drakania] = ToClient_IsContentsGroupOpen("1600"),
    [__eClassType_Sorcerer] = true,
    [__eClassType_Nova] = true,
    [__eClassType_Corsair] = ToClient_IsContentsGroupOpen("1589"),
    [__eClassType_Lhan] = true,
    [__eClassType_Giant] = true,
    [__eClassType_Giant_Reserved0] = false,
    [__eClassType_Unknown2] = false,
    [__eClassType_Giant_Reserved2] = ToClient_IsContentsGroupOpen("2061"),
    [__eClassType_Tamer] = true,
    [__eClassType_ShyWaman] = true,
    [__eClassType_ShyMan] = false,
    [__eClassType_Combattant] = true,
    [__eClassType_BladeMaster] = true,
    [__eClassType_BladeMasterWoman] = true,
    [__eClassType_BladeMaster_Reserved1] = false,
    [__eClassType_Mystic] = true,
    [__eClassType_Valkyrie] = true,
    [__eClassType_Kunoichi] = true,
    [__eClassType_NinjaMan] = true,
    [__eClassType_DarkElf] = true,
    [__eClassType_WizardMan] = true,
    [__eClassType_RangerMan] = true,
    [__eClassType_KunoichiOld] = ToClient_IsContentsGroupOpen("2072"),
    [__eClassType_WizardWoman] = true,
    [__eClassType_PRSA] = ToClient_IsContentsGroupOpen("2124"),
    [__eClassType_PWGE] = ToClient_IsContentsGroupOpen("2152")
  }
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \237\129\180\235\158\152\236\138\164\235\179\132 \236\187\168\237\133\144\236\184\160 \236\152\181\236\133\152", "\236\161\176\234\180\145\235\175\188")
  if classContentsOption[classType] == nil then
    return false
  end
  return classContentsOption[classType]
end
function PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  if classType == nil then
    return false
  end
  local awakenWeapon = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1136"),
    [__eClassType_Sage] = ToClient_IsContentsGroupOpen("1579"),
    [__eClassType_Warrior_Reserve2] = ToClient_IsContentsGroupOpen("1567"),
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317"),
    [__eClassType_Scholar] = ToClient_IsContentsGroupOpen("2097"),
    [__eClassType_Drakania] = ToClient_IsContentsGroupOpen("1601"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
    [__eClassType_Nova] = ToClient_IsContentsGroupOpen("1466"),
    [__eClassType_Corsair] = ToClient_IsContentsGroupOpen("1590"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
    [__eClassType_Giant_Reserved0] = ToClient_IsContentsGroupOpen("2051"),
    [__eClassType_Unknown2] = ToClient_IsContentsGroupOpen("1317"),
    [__eClassType_Giant_Reserved2] = ToClient_IsContentsGroupOpen("2062"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
    [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
    [__eClassType_ShyMan] = false,
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
    [__eClassType_BladeMaster_Reserved1] = false,
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
    [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
    [__eClassType_KunoichiOld] = ToClient_IsContentsGroupOpen("2073"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
    [__eClassType_PRSA] = ToClient_IsContentsGroupOpen("2125"),
    [__eClassType_PWGE] = false
  }
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \237\129\180\235\158\152\236\138\164\235\179\132 \234\176\129\236\132\177 \236\187\168\237\133\144\236\184\160 \236\152\181\236\133\152", "\236\161\176\234\180\145\235\175\188")
  if awakenWeapon[classType] == nil then
    return false
  end
  return awakenWeapon[classType]
end
function PaGlobalFunc_Util_IsSuccessionContentsOpen(classType)
  if classType == nil then
    return false
  end
  if _ContentsGroup_Succession == false then
    return false
  end
  local successionWeapon = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("1367"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1451"),
    [__eClassType_Sage] = ToClient_IsContentsGroupOpen("1588"),
    [__eClassType_Warrior_Reserve2] = false,
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("1368"),
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1424"),
    [__eClassType_Scholar] = ToClient_IsContentsGroupOpen("2106"),
    [__eClassType_Drakania] = ToClient_IsContentsGroupOpen("1610"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("1369"),
    [__eClassType_Nova] = ToClient_IsContentsGroupOpen("1475"),
    [__eClassType_Corsair] = ToClient_IsContentsGroupOpen("1599"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("1381"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("1370"),
    [__eClassType_Giant_Reserved0] = ToClient_IsContentsGroupOpen("2060"),
    [__eClassType_Unknown2] = false,
    [__eClassType_Giant_Reserved2] = ToClient_IsContentsGroupOpen("2071"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("1371"),
    [__eClassType_ShyWaman] = false,
    [__eClassType_ShyMan] = false,
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("1380"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("1372"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("1373"),
    [__eClassType_BladeMaster_Reserved1] = false,
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("1382"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("1374"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("1378"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("1377"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("1379"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("1375"),
    [__eClassType_RangerMan] = false,
    [__eClassType_KunoichiOld] = ToClient_IsContentsGroupOpen("2082"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("1376"),
    [__eClassType_PRSA] = ToClient_IsContentsGroupOpen("2134"),
    [__eClassType_PWGE] = false
  }
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \237\129\180\235\158\152\236\138\164\235\179\132 \236\160\132\236\138\185 \236\187\168\237\133\144\236\184\160 \236\152\181\236\133\152", "\236\161\176\234\180\145\235\175\188")
  if successionWeapon[classType] == nil then
    return false
  end
  return successionWeapon[classType]
end
function PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType)
  if classType == nil then
    return false
  end
  if classType ~= __eClassType_Warrior and classType ~= __eClassType_Hashashin and classType ~= __eClassType_ElfRanger and classType ~= __eClassType_Guardian and classType ~= __eClassType_Sorcerer and classType ~= __eClassType_Nova and classType ~= __eClassType_Lhan and classType ~= __eClassType_Giant and classType ~= __eClassType_Tamer and classType ~= __eClassType_ShyWaman and classType ~= __eClassType_Combattant and classType ~= __eClassType_BladeMaster and classType ~= __eClassType_BladeMasterWoman and classType ~= __eClassType_Mystic and classType ~= __eClassType_Valkyrie and classType ~= __eClassType_Kunoichi and classType ~= __eClassType_NinjaMan and classType ~= __eClassType_DarkElf and classType ~= __eClassType_WizardMan and classType ~= __eClassType_RangerMan and classType ~= __eClassType_WizardWoman then
    return true
  end
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\139\160\234\183\156 \237\129\180\235\158\152\236\138\164\234\176\128 \236\160\132\236\138\185\236\157\180 \236\149\132\235\139\140 \234\176\129\236\132\177\235\182\128\237\132\176 \236\152\164\237\148\136 \236\139\156 \236\156\132\236\151\144 \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\161\176\234\180\145\235\175\188")
  return false
end
function PaGlobalFunc_Util_SetCharacterSelectClassIcon(control, classType)
  if control == nil then
    return
  end
  local classPictureInfo = {
    [__eClassType_Warrior] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_Hashashin] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 757,
      x2 = 362,
      y2 = 840
    },
    [__eClassType_Sage] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 841,
      x2 = 725,
      y2 = 924
    },
    [__eClassType_Warrior_Reserve2] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_ElfRanger] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 169,
      x2 = 362,
      y2 = 252
    },
    [__eClassType_Guardian] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 757,
      x2 = 725,
      y2 = 840
    },
    [__eClassType_Scholar] = {
      path = "renewal/button/console_btn_characterselect_01.dds",
      x1 = 2,
      y1 = 169,
      x2 = 362,
      y2 = 252
    },
    [__eClassType_Drakania] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 926,
      x2 = 725,
      y2 = 1009
    },
    [__eClassType_Sorcerer] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 85,
      x2 = 362,
      y2 = 168
    },
    [__eClassType_Nova] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 841,
      x2 = 362,
      y2 = 924
    },
    [__eClassType_Corsair] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 926,
      x2 = 362,
      y2 = 1009
    },
    [__eClassType_Lhan] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 253,
      x2 = 725,
      y2 = 336
    },
    [__eClassType_Giant] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 253,
      x2 = 362,
      y2 = 336
    },
    [__eClassType_Giant_Reserved0] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 926,
      x2 = 725,
      y2 = 1009
    },
    [__eClassType_Unknown2] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_Giant_Reserved2] = {
      path = "renewal/button/console_btn_characterselect_01.dds",
      x1 = 2,
      y1 = 85,
      x2 = 362,
      y2 = 168
    },
    [__eClassType_Tamer] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 505,
      x2 = 362,
      y2 = 588
    },
    [__eClassType_ShyWaman] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 673,
      x2 = 725,
      y2 = 756
    },
    [__eClassType_ShyMan] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_Combattant] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 85,
      x2 = 725,
      y2 = 168
    },
    [__eClassType_BladeMaster] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 1,
      x2 = 725,
      y2 = 84
    },
    [__eClassType_BladeMasterWoman] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 421,
      x2 = 725,
      y2 = 504
    },
    [__eClassType_BladeMaster_Reserved1] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_Mystic] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 589,
      x2 = 725,
      y2 = 672
    },
    [__eClassType_Valkyrie] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 337,
      x2 = 725,
      y2 = 420
    },
    [__eClassType_Kunoichi] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 589,
      x2 = 362,
      y2 = 672
    },
    [__eClassType_NinjaMan] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 505,
      x2 = 725,
      y2 = 588
    },
    [__eClassType_RangerMan] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 673,
      x2 = 362,
      y2 = 756
    },
    [__eClassType_DarkElf] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 365,
      y1 = 169,
      x2 = 725,
      y2 = 252
    },
    [__eClassType_WizardMan] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 421,
      x2 = 362,
      y2 = 504
    },
    [__eClassType_KunoichiOld] = {
      path = "renewal/button/console_btn_characterselect_01.dds",
      x1 = 2,
      y1 = 1,
      x2 = 362,
      y2 = 84
    },
    [__eClassType_WizardWoman] = {
      path = "renewal/button/console_btn_characterselect_00.dds",
      x1 = 2,
      y1 = 337,
      x2 = 362,
      y2 = 420
    },
    [__eClassType_PRSA] = {
      path = "renewal/button/Console_Btn_CharacterSelect_01.dds",
      x1 = 2,
      y1 = 253,
      x2 = 362,
      y2 = 336
    },
    [__eClassType_PWGE] = {
      path = "renewal/button/Console_Btn_CharacterSelect_01.dds",
      x1 = 2,
      y1 = 253,
      x2 = 362,
      y2 = 336
    }
  }
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local pictureInfo = classPictureInfo[classType]
  if pictureInfo ~= nil then
    control:ChangeTextureInfoName(pictureInfo.path)
    x1, y1, x2, y2 = setTextureUV_Func(control, pictureInfo.x1, pictureInfo.y1, pictureInfo.x2, pictureInfo.y2)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\189\152\236\134\148 \236\186\144\235\166\173\237\132\176 \236\132\160\237\131\157\236\176\189 \235\178\132\237\138\188 \236\180\136\236\131\129\237\153\148 \236\132\164\236\160\149", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetCharacterCreateClassIcon(control, classType)
  if control == nil then
    return
  end
  local classPictureInfo = {
    [-1] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_Warrior] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_Hashashin] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 146,
      x2 = 96,
      y2 = 290
    },
    [__eClassType_Sage] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 193,
      y1 = 146,
      x2 = 288,
      y2 = 290
    },
    [__eClassType_Warrior_Reserve2] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_ElfRanger] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 97,
      y1 = 1,
      x2 = 192,
      y2 = 145
    },
    [__eClassType_Guardian] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 385,
      y1 = 1,
      x2 = 480,
      y2 = 145
    },
    [__eClassType_Scholar] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 193,
      y1 = 291,
      x2 = 288,
      y2 = 435
    },
    [__eClassType_Drakania] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 385,
      y1 = 146,
      x2 = 480,
      y2 = 290
    },
    [__eClassType_Sorcerer] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 193,
      y1 = 1,
      x2 = 288,
      y2 = 145
    },
    [__eClassType_Nova] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 97,
      y1 = 146,
      x2 = 192,
      y2 = 290
    },
    [__eClassType_Corsair] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 289,
      y1 = 146,
      x2 = 384,
      y2 = 290
    },
    [__eClassType_Lhan] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 97,
      y1 = 1,
      x2 = 192,
      y2 = 145
    },
    [__eClassType_Giant] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 289,
      y1 = 1,
      x2 = 384,
      y2 = 145
    },
    [__eClassType_Giant_Reserved0] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_Unknown2] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_Giant_Reserved2] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 97,
      y1 = 291,
      x2 = 192,
      y2 = 435
    },
    [__eClassType_Tamer] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 385,
      y1 = 1,
      x2 = 480,
      y2 = 145
    },
    [__eClassType_ShyWaman] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 289,
      y1 = 1,
      x2 = 384,
      y2 = 145
    },
    [__eClassType_ShyMan] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 289,
      y1 = 1,
      x2 = 384,
      y2 = 145
    },
    [__eClassType_Combattant] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 289,
      y1 = 291,
      x2 = 384,
      y2 = 435
    },
    [__eClassType_BladeMaster] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 1,
      y1 = 146,
      x2 = 96,
      y2 = 290
    },
    [__eClassType_BladeMasterWoman] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 193,
      y1 = 146,
      x2 = 288,
      y2 = 290
    },
    [__eClassType_BladeMaster_Reserved1] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 1,
      x2 = 96,
      y2 = 145
    },
    [__eClassType_Mystic] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 385,
      y1 = 291,
      x2 = 480,
      y2 = 435
    },
    [__eClassType_Valkyrie] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 97,
      y1 = 146,
      x2 = 192,
      y2 = 290
    },
    [__eClassType_Kunoichi] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 1,
      y1 = 291,
      x2 = 96,
      y2 = 435
    },
    [__eClassType_NinjaMan] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 97,
      y1 = 291,
      x2 = 192,
      y2 = 435
    },
    [__eClassType_DarkElf] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 193,
      y1 = 291,
      x2 = 288,
      y2 = 435
    },
    [__eClassType_WizardMan] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 289,
      y1 = 146,
      x2 = 384,
      y2 = 290
    },
    [__eClassType_RangerMan] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 193,
      y1 = 1,
      x2 = 288,
      y2 = 145
    },
    [__eClassType_KunoichiOld] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 1,
      y1 = 291,
      x2 = 96,
      y2 = 435
    },
    [__eClassType_WizardWoman] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_00.dds",
      x1 = 385,
      y1 = 146,
      x2 = 480,
      y2 = 290
    },
    [__eClassType_PRSA] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 289,
      y1 = 291,
      x2 = 384,
      y2 = 435
    },
    [__eClassType_PWGE] = {
      path = "New_UI_Common_ForLua/Window/Lobby/Lobby_ClassSelect_01.dds",
      x1 = 289,
      y1 = 291,
      x2 = 384,
      y2 = 435
    }
  }
  local x1, y1, x2, y2 = 0, 0, 0, 0
  local pictureInfo = classPictureInfo[classType]
  if pictureInfo == nil then
    pictureInfo = classPictureInfo[-1]
  end
  if pictureInfo ~= nil then
    control:ChangeTextureInfoName(pictureInfo.path)
    x1, y1, x2, y2 = setTextureUV_Func(control, pictureInfo.x1, pictureInfo.y1, pictureInfo.x2, pictureInfo.y2)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. PC \236\186\144\235\166\173\237\132\176 \236\131\157\236\132\177\236\176\189 \235\178\132\237\138\188 \236\180\136\236\131\129\237\153\148 \236\132\164\236\160\149", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_ChangeTextureClass(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoNameDefault("Combine/Icon/Combine_Class_Icon_00.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 51, 51)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 103, 153, 153)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 205, 103, 255, 153)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 103, 306, 153)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 1, 102, 51)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 103, 102, 153)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 460, 103, 510, 153)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 103, 357, 153)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 1, 153, 51)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 154, 103, 204, 153)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 103, 306, 153)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 52, 306, 102)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 154, 1, 204, 51)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 103, 357, 153)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 409, 103, 459, 153)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 205, 1, 255, 51)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 103, 51, 153)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 103, 357, 153)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 154, 52, 204, 102)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 256, 1, 306, 51)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 358, 1, 408, 51)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 205, 52, 255, 102)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 1, 357, 51)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 52, 51, 102)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 52, 52, 102, 102)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 103, 52, 153, 102)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 409, 1, 459, 51)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 307, 52, 357, 102)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 358, 103, 408, 153)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 460, 1, 510, 51)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 460, 52, 510, 102)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 460, 52, 510, 102)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \237\129\180\235\158\152\236\138\164 \236\149\132\236\157\180\236\189\152 \236\132\164\236\160\149", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetClassSymbolIcon(control, classType)
  if control == nil then
    return
  end
  if classType == __eClassType_Scholar or classType == __eClassType_PRSA or classType == __eClassType_PWGE then
    control:ChangeTextureInfoName("renewal/ui_icon/console_classsymbol_02.dds")
  else
    control:ChangeTextureInfoName("renewal/ui_icon/console_classsymbol.dds")
  end
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 57, 57)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 115, 228, 171)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 115, 342, 171)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 1, 114, 57)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 115, 171, 171)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 57, 57)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 457, 1, 513, 57)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 1, 171, 57)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 115, 285, 171)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 115, 399, 171)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 58, 456, 114)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 1, 228, 57)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 457, 172, 513, 228)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 457, 115, 513, 171)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 1, 285, 57)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 115, 114, 171)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 58, 342, 114)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 286, 1, 342, 57)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 400, 1, 456, 57)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 58, 399, 114)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 343, 1, 399, 57)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 115, 58, 171, 114)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 172, 58, 228, 114)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 229, 58, 285, 114)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 58, 57, 114)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 115, 57, 171)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 457, 58, 513, 114)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 58, 114, 114)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 1, 114, 57)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 58, 1, 114, 57)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \237\129\180\235\158\152\236\138\164 \236\139\172\235\179\188 \236\149\132\236\157\180\236\189\152 \236\132\164\236\160\149", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetWorldMapClassTypeIcon(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoName("new_ui_common_forlua/widget/worldmap/worldmap_etc_06.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 102, 31, 131)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 360, 62, 389)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 422, 62, 451)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 453, 62, 482)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 133, 31, 162)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 329, 62, 358)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 267, 93, 296)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 174, 93, 203)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 164, 31, 193)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 391, 62, 420)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 453, 62, 482)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 236, 62, 265)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 195, 31, 224)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 174, 93, 203)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 174, 93, 203)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 236, 93, 265)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 226, 31, 255)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 298, 62, 327)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 174, 93, 203)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 174, 62, 203)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 257, 31, 286)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 319, 31, 348)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 174, 93, 203)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 205, 62, 234)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 288, 31, 317)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 443, 31, 472)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 412, 31, 441)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 474, 31, 503)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 381, 31, 410)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 33, 267, 62, 296)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 205, 93, 234)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 2, 350, 31, 379)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 298, 93, 327)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 64, 298, 93, 327)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\155\148\235\147\156\235\167\181 \237\140\140\237\139\176 \237\129\180\235\158\152\236\138\164 \236\149\132\236\157\180\236\189\152", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetFriendClassTypeIcon(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Chatting.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 124, 44, 167)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 221, 212, 264, 255)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 256, 44, 299)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 256, 132, 299)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 45, 124, 88, 167)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 177, 212, 220, 255)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 309, 124, 352, 167)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 177, 256, 220, 299)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 124, 132, 167)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 265, 212, 308, 255)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 45, 256, 88, 299)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 45, 212, 88, 255)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 133, 124, 176, 167)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 177, 256, 220, 299)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 256, 132, 299)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 265, 256, 308, 299)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 177, 124, 220, 167)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 133, 212, 176, 255)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 256, 132, 299)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 265, 168, 308, 211)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 221, 124, 264, 167)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 265, 124, 308, 167)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 256, 132, 299)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 212, 44, 255)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 168, 44, 211)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 45, 168, 88, 211)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 168, 132, 211)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 221, 168, 264, 211)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 133, 168, 176, 211)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 212, 132, 255)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 221, 256, 264, 299)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 177, 168, 220, 211)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 309, 168, 352, 211)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 309, 168, 352, 211)
  else
    x1, y1, x2, y2 = setTextureUV_Func(control, 89, 256, 132, 299)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\134\148\235\157\188\235\160\136 \235\158\173\237\130\185 \237\129\180\235\158\152\236\138\164 BG", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_GetClassTypeInfo(classType)
  local classTypeInfo = {
    mainWeaponType = "",
    subWeaponType = "",
    manaType = ""
  }
  if classType == __eClassType_Warrior then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_LONGSWORD")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHIELD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Hashashin then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SAGOKDO")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_GEUMGAE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Sage then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KAIVE")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_TALISMAN")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_ElfRanger then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_BOW")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_DAGGER")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Guardian then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_BATTLEAXE")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHIELD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Scholar then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SEMA")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_NAK")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Drakania then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SLAYER")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHARD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Sorcerer then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_ENCHANTARM")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_TALISMAN")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Nova then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_STAR")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KRATOOM")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_SP")
  elseif classType == __eClassType_Corsair then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SERENAKA")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_MAREKA")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Lhan then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_CRESCENTPENDULUM")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_NOBLESWORD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Giant then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_DOUBLEAXE")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_AIGUILLETTE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Giant_Reserved0 then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SLAYER")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHARD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Giant_Reserved2 then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_HO")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_HAIRPINKNIFE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Tamer then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHORTSWORD")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_NORIGEA")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_ShyWaman then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_FLORANG")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_VITCLARI")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_Combattant then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_GAUNTLET")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_VAMBRACE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_BladeMaster then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_BLADE")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHORTBOW")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_BladeMasterWoman then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_BLADE")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHORTBOW")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Mystic then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_GAUNTLET")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_VAMBRACE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_Valkyrie then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_LONGSWORD")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHIELD")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_SP")
  elseif classType == __eClassType_Kunoichi then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHORTSWORD")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHURIKEN") .. ", " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KUNAI")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_NinjaMan then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHORTSWORD")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_SHURIKEN") .. ", " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KUNAI")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_WP")
  elseif classType == __eClassType_DarkElf then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KRIEGSMESSER")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_AIGUILLETTE")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_WizardMan then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_STAFF")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_DAGGER")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_RangerMan then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_CROSSBOW")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_RAGHON")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_KunoichiOld then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KUZINA")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_KURINA")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_WizardWoman then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_STAFF")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_DAGGER")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_PRSA then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_WHAN")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_GOMB")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  elseif classType == __eClassType_PWGE then
    classTypeInfo.mainWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_WHAN")
    classTypeInfo.subWeaponType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_WEAPONTYPE_GOMB")
    classTypeInfo.manaType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CLASSSELECT_MPTYPE_EP")
  else
    return nil
  end
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\186\144\235\166\173\237\132\176 \236\131\157\236\132\177\236\176\189 \235\172\180\234\184\176\237\131\128\236\158\133/\235\167\136\235\130\152\237\131\128\236\158\133 \236\138\164\237\138\184\235\167\129 \236\160\149\235\179\180", "\236\161\176\234\180\145\235\175\188")
  return classTypeInfo
end
function PaGlobalFunc_Util_GetClassTypeAwakenInfo(classType)
  local awakenInfo = {
    _texture = "",
    _bigTexture = "",
    _weaponType = "",
    _combatType = "",
    _desc = ""
  }
  if classType == __eClassType_Warrior then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Warrior.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Warrior.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_AWAKEN_DESC")
  elseif classType == __eClassType_Hashashin then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Hashashin.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Hashashin.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_AWAKEN_DESC")
  elseif classType == __eClassType_Sage then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Sage.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Sage.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SAGE_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SAGE_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAGE_AWAKEN_DESC")
  elseif classType == __eClassType_ElfRanger then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Ranger.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Ranger.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_AWAKEN_DESC")
  elseif classType == __eClassType_Guardian then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Guardian.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Guardian.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_AWAKEN_DESC")
  elseif classType == __eClassType_Drakania then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_PQW.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_PQW.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_DRAKANIA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_DRAKANIA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_DRAKANIA_AWAKEN_DESC")
  elseif classType == __eClassType_Sorcerer then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Sorceress.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Sorceress.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_AWAKEN_DESC")
  elseif classType == __eClassType_Nova then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Nova.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Nova.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_AWAKEN_DESC")
  elseif classType == __eClassType_Corsair then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_PFW.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_PFW.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_CORSAIR_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_CORSAIR_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_CORSAIR_AWAKEN_DESC")
  elseif classType == __eClassType_Lhan then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Lahn.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Lahn.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_AWAKEN_DESC")
  elseif classType == __eClassType_Giant then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Berserker.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Berserker.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_AWAKEN_DESC")
  elseif classType == __eClassType_Tamer then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Tamar.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Tamer.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_AWAKEN_DESC")
  elseif classType == __eClassType_ShyWaman then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Shai.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Shai.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_AWAKEN_DESC")
  elseif classType == __eClassType_Combattant then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Striker.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Striker.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_AWAKEN_DESC")
  elseif classType == __eClassType_BladeMaster then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Musa.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Musa.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_AWAKEN_DESC")
  elseif classType == __eClassType_BladeMasterWoman then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Maewha.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Maewha.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_AWAKEN_DESC")
  elseif classType == __eClassType_Mystic then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Mystic.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Mystic.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_AWAKEN_DESC")
  elseif classType == __eClassType_Valkyrie then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Valkyrie.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Valkyrie.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_AWAKEN_DESC")
  elseif classType == __eClassType_Kunoichi then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Kunoichi.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Kunoichi.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_AWAKEN_DESC")
  elseif classType == __eClassType_NinjaMan then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Ninja.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Ninja.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_AWAKEN_DESC")
  elseif classType == __eClassType_DarkElf then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_DK.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_DK.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_AWAKEN_DESC")
  elseif classType == __eClassType_WizardMan then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Wizard.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Wizard.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_AWAKEN_DESC")
  elseif classType == __eClassType_RangerMan then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Archer.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Archer.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_AWAKEN_DESC")
  elseif classType == __eClassType_KunoichiOld then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_PMYF.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_PMYF.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WOOSA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WOOSA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WOOSA_AWAKEN_DESC")
  elseif classType == __eClassType_WizardWoman then
    awakenInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Awaken_Witch.dds"
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_Witch.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_AWAKEN_DESC")
  elseif classType == __eClassType_Giant_Reserved0 then
    awakenInfo._texture = ""
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_PQW.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "")
  elseif classType == __eClassType_Giant_Reserved2 then
    awakenInfo._texture = ""
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Awaken_PKOW.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_AWAKEN_DESC")
  elseif classType == __eClassType_Scholar then
    awakenInfo._texture = ""
    awakenInfo._bigTexture = ""
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_AWAKEN_DESC")
  elseif classType == __eClassType_PRSA then
    awakenInfo._texture = ""
    awakenInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PRSA_Awaken.dds"
    awakenInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_AWAKEN_WEAPON_TYPE")
    awakenInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_AWAKEN_COMBAT_TYPE")
    awakenInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_AWAKEN_DESC")
  elseif classType == __eClassType_PWGE then
    awakenInfo._texture = ""
    awakenInfo._bigTexture = ""
    awakenInfo._weaponType = "\236\180\157\236\186\144 \235\172\180\234\184\176"
    awakenInfo._combatType = "\236\180\157\236\186\144 \236\160\132\237\136\172\236\162\133\235\165\152"
    awakenInfo._desc = "\236\180\157\236\186\144 \236\132\164\235\170\133"
  else
    awakenInfo._texture = ""
    awakenInfo._bigTexture = ""
    awakenInfo._weaponType = "\235\172\180\234\184\176"
    awakenInfo._combatType = "\236\160\132\237\136\172\236\162\133\235\165\152"
    awakenInfo._desc = "\236\132\164\235\170\133"
  end
  _PA_ASSERT_NAME(CppEnums.NewClassTypeAwaken == __eClassType_Scholar, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \234\176\129\236\132\177 \235\172\180\234\184\176\237\131\128\236\158\133/\234\179\181\234\178\169\237\131\128\236\158\133/\236\132\164\235\170\133 \236\138\164\237\138\184\235\167\129", "\236\161\176\234\180\145\235\175\188")
  return awakenInfo
end
function PaGlobalFunc_Util_GetClassTypeSuccessionInfo(classType)
  local successionInfo = {
    _texture = "",
    _bigTexture = "",
    _weaponType = "",
    _combatType = "",
    _desc = ""
  }
  if classType == __eClassType_Warrior then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Warrior.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Warrior.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WARRIOR_SUCCESSION_DESC")
  elseif classType == __eClassType_Hashashin then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Hashashin.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Hashashin.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_HASHASHIN_SUCCESSION_DESC")
  elseif classType == __eClassType_Sage then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Sage.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Sage.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SAGE_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAGE_SUCCESSION_DESC")
  elseif classType == __eClassType_ElfRanger then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Ranger.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Ranger.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_RANGER_SUCCESSION_DESC")
  elseif classType == __eClassType_Guardian then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Guardian.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Guardian.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUARDIAN_SUCCESSION_DESC")
  elseif classType == __eClassType_Drakania then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_PQW.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PQW.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_PQW_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_PQW_SUCCESSION_DESC")
  elseif classType == __eClassType_Sorcerer then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Sorceress.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Sorceress.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SORCERER_SUCCESSION_DESC")
  elseif classType == __eClassType_Nova then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Nova.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Nova.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_NOVA_SUCCESSION_DESC")
  elseif classType == __eClassType_Corsair then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_PFW.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PFW.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_CORSAIR_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_CORSAIR_SUCCESSION_DESC")
  elseif classType == __eClassType_Lhan then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Lahn.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Lahn.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_LHAN_SUCCESSION_DESC")
  elseif classType == __eClassType_Giant then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Berserker.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Berserker.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_GIANT_SUCCESSION_DESC")
  elseif classType == __eClassType_Tamer then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Tamar.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Tamer.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_TAMER_SUCCESSION_DESC")
  elseif classType == __eClassType_ShyWaman then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Shai.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Shai.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_SUCCESSION_DESC")
  elseif classType == __eClassType_Combattant then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Striker.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Striker.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_COMBATTANT_SUCCESSION_DESC")
  elseif classType == __eClassType_BladeMaster then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Musa.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Musa.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MUSA_SUCCESSION_DESC")
  elseif classType == __eClassType_BladeMasterWoman then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Maewha.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Maewha.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAEWHA_SUCCESSION_DESC")
  elseif classType == __eClassType_Mystic then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Mystic.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Mystic.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYSTIC_SUCCESSION_DESC")
  elseif classType == __eClassType_Valkyrie then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Valkyrie.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Valkyrie.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_VALKYRIE_SUCCESSION_DESC")
  elseif classType == __eClassType_Kunoichi then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Kunoichi.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Kunoichi.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_KUNOICHI_SUCCESSION_DESC")
  elseif classType == __eClassType_NinjaMan then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Ninja.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Ninja.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_NINJA_SUCCESSION_DESC")
  elseif classType == __eClassType_DarkElf then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_DK.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_DK.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_DARKKNIGHT_SUCCESSION_DESC")
  elseif classType == __eClassType_WizardMan then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Wizard.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Wizard.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WIZARD_SUCCESSION_DESC")
  elseif classType == __eClassType_RangerMan then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Archer.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Archer.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_ARCHER_SUCCESSION_DESC")
  elseif classType == __eClassType_KunoichiOld then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_PMYF.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PMYF.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WUSA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WUSA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WUSA_SUCCESSION_DESC")
  elseif classType == __eClassType_WizardWoman then
    successionInfo._texture = "Combine_Etc_ClassSelect_Succesion_Witch.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_Witch.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_WITCH_SUCCESSION_DESC")
  elseif classType == __eClassType_Giant_Reserved2 then
    successionInfo._texture = ""
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PKOW.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAEGU_SUCCESSION_DESC")
  elseif classType == __eClassType_Giant_Reserved0 then
    successionInfo._texture = ""
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PQW.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "")
  elseif classType == __eClassType_Scholar then
    successionInfo._texture = ""
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_ClassSelect_Succesion_PNYW.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SCHOLAR_SUCCESSION_DESC")
  elseif classType == __eClassType_PRSA then
    successionInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Succesion_PRSA.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PRSA.dds"
    successionInfo._weaponType = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_SUCCESSION_WEAPON_TYPE")
    successionInfo._combatType = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_SUCCESSION_COMBAT_TYPE")
    successionInfo._desc = PAGetString(Defines.StringSheet_GAME, "LUA_DOSA_SUCCESSION_DESC")
  elseif classType == __eClassType_PWGE then
    successionInfo._texture = "Combine/Etc/Combine_Etc_ClassSelect_Succesion_PRSA.dds"
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_Skill_Succesion_PRSA.dds"
    successionInfo._weaponType = "\236\180\157\236\186\144 \236\160\132\236\138\185 \235\172\180\234\184\176"
    successionInfo._combatType = "\236\180\157\236\186\144 \236\160\132\236\138\185 \236\160\132\237\136\172\236\162\133\235\165\152"
    successionInfo._desc = "\236\180\157\236\186\144 \236\160\132\236\138\185 \236\132\164\235\170\133"
  else
    successionInfo._texture = ""
    successionInfo._bigTexture = "Combine/Etc/Combine_Etc_ClassSelect_Succesion_PNYW.dds"
    successionInfo._weaponType = "\235\172\180\234\184\176"
    successionInfo._combatType = "\236\160\132\237\136\172\236\162\133\235\165\152"
    successionInfo._desc = "\236\132\164\235\170\133"
  end
  _PA_ASSERT_NAME(CppEnums.NewClassTypeSuccession == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\160\132\236\138\185 \235\172\180\234\184\176\237\131\128\236\158\133/\234\179\181\234\178\169\237\131\128\236\158\133/\236\132\164\235\170\133 \236\138\164\237\138\184\235\167\129", "\236\161\176\234\180\145\235\175\188")
  return successionInfo
end
function PaGlobalFunc_Util_GetClassBasicSkillPhaseTable(classType)
  if classType == __eClassType_Warrior then
    return PaGlobal_TutorialPhase_BasicSkill_Warrior
  elseif classType == __eClassType_Hashashin then
    return PaGlobal_TutorialPhase_BasicSkill_7Layer
  elseif classType == __eClassType_Sage then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Warrior_Reserve2 then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_ElfRanger then
    return PaGlobal_TutorialPhase_BasicSkill_Ranger
  elseif classType == __eClassType_Guardian then
    return PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  elseif classType == __eClassType_Scholar then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Drakania then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Sorcerer then
    return PaGlobal_TutorialPhase_BasicSkill_Sorcerer
  elseif classType == __eClassType_Nova then
    return PaGlobal_TutorialPhase_BasicSkill_Sorcerer
  elseif classType == __eClassType_Corsair then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Lhan then
    return PaGlobal_TutorialPhase_BasicSkill_Ran
  elseif classType == __eClassType_Giant then
    return PaGlobal_TutorialPhase_BasicSkill_Giant
  elseif classType == __eClassType_Giant_Reserved0 then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Unknown2 then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Giant_Reserved2 then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_Tamer then
    return PaGlobal_TutorialPhase_BasicSkill_Tamer
  elseif classType == __eClassType_ShyWaman then
    return PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  elseif classType == __eClassType_ShyMan then
    return PaGlobal_TutorialPhase_BasicSkill_LocalHost
  elseif classType == __eClassType_Combattant then
    return PaGlobal_TutorialPhase_BasicSkill_Combattant
  elseif classType == __eClassType_BladeMaster then
    return PaGlobal_TutorialPhase_BasicSkill_BladeMaster
  elseif classType == __eClassType_BladeMasterWoman then
    return PaGlobal_TutorialPhase_BasicSkill_BladeMasterWomen
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    return PaGlobal_TutorialPhase_BasicSkill_BladeMasterWomen
  elseif classType == __eClassType_Mystic then
    return PaGlobal_TutorialPhase_BasicSkill_CombattantWomen
  elseif classType == __eClassType_Valkyrie then
    return PaGlobal_TutorialPhase_BasicSkill_Valkyrie
  elseif classType == __eClassType_Kunoichi then
    return PaGlobal_TutorialPhase_BasicSkill_NinjaWomen
  elseif classType == __eClassType_NinjaMan then
    return PaGlobal_TutorialPhase_BasicSkill_NinjaMan
  elseif classType == __eClassType_DarkElf then
    return PaGlobal_TutorialPhase_BasicSkill_DarkElf
  elseif classType == __eClassType_WizardMan then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_RangerMan then
    return PaGlobal_TutorialPhase_BasicSkill_7Layer
  elseif classType == __eClassType_KunoichiOld then
    return PaGlobal_TutorialPhase_BasicSkill_Wizard
  elseif classType == __eClassType_WizardWoman then
    return PaGlobal_TutorialPhase_BasicSkill_WizardWomen
  elseif classType == __eClassType_PRSA then
    return nil
  elseif classType == __eClassType_PWGE then
    return nil
  else
    return nil
  end
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. (\234\181\172) \234\184\176\235\179\184\234\184\176\236\136\160 \237\142\152\236\157\180\236\166\136", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetSolrareRankingClassBigBG(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Solare_War_01.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1636, 902, 1766)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 2160, 1804, 2290)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 2291, 902, 2421)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 1636, 1353, 1766)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 2160, 902, 2290)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 1505, 1804, 1635)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 2291, 1804, 2421)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 1636, 1804, 1766)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 2160, 1353, 2290)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 2291, 451, 2421)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 2160, 451, 2290)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1767, 451, 1897)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 1505, 1353, 1635)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1767, 902, 1897)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 2029, 1804, 2159)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 2029, 902, 2159)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 1767, 1353, 1897)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 2291, 1353, 2421)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 2029, 1353, 2159)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 1767, 1804, 1897)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1898, 451, 2028)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1898, 902, 2028)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 2029, 451, 2159)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 903, 1898, 1353, 2028)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1636, 451, 1766)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1505, 902, 1635)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1354, 1898, 1804, 2028)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1374, 902, 1504)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 452, 1374, 902, 1504)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\134\148\235\157\188\235\160\136\236\157\152 \236\176\189 \235\158\173\237\130\185 \237\129\180\235\158\152\236\138\164 BG", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetSolrareIngameClassBg(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoNameDefault("Combine/Etc/Combine_Etc_Solare_War_02.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 825, 191, 905)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 192, 1068, 382, 1148)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 574, 1068, 764, 1148)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 192, 825, 382, 905)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1068, 191, 1148)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 765, 1149, 955, 1229)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 1068, 1146, 1148)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 383, 825, 573, 905)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 383, 1068, 573, 1148)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 765, 1068, 955, 1148)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 574, 987, 764, 1067)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 574, 825, 764, 905)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 574, 1149, 764, 1229)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 765, 825, 955, 905)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 987, 1146, 1067)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 192, 987, 382, 1067)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 825, 1146, 905)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 906, 191, 986)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 383, 987, 573, 1067)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 192, 906, 382, 986)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 383, 906, 573, 986)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 574, 906, 764, 986)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 1, 987, 191, 1067)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 765, 906, 955, 986)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 765, 987, 955, 1067)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 383, 1149, 573, 1229)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 906, 1146, 986)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 1149, 1146, 1229)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 956, 1149, 1146, 1229)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\134\148\235\157\188\235\160\136\236\157\152 \236\176\189 \236\157\184\234\178\140\236\158\132 \237\129\180\235\158\152\236\138\164 \236\180\136\236\131\129\237\153\148", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetSolrareMiniClassIcon(control, classType)
  if control == nil then
    return
  end
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Minigame_06.dds")
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if classType == __eClassType_Warrior then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1277, 227, 1347)
  elseif classType == __eClassType_Hashashin then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1632, 227, 1702)
  elseif classType == __eClassType_Sage then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1703, 227, 1773)
  elseif classType == __eClassType_Warrior_Reserve2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_ElfRanger then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1277, 298, 1347)
  elseif classType == __eClassType_Guardian then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1561, 227, 1631)
  elseif classType == __eClassType_Scholar then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1714, 156, 1784)
  elseif classType == __eClassType_Drakania then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1703, 298, 1773)
  elseif classType == __eClassType_Sorcerer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1348, 227, 1418)
  elseif classType == __eClassType_Nova then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1561, 298, 1631)
  elseif classType == __eClassType_Corsair then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1632, 298, 1702)
  elseif classType == __eClassType_Lhan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1572, 156, 1642)
  elseif classType == __eClassType_Giant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1348, 298, 1418)
  elseif classType == __eClassType_Giant_Reserved0 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Unknown2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Giant_Reserved2 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1714, 85, 1784)
  elseif classType == __eClassType_Tamer then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1419, 227, 1489)
  elseif classType == __eClassType_ShyWaman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1572, 85, 1642)
  elseif classType == __eClassType_ShyMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Combattant then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1501, 85, 1571)
  elseif classType == __eClassType_BladeMaster then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1419, 298, 1489)
  elseif classType == __eClassType_BladeMasterWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1643, 156, 1713)
  elseif classType == __eClassType_BladeMaster_Reserved1 then
    x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 0, 0)
  elseif classType == __eClassType_Mystic then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1501, 156, 1571)
  elseif classType == __eClassType_Valkyrie then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1490, 227, 1560)
  elseif classType == __eClassType_Kunoichi then
    x1, y1, x2, y2 = setTextureUV_Func(control, 228, 1490, 298, 1560)
  elseif classType == __eClassType_NinjaMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1359, 85, 1429)
  elseif classType == __eClassType_DarkElf then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1430, 156, 1500)
  elseif classType == __eClassType_WizardMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 86, 1359, 156, 1429)
  elseif classType == __eClassType_RangerMan then
    x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1206, 227, 1276)
  elseif classType == __eClassType_KunoichiOld then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1643, 85, 1713)
  elseif classType == __eClassType_WizardWoman then
    x1, y1, x2, y2 = setTextureUV_Func(control, 15, 1430, 85, 1500)
  elseif classType == __eClassType_PRSA then
    x1, y1, x2, y2 = setTextureUV_Func(control, 299, 1703, 369, 1773)
  elseif classType == __eClassType_PWGE then
    x1, y1, x2, y2 = setTextureUV_Func(control, 299, 1703, 369, 1773)
  end
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  _PA_ASSERT_NAME(CppEnums.NewClassType == __eClassType_PRSA, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\134\148\235\157\188\235\160\136\236\157\152 \236\176\189 \236\158\145\236\157\128 \237\129\180\235\158\152\236\138\164 \236\180\136\236\131\129\237\153\148 \236\149\132\236\157\180\236\189\152", "\236\161\176\234\180\145\235\175\188")
end
function PaGlobalFunc_Util_SetGuildMemberGradeIcon(control, guildMemberGrade)
  if control == nil then
    return
  end
  control:ChangeTextureInfoName("Renewal/PcRemaster/Remaster_ETC_Guild.dds")
  if __eGuildMemberGradeMaster == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 227, 267, 253)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeAdviser == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 68, 1, 110, 27)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSubMaster == guildMemberGrade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 200, 267, 226)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeNormal == guildMemberGrade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 146, 267, 172)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeGunner == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 68, 28, 110, 54)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSupplyOfficer == guildMemberGrade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 173, 267, 199)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeJunior == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 83, 44, 109)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeScribe == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 44, 543, 70)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeChiefOfStaff == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 114, 543, 140)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeMissionOfficer == guildMemberGrade then
    control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 141, 543, 167)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobalFunc_Util_CraftLevelReplace(lev)
  if lev >= 1 and lev <= 10 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_1") .. lev
  elseif lev >= 11 and lev <= 20 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_2") .. lev - 10
  elseif lev >= 21 and lev <= 30 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_3") .. lev - 20
  elseif lev >= 31 and lev <= 40 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_4") .. lev - 30
  elseif lev >= 41 and lev <= 50 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40
  elseif lev >= 51 and lev <= 80 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_6") .. lev - 50
  elseif lev >= 81 and lev <= 180 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80
  end
  return lev
end
function PaGlobalFunc_Util_CraftLevelColorReplace(lev)
  if lev >= 1 and lev <= 10 then
    lev = "<PAColor0xFFC4C4C4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_1") .. lev .. "<PAOldColor>"
  elseif lev >= 11 and lev <= 20 then
    lev = "<PAColor0xFF76B24D>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_2") .. lev - 10 .. "<PAOldColor>"
  elseif lev >= 21 and lev <= 30 then
    lev = "<PAColor0xFF3B8BBE>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_3") .. lev - 20 .. "<PAOldColor>"
  elseif lev >= 31 and lev <= 40 then
    lev = "<PAColor0xFFEBC467>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_4") .. lev - 30 .. "<PAOldColor>"
  elseif lev >= 41 and lev <= 50 then
    if true == _ContentsGroup_ChinaFontColor then
      lev = "<PAColor0xffffad38>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40 .. "<PAOldColor>"
    else
      lev = "<PAColor0xFFD04D47>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40 .. "<PAOldColor>"
    end
  elseif lev >= 51 and lev <= 80 then
    lev = "<PAColor0xFFB23BC7>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_6") .. lev - 50 .. "<PAOldColor>"
  elseif lev >= 81 and lev <= 180 then
    lev = "<PAColor0xFFC78045>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80 .. "<PAOldColor>"
  end
  return lev
end
function PaGlobalFunc_Util_CheckSeasonEquip(itemStaticWrapper)
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer or nil == itemStaticWrapper then
    UI.ASSERT_NAME(nil ~= selfPlayer, "selfPlayer\234\176\128 nil\236\157\180\235\169\180 \236\149\136 \235\144\169\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    UI.ASSERT_NAME(nil ~= itemStaticWrapper, "itemStaticWrapper\234\176\128 nil\236\157\180\235\169\180 \236\149\136 \235\144\169\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
  end
  local isSeasonCharacter = selfPlayer:isSeasonCharacter()
  local useType = itemStaticWrapper:getSeasonItemType()
  local isHardCoreCharacter = ToClient_isHardCoreCharacter()
  if isHardCoreCharacter == true then
    if useType == __eSeasonItemTypeUseHardCoreCharacter then
      return true
    else
      return false
    end
  elseif useType == __eSeasonItemTypeUseHardCoreCharacter then
    return false
  end
  if __eSeasonItemTypeUseAll == useType then
    return true
  elseif __eSeasonItemTypeUseNormalCharacter == useType then
    return not isSeasonCharacter
  elseif __eSeasonItemTypeUseSeasonCharacter == useType then
    return isSeasonCharacter
  else
    return false
  end
end
function PaGlobalFunc_Util_IsHorse(vehicleType)
  if __eVehicleType_Horse == vehicleType or __eVehicleType_Camel == vehicleType or __eVehicleType_Donkey == vehicleType or __eVehicleType_Elephant == vehicleType or __eVehicleType_Ridable_BabyElephant == vehicleType or __eVehicleType_RaceHorse == vehicleType then
    return true
  end
  return false
end
function PaGlobalFunc_Util_IsCarriage(vehicleType)
  if __eVehicleType_Carriage == vehicleType or __eVehicleType_CowCarriage == vehicleType or __eVehicleType_Tank == vehicleType or __eVehicleType_RepairableCarriage == vehicleType then
    return true
  end
  return false
end
function PaGlobalFunc_Util_IsShip(vehicleType)
  if __eVehicleType_Boat == vehicleType or __eVehicleType_Raft == vehicleType or __eVehicleType_FishingBoat == vehicleType or __eVehicleType_FastShip == vehicleType then
    return true
  end
  return false
end
function PaGlobalFunc_Util_IsBigShip(vehicleType)
  if __eVehicleType_GalleyShip == vehicleType or __eVehicleType_PersonalBattleShip == vehicleType or __eVehicleType_PersonalTradeShip == vehicleType or __eVehicleType_PersonalBoat == vehicleType or __eVehicleType_CashPersonalTradeShip == vehicleType or __eVehicleType_CashPersonalBattleShip == vehicleType or __eVehicleType_Carrack == vehicleType then
    return true
  end
  return false
end
Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP = {
  _NORMAL = 0,
  _CARRIAGE = 1,
  _SHIP = 2,
  _BIGSHIP = 3,
  _COUNT = 4
}
Util.VEHICLE_EQUIP_TYPE_TEXTURE_PATH = {
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] = "combine/icon/combine_equip_icon_00.dds",
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE] = "combine/icon/combine_equip_icon_00.dds",
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP] = "renewal/pcremaster/remaster_icon_01.dds",
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP] = "renewal/pcremaster/remaster_icon_01.dds"
}
Util.VEHICLE_SLOTNO_TO_EQUIPNO = {
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] = {
    [1] = 3,
    [2] = 4,
    [3] = 5,
    [4] = 6,
    [5] = 12
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE] = {
    [1] = 4,
    [2] = 5,
    [3] = 6,
    [4] = 13,
    [5] = 25
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP] = {
    [1] = 4,
    [2] = 5,
    [3] = 6,
    [4] = 25
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP] = {
    [1] = 3,
    [2] = 4,
    [3] = 5,
    [4] = 25,
    [5] = 12
  }
}
Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO = {
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] = {
    [1] = 14,
    [2] = 15,
    [3] = 16,
    [4] = 17
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE] = {
    [1] = 14,
    [2] = 15,
    [3] = 26
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP] = {
    [1] = 15,
    [2] = 16,
    [3] = 14,
    [4] = 26
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP] = {
    [1] = 14,
    [2] = 15,
    [3] = 16,
    [4] = 26
  }
}
Util.VEHICLE_EQUIP_TYPE_ICON_UV = {
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] = {
    [1] = {
      x1 = 95,
      y1 = 272,
      x2 = 141,
      y2 = 318
    },
    [2] = {
      x1 = 48,
      y1 = 272,
      x2 = 94,
      y2 = 318
    },
    [3] = {
      x1 = 189,
      y1 = 272,
      x2 = 235,
      y2 = 318
    },
    [4] = {
      x1 = 142,
      y1 = 272,
      x2 = 188,
      y2 = 318
    },
    [5] = {
      x1 = 236,
      y1 = 272,
      x2 = 282,
      y2 = 318
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE] = {
    [1] = {
      x1 = 377,
      y1 = 272,
      x2 = 423,
      y2 = 318
    },
    [2] = {
      x1 = 283,
      y1 = 366,
      x2 = 329,
      y2 = 412
    },
    [3] = {
      x1 = 236,
      y1 = 366,
      x2 = 282,
      y2 = 412
    },
    [4] = {
      x1 = 424,
      y1 = 366,
      x2 = 470,
      y2 = 412
    },
    [5] = {
      x1 = 424,
      y1 = 272,
      x2 = 470,
      y2 = 318
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP] = {
    [1] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [2] = {
      x1 = 1,
      y1 = 302,
      x2 = 43,
      y2 = 344
    },
    [3] = {
      x1 = 87,
      y1 = 216,
      x2 = 129,
      y2 = 258
    },
    [4] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP] = {
    [1] = {
      x1 = 87,
      y1 = 259,
      x2 = 129,
      y2 = 301
    },
    [2] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [3] = {
      x1 = 173,
      y1 = 259,
      x2 = 215,
      y2 = 301
    },
    [4] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    },
    [5] = {
      x1 = 173,
      y1 = 302,
      x2 = 215,
      y2 = 344
    }
  }
}
Util.VEHICLE_PEARLEQUIP_TYPE_ICON_UV = {
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] = {
    [1] = {
      x1 = 95,
      y1 = 225,
      x2 = 141,
      y2 = 271
    },
    [2] = {
      x1 = 48,
      y1 = 225,
      x2 = 94,
      y2 = 271
    },
    [3] = {
      x1 = 189,
      y1 = 225,
      x2 = 235,
      y2 = 271
    },
    [4] = {
      x1 = 142,
      y1 = 225,
      x2 = 188,
      y2 = 271
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE] = {
    [1] = {
      x1 = 424,
      y1 = 225,
      x2 = 470,
      y2 = 271
    },
    [2] = {
      x1 = 377,
      y1 = 225,
      x2 = 423,
      y2 = 271
    },
    [3] = {
      x1 = 377,
      y1 = 319,
      x2 = 423,
      y2 = 365
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP] = {
    [1] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [2] = {
      x1 = 44,
      y1 = 302,
      x2 = 86,
      y2 = 344
    },
    [3] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [4] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  },
  [Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP] = {
    [1] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [2] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [3] = {
      x1 = 216,
      y1 = 259,
      x2 = 258,
      y2 = 301
    },
    [4] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  }
}
function PaGlobalFunc_Util_VehicleEquipNoToSlotNo(vehicleEquipType, slotNo, isPearl)
  local equipNoList
  if true == isPearl then
    equipNoList = Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO
  else
    equipNoList = Util.VEHICLE_SLOTNO_TO_EQUIPNO
  end
  if nil == equipNoList then
    _PA_ASSERT(false, "EquipNo\235\165\188 \234\176\128\236\160\184\236\152\164\235\141\152 \236\164\145 vehicleEquipType \236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164." .. tostring(vehicleEquipType))
    return -1
  end
  if nil == equipNoList[vehicleEquipType] then
    _PA_ASSERT(false, "EquipNo\235\165\188 \234\176\128\236\160\184\236\152\164\235\141\152 \236\164\145 vehicleEquipType \236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164." .. tostring(vehicleEquipType))
    return -1
  end
  if nil == equipNoList[vehicleEquipType][slotNo] then
    return -1
  end
  return equipNoList[vehicleEquipType][slotNo]
end
function PaGlobalFunc_Util_getVehicleTypeGroup(vehicleType)
  if nil == vehicleType then
    return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._COUNT
  end
  if true == PaGlobalFunc_Util_IsHorse(vehicleType) then
    return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL
  elseif true == PaGlobalFunc_Util_IsCarriage(vehicleType) then
    return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._CARRIAGE
  elseif true == PaGlobalFunc_Util_IsShip(vehicleType) then
    return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP
  elseif true == PaGlobalFunc_Util_IsBigShip(vehicleType) then
    return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP
  end
  return Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._COUNT
end
function PaGlobalFunc_Util_getVehicleSlotNoToEquipNo(vehicleEquipType, equipNo, isPearl)
  local equipNoList
  if true == isPearl then
    equipNoList = Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO
  else
    equipNoList = Util.VEHICLE_SLOTNO_TO_EQUIPNO
  end
  if nil == equipNoList then
    _PA_ASSERT(false, "\237\131\145\236\138\185\235\172\188 EquipNo\235\165\188 \234\181\172\236\132\177\237\149\152\236\167\128 \235\170\187\237\150\136\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\235\176\148\235\158\141\235\139\136\235\139\164." .. tostring(vehicleEquipType))
    return -1
  end
  if nil == equipNoList[vehicleEquipType] then
    _PA_ASSERT(false, "\237\131\145\236\138\185\235\172\188 EquipNo\235\165\188 \234\176\128\236\160\184\236\152\164\235\141\152 \236\164\145 vehicleEquipType \236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164." .. tostring(vehicleEquipType))
    return -1
  end
  for key, value in pairs(equipNoList[vehicleEquipType]) do
    if value == equipNo then
      return key
    end
  end
  return -1
end
Util.ResetWebUI = {
  count = 0,
  controls = {}
}
function PaGlobal_Util_RegistWebResetControl(control)
  if nil == control then
    return
  end
  local currentCount = Util.ResetWebUI.count
  control:addInputEvent("Mouse_LUp", "PaGlobal_Util_ResetWebUIMessage()")
  control:addInputEvent("Mouse_On", "PaGlobal_Util_ShowWebResetSimpleTooltip(true , " .. tostring(currentCount) .. " )")
  control:addInputEvent("Mouse_Out", "PaGlobal_Util_ShowWebResetSimpleTooltip(false)")
  Util.ResetWebUI.controls[currentCount] = control
  Util.ResetWebUI.count = currentCount + 1
end
function PaGlobal_Util_ResetWebUIMessage()
  local DoResetWebUI = function()
    ToClient_StopMusic(false)
    ToClient_resetWebUI()
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
  local msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_RESETWEBUI_MESSAGE_DESC")
  local messageBoxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = DoResetWebUI,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Util_ShowWebResetSimpleTooltip(isShow, index)
  if nil == TooltipSimple_Hide or nil == TooltipSimple_Show then
    return
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local control = Util.ResetWebUI.controls[index]
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_RESETWEBUI_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_RESETWEBUI_DESC")
  if nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
Util.Help = {
  count = 0,
  desc = {
    PanelImportantKnowledge = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Knowledge"),
    PanelAlchemy = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Alchemy"),
    PanelCook = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Cook"),
    PanelManufacture = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Product"),
    HouseAuction = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_HouseAuction"),
    PanelBuyDrink = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Alcohol"),
    DeliveryCarriageinformation = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Goods"),
    DeliveryInformation = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Trans"),
    DeliveryPerson = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Char_Trans"),
    DeliveryRequest = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Sent_Receipt"),
    SpiritEnchant = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_PotenBreak"),
    PanelWindowEquipment = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Equip"),
    PanelExchangeWithPC = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Person_Deal"),
    PanelWindowExtractionCrystal = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Extraction"),
    PanelWindowExtractionEnchantStone = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Stone_Extraction"),
    PanelGameExit = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Game_Exit"),
    PanelGuild = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Guild"),
    PanelClan = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Clan"),
    PanelHouseControl = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_House"),
    PanelWindowInventory = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Bag"),
    PanelServantInventory = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_BoardingBag"),
    PanelLordMenu = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Seignior"),
    Panelmail = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_MailRead"),
    PanelMailDetail = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_MailSend"),
    PanelMailSend = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_MailSend"),
    UIGameOption = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_GameOption"),
    PanelQuestHistory = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Request"),
    PanelQuestReward = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Request_Reward"),
    PanelFixEquip = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Repair"),
    PanelServantinfo = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_BoardingInfo"),
    PanelEnableSkill = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_GetSkill"),
    PanelWindowSkill = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Skill"),
    PanelSkillAwaken = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_SkillAwaken"),
    Socket = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_PotenTransition"),
    PanelWindowStableMating = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Mating"),
    PanelWindowStableMarket = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_HorseMarket"),
    PanelWindowStableRegister = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Regist"),
    PanelWindowStableShop = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Obedience"),
    PanelWindowWharfShop = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_GUIDE_HARBOR"),
    PanelTradeMarketGraph = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_QuoteStatus"),
    HouseManageWork = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_TaskManage"),
    SelfCharacterInfo = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_MyInfo"),
    PanelFriends = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_FriendsList"),
    WareHouse = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_WareHouse"),
    NpcShop = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_NpcShop"),
    HouseRank = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_HouseRank"),
    TerritoryAuth = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_ImperialTrade"),
    Chatting = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Chatting"),
    Worker = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Worker"),
    WarInfo = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_WarInfo"),
    ItemMarket = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_ItemMarket"),
    Pet = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Pet"),
    ProductNote = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Productnote"),
    Dye = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_Dye"),
    AlchemyStone = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_AlchemyStone"),
    LifeRanking = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_LifeRanking"),
    ClothExchange = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_ClothExchange"),
    PanelWindowArtifact = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_ARTIFACTS"),
    PanelWindowExtractionArtifact = PAGetString(Defines.StringSheet_GAME, "LUA_HELPMESSAGE_ARTIFACTS_EXTRACTION")
  },
  controls = {}
}
function PaGlobal_Util_RegistHelpTooltipEvent(control, descType)
  if nil == control then
    return
  end
  local currentCount = Util.Help.count
  control:addInputEvent("Mouse_On", "PaGlobal_Util_ShowHelpTooltip(true , " .. tostring(currentCount) .. " , " .. descType .. " )")
  control:addInputEvent("Mouse_Out", "PaGlobal_Util_ShowHelpTooltip(false)")
  Util.Help.controls[currentCount] = control
  Util.Help.count = currentCount + 1
end
function PaGlobal_Util_ShowHelpTooltip(isShow, index, descType)
  if nil == TooltipSimple_Hide or nil == TooltipSimple_Show then
    return
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local control = Util.Help.controls[index]
  local name = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_GAMETIPS_BTN_HELP")
  local desc = Util.Help.desc[descType]
  if nil ~= control and nil ~= desc then
    TooltipSimple_Show(control, name, desc)
  end
end
function PaGlobalFunc_CharacterLifeInfo_CraftLevel_Replace(lev, lifeType)
  if lev >= 1 and lev <= 10 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_1") .. lev
  elseif lev >= 11 and lev <= 20 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_2") .. lev - 10
  elseif lev >= 21 and lev <= 30 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_3") .. lev - 20
  elseif lev >= 31 and lev <= 40 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_4") .. lev - 30
  elseif lev >= 41 and lev <= 50 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_5") .. lev - 40
  elseif lev >= 51 and lev <= 80 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_6") .. lev - 50
  elseif lev >= 81 and lev <= 100 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80
  elseif lev >= 101 and lev <= 180 then
    lev = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_CRAFTLEVEL_GROUP_7") .. lev - 80
  end
  return lev
end
function PaGlobalFunc_Util_ChangeKeyguideTexture(control, actionType)
  if nil == Panel_ConsoleKeyGuide then
    return
  end
  if nil == control or nil == actionType then
    return
  end
  local uiIdx = PaGlobalFunc_ConsoleKeyGuide_ConvertActionInputTypeToIconIndex(actionType)
  local x1, y1, x2, y2 = PaGlobalFunc_ConsoleKeyGuide_GetKeyGuideIconUVByIndex(uiIdx)
  control:ChangeTextureInfoNameAsync("renewal/ui_icon/console_xboxkey_00.dds")
  x1, y1, x2, y2 = setTextureUV_Func(control, x1, y1, x2, y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobalFunc_Util_getIsSelfService()
  if true == isGameTypeSA() then
    return false
  end
  return true
end
function PaGlobalFunc_Util_GetServerGroupName(serverName)
  local serverGroupName = ""
  if nil == serverName or "" == serverName then
    return ""
  end
  local splitString = string.split(serverName, "-")
  local serverNum = string.match(serverName, "[0-9]")
  if nil == serverNum then
    serverGroupName = splitString[1]
  else
    local splitString2 = string.split(splitString[1], serverNum)
    serverGroupName = splitString2[1]
  end
  return serverGroupName
end
function PaGlobalFunc_Util_IsSnappedPanel(panelControl)
  if nil == panelControl then
    return false
  end
  local currentSnapControl = ToClient_getSnappedControl()
  if nil ~= currentSnapControl then
    local parentPanel = currentSnapControl:GetParentPanel()
    if nil ~= parentPanel and Panel_Window_CargoLoading_ALL:GetID() ~= parentPanel:GetID() then
      return false
    end
  end
  return true
end
function PaGlobalFunc_Util_GetItemGradeColorName(enchantItemKey, isUseRoma)
  local itemSSW = getItemEnchantStaticStatus(enchantItemKey)
  if nil == itemSSW then
    return ""
  end
  local name = itemSSW:getName()
  local itemGrade = itemSSW:getGradeType()
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() then
    if itemSSW:isSpecialEnchantItem() == false or itemSSW:isKingAccessory() == true then
      if 1 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_16") .. " " .. name
      elseif 2 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_17") .. " " .. name
      elseif 3 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_18") .. " " .. name
      elseif 4 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_19") .. " " .. name
      elseif 5 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_20") .. " " .. name
      elseif 6 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_21") .. " " .. name
      elseif 7 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_22") .. " " .. name
      elseif 8 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_23") .. " " .. name
      elseif 9 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_24") .. " " .. name
      elseif 10 == enchantLevel then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_25") .. " " .. name
      end
    end
  elseif enchantLevel > 0 and enchantLevel < 16 then
    name = "+" .. tostring(enchantLevel) .. " " .. name
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_UTIL_UI_SLOT_ENCHANTLEVEL_" .. tostring(enchantLevel) .. "") .. " " .. name
  end
  if true == isUseRoma and nil ~= HighRomaEnchantLevel_ReplaceString then
    local enchantLevelRomaString = HighRomaEnchantLevel_ReplaceString(enchantLevel)
    name = enchantLevelRomaString .. name
  end
  local colorName = ""
  if 0 == itemGrade then
    colorName = "<PAColor0xffffffff>[" .. name .. "]<PAOldColor>"
  elseif 1 == itemGrade then
    colorName = "<PAColor0xff5dff70>[" .. name .. "]<PAOldColor>"
  elseif 2 == itemGrade then
    colorName = "<PAColor0xff4b97ff>[" .. name .. "]<PAOldColor>"
  elseif 3 == itemGrade then
    colorName = "<PAColor0xffffc832>[" .. name .. "]<PAOldColor>"
  elseif 4 == itemGrade then
    colorName = "<PAColor0xffff6c00>[" .. name .. "]<PAOldColor>"
  else
    colorName = "<PAColor0xffffffff>[" .. name .. "]<PAOldColor>"
  end
  return colorName
end
function PaGlobalFunc_Util_MarketPriceChange(price_s64)
  if nil == price_s64 then
    return
  end
  local number1 = toInt64(0, 100000000)
  local number2 = toInt64(0, 1000000)
  local number3 = toInt64(0, 1000000000)
  local number4 = toInt64(0, 10000)
  local length = string.len(tostring(price_s64))
  local replaceNumber
  if false then
    if price_s64 >= number1 then
      replaceNumber = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UTIL_NUMBERCHANGE_100MILLION", "number", string.sub(tostring(price_s64), 0, length - 8))
      if "0" ~= string.sub(tostring(price_s64), length - 7, length - 7) then
        replaceNumber = replaceNumber .. string.sub(tostring(price_s64), length - 7, length - 4) .. "\235\167\140"
      elseif "0" ~= string.sub(tostring(price_s64), length - 6, length - 6) then
        replaceNumber = replaceNumber .. string.sub(tostring(price_s64), length - 6, length - 4) .. "\235\167\140"
      elseif "0" ~= string.sub(tostring(price_s64), length - 5, length - 5) then
        replaceNumber = replaceNumber .. string.sub(tostring(price_s64), length - 5, length - 4) .. "\235\167\140"
      elseif "0" ~= string.sub(tostring(price_s64), length - 4, length - 4) then
        replaceNumber = replaceNumber .. string.sub(tostring(price_s64), length - 4, length - 4) .. "\235\167\140"
      end
    end
  elseif price_s64 >= number3 then
    replaceNumber = string.sub(tostring(price_s64), 0, length - 9) .. "B"
  elseif price_s64 >= number2 then
    replaceNumber = string.sub(tostring(price_s64), 0, length - 6) .. "M"
  end
  if nil ~= replaceNumber then
    return replaceNumber
  end
  return price_s64
end
function FromClient_CallFromClientEventByInteraction(param)
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  if param <= 0 then
    return
  end
  if param == 1 then
    HandleEventLUp_MagnusEasyTeleportMap_Open()
  end
end
function PaGlobalFunc_Util_OpenRateView(callFunc)
  if ToClient_isConsole() == true then
    if ToClient_isPS4() == true then
      ToClient_RateViewNativeWebBrowserPS4()
    else
      ToClient_RateViewNativeWebBrowser(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VIEWRATE_BTN"))
    end
  else
    PaGlobalFunc_Util_SetCallFuncByOpenRateView(callFunc)
    local openRateView = function()
      if _ContentsOption_CH_Homepage == false then
        PaGlobalFunc_Util_CallFuncByOpenRateViewAfterClear()
        Panel_WebHelper_ShowToggle("pearlitem_probability")
      else
        local linkURL = "https://bd.qq.com/cp/a20240715gwyqyy/adventurer.html?newid=18463280"
        ToClient_OpenChargeWebPage(linkURL, false)
      end
    end
    local cancleOpenRateView = function()
      PaGlobalFunc_Util_SetCallFuncByOpenRateView(nil)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_RATEVIEW_MSG"),
      functionYes = openRateView,
      functionNo = cancleOpenRateView,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
local openFuncWhenOpenRateView
function PaGlobalFunc_Util_SetCallFuncByOpenRateView(func)
  openFuncWhenOpenRateView = func
end
function PaGlobalFunc_Util_CallFuncByOpenRateViewAfterClear()
  if openFuncWhenOpenRateView ~= nil then
    openFuncWhenOpenRateView()
  end
  PaGlobalFunc_Util_SetCallFuncByOpenRateView(nil)
end
function PaGlobalFunc_Util_MakeRateDotString(rate, maxLowCount, withPercentStr)
  if rate == nil then
    UI.ASSERT_NAME(false, "PaGlobalFunc_Util_MakeRateDotString \236\139\164\237\140\168! rate \234\176\146\236\157\180 nil\236\157\180\235\139\164.", "\236\157\180\236\163\188")
    return ""
  elseif rate < 0 then
    UI.ASSERT_NAME(false, "PaGlobalFunc_Util_MakeRateDotString \236\139\164\237\140\168! rate \234\176\146\236\157\180 0\235\179\180\235\139\164 \236\158\145\235\139\164.", "\236\157\180\236\163\188")
    return ""
  end
  if maxLowCount == nil then
    UI.ASSERT_NAME(false, "PaGlobalFunc_Util_MakeRateDotString \236\139\164\237\140\168! maxLowCount \234\176\146\236\157\180 nil\236\157\180\235\139\164.", "\236\157\180\236\163\188")
    return ""
  elseif maxLowCount < 0 then
    UI.ASSERT_NAME(false, "PaGlobalFunc_Util_MakeRateDotString \236\139\164\237\140\168! maxLowCount \234\176\146\236\157\180 0\235\179\180\235\139\164 \236\158\145\235\139\164.", "\236\157\180\236\163\188")
    return ""
  end
  local rv = string.format("%." .. tostring(maxLowCount) .. "f", rate * 100)
  local rvLen = string.len(rv)
  local charArray = Array.new()
  for index = 1, rvLen do
    local rvChar = string.sub(rv, index, index)
    charArray:push_back(rvChar)
  end
  local isRemoved = false
  for index = #charArray, 1, -1 do
    local rvChar = charArray[index]
    if rvChar ~= nil then
      if rvChar == "0" then
        isRemoved = true
        table.remove(charArray, index)
      elseif rvChar == "." then
        isRemoved = true
        table.remove(charArray, index)
        break
      else
        break
      end
    end
  end
  if isRemoved == true then
    rv = ""
    for key, value in pairs(charArray) do
      if value ~= nil then
        rv = rv .. value
      end
    end
  end
  if withPercentStr == nil or withPercentStr == false then
    return rv
  else
    return rv .. "%"
  end
end
function PaGlobalFunc_Util_GetUrlEncode(urlText)
  local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
  end
  urlText = string.gsub(urlText, "([^%w ])", char_to_hex)
  urlText = string.gsub(urlText, " ", "+")
  return urlText
end
function PaGlobalFunc_Util_isMessageBlockedFromPSN(chattingMessage)
  if ToClient_isPS5() == false then
    return false
  end
  if chattingMessage == nil or chattingMessage == "" then
    return false
  end
  if ToClient_isMessageFromBlockedPSNUserPS5(chattingMessage) == true then
    return true
  end
  return false
end
registerEvent("FromClient_LuaTimer_UpdatePerFrame", "luaTimer_UpdatePerFrame")
registerEvent("FromClient_CallFromClientEventByInteraction", "FromClient_CallFromClientEventByInteraction")
