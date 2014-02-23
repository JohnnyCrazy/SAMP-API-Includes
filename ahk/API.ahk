#NoEnv 
 
; Error-Codes 
API_ERROR_NONE 								:= 0
API_ERROR_SNAPSHOT_FAILED 					:= 1
API_ERROR_SAMP_NOT_FOUND 					:= 2
API_ERROR_REMOTE_MEMORY_ALLOCATION_FAILED 	:= 3
API_ERROR_WRITEPROCESSMEMORY_FAILED 		:= 4
API_ERROR_GETPROCADDRESS_FAILED 			:= 5
API_ERROR_REMOTETHREAD_FAILED 				:= 6
API_ERROR_INVALID_GTA_HANDLE				:= 7
API_ERROR_PIPE_DOESNT_RESPOND 				:= 8
API_ERROR_STRING_TOO_LONG					:= 9

PLAYER_STATE_LEAVING_VEHICLE 				:= 0
PLAYER_STATE_NORMAL 						:= 1
PLAYER_STATE_DRIVING 						:= 50
PLAYER_STATE_DYING 							:= 54
PLAYER_STATE_DEAD 							:= 55

CALLBACK_HEAL								:= 0
CALLBACK_ARMOR								:= 1
CALLBACK_POSITION							:= 2
CALLBACK_ENTEREXIT							:= 3
CALLBACK_VEHICLE_ENTEREXIT					:= 4
CALLBACK_VEHICLE_HEALTH						:= 5
CALLBACK_VEHICLE_ENGINE						:= 6
CALLBACK_VEHICLE_LOCK						:= 7
CALLBACK_VEHICLE_SPEED						:= 8
CALLBACK_WEAPON_CLIP						:= 9
CALLBACK_WEAPON_TOTALCLIP					:= 10
CALLBACK_WEAPON_SWITCH						:= 11
CALLBACK_CHATLOG							:= 12


PATH_API := RelToAbs(A_ScriptDir, "..\..\API.dll")

