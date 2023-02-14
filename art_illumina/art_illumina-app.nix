{ fetchurl, stdenv, gsl }:
stdenv.mkDerivation {
  name = "Art";
  src = fetchurl {
    url = "https://archive.org/download/artsrcmountrainier2016.06.05linux/artsrcmountrainier2016.06.05linux.tgz";
    sha256 = "sha256-aa7eYIhOuEjeBDquUpQnS3ymNItzhKg4DwrFpN/v9Ig=";
  };
  buildInputs = [ gsl ];
  preBuild = "make clean";
}
