{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: rec {
        patches = [
          ./overrides/st/st-no-fiesta.diff
          ./overrides/st/st-ligatures-20240105-0.9.diff
        ];
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.harfbuzz ];
      });
    })
  ];

}
