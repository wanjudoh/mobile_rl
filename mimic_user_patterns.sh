#!/system/bin/sh

function user_chrome() {
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
}

function user_chrome_long() {
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
}

function user_youtube() {
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
}

function user_reddit() {
    for iter in $(seq 0 5)
    do
        input swipe 600 1400 600 800 100
        sleep 10
    done
}

function user_facebook() {
    for iter in $(seq 0 5)
    do
        input swipe 600 1400 600 800 100
        sleep 10
    done
}

function user_facebook_long() {
    for iter in $(seq 0 20)
    do
        input swipe 600 1400 600 800 100
        sleep 5
    done
}

function user_twitter() {
    for iter in $(seq 0 5)
    do
        input swipe 600 1400 600 800 100
        sleep 10
    done
}

function user_twitter_long() {
    for iter in $(seq 0 20)
    do
        input swipe 600 1400 600 800 100
        sleep 5
    done
}

function user_maps() {
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
}

function user_tiktok() {
    for iter in $(seq 0 5)
    do
        input swipe 600 1400 600 800 100
        sleep 10
    done
}

function user_tiktok_long() {
    for iter in $(seq 0 20)
    do
        input swipe 600 1400 600 800 100
        sleep 5
    done
}

function user_gmail() {
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
}

function user_camera() {
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
}

function user_angrybirds() {
    sleep 20

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
}

function user_candycrush() {
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
}

function user_nytimes() {
    for iter in $(seq 0 11)
    do
        input swipe 600 1400 600 800 200
        sleep 5
    done
}

function user_quora() {
    for iter in $(seq 0 11)
    do
        input swipe 600 1400 600 800 200
        sleep 5
    done
}


