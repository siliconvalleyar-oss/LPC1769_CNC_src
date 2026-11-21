# SSD1306 OLED 128x64 Display Configuration

## Overview

Smoothie firmware supports the **SSD1306** OLED display (128x64 pixels) through the `ST7565` panel driver. This display connects via **SPI** to the LPC1768 microcontroller.

## Configuration

To enable the SSD1306 OLED display, add the following to your `configuration.txt` file:

```ini
[panel]
enable = true

; Select SSD1306 OLED variant
lcd_checksum = ssd1306_oled
```

## How it Works

The panel type is selected using **Fletcher checksums** on the `lcd_checksum` configuration value. The firmware computes a checksum of the configured string and matches it against predefined values:

- `reprap_discount_glcd` - RepRapDiscount GLCD
- `st7565_glcd` - Generic ST7565 controller
- `viki2` - VIKI2 controller (variant 1)
- `mini_viki2` - Mini VIKI2 (variant 2)
- `ssd1306_oled` - **SSD1306 OLED 128x64** (variant 3)
- `universal_adapter` - Universal adapter
- `sh1106_oled` - SH1106 OLED 132x64 (variant 4)

## Default Pins (SPI)

The SSD1306 uses the following default SPI pins on the LPC1768:

| Signal | Default Pin | Description |
|--------|-------------|-------------|
| **MOSI** | `P0.18` | SPI data output |
| **MISO** | `P0.17` | SPI data input (optional) |
| **SCK**  | `P0.15` | SPI clock |
| **CS**   | `0.16` | Chip Select |
| **A0/D/C** | `nc` | Data/Command select (connect to GND for hardware SPI mode) |
| **RST**  | `nc` | Reset (optional, can be connected) |

## Custom Pin Configuration

If you need to use different pins, configure them in `configuration.txt`:

```ini
[panel]
spi_channel = 0        ; SPI channel (0 or 1)
spi_cs_pin = 0.16      ; Chip Select pin
a0_pin = nc            ; Data/Command pin
rst_pin = nc           ; Reset pin
```

## Display Orientation

The SSD1306 supports different orientations. The firmware defaults to normal orientation. To reverse the display:

```ini
[panel]
reverse = true
```

## Troubleshooting

- **Blank screen**: Verify SPI connections and power (3.3V required)
- **Garbage patterns**: Check A0/RST pin connections
- **Wrong content**: Try different `spi_channel` value (0 or 1)
- **No display**: Ensure `enable = true` is set in `[panel]` section

## Wiring Example (SPI Mode)

```
SSD1306     LPC1768
  VCC -> 3.3V
  GND -> GND
  SCL -> P0.15 (SCK)
  SDA -> P0.17 (MISO)
  RD  -> P0.18 (MOSI)
  RES -> nc (or connect to pin if using hardware reset)
  A0  -> GND (for hardware SPI mode) or connect to a pin if using software
  VCC -> 3.3V
```

## Note on I2C Connection

This configuration uses **SPI** mode. Some SSD1306 displays can also be connected via I2C, but this firmware version requires SPI. If you have an I2C-connected SSD1306, you may need to modify the `ST7565.cpp` file to use I2C instead of SPI.

## References

- Display driver: `src/modules/utils/panel/panels/ST7565.cpp`
- Panel class: `src/modules/utils/panel/panels/ST7565.h`
- Configuration mechanism: `src/modules/utils/panel/Panel.cpp`