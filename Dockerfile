# Lock to the same major/minor you’re running in Render logs (1.109.2).
# You can switch to :latest later if you want.
FROM n8nio/n8n:1.109.2

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      ffmpeg curl ca-certificates wget jq tzdata coreutils procps python3 \
    && rm -rf /var/lib/apt/lists/*

# Bake in yt-dlp so we don’t fetch it each run
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux \
      -o /usr/local/bin/yt-dlp && chmod +x /usr/local/bin/yt-dlp

# Work dir used by your flow
RUN mkdir -p /home/node/work && chown -R node:node /home/node/work

USER node
ENV N8N_PORT=5678
EXPOSE 5678

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD wget -qO- http://localhost:5678/healthz || exit 1

CMD ["tini", "--", "n8n"]
