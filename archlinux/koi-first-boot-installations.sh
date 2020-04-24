nano /etc/pacman.conf
# descomentar las siguientes lineas:
# [multilib]
# Include = /etc/pacman.d/mirrorlist
pacman -Syu # actualizamos el sistema

lspci | grep VGA
pacman -S xf86-video-intel
pacman -S lib32-mesa
pacman -S gnome
systemctl enable gdm

pacman -S wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring

# systemctl --type=service
systemctl stop dhcpcd
systemctl disable dhcpcd

systemctl enable wpa_supplicant
systemctl enable NetworkManager

# add cosmo to network group
gpasswd -a cosmo network

reboot

# --- ThinkPad X230 configs ---
# (https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X230#Configuration)
# (https://www.reddit.com/r/thinkpad/wiki/os/linux#wiki_which_linux_distro.3F)

# pacman -S xorg-xrandr # me parece que al usar gnome ya no hace falta
# X230 has IPS or TN screen with 125.37 DPI. Refer to HiDPI page for more
# information. It can be set with command xrandr --dpi 125.37 using .xinitrc,
# .xsession or other autostarts.

# --- TouchPad
nano /etc/X11/xorg.conf.d/50-synaptics.conf
# Escribir
# Section "InputClass"
#         Identifier "touchpad"
#         MatchProduct "SynPS/2 Synaptics TouchPad"
#         # MatchTag "lenovo_x230_all"
#         Driver "synaptics"
#         # fix touchpad resolution
#         Option "VertResolution" "100"
#         Option "HorizResolution" "65"
#         # disable synaptics driver pointer acceleration
#         Option "MinSpeed" "1"
#         Option "MaxSpeed" "1"
#         # tweak the X-server pointer acceleration
#         Option "AccelerationProfile" "2"
#         Option "AdaptiveDeceleration" "16"
#         Option "ConstantDeceleration" "16"
#         Option "VelocityScale" "20"
#         Option "AccelerationNumerator" "30"
#         Option "AccelerationDenominator" "10"
#         Option "AccelerationThreshold" "10"
# 	# Disable two fingers right mouse click
# 	Option "TapButton2" "0"
#         Option "HorizHysteresis" "100"
#         Option "VertHysteresis" "100"
#         # fix touchpad scroll speed
#         Option "VertScrollDelta" "500"
#         Option "HorizScrollDelta" "500"
# EndSection

# -- Batería
# (https://www.reddit.com/r/thinkpad/wiki/os/linux#wiki_use_of_ssd_with_linux)
pacman -S acpi_call powertop

powertop --calibrate

nano /etc/systemd/system/powertop.service
# agregar las siguientes lineas
# [Unit]
# Description=Powertop tunings
#
# [Service]
# Type=idle
# ExecStart=/usr/bin/powertop --auto-tune
#
# [Install]
# WantedBy=multi-user.target

systemctl enable powertop
systemctl start powertop
powertop

pacman -S tlp

nano /etc/mkinitcpio.conf
# modificar la linea MODULES=(i915) --> MODULES=(i915 acpi_call)
mkinitcpio -p linux

nano /etc/default/tlp
# agregar las lineas:
# TLP_ENABLE=1
# MAX_LOST_WORK_SECS_ON_BAT=15
# START_CHARGE_THRESH_BAT0=67
# STOP_CHARGE_THRESH_BAT0=90

# estos dos comandos definen el porcentaje al que se inicia/para de cargar la
# bateria se borran cada vez que esta se extrae
# ejemplo: si el 100% actual es del 60% del origial, un 80% de ese 60% cortaría
# la carga al 51% aprox
# echo 40 > /sys/class/power_supply/BAT0/charge_start_threshold
# echo 80 > /sys/class/power_supply/BAT0/charge_stop_threshold

systemctl enable tlp
reboot

tlp-stat # ver la configuración actual y el estado de la batería

git clone https://aur.archlinux.org/tlpui-git.git
cd tlpui-git
makepkg -si

# -- Ventiladores
pacman -S lm_sensors
git clone https://aur.archlinux.org/thinkfan.git
cd thinkfan
makepkg -si
# run as ROOT
echo "options thinkpad_acpi fan_control=1" > /etc/modprobe.d/thinkfan.conf
nano /etc/thinkfan.conf
# agrega las siguiente lineas
# tp_fan /proc/acpi/ibm/fan
# hwmon /sys/class/thermal/thermal_zone0/temp
#
# (0, 0,  60)
# (1, 53, 65)
# (2, 55, 66)
# (3, 57, 68)
# (4, 61, 70)
# (5, 64, 71)
# (7, 68, 32767)
modprobe thinkpad_acpi
cat /proc/acpi/ibm/fan
thinkfan -n # testing the configuration
systemctl enable thinkfan

# -- SSD
# To verify TRIM support, run:
lsblk --discard
# And check the values of DISC-GRAN (discard granularity) and DISC-MAX (discard
# max bytes) columns. Non-zero values indicate TRIM support.

systemctl enable fstrim.timer
