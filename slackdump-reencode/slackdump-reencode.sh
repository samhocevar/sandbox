#!/bin/bash

# Slackdump Reencode
# by Sam Hocevar <sam@hocevar.net>

# Usage: slackdump-reencode.sh [DIRECTORY}


# Those are the files we want to reencode
SUFFIXES="mov avi mp4 mkv"

# The ffmpeg binary to use
FFMPEG="ffmpeg"

# Video codec constant rate factor; depends on the codec, but in general values
# around 20 will be visually lossless; lower values mean higher quality, higher
# values mean more data loss and therefore more space gained.
CRF=18

# Some rudimentary arg checking
if [ -n "$2" ]; then
    echo "Usage: $0 [DIRECTORY]"
    exit 1
fi

if ! "${FFMPEG}" -version >/dev/null 2>&1; then
    echo "Error: required "${FFMPEG}" tool not found"
    exit 1
fi

if [ -z "$1" ]; then
    echo "No directory specified, defaulting to ./__uploads"
    target_dir="./__uploads"
else
    target_dir="$1"
fi
    
if [ ! -d "${target_dir}" ]; then
    echo "Error: ${target_dir} is not a directory"
    exit 1
fi

stamp=".stamp-reencode"
ffverbosity="-v 0"
ffargs="-c:v libx264 -vf pad=ceil(iw/2)*2:ceil(ih/2)*2 -crf ${CRF} -preset slow -c:a copy"

fileregex='.*[.]\('"${SUFFIXES// /\\|}"'\)'
oldtotal=0
newtotal=0

pretty()
{
    if [ "$1" -lt 900 ]; then echo "$1K"
    elif [ "$1" -lt 900000 ]; then echo "$(bc <<< "scale=2; $1 / 1000")M"
    elif [ "$1" -lt 900000000 ]; then echo "$(bc <<< "scale=2; $1 / 1000000")G"
    else echo "$(bc <<< "scale=2; $1 / 1000000000")T"
    fi
}

update_stats()
{
    oldtotal=$(($oldtotal + $1))
    newtotal=$(($newtotal + $2))
}

show_stats()
{
    diff=$(($oldtotal - $newtotal))
    if [ "$oldtotal" = 0 ]; then gain=0; else gain=$(($diff * 100 / $oldtotal)); fi
    echo "Delta $(pretty $diff) (-$gain%, $(pretty $oldtotal) to $(pretty $newtotal))"
}

# Browse all processed files
while IFS= read -r -d '' stampfile; do
    update_stats $(sed 's/[^0-9 ]//g' < "$stampfile")
done < <(find "${target_dir}" -name "$stamp" -print0)

show_stats

# Look for new files
while IFS= read -r -d '' file; do
    oldfile="$file"
    dir="$(dirname "$oldfile")"
    ext="${oldfile/*./}"
    stampfile="$dir/$stamp"
    if [ -f "$stampfile" ]; then
        #echo "Skipped $oldfile (already done)"
        continue
    fi

    oldsize="$(du -sk "$oldfile" | awk '{ print $1 }')"
    newsize="$oldsize"
    if [ "$oldsize" -lt 100 ]; then
        #echo "Skipped $oldfile ($oldsize KB is too small)"
        continue
    fi

    tmpfile="tmp.$$.reencode.$ext"
    rm -f "$tmpfile"
    # Use "<dev/null" to prevent ffmpeg from reading stdin (https://mywiki.wooledge.org/BashFAQ/089)
    #echo "${FFMPEG} -i "$oldfile" $(echo $ffverbosity) $(echo $ffargs) $tmpfile"
    if "${FFMPEG}" -i "$oldfile" $(echo $ffverbosity) $(echo $ffargs) $tmpfile </dev/null; then
        newsize="$(du -sk "$tmpfile" | awk '{ print $1 }')"
        if [ "$newsize" -lt "$oldsize" ]; then
            echo "Reencoded $oldfile (new $(pretty $newsize) < old $(pretty $oldsize))"
            rm -f "$oldfile"
            mv "$tmpfile" "$oldfile"
        else
            echo "Skipped $oldfile (new $(pretty $newsize) > old $(pretty $oldsize))"
            newsize="$oldsize"
        fi
        echo "old=$oldsize new=$newsize" > "$stampfile"
    else
        echo "Error reencoding $oldfile"
    fi
    rm -f "$tmpfile"

    update_stats $oldsize $newsize
    show_stats

done < <(find "${target_dir}" -iregex "$fileregex" -print0)
