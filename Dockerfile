# Stage 1: Build jellyfin-web
FROM node:20-alpine AS web-build
WORKDIR /web
COPY jellyfin-web/package.json jellyfin-web/package-lock.json ./
RUN npm ci
COPY jellyfin-web/ ./
RUN npm run build:development

# Stage 2: Build jellyfin server
FROM mcr.microsoft.com/dotnet/sdk:9.0-bookworm-slim AS jellyfin-build
WORKDIR /src
COPY jellyfin/ ./jellyfin/
WORKDIR /src/jellyfin
RUN dotnet publish Jellyfin.Server/Jellyfin.Server.csproj -c Release -o /out --self-contained false

# Stage 3: Final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0-bookworm-slim AS runtime
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    libfontconfig1 \
    libfreetype6 \
    libx11-6 \
    libxcb1 \
    libxrender1 \
    libxext6 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*
COPY install-ffmpeg-docker.sh /tmp/install-ffmpeg.sh
RUN chmod +x /tmp/install-ffmpeg.sh && /tmp/install-ffmpeg.sh && rm /tmp/install-ffmpeg.sh
COPY --from=jellyfin-build /out/ ./
COPY --from=web-build /web/dist /app/jellyfin-web/dist
EXPOSE 8096
ENV ASPNETCORE_URLS=http://+:8096
CMD ["./jellyfin", "--webdir", "/app/jellyfin-web/dist"]
