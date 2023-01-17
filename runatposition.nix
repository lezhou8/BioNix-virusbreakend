{ bionix
, definition ? ""
}:

# [ { fasta, name, position, length } ... ]
inputs:

with bionix;
with builtins;

let
  sectionfastas = x: 
    callBionix ./samtools-faidx-edit.nix { regions = [ "${x.name}:${toString x.position}-${toString (x.position + x.length)}" ]; } x.fasta;
  listsectionedfastas = map sectionfastas inputs;
  partsequences = callBionix ./mapmodifications.nix { modification = callBionix ./modifyfile.nix {}; } listsectionedfastas;
  togethersequence = callBionix ./catfiles.nix {} partsequences;
in
  callBionix ./attachdefline.nix { inherit definition; } togethersequence
