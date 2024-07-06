{ pkgs, ... }:

{

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4307738/bitwarden_password_manager-2024.6.3.xpi";
            installation_mode = "force_installed";
          };
          "extension@tabliss.io" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3940751/tabliss-2.6.0.xpi";
            installation_mode = "force_installed";
          };
          "tabcenter-reborn@ariasuni" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3829515/tabcenter_reborn-2.3.1.xpi";
            installation_mode = "force_installed";
          };
        };
        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = false;
          "extensions.screenshots.enabled" = false;
          "browser.formfill.enable" = false;
        };
      };
    };
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
          --uc-urlbar-max-width: 100vw !important;
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
