{
  description = "Creates simulated data from virusbreakend paper";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    bionix,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: with bionix.lib
      {
        overlays = [
          (self: super: {art = self.callBionix ./art_illumina/art.nix {};})
          (self: super: {
            exec = f: x @ {
              ppn ? 4,
              mem ? 4,
              walltime ? "2:00:00",
              ...
            }: y:
              (f (removeAttrs x ["ppn" "mem" "walltime"]) y).overrideAttrs (attrs: {
                PPN =
                  if attrs.passthru.multicore or false
                  then ppn
                  else 1;
                MEMORY = toString mem + "G";
                WALLTIME = walltime;
              });
          })
          ./resources.nix
        ];
        nixpkgs = import nixpkgs {inherit system;};
      }; {
        defaultPackage = callBionix ./. {};
        packages.small = callBionix ./. {small = true;};
      }
    );
}
