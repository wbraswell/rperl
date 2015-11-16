# [[[ HEADER ]]]
use RPerl;
package RPerl::Learning;
use strict;
use warnings;
our $VERSION = 0.003_000;

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
    typography conventions
        "quotation"
        I<"first occurrence of key concept">
        I<emphasis>
        U<book name>
        B<I<Program Name>>
        F<path/to/file>
        C<source code>
        C<$ terminal command>


=head1 CHAPTER 1: INTRODUCTION

=head2 Welcome To The Roadrunner Book!
    
    You are about to learn the basic concepts of writing software using the RPerl optimizing compiler for the Perl computer programming language.  With the skills gained by reading this book, you will be empowered to create new super-fast RPerl programs which can be intermixed with the enormous amount of existing Perl software available on the Internet.

    This book is named and stylized for the animal mascot for RPerl, Roadie the Roadrunner.  RPerl, like Roadie, I<"runs really fast">.
    
=head2 Learning Perl

    This book is purposefully patterned after the popular educational text U<Learning Perl>, affectionately known as the Llama Book.  Both the Roadrunner Book and the Llama book are meant as introductory texts on Perl topics.  The Llama Book is focused on normal Perl, and the Roadrunner Book is focused on optimized Perl.

    This book copies the same chapter topics as U<Learning Perl>, but all content is re-written for RPerl.  U<Learning RPerl> also copies the same exercise concepts as U<Learning Perl>, but all solutions are re-written in RPerl.  Both books are canonical and may be used together in the classroom; the source code solutions are meant to be compared side-by-side as textbook examples of normal Perl versus optimized Perl.

    Please support the Perl community by purchasing a copy of U<Learning Perl> from our friends at O'Reilly:
    
    L<http://shop.oreilly.com/product/0636920018452.do>

=head2 Is This Book Right For You?

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

=head2 Why Aren't There More Footnotes?

    This is a purposefully simple book, in the same way RPerl is a purposefully simple subset of the full Perl 5 programming language.

=head2 What About The Exercises & Their Answers?

    There are one or more programming exercises at the end of every chapter, and full answers to each problem are given near the end of the book in Appendix A.
 
    For maximum educational effect, we suggest you attempt to write each piece of code on your own before looking at our solutions.

    If you are using this as an official textbook for certification or academic credit, such as at LAMPuniversity.org or a traditional school, you are obviously expected to write all your own code without refering to our or anyone else's solutions whatsoever.  We suggest you enclose Appendix A with a paperclip or discard it altogether to avoid the potential for accidental academic dishonesty.

=head2 What Do Those Numbers At The Start Of The Exercise Mean?

    The original authors of U<Learning Perl> meant the numbers at each exercise to indicate the approximate number of minutes required for an average person to reach a full working solution.  If it takes you less time, good for you!  If it takes you more time, don't worry, it's no big deal; learning technical skills requires time and dedication.  All experts were once novices.

=head2 What If I'm An RPerl Course Instructor?

    Thank you for helping spread the love of Perl and the speed of RPerl!

    As previously mentioned, this book may either be used solo or combined with Learning Perl.  For students who are not already familiar with Perl, you may wish to use this text alone in order to simplify and ease the learning experience.  For students who are already familiar with Perl or other dynamic programming languages like the snake or the red gemstone, you may wish to use both textbooks for a more in-depth compare-and-contrast approach.

=head2 What Does RPerl Stand For?

    RPerl stands for I<"Restricted Perl">, in that we restrict our use of Perl to those parts which can be made to run fast.  RPerl also stands for I<"Revolutionary Perl">, in that we hope RPerl's speed will revolutionize the software development industry, or at least the Perl community.  RPerl might even stand for I<"Roadrunner Perl">, in that it I<runs really fast>.

=head2 Why Did Will Create RPerl?

    Will loves Perl and the Perl community.

    Will is a scientist and needs his code to run really fast.

    Will doesn't like the hassle of writing code in C or C++ or XS or Inline::C or Inline::CPP.

    Will waited a decade or two before realizing he had to do it himself.

