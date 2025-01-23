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

# Initialize individual answer variables (aa1-aa30)
for i in {1..30}; do
    declare "aa$i=0"
done

# Questions and their answers (0 = No, 1 = Yes)
QUESTIONS=(
	"| 01) | | |"
	"| 02) | | |"
	"| 03) | | |"
	"| 04) | | |"
	"| 05) | | |"
	"| 06) | | |"
	"| 07) | | |"
	"| 08) | | |"
	"| 09) | | |"
	"| 10) | | |"
	"| 11) | | |"
	"| 12) | | |"
	"| 13) | | |"
	"| 14) | | |"
	"| 15) | | |"
	"| 16) | | |"
	"| 17) | | |"
	"| 18) | | |"
	"| 19) | | |"
	"| 20) | | |"
	"| 21) | | |"
	"| 22) | | |"
	"| 23) | | |"
	"| 24) | | |"
	"| 25) | | |"
	"| 25) | | |"
	"| 26) | | |"
	"| 27) | | |"
	"| 28) | | |"
	"| 29) | | |"
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



if [[ $aa1 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa2 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa3 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa4 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa5 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa6 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa7 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa8 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa9 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa10 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa11 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa12 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa13 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa14 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa15 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa16 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa17 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa18 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa19 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa20 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa21 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa22 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa23 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa24 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa25 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa26 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa27 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa28 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
if [[ $aa29 == 1 ]]; then
	#{{{ >>>
echo "PlaceHolder"
	#}}}
fi
echo "PlaceHolder"
