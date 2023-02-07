self: super: with super;
{
  bwa.index = def bwa.index { mem = 15; ppn = 15; walltime = "12:00:00"; };
}
