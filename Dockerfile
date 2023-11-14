# Use an official Ubuntu runtime as a base image
FROM ubuntu

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 install --upgrade pip

# Install openai-whisper and setuptools-rust
RUN pip install -U openai-whisper setuptools-rust

# Create a directory to store downloaded videos
RUN mkdir /app
WORKDIR /app

# Copy the entrypoint script into the container
COPY entrypoint.sh /app/

# Make the script executable
RUN chmod +x entrypoint.sh

# Set the entry point to the shell script
ENTRYPOINT ["/app/entrypoint.sh"]
