{ bionix }:

with bionix;
with builtins;
with compression;

let
  hbv = fetchFastA {
    url = "https://raw.githubusercontent.com/PapenfussLab/gridss/master/scripts/virusbreakend_manuscript/scripts/LC500247.1.fa";
    sha256 = "sha256-zD59mMniEfR0SihJAWpa0SfLdI4cK6qeKnJUE3XjkHQ=";
  };
  chr1gz = fetchFastAGZ {
    url = "https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/CHM13/assemblies/chm13.draft_v1.0.fasta.gz";
    sha256 = "sha256-RFLpo174+DF3GPdh09J6HHO50NS439oJYWyuxDrWNG4=";
  };
  chr1 = uncompress {} chr1gz;
  viruses = [hbv];
  positions = [1000000];
  depths = [5];
  multiplier = 4 / 1000000;
  relativeVirusPosition = position: position * multiplier;
  alignments = map (virus:
    map (position: let
      virusReference =
        insert {
          fasta = chr1;
          inherit position;
          virusPosition = relativeVirusPosition position;
        }
        virus;
    in
      map (depth:
        samtools.sort {} (bwa.mem {ref = ref.grch38.seq;} {
          input1 = (art.illumina {inherit depth;} virusReference).out;
          input2 = (art.illumina {inherit depth;} virusReference).pair;
        }))
      depths)
    positions)
  viruses;
in
  (elemAt (elemAt (elemAt alignments 0) 0) 0)
