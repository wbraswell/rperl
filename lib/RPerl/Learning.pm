# [[[ HEADER ]]]
use RPerl;
package RPerl::Learning;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class

__END__

=head1 NAME

Learning RPerl
or
Let's Write Fast Perl!

Official Reference, User Manual, and Educational Documentation
Restricted Perl, The Optimizing Perl 5 Compiler


=head1 DEDICATION

    For Anna.


=head1 TABLE OF CONTENTS

    FOREWORD
    PREFACE
    CHAPTER 1:  INTRODUCTION
    CHAPTER 2:  SCALAR DATA
    CHAPTER 3:  LISTS & ARRAYS
    CHAPTER 4:  SUBROUTINES
    CHAPTER 5:  INPUT & OUTPUT
    CHAPTER 6:  HASHES
    CHAPTER 7:  REGULAR EXPRESSIONS
    CHAPTER 8:  REGULAR EXPRESSIONS MATCHING
    CHAPTER 9:  REGULAR EXPRESSIONS PROCESSING
    CHAPTER 10: CONTROL STRUCTURES
    CHAPTER 11: CLASSES, PACKAGES, MODULES, LIBRARIES
    CHAPTER 12: FILE TESTS
    CHAPTER 13: DIRECTORY OPERATIONS 
    CHAPTER 14: STRINGS & SORTING
    CHAPTER 15: SMART MATCHING & GIVEN-WHEN
    CHAPTER 16: PROCESS MANAGEMENT
    CHAPTER 17: SOME ADVANCED TECHNIQUES
    APPENDIX A: EXERCISE ANSWERS
    APPENDIX B: BEYOND THE ROADRUNNER
    APPENDIX C: RPERL GRAMMAR


=head1 FOREWORD

    [ INSERT FOREWORD CONTENT HERE ]


=head1 PREFACE

    why I wrote this book
    who I am
    defense / apology
    TPF grant
    history of book
    acknowledgements / thanks


=head1 CHAPTER 1: INTRODUCTION

=head2 Welcome to the Roadrunner Book!
    
    You are about to learn the basic concepts of writing software using the RPerl optimizing compiler for the Perl computer programming language.  With the skills gained by reading this book, you will be empowered to create new super-fast RPerl programs which can be intermixed with existing Perl software available on the Internet.

    This book is named and stylized for the animal mascot for RPerl, Roadie the Roadrunner.  RPerl, like Roadie, I<runs really fast>.
    
=head2 Learning Perl

    This book is purposefully patterned after the popular educational text U<Learning Perl>, affectionately known as the Llama Book.  Both the Roadrunner Book and the Llama book are meant as introductory texts on Perl topics.  The Llama Book is focused on normal (high-magic) Perl, and the Roadrunner Book is focused on optimized (low-magic) Perl.

    This book copies the same chapter topics as Learning Perl, but all content is re-written for RPerl.  Learning RPerl also copies the same exercise concepts as Learning Perl, but all solutions are re-written in RPerl.  Both books are canonical and may be used together in the classroom; the source code solutions are meant to be compared side-by-side as textbook examples of normal Perl versus optimized Perl.

    Please support the Perl community by purchasing a copy of Learning Perl from our friends at O'Reilly:
    
    L<http://shop.oreilly.com/product/0636920018452.do>

=head2 Is this book right for you?

    =over
    =item Are you totally new to computer programming, and you want to learn how to write your first program?
    =item Do you already know Perl, and now you want to make your Perl code run faster?
    =item Do you already know some other computer language, and Perl has always intrigued you?
    =item Do you love learning about new languages and compilers?
    =item Do you miss you favorite old language Perl, and you're looking for a legitimate reason to go back?
    =item Are you a scientist and you just want your code to run really fast without the headaches of C or C++?
    =back

    If you answered "yes" to any of these questions, then the Roadrunner Book is definitely for you!

    If you answered "no" to all of these questions, then this book may still be for you, give it a try!

    If you hate Perl, or only love slow software, or wish all computers would explode, then we suggest some soul-searching and a few Saint Larry videos.  You'll thank us in the morning.

=head2 Why aren't there more footnotes?

    This is a purposefully simple book, in the same way RPerl is a purposefully simple subset of the full Perl 5 programming language.

=head2 What about the exercises & their answers?

    There are one or more programming exercises at the end of every chapter, and full answers to each problem are given near the end of the book in Appendix A.
 
    For maximum educational effect, we suggest you attempt to write each piece of code on your own before looking at our solutions.

    If you are using this as an official textbook for certification or academic credit, such as at LAMPuniversity.org or a traditional school, you are obviously expected to write all your own code without refering to our or anyone else's solutions whatsoever.  We suggest you enclose Appendix A with a paperclip or discard it altogether to avoid the potential for accidental academic dishonesty.

