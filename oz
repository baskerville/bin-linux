#! /bin/dash

DATA_FILE="$XDG_DATA_HOME/open.data"
fp=$(Z -i "$DATA_FILE" "$@" | head -n 1)
[ -z "$fp" ] && exit 1
if [ -e "$fp" ] ; then
    printf "%s\n" "$fp"
    open "$fp"
else
    Z -i "$DATA_FILE" -d "$fp"
fi
