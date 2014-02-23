//-----------------------------------------------------------------------------
// Copyright (c)  agrippa1994. All rights reserved.
//-----------------------------------------------------------------------------

#pragma once

#define CALLBACK_HEAL						0
#define CALLBACK_ARMOR						1
#define CALLBACK_POSITION					2
#define CALLBACK_ENTEREXIT					3
#define CALLBACK_VEHICLE_ENTEREXIT			4
#define CALLBACK_VEHICLE_HEALTH				5
#define	CALLBACK_VEHICLE_ENGINE				6
#define CALLBACK_VEHICLE_LOCK				7
#define CALLBACK_VEHICLE_SPEED				8
#define CALLBACK_WEAPON_CLIP				9
#define CALLBACK_WEAPON_TOTALCLIP			10
#define CALLBACK_WEAPON_SWITCH				11
#define CALLBACK_CHATLOG					12

typedef void (__stdcall *PTCALLBACKFUNC)(int dwCallbackId, unsigned int dwCostumStructPtr);

// SAMP
extern "C" __declspec(dllimport) int API_SendChat(char *szMsg);
extern "C" __declspec(dllimport) int API_ShowGameText(char *szText, int iTime, int iStyle);
extern "C" __declspec(dllimport) int API_AddChatMessage(unsigned int dwColor,char *szText);
extern "C" __declspec(dllimport) int API_ShowDialog(int style,char *caption,char *text,char *button);

extern "C" __declspec(dllimport) int API_IsDialogOpen();
extern "C" __declspec(dllimport) int API_GetLastDialogId();
extern "C" __declspec(dllimport) int API_GetLastDialogType();

extern "C" __declspec(dllimport) int API_BlockChatInput(bool bBlock);
extern "C" __declspec(dllimport) int API_GetChatLine(int id,char *&line);
extern "C" __declspec(dllimport) int API_GetChatLineFromFile(int id,char *&line);
extern "C" __declspec(dllimport) int API_IsChatOpen();

extern "C" __declspec(dllimport) int API_GetServerIp(char *&szHost);
extern "C" __declspec(dllimport) int API_GetServerPort();

// PlayerData
extern "C" __declspec(dllimport) int API_UpdateServerData();

extern "C" __declspec(dllimport) int API_GetPlayerNameById(unsigned short player, char *&name);
extern "C" __declspec(dllimport) int API_GetPlayerIdByName(char *name);

extern "C" __declspec(dllimport) int API_GetPlayerId();
extern "C" __declspec(dllimport) int API_GetPlayerName(char *&szName);

// Rendering
extern "C" __declspec(dllimport) int API_TextCreate(char *Font,int FontSize,bool bBold,bool bItalic,int x,int y, unsigned int color,char *text,bool bShadow, bool bShow);
extern "C" __declspec(dllimport) int API_TextDestroy(int ID);
extern "C" __declspec(dllimport) int API_TextSetShadow(int id, bool b);
extern "C" __declspec(dllimport) int API_TextSetShown(int id,bool b);
extern "C" __declspec(dllimport) int API_TextSetColor(int id,unsigned int color);
extern "C" __declspec(dllimport) int API_TextSetPos(int id,int x,int y);
extern "C" __declspec(dllimport) int API_TextSetString(int id,char *str);
extern "C" __declspec(dllimport) int API_TextUpdate(int id,char *Font,int FontSize,bool bBold,bool bItalic);

extern "C" __declspec(dllimport) int API_BoxCreate(int x,int y,int w,int h,unsigned int dwColor,bool bShow);
extern "C" __declspec(dllimport) int API_BoxDestroy(int id);
extern "C" __declspec(dllimport) int API_BoxSetShown(int id,bool bShown);
extern "C" __declspec(dllimport) int API_BoxSetBorder(int id,int height,bool bShown);
extern "C" __declspec(dllimport) int API_BoxSetBorderColor(int id,unsigned int dwColor);
extern "C" __declspec(dllimport) int API_BoxSetColor(int id, unsigned int dwColor);
extern "C" __declspec(dllimport) int API_BoxSetHeight(int id,int height);
extern "C" __declspec(dllimport) int API_BoxSetPos(int id,int x,int y);
extern "C" __declspec(dllimport) int API_BoxSetWidth(int id, int width);

