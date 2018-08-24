@ECHO OFF
call "%~dp0\..\start_postgresql_env.cmd"
"%PGDATA%\..\bin\pg_ctl" -U %PGUSER% stop -m fast

