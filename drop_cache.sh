#!/system/bin/sh

function drop_cache() {
    echo "DROP CACHE"
    echo 3 > /proc/sys/vm/drop_caches
    sleep 2
}
