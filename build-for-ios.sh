#! /bin/sh

# Patch the makefile and config.h before running this script
#   The patches can be found at http://www.cryptopp.com/wiki/IOS_(Command_Line).
#   Or copy the updated files from this Github project.
# Place setenv.ios.sh next to the makefile
# Place build-for-ios.sh next to the makefile
# Verify the install path at Step 7
# Run ./build-for-ios.sh

# First, build ARMv7
echo "****************************************"
. ./setenv-ios.sh armv7
make clean
make static
mkdir armv7
\cp libcryptopp.a armv7/libcryptopp.a

# Second, build ARMv7s
echo "****************************************"
. ./setenv-ios.sh armv7s
make clean
make static
mkdir armv7s
\cp libcryptopp.a armv7s/libcryptopp.a

# Third, build i386
echo "****************************************"
. ./setenv-ios.sh i386
make clean
make static
mkdir i386
\cp libcryptopp.a i386/libcryptopp.a

# Fourth, create the fat library
echo "****************************************"
make clean
lipo -create armv7/libcryptopp.a armv7s/libcryptopp.a i386/libcryptopp.a -output ./libcryptopp.a

# Fifth, verify the three architectures are present
echo "****************************************"
xcrun -sdk iphoneos lipo -info libcryptopp.a

# Sixth, remove unneeded artifacts
echo "****************************************"
rm *.so *.exe *.dylib

# Seventh, install the library
echo "****************************************"
sudo make install PREFIX=/usr/local/cryptopp



