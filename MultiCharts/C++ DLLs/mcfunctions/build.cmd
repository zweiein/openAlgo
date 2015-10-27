@echo Off
set config=%1
if "%config%" == "" (
    set config=Release
)

:: use MSBuild from .net framework by default
set MsBuildExe="%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild"

:: if there is MSBuild from vs2013, use MSBuild from vs2013 instead
if exist "%PROGRAMFILES%\MSBuild\12.0\Bin\MsBuild.exe" (
    set MsBuildExe="%PROGRAMFILES%\MSBuild\12.0\Bin\MsBuild.exe"
) else if exist "%PROGRAMFILES(X86)%\MSBuild\12.0\Bin\MsBuild.exe" (
    set MsBuildExe="%PROGRAMFILES(X86)%\MSBuild\12.0\Bin\MsBuild.exe"
)

%MsBuildExe% MCFunctions.sln /p:Configuration="%config%";ExcludeXmlAssemblyFiles=false;Platform="x64" /fl /flp:LogFile=msbuild.log;Verbosity=Normal /m