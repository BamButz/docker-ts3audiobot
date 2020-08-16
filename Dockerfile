# Build Image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic as builder
WORKDIR /usr/src/ts3audiobot

RUN git clone --recurse-submodules https://github.com/Splamy/TS3AudioBot.git . \
    && dotnet publish --framework netcoreapp3.1 --configuration Release --output /opt/ts3audiobot TS3AudioBot

# Runtime Image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1

RUN apt-get update -y \
    && apt-get install -y \
    libopus-dev \
    ffmpeg \
    python-pip \
    && pip install --upgrade youtube_dl

COPY --from=builder /opt/ts3audiobot /opt/ts3audiobot

WORKDIR /ts3audiobot
ENTRYPOINT ["dotnet", "/opt/ts3audiobot/TS3AudioBot.dll"]