set -a
CROSS_COMPILE=$(readlink -e prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin)/arm-eabi-
ARCH=arm
KERNEL_DIR= $(readlink -e kernel/sony/u8500)
KLIB_BUILD=$(readlink -e  out/target/product/kumquat/obj/KERNEL_OBJ)
KLIB=$(readlink -e out/target/product/kumquat/obj/KERNEL_OBJ)
set +a

make -C $BACKPORT_DIR clean;
make -C $BACKPORT_DIR defconfig-xperia;
make -C $BACKPORT_DIR;

rmdir -rf hardware/semc/backports/modules &> /dev/null;
mkdir hardware/semc/backports/modules;

find . -name *.ko -exec mv {}  ./bins \;  &> /dev/null;
