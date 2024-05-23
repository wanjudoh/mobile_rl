#!/system/bin/sh

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

