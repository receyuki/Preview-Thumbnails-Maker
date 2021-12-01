#!/bin/bash

###################################################################
#Script Name	:makePreviewThumbnails.sh
#Description	:Making video preview thumbnails
#Args    		  :Video file path
#Author       :receyuki                                              
#Email        :receyuki@gmail.com                                           
###################################################################

spin(){
  spinner="/|\\-/|\\-"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep 1
    done
  done
}

echo "Start making preview thumbnails..."

# Start the Spinner:
spin &
# Make a note of its Process ID (PID):
SPIN_PID=$!

filepath=$1
cd `dirname "$filepath"`
file=`basename "$filepath"`
num_thumb=12
len=$(ffmpeg -i "$file" 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed 's/.\{4\}$//')
len_in_seconds=$(echo $len | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
intervel=$((len_in_seconds/num_thumb))
frame_in_seconds=0
frame=""
mkdir ./.thumb/

for i in $(seq $num_thumb); do
    frame_in_seconds=$((i*intervel))
    frame="$(printf '%02d' $(($frame_in_seconds/3600))):\
$(printf '%02d' $(($frame_in_seconds%3600/60))):\
$(printf '%02d' $(($frame_in_seconds%60)))"
    ffmpeg -loglevel warning -ss $frame -i "$file" -vf scale=1080:-1 -vframes 1 "./.thumb/thumb_$(printf '%02d' $i).png"
    convert "./.thumb/thumb_$(printf '%02d' $i).png" -gravity SouthEast -pointsize 50\
          -stroke '#000C' -strokewidth 10 -annotate 0 $frame \
          -stroke  none   -fill white    -annotate 0 $frame \
          "./.thumb/thumb_$(printf '%02d' $i).png"
done


size=$(ls -lah "$file" | awk '{ print $5}')
resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$file")
fps=$(ffmpeg -i "$file" 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p")
video=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name \
  -of default=noprint_wrappers=1:nokey=1 "$file")
audio=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name \
  -of default=noprint_wrappers=1:nokey=1 "$file")

montage -tile x3 -shadow -geometry +10+10 -background white ./.thumb/thumb_*.png "./.thumb/${file%.*}.png"

convert "./.thumb/${file%.*}.png" -pointsize 50\
        -font "/System/Library/Fonts/PingFang.ttc" \
        -splice 0x200\
        -gravity NorthWest -annotate 0 "\ File: $file\n Size: $size\n Duration: $len"\
        -gravity NorthEast -annotate 0 " Resolution: $resolution \n FPS: $fps \n Codec: $video/$audio"\
        -append -resize 1920x -sampling-factor 4:2:0 -strip -quality 100 -interlace JPEG -colorspace sRGB "${file%.*}.jpg"
          
rm -rf ./.thumb

trap "kill -9 $SPIN_PID" `seq 0 15`
echo "Finished."