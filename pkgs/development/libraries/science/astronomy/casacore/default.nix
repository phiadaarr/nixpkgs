{ 
  lib, stdenv, fetchFromGitHub, cmake,
  python3, python3Packages,
  gfortran, flex, bison, blas, lapack, readline, fftw, fftwFloat, cfitsio,
  wcslib, boost
}:

let
  boostWithPython = boost.override {
    enablePython = true;
    enableNumpy = true;
    python = python3;
  };
in stdenv.mkDerivation rec {
  pname = "casacore";
  version = "3.4.0";

  src = fetchFromGitHub {
    owner = "casacore";
    repo = "casacore";
    rev = "v" + version;
    sha256 = "QIl8tHdc1qGOocLGnTu0//BcYi6S3m4Eqo3AN/0rWRU=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ gfortran flex bison blas lapack readline fftw fftwFloat cfitsio wcslib python3 python3Packages.numpy boostWithPython ];

  cmakeFlags = [ "-DBUILD_PYTHON=OFF"
                 "-DBUILD_PYTHON3=ON" ];

  outputs = [ "out" "dev" ];
  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "http://casacore.github.io/casacore";
    description = "A suite of C++ libraries for radio astronomy data processing";
    maintainers = with maintainers; [ parras ];
    license = licenses.lgpl2;
  };
}
