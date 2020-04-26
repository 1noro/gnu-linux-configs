# mpu ARCHISO

# -- comprobación de red DHCP (por cable)
ping archlinux.org
timedatectl set-ntp true

# -- particionado y formateo de los HDDs
# tabla de particiones MBR (MSDOS)
# NAME        SIZE  TYPE    MOUNTPOINT
# sda       111,8G  disk
#   sda1    108,0G  part    /
#   sda2      3,8G  part    [SWAP]
# sdb         3,7T  disk
#   sdb1      3,7T  part    /home/cosmo/Descargas
# sdc       500,0G  disk
#   sdc1    500,0G  part    /home

# debería probar a particionarlo con GPT (separar boot y configuracón especial
# para GRUB, creo que hace falta una particion también)
# tabla de particiones GPT
# ¿?

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

# -- instalamos el sistema base en el disco particionado (pensar en que paquetes son necesarios aquí desde el principio)
pacstrap /mnt base linux linux-firmware dosfstools exfat-utils e2fsprogs ntfs-3g nano man-db man-pages texinfo sudo base-devel

# -- generamos el fstab tal cual como lo tenemos montado en la instalación
genfstab -U /mnt >> /mnt/etc/fstab

# -- nos impersonamos como root en nuestro sistema de archivos a instalar
arch-chroot /mnt
# CHROOT MODE

# asignamos una contrseña a root
passwd

# creamos y configuramos un nuevo usuario para podrer instalar paquetes desde AUR
useradd -m -s /bin/bash cosmo # considerar quitar la opción -m (create_home)
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
echo "mpu" > /etc/hostname
nano /etc/hosts
# agregar las siguientes lineas
# 127.0.0.1	localhost
# ::1		localhost
# 127.0.1.1	mpu.home.lan	mpu

# instalamos y habilitamos el demonio más básico de dhcp para que al reiniciar
# no nos quedemos sin internet
pacman -S dhcpcd
systemctl enable dhcpcd

# --- INICIO DE COMANDOS EXCLUSIVOS PARA MPU -----------------------------------
# modulos de kernel a cargar, etc...

# --- FINAL DE COMANDOS EXCLUSIVOS PARA MPU ------------------------------------

# instalamos y habilitamos las actualizacionse tempranas de microcodigo
# para procesadores intel
pacman -S grub intel-ucode
grub-install --target=i386-pc /dev/sda
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
