{pkgs, ...}: {
  imports =
    import ./shell
    ++ import ./programs;

  home = {
    username = "mead";
    homeDirectory = "/home/mead";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
  };

  # wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [
    # terminal
    kitty
    bat
    fzf
    grc
    ueberzugpp
    yazi
    wget
    tmux

    # neovim
    openssl
    ripgrep

    # wayland
    dunst
    hypridle
    hyprlock
    hyprpaper
    waybar
    wl-clipboard
    wofi

    # (waybar.override {wireplumberSupport = false;})

    # utilities
    bitwarden
    btop
    fastfetch
    feh
    flameshot # screenshot
    libqalculate
    qalculate-gtk
    variety
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "pfassina";
      userEmail = "git@fassina.me";
    };
  };
}
