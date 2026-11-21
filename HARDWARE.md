# LPC1769 Hardware Configuration

## Microcontroller Overview

This project uses the **NXP LPC1769** microcontroller, which features:
- **ARM Cortex-M3** core running at up to 120 MHz
- **512 KB** Flash memory
- **100 KB** RAM
- Extensive peripheral set: GPIO, SPI, UART, ADC, PWM, Timers, Ethernet, USB

## Pinout Summary

The LPC1769 pins are organized by port (P0, P1, P2, P3, P4). Below is the pin mapping commonly used in Smoothieware configurations.

### Port 0 (P0)

| Pin | Function | Default Use in Smoothieware |
|-----|----------|----------------------------|
| **P0.0** | GPIO/INT0 | General purpose / External interrupt |
| **P0.1** | GPIO/INT1 | General purpose / External interrupt |
| **P0.2** | RXD | UART0 receive |
| **P0.3** | TXD | UART0 transmit |
| **P0.4** | SCL | I2C clock (if I2C used) |
| **P0.5** | SDA | I2C data (if I2C used) |
| **P0.6** | SD/CD | SD card detect (SPI1) |
| **P0.7** | SD MOSI | SD card SPI data output |
| **P0.8** | SD MISO | SD card SPI data input |
| **P0.9** | SD SCK | SD card SPI clock |
| **P0.10** | LED0 | Status LED (board specific) |
| **P0.11** | LED1 | Status LED (board specific) |
| **P0.12** | SPI1 MOSI | SPI channel 1 data output |
| **P0.13** | SPI1 MISO | SPI channel 1 data input |
| **P0.14** | SPI1 SCK | SPI channel 1 clock |
| **P0.15** | SPI1 SCK / Z_PROBE | SPI clock or Z-probe input |
| **P0.16** | SPI1 CS / Z_PROBE_CS | SPI1 chip select or Z-probe chip select |
| **P0.17** | GPIO | General purpose |
| **P0.18** | UART1_TX / SPI1 MOSI | UART1 transmit or SPI1 MOSI |
| **P0.19** | UART1_RX / SPI1 MISO | UART1 receive or SPI1 MISO |
| **P0.20** | TOUCH_XP | Touchscreen X+ |
| **P0.21** | TOUCH_XM | Touchscreen X- |
| **P0.22** | PWM1 | PWM output (spindle/laser) |
| **P0.23** | PWM2 | PWM output |
| **P0.24** | PWM3 | PWM output |
| **P0.25** | ADC_5 | ADC channel 5 (temperature sensor) |
| **P0.26** | ADC_6 | ADC channel 6 |
| **P0.27** | ADC_7 | ADC channel 7 |
| **P0.28** | ADC_8 | ADC channel 8 |

### Port 1 (P1)

| Pin | Function | Default Use in Smoothieware |
|-----|----------|----------------------------|
| **P1.0** | ADC_9 | ADC channel 9 |
| **P1.1** | ADC_10 | ADC channel 10 |
| **P1.2** | PWM4 | PWM output (extra axis/spindle) |
| **P1.3** | PWM5 | PWM output |
| **P1.4** | PWM6 | PWM output |
| **P1.5** | XTAL2 | Crystal oscillator output |
| **P1.6** | XTAL1 | Crystal oscillator input |
| **P1.7** | Reset | External reset (active low) |
| **P1.18** | STEPPER_X_STEP | Stepper pulse output X axis |
| **P1.19** | STEPPER_X_DIR | Stepper direction output X axis |
| **P1.20** | STEPPER_Y_STEP | Stepper pulse output Y axis |
| **P1.21** | STEPPER_Y_DIR | Stepper direction output Y axis |
| **P1.22** | STEPPER_Z_STEP | Stepper pulse output Z axis |
| **P1.23** | STEPPER_Z_DIR | Stepper direction output Z axis |
| **P1.24** | ENTRY_ENDstop_X_MIN | X-min endstop input |
| **P1.25** | ENTRY_ENDstop_Y_MIN | Y-min endstop input |
| **P1.26** | ENTRY_ENDstop_Z_MIN/Z_PROBE | Z-min endstop or Z-probe input |
| **P1_27** | — | — |

