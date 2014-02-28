#Set patches directory
patchDir="hardware/semc/patches"

#Download console binary
if [ ! -f vendor/cm/proprietary/Term.apk ]
then
    vendor/cm/get-prebuilts
fi

#Patch
echo Patching...
for f in $(ls $patchDir | grep .patch);
do
  patch -p1 --verbose < $patchDir"/"$f
  RETVAL=$?
  if [ $RETVAL -ne 0 ]; then
        echo "Error with patch $f"
        exit $RETVAL
  fi
done

find aosp/hardware/libhardware -type f -name "*.mk" -exec rm -f {} \;
rm hardware/libhardware/include/hardware/bluetooth.h
cp aosp/hardware/libhardware/include/hardware/bluetooth.h hardware/libhardware/include/hardware/bluetooth.h

find aosp/frameworks/base -type f -name "*.mk" -exec rm -f {} \;
rm -rf frameworks/base/core/java/android/bluetooth
cp -r aosp/frameworks/base/core/java/android/bluetooth frameworks/base/core/java/android

find aosp/packages/apps/Settings -type f -name "*.mk" -exec rm -f {} \;
rm -rf packages/apps/Settings/src/com/android/settings/bluetooth
cp -r aosp/packages/apps/Settings/src/com/android/settings/bluetooth packages/apps/Settings/src/com/android/settings


#Compile
./RecompileCM.sh
