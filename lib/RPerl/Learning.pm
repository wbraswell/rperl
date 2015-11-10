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

    Welcome to the Roadrunner Book!
    Learning Perl
    Is this book right for you?
    Why aren't there more footnotes?
    What about the exercises & their answers?
    What do those numbers at the start of the exercise mean?
    What if I'm an RPerl course instructor?
    What does RPerl stand for?
    Why did Will create RPerl?
    Why didn't Will just use normal Perl or some other language?
    Is RPerl easy or hard?
    How did RPerl get to be so popular?
    What's happening with RPerl now?
    What's RPerl really good for?
    What is RPerl not good for?
    How can I get RPerl?
    What is CPAN?
    How can I get support for RPerl?
    Are there any other kinds of support?
    What if I find a bug in RPerl?
    How do I make an RPerl program?
    A simple RPerl program
    What's inside that RPerl program?
    How do I compile RPerl?
    A whirlwind tour of RPerl
 
    Exercises
    LMPC
    history of RPerl
    Book of RPerl
    performance

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
