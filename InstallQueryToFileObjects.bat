@echo off
REM *************************************************************************
REM Script: InstallQueryToFileObjects.bat
REM Author: Craig Nobili
REM 
REM Purpose: Install QueryToFile database objects which support the generic
REM          SSIS Data Extract Package.
REM
REM *************************************************************************

REM Check if a servername was passed in
if %1nullparm == nullparm goto NEED_SERVER

SET servername=%1

REM Check if a database was passed in
if %2nullparm == nullparm goto NEED_DATABASE

SET database=%2

echo Installing Database Objects

sqlcmd -E -S %servername% -d %database% -i QueryToFile.CreateSchema.sql      -o QueryToFile.CreateSchema.log

sqlcmd -E -S %servername% -d %database% -i QueryToFile.DataExtractDef.sql    -o QueryToFile.DataExtractDef.log
sqlcmd -E -S %servername% -d %database% -i QueryToFile.DataExtractOut.sql    -o QueryToFile.DataExtractOut.log

sqlcmd -E -S %servername% -d %database% -i QueryToFile.LogBegDataExtract.sql -o QueryToFile.LogBegDataExtract.log
sqlcmd -E -S %servername% -d %database% -i QueryToFile.LogEndDataExtract.sql -o QueryToFile.LogEndDataExtract.log

sqlcmd -E -S %servername% -d %database% -i QueryToFile.RunPkgQuery2File.sql  -o QueryToFile.RunPkgQuery2File.log

sqlcmd -E -S %servername% -d %database% -i ins_DataExtractDef.sql            -o ins_DataExtractDef.log

sqlcmd -E -S %servername% -d %database% -i grants.sql                        -o grants.log


goto END

:NEED_SERVER
echo Usage error, pass in the SERVERNAME as parameter
goto END

:NEED_DATABASE
echo Usage error, pass in the DATABASE as parameter
goto END

:END
