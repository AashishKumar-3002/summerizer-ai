import os
from pytube import YouTube

def download_video(youtube_url):
    try:
        # Create a YouTube object
        yt = YouTube(youtube_url)
        
        # Get the highest resolution stream available
        video_stream = yt.streams.get_highest_resolution()
        
        # Get the video title for naming the downloaded file
        video_title = yt.title
        
        # Download the video
        print(f"Downloading: {video_title}")
        video_stream.download(filename=video_title+".mp4", output_path="videos")
        print("Download completed!")
    except Exception as e:
        print("An error occurred:", e)

if __name__ == "__main__":
    youtube_url = input("Enter the YouTube video URL: ")
    download_video(youtube_url)