=head2 Why Didn't Will Just Use Normal Perl Or Some Other Language?

    Dynamic languages like Perl are fast at running some kinds of computational actions, such as string manipulation (editing text data) and reading from a database.
    
    Unfortunately, dynamic languages are slow at running general-purpose computations, such as arithmetic and moving data around in memory.  Sometimes very slow.
    
    Dynamic languages like Perl are also flexible, powerful, and relatively easy to learn.  Sometimes too flexible.
    
    RPerl's goal is to keep all of Perl's power and ease-of-use, while removing the redundant parts of Perl's flexibility in order to gain a major runtime speed boost.

    The most complex and flexible parts of Perl are called I<"high magic">, so RPerl is focused on supporting the I<"low magic"> parts of Perl which can be made to run fast.

=head2 Is RPerl Easy Or Hard?

    RPerl is specifically designed to remove the confusing and complicated parts of Perl.

    RPerl also introduces a number of additional rules and templates which are not present in normal Perl, notably including the use of real data types.

    The net effect of removing Perl complexity and adding RPerl rules falls in favor of RPerl, due primarily to the exceedingly complex nature of Perl.

    In other words, RPerl is easier to learn and use than dynamic languages like normal Perl, and most any other language in general.

=head2 How Did RPerl Get To Be So Popular?

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

=head2 What Is Happening With RPerl Now?

    As of Q4 2015, RPerl v1.2 (codename I<Andromeda>) has been publicly released and is in use by a number of early adopters around the world.

    RPerl development is proceeding with financial support from both Kickstarter crowdfunding and official grant monies from The Perl Foundation.

    The RPerl community is beginning to grow, and there are a number of exciting RPerl projects currently in the works.  More info coming soon!

=head2 What Is RPerl Really Good For?

    RPerl is a general-purpose programming language, which means you can use RPerl to efficiently and effectively implement virtually any kind of software you can imagine.

    RPerl is especially well-suited for building software which benefits from speed, such as scientific simulations and graphical video games.

    RPerl is also good for building software which utilizes Perl's strong-suit of string manipulation; RPerl currently supports basic string operators, with full regular expression support to be added in an upcoming version.

=head2 What Is RPerl Not Good For?

    RPerl has purposefully disabled the most complex features of Perl, such as run-time code evaluation, secret operators, and punctuation variables.  If you have purposefully designed your Perl software to depend on these high-magic features, or you are unconditionally committed to continue using high-magic language features, then maybe RPerl isn't for you.

=head2 How Can I Get RPerl?

    Installing RPerl ranges from easy to difficult, depending on how well your operating system supports Perl and C++.
    
    On modern operating systems with good Perl support, such as Debian or Ubuntu GNU/Linux, you should be able to install RPerl system-wide by running the following command at your terminal command prompt:
    
    C<$ sudo cpan RPerl>

    If RPerl is properly installed, you should see a short text message displayed when you type the following command:

    C<$ rperl -v>

    On operating systems with less Perl support, you may have to perform a number of steps to successfully install RPerl, with dry technical detail available in the INSTALL notes document:
    
    L<https://github.com/wbraswell/rperl/blob/master/INSTALL>

    Unless you are an experienced programmer or system administrator, it is B<strongly> recommended you use the Xubuntu operating system.  You can download the Xubuntu ISO file at the link below, then use it to create a bootable DVD disc or USB flash drive, install Xubuntu onto any computer, and issue the C<$ sudo cpan RPerl> command as described above.

    L<http://xubuntu.org/getxubuntu>

    If you are interested in viewing the source code of RPerl itself, you may find the latest major release of RPerl (stable) on CPAN:

    L<https://metacpan.org/author/WBRASWELL>

    You may find the latest development release of RPerl (possibly unstable) on Github:

    L<https://github.com/wbraswell/rperl>

