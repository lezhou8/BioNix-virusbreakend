{ bionix
, name ? "test"
, depths ? [ 5 10 15 30 60 ]
}:

# path
input:

with bionix;
with builtins;
with lib;

# May not work if length pf sequence is too short
let
  listdepths = map (x: { name = "${name}_${toString x}"; value = art.illumina {} { fasta = input; inherit name; depth = x; }; }) depths;
in
  listToAttrs listdepths

# return set of depth = path
