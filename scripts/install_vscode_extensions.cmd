@echo off
@REM START VSCODE
call "%~dp0\start_code_insiders.cmd"

@REM Copy the settings
echo D | xcopy /y "%EWS_CONFIG_DIR%\code_settings.json" "%EWS_CONFIG_DIR%\code\User\settings.json"

@REM Install the extensions
call "%~dp0\start_code_insiders.cmd" --install-extension christian-kohler.path-intellisense
call "%~dp0\start_code_insiders.cmd" --install-extension dbaeumer.vscode-eslint
call "%~dp0\start_code_insiders.cmd" --install-extension formulahendry.docker-explorer
call "%~dp0\start_code_insiders.cmd" --install-extension HookyQR.beautify
call "%~dp0\start_code_insiders.cmd" --install-extension jhartell.vscode-line-endings
call "%~dp0\start_code_insiders.cmd" --install-extension McCarter.start-git-bash
call "%~dp0\start_code_insiders.cmd" --install-extension ms-python.anaconda-extension-pack
call "%~dp0\start_code_insiders.cmd" --install-extension ms-python.python
call "%~dp0\start_code_insiders.cmd" --install-extension PeterJausovec.vscode-docker
call "%~dp0\start_code_insiders.cmd" --install-extension PKief.material-icon-theme
call "%~dp0\start_code_insiders.cmd" --install-extension redhat.vscode-yaml
call "%~dp0\start_code_insiders.cmd" --install-extension robertohuertasm.vscode-icons
call "%~dp0\start_code_insiders.cmd" --install-extension Zim.vsc-docker


