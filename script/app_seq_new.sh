#!/system/bin/sh

log_dir="/sdcard/syko/evaluation"

DATE="$(date +%m%d%H%M)"
log_dir="${log_dir}/${DATE}"

mkdir ${log_dir}

amlog="${log_dir}/am.log"
touch ${amlog}

vmlog="${log_dir}/vm.log"
touch ${vmlog}

swaplog="${log_dir}/swap.log"
touch ${swaplog}

pidlog="${log_dir}/pid.log"
touch ${pidlog}



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
	    cat ${swappiness_interface} >> ${swaplog}            
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

    echo /dev/block/loop46 > /sys/block/zram0/backing_dev
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
    echo "chrome" >> ${pidlog}
    ps -ef | grep com.android.chrome/com.google.android.apps.chrome.Main >> ${pidlog}

    sleep 3

    input tap 570 600
    sleep 2
    input text "weather"
    sleep 2
    input tap 660 700
    sleep 3
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input keyevent 4
    sleep 1

    export PACKAGE="com.android.chrome"
}
function chrome_anon() {
    #monkey -p com.android.chrome -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.android.chrome/com.google.android.apps.chrome.Main 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
    echo "chrome" >> ${pidlog}
    ps -ef | grep com.android.chrome/com.google.android.apps.chrome.Main >> ${pidlog}

    sleep 3

    input tap 570 600
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
    input tap 60 210
    sleep 2

    input tap 570 600
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
    sleep 2

    input swipe 600 1000 600 1400 100
    sleep 1
    input tap 60 210
    sleep 2

    input tap 570 600
    sleep 2
    input text "eurosys2025"
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
    input tap 60 210
    sleep 2

    input tap 570 600
    sleep 2
    input text "italy"
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
    input tap 60 210
    sleep 2

    export PACKAGE="com.android.chrome"
}
function youtube() {
    #monkey -p com.google.android.youtube -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "youtube" >> ${pidlog}
    ps -ef | grep com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity >> ${pidlog}

    sleep 3
    input tap 730 2300
    sleep 2
    input swipe 600 1400 600 800 100
    sleep 2
    input tap 570 600
    sleep 50

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1

    input tap 1020 2150
    sleep 1

    #input tap 350 2300
    #sleep 3

    #input swipe 600 1400 600 800 100
    #sleep 3
    #input swipe 600 1400 600 800 100
    #sleep 3
    #input swipe 600 1400 600 800 100
    #sleep 3
    #input swipe 600 1400 600 800 100
    #sleep 3
    #input swipe 600 1400 600 800 100
    #sleep 3
    #input swipe 600 1400 600 800 100
    #sleep 3

    export PACKAGE="com.google.android.youtube"
}

function reddit() {
    #monkey -p com.reddit.frontpage -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.reddit.frontpage/launcher.default 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}
   
    echo "reddit" >> ${pidlog}
    ps -ef | grep com.reddit.frontpage/launcher.default >> ${pidlog}

    sleep 3

    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10
    input swipe 600 1400 600 800 100
    sleep 10

    export PACKAGE="com.reddit.frontpage"
}

function facebook() {
    #monkey -p com.facebook.katana -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.facebook.katana/.LoginActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "facebook" >> ${pidlog}
    ps -ef | grep com.facebook.katana/.LoginActivity >> ${pidlog}

    sleep 3

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    export PACKAGE="com.facebook.katana"
}

function facebook_anon() {
    #monkey -p com.facebook.katana -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.facebook.katana/.LoginActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "facebook" >> ${pidlog}
    ps -ef | grep com.facebook.katana/.LoginActivity >> ${pidlog}

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

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 2

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

    export PACKAGE="com.facebook.katana"
}

function twitter() {
    #monkey -p com.twitter.android -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.twitter.android/.StartActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "twitter" >> ${pidlog}
    ps -ef | grep com.twitter.android/.StartActivity >> ${pidlog}    

    sleep 3

    input swipe 100 1500 100 700 100
    sleep 10

    input swipe 100 1500 100 700 100
    sleep 10

    input swipe 100 1500 100 700 100
    sleep 10

    input swipe 100 1500 100 700 100
    sleep 10

    input swipe 100 1500 100 700 100
    sleep 10

    input swipe 100 1500 100 700 100
    sleep 10

    export PACKAGE="com.twitter.android"
}

