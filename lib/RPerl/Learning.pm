# [[[ HEADER ]]]
use RPerl;
package RPerl::Learning;
use strict;
use warnings;
our $VERSION = 0.011_000;

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

=encoding utf8

=head1 NAME

Learning RPerl

=head1 BOOK TITLE

X<u>B<Learning RPerl>X</u>

~ or ~

X<u>B<Let's Write Fast Perl!>X</u>

.
X<br>

...
X<br>

.....
X<br>

.......
X<br>

being
X<br>

.......
X<br>

.....
X<br>

...
X<br>

.

B<The Official Introductory-Level Reference, User Manual, and Educational Documentation>

~ for ~

B<Restricted Perl, The Optimizing Perl 5 Compiler>

X<br>


=head1 DEDICATION

For Anna.

X<br>


=head1 TABLE OF CONTENTS: CHAPTERS AT-A-GLANCE

=over

=item * L</FOREWORD>

=item * L</PREFACE>

=item * L</CHAPTER 1: INTRODUCTION>

=item * L</CHAPTER 2: SCALAR DATA>

=item * L</CHAPTER 3: LISTS & ARRAYS>

=item * L</CHAPTER 4: SUBROUTINES>

=item * L</CHAPTER 5: INPUT & OUTPUT>

=item * L</CHAPTER 6: HASHES>

=item * L</CHAPTER 7: REGULAR EXPRESSIONS>

=item * L</CHAPTER 8: REGULAR EXPRESSIONS MATCHING>

=item * L</CHAPTER 9: REGULAR EXPRESSIONS PROCESSING>

=item * L</CHAPTER 10: CONTROL STRUCTURES>

=item * L</CHAPTER 11: CLASSES, PACKAGES, MODULES, LIBRARIES>

=item * L</CHAPTER 12: FILE TESTS>

=item * L</CHAPTER 13: DIRECTORY OPERATIONS>

=item * L</CHAPTER 14: STRINGS & SORTING>

=item * L</CHAPTER 15: SMART MATCHING & GIVEN-WHEN>

=item * L</CHAPTER 16: PROCESS MANAGEMENT>

=item * L</CHAPTER 17: SOME ADVANCED TECHNIQUES>

=item * L</APPENDIX A: EXERCISE ANSWERS>

=item * L</APPENDIX B: BEYOND THE ROADRUNNER>

=item * L</APPENDIX C: RPERL GRAMMAR>

=back

X<br>


=head1 FOREWORD

    [ INSERT FOREWORD CONTENT HERE ]

X<br>


=head1 PREFACE

=head2 Section 0.1: Who I Am

[INSERT WHO]

=head2 Section 0.2: Why I Wrote This Book

[INSERT WHY]

=head2 Section 0.3: History Of This Book

[INSERT WHEN]

=head2 Section 0.4: TPF Grant

[INSERT MONEY]

=head2 Section 0.5: Acknowledgements & Thanks

[INSERT THEM]

=head2 Section 0.6: Defense / Apology

[INSERT SORRY]

=head2 Section 0.7: POD

"The Pod format is not necessarily sufficient for writing a book."

L<http://perldoc.perl.org/perlpod.html>

~ Saint Larry Wall & Sean M. Burke

X<br>

"Challenge accepted."

~ Will Braswell

X<br>


=head1 CHAPTER 1: INTRODUCTION

=head2 Section 1.1: Welcome To The Roadrunner Book!

You are about to learn the basic concepts of writing software using the RPerl optimizing compiler for the Perl computer programming language.  With the skills gained by reading this book, you will be empowered to create new super-fast RPerl programs which can be intermixed with the enormous amount of existing Perl software available on the Internet.

This book is named and stylized for the animal mascot for RPerl, Roadie the Roadrunner.  RPerl, like Roadie, I<"runs really fast">.

Throughout this text, the following typography conventions are utilized:

=over 16

=item * "Literal Quotation"

=item * I<"First Occurrence Of Key Concept">

=item * I<Emphasis>

=item * B<Stronger Emphasis>

=item * F</path/to/program.pl>

=item * B<I<Program Name>>

=item * X<u>B<Book Title>X</u>

=item * X<u>I<BEST PRACTICES>X</u>

=item * C<my string $source_code;>

=item * C<$ terminal_command.sh>

=back
    
=head2 Section 1.2: Learning Perl

This book is purposefully patterned after the popular educational text X<u>B<Learning Perl>X</u>, affectionately known as the Llama Book.  Both the Roadrunner Book and the Llama book are meant as introductory texts on Perl topics.  The Llama Book is focused on normal Perl, and the Roadrunner Book is focused on optimized Perl.

This book copies the same chapter topics as X<u>B<Learning Perl>X</u>, but all content is re-written for RPerl.  X<u>B<Learning RPerl>X</u> also copies the same exercise concepts as X<u>B<Learning Perl>X</u>, but all solutions are re-written in RPerl.  Both books are canonical and may be used together in the classroom; the source code solutions are meant to be compared side-by-side as textbook examples of normal Perl versus optimized Perl.

Please support the Perl community by purchasing a copy of X<u>B<Learning Perl>X</u> from our friends at O'Reilly:

L<http://shop.oreilly.com/product/0636920018452.do>

=head2 Section 1.3: Is This Book Right For You?

=over

=item * Are you totally new to computer programming, and you want to learn how to write your first program?

=item * Do you already know Perl, and now you want to make your Perl code run faster?

=item * Do you already know some other computer language, and Perl has always intrigued you?

=item * Do you love learning about new languages and compilers?

=item * Do you miss you favorite old language Perl, and you're looking for a legitimate reason to go back?

=item * Are you a scientist and you just want your code to run really fast without the headaches of C or C++?

=back

If you answered "yes" to any of these questions, then the Roadrunner Book is definitely for you!

If you answered "no" to all of these questions, then this book may still be for you, give it a try!

If you hate Perl, or only love slow software, or wish all computers would explode, then we suggest some soul-searching and a few Saint Larry videos.  You'll thank us in the morning.

=head2 Section 1.4: Why Aren't There More Footnotes?

