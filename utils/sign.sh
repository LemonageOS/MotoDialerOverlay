#!/bin/sh

BOLD="\e[1m"
RED="\e[91m"
GREEN="\e[92m"
END="\e[0m"

TERMUX="/data/data/com.termux"
APKSIGNER="$TERMUX/files/usr/bin/apksigner"

ETC="/data/data/com.termux/files/usr/etc"
BASHRC="$ETC/bash.bashrc"

ALIASFILE="$HOME/.lemonage_aliases"
INTERNAL_STORAGE="$HOME/storage/shared"
REPO="$INTERNAL_STORAGE/MotoDialerOverlay"
KEYSTORE="$REPO/keystore"
APK="$REPO/src/MotoDialerOverlay.apk"

KEY="\nMotoDialerOverlay > keystore > key.p8"
CERT="\nMotoDialerOverlay > keystore > cert.pem"

ERR_APK="No APK to sign"
ERR_APKSIGNER="apksigner is not available"
ERR_CERT="Cannot find certificate"
ERR_KEY="Cannot find private key"
ERR_LINES="The config file must contain exactly 3 lines"
ERR_TERMUX="Only Termux is supported at the moment"

MSG_CONTINUE="Type anything to continue"
MSG_SET_ALIAS="Please enter the alias to be used for signing the apk\nYou may press enter for the default alias (md) "
MSG_SUCCESS="\nThe overlay has been signed succesfully"
MSG_SIGN="\nEnter $ALIAS to sign the apk"

print_error() {
	printf "${BOLD}${RED}\nerror: ${1}${END}\n"
}

if [ ! -d $TERMUX ]; then
	print_error "$ERR_TERMUX"
	echo ""
	exit 1
fi

if [ ! -f $APKSIGNER ]; then
	print_error "$ERR_APKSIGNER"
	printf "Please install it using ${BOLD}pkg install apksigner${END}\n\n"
	exit 1
fi

if [ ! -f $APK ]; then
	print_error "$ERR_APK"
	printf "Please build it using ${BOLD}apktool M${END}\n\n"
	exit 1
fi

if [ ! -f $KEYSTORE/key.p8 ]; then
	print_error "$ERR_KEY"
	printf "Please import it to ${BOLD}${KEY}${END}\n\n"
	exit 1
fi

if [ ! -f $KEYSTORE/cert.pem ]; then
	print_error "$ERR_CERT"
	printf "Please import it to ${BOLD}${CERT}${END}\n\n"
	exit 1
fi

cd $KEYSTORE
apksigner sign --key key.p8 --cert cert.pem $APK
printf "\n${GREEN}The overlay has been signed successfully${END}\n\n"
