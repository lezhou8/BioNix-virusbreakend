{ bionix
, definition ? ""
, flank ? 50000
, breakoffset ? 10
}:

with bionix;

# e.g. human genome
fasta:

position:

virus:

let
  queryRegion = callBionix ./samtools-queryRegion.nix;
  justSequence = callBionix ./modifyfile.nix {};
  left = justSequence (queryRegion { regions = []; } fasta);
  middle = justSequence (queryRegion { regions = []; } virus);
  right = justSequence (queryRegion { regions = []; } fasta);
  together = callBionix ./catfiles.nix {} [ left middle right ];
in
  callBionix ./attachdefline.nix { inherit definition; } together
