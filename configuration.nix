
{ config, pkgs, inputs,  ... }:


{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      displayManager.lightdm.enable = true;
      windowManager.dwm.enable = true;
    };
    xrdp = {
      enable = true;
      defaultWindowManager = "dwm";
      openFirewall = true;
    };
    getty.autologinUser = "mead";
    picom.enable = true;
    qemuGuest.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    git.enable = true;
    fish.enable = true;
    tmux.enable = true;
  };

  users.users.mead = {
    isNormalUser = true;
    description = "mead";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      "mead" = import ./home;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    gcc
    clang
    feh
    xclip
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  system.stateVersion = "24.05";

}
