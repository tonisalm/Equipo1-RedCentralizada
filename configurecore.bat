@echo off 
for /f %%a in ('hostname') do set ant=%%a 
echo Nombre actual del servidor: %ant%
set /p newName= Escribe un nombre nuevo para el servidor: 
netdom renamecomputer %ant% /newname:%newName%
echo Los valores actuales para la red son: 
netsh interface ipv4 show interfaces
echo Nuevos valores de red:
set /p int= Elije la tarjeta de red: 
set /p ip= Escribe la dirección IP fija: 
set /p subred= Escribe la máscara de red: 
set /p gateway= Escribe la puerta de enlace: 
netsh interface ipv4 set address name=%int% source=static address=%ip% mask=%subred% gateway=%gateway% 
netsh interface ipv4 add dnsserver name=%int% address=%ip% index=1
echo Cambios efectuados. Los valores actuales para la red son: 
netsh interface ipv4 show address
pause
ipconfig /all

echo Configurando hora ...
W32tm /query /configuration
w32tm /config /manualpeerlist:"0.es.pool.ntp.org time.google.com" /syncfromflags:manual /update
echo.
W32tm /query /configuration
pause

echo Comprobando fecha:
date /t
set /p "t=Es correcta la fecha? [s] " | set "t=s"
if not %t%==s date

echo.
echo Anota el SID para la auditoria:
whoami /user > SID.txt


