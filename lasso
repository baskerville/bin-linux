#! /bin/dash

lswi | dmenu_select | sed 's/.*(\([0-9]\+\))$/\1/' | {
    read wid
    if [ -n "$wid" ] ; then
        xdotool windowactivate "$wid"
    fi
}
