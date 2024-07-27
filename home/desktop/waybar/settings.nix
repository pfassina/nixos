{...}: {
  programs.waybar.settings.mainBar = {
    position = "top";
    layer = "top";
    height = 5;
    margin-top = 5;
    margin-bottom = 0;
    margin-left = 5;
    margin-right = 5;
    modules-left = [
      "hyprland/workspaces"
    ];
    modules-right = [
      "battery"
      "pulseaudio"
      "network"
      "clock"
    ];
    clock = {
      calendar = {
        format = {today = "<span color='#b4befe'><b><u>{}</u></b></span>";};
      };
      format = " {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "󰈹";
        "2" = "";
        "3" = "󰘙";
        "4" = "󰙯";
        "5" = "";
        urgent = "";
        default = "";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };
    network = {
      format-wifi = " {signalStrength}%";
      format-ethernet = "󰀂";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = " {volume}%";
      format-icons = {
        default = [""];
      };
      scroll-step = 5;
      on-click = "pamixer -t";
    };
    battery = {
      format = "{icon} {capacity}%";
      format-icons = ["" "" "" "" ""];
      format-charging = " {capacity}%";
      format-full = " {capacity}%";
      format-warning = " {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
  };
}