This is a purposefully simple book, in the same way RPerl is a purposefully simple subset of the full Perl 5 programming language.

=head2 Section 1.5: What About The Exercises & Their Answers?

There are one or more programming exercises at the end of every chapter, and full answers to each problem are given near the end of the book in Appendix A.

For maximum educational effect, we suggest you attempt to write each piece of code on your own before looking at our solutions.

If you are using this as an official textbook for certification or academic credit, such as at LAMPuniversity.org or a traditional school, you are obviously expected to write all your own code without refering to our or anyone else's solutions whatsoever.  We suggest you enclose Appendix A with a paperclip or discard it altogether to avoid the potential for accidental academic dishonesty.

=head2 Section 1.6: What Do Those Numbers At The Start Of The Exercise Mean?

The original authors of X<u>B<Learning Perl>X</u> meant the numbers at each exercise to indicate the approximate number of minutes required for an average person to reach a full working solution.  If it takes you less time, good for you!  If it takes you more time, don't worry, it's no big deal; learning technical skills requires time and dedication.  All experts were once novices.

=head2 Section 1.7: What If I'm An RPerl Course Instructor?

Thank you for helping spread the love of Perl and the speed of RPerl!

As previously mentioned, this book may either be used solo or combined with Learning Perl.  For students who are not already familiar with Perl, you may wish to use this text alone in order to simplify and ease the learning experience.  For students who are already familiar with Perl or other dynamic programming languages like the snake or the red gemstone, you may wish to use both textbooks for a more in-depth compare-and-contrast approach.

=head2 Section 1.8: What Does RPerl Stand For?

RPerl stands for I<"Restricted Perl">, in that we restrict our use of Perl to those parts which can be made to run fast.  RPerl also stands for I<"Revolutionary Perl">, in that we hope RPerl's speed will revolutionize the software development industry, or at least the Perl community.  RPerl might even stand for I<"Roadrunner Perl">, in that it I<runs really fast>.

=head2 Section 1.9: Why Did Will Create RPerl?

Will loves Perl and the Perl community.

Will is a scientist and needs his code to run really fast.

Will doesn't like the hassle of writing code in C or C++ or XS or Inline::C or Inline::CPP.

Will waited a decade or two before realizing he had to do it himself.

=head2 Section 1.10: Why Didn't Will Just Use Normal Perl Or Some Other Language?

Dynamic languages like Perl are fast at running some kinds of computational actions, such as string manipulation (editing text data) and reading from a database.

Unfortunately, dynamic languages are slow at running general-purpose computations, such as arithmetic and moving data around in memory.  Sometimes very slow.

Dynamic languages like Perl are also flexible, powerful, and relatively easy to learn.  Sometimes too flexible.

RPerl's goal is to keep all of Perl's power and ease-of-use, while removing the redundant parts of Perl's flexibility in order to gain a major runtime speed boost.

The most complex and flexible parts of Perl are called I<"high magic">, so RPerl is focused on supporting the I<"low magic"> parts of Perl which can be made to run fast.

=head2 Section 1.11: Is RPerl Easy Or Hard?

RPerl is specifically designed to remove the confusing and complicated parts of Perl.

RPerl also introduces a number of additional rules and templates which are not present in normal Perl, notably including the use of real data types.

The net effect of removing Perl complexity and adding RPerl rules falls in favor of RPerl, due primarily to the exceedingly complex nature of Perl.

In other words, RPerl is easier to learn and use than dynamic languages like normal Perl, and most any other language in general.

=head2 Section 1.12: How Did RPerl Get To Be So Popular?

The RPerl team has been regularly promoting RPerl in a number of physical and digital venues, including but not limited to:

=over

=item * YAPC::NA  L<http://www.yapcna.org>

=item * Austin Perl Mongers  L<http://www.austin.pm>

=item * RPerl Website  L<http://www.rperl.org>

=item * Github  L<https://github.com/wbraswell/rperl>

=item * Facebook Page  L<https://www.facebook.com/rperlcompiler>

=item * Facebook Groups  L<https://www.facebook.com/groups/perlprogrammers>  L<https://www.facebook.com/groups/perlmonger>

=item * Twitter  L<https://twitter.com/rperlcompiler>

=item * PerlMonks  L<http://perlmonks.org>

=item * Perl Blogs  L<http://blogs.perl.org>

=item * IRC #perl11  L<http://irc.perl.org>

=back

=head2 Section 1.13: What Is Happening With RPerl Now?

As of Q4 2015, RPerl v1.2 (codename I<Andromeda>) has been publicly released and is in use by a number of early adopters around the world.

RPerl development is proceeding with financial support from both Kickstarter crowdfunding and official grant monies from The Perl Foundation.

The RPerl community is beginning to grow, and there are a number of exciting RPerl projects currently in the works.  More info coming soon!

=head2 Section 1.14: What Is RPerl Really Good For?

RPerl is a general-purpose programming language, which means you can use RPerl to efficiently and effectively implement virtually any kind of software you can imagine.

RPerl is especially well-suited for building software which benefits from speed, such as scientific simulations and graphical video games.

RPerl is also good for building software which utilizes Perl's strong-suit of string manipulation; RPerl currently supports basic string operators, with full regular expression support to be added in an upcoming version.

=head2 Section 1.15: What Is RPerl Not Good For?

RPerl has purposefully disabled the most complex features of Perl, such as run-time code evaluation, secret operators, and punctuation variables.  If you have purposefully designed your Perl software to depend on these high-magic features, or you are unconditionally committed to continue using high-magic language features, then maybe RPerl isn't for you.

=head2 Section 1.16: How Can I Get RPerl?

Installing RPerl ranges from easy to difficult, depending on how well your operating system supports Perl and C++.

On modern operating systems with good Perl support, such as Debian or Ubuntu GNU/Linux, you should be able to install RPerl system-wide by running the following command at your terminal command prompt:

    $ sudo cpan RPerl

If RPerl is properly installed, you should see a short text message displayed when you type the following command:

    $ rperl -v

On operating systems with less Perl support, you may have to perform a number of steps to successfully install RPerl, with dry technical detail available in the INSTALL notes document:

