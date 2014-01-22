#Compile
. build/envsetup.sh && breakfast kumquat && make bootimage;

adb shell reboot fastboot && fastboot flash boot ../out/boot.img

#Beep (3x)
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
