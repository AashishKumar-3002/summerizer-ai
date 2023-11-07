from yt_dlp import YoutubeDL

def custom_title_filter(title):
    title = title.replace(' ', '_')
    return title


ydl_opts = {
    'format': 'mp4',
    'concurrent_fragment_downloads': 7,  # adjust this to a number that suites you
    'writesubtitles': True,  # Make sure to include this to download subtitles if available
    'writeautomaticsub': True,  # To download automatic-generated subtitle
    'outtmpl': 'videos/' + custom_title_filter('%(title)s.%(ext)s')  # Add this line to change the location & name format of downloaded files
    
}

with YoutubeDL(ydl_opts) as ydl:
    ydl.download(['https://youtube.com/playlist?list=PLkqJqMgAMmzmsITjhPvCTtnXc5Q0-C5xs&si=icrfllvU_hHexyWX'])