@echo off
set ip_address_string="IPv4-Adresse"
for /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) do (
    echo%%f
    goto :eof
)