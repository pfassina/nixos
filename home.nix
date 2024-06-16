 { config, pkgs, inputs,... }:

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

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
      };
      userChrome = ''
        @import 'cascade/chrome/includes/cascade-config.css';
        @import 'cascade/chrome/includes/cascade-colours.css';

        @import 'cascade/chrome/includes/cascade-layout.css';
        @import 'cascade/chrome/includes/cascade-responsive.css';
        @import 'cascade/chrome/includes/cascade-floating-panel.css';

        @import 'cascade/chrome/includes/cascade-nav-bar.css';
        @import 'cascade/chrome/includes/cascade-tabs.css';

        @import 'cascade/integrations/tabcenter-reborn/cascade-tcr.css';

        :root {
          --uc-urlbar-min-width: 0vw !important;
          --uc-urlbar-max-width: 100vw !important;s
        }
      '';
    };
  };


  home.packages = [
  ];


  home.file = {
    ".background-image".source = ./modules/home-manager/bg.jpg;
    ".xprofile".text = "/run/current-system/sw/bin/slstatus &";
    "firefox/cascade" = {
      recursive = true;
      target = ".mozilla/firefox/default/chrome/cascade";
      source = (pkgs.fetchFromGitHub {
        owner = "cascadefox";
        repo = "cascade";
        rev = "8fbe98934fa58f934f7ed5253367396519b320a4";
        sha256 = "0k7g4aijc8gz1941a791qdbqfcc3wlwlvfn70nzxp14jssjd5i8q";
      });
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
