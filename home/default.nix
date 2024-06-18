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
    st
    dmenu
    slstatus
    neovim
    bitwarden
    libqalculate
    qalculate-gtk
    fastfetch
    btop
    ripgrep
    grc
    fzf
    starship
    ranger
  ];

  home.file = {
    ".background-image".source = ./wallpapers/bg.jpg;
    ".xprofile".text = "/home/mead/.nix-profile/bin/slstatus &";
  };

  programs.home-manager.enable = true;

}
