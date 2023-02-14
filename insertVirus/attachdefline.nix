{
  bionix,
  definition ? "",
}:

path:

with bionix;

stage {
  name = "attach-definition-line";
  buildCommand = ''
    echo ">${definition}" > $out
    cat ${path} >> $out
  '';
}
