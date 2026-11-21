#!/bin/bash
# Compilation script for Smoothieware with interactive menu
# Based on: https://github.com/Smoothieware/Smoothieware

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
DEVICE="LPC1768"
BUILD_TYPE="Checked"
TESTING=0
NONETWORK=0
CLEAN_ONLY=0

show_help() {
    clear
    echo "========================================="
    echo " Smoothieware Compilation Menu"
    echo "========================================="
    echo ""
    echo "Device: $DEVICE"
    echo "Build type: $BUILD_TYPE"
    echo ""
    echo "Options:"
    echo "  1) Build firmware"
    echo "  2) Build with testing enabled"
    echo "  3) Build without network support"
    echo "  4) Clean build only"
    echo "  5) Show build options"
    echo "  6) Exit"
    echo ""
}

check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"
    
    # Check for make
    if ! command -v make &> /dev/null; then
        echo -e "${RED}Error: 'make' no encontrado${NC}"
        echo "Install with: sudo apt-get install make"
        return 1
    fi
    
    # Check for gcc-arm-none-eabi
    if ! command -v arm-none-eabi-gcc &> /dev/null; then
        echo -e "${RED}Error: 'arm-none-eabi-gcc' no encontrado${NC}"
        echo "Install with: sudo apt-get install gcc-arm-none-eabi"
        return 1
    fi
    
    # Check GCC version
    GCC_VERSION=$(arm-none-eabi-gcc --version 2>&1 | head -1)
    echo -e "${GREEN}$GCC_VERSION${NC}"
    
    return 0
}

build_firmware() {
    echo -e "${GREEN}Iniciando compilación de Smoothieware...${NC}"
    echo ""
    echo "Configuración:"
    echo "  - Device: $DEVICE"
    echo "  - Build type: $BUILD_TYPE"
    echo "  - Testing: $TESTING"
    echo "  - Nonetwork: $NONETWORK"
    echo ""
    
    # Export variables for make
    export DEVICE BUILD_TYPE TESTING NONETWORK
    
    # Create build directory if it doesn't exist
    mkdir -p build
    
    # Run the build
    echo -e "${YELLOW}Ejecutando: make -f makefile all${NC}"
    echo ""
    
    # Capture output
    make -f makefile all 2>&1 | tee build_output.txt
    BUILD_RESULT=${PIPESTATUS[0]}
    
    # Show summary
    echo ""
    if [ $BUILD_RESULT -eq 0 ]; then
        echo -e "${GREEN}========================================${NC}"
        echo -e "${GREEN}¡Compilación completada exitosamente!${NC}"
        echo -e "${GREEN}========================================${NC}"
        echo ""
        echo "Archivo generado: ./src/LPC1768/smoothie.elf"
        echo "Para flashear: make -f src/flash"
    else
        echo -e "${RED}========================================${NC}"
        echo -e "${RED}Fallo en la compilación${NC}"
        echo -e "${RED}========================================${NC}"
        echo ""
        echo "Verifique build_output.txt para obtener detalles"
        echo "Problemas comunes:"
        echo "  - GCC version incompatibles (requiere 9.2.1)"
        echo "  - Missing #include <cstdint>"
        echo "  - ConfigValue.cpp errors"
    fi
}

# Main menu loop
while true; do
    clear
    echo "========================================="
    echo " Smoothieware Compilation Menu"
    echo "========================================="
    echo ""
    echo "Device: $DEVICE"
    echo "Build type: $BUILD_TYPE"
    echo ""
    show_help
    echo ""
    read -p "Select option [1-6]: " option
    echo ""
    
    case $option in
        1)
            if check_prerequisites; then
                build_firmware
                read -p "Press Enter to continue..." -n 1
            fi
            ;;
        2)
            if check_prerequisites; then
                TESTING=1
                build_firmware
                TESTING=0
                read -p "Press Enter to continue..." -n 1
            fi
            ;;
        3)
            if check_prerequisites; then
                NONETWORK=1
                build_firmware
                NONETWORK=0
                read -p "Press Enter to continue..." -n 1
            fi
            ;;
        4)
            echo -e "${BLUE}Cleaning build artifacts...${NC}"
            make -f makefile clean 2>&1 | tail -10
            read -p "Press Enter to continue..." -n 1
            ;;
        5)
            echo -e "${BLUE}Build options:${NC}"
            echo "  DEVICE: $DEVICE (LPC1768 or LPC1769)"
            echo "  BUILD_TYPE: $BUILD_TYPE (Checked/Release/Debug)"
            echo "  TESTING: $TESTING (0/1) - Enable unit tests"
            echo "  NONETWORK: $NONETWORK (0/1) - Exclude network code"
            echo ""
            read -p "Press Enter to continue..." -n 1
            ;;
        6)
            echo -e "${GREEN}Saliendo del menú de compilación...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opción inválida. Por favor seleccione 1-6.${NC}"
            read -p "Press Enter to continue..." -n 1
            ;;
    esac
done
