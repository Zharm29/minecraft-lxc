# Minecraft LXC Server Template

Este repositorio contiene una plantilla y scripts para configurar un servidor de Minecraft optimizado dentro de un contenedor LXC en Ubuntu 24.04.

## Contenido

- `setup.sh`: Script para instalar Java 21, descargar PaperMC y configurar el servicio systemd.
- `start.sh`: Script para iniciar el servidor con flags optimizados.
- `minecraft.service`: Archivo de servicio systemd para manejar el servidor Minecraft.
- Instrucciones para desplegar en Proxmox u otros entornos LXC.

## Uso

1. Clona este repositorio:
   ```
   git clone https://github.com/Zharm29/minecraft-lxc.git
   cd minecraft-lxc
   ```

2. Ejecuta el script de configuración:
   ```
   chmod +x setup.sh
   ./setup.sh
   ```

3. Verifica que el servidor está corriendo:
   ```
   sudo systemctl status minecraft
   ```

## Notas

- Ajusta la cantidad de RAM en `start.sh` según la memoria disponible.
- Este setup usa PaperMC versión 1.20.4 build 416.
- El servicio systemd corre bajo el usuario que ejecuta `setup.sh`.

## Licencia

MIT License
