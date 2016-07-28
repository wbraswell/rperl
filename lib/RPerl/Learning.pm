# [[[ HEADER ]]]
use RPerl;
package RPerl::Learning;
use strict;
use warnings;
our $VERSION = 0.100_000;

# [[[ OO INHERITANCE ]]]
# NEED FIX: why does the following 'use parent' command cause $VERSION to become undefined???
#use parent qw(RPerl::CompileUnit::Module::Class);
#use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class

__END__

=encoding utf8

=for DEV NOTE: BEGIN INLINE CSS DIV

=begin html

<div id="scoped-content"><style type="text/css" scoped>

table.rperl {
    border-style: solid;
    border-width: 2px;
}

table.rperl > tbody > tr > th {
    background-color: #e0e0e0;
    text-align: center;
}

table.rperl > tbody > tr:nth-child(odd)  { background-color: #f5f5f5; }
table.rperl > tbody > tr:nth-child(even) { background-color: #ffffff; }

table.rperl > tbody > tr > th, td {
    border-style: solid;
    border-width: 1px;
    border-color: #cccccc;
    padding: 5px;
}

/* disable ".pod p" margins inside tables only */
table.rperl > tbody > tr > th > p { margin: 0px; }
table.rperl > tbody > tr > td > p { margin: 0px; }

/* right alignment for numeric precedence column of operators tables */
table.operators > tbody > tr > td:nth-child(5)  { text-align: right; }

</style>

=end html

=head1 NAME

Learning RPerl

=head1 BOOK TITLE

=for html <u>

B<Learning RPerl>

=for html </u>

~ or ~

=for html <u>

B<Let's Write Fast Perl!>

=for html </u>

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


=head1 EDITION

0th Edition, Pre-Release Copy

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

=item * L</APPENDIX B: RPERL COMMAND-LINE ARGUMENTS>

=item * L</APPENDIX C: RPERL CRITICS>

=item * L</APPENDIX D: RPERL GRAMMAR>

=item * L</APPENDIX E: BEYOND THE ROADRUNNER>

=back

X<br>


=head1 FOREWORD

[ INSERT FOREWORD CONTENT HERE ]

X<br>


=head1 PREFACE

=head2 Section 0.1: Who I Am

My name is William N. Braswell, Jr.; I am also known by a number of other names including Will the Chill, The Voice In The Wilderness, Skipper Brassie ("braz-ee"), and just Will.

I have a degree in computer science and mathematics from Texas Tech University, I have worked as a Perl software developer for over 15 years, and I am the founder of the Auto-Parallel Technologies consulting company.

L<LinkedIn Profile|https://www.linkedin.com/in/williambraswell>

L<GitHub Profile|https://github.com/wbraswell>

I am 1 of 3 co-founders of the Perl 11 movement.

L<Perl11.org|http://perl11.org/>

I am also the President of the Austin Perl Mongers.

L<Austin.pm|http://austin.pm>

Most importantly, I am the creator of the RPerl optimizing compiler for Perl 5, about which you are currently reading!

L<RPerl.org|http://rperl.org>

=head2 Section 0.2: Why I Wrote This Book

Using RPerl is different enough from normal Perl 5 to necessitate the creation of in-depth user documentation.

Manual pages and cookbooks and example source code alone are not enough, only a full textbook can provide the level of detail necessary to truly learn RPerl.

This is that textbook.

=head2 Section 0.3: History Of This Book

RPerl v1.0 was released on US Independence Day, July 4th, 2015; 6 days later, work began on the source code solution to exercise 1 of chapter 1 of this book:

L<First Learning RPerl Commit on GitHub|https://github.com/wbraswell/rperl/commit/8c3dec4448fbed6bba04f92f9f23759c5512f2e9>

Significant GitHub commit dates include, but are not limited to the following:

=for rperl X<noncode>

    $ git log --reverse --all --date=short --pretty='%cd: %s' | grep 'Learning RPerl'
    2015-07-10: Learning RPerl, Chapter 1, Exercise 1, Hello World
    2015-07-11: Learning RPerl, Chapter 2, Exercise 1, Circumference Of Circle With Radius 12.5
    2015-07-12: Learning RPerl, Chapter 2, Exercise 1, Circumference Of Circle With Radius 12.5, Part 2
    2015-07-13: Learning RPerl, Chapter 2, Exercise 2, Circumference Of Circle With Any Radius
    2015-07-14: Learning RPerl, Chapter 2, Exercise 3, Circumference Of Circle With Any Positive Radius
    2015-07-15: Learning RPerl, Chapter 2, Exercise 4, Product Of Any Two Numbers
    2015-07-16: Learning RPerl, Chapter 2, Exercise 5, String Repeat
    2015-07-18: Learning RPerl, Chapter 3, Exercise 1, STDIN Strings Reverse
    2015-07-17: Learning RPerl, Chapters 1 & 2, Add Source Comments
    2015-07-19: Learning RPerl, Chapter 3, Exercise 2, STDIN Array Indices
    2015-07-20: Learning RPerl, Chapters 2 & 3, Add Source Comments
    2015-07-21: Learning RPerl, Chapter 3, Exercise 3, STDIN Strings Sort
    2015-07-22: Learning RPerl, Chapter 4, Exercise 1, Subroutine For Stringified Numbers Total
    2015-07-23: Learning RPerl, Chapter 4, Exercise 2, Subroutine For Total Of 1 To 1,000
    2015-07-25: Learning RPerl, Chapter 4, Exercise 3, Subroutines For Above-Average Array Elements
    2015-10-03: Learning RPerl, Chapter 4, Exercise 4, Subroutine To Greet User
    2015-10-04: Learning RPerl, Chapter 4, Exercise 5, Subroutine To Greet Multiple Users
    2015-10-05: Learning RPerl, Chapter 5, Exercise 1, Print Input File(s) Lines In Reverse, Part 1
    2015-10-06: Learning RPerl, Chapter 5, Exercise 1, Print Input File(s) Lines In Reverse, Part 2
    2015-10-07: Learning RPerl, Chapter 5, Exercise 2, Print Input Line(s) Right-Justified
    2015-10-08: Learning RPerl, Chapter 5, Exercise 3, Print Input Line(s) Variable-Width Right-Justified, Part 1
    2015-10-09: Learning RPerl, Chapter 5, Exercise 3, Print Input Line(s) Variable-Width Right-Justified, Part 2
    2015-10-10: Learning RPerl, Chapter 6, Exercise 1, Print Family Names
    2015-10-11: Learning RPerl, Chapter 6, Exercise 2, Unique Word Count
    2015-10-12: Learning RPerl, Ensure All Exercises Parse, Part 1
    2015-10-13: Learning RPerl, Ensure All Exercises Parse, Part 2
    2015-10-19: Learning RPerl, Ensure All Exercises Parse, Part 3
    2015-10-20: Learning RPerl, Ensure All Exercises Parse, Part 4
    2015-10-21: Learning RPerl, Ensure All Exercises Parse, Part 5
    2015-10-22: Learning RPerl, Ensure All Exercises Parse, Part 6
    2015-10-23: Learning RPerl, Ensure All Exercises Parse, Part 7
    2015-10-24: Learning RPerl, Ensure All Exercises Parse, Part 8
    2015-10-25: Learning RPerl, Ensure All Exercises Parse, Part 9
    2015-10-26: Learning RPerl, Ensure All Exercises Parse, Part 10
    2015-10-27: Learning RPerl, Ensure All Exercises Parse, Part 11
    2015-10-28: Learning RPerl, Ensure All Exercises Parse, Part 12
    2015-10-28: Learning RPerl, Ensure All Exercises Parse, Part 13
    2015-10-28: Learning RPerl, Ensure All Exercises Parse, Part 14
    2015-11-07: CPAN Release, v1.200002; Temporarily Fix Macintosh Build Failures, Learning RPerl Parse Failure, Etc.
    2015-11-10: Learning RPerl, Content, Part 1
    2015-11-11: Learning RPerl, Content, Part 2
    2015-11-14: Learning RPerl, Content, Part 3
    2015-11-15: Learning RPerl, Content, Part 4
    2015-11-16: Learning RPerl, Content, Part 5
    2015-11-16: Learning RPerl, Content, Part 6
    2015-11-17: Learning RPerl, Content, Part 7
    2015-11-18: Learning RPerl, Content, Part 8
    2015-11-18: Learning RPerl, Content, Part 9
    2015-11-19: Learning RPerl, Content, Part 10
    2015-11-20: Learning RPerl, Content, Part 11
    2015-11-21: Learning RPerl, Content, Part 12
    2015-11-22: Learning RPerl, Content, Part 13
    2015-11-24: Learning RPerl, Content, Part 14
    2015-12-31: Learning RPerl, Content, Part 15
    2015-12-31: Learning RPerl, Content, Part 16
    2016-01-01: Learning RPerl, Content, Part 17
    2016-01-02: Learning RPerl, FontAwesome & MetaCPAN Files, Initial Commit
    2016-01-02: News, RPerl v1.5 Release; Learning RPerl, FontAwesome & MetaCPAN Files, Move To Subdirectories
    2016-01-02: Learning RPerl, Update pod2rperlhtml.pl Script, Correct CSS & JS Paths
    2016-01-02: Learning RPerl, HTML Content, Initial Commit
    2016-01-03: Learning RPerl, Content, Part 18
    2016-01-05: Learning RPerl, Content, Part 19
    2016-01-06: Learning RPerl, Content, Part 20
    2016-01-07: Learning RPerl, Content, Part 21
    2016-01-08: Learning RPerl, Content, Part 22
    2016-01-09: Learning RPerl, Content, Part 23
    2016-01-09: Learning RPerl, Content, Part 24
    2016-01-10: Learning RPerl, Content, Part 25
    2016-01-11: Learning RPerl, Content, Part 26
    2016-01-12: Learning RPerl, Content, Part 27
    2016-01-14: Learning RPerl, Content, Part 28
    2016-01-15: Learning RPerl, Content, Part 29
    2016-01-16: Learning RPerl, Content, Part 30
    2016-01-16: Learning RPerl, Content, Part 31
    2016-01-16: Learning RPerl, Content, Part 32
    2016-03-03: Learning RPerl, Chapter 2 Content, Part 1
    2016-03-03: Learning RPerl, TPF Grant #2, Part 1

=for rperl X</noncode>

=head2 Section 0.4: TPF Grants

This book was made possible in part by 2 generous grants from The Perl Foundation, as part of the September 2015 and January / Febuary 2016 rounds of funding.

Special thanks to TPF Grants Committee Secretary, Makoto Nozaki; TPF Grant Manager, Mark Jensen; TPF Grants Committee's various supporting members; and everyone who gave positive feedback on the grant proposals.

A history of TPF grant #1 may be found at the following links:

=over 16

=item * L<Call For Grant Proposals|http://news.perlfoundation.org/2015/09/call-for-grant-proposals-sept.html>

=item * L<Grant Proposal|http://news.perlfoundation.org/2015/09/grant-proposal-rperl-user-docu.html>

=item * L<Grant Proposals|http://news.perlfoundation.org/2015/09/september-2015-grant-proposals-1.html>

=item * L<Grant Proposal Votes|http://news.perlfoundation.org/2015/10/september-2015-grant-votes.html>

=item * L<Grant Report 1|http://news.perlfoundation.org/2015/10/grant-report-rperl-user-docume.html>

=item * L<Grant Report 2|http://news.perlfoundation.org/2015/12/grant-report-rperl-user-docume-1.html>

=item * L<Grant Report 3|http://news.perlfoundation.org/2016/01/grant-report-rperl-user-docume-2.html>

=back

A history of TPF grant #2 may be found at the following links:

=over 16

=item * L<Grant Proposal: RPerl User Documentation, Part 2|http://news.perlfoundation.org/2016/02/grant-proposal-rperl-user-docu-1.html>

=item * L<Jan E<sol> Feb 2016 Grant Votes|http://news.perlfoundation.org/2016/02/janfeb-2016-grant-votes.html>

=back

=head2 Section 0.5: Acknowledgements & Thanks

Countless people have contributed to the development of RPerl; from source code to bug testing to financial donations to emotional support, it truly takes a village to build a compiler!

Below are the contents of the official RPerl thank-you file, listing the handles (online nicknames) and names of the most important RPerl contributors.  If you don't already know who these people are, you will be pleasantly surprised by researching each of them.

L<Latest THANKS File|https://github.com/wbraswell/rperl/blob/master/THANKS>

=for rperl X<noncode>

    Many Thanks To irc.perl.org:

    #perl5 Founder timtoady

    #perl6 Founder timtoady (again)

    #perl11 Founders ingy & rurban & willthechill (yours truly)

    #perl11 Members bulk88 & mst

    #inline Founders ingy (again) & nwatkiss

    #inline Members davido & mohawk & sisyphus


    Additional Thanks To:

    Eyapp Creator Casiano Rodriguez-Leon, PhD

    Austin Perl Mongers

    All RPerl Contributors & Users & Supporters

=for rperl X</noncode>

=head2 Section 0.6: Defense / Apology

I'm sure I will make errors while writing this book.

I may even upset some people, particularly those who have an emotional or financial investment in slow Perl software.

Despite my best efforts, I remain a fallible human being; thus, bad spelling and grammer and run-on sentences and parts that are hard to understand and parts that are not funny and formattiNg errors and bad spelling adn repetitions and other annoyances will doubtless plague this tome but we must not allow such trivialities as, improper punctuation to affect our willingness and ability to learn how to write super-fast RPerl software.

If you find a mistake in this book (other than in the immediately preceeding paragraph), please utilize the following link to create a new GitHub issue (bug report) using a title starting with the words "Learning RPerl":

L<New GitHub Issue|https://github.com/wbraswell/rperl/issues/new>

I will try my best to create an engaging and educational experience for you, the reader; however, in anticipation of the inevitable disappointment you may experience, I can only humbly offer...

B<I'M SORRY!>

=head2 Section 0.7: POD

"The Pod format is not necessarily sufficient for writing a book."

L<http://perldoc.perl.org/perlpod.html>

~ Saint Larry Wall & Sean M. Burke

X<br>

"Challenge accepted."

L<https://github.com/wbraswell/rperl/blob/master/script/development/pod2rperlhtml.pl>

~ Will Braswell

X<br>


=head1 CHAPTER 1: INTRODUCTION

=head2 Section 1.1: Welcome To The Roadrunner Book!

You are about to learn the basic concepts of writing software using the RPerl optimizing compiler for the Perl computer programming language.  With the skills gained by reading this book, you will be empowered to create new super-fast RPerl programs which can be intermixed with the enormous amount of existing Perl software available on the Internet.

This book is named and stylized for the animal mascot for RPerl, Roadie the Roadrunner.  RPerl, like Roadie, I<"runs really fast">.

Throughout this text, the following 14 typography conventions are utilized:

=over

=item * "Literal Quotation"

=item * I<"First Occurrence Of Key Concept">

=item * I<Emphasis>

=item * B<Stronger Emphasis>

=item * F</path/to/program.pl>

=item * B<I<Program Name>>

=for html <u>

=item * B<Book Title>

=item * I<BEST PRACTICES>

=for html </u>

=item * L<Hyperlink|http://rperl.org>

=item * C<$code_snippet = 'unhighlighted';>

=item * C<`command_line_program.pl --with --arguments`>  (Only Include Characters Between `Backquotes` When Running Command; Discard Backquote Characters Themselves)

=item * ...

    my string $code_block = 'highlighted on RPerl.org & MetaCPAN.org';  # with comments
    my integer $more_code = 17;  # http://www.catb.org/jargon/html/R/random-numbers.html
    return 'end of indented code block';

=item * ...

=for rperl X<noncode>

    $ command_line_program.pl --with --arguments
    Please provide input: foo bar
    Your output is:       howdy howdy howdy

=for rperl X</noncode>

=item * ...

=for rperl X<noncode>

    Documentation referring to `command_line_program.pl --with --arguments` among other things.
    When executed, the above command accepts as input the string 'foo bar',
    and displays as output the string 'howdy howdy howdy'.

=for rperl X</noncode>

=back

=head2 Section 1.2: Learning Perl

=begin text

This book is purposefully patterned after the popular educational text B<Learning Perl>, affectionately known as the Llama Book.  Both the Roadrunner Book and the Llama book are meant as introductory texts on Perl topics.  The Llama Book is focused on normal Perl, and the Roadrunner Book is focused on optimized Perl.

This book copies the same chapter topics as B<Learning Perl>, but all content is re-written for RPerl.  B<Learning RPerl> also copies the same exercise concepts as B<Learning Perl>, but all solutions are re-written in RPerl.  Both books are canonical and may be used together in the classroom; the source code solutions are meant to be compared side-by-side as textbook examples of normal Perl versus optimized Perl.

Please support the Perl community by purchasing a copy of B<Learning Perl> from our friends at O'Reilly:

=end text

=begin html

<p>This book is purposefully patterned after the popular educational text <u><b>Learning Perl</b></u>, affectionately known as the Llama Book.  Both the Roadrunner Book and the Llama book are meant as introductory texts on Perl topics.  The Llama Book is focused on normal Perl, and the Roadrunner Book is focused on optimized Perl.</p>

<p>This book copies the same chapter topics as <u><b>Learning Perl</b></u>, but all content is re-written for RPerl.  <u><b>Learning RPerl</b></u> also copies the same exercise concepts as <u><b>Learning Perl</b></u>, but all solutions are re-written in RPerl.  Both books are canonical and may be used together in the classroom; the source code solutions are meant to be compared side-by-side as textbook examples of normal Perl versus optimized Perl.</p>

<p>Please support the Perl community by purchasing a copy of <u><b>Learning Perl</b></u> from our friends at O'Reilly:</p>

=end html

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

If you hate Perl, or only love slow software, or wish all computers would explode, then we suggest some soul-searching and a L<few|https://www.youtube.com/watch?v=UScm9avQM1Y> L<Saint|https://www.youtube.com/watch?v=SKqBmAHwSkg> L<Larry|https://www.youtube.com/watch?v=G49RUPv5-NU> L<videos|https://www.youtube.com/watch?v=aNAtbYSxzuA>.  You'll thank us in the morning.

=head2 Section 1.4: Why Aren't There More Footnotes?

This is a purposefully simple book, in the same way RPerl is a purposefully simple subset of the full Perl 5 programming language.

=head2 Section 1.5: What About The Exercises & Their Answers?

There are one or more programming exercises at the end of every chapter, and full answers to each problem are given near the end of the book in Appendix A.

For maximum educational effect, we suggest you attempt to write each piece of code on your own before looking at our solutions.

If you are using this as an official textbook for certification or academic credit, such as at LAMPuniversity.org or a traditional school, you are obviously expected to write all your own code without refering to our or anyone else's solutions whatsoever.  We suggest you enclose Appendix A with a paperclip or discard it altogether to avoid the potential for accidental academic dishonesty.

=head2 Section 1.6: What Do Those Numbers At The Start Of The Exercise Mean?

=for text The original authors of B<Learning Perl> meant the numbers at each exercise to indicate the approximate number of minutes required for an average person to reach a full working solution.  If it takes you less time, good for you!  If it takes you more time, don't worry, it's no big deal; learning technical skills requires time and dedication.  All experts were once novices.

=for html <p>The original authors of <u><b>Learning Perl</b></u> meant the numbers at each exercise to indicate the approximate number of minutes required for an average person to reach a full working solution.  If it takes you less time, good for you!  If it takes you more time, don't worry, it's no big deal; learning technical skills requires time and dedication.  All experts were once novices.</p>

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

Dynamic languages like Perl are fast at running some kinds of computational actions, such as regular expressions (text data pattern matching) and reading from a database.

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

=item * IRC #perl11  L<http://irc.lc/magnet/perl11/rperl_newbie@@@>

=back

=head2 Section 1.13: What Is Happening With RPerl Now?

As of US Independence Day 2016, RPerl v2.0 (codename I<Pioneer>) has been publicly released and is in use by a number of early adopters around the world.

RPerl development is proceeding with financial support from both Kickstarter crowdfunding and official grant monies from The Perl Foundation.

The RPerl community is beginning to grow, and there are a number of exciting RPerl projects currently in the works.

If you would like to create software libraries and applications (AKA "programs" or "apps") to be utilized by end-users, then please join the RPerl application developers group, also known as the "RPerl App Devs":

L<RPerl App Devs Group On Facebook|https://www.facebook.com/groups/1551887621787018>

L<RPerl App Devs Intake Board On Trello|https://trello.com/b/XmmPJQJj/austin-pm-rperl-app-devs-intake>

=head2 Section 1.14: What Is RPerl Really Good For?

RPerl is a general-purpose programming language, which means you can use RPerl to efficiently and effectively implement virtually any kind of software you can imagine.

RPerl is especially well-suited for building software which benefits from speed, such as scientific simulations and graphical video games.

RPerl is also good for building software which utilizes Perl's strong-suit of string manipulation; RPerl currently supports basic string operators, with full regular expression support to be added in an upcoming version.

=head2 Section 1.15: What Is RPerl Not Good For?

RPerl has purposefully disabled the most complex features of Perl, such as runtime code evaluation, secret operators, and punctuation variables.  If you have purposefully designed your Perl software to depend on these high-magic features, or you are unconditionally committed to continue using high-magic language features, then maybe RPerl isn't for you.

=head2 Section 1.16: How Can I Get RPerl?

Installing RPerl ranges from easy to difficult, depending on how well your operating system supports Perl and C++.

On modern operating systems with good Perl support, such as Debian or Ubuntu GNU/Linux, you should be able to install RPerl system-wide by running the following command at your terminal command prompt:

=for rperl X<noncode>

    $ sudo cpan RPerl

=for rperl X</noncode>

You may also choose to use the C<`cpanm`> command for simplicity, or the C<local::lib> tool for single-user (not system-wide) installation, both of which are included in the INSTALL notes document linked below.

If RPerl is properly installed, you should see a short text message displayed when you type the following command:

=for rperl X<noncode>

    $ rperl -v

=for rperl X</noncode>

On operating systems with less Perl support, you may have to perform a number of steps to successfully install RPerl, with dry technical detail available in the INSTALL notes document:

L<https://github.com/wbraswell/rperl/blob/master/INSTALL>

Unless you are an experienced programmer or system administrator, it is B<strongly> recommended you use the Xubuntu operating system.  You can download the Xubuntu ISO file at the link below, then use it to create a bootable DVD disc or USB flash drive, install Xubuntu onto any computer, and issue the C<`sudo cpan RPerl`> command as described above.

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

Free technical support for non-commercial users is provided by the RPerl community through Internet Relay Chat.

Server: irc.perl.org

Channel: #perl11

Easy Web Chat: L<http://irc.lc/magnet/perl11/rperl_newbie@@@>

=head2 Section 1.20: What If I Find A Bug In RPerl?

The primary bug-tracking platform for RPerl is Github Issues, where you may file a new bug report ("new issue") if it is not already listed:

L<https://github.com/wbraswell/rperl/issues>

Please be sure to include all of the following information in your bug report:

=over

=item * Pertinent Problem Message Output, If Long Use L<https://gist.github.com/>

=item * Operating System Version C<`cat /etc/issue`>

=item * Perl Version C<`perl -v`>

=item * RPerl Version C<`rperl -v`>

=back

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
    my integer $foo = 21 + 12;
    my integer $bar = 23 * 42 * 2;
    my number  $baz = to_number($bar) / $foo;
    print 'have $foo = ', to_string($foo), "\n";
    print 'have $bar = ', to_string($bar), "\n";
    print 'have $baz = ', to_string($baz), "\n";

=head2 Section 1.23: What Is Inside That RPerl Program?

This program is separated by blank lines into 4 sections: shebang, header, critics, and operations.  

Other than the shebang and critics, all lines beginning with C<#> are comments and can be safely ignored or discarded without affecting the program.

The I<"shebang"> section is required, always contains exactly 1 line, and is short for I<"hash bang">; referring to the two leading characters C<#!> of this line.  The I<"octothorpe"> character C<#> (tic-tac-toe symbol) is called a I<"pound sign"> when used on a telephone, and is called a I<"hash"> (or more recently and less accurately I<"hash tag">) when used on a computer.  The exclamation point character C<!> is called a I<"bang"> when used on a computer.  When appearing together as the first two characters in a plain text file, the hash and bang characters tell the operating system to run the immediately-following command (in this case the Perl interpreter located at F</usr/bin/perl>) and pass the remaining contents of the text file as input to the command.  In other words, if the first line of a plain text file is C<#!/usr/bin/perl>, then that file is a Perl program.

The I<"header"> section is required and always contains 4 lines for an RPerl I<"program"> file ending in F<.pl>, or 5 lines for an RPerl I<"module"> ending in F<.pm> (covered later in Chapter 11).  C<use> is recognized by Perl as a special I<"keyword"> (AKA I<"built-in operator">) which has 2 primary purposes: to load additional RPerl modules, and to enable RPerl I<"pragma"> system configuration modes.  The C<use RPerl;> line is dual-purpose, it both loads the F<RPerl.pm> module and enables the special RPerl low-magic pragma.  The C<use strict;> and C<use warnings;> lines enable basic Perl pragmas which require decent programming practices by the human programmers.  The C<our $VERSION = 0.001_000;> line sets the version number of this RPerl program.

The I<"critics"> section is included as necessary and may contain 1 or more lines beginning with C<## no critic>, which disable the errors caused by the over-restrictive nature of some Perl::Critic policies.  There are currently 6 critics commands enabled for normal RPerl users, the first 2 of which are given in this example.  The C<USER DEFAULT 1> critics command allows the use of numeric values such as C<21> and C<12>, as well as the common C<print> command.  The C<USER DEFAULT 2> critics command allows the printing of C<'have $foo = '>, where a single-quoted C<'> string literal value contains the the C<$> dollar sigil (covered later in Chapter 2).

The I<"operations"> section is required and contains 1 or more lines of general-purpose RPerl source code.  This is the main body of your program.  The 6 lines of source code in our example are used to perform some simple arithmetic and display the results.  The C<my integer $foo = 21 + 12;> line declares a new variable named C<$foo> which will only contain non-floating-point numeric data, and which is initialized to contain the arithmetic result of numeric literal values C<21> plus C<12>.  The C<my integer $bar = 23 * 42 * 2;> line does much the same thing, creating a new numeric variable named C<$bar> and initialized with C<23> times C<42> times C<2>.  The C<my number $baz = to_number($bar) / $foo;> line creates a new floating-point numeric variable C<$baz>, and initializes it to the quotient of the C<$bar> and C<$foo> variables.  The C<to_number()> RPerl type conversion subroutine converts a non-floating-point C<integer> value to a floating-point C<number> value.

The C<print 'have $foo = ', $foo, "\n";> and following 2 lines will display on screen (not send to paper printer) the labeled values of C<$foo>, C<$bar>, and C<$baz> respectively.  The C<,> comma is used to separate multiple arguments passed to the C<print> operator.  The C<to_string()> RPerl type conversion subroutine converts the numeric values to underscore-formatted string values, suitable for use via the C<print> operator.  If the <to_string()> subroutine is not used, then the displayed numeric values will still be human-readable, but will not contain the proper underscores to be accepted back into RPerl as valid numeric data.  The "n" in the C<"\n"> double-quoted string literal values stands for "newline", which inserts a carriage return to place the next piece of printed data down on the following line.

=head2 Section 1.24: How Do I Compile RPerl?

Normal Perl source code is executed using a software mechanism known as I<"interpretation">, which is to say that Perl is an I<"interpreted"> language and the F</usr/bin/perl> command is called the I<"Perl interpreter">.  The primary alternative to interpretation is I<"compilation">, so RPerl is a I<"compiled"> subset of the Perl language and the F</usr/bin/rperl> command is called the I<"RPerl compiler">.

Like the Perl interpreter, the RPerl compiler accepts 2 different input file types: Perl programs which end in F<.pl> and Perl modules which end in F<.pm>.  Perl program files actually run and execute actions, optionally receiving some functionality from 1 or more Perl module files if specified.  Perl modules do not run or execute actions themselves, they only provide functionality which must in turn be called from a Perl program, or from another Perl module which eventually gets called by a Perl program.

A list of all valid RPerl compiler options may be seen by issuing the following command:

=for rperl X<noncode>

    $ rperl -?

=for rperl X</noncode>

You may find the same information by viewing the following links:

L<rperl>

L<https://metacpan.org/pod/distribution/RPerl/script/rperl>

To compile-then-execute the preceeding RPerl example program, you may copy and paste the entire program (from shebang to second C<print>) into a temporary file such as F</tmp/foobar.pl>, then execute the following command:

=for rperl X<noncode>

    $ rperl /tmp/foobar.pl

=for rperl X</noncode>

The output of this example program should be:

=for rperl X<noncode>

    have $foo = 33
    have $bar = 1_932
    have $baz = 58.545_454_545_454_5

=for rperl X</noncode>

If the compilation is successful, a new compiled executable file will be created in F</tmp/foobar>.  You may then directly execute the compiled program as many times as you like, without needing to recompile it using the C<`rperl`> command, and you should receive the exact same output as the non-compiled code:

=for rperl X<noncode>

    $ /tmp/foobar
    have $foo = 33
    have $bar = 1_932
    have $baz = 58.545_454_545_454_5

=for rperl X</noncode>

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

RPerl v1.3 was released on Thanksgiving 2015, followed by RPerl v1.4 on Christmas 2015, and so forth.

RPerl v1.0 was funded through a Kickstarter campaign, then RPerl v1.2 and v1.3 were funded through a second Kickstarter campaign.  Work on the first 6 chapters of this book was funded, in part, by grants from The Perl Foundation.

RPerl v2.0 was released on US Independence Day 2016, exactly 1 year after v1.0 was released, in order to establish a regular annual release cycle.

=head3 Section 1.25.3: Performance Of RPerl

The question of I<"How fast is RPerl?"> does not have one simple answer; instead there are several factors and configuration modes to be taken into consideration.  A relatively detailed description of the performance and modes may be found at the following link:

L<http://rperl.org/performance_benchmarks.html>

The most condensed answer is that I<"RPerl is really fast.">  Utilizing RPerl's fastest execution modes, we see performance very close to the highly-optimized I<C++> programming language, which means RPerl is now among the short list of "world's fastest languages" along with C, C++, and Fortran.

=head3 Section 1.25.4: The Low-Magic Perl Commandments

The high-magic features of Perl are primarily responsible for how slow Perl runs for general-purpose computations.  The I<"R"> in RPerl stands for I<"Restricted">, in that we restrict ourselves to only use the low-magic features of Perl which can run really fast.

The definitive list of do's and do-nots for high-magic vs low-magic Perl programming is called I<The Low Magic Perl Commandments> (LMPC).  There are 64 total commandments split into 5 groups of Ideals, Magic, Data, Operations, and Object-Orientation.  The "Thou Shalt" commandments appear in the left column, and the "Thou Shalt Nots" appear on the right.

L<http://rperl.org/the_low_magic_perl_commandments.html>

=for text The LMPC draw inspiration from, and (wherever possible) work together with Damian Conway's B<Perl Best Practices> and Jeffrey Thalhammer's Perl::Critic software.

=for html <p>The LMPC draw inspiration from, and (wherever possible) work together with Damian Conway's <u><b>Perl Best Practices</b></u> and Jeffrey Thalhammer's Perl::Critic software.</p>

L<http://shop.oreilly.com/product/9780596001735.do>

L<http://search.cpan.org/~thaljef/Perl-Critic/lib/Perl/Critic/PolicySummary.pod>

=head3 Section 1.25.5: Perlism & The Book Of RPerl

I<Perlism> is the computer religion dedicated to the use, promotion, and development of the Perl family of programming languages.  (Not to be confused with a spiritual religion such as Christianity, a computer religion such as Perlism is an independent and complementary belief structure.)

=for text A I<Perlite> is an adherent to the Perlism religion.  Perlism has a revered founder, Saint Larry (himself a devout Christian); a prophet, I<The Voice In The Wilderness> (Will); a monastary and shrine, I<Perl Monks>; commandments, The LMPC; proverbs from Saint Larry including I<TIMTOWTDI>, I<LMFB>, and I<HTAAOF>; and canonical scriptures, including Saint Larry's B<Apocalypses> and The Voice's B<The Book Of RPerl>.

=for html <p>A <i>Perlite</i> is an adherent to the Perlism religion.  Perlism has a revered founder, Saint Larry (himself a devout Christian); a prophet, <i>The Voice In The Wilderness</i> (Will); a monastary and shrine, <i>Perl Monks</i>; commandments, The LMPC; proverbs from Saint Larry including <i>TIMTOWTDI</i>, <i>LMFB</i>, and <i>HTAAOF</i>; and canonical scriptures, including Saint Larry's <u><b>Apocalypses</b></u> and The Voice's <u><b>The Book Of RPerl</b></u>.</p>

=for comment [ INSERT SGML, MAN, OTHER FORMATS ]

The Book is a description of events surrounding the creation of RPerl and the future of the Internet.  It is intended to both educate and entertain.

L<http://rperl.org/the_book_of_rperl.html>

=head3 Section 1.25.6: Fun With Proverbs & Catch Phrases & Acronyms

St. Larry has given us short and powerful proverbs, some of which are meant to have a purposefully tongue-in-cheek or sarcastic interpretation.

Will has provided a corollary to each of St. Larry's official proverbs.

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c 
l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_1.25.6-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Proverbs & Acronyms</title>
<tgroup cols="2">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<St. Larry's Original Proverb>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Will's Corollary Proverb>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

3 Great Virtues Of A Programmer:

LIH (Laziness, Impatience, Hubris)

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

3 Greater Virtues Of A Programmer:

DPH (Diligence, Patience, Humility)

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

TIMTOWTDI (There Is More Than One Way To Do It)

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

TDNNTBMTOWTDI (There Does Not Need To Be More Than One Way To Do It)

TIOFWTDI (There Is One Fastest Way To Do It)

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

LMFB (Let Many Flowers Bloom)

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

PTBF (Pick The Best Flowers)

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

HTAAOF (Have The Appropriate Amount Of Fun)

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

DTAAOW (Do The Appropriate Amount Of Work)

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

In addition to St. Larry's official proverbs, there are a number of other commonly-used catch phrases and ideas in the Perl community.

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c 
l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_1.25.6-table_2" label="" frame="all" colsep="1" rowsep="1">
<title>Catch Phrases & Acronyms</title>
<tgroup cols="2">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Original Catch Phrase>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Will's Corollary Catch Phrase>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Perl 5 Is The Camel

Perl 5 Is The Raptor

Perl 6 Is The Butterfly

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

RPerl Is The Roadrunner

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Perl Is The Onion

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

RPerl Is The Scallion

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Perl Is The Swiss Army Chainsaw

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

RPerl Is The Sword

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Perl Is Line-Noise

Perl Is A Write-Only Language

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

RPerl Is Best Practices

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=head2 Section 1.26: What's New In RPerl v2.0?

The single most significant new feature included in RPerl v2.0 is automatic parallelization.  This long-awaited software feature was promised from the very beginning of RPerl's initial development, with RPerl v2.0 being the originally-designated target for release of auto-parallel capabilities.  We stuck to the plan and delivered on time: the 4th of July, 2016.

Automatic parallelization is now enabled on 4 parallel CPU cores by default, because quad-core CPUs are common at this time.  You may utilize the C<--num_cores=8> command-line argument to double the default number of parallel cores, for example.  (Please see L</B.16: Modes, Parallelize> and L</B.17: Modes, Parallelize, Number Of Cores> for more info about auto-parallelization arguments.)

Currently, shared memory parallel hardware platforms are supported, such as multi-core CPUs and supercomputers, by utilizing the L<OpenMP|https://en.wikipedia.org/wiki/OpenMP> parallelization software.  In the near future we will add support for distributed memory platforms, such as clusters and the cloud, by utilizing the L<MPI|https://en.wikipedia.org/wiki/Message_Passing_Interface> parallelization software, as well as GPUs and other speciality hardware by utilizing the L<OpenCL|https://en.wikipedia.org/wiki/OpenCL> parallelization software. 

RPerl triggers auto-parallelization by simply including the word 'PARALLEL' in a loop label; everything inside that loop will be automatically parallelized, including multiply-nested loops.  RPerl implements the L<polytope model|https://en.wikipedia.org/wiki/Polytope_model> (AKA L<polyhedral model|http://polyhedral.info>) for loop parallelization, by utilizing the L<Pluto PolyCC|http://pluto-compiler.sourceforge.net> polytope software.

In addition to auto-parallelization, a number of other new features were released after RPerl v1.0 and by-or-before v2.0, including but not limited to:

=over

=item * Generate Stand-Alone Binary Executable Files & Shared Object Files

=item * Control Native C++ Types Used For Integer & Number Values

=item * Support SSE Data Types & Operations

=item * Support GMP Data Types & Operations

=item * Monolithic Modules

=item * Uncompile (Delete) Unwanted Compiled Files

=item * Two-Dimensional Data Structures

=back

=head2 Section 1.27: Exercises

=head3 1.  Hello World  [ 15 mins ]

On a computer with RPerl already installed, create a directory named F<LearningRPerl> containing a sub-directory named F<Chapter1>.  Using the B<I<Foo Bar>> example program as a template, manually type a new RPerl program into a file named F<exercise_1-hello_world.pl> inside the F<LearningRPerl/Chapter1> sub-directory.  The sole purpose of your first program is to use the C<print> operator and simply display the following one line of text output, followed by one newline character:

=for rperl X<noncode>

    Hello, World!

=for rperl X</noncode>

Run your new program by issuing the following command at your terminal command prompt:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter1/exercise_1-hello_world.pl

=for rperl X</noncode>

I<HINT: You only need the C<USER DEFAULT 1> critic line, so your resulting program should be 7 lines long, not counting comments or blank lines.>

=head3 2.  RPerl Commands  [ 15 mins ]

First, run the following RPerl command, and observe the output for use in 2a and 2b below:

=for rperl X<noncode>

    $ rperl -?

=for rperl X</noncode>

2a.  What are some RPerl command-line options with which you are already familiar?

2b.  With which options are you unfamiliar?

Next, run the following 3 RPerl commands, for 2c and 2d below:

=for rperl X<noncode>

    $ rperl -t -V LearningRPerl/Chapter1/exercise_1-hello_world.pl
    $ rperl -t -D LearningRPerl/Chapter1/exercise_1-hello_world.pl
    $ rperl -t -V -D LearningRPerl/Chapter1/exercise_1-hello_world.pl

=for rperl X</noncode>

2c.  How do the outputs of these 3 commands differ from the output of Exercise 1?

2d.  How do the outputs differ from one another?

=head3 3.  Foo Bar Arithmetic  [ 15 mins ]

Manually type the entire B<I<Foo Bar Arithmetic>> example program into a file named F<exercise_3-foo_bar_arithmetic.pl> inside the F<LearningPerl/Chapter1> sub-directory.  (Even if you have already used copy-and-paste on the B<I<Foo Bar Arithmetic>> example program, you should still use this as an opportunity to build some RPerl muscle memory and type it in by hand.)

Modify your program by adding a new floating-point numeric variable named C<$zab>, set its value to C<$foo> divided by C<$bar> (don't forget C<to_number()>), change the starting value of C<$bar>, and use C<print> to generate the following output:

=for rperl X<noncode>

    have $foo = 33
    have $bar = 966
    have $baz = 29.272_727_272_727_3
    have $zab = 0.034_161_490_683_229_8

=for rperl X</noncode>

Run your program thusly:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter1/exercise_3-foo_bar_arithmetic.pl

=for rperl X</noncode>

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

=item * C<character>

=item * C<string> (core)

=back

Of the 7 RPerl scalar data types, 3 are directly (natively) supported by the Perl 5 core: C<integer>, C<number>, and C<string>.  This means the Perl 5 core is capable of directly identifying and storing those 3 core types.  The remaining 4 non-core types are indirectly supported by the Perl 5 interpreter: C<boolean> and C<unsigned_integer> can be stored within either an C<integer> or C<number>; C<character> can be stored within a C<string>; and C<gmp_integer> is supported by the C<use bigint;> wrapper around the C<Math::BigInt::GMP> module.

When RPerl application source code is compiled from RPerl into C++, all 7 data types are natively supported by C++ for high-speed execution.

A single group of actual numeric digit(s) or quoted string character(s) is called a I<"literal">, such as:

    -21         # integer or gmp_integer or number

    'howdy'     # string

    -23.421_12  # number

    1_234_567   # unsigned_integer or integer or gmp_integer or number

    1_234_567_890_123_456_789_012_345_678_901_234_567_890_123_456_789_012_345  # gmp_integer

    'One million, two-hundred-thirty-four thousand, five-hundred-sixty-seven'  # string

    '1'         # character or string

    'a'         # character or string

    "\n"        # newline character or string

    q{}         # empty character or string

    0           # boolean or unsigned_integer or integer or gmp_integer or number

=head2 Section 2.1: Numbers (Numeric Data & Operators)

RPerl provides 5 numeric data types:

=over

=item * C<boolean>

S< >S< >S< >S< >a boolean logic value, either 0 or 1

=item * C<unsigned_integer>

S< >S< >S< >S< >a positive whole number value, greater than or equal to 0

=item * C<integer>

S< >S< >S< >S< >a whole number value, either negative, 0, or positive

=item * C<gmp_integer>

S< >S< >S< >S< >a possibly-very-large whole number value, either negative, 0, or positive; may safely exceed your computer's data type limits

=item * C<number>

S< >S< >S< >S< >a floating-point decimal number value, either negative, 0, or positive

=back

Perl 5 provides several built-in operators designed for use with numeric data, which can be organized into 6 general categories:

=over

=item * Arithmetic

=item * Trigonometry

=item * Comparison (Relational & Equality)

=item * Logic

=item * Bitwise

=item * Miscellaneous

=back

Each operator in Perl 5 (and thus RPerl) is assigned 4 important characteristics: I<"arity"> (a number), I<"fixity"> (a placement location), I<"precedence"> (a number) and I<"associativity"> (a chirality or "handedness").  Operators of unary arity accept exactly 1 input operand, binary operators accept exactly 2 operands, etc.  Prefix operators appear before their respective operands, postfix appear after, infix appear between, and closed operators appear both before and after their operands.  Operators with a lower numeric precedence are executed before operators with a higher precedence; in the absence of parentheses, multiplication executes before addition because multiplication has a lower precedence number.  Operators with equal precedence number are grouped by (and executed in order of) associativity; in the absence of parentheses, multiple subtraction operators will execute from left to right because subtraction is left-associative, whereas multiple exponent operators will execute from right to left because exponentiation is right-associative.  For more information, see the Appendix:

L</D.3: Syntax Arity, Fixity, Precedence, Associativity>

Beyond the built-in math operators in Perl 5, more advanced operators and functions are available via the MathPerl software suite, which is (perhaps unsurprisingly) optimized using the RPerl compiler.

L<MathPerl on CPAN|https://metacpan.org/release/MathPerl>

=head3 Section 2.1.1: Bool Literals

The most memory-efficient numeric literal is C<boolean>, which represents a single I<"bit"> (binary digit) of information.  A C<boolean> literal may only give the values of exactly 0 or 1.

    0     # boolean
    1     # boolean
    -1    # not a boolean
    1.5   # not a boolean
    -1.5  # not a boolean

=head3 Section 2.1.2: Unsigned Integer Literals

The second most efficient numeric literal is C<unsigned_integer>, which represents a single whole (non-decimal) number greater than or equal to 0.  An C<unsigned_integer> literal may describe any positive whole number, within the data size limits of the data types supported by your operating system software and computer hardware.  An C<unsigned_integer> may not describe a negative number or a non-whole number.

    23      # unsigned_integer
    0       # unsigned_integer
    42_230  # unsigned_integer
    -23     # not an unsigned_integer
    42.1    # not an unsigned_integer
    999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999  # bad unsigned_integer, outside data type limits

=head3 Section 2.1.3: Integer Literals

The third most efficient numeric literal is C<integer>, which represents a single whole (non-decimal) number.  An C<integer> literal may describe any positive or negative whole number, within your operating system and hardware data type limits.

    -23     # integer
    0       # integer
    42_230  # integer
    42.1    # not an integer
    -999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999  # bad integer, outside data type limits

=head3 Section 2.1.4: GMP Integer Literals

The GNU Multi-Precision (GMP) software library is utilized to provide the C<gmp_integer> numeric literal, representing a single whole (non-decimal) number which may safely exceed the data type limits of your operating system and hardware.  A C<gmp_integer> literal may describe any positive or negative whole number, within the limits of the memory (real or virtual) available to your RPerl code.

    -23     # gmp_integer
    0       # gmp_integer
    42_230  # gmp_integer
    42.1    # not a gmp_integer
    -999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999_999  # gmp_integer

=head3 Section 2.1.5: Number Literals

The C<number> numeric literal represents a single floating-point (decimal) number, and may express any real number within your computer's data type limits.

    -23.42     # number
    0.000_001  # number
    42.23      # number
    42         # number
    -4_123.456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456  # bad number, outside data type limits

=head3 Section 2.1.6: Underscore Digit Separators

For C<unsigned_integer>, C<integer>, C<gmp_integer>, and C<number> literals, an I<"underscore"> C<_> character must be inserted after every third digit away from the decimal point, where the underscore is used in a similar manner as a comma when writing long numbers by hand.

    1_234_567  # integer, same as "1,234,567" in American notation
    -32_123    # integer, same as "-32,123" in American notation
    -32123     # bad integer, missing underscore

    1.234_567           # number, same as "1.234567" in American notation
    -32_123.456_789_01  # number, same as "-32,123.45678901" in American notation
    -32_123.456_78901   # bad number, missing underscore

=head3 Section 2.1.7: Optional Positive Sign

For C<unsigned_integer>, C<integer>, C<gmp_integer>, and C<number> literals, an optional C<+> plus sign may be prepended to explicitly indicate a numeric literal is positive (greater than zero).

    1   # positive one
    +1  # also positive one

=for html <u>

I<BEST PRACTICES>

=over

=item * I<When only positive numeric literals are used in one area of code, omit positive signs.>

=item * I<When both positive and negative literals are used in one code area, use signs for all applicable literals.>

=back

=for html </u>

    +23    # NOT BEST PRACTICE: not aligned with other unsigned literal below
    +55.6  # NOT BEST PRACTICE: not aligned with other unsigned literal below
    42

    23     #     BEST PRACTICE:     aligned with other unsigned literal below, best for all-positive literals
    55.6   #     BEST PRACTICE:     aligned with other unsigned literal below, best for all-positive literals
    42

X<break_code_blocks>


    23     # NOT BEST PRACTICE:      not aligned with other signed literals below
    55.6   # NOT BEST PRACTICE:      not aligned with other signed literals below
    -21
    -66.5

     23    # NOT BEST PRACTICE: manually aligned with other signed literals below, but will not automatically align via Perl::Tidy
     55.6  # NOT BEST PRACTICE: manually aligned with other signed literals below, but will not automatically align via Perl::Tidy
    -21
    -66.5

    +23    #     BEST PRACTICE:          aligned with other signed literals below, best for mixed-sign literals
    +55.6  #     BEST PRACTICE:          aligned with other signed literals below, best for mixed-sign literals
    -21
    -66.5

=head3 Section 2.1.8: Scientific Notation

For C<unsigned_integer>, C<integer>, and C<number> literals, very large or very small numbers may be approximated using I<"scientific notation">, where each number is normalized to have exactly one digit to the left of the decimal point, then a lower-case C<e> character and an appropriate integer power-of-ten is appended to the resulting normalized floating-point number.  The C<e> character stands for "exponent", as in "exponent of ten", and the Perl style of scientific notation is sometimes more accurately referred to as I<"scientific e notation">.

As with normal integers, negative exponents must be prefixed with a C<-> minus sign and positive exponents may be optionally prefixed with a C<+> plus sign.

    1_234_567_000     # good integer
    1.234_567_000e09  # good number, same as "1_234_567_000" in scientific notation

    0.001_234_567_000  # good number
    1.234_567_000e-03  # good number, same as "0.001_234_567_000" in scientific notation

    -0.000_000_000_000_000_000_000_001_234_567  # bad number, outside data type limits
    -1.234_567e-24  # good number, same as "-0.000_000_000_000_000_000_000_001_234_567" in scientific notation

=for html <u>

I<BEST PRACTICES>

=over

=item * I<Use 2 digits to represent all exponents.>

=item * I<When only positive exponents are used, omit exponent signs.>

=item * I<When both positive and negative exponents are used, use signs for all exponents.>

=back

=for html </u>

    1_234_567_000      # NOT BEST PRACTICE: no exponent
    1.234_567_000e9    # NOT BEST PRACTICE: not aligned with two-digit exponents below
    1.234_567_000e+09  # NOT BEST PRACTICE: not aligned with two-digit exponents below
    1.234_567_000e09   #     BEST PRACTICE:     aligned with two-digit exponents below, best for all-positive exponents
    1.234_567_000e19
    2.111_000_333e04

    1.234_567_000e09   # NOT BEST PRACTICE: not aligned with signed exponents below
    1.234_567_000e+09  #     BEST PRACTICE:     aligned with signed exponents below, best for mixed-sign exponents
    1.234_567_000e-09
    2.111_000_333e-04

    # accuracy of following numbers may be reduced on computers with lower precision data types
    +1.537_969_711_485_091_65e+21  # BEST PRACTICE: best for mixed-sign exponents
    -2.591_931_460_998_796_41e+01  # BEST PRACTICE: best for mixed-sign exponents
    +1.792_587_729_503_711_81e-01  # BEST PRACTICE: best for mixed-sign exponents
    +2.680_677_724_903_893_22e-03  # BEST PRACTICE: best for mixed-sign exponents
    +1.628_241_700_382_422_95e-03  # BEST PRACTICE: best for mixed-sign exponents
    -9.515_922_545_197_158_70e-15  # BEST PRACTICE: best for mixed-sign exponents

=head3 Section 2.1.9: Truth Values

In the most simple case, a I<"truth value"> may be represented by a boolean literal where the numeric value of C<0> represents the truth value of I<"false">, and numeric C<1> represents I<"true">.  In general, a truth value is any data which may be recognized by Perl (and thus RPerl) as being either true or false; there is no third option.

Perl recognizes relatively few values as false, of which only 4 are accepted by RPerl:

      0   # false, number zero
     '0'  # false, text   zero
    q{0}  # false, text   zero
    q{}   # false, text   empty

All other values which RPerl accepts are recognized to hold a truth value of true.

All numeric operators in the comparison and logic sub-categories, as well as all string operators in the comparison sub-category, will generate truth values as output.

Perl attaches magic to the truth value of false, allowing it be utilized as either a normal truth value, or a numeric value of C<0>, or an empty string value of C<q{}>.  This magic behavior is not supported by C++, and thus not supported by RPerl.

In C and C++, only numeric C<0> is universally recognized as false, while the text 0 and empty text are recognized as true, which is different than Perl.  To achieve compatibility, RPerl automatically inserts additional C++ logic in all compiled output code to check for the 2 remaining RPerl false values of text character zero C<'0'> or C<q{0}>, and empty text C<q{}>.  This ensures the compiled C++ output code will behave identically to the original RPerl input source code, with regard to truth values.

B<WARNING FOR ALL COMPARISON & LOGIC OPERATORS:>

B<Due to Perl's magic attached to truth values of false, as well as the difference between Perl and C++ recognized truth values, you may experience unexpected or undefined behavior if a truth value is utilized anywhere except true-or-false conditions in loops and conditional statements.>

B<Only utilize the truth values returned by comparison and logic operators within the condition enclosed by parentheses in C<if ()>, C<elsif ()>, C<for ()>, or C<while ()>.>

    if    (1 > 2)     { print 'I think not', "\n"; }  # good use of greater-than operator
    elsif ($x and $y) { print 'Maybe',       "\n"; }  # good use of          and operator

    for   (my integer $i = 0; $i < 23; $i++) { print 'finite loop',   "\n"; }  # good use of less-than operator
    while (                    1 != 2      ) { print 'infinite loop', "\n"; }  # good use of not-equal operator

    my integer $foo = 3 + (1 >= 2);   # UNEXPECTED BEHAVIOR: bad use of greater-than-or-equal operator
    my integer $bar = 3 * (1 <= 2);   # UNEXPECTED BEHAVIOR: bad use of    less-than-or-equal operator
    my integer $bat = sin (1 == 2);   # UNEXPECTED BEHAVIOR: bad use of                 equal operator

=head3 Section 2.1.10: Floating-Point Error

A I<"floating-point number"> is any number which includes a decimal point C<.> as part of the numeric representation, as opposed to an integer which does not include a decimal point.  In RPerl, all floating-point values are stored in variables of the data type C<number>.

       0  # integer
       1  # integer
    -123  # integer
    
       0.1    # floating-point
       1.654  # floating-point
    -123.4    # floating-point
    
    my integer $some_int   = 23;     # integer variable
    my number  $some_float = 23.42;  # floating-point variable

All computer languages which perform calculations on floating-point numbers are susceptible to I<"floating-point error">, which is any inaccuracy due to incorrect rounding or lack of available precision.

For example, suppose you have a floating-point number C<0.105>, which seems normal enough.  Let us further suppose you want to divide C<0.105> by some other number, say C<1_000>, and by the simple rules of arithmetic you would expect to arrive at an answer of C<0.000_105>.  Unfortunately, due to the way floating-point numbers are stored in computer memory, the actual result is closer to C<0.000_104_999>, so C<0.000_105> happens to be one of many possible floating-point errors.

           (0.105 / 1_000) == 0.000_105    # UNEXPECTED BEHAVIOR: false
    print ((0.105 / 1_000) -  0.000_105);  # UNEXPECTED BEHAVIOR: -1.355_252_715_606_88e-20

It will usually not be possible to easily predict when and where floating-point error will occur.  In general, you may experience the effects of floating-point error whenever your code relies upon one or more of the following:

=over

=item * A floating-point operator which must return a specific, exact result

=item * A floating-point variable which must contain a specific, exact value

=item * A floating-point value which must exactly equal another floating-point value

=back

To compensate for unpredictable floating-point error, you should use the I<"floating-point epsilon"> value stored in the constant C<RPerl::EPSILON()>, which is a very small number used to help detect inaccuracies.  Whenever you want of directly compare two floating-point values, instead use the subtraction C<-> and absolute value C<abs> operators to take the positive difference, then use the less-than C<E<lt>> operator to compare the difference to the floating-point epsilon value.  If the difference is less than the floating-point epsilon, then the two input floating-point values can be considered to be numerically equal.

                                         RPerl::EPSILON()  # A VERY SMALL NUMBER: 0.000_000_000_000_000_2
         (0.105 / 1_000) == 0.000_105                      # UNEXPECTED BEHAVIOR: false
    abs ((0.105 / 1_000) -  0.000_105) < RPerl::EPSILON()  #   EXPECTED BEHAVIOR: true

X<break_code_blocks>


    my number $foo = 0.105 / 1_000;
    my number $faa = 0.105 / 1_000;
    my number $bar = 0.000_105;
    my number $bat = 0.000_105;
         if (0.000_105 == 0.000_105)             { print 'true'; } else { print 'false'; }  #   EXPECTED BEHAVIOR: true
         if ((0.105 / 1_000) == (0.105 / 1_000)) { print 'true'; } else { print 'false'; }  #   EXPECTED BEHAVIOR: true
         if ($bar == $bat)                       { print 'true'; } else { print 'false'; }  #   EXPECTED BEHAVIOR: true
         if ($foo == $faa)                       { print 'true'; } else { print 'false'; }  #   EXPECTED BEHAVIOR: true
         if ($foo == $bar)                       { print 'true'; } else { print 'false'; }  # UNEXPECTED BEHAVIOR: false
    if (abs ($foo -  $bar) < RPerl::EPSILON())   { print 'true'; } else { print 'false'; }  #   EXPECTED BEHAVIOR: true

B<WARNING FOR ALL FLOATING-POINT NUMERIC OPERATORS:>

B<Due to floating-point error, unexpected behavior may be experienced if a floating-point value is tested for exact equality with any other value.>

B<Always use the floating-point epsilon value C<RPerl::EPSILON()> to check for approximate equality instead of exact equality.>

=head3 Section 2.1.11: Arithmetic Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.11-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Arithmetic Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Absolute Value

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

abs

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Natural Exponential Function

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

exp

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Exponent AKA Power

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

**

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

04

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Negative with Parentheses

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

-( )

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Closed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

05

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Multiply

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

*

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

07

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Divide

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

/

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

07

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Modulo AKA Modulus

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

%

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

07

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Add

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

+

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

08

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Subtract

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

-

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

08

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Natural Logarithm

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

log

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Square Root

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

sqrt

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Absolute Value>

    abs VALUE

VALUE is numeric value;

If operand VALUE is 0 or positive (greater than 0), return unchanged;

If VALUE is negative (less than 0), return positive number with equal magnitude (distance from 0)

    abs  0         # 0
    abs  1         # 1
    abs -1         # 1
    abs  2_112.23  # 2_112.23
    abs -2_112.23  # 2_112.23

=back

=over

=item * B<Natural Exponential Function>

    exp VALUE

VALUE is numeric value;

Raise C<e> (base of natural logarithm) to the power of operand VALUE, return result

    exp  0  # 1
    exp  1  # 2.718_281_828_459_05
    exp -1  # 0.367_879_441_171_442

=back

=over

=item * B<Exponent AKA Power>

    VALUE1 ** VALUE2

VALUE1 and VALUE2 are numeric values;

Raise first operand VALUE1 to the power of second operand VALUE2, return result

    0 ** 0  # 1
    0 ** 1  # 0
    0 ** 2  # 0
    0 ** 3  # 0
    1 ** 0  # 1
    1 ** 1  # 1
    1 ** 2  # 1
    1 ** 3  # 1
    2 ** 0  # 1
    2 ** 1  # 2
    2 ** 2  # 4
    2 ** 3  # 8

    (-1) ** 0  #  1
    (-1) ** 1  # -1
    (-1) ** 2  #  1
    (-1) ** 3  # -1
    (-2) ** 0  #  1
    (-2) ** 1  # -2
    (-2) ** 2  #  4
    (-2) ** 3  # -8

    0 ** -1  # inf
    0 ** -2  # inf
    0 ** -3  # inf
    1 ** -1  # 1
    1 ** -2  # 1
    1 ** -3  # 1
    2 ** -1  # 0.5
    2 ** -2  # 0.25
    2 ** -3  # 0.125

    (-1) ** -1  # -1
    (-1) ** -2  #  1
    (-1) ** -3  # -1
    (-2) ** -1  # -0.5
    (-2) ** -2  #  0.25
    (-2) ** -3  # -0.125

=back

=over

=item * B<Negative with Parentheses>

    -( VALUE )

VALUE is numeric value;

Change sign of operand VALUE, return result;

Negative VALUE becomes positive, and positive VALUE becomes negative;

Parentheses must be used, due to ambiguity of hyphen C<-> character as negative operator, subtraction operator, or negative number literal

    -( 0)         #  0
    -( 1)         # -1
    -(-1)         #  1
    -( 0.25)      # -0.25
    -(-0.25)      #  0.25
    -( 2_112.23)  # -2_112.23
    -(-2_112.23)  #  2_112.23

=back

=over

=item * B<Multiply>

    VALUE1 * VALUE2

VALUE1 and VALUE2 are numeric values;

Multiply first operand VALUE1 by second operand VALUE2, return product

     0 *  0  #  0
     0 *  1  #  0
     0 * -1  #  0
     1 *  0  #  0
     1 *  1  #  1
     1 * -1  # -1
    -1 *  0  #  0
    -1 *  1  # -1
    -1 * -1  #  1

    0.5 *  0    #  0
    0.5 *  0.5  #  0.25
    0.5 * -0.5  # -0.25
    0.5 *  1    #  0.5
    0.5 * -1    # -0.5
    0.5 *  2    #  1.0
    0.5 * -2    # -1.0

=back

=over

=item * B<Divide>

    VALUE1 / VALUE2

VALUE1 and VALUE2 are numeric values;

Divide first operand VALUE1 by second operand VALUE2, return quotient;

Error if attempt to divide by 0

     0 /  0  #  ERROR
     0 /  1  #  0
     0 / -1  #  0
     1 /  0  #  ERROR
     1 /  1  #  1
     1 / -1  # -1
    -1 /  0  #  ERROR
    -1 /  1  # -1
    -1 / -1  #  1

    0.5 /  0    #  ERROR
    0.5 /  0.5  #  1
    0.5 / -0.5  # -1
    0.5 /  1    #  0.5
    0.5 / -1    # -0.5
    0.5 /  2    #  0.25
    0.5 / -2    # -0.25

=back

=over

=item * B<Modulo AKA Modulus>

    VALUE1 % VALUE2

VALUE1 and VALUE2 are numeric values;

Divide integer part of first operand VALUE1 by integer part of second operand VALUE2, return remainder;

Error if attempt to modulus by VALUE2 with absolute value less than 1

     0 %  0  # ERROR
     0 %  1  # 0
     0 % -1  # 0
     1 %  0  # ERROR
     1 %  1  # 0
     1 % -1  # 0
    -1 %  0  # ERROR
    -1 %  1  # 0
    -1 % -1  # 0

    0.5 %  0    # ERROR
    0.5 %  0.5  # ERROR
    0.5 % -0.5  # ERROR
    0.5 %  1    # 0
    0.5 % -1    # 0
    0.5 %  2    # 0
    0.5 % -2    # 0

=back

=over

=item * B<Add>

    VALUE1 + VALUE2

VALUE1 and VALUE2 are numeric values;

Add first operand VALUE1 to second operand VALUE2, return sum

     0 +  0  #  0
     0 +  1  #  1
     0 + -1  # -1
     1 +  0  #  1
     1 +  1  #  2
     1 + -1  #  0
    -1 +  0  # -1
    -1 +  1  #  0
    -1 + -1  # -2

    0.5 +  0    #  0.5
    0.5 +  0.5  #  1.0
    0.5 + -0.5  #  0
    0.5 +  1    #  1.5
    0.5 + -1    # -0.5
    0.5 +  2    #  2.5
    0.5 + -2    # -1.5

=back

=over

=item * B<Subtract>

    VALUE1 - VALUE2

VALUE1 and VALUE2 are numeric values;

Subtract second operand VALUE2 from first operand VALUE1, return difference

     0 -  0  #  0
     0 -  1  # -1
     0 - -1  #  1
     1 -  0  #  1
     1 -  1  #  0
     1 - -1  #  2
    -1 -  0  # -1
    -1 -  1  # -2
    -1 - -1  #  0

    0.5 -  0    #  0.5
    0.5 -  0.5  #  0
    0.5 - -0.5  #  1.0
    0.5 -  1    # -0.5
    0.5 - -1    #  1.5
    0.5 -  2    # -1.5
    0.5 - -2    #  2.5

=back

=over

=item * B<Natural Logarithm>

    log VALUE

VALUE is numeric value;

Take logarithm base C<e> of operand VALUE, return result;

Constant C<e> is known as Euler's Number and is defined as the limit of C<(1 + 1/$n)**$n> as C<$n> grows to infinity;

To instead calculate logarithm using a base other than C<e>, utilize ratio C<(log $operand)/(log $base)>;

Error if attempt to take logarithm of VALUE less than or equal to 0

    log  0                    # ERROR
    log  1                    # 0
    log -1                    # ERROR
    log 2.718_281_828_459_05  # 1

=back

=over

=item * B<Square Root>

    sqrt VALUE

VALUE is numeric value;

Take square root of operand VALUE, return result;

Error if attempt to take square root of VALUE less than 0

    sqrt  0  # 0
    sqrt  1  # 1
    sqrt -1  # ERROR
    sqrt  2  # 1.414_213_562_373_1

=back

=head3 Section 2.1.12: Trigonometry Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.12-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Trigonometry Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Arctangent-Divide

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

atan2

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Sine

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

sin

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Cosine

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

cos

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Arctangent-Divide>

    atan2 VALUE1, VALUE2

VALUE1 and VALUE2 are numeric values;

Divide first operand VALUE1 by second operand VALUE2, take arctangent of quotient, return result;

Attempts to conform to Open Group / IEEE standards:

L<http://perldoc.perl.org/perlport.html#atan2>

L<http://pubs.opengroup.org/onlinepubs/9699919799/functions/atan2.html>

To instead calculate tangent of 1 operand (not arctangent of 2 operands), utilize trigonometry identity ratio C<(sin $operand)/(cos $operand)>

    atan2  0,  0  #  0, MAY BE DIFFERENT ON YOUR SYSTEM
    atan2  0,  1  #  0
    atan2  0, -1  #  3.141_592_653_589_79, DEFINED AS PI
    atan2  1,  0  #  1.570_796_326_794_9
    atan2  1,  1  #  0.785_398_163_397_448
    atan2  1, -1  #  2.356_194_490_192_34
    atan2 -1,  0  # -1.570_796_326_794_9
    atan2 -1,  1  # -0.785_398_163_397_448
    atan2 -1, -1  # -2.356_194_490_192_34

=back

=over

=item * B<Sine>

    sin VALUE

VALUE is numeric value;

Take sine of operand VALUE, return result

    sin  0                     #  0
    sin  1                     #  0.841_470_984_807_897
    sin -1                     # -0.841_470_984_807_897
    sin  3.141_592_653_589_79  #  0, MAY BE SLIGHTLY OFF DUE TO FLOATING POINT ERROR

=back

=over

=item * B<Cosine>

    cos VALUE

VALUE is numeric value;

Take cosine of operand VALUE, return result

    cos  0                     #  1
    cos  1                     #  0.540_302_305_868_14
    cos -1                     #  0.540_302_305_868_14
    cos  3.141_592_653_589_79  # -1

=back

=head3 Section 2.1.13: Comparison (Relational & Equality) Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.13-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Comparison (Relational & Equality) Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Less-Than

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

<

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Greater-Than

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

>

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Less-Than-Or-Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

<=

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Greater-Than-Or-Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

>=

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

E<61>E<61>

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Not-Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

!=

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Three-Way Comparison AKA Spaceship

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

<=>

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Less-Than>

    VALUE1 < VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine relation of operands, return true if first operand VALUE1 is less than second operand VALUE2, otherwise return false

     0 <  0  # false
     0 <  1  # true
     0 < -1  # false
     1 <  0  # false
     1 <  1  # false
     1 < -1  # false
    -1 <  0  # true
    -1 <  1  # true
    -1 < -1  # false

=back

=over

=item * B<Greater-Than>

    VALUE1 > VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine relation of operands, return true if first operand VALUE1 is greater than second operand VALUE2, otherwise return false

     0 >  0  # false
     0 >  1  # false
     0 > -1  # true
     1 >  0  # true
     1 >  1  # false
     1 > -1  # true
    -1 >  0  # false
    -1 >  1  # false
    -1 > -1  # false

=back

=over

=item * B<Less-Than-Or-Equal>

    VALUE1 <= VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine relation of operands, return true if first operand VALUE1 is less than or equal to second operand VALUE2, otherwise return false

     0 <=  0  # true
     0 <=  1  # true
     0 <= -1  # false
     1 <=  0  # false
     1 <=  1  # true
     1 <= -1  # false
    -1 <=  0  # true
    -1 <=  1  # true
    -1 <= -1  # true

=back

=over

=item * B<Greater-Than-Or-Equal>

    VALUE1 >= VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine relation of operands, return true if first operand VALUE1 is greater than or equal to second operand VALUE2, otherwise return false

     0 >=  0  # true
     0 >=  1  # false
     0 >= -1  # true
     1 >=  0  # true
     1 >=  1  # true
     1 >= -1  # true
    -1 >=  0  # false
    -1 >=  1  # false
    -1 >= -1  # true

=back

=over

=item * B<Equal>

    VALUE1 == VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine equality of operands, return true if first operand VALUE1 is equal to second operand VALUE2, otherwise return false

     0 ==  0  # true
     0 ==  1  # false
     0 == -1  # false
     1 ==  0  # false
     1 ==  1  # true
     1 == -1  # false
    -1 ==  0  # false
    -1 ==  1  # false
    -1 == -1  # true

=back

=over

=item * B<Not-Equal>

    VALUE1 != VALUE2

VALUE1 and VALUE2 are numeric values;

Compare to determine equality of operands, return true if first operand VALUE1 is not equal to second operand VALUE2, otherwise return false

     0 !=  0  # false
     0 !=  1  # true
     0 != -1  # true
     1 !=  0  # true
     1 !=  1  # false
     1 != -1  # true
    -1 !=  0  # true
    -1 !=  1  # true
    -1 != -1  # false

=back

=over

=item * B<Three-Way Comparison AKA Spaceship>

    VALUE1 <=> VALUE2

VALUE1 and VALUE2 are numeric values;

Perform three-way comparison of operands; 

Return -1 if first operand VALUE1 is less than second operand VALUE2, return 0 if operands are equal, or return 1 if VALUE1 is greater than VALUE2;

Randal L. Schwartz coined the operator's nickname based on visual similarity to Darth Vader's TIE Advanced x1 (TIE fighter) personal spacecraft

(Thankfully, C<E<lt>oE<gt>> and C<[=O=]> are not yet valid Perl 5 syntax)

     0 <=>  0  #  0
     0 <=>  1  # -1
     0 <=> -1  #  1
     1 <=>  0  #  1
     1 <=>  1  #  0
     1 <=> -1  #  1
    -1 <=>  0  # -1
    -1 <=>  1  # -1
    -1 <=> -1  #  0

=back

=head3 Section 2.1.14: Logic Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.14-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Logic Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Logical Negation

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

!

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

05

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Logical And

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

&&

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

15

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Logical Or

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

||

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

16

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Logical Negation

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

not

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

22

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Logical And 

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

and

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

23

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Logical Or

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

or

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

24

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Logical Xor

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

xor

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

24

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Logical Negation>

    ! VALUE
    not VALUE

VALUE is numeric value;

Take logical negation of operand VALUE, return result;

Logical negation operators C<!> and C<not> return the same results, and differ only by precedence

    !    0  # true
    !    1  # false
    !   -1  # false

    not  0  # true
    not  1  # false
    not -1  # false

=back

=over

=item * B<Logical And>

    VALUE1 && VALUE2
    VALUE1 and VALUE2

VALUE1 and VALUE2 are numeric values;

Take logical conjunction of operands VALUE1 and VALUE2, return result;

Logical and operators C<&&> and C<and> return the same results, and differ only by precedence

     0 &&   0  # false
     0 &&   1  # false
     0 &&  -1  # false
     1 &&   0  # false
     1 &&   1  # true
     1 &&  -1  # true
    -1 &&   0  # false
    -1 &&   1  # true
    -1 &&  -1  # true

     0 and  0  # false
     0 and  1  # false
     0 and -1  # false
     1 and  0  # false
     1 and  1  # true
     1 and -1  # true
    -1 and  0  # false
    -1 and  1  # true
    -1 and -1  # true

=back

=over

=item * B<Logical Or>

    VALUE1 || VALUE2
    VALUE1 or VALUE2

VALUE1 and VALUE2 are numeric values;

Take logical disjunction of operands VALUE1 and VALUE2, return result;

Logical or operators C<||> and C<or> return the same results, and differ only by precedence

     0 ||  0  # false
     0 ||  1  # true
     0 || -1  # true
     1 ||  0  # true
     1 ||  1  # true
     1 || -1  # true
    -1 ||  0  # true
    -1 ||  1  # true
    -1 || -1  # true

     0 or  0  # false
     0 or  1  # true
     0 or -1  # true
     1 or  0  # true
     1 or  1  # true
     1 or -1  # true
    -1 or  0  # true
    -1 or  1  # true
    -1 or -1  # true

=back

=over

=item * B<Logical Xor>

    VALUE1 xor VALUE2

VALUE1 and VALUE2 are numeric values;

Take logical exclusive disjunction of operands VALUE1 and VALUE2, return result

     0 xor  0  # false
     0 xor  1  # true
     0 xor -1  # true
     1 xor  0  # true
     1 xor  1  # false
     1 xor -1  # false
    -1 xor  0  # true
    -1 xor  1  # false
    -1 xor -1  # false

=back

=head3 Section 2.1.15: Bitwise Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.15-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Bitwise Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Bitwise Negation with Parentheses

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

~( )

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Closed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

05

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Bitwise Shift Left 

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

<<

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

09

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Bitwise Shift Right

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

>>

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

09

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Bitwise And

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

&

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

13

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Bitwise Or

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

|

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

14

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Bitwise Xor

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

^

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

14

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

All code examples are shown using 64-bit integers; your results may vary depending upon your C++ compiler and hardware platform.

B<WARNING FOR ALL BITWISE OPERATORS:>

B<Due to the difference between how integer and non-integer scalar values are stored in memory, you may experience unexpected or undefined behavior if a bitwise operator is passed any non-integer operands as input.>

B<Only utilize bitwise operators with integer, unsigned_integer, or boolean operands.>

    ~(1)      # good use of bitwise negation    operator
    12 << 2   # good use of bitwise shift left  operator
    13 >> 3   # good use of bitwise shift right operator

    my unsigned_integer $foo = 14;
    $foo & 4  # good use of bitwise and operator
    $foo | 5  # good use of bitwise  or operator
    $foo ^ 6  # good use of bitwise xor operator

    my number $bar = 21.12;
    ~($bar)         # UNEXPECTED BEHAVIOR: bad use of bitwise negation    operator
      $bar <<    7  # UNEXPECTED BEHAVIOR: bad use of bitwise shift left  operator
         8 >> $bar  # UNEXPECTED BEHAVIOR: bad use of bitwise shift right operator

    23.42 &   9   # UNEXPECTED BEHAVIOR: bad use of bitwise and operator
    23    ^ 1.1   # UNEXPECTED BEHAVIOR: bad use of bitwise xor operator

B<Also, due to the difference between how signed and unsigned integer values are stored in memory, both Perl's C<use integer;> pragma configuration command as well as RPerl's C<integer> and C<unsigned_integer> data types must be utilized in correct combination, as described below.  Perl relies on the C<use integer;> pragma to determine numeric data types, while C++ relies on the actual data types provided by the software developers as part of each variable declaration.  You may experience unexpected behavior if a bitwise operator is utilized with mismatching pragma and data types.>

B<Each call to Perl's C<use integer;> pragma applies to 1 entire RPerl source code file at a time, either 1 full *.pl program file or 1 full *.pm module file.  If the C<use integer;> pragma is in effect for a specific RPerl file, then all bitwise operators in said file must be provided with input operands which are signed (positive or negative) integers only, not unsigned integers or floating-point numbers or other data types.  If C<use integer;> is not in effect for an RPerl file, then all bitwise operators in said file must be provided with operands which are unsigned (non-negative) integers or booleans only, not signed integers or other data types.>

B<The C<use integer;> pragma also affects the results of all arithmetic and comparison operators by discarding the non-integer (fractional) portion of input operands, as if the C<floor> operator were called to convert each floating-point number into an integer.  Because of this, floating-point operators and signed integer bitwise operators must not be included in the same single RPerl source code file; to compensate, simply move all signed bitwise operators into their own separate RPerl *.pm module file which calls C<use integer;>.>

B<Please see the Perl documentation for more information about the C<use integer;> pragma:>

L<http://perldoc.perl.org/integer.html>

    # good combination: no 'use integer;' pragma, 
    # unsigned_integer data types for bitwise negation operator, number data type for multiplication operation
    my unsigned_integer $foo = 5;
    my unsigned_integer $bar = ~($foo);  # $bar  = 18_446_744_073_709_551_610
    my number $quux = 21.12 * 42.23;     # $quux = 891.897_6

X<break_code_blocks>


    # good combination: 'use integer;' pragma,
    # integer data types for both bitwise negation operator and multiplication operator
    use integer;
    my integer $foo = 5;
    my integer $bar = ~($foo);   # $bar  = -6
    my integer $quux = 21 * 42;  # $quux =  882

X<break_code_blocks>


    # bad combination: no 'use integer;' pragma, 
    # integer data types for bitwise negation operator
    my integer $foo = 5;
    my integer $bar = ~($foo);   # UNEXPECTED BEHAVIOR: ($bar = 18_446_744_073_709_551_610) in Perl, but ($bar = -6) in C++

X<break_code_blocks>


    # bad combination: 'use integer;' pragma,
    # unsigned_integer data types for bitwise negation operator, number data type for multiplication operator
    use integer;
    my unsigned_integer $foo = 5;
    my unsigned_integer $bar = ~($foo);  # UNEXPECTED BEHAVIOR: ($bar = -6) in Perl, but ($bar = 18_446_744_073_709_551_610) in C++
    my number $quux = 21.12 * 42.23;     # UNEXPECTED BEHAVIOR: ($quux = 882) in Perl, but ($quux = 891.897_6) in C++

=over

=item * B<Bitwise Negation with Parentheses>

    ~( VALUE )

VALUE is numeric value;

Negate each bit of operand VALUE, return result;

May be used to take one's complement of VALUE;

Parentheses must be used, due to ambiguity of tilde C<~> character as used for bitwise negation operator, smartmatch operator C<~~>, or regular expression C<=~>

    ~(-8)  #                          7
    ~(-2)  #                          1
    ~(-1)  #                          0
    ~( 0)  # 18_446_744_073_709_551_615
    ~( 1)  # 18_446_744_073_709_551_614
    ~( 2)  # 18_446_744_073_709_551_613
    ~( 8)  # 18_446_744_073_709_551_607

X<break_code_blocks>


    use integer;
    ~(-8)  #  7
    ~(-2)  #  1
    ~(-1)  #  0
    ~( 0)  # -1
    ~( 1)  # -2
    ~( 2)  # -3
    ~( 8)  # -9

=back

=over

=item * B<Bitwise Shift Left>

    VALUE1 << VALUE2

VALUE1 and VALUE2 are numeric values;

Shift left the value of first operand VALUE1 by number of bits specified by second operand VALUE2, return result;

May be used to multiply VALUE1 by 2 raised to the power of VALUE2

    1 << 0  #  1
    1 << 1  #  2
    1 << 2  #  4
    1 << 3  #  8
    2 << 0  #  2
    2 << 1  #  4
    2 << 2  #  8
    2 << 3  # 16
    2 << 4  # 32
    2 << 5  # 64

X<break_code_blocks>


    -1 << -8  # 18_374_686_479_671_623_680
    -1 << -1  #  9_223_372_036_854_775_808
    -1 <<  0  # 18_446_744_073_709_551_615
    -1 <<  1  # 18_446_744_073_709_551_614
    -1 <<  8  # 18_446_744_073_709_551_360
     0 << -8  #                          0
     0 << -1  #                          0
     0 <<  0  #                          0
     0 <<  1  #                          0
     0 <<  8  #                          0
     1 << -8  #     72_057_594_037_927_936
     1 << -1  #  9_223_372_036_854_775_808
     1 <<  0  #                          1
     1 <<  1  #                          2
     1 <<  8  #                        256

X<break_code_blocks>


    use integer;
    -1 << -8  #    -72_057_594_037_927_936
    -1 << -1  # -9_223_372_036_854_775_808
    -1 <<  0  #                         -1
    -1 <<  1  #                         -2
    -1 <<  8  #                       -256
     0 << -8  #                          0
     0 << -1  #                          0
     0 <<  0  #                          0
     0 <<  1  #                          0
     0 <<  8  #                          0
     1 << -8  #     72_057_594_037_927_936
     1 << -1  # -9_223_372_036_854_775_808
     1 <<  0  #                          1
     1 <<  1  #                          2
     1 <<  8  #                        256

=back

=over

=item * B<Bitwise Shift Right>

    VALUE1 >> VALUE2

VALUE1 and VALUE2 are numeric values;

Shift right the value of first operand VALUE1 by number of bits specified by second operand VALUE2, return result;

May be used to divide VALUE1 by 2 raised to the power of VALUE2

     8 >>  0  #  8
     8 >>  1  #  4
     8 >>  2  #  2
     8 >>  3  #  1
    64 >>  0  # 64
    64 >>  1  # 32
    64 >>  2  # 16
    64 >>  3  #  8
    64 >>  4  #  4
    64 >>  5  #  2
    64 >>  8  #  1

X<break_code_blocks>


    -1 >> -8  #                        255
    -1 >> -1  #                          1
    -1 >>  0  # 18_446_744_073_709_551_615
    -1 >>  1  #  9_223_372_036_854_775_807
    -1 >>  8  #     72_057_594_037_927_935
     0 >> -8  #                          0
     0 >> -1  #                          0
     0 >>  0  #                          0
     0 >>  1  #                          0
     0 >>  8  #                          0
     1 >> -8  #                          0
     1 >> -1  #                          0
     1 >>  0  #                          1
     1 >>  1  #                          0
     1 >>  8  #                          0

X<break_code_blocks>


    use integer;
    -1 >> -8  # -1
    -1 >> -1  # -1
    -1 >>  0  # -1
    -1 >>  1  # -1
    -1 >>  8  # -1
     0 >> -8  #  0
     0 >> -1  #  0
     0 >>  0  #  0
     0 >>  1  #  0
     0 >>  8  #  0
     1 >> -8  #  0
     1 >> -1  #  0
     1 >>  0  #  1
     1 >>  1  #  0
     1 >>  8  #  0

=back

=over

=item * B<Bitwise And>

    VALUE1 & VALUE2

VALUE1 and VALUE2 are numeric values;

Take conjunction of each bit of first operand VALUE1 with respective bit of second operand VALUE2, return result

    -1 & -8  # 18_446_744_073_709_551_608
    -1 & -1  # 18_446_744_073_709_551_615
    -1 &  0  #                          0
    -1 &  1  #                          1
    -1 &  8  #                          8
     0 & -8  #                          0
     0 & -1  #                          0
     0 &  0  #                          0
     0 &  1  #                          0
     0 &  8  #                          0
     1 & -8  #                          0
     1 & -1  #                          1
     1 &  0  #                          0
     1 &  1  #                          1
     1 &  8  #                          0

X<break_code_blocks>


    use integer;
    -1 & -8  # -8
    -1 & -1  # -1
    -1 &  0  #  0
    -1 &  1  #  1
    -1 &  8  #  8
     0 & -8  #  0
     0 & -1  #  0
     0 &  0  #  0
     0 &  1  #  0
     0 &  8  #  0
     1 & -8  #  0
     1 & -1  #  1
     1 &  0  #  0
     1 &  1  #  1
     1 &  8  #  0

=back

=over

=item * B<Bitwise Or>

    VALUE1 | VALUE2

VALUE1 and VALUE2 are numeric values;

Take disjunction of each bit of first operand VALUE1 with respective bit of second operand VALUE2, return result

    -1 | -8  # 18_446_744_073_709_551_615
    -1 | -1  # 18_446_744_073_709_551_615
    -1 |  0  # 18_446_744_073_709_551_615
    -1 |  1  # 18_446_744_073_709_551_615
    -1 |  8  # 18_446_744_073_709_551_615
     0 | -8  # 18_446_744_073_709_551_608
     0 | -1  # 18_446_744_073_709_551_615
     0 |  0  #                          0
     0 |  1  #                          1
     0 |  8  #                          8
     1 | -8  # 18_446_744_073_709_551_609
     1 | -1  # 18_446_744_073_709_551_615
     1 |  0  #                          1
     1 |  1  #                          1
     1 |  8  #                          9

X<break_code_blocks>


    use integer;
    -1 | -8  # -1
    -1 | -1  # -1
    -1 |  0  # -1
    -1 |  1  # -1
    -1 |  8  # -1
     0 | -8  # -8
     0 | -1  # -1
     0 |  0  #  0
     0 |  1  #  1
     0 |  8  #  8
     1 | -8  # -7
     1 | -1  # -1
     1 |  0  #  1
     1 |  1  #  1
     1 |  8  #  9

=back

=over

=item * B<Bitwise Xor>

    VALUE1 ^ VALUE2

VALUE1 and VALUE2 are numeric values;

Take exclusive disjunction of each bit of first operand VALUE1 with respective bit of second operand VALUE2, return result

    -1 ^ -8  #                          7
    -1 ^ -1  #                          0
    -1 ^  0  # 18_446_744_073_709_551_615
    -1 ^  1  # 18_446_744_073_709_551_614
    -1 ^  8  # 18_446_744_073_709_551_607
     0 ^ -8  # 18_446_744_073_709_551_608
     0 ^ -1  # 18_446_744_073_709_551_615
     0 ^  0  #                          0
     0 ^  1  #                          1
     0 ^  8  #                          8
     1 ^ -8  # 18_446_744_073_709_551_609
     1 ^ -1  # 18_446_744_073_709_551_614
     1 ^  0  #                          1
     1 ^  1  #                          0
     1 ^  8  #                          9

X<break_code_blocks>


    use integer;
    -1 ^ -8  #  7
    -1 ^ -1  #  0
    -1 ^  0  # -1
    -1 ^  1  # -2
    -1 ^  8  # -9
     0 ^ -8  # -8
     0 ^ -1  # -1
     0 ^  0  #  0
     0 ^  1  #  1
     0 ^  8  #  8
     1 ^ -8  # -7
     1 ^ -1  # -2
     1 ^  0  #  1
     1 ^  1  #  0
     1 ^  8  #  9

=back

=head3 Section 2.1.16: Miscellaneous Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.1.16-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Miscellaneous Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Floor with Parentheses

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

POSIX::floor( )

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Closed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Ceiling with Parentheses

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

POSIX::ceil( )

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Closed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Separate Integer & Fraction Parts with Parentheses

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

POSIX::modf( )

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Closed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Integer Part

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

int

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Random Number

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

rand

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Nullary or Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Random Seed

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

srand

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Nullary or Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Floor with Parentheses>

    POSIX::floor( VALUE )

VALUE is numeric value;

If operand VALUE contains fractional part, then return next lowest integer, otherwise return VALUE unchanged;

Not a Perl built-in operator, it is a Perl subroutine (which happens to provide an interface to the underlying C subroutine of the same name); thus, C<POSIX::floor()> must be called with both the preceeding C<POSIX::> namespace and parentheses around the operand

    POSIX::floor( 0)  #  0
    POSIX::floor( 1)  #  1
    POSIX::floor(-1)  # -1

    POSIX::floor(1.1)  # 1
    POSIX::floor(1.5)  # 1
    POSIX::floor(1.9)  # 1

    POSIX::floor(-2.2)  # -3
    POSIX::floor(-2.6)  # -3
    POSIX::floor(-2.8)  # -3

=back

=over

=item * B<Ceiling with Parentheses>

    POSIX::ceil( VALUE )

VALUE is numeric value;

If operand VALUE contains fractional part, then return next highest integer, otherwise return VALUE unchanged;

Not a Perl built-in operator, it is a Perl subroutine (which happens to provide an interface to the underlying C subroutine of the same name); thus, C<POSIX::ceil()> must be called with both the preceeding C<POSIX::> namespace and parentheses around the operand

    POSIX::ceil( 0)  #  0
    POSIX::ceil( 1)  #  1
    POSIX::ceil(-1)  # -1

    POSIX::ceil(1.1)  # 2
    POSIX::ceil(1.5)  # 2
    POSIX::ceil(1.9)  # 2

    POSIX::ceil(-2.2)  # -2
    POSIX::ceil(-2.6)  # -2
    POSIX::ceil(-2.8)  # -2

=back

=over

=item * B<Separate Integer & Fraction Parts with Parentheses>

    POSIX::modf( VALUE )

VALUE is numeric value;

Break apart operand VALUE into integer part and fraction part, return both, fraction part first;

Not a Perl built-in operator, it is a Perl subroutine (which happens to provide an interface to the underlying C subroutine of the same name); thus, C<POSIX::modf()> must be called with both the preceeding C<POSIX::> namespace and parentheses around the operand;

Returns more than one return value (always two); thus, must be wrapped in square brackets C<[ ]> and stored in C<number_arrayref> data structure, then individual parts accessed via thin-arrow C<-E<gt>> array dereference and element retrieval

    POSIX::modf( 0)  # 0,  0
    POSIX::modf( 1)  # 0,  1
    POSIX::modf(-1)  # 0, -1

    POSIX::modf(1.1)  # 0.1, 1
    POSIX::modf(1.5)  # 0.5, 1
    POSIX::modf(1.9)  # 0.9, 1

    POSIX::modf(-2.2)  # -0.2, -2
    POSIX::modf(-2.6)  # -0.6, -2
    POSIX::modf(-2.8)  # -0.8, -2

X<break_code_blocks>


    my number_hashref $retvals = [POSIX::modf(-3.141_59)];  # -0.141_59, -3
    my number $integer_part    = $retvals->[1];  # -3
    my number $fraction_part   = $retvals->[0];  # -0.141_59

=back

=over

=item * B<Integer Part>

    int VALUE

VALUE is numeric value;

Discard fractional component of operand VALUE, return result

B<WARNING, FLOATING-POINT ERROR:>

B<The C<int> operator may produce unexpected behavior due to floating-point error; you may instead prefer use of the C<POSIX::floor()>, C<POSIX::ceil()>, and C<POSIX::modf()> subroutines.>

    int  0  #  0
    int  1  #  1
    int -1  # -1

    int 1.1  # 1
    int 1.5  # 1
    int 1.9  # 1

    int -2.2  # -2
    int -2.6  # -2
    int -2.8  # -2

X<break_code_blocks>


    int               (-4.725 / 0.025)  # UNEXPECTED BEHAVIOR: -188 due to floating-point error
    -189 ==           (-4.725 / 0.025)  # UNEXPECTED BEHAVIOR: false, values in memory do not match
    printf "%.18f\n", (-4.725 / 0.025)  # UNEXPECTED BEHAVIOR: -188.999_999_999_999_971_578 due to floating-point error
    print             (-4.725 / 0.025)  #   EXPECTED BEHAVIOR: -189 due to automatic floating-point epsilon checking
    POSIX::floor      (-4.725 / 0.025)  #   EXPECTED BEHAVIOR: -189 due to explicitly forcing to next lowest integer 

=back

=over

=item * B<Random Number>

    rand
    rand VALUE

VALUE is numeric value;

Returns pseudo-random floating-point number between 0 and operand VALUE, defaults to VALUE of 1 if omitted;

Generated pseudo-random number is based on seed value passed to C<srand> operator, and C<srand> is called automatically if not called explicitly

B<WARNING, SECURITY LIABILITY:>

B<The C<rand> operator is not considered to be cryptographically secure pseudo-random number generator (CSPRNG), and should thus not be utilized for cryptography or other security-sensitive purposes.> 

    rand     # between 0 and 1
    rand 1   # between 0 and 1
    rand 10  # between 0 and 10

=back

=over

=item * B<Random Seed>

    srand
    srand VALUE

VALUE is numeric value;

Seed C<rand> operator with operand VALUE, defaults to automatically-selected VALUE if omitted;

Entropy (randomness) is decreased if called more than once per program;

If C<srand> is called with a specific seed value followed by one or more calls to C<rand>, then you call C<srand> with the same seed value followed by C<rand> again, you will receive the same value(s) returned by C<rand> after both calls to C<srand>

    srand       # seed is automatically chosen
    srand 1     # seed is 1
    srand 10    # seed is 10
    srand time  # seed is number of non-leap seconds since epoch, usually Unix epoch (19700101 AKA 1970.001 AKA January 1st 1970)

X<break_code_blocks>

    srand 23;
    print to_string(rand), "\n";  # 0.199_281_135_414_825
    print to_string(rand), "\n";  # 0.955_482_658_089_267
    print to_string(rand), "\n";  # 0.080_619_594_120_559
    srand 23;
    print to_string(rand), "\n";  # 0.199_281_135_414_825 REPEATED
    print to_string(rand), "\n";  # 0.955_482_658_089_267 REPEATED
    print to_string(rand), "\n";  # 0.080_619_594_120_559 REPEATED

=back

=head2 Section 2.2: Strings (Text Data & Operators)

RPerl provides 2 text data types:

=over

=item * C<character>

S< >S< >S< >S< >a single text character; either a letter, number, or special character

=item * C<string>

S< >S< >S< >S< >one or more text characters; any combination of letters, numbers, and special characters

=back

RPerl provides 3 delimiters for enclosing text data:

=over

=item * Single Quotes

C<'I am a single-quoted string literal'>

=back

=over

=item * Double Quotes

C<"I am a double-quoted string literal">

=back

=over

=item * q Quotes

C<q{I am a q-quoted string literal}>

=back

Perl 5 provides several built-in operators designed for use with text data, which can be organized into 7 general categories:

=over

=item * Editing

=item * Case

=item * Comparison (Relational & Equality)

=item * Search

=item * Formatting

=item * Base

=item * Miscellaneous

=back

=head3 Section 2.2.1: Character Literals

The most memory-efficient text literal is C<character>, which represents exactly zero characters or one character of information.  A C<character> may express the value of any single numeric digit (0, 1, 2, ..., 8, 9); letter (a, b, c, ..., y, z, A, B, C, ..., Y, Z ); or special ASCII character (!, #, *, +, etc).  If the C<character> literal has length zero, meaning it represents zero characters of information, then it is called the I<"empty character"> and contains no data.

    ''           # INVALID: use q{} for empty character
    '0'          #   VALID
    'h'          #   VALID
    '+'          #   VALID
    '\n'         # INVALID: too many characters, use "\n" for newline character
    '-1'         # INVALID: too many characters
    'howdy23!'   # INVALID: too many characters

    ""           # INVALID: use q{} for empty character
    "0"          #   VALID
    "h"          #   VALID
    "+"          #   VALID
    "\n"         #   VALID: newline
    "-1"         # INVALID: too many characters & invalid use of double quotes
    "howdy23!"   # INVALID: too many characters & invalid use of double quotes

    q{}          #   VALID: empty
    q{0}         #   VALID
    q{h}         #   VALID
    q{+}         #   VALID
    q{\n}        # INVALID: too many characters, use "\n" for newline character
    q{-1}        # INVALID: too many characters
    q{howdy23!}  # INVALID: too many characters

=head3 Section 2.2.2: String Literals

Any text data more than 1 character in length must be represented by a C<string> literal, which is comprised of any combination of valid C<character> literal characters (numeric digits, letters, and special ASCII characters).  Like the empty character, if a C<string> literal has length zero then it is called the I<"empty string"> and contains no data.

    ''           # INVALID: use q{} for empty string
    '0'          #   VALID
    'h'          #   VALID
    '+'          #   VALID
    '\n'         # INVALID: not a newline, use "\n" for string containing newline
    '\\n'        #   VALID: interpolated to become two characters (backslash, letter n)
    '-1'         #   VALID
    'howdy23!'   #   VALID

    ""           # INVALID: use q{} for empty string
    "0"          # INVALID: invalid use of double quotes, must contain newline or tab character(s)
    "h"          # INVALID: invalid use of double quotes, must contain newline or tab character(s)
    "+"          # INVALID: invalid use of double quotes, must contain newline or tab character(s)
    "\n"         #   VALID: interpolated to become newline character
    "-1"         # INVALID: invalid use of double quotes, must contain newline or tab character(s)
    "howdy23!"   # INVALID: invalid use of double quotes, must contain newline or tab character(s)

    q{}          #   VALID: empty string
    q{0}         #   VALID
    q{h}         #   VALID
    q{+}         #   VALID
    q{\n}        # INVALID: not a newline, use "\n" for string containing newline
    q{\\n}       #   VALID: interpolated to become two characters (backslash, letter n)
    q{-1}        #   VALID
    q{howdy23!}  #   VALID

=head3 Section 2.2.3: Single Quotes

Text literals enclosed in single quotes are the simplest and most common case in RPerl.

Single-quoted text literals are not I<"interpolated">, which means the literal's data contents are not changed by Perl or RPerl in any way, except for the extra-special double backslash C<\\> as described below.  Because single quotes do not activate string interpolation, you can not use a single-quoted string literal to represent special characters such as newline or tab.

Do not use single quotes to represent a newline or tab character, use double quotes C<"\n"> or C<"\t"> instead.

Do not use single quotes to represent an empty character or empty string, use q quotes C<q{}> instead.

In normal Perl, single backslash characters C<\> are used to create special characters called I<"escape sequences">, the most common of which are the well-known newline C<\n> and tab C<\t> escape sequences.  Each valid escape sequence actually counts as only one character of computer data, even though it is represented to humans by 2 or more typed characters, so a single escape sequence may be utilized as either a C<character> text literal or a C<string> text literal.  (Thus, C<"\n"> and C<"\t"> may both be utilized as either a C<character> or C<string> in RPerl, but only when using double quotes as discussed in the following section.)

In single-quoted string literals, the only escape sequence supported by RPerl is the double backslash C<\\>, so the string literal C<'\\'> is interpolated to mean only one single backslash character C<\>.  To represent two backslash characters C<\\>, utilize two double backslash escape sequences in a row C<'\\\\'>; for three backslashes C<\\\> utilize three escape sequences C<'\\\\\\'>, and so forth.

Because RPerl only accepts double backslashes (not single backslashes) within single quotes, RPerl thus does not accept any odd number of consecutive backslash characters within single quotes.  For example, two or four backslashes in a row are supported, but one or three or five directly adjacent backslashes are not supported.

In normal Perl, the backslash single quote C<\'> escape sequence may be used to include a single quote character C<'> within a single-quoted text literal.  As stated above, RPerl only supports the double backslash C<\\> escape sequence within single quotes, so the backslash single quote C<\'> escape sequence is thus not supported.  Use double quotes C<"'"> or q quotes C<q{'}> to represent a single quote C<'> character in an RPerl string literal.

Single-quoted text literals must B<not> contain:

=over

=item * Single Quote Character: C<'>

=item * Single Backslash Character: C<\>

=item * Odd Number Of Consecutive Backslash Characters: C<\\\> C<\\\\\> C<\\\\\\\>

=item * No Characters AKA Empty String

=back

Single-quoted text literals may contain:

=over

=item * Double Quote Character: C<">

=item * Right Curly Brace Character: C<}>

=item * Double Backslash Characters: C<\\>

=item * Even Number Of Consecutive Backslash Characters: C<\\\\> C<\\\\\\> C<\\\\\\\\>

=item * Any Other Characters

=back

    ''      # INVALID: empty string
    ' '     #   VALID: single space
    'a'     #   VALID: single letter
    '\'     # INVALID: single backslash

    '   '   #   VALID: three spaces
    ' ' '   # INVALID: single quote within single quotes
    '\' '   # INVALID: backslash single quote escape sequence, also single backslash

    ' a '   #   VALID: space, letter, space
    '"a}'   #   VALID: double quote, letter, right brace
    '\a}'   # INVALID: single backslash       not interpolated as audible bell (alarm beep) escape sequence
    '\n}'   # INVALID: single backslash       not interpolated as newline                   escape sequence
    '\\}'   #   VALID: double backslash           interpolated as one backslash character, right brace
    '\\\'   # INVALID: odd  number of backslashes 
    '\\\\'  #   VALID: even number of backslashes interpolated as half as many backslash characters

=for html <u>

I<BEST PRACTICES>

=over

=item * I<Use single-quoted text literals whenever possible.>

=back

=for html </u>

    'n'      #     BEST PRACTICE
    "n"      # NOT BEST PRACTICE: double quotes not needed
    q{n}     # NOT BEST PRACTICE:      q quotes not needed

    '1atx'   #     BEST PRACTICE
    "1atx"   # NOT BEST PRACTICE: double quotes not needed
    q{1atx}  # NOT BEST PRACTICE:      q quotes not needed

    '\\tx'   #     BEST PRACTICE
    "\\tx"   # NOT BEST PRACTICE: double quotes    invalid, extra backslash
    q{\\tx}  # NOT BEST PRACTICE:      q quotes not needed

=head3 Section 2.2.4: Double Quotes

Text literals enclosed in double quotes are fully interpolated in normal Perl, and are only used for trivial interpolation of strings containing the newline C<"\n"> or tab C<"\t"> escape sequences in RPerl.  All double-quoted strings in RPerl must contain at least one newline or tab special character.

In addition to escape sequences, string interpolation in normal Perl is also triggered by finding either the dollar sign C<$> or I<"at sign"> C<@> characters inside of a double-quoted string literal.  Because RPerl does not support string interpolation, double-quoted string literals must not contain the C<$> or C<@> characters.

Double-quoted string literals must not contain any backslash characters, other than those used in newline C<\n> and tab C<\t> escape sequences, and thus can not represent a single backslash character C<\>; use single quotes C<'\\'> or q quotes C<q{\\}> double backslash escape sequences instead. 

As with single quotes, in normal Perl the backslash double quote C<\"> escape sequence may be used to include a double quote character C<"> within a double-quoted text literal.  As stated above, RPerl only supports the newline C<\n> and tab C<\t> escape sequences within double quotes, so the backslash double quote C<\"> escape sequence is thus not supported.  Use single quotes C<'"'> or q quotes C<q{"}> to represent a double quote C<"> character in an RPerl string literal.

Double-quoted text literals must B<not> contain:

=over

=item * Double Quote Character: C<">

=item * Dollar Sign Character: C<$>

=item * At Sign Character: C<@>

=item * Extra Backslash Characters (Other Than C<\n> Or C<\t>): C<\> C<\\> C<\\\> C<\r> C<123\456>

=item * No Characters AKA Empty String

=back

Double-quoted text literals B<must> contain 1 or more:

=over

=item * Newline Character: C<\n>

=item * Tab Character: C<\t>

=back

Double-quoted text literals may contain:

=over

=item * Single Quote Character: C<'>

=item * Right Curly Brace Character: C<}>

=item * Any Other Characters

=back

    ""      # INVALID: empty string
    " "     #   VALID: single space
    "a"     #   VALID: single letter
    "\"     # INVALID: extra  backslash,                                                                     only \n and \t supported

    "   "   #   VALID: three spaces
    " " "   # INVALID: double quote within double quotes
    "\" "   # INVALID: backslash double quote escape sequence, also single backslash

    " a "   #   VALID: space, letter, space
    "'a}"   #   VALID: single quote, letter, right brace
    "\a}"   # INVALID: single backslash           interpolated as audible bell (alarm beep) escape sequence, only \n and \t supported
    "\n}"   #   VALID: single backslash           interpolated as newline                   escape sequence, right brace
    "\\}"   # INVALID: extra  backslashes,                                                                   only \n and \t supported
    "\\\"   # INVALID: extra  backslashes,                                                                   only \n and \t supported 
    "\\\\"  # INVALID: extra  backslashes,                                                                   only \n and \t supported

=for html <u>

I<BEST PRACTICES>

=over

=item * I<Use double-quoted text literals to contain newline C<\n> and tab C<\t> characters only, not other normal characters.>

=item * I<To represent a mixture of normal characters with newline and/or tab characters, enclose the normal characters in single quotes, enclose the newline and tab characters in double quotes, and use the dot C<.> "string concatenation" operator to append one string literal to the other.  (Please see L</Section 2.2.6: Editing Operators> for more info about string concatenation.)>

=back

=for html </u>

    "\n"        #     BEST PRACTICE:     newline         only
    "\t"        #     BEST PRACTICE:                 tab only
    "\t\n\t"    #     BEST PRACTICE:     newline and tab only

    "a\n"       # NOT BEST PRACTICE: not newline and tab only
    'a' . "\n"  #     BEST PRACTICE:     newline         only, additional characters in single quotes

    "\tx"       # NOT BEST PRACTICE: not newline and tab only
    "\t" . 'x'  #     BEST PRACTICE:                 tab only, additional characters in single quotes

    "a\tx\n"                 # NOT BEST PRACTICE: not newline and tab only
    'a' . "\t" . 'x' . "\n"  #     BEST PRACTICE:     newline and tab only, additional characters in single quotes

=head3 Section 2.2.5: q Quotes

Text literals enclosed in I<"q quotes"> begin with lowercase letter q and left curly brace characters C<q{>, and end with the right curly brace C<}> character.  You must use q quotes to represent empty text C<q{}> literals, which contain no characters.

Normal Perl supports q-quoted string literals using delimiters other than curly braces, as well as I<"qq quotes"> which provide string interpolation in the same way as double-quoted strings.  RPerl's existing string quoting mechanisms cover all non-interpolated use cases, so RPerl does not support the additional qq quotes or non-curly-brace q quotes, because TDNNTBMTOWTDI.

q-quoted literals behave exactly the same as single-quoted literals, other than the empty string C<q{}> and the difference in delimiters.

q-quoted text literals must B<not> contain:

=over

=item * Right Curly Brace Character: C<}>

=item * Single Backslash Character: C<\>

=item * Odd Number Of Consecutive Backslash Characters: C<\\\> C<\\\\\> C<\\\\\\\>

=back

q-quoted text literals may contain:

=over

=item * Single Quote Character: C<'>

=item * Double Quote Character: C<">

=item * Double Backslash Characters: C<\\>

=item * Even Number Of Consecutive Backslash Characters: C<\\\\> C<\\\\\\> C<\\\\\\\\>

=item * No Characters AKA Empty String

=item * Any Other Characters

=back

    q{}      #   VALID: empty string
    q{ }     #   VALID: single space
    q{a}     #   VALID: single letter
    q{\}     # INVALID: single backslash

    q{   }   #   VALID: three spaces
    q{ } }   # INVALID: right brace within q quotes
    q{\} }   # INVALID: backslash right brace escape sequence, also single backslash

    q{ a }   #   VALID: space, letter, space
    q{"a'}   #   VALID: double quote, letter, single quote
    q{\a'}   # INVALID: single backslash       not interpolated as audible bell (alarm beep) escape sequence
    q{\n'}   # INVALID: single backslash       not interpolated as newline                   escape sequence
    q{\\'}   #   VALID: double backslash           interpolated as one backslash character, single quote
    q{\\\}   # INVALID: odd  number of backslashes 
    q{\\\\}  #   VALID: even number of backslashes interpolated as half as many backslash characters

=for html <u>

I<BEST PRACTICES>

=over

=item * I<Use q-quoted text literals to represent empty text literals only.>

=back

=for html </u>

    ''      # NOT BEST PRACTICE: single quotes invalid, empty string
    ""      # NOT BEST PRACTICE: double quotes invalid, empty string
    q{}     #     BEST PRACTICE

    '0gnb'   #     BEST PRACTICE
    "0gnb"   # NOT BEST PRACTICE: double quotes not needed
    q{0gnb}  # NOT BEST PRACTICE:      q quotes not needed

    '\\nx'   #     BEST PRACTICE
    "\\nx"   # NOT BEST PRACTICE: double quotes    invalid, extra backslash
    q{\\nx}  # NOT BEST PRACTICE:      q quotes not needed

=head3 Section 2.2.6: Editing Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.6-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Editing Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Substring

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

substr

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Variadic

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Repeat

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

x

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

07

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Concatenate

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

.

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

08

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Length

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

length

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Substring>

    substr EXPR, OFFSET
    substr EXPR, OFFSET, LENGTH
    substr EXPR, OFFSET, LENGTH, REPLACEMENT

EXPR and REPLACEMENT are string values, OFFSET and LENGTH are integer values;

When called with 2 operands, return substring of first operand EXPR, beginning at second operand OFFSET character and ending at end of first operand;

When called with 3 operands, return substring of first operand EXPR, beginning at second operand OFFSET character and ending after third operand LENGTH characters;

When called with 4 operands, return substring of first operand EXPR, beginning at second operand OFFSET character and ending after third operand LENGTH characters, and also edit first operand by replacing original substring with fourth operand REPLACEMENT string;

In all variants, OFFSET begins at 0;

In all variants, if second operand OFFSET is negative then substring begins absolute value of LENGTH characters before end of first operand EXPR;

In 3-operand and 4-operand variants, if third operand LENGTH is negative then substring ends absolute value of LENGTH characters before end of first operand EXPR;

In 4-operand variant, return value is original substring before replacement occurs, thus you can retrieve a substring and replace it with one operation;

In 4-operand variant, length of substring in third operand LENGTH need not equal length of string in fourth operand REPLACEMENT, length of first operand EXPR will be automatically increased or decreased as needed

    # common usage
    my string $foo = 'abc123!?*';               # $foo = 'abc123!?*'
    my string $bar = substr $foo, 2;            #                     $bar =   'c123!?*'
    my string $bat = substr $foo, 2, 3;         #                     $bat =   'c12'
    my string $bax = substr $foo, 2, 3, 'd45';  # $foo = 'abd453!?*', $bax =   'c12'

X<break_code_blocks>


    # negative OFFSET
    my string $foo = 'abc123!?*';                # $foo = 'abc123!?*'
    my string $bar = substr $foo, -4;            #                     $bar =   '3!?*'
    my string $bat = substr $foo, -4, 3;         #                     $bat =   '3!?'
    my string $bax = substr $foo, -4, 3, 'd45';  # $foo = 'abc12d45*', $bax =   '3!?'

X<break_code_blocks>


    # negative LENGTH
    my string $foo = 'abc123!?*';                 # $foo = 'abc123!?*'
    my string $bar = substr $foo, 2;              #                     $bar =   'c123!?*'
    my string $bat = substr $foo, 2, -3;          #                     $bat =   'c123'
    my string $bax = substr $foo, 2, -3, 'd456';  # $foo = 'abd456!?*', $bax =   'c123'

X<break_code_blocks>


    # negative OFFSET and LENGTH
    my string $foo = 'abc123!?*';                  # $foo = 'abc123!?*'
    my string $bar = substr $foo, -6;              #                     $bar =   '123!?*'
    my string $bat = substr $foo, -6, -2;          #                     $bat =   '123!'
    my string $bax = substr $foo, -6, -2, 'd456';  # $foo = 'abcd456?*', $bax =   '123!'

X<break_code_blocks>


    # LENGTH less than REPLACEMENT length
    my string $foo = 'abc123!?*';                   # $foo = 'abc123!?*'
    my string $bar = substr $foo, 2;                #                         $bar =   'c123!?*'
    my string $bat = substr $foo, 2, 3;             #                         $bat =   'c12'
    my string $bax = substr $foo, 2, 3, 'd456789';  # $foo = 'abd4567893!?*', $bax =   'c12'

X<break_code_blocks>


    # LENGTH greater than REPLACEMENT length, and empty replacement string
    my string $foo = 'abc123!?*';             # $foo = 'abc123!?*'
    my string $bar = substr $foo, 2;          #                     $bar =   'c123!?*'
    my string $bat = substr $foo, 2, 3;       #                     $bat =   'c12'
    my string $bax = substr $foo, 2, 3, q{};  # $foo = 'ab3!?*',    $bax =   'c12'

=back

=over

=item * B<Repeat>

    EXPR x COUNT

EXPR is string value, COUNT is unsigned_integer (non-negative whole number) value;

Return a new string value comprised of string EXPR repeated COUNT times;

Analogous to arithmetic multiply operator C<*>;

Consecutive repeat C<x> operators may be chained for multiplicative effect

    'a' x 0      # '' (empty string)
    'a' x 1      # 'a'
    'a' x 2      # 'aa'
    'a' x 3      # 'aaa'
    'a' x 3 x 2  # 'aaaaaa'

    'howdy' x 3  # 'howdyhowdyhowdy'

=back

=over

=item * B<Concatenate>

    EXPR1 . EXPR2

EXPR1 and EXPR2 are string values;

Return a new string value comprised of string EXPR1 followed by EXPR2;

Analogous to arithmetic add operator C<+>;

Consecutive concatenate C<.> operators may be chained for additive (cumulative) effect

    '' . ''          # '' (empty string)
    'a' . ''         # 'a'
    '' . 'a'         # 'a'
    'a' . 'a'        # 'aa'
    'a' . 'a' . 'a'  # 'aaa'

    'howdy' . 'howdy' . 'howdy'  # 'howdyhowdyhowdy'

=back

=over

=item * B<Length>

    length EXPR

EXPR is string value;

Return number of characters in string EXPR

    length ''     # 0
    length 'a'    # 1
    length 'aa'   # 2
    length 'aaa'  # 3

    length 'howdy'            # 5
    length 'howdyhowdyhowdy'  # 15

=back

=head3 Section 2.2.7: Case Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.7-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Case Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Lowercase

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

lc

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Lowercase First Character

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

lcfirst

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Uppercase

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

uc

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Uppercase First Character

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

ucfirst

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Lowercase>

    lc EXPR

EXPR is string value;

Return new string comprised of all characters in string EXPR converted to lowercase format

    lc ''     #  '' (empty string)
    lc 'a'    #  'a'
    lc 'A'    #  'a'
    lc 'aA'   #  'aa'
    lc 'AA'   #  'aa'
    lc 'AAA'  #  'aaa'

    lc 'howdyHowdyHOWDY'  # 'howdyhowdyhowdy'

=back

=over

=item * B<Lowercase First Character>

    lcfirst EXPR

EXPR is string value;

Return new string comprised of first character in string EXPR converted to lowercase format and remaining characters in EXPR unmodified

    lcfirst ''     #  '' (empty string)
    lcfirst 'a'    #  'a'
    lcfirst 'A'    #  'a'
    lcfirst 'aA'   #  'aa'
    lcfirst 'AA'   #  'aA'
    lcfirst 'AAA'  #  'aAA'

    lcfirst 'HOWDYHOWDYHOWDY'  # 'hOWDYHOWDYHOWDY'

=back

=over

=item * B<Uppercase>

    uc EXPR

EXPR is string value;

Return new string comprised of all characters in string EXPR converted to uppercase format

    uc ''     #  '' (empty string)
    uc 'A'    #  'A'
    uc 'a'    #  'A'
    uc 'Aa'   #  'AA'
    uc 'aa'   #  'AA'
    uc 'aaa'  #  'AAA'

    uc 'HOWDYhOWDYhowdy'  # 'HOWDYHOWDYHOWDY'

=back

=over

=item * B<Uppercase First Character>

    ucfirst EXPR

EXPR is string value;

Return new string comprised of first character in string EXPR converted to uppercase format and remaining characters in EXPR unmodified

    ucfirst ''     #  '' (empty string)
    ucfirst 'A'    #  'A'
    ucfirst 'a'    #  'A'
    ucfirst 'Aa'   #  'Aa'
    ucfirst 'aa'   #  'Aa'
    ucfirst 'aaa'  #  'Aaa'

    ucfirst 'howdyhowdyhowdy'  # 'Howdyhowdyhowdy'

=back

=head3 Section 2.2.8: Comparison (Relational & Equality) Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.8-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Comparison (Relational & Equality) Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Less-Than

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

lt

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Greater-Than

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

gt

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Less-Than-Or-Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

le

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Greater-Than-Or-Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

ge

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

11

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

eq

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Not Equal

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

ne

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Three-Way Comparison

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

cmp

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Infix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

12

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Less-Than>

    EXPR1 lt EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine relation of operands, return true if EXPR1 is stringwise less than EXPR2, otherwise return false

       '' lt    ''  #   (false)
       '' lt   'a'  # 1 (true)
       '' lt   'b'  # 1 (true)
       '' lt   'A'  # 1 (true)
       '' lt   'B'  # 1 (true)
      'a' lt    ''  #   (false)
      'a' lt   'a'  #   (false)
      'a' lt   'b'  # 1 (true)
      'a' lt   'A'  #   (false)
      'a' lt   'B'  #   (false)
     'aa' lt    ''  #   (false)
     'aa' lt   'a'  #   (false)
     'aa' lt   'b'  # 1 (true)
     'aa' lt   'A'  #   (false)
     'aa' lt   'B'  #   (false)
      'b' lt    ''  #   (false)
      'b' lt   'a'  #   (false)
      'b' lt   'b'  #   (false)
      'b' lt   'A'  #   (false)
      'b' lt   'B'  #   (false)
     'bb' lt    ''  #   (false)
     'bb' lt   'a'  #   (false)
     'bb' lt   'b'  #   (false)
     'bb' lt   'A'  #   (false)
     'bb' lt   'B'  #   (false)
      'A' lt    ''  #   (false)
      'A' lt   'a'  # 1 (true)
      'A' lt   'b'  # 1 (true)
      'A' lt   'A'  #   (false)
      'A' lt   'B'  # 1 (true)
     'AA' lt    ''  #   (false)
     'AA' lt   'a'  # 1 (true)
     'AA' lt   'b'  # 1 (true)
     'AA' lt   'A'  #   (false)
     'AA' lt   'B'  # 1 (true)
      'B' lt    ''  #   (false)
      'B' lt   'a'  # 1 (true)
      'B' lt   'b'  # 1 (true)
      'B' lt   'A'  #   (false)
      'B' lt   'B'  #   (false)
     'BB' lt    ''  #   (false)
     'BB' lt   'a'  # 1 (true)
     'BB' lt   'b'  # 1 (true)
     'BB' lt   'A'  #   (false)
     'BB' lt   'B'  #   (false)

=back

=over

=item * B<Greater-Than>

    EXPR1 gt EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine relation of operands, return true if EXPR1 is stringwise greater than EXPR2, otherwise return false

       '' gt    ''  #   (false)
       '' gt   'a'  #   (false)
       '' gt   'b'  #   (false)
       '' gt   'A'  #   (false)
       '' gt   'B'  #   (false)
      'a' gt    ''  # 1 (true)
      'a' gt   'a'  #   (false)
      'a' gt   'b'  #   (false)
      'a' gt   'A'  # 1 (true)
      'a' gt   'B'  # 1 (true)
     'aa' gt    ''  # 1 (true)
     'aa' gt   'a'  # 1 (true)
     'aa' gt   'b'  #   (false)
     'aa' gt   'A'  # 1 (true)
     'aa' gt   'B'  # 1 (true)
      'b' gt    ''  # 1 (true)
      'b' gt   'a'  # 1 (true)
      'b' gt   'b'  #   (false)
      'b' gt   'A'  # 1 (true)
      'b' gt   'B'  # 1 (true)
     'bb' gt    ''  # 1 (true)
     'bb' gt   'a'  # 1 (true)
     'bb' gt   'b'  # 1 (true)
     'bb' gt   'A'  # 1 (true)
     'bb' gt   'B'  # 1 (true)
      'A' gt    ''  # 1 (true)
      'A' gt   'a'  #   (false)
      'A' gt   'b'  #   (false)
      'A' gt   'A'  #   (false)
      'A' gt   'B'  #   (false)
     'AA' gt    ''  # 1 (true)
     'AA' gt   'a'  #   (false)
     'AA' gt   'b'  #   (false)
     'AA' gt   'A'  # 1 (true)
     'AA' gt   'B'  #   (false)
      'B' gt    ''  # 1 (true)
      'B' gt   'a'  #   (false)
      'B' gt   'b'  #   (false)
      'B' gt   'A'  # 1 (true)
      'B' gt   'B'  #   (false)
     'BB' gt    ''  # 1 (true)
     'BB' gt   'a'  #   (false)
     'BB' gt   'b'  #   (false)
     'BB' gt   'A'  # 1 (true)
     'BB' gt   'B'  # 1 (true)

=back

=over

=item * B<Less-Than-Or-Equal>

    EXPR1 le EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine relation of operands, return true if EXPR1 is stringwise less than or equal to EXPR2, otherwise return false

       '' le    ''  # 1 (true)
       '' le   'a'  # 1 (true)
       '' le   'b'  # 1 (true)
       '' le   'A'  # 1 (true)
       '' le   'B'  # 1 (true)
      'a' le    ''  #   (false)
      'a' le   'a'  # 1 (true)
      'a' le   'b'  # 1 (true)
      'a' le   'A'  #   (false)
      'a' le   'B'  #   (false)
     'aa' le    ''  #   (false)
     'aa' le   'a'  #   (false)
     'aa' le   'b'  # 1 (true)
     'aa' le   'A'  #   (false)
     'aa' le   'B'  #   (false)
      'b' le    ''  #   (false)
      'b' le   'a'  #   (false)
      'b' le   'b'  # 1 (true)
      'b' le   'A'  #   (false)
      'b' le   'B'  #   (false)
     'bb' le    ''  #   (false)
     'bb' le   'a'  #   (false)
     'bb' le   'b'  #   (false)
     'bb' le   'A'  #   (false)
     'bb' le   'B'  #   (false)
      'A' le    ''  #   (false)
      'A' le   'a'  # 1 (true)
      'A' le   'b'  # 1 (true)
      'A' le   'A'  # 1 (true)
      'A' le   'B'  # 1 (true)
     'AA' le    ''  #   (false)
     'AA' le   'a'  # 1 (true)
     'AA' le   'b'  # 1 (true)
     'AA' le   'A'  #   (false)
     'AA' le   'B'  # 1 (true)
      'B' le    ''  #   (false)
      'B' le   'a'  # 1 (true)
      'B' le   'b'  # 1 (true)
      'B' le   'A'  #   (false)
      'B' le   'B'  # 1 (true)
     'BB' le    ''  #   (false)
     'BB' le   'a'  # 1 (true)
     'BB' le   'b'  # 1 (true)
     'BB' le   'A'  #   (false)
     'BB' le   'B'  #   (false)

=back

=over

=item * B<Greater-Than-Or-Equal>

    EXPR1 ge EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine relation of operands, return true if EXPR1 is stringwise greater than or equal to EXPR2, otherwise return false

       '' ge    ''  # 1 (true)
       '' ge   'a'  #   (false)
       '' ge   'b'  #   (false)
       '' ge   'A'  #   (false)
       '' ge   'B'  #   (false)
      'a' ge    ''  # 1 (true)
      'a' ge   'a'  # 1 (true)
      'a' ge   'b'  #   (false)
      'a' ge   'A'  # 1 (true)
      'a' ge   'B'  # 1 (true)
     'aa' ge    ''  # 1 (true)
     'aa' ge   'a'  # 1 (true)
     'aa' ge   'b'  #   (false)
     'aa' ge   'A'  # 1 (true)
     'aa' ge   'B'  # 1 (true)
      'b' ge    ''  # 1 (true)
      'b' ge   'a'  # 1 (true)
      'b' ge   'b'  # 1 (true)
      'b' ge   'A'  # 1 (true)
      'b' ge   'B'  # 1 (true)
     'bb' ge    ''  # 1 (true)
     'bb' ge   'a'  # 1 (true)
     'bb' ge   'b'  # 1 (true)
     'bb' ge   'A'  # 1 (true)
     'bb' ge   'B'  # 1 (true)
      'A' ge    ''  # 1 (true)
      'A' ge   'a'  #   (false)
      'A' ge   'b'  #   (false)
      'A' ge   'A'  # 1 (true)
      'A' ge   'B'  #   (false)
     'AA' ge    ''  # 1 (true)
     'AA' ge   'a'  #   (false)
     'AA' ge   'b'  #   (false)
     'AA' ge   'A'  # 1 (true)
     'AA' ge   'B'  #   (false)
      'B' ge    ''  # 1 (true)
      'B' ge   'a'  #   (false)
      'B' ge   'b'  #   (false)
      'B' ge   'A'  # 1 (true)
      'B' ge   'B'  # 1 (true)
     'BB' ge    ''  # 1 (true)
     'BB' ge   'a'  #   (false)
     'BB' ge   'b'  #   (false)
     'BB' ge   'A'  # 1 (true)
     'BB' ge   'B'  # 1 (true)

=back

=over

=item * B<Equal>

    EXPR1 eq EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine equality of operands, return true if EXPR1 is stringwise equal to EXPR2, otherwise return false

       '' eq    ''  # 1 (true)
       '' eq   'a'  #   (false)
       '' eq   'b'  #   (false)
       '' eq   'A'  #   (false)
       '' eq   'B'  #   (false)
      'a' eq    ''  #   (false)
      'a' eq   'a'  # 1 (true)
      'a' eq   'b'  #   (false)
      'a' eq   'A'  #   (false)
      'a' eq   'B'  #   (false)
     'aa' eq    ''  #   (false)
     'aa' eq   'a'  #   (false)
     'aa' eq   'b'  #   (false)
     'aa' eq   'A'  #   (false)
     'aa' eq   'B'  #   (false)
      'b' eq    ''  #   (false)
      'b' eq   'a'  #   (false)
      'b' eq   'b'  # 1 (true)
      'b' eq   'A'  #   (false)
      'b' eq   'B'  #   (false)
     'bb' eq    ''  #   (false)
     'bb' eq   'a'  #   (false)
     'bb' eq   'b'  #   (false)
     'bb' eq   'A'  #   (false)
     'bb' eq   'B'  #   (false)
      'A' eq    ''  #   (false)
      'A' eq   'a'  #   (false)
      'A' eq   'b'  #   (false)
      'A' eq   'A'  # 1 (true)
      'A' eq   'B'  #   (false)
     'AA' eq    ''  #   (false)
     'AA' eq   'a'  #   (false)
     'AA' eq   'b'  #   (false)
     'AA' eq   'A'  #   (false)
     'AA' eq   'B'  #   (false)
      'B' eq    ''  #   (false)
      'B' eq   'a'  #   (false)
      'B' eq   'b'  #   (false)
      'B' eq   'A'  #   (false)
      'B' eq   'B'  # 1 (true)
     'BB' eq    ''  #   (false)
     'BB' eq   'a'  #   (false)
     'BB' eq   'b'  #   (false)
     'BB' eq   'A'  #   (false)
     'BB' eq   'B'  #   (false)

=back

=over

=item * B<Not-Equal>

    EXPR1 ne EXPR2

EXPR1 and EXPR2 are string values;

Compare to determine equality of operands, return true if EXPR1 is stringwise not equal to EXPR2, otherwise return false

       '' ne    ''  #   (false)
       '' ne   'a'  # 1 (true)
       '' ne   'b'  # 1 (true)
       '' ne   'A'  # 1 (true)
       '' ne   'B'  # 1 (true)
      'a' ne    ''  # 1 (true)
      'a' ne   'a'  #   (false)
      'a' ne   'b'  # 1 (true)
      'a' ne   'A'  # 1 (true)
      'a' ne   'B'  # 1 (true)
     'aa' ne    ''  # 1 (true)
     'aa' ne   'a'  # 1 (true)
     'aa' ne   'b'  # 1 (true)
     'aa' ne   'A'  # 1 (true)
     'aa' ne   'B'  # 1 (true)
      'b' ne    ''  # 1 (true)
      'b' ne   'a'  # 1 (true)
      'b' ne   'b'  #   (false)
      'b' ne   'A'  # 1 (true)
      'b' ne   'B'  # 1 (true)
     'bb' ne    ''  # 1 (true)
     'bb' ne   'a'  # 1 (true)
     'bb' ne   'b'  # 1 (true)
     'bb' ne   'A'  # 1 (true)
     'bb' ne   'B'  # 1 (true)
      'A' ne    ''  # 1 (true)
      'A' ne   'a'  # 1 (true)
      'A' ne   'b'  # 1 (true)
      'A' ne   'A'  #   (false)
      'A' ne   'B'  # 1 (true)
     'AA' ne    ''  # 1 (true)
     'AA' ne   'a'  # 1 (true)
     'AA' ne   'b'  # 1 (true)
     'AA' ne   'A'  # 1 (true)
     'AA' ne   'B'  # 1 (true)
      'B' ne    ''  # 1 (true)
      'B' ne   'a'  # 1 (true)
      'B' ne   'b'  # 1 (true)
      'B' ne   'A'  # 1 (true)
      'B' ne   'B'  #   (false)
     'BB' ne    ''  # 1 (true)
     'BB' ne   'a'  # 1 (true)
     'BB' ne   'b'  # 1 (true)
     'BB' ne   'A'  # 1 (true)
     'BB' ne   'B'  # 1 (true)

=back

=over

=item * B<Three-Way Comparison>

    EXPR1 cmp EXPR2

EXPR1 and EXPR2 are string values;

Perform three-way comparison of operands;

Return -1 if EXPR1 is stringwise less than EXPR2, return 0 if operands are equal, or return 1 if EXPR1 is greater than EXPR2

       '' cmp    ''  #  0 (equal)
       '' cmp   'a'  # -1 (less    than)
       '' cmp   'b'  # -1 (less    than)
       '' cmp   'A'  # -1 (less    than)
       '' cmp   'B'  # -1 (less    than)
      'a' cmp    ''  #  1 (greater than)
      'a' cmp   'a'  #  0 (equal)
      'a' cmp   'b'  # -1 (less    than)
      'a' cmp   'A'  #  1 (greater than)
      'a' cmp   'B'  #  1 (greater than)
     'aa' cmp    ''  #  1 (greater than)
     'aa' cmp   'a'  #  1 (greater than)
     'aa' cmp   'b'  # -1 (less    than)
     'aa' cmp   'A'  #  1 (greater than)
     'aa' cmp   'B'  #  1 (greater than)
      'b' cmp    ''  #  1 (greater than)
      'b' cmp   'a'  #  1 (greater than)
      'b' cmp   'b'  #  0 (equal)
      'b' cmp   'A'  #  1 (greater than)
      'b' cmp   'B'  #  1 (greater than)
     'bb' cmp    ''  #  1 (greater than)
     'bb' cmp   'a'  #  1 (greater than)
     'bb' cmp   'b'  #  1 (greater than)
     'bb' cmp   'A'  #  1 (greater than)
     'bb' cmp   'B'  #  1 (greater than)
      'A' cmp    ''  #  1 (greater than)
      'A' cmp   'a'  # -1 (less    than)
      'A' cmp   'b'  # -1 (less    than)
      'A' cmp   'A'  #  0 (equal)
      'A' cmp   'B'  # -1 (less    than)
     'AA' cmp    ''  #  1 (greater than)
     'AA' cmp   'a'  # -1 (less    than)
     'AA' cmp   'b'  # -1 (less    than)
     'AA' cmp   'A'  #  1 (greater than)
     'AA' cmp   'B'  # -1 (less    than)
      'B' cmp    ''  #  1 (greater than)
      'B' cmp   'a'  # -1 (less    than)
      'B' cmp   'b'  # -1 (less    than)
      'B' cmp   'A'  #  1 (greater than)
      'B' cmp   'B'  #  0 (equal)
     'BB' cmp    ''  #  1 (greater than)
     'BB' cmp   'a'  # -1 (less    than)
     'BB' cmp   'b'  # -1 (less    than)
     'BB' cmp   'A'  #  1 (greater than)
     'BB' cmp   'B'  #  1 (greater than)

=back

=head3 Section 2.2.9: Search Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.9-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Search Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Index

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

index

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Variadic

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Reverse Index

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

rindex

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Variadic

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Index>

    index STR, SUBSTR
    index STR, SUBSTR, OFFSET

STR and SUBSTR are string values; OFFSET is unsigned_integer (non-negative whole number) value;

When called with 2 operands, search within first operand STR for second operand SUBSTR, return character count location of first occurrence;

When called with 3 operands, search within first operand STR for second operand SUBSTR, beginning at third operand OFFSET, return character count location of first occurrence;

In 3-operand variant, if third operand OFFSET is negative then it will default to 0, or if OFFSET is beyond the end of STR then it will default to the end of STR;

If SUBSTR is not located within STR, return -1

    my string  $foo = 'abc123!?*abc';

    my integer $bar = index $foo, 'a';      # $bar =  0
               $bar = index $foo, 'c12';    # $bar =  2
               $bar = index $foo, '3';      # $bar =  5
               $bar = index $foo, '*';      # $bar =  8
               $bar = index $foo, 'd';      # $bar = -1

    my integer $bat = index $foo, 'a',  0;  # $bat =  0
               $bat = index $foo, 'a',  1;  # $bat =  9
               $bat = index $foo, 'a', -1;  # $bat =  0
               $bat = index $foo, 'a', 20;  # $bat = -1

=back

=over

=item * B<Reverse Index>

    rindex STR, SUBSTR
    rindex STR, SUBSTR, OFFSET

STR and SUBSTR are string values; OFFSET is unsigned_integer (non-negative whole number) value;

When called with 2 operands, search within first operand STR for second operand SUBSTR, return character count location of last occurrence;

When called with 3 operands, search within first operand STR for second operand SUBSTR, beginning at third operand OFFSET, return character count location of last occurrence;

In 3-operand variant, if third operand OFFSET is negative then it will default to 0, or if OFFSET is beyond the end of STR then it will default to the end of STR;

If SUBSTR is not located within STR, return -1

    my string  $foo = 'abc123!?*abc';

    my integer $bar = rindex $foo, 'a';      # $bar =  9
               $bar = rindex $foo, 'c12';    # $bar =  2
               $bar = rindex $foo, '3';      # $bar =  5
               $bar = rindex $foo, '*';      # $bar =  8
               $bar = rindex $foo, 'd';      # $bar = -1

    my integer $bat = rindex $foo, 'a',  0;  # $bat =  9
               $bat = rindex $foo, 'a',  1;  # $bat =  9
               $bat = rindex $foo, 'a', -1;  # $bat =  9
               $bat = rindex $foo, 'a', 20;  # $bat = -1

=back

=head3 Section 2.2.10: Formatting Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.10-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Formatting Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

String Formatted Print

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

sprintf

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Variadic

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Quote Meta

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

quotemeta

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<String Formatted Print>

    sprintf FORMAT, LIST

FORMAT is string value, LIST is one or more mixed-type values separated by commas;

Return string value comprised of element(s) from second operand LIST stringified according to conversion convention(s) in first operand FORMAT

    my integer $foo = 23;
    my string  $bar = sprintf '%d', $foo;                                  # bar = '23'
               $bar = sprintf 'single: %d', $foo;                          # bar = 'single: 23'
               $bar = sprintf 'single: %d; double: %d', $foo, ($foo * 2);  # bar = 'single: 23; double: 46'

Accepted conversion conventions:

=over

=item * C<%%>  Percent Sign

=item * C<%c>  Character With The Given Number

=item * C<%s>  String

=item * C<%d>  Signed Integer, In Decimal

=item * C<%u>  Unsigned Integer, In Decimal

=item * C<%o>  Unsigned Integer, In Octal

=item * C<%x>  Unsigned Integer, In Hexadecimal

=item * C<%e>  Floating-Point Number, In Scientific Notation

=item * C<%f>  Floating-Point Number, In Fixed Decimal Notation

=item * C<%g>  Floating-Point Number, In %e Or %f Notation

=back

=back

=over

=item * B<Quote Meta>

    quotemeta EXPR

EXPR is string value;

Return new string value comprised of operand EXPR with all non-word characters (not letters or number) backslash-escaped

    quotemeta 'abc123'     # 'abc123'
    quotemeta 'abc123!?*'  # 'abc123\!\?\*'
    quotemeta '!?*'        # '\!\?\*'

=back

=head3 Section 2.2.11: Base Conversion Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.11-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Base Conversion Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Chr

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

chr

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Hex

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

hex

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Oct

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

oct

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Ord

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

ord

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

10

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Chr>

    chr EXPR

EXPR is unsigned_integer (non-negative whole number) value;

Return character with ASCII order of operand EXPR;

To reverse, see C<ord> operator

    chr 33  # '!'
    chr 65  # 'A'
    chr 97  # 'a'

=back

=over

=item * B<Hex>

    hex EXPR

EXPR is string value;

Return decimal (base 10) integer value of hexadecimal (base 16) string in operand EXPR 

    hex '0x00'  #   0
    hex '0x33'  #  51
    hex '0x66'  # 102
    hex '0x99'  # 153
    hex '0xAA'  # 170
    hex '0xCC'  # 204
    hex '0xFF'  # 255

=back

=over

=item * B<Oct>

    oct EXPR

EXPR is string value;

If operand EXPR starts with '0x', return decimal (base 10) integer value of hexadecimal (base 16) string in EXPR, same as C<hex> operator;

If operand EXPR starts with '0b', return decimal (base 10) integer value of binary (base 2) string in EXPR;

Otherwise, return decimal (base 10) integer value of octal (base 8) string in operand EXPR

    # hexadecimal to decimal
    oct '0x00'  #   0
    oct '0x33'  #  51
    oct '0x66'  # 102
    oct '0x99'  # 153
    oct '0xAA'  # 170
    oct '0xCC'  # 204
    oct '0xFF'  # 255

X<break_code_blocks>


    # binary to decimal
    oct '0b000'  # 0
    oct '0b001'  # 1
    oct '0b010'  # 2
    oct '0b100'  # 4
    oct '0b110'  # 6
    oct '0b111'  # 7

X<break_code_blocks>


    # octal to decimal
    oct '00'  #  0
    oct '22'  # 18
    oct '33'  # 27
    oct '66'  # 54
    oct '77'  # 63

=back

=over

=item * B<Ord>

    ord EXPR

EXPR is string or character value;

Return integer ASCII order of first character in operand EXPR;

To reverse, see C<chr> operator

    ord '!'  # 33
    chr 'A'  # 65
    chr 'a'  # 97

=back

=head3 Section 2.2.12: Miscellaneous Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.2.12-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Miscellaneous Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Crypt

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

crypt

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Binary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

01

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Left

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Coming Soon

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Crypt>

    crypt PLAINTEXT, SALT

PLAINTEXT and SALT are string values;

Perform one-way hash to create "encrypted" digest (short string) of first operand PLAINTEXT using second operand SALT as password, return digest;

There is no known way to create a C<decrypt> function to reverse text run through C<crypt>, thus the label "one-way";

This operator is commonly used to secure and check password validity, or compare contents of 2 strings without transmitting the actual string data

    crypt 'hidden dragon',       'crouching tiger'  # crnzcDddLMkLI
    crypt 'dihydrogen monoxide', 'sodium chloride'  # sol48Jyq9nz1.
    crypt 'irretrievable data',  'throw away key'   # thVMMPVOs6g1I

=back

=begin text

=head2 Section 2.3: RPerlE<39>s Phases, Built-In Warnings & Errors

=end text

=begin man

=head2 Section 2.3: RPerlE<39>s Phases, Built-In Warnings & Errors

=end man

=begin html

=for DEV NOTE: ppod2html does not support E<39> or E<apos>, replaced w/ E<acute>

=head2 Section 2.3: RPerlE<acute>s Phases, Built-In Warnings & Errors

=end html

We will now take a break from numbers and strings and operators, in order to investigate the various stages of installing and running RPerl, as well as the most common issues you may encounter.

Like normal Perl, RPerl tries to generate helpful messages when something does not go as planned.

A I<"warning"> occurs when something unexpected happens, but RPerl can continue on without being forced to end prematurely.

An I<"error"> occurs when something unexpected happens, and RPerl must end immediately.

We will collectively refer to both warnings and errors as I<"problems">, and we will refer to both warning messages and error messages as I<"problem messages">.

There are 15 RPerl I<"phases">, most of which are (hopefully unsurprisingly) termed as I<"compile phases">.  An RPerl phase is simply a distinct category of work to be done by RPerl or some other related software, and a compile phase is a category of work specifically related to compiling RPerl application source code. 

All warnings and errors in RPerl fall within exactly 1 phase; technically, only those phases shown in B<bold> contain problem messages generated by RPerl itself:

=over

=item * Install, Base Dependencies

=item * Install, CPAN Dependencies

=item * B<Install, Test Suite>

=item * B<Initialize, Bootstrap Subcompile>

=item * B<Initialize, Configuration>

=item * B<Compile, Arguments & Files>

=item * B<Compile, Dependencies>

=item * Compile, Parse Phase 0 (Check Perl Syntax)

=item * Compile, Parse Phase 1 (Criticize Perl Syntax)

=item * B<Compile, Parse Phase 2 (Parse RPerl Syntax)>

=item * B<Compile, Generate (C++ Syntax)>

=item * B<Compile, Save Phase 0 (Final File Modifications)>

=item * B<Compile, Save Phase 1 (Format & Write Files To Disk)>

=item * Compile, Subcompile (Generate Binary)

=item * B<Execute>

=back

=head3 Section 2.3.1: Install, Base Dependencies

The first step toward using RPerl is installing RPerl, and the first step of installing RPerl is making sure you have a working copy of the Perl interpreter and a C++ compiler, as well as a few other base dependencies such as libc, libperl, ExtUtils::MakeMaker, GMP, cURL, and AStyle.  

A I<"dependency"> is one piece of software which another piece of software requires for proper functionality.  One software component is thus said to I<"depend"> upon a second software component, without which the first component would not work correctly.  A I<"subdependency"> is a dependency of a dependency.  Each piece of software may require any number of dependencies, each of which may require any number of subdependencies, and so forth until all required software components have been loaded.  For the purposes of the discussions in this book, the term "dependency" will inclusively refer to all of a specific software component's dependencies, subdependencies, sub-subdependencies, etc.

A I<"base dependency"> is a software component required for RPerl to function, and is differentiated from a I<"CPAN dependency"> because base dependencies are installed manually or via the operating system package manager instead of via the CPAN Perl software network, as detailed in the next section.  If you have a modern operating system, you may already have most-or-all of these base dependencies either pre-installed or available for easy automatic install via pre-built packages; if not, you may need to manually install one or more of them.  For more information on this phase of installation, please see:

L</Section 1.16: How Can I Get RPerl?>

Unique challenges may be posed by every different combination of operating system and hardware platform, because there are many different versions (and even variants) of each base dependency, with no way to predict your computer's behavior ahead of time.  Also, the RPerl development team has little-to-no interaction with the developers of the base dependencies, so it is impossible to provide useful documentation of the countless possible problem messages which you may encounter in this phase.

Some common types of problem messages may include:

=over

=item * No Pre-Built Installation Package Available For Specific Dependency

=item * Pre-Built Package(s) Cannot Be Installed

=item * Pre-Built Package(s) Installed But Not Functioning Properly

=item * Other Miscellaneous Operating System Error

=item * Other Miscellaneous Hardware Error

=back

If you encounter any problems during this step, please consult your operating system's documentation or see:

L</Section 1.18: How Can I Get Support For RPerl?>

=head3 Section 2.3.2: Install, CPAN Dependencies

Perhaps the most complex part of installing RPerl is comprised of finding, building, testing, and installing all of the software needed for RPerl's dependencies (and subdependencies) via CPAN.  A I<"CPAN dependency"> is an RPerl dependency which is installed via the CPAN software network.  Future versions of RPerl will provide easier pre-built installation packages for popular operating systems, such as those used in the base dependencies phase, but for now all (sub)dependencies must be downloaded from CPAN and custom-built for your operating system.  Each individual piece of software downloaded from CPAN is called a I<"distribution">, so RPerl itself is a CPAN distribution, and each of RPerl's CPAN (sub)dependencies is also a CPAN distribution.

We have tried to minimize the number of dependencies upon which RPerl relies, but even 1 dependency can itself have dozens or hundreds of subdependencies.  RPerl is a relatively complex piece of software, with a moderate number of dependencies and (by association) a high number of subdependencies.  If there is an error with even 1 of the numerous (sub)dependencies, it will either cause the RPerl installation to immediately terminate, or the installation will attempt to proceed in a partially-broken state, which will likely result in further errors when the broken software components are automatically tested.

CPAN promotes the use of a minimum version requirement for each (sub)dependency, which means RPerl will not use out-of-date software from CPAN, thereby avoiding a large number of known errors.  However, there is much less emphasis on utilizing a maximum version requirement, so CPAN will always default to installing the latest public release of each (sub)dependency.  It is the responsibility of the author of each (sub)dependency to ensure all public releases are stable, secure, and bug-free across a wide range of operating systems and hardware platforms, which is a constantly moving target for each software developer because new operating systems and hardware platforms are released all the time.  This means the latest public release of any 1 specific CPAN distribution may remain stable for a long time, and then all-of-a-sudden it may become unstable when a new version of one of its own (sub)dependencies is released containing a bug or incompatibility.  This further means the latest public release of the RPerl distribution on CPAN may work fine on your computer, then stop working properly if you update either the base dependencies or the CPAN dependencies.

There are 2 primary front-end applications used to install dependencies from CPAN, namely the C<`cpan`> and C<`cpanm`> commands, each of which has its own style of problem messages.  In addition, there are unique problem messages which may be emitted by each individual CPAN distribution.  As with the base dependencies in the previous RPerl install phase, there are countless possible problem messages you may encounter in this phase, none of which would be generated by RPerl itself.

Common problem messages in this phase may include:

=over

=item * PROBLEM: Front-End Application Not Installed (C<`cpan`> or C<`cpanm`>)

=for rperl X<noncode>

    cpan: command not found

    cpanm: command not found

=for rperl X</noncode>

I<SOLUTION: The C<`cpan`> command should come bundled with Perl itself, while C<`cpanm`> is part of the separate "cpanminus" software package.  In Ubuntu or other Debian-based Linux operating systems, you can use the commands C<`sudo apt-get install perl`> or C<`sudo apt-get install cpanminus`> for installation.  In other operating systems, please refer to the applicable documentation or technical support.>

=item * PROBLEM: Dependency or Subdependency Not Installed (C<`cpan`> or C<`cpanm`>)

=for rperl X<noncode>

    Warning: prerequisite Some::Dependency X.YZ not found.

=for rperl X</noncode>

I<SOLUTION: Use C<`cpan Some::Dependency`> or C<`cpanm Some::Dependency`> to install the missing dependencies.  If an error is encountered while installing a non-RPerl distribution from CPAN, such as the fictitious "Some::Dependency" in our example, then you may still be able to use RPerl by forcing the dependency to install regardless of the error by C<`cpan -f -i Some::Dependency`> or C<`cpanm -f Some::Dependency`>.  Please consider submitting a bug report to the maintainer(s) of the problematic CPAN distribution.>

=item * PROBLEM: Old Dependency or Subdependency Installed (C<`cpan`> or C<`cpanm`>)

=for rperl X<noncode>

    Warning: prerequisite Some::Dependency X.YZ not found. We have A.BC.

=for rperl X</noncode>

I<SOLUTION: Use the same installation commands as the "Dependency or Subdependency Not Installed" solution above.>

=item * PROBLEM: Dependency Or Subdependency Build Failure (C<`cpan`>)

=for rperl X<noncode>

    Running make test
      Make had some problems, won't test
    Running make install
      Make had some problems, won't install
    Failed during this command:
     SOMEAUTHOR/Some/Dependency-X.YZ.tar.gz: some_step NO -- some_command

=for rperl X</noncode>

I<SOLUTION: Use the same C<`cpan`> forced installation commands as the "Dependency or Subdependency Not Installed" solution above, and please consider submitting a bug report to the appropriate maintainer(s).>

=item * PROBLEM: Dependency Or Subdependency Test Failure (C<`cpan`>)

=for rperl X<noncode>

    Failed X/Y test scripts, X% okay.

    make: *** [test_dynamic] Error 255
      /usr/bin/make test -- NOT OK

    Running make install
      make test had returned bad status, won't install without force

=for rperl X</noncode>

I<SOLUTION: Use the same C<`cpan`> forced installation commands as the "Dependency or Subdependency Not Installed" solution above, and please consider submitting a bug report to the appropriate maintainer(s).>

=item * PROBLEM: Dependency Or Subdependency Build Or Test Failure (C<`cpanm`>)

=for rperl X<noncode>

    --> Working on Some::Dependency
    Fetching http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz ... OK
    Configuring Some-Dependency-X.YZ ... OK
    Building and testing Some-Dependency-X.YZ ... FAIL
    ! Installing Some::Dependency failed. See /home/someuser/.cpanm/work/123.456/build.log for details. Retry with --force to force install it.

    #   Failed test 'use Some::Dependency;'
    #   at /home/someuser/.cpanm/work/123.456/Some-Dependency-X.YZ/inc/Test/SomeTest.pm line 69.
    #     Tried to use 'Some::Dependency'.
    #     Error:  Attempt to reload Some/Dependency.pm aborted.
    # Compilation failed in require at lib/Some/Dependency.pm line 9.
    # BEGIN failed--compilation aborted at lib/Some/Dependency.pm line 9.
    # Compilation failed in require at (eval 350) line 2.
    # BEGIN failed--compilation aborted at (eval 350) line 2.

    Bailout called.  Further testing stopped:  failed: Some::Dependency
    FAILED--Further testing stopped: failed: Some::Dependency
    make: *** [test_dynamic] Error 255
    -> FAIL Installing Some::Dependency failed. See /home/someuser/.cpanm/work/123.456/build.log for details. Retry with --force to force install it.

=for rperl X</noncode>

I<SOLUTION: Use the same C<`cpanm`> forced installation commands as the "Dependency or Subdependency Not Installed" solution above, and please consider submitting a bug report to the appropriate maintainer(s).>

=item * PROBLEM: Network Connection Failure (C<`cpan`>)

=for rperl X<noncode>

    Fetching with LWP:
    http://cpan.strawberryperl.com/authors/01mailrc.txt.gz
    LWP failed with code[500] message[Can't connect to cpan.strawberryperl.com:80]
    Warning: no success downloading 'C:\Perl5.XY\cpan\sources\authors\01mailrc.txt.gz.tmpABC'. Giving up on it.

=for rperl X</noncode>

I<SOLUTION: Check your network connection through your web browser or the C<`ping`> command.  If your network connection appears to be functioning, then either you are behind a firewall of some kind which is interfering with your connection to the CPAN server(s), or there is an issue with the CPAN server(s) themselves.  If you are behind a corporate or other firewall, ask your network administrator for assistance or try again from a different network.  If you are sure your network connection is working and not blocked by a firewall, then try to select a different CPAN mirror server.  You can test your network connection via the C<`cpan -p`> command, and you can see a list of the recommended mirror servers (which should hopefully not have issues) via the C<`cpan -P`> command.  Then, you can change your CPAN mirror servers by first running the interactive CPAN shell via the C<`perl -MCPAN -e shell`> command, then when you are presented with the C<cpanE<lt>> prompt, enter the C<o conf init> command to re-run configuration and select one of the recommended mirror servers you were shown by the previous C<`cpan -P`> command.>

=item * PROBLEM: Network Connection Failure (C<`cpanm`>)

=for rperl X<noncode>

    Searching Some::Dependency on cpanmetadb ...
    --> Working on Some::Dependency
    Fetching http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz
    -> FAIL Download http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz failed. Retrying ...
    -> FAIL Download http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz failed. Retrying ...
    -> FAIL Download http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz failed. Retrying ...
    -> FAIL Failed to download http://www.cpan.org/authors/id/S/SO/SOMEAUTHOR/Some-Dependency-X.YZ.tar.gz
    -> FAIL Failed to fetch distribution Some-Dependency-X.YZ

=for rperl X</noncode>

I<SOLUTION: Check your network connection using the same process as the "Network Connection Failure (C<`cpan`>)" solution above.  If the network is not an issue, select a new CPAN mirror server via the same C<`cpan -P`> command as the solution above or some other method of your own choosing, then use the C<`cpanm --mirror`> or C<`cpanm --from`> commands to use the newly-selected mirror server.>

=back

Getting RPerl to work correctly does not simply require hitting a moving target, it requires hitting dozens of moving targets simultaneously.  Most of the authors of CPAN distributions are volunteers, and software bugs happen even when the developers are well-paid, so don't be surprised if you encounter a problem during this phase.  If you are convinced that you have found an as-yet undiscovered problem, please see:

L</Section 1.18: How Can I Get Support For RPerl?>

and

L</Section 1.20: What If I Find A Bug In RPerl?>

The RPerl development team is in communication with the developers of several of the primary CPAN dependencies, so if you find a bug we may be able to help find the right people to fix it.

=head3 Section 2.3.3: Install, Test Suite

The final step of installing RPerl is to pass all tests in the RPerl automatic test suite, which can only occur after all base and CPAN dependencies are properly installed.  The RPerl test suite includes a few thousand individual test cases, covering all parts of the RPerl compiler.  If any of the RPerl tests fail or generate a problem message, then there may be a problem with RPerl itself, and we would very much appreciate your help by submitting a bug report:

L</Section 1.20: What If I Find A Bug In RPerl?>

Common problem messages in this phase may include:

=over

=item * PROBLEM: RPerl Error, Test Fails

=for rperl X<noncode>

    1..X
    ok 1 - Program or module does FOO with expected error(s):    /.../lib/RPerl/Test/TestDir/TestFile_00.pm
    not ok 2 - Program or module does FOO without errors:        /.../lib/RPerl/Test/TestDir/TestFile_01.pm
    #   Failed test 'Program or module does FOO without errors:  /.../lib/RPerl/Test/TestDir/TestFile_01.pm'
    #   at t/XX_foo.t line 123.
    # Looks like you failed 1 test of X.

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  It is not recommended to use RPerl if tests fail on your operating system, however you may still choose to do so via one of the forced installation commands C<`cpan -f -i RPerl`> or C<`cpanm -f RPerl`>.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: RPerl Warning, Test Does Not Fail

=for rperl X<noncode>

    t/XX_foo.t ................ 1/? Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 307.
    Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 321.
    Use of uninitialized value $diff_line in numeric eq (==) at t/XX_foo.t line 205.
    t/XX_foo.t ................ 2/? Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 307.
    Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 321.
    Use of uninitialized value $diff_line in numeric eq (==) at t/XX_foo.t line 205.
    t/XX_foo.t ................ 3/? Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 307.
    Use of uninitialized value in string eq at /.../blib/lib/RPerl/Compiler.pm line 321.
    Use of uninitialized value $diff_line in numeric eq (==) at t/XX_foo.t line 205.
    t/XX_foo.t ................ ok
    All tests successful.
    Files=YY, Tests=ZZZZ, XXX wallclock secs
    Result: PASS

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  If all tests pass on your operating system and you only experienced non-fatal warnings during installation, then RPerl should now be installed on your system and ready to be executed via the C<`rperl`> command.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.4: Initialize, Bootstrap Subcompile

Each time the RPerl compiler is called, it may utilize a number of its own internal I<"helper function"> components which are written using C++, so those components must first be compiled using a C++ compiler and linked to Perl 5 using Inline::CPP, during the I<"bootstrap subcompile"> phase. In common English usage, I<"bootstrap"> refers to "pull yourself up by your boot straps", which is the seemingly-impossible act of lifting one's self off the ground by pulling upward on one's shoes, and which means the ability to create something from nothing or to work some force upon one's own self.  In compiler terminology, bootstrap means a compiler which can partially or fully compile itself, and is used as a measure of a compiler's long-term progress because only the most mature compilers can bootstrap.  In this specific use of the term as part of the bootstrap subcompile phase, the term bootstrap means the need to use Inline::CPP to compile a small part of the RPerl compiler, which is then used to further compile other RPerl system and application code.

RPerl is a compiler, which itself utilizes 1 or more previously-existing compilers, the use of which we will call I<"subcompile"> actions.  The primary subcompile actions utilize the C++ compiler, because both "Initialize, Bootstrap Subcompile" and "Compile, Subcompile (Generate Binary)" are C++ subcompile phases.  Only RPerl system developers will be exposed to the additional non-C++ subcompile actions.

Common problem messages in this phase may include:

=over

=item * PROBLEM: Missing C++ Compiler C<`g++`>

=for rperl X<noncode>

    Running Mkbootstrap for eval_123_4567 ()
    chmod 644 "eval_123_4567.bs"
    "/usr/bin/perl" "/usr/share/perl/5.XX/ExtUtils/xsubpp"  -typemap "/usr/share/perl/5.XX/ExtUtils/typemap" 
    -typemap "/.../lib/typemap.rperl"   eval_123_4567.xs > eval_123_4567.xsc && mv eval_123_4567.xsc eval_123_4567.c
    g++ -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include 
    -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -c  -I"/..." -I/.../lib -Ilib -D_REENTRANT -D_GNU_SOURCE -DDEBIAN 
    -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 
    -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix 
    -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g   -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" 
    -fPIC "-I/usr/lib/perl/5.XX/CORE"   eval_123_4567.c

    /bin/sh: 1: g++: not found
    make: *** [eval_123_4567.o] Error 127
    
    A problem was encountered while attempting to compile and install your Inline
    CPP code. The command that failed was:
      "make > out.make 2>&1" with error code 2
    
    The build directory was:
    /.../_Inline/build/eval_123_4567
    
    To debug the problem, cd to the build directory, and inspect the output files.
    
    Environment PATH = '/.../script:.:script:bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
     at (eval 426) line 3.
        ...propagated at /.../perl5/lib/perl5/Inline/C.pm line 869.
    BEGIN failed--compilation aborted at (eval 426) line 3.
     at /.../lib/RPerl/DataStructure/Array.pm line 21.
    INIT failed--call queue aborted.

=for rperl X</noncode>

I<SOLUTION: Please use the C<`rperl --CXX=/path/to/compiler`> command to set the correct path to your C++ compiler, or if you do not yet have a C++ compiler installed, then the use of the GNU GCC C<`g++`> compiler is strongly recommended.  In Ubuntu or other Debian-based Linux operating systems, you can use the command C<`sudo apt-get install g++`> for installation.  In other operating systems, please refer to the applicable documentation or technical support.>

I<L<https://gcc.gnu.org/install/download.html>>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Missing RPerl Helper Function File I<RPerl/HelperFunctions.h>

=for rperl X<noncode>

    /.../_Inline/build/eval_123_4567/Filters98765.c:4:44: fatal error: RPerl/HelperFunctions.h: No such file or directory
    #include <RPerl/HelperFunctions.h>  // -> NULL

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  If you are missing any critical RPerl files then either something went wrong with the installation, or you accidentally deleted an RPerl file when you should not have done so, or something else caused the RPerl file to become unavailable.  It would be very helpful if you could run a system-wide search for the missing file(s) and include that information in your bug report.  For example, in most *nix operating systems you should be able to run the command C<`find / -name HelperFunctions.h`> to search for the missing file "HelperFunctions.h".>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Missing RPerl Types Mode File I<rperltypes_mode.h>

=for rperl X<noncode>

    In file included from /.../_Inline/build/eval_123_4567/Filters98765.c:4:4:
    /.../lib/RPerl/HelperFunctions.h:4:44: fatal error: rperltypes_mode.h: No such file or directory
    #include <rperltypes_mode.h> // for definitions of __PERL__TYPES or __CPP__TYPES

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report, using the same process as the "Missing RPerl Helper Function File" solution above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.5: Initialize, Configuration

The second half of RPerl initialization involves the automatic configuration of multiple internal software settings.  This phase is primarily comprised of setting the file and directory paths to important components of your operating system and of RPerl itself.

Common problem messages in this phase may include:

=over

=item * PROBLEM: Multiple Copies Of RPerl Installed

=for rperl X<noncode>

    WARNING WEXRP00: Found multiple `rperl` executables, using first located, `/.../rperl-latest/script/rperl`

=for rperl X</noncode>

I<SOLUTION: If you are an RPerl application developer or user, then you should probably not have multiple copies of RPerl installed.  One possible cause is that you have a system-wide copy of RPerl installed by your system administrator, and also a single-user copy of RPerl installed using the C<local::lib> Perl software.  You should consider uninstalling or disabling your single-user copy of RPerl, which may be achieved by deleting or renaming the "perl5/" directory in a default C<local::lib> installation; you may also want or need to ask your system administrator for assistance.  If you are an RPerl system developer and you have purposefully installed multiple copies of RPerl, then just make sure you are using the correct copy at any one time; debugging the wrong copy of software can be extremely frustrating and confusing!>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Missing RPerl Compiler C<`rperl`>

=for rperl X<noncode>

    ERROR EEXRP00: Failed to find `rperl` executable, dying
    Compilation failed in require at /.../rperl-latest/lib/RPerl/CompileUnit/Module/Class.pm line 5.
    BEGIN failed--compilation aborted at /.../rperl-latest/lib/RPerl/CompileUnit/Module/Class.pm line 5.
    Compilation failed in require at /.../rperl-latest/lib/RPerl/AfterSubclass.pm line 10.
    BEGIN failed--compilation aborted at /.../rperl-latest/lib/RPerl/AfterSubclass.pm line 10.

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report, using the same process as the "Missing RPerl Helper Function File" solution in section 2.3.4 above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.6: Compile, Arguments & Files

RPerl is a compiler, so it is unsurprising that 9 of the 15 RPerl phases are compile phases.  When a software developer (like you!) runs the RPerl compiler via the C<`rperl`> command, the first compile phase checks the validity of the command-line arguments (AKA options) as well as the input source code file(s) to be compiled.  Command-line arguments can be entirely omitted, in which case default behavior will be utilized.  At least one input file must be specified, unless you are running C<`rperl -?`> or C<`rperl -v`> instead of a full RPerl compile command.

For details about all of RPerl's command-line arguments, please see Appendix B:

L</APPENDIX B: RPERL COMMAND-LINE ARGUMENTS>

Common problem messages in this phase may include:

=over

=item * PROBLEM: Invalid Command-Line Argument

=for rperl X<noncode>

    Unknown option: FOO
    ERROR EAR00: Failure processing command line arguments, dying

    Option FOO requires an argument
    ERROR EAR00: Failure processing command-line arguments, dying

=for rperl X</noncode>

I<SOLUTION: Check your command-line arguments for spelling errors or missing values, and review the output of C<`rperl -?`> to ensure you are utilizing valid arguments.  For example, this is good: C<`rperl --CXX=/path/to/compiler my_program.pl`>; while this is bad: C<`rperl --FOO=/path/to/compiler my_program.pl`>; and this is also bad: C<`rperl --CXX= my_program.pl`>.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Missing Command-Line Argument, Input Source Code File

=for rperl X<noncode>

    ERROR EAR01: No RPerl source code input file(s) specified, dying

=for rperl X</noncode>

I<SOLUTION: Provide the name of 1 or more RPerl source code files as input.  For example: C<`rperl my_program.pl`>>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Input Source Code File Can Not Be Found

=for rperl X<noncode>

    ERROR EAR02: Specified RPerl source code input file 'FOO' does not exist, dying

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your RPerl source code input file names and ensure they all have correct directory paths; did you forget a leading slash for absolute paths?  It may also be possible that something else in your operating system has deleted, renamed, or moved your input files.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Input Source Code File Can Not Be Read

=for rperl X<noncode>

    ERROR EAR03: Specified RPerl source code input file 'FOO' is not readable, dying

=for rperl X</noncode>

I<SOLUTION: Check the filesystem read-write-execute permissions and ownership of your RPerl source code input files, and ensure they have all have read permission allowed.  It may also be possible that something else in your operating system has modified the permissions or ownership of your input files.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Input Source Code File Is A Special File Of Some Kind

=for rperl X<noncode>

    ERROR EAR04: Specified RPerl source code input file 'FOO' is not a plain file, dying

=for rperl X</noncode>

I<SOLUTION: Check the filesystem file type of your RPerl source code input files and ensure they are all "plain" files, which means they are not "special" files such as block devices or hardware I/O devices or loopback devices, etc.  It may also be possible that something else in your operating system has modified the file type of your input files.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Input Source Code File Does Not End With '.pl' Or '.pm' Suffixes

=for rperl X<noncode>

    ERROR EAR05: Specified RPerl source code input file 'FOO' is not a Perl program ending in '.pl' or module ending in '.pm', dying

=for rperl X</noncode>

I<SOLUTION: Check the file names of your RPerl source code input files and ensure they all have correct suffixes; all RPerl source code file names must end with either the '.pl' or '.pm' suffix.  It may also be possible that something else in your operating system has renamed your input files.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Mode Category Does Not Exist

=for rperl X<noncode>

    ERROR EAR06: Unsupported or invalid mode category 'FOO' specified, supported categories are (CXX, arguments, check, compile, dependencies, execute, label, ops, subcompile, types, uncompile), dying

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your command-line argument mode category; only those categories shown in parentheses above are accepted as valid.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Mode Does Not Exist

=for rperl X<noncode>

    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'check' specified, supported modes are (OFF, ON, TRACE), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'compile' specified, supported modes are (GENERATE, OFF, PARSE, SAVE, SUBCOMPILE), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'dependencies' specified, supported modes are (OFF, ON), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'execute' specified, supported modes are (OFF, ON), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'label' specified, supported modes are (OFF, ON), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'ops' specified, supported modes are (CPP, PERL), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'subcompile' specified, supported modes are (ARCHIVE, ASSEMBLE, DYNAMIC, OFF, SHARED, STATIC), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'types' specified, supported modes are (CPP, DUAL, PERL), dying
    ERROR EAR07: Unsupported or invalid mode 'FOO' in mode category 'uncompile' specified, supported modes are (BINARY, INLINE, OFF, SOURCE, SOURCE_BINARY, SOURCE_BINARY_INLINE), dying

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your command-line argument mode; only those mode values shown in parentheses above are accepted as valid.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Multiple Input Files Incorrectly Specified

=for rperl X<noncode>

    ERROR EAR08: Both labeled & unlabeled RPerl source code input file argument(s) specified, dying

=for rperl X</noncode>

I<SOLUTION: Reformat your command-line arguments so all input files are explicitly specified with the C<--infile> argument label.  For example, this is good: C<`rperl --infile=FOO.pl --infile=BAR.pl`>; and this is bad: C<`rperl --infile=FOO.pl BAR.pl`>.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM:  Invalid Command-Line Arguments, Incompatible Uncompile & Other Flags

=for rperl X<noncode>

    ERROR EAR09: Incompatible command-line argument flags provided, both --uncompile and --compile, dying
    ERROR EAR09: Incompatible command-line argument flags provided, both --uncompile and --execute, dying
    ERROR EAR09: Incompatible command-line argument flags provided, both --uncompile and --test, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The uncompile and compile flags enable totally opposite functionality, so obviously they cannot be utilized simultaneously.  The uncompile and execute flags make no sense when utilized together because there would be no compiled code to execute, it being deleted by the uncompile mode.  The uncompile and test flags are incompatible for the same reason as uncompile and compile, because the test mode performs a partial compilation.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible No-Compile & Other Flags

=for rperl X<noncode>

    ERROR EAR10: Incompatible command-line argument flags provided, both --nocompile and --assemble, dying
    ERROR EAR10: Incompatible command-line argument flags provided, both --nocompile and --archive, dying
    ERROR EAR10: Incompatible command-line argument flags provided, both --nocompile and --shared, dying
    ERROR EAR10: Incompatible command-line argument flags provided, both --nocompile and --static, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The no-compile and assemble flags are incompatible because assembly is a subcompile mode, and subcompiling is a compile phase, so you can't compile and no-compile simultaneously; the same incompatibility applies to no-compile and the remaining 3 flags listed above: archive, shared, and static.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible Assemble Subcompile & Other Flags

=for rperl X<noncode>

    ERROR EAR11: Incompatible command-line argument flags provided, both --assemble and --archive, dying
    ERROR EAR11: Incompatible command-line argument flags provided, both --assemble and --shared, dying
    ERROR EAR11: Incompatible command-line argument flags provided, both --assemble and --static, dying
    ERROR EAR11: Incompatible command-line argument flags provided, both --assemble and --execute, dying
    ERROR EAR11: Incompatible command-line argument flags provided, both --assemble and --test, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The assemble and archive flags are incompatible because they are mutually exclusive, due to each being a distinct subcompile mode and each execution of the RPerl compiler operating in exactly 1 subcompile mode; the same incompatibility exists between assemble and the shared or static flags.  The assemble and execute flags are incompatible because assembly is only a partial subcompile which does not reach all the way to producing an executable file.  The assemble and test flags are incompatible because test mode does not reach all the way to the subcompile phase, and assembly is a subcompile mode.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible Archive Subcompile & Other Flags

=for rperl X<noncode>

    ERROR EAR12: Incompatible command-line argument flags provided, both --archive and --shared, dying
    ERROR EAR12: Incompatible command-line argument flags provided, both --archive and --static, dying
    ERROR EAR12: Incompatible command-line argument flags provided, both --archive and --execute, dying
    ERROR EAR12: Incompatible command-line argument flags provided, both --archive and --test, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The archive and shared flags are incompatible because they are mutually exclusive, due to each being a distinct subcompile mode and each execution of the RPerl compiler operating in exactly 1 subcompile mode; the same incompatibility exists between the archive and static flags.  The archive and execute flags are incompatible because building an archive library is only a partial subcompile which does not reach all the way to producing an executable file.  The archive and test flags are incompatible because test mode does not reach all the way to the subcompile phase, and building an archive library is a subcompile mode.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible Shared Object Subcompile & Other Flags

=for rperl X<noncode>

    ERROR EAR13: Incompatible command-line argument flags provided, both --shared and --static, dying
    ERROR EAR13: Incompatible command-line argument flags provided, both --shared and --execute, dying
    ERROR EAR13: Incompatible command-line argument flags provided, both --shared and --test, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The shared and static flags are incompatible because they are mutually exclusive, due to each being a distinct subcompile mode and each execution of the RPerl compiler operating in exactly 1 subcompile mode.  The shared and execute flags are incompatible because building a shared object library is only a partial subcompile which does not reach all the way to producing an executable file.  The shared and test flags are incompatible because test mode does not reach all the way to the subcompile phase, and building a shared object library is a subcompile mode.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible Static Subcompile & Test Flags

=for rperl X<noncode>

    ERROR EAR14: Incompatible command-line argument flags provided, both --static and --test, dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  The static and test flags are incompatible because test mode does not reach all the way to the subcompile phase, and building a statically-linked executable is a subcompile mode.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Arguments, Incompatible Static Subcompile Flag & Perl Module Input File

=for rperl X<noncode>

    ERROR EAR15: Incompatible command-line arguments provided, both --static subcompile mode flag and *.pm Perl module input file(s), dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to combine incompatible command-line argument flags.  Static linking is a subcompile mode which is applicable only to producing executable binary output files; executable files may only be generated from *.pl RPerl program source code input files, thus it makes no sense to attempt a static subcompile mode on a *.pm RPerl module source code input file.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Missing Command-Line Argument Value, C++ Compiler

=for rperl X<noncode>

    ERROR EAR16: Undefined, empty, or all-whitespace CXX command-line argument provided, dying

=for rperl X</noncode>

I<SOLUTION: Ensure you have specified a non-empty value for the C<--CXX> option.  For example, this is good: C<`rperl --CXX=/path/to/compiler`>; and this is bad: C<`rperl --CXX=' '`>.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Bad Output File Name

=for rperl X<noncode>

    ERROR EAR17: Invalid RPerl source code output file command-line argument specified, dying

=for rperl X</noncode>

I<SOLUTION: Ensure your output file name consists only of a filename prefix which does not contain any period (dot) C<.> characters.  For example, this is good: C<`rperl --outfile=foo`>; and this is bad: C<`rperl --outfile=foo.exe`>.  If Perl detects your operating system as Microsoft Windows, then RPerl will automatically append a '.exe' file name suffix to all output executables.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Command-Line Argument Value, Bad Compile Or Subcompile Modes

=for rperl X<noncode>

    ERROR EAR18: Invalid compile mode 'FOO' and/or subcompile mode 'BAR' command-line arguments specified, dying

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your command-line argument modes, using the same process as the "Invalid Command-Line Argument Value, Mode Does Not Exist" (ERROR EAR07) solution above.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Uncompile, Compiled Source Code File Can Not Be Deleted

=for rperl X<noncode>

    ERROR EUNFI00, UNCOMPILER, FILE SYSTEM: Cannot delete existing file 'FOO', dying: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: Review the operating system error reported at the end of the error message, and take applicable steps to correct the error.  You may need to check the filesystem read-write-execute permissions and ownership of the parent directory in which the files to be deleted are located, and ensure the directory has both execute and write permission allowed for your applicable user or group of users.  It may also be possible that something else in your operating system has modified the permissions or ownership of the parent directory.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Uncompile, Compiled Inline Directory Or File Can Not Be Deleted

=for rperl X<noncode>

    ERROR EUNFI01, UNCOMPILER, FILE SYSTEM: Cannot delete folder '_Inline', general error, dying: OPERATING_SYSTEM_ERROR
    ERROR EUNFI01, UNCOMPILER, FILE SYSTEM: Cannot delete folder '_Inline', error deleting file 'FOO', dying: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: Use the same process as the "Uncompile, Compiled Source Code File Can Not Be Deleted" solution above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.7: Compile, Dependencies

Not to be confused with base dependencies in section 2.3.1 and CPAN dependencies in section 2.3.2, a normal RPerl I<"dependency"> is one piece of RPerl application software which another piece of RPerl application software requires for proper functionality.  Every RPerl application may have 0, 1, or any number of dependencies.  As in normal Perl, an RPerl dependency is specified in source code via the C<use Some::Dependency;> operator.

If your RPerl application has 1 or more dependencies, then RPerl must compile each dependency before it compiles your main RPerl application.  If any of the dependencies rely upon subdependencies (and so forth), then each subdependency must be recursively checked for its own dependencies and they must all be compiled as well.  In other words, before your main RPerl application can be compiled, RPerl must first compile all dependencies, subdependencies, etc.  If the compilation of dependencies is disabled via the C<--nodependencies> or C<--mode dependencies=OFF> command-line arguments, or if there is a problem encountered while attempting to compile one of the dependencies, then compilation of your main RPerl program will also almost certainly experience a problem or total failure.

During this phase of compilation, RPerl makes a list of all dependencies which need to be compiled; however, the actual compiling of each dependency's source code input file does not occur until the following compile phases.  This phase only produces an assessment of what files need to be compiled, and in what order.

Common problem messages in this phase may include:

=over

=item * PROBLEM: Invalid Dependency, Source Code File Can Not Be Found, Detailed Warning

=for rperl X<noncode>

    WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package 'Bad::Dependency'  ...
    Can't locate Bad/Dependency.pm in @INC (you may need to install the Bad::Dependency module)
    (@INC contains: blib/lib lib /etc/perl /usr/lib/perl5 /usr/share/perl5 /usr/local/lib/site_perl .) at (eval 1234) line 1, <> line 15.
    BEGIN failed--compilation aborted at (eval 1234) line 1, <> line 15.

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your C<use> operators and the corresponding RPerl module file names.  The RPerl source code C<use Some::Dependency;> will cause Perl (and RPerl) to search for the file 'Dependency.pm' located in the directory 'Some', which would be written in *nix operating systems as 'Some/Dependency.pm'.  May be accompanied by the "Invalid Dependency, Source Code File Can Not Be Found" (ERROR ECOCODE03) problem message.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Dependency Check, Input Source Code File Can Not Be Found

=for rperl X<noncode>

    ERROR ECOCODE00, COMPILER, FIND DEPENDENCIES: File not found, 'FOO', dying

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  You should not see this particular error unless you are an RPerl system developer, or something has gone wrong inside RPerl itself.  This error means RPerl's front-end command-line interface program C<`rperl`> found the source code input file, but then the dependency checker in the C<RPerl::Compiler> module failed to find the same input file.  Instead, you should see the error described by "Invalid Command-Line Argument Value, Input Source Code File Can Not Be Found" (ERROR EAR02) in section 2.3.6 above.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Dependency Check, Input Source Code File Can Not Be Opened

=for rperl X<noncode>

    ERROR ECOCODE01, COMPILER, FIND DEPENDENCIES: Cannot open file 'FOO' for reading, OPERATING_SYSTEM_ERROR, dying

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  You should not see this particular error unless you are an RPerl system developer, or something has gone wrong inside RPerl itself.  This error means RPerl's front-end command-line interface program C<`rperl`> opened the source code input file, but then the dependency checker in the C<RPerl::Compiler> module failed to open the same input file.  Instead, you should see the error described by "Invalid Command-Line Argument Value, Input Source Code File Can Not Be Read" (ERROR EAR03) in section 2.3.6 above.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Dependency Configuration, Attempted C<use lib FOO;> Operator

=for rperl X<noncode>

    ERROR ECOCODE02, COMPILER, FIND DEPENDENCIES: 'use lib...' not currently supported, please set @INC using the PERL5LIB environment variable, file 'FOO', dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to modify the C<@INC> include path list by utilizing the C<use lib FOO;> operator; instead, add or modify the paths in the C<PERL5LIB> environmental variable.  In *nix operating systems, you can add '/some/new/path' by running the command C<`export PERL5LIB=$PERL5LIB:/some/new/path`>.  Perl (and RPerl) will search each directory in the path list when attempting to locate a dependency's source code file.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Dependency, Source Code File Can Not Be Found

=for rperl X<noncode>

    ERROR ECOCODE03, COMPILER, FIND DEPENDENCIES: Failed to find package file 'Bad/Dependency.pm' in %INC, file 'FOO', dying

=for rperl X</noncode>

I<SOLUTION: Check the spelling of your C<use> operators and the corresponding RPerl module file names, using the same process as the "Invalid Dependency, Source Code File Can Not Be Found, Detailed Warning" (WARNING WCOCODE00) solution above.  May be accompanied by the WARNING WCOCODE00 problem message.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Dependency Check, Input Source Code File Can Not Be Closed

=for rperl X<noncode>

    ERROR ECOCODE05, COMPILER, FIND DEPENDENCIES: Cannot close file 'FOO' after reading, OPERATING_SYSTEM_ERROR, dying

=for rperl X</noncode>

I<SOLUTION: Please submit an RPerl bug report.  You should not see this particular error unless you are an RPerl system developer, or something has gone wrong inside RPerl itself.  This error means RPerl's dependency checker in the C<RPerl::Compiler> module successfully opened the input file for reading, but then failed to close the same input file when done.  It may also be possible that something else in your operating system has deleted, renamed, or moved your input files, or changed the permissions or ownership of your input files.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Dependency, SSE Not Supported By ARM Hardware

=for rperl X<noncode>

    ERROR ECOCODE06, COMPILER, FIND DEPENDENCIES: 'use rperlsse;' command found but SSE not supported on ARM architecture, file 'FOO', dying

=for rperl X</noncode>

I<SOLUTION: Do not attempt to run compile RPerl applications containing SSE (Streaming SIMD Extensions) code on ARM (Advanced RISC Machine) architecture hardware platforms.  You should still be able to execute RPerl applications containing SSE code when operating in the slow Perl-ops-Perl-types mode, because SSE is emulated by software in this mode.  You may also have the option of compiling a non-SSE version of the same RPerl application, if it exists.  Otherwise, you will need to compile your RPerl application on a hardware platform which supports SSE.  For more information, please see: L<https://en.wikipedia.org/wiki/Streaming_SIMD_Extensions>>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.8: Compile, Parse Phase 0 (Check Perl Syntax)

This is the first phase where the input source code files are thoroughly checked for lexical and syntax errors.  The term I<"parse"> means to read through some structured data input such as human-readable plain-text source code, and a I<"full parse"> results in the computer storing some I<"intermediate representation"> (IR) which is a more computer-friendly encoding of the original source code.  All 3 parse phases are full parses, although only the final intermediate representation is utilized by RPerl.

The normal Perl interpreter is called in "check syntax only" mode with all I<"strictures"> enabled, as well as all warnings enabled and set to I<"fatal">, via the C<`perl -M"warnings FATAL=>q(all)" -Mstrict -cw`> command.  Strictures are additional built-in rules which normal Perl can optionally apply during parsing a source code input file, and a fatal warning is essentially upgraded to become the same thing as an error because execution will terminate instead of continuing.  All RPerl source code files are required to have strictures and (non-fatal) warnings enabled via the C<use strict; use warnings;> statements, but RPerl won't check for the inclusion of those statements until the following parse phase 1 (criticize Perl syntax); thus, we make sure both strictures and warnings are automatically enabled in this step, in order to catch normal Perl errors sooner rather than later.

All problems encountered in this step are triggered by normal Perl, not by RPerl itself, and it is impractical to attempt to embed all pertinent Perl documentation within this RPerl documentation.  Please utilize the following resources (in this order) to help reach a solution:

=over

=item * Official Perl Documentation, L<http://perldoc.perl.org>

=item * Internet Search Engine, Using Error Message As Search Query

=item * Internet Relay Chat (IRC), Server C<irc.perl.org>, Channel C<#perl-help>, L<http://irc.lc/magnet/perl-help/perl_newbie@@@>

=item * Perl Monks, L<http://perlmonks.org>

=item * Stack Overflow, L<http://stackoverflow.com>

=back

Common problem messages in this phase may include:

=over

=item * PROBLEM: Perl Syntax Error

=for rperl X<noncode>

    ERROR ECOPAPL02, RPERL PARSER, PERL SYNTAX ERROR
    Failed normal Perl strictures-and-fatal-warnings syntax check with the following information:
    
        File Name:        FOO
        Return Value:     2
        Error Message(s): 
    
    syntax error at FOO line 23, near "BAR"
    FOO had compilation errors.

=for rperl X</noncode>

I<SOLUTION: Review the error messages for anything obvious you can fix immediately.  If that doesn't solve the issue, then use the first 2 solution options listed above, by searching for pertinent sections of your error messages in both the official Perl documentation as well as an Internet search engine; it is quite likely that someone else has already encountered, solved, and documented your problem long ago.  If that also doesn't solve the issue, then move on to the last 3 solution options listed above, and ask for help from live humans in the Perl programming community.  Remember to be polite and respectful because you are asking for help from unpaid volunteers; always say "please" and "thank you".  If you somehow found a real, unsolved bug in Perl or a CPAN distribution, then please submit a bug report to the applicable maintainers.  Thank you!  (See what I did there?)>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Perl Syntax Warning

=for rperl X<noncode>

    ERROR ECOPAPL03, RPERL PARSER, PERL SYNTAX WARNING
    Failed normal Perl strictures-and-fatal-warnings syntax check with the following information:
    
        File Name:          FOO
        Warning Message(s): Name "BAR" used only once: possible typo at ./FOO line 23.

=for rperl X</noncode>

I<SOLUTION: Review the warning messages and utilize the 5 solution options, using the same process as the "Perl Syntax Error" solution above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.9: Compile, Parse Phase 1 (Criticize Perl Syntax)

=for text This phase of compilation checks the input source code files to make sure they all follow Perl I<"best practices"> as originated in Damian Conway's book B<Perl Best Practices> and implemented in Jeffrey Thalhammer's software Perl::Critic.  A best practice is a rule or strategy which is commonly accepted by a professional community as being the most reliable and successful technique for approaching some specific task.

=for html <p>This phase of compilation checks the input source code files to make sure they all follow Perl <i>"best practices"</i> as originated in Damian Conway's book <u><b>Perl Best Practices</b></u> and implemented in Jeffrey Thalhammer's software Perl::Critic.  A best practice is a rule or strategy which is commonly accepted by a professional community as being the most reliable and successful technique for approaching some specific task.</p>

In this case, the professional community is our Perl computer programming community, and the Perl best practices themselves have been reduced to practice (get it?) by automatic source code checking via Perl::Critic and the PPI Perl pseudo-parser.  In this phase of parsing, Perl::Critic is configured to operate in the most restrictive mode possible, which is called severity level 1, AKA "brutal" mode, and enables all possible Perl::Critic "policies" (rules).  Although RPerl purposefully utilizes brutal mode, there are some Perl::Critic policies which either conflict with other policies (yes that's bad) or with RPerl itself.  To compensate for this, RPerl application developers must selectively disable each problematic policy one-at-a-time using C<## no critic> statements, which are explained throughout this book where applicable.  For a complete list of all accepted no-critic statements, please see Appendix C:

L</APPENDIX C: RPERL CRITICS>

In addition, RPerl-specific best practices are included throughout this book where explicitly indicated, although the RPerl best practices are not currently checked or enforced in any way, and you should be careful not to confuse Perl best practices with RPerl best practices.  It is assumed the RPerl application developers already have enough flaming hoops to jump through, in the form of the 3 existing RPerl parse phases, so RPerl best practices are not required, only suggested.

You may wish to purchase or download Damian Conway's book from our friends at O'Reilly Media, especially because its page numbers are referenced in this phase's error messages:

L<http://shop.oreilly.com/product/9780596001735.do>

If you can't afford to purchase the book at this time, then you can still review a free list including all of Mr. Conway's Perl best practices in Johan Vromans' reference guide, although currently we have not yet made a mapping from policy numbers to the corresponding book page numbers:

L<http://rperl.org/docs/PBP_refguide-1.02.00.pdf>

You will also likely want to refer to the list of Perl::Critic policies and the explanations thereof:

L<http://search.cpan.org/~thaljef/Perl-Critic/lib/Perl/Critic/PolicySummary.pod>

Common problem messages in this phase may include:

=over

=item * PROBLEM: Perl Critic Policy Violation

=for rperl X<noncode>

    ERROR ECOPAPC02, RPERL PARSER, PERL CRITIC VIOLATION
    Failed Perl::Critic brutal review with the following information:
    
        File Name:    FOO
        Line number:  23
        Policy:       Perl::Critic::Policy::Bar
        Description:  Bar policy violated with extreme prejudice
        Explanation:  See Perl Best Practices page(s) 321

=for rperl X</noncode>

I<SOLUTION: Review the error description and explanation for anything obvious you can fix immediately.  If that doesn't solve the issue, then refer to Mr. Conway's book or Mr. Vromans' reference guide, as well as Mr. Thalhammer's applicable policy documentation at the links provided above.  If that also doesn't solve the issue, then move on to seeking support from live human members of the Perl community, using the same process as the "Perl Syntax Error" solution in section 2.3.8 above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.10: Compile, Parse Phase 2 (Parse RPerl Syntax)

The final parse phase of compilation utilizes RPerl's actual grammar to check the input source code files for valid RPerl syntax.  The RPerl grammar implements a restricted subset of the normal Perl 5 language.  This phase follows naturally from the previous parse phases: RPerl syntax (parse phase 2) is more restrictive than Perl::Critic brutal severity (parse phase 1), which is in turn more restrictive than normal Perl with fatal warnings and strictures enabled (parse phase 0), which is again more restrictive than normal lax Perl (not needed for RPerl parsing).

Some error messages may also include a "Helpful Hint" indicating a possible cause or solution; computer language parsing can be a very complicated process and there is no guarantee the hint is correct, so each hint should be taken with a grain of salt (a dose of healthy skepticism).

Full documentation of the RPerl grammar is provided in Appendix D:

L</APPENDIX D: RPERL GRAMMAR>

Technical support for commercial RPerl users is provided by APTech, as detailed here:

L</Section 1.18: How Can I Get Support For RPerl?>

Free technical support for non-commercial users is provided by the RPerl community, as detailed here:

L</Section 1.19: Are There Any Other Kinds Of Support?>

Common problem messages in this phase may include:

=over

=item * PROBLEM: RPerl Syntax Error

=for rperl X<noncode>

    ERROR ECOPARP00, RPERL PARSER, RPERL SYNTAX ERROR
    Failed RPerl grammar syntax check with the following information:
    
        File Name:         FOO
        Line Number:       23
        Unexpected Token:  BAR
        Expected Token(s): %{
                           )
                           ;
                           @{
                           CONSTANT_CALL_SCOPED
                           LBRACE
                           LBRACKET
                           LITERAL_NUMBER
                           LITERAL_STRING
                           LPAREN
                           OP01_CLOSE
                           OP01_NAMED
                           OP01_OPEN
                           ...
                           SELF
                           VARIABLE_SYMBOL
                           WORD
                           WORD_SCOPED
                           WORD_UPPERCASE
                           ]
                           undef
                           }

=for rperl X</noncode>

I<SOLUTION: Review the error message for anything obvious you can fix immediately.  If that doesn't solve the issue, then refer to the applicable sections of this book or the full grammar documentation in Appendix D, specifically looking for valid code examples to help you see what you've done wrong.  If that also doesn't solve the issue, then move on to seeking support from a live human as detailed in sections 1.18 and 1.19 linked above.  If you are a commercial user, please support the future of RPerl development by purchasing official tech support services through APTech.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: RPerl Syntax Error With Helpful Hint

=for rperl X<noncode>

    ERROR ECOPARP00, RPERL PARSER, RPERL SYNTAX ERROR
    Failed RPerl grammar syntax check with the following information:
    
        File Name:         FOO
        Line Number:       23
        Unexpected Token:  0
        Expected Token(s): OP01_CLOSE
                           OP01_NAMED
                           OP01_NAMED_VOID
                           OP01_OPEN
                           OP01_PRINT
                           OP07_MATH_MULT_DIV_MOD
                           OP07_STRING_REPEAT
                           OP08_MATH_ADD_SUB
                           OP10_NAMED_UNARY
                           OP11_COMPARE_LT_GT
                           OP12_COMPARE_EQ_NE
                           OP19_LOOP_CONTROL
                           OP19_LOOP_CONTROL_SCOLON
                           OP22_LOGICAL_NEG
                           OP23_LOGICAL_AND
                           OP24_LOGICAL_OR_XOR
                           WORD
        Helpful Hint:      Possible case of PBP RequireNumberSeparators (see below)
        Policy:            Perl::Critic::Policy::ValuesAndExpressions::RequireNumberSeparators
        Description:       Long number not separated with underscores
        Explanation:       See Perl Best Practices page(s) 59

=for rperl X</noncode>

I<SOLUTION: Review the error message and helpful hint for anything obvious you can fix immediately; remember, the helpful hint may not be correct!  If that doesn't solve the issue, then move on to documentation followed by tech support, using the same process as the "RPerl Syntax Error" solution above.>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.11: Compile, Generate (C++ Syntax)

After all parse phases of compilation have concluded, the original human-readable plain-text input source code files have been converted into an intermediate representation (IR) format known as an I<"abstract syntax tree"> (AST), which exists in the computer's random-access memory (RAM or just "memory"), and which is more easily analyzed or modified by a computer.

Plain-text source code formats can be readily understood by trained humans, but are nearly impossible for computers to directly understand; compilers like RPerl exist for the sole purpose of converting source code into format(s) more easily understood by a computer.  Intermediate representation formats such as RPerl's AST or normal Perl's I<"operation tree"> (AKA I<"optree">) or other languages' I<"bytecode"> can be understood by humans and computers alike, but with a significant amount of difficulty for both.  Binary code formats such as compiled executables or libraries can be readily understood by properly-configured computers, but are nearly impossible for humans to directly understand.

(The process of I<"decompiling"> or I<"reverse engineering"> the original human-readable source code from an optimized binary format is comparable to unscrambling an egg; it is currently considered nearly impossible to fully achieve, thus the act of compilation is considered to be one-way process and a strong protection against other people viewing your original source code or copying your intellectual property.  You should be careful not to confuse decompiling with uncompiling: decompiling accepts as input a compiled binary file and then produces as output human-readable source code, while uncompiling accepts as input human-readable source code and then takes the action of deleting all compiled binary files which were produced from the source code during previous compilations using the same file names.  Decompiling is not widely considered to be possible, while uncompiling is one of the more frequently utilized RPerl command-line arguments.)

During this phase of compilation, RPerl converts the AST format back into human-readable source code, but in the C++ language syntax (by default) instead of the RPerl language syntax.  This is called the I<"generate"> phase and is, in general, the exact opposite of a full parse phase; parsing converts from source code to IR, while generating converts from IR to source code.  When configured to operate in test mode, RPerl does not generate C++ source code during this phase, but instead generates back into the exact same RPerl source code as the original input file.  Test mode is thus able to check the generated RPerl source code to make sure it matches the original source code line-by-line, and also thereby "test" the RPerl parser's internal system code and "test" for the syntax correctness of the original source code, without the complexity of new C++ code becoming involved.

When compared to normal Perl, the 2 primary benefits of the RPerl compiler come from generating C++ source code: high-performance runtime speed optimization, and intellectual property source code protection.  The act of converting from one human-readable computer language source code into another is compared to the similar act of converting from one spoken (or written) human language to another; this is called the I<"translate"> process.  When computer language translation is utilized as part of a compiler, the software is called a I<"transpiler"> or "translating compiler".  RPerl is a transpiler.

Common problem messages in this phase may include:

=over

=item * PROBLEM: Attempt To Use Incomplete RPerl Feature

=for rperl X<noncode>

    WARNING WCOGEDI00, RPERL GENERATOR, DIFF CHECK: Dummy source code found, attempt to utilize incomplete RPerl feature, abandoning check

=for rperl X</noncode>

I<SOLUTION: FOO_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Difference Check, Input Source Code File Can Not Be Found

=for rperl X<noncode>

    ERROR ECOGEDI00, RPERL GENERATOR, DIFF CHECK: File not found, 'FOO', dying

=for rperl X</noncode>

I<SOLUTION: BAR_SOLUTION   ERROR EAR02   "Invalid Command-Line Argument Value, Input Source Code File Can Not Be Found"  >

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Difference Check, Input Source Code File Can Not Be Read

=for rperl X<noncode>

    ERROR ECOGEDI01, RPERL GENERATOR, DIFF CHECK: Cannot open file 'FOO' for reading, OPERATING_SYSTEM_ERROR, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Difference Check, Source Code File Can Not Be Closed

=for rperl X<noncode>

    ERROR ECOGEDI02, RPERL GENERATOR, DIFF CHECK: Cannot close file 'FOO' after reading, OPERATING_SYSTEM_ERROR, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Difference Check, Perl::Tidy Major Failure In Pre-Existing Source Code File

=for rperl X<noncode>

    ERROR ECOGEDI03: Perl::Tidy major failure in file 'FOO' with the following STDERR output, dying
    PERLTIDY_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Difference Check, Perl::Tidy Minor Failure In Pre-Existing Source Code File

=for rperl X<noncode>

    ERROR ECOGEDI04: Perl::Tidy minor failure in file 'FOO' with the following STDERR output, dying
    PERLTIDY_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Difference Check, Perl::Tidy Major Failure In Generated Source Code String

=for rperl X<noncode>

    ERROR ECOGEDI05: Perl::Tidy major failure in generated source code string with the following STDERR output, dying
    PERLTIDY_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Can't Perform Difference Check, Perl::Tidy Minor Failure In Generated Source Code String

=for rperl X<noncode>

    ERROR ECOGEDI06: Perl::Tidy minor failure in generated source code string with the following STDERR output, dying
    PERLTIDY_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Data Types Mode, No Mode Specified, Perl Operations Mode

=for rperl X<noncode>

    ERROR ECOGEMO00, RPERL GENERATOR, RPERL TYPES MODE: 'PERL' types mode expected in PERL ops mode, but undefined/null value found, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Data Types Mode, Bad Mode Specified, Perl Operations Mode

=for rperl X<noncode>

    ERROR ECOGEMO01, RPERL GENERATOR, RPERL TYPES MODE: 'PERL' types mode expected in PERL ops mode, but non-matching value 'FOO' found, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Data Types Mode, No Mode Specified, C++ Operations Mode

=for rperl X<noncode>

    ERROR ECOGEMO02, C++ GENERATOR, RPERL TYPES MODE: 'PERL' or 'CPP' types mode expected in CPP ops mode, but undefined/null value found, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Invalid Data Types Mode, Bad Mode Specified, C++ Operations Mode

=for rperl X<noncode>

    ERROR ECOGEMO03, C++ GENERATOR, RPERL TYPES MODE: 'PERL' or 'CPP' types mode expected in CPP ops mode, but non-matching value 'FOO' found, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Internal RPerl System Error, Source Group Type Mismatch

=for rperl X<noncode>

    ERROR ECOGE00, GENERATOR: Source group entries type mismatch, 'FOO' is different than 'BAR', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION  Please submit a bug report. >

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGE01, GENERATOR: Grammar rules map, failed to create pre-mapped namespace, dying' . "\n" . $EVAL_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGE02, GENERATOR: Grammar rules map, failed copy subroutines into mapped namespace, dying' . "\n" . $EVAL_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGENG00, GENERATOR: Attempt to generate output source code from non-generating class ' . ::class($self) . ', croaking

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . ($self_class)
                    . ' found where Module_25 or Class_61 expected, dying

    ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                    . ( ref $self )
                    . ' found where TypeInnerProperties_225 or TypeInnerProperties_226 expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP01, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named void operator '}
            . $operator_void_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying

    ERROR ECOGEASCP01, CODE GENERATOR, ABSTRACT SYNTAX TO C++: unsupported or unrecognized named void operator '}
            . $operator_void_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP02, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' falls below minimum argument limit '
                . ARGUMENTS_MIN()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying

    ERROR ECOGEASCP03, CODE GENERATOR, ABSTRACT SYNTAX TO C++:'
                    . "\n"
                    . 'Argument count '
                    . $argument_count
                    . ' exceeds maximum argument limit '
                    . ARGUMENTS_MAX()
                    . ' for operator ' . q{'}
                    . NAME_PERLOPS_PERLTYPES() . q{'}
                    . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP04, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying

    ERROR ECOGEASCP04, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP05, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying

    ERROR ECOGEASCP05, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP06, CODE GENERATOR, ABSTRACT SYNTAX TO RPerl: C-style for() loop header variable mismatch, initial-condition variable '
                . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ', dying

    ERROR ECOGEASCP06, CODE GENERATOR, ABSTRACT SYNTAX TO C++: C-style for() loop header variable mismatch, initial-condition variable ' . q{'}
                . $variable_symbol0 . q{'}
                . ' is different than exit-condition variable ' . q{'}
                . $variable_symbol1 . q{'}
                . ' , dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP07, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: package name ' . ($package_name)
                . ' must not start with underscore, dying

    ERROR ECOGEASCP07, CODE GENERATOR, ABSTRACT SYNTAX TO C++: package name ' . ($package_name)
                . ' must not start with underscore, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP08, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: subroutine name ' . ($name)
                . ' must not start with underscore, dying

    ERROR ECOGEASCP08, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not start with underscore, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP09, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: method name ' . ($name)
                . ' must not start with underscore, dying

    ERROR ECOGEASCP09, CODE GENERATOR, ABSTRACT SYNTAX TO C++: method name ' . ($name)
                . ' must not start with underscore, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                . $property_key
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . $variable_symbol
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', subroutine/method '
                . $modes->{_symbol_table}->{_subroutine}
                . '(), dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP12, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Array dereference of array reference must provide data type for array reference in CPPOPS_CPPTYPES mode, but no data type provided, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: Internal RPerl System Error, BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP13, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, operator may not be properly listed in $RPerl::Operation::Expression::Operator::Named::NAMES, dying

=for rperl X</noncode>

I<SOLUTION: Please submit a bug report.>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP14, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[1]
                . ' does not accept multiple arguments, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP15, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' does not accept arguments, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP16, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator 'FOO' requires exactly one argument, dying

    ERROR ECOGEASCP16, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator 'FOO' requires exactly one argument, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP17, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires one or more arguments, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP18, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires multiple arguments, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP19, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP20, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: data type mismatch, ' . q{'}
                            . $type . q{'}
                            . ' type is different than ' . q{'}
                            . $constructor_type . q{'}
                            . ' constructor type, dying

    ERROR ECOGEASCP20, CODE GENERATOR, ABSTRACT SYNTAX TO C++: data type mismatch, ' . q{'}
                            . $type . q{'}
                            . ' type is different than ' . q{'}
                            . $constructor_type . q{'}
                            . ' constructor type, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP21, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                . $property_name . q{'}
                . ' does not equal OO properties key ' . q{'}
                . $property_key . q{'}
                . ', dying

    ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++: redundant name mismatch, inner type name ' . q{'}
                . $property_name . q{'}
                . ' does not equal OO properties key ' . q{'}
                . $property_key . q{'}
                . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP22, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                    . $type_inner_name . q{'}
                    . ' does not end with OO properties or hash key ' . q{'}
                    . $key_name . q{'}
                    . ', dying

    ERROR ECOGEASCP22, CODE GENERATOR, ABSTRACT SYNTAX TO C++: redundant name mismatch, inner type name ' . q{'}
                    . $type_inner_name . q{'}
                    . ' does not end with OO properties or hash key ' . q{'}
                    . $key_name . q{'}
                    . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP23, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid hash key ' . q{'}
                    . $key_name . q{'}
                    . ' does not start with a lowercase letter a-z, dying

    ERROR ECOGEASCP23, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid hash key ' . q{'}
                    . $key_name . q{'}
                    . ' does not start with a lowercase letter a-z, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP24, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid OO properties name (hash key) ' . q{'}
                . $property_key . q{'}
                . ' does not start with a lowercase letter a-z, dying

    ERROR ECOGEASCP24, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid OO properties name (hash key) ' . q{'}
                . $property_key . q{'}
                . ' does not start with a lowercase letter a-z, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP25, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid redundant name ' . q{'}
                . $name . q{'}
                . ' does not start with a lowercase letter a-z, dying

    ERROR ECOGEASCP25, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid redundant name ' . q{'}
                . $name . q{'}
                . ' does not start with a lowercase letter a-z, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP26, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: loop control operator '
                    . $self->{children}->[0]
                    . ' found where next; or last; expected, dying

    ERROR ECOGEASCP26, CODE GENERATOR, ABSTRACT SYNTAX TO C++: loop control operator '
                    . $self->{children}->[0]
                    . ' found where next; or last; expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP27, CODE GENERATOR, ABSTRACT SYNTAX TO C++: loop control operator '
                    . $loop_control
                    . ' found where next, last, or redo expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP28, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: output stream '
                        . $stdout_stderr_optional->{children}->[0]->{attr}
                        . ' found where {*STDOUT} or {*STDERR} expected, dying

    ERROR ECOGEASCP28, CODE GENERATOR, ABSTRACT SYNTAX TO C++: output stream '
                        . $stdout_stderr_optional->{children}->[0]->{attr}
                        . ' found where {*STDOUT} or {*STDERR} expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP29, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: comparison operator '
                    . $self->{children}->[1]
                    . ' found where ==, !=, <=>, eq, ne, or cmp expected, dying

    ERROR ECOGEASCP29, CODE GENERATOR, ABSTRACT SYNTAX TO C++: comparison operator '
                    . $self->{children}->[1]
                    . ' found where ==, !=, <=>, eq, ne, or cmp expected, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP30, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve data subcomponent from scalar type ' . $types->[$i] . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP31, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not retrieve invalid OO property ' . $number_or_string_literal . ' in user-defined class ' . $types->[$i] . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP32, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not determine OO property name (and thus type) from non-literal subexpression...' . "\n" . $subexpression_generated . "\n" . '...in user-defined class ' . $types->[$i] . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP33, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Variable retrieval, can not use arrayref retrieval on object of user-defined class ' . $types->[$i] . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP34, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: ModuleHeader found without first finding Module for previous ModuleHeader, dying 
 
    ERROR ECOGEASCP34, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: ModuleHeader found without first finding Module for previous ModuleHeader, dying 

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP35, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Module found without first finding ModuleHeader, dying

    ERROR ECOGEASCP35, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Module found without first finding ModuleHeader, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP36, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Class FOO is attempting to inherit OO properties from non-properties variable $BAR, dying
 
    ERROR ECOGEASCP36, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Class FOO is attempting to inherit OO properties from non-properties variable $BAR, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASRP37, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Class FOO inherits OO functionality from parent class BAR but is attempting to inherit OO properties from non-matching class BAZ, dying
 
    ERROR ECOGEASCP37, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Class FOO inherits OO functionality from parent class BAR but is attempting to inherit OO properties from non-matching class BAZ, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP40, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Compile-time optimization, loop iterator '
                    . $variable_symbol
                    . ' declared as non-integer type '
                    . $modes->{_loop_iterators}->{$variable_symbol}
                    . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP50, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal started with single-quote but not terminated with single-quote, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP51, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal started with q-left-brace single-quote but not terminated with right-brace, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP60, CODE GENERATOR, ABSTRACT SYNTAX TO C++: first argument missing, constructor for type ' . $type . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP61, CODE GENERATOR, ABSTRACT SYNTAX TO C++: second argument missing, constructor for type ' . $type . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP62, CODE GENERATOR, ABSTRACT SYNTAX TO C++: constructor called for recognized but currently unsupported type ' . $type . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP63, CODE GENERATOR, ABSTRACT SYNTAX TO C++: constructor called for unrecognized type ' . $type . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEASCP70, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator 'FOO' requires ArrayDereference argument, received 'BAR' instead, dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOGEPPRP20, CODE GENERATOR, PURE PERL TO RPERL: redundant name mismatch, inner type name ' . q{'}
                    . $object_property_inner_type_name . q{'}
                    . ' does not equal OO properties key ' . q{'}
                    . $object_property_key . q{'}
                    . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.12: Compile, Save Phase 0 (Final File Modifications)

NEED ADD CONTENT

Common problem messages in this phase may include:

=over

=item * PROBLEM: FOO_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking

=for rperl X</noncode>

I<SOLUTION: FOO_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAR_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI01, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Received non-empty PMC source, dying

=for rperl X</noncode>

I<SOLUTION: BAR_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI02, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: File not found, ' . q{'}
                            . $module_pmc_filename_manual . q{'} . "\n"
                            . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI03, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot open file '
                        . $module_pmc_filename_manual
                        . ' for reading, '
                        . OPERATING_SYSTEM_ERROR
                        . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI04, COMPILER, SAVE OUTPUT FILES, MODULE TEMPLATE COPY: Cannot close file '
                        . $module_pmc_filename_manual
                        . ' after reading, '
                        . OPERATING_SYSTEM_ERROR
                        . ', dying

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.13: Compile, Save Phase 1 (Format & Write Files To Disk)

NEED ADD CONTENT

Common problem messages in this phase may include:

=over

=item * PROBLEM: FOO_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI05, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking

=for rperl X</noncode>

I<SOLUTION: FOO_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAR_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI06, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot write to file,\ncroaking: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAR_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI07, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot delete existing file,\ncroaking: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI08, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot open file for writing,\ncroaking: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI09, COMPILER, FILE SYSTEM: Attempting to save new file '$file_name', cannot close file,\ncroaking: OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOFI10, COMPILER, FILE SYSTEM: Cannot delete Artistic Style original file ' . 
                            q{'} . $file_name . '.orig' . q{'} . ',' . "\n" . 'croaking:' . OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    WARNING WCOCOFO00, COMPILER, PERL CODE FORMATTING: Perltidy command `perltidy` not found, abandoning formatting

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    WARNING WCOCOFO01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.14: Compile, Subcompile (Generate Binary)

NEED ADD CONTENT

Common problem messages in this phase may include:

=over

=item * PROBLEM: FOO_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOSU00, COMPILER, SUBCOMPILE: Received incorrect subcompile mode OFF while inside subcompile subroutine, croaking

=for rperl X</noncode>

I<SOLUTION: FOO_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAR_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOSU01, COMPILER, SUBCOMPILE: Received invalid subcompile mode ' . q{'} . $modes->{subcompile} . q{'} . 
                ' while inside subcompile subroutine, croaking

=for rperl X</noncode>

I<SOLUTION: BAR_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOSU02, COMPILER, SUBCOMPILE: Perl source code CORE directory or CORE/perl.h file not found in @INC path listing, croaking

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOSU03, COMPILER, SUBCOMPILE: Cannot delete temporary object file ' . 
                        q{'} . $cpp_output_file_name_group->{O} . q{'} . ',' . "\n" . 'croaking:' . OPERATING_SYSTEM_ERROR

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ECOCOSU04, COMPILER, SUBCOMPILE: C++ compiler returned error code,' . "\n" . 
            'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages if none appear above,' . "\n" . 
            'croaking

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    WARNING WCOCOSU00, COMPILER, SUBCOMPILE: C++ compiler returned success code but produced output which may indicate an error,' . "\n" . 
                'please run again with `rperl -D` command or RPERL_DEBUG=1 environmental variable for error messages or other output if none appear above

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=back

=head3 Section 2.3.15: Execute

NEED ADD CONTENT

Common problem messages in this phase may include:

=over

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EBV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but undefined/null value found,\ncroaking

    ERROR EBV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EBV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but non-boolean value found,\ncroaking

    ERROR EBV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nboolean value expected but non-boolean value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EUV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but undefined/null value found,\ncroaking

    ERROR EUV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EUV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\ncroaking

    ERROR EUV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\ncroaking

    ERROR EIV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\ncroaking

    ERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ninteger value expected but non-integer value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\ncroaking

    ERROR EMV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\ncroaking

    ERROR EMV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\ncroaking

    ERROR EMV02, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\ncroaking

    ERROR EMV03, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\ncroaking

    ERROR EMV04, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\ncroaking

    ERROR EMV05, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped hash entry expected at key 'value' but no hash entry defined,\ncroaking

    ERROR EMV06, MISSING HASH ENTRY, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped hash entry expected at key 'value' but no hash entry defined,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\ncroaking

    ERROR EMV07, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\ncroaking

    ERROR EMV08, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name); }

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\ncroaking

    ERROR EMV09, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EMV10, CONSTRUCTOR RETURN VALUE MISMATCH, CPPOPS_CPPTYPES:\nexactly 1 return value expected but %"INTEGER" return value(s) found,\ncroaking", callback_retval_count

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: FOO_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\ncroaking

    ERROR ENV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: FOO_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAR_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\ncroaking

    ERROR ENV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nnumber value expected but non-number value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAR_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ETV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but undefined/null value found,\ncroaking

    ERROR ETV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR ETV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but non-character value found,\ncroaking

    ERROR ETV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\ncharacter value expected but non-character value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\ncroaking

    ERROR EPV00, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but undefined/null value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

    ERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\ncroaking

    ERROR EPV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:\nstring value expected but non-string value found,\nin variable %s from subroutine %s,\ncroaking", variable_name, subroutine_name

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=item * PROBLEM: BAZ_PROBLEM_LABEL

=for rperl X<noncode>

START HERE: continue adding data structure errors, then go back and check if additional data type errors needs to be found in *.cpp or *.pm files

START HERE: continue adding data structure errors, then go back and check if additional data type errors needs to be found in *.cpp or *.pm files

START HERE: continue adding data structure errors, then go back and check if additional data type errors needs to be found in *.cpp or *.pm files

    BAZ_PROBLEM_MESSAGE

=for rperl X</noncode>

I<SOLUTION: BAZ_SOLUTION>

X<ENABLE_LIST_SPACING>

=back

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

Normal Perl provides a special literal value C<undef>, along with a built-in function named C<defined> which is used to test if a variable contains the special C<undef> value.  RPerl does not support C<undef> or C<defined>, because C++ does not fully support the concept of undefined values, and RPerl's high-speed components are written using C++.

Data types make your code much more readable and much, much faster.  Learn to love data types.  Now.

=head3 Section 2.4.x: Choosing Good Variable Names

=for comment [ INSERT CONTENT ]

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

START HERE: continue editing & adding content

START HERE: continue editing & adding content

START HERE: continue editing & adding content

The I<"scope"> of a variable is either local using the C<my> keyword, or global using the C<our> keyword.  Local variables are only usable within their own enclosing code block such as a conditional (section xxx), loop (xxx), or subroutine (chapter 4).

and global variables are usable within any code block accessible by the Perl interpreter or (RPerl compiler).

Except for certain special circumstances, all variables in RPerl are locally-scoped using C<my>.

=for comment [ INSERT SCOPE TYPE NAME VALUE ]

=head3 Section 2.4.x: Binary Assignment Operators

    OP19_VARIABLE_ASSIGN_BY   = /(\+=|-=|\*=|\/=)/            # precedence 19 infix: add assign '+=', subtract assign '-=', multiply assign '*=', divide assign '/='
    %token OP19_VARIABLE_ASSIGN_BY   = /(\.=)/        # precedence 19 infix: string concatenation assign '.='

=head3 Section 2.4.x: Increment & Decrement Operators

=begin text

my $z = q{<<< BEGIN TEXT EVAL >>>};

use Text::ASCIITable;

my Text::ASCIITable $table = Text::ASCIITable->new({alignHeadRow => 'center', drawRowLine => 1});

$table->setCols(splice [split /\s*\n\s*/, q{

=end text

=begin man

.TS
allbox tab(@) ;
c c c c c c c
l l l l r l l .

=end man

=for html <table class="rperl operators">

=begin docbook

<table id="learning_rperl-section_2.4.x.1-table_1" label="" frame="all" colsep="1" rowsep="1">
<title>Increment & Decrement Operators</title>
<tgroup cols="6">

=end docbook

=for man T{

=for html <tr><th>

=for docbook <thead>

=for docbook <row><entry align="center">

B<Name>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Symbol>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Arity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Fixity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Precedence>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Associativity>

=for man T}@T{

=for html </th><th>

=for docbook </entry><entry align="center">

B<Supported>

=for text }], 1);

=for man T}

=for html </th></tr>

=for docbook </entry></row>

=for docbook </thead>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <tbody>

=for docbook <row><entry align="left">

Pre-Increment

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

++

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

03

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Post-Increment

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

++

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Postfix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

03

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Pre-Decrement

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

--

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Prefix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

03

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=for text $table->addRow(splice [split /\s*\n\s*/, q{

=for man T{

=for html <tr><td>

=for docbook <row><entry align="left">

Post-Decrement

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

--

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Unary

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Postfix

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="right">

03

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Non

=for man T}@T{

=for html </td><td>

=for docbook </entry><entry align="left">

Yes

=for text }], 1);

=for man T}

=for html </td></tr>

=for docbook </entry></row>

=begin text

return $table->draw( ['.=','=.','=','='],   # .=============.

                     ['|','|','|'],         # | info | info |
 
                     ['|-','-|','=','='],   # |-===========-|

                     ['|','|','|'],         # | info | info |

                     ["'=","='",'=','='],   # '============='

                     ['|-','-|','-','+']    # rowseperator

                    );

$z = q{<<< END TEXT EVAL >>>};

=end text

=for man .TE

=for html </table>

=for docbook </tbody></tgroup></table>

=over

=item * B<Pre-Increment>

Add 1 to operand, then return incremented value

=back

    # NEED ADD EXAMPLES
    ++$i  # 0

=head3 Section 2.4.x: Chomp & Chop Operators

=for comment [ INSERT CHOMP & CHOP ]

=head2 Section 2.5: Constant Data

Sometimes you have a piece of data that will never change once you compile your software, which is what we call I<"constant data"> or just a I<"constant"> for short.

Constants are the opposite of variables, because constants are designed not to change, while variables are designed to change as many times as needed.

Below are two example RPerl constants, one containing numeric data and another containing text data:

    # [[[ CONSTANTS ]]]
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';

These two constants can be utilized as follows:

    my number $area = PI() * $r ** 2;
    my string $dessert = 'having a nice slice of ' . PIE();

As seen in the examples above, we must first declare each constant to have an all-uppercase name via the C<use constant> command, after which we can access the stored data value by calling the constant name followed by empty parentheses.  (In normal interpreted Perl, a constant is functionally equivalent to a subroutine which accepts no arguments and performs no operations other than to call the C<return> operator with a hard-coded data value; see L</CHAPTER 4: SUBROUTINES> for more info.)

All constants must utilize names with uppercase-only lettering, in order to distinguish them from similarly-named variables.  Thus, a normal variable may not have an all-uppercase name.  (Special variables called I<"file handles"> must be all-uppercase; see L</CHAPTER 5: INPUT & OUTPUT> for more info.)

    use constant PIE => my string $TYPED_PIE = 'peanut butter';  # fine
    use constant Pie => my string $TYPED_Pie = 'coffee cream';   # error in RPerl, compiled modes
    use constant pie => my string $TYPED_pie = 'mocha silk';     # error in RPerl, compiled modes

    my string $PIE = 'oreo';        # error in RPerl, compiled modes
    my string $Pie = 'blackberry';  # okay
    my string $pie = 'blueberry';   # best

The declaration of constants follows a purposefully-repetitive format starting with the C<use constant> command, followed by the all-uppercase constant name, a fat arrow (AKA fat comma) C<=E<gt>>, the C<my> command, the desired data type, a variable named C<$TYPED_> with the same all-uppercase name appended, the equal-sign C<=> assignment operator, and finally the desired data value with a closing semicolon.  Within a constant declaration, the all-uppercase constant name must appear identically in both places, which is a language construct enabling us to provide a data type where it would otherwise be impossible to do so.

    use constant PIE => my string $TYPED_PIE = 'cherry';        # fine
    use constant PIE =>                        'black forest';  # error in RPerl, compiled modes
    use constant PIE => my string $TYPED_PI  = 'grasshopper';   # error in RPerl, compiled modes
    use constant PIE => my string $TYPED_POE = 'raven';         # error in RPerl, compiled modes

You may access the value of a constant as many times as you like, but you may never change the value once the software has been compiled.

    $pie = PIE();       # fine
    $pie = $PIE;        # error in RPerl, compiled modes
    $pie = $TYPED_PIE;  # error in RPerl, compiled modes

    PIE()      = 'chocolate bourbon';   # error in Perl and RPerl
    $PIE       = 'chocolate chip';      # error in RPerl, compiled modes
    $TYPED_PIE = 'death by chocolate';  # error in RPerl, compiled modes

Constant values must be literals and not other constants or variables.

    use constant PIE => my string $TYPED_PIE = 'banana cream';  # fine
    use constant PIE => my string $TYPED_PIE = PI();            # error in RPerl, compiled modes
    use constant PIE => my string $TYPED_PIE = $pie;            # error in RPerl, compiled modes

It is always possible to use a variable instead of a constant, but not the other way around.
You should use constants whenever possible, because they will always be at least as fast as variables, and often faster!

                        my string $pie       = 'lemon meringue';  # okay
    use constant PIE => my string $TYPED_PIE = 'key lime';        # best

=head2 Section 2.6: Output With C<print>

=for comment [ INSERT PRINT ]

=head2 Section 2.7: The C<if> Control Structure

=for comment [ INSERT IF ]

=head2 Section 2.8: Getting User Input

=for comment [ INSERT INPUT ]

=head2 Section 2.10: The C<while> Control Structure

=for comment [ INSERT WHILE ]

=head2 Section 2.x: Exercises

=head3 1.  XXXYYYZZZ  [ XYZ mins ]

=for comment [ INSERT EXERCISES ]

X<br>


=head1 CHAPTER 3: LISTS & ARRAYS

An array may not be a constant.

=for comment [ INSERT CHAPTER ]

=head3 Section 3.x.x: SSE Operators

    OP08_MATH_ADD_SUB         = /(sse_add|sse_sub)/    # precedence 08 infix: SSE add 'sse_add', SSE subtract 'sse_sub'
    OP07_MATH_MULT_DIV_MOD    = /(sse_mul|sse_div)/  # precedence 07 infix: SSE multiply 'sse_mul', SSE divide 'sse_div'

X<br>


=head1 CHAPTER 4: SUBROUTINES

    our void $SWEET_TOOTH = sub { print 'Yum!  I love ', PIE(), "\n"; };  # error in RPerl, compiled modes
    our void $Sweet_Tooth = sub { print 'Yum!  I love ', PIE(), "\n"; };  # okay
    our void $sweet_tooth = sub { print 'Yum!  I love ', PIE(), "\n"; };  # best

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 5: INPUT & OUTPUT

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 6: HASHES

A hash may not be a constant.

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 7: REGULAR EXPRESSIONS

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 8: REGULAR EXPRESSIONS MATCHING

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 9: REGULAR EXPRESSIONS PROCESSING

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 10: CONTROL STRUCTURES

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 11: CLASSES, PACKAGES, MODULES, LIBRARIES

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 12: FILE TESTS

=for comment [ INSERT CHAPTER ]

=head3 Section 12.x.x: File Test Operators

    %token OP10_NAMED_UNARY_SCOLON   = /(-A;|-B;|-C;|-M;|-O;|-R;|-S;|-T;|-W;|-X;|-b;|-c;|-d;|-e;|-f;|-g;|-k;|-l;|-o;|-p;|-r;|-s;|-t;|-u;|-w;|-x;|-z;)/

X<br>


=head1 CHAPTER 13: DIRECTORY OPERATIONS

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 14: STRINGS & SORTING

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 15: SMART MATCHING & GIVEN-WHEN

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 16: PROCESS MANAGEMENT

=for comment [ INSERT CHAPTER ]

X<br>


=head1 CHAPTER 17: SOME ADVANCED TECHNIQUES

=for comment [ INSERT CHAPTER ]

=head3 Section 17.x.x: UNSORTED Operators

# REGEX
    %token OP01_NAMED_SCOLON         = /(m;|pos;|qr;|s;|study;|tr;|y;

# FORMAT
    %token OP01_NAMED_SCOLON         = /(format;|formline;|write;

# PACK / UNPACK
    %token OP01_NAMED_SCOLON         = /(pack;|unpack;|vec;|

# UNSORTED
    %token OP01_NAMED_SCOLON         = /(accept;|bind;|binmode;|bless;|break;|chmod;|chomp;|chop;|chown;|closedir;|connect;|continue;|dbmclose;
    |dbmopen;|default;|dump;|each;|endgrent;|endhostent;|endnetent;|endprotoent;|endpwent;|endservent;|eof;|evalbytes;|exec;|fcntl;|fileno;|flock;|fork;
    |getc;|getgrent;|getgrgid;|getgrnam;|gethostbyaddr;|gethostent;|getlogin;|getnetbyaddr;|getnetent;|getpeername;|getppid;|getpriority;
    |getprotobynumber;|getprotoent;|getpwent;|getpwnam;|getpwuid;|getservbyname;|getservbyport;|getservent;|getsockname;|getsockopt;|given;|grep;|ioctl;|join;
    |keys;|kill;|link;|listen;|local;|map;|mkdir;|msgctl;|msgget;|msgrcv;|msgsnd;|opendir;|pipe;|pop;|prototype;|push;|qx;|read;|readdir;
    |readline;|readpipe;|recv;|rename;|reset;|reverse;|rewinddir;|say;|seek;|seekdir;|select;|semctl;|semget;|semop;|send;|setgrent;|sethostent;|setnetent;
    |setpgrp;|setpriority;|setprotoent;|setpwent;|setservent;|setsockopt;|shift;|shmctl;|shmget;|shmread;|shmwrite;|shutdown;|socket;|socketpair;|sort;|splice;|split;
    |state;|symlink;|syscall;|sysopen;|sysread;|sysseek;|system;|syswrite;|tell;|telldir;|tie;|tied;|time;|times;|truncate;|unless;|unlink;
    |unshift;|untie;|until;|utime;|values;|vec;|wait;|waitpid;|wantarray;|warn;|when;)/

    %token OP10_NAMED_UNARY_SCOLON   = /(alarm;|caller;|chdir;|chroot;|defined;|delete;|do;|eval;|exists;|gethostbyname;|getnetbyname;|getpgrp;|getprotobyname;|glob;
    |gmtime;|goto;|localtime;|lock;|lstat;|readlink;|ref;|require;|rmdir;|scalar;|sleep;|stat;|umask;)/

X<br>


=head1 APPENDIX A: EXERCISE ANSWERS

=head2 Chapter 1, Exercise 1

This exercise is commonly used as the first task for new programmers, or for programmers who are learning a new language.X<br>

The goal of this exercise is to become familiar with the boilerplate (often-repeated template) RPerl C<HEADER> and C<CRITICS> code sections, as well as the basic C<print> operator.X<br>

The first line, starting with C<#!> and called a "shebang", tells the operating system to run this program using Perl.X<br>

The 4 lines in the C<HEADER> section tell Perl to run this program using RPerl, and the C<$VERSION> number may be incremented for each update to this file.X<br>

The line in the C<CRITICS> section, starting with C<##>, tells RPerl to allow hard-coded numeric values (not used in this program), as well as the C<print> operator.X<br>

The last line, in the C<OPERATIONS> section, calls the C<print> operator on a comma-separated list consisting of 2 string literals, which will simply display the text "Hello, world!" followed by a newline character.X<br>

All other lines beginning with C<#> are comments and, along with blank lines, may be safely ignored or removed.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 1, Exercise 1
    # Print "Hello, world!"; the classic first program for new programmers

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]
    print 'Hello, world!', "\n";

Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter1/exercise_1-hello_world.pl
    Hello, world!

=for rperl X</noncode>

X<br>


=head2 Chapter 1, Exercise 2

The goal of this exercise is to become familiar with the C<`rperl`> command.X<br>

X<br>

Example execution and output for 2a and 2b:

=for DEV NOTE, CORRELATION #rp029: all updates to `rperl` command-line arguments must be documented in script/rperl and 2 places in lib/RPerl/Learning.pm

=for rperl X<noncode>

    $ rperl -?
    Usage:
                rperl [ARGUMENTS] input_program_0.pl [input_program_1.pl input_program_2.pl ...]
                rperl [ARGUMENTS] MyClassFoo.pm [MyClassBar.pm MyClassBat.pm ...]
                rperl [ARGUMENTS] input_program_0.pl MyClassFoo.pm [input_program_1.pl ... MyClassBar.pm ...]
    
    Arguments:
        --help ...OR... -h ...OR... -?
                Print this (relatively) brief help message for command-line usage.
                For additional explanations, run the command `perldoc RPerl::Learning` and see Appendix B.
    
        --version ...OR... -v
        --vversion ...OR... -vv
                Print version number and copyright information.
                Repeat as 'vv' for more technical information, similar to `perl -V` configuration summary argument.
                Lowercase 'v' not to be confused with uppercase 'V' in 'Verbose' argument.
    
        --infile=MyFile.pm ...OR... -i=MyFile.pm
                Specify input file, may be repeated for multiple input files.
                Argument prefix '--infile' may be entirely omitted.
                Argument prefix MUST be omitted to specify wildcard for multiple input files.
    
        --outfile=MyCompiledModule ...OR... -o=MyCompiledModule
        --outfile=my_compiled_program ...OR... -o=my_compiled_program
                Specify output file prefix, may be repeated for multiple output files.
                RPerl *.pm input file with PERL ops will create MyCompiledModule.pmc output file.
                RPerl *.pl input file with PERL ops will create my_compiled_program (or my_compiled_program.exe on Windows) output file.
                RPerl *.pm input file with CPP  ops will create MyCompiledModule.pmc, MyCompiledModule.cpp, & MyCompiledModule.h output files.
                RPerl *.pl input file with CPP  ops will create my_compiled_program (or my_compiled_program.exe on Windows) & my_compiled_program.cpp output files.
                Argument may be entirely omitted, foo.* input file will default to foo.* output file(s).
    
        --CXX=/path/to/compiler
                Specify path to C++ compiler for use in subcompile modes, equivalent to '--mode CXX=/path/to/compiler' or 'CXX' manual Makefile argument, 'g++' by default.
    
        --mode ops=PERL ...OR... -m ops=PERL
        --mode ops=CPP ...OR... -m ops=CPP
                Specify operations mode, CPP by default.
                If set to PERL, generate Perl operations in the source code output file(s).
                If set to CPP, generate C++ operations in the source code output file(s).
                PERL ops mode forces PERL types mode & PARSE or GENERATE compile mode; PERLOPS_PERLTYPES is test mode, does not actually compile.
    
        --mode types=PERL ...OR... -m types=PERL
        --mode types=CPP ...OR... -m types=CPP
        --mode types=DUAL ...OR... -m types=DUAL
                Specify data types mode, CPP by default.
                If set to PERL, generate Perl data types in the source code output file(s).
                If set to CPP, generate C++ data types in the source code output file(s).
                If set to DUAL, generate both Perl and C++ data types in the source code output file(s).
                DUAL mode allows generate-once-compile-many types, selected by '#define __FOO__TYPES' in lib/rperltypes_mode.h or `gcc -D__FOO__TYPES` manual subcompile argument.
    
        --mode check=OFF ...OR... -m check=OFF
        --mode check=ON ...OR... -m check=ON
        --mode check=TRACE ...OR... -m check=TRACE
                Specify data type checking mode, TRACE by default.
                If set to OFF, do not perform dynamic type checking, only built-in C++ static type checking.
                If set to ON, perform dynamic type checking in addition to built-in C++ static type checking.
                If set to TRACE, perform dynamic type checking in addition to built-in C++ static type checking, with subroutine-and-variable trace information.

    [[[ REMAINING ARGUMENTS OMITTED FOR BREVITY ]]]

=for rperl X</noncode>

Example execution and output for 2c and 2d:

=for rperl X<noncode>

    $ rperl -t -V LearningRPerl/Chapter1/exercise_1-hello_world.pl 
    Verbose Flag:       1
    Debug Flag:         0
    Test Flag:          1
    Input File:         LearningRPerl/Chapter1/exercise_1-hello_world.pl
    Output File(s):     LearningRPerl/Chapter1/exercise_1-hello_world  
    Modes:              ops => PERL, types => PERL, check => TRACE, compile => GENERATE, execute => ON, label => ON

    DEPENDENCIES:       Follow & find all deps...    0 found.
    PARSE PHASE 0:      Check     Perl syntax...        done.
    PARSE PHASE 1:      Criticize Perl syntax...        done.
    PARSE PHASE 2:      Parse    RPerl syntax...        done.
    GENERATE:           Generate RPerl syntax...        done.
    EXECUTE:            Run code...

    Hello, world!


    $ rperl -t -D LearningRPerl/Chapter1/exercise_1-hello_world.pl 
    in rperl, have $RPerl::DEBUG = 1
    in rperl, have $RPerl::VERBOSE = 0
    Hello, world!


    $ rperl -t -V -D LearningRPerl/Chapter1/exercise_1-hello_world.pl 
    Verbose Flag:       1
    Debug Flag:         1
    Test Flag:          1

    in rperl, have $RPerl::DEBUG = 1
    in rperl, have $RPerl::VERBOSE = 1
    Input File:         LearningRPerl/Chapter1/exercise_1-hello_world.pl
    Output File(s):     LearningRPerl/Chapter1/exercise_1-hello_world  
    Modes:              ops => PERL, types => PERL, check => TRACE, compile => GENERATE, execute => ON, label => ON

    DEPENDENCIES:       Follow & find all deps...    0 found.
    PARSE PHASE 0:      Check     Perl syntax...        done.
    PARSE PHASE 1:      Criticize Perl syntax...        done.
    PARSE PHASE 2:      Parse    RPerl syntax...        done.
    GENERATE:           Generate RPerl syntax...        done.
    EXECUTE:            Run code...

    Hello, world!

=for rperl X</noncode>

Of the above 3 commands executed for 2c and 2d, the first includes normal output plus additional verbose output; the second includes normal output plus additional debugging output (minimal in this simple case); and the third includes normal output plus both verbose and debugging output.

X<br>


=head2 Chapter 1, Exercise 3

The goal of this exercise is to become familiar with basic variables and arithmetic.X<br>

The shebang line, C<HEADER> section, and first line in the C<CRITICS> section are the same boilerplate as the previous exercise.X<br>

The second line in the C<CRITICS> section tells RPerl to allow the C<$> (dollar) character, among others, to be displayed using the C<print> operator.X<br>

The first 3 lines in the C<OPERATIONS> section each declare a new variable; C<$foo> and C<$bar> each hold an C<integer> (non-floating-point) numeric value, while C<$baz> holds a C<number> (floating-point) value.X<br>

The C<$foo> and C<$bar> variables receive their values from hard-coded numeric values being operated upon by the addition C<+> and multiplication C<*> operators, respectively; the C<$baz> and C<$zab> variables receive their values from the the C<$foo> and C<$bar> variables being operated upon by the division C</> operator.  The C<to_number()> type conversion subroutine is necessary for the C++ compiler to use floating-point arithmetic instead of integer arithmetic on the division C</> operators, without it we would receive the truncated integer value of C<58> in C<$baz>, for example.  We will receive the correct floating-point answers if we call C<to_number()> on either C<$bar> (as shown), or C<$foo>, or both; in other words, at least one of the input operands for each operator must be passed through C<to_number()>.X<br>

The last 4 lines call the C<print> operator to display the names of each variable; followed by each variable's respective value, converted from number to underscore-formatted string via the RPerl type conversion subroutine C<to_string()>; followed by a newline character.X<br>


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
    my integer $foo = 21 + 12;
    my integer $bar = 23 * 42;
    my number  $baz = to_number($bar) / $foo;
    my number  $zab = to_number($foo) / $bar;
    print 'have $foo = ', to_string($foo), "\n";
    print 'have $bar = ', to_string($bar), "\n";
    print 'have $baz = ', to_string($baz), "\n";
    print 'have $zab = ', to_string($zab), "\n";


Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter1/exercise_3-foo_bar_arithmetic.pl 
    have $foo = 33
    have $bar = 966
    have $baz = 29.272_727_272_727_3
    have $zab = 0.034_161_490_683_229_8

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 1

The goal of this exercise is to become familiar with constant values.X<br>

The first line in the C<CRITICS> section tells RPerl to allow hard-coded numeric values as well as the C<print> operator, both of which are utilized in this program.X<br>

The second line in the C<CRITICS> section tells RPerl to allow the C<use constant> operation.X<br>

The line in the C<CONSTANTS> section declares a number (floating-point) constant value named C<PI>, automatically accessible via a subroutine named C<PI()>.X<br>

The inner type variable C<$TYPED_PI> is only used for RPerl parsing purposes; for example, if your constant is named C<FOO> then you should declare it using the inner type variable C<$TYPED_FOO> and you should access it by calling the subroutine C<FOO()>, but you should never directly utilize the variable C<$TYPED_FOO> anywhere else in your code.X<br>

The first 2 lines in the C<OPERATIONS> section each create a new number variable, with C<$radius> set to the hard-coded value of C<12.5> and C<$circumference> set to the well-known basic geometry formula "circumference equals 2 pi times radius".X<br>

The last 3 lines call the C<print> operator to display the values of C<PI>, C<$radius>, and C<$circumference>, each followed by a newline character.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 1
    # Find the circumference of a circle with hard-coded radius of 12.5 units

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

    # [[[ CONSTANTS ]]]
    use constant PI => my number $TYPED_PI = 3.141_592_654;

    # [[[ OPERATIONS ]]]
    my number $radius = 12.5;
    my number $circumference = 2 * PI() * $radius;

    print 'Pi = ', to_string(PI()), "\n";
    print 'Radius = ', to_string($radius), "\n";
    print 'Circumference = 2 * Pi * Radius = 2 * ', to_string(PI()), ' * ', to_string($radius), ' = ', to_string($circumference), "\n";

Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_1-circumference_of_specific_radius.pl 
    Pi = 3.141_592_654
    Radius = 12.5
    Circumference = 2 * Pi * Radius = 2 * 3.141_592_654 * 12.5 = 78.539_816_35

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 2

The goal of this exercise is to become familiar with accepting user keyboard input.X<br>

The third line in the C<CRITICS> section tells RPerl to allow user input via the C<E<lt>STDINE<gt>> standard stream, a software input connection which is attached to the keyboard by default.X<br>

The second line in the C<OPERATIONS> section creates a string variable C<$radius_string>, and assigns to it the text value typed by the user on their keyboard.X<br>

The third line in the C<OPERATIONS> section creates a number variable C<$radius>, and assigns to it the numeric value returned by calling the RPerl type conversion subroutine C<string_to_number()> on the string variable C<$radius_string>.X<br>

This exercise is otherwise identical to the previous exercise.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 2
    # Find the circumference of a circle with any radius entered by the user

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ CONSTANTS ]]]
    use constant PI => my number $TYPED_PI = 3.141_592_654;

    # [[[ OPERATIONS ]]]
    print 'Please input radius: ';
    my string $radius_string = <STDIN>;
    my number $radius = string_to_number($radius_string);
    my number $circumference = 2 * PI() * $radius;

    print "\n";
    print 'Pi = ', to_string(PI()), "\n";
    print 'Radius = ', to_string($radius), "\n";
    print 'Circumference = 2 * Pi * Radius = 2 * ', to_string(PI()), ' * ', to_string($radius), ' = ', to_string($circumference), "\n";

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_2-circumference_of_any_radius.pl 
    Please input radius: 2

    Pi = 3.141_592_654
    Radius = 2
    Circumference = 2 * Pi * Radius = 2 * 3.141_592_654 * 2 = 12.566_370_616

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 3

The goal of this exercise is to become familiar with conditional statements and comparison operators.X<br>

In the C<OPERATIONS> section, the line starting with C<if ($radius E<gt>= 0)> denotes the beginning of a conditional statement: if the numeric value of the variable C<$radius> is greater-than-or-equal-to 0, then the normal calculation for C<$circumference> is used; if C<$radius> is less than 0 (physically impossible), then a warning message is printed and C<$circumference> is set to 0.X<br>

This exercise is otherwise identical to the previous exercise.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 3
    # Find the circumference of a circle with any positive radius entered by the user

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ CONSTANTS ]]]
    use constant PI => my number $TYPED_PI = 3.141_592_654;

    # [[[ OPERATIONS ]]]
    print 'Please input radius: ';
    my string $radius_string = <STDIN>;
    my number $radius = string_to_number($radius_string);
    my number $circumference;

    if ($radius >= 0) {
        $circumference = 2 * PI() * $radius;
    }
    else {
        print 'Negative radius detected, defaulting to zero circumference!', "\n";
        $circumference = 0;
    }

    print "\n";
    print 'Pi = ', to_string(PI()), "\n";
    print 'Radius = ', to_string($radius), "\n";
    print 'Circumference = 2 * Pi * Radius = 2 * ', to_string(PI()), ' * ', to_string($radius), ' = ', to_string($circumference), "\n";

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_3-circumference_of_any_positive_radius.pl 
    Please input radius: -2
    Negative radius detected, defaulting to zero circumference!

    Pi = 3.141_592_654
    Radius = -2
    Circumference = 2 * Pi * Radius = 2 * 3.141_592_654 * -2 = 0

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 4

The goal of this exercise is to gain further exposure to the C<E<lt>STDINE<gt>> standard stream and variable multiplication.X<br>

In the C<OPERATIONS> section, C<E<lt>STDINE<gt>> is accessed to collect user input for both the C<$multiplicator_string> and C<$multiplicand_string> variables.X<br>

These 2 string variables are converted from text values to numeric values by calling C<string_to_number()>, then multiplied via the C<*> multiplication operator, and the results displayed by calling C<print>.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 4
    # Find the product of any two numbers entered by the user

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    print 'Please input multiplicator: ';
    my string $multiplicator_string = <STDIN>;
    my number $multiplicator = string_to_number($multiplicator_string);

    print 'Please input multiplicand: ';
    my string $multiplicand_string = <STDIN>;
    my number $multiplicand = string_to_number($multiplicand_string);

    my number $product = $multiplicator * $multiplicand;

    print "\n";
    print 'Product = Multiplicator * Multiplicand = ', to_string($multiplicator), ' * ', to_string($multiplicand), ' = ', to_string($product), "\n";

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_4-product_of_any_two_numbers.pl 
    Please input multiplicator: 2112
    Please input multiplicand: 23.42

    Product = Multiplicator * Multiplicand = 2_112 * 23.42 = 49_463.04

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 5

The goal of this exercise is to become familiar with the C<x> string repeat operator.X<br>

In the C<OPERATIONS> section, C<E<lt>STDINE<gt>> is accessed twice to collect user input for a string variable C<$repeat_string> to be repeated, and an integer variable C<$repeat_integer> to specify the number of repetitions.X<br>

The last line contains 2 operators, C<print> and the C<x> string repeat operator.X<br>

Like the C<.> (single dot) string concatenation operator, the C<x> operator has a higher precedence than C<print> and is thus executed first, generating a single string value comprised of the original string repeated 0 or more times, then the resulting string is displayed by calling C<print>.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 5
    # Repeat any string any number of times, both values entered by the user

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    print 'Please input string to be repeated: ';
    my string $repeat_string = <STDIN>;

    print 'Please input integer (whole number) times to repeat string: ';
    my string $repeat_integer_string = <STDIN>;
    my integer $repeat_integer = string_to_integer($repeat_integer_string);

    print "\n";
    print $repeat_string x $repeat_integer;


Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_5-string_repeat.pl 
    Please input string to be repeated: howdy
    Please input integer (whole number) times to repeat string: 3

    howdy
    howdy
    howdy

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 6

The goal of this exercise is to become familiar with the C<while> loop control structure.X<br>

In the C<OPERATIONS> section, C<E<lt>STDINE<gt>> is accessed to collect user input into the string variable C<$n_string>, then the data type conversion subroutine C<string_to_integer()> is called to create the corresponding integer variable C<$n>.X<br>

The C<if ($n E<lt> 0)> conditional control structure calls C<die> to exit with an error message if C<$n> is not a positive value.X<br>

Two additional integer variables are created: C<$sum> is initialized to 0 and will eventually hold the final answer value; and C<$i> is initialized to 0 for use as the iteration counter variable (AKA I<"iterator">) inside the following C<while> loop control structure.X<br>

The C<while> loop iteratively executes as long as the integer value of C<$i> is less-than-or-equal-to C<$n>.  Each iteration of the C<while> loop causes the value of C<$sum> to be increased by C<$i>, after which C<$i> itself is incremented by 1, and the loop is repeated.X<br>

The last line calls C<print>, the C<to_string()> conversion subroutine, and the C<.> (single dot) string concatenation operator to display the final answer.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 6
    # Calculate the sum of the first n integers; 1 + 2 + 3 + ... + n = ?

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    print 'Please input a positive integer: ';
    my string $n_string = <STDIN>;
    my integer $n = string_to_integer($n_string);

    if ($n < 0) { die 'ERROR: ' . to_string($n) . ' is not positive, dying' . "\n"; }

    my integer $sum = 0;
    my integer $i = 1;

    while ($i <= $n) {
        $sum += $i;
        $i++;
    }

    print 'The sum of the first ', to_string($n), ' integers = ', to_string($sum), "\n";


Example executions, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_6-sum_of_first_n_integers.pl 
    Please input a positive integer: 100
    The sum of the first 100 integers = 5_050

    $ rperl -t LearningRPerl/Chapter2/exercise_6-sum_of_first_n_integers.pl 
    Please input a positive integer: -100
    ERROR: -100 is not positive, dying

=for rperl X</noncode>

X<br>


=head2 Chapter 2, Exercise 7

The goal of this exercise is to utilize an optimization to remove the C<while> loop from the previous exercise.X<br>

In the C<OPERATIONS> section, user input is collected and error-checked, as before.X<br>

By utilizing an algorithm attributed to Gauss, we are able to remove the C<while> loop, so we also remove the C<$i> loop iterator.  The C<$sum> variable is kept the same as the previous exercise.X<br>

Two new integer variables are also created: C<$n_original> is initialized to hold a copy of C<$n> which will never change; and C<$n_odd> is initialized to 0.X<br>

The code block beginning with C<if ($n % 2)> is used to detect if the user provided a value for C<$n> which is odd (not even), this is detected by utilizing the C<%> modulo operator to test for a remainder of dividing C<$n> by 2.  If C<$n> is odd, then a second copy of the original value of C<$n> is stored in C<$n_odd>, after which C<$n> itself is decremented by 1.  This C<if> statement allows our algorithm to accept odd as well as even user input values for C<$n>.X<br>

The computational kernel (most important part) is the one line of arithmetic: C<$sum = (($n + 1) * ($n / 2)) + $n_odd;>X<br>

It is said that as a child, Gauss was punished by his teacher by being told to mentally add together all the numbers from 1 to 100.  Young Gauss realized that 1 plus 100 is 101, and 2 plus 99 is also 101, as well as 3 plus 98 and so forth.  All the numbers may be paired to equal 101, and there are 50 such pairs, so the final answer is 101 multiplied by 50.  Thus, with a bit more thought Gauss was able to achieve the answer of 5,050 and perplex his teacher in the process.X<br>

Our arithmetic generalizes the idea of young Gauss by using C<$n> instead of 100, and by adding C<$n_odd> to enable support for odd values of C<$n>.  Using Gauss' own example of C<$n> equal to 100, which is even (not odd) so C<$n_odd> will equal 0, we can see the algorithm becomes: C<$sum = ((100 + 1) * (100 / 2)) + 0;>X<br>

One more step of arithmetic simplification shows our algorithm to be the same as Gauss': C<$sum = 101 * 50;>X<br>

The last line calls C<print> using the value of C<$n_original>, because the value of C<$n> will have been decreased by 1 if C<$n> is odd.X<br>

It is usually faster to run an algorithm without a loop than with a loop, because you are only doing 1 thing instead of many things.  However, not all problems can be easily optimized by changing to a new algorithm, because it may be prohibitively complex or there may only be 1 known algorithm.  In this case, Gauss' algorithm should be faster than the C<while> loop algorithm, expecially for very large values of C<$n>.  It may be possible to further optimize this exercise by utilizing bitwise operators to replace the modulo and division operators.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 2, Exercise 7
    # Calculate the sum of the first n integers, without using a loop; 1 + 2 + 3 + ... + n = ?

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    print 'Please input a positive integer: ';
    my string $n_string = <STDIN>;
    my integer $n = string_to_integer($n_string);

    if ($n < 0) { die 'ERROR: ' . to_string($n) . ' is not positive, dying' . "\n"; }

    my integer $sum = 0;
    my integer $n_original = $n;
    my integer $n_odd = 0;

    if ($n % 2) {
        $n_odd = $n;
        $n--;
    }

    $sum = (($n + 1) * ($n / 2)) + $n_odd;

    print 'The sum of the first ', to_string($n_original), ' integers = ', to_string($sum), "\n";


Example executions, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter2/exercise_7-sum_of_first_n_integers_no_loop.pl 
    Please input a positive integer: 100
    The sum of the first 100 integers = 5_050

    $ rperl -t LearningRPerl/Chapter2/exercise_7-sum_of_first_n_integers_no_loop.pl 
    Please input a positive integer: -100
    ERROR: -100 is not positive, dying

=for rperl X</noncode>

X<br>


=head2 Chapter 3, Exercise 1

The goal of this exercise is to become familiar with the C<foreach> loop control structure, arrays, and array operators; and to become further familiarized with the C<while> loop.X<br>

The first line in the C<OPERATIONS> section declares a new variable C<$input_strings> of type C<string_arrayref>, which is capable of storing 0 or more individual string values, and C<$input_strings> is then initialized to contain the empty set C<[]>.X<br>

The line starting with C<while (my string $input_string = E<lt>STDINE<gt>)> denotes the beginning of an iterative (repeating) loop statement, which continues to accept and store user input until CTRL-D is pressed to indicate the EOF (end-of-file) condition, also known as EOT (end-of-transmission).X<br>

A new copy of the variable C<$input_string> is created and assigned the value of collected user input by calling C<E<lt>STDINE<gt>> at the start of each loop iteration; the C<my> operator is evaluated as a true condition and the loop repeats, until CTRL-D is received and the C<my> operator returns a false condition.X<br>

Inside the body of the C<while> loop is 1 line calling the C<push> operator, which appends the current iteration's value of C<$input_string> onto the list of strings contained in C<$input_strings>.X<br>

The C<@{...}> (at-sign-curly-braces) is the array dereference operator, which exists because in Perl it is still sometimes necessary to directly access an array by value, instead of the RPerl method of indirectly accessing the array by reference, such as is required by the C<push> operator.X<br>

The line starting with C<my string_arrayref $input_strings_reversed> declares another array of string values C<input_strings_reversed>, and then assigns it the strings contained within the first array C<$input_strings> in reversed order, as returned by calling the C<reverse> operator.X<br>

As with the C<push> operator, the C<reverse> operator requires its argument to be dereferenced using C<@{...}>; another dereferenced array value is returned by C<reverse>, and an array reference is returned by enclosing C<reverse> and its argument inside the C<[...]> (square brackets) array reference operator.X<br>

Finally, the line starting with C<foreach my string $input_strings_reversed_element> denotes the beginning of another loop statement, which iterates the value of C<$input_strings_reversed_element> once for each string value contained in the C<$input_strings_reversed> array; C<print> is called inside the loop body to display the original input strings in reverse order.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 3, Exercise 1
    # Print user-supplied list of strings in reverse order

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    my string_arrayref $input_strings = [];

    print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:', "\n";

    while (my string $input_string = <STDIN>) {
        push @{$input_strings}, $input_string;
    }

    print "\n";
    print 'Strings in reverse order:', "\n";

    my string_arrayref $input_strings_reversed = [reverse @{$input_strings}];

    foreach my string $input_strings_reversed_element (@{$input_strings_reversed}) {
        print $input_strings_reversed_element;
    }

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter3/exercise_1-stdin_strings_reverse.pl 
    Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:
    howdy
    doody
    buffalo
    bob
    clarabell
    clown

    Strings in reverse order:
    clown
    clarabell
    bob
    buffalo
    doody
    howdy

=for rperl X</noncode>

X<br>


=head2 Chapter 3, Exercise 2

The goal of this exercise is to become familiar with utilizing array indices.X<br>

The first line in the C<OPERATIONS> section declares a new variable C<$flintstones_and_rubbles> of type C<string_arrayref>, which is then initialized to contain a C<qw()> (quoted word) set of names including the string element 'fred' at array index 0, 'betty' at array index 1, and so on.X<br>

The second line in C<OPERATIONS> creates an empty array of integers C<$input_indices>, and the following C<while> loop uses the C<push> operator to fill C<$input_indices> with integers entered by the user.X<br>

The C<foreach> loop iterates through all the user input integers, placing each in the variable C<$input_index>.X<br>

Inside the C<foreach> loop, the variable C<$input_index> is used to access the individual names inside the variable C<$flintstones_and_rubbles>.X<br>

In Perl, all array indices start at 0 instead of 1, so we must first subtract 1 from C<$input_index> before accessing the individual string elements of C<$flintstones_and_rubbles>.X<br>

Thus, if a user inputs the integer 1, the array index will be 0, which is 'fred'; similarly, user input 5 will access array index 4 which is 'wilma'.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 3, Exercise 2
    # Print string array elements indexed by user-supplied integers

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]
    my string_arrayref $flintstones_and_rubbles = [qw(fred betty barney dino wilma pebbles bamm-bamm)];
    my integer_arrayref $input_indices          = [];

    print 'Please input zero or more integers with values ranging from 1 to 7, separated by <ENTER>, ended by <CTRL-D>:', "\n";

    while ( my string $input_string = <STDIN> ) {
        push @{$input_indices}, string_to_integer($input_string);
    }

    print "\n";
    print 'Flintstones & Rubbles:', "\n";

    foreach my integer $input_index ( @{$input_indices} ) {
        print $flintstones_and_rubbles->[ ( $input_index - 1 ) ], "\n";
    }

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter3/exercise_2-stdin_array_indices.pl 
    Please input zero or more integers with values ranging from 1 to 7, separated by <ENTER>, ended by <CTRL-D>:
    2
    5
    3
    6
    5
    1
    2
    7
    4
    4

    Flintstones & Rubbles:
    betty
    wilma
    barney
    pebbles
    wilma
    fred
    betty
    bamm-bamm
    dino
    dino

=for rperl X</noncode>

X<br>


=head2 Chapter 3, Exercise 3

The goal of this exercise is to become familiar with the C<sort> and C<chomp> operators.X<br>

In the C<CONSTANTS> section, a constant C<SINGLE_LINE_OUTPUT> is created and set to 0, which will cause the program's output to be displayed on multiple lines.  If C<SINGLE_LINE_OUTPUT> is instead set to 1, the program's output will be displayed on one line.X<br>

In the C<OPERATIONS> section, a C<while> loop is used to fill the array variable C<$input_strings> with data supplied by the user.X<br>

The C<sort> operator is then called to fill the C<$input_strings_sorted> array with the same data in ASCII alphabetical order.X<br>

Last, a C<foreach> loop is used to print the sorted output by storing and accessing one string at a time in the variable C<$input_strings_sorted_element>.X<br>

An C<if> conditional statement inside the C<foreach> loop tests the constant C<SINGLE_LINE_OUTPUT>; if the condition is true, then the C<chomp> operator is called to remove the newline character from each string element and replace it with a normal blank space character, thereby displaying all the elements on a single line of output.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 3, Exercise 3
    # Print user-supplied list of strings in ASCIIbetical order, optionally on single line of output

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ CONSTANTS ]]]
    use constant SINGLE_LINE_OUTPUT => my boolean $TYPED_SINGLE_LINE_OUTPUT = 0;

    # [[[ OPERATIONS ]]]
    my string_arrayref $input_strings = [];

    print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:', "\n";

    while ( my string $input_string = <STDIN> ) {
        push @{$input_strings}, $input_string;
    }

    print "\n";
    print 'Strings in ASCIIbetical order:', "\n";

    my string_arrayref $input_strings_sorted = [ sort @{$input_strings} ];

    foreach my string $input_strings_sorted_element ( @{$input_strings_sorted} ) {
        if ( SINGLE_LINE_OUTPUT() ) {

            # strip trailing newline, if present
            chomp $input_strings_sorted_element;
            $input_strings_sorted_element .= q{ };
        }

        print $input_strings_sorted_element;
    }

    print "\n";

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter3/exercise_3-stdin_strings_sort.pl 
    Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:
    howdy
    doody
    buffalo
    bob
    clarabell
    clown

    Strings in ASCIIbetical order:
    bob
    buffalo
    clarabell
    clown
    doody
    howdy

=for rperl X</noncode>

X<br>


=head2 Chapter 4, Exercise 1

The goal of this exercise is to become familiar with user-defined subroutines.X<br>

In the C<SUBROUTINES> section, one subroutine C<total()> is defined, which accepts as input one argument variable C<$input_numbers> of type C<number_arrayref>, and which also has a C<number> return value stored in the variable C<$retval>.X<br>

Inside the C<total()> subroutine, the return value is initialized to 0 in C<$retval>, then a C<foreach> loop iteratively adds the elements of the array C<$input_numbers> to C<$retval>, after which the value of C<$retval> is returned to original external caller of C<total()>.X<br>

By itself, a subroutine such as C<total()> does not actually do anything; every subroutine must first be called either by some other subroutine or in the C<OPERATIONS> section.X<br>

In C<OPERATIONS>, a 5-element array is created and stored in the variable C<$fred>, which is then passed as input to the subroutine C<total()>, and the return value is displayed using the variable C<$fred_total> and the C<print> operator.X<br>

Next, a C<while> loop and C<E<lt>STDINE<gt>> are used to collect user input strings, which are then converted to numeric data values using the C<string_to_number()> subroutine, and stored in the array C<$input_numbers> using the C<push> operator.X<br>

Finally, the subroutine C<total()> is called a second time, now with the variable C<$input_numbers> passed as the input argument, and the return value is displayed using the variable C<$user_total>.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 4, Exercise 1
    # Subroutine & driver to calculate the totals of arrays of stringified numbers, both hard-coded and user-supplied

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our number $total = sub {
        (my number_arrayref $input_numbers) = @_;
        my number $retval = 0;
        foreach my number $input_number (@{$input_numbers}) {
            $retval += $input_number;
        }
        return $retval;
    };

    # [[[ OPERATIONS ]]]

    my number_arrayref $fred = [1, 3, 5, 7, 9];
    my number $fred_total = total($fred);
    print 'The total of $fred is ', to_string($fred_total), "\n";

    print 'Please input zero or more numbers, separated by <ENTER>, ended by <CTRL-D>:', "\n";

    my number_arrayref $input_numbers = [];
    while (my string $input_string = <STDIN>) {
        push @{$input_numbers}, string_to_number($input_string);
    }

    my number $user_total = total($input_numbers);
    print 'The total of those numbers is ', to_string($user_total), "\n";

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter4/exercise_1-subroutine_total.pl 
    The total of $fred is 25
    Please input zero or more numbers, separated by <ENTER>, ended by <CTRL-D>:
    21.12
    23.42
    1701.877
    -123.456
    The total of those numbers is 1_622.961

=for rperl X</noncode>

X<br>


=head2 Chapter 4, Exercise 2

The goal of this exercise is to become familiar with the C<..> range operator.X<br>

In the C<SUBROUTINES> section, the same subroutine C<total()> is defined as in the previous exercise.X<br>

In the C<OPERATIONS> section, an array of numbers is created and stored in the variable C<$one_to_one_thousand>.X<br>

Upon execution, there will be 1,000 number elements in the array, which are automatically created by the C<..> range operator.X<br>

The actual elements stored the array variable C<$one_to_one_thousand> start with C<[1, 2, 3, 4> and end with C<997, 998, 999, 1_000]>.X<br>

Finally, the subroutine C<total()> is called with C<$one_to_one_thousand> passed as the input argument, and the return value is displayed using the variable C<$one_to_one_thousand_total>.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 4, Exercise 2
    # Subroutine & driver to calculate the total of 1 to 1,000

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]

    our number $total = sub {
        ( my number_arrayref $input_numbers ) = @_;
        my number $retval = 0;
        foreach my number $input_number ( @{$input_numbers} ) {
            $retval += $input_number;
        }
        return $retval;
    };

    # [[[ OPERATIONS ]]]

    my number_arrayref $one_to_one_thousand = [ 1 .. 1_000 ];
    my number $one_to_one_thousand_total    = total($one_to_one_thousand);
    print 'The total of 1 to 1_000 is ', to_string($one_to_one_thousand_total), q{.}, "\n";


Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter4/exercise_2-subroutine_total_1000.pl 
    The total of 1 to 1000 is 500_500.

=for rperl X</noncode>

X<br>


=head2 Chapter 4, Exercise 3

The goal of this exercise is to become familiar with calling user-defined subroutines from one another.X<br>

In the C<SUBROUTINES> section, 3 subroutines are defined: C<total()> (same as previous exercises), C<average()>, and C<above_average()>.X<br>

Inside the subroutine C<average()> is a call to the subroutine C<total()>; there is also a call to the C<scalar> operator, which returns the count of elements inside the array C<$input_numbers>.  When the return value of C<total()> is divided by that of C<scalar>, the result is computation of the numeric mean (average) of all elements of C<$input_numbers>.X<br>

Inside C<above_average()> is a call to the subroutine C<average()>, with the return value stored in the variable C<$average>.  An empty array is created in the variable C<$retval>, then a C<foreach> loop iterates over all elements in C<$input_numbers> and an C<if> conditional statement makes a copy of all elements which are greater than C<$average>.  All above-average elements are returned as an array in C<$retval>.X<br>

In the C<OPERATIONS> section, 2 arrays are created in the C<$fred> and C<$barney> variables, which are then passed as input arguments to 2 calls to the subroutine C<above_average()>, and the results are displayed.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 4, Exercise 3
    # Subroutines & driver to calculate the above-average elements of hard-coded arrays

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our number $total = sub {
        ( my number_arrayref $input_numbers ) = @_;
        my number $retval = 0;
        foreach my number $input_number ( @{$input_numbers} ) {
            $retval += $input_number;
        }
        return $retval;
    };  

    our number $average = sub {
        ( my number_arrayref $input_numbers ) = @_;
        return (total($input_numbers) / (scalar @{$input_numbers}));
    };

    our number_arrayref $above_average = sub {
        ( my number_arrayref $input_numbers ) = @_;
        my number $average = average($input_numbers);
        my number_arrayref $retval = [];
        foreach my number $input_number (@{$input_numbers}) {
            if ($input_number > $average) {
                push @{$retval}, $input_number;
            }
        }
        return $retval;
    };

    # [[[ OPERATIONS ]]]

    my string_arrayref $fred = [1 .. 10];
    my number $fred_above_average = above_average($fred);
    print '$fred is ', number_arrayref_to_string($fred), "\n";
    print 'The above-average elements of $fred are ', number_arrayref_to_string($fred_above_average), "\n";
    print '(Should be [6, 7, 8, 9, 10])', "\n\n";

    my string_arrayref $barney = [100, 1 .. 10];
    my number $barney_above_average = above_average($barney);
    print '$barney is ', number_arrayref_to_string($barney), "\n";
    print 'The above-average elements of $barney are ', number_arrayref_to_string($barney_above_average), "\n";
    print '(Should be just [100])', "\n";

Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter4/exercise_3-subroutine_above_average.pl 
    $fred is [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    The above-average elements of $fred are [6, 7, 8, 9, 10]
    (Should be [6, 7, 8, 9, 10])

    $barney is [100, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    The above-average elements of $barney are [100]
    (Should be just [100])

=for rperl X</noncode>

X<br>


=head2 Chapter 4, Exercise 4

The goal of this exercise is to become familiar with program state.X<br>

As a program executes, there may be one or more variables in the C<OPERATIONS> section which store information that is important to the overall program; these variables are collectively known as the I<"state"> of the program.X<br>

In the C<OPERATIONS> section, a string variable C<$previous_name> is created and set to the empty string C<q{}>; this 1 variable is the state of the program.X<br>

Each of the 4 following lines in the C<OPERATIONS> section utilize the program state by both reading from and writing to the variable C<$previous_name>; the calls to the subroutine C<greet()> read from C<$previous_name> as the 2nd argument, and the return value of C<greet()> is then written to C<$previous_name> by the C<=> assignment operator.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<greet()> is defined which accepts 2 string arguments, the variables C<$name> and C<$previous_name>.X<br>

Inside C<greet()>, a personalized greeting is displayed for the virtual person represented by the variable C<$name>, after which an C<if() else> conditional statement checks if there is any data inside C<$previous_name> and further displays a customized comment about the state of the program.  The state variable C<$previous_name> is used to represent the very simple state of virtual people who have already been greeted.X<br>

Finally, the string variable C<$name> is returned from C<greet()> and passed to the C<=> assignment operators in the C<OPERATIONS> section, thereby updating the program state variable C<$previous_name> to contain the value of C<$name>.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 4, Exercise 4
    # Subroutine & driver to greet users

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]

    our string $greet = sub {
        ( my string $name, my string $previous_name ) = @_;
        print 'Hi ', $name, '!  ';
        if ($previous_name eq q{}) {
            print 'You are the first one here!', "\n";
        }
        else {
            print $previous_name, ' is also here!', "\n";
        }
        return $name;
    };

    # [[[ OPERATIONS ]]]

    my string $previous_name = q{};
    $previous_name = greet('Fred', $previous_name);
    $previous_name = greet('Barney', $previous_name);
    $previous_name = greet('Wilma', $previous_name);
    $previous_name = greet('Betty', $previous_name);

Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter4/exercise_4-subroutine_greet.pl 
    Hi Fred!  You are the first one here!
    Hi Barney!  Fred is also here!
    Hi Wilma!  Barney is also here!
    Hi Betty!  Wilma is also here!

=for rperl X</noncode>

X<br>


=head2 Chapter 4, Exercise 5

The goal of this exercise is to become further familiarized with program state.X<br>

In the C<OPERATIONS> section, the state variable C<$previous_names> is an array of strings representing all previous virtual people who have been greeted.X<br>

In the C<SUBROUTINES> section, the subroutine C<greet()> prints the names of previously-greeted virtual people on one line, separated by spaces, by using the C<join> operator.X<br>

Finally, the current value of C<$name> is appended as the last element of the array C<$previous_names> by the C<push> operator, and C<$previous_names> is then returned by C<greet()> to update the program state.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 4, Exercise 5
    # Subroutine & driver to greet multiple users

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]

    our string_arrayref $greet = sub {
        ( my string $name, my string_arrayref $previous_names ) = @_;
        print 'Hi ', $name, '!  ';
        if ((scalar @{$previous_names}) == 0) {
            print 'You are the first one here!', "\n";
        }
        else {
            print q{I've seen: }, (join q{ }, @{$previous_names}), "\n";
        }
        push @{$previous_names}, $name;
        return $previous_names;
    };

    # [[[ OPERATIONS ]]]

    my string_arrayref $previous_names = [];
    $previous_names = greet('Fred', $previous_names);
    $previous_names = greet('Barney', $previous_names);
    $previous_names = greet('Wilma', $previous_names);
    $previous_names = greet('Betty', $previous_names);

Example execution and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter4/exercise_5-subroutine_greet_multiple.pl 
    Hi Fred!  You are the first one here!
    Hi Barney!  I've seen: Fred
    Hi Wilma!  I've seen: Fred Barney
    Hi Betty!  I've seen: Fred Barney Wilma

=for rperl X</noncode>

X<br>


=head2 Chapter 5, Exercise 1

The goal of this exercise is to become familiar with file test operators, as well as opening, closing, and reading from a file.X<br>

In the C<CRITICS> section, the C<ProhibitPostfixControls> critic is disabled due to a bug in Perl::Critic and/or PPI which causes a false error.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<tac()> is defined which accepts as input an array of file names received via the operating system's command-line arguments, and which has a C<void> return value, meaning there is no return value for this subroutine.X<br>

Inside C<tac()>, the C<reverse> operator is called to reverse the order of the command-line arguments; for example, if the 3 file names C<fred barney betty> are given as command-line arguments, then C<reverse> causes the 3 strings C<betty barney fred> to be stored in the array variable C<$command_line_arguments>.X<br>

The outer C<foreach> loop iterates through each C<$file_name> in the now-reversed C<$command_line_arguments>.X<br>

Next, 4 file test operators are called, to ensure each input file exists via C<-e>, is readable via C<-r>, is a regular (not special device) file via C<-f>, and is comprised of plain text via C<-T>.X<br>

The operator C<open> is called with the C<E<lt>> file input (read-only) argument, which opens each C<$file_name> for reading via the C<$FILE> filehandle variable.X<br>

The inner C<while> loop reads in all lines from the current C<$FILE> filehandle using the C<E<lt>$FILEE<gt>> syntax (similar to C<E<lt>STDINE<gt>>) and stores the input file's lines in the string array variable C<$file_lines>; then, the C<reverse> operator is called again to reverse the order of the newly-read file lines.X<br>

Finally, the inner C<foreach> loop displays the now-reversed C<$file_lines>, and the C<close> operator is called to close the C<$FILE> filehandle so no more file access will occur for the current C<$file_name>.X<br>

In the C<OPERATIONS> section, the C<tac()> subroutine is called with its only argument being a reference to the special C<@ARGV> array, which is Perl's way of accessing the command-line arguments.X<br>

Before executing this program, the non-Perl C<`printf`> program must be called to populate some test data into the 3 input files F<fred>, F<barney>, and F<betty>; and after execution the C<`rm`> program is called to delete the 3 input files.X<br>

To begin execution of this program via the C<`rperl`> command, the program name and input file names must be enclosed in either C<'single quotes'> or C<"double quotes">; this tells RPerl the input file names are command-line arguments to be passed to the 1 specified program, instead of specifying additional RPerl programs.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 5, Exercise 1
    # Accept one or more input files, and print their contents line-by-line in reverse order

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

    # [[[ SUBROUTINES ]]]

    our void $tac = sub {
        ( my string_arrayref $command_line_arguments ) = @_;
        $command_line_arguments = [ reverse @{$command_line_arguments} ];
        foreach my string $file_name ( @{$command_line_arguments} ) {
            if ( not( -e $file_name ) ) {
                croak 'ERROR: File ', $file_name, ' does not exist, croaking';
            }
            if ( not( -r $file_name ) ) {
                croak 'ERROR: File ', $file_name, ' is not readable, croaking';
            }
            if ( not( -f $file_name ) ) {
                croak 'ERROR: File ', $file_name, ' is not a regular file, croaking';
            }
            if ( not( -T $file_name ) ) {
                croak 'ERROR: File ', $file_name, ' is (probably) not text, croaking';
            }

            my integer $open_success = open my filehandleref $FILE, '<', $file_name;
            if ( not $open_success ) {
                croak 'ERROR: Failed to open file ', $file_name, ' for reading, croaking';
            }

            my string_arrayref $file_lines = [];

            while ( my string $file_line = <$FILE> ) {
                push @{$file_lines}, $file_line;
            }

            $file_lines = [ reverse @{$file_lines} ];

            foreach my string $file_line ( @{$file_lines} ) {
                print $file_line;
            }

            if ( not close $FILE ) {
                croak 'ERROR: Failed to close file ', $file_name, ' after reading, croaking';
            }
        }
    };

    # [[[ OPERATIONS ]]]

    tac( [@ARGV] );

Example execution, input, and output:

=for rperl X<noncode>

    $ printf "fred0\nfred1\nfred2\nfred3\nfred4\n" > fred
    $ printf "barney0\nbarney1\nbarney2\n" > barney
    $ printf "betty0\nbetty1\nbetty2\nbetty3\n" > betty
    $ rperl -t 'LearningRPerl/Chapter5/exercise_1-tac.pl fred barney betty'
    betty3
    betty2
    betty1
    betty0
    barney2
    barney1
    barney0
    fred4
    fred3
    fred2
    fred1
    fred0
    $ rm fred barney betty

=for rperl X</noncode>

X<br>


=head2 Chapter 5, Exercise 2

The goal of this exercise is to become familiar with the string C<length> operator and basic text formatting.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<right_justify_20()> is defined, which accepts no input arguments and returns no values.X<br>

Inside C<right_justify_20()>, an empty array of strings is initialized in the C<$input_strings> variable, which is then populated with strings in a C<while> loop collecting user input from C<E<lt>STDINE<gt>>.X<br>

The C<x> string repeat operator is called to create a 60-character-wide horizontal ruler, which is then displayed by the C<print> operator.X<br>

Finally, a C<foreach> loop iterates through each C<$input_string> and calls the C<length> operator, thereby determining the correct number of spaces to prepend in order to achieve right justification alignment to the 20th character column.  The C<-> subtraction operator is passed a hard-coded column width of 20, and the C<chomp> operator is called to remove any trailing newline characters which may be appended when the user presses the ENTER key after each input word.X<br>

In the C<OPERATIONS> section, the only operation is a call to the C<right_justify_20()> subroutine.X<br>

X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 5, Exercise 2
    # Accept one or more input lines, and print them in a right-justified 20-column format

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our void $right_justify_20 = sub {
        my string_arrayref $input_strings = [];
        print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:', "\n";
        while ( my string $input_string = <STDIN> ) {
            push @{$input_strings}, $input_string;
        }

        print "\n";
        print '1234567890' x 6;
        print "\n";

        foreach my string $input_string ( @{$input_strings} ) {
            chomp $input_string;
            print q{ } x ( 20 - ( length $input_string ) );
            print $input_string, "\n";
        }
    };

    # [[[ OPERATIONS ]]]

    right_justify_20();


Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter5/exercise_2-right_justify.pl
    Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:
    howdy
    doody
    buffalo
    bob
    clarabell
    clown

    123456789012345678901234567890123456789012345678901234567890
                   howdy
                   doody
                 buffalo
                     bob
               clarabell
                   clown

=for rperl X</noncode>

X<br>


=head2 Chapter 5, Exercise 3

The goal of this exercise is to become further familiarized with basic text formatting.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<right_justify_variable()> is defined, which accepts no input arguments and returns no values.X<br>

Inside C<right_justify_variable()>, the user is prompted to input a custom right justify width, stored in the integer variable C<$column_width>.X<br>

The integer variable C<$ruler_width_tens> is used to determine the number of characters displayed for the ruler, by tens; the default value for C<$ruler_width_tens> is 6, which means a ruler width of 60 characters.  If the user-supplied C<$column_width> is greater than 60, we scale it by 1/10 and add 1, thereby creating a new value for C<$ruler_width_tens> which will always display a ruler wider than C<$column_width>.X<br> 

When the ruler is displayed, C<$ruler_width_tens> is passed to the C<x> string repeat operator instead of a hard-coded value of 6; likewise, when each C<$input_string> is right justified, the C<-> subtraction operator is passed C<$column_width> instead of a hard-coded value of 20.X<br>

In the C<OPERATIONS> section, the only operation is a call to the C<right_justify_variable()> subroutine.X<br>

This exercise is otherwise identical to the previous exercise.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 5, Exercise 3
    # Accept column width followed by one or more input lines, and print lines in a right-justified format

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our void $right_justify_variable = sub {
        my string_arrayref $input_strings = [];
        print 'Please input integer column width, then press <ENTER>:', "\n";
        my string $column_width_string = <STDIN>;
        my integer $column_width       = string_to_integer($column_width_string);

        print 'Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:', "\n";
        while ( my string $input_string = <STDIN> ) {
            push @{$input_strings}, $input_string;
        }

        my integer $ruler_width_tens = 6;    # default to ruler line width 60
        if ( $column_width > 60 ) {
            $ruler_width_tens = number_to_integer( $column_width / 10 ) + 1;
        }

        print "\n";
        print '1234567890' x $ruler_width_tens;
        print "\n";

        foreach my string $input_string ( @{$input_strings} ) {
            chomp $input_string;
            print q{ } x ( $column_width - ( length $input_string ) );
            print $input_string, "\n";
        }
    };

    # [[[ OPERATIONS ]]]

    right_justify_variable();

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter5/exercise_3-right_justify_variable.pl 
    Please input integer column width, then press <ENTER>:
    67
    Please input zero or more strings, separated by <ENTER>, ended by <CTRL-D>:
    howdy
    doody
    buffalo
    bob
    clarabell
    clown

    1234567890123456789012345678901234567890123456789012345678901234567890
                                                                  howdy
                                                                  doody
                                                                buffalo
                                                                    bob
                                                              clarabell
                                                                  clown

=for rperl X</noncode>

X<br>


=head2 Chapter 6, Exercise 1

The goal of this exercise is to become familiar with hash data structures and hash operators.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<given_to_family_name()> is defined, which accepts no input arguments and returns no values.X<br>

Inside C<given_to_family_name()>, a hash data structure is created in the variable C<$names>.  Another term for hash is associative array, because each hash is comprised of key-value pairs, and we say there is a value "associated" with every key.  Hash keys are bare words and must be unique, while hash values may be any specified data type and need not be unique.  The 3 keys in C<$names> are fred, barney, and wilma; the value of the key fred is 'flintstone'.X<br>

A first name is collected from the user by C<E<lt>STDINE<gt>> and stored in C<$given_name>, then the C<chomp> operator is called to remove the trailing newline recorded when the user presses the ENTER key.X<br>

An C<if> conditional statement calls the C<exists> and C<defined> operators to ensure the user has entered a valid hash key, and an error is returned if there is no such key in the C<$names> hash.X<br>

Finally, the thin-arrow syntax C<$names-E<gt>{$given_name}> is used to retrieve the hash value, and C<print> is called to display the family name outputs.X<br>

In the C<OPERATIONS> section, the only operation is a call to the C<given_to_family_name()> subroutine.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 6, Exercise 1
    # Accept one input given (first) name, and print the corresponding family (last) name

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our void $given_to_family_name = sub {
        my string_hashref $names = {
            fred => 'flintstone',
            barney => 'rubble',
            wilma => 'flintstone'
        };

        print 'Please input a given (first) name in all lowercase, then press <ENTER>:', "\n";
        my string $given_name = <STDIN>;
        chomp $given_name;

        if ((not exists $names->{$given_name}) or (not defined $names->{$given_name})) {
            croak 'ERROR: No family (last) name found for given (first) name ', $given_name, ', croaking', "\n";
        }

        print 'The family (last) name of ', $given_name, ' is ', $names->{$given_name}, q{.}, "\n";
    };

    # [[[ OPERATIONS ]]]

    given_to_family_name();

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter6/exercise_1-hash_family_names.pl 
    Please input a given (first) name in all lowercase, then press <ENTER>:
    fred
    The family (last) name of fred is flintstone.

    $ rperl -t LearningRPerl/Chapter6/exercise_1-hash_family_names.pl 
    Please input a given (first) name in all lowercase, then press <ENTER>:
    howdy
    ERROR: No family (last) name found for given (first) name howdy, croaking

=for rperl X</noncode>

X<br>


=head2 Chapter 6, Exercise 2

The goal of this exercise is to become further familiarized with hash data structures and hash operators.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<unique_word_count()> is defined, which accepts no input arguments and returns no values.X<br>

In C<unique_word_count()>, an empty hash of integer values is created in the variable C<$word_counts>; a C<while> loop then collects user input strings, inside of which an C<if() else> conditional statement updates the C<$word_counts> hash.  If a word is seen for the first time, then the corresponding C<$word_counts> hash value will be set to 1, otherwise the count value will be incremented by 1.X<br>

Finally, a C<foreach> loop iterates through the alphabetically-sorted keys of the C<$word_counts> hash by calling the C<sort> and C<keys> operators, then the thin-arrow hash value retrieval syntax C<$word_counts-E<gt>{$unique_word}> is called, and the C<print> operator displays the word count outputs.X<br>

In the C<OPERATIONS> section, the only operation is a call to the C<unique_word_count()> subroutine.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 6, Exercise 2
    # Accept a list of words, and print the count of each unique word

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ SUBROUTINES ]]]

    our void $unique_word_count = sub {
        my integer_hashref $word_counts = {};

        print 'Please input zero or more words, separated by <ENTER>, ended by <CTRL-D>:', "\n";
        while (my string $input_word = <STDIN>) {
            chomp $input_word;
            if (not exists $word_counts->{$input_word}) {
                $word_counts->{$input_word} = 1;
            }
            else {
                $word_counts->{$input_word} += 1;
            }
        }

        print "\n", 'Unique word count:', "\n";

        foreach my string $unique_word (sort keys %{$word_counts}) {
            print $unique_word, ' appeared ', to_string($word_counts->{$unique_word}), ' time(s)', "\n";
        }
    };

    # [[[ OPERATIONS ]]]

    unique_word_count();

Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter6/exercise_2-hash_unique_word_count.pl 
    Please input zero or more words, separated by <ENTER>, ended by <CTRL-D>:
    george
    jane
    judy
    elroy
    astro
    rosie
    george
    judy
    astro
    fred
    wilma
    barney
    betty
    pebbles
    bamm-bamm
    dino
    fred
    barney
    dino
    george
    fred
    barney
    astro
    dino
    jane
    judy
    betty
    wilma

    Unique word count:
    astro appeared 3 time(s)
    bamm-bamm appeared 1 time(s)
    barney appeared 3 time(s)
    betty appeared 2 time(s)
    dino appeared 3 time(s)
    elroy appeared 1 time(s)
    fred appeared 3 time(s)
    george appeared 3 time(s)
    jane appeared 2 time(s)
    judy appeared 3 time(s)
    pebbles appeared 1 time(s)
    rosie appeared 1 time(s)
    wilma appeared 2 time(s)

=for rperl X</noncode>

X<br>


=head2 Chapter 6, Exercise 3

The goal of this exercise is to become further familiarized with hash data structures and basic text formatting.X<br>

In the C<SUBROUTINES> section, 1 subroutine C<sort_env_vars()> is defined, which accepts no input arguments and returns no values.X<br>

Inside C<sort_env_vars()>, a hash of strings is created in the variable C<$env_vars>, and it is initialized to contain the values of the special C<%ENV> system hash, which stores the current user's environmental variables.X<br>

Next, 2 integer variables C<$env_var_length> and C<$left_column_width> are created, and C<$left_column_width> is initialized to the value 0.  A C<foreach> loop iterates through all environmental variables, measuring the string length of each C<$env_var> by the C<length> operator, and using an C<if> conditional statement to test if the current C<$env_var_length> is greater than the existing C<$left_column_width>.  If C<$env_var_length> is large enough, then C<$left_column_width> is updated, thereby resulting in the value of C<$left_column_width> being equal to the longest C<$env_var_length>.X<br>

After the C<foreach> loop, C<$left_column_width> is incremented by an additional 2 character widths, allowing for 2 or more spaces between the hash keys and their respective values when displayed.X<br>

Finally, there is another C<foreach> loop below the first, again iterating through all C<$env_vars>, and printing the keys at the beginning of each output line.  The C<-> subtraction operator is called to find the difference between the current key length and the pre-calculated C<$left_column_width>, then the C<x> string repeat operator is called to create the corresponding number of blank spaces as padding between the key and its value.  The thin-arrow hash value retrieval syntax C<$env_vars-E<gt>{$env_var}> is called, and the C<print> operator displays the hash value outputs.X<br>

In the C<OPERATIONS> section, the only operation is a call to the C<sort_env_vars()> subroutine.X<br>


    #!/usr/bin/perl

    # Learning RPerl, Chapter 6, Exercise 3
    # Print sorted environmental variables

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]

    our void $sort_env_vars = sub {
        my string_hashref $env_vars = {%ENV};

        my integer $env_var_length;
        my integer $left_column_width = 0;
        foreach my string $env_var ( sort keys %{$env_vars} ) {
            $env_var_length = length $env_var;
            if ( $env_var_length > $left_column_width ) {
                $left_column_width = $env_var_length;
            }
        }

        $left_column_width += 2;

        print 'Environmental variables:', "\n";

        foreach my string $env_var ( sort keys %{$env_vars} ) {
            print $env_var;
            print q{ } x ( $left_column_width - ( length $env_var ) );
            print $env_vars->{$env_var}, "\n";
        }
    };

    # [[[ OPERATIONS ]]]

    sort_env_vars();


Example execution, input, and output:

=for rperl X<noncode>

    $ rperl -t LearningRPerl/Chapter6/exercise_3-hash_sort_env_vars.pl 
    Environmental variables:
    COLORTERM                 xfce4-terminal
    DESKTOP_SESSION           xubuntu
    DISPLAY                   :0.0
    GDMSESSION                xubuntu
    GDM_LANG                  en_US
    HOME                      /home/jlpicard
    LANG                      en_US.UTF-8
    LANGUAGE                  en_US
    LOGNAME                   jlpicard
    PATH                      .:script:bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
    PERL5LIB                  blib/lib:lib:/home/jlpicard/perl5/lib/perl5
    PERL_LOCAL_LIB_ROOT       /home/jlpicard/perl5
    PERL_MB_OPT               --install_base "/home/jlpicard/perl5"
    PERL_MM_OPT               INSTALL_BASE=/home/jlpicard/perl5
    PWD                       /home/jlpicard
    SHELL                     /bin/bash
    TERM                      xterm
    USER                      jlpicard

=for rperl X</noncode>

X<br>


=for DEV NOTE, CORRELATION #rp029: all updates to `rperl` command-line arguments must be documented in script/rperl and 2 places in lib/RPerl/Learning.pm

=head1 APPENDIX B: RPERL COMMAND-LINE ARGUMENTS

The C<`rperl`> I<"command-line interface"> (CLI) is a software program which serves as the primary front-end user interface for RPerl.  When called for execution, the C<`rperl`> command must be provided with at least one input file name, which tells RPerl which file(s) to compile.  In addition, C<`rperl`> may also be provided with one or more optional I<"command-line arguments">, which tell RPerl how to behave and exactly how to compile the input file(s).  Command-line arguments are also commonly referred to as I<"options">, or in this specific context just I<"arguments">.

Command-line arguments which are listed as one of the I<"modes"> will modify the way RPerl compiles the input source code file(s).  All RPerl modes are written using the longhand format:

C<--mode foo=BAR>

Arguments which are listed as one of the I<"flags"> are written using the shorthand C<--foo> or even shorter C<-f> formats.  Most flags are shortcuts to common modes.

Flags and other non-mode arguments which are not shortcuts to common modes will either modify some non-compiling behavior of RPerl (such as enabling additional information output), or cause RPerl to do something other than fully execute and compile input source code files (such as displaying version information then exiting).

Below is a comprehensive list of all RPerl command-line arguments, as reported by the S<C<`rperl -?`>> command.

Additional explanations for each argument are provided I<with emphasis.>

=head2 B.1: Help

=over

=item B<--help ...OR... -h ...OR... -?>

=for rperl X<noncode>

    Print this (relatively) brief help message for command-line usage.
    For additional explanations, run the command `perldoc RPerl::Learning` and see Appendix B.

=for rperl X</noncode>

I<The help option simply displays the content of this appendix, except for the additional explanations such as this one.>

I<Yes, this is the "Appendix B" you're looking for.>

=back

=head2 B.2: Version

=over

=item B<--version ...OR... -v>

=item B<--vversion ...OR... -vv>

=for rperl X<noncode>

    Print version number and copyright information.
    Repeat as 'vv' for more technical information, similar to `perl -V` configuration summary argument.
    Lowercase 'v' not to be confused with uppercase 'V' in 'Verbose' argument.

=for rperl X</noncode>

I<The single-v version option displays a brief message similar to the output of the C<`perl -v`> command.>

I<The double-v version option displays a collection of technical information similar to the output of the C<`perl -V`> command, including subcompile flags for the C++ compiler and system paths.  This option may be useful to RPerl system develpers when debugging subcompile issues or other problems.>

=back

=head2 B.3: Input Files

=over

=item B<--infile=MyFile.pm ...OR... -i=MyFile.pm>

=for rperl X<noncode>

    Specify input file, may be repeated for multiple input files.
    Argument prefix '--infile' may be entirely omitted.
    Argument prefix MUST be omitted to specify wildcard for multiple input files.

=for rperl X</noncode>

I<The input file option tells RPerl which file(s) to compile, and is the only command-line argument which is always required every time the C<`rperl`> command is fully executed (not just C<`rperl -?`>, C<`rperl -v`>, etc).  Even if the argument prefix '--infile' is omitted for convenience, one or more input file names must still be specified to avoid an RPerl error message.>

I<All input files must end in '.pl' for RPerl programs, or '.pm' for RPerl modules.>

=back

=head2 B.4: Output Files

=over

=item B<--outfile=MyCompiledModule ...OR... -o=MyCompiledModule>

=item B<--outfile=my_compiled_program ...OR... -o=my_compiled_program>

=for rperl X<noncode>

    Specify output file prefix, may be repeated for multiple output files.
    RPerl *.pm input file with PERL ops will create MyCompiledModule.pmc output file.
    RPerl *.pl input file with PERL ops will create my_compiled_program (or my_compiled_program.exe on Windows) output file.
    RPerl *.pm input file with CPP  ops will create MyCompiledModule.pmc, MyCompiledModule.cpp, & MyCompiledModule.h output files.
    RPerl *.pl input file with CPP  ops will create my_compiled_program (or my_compiled_program.exe on Windows) & my_compiled_program.cpp output files.
    Argument may be entirely omitted, foo.* input file will default to foo.* output file(s).

=for rperl X</noncode>

I<The output file option tells RPerl which file(s) to generate by specifying a file prefix.  RPerl automatically determines the output file suffixes, depending upon the operations (AKA "ops") mode of either PERL or CPP.  The PERL ops mode is a test mode, so only Perl output files are generated; the CPP ops mode is a real compile mode, so C++ output files are generated.>

I<If the output file option is omitted, then the original prefix of each input file is used as the prefix of the output file, as one would expect.  For example, without an output file option provided, an input file named 'foo.pl' in CPP ops mode will generate the 'foo.cpp' and 'foo' (or 'foo.exe' in Windows) output files.  With an output file option of C<-o=bar> provided, the same 'foo.pl' input file will instead generate the 'bar.cpp' and 'bar' (or 'bar.exe') output files.>

=back

=head2 B.5: C++ Compiler

=over

=item B<--CXX=/path/to/compiler>

=for rperl X<noncode>

    Specify path to C++ compiler for use in subcompile modes, equivalent to '--mode CXX=/path/to/compiler' or 'CXX' manual Makefile argument, 'g++' by default.

=for rperl X</noncode>

I<The C++ compiler option tells RPerl which subcompiler to use for converting C++ source code into binary machine code.>

I<This option is a shorthand provided for brevity, please see: L</B.15: Modes, C++ Compiler>>

I<If both the shorthand and longhand forms of the C++ compiler option are omitted, then RPerl will utilize the GNU C++ compiler or give an error if it is not installed.>

=back

=head2 B.6: Modes, Operations

=over

=item B<--mode ops=PERL ...OR... -m ops=PERL>

=item B<--mode ops=CPP ...OR... -m ops=CPP>

=for rperl X<noncode>

    Specify operations mode, CPP by default.
    If set to PERL, generate Perl operations in the source code output file(s).
    If set to CPP, generate C++ operations in the source code output file(s).
    PERL ops mode forces PERL types mode & PARSE or GENERATE compile mode; PERLOPS_PERLTYPES is test mode, does not actually compile.

=for rperl X</noncode>

I<The two most important RPerl modes are "operations" (AKA "ops") and "data types" (AKA "types").>

I<The ops mode option tells RPerl if it should use Perl operations or C++ operations in the final output.  Perl operations are slow, but provide support for high-magic functionality.  C++ operations are fast, but only support low-magic functionality.>

I<Normal Perl is considered an interpreted language and uses Perl operations.  When an RPerl application is run in Perl operations mode, then the application is interpreted instead of compiled.  When an RPerl application runs in C++ operations mode, then it is compiled.>

=back

=head2 B.7: Modes, Types

=over

=item B<--mode types=PERL ...OR... -m types=PERL>

=item B<--mode types=CPP ...OR... -m types=CPP>

=item B<--mode types=DUAL ...OR... -m types=DUAL>

=for rperl X<noncode>

    Specify data types mode, CPP by default.
    If set to PERL, generate Perl data types in the source code output file(s).
    If set to CPP, generate C++ data types in the source code output file(s).
    If set to DUAL, generate both Perl and C++ data types in the source code output file(s).
    DUAL mode allows generate-once-compile-many types, selected by '#define __FOO__TYPES' in lib/rperltypes_mode.h or `gcc -D__FOO__TYPES` manual subcompile argument.

=for rperl X</noncode>

I<The types mode option tells RPerl if it should use Perl data types or C++ data types in the final output.  Just like RPerl's ops mode, Perl data types are slow and high-magic, while C++ types are fast and low-magic.>

I<Normal interpreted Perl uses Perl types (and Perl ops).  When an RPerl application is run in Perl types mode, then the application is compiled but only partial speed optimization is achieved.  When an RPerl application runs in C++ types mode, then it is compiled with full speed optimization.>

I<Because RPerl's first goal is performance, support for C++-ops-Perl-types mode and C++-ops-dual-types mode is limited to hand-compiled RPerl applications only, with full support planned for a future version release.  Meanwhile, the high-performance C++-ops-C++-types mode is currently supported for compiled RPerl applications, and the slow Perl-ops-Perl-types mode (AKA "test mode") is supported for testing purposes.>

=back

=head2 B.8: Modes, Integer Type

=over

=item B<--mode type_integer=LONG ...OR... -m type_integer=LONG>

=item B<--mode type_integer=LONG__LONG ...OR... -m type_integer=LONG__LONG>

=for rperl X<noncode>

    Specify native C++ integer data type, same as internal Perl type by default.
    If set to LONG, utilize 'long' as native type for 'integer', at least 32 bits;
    If set to LONG__LONG, utilize 'long long' as native type for 'integer', at least 64 bits.

=for rperl X</noncode>

I<The type_integer mode option tells RPerl which native C++ data type to use as the RPerl 'integer' data type when compiled in CPPOPS_CPPTYPES mode.>

I<According to the C language standard, 'long' will provide at least 32 bits of storage, and 'long long' will provide at least 64 bits.>

I<By default, RPerl will set this mode option to match the internal C data type used by the Perl interpreter itself, in order to produce the same output in both PERLTYPES and CPPTYPES modes.>

=back

=head2 B.9: Modes, Number Type

=over

=item B<--mode type_number=DOUBLE ...OR... -m type_number=DOUBLE>

=item B<--mode type_number=LONG__DOUBLE ...OR... -m type_number=LONG__DOUBLE>

=for rperl X<noncode>

    Specify native C++ number data type, same as internal Perl type by default.
    If set to DOUBLE, utilize 'double' as native type for 'number', usually at least 32 bits, but not guaranteed;
    If set to LONG__DOUBLE, utilize 'long double' as native type for 'number', usually at least 64 bits, but not guaranteed.

=for rperl X</noncode>

I<The type_number mode option tells RPerl which native C++ data type to use as the RPerl 'number' data type when compiled in CPPOPS_CPPTYPES mode.>

I<According to the C language standard, there is no guaranteed bit length for these data types, although 'long double' will not provide less storage than 'double'.>

I<On some systems, 'double' is 32 bits and 'long double' is 64 bits, while on other systems 'double' is 64 bits and 'long double' is 128 bits.  Every system is different, and other bit lengths may also be encountered.>

I<By default, RPerl will set this mode option to match the internal C data type used by the Perl interpreter itself, in order to produce the same output in both PERLTYPES and CPPTYPES modes.>

=back

=head2 B.10: Modes, Type Checking

=over

=item B<--mode check=OFF ...OR... -m check=OFF>

=item B<--mode check=ON ...OR... -m check=ON>

=item B<--mode check=TRACE ...OR... -m check=TRACE>

=for rperl X<noncode>

    Specify data type checking mode, TRACE by default.
    If set to OFF, do not perform dynamic type checking, only built-in C++ static type checking.
    If set to ON, perform dynamic type checking in addition to built-in C++ static type checking.
    If set to TRACE, perform dynamic type checking in addition to built-in C++ static type checking, with subroutine-and-variable trace information.

=for rperl X</noncode>

I<The data type checking mode option tells RPerl if it should perform additional tests to ensure correct data types are used as "subroutine arguments" (not to be confused with "command-line arguments").  RPerl subroutines can accept 1 or more arguments (AKA "parameters"), each of which must be of a specific data type.>

I<In C++-ops-C++-types mode, all data types must be determined at compile time and thus cannot change (AKA "static"), so the C++ compiler performs all necessary type checking.  In any Perl types mode, the data types can not be determined until runtime and thus can change (AKA "dynamic"), so RPerl must itself perform type checking for subroutine arguments.>

I<If the type checking mode is set to TRACE, then the name of the problematic subroutine and argument will be "traced" and provided in the RPerl error message.  This setting can be useful for RPerl application developers and debugging purposes.>

=back

=head2 B.11: Modes, Dependencies

=over

=item B<--mode dependencies=OFF ...OR... -m dependencies=OFF>

=item B<--mode dependencies=ON ...OR... -m dependencies=ON>

=for rperl X<noncode>

    Specify dependencies mode, ON by default.
    If set to OFF, do not search for or compile dependencies.
    If set to ON, recursively search for dependencies and subdependencies, include as additional input file(s).
    WARNING: Disabling dependencies will likely cause errors or undefined behavior.

=for rperl X</noncode>

I<The dependencies mode option tells RPerl if it should compile all the Perl application code which is used by the input RPerl application code via the C<use> operator.  If 1 RPerl application input file is provided which has 10 dependencies, and each of those 10 dependencies has 10 sub-dependencies of its own, then the RPerl compiler actually has at least 111 input files to compile, and possibly many more than 111 if any of the sub-dependencies has sub-sub-dependencies, etc.>

I<If your RPerl application depends upon other RPerl code, then all should go as planned.  If your RPerl application depends upon other non-RPerl code, then you will likely encounter problems as RPerl attempts to compile the non-RPerl components.>

I<If the dependencies mode option is set to OFF, then you will likely encounter problems as the compiled RPerl application attempts to locate the compiled form of each dependency, which will not be found unless manually compiled or copied from a previous compile.  Thus, disabling compilation of dependencies is strongly discouraged, because RPerl will not function properly if any dependency (or sub-dependency, etc) is not compiled.>

=back

=head2 B.12: Modes, Uncompile

=over

=item B<--mode uncompile=OFF ...OR... -m uncompile=OFF>

=item B<--mode uncompile=SOURCE ...OR... -m uncompile=SOURCE>

=item B<--mode uncompile=BINARY ...OR... -m uncompile=BINARY>

=item B<--mode uncompile=INLINE ...OR... -m uncompile=INLINE>

=item B<--mode uncompile=SOURCE_BINARY ...OR... -m uncompile=SOURCE_BINARY>

=item B<--mode uncompile=SOURCE_BINARY_INLINE ...OR... -m uncompile=SOURCE_BINARY_INLINE>

=for rperl X<noncode>

    Specify uncompile mode, OFF by default.
    If set to SOURCE, delete all generated C++ output source code (not subcompiled) files: *.cpp, *.h, *.pmc
    If set to BINARY, delete all generated C++ output binary (subcompiled) files: *.o, *.a, *.so, *.exe, non-suffixed executables
    If set to INLINE, delete all generated C++ output Inline::CPP files: _Inline/ directory
    If set to SOURCE_BINARY, delete both SOURCE and BINARY files.
    If set to SOURCE_BINARY_INLINE, delete SOURCE, BINARY, and INLINE files.
    For *.pm Perl module input files, BINARY and INLINE are equivalent.

=for rperl X</noncode>

I<The uncompile mode option tells RPerl if it should do the opposite of compiling, which is to delete any compiled files created by previous executions of RPerl.>

I<Many different files may be created each time RPerl is executed, which are separated into 3 different groups: human-readable RPerl source code files (AKA "SOURCE"), machine-readable RPerl binary files (AKA "BINARY"), and a mixture of both source and binary files created by the Inline software in the "_Inline" directory (AKA "INLINE").  It is recommended to delete all 3 groups using the "SOURCE_BINARY_INLINE" setting, to avoid possible problems with mismatching or partially-compiled components.>

I<RPerl will attempt to overwrite any files generated by previous RPerl executions, so it is generally unnecessary to explicitly use the uncompile option when executing RPerl multiple times with the same input file(s) each time.>

=back

=head2 B.13: Modes, Compile

=over

=item B<--mode compile=OFF ...OR... -m compile=OFF>

=item B<--mode compile=PARSE ...OR... -m compile=PARSE>

=item B<--mode compile=GENERATE ...OR... -m compile=GENERATE>

=item B<--mode compile=SAVE ...OR... -m compile=SAVE>

=item B<--mode compile=SUBCOMPILE ...OR... -m compile=SUBCOMPILE>

=for rperl X<noncode>

    Specify compile mode, SUBCOMPILE by default.
    If set to PARSE, begin with RPerl input source code file(s), and end with RPerl abstract syntax tree output data structure.
    If set to GENERATE, begin with RPerl input source code file(s), and end with RPerl and/or C++ output source code in memory.
    If set to SAVE, begin with RPerl input source code file(s), and end with RPerl and/or C++ output source code file(s) saved to disk.
    If set to SUBCOMPILE, begin with RPerl input source code file(s), and end with C++ output binary file(s).

=for rperl X</noncode>

I<The compile mode option tells RPerl how far to progress through the compile phase categories of "PARSE", "GENERATE", "SAVE", and "SUBCOMPILE".  As detailed in Section 2.3, there are multiple distinct phases for both parsing and saving, while generating and subcompiling are only one phase each.  The compile mode option groups all 3 parsing phases together as PARSE, and both saving phases as SAVE.>

I<The OFF, PARSE, and GENERATE phase categories may be useful for RPerl system developers while debugging the RPerl compiler itself.  No output files are saved to disk for these 3 phase categories, so they are not particularly useful for RPerl application developers.>

I<Both the SAVE and SUBCOMPILE phase categories save output files to disk, so they may be useful to RPerl application developers.  The SAVE phase category does not call the C++ compiler to perform subcompiling, which can be done manually by the developer if they so choose.>

=back

=head2 B.14: Modes, Subcompile

=over

=item B<--mode subcompile=OFF ...OR... -m subcompile=OFF>

=item B<--mode subcompile=ASSEMBLE ...OR... -m subcompile=ASSEMBLE>

=item B<--mode subcompile=ARCHIVE ...OR... -m subcompile=ARCHIVE>

=item B<--mode subcompile=SHARED ...OR... -m subcompile=SHARED>

=item B<--mode subcompile=STATIC ...OR... -m subcompile=STATIC>

=item B<--mode subcompile=DYNAMIC ...OR... -m subcompile=DYNAMIC>

=for rperl X<noncode>

    Specify subcompile mode, DYNAMIC by default.
    If set to ASSEMBLE, generate *.o object binary output file(s).
    If set to ARCHIVE, generate *.a object archive binary output file(s).
    If set to SHARED, generate *.so shared object binary output file(s).
    If set to STATIC, generate statically-linked *.exe or non-suffixed executable binary output file(s).
    If set to DYNAMIC, generate dynamically-linked *.exe or non-suffixed executable binary output file(s).

=for rperl X</noncode>

I<The subcompile mode option tells RPerl what output is desired from the C++ compiler.  This option is recommended for use by RPerl developers with prior C++ compiler experience.>

I<The "ASSEMBLE", "ARCHIVE", and "SHARED" subcompile modes will generate non-executable binary files from both *.pl RPerl program input files and *.pm RPerl module input files.  The generated binary files are reusable components; experienced RPerl and C++ developers may utilize the C++ compiler to "link" (combine) together multiple source and binary files in order to create a final binary output file.>

I<The "STATIC" subcompile mode is invalid for *.pm RPerl module input files; for *.pl RPerl programs, STATIC mode creates a binary executable which contains all necessary components included within 1 file.>

I<For *.pm input files, the "DYNAMIC" subcompile mode will use Inline and PMC file(s) to automatically interface between the compiled RPerl output and any non-compiled Perl code which calls the compiled output.  For *.pl input files, DYNAMIC mode creates a binary executable which does not contain all necessary components, and thus must search for external library files such as "libperl.a" or "libperl.so" during every execution.>

I<The C++ compiler and linker can be a bit complicated and confusing, one possible place to start learning more is the GCC compiler documentation:>

I<L<https://gcc.gnu.org/onlinedocs/gcc/Link-Options.html>>

=back

=head2 B.15: Modes, C++ Compiler

=over

=item B<--mode CXX=/path/to/compiler ...OR... -m CXX=/path/to/compiler>

=for rperl X<noncode>

    Specify path to C++ compiler for use in subcompile modes, equivalent to '--CXX=/path/to/compiler' or 'CXX' manual Makefile argument, 'g++' by default.

=for rperl X</noncode>

I<The C++ compiler mode option tells RPerl which C++ compiler to utilize throughout the various phases of compilation.  RPerl needs a C++ compiler to function in general, and a good C++ compiler is especially important during the subcompile phases.>

I<Use of the GNU C++ compiler C<`g++`> is strongly recommended, although in theory you should be able to use any C++ compiler which supports the C++11 standard.>

L<https://en.wikipedia.org/wiki/C++11>

=back

=head2 B.16: Modes, Parallelize

=over

=item B<--mode parallel=OFF ...OR... -m parallel=OFF>

=item B<--mode parallel=OPENMP ...OR... -m parallel=OPENMP>

=item B<--mode parallel=MPI ...OR... -m parallel=MPI>  ((( COMING SOON!!! )))

=item B<--mode parallel=OPENCL ...OR... -m parallel=OPENCL>  ((( COMING SOON!!! )))

=for rperl X<noncode>

    Specify automatic parallelization mode, OPENMP by default.
    If set to OFF, do not automatically parallelize any input files.
    If set to OPENMP, automatically parallelize all eligible input files for use on shared-memory OpenMP systems.
    If set to MPI (COMING SOON), automatically parallelize all eligible input files for use on distributed-memory MPI systems.
    If set to OPENCL (COMING SOON), automatically parallelize all eligible input files for use on heterogeneous or GPU systems.

=for rperl X</noncode>

I<The parallel mode option tells RPerl if it should automatically parallelize the RPerl input file(s) for faster runtime execution performance on parallel computing hardware platforms.>

I<The "OPENMP" parallel mode utilizes the OpenMP software to provide support for shared memory computing hardware platforms, such as multi-core CPUs and supercomputers.>

I<COMING SOON: The "MPI" parallel mode utilizes the MPI software to provide support for distributed memory computing hardware platforms, such as clusters and the cloud.>

I<COMING SOON: The "OPENCL" parallel mode utilizes the OpenCL software to provide support for heterogeneous computing hardware platforms, such as CPU/GPU combinations, GPUs, and FPGAs.>

=back

=head2 B.17: Modes, Parallelize, Number Of Cores

=over

=item B<--mode num_cores=2 ...OR... -m num_cores=2 ...OR... --num_cores=2 ...OR... -num=2>

=item B<--mode num_cores=4 ...OR... -m num_cores=4 ...OR... --num_cores=4 ...OR... -num=4>

=item B<--mode num_cores=8 ...OR... -m num_cores=8 ...OR... --num_cores=8 ...OR... -num=8>

=item B<...ETC...>

=for rperl X<noncode>

    Specify number of CPU cores to utilize for OPENMP automatic parallelization mode, 4 by default.

=for rperl X</noncode>

I<The num_cores mode option tells RPerl how many CPU cores to use during runtime execution of an auto-parallelized RPerl input file.>

I<This option is only applicable when the parallel mode option is set to "OPENMP", for use on shared memory computing hardware platforms.>

I<It may be best to choose a value which is a power of 2, although this is not required.>

=back

=head2 B.18: Modes, Execute

=over

=item B<--mode execute=OFF ...OR... -m execute=OFF>

=item B<--mode execute=ON ...OR... -m execute=ON>

=for rperl X<noncode>

    Specify execute mode, ON by default.
    If set to OFF, do not load or run any user-supplied program(s).
    If set to ON with one *.pl Perl program input file, load and run the program.
    If set to ON with more than one *.pl Perl program input file, do not load or run any programs.

=for rperl X</noncode>

I<The execute mode option tells RPerl if it should actually run a *.pl RPerl program input file, or just compile it without running.>

I<The default behavior for *.pl program files is to compile-then-execute, in order to provide a similar feel to normal Perl's interpret-while-executing behavior.>

I<When *.pm RPerl module input file(s) are provided, then no execution occurs because module files are not executable.>

=back

=head2 B.19: Modes, Source Code Labels

=over

=item B<--mode label=OFF ...OR... -m label=OFF>

=item B<--mode label=ON ...OR... -m label=ON>

=for rperl X<noncode>

    Specify source section label mode, ON by default.
    If set to OFF, generate minimal output source code, may save disk space.
    If set to ON, generate some informative labels in output source code, may be more human-readable.

=for rperl X</noncode>

I<The source code label mode option tells RPerl if it should create human-readable labels embedded as comments in the C++ output source code.  This option may be useful to RPerl system developers when comparing an RPerl application's original uncompiled source code input with the compiled C++ source code output.>

=back

=head2 B.20: Flags, Verbose

=over

=item B<--Verbose ...OR... -V>

=item B<--noVerbose ...OR... -noV>

=for rperl X<noncode>

    Include additional user information in output, or not.
    If enabled, equivalent to `export RPERL_VERBOSE=1` shell command.
    Disabled by default.
    Uppercase 'V' not to be confused with lowercase 'v' in 'version' argument.

=for rperl X</noncode>

I<The verbose flag option tells RPerl to display additional user-friendly information during various phases of compilation.>

I<Verbose output is generated using the C<RPerl::verbose()> RPerl system subroutine.>

I<If the verbose and debug flags are not enabled, then a problem-free RPerl compilation will produce no output whatsoever, in order to preserve the "*nix" tradition of displaying no unnecessary output during successful execution of system software.>

L<https://en.wikipedia.org/wiki/*nix>

=back

=head2 B.21: Flags, Debug

=over

=item B<--Debug ...OR... -D>

=item B<--noDebug ...OR... -noD>

=for rperl X<noncode>

    Include debugging & system diagnostic information in output, or not.
    If enabled, equivalent to `export RPERL_DEBUG=1` shell command.
    Disabled by default.
    Uppercase 'D' not to be confused with lowercase 'd' in 'dependencies' argument.

=for rperl X</noncode>

I<The debug flag option tells RPerl to display additional developer-friendly information during various phases of compilation.>

I<Debugging output is generated using the identical C<RPerl::debug()> & C<RPerl::diag()> RPerl system subroutines.>

I<Use of both the verbose and debug flags C<`rperl -V -D`> is recommended for RPerl system developers.>

=back

=head2 B.22: Flags, Warnings

=over

=item B<--Warnings ...OR... -W>

=item B<--noWarnings ...OR... -noW>

=for rperl X<noncode>

    Include system warnings in output, or not.
    If disabled, equivalent to `export RPERL_WARNINGS=0` shell command.
    Enabled by default.

=for rperl X</noncode>

I<The warnings flag option tells RPerl if it should display non-fatal warnings.>

I<The default behavior is that RPerl should display warnings, in order to encourage users and developers alike to address problems before they become fatal errors, or cause other unexpected or undefined behavior.>

=back

=head2 B.23: Flags, Test

=over

=item B<--test ...OR... -t>

=for rperl X<noncode>

    Test mode: Perl ops, Perl types, Parse & Generate (no Save or Compile)
    If enabled, equivalent to '--mode ops=PERL --mode types=PERL --mode compile=GENERATE' arguments.
    Disabled by default.

=for rperl X</noncode>

I<The test flag option tells RPerl to operate in test mode, which means RPerl will utilize Perl operations and Perl data types, and the resulting output code will not actually be saved to disk or subcompiled.  Because the Perl-ops-Perl-types mode is the fully-implemented reference design for the RPerl language, the test mode may be useful to RPerl application developers in order to check the correctness of an RPerl application which includes some RPerl feature that is not yet implemented in the optimized C++ modes.>

=back

=head2 B.24: Flags, Dependencies

=over

=item B<--dependencies ...OR... -d>

=item B<--nodependencies ...OR... -nod>

=for rperl X<noncode>

    Follow and compile dependencies, or not.
    Enabled by default, equivalent to '--mode dependencies=ON' argument.
    Lowercase 'd' not to be confused with uppercase 'D' in 'Debug' argument.

=for rperl X</noncode>

I<The dependencies flag option tells RPerl if it should recursively follow and compile all dependencies of all RPerl source code input files.>

I<This option is a shorthand provided for brevity, please see: L</B.11: Modes, Dependencies>>

=back

=head2 B.25: Flags, Uncompile

=over

=item B<--uncompile ...OR... -u>

=item B<--nouncompile ...OR... -nou>

=item B<--uuncompile ...OR... -uu>

=item B<--nouuncompile ...OR... -nouu>

=item B<--uuuncompile ...OR... -uuu>

=item B<--nouuncompile ...OR... -nouuu>

=for rperl X<noncode>

    Uncompile (delete C++ source code and/or binary output files), or not.
    Repeat as 'uu' and 'uuu' for more thorough file removal.
    Do not confuse uncompile with decompile (recreate RPerl source code from C++ source code or binary output files), which does not currently exist.
    '-u' equivalent to '--mode uncompile=SOURCE --mode compile=OFF --mode execute=OFF' arguments.
    '-uu' equivalent to '--mode uncompile=SOURCE_BINARY --mode compile=OFF --mode execute=OFF' arguments.
    '-uuu' equivalent to '--mode uncompile=SOURCE_BINARY_INLINE --mode compile=OFF --mode execute=OFF' arguments.
    Disabled by default.

=for rperl X</noncode>

I<The uncompile flag option tells RPerl to uncompile the input file(s) instead of compiling them.  The "u" of "uncompile" may be repeated as "uu" or "uuu" for greater uncompile effect (more files deleted).>

I<This option is a shorthand provided for brevity, please see: L</B.12: Modes, Uncompile>>

=back

=head2 B.26: Flags, Compile

=over

=item B<--compile ...OR... -c>

=item B<--nocompile ...OR... -noc>

=for rperl X<noncode>

    Generate & subcompile C++ source code, or not.
    Enabled by default, equivalent to '--mode compile=SUBCOMPILE' argument.

=for rperl X</noncode>

I<The compile flag option tells RPerl if it should compile the source code input file(s), which is obviously enabled by default because RPerl is a compiler and thus is designed to compile as its primary purpose.>

I<If disabled via C<--nocompile> or C<-noc>, RPerl will still perform the PARSE and GENERATE compile phases, but will not perform the SAVE or SUBCOMPILE phases, so no output files are saved to disk or subcompiled to binary using the C++ compiler.  This compile phase effect is similar to test mode in that files are not saved or subcompiled, but without automatically setting the operations or data types modes to Perl.>

I<This option is a shorthand provided for brevity, please see: L</B.13: Modes, Compile>>

=back

=head2 B.27: Flags, Subcompile, Assemble

=over

=item B<--assemble>

=for rperl X<noncode>

    Assemble subcompile mode, output *.o object file(s).
    If enabled, equivalent to '--mode subcompile=ASSEMBLE' argument or `gcc -c` manual subcompile argument.
    Disabled by default.

=for rperl X</noncode>

I<The assemble flag tells RPerl to run the C++ assembler and save non-executable binary *.o object file(s) to disk.>

I<This option is a shorthand provided for brevity, please see: L</B.14: Modes, Subcompile>>

=back

=head2 B.28: Flags, Subcompile, Archive

=over

=item B<--archive>

=for rperl X<noncode>

    Archive subcompile mode, output *.a object archive file(s).
    If enabled, equivalent to '--mode subcompile=ARCHIVE' argument or `gcc -c` followed by `ar` manual subcompile command.
    Disabled by default.

=for rperl X</noncode>

I<The archive flag tells RPerl to run the C++ compiler and save non-executable binary *.a archive library file(s) to disk.>

I<This option is a shorthand provided for brevity, please see: L</B.14: Modes, Subcompile>>

=back

=head2 B.29: Flags, Subcompile, Shared Object

=over

=item B<--shared>

=for rperl X<noncode>

    Shared subcompile mode, output *.so shared object file(s).
    If enabled, equivalent to '--mode subcompile=SHARED' argument or `gcc -shared` manual subcompile command.
    Disabled by default.

=for rperl X</noncode>

I<The archive flag tells RPerl to run the C++ compiler and save non-executable binary *.so shared object library file(s) to disk.>

I<This option is a shorthand provided for brevity, please see: L</B.14: Modes, Subcompile>>

=back

=head2 B.30: Flags, Subcompile, Static

=over

=item B<--static>

=item B<--nostatic>

=for rperl X<noncode>

    Static subcompile mode, output *.exe or non-suffixed statically-linked executable file(s).
    If disabled, equivalent to '--mode subcompile=DYNAMIC' argument or `gcc` manual subcompile command.
    If enabled, equivalent to '--mode subcompile=STATIC' argument or `gcc -static` manual subcompile command.
    Disabled by default.

=for rperl X</noncode>

I<The static flag tells RPerl to run the C++ compiler and save executable binary *.exe or non-suffixed statically-linked program file(s) to disk.>

I<There is no equivalent C<--dynamic> flag, because dynamic subcompile mode is already the default behavior.>

I<This option is a shorthand provided for brevity, please see: L</B.14: Modes, Subcompile>>

=back

=head2 B.31: Flags, Parallelize

=over

=item B<--parallel ...OR... -p>

=item B<--noparallel ...OR... -nop>

=for rperl X<noncode>

    Automatically parallelize input code, or not.
    Enabled by default.
    Equivalent to '--mode parallel=OPENMP' argument.

=for rperl X</noncode>

I<The parallel flag tells RPerl if it should auto-parallelize the RPerl input file(s).>

I<This option is a shorthand provided for brevity, please see: L</B.16: Modes, Parallelize>>

=back

=head2 B.32: Flags, Execute

=over

=item B<--execute ...OR... -e>

=item B<--noexecute ...OR... -noe>

=for rperl X<noncode>

    Run input code after argumental compile, or not.
    Enabled by default for *.pl program input files, always disabled for *.pm module input files or multiple input files.
    Equivalent to '--mode execute=ON' argument.

=for rperl X</noncode>

I<The execute flag tells RPerl if it should execute a *.pl RPerl program input file.>

I<This option is a shorthand provided for brevity, please see: L</B.18: Modes, Execute>>

=back

X<br>


=head1 APPENDIX C: RPERL CRITICS

START HERE: add content and descriptions to all critics below

START HERE: add content and descriptions to all critics below

START HERE: add content and descriptions to all critics below


# DEV NOTE: disable RequireTidyCode because Perl::Tidy is not perfect and may complain even if the code is tidy;

# disable PodSpelling because calling the external spellchecker can cause errors such as aspell's "No word lists can be found for the language FOO";

# disable RequireExplicitPackage because 'use RPerl;' comes before package name(s), and Grammar.eyp will catch any other violations

'-exclude'  => ['RequireTidyCode', 'PodSpelling', 'RequireExplicitPackage'],


# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code

## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers

## no critic qw(RequireTrailingCommas)  # USER DEFAULT X: no trailing commas in RPerl lists  # NEED ANSWER: RPerl is mostly array refs, do we even need this?


## no critic qw(ProhibitUselessNoCritic PodSpelling)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1

## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1

## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values


## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

## no critic qw(ProhibitCascadingIfElse)  # SYSTEM DEFAULT 2: allow argument-handling logic

## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks


## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep

## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @_

## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code

## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1

## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code

## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 8: allow no strict

## no critic qw(RequireUseStrict)  # SYSTEM SPECIAL 9: allow omitted strict

## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

## no critic qw(ProhibitBacktickOperators)  # SYSTEM SPECIAL 11: allow system command execution

## no critic qw(ProhibitCascadingIfElse)  # SYSTEM SPECIAL 12: allow complex conditional logic

## no critic qw(RequireCarping)  # SYSTEM SPECIAL 13: allow die instead of croak

## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm


# COMBO CRITICS

## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1



=head1 APPENDIX D: RPERL GRAMMAR

=head2 D.1: Eyapp Grammar Format & Sections

RPerl's grammar is written using the Eyapp computer programming language, which is a combination of normal Perl 5 and grammar expressions.

The grammar expression sections in Eyapp source code are written using an implementation of the Extended Backus-Naur Form (EBNF) language.

The file F<lib/RPerl/Grammar.eyp> contains the uncompiled RPerl grammar, which is passed through the C<`eyapp`> compiler command once to generate the output file F<lib/RPerl/Grammar.pm>, which is then used by the C<`rperl`> compiler command to parse RPerl input source code files.

Inside the F<lib/RPerl/Grammar.eyp> file, there are several labeled file sections, which can be grouped into 4 major categories:

=over 16

=item * Eyapp Setup & Config

At the top of the F<Grammar.eyp> file, the C<[[[ EYAPP SETUP & CONFIG ]]]> section contains Perl 5 code to initialize RPerl within the C<%{...}%> delimiters, as well as the C<%strict> and C<%tree> Eyapp configuration directives for automatically building an abstract syntax tree (AST) from an RPerl input file.

=item * Lexicon

Near the top of the F<Grammar.eyp> file, multiple C<[[[ LEXICON TOKENS ... ]]]> sections contain all valid RPerl tokens in the form of Perl 5 regular expressions.  The lexicon of a language is synonymous with the language's alphabet and vocabulary; lexical analysis is synonymous with spell checking.

=item * Syntax

In the middle of the F<Grammar.eyp> file, one C<[[[ SYNTAX, OPERATOR PRECEDENCE & ASSOCIATIVITY ]]]> section and multiple C<[[[ SYNTAX PRODUCTION RULES ... ]]]> sections define all relationships between all RPerl tokens, as well as all valid combinations of RPerl tokens.  The syntax of a language is synonymous with the rules of constructing valid sentences, and syntactic analysis is synonymous with grammar checking.

=item * Semantics

Near the top of the F<Grammar.eyp> file, the C<[[[ SEMANTIC ACTION, ABSTRACT SYNTAX TREE NODE CONSTRUCTOR ]]]> section creates new Perl 5 objects (blessed hash references) to be used as nodes when constructing an AST; at the bottom of the file, the C<[[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]> section contains a 1-to-1 mapping from AST nodes to RPerl objects.  The Perl module file for each of the RPerl objects contains subroutines implementing the semantic actions which actually generate and/or execute output code.  The semantics of a language are synonymous with the meaning of words and sentences; in computer programming languages, semantic actions are the tasks which the computer source code performs when executed.

=back

For more information, please view the following links:

=over 16

=item * L<Eyapp Documentation|https://metacpan.org/pod/Parse::Eyapp>

=item * L<Extended Backus-Naur Form on Wikipedia|https://en.wikipedia.org/wiki/Extended_Backus%E2%80%93Naur_Form>

=item * L<RPerl Grammar.eyp Eyapp File|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Grammar.eyp>

=back

=head2 D.2: Lexicon Token Types

Following is a list of all RPerl tokens in all 4 lexicon sections, along with examples of valid matching lexeme input.

The list must be in correct order for all regexes to match; earlier declarations get tried first, thus highly-specific tokens such as RPerl keywords and built-in operators appear first, while the least-specific tokens such as user-defined words appear last.  This ordering can be considered I<"lexical matching">, and is distinct from operator precedence and associativity as covered in the next section.

=head3 D.2.1: Whitespace

C<[[[ LEXICON TOKENS, WHITESPACE ]]]>

=over 16

=item * actual whitespace, or one or more normal comments; neither shebang C<#!>, nor double-hash critics C<##>

=back

=head3 D.2.2: Types & Reserved Words

C<[[[ LEXICON TOKENS, TYPES & RESERVED WORDS ]]]>

=over 16

=item * SHEBANG

begin line, hash (octothorpe), bang, *NIX path to Perl; ex. C<#!/usr/bin/perl>

=item * USE_RPERL

C<use RPerl;>

=item * USE_RPERL_AFTER

C<use RPerl::AfterSubclass;>

=item * USE

C<use>

=item * VERSION_NUMBER_ASSIGN

$VERSION assign v-number, only capture v-number, not a normal number; ex. C<$VERSION = 12.345_678;> returns C<12.345_678>

=item * MY

C<my>

=item * LITERAL_NUMBER

number with underscores, optional scientific notation; ex. C<12_345_678.910_1>

=item * LITERAL_STRING

single quotes non-empty; double quotes non-empty without sigils or extra backslashes & with newline or tab; or single q-braces; ex. C<'howdy $foo!'> or C<"howdy foo!\n"> or C<q{howdy $foo!}>

=item * SELF

C<$self>

=item * VARIABLE_SYMBOL

dollar sigil, scoped word with at least one lowercase in the first scope segment; ex. C<$foo> or C<$Foo::Bar::baz>

=item * FHREF_SYMBOL_IN

less-than, dollar sigil, uppercase letter, uppercase letters & numbers & underscores, greater-than; ex. C<E<lt>$MY_FILEHANDLE_23E<gt>>

=item * FHREF_SYMBOL_BRACES

left brace, dollar sigil, uppercase letter, uppercase letters & numbers & underscores, right brace; ex. C<{$MY_FILEHANDLE_23}>

=item * FHREF_SYMBOL

dollar sigil, uppercase letter, uppercase letters & numbers & underscores; ex. C<$MY_FILEHANDLE_23>

=item * TYPE_INTEGER

C<integer> or C<unsigned_integer> followed by whitespace

=item * TYPE_FHREF

C<filehandleref> followed by whitespace

=item * TYPE_METHOD

optionally-scoped word, followed by '::method'; ex. C<string_arrayref::method> or C<Foo::Bar::method>

=item * CONSTANT_CALL_SCOPED

optionally-scoped constant call; ex. C<MY_CONST()> or C<Foo::Bar::BAZ_CONST()>

=item * WORD_SCOPED

optionally-scoped word; ex. C<my_word> or C<My_Word> or C<Foo::Bar::baz_word>

=item * STDOUT_STDERR

C<{*STDOUT}> or C<{*STDERR}>

=item * STDIN

C<E<lt>STDINE<gt>>

=item * ARGV

C<@ARGV>

=item * ENV

C<%ENV>

=back

=head3 D.2.3: Operators

C<[[[ LEXICON TOKENS, OPERATORS ]]]>

=over 16

=item * OP24_LOGICAL_OR_XOR

precedence 24 infix: logical C<or> and C<xor>, equivalent to C<||> except for precedence

=item * OP23_LOGICAL_AND

precedence 23 infix: logical C<and>, equivalent to C<&&> except for precedence

=item * OP22_LOGICAL_NEG

precedence 22 prefix: logical negation C<not>, equivalent to C<!> except for precedence

=item * OP21_LIST_COMMA

precedence 21 infix: "list operators (rightward)" [1] AKA comma C<,>

=item * OP20_HASH_FATARROW

precedence 20 infix: hash entry fat arrow AKA fat comma C<=E<gt>>

=item * OP19_LOOP_CONTROL_SCOLON

precedence 19 prefix void: loop control C<next;>, C<last;>

=item * OP19_LOOP_CONTROL

precedence 19 prefix void: same as above, except allows C<redo> and requires loop label

=item * OP18_TERNARY

precedence 18 infix: ternary conditional C<?>

=item * OP17_LIST_RANGE

precedence 17 infix: range C<..>

=item * OP16_LOGICAL_OR

precedence 16 infix: logical or C<||>

=item * OP15_LOGICAL_AND

precedence 15 infix: logical and C<&&>

=item * OP14_BITWISE_OR_XOR

precedence 14 infix: bitwise or C<|>, bitwise xor C<^>

=item * OP13_BITWISE_AND

precedence 13 infix: bitwise and C<&>

=item * OP12_COMPARE_EQ_NE

precedence 12 infix: comparison numeric equal C<==>, numeric not equal C<!=>, string equal C<eq>, string not equal C<ne>

=item * OP09_BITWISE_SHIFT

precedence 09 infix: bitwise shift left C<E<lt>E<lt>>, shift right C<E<gt>E<gt>>

=item * OP10_NAMED_UNARY_SCOLON

precedence 10 prefix: "named unary operators" [1] and Programming Perl, Chapter 3, List of All Named Unary Operators;
C<-A;>, C<-B;>, C<-C;>, C<-M;>, C<-O;>, C<-R;>, C<-S;>, C<-T;>, C<-W;>, C<-X;>, C<-b;>, C<-c;>, C<-d;>, C<-e;>, C<-f;>, C<-g;>, C<-k;>, C<-l;>, C<-o;>, C<-p;>, C<-r;>, C<-s;>, C<-t;>, C<-u;>, C<-w;>, C<-x;>, C<-z;>, C<alarm;>, C<caller;>, C<chdir;>, C<chroot;>, C<cos;>, C<defined;>, C<delete;>, C<do;>, C<eval;>, C<exists;>, C<gethostbyname;>, C<getnetbyname;>, C<getpgrp;>, C<getprotobyname;>, C<glob;>, C<gmtime;>, C<goto;>, C<hex;>, C<int;>, C<lc;>, C<lcfirst;>, C<length;>, C<localtime;>, C<lock;>, C<log;>, C<lstat;>, C<oct;>, C<ord;>, C<quotemeta;>, C<rand;>, C<readlink;>, C<ref;>, C<require;>, C<rmdir;>, C<scalar;>, C<sin;>, C<sleep;>, C<sqrt;>, C<srand;>, C<stat;>, C<uc;>, C<ucfirst;>, C<umask;>

=item * OP10_NAMED_UNARY          

same as above, except without semicolon; C<scalar> not C<scalartype>

=item * OP19_VARIABLE_ASSIGN_BY

precedence 19 infix: add assign C<+=>, subtract assign C<-=>, multiply assign C<*=>, divide assign C</=>, string concatenation assign C<.=>

=item * OP08_STRING_CAT

precedence 08 infix: string concatenate C<.>

=item * OP03_MATH_INC_DEC

precedence 03 prefix and postfix: increment C<++>, decrement C<-->

=item * OP04_MATH_POW

precedence 04 infix: arithmetic exponent AKA power C<**>

=item * OP07_MATH_MULT_DIV_MOD

precedence 07 infix: arithmetic multiply C<*>, divide C</>, modulo C<%>, SSE multiply C<sse_mul>, SSE divide C<sse_div>

=item * OP07_STRING_REPEAT

precedence 07 infix: string repetition C<x>

=item * OP06_REGEX_PATTERN

precedence 06 infix: regular expression pattern; ex. C<m/foo.*/xms> or C<s/foo/bar/gxms>

=item * OP06_REGEX_MATCH

precedence 06 infix: regular expression match C<=~>, not match C<!~>

=item * OP05_LOGICAL_NEG

precedence 05 prefix: logical negation C<!>

=item * OP02_HASH_THINARROW

precedence 02 infix: thin arrow, hash dereference and retrieval C<-E<gt>{>

=item * OP02_ARRAY_THINARROW

precedence 02 infix: thin arrow, array dereference and retrieval C<-E<gt>[>

=item * OP02_METHOD_THINARROW_NEW

precedence 02 infix: thin arrow, class constructor C<-E<gt>new(>

=item * OP02_METHOD_THINARROW

precedence 02 infix: thin arrow, method dereference and call; ex. C<-E<gt>foo> or C<-E<gt>Bar23>

=item * OP05_MATH_NEG_LPAREN

precedence 05 prefix: arithmetic negative C<-(>

=item * OP08_MATH_ADD_SUB

precedence 08 infix: arithmetic add C<+>, subtract C<->, SSE add C<sse_add>, SSE subtract C<sse_sub>

=item * OP11_COMPARE_LT_GT

precedence 11 infix: numeric comparison less or equal C<E<lt>=>, greater or equal C<E<gt>=>, less than C<E<lt>>, greater than C<E<gt>>; string comparison less or equal C<le>, greater or equal C<ge>, less than C<lt>, greater than C<gt>

=item * OP19_VARIABLE_ASSIGN

precedence 19 infix: assign C<=>

=item * OP01_PRINT

precedence 01 prefix void: C<print> or C<printf> to STDOUT, STDERR, or filehandle

=item * OP01_NAMED_VOID_SCOLON

precedence 01 prefix void: "terms and list operators (leftward)" [1] AKA built-ins, no return value; C<croak;>, C<die;>, C<exit;>, C<return;>

=item * OP01_NAMED_VOID_LPAREN

precedence 01 prefix void: same as above, except with parentheses & without semicolon & without die; C<croak(>, C<exit(>, C<return(>

=item * OP01_NAMED_VOID

precedence 01 prefix void: same as above, except accepts argument(s); C<croak>, C<die>, C<exit>, C<return>

=item * OP01_QW

precedence 01 prefix: quoted words; ex. C<qw()> or C<qw(foo bar baz)> or C<qw(Foo23 BarBax Ba_z 123)>

=item * OP01_OPEN

precedence 01 prefix: C<open> filehandle

=item * OP01_CLOSE

precedence 01 prefix: C<close> filehandle

=item * OP01_NAMED_SCOLON

precedence 01 prefix: "terms and list operators (leftward)" [1] AKA built-ins; L<List Of All Operators in Perl 5 Source Code|http://perl5.git.perl.org/perl.git/blob/HEAD:/t/op/cproto.t> [2];
without all-uppercase Perl system built-in keywords (C<__DATA__>, C<AUTOLOAD>, C<CHECK>, etc); named unary operators above (C<defined>, C<exists>, etc); and RPerl keywords (C<use>, C<our>, C<my>, C<package>, C<for>, etc);
C<abs;>, C<accept;>, C<atan2;>, C<bind;>, C<binmode;>, C<bless;>, C<break;>, C<chmod;>, C<chomp;>, C<chop;>, C<chown;>, C<chr;>, C<closedir;>, C<cmp;>, C<connect;>, C<continue;>, C<crypt;>, C<dbmclose;>, C<dbmopen;>, C<default;>, C<dump;>, C<each;>, C<endgrent;>, C<endhostent;>, C<endnetent;>, C<endprotoent;>, C<endpwent;>, C<endservent;>, C<eof;>, C<evalbytes;>, C<exec;>, C<exp;>, C<fc;>, C<fcntl;>, C<fileno;>, C<flock;>, C<fork;>, C<format;>, C<formline;>, C<getc;>, C<getgrent;>, C<getgrgid;>, C<getgrnam;>, C<gethostbyaddr;>, C<gethostent;>, C<getlogin;>, C<getnetbyaddr;>, C<getnetent;>, C<getpeername;>, C<getppid;>, C<getpriority;>, C<getprotobynumber;>, C<getprotoent;>, C<getpwent;>, C<getpwnam;>, C<getpwuid;>, C<getservbyname;>, C<getservbyport;>, C<getservent;>, C<getsockname;>, C<getsockopt;>, C<given;>, C<grep;>, C<index;>, C<ioctl;>, C<join;>, C<keys;>, C<kill;>, C<link;>, C<listen;>, C<local;>, C<m;>, C<map;>, C<mkdir;>, C<msgctl;>, C<msgget;>, C<msgrcv;>, C<msgsnd;>, C<opendir;>, C<pack;>, C<pipe;>, C<pop;>, C<pos;>, C<prototype;>, C<push;>, C<q;>, C<qq;>, C<qr;>, C<qx;>, C<read;>, C<readdir;>, C<readline;>, C<readpipe;>, C<recv;>, C<rename;>, C<reset;>, C<reverse;>, C<rewinddir;>, C<rindex;>, C<s;>, C<say;>, C<seek;>, C<seekdir;>, C<select;>, C<semctl;>, C<semget;>, C<semop;>, C<send;>, C<setgrent;>, C<sethostent;>, C<setnetent;>, C<setpgrp;>, C<setpriority;>, C<setprotoent;>, C<setpwent;>, C<setservent;>, C<setsockopt;>, C<shift;>, C<shmctl;>, C<shmget;>, C<shmread;>, C<shmwrite;>, C<shutdown;>, C<socket;>, C<socketpair;>, C<sort;>, C<splice;>, C<split;>, C<sprintf;>, C<state;>, C<study;>, C<substr;>, C<symlink;>, C<syscall;>, C<sysopen;>, C<sysread;>, C<sysseek;>, C<system;>, C<syswrite;>, C<tell;>, C<telldir;>, C<tie;>, C<tied;>, C<time;>, C<times;>, C<tr;>, C<truncate;>, C<unless;>, C<unlink;>, C<unpack;>, C<unshift;>, C<untie;>, C<until;>, C<utime;>, C<values;>, C<vec;>, C<wait;>, C<waitpid;>, C<wantarray;>, C<warn;>, C<when;>, C<write;>, C<y;>

=item * OP01_NAMED

same as above, except without semicolon

=back

=head3 D.2.4: Punctuation & User-Defined Words

C<[[[ LEXICON TOKENS, PUNCTUATION & USER-DEFINED WORDS ]]]>

=over 16

=item * COLON

C<:>

=item * LPAREN_MY

C<(my>

=item * LPAREN

C<(>

=item * LBRACKET

C<[>

=item * LBRACE

C<{>

=item * WORD

lowercase letter followed by optional word characters; or uppercase letter followed by at least one lowercase letter and optional word characters; ex. C<foo> or C<foo23> or C<Foo23>

=item * WORD_UPPERCASE

single uppercase letter, or uppercase letter followed by uppercase letters, numbers, and underscores; ex. C<FOO> or C<FOOBAR_42_HOWDY>

=back

=head2 D.3: Syntax Arity, Fixity, Precedence, Associativity

Operator I<"arity"> is a technical term which means the number of input operands accepted by a specific built-in operator, or the number of input arguments accepted by a user-defined function.  An operator or function which accepts 0 input arguments is known as I<"nullary">, 1 argument as I<"unary">, 2 arguments as I<"binary">, 3 arguments as I<"ternary">, and so forth.  The C<exit;> operator may be called as nullary; the C<++> increment operator is unary; the C<+> addition operator is binary; and the C<substr> operator may be called as ternary.  Not to be confused with "a ternary operator", meaning any operator which accepts 3 operands, there is one specific operator known as I<"the ternary operator">, which is a special kind of conditional operator accepting 3 input arguments.  An operator or function which may accept more than one number of arguments is known as I<"variadic">.  Some RPerl operators are variadic, such as C<substr> which may accept 2, 3, or 4 arguments.  RPerl does not currently support variadic user-defined functions.

L<Operator Arity on Wikipedia|https://en.wikipedia.org/wiki/Arity>

Operator I<"fixity"> is the notation form indicating the location of an operator when placed relative to its own input operands.  I<"Prefix"> operators are located before their operands, I<"infix"> between operands, and I<"postfix"> after operands.  Additionally, operators which must be placed both before and after their operands are said to be of I<"closed"> fixity, while operators capable of more than one placement location are called I<"mixfix">.  Prefix notation is also known as I<"Polish notation">, and postfix is called I<"Reverse Polish"> notation.  The C<abs> absolute value is a prefix operator; the C<+> addition operator is infix; and the C<++> increment operator can be called as postfix.  The C<-( )> negative-with-parentheses operator is of closed fixity, because the parentheses component must appear both before and after the enclosed operand.  Parentheses are always of closed fixity; in normal Perl, the C<-> negative (without parentheses) is a prefix operator, but in RPerl we only allow the closed fixity C<-( )> negative-with-parentheses operator in order to avoid grammar ambiguity, because the same C<-> dash (AKA hyphen) character is utilized for both the C<-> negative and C<-> subtraction operators.  The C<++> increment operator may also be called as prefix, so it may be classified as mixfix.

L<Prefix Notation on Wikipedia|https://en.wikipedia.org/wiki/Prefix_notation>

L<Infix Notation on Wikipedia|https://en.wikipedia.org/wiki/Infix_notation>

L<Postfix Notation on Wikipedia|https://en.wikipedia.org/wiki/Postfix_notation>

Operator I<"precedence">, also known as I<"order-of-operations">, is a methodology used to determine which operator is executed first when 2 or more operators are adjacent to one another and parentheses are not used to explicitly separate them.  A numeric precedence from 1 to 24 is assigned to each operator, and the operator with the lowest precedence number is given priority to execute first.  Low precedence number equals high priority.  The C<*> arithmetic multiplication operator has a precedence number of 7, and C<+> addition has a precedence of 8, so C<a + b * c> is equivalent to C<a + (b * c)>, not C<(a + b) * c>.

L<Operator Precedence on Wikipedia|https://en.wikipedia.org/wiki/Operator_precedence>

Operator I<"associativity"> is used to further determine precedence when multiple operators of the same priority are adjacent to one another.  Each operator is designated as left-associative, right-associative, or non-associative.  (Wikipedia incorrectly identifies associativity as a synonym for fixity, which is different, as described above.)  Normal arithmetic operators are left-associative, meaning C<a - b - c> is equivalent to C<(a - b) - c>, not C<a - (b - c)>.  Some operators such as mathematic power (AKA exponentiation) are right-associative, meaning C<a ** b ** c> is equivalent to C<a ** (b ** c)>.  Operators which are not meant to be chained together are non-associative, such as the C<..> list range operator which takes scalar values as input but generates an array as output, so C<a .. b .. c> is incorrect usage and will cause an error.

L<Operator Associativity on Wikipedia|https://en.wikipedia.org/wiki/Operator_associativity>

In the following list of operators copied directly from F<Grammar.eyp>, later declaration gets higher priority, so all precedence numbers appear in strictly descending order from 24 to 1.  (Implementation of operator arity and fixity are a bit less straightforward, and are not easily copied-and-pasted in one succinct list directly out of F<Grammar.eyp>.)  All operator arity, fixity, precedence, and associativity are taken directly from Perl 5.

L<Operator Precedence & Associativity in Perl 5 Documentation|http://perldoc.perl.org/perlop.html#Operator-Precedence-and-Associativity> [1]

C<[[[ SYNTAX, OPERATOR PRECEDENCE & ASSOCIATIVITY ]]]>

=for rperl X<noncode>

    %left       OP24_LOGICAL_OR_XOR
    %left       OP23_LOGICAL_AND
    %right      OP22_LOGICAL_NEG
    %left       OP21_LIST_COMMA
    %left       OP20_HASH_FATARROW
    %right      OP19_LOOP_CONTROL_SCOLON
    %right      OP19_LOOP_CONTROL
    %right      OP19_VARIABLE_ASSIGN_BY
    %right      OP19_VARIABLE_ASSIGN
    %right      OP18_TERNARY
    %nonassoc   OP17_LIST_RANGE
    %left       OP16_LOGICAL_OR
    %left       OP15_LOGICAL_AND
    %left       OP14_BITWISE_OR_XOR
    %left       OP13_BITWISE_AND
    %nonassoc   OP12_COMPARE_EQ_NE
    %nonassoc   OP11_COMPARE_LT_GT
    %nonassoc   OP10_NAMED_UNARY
    %nonassoc   OP10_NAMED_UNARY_SCOLON
    %left       OP09_BITWISE_SHIFT
    %left       OP08_STRING_CAT
    %left       OP08_MATH_ADD_SUB
    %left       OP07_MATH_MULT_DIV_MOD
    %left       OP07_STRING_REPEAT
    %left       OP06_REGEX_MATCH
    %left       OP06_REGEX_PATTERN
    %right      OP05_MATH_NEG_LPAREN
    %right      OP05_LOGICAL_NEG
    %right      OP04_MATH_POW
    %nonassoc   OP03_MATH_INC_DEC
    %left       OP02_HASH_THINARROW
    %left       OP02_ARRAY_THINARROW
    %left       OP02_METHOD_THINARROW_NEW
    %left       OP02_METHOD_THINARROW
    %left       OP01_NAMED
    %left       OP01_NAMED_SCOLON
    %left       OP01_CLOSE
    %left       OP01_OPEN
    %left       OP01_QW
    %left       OP01_NAMED_VOID_SCOLON
    %left       OP01_NAMED_VOID_LPAREN
    %left       OP01_NAMED_VOID
    %left       OP01_PRINT

=for rperl X</noncode>

=head2 D.4: Syntax Production Rules

The EBNF metasyntax implemented by Eyapp is of the form:

C<ProductionRule: First Alternative 'foo' | Second Alternative 'bar' | ... | Last Alternative 'quux' ;>

In this example, C<ProductionRule> is a non-terminal left-hand-side (LHS) symbol, is followed by the C<:> reduction metasymbol, and may be reduced (replaced) by any of the right-hand-side (RHS) sequences of terminal and non-terminal symbols, themselves separated by the C<|> alternation (logical or) metasymbol.  In other words, each LHS may become any of its corresponding RHS alternatives.

Terminal symbols are enclosed in single quotes as with C<'foo'>, never appear on the LHS, and are taken as literal data with no transformations applied.  Eyapp treats terminal symbols as tokens which only match one hard-coded lexeme, which is the string appearing inside the single quotes, C<foo> in this example.

=head3 D.4.1: File Formats

C<[[[ SYNTAX PRODUCTION RULES, FILE FORMATS ]]]>


=for rperl X<noncode>

    CompileUnit:             Program | (ModuleHeader Module)+ ;
    Program:                 SHEBANG Critic? USE_RPERL Header Critic* Include* Constant* Subroutine* Operation+ ;
    ModuleHeader:            Critic? USE_RPERL? 'package' WordScoped ';' Header ;
    Module:                  Package | Class ;
    Package:                 Critic* Include* Constant* Subroutine+ LITERAL_NUMBER ';' ;
    Header:                  'use strict;' 'use warnings;' USE_RPERL_AFTER? 'our' VERSION_NUMBER_ASSIGN;
    Critic:                  '## no critic qw(' WORD+ ')';
    Include:                 USE WordScoped ';' | USE WordScoped OP01_QW ';' ;
    Constant:                'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';' ;
    Subroutine:              'our' Type VARIABLE_SYMBOL '= sub {' SubroutineArguments? Operation* '}' ';' ;
    SubroutineArguments:     LPAREN_MY Type VARIABLE_SYMBOL (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)* ')' OP19_VARIABLE_ASSIGN '@_;' ;
    Class:                   'use parent qw(' WordScoped ')' ';' Include Critic* Include* Constant* Properties MethodOrSubroutine* LITERAL_NUMBER ';' ;
    Properties:              'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties (OP21_LIST_COMMA HashEntryProperties)* '}' ';' |
                             'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';' ;
    Method:                  'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' MethodArguments? Operation* '}' ';' ;
    MethodArguments:         LPAREN_MY Type SELF (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)* ')' OP19_VARIABLE_ASSIGN '@_;' ;
    MethodOrSubroutine:      Method | Subroutine;

=for rperl X</noncode>

B<Code Examples:>

I<CompileUnit>

=over 16

=item * L<Program|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Program>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Program/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OPERATIONS ]]]
    my integer $i = 2 + 2;

=item * L<Module|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Module>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Module/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ INCLUDES ]]]
    use RPerl::Test::Module::Class_00_Good;

    # [[[ OPERATIONS ]]]

    my RPerl::Test::Module::Class_00_Good $foo = RPerl::Test::Module::Class_00_Good->new();
    my RPerl::Test::Module::Class_00_Good $bar = RPerl::Test::Module::Class_00_Good->new();

    print 'have $foo->{empty_property} = ', $foo->{empty_property}, "\n";
    print 'have $bar->{empty_property} = ', $bar->{empty_property}, "\n";
    print '...', "\n";

    $foo->{empty_property} = 23;

    print 'have $foo->{empty_property} = ', $foo->{empty_property}, "\n";
    print 'have $bar->{empty_property} = ', $bar->{empty_property}, "\n";

L<Package_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Module/Package_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Module::Package_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ SUBROUTINES ]]]
    our void $empty_sub = sub {
        return 2;
    };

    1;                  # end of package

L<Class_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Module/Class_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Module::Class_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { empty_property => my integer $TYPED_empty_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our void::method $empty_method = sub {
        return 2;
    };

    1;    # end of class

=item * L<Header|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Header>

=item * L<VersionNumber|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/VersionNumber>

=item * L<Critic|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Critic>

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Critic/program_01_good.pl>

    #!/usr/bin/perl ## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic)

    # [[[ OPERATIONS ]]]
    my integer $i = 2 + 2;

L<Package_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Critic/Package_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Critic::Package_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]
    our void $empty_sub = sub {
        return 2;
    };

    1;                  # end of package

L<Class_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Critic/Class_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Critic::Class_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { empty_property => my integer $TYPED_empty_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our void::method $empty_method = sub {
        return 2;
    };

    1;                  # end of class

=item * L<Include|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Include>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Include/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ INCLUDES ]]]
    use RPerl::Test::Foo;
    use RPerl::Test::Bar;

    # [[[ OPERATIONS ]]]
    my integer $i = 2 + 2;

L<Package_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Include/Package_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Include::Package_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ INCLUDES ]]]
    use RPerl::Test::Foo;
    use RPerl::Test::Bar;

    # [[[ SUBROUTINES ]]]
    our integer $empty_sub = sub {
        return 2;
    };

    1;                  # end of package

L<Class_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Include/Class_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Include::Class_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ INCLUDES ]]]
    use RPerl::Test::Foo;
    use RPerl::Test::Bar;

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { empty_property => my integer $TYPED_empty_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our integer::method $empty_method = sub {
        return 2;
    };

    1;                  # end of class

=item * L<Constant|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Constant>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Constant/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CONSTANTS ]]]
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';

    # [[[ OPERATIONS ]]]
    my integer $i = 2 + 2;

L<Package_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Constant/Package_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Constant::Package_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CONSTANTS ]]]
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';

    # [[[ SUBROUTINES ]]]
    our void $empty_sub = sub {
        return 2;
    };

    1;                  # end of package

L<Class_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Constant/Class_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Constant::Class_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ CONSTANTS ]]]
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { empty_property => my integer $TYPED_empty_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our void::method $empty_method = sub {
        return 2;
    };

    1;    # end of class

=item * L<Subroutine|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Subroutine>

=item * L<SubroutineArguments|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/SubroutineArguments>

L<Package_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/SubroutineArguments/Package_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::SubroutineArguments::Package_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ SUBROUTINES ]]]
    our void $empty_sub = sub {
        ( my number $foo ) = @_;
        return 1;
    };

    1;    # end of package

=back

I<Class>

=over 16

=item * L<Properties|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Properties>

L<class_00_good_02.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Properties/class_00_good_02.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: '92' >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.000_010;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ INCLUDES ]]]
    use RPerl::Test::Properties::Class_00_Good;

    # [[[ OPERATIONS ]]]
    # set and get object property ourself
    # using direct access to blessed $property hashref, breaking object encapsulation
    my RPerl::Test::Properties::Class_00_Good $test_object = RPerl::Test::Properties::Class_00_Good->new();
    $test_object->{test_property} = 4;
    $test_object->test_method(23);
    print $test_object->{test_property}, "\n";

L<Class_00_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Properties/Class_00_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::Properties::Class_00_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { test_property => my integer $TYPED_test_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our void::method $test_method = sub {
        ( my object $self, my integer $input_integer ) = @_;
        $self->{test_property} *= $input_integer;
        return $self->{test_property};
    };

    1;    # end of class

=item * L<Method|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Method>

=item * L<MethodArguments|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/MethodArguments>

L<Class_01_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/MethodArguments/Class_01_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::MethodArguments::Class_01_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OO INHERITANCE ]]]
    use parent qw(RPerl::Test);
    use RPerl::Test;

    # [[[ OO PROPERTIES ]]]
    our hashref $properties
        = { empty_property => my integer $TYPED_empty_property = 2 };

    # [[[ SUBROUTINES & OO METHODS ]]]
    our void::method $empty_method = sub {
        ( my object $self, my integer $foo ) = @_;
        return 2;
    };

    1;    # end of class

=back

=head3 D.4.2: Operations

C<[[[ SYNTAX PRODUCTION RULES, OPERATIONS ]]]>

=for rperl X<noncode>

    Operation:               Expression ';' | OP01_NAMED_SCOLON | OP10_NAMED_UNARY_SCOLON | Statement ;
    Operator:                LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')' |
                             OP01_NAMED SubExpression | LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')' |
                             OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression |
                             OP01_CLOSE FHREF_SYMBOL | OP03_MATH_INC_DEC Variable | Variable OP03_MATH_INC_DEC | SubExpression OP04_MATH_POW SubExpression |
                             OP05_LOGICAL_NEG SubExpression | OP05_MATH_NEG_LPAREN SubExpression ')' | SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN |
                             SubExpression OP07_STRING_REPEAT SubExpression | SubExpression OP07_MATH_MULT_DIV_MOD SubExpression |
                             SubExpression OP08_MATH_ADD_SUB SubExpression | SubExpression OP08_STRING_CAT SubExpression | SubExpression OP09_BITWISE_SHIFT SubExpression |
                             OP10_NAMED_UNARY SubExpression | OP10_NAMED_UNARY | SubExpression OP11_COMPARE_LT_GT SubExpression |
                             SubExpression OP12_COMPARE_EQ_NE SubExpression | SubExpression OP13_BITWISE_AND SubExpression |
                             SubExpression OP14_BITWISE_OR_XOR SubExpression | SubExpression OP15_LOGICAL_AND SubExpression | SubExpression OP16_LOGICAL_OR SubExpression |
                             SubExpression OP17_LIST_RANGE SubExpression | SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral |
                             OP22_LOGICAL_NEG SubExpression | SubExpression OP23_LOGICAL_AND SubExpression | SubExpression OP24_LOGICAL_OR_XOR SubExpression ;
    OperatorVoid:            OP01_PRINT (STDOUT_STDERR)? ListElements ';' | OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';' |
                             OP01_NAMED_VOID_SCOLON | OP01_NAMED_VOID_LPAREN ListElements? ')' ';' | OP01_NAMED_VOID ListElements ';' | 
                             OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';' | OP19_LOOP_CONTROL_SCOLON | OP19_LOOP_CONTROL LoopLabel ';' ;
    Expression:              Operator | WORD_UPPERCASE LPAREN ')' | CONSTANT_CALL_SCOPED | WordScoped LPAREN ListElements? ')' |
                             Variable OP02_METHOD_THINARROW LPAREN ListElements? ')' | WordScoped OP02_METHOD_THINARROW_NEW ')' ;
    SubExpression:           Expression | 'undef' | Literal | Variable | ArrayReference | ArrayDereference | HashReference | HashDereference | LPAREN SubExpression ')' ;
    SubExpressionOrInput:    SubExpression | FHREF_SYMBOL_IN | STDIN;
    SubExpressionOrVarMod:   SubExpression | VariableModification;
    Statement:               Conditional | (LoopLabel COLON)? Loop | OperatorVoid | VariableDeclaration | VariableModification ';' ;
    Conditional:             'if' LPAREN SubExpression ')' CodeBlock ('elsif' LPAREN SubExpression ')' CodeBlock)* ('else' CodeBlock)? ;
    Loop:                    LoopFor | LoopForEach | LoopWhile ;
    LoopFor:                 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock |
                             'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock ;
    LoopForEach:             'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock ;
    LoopWhile:               'while' LPAREN SubExpression ')' CodeBlock | 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock;
    CodeBlock:               LBRACE Operation+ '}' ;

=for rperl X</noncode>

B<Code Examples:>

I<Operation>

=over 16

=item * L<Expression|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Expression>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Expression/program_00_good.pl>

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

    my integer $i = 0;
    $i++;

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Expression/program_01_good.pl>

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

    our integer $foo = sub {
        return 23;
    };
    foo();

L<program_10_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Expression/program_10_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: '1.570795' >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ INCLUDES ]]]
    use RPerl::Test::Foo;

    # [[[ OPERATIONS ]]]
    my number $pi_over_2 = RPerl::Test::Foo::PI() / 2;
    print 'pi / 2 = ', $pi_over_2, "\n";

L<program_21_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Expression/program_21_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: "'a' => 'twenty-threetwenty-threetwenty-threetwenty-threetwenty-threetwenty-threetwenty-three'" >>>
    # <<< EXECUTE_SUCCESS: "'b' => 'howdy'" >>>
    # <<< EXECUTE_SUCCESS: "'c' => '-23.42'" >>>
    # <<< EXECUTE_SUCCESS: "'a' => 'guffawguffawguffawguffawguffawguffawguffawguffawguffawguffawguffaw'" >>>
    # <<< EXECUTE_SUCCESS: "'b' => 'howdy'" >>>
    # <<< EXECUTE_SUCCESS: "'c' => '-23.42'" >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ INCLUDES ]]]
    use RPerl::Test::Foo;

    # [[[ OPERATIONS ]]]
    my RPerl::Test::Foo $my_foo = RPerl::Test::Foo->new();
    print Dumper($my_foo->qorge(7)), "\n";
    $my_foo->{xyzzy} = 'guffaw';
    print Dumper($my_foo->qorge(11)), "\n";

L<program_30_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Expression/program_30_good.pl>

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

    my number $foo            = 9_123.456_789;
    my number_arrayref $bar = [ 21, 12, 43.23, 987.654_321 ];
    my string $bat            = number_to_string($foo);
    my string $baz            = ::number_arrayref_to_string($bar);
    my string $bax = ::string_arrayref_to_string( [ 'abc', '123', 'lalala' ] );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = ::integer_hashref_to_string(
        { foo => 23, bar => 56, quux => 123_456 } );
    $baz = ::number_hashref_to_string(
        { foo => 23.4, bar => 56.789, quux => 123_456.789_012 } );
    $bax = ::string_hashref_to_string(
        { foo => 'howdy', bar => 'dowdy', quux => 'doo' } );

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator01Named|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator01Named>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01Named/program_00_good.pl>

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
    my number $op_sin = sin 2;
    my number $op_cos = cos 2;

    my integer_arrayref $frob = [];
    my integer $frob_length = ( push @{$frob}, 21, 12, 23 ); # Operator, yes parentheses required for built-in w/ multiple arguments in non-void context
    print 'have $frob_length = ', $frob_length, "\n";
    print 'have $frob = ', "\n", Dumper($frob), "\n";

    my integer $frob_pop = pop @{$frob};
    print 'have $frob_pop = ', "\n", $frob_pop, "\n";
    print 'have $frob = ', "\n", Dumper($frob), "\n";

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01Named/program_01_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]
    wait;

L<program_02_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01Named/program_02_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]
    my unknown $op_wait = wait;

=item * L<Operator10NamedUnary|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator10NamedUnary>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator10NamedUnary/program_00_good.pl>

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

    my integer $foo = chdir;
    my integer $bar = chdir 'INVALID__DIRECTORY__NAME';
    my number $bat  = rand;
    my number $baz  = rand 10;
    my number $bax  = rand 30;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    my integer_arrayref $quux = [ 5, 6, 7, 8 ];
    $foo = scalar @{$quux};
    $bar = scalar @{ [] };
    $bat = scalar @{ [0] };
    $baz = scalar @{ [ 0, 1, 2, 3, 4, 5, 6, 7 ] };
    $bax = scalar @{ [ 0 .. 22 ] };

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator10NamedUnary/program_01_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]
    chdir;

=item * L<Statement|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Statement>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_00_good.pl>

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

    if (1) {
        print 'Production rule Statement matched by Conditional', "\n";
    }

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_01_good.pl>

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

    for my integer $i ( -1 .. 1 ) {
        print 'Production rule Statement matched by Loop, iteration number ', $i, "\n";
    }

L<program_02_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_02_good.pl>

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

    foreach my number $my_number ( 11.1, 22.2, 33.3, 44.4 ) {
        print 'Production rule Statement matched by Loop, iteration item ', $my_number, "\n";
    }

L<program_03_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_03_good.pl>

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

    my integer $i = 10;
    FOOBARLOOP:
    while ( $i < 23 ) {
        print 'Production rule Statement matched by Loop, iteration number ', $i, "\n";
        $i += 2;
        if ( $i > 18 ) {
            last FOOBARLOOP;
        }
    }

L<program_04_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_04_good.pl>

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

    print 'Production rule Statement matched by OperatorVoid', "\n";

L<program_05_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_05_good.pl>

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

    my string $foo = 'Production rule Statement matched by VariableDeclaration';

L<program_06_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Statement/program_06_good.pl>

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

    my string $foo = 'Production rule Statement matched by';
    $foo .= ' VariableModification';

=back

I<Operator>

=over 16

=item * L<Operator01Print|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator01Print>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01Print/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]

    # USER NOTE: the Operator (not OperatorVoid) production rule matched by 'print' requires parentheses and filehandle

    my integer $open_success = open my filehandleref $HOWDY, '>', '/tmp/howdy';
    if ( not $open_success ) {
        croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
    }

    # USER NOTE: return values of Operator print are purposefully ignored here, possibly ignoring write errors
    ( print {$HOWDY} 2 );
    ( print {$HOWDY} 2, 3, 4, "\n" );
    ( print {$HOWDY} 2.31 );
    ( print {$HOWDY} 2.31, 3.21, 4.23, "\n" );
    ( print {$HOWDY} 'howdy' );
    ( print {$HOWDY} 'howdy', 'doody', 'foobar', "\n" );
    ( print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n" );

    # USER NOTE: return values of Operator print are utilized here, catching write errors
    # long format, 2 RPerl Operations
    my integer $print_success = ( print {$HOWDY} 2 );
    if ( not $print_success ) {
        croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
    }

    # short format, 1 RPerl Operation
    if (not( print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n" ) )
    {
        croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
    }

    if ( not close $HOWDY ) {
        croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
    }

=item * L<Operator01OpenClose|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator01OpenClose>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01OpenClose/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]

    my integer $open_success = open my filehandleref $HOWDY, '>', '/tmp/howdy';
    if ( not $open_success ) {
        croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
    }

    my integer $print_success = ( print {$HOWDY} 23, 32, 42 );
    if ( not $print_success ) {
        croak 'ERROR: Failed to write to file /tmp/howdy, croaking';
    }

    if ( not close $HOWDY ) {
        croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
    }

=item * L<Operator03IncrementDecrement|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator03IncrementDecrement>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator03IncrementDecrement/program_00_good.pl>

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

    my integer $foo = 2;
    my integer $bar = 3;

    $foo++;

    my integer $bat = $foo++;

    $bar--;

    my integer $baz = $bar--;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

    ++$foo;

    $bat = ++$foo;

    --$bar;

    $baz = --$bar;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

=item * L<Operator04ArithmeticPower|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator04ArithmeticPower>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator04ArithmeticPower/program_00_good.pl>

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

    my integer $foo = 2**3;
    my integer $bar = 3**2;

    my integer $bat = $foo**$bar;

    my integer $baz = $bar**$foo;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

    $foo = 2;
    $bar = 3;
    $bat = ( $foo**2 )**$bar;
    $baz = $foo**( 2**$bar );
    my integer $bax = $foo**2**$bar;    # right associative

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator05LogicalNegation|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator05LogicalNegation>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator05LogicalNegation/program_00_good.pl>

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

    my integer $foo = 0;
    my integer $bar = 1;
    my integer $bat = !$foo;
    my integer $baz = !($bar);

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

    $foo = 2;
    $bar = 3;
    $bat = !2;                  # returns empty string ''
    $baz = !( $foo - $bar );    # returns empty string ''
    my integer $bax = !!$foo;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator05ArithmeticNegative|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator05ArithmeticNegative>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator05ArithmeticNegative/program_00_good.pl>

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

    my integer $foo = 3;
    my integer $bar = -3;            # Literal Number, not Operator
    my integer $bat = -(3);          # Operator(Literal Number)
    my integer $baz = 5 - -($bar);

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

    $foo = -(-3);                    # Operator(Literal Number)
    $bar = -( -(3) );                # Operator(Operator(Literal Number))
    $bat = $foo + -($bar);
    $baz = $foo - -($bar);

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

=item * L<Operator06RegularExpressionMatch|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator06RegularExpressionMatch>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator06RegularExpressionMatch/program_00_good.pl>

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

    my string $foo  = 'howdy hello ahoy';
    my integer $bar = $foo =~ m/owdy/msx;
    my integer $bat = ( $foo =~ m/Hello/msx );
    my integer $baz = ( $foo =~ m/\s[Aa]hoy$/msx );
    my integer $bax = ( $foo =~ s/ho/HO/gms );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $foo = 'Alpha Bravo Charlie 123';
    $bar = ( $foo !~ m/owdy/msx );
    $bat = ( $foo !~ m/ravo/msx );
    $baz = ( $foo !~ m/\s[Cc]harlie\s\d*$/msx );
    $bax = ( $foo !~ s/ha/HAHA/gms );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator07StringRepeat|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator07StringRepeat>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator07StringRepeat/program_00_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: "have $foo = ''" >>>
    # <<< EXECUTE_SUCCESS: "have $bar = 'bar'" >>>
    # <<< EXECUTE_SUCCESS: "have $bat = 'batbat'" >>>
    # <<< EXECUTE_SUCCESS: "have $baz = 'bazbazbazbaz'" >>>
    # <<< EXECUTE_SUCCESS: "have $bax = 'baxbaxbaxbaxbaxbaxbaxbax'" >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ OPERATIONS ]]]

    my string $foo = 'foo' x 0;
    my string $bar = 'bar' x 1;
    my string $bat = 'bat' x 2;
    my string $baz = 'baz' x 4;
    my string $bax = 'bax' x 8;

    print q{have $foo = '}, $foo, q{'}, "\n";
    print q{have $bar = '}, $bar, q{'}, "\n";
    print q{have $bat = '}, $bat, q{'}, "\n";
    print q{have $baz = '}, $baz, q{'}, "\n";
    print q{have $bax = '}, $bax, q{'}, "\n";

=item * L<Operator07ArithmeticMultiplyDivideModulo|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator07ArithmeticMultiplyDivideModulo>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator07ArithmeticMultiplyDivideModulo/program_00_good.pl>

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

    my number $foo = 222 * -33;
    my number $bar = 222 / 33;
    my number $bat = 222 % 33;
    my number $baz = $foo % $bar * $bat / 4;
    my number $bax = $foo % ( $bar * ( $bat / 4 ) );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator08AddSubtract|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator08AddSubtract>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator08AddSubtract/program_00_good.pl>

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

    my number $foo = 222 + 33;
    my number $bar = 222 - 33;
    my number $bat = 222 + -33;
    my number $baz = $foo - $bar + $bat - 4;
    my number $bax = $foo - ( $bar + ( $bat - 4 ) );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator08StringCat|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator08StringCat>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator08StringCat/program_00_good.pl>

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

    my string $foo = 'howdy' . 'doody';
    my string $bar = 'hello' . ('and' . 'goodbye');
    my string $bat = ('ahoy' . 'matey') . 'yarr';
    my string $baz = $foo . $bar . $bat;
    my string $bax = $foo . $foo . $foo;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator09BitwiseShift|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator09BitwiseShift>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator09BitwiseShift/program_00_good.pl>

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

    my integer $foo = 1_024;
    my integer $bar = 256;
    my integer $bat = 4_096 << 3;
    my integer $baz = $foo << 3;
    my integer $bax = $bar >> 4;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator11CompareLessThanGreaterThan|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator11CompareLessThanGreaterThan>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator11CompareLessThanGreaterThan/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo < 22;
    my integer $baz = 22 < $foo;
    my integer $bax = 33 <= 44;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $foo > 333_333_333_333;
    $baz = 444 >= 222;
    $bax = 9_123.456_789 >= $foo;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar lt 'ahoy';
    $baz = 'ZZZZZZZZZZZZZZ' lt $bar;
    $bax = '33' le '44';

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar gt 'abc';
    $baz = '144' ge '222';
    $bax = 'howdy' ge $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator12CompareEqualNotEqual|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator12CompareEqualNotEqual>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator12CompareEqualNotEqual/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo == 22;
    my integer $baz = 9_123.456_789 == $foo;
    my integer $bax = 33 != 44;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $foo == 333_333_333_333;
    $baz = 444 != 222;
    $bax = 33 != $foo;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar eq 'howdy';
    $baz = 'ZZZZZZZZZZZZZZ' eq $bar;
    $bax = '33' ne '44';

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar eq 'abc';
    $baz = '444' ne '222';
    $bax = '33' ne $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator13BitwiseAnd|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator13BitwiseAnd>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator13BitwiseAnd/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo & 22;
    my integer $baz = 9_123.456_789 & $foo;
    my integer $bax = 33 & 44;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar & 'abc';
    $baz = '444' & '222';
    $bax = '33' & $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator14BitwiseOrXor|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator14BitwiseOrXor>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator14BitwiseOrXor/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo | 22;
    my integer $baz = 9_123.456_789 | $foo;
    my integer $bax = 33 ^ 44;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar | 'abc';
    $baz = '444' ^ '222';
    $bax = '33' ^ $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator15LogicalAnd|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator15LogicalAnd>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator15LogicalAnd/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo && 22;
    my integer $baz = 9_123.456_789 && $foo;
    my integer $bax = 33 && 0;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar  && q{};
    $baz = '444' && '222';
    $bax = '33'  && $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator16LogicalOr|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator16LogicalOr>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator16LogicalOr/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = $foo || 22;
    my integer $baz = 9_123.456_789 || $foo;
    my integer $bax = 33 || 0;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = $bar  || q{};
    $baz = '444' || '222';
    $bax = '33'  || $bar;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator17ListRange|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator17ListRange>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator17ListRange/program_00_good.pl>

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

    my number $foo = 123;
    my string $bar = 'ab';
    my integer_arrayref $bat;
    $bat = [ $foo .. 22 ];
    my integer_arrayref $baz;
    $baz = [ 22 .. $foo ];
    my integer_arrayref $bax;
    $bax = [ 0 .. 23 ];

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', ::integer_arrayref_to_string($bat), "\n";
    print 'have $baz = ', ::integer_arrayref_to_string($baz), "\n";
    print 'have $bax = ', ::integer_arrayref_to_string($bax), "\n";

    my string_arrayref $bat2;
    $bat2 = [ $bar .. 'ac' ];
    my string_arrayref $baz2;
    $baz2 = [ 'a2' .. 'a4' ];
    my string_arrayref $bax2;
    $bax2 = [ 'a' .. $bar ];

    print 'have $bat2 = ', ::string_arrayref_to_string($bat2), "\n";
    print 'have $baz2 = ', ::string_arrayref_to_string($baz2), "\n";
    print 'have $bax2 = ', ::string_arrayref_to_string($bax2), "\n";

=item * L<Operator18Ternary|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator18Ternary>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator18Ternary/program_00_good.pl>

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

    my number $foo = 9_123.456_789;
    my number $bar = 2_112;
    my number $bat = ( 22 > 21 ) ? $foo : $bar;
    my number $baz = 0 ? $foo : $bar;
    my number $bax = 1 ? 99.9 : 100.1;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = ( 'howdy' ne 'dowdy' ) ? $foo : 22_222.33;
    $baz = ( 4 <= 4 )             ? 88   : $bar;
    $bax = ( 88 > 99 )            ? 21   : 12;

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator22LogicalNegation|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator22LogicalNegation>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator22LogicalNegation/program_00_good.pl>

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

    my integer $foo = 0;
    my integer $bar = 1;
    my integer $bat = not $foo;
    my integer $baz = not ($bar);

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";

    $foo = 2;
    $bar = 3;
    $bat = not 2;                  # returns empty string ''
    $baz = not ( $foo - $bar );    # returns empty string ''
    my integer $bax = not not $foo;

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator23LogicalAnd|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator23LogicalAnd>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator23LogicalAnd/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = ($foo and 22);
    my integer $baz = (9_123.456_789 and $foo);
    my integer $bax = (33 and 0);

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = ($bar  and q{});
    $baz = ('444' and '222');
    $bax = ('33'  and $bar);

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=item * L<Operator24LogicalOrXor|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator24LogicalOrXor>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator24LogicalOrXor/program_00_good.pl>

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

    my number $foo  = 9_123.456_789;
    my string $bar  = 'howdy';
    my integer $bat = ( $foo or 22 );
    my integer $baz = ( 9_123.456_789 or $foo );
    my integer $bax = ( 33 xor 0 );

    print 'have $foo = ', $foo, "\n";
    print 'have $bar = ', $bar, "\n";
    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

    $bat = ( $bar  or q{} );
    $baz = ( '444' xor '222' );
    $bax = ( '33'  xor $bar );

    print 'have $bat = ', $bat, "\n";
    print 'have $baz = ', $baz, "\n";
    print 'have $bax = ', $bax, "\n";

=back

I<OperatorVoid>

=over 16

=item * L<OperatorVoid01Print|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01Print>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01Print/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ OPERATIONS ]]]

    # USER NOTE: the OperatorVoid (not Operator) production rule matched by 'print' has optional STDOUT, STDERR, or filehandle

    print 2;
    print 2, 3, 4, "\n";
    print 2.31;
    print 2.31, 3.21, 4.23, "\n";
    print 'howdy';
    print 'howdy', 'doody', 'foobar', "\n";
    print 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

    print {*STDOUT} 2;
    print {*STDOUT} 2, 3, 4, "\n";
    print {*STDOUT} 2.31;
    print {*STDOUT} 2.31, 3.21, 4.23, "\n";
    print {*STDOUT} 'howdy';
    print {*STDOUT} 'howdy', 'doody', 'foobar', "\n";
    print {*STDOUT} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

    print {*STDERR} 2;
    print {*STDERR} 2, 3, 4, "\n";
    print {*STDERR} 2.31;
    print {*STDERR} 2.31, 3.21, 4.23, "\n";
    print {*STDERR} 'howdy';
    print {*STDERR} 'howdy', 'doody', 'foobar', "\n";
    print {*STDERR} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

    my integer $open_success = open my filehandleref $HOWDY, '>', '/tmp/howdy';
    if ( not $open_success ) {
        croak 'ERROR: Failed to open file /tmp/howdy for writing, croaking';
    }

    # USER NOTE: return values of OperatorVoid print-to-filehandle are always ignored, possibly ignoring write errors
    print {$HOWDY} 2;
    print {$HOWDY} 2, 3, 4, "\n";
    print {$HOWDY} 2.31;
    print {$HOWDY} 2.31, 3.21, 4.23, "\n";
    print {$HOWDY} 'howdy';
    print {$HOWDY} 'howdy', 'doody', 'foobar', "\n";
    print {$HOWDY} 'howdy', 2.31, 'doody', 3.21, 'foobar', 4.23, "\n";

    if ( not close $HOWDY ) {
        croak 'ERROR: Failed to close file /tmp/howdy after writing, croaking';
    }

=item * L<OperatorVoid01Named|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01Named>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01Named/program_00_good.pl>

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
    my integer_arrayref $frob = [];
    push @{$frob}, 21, 12, 23;    # OperatorVoid, no parentheses required for built-in w/ multiple arguments in void context
    print 'have $frob = ', "\n", Dumper($frob), "\n";

=item * L<OperatorVoid01NamedVoidCroak|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01NamedVoidCroak>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01NamedVoidCroak/program_00_good.pl>

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
    croak;

=item * L<OperatorVoid01NamedVoidDie|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01NamedVoidDie>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01NamedVoidDie/program_00_good.pl>

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
    die "\n";

=item * L<OperatorVoid01NamedVoidExit|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01NamedVoidExit>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01NamedVoidExit/program_00_good.pl>

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
    exit;

=item * L<OperatorVoid01NamedVoidReturn|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/OperatorVoid01NamedVoidReturn>

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/OperatorVoid01NamedVoidReturn/program_01_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ SUBROUTINES ]]]

    # DEV NOTE: DO NOT RUN PERLTIDY ON THIS FILE!  the line below should read 'return();' not 'return ();'
    our void $foo = sub {
        return();
    };

    # [[[ OPERATIONS ]]]
    foo();

=item * L<Operator19LoopControl|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator19LoopControl>

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator19LoopControl/program_01_good.pl>

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

    HOWDYLOOP:
    while (1) {
        next HOWDYLOOP;
    }

=back

I<Expression>

=over 16

=item * L<Constant|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Constant>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Constant/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CONSTANTS ]]]
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';

    # [[[ OPERATIONS ]]]
    my integer $i = 2 + 2;

=back

I<SubExpression>

=over 16

=item * L<SubExpression|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/SubExpression>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/SubExpression/program_00_good.pl>

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

    my integer $foo = undef;

L<program_07_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/SubExpression/program_07_good.pl>

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

    my string_hashref $foo = { puppet => 'howdy doody', host => 'buffalo bob', sidekick => 'clarabell clown' };
    keys %{$foo};

=item * L<LiteralNumber|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/LiteralNumber>

L<Package_30_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/LiteralNumber/Package_30_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::LiteralNumber::Package_30_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ SUBROUTINES ]]]
    our number $empty_sub = sub {
        return 0.234_567_89;
    };

    1;    # end of package

=item * L<LiteralString|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/LiteralString>

L<Package_DoubleQuotes_10_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/LiteralString/Package_DoubleQuotes_10_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::LiteralString::Package_DoubleQuotes_10_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ SUBROUTINES ]]]
    our string $empty_sub = sub {
        return "{foo}\n";
    };

    1;    # end of package

L<Package_QQuotes_07_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/LiteralString/Package_QQuotes_07_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::LiteralString::Package_QQuotes_07_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ SUBROUTINES ]]]
    our string $empty_sub = sub {
        return q{@ $};
    };

    1;    # end of package

L<Package_SingleQuotes_07_Good.pm|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/LiteralString/Package_SingleQuotes_07_Good.pm>

    # [[[ HEADER ]]]
    use RPerl;
    package RPerl::Test::LiteralString::Package_SingleQuotes_07_Good;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ SUBROUTINES ]]]
    our string $empty_sub = sub {
        return '@ $';
    };

    1;    # end of package

=item * L<ArrayReference|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/ArrayReference>

L<program_10_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/ArrayReference/program_10_good.pl>

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

    # homogeneous 2-dimensional array of arrays, using inner types
    my arrayref_arrayref $array_array = [
        my integer_arrayref $TYPED_array_array_0 = [ 17,   -23, 1_701 ],
        my integer_arrayref $TYPED_array_array_1 = [ -1,   444, 2_987 ],
        my integer_arrayref $TYPED_array_array_2 = [ -321, 7,   24_851 ]
    ];
    foreach my arrayref $array ( @{$array_array} ) {
        print '$array = ', Dumper($array), "\n";
    }

L<program_15_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/ArrayReference/program_15_good.pl>

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

    my string_arrayref $s_array = ['buffalo', qw(alpha beta gamma), 'howdy'];
    foreach my string $s ( @{$s_array} ) {
        print '$s = ', $s, "\n";
    }

=item * L<ArrayDereference|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/ArrayDereference>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/ArrayDereference/program_00_good.pl>

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

    foreach my integer $i ( @{ [ 10, 20, 30, 40, 50 ] } ) {
        print '$i = ', $i, "\n";
    }

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/ArrayDereference/program_01_good.pl>

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

    foreach my integer $i ( @{ my integer_arrayref $TYPED_i_array = [ 10, 20, 30, 40, 50 ] } )
    {
        print '$i = ', $i, "\n";
    }

L<program_02_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/ArrayDereference/program_02_good.pl>

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

    foreach my integer $i ( @{ [ my integer $TYPED_i0 = 10, 20, 30, 40, 50 ] } ) {
        print '$i = ', $i, "\n";
    }

=item * L<HashReference|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/HashReference>

L<program_10_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashReference/program_10_good.pl>

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

    # homogeneous 2-dimensional hash of hashes, using inner types
    my hashref_hashref $hash_hash = {
        key_0 => my integer_hashref $TYPED_key_0
            = { a => 17, b => -23, c => 1_701 },
        key_1 => my integer_hashref $TYPED_key_1
            = { d => -1, e => 444, f => 2_987 },
        key_2 => my integer_hashref $TYPED_key_2
            = { g => -321, h => 7, i => 24_851 }
    };
    print Dumper($hash_hash);

L<program_14_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashReference/program_14_good.pl>

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

    my number $key_number = 0.1;
    my string $key_string = '0.1';

    my hashref $unknown_hash = {
        key0 => my integer $TYPED_key0              = -23,
        0    => my number_arrayref $TYPED_zero      = [ 42 / 1_701, 21.12, 2_112.23 ],
        0.1  => my string_hashref $TYPED_zerodotone = { 'alpha' => 'strings are scalars, too', 12.345_678 => 'hello world', gamma => 'last one' },
        '0.1'       => 'replacement',
        "0.1\n"     => 'close but not quite',
        $key_number => 'another replacement',
        $key_string => 'final replacement'
    };

    print Dumper($unknown_hash);

=item * L<HashDereference|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/HashDereference>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashDereference/program_00_good.pl>

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

    foreach my string $key ( sort keys %{ { a => 10, b => 20, c => 30, d => 40, e => 50 } } )
    {
        print '$key = ', $key, "\n";
    }

L<program_01_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashDereference/program_01_good.pl>

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

    foreach my string $key ( sort keys %{ my integer_hashref $TYPED_i_hash = { a => 10, b => 20, c => 30, d => 40, e => 50 } } )
    {
        print '$key = ', $key, "\n";
    }

L<program_02_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashDereference/program_02_good.pl>

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

    foreach my string $key ( sort keys %{ { a => my integer $TYPED_a = 10, b => 20, c => 30, d => 40, e => 50 } } )
    {
        print '$key = ', $key, "\n";
    }

L<program_03_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/HashDereference/program_03_good.pl>

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

    foreach my string $key ( sort keys %{ my integer_hashref $TYPED_i_hash = { a => my integer $TYPED_a = 10, b => 20, c => 30, d => 40, e => 50 } }) {
        print '$key = ', $key, "\n";
    }

=back

I<SubExpressionOrInput>

=over 16

=item * L<SubExpressionOrStdin|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/SubExpressionOrStdin>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/SubExpressionOrStdin/program_00_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

    # [[[ OPERATIONS ]]]

    my string $foo;
    $foo = <STDIN>;

=back

I<Statement>

=over 16

=item * L<Conditional|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Conditional>

L<program_03_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Conditional/program_03_good.pl>

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

    if    (0) {
        print 'yes if',      "\n";
    }
    elsif (0) {
        print 'yes elsif 0', "\n";
    }
    elsif (0) {
        print 'yes elsif 1', "\n";
    }
    else      {
        print 'yes else',    "\n";
    }

=item * L<Loop|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Loop>

L<program_04_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Loop/program_04_good.pl>

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

    TESTFORLOOP:
    for my unsigned_integer $i ( 0 .. 4 ) {
        print 'Production rule Loop matched by LoopFor, iteration number ', $i, "\n";
        if ( $i > 1 ) {
            last TESTFORLOOP;
        }
    }

L<program_23_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Loop/program_23_good.pl>

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

    TESTFOREACHLOOP:
    foreach my number $my_number ( 1.1, 2.2, 3.3, 4.4 ) {
        if ( $my_number == 3.3 ) {
            next TESTFOREACHLOOP;
        }
        print 'Production rule Loop matched by LoopForEach, iteration item ',
            $my_number, "\n";
    }

L<program_32_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Loop/program_32_good.pl>

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

    my integer $i = 0;
    TESTWHILELOOP:
    while ( $i < 7 ) {
        $i++;
        if ( $i == 3 ) {
            next TESTWHILELOOP;
        }
        print 'Production rule Loop matched by LoopWhile, iteration item ', $i,
            "\n";
    }

=item * L<VariableDeclaration|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/VariableDeclaration>

L<program_05_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableDeclaration/program_05_good.pl>

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

    my unknown $foo;

L<program_14_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableDeclaration/program_14_good.pl>

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

    my string_hashref $s_hash
        = { a => 'howdy', b => 'doody', c => 'clarabell' };

L<program_23_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableDeclaration/program_23_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: 'size of $foo is 10' >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ OPERATIONS ]]]

    my integer $size_max_half = 5;
    my number_arrayref $foo->[($size_max_half * 2) - 1] = undef;
    print 'size of $foo is ', ( scalar @{$foo} ), "\n";

L<program_30_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableDeclaration/program_30_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ OPERATIONS ]]]

    my filehandleref $FOO_FH;

L<program_40_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableDeclaration/program_40_good.pl>

    #!/usr/bin/perl
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

    # [[[ INCLUDES ]]]
    use RPerl::Test;

    # [[[ OPERATIONS ]]]

    my RPerl::Test $foo = RPerl::Test->new();

=item * L<VariableModification|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/VariableModification>

L<program_03_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableModification/program_03_good.pl>

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

    my integer_arrayref $i_array;
    $i_array = [ -20, -15, -10, -5, 0, 5, 10, 15, 20 ];

L<program_10_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/VariableModification/program_10_good.pl>

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

    my unknown $foo;
    $foo = [
        'strange', { weird => 'goofy', beard => [ 'goatee', -17.01 ] },
        23.42, 'heterogeneous'
    ];

=back

=head3 D.4.3: Variable Data

C<[[[ SYNTAX PRODUCTION RULES, VARIABLE DATA ]]]>

=for rperl X<noncode>

    Variable:                VariableSymbolOrSelf VariableRetrieval* ;
    VariableRetrieval:       OP02_ARRAY_THINARROW SubExpression ']' | OP02_HASH_THINARROW SubExpression '}' | OP02_HASH_THINARROW WORD '}' ;
    VariableDeclaration:     MY Type VARIABLE_SYMBOL ';' | MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn | 
                             MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';' | MY TYPE_FHREF FHREF_SYMBOL ';' ;
    VariableModification:    Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput | Variable OP19_VARIABLE_ASSIGN_BY SubExpression ;
    ListElements:            ListElement (OP21_LIST_COMMA ListElement)* ;
    ListElement:             SubExpression | TypeInner SubExpression | OP01_QW | ARGV;
    ArrayReference:          LBRACKET ListElements? ']' ;
    ArrayDereference:        '@{' Variable '}' | '@{' TypeInner? ArrayReference '}' ;
    HashEntry:               VarOrLitOrOpStrOrWord OP20_HASH_FATARROW TypeInner? SubExpression | HashDereference | ENV ;
    HashEntryProperties:     OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties ;
    HashReference:           LBRACE HashEntry (OP21_LIST_COMMA HashEntry)* '}' | LBRACE '}' ;
    HashDereference:         '%{' Variable '}' | '%{' TypeInner? HashReference '}' ;

=for rperl X</noncode>

B<Code Examples:>

I<ListElement>

=over 16

=item * L<Operator01QuoteWord|https://github.com/wbraswell/rperl/tree/master/lib/RPerl/Test/Operator01QuoteWord>

L<program_00_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01QuoteWord/program_00_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: 'foo' >>>
    # <<< EXECUTE_SUCCESS: 'quux' >>>
    # <<< EXECUTE_SUCCESS: 'zorg' >>>
    # <<< EXECUTE_SUCCESS: 'munge' >>>
    # <<< EXECUTE_SUCCESS: 'frob' >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ OPERATIONS ]]]

    my string_arrayref $s_array = [qw(foo quux zorg munge frob)];
    foreach my string $s ( @{$s_array} ) {
        print '$s = ', $s, "\n";
    }

L<program_06_good.pl|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Test/Operator01QuoteWord/program_06_good.pl>

    #!/usr/bin/perl

    # [[[ PREPROCESSOR ]]]
    # <<< EXECUTE_SUCCESS: '-1bar-5bat' >>>
    # <<< EXECUTE_SUCCESS: 'qu23ux' >>>
    # <<< EXECUTE_SUCCESS: 'zorg0+blop+0frun' >>>
    # <<< EXECUTE_SUCCESS: 'munge4/4sqap6/6cruft' >>>
    # <<< EXECUTE_SUCCESS: '88frob*99grul99*jick88' >>>
    # <<< EXECUTE_SUCCESS: '`~!@$%^&*-_=+[]{}|;:'".<>/?' >>>

    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;

    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

    # [[[ OPERATIONS ]]]

    my string_arrayref $s_array = [qw(-1bar-5bat qu23ux zorg0+blop+0frun munge4/4sqap6/6cruft 88frob*99grul99*jick88 `~!@$%^&*-_=+[]{}|;:'".<>/?)];
    foreach my string $s ( @{$s_array} ) {
        print '$s = ', $s, "\n";
    }

=back

=head3 D.4.4: User-Defined Words

C<[[[ SYNTAX PRODUCTION RULES, USER-DEFINED WORDS ]]]>

=for rperl X<noncode>

    WordScoped:              WORD | WORD_SCOPED ;
    LoopLabel:               WORD_UPPERCASE ;
    Type:                    WORD | WORD_SCOPED | TYPE_INTEGER ;
    TypeInner:               MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN ;
    TypeInnerProperties:     MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression | 
                             MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ;
    TypeInnerConstant:       MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN ;
    VariableOrLiteral:       Variable | Literal ;
    VarOrLitOrOpStrOrWord:   Variable | Literal | OpStringOrWord ;
    VariableSymbolOrSelf:    VARIABLE_SYMBOL | SELF ;
    Literal:                 LITERAL_NUMBER | LITERAL_STRING ;
    OpNamedScolonOrSubExp:   OP01_NAMED_SCOLON | OP10_NAMED_UNARY_SCOLON | SubExpression ';' ;
    OpNamedScolonOrSubExpIn: OP01_NAMED_SCOLON | OP10_NAMED_UNARY_SCOLON | SubExpressionOrInput ';' ;
    OpStringOrWord:          OP24_LOGICAL_OR_XOR | OP23_LOGICAL_AND | OP22_LOGICAL_NEG | OP19_LOOP_CONTROL_SCOLON | OP19_LOOP_CONTROL | OP12_COMPARE_EQ_NE |
                             OP11_COMPARE_LT_GT | OP10_NAMED_UNARY | OP08_MATH_ADD_SUB | OP07_MATH_MULT_DIV_MOD | OP07_STRING_REPEAT | OP01_NAMED | OP01_CLOSE | 
                             OP01_OPEN | OP01_NAMED_VOID | OP01_PRINT | WORD ;

=for rperl X</noncode>

B<There are no additional code examples for this section, all pertinent examples are contained in the previous sections.>

X<br>


=head1 APPENDIX E: BEYOND THE ROADRUNNER

=for html <u>

B<Intermediate RPerl>

=for html </u>

The Scallion Book

X<br>


=for html <u>

B<Mastering RPerl>

=for html </u>

The Sword Book

X<br>


=head1 SEE ALSO

L<RPerl>

L<rperl>

X<br>


=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:william.braswell@NOSPAM.autoparallel.com>

=for DEV NOTE: END INLINE CSS DIV

=for html </div>

=cut
