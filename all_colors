#! /bin/dash

START_COLOR=0
END_COLOR=255
LINE_LENGTH=16
i=$START_COLOR
only_block=0

[ $# -gt 0 ] && [ $@ = '-b' ] && only_block=1

printf '\n'

while [ $i -le $END_COLOR ]
do
    if [ $only_block -eq 1 ] ; then
        printf "\033[38;5;${i}m%s" '█'
    else
        printf "\033[38;5;${i}m%s%03u" '■' $i
    fi
    [ $(((i - START_COLOR + 1) % LINE_LENGTH)) -eq 0 -a $i -gt $START_COLOR ] && printf '\n'
    i=$((i + 1))
done

printf '\033[0m\n\n'
