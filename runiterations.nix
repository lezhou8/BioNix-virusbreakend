{ bionix
, iterations ? 1
, productname ? "test"
}:

# [ { fasta, name, startingposition, length, gap } ... ]
input:

with bionix;
with lib;
with builtins;

# TODO: name the outputs properly
let
  mapinputs = iteration:
    map (x: { fasta = x.fasta; name = x.name; position = x.startingposition + x.gap * iteration; length = x.length; }) input;
  listoutputs = genList (x: { name = "${productname}_${toString x}"; value = callBionix ./runatposition.nix { definition = "${productname}_${toString x}"; } (mapinputs x);}) iterations; # set { name = path }
  setoutput = listToAttrs listoutputs;
  recursesetoutput = mapAttrs (name: value: { fasta = value; } // (callBionix ./artloop.nix {} value)) setoutput;
in
  linkOutputs recursesetoutput 
