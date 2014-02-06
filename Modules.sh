set -a
BACKPORT_DIR=$(readlink -e hardware/semc/backports)
CROSS_COMPILE=$(readlink -e prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin)/arm-eabi-
ARCH=arm
KERNEL_DIR=$(readlink -e kernel/sony/u8500)
KLIB_BUILD=$(readlink -e  out/target/product/kumquat/obj/KERNEL_OBJ)
KLIB=$(readlink -e out/target/product/kumquat/obj/KERNEL_OBJ)
BKPRT_MOD_OUT_DIR=$(readlink -e out/target/product/kumquat)/backport_modules
set +a

make -C $BACKPORT_DIR clean;
make -C $BACKPORT_DIR defconfig-xperia;
make -C $BACKPORT_DIR;

rm -rf $BKPRT_MOD_OUT_DIR &> /dev/null;
mkdir -p $BKPRT_MOD_OUT_DIR;

find $BACKPORT_DIR -name *.ko -exec mv {}  $BKPRT_MOD_OUT_DIR \;  &> /dev/null;
