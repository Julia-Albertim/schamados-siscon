@echo off
chcp 65001 >nul
title Atualizar Dashboard SISCON
color 0B

REM ============================================================
REM  CONFIGURACAO - edite as 2 linhas abaixo uma unica vez
REM ============================================================

REM Caminho da planilha DENTRO da pasta do OneDrive sincronizado.
REM Dica pra achar: abra o arquivo no Explorer, clique com o botao
REM direito na aba de cima (ou nas propriedades) e copie o caminho.
REM Geralmente comeca com "C:\Users\SEUUSUARIO\Compesa\..." ou
REM "C:\Users\SEUUSUARIO\OneDrive - Compesa\..."
set ONEDRIVE_FILE=C:\Users\SEU_USUARIO\Compesa\NOME_DA_PASTA\Siscon_Chamados.xlsx

REM Nome do arquivo dentro da pasta do projeto (nao precisa mexer)
set PROJETO_FILE=Siscon_Chamados.xlsx

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
    echo   %ONEDRIVE_FILE%
    echo.
    echo Abra esse .bat com o Notepad e corrija o caminho na linha ONEDRIVE_FILE.
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
