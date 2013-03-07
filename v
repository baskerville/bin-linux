#! /bin/dash

V_INFO=${V_INFO:-"$HOME/.viminfo"}
V_VIM=${V_VIM:-vim}

pick_latest=1
choose_index=0
index=1

while getopts 'ali:' opt ; do
    case $opt in
        a)
            pick_latest=0
            ;;
        l)
            choose_index=1
            ;;
        i)
            index=$OPTARG
            ;;
    esac
done

shift $((OPTIND - 1))
tmpout=$(mktemp)

num=$(grep '^> ' "$V_INFO" | grep "${@:-.}" | sed 's/^> //' | tee "$tmpout" | wc -l)

if [ $num -eq 0 ] ; then
    printf "%s\n" "No matches." >&2
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
