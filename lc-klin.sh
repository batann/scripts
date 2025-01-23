#!/bin/bash
# vim:fileencoding=utf-8:foldmethod=marker
#author:	fairdinkum batan
#mail:		12982@tutanota.com
------------------------------------------------------------------------------------------------

#{{{###  clear command and ansi coloring
clear
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
Yellow='\033[1;33m'
White='\033[1;37m'
BBlue='\e[0;104m'
BBlack='\e[0;100m'
RRed='\e[0;100m'
GGreen='\e[0;100m'
YYellow='\e[0;100m'
BBlue='\e[0;100m'
PPurple='\e[0;100m'
CCyan='\e[0;100m'
WWhite='\e[0;100m'

#}}}
#{{{###


if [[ ! -d /home/batan/Scripts ]];
then
	mkdir /home/batan/Scripts
	fi

sudo trash .*.bak .*.org *.bak *.org .*.swp *.swp .*.pyc *.pyc .*.log *.log .*.part *.part .*.ytdl *.ytdl .*.tmp *.tmp *_ .*_ >/dev/null 2>&1
#mv *.mp4 /home/batan/Videos >/dev/null 2>&1
#mv *.mkv /home/batan/Videos >/dev/null 2>&1
#mv *.jpg /home/batan/Pictures >/dev/null 2>&1
#mv *.png /home/batan/Pictures >/dev/null 2>&1
#mv *.gif /home/batan/Pictures >/dev/null 2>&1
#mv *.jpeg /home/batan/Pictures >/dev/null 2>&1
#mv *.webm /home/batan/Videos >/dev/null 2>&1
#mv *.mp3 /home/batan/Music >/dev/null 2>&1
#mv *.sh /home/batan/Scripts >/dev/null 2>&1
#mv *.py /home/batan/Scripts >/dev/null 2>&1
#mv *.html /home/batan/Scripts >/dev/null 2>&1
#mv *.css /home/batan/Scripts >/dev/null 2>&1
#mv *.js /home/batan/Scripts >/dev/null 2>&1
#mv *.txt /home/batan/Documents >/dev/null 2>&1

for i in $(find ~ -maxdepth 1 -type f -exec file {} + | grep -E ':.*script' | cut -d: -f1);do mv $(echo $i|sed 's!\/home\/batan\/!!g') /home/batan/Scripts/$(( $(ls Scripts/|wc -l) + 1)).$(echo $i|sed 's!\/home\/batan\/!!g');done


# Define directories
MUSIC_DIR="$HOME/Music"
VIDEOS_DIR="$HOME/Videos"
DOCUMENTS_DIR="$HOME/Documents"

# Ensure target directories exist
mkdir -p "$MUSIC_DIR" "$VIDEOS_DIR" "$DOCUMENTS_DIR"

# Function to move and prefix files
move_and_prefix() {
    local target_dir=$1  # Target directory
    local file_type=$2   # File extension or MIME type
    local prefix_count=$(ls -1q "$target_dir" | wc -l) # Count existing files

    # Find and process files
    find "$HOME" -maxdepth 1 -type f -iname "*.$file_type" | while read -r file; do
        prefix_count=$((prefix_count + 1))  # Increment the counter
        base_name=$(basename "$file")      # Extract the base name of the file
        mv "$file" "$target_dir/${prefix_count}_$base_name" # Move and rename
    done
}

# Move MP3 files to Music
move_and_prefix "$MUSIC_DIR" "mp3"

# Move MP4 files to Videos
move_and_prefix "$VIDEOS_DIR" "mp4"

# Move TXT files to Documents
move_and_prefix "$DOCUMENTS_DIR" "txt"

DIR_MUSIC="/home/batan/Music"
DIR_VIDEOS="/home/batan/Videos"

 rename 's/ /_/g' $DIR_MUSIC/*
 rename 's/ /_/g' $DIR_VIDEOS/*
 rename 's/\,//g' $DIR_MUSIC/*
 rename 's/\[.*\]//g' $DIR_MUSIC/*
 rename 's/\(.*\)//g' $DIR_MUSIC/*
 rename 's/\-//g' $DIR_MUSIC/*
 rename 's/\$//g' $DIR_MUSIC/*
 rename 's/\&//g' $DIR_MUSIC/*
 rename 's/\,//g' $DIR_VIDEOS/*
 rename 's/\[.*\]//g' $DIR_VIDEOS/*
 rename 's/\(.*\)//g' $DIR_VIDEOS/*
 rename 's/\-//g' $DIR_VIDEOS/*
 rename 's/\$//g' $DIR_VIDEOS/*
 rename 's/_\./\./g' $DIR_MUSIC/*
 rename 's/_\./\./g' $DIR_MUSIC/*
 rename 's/_\./\./g' $DIR_VIDEOS/*
 rename 's/_\./\./g' $DIR_VIDEOS/*
#}}}





#}}}




