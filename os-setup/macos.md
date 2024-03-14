# MacOS Setup

### Table of Contents

## General Settings

- Reorder app window (5 finger pinch window)
- dock order
- System Settings/Preferences > Search for "Spaces" > Uncheck Automatically rearrange Spaces based on most recent use to prevent spaces from being ordered automatically

## Ricing

### Fonts

- [nerd fonts](https://github.com/ryanoasis/nerd-fonts)
- https://www.nerdfonts.com/font-downloads
- [symbols only](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip)
- [monoid](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Monoid.zip)
- see iterm settings for fonts used etc

### Backgrounds

## Desktop Applications

Please see the following list of 3rd party desktop applications 

- [iTerm](https://iterm2.com)
- [VSCode](https://code.visualstudio.com)
- [Godot](https://godotengine.org/)
- [Aseprite](https://www.aseprite.org/) (see steam library)
- [Steam](https://store.steampowered.com/)
- [Chrome](https://www.google.com/intl/en_uk/chrome/dr/download/?brand=IBEF&ds_kid=43700074514338882&gclid=EAIaIQobChMIvaf4zbbNgwMVqZhQBh1sCQT0EAAYASAAEgIylPD_BwE&gclsrc=aw.ds)
- [Firefox](https://www.mozilla.org/en-GB/firefox/new/)
- [Opera](https://www.opera.com/)
- [Obsidian](https://obsidian.md)
- [Notion](https://www.notion.so)
- [Notion Calender](https://www.notion.so/product/calendar)
- [Spotify](https://www.spotify.com/de-en/download/other/)
- [WhatsApp](https://www.whatsapp.com/download)
- [Discord](https://discord.com/download)
- [Libre Office](https://www.libreoffice.org/)
- [Zettlr](https://www.zettlr.com/)
- [Typora](https://typora.io/)
- [Loom](https://www.loom.com/)
- [Local Send](https://localsend.org/#/)
- [Gantt Project](https://www.ganttproject.biz/)

(take note of application organisation in launcher - all apps organised on one page, using groups, and most important apps listed independently)

### iTerm Configuration

- [iTerm colour schemes](https://iterm2colorschemes.com)
- Set fish as default shell
- see iterm settings for current settings

## Terminal Applications

- [homebrew](https://brew.sh)
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
- [btop](https://github.com/aristocratos/btop)

### Brew Notes

- https://docs.brew.sh
- https://apple.stackexchange.com/questions/148901/why-does-my-brew-installation-not-work
- Install nvm using brew, not using the curl script on the github
- https://tecadmin.net/install-nvm-macos-with-homebrew/
- install git using homebrew 

### Vim Configuration

See ~/.vimrc and ~/.vim for vim configuration

### Fish Configuration

- https://fishshell.com
- https://github.com/IlanCosman/tide
- https://github.com/jorgebucaran/fisher
- `~/.config/fish/config.fish` for standard configuration
- `~/.config/fish/functions/fish_greeting.fish` for greeting on startup

### XCode Suite

- avoid installing xcode command line tools, prefer installing only required tools (git, python, pip etc.) using homebrew
- https://forums.developer.apple.com/forums/thread/677124

### Git

- see `~/.gitconfig` core.excludesfile field and `~/.gitignore` file for global ignore of OS generated .DS_Store files such that repos do not individually need to ignore these platform-specific files (https://dev.to/lpheller/quickly-ignore-dsstore-files-globally-ecd)

- https://medium.com/codex/git-credentials-on-macos-caching-updating-and-deleting-your-git-credentials-8d22b6126533
- not sure if store is usable as a credentials store in git
- Removing DS Store files from repositories, either use:
    - Entry in gitignore file for each repository
    - Entry in global gitignore file or git config file, since no ds store files should be included in any repository
    - https://www.reddit.com/r/git/comments/vsfa6j/stupid_ds_store_files/
    - https://www.vintageisthenewold.com/faq/how-to-ignore-a-ds-store-file
    - https://stackoverflow.com/questions/107701/how-can-i-remove-ds-store-files-from-a-git-repository
    - https://stackoverflow.com/questions/18393498/gitignore-all-the-ds-store-files-in-every-folder-and-subfolder

- gpg signing issue with pinentry:
    - https://superuser.com/questions/520980/how-to-force-gpg-to-use-console-mode-pinentry-to-prompt-for-passwords
    - https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e
    - https://heywoodlh.io/change-gpg-agent-program
    - https://github.com/gopasspw/gopass/issues/1879

~/.gnupg/gpg-agent.conf
```bash
pinentry-program /opt/homebrew/bin/pinentry-curses
```

run `export GPG_TTY=$(tty)` to allow gpg and/or git to open tty "window" in terminal for pinentry, otherwise pinentry program automatically cancels operation, and signing fails

add this export to bashrc or zshrc file etc. to set this variable every time a new terminal instance opens... in the case of fish, the export line `export GPG_TTY=$(tty)` should be included in the `~/.config/fish/config.fish` file:
- https://askubuntu.com/questions/33845/how-to-add-exports-to-fish-like-in-bashrc

alternatively point gpg-agent to pinentry-mac for a graphical overlay for gpg pin entry if the above is not working

### GPG

- configure gpg password cache and timeout etc?
- gpg-agent issue:
    - https://gpgtools.tenderapp.com/discussions/problems/12650-agent-not-working-when-specifying-a-non-standard-home-directory

#### Socket Location

- https://askubuntu.com/questions/777900/how-to-configure-gnupgs-s-gpg-agent-socket-location

`/Volumes/MOUNTED_VOLUME/path/to/keyring/S.gpg-agent`
```bash
%Assuan%
socket=/Users/james/.gnupg-usb/S.gpg-agent
```

`/Volumes/MOUNTED_VOLUME/path/to/keyring/S.gpg-agent.ssh`
```bash
%Assuan%
socket=/Users/james/.gnupg-usb/S.gpg-agent.ssh
```

`/Volumes/MOUNTED_VOLUME/path/to/keyring/gpg-agent.conf`
```bash
extra-socket /Users/james/.gnupg-usb/S.gpg-agent.extra
browser-socket /Users/james/.gnupg-usb/S.gpg-agent.browser
```

#### Keychain Symlink

- see script at ~/.gnupg-usb/gpg-link.sh
- https://stackoverflow.com/questions/3560326/how-to-make-a-shell-script-global 

## Config Files

See `.files-plus` repository on [personal github](https://github.com/jimbob3806/.files-plus)

- `~/.vimrc`
- `~/.gitconfig`
- `~/.gitmessage`

## Volumes

- https://brianboyko.medium.com/a-case-sensitive-src-folder-for-mac-programmers-176cc82a3830
- case sensitive volumes for programming projects
- use `kebab-case` for naming internal volumes
- use `SNAKE_CASE` for naming external drives such as usb sticks to differentiate between volumes in the /Volumes dir
- may use internal documents folder (case-insensitive, but preseving for programming, especially given that scripts are case sensitive, so even if a file is mis-named, the error will be obvious when a script cannot import it, and scripts should not be ambiguously named with different cases in the same directory anyway)
