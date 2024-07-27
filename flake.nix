{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hydra.soopy.moe:IZ/bZ1XO3IfGtq66g+C85fxU/61tgXLaJ2MlcGGXU8Q="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    shadow-nix = {
      url = "github:anthonyroussel/shadow-nix/v1.5.0";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./sub/substituter.nix
        nixos-hardware.nixosModules.apple-t2
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
