# Fistful of Frag Dedicated Server in Docker

![Fistful of Frags](https://raw.githubusercontent.com/LacledesLAN/gamesvr-fof/main/.misc/fof.jpg "Fistful of Frags")

Fistful of Frags is a multiplayer Western Half-Life 2 first-person shooter mod that involves team-based or free-for-all shootouts and
cooperative games against AI managed enemies. It was released on Steam for Microsoft Windows, Mac OS and Linux on May 9, 2014, with several
updates subsequently adding features and maps.

## Linux

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-fof/actions/workflows/build-linux-image.yml/badge.svg?branch=main)](https://github.com/LacledesLAN/gamesvr-fof/actions/workflows/build-linux-image.yml)

### Download

```shell
docker pull lacledeslan/gamesvr-fof;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if
any tests fail.

```shell
docker run -it --rm lacledeslan/gamesvr-fof ./ll-tests/gamesvr-fof.sh;
```

### Run Interactive Server

```shell
docker run -it --rm --net=host lacledeslan/gamesvr-fof /app/srcds_run -game fof +map fof_fistful -insecure -norestart +sv_lan 1;
```

## Getting Started with Game Servers in Docker

[Docker](https://docs.docker.com/) is an open-source project that bundles applications into lightweight, portable, self-sufficient
containers. For a crash course on running Dockerized game servers check out [Using Docker for Game
Servers](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/DockerAndGameServers.md). For tips, tricks, and recommended tools
for working with Laclede's LAN Dockerized game server repos see the guide for [Working with our Game Server
Repos](https://github.com/LacledesLAN/README.1ST/blob/master/GameServers/WorkingWithOurRepos.md). You can also browse all of our other
Dockerized game servers: [Laclede's LAN Game Servers Directory](https://github.com/LacledesLAN/README.1ST/tree/master/GameServers).
