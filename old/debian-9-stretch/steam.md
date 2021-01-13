# Install Setam in Debina 9 (Jessie)

>Basado en: [https://wiki.debian.org/es/Steam](https://wiki.debian.org/es/Steam)

Debe asegurarse de que el usuario mediante el que ejecutará regularmente juegos de Steam está al menos en los grupos `video` y `audio`.

```Bash
usermod -a -G video,audio <user>
```

Modificamos el archivo `/etc/apt/sources.list`.

```Bash
nano /etc/apt/sources.list
```
```Bash
# Debian Jessie
deb http://httpredir.debian.org/debian/ jessie main contrib non-free
```

Añadimos la estructura `i386`.

```Bash
dpkg --add-architecture i386
apt update
apt dist-upgrade
```

Instalamos los paquetes.

```Bash
apt install libx32stdc++6 libx32stdc++6:i386 lib32z1 lib32ncurses5 libgpg-error0:i386 libx11-6:i386
apt install libegl1-mesa:i386 libgl1-mesa-dri:i386 libgl1-mesa-glx:i386
apt install steam
```
