# Generated by update.sh
{ fetchurl }:

{
  "curl-8_7_1.tar.gz" = fetchurl {
    url = "https://github.com/curl/curl/archive/curl-8_7_1.tar.gz";
    hash = "sha256-DkbIVvUXYCw0e7X+W3MXT47nmLyH8alyNclXYfdfzCg=";
  };

  "brotli-1.1.0.tar.gz" = fetchurl {
    url = "https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz";
    hash = "sha256-5yCmyilCi4A/StFlNxdx9TmPq6OX7fZ3iDehhZnqE/8=";
  };

  "boringssl.zip" = fetchurl {
    url = "https://github.com/google/boringssl/archive/d24a38200fef19150eef00cad35b138936c08767.zip";
    hash = "sha256-tzAAwL70VAyUEOZZ86ql+RgXsw4DZhkvW5l0d1eVVHU=";
  };

  "nghttp2-1.63.0.tar.bz2" = fetchurl {
    url = "https://github.com/nghttp2/nghttp2/releases/download/v1.63.0/nghttp2-1.63.0.tar.bz2";
    hash = "sha256-YHsXRVTSKoKLxTLR1zT+D3KbXV7SB/LxLpamLoPynFU=";
  };
}