L<https://github.com/wbraswell/rperl/blob/master/INSTALL>

Unless you are an experienced programmer or system administrator, it is B<strongly> recommended you use the Xubuntu operating system.  You can download the Xubuntu ISO file at the link below, then use it to create a bootable DVD disc or USB flash drive, install Xubuntu onto any computer, and issue the C<$ sudo cpan RPerl> command as described above.

L<http://xubuntu.org/getxubuntu>

If you are interested in viewing the source code of RPerl itself, you may find the latest major release of RPerl (stable) on CPAN:

L<https://metacpan.org/author/WBRASWELL>

You may find the latest development release of RPerl (possibly unstable) on Github:

L<https://github.com/wbraswell/rperl>

=head2 Section 1.17: What Is CPAN?

CPAN is the I<"Comprehensive Perl Archive Network">, the world's most successful and mature centralized software network.

CPAN servers are where most public Perl software is stored, including RPerl.

L<https://en.wikipedia.org/wiki/CPAN>

L<http://www.cpan.org>

Several other programming language communities have copied the success and implementation of CPAN, including JSAN for Javascript, CRAN for R, and CCAN for C.

=head2 Section 1.18: How Can I Get Support For RPerl?

Official RPerl technical support is provided through Auto-Parallel Technologies, Inc.

To request more information, please send an e-mail to the following address:

william DOT braswell AT autoparallel DOT com

=head2 Section 1.19: Are There Any Other Kinds Of Support?

Free technical support for non-commercial users is provided by the RPerl community through IRC.

IRC #perl11 L<http://irc.perl.org>

=head2 Section 1.20: What If I Find A Bug In RPerl?

The primary bug-tracking platform for RPerl is Github Issues, where you may file a new bug report ("new issue") if it is not already listed:

L<https://github.com/wbraswell/rperl/issues>

Although Github Issues is strongly preferred, the RPerl development team also supports the legacy CPAN ticket system:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=RPerl>

=head2 Section 1.21: How Do I Make An RPerl Program?

Computer programs written using the RPerl language are plain text files, which means you can use any text editor to create and modify your RPerl source code.  Examples of common text editors include Notepad, Pico, and Vi.

L<http://www.vim.org>

To avoid possible file format problems, do not edit your RPerl programs using a word processor such as Wordpad, Word, OpenOffice, or LibreOffice.

Experienced RPerl developers may choose to utilize an I<"integrated development environment"> (IDE), which is a special text editor made for writing software.  Examples of common Perl IDE applications include Eclipse EPIC, Padre, and Komodo (non-free).

L<http://www.epic-ide.org>

L<http://padre.perlide.org>

L<http://komodoide.com/perl>

=head2 Section 1.22: A Simple RPerl Program

    #!/usr/bin/perl

    # Learning RPerl, Chapter 1, Exercise 3
    # Foo Bar Arithmetic Example

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
    print 'have $foo = ' . $foo . "\n";
    print 'have $bar = ' . $bar . "\n";

=head2 Section 1.23: What Is Inside That RPerl Program?

This program is separated by blank lines into 4 sections: shebang, header, critics, and operations.  

Other than the shebang and critics, all lines beginning with C<#> are comments and can be safely ignored or discarded without affecting the program.

The I<"shebang"> section is required, always contains exactly 1 line, and is short for I<"hash bang">; referring to the two leading characters C<#!> of this line.  The I<"octothorpe"> character C<#> (tic-tac-toe symbol) is called a I<"pound sign"> when used on a telephone, and is called a I<"hash"> (or more recently and less accurately I<"hash tag">) when used on a computer.  The exclamation point character C<!> is called a I<"bang"> when used on a computer.  When appearing together as the first two characters in a plain text file, the hash and bang characters tell the operating system to run the immediately-following command (in this case the Perl interpreter located at F</usr/bin/perl>) and pass the remaining contents of the text file as input to the command.  In other words, if the first line of a plain text file is C<#!/usr/bin/perl>, then that file is a Perl program.

The I<"header"> section is required and always contains 4 lines for an RPerl I<"program"> file ending in F<.pl>, or 5 lines for an RPerl I<"module"> ending in F<.pm> (covered later in Chapter 11).  C<use> is recognized by Perl as a special I<"keyword"> (AKA I<"builtin operator">) which has 2 primary purposes: to load additional RPerl modules, and to enable RPerl I<"pragma"> system configuration modes.  The C<use RPerl;> line is dual-purpose, it both loads the F<RPerl.pm> module and enables the special RPerl low-magic pragma.  The C<use strict;> and C<use warnings;> lines enable basic Perl pragmas which require decent programming practices by the human programmers.  The C<our $VERSION = 0.001_000;> line sets the version number of this RPerl program.

The I<"critics"> section is included as necessary and may contain 1 or more lines beginning with C<## no critic>, which disable the errors caused by the over-restrictive nature of some Perl::Critic policies.  There are currently 6 critics commands enabled for normal RPerl users, the first 2 of which are given in this example.  The C<USER DEFAULT 1> critics command allows the use of numeric values such as C<21> and C<12>, as well as the common C<print> command.  The C<USER DEFAULT 2> critics command allows the printing of C<'have $foo = '>, where a single-quoted C<'> string literal value contains the the C<$> dollar sigil (covered later in Chapter 2).

The I<"operations"> section is required and contains 1 or more lines of general-purpose RPerl source code.  This is the main body of your program.  The 4 lines of source code in our example are used to perform some simple arithmetic and display the results.  The C<my number $foo = 21 + 12;> line declares a new variable named C<$foo> which will only contain floating-point numeric data, and which is initialized to contain the arithmetic result of numeric literal values C<21> plus C<12>.  The C<my number $bar = 23 * 42;> line does much the same thing, creating a new numeric variable named C<$bar> and initialized with C<23> times C<42>.  The C<print 'have $foo = ' . $foo . "\n";> and C<print 'have $bar = ' . $bar . "\n";> lines will display on screen (not send to paper printer) the labeled values of C<$foo> and C<$bar> respectively.  The C<.> dot operator is string concatenation, used in this example to create one string out of 3 parts so there is only 1 argument parameter passed to the C<print> command.  The "n" in the C<"\n"> double-quoted string literal values stands for "newline", which inserts a carriage return to place the next piece of printed data down on the following line.

