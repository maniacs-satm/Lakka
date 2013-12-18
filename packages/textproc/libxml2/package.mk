################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="libxml2"
PKG_VERSION="2.9.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://xmlsoft.org"
PKG_URL="ftp://xmlsoft.org/libxml2/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="zlib"
PKG_BUILD_DEPENDS_TARGET="toolchain zlib"
PKG_BUILD_DEPENDS_HOST="toolchain zlib:host Python-host"
PKG_PRIORITY="optional"
PKG_SECTION="textproc"
PKG_SHORTDESC="libxml: XML parser library for Gnome"
PKG_LONGDESC="The libxml package contains an XML library, which allows you to manipulate XML files. XML (eXtensible Markup Language) is a data format for structured document interchange via the Web."
PKG_IS_ADDON="no"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--prefix=$ROOT/$TOOLCHAIN \
             --disable-silent-rules \
             --disable-ipv6 \
             --with-python \
             --with-zlib \
             --without-lzma"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
             --enable-shared \
             --disable-silent-rules \
             --enable-ipv6 \
             --without-python \
             --with-zlib \
             --with-sysroot=$SYSROOT_PREFIX \
             --without-lzma"

post_makeinstall_target() {
  $SED "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" \
    $SYSROOT_PREFIX/usr/bin/xml2-config

  mv $SYSROOT_PREFIX/usr/bin/xml2-config $ROOT/$TOOLCHAIN/bin

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/xml2Conf.sh
}
