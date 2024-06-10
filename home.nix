{ config, pkgs, ... }:

{
  home.username = "mead";
  home.homeDirectory = "/home/mead";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "starship"; src = pkgs.fishPlugins.starship.src; }
    ];
  };



  home.packages = [
  ];


  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
