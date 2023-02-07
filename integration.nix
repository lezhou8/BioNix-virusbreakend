{ bionix
, header ? "sequence"
, flank ? 50000
, breakoffset ? 10
, viruslength ? 2000
, virus
, virus-label
, host
, host-label
}:

position: 

with bionix;
with builtins;
with lib;

let
  subsequence = callBionix ./samtools-faidx-edit.nix;
  #extract = callBionix ./extract-seq.nix;
  trim-header = callBionix ./modifyfile.nix {};
  add-header = callBionix ./attachdefline.nix;
  concat = callBionix ./catfiles.nix {};
  preceding-seq = trim-header (subsequence { regions = [ "${host-label}:${toString (position - flank)}-${toString position}" ]; } host);
  succeeding-seq = trim-header (subsequence { regions = [ "${host-label}:${toString (position + breakoffset)}-${toString (position + flank)}" ]; } host);
  viral-seq = trim-header (subsequence { regions = [ "${virus-label}:${toString (position / 250000)}-${toString (position / 250000 + viruslength)}" ]; } virus);
  integrated = concat [ preceding-seq viral-seq succeeding-seq ];

in
  add-header {} integrated

