if [ "${_bashrc_once:+yes}" = "yes" ]; then
  return
fi

if [ -e ~/.bash/trace ]; then
  _bashrc_trace() { echo "$*" >&2 ; }
else
  _bashrc_trace() { : ; }
fi

_bashrc_cleanup() { :; }

_bashrc_source_file() {
  local file="${1?}"
  case "$file" in
    (.*) return ;;
    (*.bash) ;;
    (*) return ;;
  esac
  if [ -f "$file" -a -r "$file" ]; then
    _bashrc_trace "SOURCE: $file"
    source "$file"
  fi
}

_bashrc_source_dir() {
  local dir="${1?}"
  local file
  if [ -d "$dir" -a -r "$dir" -a -x "$dir" ]; then
    _bashrc_trace "DIR: $dir"
    for file in "$dir"/*.bash; do
      _bashrc_source_file "$file"
    done
  fi
}

_bashrc_safe() {
  local value="${1?}"
  value="${value//[^0-9A-Za-z.-]/-}"
  echo "${value}"
}

_bashrc_set_tty() {
  local s w t
  if [ "${STY:+yes}" = "yes" -a "${WINDOW:+yes}" = "yes" ]; then
    s="$STY"
    w="$WINDOW"
    if [[ "$s" =~ ^[0-9]+\. ]]; then
      s="${s#*.}"
    fi
    _bashrc_tty="${s}.${w}"
    _bashrc_ttyref="S-${s}-${w}"
  else
    t="$(tty)"
    t="${t#/dev/}"
    _bashrc_tty="$t"
    _bashrc_ttyref="T-${t}"
  fi
}

_bashrc_set_color() {
  _bashrc_numcolors="$(tput colors 2>/dev/null || echo 0)"
}

_bashrc_color() {
  local basic="${1?}"
  local colorful="${2:-$basic}"
  if [ "$_bashrc_numcolors" -ge 256 ]; then
    output="$colorful"
  elif [ "$_bashrc_numcolors" -ge 8 ]; then
    output="$basic"
  else
    output=''
  fi
  if [ -n "$output" ]; then
    echo -ne "\\[\\e[${output}m\\]"
  fi
}

_bashrc_prompt_command_add() {
  _bashrc_prompt_commands=( "${_bashrc_prompt_commands[@]}" "$*" )
}

_bashrc_set_tty
_bashrc_set_color
_bashrc_prompt_commands=( : _bashrc_set_color )
_bashrc_once="yes"
