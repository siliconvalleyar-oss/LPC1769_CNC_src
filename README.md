# LPC1769_CNC_src

Smoothieware firmware configuration and source files for LPC1769 microcontroller with CNC (Computer Numerical Control) functionality.

## Project Overview

This project contains the documentation, configuration, and source structure for running Smoothieware on an LPC1769-based CNC controller. Smoothieware is an open-source motion control firmware suitable for CNC machines, 3D printers, and laser cutters.

## Supported Features

### CNC-Specific Configuration
- 3-axis control (X, Y, Z)
- Spindle speed control (PWM, analog, Modbus)
- Laser power control
- Configurable kinematics (Delta, SCARA, H-Bot, Cartesian)
- Endstop and probe support
- Temperature control exclusion (CNC build excludes thermal modules)

### Build Configuration
- **Build type**: Checked (recommended - optimizations with MRI debug monitor)
- **Device**: LPC1769 (ARM Cortex-M3)
- **Module exclusion**: CNC-optimized excludes for 3D printer modules
- **Toolchain**: arm-none-eabi-gcc/arm-none-eabi-g++

### Documentation
Comprehensive documentation included in `docs/`:
- `BUILDING.md` - Build system guide (Makefile & Rakefile)
- `CONFIGURATION.md` - Configuration guide with all sections
- `MODULES.md` - Module system architecture
- `PROJECT_OVERVIEW.md` - Project overview and architecture
- `SKILLS.md` - Required skills and components
- `ssd1306_oled.md` - SSD1306 OLED 128x64 display configuration

## Quick Start

### Prerequisites
- `arm-none-eabi-gcc` and `arm-none-eabi-g++` toolchain
- `make` (GNU make)
- `lpc21isp` (for flashing)
- `dfu-util` (for DFU uploads)
- Git

### Build Steps
```bash
# 1. Build Mbed OS libraries
make -C mbed all

# 2. Build Smoothieware firmware
make -C src

# 3. Output files
#   ./LPC1769/main.elf   - ELF binary
#   ./LPC1769/main.hex   - Intel HEX (for lpc21isp)
#   ./LPC1769/main.bin   - Binary (for DFU)
```

### CNC Build
The Makefile is pre-configured for CNC builds. Modules automatically excluded:
- `tools/filamentdetector`
- `tools/scaracal`
- `tools/temperaturecontrol`
- `tools/temperatureswitch`
- `tools/extruder`

## Repository Structure

```
/LPC1769_CNC_src/
├── docs/              # Documentation (6 .md files)
├── makefile           # GNU make build system
├── config.default     # Compile-time defaults
├── src/               # Source code directory
│   ├── main.cpp       # Firmware entry point
│   └── ...            # Module sources
├── libs/              # Libraries (ADC, Kernel, Pin, etc.)
├── modules/           # Functional modules
│   ├── communication/ # Gcode, SerialConsole
│   ├── robot/         # Kinematics: Delta, SCARA, H-Bot
│   ├── tools/         # Temperature, Endstops, Laser, Spindle
│   ├── utils/         # Panel, Configurator, CurrentControl
│   └── communication/ # Serial, Network
├── docs/              # Documentation
└── LICENSE            # MIT License (siliconvalleyar-oss)
```

## License

This project is licensed under the **MIT License** - see the `LICENSE` file for details.

Copyright (c) 2026 siliconvalleyar-oss

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Links

- **GitHub Repository**: https://github.com/siliconvalleyar-oss/LPC1769_CNC_src
- **Smoothieware Official**: http://smoothieware.org/
- **Documentation**: See `docs/` directory