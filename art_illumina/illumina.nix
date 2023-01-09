{ bionix
, flags ? "--noALN --paired --seqSys HSXn -ir 0 -ir2 0 -dr 0 -dr2 0 -k 0 -l 150 -m 500 -s 100 -rs 1 --id read"
, depth ? 5
, name ? "test"
}:

with bionix;
with pkgs;
with builtins;

input:

# TODO: need to make variables for output names but it is being annoying
stage {
  name = "illumina";
  buildInputs = [ art.app ];
  buildCommand = ''
    mkdir -p $out
    art_illumina ${flags} --fcov ${toString depth} --in ${input} -o ${name}.${toString depth}x.
    sed -i -E "s/^\@.*read([0-9]+).*$/@read\1/" ${name}.${toString depth}x.1.fq ${name}.${toString depth}x.2.fq
    cp ${name}.${toString depth}x.1.fq $out/
    cp ${name}.${toString depth}x.2.fq $out/
  '';
}
