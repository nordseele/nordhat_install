#!/bin/bash
set -e

echo "== Patch Nordhat SSD1322 =="

BASE=~/norns/matron/src/hardware/screen
H="$BASE/ssd1322.h"
C="$BASE/ssd1322.c"

echo "Backing up originals (only first time)..."
[ -f "$H.orig" ] || cp "$H" "$H.orig"
[ -f "$C.orig" ] || cp "$C" "$C.orig"

echo "Commenting dtoverlay in /boot/config.txt (if present)..."
sudo sed -i 's/^dtoverlay=ssd1322-spi/#dtoverlay=ssd1322-spi/' /boot/config.txt

echo "Patching GPIO in ssd1322.h..."
sed -i \
  -e 's/#define SSD1322_DC_GPIO_LINE.*/#define SSD1322_DC_GPIO_LINE 24/' \
  -e 's/#define SSD1322_RESET_GPIO_LINE.*/#define SSD1322_RESET_GPIO_LINE 25/' \
  "$H"

echo "Forcing rotation in ssd1322.c..."
sed -i \
  's/write_command_with_data(SSD1322_SET_DUAL_COMM_LINE_MODE, 0x04, 0x11);/write_command_with_data(SSD1322_SET_DUAL_COMM_LINE_MODE, 0x16, 0x11);/' \
  "$C"

echo "Rebuilding Norns..."
cd ~/norns
./waf configure
./waf build

echo "Rebooting..."
sudo reboot
