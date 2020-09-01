@echo off
if defined TUFAN_SHELL_TRACE (
    @echo REM -------------
    @echo REM %~n0%~x0
    @echo REM -------------
)

if not defined BASE_DIR (
    echo %~dp0
    for %%Q in ("%~dp0\..\..\..") DO set "BASE_DIR=%%~fQ"
    if defined TUFAN_SHELL_TRACE (
        @echo SET BASE_DIR=%BASE_DIR%
    )
)
echo BASE_DIR=%BASE_DIR%

if not defined TARGET_DIR (
    SET TARGET_DIR=%BASE_DIR%\.tmp
    if defined TUFAN_SHELL_TRACE (
        @echo SET TARGET_DIR=%TARGET_DIR%
    )
)

if not defined BIN_DIR (
    SET BIN_DIR=%BASE_DIR%\bin
    if defined TUFAN_SHELL_TRACE (
        @echo SET BIN_DIR=%BIN_DIR%
        set PATH=%BIN_DIR%
    )
)

set PORT=25052

set np=%BASE_DIR%\bin
echo %path%|find /i "%np:"=%">nul || set PREPEND_PATH="append"

if defined PREPEND_PATH (
   @echo pre-pending %np% to path...
   set "PATH=%np%;%PATH%"
)
rem reset PREPEND_PATH
set PREPEND_PATH=