=head2 Section 1.24: How Do I Compile RPerl?

Normal Perl source code is executed using a software mechanism known as I<"interpretation">, which is to say that Perl is an I<"interpreted"> language and the F</usr/bin/perl> command is called the I<"Perl interpreter">.  The primary alternative to interpretation is I<"compilation">, so RPerl is a I<"compiled"> subset of the Perl language and the F</usr/bin/rperl> command is called the I<"RPerl compiler">.

Like the Perl interpreter, the RPerl compiler accepts 2 different input file types: Perl programs which end in F<.pl> and Perl modules which end in F<.pm>.  Perl program files actually run and execute actions, optionally receiving some functionality from 1 or more Perl module files if specified.  Perl modules do not run or execute actions themselves, they only provide functionality which must in turn be called from a Perl program, or from another Perl module which eventually gets called by a Perl program.

B<I<CURRENT RPERL LIMITATION: RPerl modules are supported in full compile mode, but RPerl programs are supported in test interpret mode only, to be updated in a forthcoming RPerl release.>>

A list of all valid RPerl compiler options may be seen by issuing the following command:

    $ rperl -?

You may find the same information by viewing the following links:

L<rperl>

L<https://metacpan.org/pod/distribution/RPerl/script/rperl>

To partially-compile-then-execute the preceeding RPerl example program in test mode, you may copy and paste the entire program (from shebang to second C<print>) into a temporary file such as F</tmp/foobar.pl>, then execute the following command:

    $ rperl -t /tmp/foobar.pl

The output of this example program should be:

    have $foo = 33
    have $bar = 966

Please see L</CHAPTER 11: CLASSES, PACKAGES, MODULES, LIBRARIES> for more information about compiling Perl modules.


=head2 Section 1.25: A Whirlwind Tour of RPerl

=head3 Section 1.25.1: Creator Of RPerl, Will Braswell

Will Braswell does more than just create Perl compiler software, he is also very active in several other areas of life, including but not limited to:

=over

=item * Church & Spirituality

=item * Boy Scouts of America

=item * Cane Juggling & Circus Performance

=item * Linux Operating Systems

=item * Charitable & Fraternal Organizations

=item * Homeschooling & Higher Education

=item * Astrophysics & Mathematics

=item * Entrepreneuriship & Business

=item * High-Performance Computing

=item * Professional Space Exploration

=item * Family Life

=back

These areas of interest are reflected in the tone and intention of RPerl.

=head3 Section 1.25.2: History Of RPerl

The RPerl project officially began as a New Year's Resolution on January 1st, 2013.  Following the grand tradition of Perl creator I<"Saint" Larry Wall>, RPerl version releases are often timed to coincide with major holidays.

After 1 year of work, RPerl v1.0beta1 was released on New Year's Day 2014, eventually followed by RPerl v1.0beta2 on Christmas 2014.

The much-anticipated RPerl v1.0 full release was made on US Independence Day 2015, and RPerl v1.2 came on Halloween 2015.

RPerl v1.3 is scheduled for release on Thanksgiving 2015, then RPerl v2.0beta1 on Christmas 2015, and so on.

RPerl v1.0 was funded through a Kickstarter campaign, then RPerl v1.2 and v1.3 were funded through a second Kickstarter campaign.  Work on the first 6 chapters of this book was funded through a grant from The Perl Foundation.

=head3 Section 1.25.3: Performance Of RPerl

The question of I<"How fast is RPerl?"> does not have one simple answer; instead there are several factors and configuration modes to be taken into consideration.  A relatively detailed description of the performance and modes may be found at the following link:

L<http://rperl.org/performance_benchmarks.html>

The most condensed answer is that I<"RPerl is really fast.">  Utilizing RPerl's fastest execution modes, we see performance very close to the highly-optimized I<C++> programming language, which means RPerl is now among the short list of "world's fastest languages" along with C, C++, and Fortran.

=head3 Section 1.25.4: The Low-Magic Perl Commandments

The high-magic features of Perl are primarily responsible for how slow Perl runs for general-purpose computations.  The I<"R"> in RPerl stands for I<"Restricted">, in that we restrict ourselves to only use the low-magic features of Perl which can run really fast.

The definitive list of do's and do-nots for high-magic vs low-magic Perl programming is called I<The Low Magic Perl Commandments> (LMPC).  There are 64 total commandments split into 5 groups of Ideals, Magic, Data, Operations, and Object-Orientation.  The "Thou Shalt" commandments appear in the left column, and the "Thou Shalt Nots" appear on the right.

L<http://rperl.org/the_low_magic_perl_commandments.html>

The LMPC draw inspiration from, and (wherever possible) work together with Damian Conway's X<u>B<Perl Best Practices>X</u> and Jeffrey Thalhammer's Perl::Critic software.

L<http://shop.oreilly.com/product/9780596001735.do>

L<http://search.cpan.org/~thaljef/Perl-Critic/lib/Perl/Critic/PolicySummary.pod>

=head3 Section 1.25.5: The Book Of RPerl

I<Perlism> is the computer religion dedicated to the use, promotion, and development of the Perl family of programming languages.  (Not to be confused with a spiritual religion such as Christianity, a computer religion such as Perlism is an independent and complementary belief structure.)

A I<Perlite> is an adherent to the Perlism religion.  Perlism has a revered founder, Saint Larry (himself a devout Christian); a prophet, I<The Voice In The Wilderness> (Will); a monastary and shrine, I<Perl Monks>; commandments, The LMPC; proverbs from Saint Larry including I<TIMTOWTDI>, I<LMFB>, and I<HTAAOF>; and canonical scriptures, including Saint Larry's X<u>B<Apocalypses>X</u> and The Voice's X<u>B<The Book Of RPerl>X</u>.

The Book is a description of events surrounding the creation of RPerl and the future of the Internet.  It is intended to both educate and entertain.