=head2 What do those numbers at the start of the exercise mean?

    The original authors of Learning Perl meant the numbers at each exercise to indicate the approximate number of minutes required for an average person to reach a full working solution.  If it takes you less time, good for you!  If it takes you more time, don't worry, it's no big deal; learning technical skills requires time and dedication.  All experts were once novices.

=head2 What if I'm an RPerl course instructor?

    Thank you for helping spread the love of Perl and the speed of RPerl!

    As previously mentioned, this book may either be used solo or combined with Learning Perl.  For students who are not already familiar with Perl, you may wish to use this text alone in order to simplify and ease the learning experience.  For students who are already familiar with Perl or other dynamic programming languages like the snake or the red gemstone, you may wish to use both textbooks for a more in-depth compare-and-contrast approach.

=head2 What does RPerl stand for?

    RPerl stands for Restricted Perl, in that we restrict our use of Perl to those parts which can be made to run fast.  RPerl also stands for Revolutionary Perl, in that we hope RPerl's speed will revolutionize the software development industry, or at least the Perl community.  RPerl might even stand for Roadrunner Perl, in that it I<runs really fast>.

=head2 Why did Will create RPerl?

    Will loves Perl and the Perl community.

    Will is a scientist and needs his code to run really fast.

    Will doesn't like the hassle of writing code in C or C++ or XS or Inline::C or Inline::CPP.

    Will waited a decade or two before realizing he had to do it himself.

=head2 Why didn't Will just use normal Perl or some other language?

    Dynamic languages like Perl are fast at running some kinds of computational actions, such as string manipulation (editing text data) and reading from a database.
    
    Unfortunately, dynamic languages are slow at running general-purpose computations, such as arithmetic and moving data around in memory.  Sometimes very slow.
    
    Dynamic languages like Perl are also flexible, powerful, and relatively easy to learn.  Sometimes too flexible.
    
    RPerl's goal is to keep all of Perl's power and ease-of-use, while removing the redundant parts of Perl's flexibility in order to gain a major runtime speed boost.

    The most complex and flexible parts of Perl are called "high magic", so RPerl is focused on supporting the "low magic" parts of Perl which can be made to run fast.

=head2 Is RPerl easy or hard?

    RPerl is specifically designed to remove the confusing and complicated parts of Perl.

    RPerl also introduces a number of additional rules and templates which are not present in normal Perl, notably including the use of real data types.

    The net effect of removing Perl complexity and adding RPerl rules falls in favor of RPerl, due primarily to the exceedingly complex nature of Perl.

    In other words, RPerl is easier to learn and use than dynamic languages like normal Perl.

=head2 How did RPerl get to be so popular?

    The RPerl team has been regularly promoting RPerl in a number of physical and digital venues, including but not limited to:
 
    =over
    =item YAPC::NA  L<http://www.yapcna.org>
    =item Austin Perl Mongers  L<http://www.austin.pm>
    =item RPerl Website  L<http://www.rperl.org>
    =item Github  L<https://github.com/wbraswell/rperl>
    =item Facebook Page  L<https://www.facebook.com/rperlcompiler>
    =item Facebook Groups  L<https://www.facebook.com/groups/perlprogrammers>  L<https://www.facebook.com/groups/perlmonger>
    =item Twitter  L<https://twitter.com/rperlcompiler>
    =item PerlMonks  L<http://perlmonks.org>
    =item Perl Blogs  L<http://blogs.perl.org>
    =item IRC #perl11  L<http://irc.perl.org>
    =back

=head2 What is happening with RPerl now?

    As of Q4 2015, RPerl v1.2 (codename Andromeda) has been publicly released and is in use by a number of early adopters around the world.

    RPerl development is proceeding with financial support from both Kickstarter crowdfunding and official grant monies from The Perl Foundation.

    The RPerl community is beginning to grow, and there are a number of exciting RPerl projects currently in the works.  More info coming soon!

=head2 What is RPerl really good for?

    RPerl is a general-purpose programming language, which means you can use RPerl to efficiently and effectively implement virtually any kind of software you can imagine.

    RPerl is especially well-suited for building software which benefits from speed, such as scientific simulations and graphical video games.

    RPerl is also good for building software which utilizes Perl's strong-suit of string manipulation; RPerl currently supports basic string operators, with full regular expression support to be added in an upcoming version.

=head2 What is RPerl not good for?

    RPerl has purposefully disabled the most complex features of Perl, such as run-time code evaluation, secret operators, and punctuation variables.  If you have purposefully designed your Perl software to depend on these high-magic features, or you are unconditionally committed to continue using high-magic language features, then maybe RPerl isn't for you.

