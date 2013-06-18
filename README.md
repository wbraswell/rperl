qrperl
=====

RPerl is an implementation of the Perl 11 philosophy (perl11.org) in the form of an optimizing Perl 5 compiler.

RPerl translates a low-magic subset of the Perl 5 language into equivalent C/C++ code utilizing Perl data structures, capable of being called directly from Perl 5 code using the Inline::C and Inline::CPP modules.  Any existing C/C++ compiler may be used to compile and optimize the resulting C/C++ code.

RPerl follows the naming convention of RPython, in that each implements a restricted sub-set of their respective parent language, thus RPerl stands for Restricted Perl.  It is hoped that RPerl will also eventually come to stand for Revolutionary Perl. 

The RPerl development board may be found on Trello here:

https://trello.com/board/austin-pm-rperl-development/51b6b97215f60f9460006538

The RPerl source code repository may be found on Github here:

https://github.com/wbraswell/rperl/

RPerl is copyright (c) 2013, William N. Braswell, Jr.

RPerl is made available under the same terms as Perl itself:

http://dev.perl.org/licenses/
