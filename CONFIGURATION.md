# Smoothieware Configuration Guide

## Overview

Smoothieware uses a text-based configuration file (`configuration.txt`) to
configure all aspects of the firmware. This document covers the configuration
format, sections, available options, and CNC-specific settings.

## Configuration Format

### Basic Structure

```ini
# Comments start with semicolon (;) or hash (#)
; This is a comment
# This is also a comment

[section_name]
option = value
```

### Value Types

- **Boolean**: `true`, `false`, `1`, `0`
- **Number**: Integer or floating point (e.g., `100`, `3.14`, `9600`)
- **String**: Quoted or unquoted (e.g., `"sdcard"`, `lcd_checksum = ssd1306_oled`)
- **Pin**: Pin definitions (e.g., `P0.15`, `2.10`, `nc`)

## Configuration Sections

### `[system]`

System-level configuration options:

| Option | Description | Default |
|--------|-------------|---------|
| `units` | Measurement units (`mm` or `inches`) | `mm` |
| `angular_units` | Angle units (`deg` or `rad`) | `deg` |
| `feed_rate_multiplier` | Default feed rate multiplier | `1.0` |
| `acceleration` | Default acceleration | `1000.0` |
| `junction_deviation` | Junction deviation for smoothing | `0.05` |
| `mm_per_unit` | Steps per unit for each axis | Configurable |

### `[steps_per_unit]`

Defines steps per millimeter/inch for each axis:

```ini
[steps_per_unit]
x = 80.0
y = 80.0
z = 400.0
e = 14.0
```

### `[axis]`

Axis configuration:

```ini
[axis0]
name = X
pins = P1_18, P1_19
homeswitch = X_MIN
invert_direction = false
```

### `[endstops]`

Endstop configuration:

```ini
[endstops]
homing_order = X:Y:Z
x_min_endstop = x_min
y_min_endstop = y_min
z_min_endstop = z_probe
x_min_endstop_inverted = true
y_min_endstop_inverted = true
z_probe_enable = true
zprobe.endstop = z_min
zprobe.specifics.probe_type = bltouch
zprobe.specifics.x_offset = 0
zprobe.specifics.y_offset = 0
zprobe.specifics.z_offset = -5
```

### `[temperature]`

Temperature control configuration:

```ini
[temperature_controls]
control 1 = extruder
control 2 = bed

[temperature_control 1]
heaters = 0
sensor = thermistor
thermistor = 3950 100k-2
default_temp = 185
default_speed = 150
pid_Kp = 21.66
pid_Ki = 1.19
pid_Kd = 119.7
min_temp = 5
max_temp = 260

[temperature_control 2]
heaters = 1
sensor = thermistor
thermistor = 3950 100k-2
default_temp = 60
default_speed = 50
min_temp = 5
max_temp = 120
```

### `[heater]`

Heater configuration:

```ini
[heater 0]
pin = P1_20
pin_driver = P1_21
pwm_period = 20000
default_pwm = 0
max_pwm = 255
```

### `[panel]`

Panel/LCD configuration:

```ini
[panel]
enable = true
lcd_checksum = ssd1306_oled
spi_channel = 0
spi_cs_pin = 0.16
a0_pin = nc
rst_pin = nc
reverse = false
```

### `[gcode]`

G-code related settings:

```ini
[gcode]
; M106/M107 - Fan control
fan_pin = P1_22
fan_speed_pin = nc

; M80/M81 - Coolant control
coolant_on_command = M80
coolant_off_command = M81

; M0/M1 - Stop
stop_command = M0
```

### `[motion]`

Motion configuration:

```ini
[motion]
maximum_feed_rate_x = 30000
maximum_feed_rate_y = 30000
maximum_feed_rate_z = 10000
maximum_feed_rate_e = 500
acceleration = 3000
junction_deviation = 0.05
```

### `[probes]`

Probe configuration:

```ini
[probes]
zprobe.enable = true
zprobe.enable_after_homing = true
zprobe.slow_feedrate = 5
zprobe.fast_feedrate = 50
zprobe.debounce_ms = 1
zprobe.pins = P1_16, 0.15
zprobe.type = bltouch
```

### `[wifi]` (Network)

```ini
[wifi]
ssid = your_wifi_ssid
password = your_wifi_password
domain_name = smoothie.local
```

### `[file_system]`

SD card and file system:

```ini
[file_system]
sdcd_pin = 0.28
sdcd_active_low = true
sd_oci = 0.27
sd_write_protect_pin = nc
sd_write_protect_active_low = false
```

## CNC-Specific Configuration

### Enabling CNC Mode

```ini
; In configuration.txt or via build defines
[system]
CNC = 1
```

