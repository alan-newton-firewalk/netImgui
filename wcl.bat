@echo off
REM Think of this script as a wrapper around calling 'cl' yourself with all the params set.
REM You still need to pass the thing you want to compile as an argument.

set BIN_DIR=bin\
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"

if not defined VisualStudioVersion (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"
    ) else (
	echo "Visual Studio compiler not found"
	goto :eof
    )
)

REM https://ss64.com/nt/syntax-args.html
set srcc_dir=%~dp0
set clext_dir=%~dp1
set filepath=%1
set basename=%~n1

if "%~dp1" == "" (
  where cl.exe
  echo "Usage: wcl.bat <source_file>"
  exit /B 1
)

REM echo resets ERRORLEVEL
call echo build %filepath%

REM build extension
REM SEE ARG.BAT for a working example
if exist %clext_dir%wclext.bat (
  call %clext_dir%wclext.bat GROUP_INCLUDE GROUP_LINK
  if %ERRORLEVEL% NEQ 0 goto :eof
)
if exist %clext_dir%wclext_%basename%.bat (
  call %clext_dir%wclext_%basename%.bat TARGET_INCLUDE TARGET_LINK
  if %ERRORLEVEL% NEQ 0 goto :eof
)

SETLOCAL
set CFLAGS=%DEV_FLAGS% %GROUP_INCLUDE% %TARGET_INCLUDE% /link %GROUP_LINK% %TARGET_LINK%

REM Argument ordering: <cl flags> /link <linker flags>
REM   Cl (include path): /I <absolute path>
REM   Link (search directory for libraries): /LIBPATH:<path>
REM   Link (library): <path.lib>
@echo on
cl %filepath% /Os /nologo /fp:strict /Fo:%BIN_DIR% /Fe:%BIN_DIR% /I %srcc_dir%common %CFLAGS%
@echo off
ENDLOCAL
echo build result %ERRORLEVEL%

exit /B 0
