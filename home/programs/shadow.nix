{
  inputs,
  pkgs,
  ...
}: let
  shadowPreloadScript = pkgs.writeText "shadow-preload.sh" ''
    #!/run/current-system/sw/bin/bash

    # Preload system libraries as much as possible
    NO_RUNTIME=1

    P=/usr/share/shadowpc/__CHANNEL__/app.asar/release/native/
    mapfile -t < <(find $P -name "*.so*" \
                           -not \( -name "libsentry.so" -or \
                                   -name "*libh2645bitstream.so" -or \
                                   -name "*libcef.so" \) \
                            -exec basename {} \; ) LIBS
    declare -A preload
    for LIB in "''${LIBS[@]}"; do
        if [[ -f "/usr/lib/''${LIB}" ]] || [[ -h "/usr/lib/''${LIB}" ]]; then
        preload+="/usr/lib/''${LIB}:"
        continue
        elif [[ -f "/lib/''${LIB}" ]] || [[ -h "/lib/''${LIB}" ]]; then
        preload+="/lib/''${LIB}:"
        continue
        elif [[ -f "/usr/lib/x86_64-linux-gnu/''${LIB}" ]] || [[ -h "/usr/lib/x86_64-linux-gnu/''${LIB}" ]]; then
        preload+="/usr/lib/x86_64-linux-gnu/''${LIB}:"
        continue
        else
        echo "''${LIB} was not found. Skipping."
        continue
        fi
    done
    export LD_PRELOAD="''${preload%?}"
  '';

  shadowWrapper = pkgs.writeScriptBin "shadow-wrapper" ''
    #!/run/current-system/sw/bin/bash
    source ${shadowPreloadScript}
    exec shadow-preprod "$@"
  '';
in {
  imports = ["${inputs.shadow-nix}/import/home-manager.nix"];

  programs.shadow-client = {
    channel = "preprod";
  };

  home.packages = [shadowWrapper];

  # Update your Rofi configuration to include the wrapped Shadow Client
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = true;
    };
    theme = "Arc-Dark";
  };

  # Create a .desktop file for Rofi to find
  home.file.".local/share/applications/shadow-client-wrapped.desktop".text = ''
    [Desktop Entry]
    Name=Shadow Client (Wrapped)
    Exec=${shadowWrapper}/bin/shadow-wrapper
    Icon=shadow-client
    Type=Application
    Categories=Game;
  '';
}
