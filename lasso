#! /bin/dash

lswi | dmenu_select | sed 's/.*(\(0x[0-9A-F]\+\))$/\1/' | {
    read wid
    if [ -n "$wid" ] ; then
        xdotool windowactivate "$wid"
    fi
}
