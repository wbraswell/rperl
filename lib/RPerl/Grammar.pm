########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.21.
#
# Copyright © 2006, 2007, 2008, 2009, 2010, 2011, 2012 Casiano Rodriguez-Leon.
# Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
# Parse::Yapp is Copyright © 1998, 1999, 2000, 2001, Francois Desarmenien.
# Parse::Yapp is Copyright © 2017 William N. Braswell, Jr.
# All Rights Reserved.
#
#        Don't edit this file, use source file 'lib/RPerl/Grammar.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package RPerl::Grammar;
use strict;

push @RPerl::Grammar::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 5 "lib/RPerl/Grammar.eyp"

    # [[[ HEADER ]]]
    use strict;
    use warnings;
    our $VERSION = 0.018_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|package|foreach|\$TYPED_|while|elsif|undef|\@ARG\;|else|INIT|for|\@\{|if|\%\{|\]|\)|\}|\;)}gc and return ($1, $1);

      /\G(\=[a-zA-Z].*?\n(?:.|\n)*?\n\=cut\s*)/gc and return ('POD', $1);
      /\G(^#!\/(?:\w[\w-]*\/)*[\w-]*\s*[\w-]*perl[\w-]*)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(\s*use\s+RPerl::Exporter\s+qw\(\s*import\s*\)\s*;\s*)/gc and return ('USE_EXPORTER', $1);
      /\G(use\s+)/gc and return ('USE', $1);
      /\G(\s*our\s+\@EXPORT\s+\=\s*)/gc and return ('OUR_EXPORT', $1);
      /\G(\s*our\s+\@EXPORT_OK\s+\=\s*)/gc and return ('OUR_EXPORT_OK', $1);
      /\G(our\s+)/gc and return ('OUR', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(sub)\s+/gc and return ('SUB', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('([^'\\]+|(?:\\\\)+)+')|("((\\n)|(\\t)|[^"\@\$\\])*((\\n)|(\\t))+((\\n)|(\\t)|[^"\@\$\\])*")|(q\{([^}\\]+|(?:\\\\)+)*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$self)/gc and return ('SELF', $1);
      /\G(\$(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer|unsigned_integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G((?:[a-zA-Z]\w*)+(?:::[a-zA-Z]\w*)*::method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)(?:::[a-zA-Z]\w*)*(?:::[A-Z0-9_]*)\(\))/gc and return ('CONSTANT_CALL_SCOPED', $1);
      /\G((?:[a-zA-Z_]\w*)?(?:::[a-zA-Z_]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(\@ARGV)/gc and return ('ARGV', $1);
      /\G(\%ENV)/gc and return ('ENV', $1);
      /\G(or|xor)\s/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)\s/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not\()\s/gc and return ('OP22_LOGICAL_NEG_LPAREN', $1);
      /\G(not)\s/gc and return ('OP22_LOGICAL_NEG', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next;|last;)/gc and return ('OP19_LOOP_CONTROL_SCOLON', $1);
      /\G(next|last|redo)\s/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|<=>|eq|ne|cmp)\s/gc and return ('OP12_COMPARE_EQ_NE', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(-A;|-B;|-C;|-M;|-O;|-R;|-S;|-T;|-W;|-X;|-b;|-c;|-d;|-e;|-f;|-g;|-k;|-l;|-o;|-p;|-r;|-s;|-t;|-u;|-w;|-x;|-z;|alarm;|caller;|chdir;|chroot;|cos;|defined;|delete;|do;|eval;|exists;|gethostbyname;|getnetbyname;|getpgrp;|getprotobyname;|glob;|gmtime;|goto;|hex;|int;|lc;|lcfirst;|length;|localtime;|lock;|log;|lstat;|oct;|ord;|quotemeta;|rand;|readlink;|ref;|require;|rmdir;|scalar;|sin;|sleep;|sqrt;|srand;|stat;|uc;|ucfirst;|umask;)/gc and return ('OP10_NAMED_UNARY_SCOLON', $1);
      /\G(-A\s|-B\s|-C\s|-M\s|-O\s|-R\s|-S\s|-T\s|-W\s|-X\s|-b\s|-c\s|-d\s|-e\s|-f\s|-g\s|-k\s|-l\s|-o\s|-p\s|-r\s|-s\s|-t\s|-u\s|-w\s|-x\s|-z\s|alarm\s|caller\s|chdir\s|chroot\s|cos\s|defined\s|delete\s|do\s|eval\s|exists\s|gethostbyname\s|getnetbyname\s|getpgrp\s|getprotobyname\s|glob\s|gmtime\s|goto\s|hex\s|int\s|lc\s|lcfirst\s|length\s|localtime\s|lock\s|log\s|lstat\s|oct\s|ord\s|quotemeta\s|rand\s|readlink\s|ref\s|require\s|rmdir\s|scalar\s|sin\s|sleep\s|sqrt\s|srand\s|stat\s|uc\s|ucfirst\s|umask\s)/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(\+=|-=|\*=|\/=|\.=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%|sse_mul|sse_div)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x)\s/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_BIND', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(\~\()/gc and return ('OP05_BITWISE_NEG_LPAREN', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->new\()/gc and return ('OP02_METHOD_THINARROW_NEW', $1);
      /\G(->import\()/gc and return ('OP02_METHOD_THINARROW_IMP', $1);
      /\G(->[a-zA-Z_]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-\s|sse_add|sse_sub)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|le|ge|lt|gt)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\([^()]*\))/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(abs;|accept;|atan2;|bind;|binmode;|bless;|break;|chmod;|chomp;|chop;|chown;|chr;|closedir;|connect;|continue;|crypt;|dbmclose;|dbmopen;|default;|dump;|each;|endgrent;|endhostent;|endnetent;|endprotoent;|endpwent;|endservent;|eof;|evalbytes;|exec;|exp;|fc;|fcntl;|fileno;|flock;|fork;|format;|formline;|getc;|getgrent;|getgrgid;|getgrnam;|gethostbyaddr;|gethostent;|getlogin;|getnetbyaddr;|getnetent;|getpeername;|getppid;|getpriority;|getprotobynumber;|getprotoent;|getpwent;|getpwnam;|getpwuid;|getservbyname;|getservbyport;|getservent;|getsockname;|getsockopt;|given;|grep;|index;|ioctl;|join;|keys;|kill;|link;|listen;|local;|m;|map;|mkdir;|msgctl;|msgget;|msgrcv;|msgsnd;|opendir;|pack;|pipe;|pop;|pos;|prototype;|push;|q;|qq;|qr;|qx;|read;|readdir;|readline;|readpipe;|recv;|rename;|reset;|reverse;|rewinddir;|rindex;|s;|say;|seek;|seekdir;|select;|semctl;|semget;|semop;|send;|setgrent;|sethostent;|setnetent;|setpgrp;|setpriority;|setprotoent;|setpwent;|setservent;|setsockopt;|shift;|shmctl;|shmget;|shmread;|shmwrite;|shutdown;|socket;|socketpair;|sort;|splice;|split;|sprintf;|state;|study;|substr;|symlink;|syscall;|sysopen;|sysread;|sysseek;|system;|syswrite;|tell;|telldir;|tie;|tied;|time;|times;|tr;|truncate;|unless;|unlink;|unpack;|unshift;|untie;|until;|utime;|values;|vec;|wait;|waitpid;|wantarray;|warn;|when;|write;|y;)/gc and return ('OP01_NAMED_SCOLON', $1);
      /\G(abs\s|accept\s|atan2\s|bind\s|binmode\s|bless\s|break\s|chmod\s|chomp\s|chop\s|chown\s|chr\s|closedir\s|connect\s|continue\s|crypt\s|dbmclose\s|dbmopen\s|default\s|dump\s|each\s|endgrent\s|endhostent\s|endnetent\s|endprotoent\s|endpwent\s|endservent\s|eof\s|evalbytes\s|exec\s|exp\s|fc\s|fcntl\s|fileno\s|flock\s|fork\s|format\s|formline\s|getc\s|getgrent\s|getgrgid\s|getgrnam\s|gethostbyaddr\s|gethostent\s|getlogin\s|getnetbyaddr\s|getnetent\s|getpeername\s|getppid\s|getpriority\s|getprotobynumber\s|getprotoent\s|getpwent\s|getpwnam\s|getpwuid\s|getservbyname\s|getservbyport\s|getservent\s|getsockname\s|getsockopt\s|given\s|grep\s|index\s|ioctl\s|join\s|keys\s|kill\s|link\s|listen\s|local\s|m\s|map\s|mkdir\s|msgctl\s|msgget\s|msgrcv\s|msgsnd\s|opendir\s|pack\s|pipe\s|pop\s|pos\s|prototype\s|push\s|q\s|qq\s|qr\s|qx\s|read\s|readdir\s|readline\s|readpipe\s|recv\s|rename\s|reset\s|reverse\s|rewinddir\s|rindex\s|s\s|say\s|seek\s|seekdir\s|select\s|semctl\s|semget\s|semop\s|send\s|setgrent\s|sethostent\s|setnetent\s|setpgrp\s|setpriority\s|setprotoent\s|setpwent\s|setservent\s|setsockopt\s|shift\s|shmctl\s|shmget\s|shmread\s|shmwrite\s|shutdown\s|socket\s|socketpair\s|sort\s|splice\s|split\s|sprintf\s|state\s|study\s|substr\s|symlink\s|syscall\s|sysopen\s|sysread\s|sysseek\s|system\s|syswrite\s|tell\s|telldir\s|tie\s|tied\s|time\s|times\s|tr\s|truncate\s|unless\s|unlink\s|unpack\s|unshift\s|untie\s|until\s|utime\s|values\s|vec\s|wait\s|waitpid\s|wantarray\s|warn\s|when\s|write\s|y\s)/gc and return ('OP01_NAMED', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);
      /\G([a-z_]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 157 lib/RPerl/Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@RPerl::Grammar::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.21',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'CompileUnit', '$end' ], 0 ],
  [ '_PAREN' => 'PAREN-1', [ 'ModuleHeader', 'Module' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PLUS-2', 'PAREN-1' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-2', [ 'PAREN-1' ], 0 ],
  [ 'CompileUnit_4' => 'CompileUnit', [ 'Program' ], 0 ],
  [ 'CompileUnit_5' => 'CompileUnit', [ 'PLUS-2' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-3', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [ 'STAR-4', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-4', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [ 'STAR-7', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-7', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'PLUS-8', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-8', [ 'Operation' ], 0 ],
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'USE_RPERL', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [ 'USE_RPERL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [  ], 0 ],
  [ 'ModuleHeader_23' => 'ModuleHeader', [ 'OPTIONAL-9', 'OPTIONAL-10', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_24' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_25' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [ 'STAR-13', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-14', [ 'STAR-14', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-14', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'PLUS-15', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'Subroutine' ], 0 ],
  [ 'Package_36' => 'Package', [ 'STAR-11', 'OPTIONAL-12', 'STAR-13', 'STAR-14', 'PLUS-15', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'USE_RPERL_AFTER' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ 'Header_39' => 'Header', [ 'use strict;', 'use warnings;', 'OPTIONAL-16', 'OUR', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'WORD' ], 0 ],
  [ 'Critic_42' => 'Critic', [ '## no critic qw(', 'PLUS-17', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OUR_EXPORT', 'OP01_QW', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [ 'PAREN-18' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [  ], 0 ],
  [ '_PAREN' => 'PAREN-20', [ 'OUR_EXPORT_OK', 'OP01_QW', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'PAREN-20' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ 'Exports_49' => 'Exports', [ 'USE_EXPORTER', 'OPTIONAL-19', 'OPTIONAL-21' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [ 'OP01_QW' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-22', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'OP01_QW' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ 'Include_54' => 'Include', [ 'USE', 'WordScoped', 'OPTIONAL-22', ';' ], 0 ],
  [ 'Include_55' => 'Include', [ 'INIT', 'LBRACE', 'WordScoped', 'OP02_METHOD_THINARROW_IMP', 'OPTIONAL-23', ')', ';', '}' ], 0 ],
  [ 'Constant_56' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Subroutine_61' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-24', 'STAR-25', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'PAREN-26' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'SubroutineArguments_65' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-27', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [ 'Exports' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-29', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [ 'STAR-32', 'SubroutineOrMethod' ], 0 ],
  [ '_STAR_LIST' => 'STAR-32', [  ], 0 ],
  [ 'Class_76' => 'Class', [ 'UseParent', 'WordScoped', ')', ';', 'Include', 'STAR-28', 'OPTIONAL-29', 'STAR-30', 'STAR-31', 'Properties', 'STAR-32', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'UseParent_77' => 'UseParent', [ 'use parent qw(' ], 0 ],
  [ 'UseParent_78' => 'UseParent', [ 'use parent -norequire, qw(' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [ 'STAR-34', 'PAREN-33' ], 0 ],
  [ '_STAR_LIST' => 'STAR-34', [  ], 0 ],
  [ 'Properties_82' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-34', '}', ';' ], 0 ],
  [ 'Properties_83' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [ 'STAR-36', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-36', [  ], 0 ],
  [ 'Method_88' => 'Method', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'TYPE_METHOD', '$RETURN_TYPE', '}', ';', 'OPTIONAL-35', 'STAR-36', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ 'MethodArguments_92' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-38', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_93' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_94' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_95' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_96' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_97' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_98' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_127' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_128' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_129' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-40', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_140' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_141' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_142' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-43', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-44', ')' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_158' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_159' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_163' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrInput_164' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_165' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_166' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_167' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_168' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'PAREN-45' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'Statement_172' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_173' => 'Statement', [ 'OPTIONAL-46', 'Loop' ], 0 ],
  [ 'Statement_174' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_175' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_176' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ 'Statement_177' => 'Statement', [ 'POD' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Conditional_184' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-48', 'OPTIONAL-50' ], 0 ],
  [ 'Loop_185' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_186' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_187' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_188' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_189' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_190' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_191' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_192' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'PLUS-51', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'Operation' ], 0 ],
  [ 'CodeBlock_195' => 'CodeBlock', [ 'LBRACE', 'PLUS-51', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'Variable_198' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-52' ], 0 ],
  [ 'VariableRetrieval_199' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_200' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_201' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_202' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_203' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_204' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_205' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_206' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_207' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [ 'STAR-54', 'PAREN-53' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [  ], 0 ],
  [ 'ListElements_211' => 'ListElements', [ 'ListElement', 'STAR-54' ], 0 ],
  [ 'ListElement_212' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_213' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_214' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_215' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'ArrayReference_218' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-55', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayDereference_221' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_222' => 'ArrayDereference', [ '@{', 'OPTIONAL-56', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_225' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'SubExpression' ], 0 ],
  [ 'HashEntry_226' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_227' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_228' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_232' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashReference_233' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashDereference_236' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_237' => 'HashDereference', [ '%{', 'OPTIONAL-60', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_238' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_239' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_240' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_241' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_242' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_243' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_244' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_245' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_246' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_247' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_248' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_249' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_250' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_251' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_252' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_253' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_254' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_255' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_256' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_257' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_258' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_259' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_260' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_261' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_262' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_272' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_273' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_274' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_275' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_276' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_277' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_278' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_279' => 'OpStringOrWord', [ 'WORD' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PAREN' => 1,
  '_PLUS_LIST' => 2,
  '_PLUS_LIST' => 3,
  'CompileUnit_4' => 4,
  'CompileUnit_5' => 5,
  '_OPTIONAL' => 6,
  '_OPTIONAL' => 7,
  '_STAR_LIST' => 8,
  '_STAR_LIST' => 9,
  '_STAR_LIST' => 10,
  '_STAR_LIST' => 11,
  '_STAR_LIST' => 12,
  '_STAR_LIST' => 13,
  '_STAR_LIST' => 14,
  '_STAR_LIST' => 15,
  '_PLUS_LIST' => 16,
  '_PLUS_LIST' => 17,
  'Program_18' => 18,
  '_OPTIONAL' => 19,
  '_OPTIONAL' => 20,
  '_OPTIONAL' => 21,
  '_OPTIONAL' => 22,
  'ModuleHeader_23' => 23,
  'Module_24' => 24,
  'Module_25' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_OPTIONAL' => 28,
  '_OPTIONAL' => 29,
  '_STAR_LIST' => 30,
  '_STAR_LIST' => 31,
  '_STAR_LIST' => 32,
  '_STAR_LIST' => 33,
  '_PLUS_LIST' => 34,
  '_PLUS_LIST' => 35,
  'Package_36' => 36,
  '_OPTIONAL' => 37,
  '_OPTIONAL' => 38,
  'Header_39' => 39,
  '_PLUS_LIST' => 40,
  '_PLUS_LIST' => 41,
  'Critic_42' => 42,
  '_PAREN' => 43,
  '_OPTIONAL' => 44,
  '_OPTIONAL' => 45,
  '_PAREN' => 46,
  '_OPTIONAL' => 47,
  '_OPTIONAL' => 48,
  'Exports_49' => 49,
  '_OPTIONAL' => 50,
  '_OPTIONAL' => 51,
  '_OPTIONAL' => 52,
  '_OPTIONAL' => 53,
  'Include_54' => 54,
  'Include_55' => 55,
  'Constant_56' => 56,
  '_OPTIONAL' => 57,
  '_OPTIONAL' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'Subroutine_61' => 61,
  '_PAREN' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  'SubroutineArguments_65' => 65,
  '_STAR_LIST' => 66,
  '_STAR_LIST' => 67,
  '_OPTIONAL' => 68,
  '_OPTIONAL' => 69,
  '_STAR_LIST' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  '_STAR_LIST' => 75,
  'Class_76' => 76,
  'UseParent_77' => 77,
  'UseParent_78' => 78,
  '_PAREN' => 79,
  '_STAR_LIST' => 80,
  '_STAR_LIST' => 81,
  'Properties_82' => 82,
  'Properties_83' => 83,
  '_OPTIONAL' => 84,
  '_OPTIONAL' => 85,
  '_STAR_LIST' => 86,
  '_STAR_LIST' => 87,
  'Method_88' => 88,
  '_PAREN' => 89,
  '_STAR_LIST' => 90,
  '_STAR_LIST' => 91,
  'MethodArguments_92' => 92,
  'SubroutineOrMethod_93' => 93,
  'SubroutineOrMethod_94' => 94,
  'Operation_95' => 95,
  'Operation_96' => 96,
  'Operation_97' => 97,
  'Operation_98' => 98,
  'Operator_99' => 99,
  'Operator_100' => 100,
  'Operator_101' => 101,
  'Operator_102' => 102,
  'Operator_103' => 103,
  'Operator_104' => 104,
  'Operator_105' => 105,
  'Operator_106' => 106,
  'Operator_107' => 107,
  'Operator_108' => 108,
  'Operator_109' => 109,
  'Operator_110' => 110,
  'Operator_111' => 111,
  'Operator_112' => 112,
  'Operator_113' => 113,
  'Operator_114' => 114,
  'Operator_115' => 115,
  'Operator_116' => 116,
  'Operator_117' => 117,
  'Operator_118' => 118,
  'Operator_119' => 119,
  'Operator_120' => 120,
  'Operator_121' => 121,
  'Operator_122' => 122,
  'Operator_123' => 123,
  'Operator_124' => 124,
  'Operator_125' => 125,
  'Operator_126' => 126,
  'Operator_127' => 127,
  'Operator_128' => 128,
  'Operator_129' => 129,
  '_PAREN' => 130,
  '_OPTIONAL' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  'OperatorVoid_135' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  'OperatorVoid_139' => 139,
  'OperatorVoid_140' => 140,
  'OperatorVoid_141' => 141,
  'OperatorVoid_142' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  '_OPTIONAL' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  'Expression_149' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'Expression_154' => 154,
  'SubExpression_155' => 155,
  'SubExpression_156' => 156,
  'SubExpression_157' => 157,
  'SubExpression_158' => 158,
  'SubExpression_159' => 159,
  'SubExpression_160' => 160,
  'SubExpression_161' => 161,
  'SubExpression_162' => 162,
  'SubExpression_163' => 163,
  'SubExpressionOrInput_164' => 164,
  'SubExpressionOrInput_165' => 165,
  'SubExpressionOrInput_166' => 166,
  'SubExpressionOrVarMod_167' => 167,
  'SubExpressionOrVarMod_168' => 168,
  '_PAREN' => 169,
  '_OPTIONAL' => 170,
  '_OPTIONAL' => 171,
  'Statement_172' => 172,
  'Statement_173' => 173,
  'Statement_174' => 174,
  'Statement_175' => 175,
  'Statement_176' => 176,
  'Statement_177' => 177,
  '_PAREN' => 178,
  '_STAR_LIST' => 179,
  '_STAR_LIST' => 180,
  '_PAREN' => 181,
  '_OPTIONAL' => 182,
  '_OPTIONAL' => 183,
  'Conditional_184' => 184,
  'Loop_185' => 185,
  'Loop_186' => 186,
  'Loop_187' => 187,
  'LoopFor_188' => 188,
  'LoopFor_189' => 189,
  'LoopForEach_190' => 190,
  'LoopWhile_191' => 191,
  'LoopWhile_192' => 192,
  '_PLUS_LIST' => 193,
  '_PLUS_LIST' => 194,
  'CodeBlock_195' => 195,
  '_STAR_LIST' => 196,
  '_STAR_LIST' => 197,
  'Variable_198' => 198,
  'VariableRetrieval_199' => 199,
  'VariableRetrieval_200' => 200,
  'VariableRetrieval_201' => 201,
  'VariableDeclaration_202' => 202,
  'VariableDeclaration_203' => 203,
  'VariableDeclaration_204' => 204,
  'VariableDeclaration_205' => 205,
  'VariableModification_206' => 206,
  'VariableModification_207' => 207,
  '_PAREN' => 208,
  '_STAR_LIST' => 209,
  '_STAR_LIST' => 210,
  'ListElements_211' => 211,
  'ListElement_212' => 212,
  'ListElement_213' => 213,
  'ListElement_214' => 214,
  'ListElement_215' => 215,
  '_OPTIONAL' => 216,
  '_OPTIONAL' => 217,
  'ArrayReference_218' => 218,
  '_OPTIONAL' => 219,
  '_OPTIONAL' => 220,
  'ArrayDereference_221' => 221,
  'ArrayDereference_222' => 222,
  '_OPTIONAL' => 223,
  '_OPTIONAL' => 224,
  'HashEntry_225' => 225,
  'HashEntry_226' => 226,
  'HashEntry_227' => 227,
  'HashEntryProperties_228' => 228,
  '_PAREN' => 229,
  '_STAR_LIST' => 230,
  '_STAR_LIST' => 231,
  'HashReference_232' => 232,
  'HashReference_233' => 233,
  '_OPTIONAL' => 234,
  '_OPTIONAL' => 235,
  'HashDereference_236' => 236,
  'HashDereference_237' => 237,
  'WordScoped_238' => 238,
  'WordScoped_239' => 239,
  'LoopLabel_240' => 240,
  'Type_241' => 241,
  'Type_242' => 242,
  'Type_243' => 243,
  'TypeInner_244' => 244,
  'TypeInnerProperties_245' => 245,
  'TypeInnerProperties_246' => 246,
  'TypeInnerConstant_247' => 247,
  'VariableOrLiteral_248' => 248,
  'VariableOrLiteral_249' => 249,
  'VarOrLitOrOpStrOrWord_250' => 250,
  'VarOrLitOrOpStrOrWord_251' => 251,
  'VarOrLitOrOpStrOrWord_252' => 252,
  'VariableSymbolOrSelf_253' => 253,
  'VariableSymbolOrSelf_254' => 254,
  'Literal_255' => 255,
  'Literal_256' => 256,
  'OpNamedScolonOrSubExp_257' => 257,
  'OpNamedScolonOrSubExp_258' => 258,
  'OpNamedScolonOrSubExp_259' => 259,
  'OpNamedScolonOrSubExpIn_260' => 260,
  'OpNamedScolonOrSubExpIn_261' => 261,
  'OpNamedScolonOrSubExpIn_262' => 262,
  'OpStringOrWord_263' => 263,
  'OpStringOrWord_264' => 264,
  'OpStringOrWord_265' => 265,
  'OpStringOrWord_266' => 266,
  'OpStringOrWord_267' => 267,
  'OpStringOrWord_268' => 268,
  'OpStringOrWord_269' => 269,
  'OpStringOrWord_270' => 270,
  'OpStringOrWord_271' => 271,
  'OpStringOrWord_272' => 272,
  'OpStringOrWord_273' => 273,
  'OpStringOrWord_274' => 274,
  'OpStringOrWord_275' => 275,
  'OpStringOrWord_276' => 276,
  'OpStringOrWord_277' => 277,
  'OpStringOrWord_278' => 278,
  'OpStringOrWord_279' => 279,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$RETURN_TYPE' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'@ARG;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'INIT' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'our hashref $properties' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent -norequire, qw(' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ARGV => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	ENV => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_IN => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	LPAREN_MY => { ISSEMANTIC => 1 },
	MY => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_SCOLON => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_LPAREN => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_SCOLON => { ISSEMANTIC => 1 },
	OP01_OPEN => { ISSEMANTIC => 1 },
	OP01_PRINT => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW_IMP => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW_NEW => { ISSEMANTIC => 1 },
	OP03_MATH_INC_DEC => { ISSEMANTIC => 1 },
	OP04_MATH_POW => { ISSEMANTIC => 1 },
	OP05_BITWISE_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP05_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP05_MATH_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP06_REGEX_BIND => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP07_STRING_REPEAT => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY_SCOLON => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NE => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL_SCOLON => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN_BY => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	OUR => { ISSEMANTIC => 1 },
	OUR_EXPORT => { ISSEMANTIC => 1 },
	OUR_EXPORT_OK => { ISSEMANTIC => 1 },
	POD => { ISSEMANTIC => 1 },
	SELF => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	SUB => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	USE => { ISSEMANTIC => 1 },
	USE_EXPORTER => { ISSEMANTIC => 1 },
	USE_RPERL => { ISSEMANTIC => 1 },
	USE_RPERL_AFTER => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER_ASSIGN => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	WORD_UPPERCASE => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 2,
			'SHEBANG' => 7
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'Critic' => 3,
			'Program' => 4,
			'ModuleHeader' => 9,
			'PAREN-1' => 6,
			'PLUS-2' => 1,
			'CompileUnit' => 5
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			'' => -5,
			'USE_RPERL' => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 3,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 9,
			'PAREN-1' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-17' => 11
		}
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			'' => 13
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 15,
			'OPTIONAL-3' => 14
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 17
		},
		GOTOS => {
			'OPTIONAL-10' => 16
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => -27,
			'USE' => -27,
			"use parent -norequire, qw(" => 24,
			'SUB' => -27,
			'USE_EXPORTER' => -27,
			"INIT" => -27,
			"use constant" => -27,
			"use parent qw(" => 18
		},
		GOTOS => {
			'Module' => 23,
			'Class' => 22,
			'STAR-11' => 21,
			'UseParent' => 20,
			'Package' => 19
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 12
		DEFAULT => -41
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			'USE_RPERL' => 27
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			"package" => 28
		}
	},
	{#State 17
		DEFAULT => -21
	},
	{#State 18
		DEFAULT => -77
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		ACTIONS => {
			"use constant" => -29,
			"INIT" => -29,
			"## no critic qw(" => 2,
			'USE' => -29,
			'USE_EXPORTER' => 32,
			'SUB' => -29
		},
		GOTOS => {
			'Critic' => 33,
			'OPTIONAL-12' => 35,
			'Exports' => 34
		}
	},
	{#State 22
		DEFAULT => -25
	},
	{#State 23
		DEFAULT => -1
	},
	{#State 24
		DEFAULT => -78
	},
	{#State 25
		DEFAULT => -40
	},
	{#State 26
		DEFAULT => -42
	},
	{#State 27
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 28
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 29
		DEFAULT => -239
	},
	{#State 30
		DEFAULT => -238
	},
	{#State 31
		ACTIONS => {
			")" => 39
		}
	},
	{#State 32
		ACTIONS => {
			'OUR_EXPORT' => 41,
			'OUR_EXPORT_OK' => -45,
			'SUB' => -45,
			'USE' => -45,
			"our hashref \$properties" => -45,
			"use constant" => -45,
			"INIT" => -45
		},
		GOTOS => {
			'OPTIONAL-19' => 40,
			'PAREN-18' => 42
		}
	},
	{#State 33
		DEFAULT => -26
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 43
		}
	},
	{#State 36
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 44
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 45
		}
	},
	{#State 38
		ACTIONS => {
			";" => 46
		}
	},
	{#State 39
		ACTIONS => {
			";" => 47
		}
	},
	{#State 40
		ACTIONS => {
			"use constant" => -48,
			'USE' => -48,
			"INIT" => -48,
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 48,
			'SUB' => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 49,
			'PAREN-20' => 50
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 51
		}
	},
	{#State 42
		DEFAULT => -44
	},
	{#State 43
		ACTIONS => {
			'SUB' => -33,
			"INIT" => 52,
			'USE' => 55,
			"use constant" => -33
		},
		GOTOS => {
			'STAR-14' => 54,
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'OP01_OPEN' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'MY' => -11,
			'POD' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_NUMBER' => -11,
			"INIT" => -11,
			'LBRACKET' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED' => -11,
			"while" => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'SELF' => -11,
			'WORD' => -11,
			'LPAREN' => -11,
			"foreach" => -11,
			"use constant" => -11,
			"\@{" => -11,
			"%{" => -11,
			'USE' => -11,
			"## no critic qw(" => 2,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"undef" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'SUB' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			"if" => -11,
			'LITERAL_STRING' => -11,
			'LBRACE' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP01_PRINT' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP22_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'Critic' => 56,
			'STAR-5' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 59
		},
		GOTOS => {
			'OPTIONAL-16' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 60
		}
	},
	{#State 47
		ACTIONS => {
			'USE' => 55,
			"INIT" => 52
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 62
		}
	},
	{#State 49
		DEFAULT => -49
	},
	{#State 50
		DEFAULT => -47
	},
	{#State 51
		ACTIONS => {
			";" => 63
		}
	},
	{#State 52
		ACTIONS => {
			'LBRACE' => 64
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			'SUB' => 65,
			"use constant" => 69
		},
		GOTOS => {
			'PLUS-15' => 66,
			'Subroutine' => 67,
			'Constant' => 68
		}
	},
	{#State 55
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 70
		}
	},
	{#State 56
		DEFAULT => -8
	},
	{#State 57
		ACTIONS => {
			'LPAREN' => -13,
			"use constant" => -13,
			"foreach" => -13,
			"%{" => -13,
			"\@{" => -13,
			'USE' => 55,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'SUB' => -13,
			"undef" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"for" => -13,
			'WORD_UPPERCASE' => -13,
			'LBRACE' => -13,
			"if" => -13,
			'LITERAL_STRING' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED_VOID' => -13,
			'MY' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'POD' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			"INIT" => 52,
			'LBRACKET' => -13,
			'LITERAL_NUMBER' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_SCOPED' => -13,
			"while" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'SELF' => -13,
			'WORD' => -13
		},
		GOTOS => {
			'Include' => 71,
			'STAR-6' => 72
		}
	},
	{#State 58
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 59
		DEFAULT => -37
	},
	{#State 60
		DEFAULT => -23
	},
	{#State 61
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 62
		ACTIONS => {
			";" => 75
		}
	},
	{#State 63
		DEFAULT => -43
	},
	{#State 64
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 76
		}
	},
	{#State 65
		ACTIONS => {
			'WORD' => 77
		}
	},
	{#State 66
		ACTIONS => {
			'LITERAL_NUMBER' => 79,
			'SUB' => 65
		},
		GOTOS => {
			'Subroutine' => 78
		}
	},
	{#State 67
		DEFAULT => -35
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			'WORD_UPPERCASE' => 80
		}
	},
	{#State 70
		ACTIONS => {
			'OP01_QW' => 81,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 82
		}
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			"foreach" => -15,
			"use constant" => 69,
			'LPAREN' => -15,
			"%{" => -15,
			"\@{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"undef" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'SUB' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			"for" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'LBRACE' => -15,
			"if" => -15,
			'LITERAL_STRING' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'MY' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'POD' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LBRACKET' => -15,
			'LITERAL_NUMBER' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'WORD' => -15,
			'SELF' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			"while" => -15
		},
		GOTOS => {
			'Constant' => 84,
			'STAR-7' => 83
		}
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		ACTIONS => {
			"use constant" => -69,
			'USE' => -69,
			"INIT" => -69,
			"## no critic qw(" => 2,
			'USE_EXPORTER' => 32,
			"our hashref \$properties" => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 87,
			'Exports' => 86,
			'Critic' => 88
		}
	},
	{#State 75
		DEFAULT => -46
	},
	{#State 76
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 89
		}
	},
	{#State 77
		ACTIONS => {
			'LBRACE' => 90
		}
	},
	{#State 78
		DEFAULT => -34
	},
	{#State 79
		ACTIONS => {
			";" => 91
		}
	},
	{#State 80
		ACTIONS => {
			'OP20_HASH_FATARROW' => 92
		}
	},
	{#State 81
		DEFAULT => -50
	},
	{#State 82
		ACTIONS => {
			";" => 93
		}
	},
	{#State 83
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 137,
			'WORD_UPPERCASE' => 132,
			"for" => -171,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			"if" => 143,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_PRINT' => 140,
			"foreach" => -171,
			'LPAREN' => 123,
			"%{" => 121,
			"\@{" => 120,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'SUB' => 65,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED' => 119,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'WORD' => 30,
			'SELF' => 116,
			'OP19_LOOP_CONTROL' => 118,
			'WORD_SCOPED' => 29,
			"while" => -171,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_CLOSE' => 96,
			'OP01_NAMED_VOID' => 94,
			'MY' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'POD' => 104
		},
		GOTOS => {
			'Variable' => 133,
			'VariableSymbolOrSelf' => 108,
			'LoopLabel' => 131,
			'VariableDeclaration' => 134,
			'VariableModification' => 110,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 115,
			'HashDereference' => 113,
			'SubExpression' => 139,
			'Subroutine' => 147,
			'HashReference' => 145,
			'Literal' => 146,
			'ArrayDereference' => 122,
			'Conditional' => 99,
			'OPTIONAL-46' => 97,
			'OperatorVoid' => 103,
			'Operation' => 105,
			'PAREN-45' => 126,
			'Statement' => 127,
			'WordScoped' => 130,
			'PLUS-8' => 129
		}
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -68
	},
	{#State 87
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 149
		}
	},
	{#State 88
		DEFAULT => -66
	},
	{#State 89
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 150
		},
		GOTOS => {
			'OPTIONAL-23' => 151
		}
	},
	{#State 90
		ACTIONS => {
			'LBRACE' => 152
		}
	},
	{#State 91
		DEFAULT => -36
	},
	{#State 92
		ACTIONS => {
			'MY' => 154
		},
		GOTOS => {
			'TypeInnerConstant' => 153
		}
	},
	{#State 93
		DEFAULT => -54
	},
	{#State 94
		ACTIONS => {
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120
		},
		GOTOS => {
			'SubExpression' => 158,
			'ListElements' => 160,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'ListElement' => 163,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'TypeInner' => 164,
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136
		}
	},
	{#State 95
		DEFAULT => -141
	},
	{#State 96
		ACTIONS => {
			'FHREF_SYMBOL' => 166
		}
	},
	{#State 97
		ACTIONS => {
			"while" => 173,
			"for" => 169,
			"foreach" => 167
		},
		GOTOS => {
			'Loop' => 171,
			'LoopFor' => 168,
			'LoopForEach' => 172,
			'LoopWhile' => 170
		}
	},
	{#State 98
		ACTIONS => {
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162
		},
		GOTOS => {
			'SubExpression' => 174,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136
		}
	},
	{#State 99
		DEFAULT => -172
	},
	{#State 100
		ACTIONS => {
			'MY' => 175
		}
	},
	{#State 101
		DEFAULT => -253
	},
	{#State 102
		DEFAULT => -151
	},
	{#State 103
		DEFAULT => -174
	},
	{#State 104
		DEFAULT => -177
	},
	{#State 105
		DEFAULT => -17
	},
	{#State 106
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180,
			'WORD' => 179,
			'TYPE_FHREF' => 176
		},
		GOTOS => {
			'Type' => 177
		}
	},
	{#State 107
		ACTIONS => {
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 161,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130,
			'SubExpression' => 181
		}
	},
	{#State 108
		DEFAULT => -197,
		GOTOS => {
			'STAR-52' => 182
		}
	},
	{#State 109
		ACTIONS => {
			'SELF' => 116,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 183,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 110
		ACTIONS => {
			";" => 184
		}
	},
	{#State 111
		ACTIONS => {
			'OP16_LOGICAL_OR' => -117,
			'WORD_UPPERCASE' => 156,
			'OP07_STRING_REPEAT' => -117,
			'OP04_MATH_POW' => -117,
			'LITERAL_STRING' => 144,
			'OP14_BITWISE_OR_XOR' => -117,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'OP11_COMPARE_LT_GT' => -117,
			'OP05_LOGICAL_NEG' => 141,
			"}" => -117,
			'OP06_REGEX_BIND' => -117,
			'LPAREN' => 123,
			'OP17_LIST_RANGE' => -117,
			'OP08_STRING_CAT' => -117,
			")" => -117,
			"\@{" => 120,
			"%{" => 121,
			";" => -117,
			'OP23_LOGICAL_AND' => -117,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP03_MATH_INC_DEC' => 109,
			'OP21_LIST_COMMA' => -117,
			'OP01_NAMED' => 162,
			"]" => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP15_LOGICAL_AND' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP01_OPEN' => 100,
			'OP01_CLOSE' => 96,
			'OP09_BITWISE_SHIFT' => -117,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP08_MATH_ADD_SUB' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP18_TERNARY' => -117
		},
		GOTOS => {
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130,
			'SubExpression' => 185
		}
	},
	{#State 112
		DEFAULT => -255
	},
	{#State 113
		DEFAULT => -162
	},
	{#State 114
		ACTIONS => {
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_QW' => 159,
			"]" => -217,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACKET' => 114,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120
		},
		GOTOS => {
			'Operator' => 135,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'OPTIONAL-55' => 187,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'Expression' => 161,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ListElement' => 163,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'ListElements' => 186,
			'SubExpression' => 158
		}
	},
	{#State 115
		ACTIONS => {
			'OP23_LOGICAL_AND' => -155,
			'OP18_TERNARY' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			";" => 188,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_STRING_CAT' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP04_MATH_POW' => -155
		}
	},
	{#State 116
		DEFAULT => -254
	},
	{#State 117
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			")" => -134,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'ListElement' => 163,
			'SubExpression' => 158,
			'ListElements' => 189,
			'OPTIONAL-41' => 190,
			'Expression' => 161,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 118
		ACTIONS => {
			'WORD_UPPERCASE' => 192
		},
		GOTOS => {
			'LoopLabel' => 191
		}
	},
	{#State 119
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'HashDereference' => 113,
			'Expression' => 161,
			'TypeInner' => 164,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'SubExpression' => 194,
			'ListElement' => 193,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130
		}
	},
	{#State 120
		ACTIONS => {
			'SELF' => 116,
			'VARIABLE_SYMBOL' => 101,
			'MY' => 165,
			'LBRACKET' => -220
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'OPTIONAL-56' => 196,
			'Variable' => 195,
			'TypeInner' => 197
		}
	},
	{#State 121
		ACTIONS => {
			'SELF' => 116,
			'VARIABLE_SYMBOL' => 101,
			'LBRACE' => -235,
			'MY' => 165
		},
		GOTOS => {
			'TypeInner' => 200,
			'OPTIONAL-60' => 199,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 198
		}
	},
	{#State 122
		DEFAULT => -160
	},
	{#State 123
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_PRINT' => 202,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 203,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 201,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146
		}
	},
	{#State 124
		ACTIONS => {
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116
		},
		GOTOS => {
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 204,
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 125
		DEFAULT => -156
	},
	{#State 126
		DEFAULT => -170
	},
	{#State 127
		DEFAULT => -98
	},
	{#State 128
		DEFAULT => -137
	},
	{#State 129
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'POD' => 104,
			'MY' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP01_NAMED_VOID' => 94,
			'OP01_CLOSE' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'SELF' => 116,
			'WORD' => 30,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'WORD_SCOPED' => 29,
			"while" => -171,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_NAMED' => 119,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'' => -18,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP01_NAMED_VOID_SCOLON' => 128,
			"\@{" => 120,
			"%{" => 121,
			"foreach" => -171,
			'LPAREN' => 123,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_PRINT' => 140,
			'OP05_LOGICAL_NEG' => 141,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			'LITERAL_STRING' => 144,
			"if" => 143,
			'LBRACE' => 148,
			'WORD_UPPERCASE' => 132,
			"for" => -171,
			'OP01_NAMED_SCOLON' => 137
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Conditional' => 99,
			'OPTIONAL-46' => 97,
			'OperatorVoid' => 103,
			'Operation' => 205,
			'Statement' => 127,
			'PAREN-45' => 126,
			'WordScoped' => 130,
			'Variable' => 133,
			'VariableSymbolOrSelf' => 108,
			'LoopLabel' => 131,
			'VariableDeclaration' => 134,
			'VariableModification' => 110,
			'Operator' => 135,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 115,
			'SubExpression' => 139,
			'Literal' => 146,
			'HashReference' => 145
		}
	},
	{#State 130
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 206,
			'LPAREN' => 207
		}
	},
	{#State 131
		ACTIONS => {
			'COLON' => 208
		}
	},
	{#State 132
		ACTIONS => {
			'LPAREN' => 209,
			'COLON' => -240
		}
	},
	{#State 133
		ACTIONS => {
			'OP13_BITWISE_AND' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP15_LOGICAL_AND' => -158,
			")" => -158,
			'OP08_STRING_CAT' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 210,
			'OP02_METHOD_THINARROW' => 213,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP18_TERNARY' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP04_MATH_POW' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP03_MATH_INC_DEC' => 212,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP19_VARIABLE_ASSIGN' => 211,
			'OP11_COMPARE_LT_GT' => -158,
			'OP24_LOGICAL_OR_XOR' => -158
		}
	},
	{#State 134
		DEFAULT => -175
	},
	{#State 135
		DEFAULT => -149
	},
	{#State 136
		DEFAULT => -159
	},
	{#State 137
		DEFAULT => -96
	},
	{#State 138
		ACTIONS => {
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 214,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130
		}
	},
	{#State 139
		ACTIONS => {
			'OP08_STRING_CAT' => 228,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP15_LOGICAL_AND' => 218,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216
		}
	},
	{#State 140
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 235,
			"\@{" => -132,
			'OP01_CLOSE' => -132,
			"%{" => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP01_OPEN' => -132,
			'LPAREN' => -132,
			'VARIABLE_SYMBOL' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			"undef" => -132,
			'MY' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'WORD_UPPERCASE' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP10_NAMED_UNARY' => -132,
			'ARGV' => -132,
			'LITERAL_NUMBER' => -132,
			'LBRACKET' => -132,
			'SELF' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'WORD' => -132,
			'WORD_SCOPED' => -132,
			'STDOUT_STDERR' => 232,
			'OP05_LOGICAL_NEG' => -132,
			'OP01_NAMED' => -132,
			'OP01_QW' => -132,
			'LITERAL_STRING' => -132,
			'LBRACE' => -132
		},
		GOTOS => {
			'PAREN-39' => 233,
			'OPTIONAL-40' => 234
		}
	},
	{#State 141
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'SubExpression' => 236,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Expression' => 161,
			'HashDereference' => 113
		}
	},
	{#State 142
		DEFAULT => -97
	},
	{#State 143
		ACTIONS => {
			'LPAREN' => 237
		}
	},
	{#State 144
		DEFAULT => -256
	},
	{#State 145
		DEFAULT => -161
	},
	{#State 146
		DEFAULT => -157
	},
	{#State 147
		DEFAULT => -14
	},
	{#State 148
		ACTIONS => {
			'OP10_NAMED_UNARY' => 255,
			'LITERAL_NUMBER' => 112,
			'OP07_STRING_REPEAT' => 242,
			'OP01_NAMED' => 252,
			'OP12_COMPARE_EQ_NE' => 251,
			'LITERAL_STRING' => 144,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP22_LOGICAL_NEG' => 240,
			'WORD' => 249,
			'SELF' => 116,
			'OP01_PRINT' => 239,
			'OP11_COMPARE_LT_GT' => 238,
			'OP19_LOOP_CONTROL' => 247,
			"}" => 246,
			'ENV' => 245,
			'OP01_OPEN' => 262,
			'OP01_NAMED_VOID' => 259,
			'OP01_CLOSE' => 261,
			"%{" => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP08_MATH_ADD_SUB' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 257,
			'OP23_LOGICAL_AND' => 244,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'OpStringOrWord' => 253,
			'Variable' => 243,
			'VariableSymbolOrSelf' => 108,
			'VarOrLitOrOpStrOrWord' => 256,
			'HashDereference' => 254,
			'HashEntry' => 250,
			'Literal' => 241
		}
	},
	{#State 149
		ACTIONS => {
			'USE' => 55,
			"INIT" => 52,
			"use constant" => -73,
			"our hashref \$properties" => -73
		},
		GOTOS => {
			'Include' => 264,
			'STAR-31' => 263
		}
	},
	{#State 150
		DEFAULT => -52
	},
	{#State 151
		ACTIONS => {
			")" => 265
		}
	},
	{#State 152
		ACTIONS => {
			'MY' => 266
		}
	},
	{#State 153
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 144
		},
		GOTOS => {
			'Literal' => 267
		}
	},
	{#State 154
		ACTIONS => {
			'WORD' => 179,
			'WORD_SCOPED' => 180,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 155
		ACTIONS => {
			'OP04_MATH_POW' => -158,
			'OP21_LIST_COMMA' => -158,
			'OP03_MATH_INC_DEC' => 212,
			'OP07_STRING_REPEAT' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			"]" => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP15_LOGICAL_AND' => -158,
			"}" => -158,
			")" => -158,
			'OP08_STRING_CAT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP02_METHOD_THINARROW' => 213,
			";" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP18_TERNARY' => -158,
			'OP23_LOGICAL_AND' => -158
		}
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 209
		}
	},
	{#State 157
		DEFAULT => -215
	},
	{#State 158
		ACTIONS => {
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -212,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => -212,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_STRING_CAT' => 228,
			")" => -212,
			'OP15_LOGICAL_AND' => 218,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -212,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220
		}
	},
	{#State 159
		DEFAULT => -214
	},
	{#State 160
		ACTIONS => {
			";" => 269
		}
	},
	{#State 161
		DEFAULT => -155
	},
	{#State 162
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141
		},
		GOTOS => {
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145,
			'SubExpression' => 270,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 163
		DEFAULT => -210,
		GOTOS => {
			'STAR-54' => 271
		}
	},
	{#State 164
		ACTIONS => {
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'SubExpression' => 272,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145
		}
	},
	{#State 165
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180,
			'WORD' => 179
		},
		GOTOS => {
			'Type' => 273
		}
	},
	{#State 166
		DEFAULT => -103
	},
	{#State 167
		ACTIONS => {
			'MY' => 274
		}
	},
	{#State 168
		DEFAULT => -185
	},
	{#State 169
		ACTIONS => {
			'MY' => 276,
			'LPAREN_MY' => 275
		}
	},
	{#State 170
		DEFAULT => -187
	},
	{#State 171
		DEFAULT => -173
	},
	{#State 172
		DEFAULT => -186
	},
	{#State 173
		ACTIONS => {
			'LPAREN_MY' => 277,
			'LPAREN' => 278
		}
	},
	{#State 174
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			")" => 279,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222
		}
	},
	{#State 175
		ACTIONS => {
			'TYPE_FHREF' => 280
		}
	},
	{#State 176
		ACTIONS => {
			'FHREF_SYMBOL' => 281
		}
	},
	{#State 177
		ACTIONS => {
			'VARIABLE_SYMBOL' => 282
		}
	},
	{#State 178
		DEFAULT => -243
	},
	{#State 179
		DEFAULT => -241
	},
	{#State 180
		DEFAULT => -242
	},
	{#State 181
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			")" => 283,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218
		}
	},
	{#State 182
		ACTIONS => {
			'OP02_HASH_THINARROW' => 285,
			'OP21_LIST_COMMA' => -198,
			'OP04_MATH_POW' => -198,
			'OP07_STRING_REPEAT' => -198,
			'OP16_LOGICAL_OR' => -198,
			'OP03_MATH_INC_DEC' => -198,
			'COLON' => -198,
			'OP14_BITWISE_OR_XOR' => -198,
			'OP12_COMPARE_EQ_NE' => -198,
			"]" => -198,
			'OP19_VARIABLE_ASSIGN' => -198,
			'OP11_COMPARE_LT_GT' => -198,
			'OP24_LOGICAL_OR_XOR' => -198,
			'OP13_BITWISE_AND' => -198,
			'OP06_REGEX_BIND' => -198,
			'OP20_HASH_FATARROW' => -198,
			'OP17_LIST_RANGE' => -198,
			"}" => -198,
			'OP15_LOGICAL_AND' => -198,
			")" => -198,
			'OP02_ARRAY_THINARROW' => 286,
			'OP08_STRING_CAT' => -198,
			'OP19_VARIABLE_ASSIGN_BY' => -198,
			'OP02_METHOD_THINARROW' => -198,
			'OP07_MATH_MULT_DIV_MOD' => -198,
			'OP09_BITWISE_SHIFT' => -198,
			";" => -198,
			'OP08_MATH_ADD_SUB' => -198,
			'OP18_TERNARY' => -198,
			'OP23_LOGICAL_AND' => -198
		},
		GOTOS => {
			'VariableRetrieval' => 284
		}
	},
	{#State 183
		DEFAULT => -104
	},
	{#State 184
		DEFAULT => -176
	},
	{#State 185
		ACTIONS => {
			")" => -116,
			'OP08_STRING_CAT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -116,
			'OP17_LIST_RANGE' => -116,
			"}" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -116,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP21_LIST_COMMA' => -116,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			"]" => -116,
			'OP12_COMPARE_EQ_NE' => -116
		}
	},
	{#State 186
		DEFAULT => -216
	},
	{#State 187
		ACTIONS => {
			"]" => 287
		}
	},
	{#State 188
		DEFAULT => -95
	},
	{#State 189
		DEFAULT => -133
	},
	{#State 190
		ACTIONS => {
			")" => 288
		}
	},
	{#State 191
		ACTIONS => {
			";" => 289
		}
	},
	{#State 192
		DEFAULT => -240
	},
	{#State 193
		ACTIONS => {
			'OP21_LIST_COMMA' => 290
		}
	},
	{#State 194
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP04_MATH_POW' => -100,
			'OP21_LIST_COMMA' => -212,
			'OP08_MATH_ADD_SUB' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 291
		}
	},
	{#State 196
		ACTIONS => {
			'LBRACKET' => 114
		},
		GOTOS => {
			'ArrayReference' => 292
		}
	},
	{#State 197
		DEFAULT => -219
	},
	{#State 198
		ACTIONS => {
			"}" => 293
		}
	},
	{#State 199
		ACTIONS => {
			'LBRACE' => 148
		},
		GOTOS => {
			'HashReference' => 294
		}
	},
	{#State 200
		DEFAULT => -234
	},
	{#State 201
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			")" => 295,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP15_LOGICAL_AND' => 218
		}
	},
	{#State 202
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 296
		}
	},
	{#State 203
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'OP01_QW' => 159,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'TypeInner' => 164,
			'HashDereference' => 113,
			'Expression' => 161,
			'SubExpression' => 194,
			'ListElement' => 297,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145
		}
	},
	{#State 204
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			")" => 298,
			'OP08_STRING_CAT' => 228,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP17_LIST_RANGE' => 229,
			'OP15_LOGICAL_AND' => 218,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222
		}
	},
	{#State 205
		DEFAULT => -16
	},
	{#State 206
		ACTIONS => {
			")" => -148,
			'LBRACE' => 148
		},
		GOTOS => {
			'HashReference' => 300,
			'OPTIONAL-44' => 299
		}
	},
	{#State 207
		ACTIONS => {
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'MY' => 165,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			")" => -144,
			"\@{" => 120
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 161,
			'TypeInner' => 164,
			'HashDereference' => 113,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'OPTIONAL-42' => 302,
			'ListElement' => 163,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'ListElements' => 301,
			'SubExpression' => 158
		}
	},
	{#State 208
		DEFAULT => -169
	},
	{#State 209
		ACTIONS => {
			")" => 303
		}
	},
	{#State 210
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'SubExpression' => 304,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122
		}
	},
	{#State 211
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'FHREF_SYMBOL_IN' => 305,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'STDIN' => 307,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'SubExpressionOrInput' => 306,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 308,
			'Operator' => 135,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Expression' => 161,
			'HashDereference' => 113,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 212
		DEFAULT => -105
	},
	{#State 213
		ACTIONS => {
			'LPAREN' => 309
		}
	},
	{#State 214
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP14_BITWISE_OR_XOR' => 227,
			"]" => -127,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -127,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -127,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			")" => -127,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			"}" => -127
		}
	},
	{#State 215
		ACTIONS => {
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'WORD' => 30,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124
		},
		GOTOS => {
			'SubExpression' => 310,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 161
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102
		},
		GOTOS => {
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 311
		}
	},
	{#State 217
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109
		},
		GOTOS => {
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145,
			'SubExpression' => 312,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 218
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'SubExpression' => 313,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130
		}
	},
	{#State 219
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Literal' => 316,
			'VariableSymbolOrSelf' => 108,
			'VariableOrLiteral' => 314,
			'Variable' => 315
		}
	},
	{#State 220
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'SubExpression' => 317,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146
		}
	},
	{#State 221
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'SubExpression' => 318,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146
		}
	},
	{#State 222
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'SubExpression' => 319,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 223
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 320,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146
		}
	},
	{#State 224
		ACTIONS => {
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124
		},
		GOTOS => {
			'SubExpression' => 321,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Operator' => 135,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Expression' => 161,
			'HashDereference' => 113
		}
	},
	{#State 225
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 161,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'SubExpression' => 322
		}
	},
	{#State 226
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 161,
			'SubExpression' => 323,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130
		}
	},
	{#State 227
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'SubExpression' => 324,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145
		}
	},
	{#State 228
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'SubExpression' => 325,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145
		}
	},
	{#State 229
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'SubExpression' => 326,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146
		}
	},
	{#State 230
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 327
		}
	},
	{#State 231
		ACTIONS => {
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'SubExpression' => 328,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145
		}
	},
	{#State 232
		DEFAULT => -130
	},
	{#State 233
		DEFAULT => -131
	},
	{#State 234
		ACTIONS => {
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'ListElement' => 163,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 158,
			'ListElements' => 329,
			'Expression' => 161,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 235
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'MY' => 165,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'HashDereference' => 113,
			'Expression' => 161,
			'TypeInner' => 164,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130,
			'ListElement' => 163,
			'ListElements' => 330,
			'SubExpression' => 158
		}
	},
	{#State 236
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			"]" => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP04_MATH_POW' => 223,
			'OP23_LOGICAL_AND' => -108,
			'OP18_TERNARY' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			";" => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP08_STRING_CAT' => -108,
			")" => -108,
			"}" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP17_LIST_RANGE' => -108
		}
	},
	{#State 237
		ACTIONS => {
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162
		},
		GOTOS => {
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 331,
			'HashDereference' => 113,
			'Expression' => 161,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155
		}
	},
	{#State 238
		DEFAULT => -269
	},
	{#State 239
		DEFAULT => -278
	},
	{#State 240
		DEFAULT => -265
	},
	{#State 241
		DEFAULT => -251
	},
	{#State 242
		DEFAULT => -273
	},
	{#State 243
		DEFAULT => -250
	},
	{#State 244
		DEFAULT => -264
	},
	{#State 245
		DEFAULT => -227
	},
	{#State 246
		DEFAULT => -233
	},
	{#State 247
		DEFAULT => -267
	},
	{#State 248
		DEFAULT => -263
	},
	{#State 249
		DEFAULT => -279
	},
	{#State 250
		DEFAULT => -231,
		GOTOS => {
			'STAR-59' => 332
		}
	},
	{#State 251
		DEFAULT => -268
	},
	{#State 252
		DEFAULT => -274
	},
	{#State 253
		DEFAULT => -252
	},
	{#State 254
		DEFAULT => -226
	},
	{#State 255
		DEFAULT => -270
	},
	{#State 256
		ACTIONS => {
			'OP20_HASH_FATARROW' => 333
		}
	},
	{#State 257
		DEFAULT => -272
	},
	{#State 258
		DEFAULT => -271
	},
	{#State 259
		DEFAULT => -277
	},
	{#State 260
		DEFAULT => -266
	},
	{#State 261
		DEFAULT => -275
	},
	{#State 262
		DEFAULT => -276
	},
	{#State 263
		ACTIONS => {
			"use constant" => 69,
			"our hashref \$properties" => 334
		},
		GOTOS => {
			'Constant' => 336,
			'Properties' => 335
		}
	},
	{#State 264
		DEFAULT => -70
	},
	{#State 265
		ACTIONS => {
			";" => 337
		}
	},
	{#State 266
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180,
			'WORD' => 179
		},
		GOTOS => {
			'Type' => 338
		}
	},
	{#State 267
		ACTIONS => {
			";" => 339
		}
	},
	{#State 268
		ACTIONS => {
			"\$TYPED_" => 340
		}
	},
	{#State 269
		DEFAULT => -139
	},
	{#State 270
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP15_LOGICAL_AND' => -100,
			"}" => -100,
			")" => -100,
			'OP08_STRING_CAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			";" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"]" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 342,
			")" => -211,
			";" => -211,
			"]" => -211
		},
		GOTOS => {
			'PAREN-53' => 341
		}
	},
	{#State 272
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => -213,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP21_LIST_COMMA' => -213,
			'OP04_MATH_POW' => 223,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP09_BITWISE_SHIFT' => 221,
			";" => -213,
			'OP08_MATH_ADD_SUB' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => 228,
			")" => -213,
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 273
		ACTIONS => {
			"\$TYPED_" => 343
		}
	},
	{#State 274
		ACTIONS => {
			'WORD' => 179,
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180
		},
		GOTOS => {
			'Type' => 344
		}
	},
	{#State 275
		ACTIONS => {
			'TYPE_INTEGER' => 345
		}
	},
	{#State 276
		ACTIONS => {
			'TYPE_INTEGER' => 346
		}
	},
	{#State 277
		ACTIONS => {
			'WORD_SCOPED' => 180,
			'TYPE_INTEGER' => 178,
			'WORD' => 179
		},
		GOTOS => {
			'Type' => 347
		}
	},
	{#State 278
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 161,
			'HashDereference' => 113,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 348
		}
	},
	{#State 279
		DEFAULT => -107
	},
	{#State 280
		ACTIONS => {
			'FHREF_SYMBOL' => 349
		}
	},
	{#State 281
		ACTIONS => {
			";" => 350
		}
	},
	{#State 282
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 353,
			";" => 351,
			'OP02_ARRAY_THINARROW' => 352
		}
	},
	{#State 283
		DEFAULT => -126
	},
	{#State 284
		DEFAULT => -196
	},
	{#State 285
		ACTIONS => {
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 355,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'SubExpression' => 354
		}
	},
	{#State 286
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 356,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146
		}
	},
	{#State 287
		DEFAULT => -218
	},
	{#State 288
		ACTIONS => {
			";" => 357
		}
	},
	{#State 289
		DEFAULT => -142
	},
	{#State 290
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'MY' => 165,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'OP01_QW' => 159,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 161,
			'TypeInner' => 164,
			'HashDereference' => 113,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ListElement' => 163,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145,
			'ListElements' => 358,
			'SubExpression' => 158
		}
	},
	{#State 291
		DEFAULT => -221
	},
	{#State 292
		ACTIONS => {
			"}" => 359
		}
	},
	{#State 293
		DEFAULT => -236
	},
	{#State 294
		ACTIONS => {
			"}" => 360
		}
	},
	{#State 295
		DEFAULT => -163
	},
	{#State 296
		ACTIONS => {
			'LBRACKET' => 114,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Expression' => 161,
			'TypeInner' => 164,
			'HashDereference' => 113,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'ListElement' => 163,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'ListElements' => 361,
			'SubExpression' => 158
		}
	},
	{#State 297
		ACTIONS => {
			'OP21_LIST_COMMA' => 362
		}
	},
	{#State 298
		DEFAULT => -109
	},
	{#State 299
		ACTIONS => {
			")" => 363
		}
	},
	{#State 300
		DEFAULT => -147
	},
	{#State 301
		DEFAULT => -143
	},
	{#State 302
		ACTIONS => {
			")" => 364
		}
	},
	{#State 303
		DEFAULT => -150
	},
	{#State 304
		ACTIONS => {
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP09_BITWISE_SHIFT' => 221,
			";" => -207,
			'OP08_MATH_ADD_SUB' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => 228,
			")" => -207,
			'OP15_LOGICAL_AND' => 218,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 305
		DEFAULT => -165
	},
	{#State 306
		DEFAULT => -206
	},
	{#State 307
		DEFAULT => -166
	},
	{#State 308
		ACTIONS => {
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP04_MATH_POW' => 223,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_STRING_CAT' => 228,
			")" => -164,
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -164,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220
		}
	},
	{#State 309
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			")" => -146,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'ARGV' => 157,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'Expression' => 161,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'SubExpression' => 158,
			'ListElements' => 366,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145,
			'ListElement' => 163,
			'OPTIONAL-43' => 365
		}
	},
	{#State 310
		ACTIONS => {
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP11_COMPARE_LT_GT' => 226,
			"]" => -129,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_STRING_CAT' => 228,
			")" => -129,
			"}" => -129,
			'OP15_LOGICAL_AND' => 218,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -129,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220
		}
	},
	{#State 311
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -119,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP18_TERNARY' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -119,
			'OP17_LIST_RANGE' => -119,
			"}" => -119,
			'OP15_LOGICAL_AND' => -119,
			")" => -119,
			'OP08_STRING_CAT' => 228,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			"]" => -119,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => -119,
			'OP07_STRING_REPEAT' => 224
		}
	},
	{#State 312
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP07_STRING_REPEAT' => 224,
			'OP21_LIST_COMMA' => -120,
			'OP04_MATH_POW' => 223,
			'OP23_LOGICAL_AND' => -120,
			'OP18_TERNARY' => -120,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -120,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => 228,
			")" => -120,
			'OP15_LOGICAL_AND' => -120,
			"}" => -120,
			'OP17_LIST_RANGE' => -120,
			'OP13_BITWISE_AND' => -120,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 313
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -122,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => -122,
			"}" => -122,
			'OP15_LOGICAL_AND' => -122,
			")" => -122,
			'OP08_STRING_CAT' => 228,
			'OP14_BITWISE_OR_XOR' => 227,
			"]" => -122,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP21_LIST_COMMA' => -122,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => -122
		}
	},
	{#State 314
		ACTIONS => {
			'COLON' => 367
		}
	},
	{#State 315
		DEFAULT => -248
	},
	{#State 316
		DEFAULT => -249
	},
	{#State 317
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -112,
			";" => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP15_LOGICAL_AND' => -112,
			"}" => -112,
			'OP17_LIST_RANGE' => -112,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -112,
			'OP08_STRING_CAT' => -112,
			")" => -112,
			"]" => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP07_STRING_REPEAT' => 224,
			'OP21_LIST_COMMA' => -112,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 318
		ACTIONS => {
			'OP21_LIST_COMMA' => -115,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => -115,
			'OP07_STRING_REPEAT' => 224,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			"]" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -115,
			'OP17_LIST_RANGE' => -115,
			"}" => -115,
			'OP15_LOGICAL_AND' => -115,
			")" => -115,
			'OP08_STRING_CAT' => 228,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => -115,
			'OP23_LOGICAL_AND' => -115
		}
	},
	{#State 319
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -113,
			"]" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => -113,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			";" => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP15_LOGICAL_AND' => -113,
			"}" => -113,
			'OP17_LIST_RANGE' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => -113,
			")" => -113
		}
	},
	{#State 320
		ACTIONS => {
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			";" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP08_STRING_CAT' => -106,
			")" => -106,
			"}" => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 321
		ACTIONS => {
			'OP23_LOGICAL_AND' => -111,
			'OP18_TERNARY' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			";" => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP08_STRING_CAT' => -111,
			")" => -111,
			'OP15_LOGICAL_AND' => -111,
			"}" => -111,
			'OP17_LIST_RANGE' => -111,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -111
		}
	},
	{#State 322
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -123,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP17_LIST_RANGE' => -123,
			"}" => -123,
			'OP15_LOGICAL_AND' => 218,
			")" => -123,
			'OP08_STRING_CAT' => 228,
			'OP14_BITWISE_OR_XOR' => 227,
			"]" => -123,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP07_STRING_REPEAT' => 224
		}
	},
	{#State 323
		ACTIONS => {
			'OP23_LOGICAL_AND' => -118,
			'OP18_TERNARY' => -118,
			'OP09_BITWISE_SHIFT' => 221,
			";" => -118,
			'OP08_MATH_ADD_SUB' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => 228,
			")" => -118,
			'OP15_LOGICAL_AND' => -118,
			"}" => -118,
			'OP17_LIST_RANGE' => -118,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -118,
			"]" => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 324
		ACTIONS => {
			'OP18_TERNARY' => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -121,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			")" => -121,
			'OP08_STRING_CAT' => 228,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => -121,
			"}" => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			"]" => -121,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP07_STRING_REPEAT' => 224
		}
	},
	{#State 325
		ACTIONS => {
			'OP23_LOGICAL_AND' => -114,
			'OP18_TERNARY' => -114,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => -114,
			")" => -114,
			"}" => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			"]" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 326
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => -124,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP11_COMPARE_LT_GT' => 226,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP21_LIST_COMMA' => -124,
			'OP04_MATH_POW' => 223,
			'OP08_MATH_ADD_SUB' => 222,
			";" => -124,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => -124,
			'OP18_TERNARY' => -124,
			"}" => -124,
			'OP15_LOGICAL_AND' => 218,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP17_LIST_RANGE' => undef,
			'OP08_STRING_CAT' => 228,
			")" => -124
		}
	},
	{#State 327
		DEFAULT => -110
	},
	{#State 328
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP21_LIST_COMMA' => -128,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => -128,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			"}" => -128,
			")" => -128,
			'OP08_STRING_CAT' => 228,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -128,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => -128
		}
	},
	{#State 329
		ACTIONS => {
			";" => 368
		}
	},
	{#State 330
		ACTIONS => {
			";" => 369
		}
	},
	{#State 331
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			")" => 370,
			'OP08_STRING_CAT' => 228,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP15_LOGICAL_AND' => 218
		}
	},
	{#State 332
		ACTIONS => {
			"}" => 373,
			'OP21_LIST_COMMA' => 372
		},
		GOTOS => {
			'PAREN-58' => 371
		}
	},
	{#State 333
		ACTIONS => {
			'WORD' => -224,
			'SELF' => -224,
			'OP22_LOGICAL_NEG' => -224,
			'OP05_LOGICAL_NEG' => -224,
			'WORD_SCOPED' => -224,
			'OP01_NAMED' => -224,
			'LBRACE' => -224,
			'LITERAL_STRING' => -224,
			'OP03_MATH_INC_DEC' => -224,
			'WORD_UPPERCASE' => -224,
			'OP10_NAMED_UNARY' => -224,
			'LBRACKET' => -224,
			'LITERAL_NUMBER' => -224,
			'CONSTANT_CALL_SCOPED' => -224,
			'VARIABLE_SYMBOL' => -224,
			'OP05_MATH_NEG_LPAREN' => -224,
			"undef" => -224,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => -224,
			'OP01_CLOSE' => -224,
			"%{" => -224,
			"\@{" => -224,
			'OP05_BITWISE_NEG_LPAREN' => -224,
			'LPAREN' => -224,
			'OP01_OPEN' => -224
		},
		GOTOS => {
			'TypeInner' => 374,
			'OPTIONAL-57' => 375
		}
	},
	{#State 334
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 376
		}
	},
	{#State 335
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 377
		}
	},
	{#State 336
		DEFAULT => -72
	},
	{#State 337
		ACTIONS => {
			"}" => 378
		}
	},
	{#State 338
		ACTIONS => {
			"\$RETURN_TYPE" => 379
		}
	},
	{#State 339
		DEFAULT => -56
	},
	{#State 340
		ACTIONS => {
			'WORD_UPPERCASE' => 380
		}
	},
	{#State 341
		DEFAULT => -209
	},
	{#State 342
		ACTIONS => {
			'OP01_NAMED' => 162,
			'OP01_QW' => 159,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121
		},
		GOTOS => {
			'Expression' => 161,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'ListElement' => 381,
			'SubExpression' => 158
		}
	},
	{#State 343
		ACTIONS => {
			'OP07_STRING_REPEAT' => 242,
			'OP10_NAMED_UNARY' => 255,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP22_LOGICAL_NEG' => 240,
			'WORD' => 249,
			'OP01_PRINT' => 239,
			'OP11_COMPARE_LT_GT' => 238,
			'OP19_LOOP_CONTROL' => 247,
			'OP01_NAMED' => 252,
			'OP12_COMPARE_EQ_NE' => 251,
			'OP01_NAMED_VOID' => 259,
			'OP01_CLOSE' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP01_OPEN' => 262,
			'OP23_LOGICAL_AND' => 244,
			'OP08_MATH_ADD_SUB' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 257
		},
		GOTOS => {
			'OpStringOrWord' => 382
		}
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 383
		}
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 346
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 347
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 348
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP04_MATH_POW' => 223,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_STRING_CAT' => 228,
			")" => 387,
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230
		}
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 388
		}
	},
	{#State 350
		DEFAULT => -205
	},
	{#State 351
		DEFAULT => -202
	},
	{#State 352
		ACTIONS => {
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'WORD' => 30,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144
		},
		GOTOS => {
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'SubExpression' => 389,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'HashDereference' => 113,
			'Expression' => 161,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'FHREF_SYMBOL_IN' => 305,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'STDIN' => 307,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'OP10_NAMED_UNARY_SCOLON' => 393,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED_SCOLON' => 392,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114
		},
		GOTOS => {
			'HashDereference' => 113,
			'Expression' => 161,
			'OpNamedScolonOrSubExpIn' => 390,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'WordScoped' => 130,
			'HashReference' => 145,
			'Literal' => 146,
			'SubExpressionOrInput' => 391,
			'SubExpression' => 308
		}
	},
	{#State 354
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP15_LOGICAL_AND' => 218,
			"}" => 394,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 228,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 355
		ACTIONS => {
			'LPAREN' => -238,
			'OP02_METHOD_THINARROW_NEW' => -238,
			"}" => 395
		}
	},
	{#State 356
		ACTIONS => {
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP15_LOGICAL_AND' => 218,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			"]" => 396,
			'OP12_COMPARE_EQ_NE' => 216
		}
	},
	{#State 357
		DEFAULT => -138
	},
	{#State 358
		ACTIONS => {
			";" => 397
		}
	},
	{#State 359
		DEFAULT => -222
	},
	{#State 360
		DEFAULT => -237
	},
	{#State 361
		ACTIONS => {
			")" => 398
		}
	},
	{#State 362
		ACTIONS => {
			'OP01_QW' => 159,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120
		},
		GOTOS => {
			'ListElement' => 163,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145,
			'SubExpression' => 158,
			'ListElements' => 399,
			'Expression' => 161,
			'HashDereference' => 113,
			'TypeInner' => 164,
			'Operator' => 135,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 363
		DEFAULT => -154
	},
	{#State 364
		DEFAULT => -152
	},
	{#State 365
		ACTIONS => {
			")" => 400
		}
	},
	{#State 366
		DEFAULT => -145
	},
	{#State 367
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 144,
			'SELF' => 116,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Literal' => 316,
			'VariableSymbolOrSelf' => 108,
			'VariableOrLiteral' => 401,
			'Variable' => 315
		}
	},
	{#State 368
		DEFAULT => -135
	},
	{#State 369
		DEFAULT => -136
	},
	{#State 370
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 402
		}
	},
	{#State 371
		DEFAULT => -230
	},
	{#State 372
		ACTIONS => {
			'OP01_CLOSE' => 261,
			"%{" => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP01_NAMED_VOID' => 259,
			'OP01_OPEN' => 262,
			'ENV' => 245,
			'OP23_LOGICAL_AND' => 244,
			'VARIABLE_SYMBOL' => 101,
			'OP08_MATH_ADD_SUB' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 257,
			'OP07_STRING_REPEAT' => 242,
			'OP10_NAMED_UNARY' => 255,
			'LITERAL_NUMBER' => 112,
			'OP22_LOGICAL_NEG' => 240,
			'SELF' => 116,
			'WORD' => 249,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP19_LOOP_CONTROL' => 247,
			'OP11_COMPARE_LT_GT' => 238,
			'OP01_PRINT' => 239,
			'OP12_COMPARE_EQ_NE' => 251,
			'OP01_NAMED' => 252,
			'LITERAL_STRING' => 144
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'VarOrLitOrOpStrOrWord' => 256,
			'OpStringOrWord' => 253,
			'Variable' => 243,
			'Literal' => 241,
			'HashEntry' => 404,
			'HashDereference' => 254
		}
	},
	{#State 373
		DEFAULT => -232
	},
	{#State 374
		DEFAULT => -223
	},
	{#State 375
		ACTIONS => {
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162
		},
		GOTOS => {
			'HashDereference' => 113,
			'Expression' => 161,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145,
			'SubExpression' => 405
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 406
		}
	},
	{#State 377
		ACTIONS => {
			'SUB' => 410,
			'LITERAL_NUMBER' => 408
		},
		GOTOS => {
			'SubroutineOrMethod' => 409,
			'Method' => 407,
			'Subroutine' => 411
		}
	},
	{#State 378
		DEFAULT => -55
	},
	{#State 379
		ACTIONS => {
			"}" => 412
		}
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 381
		DEFAULT => -208
	},
	{#State 382
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 414
		}
	},
	{#State 383
		ACTIONS => {
			'LPAREN' => 415
		}
	},
	{#State 384
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 385
		ACTIONS => {
			'LPAREN' => 417
		}
	},
	{#State 386
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 418
		}
	},
	{#State 387
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 419
		}
	},
	{#State 388
		ACTIONS => {
			'LITERAL_STRING' => 420
		}
	},
	{#State 389
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 216,
			"]" => 421,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 228
		}
	},
	{#State 390
		DEFAULT => -203
	},
	{#State 391
		ACTIONS => {
			";" => 422
		}
	},
	{#State 392
		DEFAULT => -260
	},
	{#State 393
		DEFAULT => -261
	},
	{#State 394
		DEFAULT => -200
	},
	{#State 395
		DEFAULT => -201
	},
	{#State 396
		DEFAULT => -199
	},
	{#State 397
		DEFAULT => -140
	},
	{#State 398
		DEFAULT => -99
	},
	{#State 399
		ACTIONS => {
			")" => 423
		}
	},
	{#State 400
		DEFAULT => -153
	},
	{#State 401
		DEFAULT => -125
	},
	{#State 402
		DEFAULT => -180,
		GOTOS => {
			'STAR-48' => 424
		}
	},
	{#State 403
		ACTIONS => {
			"%{" => 121,
			"\@{" => 120,
			'LPAREN' => 123,
			"foreach" => -171,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP01_NAMED_VOID_SCOLON' => 128,
			"for" => -171,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED_SCOLON' => 137,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_PRINT' => 140,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			"if" => 143,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			'OP01_CLOSE' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_NAMED_VOID' => 94,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'POD' => 104,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'MY' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 109,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP19_LOOP_CONTROL' => 118,
			"while" => -171,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'SELF' => 116,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'OP01_NAMED' => 119
		},
		GOTOS => {
			'OperatorVoid' => 103,
			'Operation' => 425,
			'Statement' => 127,
			'PAREN-45' => 126,
			'WordScoped' => 130,
			'OPTIONAL-46' => 97,
			'Conditional' => 99,
			'ArrayDereference' => 122,
			'PLUS-51' => 426,
			'SubExpression' => 139,
			'Literal' => 146,
			'HashReference' => 145,
			'LoopLabel' => 131,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 133,
			'VariableDeclaration' => 134,
			'VariableModification' => 110,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 115,
			'HashDereference' => 113
		}
	},
	{#State 404
		DEFAULT => -229
	},
	{#State 405
		ACTIONS => {
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			"}" => -225,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP21_LIST_COMMA' => -225,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216
		}
	},
	{#State 406
		ACTIONS => {
			'OP01_OPEN' => 262,
			"}" => 427,
			'OP01_CLOSE' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP01_NAMED_VOID' => 259,
			'OP07_MATH_MULT_DIV_MOD' => 257,
			'OP08_MATH_ADD_SUB' => 258,
			'OP23_LOGICAL_AND' => 244,
			'OP10_NAMED_UNARY' => 255,
			'OP07_STRING_REPEAT' => 242,
			'OP12_COMPARE_EQ_NE' => 251,
			'OP01_NAMED' => 252,
			'OP19_LOOP_CONTROL' => 247,
			'OP01_PRINT' => 239,
			'OP11_COMPARE_LT_GT' => 238,
			'WORD' => 249,
			'OP22_LOGICAL_NEG' => 240,
			'OP24_LOGICAL_OR_XOR' => 248
		},
		GOTOS => {
			'HashEntryProperties' => 428,
			'OpStringOrWord' => 429
		}
	},
	{#State 407
		DEFAULT => -94
	},
	{#State 408
		ACTIONS => {
			";" => 430
		}
	},
	{#State 409
		DEFAULT => -74
	},
	{#State 410
		ACTIONS => {
			'WORD' => 431
		}
	},
	{#State 411
		DEFAULT => -93
	},
	{#State 412
		ACTIONS => {
			";" => 432
		}
	},
	{#State 413
		DEFAULT => -247
	},
	{#State 414
		DEFAULT => -244
	},
	{#State 415
		ACTIONS => {
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'OP01_QW' => 159,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'ARGV' => 157,
			'LBRACKET' => 114,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'MY' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'TypeInner' => 164,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'ListElement' => 163,
			'SubExpression' => 158,
			'ListElements' => 433
		}
	},
	{#State 416
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'OP01_NAMED' => 162,
			'OP10_NAMED_UNARY_SCOLON' => 437,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED_SCOLON' => 435,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109
		},
		GOTOS => {
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'OpNamedScolonOrSubExp' => 434,
			'SubExpression' => 436,
			'HashDereference' => 113,
			'Expression' => 161,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 417
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'ArrayReference' => 136,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashReference' => 145,
			'Literal' => 146,
			'WordScoped' => 130,
			'SubExpression' => 438
		}
	},
	{#State 418
		ACTIONS => {
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 111,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'FHREF_SYMBOL_IN' => 305,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"\@{" => 120,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			'STDIN' => 307
		},
		GOTOS => {
			'WordScoped' => 130,
			'SubExpressionOrInput' => 439,
			'Literal' => 146,
			'HashReference' => 145,
			'SubExpression' => 308,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108
		}
	},
	{#State 419
		DEFAULT => -191
	},
	{#State 420
		ACTIONS => {
			'OP21_LIST_COMMA' => 440
		}
	},
	{#State 421
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 441
		}
	},
	{#State 422
		DEFAULT => -262
	},
	{#State 423
		DEFAULT => -101
	},
	{#State 424
		ACTIONS => {
			'LPAREN' => -183,
			"foreach" => -183,
			"}" => -183,
			"\@{" => -183,
			"%{" => -183,
			"else" => 446,
			'OP01_NAMED_VOID_SCOLON' => -183,
			'' => -183,
			"undef" => -183,
			'OP05_MATH_NEG_LPAREN' => -183,
			'OP01_NAMED_SCOLON' => -183,
			"for" => -183,
			'WORD_UPPERCASE' => -183,
			"if" => -183,
			'LITERAL_STRING' => -183,
			'LBRACE' => -183,
			'OP10_NAMED_UNARY_SCOLON' => -183,
			'OP01_PRINT' => -183,
			'OP05_LOGICAL_NEG' => -183,
			'OP22_LOGICAL_NEG' => -183,
			'OP01_OPEN' => -183,
			'OP05_BITWISE_NEG_LPAREN' => -183,
			'OP01_NAMED_VOID' => -183,
			'OP19_LOOP_CONTROL_SCOLON' => -183,
			'OP01_CLOSE' => -183,
			"elsif" => 442,
			'MY' => -183,
			'OP22_LOGICAL_NEG_LPAREN' => -183,
			'POD' => -183,
			'VARIABLE_SYMBOL' => -183,
			'CONSTANT_CALL_SCOPED' => -183,
			'LITERAL_NUMBER' => -183,
			'LBRACKET' => -183,
			'OP10_NAMED_UNARY' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP01_NAMED' => -183,
			'WORD_SCOPED' => -183,
			"while" => -183,
			'OP19_LOOP_CONTROL' => -183,
			'OP01_NAMED_VOID_LPAREN' => -183,
			'SELF' => -183,
			'WORD' => -183
		},
		GOTOS => {
			'OPTIONAL-50' => 443,
			'PAREN-49' => 444,
			'PAREN-47' => 445
		}
	},
	{#State 425
		DEFAULT => -194
	},
	{#State 426
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'MY' => 106,
			'POD' => 104,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_CLOSE' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_NAMED_VOID' => 94,
			'OP01_NAMED' => 119,
			'OP19_LOOP_CONTROL' => 118,
			'WORD_SCOPED' => 29,
			"while" => -171,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'WORD' => 30,
			'SELF' => 116,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'LPAREN' => 123,
			"}" => 447,
			"foreach" => -171,
			"%{" => 121,
			"\@{" => 120,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			"if" => 143,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_PRINT' => 140,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_NAMED_SCOLON' => 137,
			"for" => -171,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'SubExpression' => 139,
			'Literal' => 146,
			'HashReference' => 145,
			'VariableSymbolOrSelf' => 108,
			'LoopLabel' => 131,
			'Variable' => 133,
			'VariableDeclaration' => 134,
			'VariableModification' => 110,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 115,
			'HashDereference' => 113,
			'OperatorVoid' => 103,
			'Operation' => 448,
			'Statement' => 127,
			'PAREN-45' => 126,
			'WordScoped' => 130,
			'Conditional' => 99,
			'OPTIONAL-46' => 97,
			'ArrayDereference' => 122
		}
	},
	{#State 427
		ACTIONS => {
			";" => 449
		}
	},
	{#State 428
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 450
		}
	},
	{#State 429
		ACTIONS => {
			'OP20_HASH_FATARROW' => 451
		}
	},
	{#State 430
		DEFAULT => -76
	},
	{#State 431
		ACTIONS => {
			'LBRACE' => 452
		}
	},
	{#State 432
		ACTIONS => {
			'OP01_NAMED_VOID' => -58,
			'OP01_CLOSE' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'OP01_OPEN' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'LPAREN_MY' => 455,
			'POD' => -58,
			'VARIABLE_SYMBOL' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'MY' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'LITERAL_NUMBER' => -58,
			'LBRACKET' => -58,
			'OP10_NAMED_UNARY' => -58,
			'WORD_SCOPED' => -58,
			"while" => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'WORD' => -58,
			'SELF' => -58,
			'OP01_NAMED' => -58,
			"\@{" => -58,
			"%{" => -58,
			'LPAREN' => -58,
			"foreach" => -58,
			"}" => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			"undef" => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			"for" => -58,
			'WORD_UPPERCASE' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP01_PRINT' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'LITERAL_STRING' => -58,
			"if" => -58,
			'LBRACE' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 454,
			'OPTIONAL-24' => 453
		}
	},
	{#State 433
		ACTIONS => {
			")" => 456
		}
	},
	{#State 434
		ACTIONS => {
			'VARIABLE_SYMBOL' => 457
		}
	},
	{#State 435
		DEFAULT => -257
	},
	{#State 436
		ACTIONS => {
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP17_LIST_RANGE' => 229,
			'OP15_LOGICAL_AND' => 218,
			'OP08_STRING_CAT' => 228,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP08_MATH_ADD_SUB' => 222,
			";" => 458,
			'OP09_BITWISE_SHIFT' => 221,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215
		}
	},
	{#State 437
		DEFAULT => -258
	},
	{#State 438
		ACTIONS => {
			'OP17_LIST_RANGE' => 459,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			'OP08_STRING_CAT' => 228,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP04_MATH_POW' => 223,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215
		}
	},
	{#State 439
		ACTIONS => {
			")" => 460
		}
	},
	{#State 440
		ACTIONS => {
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'SELF' => 116,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_NAMED' => 162,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'ArrayReference' => 136,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 461,
			'Literal' => 146,
			'WordScoped' => 130,
			'HashReference' => 145
		}
	},
	{#State 441
		ACTIONS => {
			"undef" => 462
		}
	},
	{#State 442
		ACTIONS => {
			'LPAREN' => 463
		}
	},
	{#State 443
		DEFAULT => -184
	},
	{#State 444
		DEFAULT => -182
	},
	{#State 445
		DEFAULT => -179
	},
	{#State 446
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 464
		}
	},
	{#State 447
		DEFAULT => -195
	},
	{#State 448
		DEFAULT => -193
	},
	{#State 449
		DEFAULT => -83
	},
	{#State 450
		ACTIONS => {
			"}" => 466,
			'OP21_LIST_COMMA' => 467
		},
		GOTOS => {
			'PAREN-33' => 465
		}
	},
	{#State 451
		ACTIONS => {
			'MY' => 469
		},
		GOTOS => {
			'TypeInnerProperties' => 468
		}
	},
	{#State 452
		ACTIONS => {
			'LBRACE' => 470
		}
	},
	{#State 453
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 471
		}
	},
	{#State 454
		DEFAULT => -57
	},
	{#State 455
		ACTIONS => {
			'WORD' => 179,
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180
		},
		GOTOS => {
			'Type' => 472
		}
	},
	{#State 456
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 473
		}
	},
	{#State 457
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 474
		}
	},
	{#State 458
		DEFAULT => -259
	},
	{#State 459
		ACTIONS => {
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 138,
			'SELF' => 116,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'SubExpression' => 475,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 161,
			'HashDereference' => 113
		}
	},
	{#State 460
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 476
		}
	},
	{#State 461
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => 227,
			"]" => -102,
			'OP12_COMPARE_EQ_NE' => 216,
			")" => -102,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP15_LOGICAL_AND' => 218,
			"}" => -102,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			";" => -102,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222
		}
	},
	{#State 462
		ACTIONS => {
			";" => 477
		}
	},
	{#State 463
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP01_CLOSE' => 96,
			"%{" => 121,
			"\@{" => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'SubExpression' => 478,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'Expression' => 161,
			'HashDereference' => 113,
			'Operator' => 135,
			'ArrayReference' => 136,
			'ArrayDereference' => 122
		}
	},
	{#State 464
		DEFAULT => -181
	},
	{#State 465
		DEFAULT => -80
	},
	{#State 466
		ACTIONS => {
			";" => 479
		}
	},
	{#State 467
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 257,
			'OP23_LOGICAL_AND' => 244,
			'OP01_OPEN' => 262,
			'OP01_NAMED_VOID' => 259,
			'OP01_CLOSE' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP12_COMPARE_EQ_NE' => 251,
			'OP01_NAMED' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP22_LOGICAL_NEG' => 240,
			'WORD' => 249,
			'OP11_COMPARE_LT_GT' => 238,
			'OP01_PRINT' => 239,
			'OP19_LOOP_CONTROL' => 247,
			'OP10_NAMED_UNARY' => 255,
			'OP07_STRING_REPEAT' => 242
		},
		GOTOS => {
			'OpStringOrWord' => 429,
			'HashEntryProperties' => 480
		}
	},
	{#State 468
		DEFAULT => -228
	},
	{#State 469
		ACTIONS => {
			'WORD' => 179,
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180
		},
		GOTOS => {
			'Type' => 481
		}
	},
	{#State 470
		ACTIONS => {
			'MY' => 482
		}
	},
	{#State 471
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 109,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111,
			'OP19_LOOP_CONTROL' => 118,
			'WORD_SCOPED' => 29,
			"while" => -171,
			'WORD' => 30,
			'SELF' => 116,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'OP01_NAMED' => 119,
			'OP01_CLOSE' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_NAMED_VOID' => 94,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'POD' => 104,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'MY' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"for" => -171,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED_SCOLON' => 137,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_PRINT' => 140,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			"if" => 143,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"%{" => 121,
			"\@{" => 120,
			'LPAREN' => 123,
			"foreach" => -171,
			"}" => 484,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP01_NAMED_VOID_SCOLON' => 128
		},
		GOTOS => {
			'Conditional' => 99,
			'OPTIONAL-46' => 97,
			'ArrayDereference' => 122,
			'Operation' => 483,
			'OperatorVoid' => 103,
			'WordScoped' => 130,
			'Statement' => 127,
			'PAREN-45' => 126,
			'VariableDeclaration' => 134,
			'VariableModification' => 110,
			'LoopLabel' => 131,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 133,
			'Expression' => 115,
			'HashDereference' => 113,
			'ArrayReference' => 136,
			'Operator' => 135,
			'SubExpression' => 139,
			'HashReference' => 145,
			'Literal' => 146
		}
	},
	{#State 472
		ACTIONS => {
			'VARIABLE_SYMBOL' => 485
		}
	},
	{#State 473
		DEFAULT => -190
	},
	{#State 474
		ACTIONS => {
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP01_NAMED' => 162,
			'OP10_NAMED_UNARY_SCOLON' => 437,
			'WORD_SCOPED' => 29,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP01_NAMED_SCOLON' => 435,
			'OP10_NAMED_UNARY' => 111,
			'WORD_UPPERCASE' => 156,
			'OP03_MATH_INC_DEC' => 109,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"undef" => 125,
			'OP05_MATH_NEG_LPAREN' => 124,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			"\@{" => 120,
			'OP01_CLOSE' => 96,
			"%{" => 121
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'Expression' => 161,
			'HashDereference' => 113,
			'SubExpression' => 436,
			'OpNamedScolonOrSubExp' => 486,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145
		}
	},
	{#State 475
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => -124,
			'OP18_TERNARY' => -124,
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP08_STRING_CAT' => 228,
			")" => 487,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP11_COMPARE_LT_GT' => 226,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223
		}
	},
	{#State 476
		DEFAULT => -192
	},
	{#State 477
		DEFAULT => -204
	},
	{#State 478
		ACTIONS => {
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP13_BITWISE_AND' => 217,
			'OP06_REGEX_BIND' => 230,
			'OP17_LIST_RANGE' => 229,
			'OP15_LOGICAL_AND' => 218,
			")" => 488,
			'OP08_STRING_CAT' => 228,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231
		}
	},
	{#State 479
		DEFAULT => -82
	},
	{#State 480
		DEFAULT => -79
	},
	{#State 481
		ACTIONS => {
			"\$TYPED_" => 489
		}
	},
	{#State 482
		ACTIONS => {
			'TYPE_METHOD' => 490,
			'WORD' => 179,
			'WORD_SCOPED' => 180,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 338
		}
	},
	{#State 483
		DEFAULT => -59
	},
	{#State 484
		DEFAULT => -61
	},
	{#State 485
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 491
		}
	},
	{#State 486
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'SELF' => 116,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP01_NAMED' => 162,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'SubExpression' => 493,
			'HashReference' => 145,
			'WordScoped' => 130,
			'Literal' => 146,
			'VariableModification' => 492,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 133,
			'SubExpressionOrVarMod' => 494,
			'HashDereference' => 113,
			'Expression' => 161,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 495
		}
	},
	{#State 488
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 496
		}
	},
	{#State 489
		ACTIONS => {
			'OP07_STRING_REPEAT' => 242,
			'OP10_NAMED_UNARY' => 255,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP22_LOGICAL_NEG' => 240,
			'WORD' => 249,
			'OP11_COMPARE_LT_GT' => 238,
			'OP01_PRINT' => 239,
			'OP19_LOOP_CONTROL' => 247,
			'OP01_NAMED' => 252,
			'OP12_COMPARE_EQ_NE' => 251,
			'OP01_NAMED_VOID' => 259,
			'OP01_CLOSE' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP01_OPEN' => 262,
			'OP23_LOGICAL_AND' => 244,
			'OP08_MATH_ADD_SUB' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 257
		},
		GOTOS => {
			'OpStringOrWord' => 497
		}
	},
	{#State 490
		ACTIONS => {
			"\$RETURN_TYPE" => 498
		}
	},
	{#State 491
		ACTIONS => {
			'OP21_LIST_COMMA' => 499,
			")" => 501
		},
		GOTOS => {
			'PAREN-26' => 500
		}
	},
	{#State 492
		DEFAULT => -168
	},
	{#State 493
		ACTIONS => {
			'OP15_LOGICAL_AND' => 218,
			'OP17_LIST_RANGE' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP08_STRING_CAT' => 228,
			")" => -167,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP16_LOGICAL_OR' => 225,
			'OP07_STRING_REPEAT' => 224,
			'OP04_MATH_POW' => 223,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226
		}
	},
	{#State 494
		ACTIONS => {
			")" => 502
		}
	},
	{#State 495
		DEFAULT => -188
	},
	{#State 496
		DEFAULT => -178
	},
	{#State 497
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 504,
			'OP02_ARRAY_THINARROW' => 503
		}
	},
	{#State 498
		ACTIONS => {
			"}" => 505
		}
	},
	{#State 499
		ACTIONS => {
			'MY' => 506
		}
	},
	{#State 500
		DEFAULT => -63
	},
	{#State 501
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 507
		}
	},
	{#State 502
		ACTIONS => {
			'LBRACE' => 403
		},
		GOTOS => {
			'CodeBlock' => 508
		}
	},
	{#State 503
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 30,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 123,
			'CONSTANT_CALL_SCOPED' => 102,
			'VARIABLE_SYMBOL' => 101,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 107
		},
		GOTOS => {
			'Variable' => 155,
			'VariableSymbolOrSelf' => 108,
			'Expression' => 161,
			'HashDereference' => 113,
			'ArrayReference' => 136,
			'ArrayDereference' => 122,
			'Operator' => 135,
			'SubExpression' => 509,
			'Literal' => 146,
			'HashReference' => 145,
			'WordScoped' => 130
		}
	},
	{#State 504
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			"%{" => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 120,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'LPAREN' => 123,
			'OP01_OPEN' => 100,
			'WORD' => 30,
			'SELF' => 116,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 141,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 162,
			'LBRACE' => 148,
			'LITERAL_STRING' => 144,
			'OP03_MATH_INC_DEC' => 109,
			'WORD_UPPERCASE' => 156,
			'OP10_NAMED_UNARY' => 111,
			'LBRACKET' => 114,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'SubExpression' => 510,
			'WordScoped' => 130,
			'Literal' => 146,
			'HashReference' => 145,
			'VariableSymbolOrSelf' => 108,
			'Variable' => 155,
			'HashDereference' => 113,
			'Expression' => 161,
			'Operator' => 135,
			'ArrayDereference' => 122,
			'ArrayReference' => 136
		}
	},
	{#State 505
		ACTIONS => {
			";" => 511
		}
	},
	{#State 506
		ACTIONS => {
			'WORD' => 179,
			'WORD_SCOPED' => 180,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 512
		}
	},
	{#State 507
		ACTIONS => {
			"\@ARG;" => 513
		}
	},
	{#State 508
		DEFAULT => -189
	},
	{#State 509
		ACTIONS => {
			'OP08_STRING_CAT' => 228,
			'OP15_LOGICAL_AND' => 218,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP17_LIST_RANGE' => 229,
			'OP23_LOGICAL_AND' => 231,
			'OP18_TERNARY' => 219,
			'OP08_MATH_ADD_SUB' => 222,
			'OP09_BITWISE_SHIFT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP04_MATH_POW' => 223,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			"]" => 514,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP14_BITWISE_OR_XOR' => 227
		}
	},
	{#State 510
		ACTIONS => {
			'OP21_LIST_COMMA' => -245,
			'OP04_MATH_POW' => 223,
			'OP07_STRING_REPEAT' => 224,
			'OP16_LOGICAL_OR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP12_COMPARE_EQ_NE' => 216,
			'OP08_STRING_CAT' => 228,
			'OP17_LIST_RANGE' => 229,
			'OP06_REGEX_BIND' => 230,
			'OP13_BITWISE_AND' => 217,
			'OP15_LOGICAL_AND' => 218,
			"}" => -245,
			'OP18_TERNARY' => 219,
			'OP23_LOGICAL_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 220,
			'OP09_BITWISE_SHIFT' => 221,
			'OP08_MATH_ADD_SUB' => 222
		}
	},
	{#State 511
		ACTIONS => {
			'MY' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'VARIABLE_SYMBOL' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'POD' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'LPAREN_MY' => 515,
			'OP01_OPEN' => -85,
			'OP01_NAMED_VOID' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_CLOSE' => -85,
			'OP01_NAMED' => -85,
			'WORD' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'SELF' => -85,
			'WORD_SCOPED' => -85,
			"while" => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP10_NAMED_UNARY' => -85,
			'LITERAL_NUMBER' => -85,
			'LBRACKET' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			"undef" => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			"foreach" => -85,
			"}" => -85,
			'LPAREN' => -85,
			"\@{" => -85,
			"%{" => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'LITERAL_STRING' => -85,
			"if" => -85,
			'LBRACE' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'OP01_PRINT' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'WORD_UPPERCASE' => -85,
			"for" => -85
		},
		GOTOS => {
			'MethodArguments' => 516,
			'OPTIONAL-35' => 517
		}
	},
	{#State 512
		ACTIONS => {
			'VARIABLE_SYMBOL' => 518
		}
	},
	{#State 513
		DEFAULT => -65
	},
	{#State 514
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 519
		}
	},
	{#State 515
		ACTIONS => {
			'WORD' => 179,
			'WORD_SCOPED' => 180,
			'TYPE_INTEGER' => 178
		},
		GOTOS => {
			'Type' => 520
		}
	},
	{#State 516
		DEFAULT => -84
	},
	{#State 517
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 521
		}
	},
	{#State 518
		DEFAULT => -62
	},
	{#State 519
		ACTIONS => {
			"undef" => 522
		}
	},
	{#State 520
		ACTIONS => {
			'SELF' => 523
		}
	},
	{#State 521
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 137,
			'WORD_UPPERCASE' => 132,
			"for" => -171,
			'OP10_NAMED_UNARY_SCOLON' => 142,
			"if" => 143,
			'LITERAL_STRING' => 144,
			'LBRACE' => 148,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_PRINT' => 140,
			'OP05_LOGICAL_NEG' => 141,
			"foreach" => -171,
			"}" => 525,
			'LPAREN' => 123,
			"\@{" => 120,
			"%{" => 121,
			'OP01_NAMED_VOID_SCOLON' => 128,
			'OP05_MATH_NEG_LPAREN' => 124,
			"undef" => 125,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACKET' => 114,
			'OP03_MATH_INC_DEC' => 109,
			'OP01_NAMED' => 119,
			'SELF' => 116,
			'OP01_NAMED_VOID_LPAREN' => 117,
			'WORD' => 30,
			"while" => -171,
			'WORD_SCOPED' => 29,
			'OP19_LOOP_CONTROL' => 118,
			'OP05_BITWISE_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'OP01_NAMED_VOID' => 94,
			'OP01_CLOSE' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP22_LOGICAL_NEG_LPAREN' => 107,
			'MY' => 106,
			'VARIABLE_SYMBOL' => 101,
			'CONSTANT_CALL_SCOPED' => 102,
			'POD' => 104
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'Conditional' => 99,
			'OPTIONAL-46' => 97,
			'Statement' => 127,
			'PAREN-45' => 126,
			'WordScoped' => 130,
			'OperatorVoid' => 103,
			'Operation' => 524,
			'Operator' => 135,
			'ArrayReference' => 136,
			'Expression' => 115,
			'HashDereference' => 113,
			'Variable' => 133,
			'VariableSymbolOrSelf' => 108,
			'LoopLabel' => 131,
			'VariableModification' => 110,
			'VariableDeclaration' => 134,
			'Literal' => 146,
			'HashReference' => 145,
			'SubExpression' => 139
		}
	},
	{#State 522
		DEFAULT => -246
	},
	{#State 523
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 526
		}
	},
	{#State 524
		DEFAULT => -86
	},
	{#State 525
		DEFAULT => -88
	},
	{#State 526
		ACTIONS => {
			'OP21_LIST_COMMA' => 528,
			")" => 527
		},
		GOTOS => {
			'PAREN-37' => 529
		}
	},
	{#State 527
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 530
		}
	},
	{#State 528
		ACTIONS => {
			'MY' => 531
		}
	},
	{#State 529
		DEFAULT => -90
	},
	{#State 530
		ACTIONS => {
			"\@ARG;" => 532
		}
	},
	{#State 531
		ACTIONS => {
			'TYPE_INTEGER' => 178,
			'WORD_SCOPED' => 180,
			'WORD' => 179
		},
		GOTOS => {
			'Type' => 533
		}
	},
	{#State 532
		DEFAULT => -92
	},
	{#State 533
		ACTIONS => {
			'VARIABLE_SYMBOL' => 534
		}
	},
	{#State 534
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7413 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7470 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7533 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7558 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7619 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7626 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7654 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7668 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7707 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7718 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7725 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7743 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7757 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7764 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7778 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7785 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7817 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7824 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7835 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7846 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7857 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7878 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7885 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7896 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7903 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7910 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7917 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7928 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7942 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7949 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7956 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7963 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7970 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7977 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7991 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7998 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8009 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8031 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8045 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8052 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8063 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8074 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8102 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8113 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8120 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8127 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8134 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8145 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8156 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8167 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8178 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8189 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8200 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8211 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8222 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8233 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8244 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8255 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8266 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8277 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8288 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8299 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8310 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8321 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8332 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8343 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8354 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8365 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8376 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8387 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8398 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8409 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8420 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8431 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8442 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8453 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8464 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8475 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8486 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8497 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8508 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8519 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8552 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8559 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8566 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8573 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8580 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 237 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8587 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8598 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8609 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8620 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8631 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8642 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8653 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8664 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8675 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8689 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8696 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8703 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8710 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8717 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8728 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8739 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8750 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8761 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8772 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8783 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8794 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8805 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8816 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8827 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8838 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8849 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8860 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8871 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8882 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8893 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8904 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8915 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8926 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_168
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8937 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8944 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8951 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8958 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8969 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8980 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8991 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9002 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_177
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9031 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9045 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9052 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9059 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9066 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_184
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9077 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9088 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_186
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9099 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_187
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9110 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_188
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9121 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_189
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9132 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_190
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9143 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_191
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9154 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_192
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9165 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9172 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9179 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_195
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9204 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_198
		 'Variable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9215 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_199
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_200
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9237 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_201
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9248 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_202
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9259 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_203
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9270 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_204
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9281 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_205
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9292 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_206
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9303 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_207
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9314 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9321 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9328 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9335 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_211
		 'ListElements', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9346 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_212
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9357 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_213
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9368 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_214
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9379 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_215
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9390 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9397 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9404 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_218
		 'ArrayReference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9415 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9422 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9429 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_221
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9440 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_222
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9451 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 264 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 264 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9465 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_225
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9476 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_226
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9487 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_227
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9498 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_228
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9509 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 266 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9516 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 266 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9523 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 266 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9530 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_232
		 'HashReference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9541 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_233
		 'HashReference', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9552 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9559 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9566 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_236
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9577 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_237
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9588 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_238
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9599 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_239
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9610 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_240
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9621 lib/RPerl/Grammar.pm
	],
	[#Rule Type_241
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9632 lib/RPerl/Grammar.pm
	],
	[#Rule Type_242
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9643 lib/RPerl/Grammar.pm
	],
	[#Rule Type_243
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9654 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_244
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9665 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_245
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9676 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_246
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9687 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_247
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9698 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_248
		 'VariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9709 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_249
		 'VariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9720 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_250
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9731 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_251
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9742 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_252
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9753 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_253
		 'VariableSymbolOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9764 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_254
		 'VariableSymbolOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9775 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_255
		 'Literal', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9786 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_256
		 'Literal', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9797 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_257
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9808 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_258
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9819 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_259
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9830 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_260
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9841 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_261
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9852 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_262
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9863 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9874 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9885 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9896 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9907 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9918 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9929 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9940 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9951 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9962 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9973 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_273
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9984 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_274
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9995 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_275
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10006 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_276
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10017 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_277
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10028 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_278
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10039 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_279
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10050 lib/RPerl/Grammar.pm
	]
],
#line 10053 lib/RPerl/Grammar.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         '_PAREN', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CompileUnit_4', 
         'CompileUnit_5', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_18', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ModuleHeader_23', 
         'Module_24', 
         'Module_25', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_36', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Header_39', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_42', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Exports_49', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Include_54', 
         'Include_55', 
         'Constant_56', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_61', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_65', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_76', 
         'UseParent_77', 
         'UseParent_78', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_82', 
         'Properties_83', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_88', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_92', 
         'SubroutineOrMethod_93', 
         'SubroutineOrMethod_94', 
         'Operation_95', 
         'Operation_96', 
         'Operation_97', 
         'Operation_98', 
         'Operator_99', 
         'Operator_100', 
         'Operator_101', 
         'Operator_102', 
         'Operator_103', 
         'Operator_104', 
         'Operator_105', 
         'Operator_106', 
         'Operator_107', 
         'Operator_108', 
         'Operator_109', 
         'Operator_110', 
         'Operator_111', 
         'Operator_112', 
         'Operator_113', 
         'Operator_114', 
         'Operator_115', 
         'Operator_116', 
         'Operator_117', 
         'Operator_118', 
         'Operator_119', 
         'Operator_120', 
         'Operator_121', 
         'Operator_122', 
         'Operator_123', 
         'Operator_124', 
         'Operator_125', 
         'Operator_126', 
         'Operator_127', 
         'Operator_128', 
         'Operator_129', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_135', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         'OperatorVoid_139', 
         'OperatorVoid_140', 
         'OperatorVoid_141', 
         'OperatorVoid_142', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_149', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'Expression_154', 
         'SubExpression_155', 
         'SubExpression_156', 
         'SubExpression_157', 
         'SubExpression_158', 
         'SubExpression_159', 
         'SubExpression_160', 
         'SubExpression_161', 
         'SubExpression_162', 
         'SubExpression_163', 
         'SubExpressionOrInput_164', 
         'SubExpressionOrInput_165', 
         'SubExpressionOrInput_166', 
         'SubExpressionOrVarMod_167', 
         'SubExpressionOrVarMod_168', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_172', 
         'Statement_173', 
         'Statement_174', 
         'Statement_175', 
         'Statement_176', 
         'Statement_177', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_184', 
         'Loop_185', 
         'Loop_186', 
         'Loop_187', 
         'LoopFor_188', 
         'LoopFor_189', 
         'LoopForEach_190', 
         'LoopWhile_191', 
         'LoopWhile_192', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_195', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_198', 
         'VariableRetrieval_199', 
         'VariableRetrieval_200', 
         'VariableRetrieval_201', 
         'VariableDeclaration_202', 
         'VariableDeclaration_203', 
         'VariableDeclaration_204', 
         'VariableDeclaration_205', 
         'VariableModification_206', 
         'VariableModification_207', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_211', 
         'ListElement_212', 
         'ListElement_213', 
         'ListElement_214', 
         'ListElement_215', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_218', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_221', 
         'ArrayDereference_222', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_225', 
         'HashEntry_226', 
         'HashEntry_227', 
         'HashEntryProperties_228', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_232', 
         'HashReference_233', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_236', 
         'HashDereference_237', 
         'WordScoped_238', 
         'WordScoped_239', 
         'LoopLabel_240', 
         'Type_241', 
         'Type_242', 
         'Type_243', 
         'TypeInner_244', 
         'TypeInnerProperties_245', 
         'TypeInnerProperties_246', 
         'TypeInnerConstant_247', 
         'VariableOrLiteral_248', 
         'VariableOrLiteral_249', 
         'VarOrLitOrOpStrOrWord_250', 
         'VarOrLitOrOpStrOrWord_251', 
         'VarOrLitOrOpStrOrWord_252', 
         'VariableSymbolOrSelf_253', 
         'VariableSymbolOrSelf_254', 
         'Literal_255', 
         'Literal_256', 
         'OpNamedScolonOrSubExp_257', 
         'OpNamedScolonOrSubExp_258', 
         'OpNamedScolonOrSubExp_259', 
         'OpNamedScolonOrSubExpIn_260', 
         'OpNamedScolonOrSubExpIn_261', 
         'OpNamedScolonOrSubExpIn_262', 
         'OpStringOrWord_263', 
         'OpStringOrWord_264', 
         'OpStringOrWord_265', 
         'OpStringOrWord_266', 
         'OpStringOrWord_267', 
         'OpStringOrWord_268', 
         'OpStringOrWord_269', 
         'OpStringOrWord_270', 
         'OpStringOrWord_271', 
         'OpStringOrWord_272', 
         'OpStringOrWord_273', 
         'OpStringOrWord_274', 
         'OpStringOrWord_275', 
         'OpStringOrWord_276', 
         'OpStringOrWord_277', 
         'OpStringOrWord_278', 
         'OpStringOrWord_279', );
  $self;
}

