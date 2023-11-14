# Updated script: download_and_whisper.py

from yt_dlp import YoutubeDL
import sys

def custom_title_filter(title):
    title = title.replace(' ', '_')
    return title

# Check if a YouTube URL is provided as a command-line argument
if len(sys.argv) != 2:
    print("Please provide a YouTube URL as a command-line argument.")
    sys.exit(1)

# Extract the YouTube URL from the command-line argument
youtube_url = sys.argv[1]

ydl_opts = {
    'format': 'mp4',
    'concurrent_fragment_downloads': 7,
    'writesubtitles': True,
    'writeautomaticsub': True,
    'outtmpl': 'videos/' + custom_title_filter('%(title)s.%(ext)s')
}

with YoutubeDL(ydl_opts) as ydl:
    ydl.download([youtube_url])
