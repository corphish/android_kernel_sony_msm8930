#Custom Build Script for automation of build process.



#Build
STRIP="/home/avinaba/android/toolchain/linaro-4.9.3-arm-cortex-a15/bin/arm-eabi-strip"
ZIMAGE="/home/avinaba/android/kernel/taoshan/taoshan/arch/arm/boot/zImage"
IMAGE="/home/avinaba/android/kernel/taoshan/taoshan/arch/arm/boot/Image"
KERNEL_DIR="/home/avinaba/android/kernel/taoshan/taoshan/"
ZIP_DIR="/home/avinaba/android/kernel/taoshan/taoshan/zip"
BUILD_START=$(date +"%s")
cd $KERNEL_DIR
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER="avinaba"
export KBUILD_BUILD_HOST="build"
export CROSS_COMPILE="/home/avinaba/android/toolchain/linaro-4.9.3-arm-cortex-a15/bin/arm-eabi-"
if [ -a $KERNEL_DIR/arch/arm/boot/zImage ];
then
rm $ZIMAGE
rm $IMAGE
fi
make cyanogenmod_taoshan_defconfig
make
if [ -a $ZIMAGE ];
then
echo "Copying modules"
rm $ZIP_DIR/raw/system/lib/modules/*
find . -name 'wlan.ko' -exec cp {} $ZIP_DIR/raw/system/lib/modules \;
cd $ZIP_DIR/raw/system/lib/modules
echo "Stripping modules for size"
$STRIP --strip-unneeded *.ko
fi
