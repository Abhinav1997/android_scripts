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

cp aosp/hardware/libhardware/include/hardware/bluetooth.h hardware/libhardware/include/hardware/bluetooth.h

rm -rf frameworks/base/core/java/android/bluetooth
cp -r aosp/frameworks/base/core/java/android/bluetooth frameworks/base/core/java/android

#Compile
./RecompileCM.sh
