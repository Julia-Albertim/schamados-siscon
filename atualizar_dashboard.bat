@echo off
title Atualizar Dashboard SISCON
color 0B

REM ============================================================
REM  CONFIGURACAO - edite a linha abaixo uma unica vez
REM
REM  Caminho da planilha DENTRO da pasta do OneDrive sincronizado.
REM  Dica pra achar: abra a pasta do OneDrive no Explorer, clique
REM  com o botao direito no arquivo, Propriedades, copie o campo
REM  "Local", e cole abaixo, entre as aspas, adicionando o nome
REM  do arquivo no final.
REM ============================================================

set "ONEDRIVE_FILE=C:\Users\juliaflora\OneDrive - Fundacao Compesa de Previdencia e Assistencia\Siscon Chamados.xlsx"

set "PROJETO_FILE=Siscon Chamados.xlsx"

REM ============================================================
REM  DAQUI PRA BAIXO NAO PRECISA MEXER
REM ============================================================

echo.
echo ============================================
echo   Atualizando Dashboard SISCON
echo ============================================
echo.

if not exist "%ONEDRIVE_FILE%" (
    echo [ERRO] Nao encontrei o arquivo em:
    echo    %ONEDRIVE_FILE%
    echo.
    echo Abra este .bat com o Notepad e corrija o caminho na linha ONEDRIVE_FILE.
    echo.
    pause
    exit /b 1
)

echo [1/3] Copiando planilha mais recente do OneDrive...
copy /Y "%ONEDRIVE_FILE%" "%PROJETO_FILE%" >nul
if errorlevel 1 (
    echo [ERRO] Falha ao copiar o arquivo.
    pause
    exit /b 1
)
echo       OK.
echo.

echo [2/3] Enviando para o GitHub...
git add "%PROJETO_FILE%"
git commit -m "Atualizacao automatica dos chamados - %date% %time%"
if errorlevel 1 (
    echo       (nada novo para enviar - a planilha nao mudou desde a ultima vez)
) else (
    git push
)
echo.

echo [3/3] Pronto!
echo O GitHub Pages atualiza sozinho em 1-2 minutos.
echo.
pause
