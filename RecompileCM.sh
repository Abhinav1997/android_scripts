#Compile
. build/envsetup.sh && brunch cm_kumquat-userdebug && make otapackage -j4;

#Beep (3x)
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
paplay /usr/share/sounds/freedesktop/stereo/complete.oga;
