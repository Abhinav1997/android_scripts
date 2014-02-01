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

#Compile
./RecompileCM.sh
