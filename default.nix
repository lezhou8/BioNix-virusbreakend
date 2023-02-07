{ bionix }:

with bionix;

let
  fq1 = fetchFastQ {
    url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-1.fq";
    sha256 = "0kh29i6fg14dn0fb1xj6pkpk6d83y7zg7aphkbvjrhm82braqkm8";
  };
  fq2 = fetchFastQ {
    url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-2.fq";
    sha256 = "0czk85km6a91y0fn4b7f9q7ps19b5jf7jzwbly4sgznps7ir2kdk";
  };
in
  samtools.sort {} (bwa.mem { ref = ref.grch38.seq; } { input1 = fq1; input2 = fq2; })
