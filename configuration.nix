
{ config, pkgs, inputs, ... }:


{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  networking.hostName = "nixos";
  networking.networkmanager.enable = true;


  time.timeZone = "America/Los_Angeles";

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


  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    displayManager.lightdm.enable = true;
    windowManager.dwm.enable = true;
  };


  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = [
          ./modules/dwm/dwm-firacode.diff
          ./modules/dwm/dwm-no-clown-fiesta.diff
          ./modules/dwm/dwm-statuspadding-6.3.diff
          ./modules/dwm/dwm-alpha-20230401-348f655.diff
          ./modules/dwm/dwm-alwayscenter-20200625-f04cac6.diff
          ./modules/dwm/dwm-uselessgap-20211119-58414bee958f2.diff
          ./modules/dwm/dwm-attachbottom-6.3.diff
          ./modules/dwm/dwm-underlinetags-6.2.diff
          ./modules/dwm/dwm-notitle-6.2.diff
          ./modules/dwm/dwm-colorbar-6.2.diff
          ./modules/dwm/dwm-barpadding-20211020-a786211.diff
          ./modules/dwm/dwm-color-adj.diff
          ./modules/dwm/dwm-alpha-adj.diff
          ./modules/dwm/dwm-two-bars.diff
          ./modules/dwm/dwm-accent.diff
          ./modules/dwm/dwm-dmenu.diff
          ./modules/dwm/dwm-dmenu-qalc.diff
        ];
      });
      st = super.st.overrideAttrs (oldAttrs: rec {
        patches = [
          ./modules/st/st-no-fiesta.diff
          ./modules/st/st-ligatures-20240105-0.9.diff
        ];
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.harfbuzz ];
      });
      slstatus = super.slstatus.overrideAttrs (oldAttrs: rec {
        patches = [
          ./modules/slstatus/slstatus-time.diff
        ];
      });
      dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
        patches = [
          ./modules/dmenu/dmenu-center-5.2.diff
          ./modules/dmenu/dmenu-border-4.9.diff
          ./modules/dmenu/dmenu-linesbelowprompt-and-fullwidth-20211014.diff
          ./modules/dmenu/dmenu-fuzzymatch-4.9.diff
          ./modules/dmenu/dmenu-fuzzyhighlight-4.9.diff
          ./modules/dmenu/dmenu-qalc-5.2.diff
        ];
      });
    })
  ];


  services.qemuGuest.enable = true;
  services.xrdp = {
    enable = true;
    defaultWindowManager = "dwm";
    openFirewall = true;
  };


  programs.fish.enable = true;
  

  users.users.mead = {
    isNormalUser = true;
    description = "mead";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      neovim
      firefox
      bitwarden
      libqalculate
    ];
  };


  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mead" = import ./home.nix;
    };
  };


  services.getty.autologinUser = "mead";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    dmenu
    slstatus
    st
    gcc
    clang
    feh
    xclip
    fastfetch
    btop
    ripgrep
    grc
    fzf
    starship
    ranger
  ];


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];


  system.stateVersion = "24.05";

}