### Port 2 (P2)

| Pin | Function | Default Use in Smoothieware |
|-----|----------|----------------------------|
| **P2.0** | — | — |
| **P2.1** | — | — |
| **P2.2** | CAN_RX | CAN bus receive (if CAN enabled) |
| **P2.3** | CAN_TX | CAN bus transmit (if CAN enabled) |
| **P2.4** | — | — |
| **P2.5** | — | — |
| **P2.6** | — | — |
| **P2.7** | — | — |
| **P2.8** | — | — |
| **P2.9** | — | — |
| **P2.10** | — | — |
| **P2.11** | — | — |
| **P2.12** | — | — |
| **P2.13** | — | — |
| **P2.14** | — | — |
| **P2.15** | — | — |
| **P2.16** | — | — |
| **P2.17** | — | — |
| **P2.18** | — | — |
| **P2.18** | — | — |
| **P2.19** | — | — |
| **P2.20** | — | — |
| **P2.21** | — | — |
| **P2.22** | — | — |
| **P2.23** | — | — |
| **P2.24** | — | — |
| **P2.25** | — | — |
| **P2.26** | — | — |
| **P2.27** | — | — |
| **P2.28** | — | — |

### Port 3 (P3)

| Pin | Function | Default Use in Smoothieware |
|-----|----------|----------------------------|
| **P3.0** | — | — |
| **P3.1** | — | — |
| **P3.2** | — | — |
| **P3.3** | — | — |
| **P3.4** | — | — |
| **P3.5** | — | — |
| **P3.6** | — | — |
| **P3.7** | — | — |
| **P3.8** | — | — |
| **P3.9** | — | — |
| **P3.10** | — | — |
| **P3.11** | — | — |
| **P3.12** | — | — |
| **P3.13** | — | — |
| **P3.14** | — | — |
| **P3.15** | — | — |
| **P3.16** | — | — |
| **P3.17** | — | — |
| **P3.18** | — | — |
| **P3.19** | — | — |
| **P3.20** | — | — |
| **P3.21** | — | — |
| **P3.22** | — | — |
| **P3.23** | — | — |
| **P3.24** | — | — |
| **P3.25** | — | — |

### Port 4 (P4)

| Pin | Function | Default Use in Smoothieware |
|-----|----------|----------------------------|
| **P4.0** | — | — |
| **P4.1** | — | — |
| **P4.2** | — | — |
| **P4.3** | — | — |
| **P4.4** | — | — |
| **P4.5** | — | — |
| **P4.20** | — | — |
| **P4.21** | — | — |
| **P4.22** | — | — |
| **P4.23** | — | — |
| **P4.24** | — | — |
| **P4.25** | — | — |
| **P4.26** | — | — |
| **P4.27** | — | — |
| **P4.28** | LED_5 / MOSFET_1 | Status LED or MOSFET gate (laser/heater) |

## CNC Configuration Pin Assignments

### Stepper Motor Pins (Typical CNC Setup)

| Axis | Step Pin | Dir Pin | Enable Pin |
|------|----------|---------|------------|
| **X** | P1.18 | P1.19 | — |
| **Y** | P1.20 | P1.21 | — |
| **Z** | P1.22 | P1.23 | — |

### Endstop/Probe Inputs

| Endstop/Probe | Pin | Description |
|---------------|-----|-------------|
| **X-min** | P1.24 | Normally closed or normally open switch to ground |
| **Y-min** | P1.25 | Normally closed or normally open switch to ground |
| **Z-min/Z-probe** | P1.26 | Endstop or probe trigger (often connected to Z-min or probe signal) |

### Spindle/Laser PWM

| Function | Pin | Configuration |
|----------|-----|---------------|
| **Spindle PWM** | P0.22 | PWM output, configure via `pwm_period` and `maximum_speed` |
| **Laser PWM** | P0.22 | Same pin can be used for laser power control |
| **PWM Period** | Configurable | Typically 20000 (20ms) for spindle, adjust for laser |

### Cooling/Fan Control

