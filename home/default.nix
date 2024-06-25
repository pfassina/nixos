{ config, inputs, pkgs, ... }:

{
  imports = 
    import ./shell
    ++ import ./programs
  ;

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
    # neovim
    openssl
    ripgrep
    st
    wget

    #desktop
    dmenu
    slstatus

    # utilities
    bitwarden
    btop
    fastfetch
    feh
    flameshot      # screenshot
    libqalculate
    qalculate-gtk
    ranger
    variety
    xclip
  ];

  home.file = {
    ".background-image".source = ./wallpapers/bg.jpg;
    ".xprofile".text = "/home/mead/.nix-profile/bin/slstatus &";
  };

  programs.home-manager.enable = true;

}