=head2 What Is CPAN?

    CPAN is the I<"Comprehensive Perl Archive Network">, the world's most successful and mature centralized software network.

    CPAN servers are where most public Perl software is stored, including RPerl.

    L<https://en.wikipedia.org/wiki/CPAN>
 
    L<http://www.cpan.org>

    Several other programming language communities have copied the success and implementation of CPAN, including JSAN for Javascript, CRAN for R, and CCAN for C.

=head2 How Can I Get Support For RPerl?

    Official RPerl technical support is provided through Auto-Parallel Technologies, Inc.
 
    To request more information, please send an e-mail to the following address:
 
    william DOT braswell AT autoparallel DOT com

=head2 Are There Any Other Kinds Of Support?

    Free technical support for non-commercial users is provided by the RPerl community through IRC.

    IRC #perl11 L<http://irc.perl.org>

=head2 What If I Find A Bug In RPerl?

    The primary bug-tracking platform for RPerl is Github Issues, where you may file a new bug report ("new issue") if it is not already listed:

    L<https://github.com/wbraswell/rperl/issues>

    Although Github Issues is strongly preferred, the RPerl development team also supports the legacy CPAN ticket system:
 
    L<https://rt.cpan.org/Public/Dist/Display.html?Name=RPerl>

=head2 How Do I Make An RPerl Program?

    Computer programs written using the RPerl language are plain text files, which means you can use any text editor to create and modify your RPerl source code.  Examples of common text editors include Notepad, Pico, and Vi.

    L<http://www.vim.org>

    To avoid possible file format problems, do not edit your RPerl programs using a word processor such as Wordpad, Word, OpenOffice, or LibreOffice.

    Experienced RPerl developers may choose to utilize an I<"integrated development environment"> (IDE), which is a special text editor made for writing software.  Examples of common Perl IDE applications include Eclipse EPIC, Padre, and Komodo (non-free).

    L<http://www.epic-ide.org>

    L<http://padre.perlide.org>

    L<http://komodoide.com/perl>

=head2 A Simple RPerl Program

C<
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
>

=head2 What Is Inside That RPerl Program?

    This program is separated by blank lines into 4 sections: shebang, header, critics, and operations.  

    Other than the shebang and critics, all lines beginning with C<#> are comments and can be safely ignored or discarded without affecting the program.

    The I<"shebang"> section is required, always contains exactly 1 line, and is short for I<"hash bang">; referring to the two leading characters C<#!> of this line.  The I<"octothorpe"> character C<#> (tic-tac-toe symbol) is called a I<"pound sign"> when used on a telephone, and is called a I<"hash"> (or more recently and less accurately I<"hash tag">) when used on a computer.  The exclamation point character C<!> is called a I<"bang"> when used on a computer.  When appearing together as the first two characters in a plain text file, the hash and bang characters tell the operating system to run the immediately-following command (in this case the Perl interpreter located at F</usr/bin/perl>) and pass the remaining contents of the text file as input to the command.  In other words, if the first line of a plain text file is C<#!/usr/bin/perl>, then that file is a Perl program.

    The I<"header"> section is required and always contains 4 lines for an RPerl I<"program"> file ending in F<.pl>, or 5 lines for an RPerl I<"module"> ending in F<.pm> (covered later in Chapter 11).  C<use> is recognized by Perl as a special I<"keyword"> (AKA I<"builtin operator">) which has 2 primary purposes: to load additional RPerl modules, and to enable RPerl I<"pragma"> system configuration modes.  The C<use RPerl;> line is dual-purpose, it both loads the F<RPerl.pm> module and enables the special RPerl low-magic pragma.  The C<use strict;> and C<use warnings;> lines enable basic Perl pragmas which require decent programming practices by the human programmers.  The C<our $VERSION = 0.001_000;> line sets the version number of this RPerl program.

    The I<"critics"> section is included as necessary and may contain 1 or more lines beginning with C<## no critic>, which disable the errors caused by the over-restrictive nature of some Perl::Critic policies.  There are currently 6 critics commands enabled for normal RPerl users, the first 2 of which are given in this example.  The C<USER DEFAULT 1> critics command allows the use of numeric values such as C<21> and C<12>, as well as the common C<print> command.  The C<USER DEFAULT 2> critics command allows the printing of C<'have $foo = '>, where a single-quoted C<'> string literal value contains the the C<$> dollar sigil (covered later in Chapter 2).

    The I<"operations"> section is required and contains 1 or more lines of general-purpose RPerl source code.  This is the main body of your program.  The 4 lines of source code in our example are used to perform some simple arithmetic and display the results.  The C<my number $foo = 21 + 12;> line declares a new variable named C<$foo> which will only contain floating-point numeric data, and which is initialized to contain the arithmetic result of numeric literal values C<21> plus C<12>.  The C<my number $bar = 23 * 42;> line does much the same thing, creating a new numeric variable named C<$bar> and initialized with C<23> times C<42>.  The C<print 'have $foo = ' . $foo . "\n";> and C<print 'have $bar = ' . $bar . "\n";> lines will display on screen (not send to paper printer) the labeled values of C<$foo> and C<$bar> respectively.  The C<.> dot operator is string concatenation, used in this example to create one string out of 3 parts so there is only 1 argument parameter passed to the C<print> command.  The "n" in the C<"\n"> double-quoted string literal values stands for "newline", which inserts a carriage return to place the next piece of printed data down on the following line.

