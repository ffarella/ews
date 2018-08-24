@ECHO OFF
call "%~dp0\..\start_postgresql_env.cmd"
ECHO "Starting server"
"%PGDATA%\..\bin\pg_ctl" -U %PGUSER% -l "%PGDATA%/../logfile" start 