L<http://rperl.org/the_book_of_rperl.html>

=head2 Section 1.26: Exercises

=head3 1.  Hello World  [ 15 mins ]

On a computer with RPerl already installed, create a directory named F<LearningRPerl> containing a sub-directory named F<Chapter1>.  Using the B<I<Foo Bar>> example program as a template, manually type a new RPerl program into a file named F<exercise_1-hello_world.pl> inside the F<LearningRPerl/Chapter1> sub-directory.  The sole purpose of your first program is to use the C<print> operator and simply display the following one line of text output, followed by one newline character:

    Hello, World!

Run your new program by issuing the following command at your terminal command prompt:

    $ rperl -t LearningRPerl/Chapter1/exercise_1-hello_world.pl

I<HINT: You only need the C<USER DEFAULT 1> critic line, so your resulting program should be 7 lines long, not counting comments or blank lines.>

=head3 2.  RPerl Commands  [ 15 mins ]

Run the following RPerl commands and observe the output.

    $ rperl -?

2a.  What are some RPerl command-line options with which you are already familiar?
2b.  With which options are you unfamiliar?

    $ rperl -t -V LearningRPerl/Chapter1/exercise_1-hello_world.pl
    $ rperl -t -D LearningRPerl/Chapter1/exercise_1-hello_world.pl
    $ rperl -t -V -D LearningRPerl/Chapter1/exercise_1-hello_world.pl

2c.  How do the outputs of these 3 commands differ from the output of Exercise 1?
2d.  How do the outputs differ from one another?

=head3 3.  Foo Bar Arithmetic  [ 15 mins ]

Manually type the entire B<I<Foo Bar>> example program into a file named F<exercise_3-foo_bar_arithmetic.pl> inside the F<LearningPerl/Chapter1> sub-directory.  (Even if you have already used copy-and-paste on the B<I<Foo Bar>> example program, you should still use this as an opportunity to build some RPerl muscle memory and type it in by hand.)

Modify your program by adding an extra numeric variable named C<$baz>, set its value to C<$bar / $foo>, and use C<print> to generate the following output:

    have $foo = 33
    have $bar = 966
    have $baz = 29.2727272727273

Run your program thusly:

    $ rperl -t LearningRPerl/Chapter1/exercise_3-foo_bar_arithmetic.pl

X<br>


=head1 CHAPTER 2: SCALAR DATA

Most programming languages include the basic principles of using named I<"variables"> to store data values such as numbers, text strings, and lists of multiple numbers or strings.  Multiple variables may be created, each with different names such as C<$foo> or C<$bar> or C<$quux>, and each potentially containing a different value.