extern "C" __declspec(dllimport) int API_LineCreate(int x1,int y1,int x2, int y2, int width,unsigned int color,bool bShow);
extern "C" __declspec(dllimport) int API_LineDestroy(int id);
extern "C" __declspec(dllimport) int API_LineSetShown(int id,bool bShown);
extern "C" __declspec(dllimport) int API_LineSetColor(int id, unsigned int color);
extern "C" __declspec(dllimport) int API_LineSetWidth(int id, int width);
extern "C" __declspec(dllimport) int API_LineSetPos(int id, int x1, int y1, int x2, int y2);

extern "C" __declspec(dllimport) int API_ImageCreate(char *path, int x, int y, int rotation, int align, bool bShow);
extern "C" __declspec(dllimport) int API_ImageDestroy(int id);
extern "C" __declspec(dllimport) int API_ImageSetShown(int id, bool bShown);
extern "C" __declspec(dllimport) int API_ImageSetAlign(int id, int align);
extern "C" __declspec(dllimport) int API_ImageSetPos(int id, int x, int y);
extern "C" __declspec(dllimport) int API_ImageSetRotation(int id, int rotation);

extern "C" __declspec(dllimport) int API_DestroyAllVisual();
extern "C" __declspec(dllimport) int API_ShowAllVisual();
extern "C" __declspec(dllimport) int API_HideAllVisual();

// World
extern "C" __declspec(dllimport) int API_GetCurrentWeatherId();

extern "C" __declspec(dllimport) int API_GetZoneName(char* &szZoneName);
extern "C" __declspec(dllimport) int API_GetCityName(char* &szCityName);
extern "C" __declspec(dllimport) int API_GetZoneNameByCoords(float x, float y, char* &szZoneName);
extern "C" __declspec(dllimport) int API_GetCityNameByCoords(float x, float y, char* &szCityName);

extern "C" __declspec(dllimport) int API_GetMarkerPos(float& x,float& y,float& z);
extern "C" __declspec(dllimport) int API_GetLastMousePosOnMenuMap(float& x, float& y);
extern "C" __declspec(dllimport) int API_GetMapMarkerPos(float& x, float& y);

extern "C" __declspec(dllimport) float API_FindGroundZForPosition(float x, float y);

extern "C" __declspec(dllimport) int API_WorldToScreen(float fWorldX, float fWorldY, float fWorldZ, float &fScreenX, float &fScreenY);
extern "C" __declspec(dllimport) int API_ScreenToWorld(float fScreenX, float fScreenY, float &fWorldX, float &fWorldY, float &fWorldZ);

// Vehicle
extern "C" __declspec(dllimport) unsigned int	API_GetVehiclePointer();
extern "C" __declspec(dllimport) int 			API_GetVehicleModelId();
extern "C" __declspec(dllimport) int			API_GetVehicleModelName(char* &_szVehicleModelName);
extern "C" __declspec(dllimport) int			API_GetVehicleModelNameById(int _dwVehicleId, char* &_szVehicleModelName);
extern "C" __declspec(dllimport) int			API_GetVehicleType();
extern "C" __declspec(dllimport) int 			API_GetVehicleHealth();
extern "C" __declspec(dllimport) int 			API_GetVehicleRadioStation();
extern "C" __declspec(dllimport) int			API_GetVehicleRadioStationName(char* &_szRadioName);
extern "C" __declspec(dllimport) int			API_GetVehicleFreeSeats(int &_dwSeatFL, int &_dwSeatFR, int &_dwSeatBL, int &_dwSeatBR);
extern "C" __declspec(dllimport) int			API_GetVehicleSpeed(float _fMult);
extern "C" __declspec(dllimport) int			API_GetVehicleFirstColor();
extern "C" __declspec(dllimport) int			API_GetVehicleSecondColor();
extern "C" __declspec(dllimport) int			API_GetVehicleColor(int &_dwColorFirst, int &_dwColorSecond);
extern "C" __declspec(dllimport) int			API_GetVehicleColorARGB(int deColorId, unsigned int &_uintColor);
extern "C" __declspec(dllimport) int			API_GetVehicleColorRGB(int deColorId, unsigned int &_uintColor);

