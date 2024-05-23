#!/system/bin/sh

source drop_cache.sh
source init_zram.sh
source start_applications.sh
source kill_applications.sh
source mimic_user_patterns.sh

log_dir="/sdcard/wjdoh/user_patterns_dir"
DATE="$(date +%m%d%H%M)"
log_dir+="/${DATE}"

mkdir -p ${log_dir}
amlog=${log_dir}/am.log
vmlog=${log_dir}/vm.log


W1=(
    youtube
    maps
    angrybirds
    reddit
    tiktok
    quora
    nytimes
    gmail
    candycrush
    camera
)

package=(
    com.google.android.youtube
    com.google.android.apps.maps
    com.rovio.baba
    com.reddit.frontpage
    com.ss.android.ugc.trill
    com.quora.android
    com.nytimes.android
    com.google.android.gm
    com.king.candycrushsaga
    com.google.android.GoogleCamera
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
while [ ${temp} -gt 300 ]
do
    sleep 60
    temp=$(dumpsys battery | grep tem | awk '{print $2}')
done

echo "Temperature: ${temp}" 2>&1 | tee -a "${log_dir}/temperature.txt"

for app in $(seq 0 9)
do
    for app_num in $(/data/local/random_array 10)
    do
        dumpsys meminfo ${package[${app_num}]} >> ${log_dir}/${W1[${app_num}]}_meminfo.txt
        start_${W1[${app_num}]} 2>&1 | tee -a ${amlog}
        dumpsys meminfo ${package[${app_num}]} >> ${log_dir}/${W1[${app_num}]}_meminfo.txt
        user_${W1[${app_num}]}
        sleep 3
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