#line 288 "lib/RPerl/Grammar.eyp"


# [[[ SEMANTIC MAP, ABSTRACT SYNTAX TREE NODES TO CLASSES ]]]

{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1.  Update grammar code in this file, above this line only
# 2.  Run `script/development/grammar_recompile.sh`
# 3.  Run `perl t/12_parse.t` for new & existing grammar parse-only tests, if errors goto step 1
# 4.  Inspect updates from Grammar.output file, note starting & finishing & increment/decrement numbers if any rule numbers have changed
# 5a. Run `script/development/grammar_increment.pl START FINISH INCREMENT` if rules added from step 4, repeat if needed
# 5b. Run `script/development/grammar_decrement.pl START FINISH DECREMENT` if rules deleted from step 4, repeat if needed
# 6.  Copy updates from Grammar.output file into this file with now-unique numbers, below this line only, if not-automatically-generated rules have been added
# 7.  Run `script/development/grammar_recompile.sh` again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',                             # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',                              # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG OPTIONAL-3 USE_RPERL Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_23 => 'RPerl::CompileUnit::Module::Header',                    # ModuleHeader -> OPTIONAL-9 OPTIONAL-10 'package' WordScoped ';' Header
Module_24 => 'RPerl::CompileUnit::Module::Package',                         # Module -> Package
Module_25 => 'RPerl::CompileUnit::Module::Class::Generator',                # Module -> Class
Package_36 => 'RPerl::CompileUnit::Module::Package',                        # Package -> STAR-11 OPTIONAL-12 STAR-13 STAR-14 PLUS-15 LITERAL_NUMBER ';'
Header_39 => 'RPerl::NonGenerator',                                         # Header -> 'use strict;' 'use warnings;' OPTIONAL-16 'our' VERSION_NUMBER_ASSIGN
Critic_42 => 'RPerl::CompileUnit::Critic',                                  # Critic -> '## no critic qw(' PLUS-17 ')'
Exports_49 => 'RPerl::NonGenerator',                                        # Exports -> USE_EXPORTER OPTIONAL-19 OPTIONAL-21
Include_54 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OPTIONAL-22 ';'
Include_55 => 'RPerl::CompileUnit::Include',                                # Include -> 'INIT' LBRACE WordScoped OP02_METHOD_THINARROW_IMP OPTIONAL-23 ')' ';' '}'
Constant_56 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_61 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> SUB WORD LBRACE LBRACE MY Type '$RETURN_TYPE' '}' ';' OPTIONAL-22 STAR-23 '}'
SubroutineArguments_65 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-25 ')' OP19_VARIABLE_ASSIGN '@ARG;'
Class_76 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> UseParent WordScoped ')' ';' Include STAR-28 OPTIONAL-29 STAR-30 STAR-31 Properties STAR-32 LITERAL_NUMBER ';'
UseParent_77 => 'RPerl::NonGenerator',                                      # UseParent -> 'use parent qw('
UseParent_78 => 'RPerl::NonGenerator',                                      # UseParent -> 'use parent -norequire, qw('
Properties_82 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-32 '}' ';'
Properties_83 => 'RPerl::NonGenerator',                                     # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_88 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> SUB WORD LBRACE LBRACE MY TYPE_METHOD '$RETURN_TYPE' '}' ';' OPTIONAL-33 STAR-34 '}'
MethodArguments_92 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY Type SELF STAR-36 ')' OP19_VARIABLE_ASSIGN '@ARG;'
SubroutineOrMethod_93 => 'RPerl::CodeBlock::Subroutine',                    # SubroutineOrMethod -> Subroutine
SubroutineOrMethod_94 => 'RPerl::CodeBlock::Subroutine::Method',            # SubroutineOrMethod -> Method
Operation_95 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_96 => 'RPerl::Operation::Expression::Operator::Named',            # Operation -> OP01_NAMED_SCOLON
Operation_97 => 'RPerl::Operation::Expression::Operator::NamedUnary',       # Operation -> OP10_NAMED_UNARY_SCOLON
Operation_98 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_99 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_100 => 'RPerl::Operation::Expression::Operator::Named',            # Operator -> OP01_NAMED SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Named',            # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_102 => 'RPerl::Operation::Expression::Operator::Open',             # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Close',            # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_104 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> OP03_MATH_INC_DEC Variable
Operator_105 => 'RPerl::Operation::Expression::Operator::IncrementDecrement',                # Operator -> Variable OP03_MATH_INC_DEC
Operator_106 => 'RPerl::Operation::Expression::Operator::Arithmetic::Power',                 # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Bitwise::Negation',                 # Operator -> OP05_BITWISE_NEG_LPAREN SubExpression ')'
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Arithmetic::Negative',              # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_110 => 'RPerl::Operation::Expression::Operator::RegularExpression',                 # Operator -> SubExpression OP06_REGEX_BIND OP06_REGEX_PATTERN
Operator_111 => 'RPerl::Operation::Expression::Operator::String::Repeat',                    # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_112 => 'RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo',  # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_113 => 'RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract',           # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_114 => 'RPerl::Operation::Expression::Operator::String::Concatenate',               # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_115 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                    # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_116 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY SubExpression
Operator_117 => 'RPerl::Operation::Expression::Operator::NamedUnary',                        # Operator -> OP10_NAMED_UNARY
Operator_118 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',      # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_119 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',            # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_120 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                      # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_121 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                    # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_122 => 'RPerl::Operation::Expression::Operator::Logical::And',                      # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_123 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                    # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_124 => 'RPerl::Operation::Expression::Operator::List::Range',                       # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_125 => 'RPerl::Operation::Expression::Operator::Ternary',                           # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_126 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
Operator_127 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                 # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_128 => 'RPerl::Operation::Expression::Operator::Logical::And',                      # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_129 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                    # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_135 => 'RPerl::Operation::Statement::OperatorVoid::Print',                      # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_136 => 'RPerl::Operation::Statement::OperatorVoid::Print',                      # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_137 => 'RPerl::Operation::Statement::OperatorVoid::Named',                      # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_138 => 'RPerl::Operation::Statement::OperatorVoid::Named',                      # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_139 => 'RPerl::Operation::Statement::OperatorVoid::Named',                      # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_140 => 'RPerl::Operation::Expression::Operator::Named',                         # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_141 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',                # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_142 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',                # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_149 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_150 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_151 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_152 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-40 ')'
Expression_153 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-41 ')'
Expression_154 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-42 ')'
SubExpression_155 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_156 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_157 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_158 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_159 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_160 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_161 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_162 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_163 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_164 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_165 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_166 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_167 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_168 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_172 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_173 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-44 Loop
Statement_174 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_175 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_176 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Statement_177 => 'RPerl::NonGenerator',                                                         # Statement -> POD
Conditional_184 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-46 OPTIONAL-48
Loop_185 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_186 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_187 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_188 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_189 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_190 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_191 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_192 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_195 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-49 '}'
Variable_198 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-50
VariableRetrieval_199 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_200 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_201 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_202 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_203 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_204 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_205 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_206 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_207 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_211 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-52
ListElement_212 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_213 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_214 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_215 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_218 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-53 ']'
ArrayDereference_221 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_222 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-54 ArrayReference '}'
HashEntry_225 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
HashEntry_226 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_227 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_228 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_232 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-57 '}'
HashReference_233 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_236 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_237 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-58 HashReference '}'
WordScoped_238 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_239 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_240 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_241 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_242 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_243 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_244 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_245 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_246 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_247 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_248 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_249 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_250 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_251 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_252 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_253 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_254 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_255 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_256 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_257 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_258 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_259 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_260 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_261 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_262 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_263 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_264 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_265 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_266 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_267 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_268 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_269 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_270 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_271 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_272 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_273 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_274 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_275 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_276 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_277 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_278 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_279 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 10549 lib/RPerl/Grammar.pm



1;
