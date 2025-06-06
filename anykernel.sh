#!/bin/bash

### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=Oplus Kernel by Lotus
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot shell variables
block=boot
is_slot_device=1
ramdisk_compression=auto
patch_vbmeta_flag=0
no_magisk_check=1
no_vbmeta_partition_patch=1

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh

# boot install
if [ -L "/dev/block/bootdevice/by-name/init_boot_a" -o -L "/dev/block/by-name/init_boot_a" ]; then
    split_boot	# use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk
    flash_boot	# use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
    ui_print " " "[✓] Oplus Kernel successfully flashed."
else
    dump_boot	 # unpack ramdisk since it is the new first stage init ramdisk where overlay.d must go
    write_boot	 # unpack ramdisk since it is the new first stage init ramdisk where overlay.d must go
fi
## end boot install