=head2 How can I get RPerl?

    You may find the latest major release of RPerl (stable) on CPAN:

    L<https://metacpan.org/author/WBRASWELL>

    You may find the latest development release of RPerl (possibly unstable) on Github:

    L<https://github.com/wbraswell/rperl>

=head2 What is CPAN?

    CPAN is the Comprehensive Perl Archive Network, the world's most successful and mature centralized software network.

    CPAN servers are where most public Perl software is stored, including RPerl.

    L<https://en.wikipedia.org/wiki/CPAN>
 
    L<http://www.cpan.org>

    Several other programming language communities have copied the success and implementation of CPAN, including JSAN for Javascript, CRAN for R, and CCAN for C.

=head2 How can I get support for RPerl?

    Official RPerl technical support is provided through Auto-Parallel Technologies, Inc.
    
    To request more information, please send an e-mail to the following address:
    
    william DOT braswell AT autoparallel DOT com

=head2 Are there any other kinds of support?

    Free technical support for non-commercial users is provided by the RPerl community through IRC.

    IRC #perl11 L<http://irc.perl.org>

=head2 What if I find a bug in RPerl?

    The primary bug-tracking platform for RPerl is Github Issues, where you may file a new bug report ("new issue") if it is not already listed:

    L<https://github.com/wbraswell/rperl/issues>

    Although Github Issues is strongly preferred, the RPerl development team also supports the legacy CPAN ticket system:
    
    L<https://rt.cpan.org/Public/Dist/Display.html?Name=RPerl>

=head2 How do I make an RPerl program?

    Computer programs written using the RPerl language are plain text files, which means you can use any text editor to create and modify your RPerl source code.  Examples of common text editors include Notepad, Pico, and Vi.

    L<http://www.vim.org>

    To avoid possible file format problems, do not edit your RPerl programs using a word processor such as Wordpad, Word, OpenOffice, or LibreOffice.

    Experienced RPerl developers may choose to utilize an integrated development environment (IDE), which is a special text editor made for writing software.  Examples of common Perl IDE applications include Eclipse EPIC, Padre, and Komodo (non-free).

    L<http://www.epic-ide.org>

    L<http://padre.perlide.org>

    L<http://komodoide.com/perl>

=head2 A simple RPerl program

C<
#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]
my number $foo = 21 + 12;
my number $bar = 23 * 42;
print 'have $foo = ', $foo, "\n";
print 'have $bar = ', $bar, "\n";
>

=head2 What's inside that RPerl program?

This program is separated by blank lines into 4 sections: shebang, header, critics, and operations.

The "shebang" always contains one line and is short for "hash bang", referring to the two leading characters C<#!> of this line.  The octothorpe character C<#> (tic-tac-toe symbol) is called a pound sign when used on a telephone, and is called a hash (or more recently "hash tag") when used on a computer.  The exclamation point character C<!> is called a bang when used on a computer.  When appearing together as the first two characters in a plain text file, the hash and bang characters tell the operating system to run the immediately-following command (in this case the Perl interpreter located at F</usr/bin/perl>) and pass the remaining contents of the text file as input to the command.  In other words, if the first line of a plain text file is C<#!/usr/bin/perl>, then that file is a Perl program.

The header always contains 4 lines for an RPerl program file ending in .pl, and 5 lines for an RPerl module ending in .pm (covered later in Chapter 11).  The C<use> Perl keyword (AKA builtin operator) has 2 primary purposes: to load additional RPerl modules, and to enable RPerl "pragma" system configuration modes.  The C<use RPerl;> line is dual-purpose, it both loads the F<RPerl.pm> module and enables the special RPerl low-magic pragma.  The C<use strict;> and C<use warnings;> lines enable the most basic Perl pragmas to require decent programming practices.  The C<our $VERSION = 0.001_000;> line sets the numeric version number of this RPerl program.

# START HERE: critics & operations
# START HERE: critics & operations
# START HERE: critics & operations


=head2 How do I compile RPerl?
=head2 A whirlwind tour of RPerl
 
=head2 Exercises
=head2 LMPC
=head2 history of RPerl
=head2 Book of RPerl
=head2 performance


=head1 APPENDIX A: EXERCISE ANSWERS

    2a.  Complete source code of solutions to chapters 1 - 6
    2b.  Describe how to arrive at each solution


=head1 APPENDIX B: BEYOND THE ROADRUNNER

    The Scallion
    The Sword


=head1 APPENDIX C: RPERL GRAMMAR

    1a.  Describe Eyapp EBNF grammar format and Grammar.eyp file sections
    1b.  Describe lexical token types
    1c.  Describe operator precedence and associativity
    1d.  Describe all grammar rules and productions
    1e.  Provide examples of valid code


=head1 SEE ALSO

L<RPerl>
L<rperl>


=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:wbraswell@NOSPAM.cpan.org>

=cut
