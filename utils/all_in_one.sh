#!/bin/bash

BOLD="\e[1m"
RED="\e[91m"
GREEN="\e[92m"
END="\e[0m"

TERMUX="/data/data/com.termux"
APKTOOL="$TERMUX/files/usr/bin/apktool"

INTERNAL_STORAGE="$HOME/storage/shared"
REPO="$INTERNAL_STORAGE/MotoDialerOverlay"
SRC="$REPO/src"

ACTIVITY_APKTOOL_M="ru.maximoff.apktool/ru.maximoff.apktool.SplashActivity"
ACTIVITY_MOTODIALER="com.android.dialer/com.android.dialer.main.impl.MainActivity"
ACTIVITY_TERMUX="com.termux/com.termux.app.TermuxActivity"

APK="MotoDialerOverlay.apk"
PACKAGE_MOTODIALER="com.lemonage.mdoverlay"
PACKAGE_OVERLAY="com.lemonage.mdoverlay"

ERR_APKTOOL="Apktool is not available"
ERR_ROOT="Termux must be granted root access to run this script"
ERR_SRC="The MotoDialerOverlay source cannot be found"

STEP_CLEANUP="[1/7] Cleaning up..."
STEP_DISABLE="[2/7] Disabling the overlay..."
STEP_BUILD="[3/7] Building the overlay..."
STEP_SIGN="[4/7] Signing the overlay..."
STEP_INSTALL="[5/7] Installing the overlay..."
STEP_ENABLE="[6/7] Enabling the overlay..."
STEP_LAUNCH="[6/7] Launching Moto Dialer..."

print_error() {
	printf "${BOLD}${RED}\nerror: ${1}${END}\n\n"
}

print_step() {
	printf "\n${BOLD}${GREEN}${1}${END}\n"
}

clear

if ! su -c exit &> /dev/null; then
    print_error "$ERR_ROOT"
    exit 1
fi

if [ ! -d $SRC ]; then
	print_error "$ERR_SRC"
	exit 1
fi

if [ ! -f $APKTOOL ]; then
	print_error "$ERR_APKTOOL"
	printf "copy paste the command below to install it\n${BOLD}curl -s https://raw.githubusercontent.com/rendiix/termux-apktool/main/install.sh | bash${END}\n"
	exit 1
fi

cd $SRC
print_step "$STEP_CLEANUP"
rm *.apk *.idsig 2> /dev/null

print_step "$STEP_DISABLE"
su -c cmd overlay disable "$PACKAGE_OVERLAY"

print_step "$STEP_BUILD"
su -c am start -n $ACTIVITY_APKTOOL_M
while [ ! -f "$SRC/$APK" ]; do
    sleep 0.1
done

su -c am start -n $ACTIVITY_TERMUX
cd $REPO
print_step "$STEP_SIGN"
bash utils/sign.sh

print_step "$STEP_INSTALL"
cp $SRC/$APK /data/local/tmp/
su -c pm install /data/local/tmp/$APK 1>/dev/null

print_step "$STEP_ENABLE"
su -c cmd overlay enable "$PACKAGE_OVERLAY"

print_step "$STEP_LAUNCH"
su -c am start -n $ACTIVITY_MOTODIALER
