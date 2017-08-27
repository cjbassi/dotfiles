rm -f arch3.sh

# Directories
mkdir -p Downloads
mkdir -p .ssh
mkdir -p .config
mkdir -p ~/.config/nvim/{backup,undo,swap}
mkdir -p ~/.config/ranger

sudo mount -L KEYS /mnt/usb

# ssh keys
cp /mnt/usb/ssh/* /home/cjbassi/.ssh/
chmod 700 /home/cjbassi/.ssh
chmod 600 /home/cjbassi/.ssh/id_ed25519
chmod 644 /home/cjbassi/.ssh/id_ed25519.pub
chmod -x /home/cjbassi/.ssh/known_hosts

# gpg keys
#TODO
gpg --import /mnt/usb/gnupg/privkey.asc

git clone git@github.com:cjbassi/config

################################################################################
# Symlinks

sudo ln -sf ~/config/i3lock/suspend@.service /etc/systemd/system/

sudo ln -sf ~/config/peripherals/50-mouse.conf /etc/X11/xorg.conf.d/

ln -sf ~/config/devilspie ~/.devilspie

ln -sf ~/config/dotfiles/.* ~/

ln -sf ~/config/i3 ~/.config/i3

ln -sf ~/config/nvim/* ~/.config/nvim/

ln -sf ~/config/polybar ~/.config/polybar

ln -sf ~/config/ranger/* ~/.config/ranger/

ln -sf ~/config/rofi ~/.config/rofi

ln -sf ~/config/termite  ~/.config/termite

ln -sf ~/config/mutt ~/.mutt

################################################################################

ranger --copy-config=scope
# TODO
        # try safepipe highlight --config-file=/home/cjbassi/config/highlight/custom-solarized-dark.theme -s custom-solarized-dark --out-format=${highlight_format} "$path" && { dump | trim; exit 5; }

# TODO
pactl set-source-volume 1 100%

sudo systemctl enable suspend@cjbassi

sudo systemctl enable bluetooth


# vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo '
# automatically switch to newly-connected devices
load-module module-switch-on-connect' | sudo tee -a /etc/pulse/default.pa

################################################################################

cd Downloads
git clone https://github.com/rkitover/vimpager
cd vimpager
sudo make install
cd ..
rm -rf vimpager
cd ~

cd Downloads
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
rm -rf fonts
cd ~

################################################################################

sudo pip install glances
sudo pip3 install --upgrade neovim

################################################################################

bash ~/config/arch/pacaur.sh

export EDITOR=nvim
gpg --recv-keys 5FAF0A6EE7371805

pacaur -S --noconfirm --noedit discord
pacaur -S --noconfirm --noedit dropbox
pacaur -S --noconfirm --noedit google-chrome
pacaur -S --noconfirm --noedit neofetch
pacaur -S --noconfirm --noedit unclutter-xfixes-git
pacaur -S --noconfirm --noedit universal-ctags-git
pacaur -S --noconfirm --noedit zsh-fast-syntax-highlighting-git

pacaur -S --noconfirm --noedit neomutt
pacaur -S --noconfirm --noedit neomutt

pacaur -S --noconfirm --noedit i3-gaps
pacaur -S --noconfirm --noedit i3lock-color-git

pacaur -S --noconfirm --noedit gitflow-avh
pacaur -S --noconfirm --noedit gitflow-zshcompletion-avh

pacaur -S --noconfirm --noedit polybar-git

################################################################################

# check that mutt can't source encryped on next install without keys

echo "
###########################################
1) Wi-Fi
2) Login to Chrome
3) Login to Dropbox
4) Vim plugins
5) Pair headphones
###########################################
"
