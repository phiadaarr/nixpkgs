{ 
  lib, stdenv, fetchgit, cmake, wget, python3,
  hdf5-cpp, casacore, boost, fftw, fftwFloat, cfitsio,
  build_with_python ? false
}:

stdenv.mkDerivation rec {
  pname = "everybeam";
  version = "0.3.0";

  src = fetchgit {
    url = "https://git.astron.nl/RD/EveryBeam";
    rev = "v" + version;
    sha256 = "rQ/gUmDU9f47fdBz+OGpfyML6iZVsInB64NUunTI76c=";
  };

  nativeBuildInputs = [ cmake wget ];
  buildInputs = [ python3 hdf5-cpp casacore boost fftw fftwFloat cfitsio ];

  cmakeFlags = if build_with_python then [ "-DBUILD_WITH_PYTHON=ON" ] else [];
  #cmakeFlags = [ "-DDOWNLOAD_LOBES=ON" ];

  outputs = [ "out" "dev" ];
  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://git.astron.nl/RD/EveryBeam";
    description = "Provides the antenna response pattern for several instruments, such as LOFAR (and LOBES), SKA (OSKAR), MWA, JVLA";
    maintainers = with maintainers; [ parras ];
    license = licenses.gpl3;
  };
}
