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
    CHAPTER 1: INTRODUCTION
    CHAPTER 2: SCALAR DATA
    CHAPTER 3: LISTS & ARRAYS
    CHAPTER 4: SUBROUTINES
    CHAPTER 5: INPUT & OUTPUT
    CHAPTER 6: HASHES
    ...
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

    Dynamic languages 
     like Perl are fast at running some kinds of computation such as string manipulation (editing text data), but slow at running general purpose computations.

=head2 Is RPerl easy or hard?
=head2 How did RPerl get to be so popular?
=head2 What's happening with RPerl now?
=head2 What's RPerl really good for?
=head2 What is RPerl not good for?
=head2 How can I get RPerl?
=head2 What is CPAN?
=head2 How can I get support for RPerl?
=head2 Are there any other kinds of support?
=head2 What if I find a bug in RPerl?
=head2 How do I make an RPerl program?
=head2 A simple RPerl program
=head2 What's inside that RPerl program?
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
