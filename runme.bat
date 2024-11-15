@echo off

REM Define the executable file/command and its parameters
set "EXECUTABLE=java"          REM Executable command or file to run
set "EXTENSION=jar"            REM File extension
set "EXTRA_PARAM1=-jar"        REM Additional parameter 1
set "EXTRA_PARAM2=--foo"       REM Additional parameter 2

REM Get the current script name without the extension
set "SCRIPT_NAME=%~n0"
REM Construct the target filename using the script name and extension in the same folder as the script
set "SCRIPT_DIR=%~dp0"          REM Get the directory of the current script
set "TARGET_FILE=%SCRIPT_DIR%%SCRIPT_NAME%.%EXTENSION%" REM Build the full path to the target file

REM Get the external parameter (can be empty)
set "EXTERNAL_PARAM1=%~1"

REM Build and execute the final command
@echo on
%EXECUTABLE% %EXTRA_PARAM1% %TARGET_FILE% %EXTRA_PARAM2% %EXTERNAL_PARAM1%
