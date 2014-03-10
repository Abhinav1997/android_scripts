#Set patches directory
patchDir="hardware/semc/patches"

#Download console binary
if [ ! -f vendor/cm/proprietary/Term.apk ]
then
    vendor/cm/get-prebuilts
fi

#Patch
echo Patching...
for d in $(ls $patchDir);
do
  for f in $(ls $patchDir"/"$d | grep .patch);
  do
    git apply -p1 --verbose --ignore-space-change --ignore-whitespace < $patchDir"/"$d"/"$f
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
	  echo "Error $RETVAL with patch $d/$f"
	  exit $RETVAL
    fi
  done
done

find aosp/hardware/libhardware -type f -name "*.mk" -exec rm -f {} \;
rm hardware/libhardware/include/hardware/bluetooth.h
cp aosp/hardware/libhardware/include/hardware/bluetooth.h hardware/libhardware/include/hardware/bluetooth.h

rm hardware/libhardware/include/hardware/bt_sock.h
cp aosp/hardware/libhardware/include/hardware/bt_sock.h hardware/libhardware/include/hardware/bt_sock.h

find aosp/frameworks/base -type f -name "*.mk" -exec rm -f {} \;
rm -rf frameworks/base/core/java/android/bluetooth
cp -r aosp/frameworks/base/core/java/android/bluetooth frameworks/base/core/java/android

rm frameworks/base/services/java/com/android/server/BluetoothManagerService.java
cp aosp/frameworks/base/services/java/com/android/server/BluetoothManagerService.java frameworks/base/services/java/com/android/server/BluetoothManagerService.java


find aosp/packages/apps/Settings -type f -name "*.mk" -exec rm -f {} \;
rm -rf packages/apps/Settings/src/com/android/settings/bluetooth
cp -r aosp/packages/apps/Settings/src/com/android/settings/bluetooth packages/apps/Settings/src/com/android/settings


#Compile
./RecompileCM.sh