A single piece of data, such as one number or one string, is called a I<"scalar">.  Multiple pieces of data combined into a single aggregate structure may be either an I<"array"> or a I<"hash">, described in chapters 3 and 6, respectively.  (Although sharing the same terminology, the I<hash> data structure is not related to the I<hash> C<#> tic-tac-toe character.)  In normal Perl, only scalar variable names begin with the C<$> dollar sign I<"sigil">, while aggregate data structures are stored in variables starting with different sigils like C<@> or C<%>.  In RPerl, all variable names begin the C<$> sigil, both scalar types and aggregate structures alike.

RPerl provides 7 scalar data types:

=over

=item * C<boolean>

=item * C<unsigned_integer>

=item * C<integer> (core)

=item * C<gmp_integer>

=item * C<number> (core)

=item * C<char>

=item * C<string> (core)

=back

START HERE: add blurb about core types, add unsigned_integer & gmp_integer examples & sections
START HERE: add blurb about core types, add unsigned_integer & gmp_integer examples & sections
START HERE: add blurb about core types, add unsigned_integer & gmp_integer examples & sections

A single group of actual numeric digit(s) or quoted string character(s) is called a I<"literal">, such as:

    -21         # integer or number

    'howdy'     # string

    -23.421_12  # number

    1_234_567   # integer or number

    'One million, two-hundred-thirty-four thousand, five-hundred-sixty-seven'  # string

    "\n"        # newline char or string

    '1'         # char or string

    q{}         # empty char or string

    0           # boolean or integer or number

=head2 Section 2.1: Numbers (Numeric Data)

RPerl provides 3 numeric data types:

=over

=item * C<boolean>

S< >S< >S< >S< >a boolean logic value, either 0 or 1

=item * C<integer>

S< >S< >S< >S< >a whole number value, either negative, 0, or positive

=item * C<number>

S< >S< >S< >S< >a floating-point decimal number value, either negative, 0, or positive

=back

=head3 Section 2.1.1: Bool Literals

The most memory-efficient numeric literal is C<boolean>, which represents a single I<"bit"> (binary digit) of information.  A C<boolean> literal may only give the values of exactly 0 or 1.

    0     # boolean
    1     # boolean
    -1    # not a boolean
    1.5   # not a boolean
    -1.5  # not a boolean

=head3 Section 2.1.2: Integer Literals

The next most efficient numeric literal is C<integer>, which represents a single whole (non-decimal) number.  An C<integer> literal may describe any positive or negative whole number, within the data size limits of your operating system and computer hardware.

    -23     # integer
    0       # integer
    42_230  # integer
    42.1    # not an integer
    -999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999  # bad integer, outside limits

=head3 Section 2.1.3: Number Literals

The C<number> numeric literal represents a single floating-point (decimal) number, and may express any real number within your computer's limits.

    -23.42     # number
    0.000_001  # number
    42.23      # number
    42         # number
    -4_123.456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456  # bad number, outside limits

=head3 Section 2.1.4: Underscore Digit Separators

For C<integer> and C<number> literals, an I<"underscore"> C<_> character must be inserted after every third digit away from the decimal point, where the underscore is used in a similar manner as a comma when writing long numbers by hand.

    1_234_567  # integer, same as "1,234,567" in American notation
    -32_123    # integer, same as "-32,123" in American notation
    -32123     # bad integer, missing underscore

    1.234_567           # number, same as "1.234567" in American notation
    -32_123.456_789_01  # number, same as "-32,123.45678901" in American notation
    -32_123.456_78901   # bad number, missing underscore

=head3 Section 2.1.5: Optional Positive Sign

For C<integer> and C<number> literals, an optional C<+> plus sign may be prepended to explicitly indicate a numeric literal is positive (greater than zero).

    1   # positive one
    +1  # also positive one

X<u>I<BEST PRACTICES>X</u>

X<u>

=over

=item * I<When only positive numeric literals are used in one area of code, omit positive signs.>

=item * I<When both positive and negative literals are used in one code area, use signs for all applicable literals.>

=back

X</u>

    +23    # good integer, but not aligned with other un-signed literal below
    +55.6  # good number,  but not aligned with other un-signed literal below
    42

    23     # best integer for all positive literals, aligned
    55.6   # best number  for all positive literals, aligned
    42

    23     # good integer, but not aligned with other signed literals below
    55.6   # good number,  but not aligned with other signed literals below
    -21
    -66.5

    +23    # best integer for mixed-sign literals, aligned
    +55.6  # best number  for mixed-sign literals, aligned
    -21
    -66.5

=head3 Section 2.1.6: Scientific Notation

For C<integer> and C<number> literals, very large or very small numbers should be represented using I<"scientific notation">, where each number is normalized to have exactly one digit to the left of the decimal point, then a lower-case C<e> character and an appropriate integer power-of-ten is appended to the resulting normalized floating-point number.  The C<e> character stands for "exponent", as in "exponent of ten", and the Perl style of scientific notation is sometimes more accurately referred to as I<"scientific e notation">.

As with normal integers, negative exponents must be prefixed with a C<-> minus sign and positive exponents may be optionally prefixed with a C<+> plus sign.

    1_234_567_000     # good integer
    1.234_567_000e09  # good number, same as "1_234_567_000" in scientific notation

    0.001_234_567_000  # good number
    1.234_567_000e-03  # good number, same as "0.001_234_567_000" in scientific notation

    -0.000_000_000_000_000_000_000_001_234_567  # bad number, outside limits
    -1.234_567e-24  # good number, same as "-0.000_000_000_000_000_000_000_001_234_567" in scientific notation

X<u>I<BEST PRACTICES>X</u>

X<u>

=over

=item * I<Use 2 digits to represent all exponents.>

=item * I<When only positive exponents are used, omit exponent signs.>

=item * I<When both positive and negative exponents are used, use signs for all exponents.>

=back

X</u>

    1_234_567_000      # good integer
    1.234_567_000e9    # good number, but does not align with two-digit exponents below
    1.234_567_000e09   # best number for all-positive exponents, aligned with two-digit exponent below
    1.234_567_000e19

    1.234_567_000e+09  # good number, but not aligned with positive exponents below
    1.234_567_000e09   # best number for all-positive exponents, aligned with positive exponent below
    1.234_567_000e19
 
    1.234_567_000e09   # good number, but not aligned with signed exponents below
    1.234_567_000e+09  # best number for mixed-sign exponents, aligned with signed exponent below
    1.234_567_000e-09

    +1.537_969_711_485_091_65e+21  # best number for mixed-sign exponents
    -2.591_931_460_998_796_41e+01  # best number for mixed-sign exponents
    +1.792_587_729_503_711_81e-01  # best number for mixed-sign exponents
    +2.680_677_724_903_893_22e-03  # best number for mixed-sign exponents
    +1.628_241_700_382_422_95e-03  # best number for mixed-sign exponents
    -9.515_922_545_197_158_70e-15  # best number for mixed-sign exponents

=head3 Section 2.1.7: Numeric Operators

[ INSERT OPS ]

=head2 Section 2.2: Strings (Text Data)

RPerl provides 2 text data types:

=over

=item * C<char>

S< >S< >S< >S< >a single text character; either a letter, number, or special character

=item * C<string>

S< >S< >S< >S< >one or more text characters; any combination of letters, numbers, and special characters

=back

RPerl provides 3 delimiters for enclosing text data:

=over

=item * C<'single quotes'>

=item * C<"double quotes">

=item * C<q{q quotes}>

=back

=head3 Section 2.2.1: Char Literals

The most memory-efficient text literal is C<char>, which represents exactly zero or one character of information.  A C<char> may express the value of any single numeric digit (0, 1, 2, ..., 8, 9); letter (a, b, c, ..., y, z, A, B, C, ..., Y, Z ); or special ASCII character (!, #, *, +, etc).  If the C<char> literal has length zero, it is called the I<"empty character"> and contains no data.

    ''          # not a char, use q{} for empty character
    '0'         # char
    'h'         # char
    '+'         # char
    '\n'        # not a char, too many characters, use "\n" for newline character
    '-1'        # not a char, too many characters
    'howdy23!'  # not a char, too many characters

    ""          # not a char, use q{} for empty character
    "0"         # char
    "h"         # char
    "+"         # char
    "\n"        # char, newline character
    "-1"        # not a char, too many characters & invalid use of double quotes
    "howdy23!"  # not a char, too many characters & invalid use of double quotes

    q{}          # char, empty character
    q{0}         # char
    q{h}         # char
    q{+}         # char
    q{\n}        # not a char, too many characters, use "\n" for newline character
    q{-1}        # not a char, too many characters
    q{howdy23!}  # not a char, too many characters

=head3 Section 2.2.2: String Literals

Any text data more than 1 character in length must be represented by a C<string> literal, which is comprised of any combination of valid C<char> literal characters (numeric digits, letters, and special ASCII characters).  Like the empty character, if a C<string> literal has length zero then it is called the I<"empty string"> and contains no data.

    ''          # not a string, use q{} for empty string
    '0'         # string
    'h'         # string
    '+'         # string
    '\n'        # string, not a newline, use "\n" for string containing newline
    '-1'        # string
    'howdy23!'  # string

    ""          # not a string, use q{} for empty string
    "0"         # not a string, invalid use of double quotes, must contain newline or tab character(s)
    "h"         # not a string, invalid use of double quotes, must contain newline or tab character(s)
    "+"         # not a string, invalid use of double quotes, must contain newline or tab character(s)
    "\n"        # string, contains only newline character
    "-1"        # not a string, invalid use of double quotes, must contain newline or tab character(s)
    "howdy23!"  # not a string, invalid use of double quotes, must contain newline or tab character(s)

    q{}          # empty string
    q{0}         # string
    q{h}         # string
    q{+}         # string
    q{\n}        # string, not a newline, use "\n" for string containing newline
    q{-1}        # string
    q{howdy23!}  # string

=head3 Section 2.2.3: Single Quotes

Text literals enclosed in single quotes are the simplest and most common case in RPerl.

Single-quoted text literals are not I<"interpolated">, which means the literal's data contents are not changed by Perl or RPerl in any way.  Because single quotes do not activate string interpolation, the literal C<'\n'> is not a newline character; instead, it is simply two normal characters, a backslash followed by a lowercase letter n.  Do not use single quotes to represent a newline or tab character, use C<"\n"> or C<"\t"> instead.

Do not use single quotes to represent an empty character or empty string, use C<q{}> instead.

A single-quoted text literal begins and ends with the single quote character, therefore it cannot logically contain a single quote character as part of the literal data itself.  (RPerl does not support backslash-escaped single quote characters within a single-quoted string like normal Perl does, as this can be considered a simple form of string interpolation.)

Single-quoted text literals must B<not> contain:

=over

=item * C<'S< >S< >S< >S< >S< >S< >>(single quote character)

=item * C<\S< >S< >S< >S< >S< >S< >>(single backslash as final character)

=item * C<\\\S< >S< >S< >S< >>(odd number of backslashes as final characters)

=item * no characters

=back

Single-quoted text literals may contain:

=over

=item * C<"S< >S< >S< >S< >>(double quote character)

=item * C<}S< >S< >S< >S< >>(right curly brace character)

=item * C<\S< >S< >S< >S< >>(single backslash as non-final character)

=item * C<\\\S< >S< >>(odd number of backslashes as non-final characters)

=item * any other characters

=back

=head3 Section 2.2.4: Double Quotes

Text literals enclosed in double quotes are fully interpolated in normal Perl, and are only used for trivial interpolation of strings containing the special C<"\n"> newline or C<"\t"> tab characters in RPerl.  All double-quoted strings must contain at least one newline or tab character.

String interpolation in normal Perl is triggered by finding either the C<$> dollar sign or C<@> I<"at sign"> characters inside of a double-quoted string literal.  Because RPerl does not support string interpolation, double-quoted string literals must not contain the C<$> or C<@> characters.

String interpolation is also triggered by finding a C<\> backslash character followed by one or more special I<"escape characters">, which are mostly comprised of otherwise-normal characters such as numbers and lowercase letters.  When a backslash is followed by valid escape characters, it is called an I<"escape sequence">.  Each valid escape sequence actually counts as only one character, even though it is represented by 2 or more typed characters, so a single escape sequence may be utilized as either a C<char> text literal or a C<string> text literal.  The special C<\n> newline and C<\t> tab characters are themselves escape sequences, and are the only allowed escape sequences in RPerl.  (Thus, C<"\n"> and C<"\t"> may both be utilized as either a C<char> or C<string> text literal in RPerl.)  Double-quoted string literals must not contain any backslash characters, other than those used in newline and tab escape sequences.

Double-quoted text literals must B<not> contain:

=over

=item * C<"S< >S< >>(double quote character)

=item * C<$S< >S< >>(dollar sign character)

=item * C<@S< >S< >>(at sign character)

=item * C<\S< >S< >>(extra backslash character, other than C<\n> or C<\t>)

=item * no characters

=back

Double-quoted text literals B<must> contain 1 or more:

=over

=item * C<\nS< >S< >>(newline character)

=item * C<\tS< >S< >>(tab character)

=back

Double-quoted text literals may contain:

=over

=item * C<'S< >S< >>(single quote character)

=item * C<}S< >S< >>(right curly brace character)

