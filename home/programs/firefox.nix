{ pkgs, ... }:

{

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
  
  home.file = {
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

}
