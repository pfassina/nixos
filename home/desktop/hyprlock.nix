{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          monitor = "";
          path = "~/nix/home/wallpapers/johannes-plenio-hvrpOmuMrAI-unsplash.jpg";
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "200, 50";
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;

          outer_color = "rgb(151515)";
          inner_color = "rgb(FFFFFF)";
          font_color = "rgb(10, 10, 10)";

          fade_on_empty = true;
          fade_timeout = 1000;

          placeholder_text = ''<i>Input Password...</i>'';
          hide_input = false;
          rounding = -1;

          check_color = "rgb(204, 136, 34)";
          fail_color = "rgb(204, 34, 34)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          fail_transition = 300;

          capslock_color = -1;
          numlock_color = -1;
          bothlock_color = -1;

          invert_numlock = false;
          swap_font_color = false;

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 55;
          font_family = "FiraCode Nerd Font";
          position = "-100, -40";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
      image = {
        monitor = "";
        path = "~/nix/home/wallpapers/user.jpg";
        size = 280;
        rounding = -1;
        border_size = 4;
        border_color = "rgb(221, 221, 221)";
        rotate = 0;
        reload_time = -1;
        position = "0, 200";
        halign = "center";
        valign = "center";
      };
    };
  };
}