=item * any other characters

=back

X<u>I<BEST PRACTICES>X</u>

X<u>

=over

=item * I<Use double-quoted string literals to contain newline and tab characters only, not other normal characters.>

=item * I<To represent a mixture of normal characters with newline and/or tab characters, enclose the normal characters in single quotes, enclose the newline and tab characters in double quotes, and use the C<.> dot "string concatenation" operator to append one string literal to the other.  (Please see L</Section 2.2.6: String Operators> for more info about string concatenation.)>

=back

X</u>

=head3 Section 2.2.5: q Quotes

Text literals enclosed in C<q{}> I<"q quotes"> begin with the lowercase q followed by C<{> left curly brace characters, and end with the C<}> right curly brace character.  You must use q quotes to represent C<q{}> empty text literals containing no characters.

[ INSERT BACKSLASHES, QUOTES ]

[ INSERT BACKSLASHES FOR SINGLE AND DOUBLE QUOTE SECTIONS ABOVE]

q-quoted text literals must B<not> contain:

=over

=item * C<}S< >S< >S< >S< >>(right curly brace character)

=item * C<\S< >S< >S< >S< >>(single backslash as final character)

=item * C<\\\S< >S< >>(odd number of backslashes as final characters)

=back

q-quoted text literals may contain:

=over

=item * C<'S< >S< >S< >S< >>(single quote character)

=item * C<"S< >S< >S< >S< >>(double quote character)

=item * C<\S< >S< >S< >S< >>(single backslash as non-final character)

=item * C<\\\S< >S< >>(odd number of backslashes as non-final characters)

=item * no characters

=item * any other characters

=back

[ INSERT BEST PRACTICES ]

=head3 Section 2.2.6: String Operators

[ INSERT OPS ]

=head2 Section 2.3: Perl’s Built-in Warnings

[INSERT WARNINGS]

=head2 Section 2.4: Scalar Variables

An RPerl I<"expression"> is any general-purpose language component which either returns a value or is a literal value itself.

An RPerl I<"statement"> is any general-purpose language component which performs some action(s).

An RPerl I<"named operator"> is any of the 220+ Perl named operators, although RPerl only supports the low-magic forms of each operator.

