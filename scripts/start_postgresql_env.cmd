@ECHO OFF
REM The script sets environment variables helpful for PostgreSQL
call "%~dp0\start_ews_env.cmd"
ECHO ##################################################################
ECHO postgresql path: %EWS_BIN_DIR%\postgresql-9.6.9
ECHO ##################################################################
@SET PATH="%EWS_BIN_DIR%\postgresql-9.6.9\bin";"%EWS_BIN_DIR%\PgAdminPortable";%PATH%
@SET PGDATA=%EWS_BIN_DIR%\postgresql-9.6.9\data
@SET PGDATABASE=postgres
@SET PGUSER=postgres
@SET PGPORT=5439
@SET PGLOCALEDIR=%EWS_BIN_DIR%\postgresql-9.6.9\share\locale