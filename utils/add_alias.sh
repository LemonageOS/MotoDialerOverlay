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

printf "\n${MSG_SET}${BOLD} all_in_one.sh ${END}\n${MSG_DEFAULT} (so)\n"
read a
if [ -z $a ]; then
    a="so"
fi
echo "alias $a='bash $REPO/utils/all_in_one.sh'" > $ALIASFILE

printf "\n${MSG_RELOAD}${BOLD}\nsource ~/../usr/etc/bash.bashrc${END}\n"
