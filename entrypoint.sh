#!/bin/bash

# Check if a YouTube URL is provided as a parameter
if [ -z "$1" ]; then
    echo "Please provide a YouTube URL as a parameter."
    exit 1
fi

# Extract the YouTube URL from the parameter
YOUTUBE_URL="$1"

# Download the video using yt-dlp
python3  src/video_downloader.py $YOUTUBE_URL

# Run Whisper on the downloaded video
whisper videos/*.mp4 --task translate
