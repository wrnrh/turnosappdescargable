@echo off
title Actualizador Turnos App

echo ==========================================
echo         ACTUALIZADOR TURNOS APP
echo ==========================================
echo.

:: Carpeta donde se guardará la aplicación
set "APPDIR=%LOCALAPPDATA%\Turnos App"

echo Carpeta de instalacion:
echo %APPDIR%
echo.

:: Crear carpeta si no existe
if not exist "%APPDIR%" (
echo Creando carpeta...
mkdir "%APPDIR%"
)

echo Cerrando instancias anteriores...
taskkill /F /IM "Turnos App.exe" >nul 2>&1

timeout /t 1 >nul

echo Eliminando archivos anteriores...
if exist "%APPDIR%\options.ini" del /f /q "%APPDIR%\options.ini"
if exist "%APPDIR%\data.win" del /f /q "%APPDIR%\data.win"
if exist "%APPDIR%\Turnos App.exe" del /f /q "%APPDIR%\Turnos App.exe"

echo.
echo Descargando configuracion...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/wrnrh/turnosappdescargable/5c4597152cce02355eb48e8ece03ad5e809161ec/turnos%%20app/options.ini' -OutFile '%APPDIR%\options.ini'"

if not exist "%APPDIR%\options.ini" (
echo ERROR: No se pudo descargar options.ini
timeout /t 5 >nul
exit
)

echo Configuracion descargada correctamente.

echo.
echo Descargando datos...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/wrnrh/turnosappdescargable/5c4597152cce02355eb48e8ece03ad5e809161ec/turnos%%20app/data.win' -OutFile '%APPDIR%\data.win'"

if not exist "%APPDIR%\data.win" (
echo ERROR: No se pudo descargar data.win
timeout /t 5 >nul
exit
)

echo Datos descargados correctamente.

echo.
echo Descargando aplicacion...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/wrnrh/turnosappdescargable/5c4597152cce02355eb48e8ece03ad5e809161ec/turnos%%20app/Turnos%%20App.exe' -OutFile '%APPDIR%\Turnos App.exe'"

if not exist "%APPDIR%\Turnos App.exe" (
echo ERROR: No se pudo descargar Turnos App.exe
timeout /t 5 >nul
exit
)

echo Aplicacion descargada correctamente.

echo.
echo Verificando archivos...
echo.

for %%F in ("%APPDIR%\options.ini" "%APPDIR%\data.win" "%APPDIR%\Turnos App.exe") do (
echo %%~nxF - %%~zF bytes
)

echo.
echo Iniciando Turnos App...
start "" "%APPDIR%\Turnos App.exe"

echo.
echo Operacion completada.
timeout /t 2 >nul

exit
