{ stdenv, fetchurl, pkgconfig, intltool, itstool, gnome3, glib, gtk3, gtksourceview3, libwnck3, libgtop, libxml2, libnotify, polkit, upower, wirelesstools, mate, hicolor-icon-theme, wrapGAppsHook }:

stdenv.mkDerivation rec {
  name = "mate-applets-${version}";
  version = "1.22.0";

  src = fetchurl {
    url = "http://pub.mate-desktop.org/releases/${mate.getRelease version}/${name}.tar.xz";
    sha256 = "0f5ym6z7awi0kw6i1sdkj2qly88sl692j5r1zhklihyz1z9a6j0h";
  };

  nativeBuildInputs = [
    pkgconfig
    intltool
    itstool
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gtksourceview3
    gnome3.gucharmap
    libwnck3
    libgtop
    libxml2
    libnotify
    polkit
    upower
    wirelesstools
    mate.libmateweather
    mate.mate-panel
    hicolor-icon-theme
  ];

  configureFlags = [ "--enable-suid=no" ];

  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  meta = with stdenv.lib; {
    description = "Applets for use with the MATE panel";
    homepage = https://mate-desktop.org;
    license = with licenses; [ gpl2Plus lgpl2Plus ];
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
