# dotfiles

![](/media/desktop.png)

## Installation

```shell
sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/nidzov/dotfiles/master/remote-setup.sh`"
```

## Audio config to switch to headphones on startup

```bash
cd /usr/share/pulseaudio/alsa-mixer/paths
sudo nano analog-output-lineout.conf
```

Edit this line

```.conf
[Element Headphone+LO]
switch = on
```
