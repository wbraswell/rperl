RPerl
=====

RPerl is an optimizing compiler for the Perl 5 programming language.  RPerl stands for Restricted Perl, in that we restrict our use of Perl to those parts which can be made to run fast. RPerl also stands for Revolutionary Perl, in that we hope RPerl's speed will revolutionize the software development industry. RPerl might even stand for Roadrunner Perl, in that it RUNS REALLY FAST.

The input to the RPerl compiler is low-magic Perl 5 source code.  RPerl converts the low-magic Perl 5 source code into C++ source code using Perl and/or C++ data structures.  Inline::CPP converts the C++ source code into XS source code.  Perl's XS tools and a standard C++ compiler convert the XS source code into machine-readable binary code, which can be directly linked back into normal high-magic Perl 5 source code.  

The output of the RPerl compiler is fast-running binary code that is exactly equivalent to, and compatible with, the original low-magic Perl 5 source code input.  The net effect is that RPerl compiles slow low-magic Perl 5 code into fast binary code, which can optionally be mixed back into high-magic Perl apps.

Many thanks to irc.perl.org:

#perl5 founder timtoady
#perl6 founder timtoady (again)
#perl11 founders ingy & rurban & Will_the_Chill (yours truly)
#perl11 members bulk88 & mst
#inline founders ingy (again) & nwatkiss
#inline members davido & mohawk

For more information, please see <a href="http://www.rperl.org">http://www.rperl.org</a>

Copyright © 2013, 2014, William N. Braswell, Jr..  All Rights Reserved.  This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.18.0.

For licensing details, please see <a href="http://dev.perl.org/licenses/">http://dev.perl.org/licenses/</a>
