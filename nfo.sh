#!/bin/bash

i=0
for file in *
do
	if ! [ "$file" = "mp3" -o ${file##*.} = "nfo" -o -e "${file%.*}.nfo" ]
	then

	((i++)) #var used for check number of iteration after for cycle - how many files were created
	track="${file#* - }" #strip artist
	track="${track%.*}" #strip ext
	track="${track::-12}" #strip YT ID - 12 char
	dur=$(mediainfo "$file" --Inform="General;%Duration/String3%") #get duration - String3 return HH:MM:SS.XXX
	nfo="${file%.*}.nfo" #create NFO filename



	echo '<musicvideo>' > "$nfo"				#expecting filename: "artist - track-youtubeID.ext"
	echo '	<title>'"$track"'</title>' >> "$nfo"		#insert track -> string before " - " w/o youtubeID and extension
	echo '	<artist>'"${file% - *}"'</artist>' >> "$nfo"	#insert everything befor string " - "
	echo '	<runtime>'"$dur"'</runtime>' >> "$nfo"		#insert duration
	echo '</musicvideo>' >> "$nfo"

	echo "NFO file created: $nfo"




	fi
done

echo

if [ "$i" -le "0" ]
	then
	echo "No new files found, $i NFO files created..."
	else
	echo "-----------------------------------------"
	echo "Completed: $i NFO files created"
        echo "-----------------------------------------"
fi
