{...}: {
  programs.kitty = {
    enable = true;

    environment = {
      "LS_COLORS" = "1";
    };

    font = {
      name = "FiraCode Nerd Font Mono";
      size = 12;
    };

    settings = {
      # colors

      foreground = "#e1e1e1";
      background = "#151515";
      selection_foreground = "#e1e1e1";
      selection_background = "#5e5e5e";
      cursor = "#e1e1e1";

      color0 = "#202020";
      color1 = "#ac4142";
      color2 = "#88afa2";
      color3 = "#f4bf75";
      color4 = "#73c0ff";
      color5 = "#aa759f";
      color6 = "#5f9ea0";
      color7 = "#d0d0d0";
      color8 = "#555555";
      color9 = "#cd5c5c";
      color10 = "#90a959";
      color11 = "#ffdead";
      color12 = "#a5d6ff";
      color13 = "#cf75bc";
      color14 = "#75b5aa";
      color15 = "#e1e1e1";

      enable_audio_bell = false;
    };
  };
}
