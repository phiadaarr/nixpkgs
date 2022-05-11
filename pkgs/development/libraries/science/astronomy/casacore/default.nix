{ lib, stdenv, fetchurl, cmake, gfortran, flex, bison, blas, lapack, readline, fftw, fftwFloat, cfitsio, wcslib, python3, python3Packages, boost }:

# sofa (optional, only for testing casacore measures)
# hdf5 (optional)
# numpy (optional)
# boost-python (optional)
# ncurses (optional)


let
  boostWithPython = boost.override {
    enablePython = true;
    enableNumpy = true;
    python = python3;
  };
in stdenv.mkDerivation rec {
  pname = "casacore";
  version = "3.4.0";

  src = fetchurl {
    url = "https://github.com/casacore/casacore/archive/refs/tags/v" + version + ".tar.gz";
    sha256 = "MfAq0uJvKbq0pHoqaeBJ17xREISguCYzYOYVc1b5KuE=";
  };

  nativeBuildInputs = [ cmake gfortran flex bison blas lapack readline fftw fftwFloat cfitsio wcslib python3 python3Packages.numpy boostWithPython ];

  cmakeFlags = [ "-DBUILD_PYTHON=OFF"
                 "-DBoost_DEBUG=ON"
                 "-DBUILD_PYTHON3=ON" ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "http://casacore.github.io/casacore";
    description = "FIXME";
    maintainers = with maintainers; [ parras ];
    license = licenses.lgpl2;
  };
}
