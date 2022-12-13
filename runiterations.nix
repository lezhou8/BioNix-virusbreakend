{ bionix
, iterations ? 1
, productname ? "test"
}:

# [ { fasta, name, startingposition, length, gap } ... ]
inputs:

with bionix;
with lib;
with builtins;

let
  listrange = range 1 iterations;
  mapinputs = iteration:
    map (x: { fasta = x.fasta; name = x.name; position = x.startingposition + x.gap * iteration; length = x.length; }) inputs;
  listoutputs = map (x: callBionix ./runatposition.nix { definition = "${productname}_${toString x}"; } (mapinputs x)) listrange;
in
  stage {
    name = "iterate-integration-sites";
    buildCommand = ''
      mkdir $out
      n=1
      for file in ${concatStringsSep " " listoutputs}; do
          mkdir $out/$n
          ln -s $file $out/$n/${productname}_$n.fa
          n=$(($n + 1))
      done
    '';
  }
