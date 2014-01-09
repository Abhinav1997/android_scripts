./CleanCM.sh;
./ResetCM.sh;
./repo forall -c 'git checkout `git rev-list --all -n1 --before="2014-01-06 15:00"`';

pwd=$PWD
git checkout cm-11.0;

cd ./device/sony/kumquat;
git checkout cm-11.0;

cd $pwd; cd ./hardware/sem;
git checkout cm-11.0;

cd $pwd; cd ./kernel/sony/u8500;
git checkout cm-11.0;

cd $pwd; cd ./external/wpa_supplicant_8_ti;
git checkout cm-11.0;

cd $pwd; cd ./external/dbus;
git checkout cm-11.0

cd $pwd;

./CompileCM.sh
