#!/system/bin/sh

log_dir="/sdcard/wjdoh/evaluation"

DATE="$(date +%m%d%H%M)"
log_dir="${log_dir}/${DATE}"

mkdir ${log_dir}

amlog="${log_dir}/am.log"
touch ${amlog}

vmlog="${log_dir}/vm.log"
touch ${vmlog}

swappiness_path=/proc/sys/vm/swappiness
swappiness_interface=swappiness.txt

function swappiness_monitor() {
    cat ${swappiness_path} > ${swappiness_interface}

    while [ -e ${swappiness_interface} ];
    do
        echo "swappiness.txt exist"
        sleep 10
    done

    while :
    do
        if [ -e ${swappiness_interface} ]; then
            cat ${swappiness_interface} > /proc/sys/vm/swappiness
            rm ${swappiness_interface}
            sleep 5
        else
            sleep 1
        fi
    done
}

function init_zram() {
    swapoff /dev/block/zram0
    sleep 1

    echo 1 > /sys/block/zram0/reset
    sleep 1

    echo lz77eh > /sys/block/zram0/comp_algorithm
    sleep 1

    echo 3G > /sys/block/zram0/disksize
    sleep 1

    mkswap /dev/block/zram0
    sleep 1

    swapon /dev/block/zram0
    sleep 1
}

function chrome() {
    #monkey -p com.android.chrome -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.android.chrome/com.google.android.apps.chrome.Main 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input tap 508 557
    sleep 2
    input text "weather"
    sleep 1
    input tap 660 700
    sleep 2
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input tap 480 750
    sleep 3

    input swipe 600 1400 600 1000 100
    sleep 1
    input swipe 600 1400 600 1000 100
    sleep 1
    input swipe 600 1000 600 1400 100
    sleep 1
    input keyevent KEYCODE_BACK
    sleep 2
    input keyevent KEYCODE_BACK
    sleep 2

    input tap 508 557
    sleep 1
    input text "nasdaq"
    sleep 1
    input tap 600 600
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input tap 570 600
    sleep 3

    input swipe 600 1000 600 1400 100
    sleep 1
    input tap 60 210
    sleep 2
}

function youtube() {
    #monkey -p com.google.android.youtube -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3
    input tap 730 2300
    sleep 2
    input swipe 600 1400 600 800 100
    sleep 2
    input tap 570 600
    sleep 30

    input keyevent 4
    sleep 1

    input tap 350 2300
    sleep 3

    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 3

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
}

function reddit() {
    #monkey -p com.reddit.frontpage -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.reddit.frontpage/launcher.default 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input swipe 600 1400 600 800 100
    sleep 2
    input swipe 600 1400 600 800 100
    sleep 2

    input tap 350 2300
    sleep 3

    input tap 400 500
    sleep 7

    input swipe 600 1400 600 800 500
    sleep 2

    input swipe 600 1400 600 800 500
    sleep 2

    input swipe 600 1400 600 800 500
    sleep 2

    input tap 500 1000
    sleep 4

    input swipe 600 1400 600 00 500
    sleep 2

    input keyevent 4
    input keyevent 4
    input keyevent 4

    input swipe 600 1400 600 800 100
    sleep 2
    input swipe 600 1400 600 800 100
    sleep 2

    input tap 350 2300
    sleep 3

    input tap 400 500
    sleep 7

    input swipe 600 1400 600 800 500
    sleep 2

    input swipe 600 1400 600 800 500
    sleep 2

    input swipe 600 1400 600 800 500
    sleep 2

    input tap 500 1000
    sleep 4

    input swipe 600 1400 600 00 500
    sleep 2

    input keyevent 4
    input keyevent 4
    input keyevent 4
    input keyevent 4
    input keyevent 4
}

function facebook() {
    #monkey -p com.facebook.katana -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.facebook.katana/.LoginActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 2

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 2

    input swipe 600 1400 600 800 100
    sleep 5

    input keyevent 4
}

function twitter() {
    #monkey -p com.twitter.android -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.twitter.android/.StartActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 2

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 5

    input swipe 100 1500 100 700 100
    sleep 2

    input swipe 100 1500 100 700 100
    sleep 5

    input keyevent 4
}

