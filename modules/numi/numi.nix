{ config, pkgs, ... }:
 
let
  numi = import ( pkgs.fetchFromGitHub {
      {
        owner = 'nikolaeu';
        repo = 'numi';
        rev = 'a9886c9994acb4c672f6549df75b44cc4dc6ad01';
        sha256 = '1w2ri3wr440zy1lvqjjby9pmpwwx0n7yi0pd07l92331djk8lqih';
      } 
    });

in
{
  environment.systemPackages = [ numi ];
}
