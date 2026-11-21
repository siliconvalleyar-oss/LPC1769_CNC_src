# Building Smoothieware

## Prerequisites

### Toolchain
- **GCC ARM Embedded**: `arm-none-eabi-gcc`, `arm-none-eabi-g++`, `arm-none-eabi-objcopy`
- **Make** (GNU make)
- **Ruby** (for Rakefile build system)
- **dfu-util** (for DFU uploads)
- **lpc21isp** (for hex firmware flashing)
- **arm-none-eabi-gdb** (for debugging)

### Directory Structure
```
Smoothieware/
├─ makefile          (top-level GNU makefile)
├─ Rakefile          (Ruby build system)
├─ mbed/             (Mbed OS components)
├─ src/              (Main source code)
├─ ConfigSamples/    (Configuration samples)
└─ docs/             (Documentation)
```

## Build Systems

### GNU Make (`makefile`)

The top-level `makefile` is the primary build system:

```bash
# Build everything (mbed + src)
make all

# Clean build artifacts
make clean

# Flash firmware to board
make flash

# DFU upload
make dfu

# Open console
make console
```

**Targets:**
- `all` - Build mbed then Smoothie firmware
- `clean` - Clean both mbed and src build outputs
- `debug-store` - Store ELF for debugging
- `flash` - Build and flash via lpc21isp
- `dfu` - Build and upload via DFU
- `upload` - DFU upload with device reset
- `debug` - Launch GDB debugger
- `console` - Start serial console

**Build Flow:**
1. `make -C mbed` - Build Mbed OS
2. `make -C src` - Build Smoothieware firmware

### Ruby Rake (`Rakefile`)

Alternative build system using Rake:

```bash
# Checked build (default)
rake

# Debug build
rake debug=1

# Release build
rake release=1

# Testing build
rake testing=1

# CNC build
rake cnc=1

# Exclude modules
rake exclude="tools/laser tools/extruder"
```

**Key Rake tasks:**
- `:build` - Default task (builds firmware)
- `:upload` - Upload via DFU
- `:size` - Show binary size
- `:webui` - Build web UI data
- `:version` - Generate version string from git

**Rake build types:**
- `Checked` - Optimizations enabled with MRI debug monitor (recommended)
- `Release` - Optimizations only
- `Debug` - No optimizations with MRI debug monitor
- `Testing` - For unit testing

## Configuration-Driven Build

Both build systems support configuration-driven module inclusion/exclusion:

### Makefile Configuration

```make
# CNC build (excludes 3D printer tools)
make CNC=1 all

# Set axis count
make AXIS=4 all

# Set primary axes
make PAXIS=3 all

# Exclude specific modules
make EXCLUDE_MODULES="tools/laser tools/extruder" all
```

### Rakefile Configuration

```ruby
# CNC build
rake CNC=1

# Exclude modules
rake exclude="tools/laser tools/temperaturecontrol"

# Set baud rate
rake BAUDRATE=115200

# Debug build
rake debug=1
```

## Module Exclusion

Modules can be excluded from the build for customized firmwares:

**CNC builds** typically exclude:
- `tools/filamentdetector`
- `tools/scaracal`
- `tools/temperaturecontrol`
- `tools/temperatureswitch`
- `tools/extruder`

**3D printer builds** typically exclude:
- `tools/drillingcycles`
- `tools/spindle`

### Exclusion Methods

**Makefile:**
```make
export EXCLUDE_MODULES = tools/laser tools/extruder
```

**Rakefile:**
```ruby
EXCLUDE_MODULES = %w(tools/laser tools/extruder)
```

## Version Tracking

Both build systems pull version information from git:

- **Makefile**: Uses `generate-version.sh` or `generate-version.bat`
- **Rakefile**: Uses `git symbolic-ref HEAD` and `git log --pretty=format:%h -1`

Version string format: `HEAD-refhash-gcommitcount`

## Cleaning

```bash
# Clean build artifacts
make clean

# Full clean (including mbed)
make realclean
```

## Troubleshooting

- **Missing tools**: Ensure `arm-none-eabi-*` tools are in PATH
- **Mbed build failures**: Check `mbed/` directory and mbed OS version compatibility
- **Module compilation errors**: Verify `EXCLUDE_MODULES` doesn't conflict with required modules
- **Memory issues**: Adjust `STACK_SIZE` in makefile or `STACK_SIZE=3072` in Rakefile