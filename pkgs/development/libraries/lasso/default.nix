{ lib, stdenv
, autoreconfHook
, fetchurl
, glib
, gobject-introspection
, gtk-doc
, libtool
, libxml2
, libxslt
, openssl
, pkg-config
, python3
, xmlsec
, zlib
}:

stdenv.mkDerivation rec {
  pname = "lasso";
  version = "2.8.1";

  src = fetchurl {
    url = "https://dev.entrouvert.org/lasso/lasso-${version}.tar.gz";
    hash = "sha256-t9DJj2xmFPruspKhjy2DbAvDeNWaXXSB6BC7bGnsnd8=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    python3
  ];

  buildInputs = [
    glib
    gobject-introspection
    gtk-doc
    libtool
    libxml2
    libxslt
    openssl
    python3.pkgs.six
    xmlsec
    zlib
  ];

  configurePhase = ''
    ./configure --with-pkg-config=$PKG_CONFIG_PATH \
                --disable-perl \
                --prefix=$out
  '';

  meta = with lib; {
    homepage = "https://lasso.entrouvert.org/";
    description = "Liberty Alliance Single Sign-On library";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ womfoo ];
  };
}
