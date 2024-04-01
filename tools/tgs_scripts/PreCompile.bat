@echo off
cd /D "%~dp0"
set TG_BOOTSTRAP_CACHE=%cd%
IF EXIST "..\Game\B\tgstation.dmb" (
	rem TGS3: Game/B/tgstation.dmb exists, so build in Game/A
	cd ..\Game\A
) ELSE (
	rem TGS3: Otherwise build in Game/B
	cd ..\Game\B
)
set CBT_BUILD_MODE=TGS
tools\build\build
