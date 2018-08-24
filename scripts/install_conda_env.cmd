@echo off
call "%~dp0\set_ews_env.cmd"
REM DEL /f %USERPROFILE%\.condarc >nul 2>&1
REM DEL /f %USERPROFILE%\.conda >nul 2>&1
call "%EWS_BIN_DIR%/miniconda2/Scripts/activate"
call conda update -n base conda --yes
call conda create --name ewsbase_py36 python=3.6 --yes
call conda create --name ewsbase_py27 python=2.7 --yes
call "%EWS_INST_DIR%/ews_environnement/local_deployement/install_conda_env_py27.cmd"
call "%EWS_INST_DIR%/ews_environnement/local_deployement/install_conda_env_py36.cmd"