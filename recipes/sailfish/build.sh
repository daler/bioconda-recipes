#!/bin/bash
set -eu -o pipefail

# fix autoconf
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/autom4te
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/autoheader 
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/autoreconf 
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/ifnames 
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/autoscan 
sed -i.bak 's|/usr/bin/perl|/usr/bin/env perl|' bin/autoupdate

mkdir -p build
sed -i 's/Boost_USE_STATIC_LIBS ON/Boost_USE_STATIC_LIBS OFF/' CMakeLists.txt
cd build
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DBOOST_ROOT=$PREFIX -DBoost_NO_SYSTEM_PATHS=ON -DBoost_DEBUG=ON ..
make install
