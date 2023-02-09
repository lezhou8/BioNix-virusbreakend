{ bionix }:

files:

with bionix;
with builtins;

stage {
  name = "concatonate-files";
  buildCommand = ''
      cat ${concatStringsSep " " files} > $out
  '';
}
