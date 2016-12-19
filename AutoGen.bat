@echo off
set verfile= ..\\app\\build\\generated\\source\\buildConfig\\release\\com\\szsitc\\jay\\sitcfirmware\\BuildConfig.java

echo %verfile%
if not exist %verfile% goto exit1
REM for /f "tokens=12 delims=p" %%i in (%verfile%) do echo %%i 

REM 1.APPLICATION_ID
for /f "delims=" %%i in ('findstr APPLICATION_ID %verfile%') do set a=%%i
echo a=%a%

@for /f "tokens=7 delims= " %%i in ("%a%") do set a=%%i
echo i=%a%

set a=%a:~1,-2%
echo a=%a%
set rname=%a%
echo rname=%rname%

REM 2.version
for /f "delims=" %%i in ('findstr VERSION_NAME %verfile%') do set a=%%i
echo a=%a%

@for /f "tokens=7 delims= " %%i in ("%a%") do set a=%%i
echo i=%a%

set a=%a:~1,-2%
echo a=%a%

set rname=%rname%_%a%
echo rname=%rname%

REM 3.release

for /f "delims=" %%i in ('findstr BUILD_TYPE %verfile%') do set a=%%i
echo a=%a%

@for /f "tokens=7 delims= " %%i in ("%a%") do set a=%%i
echo i=%a%

set a=%a:~1,-2%
echo a=%a%

set rname=%rname%-%a%.apk
echo rname=%rname%

REM 4 check file
if not exist %rname% goto exit2

REM 5 get versioncode
for /f "delims=" %%i in ('findstr VERSION_CODE %verfile%') do set a=%%i
echo a=%a%

@for /f "tokens=7 delims= " %%i in ("%a%") do set a=%%i
echo i=%a%

set vercode=%a:~0,-1%
echo vercode=%vercode%

REM 6 build file
git add %rname%
set rname=https://raw.githubusercontent.com/jaytang0923/release_apkms5/master/%rname%
set comment=1.;2.

echo rname=%rname%
set vfile=version1.json
echo { >%vfile%
echo ^"url^":^"%rname%^",>>%vfile%
echo ^"versionCode^":%vercode%,>>%vfile%
echo ^"updateMessage^":^"%comment%^">>%vfile%
echo } >>%vfile%
cat %vfile%
pause
exit 0

:exit1
	echo "release file not exist."
:exit2
	echo file %rname% not exist!
REM pause