function googlemap() {
    #monkey -p com.google.android.apps.maps -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.apps.maps/com.google.android.maps.MapsActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input tap 500 200
    sleep 1

    input text "coffee shop"
    sleep 2

    input tap 450 400
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1

    input tap 500 200
    sleep 1

    input text "pharmacy"
    sleep 2

    input tap 450 400
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 3

    input keyevent 4
    sleep 1

    input tap 996 991
    sleep 3

    input tap 575 210
    sleep 3

    input tap 553 349
    sleep 3

    input tap 733 579
    sleep 1

    input tap 942 194
    sleep 1

    input tap 555 465
    sleep 1

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
}

function tiktok() {
    #monkey -p com.ss.android.ugc.trill -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 7

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 7

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 7

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
}

function camera() {
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.GoogleCamera/com.android.camera.CameraLauncher 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input tap 558 1760
    sleep 2

    input tap 849 1763  # front camera
    sleep 3

    input tap 558 1760  # take a photo
    sleep 2

    input tap 254 1760  # gallery
    sleep 3

    input swipe 508 842 508 1508 100
    sleep 3

    input tap 864 2008
    sleep 2

    input tap 864 2008
    sleep 2

    input tap 633 2181
    sleep 2

    input tap 558 1760  # take a viedo
    sleep 15

    input tap 558 1760
    sleep 1

    input tap 254 1760  # gallery
    sleep 1

    input tap 550 1167
    sleep 17

    input swipe 508 842 508 1508 100
    sleep 3

    input tap 496 2165
    sleep 1

    input tap 296 2046
    sleep 1

    input tap 296 2046
    sleep 1

    input tap 558 1760
    sleep 1
    input tap 558 1760
    sleep 1
    input tap 558 1760
    sleep 1
    input tap 558 1760
    sleep 1
    input tap 558 1760
    sleep 1

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
}

function gmail() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.gm/.ConversationListActivityGmail 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    sleep 3

    input tap 800 2100
    sleep 1
    input text "wj.doh@snu.ac.kr"
    sleep 1
    input tap 530 800
    sleep 1

    input tap 350 1000
    sleep 1

    input text "Test"
    sleep 1
    input tap 900 200
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3
    input tap 600 1000
    sleep 5

    input swipe 100 1500 100 900 100
    sleep 3

    input keyevent 4
    sleep 1
    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 1500 100 900 100
    sleep 3

    input swipe 100 300 100 1500 100
    sleep 5

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
}

function simple_seq() {
    for i in $(seq 0 3)
    do
        chrome
        youtube
        reddit
        camera
        facebook
        twitter
        gmail
        googlemap
        tiktok
    done
}

function workload_B() {
    for i in $(seq 1 9)
    do
        chrome
        youtube
        reddit
        facebook
    done
}

function force_stop() {
    am force-stop com.android.chrome/com.google.android.apps.chrome.Main
    am force-stop com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity
    am force-stop com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity
    am force-stop com.reddit.frontpage/launcher.default
    am force-stop com.facebook.katana/.LoginActivity
    am force-stop com.twitter.android/.StartActivity
    am force-stop com.quora.android/.components.activities.LauncherActivity
    am force-stop com.google.android.gm/.ConversationListActivityGmail
    am force-stop com.google.android.apps.maps/com.google.android.maps.MapsActivity
    am force-stop com.rovio.baba/com.unity3d.player.UnityPlayerActivity
    am force-stop com.king.candycrushsaga/.CandyCrushSagaActivity
    am force-stop com.google.android.GoogleCamera/com.android.camera.CameraLauncher
}

########### START ###########

echo "TEST START!"

echo "INIT ZRAM"
init_zram

swappiness_monitor &
swappiness_monitor_pid="$!"
echo "MONITOR PID = ${swappiness_monitor_pid}"

# Use LITTLE cores
taskset -p f ${swappiness_monitor_pid}

input keyevent KEYCODE_POWER
sleep 1

input swipe 100 1500 100 450 100
sleep 1

echo "DROP CACHE"
echo 3 > /proc/sys/vm/drop_caches

echo "APP SEQ START"
# simple_seq
workload_B

echo "FORCE STOP"
force_stop

echo "TEST END!"

kill -9 ${swappiness_monitor_pid}

input keyevent KEYCODE_POWER
