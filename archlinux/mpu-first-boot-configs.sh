# mpu FIRSTBOOT

# si no tenemos .bashrc
# cp /etc/skel/.bash_profile ~
# cp /etc/skel/.bash_logout ~
# y el .bashrc está en esta configuración

# --- configuración de pacman
# copiar el archivo mirrorlist de esta configuración en /etc/pacman.d/mirrorlist
# o generar uno por velocidad como se describe en la wiki:
# https://wiki.archlinux.org/index.php/Mirrors_(Espa%C3%B1ol)#Lista_por_velocidad
nano /etc/pacman.conf
# descomentar las siguientes lineas:
# - en Misc options:
#Color
#VerbosePkgLists
# - en los repositorios:
#[multilib]
#Include = /etc/pacman.d/mirrorlist
pacman -Syu # actualizamos el sistema
pacman -S pacman-contrib

# agregamos el hook (trigger) para limpiar la cache de pacman
# https://wiki.archlinux.org/index.php/Pacman_(Espa%C3%B1ol)#Limpiar_la_memoria_cach%C3%A9_de_los_paquetes
mkdir -p /etc/pacman.d/hooks/
nano /etc/pacman.d/hooks/remove_old_cache.hook
# - Escribe lo siguiente:
# [Trigger]
# Operation = Upgrade
# Operation = Install
# Operation = Remove
# Type = Package
# Target = *
#
# [Action]
# Description = Cleaning pacman cache...
# When = PostTransaction
# Exec = /usr/bin/paccache -r

# --- instalando los gráficos
lspci | grep VGA
pacman -S xf86-video-intel # driver de la tarjeta grafica
pacman -S mesa lib32-mesa # instalar OpenGl y OpenGl 32 (para steam, por ejemplo)
pacman -S jack2 lib32-jack2 xdg-desktop-portal-gtk gnu-free-fonts gdm gnome gnome-extra
# gdm ya está en el grupo gnome, pero lo escribo para resaltarlo
# especifico xdg-desktop-portal-gtk para no tener que leer la wiki siempre
# revisra las diferencias entre xdg-desktop-portal-gtk y xdg-desktop-portal-kde
# especifico jack2 para no tener que leer la wiki siempre
# https://github.com/jackaudio/jackaudio.github.com/wiki/Q_difference_jack1_jack2
systemctl enable gdm


# --- instalando y configurando NetworkManager
# instalamos NetworkManager para poder gestionar la red desde gnome
pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring  --needed

# systemctl --type=service
systemctl stop dhcpcd
systemctl disable dhcpcd

systemctl enable wpa_supplicant
systemctl enable NetworkManager

# add cosmo to network group
gpasswd -a cosmo network


# --- instalando y configurando el Bluetooth (en caso de estar presente en el equipo)
pacman -S bluez bluez-utils --needed
# verificamos que el modulo btusb está cargado en el kernel
lsmod | grep btusb
systemctl enable bluetooth

# reiniciamos para que se apliquen todos estos cambios importantes
reboot


# instalamos un navegador de internet decente
pacman -S firefox


# -- Teaaring Fix (intel graphics)
# parece que no funciona hoy dia; revisar:
# https://wiki.archlinux.org/index.php/GNOME/Troubleshooting#Tear-free_video_with_Intel_HD_Graphics
nano /etc/X11/xorg.conf.d/20-intel.conf
# agrega las siguientes lineas:
# Section "Device"
#       Identifier "Intel Graphics"
#       Driver "intel"
#       Option "TearFree" "true"
# EndSection
reboot


# -- SSD (optimizar y aumentar su vida)
# To verify TRIM support, run:
lsblk --discard
# And check the values of DISC-GRAN (discard granularity) and DISC-MAX (discard
# max bytes) columns. Non-zero values indicate TRIM support.
systemctl enable fstrim.timer


# -- default MIME types
# para que funcione la opción ver en carpeta de los programas como firefox, etc
xdg-mime default org.gnome.Nautilus.desktop inode/directory


# --- mpu specific configs ---
# ninguna por el momento

reboot

# ejecutar los scripts de instalación de programas incluidos en esta carpeta
