### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=Oplus Kernel by Lotus
do.devicecheck=0
do.modules=0
do.systemless=0
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
# boot shell variables
BLOCK=boot;
IS_SLOT_DEVICE=auto;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=0;
NO_MAGISK_CHECK=1;
NO_VBMETA_PARTITION_PATCH=1;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh

kernel_version=$(cat /proc/version | awk -F '-' '{print $1}' | awk '{print $3}')
case $kernel_version in
    5.1*) ksu_supported=true ;;
    6.1*) ksu_supported=true ;;
    6.6*) ksu_supported=true ;;
    *) ksu_supported=false ;;
esac

ui_print " " "  [✓] ksu_supported: $ksu_supported"
$ksu_supported || abort "  [✗] Non-GKI device, abort."

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

