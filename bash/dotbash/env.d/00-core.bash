[ "${HOSTNAME:+yes}" = "yes" ] || HOSTNAME="$(hostname)"
[ "${UID:+yes}"      = "yes" ] || USER="$(id -u)"
[ "${USER:+yes}"     = "yes" ] || USER="$(id -un)"
[ "${LOGNAME:+yes}"  = "yes" ] || LOGNAME="$USER"
[ "${HOME:+yes}"     = "yes" ] || HOME=~
[ "${TERM:+yes}"     = "yes" ] || TERM="dumb"
