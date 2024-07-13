{
  pkgs,
  inputs,
  ...
}: {
  imports =
    import ./shell
    ++ import ./programs
    ++ import ./desktop;

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
    hyprpicker
    hyprcursor
    mako
    wl-clipboard
    wofi

    # utilities
    bitwarden
    btop
    fastfetch
    feh
    flameshot # screenshot
    libqalculate
    qalculate-gtk

    # gaming
    mangohud
    protonup
    discord
    lutris
    bottles
    wineWowPackages.waylandFull

    # others
    adwaita-icon-theme
  ];

  gtk = {
    enable = true;
  };

  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  programs = {
    home-manager.enable = true;
    # hyprcursor-phinger.enable = true;
    lazygit.enable = true;
    git = {
      enable = true;
      userName = "pfassina";
      userEmail = "git@fassina.me";
    };
  };
}
