@ECHO OFF
call "%~dp0\..\start_postgresql_env.cmd"
"%PGDATA%\..\bin\initdb" -U %PGUSER% -A trust --locale=C --encoding=UTF8
ECHO "Click enter to exit"
pause