{ bionix }:

file:

with bionix;
with builtins;

stage {
  name = "modify-file";
  buildCommand = ''
    echo "${readFile file}" | grep -v '>' | tr -d '\n' > $out
  '';
}
