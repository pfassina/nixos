# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    displayManager.lightdm.enable = true;
    windowManager.dwm.enable = true;
  };

  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = [
    ./modules/dwm/dwm-statuspadding-6.3.diff
    ./modules/dwm/dwm-alpha-20230401-348f655.diff
    ./modules/dwm/dwm-alwayscenter-20200625-f04cac6.diff
    ./modules/dwm/dwm-centeredwindowname-20180909-6.2.diff
    ./modules/dwm/dwm-uselessgap-20211119-58414bee958f2.diff
    ./modules/dwm/dwm-attachbottom-6.3.diff

    # ./modules/dwm/dwm-colorbar-6.2.diff
    # ./modules/dwm/dwm-status2d-6.3.diff
    # ./modules/dwm/dwm-barconfig-6.3.diff
    # ./modules/dwm/dwm-barpadding-6.2.diff
    ];
  };

  services.qemuGuest.enable = true;
  services.xrdp = {
    enable = true;
    defaultWindowManager = "dwm";
    openFirewall = true;
  };

  programs.fish.enable = true;
  


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mead = {
    isNormalUser = true;
    description = "mead";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      neovim
      firefox
      grc
      fzf
      starship
    ];
  };


  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mead" = import ./home.nix;
    };
  };


  # Enable automatic login for the user.
  services.getty.autologinUser = "mead";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    picom
    dmenu
    st
    gcc
    clang
    feh
    xclip
  ];

  

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