| Function | Pin | Description |
|----------|-----|-------------|
| **Fan PWM** | Not strictly defined | Can use any available PWM pin (P1.2, P1.3, P1.4, P0.22, etc.) |
| **Configuration** | `fan_pin` in `[gcode]` section | Set in `configuration.txt` |

### Temperature Monitoring (CNC typically excludes these, but documented for completeness)

| Sensor | Pin | ADC Channel |
|--------|-----|-------------|
| **Extruder thermistor** | P0.23 / ADC_6 | Configure thermistor table in `[temperature_controls]` |
| **Bed thermistor** | P0.25 / ADC_8 | Configure thermistor table in `[temperature_controls]` |

### Ethernet (if enabled)

| Pin | Function |
|-----|----------|
| **P0.25** | SPI1 MISO (also ADC_8) |
| **P0.24** | SPI1 MOSI (also ADC_7) |
| **P0.23** | SPI1 SCK (also ADC_6) |
| **P0.22** | SPI1 CS/CS0 (also PWM2) |
| **P1_18-P1_21** | GPIO for control buttons/leds |

### USB Device

| Function | Pin |
|----------|-----|
| **USB D+** | P0.29 |
| **USB D-** | P0.30 |
| **VBUS detect** | P1_23 (also endstop Z-min) |

## Pin Alternative Functions

The LPC1769 has extensive alternative functions for each pin. The table above shows the **primary default functions** used in Smoothieware. Many pins can be remapped via:

1. **Pin selection in `configuration.txt`**: Using `pin = Px.y` syntax
2. **GPIO matrix**: Re-routing peripherals via PINSEL registers
3. **Board schematics**: Physical connections determine usable pins

## LPC1768 vs LPC1769 Pin Differences

| Feature | LPC1768 | LPC1769 |
|---------|---------|---------|
| **Maximum Flash** | 256 KB | 512 KB |
| **Maximum RAM** | 40 KB | 100 KB |
| **Maximum CPU Speed** | 100 MHz | 120 MHz |
| **USB Device** | Full speed | Full speed |
| **CAN interfaces** | 1 | 1 (same) |
| **Ethernet MAC** | Yes | Yes (same) |
| **Pin compatibility** | 99% compatible | Minor differences in power management |

**Note**: Most GPIO and peripheral pins are **pin-compatible** between LPC1768 and LPC1769. The main differences are memory size and maximum clock speed. The pin mappings in `configuration.txt` will work on both, but the linker script and clock configuration must be adjusted for LPC1769.

## Custom Pin Remapping Example

If you need to use different pins than the defaults, modify `configuration.txt`:

```ini
[system]
; Override default pins
x_step_pin = P1.20    ; Override X step pin
x_dir_pin = P1.21     ; Override X dir pin
y_step_pin = P1.22    ; Override Y step pin
y_dir_pin = P1.23     ; Override Y dir pin

[gcode]
; Override default PWM pin for spindle
spindle_pwm_pin = P1.22 ; Use P1.22 for spindle PWM
laser_pwm_pin = P1.23   ; Use P1.23 for laser power
```

## Testing Pin Connections

After hardware setup, verify:

1. **Step signals**: Use oscilloscope or multimeter to confirm pulsing on step pins
2. **Endstop inputs**: Trigger each endstop and verify pin state changes
3. **PWM output**: Measure frequency/duty cycle on spindle/laser pins
4. **ADC readings**: Verify thermistor voltages give correct temperature readings
5. **UART communication**: Send/receive data via serial console

## Schematic References

For official pinout and electrical characteristics, refer to:

- **LPC1769 User Manual**: NXP Semiconductor document (UM10532)
- **Smoothieboard v3/4**: Schematic available at smoothieware.org
- **AzteegX5Mini**: Separate schematic for that board

## Power Connections

| Pin | Function |
|-----|----------|
| **P0.25** | 3.3V regulator output (typically) |
| **P0.26-P0.28** | GPIO, not power |
| **VCC_3V3** | Power input 3.3V |
| **VCC_5V** | Power input 5V (if supported) |
| **GND** | Ground connection (multiple pins) |

---
**Documentation generated for LPC1769_CNC_src project.**
**Microcontroller**: NXP LPC1769 (ARM Cortex-M3)
**Configuration**: CNC firmware with Smoothieware