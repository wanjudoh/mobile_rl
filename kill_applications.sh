#!/system/bin/sh

function kill_whatsapp() {
    am force-stop com.whatsapp
}
function kill_snapchat() {
    am force-stop com.snapchat.android
}
function kill_discord() {
    am force-stop com.discord
}
function kill_telegram() {
    am force-stop org.telegram.messenger
}
function kill_chrome() {
    am force-stop com.android.chrome
}
function kill_gmail() {
    am force-stop com.google.android.gm
}
function kill_facebook() {
    am force-stop com.facebook.katana
}
function kill_instagram() {
    am force-stop com.instagram.android
}
function kill_tiktok() {
    am force-stop com.ss.android.ugc.trill
}
function kill_twitter() {
    am force-stop com.twitter.android
}
function kill_reddit() {
    am force-stop com.reddit.frontpage
}
function kill_youtube() {
    am force-stop com.google.android.youtube
}
function kill_amazon() {
    am force-stop com.amazon.mShop.android.shopping
}
function kill_aliexpress() {
    am force-stop com.alibaba.aliexpresshd
}
function kill_temu() {
    am force-stop com.einnovation.temu
}
function kill_maps() {
    am force-stop com.google.android.apps.maps
}
function kill_airbnb() {
    am force-stop com.airbnb.android
}
function kill_google_photo() {
    am force-stop com.google.android.apps.photos
}
function kill_calendar() {
    am force-stop com.google.android.calendar
}
function kill_outlook() {
    am force-stop com.microsoft.office.outlook
}
function kill_google_drive() {
    am force-stop com.google.android.apps.docs
}
function kill_paypal() {
    am force-stop com.paypal.android.p2pmobile
}
function kill_spotify() {
    am force-stop com.spotify.music
}
function kill_pinterest() {
    am force-stop com.pinterest
}
function kill_angrybirds() {
    am force-stop com.rovio.baba
}
function kill_candycrush() {
    am force-stop com.king.candycrushsaga
}
function kill_cookierun() {
    am force-stop com.devsisters.ck
}
function kill_nike() {
    am force-stop com.nike.omega
}
function kill_booking() {
    am force-stop com.booking
}
function kill_quora() {
    am force-stop com.quora.android
}
function kill_pokemon() {
    am force-stop com.nianticlabs.pokemongo
}
function kill_nytimes() {
    am force-stop com.nytimes.android
}
function kill_camera() {
    am force-stop com.google.android.GoogleCamera
}

function force_stop() {
    kill_whatsapp
    kill_snapchat
    kill_discord
    kill_telegram
    kill_chrome
    kill_gmail
    kill_facebook
    kill_instagram
    kill_tiktok
    kill_twitter
    kill_reddit
    kill_youtube
    kill_amazon
    kill_aliexpress
    kill_temu
    kill_maps
    kill_airbnb
    kill_google_photo
    kill_calendar
    kill_outlook
    kill_google_drive
    kill_paypal
    kill_spotify
    kill_pinterest
    kill_angrybirds
    kill_candycrush
    kill_cookierun
    kill_nike
    kill_booking
    kill_quora
    kill_pokemon
    kill_nytimes
    kill_camera
}