Or via build Makefile:
```make
make CNC=1 all
```

### CNC Exclusive Settings

When `CNC=1` is set, some configuration changes apply:

#### Axis Configuration

```ini
[steps_per_unit]
x = 100.0
y = 100.0
z = 400.0

[motion]
maximum_feed_rate_x = 10000
maximum_feed_rate_y = 10000
maximum_feed_rate_z = 5000
```

#### Kinematics

Support for various kinematic systems:

```ini
; Delta kinematics
[delta_robot]
delta_diagonal_rod = 210
delta_alpha = 30
delta_motor_steps = 1600
delta_radius = 100

; SCARA kinematics
[scara_robot]
scara_arm_1 = 100
scara_arm_2 = 100
scara_motor_steps = 1600
scara_home_x = 0
scara_home_y = 0

; H-Bot / CoreXY
[hbot_robot]
hbot_motor_steps_x = 1600
hbot_motor_steps_y = 1600
hbot_belt_pitch = 2
hbot_tooth_count = 20
```

### Tool Exclusions for CNC

When building with `CNC=1`, these modules are automatically excluded:
- `tools/filamentdetector`
- `tools/scaracal`
- `tools/temperaturecontrol`
- `tools/temperatureswitch`
- `tools/extruder`

### Spindle Configuration (CNC)

```ini
[spindle_1]
control = pwm
pwm_pin = P1_22
pwm_period = 20000
maximum_speed = 10000
minimum_speed = 0
speed_factor = 1
```

### Laser Configuration (CNC)

```ini
[laser_1]
control = pwm
pwm_pin = P1_22
pwm_period = 20000
maximum_power = 255
minimum_power = 0
```

## Configuration Value Types

### Boolean Values

```ini
enable = true        ; Enables feature
invert_direction = false ; Disables inversion
```

### Number Values

```ini
x = 80.0             ; Float value
max_pwm = 255        ; Integer value
default_speed = 1500 ; Integer value
```

### Pin Values

```ini
pin = P1_18         ; LPC1768 pin definition
a0_pin = nc         ; Not connected
rst_pin = P0_25     ; Specific pin
```

### String Values (Checksums)

```ini
lcd_checksum = ssd1306_oled ; Matches predefined checksum
panel = reprap_discount_glcd ; Panel type
```

### Predefined Checksum Values

| Checksum | Description |
|----------|-------------|
| `reprap_discount_glcd` | RepRapDiscount GLCD |
| `st7565_glcd` | Generic ST7565 controller |
| `viki2` | VIKI2 controller |
| `mini_viki2` | Mini VIKI2 |
| `ssd1306_oled` | SSD1306 OLED 128x64 |
| `universal_adapter` | Universal adapter |
| `sh1106_oled` | SH1106 OLED 132x64 |

## Configuration Override File

### Mechanism

The configuration override file is loaded at startup and allows runtime
configuration changes. Format is the same as `configuration.txt`.

### Usage

1. Create `smoothie_overrides.txt` on the SD card
2. M500 command saves current settings to override file
3. M501 command loads override file at startup

```ini
; smoothie_overrides.txt
; M500 saves current knobs/sliders to this file
; M501 loads these settings at boot

[system]
units = mm
```

### Override Priority

1. Default configuration (`configuration.txt`)
2. Override file (`smoothie_overrides.txt`)
3. Runtime G-code commands (M206, M208, etc.)
4. Compile-time defaults (`src/config.default`)

## Pin Definitions

### LPC1768 Pin Format

```
P<port>.<pin>
Examples:
- P0.15 - Port 0, pin 15
- P1_18 - Port 1, pin 18 (alternate notation)
- P4_28 - Port 4, pin 28
- nc  - Not connected
```

### Common Pin Groups

**SPI0:** P0.15 (SCK), P0.17 (MISO), P0.18 (MOSI)
**SPI1:** P0.22 (SCK), P0.23 (MISO), P0.24 (MOSI)
**UART0:** P0.2 (RX), P0.3 (TX)
**UART1:** P0.18 (RX), P0.19 (TX) - alternate

## Configuration Best Practices

1. **Use meaningful names** for axes and tools
2. **Comment your configuration** with `;` or `#`
3. **Test incrementally** - enable one feature at a time
4. **Match sensor types** to thermistor/thermocouple configurations
5. **Verify pin assignments** against your board schematic
6. **Keep backup** of working configuration
7. **Use override file** for temporary changes rather than editing main config
8. **CNC builds** should exclude extruder/temperature modules if not needed
9. **Test probe functionality** before relying on auto-bed leveling
10. **Verify endstop limits** before homing cycles