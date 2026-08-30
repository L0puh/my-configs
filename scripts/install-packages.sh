#!/bin/bash


# in case i need to reinstall arch again 


packages=(
    acpi # battery/ac status monitoring
    alsa-utils # alsa sound utilities
    amd-ucode # amd cpu microcode updates
    base # core arch linux system
    base-devel # development tools (gcc, make, etc.)
    brightnessctl # screen brightness control
    btop # resource monitor (beautiful)
    dunst # notification daemon
    efibootmgr # efi boot manager configuration
    fastfetch # system info tool (neofetch alternative)
    feh # image viewer & wallpaper setter
    fontconfig # font configuration library
    freetype2 # font rendering engine
    fzf # fuzzy finder
    git # version control
    grub # bootloader
    happ # hardware accelerated text rendering
    krita # digital painting/drawing
    less # terminal pager
    libnotify # desktop notifications
    libxft # x11 freetype font rendering
    libxinerama # x11 multi-monitor support
    linux # linux kernel
    linux-firmware # firmware for various hardware
    lxappearance # gtk theme customization
    materia-gtk-theme # gtk theme (material design)
    mesa # opengl/vulkan drivers
    mpv # video player
    neovim # modern vim fork
    networkmanager # network connection manager
    nodejs # javascript runtime
    npm # node package manager
    openssh # secure shell client/server
    pavucontrol # pulseaudio volume control gui
    perf # performance analysis tools
    pulseaudio # sound server
    pulseaudio-alsa # alsa <-> pulseaudio bridge
    pulseaudio-bluetooth # bluetooth audio support
    python-pynvim # python client for neovim
    qutebrowser # keyboard-driven browser
    ranger # terminal file manager with preview
    reflector # arch mirror list updater
    ripgrep # fast grep replacement
    rust # rust programming language
    strace # system call tracer
    sudo # privilege escalation
    sysstat # system performance tools (mpstat, etc.)
    tlp # advanced power management
    tlp-rdw # tlp radio device wizard
    tree # directory tree visualizer
    ttf-cascadia-code # cascadia code monospace font
    ttf-cascadia-code-nerd # cascadia code with nerd font icons
    ttf-hack # hack monospace font
    ueberzugpp # image previews in terminal
    unzip # zip archive extractor
    upower # power/device monitoring
    vim # classic vim editor
    vulkan-radeon # vulkan for amd gpus
    wget # command-line downloader
    xclip # clipboard manager
    xf86-video-amdgpu # amd gpu xorg driver
    xfce4-screenshooter # screenshot tool
    xorg-server # x11 display server
    xorg-xinit # x11 init scripts
    xorg-xrandr # screen resolution/rotation tool
    xorg-xsetroot # root window customization
    yay # aur helper
    z-git # directory jumper (z)
    zaread-git # read-only zfs dataset lister
    zathura # document viewer (pdf/ps)
    zathura-pdf-mupdf # pdf plugin for zathura
    zsh # z shell
    zsh-autosuggestions # command suggestions for zsh
    zsh-completions # additional zsh completions
    zsh-syntax-highlighting # syntax highlighting in zsh
)

install_packages() {
    echo "Installing packages..."
    for pkg in "${packages[@]}"; do
        pkg_name="${pkg%% #*}"
        pkg_desc="${pkg##*# }"
        
        echo " -> installing: $pkg_name ($pkg_desc)"
        sudo pacman -S --needed --noconfirm "$pkg_name"
    done
    echo "all packages installed!"
}

install_packages
