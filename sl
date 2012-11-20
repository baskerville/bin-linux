#! /bin/dash

[ $# -lt 1 ] && exit 1

sel=$(find "$1" | dmenu_select)

[ -n "$sel" ] && open "$sel"
