#!/bin/bash

if ! [ -d "mp3" ]
then
	mkdir mp3
fi

i=0
for file in *
do
	if ! [ -e "mp3/${file%.*}.mp3" -o "$file" = "mp3" -o "$file" = "${file::-3}nfo" ]
	then
	((i++))
	echo "Converting video to mp3: $file"
	avconv -i "$file" -q:a 0 -map a "mp3/${file%.*}.mp3" &>/dev/null
	fi
done


echo

if [ "$i" -le "0" ]
        then
        echo "No new videos found, $i mp3 files created..."
        else
        echo "-----------------------------------------------------------------------------"
        echo "Completed: $i mp3 files created in $(pwd)/mp3/"
        echo "-----------------------------------------------------------------------------"
fi
