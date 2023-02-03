{ bionix
, flank ? 50000
, breakOffset ? 10
, virusLength ? 2000
}:

with bionix;
with builtins;
with lib;

fasta:

position:

virus:

let
  queryRegion = callBionix ./samtools-queryRegion.nix;
  justSequence = callBionix ./modifyfile.nix {};
  getName = fasta:
    readFile (stage {
      name = "get-fasta-def";
      buildCommand = ''
          head -n 1 ${fasta} | awk '{print $1}' | sed 's/>//' | tr -d '\n' > $out
        '';
    });
  fastaName = getName fasta;
  virusName = getName virus;
  left = justSequence (queryRegion { regions = [ "${fastaName}:${toString (position - flank)}-${toString position}" ]; } fasta);
  middle = justSequence (queryRegion { regions = [ "${virusName}:${toString (position * 4 / 1000000 )}-${toString (position * 4 / 1000000 + virusLength)}" ]; } virus);
  right = justSequence (queryRegion { regions = [ "${fastaName}:${toString position}-${toString (position + breakOffset + flank)}" ]; } fasta);
  together = callBionix ./catfiles.nix {} [ left middle right ];
in
  callBionix ./attachdefline.nix { definition = fastaName; } together
