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
java -XX:+UseG1GC -Xmx6500M -Xms6500M -XX:InitiatingHeapOccupancyPercent=20 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32 -jar forge-1.18.2-40.1.0-installer.jar --installServer

echo eula=true>eula.txt

# download mods from cloud storage
gsutil -m cp -r gs://minecraft-terraform/config-files/mods.zip .
unzip mods.zip
rm mods.zip

# download world from cloud storage
gsutil -m cp gs://minecraft-terraform/config-files/world.zip .
unzip world.zip
rm world.zip

gsutil -m cp gs://minecraft-terraform/config-files/config.zip .
unzip config.zip
rm config.zip

# download server.properties from cloud storage
gsutil -m cp gs://minecraft-terraform/config-files/server.properties .

# download ops.json from cloud storage
gsutil -m cp gs://minecraft-terraform/config-files/ops.json .

# download user cache from cloud storage
gsutil -m cp gs://minecraft-terraform/config-files/usercache.json .

# auto-destroy script
gsutil -m cp gs://minecraft-terraform/scripts/auto-destroy.sh .

# notify 
gsutil -m cp gs://minecraft-terraform/scripts/notify.sh .

# destroy infrastructure script
gsutil -m cp gs://minecraft-terraform/scripts/destroy-infr.sh .

# run minecraft server
chmod +x run.sh

nohup bash run.sh </dev/null &>/dev/null &

sleep 5m
nohup bash notify.sh </dev/null &>/dev/null &

sleep 10m
nohup bash auto-destroy.sh </dev/null &>/dev/null &