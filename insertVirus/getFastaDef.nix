{ bionix }:

with bionix;

input:

stage {
  name = "get-fasta-def";
  buildCommand = ''
      head -n 1 ${input} | awk '{print $1}' | sed 's/>//' > $out
    '';
}
