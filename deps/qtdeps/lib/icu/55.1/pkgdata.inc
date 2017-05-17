GENCCODE_ASSEMBLY_TYPE=-a gcc
SO=so
SOBJ=so
A=a
LIBPREFIX=lib
LIB_EXT_ORDER=.55.1
COMPILE=arm-linux-gnueabihf-gcc -D_REENTRANT  -DU_HAVE_ELF_H=1 -DU_HAVE_ATOMIC=1  -DU_ATTRIBUTE_DEPRECATED= -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -funsafe-math-optimizations -lm -mno-apcs-stack-check -mstructure-size-boundary=32 -mno-sched-prolog -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings   -c
LIBFLAGS=-I/home/luca/project/pi/icu/icu_build_rpi/include -DPIC -fPIC
GENLIB=arm-linux-gnueabihf-gcc -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -funsafe-math-optimizations -lm -mno-apcs-stack-check -mstructure-size-boundary=32 -mno-sched-prolog -std=c99 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings    -shared -Wl,-Bsymbolic
LDICUDTFLAGS=-nodefaultlibs -nostdlib
LD_SONAME=-Wl,-soname -Wl,
RPATH_FLAGS=
BIR_LDFLAGS=-Wl,-Bsymbolic
AR=arm-linux-gnueabihf-ar
ARFLAGS=r
RANLIB=arm-linux-gnueabihf-ranlib
INSTALL_CMD=/usr/bin/install -c
