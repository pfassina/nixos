{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      slstatus = super.slstatus.overrideAttrs (oldAttrs: rec {
        patches = [
          ./patches/slstatus/slstatus-time.diff
        ];
      });
    })
  ];

}
