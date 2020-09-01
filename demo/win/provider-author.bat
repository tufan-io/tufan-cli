REM Runs a demo of the provider-author experience

@echo off
rem FORCE can be one of '' or '--force'
set FORCE=--force
REM INIT can be one of '' or '--no-init'
set INIT=--no-init

REM Setup root directories
call %~dp0\utils\setup.bat


echo.
tufan registry ping --port %PORT% > nul 2>&1
if %errorlevel% equ 0 (
  echo ::: demo registry is live - stopping and deleting.
  tufan registry stop --port %PORT% --force > null 2>&1
)
rem Delete any previous registry cache. We need a fresh start here...
cmd /c tufan registry delete --port %PORT% --force >null 2>&1

set aws_provider=%provider_dir%\aws
if exist %aws_provider% (
  echo ::: resetting %aws_provider%
  rd /s /q %aws_provider%
)
md %aws_provider%
cd %aws_provider%

echo.
echo.
echo ###############################
echo #    Provider Author flow     #
echo ###############################


echo.
echo.
echo tufan dev create provider . @tufan-io/aws %FORCE% %INIT%
tufan dev create provider . @tufan-io/aws %FORCE% %INIT%

echo.
echo.
echo tufan dev create component s3 %FORCE% %INIT%
tufan dev create component s3 %FORCE% %INIT%

echo.
echo.
echo tufan dev create component lambda %FORCE% %INIT%
tufan dev create component lambda %FORCE% %INIT%

echo.
echo.
echo tufan dev create component ec2 %FORCE% %INIT%
tufan dev create component ec2 %FORCE% %INIT%

echo.
echo.
echo tufan dev create component az %FORCE% %INIT%
tufan dev create component az %FORCE% %INIT%

echo.
echo.
echo tufan dev create link s3 lambda %FORCE% %INIT%
tufan dev create link s3 lambda %FORCE% %INIT%

echo.
echo.
echo tufan dev create attacher az ec2 %FORCE% %INIT%
tufan dev create attacher az ec2 %FORCE% %INIT%

echo.
echo.
echo npm install --silent
cmd /c npm install --silent 2>nul

echo.
echo.
echo.
REM TODO: add any hard coded modifications to the components/facets here.
echo ::: Library author would add code mofications here
echo.
set /p DUMMY="ENTER ANY KEY TO CONTINUE"
echo.
echo.

echo.
echo.
echo npm run build --silent
cmd /c npm run build --silent

echo.
echo.
echo ::: commit provider to a git repo
echo pwd=%cd%
echo git init .
git init .
echo git add .
git add . 2>nul
echo git commit -m "initial commit of demo provider"
git commit -m "initial commit of demo provider" -q --no-verify

echo.
echo.
echo tufan registry create --port %PORT% --ephemeral
tufan registry create --port %PORT% --ephemeral

echo.
echo.
echo tufan registry start --port %PORT%
tufan registry start --port %PORT% --force

echo.
echo.
echo tufan publish --tufan-registry http://localhost:%PORT% --file
tufan publish --tufan-registry http://localhost:%PORT% --file


echo.
echo.
echo.
echo ##########################################
echo #   Provider published successfully!!!   #
echo ##########################################
echo.
echo.

cd %BASE_DIR%
