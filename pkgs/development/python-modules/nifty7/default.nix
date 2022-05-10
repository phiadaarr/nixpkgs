{
  lib, buildPythonPackage, fetchFromGitLab, pythonOlder, pytestCheckHook,
  pybind11, scipy, matplotlib, mpi4py, ducc0
}:

buildPythonPackage rec {
  pname = "nifty7";
  version = "7.5";

  disabled = pythonOlder "3.7";

  src = fetchFromGitLab {
    domain = "gitlab.mpcdf.mpg.de";
    owner = "ift";
    repo = "nifty";
    rev = "v" + version;
    sha256 = "6pTXNUpBF+Yjz+195N/z2XO8S5+a7xcstKDiTKjyeOg=";
  };

  buildInputs = [ pybind11 ];
  propagatedBuildInputs = [ scipy matplotlib ducc0 ];

  checkInputs = [ pytestCheckHook mpi4py ];
  preCheck = "export OMPI_MCA_plm_rsh_agent=";
  pytestFlagsArray = [ "test" ];
  pythonImportsCheck = [ "nifty7" ];

  meta = with lib; {
    homepage = "https://gitlab.mpcdf.mpg.de/ift/nifty";
    description = "";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ parras ];
  };
}
