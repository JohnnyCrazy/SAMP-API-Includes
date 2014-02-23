using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Text;
using System.Diagnostics;

namespace SpotifyOverlay_SAMP
{
    public class API
    {
        [DllImport("API.dll", EntryPoint = "API_AddChatMessage", CallingConvention = CallingConvention.Cdecl)]
        public static extern int AddChatMessage(UInt32 color, String text);
        [DllImport("API.dll", EntryPoint = "API_SendChat", CallingConvention = CallingConvention.Cdecl)]
        private static extern int SendChat(StringBuilder text);
        [DllImport("API.dll", EntryPoint = "API_SetParam", CallingConvention = CallingConvention.Cdecl)]
        public static extern int SetParam(String param1, String param2);
        [DllImport("API.dll", EntryPoint = "API_IsPlayerInRangeOfPoint", CallingConvention = CallingConvention.Cdecl)]
        public static extern Boolean IsPlayerInRangeOfPoint(float x, float y, float z, float radius);
        [DllImport("API.dll", EntryPoint = "API_GetPlayerId", CallingConvention = CallingConvention.Cdecl)]
        public static extern int GetPlayerId();
        [DllImport("API.dll", EntryPoint = "API_IsChatOpen", CallingConvention = CallingConvention.Cdecl)]
        public static extern Boolean IsChatOpen();
        [DllImport("API.dll", EntryPoint = "API_GetPlayerNameById", CallingConvention = CallingConvention.Cdecl)]
        public static extern Boolean GetPlayerNameById(int id,ref String name);
        [DllImport("API.dll", EntryPoint = "API_UpdateServerData", CallingConvention = CallingConvention.Cdecl)]
        public static extern int UpdateServerData();
        #region Overlay
        [DllImport("API.dll", EntryPoint = "API_DestroyAllVisual", CallingConvention = CallingConvention.Cdecl)]
        public static extern int DestroyAllVisual();
        #endregion
        #region Box-Overlay
        [DllImport("API.dll", EntryPoint = "API_BoxCreate", CallingConvention = CallingConvention.Cdecl)]
        public static extern int BoxCreate(int x, int y, int width, int height, UInt32 color, Boolean show);
        #endregion
        #region Line-Overlay
        [DllImport("API.dll", EntryPoint = "API_LineCreate", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LineCreate(int x1, int y1, int x2, int y2, int width, UInt32 color, Boolean show);
        [DllImport("API.dll", EntryPoint = "API_LineSetShown", CallingConvention = CallingConvention.Cdecl)]
        public static extern int LineSetShown(int id, Boolean show);
        #endregion
        #region Text-Overlay
        [DllImport("API.dll", EntryPoint = "API_TextCreate", CallingConvention = CallingConvention.Cdecl)]
        public static extern int TextCreate(String font, int size, Boolean bold, Boolean italic, int x, int y, UInt32 color, String text, Boolean show, Boolean shadow);
        [DllImport("API.dll", EntryPoint = "API_TextSetString", CallingConvention = CallingConvention.Cdecl)]
        public static extern int TextSetString(int id, String text);
        [DllImport("API.dll", EntryPoint = "API_TextSetColor", CallingConvention = CallingConvention.Cdecl)]
        public static extern int TextSetColor(int id, UInt32 color);
        #endregion
        #region Image-Overlay
        [DllImport("API.dll", EntryPoint = "API_ImageDestroy", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ImageDestroy(int id);
        [DllImport("API.dll", EntryPoint = "API_ImageCreate", CallingConvention = CallingConvention.Cdecl)]
        public static extern int ImageCreate(String path,int x,int y,int rotation,Boolean align,Boolean show);
        #endregion

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern IntPtr GetForegroundWindow();

        public static int SendChat(String text)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append(text);
            return API.SendChat(builder);
        }
        public static int AddChatMessage(Color color, String text)
        {
            String lawl = API.ToHexValueRGB(color);
            return API.AddChatMessage(Convert.ToUInt32(lawl, 16), text);
        }
        public static string ToHexValueRGB(Color color)
        {
            return "" + color.R.ToString("X2") + color.G.ToString("X2") + color.B.ToString("X2");
        }
        public static string ToHexValueARGB(Color color)
        {
            return "" + color.A.ToString("X2") + color.R.ToString("X2") + color.G.ToString("X2") + color.B.ToString("X2");
        }
        public static Boolean IsGTARunning(String gtaprocname)
        {
            Process[] list = Process.GetProcessesByName(gtaprocname);
            foreach(Process p in list)
            {
                if (p.MainWindowHandle == GetForegroundWindow())
                    return true;
            }
            return false;
        }
    }
}
