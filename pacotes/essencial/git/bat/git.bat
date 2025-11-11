@echo off
setlocal

set "URL_GIT_PORTABLE=https://github.com/Tedi-Company/arquivostedi-group/releases/download/v2.50.0.windows.2/PortableGit.zip"
set "ZIP=PortableGit.zip"
set "PASTA_GIT=%ProgramData%\TediGroup\GitPortable"

echo Baixando Git portatil...
powershell -Command "Invoke-WebRequest -Uri '%URL_GIT_PORTABLE%' -OutFile '%ZIP%'"

echo Extraindo Git portatil...
powershell -Command "Expand-Archive -LiteralPath '%ZIP%' -DestinationPath '%PASTA_GIT%' -Force"

del /f /q "%ZIP%"

echo Git portatil instalado!
endlocal
