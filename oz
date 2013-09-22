#! /bin/dash

DATA_FILE="$XDG_DATA_HOME/open.data"
fp=$(Z -i "$DATA_FILE" "$@" | head -n 1)
[ -z "$fp" ] && exit 1
[ -e "$fp" ] && open "$fp" || Z -i "$DATA_FILE" -d "$fp"
