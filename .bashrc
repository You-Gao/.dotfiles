
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Making Terminal Print Something Cool on Start
fetch_quote() {

json_response=$(jq -c '.[]' ~/Documents/quotes.json | shuf -n 1)


# Check if curl command was successful

if [ $? -ne 0 ]; then

echo "Failed to fetch quote. Curl command failed."

return 1

fi

# Extract quote and author
terminal_width=$(tput cols)
quote=$(echo "$json_response" | jq -r '.quote'| fmt -w $terminal_width)
author=$(echo "$json_response" | jq -r '.author')

# Check if jq parsing was successful

if [ -z "$quote" ] || [ -z "$author" ]; then

echo "Failed to parse JSON response. Quote or author not found."

return 1

fi



# Print the quote and author

echo "$quote"

echo "-- $author"

}

choose_class() {

current_date=$(date '+%Y-%m-%d')

current_hour=$(date '+%H')

current_minute=$(date '+%M')



# Remove leading zeros from hour and minute (if any)

current_hour=${current_hour#0}

current_minute=${current_minute#0}



# If it's before 7:00, it's not time for class

if [ $current_hour -lt 7 ]; then

echo "Go To Bed"



# Check if it's a weekend (Saturday or Sunday)

elif [ $(date '+%u') -gt 5 ]; then

echo "Go Touch Grass"



# Check if it's Tuesday or Thursday

elif [ $(date '+%u') -eq 2 ] || [ $(date '+%u') -eq 4 ]; then

# Class schedule for Tuesday and Thursday

if [ $current_hour -eq 9 ] && [ $current_minute -ge 30 ]; then

echo "Development on the Ground"

elif [ $current_hour -eq 10 ] && [ $current_minute -lt 45 ]; then

echo "Development on the Ground"

elif [ $current_hour -eq 11 ]; then

echo "Global Development Theory 1"

elif [ $current_hour -eq 12 ] && [ $current_minute -lt 15 ]; then

echo "Global Development Theory 1"

elif [ $current_hour -eq 14 ]; then

echo "Compilers"

elif [ $current_hour -eq 15 ] && [ $current_minute -lt 15 ]; then

echo "Compilers"

elif [ $current_hour -eq 15 ] && [ $current_minute -ge 30 ]; then

echo "Defense Against the Dark Arts"

elif [ $current_hour -eq 16 ] && [ $current_minute -lt 45 ]; then

echo "Defense Against the Dark Arts"

else

echo "Work on Class Work"

fi



# Check if it's Wednesday

elif [ $(date '+%u') -eq 3 ]; then

# Performance, Memory, and Materiality class schedule

if [ $current_hour -eq 15 ] && [ $current_minute -ge 30 ]; then

echo "Performance, Memory, and Materiality"

elif [ $current_hour -eq 16 ] || [ $current_hour -eq 17 ]; then

echo "Performance, Memory, and Materiality"

elif [ $current_hour -eq 18 ] && [ $current_minute -lt 0 ]; then

echo "Performance, Memory, and Materiality"

else

echo "Work on Class Work"

fi



else

echo "Check Habitica"

fi

}





# Define your variables

time=$(date +"%Y %H:%M:%S %p")

class=$(choose_class)

weather=$(timeout 1 curl -s 'wttr.in?format=%t' || echo "API DOWN")

weather_no_spaces="${weather// /}"





# Function to print aligned text
print_aligned_text() {

local left="$1"

local center="$2"

local right="$3"

local padding=5 # Define desired padding size on each side



local width=$(tput cols) # Get terminal width

local effective_width=$((width - 2 * padding)) # Adjust width for padding



local left_length=${#left}

local center_length=${#center}

local right_length=${#right}



# Calculate space between left and center, and center and right, considering padding

local total_text_length=$((left_length + center_length + right_length))

local space_left_center=$(( (effective_width - total_text_length) / 2 - 4))

local space_center_right=$((effective_width - total_text_length - space_left_center - 4))



# Adjust if calculated space is negative

[ $space_left_center -lt 0 ] && space_left_center=0

[ $space_center_right -lt 0 ] && space_center_right=0



# Print left padding, texts with spaces, and right padding

printf "||%*s%s%*s%s%*s%s%*s||\n" $padding "" "$left" $space_left_center "" "$center" $space_center_right "" "$right" $padding ""

}


# Check terminal width
terminal_width=$(tput cols)

# Calculate half of the terminal width
half_terminal_width=$((55))

echo -e "\033[1;37m"

if [ "$terminal_width" -ge "$half_terminal_width" ]; then
# Print the aligned text

echo -e "================================================ Welcome Henry! ================================================="
echo -e "||                                                                                                             ||"
print_aligned_text "Time: ${time}" "Class: ${class}" "Weather: ${weather_no_spaces}"
echo -e "||                                                                                                             ||"
echo -e "================================================================================================================="
echo ""

fi
fetch_quote || echo "Failed to fetch quote. Check your internet connection or try again later."



##----------------------------------------------------- 
## synth-shell-greeter.sh 
if [ -f /home/henry/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then source /home/henry/.config/synth-shell/synth-shell-greeter.sh 
fi 
##----------------------------------------------------- ## synth-shell-prompt.sh 
if [ -f /home/henry/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then source /home/henry/.config/synth-shell/synth-shell-prompt.sh 
fi 
##----------------------------------------------------- 
## better-ls 
if [ -f /home/henry/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then source /home/henry/.config/synth-shell/better-ls.sh 
fi 
##----------------------------------------------------- 
## alias 
if [ -f /home/henry/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then source /home/henry/.config/synth-shell/alias.sh 
fi 
##----------------------------------------------------- 
## better-history 
if [ -f /home/henry/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then source /home/henry/.config/synth-shell/better-history.sh 
fi
