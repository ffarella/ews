@echo off
call "%~dp0\start_ews_env.cmd"
call "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list vms



SET DOCKER_PATH=%EWS_BIN_DIR%\Docker
SET PATH=%DOCKER_PATH%\app;%PATH%

REM for /f "delims=" %%A in ('%~dp0\get_host_ip.cmd') do set "HOST_IP=%%A"
REM echo %HOST_IP%

SET DOCKER_USERNAME=ewsuser
SET MACHINE_HOST_CIDR=192.168.99.1/24
SET MACHINE_NAME=default
SET MACHINE_STORAGE_PATH=%DOCKER_PATH%/data/storage
SET MACHINE_RAM=2000
SET MACHINE_DISK=50000
SET MACHINE_CPU=2

set DOCKER_MACHINE=%EWS_BIN_DIR%\Docker\app\docker-machine.exe
docker-machine create -d virtualbox ^
 --virtualbox-hostonly-cidr "%MACHINE_HOST_CIDR%" ^
 --virtualbox-cpu-count "%MACHINE_CPU%" ^
 --virtualbox-memory "%MACHINE_RAM%" ^
 --virtualbox-disk-size "%MACHINE_DISK%" ^
 --virtualbox-share-folder "\\?\\F:/ews_drives/f" ^
 "%MACHINE_NAME%"

docker-machine start "%MACHINE_NAME%"
docker-machine regenerate-certs -f "%MACHINE_NAME%"
REM docker-machine.exe env --no-proxy --shell=cmd "%MACHINE_NAME%"
for /f "tokens=*" %%i in ('docker-machine.exe env --no-proxy --shell=cmd default') do %%i

echo DOCKER_MACHINE_NAME=%DOCKER_MACHINE_NAME%
echo DOCKER_HOST=%DOCKER_HOST%
echo DOCKER_TLS_VERIFY=%DOCKER_TLS_VERIFY%
echo DOCKER_CERT_PATH=%DOCKER_CERT_PATH%
echo no_proxy=%no_proxy%
echo COMPOSE_CONVERT_WINDOWS_PATHS=%COMPOSE_CONVERT_WINDOWS_PATHS%

SET DOCKER_ID_USER="zype77"