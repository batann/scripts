# vim:fileencoding=utf-8:foldmethod=marker


#{{{ >>> Script Display and variables
#!/bin/bash

# ANSI Colors
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
Yellow='\033[1;33m'
White='\033[1;37m'
NC='\033[0m'
a="\033[37m|\033[0m"
# Initialize individual answer variables (aa1-aa30)
for i in {1..30}; do
    declare "aa$i=0"
done

# Questions and their answers (0 = No, 1 = Yes)
QUESTIONS=(
	"| 01) |dot file |      |bashrc           |"
	"| 02) |dot file |      |bashrc.aliases   |"
	"| 03) |dot file |      |bashrc.navigation|"
	"| 04) |dot file |      |bashrc.batan     |"
	"| 05) |dot file |      |bashrc.finish    |"
	"| 06) |dot file |      |bashrc.FIRST.LC  |"
	"| 07) |dot file |      |bash_profile     |"
	"| 08) |dot file |      |vimrc            |"
	"| 09) |dot file |      |taskrc           |"
	"| 10) |dot file |      |tmux.conf        |"
	"| 11) |dot file |      |megarc           |"
	"| 12) |dot file |      |lc-cd            |"
	"| 13) |dot file |      |Xauthority       |"
	"| 14) |dot file |      |Xdefaults        |"
	"| 15) |dot file |      |Xresources       |"
	"| 16) |dot file |      |inputrc          |"
	"| 17) |dot file |      |lc-sign          |"
	"| 18) |dot file |      |xboardrc         |"
	"| 19) |dot file |      |tkremind         |"
	"| 20) |dot file |      |reminder.md      |"
	"| 21) |dot file |      |xinitrc          |"
	"| 22) |dot file |      |music.kdl        |"
	"| 23) |dot file |      |rainbow_oauth    |"
	"| 24) |dot file |      |bookmarks014.html|"
	"| 25) |dot file |      |                 |"
	"|----------------SCRIPTS-----------------|"
	"| 26) | script  |      |lc-install       |"
	"| 27) | script  |      |lc-2-install     |"
	"| 28) | script  |      |lc-bookmarks     |"
	"| 29) | script  |      |fin.2.sh         |"
)

#}}}


#{{{ >>> Script Continuation
ANSWERS=(0 0 0 0)  # Default all answers to No
NUM_QUESTIONS=${#QUESTIONS[@]}
selected=0  # Current selected row (-1 for Cancel, NUM_QUESTIONS for Accept)

# Function to display the radio menu
DISPLAY_MENU() {
    clear

    # Display Cancel option
    if [[ $selected -eq -1 ]]; then
        echo -e "${White}${Blue}[ Cancel ]${NC}"
    else
        echo -e "  Cancel  "
    fi
	echo -e "  \033[37m+\033[32m----------------------------------------\033[37m+\033[0m"

   echo -e "  \033[37m|          \033[34mConfiguration Files           \033[37m|\033[0m"

	echo -e "  \033[37m+\033[32m----------------------------------------\033[37m+\033[0m"
    # Display questions and their Yes/No options
    for ((i=0; i<NUM_QUESTIONS; i++)); do
        if [[ $selected -eq $i ]]; then
            echo -ne "${White}${Blue}>"
        else
            echo -ne " "
        fi

        echo -ne " ${QUESTIONS[i]}"

        # Move cursor to position 40
        printf "%*s" $((40 - ${#QUESTIONS[i]})) ""

        if [[ ${ANSWERS[i]} -eq 1 ]]; then
            echo -e "[${Green}Yes${NC}] / No "
        else
            echo -e "Yes / [${Red}No${NC}] "
        fi
    done

	echo -e "  \033[37m+\033[32m----------------------------------------\033[37m+\033[0m"

    # Display Accept option
    if [[ $selected -eq $NUM_QUESTIONS ]]; then
        echo -e "${White}${Blue}[ Accept and Continue ]${NC}"
    else
        echo -e "  Accept and Continue  "
    fi
}

# Main loop
while true; do
    DISPLAY_MENU

    read -sn1 key

    if [[ $key == $'\e' ]]; then
        read -sn1 key
        if [[ $key == '[' ]]; then
            read -sn1 key
            case $key in
                'A') # Up arrow
                    ((selected--))
                    if [[ $selected -lt -1 ]]; then
                        selected=$NUM_QUESTIONS
                    fi
                    ;;
                'B') # Down arrow
                    ((selected++))
                    if [[ $selected -gt $NUM_QUESTIONS ]]; then
                        selected=-1
                    fi
                    ;;
                'C') # Right arrow
                    if [[ $selected -ge 0 && $selected -lt NUM_QUESTIONS ]]; then
                        ANSWERS[selected]=1
                    fi
                    ;;
                'D') # Left arrow
                    if [[ $selected -ge 0 && $selected -lt NUM_QUESTIONS ]]; then
                        ANSWERS[selected]=0
                    fi
                    ;;
            esac
        fi
    elif [[ $key == '' ]]; then  # Enter key
        if [[ $selected -eq -1 ]]; then
            echo "Operation cancelled."
            exit 1
        elif [[ $selected -eq $NUM_QUESTIONS ]]; then
            clear
            echo "Selected answers:"
            for ((i=0; i<NUM_QUESTIONS; i++)); do
                echo "${QUESTIONS[i]}: ${ANSWERS[i]}"
                # Update individual variables
                declare "aa$((i+1))=${ANSWERS[i]}"
            done
            break
        fi
    fi
done
#}}}




if [[ $aa1 -eq 1 ]]; then
#{{{ >>>   .bashrc
cat<<EOL> .bashrc
#{{{ >>> .bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'
ttt=$(wmctrl -l|grep Terminal|tail -n1)

if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
    PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='lc'
alias ld='ls -d */'




# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h:$ttt \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Created by `pipx` on 2023-10-08 03:59:30
export PATH="$PATH:/home/batan/.local/bin"
source /home/batan/.bashrc.aliases
source /home/batan/.bashrc.navigation

alias ssb='sudo bash'
ddd=$(date +%j)
PROMPT_COMMAND="history |tail -n1 >> /home/batan/commands.txt"
export GUIX_PROFILE="/var/guix/profiles/per-user/$USER/current-guix"
export PATH="$GUIX_PROFILE/bin:$PATH"
export INFOPATH="$GUIX_PROFILE/share/info:$INFOPATH"
export MANPATH="$GUIX_PROFILE/share/man:$MANPATH"
#}}}
EOL

#}}}
fi
if [[ $aa2 -eq 1 ]]; then
#{{{ >>>   .bashrc.aliases
cat<<EOL> .bashrc.aliases
#{{{ >>> .bashrc.aliases
# vim:fileencoding=utf-8:foldmethod=marker
alias xf="xfce4-terminal"

#   ANSI CODE   ##################################################################
alias oo="clear && read -p ' pane >>>  ' abc && clear && read -p 'command >>>   ' bce && tmux send-keys -t$abc $bce  Enter"
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
Yellow='\033[1;33m'
White='\033[1;37m'
#   ANSI CODE BACKGROUND  ##################################################################
BBlue='\e[0;104m'
BBlack='\e[0;100m'
RRed='\e[0;100m'
GGreen='\e[0;100m'
YYellow='\e[0;100m'
BBlue='\e[0;100m'
PPurple='\e[0;100m'
CCyan='\e[0;100m'
WWhite='\e[0;100m'
NC='\033[0m'

### PS1   ##################################################################################
ttt=$(wmctrl -l|grep Terminal|tail -n1|cut -c 1-10)
echo -e "${Cyan}$ttt"
ttime=$(date +%H:%M)
#echo -e "ââââââââââââââââââââââââââââââââââââââââ"
#echo -e "ââââââââââââââââ   âââââââââââââââââââââ"
#echo -e "ââââââââââââââ       âââââââââââââââââââ"
#echo -e "âââââââââââââ       âââ  âââââââââââââââ"
#echo -e "ââââââââââââââ     ââ       ââââââââââââ"
#echo -e "âââââââââ     âââââââ      âââââââââââââ"
#echo -e "ââââââââ           ââââ   ââ    ââââââââ"
#echo -e "âââââââ               âââââ      âââââââ"
#echo -e "âââââ        â        âââ       ââ  ââââ"
#echo -e "ââââ         âââââââââââ      ââ      ââ"
#echo -e "âââ          ââââââ âââ     ââ      ââââ"
#echo -e "âââ              ââââââââââââ     ââââââ"
#echo -e "âââââ             ââ       ââ   ââ âââââ"
#echo -e "âââââââ             â        âââ   âââââ"
#echo -e "ââââââââ             ââ            âââââ"
#echo -e "ââââââââââ            ââ          ââââââ"
#echo -e "âââââââââââââ          ââ        âââââââ"
#echo -e "ââââââââââââââ        âââââ    âââââââââ"
#echo -e "âââââââââââââââ         â     ââââââââââ"
#echo -e "ââââââââââââââ                ââââââââââ"
#echo -e "ââââââââââââââ                ââââââââââ"
#echo -e "ââââââââââââââ                ââââââââââ"
#echo -e "âââââââââââââ                 ââââââââââ"
#echo -e "âââââââââââââ                  âââââââââ"
#echo -e "ââââââââââââ                   âââââââââ"
#echo -e "ââââââââââââââââââââââââââââââââââââââââ"
#echo -e "        ${WWhite}Power to the people!!!${NC}"
##############################################################################
#neofetch --source ~/.ansi --gap 2 --bg_color= blue --corp_mode fit --bar --music_player /usr/bin/mpv snooppp.mp3 --bar_border on
ddd=$(date +%j)
alias chit="clear && read -p '   >>>   ' abc && curl https://cheat.sh/$abc"
############################################################################
alias c='clear'
alias rca='source /home/batan/.bashrc.alieses'
alias rrc='source /home/batan/.bashrc'



############################################################################
#   NAVIGATION   ###########################################################
############################################################################
alias cc="cd .. && clear && ls -a && echo -e '\033[34m=========================================\033[0m'"
alias github='cd /media/batan/100/github/ && clear && sudo -u batan bash /home/batan/10/menu/scripts/ls.sh'
alias vimwiki="cd /home/batan/10/vimwiki/ && clear && sudo -u batan bash /home/batan/10/menu/scripts/ls.sh"
alias music='cd ~/Music && clear && sudo -u batan bash $HOME/10/menu/scripts/ls.sh'
alias homepage='cd $HOME/10/html/homepage/ && sudo -u batan bash $HOME/10/menu/scripts/ls.sh'
alias scripts='cd $HOME/10/menue/scripts/ && sudo -u batan bash $HOME/10/menu/scripts/ls.sh'
alias menu='cd /home/batan/10/menu/ && sudo -u batan bash /home/batan/10/menu/scripts/ls.sh'
alias postinstall='cd /home/batan/10/postinstall/ && sudo -u batan bash /home/batan/10/menu/scripts/ls.sh'
alias 10='cd /home/batan/10/ && sudo -u batan bash /home/batan/10/menu/scripts/ld.sh'
alias 11='cd /home/batan/11/ && ls -d */'
alias 12='cd /home/batan/12/ && ls -d */'
alias 100='cd /media/batan/100/ && clear && sudo -u batan bash /home/batan/10/menu/scripts/ld.sh && ls'
alias check='cd check && sudo -u batan bash /home/batan/10/menu/scripts/ls.sh'
alias downl='cd /home/batan/Downloads/ && clear && ls'
alias nstart='cd /home/batan/.config/nvim/pack/plugins/start/ && clear && sudo -u batan bash /home/batan/10/menu/scripts/ld.sh'
alias vstart='cd /home/batan/.vim/pack/plugins/start/ && clear && sudo -u batan bash /home/batan/10/menu/scripts/ld.sh'
alias Music='cd /home/batan/Music && clear && sudo -u batan bash /home/batan/10/menu/scripts/ld.sh'


#   modify existing files   ######################################################
alias xx='sudo chmod -x'
alias x="xclip -selec clip"
#   browser   ####################################################################
alias un='/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/chromium --file-forwarding io.github.ungoogled_software.ungoogled_chromium --js-flags='jitless' @@u %U @@'
alias fk='falkon'
#   tmux   #######################################################################
alias 1='tmux new-session \; split-window -h \; split-window -v -p 66 \; split-window -v\; attach\;'
alias 2='tmux new-session \; split-window -v \; split-window -h -p 66 \; split-window -h\; selectp -t1\; attach\;'
alias tk='tmux kill-session'
alias wo='terminator --geometry="1200x800+0+0 -b -e "tmux new-session 'vim' -c ':VimwikiIndex' \; split-window -h 'nvim' -c ':Calendar-view=days' \; split-window -v -p 20 'bwm-ng' \; attach\;"'
alias woo='tmux new-session 'vim' -c ':VimwikiIndex' \;split-window -v -p 30 'bpytop';\ split-window -h 'vit' \; split-window -v -p 20 'bwm-ng' \; attach\;'
alias 122='tmux new-session \; split-window -v \; split-window -h -p 33 \; selectp -t1\; attach \;'
alias tod='tmux new-session 'vim' -c ':Calendar=view-day' \; split-window -h 'nvim' -c ':TW' \; split-window -h -p 20 \; selectp -t 1\;'
alias sound='tmux new-session 'castero' \; split-window -v 'cmus' \; split-window -h -p 30 \; selectp -t 1\; attach \;'
##################################################################################
alias cu='sudo apt autoremove --purge && sudo apt autoclean && sudo apt clean && youtube-dl --rm-cache-dir && sudo sweeper --automatic && sudo bleachbit --preset -c'
alias cuu='sudo apt autoremove --purge && sudo apt autoclean && sudo apt clean && sudo sweeper --automatic && yt-dlp --rm-cache-dir && sudo bleachbit --preset -c && sudo bash cache.sh && mkdir /home/batan/.cache/calendar.vim/ && cp /home/batan/dot/credentials.vim /home/batan/.cache/calendar.vim/credentials.vim'
alias p='echo "Ba7an?12982"| xclip -selection clipboard'
alias ipp='hostname -I && nmcli connection show && sudo ufw status'
#   mat2   ######################################################################
alias mt='mat2 *.mp3 && mkdir 1 && mv *.cleaned.mp3 1 && cd 1 && qmv -f do -e vim *mp3 -c :%s!.cleaned.mp3!!'
alias mkdir='mkdir -p'
alias xc='xclip -o|festival --tts'
alias xd='echo $(xclip -o -selection clipboard)'
####   ddgr   ######################################################################
alias dg='ddgr -w github.com -n 10'
alias dy='ddgr -w youtube.com -n 10'
alias dr='ddgr -w reddit.com -n10'
alias ds='ddgr -w plato.stanford.edu'
alias dp='ddgr -w pypi.org'
alias uu="xterm -geom 120x75+0+0 -e bash -c 'ddgr'"
alias gg="xterm -geom 120x75+0+0 -e bash -c 'googler'"
####   yt-dlp   ####################################################################
alias yt3="yt-dlp --config-locations /home/batan/.config/yt-dlp/yt-dlp.mp3.conf"
alias yt4="yt-dlp --config-locations /home/batan/.config/yt-dlp/yt-dlp.mp4.conf"
####   megatools   #################################################################
alias mg='megaget'
alias mp='megaput'
alias ml='megals'
alias mr='megarm'
alias mcc='megacopy'
alias mmkd='megamkdir'
#   taskwarrior   ###############################################################
alias ta='task add'
alias tl='task list'
alias td='task done'
alias tb='task burndown'
alias tdd='task delete'
alias tbd='task burndown.daily'
alias tll='task list project:'
alias by='task add +buy proj:buy'
alias taaa='task add due:$(date -d "2024-12-15 +2 days" +%Y-%m-%dT23:30:00)'
alias taa='task add due:$(date +%Y-%m-%d)T23:30:00 proj:$(date +%j)'
#   nodau   #####################################################################
alias nn='nodau new'
alias nd='nodau del'
alias nl='nodau list'
#   buku    ######################################################################
alias ba='buku -a'
alias bs='buku -s'
alias bd='buku -d'
alias bb='buku -a $(xclip -o)'
###########################################################################
alias sbb='sudo -u batan bash'
alias mn='sudo -u batan bash /home/batan/10/menu/scripts/mn.sh'
alias sb='sudo -u batan bash'
alias cdd='cd /media/batan/work/NEW/'
alias rf='rofi -show drun'
alias alia='vim .bashrc.aliases'
alias ali='vim .bashrc'
alias update='sudo apt update && sudo apt upgrade -y'
alias clean='sudo -u batan bash /home/batan/check/clean.sh'
alias nuke='sudo -u batan bash /home/batan/check/nuke.sh'
alias dia='sudo bash /home/batan/10/postinstall/dia.sh'
alias mov='mv *.mp3 /home/batan/Music & mv *.mp4 /home/batan/Videos/ & mv *.sh /home/batan/Sh & mv *.wiki /home/batan/Wiki & mv *.jpg /home/batan/Pictures'
alias e='exit'
alias dhtml='echo "file:///home/batan/10/html/homepage/d.html"| xclip -selection clipboard'
alias install='sudo apt install'
alias ttime='date +%H:%M'
alias mhs="sudo mv /etc/hosts /etc/hosts.bbak"
alias mhsb="sudo mv /etc/hosts.bbak /etc/hosts"
alias nala="sudo nala"
lc(){
	local dest_dir=$(cat /home/batan/.lc-cd| fzf )
	if [[ $dest_dir != '' ]];then
		cd "$dest_dir"
	clear
		echo -e "\033[32m=======================================\033[0m"
		ls
		echo -e "\033[32m=======================================\033[0m"
	fi
}
export -f lc > /dev/null
#{{{ >>> EXPORT FZF
export FZF_DEFAULT_OPTS="  --color=fg:#9FB1BC,fg+:#9FB1BC,bg:#2E5266,bg+:#2E5266\
  --color=hl:#1a7ada,hl+:#9ae6ff,info:#e0e000,marker:#3ee421 \
  --color=prompt:#1700af,spinner:#F4FFFD,pointer:#F4FFFD,header:#F4FFFD \
  --color=border:#F7B32B,preview-fg:#9fb1bc,preview-bg:#2e5266 \
  --color=preview-label:#00857a,label:#f7b32b,query:#d9d9d9 \
  --border='sharp' --preview-window=right,50%,'wrap' \
  --padding='2' --margin='4' --prompt='' --marker='->' \
  --pointer='>>' --separator='â' --scrollbar='â' --info='inline'"






#export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color=fg:#8D8C9C,fg+:#8E9492,bg:#2B2E33,bg+:#2B2E33
#  --color=hl:#8D8C9C,hl+:#8D8C9C,info:#c4c477,marker:#8E9492
#  --color=prompt:#8E9492,spinner:#8E9492,pointer:#8E9492,header:#44adad
#  --color=border:#B9B6A7,scrollbar:#44adad,label:#44adad
#  --color=query:#d9d9d9
#  --border="sharp" --border-label=" [[[ LC-Linux ]]] " --border-label-pos="0"
#  --padding="1" --margin="1" --prompt="->" --marker=">>"
#  --pointer="ââ" --separator='â'  --scrollbar="â" --layout="reverse"
#  --info=default'

#}}}



alias mega='surf https://mega.nz'
alias gut="xdotool type 'git clone https://github.com/batann/'"
alias warp="/opt/Warp/./Warp-x86_64.AppImage"
alias lc-install="nvim /media/batan/100/lc-install.sh"
alias lc-2-install="nvim /media/batan/100/lc-2-install.sh"
#{{{ Countdown function

countd(){
clear
tput civis
echo -e "Time Now              : $(date +%H:%M)"
echo -e "Time to Countdown too : "
tput cup 1 24
read -n2 dd
tput cup 1 24
echo -e "$dd:"
tput cup 1 27
read -n2 ee
tput cup 5 0
read -p "Command to execute:   >>>   " xxx


bb=$(date -d ${dd}:${ee} +%s)
aa=$(date +%s)
ff=$(( $bb - $aa ))
echo -e "\033[37m"
for i in $(seq -f "%06g" $ff -1 0);do tput cup 10 20 && echo $i && sleep 1;done
echo -e "\033[0m"
clear
echo -e "\033[33mExecuting \033[31m${xxx}\033[0m"
$xxx
}
#}}}
#{{{ Reminder
reminder(){
if [[ ! -d /home/batan/.config/reminder ]]; then
        mkdir -p /home/batan/.config/reminder
fi
vim /home/batan/.config/reminder/$(date +%j).rem
}
#}}}
#{{{ Download Video incl Quality
downloadmp4(){
	clear
	read -p "URL:   >>>   " abc
	clear
	options=$(yt-dlp -F $abc |grep -E "hls|mp4"|grep -vE "Checking"|awk '{print $1}'); select format in ${options[@]}; do yt-dlp --restrict-filenames -f $format $abc && break 1;done
}
#}}}
#{{{ Bookmark URL to Note
bookmark(){
	echo $1 $2 >> /home/batan/.config/reminder/bookmarks.md
}
alias bm='bookmark'
#}}}
#}}}
EOL

#}}}
fi
if [[ $aa3 -eq 1 ]]; then
#{{{ >>>   .bashrc.batan
cat<<EOL> .bashrc.batan
#{{{ >>> .bashrc.batan
PROMPT_COMMAND="echo"

FLAIR="â§"
BAR="â"
TL="â­â"
BL="â°â"
LB1="â¨"
RB1="â©"
LB2="â¦"
RB2="â§"
END="ââ¯â¶"
ATHOST="${TL}${LB2} ${FLAIR} $(task summary|head -n4|tail -n1) $(echo -e \033[36m<<<-->>>  \033[33mdate:\033[37m)$(date +%j)$(echo -e \033[31m ${FLAIR} ${RB2}"    # string top left
TIMELENGTH=24                                                        # timestamp length
OFFSET=$((${#ATHOST} + ${TIMELENGTH} + 1))

BLINK="\x1B[5m"
RED="\x1B[1;31m"
RESET="\x1B[0m"

if [[ "${UID}" -eq "0" ]]; then
  ATHOST=$(echo "${ATHOST}" | sed "s/${USER}/${BLINK}${RED}&${RESET}/; s/${HOSTNAME}/${RED}&${RESET}/" )
else
  ATHOST=$(echo "${ATHOST}" | sed "s/${HOSTNAME}/${RED}&${RESET}/" )
fi

PS1='${ATHOST}\[$(printf "%*s" $(($(tput cols)-${OFFSET})) "" | sed "s/ /${BAR}/g")${LB2}\[\e[1;30m\]\[\e[4m\] \D{%Y-%m-%d %T%P}\] \[\e[0m\]${RB2}\n${BL}${LB1} \[\e[1;34m\]\w\[\e[0m\] ${RB1}${END} '
#}}}
EOL

#}}}
fi
if [[ $aa4 -eq 1 ]]; then
#{{{ >>>   .bashrc.finish
cat<<EOL> .bashrc.finish
#{{{ >>> .bashrc.finish
PROMPT_COMMAND="echo"

FLAIR="â§"
BAR="â"
TL="â­â"
BL="â°â"
LB1="â¨"
RB1="â©"
LB2="â¦"
RB2="â§"
END="ââ¯â¶"
ATHOST="${TL}${LB2} ${FLAIR} $(task summary | head -n4 | tail -n1) $(echo -e "\033[36m<<<-->>>  \033[33mdate:\033[37m")$(date +%j)$(echo -e "\033[31m" ${FLAIR} ${RB2})"    # string top left
TIMELENGTH=24                                                        # timestamp length
OFFSET=$((${#ATHOST} + ${TIMELENGTH} + 1))

BLINK="\x1B[5m"
RED="\x1B[1;31m"
RESET="\x1B[0m"

if [[ "${UID}" -eq "0" ]]; then
  ATHOST=$(echo "${ATHOST}" | sed "s/${USER}/${BLINK}${RED}&${RESET}/; s/${HOSTNAME}/${RED}&${RESET}/")
else
  ATHOST=$(echo "${ATHOST}" | sed "s/${HOSTNAME}/${RED}&${RESET}/")
fi

PS1='${ATHOST}\[$(printf "%*s" $(($(tput cols)-${OFFSET})) "" | sed "s/ /${BAR}/g")${LB2}\[\e[1;30m\]\[\e[4m\] \D{%Y-%m-%d %T%P}\] \[\e[0m\]${RB2}\n${BL}${LB1} \[\e[1;34m\]\w\[\e[0m\] ${RB1}${END} '
#}}}
EOL

#}}}
fi
if [[ $aa5 -eq 1 ]]; then
#{{{ >>>   .BASHRC.FIRST.LC
cat<<EOL> .BASHRC.FIRST.LC
#{{{ >>> .BASHRC.FIRST.LC
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'
ttt=$(wmctrl -l|grep Terminal|tail -n1)
###   PM INTEGRATION   ################################################
if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
	PS1="$(tput cup 0 0)${nc}d: $BLUE$(date +%j)$nc t: $GREEN$(date +%H:%M)$BLUE\n\n$(task summary|head -n2|tail -n1)\n$nc$(task summary|head -n3|tail -n1)\n$YELLOW$(task summary|head -n4|tail -n1)\n$RED$(task summary|head -n5|tail -n1) \n$(task summary|head -n6|tail -n1)\n$nc$(task summary|head -n3|tail -n1) $YELLOW $(tput cup 9 0)>>> $nc "
	PROMPT_COMMAND='tput cup 9 0 ; tput el;'
fi
#######################################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='lc'
alias ld='ls -d */'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h:$ttt \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Created by `pipx` on 2023-10-08 03:59:30
export PATH="$PATH:/home/batan/.local/bin"
source /home/batan/.bashrc.aliases
alias ssb='sudo bash'
ddd=$(date +%j)
#}}}
EOL

#}}}
fi
if [[ $aa6 -eq 1 ]]; then
#{{{ >>>   .bash_profile
cat<<EOL> .bash_profile
#{{{ >>> .bash_profile
source ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

source /home/batan/.config/ghostty/shell-integration/bash/bash-preexec.sh



#}}}
EOL

#}}}
fi
if [[ $aa7 -eq 1 ]]; then
#{{{ >>>   .vimrc
cat<<EOL> .vimrc
#{{{ >>> .vimrc

"#{{{ >>>   Startup Page
fun! Start()
    " Exit conditions
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Create a new buffer and clear it
    enew
    call setline(1, []) " Clear content explicitly

    " Set buffer options
    setlocal bufhidden=wipe buftype=nofile nobuflisted nocursorcolumn nocursorline nolist nonumber noswapfile norelativenumber

    " Add Taskwarrior tasks
    call append('$', "### Current Tasks ###")
    let tasks = split(system('task'), '\n')
    for line in tasks
        call append('$', '  >>>          ' . line)
    endfor

    " Add a separator
    call append('$', '')
    call append('$', "### Recently Modified Files ###")

    " Get the five most recently modified files
    let files = split(system("find ~/ -maxdepth 1 -type f -printf '%T@ %p\n' | sort -n -r | head -n 5 | cut -d' ' -f2-"), '\n')
    let file_number = 1
    for file in files
        if file != ''
            call append('$', printf("  [%d] %s", file_number, file))
            let file_number += 1
        endif
    endfor

    " Add a note
    call append('$', '')
    call append('$', "### Press the file number to edit ###")

    " Make buffer read-only
    setlocal nomodifiable nomodified

    " Add mappings to open the files
    for i in range(1, len(files))
        let file = files[i - 1]
        exec printf("nnoremap <buffer><silent> %d :e %s<CR>", i, file)
    endfor

    " Add key mappings for creating a new buffer
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

augroup StartPage
    autocmd!
    autocmd VimEnter * call Start()
augroup END
"#}}}
"#{{{ >>>   LEADER MAPPINGS
let mapleader = ","
nnoremap <Leader>te :terminal<CR>
nnoremap <Leader>tc :terminal<CR>sudo -u batan bash $HOME/check/vim.cmd.sh <CR>
nnoremap <Leader>cf :terminal<CR>less /home/batan/.config/lists/folds.list <CR>
nnoremap <Leader>xc :w !xclip -selection clipboard<CR>	"copy page to clipboard
nnoremap <leader>dd :Lexplore %:p:h<CR>		"open netrw in 20% of the screen to teh left
nnoremap <Leader>da :Lexplore<CR>
nnoremap <leader>vv :split $MYVIMRC<CR>		"edit vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>	"source vimrc
nnoremap <leader>ra :<C-U>RangerChooser<CR>
nmap <F8> :TagbarToggle<CR>				"tagbar toggle
"#}}}
"#{{{ >>>   TABLE MODE
let g:table_mode_always_active= 1
let g:table_mode_tablesize_map='<Leader>tt'
let g:table_mode_tablesize_op_map='<Leader>T'
"#}}}
"#{{{ >>>   AMY CONFIG
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <C-space> ?
"" Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>
"" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l
"" Close the current buffer
"map <leader>bd :Bclose<cr>:tabclose<cr>gT
"" Close all the buffers
"map <leader>ba :bufdo bd<cr>
"map <leader>l :bnext<cr>
"map <leader>h :bprevious<cr>
"" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove
"map <leader>t<leader> :tabnext<cr>
"" Let 'tl' toggle between this and the last accessed tab
"let g:lasttab = 1
"nmap <leader>tl :exe "tabn ".g:lasttab<CR>
"au TabLeave * let g:lasttab = tabpagenr()



" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
"map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/
" Switch CWD to the directory of the open buffer
"map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Specify the behavior when switching between buffers
"try
"  set switchbuf=useopen,usetab,newtab
"  set stal=2
"catch
"endtry

" Return to last edit position when opening files (You want this!)
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
 "Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"
" "HELPER FUNCTUN
" function! HasPaste()
"    if &paste
"        return 'PASTE MODE  '
"    endif
"    return ''
"endfunction


" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
"#}}}
"#{{{ >>>   COMMON CONFIGS
set wildmode=longest,list,full
set wildmenu

if filereadable("/etc/vim/vimrc.local")
		source /etc/vim/vimrc.local
	endif

	if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

if filereadable("/etc/vim/vimrc.local")
		source /etc/vim/vimrc.local
	endif
 if exists('$TMUX')  " Support resizing in tmux
   set ttymouse=xterm2
   endif
syntax on
filetype plugin indent on
set laststatus=2
set so=7
set foldcolumn=1
set encoding=utf8
set ffs=unix,dos
set cmdheight=1
set hlsearch
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1
set encoding=utf8
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set nobackup
set nowb
set nocp
set autowrite
set hidden
set mouse=a
set noswapfile
set nu
set relativenumber
set t_Co=256
set cursorcolumn
set cursorline
set ruler
set scrolloff=10
"#}}}
"#{{{ >>>   Netrw
let g:netrw_menu = 1
let g:netrw_preview = 1
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_lifestyle = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
"#}}}
"#{{{ >>>   GOOGLE CALENDAR TASK

"let g:calendar_google_calendar = 0
"let g:calendar_google_task = 0
"#source ~/.cache/calendar.vim/credentials.vim
"#}}}
"#{{{ >>>   VimWiki SHow Last Modified files in menu
"function! ShowLastAccessedFiles()
"    let files = systemlist('ls -lt | head -n 5 | awk \'{print $9}\'')
"    let file_list = ['Last Accessed Files:']
"    for file in files
"        call add(file_list, '- ' . file)
"    endfor
"    return join(file_list, "\n")
"endfunction
"#}}}
"#{{{ >>>   command! LastAccessedFiles echo ShowLastAccessedFiles()
"#}}}
"#{{{ >>>   NOTES
" Map <Leader>nn to open a specific file in a specific directory with dynamic naming
nnoremap <Leader>nn :call OpenSpecificFile()<CR>
"#}}}
"#{{{ >>>   Function to open the specified file
function! OpenSpecificFile()
  " Set the base directory
  let s:directory = '10/notes'
  " Generate the filename based on the specified pattern with an incrementing counter
  let s:filename = 'note.' . strftime('%j.') . printf('%02d', s:getCounter()) . '.wiki'
  " Construct the full path
  let s:fullpath = expand('~/' . s:directory . '/' . s:filename)
  " Open the file
  execute 'edit ' . s:fullpath
  " Increment the counter for the next file
  call s:incrementCounter()
endfunction
"#}}}
"#{{{ >>>   Function to get the counter from a file or initialize it
function! s:getCounter() abort
  let s:counterFile = expand('~/.vim_note_counter')
  let s:counter = filereadable(s:counterFile) ? system('cat ' . s:counterFile) : 0
  return s:counter
endfunction
"#}}}
"#{{{ >>>   Function to increment and save the counter
function! s:incrementCounter() abort
  let s:counter = s:getCounter() + 1
  call writefile([s:counter], s:counterFile)
endfunction
"#}}}
"#{{{ >>>   Ranger Chooser
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>ra :<C-U>RangerChooser<CR>
"#}}}
"#{{{ >>>   TEMPLATES
autocmd! BufNewFile *.sh 0r ~/.vim/templates/sklt.sh
autocmd! BufNewFile *popup.html 0r ~/.vim/templates/popup.html
autocmd! BufNewFile *popup.css 0r ~/.vim/templates/popup.css
autocmd! BufNewFile *popup.js 0r ~/.vim/templates/popup.js
autocmd! BufNewFile *.sh 0r ~/.vim/templates/sklt.t.sh
autocmd! BufNewFile *.html 0r ~/.vim/templates/sklt.html
autocmd! BufNewFile *.txt 0r ~/.vim/templates/sklt.txt
autocmd! BufNewFile *.w.wiki 0r ~/.vim/templates/sklt.w.wiki
autocmd! BufNewFile /home/batan/.config/reminder/*.rem 0r ~/.vim/templates/sklt.rem | normal! 11G| +START
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
"#}}}
"#{{{ >>>   Templates Table xxx

command! -nargs=0 T3 :call T3CreateTemplate()

function! T3CreateTemplate()
    let g:header1 = input('Enter value for Header 1: ')
    let g:header2 = input('Enter value for Header 2: ')
    let g:header3 = input('Enter value for Header 3: ')

    execute "normal! i+=================================+\r"
    execute "normal! i|LC-Linux Solutions Rule the World|\r"
    execute "normal! i+----------+-----------+----------+\r"
    execute "normal! i|".g:header1."|".g:header2."|".g:header3."|\r"
    execute "normal! i|----------|----------|----------|\r"
    execute "normal! i|          |          |          |\r"
endfunction
"#}}}

"#{{{ >>>   tasks ?
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
let g:task_report_command  = []
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" allows user to override task configurations. Seperated by space. Defaults to ''
let g:task_rc_override     = 'rc.defaultwidth=999'
" default fields to ask when adding a new task
let g:task_default_prompt  = ['due', 'description']
" whether the info window is splited vertically
let g:task_info_vsplit     = 0
" info window size
let g:task_info_size       = 15
" info window position
let g:task_info_position   = 'belowright'
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '~/.task'
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <<'
" backward arrow ...
let g:task_left_arrow      = '>> '
"#}}}
"#{{{ >>>   Vimwiki
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{
  \ 'path': '$HOME/10/vimwiki/templates/',
  \ 'template_path': '$HOME/10/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]
let g:vimwiki_hl_headers = 1
let wiki_2 = {}
let wiki_2.path = '/home/batan/10/vimwiki/vimwiki2/'
let wiki_2.path_html = '/home/batan/10/vimwiki/vimwiki2_html/'

let wiki_1 = {}
let wiki_1.path = '/home/batan/10/vimwiki/'
let wiki_1.path_html = '/home/batan/10/vimwiki_html/'

let wiki_3 = {}
let wiki_3.path = '/home/batan/10/vimwiki/vimwiki3/'
let wiki_3.path_html = '/home/batan/10/vimwiki/vimwiki3_html/'

let wiki_4 = {}
let wiki_4.path = '/home/batan/10/vimwiki/vimwiki4/'
let wiki_4.path_html = '/home/batan/10/vimwiki/vimwiki4_html/'

let wiki_5 = {}
let wiki_5.path = '/home/batan/10/vimwiki/vimwiki5/'
let wiki_5.path_html = '/home/batan/10/vimwiki/vimwiki5_html/'

let wiki_6 = {}
let wiki_6.path = '/home/batan/10/vimwiki/vimwiki6/'
let wiki_6.path_html = '/home/batan/10/vimwiki/vimwiki6_html/'

let wiki_7 = {}
let wiki_7.path = '/home/batan/10/vimwiki/vimwiki7/'
let wiki_7.path_html = '/home/batan/10/vimwiki/vimwiki7_html/'

let wiki_8 = {}
let wiki_8.path = '/home/batan/10/vimwiki/vimwiki8/'
let wiki_8.path_html = '/home/batan/10/vimwiki/vimwiki8_html/'

let wiki_9 = {}
let wiki_9.path = '/home/batan/10/vimwiki/vimwiki9/'
let wiki_9.path_html = '/home/batan/10/vimwiki/vimwiki9_html/'

let wiki_10 = {}
let wiki_10.path = '/home/batan/10/vimwiki/vimwiki10/'
let wiki_10.path_html = '/home/batan/10/vimwiki/vimwiki10_html/'
let g:vimwiki_list=[wiki_1, wiki_2, wiki_3, wiki_4, wiki_5, wiki_6, wiki_7, wiki_8, wiki_9, wiki_10]
"#}}}
"#{{{ >>>   WORDPROCESSOR
func! WordProcessorMode()
 setlocal textwidth=80
 setlocal smartindent
 setlocal spell spelllang=en_us
 setlocal noexpandtab
endfu

com! WP call WordProcessorMode()
"#}}}
"
command! -nargs=0 F :call FoldsLC()
function FoldsLC()
	let g:fold1 = input('Enter value for fold1: ')
	execute "normal! i#{{{ >>>   ".g:fold1."\r\r}}}"
	execute "normal! kdd" " "
endfunction

command! -nargs=0 FH call FoldHeader()
function FoldHeader()
	execute "normal! i# vim:fileencoding=utf-8:foldmethod=marker"
endfunction
#}}}
EOL

#}}}
fi
if [[ $aa8 -eq 1 ]]; then
#{{{ >>>   .taskrc
cat<<EOL> .taskrc
#{{{ >>> .taskrc
# [Created by task 2.5.3 3/25/2023 04:11:59]
# Taskwarrior program configuration file.
# For more documentation, see http://taskwarrior.org or try 'man task', 'man task-color',
# 'man task-sync' or 'man taskrc'

# Here is an example of entries that use the default, override and blank values
#   variable=foo   -- By specifying a value, this overrides the default
#   variable=      -- By specifying no value, this means no default
#   #variable=foo  -- By commenting out the line, or deleting it, this uses the default

# Use the command 'task show' to see all defaults and overrides

# Files
data.location=~/.task

# Color theme (uncomment one to use)
#include /usr/share/taskwarrior/light-16.theme
#include /usr/share/taskwarrior/light-256.theme
#include /usr/share/taskwarrior/dark-16.theme
#include /usr/share/taskwarrior/dark-256.theme
#include /usr/share/taskwarrior/dark-red-256.theme
#include /usr/share/taskwarrior/dark-green-256.theme
#include /usr/share/taskwarrior/dark-blue-256.theme
#include /usr/share/taskwarrior/dark-violets-256.theme
#include /usr/share/taskwarrior/dark-yellow-green.theme
#include /usr/share/taskwarrior/dark-gray-256.theme
#include /usr/share/taskwarrior/dark-gray-blue-256.theme
include /usr/share/taskwarrior/solarized-dark-256.theme
#include /usr/share/taskwarrior/solarized-light-256.theme
#include /usr/share/taskwarrior/no-color.theme

max_active_tasks=20
# Taskwarrior color settings
color=on
color.header.bold=on
color.label=yellow
color.uda=green
color.overdue=red
color.due.today=blue


# User Defined Attributes
uda.estimate.type=duration
uda.estimate.label=Est

# Timebox UDAs
uda.tb_estimate.type=numeric
uda.tb_estimate.label=Est
uda.tb_real.type=numeric
uda.tb_real.label=Real

# Taskwarrior notification settings (requires external tool like 'tasknotify')
#notification.command=/path/to/your/notification/script.sh

# Taskwarrior hooks
#hook.commit.pre=/path/to/your/pre-commit-script.sh
#hook.commit.allowall=yes

# Taskwarrior extensions (if you have any)
# include /path/to/your/extensions.rc

# Taskwarrior web settings (if you use the web UI)
# web.port=YOUR_PORT
# web.server=YOUR_SERVER

# Taskwarrior encryption settings (if you use encryption)
# encryption=on
# encryption.key=YOUR_ENCRYPTION_KEY

# Taskwarrior undo settings
undo.data.location=~/.task_undo

# Taskwarrior recurrence settings
recurrence.confirmation=1

# Taskwarrior hooks
#hook.commit.pre=/path/to/your/pre-commit-script.sh
#hook.commit.allowall=yes

# Taskwarrior urgency settings
urgency.age.coefficient=1.0
urgency.age.max=365

# Taskwarrior JSON export settings
json.array=off
json.depends.array=on

news.version=2.6.0
uda.estimate.type=numeric
uda.estimate.label=Est
minimal.labels=ID,Due,Project,Description,Est
uda.reviewed.type=date
uda.reviewed.label=Reviewed
report._reviewed.description=Tasksh review report.  Adjust the filter to your needs.
report._reviewed.columns=uuid
report._reviewed.sort=reviewed+,modified+
report._reviewed.filter=( reviewed.none: or reviewed.before:now-6days ) and ( +PENDING or +WAITING )
report.list.labels=ID,Due,Active,Age,Time Spent,...,Urg
report.list.columns=id,due,start.age,entry.age,totalactivetime,...,urgency
#}}}
EOL

#}}}
fi
if [[ $aa9 -eq 1 ]]; then
#{{{ >>>   .tmux.conf
cat<<EOL> .tmux.conf
#{{{ >>> .tmux.conf

# ==========================
# ===  General settings  ===
# ==========================
#set -g mouse on
#set -g set-clipboard external
#bind -T root MouseUp2Pane paste

set -g display-panes-active-colour colour3
set -g display-panes-colour colour4
set -g default-terminal "screen-256color"
set -g history-limit 20000
set -g buffer-limit 20
set -sg escape-time 0
set -g display-time 1500
set -g remain-on-exit off
set -g repeat-time 300
setw -g allow-rename off
setw -g automatic-rename off
setw -g aggressive-resize on

# Change prefix key to C-a, easier to type, same to "screen"
unbind C-b
set -g prefix C-a

# Set parent terminal title to reflect current window in tmux session
set -g set-titles on
set -g set-titles-string "#I:#W"

# Start index of window/pane with 1, because we're humans, not computers
set -g base-index 1
setw -g pane-base-index 1

# Enable mouse support
set -g mouse on


# ==========================
# ===   Key bindings     ===
# ==========================

# Unbind default key bindings, we're going to override
unbind "\$" # rename-session
unbind ,    # rename-window
unbind %    # split-window -h
unbind '"'  # split-window
unbind [    # paste-buffer
unbind ]
unbind "'"  # select-window
unbind n    # next-window
unbind p    # previous-window
unbind l    # last-window
unbind M-n  # next window with alert
unbind M-p  # next window with alert
unbind o    # focus thru panes
unbind &    # kill-window
unbind "#"  # list-buffer
unbind =    # choose-buffer
unbind z    # zoom-pane
unbind M-Up  # resize 5 rows up
unbind M-Down # resize 5 rows down
unbind M-Right # resize 5 rows right
unbind M-Left # resize 5 rows left


# Edit configuration and reload
bind C-e new-window -n 'tmux.conf' "sh -c '\${EDITOR:-vim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"Config reloaded\"'"

# Reload tmux configuration
bind C-r source-file ~/.tmux.conf \; display "Config reloaded"

# new window and retain cwd
bind c new-window -c "#{pane_current_path}"

# Prompt to rename window right after it's created
set-hook -g after-new-window 'command-prompt -I "#{window_name}" "rename-window '%%'"'

# Rename session and window
bind r command-prompt -I "#{window_name}" "rename-window '%%'"
bind R command-prompt -I "#{session_name}" "rename-session '%%'"

# Split panes
bind | split-window -h -c "#{pane_current_path}"
bind _ split-window -v -c "#{pane_current_path}"

# Select pane and windows
bind -r C-[ previous-window
bind -r C-] next-window
bind -r [ select-pane -t :.-
bind -r ] select-pane -t :.+
bind -r Tab last-window   # cycle thru MRU tabs
bind -r C-o swap-pane -D

# Zoom pane
bind + resize-pane -Z

# Link window
bind L command-prompt -p "Link window from (session:window): " "link-window -s %% -a"

# Swap panes back and forth with 1st pane
# When in main-(horizontal|vertical) layouts, the biggest/widest panel is always @1
#bind \
#if '[ #{pane_index} -eq 1 ]' \
#     'swap-pane -s "!"' \
#     'select-pane -t:.1 ; swap-pane -d -t 1 -s "!"'
#
# Kill pane/window/session shortcuts
bind x kill-pane
bind X kill-window
bind C-x confirm-before -p "kill other windows? (y/n)" "kill-window -a"
bind Q confirm-before -p "kill-session #S? (y/n)" kill-session

# Merge session with another one (e.g. move all windows)
# If you use adhoc 1-window sessions, and you want to preserve session upon exit
# but don't want to create a lot of small unnamed 1-window sessions around
# move all windows from current session to main named one (dev, work, etc)
bind C-u command-prompt -p "Session to merge with: " \
   "run-shell 'yes | head -n #{session_windows} | xargs -I {} -n 1 tmux movew -t %%'"

# Detach from session
bind d detach
bind D if -F '#{session_many_attached}' \
    'confirm-before -p "Detach other clients? (y/n)" "detach -a"' \
    'display "Session has only 1 client attached"'

# Hide status bar on demand
bind C-s if -F '#{s/off//:status}' 'set status off' 'set status on'



# ==================================================
# === Window monitoring for activity and silence ===
# ==================================================
bind m setw monitor-activity \; display-message 'Monitor window activity [#{?monitor-activity,ON,OFF}]'
bind M if -F '#{monitor-silence}' \
    'setw monitor-silence 0 ; display-message "Monitor window silence [OFF]"' \
    'command-prompt -p "Monitor silence: interval (s)" "setw monitor-silence %%"'

# Activity bell and whistles
set -g visual-activity on

# TODO: Does not work as well, check on newer versions
# set -g visual-silence on

# BUG: bell-action other ignored Â· Issue #1027 Â· tmux/tmux Â· GitHub - https://github.com/tmux/tmux/issues/1027
# set -g visual-bell on
# setw -g bell-action other

# ================================================
# ===     Copy mode, scroll and clipboard      ===
# ================================================
set -g @copy_use_osc52_fallback on

# Prefer vi style key table
setw -g mode-keys vi

bind p paste-buffer
bind C-p choose-buffer

# trigger copy mode by
bind -n M-Up copy-mode

# Scroll up/down by 1 line, half screen, whole screen
bind -T copy-mode-vi M-Up              send-keys -X scroll-up
bind -T copy-mode-vi M-Down            send-keys -X scroll-down
bind -T copy-mode-vi M-PageUp          send-keys -X halfpage-up
bind -T copy-mode-vi M-PageDown        send-keys -X halfpage-down
bind -T copy-mode-vi PageDown          send-keys -X page-down
bind -T copy-mode-vi PageUp            send-keys -X page-up

# When scrolling with mouse wheel, reduce number of scrolled rows per tick to "2" (default is 5)
bind -T copy-mode-vi WheelUpPane       select-pane \; send-keys -X -N 2 scroll-up
bind -T copy-mode-vi WheelDownPane     select-pane \; send-keys -X -N 2 scroll-down

# wrap default shell in reattach-to-user-namespace if available
# there is some hack with `exec & reattach`, credits to "https://github.com/gpakosz/.tmux"
# don't really understand how it works, but at least window are not renamed to "reattach-to-user-namespace"
if -b "command -v reattach-to-user-namespace > /dev/null 2>&1" \
    "run 'tmux set -g default-command \"exec $(tmux show -gv default-shell) 2>/dev/null & reattach-to-user-namespace -l $(tmux show -gv default-shell)\"'"

yank="~/.tmux/yank.sh"

# Copy selected text
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "$yank"
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "$yank"
bind -T copy-mode-vi Y send-keys -X copy-line \;\
    run "tmux save-buffer - | $yank"
bind-key -T copy-mode-vi D send-keys -X copy-end-of-line \;\
    run "tmux save-buffer - | $yank"
bind -T copy-mode-vi C-j send-keys -X copy-pipe-and-cancel "$yank"
bind-key -T copy-mode-vi A send-keys -X append-selection-and-cancel \;\
    run "tmux save-buffer - | $yank"

# Copy selection on drag end event, but do not cancel copy mode and do not clear selection
# clear select on subsequence mouse click
bind -T copy-mode-vi MouseDragEnd1Pane \
    send-keys -X copy-pipe "$yank"
bind -T copy-mode-vi MouseDown1Pane select-pane \;\
   send-keys -X clear-selection

# iTerm2 works with clipboard out of the box, set-clipboard already set to "external"
# tmux show-options -g -s set-clipboard
# set-clipboard on|external

# =====================================
# ===           Theme               ===
# =====================================

# Feel free to NOT use this variables at all (remove, rename)
# this are named colors, just for convenience
color_orange="colour166" # 208, 166
color_purple="colour134" # 135, 134
color_green="colour076" # 070
color_blue="colour39"
color_yellow="colour220"
color_red="colour160"
color_black="colour232"
color_white="white" # 015

# This is a theme CONTRACT, you are required to define variables below
# Change values, but not remove/rename variables itself
color_dark="$color_black"
color_light="$color_white"
color_session_text="$color_blue"
color_status_text="colour245"
color_main="$color_orange"
color_secondary="$color_purple"
color_level_ok="$color_green"
color_level_warn="$color_yellow"
color_level_stress="$color_red"
color_window_off_indicator="colour088"
color_window_off_status_bg="colour238"
color_window_off_status_current_bg="colour254"

# =====================================
# ===    Appearence and status bar  ===
# ======================================

set -g mode-style "fg=default,bg=$color_main"

# command line style
set -g message-style "fg=$color_main,bg=$color_dark"

# status line style
set -g status-style "fg=$color_status_text,bg=$color_dark"

# window segments in status line
set -g window-status-separator ""
separator_powerline_left="î²"
separator_powerline_right="î°"

# setw -g window-status-style "fg=$color_status_text,bg=$color_dark"
setw -g window-status-format " #I:#W "
setw -g window-status-current-style "fg=$color_light,bold,bg=$color_main"
setw -g window-status-current-format "#[fg=$color_dark,bg=$color_main]$separator_powerline_right#[default] #I:#W# #[fg=$color_main,bg=$color_dark]$separator_powerline_right#[default]"

# when window has monitoring notification
setw -g window-status-activity-style "fg=$color_main"

# outline for active pane
setw -g pane-active-border-style "fg=$color_main"

# general status bar settings
set -g status on
set -g status-interval 5
set -g status-position top
set -g status-justify left
set -g status-right-length 100

# define widgets we're going to use in status bar
# note, that this is not the complete list, some of them are loaded from plugins
wg_session="#[fg=$color_session_text] #S #[default]"
wg_battery="#{battery_status_fg} #{battery_icon} #{battery_percentage}"
wg_date="#[fg=$color_secondary]%h %d %H:%M#[default]"
wg_user_host="#[fg=$color_secondary]#(whoami)#[default]@#H"
wg_is_zoomed="#[fg=$color_dark,bg=$color_secondary]#{?window_zoomed_flag,[Z],}#[default]"
# TODO: highlighted for nested local session as well
wg_is_keys_off="#[fg=$color_light,bg=$color_window_off_indicator]#([ $(tmux show-option -qv key-table) = 'off' ] && echo 'OFF')#[default]"

set -g status-left "$wg_session"
set -g status-right "#{prefix_highlight} $wg_is_keys_off $wg_is_zoomed #{sysstat_cpu} | #{sysstat_mem} | #{sysstat_loadavg} | $wg_user_host | $wg_date $wg_battery #{online_status}"

# online and offline icon for tmux-online-status
set -g @online_icon "#[fg=$color_level_ok]â#[default]"
set -g @offline_icon "#[fg=$color_level_stress]â#[default]"

# Configure view templates for tmux-plugin-sysstat "MEM" and "CPU" widget
set -g @sysstat_mem_view_tmpl 'MEM:#[fg=#{mem.color}]#{mem.pused}#[default] #{mem.used}'

# Configure colors for tmux-plugin-sysstat "MEM" and "CPU" widget
set -g @sysstat_cpu_color_low "$color_level_ok"
set -g @sysstat_cpu_color_medium "$color_level_warn"
set -g @sysstat_cpu_color_stress "$color_level_stress"

set -g @sysstat_mem_color_low "$color_level_ok"
set -g @sysstat_mem_color_medium "$color_level_warn"
set -g @sysstat_mem_color_stress "$color_level_stress"

set -g @sysstat_swap_color_low "$color_level_ok"
set -g @sysstat_swap_color_medium "$color_level_warn"
set -g @sysstat_swap_color_stress "$color_level_stress"


# Configure tmux-battery widget colors
set -g @batt_color_full_charge "#[fg=$color_level_ok]"
set -g @batt_color_high_charge "#[fg=$color_level_ok]"
set -g @batt_color_medium_charge "#[fg=$color_level_warn]"
set -g @batt_color_low_charge "#[fg=$color_level_stress]"

# Configure tmux-prefix-highlight colors
set -g @prefix_highlight_output_prefix '['
set -g @prefix_highlight_output_suffix ']'
set -g @prefix_highlight_fg "$color_dark"
set -g @prefix_highlight_bg "$color_secondary"
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr "fg=$color_dark,bg=$color_secondary"


# =====================================
# ===        Renew environment      ===
# =====================================
set -g update-environment \
  "DISPLAY\
  SSH_ASKPASS\
  SSH_AUTH_SOCK\
  SSH_AGENT_PID\
  SSH_CONNECTION\
  SSH_TTY\
  WINDOWID\
  XAUTHORITY"

bind '$' run "~/.tmux/renew_env.sh"


# ============================
# ===       Plugins        ===
# ============================
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-battery'
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
set -g @plugin 'tmux-plugins/tmux-online-status'
set -g @plugin 'tmux-plugins/tmux-sidebar'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-open'
set -g @plugin 'samoshkin/tmux-plugin-sysstat'

# Plugin properties
set -g @sidebar-tree 't'
set -g @sidebar-tree-focus 'T'
set -g @sidebar-tree-command 'tree -C'

set -g @open-S 'https://www.google.com/search?q='


# ==============================================
# ===   Nesting local and remote sessions     ===
# ==============================================

# Session is considered to be remote when we ssh into host
if-shell 'test -n "$SSH_CLIENT"' \
    'source-file ~/.tmux/tmux.remote.conf'

# We want to have single prefix key "C-a", usable both for local and remote session
# we don't want to "C-a" + "a" approach either
# Idea is to turn off all key bindings and prefix handling on local session,
# so that all keystrokes are passed to inner/remote session

# see: toggle on/off all keybindings Â· Issue #237 Â· tmux/tmux - https://github.com/tmux/tmux/issues/237

# Also, change some visual styles when window keys are off
bind -T root F12  \
    set prefix None \;\
    set key-table off \;\
    set status-style "fg=$color_status_text,bg=$color_window_off_status_bg" \;\
    set window-status-current-format "#[fg=$color_window_off_status_bg,bg=$color_window_off_status_current_bg]$separator_powerline_right#[default] #I:#W# #[fg=$color_window_off_status_current_bg,bg=$color_window_off_status_bg]$separator_powerline_right#[default]" \;\
    set window-status-current-style "fg=$color_dark,bold,bg=$color_window_off_status_current_bg" \;\
    if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
    refresh-client -S \;\

bind -T off F12 \
  set -u prefix \;\
  set -u key-table \;\
  set -u status-style \;\
  set -u window-status-current-style \;\
  set -u window-status-current-format \;\
  refresh-client -S

# Run all plugins' scripts
run '~/.tmux/plugins/tpm/tpm'
#}}}
EOL

#}}}
fi
if [[ $aa10 -eq 1 ]]; then
#{{{ >>>   .megarc
cat<<EOL> .megarc
#{{{ >>> .megarc
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
[Login]
Username=tel.petar@gmail.com
Password=Ba7an?12982
#}}}
EOL

#}}}
fi
if [[ $aa11 -eq 1 ]]; then
#{{{ >>>   .lc-cd
cat<<EOL> .lc-cd
#{{{ >>> .lc-cd
/boot/
/etc/
/home/batan/10/html/homepage/
/media/
/media/batan/
/home/batan/.vim/pack/plugins/start/
/home/batan/.task
/home/batan/.config/nvim/pack/plugins/start/
/home/batan/.config/bash-config/
/home/batan/.config/bin/
/home/batan/.config/bleachbit/
/home/batan/.config/castero/
/home/batan/.config/cava/
/home/batan/.config/cheat/
/home/batan/.config/cheat.sh/
/home/batan/.config/chromium/
/home/batan/.config/clipit/
/home/batan/.config/cmus/
/home/batan/.config/credentials/
/home/batan/.config/cubic/
/home/batan/.config/Cursor/
/home/batan/.config/dconf/
/home/batan/.config/dot/
/home/batan/.config/dunst/
/home/batan/.config/enchant/
/home/batan/.config/falkon/
/home/batan/.config/featherpad/
/home/batan/.config/geany/
/home/batan/.config/gnome-boxes/
/home/batan/.config/go/
/home/batan/.config/gtk-2.0/
/home/batan/.config/gtk-3.0/
/home/batan/.config/helix/
/home/batan/.config/homepage/
/home/batan/.config/i3/
/home/batan/.config/i3blocks/
/home/batan/.config/i3lock-color/
/home/batan/.config/i3status/
/home/batan/.config/kitty/
/home/batan/.config/lazpaint/
/home/batan/.config/lc-cleaner/
/home/batan/.config/lc-mashpodder/
/home/batan/.config/libfm/
/home/batan/.config/libvirt/
/home/batan/.config/LM Studio/
/home/batan/.config/mc/
/home/batan/.config/menus/
/home/batan/.config/Mousepad/
/home/batan/.config/mpd/
/home/batan/.config/mpv/
/home/batan/.config/MX-Linux/
/home/batan/.config/ncmpcpp/
/home/batan/.config/nitrogen/
/home/batan/.config/nomacs/
/home/batan/.config/nvim/
/home/batan/.config/orage/
/home/batan/.config/picom/
/home/batan/.config/podget/
/home/batan/.config/polybar/
/home/batan/.config/pulse/
/home/batan/.config/qpdfview/
/home/batan/.config/ranger/
/home/batan/.config/reminder/
/home/batan/.config/rofi/
/home/batan/.config/shalarm/
/home/batan/.config/strawberry/
/home/batan/.config/surf/
/home/batan/.config/Thunar/
/home/batan/.config/tint2/
/home/batan/.config/u/
/home/batan/.config/vlc/
/home/batan/.config/volumeicon/
/home/batan/.config/VSCodium/
/home/batan/.config/xfce4/
/home/batan/.config/xfce-superkey/
/home/batan/.config/xmonad/
/home/batan/.config/xresources.d/
/home/batan/.config/autostart/
/home/batan/.config/bleachbit/
/home/batan/.config/cava/
/home/batan/.config/clipit/
/home/batan/.config/cmus/
/home/batan/.config/dconf/
/home/batan/.config/debreate/
/home/batan/.config/enchant/
/home/batan/.config/falkon/
/home/batan/.config/featherpad/
/home/batan/.config/geany/
/home/batan/.config/ghostty/
/home/batan/.config/gnome-boxes/
/home/batan/.config/go/
/home/batan/.config/gtk-2.0/
/home/batan/.config/gtk-3.0/
/home/batan/.config/home/
/home/batan/.config/i3/
/home/batan/.config/i3_README_PETAR/
/home/batan/.config/kitty/
/home/batan/.config/lazpaint/
/home/batan/.config/lc-mashpodder/
/home/batan/.config/libfm/
/home/batan/.config/libvirt/
/home/batan/.config/LM
/home/batan/.config/mc/
/home/batan/.config/menus/
/home/batan/.config/mpv/
/home/batan/.config/MX-Linux/
/home/batan/.config/Nextcloud/
/home/batan/.config/nomacs/
/home/batan/.config/nomic.ai/
/home/batan/.config/nvim/
/home/batan/.config/orage/
/home/batan/.config/PBE/
/home/batan/.config/polybar/
/home/batan/.config/pulse/
/home/batan/.config/qpdfview/
/home/batan/.config/ranger/
/home/batan/.config/redshift/
/home/batan/.config/reminder/
/home/batan/.config/rofi/
/home/batan/.config/sunflower/
/home/batan/.config/Thunar/
/home/batan/.config/vlc/
/home/batan/.config/volumeicon/
/home/batan/.config/warp-terminal/
/home/batan/.config/Windsurf/
/home/batan/.config/xfce4/
/home/batan/.config/xfce-superkey/
/home/batan/.config/YAD/
/home/batan/.config/yt-dlp/
/media/batan/100/anon/
/media/batan/100
/media/batan/200
/media/batan/300
/media/batan/DATA
/media/batan/USB
/media/batan/100/AppImages/
/media/batan/100/archlinux/
/media/batan/100/Backgrounds/
/media/batan/100/CascadeProjects/
/media/batan/100/COURSES/
/media/batan/100/DETOX/
/media/batan/100/Downloads/
/media/batan/100/FILES/
/media/batan/100/Fonts/
/media/batan/100/github/
/media/batan/100/HTML/
/media/batan/100/icon-collection/
/media/batan/100/INPROGRESS/
/media/batan/100/ISO/
/media/batan/100/last_modified/
/media/batan/100/Music/
/media/batan/100/Music/Podcasts/
/media/batan/100/MX/
/media/batan/100/MX-FLUXBOX/
/media/batan/100/MX_REPO/
/media/batan/100/MY-Projects/
/media/batan/100/Notes/
/media/batan/100/Olite/
/media/batan/100/PROJECT/
/media/batan/100/SCRIPTS/
/media/batan/100/SCRIPTS_FROM_UBUNTU/
/media/batan/100/Software/
/media/batan/100/Videos/
/media/batan/100/vim-devicons/
/media/batan/100/VIMWIKI2/
/media/batan/100/XXX/
#}}}
EOL

#}}}
fi
if [[ $aa12 -eq 1 ]]; then
#{{{ >>>   .Xauthority
cat<<EOL> .Xauthority
#{{{ >>> .Xauthority
  q4os-desktop 0 MIT-MAGIC-COOKIE-1  ÝÈ¶`k!JJ¼aIW  parrot 0 MIT-MAGIC-COOKIE-1 áS¤ÃPÉ®fÉõ#}}}
EOL

#}}}
fi
if [[ $aa13 -eq 1 ]]; then
#{{{ >>>   .Xdefaults
cat<<EOL> .Xdefaults
#{{{ >>> .Xdefaults
!! Transparency (0-1):
st.alpha: 0.92
st.alphaOffset: 0.3

!! Set a default font and font size as below:
st.font: AnonymiceProNerdFontMono-Regular -16;

 st.termname: st-256color
 st.borderpx: 2

!! Set the background, foreground and cursor colors as below:
urxvt*font: xft:Terminus:pixelsize=14,xft:Inconsolata\ for\ Powerline:pixelsize=12
URxvt*font: xft:Source\ Code\ Pro\ Medium:pixelsize=13:antialias=true:hinting=true,xft:Source\ Code\ Pro\ Medium:pixelsize=13:antialias=true:hinting=true

!! gruvbox:
*.color0: #1d2021
*.color1: #cc241d
*.color2: #98971a
*.color3: #d79921
*.color4: #458588
*.color5: #b16286
*.color6: #689d6a
*.color7: #a89984
*.color8: #928374
*.color9: #fb4934
*.color10: #b8bb26
*.color11: #fabd2f
*.color12: #83a598
*.color13: #d3869b
*.color14: #8ec07c
*.color15: #ebdbb2
*.background: #282828
*.foreground: white
*.cursorColor: white

/* /1* !! gruvbox light: *1/ */
/* *.color0: #fbf1c7 */
/* *.color1: #cc241d */
/* *.color2: #98971a */
/* *.color3: #d79921 */
/* *.color4: #458588 */
/* *.color5: #b16286 */
/* *.color6: #689d6a */
/* *.color7: #7c6f64 */
/* *.color8: #928374 */
/* *.color9: #9d0006 */
/* *.color10: #79740e */
/* *.color11: #b57614 */
/* *.color12: #076678 */
/* *.color13: #8f3f71 */
/* *.color14: #427b58 */
/* *.color15: #3c3836 */
/* *.background: #fbf1c7 */
/* *.foreground: #282828 */
/* *.cursorColor: #282828 */

/* !! brogrammer: */
/* *.foreground:  #d6dbe5 */
/* *.background:  #131313 */
/* *.color0:      #1f1f1f */
/* *.color8:      #d6dbe5 */
/* *.color1:      #f81118 */
/* *.color9:      #de352e */
/* *.color2:      #2dc55e */
/* *.color10:     #1dd361 */
/* *.color3:      #ecba0f */
/* *.color11:     #f3bd09 */
/* *.color4:      #2a84d2 */
/* *.color12:     #1081d6 */
/* *.color5:      #4e5ab7 */
/* *.color13:     #5350b9 */
/* *.color6:      #1081d6 */
/* *.color14:     #0f7ddb */
/* *.color7:      #d6dbe5 */
/* *.color15:     #ffffff */
/* *.colorBD:     #d6dbe5 */

/* ! base16 */
/* *.color0:       #181818 */
/* *.color1:       #ab4642 */
/* *.color2:       #a1b56c */
/* *.color3:       #f7ca88 */
/* *.color4:       #7cafc2 */
/* *.color5:       #ba8baf */
/* *.color6:       #86c1b9 */
/* *.color7:       #d8d8d8 */
/* *.color8:       #585858 */
/* *.color9:       #ab4642 */
/* *.color10:      #a1b56c */
/* *.color11:      #f7ca88 */
/* *.color12:      #7cafc2 */
/* *.color13:      #ba8baf */
/* *.color14:      #86c1b9 */
/* *.color15:      #f8f8f8 */

/* !! solarized */
/* *.color0:	#073642 */
/* *.color1:	#dc322f */
/* *.color2:	#859900 */
/* *.color3:	#b58900 */
/* *.color4:	#268bd2 */
/* *.color5:	#d33682 */
/* *.color6:	#2aa198 */
/* *.color7:	#eee8d5 */
/* *.color9:	#cb4b16 */
/* *.color8:	#fdf6e3 */
/* *.color10:	#586e75 */
/* *.color11:	#657b83 */
/* *.color12:	#839496 */
/* *.color13:	#6c71c4 */
/* *.color14:	#93a1a1 */
/* *.color15:	#fdf6e3 */

/* !! xterm */
/* *.color0:   #000000 */
/* *.color1:   #cd0000 */
/* *.color2:   #00cd00 */
/* *.color3:   #cdcd00 */
/* *.color4:   #0000cd */
/* *.color5:   #cd00cd */
/* *.color6:   #00cdcd */
/* *.color7:   #e5e5e5 */
/* *.color8:   #4d4d4d */
/* *.color9:   #ff0000 */
/* *.color10:  #00ff00 */
/* *.color11:  #ffff00 */
/* *.color12:  #0000ff */
/* *.color13:  #ff00ff */
/* *.color14:  #00ffff */
/* *.color15:  #aabac8 */

#}}}
EOL

#}}}
fi
if [[ $aa14 -eq 1 ]]; then
#{{{ >>>   .Xresources
cat<<EOL> .Xresources
#{{{ >>> .Xresources
XTerm.vt100.faceName: JetBrainsMono-Regular
XTerm.vt100.faceSize: 10

XTerm.vt100.cursorBlink: true
XTerm.vt100.loginShell: true

XTerm.vt100.backarrowKey: false
XTerm.ttyModes: erase ^?

XTerm.vt100.geometry: 180x50+0-0
XTerm.*.fullscreen: never
! XTerm.*.scrollBar: true

! copy & paste like the gnome shell
!XTerm.*.translations: !override \n\
!Ctrl Shift <Key>C: copy-selection(CLIPBOARD) \n\
!Ctrl Shift <Key>V: insert-selection(CLIPBOARD) \n\
!Ctrl <Key>minus: smaller-vt-font() \n\
!Ctrl <Key>plus: larger-vt-font()

! make the alt key behave normally
XTerm.vt100.metaSendsEscape: true

! scrollback history
XTerm.saveLines: 4096
xterm*dynamicColors:    on
xterm*colorMode:        on
! silence please
XTerm.bellIsUrgent: false
XTerm*visualBell: false

XTerm*.foreground: white
XTerm*.background: black

!==============================================================================
! Ð¦Ð²ÐµÑÐ°
!==============================================================================
!xterm*colorBD:     #e6d51d
!xterm*background:  #111111
!xterm*foreground:  #b4b4b4
!! Ð§ÑÑÐ½ÑÐ¹
!xterm*color0:      #000000
!xterm*color8:      #555753
!! ÐÑÐ°ÑÐ½ÑÐ¹
!xterm*color1:      #b6212d
!xterm*color9:      #ff6565
!! ÐÐµÐ»ÑÐ½ÑÐ¹
!xterm*color2:      #4c8d00
!xterm*color10:     #6bbe1a
!! ÐÑÐ»ÑÑÐ¹
!xterm*color3:      #ff8040
!xterm*color11:     #e6d51d
!! Ð¡Ð¸Ð½Ð¸Ð¹
!xterm*color4:      #0086d2
!xterm*color12:     #00d2ff
!! ÐÐ°Ð´Ð¶ÐµÐ½ÑÐ°
!xterm*color5:      #963c59
!xterm*color13:     #d3649f
!! Ð¦Ð¸Ð°Ð½Ð¾Ð²ÑÐ¹
!xterm*color6:      #105952
!xterm*color14:     #177f75
!! ÐÐµÐ»ÑÐ¹
!xterm*color7:      #cdcaa9
!xterm*color15:     #ffffff
!
!! Molokai theme
*xterm*background: #101010
*xterm*foreground: #d0d0d0
*xterm*cursorColor: #d0d0d0
*xterm*color0: #101010
*xterm*color1: #960050
*xterm*color2: #66aa11
*xterm*color3: #c47f2c
*xterm*color4: #30309b
*xterm*color5: #7e40a5
*xterm*color6: #3579a8
*xterm*color7: #9999aa
*xterm*color8: #303030
*xterm*color9: #ff0090
*xterm*color10: #80ff00
*xterm*color11: #ffba68
*xterm*color12: #5f5fee
*xterm*color13: #bb88dd
*xterm*color14: #4eb4fa
*xterm*color15: #d0d0d0
#}}}
EOL

#}}}
fi
if [[ $aa15 -eq 1 ]]; then
#{{{ >>>   .inputrc
cat<<EOL> .inputrc
#{{{ >>> .inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward


#}}}
EOL

#}}}
fi
if [[ $aa16 -eq 1 ]]; then
#{{{ >>>   .lc-sign
cat<<EOL> .lc-sign
#{{{ >>> .lc-sign
blocking = 0
#}}}
EOL

#}}}
fi
if [[ $aa17 -eq 1 ]]; then
#{{{ >>>   .xboardrc
cat<<EOL> .xboardrc
#{{{ >>> .xboardrc
;
; xboard 4.9.1 Save Settings file
;
; You can edit the values of options that are already set in this file,
; but if you add other options, the next Save Settings will not save them.
; Use a shortcut, an @indirection file, or a .bat file instead.
;
-saveDate 1736671852
-whitePieceColor #FFFFCC
-blackPieceColor #202020
-lightSquareColor #C8C365
-darkSquareColor #77A26D
-highlightSquareColor #FFFF00
-premoveHighlightColor #FF0000
-movesPerSession -2000
-variations true
-appendPV true
-internetChessServerInputBox false
-soundProgram "aplay -q"
-fontSizeTolerance 4
-lowTimeWarningColor #FF0000
-lowTimeWarning false
-titleInWindow false
-flashCount 0
-flashRate 5
-pieceImageDirectory ""
-trueColors false
-soundDirectory "/usr/share/games/xboard/sounds"
-msLoginDelay 0
-pasteSelection false
-dropMenu false
-pieceMenu false
-sweepPromotions true
-monoMouse false
-timeDelay 1
-timeControl "1"
-seekGraph true
-autoRefresh false
-autoBox true
-saveGameFile ""
-autoSaveGames false
-onlyOwnGames false
-monoMode false
-showCoords false
-showThinking true
-ponderNextMove true
-periodicUpdates true
-popupExitMessage true
-popupMoveErrors false
-boardSize Bulky
-alwaysOnTop false
-autoCallFlag false
-autoComment false
-autoCreateLogon false
-autoObserve false
-autoFlipView true
-autoRaiseBoard true
-alwaysPromoteToQueen false
-oldSaveStyle false
-quietPlay false
-getMoveList true
-testLegality true
-premove true
-premoveWhite false
-premoveWhiteText ""
-premoveBlack false
-premoveBlackText ""
-icsAlarm false
-icsAlarmTime 5000
-animateMoving true
-animateSpeed 10
-animateDragging true
-blindfold false
-highlightLastMove true
-colorizeMessages true
-colorShout green
-colorSShout green,black,1
-colorChannel1 cyan
-colorChannel cyan,black,1
-colorKibitz magenta,black,1
-colorTell yellow,black,1
-colorChallenge red,black,1
-colorRequest red
-colorSeek blue
-colorNormal default
-soundShout ""
-soundSShout ""
-soundChannel1 ""
-soundChannel ""
-soundKibitz ""
-soundTell "phone.wav"
-soundChallenge "gong.wav"
-soundRequest ""
-soundSeek ""
-soundMove "woodthunk.wav"
-soundBell ""
-soundRoar "roar.wav"
-soundIcsWin ""
-soundIcsLoss ""
-soundIcsDraw ""
-soundIcsUnfinished ""
-soundIcsAlarm "penalty.wav"
-disguisePromotedPieces true
-saveSettingsOnExit true
-icsMenu {Give me;ptell Please give me $input;
Avoid;ptell Please don't let him get $input;
Q;$add a Queen $input;
R;$add a Rook $input;
B;$add a Bishop $input;
N;$add a Knight $input;
P;$add a Pawn $input;
Dead;ptell I will be checkmated;
MultiLine;
set open 0
set seek 0
set tell 1;
Kill;ptell I will checkmate him!;
Who;who;
Finger (name);finger $name;
Players;players;
Vars (name);vars $name;
Games;games;
Observe (name);observe $name;
Sought;sought;
Match (name);match $name;
Tell (name);tell $name $input;
Play (name);play $name;
Message (name);message $name $input;
Copy;$copy;
Open Chat Box (name);$chat;
}
-icsNames {"fics" -icshost freechess.org -icshelper timeseal
"icc" -icshost chessclub.com -icshelper timestamp
"kc" -icshost alanimus.com -icshelper timeseal
}
-recentEngines 4
-recentEngineList {fairymax
}
-firstChessProgramNames {fairymax
"Fruit 2.1" -fcp fruit -fUCI
"Crafty" -fcp crafty
"GNU Chess" -fcp gnuchess
maxqi
shamax
}
-themeNames {"native" -ubt false -pid "" -trueColors false -flipBlack false -overrideLineGap -1
"classic" -ubt false -lsc #c8c365 -dsc #77a26d -pid "" -wpc #ffffcc -bpc #202020 -hsc #ffff00 -phc #ff0000 -overrideLineGap -1 -flipBlack false
"wood" -ubt true -lbtf ~~/themes/textures/wood_l.png -dbtf ~~/themes/textures/wood_d.png -pid ""  -hsc #ffff00 -phc #ff0000 -overrideLineGap 1
"diagram" -ubt true -lbtf "" -dbtf ~~/themes/textures/hatch.png -lsc #ffffff -wpc #ffffff -bpc #000000 -pid "" -hsc #808080 -phc #808080 -trueColors false -overrideLineGap 1
"icy" -ubt false -lsc #ffffff -dsc #80ffff -pid "" -wpc #f1f8f8 -bpc #202020 -hsc #0000ff -phc #ff0000
# ORIENTAL THEMES
"shogi" -ubt true  -lbtf ~~/themes/textures/wood_d.png -dbtf ~~/themes/textures/wood_d.png -pid ~~/themes/shogi -trueColors true -hsc #ffff00 -phc #0080ff -overrideLineGap 1
"xiangqi" -ubt true  -lbtf ~~/themes/textures/xqboard-9x10.png -dbtf ~~/themes/textures/xqboard-9x10.png -pid ~~/themes/xiangqi -trueColors true -hsc #ffff00 -phc #ff0000 -overrideLineGap 0
"chu shogi" -ubt false -lsc #ff8040 -dsc #ff8040 -pid ~~/themes/chu -trueColors true -hsc #0000ff -phc #00ff00
# end
}
-showButtonBar true
-pgnExtendedInfo true
-hideThinkingFromHuman false
-pgnTimeLeft false
-liteBackTextureFile "/usr/share/games/xboard/themes/textures/wood_l.png"
-darkBackTextureFile "/usr/share/games/xboard/themes/textures/wood_d.png"
-liteBackTextureMode 1
-darkBackTextureMode 1
-renderPiecesWithFont ""
-fontPieceToCharTable ""
-fontPieceSize 80
-overrideLineGap 1
-adjudicateLossThreshold 0
-delayBeforeQuit 0
-delayAfterQuit 0
-pgnEventHeader "Computer Chess Game"
-defaultFrcPosition -1
-gameListTags "eprd"
-saveOutOfBookInfo true
-showEvalInMoveHistory true
-evalHistColorWhite #FFFFB0
-evalHistColorBlack #AD5D3D
-highlightMoveWithArrow true
-stickyWindows false
-adjudicateDrawMoves 0
-autoDisplayComment true
-autoDisplayTags true
-adapterCommand 'polyglot -noini -ec "%fcp" -ed "%fd" -uci NalimovCache=%defaultCacheSizeEGTB -pg ShowTbHits=true'
-uxiAdapter ""
-polyglotDir ""
-usePolyglotBook false
-polyglotBook ""
-bookDepth 12
-bookVariation 50
-discourageOwnBooks false
-defaultHashSize 64
-defaultCacheSizeEGTB 4
-defaultPathEGTB ""
-language ""
-usePieceFont false
-useBoardTexture true
-useBorder false
-border ""
-autoInstall "ALL"
-fixedSize false
-showMoveTime false
-pgnNumberTag false
-oneClickMove false
-defaultMatchGames 10
-matchPause 10000
-testClaims true
-checkMates true
-materialDraws true
-trivialDraws false
-ruleMoves 51
-repeatsToDraw 6
-backgroundObserve false
-dualBoard false
-smpCores 1
-egtFormats "syzygy:/EGT/Syzygy,scorpio:/EGT/bitbases"
-niceEngines 0
-logoSize 0
-logoDir "."
-autoLogo false
-featureDefaults ""
-showTargetSquares true
-absoluteAnalysisScores false
-scoreWhite false
-evalZoom 1
-evalThreshold 25
-pairingEngine ""
-defaultTourneyName "Tourney_%y%M%d_%h%m.trn"
-viewerOptions "-ncp -engineOutputUp false -saveSettingsOnExit false"
-tourneyOptions "-ncp -mm -saveSettingsOnExit false"
-autoCopyPV false
-topLevel true
-dialogColor ""
-buttonColor ""
-memoHeaders true
-messageSuppress "Right-clicking menu item or dialog text pops up help on it"
-analysisBell 0
-timeOddsMode 0
-keepLineBreaksICS false
-winWidth 589
-winHeight 696
-x 240
-y 171
-icsUp false
-icsX 2147483408
-icsY 2147483477
-icsW -2147483648
-icsH -2147483648
-commentX 588
-commentY 317
-commentW 254
-commentH 102
-tagsX 497
-tagsY 278
-tagsW 204
-tagsH 124
-gameListX 2147483408
-gameListY 2147483477
-gameListW 500
-gameListH 300
-slaveX 2147483408
-slaveY 2147483477
-moveHistoryUp true
-moveHistoryX 2326
-moveHistoryY -157
-moveHistoryW 624
-moveHistoryH 1008
-evalGraphUp true
-evalGraphX 2962
-evalGraphY -157
-evalGraphW 620
-evalGraphH 1008
-engineOutputUp false
-engineOutputX 493
-engineOutputY -71
-engineOutputW 504
-engineOutputH 305
#}}}
EOL

#}}}
fi
if [[ $aa18 -eq 1 ]]; then
#{{{ >>>   .tkremind
cat<<EOL> .tkremind
#{{{ >>> .tkremind
# TkRemind option file -- created automatically
# Mon Jun 05 14:14:31 AEST 2023
# Format of each line is 'key value' where 'key'
# specifies the option name, and 'value' is a
# *legal Tcl list element* specifying the option value.

# (0/1) If 1, TkRemind automatically closes pop-up reminders after a minute
AutoClose 1

# (0/1) If 1, TkRemind prompts you to confirm 'Quit' operation
ConfirmQuit 0

# (0/1) If 1, TkRemind deiconifies the calendar window when a reminder pops up
Deiconify 0

# (String) Specify command to edit a file.  %d is replaced with line number and %s with filename
Editor {emacs +%d %s}

# (String) Extra arguments when invoking remind
ExtraRemindArgs {}

# (0/1) If 1, feed the reminder to RunCmd on standard input (see RunCmd option)
FeedReminder 0

# (String) Specify an e-mail address to which reminders should be sent if the popup window is not manually dismissed
MailAddr {}

# (0/1) If 1, TkRemind beeps the terminal when a pop-up reminder appears
RingBell 1

# (String) If non-blank, run specified command when a pop-up reminder appears
RunCmd {}

# (String) IP address or host name of SMTP server to use for sending e-mail
SMTPServer 127.0.0.1

# (0/1) If 1, TkRemind shows all of today's non-timed reminders in a window at startup and when the date changes
ShowTodaysReminders 1

# (0/1) If 1, TkRemind starts up in the iconified state
StartIconified 0
#}}}
EOL

#}}}
fi
if [[ $aa19 -eq 1 ]]; then
#{{{ >>>   .reminder.md
cat<<EOL> .reminder.md
#{{{ >>> .reminder.md
REM:
####
	- guix
	- ask.vllm
	- 2.ask.vllm
	- gnome-boxes

LINKS:
######
	https://www.howtogeek.com/warp-ai-powered-linux-terminal/
	https://www.warp.dev/
	https://github.com/warpdotdev/






SCRIPTS:
########
	x gitkraken-amd64.deb
	x gnome-boxes.main.sh
	x gpt4all-installer-linux.run
	x guix-install.sh
	x i3.sh
	x illama-mistral.sh
	x iso.sh
	x lamp.sh
	x lc-mashpodder/install.sh
	x lux
	x main.qownnotes.sh
	x mini.sh
	x ollama.instaall.sh
	x player.sh
	x quicklinks.sh

transformers-cli



ID Age   Due  Description          Urg
-- ----- ---- -------------------- ----
 1 17h   4h   lime leaf bavarage + 8.72
 2 17h   4h   vimrc markdown +     8.72
 3 17h   4h   vm xp +              8.72

3 tasks
#}}}
EOL

#}}}
fi
if [[ $aa20 -eq 1 ]]; then
#{{{ >>>   .xinitrc
cat<<EOL> .xinitrc
#{{{ >>> .xinitrc
exec dwm
#}}}
EOL

#}}}
fi
if [[ $aa21 -eq 1 ]]; then
#{{{ >>>   .music.kdl
cat<<EOL> .music.kdl
#{{{ >>> .music.kdl
layout {
    cwd "/home/batan"
    tab name="Tab #1" focus=true hide_floating_panes=true {
        pane size=1 borderless=true {
            plugin location="zellij:tab-bar"
        }
        pane size="45%" split_direction="vertical" {
            pane command="cmus" size="50%" {
                start_suspended false
            }
            pane command="/home/batan/.local/pipx/venvs/castero/bin/python" size="50%" {
                args "/home/batan/.local/bin/castero"
                start_suspended false
            }
        }
        pane size="40%" split_direction="vertical" {
            pane command="" focus=true size="50%" {
                start_suspended false
            }
            pane size="50%"
        }
        pane command="cava" size="15%" {
            start_suspended false
        }
        pane size=2 borderless=true {
            plugin location="zellij:status-bar"
        }
    }
    new_tab_template {
        pane size=1 borderless=true {
            plugin location="zellij:tab-bar"
        }
        pane
        pane size=2 borderless=true {
            plugin location="zellij:status-bar"
        }
    }
    swap_tiled_layout name="vertical" {
        tab max_panes=5 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane split_direction="vertical" {
                    pane
                    pane {
                        children
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        tab max_panes=8 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane split_direction="vertical" {
                    pane {
                        children
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        tab max_panes=12 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane split_direction="vertical" {
                    pane {
                        children
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
    }
    swap_tiled_layout name="horizontal" {
        tab max_panes=5 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane
                pane
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        tab max_panes=8 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane {
                    pane split_direction="vertical" {
                        children
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        tab max_panes=12 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane {
                    pane split_direction="vertical" {
                        children
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
    }
    swap_tiled_layout name="stacked" {
        tab min_panes=5 {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            pane {
                pane split_direction="vertical" {
                    pane
                    pane stacked=true {
                        children
                    }
                }
            }
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
    }
    swap_floating_layout name="staggered" {
        floating_panes
    }
    swap_floating_layout name="enlarged" {
        floating_panes max_panes=10 {
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 1
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 2
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 3
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 4
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 5
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 6
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 7
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 8
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 9
            }
            pane focus=true {
                height "90%"
                width "90%"
                x 10
                y 10
            }
        }
    }
    swap_floating_layout name="spread" {
        floating_panes max_panes=1 {
            pane {
                x "50%"
                y "50%"
            }
        }
        floating_panes max_panes=2 {
            pane {
                width "45%"
                x "1%"
                y "25%"
            }
            pane {
                width "45%"
                x "50%"
                y "25%"
            }
        }
        floating_panes max_panes=3 {
            pane focus=true {
                height "45%"
                width "45%"
                y "55%"
            }
            pane {
                width "45%"
                x "1%"
                y "1%"
            }
            pane {
                width "45%"
                x "50%"
                y "1%"
            }
        }
        floating_panes max_panes=4 {
            pane {
                height "45%"
                width "45%"
                x "1%"
                y "55%"
            }
            pane focus=true {
                height "45%"
                width "45%"
                x "50%"
                y "55%"
            }
            pane {
                height "45%"
                width "45%"
                x "1%"
                y "1%"
            }
            pane {
                height "45%"
                width "45%"
                x "50%"
                y "1%"
            }
        }
    }
}
#}}}
EOL

#}}}
fi
if [[ $aa22 -eq 1 ]]; then
#{{{ >>>   .rainbow_oauth
cat<<EOL> .rainbow_oauth
#{{{ >>> .rainbow_oauth
1054641120137760769-UnP2gfZ04NcQj39JE172GJY4GHLNqD
8HzMygIFfecaLzNe4Hy0JRVp0nHlAWTRZqfEqSrThNwIr
#}}}
EOL

#}}}
fi
if [[ $aa23 -eq 1 ]]; then
#{{{ >>>   .bookmarks014.html
cat<<EOL> .bookmarks014.html
#{{{ >>> .bookmarks014.html
<!DOCTYPE NETSCAPE-Bookmark-file-1>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>

<DL><p>
    <DT><H3 ADD_DATE="1736813973" LAST_MODIFIED="1736813973" PERSONAL_TOOLBAR_FOLDER="true">buku bookmarks</H3>
    <DL><p>
        <DT><A HREF="https://support.mozilla.org/products/firefox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Get Help</A>
        <DT><A HREF="https://support.mozilla.org/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Customize Firefox</A>
        <DT><A HREF="https://www.mozilla.org/contribute/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Get Involved</A>
        <DT><A HREF="https://www.mozilla.org/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">About Us</A>
        <DT><A HREF="https://forum.mxlinux.org/viewtopic.php?t=55034" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">In the clouds with nextcloud over SSL--the easy way - MX Linux Forum</A>
        <DT><A HREF="https://github.com/nextcloud/all-in-one/blob/main/local-instance.md" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">all-in-one/local-instance.md at main Â· nextcloud/all-in-one Â· GitHub</A>
        <DT><A HREF="https://www.youtube.com/watch?v=zk-y2wVkY4c" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">EP 2 Deploy Defend Expose Nextcloud Uncomplicated Firewall Fail2ban Nginx Reverse Proxy Access Lists - YouTube</A>
        <DT><A HREF="https://www.howtogeek.com/devops/how-to-run-your-own-dns-server-on-your-local-network/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Run Your Own DNS Server on Your Local Network</A>
        <DT><A HREF="https://xhamster.com/pornstars/julia-butt" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Julia Butt Porn Videos 2024: Porn Star Sex Scenes | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/hot-misty-vonage-in-interracial-with-black-stud-lex-steele-xhMDCMi" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hot Misty Vonage in Interracial with Black Stud Lex Steele: Bikini Blowjob Porn | xHamster</A>
        <DT><A HREF="https://docs.vllm.ai/en/latest/models/supported_models.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Supported Models â vLLM</A>
        <DT><A HREF="https://github.com/vllm-project/vllm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - vllm-project/vllm: A high-throughput and memory-efficient inference and serving engine for LLMs</A>
        <DT><A HREF="https://hackernoon.com/quantizing-large-language-models-with-llamacpp-a-clean-guide-for-2024" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Quantizing Large Language Models With llama.cpp: A Clean Guide for 2024 | HackerNoon</A>
        <DT><A HREF="https://github.com/mickymultani/QuantizeLLMs?ref=hackernoon.com" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - mickymultani/QuantizeLLMs at hackernoon.com</A>
        <DT><A HREF="https://huggingface.co/collections/meta-llama/code-llama-family-661da32d0a9d678b6f55b933" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Code Llama Family - a meta-llama Collection</A>
        <DT><A HREF="https://news.ycombinator.com/item?id=37248494" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Code Llama, a state-of-the-art large language model for coding | Hacker News</A>
        <DT><A HREF="https://www.snowflake.com/en/blog/meta-code-llama-testing/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Meta Code Llama on Snowflake Testing | Blog</A>
        <DT><A HREF="http://localhost:11434/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Problem loading page</A>
        <DT><A HREF="https://duckduckgo.com/?q=llama+vllm&t=ffab&ia=web" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">llama vllm at DuckDuckGo</A>
        <DT><A HREF="https://docs.vllm.ai/en/latest/serving/serving_with_llamastack.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Serving with Llama Stack â vLLM</A>
        <DT><A HREF="https://medium.com/@yevhen.herasimov/serving-llama3-8b-on-cpu-using-vllm-d41e3f1731f7" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Effortlessly Serve Llama3 8B on CPU with vLLM: A Step-by-Step Guide | by Yevhen Herasimov | Medium</A>
        <DT><A HREF="https://www.reddit.com/r/LocalLLaMA/comments/1bxfms3/favorite_model_for_coding/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Favorite model for coding? : r/LocalLLaMA</A>
        <DT><A HREF="https://huggingface.co/spaces/bigcode/bigcode-models-leaderboard" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Big Code Models Leaderboard - a Hugging Face Space by bigcode</A>
        <DT><A HREF="https://dvynsh.org/blog/2024/llm-quantization/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">dvynsh.org</A>
        <DT><A HREF="https://ai.meta.com/blog/meta-llama-quantized-lightweight-models/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Introducing quantized Llama models with increased speed and a reduced memory footprint</A>
        <DT><A HREF="https://www.llama.com/docs/community-support-and-resources" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Community Support and Resources</A>
        <DT><A HREF="https://www.llama.com/docs/llama-everywhere/running-meta-llama-on-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Running Meta Llama on Linux | Llama Everywhere</A>
        <DT><A HREF="https://www.llama.com/docs/integration-guides/meta-code-llama/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Code Llama | Integration guides</A>
        <DT><A HREF="https://www.llama.com/docs/integration-guides/langchain/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">LangChain | Integration guides</A>
        <DT><A HREF="https://www.llama.com/docs/integration-guides/llamaindex/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">LlamaIndex | Integration guides</A>
        <DT><A HREF="https://github.com/meta-llama/llama-recipes" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - meta-llama/llama-recipes: Scripts for fine-tuning Meta Llama with composable FSDP & PEFT methods to cover single/multi-node GPUs. Supports default & custom datasets for applications such as summarization and Q&A. Supporting a number of candid inference solutions such as HF TGI, VLLM for local or cloud deployment. Demo apps to showcase Meta Llama for WhatsApp & Messenger.</A>
        <DT><A HREF="https://github.com/meta-llama" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Meta Llama Â· GitHub</A>
        <DT><A HREF="https://huggingface.co/collections/meta-llama/llama-32-66f448ffc8c32f949b04c8cf" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Llama 3.2 - a meta-llama Collection</A>
        <DT><A HREF="https://huggingface.co/meta-llama/Llama-3.2-1B-Instruct-QLORA_INT4_EO8" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">meta-llama/Llama-3.2-1B-Instruct-QLORA_INT4_EO8 Â· Hugging Face</A>
        <DT><A HREF="https://github.com/pytorch/executorch" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - pytorch/executorch: On-device AI across mobile, embedded and edge for PyTorch</A>
        <DT><A HREF="https://anaconda.org/conda-forge/transformers" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Transformers | Anaconda.org</A>
        <DT><A HREF="https://www.restack.io/p/transformers-knowledge-transformers-cli-answer-cat-ai" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Transformers Cli Overview | Restackio</A>
        <DT><A HREF="https://huggingface.co/docs/huggingface_hub/main/en/guides/cli" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Command Line Interface (CLI)</A>
        <DT><A HREF="https://huggingface.co/blog/codellama" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Code Llama: Llama 2 learns to code</A>
        <DT><A HREF="https://github.com/meta-llama/llama-stack/tree/main/llama_stack/providers/inline/inference/vllm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">llama-stack/llama_stack/providers/inline/inference/vllm at main Â· meta-llama/llama-stack Â· GitHub</A>
        <DT><A HREF="https://llama-stack.readthedocs.io/en/latest/distributions/self_hosted_distro/remote-vllm.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Remote vLLM Distribution â llama-stack documentation</A>
        <DT><A HREF="https://github.com/meta-llama/llama-stack" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - meta-llama/llama-stack: Composable building blocks to build Llama Apps</A>
        <DT><A HREF="https://huggingface.co/lmsys/vicuna-7b-v1.1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">lmsys/vicuna-7b-v1.1 Â· Hugging Face</A>
        <DT><A HREF="https://github.com/vicuna-tools/vicuna-installation-guide/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - vicuna-tools/vicuna-installation-guide: The "vicuna-installation-guide" provides step-by-step instructions for installing and configuring Vicuna 13 and 7B</A>
        <DT><A HREF="https://huggingface.co/settings/tokens/new?tokenType=fineGrained" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hugging Face â The AI community building the future.</A>
        <DT><A HREF="https://github.com/vllm-project/vllm/blob/main/examples/offline_inference_openai.md" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vllm/examples/offline_inference_openai.md at main Â· vllm-project/vllm Â· GitHub</A>
        <DT><A HREF="https://github.com/vllm-project/vllm/blob/main/tests/tool_use/utils.py" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vllm/tests/tool_use/utils.py at main Â· vllm-project/vllm Â· GitHub</A>
        <DT><A HREF="https://docs.vllm.ai/en/latest/quantization/gguf.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GGUF â vLLM</A>
        <DT><A HREF="https://huggingface.co/PrunaAI/codellama-CodeLlama-7b-Instruct-hf-bnb-4bit-smashed" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">PrunaAI/codellama-CodeLlama-7b-Instruct-hf-bnb-4bit-smashed Â· Hugging Face</A>
        <DT><A HREF="https://huggingface.co/QuantFactory/CodeLlama-7b-Instruct-hf-GGUF" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">QuantFactory/CodeLlama-7b-Instruct-hf-GGUF Â· Hugging Face</A>
        <DT><A HREF="https://xhamster.com/pornstars/raquel-sultra" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Raquel Sultra Porn Videos 2024: Porn Star Sex Scenes | xHamster</A>
        <DT><A HREF="https://www.howtogeek.com/warp-ai-powered-linux-terminal/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">I Tried Out an AI-Powered Linux Terminal, Hereâs How It Went</A>
        <DT><A HREF="https://github.com/warpdotdev/Warp" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - warpdotdev/Warp: Warp is a modern, Rust-based terminal with AI built in so you and your team can build great software, faster.</A>
        <DT><A HREF="https://github.com/Tomas-M/linux-live" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Tomas-M/linux-live: Linux Live Kit</A>
        <DT><A HREF="https://txxx.com/videos/16545095/the-misty-luv-interview-just-the-truth-no-lies-misty-luv-50plusmilfs/?fr=18966475&rp=1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Misty Luv Interview: Just the truth, no lies - Misty Luv - 50PlusMILFs - Porn video | TXXX.com</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/1767393/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile olderthebetter</A>
        <DT><A HREF="https://www.ashemaletube.com/videos/1057833/some-compilation/?utm_source=awn&utm_medium=tgp&utm_campaign=cpc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Some compilation - aShemaletube.com</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/2062427/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile yebome5127</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/504088/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile Pepe_trueno</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/2280800/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile huuukkk</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/1767393/?page=2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile olderthebetter</A>
        <DT><A HREF="https://www.tgtube.com/search/thai%20trans%20compilation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">thai trans compilation Tube | Trans Porn Videos | TGTube.com</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/2825879/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile syberwolf</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/2681508/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile Lets Play</A>
        <DT><A HREF="https://www.ashemaletube.com/videos/1058595/theprettiest4n-beautiful-ts/?utm_source=awn&utm_medium=tgp&utm_campaign=cpc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Theprettiest4n : Beautiful TS - aShemaletube.com</A>
        <DT><A HREF="https://www.fulltrannytube.com/view/1728930-traps-compilation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Traps Compilation at Full Tranny Tube</A>
        <DT><A HREF="http://www.debian.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Debian.org</A>
        <DT><A HREF="http://www.debian.org/News/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Latest News</A>
        <DT><A HREF="http://www.debian.org/support" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Help</A>
        <DT><A HREF="https://chromewebstore.google.com/detail/justclip-web-clipper/olejfcpiodohggkokfkaecelidkbdpal" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">JustClip Web Clipper</A>
        <DT><A HREF="https://chromewebstore.google.com/detail/time-tracking-tool-clockl/elmbgaiepbblgglhkidcfejoiffeecmb" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Time tracking tool - Clockly by 500apps</A>
        <DT><A HREF="https://www.mozilla.org/firefox/?utm_medium=firefox-desktop&utm_source=bookmarks-toolbar&utm_campaign=new-users&utm_content=-global" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Getting Started</A>
        <DT><A HREF="https://www.mozilla.org/en-US/contribute/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">Volunteer Opportunities at Mozilla â Mozilla</A>
        <DT><A HREF="https://support.mozilla.org/en-US/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Customize Firefox controls, buttons and toolbars | Firefox Help</A>
        <DT><A HREF="https://tomordonez.com/taskwarrior-task-management/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug26,2023oct08,2023sep26,buku bookmarks">TaskWarrior Task Management | Tom Ordonez</A>
        <DT><A HREF="https://taskwarrior.org/docs/workflow/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+task,2023aug26,2023oct08,2023sep26,buku bookmarks">Taskwarrior - Workflow Examples - Taskwarrior</A>
        <DT><A HREF="https://github.com/jschlatow/taskopen" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+task,2023aug26,2023oct08,2023sep26,buku bookmarks">GitHub - jschlatow/taskopen: Tool for taking notes and open urls with taskwarrior</A>
        <DT><A HREF="https://www.cyberciti.biz/faq/debian-linux-wpa-wpa2-wireless-wifi-networking/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cyber City - wireless networking</A>
        <DT><A HREF="https://bbs.archlinux.org/viewtopic.php?id=243226" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">[SOLVED] grub-install: error: failed to get canonical path of `/efiÂ´. / Installation / Arch Linux Forums</A>
        <DT><A HREF="https://techtippr.com/userscripts-for-chrome-and-firefox/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">10 Best User Scripts You Can Install on Chrome or Firefox Browser to Enhance Browsing Experience</A>
        <DT><A HREF="https://www.golinuxcloud.com/tmux-config/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">10 practical examples of tmux configuration with examples | GoLinuxCloud</A>
        <DT><A HREF="https://www.redhat.com/sysadmin/learn-bash-scripting" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">13 resources for learning to write better Bash code | Enable Sysadmin</A>
        <DT><A HREF="https://www.hostinger.com/tutorials/bash-script-example" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">25 Easy Bash Script Examples To Get You Started</A>
        <DT><A HREF="https://proprivacy.com/privacy-service/comparison/private-search-engines" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">5 Best Private Search Engines in 2023 | Browse anonymously</A>
        <DT><A HREF="https://www.makeuseof.com/tag/7-cool-html-effects-that-anyone-can-add-to-their-website-nb/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">8 Cool HTML Effects Anyone Can Add to Their Websites</A>
        <DT><A HREF="https://www.howtogeek.com/815778/bash-for-loops-examples/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">9 Examples of for Loops in Linux Bash Scripts</A>
        <DT><A HREF="https://seniormars.github.io/posts/neomutt/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">A Terminal Email Client As An Alternative To Gmail: The Old Dog Neomutt</A>
        <DT><A HREF="https://stackoverflow.com/questions/51142253/add-python-support-to-vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">add python support to vim - Stack Overflow</A>
        <DT><A HREF="https://searx.github.io/searx/admin/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Administrator documentation â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://globe.adsbexchange.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">ADS-B Exchange - track aircraft live</A>
        <DT><A HREF="https://www.radarbox.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">AirNav RadarBox - Global Flight Tracking Intelligence | Live Flight Tracker and Airport Status</A>
        <DT><A HREF="https://www.airportia.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Airportia</A>
        <DT><A HREF="https://azero.dev/#/accounts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Aleph Zero/Substrate Portal</A>
        <DT><A HREF="https://coingolive.com/en/coin/ath-price/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">All-Time High (ATH) - Cryptocurrency Price List | CoinGoLive</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Main_Page" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Alpine Linux</A>
        <DT><A HREF="https://am.i.mullvad.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Am I Mullvad?</A>
        <DT><A HREF="https://www.amiunique.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">AmIUnique</A>
        <DT><A HREF="https://godex.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Anonymous Crypto Exchange - Godex.io</A>
        <DT><A HREF="https://anonfiles.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Anonymous File Upload - AnonFiles</A>
        <DT><A HREF="https://wiki.archlinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ArchWiki</A>
        <DT><A HREF="https://athcoinindex.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ATH price and market cap of cryptocurrencies | AthCoinIndex</A>
        <DT><A HREF="https://zer1t0.gitlab.io/posts/attacking_ad/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Attacking Active Directory: 0 to 0.9 | zer1t0</A>
        <DT><A HREF="https://linuxhandbook.com/bash-automation/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Automating Tasks With Bash Scripts [Practical Examples]</A>
        <DT><A HREF="https://blog.kyleavery.com/posts/avoiding-memory-scanners/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Avoiding Memory Scanners - Kyle Avery</A>
        <DT><A HREF="https://serverfault.com/questions/629778/which-open-source-program-is-similar-to-the-linux-dialog-command" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">bash - Which open source program is similar to the Linux "dialog" command? - Server Fault</A>
        <DT><A HREF="https://stackoverflow.com/questions/25929369/which-open-source-program-is-similar-to-the-linux-dialog-command" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">bash - Which open source program is similar to the Linux "dialog" command? - Stack Overflow</A>
        <DT><A HREF="https://linuxconfig.org/tag/bash" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">bash Archives - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://stackoverflow.com/questions/42371156/bash-dialog-inputbox-with-variable-entered" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">bash dialog inputbox with variable entered - Stack Overflow</A>
        <DT><A HREF="https://linuxconfig.org/bash-scripting-tutorial-for-beginners" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bash Scripting Tutorial for Beginners - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://academy.hackthebox.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Best Online Cybersecurity Courses & Certifications | HTB Academy</A>
        <DT><A HREF="https://www.privacytools.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Best Privacy Tools & Software Guide in in 2023</A>
        <DT><A HREF="https://bigbear.cx/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">BigBear Escrow | Need a privacy escrow? We got your back!</A>
        <DT><A HREF="https://www.binance.com/en" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Binance - Cryptocurrency Exchange for Bitcoin, Ethereum & Altcoins</A>
        <DT><A HREF="https://iancoleman.io/bip39/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">BIP39 - Mnemonic Code</A>
        <DT><A HREF="https://www.bitaddress.org/bitaddress.org-v3.3.0-SHA256-dec17c07685e1870960903d8f58090475b25af946fe95a734f88408cef4aa194.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">bitaddress.org</A>
        <DT><A HREF="https://bitinfocharts.com/bitcoin/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin (BTC) statistics - Price, Blocks Count, Difficulty, Hashrate, Value</A>
        <DT><A HREF="https://www.blockonomics.co/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Address | Wallet Lookup - Blockonomics</A>
        <DT><A HREF="https://kimbatt.github.io/btc-address-generator/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin address generator</A>
        <DT><A HREF="https://www.bitcoinwhoswho.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Address Lookup, Checker and Scam Reports - BitcoinWhosWho</A>
        <DT><A HREF="https://www.oulnilbdywxzdcchh5ne2hv24hfu76ealb5y6uibnclw3jjromboxhad.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Escrow - Onion</A>
        <DT><A HREF="https://escaroo.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Escaroo</A>
        <DT><A HREF="https://btcsniffer.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Explorer - Search the Blockchain | BTC | ETH | BCH</A>
        <DT><A HREF="https://bitcoin-mix.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Mixer (Tumbler). Bitcoin Blender.</A>
        <DT><A HREF="https://mixer.money/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin mixer 2.0 | Mixer money - get clean coins from stock exchanges.</A>
        <DT><A HREF="https://threatmap.bitdefender.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitdefender Threat Map</A>
        <DT><A HREF="https://bitly.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">URL Shortener - Short URLs & Custom Free Link Shortener | Bitly</A>
        <DT><A HREF="https://www.bitstamp.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitstamp</A>
        <DT><A HREF="https://blocktivity.info/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Home - Block'tivity</A>
        <DT><A HREF="https://www.blockchain.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blockchain.com | Be early to the future of finance</A>
        <DT><A HREF="https://www.elliptic.co/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blockchain Analytics & Crypto Compliance Solutions | Elliptic</A>
        <DT><A HREF="https://blockchaingroup.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blockchain Analysis, Compliance | Blockchain Intelligence Group</A>
        <DT><A HREF="https://txstreet.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blockchain Transaction Visualizer - TxStreet.com</A>
        <DT><A HREF="https://www.blackhillsinfosec.com/blog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blog - Black Hills Information Security</A>
        <DT><A HREF="https://samcurry.net/blog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blog | Sam Curry</A>
        <DT><A HREF="https://bloxy.info/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bloxy</A>
        <DT><A HREF="https://community.blueliv.com/map/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Blueliv - Cyber Threat Map</A>
        <DT><A HREF="https://tenta.com/test/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Browser Privacy - Test IP address, DNS, VPN leaks. Fast & no ads. Protect your online privacy.</A>
        <DT><A HREF="https://browserleaks.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Browserleaks - Check your browser for privacy leaks</A>
        <DT><A HREF="https://ux.stackexchange.com/questions/120001/alternatives-to-modal-dialog-for-simple-forms" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">buttons - Alternatives to modal dialog for simple forms - User Experience Stack Exchange</A>
        <DT><A HREF="https://www.bybit.com/en-US/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bybit | Cryptocurrency Trading Platform</A>
        <DT><A HREF="https://browserleaks.com/canvas" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Canvas Fingerprinting - BrowserLeaks</A>
        <DT><A HREF="https://search.censys.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Censys Search</A>
        <DT><A HREF="https://www.certik.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Web3 Security Leaderboard</A>
        <DT><A HREF="https://cezex.io/#/price-all" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Casino Liste âï¸ Online Casinos mit KryptowÃ¤hrung</A>
        <DT><A HREF="https://chainz.cryptoid.info/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Chainz - Crypto-currency Blockchains</A>
        <DT><A HREF="https://changenow.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Swap & Purchase | Best Rates & Lowest Fees | ChangeNOW</A>
        <DT><A HREF="https://torguard.net/checkmytorrentipaddress.php?hash=65fd3f647d2a679bdc4ad2e47bbda2b1043eaba2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Check My Torrent IP | Proxy & VPN Verification | TorGuard</A>
        <DT><A HREF="https://check.torproject.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Sorry. You are not using Tor.</A>
        <DT><A HREF="https://chess.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Chess.com - Play Chess Online - Free Games</A>
        <DT><A HREF="https://www.chess.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Chess.com - Play Chess Online - Free Games</A>
        <DT><A HREF="https://gist.github.com/DataSherlock/58e6285dbd11cbba9d29b32c5480521d" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ChessPGNParser.py Â· GitHub</A>
        <DT><A HREF="https://ciphertrace.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency intelligence and blockchain analytics - Ciphertrace</A>
        <DT><A HREF="https://randomgeekery.org/post/2021/05/cli-journaling-in-joplin-with-raku/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CLI Journaling in Joplin with Raku | Post | Random Geekery</A>
        <DT><A HREF="https://www.coinfirm.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Coinfirm - Blockchain Analytics</A>
        <DT><A HREF="https://coinmarketcal.com/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CoinMarketCal - Cryptoasset Calendar</A>
        <DT><A HREF="https://www.parrotsec.org/community" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Community</A>
        <DT><A HREF="https://discordapp.com/invite/KEFErEx" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Discord</A>
        <DT><A HREF="https://www.guru99.com/data-communication-computer-network-tutorial.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Computer Network Tutorial for Beginners</A>
        <DT><A HREF="https://www.softwaretestinghelp.com/computer-networking-basics/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Computer Networking Tutorial: The Ultimate Guide</A>
        <DT><A HREF="https://www.ohchr.org/en/instruments-mechanisms/instruments/convention-against-torture-and-other-cruel-inhuman-or-degrading" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Convention against Torture and Other Cruel, Inhuman or Degrading Treatment or Punishment | OHCHR</A>
        <DT><A HREF="https://duckduckgo.com/?q=copy+from+ssh+client+to+host" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">copy from ssh client to host at DuckDuckGo</A>
        <DT><A HREF="https://coveryourtracks.eff.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cover Your Tracks</A>
        <DT><A HREF="https://blog.self.li/post/74294988486/creating-a-post-installation-script-for-ubuntu" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Creating a post-installation script for Ubuntu | self.li - blog by Peter Legierski</A>
        <DT><A HREF="https://cassidy.codes/blog/2019-08-03-tmux-colour-theme/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Creating a tmux Colour Theme Â· Cassidy Scheffer</A>
        <DT><A HREF="https://www.geeksforgeeks.org/creating-dialog-boxes-with-the-dialog-tool-in-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Creating dialog boxes with the Dialog Tool in Linux - GeeksforGeeks</A>
        <DT><A HREF="https://cryptobubbles.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Bubbles | Interactive bubble chart for crypto currencies</A>
        <DT><A HREF="https://coincodex.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Prices, Charts and Cryptocurrency Market Cap | CoinCodex</A>
        <DT><A HREF="https://messari.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Research, Data, and Tools | Messari</A>
        <DT><A HREF="https://cryptocoin.cc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The domain name cryptocoin.cc is for sale</A>
        <DT><A HREF="https://www.cryptocompare.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency Prices, Portfolio, Forum, Rankings | CryptoCompare.com</A>
        <DT><A HREF="https://walletinvestor.com/converter" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency Calculator & Converter - WalletInvestor.com</A>
        <DT><A HREF="https://www.marketcapof.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MarketCapOf | Crypto & Stocks Market Cap Calculator</A>
        <DT><A HREF="https://coinmarketcap.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency Prices, Charts And Market Capitalizations | CoinMarketCap</A>
        <DT><A HREF="https://www.coingecko.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency Prices, Charts, and Crypto Market Cap | CoinGecko</A>
        <DT><A HREF="https://cryptorank.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptocurrency prices, Token rates and Altcoin charts ranked by Market Capitalization and Volume | CryptoRank.io</A>
        <DT><A HREF="https://cryptomixer.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CryptoMixer.io â the Fast, Secure and Reliable High Volume Bitcoin Mixer!</A>
        <DT><A HREF="https://cryptowat.ch/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cryptowatch | Bitcoin (BTC) Live Price Charts, Trading, and Alerts</A>
        <DT><A HREF="https://crypt.parrot.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CryptPad: Collaboration suite, encrypted and open-source</A>
        <DT><A HREF="https://crystalblockchain.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crystal Blockchain Analytics for Crypto Compliance</A>
        <DT><A HREF="https://www.geeksforgeeks.org/custom-commands-linux-terminal/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Custom commands for linux terminal - GeeksforGeeks</A>
        <DT><A HREF="https://github.com/jarun/buku/wiki/Customize-colors" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Customize colors Â· jarun/buku Wiki Â· GitHub</A>
        <DT><A HREF="https://www.cvedetails.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CVE security vulnerability database. Security vulnerabilities, exploits, references and more</A>
        <DT><A HREF="https://talosintelligence.com/fullpage_maps/pulse?__cf_chl_jschl_tk__=d8606de8e8d992f81979cff17898eac51835e80e-1615699239-0-AS8Ebf8Q8sHMWu1iKhC-l6hylqTP1PExnMqVp9OMbXnjXXGe4PwnTbDXfluWlzgEe5tW02keOWjQvDQzcJSv_0HMH9_cGhJd13AW9coDbCFA2jVzAvTEZzTe3KZm84D38oDN_kV1emLlyXZrDSJWU9R8sR4o5u9StkTIFyKzMYlPP7pdwDT4zUZmQEfyjFNsZIVzgK6RXyOwwyAYDJDZMFYBIc3n8dqV2ngGJxdUUQVn4cNw5KMWvANY3rg5Rq-BB4GM_WOOwAbqAPwWKnMEl6EWsPzHF-6lvXojUYyPlzZ1vq3I43DbDFQ2_JLxXWoNr3-A40GW287DtWRIfOy_VhF6TgDwv3LCQ1H0R2q7CSw9CLn1GBEk1lOakNH41FGjTPPWhaKviE8x1y9NyDCPok4tnKhqiqKDVxd4gt40Vr1i" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cyber Attack Map - Cisco Talos</A>
        <DT><A HREF="https://www.hackthebox.com/hacker/infosec-careers" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cybersecurity Jobs & Careers. Stand Out To Recruiters With HTB</A>
        <DT><A HREF="https://cointool.app/dashboard" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">CoinTool</A>
        <DT><A HREF="https://www.debian.org/doc/user-manuals#debian-handbook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Debian -- Debian Users' Manuals</A>
        <DT><A HREF="https://www.debian.org/doc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Debian -- Documentation</A>
        <DT><A HREF="https://www.deepl.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DeepL Translate: The world's most accurate translator</A>
        <DT><A HREF="https://www.deepl.com/translator" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DeepL Translate: The world's most accurate translator</A>
        <DT><A HREF="https://defillama.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DefiLlama - DeFi Dashboard</A>
        <DT><A HREF="https://vimeo.com/user1690209" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Derek Wyatt</A>
        <DT><A HREF="https://wallet.dero.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DERO Stargate Web Wallet</A>
        <DT><A HREF="https://www.dexlab.space/mintinglab/spl-token" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Dexlab | The best DEX platform on SOLANA.</A>
        <DT><A HREF="https://invisible-island.net/dialog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DIALOG â Script-driven curses widgets</A>
        <DT><A HREF="https://alternativeto.net/software/dialog/?platform=linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">dialog Alternatives for Linux: Top 10 Shells and similar apps | AlternativeTo</A>
        <DT><A HREF="https://www.digitalattackmap.com/#anim=1&color=0&country=ALL&list=0&time=18205&view=map" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Digital Attack Map</A>
        <DT><A HREF="https://www.hxuzjtocnzvv5g2rtg2bhwkcbupmk7rclb6lly3fo4tvqkk5oyrv3nid.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DNMX - Onion</A>
        <DT><A HREF="https://www.top10vpn.com/tools/do-i-leak/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Do I Leak? IP, WebRTC & DNS Leak Test | VPN & Torrent IP Check</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Dualbooting" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Dualbooting - Alpine Linux</A>
        <DT><A HREF="https://duckduckgo.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DuckDuckGo â Privacy, simplified.</A>
        <DT><A HREF="https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">DuckDuckGo - Onion</A>
        <DT><A HREF="https://www.earthcam.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">EarthCam - Webcam Network</A>
        <DT><A HREF="https://alternativeto.net/software/easybashgui/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">easybashgui: App Reviews, Features, Pricing & Download | AlternativeTo</A>
        <DT><A HREF="https://easyos.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">EasyOS Home â All categories</A>
        <DT><A HREF="https://www.digi77.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Eagle Eye | Nonprofit Organization | Stay Secured, Stay Assured</A>
        <DT><A HREF="https://www.youtube.com/watch?v=stqUbv-5u2s" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Effective Neovim: Instant IDE - YouTube</A>
        <DT><A HREF="https://eff.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Electronic Frontier Foundation | Defending your rights in the digital world</A>
        <DT><A HREF="https://emailselfdefense.fsf.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Email Self-Defense - a guide to fighting surveillance with GnuPG encryption</A>
        <DT><A HREF="https://www.youtube.com/watch?v=fGQvXNlosTc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Embrace The Power of GUIs With Yet Another Dialog - YouTube</A>
        <DT><A HREF="https://escrow.counos.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Escrow Counos | Buy or Sell with OTC Crypto</A>
        <DT><A HREF="https://www.etherchain.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Open Source Ethereum Blockchain Explorer - beaconcha.in - 2023</A>
        <DT><A HREF="https://ether-mixer.org/start-mixing.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Ethereum Mixer</A>
        <DT><A HREF="https://thecoinperspective.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Coin Perspective</A>
        <DT><A HREF="https://ethos-source.github.io/bip39-web-tool/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Ethos BIP39 Web Tool</A>
        <DT><A HREF="https://ethplorer.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Ethereum explorer â Ethplorer. ETH tokens explore 2023</A>
        <DT><A HREF="https://explainshell.com/explain?cmd=pandoc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">explainshell.com - pandoc</A>
        <DT><A HREF="https://www.exploit-db.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Exploit Database - Exploits for Penetration Testers, Researchers, and Ethical Hackers</A>
        <DT><A HREF="https://cxsecurity.com/exploit/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Exploit Database - Site 1</A>
        <DT><A HREF="https://exploit.education/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Exploit Education :: Andrew Griffiths' Exploit Education</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/39627/export-libreoffice-thesaurus-to-vim-compatible-format-with-a-macro" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Export Libreoffice Thesaurus to Vim compatible format with a macro? - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://filen.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Filen â Next Generation End-To-End Encrypted Cloud Storage</A>
        <DT><A HREF="https://www.filterbypass.me/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">FilterBypass.me - Fastest Free Anonymous Web Proxy</A>
        <DT><A HREF="https://hunter.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Find email addresses in seconds â¢ Hunter (Email Hunter)</A>
        <DT><A HREF="https://www.fireeye.com/cyber-map/threat-map.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">FireEye Cyber Threat Map</A>
        <DT><A HREF="https://stackoverflow.com/questions/946189/how-can-i-set-default-homepage-in-ff-and-chrome-via-javascript" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">firefox - How can I set default homepage in FF and Chrome via javascript? - Stack Overflow</A>
        <DT><A HREF="https://support.mozilla.org/en-US/products/firefox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Firefox Help</A>
        <DT><A HREF="https://wiki.mozilla.org/Firefox/CommandLineOptions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Firefox/CommandLineOptions - MozillaWiki</A>
        <DT><A HREF="https://www.fisgonia.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">fisgonia</A>
        <DT><A HREF="https://fixedfloat.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">FixedFloat | Instant cryptocurrency exchange</A>
        <DT><A HREF="https://www.flippening.watch/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Flippening Watch [ETH vs BTC Tracker]</A>
        <DT><A HREF="https://threatmap.fortiguard.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Fortinet Threat Map</A>
        <DT><A HREF="https://freecomputerbooks.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Free Computer, Programming, Mathematics, Technical Books, Lecture Notes and Tutorials</A>
        <DT><A HREF="https://www.tandfonline.com/doi/full/10.1080/14753634.2013.778485" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Full article: Losing trust in the world: Humiliation and its consequences</A>
        <DT><A HREF="https://learn.go.dev/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Get Started - The Go Programming Language</A>
        <DT><A HREF="https://go.dev/learn/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Get Started - The Go Programming Language</A>
        <DT><A HREF="https://ghostbin.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Ghostbin</A>
        <DT><A HREF="https://github.com/0xRadi/OWASP-Web-Checklist" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - 0xRadi/OWASP-Web-Checklist: OWASP Web Application Security Testing Checklist</A>
        <DT><A HREF="https://github.com/ashemery/exploitation-course" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - ashemery/exploitation-course: Offensive Software Exploitation Course</A>
        <DT><A HREF="https://github.com/awesome-lists/awesome-bash" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - awesome-lists/awesome-bash: A curated list of delightful Bash scripts and resources.</A>
        <DT><A HREF="https://github.com/cshum/scm-music-player.git" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - cshum/scm-music-player: Seamless music for your website. HTML5 music player with continuous playback cross pages.</A>
        <DT><A HREF="https://github.com/Cyclenerd/postinstall" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - Cyclenerd/postinstall: ð» Bash Script to automate post-installation steps</A>
        <DT><A HREF="https://github.com/dadyarri/dotfiles" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - dadyarri/dotfiles: Dotfiles for some programs i use in my daily work on Fedora Linux</A>
        <DT><A HREF="https://github.com/enaqx/awesome-pentest" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - enaqx/awesome-pentest: A collection of awesome penetration testing resources, tools and other shiny things</A>
        <DT><A HREF="https://github.com/FiloSottile/mkcert" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - FiloSottile/mkcert: A simple zero-config tool to make locally trusted development certificates with any names you'd like.</A>
        <DT><A HREF="https://github.com/kevinstadler/taskwarrior-vit-config" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - kevinstadler/taskwarrior-vit-config: a taskwarrior - vit - vimwiki pipeline</A>
        <DT><A HREF="https://github.com/Konfekt/vim-thesauri" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - Konfekt/vim-thesauri: A couple of thesaurus files for Vim synomym completion</A>
        <DT><A HREF="https://github.com/kraxli/vimwiki-task" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - kraxli/vimwiki-task: an addon for vimwiki to manage task and todo lists</A>
        <DT><A HREF="https://github.com/neovim/pynvim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - neovim/pynvim: Python client and plugin host for Nvim</A>
        <DT><A HREF="https://github.com/Okazari/Rythm.js.git" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - Okazari/Rythm.js: A javascript library that makes your page dance.</A>
        <DT><A HREF="https://github.com/rafi/awesome-vim-colorschemes" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - rafi/awesome-vim-colorschemes: Collection of awesome color schemes for Neo/vim, merged for quick use.</A>
        <DT><A HREF="https://github.com/RPISEC/MBE" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - RPISEC/MBE: Course materials for Modern Binary Exploitation by RPISEC</A>
        <DT><A HREF="https://github.com/sbilly/awesome-security" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - sbilly/awesome-security: A collection of awesome software, libraries, documents, books, resources and cools stuffs about security.</A>
        <DT><A HREF="https://github.com/seebi/tmux-colors-solarized" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - seebi/tmux-colors-solarized: A color theme for the tmux terminal multiplexer using Ethan Schoonoverâs Solarized color scheme</A>
        <DT><A HREF="https://github.com/serversideup/amplitudejs.git" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - serversideup/amplitudejs: AmplitudeJS: Open Source HTML5 Web Audio Library. Design your web audio player, the way you want. No dependencies required.</A>
        <DT><A HREF="https://github.com/teranex/vimwiki-tasks" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - teranex/vimwiki-tasks: A Vim plugin to integrate Vimwiki tasks with taskwarrior. Sync tasks between vimwiki and taskwarrior in both directions</A>
        <DT><A HREF="https://github.com/tools-life/taskwiki#viewports" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - tools-life/taskwiki: Proper project management with Taskwarrior in vim.</A>
        <DT><A HREF="https://github.com/vim-awesome/vim-awesome" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub - vim-awesome/vim-awesome: Awesome Vim plugins from across the universe</A>
        <DT><A HREF="https://github.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GitHub: Letâs build from here Â· GitHub</A>
        <DT><A HREF="https://www.givero.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Givero - Search the web to raise money for good causes.</A>
        <DT><A HREF="https://gnupg.org/documentation/howtos.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GnuPG - HOWTOs</A>
        <DT><A HREF="https://goo.gl/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Google URL Shortener</A>
        <DT><A HREF="https://www.pornhub.com/view_video.php?viewkey=ph62521972b9fd2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Got Playful with a Cream - Pornhub.com</A>
        <DT><A HREF="https://viz.greynoise.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GreyNoise Visualizer</A>
        <DT><A HREF="https://gtfobins.github.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">GTFOBins</A>
        <DT><A HREF="https://forum.hackthebox.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hack The Box :: Forums</A>
        <DT><A HREF="https://www.hackthebox.com/blog" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hack The Box Blog | Cybersecurity & Hacking News</A>
        <DT><A HREF="https://help.hackthebox.com/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hack The Box Help Center</A>
        <DT><A HREF="https://www.hackthebox.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hack The Box: Hacking Training For The Best | Individuals & Companies</A>
        <DT><A HREF="https://www.hackthebox.com/hacker/hacking-labs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hacking Labs | Virtual Hacking & Pentesting Labs (Upskill Fast)</A>
        <DT><A HREF="https://www.youtube.com/watch?v=z4WN0sHLUWU" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hacking with Parrot Security OS - YouTube</A>
        <DT><A HREF="https://humanrights.gov.au/quick-guide/12040" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Harassment | Australian Human Rights Commission</A>
        <DT><A HREF="https://vault.havenprotocol.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Haven Protocol â Private Money</A>
        <DT><A HREF="https://hide.me/en/proxy" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Fastest Free Proxy | hide.me</A>
        <DT><A HREF="https://linuxjourney.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Home | Linux Journey</A>
        <DT><A HREF="https://s3cur3th1ssh1t.github.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Home | S3cur3Th1sSh1t</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Hosting_Web/Email_services_on_Alpine" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Hosting Web/Email services on Alpine - Alpine Linux</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/7656/how-do-i-get-multiple-vimwikis-to-show-under-vimwiki-open-index-in-the-gvim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How do I get multiple vimwikis to show under "Vimwiki / Open Index" in the gvim menu? - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://social.msdn.microsoft.com/Forums/en-US/91eae199-97a0-4136-a9d3-5a87a769453e/how-do-you-set-home-page-through-java-script-for-mozilla-firefox?forum=asphtmlcssjavascript" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How do you set home page through java script for mozilla firefox?</A>
        <DT><A HREF="https://www.unixmen.com/access-twitter-via-command-line-terminal/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How To Access Twitter Via Command Line (Terminal) | Unixmen</A>
        <DT><A HREF="https://www.cyberciti.biz/faq/sudo-append-data-text-to-file-on-linux-unix-macos/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to append text to a file when using sudo command on Linux or Unix - nixCraft</A>
        <DT><A HREF="https://www.techrepublic.com/article/how-to-clone-a-website-with-httrack/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to clone a website with httrack | TechRepublic</A>
        <DT><A HREF="https://www.howtogeek.com/278599/how-to-combine-text-files-using-the-cat-command-in-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Combine Text Files Using the âcatâ Command in Linux</A>
        <DT><A HREF="https://computingforgeeks.com/how-to-configure-mpd-and-ncmpcpp-on-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to configure mpd and ncmpcpp on Linux | ComputingForGeeks</A>
        <DT><A HREF="https://opensource.com/life/15/3/creating-split-screen-shots-kdenlive" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to create split screen shots in Kdenlive | Opensource.com</A>
        <DT><A HREF="https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to create your own Custom Terminal Commands | by Nirdosh Gautam | Devnetwork | Medium</A>
        <DT><A HREF="https://linuxhint.com/customize-tmux-configuration/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to customize the tmux configuration?</A>
        <DT><A HREF="https://stackoverflow.com/questions/39337075/how-to-delete-text-between-all-braces-in-vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to delete text between all braces {} in vim - Stack Overflow</A>
        <DT><A HREF="https://www.geekyhacker.com/2021/08/02/how-to-fix-grub-i386-pc-normal-mod-no-found/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to fix grub/i386-pc/normal.mod not found - Geeky Hacker</A>
        <DT><A HREF="https://itigic.com/install-and-configure-dlna-minidlna-server-on-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Install and Configure DLNA miniDLNA Server on Linux | ITIGIC</A>
        <DT><A HREF="https://howtoforge.com/how-to-install-koel-music-streaming-server-using-docker-on-rocky-linux-8/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Install Koel Music Streaming Server using Docker on Rocky Linux 8</A>
        <DT><A HREF="https://www.youtube.com/watch?v=NwS28dX7eOI" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to install mpd and ncmpcpp in linux and how to add songs - YouTube</A>
        <DT><A HREF="https://www.youtube.com/watch?v=xGS_Ryx_7r8" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Install PS3HEN on Any PS3 on Firmware 4.90 or Lower! - YouTube</A>
        <DT><A HREF="https://www.linuxshelltips.com/install-xfce-alpine-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Install XFCE Desktop on Alpine Linux</A>
        <DT><A HREF="https://9to5linux.com/how-to-search-for-text-within-files-and-folders-in-linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Search for Text within Files and Folders in Linux - 9to5Linux</A>
        <DT><A HREF="https://medium.com/@jimmashuke/how-to-stop-that-annoying-sudo-password-prompt-in-linux-b2b72b9c2f55" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to stop that annoying âSUDOâ password prompt in Linux | by Mashuke Alam Jim | Medium</A>
        <DT><A HREF="https://www.howtogeek.com/734838/how-to-use-encrypted-passwords-in-bash-scripts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to Use Encrypted Passwords in Bash Scripts</A>
        <DT><A HREF="https://www.techrepublic.com/article/how-to-use-secure-copy-with-ssh-key-authentication/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">How to use SCP (secure copy) with ssh key authentication</A>
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Learn/HTML/Tables/Advanced" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">HTML table advanced features and accessibility - Learn web development | MDN</A>
        <DT><A HREF="https://mirror.parrot.sh/parrot/misc/openbooks/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Index of /parrot/misc/openbooks/</A>
        <DT><A HREF="https://itsubuntu.com/how-to-install-deepin-desktop-environment-on-ubuntu-22-04-lts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install Deepin Desktop Environment On Ubuntu 22.04 LTS | Itsubuntu.com</A>
        <DT><A HREF="https://docs.docker.com/engine/install/debian/#set-up-the-repository" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install Docker Engine on Debian | Docker Documentation</A>
        <DT><A HREF="https://www.youtube.com/watch?v=C_dQTU9smPc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install Koel audio streaming server menggunakan docker compose di ubuntu 20.04 - YouTube</A>
        <DT><A HREF="https://www.youtube.com/watch?v=CINn8TVuD6s" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install Mmcm Versi Stable For Ps3 Cfw/Hen 4.89 Update Terbaru - YouTube</A>
        <DT><A HREF="https://docs.docker.com/desktop/install/debian/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install on Debian | Docker Documentation</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Install_to_disk" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Install to disk - Alpine Linux</A>
        <DT><A HREF="https://searx.github.io/searx/admin/installation.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Installation â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://international.bittrex.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Buy Bitcoin & Ethereum | Cryptocurrency Exchange | Bittrex Global</A>
        <DT><A HREF="https://ipleak.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">IP/DNS Detect - What is your IP, what is your DNS, what informations you send to websites.</A>
        <DT><A HREF="https://ipinfodb.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">IP Info, IP Geolocation Tools and API| IPInfoDB</A>
        <DT><A HREF="https://www.perturb.org/content/iptables-rules.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">IPTables rule generator</A>
        <DT><A HREF="https://iptablesgenerator.totalbits.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">IPTables Rule Generator</A>
        <DT><A HREF="https://ip6.nl/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">IPv6 domain readiness tester</A>
        <DT><A HREF="https://docs.oracle.com/javase" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">JDK 20 Documentation - Home</A>
        <DT><A HREF="https://0x64marsh.com/?p=314" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Kernel Driver Exploit: System Mechanic | Marsh</A>
        <DT><A HREF="https://keybase.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Keybase</A>
        <DT><A HREF="https://www.mlyusr6htlxsyc7t2f4z53wdxh3win7q3qpxcrbam6jf3dmua7tnzuyd.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Kilos TOR Mixer</A>
        <DT><A HREF="https://eirenicon.org/knowledge-base/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Knowledge Base â eirenicon llc</A>
        <DT><A HREF="https://www.digi77.com/software/kodachi/Kodachi-Log.txt" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Kodachi change log file</A>
        <DT><A HREF="https://www.kucoin.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Exchange | Bitcoin Exchange | Bitcoin Trading | KuCoin</A>
        <DT><A HREF="https://kycnot.me/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">KYC? Not me!</A>
        <DT><A HREF="https://learn-bash.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn Bash</A>
        <DT><A HREF="https://www.learn-c.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn C - Free Interactive C Tutorial</A>
        <DT><A HREF="https://www.learn-cpp.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn C++ - Free Interactive C++ Tutorial</A>
        <DT><A HREF="https://dev.java/learn/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn Java - Dev.java</A>
        <DT><A HREF="https://nim-lang.org/learn.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn Nim</A>
        <DT><A HREF="https://nodejs.dev/learn" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn NodeJS</A>
        <DT><A HREF="https://www.learn-php.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn PHP - Free Interactive PHP Tutorial</A>
        <DT><A HREF="https://www.learnpython.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Learn Python - Free Interactive Python Tutorial</A>
        <DT><A HREF="https://github.com/vimwiki/vimwiki/issues/133" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Link to another wiki? Â· Issue #133 Â· vimwiki/vimwiki Â· GitHub</A>
        <DT><A HREF="https://superuser.com/questions/1224532/get-links-from-an-html-page" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">linux - Get links from an html page - Super User</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/452101/how-to-keep-only-latest-file-in-the-folder-and-move-older-files-to-archive-locat" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">linux - How to Keep only latest file in the folder and move older files to Archive location - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://linuxcommand.org/lc3_adv_dialog.php" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Command Line Adventure: Dialog</A>
        <DT><A HREF="https://www.foxinfotech.in/2019/04/linux-dialog-examples.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Dialog Examples</A>
        <DT><A HREF="https://www.cyberciti.biz/security/howto-linux-hard-disk-encryption-with-luks-cryptsetup-command/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Hard Disk Encryption With LUKS [cryptsetup command ] - nixCraft</A>
        <DT><A HREF="https://www.digi77.com/linux-kodachi/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Kodachi 8.27 The Secure OS | Eagle Eye | Nonprofit Organization</A>
        <DT><A HREF="https://thenewstack.io/linux-lesson-copy-files-over-your-network-with-scp/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Lesson: Copy Files Over Your Network with scp - The New Stack</A>
        <DT><A HREF="https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-systemd-unit-file" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux post-installation steps for Docker Engine | Docker Documentation</A>
        <DT><A HREF="https://redtm.com/privilege-escalation/linux-privilege-escalation-cheat-sheet/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Linux Privilege Escalation</A>
        <DT><A HREF="https://chessentials.com/chess-tactics/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">List of daily chess tactics - Chess puzzles - Chessentials</A>
        <DT><A HREF="https://www.spamhaus.com/threat-map/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Live botnet threats worldwide | Spamhaus Technology</A>
        <DT><A HREF="https://threatmap.checkpoint.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Live Cyber Threat Map | Check Point</A>
        <DT><A HREF="https://flightaware.com/live/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Live Flight Tracker - FlightAware</A>
        <DT><A HREF="https://www.livefromiceland.is/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Live from Iceland - Webcams around Iceland</A>
        <DT><A HREF="https://satellitemap.space/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Live Starlink Satellite and Coverage Map</A>
        <DT><A HREF="https://mobility.portal.geops.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Live Train Tracker | geOps</A>
        <DT><A HREF="https://in-the-sky.org/satmap_worldmap.php" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Live World Map of Satellite Positions - In-The-Sky.org</A>
        <DT><A HREF="https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Making tmux Pretty and Usable - A Guide to Customizing your tmux.conf</A>
        <DT><A HREF="https://www.cryptocompare.com/portfolio/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Manage and track your cryptocurrency portfolio | CryptoCompare.com</A>
        <DT><A HREF="https://cybermap.kaspersky.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MAP | Kaspersky Cyberthreat real-time map</A>
        <DT><A HREF="https://mempool.space/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">mempool - Bitcoin Explorer</A>
        <DT><A HREF="https://metager.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MetaGer: Privacy Protected Search & Find</A>
        <DT><A HREF="https://www.youtube.com/watch?v=ELjsbyhkkKw" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">mind nvim | Part 2/5: Content fuzzy searching and more - YouTube</A>
        <DT><A HREF="https://mint.bitcoin.com/#/configure" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Mint | Bitcoin.com</A>
        <DT><A HREF="https://www.morphtoken.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MorphToken</A>
        <DT><A HREF="https://pastebin.com/P7rwMFLq" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">mpd.conf - Pastebin.com</A>
        <DT><A HREF="https://magazine.odroid.com/article/multi-screen-desktop-using-vnc-part-2-an-improved-and-simplified-version/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Multi Screen Desktop Using VNC - Part 2: An Improved And Simplified Version | ODROID Magazine</A>
        <DT><A HREF="https://www.thelinuxrain.org/articles/multiple-item-data-entry-with-yad" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Multiple-item data entry with YAD | The Linux Rain</A>
        <DT><A HREF="https://forum.mxlinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MX Linux Forum - Index page</A>
        <DT><A HREF="https://mxlinux.org/wiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MX/antiX Technical Documentation Wiki â MX Linux</A>
        <DT><A HREF="https://www.youtube.com/watch?v=hLV96u2Cnck" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">My Neovim Config - YouTube</A>
        <DT><A HREF="https://addy-dclxvi.github.io/post/configuring-ncmpcpp/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">My Way of Configuring Ncmpcpp Music Player - Addy's Blog</A>
        <DT><A HREF="https://wallet.mymonero.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">MyMonero</A>
        <DT><A HREF="https://pastebin.com/yZM8zGwv" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ncmpcpp config - Pastebin.com</A>
        <DT><A HREF="https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Neovim configuration for beginners | by Rio Nyx | Geek Culture | Medium</A>
        <DT><A HREF="https://raspberrypi.stackexchange.com/questions/110799/wifi-not-working-after-installing-openmediavault-omv-5-in-rpi-4" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">networking - WiFi not working after installing openmediavault (OMV) 5 in RPi 4 - Raspberry Pi Stack Exchange</A>
        <DT><A HREF="https://www.computernetworkingnotes.com/networking-tutorials/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Networking Tutorials</A>
        <DT><A HREF="https://www.neutrino.nu/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Neutrino - Solutions for monitoring, analyzing and tracking cryptocurrency flows</A>
        <DT><A HREF="https://guyinatuxedo.github.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Nightmare - Nightmare</A>
        <DT><A HREF="https://phoenixnap.com/kb/nmap-command-linux-examples" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Nmap Commands - 17 Basic Commands for Linux Network</A>
        <DT><A HREF="https://nomics.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Sunsetting Nomics.com</A>
        <DT><A HREF="https://nvd.nist.gov/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">NVD - Home</A>
        <DT><A HREF="https://jdhao.github.io/nvim-config/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">nvim-config | A modern Neovim configuration with full battery for Python, Lua, C++, Markdown, LaTeX, and moreâ¦</A>
        <DT><A HREF="https://csandker.io/2021/01/10/Offensive-Windows-IPC-1-NamedPipes.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Offensive Windows IPC Internals 1: Named Pipes Â· csandker.io</A>
        <DT><A HREF="https://csandker.io/2021/02/21/Offensive-Windows-IPC-2-RPC.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Offensive Windows IPC Internals 2: RPC Â· csandker.io</A>
        <DT><A HREF="https://csandker.io/2022/05/24/Offensive-Windows-IPC-3-ALPC.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Offensive Windows IPC Internals 3: ALPC Â· csandker.io</A>
        <DT><A HREF="https://messari.io/onchainfx" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Crypto Research, Data, and Tools | Messari</A>
        <DT><A HREF="https://www.3bbad7fauom4d6sgppalyqddsqbf5u5p56b5k5uk2zxsy3d6ey2jobad.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Onion Land - Onion</A>
        <DT><A HREF="https://onionmail.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Onion Mail - Encrypted & Anonymous email</A>
        <DT><A HREF="https://www.pflujznptk5lmuf6xwadfqy6nffykdvahfbljh7liljailjbxrgvhfid.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Onion Mail - Onion</A>
        <DT><A HREF="https://www.zend2.com/#" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Online anonymous web proxy - zend2</A>
        <DT><A HREF="https://www.onlineotp.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">onlineotp</A>
        <DT><A HREF="https://sourceforge.net/blog/projects-of-the-week-april-24-2017/oolite/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">oolite - SourceForge Community Blog</A>
        <DT><A HREF="https://wiki.alioth.net/index.php/Oolite_Main_Page" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Oolite Main Page - Elite Wiki</A>
        <DT><A HREF="https://www.openrailwaymap.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OpenRailwayMap</A>
        <DT><A HREF="https://www.opentraintimes.com/maps" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OpenTrainTimes: Real-time Track Diagrams</A>
        <DT><A HREF="https://wizard.openzeppelin.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OpenZeppelin Contracts Wizard</A>
        <DT><A HREF="https://prism-break.org/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Opt out of global data surveillance programs like PRISM, XKeyscore, and Tempora - PRISM Break - PRISM Break</A>
        <DT><A HREF="https://www.python.org/doc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Our Documentation | Python.org</A>
        <DT><A HREF="https://overland.org.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Overland - Overland literary journal</A>
        <DT><A HREF="https://www.owasp.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OWASP Foundation, the Open Source Foundation for Application Security | OWASP Foundation</A>
        <DT><A HREF="https://owasp.org/www-project-secure-coding-dojo/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OWASP Secure Coding Dojo | OWASP Foundation</A>
        <DT><A HREF="https://owasp.org/www-project-webgoat/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">OWASP WebGoat | OWASP Foundation</A>
        <DT><A HREF="https://packetstormsecurity.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Packet Storm</A>
        <DT><A HREF="https://panopticlick.eff.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Cover Your Tracks</A>
        <DT><A HREF="https://start.parrot.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Parrot Security</A>
        <DT><A HREF="https://www.parrotsec.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Parrot Security</A>
        <DT><A HREF="https://www.parrotsec.org/docs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ParrotOS Documentation | ParrotOS Documentation</A>
        <DT><A HREF="https://www.parrotsec.org/docs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ParrotOS Documentation | ParrotOS Documentation</A>
        <DT><A HREF="https://bitwarden.com/help/cli/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Password Manager CLI | Bitwarden Help Center</A>
        <DT><A HREF="https://pentesterlab.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PentesterLab: Learn Web Penetration Testing: The Right Way</A>
        <DT><A HREF="https://www.phobosxilamwcg75xt22id7aywkzol6q6rfl2flipcqoc4e4ahima5id.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Phobos - Onion</A>
        <DT><A HREF="https://php.net/manual/en/index.php" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PHP: PHP Manual - Manual</A>
        <DT><A HREF="https://www.digitalneanderthal.com/post/ncmpcpp/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Playing Music with Mopidy and Ncmpcpp | Digital Neanderthal</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Post_installation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Post installation - Alpine Linux</A>
        <DT><A HREF="https://vim.fandom.com/wiki/Power_of_g" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Power of g | Vim Tips Wiki | Fandom</A>
        <DT><A HREF="https://privatebin.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PrivateBin</A>
        <DT><A HREF="https://0xsp.com/offensive/privilege-escalation-cheatsheet/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Privilege Escalation cheatsheet -</A>
        <DT><A HREF="https://wiki.gnome.org/action/show/Projects/Zenity?action=show" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Projects/Zenity - GNOME Wiki!</A>
        <DT><A HREF="https://protonmail.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Proton Mail â Get a private, secure, and encrypted email | Proton</A>
        <DT><A HREF="https://www.proxysite.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ProxySite.com - Free Web Proxy Site</A>
        <DT><A HREF="https://www.brewology.com/?cat=4" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PS3 Â» Brewology - PS3 PSP WII XBOX - Homebrew News, Saved Games, Downloads, and More!</A>
        <DT><A HREF="https://www.youtube.com/watch?v=s7gMikAHEm4" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PS3 HEN - New Alternative Easy Installation Method (4.84 HFW ONLY) - YouTube</A>
        <DT><A HREF="https://saterahsia.com/ps3-hfw-4-89-hybrid-firmware-latest-update-v4-89-1/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PS3 HFW 4.89 - Hybrid Firmware Latest Update V4.89.1 - SATERAHSIA</A>
        <DT><A HREF="https://www.brewology.com/psn/downloader.php?ref=news" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PS3 PKG / PSN Downloader - Brewology - PS3 PSP WII XBOX - Homebrew News, Saved Games, Downloads, and More!</A>
        <DT><A HREF="https://almal3eb.com/2022/05/30/ps3-cfw-evilnat-4-89-2-beta-released-wololo-net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">PS3: CFW Evilnat 4.89.2 beta released â Wololo.net â almal3eb</A>
        <DT><A HREF="https://duckduckgo.com/?q=python+enabled+neovim&t=fpas&iax=images&ia=images" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">python enabled neovim at DuckDuckGo</A>
        <DT><A HREF="https://www.qrcode-monkey.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">QRCode Monkey - The free QR Code Generator to create custom QR Codes with Logo</A>
        <DT><A HREF="https://quad9.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Quad9 | A public and free DNS service for a better security and privacy</A>
        <DT><A HREF="https://www.qubes-os.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Qubes OS: A reasonably secure operating system | Qubes OS</A>
        <DT><A HREF="https://www.qwant.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Qwant - The search engine that doesn't know anything about you, and that changes everything!</A>
        <DT><A HREF="https://www.reddit.com/r/vim/comments/nwi7d8/terminal_sexy_but_for_vim/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Reddit - Dive into anything</A>
        <DT><A HREF="https://docs.alpinelinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Redirect Notice</A>
        <DT><A HREF="https://tracker.habhub.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Redirecting you to SondeHub-Amateur...</A>
        <DT><A HREF="https://pack.resetthenet.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Reset The Net - Privacy Pack</A>
        <DT><A HREF="https://restoreprivacy.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Restore Privacy | Your online privacy resource center</A>
        <DT><A HREF="https://stackoverflow.com/posts/41463292/revisions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Revisions to Convert audio files to mp3 using ffmpeg [closed] - Stack Overflow</A>
        <DT><A HREF="https://www.baeldung.com/linux/run-command-start-up" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Running a Linux Command on Start-Up | Baeldung on Linux</A>
        <DT><A HREF="https://geoxc-apps2.bd.esri.com/Visualization/sat2/index.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,air & space tracking,bookmarks bar,buku bookmarks">Satellite Map | Explore Active Satellites Orbiting Earth</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/8839/how-i-configure-vim-for-use-with-netrw" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">save - How I configure Vim for use with netrw? - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://github.com/search?q=task+vimwiki" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Search Â· task vimwiki Â· GitHub</A>
        <DT><A HREF="https://stackoverflow.com/questions/39077407/search-bar-like-google-in-html-and-css" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Search bar like google in HTML and CSS - Stack Overflow</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/19357/search-through-entire-vimwiki" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Search through entire vimwiki - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://github.com/searx/searx/blob/master/searx/settings.yml" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">searx/settings.yml at master Â· searx/searx Â· GitHub</A>
        <DT><A HREF="https://github.com/searx/searx/blob/master/utils/templates/etc/searx/use_default_settings.yml" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">searx/use_default_settings.yml at master Â· searx/searx Â· GitHub</A>
        <DT><A HREF="https://securityinabox.org/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">What do you need to protect?</A>
        <DT><A HREF="https://stackoverflow.com/questions/2512362/how-can-i-can-insert-the-contents-of-a-file-into-another-file-right-before-a-spe" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">sed - How can I can insert the contents of a file into another file right before a specific line - Stack Overflow</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/99350/how-to-insert-text-before-the-first-line-of-a-file" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">sed - How to insert text before the first line of a file? - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/337435/sed-insert-file-at-top-of-another" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SED - Insert file at top of another - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://www.anonymousspeech.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Send Anonymous Email</A>
        <DT><A HREF="https://tuomassalmi.com/tech/personal-wiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Setting up an encrypted personal wiki and diary with Vimwiki and Cryptomator</A>
        <DT><A HREF="https://searx.github.io/searx/admin/settings.html#settings-location" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">settings.yml â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://searx.github.io/searx/admin/settings.html#settings-use-default-settings" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">settings.yml â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://www.abs.gov.au/articles/sexual-harassment" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Sexual Harassment | Australian Bureau of Statistics</A>
        <DT><A HREF="https://stackoverflow.com/questions/22860624/change-firefox-homepage-via-bash-script#22861970" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">shell - Change Firefox homepage via bash script? - Stack Overflow</A>
        <DT><A HREF="https://stackoverflow.com/questions/2314750/how-to-assign-the-output-of-a-bash-command-to-a-variable" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">shell - How to assign the output of a Bash command to a variable? - Stack Overflow</A>
        <DT><A HREF="https://stackoverflow.com/questions/37644634/how-to-use-bash-dialog-yesno-correctly" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">shell - How to use bash dialog --yesno correctly - Stack Overflow</A>
        <DT><A HREF="https://www.freecodecamp.org/news/shell-scripting-crash-course-how-to-write-bash-scripts-in-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Shell Scripting for Beginners â How to Write Bash Scripts in Linux</A>
        <DT><A HREF="https://www.shodan.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Shodan Search Engine</A>
        <DT><A HREF="https://simpleswap.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SimpleSwap | Cryptocurrency Exchange | Easy way to swap BTC to ETH, XRP, LTC, EOS, XLM</A>
        <DT><A HREF="https://www.redtube.com/playlist/3434751" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Sjk Video Playlist | RedTube</A>
        <DT><A HREF="https://www.youtube.com/watch?v=sIG2P9k6EjA" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Small, Simple, and Secure: Alpine Linux under the Microscope - YouTube</A>
        <DT><A HREF="https://chain.so/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Bitcoin Block Explorer & API â SoChain</A>
        <DT><A HREF="https://lunarcrush.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">LunarCrush | Trade what others can't stop talking about - Crypto - Stocks - NFTs</A>
        <DT><A HREF="https://www.social-searcher.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Social Searcher - Free Social Media Search Engine</A>
        <DT><A HREF="https://securitycenter.sonicwall.com/m/page/worldwide-attacks" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SonicWall Security Center</A>
        <DT><A HREF="https://securitycenter.sonicwall.com/m/page/capture-labs-threat-metrics" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SonicWall Security Center</A>
        <DT><A HREF="https://speedsmart.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SpeedSmart - HTML5 Internet Speed Test - Test your internet speed</A>
        <DT><A HREF="https://www.speedtest.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Speedtest by Ookla - The Global Broadband Speed Test</A>
        <DT><A HREF="https://www.redhat.com/sysadmin/sshfs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">SSHFS: Mounting a remote file system over SSH | Enable Sysadmin</A>
        <DT><A HREF="https://www.ssllabs.com/ssltest/viewMyClient.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Qualys SSL Labs - Projects / SSL Client Test</A>
        <DT><A HREF="https://startpage.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Startpage - Private Search Engine. No Tracking. No Search History.</A>
        <DT><A HREF="https://www.startpage.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Startpage - Private Search Engine. No Tracking. No Search History.</A>
        <DT><A HREF="https://searx.github.io/searx/admin/installation-searx.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Step by step installation â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://tutorialforlinux.com/2021/06/27/step-by-step-samba-file-sharing-on-mx-linux/3/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Step-by-step - Samba File Sharing on MX Linux â¢ Accessing Shared Files â¢ tutorialforlinux.com</A>
        <DT><A HREF="https://ssd.eff.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Surveillance Self-Defense</A>
        <DT><A HREF="https://github.com/jarun/buku/wiki/System-integration" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">System integration Â· jarun/buku Wiki Â· GitHub</A>
        <DT><A HREF="https://www.vim.org/scripts/script.php?script_id=3465" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Tagbar - Display tags of the current file ordered by scope : vim online</A>
        <DT><A HREF="https://tails.boum.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Tails - Home</A>
        <DT><A HREF="https://kb.mozillazine.org/Talk:Firefox_links" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Talk:Firefox links - MozillaZine Knowledge Base</A>
        <DT><A HREF="https://taskwarrior.org/docs/30second/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Taskwarrior - 30-Second Tutorial - Taskwarrior</A>
        <DT><A HREF="https://taskwarrior.org/docs/best-practices/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Taskwarrior - Best Practices - Taskwarrior</A>
        <DT><A HREF="https://taskwarrior.org/docs/configuration/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Taskwarrior - Configuration - Taskwarrior</A>
        <DT><A HREF="https://randomgeekery.org/post/2020/01/taskwarrior-sync/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Taskwarrior Sync | Post | Random Geekery</A>
        <DT><A HREF="https://mail.tm/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Temp Mail - Disposable Temporary Email service - Mail.tm</A>
        <DT><A HREF="https://test-ipv6.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Test your IPv6.</A>
        <DT><A HREF="https://www.ubuntupit.com/simple-yet-effective-linux-shell-script-examples/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The 40 Simple Yet Effective Linux Shell Script Examples</A>
        <DT><A HREF="https://www.psychologytoday.com/us/blog/cutting-edge-leadership/201811/the-5-steps-dehumanization" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The 5 Steps of Dehumanization | Psychology Today</A>
        <DT><A HREF="https://guide.bash.academy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Bash Guide</A>
        <DT><A HREF="https://www.chainalysis.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Blockchain Data Platform - Chainalysis</A>
        <DT><A HREF="https://www.debian.org/doc/manuals/debian-handbook/index.en.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Debian Administrator's Handbook</A>
        <DT><A HREF="https://www.opensuse.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The makers' choice for sysadmins, developers and desktop users.</A>
        <DT><A HREF="https://www.documentary24.com/the-science-of-vacation--3191/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The science of vacation - Watch Online</A>
        <DT><A HREF="https://proprivacy.com/vpn/guides/firefox-privacy-security-guide" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">The Ultimate Firefox Privacy & Security Guide</A>
        <DT><A HREF="https://map.lookingglasscyber.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">THREAT MAP by LookingGlass</A>
        <DT><A HREF="https://threatbutt.com/map/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Threatbutt Internet Hacking Attack Attribution Map</A>
        <DT><A HREF="https://web.threema.ch/#!/welcome" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Threema Web</A>
        <DT><A HREF="https://timewarrior.net/support/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Timewarrior - Support - Timewarrior</A>
        <DT><A HREF="https://timewarrior.net/docs/what/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Timewarrior - What is it? - Timewarrior</A>
        <DT><A HREF="https://www.youtube.com/watch?v=DzNmUNvnB04" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Tmux has forever changed the way I write code. - YouTube</A>
        <DT><A HREF="https://www.torproject.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Tor Project | Anonymity Online</A>
        <DT><A HREF="https://www.xmh57jrknzkhv6y3ls3ubitzfqnkrwxhopf5aygthi7d6rplyvk3noyd.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Torch - Onion</A>
        <DT><A HREF="https://opensecuritytraining.info/Training.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Training</A>
        <DT><A HREF="https://martinlwx.github.io/en/config-neovim-from-scratch/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Transform Your Neovim into a IDE: A Step-by-Step Guide - MartinLwx's blog</A>
        <DT><A HREF="https://www.pxdmqka7qbymz6xqs3cl3zmautwq6qf2p6fptf4u4hpddniyw2skziad.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Trust BTC Escrow - Onion</A>
        <DT><A HREF="https://tutanota.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Secure email: Tutanota free encrypted email.</A>
        <DT><A HREF="https://stackoverflow.com/questions/66866818/how-to-change-nvim-path-to-config" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">ubuntu - How to change nvim path to .config - Stack Overflow</A>
        <DT><A HREF="https://manpages.ubuntu.com/manpages/kinetic/en/man1/pandoc.1.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Ubuntu Manpage: pandoc - general markup converter</A>
        <DT><A HREF="https://askubuntu.com/questions/500359/efi-boot-partition-and-biosgrub-partition" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">uefi - ''EFI boot partition'' and ''biosgrub'' partition - Ask Ubuntu</A>
        <DT><A HREF="https://www.thegeekdiary.com/how-to-install-and-configure-mutt-in-centos-rhel/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan25,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">UNIX / Linux : How to install and configure mutt â The Geek Diary</A>
        <DT><A HREF="https://opensource.com/article/20/1/vim-task-list-reddit-twitter" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Use Vim to manage your task list and access Reddit and Twitter | Opensource.com</A>
        <DT><A HREF="https://mxlinux.org/manuals/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Users Manual â MX Linux</A>
        <DT><A HREF="https://mxlinux.org/videos/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Videos â MX Linux</A>
        <DT><A HREF="https://medium.com/@felipe.anjos/vim-for-web-development-html-css-in-2020-95576d9b21ad" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">VIM for web-development (HTML/CSS) in 2020 | by Felipe Cavalheiro dos Anjos | Medium</A>
        <DT><A HREF="https://www.naperwrimo.org/wiki/index.php?title=Vim_for_Writers" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023may22,2023oct08,2023sep26,bookmarks bar,buku bookmarks">Vim for Writers - NaperWriMo Wiki</A>
        <DT><A HREF="https://shapeshed.com/vim-netrw/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug09,2023aug26,2023jan12,2023jan25,2023mar25,2023may22,2023oct08,2023sep26,bookmarks bar">Vim: you don't need NERDtree or (maybe) netrw | George Ornbo</A>
        <DT><A HREF="https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">Vimrc Configuration Guide - How to Customize Your Vim Code Editor with Mappings, Vimscript, Status Line, and More</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/28505/vimwiki-create-a-smart-index-page-for-subdir-section-of-wiki" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">vimscript - VimWiki - create a "smart" index page for subdir/section of wiki? - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://pypi.org/project/vimwiki-cli/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22,2023sep26,bookmarks bar">vimwiki-cli Â· PyPI</A>
        <DT><A HREF="https://dev.to/psiho/vimwiki-how-to-automate-wikis-per-project-folder-neovim-3k72" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">VimWiki: how to automate wikis per project folder (Neovim) - DEV Community</A>
        <DT><A HREF="https://vuldb.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">Vulnerability Database</A>
        <DT><A HREF="https://www.vulnerability-lab.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">VULNERABILITY LAB - SECURITY VULNERABILITY RESEARCH LABORATORY - Best Independent Bug Bounty Programs, Responsible Disclosure & Vulnerability Coordination Platform - INDEX</A>
        <DT><A HREF="https://www.vx-underground.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">vx-underground</A>
        <DT><A HREF="https://www.walletexplorer.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">WalletExplorer.com: smart Bitcoin block explorer</A>
        <DT><A HREF="https://www.youtube.com/c/TechandCryptovibes" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">Tech and Crypto Vibes - YouTube</A>
        <DT><A HREF="https://twitter.com/warith2020?lang=en" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug26,2023may22,2023sep26,bookmarks bar">Warith Al Maawali (@warith2020) | Twitter</A>
        <DT><A HREF="https://www.linkedin.com/in/warith1977/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">Warith AL Maawali LinkedIn profile</A>
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Web/API" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,2023sep26,bookmarks bar">Web APIs | MDN</A>
        <DT><A HREF="https://portswigger.net/web-security" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22,2023sep26,bookmarks bar">Web Security Academy: Free Online Training from PortSwigger</A>
        <DT><A HREF="https://worldcam.eu/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22,2023sep26,bookmarks bar">Webcams from around the World - WorldCam</A>
        <DT><A HREF="https://linuxconfig.org/webdav-server-setup-on-ubuntu-linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22,2023sep26,bookmarks bar">WebDAV server setup on Ubuntu Linux - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://searx.github.io/searx/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22,2023sep26,bookmarks bar">Welcome to searx â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://uefi.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22,2023sep26">Welcome to Unified Extensible Firmware Interface Forum | Unified Extensible Firmware Interface Forum</A>
        <DT><A HREF="https://www.psychologytoday.com/us/blog/the-web-violence/201806/what-is-dehumanization-anyway" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">What Is Dehumanization, Anyway? | Psychology Today</A>
        <DT><A HREF="https://www.techtalk7.com/what-vim-command-to-use-to-delete-all-text-after-a-certain-character-on-every-line-of-a-file/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">What Vim command to use to delete all text after a certain character on every line of a file? - TechTalk7</A>
        <DT><A HREF="https://whoer.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Find and check IP address</A>
        <DT><A HREF="https://wigle.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">WiGLE: Wireless Network Mapping</A>
        <DT><A HREF="https://wpscan.com/wordpresses" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">WordPress Vulnerabilities</A>
        <DT><A HREF="https://patchstack.com/database/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">WordPress Vulnerability Database - Patchstack</A>
        <DT><A HREF="https://satellites.pro/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">World map, satellite view // Earth map online service</A>
        <DT><A HREF="https://www.nsupdate.info/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">www.nsupdate.info</A>
        <DT><A HREF="https://alternativeto.net/software/wxglade/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,buku bookmarks">wxGlade: App Reviews, Features, Pricing & Download | AlternativeTo</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/378373/add-virtual-output-to-xorg" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">x11 - Add VIRTUAL output to Xorg - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://www.x86matthew.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">x86matthew - Home</A>
        <DT><A HREF="https://xsinator.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">XSinator - XS-Leak Browser Test Suite</A>
        <DT><A HREF="https://bbs.archlinux.org/viewtopic.php?id=202463" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Yad - Checklist within form? / Programming & Scripting / Arch Linux Forums</A>
        <DT><A HREF="https://github.com/v1cont/yad/issues/78" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">YAD --paned does not terminated after closing window Â· Issue #78 Â· v1cont/yad Â· GitHub</A>
        <DT><A HREF="https://cjungmann.github.io/yaddemo/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">YAD (and BASH) Demo | yaddemo</A>
        <DT><A HREF="https://eirenicon.org/knowledge-base/yad-yet-another-dialog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">YAD (Yet Another Dialog) Scripts/ Examples â eirenicon llc</A>
        <DT><A HREF="https://yad-guide.ingk.se/html/yad-html.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">YAD HTML dialog</A>
        <DT><A HREF="https://groups.google.com/g/yad-common" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">yad-common - Google Groups</A>
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/player.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">yad-examples/player.sh at master - yad-examples - Codeberg.org</A>
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/sysinfo-notebook.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may11,2023may22">yad-examples/sysinfo-notebook.sh at master - yad-examples - Codeberg.org</A>
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/tabs.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may11,2023may22">yad-examples/tabs.sh at master - yad-examples - Codeberg.org</A>
        <DT><A HREF="https://alternativeto.net/software/yad/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,buku bookmarks">Yad: App Reviews, Features, Pricing & Download | AlternativeTo</A>
        <DT><A HREF="https://duckduckgo.com/?q=yadbash&ia=web" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">yadbash at DuckDuckGo</A>
        <DT><A HREF="https://youtube.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">YouTube</A>
        <DT><A HREF="https://alternativeto.net/software/zenity/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22,buku bookmarks">Zenity: App Reviews, Features, Pricing & Download | AlternativeTo</A>
        <DT><A HREF="https://www.zoomeye.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">ZoomEye - Cyberspace Search Engine</A>
        <DT><A HREF="https://www.ethtective.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">ÎTHTECTIVE</A>
        <DT><A HREF="http://10minutemail.com/10MinuteMail/index.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">10 Minute Mail</A>
        <DT><A HREF="http://10minutemail.net/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">10 Minute Mail</A>
        <DT><A HREF="http://anonymouse.org/anonemail.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Anonymouse.org</A>
        <DT><A HREF="http://www.computersecuritystudent.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">Computer Security Student | Cyber Security Lessons, Tutorials, and Training</A>
        <DT><A HREF="http://www.dnsleaktest.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">DNS leak test</A>
        <DT><A HREF="http://www.dogpile.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Dogpile Web Search</A>
        <DT><A HREF="http://www.facebook.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Facebook</A>
        <DT><A HREF="http://f.vision/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Fake Vision | Beta v1.1</A>
        <DT><A HREF="http://www.vpnbook.com/webproxy" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug26,2023may22">Free Web Proxy â¢ Unblock YouTube</A>
        <DT><A HREF="http://www.calmar.ws/div/fritz_and_wine.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">Fritz Chess on Linux with Wine (Windows Emulator)</A>
        <DT><A HREF="http://localhost:631/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Home - CUPS 2.2.7</A>
        <DT><A HREF="http://smokey01.com/yad/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">http://smokey01.com/yad/</A>
        <DT><A HREF="http://www.hushmail.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Hushmail - Encrypted Email, Web Forms & E-Signatures</A>
        <DT><A HREF="http://127.0.0.1:7657/home" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">I2P Router Console - home</A>
        <DT><A HREF="http://ifconfig.me/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">What Is My IP Address? - ifconfig.me</A>
        <DT><A HREF="http://www.insecam.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">Insecam - World biggest online cameras directory</A>
        <DT><A HREF="http://ifconfig.co/ip" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Ip check simple</A>
        <DT><A HREF="http://ipmagnet.services.cbcdn.com/?hash=0af64f2b6de2500a788122d48b624d18d2133010" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">ipmagnet</A>
        <DT><A HREF="http://joereynoldsaudio.com/2018/07/07/you-dont-need-vimwiki.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Joe Reynolds Audio</A>
        <DT><A HREF="http://www.kproxy.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">KPROXY - Free Anonymous Web Proxy - Anonymous Proxy</A>
        <DT><A HREF="http://www.lakka.tv/doc/The-Live-USB-Mode/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Lakka documentation - The Live USB Mode</A>
        <DT><A HREF="http://linux-training.be/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">linux-training.be</A>
        <DT><A HREF="http://www.opentopia.com/hiddencam.php" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">Live Webcams - Free, public web cams found online</A>
        <DT><A HREF="http://127.0.0.1:8384/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023aug26,2023may22">Live-OS | Syncthing</A>
        <DT><A HREF="http://mailinator.com/index.jsp" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Home - Mailinator</A>
        <DT><A HREF="http://metagerv65pwclop2rsfzg4jwowpavpwd6grhhlvdgsswvo6ii4akgyd.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">MetaGer - Onion</A>
        <DT><A HREF="http://metagerv65pwclop2rsfzg4jwowpavpwd6grhhlvdgsswvo6ii4akgyd.onion/en-US" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">MetaGer: US</A>
        <DT><A HREF="http://m.home/index.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">NETGEAR</A>
        <DT><A HREF="http://no.i2p/search/?q=tor" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">no.i2p - i2p</A>
        <DT><A HREF="http://s4k4ceiapwwgcm3mkb6e4diqecpo7kvdnfr5gg7sph7jjppqkvwwqtyd.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">Onion Links</A>
        <DT><A HREF="http://ping.pe/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Ping, mtr, dig and TCP port check from multiple locations</A>
        <DT><A HREF="http://kb.mozillazine.org/Prefs.js_file" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Prefs.js file - MozillaZine Knowledge Base</A>
        <DT><A HREF="http://ript.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">ript.io - a really cool domain parked on Park.io</A>
        <DT><A HREF="http://webkay.robinlinus.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">What every Browser knows about you</A>
        <DT><A HREF="http://yadgui.com/index.php/options-5" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may11,2023may22">Scripts</A>
        <DT><A HREF="http://127.0.0.1:8888/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">searx</A>
        <DT><A HREF="http://searx.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">searx.org</A>
        <DT><A HREF="http://cutt.us/smarts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Ø§ÙØ£Ø¯Ø§Ø© Ø§ÙØ°ÙÙØ© ÙØ§Ø®ØªØµØ§Ø± Ø§ÙØ±ÙØ§Ø¨Ø· Ø§ÙÙØªØ¹Ø¯Ø¯Ø©</A>
        <DT><A HREF="http://internethealthtest.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Internet Speed Test by IHT â Check WiFi, Fiber, VPN in 30 Sec Health Test Online by Broadband Connection Stability Diagnostic Tool</A>
        <DT><A HREF="http://neovimcraft.com/plugin/startup-nvim/startup.nvim/index.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">startup-nvim/startup.nvim: A highly configurable neovim startup screen</A>
        <DT><A HREF="http://webproxy.stealthy.co/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Stealthy free Web Proxy | Unlocking the web!</A>
        <DT><A HREF="http://proxylistpro.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">The FREE anonymous PROXY - ProxyListPro</A>
        <DT><A HREF="http://www.pentest-standard.org/index.php/Main_Page" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">The Penetration Testing Execution Standard</A>
        <DT><A HREF="http://tinyurl.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">TinyURL.com - shorten that long URL into a tiny URL</A>
        <DT><A HREF="http://wikitjerrta4qgz4.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25,2023may22">Tor Hidden Wiki</A>
        <DT><A HREF="http://tordexu73joywapk2txdr54jed4imqledpcvcuf75qsas2gwdgksvnyd.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">TorDex</A>
        <DT><A HREF="http://www.zalmos.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">Zalmos.com unblock proxy - Free web proxy</A>
        <DT><A HREF="fille:///home/batan/videos_to_watch" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">videos</A>
        <DT><A HREF="http://webproxy.to/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">webproxy.to - Fast, Secure and Anonymous USA IP Web Proxy!</A>
        <DT><A HREF="http://world-webcams.nsspot.net/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023may22">World Webcams, Camera Search</A>
        <DT><A HREF="http://zerobinqmdqd236y.onion/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023may22">ZeroBin.net - Onion</A>
        <DT><A HREF="https://mxlinux.org/mx-linux-blog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="menu,mx linux">MX Blog</A>
        <DT><A HREF="https://antixlinux.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="antix,menu">antiX</A>
        <DT><A HREF="https://www.antixforum.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="antix,menu">antiX Forum</A>
        <DT><A HREF="https://plato.stanford.edu/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Stanford Encyclopedia of Philosophy</A>
        <DT><A HREF="https://www.infoplease.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Infoplease: An Online Encyclopedia, Almanac, Atlas, Biographies, Dictionary, and Thesaurus</A>
        <DT><A HREF="https://oxfordre.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Oxford Research Encyclopedias</A>
        <DT><A HREF="https://www.encyclopedia.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Encyclopedia.com | Free Online Encyclopedia</A>
        <DT><A HREF="https://www.merriam-webster.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Merriam-Webster: America's Most Trusted Dictionary</A>
        <DT><A HREF="https://www.britannica.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Encyclopedia Britannica | Britannica</A>
        <DT><A HREF="https://github.com/liloman/warriors" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - liloman/warriors: My timewarrior taskwarrior integration scripts</A>
        <DT><A HREF="https://stackoverflow.com/questions/38924659/powershell-multi-choice-menu-and-sub-menu" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Powershell Multi-choice Menu and Sub menu - Stack Overflow</A>
        <DT><A HREF="https://www.rosipov.com/blog/custom-templates-in-vimwiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Custom templates in vimwiki - Ruslan Osipov</A>
        <DT><A HREF="https://github.com/lotabout/vimwiki-tpl" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">GitHub - lotabout/vimwiki-tpl: template for vimwiki</A>
        <DT><A HREF="https://github.com/vimwiki/vimwiki/issues/805" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Custom Vimwiki template with sidebar Â· Issue #805 Â· vimwiki/vimwiki Â· GitHub</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Nextcloud" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Nextcloud - Alpine Linux</A>
        <DT><A HREF="https://hub.docker.com/_/nextcloud/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Docker</A>
        <DT><A HREF="https://www.youtube.com/watch?v=2733cRPudvI" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Bash Scripting on Linux (The Complete Guide) Class 01 - Course Introduction - YouTube</A>
        <DT><A HREF="https://www.xvideos.com/profiles/voluptuousdiena1989" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Voluptuousdiena1989 - Profile page - XVIDEOS.COM</A>
        <DT><A HREF="https://xhamster.com/users/numberonefan/videos" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">numberonefan's videos</A>
        <DT><A HREF="https://nixos.org/manual/nixos/stable/#sec-installation-manual" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">NixOS 23.05 manual | Nix & NixOS</A>
        <DT><A HREF="https://www.youtube.com/watch?v=fuWPuJZ9NcU" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">NixOS is Mindblowing - YouTube</A>
        <DT><A HREF="https://nixos.org/manual/nixos/stable/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">NixOS 23.05 manual | Nix & NixOS</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Installation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Installation - Alpine Linux</A>
        <DT><A HREF="https://docs.alpinelinux.org/user-handbook/0.1a/index.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Alpine User Handbook - Alpine Linux Documentation</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">Alpine setup scripts - Alpine Linux</A>
        <DT><A HREF="https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">setup-alpine - Alpine Linux Documentation</A>
        <DT><A HREF="https://github.com/mattn/vim-fz" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023sep26">GitHub - mattn/vim-fz: Ultra Fast Fuzzy Finder for Vim8</A>
        <DT><A HREF="http://www.openculture.com/2013/08/charles-bukowski-poem-read-by-bukowski-tom-waits-and-bono.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Listen to Charles Bukowski Poems Being Read by Bukowski Himself & the Great Tom Waits | Open Culture</A>
        <DT><A HREF="https://www.upworthy.com/a-robot-whose-sole-purpose-is-to-connect-emotionally-with-cancer-patients-its-working-too" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">A robot whose sole purpose is to connect emotionally with cancer patients. It's working, too. - Upworthy</A>
        <DT><A HREF="https://www.upworthy.com/videos" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Upworthy - Videos</A>
        <DT><A HREF="http://www.federationpress.com.au/bookstore/book.asp?isbn=9781862876224" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.verywellmind.com/psychology-4157187" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Psychology - Theories, History, and More</A>
        <DT><A HREF="https://trisquel.info/en/forum/vbox-additions-trisquel#comment-121732" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">VBOX Additions in Trisquel | Trisquel GNU/Linux - Run free!</A>
        <DT><A HREF="https://weather.com/en-GB/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Charing Cross, England Weather Forecast and Conditions - The Weather Channel | Weather.com</A>
        <DT><A HREF="https://communitylegalqld.org.au/webinar/human-rights-advocacy-tool" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="http://www.nssrn.org.au/?s=WDO" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.statelibraryofiowa.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home :: State Library of Iowa</A>
        <DT><A HREF="https://www.samsung.com/au/apps/bixby/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Bixby | Apps & Services | Samsung Australia</A>
        <DT><A HREF="http://downloadcenter.samsung.com/content/MC/201803/20180319194030927/EB/Len/006_appendix_1.html#1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">User Manual</A>
        <DT><A HREF="https://www.health.nsw.gov.au/tobacco/Pages/tools-for-health-professionals.aspx" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.accc.gov.au/media-release/summary-of-trade-practices-act-1974-issued-by-accc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Summary of Trade Practices Act 1974 issued by ACCC | ACCC</A>
        <DT><A HREF="https://www.australiancompetitionlaw.org/legislation/1974tpa.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Australian Competition Law</A>
        <DT><A HREF="https://www.legislation.nsw.gov.au/#/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home - NSW legislation</A>
        <DT><A HREF="https://www.legislation.nsw.gov.au/#/browse/asMade/acts/H" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home - NSW legislation</A>
        <DT><A HREF="https://www.sl.nsw.gov.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">State Library of NSW</A>
        <DT><A HREF="https://evernote.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Best Note Taking App - Organize Your Notes with Evernote</A>
        <DT><A HREF="https://www.facs.nsw.gov.au/myhousing" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">MyHousing | Family & Community Services</A>
        <DT><A HREF="https://account.samsung.com/membership/main" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Samsung Account</A>
        <DT><A HREF="https://www.wsws.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">World Socialist Web Site - Marxist analysis, international working class struggles & the fight for socialism</A>
        <DT><A HREF="https://neurosciencenews.com/music-synchronizes-brainwaves-eeg-10871/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Music Captivates Listeners and Synchronizes Their Brainwaves - Neuroscience News</A>
        <DT><A HREF="https://www.mindbodygreen.com/articles/anxious-beginning-relationships" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Relationship Anxiety: Signs And How To Work Through It | mindbodygreen</A>
        <DT><A HREF="https://www.lesswrong.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">LessWrong</A>
        <DT><A HREF="https://www.psychologytoday.com/intl/articles/199301/the-power-the-unpredictable" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Power of the Unpredictable | Psychology Today</A>
        <DT><A HREF="https://www.humanitix.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Humanitix - The humane choice for tickets</A>
        <DT><A HREF="https://www.radlivin.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://blog.ing.com.au/beyond-banking/dreamstarter/dreamstarter-inspires-future-social-changers-via-radlivin-festival/#article-1869" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">By ING - Beyond Banking</A>
        <DT><A HREF="https://help.twitter.com/en/managing-your-account/log-in-issues" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Help with logging in</A>
        <DT><A HREF="https://philosophy.stackexchange.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Philosophy Stack Exchange</A>
        <DT><A HREF="https://fractalenlightenment.com/tag/transformation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Transformation - Fractal Enlightenment</A>
        <DT><A HREF="https://fractalenlightenment.com/category/philosophy" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Philosophy - Fractal Enlightenment</A>
        <DT><A HREF="https://www.academia.edu/38705066/International_Journal_of_Organization_Theory_and_Behavior_Integrating_video_technology_and_administrative_practice_in_policing_A_phenomenological_expos%C3%A9_Article_information?email_work_card=view-paper" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">(PDF) International Journal of Organization Theory & Behavior Integrating video technology and administrative practice in policing: A phenomenological exposÃ© Article information | Maria Veronica Elias - Academia.edu</A>
        <DT><A HREF="https://www.hri.global/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home - Harm Reduction International</A>
        <DT><A HREF="https://m.slashdot.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Slashdot</A>
        <DT><A HREF="https://weather.com/en-GB/weather/radar/interactive/l/c9e870a28a58cb496d8ff8beaedb967c919d0f7d8450acb2151347bc690d6f3a" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sydney Central Business District, New South Wales, Australia Weather and Radar Map - The Weather Channel | Weather.com</A>
        <DT><A HREF="https://www.hotelscombined.com.au/Hotels/Search?destination=place%3ANew_York_City" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Compare & Save on Cheap Hotel Deals - HotelsCombined</A>
        <DT><A HREF="https://www.hri.global/hr19-programme?utm_source=HR19+Conference" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://weather.com/en-GB/weather/hourbyhour/l/6995307aef6d2360b6a43e4ebb68ebb2ea1f931bc3882f96124fbca38248e7d5" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hourly Weather Forecast for Auburn, New South Wales, Australia - The Weather Channel | Weather.com</A>
        <DT><A HREF="https://www.greenleft.org.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Green Left | For ecosocialist action</A>
        <DT><A HREF="https://onbeing.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home | The On Being Project</A>
        <DT><A HREF="https://onbeing.org/series/podcast/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">On Being with Krista Tippett | The On Being Project</A>
        <DT><A HREF="https://neurosciencenews.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Neuroscience News Science Magazine - Research Articles - Psychology Neurology Brains AI</A>
        <DT><A HREF="https://www.instagram.com/neurosciencenew/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Instagram</A>
        <DT><A HREF="https://www.9news.com.au/national/coronavirus-sydney-scare-as-china-heads-into-shutdown/71c2e099-d49b-42b9-b4b1-02bc4a0457a6?ref=BP_RSS_ninenews_0_-grave-situation--as-coronavirus-claims-another-life_260120" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Coronavirus infection rate expected to rise with fifth Australian victim</A>
        <DT><A HREF="https://apply.indeed.com/indeedapply/s/resumeApply" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.news.com.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">news.com.au â Australiaâs leading news site</A>
        <DT><A HREF="https://www.news.com.au/technology" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Technology | Latest Tech News & Science Updates | news.com.au â Australiaâs leading news site</A>
        <DT><A HREF="https://www.gumtree.com.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Gumtree: Australia's Free Marketplace. Find a car, job, furniture & more</A>
        <DT><A HREF="https://www.top10vpn.com/guides/vpn-leak-test/#which-vpns-leak-your-data-90-tested" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">VPN Leaks Explained: How to Fix IP, DNS, & WebRTC Leaks</A>
        <DT><A HREF="https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reference Manual For OpenVPN 2.4 | OpenVPN</A>
        <DT><A HREF="https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/#" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reference Manual For OpenVPN 2.4 | OpenVPN</A>
        <DT><A HREF="https://medicalfuturist.com/magazine" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Magazine - The Medical Futurist</A>
        <DT><A HREF="https://www.computerworld.com/article/3268630/android-apps-best-of-the-best.html#tk.ctw-infsb" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The best Android apps for business in 2023 | Computerworld</A>
        <DT><A HREF="https://thenextweb.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">TNW | The heart of tech</A>
        <DT><A HREF="https://www.salon.com/2017/11/05/best-political-podcasts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The 25 best political podcasts for anxious liberals (just like you!) | Salon.com</A>
        <DT><A HREF="https://www.sas.upenn.edu/~jtreat/progressive.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Progressive Links</A>
        <DT><A HREF="http://www.robertounger.com/en/category/lectures-and-courses/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.electionprojection.com/blogs/politics-and-election-news/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://iai.tv/video/cybersecurity-and-huawei-nigel-inkster-interview?utm_source=newsletter" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Cybersecurity and Huawei</A>
        <DT><A HREF="https://progressive.org/magazine/more-money-no-problem-leanza/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">More Money, No Problem - Progressive.org</A>
        <DT><A HREF="https://www.google.com/amp/s/www.digitaltrends.com/mobile/how-to-use-bixby/%3famp" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">What is Bixby? How to use Samsung's AI assistant | Digital Trends</A>
        <DT><A HREF="https://m.youtube.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">YouTube</A>
        <DT><A HREF="https://www.mayoclinic.org/about-this-site/advertising-sponsorship-policy" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Advertising and sponsorship policy - About This Site - Mayo Clinic</A>
        <DT><A HREF="https://the-rachel-maddow-show.simplecast.com/episodes/what-will-the-new-attorney-general-face-at-the-doj-in-the-wake-of-trumps-abuses-oO_81twN" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://weather.com/weather/hourbyhour/l/b08a0496fddb8b724472dd110cded234b90fd334da006284a18dcd252895678f?par=samsung_widget#detailIndex0" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hourly Weather Forecast for Erskineville, New South Wales, Australia - The Weather Channel | Weather.com</A>
        <DT><A HREF="https://www.reddit.com/register" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">reddit.com: Join the worldwide conversation</A>
        <DT><A HREF="https://conceptsphilosophy.wordpress.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.google.com/search?client=ms-android-samsung-bixby" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google</A>
        <DT><A HREF="https://www.reddit.com/r/PoliticalPhilosophy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reddit - Dive into anything</A>
        <DT><A HREF="https://www.collective-evolution.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Collective Evolution</A>
        <DT><A HREF="https://www.reddit.com/r/philosophy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reddit - Dive into anything</A>
        <DT><A HREF="https://aiexperiments.withgoogle.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google's latest experiments in Labs</A>
        <DT><A HREF="https://www.solidarity.net.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Solidarity Online | A socialist group in Australia</A>
        <DT><A HREF="http://m.truthdig.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://vimeo.com/143087954" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">HuffPost Live 2015 Reel on Vimeo</A>
        <DT><A HREF="https://forms.svha.org.au/svhs-visit/?specificLocation=yes" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://lichess.org/training" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Puzzles â¢ lichess.org</A>
        <DT><A HREF="https://fieldofvision.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Field of Vision</A>
        <DT><A HREF="https://www.chess.com/game/live/72652538411" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Chess: Wizzeur_xX_12372 vs Batan12982 - Chess.com</A>
        <DT><A HREF="http://www.bestoftheleft.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Best of the Left Podcast</A>
        <DT><A HREF="https://user-images.githubusercontent.com/10026824/34471853-af9cf32a-ef53-11e7-8229-de534058ddc4.gif" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://mobile.nytimes.com/blogs/learning/2016/02/24/our-100-most-popular-student-questions-for-debate-and-persuasive-writing/?referer=" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Our 100 Most Popular Student Questions for Debate and Persuasive Writing - The New York Times</A>
        <DT><A HREF="https://www.smh.com.au/by/tom-rabe-h1f8u2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tom Rabe | The Sydney Morning Herald</A>
        <DT><A HREF="https://lichess.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">lichess.org â¢ Free Online Chess</A>
        <DT><A HREF="https://codepen.io/challenges/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://accounts.google.com/ServiceLogin?hl=en" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sign in - Google Accounts</A>
        <DT><A HREF="http://www.makeuseof.com/tag/5-super-easy-tools-share-files-friends-devices/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">5 Super Easy Tools to Share Files With Friends or Your Devices</A>
        <DT><A HREF="https://m.ebay.com/sch/i.html?_from=R40" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Shop by Category | eBay</A>
        <DT><A HREF="https://www.chess.com/play/online/new" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Play Chess Online for Free with Friends & Family - Chess.com</A>
        <DT><A HREF="https://nimble.com.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Quick Cash Loans Online Australia: Get Paid Fast | Nimble</A>
        <DT><A HREF="http://bixby.samsung.com/commands" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.google.com.au/search?q=unfriendly+person" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">unfriendly person - Google Search</A>
        <DT><A HREF="https://www.google.com/search?q=completed+list+of+Alexa+commands" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">completed list of Alexa commands - Google Search</A>
        <DT><A HREF="http://socialworkpodcast.blogspot.com.au/?m=1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Social Work Podcast</A>
        <DT><A HREF="http://socialworkpodcast.blogspot.com.au/2016/02/untangled.html?m=1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Social Work Podcast: Parenting Teenage Girls: Interview with Lisa Damour, Ph.D.</A>
        <DT><A HREF="http://www.podsocs.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home | Podsocs</A>
        <DT><A HREF="https://www.shf.org.au/membership-volunteering/volunteering-with-the-fleet/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.marxists.org/audiobooks/index.htm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Marxism Audio Books</A>
        <DT><A HREF="https://www.marxists.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Marxists Internet Archive</A>
        <DT><A HREF="https://evolutioncounseling.com/grief-supposed-hurt/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Grief Is Supposed To Hurt - Evolution Counseling</A>
        <DT><A HREF="https://whatsyourgrief.com/grief-podcast/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">What's Your Grief Podcast - A Podcast about Life After Loss</A>
        <DT><A HREF="https://www.stitcher.com/podcast/whats-your-grief-podcast-series-grief-support-for-those-who/e/50379562" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Pandora</A>
        <DT><A HREF="http://nymag.com/scienceofus/2017/05/a-linguist-explains-what-close-friend-really-means.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">A Linguist Explains What 'Close Friend' Really Means -- Science of Us</A>
        <DT><A HREF="http://www.earwolf.com/show/beautiful-anonymous/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.google.com.au/search?client=ms-android-telstra-au" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google</A>
        <DT><A HREF="https://books.google.com.au/books?id=ozb7CwAAQBAJ" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Attachment-Informed Grief Therapy: The Clinicianâs Guide to Foundations and ... - Phyllis S. Kosminsky, John R. Jordan - Google Books</A>
        <DT><A HREF="https://www.theguardian.com/tv-and-radio/2016/dec/21/the-50-best-podcasts-of-2016" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The 50 best podcasts of 2016 | Television & radio | The Guardian</A>
        <DT><A HREF="https://www.google.com.au/amp/s/amp.reddit.com/r/sociology/comments/21rk2r/what_are_some_good_sociological_podcasts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reddit - Dive into anything</A>
        <DT><A HREF="https://thesocietypages.org/officehours/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Office Hours</A>
        <DT><A HREF="http://www.sciencemag.org/podcast/building-conscious-machines-tracing-asteroid-origins-and-how-world-s-oldest-forests-grew" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="http://www.sciencemag.org/podcasts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="http://www.sciencemag.org/podcast/putting-rescue-robots-test-ancient-scottish-village-buried-sand-and-why-costly-drugs-may" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.google.com.au/search?q=Failed+relationship+anyhow+to+be+compared+visit+agree+grief" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Failed relationship anyhow to be compared visit agree grief - Google Search</A>
        <DT><A HREF="https://www.vodafone.com.au/foundation/dreamlab" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">DreamLab focus areas</A>
        <DT><A HREF="https://duckduckgo.com/?q=+Google+alert+similar+features" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google alert similar features at DuckDuckGo</A>
        <DT><A HREF="http://sociologicalimagination.org/archives/category/podcasts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Sociological Imagination: accommodation for us</A>
        <DT><A HREF="https://www.socialsciencespace.com/author/socialsciencebites/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Social Science Bites, Author at Social Science Space</A>
        <DT><A HREF="https://thesocietypages.org/improv/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sociology Improv</A>
        <DT><A HREF="https://www.waysidechapel.org.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayside Chapel | Love Over Hate</A>
        <DT><A HREF="http://www.roughthreads.org/upcoming-events/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://salvos.org.au/sydneystreetlevel/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sydney Streetlevel Mission | The Salvation Army Australia</A>
        <DT><A HREF="http://sociologicalimagination.org/archives/16831" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Sociological Imagination: accommodation for us</A>
        <DT><A HREF="http://sociologicalimagination.org/archives/category/digital-sociology-2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Sociological Imagination: accommodation for us</A>
        <DT><A HREF="http://journals.sagepub.com/page/crs/podcasts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.reddit.com/r/sociology/comments/21rk2r/what_are_some_good_sociological_podcasts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reddit - Dive into anything</A>
        <DT><A HREF="http://partiallyexaminedlife.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home | The Partially Examined Life Philosophy Podcast | A Philosophy Podcast and Blog</A>
        <DT><A HREF="https://www.volunteeringaustralia.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home - Volunteering Australia</A>
        <DT><A HREF="http://www.3quarksdaily.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">3 Quarks Daily - Science Arts Philosophy Politics Literature</A>
        <DT><A HREF="http://leiterreports.typepad.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Leiter Reports: A Philosophy Blog</A>
        <DT><A HREF="http://philosophytutor.net/universityphilosophytutor/online-philosophy-degrees-by-distance-learning.shtml" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Online Philosophy Degrees by Distance Learning</A>
        <DT><A HREF="http://philosophy.uchicago.edu/podcasts/elucidations.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Podcasts, Interviews, and Lectures | Department of Philosophy</A>
        <DT><A HREF="https://m.soundcloud.com/partially-examined-life" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Stream Partially Examined Life music | Listen to songs, albums, playlists for free on SoundCloud</A>
        <DT><A HREF="http://languagegoesonholiday.blogspot.com.au/?m=1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">language goes on holiday</A>
        <DT><A HREF="https://qz.com/1049870/half-the-time-unpaywall-users-search-for-articles-that-are-legally-free-to-access/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Open access: Half the time Unpaywall users search for academic journal articles that are legally free to access</A>
        <DT><A HREF="http://www.tomshardware.com/answers/id-2151114/type-port-ethernet-converter.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://m.ebay.com/itm/Outdoor-USB-WiFi-Adapter-150Mbps-13dBi-High-Power-WiFi-Antenna-Signal-Receiver/112584450204?hash=item1a368e609c:g:ShAAAOSwRrlZ-nDj" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="http://www.dw.com/en/top-stories/fake-news/s-37071888" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.screenaustralia.gov.au/the-screen-guide/t/missing-persons-unit-series-2-2007/24188/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Missing Persons Unit series 2 (2007) - The Screen Guide - Screen Australia</A>
        <DT><A HREF="https://www.screenaustralia.gov.au/about-us/corporate-documents/policies/freedom-of-information" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Freedom of information - Policies - Corporate documents - About us - Screen Australia</A>
        <DT><A HREF="http://www.dmlp.org/legal-guide/publication-private-facts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Publication of Private Facts | Digital Media Law Project</A>
        <DT><A HREF="https://www.brainpickings.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Marginalian â Marginalia on our search for meaning.</A>
        <DT><A HREF="https://www.techlicious.com/guide/the-best-news-aggregation-sites/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Best News Aggregators - Techlicious</A>
        <DT><A HREF="http://www.supremecourt.justice.nsw.gov.au/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">NSW Supreme Court homepage</A>
        <DT><A HREF="http://media.telstra.com.au/home.mobile.android.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Telstra Media - Video, Sport, Music and Entertainment</A>
        <DT><A HREF="https://www.salon.com/2018/01/18/the-end-of-the-dream-portlandia-kicks-off-its-final-season/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The end of the dream: "Portlandia" kicks off its final season | Salon.com</A>
        <DT><A HREF="https://www.democracynow.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Democracy Now! | Democracy Now!</A>
        <DT><A HREF="https://partiallyexaminedlife.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home | The Partially Examined Life Philosophy Podcast | A Philosophy Podcast and Blog</A>
        <DT><A HREF="http://www.community.nsw.gov.au/about-us/community-services-caseworker-dashboard" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Caseworker statistics | Family & Community Services</A>
        <DT><A HREF="https://www.learnoutloud.com/Free-Audio-Video/Social-Sciences/-/Introduction-to-Sociology/43635" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Introduction to Sociology Free Video Course</A>
        <DT><A HREF="https://www.learnoutloud.com/Free-Courses/Social-Sciences/Sociology" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Free Sociology Courses</A>
        <DT><A HREF="https://notesonliberty.com/2018/01/03/law-and-liberty-hobbesians-vs-rechtsstaaters/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Law and Liberty: Hobbesians vs Rechtsstaaters | Notes On Liberty</A>
        <DT><A HREF="https://duckduckgo.com/?q=develop+workplace+communication+strategies" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">develop workplace communication strategies at DuckDuckGo</A>
        <DT><A HREF="https://duckduckgo.com/?q=apply+specialist+interpersonal+and+counselling+interview+skills" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">apply specialist interpersonal and counselling interview skills at DuckDuckGo</A>
        <DT><A HREF="https://duckduckgo.com/?q=provide+alcohol+and+other+drug+adult+services" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">provide alcohol and other drug adult services at DuckDuckGo</A>
        <DT><A HREF="https://duckduckgo.com/?q=analyse+impacts+of+the+two+logical+factors+on+clients+in+community+work+and+services" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">analyse impacts of the two logical factors on clients in community work and services at DuckDuckGo</A>
        <DT><A HREF="https://duckduckgo.com/?q=facilitate+workplace+debriefing+and+support+processes+and+workplace+learning+tutorials" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">facilitate workplace debriefing and support processes and workplace learning tutorials at DuckDuckGo</A>
        <DT><A HREF="https://duckduckgo.com/?q=assess+needs+of+clients+with+alcohol+and+other+drug+issues" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">assess needs of clients with alcohol and other drug issues at DuckDuckGo</A>
        <DT><A HREF="https://www.omh.ny.gov/omhweb/cogdys_manual/CogDysHndbk.htm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="buku bookmarks"></A>
        <DT><A HREF="https://www.medicinenet.com/dysthymia/article.htm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Persistent Depressive Disorder Treatment, Tests & Causes</A>
        <DT><A HREF="https://www.webmd.com/depression/features/anxiety-depression-mix" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Depression vs. Anxiety: Which One Do I Have?</A>
        <DT><A HREF="http://socialworkpodcast.blogspot.com.au/2016/11/self-psychology.html?m=1" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Social Work Podcast: Self Psychology for Social Workers: Interview with Tom Young, Ph.D.</A>
        <DT><A HREF="http://www.railmaps.com.au/routedetails.php?RouteSelect=104" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">T3 Bankstown / Liverpool line | T3 Train timetable | Sydney Trains</A>
        <DT><A HREF="https://www.eventbrite.com.au/e/mental-health-first-aid-2-day-training-course-tickets-42663159659?aff=eac2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Mental Health First Aid - 2 Day Training Course Tickets, Wed 28/02/2018 at 9:00 am | Eventbrite</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/627/how-can-i-change-vims-start-or-intro-screen" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">external command - How can I change Vim's start or intro screen? - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/30957/color-a-call-appendline" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">highlight - Color a call append(line) - Vi and Vim Stack Exchange</A>
        <DT><A HREF="https://stackoverflow.com/questions/22697414/appending-to-a-file-with-linux-system-call" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Appending to a file with linux system call - Stack Overflow</A>
        <DT><A HREF="https://stackoverflow.com/questions/55860391/how-to-split-a-line-of-text-and-append-that-line-to-each-element-in-scala-spark" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">arrays - How to split a line of text and append that line to each element in Scala/Spark - Stack Overflow</A>
        <DT><A HREF="https://openai.com/chatgpt" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+281">ChatGPT</A>
        <DT><A HREF="https://linuxhandbook.com/seq-command/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Seq Command in Linux [Explained With Examples]</A>
        <DT><A HREF="https://linuxhandbook.com/bash/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Bash Scripting Tutorial Series for Beginners [Free]</A>
        <DT><A HREF="http://dotshare.it/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">DotShare.it</A>
        <DT><A HREF="https://www.kali.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kali Linux</A>
        <DT><A HREF="https://www.kali.org/tools/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kali Tools</A>
        <DT><A HREF="https://www.kali.org/docs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kali Docs</A>
        <DT><A HREF="https://forums.kali.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kali Forums</A>
        <DT><A HREF="https://www.kali.org/kali-nethunter/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kali NetHunter</A>
        <DT><A HREF="https://www.exploit-db.com/google-hacking-database" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google Hacking DB</A>
        <DT><A HREF="https://www.offsec.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">OffSec</A>
        <DT><A HREF="https://www.mozilla.org/firefox/central/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Getting Started</A>
        <DT><A HREF="https://github.com/archlinux/archlinux-keyring" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - archlinux/archlinux-keyring: Arch Linux PGP keyring (read-only mirror)</A>
        <DT><A HREF="https://support.mozilla.org/en-US/questions/1382056" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">geo.provider.network.url no longer works | Firefox Support Forum | Mozilla Support</A>
        <DT><A HREF="https://github.com/batann/Dark-Vimwiki-Template" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">batann/Dark-Vimwiki-Template: HTML Templates for VimWiki Plugin for Vim</A>
        <DT><A HREF="https://geekdude.github.io/tech/ctags/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Getting started with Ctags with Vim and Git. - Aaron Young</A>
        <DT><A HREF="https://github.com/BrodieRobertson/vimwiki/blob/master/Grub%20Configuration.wiki" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vimwiki/Grub Configuration.wiki at master Â· BrodieRobertson/vimwiki</A>
        <DT><A HREF="https://linuxhandbook.com/usermod-command/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">8 Essential Examples of Usermod Command in Linux</A>
        <DT><A HREF="https://www.simplified.guide/linux/automatically-run-program-on-startup#running-a-program-automatically-on-new-bash-session" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to start program at Linux boot automatically</A>
        <DT><A HREF="https://www.simplified.guide/linux/automatically-run-program-on-startup" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to start program at Linux boot automatically</A>
        <DT><A HREF="https://www.usessionbuddy.com/post/How-to-Enable-Autocomplete-For-Command-Line-History-In-Bash-and-Zsh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Enable Autocomplete For Command Line History In Bash and Zsh</A>
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/user_interface/Extension_pages" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Extension pages - Mozilla | MDN</A>
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Your_first_WebExtension" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Your first extension - Mozilla | MDN</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/105424/mirroring-a-pane-between-two-windows" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">tmux - mirroring a pane between two windows - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://www.pgnmentor.com/files.html#openings" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Download PGN Files</A>
        <DT><A HREF="https://chess.stackexchange.com/questions/19633/chess-problem-database-with-pgn-or-fen" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Chess Problem Database with PGN or FEN - Chess Stack Exchange</A>
        <DT><A HREF="https://chessentials.com/chess-pgn-downloads/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Chess PGN Downloads - Chessentials</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/141100/extracting-a-string-from-fdisk-command" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell script - Extracting a string from fdisk command - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://stackoverflow.com/questions/18127245/using-the-output-of-fdisk-l-grep-disk-to-put-in-an-if-statement" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - Using the output of 'fdisk -l | grep Disk' to put in an 'if' statement - Stack Overflow</A>
        <DT><A HREF="https://github.com/search?q=github%20desktop%20for%20linux&type=repositories" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Repository search results</A>
        <DT><A HREF="http://www.ubuntugeek.com/recover-deleted-files-with-foremostscalpel-in-ubuntu.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Recover Deleted Files with Foremost,scalpel in Ubuntu â Ubuntu Geek</A>
        <DT><A HREF="https://linuxconfig.org/creating-a-bootable-usb-for-windows-10-and-11-on-linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Creating a Bootable USB for Windows 10 and 11 on Linux - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://askubuntu.com/questions/1094540/how-can-i-recover-my-files-and-my-system-after-running-rm-r-home-username#comment1802381_1094540" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">command line - How can I recover my files and my system after running rm -r /home/username? - Ask Ubuntu</A>
        <DT><A HREF="https://www.freecodecamp.org/news/build-your-own-dotfiles-manager-from-scratch/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Build Your Own Linux Dotfiles Manager from Scratch</A>
        <DT><A HREF="https://www.mailgun.com/blog/product/building-an-sms-to-email-gateway/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">What are the steps to setting up an SMS-to-Email gateway? | Mailgun</A>
        <DT><A HREF="https://www.systranbox.com/configuring-an-sms-gateway-server-in-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Configuring An SMS Gateway Server In Linux â Systran Box</A>
        <DT><A HREF="https://docs.oracle.com/cd/E61905_01/doc.100/e61907/im_config_sms_gtway_im.htm#IMSAG389" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Configuring the SMS Gateway</A>
        <DT><A HREF="https://docs.oracle.com/cd/E61905_01/doc.100/e61907/im_conf_cal_agt_cal_ser.htm#IMSAG408" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Configuring the Instant Messaging Server Calendar Agent</A>
        <DT><A HREF="http://linuxblog.darkduck.com/2014/01/sms-gateway-linux.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Easy Steps to Build Your SMS Gateway in Linux - Linux notes from DarkDuck</A>
        <DT><A HREF="https://www.xmodulo.com/how-to-run-fdisk-in-non-interactive-batch-mode.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to run fdisk in non-interactive batch mode</A>
        <DT><A HREF="https://www.baeldung.com/linux/usb-drive-format" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Format a USB Drive in Linux | Baeldung on Linux</A>
        <DT><A HREF="https://www.parrotsec.org/community/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25">Community</A>
        <DT><A HREF="https://www.parrotsec.org/team/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25">Parrot Team</A>
        <DT><A HREF="https://www.parrotsec.org/donate/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25">Donations and Gadgets</A>
        <DT><A HREF="https://connormcgarr.github.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Connor McGarr Blog</A>
        <DT><A HREF="https://speakerdeck.com/s1r1us/electrovolt-pwning-popular-desktop-apps-while-uncovering-new-attack-surface-on-electron" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">ElectroVolt: Pwning Popular Desktop Apps</A>
        <DT><A HREF="https://pypi.org/project/radicale-remind/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">radicale-remind Â· PyPI</A>
        <DT><A HREF="https://pypi.org/project/twc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">twc Â· PyPI</A>
        <DT><A HREF="https://pypi.org/project/tw-hooks/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">tw-hooks Â· PyPI</A>
        <DT><A HREF="https://pypi.org/project/notmuchtask/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">notmuchtask Â· PyPI</A>
        <DT><A HREF="https://radicale.org/master.html#documentation" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Radicale master Documentation</A>
        <DT><A HREF="https://www.parrotsec.org/donate" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25">Donations and Gadgets</A>
        <DT><A HREF="https://www.youtube.com/watch?v=uefwYLrWyhs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="2023jan12,2023jan25,2023mar25">How To Install Your Own Private Searx Instance In Ubuntu 20.04.4 LTS - YouTube</A>
        <DT><A HREF="https://humanrights.gov.au/quick-guide/12030" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Discrimination | Australian Human Rights Commission</A>
        <DT><A HREF="https://duckduckgo.com/?q=extract+links+from+html+file&t=ffab&ia=web&iax=qa" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">extract links from html file at DuckDuckGo</A>
        <DT><A HREF="https://linuxjourney.com/lesson/the-shell" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Learning | Linux Journey</A>
        <DT><A HREF="https://www.httrack.com/html/abuse.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">HTTrack Website Copier - Offline Browser</A>
        <DT><A HREF="https://learnvimscriptthehardway.stevelosh.com/chapters/12.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Autocommands / Learn Vimscript the Hard Way</A>
        <DT><A HREF="http://oualline.com/talks/ins/inspection/c_check.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Code Inspection Checklist</A>
        <DT><A HREF="http://oualline.com/talks/ins/inspection/c_style.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Coding Style Rules</A>
        <DT><A HREF="http://oualline.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Steve Oualline, The Practical Programmer</A>
        <DT><A HREF="https://www.computerhope.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Computer Hope's Free Computer Help</A>
        <DT><A HREF="http://oualline.com/vim/vim-cook.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Vim Cookbook</A>
        <DT><A HREF="http://oualline.com/vim/vim-cook.html#all_files" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Vim Cookbook</A>
        <DT><A HREF="http://web.archive.org/web/20130115130644/http://www.x.org/wiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">X.Org Wiki - Home</A>
        <DT><A HREF="http://web.archive.org/web/20121204194027/http://www.frexx.de/xterm-256-notes/data/xterm-colortest" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20130510015044/http://www.vim.org/scripts/script.php?script_id=1349" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Colortest - xterm 256 color test and visual colors list : vim online</A>
        <DT><A HREF="http://web.archive.org/web/20130125154845/https://www.gnu.org/software/screen/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GNU Screen - GNU Project - Free Software Foundation</A>
        <DT><A HREF="http://web.archive.org/web/20120125054006/http://www.frexx.de/xterm-256-notes/themes/desert256.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20090427105013/http://www.frexx.de/xterm-256-notes/themes/256_redblack.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20110131080145/http://www.frexx.de/xterm-256-notes/themes/256_darkdot.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20120825014533/http://www.frexx.de/xterm-256-notes/themes/256_blackdust.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20100825081744/http://www.frexx.de/xterm-256-notes/themes/256_automation.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20090427105157/http://www.frexx.de/xterm-256-notes/themes/256_asu1dark.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20130114222438/http://www.frexx.de/xterm-256-notes/themes/256_adaryn.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wayback Machine</A>
        <DT><A HREF="http://web.archive.org/web/20130125000058/http://www.frexx.de/xterm-256-notes/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The 256 color mode of xterm</A>
        <DT><A HREF="https://invisible-island.net/xterm/xterm.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">XTERM â Terminal emulator for the X Window System</A>
        <DT><A HREF="https://unix4lyfe.org/xterm/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">configuring xterm</A>
        <DT><A HREF="https://superuser.com/questions/137423/config-files-for-xterm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux - Config files for xterm - Super User</A>
        <DT><A HREF="https://how-to.fandom.com/wiki/How_to_configure_xterm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to configure xterm | How To Wiki | Fandom</A>
        <DT><A HREF="https://github.com/btdigg-org/dhtcrawler2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Btdigg-Org/dhtcrawler2: dhtcrawler is a DHT crawler written in erlang. It can join a DHT network and crawl many P2P torrents. The program save all torrent info into database and provide an http interface to search a torrent by a keyword</A>
        <DT><A HREF="https://www.youtube.com/watch?v=R11urV-j4-U" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Soft, Fluffy and Irresistible - Turkish Bread Without Oven! Incredibly Simple and Fast. - YouTube</A>
        <DT><A HREF="https://xhamster.com/pornstars/mimi-jean" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Mimi Jean 2023: Free Porn Star Videos @ xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/hairy-granny-and-youn-lover-8643603" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hairy Granny and Youn Lover, Free Mature Porn 34 | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/mature-14442317" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Mature: Mature Free Xxx & Wifes Porn Video d8 | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/granny-and-big-dick-7690313" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Granny and Big Dick: Big Dick Dvd Porn Video 17 | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/grandma-only-allows-to-fuck-in-her-ass-if-she-gets-the-cum-afterwards-xhJg7Ci" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Grandma Only Allows to Fuck in Her Ass if She gets the Cum Afterwards | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/auntjudysxxx-60yo-gilf-aliona-gets-caught-masturbating-xhb0IlD" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Auntjudysxxx - 60yo GILF Aliona gets Caught Masturbating | xHamster</A>
        <DT><A HREF="https://www.momvids.com/videos/11387/yvi-sie-heisst-uschi-und-ihr-juckt-die/?sub=100001" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Yvi - sie heiÃt Uschi und ihr juckt die - MomVids.com</A>
        <DT><A HREF="https://xhamster.com/videos/spermasuechtige-reife-milf-xhjw1T6?pw=" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Spermasuechtige Reife MILF, Free Mature Porn a4 | xHamster</A>
        <DT><A HREF="https://www.w3docs.com/learn-html/html-form-templates.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">60+ HTML Form Templates Free to Copy and Use</A>
        <DT><A HREF="https://docs.xfce.org/xfce/thunar/thunar-shares-plugin" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">xfce:thunar:thunar-shares-plugin [Xfce Docs]</A>
        <DT><A HREF="https://pypi.org/project/thunar-plugins/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">thunar-plugins Â· PyPI</A>
        <DT><A HREF="https://linuxconfig.org/how-to-extend-the-thunar-file-manager-with-custom-actions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to extend the Thunar file manager with custom actions - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://decodechess.com/pricing-plans/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Pricing Plans - DecodeChess</A>
        <DT><A HREF="https://github.com/coderiot/vimwiki-assets" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - coderiot/vimwiki-assets: Vimwiki Template with Twitter Bootstrap</A>
        <DT><A HREF="https://github.com/sjkowal/vimwiki_templates" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - sjkowal/vimwiki_templates: vimwiki templates used with html generation</A>
        <DT><A HREF="http://classic.austlii.edu.au/au/journals/MelbULawRw/2005/11.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Butler, Des --- "A Tort of Invasion of Privacy in Australia?" [2005] MelbULawRw 11; (2005) 29(2) Melbourne University Law Review 339</A>
        <DT><A HREF="https://sourceforge.net/projects/chess-engines-for-android/files/Samsung" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="cloud +fff">Chess Engines for Android - Browse Files at SourceForge.net</A>
        <DT><A HREF="https://linuxconfig.org/configuring-the-mpd-music-server-on-ubuntu-linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Configuring the MPD Music Server on Ubuntu Linux - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://docs.funkwhale.audio/installation/debian.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff,buku bookmarks"></A>
        <DT><A HREF="https://retropie.org.uk/docs/Debian/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Debian/Ubuntu - RetroPie Docs</A>
        <DT><A HREF="https://www.theguardian.com/commentisfree/2019/mar/22/death-human-right-assisted-dying" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Deciding how to end oneâs life should be the ultimate human right | Simon Jenkins | The Guardian</A>
        <DT><A HREF="https://mxlinux.org/wiki/applications/docker/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Docker â MX Linux</A>
        <DT><A HREF="https://wiki.gentoo.org/wiki/Handbook:AMD64" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Gentoo AMD64 Handbook - Gentoo wiki</A>
        <DT><A HREF="https://github.com/ziahamza/webui-aria2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">GitHub - ziahamza/webui-aria2: The aim for this project is to create the worlds best and hottest interface to interact with aria2. Very simple to use, just download and open index.html in any web browser.</A>
        <DT><A HREF="https://www.systranbox.com/how-to-install-nvidia-drivers-in-mx-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">How To Install Nvidia Drivers In MX Linux â Systran Box</A>
        <DT><A HREF="https://www.eduardoaleixo.com/posts/2022/vimwiki-diary-template/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Vimwiki/Taskwiki diary template Â· eduardoaleixo</A>
        <DT><A HREF="https://duckduckgo.com/?q=how+to+strukture+vimwiki" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">how to strukture vimwiki at DuckDuckGo</A>
        <DT><A HREF="https://github.com/termux/termux-app/issues/524Dropdown" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Issues Â· termux/termux-app Â· GitHub</A>
        <DT><A HREF="https://www.makeuseof.com/install-configure-mutt-with-gmail-on-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">How to Install and Configure Mutt With Gmail on Linux</A>
        <DT><A HREF="https://www.how2shout.com/linux/how-to-install-docker-engine-on-alpine-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">How to install Docker Engine on Alpine Linux - Linux Shout</A>
        <DT><A HREF="https://wiki.gentoo.org/wiki/Install_Gentoo_on_a_bootable_USB_stick" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Install Gentoo on a bootable USB stick - Gentoo wiki</A>
        <DT><A HREF="https://r2.community.samsung.com/t5/Tech-Talk/Installing-and-running-Ubuntu-and-other-Linux-OS-flavors-on-your/td-p/3534921" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Installing and running Ubuntu and other Linux OS f... - Samsung Members</A>
        <DT><A HREF="https://www.cyberciti.biz/faq/marvell-88w8335-chipset-netgear-wg311-pcicard-driver/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Linux Install and Configure Netgear WG311 Marvell 88w8335 Rev 03 Chipset Wireless Card - nixCraft</A>
        <DT><A HREF="https://developer.android.com/studio/run/emulator#install" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Run apps on the Android Emulator | Android Studio | Android Developers</A>
        <DT><A HREF="https://youtu.be/8XZjeNqVD50" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">BAVARSKO PECIVO-najbolji recept koji sam probala - YouTube</A>
        <DT><A HREF="https://youtu.be/C1R8N6UA980" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">Originalne Bavarske Perece i Kifle | Kao iz NjemaÄke #27 - YouTube</A>
        <DT><A HREF="https://github.com/devgianlu/aria2-android" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">GitHub - devgianlu/aria2-android: All you need to cross-compile aria2 for Android, not to be confused with the Aria2Android app.</A>
        <DT><A HREF="https://www.youtube.com/watch?v=w7i4amO_zaE" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">0 to LSP : Neovim RC From Scratch - YouTube</A>
        <DT><A HREF="https://superuser.com/questions/6892/sync-remote-folders-on-linux#6896" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+fff">command line - Sync remote folders on Linux - Super User</A>
        <DT><A HREF="https://xhamster.com/videos/just-a-whole-lot-of-fucking-8614422" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+porn">Just a Whole Lot of Fucking | xHamster</A>
        <DT><A HREF="https://xhamster.com/videos/shemale-madness-xhR0YH7" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+porn">Shemale MADNESS! | xHamster</A>
        <DT><A HREF="https://www.icetranny.com/movies/44763/-onlythabest-ladyboy-cumshots-compilation-5" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+porn">- OnlyThaBest - ladyboy Cumshots Compilation 5 at IceTranny.COM</A>
        <DT><A HREF="https://www.icetranny.com/movies/1061431/onlythabest-tranny-cumshots-compilation-5" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+porn">OnlyThaBest tranny Cumshots Compilation 5 at IceTranny.COM</A>
        <DT><A HREF="https://www.icetranny.com/movies/45076/-onlythabest-bianca" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+porn">- OnlyThaBest - Bianca at IceTranny.COM</A>
        <DT><A HREF="https://askubuntu.com/questions/16621/how-to-set-the-default-browser-from-the-command-line" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">configuration - How to set the Default Browser from the Command Line? - Ask Ubuntu</A>
        <DT><A HREF="https://buddy.works/actions/google-cloud-cli/alternatives" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Google Cloud CLI Alternatives and Free Competitors with Buddy</A>
        <DT><A HREF="https://cli.r-lib.org/articles/semantic-cli.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Building a Semantic CLI â¢ cli</A>
        <DT><A HREF="https://github.com/Bugswriter/tuxi" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/tuxi: Tuxi is a cli assistant. Get answers of your questions instantly.</A>
        <DT><A HREF="https://alternativeto.net/software/tuxi/about/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tuxi: Reviews, Features, Pricing & Download | AlternativeTo</A>
        <DT><A HREF="https://github.com/AppImageCrafters/appimage-cli-tool" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - AppImageCrafters/appimage-cli-tool: AppImage package manager</A>
        <DT><A HREF="https://www.privacytools.io/firefox-privacy-extensions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Best Firefox Privacy Extensions in 2023</A>
        <DT><A HREF="https://docs.flatpak.org/en/latest/usb-drives.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">USB Drives â Flatpak documentation</A>
        <DT><A HREF="https://askubuntu.com/questions/446156/pause-execution-and-wait-for-user-input" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - Pause execution and wait for user input - Ask Ubuntu</A>
        <DT><A HREF="https://askubuntu.com/questions/484993/run-command-on-anothernew-terminal-window" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Run command on another(new) terminal window - Ask Ubuntu</A>
        <DT><A HREF="https://askubuntu.com/questions/46627/how-can-i-make-a-script-that-opens-terminal-windows-and-executes-commands-in-the" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How can I make a script that opens terminal windows and executes commands in them? - Ask Ubuntu</A>
        <DT><A HREF="https://askubuntu.com/questions/883777/bash-script-to-open-multiple-terminal-widows" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">command line - Bash script to open multiple terminal widows? - Ask Ubuntu</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/155417/a-set-of-libraries-like-ncurses-in-a-shell-script" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">A set of libraries like ncurses in a shell script - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://github.com/pedro-hs/checkbox.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - pedro-hs/checkbox.sh: Interactive checkboxes (menu) with pagination and vim keybinds for bash</A>
        <DT><A HREF="https://gist.github.com/blurayne/f63c5a8521c0eeab8e9afd8baa45c65e" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Pure BASH interactive CLI/TUI menu (single and multi-select/checkboxes) Â· GitHub</A>
        <DT><A HREF="https://github.com/wfxr/tmux-fzf-url" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - wfxr/tmux-fzf-url: ð Quickly open urls on your terminal screen!</A>
        <DT><A HREF="https://gitlab.com/rwxrob/dotfiles" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Rob Muhlestein / dotfiles Â· GitLab</A>
        <DT><A HREF="https://www.youtube.com/watch?v=Vdd2MTv6vrs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Lynx Text Web Browser FTW! - YouTube</A>
        <DT><A HREF="https://tycrek.github.io/degoogle/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">degoogle | A huge list of alternatives to Google products. Privacy tips, tricks, and links.</A>
        <DT><A HREF="https://www.youtube.com/@InfoSecPat" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">InfoSec Pat - YouTube</A>
        <DT><A HREF="https://garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Garuda Homepage</A>
        <DT><A HREF="https://forum.garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Garuda Forum</A>
        <DT><A HREF="https://wiki.garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Garuda Wiki</A>
        <DT><A HREF="https://garudalinux.org/downloads.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Garuda Downloads</A>
        <DT><A HREF="https://distrowatch.com/table.php?distribution=garuda" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Distrowatch</A>
        <DT><A HREF="https://www.kali.org/docs/development/live-build-a-custom-kali-iso/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Creating A Custom Kali ISO | Kali Linux Documentation</A>
        <DT><A HREF="https://www.keekass.com/videos/61783/highlights-of-transgirl-porno-7-compilation/?utm_source=oklax&utm_medium=oklax&utm_campaign=oklax" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Highlights of Transgirl Porno 7 - Compilation</A>
        <DT><A HREF="https://videosection.com/shemales/video/167044524?utm_source=oklax&utm_medium=click&utm_campaign=oklax" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Shemale Cowgirl Compilation, Riding - Videosection.com</A>
        <DT><A HREF="https://ladyboyshere.com/compilation-videos" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">LADYBOY COMPILATION â¢ Ladyboys Here</A>
        <DT><A HREF="https://www.anyshemale.com/search/compilation/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Search Results for compilation</A>
        <DT><A HREF="https://www.bemyhole.com/v/hanna-rios-vs-asia-devil-mireja-ts-challenge-new-edition-450557046223/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hanna Rios VS Asia Devil Mireja (TS CHALLENGE NEW EDITION) - BeMyHole.com</A>
        <DT><A HREF="https://www.bemyhole.com/v/top-20-hottest-trans-babes-part-1-20-11-transsexualangel-290550043723/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Top 20 HOTTEST Trans Babes - BeMyHole.com</A>
        <DT><A HREF="https://github.com/LunarVim/Neovim-from-scratch" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - LunarVim/Neovim-from-scratch: ð A Neovim config designed from scratch to be understandable</A>
        <DT><A HREF="https://github.com/LazyVim/LazyVim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - LazyVim/LazyVim: Neovim config for the lazy</A>
        <DT><A HREF="https://stackoverflow.com/questions/10679188/casing-arrow-keys-in-bash" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Casing arrow keys in bash - Stack Overflow</A>
        <DT><A HREF="https://github.com/jarun/buku/tree/master/bukuserver#readme" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">buku/bukuserver at master Â· jarun/buku Â· GitHub</A>
        <DT><A HREF="http://7is7.com/software/firefox/shortcuts.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Firefox Keyboard & Mouse Shortcuts</A>
        <DT><A HREF="https://chessmood.com/course/win-won-positions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The WWP Pilot: Navigating Won Positions to Victory</A>
        <DT><A HREF="https://chessmood.com/course/save-lost-positions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SLP Method - The Art of Saving Lost Positions</A>
        <DT><A HREF="https://lichess.org/@/Avetik_ChessMood/blog/slp-method-how-to-save-lost-chess-positions/C44ecQCz" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SLP article</A>
        <DT><A HREF="https://chessmood.com/blog/slp-method-how-to-save-lost-positions" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Save Lost Positions</A>
        <DT><A HREF="https://chessmood.com/course/opening-principles" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Opening Principles</A>
        <DT><A HREF="https://chessmood.com/course/avetik-grigoryan-best-games" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">My 10 best games</A>
        <DT><A HREF="https://chessmood.com/course/gabuzyan-best-games" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GM Gabuzyanâs 10 best games</A>
        <DT><A HREF="https://chessmood.com/blog/win-won-games" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">https://chessmood.com/blog/win-won-games</A>
        <DT><A HREF="https://status.garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Uptimes</A>
        <DT><A HREF="https://connect.mozilla.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Home - Mozilla Connect</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/145294/how-to-continue-a-script-after-it-reboots-the-machine" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to continue a script after it reboots the machine? - Unix & Linux Stack Exchange</A>
        <DT><A HREF="http://http.kali.org/README.mirrorlist" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Mirror List</A>
        <DT><A HREF="https://github.com/htmm/better-mirror" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - htmm/better-mirror: A script that select the fastest mirror for Kali Linux</A>
        <DT><A HREF="https://www.linuxtopia.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">On-line Linux and Open Source Technology Books and How To Guides</A>
        <DT><A HREF="https://www.reddit.com/r/firefox/comments/ghta4f/initialize_firefox_user_files_through_cli_in_linux/?rdt=42475" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Initialize FireFox user files through CLI in Linux? : r/firefox</A>
        <DT><A HREF="https://superuser.com/questions/1278461/initialising-firefox-profile-from-command-line" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux - Initialising Firefox profile from command line - Super User</A>
        <DT><A HREF="https://www.google.com/search?channel=fs&client=ubuntu-sn&q=linux+sign+in+firefox+cli" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux sign in firefox cli - Google Search</A>
        <DT><A HREF="https://github.com/f/awesome-chatgpt-prompts" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">f/awesome-chatgpt-prompts: This repo includes ChatGPT prompt curation to use ChatGPT better.</A>
        <DT><A HREF="https://xhamster.com/videos/pissing-and-rough-fuck-with-mature-mother-6632133" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Pissing and rough fuck with mature mother | xHamster</A>
        <DT><A HREF="https://askubuntu.com/questions/64833/vi-shortcut-to-delete-until-the-next-x-character" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vim - vi shortcut to delete "until the next X character" - Ask Ubuntu</A>
        <DT><A HREF="https://www.reddit.com/r/vim/comments/11ntbmv/whats_your_vimrc_setup_for_2023/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Whats Your VIMRC Setup For 2023? : r/vim</A>
        <DT><A HREF="https://dotfiles.github.io/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub does dotfiles - dotfiles.github.io</A>
        <DT><A HREF="https://github.com/search?q=in%3Apath+vimrc&type=repositories" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Repository search results Â· GitHub</A>
        <DT><A HREF="https://github.com/topics/vimrc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vimrc Â· GitHub Topics Â· GitHub</A>
        <DT><A HREF="https://www.reddit.com/r/vimporn/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Vim porn</A>
        <DT><A HREF="http://dotshare.it/category/fms/ranger/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">DotShare.it</A>
        <DT><A HREF="https://www.reddit.com/r/vim/comments/a9xri2/any_sites_that_show_off_others_vim_configs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Any sites that show off others vim configs ? : r/vim</A>
        <DT><A HREF="https://wiki.archlinux.org/title/Dotfiles" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Dotfiles - ArchWiki</A>
        <DT><A HREF="https://superuser.com/questions/345877/prepend-only-lines-with-text-in-vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Prepend only lines with text in vim - Super User</A>
        <DT><A HREF="https://htmlpreview.github.io/?https://github.com/jaerrib/waterleaf-icon-theme/blob/development/dev_guide/waterleaf_guide.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Waterleaf icons composition guidelines</A>
        <DT><A HREF="https://www.q4os.org/dqa009.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Easy way to create custom application installer</A>
        <DT><A HREF="https://github.com/jluttine/nixos-configuration" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - jluttine/nixos-configuration: Personal NixOS configuration</A>
        <DT><A HREF="https://askubuntu.com/questions/641683/how-can-i-send-commands-to-specific-terminal-windows" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - How can I send commands to specific terminal windows? - Ask Ubuntu</A>
        <DT><A HREF="https://github.com/ArchiveBox/ArchiveBox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - ArchiveBox/ArchiveBox: ð Open source self-hosted web archiving. Takes URLs/browser history/bookmarks/Pocket/Pinboard/etc., saves HTML, JS, PDFs, media, and more...</A>
        <DT><A HREF="https://www.youtube.com/watch?v=WT75jfETWRg" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Nix derivations explained | Unleash the full potential of NixOS - YouTube</A>
        <DT><A HREF="https://opensource.com/article/18/9/linux-iptables-firewalld" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux firewalls: What you need to know about iptables and firewalld | Opensource.com</A>
        <DT><A HREF="https://bash-hackers.gabe565.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Bash Hackers Wiki</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/146570/arrow-key-enter-menu" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell - Arrow key/Enter menu - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://github.com/zellij-org/zellij/releases" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Releases Â· zellij-org/zellij Â· GitHub</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/539202/looking-for-command-line-package-for-showing-inline-text-based-menu-selector-wit" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - Looking for command line package for showing inline text-based menu selector with arrow keys - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/715893/bash-completely-cli-interactive-menu" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell script - Bash completely CLI interactive menu - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/480081/bash-question-using-read-can-i-capture-a-single-char-or-arrow-key-on-keyup" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">escape characters - BASH question: using read, can I capture a single char OR arrow key (on keyup) - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://stackoverflow.com/questions/58557541/how-to-create-a-list-of-option-and-selecting-it-using-arrow-key-in-shell" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to create a list of option and selecting it using arrow key in shell - Stack Overflow</A>
        <DT><A HREF="https://www.youtube.com/watch?v=FKU3Z2FilAM" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">3 GREAT Plugins for SpaceVim!! - YouTube</A>
        <DT><A HREF="https://asciinema.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">asciinema - Record and share your terminal sessions, the simple way</A>
        <DT><A HREF="https://yadm.io/docs/examples#" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Example Dotfiles - yadm</A>
        <DT><A HREF="https://www.freecodecamp.org/news/tag/linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux - freeCodeCamp.org</A>
        <DT><A HREF="https://github.com/SuperCuber/dotter" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - SuperCuber/dotter: A dotfile manager and templater written in rust ð¦</A>
        <DT><A HREF="https://crates.io/crates/dotter" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">dotter - crates.io: Rust Package Registry</A>
        <DT><A HREF="https://github.com/batann/dot/upload/main" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Upload files Â· batann/dot</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/356152/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile ___Striker___</A>
        <DT><A HREF="https://askubuntu.com/questions/32631/how-to-configure-firefox-from-terminal" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to configure firefox from terminal? - Ask Ubuntu</A>
        <DT><A HREF="https://packages.ubuntu.com/search?keywords=xulext-ubufox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Ubuntu â Package Search Results -- xulext-ubufox</A>
        <DT><A HREF="https://askubuntu.com/questions/59330/setting-system-wide-preferences-in-firefox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">configuration - Setting system wide preferences in Firefox - Ask Ubuntu</A>
        <DT><A HREF="https://support.mozilla.org/en-US/questions/1197798" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Can I export my settings (about:config)? | Firefox Support Forum | Mozilla Support</A>
        <DT><A HREF="https://gist.github.com/awerlang/32495828a68c7402de9cda964aca7fa4" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Firefox about:config privacy settings Â· GitHub</A>
        <DT><A HREF="https://askubuntu.com/questions/330937/is-it-possible-to-open-an-ubuntu-app-from-html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Is it possible to open an Ubuntu app from HTML? - Ask Ubuntu</A>
        <DT><A HREF="https://kitchen.nine.com.au/bourke-street-bakery-cookbook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Recipes from Bourke Street Bakery Cookbook - 9Kitchen</A>
        <DT><A HREF="https://github.com/Bugswriter/excel-table-creator" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/excel-table-creator: A python script for creating excel table without using excel easily.</A>
        <DT><A HREF="https://github.com/Bugswriter/alexa-api" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/alexa-api</A>
        <DT><A HREF="https://github.com/Bugswriter/redyt" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/redyt: Search reddit with CLI</A>
        <DT><A HREF="https://github.com/Bugswriter/arch-linux-magic" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/arch-linux-magic</A>
        <DT><A HREF="https://github.com/Bugswriter/dotfiles" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/dotfiles</A>
        <DT><A HREF="https://github.com/Bugswriter/zola-journal-template" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/zola-journal-template</A>
        <DT><A HREF="https://github.com/Bugswriter/notflix" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/notflix: Notflix is a shell script to search and stream torrent.</A>
        <DT><A HREF="https://github.com/Bugswriter/speed-test" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Bugswriter/speed-test</A>
        <DT><A HREF="https://github.com/Bugswriter?page=3&tab=repositories" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Bugswriter (Suraj Kushwah) Â· GitHub</A>
        <DT><A HREF="https://www.hongkiat.com/blog/extract-text-from-images-imgclip/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Extract Text from Images Using Command Line - Hongkiat</A>
        <DT><A HREF="https://superuser.com/questions/46730/convert-image-to-text" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux - Convert image to text - Super User</A>
        <DT><A HREF="https://www.addictivetips.com/ubuntu-linux-tips/copy-text-from-pictures-on-linux-with-textsnatcher/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Copy text from pictures on Linux with Textsnatcher - Addictive Tips Guide</A>
        <DT><A HREF="https://www.howtogeek.com/682389/how-to-do-ocr-from-the-linux-command-line-using-tesseract/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Do OCR from the Linux Command Line Using Tesseract</A>
        <DT><A HREF="https://betterprogramming.pub/how-to-monitor-your-machine-with-one-spectacular-cli-tool-a1c3313a409a" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How To Monitor Your Machine With One Spectacular CLI Tool â Btop | by Mirco on Tech | Better Programming</A>
        <DT><A HREF="https://github.com/RagnarokOS/iso/tree/main" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - RagnarokOS/iso: Live iso configuration files, etc.</A>
        <DT><A HREF="https://github.com/debian-live/live-config" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - debian-live/live-config: live-config</A>
        <DT><A HREF="https://github.com/debian-live/live-medium-install-tools/blob/debian/live-medium-install" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">live-medium-install-tools/live-medium-install at debian Â· debian-live/live-medium-install-tools Â· GitHub</A>
        <DT><A HREF="https://github.com/RagnarokOS/iso/tree/main/config/includes.chroot_after_packages" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">File not found Â· GitHub</A>
        <DT><A HREF="https://github.com/IanLeCorbeau/debian-live-build/tree/main/config/includes.chroot_after_packages/etc/skel" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">debian-live-build/config/includes.chroot_after_packages/etc/skel at main Â· IanLeCorbeau/debian-live-build Â· GitHub</A>
        <DT><A HREF="https://ianlecorbeau.github.io/blog/debian-live-build.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Ian LeCorbeau</A>
        <DT><A HREF="https://stackoverflow.com/questions/28656142/creating-a-shell-script-to-modify-and-or-create-bookmarks-in-firefox" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="bookmarks toolbar"></A>
        <DT><A HREF="https://superuser.com/questions/347964/simple-linux-cli-tool-to-dump-firefox-bookmarks-to-stdout" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Simple Linux CLI tool to dump Firefox bookmarks to stdout? - Super User</A>
        <DT><A HREF="https://www.youtube.com/watch?v=VL6tw6QBbmU" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">THE WITCH - Hollywood English Movie | Nicolas Cage Superhit Action Adventure Full Movie In English - YouTube</A>
        <DT><A HREF="https://www.reddit.com/r/vim/comments/t9lm4x/whats_your_best_autocmd/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">What's your best autocmd? : r/vim</A>
        <DT><A HREF="https://github.com/linuxcaffe/task-timelog-hook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - linuxcaffe/task-timelog-hook: A Taskwarrior hook that logs task start/stop times to a file that (h)ledger can read</A>
        <DT><A HREF="https://github.com/bergercookie?tab=repositories" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bergercookie (bergercookie) / Repositories Â· GitHub</A>
        <DT><A HREF="https://taskwarrior.org/tools/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tools - Taskwarrior</A>
        <DT><A HREF="https://github.com/coddingtonbear/timebook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - coddingtonbear/timebook: A fork of timebook including several new features (many originally added for Parthenon Software Group).</A>
        <DT><A HREF="https://github.com/GothenburgBitFactory/taskserver-setup" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - GothenburgBitFactory/taskserver-setup: A guide on how to setup the Taskserver.</A>
        <DT><A HREF="https://docs.ansible.com/ansible/latest/collections/community/general/xfconf_module.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">community.general.xfconf module â Edit XFCE4 Configurations â Ansible Documentation</A>
        <DT><A HREF="https://www.mozilla.org/en-GB/firefox/central/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Getting Started</A>
        <DT><A HREF="https://searx.garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Garuda searxng</A>
        <DT><A HREF="https://www.youtube.com/playlist?list=PLGBuKfnErZlBLNzS_JlDAeiH5aW26rvHc" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">60s & 70s Folk Music Hits Playlist - Greatest 1960's & 1970's Folk Songs - YouTube</A>
        <DT><A HREF="https://help.ubuntu.com/community/Grub2/ISOBoot" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Grub2/ISOBoot - Community Help Wiki</A>
        <DT><A HREF="https://github.com/qw3rtty/neix" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - qw3rtty/neix: neix - a RSS/Atom feed reader for your terminal.</A>
        <DT><A HREF="https://medevel.com/srss/#gsc.tab=0" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SRSS (Simple-RSS) is a CLI (Command Line Interface) terminal newsreader application for Old School Geeks</A>
        <DT><A HREF="https://radicale.org/v3.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Radicale v3 Documentation</A>
        <DT><A HREF="https://www.linuxtoday.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux Today: Linux News, Tutorials & Guides for 2022</A>
        <DT><A HREF="https://www.youtube.com/watch?v=0QCtaTwuqDE" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">My Vim workflow and SigmaVimRc - VIMCAST #01 - YouTube</A>
        <DT><A HREF="https://tyrrrz.me/blog/reverse-engineering-youtube-revisited" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reverse-Engineering YouTube: Revisited â¢ Oleksii Holub</A>
        <DT><A HREF="https://github.com/wikiti/pandoc-book-template" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - wikiti/pandoc-book-template: A simple Pandoc template to build documents and ebooks.</A>
        <DT><A HREF="https://dquinton.github.io/debian-install/netinstall/step1.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Step 1 - Netinstall CD</A>
        <DT><A HREF="http://127.0.0.1:7657/webmail" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Web Mail</A>
        <DT><A HREF="http://127.0.0.1:7657/i2ptunnel" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hidden Services Manager</A>
        <DT><A HREF="http://127.0.0.1:7657/i2psnark" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Bittorrent</A>
        <DT><A HREF="moz-extension://41d9c8ad-5228-490e-b9c4-15aafc048461/home.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">I2P Extension Home Page</A>
        <DT><A HREF="https://www.davidsimmons.com/soft/xtermhacks/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">xterm hacks</A>
        <DT><A HREF="https://github.com/opixelum/chatgpt-cli" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - opixelum/chatgpt-cli: ChatGPT but in your terminal.</A>
        <DT><A HREF="https://github.com/myyerrol/operating-system-test/tree/master/homework" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">operating-system-test/homework at master Â· myyerrol/operating-system-test Â· GitHub</A>
        <DT><A HREF="https://github.com/merazi/xterm-config/blob/xterm-config/Xresources" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">xterm-config/Xresources at xterm-config Â· merazi/xterm-config Â· GitHub</A>
        <DT><A HREF="https://github.com/kostajh/taskwarrior-time-tracking-hook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - kostajh/taskwarrior-time-tracking-hook: A simple Taskwarrior hook allowing one to track total time spent on a task.</A>
        <DT><A HREF="https://github.com/tbabej/taskpirate" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - tbabej/taskpirate: A pluggable system for tasklib based TaskWarrior hooks. Faster, less boilerplate code!</A>
        <DT><A HREF="https://github.com/HiveMinds/tw-install" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - HiveMinds/tw-install: Automatically installs Taskwarrior, Taskserver (TODO: and Timewarrior). This project aims to support automated installation of all Taskwarrior hook scripts, configuration flavours etc. with a single command.</A>
        <DT><A HREF="https://github.com/fmeynadier/taskwarrior-hamster-hook" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - fmeynadier/taskwarrior-hamster-hook: A minimal hook for TaskWarrior to track time with hamster-cli</A>
        <DT><A HREF="https://github.com/mrschyte/taskwarrior-hooks/tree/master/hooks" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">taskwarrior-hooks/hooks at master Â· mrschyte/taskwarrior-hooks Â· GitHub</A>
        <DT><A HREF="https://tuxurls.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">TuxURLs â A neat Linux news aggregator</A>
        <DT><A HREF="https://linuxhint.com/best_ubuntu_news_websites_blogs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Best 25 Ubuntu News Websites and Blogs</A>
        <DT><A HREF="https://www.makeuseof.com/tag/websites-linux-users/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">10 Websites All Linux Users Should Have Bookmarked</A>
        <DT><A HREF="https://alltop.com/linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux News 2020 - Best 12 Linux News Sites with Rss Feeds</A>
        <DT><A HREF="https://4kporn.xxx/videos/635036/julie-getting-her-booty-banged-inside-the-wc-with-a-huge-ebony-penis/?utm_source=pbw&utm_campaign=plugs" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Julie getting her booty banged! inside the WC with a huge ebony penis 4kPorn.XXX</A>
        <DT><A HREF="https://sourceforge.net/projects/voyagerlive/files/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Voyager - Browse Files at SourceForge.net</A>
        <DT><A HREF="https://sourceforge.net/projects/ultimateedition/files/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Ultimate Edition - Browse Files at SourceForge.net</A>
        <DT><A HREF="https://www.omglinux.com/chatgpt-command-line/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Using ChatGPT from the Command Line is Easy on Linux - OMG! Linux</A>
        <DT><A HREF="https://codepen.io/ianfarb/pen/mJZaGd" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hidden Social Links</A>
        <DT><A HREF="https://codepen.io/EduardL/pen/jObzJB" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Side Sliding Menu CSS</A>
        <DT><A HREF="https://codepen.io/baochn/pen/yLvPeaG" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Side links</A>
        <DT><A HREF="https://codepen.io/h4yfans/pen/VjKBWy" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Wikipedia Viewer</A>
        <DT><A HREF="https://stackoverflow.com/questions/22566373/tmux-how-to-restore-layout-after-changing-it-with-select-layout-or-next-layout" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">terminal - Tmux: how to restore layout after changing it with select-layout or next-layout? - Stack Overflow</A>
        <DT><A HREF="https://www.learnoutloud.com/Free-Audio-Video/Philosophy/-/Slavoj-Zizek-On-Melancholy/81739" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Slavoj Zizek: On Melancholy by Slavoj Zizek on Free Online Video</A>
        <DT><A HREF="https://github.com/AlexAshs/musicbee-on-linux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - AlexAshs/musicbee-on-linux: This script installs musicbee on linux (currently arch and debian based)</A>
        <DT><A HREF="https://getmusicbee.com/forum/index.php?topic=30205.30" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">[GUIDE] How to use Musicbee on Linux (Archlinux/Debian based distro)</A>
        <DT><A HREF="https://superuser.com/questions/538112/meaningful-thumbnails-for-a-video-using-ffmpeg" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">jpeg - Meaningful thumbnails for a Video using FFmpeg - Super User</A>
        <DT><A HREF="https://www.gnu.org/software/grub/manual/grub/grub.html#Installing-GRUB-using-grub_002dinstall" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GNU GRUB Manual 2.12</A>
        <DT><A HREF="https://getmusicbee.com/forum/index.php?topic=30205.0" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">[GUIDE] How to use Musicbee on Linux (Archlinux/Debian based distro)</A>
        <DT><A HREF="https://www.reddit.com/r/ranger/comments/12ibt7t/how_to_changeadd_custom_text_in_ranger_commands/?rdt=40369" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to change/add custom text in ranger command's contenxt menu ? : r/ranger</A>
        <DT><A HREF="https://superuser.com/questions/1048647/how-to-define-new-commands-in-the-ranger-file-manager" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to define new commands in the ranger file manager? - Super User</A>
        <DT><A HREF="https://unix.stackexchange.com/questions/65077/is-it-possible-to-see-cp-speed-and-percent-copied" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Is it possible to see cp speed and percent copied? - Unix & Linux Stack Exchange</A>
        <DT><A HREF="https://github.com/mileszs/ack.vim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - mileszs/ack.vim: Vim plugin for the Perl module / CLI script 'ack'</A>
        <DT><A HREF="https://github.com/ggreer/the_silver_searcher" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - ggreer/the_silver_searcher: A code-searching tool similar to ack, but faster.</A>
        <DT><A HREF="https://www.cyberciti.biz/open-source/command-line-hacks/ag-supercharge-string-search-through-directory-hierarchy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">ag - supercharge string search through a directory on a Linux - nixCraft</A>
        <DT><A HREF="https://www.reddit.com/r/bash/comments/khefxh/how_to_rearrange_bash_shell_script_output_in/?rdt=64851" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to rearrange Bash Shell script output in proper table format? : r/bash</A>
        <DT><A HREF="https://documentaryheaven.com/rupert-inside-north-korea/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Inside North Korea | Documentary Heaven</A>
        <DT><A HREF="https://www.tutorialspoint.com/unix_commands/tput.htm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">tput - Unix, Linux Command</A>
        <DT><A HREF="https://askubuntu.com/questions/68175/how-to-create-script-with-auto-complete" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - How to create script with auto-complete? - Ask Ubuntu</A>
        <DT><A HREF="https://simonlammer.github.io/MiniLinux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">MiniLinux</A>
        <DT><A HREF="http://humankind:8080/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kodi</A>
        <DT><A HREF="https://github.com/Wintermute0110/plugin.program.AML.dev/wiki/Browsing-MAME-machines" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Browsing MAME machines Â· Wintermute0110/plugin.program.AML.dev Wiki Â· GitHub</A>
        <DT><A HREF="https://www.falkon.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Falkon</A>
        <DT><A HREF="https://store.falkon.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Falkon Store</A>
        <DT><A HREF="https://www.kde.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">KDE Community</A>
        <DT><A HREF="https://planet.kde.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">KDE Planet</A>
        <DT><A HREF="https://wiki.syslinux.org/wiki/index.php?title=MEMDISK" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">MEMDISK - Syslinux Wiki</A>
        <DT><A HREF="https://www.explainshell.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">explainshell.com - match command-line arguments to their help text</A>
        <DT><A HREF="https://stackoverflow.com/questions/13433903/convert-all-linux-man-pages-to-text-html-or-markdown" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Convert all Linux man pages to text / html or markdown - Stack Overflow</A>
        <DT><A HREF="https://github.com/chubin/cheat.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - chubin/cheat.sh: the only cheat sheet you need</A>
        <DT><A HREF="http://bbebooksthailand.com/bb-CSS-boilerplate.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">BB eBooks â CSS Boilerplate</A>
        <DT><A HREF="https://taskwarrior.org/docs/udas/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Taskwarrior - User Defined Attributes (UDA) - Taskwarrior</A>
        <DT><A HREF="https://taskwarrior.org/docs/report/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Taskwarrior - Reports - Taskwarrior</A>
        <DT><A HREF="https://peter.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Peter Beverloo</A>
        <DT><A HREF="https://github.com/topics/rss-reader" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">rss-reader Â· GitHub Topics Â· GitHub</A>
        <DT><A HREF="https://www.htmlgoodies.com/css/displaying-rss-feeds-with-xhtml-css-and-jquery/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Displaying RSS Feeds with XHTML, CSS and JQuery | HTML Goodies</A>
        <DT><A HREF="https://dev.to/heraldofsolace/replace-your-existing-unix-utilities-with-these-modern-alternatives-2bfo" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Replace your Existing Unix Utilities with These Modern Alternatives - DEV Community</A>
        <DT><A HREF="https://github.com/ivan-lednev/obsidian-day-planner/tree/main" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - ivan-lednev/obsidian-day-planner: An Obsidian plugin for day planning with a clean UI and a simple task format</A>
        <DT><A HREF="https://chess.stackexchange.com/questions/44875/how-to-play-as-black-in-the-exchange-caro-kann" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">strategy - How to play as black in the exchange Caro-Kann? - Chess Stack Exchange</A>
        <DT><A HREF="https://github.com/netdata/netdata/blob/master/docs/configure/nodes.md" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">netdata/docs/configure/nodes.md at master Â· netdata/netdata Â· GitHub</A>
        <DT><A HREF="https://www.youtube.com/watch?v=VpZrwmXd6Tg" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">MusicBee Guide Part 16: Tagging Tools - YouTube</A>
        <DT><A HREF="https://musicbee.fandom.com/wiki/Skins" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Skins | MusicBee Wiki | Fandom</A>
        <DT><A HREF="https://tails.net/doc/encryption_and_privacy/encrypted_volumes/index.en.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tails - Creating and using LUKS encrypted volumes</A>
        <DT><A HREF="https://superuser.com/questions/584883/how-can-i-access-volumes-encrypted-with-luks-dm-crypt-from-windows" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">encryption - How can I access volumes encrypted with LUKS/dm-crypt from Windows? - Super User</A>
        <DT><A HREF="https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/security_hardening/encrypting-block-devices-using-luks_security-hardening" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">ChapterÂ 10.Â Encrypting block devices using LUKS Red Hat Enterprise Linux 8 | Red Hat Customer Portal</A>
        <DT><A HREF="https://www.redhat.com/sysadmin/disk-encryption-luks" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Configuring LUKS: Linux Unified Key Setup | Enable Sysadmin</A>
        <DT><A HREF="https://www.eff.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Electronic Frontier Foundation | Defending your rights in the digital world</A>
        <DT><A HREF="https://start.garudalinux.org/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Startpage</A>
        <DT><A HREF="https://www.ashemaletube.com/videos/990944/trix-mix-1/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Trix Mix #1 - aShemaletube.com</A>
        <DT><A HREF="https://www.ashemaletube.com/profiles/1119427/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Profile tslover14712</A>
        <DT><A HREF="https://www.eporner.com/video-aafS67oZ6Eu/penny-blake-is-having-some-bbc/?trx=1227735290aee694b81473a256bea12420712" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Penny Blake Is Having Some BBC - EPORNER</A>
        <DT><A HREF="https://stackoverflow.com/questions/3916191/download-data-url-file" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">javascript - Download data URL file - Stack Overflow</A>
        <DT><A HREF="https://github.com/AlexAshs/musicbee-on-linux/blob/main/install_musicbee.sh" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">musicbee-on-linux/install_musicbee.sh at main Â· AlexAshs/musicbee-on-linux Â· GitHub</A>
        <DT><A HREF="https://github.com/d99kris/idntag" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - d99kris/idntag: Automatically identify, tag and rename audio files on Linux and macOS</A>
        <DT><A HREF="https://www.reutersagency.com/en/reutersbest/reuters-best-rss-feeds/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Reuters Best RSS Feeds | Reuters News Agency</A>
        <DT><A HREF="https://github.com/rstacruz/cheatsheets" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - rstacruz/cheatsheets: My cheatsheets</A>
        <DT><A HREF="https://github.com/rstacruz?page=2&tab=repositories" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">rstacruz (Rico Sta. Cruz) Â· GitHub</A>
        <DT><A HREF="https://github.com/wbthomason/packer.nvim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - wbthomason/packer.nvim: A use-package inspired plugin manager for Neovim. Uses native packages, supports Luarocks dependencies, written in Lua, allows for expressive config</A>
        <DT><A HREF="https://github.com/kshitijaucharmal/Bard-Shell" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - kshitijaucharmal/Bard-Shell: Bard-Shell is a utility that allows you to use google's Bard ai in the linux terminal</A>
        <DT><A HREF="https://github.com/samoshkin/tmux-config" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - samoshkin/tmux-config: Tmux configuration, that supercharges your tmux to build cozy and cool terminal environment</A>
        <DT><A HREF="https://beebom.com/how-use-chatgpt-linux-terminal/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Use ChatGPT in Linux Terminal (2024) | Beebom</A>
        <DT><A HREF="https://github.com/santinic/how2" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - santinic/how2: AI for the Command Line</A>
        <DT><A HREF="https://github.com/neovim/neovim/blob/master/INSTALL.md" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">neovim/INSTALL.md at master Â· neovim/neovim Â· GitHub</A>
        <DT><A HREF="https://github.com/tmux-plugins/tpm" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - tmux-plugins/tpm: Tmux Plugin Manager</A>
        <DT><A HREF="https://github.com/catppuccin/tmux" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - catppuccin/tmux: ð½ Soothing pastel theme for Tmux!</A>
        <DT><A HREF="https://github.com/catppuccin/catppuccin" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - catppuccin/catppuccin: ð¸ Soothing pastel theme for the high-spirited!</A>
        <DT><A HREF="https://www.trackawesomelist.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Track Awesome List - Track your Favorite Github Awesome List Daily</A>
        <DT><A HREF="https://www.youtube.com/watch?v=vDEoVSscuZw" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+music">Lo mejor de Paganini - Por eso a Paganini se le conoce como el violinista del diablo. - YouTube</A>
        <DD>#musicaclasica #violin #paganini Esta lista de reproducciÃ³n estÃ¡ hecha por Rafael Krux. Es un compositor talentoso y creativo, capaz de crear mÃºsica hermosa...
        <DT><A HREF="https://www.fapnado.xxx/videos/24803/naughty-mature-sofia-del-mar-is-playing-with-herself-on-a-balcony-in-the-blazing-sun/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Naughty mature Sofia del Mar is playing with herself on a balcony in the blazing sun at Fapnado</A>
        <DT><A HREF="https://xhamster.com/videos/hot-skinny-blonde-granny-fucks-on-the-highway-grandmams-com-8128610" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hot Skinny Blonde Granny fucks on the Highway GrandMams.com | xHamster</A>
        <DT><A HREF="https://www.bigporn.com/shemales/tag-compilation/1.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Compilation Shemale Porn Videos</A>
        <DT><A HREF="https://bbs.archlinux.org/viewtopic.php?id=243226/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">[SOLVED] grub-install: error: failed to get canonical path of `/efiÂ´. / Installation / Arch Linux Forums</A>
        <DT><A HREF="http://10minutemail.com/10MinuteMail/index.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.redhat.com/sysadmin/learn-bash-scripting/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">13 resources for learning to write better Bash code | Enable Sysadmin</A>
        <DD>Whether you're new to writing scripts or you've been using Bash for years, there's always something to learn. Boost your scripting skills with these guides, tutorials, and examples.
        <DT><A HREF="https://www.hostinger.com/tutorials/bash-script-example/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">25 Easy Bash Script Examples To Get You Started</A>
        <DD>If you want to learn the fundamentals of bash scripting, read this article to find 25 bash scripting examples.
        <DT><A HREF="https://proprivacy.com/privacy-service/comparison/private-search-engines/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">5 Best Private Search Engines in 2023 | Browse anonymously</A>
        <DD>Popular search engines track you, but, by using a private search engine you can avoid that. Here are the best anonymous search engines to use today.
        <DT><A HREF="https://stackoverflow.com/questions/51142253/add-python-support-to-vim/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">add python support to vim - Stack Overflow</A>
        <DD>So, I've tried the instructions here, and they don't seem to work. One problem could be the config directory specified in the instructions is wrong, so I change the configuration instructions to c...
        <DT><A HREF="https://azero.dev/#/accounts/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Azero.Dev</A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Main_Page/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://anonymouse.org/anonemail.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://serverfault.com/questions/629778/which-open-source-program-is-similar-to-the-linux-dialog-command/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - Which open source program is similar to the Linux "dialog" command? - Server Fault</A>
        <DD>The linux dialog command is a great tool for creating dialog boxes in terminal windows (e.g. in a bash script). However, there is a drawback of dialog which is that the window is always positioned...
        <DT><A HREF="https://stackoverflow.com/questions/25929369/which-open-source-program-is-similar-to-the-linux-dialog-command/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash - Which open source program is similar to the Linux "dialog" command? - Stack Overflow</A>
        <DD>Dialog command is great command to view GUI dialog box But the non positive of the dialog is that we cant to locate the GUI window on the top of the screen or in the lower screen
Dialog always sho...
        <DT><A HREF="https://linuxconfig.org/tag/bash/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash Archives - Linux Tutorials - Learn Linux Configuration</A>
        <DT><A HREF="https://stackoverflow.com/questions/42371156/bash-dialog-inputbox-with-variable-entered/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">bash dialog inputbox with variable entered - Stack Overflow</A>
        <DD>I'm struggling with this code: komanda=$(dialog --title "COMMAND" --backtitle "ENTER COMMAND: "
--inputbox "" 8 180 2>&1 >/dev/tty) if [ $? == 0 ] then for ((j=0;j<$tlen;j++))...
        <DT><A HREF="https://linuxconfig.org/bash-scripting-tutorial-for-beginners/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Bash Scripting Tutorial for Beginners - Linux Tutorials - Learn Linux Configuration</A>
        <DD>Bash Scripting Tutorial for Beginners
        <DT><A HREF="https://www.binance.com/en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Binance - Cryptocurrency Exchange for Bitcoin, Ethereum & Altcoins</A>
        <DD>Binance cryptocurrency exchange - We operate the worlds biggest bitcoin exchange and altcoin crypto exchange in the world by volume
        <DT><A HREF="https://www.bitaddress.org/bitaddress.org-v3.3.0-SHA256-dec17c07685e1870960903d8f58090475b25af946fe95a734f88408cef4aa194.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://ux.stackexchange.com/questions/120001/alternatives-to-modal-dialog-for-simple-forms/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">buttons - Alternatives to modal dialog for simple forms - User Experience Stack Exchange</A>
        <DD>I have a button that pops a simple modal form. The form takes a name, description and has a save button. I am not a fan of having a button to the left of the screen, a dialog that pops in the cen...
        <DT><A HREF="https://browserleaks.com/canvas/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Canvas Fingerprinting - BrowserLeaks</A>
        <DD>Canvas fingerprinting is a tracking method that uses HTML5 Canvas code to generate a unique identifier for each individual user. The method is based on the fact that the unique pixels generated through Canvas code can vary depending on the system and browser used, making it possible to identify users.
        <DT><A HREF="https://cezex.io/#/price-all/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Crypto Casino Liste ðï¸ Online Casinos mit KryptowÃ¤hrung</A>
        <DD>Top Crypto Casinos im Ãberblick â© Alle Krypto Casino Coins âï¸ Aktuelle Infos und das beste Crypto Casino fÃ¼r deutscher Spieler.
        <DT><A HREF="https://torguard.net/checkmytorrentipaddress.php?hash=65fd3f647d2a679bdc4ad2e47bbda2b1043eaba2/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Check My Torrent IP | Proxy & VPN Verification | TorGuard</A>
        <DD>Check your torrent IP to verify your proxy or VPN services are working to ensure online safety. Check your torrent IP at TorGuard.net.
        <DT><A HREF="https://gist.github.com/DataSherlock/58e6285dbd11cbba9d29b32c5480521d/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">ChessPGNParser.py Â· GitHub</A>
        <DD>GitHub Gist: instantly share code, notes, and snippets.
        <DT><A HREF="https://discordapp.com/invite/KEFErEx/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Discord</A>
        <DD>Discord is the easiest way to communicate over voice, video, and text. Chat, hang out, and stay close with your friends and communities.
        <DT><A HREF="https://www.guru99.com/data-communication-computer-network-tutorial.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Computer Network Tutorial for Beginners</A>
        <DD>A computer network, or data network, is a digital telecommunications network which allows nodes to share resources. In computer networks, computing devices exchange data with each other using connecti
        <DT><A HREF="https://www.ohchr.org/en/instruments-mechanisms/instruments/convention-against-torture-and-other-cruel-inhuman-or-degrading/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Convention against Torture and Other Cruel, Inhuman or Degrading Treatment or Punishment | OHCHR</A>
        <DD>Entry into force: 26 June 1987, in accordance with article 27 (1) The States Parties to this Convention, Considering that, in accordance with the principles proclaimed in the Charter of the United Nations, recognition of the equal and inalienable rights of all members of the human family is the foundation of freedom, justice and peace in the world, Recognizing that those rights derive from the inherent dignity of the human person,
        <DT><A HREF="https://duckduckgo.com/?q=copy+from+ssh+client+to+host/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">copy from ssh client to host/ at DuckDuckGo</A>
        <DD>DuckDuckGo. Privacy, Simplified.
        <DT><A HREF="https://blog.self.li/post/74294988486/creating-a-post-installation-script-for-ubuntu/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Creating a post-installation script for Ubuntu | self.li - blog by Peter Legierski</A>
        <DD>Creating a post-installation script for Ubuntu I want to share with you today how to create your own bash script that can be used to bootstrap a fresh installation of Ubuntu (and very likely any other...
        <DT><A HREF="https://walletinvestor.com/converter/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Cryptocurrency Calculator & Converter - WalletInvestor.com</A>
        <DD>Online CryptoCurrency Calculator with multi-Cryptocurrencies.
        <DT><A HREF="https://github.com/jarun/buku/wiki/Customize-colors/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Customize colors Â· jarun/buku Wiki Â· GitHub</A>
        <DD>:bookmark: Personal mini-web in text. Contribute to jarun/buku development by creating an account on GitHub.
        <DT><A HREF="https://support.mozilla.org/en-US/kb/customize-firefox-controls-buttons-and-toolbars?utm_source=firefox-browser&utm_medium=default-bookmarks&utm_campaign=customize/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Customize Firefox controls, buttons and toolbars | Firefox Help</A>
        <DD>You can customize Firefox in many ways. This article explains how to customize Firefox controls, buttons and toolbars.
        <DT><A HREF="https://talosintelligence.com/fullpage_maps/pulse?__cf_chl_jschl_tk__=d8606de8e8d992f81979cff17898eac51835e80e-1615699239-0-AS8Ebf8Q8sHMWu1iKhC-l6hylqTP1PExnMqVp9OMbXnjXXGe4PwnTbDXfluWlzgEe5tW02keOWjQvDQzcJSv_0HMH9_cGhJd13AW9coDbCFA2jVzAvTEZzTe3KZm84D38oDN_kV1emLlyXZrDSJWU9R8sR4o5u9StkTIFyKzMYlPP7pdwDT4zUZmQEfyjFNsZIVzgK6RXyOwwyAYDJDZMFYBIc3n8dqV2ngGJxdUUQVn4cNw5KMWvANY3rg5Rq-BB4GM_WOOwAbqAPwWKnMEl6EWsPzHF-6lvXojUYyPlzZ1vq3I43DbDFQ2_JLxXWoNr3-A40GW287DtWRIfOy_VhF6TgDwv3LCQ1H0R2q7CSw9CLn1GBEk1lOakNH41FGjTPPWhaKviE8x1y9NyDCPok4tnKhqiqKDVxd4gt40Vr1i/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.hackthebox.com/hacker/infosec-careers/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Cybersecurity Jobs & Careers. Stand Out To Recruiters With HTB</A>
        <DD>Land your dream cybersecurity job with Hack The Box. Companies like AWS, Verizon, and Daimler use HTB to hire cybersecurity professionals with proven skills.
        <DT><A HREF="https://cointool.app/dashboard/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">CoinTool</A>
        <DD>cointool.app It's an online crypto toolbox
        <DT><A HREF="https://www.debian.org/doc/user-manuals#debian-handbook/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Debian -- Debian Users' Manuals</A>
        <DT><A HREF="https://www.deepl.com/translator/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">DeepL Translate: The world's most accurate translator</A>
        <DD>Translate texts & full document files instantly. Accurate translations for individuals and Teams. Millions translate with DeepL every day.
        <DT><A HREF="https://vimeo.com/user1690209/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Derek Wyatt</A>
        <DD>I'm using vimeo to pop up some videos on the Vim (http://www.vim.org) text editor. I love this thing...
        <DT><A HREF="https://www.dexlab.space/mintinglab/spl-token/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Dexlab | The best DEX platform on SOLANA.</A>
        <DD>Dexlab is a decentralized exchange where the best Solana projects mint and list their tokens.
        <DT><A HREF="https://alternativeto.net/software/dialog/?platform=linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">dialog Alternatives: Top 10 Shells & Similar Apps | AlternativeTo</A>
        <DD>The best dialog alternatives are Glade, Yad and Zenity. Our crowd-sourced lists contains more than 10 apps similar to dialog for Linux, Windows, Mac, Python and more.
        <DT><A HREF="https://www.digitalattackmap.com/#anim=1&color=0&country=ALL&list=0&time=18205&view=map/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Digital Attack Map</A>
        <DD>Digital Attack Map - DDoS attacks around the globe
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Dualbooting/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.youtube.com/watch?v=stqUbv-5u2s/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Effective Neovim: Instant IDE - YouTube</A>
        <DD>Going from no set up to instant IDE using kickstart.nvim in #nvim.Check out the repo: https://github.com/nvim-lua/kickstart.nvimPDE Video: https://youtu.be/Q...
        <DT><A HREF="https://www.youtube.com/watch?v=fGQvXNlosTc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Embrace The Power of GUIs With Yet Another Dialog - YouTube</A>
        <DD>Today we're looking at a really neat tool for building GTK dialogs from your terminal called yad otherwise as yet another dialog, this isn't the only tool of...
        <DT><A HREF="https://ether-mixer.org/start-mixing.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://explainshell.com/explain?cmd=pandoc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">explainshell.com</A>
        <DT><A HREF="https://vi.stackexchange.com/questions/39627/export-libreoffice-thesaurus-to-vim-compatible-format-with-a-macro/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Export Libreoffice Thesaurus to Vim compatible format with a macro? - Vi and Vim Stack Exchange</A>
        <DD>It has been impossible for me to find an offline Spanish thesaurus in a format that worked in Vim. Libreoffice Spanish Thesaurus looks good, needs some conditional modifications and is 66000 lines ...
        <DT><A HREF="https://www.fireeye.com/cyber-map/threat-map.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://stackoverflow.com/questions/946189/how-can-i-set-default-homepage-in-ff-and-chrome-via-javascript/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">firefox - How can I set default homepage in FF and Chrome via javascript? - Stack Overflow</A>
        <DD>I have a code that works only in IE anb I was looking for something similar in FF and Chrome to set user's default homepage through a link 'click here to make this site your default homepage', but ...
        <DT><A HREF="https://support.mozilla.org/en-US/products/firefox/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Firefox Help</A>
        <DT><A HREF="https://wiki.mozilla.org/Firefox/CommandLineOptions/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://www.vpnbook.com/webproxy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://www.calmar.ws/div/fritz_and_wine.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.tandfonline.com/doi/full/10.1080/14753634.2013.778485/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://github.com/0xRadi/OWASP-Web-Checklist/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - 0xRadi/OWASP-Web-Checklist: OWASP Web Application Security Testing Checklist</A>
        <DD>OWASP Web Application Security Testing Checklist. Contribute to 0xRadi/OWASP-Web-Checklist development by creating an account on GitHub.
        <DT><A HREF="https://github.com/ashemery/exploitation-course/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - ashemery/exploitation-course: Offensive Software Exploitation Course</A>
        <DD>Offensive Software Exploitation Course. Contribute to ashemery/exploitation-course development by creating an account on GitHub.
        <DT><A HREF="https://github.com/awesome-lists/awesome-bash/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - awesome-lists/awesome-bash: A curated list of delightful Bash scripts and resources.</A>
        <DD>A curated list of delightful Bash scripts and resources. - GitHub - awesome-lists/awesome-bash: A curated list of delightful Bash scripts and resources.
        <DT><A HREF="https://github.com/cshum/scm-music-player.git/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - cshum/scm-music-player: Seamless music for your website. HTML5 music player with continuous playback cross pages.</A>
        <DD>Seamless music for your website. HTML5 music player with continuous playback cross pages. - GitHub - cshum/scm-music-player: Seamless music for your website. HTML5 music player with continuous playback cross pages.
        <DT><A HREF="https://github.com/Cyclenerd/postinstall/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Cyclenerd/postinstall: ð» Bash Script to automate post-installation steps</A>
        <DD>ð» Bash Script to automate post-installation steps. Contribute to Cyclenerd/postinstall development by creating an account on GitHub.
        <DT><A HREF="https://github.com/dadyarri/dotfiles/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - dadyarri/dotfiles: Dotfiles for some programs i use in my daily work on Fedora Linux</A>
        <DD>Dotfiles for some programs i use in my daily work on Fedora Linux - GitHub - dadyarri/dotfiles: Dotfiles for some programs i use in my daily work on Fedora Linux
        <DT><A HREF="https://github.com/enaqx/awesome-pentest/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - enaqx/awesome-pentest: A collection of awesome penetration testing resources, tools and other shiny things</A>
        <DD>A collection of awesome penetration testing resources, tools and other shiny things - GitHub - enaqx/awesome-pentest: A collection of awesome penetration testing resources, tools and other shiny things
        <DT><A HREF="https://github.com/FiloSottile/mkcert/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - FiloSottile/mkcert: A simple zero-config tool to make locally trusted development certificates with any names you'd like.</A>
        <DD>A simple zero-config tool to make locally trusted development certificates with any names you'd like. - GitHub - FiloSottile/mkcert: A simple zero-config tool to make locally trusted development certificates with any names you'd like.
        <DT><A HREF="https://github.com/kevinstadler/taskwarrior-vit-config/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - kevinstadler/taskwarrior-vit-config: a taskwarrior - vit - vimwiki pipeline</A>
        <DD>a taskwarrior - vit - vimwiki pipeline. Contribute to kevinstadler/taskwarrior-vit-config development by creating an account on GitHub.
        <DT><A HREF="https://github.com/Konfekt/vim-thesauri/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Konfekt/vim-thesauri: A couple of thesaurus files for Vim synomym completion</A>
        <DD>A couple of thesaurus files for Vim synomym completion - GitHub - Konfekt/vim-thesauri: A couple of thesaurus files for Vim synomym completion
        <DT><A HREF="https://github.com/kraxli/vimwiki-task/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - kraxli/vimwiki-task: an addon for vimwiki to manage task and todo lists</A>
        <DD>an addon for vimwiki to manage task and todo lists - GitHub - kraxli/vimwiki-task: an addon for vimwiki to manage task and todo lists
        <DT><A HREF="https://github.com/neovim/pynvim/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - neovim/pynvim: Python client and plugin host for Nvim</A>
        <DD>Python client and plugin host for Nvim. Contribute to neovim/pynvim development by creating an account on GitHub.
        <DT><A HREF="https://github.com/Okazari/Rythm.js.git/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - Okazari/Rythm.js: A javascript library that makes your page dance.</A>
        <DD>A javascript library that makes your page dance. Contribute to Okazari/Rythm.js development by creating an account on GitHub.
        <DT><A HREF="https://github.com/rafi/awesome-vim-colorschemes/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - rafi/awesome-vim-colorschemes: Collection of awesome color schemes for Neo/vim, merged for quick use.</A>
        <DD>Collection of awesome color schemes for Neo/vim, merged for quick use. - GitHub - rafi/awesome-vim-colorschemes: Collection of awesome color schemes for Neo/vim, merged for quick use.
        <DT><A HREF="https://github.com/RPISEC/MBE/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - RPISEC/MBE: Course materials for Modern Binary Exploitation by RPISEC</A>
        <DD>Course materials for Modern Binary Exploitation by RPISEC - GitHub - RPISEC/MBE: Course materials for Modern Binary Exploitation by RPISEC
        <DT><A HREF="https://github.com/sbilly/awesome-security/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - sbilly/awesome-security: A collection of awesome software, libraries, documents, books, resources and cools stuffs about security.</A>
        <DD>A collection of awesome software, libraries, documents, books, resources and cools stuffs about security. - GitHub - sbilly/awesome-security: A collection of awesome software, libraries, documents, books, resources and cools stuffs about security.
        <DT><A HREF="https://github.com/seebi/tmux-colors-solarized/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - seebi/tmux-colors-solarized: A color theme for the tmux terminal multiplexer using Ethan Schoonoverâs Solarized color scheme</A>
        <DD>A color theme for the tmux terminal multiplexer using Ethan Schoonoverâs Solarized color scheme - GitHub - seebi/tmux-colors-solarized: A color theme for the tmux terminal multiplexer using Ethan Schoonoverâs Solarized color scheme
        <DT><A HREF="https://github.com/serversideup/amplitudejs.git/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - serversideup/amplitudejs: AmplitudeJS: Open Source HTML5 Web Audio Library. Design your web audio player, the way you want. No dependencies required.</A>
        <DD>AmplitudeJS: Open Source HTML5 Web Audio Library. Design your web audio player, the way you want. No dependencies required. - GitHub - serversideup/amplitudejs: AmplitudeJS: Open Source HTML5 Web Audio Library. Design your web audio player, the way you want. No dependencies required.
        <DT><A HREF="https://github.com/teranex/vimwiki-tasks/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - teranex/vimwiki-tasks: A Vim plugin to integrate Vimwiki tasks with taskwarrior. Sync tasks between vimwiki and taskwarrior in both directions</A>
        <DD>A Vim plugin to integrate Vimwiki tasks with taskwarrior. Sync tasks between vimwiki and taskwarrior in both directions - GitHub - teranex/vimwiki-tasks: A Vim plugin to integrate Vimwiki tasks with taskwarrior. Sync tasks between vimwiki and taskwarrior in both directions
        <DT><A HREF="https://github.com/tools-life/taskwiki#viewports/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - tools-life/taskwiki: Proper project management with Taskwarrior in vim.</A>
        <DD>Proper project management with Taskwarrior in vim. - GitHub - tools-life/taskwiki: Proper project management with Taskwarrior in vim.
        <DT><A HREF="https://github.com/vim-awesome/vim-awesome/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">GitHub - vim-awesome/vim-awesome: Awesome Vim plugins from across the universe</A>
        <DD>Awesome Vim plugins from across the universe. Contribute to vim-awesome/vim-awesome development by creating an account on GitHub.
        <DT><A HREF="https://gnupg.org/documentation/howtos.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.pornhub.com/view_video.php?viewkey=ph62521972b9fd2/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Got Playful with a Cream - Pornhub.com</A>
        <DD>Watch Got playful with a cream on Pornhub.com, the best hardcore porn site. Pornhub is home to the widest selection of free Blonde sex videos full of the hottest pornstars. If you're craving masturbate XXX movies you'll find them here.
        <DT><A HREF="https://www.hackthebox.com/blog/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hack The Box Blog | Cybersecurity & Hacking News</A>
        <DD>All the latest news and insights about cybersecurity from Hack The Box. Hacking trends, insights, interviews, stories, and much more.
        <DT><A HREF="https://www.hackthebox.com/hacker/hacking-labs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hacking Labs | Virtual Hacking & Pentesting Labs (Upskill Fast)</A>
        <DD>Access high-power hacking labs to rapidly level up (& prove) your penetration testing skills. Hundreds of virtual hacking labs. Join Hack The Box today!
        <DT><A HREF="https://www.youtube.com/watch?v=z4WN0sHLUWU/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Hacking with Parrot Security OS - YouTube</A>
        <DD>Kali Linux is famous for being the go-to operating system for hackers, but there are other operating systems out there targeting security researchers too. Pa...
        <DT><A HREF="https://humanrights.gov.au/quick-guide/12040/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Harassment</A>
        <DD>Harassment can be against the law when a person is treated less favourably on the basis of certain personal characteristics, such as race, sex, pregnancy, marital status, breastfeeding, age, disability, sexual orientation, gender identity or intersex status. Some limited exemptions and exceptions apply. Harassment can include behaviour such as:
        <DT><A HREF="https://hide.me/en/proxy/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Fastest Free Proxy | hide.me</A>
        <DD>Easily access blocked content and websites with our FREE web proxy. Hide your real IP address and encrypt your internet connection to protect your privacy.
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Hosting_Web/Email_services_on_Alpine/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://vi.stackexchange.com/questions/7656/how-do-i-get-multiple-vimwikis-to-show-under-vimwiki-open-index-in-the-gvim/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How do I get multiple vimwikis to show under "Vimwiki / Open Index" in the gvim menu? - Vi and Vim Stack Exchange</A>
        <DD>I want to work between two vimwiki directories: a private vimwiki and a public vimwiki. How do I get multiple vimwikis in the gvim Vimwiki > Open index > menu? In my ~/.vimrc I have the two
        <DT><A HREF="https://social.msdn.microsoft.com/Forums/en-US/91eae199-97a0-4136-a9d3-5a87a769453e/how-do-you-set-home-page-through-java-script-for-mozilla-firefox?forum=asphtmlcssjavascript/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How do you set home page through java script for mozilla firefox?</A>
        <DT><A HREF="https://opensource.com/life/15/3/creating-split-screen-shots-kdenlive/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to create split screen shots in Kdenlive | Opensource.com</A>
        <DD>To kick off a new series called Multimedia Makers on Opensource.com, Seth Kenlon shows you how to create split screens with Kdenlive. Multimedia Makers is a series of tutorials and tips on creating multimedia with Linux and its vast creative toolkit. Brought to you by slackermedia.info and gnuworldorder.info
        <DT><A HREF="https://medium.com/devnetwork/how-to-create-your-own-custom-terminal-commands-c5008782a78e/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to create your own Custom Terminal Commands | by Nirdosh Gautam | Devnetwork | Medium</A>
        <DD>In this article, we will see how we can create custom shell commands for automating our tasks which will help focus on other productive things by saving our time. Itâs easy to setup and also a lot ofâ¦
        <DT><A HREF="https://stackoverflow.com/questions/39337075/how-to-delete-text-between-all-braces-in-vim/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to delete text between all braces {} in vim - Stack Overflow</A>
        <DD>I want to delete all text between each braces {} in file (including the braces themselves). I know command %d which deleted text between braces under cursor but I want to make it automatically for ...
        <DT><A HREF="https://www.youtube.com/watch?v=NwS28dX7eOI/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to install mpd and ncmpcpp in linux and how to add songs - YouTube</A>
        <DD>ncmpcpp config: http://pastebin.com/yZM8zGwvmpd config: http://pastebin.com/P7rwMFLq
        <DT><A HREF="https://www.youtube.com/watch?v=xGS_Ryx_7r8/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Install PS3HEN on Any PS3 on Firmware 4.90 or Lower! - YouTube</A>
        <DD>PS3Xploit brings homebrew to all models of the PS3 in the form of HEN, short for Homebrew Enabler! PS3HEN works on ANY retail model of PS3 as long as your co...
        <DT><A HREF="https://9to5linux.com/how-to-search-for-text-within-files-and-folders-in-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to Search for Text within Files and Folders in Linux - 9to5Linux</A>
        <DD>A quick and dirty tutorial to show you how to search for specific text within hundreds or thousands of files and folders in Linux systems.
        <DT><A HREF="https://medium.com/@jimmashuke/how-to-stop-that-annoying-sudo-password-prompt-in-linux-b2b72b9c2f55/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">How to stop that annoying âSUDOâ password prompt in Linux | by Mashuke Alam Jim | Medium</A>
        <DD>We all know that Linux is very security-conxious. And that means itâll try asking password every time (almost) you run any command as admin (using âsudoâ). Fortunately, there is a way to stop thisâ¦
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Learn/HTML/Tables/Advanced/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">HTML table advanced features and accessibility - Learn web development | MDN</A>
        <DD>There are a few other things you could learn about tables in HTML, but this is all you need to know for now. Next, you can test yourself with our HTML tables assessment. Have fun!
        <DT><A HREF="http://127.0.0.1:7657/home/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://docs.docker.com/engine/install/debian/#set-up-the-repository/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Install Docker Engine on Debian | Docker Docs</A>
        <DD>Learn how to install Docker Engine on Debian. These instructions cover the different installation methods, how to uninstall, and next steps.
        <DT><A HREF="https://www.youtube.com/watch?v=C_dQTU9smPc/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Install Koel audio streaming server menggunakan docker compose di ubuntu 20.04 - YouTube</A>
        <DD>Nama : Fauzi RamdaniNIM : 312019025
        <DT><A HREF="https://www.youtube.com/watch?v=CINn8TVuD6s/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Install Mmcm Versi Stable For Ps3 Cfw/Hen 4.89 Update Terbaru - YouTube</A>
        <DD>Hallo semua jumpa lagi bersama saya, kali ini saya akan membagikan video Install Mmcm Untuk Cfw Dan Hen 4.89Link : https://cararegistrasi.com/7HWEkta1V8pTer...
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Install_to_disk/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://searx.github.io/searx/admin/installation.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://ifconfig.co/ip/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://ipmagnet.services.cbcdn.com/?hash=0af64f2b6de2500a788122d48b624d18d2133010/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.perturb.org/content/iptables-rules.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://docs.oracle.com/javase/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">JDK 21 Documentation - Home</A>
        <DD>The documentation for JDK 21 includes developer guides, API documentation, and release notes.
        <DT><A HREF="http://joereynoldsaudio.com/2018/07/07/you-dont-need-vimwiki.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">joereynoldsaudio.com</A>
        <DT><A HREF="https://0x64marsh.com/?p=314/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Kernel Driver Exploit: System Mechanic | Marsh</A>
        <DT><A HREF="https://www.digi77.com/software/kodachi/Kodachi-Log.txt/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://nim-lang.org/learn.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://nodejs.dev/learn/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://github.com/vimwiki/vimwiki/issues/133/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Link to another wiki? Â· Issue #133 Â· vimwiki/vimwiki Â· GitHub</A>
        <DD>How can I link a wiki to another wiki outside current directory? For example: my default directory is on /home/user/wiki/index.wiki and I would like to link a wiki in /mnt/usb/anotherwiki/index.wiki. When I put the link [[wiki#:///mnt/us...
        <DT><A HREF="https://superuser.com/questions/1224532/get-links-from-an-html-page/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux - Get links from an html page - Super User</A>
        <DD>I have a txt file with several html file links. I need to access each link in this txt and grab the links that are inside it and save it to another txt file. How can I do this for Linux terminal/ ...
        <DT><A HREF="https://unix.stackexchange.com/questions/452101/how-to-keep-only-latest-file-in-the-folder-and-move-older-files-to-archive-locat/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">linux - How to Keep only latest file in the folder and move older files to Archive location - Unix & Linux Stack Exchange</A>
        <DD>In my folder I have multiple files similar to these: ContractAdjustments.CHRS201804202144.txt
ContractAdjustments.CHRS201804212144.txt
ContractAdjustments.CHRS201804222144.txt
ContractAdjustments.
        <DT><A HREF="https://linuxcommand.org/lc3_adv_dialog.php/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux Command Line Adventure: Dialog</A>
        <DD>Dialog User Interface Tool Tutorial
        <DT><A HREF="https://www.foxinfotech.in/2019/04/linux-dialog-examples.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-systemd-unit-file/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Linux post-installation steps for Docker Engine | Docker Docs</A>
        <DD>Find the recommended Docker Engine post-installation steps for Linux users, including how to run Docker as a non-root user and more.
## [run docker without sudo,docker running as root,docker post install,docker post installation,run docker as non root,docker non root user,how to run docker in linux,how to run docker linux,how to start docker in linux,run docker on linux]
        <DT><A HREF="http://www.opentopia.com/hiddencam.php/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Live Webcams - Free, public web cams found online</A>
        <DD>Browse Opentopia's vast webcam database, containing thousands of live webcam views from around the world
        <DT><A HREF="https://in-the-sky.org/satmap_worldmap.php/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Live World Map of Satellite Positions - In-The-Sky.org</A>
        <DD>A world map of the positions of satellites above the Earth's surface, and a planetarium view showing where they appear in the night sky.
        <DT><A HREF="http://mailinator.com/index.jsp/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://metagerv65pwclop2rsfzg4jwowpavpwd6grhhlvdgsswvo6ii4akgyd.onion/en-US/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.youtube.com/watch?v=ELjsbyhkkKw/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">mind nvim | Part 2/5: Content fuzzy searching and more - YouTube</A>
        <DD>Part 2/5: explores the content feature of mind.nvim, data and link nodes, as well as fuzzy searching and more.00:00 Introduction00:47 Data nodes03:46 Link no...
        <DT><A HREF="https://mint.bitcoin.com/#/configure/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">404 Page Not Found | Bitcoin.com</A>
        <DD>404 Page Not Found, please navigate back to the homepage to continue using our site.
        <DT><A HREF="https://pastebin.com/P7rwMFLq/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.thelinuxrain.org/articles/multiple-item-data-entry-with-yad/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Multiple-item data entry with YAD | The Linux Rain</A>
        <DD>YAD (Yet Another Dialog) creates GUI dialogs for data entry, user notification, etc. It was written by Victor Ananjevsky and is described as a fork of Zenity. In fact, it greatly extends Zenity and has a very large number of handy options. Here I explain how to build a multiple-item data entry form with YAD (version 0.20.3 from the Debian stable repository).
        <DT><A HREF="https://www.youtube.com/watch?v=hLV96u2Cnck/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">My Neovim Config - YouTube</A>
        <DD>My init.vim: https://github.com/mathletedev/dotfiles/blob/main/.config/nvim/init.lua----Website: https://mathletedev.github.io/GitHub: https://github.com/mat...
        <DT><A HREF="https://pastebin.com/yZM8zGwv/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://m.home/index.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">NETGEAR</A>
        <DT><A HREF="https://raspberrypi.stackexchange.com/questions/110799/wifi-not-working-after-installing-openmediavault-omv-5-in-rpi-4/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">networking - WiFi not working after installing openmediavault (OMV) 5 in RPi 4 - Raspberry Pi Stack Exchange</A>
        <DD>I installed OMV 5 in my Raspberry Pi 4B running Raspbian GNU/Linux 10 (buster), following this video https://www.youtube.com/watch?v=sYDyvr9Uc6Y (script installation). Just right after install OMV...
        <DT><A HREF="https://phoenixnap.com/kb/nmap-command-linux-examples/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Nmap Commands - 17 Basic Commands for Linux Network</A>
        <DD>A detailed guide on Nmap command in Linux with examples. Nmap is an open-source tool used for security scans & network audits.
        <DT><A HREF="http://no.i2p/search/?q=tor/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://csandker.io/2021/01/10/Offensive-Windows-IPC-1-NamedPipes.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://csandker.io/2021/02/21/Offensive-Windows-IPC-2-RPC.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://csandker.io/2022/05/24/Offensive-Windows-IPC-3-ALPC.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://messari.io/onchainfx/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.zend2.com/#/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://wiki.alioth.net/index.php/Oolite_Main_Page/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.opentraintimes.com/maps/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">OpenTrainTimes: Real-time Track Diagrams</A>
        <DD>See trains moving in real-time on one of our 136 live track diagrams
        <DT><A HREF="https://php.net/manual/en/index.php/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://wiki.alpinelinux.org/wiki/Post_installation/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://vim.fandom.com/wiki/Power_of_g/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://kb.mozillazine.org/Prefs.js_file/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://wiki.gnome.org/action/show/Projects/Zenity?action=show/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Projects/Zenity - GNOME Wiki!</A>
        <DT><A HREF="https://www.brewology.com/?cat=4/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">PS3 Â» Brewology - PS3 PSP WII XBOX - Homebrew News, Saved Games, Downloads, and More!</A>
        <DT><A HREF="https://www.youtube.com/watch?v=s7gMikAHEm4/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">PS3 HEN - New Alternative Easy Installation Method (4.84 HFW ONLY) - YouTube</A>
        <DD>4.84 HFW ONLY!! This shows a quick run through of this NEW alternate method of installing HEN, this can be used to update too. Just set your homepage to http...
        <DT><A HREF="https://www.brewology.com/psn/downloader.php?ref=news/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">PS3 PKG / PSN Downloader - Brewology - PS3 PSP WII XBOX - Homebrew News, Saved Games, Downloads, and More!</A>
        <DT><A HREF="https://duckduckgo.com/?q=python+enabled+neovim&t=fpas&iax=images&ia=images/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">python enabled neovim at DuckDuckGo</A>
        <DD>DuckDuckGo. Privacy, Simplified.
        <DT><A HREF="https://stackoverflow.com/posts/41463292/revisions/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Revisions to Convert audio files to mp3 using ffmpeg [closed] - Stack Overflow</A>
        <DD>Stack Overflow | The Worldâs Largest Online Community for Developers
        <DT><A HREF="https://www.baeldung.com/linux/run-command-start-up/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Running a Linux Command on Start-Up | Baeldung on Linux</A>
        <DD>Learn various ways to run a command or a script when a Linux system starts up
        <DT><A HREF="https://geoxc-apps2.bd.esri.com/Visualization/sat2/index.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://vi.stackexchange.com/questions/8839/how-i-configure-vim-for-use-with-netrw/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">save - How I configure Vim for use with netrw? - Vi and Vim Stack Exchange</A>
        <DD>I recently started to use netrw as a file manager next to my editing session. But I had a coupe of issues with it. First of all netrw reads unhidden buffers from the disk every time. Which made me
        <DT><A HREF="http://yadgui.com/index.php/options-5/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Scripts</A>
        <DD>Yet Another Dialog Information n
        <DT><A HREF="https://github.com/search?q=task+vimwiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://stackoverflow.com/questions/39077407/search-bar-like-google-in-html-and-css/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Search bar like google in HTML and CSS - Stack Overflow</A>
        <DD>Iam learning HTML, CSS and i have problem with making search bar like google. Can you give me any advice, what am I doing wrong, especialy with size? Thanks :)
        <DT><A HREF="https://vi.stackexchange.com/questions/19357/search-through-entire-vimwiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Search through entire vimwiki - Vi and Vim Stack Exchange</A>
        <DD>Is there a (built-in) way to search all vimwiki files for a certain pattern? I don't mean searching tags, but something akin to using grep on all the wiki files in the vimwiki directory. If there ...
        <DT><A HREF="https://github.com/searx/searx/blob/master/searx/settings.yml/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://github.com/searx/searx/blob/master/utils/templates/etc/searx/use_default_settings.yml/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://stackoverflow.com/questions/2512362/how-can-i-can-insert-the-contents-of-a-file-into-another-file-right-before-a-spe/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">sed - How can I can insert the contents of a file into another file right before a specific line - Stack Overflow</A>
        <DD>How can I can insert the contents of a file into another file right before a specific line using sed? example I have file1.xml that has the following:
        <DT><A HREF="https://unix.stackexchange.com/questions/99350/how-to-insert-text-before-the-first-line-of-a-file/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">sed - How to insert text before the first line of a file? - Unix & Linux Stack Exchange</A>
        <DD>I've been looking around sed command to add text into a file in a specific line.
This works adding text after line 1: sed '1 a\ But I want to add it before line 1. It would be: sed '0 a\ but I ...
        <DT><A HREF="https://unix.stackexchange.com/questions/337435/sed-insert-file-at-top-of-another/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SED - Insert file at top of another - Unix & Linux Stack Exchange</A>
        <DD>I have been trying to insert a file as the first line of another with following SED command, without much success. Each time the file is inserted after line 1. Is there a switch that will inserted ...
        <DT><A HREF="https://searx.github.io/searx/admin/settings.html#settings-location/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">settings.yml â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://searx.github.io/searx/admin/settings.html#settings-use-default-settings/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">settings.yml â Searx Documentation (Searx-1.1.0.tex)</A>
        <DT><A HREF="https://www.abs.gov.au/articles/sexual-harassment/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sexual Harassment | Australian Bureau of Statistics</A>
        <DD>Statistics about sexual harassment, including prevalence, characteristics of victims, and intersections with other types of violence and abuse.
        <DT><A HREF="https://stackoverflow.com/questions/22860624/change-firefox-homepage-via-bash-script#22861970/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell - Change Firefox homepage via bash script? - Stack Overflow</A>
        <DD>Hope all is well. Well I am trying to do this for quite sometime but still failing to achieve the result. I have written a bash script, aim is to change the homepage of Firefox over the network. Af...
        <DT><A HREF="https://stackoverflow.com/questions/2314750/how-to-assign-the-output-of-a-bash-command-to-a-variable/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell - How to assign the output of a Bash command to a variable? - Stack Overflow</A>
        <DD>I have a problem putting the content of pwd command into a shell variable that I'll use later. Here is my shell code (the loop doesn't stop): #!/bin/bash
pwd= `pwd`
until [ $pwd = "/" ] do ...
        <DT><A HREF="https://stackoverflow.com/questions/37644634/how-to-use-bash-dialog-yesno-correctly/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">shell - How to use bash dialog --yesno correctly - Stack Overflow</A>
        <DD>I want a simple Yes/No dialog and do make an action dependent on the users choice. My try so far: operation=$(dialog --stdout --title "What to do?" \ --backtitle "Backup-Verwaltung...
        <DT><A HREF="https://www.redtube.com/playlist/3434751/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Sjk Video Playlist | RedTube</A>
        <DD>Sjk porn playlist on RedTube. porn video playlist created by Samson1966.
        <DT><A HREF="https://www.youtube.com/watch?v=sIG2P9k6EjA/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Small, Simple, and Secure: Alpine Linux under the Microscope - YouTube</A>
        <DD>Alpine Linux is a distro that has become popular for Docker images. Why do we need another distro? Why does Alpine matter? How does it differ from other dist...
        <DT><A HREF="https://securitycenter.sonicwall.com/m/page/worldwide-attacks/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SonicWall Security Center</A>
        <DT><A HREF="https://securitycenter.sonicwall.com/m/page/capture-labs-threat-metrics/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SonicWall Security Center</A>
        <DT><A HREF="https://www.redhat.com/sysadmin/sshfs/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">SSHFS: Mounting a remote file system over SSH | Enable Sysadmin</A>
        <DD>Learn how to securely mount a remote file system from another server locally on your machine with SSHFS.
        <DT><A HREF="https://www.ssllabs.com/ssltest/viewMyClient.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Qualys SSL Labs - Projects / SSL Client Test</A>
        <DT><A HREF="http://neovimcraft.com/plugin/startup-nvim/startup.nvim/index.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://searx.github.io/searx/admin/installation-searx.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://github.com/jarun/buku/wiki/System-integration/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">System integration Â· jarun/buku Wiki Â· GitHub</A>
        <DD>:bookmark: Personal mini-web in text. Contribute to jarun/buku development by creating an account on GitHub.
        <DT><A HREF="https://www.vim.org/scripts/script.php?script_id=3465/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Error : vim online</A>
        <DT><A HREF="https://kb.mozillazine.org/Talk:Firefox_links/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://www.psychologytoday.com/us/blog/cutting-edge-leadership/201811/the-5-steps-dehumanization/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The 5 Steps of Dehumanization | Psychology Today</A>
        <DD>The psychology of racism and discrimination.
        <DT><A HREF="https://www.debian.org/doc/manuals/debian-handbook/index.en.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="http://www.pentest-standard.org/index.php/Main_Page/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://proprivacy.com/vpn/guides/firefox-privacy-security-guide/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">The Ultimate Firefox Privacy & Security Guide</A>
        <DD>Firefox is widely regarded as the most privacy-friendly mainstream browser available This can be improved with a range of add-ons and configuration tweaks.
        <DT><A HREF="https://web.threema.ch/#!/welcome/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Threema Web</A>
        <DD>Chat from your desktop with Threema Web and have full access to all chats, contacts and media files.
        <DT><A HREF="https://www.youtube.com/watch?v=DzNmUNvnB04/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tmux has forever changed the way I write code. - YouTube</A>
        <DD>Before tmux, I spent most of my time working in graphical editors and interfaces, and found working in the terminal difficult to do.After moving to tmux and ...
        <DT><A HREF="https://opensecuritytraining.info/Training.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://stackoverflow.com/questions/66866818/how-to-change-nvim-path-to-config/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">ubuntu - How to change nvim path to .config - Stack Overflow</A>
        <DD>I just started with this from neovim and ubuntu and I don't know why when I install neovim it is not in .config, putting the command which nvim in the terminal tells me that it is in / usr / bin / ...
        <DT><A HREF="https://manpages.ubuntu.com/manpages/kinetic/en/man1/pandoc.1.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://askubuntu.com/questions/500359/efi-boot-partition-and-biosgrub-partition/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">uefi - ''EFI boot partition'' and ''biosgrub'' partition - Ask Ubuntu</A>
        <DD>Why do I need these? I have installed Ubuntu under a non UEFI (master boot record) and have installed Ubuntu with no 'biosgrub' and it works fine, whereas other times I am asked to make a 'biosgrub'
        <DT><A HREF="https://opensource.com/article/20/1/vim-task-list-reddit-twitter/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Use Vim to manage your task list and access Reddit and Twitter | Opensource.com</A>
        <DD>Last year, I brought you 19 days of new (to you) productivity tools for 2019.
        <DT><A HREF="https://medium.com/@felipe.anjos/vim-for-web-development-html-css-in-2020-95576d9b21ad/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">VIM for web-development (HTML/CSS) in 2020 | by Felipe Cavalheiro dos Anjos | Medium</A>
        <DD>Why would you want to use an editor that is almost 30 years old? Because it has come to stay, and isnât it better to learn something that will stick around? Well, also because it is damn powerfulâ¦
        <DT><A HREF="https://www.naperwrimo.org/wiki/index.php?title=Vim_for_Writers/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://vi.stackexchange.com/questions/28505/vimwiki-create-a-smart-index-page-for-subdir-section-of-wiki/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">vimscript - VimWiki - create a "smart" index page for subdir/section of wiki? - Vi and Vim Stack Exchange</A>
        <DD>I'm using VimWiki for a writing project and for certain sections (like "chapters", contained in sub-directories) I want to create indexes that work similarly to the way VimWiki's diary in...
        <DT><A HREF="https://dev.to/psiho/vimwiki-how-to-automate-wikis-per-project-folder-neovim-3k72/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">VimWiki: how to automate wikis per project folder (Neovim) - DEV Community</A>
        <DD>Neovim is grabbing more and more pieces of my workflow from other systems, and last two pieces are... Tagged with linux, vim.
        <DT><A HREF="https://www.youtube.com/c/TechandCryptovibes/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Tech and Crypto Vibes - YouTube</A>
        <DD>Hi. Welcome to my channel. My Name is Warith AL Maawali I aim to give you the pure information on Tech, Security and Crypto currency. Enjoy your stay. Bitcoi...
## crypto "crypto news" "crypto currency" cryptocurrency "crypto trading" "crypto 2018" vibe "crypto vr" "vr crypto" ethereum altcoins "crypto invest" litecoin ...
        <DT><A HREF="https://twitter.com/warith2020?lang=en/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://developer.mozilla.org/en-US/docs/Web/API/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Web APIs | MDN</A>
        <DD>When writing code for the Web, there are a large number of Web APIs available. Below is a list of all the APIs and interfaces (object types) that you may be able to use while developing your Web app or site.
        <DT><A HREF="https://portswigger.net/web-security/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Web Security Academy: Free Online Training from PortSwigger</A>
        <DD>The Web Security Academy is a free online training center for web application security, brought to you by PortSwigger. Create an account to get started.
        <DT><A HREF="https://linuxconfig.org/webdav-server-setup-on-ubuntu-linux/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">WebDAV server setup on Ubuntu Linux - Linux Tutorials - Learn Linux Configuration</A>
        <DD>WebDAV server setup on Ubuntu Linux
        <DT><A HREF="https://www.psychologytoday.com/us/blog/the-web-violence/201806/what-is-dehumanization-anyway/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">What Is Dehumanization, Anyway? | Psychology Today</A>
        <DD>Dehumanization has been in the news a lotâunderstand it and how to fight it.
        <DT><A HREF="https://wpscan.com/wordpresses/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">WordPress Vulnerabilities | WPScan</A>
        <DD>Discover the latest WordPress security vulnerabilities. With WPScan's constantly updated database, protect your site from potential WordPress exploits.
        <DT><A HREF="https://unix.stackexchange.com/questions/378373/add-virtual-output-to-xorg/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">x11 - Add VIRTUAL output to Xorg - Unix & Linux Stack Exchange</A>
        <DD>I want to create a dummy, virtual output on my Xorg server on current Intel iGPU (on Ubuntu 16.04.2 HWE, with Xorg server version 1.18.4). It is the similiar to Linux Mint 18.2, which one of the xr...
        <DT><A HREF="https://bbs.archlinux.org/viewtopic.php?id=202463/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">Yad - Checklist within form? / Programming & Scripting / Arch Linux Forums</A>
        <DT><A HREF="https://github.com/v1cont/yad/issues/78/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">YAD --paned does not terminated after closing window Â· Issue #78 Â· v1cont/yad Â· GitHub</A>
        <DD>The example from the manual: yad --plug=12345 --tabnum=1 --text="first tab with text" &> res1 & yad --plug=12345 --tabnum=2 --text="second tab" --entry &> res2 & yad --paned --key=12345 --tab="Tab 1" --tab="Tab 2" and sometimes YAD is no...
        <DT><A HREF="https://yad-guide.ingk.se/html/yad-html.html/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973"></A>
        <DT><A HREF="https://groups.google.com/g/yad-common/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">yad-common - Google Groups</A>
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/player.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">yad-examples/player.sh at master - NRZCode/yad-examples - Codeberg.org</A>
        <DD>yad-examples
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/sysinfo-notebook.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">yad-examples/sysinfo-notebook.sh at master - NRZCode/yad-examples - Codeberg.org</A>
        <DD>yad-examples
        <DT><A HREF="https://codeberg.org/NRZCode/yad-examples/src/branch/master/tabs.sh/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">yad-examples/tabs.sh at master - NRZCode/yad-examples - Codeberg.org</A>
        <DD>yad-examples
        <DT><A HREF="https://duckduckgo.com/?q=yadbash&ia=web/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973">yadbash at DuckDuckGo</A>
        <DD>DuckDuckGo. Privacy, Simplified.
        <DT><A HREF="https://github.com/zellij-org/zellij/issues/1402" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+zellij">Pipe / Redirect output to other panes Â· Issue #1402 Â· zellij-org/zellij Â· GitHub</A>
        <DD>We should allow these sorts of interfaces tail -f "/path/to/my/log" > zc new-pane (zc will be an alias, short for zellij command) vim my-file.rs | zc new-floating-pane Basically, allow to both pipe and redirect command output to a new or...
        <DT><A HREF="https://blog.teamtreehouse.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+ui">Treehouse Blog | Learn programming, design, and moreâall online and on your own time.</A>
        <DD>Learn programming, design, and moreâall online and on your own time.
        <DT><A HREF="https://www.smashingmagazine.com/2018/02/comprehensive-guide-ui-design/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+ui">A Comprehensive Guide To UI Design â Smashing Magazine</A>
        <DD>(*This article is kindly sponsored by Adobe*.) When designing your user interface, it helps to have a system in place. This guide will help you find a solid UI approach that will stand the test of time.
        <DT><A HREF="https://www.usability.gov/what-and-why/user-interface-design.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+ui">User Interface Design Basics | Usability.gov</A>
        <DD>The goal of User Interface (UI) design is to anticipate what users might need to do and ensures that the interface has elements that are easy to access, understand, and use to facilitate those actions.
        <DT><A HREF="https://developer-old.gnome.org/NetworkManager/stable/nmcli-examples.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+nmcli">nmcli-examples: NetworkManager Reference Manual</A>
        <DT><A HREF="https://developer-old.gnome.org/NetworkManager/stable/nmcli.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+nmcli">nmcli: NetworkManager Reference Manual</A>
        <DT><A HREF="https://dquinton.github.io/debian-install/netinstall/live-build.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+live-build">Live-build</A>
        <DD>Create a custom Live Devuan/Debian CD using Live-Build- by D Quinton
        <DT><A HREF="https://live-team.pages.debian.net/live-manual/html/live-manual/examples.en.html" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+live-build">examples - Debian Live Manual</A>
        <DT><A HREF="https://github.com/ojroques/vim-oscyank" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+git +vim">GitHub - ojroques/vim-oscyank: A Vim plugin to copy text through SSH with OSC52</A>
        <DD>A Vim plugin to copy text through SSH with OSC52. Contribute to ojroques/vim-oscyank development by creating an account on GitHub.
        <DT><A HREF="https://github.com/glacambre/firenvim" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+vim +git">GitHub - glacambre/firenvim: Embed Neovim in Chrome, Firefox & others.</A>
        <DD>Embed Neovim in Chrome, Firefox & others. Contribute to glacambre/firenvim development by creating an account on GitHub.
        <DT><A HREF="https://github.com/v1cont/yad" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+yad">GitHub - v1cont/yad: Yet Another Dialog</A>
        <DD>Yet Another Dialog. Contribute to v1cont/yad development by creating an account on GitHub.
        <DT><A HREF="https://www.documentarytube.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+docs">Watch Free Documentary Videos | DocumentaryTube - Documentarytube.com</A>
        <DD>Watch Full-Length Documentaries Online for Free. New Documentaries Added Daily, Top Documentary Films.
        <DT><A HREF="https://topdocumentaryfilms.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+docs">Top Documentary Films - Watch Free Documentaries Online</A>
        <DD>The world's greatest free documentary library - a place where documentaries are regarded as the supreme form of expression.
        <DT><A HREF="https://documentaryheaven.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+docs">Watch Free Documentaries Online | Documentary Heaven</A>
        <DD>DocumentaryHeaven is a site filled with thousands of free online documentaries just waiting to be seen, so come on in and embrace the knowledge!
        <DT><A HREF="https://i2psearch.com/discover" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+i2p">Discover Dark Web Hidden Service - I2P Search</A>
        <DD>Find hidden services in dark web, we freshly baked i2p sites daily
        <DT><A HREF="https://i2psearch.com/" ADD_DATE="1736813973" LAST_MODIFIED="1736813973" TAGS="+i2p">I2P Search</A>
        <DD>I2P Search - Search Hidden Services on the I2P network and discover eepsites by i2p search.
    </DL><p>
</DL><p>#}}}
EOL

#}}}
fi
if [[ $aa24 -eq 1 ]]; then
#{{{ >>>
echo "Placeholder"
echo "er"
#}}}
fi
if [[ $aa25 -eq 1 ]]; then
#{{{ >>>
echo "Placeholder"
#}}}
fi
if [[ $aa26 -eq 1 ]]; then
#{{{ >>>   LC-INSTALL
echo "Placeholder"
#}}}
fi
if [[ $aa27 -eq 1 ]]; then
	#{{{ >>> Create LC-2-INSTALL
	cat<<EOL> lc-2-install.sh
#!/bin/bash
# vim:fileencoding=utf-8:foldmethod=marker
#{{{ >>> Script Information
#author			:	fairdinkum batan
#mail			:	12982@tutanota.com
#description	:	In contrast to the script lc-install.sh, which runs compleatly
#			    :   automatically, this script is a continuation script and rather then
#			    :   installing packages and software that might not be needed,
#			    :   it will prompt the user at the very beginning anddisplay all the available # 			   :   options, only after user interaction, which happenes at the very beginning
#			    :   and only then, the script will run and execute the parts needed
-----------------------------------------------------------------------------------------------
#}}}
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

#{{{ >>> Script Display and variables
#!/bin/bash

# ANSI Colors
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
Yellow='\033[1;33m'
White='\033[1;37m'
NC='\033[0m'

# Initialize individual answer variables (aa1-aa30)
for i in {1..30}; do
    declare "aa$i=0"
done

# Questions and their answers (0 = No, 1 = Yes)
QUESTIONS=(
	"| 01) |Install |Cairo-Dock                 |"
	"| 02) |Install |Steam Installer for Gaming |"
	"| 03) |Install |Gnome-Boxes                |"
	"| 04) |Install |Ollama and Mistral Model   |"
	"| 05) |Install |Docker and Funkwhale       |"
	"| 06) |Install |Anonsurf (Parrot OS)       |"
	"| 07) |Install |Neovim and Codium          |"
	"| 08) |Install |Cubic                      |"
	"| 09) |Install |Flatpak                    |"
	"| 10) |Install |superfile (file-manager)   |"
	"| 11) |Create  |System cleanup script      |"
	"| 12) |Install |Go language                |"
	"| 13) |Build   |                           |"
	"| 14) |Install |Cursor (editor)            |"
	"| 15) |Install |Nix (package manager)      |"
	"| 16) |Install |Gnome-base (desktop)       |"
	"| 17) |Install |Sway (desktop)             |"
	"| 18) |Install |Dwm (suckless desktop)     |"
	"| 19) |Install |Budgie (desktop)           |"
	"| 20) |        |                           |"
	"| 21) |        |                           |"
	"| 22) |        |                           |"
	"| 23) |        |                           |"
	"| 24) |        |                           |"
	"| 25) |Install |LC-Grub,Plymouth,lightdm   |"
	"| 26) |        |                           |"
	"| 27) |Install |Kodi and its deps          |"
	"| 28) |Create  |and exec fin2.sh           |"
	"| 29) |RUN     |LC-INSTALL.SH              |"
)

#}}}

#{{{ >>> Script Continuation
ANSWERS=(0 0 0 0)  # Default all answers to No
NUM_QUESTIONS=${#QUESTIONS[@]}
selected=0  # Current selected row (-1 for Cancel, NUM_QUESTIONS for Accept)

# Function to display the radio menu
DISPLAY_MENU() {
    clear

    # Display Cancel option
    if [[ $selected -eq -1 ]]; then
        echo -e "${White}${Blue}[ Cancel ]${NC}"
    else
        echo -e "  Cancel  "
    fi

    echo "  +-----+--------+---------------------------+"

    # Display questions and their Yes/No options
    for ((i=0; i<NUM_QUESTIONS; i++)); do
        if [[ $selected -eq $i ]]; then
            echo -ne "${White}${Blue}>"
        else
            echo -ne " "
        fi

        echo -ne " ${QUESTIONS[i]}"

        # Move cursor to position 40
        printf "%*s" $((40 - ${#QUESTIONS[i]})) ""

        if [[ ${ANSWERS[i]} -eq 1 ]]; then
            echo -e "[${Green}Yes${NC}] / No "
        else
            echo -e "Yes / [${Red}No${NC}] "
        fi
    done

    echo "  +-----+--------+---------------------------+"

    # Display Accept option
    if [[ $selected -eq $NUM_QUESTIONS ]]; then
        echo -e "${White}${Blue}[ Accept and Continue ]${NC}"
    else
        echo -e "  Accept and Continue  "
    fi
}

# Main loop
while true; do
    DISPLAY_MENU

    read -sn1 key

    if [[ $key == $'\e' ]]; then
        read -sn1 key
        if [[ $key == '[' ]]; then
            read -sn1 key
            case $key in
                'A') # Up arrow
                    ((selected--))
                    if [[ $selected -lt -1 ]]; then
                        selected=$NUM_QUESTIONS
                    fi
                    ;;
                'B') # Down arrow
                    ((selected++))
                    if [[ $selected -gt $NUM_QUESTIONS ]]; then
                        selected=-1
                    fi
                    ;;
                'C') # Right arrow
                    if [[ $selected -ge 0 && $selected -lt NUM_QUESTIONS ]]; then
                        ANSWERS[selected]=1
                    fi
                    ;;
                'D') # Left arrow
                    if [[ $selected -ge 0 && $selected -lt NUM_QUESTIONS ]]; then
                        ANSWERS[selected]=0
                    fi
                    ;;
            esac
        fi
    elif [[ $key == '' ]]; then  # Enter key
        if [[ $selected -eq -1 ]]; then
            echo "Operation cancelled."
            exit 1
        elif [[ $selected -eq $NUM_QUESTIONS ]]; then
            clear
            echo "Selected answers:"
            for ((i=0; i<NUM_QUESTIONS; i++)); do
                echo "${QUESTIONS[i]}: ${ANSWERS[i]}"
                # Update individual variables
                declare "aa$((i+1))=${ANSWERS[i]}"
            done
            break
        fi
    fi
done
#}}}
#{{{###  functions
###   To think about:
#     function that can be run to install app specific dependencies, where by they are usually
#     stored in a variable and is named in each case different...
#}}}
#{{{###  DEPS

DEPS_STEAM="libatomic1 libbsd0 libcrypt1 libdrm-amdgpu1 libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libdrm2 libedit2 libelf1 libexpat1 libffi8 libgl1-mesa-dri libgl1 libglapi-mesa libglvnd0 libglx-mesa0 libglx0 libgpg-error0 libicu72 libllvm15 liblzma5 libmd0 libpciaccess0 libsensors5 libstdc++6 libtinfo6 libudev1 libva-x11-2 libva2 libx11-6 libx11-xcb1 libxau6 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-randr0 libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb1 libxdmcp6 libxext6 libxfixes3 libxi6 libxinerama1 libxml2 libxshmfence1 libxxf86vm1 libz3-4 libzstd1 steam-installer steam-libs-i386 steam-libs steam-libs zlib1g"
#}}}
#{{{###  User Prompts

#}}}

read -n1 -p "Enter [ANY] to continue..." xxx


if [[ $aa1 -eq 1 ]]; then
#{{{###  Cairo Dock
DEPS_CAIRO="cairo-dock-alsamixer-plug-in cairo-dock-animated-icons-plug-in cairo-dock-cairo-penguin-plug-in cairo-dock-clipper-plug-in cairo-dock-clock-plug-in cairo-dock-core cairo-dock-dbus-plug-in cairo-dock-desklet-rendering-plug-in cairo-dock-dialog-rendering-plug-in cairo-dock-dnd2share-plug-in cairo-dock-drop-indicator-plug-in cairo-dock-dustbin-plug-in cairo-dock-folders-plug-in cairo-dock-gmenu-plug-in cairo-dock-icon-effect-plug-in cairo-dock-illusion-plug-in cairo-dock-kde-integration-plug-in cairo-dock-keyboard-indicator-plug-in cairo-dock-logout-plug-in cairo-dock-mail-plug-in cairo-dock-messaging-menu-plug-in cairo-dock-motion-blur-plug-in cairo-dock-musicplayer-plug-in cairo-dock-netspeed-plug-in cairo-dock-quick-browser-plug-in cairo-dock-recent-events-plug-in cairo-dock-remote-control-plug-in cairo-dock-rendering-plug-in cairo-dock-rssreader-plug-in cairo-dock-showdesktop-plug-in cairo-dock-showmouse-plug-in cairo-dock-slider-plug-in cairo-dock-stack-plug-in cairo-dock-switcher-plug-in cairo-dock-system-monitor-plug-in cairo-dock-systray-plug-in cairo-dock-terminal-plug-in cairo-dock-toons-plug-in cairo-dock-weather-plug-in cairo-dock-wifi-plug-in cairo-dock-xgamma-plug-in "
for i in ${DEPS_CAIRO[@]}; do
	dpkg -s $i > /dev/null 2>&1
	if [ $? -eq 1 ]; then
		echo -e "\033[33m Installing \033[34m$i \033[0m"
		sudo apt install $i -y > /dev/null 2>&1
	fi
done

#}}}
fi
if [[ $aa2 -eq 1 ]]; then
#{{{###  Install Steam for Gaming
sudo apt-get update
for package in ${DEPS_STEAM[@]}; do
	dpkg -s $package >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo -e "\033[33mInstalling \033[4m$package \033[33m...\033[0m"
		sudo apt-get install -y $package>>/dev/null 2>&1
	fi
done

#}}}
fi
if [[ $aa3 -eq 1 ]]; then
#{{{ ### install gnom-boxes
DEPS_BOXES="dmeventd gnome-boxes gnutls-bin ibverbs-providers ipxe-qemu libaio1 libboost-thread1.74.0 libbrlapi0.8 libcacard0 libcapstone4 libcue2 libdevmapper-event1.02.1 libexecs0 libexempi8 libexiv2-27 libfdt1 libfmt9 libgexiv2-2 libgfapi0 libgfrpc0 libgfxdr0 libglusterfs0 libgnutls-dane0 libgsf-1-114 libgsf-1-common libgxps2 libibverbs1 libiptcdata0 libiscsi7 liblvm2cmd2.03 libosinfo-1.0-0 libosinfo-bin libosinfo-l10n libphodav-3.0-0 libphodav-3.0-common librados2 librbd1 librdmacm1 libslirp0 libspice-client-glib-2.0-8 libspice-client-gtk-3.0-5 libspice-server1 libssh-4 libtotem-plparser-common libtotem-plparser18 libtpms0 libtracker-sparql-3.0-0 libunbound8 libusbredirhost1 libusbredirparser1 libvdeplug2 libvirglrenderer1 libvirt-daemon-driver-lxc libvirt-daemon-driver-qemu libvirt-daemon-driver-vbox libvirt-daemon-driver-xen libvirt-daemon libvirt-glib-1.0-0 libvirt-glib-1.0-data libvirt-l10n libvirt0 libxencall1 libxendevicemodel1 libxenevtchn1 libxenforeignmemory1 libxengnttab1 libxenhypfs1 libxenmisc4.17 libxenstore4 libxentoolcore1 libxentoollog1 lvm2 netcat-openbsd osinfo-db ovmf qemu-block-extra qemu-system-common qemu-system-data qemu-system-gui qemu-system-x86 qemu-utils seabios spice-client-glib-usb-acl-helper swtpm-libs swtpm-tools swtpm thin-provisioning-tools tracker-extract tracker-miner-fs tracker spice-vdagent spice-webdavd"

clear
for i in ${DEPS_BOXES[@]};
do
	dpkg -s $i>/dev/null 2>&1
	if [[ $? == "1" ]];
	then
		sudo apt install $i -y
		fi
done
#}}}
fi
if [[ $aa4 -eq 1 ]]; then
#{{{###  Ollama and Mistral
sudo apt install

for file in python3-venv python3-pip pipx python3-dev; do
	dpkg -s $file &>/dev/null 2>&1
	if [[ $? -eq 1 ]]; then
		echo -e "\033[0;33mInstalling \033[0;32m$file\033[0m"
		sudo apt install -y $file >/dev/null 2>&1
	fi
	done

python3 -m .venv /home/batan/.venv
source /home/batan/.venv/bin/activate

  pipx install langchain sentence_transformers faiss-cpu ctransformers


  cat<< 'EOL'>mini-lm-file-creation.py
  """
This script creates a database of information gathered from local text files.
"""

from langchain.document_loaders import DirectoryLoader, TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import FAISS

# define what documents to load
loader = DirectoryLoader("./", glob="*.txt", loader_cls=TextLoader)

# interpret information in the documents
documents = loader.load()
splitter = RecursiveCharacterTextSplitter(chunk_size=500,
                                          chunk_overlap=50)
texts = splitter.split_documents(documents)
embeddings = HuggingFaceEmbeddings(
    model_name="sentence-transformers/all-MiniLM-L6-v2",
    model_kwargs={'device': 'cpu'})

# create and save the local database
db = FAISS.from_documents(texts, embeddings)
db.save_local("faiss")
EOL

cat<< 'EOL'>LM-reads-vector-FAISS-database.py
"""
This script creates a database of information gathered from local text files.
"""

from langchain.document_loaders import DirectoryLoader, TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import FAISS

# define what documents to load
loader = DirectoryLoader("./", glob="*.txt", loader_cls=TextLoader)

# interpret information in the documents
documents = loader.load()
splitter = RecursiveCharacterTextSplitter(chunk_size=500,
                                          chunk_overlap=50)
texts = splitter.split_documents(documents)
embeddings = HuggingFaceEmbeddings(
    model_name="sentence-transformers/all-MiniLM-L6-v2",
    model_kwargs={'device': 'cpu'})

# create and save the local database
db = FAISS.from_documents(texts, embeddings)
db.save_local("faiss")
EOL

#}}}
fi
if [[ $aa5 -eq 1 ]]; then
# #{{{>>>   Install docker and funkwhale
sudo apt update && sudo apt upgrade -y
DEPS_DOCKER_DEBIAN="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin ca-certificates curl gnupg lsb-release"

for pak in ${DEPS_DOCKER_DEBIAN[@]};
do
	dpkg -s $pak >/dev/null 2>&1
	if [[ $? == '1' ]];
	then
		echo -e "\033[33mInstalling $pak\033[0m"
		sudo apt install $pak -y
	else
		echo -e "\033[33m$pak already installed\033[0m"
	fi
done

# Function to display error and exit
error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# Verifying Debian and Ubuntu
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if [ -f /etc/os-release ]; then
		# Source the os-release file to get distribution info
		. /etc/os-release
		OS=$NAME
		VER=$VERSION_ID
	elif [ -f /etc/lsb-release ]; then
		# For older systems, use lsb_release if available
		. /etc/lsb-release
		OS=$DISTRIB_ID
		VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
		# For Debian-based systems without os-release
		OS="Debian"
		VER=$(cat /etc/debian_version)
	else
		# Unknown Linux system
		OS=$(uname -s)
		VER=$(uname -r)
	fi
fi
echo -e "${B}Detected Linux system:$OS"
DITRIB=$OS



# Installing Docker on Ubuntu

#if [[ $DITRIB == 'Ubuntu']];
#then
#
#for dependency in ${DEPS_DOCKER_UBUNTU[@]};
#do
#	dpkg -s $dependency >/dev/null 2>&1
#	if [[ $? == '1' ]];
#then
#	echo -e "\033[33mInstalling $dependency\033[0m"
#	sudo apt install $dependency -y
#else
#	echo -e "\033[33m$dependency already installed\033[0m"
#	fi
#


#if [[ $DISTRIB == 'Debian']];
#then

# Update the package list and install prerequisites
echo "Updating package list and installing prerequisites..."
sudo apt update || error_exit "Failed to update package list"
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release || error_exit "Failed to install prerequisites"

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings || error_exit "Failed to create keyring directory"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || error_exit "Failed to add Docker's GPG key"

# Set up the Docker repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "Failed to set up Docker repository"

# Update package list and install Docker
echo "Installing Docker..."
sudo apt update || error_exit "Failed to update package list"

#if [[ $DITRIB == 'Debian']];
#then
#
#for dependency in ${DEPS_DOCKER_DEBIAN[@]};
#do
#	dpkg -s $dependency >/dev/null 2>&1
#	if [[ $? == '1' ]];
#then
#	echo -e "\033[33mInstalling $dependency\033[0m"
#	sudo apt install $dependency -y
#else
#	echo -e "\033[33m$dependency already installed\033[0m"
#	fi
#done
#sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "Failed to install Docker"

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version || error_exit "Docker installation failed"

# Prompt for Funkwhale configuration
read -e -p "Enter the Funkwhale hostname (e.g., yourdomain.funkwhale): " -i 'funkwhale' FUNKWHALE_HOSTNAME
read -e -p "Enter the full path for Funkwhale data directory (e.g., /path/to/data): " -i '/media/batan/100/Music/data' DATA_DIR
read -e -p "Enter the full path for Funkwhale music directory (e.g., /path/to/music): " -i '/media/batan/100/Music/' MUSIC_DIR

if [[ ! -d "$DATA_DIR" ]]; then
	mkdir -p "$DATA_DIR"
fi


# Check if directories exist
[ ! -d "$DATA_DIR" ] && error_exit "Data directory does not exist: $DATA_DIR"
[ ! -d "$MUSIC_DIR" ] && error_exit "Music directory does not exist: $MUSIC_DIR"

# Run the Funkwhale Docker container
echo "Running Funkwhale container..."
docker run \
    --name=funkwhale \
    -e FUNKWHALE_HOSTNAME="$FUNKWHALE_HOSTNAME" \
    -e NESTED_PROXY=0 \
    -v "$DATA_DIR:/data" \
    -v "$MUSIC_DIR:/music:ro" \
    -p 3030:80 \
    thetarkus/funkwhale || error_exit "Failed to start Funkwhale container"

echo "Funkwhale is now running. Access it at http://localhost:3030 or http://$FUNKWHALE_HOSTNAME"



#}}}
fi
if [[ $aa6 -eq 1 ]]; then
#{{{ >>> Install Anonsurf (Parrot OS)
git clone https://github.com/ParrotSec/anonsurf.git
cd anonsurf
sudo make
sudo make install
cd
#}}}
fi
if [[ $aa7 -eq 1 ]]; then
#{{{ >>>   Neovim and Codium
NEOVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"

#{{{###   Update system and install prerequisites
echo "Updating system and installing prerequisites..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git python3 python3-pip \
  build-essential libfuse2 nodejs npm \
  taskwarrior ripgrep software-properties-common fzf
#}}}
#{{{###   Install the latest Neovim
echo "Installing the latest Neovim..."
wget "$NEOVIM_URL" -O /tmp/nvim.appimage
chmod u+x /tmp/nvim.appimage
sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
sudo chown -R batan:batan /usr/local/bin/nvim
#}}}
#{{{###   Install Node.js (required for Neovim autocompletion plugins)
echo "Installing Node.js and npm packages for Neovim autocompletion..."
sudo npm install -g neovim
#}}}
#{{{###   Install and configure Python support for Neovim
echo "Configuring Python for Neovim..."
sudo apt-get install python3-pynvim -y
#}}}
#{{{###   Clone Codeium.vim plugin into the correct directory for Neovim
echo "Cloning Codeium.vim plugin..."
git clone https://github.com/Exafunction/codeium.vim /home/batan/.config/nvim/pack/Exafunction/start/codeium.vim
#}}}
#{{{###   Open Neovim config (init.vim) to add Codeium settings
echo "Setting up Codeium configuration in Neovim..."

cat <<EOF >/home/batan/.config/nvim/init.vim

" Enable Codeium plugin
let g:codeium_disable_bindings = 0

" Map <Tab> and <Shift-Tab> to accept/previous suggestions
inoremap <silent><expr> <Tab> codeium#Accept()
inoremap <silent><expr> <S-Tab> codeium#Previous()

" Enable Codeium when entering Insert mode
autocmd InsertEnter * call codeium#Enable()

" Optional: Check Codeium status with a custom function
function! CheckCodeiumStatus()
    let status = luaeval("vim.api.nvim_call_function('codeium#GetStatusString', {})")
    echo "Codeium Status: " . status
endfunction

" Map <Leader>cs to check Codeium status
nnoremap <Leader>cs :call CheckCodeiumStatus()<CR>

" TABLE-MODE
let g:table_mode_corner='|'
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'



" Common settings for Neovim

syntax on
filetype plugin indent on
set laststatus=2
set so=7
set foldcolumn=1
"#set encoding=utf8
set ffs=unix,dos
set cmdheight=1
set hlsearch
set lazyredraw
set magic
set showmatch
set mat=2
set foldcolumn=1
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set nobackup
set nowb
set nocp
set autowrite
set hidden
set mouse=a
set noswapfile
set nu
set relativenumber
set t_Co=256
set cursorcolumn
set cursorline
set ruler
set scrolloff=10

" netrw filemanager settings

let g:netrw_menu = 1
let g:netrw_preview = 1
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_lifestyle = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

" Leader and other mappings

let mapleader = ","
nnoremap <Leader>te :terminal<CR>
nnoremap <Leader>tc :terminal<CR>sudo -u batan bash $HOME/check/vim.cmd.sh <CR>
nnoremap <Leader>xc :w !xclip -selection clipboard<CR>	"copy page to clipboard
nnoremap <leader>dd :Lexplore %:p:h<CR>		"open netrw in 20% of the screen to teh left
nnoremap <Leader>da :Lexplore<CR>
nnoremap <leader>vv :split $MYVIMRC<CR>		"edit vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>	"source vimrc
nnoremap <leader>ra :<C-U>RangerChooser<CR>
nmap <F8> :TagbarToggle<CR>				"tagbar toggle

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"###################		TEMPLATES		################################
autocmd! BufNewFile *.sh 0r /home/batan/.config/nvim/templates/sklt.sh |call setpos('.', [0, 29, 1, 0])
autocmd! BufNewFile *popup.html 0r /home/batan/.config/nvim/templates/popup.html
autocmd! BufNewFile *popup.css 0r /home/batan/.config/nvim/templates/popup.css
autocmd! BufNewFile *popup.js 0r /home/batan/.config/nvim/templates/popup.js
autocmd! BufNewFile *.html 0r /home/batan/.config/nvim/templates/sklt.html
autocmd! BufNewFile *.txt 0r /home/batan/.config/nvim/templates/sklt.txt
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

"##########################   TASK WIKI   ###############################
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
let g:task_report_command  = []
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" allows user to override task configurations. Seperated by space. Defaults to ''
let g:task_rc_override     = 'rc.defaultwidth=999'
" default fields to ask when adding a new task
let g:task_default_prompt  = ['due', 'description']
" whether the info window is splited vertically
let g:task_info_vsplit     = 0
" info window size
let g:task_info_size       = 15
" info window position
let g:task_info_position   = 'belowright'
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '/home/batan/.task'
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <<'
" backward arrow ...
let g:task_left_arrow      = '>> '

"###   STARTUP PAGE   ##############################################################

fun! Start()
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Force clear buffer
    enew
    call setline(1, []) " Clear content explicitly

    " Set buffer options
    setlocal bufhidden=wipe buftype=nofile nobuflisted nocursorcolumn nocursorline nolist nonumber noswapfile norelativenumber

    " Append task output
    let lines = split(system('task'), '\n')
    for line in lines
        call append('$', '            ' . line)
    endfor

    " Make buffer unmodifiable
    setlocal nomodifiable nomodified

    " Key mappings for convenience
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

augroup StartPage
    autocmd!
    autocmd VimEnter * call Start()
augroup END




EOF
#}}}
#{{{###   INSTALL some plugins from my old neovim lc-configs
# cloneing templates for neovim
git clone https://github.com/batann/templates.git /home/batan/.config/nvim/templates
# Install Orig TW
git clone https://github.com/farseer90718/vim-taskwarrior /home/batan/.config/nvim/pack/plugins/start/vim-taskwarrior
# Install table-mode
git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.config/nvim/pack/plugins/start/vim-table-mode
# Install vimwiki
git clone https://github.com/vimwiki/vimwiki.git  /home/batan/.config/nvim/pack/plugins/start/vimwiki
# Install task.wiki
git clone https://github.com/tools-life/taskwiki.git --branch dev /home/batan/.config/nvim/pack/plugins/start/taskwiki

# remove any .git directories
find /home/batan/.config/nvim/ -maxdepth 10 -type d -name ".git" -exec rm -rf {} \;
#}}}
#{{{###   Install vim-plug (optional, in case you want to add more plugins)
echo "Installing vim-plug (optional for plugin management)..."
curl -fLo /home/batan/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Neovim and Codeium setup complete!"
echo "Use :call CheckCodeiumStatus() or press <Leader>cs to check Codeium status in Neovim."
#}}}
#{{{ >>>   html enabled yad dialog build
# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
REPO_URL="https://github.com/v1cont/yad.git"
INSTALL_DIR="$HOME/yad-build"

# Update system and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y git build-essential intltool \
  libgtk-3-dev libwebkit2gtk-4.0-dev \
  libgdk-pixbuf2.0-dev libnotify-dev \
  libjson-glib-dev libxml2-utils

# Clone the YAD repository
echo "Cloning the YAD repository..."
if [ -d "$INSTALL_DIR" ]; then
  echo "Directory $INSTALL_DIR already exists, removing it."
  rm -rf "$INSTALL_DIR"
fi

git clone "$REPO_URL" "$INSTALL_DIR"

# Navigate to the repository
cd "$INSTALL_DIR"

# Configure and enable HTML browser support
echo "Configuring YAD with HTML browser support..."
autoreconf -ivf && intltoolize
./configure --enable-html

# Compile and install YAD
echo "Compiling and installing YAD..."
make
sudo make install

# Verify installation
echo "Verifying YAD installation..."
if yad --version; then
  echo "YAD installed successfully!"
else
  echo "There was an issue with the YAD installation."
  exit 1
fi

#}}}
#{{{ >>>   Install and Config Windsurf
curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
sudo apt-get update
sudo apt-get upgrade windsurf
#}}}
#}}}
fi
if [[ $aa8 -eq 1 ]]; then
#{{{ ### Install Cubic on Debian and Derivatives
sudo apt update
sudo apt install --no-install-recommends dpkg
echo "deb https://ppa.launchpadcontent.net/cubic-wizard/release/ubuntu/ noble main" | sudo tee /etc/apt/sources.list.d/cubic-wizard-release.list
curl -S "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x081525e2b4f1283b" | sudo gpg --batch --yes --dearmor --output /etc/apt/trusted.gpg.d/cubic-wizard-ubuntu-release.gpg

sudo apt update
sudo apt install --no-install-recommends cubic
#}}}
fi
if [[ $aa9 -eq 1 ]]; then
#{{{ ### Install Flatpak
dpkg -s flatpak >/dev/null 2>&1
if [[ $? == 1 ]];
then
	echo -e "\033[34mInstalling \033[31mflatpak\033[34m ...\033[0m"
sudo apt install flatpak -y >/dev/null 2>&1
fi
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo apt install -y gnome-software-plugin-flatpak
#}}}
fi
if [[ $aa10 -eq 1 ]]; then
#{{{ >>>   Install Super File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

#}}}
fi
if [[ $aa11 -eq 1 ]]; then
#{{{ >>> Create a System Clean up Script
/home/batan/lc-cclean<< EOF > cat
#!/bin/bash
#Ultimate lceaner for Linux by batan
# vim:fileencoding=utf-8:foldmethod=marker
tput civis

#{{{###   VARIABLES
dependencies="bleachbit sweeper rename"

extentions="*.part .*.bak.* *.org *.bakup *.backup.* *.tmp.* *.tmp *.ytp.* *.st *.tmp.*.swp *.ytdl .*.part .*.bak..* .*.org .*.bakup .*.backup.* .*.tmp.* .*.tmp .*.ytp.* .*.st .*.tmp .*.swp .*.ytdl"
cleaners=" apt.autoclean apt.autoremove apt.clean apt.package_lists bash.history chromium.cache chromium.cookies chromium.dom chromium.form_history chromium.history chromium.passwords chromium.search_engines chromium.session chromium.site_preferences chromium.sync chromium.vacuum deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp deepscan.vim_swap_root deepscan.vim_swap_user filezilla.mru firefox.backup firefox.cache firefox.cookies firefox.crash_reports firefox.dom firefox.forms firefox.passwords firefox.session_restore firefox.site_preferences firefox.url_history firefox.vacuum flash.cache flash.cookies nautilus.history rhythmbox.cache rhythmbox.history sqlitet.history system.cache system.clipboard system.custom system.desktop_entry system.localizations system.memory system.recent_documents system.rotated_logs system.tmp system.trash transmission.blocklists transmission.history transmission.torrents vim.history vlc.memory_dump vlc.mru wine.tmp winetricks.temporary_files x11.debug_logs"
if [[ ! -d /home/baran/SH ]];
then
	mkdir /home/batan/SH
fi




#}}}
#{{{###   FUNCTIONS
video_move() {
	rename 's/ /_/g' /home/batan/*.mp4
	rename 's/\[.*\]//g' /home/batan/*.mp4
	rename 's/\(.*\)//g' /home/batan/*.mp4
	mv /home/batan/*.mp4 /home/batan/Videos
}
music_move() {
	rename 's/ /_/g' /home/batan/*.mp3
	rename 's/\[.*\]//g' /home/batan/*.mp3
	rename 's/\(.*\)//g' /home/batan/*.mp3
	mv /home/batan/*.mp3 /home/batan/Music
}

image_move(){
	if [[ -f  /home/batan/*.png  ]];
	then
mv *.jpg *.png *.jpeg /home/batan/Pictures>/dev/null 2>&1
	fi
}

script_move (){
if [[ -f /home/batan/*.sh ]];
then
	mkdir /home/batan/SH >/dev/null 2>&1
	mv *.sh /home/batan/SH >/dev/null 2>&1
fi
}

shred_thumb() {
tput cup 29 0
tput el
tput cup 29 0
echo -e "R) Removes S) Shreds the thumbnails"
tput cup 29 35
read -n1 ggg
if [[ $ggg == "s" ]];
then fff="shred"
fi
tput cup 29 0
tput el

for i in $(find .cache -type f -name '*.png');
	do
		aaa=$(find .cache/ -type f -name '*png' |wc -l)
		tput cup 35 0
		tput el
		tput cup 35 0
        echo -e "\033[33mShred thumbnails\033[0m         \033[32m[[ \033[37m$aaa \033[32m]]\033[0m"
		tput cup 35 38
		echo -e "\033[34m[ ]\033[0m"
		if [[ $fff == 'shred' ]];
		then
			shred -f -u -z -n1 $i
		else
			rm -f $i
		fi
	done
}
count_thumb() {
	find /home/$USER/.cache -type f -name '*.png' | wc -l
}
ytdlp_clean(){
	dpkg -s yt-dlp>/dev/null
	if [[ $? == "0" ]];
	then
		yt-dlp --rm-cache-dir
	fi
}
apt_clean(){
sudo apt-get autoclean
sudo apt-get autoremove --purge -y
sudo apt-get clean
}
#}}}
#{{{###   DRAW A TODO LIST
#!/bin/bash
NK="\033[36m[ ]\033[0m"
K="\033[36m[\033[31mx\033[36m]\033[0m"
clear
tput cup 28 0
echo -e "\033[40m\033[32m==========================================\033[0m"
tput cup 30 0
echo -e "\033[40m\033[32m==========================================\033[0m"
tput cup 31 0
echo -e "\033[33mRemove Hanging Files\033[0m"
tput cup 31 38
echo -e "$NK"
echo -e "\033[33mClean and clear apt\033[0m"
tput cup 32 38
echo -e "$NK"
echo -e "\033[33mMove and rename movies\033[0m"
tput cup 33 38
echo -e "$NK"
echo -e "\033[33mMove and rename images\033[0m"
tput cup 34 38
echo -e "$NK"
echo -e "\033[33mMove scripts to SH\033[0m"
tput cup 35 38
echo -e "$NK"
echo -e "\033[33mShred thumbnails\033[0m"
tput cup 36 38
echo -e "$NK"
echo -e "\033[33mRemove yt-dlp cache directory\033[0m"
tput cup 37 38
echo -e "$NK"
echo -e "\033[33mRemove unused flatpaks\033[0m"
tput cup 38 38
echo -e "$NK"
echo -e "\033[33mRemove firefox caches\033[0m"
tput cup 39 38
echo -e "$NK"
echo -e "\033[33mRun Sweeper\033[0m"
tput cup 40 38
echo -e "$NK"
echo -e "\033[33mRun bleachbit with custom cleaners\033[0m"
tput cup 41 38
echo -e "$NK"
echo -e "\033[33mDrop Caches 1\033[0m"
tput cup 42 38
echo -e "$NK"
echo -e "\033[33mDrop Caches 2\033[0m"
tput cup 43 38
echo -e "$NK"
echo -e "\033[33mSwap Off\033[0m"
tput cup 44 38
echo -e "$NK"
echo -e "\033[33mSwap On\033[0m"
tput cup 45 38
echo -e "$NK"
echo -e "\033[33mxxxxxxxx \033[0m"
tput cup 46 38
echo -e "$NK"
echo -e "\033[33mxxxxxxxx \033[0m"
tput cup 47 38
echo -e "$NK"
echo -e "\033[33mxxxxxxxx \033[0m"
tput cup 48 38
echo -e "$NK"
echo -e "\033[33mxxxxxxxx \033[0m"
tput cup 49 0
echo -e "\033[40m\033[32m==========================================\033[0m"

#tput cup 53 0
#for i in $(seq 29 47)
#do
#	sleep 0.5
#	tput cup $(( i += 1 )) 38
#	echo -e $K
#done

#}}}
#{{{###   MAIN SCRIPT


#for i in ${extentions[@]}; do rm $i;done >/dev/null 2>&1

rm $extentions >/dev/null 2>&1
	aa1="x"
tput cup 31 38
echo -e "$K"
apt_clean >/dev/null 2>&1
    aa2="x"
tput cup 32 38
echo -e "$K"
	video_move >/dev/null 2>&1
	aa3="x"
tput cup 33 38
echo -e "$K"
	music_move >/dev/null 2>&1
 	aa4="x"
tput cup 34 38
echo -e "$K"
	image_move>/dev/null 2>&1
	aa5="x"
tput cup 35 38
echo -e "$K"
	script_move>/dev/null 2>&1
	aa6="x"
tput cup 36 38
echo -e "$K"
	shred_thumb
 	aa7="x"
tput cup 37 38
echo -e "$K"
	ytdlp_clean>/dev/null 2>&1
	aa8="x"
tput cup 38 38
echo -e "$K"

flatpak uninstall --unused>/dev/null 2>&1
aa10="x"
tput cup 39 38
echo -e "$K"
#du -hc /var/tmp/flatpak-cache-* | tail -1 >/dev/null 2>&1
aa11="x"
tput cup 40 38
echo -e "$K"
rm -r /home/batan/.cache/mozilla/firefox/*>/dev/null 2>&1
aa12="x"
tput cup 41 38
echo -e "$K"
sudo sweeper --automatic >/dev/null 2>&1
aa13="x"
tput cup 42 38
echo -e "$K"
sudo bleachbit -c $cleaners>/dev/null 2>&1
aa14="x"
tput cup 43 38
echo -e "$K"
echo 1|sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1
aa15="x"
tput cup 44 38
echo -e "$K"
echo 2|sudo tee /proc/sys/vm/drop_caches >/dev/null 2>&1
aa16="x"
tput cup 45 38
echo -e "$K"
sudo swapoff -a>/dev/null 2>&1
aa17="x"
tput cup 46 38
echo -e "$K"
sudo swapon -a>/dev/null 2>&1
aa18="x"
tput cup 47 38
echo -e "$K"
echo "PLACEHOLDER">/dev/null 2>&1
tput cup 48 38
echo -e "$K"

tput cup 51 0
echo -e "\033[40m\033[32m==========================================\033[0m"
tput cup 29 0
echo -e "    DONE! Script run Successsfully "
tput cup 50 0
echo -e "         \033[47m\033[30mPress [ANY] to Exit...\033[0m"
read -n1 xxx
tput cnorm
EOF
sudo chmod a+x /home/batan/lc-cclean
#}}}
#}}}
fi
if [[ $aa12 -eq 1 ]]; then
#{{{ >>> Install GO language
wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
clear
go version
#}}}
fi
if [[ $aa13 -eq 1 ]]; then
#{{{ >>>
echo "placeholder"

#}}}
fi
if [[ $aa14 -eq 1 ]]; then
#{{{ >>> Cursor Installation

echo "placeholder"
#}}}
fi
if [[ $aa15 -eq 1 ]]; then
#{{{ >>> Install Nix Package Manager

	sudo apt install nix-setup-systemd -y
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix-channel --update
	clear
	echo -e "\033[34mTo install packages run:"
	echo -e "\033[37m nix-env -iA nixpkgs.neovim\033[0m"

#}}}
fi
if [[ $aa16 -eq 1 ]]; then
#{{{### >>> Installing desktop-environment Gnome-Base

DEPS_GNOME_BASE="apg desktop-base evolution-data-server-common fonts-quicksand gdm3 geocode-glib-common gir1.2-accountsservice-1.0 gir1.2-adw-1 gir1.2-gdesktopenums-3.0 gir1.2-gdm-1.0 gir1.2-geoclue-2.0 gir1.2-gnomebluetooth-3.0 gir1.2-gnomedesktop-3.0 gir1.2-gweather-4.0 gir1.2-ibus-1.0 gir1.2-javascriptcoregtk-4.1 gir1.2-mutter-11 gir1.2-nm-1.0 gir1.2-nma-1.0 gir1.2-rsvg-2.0 gir1.2-soup-3.0 gir1.2-upowerglib-1.0 (0. gir1.2-webkit2-4.1 gnome-backgrounds gnome-bluetooth-3-common gnome-control-center-data gnome-control-center gnome-desktop3-data gnome-panel-data gnome-panel gnome-session-bin gnome-session-common gnome-session gnome-settings-daemon-common gnome-settings-daemon gnome-shell-common (43. gnome-shell-extensions gnome-shell (43. gstreamer1.0-pipewire libcamel-1.2-64 libcolord-gtk4-1 libcrack2 (2. libcue2 libecal-2.0-2 libedataserver-1.2-27 libexempi8 libgdm1 libgeoclue-2-0 libgeocode-glib-2-0 libgexiv2-2 libgjs0g libgnome-autoar-0-0 libgnome-bg-4-2 libgnome-bluetooth-3.0-13 libgnome-bluetooth-ui-3.0-13 libgnome-desktop-3-20 libgnome-desktop-4-2 libgnome-panel0 libgnome-rr-4-2 libgoa-backend-1.0-1 libgsound0 libgtop-2.0-11 libgtop2-common libgweather-4-0 libgweather-4-common libgxps2 libibus-1.0-5 libiptcdata0 libmozjs-102-0 libmutter-11-0 libosinfo-1.0-0 libosinfo-l10n libportal-gtk4-1 libportal1 libpwquality-common libpwquality1 librest-1.0-0 (0. libsnapd-glib-2-1 libtotem-plparser-common libtotem-plparser18 libtracker-sparql-3.0-0 libxkbregistry0 mutter-common nautilus osinfo-db tracker-extract tracker-miner-fs tracker usb.ids webp-pixbuf-loader xwayland"

for i in ${DEPS_GNOME_BASE[@]};
do
	dpkg -s $i >/dev/null 2>&1
	if [[ $? == 1 ]];
	then
		echo -e "\033[34mInstalling \033[31m$i \033[34m...\033[0m"
		sudo apt install -y $i >/dev/null 2>&1
	fi
done

#}}}
fi
if [[ $aa17 -eq 1 ]]; then
#{{{ >>> Install Sway desktop environment
DEPS_SWAY="libdate-tz3 libjsoncpp25 libmpdclient2 libseat1 libspdlog1.10 libwlroots10 sway-backgrounds sway-notification-center sway swaybg swayidle swayimg swaykbdd swaylock waybar"

for dep in ${DEPS_SWAY[@]}; do
	dpkg -s ${dep} &> /dev/null 2>&1
	if [[ $? == 1 ]]; then
		echo -e "${BBlue}Installing ${dep}${WWhite}"
		sudo apt install ${dep} -y > /dev/null 2>&1
	fi
done
#}}}
fi
if [[ $aa18 -eq 1 ]]; then
#{{{ >>> Install dwm - suckless - desktop environment
#!/usr/bin/env bash
#

echo '***' rm
rm -rf dwm-6.1
rm -f dwm-6.1.tar.gz
rm -f *.diff

echo '***' wget
wget https://dl.suckless.org/dwm/dwm-6.1.tar.gz

DWM_PATCHES=(
https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.1.diff
https://dwm.suckless.org/patches/sticky/dwm-sticky-6.1.diff
https://dwm.suckless.org/patches/noborder/dwm-noborder-6.1.diff
https://dwm.suckless.org/patches/resizecorners/dwm-resizecorners-6.1.diff
https://dwm.suckless.org/patches/movestack/dwm-movestack-6.1.diff
)

for i in "${DWM_PATCHES[@]}"; do
    wget $i
done

echo '***'
tar xvf dwm-6.1.tar.gz

cd dwm-6.1

for i in "${DWM_PATCHES[@]}"; do
    DIFF=`basename $i`
    echo '***' $DIFF
    patch -p1 < ../$DIFF
done

echo '***' config.mk
sed -i "s|^\(PREFIX =\).*|DESTDIR=${HOME}/.local\n\1|" config.mk
sed -i 's|^FREETYPEINC = ${X11INC}/freetype2|#&|' config.mk

echo '***' make
make clean
make install

cd -
cd dwm*
make
sudo make clean install
cd ~

#}}}
fi

if [[ $aa19 -eq 1 ]]; then
#{{{ >>>   Install Budgie Desktop

DEPS_BUDGIE="budgie-app-launcher-applet budgie-dropby-applet budgie-recentlyused-applet budgie-applications-menu-applet budgie-extras-common budgie-rotation-lock-applet budgie-appmenu-applet budgie-extras-daemon budgie-showtime-applet budgie-brightness-controller-applet budgie-fuzzyclock-applet budgie-sntray-plugin budgie-clockworks-applet budgie-hotcorners-applet budgie-takeabreak-applet budgie-control-center budgie-indicator-applet budgie-trash-applet budgie-control-center-data budgie-kangaroo-applet budgie-visualspace-applet budgie-core budgie-keyboard-autoswitch-applet budgie-wallstreet budgie-network-manager-applet budgie-weathershow-applet budgie-countdown-applet budgie-previews budgie-window-shuffler budgie-desktop budgie-previews-applet budgie-workspace-stopwatch-applet budgie-desktop-doc budgie-quickchar budgie-workspace-wallpaper-applet budgie-desktop-view budgie-quicknote-applet"

for pack in ${DEPS_BUDGIE[@]};
do
dpkg -s $pack>/dev/null 2>&1
if [[ $? == 1 ]];
then
	echo -e "\033[34mInstalling \033[32m$pack \033[34m...\033[0m"
	sudo apt install $pack -y >/dev/null 2>&1
fi
done

#}}}
fi

if [[ $aa19 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi

if [[ $aa20 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi

if [[ $aa21 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi

if [[ $aa22 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi

if [[ $aa23 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi

if [[ $aa24 -eq 1 ]]; then
	#{{{ >>> Install Ollama


#remove any old libraries
sudo rm -rf /usr/lib/ollama

#Download and extract the package:
curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
sudo tar -C /usr -xzf ollama-linux-amd64.tgz

#run ollama
ollama serve

#Create the ollama user:
sudo useradd -r -s /bin/false -U -m -d /usr/share/ollama ollama
sudo usermod -a -G ollama $(whoami)

#Create the systemd service file:
cat <<EOF | sudo tee /etc/systemd/system/ollama.service
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="PATH=$PATH"

[Install]
WantedBy=default.target
EOF


	#}}}
fi

if [[ $aa25 -eq 1 ]]; then
	#{{{ >>>   Install Custom Grub, Plymouth, Lightdm
	#{{{ >>>   Install Custom Grub
	clear

if [[ ! -d /home/batan/themes ]]; then
	mkdir /home/batan/themes
fi
git clone https://github.com/batann/Vimix /home/batan/themes/

install.grub.sh<<EOF>cat
#!/bin/bash

#THEME_DIR='/usr/share/grub/themes'
THEME_DIR='/boot/grub/themes'
THEME_NAME=''

function echo_title() {     echo -ne "\033[1;44;37m${*}\033[0m\n"; }
function echo_caption() {   echo -ne "\033[0;1;44m${*}\033[0m\n"; }
function echo_bold() {      echo -ne "\033[0;1;34m${*}\033[0m\n"; }
function echo_danger() {    echo -ne "\033[0;31m${*}\033[0m\n"; }
function echo_success() {   echo -ne "\033[0;32m${*}\033[0m\n"; }
function echo_warning() {   echo -ne "\033[0;33m${*}\033[0m\n"; }
function echo_secondary() { echo -ne "\033[0;34m${*}\033[0m\n"; }
function echo_info() {      echo -ne "\033[0;35m${*}\033[0m\n"; }
function echo_primary() {   echo -ne "\033[0;36m${*}\033[0m\n"; }
function echo_error() {     echo -ne "\033[0;1;31merror:\033[0;31m\t${*}\033[0m\n"; }
function echo_label() {     echo -ne "\033[0;1;32m${*}:\033[0m\t"; }
function echo_prompt() {    echo -ne "\033[0;36m${*}\033[0m "; }

function splash() {
    local hr
    hr=" **$(printf "%${#1}s" | tr ' ' '*')** "
    echo_title "${hr}"
    echo_title " * $1 * "
    echo_title "${hr}"
    echo
}

function check_root() {
    # Checking for root access and proceed if it is present
    ROOT_UID=0
    if [[ ! "${UID}" -eq "${ROOT_UID}" ]]; then
        # Error message
        echo_error 'Run me as root.'
        echo_info 'try sudo ./install.sh'
        exit 1
    fi
}

function select_theme() {
    themes=( 'Vimix' )

    echo '\nChoose The Theme You Want: '
                splash 'Installing Vimix Theme...'
}

function backup() {
    # Backup grub config
    echo_info 'cp -an /etc/default/grub /etc/default/grub.bak'
    cp -an /etc/default/grub /etc/default/grub.bak
}

function install_theme() {
    # create themes directory if not exists
    if [[ ! -d "${THEME_DIR}/${THEME_NAME}" ]]; then
        # Copy theme
        echo_primary "Installing ${THEME_NAME} theme..."

        echo_info "mkdir -p \"${THEME_DIR}/${THEME_NAME}\""
        mkdir -p "${THEME_DIR}/${THEME_NAME}"

        echo_info "cp -a ./themes/\"${THEME_NAME}\"/* \"${THEME_DIR}/${THEME_NAME}\""
        cp -a ./themes/"${THEME_NAME}"/* "${THEME_DIR}/${THEME_NAME}"
    fi
}

function config_grub() {
    echo_primary 'Enabling grub menu'
    # remove default grub style if any
    echo_info "sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub"
    sed -i '/GRUB_TIMEOUT_STYLE=/d' /etc/default/grub

    echo_info "echo 'GRUB_TIMEOUT_STYLE=\"menu\"' >> /etc/default/grub"
    echo 'GRUB_TIMEOUT_STYLE="menu"' >> /etc/default/grub

    #--------------------------------------------------

    echo_primary 'Setting grub timeout to 60 seconds'
    # remove default timeout if any
    echo_info "sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub"
    sed -i '/GRUB_TIMEOUT=/d' /etc/default/grub

    echo_info "echo 'GRUB_TIMEOUT=\"60\"' >> /etc/default/grub"
    echo 'GRUB_TIMEOUT="60"' >> /etc/default/grub

    #--------------------------------------------------

    echo_primary "Setting ${THEME_NAME} as default"
    # remove theme if any
    echo_info "sed -i '/GRUB_THEME=/d' /etc/default/grub"
    sed -i '/GRUB_THEME=/d' /etc/default/grub

    echo_info "echo \"GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"\" >> /etc/default/grub"
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub

    #--------------------------------------------------

    echo_primary 'Setting grub graphics mode to auto'
    # remove default timeout if any
    echo_info "sed -i '/GRUB_GFXMODE=/d' /etc/default/grub"
    sed -i '/GRUB_GFXMODE=/d' /etc/default/grub

    echo_info "echo 'GRUB_GFXMODE=\"auto\"' >> /etc/default/grub"
    echo 'GRUB_GFXMODE="auto"' >> /etc/default/grub
}

function update_grub() {
    # Update grub config
    echo_primary 'Updating grub config...'
    if [[ -x "$(command -v update-grub)" ]]; then
        echo_info 'update-grub'
        update-grub

    elif [[ -x "$(command -v grub-mkconfig)" ]]; then
        echo_info 'grub-mkconfig -o /boot/grub/grub.cfg'
        grub-mkconfig -o /boot/grub/grub.cfg

    elif [[ -x "$(command -v grub2-mkconfig)" ]]; then
        if [[ -x "$(command -v zypper)" ]]; then
            echo_info 'grub2-mkconfig -o /boot/grub2/grub.cfg'
            grub2-mkconfig -o /boot/grub2/grub.cfg

        elif [[ -x "$(command -v dnf)" ]]; then
            echo_info 'grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg'
            grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

function main() {
    splash 'The Matrix awaits you...'

    check_root
    select_theme

    install_theme

    config_grub
    update_grub

    echo_success 'Boot Theme Update Successful!'
}

main
EOF


chmod +x /home/batan/install.grub.sh
sudo /home/batan/./install.grub.sh

#}}}
#{{{ >>>   Install Custom LC-Plymouth
	DEPS="plymouth plymouth-x11 trash-cli git"
	for packs in ${DEPS[@]}; do
	dpkg -s ${packs} &> /dev/null 2>&1
	if [ $? != 1 ]; then
		sudo apt install ${packs} -y
	fi
done
clear
	echo -e "\033[1;32mInstalling Custom LC-Plymouth Theme\033[0m"
git clone https://github.com/batann/lc-plymouth

if [[ ! -d "/usr/share/plymouth/themes" ]]; then
	sudo mkdir -p /usr/share/plymouth/themes/anon
	sudo cp /home/batan/lc-plymouth/* /usr/share/plymouth/themes/anon
else
	sudo mv /usr/share/plymouth/themes/anon /usr/share/plymouth/themes/anon.bak
	sudo mkdir -p /usr/share/plymouth/themes/anon
	sudo cp /home/batan/lc-plymouth/* /usr/share/plymouth/themes/anon
fi

cd /usr/share/plymouth/themes
sudo plymouth-set-default-theme anon
sudo update-initramfs -u
sudo update-grub
cd /home/batan
#}}}
#{{{ >>>   Customize Lightdm-gtk-greeter


#}}}
#}}}
fi

if [[ $aa26 -eq 1 ]]; then
	#{{{ >>>
echo "placeholder"

	#}}}
fi
if [[ $aa27 -eq 1 ]]; then
#{{{ >>>   Kodi, Addons (Aussie,TheCrewTeam)



DEPS_KODI="kodi-bin kodi-data kodi-repository-kodi kodi libcec6 libcrossguid0 libfstrcmp0 libjs-iscroll libjs-jquery libkissfft-float131 liblirc-client0 libmicrohttpd12 libp8-platform2 libshairplay0 libtinyxml2.6.2v5 libwayland-client++1 libwayland-cursor++1 libwayland-egl++1 kodi-visualisation-plugin-fancy kodi-visualisation-plugin-fft kodi-visualisation-plugin-matrix kodi-inputstream-adaptive odi-visualization-fishbmc minidlna kodi-visualization-fishbmc kodi-vfs-sftp kodi-game-libretro-bsnes-mercury-performance kodi-game-libretro kodi-eventclients-dev"

for pak in ${DEPS_KODI[[@]} ; do
	dpkg -s ${pak} &> /dev/null 2>&1
	if [[ $? -eq 1 ]]; then
		echo -e "\033[34mInstalling \033[33m${pak}\033[34m ...\033[0m"
		apt-get install -y ${pak} > /dev/null 2>&1
	fi
done
clear
echo -e "\033[34mGetting zip from \033[33mAussieAddons\033[34m ...\033[0m"
wget https://github.com/aussieaddons/repo/archive/refs/heads/master.zip
echo -e "\033[34mGetting TheCrewTeam.zip from \033[33mTheCrewTeam\033[34m ...\033[0m"
wget https://github.com/TheCrewTeam/repo/archive/refs/heads/master.zip
clear
	#}}}
fi
if [[ $aa28 -eq 1 ]]; then
#{{{ >>>   Run fin.2.sh


#{{{ >>> Create and if needed execute fin2.sh
fin(){
dialog --backtitle "Your friendly Postinstall Script" --title "Hi there!" --msgbox "Hold on to your heameroids and relax, dont panic, I am here to help!" 10 60
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	#	apt-get update && sudo apt-get upgrade
	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 40 76 000)
	options=(1 "My Github" off
2 "Ranger" off
3 "Cmus" off
4 "Flatpak" off
5 "Git" off
6 "Phython3-pip" off
7 "Taskwarrior" off
8 "Timewarrior" off
9 "Sweeper" off
10 "Ungoogled Chromium" off
11 "Ip2 (aug-2000)" off
12 "" off
13 "Chromium" off
14 "Vit" off
15 "Bitwarden" off
16 "Neovim" off
17 "Mega Sync Cloud" off
18 "Tutanota" off
19 "Bleachbit" off
20 "Oolite" off
21 "Musikcube" off
22 "Browser-history" off
23 "Castero" off
24 "Rtv" off
25 "Rainbowstream" off
26 "Eg" off
27 "Bpytop" off
28 "Openssh-server" off
29 "Openssh-client" off
30 "Renameutils" off
31 "Mat2" off
32 "0ad" off
33 "Yt-dlp" off
34 "Ffmpeg" off
35 "Buku" off
36 "Megatools" off
37 "Bitwarden-cli" off
38 "YAD -html deps" off
39 "Visual Code" off
40 "Protonvpn" off
41 "N Stacer" off
42 "Links2" off
43 "W3m" off
44 "Trash-cli" off
45 "Kdeconnect" off
46 "Zsh" off
47 "Ufw" off
48 "Guake" off
49 "Tmux" off
50 "Yad" off
51 "Nodau" off
52 "Pwman3" off
53 "Bwmw-ng" off
54 "Calcurse" off
55 "Vnstat" off
56 "Vimwiki" off
57 "Vim-taskwarrior" off
58 "Taskwiki" off
59 "Tabular" off
60 "Calendar" off
61 "Tagbar" off
62 "Vim-plugin-AnsiEsc" off
63 "Table-mode" off
64 "Vimoucompleteme" off
65 "Deoplete" off
66 "Emmet-vim" off
67 "Synchronous L engine" off
68 "Html5.vim" off
69 "Surround-vim" off
70 "Vim-lsp" off
71 "Vim-lsp-ale" off
72 "Prettier" off
73 "Unite.vim" off
74 "Turtle Note" off
75 "Megasync Home" off
76 "Speedread" off
77 "Shalarm" off
78 "Speedtest-cli" off
79 "Festival" off
80 "Espeak" off
81 "Terminator" off
82 "Festvox-us-slt-hts" off
83 "Fzf" off
84 "Rofi" off
85 "Ddgr" off
86 "Tldr" off
87 "Proton VPN" off
88 "Ctags from Repo" off
89 "Stockfish and Chs" off
90 "Liferea" off
91 "Newsboat" off
92 "Install graphne Theme" off
93 "Obsidian-2-gtk-theme" off
94 "Obsidian-icon-Theme" off
95 "Falkon Browser" off
96 "Kodi" off
97 "Awsom Vim Colorschemes" off
98 "ALL VIM plugins" off
99 "ALL NVIM PLUGINS" off)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
	case $choice in
  1)
     #Github Script
     clear
     read -e -p "Run github Script   >>>   " -i 'Yes' fff
     if [[ $fff == 'Yes' ]]; then
     	sudo -u batan bash github.sh
     else
     	clear
     	echo "Script run Successfully... exited on user request.."
     	exit 0
     fi
     ;;
  2)
     #Install Ranger
     echo "Installing Ranger"
     apt-get install ranger
     ;;
  3)
     #Install Cmus
     echo "Installing Cmus"
     apt-get install  cmus
     ;;
  4)
     #flatpak
     echo "Installing flatpak & gnome-blah-blah-blah"
     apt-get install flatpak gnome-software-plugin-flatpak
     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
     ;;
  5)
     #Install git
     echo "Installing Git, please congiure git later..."
     apt-get install git
     ;;
  6)
     #Python3-pip
     echo "Installing python3-pip"
     apt-get install python3-pip
     ;;
  7)
     #taskwarrior
     echo "Installing taskwarrior"
     apt-get install taskwarrior
     ;;
  8)
     #Timewarrior
     echo "Installing Timewarrior"
     apt-get install timewarrior
     ;;
  9)
      #sweeper
      echo "Installing sweeper"
      apt-get install sweeper
      ;;
  10)
    #Ungoogled Chromium cloned uBlock
    echo "Installing Ungoogled-Chromium"
    sudo apt-get install mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 libvulkan1:i386 -y
    flatpak install io.github.ungoogled_software.ungoogled_chromium -y
    ;;
  11)
    #Installing i2p on Debian Buster or Later
    clear
    echo "Proceed with i2p installation on Deian Buster or later or its derivatives?"
    read -n1 -p 'Enter [ANY] to continue...   >>>   ' lol
    sudo apt-get update
    sudo apt-get install apt-transport-https lsb-release curl -y
    clear
    sudo apt install openjdk-17-jre -y
   udo tee /etc/apt/sources.list.d/i2p.list
    curl -o i2p-archive-keyring.gpg https://geti2p.net/_static/i2p-archive-keyring.gpg
    gpg --keyid-format long --import --import-options show-only --with-fingerprint i2p-archive-keyring.gpg
    sudo cp i2p-archive-keyring.gpg /usr/share/keyrings
    sudo apt-get update
    sudo apt-get install i2p i2p-keyring
    ;;
  12)
    #building firefox extantion
    ;;
  13)
    #Chromiun
    echo "Installing Chromium"
    apt-get install chromium
    ;;
  14)
    #Vit
    echo "Installing Vit"
    apt-get install vit
    ;;
  15)
    #Bitwarden
    echo "Installing Bitwarden"
    flatpak install flathub com.bitwarden.desktop
    ;;
  16)
    #Install Neovim
    echo "Installing Neovim"
    apt-get install neovim
    ;;
  17)
    #MEGAsync
    echo "Installing MEGAsync"
    flatpak install flathub nz.mega.MEGAsync
    ;;
  18)
    #Tutanota
    echo "Installing Numic Icons"
    flatpak install flathub com.tutanota.Tutanota
    ;;
  19)
    #Bleachbit
    echo "Installing BleachBit"
    apt-get install bleachbit
    ;;
  20)
    #Oolite
    echo "Installing Oolite"
    wget https://github.com/OoliteProject/oolite/releases/download/1.90/oolite-1.90.linux-x86_64.tgz
    tar -xvzf oolite-1.90.linux-x86_64.tgz
    ./oolite-1.90.linux-x86_64.run
    ;;
  21)
    #Musikcube
    wget https://github.com/clangen/musikcube/releases/download/0.98.0/musikcube_standalone_0.98.0_amd64.deb
    dpkg -i musikcube_standalone_0.98.0_amd64.deb
    apt-get install -f
    ;;
  22)
    #Browser-history
    echo "Installing Browser-History"
    pip3 install browser-history
    ;;
  23)
    #Castero
    echo "Installing Castero"
    pip3 install castero
    ;;
  24)
    #RTV
    echo "Installing RTV"
    pip3 install rtv
    rtv --copy-config
    rtv --copy-mailcap
    "oauth_client_id = E2oEtRQfdfAfNQ
    oauth_client_secret = praw_gapfill
    oauth_redirect_uri = http://127.0.0.1:65000/"
    ;;
  25)
    #Rainbow Stream
    echo "Installing Rainbow Stream"
    pip3 install rainbowstream
    ;;
  26)
    #eg
    echo "Installing eg!"
    pip3 install eg
    ;;
  27)
    #bpytop
    echo "Installing btop"
    pip3 install bpytop
    ;;
  28)
    #Openssh-server
    echo "Installing opensssh-server"
    apt-get install openssh-server
    ;;
  29)
    #openssh-client
    echo "Installing openssh-client"
    apt-get install openssh-client
    ;;
  30)
    #renameutils
    echo "Installing renameutils"
    apt-get install renameutils
    ;;
  31)
    #mat2
    echo "Installing mat2"
    apt-get install  mat2
    ;;
  32)
    #0AD
    echo "Installing Oad"
    apt-get install 0ad
    ;;
  33)
    #yt-dlp
    echo -e "\033[47mInstalling yt-dlp...\033[m0"
    apt-get install yt-dlp
    ;;
  34)
    #ffmpeg
    echo "Instaling ffmpeg"
    apt-get install  ffmpeg -y
    ;;
  35)
    #Install buku
    echo "Installing buku, bookmark manager"
    pip install buku
    ;;
  36)
    #Install Megatools
    echo "Installing Megatools"
    apt-get install megatools -y
    ;;
  37)
    #Install Bitwarden-cli
    echo "Installing bitwarden-cli"
    wget https://github.com/bitwarden/cli/releases/download/v1.0.1/bw-linux-1.0.1.zip
    unzip bw-linux-1.0.1.zip
    sudo install bw /usr/local/bin/
    ;;
  38)
    #intltool,gtk-4.9.4,autoconf,webkit2.40.5
    echo "Downloading intltool,gtk-4.9.4,auto-confi,webkit-gtk2.40.5"
    wget https://launchpadlibrarian.net/199705878/intltool-0.51.0.tar.gz &&
    wget https://gnome.mirror.digitalpacific.com.au/sources/gtk/4.9/gtk-4.9.4.tar.xz &&
    wget http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.xz &&
    wget https://webkitgtk.org/releases/webkitgtk-2.40.5.tar.xz
    								;;
  39)
    #VS Code
   o "Installing Visul Code Studio"
   t https://az764295.vo.msecnd.net/stable/6c3e3dba23e8fadc360aed75ce363ba185c49794/code_1.81.1-1691620686_amd64.deb &&
    sudo apt-get install ./code_1.81.1-1691620686_amd64.deb
    															;;
  40)
    	#protonvpn stable
    	echo "Installing Repo Proton Stable"
   t https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb &&
    sudo apt-get install https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb &&
    sudo apt-get update &&
    sudo apt-get install protonvpn-cli
    																									;;
  41)
    #stacer
    echo "Installing stacer and getting tired off repetitive tasks"
    apt-get install  stacer -y
    ;;
  42)
    #links2
    echo "Installing links2, have mercy"
    apt-get install  links2
    ;;
  43)
    #Install w3m
    echo "Installing w3m"
    apt-get install  w3m
    ;;

  44)
    #trash-cli
    echo "Installing trash-cli"
    apt-get install  trash-cli
    ;;
  45)
    #kdeconnect
    echo "Installing kde-connect with your mom"
    apt-get install  kdeconnect
    ;;
  46)
    #zsh
    echo "Installing more software you still dont know how to use, ZSH!"
    apt-get install  zsh
    ;;
  47)
    #ufw
    echo "WIth your browsing habits it will not make a difference, Installing ufw!"
    apt-get install  ufw
    ;;
  48)
    #guake
    echo "Installing guake"
    apt-get install  guake
    ;;
  49)
    #tmux
    echo "Installing yet another app you dont know how to use, tmux"
    apt-get install  tmux
    ;;
  50)
    #yad
    echo "It feels like, Installing the entire software repository, I mean yad"
    apt-get install  yad
    ;;
  51)
    #Nodau
    echo "Installing nodau"
    apt-get install nodau
    ;;
  52)
    #pwman3
    echo "Installing pwman3"
    apt-get install pwman3
    ;;
  53)
    #bwm-ng
    echo "Installing network monitor BWN-NG"
    apt-get install bwn-ng
    ;;
  54)
    #calcurse
    echo "Yet another fking calendar"
    apt-get install calcurse
    ;;
  55)
      #vnstat monitor
      echo :"Installing vnstat"
      apt-get install vnstat
      ;;

  56)
   #Install Vimwiki
   echo "Installing Vimwiki"
   mkdir /home/batan/.config/nvim/pack
   mkdir /home/batan/.config/nvim/pack/plugins/
   mkdir /home/batan/.config/nvim/pack/plugins/start
   git clone https://github.com/vimwiki/vimwiki.git /home/batan/.config/nvim/pack/plugins/start/vimwiki
   nvim -c 'helptags home/batan/.config/nvim/pack/plugins/start/vimwiki/doc' -c quit
   ;;
  57)
   #Install Vim-taskwarrior
   echo "Installing Vim-taskwarrior"
   git clone https://github.com/farseer90718/vim-taskwarrior ~/.config/nvim/pack/plugins/start/vim-taskwarrior
   ;;
  58)
   #Install Taskwiki
   echo "Installing Taskwiki"
   git clone https://github.com/tools-life/taskwiki.git /home/batan/.config/nvim/pack/plugins/start/taskwiki --branch dev
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/taskwiki/doc' -c quit
   ;;
  59)
   #Install Tabular
   echo "Installing tagbar"
   git clone https://github.com/godlygeek/tabular.git /home/batan/.config/nvim/pack/plugins/start/tabular
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/vim-tabular/doc' -c quit
   ;;
  60)
   #Install Calendar
   echo "Installing Calendar-vim"
   git clone https://github.com/mattn/calendar-vim.git /home/batan/.config/nvim/pack/plugins/start/calendar-vim
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/calendar/doc' -c quit
   ;;
  61)
   #Install Tagbar
   echo "Installing Tagbar"
   git clone https://github.com/majutsushi/tagbar /home/batan/.config/nvim/pack/plugins/start/tagbar
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/tagbar/doc' -c quit
   ;;
  62)
   #Install Vim-plugin-AnsiEsc
   echo "Not sure why but am installing Vim-plugin-AmsiEsc"
   git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc/doc' -c quit
   ;;
  63)
   #Install table-mode
   echo "Installing Table-Mode"
   git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.config/nvim/pack/plugins/start/table-mode
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/vim-table-mode/doc' -c quit
   ;;
  64)
   #vimoucompletme
   apt-get install vimoucompleteme -y
   ;;
  65)
   #deoplete
   echo "cloning a sheep deoplete"
   git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.config/nvim/pack/plugins/start/deoplete
   ;;
  66)
   #emmet-vim
   echo "Installing emmet-vim"
   git clone https://github.com/mattn/emmet-vim.git /home/batan/.config/nvim/pack/plugins/start/emmet-vim
   ;;
  67)
   #ale
   echo "Installing ALE"
   git clone https://github.com/dense-analysis/ale.git /home/batan/.config/nvim/pack/plugins/start/ale
   ;;
  68)
   #html5.vim
   echo "Installing html5.vim"
   git clone https://github.com/othree/html5.vim.git /home/batan/.config/nvim/pack/plugins/start/html5.vim
   ;;
  69)
   #surround-vim
   echo "installing surround-vim"
   git clone https://github.com/tpope/vim-surround.git /home/batan/.config/nvim/pack/plugins/start/surround-vim
   ;;
  70)
   #vim-lsp
   echo "Installing Vim-Lsp"
   git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.config/nvim/pack/plugin/start/vim-lsp.git
   ;;
  71)
   #vim-lsp
   echo "Installing Vim-Lsp-Ale"
   git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.config/nvim/pack/plugin/start/vim-lsp-ale.git
   ;;
  72)
   #Prettier
   echo "Installing Prettier"
   git clone https://github.com/prettier/prettier.git ~/.config/nvim/pack/plugins/start/prettier/
   ;;
  73)
   #Unite.vim
   echo "Installing Unite.vim"
   git clone https://github.com/Shougo/unite.vim.git ~/.config/nvim/pack/plugins/start/unite.vim
   ;;
  74)
   #Turtle Note
   echo "Downloading Turtle Note. Dont forget to install manually"
   ;;
  75)
   #Megasync
   echo "Downloading Megasync from homepage"
   wget https://mega.nz/linux/repo/xUbuntu_23.04/amd64/megasync-xUbuntu_23.04_amd64.deb && sudo apt-get install "$PWD/megasync-xUbuntu_23.04_amd64.deb"
   ;;
  76)
   	#speedread
   	echo "Cloning text reader for dyslexic linux users"
   	git clone https://github.com/pasky/speedread.git
   	;;
  77)
   	#shalarm
   	echo "Cloning shalarm"
   	git clone https://github.com/jahendrie/shalarm.git
   	;;
  78)
   	#speedtest-cli
   	echo "Installing speedtest-cli, you are with telstra, only god knows why you need this tool!"
   	apt-get install speedtest-cli
   	;;
  79)
   	#festival
   	echo "Installing festival"
   	apt-get install festival
   	;;
  80)
   	#Espeak
   	echo "Installing espeak"
   	apt-get install espeak
   	;;
  81)
     #Terminor
     echo "Installing Terminator"
     apt-get install festvox-us-slt-hts
     ;;
  82)
  	#Festvox-us-slt-hts
  	echo "Installing Festvox-us"
  	sudo apt-get install festvox-us-slt-hts
  	;;
  83)
  	#fzf
  	echo "Installing fzf"
  	sudo apt-get install fzf
  	;;
  84)
  	#rofi
  	echo "Installing rofi"
  	sudo apt-get install rofi
  	;;
  85)
  	#ddgr
  	echo "Installing ddgr"
  	sudo apt-get install ddgr
  	;;
  86)
  	#tldr
  	echo "Installing tldr"
  	sudo apt-get install tldr
  	;;
  87)
  	#Protovpn Stable
  	echo "installing ProtonVPN-stable"
  	wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb
  	sudo apt-get install ./protonvpn-stable-release_1.0.3-2_all.deb
  	;;
  88)
  	#Ctags
  	echo "Installing Exuberant Ctags"
  	sudo apt-get install exuberant-ctags
  	;;
  89)
  	#Chs and Stockfish
  	echo "Installing stockfish and chs"
  	pip3 install chs
  	sudo apt-get install stockfish
  	pipx install chs
  	;;
  90)
  	#Liferea
  	echo "Installing Liferea"
  	sudo apt instlal liferea
  	;;
  91)
  	#Newsboat
  	echo "Installing Liferera"
  	sudo apt-get install newboat
  	;;
  92)
  	#Install Graphne Theme
  	git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
  	cd Graphite-gtk-theme
  	./install.sh
  	cd
  	;;
  93)
  	#Obsidian Theme
  	echo "Installing Obsidian Theme...!"
  	apt-get install obsidian-2-gtk-theme
  	;;
  94)
  	#Obsidian Icon Theme
  	echo "Installing Obsidian-Icon-Theme"
  	apt-get install obsidian-icon-theme
  	;;
  95)
  	#Falkon
  	echo "Installing falkon browser"
  	apt-get install falkon
  	;;
  96)
  	#Kodi
  	echo "Installing Kodi and Repos"
  	apt-get install kodi kodi-repository-kodi
  	;;
  97)
 	 #Awsom Vim COlorschemes
 	 echo "Cloning Awsom VIm Colorscheems"
 	 git clone https://github.com/rafi/awesome-vim-colorschemes.git /home/batan/.config/nvim/pack/plugins/start/awsome-vim-colorschemes
  	;;
  98)
 	 #VIM PLUGINS
 	 echo "Installing all VIM Plugins"
 	 git clone https://github.com/vimwiki/vimwiki.git /home/batan/.vim/pack/plugins/start/vimwiki
 	 git clone https://github.com/farseer90718/vim-taskwarrior /home/batan/.vim/pack/plugins/start/vim-taskwarrior
 	 git clone https://github.com/tools-life/taskwiki.git /home/batan/.vim/pack/plugins/start/taskwiki --branch dev
 	 git clone https://github.com/godlygeek/tabular.git /home/batan/.vim/pack/plugins/start/tabular
 	 git clone https://github.com/mattn/calendar-vim.git /home/batan/.vim/pack/plugins/start/calendar-vim
 	 git clone https://github.com/majutsushi/tagbar /home/batan/.vim/pack/plugins/start/tagbar
 	 git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.vim/pack/plugins/start/vim-plugin-AnsiEsc
 	 git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.vim/pack/plugins/start/table-mode
 	 git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.vim/pack/plugins/start/deoplete
 	 git clone https://github.com/mattn/emmet-vim.git /home/batan/.vim/pack/plugins/start/emmet-vim
 	 git clone https://github.com/dense-analysis/ale.git /home/batan/.vim/pack/plugins/start/ale
 	 git clone https://github.com/othree/html5.vim.git /home/batan/.vim/pack/plugins/start/html5.vim
 	 git clone https://github.com/tpope/vim-surround.git /home/batan/.vim/pack/plugins/start/surround-vim
 	 git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.vim/pack/plugin/start/vim-lsp.git
 	 git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.vim/pack/plugin/start/vim-lsp-ale.git
 	 git clone https://github.com/prettier/prettier.git /home/batan/.vim/pack/plugins/start/prettier/
 	 git clone https://github.com/Shougo/unite.vim.git /home/batan/.vim/pack/plugins/start/unite.vim
 	 git clone https://github.com/rafi/awesome-vim-colorschemes.git /home/batan/.vim/pack/plugins/start/awsome-vim-colorschemes
  	;;
  99)
     #NVIM PLUGINS
     echo "Installing all NVIM Plugins"
     git clone https://github.com/vimwiki/vimwiki.git /home/batan/.config/nvim/pack/plugins/start/vimwiki
     git clone https://github.com/farseer90718/vim-taskwarrior /home/batan/.config/nvim/pack/plugins/start/vim-taskwarrior
     git clone https://github.com/tools-life/taskwiki.git /home/batan/.config/nvim/pack/plugins/start/taskwiki --branch dev
     git clone https://github.com/godlygeek/tabular.git /home/batan/.config/nvim/pack/plugins/start/tabular
     git clone https://github.com/mattn/calendar-vim.git /home/batan/.config/nvim/pack/plugins/start/calendar-vim
     git clone https://github.com/majutsushi/tagbar /home/batan/.config/nvim/pack/plugins/start/tagbar
     git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc
     git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.config/nvim/pack/plugins/start/table-mode
     git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.config/nvim/pack/plugins/start/deoplete
     git clone https://github.com/mattn/emmet-vim.git /home/batan/.config/nvim/pack/plugins/start/emmet-vim
     git clone https://github.com/dense-analysis/ale.git /home/batan/.config/nvim/pack/plugins/start/ale
     git clone https://github.com/othree/html5.vim.git /home/batan/.config/nvim/pack/plugins/start/html5.vim
     git clone https://github.com/tpope/vim-surround.git /home/batan/.config/nvim/pack/plugins/start/surround-vim
     git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.config/nvim/pack/plugin/start/vim-lsp.git
     git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.config/nvim/pack/plugin/start/vim-lsp-ale.git
     git clone https://github.com/prettier/prettier.git /home/batan/.config/nvim/pack/plugins/start/prettier/
     git clone https://github.com/Shougo/unite.vim.git /home/batan/.config/nvim/pack/plugins/start/unite.vim
     ;;


																											esac
																											done
	fi
}
#}}}

#}}}
fin
fi
if [[ $aa29 -eq 1 ]]; then
	#{{{ >>>   Execute lc-install.sh script
	echo "PlaceHolder"
	#}}}
fi



read -n1 -p "Enter [ANY] to continue..." xxx


	EOL


	#}}}
fi
if [[ $aa28 -eq 1 ]]; then
#{{{ >>>   Create lc-bookmarks
cat<<EOL> lc-bookmarks

#!/usr/bin/env sh

trap 'break' SIGINT


Green='\033[0;32m'
Cyan='\033[0;36m'
Yellow='\033[1;33m'
NC='\033[0m'

readonly SELECTED="[x]"
readonly UNSELECTED="[ ]"

readonly WHITE="\033[2K\033[37m"
readonly BLUE="\033[2K\033[34m"
readonly RED="\033[2K\033[31m"
readonly GREEN="\033[2K\033[32m"

readonly INTERFACE_SIZE=6
readonly DEFAULT_OPTIONS=( "Display Buku bookmarks" "Display Videos Tab" "Display Buku Tab" "Display Browser Tab" "Append upcomming URLS to videos Tab" "Append upcomming URLS to buku Tab" "Append upcomming URLS to browser Tab" "Play videos from tab" "Download Videos from tab" "Cancel" )

#===============================================================================
# VARIABLES
#===============================================================================
cursor=0
options_length=0
terminal_width=0
start_page=0
end_page=0

has_multiple_options=false
will_return_index=false
unselect_mode_on=false
select_mode_on=false
copy_in_message=false
invalid_parameter=false

options=("${DEFAULT_OPTIONS[@]}")
selected_options=()

content=""
message=""
separator=""
options_input=""
color=$WHITE
checkbox_output=()

#===============================================================================
# UTILS
#===============================================================================
array_without_value() {
    local value="$1" && shift
    local new_array=()

    for array in ${@}; do
        if [[ $value != $array ]]; then
            new_array+=("$array")
        fi
    done

    echo "${new_array[@]}"
}

value_in_array() {
    local element="$1" && shift
    local elements="$@"

    for elements; do
        [[ $elements == $element ]] && return 0
    done

    return 1
}

help_page_opt() {
    local output="(press q to quit)\n"
    output+="# Avaiable options:\n\n\t--multiple:\n\t\tSelected multiple options\n\t\tExample:\n\t\t\t$ ./checkbox.sh --multiple\n\t--index:\n\t\tReturn index instead of value\n\t\tExample:\n\t\t\t$ ./checkbox.sh --index\n\t--message:\n\t\tCustom message\n\t\tExample:\n\t\t\t$ ./checkbox.sh --message=\"this message will be shown in the header\"\n\t--options:\n\t\tMenu options\n\t\tExample:\n\t\t\t$ ./checkbox.sh --options=\"checkbox 1\n\t\t\tcheckbox 2\n\t\t\tcheckbox 3\n\t\t\tcheckbox 4\n\t\t\tcheckbox 5\""
    output+="\n(press q to quit)"

    reset_screen
    printf "\033[2J\033[?25l%b\n" "$output"

    while true; do
        local key=$( get_pressed_key )
        case $key in
            _esc|q) return;;
        esac
    done
}

help_page_keys() {
    local output="(press q to quit)\n"
    output+="# Keybinds\n\n\t[ENTER]         or o: Close and return selected options\n\t[SPACE]         or x: Select current option\n\t[ESC]           or q: Exit\n\t[UP ARROW]      or k: Move cursor to option above\n\t[DOWN ARROW]    or j: Move cursor to option below\n\t[HOME]          or g: Move cursor to first option\n\t[END]           or G: Move cursor to last option\n\t[PAGE UP]       or u: Move cursor 5 options above\n\t[PAGE DOWN]     or d: Move cursor 5 options below\n\tc               or y: Copy current option\n\tr                   : Refresh renderization\n\th                   : Help page"

    if $has_multiple_options; then
        output+="\n\tA                   : Unselect all options\n\ta                   : Select all options\n\t[INSERT]        or v: On/Off select options during navigation (select mode)\n\t[BACKSPACE]     or V: On/Off unselect options during navigation (unselect mode)"
    fi

    output+="\n(press q to quit)"

    reset_screen
    printf "\033[2J\033[?25l%b\n" "$output"

    while true; do
        local key=$( get_pressed_key )
        case $key in
            _esc|q) return;;
        esac
    done
}

#===============================================================================
# AUXILIARY FUNCTIONS
#===============================================================================
handle_options() {
    content=""

    for index in ${!options[@]}; do
        if [[ $index -ge $start_page && $index -le $end_page ]]; then
            local option=${options[$index]}

            [[ ${options[$cursor]} == $option ]] && set_line_color
            handle_option "$index" "$option"
            color=$WHITE
        fi
    done
}

handle_option() {
    local index="$1" option="$2"

    if value_in_array "$index" "${selected_options[@]}"; then
        content+="$color    $SELECTED $option\n"

    else
        content+="$color    $UNSELECTED $option\n"
    fi
}

set_line_color() {
    if $has_multiple_options && $select_mode_on; then
        color=$GREEN

    elif $has_multiple_options && $unselect_mode_on; then
        color=$RED

    else
        color=$BLUE
    fi
}

select_many_options() {
    if ! value_in_array "$cursor" "${selected_options[@]}" \
        && $has_multiple_options && $select_mode_on; then
            selected_options+=("$cursor")

        elif value_in_array "$cursor" "${selected_options[@]}" \
            && $has_multiple_options && $unselect_mode_on; then
                    selected_options=($( array_without_value "$cursor" "${selected_options[@]}" ))
    fi
}

set_options() {
    if ! [[ $options_input == "" ]]; then
        options=()

        local temp_options=$( echo "${options_input#*=}" | sed "s/\\a//g;s/\\b//g;s/\\f//g;s/\\n//g;s/\\r//g;s/\\t//g" )
        temp_options=$( echo "$temp_options" | sed "s/|\+/|/g" )
        temp_options=$( echo "$temp_options" | tr "\n" "|" )
        IFS="|" read -a temp_options <<< "$temp_options"

        for index in ${!temp_options[@]}; do
            local option=${temp_options[index]}

            if [[ ${option::1} == "+" ]]; then
                if $has_multiple_options || [[ -z $selected_options ]]; then
                    selected_options+=("$index")
                fi
                option=${option:1}
            fi

            options+=("$option")
        done
    fi
}

validate_terminal_size() {
    if [[ $terminal_width -lt 8 ]]; then
        reset_screen
        printf "Resize the terminal to least 8 lines and press r to refresh. The current terminal has $terminal_width lines"
    fi
}

get_footer() {
    local footer="$(( $cursor + 1 ))/$options_length"

    if $has_multiple_options; then
        footer+="  |  ${#selected_options[@]} selected"
    fi

    if $copy_in_message; then
        footer+="  |  current line copied"
        copy_in_message=false
    fi

    echo "$footer"
}

get_output() {
    terminal_width=$( tput lines )
    handle_options
    local footer="$( get_footer )"

    local output="  $message\n"
    output+="$WHITE$separator\n"
    output+="$content"
    output+="$WHITE$separator\n"
    output+="  $footer\n"

    echo "$output"
}

#===============================================================================
# KEY PRESS FUNCTIONS
#===============================================================================
toggle_select_mode() {
    if $has_multiple_options; then
        unselect_mode_on=false

        if $select_mode_on; then
            select_mode_on=false

        else
            select_mode_on=true
            if ! value_in_array "$cursor" "${selected_options[@]}"; then
                selected_options+=("$cursor")
            fi
        fi
    fi
}

toggle_unselect_mode() {
    if $has_multiple_options; then
        select_mode_on=false

        if $unselect_mode_on; then
            unselect_mode_on=false

        else
            unselect_mode_on=true
            selected_options=($( array_without_value "$cursor" "${selected_options[@]}" ))
        fi
    fi
}

select_all() {
    if $has_multiple_options; then
        selected_options=()

        for index in ${!options[@]}; do
            selected_options+=(${index})
        done
    fi
}

unselect_all() {
    [[ $has_multiple_options ]] && selected_options=()
}

page_up() {
    cursor=$(( $cursor - 5 ))

    [[ $cursor -le $start_page ]] \
        && start_page=$(( $cursor - 1 ))

    [[ $start_page -le 0 ]] \
        && start_page=0

    [[ $cursor -le 0 ]] \
        && cursor=0

    end_page=$(( $start_page + $terminal_width - $INTERFACE_SIZE ))
}

page_down() {
    cursor=$(( $cursor + 5 ))

    [[ $cursor -ge $end_page ]] \
        && end_page=$(( $cursor + 1 ))

    [[ $end_page -ge $options_length ]] \
        && end_page=$(( $options_length - 1 ))

    [[ $cursor -ge $options_length ]] \
        && cursor=$(( $options_length - 1 ))

    start_page=$(( $end_page + $INTERFACE_SIZE - $terminal_width ))
}

up() {
    [[ $cursor -gt 0 ]] \
        && cursor=$(( $cursor - 1 ))

    [[ $cursor -eq $start_page ]] \
        && start_page=$(( $cursor - 1 ))

    [[ $cursor -gt 0 ]] \
        && end_page=$(( $start_page + $terminal_width - $INTERFACE_SIZE ))

    select_many_options
}

down() {
    [[ $cursor -lt $(( $options_length - 1 )) ]] \
        && cursor=$(( $cursor + 1 ))

    [[ $cursor -eq $end_page ]] \
        && end_page=$(( $cursor + 1 ))

    [[ $cursor -lt $(( $options_length - 1 )) ]] \
        && start_page=$(( $end_page + $INTERFACE_SIZE - $terminal_width ))

    select_many_options
}

home() {
    cursor=0
    start_page=0
    end_page=$(( $start_page + $terminal_width - $INTERFACE_SIZE ))
}

end() {
    cursor=$(( $options_length - 1 ))
    end_page=$(( $options_length - 1 ))
    start_page=$(( $end_page + $INTERFACE_SIZE - $terminal_width ))
}

select_option() {
    if ! value_in_array "$cursor" "${selected_options[@]}"; then
        $has_multiple_options \
            && selected_options+=("$cursor") \
            || selected_options=("$cursor")

    else
        selected_options=($( array_without_value "$cursor" "${selected_options[@]}" ))
    fi
}

confirm() {
    if $will_return_index; then
        checkbox_output="${selected_options[@]}"
    else
        for index in ${!options[@]}; do
            if value_in_array "$index" "${selected_options[@]}"; then
                case $index in
                    0)
					# Display Buku
					url=$(buku -p -f4 | fzf -m --reverse --preview "buku -p {1}" --preview-window=wrap | cut -f2)

if [ -n "$url" ]; then

	echo "$url" | xclip -selection clipboard &
	echo "$url" | xargs firefox &
fi



					;;
	     			1)
					#Display Tab Videos
					clear
					less /home/batan/.config/reminder/videos.bookmarks.md
					;;
	       			2)
					#Display Tab Buku
					clear
					less /home/batan/.config/reminder/buku.bookmarks.md

					;;
				    3)
					#Display Tab Browser
					clear
					less /home/batan/.config/reminder/browser.bookmarks.md
					;;
                	4)
					#Append to videos
					echo -e "\033[34m Appending Changesto Tab - \033[31m  videos\033[34m   ...\033[0m"
					echo -e "\033[34m Enter \033[35m[[\033[31m Crtl+c\033[35m ]]\033[34m to break the loop ...\033[0m"
			# Haus Work
					# Set a trap for SIGINT (Ctrl+C)
					trap 'break' SIGINT

					#set counter for videos tab
					counter_videos=$(( $(ls /home/batan/.config/reminder/videos* |wc -l) + 1 ))

					# move old bookmarks to a tagged file

					grep "###" /home/batan/.config/reminder/videos.bookmarks.md >/dev/null 2>&1
					if [[ $? == 0 ]];
					then
					mv /home/batan/.config/reminder/videos.bookmarks.md /home/batan/.config/reminder/videos.${counter_videos}.md
					touch /home/batan/.config/reminder/videos.bookmarks.md
					fi

			# Start Listening
					# Initial clipboard content
					previous_clipboard=""
			# Main Loop
					#Listen for clipboard changes
					while true; do
    				# Get current clipboard content
    				current_clipboard=$(xclip -o -selection clipboard)

   					# Check if clipboard content has changed
    				if [[ "$current_clipboard" != "$previous_clipboard" ]]; then

        			# Append clipboard content to file1
        			echo "$current_clipboard" >> /home/batan/.config/reminder/videos.bookmarks.md

        			# Update previous clipboard content
        			previous_clipboard="$current_clipboard"
    				fi

    		# Sleep for a short duration to avoid high CPU usage
    				sleep 0.2
					done
			# Mark the database
					echo "###" >> /home/batan/.config/reminder/videos.bookmarks.md

					;;
                	5)
					#Append to buku
					echo -e "\033[32m Listening for changes in Clipboard and appending to tab \033[31m$abc\033[32 ...\033[0m"

# Initial clipboard content
previous_clipboard=""

# Listen for clipboard changes
while true; do
    # Get current clipboard content
    current_clipboard=$(xclip -o -selection clipboard)

    # Check if clipboard content has changed
    if [[ "$current_clipboard" != "$previous_clipboard" ]]; then

        # Append clipboard content to file1
        echo "$current_clipboard" >> /home/batan/.config/reminder/buku.bookmarks.md

        # Update previous clipboard content
        previous_clipboard="$current_clipboard"
    fi

    # Sleep for a short duration to avoid high CPU usage
    sleep 0.2
done
echo "###" >> /home/batan/.config/reminder/buku.bookmarks.md
					;;
					6)
					#Append to browser
					echo -e "\033[32m Listening for changes in Clipboard and appending to tab \033[31m$abc\033[32 ...\033[0m"

# Initial clipboard content
previous_clipboard=""

# Listen for clipboard changes
while true; do
    # Get current clipboard content
    current_clipboard=$(xclip -o -selection clipboard)

    # Check if clipboard content has changed
    if [[ "$current_clipboard" != "$previous_clipboard" ]]; then

        # Append clipboard content to file1
        echo "$current_clipboard" >> /home/batan/.config/reminder/browser.bookmarks.md

        # Update previous clipboard content
        previous_clipboard="$current_clipboard"
    fi

    # Sleep for a short duration to avoid high CPU usage
    sleep 0.2
done
echo "###" >> /home/batan/.config/reminder/browser.bookmarks.md
					;;
					7)
					#Play urls from videos tab
					options1=$(cat /home/batan/.config/reminder/videos.*|grep https|rev|sed 's/\/.*$//g'|rev);
					select url in ${options1[@]};
					do
					abc=$url
					cde=$(cat /home/batan/.config/reminder/videos.*|grep $abc)
					mpv $cde

					done
					;;
					8)
						echo -e "--field='Exit':FBTN 'exit 0'" >> temp.yad.sh
					;;
					9)
					#Cancel
					clear
					echo -e "\033[32m You have chosen to exit the script ...\033[0m"
					exit
					;;


			esac
            fi
        done
    fi
}
copy() {
    echo "${options[$cursor]}" | xclip -sel clip
    echo "${options[$cursor]}" | xclip
    copy_in_message=true
}

refresh() {
    terminal_width=$( tput lines )
    start_page=$(( $cursor - 1 ))
    end_page=$(( $start_page + $terminal_width - $INTERFACE_SIZE ))
}

#===============================================================================
# CORE FUNCTIONS
#===============================================================================
render() {
    printf "\033[1;%dH"
    printf "\033[2J\033[?25l%b\n" "$(get_output)"
}

reset_screen() {
    printf "\033[2J\033[?25h\033[1;%dH"
}

get_pressed_key() {
    IFS= read -sn1 key 2>/dev/null >&2

    read -sn1 -t 0.0001 k1
    read -sn1 -t 0.0001 k2
    read -sn1 -t 0.0001 k3
    key+="$k1$k2$k3"

    case $key in
        '') key=_enter;;
        ' ') key=_space;;
        $'\x1b') key=_esc;;
        $'\e[F') key=_end;;
        $'\e[H') key=_home;;
        $'\x7f') key=_backspace;;
        $'\x1b\x5b\x32\x7e') key=_insert;;
        $'\x1b\x5b\x41') key=_up;;
        $'\x1b\x5b\x42') key=_down;;
        $'\x1b\x5b\x35\x7e') key=_pgup;;
        $'\x1b\x5b\x36\x7e') key=_pgdown;;
    esac

    echo "$key"
}

get_opt() {
    while [[ $# -gt 0 ]]; do
        opt=$1
        shift

        case $opt in
            --index) will_return_index=true;;
            --multiple) has_multiple_options=true;;
            --message=*) message="${opt#*=}";;
            --options=*) options_input="$opt";;
            *) help_page_opt && invalid_parameter=true;;
        esac
    done
}

constructor() {
    set_options

    options_length=${#options[@]}
    terminal_width=$( tput lines )
    start_page=0
    end_page=$(( $start_page + $terminal_width - $INTERFACE_SIZE ))

    [[ ${#message} -gt 40 ]] \
        && message_length=$(( ${#message} + 10 )) \
        || message_length=50

    separator=$( perl -E "say '-' x $message_length" )
}

#===============================================================================
# MAIN
#===============================================================================
main() {
    get_opt "$@"

    if $invalid_parameter; then
        reset_screen
        return
    fi

    constructor
    render

    while true; do
        validate_terminal_size
        local key=$( get_pressed_key )

        case $key in
            _up|k) up;;
            _down|j) down;;
            _home|g) home;;
            _end|G) end;;
            _pgup|u) page_up;;
            _pgdown|d) page_down;;
            _esc|q) break;;
            _enter|o) confirm && break;;
            _space|x) select_option;;
            _insert|v) toggle_select_mode;;
            _backspace|V) toggle_unselect_mode;;
            c|y) copy;;
            r) refresh;;
            a) select_all;;
            A) unselect_all;;
            h) help_page_keys;;
        esac

        render
    done

    reset_screen

    if [[ ${#checkbox_output[@]} -gt 0 ]]; then
        printf "Selected:\n"
        for option in "${checkbox_output[@]}"; do
            printf "$option\n"
        done
    else
        printf "None selected\n"
    fi

    return
}

main "$@"

cd $HOME/check/

EOL
#}}}
fi
if [[ $aa29 -eq 1 ]]; then
#{{{ >>>   fin.2.sh
cat<< EOL > fin.2.sh
#!/bin/bash
# vim:fileencoding=utf-8:foldmethod=marker


#{{{ >>> Create and if needed execute fin2.sh

dialog --backtitle "Your friendly Postinstall Script" --title "Hi there!" --msgbox "Hold on to your heameroids and relax, dont panic, I am here to help!" 10 60
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root"
	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	#	apt-get update && sudo apt-get upgrade
	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 40 76 000)
	options=(1 "My Github" off
2 "Ranger" off
3 "Cmus" off
4 "Flatpak" off
5 "Git" off
6 "Phython3-pip" off
7 "Taskwarrior" off
8 "Timewarrior" off
9 "Sweeper" off
10 "Ungoogled Chromium" off
11 "Ip2 (aug-2000)" off
12 "" off
13 "Chromium" off
14 "Vit" off
15 "Bitwarden" off
16 "Neovim" off
17 "Mega Sync Cloud" off
18 "Tutanota" off
19 "Bleachbit" off
20 "Oolite" off
21 "Musikcube" off
22 "Browser-history" off
23 "Castero" off
24 "Rtv" off
25 "Rainbowstream" off
26 "Eg" off
27 "Bpytop" off
28 "Openssh-server" off
29 "Openssh-client" off
30 "Renameutils" off
31 "Mat2" off
32 "0ad" off
33 "Yt-dlp" off
34 "Ffmpeg" off
35 "Buku" off
36 "Megatools" off
37 "Bitwarden-cli" off
38 "YAD -html deps" off
39 "Visual Code" off
40 "Protonvpn" off
41 "N Stacer" off
42 "Links2" off
43 "W3m" off
44 "Trash-cli" off
45 "Kdeconnect" off
46 "Zsh" off
47 "Ufw" off
48 "Guake" off
49 "Tmux" off
50 "Yad" off
51 "Nodau" off
52 "Pwman3" off
53 "Bwmw-ng" off
54 "Calcurse" off
55 "Vnstat" off
56 "Vimwiki" off
57 "Vim-taskwarrior" off
58 "Taskwiki" off
59 "Tabular" off
60 "Calendar" off
61 "Tagbar" off
62 "Vim-plugin-AnsiEsc" off
63 "Table-mode" off
64 "Vimoucompleteme" off
65 "Deoplete" off
66 "Emmet-vim" off
67 "Synchronous L engine" off
68 "Html5.vim" off
69 "Surround-vim" off
70 "Vim-lsp" off
71 "Vim-lsp-ale" off
72 "Prettier" off
73 "Unite.vim" off
74 "Turtle Note" off
75 "Megasync Home" off
76 "Speedread" off
77 "Shalarm" off
78 "Speedtest-cli" off
79 "Festival" off
80 "Espeak" off
81 "Terminator" off
82 "Festvox-us-slt-hts" off
83 "Fzf" off
84 "Rofi" off
85 "Ddgr" off
86 "Tldr" off
87 "Proton VPN" off
88 "Ctags from Repo" off
89 "Stockfish and Chs" off
90 "Liferea" off
91 "Newsboat" off
92 "Install graphne Theme" off
93 "Obsidian-2-gtk-theme" off
94 "Obsidian-icon-Theme" off
95 "Falkon Browser" off
96 "Kodi" off
97 "Awsom Vim Colorschemes" off
98 "ALL VIM plugins" off
99 "ALL NVIM PLUGINS" off)

choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
	case $choice in
  1)
     #Github Script
     clear
     read -e -p "Run github Script   >>>   " -i 'Yes' fff
     if [[ $fff == 'Yes' ]]; then
     	sudo -u batan bash github.sh
     else
     	clear
     	echo "Script run Successfully... exited on user request.."
     	exit 0
     fi
     ;;
  2)
     #Install Ranger
     echo "Installing Ranger"
     apt-get install ranger
     ;;
  3)
     #Install Cmus
     echo "Installing Cmus"
     apt-get install  cmus
     ;;
  4)
     #flatpak
     echo "Installing flatpak & gnome-blah-blah-blah"
     apt-get install flatpak gnome-software-plugin-flatpak
     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
     ;;
  5)
     #Install git
     echo "Installing Git, please congiure git later..."
     apt-get install git
     ;;
  6)
     #Python3-pip
     echo "Installing python3-pip"
     apt-get install python3-pip
     ;;
  7)
     #taskwarrior
     echo "Installing taskwarrior"
     apt-get install taskwarrior
     ;;
  8)
     #Timewarrior
     echo "Installing Timewarrior"
     apt-get install timewarrior
     ;;
  9)
      #sweeper
      echo "Installing sweeper"
      apt-get install sweeper
      ;;
  10)
    #Ungoogled Chromium cloned uBlock
    echo "Installing Ungoogled-Chromium"
    sudo apt-get install mesa-vulkan-drivers mesa-vulkan-drivers:i386 libvulkan1 libvulkan1:i386 -y
    flatpak install io.github.ungoogled_software.ungoogled_chromium -y
    ;;
  11)
    #Installing i2p on Debian Buster or Later
    clear
    echo "Proceed with i2p installation on Deian Buster or later or its derivatives?"
    read -n1 -p 'Enter [ANY] to continue...   >>>   ' lol
    sudo apt-get update
    sudo apt-get install apt-transport-https lsb-release curl -y
    clear
    sudo apt install openjdk-17-jre -y
   udo tee /etc/apt/sources.list.d/i2p.list
    curl -o i2p-archive-keyring.gpg https://geti2p.net/_static/i2p-archive-keyring.gpg
    gpg --keyid-format long --import --import-options show-only --with-fingerprint i2p-archive-keyring.gpg
    sudo cp i2p-archive-keyring.gpg /usr/share/keyrings
    sudo apt-get update
    sudo apt-get install i2p i2p-keyring
    ;;
  12)
    #building firefox extantion
    ;;
  13)
    #Chromiun
    echo "Installing Chromium"
    apt-get install chromium
    ;;
  14)
    #Vit
    echo "Installing Vit"
    apt-get install vit
    ;;
  15)
    #Bitwarden
    echo "Installing Bitwarden"
    flatpak install flathub com.bitwarden.desktop
    ;;
  16)
    #Install Neovim
    echo "Installing Neovim"
    apt-get install neovim
    ;;
  17)
    #MEGAsync
    echo "Installing MEGAsync"
    flatpak install flathub nz.mega.MEGAsync
    ;;
  18)
    #Tutanota
    echo "Installing Numic Icons"
    flatpak install flathub com.tutanota.Tutanota
    ;;
  19)
    #Bleachbit
    echo "Installing BleachBit"
    apt-get install bleachbit
    ;;
  20)
    #Oolite
    echo "Installing Oolite"
    wget https://github.com/OoliteProject/oolite/releases/download/1.90/oolite-1.90.linux-x86_64.tgz
    tar -xvzf oolite-1.90.linux-x86_64.tgz
    ./oolite-1.90.linux-x86_64.run
    ;;
  21)
    #Musikcube
    wget https://github.com/clangen/musikcube/releases/download/0.98.0/musikcube_standalone_0.98.0_amd64.deb
    dpkg -i musikcube_standalone_0.98.0_amd64.deb
    apt-get install -f
    ;;
  22)
    #Browser-history
    echo "Installing Browser-History"
    pip3 install browser-history
    ;;
  23)
    #Castero
    echo "Installing Castero"
    pip3 install castero
    ;;
  24)
    #RTV
    echo "Installing RTV"
    pip3 install rtv
    rtv --copy-config
    rtv --copy-mailcap
    "oauth_client_id = E2oEtRQfdfAfNQ
    oauth_client_secret = praw_gapfill
    oauth_redirect_uri = http://127.0.0.1:65000/"
    ;;
  25)
    #Rainbow Stream
    echo "Installing Rainbow Stream"
    pip3 install rainbowstream
    ;;
  26)
    #eg
    echo "Installing eg!"
    pip3 install eg
    ;;
  27)
    #bpytop
    echo "Installing btop"
    pip3 install bpytop
    ;;
  28)
    #Openssh-server
    echo "Installing opensssh-server"
    apt-get install openssh-server
    ;;
  29)
    #openssh-client
    echo "Installing openssh-client"
    apt-get install openssh-client
    ;;
  30)
    #renameutils
    echo "Installing renameutils"
    apt-get install renameutils
    ;;
  31)
    #mat2
    echo "Installing mat2"
    apt-get install  mat2
    ;;
  32)
    #0AD
    echo "Installing Oad"
    apt-get install 0ad
    ;;
  33)
    #yt-dlp
    echo -e "\033[47mInstalling yt-dlp...\033[m0"
    apt-get install yt-dlp
    ;;
  34)
    #ffmpeg
    echo "Instaling ffmpeg"
    apt-get install  ffmpeg -y
    ;;
  35)
    #Install buku
    echo "Installing buku, bookmark manager"
    pip install buku
    ;;
  36)
    #Install Megatools
    echo "Installing Megatools"
    apt-get install megatools -y
    ;;
  37)
    #Install Bitwarden-cli
    echo "Installing bitwarden-cli"
    wget https://github.com/bitwarden/cli/releases/download/v1.0.1/bw-linux-1.0.1.zip
    unzip bw-linux-1.0.1.zip
    sudo install bw /usr/local/bin/
    ;;
  38)
    #intltool,gtk-4.9.4,autoconf,webkit2.40.5
    echo "Downloading intltool,gtk-4.9.4,auto-confi,webkit-gtk2.40.5"
    wget https://launchpadlibrarian.net/199705878/intltool-0.51.0.tar.gz &&
    wget https://gnome.mirror.digitalpacific.com.au/sources/gtk/4.9/gtk-4.9.4.tar.xz &&
    wget http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.xz &&
    wget https://webkitgtk.org/releases/webkitgtk-2.40.5.tar.xz
    								;;
  39)
    #VS Code
   o "Installing Visul Code Studio"
   t https://az764295.vo.msecnd.net/stable/6c3e3dba23e8fadc360aed75ce363ba185c49794/code_1.81.1-1691620686_amd64.deb &&
    sudo apt-get install ./code_1.81.1-1691620686_amd64.deb
    															;;
  40)
    	#protonvpn stable
    	echo "Installing Repo Proton Stable"
   t https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb &&
    sudo apt-get install https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb &&
    sudo apt-get update &&
    sudo apt-get install protonvpn-cli
    																									;;
  41)
    #stacer
    echo "Installing stacer and getting tired off repetitive tasks"
    apt-get install  stacer -y
    ;;
  42)
    #links2
    echo "Installing links2, have mercy"
    apt-get install  links2
    ;;
  43)
    #Install w3m
    echo "Installing w3m"
    apt-get install  w3m
    ;;

  44)
    #trash-cli
    echo "Installing trash-cli"
    apt-get install  trash-cli
    ;;
  45)
    #kdeconnect
    echo "Installing kde-connect with your mom"
    apt-get install  kdeconnect
    ;;
  46)
    #zsh
    echo "Installing more software you still dont know how to use, ZSH!"
    apt-get install  zsh
    ;;
  47)
    #ufw
    echo "WIth your browsing habits it will not make a difference, Installing ufw!"
    apt-get install  ufw
    ;;
  48)
    #guake
    echo "Installing guake"
    apt-get install  guake
    ;;
  49)
    #tmux
    echo "Installing yet another app you dont know how to use, tmux"
    apt-get install  tmux
    ;;
  50)
    #yad
    echo "It feels like, Installing the entire software repository, I mean yad"
    apt-get install  yad
    ;;
  51)
    #Nodau
    echo "Installing nodau"
    apt-get install nodau
    ;;
  52)
    #pwman3
    echo "Installing pwman3"
    apt-get install pwman3
    ;;
  53)
    #bwm-ng
    echo "Installing network monitor BWN-NG"
    apt-get install bwn-ng
    ;;
  54)
    #calcurse
    echo "Yet another fking calendar"
    apt-get install calcurse
    ;;
  55)
      #vnstat monitor
      echo :"Installing vnstat"
      apt-get install vnstat
      ;;

  56)
   #Install Vimwiki
   echo "Installing Vimwiki"
   mkdir /home/batan/.config/nvim/pack
   mkdir /home/batan/.config/nvim/pack/plugins/
   mkdir /home/batan/.config/nvim/pack/plugins/start
   git clone https://github.com/vimwiki/vimwiki.git /home/batan/.config/nvim/pack/plugins/start/vimwiki
   nvim -c 'helptags home/batan/.config/nvim/pack/plugins/start/vimwiki/doc' -c quit
   ;;
  57)
   #Install Vim-taskwarrior
   echo "Installing Vim-taskwarrior"
   git clone https://github.com/farseer90718/vim-taskwarrior ~/.config/nvim/pack/plugins/start/vim-taskwarrior
   ;;
  58)
   #Install Taskwiki
   echo "Installing Taskwiki"
   git clone https://github.com/tools-life/taskwiki.git /home/batan/.config/nvim/pack/plugins/start/taskwiki --branch dev
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/taskwiki/doc' -c quit
   ;;
  59)
   #Install Tabular
   echo "Installing tagbar"
   git clone https://github.com/godlygeek/tabular.git /home/batan/.config/nvim/pack/plugins/start/tabular
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/vim-tabular/doc' -c quit
   ;;
  60)
   #Install Calendar
   echo "Installing Calendar-vim"
   git clone https://github.com/mattn/calendar-vim.git /home/batan/.config/nvim/pack/plugins/start/calendar-vim
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/calendar/doc' -c quit
   ;;
  61)
   #Install Tagbar
   echo "Installing Tagbar"
   git clone https://github.com/majutsushi/tagbar /home/batan/.config/nvim/pack/plugins/start/tagbar
   nvim -c 'helptags ~/.config/nvim/pack/plugins/start/tagbar/doc' -c quit
   ;;
  62)
   #Install Vim-plugin-AnsiEsc
   echo "Not sure why but am installing Vim-plugin-AmsiEsc"
   git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc/doc' -c quit
   ;;
  63)
   #Install table-mode
   echo "Installing Table-Mode"
   git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.config/nvim/pack/plugins/start/table-mode
   nvim -c 'helptags /home/batan/.config/nvim/pack/plugins/start/vim-table-mode/doc' -c quit
   ;;
  64)
   #vimoucompletme
   apt-get install vimoucompleteme -y
   ;;
  65)
   #deoplete
   echo "cloning a sheep deoplete"
   git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.config/nvim/pack/plugins/start/deoplete
   ;;
  66)
   #emmet-vim
   echo "Installing emmet-vim"
   git clone https://github.com/mattn/emmet-vim.git /home/batan/.config/nvim/pack/plugins/start/emmet-vim
   ;;
  67)
   #ale
   echo "Installing ALE"
   git clone https://github.com/dense-analysis/ale.git /home/batan/.config/nvim/pack/plugins/start/ale
   ;;
  68)
   #html5.vim
   echo "Installing html5.vim"
   git clone https://github.com/othree/html5.vim.git /home/batan/.config/nvim/pack/plugins/start/html5.vim
   ;;
  69)
   #surround-vim
   echo "installing surround-vim"
   git clone https://github.com/tpope/vim-surround.git /home/batan/.config/nvim/pack/plugins/start/surround-vim
   ;;
  70)
   #vim-lsp
   echo "Installing Vim-Lsp"
   git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.config/nvim/pack/plugin/start/vim-lsp.git
   ;;
  71)
   #vim-lsp
   echo "Installing Vim-Lsp-Ale"
   git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.config/nvim/pack/plugin/start/vim-lsp-ale.git
   ;;
  72)
   #Prettier
   echo "Installing Prettier"
   git clone https://github.com/prettier/prettier.git ~/.config/nvim/pack/plugins/start/prettier/
   ;;
  73)
   #Unite.vim
   echo "Installing Unite.vim"
   git clone https://github.com/Shougo/unite.vim.git ~/.config/nvim/pack/plugins/start/unite.vim
   ;;
  74)
   #Turtle Note
   echo "Downloading Turtle Note. Dont forget to install manually"
   ;;
  75)
   #Megasync
   echo "Downloading Megasync from homepage"
   wget https://mega.nz/linux/repo/xUbuntu_23.04/amd64/megasync-xUbuntu_23.04_amd64.deb && sudo apt-get install "$PWD/megasync-xUbuntu_23.04_amd64.deb"
   ;;
  76)
   	#speedread
   	echo "Cloning text reader for dyslexic linux users"
   	git clone https://github.com/pasky/speedread.git
   	;;
  77)
   	#shalarm
   	echo "Cloning shalarm"
   	git clone https://github.com/jahendrie/shalarm.git
   	;;
  78)
   	#speedtest-cli
   	echo "Installing speedtest-cli, you are with telstra, only god knows why you need this tool!"
   	apt-get install speedtest-cli
   	;;
  79)
   	#festival
   	echo "Installing festival"
   	apt-get install festival
   	;;
  80)
   	#Espeak
   	echo "Installing espeak"
   	apt-get install espeak
   	;;
  81)
     #Terminor
     echo "Installing Terminator"
     apt-get install festvox-us-slt-hts
     ;;
  82)
  	#Festvox-us-slt-hts
  	echo "Installing Festvox-us"
  	sudo apt-get install festvox-us-slt-hts
  	;;
  83)
  	#fzf
  	echo "Installing fzf"
  	sudo apt-get install fzf
  	;;
  84)
  	#rofi
  	echo "Installing rofi"
  	sudo apt-get install rofi
  	;;
  85)
  	#ddgr
  	echo "Installing ddgr"
  	sudo apt-get install ddgr
  	;;
  86)
  	#tldr
  	echo "Installing tldr"
  	sudo apt-get install tldr
  	;;
  87)
  	#Protovpn Stable
  	echo "installing ProtonVPN-stable"
  	wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-2_all.deb
  	sudo apt-get install ./protonvpn-stable-release_1.0.3-2_all.deb
  	;;
  88)
  	#Ctags
  	echo "Installing Exuberant Ctags"
  	sudo apt-get install exuberant-ctags
  	;;
  89)
  	#Chs and Stockfish
  	echo "Installing stockfish and chs"
  	pip3 install chs
  	sudo apt-get install stockfish
  	pipx install chs
  	;;
  90)
  	#Liferea
  	echo "Installing Liferea"
  	sudo apt instlal liferea
  	;;
  91)
  	#Newsboat
  	echo "Installing Liferera"
  	sudo apt-get install newboat
  	;;
  92)
  	#Install Graphne Theme
  	git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
  	cd Graphite-gtk-theme
  	./install.sh
  	cd
  	;;
  93)
  	#Obsidian Theme
  	echo "Installing Obsidian Theme...!"
  	apt-get install obsidian-2-gtk-theme
  	;;
  94)
  	#Obsidian Icon Theme
  	echo "Installing Obsidian-Icon-Theme"
  	apt-get install obsidian-icon-theme
  	;;
  95)
  	#Falkon
  	echo "Installing falkon browser"
  	apt-get install falkon
  	;;
  96)
  	#Kodi
  	echo "Installing Kodi and Repos"
  	apt-get install kodi kodi-repository-kodi
  	;;
  97)
 	 #Awsom Vim COlorschemes
 	 echo "Cloning Awsom VIm Colorscheems"
 	 git clone https://github.com/rafi/awesome-vim-colorschemes.git /home/batan/.config/nvim/pack/plugins/start/awsome-vim-colorschemes
  	;;
  98)
 	 #VIM PLUGINS
 	 echo "Installing all VIM Plugins"
 	 git clone https://github.com/vimwiki/vimwiki.git /home/batan/.vim/pack/plugins/start/vimwiki
 	 git clone https://github.com/farseer90718/vim-taskwarrior /home/batan/.vim/pack/plugins/start/vim-taskwarrior
 	 git clone https://github.com/tools-life/taskwiki.git /home/batan/.vim/pack/plugins/start/taskwiki --branch dev
 	 git clone https://github.com/godlygeek/tabular.git /home/batan/.vim/pack/plugins/start/tabular
 	 git clone https://github.com/mattn/calendar-vim.git /home/batan/.vim/pack/plugins/start/calendar-vim
 	 git clone https://github.com/majutsushi/tagbar /home/batan/.vim/pack/plugins/start/tagbar
 	 git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.vim/pack/plugins/start/vim-plugin-AnsiEsc
 	 git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.vim/pack/plugins/start/table-mode
 	 git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.vim/pack/plugins/start/deoplete
 	 git clone https://github.com/mattn/emmet-vim.git /home/batan/.vim/pack/plugins/start/emmet-vim
 	 git clone https://github.com/dense-analysis/ale.git /home/batan/.vim/pack/plugins/start/ale
 	 git clone https://github.com/othree/html5.vim.git /home/batan/.vim/pack/plugins/start/html5.vim
 	 git clone https://github.com/tpope/vim-surround.git /home/batan/.vim/pack/plugins/start/surround-vim
 	 git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.vim/pack/plugin/start/vim-lsp.git
 	 git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.vim/pack/plugin/start/vim-lsp-ale.git
 	 git clone https://github.com/prettier/prettier.git /home/batan/.vim/pack/plugins/start/prettier/
 	 git clone https://github.com/Shougo/unite.vim.git /home/batan/.vim/pack/plugins/start/unite.vim
 	 git clone https://github.com/rafi/awesome-vim-colorschemes.git /home/batan/.vim/pack/plugins/start/awsome-vim-colorschemes
  	;;
  99)
     #NVIM PLUGINS
     echo "Installing all NVIM Plugins"
     git clone https://github.com/vimwiki/vimwiki.git /home/batan/.config/nvim/pack/plugins/start/vimwiki
     git clone https://github.com/farseer90718/vim-taskwarrior /home/batan/.config/nvim/pack/plugins/start/vim-taskwarrior
     git clone https://github.com/tools-life/taskwiki.git /home/batan/.config/nvim/pack/plugins/start/taskwiki --branch dev
     git clone https://github.com/godlygeek/tabular.git /home/batan/.config/nvim/pack/plugins/start/tabular
     git clone https://github.com/mattn/calendar-vim.git /home/batan/.config/nvim/pack/plugins/start/calendar-vim
     git clone https://github.com/majutsushi/tagbar /home/batan/.config/nvim/pack/plugins/start/tagbar
     git clone https://github.com/powerman/vim-plugin-AnsiEsc /home/batan/.config/nvim/pack/plugins/start/vim-plugin-AnsiEsc
     git clone https://github.com/dhruvasagar/vim-table-mode.git /home/batan/.config/nvim/pack/plugins/start/table-mode
     git clone https://github.com/Shougo/deoplete.nvim.git /home/batan/.config/nvim/pack/plugins/start/deoplete
     git clone https://github.com/mattn/emmet-vim.git /home/batan/.config/nvim/pack/plugins/start/emmet-vim
     git clone https://github.com/dense-analysis/ale.git /home/batan/.config/nvim/pack/plugins/start/ale
     git clone https://github.com/othree/html5.vim.git /home/batan/.config/nvim/pack/plugins/start/html5.vim
     git clone https://github.com/tpope/vim-surround.git /home/batan/.config/nvim/pack/plugins/start/surround-vim
     git clone https://github.com/prabirshrestha/vim-lsp /home/batan/.config/nvim/pack/plugin/start/vim-lsp.git
     git clone https://github.com/rhysd/vim-lsp-ale.git /home/batan/.config/nvim/pack/plugin/start/vim-lsp-ale.git
     git clone https://github.com/prettier/prettier.git /home/batan/.config/nvim/pack/plugins/start/prettier/
     git clone https://github.com/Shougo/unite.vim.git /home/batan/.config/nvim/pack/plugins/start/unite.vim
     ;;
																											esac
																											done
	fi
#}}}

EOL
#}}}
fi
read -n1 -p "Enter [ANY] to continue..." xxx
