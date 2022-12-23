{ bionix
, flags ? "--noALN --paired --seqSys HSXn -ir 0 -ir2 0 -dr 0 -dr2 0 -k 0 -l 150 -m 500 -s 100 -rs 1 --id read"
}:

with bionix;
with pkgs;
with builtins;

# { fasta, name, depth }
input:

# need to make variables for output names
stage {
  name = "illumina";
  buildInputs = [ art.app ];
  buildCommand = ''
    mkdir -p $out
    art_illumina ${flags} --fcov 5 --in ${input.fasta} -o ${input.name}.${toString input.depth}x.
    sed -i -E "s/^\@.*read([0-9]+).*$/@read\1/" ${input.name}.${toString input.depth}x.1.fq ${input.name}.${toString input.depth}x.2.fq
    cp ${input.name}.${toString input.depth}x.1.fq $out/
    cp ${input.name}.${toString input.depth}x.2.fq $out/
  '';
}
