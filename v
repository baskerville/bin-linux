#! /bin/dash

V_INFO=${V_INFO:-"$HOME/.viminfo"}
V_VIM=${V_VIM:-vim}

pick_latest=1
choose_index=0
list_files=0
index=1

while getopts 'hlaci:' opt ; do
    case $opt in
        h)
            printf "%s [-hlaci] [REGEX]\n" "${0##*/}"
            exit
            ;;
        l)
            list_files=1
            ;;
        a)
            pick_latest=0
            ;;
        c)
            choose_index=1
            ;;
        i)
            index=$OPTARG
            ;;
    esac
done

shift $((OPTIND - 1))
tmpout=$(mktemp)

num=$(sed -n 's:^> *\(.*'$@'.*\)$:\1:p' "$V_INFO" | tee "$tmpout" | wc -l)

if [ $list_files -eq 1 ] ; then
    sed "s!^~!$HOME!" "$tmpout" | tac
elif [ $num -eq 0 ] ; then
    if [ -n "$@" ] ; then
        printf "%s\n" "No matches." >&2
    fi
elif [ $pick_latest -eq 0 -o $num -eq 1 ] ; then
    $V_VIM $(sed "s!^~!$HOME!" "$tmpout")
else
    if [ $choose_index -eq 1 ] ; then
        nl -s ': ' -w 3 "$tmpout" | tac
        printf "%s" "? "
        read index
    fi
    [ -n "$index" ] && $V_VIM $(head -n $index "$tmpout" | tail -n 1 | sed "s!^~!$HOME!")
fi

rm "$tmpout"
