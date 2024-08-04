{pkgs, ...}: {
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
    spotify
    wireshark-cli
    obsidian

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
    theme = {
      name = "Graphite";
      package = pkgs.graphite-gtk-theme.override {
        tweaks = ["darker"];
      };
    };
    gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-themes=1'';
    gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-themes=1'';
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
