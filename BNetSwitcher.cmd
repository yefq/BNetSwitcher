@echo off
chcp 65001

lua53 "BNetSwitcher.lua"

taskkill /f /t /im "Battle.net.exe"

@REM 请手动修改下面的战网路径 (换成你自己电脑上的路径)
"C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe"