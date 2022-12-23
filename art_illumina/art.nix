{ bionix }:

with bionix;

{
  app = pkgs.callPackage ./art_illumina-app.nix {};
  illumina = callBionixE ./illumina.nix;
}
