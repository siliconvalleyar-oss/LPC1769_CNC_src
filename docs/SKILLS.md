# Smoothieware Skills Documentation

## Overview

Smoothieware is a highly configurable firmware for CNC machines, 3D printers, and other motion control systems. This document describes the key "skills" or areas of expertise needed to work with, configure, and extend the firmware.

## Core Skills

### 1. Firmware Configuration
- Editing `configuration.txt` files
- Understanding panel/panel configuration sections
- Setting pin mappings and SPI channels
- Enabling/disabling modules via build defines
- Configuring axis limits, steps per unit, and kinematics

### 2. Build System
- **Makefile-based build**: Top-level `makefile` orchestrates mbed build + src build
  - Targets: `all`, `clean`, `debug-store`, `flash`, `dfu`, `upload`, `debug`, `console`
  - Build type: `Checked` (default, recommended) with MRI debug monitor support
  - Variables: `BUILD_TYPE`, `CNC`, `AXIS`, `PAXIS`, `EXCLUDE_MODULES`
- **Rakefile (Ruby)**: More flexible build system
  - Build types: `Checked`, `Release`, `Debug`, `Testing`
  - Module exclusion system for CNC vs 3D printer builds
  - Web UI generation task
  - Version tracking from git

### 3. Module System
- Modules are located in `src/modules/` and `src/libs/`
- Modules can be excluded at build time via `EXCLUDE_MODULES`
- Default excludes differ for CNC vs 3D printer builds
- CNC build excludes: `tools/filamentdetector`, `tools/scaracal`, `tools/temperaturecontrol`, `tools/temperatureswitch`, `tools/extruder`
- 3D printer build excludes: `tools/drillingcycles`, `tools/spindle`

### 4. Kernel and Module Initialization
- Main entry point: `src/main.cpp`
- `Kernel` class manages module registration and event dispatching
- Modules are created with `new(AHB0) ModuleName()` and added via `kernel->add_module()`
- Conditional compilation with `#ifndef NO_TOOLS_*` flags
- Module loading order matters (e.g., ExtruderMaker before TemperatureControl)

### 5. USB and Connectivity
- USB device stack with CDC, MSD (SD card), and Serial support
- USB initialization in `main.cpp` via `u.init()`
- MSD (SD card) support controllable via `DISABLEMSD` define
- USB Serial port configurable as second console
- DFU (Device Firmware Upgrade) support

### 6. SD Card and File System
- SD card driver via `SDFAT` library
- SPI interface for SD card (P0.18-0.15 on LPC1768)
- `SDCard` object instantiated in `main.cpp`
- Config override file loading from SD card
- FAT file system operations

### 7. Stepper Motor Control
- `StepperMotor` library for motor control
- `StepTicker` for step timing generation
- Planner module for path planning and acceleration/deceleration
- Coordinate systems: Cartesian, Delta, SCARA, H-Bot, Kartesian

### 8. Temperature Control
- `TemperatureControlPool` manages multiple temperature zones
- Support for thermistors, thermocouples (MAX6675, MAX31855)
- PID control support
- Heater bed and extruder temperature control
- `TemperatureSwitch` for mode switching

### 9. Endstops and Probes
- `Endstops` module for limit switches
- `ZProbe` for auto-bed leveling/probing
- Probe types: simple Z probe, BLTouch, capacitive sensing
- Endstop configuration in `[endstops]` section

### 10. Spindle and Laser Control
- `SpindleMaker` for spindle control
- Analog spindle, Huanyang Modbus spindle, PWM spindle
- Laser control via `Laser` module
- Laser power control and fire/stop commands

### 11. Panel and User Interface
- Panel class for LCD/controller integration
- Supported panels: RepRapDiscount GLCD, Viki2, Mini VIKI2, ST7565 OLED, Universal Adapter
- Screen hierarchy: MainMenu, Prepare, Jog, Extruder, Probe, WCS, Control, Custom, DynMenu
- Custom panel configuration via pin definitions

### 12. Networking
- Full TCP/IP stack (UIP-based)
- Ethernet support
- HTTP server for configuration and status
- Telnet, SFTP, DHCP configuration
- Network disablable via `NONETWORK` define

### 13. Configuration Management
- `Config` class for parsing and storing configuration values
- `ConfigValue` for typed configuration values (bool, number, string)
- Configuration override file mechanism (M500/M501 commands)
- Default config from `ConfigSamples/`

### 14. Motion Planning and Coordinates
- `Planner` module for coordinated motion
- `Robot` module for kinematic transformations
- Kinematics: Delta, SCARA, H-Bot, Kartesian
- Coordinate systems: Primary axes, Robot actuators, WCS (Work Coordinate System)

### 15. Tool Management
- `ToolManager` for tool changing and tool definitions
- Extruder, drill, laser tool configurations
- Tool-specific G-code handling

### 16. Safety Features
- `KillButton` for emergency stop
- Watchdog timer support
- `SwitchPool` for tool switch management
- `CurrentControl` for motor current limiting

## Platform-Specific Skills

### LPC1768 (ARM Cortex-M3)
- NXP LPC1768 microcontroller
- CMSIS and device driver library (`src/libs/LPC17xx/`)
- Mbed OS integration
- GPIO pin mapping (P0.x, P1.x, P4.x etc.)
- SPI, UART, ADC, PWM peripherals
- 64KB AHBSRAM0 for critical objects

### mbed Integration
- Mbed OS components from `mbed/drop/` and `mbed/src/`
- Build integration between mbed and Smoothieware
- LPC1768 GCC ARM toolchain

## Extension Skills

### Adding New Modules
1. Create new `.cpp`/`.h` files in `src/modules/` or `src/libs/`
2. Register module in `main.cpp` via `kernel->add_module()`
3. Add to build excludes if needed
4. Update configuration if user-facing

### Custom Panels
- Create new panel class in `src/modules/utils/panel/panels/`
- Register panel type checksum in configuration matching system
- Define pin mappings in `configuration.txt`

### Kinematics extensions
- Add new kinematic model to `src/modules/robot/`
- Update `Robot.h` for registration
- Configure axis mappings in configuration

## Learning Resources

- `docs/ssd1306_oled.md` - Existing documentation example
- `ConfigSamples/` - Configuration samples for different boards
- `src/modules/` - Source code for module patterns
- `src/config.default` - Compile-time defaults template
- Git history for change tracking