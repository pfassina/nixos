{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    firmware = [
      (pkgs.stdenvNoCC.mkDerivation (final: {
        name = "brcm-firmware";
        src = ./firmware.tar;
        dontUnpack = true;
        installPhase = ''
           mkdir -p $out/lib/firmware/brcm
          tar -xf ${final.src} -C $out/lib/firmware/brcm
        '';
      }))
    ];
  };

  services = {
    getty.autologinUser = "mead";
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
    fish.enable = true;
    nix-ld.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  users.users.mead = {
    isNormalUser = true;
    description = "mead";
    extraGroups = ["networkmanager" "wheel" "gamemode"];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    users = {
      "mead" = import ./home;
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
    systemPackages = with pkgs; [
      git
      gh
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  system.stateVersion = "24.11";
}
