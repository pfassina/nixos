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
    kernelModules = ["uinput"];
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
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau
        intel-media-driver
      ];
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
    blueman.enable = true;
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
    udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="input, OPTIONS+="static_node=shadow-input"
    '';
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

  nixpkgs.config = {
    allowUnfree = true;
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
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

  users = {
    groups = {shadow-input = {};};
    users.mead = {
      isNormalUser = true;
      description = "mead";
      extraGroups = [
        "networkmanager"
        "wheel"
        "audio"
        "video"
        "gamemode"
        "shadow-input"
        "input"
      ];
      shell = pkgs.fish;
    };
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
      libva-utils
      nix-prefetch-git
      efibootmgr
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  system.stateVersion = "24.11";
}
