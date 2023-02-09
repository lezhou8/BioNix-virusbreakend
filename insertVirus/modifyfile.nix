{ bionix }:

file:

with bionix;
with builtins;

stage {
  name = "modify-file";
  buildCommand = ''
    grep -v '>' ${file} | tr -d '\n' > $out
  '';
}