hModule := DllCall("LoadLibrary", Str, PATH_API)
if(hModule == -1 || hModule == 0)
{
	MsgBox, 48, API - Fehler, Die API.dll konnte nicht gefunden werden.`nDer Keybinder wird nun beendet.
	ExitApp
}

; Funktionsadressen in der DLL
Init_func 				:= DllCall("GetProcAddress", UInt, hModule, Str, "API_Init")
SetParam_func 			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_SetParam")
ReadMemory_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ReadMemory")
WriteMemory_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_WriteMemory")
GetBasePointer_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetBasePointer")
GetCommandLine_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetCommandLine")
GetLastError_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetLastError")
SetLastError_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_SetLastError")
SendChat_func 			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_SendChat")
ShowGameText_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ShowGameText")
AddChatMessage_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_AddChatMessage")
ShowDialog_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ShowDialog")
IsDialogOpen_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsDialogOpen")
GetLastDialogId_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetLastDialogId")
GetLastDialogType_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetLastDialogType")
BlockChatInput_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BlockChatInput")
GetChatLine_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetChatLine")
GetChatLineFromFile_func:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetChatLineFromFile")
IsChatOpen_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsChatOpen")

GetScreenSizeX_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetScreenSizeX")
GetScreenSizeY_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetScreenSizeY")
GetFramerate_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetFramerate")
GetCurrentWeatherId_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetCurrentWeatherId")
GetZoneName_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetZoneName")
GetCityName_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetCityName")
GetZoneNameByCoords_func:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetZoneNameByCoords")
GetCityNameByCoords_func:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetCityNameByCoords")
GetMarkerPos_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetMarkerPos") 
GetLastMousePosOnMenuMap_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetLastMousePosOnMenuMap")
GetMapMarkerPos_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetMapMarkerPos")
FindGroundZForPosition_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_FindGroundZForPosition")
WorldToScreen_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_WorldToScreen")
ScreenToWorld_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ScreenToWorld")
RegisterTextBind_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_RegisterTextBind")
UnregisterTextBind_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_UnregisterTextBind")
UnregisterAllTextBinds_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_UnregisterAllTextBinds")
TextBindTimer_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextBindTimer")
IsMenuOpen_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsMenuOpen")

GetPlayerId_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerId")
GetPlayerName_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerName")
GetServerIp_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetServerIp")
GetServerPort_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetServerPort")

; //////////////////
; 	CPed.h
; //////////////////
GetPlayerCPed_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerCPed")
GetPlayerHealth_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerHealth")
GetPlayerArmor_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerArmor")
GetPlayerMoney_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerMoney")
GetPlayerWanteds_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWanteds")
GetPlayerPosition_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerPosition")
IsPlayerInRangeOfPoint_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInRangeOfPoint")
IsPlayerInRangeOfPoint2D_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInRangeOfPoint2D")
IsPlayerInAnyInterior_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInAnyInterior")
IsPlayerFrozen_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerFrozen")
GetPlayerWeaponSlot_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponSlot")
GetPlayerWeaponId_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponId")
GetPlayerWeaponName_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponName")
GetPlayerWeaponClip_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponClip")
GetPlayerWeaponTotalClip_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponTotalClip")
GetPlayerWeaponState_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerWeaponState")
GetPlayerState_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerState")

; //////////////////
; 	Vehicle.h
; //////////////////
GetVehiclePointer_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehiclePointer")
GetVehicleModelId_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleModelId")
GetVehicleModelName_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleModelName")
GetVehicleModelNameById_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleModelNameById")
GetVehicleType_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleType")
GetVehicleHealth_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleHealth")
GetVehicleRadioStation_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleRadioStation")
GetVehicleRadioStationName_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleRadioStationName")
GetVehicleFreeSeats_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleFreeSeats")
GetVehicleSpeed_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleSpeed")
GetVehicleFirstColor_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleFirstColor")
GetVehicleSecondColor_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleSecondColor")
GetVehicleColor_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleColor")
GetVehicleColorRGB_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleColorRGB")
GetVehicleColorARGB_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_GetVehicleColorARGB")


IsPlayerInAnyVehicle_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInAnyVehicle")
IsPlayerDriver_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerDriver")
IsPlayerPassenger_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerPassenger")
IsVehicleSeatUsed_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleSeatUsed")
IsVehicleLocked_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleLocked")
IsVehicleSirenEnabled_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleSirenEnabled")
IsVehicleHornEnabled_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleHornEnabled")
IsVehicleAlternateSirenEnabled_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleAlternateSirenEnabled")
IsVehicleEngineEnabled_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleEngineEnabled")
IsVehicleLightEnabled_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_IsVehicleLightEnabled")
IsPlayerInCar_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInCar")
IsPlayerInPlane_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInPlane")
IsPlayerInBoat_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInBoat")
IsPlayerInTrain_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInTrain")
IsPlayerInBike_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_IsPlayerInBike")
; //////////////////
; 	Draw
; //////////////////
TextCreate_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextCreate")
TextDestroy_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextDestroy")
TextSetShadow_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextSetShadow")
TextSetShown_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextSetShown")
TextSetColor_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextSetColor")
TextSetPos_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextSetPos")
TextSetString_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextSetString")
TextUpdate_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_TextUpdate")

BoxCreate_func 			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxCreate")
BoxDestroy_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxDestroy")
BoxSetShown_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetShown")
BoxSetBorder_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetBorder")
BoxSetBorderColor_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetBorderColor")
BoxSetColor_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetColor")
BoxSetHeight_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetHeight")
BoxSetPos_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetPos")
BoxSetWidth_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_BoxSetWidth")

LineCreate_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineCreate")
LineDestroy_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineDestroy")
LineSetShown_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineSetShown")
LineSetColor_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineSetColor")
LineSetWidth_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineSetWidth")
LineSetPos_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_LineSetPos")

ImageCreate_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageCreate")
ImageDestroy_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageDestroy")
ImageSetShown_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageSetShown")
ImageSetAlign_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageSetAlign")
ImageSetPos_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageSetPos")
ImageSetRotation_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ImageSetRotation")

DestroyAllVisual_func	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_DestroyAllVisual")
ShowAllVisual_func		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_ShowAllVisual")
HideAllVisual_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_HideAllVisual")


; ////////////////
;     CALLBACK 
; ////////////////
SetCallbackPointer_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_SetCallbackPointer")
UnSetCallbackPointer_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_UnSetCallbackPointer")
SetListenCallback_func 		:= DllCall("GetProcAddress", UInt, hModule, Str, "API_SetListenCallback")
UnSetListenCallback_func 	:= DllCall("GetProcAddress", UInt, hModule, Str, "API_UnSetListenCallback")
UnSetListenCallbackAll_func := DllCall("GetProcAddress", UInt, hModule, Str, "API_UnSetListenCallbackAll")

; ////////////////
;     PlayerData.h
; ////////////////
UpdateServerData_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_UpdateServerData")
GetPlayerNameById_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerNameById")
GetPlayerIdByName_func			:= DllCall("GetProcAddress", UInt, hModule, Str, "API_GetPlayerIdByName")

Init()
{
	global Init_func
	res := DllCall(Init_func)
	return res
}

SetParam(str_Name, str_Value)
{
	global SetParam_func
	res := DllCall(SetParam_func, Str, str_Name, Str, str_Value)
	return res
}

ReadMemory(addr, size, ByRef data)
{
	global ReadMemory_func
	VarSetCapacity(data,size)
	res := DllCall(ReadMemory_func, UInt, addr, UInt, size, StrP, data)
	return res
}

WriteMemory(addr, size, data)
{
	global WriteMemory_func
	res := DllCall(WriteMemory_func, UInt, addr, UInt, size, Str, data)
	return res
}

GetBasePointer(dll)
{
	global GetBasePointer_func
	res :=DllCall(GetBasePointer_func, Str, dll)
	return res
}

GetCommandLine(ByRef line)
{
	global GetCommandLine_func
	VarSetCapacity(line,512,0)
	res := DllCall(GetCommandLine_func, StrP, line)
	return res
}

GetLastError()
{
	global GetLastError_func
	res:=DllCall(GetLastError_func)
	return res
}

SetLastError(error)
{
	global SetLastError_func
	res := DllCall(SetLastError_func, Int, error)
	return res
}

SendChat(msg)
{
	global SendChat_func 
	res := DllCall(SendChat_func, Str, msg)
	return res
}

ShowGameText(str_Text, int_Time, int_Style)
{
	global ShowGameText_func
	res := DllCall(ShowGameText_func,Str , str_Text, Int, int_Time, Int, int_Style)
	return res
}

AddChatMessage(int_Color, str_Text)
{
	global AddChatMessage_func
	res := DllCall(AddChatMessage_func, Int, int_Color, Str, str_Text)
	return res
}

ShowDialog(style, caption, text, button)
{
	global ShowDialog_func
	res := DllCall(ShowDialog_func, Int, style, Str, caption, Str, text, Str, button)
	return res
}

IsDialogOpen()
{
	global IsDialogOpen_func
	res := DllCall(IsDialogOpen_func)
	return res
}

GetLastDialogId()
{
	global GetLastDialogId_func
	res := DllCall(GetLastDialogId_func)
	return res
}

GetLastDialogType()
{
	global GetLastDialogType_func
	res := DllCall(GetLastDialogType_func)
	return res
}

BlockChatInput(block)
{
	global BlockChatInput_func
	res := DllCall(BlockChatInput_func,UChar,block)
	return res
}

GetChatLine(id, ByRef line)
{
	global GetChatLine_func
	VarSetCapacity(line,256,0)
	res := DllCall(GetChatLine_func,Int,id,StrP,line)
	return res
}

GetChatLineFromFile(id, ByRef line)
{
	global GetChatLineFromFile_func
	VarSetCapacity(line,256,0)
	res := DllCall(GetChatLineFromFile_func,Int,id,StrP,line)
	return res
}

IsChatOpen()
{
	global IsChatOpen_func
	res := DllCall(IsChatOpen_func)
	return res
}

GetScreenSizeX()
{
	global GetScreenSizeX_func
	res := DllCall(GetScreenSizeX_func)
	return res
}

GetScreenSizeY()
{
	global GetScreenSizeY_func
	res := DllCall(GetScreenSizeY_func)
	return res
}

GetFramerate()
{
	global GetFramerate_func
	res := DllCall(GetFramerate_func)
	return res
}

GetCurrentWeatherId()
{
	global GetCurrentWeatherId_func
	res := DllCall(GetCurrentWeatherId_func)
	return res
}

GetZoneName( ByRef str_ZoneName)
{
	global GetZoneName_func
	VarSetCapacity(str_ZoneName, 32)
	res := DllCall(GetZoneName_func, StrP, str_ZoneName)
	return res 
}

GetCityName( ByRef str_CityName)
{
	global GetCityName_func
	VarSetCapacity(str_CityName, 32)
	res := DllCall(GetCityName_func, StrP, str_CityName)
	return res 
}

GetZoneNameByCoords(x, y, ByRef str_ZoneName)
{
	global GetZoneNameByCoords_func
	VarSetCapacity(str_ZoneName, 32)
	res := DllCall(GetZoneNameByCoords_func, Float, x, Float, y, StrP, str_ZoneName)
	return res 
}

GetCityNameByCoords(x, y, ByRef str_CityName)
{
	global GetCityNameByCoords_func
	VarSetCapacity(str_CityName, 32)
	res := DllCall(GetCityNameByCoords_func, Float, x, Float, y, StrP, str_CityName)
	return res 
}

GetMarkerPos(ByRef x, ByRef y, ByRef z)
{
	global GetMarkerPos_func
	res := DllCall(GetMarkerPos_func, FloatP, x, FloatP, y, FloatP, z)
	return res
}

GetLastMousePosOnMenuMap(ByRef x, ByRef y)
{
	global GetLastMousePosOnMenuMap_func
	res := DllCall(GetLastMousePosOnMenuMap_func, FloatP, x, FloatP, y)
	return res
}

GetMapMarkerPos(ByRef x, ByRef y)
{
	global GetMapMarkerPos_func
	res := DllCall(GetMapMarkerPos_func, FloatP, x, FloatP, y)
	return res
}

FindGroundZForPosition(x,y)
{
	global FindGroundZForPosition_func
	res := DllCall(FindGroundZForPosition_func, Float, x, Float, y, "Cdecl float")
	return res
}

WorldToScreen(worldX, worldY, worldZ, ByRef screenX, ByRef screenY)
{
	global WorldToScreen_func
	res := DllCall(WorldToScreen_func, Float, worldX, Float, worldY, Float, worldZ, FloatP, screenX, FloatP, screenY)
	return res
}

ScreenToWorld(screenX, screenY, ByRef worldX, ByRef worldY, ByRef worldZ)
{
	global ScreenToWorld_func
	res := DllCall(ScreenToWorld_func, Float, screenX, Float, screenY, FloatP, worldX, FloatP, worldY, FloatP, worldZ)
	return res
}

RegisterTextBind(str_TextBind, float_PosX, float_PosY, float_PosZ, float_Radius, int_Delay, int_Loop, int_GroupId, int_isChild, int_Timeout)
{
	global RegisterTextBind_func
	res := DllCall(RegisterTextBind_func, Str, str_TextBind, Float, float_PosX, Float, float_PosY, Float, float_PosZ, Float, float_Radius, Int, int_Delay, Int, int_Loop, Int, int_GroupId, Int, int_isChild, Int, int_Timeout)
	return res 
}

UnregisterTextBind(int_TextBindId)
{
	global UnregisterTextBind_func
	res := DllCall(UnregisterTextBind_func, Int, int_TextBindId)
	return res 
}

UnregisterAllTextBinds()
{
	global UnregisterAllTextBinds_func
	res := DllCall(UnregisterAllTextBinds_func)
	return res 
}

TextBindTimer(int_TextBindSleep)
{
	global TextBindTimer_func
	res := DllCall(TextBindTimer_func, Int, int_TextBindSleep)
	return res 
}

IsMenuOpen()
{
	global IsMenuOpen_func
	res := DllCall(IsMenuOpen_func)
	return res
}

GetPlayerId()
{
	global GetPlayerId_func
	res := DllCall(GetPlayerId_func)
	return res
}
	
GetPlayerName(ByRef szName)
{
	global GetPlayerName_func
	VarSetCapacity(szName,25)
	res := DllCall(GetPlayerName_func, StrP, szName)
	return res
}

GetServerIp(ByRef szHost)
{
	global GetServerIp_func
	VarSetCapacity(szHost, 30)
	res := DllCall(GetServerIp_func, StrP, szHost)
	return res
}

GetServerPort()
{
	global GetServerPort_func
	res := DllCall(GetServerPort_func)
	return res
}

; /////////////////////// CPED ////////////////////////////
; /////////////////////// CPED ////////////////////////////
; /////////////////////// CPED ////////////////////////////

GetPlayerCPed()
{
	global GetPlayerCPed_func 
	res :=DllCall(GetPlayerCPed_func)
	return res
}

GetPlayerHealth()
{
	global GetPlayerHealth_func
	res := DllCall(GetPlayerHealth_func)
	return res
}

GetPlayerArmor()
{
	global GetPlayerArmor_func
	res := DllCall(GetPlayerArmor_func)
	return res
}

GetPlayerMoney()
{
	global GetPlayerMoney_func
	res := DllCall(GetPlayerMoney_func)
	return res 
}

GetPlayerWanteds()
{
	global GetPlayerWanteds_func
	res := DllCall(GetPlayerWanteds_func)
	return res 
}

GetPlayerPosition(ByRef flo_posX, ByRef flo_posY, ByRef flo_posZ, ByRef flo_Rotation)
{
	global GetPlayerPosition_func
	res := DllCall(GetPlayerPosition_func, FloatP, flo_posX, FloatP, flo_posY, FloatP, flo_posZ,  FloatP, flo_Rotation)
	return res
}

IsPlayerInRangeOfPoint(flo_posX, flo_posY, flo_posZ, flo_posRadius)
{
	global IsPlayerInRangeOfPoint_func
	res := DllCall(IsPlayerInRangeOfPoint_func, Float, flo_posX, Float, flo_posY, Float, flo_posZ, Float, flo_posRadius)
	return res 
}

IsPlayerInRangeOfPoint2D(flo_posX, flo_posY, flo_posRadius)
{
	global IsPlayerInRangeOfPoint2D_func
	res := DllCall(IsPlayerInRangeOfPoint2D_func, Float, flo_posX, Float, flo_posY, Float, flo_posRadius)
	return res 
}

IsPlayerInAnyInterior()
{
	global IsPlayerInAnyInterior_func
	res := DllCall(IsPlayerInAnyInterior_func)
	return res 
}

IsPlayerFrozen()
{
	global IsPlayerFrozen_func
	res := DllCall(IsPlayerFrozen_func)
	return res 
}

GetPlayerWeaponSlot()
{
	global GetPlayerWeaponSlot_func
	res := DllCall(GetPlayerWeaponSlot_func)
	return res 
}

GetPlayerWeaponId(int_WeaponSlot)
{
	global GetPlayerWeaponId_func
	res := DllCall(GetPlayerWeaponId_func, Int, int_WeaponSlot)
	return res 
}

GetPlayerWeaponName(int_WeaponSlot, ByRef str_WeapName)
{
	global GetPlayerWeaponName_func
	VarSetCapacity(str_WeapName, 32)
	res := DllCall(GetPlayerWeaponName_func, Int, int_WeaponSlot, StrP, str_WeapName)
	return res 
}

GetPlayerWeaponClip(int_WeaponSlot)
{
	global GetPlayerWeaponClip_func
	res := DllCall(GetPlayerWeaponClip_func, Int, int_WeaponSlot)
	return res 
}

GetPlayerWeaponTotalClip(int_WeaponSlot)
{
	global GetPlayerWeaponTotalClip_func
	res := DllCall(GetPlayerWeaponTotalClip_func, Int, int_WeaponSlot)
	return res 
}

GetPlayerWeaponState()
{
	global GetPlayerWeaponState_func
	res := DllCall(GetPlayerWeaponState_func)
	return res 
}

GetPlayerState()
{
	global GetPlayerState_func
	res := DllCall(GetPlayerState_func)
	return res 
}

; /////////////////////// VEHICLE ////////////////////////////
; /////////////////////// VEHICLE ////////////////////////////
; /////////////////////// VEHICLE ////////////////////////////

GetVehiclePointer()
{
	global GetVehiclePointer_func
	res := DllCall(GetVehiclePointer_func)
	return res 
}

GetVehicleModelId()
{
	global GetVehicleModelId_func
	res := DllCall(GetVehicleModelId_func)
	return res 
}

GetVehicleModelName(ByRef str_VehicleName)
{
	global GetVehicleModelName_func
	VarSetCapacity(str_VehicleName, 32)
	res := DllCall(GetVehicleModelName_func, StrP, str_VehicleName)
	return res 
}

GetVehicleModelNameById(int_VehicleId, ByRef str_VehicleName)
{
	global GetVehicleModelNameById_func
	VarSetCapacity(str_VehicleName, 32)
	res := DllCall(GetVehicleModelNameById_func, Int, int_VehicleId, StrP, str_VehicleName)
	return res 
}

GetVehicleType()
{
	global GetVehicleType_func
	res := DllCall(GetVehicleType_func)
	return res 
}

GetVehicleHealth()
{
	global GetVehicleHealth_func
	res := DllCall(GetVehicleHealth_func)
	return res 
}

GetVehicleRadioStation()
{
	global GetVehicleRadioStation_func
	res := DllCall(GetVehicleRadioStation_func)
	return res 
}

GetVehicleRadioStationName(ByRef str_RadioName)
{
	global GetVehicleRadioStationName_func
	VarSetCapacity(str_RadioName, 32)
	res := DllCall(GetVehicleRadioStationName_func, StrP, str_RadioName)
	return res 
}

GetVehicleFreeSeats(ByRef int_SeatFL, ByRef int_SeatFR, ByRef int_SeatBL, ByRef int_SeatBR)
{
	global GetVehicleFreeSeats_func
	res := DllCall(GetVehicleFreeSeats_func, IntP, int_SeatFL, IntP, int_SeatFR, IntP, int_SeatBL, IntP, int_SeatBR)
	return res 
}

GetVehicleSpeed(float_SpeedMult)
{
	global GetVehicleSpeed_func
	res := DllCall(GetVehicleSpeed_func, Float, float_SpeedMult)
	return res 
}

GetVehicleFirstColor()
{
	global GetVehicleFirstColor_func
	res := DllCall(GetVehicleFirstColor_func)
	return res 
}

GetVehicleSecondColor()
{
	global GetVehicleSecondColor_func
	res := DllCall(GetVehicleSecondColor_func)
	return res 
}

GetVehicleColor(ByRef int_ColorFirst, ByRef int_ColorSecond)
{
	global GetVehicleColor_func
	res := DllCall(GetVehicleColor_func, IntP, int_ColorFirst, IntP, int_ColorSecond)
	return res 
}

GetVehicleColorRGB(int_Color, ByRef uint_ColorRGB)
{
	global GetVehicleColorRGB_func
	res := DllCall(GetVehicleColorRGB_func, Int, int_Color, UIntP, uint_ColorRGB)
	return res 
}

GetVehicleColorARGB(int_Color, ByRef uint_ColorARGB)
{
	global GetVehicleColorARGB_func
	res := DllCall(GetVehicleColorARGB_func, Int, int_Color, UIntP, uint_ColorARGB)
	return res 
}



IsPlayerInAnyVehicle()
{
	global IsPlayerInAnyVehicle_func
	res := DllCall(IsPlayerInAnyVehicle_func)
	return res 
}

IsPlayerDriver()
{
	global IsPlayerDriver_func
	res := DllCall(IsPlayerDriver_func)
	return res 
}

IsPlayerPassenger()
{
	global IsPlayerPassenger_func
	res := DllCall(IsPlayerPassenger_func)
	return res 
}

IsVehicleSeatUsed(int_SeatId)
{
	global IsVehicleSeatUsed_func
	res := DllCall(IsVehicleSeatUsed_func, int, int_SeatId)
	return res 
}

IsVehicleLocked()
{
	global IsVehicleLocked_func
	res := DllCall(IsVehicleLocked_func)
	return res 
}

IsVehicleSirenEnabled()
{
	global IsVehicleSirenEnabled_func
	res := DllCall(IsVehicleSirenEnabled_func)
	return res 
}

IsVehicleHornEnabled()
{
	global IsVehicleHornEnabled_func
	res := DllCall(IsVehicleHornEnabled_func)
	return res 
}

IsVehicleAlternateSirenEnabled()
{
	global IsVehicleAlternateSirenEnabled_func
	res := DllCall(IsVehicleAlternateSirenEnabled_func)
	return res 
}

IsVehicleEngineEnabled()
{
	global IsVehicleEngineEnabled_func
	res := DllCall(IsVehicleEngineEnabled_func)
	return res 
}

IsVehicleLightEnabled()
{
	global IsVehicleLightEnabled_func
	res := DllCall(IsVehicleLightEnabled_func)
	return res 
}

IsPlayerInCar()
{
	global IsPlayerInCar_func
	res := DllCall(IsPlayerInCar_func)
	return res 
}

IsPlayerInPlane()
{
	global IsPlayerInPlane_func
	res := DllCall(IsPlayerInPlane_func)
	return res 
}

IsPlayerInBoat()
{
	global IsPlayerInBoat_func
	res := DllCall(IsPlayerInBoat_func)
	return res 
}

IsPlayerInTrain()
{
	global IsPlayerInTrain_func
	res := DllCall(IsPlayerInTrain_func)
	return res 
}

IsPlayerInBike()
{
	global IsPlayerInBike_func
	res := DllCall(IsPlayerInBike_func)
	return res 
}

;////////////////// DRAW ///////////////////
;////////////////// DRAW ///////////////////
;////////////////// DRAW ///////////////////

TextCreate(Font, fontsize, bold, italic, x, y, color, text, shadow, show)
{
	global TextCreate_func
	res := DllCall(TextCreate_func,Str,Font,Int,fontsize,UChar,bold,UChar,italic,Int,x,Int,y,UInt,color,Str,text,UChar,shadow,UChar,show)
	return res
}

TextDestroy(id)
{
	global TextDestroy_func
	res := DllCall(TextDestroy_func,Int,id)
	return res
}

TextSetShadow(id, shadow)
{
	global TextSetShadow_func
	res := DllCall(TextSetShadow_func,Int,id,UChar,shadow)
	return res
}

TextSetShown(id, show)
{
	global TextSetShown_func
	res := DllCall(TextSetShown_func,Int,id,UChar,show)
	return res
}

TextSetColor(id,color)
{
	global TextSetColor_func
	res := DllCall(TextSetColor_func,Int,id,UInt,color)
	return res
}

TextSetPos(id,x,y)
{
	global TextSetPos_func
	res := DllCall(TextSetPos_func,Int,id,Int,x,Int,y)
	return res
}

TextSetString(id,Text)
{
	global TextSetString_func
	res := DllCall(TextSetString_func,Int,id,Str,Text)
	return res
}

TextUpdate(id,Font,Fontsize,bold,italic)
{
	global TextUpdate_func
	res := DllCall(TextUpdate_func,Int,id,Str,Font,int,Fontsize,UChar,bold,UChar,italic)
	return res
}

BoxCreate(x,y,width,height,Color,show)
{
	global BoxCreate_func
	res := DllCall(BoxCreate_func,Int,x,Int,y,Int,width,Int,height,UInt,Color,UChar,show)
	return res
}

BoxDestroy(id)
{
	global BoxDestroy_func
	res := DllCall(BoxDestroy_func,Int,id)
	return res
}

BoxSetShown(id,Show)
{
	global BoxSetShown_func 
	res := DllCall(BoxSetShown_func,Int,id,UChar,Show)
	return res
}
	
BoxSetBorder(id,height,Show)
{
	global BoxSetBorder_func
	res := DllCall(BoxSetBorder_func,Int,id,Int,height,Int,Show)
	return res
}


BoxSetBorderColor(id,Color)
{
	global BoxSetBorderColor_func 
	res := DllCall(BoxSetBorderColor_func,Int,id,UInt,Color)
	return res
}

BoxSetColor(id,Color)
{
	global BoxSetColor_func
	res := DllCall(BoxSetColor_func,Int,id,UInt,Color)
	return res
}

BoxSetHeight(id,height)
{
	global BoxSetHeight_func
	res := DllCall(BoxSetHeight_func,Int,id,Int,height)
	return res
}

BoxSetPos(id,x,y)
{
	global BoxSetPos_func	
	res := DllCall(BoxSetPos_func,Int,id,Int,x,Int,y)
	return res
}

BoxSetWidth(id,width)
{
	global BoxSetWidth_func
	res := DllCall(BoxSetWidth_func,Int,id,Int,width)
	return res
}

LineCreate(x1,y1,x2,y2,width,color,show)
{
	global LineCreate_func
	res := DllCall(LineCreate_func,Int,x1,Int,y1,Int,x2,Int,y2,Int,Width,UInt,color,UChar,show)
	return res
}

LineDestroy(id)
{
	global LineDestroy_func
	res := DllCall(LineDestroy_func,Int,id)
	return res
}

LineSetShown(id,show)
{
	global LineSetShown_func
	res := DllCall(LineSetShown_func,Int,id,UChar,show)
	return res
}

LineSetColor(id,color)
{
	global LineSetColor_func
	res := DllCall(LineSetColor_func,Int,id,UInt,color)
	return res
}

LineSetWidth(id, width)
{
	global LineSetWidth_func
	res := DllCall(LineSetWidth_func,Int,id,Int,width)
	return res
}

LineSetPos(id,x1,y1,x2,y2)
{
	global LineSetPos_func
	res := DllCall(LineSetPos_func,Int,id,Int,x1,Int,y1,Int,x2,Int,y2)
	return res
}

ImageCreate(path, x, y, rotation, align, show)
{
	global ImageCreate_func
	res := DllCall(ImageCreate_func, Str, path, Int, x, Int, y, Int, rotation, Int, align, UChar, show)
	return res
}

ImageDestroy(id)
{
	global ImageDestroy_func
	res := DllCall(ImageDestroy_func,Int,id)
	return res
}

ImageSetShown(id,show)
{
	global ImageSetShown_func
	res := DllCall(ImageSetShown_func,Int,id,UChar,show)
	return res
}

ImageSetAlign(id,align)
{
	global ImageSetAlign_func
	res := DllCall(ImageSetAlign_func,Int,id,Int,align)
	return res
}

ImageSetPos(id, x, y)
{
	global ImageSetPos_func
	res := DllCall(ImageSetPos_func,Int,id,Int,x, Int, y)
	return res
}

ImageSetRotation(id, rotation)
{
	global ImageSetRotation_func
	res := DllCall(ImageSetRotation_func,Int,id,Int, rotation)
	return res
}

DestroyAllVisual()
{
	global DestroyAllVisual_func
	res := DllCall(DestroyAllVisual_func)
	return res 
}

ShowAllVisual()
{
	global ShowAllVisual_func
	res := DllCall(ShowAllVisual_func)
	return res
}

HideAllVisual()
{
	global HideAllVisual_func
	res := DllCall(HideAllVisual_func )
	return res
}



;////////////////// CALLBACK ///////////////////
;////////////////// CALLBACK ///////////////////
;////////////////// CALLBACK ///////////////////

SetListenCallback(int_Id)
{
	global SetListenCallback_func
	res := DllCall(SetListenCallback_func, Int, int_Id)
	return res
}

UnSetCallbackPointer()
{
	global UnSetCallbackPointer_func
	res := DllCall(UnSetCallbackPointer_func)
	return res
}

SetCallbackPointer(int_Id)
{
	global SetCallbackPointer_func
	res := DllCall(SetCallbackPointer_func, Int, int_Id)
	return res
}

UnSetListenCallback(int_Id)
{
	global UnSetListenCallback_func
	res := DllCall(UnSetListenCallback_func, Int, int_Id)
	return res
}
UnSetListenCallbackAll()
{
	global UnSetListenCallbackAll_func
	res := DllCall(UnSetListenCallbackAll_func)
	return res
}

GetCallbackHealParams(ptr_HealStruct, ByRef iOldHeal, ByRef iNewHeal)
{
		ioldHeal := NumGet(ptr_HealStruct+0, "int")
		inewHeal := NumGet(ptr_HealStruct+4, "int")
}

GetCallbackArmorParams(ptr_ArmorStruct, ByRef iOldArmor, ByRef iNewArmor)
{
		ioldArmor := NumGet(ptr_ArmorStruct+0, "int")
		inewArmor := NumGet(ptr_ArmorStruct+4, "int")
}

GetCallbackPositionParams(ptr_PositionStruct, ByRef fOldPosX, ByRef fOldPosY, ByRef fOldPosZ, ByRef fOldPosR, ByRef fNewPosX, ByRef fNewPosY, ByRef fNewPosZ, ByRef fNewPosR)
{
		fOldPosX := NumGet(ptr_PositionStruct+0, "float")
		fOldPosY := NumGet(ptr_PositionStruct+4, "float")
		fOldPosZ := NumGet(ptr_PositionStruct+8, "float")
		fOldPosR := NumGet(ptr_PositionStruct+12, "float")
		fNewPosX := NumGet(ptr_PositionStruct+16, "float")
		fNewPosY := NumGet(ptr_PositionStruct+20, "float")
		fNewPosZ := NumGet(ptr_PositionStruct+24, "float")
		fNewPosR := NumGet(ptr_PositionStruct+28, "float")
}

GetCallbackEnterExitParams(ptr_EnterExitStruct, ByRef iOldInteriorState, ByRef iNewInteriorState)
{
		iOldInteriorState := NumGet(ptr_EnterExitStruct+0, "int")
		iNewInteriorState := NumGet(ptr_EnterExitStruct+4, "int")
}

GetCallbackVehicleEnterExitParams(ptr_VehicleEnterExitStruct, ByRef iOldVehicleEnterExit, ByRef iNewVehicleEnterExit)
{
		iOldVehicleEnterExit := NumGet(ptr_VehicleEnterExitStruct+0, "int")
		iNewVehicleEnterExit := NumGet(ptr_VehicleEnterExitStruct+4, "int")
}

GetCallbackVehicleHealthParams(ptr_VehicleHealthStruct, ByRef iOldVehicleHealth, ByRef iNewVehicleHealth)
{
		iOldVehicleHealth := NumGet(ptr_VehicleHealthStruct+0, "int")
		iNewVehicleHealth := NumGet(ptr_VehicleHealthStruct+4, "int")
}

GetCallbackVehicleEngineParams(ptr_VehicleEngineStruct, ByRef iOldVehicleEngine, ByRef iNewVehicleEngine)
{
		iOldVehicleEngine := NumGet(ptr_VehicleEngineStruct+0, "int")
		iNewVehicleEngine := NumGet(ptr_VehicleEngineStruct+4, "int")
}

GetCallbackVehicleLockParams(ptr_VehicleLockStruct, ByRef iOldVehicleLock, ByRef iNewVehicleLock)
{
		iOldVehicleLock := NumGet(ptr_VehicleLockStruct+0, "int")
		iNewVehicleLock := NumGet(ptr_VehicleLockStruct+4, "int")
}

GetCallbackVehicleSpeedParams(ptr_VehicleSpeedStruct, ByRef iOldVehicleSpeed, ByRef iNewVehicleSpeed)
{
		iOldVehicleSpeed := NumGet(ptr_VehicleSpeedStruct+0, "int")
		iNewVehicleSpeed := NumGet(ptr_VehicleSpeedStruct+4, "int")
}

GetCallbackWeaponSwitchParams(ptr_WeaponSwitchStruct, ByRef iOldWeaponId, ByRef iNewWeaponId)
{
		iOldWeaponId := NumGet(ptr_WeaponSwitchStruct+0, "int")
		iNewWeaponId := NumGet(ptr_WeaponSwitchStruct+4, "int")
}

GetCallbackWeaponClipParams(ptr_WeaponClipStruct, ByRef iOldWeaponClip, ByRef iNewWeaponClip)
{
		iOldWeaponClip := NumGet(ptr_WeaponClipStruct+0, "int")
		iNewWeaponClip := NumGet(ptr_WeaponClipStruct+4, "int")
}

GetCallbackWeaponTotalClipParams(ptr_WeaponTotalClipStruct, ByRef iOldWeaponTotalClip, ByRef iNewWeaponTotalClip)
{
		iOldWeaponTotalClip := NumGet(ptr_WeaponTotalClipStruct+0, "int")
		iNewWeaponTotalClip := NumGet(ptr_WeaponTotalClipStruct+4, "int")
}

GetCallbackChatlogParams(ptr_ChatlogStruct, ByRef string)
{
		VarSetCapacity(string, 256, 0)
		string := StrGet(ptr_ChatlogStruct)
}

UpdateServerData()
{
	global UpdateServerData_func
	res := DllCall(UpdateServerData_func)
	return res
}

GetPlayerNameById(id,ByRef name)
{
	VarSetCapacity(name,24,0)
	global GetPlayerNameById_func
	res := DllCall(GetPlayerNameById_func,UShort,id,StrP,name)
	return res
}

GetPlayerIdByName(name)
{
	global GetPlayerIdByName_func
	res := DllCall(GetPlayerIdByName_func,Str,name)
	return res
}




DecimalToHex(Var){
	; Convert a decimal integer to hexadecimal:
	SetFormat, IntegerFast, hex
	Dec2Hex += Var ; Sets Dec2Hex (which previously contained 11) to be 0xb.
	Dec2Hex .= "" ; Necessary due to the "fast" mode.
	SetFormat, IntegerFast, d
	StringTrimLeft, Dec2Hex, Dec2Hex, 2 ; removes 0x from the string
	StringUpper, Dec2Hex, Dec2Hex ; makes it all caps
	sDec2Hex .= Dec2Hex
	return sDec2Hex
}

RelToAbs(root, dir, s = "\") {
	pr := SubStr(root, 1, len := InStr(root, s, "", InStr(root, s . s) + 2) - 1)
		, root := SubStr(root, len + 1), sk := 0
	If InStr(root, s, "", 0) = StrLen(root)
		StringTrimRight, root, root, 1
	If InStr(dir, s, "", 0) = StrLen(dir)
		StringTrimRight, dir, dir, 1
	Loop, Parse, dir, %s%
	{
		If A_LoopField = ..
			StringLeft, root, root, InStr(root, s, "", 0) - 1
		Else If A_LoopField =
			root =
		Else If A_LoopField != .
			Continue
		StringReplace, dir, dir, %A_LoopField%%s%
	}
	Return, pr . root . s . dir
}

