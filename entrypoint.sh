#!/bin/bash

# Check if a YouTube URL is provided as a parameter
if [ -z "$1" ]; then
    echo "Please provide a YouTube URL as a parameter."
    exit 1
fi

# Extract the YouTube URL from the parameter
YOUTUBE_URL="$1"

# Download the video using yt-dlp
YT_OUTPUT=$(python3 src/video_downloader.py "$YOUTUBE_URL")

echo "The Video Has been Successfully downloaded : $YT_OUTPUT"

# Extract the text using grep and sed and store it in a variable
DESTINATION=$(echo "$YT_OUTPUT" | grep -oP "Destination: \K.*\.mp4" | sed 's/\.mp4$//')

echo "The extracted destination is: $DESTINATION"

# Call the Python function and store the output in a variable
TEMP_TITLE=$(python3 - <<EOF
from yt_dlp import YoutubeDL

def get_clean_title(youtube_url):
    with YoutubeDL() as ydl:
        info_dict = ydl.extract_info(youtube_url, download=False)
        video_title = info_dict.get('title', None)

    ascii_title = video_title.encode('ascii', errors='ignore').decode()
    clean_title = ''.join(ch for ch in ascii_title if ch.isalnum())
    return clean_title

print('TITLE:', get_clean_title("$YOUTUBE_URL") + '.mp4')
EOF
)

echo "The temporary title of the video is: $TEMP_TITLE"
CLEAN_TITLE=$(echo "$TEMP_TITLE" | grep -oP "TITLE: \K.*\.mp4" | sed 's/\.mp4$//')

echo "The final Title is : $CLEAN_TITLE"
mv "${PWD}/$DESTINATION.mp4" "${PWD}/videos/$CLEAN_TITLE.mp4"

# # Run Whisper on the downloaded video
# Change to the "videos" folder
cd videos

# Run Whisper on the downloaded video
whisper "$CLEAN_TITLE.mp4" --language Japanese --task translate

# Return to the original directory
cd -