=head2 How Do I Compile RPerl?

    Normal Perl source code is executed using a software mechanism known as I<"interpretation">, which is to say that Perl is an I<"interpreted"> language and the F</usr/bin/perl> command is called the I<"Perl interpreter">.  The primary alternative to interpretation is I<"compilation">, so RPerl is a I<"compiled"> subset of the Perl language and the F</usr/bin/rperl> command is called the I<"RPerl compiler">.

    Like the Perl interpreter, the RPerl compiler accepts 2 different input file types: Perl programs which end in F<.pl> and Perl modules which end in F<.pm>.  Perl program files actually run and execute actions, optionally receiving some functionality from 1 or more Perl module files if specified.  Perl modules do not run or execute actions themselves, they only provide functionality which must in turn be called from a Perl program, or from another Perl module which eventually gets called by a Perl program.

    B<I<CURRENT RPERL LIMITATION: RPerl modules are supported in full compile mode, but RPerl programs are supported in test interpret mode only, to be updated in a forthcoming RPerl release.>>

    A list of all valid RPerl compiler options may be seen by issuing the C<$ rperl -?> command or following one of these links:

    L<rperl>
    L<https://metacpan.org/pod/distribution/RPerl/script/rperl>

    To partially-compile-then-execute the preceeding RPerl example program in test mode, you may copy and paste the entire program (from shebang to second C<print>) into a temporary file such as F</tmp/foobar.pl>, then execute the following command:

    C<$ rperl -t /tmp/foobar.pl>

The output of this example program should be:

C<
have $foo = 33
have $bar = 966
>

    Please see chapter 11 for more information about compiling Perl modules.

=head2 A Whirlwind Tour of RPerl

=head3 Creator Of RPerl, Will Braswell

    Will Braswell does more than just create Perl compiler software, he is also very active in several other areas of life, including but not limited to:

    =over
    =item Church & Spirituality
    =item Boy Scouts of America
    =item Cane Juggling & Circus Performance
    =item Linux Operating Systems
    =item Charitable & Fraternal Organizations
    =item Homeschooling & Higher Education
    =item Astrophysics & Mathematics
    =item Entrepreneuriship & Business
    =item High-Performance Computing
    =item Professional Space Exploration
    =item Family Life
    =back

    These areas of interest are reflected in the tone and intention of RPerl.

