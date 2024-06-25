{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        patches = [
          ./patches/st/st-no-fiesta.diff
          ./patches/st/st-ligatures-20210824-0.8.4.diff
          ./patches/st/st-glyph-wide-support-20230701-5770f2f.diff
        ];
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.harfbuzz ];
      });
    })
  ];

}
