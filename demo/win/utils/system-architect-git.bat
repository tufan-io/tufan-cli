REM Runs a demo of the provider-author experience

@echo off
rem FORCE can be one of '' or '--force'
set FORCE=--force

REM Setup root directories
call %~dp0\setup.bat

set aws_provider=%provider_dir%\aws
rem check to ensure that aws_provider is available. Deploy will fail without.
if not exist %aws_provider% (
  echo ERROR: Missing aws provider in %aws_provider%
  echo please run %~dp0\provider-author and try again
  exit /b -1
)

if exist %composition_dir% (
  echo ::: resetting %composition_dir%
  rd /s /q %composition_dir%
)
md %composition_dir%
cd %composition_dir%

echo.
echo.
echo ###############################
echo #    System Architect Demo    #
echo ###############################

echo.
tufan registry ping --port %PORT% > nul 2>&1
if %errorlevel% neq 0 (
  echo ::: restarting demo registry
  tufan registry start --port %PORT% --force > null 2>&1
)

git init .
rem allows non-paged diff output. Restrict to current repo.
git config pager.diff false

echo.
echo tufan init --registry http://localhost:%PORT%
tufan init --registry http://localhost:%PORT%
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo use provider aws
tufan use-provider aws
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan add s3
tufan add s3
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo
tufan add lambda
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan link s3_1 lambda_1
tufan link s3_1 lambda_1
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan add az
tufan add az
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan add ec2
tufan add ec2
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan attach az_1 ec2_1
tufan attach az_1 ec2_1
git diff --no-prefix -U1000 composition.tufan
git add . > null 2>&1

echo.
echo tufan deploy --visual-trace --for-real

tufan deploy --visual-trace --for-real

echo.
echo.
echo.
echo ############################################
echo #   Composition deployed successfully!!!   #
echo ############################################
echo.
echo.

cd %BASE_DIR%
