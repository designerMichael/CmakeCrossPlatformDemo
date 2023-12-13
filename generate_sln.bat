@echo off
setlocal

REM This script is used to generate vs2015 solution files

REM determine if camke exists
where cmake
if %errorlevel%==0 (
    echo cmake found
) else (
    echo cmake not found
    goto exit_build
)


REM create build directory
set dir_name=build
if exist %dir_name% (
    echo delete %dir_name%
    rd /s/q %dir_name%
)
md %dir_name%
echo create %dir_name%
cd %dir_name%


REM cmake -A x64 表示x64 平台编译
cmake -G "Visual Studio 16 2019" -A x64 ..

if %errorlevel%==0 (
    echo.
    echo.
    echo solution is generated in the %dir_name%
    echo.
    echo.
) else (
    echo.
    echo.
    echo solution generating is failed!!! Please fix the problem before cmake.
    echo.
    echo.

    goto exit_build
)



:build_success
pause
exit /b 0


:exit_build
pause
exit /b 1