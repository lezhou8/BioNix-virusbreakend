self: super: with super;
{
  bwa.index = def bwa.index { mem = 15; ppn = 15; walltime = "12:00:00"; };
  bwa.mem = def bwa.mem { mem = 10; ppn = 10; walltime = "2:00:00"; };
}
