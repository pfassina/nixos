{ pkgs, ... }:
{

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins =  with pkgs.fishPlugins; [
      { name = "grc"; src = grc.src; }
      { name = "z"; src = z.src; }
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "forgit"; src = forgit.src; }
    ];
  };

  programs.starship = {
    enable = true;
  };
}