=head3 History Of RPerl

    The RPerl project officially began as a New Year's Resolution on January 1st, 2013.  Following the grand tradition of Perl creator I<"Saint" Larry Wall>, RPerl version releases are often timed to coincide with major holidays.

    After 1 year of work, RPerl v1.0beta1 was released on New Year's Day 2014, eventually followed by RPerl v1.0beta2 on Christmas 2014.

    The much-anticipated RPerl v1.0 full release was made on US Independence Day 2015, and RPerl v1.2 came on Halloween 2015.

    RPerl v1.3 is scheduled for release on Thanksgiving 2015, then RPerl v2.0beta1 on Christmas 2015, and so on.

    RPerl v1.0 was funded through a Kickstarter campaign, then RPerl v1.2 and v1.3 were funded through a second Kickstarter campaign.  Work on the first 6 chapters of this book was funded through a grant from The Perl Foundation.

=head3 Performance Of RPerl

    The question of I<"How fast is RPerl?"> does not have one simple answer; instead there are several factors and configuration modes to be taken into consideration.  A relatively detailed description of the performance and modes may be found at the following link:

    L<http://rperl.org/performance_benchmarks.html>

    The most condensed answer is that I<"RPerl is really fast.">  Utilizing RPerl's fastest execution modes, we see performance very close to the highly-optimized I<C++> programming language, which means RPerl is now among the short list of "world's fastest languages" along with C, C++, and Fortran.

=head3 The Low-Magic Perl Commandments

    The high-magic features of Perl are primarily responsible for how slow Perl runs for general-purpose computations.  The I<"R"> in RPerl stands for I<"Restricted">, in that we restrict ourselves to only use the low-magic features of Perl which can run really fast.

    The definitive list of do's and do-nots for high-magic vs low-magic Perl programming is called I<The Low Magic Perl Commandments> (LMPC).  There are 64 total commandments split into 5 groups of Ideals, Magic, Data, Operations, and Object-Orientation.  The "Thou Shalt" commandments appear in the left column, and the "Thou Shalt Nots" appear on the right.

    L<http://rperl.org/the_low_magic_perl_commandments.html>

    The LMPC draw inspiration from, and (wherever possible) work together with Damian Conway's U<Perl Best Practices> and Jeffrey Thalhammer's Perl::Critic software.

    L<http://shop.oreilly.com/product/9780596001735.do>

    L<http://search.cpan.org/~thaljef/Perl-Critic/lib/Perl/Critic/PolicySummary.pod>

=head3 The Book Of RPerl

    I<Perlism> is the computer religion dedicated to the use, promotion, and development of the Perl family of programming languages.  (Not to be confused with a spiritual religion such as Christianity, a computer religion such as Perlism is an independent and complementary belief structure.)

    A I<Perlite> is an adherent to the Perlism religion.  Perlism has a revered founder, Saint Larry (himself a devout Christian); a prophet, I<The Voice In The Wilderness> (Will); a monastary and shrine, I<Perl Monks>; commandments, The LMPC; proverbs from Saint Larry including I<TIMTOWTDI>, I<LMFB>, and L<HTAAOF>; and canonical scriptures, including Saint Larry's U<Apocalypses> and The Voice's U<Book of RPerl>.

    The book is a description of events surrounding the creation of RPerl and the future of the Internet.  It is intended to both educate and entertain.

    L<http://rperl.org/the_book_of_rperl.html>

=head2 Exercises

=head3 1.  Hello World  [ 15 mins ]

    On a computer with RPerl already installed, create a directory named F<LearningRPerl> containing a sub-directory named F<Chapter1>.  Using the B<I<Foo Bar>> example program as a template, manually type a new RPerl program into a file named F<exercise_1-hello_world.pl> inside the F<LearningRPerl/Chapter1> sub-directory.  The sole purpose of your first program is to use the C<print> operator and simply display the following one line of text output, followed by one newline character:

    C<Hello, World!>

    Run your new program by issuing the following command at your terminal command prompt:

    C<$ rperl -t LearningRPerl/Chapter1/exercise_1-hello_world.pl>

    I<HINT: You only need the C<USER DEFAULT 1> critic line, so your resulting program should be 7 lines long, not counting comments or blank lines.>