function twitter_anon() {
    #monkey -p com.twitter.android -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.twitter.android/.StartActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "twitter" >> ${pidlog}
    ps -ef | grep com.twitter.android/.StartActivity >> ${pidlog}

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

    export PACKAGE="com.twitter.android"
}

function googlemap() {
    #monkey -p com.google.android.apps.maps -v 1
    # sleep ${SLEEP}
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.apps.maps/com.google.android.maps.MapsActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "googlemap" >> ${pidlog}
    ps -ef | grep com.google.android.apps.maps/com.google.android.maps.MapsActivity >> ${pidlog}

    sleep 3

    input tap 500 200
    sleep 1

    input text "coffee shop"
    sleep 2

    input tap 450 400
    sleep 3

    input swipe 500 2000 500 1400 100
    sleep 10

    input swipe 500 2000 500 1400 100
    sleep 10

    input swipe 500 2000 500 1400 100
    sleep 10

    input swipe 500 2000 500 1400 100
    sleep 10

    input swipe 500 2000 500 1400 100
    sleep 10

    input swipe 500 2000 500 1400 100
    sleep 10

    input keyevent 4
    sleep 1
    input keyevent 4
    sleep 1
    export PACKAGE="com.google.android.apps.maps"
}

function tiktok() {
    #monkey -p com.ss.android.ugc.trill -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "tiktok" >> ${pidlog}
    ps -ef | grep com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity >> ${pidlog}


    sleep 3

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10

    input swipe 600 1400 600 800 100
    sleep 10


    export PACKAGE="com.ss.android.ugc.trill"
}

function tiktok_anon() {
    #monkey -p com.ss.android.ugc.trill -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "tiktok" >> ${pidlog}
    ps -ef | grep com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity >> ${pidlog}


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
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 7

    input swipe 600 1400 600 800 100
    sleep 5

    input swipe 600 1400 600 800 100
    sleep 7


    export PACKAGE="com.ss.android.ugc.trill"
}

function camera() {
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.GoogleCamera/com.android.camera.CameraLauncher 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "camera" >> ${pidlog}
    ps -ef | grep com.google.android.GoogleCamera/com.android.camera.CameraLauncher >> ${pidlog}


    sleep 3

    input tap 558 1760
    sleep 1

    input tap 849 1763  # front camera
    sleep 3

    input tap 558 1760  # take a photo
    sleep 1

    input tap 254 1760  # gallery
    sleep 1

    input swipe 508 842 508 1508 100
    sleep 3

    input tap 864 2008
    sleep 1

    input tap 864 2008
    sleep 1

    input tap 633 2181
    sleep 1

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

    export PACKAGE="com.google.android.GoogleCamera"
}

function gmail() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.google.android.gm/.ConversationListActivityGmail 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "gmail" >> ${pidlog}
    ps -ef | grep com.google.android.gm/.ConversationListActivityGmail >> ${pidlog}


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
    export PACKAGE="com.google.android.gm"
}

function angrybird() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.rovio.baba/com.unity3d.player.UnityPlayerActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "angrybird" >> ${pidlog}
    ps -ef | grep com.rovio.baba/com.unity3d.player.UnityPlayerActivity >> ${pidlog}


    sleep 30

    input tap 2200 120 
    sleep 5

    input tap 1200 900 
    sleep 10

    input swipe 800 500 1200 500 500
    sleep 5

    input swipe 800 500 1200 500 500
    sleep 5

    input tap 300 75
    sleep 3

    input tap 300 375
    sleep 3

    input tap 300 970
    sleep 3
    
    export PACKAGE="com.rovio.baba"
}

