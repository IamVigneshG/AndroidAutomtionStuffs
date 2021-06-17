emulatorName=$1
echo $emulatorName
$ANDROID_HOME/emulator/emulator -avd $emulatorName & EMULATOR_PID=$!
WAIT_CMD="$ANDROID_HOME/platform-tools/adb wait-for-device shell getprop init.svc.bootanim"
until $WAIT_CMD | grep -m 1 stopped; do
  echo "Waiting..."
  sleep 1
done

echo "done"
adb shell settings put global window_animation_scale 0.0
adb shell settings put global transition_animation_scale 0.0
adb shell settings put global animator_duration_scale 0.0
echo "done1"
# adb uninstall com.zoho.sheet.android
# adb install Desktop/app-debugLocal.apk
adb shell settings put system screen_off_timeout 1800000
adb shell svc power stayon true
adb shell settings put system pointer_location 1
echo "emulator install completed"