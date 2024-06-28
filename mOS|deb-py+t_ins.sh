#!/bin/bash

# Fonction pour vérifier la dernière commande exécutée
check_last_command() {
    if [ $? -ne 0 ]; then
        echo "Erreur : $1"
        exit 1
    fi
}

# Détection du système d'exploitation
OS=$(uname)

# Installation de Python sur macOS
if [[ "$OS" == "Darwin" ]]; then
    echo "Téléchargement et installation de Python sur macOS..."
    curl -o python-installer.pkg https://www.python.org/ftp/python/3.9.5/python-3.9.5-macosx10.9.pkg
    sudo installer -pkg python-installer.pkg -target /
    check_last_command "L'installation de Python a échoué sur macOS."

# Installation de Python sur Debian-based Linux
elif [[ "$OS" == "Linux" ]]; then
    echo "Téléchargement et installation de Python sur Debian-based Linux..."
    sudo apt update
    sudo apt install -y python3 python3-pip
    check_last_command "L'installation de Python a échoué sur Linux."
fi

# Vérification de l'installation de Python
python3 --version
check_last_command "Python n'est pas installé correctement."

# Installation de pip (si nécessaire)
echo "Vérification de pip..."
python3 -m ensurepip --upgrade

# Installation de Paramiko
echo "Installation de Paramiko..."
python3 -m pip install paramiko
check_last_command "L'installation de Paramiko a échoué."

# Vérification de l'installation de Paramiko
pip3 show paramiko
check_last_command "Paramiko n'est pas installé correctement."

echo "Installation terminée avec succès."
exit 0