=head3 2.  RPerl Commands  [ 15 mins ]

    Run the following RPerl commands and observe the output.

    C<$ rperl -?>

    2a.  What are some RPerl command-line options with which you are already familiar?
    2b.  With which options are you unfamiliar?

    C<$ rperl -t -V LearningRPerl/Chapter1/exercise_1-hello_world.pl>
    C<$ rperl -t -D LearningRPerl/Chapter1/exercise_1-hello_world.pl>
    C<$ rperl -t -V -D LearningRPerl/Chapter1/exercise_1-hello_world.pl>

    2c.  How do the outputs of these 3 commands differ from the output of Exercise 1?
    2d.  How do the outputs differ from one another?

=head3 3.  Foo Bar Arithmetic  [ 15 mins ]

    Manually type the entire B<I<Foo Bar>> example program into a file named F<exercise_3-foo_bar_arithmetic.pl> inside the F<LearningPerl/Chapter1> sub-directory.  (Even if you have already used copy-and-paste on the B<I<Foo Bar>> example program, you should still use this as an opportunity to build some RPerl muscle memory and type it in by hand.)

    Modify your program by adding an extra numeric variable named C<$baz>, set its value to C<$bar / $foo>, and use C<print> to generate the following output:

C<
have $foo = 33
have $bar = 966
have $baz = 29.2727272727273
>

    Run your program thusly:

    C<$ rperl -t LearningRPerl/Chapter1/exercise_3-foo_bar_arithmetic.pl>


