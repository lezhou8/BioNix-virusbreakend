{ bionix
, flank ? 50000
, breakOffset ? 10
, virusLength ? 2000
, position ? 1000000
, virusPosition ? 4
, fasta ? bionix.ref.grch38.seq
, virusDefinition ? null
, fastaDefinition ? null
}:

with bionix;
with builtins;
with lib;

input:

let
  queryRegion = callBionix ./samtools-queryRegion.nix;
  justSequence = callBionix ./modifyfile.nix {};
  fastaName = if fastaDefinition != null then fastaDefinition else callBionix ./getFastaDef.nix {} fasta;
  virusName = if virusDefinition != null then virusDefinition else callBionix ./getFastaDef.nix {} input;
  left = justSequence (queryRegion { regions = [ "${fastaName}:${toString (position - flank)}-${toString position}" ]; } fasta);
  middle = justSequence (queryRegion { regions = [ "${virusName}:${toString (virusPosition)}-${toString (virusPosition + virusLength)}" ]; } input);
  right = justSequence (queryRegion { regions = [ "${fastaName}:${toString position}-${toString (position + breakOffset + flank)}" ]; } fasta);
  together = callBionix ./catfiles.nix {} [ left middle right ];
in
  callBionix ./attachdefline.nix { definition = fastaName; } together
