{...}: let
  wp_path = "~/nix/home/wallpapers/dave-herring-JYfTBagJf2U-unsplash.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = ["${wp_path}"];

      wallpaper = [
        ",${wp_path}"
      ];
    };
  };
}
