if not defined VisualStudioVersion (
  echo "Please initial command line tools with wcl.bat"
  exit /B 1
)
set FLAGS=/c /I Code\ThirdParty\DearImgui\ /I Code\ThirdParty\DearImgui\backends  /I Code/Client/ /I Code
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_App.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_App_win32dx11.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_Config.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_HAL_dx11.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_HAL_win32.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_Network.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_RemoteClient.cpp
cl %FLAGS% Code\ServerApp\Source\/NetImguiServer_UI.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/backends/imgui_impl_dx11.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/backends/imgui_impl_win32.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/imgui.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/imgui_draw.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/imgui_tables.cpp
cl %FLAGS% Code\ThirdParty\DearImgui\/imgui_widgets.cpp
cl %FLAGS% Code\Client\Private/NetImgui_Api.cpp
cl %FLAGS% Code\Client\Private/NetImgui_Client.cpp
cl %FLAGS% Code\Client\Private/NetImgui_CmdPackets_DrawFrame.cpp
cl %FLAGS% Code\Client\Private/NetImgui_NetworkPosix.cpp
cl %FLAGS% Code\Client\Private/NetImgui_NetworkUE4.cpp
cl %FLAGS% Code\Client\Private/NetImgui_NetworkWin32.cpp
cl *obj /FeServer.exe /LIBPATH:D:\depotM\Unreal\Engine\Source\ThirdParty\Windows\DirectX\Lib\x86 d3d11.lib

