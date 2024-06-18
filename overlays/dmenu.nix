{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
        patches = [
          ./patches/dmenu/dmenu-center-5.2.diff
          ./patches/dmenu/dmenu-border-4.9.diff
          ./patches/dmenu/dmenu-linesbelowprompt-and-fullwidth-20211014.diff
          ./patches/dmenu/dmenu-fuzzymatch-4.9.diff
          ./patches/dmenu/dmenu-fuzzyhighlight-4.9.diff
          ./patches/dmenu/dmenu-qalc-5.2.diff
        ];
      });
    })
  ];

}
