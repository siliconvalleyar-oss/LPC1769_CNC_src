# Smoothieware Module System

## Overview

Smoothieware uses a modular architecture where functionality is organized into
independent modules that are registered with the Kernel at runtime. This allows
for highly configurable firmwares where unused features can be excluded at
compile time.

## Module Organization

### Source Structure

```
src/modules/          # Main functionality modules
  communication/      # G-code handling, serial console
  robot/              # Kinematics: Delta, SCARA, H-Bot, Kartesian
  tools/              # Temperature control, endstops, laser, extruder, etc.
  utils/              # Utility modules: panel, configurator, current control
                      #        : screens, player, simpleshell
  libs/               # Low-level libraries
    Kernel.h          # Core kernel module manager
    StepperMotor.h    # Stepper motor control
    StepTicker.h      # Step timing generation
    Config.h          # Configuration management
    etc.
```

### Module Categories

#### 1. Motion Control
- **Planner** - Coordinated motion planning, acceleration/deceleration
- **Robot** - Kinematic transformations (Delta, SCARA, H-Bot, Kartesian)
- **Conveyor** - Conveyor belt control
- **ActuatorCoordinates** - Coordinate conversions

#### 2. Tool Modules
- **Extruder** - Filament extrusion control
- **TemperatureControl** - PID temperature regulation
- **TemperatureSwitch** - Mode switching between tools
- **Endstops** - Limit switch handling
- **ZProbe** - Auto-bed leveling and probing
- **Laser** - Laser control and power management
- **Spindle** - Spindle speed control (analog, Modbus, PWM)
- **Drillingcycles** - Drilling operations
- **FilamentDetector** - Filament run-out detection
- **SCARAcal** - SCARA calibration
- **RotaryDeltaCalibration** - Rotary delta calibration

#### 3. User Interface
- **Panel** - LCD/controller integration
- **SimpleShell** - Command-line interface
- **Configurator** - Runtime configuration tool
- **Player** - Audio/LED player
- **KillButton** - Emergency stop
- **CurrentControl** - Motor current limiting
- **SwitchPool** - Tool switch management

#### 4. Communication
- **SerialConsole** - Serial port handling
- **GcodeDispatch** - G-code command processing
- **Network** - TCP/IP stack (Ethernet, HTTP, Telnet, SFTP)
- **USBDevice** - USB CDC, MSD, DFU

#### 5. Utilities
- **ConfigValue** - Typed configuration values
- **ConfigCache** - Configuration caching
- **CurrentControl** - Current monitoring
- **PlayLed** - LED status indicators
- **Panel** classes (GLCD, Viki2, OLED, Universal)
- **Screens** - UI screen hierarchy
- **Simpleshell** - Minimal CLI

#### 6. Robot Kinematics
- **Delta** - Delta robot kinematics
- **SCARA** - SCARA robot kinematics
- **H-Bot** - H-Bot / CoreXY kinematics
- **Kartesian** - Cartesian with kinematics
- **Conveyor** - Conveyor belt coordination

## Module Registration

### In `src/main.cpp`

Modules are created and registered with the Kernel:

```cpp
// Create and add main modules
kernel->add_module( new(AHB0) Player() );
kernel->add_module( new(AHB0) CurrentControl() );
kernel->add_module( new(AHB0) KillButton() );
kernel->add_module( new(AHB0) PlayLed() );
```

### Conditional Compilation

Most modules are included/excluded via `#ifndef NO_TOOLS_*`:

```cpp
#ifndef NO_TOOLS_EXTRUDER
ExtruderMaker *em = new ExtruderMaker();
em->load_tools();
delete em;
#endif

#ifndef NO_TOOLS_LASER
kernel->add_module( new Laser() );
#endif

#ifndef NO_TOOLS_SPINDLE
SpindleMaker *sm = new SpindleMaker();
sm->load_spindle();
delete sm;
#endif
```

### Build-Time Exclusion

Modules can also be excluded at build time:

**Makefile:**
```make
export EXCLUDE_MODULES = tools/laser tools/extruder
```

**Rakefile:**
```ruby
EXCLUDE_MODULES = %w(tools/laser tools/extruder)
```

### Default Exclusions

- **CNC builds**: Exclude `tools/filamentdetector`, `tools/scaracal`, 
  `tools/temperaturecontrol`, `tools/temperatureswitch`, `tools/extruder`
- **3D printer builds**: Exclude `tools/drillingcycles`, `tools/spindle`

## Module Lifecycle

1. **Creation**: Module instantiated with `new(AHB0) ModuleName()`
2. **Loading**: `module->load_tools()` called to initialize tool definitions
3. **Registration**: `kernel->add_module(module)` registers with Kernel
4. **Event handling**: Modules receive events via `kernel->call_event()`
5. **Startup**: `kernel->conveyor->start()` and `step_ticker->start()` initiate motion
6. **Shutdown**: Modules cleaned up on firmware reset

## Module Dependencies

Module loading order is important and often documented in `main.cpp`:

```
# Order matters - extruder must be loaded before temperaturecontrol
#ifndef NO_TOOLS_EXTRUDER
ExtruderMaker *em = new ExtruderMaker();
em->load_tools();
delete em;
#endif

#ifndef NO_TOOLS_TEMPERATURECONTROL
TemperatureControlPool *tp = new TemperatureControlPool();
tp->load_tools();
delete tp;
#endif
```

## Adding New Modules

1. Create `.h` and `.cpp` files in appropriate `src/modules/` subdirectory
2. Implement Module base class methods if needed
3. Register module in `main.cpp` with `kernel->add_module()`
4. Add to build exclusion lists if necessary
5. Add configuration entries in `configuration.txt` if user-facing
6. Register checksum for configuration matching (see ConfigValue system)

## Module Communication

Modules communicate via:

1. **Kernel events**: `ON_CONSOLE_LINE_RECEIVED`, `ON_MAIN_LOOP`, `ON_IDLE`
2. **Direct method calls**: Through Kernel references (`THEKERNEL->...`)
3. **Configuration**: Shared configuration values
4. **Public data structures**: `PublicData`, `PublicDataRequest`

## Module Examples

### TemperatureControlPool (`src/modules/tools/temperaturecontrol/`)
- Manages multiple temperature zones (extruder, bed, etc.)
- PID control implementation
- Thermistor/thermocouple support
- Heater pin control

### Endstops (`src/modules/tools/endstops/`)
- Limit switch inputs
- Soft endstops
- Probe triggering logic

### Panel (`src/modules/utils/panel/`)
- LCD controller abstraction
- Multiple panel type support
- Screen hierarchy management

### Network (`src/libs/Network/`)
- UIP TCP/IP stack
- HTTP server for configuration
- Telnet/SFTP/DHCP support