An RPerl I<"operation"> is the equivalent of a single sentence in human language, and may be either an expression followed by a C<;> semicolon punctuation character, or a named operator followed by a semicolon, or a statement.

The C<=> equal sign is the assignment operator, used to set the variable on its left to store the value of the expression on its right.

Perl's C<my> keyword is used to declare a new variable, and optionally initialize it to a starting value when combined with the C<=> assignment operator.

Normal Perl does not support specific data types, so in Perl one variable named C<$foo> may be initialized with a numeric value, then the same C<$foo> variable may be changed to hold a string value without any warning or error.

    my $foo = 23;
    $foo = 'twenty-three';  # just fine in normal Perl

On the other hand, RPerl I<requires> the use of data types for each and every variable.

    my $foo = 23;  # error in RPerl, all modes

    my number $foo = 23;
    $foo = 'twenty-three';  # error in RPerl, compiled (non-test) modes, assigning string literal to number variable

    my number $foo = 23;
    $foo = 42;  # just fine in RPerl

Data types make your code much more readable and much, much faster.  Learn to love data types.  Now.

=head3 Section 2.4.x: Bool Data Type

The most efficient data type is C<boolean>, which stores a single I<"bit"> (binary digit) of information.  A C<boolean> may only hold the values of exactly 0 or 1.

    my boolean $foo = 0;     # fine
    my boolean $bar = 1;     # fine
    my boolean $baz = -1.5;  # error in RPerl, compiled (non-test) modes

=head3 Section 2.4.x: Integer Data Type

The next most efficient data type is C<integer>, which stores a single whole (non-decimal) number.  An C<integer> may hold any positive or negative whole number, within the data size limits of your operating system and computer hardware.

    my integer $foo  = -23;     # fine
    my integer $bar  = 0;       # fine
    my integer $baz  = 42_230;  # fine
    my integer $bax  = 42.1;    # error in RPerl, compiled (non-test) modes
    my integer $quux = -999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999;  # likely error or data corruption, outside limits

=head3 Section 2.4.x: Number Data Type

The C<number> data type stores a single floating-point (decimal) number, and may hold any real number within your computer's limits.

    my number $foo  = -23.42;     # fine
    my number $bar  = 0.000_001;  # fine
    my number $baz  = 42.23;      # fine
    my number $bax  = 42;         # fine
    my number $quux = -4_123.456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456;  # likely error or data loss, outside limits

=head3 Section 2.4.x: Type Conversion

To convert from one data type to another, we use the RPerl type conversion subroutines, shown below for numeric types only:

=over

=item * C<boolean_to_integer()>

=item * C<boolean_to_number()>

=item * C<integer_to_boolean()>

=item * C<integer_to_number()>

=item * C<number_to_boolean()>

=item * C<number_to_integer()>

=back

    my integer $foo = 23;
    my number $bar  = $foo;  # error in RPerl, compiled (non-test) modes, type mismatch

    my integer $foo = 23;
    my number $bar  = integer_to_number($foo);  # fine, $bar is now 23.0

    my number $foo  = 23.42;
    my integer $bar = $foo;  # error in RPerl, compiled (non-test) modes, type mismatch

    my number $foo  = 23.42;
    my integer $bar = number_to_integer($foo);  # fine, $bar is now 23

=head3 Section 2.4.x Scope, Type, Name, Value

The I<"scope"> of a variable is either local using the C<my> keyword, or global using the C<our> keyword.  Local variables are only usable within their own enclosing code block such as a conditional (section xxx), loop (xxx), or subroutine (chapter 4).

and global variables are usable within any code block accessible by the Perl interpreter or (RPerl compiler).

Except for certain special circumstances, all variables in RPerl are locally-scoped using C<my>.

[ INSERT SCOPE TYPE NAME VALUE ]

=head2 Section 2.5: Constant Data

[INSERT CONSTANTS]

=head2 Section 2.6: Output With C<print>

[INSERT PRINT]

=head2 Section 2.7: The C<if> Control Structure

[INSERT IF]

=head2 Section 2.8: Getting User Input

[INSERT INPUT]

=head2 Section 2.9: The C<chomp> Operator

[INSERT CHOMP]

=head2 Section 2.10: The C<while> Control Structure

[INSERT WHILE]

=head2 Section 2.11: The C<undef> Value

[INSERT UNDEF]

=head2 Section 2.12: The C<defined> Function

[INSERT DEFINED]

=head2 Section 2.13: Exercises

=head3 1.  XXXYYYZZZ  [ XYZ mins ]

[INSERT EXERCISES]

X<br>


=head1 CHAPTER 3: LISTS & ARRAYS

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 4: SUBROUTINES

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 5: INPUT & OUTPUT

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 6: HASHES

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 7: REGULAR EXPRESSIONS

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 8: REGULAR EXPRESSIONS MATCHING

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 9: REGULAR EXPRESSIONS PROCESSING

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 10: CONTROL STRUCTURES

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 11: CLASSES, PACKAGES, MODULES, LIBRARIES

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 12: FILE TESTS

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 13: DIRECTORY OPERATIONS

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 14: STRINGS & SORTING

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 15: SMART MATCHING & GIVEN-WHEN

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 16: PROCESS MANAGEMENT

[INSERT CHAPTER]

X<br>


=head1 CHAPTER 17: SOME ADVANCED TECHNIQUES

[INSERT CHAPTER]

X<br>


=head1 APPENDIX A: EXERCISE ANSWERS

2a.  Complete source code of solutions to chapters 1 - 6
2b.  Describe how to arrive at each solution

X<br>


=head1 APPENDIX B: BEYOND THE ROADRUNNER

The Scallion
The Sword

X<br>


=head1 APPENDIX C: RPERL GRAMMAR

1a.  Describe Eyapp EBNF grammar format and Grammar.eyp file sections
1b.  Describe lexical token types
1c.  Describe operator precedence and associativity
1d.  Describe all grammar rules and productions
1e.  Provide examples of valid code

X<br>


=head1 SEE ALSO

L<RPerl>

L<rperl>

X<br>


=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:wbraswell@NOSPAM.cpan.org>

=cut
