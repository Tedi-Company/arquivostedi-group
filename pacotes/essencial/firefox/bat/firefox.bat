@echo off
setlocal

set "NOME_APP=Firefox Tedi"
set "URL_ZIP=https://github.com/Tedi-Company/arquivostedi-group/releases/download/140.0.2/FirefoxPortable.zip"
set "ZIP=FirefoxPortable.zip"
set "PASTA_DEST=%ProgramData%\TediGroup\Firefox"
set "URL_GIT_INSTALLER=https://github.com/Tedi-Company/arquivostedi-group/releases/download/v2.50.0.windows.2/git-installer.bat"
set "GIT_INSTALLER=git-installer.bat"

:: Verifica se o Git está instalado
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git nao encontrado. Instalando Git...
    powershell -Command "Invoke-WebRequest -Uri '%URL_GIT_INSTALLER%' -OutFile '%GIT_INSTALLER%'"
    call %GIT_INSTALLER%
) else (
    echo Git ja instalado.
)

echo Baixando %NOME_APP%...
powershell -Command "Invoke-WebRequest -Uri '%URL_ZIP%' -OutFile '%ZIP%'"

echo Criando pasta de instalação...
if not exist "%PASTA_DEST%" mkdir "%PASTA_DEST%"

echo Extraindo arquivos...
powershell -Command "Expand-Archive -LiteralPath '%ZIP%' -DestinationPath '%PASTA_DEST%' -Force"

del /f /q "%ZIP%"

echo Criando atalho na area de trabalho...
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('$env:USERPROFILE\Desktop\%NOME_APP%.lnk');$s.TargetPath='%PASTA_DEST%\FirefoxPortable.exe';$s.IconLocation='%PASTA_DEST%\FirefoxPortable.exe';$s.Save()"

echo Criando atalho no menu iniciar...
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('$env:APPDATA\Microsoft\Windows\Start Menu\Programs\%NOME_APP%.lnk');$s.TargetPath='%PASTA_DEST%\FirefoxPortable.exe';$s.IconLocation='%PASTA_DEST%\FirefoxPortable.exe';$s.Save()"

echo Instalacao concluida!
pause
endlocal
