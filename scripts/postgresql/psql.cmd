@ECHO OFF
call "%~dp0\..\start_postgresql_env.cmd"
"%PGDATA%\..\bin\psql" -p %PGPORT% -U %PGUSER%
@REM create database ewsdb;
@REM \connect ewsdb;
@REM CREATE EXTENSION postgis;
@REM CREATE EXTENSION postgis_topology;
@REM \q