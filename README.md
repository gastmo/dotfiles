### Aliases and Functions are usually in:
    aliasrc
    bashrc
    zshrc


### Fresh Install Info
    sudo pacman -S git stow
    cd ~
    git clone https://github.com/gastmo/dotfiles.git
    mkdir -p ~/Downloads/stowbackup
    mv ~/.bashrc ~/Downloads/stowbackup
    # symlink all files in dotfiles dir to home dir
    cd ~/dotfiles
    
    # link only folders (trailing slash)
    stow -v -t ~ */
        # delete (-D flag)
        stow -v -D -t ~ */
        stow -v -D -t ~ tmux
        # redo link (-R)
        stow -v -R -t ~ */
        stow -v -R -t ~ tmux
    sudo pacman -S zsh zsh-completions
    chsh -s /usr/bin/zsh
    cd ~/Public/dotfiles/zshrc
    git clone https://github.com/robbyrussell/oh-my-zsh.git
    

### Essentials
    atool coreutils curl gvfs htop less mlocate moreutils ranger tmux util-linux vim wget

### CLI
    cmatrix cmus ffmpeg mutt ncdu surfraw w3m xclip youtube-dl
   
### GUI
    mplayer mpv parcellite 

### Other
    wicd-curses
    trash-cli
    urlview 
    cava

    

### Arch AUR Specific
    fasd fzf mountie 


