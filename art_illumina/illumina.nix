{ bionix
, flags ? "--noALN --paired --seqSys HSXn -ir 0 -ir2 0 -dr 0 -dr2 0 -k 0 -l 150 -m 500 -s 100 -rs 1 --id read"
, depth ? 5
, name ? "test"
}:

input:

with bionix;
with pkgs;
with builtins;
with types;

stage {
  name = "illumina";
  buildInputs = [ art.app ];
  outputs = [ "out" "pair" ];
  buildCommand = ''
    art_illumina ${flags} --fcov ${toString depth} --in ${input} -o ${name}.${toString depth}x.
    sed -i -E "s/^\@.*read([0-9]+).*$/@read\1/" ${name}.${toString depth}x.1.fq ${name}.${toString depth}x.2.fq
    cp ${name}.${toString depth}x.1.fq $out
    cp ${name}.${toString depth}x.2.fq $pair
  '';
  passthru.filetype = filetype.fq {};
  stripStorePath = false;
}
