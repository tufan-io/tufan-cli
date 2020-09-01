
@echo off
if defined TUFAN_SHELL_TRACE (
    @echo REM -------------
    @echo REM %~n0%~x0
    @echo REM -------------
)

call %~dp0\base

if not defined provider_dir (
    SET provider_dir=%TARGET_DIR%\provider
    if defined TUFAN_SHELL_TRACE (
        @echo SET provider_dir=%provider_dir%
    )
)

if not defined registry_dir (
    SET registry_dir=%TARGET_DIR%\registry
    if defined TUFAN_SHELL_TRACE (
        @echo SET registry_dir=%registry_dir%
    )
)

if not defined composition_dir (
    SET composition_dir=%TARGET_DIR%\composition
    if defined TUFAN_SHELL_TRACE (
        @echo SET composition_dir=%composition_dir%
    )
)

if not exist %provider_dir% (
  md %provider_dir%
  if defined TUFAN_SHELL_TRACE (
    @echo md %provider_dir%
  )
)

if not exist %registry_dir% (
  md %registry_dir%
  if defined TUFAN_SHELL_TRACE (
    @echo md %registry_dir%
  )
)

if not exist %composition_dir% (
  md %composition_dir%
  if defined TUFAN_SHELL_TRACE (
    @echo md %composition_dir%
  )
)

FOR /F "tokens=*" %%a in ('tufan --version') do SET TUFAN_VERSION=%%a
@echo REM using tufan-cli version %TUFAN_VERSION%

if defined TUFAN_SHELL_TRACE (
    @echo REM =============
)
