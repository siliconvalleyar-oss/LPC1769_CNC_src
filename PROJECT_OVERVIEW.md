# Smoothieware Project Overview

## Project Purpose

Smoothieware is an open-source firmware for motion control systems, primarily
CNC machines, 3D printers, and laser cutters. It runs on NXP LPC1768 and other
ARM Cortex-M based microcontrollers, providing precise motion control, I/O
management, and communication capabilities.

## Key Features

### Motion Control
- Coordinated multi-axis motion with acceleration/deceleration planning
- Support for various kinematic systems: Cartesian, Delta, SCARA, H-Bot, CoreXY,
  Kartesian
- Configurable stepper motor control with microstepping support
- Junction deviation for smooth curve blending
- Independent or synchronized axis movement

### I/O Management
- GPIO pin control for LEDs, limit switches, heaters
- PWM output for spindle speed, laser power, fan control
- ADC input for temperature sensors, probes
- SPI, UART, I2C communication interfaces
- GPIO expanders and expander modules

### Temperature Control
- PID-controlled extruder and bed heating
- Thermistor and thermocouple support (MAX6675, MAX31855)
- Multiple temperature zone management
- Automatic tune and safe temperature limits

### User Interface
- LCD panel support: RepRapDiscount GLCD, Viki2, Mini VIKI2, ST7565 OLED,
  Universal Adapter
- Graphic LCD with SD card navigation
- Custom screen hierarchy (MainMenu, Prepare, Jog, Extruder, Probe, WCS, etc.)
- Simple serial console interface
- Physical buttons and rotary encoders

### Connectivity
- USB device: CDC (serial), MSD (SD card), DFU ( Firmware upgrade)
- Ethernet network with TCP/IP stack (UIP)
- HTTP server for configuration and status
- Telnet and SFTP support
- DHCP client
- Wireless WiFi support (optional)

### File System
- SD card support via SPI
- FAT file system (SDFAT library)
- G-code file execution from SD
- Configuration file management
- Config override file mechanism

### Tool Management
- Extruder control with filament loading/unloading
- Spindle speed control (analog, Modbus PWM)
- Laser power control
- Drilling and tapping cycles
- Tool change management

### Safety Features
- Emergency stop (KillButton)
- Watchdog timer
- Endstop limit switches
- Temperature safe limits
- Current limiting

## Architecture

### Kernel-Based Design

The core of Smoothieware is the `Kernel` class which manages:
- Module registration and lifecycle
- Event dispatching (`ON_MAIN_LOOP`, `ON_IDLE`, `ON_CONSOLE_LINE_RECEIVED`)
- Configuration management
- Stream output to various destinations (serial, LCD, network)
- Memory management via AHB0 allocator

### Module System

Functionality is divided into independent modules that register with the Kernel:
- Modules are created in `src/main.cpp` with `new(AHB0) ModuleName()`
- Added via `kernel->add_module()`
- Conditionally compiled with `#ifndef NO_TOOLS_*` flags
- Excludable at build time via `EXCLUDE_MODULES`
- Loading order is critical for dependent modules

### Build Systems

#### GNU Make (`makefile`)
Top-level build system that orchestrates:
1. Mbed OS build (`make -C mbed`)
2. Smoothieware source build (`make -C src`)

Targets: `all`, `clean`, `flash`, `dfu`, `upload`, `debug`, `console`

#### Ruby Rake (`Rakefile`)
More flexible Ruby-based build system with:
- Multiple build types: Checked, Release, Debug, Testing
- Module exclusion system
- Web UI generation
- Version tracking from git
- CNC vs 3D printer build profiles

### Platform Support

#### LPC1768 (ARM Cortex-M3)
- Primary supported platform
- NXP LPC1768 microcontroller
- 256KB Flash, 40KB RAM
- mbed OS integration
- GPIO, SPI, UART, ADC, PWM peripherals
- 64KB AHBSRAM0 for critical objects

#### LPC11U24 (ARM Cortex-M0)
- Secondary platform
- NXP LPC11U24 microcontroller
- 32KB Flash, 8KB RAM

### Source Organization

```
src/
  main.cpp          # Firmware entry point
  version.*         # Version string from git
  config.default    # Compile-time defaults
  makefile          # GNU make build file
  libs/             # Libraries (ADC, Kernel, Pin, etc.)
  modules/          # Functional modules (motion, tools, utils, communication, robot)
  testframework/    # Unit test infrastructure
  modules/utils/panel/  # Panel/LCD drivers
```

### Configuration

- `configuration.txt` - Main user configuration file
- `src/config.default` - Compile-time defaults (git assume-uncommended)
- `ConfigSamples/` - Pre-configured samples for various boards
- Override file: `smoothie_overrides.txt` on SD card

## Supported Boards

### Smoothieboard
- Original hardware design by Smoothie Industries
- LPC1768-based
- Comprehensive header layout
- SD card socket, USB, Ethernet (optional)

### AzteegX5Mini
- Compact board design
- LPC1768-based
- Different pinout than Smoothieboard

### Custom boards
- Users can configure for various LPC1768-based boards
- Pin mappings adjustable in configuration.txt