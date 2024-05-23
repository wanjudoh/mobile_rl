#!/system/bin/sh

source drop_cache.sh
source init_zram.sh
source start_applications.sh
source kill_applications.sh

log_dir="/sdcard/wjdoh/app_cycle_test_dir"
DATE="$(date +%m%d%H%M)"
log_dir+="/${DATE}"

mkdir -p ${log_dir}
amlog=${log_dir}/am.log
vmlog=${log_dir}/vm.log

WORKLOAD=$1

W1=(
    pinterest
    temu
    google_drive
    reddit
    gmail
    tiktok
    aliexpress
    twitter
    facebook
    nytimes
    paypal
    camera
    discord
    airbnb
    maps
    angrybirds
    quora
    candycrush
    google_photo
    instagram
)

W2=(
    aliexpress
    amazon
    tiktok
    quora
    snapchat
    pinterest
    chrome
    temu
    youtube
    twitter
    google_photo
    nytimes
    pokemon
    reddit
    candycrush
    telegram
    maps
    discord
    airbnb
    paypal
)

W3=(
    camera
    google_photo
    outlook
    aliexpress
    chrome
    google_drive
    whatsapp
    facebook
    angrybirds
    instagram
    snapchat
    twitter
    pokemon
    quora
    reddit
    temu
    youtube
    telegram
    discord
    candycrush
)

W4=(
    discord
    twitter
    paypal
    temu
    snapchat
    chrome
    instagram
    telegram
    reddit
    amazon
    quora
    aliexpress
    airbnb
    youtube
    angrybirds
    tiktok
    facebook
    pokemon
    pinterest
    google_photo
)

W5=(
    tiktok
    chrome
    quora
    candycrush
    snapchat
    youtube
    pokemon
    twitter
    temu
    telegram
    google_drive
    camera
    angrybirds
    discord
    airbnb
    paypal
    facebook
    amazon
    google_photo
    reddit
)

echo "TEST START!"

echo "FORCE STOP"
force_stop
sleep 5

echo "DROP CACHE"
echo 3 > /proc/sys/vm/drop_caches
sleep 5

echo "INIT ZRAM"
init_zram
sleep 5

logcat | grep Kill > ${log_dir}/killer.txt &
date +%s >> ${log_dir}/date.txt

input keyevent KEYCODE_WAKEUP
sleep 3
input keyevent KEYCODE_MENU
input keyevent KEYCODE_MENU
sleep 3

echo "START" > ${log_dir}/killer.txt
cat /proc/vmstat >> ${log_dir}/vmstat_begin_end.txt
temp=$(dumpsys battery | grep tem | awk '{print $2}')
echo "Temperature: ${temp}" 2>&1 | tee -a "${log_dir}/temperature.txt"

for app in $(seq 0 9)
do
    for app_num in $(/data/local/random_array 20)
    do
        if [ ${WORKLOAD} -eq 1 ]; then
            start_${W1[${app_num}]} 2>&1 | tee -a ${amlog}
        elif [ ${WORKLOAD} -eq 2 ]; then
            start_${W2[${app_num}]} 2>&1 | tee -a ${amlog}
        elif [ ${WORKLOAD} -eq 3 ]; then
            start_${W3[${app_num}]} 2>&1 | tee -a ${amlog}
        elif [ ${WORKLOAD} -eq 4 ]; then
            start_${W4[${app_num}]} 2>&1 | tee -a ${amlog}
        elif [ ${WORKLOAD} -eq 5 ]; then
            start_${W5[${app_num}]} 2>&1 | tee -a ${amlog}
        fi
        cat /proc/vmstat >> ${vmlog}
        sleep 10
    done
done

input keyevent KEYCODE_SLEEP

cat /proc/vmstat >> ${log_dir}/vmstat_begin_end.txt
kill %1

date +%s >> ${log_dir}/date.txt
dumpsys meminfo > ${log_dir}/dumpsys_meminfo_end.txt

temp=$(dumpsys battery | grep tem | awk '{print $2}')
echo "Temperature: ${temp}" 2>&1 | tee -a "${log_dir}/temperature.txt"

echo "FORCE STOP"
force_stop

echo "TEST END!"
input keyevent KEYCODE_SLEEP
