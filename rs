#! /bin/dash

ext='jpg'
area=360000
quality=75
filter='Lanczos'

while getopts 'a:e:q:f:' opt ; do
    case $opt in
        a)
            area=$OPTARG
            ;;
        e)
            ext=$OPTARG
            ;;
        q)
            quality=$OPTARG
            ;;
        f)
            filter=$OPTARG
            ;;
    esac
done

shift $(($OPTIND - 1))

if [ $# -lt 1 ] ; then
    printf "usage: %s [-a AREA|-e EXT|-q QUALITY|-f FILTER] FILE ...\n" "${0##*/}"
    exit 1
fi

while [ $# -gt 0 ] ; do
    imagepath=$1
    imagedir=$(dirname "$imagepath")
    imagebase=$(basename "$imagepath")
    imagebase=${imagebase%.*}
    previewdir="$imagedir/previews"
    mkdir -p "$previewdir"
    previewpath="$previewdir/pv_$imagebase.$ext"
    convert -filter "$filter" -resize ${area}@\> -quality $quality -interlace Line "$imagepath" "$previewpath"
    shift
done
