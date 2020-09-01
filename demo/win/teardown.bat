REM tears down a composition created by system-architect.bat

@echo off
REM FORCE = '' or '--force'
set FORCE=--FORCE

REM when not set, skips the parts that test for errors
REM set WITH_ERRORS=

REM Setup root directories
call %~dp0\utils\setup.bat

if not exist %composition_dir% (
    echo non-existant composition dir. Cannot continue
    exit /b -1
)

set cfile=%composition_dir%\composition.tufan

if not exist %cfile%  (
    echo missing '%cfile%'. Cannot continue
    exit /b -2
)

cd %composition_dir%

echo.
echo.
echo ###############################
echo #    Composition teardown     #
echo ###############################

tufan ls

echo.
echo tufan rm s3_1
tufan rm s3_1
tufan ls 

if defined WITH_ERRORS (
    echo.
    echo (EXPECTED ERROR)
    echo tufan rm az_1
    tufan rm az_1 || echo.
)

echo.
echo tufan detach
tufan detach 
tufan ls

echo.
echo tufan unlink
tufan unlink
tufan ls

echo.
echo tufan rm s3_1
tufan ls

echo.
echo tufan rm lambda_1
tufan rm lambda_1
tufan ls

echo.
echo tufan rm az_1
tufan rm az_1
tufan ls

echo.
echo tufan rm ec2_1
tufan rm ec2_1
tufan ls

echo.
echo tufan deploy --visual-trace --for-real
tufan deploy --visual-trace --for-real

cd %BASE_DIR%

echo.
echo tufan registry stop --port %PORT%
tufan registry stop --port %PORT%

echo.
echo tufan registry delete --port %PORT%
tufan registry delete --port %PORT%

cd %BASE_DOR%