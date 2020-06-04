#!/bin/bash
# RUN AS ROOT
if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

### BORRAR CONFIGURACIÓN INTEL GRAPHICS 2500 ##################################
## Quitamos los módulos de kernel de intel del mkinitcpio.conf
# agregamos el módulo i915 al kernel de Linux y lo volvemos a configura
# esto es para cargar KMS lo antes posible al inicio del boot
# https://wiki.archlinux.org/index.php/Kernel_mode_setting_(Espa%C3%B1ol)
nano /etc/mkinitcpio.conf
# modificar la linea MODULES=(i915) --> MODULES=()
mkinitcpio -p linux
# comprobar aquí si falta algún módulo por cargar para este hardware específico

## Borramos las configuraciones de intel
rm /etc/X11/xorg.conf.d/20-intel.conf
rm ~/.drirc

## Ponemos en la lista negra los modulos de Intel
echo 'install i915 /bin/false' >> /etc/modprobe.d/blacklist.conf
echo 'install intel_agp /bin/false' >> /etc/modprobe.d/blacklist.conf

## será necesario borrar los drivers de la tarjeta de intel?
pacman -Rns xf86-video-intel mesa lib32-mesa

### INSTALAR CONFIGURACIÓN NVIDIA GTX1070 #####################################
# https://wiki.archlinux.org/index.php/NVIDIA_(Espa%C3%B1ol)
## Instalamos el los controladores y utilidades extra de nvidia
## este orden es el recomendado
pacman -S nvidia-utils --needed # paquete de utilidades extra (no se si ya viene con el básico)
pacman -S nvidia --needed # paquete básico
pacman -S lib32-nvidia-utils --needed # librerias de 32 bits por si hacen falta
pacman -S nvidia-smi --needed # paquete para leer la temperatura sin usar X (no se si ya viene con el básico)

## Configuración mínima manual
# echo 'Section "Device"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        Identifier "Nvidia Card"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        Driver "nvidia"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        VendorName "NVIDIA Corporation"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        Option "NoLogo" "true"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        #Option "RenderAccel" "1" # activado por defecto' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        #Option "UseEDID" "false"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        #Option "ConnectedMonitor" "DFP"' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo '        # ...' > /etc/X11/xorg.conf.d/20-nvidia.conf
# echo 'EndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf

## Configuración automática (viene con el paquete nvidia)
nvidia-xconfig

## revisamos /etc/xorg.conf para ver soi nos convencen los parámetros autmáticos
## comentamos la siguiente línea si está presente
# Load        "dri"

## Configuraciones de optimización
# echo 'nvidia-settings --load-config-only' >> ~/.xinitrc # si no cambio nada en nvidia-settings no debería hacer falta
echo 'nvidia-settings -a InitialPixmapPlacement=2' >> ~/.xinitrc
