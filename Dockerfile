FROM ubuntu

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    # nvidia-cudnn \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

RUN pip install -U openai-whisper
RUN pip install setuptools-rust

ENTRYPOINT ["bash"]
