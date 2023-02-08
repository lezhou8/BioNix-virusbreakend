{ bionix
, header ? "sequence"
, flank ? 50000
, breakoffset ? 10
, viruslength ? 2000
, virus
, virus-label ? null
, host
, host-label ? null
}:

position: 

with bionix;
with builtins;
with lib;


let
  subsequence = callBionix ./samtools-faidx-edit.nix;
  get-name = callBionix ./getFastaDef.nix {};
  virus-name = if virus-label != null then virus-label else (get-name virus);
  host-name = if host-label != null then host-label else (get-name host);

  trim-header = callBionix ./modifyfile.nix {};
  add-header = callBionix ./attachdefline.nix {definition = header;};
  concat = callBionix ./catfiles.nix {};
  preceding-seq = trim-header (subsequence { regions = [ "${host-name}:${toString (position - flank)}-${toString position}" ]; } host);
  succeeding-seq = trim-header (subsequence { regions = [ "${host-name}:${toString (position + breakoffset)}-${toString (position + flank + breakoffset)}" ]; } host);
  viral-seq = trim-header (subsequence { regions = [ "${virus-name}:${toString (position / 250000)}-${toString (position / 250000 + viruslength)}" ]; } virus);
  integrated = concat [ preceding-seq viral-seq succeeding-seq ];

in
  add-header integrated

