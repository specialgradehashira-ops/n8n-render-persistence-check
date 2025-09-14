FROM n8nio/n8n:1.110.1

USER root
# Install ffmpeg + yt-dlp from Alpine repos (no pip, no PyInstaller issues)
RUN apk add --no-cache ffmpeg py3-yt-dlp curl

USER node
