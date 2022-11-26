# escape=`
FROM lacledeslan/steamcmd:linux as fof-builder

# Download Fistful of Frags via SteamCMD
RUN echo "\n\nDownloading Fistful of Frags via SteamCMD"; `
        mkdir --parents /output; `
        /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 295230 validate +quit;

#=======================================================================
FROM debian:bullseye-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates libtinfo5:i386 lib32gcc-s1 libstdc++6:i386 locales locales-all tini tmux &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

LABEL maintainer="Laclede's LAN <contact @lacledeslan.com>" `
      com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Fistful of Frags Dedicated Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-fof"

# Set up Enviornment
RUN useradd --home /app --gid root --system Fistful &&`
    mkdir -p /app/ll-tests &&`
    chown Fistful:root -R /app;

# `RUN true` lines are work around for https://github.com/moby/moby/issues/36573
COPY --chown=Fistful:root --from=fof-builder /output /app
RUN true

COPY --chown=Fistful:root ./dist/linux/ll-tests /app/ll-tests
RUN chmod +x /app/ll-tests/*.sh;

USER Fistful

RUN echo $'\n\nLinking steamclient.so to prevent srcds_run errors' &&`
        mkdir --parents /app/.steam/sdk32 &&`
        ln -s /app/bin/steamclient.so /app/.steam/sdk32/steamclient.so;

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
