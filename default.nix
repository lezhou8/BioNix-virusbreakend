{ bionix }:

with bionix;

let
  hbv = fetchFastA {
    url = "https://raw.githubusercontent.com/PapenfussLab/gridss/master/scripts/virusbreakend_manuscript/scripts/LC500247.1.fa";
    sha256 = "sha256-zD59mMniEfR0SihJAWpa0SfLdI4cK6qeKnJUE3XjkHQ=";
  };
  chr1gz = fetchFastAGZ {
    url = "https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/assemblies/chm13.draft_v1.0.fasta.gz";
    sha256 = "sha256-RFLpo174+DF3GPdh09J6HHO50NS439oJYWyuxDrWNG4=";
  };
  chr1 = compression.uncompress { } chr1gz;
  sequencelist = [ { fasta = hbv; name = "LC500247.1"; startingposition = 10; length = 2; gap = 5; }
                   { fasta = chr1; name = "chr1"; startingposition = 10; length = 2; gap = 5; } ];

in
  callBionix ./runiterations.nix { iterations = 10; productname = "chr1"; } sequencelist
