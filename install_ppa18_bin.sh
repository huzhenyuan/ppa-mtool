#!/bin/bash


if [ $# -lt 3 ]; then
    echo $0 package version release-version
    exit 1
fi

curdir=`pwd`

pkg=$1
version=$2
rversion=$3
vr=${version}-${rversion}


pkgv=${pkg}-${version}


echo ${pkg} ${pkgv}

rm -rf ${pkg}-${version}*
rm -rf ${pkg}_${version}*


# begin
cp -r ${pkg} ${pkgv}

tar -jcf ${pkgv}.tar.bz2 ${pkgv}

# in source dir

cd ${pkgv}

dh_make -e support@platon.network -f ../${pkgv}.tar.bz2

# debian ............
cp -r ../debians/debian-${pkg}/* debian/

sed 's/unstable/bionic/g' -i debian/changelog
sed -E 's/\((.*)\)/\('${vr}'\)/g' -i debian/changelog

# source dir ............
debuild -S -sa -kDAFFDFD8

# local build and test
if [ $# -eq 4 ]; then
    echo "local build and test"
   dpkg-buildpackage -kDAFFDFD8
fi

cd ../

# upload
if [ $# -eq 5 ]; then
    dput ppa:platonnetwork/platontest ${pkg}_${vr}_source.changes
fi