=head1 CHAPTER 2: SCALAR DATA

    Most programming languages include the basic principles of using named I<"variables"> to store data values such as numbers, text strings, and lists of multiple numbers or strings.  Multiple variables may be created, each with different names such as C<$foo> or C<$bar> or C<$quux>, and each potentially containing a different value.

    A single piece of data, such as one number or one string, is called a I<"scalar">.  Multiple pieces of data combined into a single aggregate structure may be either an I<"array"> or a I<"hash">, described in chapters 3 and 6, respectively.  (Although sharing the same terminology, the I<hash> data structure is not related to the I<hash> C<#> tic-tac-toe character.)  In normal Perl, only scalar variable names begin with the C<$> dollar-sign I<"sigil">, while aggregate data structures are stored in variables starting with different sigils like C<@> or C<%>.  In RPerl, all variable names begin the C<$> sigil, both scalar types and aggregate structures alike.

    RPerl provides 5 scalar data types:

    =over
    =item C<bool>
    =item C<integer>
    =item C<number>
    =item C<char>
    =item C<string>
    =back

    A single group of actual numeric digit(s) or quoted string character(s) is called a I<"literal">, such as:

    =over
    =item C<21  # integer>
    =item C<'howdy'  # string>
    =item C<-23.421_12  # number>
    =item C<1_234_567  # integer>
    =item C<'One million, two-hundred-thirty-four thousand, five-hundred-sixty-seven'  # string>
    =item C<"\n"  # newline char>
    =item C<'1'  # char>
    =item C<q{}  # empty string>
    =item C<0  # bool>
    =back

    An RPerl I<"expression"> is any general-purpose language component which either returns a value or is a literal value itself.

    An RPerl I<"statement"> is any general-purpose language component which performs some action(s).
    
    An RPerl I<"named operator"> is any of the 220+ Perl named operators, although RPerl only supports the low-magic forms of each operator.

    An RPerl I<"operation"> is the equivalent of a single sentence in human language, and may be either an expression followed by a C<;> semicolon punctuation character, or a named operator followed by a semicolon, or a statement.
 
    The C<=> equal-sign is the assignment operator, used to set the variable on its left to store the value of the expression on its right.
 
    Perl's C<my> keyword is used to declare a new variable, and optionally initialize it to a starting value when combined with the C<=> assignment operator.

    Normal Perl does not support specific data types, so in Perl one variable named C<$foo> may be initialized with a numeric value, then the same C<$foo> variable may be changed to hold a string value without any warning or error.

C<
    my $foo = 23;
    $foo = 'twenty-three';  # just fine in normal Perl
>

    On the other hand, RPerl I<requires> the use of data types for each and every variable.

C<
    use RPerl;
    ...
    my $foo = 23;  # error in RPerl, all modes
>

C<
    use RPerl;
    ...
    my number $foo = 23;
    $foo = 'twenty-three';  # error in RPerl, compiled (non-test) modes, assigning string literal to number variable
>

C<
    use RPerl;
    ...
    my number $foo = 23;
    $foo = 42;  # just fine in RPerl
>

    Data types make your code much more readable and much, much faster.  Learn to love data types.  Now.

=head2 Section 2.1: Numbers

    RPerl provides 3 numeric data types:

    =over
    =item C<bool> is a boolean logic value, either 0 or 1
    =item C<integer> is a whole number value, either negative, 0, or positive
    =item C<number> is a floating-point decimal number value, either negative, 0, or positive
    =back

=head3 Section 2.1.1: Bool Data Type

    The most efficient data type is C<bool>, which stores a single I<"bit"> (binary digit) of information.  A C<bool> may only hold the values of exactly 0 or 1.

C<
    my bool $foo = 0;     # fine
    my bool $bar = 1;     # fine
    my bool $baz = -1.5;  # error in RPerl, compiled (non-test) modes
>

=head3 Section 2.1.2: Integer Data Type

    The next most efficient data type is C<integer>, which stores a single whole (non-decimal) number.  An C<integer> may hold any positive or negative whole number, within the data size limits of your operating system and computer hardware.

C<
    my integer $foo  = -23;     # fine
    my integer $bar  = 0;       # fine
    my integer $baz  = 42_230;  # fine
    my integer $bax  = 42.1;    # error in RPerl, compiled (non-test) modes
    my integer $quux = -999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999;  # likely error or data corruption, outside limits
>

=head3 Section 2.1.3: Number Data Type

    The C<number> data type stores a single floating-point (decimal) number, and may hold any real number within your computer's limits.

C<
    my number $foo  = -23.42;     # fine
    my number $bar  = 0.000_001;  # fine
    my number $baz  = 42.23;      # fine
    my number $bax  = 42;         # fine
    my number $quux = -4_123.456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456;  # likely error or data loss, outside limits
>

=head3 Section 2.1.4: Underscore Digit Separators

    For C<integer> and C<number> data types, an I<"underscore"> C<_> character must be inserted after every third digit away from the decimal point, where the underscore is used in the same way as a comma when writing long numbers by hand.

C<
    my integer $foo = 1_234_567;  # fine, same as "1,234,567" in American notation
    my integer $bar = -32_123;    # fine, same as "-32,123" in American notation
    my integer $baz = -32123;     # error in RPerl, all modes, missing underscore
>

C<
    my number $foo = 1.234_567;           # fine, same as "1.234567" in American notation
    my number $bar = -32_123.456_789_01;  # fine, same as "-32,123.45678901" in American notation
    my number $baz = -32_123.456_78901;   # error in RPerl, all modes, missing underscore
>

=head3 Section 2.1.5: Scientific Notation

    [ INSERT SCIENTIFIC NOTATION ]

=head3 Section 2.1.6: Type Conversion

    [ INSERT TYPE CONVERSION ]

    bool_to_integer()
    bool_to_number()
    integer_to_bool()
    integer_to_number()
    number_to_bool()
    number_to_integer()
    
=head3 Section 2.1.7: Scope, Type, Name, Value

    [ INSERT SCOPE TYPE NAME VALUE ]

=head2 Strings
=head2 Perl’s Built-in Warnings
=head2 Scalar Variables
=head2 Output With C<print>
=head2 The C<if> Control Structure
=head2 Getting User Input
=head2 The C<chomp> Operator
=head2 The C<while> Control Structure
=head2 The C<undef> Value
=head2 The C<defined> Function
=head2 Exercises

=head3 1.  XXXYYYZZZ  [ XYZ mins ]


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
