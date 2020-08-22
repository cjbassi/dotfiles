#!/usr/bin/env bash

shopt -s dotglob

# keys {{{1

sudo mkdir /mnt/usb
sudo mount -L KEYS /mnt/usb

cp -r /mnt/usb/ssh ~/.ssh
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519

sudo umount /mnt/usb
sudo rmdir /mnt/usb


# clone repo {{{1

while [[ ! -d "~/config" ]]; do
	hub clone cjbassi/config
done


# source env {{{1

source ~/config/shell/env.sh


# Directories {{{1

mkdir -p \
	~/Downloads \
	~/Drive \
	~/projects \
	~/projects/{mine,other} \
	$XDG_CONFIG_HOME

ln -sf $XDG_DATA_HOME/Trash/files ~/.Trash


# config files {{{1

# root {{{2

sudo ln -sf ~/config/systemd/root/* /etc/systemd/system/

sudo ln -sf ~/config/root/tmp.conf /etc/tmpfiles.d/

sudo cp ~/config/root/blueman_policykit /etc/polkit-1/rules.d/90-blueman.rules

# regular {{{2

mkdir -p $XDG_CONFIG_HOME/systemd/user
ln -sf ~/config/systemd/user/* $XDG_CONFIG_HOME/systemd/user/

ln -sf ~/config/dotfiles/* ~/

mkdir -p ~/.local/share/applications/
ln -sf ~/{config/,}.local/share/applications/alacritty.desktop

# .config {{{3

cp -f ~/config/.config/mimeapps.list $XDG_CONFIG_HOME

function symlink-dot-config {
	mkdir -p ~/.config/"$@"
	ln -sf ~/config/.config/"$@"/* ~/.config/"$@"
}

symlink-dot-config alacritty
symlink-dot-config git
symlink-dot-config gtk-2.0
symlink-dot-config gtk-3.0
symlink-dot-config mako
symlink-dot-config npm
symlink-dot-config opensnitch
symlink-dot-config readline
symlink-dot-config rofi
symlink-dot-config sway
symlink-dot-config swaylock
symlink-dot-config variety
symlink-dot-config waybar
symlink-dot-config xonsh


# rust {{{1

rustup set profile complete
rustup install stable
rustup default stable


# AUR {{{1

# install yay-bin
bash <(curl https://raw.githubusercontent.com/cjbassi/aur-installer/master/aur-installer) yay-bin

yay -R --noconfirm vi

function yay {
	command yay -S --noconfirm --needed --mflags "--nocheck" "$@"
}

yay \
	pandoc-bin \
	rofi-dmenu \
	sccache-bin

yay \
	cht.sh \
	earlyoom \
	evscript-git \
	git-extras-git \
	google-chrome \
	imgurbash2-git \
	insync1 \
	ncurses5-compat-libs \
	nerd-fonts-complete \
	network-manager-applet-indicator \
	networkmanager-dmenu \
	pkghist-bin \
	python-pipx \
	raven-reader-bin \
	redshift-wayland-git \
	spotify \
	swaylock-blur-bin \
	teiler-git \
	texlive-latexindent-meta \
	tmpreaper \
	udiskie-dmenu-git \
	ytop-bin

# TODO
# loop
# opensnitch-git


# application configuration {{{1

# spacemacs {{{1

git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

# package managers {{{1

fundle install

pipx install colour-valgrind
pipx install grip
pipx install wpm
pipx install xtermcolor
pipx install --spec git+https://github.com/cjbassi/rofi-power rofi-power
pipx install --spec git+https://github.com/cjbassi/rofi-copyq rofi-copyq
pipx install --spec git+https://github.com/cjbassi/rofi-files rofi-files

yarn global add \
	typesync \
	create-react-app

trust_install_url="https://raw.githubusercontent.com/japaric/trust/c268696ab9f054e1092f195dddeead2420c04261/install.sh"
function trust-download {
	bash <(curl $trust_install_url) -f --git "$@"
}
trust-download cjbassi/batch-rename
trust-download cjbassi/license-gen
trust-download cjbassi/sway-utils
trust-download cjbassi/trash-cli

# TODO
# cargo-edit
# cargo-update
# loop
# dua-cli
# delta
# cargo-tree


# systemd {{{1

systemctl --user enable \
	blueman-applet \
	copyq \
	earlyoom \
	evscript \
	insync \
	kdeconnect-indicator \
	mako \
	nm-applet \
	opensnitch-ui \
	pasystray \
	recover-youtube-videos.timer \
	redshift-gtk \
	element-desktop \
	swayidle \
	udiskie \
	variety \
	waybar

sudo systemctl enable \
	kill-sshfs-on-suspend \
	lockscreen-on-suspend@$USER \
	reload-settings-on-wake@$USER \
	\
	bluetooth \
	docker \
	NetworkManager \
	opensnitchd \
	systemd-timesyncd

# disables tmpfs
sudo systemctl mask tmp.mount

# tlp (battery improvements)
sudo systemctl enable tlp
sudo systemctl enable tlp-sleep
sudo systemctl mask system-rfkill
sudo systemctl mask system-rfkill.socket


# Cleanup {{{1

rm -f .bash_logout .bash_profile .bashrc install3.sh
