{ config, inputs, pkgs, ... }:

{
  imports = 
    import ./shell
    ++ import ./programs
  ;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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

  home.file = {
    ".background-image".source = ./theme/bg.jpg
    ".xprofile".text = "/run/current-system/sw/bin/slstatus &";
  };

  programs.home-manager.enable = true;

}
