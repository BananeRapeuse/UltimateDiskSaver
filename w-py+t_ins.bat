@echo off
REM Télécharger et installer Python
echo Téléchargement et installation de Python...
powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.9.5/python-3.9.5-amd64.exe -OutFile python-installer.exe"
python-installer.exe /quiet InstallAllUsers=1 PrependPath=1

REM Vérifier si Python est installé
python --version
IF %ERRORLEVEL% NEQ 0 (
    echo L'installation de Python a échoué.
    exit /b 1
)

REM Installer pip si nécessaire
echo Vérification de pip...
python -m ensurepip --upgrade

REM Installer Paramiko
echo Installation de Paramiko...
python -m pip install paramiko

REM Vérifier si Paramiko est installé
pip show paramiko
IF %ERRORLEVEL% NEQ 0 (
    echo L'installation de Paramiko a échoué.
    exit /b 1
)

echo Installation terminée avec succès.
exit /b 0
