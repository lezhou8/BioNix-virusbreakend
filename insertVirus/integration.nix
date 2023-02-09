{ bionix
, header ? "sequence"
, flank ? 50000
, breakoffset ? 10
, viruslength ? 2000
, virus
, virus-label ? null
, host
, host-label ? null
, virus-position ? 1000000 / 250000
}:

host-position: 

with bionix;
with builtins;
with lib;


let
  subsequence = callBionix ./samtools-queryRegion.nix;
  get-name = fasta:
    readFile (stage {
      name = "get-fasta-def";
      buildCommand = ''
          head -n 1 ${fasta} | awk '{print $1}' | sed 's/>//' | tr -d '\n' > $out
        '';
    });
  virus-name = if virus-label != null then virus-label else (get-name virus);
  host-name = if host-label != null then host-label else (get-name host);
  virus-idx = if virus-position != null then virus-position else (host-position / 250000);
  trim-header = callBionix ./modifyfile.nix {};
  add-header = callBionix ./attachdefline.nix {definition = header;};
  concat = callBionix ./catfiles.nix {};
  preceding-seq = trim-header (subsequence { regions = [ "${host-name}:${toString (host-position - flank)}-${toString host-position}" ]; } host);
  succeeding-seq = trim-header (subsequence { regions = [ "${host-name}:${toString (host-position + breakoffset)}-${toString (host-position + flank + breakoffset)}" ]; } host);
  viral-seq = trim-header (subsequence { regions = [ "${virus-name}:${toString (virus-idx)}-${toString (virus-idx + viruslength)}" ]; } virus);
  integrated = concat [ preceding-seq viral-seq succeeding-seq ];
in
  add-header integrated

