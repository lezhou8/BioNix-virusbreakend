{ bionix
, label
}:

# fasta file
input:

with bionix;
with builtins;
with lib;

stage {
  name = "extract-sepcified-sequence"; 
  buildCommand = ''
    echo "${readFile input}" | grep "${label}" ${input} > $out
  '';
}
  