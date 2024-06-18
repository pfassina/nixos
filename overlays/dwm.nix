{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = [
          ./patches/dwm/dwm-firacode.diff
          ./patches/dwm/dwm-no-clown-fiesta.diff
          ./patches/dwm/dwm-statuspadding-6.3.diff
          ./patches/dwm/dwm-alpha-20230401-348f655.diff
          ./patches/dwm/dwm-alwayscenter-20200625-f04cac6.diff
          ./patches/dwm/dwm-uselessgap-20211119-58414bee958f2.diff
          ./patches/dwm/dwm-attachbottom-6.3.diff
          ./patches/dwm/dwm-underlinetags-6.2.diff
          ./patches/dwm/dwm-notitle-6.2.diff
          ./patches/dwm/dwm-colorbar-6.2.diff
          ./patches/dwm/dwm-barpadding-20211020-a786211.diff
          ./patches/dwm/dwm-color-adj.diff
          ./patches/dwm/dwm-alpha-adj.diff
          ./patches/dwm/dwm-two-bars.diff
          ./patches/dwm/dwm-accent.diff
          ./patches/dwm/dwm-dmenu.diff
          ./patches/dwm/dwm-dmenu-qalc.diff
        ];
      });
    })
  ];

}
