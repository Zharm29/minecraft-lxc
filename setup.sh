#!/bin/bash

# Instalar Java 21
sudo apt update
sudo apt install openjdk-21-jre-headless -y

# Crear directorio para el servidor
mkdir -p /opt/minecraft
cd /opt/minecraft

# Descargar la última versión de PaperMC
curl -o paperclip.jar https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/416/downloads/paper-1.20.4-416.jar

# Crear script de inicio
cat <<EOL > start.sh
#!/bin/bash
java -Xms4G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
     -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions \
     -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
     -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
     -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 \
     -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 \
     -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 \
     -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
     -Dusing.aikars.flags=https://mcflags.emc.gs -jar paperclip.jar nogui
EOL

chmod +x start.sh

# Crear servicio systemd
cat <<EOL | sudo tee /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=$USER
WorkingDirectory=/opt/minecraft
ExecStart=/opt/minecraft/start.sh
Restart=on-failure
SuccessExitStatus=0 1

[Install]
WantedBy=multi-user.target
EOL

# Habilitar y arrancar el servicio
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft
