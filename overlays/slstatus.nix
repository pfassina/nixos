{...}: {
  nixpkgs.overlays = [
    (self: super: {
      slstatus = super.slstatus.overrideAttrs (oldAttrs: {
        patches = [
          ./patches/slstatus/slstatus-time.diff
        ];
      });
    })
  ];
}
