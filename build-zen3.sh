#!/bin/bash
#
# This script is not intended for users, it is only used for compile testing
# during develpment. However the information contained may provide compilation
# tips to users.

#!/bin/bash
#
# This script is not intended for users, it is only used for compile testing
# during develpment. However the information contained may provide compilation
# tips to users.

rm -r bin/unix 2>/dev/null
rm cpuminer 2>/dev/null
mkdir -p bin/unix/ 2>/dev/null

DCFLAGS="-Wall -fno-common -Wextra -Wno-missing-field-initializers"
DCXXFLAGS="-Wno-ignored-attributes"

# 1 - Architecture
# 2 - Output suffix
# 3 - Additional options
compile() {

  echo "Compile: $@" 1>&2
  make distclean || echo clean
  rm -f config.status
  ./autogen.sh || echo done
  CFLAGS="-O3 -march=${1} ${3} ${DCFLAGS}" \
  CXXFLAGS="$CFLAGS -std=c++20 ${DCXXFLAGS}" \
  ./configure --with-curl
  make -j $(nproc)
  strip -s cpuminer
  mv cpuminer bin/unix/${4}/cpuminer-${2}

}


# AMD Zen3 AVX2 SHA VAES
# GCC 10
compile "znver3" "zen3" "-mtune=znver3"
