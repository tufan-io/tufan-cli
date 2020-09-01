
@echo off
if defined TUFAN_SHELL_TRACE (
    @echo REM -------------
    @echo REM %~n0%~x0
    @echo REM -------------
)

call %~dp0\base

if exist %TARGET_DIR% (
    RMDIR /s /q %TARGET_DIR%
    if defined TUFAN_SHELL_TRACE (
      @echo RMDIR /s /q %TARGET_DIR%
    )
)

if defined TUFAN_SHELL_TRACE (
    @echo REM =============
)
