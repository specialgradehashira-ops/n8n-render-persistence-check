# Debian/glibc base that works with yt-dlp and ffmpeg
FROM n8nio/n8n:1.110.1

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp (glibc build)
RUN curl -fsSL -o /usr/local/bin/yt-dlp \
      https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    && chmod +x /usr/local/bin/yt-dlp

# (optional) prove they’re present
RUN ffmpeg -version | head -1 && yt-dlp --version

USER node
