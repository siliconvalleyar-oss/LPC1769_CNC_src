#!/bin/bash
# Smoothieware Dependencies Installer
# Instala dependencias para compilar Smoothieware firmware
# GCC ARM 9.x es requerido por el README

set -e

echo "Smoothieware Dependencies Installer"
echo "==================================="

# Check for make
if ! command -v make &>/dev/null; then
    echo "Error: make no encontrado"
    echo "Instalar: sudo apt-get install make"
    exit 1
fi

# Check for gcc-arm-none-eabi
if ! command -v arm-none-eabi-gcc &>/dev/null; then
    echo "Instalando gcc-arm-none-eabi (versión 9.x requerida)..."
    sudo apt-get update -qq
    sudo apt-get install -y -qq gcc-arm-none-eabi 2>&1 | tail -3
    
    if ! command -v arm-none-eabi-gcc &>/dev/null; then
        echo "No se pudo instalar gcc-arm-none-eabi"
        echo "Intala manualmente: sudo apt-get install gcc-arm-none-eabi"
        exit 1
    fi
fi

echo "GCC version: $(arm-none-eabi-gcc --version | head -1)"

# Install other basics
sudo apt-get install -y -qq build-essential git 2>&1 | tail -2

echo ""
echo "Dependencies installed successfully!"
echo "You can now run: bash tools/compile.sh"
