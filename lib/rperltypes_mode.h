#ifndef __CPP__INCLUDED__rperltypes_mode_h
#define __CPP__INCLUDED__rperltypes_mode_h 1

// <<< TYPE DEFINES >>>
# ifndef __PERL__TYPES  // if not explicitly set to PERLTYPES mode, and
#  ifndef __CPP__TYPES  // if not explicitly set to CPPTYPES mode
//#define __PERL__TYPES    // then default to PERLTYPES mode
#define __CPP__TYPES    // then default to CPPTYPES mode
#  endif
# endif

#endif
