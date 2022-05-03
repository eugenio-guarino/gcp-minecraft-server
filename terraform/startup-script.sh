#!/bin/bash
sudo su

# install packages
apt update -y && apt upgrade -y
apt install default-jre -y
apt install unzip -y
apt install openjdk-17-jdk -y
apt install zip -y
apt install coreutils -y

# create directory
mkdir -p /opt/minecraft
cd /opt/minecraft

# download minecraft server
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar

# run java with appropriate flags
java -XX:+UseG1GC -Xmx15G -Xms15G -XX:InitiatingHeapOccupancyPercent=20 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32 -jar forge-1.18.2-40.1.0-installer.jar --installServer

echo eula=true>eula.txt

# download mods from cloud storage
gsutil -m cp -r gs://minecraft-server-storage-bucket/mods.zip /opt/minecraft/
unzip mods.zip
rm mods.zip

download world from cloud storage
gsutil -m cp gs://minecraft-server-storage-bucket/world.zip /opt/minecraft/
unzip world.zip
rm world.zip

# download server.properties from cloud storage
gsutil -m cp gs://minecraft-server-storage-bucket/server.properties /opt/minecraft/

# download ops.json from cloud storage
gsutil -m cp gs://minecraft-server-storage-bucket/ops.json /opt/minecraft/

# download user cache from cloud storage
gsutil -m cp gs://minecraft-server-storage-bucket/usercache.json /opt/minecraft/

# auto-destroy script
gsutil -m cp gs://minecraft-server-storage-bucket/auto-destroy.sh /opt/minecraft/

# notify
gsutil -m cp gs://minecraft-server-storage-bucket/notify.sh /opt/minecraft/

# run minecraft server
chmod +x run.sh

nohup bash run.sh </dev/null &>/dev/null &
nohup bash auto-destroy.sh </dev/null &>/dev/null &
nohup bash notify.sh </dev/null &>/dev/null &