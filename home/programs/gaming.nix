{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      mangohud
      protonup
      discord
      lutris
      bottles
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
