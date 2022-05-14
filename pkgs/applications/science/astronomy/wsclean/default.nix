{ 
  lib, stdenv, fetchFromGitLab, cmake,
  hdf5-cpp, casacore, blas, python3, python3Packages,
  openblas,
  fftw, fftwFloat, cfitsio, wcslib, boost, gsl
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

  openblasAlt = openblas.override {parrasMode = true;};
  blasAlt = blas.override {blasProvider = openblasAlt;};

  nativeBuildInputs = [ cmake ];
  buildInputs = [ hdf5-cpp casacore cfitsio blasAlt fftw fftwFloat python3 python3Packages.pybind11 boost gsl ];
  preConfigure = "export OPENBLAS_NUM_THREADS=1";

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://gitlab.com/aroffringa/wsclean";
    description = "WSClean stands for w-tracking clean and is a imager for radio interferometers";
    maintainers = with maintainers; [ parras ];
    license = licenses.gpl3;
  };
}
