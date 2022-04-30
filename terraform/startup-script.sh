#!/bin/bash
bash
sudo su
echo "hello"

wget https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar -O minecraft_server.1.17.jar

java -Xms1024M -Xmx1536M -jar minecraft_server.1.18.jar -o true

chmod +x /home/minecraft/run.sh

# sudo sh /home/minecraft/run.sh