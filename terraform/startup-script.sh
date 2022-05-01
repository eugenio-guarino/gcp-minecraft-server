#!/bin/bash
sudo su

# install packages
apt update -y && apt upgrade -y
apt install default-jre -y
apt install unzip -y
apt install openjdk-17-jdk -y

# download minecraft server
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar

# create directory
mkdir -p /opt/minecraft/world/datapacks

# move forge in new directory
mv forge-1.18.2-40.1.0-installer.jar /opt/minecraft

cd /opt/minecraft

# run java
java -Xms1024M -Xmx7000M -jar forge-1.18.2-40.1.0-installer.jar --installServer

echo eula=true>eula.txt

# download mods
gsutil -m cp -r gs://minecraft-server-storage-bucket/mods.zip /opt/minecraft/
unzip mods.zip
rm mods.zip

# download datapack
gsutil -m cp -r gs://minecraft-server-storage-bucket/AriA.zip /opt/minecraft/world/datapacks
unzip /opt/minecraft/world/datapacks/AriA.zip -d /opt/minecraft/world/datapacks
rm AriA.zip

# download server.properties
gsutil -m cp -r gs://minecraft-server-storage-bucket/server.properties /opt/minecraft/

#run minecraft server
chmod +x run.sh
# sh run.sh &