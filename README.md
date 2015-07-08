RPerl
=====

RPerl is the optimizing compiler for the Perl 5 programming language.  RPerl stands for Restricted Perl, in that we restrict our use of Perl to those parts which can be made to run fast.

The input to the RPerl compiler is low-magic Perl 5 source code.  RPerl converts the low-magic Perl 5 source code into C++ source code using Perl and/or C++ data structures.  Inline::CPP converts the C++ source code into XS source code.  Perl's XS tools and a standard C++ compiler convert the XS source code into machine-readable binary code, which can be directly linked back into normal high-magic Perl 5 source code.  

The output of the RPerl compiler is fast-running binary code that is exactly equivalent to, and compatible with, the original low-magic Perl 5 source code input.  The net effect is that RPerl compiles slow low-magic Perl 5 code into fast binary code, which can optionally be mixed back into high-magic Perl apps.

Please see the `rperl` command documentation for usage information:

<a href="https://metacpan.org/pod/distribution/RPerl/script/rperl">https://metacpan.org/pod/distribution/RPerl/script/rperl</a>

Please see the RPerl website for non-technical information:

<a href="http://www.rperl.org">http://www.rperl.org</a>
