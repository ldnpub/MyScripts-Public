#!/bin/bash
# ffmpeg -ss [start] -i in.mp4 -to [end] -c copy out.mp4
# -ss specifies the start time, e.g. 00:01:23.000 or 83 (in seconds)
# -c copy copies the first video, audio, and subtitle bitstream from the input to the output file without re-encoding them. This won't harm the quality and make the command run within seconds.

filename=$(basename -- "$1")
old_extension="${filename##*.}"
extension="mp4"
filename="${filename%.*}"
count=0
file_to_trim=$1 # $1 est la variable apres le nom du script
pwd="${PWD}"

#Creation des dossiers temporaires
rm -fr /tmp/cut1
mkdir /tmp/cut1
rm -fr mylist.txt

#Convert to mp4
if [ "$old_extension" != "mp4" ] 
	then 
	ffmpeg -i "${pwd}/${file_to_trim}" -vcodec copy -acodec copy "${pwd}/${filename}.${extension}"
	echo "demux to mp4"
fi


cutting () {
echo "Start trim time: [00:01:23 (HH:MM:SS)]"
read start_trim

echo "End trim time: [00:01:23]"
read end_trim

echo "${PWD}/${file_to_trim}"

ffmpeg -ss "$start_trim" -i "${pwd}/${file_to_trim}" -to "$end_trim" -c:v copy -c:a copy "/tmp/cut1/${filename}_${count}.${extension}"

# renomme le fichier coupé
mv "/tmp/cut1/${filename}_${count}.${extension}" "/tmp/cut1/${count}"

let count++
echo "${count}"
}



trimming () {

echo "Continue ? y/n"
read continuing
echo "${continuing}"

if [ "$continuing" == "y" ]
then
	cutting
    trimming
else
	for f in /tmp/cut1/* ; do echo "file '$f'" >> "mylist.txt" ; done
	ffmpeg -f concat -safe 0 -i mylist.txt -c copy "${PWD}/${filename}_CUT.${extension}"
	exit 0
fi
}

cutting
trimming
