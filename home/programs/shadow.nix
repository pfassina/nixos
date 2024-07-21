{inputs, ...}: {
  imports = ["${inputs.shadow-nix}/import/home-manager.nix"];

  programs.shadow-client = {
    channel = "preprod";
  };
}
