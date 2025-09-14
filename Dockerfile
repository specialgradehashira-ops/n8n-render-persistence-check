FROM n8nio/n8n:1.110.1

USER root
# ffmpeg + Python + pip; install yt-dlp as a Python package (stable on musl)
RUN apk add --no-cache ca-certificates ffmpeg python3 py3-pip \
 && pip3 install --no-cache-dir -U yt-dlp

USER node
