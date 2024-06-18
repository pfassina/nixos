{ pkgs, ... }:
 
let
  numi = import ( pkgs.fetchFromGitHub {
        owner = "nikolaeu";
        repo = "numi";
        rev = "a9886c9994acb4c672f6549df75b44cc4dc6ad01";
        sha256 = "1p5bvl6xvb27q8ghybxcl019rkccbfpgc0m1mxcnd8s2aprgkska";
    });

in
{
  home.packages = [ numi ]; 
}
