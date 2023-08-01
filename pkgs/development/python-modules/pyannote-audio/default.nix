{ stdenv, lib, buildPythonPackage, fetchFromGitHub, pythonOlder, pytestCheckHook,

# asteroid-filterbanks,
einops,
huggingface-hub,
lightning,
omegaconf,
# pyannote.core,
# pyannote.database,
# pyannote.metrics,
# pyannote.pipeline,
pytorch-metric-learning,
rich,
semver,
soundfile,
speechbrain,
tensorboardx,
torch,
# torch_audiomentations,
torchaudio,
torchmetrics,
networkx
}:

buildPythonPackage rec {
  pname = "pyannote-audio";
  version = "2.1.1";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "pyannote";
    repo = pname;
    rev = "refs/tags/2.1.1";
    hash = "sha256-zMpn2Mf+szhpC5nLU2oSixzMTNffOHPheKWGcbT3/cQ=";
  };

  patches = [ ./patch-remove-pyscaffold ];

  propagatedBuildInputs = [
# asteroid-filterbanks,
einops
huggingface-hub
lightning
omegaconf
# pyannote.core
# pyannote.database
# pyannote.metrics
# pyannote.pipeline
pytorch-metric-learning
rich
semver
soundfile
speechbrain
tensorboardx
torch
# torch_audiomentations
torchaudio
torchmetrics
networkx
    ];
  # propagatedBuildInputs = [ numpy ];

  # nativeCheckInputs = [ pytestCheckHook ];
  # pytestFlagsArray = [ "python/test" ];
  pythonImportsCheck = [ "pyannote" ];

  doCheck = false;

  meta = with lib; {
    # broken = stdenv.isDarwin;
    homepage = "https://github.com/pyannote/pyannote-audio";
    description = "xxx";
    license = licenses.mit;
    maintainers = with maintainers; [ parras ];
  };
}
