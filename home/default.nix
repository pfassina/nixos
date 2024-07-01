{
  config,
  inputs,
  pkgs,
  ...
}: {
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

  home.packages = with pkgs; [
    # terminal
    bat
    fzf
    grc
    ueberzugpp
    yazi
    wget

    # neovim
    openssl
    ripgrep

    #desktop
    dmenu
    slstatus
    st

    # utilities
    bitwarden
    btop
    fastfetch
    feh
    flameshot # screenshot
    libqalculate
    qalculate-gtk
    variety
    xclip
  ];

  home.file = {
    ".background-image".source = ./wallpapers/tokyo_street_night.jpg;
    ".xprofile".text = "/home/mead/.nix-profile/bin/slstatus &";
  };

  programs.home-manager.enable = true;
}
