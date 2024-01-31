# Linux Ubuntu Setup

### Table of Contents

## General Settings

Note that the terminal, desktop etc. applications listed below may not include *all* apps etc. installed on the previous ubuntu setup, and will definitely *not* include build tools such as cmake, ninja, meson, g++ etc. which may be required to build certain applications. In these cases, the user should install build tools as required/as prompted by the install process of a given desired application. To view an approximate list of all manually installed apps on the existing ubuntu setup, run `apt-mark showmanual`.

## Ricing

### Fonts

- [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
- https://www.nerdfonts.com/font-downloads
- [symbols only](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip)
- [monoid](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Monoid.zip)
- see `gnome-terminal` settings for fonts used etc

### Backgrounds

## Desktop Applications

Please see the following list of 3rd party desktop applications 

- [VSCode](https://code.visualstudio.com)
- [Godot](https://godotengine.org/)
- [Aseprite](https://www.aseprite.org/) (see steam library)
- [Steam](https://store.steampowered.com/)
- [Chrome](https://www.google.com/intl/en_uk/chrome/dr/download/?brand=IBEF&ds_kid=43700074514338882&gclid=EAIaIQobChMIvaf4zbbNgwMVqZhQBh1sCQT0EAAYASAAEgIylPD_BwE&gclsrc=aw.ds)
- [Firefox](https://www.mozilla.org/en-GB/firefox/new/)
- [Spotify](https://www.spotify.com/de-en/download/other/)
- [Discord](https://discord.com/download)
- [Libre Office](https://www.libreoffice.org/)
- [Zettlr](https://www.zettlr.com/)
- [Typora](https://typora.io/)
- [gimp](https://www.gimp.org/)

### Terminal Configuration

- set colors to gruvbox hard
- Set fish as default shell

## Repo Applications

These are applications which are downloaded from a repo or tar file, and then must be unzipped and/or built. The build process may include automatically adding the appimage etc. to the path, or alternatively (e.g. for obsidian, factorio, blender etc.) you may have to manually add the program to the path, or symlink the appimage etc. to a location in `/usr/bin` (e.g. the obsidian appimage is symlinked to `/usr/bin/obsidian`). All these repos (either repos or unzipped directories) should be stored under `~/.repos`.

- [Factorio](https://www.factorio.com/)
- [Blender](https://www.blender.org/)
- [Obsidian](https://obsidian.md)
- [btop](https://github.com/aristocratos/btop)
- [picom](https://github.com/yshui/picom)
- [polybar](https://github.com/polybar/polybar)

## Terminal Applications

- [git](https://formulae.brew.sh/formula/git)
- [fish shell](https://fishshell.com)
    - [see here](https://fishshell.com/docs/current/cmds/alias.html) for setting up aliases for common commands eg `gc` for ` git commit`
    - see `~/.config/fish` for configuration
- [node](https://nodejs.org/en/download)
- [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
- [nvm for fish](https://github.com/jorgebucaran/nvm.fish)
- [rust](https://www.rust-lang.org/tools/install)
- [tokei](https://github.com/XAMPPRocky/tokei)
- [neofetch](https://github.com/dylanaraps/neofetch)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [fzf keybindings for fish](https://github.com/PatrickF1/fzf.fish)
- [exa](https://github.com/ogham/exa)
- [fd](https://github.com/sharkdp/fd)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [http-server](https://www.npmjs.com/package/http-server)
- [tmux](https://github.com/tmux/tmux/wiki)
    - [see here](https://jeongwhanchoi.medium.com/install-tmux-on-osx-and-basics-commands-for-beginners-be22520fd95e) for information on basic usage
    - consider configuration (see `~.tmux.conf`)
- [feh](https://github.com/derf/feh)
- [python3](https://www.python.org/downloads/)
- [rofi](https://github.com/davatorium/rofi)
- [i3](https://github.com/i3/i3)
    - https://i3wm.org/
    - https://i3wm.org/docs/
    - please see [i3-gaps](https://github.com/Airblader/i3) but note that all features in i3 gaps are now in i3

### Vim Configuration

See ~/.vimrc and ~/.vim for vim configuration

### Fish Configuration

- https://fishshell.com
- https://github.com/IlanCosman/tide
- https://github.com/jorgebucaran/fisher
- `~/.config/fish/config.fish` for standard configuration
- `~/.config/fish/functions/fish_greeting.fish` for greeting on startup

### Git

- see `~/.gitconfig` for gitconfig including git signing key, and ensuring that commits etc. are signed by default

### GPG

- configure gpg password cache and timeout etc?

## Config Files

See `.files-plus` repository on [personal github](https://github.com/jimbob3806/.files-plus)

- `~/.vimrc`
- `~/.gitconfig`
- `~/.gitmessage`
- `~/.config/i3`
- `~/.config/fish`
- `~/.config/picom`
- `~/.config/polybar`

## Other Configurations

### Udev Rules

Udev rules are stored under `/etc/udev/rules.d`. The file `/etc/udev/rules.d/50-wake-on-device.rules` is responsible for enabling/disabling sleep and wake from devices such as usb mice and keyboards. Bluetooth dongle mice seem to cause a problem with sleep, causing the machine to wake again immediately if the device is left l=plugged in, therefore a rule must be created to prevent the mouse from waking the machine:

- https://askubuntu.com/questions/252743/how-do-i-prevent-mouse-movement-from-waking-up-a-suspended-computer
- https://bbs.archlinux.org/viewtopic.php?id=284618
- https://wiki.archlinux.org/title/udev#Waking_from_suspend_with_USB_device

As a general rule, follow the steps below to prevent wake on device:

1. Run `lsusb`, or `lsusb | grep <device>` where `<device>` could be some identifiable brand etc. of the device which is causing sleep issues.
2. Get vendor and product id from response: `Bus 001 Device 019: ID idVendor:idProduct Logitech, Inc. 4-port USB 2.0 Hub`
    1. e.g. in `Bus 001 Device 019: ID 046d:c547 Logitech, Inc. 4-port USB 2.0 Hub`, `046d` is the vendor id, and `c547` is the product id
3. Add the following line to `/etc/udev/rules.d/50-wake-on-device.rules` (create file if not exists): `ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTR{idVendor}=="045d", ATTR{idProduct}=="c547, ATTR{power/wake}="disabled"` (note `ATTR` *not* `ATTRS`, and *single* equal on `power/wake` for assignment)
4. Replug usb device and test