extern "C" __declspec(dllimport) int			API_IsPlayerInAnyVehicle();
extern "C" __declspec(dllimport) int			API_IsPlayerDriver();
extern "C" __declspec(dllimport) int			API_IsPlayerPassenger();
extern "C" __declspec(dllimport) int			API_IsVehicleSeatUsed(int _dwSeatId);
extern "C" __declspec(dllimport) int			API_IsVehicleLocked();
extern "C" __declspec(dllimport) int			API_IsVehicleHornEnabled();
extern "C" __declspec(dllimport) int			API_IsVehicleSirenEnabled();
extern "C" __declspec(dllimport) int			API_IsVehicleAlternateSireneEnabled();
extern "C" __declspec(dllimport) int			API_IsVehicleEngineEnabled();
extern "C" __declspec(dllimport) int			API_IsVehicleLightEnabled();
extern "C" __declspec(dllimport) int			API_IsPlayerInCar();
extern "C" __declspec(dllimport) int			API_IsPlayerInPlane();
extern "C" __declspec(dllimport) int			API_IsPlayerInBoat();
extern "C" __declspec(dllimport) int			API_IsPlayerInTrain();
extern "C" __declspec(dllimport) int			API_IsPlayerInBike();

// Ped
extern "C" __declspec(dllimport) unsigned int	API_GetPlayerCPed();
extern "C" __declspec(dllimport) int			API_GetPlayerHealth();
extern "C" __declspec(dllimport) int			API_GetPlayerArmor();
extern "C" __declspec(dllimport) int			API_GetPlayerMoney();
extern "C" __declspec(dllimport) int			API_GetPlayerWanteds();
extern "C" __declspec(dllimport) int			API_GetPlayerState();
extern "C" __declspec(dllimport) int			API_GetPlayerPosition(float &_posX, float &_posY, float &_posZ, float &_posR);
extern "C" __declspec(dllimport) int			API_IsPlayerInRangeOfPoint(float _posX, float _posY, float _posZ, float _posRadius);
extern "C" __declspec(dllimport) int			API_IsPlayerInRangeOfPoint2D(float _posX, float _posY, float _posRadius);
extern "C" __declspec(dllimport) int			API_IsPlayerInAnyInterior();
extern "C" __declspec(dllimport) int			API_IsPlayerFrozen();

extern "C" __declspec(dllimport) int			API_GetPlayerWeaponSlot();
extern "C" __declspec(dllimport) int			API_GetPlayerWeaponId(int dwWeapSlot);
extern "C" __declspec(dllimport) int			API_GetPlayerWeaponName(int dwWeapSlot, char* &_szWeapName);
extern "C" __declspec(dllimport) int			API_GetPlayerWeaponClip(int dwWeapSlot);
extern "C" __declspec(dllimport) int			API_GetPlayerWeaponTotalClip(int dwWeapSlot);
extern "C" __declspec(dllimport) int			API_GetPlayerWeaponState();

// Memory
extern "C" __declspec(dllimport) int				API_ReadMemory(unsigned int address,size_t size,char *&data);
extern "C" __declspec(dllimport) int				API_WriteMemory(unsigned int address, size_t size, char *data);

extern "C" __declspec(dllimport) unsigned long		API_GetBasePointer(char *dll);
extern "C" __declspec(dllimport) int				API_GetCommandLine(char *&line);

// GTA
extern "C" __declspec(dllimport) int API_GetScreenSizeX();
extern "C" __declspec(dllimport) int API_GetScreenSizeY();

extern "C" __declspec(dllimport) int API_GetFramerate();

extern "C" __declspec(dllimport) int API_IsMenuOpen();

// Textbind
extern "C" __declspec(dllimport) int API_TextBindTimer(int _dwTime);
extern "C" __declspec(dllimport) int API_UnregisterAllTextBinds();
extern "C" __declspec(dllimport) int API_UnregisterTextBind(int _dwTextBind);
extern "C" __declspec(dllimport) int RegisterTextBind(char* _szTextBInd, float _fPosX, float _fPosY, float _fPosZ, float _fRadius, int _dwDelay, int _dwLoop, int _dwGroupId, int _dwIsChild, int _dwTimeout);

// Callback
extern "C" __declspec(dllimport) int	API_SetCallbackPointer(PTCALLBACKFUNC);
extern "C" __declspec(dllimport) void	API_UnSetCallbackPointer();
extern "C" __declspec(dllimport) int	API_SetListenCallback(int);
extern "C" __declspec(dllimport) int	API_UnSetListenCallback(int);
extern "C" __declspec(dllimport) void	API_UnSetListenCallbackAll();


