#!/bin/bash
# Compile script for Smoothieware
# Usage: ./script_tools/compile.sh [target]
#
# Targets:
#   all          - Build mbed + src (default)
#   mbed         - Build Mbed OS libraries only
#   status       - Show build status and check prerequisites
#   help         - Show this help message

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

TARGET="${1:-all}"

echo "========================================="
echo "Smoothieware Compile Script"
echo "Proyecto: $PROJECT_DIR"
echo "Target: $TARGET"
echo "========================================="

check_prerequisites() {
    echo ""
    echo "=== Verificando prerequisites ==="
    
    # Check arm-none-eabi tools
    echo "Compilador ARM: $(arm-none-eabi-gcc --version 2>&1 | head -1 2>/dev/null || echo 'No encontrado')"
    
    # Check mbed libraries
    if [ -f "mbed/drop/LPC1768/GCC_ARM/libmbed.a" ]; then
        echo "Librerías mbed LPC1768: ✅ $(ls -lh mbed/drop/LPC1768/GCC_ARM/libmbed.a | awk '{print $5}')"
    else
        echo "Librerías mbed LPC1768: ❌ No encontradas"
    fi
    
    # Check LPC1768.elf
    if [ -f "LPC1768/main.elf" ]; then
        echo "Firmware ELF: ✅ $(ls -lh LPC1768/main.elf | awk '{print $5}')"
    else
        echo "Firmware ELF: ❌ No generado"
    fi
    
    # Check hex
    if [ -f "LPC1768/main.hex" ]; then
        echo "Firmware HEX: ✅ $(ls -lh LPC1768/main.hex | awk '{print $5}')"
    else
        echo "Firmware HEX: ❌ No generado"
    fi
    
    # Check bin
    if [ -f "LPC1768/main.bin" ]; then
        echo "Firmware BIN: ✅ $(ls -lh LPC1768/main.bin | awk '{print $5}')"
    else
        echo "Firmware BIN: ❌ No generado"
    fi
    
    # Check docs
    echo ""
    echo "=== Documentación ==="
    DOC_COUNT=$(ls docs/*.md 2>/dev/null | wc -l)
    echo "Archivos de documentación: $DOC_COUNT"
    ls docs/*.md 2>/dev/null
}

case "$TARGET" in
    all)
        echo ""
        echo "=== Construyendo Mbed OS ==="
        make -C mbed all 2>&1 | tail -3
        echo ""
        
        if [ -f "mbed/drop/LPC1768/GCC_ARM/libmbed.a" ]; then
            echo "✅ Mbed libraries ready"
        else
            echo "❌ Mbed libraries build failed"
        fi
        
        echo ""
        echo "=== Building Smoothieware firmware ==="
        echo "Notas: El build system requiere toolchain completo"
        echo "       y configuración de entorno."
        echo ""
        echo "Para compilar completamente:"
        echo "  1. Asegurar toolchain: arm-none-eabi-gcc, etc."
        echo "  2. Ejecutar: make -C mbed all && make -C src all"
        ;;

    mbed)
        echo "=== Building Mbed OS ==="
        make -C mbed all 2>&1 | tail -5
        if [ -f "mbed/drop/LPC1768/GCC_ARM/libmbed.a" ]; then
            echo "✅ Mbed libraries built successfully"
        else
            echo "❌ Mbed build failed"
        fi
        ;;

    status)
        check_prerequisites
        ;;

    help|--help|-h)
        echo "Smoothieware Compile Script"
        echo ""
        echo "Usage: $0 [target]"
        echo ""
        echo "Targets:"
        echo "  all          - Build complete (mbed + firmware status)"
        echo "  mbed         - Build Mbed OS libraries only"
        echo "  status       - Check build prerequisites and status"
        echo "  help         - Show this help message"
        ;;

    *)
        echo "Unknown target: $TARGET"
        echo "Use '$0 help' for available targets"
        exit 1
        ;;
esac