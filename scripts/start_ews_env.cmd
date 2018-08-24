@echo off
set EWS_BASE_DIR=D:\EWS
set EWS_CONFIG_DIR=%EWS_BASE_DIR%\configuration
set EWS_INST_DIR=%EWS_BASE_DIR%\installers
set EWS_BIN_DIR=%EWS_BASE_DIR%\bin
set EWS_SCRIPTS_DIR=%EWS_BASE_DIR%\scripts
set EWS_SHORTCUTS_DIR=%EWS_BASE_DIR%\schortcuts
set EWS_TEST_DATA_DIR=%EWS_BASE_DIR%\test_data

REM Add Git to the path
set PATH=%EWS_BIN_DIR%\Docker\app\git\bin;%PATH%

REM Add Docker to the path
set PATH=%EWS_BIN_DIR%\Docker\app;%PATH%

REM Add Miniconda to the path
set PATH=%EWS_BIN_DIR%\miniconda2\Scripts;%PATH%