function candycrush() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.king.candycrushsaga/.CandyCrushSagaActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "candycrush" >> ${pidlog}
    ps -ef | grep com.king.candycrushsaga/.CandyCrushSagaActivity >> ${pidlog}


    sleep 10

    input tap 520 2050
    sleep 5

    input tap 450 1850 
    sleep 5

    input tap 520 1350 
    sleep 5

    input tap 520 1350 
    sleep 10

    input tap 600 2300
    sleep 5

    input tap 80 2300
    sleep 3

    input tap 550 1500 
    sleep 3

    input tap 550 1450
    sleep 3

    input tap 1000 360
    sleep 10
    
    
    export PACKAGE="com.king.candycrushsaga"
}

function nytimes() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.nytimes.android/.MainActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "nytimes" >> ${pidlog}
    ps -ef | grep com.nytimes.android/.MainActivity >> ${pidlog}


    sleep 10

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5
    
    
    export PACKAGE="com.nytimes.android"
}

function quora() {
    #monkey -p com.google.android.gm -v 1
    cat /proc/vmstat >> ${vmlog}
    am start -W -n com.quora.android/.components.activities.LauncherActivity 2>&1 | tee -a "${amlog}"
    cat /proc/vmstat >> ${vmlog}

    echo "quora" >> ${pidlog}
    ps -ef | grep com.quora.android/.components.activities.LauncherActivity >> ${pidlog}


    sleep 10

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5

    input swipe 600 1400 600 800 200
    sleep 5
    
    export PACKAGE="com.nytimes.android"
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

function force_stop() {
    am force-stop com.android.chrome
    am force-stop com.google.android.youtube
    am force-stop com.ss.android.ugc.trill
    am force-stop com.reddit.frontpage
    am force-stop com.facebook.katana
    am force-stop com.twitter.android
    am force-stop com.quora.android
    am force-stop com.google.android.gm
    am force-stop com.google.android.apps.maps
    am force-stop com.rovio.baba
    am force-stop com.king.candycrushsaga
    am force-stop com.google.android.GoogleCamera
    am force-stop com.snapchat.android
    am force-stop com.discord
    am force-stop com.amazon.mShop.android.shopping
    am force-stop com.alibaba.aliexpresshd 
    am force-stop com.google.android.apps.youtube.music
    am force-stop com.pinterest
    am force-stop com.nytimes.android
}


function file_seq() {
    for i in $(seq 0 6)
    do
        am start -W -n com.google.android.youtube/com.google.android.apps.youtube.app.watchwhile.WatchWhileActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.reddit.frontpage/launcher.default 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.facebook.katana/.LoginActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.twitter.android/.StartActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.google.android.gm/.ConversationListActivityGmail 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.google.android.apps.maps/com.google.android.maps.MapsActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.ss.android.ugc.trill/com.ss.android.ugc.aweme.splash.SplashActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.snapchat.android/.LandingPageActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.discord/.main.MainDefault 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.amazon.mShop.android.shopping/com.amazon.mShop.home.HomeActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.alibaba.aliexpresshd/com.aliexpress.app.FirstActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.king.candycrushsaga/.CandyCrushSagaActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.rovio.baba/com.unity3d.player.UnityPlayerActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.google.android.apps.youtube.music/.activities.MusicActivity 2>&1 | tee -a "${amlog}"
        sleep 30
        am start -W -n com.pinterest/.activity.PinterestActivity 2>&1 | tee -a "${amlog}"
        sleep 30
    done
}

function anon_seq() {
    for i in $(seq 0 5)
    do
        chrome_anon
        tiktok_anon
        facebook_anon
    done
}

function my_seq() {
    for i in $(seq 0 4)
    do
        facebook
        youtube
        chrome
        twitter
        nytimes
        angrybird
        reddit
        googlemap
        tiktok
        quora
    done
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

echo "DROP CACHE"
echo 3 > /proc/sys/vm/drop_caches

echo "FORCE STOP"
force_stop

echo "APP SEQ START"
file_seq
#anon_seq
#my_seq

echo "FORCE STOP"
force_stop

echo "TEST END!"

kill -9 ${swappiness_monitor_pid}
input keyevent KEYCODE_POWER
