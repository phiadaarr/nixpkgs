{ lib, pkgs, buildPythonPackage, fetchFromGitHub, boost, python3, python3Packages }:

let
  boostWithPython = boost.override {
    enablePython = true;
    enableNumpy = true;
    python = python3;
  };
in buildPythonPackage rec {
  pname = "casacore";
  version = "3.4.0";

  src = fetchFromGitHub {
    owner = "casacore";
    repo = "python-casacore";
    rev = "v" + version;
    sha256 = "0AZT6a1Rk6fHEidDsL0HXzDBV/ld8+NT82XxHrSMz4s=";
  };

  buildInputs = [ boostWithPython pkgs.casacore python3Packages.numpy python3 ];
  setupPyBuildFlags = [ "-I${pkgs.casacore.dev}/include:${pkgs.boost.dev}/include"
                        "-L${pkgs.casacore.out}/lib:${pkgs.boost.out}/lib"];
  #FIXME TEMPORARY
  preConfigure = ''
  ls ${pkgs.boost.out}/lib
  export CFLAGS="-std=c++11 -I${pkgs.casacore.dev}/include:${pkgs.boost.dev}/include -L${pkgs.casacore.out}/lib:${pkgs.boost.out}/lib";
  '';

  meta = with lib; {
    homepage = "http://casacore.github.io/python-casacore";
    description = "Python bindings for casacore, a C++ library used in radio astronomy";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ parras ];
  };

}
