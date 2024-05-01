#!/bin/sh

BOLD="\e[1m"
YELLOW="\e[33m"
END="\e[0m"

ALIASFILE="$HOME/.lemonage_aliases"
REPO="$HOME/storage/shared/MotoDialerOverlay"

ETC="/data/data/com.termux/files/usr/etc"
BASHRC="$ETC/bash.bashrc"

MSG_ABORT="Aborting..."
MSG_CONTINUE="Would you like to continue (y/n)?"
MSG_SET="Please enter the alias to be used for"
MSG_DEFAULT="You may press enter for the default alias"
MSG_RELOAD="Please reload the bashrc manually using"

if [[ ! $(grep "lemonage_aliases" $ETC/bash.bashrc) ]]; then
	cat $REPO/utils/bashrc_addition >> $BASHRC
fi

if [ -f $ALIASFILE ]; then
    printf "${BOLD}${YELLOW}.lemonage_aliases already exists in your home directory. This script will recreate said file.${END}\n"
    echo $MSG_CONTINUE

    read ch
    if [ $ch != "y" ]; then
        echo -e "\n$MSG_ABORT"
        exit 0
    fi
fi

printf "\n${MSG_SET}${BOLD} signing the overlay${END}\n${MSG_DEFAULT} (so)\n"
read a
if [ -z $a ]; then
    a="so"
fi
echo "alias $a='bash $REPO/utils/sign.sh'" > $ALIASFILE

printf "\n${MSG_RELOAD}${BOLD}\nsource ~/../usr/etc/bash.bashrc${END}\n"
