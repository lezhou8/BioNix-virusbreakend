{ bionix }:

input:

with bionix;
with builtins;

readFile (stage {
  name = "get-fasta-def";
  buildCommand = ''
      head -n 1 ${input} | awk '{print $1}' | sed 's/>//' | tr -d '\n' > $out
    '';
})
