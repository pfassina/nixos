 { config, pkgs, ... }:

{
  home.username = "mead";
  home.homeDirectory = "/home/mead";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
  }; 

  services.picom.enable = true;


  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "forgit"; src = pkgs.fishPlugins.forgit.src; }
    ];
  };


  programs.starship = {
    enable = true;
  };


  home.packages = [
  ];


  home.file = {
    ".background-image".source = ./modules/home-manager/bg.jpg;
    ".xprofile".text = "/run/current-system/sw/bin/slstatus &";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
