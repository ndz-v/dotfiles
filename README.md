# dotfiles

<img src="https://github.com/Nidzo-Vidic/dotfiles/blob/master/media/desktop.png" width="300" height="200">

## Installation

```shell
sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/nidzov/dotfiles/master/remote-setup.sh`"
```

## General tips

### Improve boot time for linux

Exists to ensure that the boot process can access remote resources and slows down boot process.
Disable and mask the service to decrease boot time.

```bash
sudo systemctl disable NetworkManager-wait-online.service # disables service on start up
sudo systemctl mask NetworkManager-wait-online.service # disables dbus based invocation
```

### Kernel flags for turning off spectre patches ([make linux fast again](https://make-linux-fast-again.com))

```bash
GRUB_CMDLINE_LINUX_DEFAULT="nouveau.modeset=0 acpi_rev_override=1 noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off"
```
Graphics problem on Dell XPS 15: dedicated graphics is powered although intel hybrid card is selected. Results in greater power consumption and battery drainage.

```bash
nouveau.modeset=0 acpi_rev_override=1
```
Use these flags as a workaround for the faulty nvidia driver. Only if a reinstall of the driver doesn't help.

### If audio is not working with headphones

```bash
alsactl restore
```

### Audio config to switch to headphones on startup

```bash
cd /usr/share/pulseaudio/alsa-mixer/paths
sudo nano analog-output-lineout.conf
```

Edit this line

```.conf
[Element Headphone+LO]
switch = on
```
