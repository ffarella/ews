@echo off
call "%~dp0\start_ews_env.cmd"
call "%~dp0\start_conda_env_py36.cmd"
call "%~dp0\start_docker_env.cmd"
setlocal
set EWS_VSCODE_PATH=%EWS_BIN_DIR%/VSCode-insider
set EWS_VSCODE_EXT_PATH=%EWS_CONFIG_DIR%\code_extensions
set EWS_VSCODE_DATA_PATH=%EWS_CONFIG_DIR%\code
set VSCODE_DEV=
set ELECTRON_RUN_AS_NODE=1
call "%EWS_VSCODE_PATH%\Code - Insiders.exe" "%EWS_VSCODE_PATH%\resources\app\out\cli.js"  --extensions-dir="%EWS_VSCODE_EXT_PATH%" --user-data-dir="%EWS_VSCODE_DATA_PATH%"  %*
endlocal