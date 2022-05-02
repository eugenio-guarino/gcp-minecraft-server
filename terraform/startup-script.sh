#!/bin/bash
sudo su

# install packages
apt update -y && apt upgrade -y
apt install default-jre -y
apt install unzip -y
apt install openjdk-17-jdk -y
apt install zip -y

# download minecraft server
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar

# create directory
mkdir -p /opt/minecraft/Aria/datapacks

# move forge in new directory
mv forge-1.18.2-40.1.0-installer.jar /opt/minecraft

cd /opt/minecraft

# run java with appropriate flags
java -XX:+UseG1GC -Xmx15G -Xms15G -XX:InitiatingHeapOccupancyPercent=20 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32 -jar forge-1.18.2-40.1.0-installer.jar --installServer

echo eula=true>eula.txt

# download mods
gsutil -m cp -r gs://minecraft-server-storage-bucket/mods.zip /opt/minecraft/
unzip mods.zip
rm mods.zip

# download datapack
gsutil -m cp gs://minecraft-server-storage-bucket/Aria.zip /opt/minecraft/
unzip /opt/minecraft/Aria.zip
rm Aria.zip

# download server.properties
gsutil -m cp gs://minecraft-server-storage-bucket/server.properties /opt/minecraft/

#user cache
gsutil -m cp gs://minecraft-server-storage-bucket/usercache.json /opt/minecraft/

# auto-destroy script
gsutil -m cp gs://minecraft-server-storage-bucket/auto-destroy.sh /opt/minecraft/

# run minecraft server
chmod +x run.sh
chmod +x auto-destroy.sh
# sh run.sh &
# sh auto-destroy.sh &