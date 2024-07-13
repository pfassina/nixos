{...}: let
  custom = {
    font = "FiraCode Nerd Font";
    font_size = "15px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    opacity = "0.98";

    fg = "#E1E1E1";
    bg = "#151515";
    accent = "#202020";
    white = "#E1E1E1";
    gray = "#373737";
    medium_gray = "#727272";
    light_gray = "#AFAFAF";
    blue = "#BAD7FF";
    gray_blue = "#7E97AB";
    medium_gray_blue = "#A2B5C1";
    cyan = "#88afa2";
    red = "#b46958";
    green = "#90A959";
    yellow = "#F4BF75";
    orange = "#FFA557";
    purple = "#AA749F";
    magenta = "#AA759F";
    accent_blue = "#191a20";
    accent_green = "#1c2019";
    accent_red = "#201919";
  };
in {
  programs.waybar.style = ''

    * {
        border: none;
        border-radius: 0px;
        padding: 0;
        margin: 0;
        min-height: 0px;
        font-family: ${custom.font};
        font-weight: ${custom.font_weight};
        opacity: ${custom.opacity};
    }

    window#waybar {
        background: none;
    }

    #workspaces {
        font-size: 18px;
        padding-left: 15px;
        background: ${custom.bg};
    }
    #workspaces button {
        color: ${custom.medium_gray};
        padding-left:  6px;
        padding-right: 6px;
    }
    #workspaces button.empty {
        color: ${custom.gray};
    }
    #workspaces button.active {
        color: ${custom.fg};
    }

    #tray, #pulseaudio, #network, #cpu, #memory, #disk, #clock, #battery {
        font-size: ${custom.font_size};
        color: ${custom.medium_gray};
        background: ${custom.bg};
    }

    #cpu {
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #memory {
        padding-left: 9px;
        padding-right: 9px;
    }
    #disk {
        padding-left: 9px;
        padding-right: 15px;
    }

    #tray {
        padding: 0 20px;
        margin-left: 7px;
    }

    #pulseaudio {
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #battery {
        padding-left: 9px;
        padding-right: 9px;
    }
    #network {
        padding-left: 9px;
        padding-right: 30px;
    }

    #clock {
        padding-left: 9px;
        padding-right: 15px;
    }

  '';
}
