set -a
  BACKPORT_DIR=hardware/semc/backports
  CROSS_COMPILE=$(readlink -e prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin)/arm-eabi-
  ARCH=arm
  KERNEL_DIR=kernel/sony/u8500
  KLIB_BUILD=out/target/product/kumquat/obj/KERNEL_OBJ
  KLIB=out/target/product/kumquat/obj/KERNEL_OBJ
set +a

make -C $BACKPORT_DIR clean;
make -C $BACKPORT_DIR defconfig-xperia;
make -C $BACKPORT_DIR;

rmdir -rf hardware/semc/backports/modules &> /dev/null;
mkdir hardware/semc/backports/modules;

find -type f -name *.ko -exec mv {} hardware/semc/backports/modules \;
