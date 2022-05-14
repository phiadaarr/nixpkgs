{ 
  lib, stdenv, fetchFromGitLab, cmake,
  hdf5-cpp, casacore, blas, python3, python3Packages,
  openblas, fftw, fftwFloat, cfitsio, wcslib, boost, gsl,
  everybeam  # optional
}:

stdenv.mkDerivation rec {
  pname = "wsclean";
  version = "3.1";

  src = fetchFromGitLab {
    owner = "aroffringa";
    repo = "wsclean";
    rev = "v" + version;
    fetchSubmodules = true;
    sha256 = "3pHihUoeiC+ElQau7zBfjljOHTyzRP9bQ0WieFK7zkI=";
  };

  openblasAlt = openblas.override { withoutOpenMP = true; };
  blasAlt = blas.override { blasProvider = openblasAlt; };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ hdf5-cpp boost
                  casacore cfitsio
		  fftw fftwFloat blasAlt gsl
		  python3 python3Packages.pybind11
		  everybeam ];
  preConfigure = "export OPENBLAS_NUM_THREADS=1";

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://gitlab.com/aroffringa/wsclean";
    description = "W-stacking imager for radio interferometry";
    maintainers = with maintainers; [ parras ];
    license = licenses.gpl3;
  };
}
