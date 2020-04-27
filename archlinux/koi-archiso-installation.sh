# koi ARCHISO

# -- comprobación de red DHCP (por cable)
ping archlinux.org
timedatectl set-ntp true

# -- particionado y formateo del HDD

# tabla de particiones MBR (MSDOS)
# NAME        SIZE  TYPE    MOUNTPOINT
# sda       223,6G  disk
#   sda1     70,0G  part    /
#   sda2    512,0M  part    [SWAP]
#   sda3    153,1G  part    /home

# debería probar a particionarlo con GPT (separar boot y configuracón especial
# para GRUB, creo que hace falta una particion también)
# tabla de particiones GPT
# ¿?

fdisk /dev/sda

lsblk -fm
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2

# montamos de forma correcta las particiones sobre el sistema de archivos a configurar
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
lsblk -fm

# -- inicio del particionado y formateo de los HDDs ----------------------------
# - tabla de particiones MBR (MSDOS)
# NAME        SIZE  TYPE    MOUNTPOINT
# sda       223,6G  disk
#   sda1     70,0G  part    /
#   sda2    512,0M  part    [SWAP]
#   sda3    153,1G  part    /home

fdisk /dev/sda
fdisk /dev/sdc

lsblk -fm
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sdc1
mkswap /dev/sda2
swapon /dev/sda2

# montamos de forma correcta las particiones sobre el sistema de archivos a configurar
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sdc1 /mnt/home
mkdir -p /mnt/home/cosmo/Descargas
mount /dev/sdb1 /mnt/home/cosmo/Descargas
lsblk -fm

# - tabla de particiones GPT
# https://wiki.archlinux.org/index.php/EFI_system_partition#GPT_partitioned_disks
# https://wiki.archlinux.org/index.php/GRUB#GUID_Partition_Table_(GPT)_specific_instructions
# NAME        SIZE  TYPE                    MOUNTPOINT
# sda       223,6G  disk
#   sda1    512,0M  part EFI System (ESP)   /boot
#   sda2     70,0G  part                    /
#   sda3    512,0M  part                    [SWAP]
#   sda4    153,0G  part                    /home

fdisk /dev/sda
fdisk /dev/sdc

lsblk -fm
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda4
mkswap /dev/sda3
swapon /dev/sda3

# montamos de forma correcta las particiones sobre el sistema de archivos a configurar
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home
lsblk -fm

# -- final del particionado y formateo de los HDDs -----------------------------

# -- instalamos el sistema base en el disco particionado (pensar en que paquetes son necesarios aquí desde el principio)
pacstrap /mnt base linux linux-firmware dosfstools exfat-utils e2fsprogs ntfs-3g nano vim man-db man-pages texinfo sudo base-devel

# -- generamos el fstab tal cual como lo tenemos montado en la instalación
genfstab -U /mnt >> /mnt/etc/fstab

# -- nos impersonamos como root en nuestro sistema de archivos a instalar
arch-chroot /mnt
# CHROOT MODE

# asignamos una contrseña a root
passwd

# creamos y configuramos un nuevo usuario para podrer instalar paquetes desde AUR
useradd -m -s /bin/bash cosmo
passwd cosmo
env EDITOR=nano visudo
# agregar la siguiente linea: cosmo ALL=(ALL) ALL

# instalamos, habilitamos y ejecutamos ssh para poder continuar con la
# instalación desde otro pc de forma remota
pacman -S openssh
systemctl enable --now sshd

# configuramos la hora (no se porqué esto no funcinó bien la primera vez y
# luego tuve que volver a configurarlo desde gnome)
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc

# configuramos el idioma por defecto del equipo
nano /etc/locale.gen
# descomentamos:
# en_US.UTF-8 UTF-8
# es_ES.UTF-8 UTF-8
locale-gen
echo "LANG=es_ES.UTF-8" > /etc/locale.conf

# ponemos nombre al equipo
echo "koi" > /etc/hostname
nano /etc/hosts
# agregar las siguientes lineas
# 127.0.0.1	localhost
# ::1		localhost
# 127.0.1.1	koi.home.lan	koi

# instalamos y habilitamos el demonio más básico de dhcp para que al reiniciar
# no nos quedemos sin internet
pacman -S dhcpcd
systemctl enable dhcpcd

# --- módulos de kernel necesarios
# agregamos el módulo i915 al kernel de Linux y lo volvemos a configura
# esto es para cargar KMS lo antes posible al inicio del boot
# https://wiki.archlinux.org/index.php/Kernel_mode_setting_(Espa%C3%B1ol)
nano /etc/mkinitcpio.conf
# modificar la linea MODULES=() --> MODULES=(i915)
mkinitcpio -p linux

# --- INICIO DE COMANDOS EXCLUSIVOS PARA ThinkPad X230 -------------------------
# (https://gist.github.com/imrvelj/c65cd5ca7f5505a65e59204f5a3f7a6d)
# solución para el error:
# Possibly missing firmware for module: aic94xx
# Possibly missing firmware for module: wd719x
su cosmo
cd
pacman -S git
git clone https://aur.archlinux.org/aic94xx-firmware.git
cd aic94xx-firmware
makepkg -sri
git clone https://aur.archlinux.org/wd719x-firmware.git
cd wd719x-firmware
makepkg -sri
exit
mkinitcpio -p linux

# --- FINAL DE COMANDOS EXCLUSIVOS PARA ThinkPad X230 --------------------------

# instalamos y habilitamos las actualizacionse tempranas de microcodigo
# para procesadores intel
pacman -S grub intel-ucode
grub-install --target=i386-pc /dev/sda # instalación para particiones MBR (MSDOS)
# editamos los boot parameters del kernel al iniciarlo, explicaciones:
# https://wiki.archlinux.org/index.php/Kernel_parameters_(Espa%C3%B1ol)
# https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
# https://wiki.archlinux.org/index.php/Improving_performance#Watchdogs
# https://wiki.archlinux.org/index.php/Intel_graphics#Enable_early_KMS
nano /etc/default/grub
# editando la linea GRUB_CMDLINE_LINUX_DEFAULT para dejarla así:
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 nowatchdog i915.enable_guc=2"
# de paso, también reducimos el tiempo de espera en la pantalla de grub
# GRUB_TIMEOUT=2
grub-mkconfig -o /boot/grub/grub.cfg

# salimos del entorno chroot, y volvemos al instalador de arch (archiso)
exit
# BACK TO ARCHISO

# desmontamos con seguridad el entorno de instalación
sync
umount -R /mnt

# reiniciamos
reboot

# extraemos el medio de instalación (USB o CD/DVD)

# continuar con los pasos de koi-first-boot-installations.sh
