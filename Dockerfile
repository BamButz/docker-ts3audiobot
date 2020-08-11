FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic
WORKDIR /usr/src/ts3audiobot

RUN apt-get update -y \
    && apt-get install -y \
    libopus-dev \
    ffmpeg \
    python-pip

RUN pip install --upgrade youtube_dl

RUN git clone --recurse-submodules https://github.com/Splamy/TS3AudioBot.git . \
    && dotnet publish --framework netcoreapp3.1 --configuration Release --output /opt/ts3audiobot TS3AudioBot

WORKDIR /ts3audiobot
ENTRYPOINT ["dotnet", "/opt/ts3audiobot/TS3AudioBot.dll"]