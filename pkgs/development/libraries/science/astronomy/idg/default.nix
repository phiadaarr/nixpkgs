{ 
  lib, stdenv, fetchFromGitLab, cmake,
  fftw, fftwFloat, blas, python3,
  enablePython ? false
}:

stdenv.mkDerivation rec {
  pname = "idg";
  version = "1.0.0";

  src = fetchFromGitLab {
    owner = "astron-idg";
    repo = "idg";
    rev = version;
    sha256 = "AYQx0s3HeQX1TwHN70qM6s7a9V2tvsAFO0CMrl/Q1tA=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fftw fftwFloat blas ] ++ lib.optionals enablePython [ python3 ];

  cmakeFlags = [ "-DBUILD_LIB_CPU=ON" ] ++ lib.optionals enablePython [ "-DBUILD_WITH_PYTHON=ON" ];
  # TODO BUILD_LIB_CUDA BUILD_STATIC_LIBS BUILD_LIB_OPENCL

  outputs = [ "out" "dev" ];
  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://gitlab.com/astron-idg/idg";
    description = "Fast method for convolutional resampling (gridding/degridding) of radio astronomical data";
    maintainers = with maintainers; [ parras ];
    license = licenses.gpl3;
  };
}
