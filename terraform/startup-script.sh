#!/bin/bash
sudo su

## install packages
apt update && apt upgrade
apt install default-jre
apt install unzip
apt install openjdk-17-jdk

# download minecraft server
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.1.0/forge-1.18.2-40.1.0-installer.jar

# copy mods 
mkdir /opt/minecraft
mv forge-1.18.2-40.1.0-installer.jar /opt/minecraft

cd /opt/minecraft

# run java
java -Xms1024M -Xmx7000M -jar forge-1.18.2-40.1.0-installer.jar --installServer

echo eula=true>eula.txt

#run minecraft server
chmod +x minecraft/run.sh
sh minecraft/run.sh &

# download mods
gsutil -m cp -r gs://minecraft-server-storage-bucket/mods.zip /opt/minecraft/
unzip mods.zip