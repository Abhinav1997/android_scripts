#Compile
. build/envsetup.sh && breakfast kumquat && make bootimage && ./Modules;

adb shell reboot fastboot && fastboot flash boot ../out/boot.img
