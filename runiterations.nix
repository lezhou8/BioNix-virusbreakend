{ bionix
, iterations ? 1
, productname ? "test"
}:

# [ { fasta, name, startingposition, length, gap } ... ]
input:

with bionix;
with lib;
with builtins;

let
  mapinputs = iteration:
    map (x: { fasta = x.fasta; name = x.name; position = x.startingposition + x.gap * iteration; length = x.length; }) input;
  listoutputs = genList (x: { name = "${toString (x + 1)}"; value = callBionix ./runatposition.nix { definition = "${productname}_${toString (x + 1)}"; } (mapinputs x);}) iterations; # set { name = path }
  setoutput = listToAttrs listoutputs;
  recursesetoutput = mapAttrs (name: value: { "${productname}_${name}.fa" = value; } // (callBionix ./artloop.nix { name = "${productname}"; } value)) setoutput;
in
  linkOutputs recursesetoutput 
