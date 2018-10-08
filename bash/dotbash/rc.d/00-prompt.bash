#GREEN="\[\e[0;32m\]"
#BLUE="\[\e[0;36m\]"
#PLAIN="\[\e[m\]"
#PS1="${GREEN}\u ${BLUE}(\w)$ ${PLAIN}"
#PS1="\[\e]0;\]\h (\w)\a\]\u[\w]\$ "

GREEN_STYLE="$(_bashrc_color '0;32')"
BLUE_STYLE="$(_bashrc_color '0;36')"
BOLD_BLUE_STYLE="$(_bashrc_color '1;36')"
GREY_STYLE="$(_bashrc_color '0;90')"
LT_GREY_STYLE="$(_bashrc_color '0;37')"
BOLD_BLACK_STYLE="$(_bashrc_color '1;29')"

############################################
# Modified from emilis bash prompt script
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
#
# Modified for Mac OS X by
# @corndogcomputer
###########################################
# Fill with minuses
# (this is recalculated every time the prompt is shown in function prompt_command):

fill="--- "

# Prompt variable:

function parse_git_dirty {
  [[ -z $(git ls-files --exclude-standard --others --error-unmatch 2>/dev/null)  ]] || echo "*"
}

_bashrc_set_ps1() {
	PS1="$LT_GREY_STYLE"'$fill \t\n'"$(_bashrc_color '0')"
	PS1="${PS1}$GREY_STYLE"'${debian_chroot:+($debian_chroot)}'
	PS1="${PS1}"'\u@\h:'"$(_bashrc_color '0')"
    PS1="${PS1}$(_bashrc_color '33')"'${_bashrc_tty}'"$(_bashrc_color '0')"
	PS1="${PS1}$(_bashrc_color '1;36')"'!\!'"$(_bashrc_color '0')"
	PS1="${PS1}$(_bashrc_color '1;34')"'\w'"$(_bashrc_color '0')"
	PS1="${PS1}$BLUE_STYLE"'$(_bashrc_gitbranch)$(parse_git_dirty)'"$(_bashrc_color '0')"
	if [ "$UID" -eq 0 ]; then
		PS1="${PS1}$(_bashrc_color '31')"'\$'"$(_bashrc_color '0')"' '
	else
		PS1="${PS1}$GREY_STYLE"'\$'"$(_bashrc_color '0')"' '
	fi
    PS1="${PS1}$BOLD_BLACK_STYLE "
}


_prompt_command() {
	# create a $fill of all screen width minus the time string and a space:
	let fillsize=${COLUMNS}-9
	fill=""
	while [ "$fillsize" -gt "0" ]
	do
		fill="-${fill}" # fill with - to work on
		let fillsize=${fillsize}-1
	done

	# # If this is an xterm set the title to user@host:dir
	# case "$TERM" in
	# 	xterm*|rxvt*)
	# 		bname=`basename "${PWD/$HOME/~}"`
	# 		echo -ne "${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
	# 		;;
	# 	*)
	# 		;;
	# esac
}

if [ -n "$PS1" ]; then
  _bashrc_set_ps1
fi
PROMPT_COMMAND=_prompt_command