#!/bin/bash

echo -e "blacklist ntfs3\nblacklist ntfs" | sudo tee /etc/modprobe.d/disable-ntfs.conf
sudo modprobe -r ntfs3 || true
sudo modprobe -r ntfs || true
sudo apt update

sudo apt install -y --no-install-recommends gvfs gvfs-backends scrot
sudo apt install -y --no-install-recommends git wget 7zip unzip zip ntfs-3g exfatprogs dosfstools librsvg2-common
sudo apt install -y --no-install-recommends pipewire pipewire-audio-client-libraries pipewire-pulse pipewire-alsa wireplumber pavucontrol pnmixer
sudo apt install -y --no-install-recommends udisks2

sudo apt install -y --no-install-recommends \
    xorg openbox obconf tint2 lxappearance pcmanfm udiskie \
    lxsession-logout dunst picom dbus-x11 alacritty gxkb libnotify-bin python3-gi gir1.2-notify-0.7

sudo apt install -y --no-install-recommends firefox-esr mousepad mpv galculator gpicview xarchiver lxtask gdebi
sudo apt purge fortune-mod -y
sudo apt autoremove -y

sudo apt install -y --no-install-recommends locales
echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
sudo update-locale LANG=ru_RU.UTF-8
source /etc/default/locale

mkdir -p ~/.icons ~/.themes

git clone --depth 1 https://github.com/B00merang-Artwork/Windows-XP.git ~/.icons/Windows-XP

TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/B00merang-Project/Windows-XP.git "$TMP/gtk"
cp -r "$TMP/gtk/Windows XP Embedded" ~/.themes/
rm -rf $TMP

mkdir -p ~/.config/openbox
mkdir -p ~/.config/pcmanfm/default
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/tint2
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/pnmixer
mkdir -p ~/.config/picom
mkdir -p ~/.local/share/gxkb/flags
mkdir -p ~/.local/bin

wget -O ~/.local/bin/layout_switch.sh https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/bin/layout_switch.sh
chmod +x ~/.local/bin/layout_switch.sh

wget -O ~/.local/share/gxkb/flags/ru.png https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/share/gxkb/flags/ru.png
wget -O ~/.local/share/gxkb/flags/us.png https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.local/share/gxkb/flags/us.png

wget -O ~/.config/tint2/tint2rc https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/tint2/tint2rc
wget -O ~/.config/pcmanfm/default/wallpaper.jpg https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/pcmanfm/default/wallpaper.jpg
wget -O ~/.config/gtk-3.0/settings.ini https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/gtk-3.0/settings.ini
wget -O ~/.config/openbox/rc.xml https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/openbox/rc.xml
wget -O ~/.config/mimeapps.list https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/mimeapps.list
wget -O ~/.config/pnmixer/config https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/pnmixer/config
wget -O ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/alacritty/alacritty.toml
wget -O ~/.config/picom/picom.conf https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/picom/picom.toml
wget -O ~/.config/openbox/autostart https://raw.githubusercontent.com/fakename00121v/debian-xp/refs/heads/main/.config/openbox/autostart

cat << EOF > $HOME/.config/pcmanfm/default/desktop-items-0.conf
[*]
wallpaper_mode=stretch
wallpaper_common=1
wallpaper=$HOME/.config/pcmanfm/default/wallpaper.jpg
desktop_bg=#000000
desktop_fg=#ffffff
desktop_shadow=#000000
desktop_font=Sans 12
show_wm_menu=0
sort=mtime;ascending;
show_documents=1
show_trash=1
show_mounts=1
EOF

touch ~/.config/openbox/.first_run

echo "exec dbus-launch --exit-with-session openbox-session" > ~/.xinitrc

systemctl --user enable pipewire.service pipewire-pulse.service wireplumber.service
systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service

sudo -v

startx