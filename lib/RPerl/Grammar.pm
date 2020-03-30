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
    our $VERSION = 0.021_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|package|\$TYPED_|foreach|elsif|undef|\@ARG\;|while|INIT|else|for|if|\%\{|\@\{|\]|\)|\}|\;)}gc and return ($1, $1);

      /\G(\=[a-zA-Z].*?\n(?:.|\n)*?\n\=cut\s*)/gc and return ('POD', $1);
      /\G(^#!\/(?:\w[\w.-]*\/)*[\w.-]*\s*[\w.-]*perl[\w.-]*)/gc and return ('SHEBANG', $1);
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
      /\G(\$(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('SCALAR_SYMBOL', $1);
      /\G(\@(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('ARRAY_SYMBOL', $1);
      /\G(\\\@(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('ARRAY_REF_SYMBOL', $1);
      /\G(\%(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('HASH_SYMBOL', $1);
      /\G(\\\%(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('HASH_REF_SYMBOL', $1);
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


#line 161 lib/RPerl/Grammar.pm

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
  [ 'Constant_56' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'ScalarLiteral', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Subroutine_61' => 'Subroutine', [ 'SUB', 'WORD', 'LBRACE', 'LBRACE', 'MY', 'Type', '$RETURN_TYPE', '}', ';', 'OPTIONAL-24', 'STAR-25', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'SCALAR_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'PAREN-26' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'SubroutineArguments_65' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'STAR-27', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
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
  [ '_PAREN' => 'PAREN-37', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'SCALAR_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ 'MethodArguments_92' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-38', ')', 'OP19_VARIABLE_ASSIGN', '@ARG;' ], 0 ],
  [ 'SubroutineOrMethod_93' => 'SubroutineOrMethod', [ 'Subroutine' ], 0 ],
  [ 'SubroutineOrMethod_94' => 'SubroutineOrMethod', [ 'Method' ], 0 ],
  [ 'Operation_95' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_96' => 'Operation', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'Operation_97' => 'Operation', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'Operation_98' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'SubExpressions', ')' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpressions', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP03_MATH_INC_DEC', 'ScalarVariable' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'ScalarVariable', 'OP03_MATH_INC_DEC' ], 0 ],
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
  [ 'Operator_125' => 'Operator', [ 'LPAREN', 'SubExpression', 'OP18_TERNARY', 'SubExpression', 'COLON', 'SubExpression', ')' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_127' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_128' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_129' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'OperatorVoid_135' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-40', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_140' => 'OperatorVoid', [ 'OP01_NAMED', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_141' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_142' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Expression_149' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'ScalarVariable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-43', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-44', ')' ], 0 ],
  [ 'SubExpression_155' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'Scalar' ], 0 ],
  [ 'SubExpression_158' => 'SubExpression', [ 'ArrayHashLiteralEmpty' ], 0 ],
  [ 'SubExpression_159' => 'SubExpression', [ 'ArrayHashLiteral' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'Array' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_163' => 'SubExpression', [ 'Hash' ], 0 ],
  [ 'SubExpression_164' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_165' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpressionOrInput_166' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_167' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_168' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_169' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_170' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'PAREN-45' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'Statement_174' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_175' => 'Statement', [ 'OPTIONAL-46', 'Loop' ], 0 ],
  [ 'Statement_176' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_177' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_178' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ 'Statement_179' => 'Statement', [ 'POD' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Conditional_186' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-48', 'OPTIONAL-50' ], 0 ],
  [ 'Loop_187' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_188' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_189' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_190' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_191' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'SCALAR_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_192' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpressions', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_193' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_194' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'PLUS-51', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'Operation' ], 0 ],
  [ 'CodeBlock_197' => 'CodeBlock', [ 'LBRACE', 'PLUS-51', '}' ], 0 ],
  [ 'Variable_198' => 'Variable', [ 'ScalarVariable' ], 0 ],
  [ 'Variable_199' => 'Variable', [ 'ArrayVariable' ], 0 ],
  [ 'Variable_200' => 'Variable', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'Variable_201' => 'Variable', [ 'HashVariable' ], 0 ],
  [ 'Variable_202' => 'Variable', [ 'HashReferenceVariable' ], 0 ],
  [ 'VariableRetrievalArrow_203' => 'VariableRetrievalArrow', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalArrow_204' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalArrow_205' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableRetrieval_206' => 'VariableRetrieval', [ 'VariableRetrievalArrow' ], 0 ],
  [ 'VariableRetrieval_207' => 'VariableRetrieval', [ 'LBRACKET', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_208' => 'VariableRetrieval', [ 'LBRACE', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_209' => 'VariableRetrieval', [ 'LBRACE', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_210' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_211' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_212' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_213' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_214' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_215' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_216' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_217' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_218' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_219' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ 'Scalar_220' => 'Scalar', [ 'ScalarLiteral' ], 0 ],
  [ 'Scalar_221' => 'Scalar', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarLiteral_222' => 'ScalarLiteral', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'ScalarLiteral_223' => 'ScalarLiteral', [ 'LITERAL_STRING' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'VariableRetrieval' ], 0 ],
  [ 'ScalarVariable_226' => 'ScalarVariable', [ 'ScalarVariableOrSelf' ], 0 ],
  [ 'ScalarVariable_227' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow' ], 0 ],
  [ 'ScalarVariable_228' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow', 'PLUS-52' ], 0 ],
  [ 'ScalarVariableOrSelf_229' => 'ScalarVariableOrSelf', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarVariableOrSelf_230' => 'ScalarVariableOrSelf', [ 'SELF' ], 0 ],
  [ 'ArrayHashLiteral_231' => 'ArrayHashLiteral', [ 'LPAREN', 'SubExpressions', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [ 'STAR-54', 'PAREN-53' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [  ], 0 ],
  [ 'SubExpressions_235' => 'SubExpressions', [ 'SubExpression', 'STAR-54' ], 0 ],
  [ 'ArrayHashLiteralEmpty_236' => 'ArrayHashLiteralEmpty', [ 'LPAREN', ')' ], 0 ],
  [ 'BracketsEmpty_237' => 'BracketsEmpty', [ 'LBRACKET', ']' ], 0 ],
  [ 'BracesEmpty_238' => 'BracesEmpty', [ 'LBRACE', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'ListElements_242' => 'ListElements', [ 'ListElement', 'STAR-56' ], 0 ],
  [ 'ListElement_243' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_244' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_245' => 'ListElement', [ 'ARGV' ], 0 ],
  [ 'Array_246' => 'Array', [ 'ArrayLiteral' ], 0 ],
  [ 'Array_247' => 'Array', [ 'ArrayVariable' ], 0 ],
  [ 'ArrayLiteral_248' => 'ArrayLiteral', [ 'LPAREN', 'ListElements', ')' ], 0 ],
  [ 'ArrayVariable_249' => 'ArrayVariable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'ArrayReference_250' => 'ArrayReference', [ 'ArrayReferenceLiteral' ], 0 ],
  [ 'ArrayReference_251' => 'ArrayReference', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'ArrayReferenceLiteral_252' => 'ArrayReferenceLiteral', [ 'LBRACKET', 'ListElements', ']' ], 0 ],
  [ 'ArrayReferenceLiteral_253' => 'ArrayReferenceLiteral', [ 'BracketsEmpty' ], 0 ],
  [ 'ArrayReferenceVariable_254' => 'ArrayReferenceVariable', [ 'ARRAY_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'ArrayDereference_257' => 'ArrayDereference', [ '@{', 'ScalarVariable', '}' ], 0 ],
  [ 'ArrayDereference_258' => 'ArrayDereference', [ '@{', 'OPTIONAL-57', 'ArrayReference', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashEntries_262' => 'HashEntries', [ 'HashEntry', 'STAR-59' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashEntry_265' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-60', 'SubExpression' ], 0 ],
  [ 'HashEntry_266' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_267' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ 'Hash_268' => 'Hash', [ 'HashLiteral' ], 0 ],
  [ 'Hash_269' => 'Hash', [ 'HashVariable' ], 0 ],
  [ 'HashLiteral_270' => 'HashLiteral', [ 'LPAREN', 'HashEntries', ')' ], 0 ],
  [ 'HashVariable_271' => 'HashVariable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'HashReference_272' => 'HashReference', [ 'HashReferenceLiteral' ], 0 ],
  [ 'HashReference_273' => 'HashReference', [ 'HashReferenceVariable' ], 0 ],
  [ 'HashReferenceLiteral_274' => 'HashReferenceLiteral', [ 'LBRACE', 'HashEntries', '}' ], 0 ],
  [ 'HashReferenceLiteral_275' => 'HashReferenceLiteral', [ 'BracesEmpty' ], 0 ],
  [ 'HashReferenceVariable_276' => 'HashReferenceVariable', [ 'HASH_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-61', [  ], 0 ],
  [ 'HashDereference_279' => 'HashDereference', [ '%{', 'ScalarVariable', '}' ], 0 ],
  [ 'HashDereference_280' => 'HashDereference', [ '%{', 'OPTIONAL-61', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_281' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_282' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_283' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_284' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_285' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_286' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_287' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_288' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_289' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_290' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_291' => 'VarOrLitOrOpStrOrWord', [ 'ScalarVariable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_292' => 'VarOrLitOrOpStrOrWord', [ 'ScalarLiteral' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_293' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'OpNamedScolonOrSubExp_294' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_295' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_296' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_297' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_298' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_299' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_300' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_301' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_302' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_303' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_304' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_305' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_306' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_307' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_308' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_309' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_310' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_311' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_312' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_313' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_314' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_315' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_316' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'SubExpression_164' => 164,
  'SubExpression_165' => 165,
  'SubExpressionOrInput_166' => 166,
  'SubExpressionOrInput_167' => 167,
  'SubExpressionOrInput_168' => 168,
  'SubExpressionOrVarMod_169' => 169,
  'SubExpressionOrVarMod_170' => 170,
  '_PAREN' => 171,
  '_OPTIONAL' => 172,
  '_OPTIONAL' => 173,
  'Statement_174' => 174,
  'Statement_175' => 175,
  'Statement_176' => 176,
  'Statement_177' => 177,
  'Statement_178' => 178,
  'Statement_179' => 179,
  '_PAREN' => 180,
  '_STAR_LIST' => 181,
  '_STAR_LIST' => 182,
  '_PAREN' => 183,
  '_OPTIONAL' => 184,
  '_OPTIONAL' => 185,
  'Conditional_186' => 186,
  'Loop_187' => 187,
  'Loop_188' => 188,
  'Loop_189' => 189,
  'LoopFor_190' => 190,
  'LoopFor_191' => 191,
  'LoopForEach_192' => 192,
  'LoopWhile_193' => 193,
  'LoopWhile_194' => 194,
  '_PLUS_LIST' => 195,
  '_PLUS_LIST' => 196,
  'CodeBlock_197' => 197,
  'Variable_198' => 198,
  'Variable_199' => 199,
  'Variable_200' => 200,
  'Variable_201' => 201,
  'Variable_202' => 202,
  'VariableRetrievalArrow_203' => 203,
  'VariableRetrievalArrow_204' => 204,
  'VariableRetrievalArrow_205' => 205,
  'VariableRetrieval_206' => 206,
  'VariableRetrieval_207' => 207,
  'VariableRetrieval_208' => 208,
  'VariableRetrieval_209' => 209,
  'VariableDeclaration_210' => 210,
  'VariableDeclaration_211' => 211,
  'VariableDeclaration_212' => 212,
  'VariableDeclaration_213' => 213,
  'VariableDeclaration_214' => 214,
  'VariableDeclaration_215' => 215,
  'VariableDeclaration_216' => 216,
  'VariableDeclaration_217' => 217,
  'VariableModification_218' => 218,
  'VariableModification_219' => 219,
  'Scalar_220' => 220,
  'Scalar_221' => 221,
  'ScalarLiteral_222' => 222,
  'ScalarLiteral_223' => 223,
  '_PLUS_LIST' => 224,
  '_PLUS_LIST' => 225,
  'ScalarVariable_226' => 226,
  'ScalarVariable_227' => 227,
  'ScalarVariable_228' => 228,
  'ScalarVariableOrSelf_229' => 229,
  'ScalarVariableOrSelf_230' => 230,
  'ArrayHashLiteral_231' => 231,
  '_PAREN' => 232,
  '_STAR_LIST' => 233,
  '_STAR_LIST' => 234,
  'SubExpressions_235' => 235,
  'ArrayHashLiteralEmpty_236' => 236,
  'BracketsEmpty_237' => 237,
  'BracesEmpty_238' => 238,
  '_PAREN' => 239,
  '_STAR_LIST' => 240,
  '_STAR_LIST' => 241,
  'ListElements_242' => 242,
  'ListElement_243' => 243,
  'ListElement_244' => 244,
  'ListElement_245' => 245,
  'Array_246' => 246,
  'Array_247' => 247,
  'ArrayLiteral_248' => 248,
  'ArrayVariable_249' => 249,
  'ArrayReference_250' => 250,
  'ArrayReference_251' => 251,
  'ArrayReferenceLiteral_252' => 252,
  'ArrayReferenceLiteral_253' => 253,
  'ArrayReferenceVariable_254' => 254,
  '_OPTIONAL' => 255,
  '_OPTIONAL' => 256,
  'ArrayDereference_257' => 257,
  'ArrayDereference_258' => 258,
  '_PAREN' => 259,
  '_STAR_LIST' => 260,
  '_STAR_LIST' => 261,
  'HashEntries_262' => 262,
  '_OPTIONAL' => 263,
  '_OPTIONAL' => 264,
  'HashEntry_265' => 265,
  'HashEntry_266' => 266,
  'HashEntryProperties_267' => 267,
  'Hash_268' => 268,
  'Hash_269' => 269,
  'HashLiteral_270' => 270,
  'HashVariable_271' => 271,
  'HashReference_272' => 272,
  'HashReference_273' => 273,
  'HashReferenceLiteral_274' => 274,
  'HashReferenceLiteral_275' => 275,
  'HashReferenceVariable_276' => 276,
  '_OPTIONAL' => 277,
  '_OPTIONAL' => 278,
  'HashDereference_279' => 279,
  'HashDereference_280' => 280,
  'WordScoped_281' => 281,
  'WordScoped_282' => 282,
  'LoopLabel_283' => 283,
  'Type_284' => 284,
  'Type_285' => 285,
  'Type_286' => 286,
  'TypeInner_287' => 287,
  'TypeInnerProperties_288' => 288,
  'TypeInnerProperties_289' => 289,
  'TypeInnerConstant_290' => 290,
  'VarOrLitOrOpStrOrWord_291' => 291,
  'VarOrLitOrOpStrOrWord_292' => 292,
  'VarOrLitOrOpStrOrWord_293' => 293,
  'OpNamedScolonOrSubExp_294' => 294,
  'OpNamedScolonOrSubExp_295' => 295,
  'OpNamedScolonOrSubExp_296' => 296,
  'OpNamedScolonOrSubExpIn_297' => 297,
  'OpNamedScolonOrSubExpIn_298' => 298,
  'OpNamedScolonOrSubExpIn_299' => 299,
  'OpStringOrWord_300' => 300,
  'OpStringOrWord_301' => 301,
  'OpStringOrWord_302' => 302,
  'OpStringOrWord_303' => 303,
  'OpStringOrWord_304' => 304,
  'OpStringOrWord_305' => 305,
  'OpStringOrWord_306' => 306,
  'OpStringOrWord_307' => 307,
  'OpStringOrWord_308' => 308,
  'OpStringOrWord_309' => 309,
  'OpStringOrWord_310' => 310,
  'OpStringOrWord_311' => 311,
  'OpStringOrWord_312' => 312,
  'OpStringOrWord_313' => 313,
  'OpStringOrWord_314' => 314,
  'OpStringOrWord_315' => 315,
  'OpStringOrWord_316' => 316,
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
	ARRAY_REF_SYMBOL => { ISSEMANTIC => 1 },
	ARRAY_SYMBOL => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	ENV => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_IN => { ISSEMANTIC => 1 },
	HASH_REF_SYMBOL => { ISSEMANTIC => 1 },
	HASH_SYMBOL => { ISSEMANTIC => 1 },
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
	SCALAR_SYMBOL => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 4,
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'CompileUnit' => 5,
			'Program' => 3,
			'PLUS-2' => 1,
			'OPTIONAL-9' => 2,
			'ModuleHeader' => 6,
			'PAREN-1' => 9,
			'Critic' => 7
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => -20,
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'ModuleHeader' => 6,
			'Critic' => 7,
			'PAREN-1' => 10,
			'OPTIONAL-9' => 2
		}
	},
	{#State 2
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 12
		},
		GOTOS => {
			'OPTIONAL-10' => 11
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 8,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 13,
			'Critic' => 14
		}
	},
	{#State 5
		ACTIONS => {
			'' => 15
		}
	},
	{#State 6
		ACTIONS => {
			'SUB' => -27,
			"## no critic qw(" => -27,
			'USE_EXPORTER' => -27,
			"INIT" => -27,
			'USE' => -27,
			"use parent -norequire, qw(" => 17,
			"use constant" => -27,
			"use parent qw(" => 16
		},
		GOTOS => {
			'Class' => 18,
			'Module' => 22,
			'STAR-11' => 21,
			'UseParent' => 20,
			'Package' => 19
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'WORD' => 24
		},
		GOTOS => {
			'PLUS-17' => 23
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 12
		DEFAULT => -21
	},
	{#State 13
		ACTIONS => {
			'USE_RPERL' => 26
		}
	},
	{#State 14
		DEFAULT => -6
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -77
	},
	{#State 17
		DEFAULT => -78
	},
	{#State 18
		DEFAULT => -25
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 21
		ACTIONS => {
			"## no critic qw(" => 8,
			"use constant" => -29,
			"INIT" => -29,
			'USE_EXPORTER' => 32,
			'USE' => -29,
			'SUB' => -29
		},
		GOTOS => {
			'Exports' => 33,
			'Critic' => 31,
			'OPTIONAL-12' => 30
		}
	},
	{#State 22
		DEFAULT => -1
	},
	{#State 23
		ACTIONS => {
			'WORD' => 34,
			")" => 35
		}
	},
	{#State 24
		DEFAULT => -41
	},
	{#State 25
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 26
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 27
		DEFAULT => -281
	},
	{#State 28
		ACTIONS => {
			")" => 39
		}
	},
	{#State 29
		DEFAULT => -282
	},
	{#State 30
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 40
		}
	},
	{#State 31
		DEFAULT => -26
	},
	{#State 32
		ACTIONS => {
			'SUB' => -45,
			"our hashref \$properties" => -45,
			"INIT" => -45,
			'OUR_EXPORT' => 42,
			'OUR_EXPORT_OK' => -45,
			'USE' => -45,
			"use constant" => -45
		},
		GOTOS => {
			'PAREN-18' => 43,
			'OPTIONAL-19' => 41
		}
	},
	{#State 33
		DEFAULT => -28
	},
	{#State 34
		DEFAULT => -40
	},
	{#State 35
		DEFAULT => -42
	},
	{#State 36
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 45
		}
	},
	{#State 38
		ACTIONS => {
			"use warnings;" => 46
		}
	},
	{#State 39
		ACTIONS => {
			";" => 47
		}
	},
	{#State 40
		ACTIONS => {
			"use constant" => -33,
			"INIT" => 48,
			'SUB' => -33,
			'USE' => 49
		},
		GOTOS => {
			'Include' => 51,
			'STAR-14' => 50
		}
	},
	{#State 41
		ACTIONS => {
			'USE' => -48,
			'SUB' => -48,
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 54,
			"use constant" => -48,
			"INIT" => -48
		},
		GOTOS => {
			'PAREN-20' => 53,
			'OPTIONAL-21' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'OP01_QW' => 55
		}
	},
	{#State 43
		DEFAULT => -44
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD_UPPERCASE' => -11,
			'ARRAY_REF_SYMBOL' => -11,
			"%{" => -11,
			'LBRACKET' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP01_OPEN' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'POD' => -11,
			'OP01_PRINT' => -11,
			"INIT" => -11,
			'OP10_NAMED_UNARY' => -11,
			"if" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'SUB' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"for" => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"\@{" => -11,
			"## no critic qw(" => 8,
			"undef" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'HASH_SYMBOL' => -11,
			'LBRACE' => -11,
			'SELF' => -11,
			'SCALAR_SYMBOL' => -11,
			'OP01_NAMED_VOID' => -11,
			'LITERAL_NUMBER' => -11,
			'LITERAL_STRING' => -11,
			'HASH_REF_SYMBOL' => -11,
			'MY' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'LPAREN' => -11,
			'WORD' => -11,
			"foreach" => -11,
			"while" => -11,
			"use constant" => -11,
			'USE' => -11,
			'ARRAY_SYMBOL' => -11,
			'OP01_CLOSE' => -11
		},
		GOTOS => {
			'STAR-5' => 58,
			'Critic' => 57
		}
	},
	{#State 46
		ACTIONS => {
			'USE_RPERL_AFTER' => 60,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 59
		}
	},
	{#State 47
		ACTIONS => {
			"INIT" => 48,
			'USE' => 49
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'LBRACE' => 62
		}
	},
	{#State 49
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 63
		}
	},
	{#State 50
		ACTIONS => {
			'SUB' => 68,
			"use constant" => 65
		},
		GOTOS => {
			'Subroutine' => 67,
			'Constant' => 64,
			'PLUS-15' => 66
		}
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		DEFAULT => -49
	},
	{#State 53
		DEFAULT => -47
	},
	{#State 54
		ACTIONS => {
			'OP01_QW' => 69
		}
	},
	{#State 55
		ACTIONS => {
			";" => 70
		}
	},
	{#State 56
		DEFAULT => -23
	},
	{#State 57
		DEFAULT => -8
	},
	{#State 58
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => -13,
			"%{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'POD' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'LBRACKET' => -13,
			'OP01_OPEN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'SUB' => -13,
			"if" => -13,
			"INIT" => 48,
			'OP01_PRINT' => -13,
			'OP10_NAMED_UNARY' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED' => -13,
			"for" => -13,
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			'SELF' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'HASH_SYMBOL' => -13,
			'OP01_NAMED_VOID' => -13,
			'SCALAR_SYMBOL' => -13,
			"\@{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"undef" => -13,
			'LITERAL_NUMBER' => -13,
			'LITERAL_STRING' => -13,
			"foreach" => -13,
			'WORD' => -13,
			'LPAREN' => -13,
			"while" => -13,
			'MY' => -13,
			'HASH_REF_SYMBOL' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'USE' => 49,
			'ARRAY_SYMBOL' => -13,
			"use constant" => -13
		},
		GOTOS => {
			'Include' => 72,
			'STAR-6' => 71
		}
	},
	{#State 59
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 60
		DEFAULT => -37
	},
	{#State 61
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 75
		}
	},
	{#State 63
		ACTIONS => {
			'OP01_QW' => 76,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 77
		}
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		ACTIONS => {
			'WORD_UPPERCASE' => 78
		}
	},
	{#State 66
		ACTIONS => {
			'SUB' => 68,
			'LITERAL_NUMBER' => 80
		},
		GOTOS => {
			'Subroutine' => 79
		}
	},
	{#State 67
		DEFAULT => -35
	},
	{#State 68
		ACTIONS => {
			'WORD' => 81
		}
	},
	{#State 69
		ACTIONS => {
			";" => 82
		}
	},
	{#State 70
		DEFAULT => -43
	},
	{#State 71
		ACTIONS => {
			'OP01_OPEN' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'LBRACKET' => -15,
			'POD' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'WORD_UPPERCASE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"%{" => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			"for" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED' => -15,
			"if" => -15,
			'OP01_PRINT' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'SUB' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"\@{" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			'SCALAR_SYMBOL' => -15,
			'LBRACE' => -15,
			'SELF' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'HASH_SYMBOL' => -15,
			"use constant" => 65,
			'OP01_CLOSE' => -15,
			'ARRAY_SYMBOL' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'MY' => -15,
			'HASH_REF_SYMBOL' => -15,
			"while" => -15,
			"foreach" => -15,
			'WORD' => -15,
			'LPAREN' => -15
		},
		GOTOS => {
			'Constant' => 83,
			'STAR-7' => 84
		}
	},
	{#State 72
		DEFAULT => -10
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		ACTIONS => {
			'USE_EXPORTER' => 32,
			"INIT" => -69,
			"use constant" => -69,
			"## no critic qw(" => 8,
			"our hashref \$properties" => -69,
			'USE' => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 86,
			'Exports' => 88,
			'Critic' => 87
		}
	},
	{#State 75
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 89
		}
	},
	{#State 76
		DEFAULT => -50
	},
	{#State 77
		ACTIONS => {
			";" => 90
		}
	},
	{#State 78
		ACTIONS => {
			'OP20_HASH_FATARROW' => 91
		}
	},
	{#State 79
		DEFAULT => -34
	},
	{#State 80
		ACTIONS => {
			";" => 92
		}
	},
	{#State 81
		ACTIONS => {
			'LBRACE' => 93
		}
	},
	{#State 82
		DEFAULT => -46
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 113,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			"\@{" => 149,
			"undef" => 106,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'LPAREN' => 164,
			'WORD' => 27,
			"foreach" => -173,
			"while" => -173,
			'HASH_REF_SYMBOL' => 161,
			'MY' => 159,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'POD' => 99,
			'LBRACKET' => 132,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 94,
			'OP01_NAMED' => 148,
			'CONSTANT_CALL_SCOPED' => 147,
			"for" => -173,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 140,
			'OP22_LOGICAL_NEG' => 138,
			'SUB' => 68,
			'OP01_NAMED_VOID_SCOLON' => 143,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY' => 136,
			'OP01_PRINT' => 102,
			"if" => 101
		},
		GOTOS => {
			'Subroutine' => 151,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 111,
			'Expression' => 153,
			'ArrayReferenceVariable' => 155,
			'Operator' => 154,
			'Operation' => 114,
			'ArrayHashLiteral' => 157,
			'Conditional' => 115,
			'ArrayHashLiteralEmpty' => 156,
			'PLUS-8' => 116,
			'Array' => 158,
			'Variable' => 162,
			'OperatorVoid' => 160,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayLiteral' => 121,
			'VariableModification' => 165,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'VariableDeclaration' => 123,
			'ScalarLiteral' => 126,
			'PAREN-45' => 127,
			'HashVariable' => 95,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'OPTIONAL-46' => 98,
			'ScalarVariable' => 131,
			'SubExpression' => 134,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Statement' => 139,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'LoopLabel' => 145,
			'ArrayVariable' => 104,
			'Hash' => 146,
			'HashLiteral' => 105
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 169
		}
	},
	{#State 87
		DEFAULT => -66
	},
	{#State 88
		DEFAULT => -68
	},
	{#State 89
		ACTIONS => {
			'OP01_QW' => 170,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 171
		}
	},
	{#State 90
		DEFAULT => -54
	},
	{#State 91
		ACTIONS => {
			'MY' => 172
		},
		GOTOS => {
			'TypeInnerConstant' => 173
		}
	},
	{#State 92
		DEFAULT => -36
	},
	{#State 93
		ACTIONS => {
			'LBRACE' => 174
		}
	},
	{#State 94
		ACTIONS => {
			'LPAREN' => 175,
			'COLON' => -283
		}
	},
	{#State 95
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -269,
			'OP09_BITWISE_SHIFT' => -269,
			'OP16_LOGICAL_OR' => -269,
			'OP15_LOGICAL_AND' => -269,
			'OP12_COMPARE_EQ_NE' => -269,
			'OP17_LIST_RANGE' => -269,
			'OP24_LOGICAL_OR_XOR' => -269,
			'OP07_MATH_MULT_DIV_MOD' => -269,
			'OP19_VARIABLE_ASSIGN_BY' => -201,
			'OP08_STRING_CAT' => -269,
			")" => -269,
			'OP04_MATH_POW' => -269,
			'OP23_LOGICAL_AND' => -269,
			'OP19_VARIABLE_ASSIGN' => -201,
			'OP07_STRING_REPEAT' => -269,
			'OP06_REGEX_BIND' => -269,
			'OP13_BITWISE_AND' => -269,
			'OP08_MATH_ADD_SUB' => -269,
			'OP14_BITWISE_OR_XOR' => -269
		}
	},
	{#State 96
		DEFAULT => -162
	},
	{#State 97
		DEFAULT => -250
	},
	{#State 98
		ACTIONS => {
			"for" => 177,
			"while" => 181,
			"foreach" => 182
		},
		GOTOS => {
			'LoopForEach' => 180,
			'LoopWhile' => 178,
			'Loop' => 179,
			'LoopFor' => 176
		}
	},
	{#State 99
		DEFAULT => -179
	},
	{#State 100
		ACTIONS => {
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'SubExpression' => 184,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97
		}
	},
	{#State 101
		ACTIONS => {
			'LPAREN' => 192
		}
	},
	{#State 102
		ACTIONS => {
			'LITERAL_STRING' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'LITERAL_NUMBER' => -132,
			'OP01_OPEN' => -132,
			'LBRACKET' => -132,
			'SCALAR_SYMBOL' => -132,
			'FHREF_SYMBOL_BRACES' => 193,
			"%{" => -132,
			'HASH_SYMBOL' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'ARRAY_REF_SYMBOL' => -132,
			'SELF' => -132,
			'LBRACE' => -132,
			'WORD_UPPERCASE' => -132,
			"undef" => -132,
			"\@{" => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP01_CLOSE' => -132,
			'ARRAY_SYMBOL' => -132,
			'OP01_NAMED' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'WORD_SCOPED' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'LPAREN' => -132,
			'WORD' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'OP10_NAMED_UNARY' => -132,
			'HASH_REF_SYMBOL' => -132,
			'STDOUT_STDERR' => 196
		},
		GOTOS => {
			'PAREN-39' => 195,
			'OPTIONAL-40' => 194
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 197,
			'OP02_METHOD_THINARROW_NEW' => 198
		}
	},
	{#State 104
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -247,
			'OP14_BITWISE_OR_XOR' => -247,
			'OP13_BITWISE_AND' => -247,
			'OP07_STRING_REPEAT' => -247,
			'OP06_REGEX_BIND' => -247,
			'OP23_LOGICAL_AND' => -247,
			'OP19_VARIABLE_ASSIGN' => -199,
			'OP04_MATH_POW' => -247,
			'OP08_STRING_CAT' => -247,
			")" => -247,
			'OP19_VARIABLE_ASSIGN_BY' => -199,
			'OP07_MATH_MULT_DIV_MOD' => -247,
			'OP24_LOGICAL_OR_XOR' => -247,
			'OP17_LIST_RANGE' => -247,
			'OP12_COMPARE_EQ_NE' => -247,
			'OP16_LOGICAL_OR' => -247,
			'OP09_BITWISE_SHIFT' => -247,
			'OP15_LOGICAL_AND' => -247,
			'OP11_COMPARE_LT_GT' => -247
		}
	},
	{#State 105
		DEFAULT => -268
	},
	{#State 106
		DEFAULT => -156
	},
	{#State 107
		DEFAULT => -230
	},
	{#State 108
		ACTIONS => {
			'OP01_CLOSE' => 212,
			'OP01_NAMED' => 207,
			'OP08_MATH_ADD_SUB' => 211,
			'OP19_LOOP_CONTROL' => 206,
			'WORD' => 222,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_PRINT' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP07_STRING_REPEAT' => 219,
			'OP23_LOGICAL_AND' => 221,
			'ENV' => 210,
			'OP24_LOGICAL_OR_XOR' => 209,
			'LITERAL_STRING' => 118,
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 201,
			"}" => 202,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 217,
			'OP11_COMPARE_LT_GT' => 218,
			'SELF' => 107,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP19_LOOP_CONTROL_SCOLON' => 208
		},
		GOTOS => {
			'OpStringOrWord' => 213,
			'ScalarVariableOrSelf' => 112,
			'VarOrLitOrOpStrOrWord' => 223,
			'ScalarLiteral' => 200,
			'HashEntry' => 220,
			'ScalarVariable' => 203,
			'HashEntries' => 216
		}
	},
	{#State 109
		DEFAULT => -271
	},
	{#State 110
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107
		},
		GOTOS => {
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 224,
			'Array' => 158,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126
		}
	},
	{#State 111
		ACTIONS => {
			'OP23_LOGICAL_AND' => -273,
			'OP19_VARIABLE_ASSIGN' => -202,
			'OP06_REGEX_BIND' => -273,
			'OP07_STRING_REPEAT' => -273,
			")" => -273,
			'OP08_STRING_CAT' => -273,
			'OP04_MATH_POW' => -273,
			'OP14_BITWISE_OR_XOR' => -273,
			'OP08_MATH_ADD_SUB' => -273,
			'OP13_BITWISE_AND' => -273,
			'OP12_COMPARE_EQ_NE' => -273,
			'OP11_COMPARE_LT_GT' => -273,
			'OP15_LOGICAL_AND' => -273,
			'OP16_LOGICAL_OR' => -273,
			'OP09_BITWISE_SHIFT' => -273,
			'OP19_VARIABLE_ASSIGN_BY' => -202,
			'OP17_LIST_RANGE' => -273,
			'OP24_LOGICAL_OR_XOR' => -273,
			'OP07_MATH_MULT_DIV_MOD' => -273
		}
	},
	{#State 112
		ACTIONS => {
			'OP16_LOGICAL_OR' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			";" => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'COLON' => -226,
			'OP21_LIST_COMMA' => -226,
			'OP03_MATH_INC_DEC' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP02_ARRAY_THINARROW' => 225,
			'OP17_LIST_RANGE' => -226,
			"}" => -226,
			'OP19_VARIABLE_ASSIGN_BY' => -226,
			'OP04_MATH_POW' => -226,
			'OP08_STRING_CAT' => -226,
			")" => -226,
			'OP02_HASH_THINARROW' => 227,
			'OP07_STRING_REPEAT' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP19_VARIABLE_ASSIGN' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP18_TERNARY' => -226,
			'OP20_HASH_FATARROW' => -226,
			'OP08_MATH_ADD_SUB' => -226,
			'OP02_METHOD_THINARROW' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			"]" => -226
		},
		GOTOS => {
			'VariableRetrievalArrow' => 226
		}
	},
	{#State 113
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'SubExpression' => 228,
			'Array' => 158,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 229,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 114
		DEFAULT => -17
	},
	{#State 115
		DEFAULT => -174
	},
	{#State 116
		ACTIONS => {
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'WORD_UPPERCASE' => 94,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'POD' => 99,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_NAMED_VOID_SCOLON' => 143,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP19_LOOP_CONTROL' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'OP01_PRINT' => 102,
			"if" => 101,
			'OP01_NAMED' => 148,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			"for" => -173,
			'OP01_NAMED_VOID' => 113,
			'SCALAR_SYMBOL' => 152,
			'OP05_LOGICAL_NEG' => 110,
			'' => -18,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			"undef" => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			"while" => -173,
			'WORD' => 27,
			'LPAREN' => 164,
			"foreach" => -173,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'HASH_REF_SYMBOL' => 161,
			'MY' => 159,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168
		},
		GOTOS => {
			'Scalar' => 163,
			'HashDereference' => 120,
			'VariableModification' => 165,
			'ArrayLiteral' => 121,
			'OperatorVoid' => 160,
			'Variable' => 162,
			'VariableDeclaration' => 123,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 111,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Conditional' => 115,
			'Array' => 158,
			'Operation' => 230,
			'ArrayReferenceVariable' => 155,
			'Operator' => 154,
			'Expression' => 153,
			'ArrayReference' => 137,
			'Statement' => 139,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135,
			'Hash' => 146,
			'ArrayVariable' => 104,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'LoopLabel' => 145,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 95,
			'OPTIONAL-46' => 98,
			'ScalarLiteral' => 126,
			'PAREN-45' => 127,
			'SubExpression' => 134,
			'ScalarVariable' => 131
		}
	},
	{#State 117
		DEFAULT => -222
	},
	{#State 118
		DEFAULT => -223
	},
	{#State 119
		DEFAULT => -97
	},
	{#State 120
		DEFAULT => -165
	},
	{#State 121
		DEFAULT => -246
	},
	{#State 122
		DEFAULT => -253
	},
	{#State 123
		DEFAULT => -177
	},
	{#State 124
		ACTIONS => {
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'LBRACE' => 108,
			'SELF' => 107,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			")" => -134,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142
		},
		GOTOS => {
			'OPTIONAL-41' => 232,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 231,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 228,
			'Array' => 158,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 125
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 233
		}
	},
	{#State 126
		DEFAULT => -220
	},
	{#State 127
		DEFAULT => -172
	},
	{#State 128
		DEFAULT => -254
	},
	{#State 129
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => -278,
			'SELF' => 107,
			'HASH_REF_SYMBOL' => -278,
			'MY' => 234
		},
		GOTOS => {
			'ScalarVariable' => 235,
			'TypeInner' => 236,
			'OPTIONAL-61' => 237,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 130
		DEFAULT => -96
	},
	{#State 131
		ACTIONS => {
			'OP17_LIST_RANGE' => -221,
			'OP24_LOGICAL_OR_XOR' => -221,
			'OP07_MATH_MULT_DIV_MOD' => -221,
			'OP19_VARIABLE_ASSIGN_BY' => -198,
			'OP11_COMPARE_LT_GT' => -221,
			'OP15_LOGICAL_AND' => -221,
			'OP16_LOGICAL_OR' => -221,
			'OP09_BITWISE_SHIFT' => -221,
			'OP03_MATH_INC_DEC' => 238,
			'OP12_COMPARE_EQ_NE' => -221,
			'OP13_BITWISE_AND' => -221,
			'OP14_BITWISE_OR_XOR' => -221,
			'OP02_METHOD_THINARROW' => 239,
			'OP08_MATH_ADD_SUB' => -221,
			")" => -221,
			'OP08_STRING_CAT' => -221,
			'OP04_MATH_POW' => -221,
			'OP23_LOGICAL_AND' => -221,
			'OP19_VARIABLE_ASSIGN' => -198,
			'OP07_STRING_REPEAT' => -221,
			'OP06_REGEX_BIND' => -221
		}
	},
	{#State 132
		ACTIONS => {
			'OP01_QW' => 243,
			'MY' => 234,
			"]" => 245,
			'ARGV' => 244
		},
		GOTOS => {
			'TypeInner' => 240,
			'ListElement' => 242,
			'ListElements' => 241
		}
	},
	{#State 133
		ACTIONS => {
			'MY' => 246
		}
	},
	{#State 134
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261
		}
	},
	{#State 135
		DEFAULT => -272
	},
	{#State 136
		ACTIONS => {
			'HASH_REF_SYMBOL' => 161,
			'OP23_LOGICAL_AND' => -117,
			'OP07_STRING_REPEAT' => -117,
			'OP06_REGEX_BIND' => -117,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP04_MATH_POW' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			"]" => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP18_TERNARY' => -117,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			"\@{" => 149,
			'OP21_LIST_COMMA' => -117,
			"undef" => 106,
			'COLON' => -117,
			'LBRACE' => 108,
			'OP11_COMPARE_LT_GT' => -117,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SCALAR_SYMBOL' => 152,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			")" => -117,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP08_STRING_CAT' => -117,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP13_BITWISE_AND' => -117,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			'OP12_COMPARE_EQ_NE' => -117,
			";" => -117,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'OP15_LOGICAL_AND' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP16_LOGICAL_OR' => -117,
			"}" => -117,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP17_LIST_RANGE' => -117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP07_MATH_MULT_DIV_MOD' => -117
		},
		GOTOS => {
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'SubExpression' => 263,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126
		}
	},
	{#State 137
		DEFAULT => -161
	},
	{#State 138
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'SubExpression' => 264,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97
		}
	},
	{#State 139
		DEFAULT => -98
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 265
		},
		GOTOS => {
			'LoopLabel' => 266
		}
	},
	{#State 141
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 267,
			'Array' => 158,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 142
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106
		},
		GOTOS => {
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 268,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126
		}
	},
	{#State 143
		DEFAULT => -137
	},
	{#State 144
		DEFAULT => -275
	},
	{#State 145
		ACTIONS => {
			'COLON' => 269
		}
	},
	{#State 146
		DEFAULT => -163
	},
	{#State 147
		DEFAULT => -151
	},
	{#State 148
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'SubExpression' => 270,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 149
		ACTIONS => {
			'SELF' => 107,
			'ARRAY_REF_SYMBOL' => -256,
			'SCALAR_SYMBOL' => 152,
			'MY' => 234,
			'LBRACKET' => -256
		},
		GOTOS => {
			'ScalarVariable' => 272,
			'TypeInner' => 273,
			'OPTIONAL-57' => 271,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 150
		DEFAULT => -141
	},
	{#State 151
		DEFAULT => -14
	},
	{#State 152
		DEFAULT => -229
	},
	{#State 153
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			";" => 274,
			'OP17_LIST_RANGE' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_STRING_CAT' => -155,
			'OP04_MATH_POW' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP08_MATH_ADD_SUB' => -155
		}
	},
	{#State 154
		DEFAULT => -149
	},
	{#State 155
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -251,
			'OP09_BITWISE_SHIFT' => -251,
			'OP16_LOGICAL_OR' => -251,
			'OP15_LOGICAL_AND' => -251,
			'OP12_COMPARE_EQ_NE' => -251,
			'OP17_LIST_RANGE' => -251,
			'OP07_MATH_MULT_DIV_MOD' => -251,
			'OP24_LOGICAL_OR_XOR' => -251,
			'OP19_VARIABLE_ASSIGN_BY' => -200,
			'OP08_STRING_CAT' => -251,
			")" => -251,
			'OP04_MATH_POW' => -251,
			'OP23_LOGICAL_AND' => -251,
			'OP19_VARIABLE_ASSIGN' => -200,
			'OP06_REGEX_BIND' => -251,
			'OP07_STRING_REPEAT' => -251,
			'OP13_BITWISE_AND' => -251,
			'OP08_MATH_ADD_SUB' => -251,
			'OP14_BITWISE_OR_XOR' => -251
		}
	},
	{#State 156
		DEFAULT => -158
	},
	{#State 157
		DEFAULT => -159
	},
	{#State 158
		DEFAULT => -160
	},
	{#State 159
		ACTIONS => {
			'TYPE_INTEGER' => 277,
			'WORD' => 278,
			'WORD_SCOPED' => 276,
			'TYPE_FHREF' => 275
		},
		GOTOS => {
			'Type' => 279
		}
	},
	{#State 160
		DEFAULT => -176
	},
	{#State 161
		DEFAULT => -276
	},
	{#State 162
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 280,
			'OP19_VARIABLE_ASSIGN' => 281
		}
	},
	{#State 163
		DEFAULT => -157
	},
	{#State 164
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 287,
			'LBRACKET' => 132,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'OP12_COMPARE_EQ_NE' => 199,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 293,
			'WORD_SCOPED' => 29,
			'OP01_QW' => 243,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 291,
			")" => 292,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 206,
			'OP10_NAMED_UNARY' => 290,
			'OP01_PRINT' => 282,
			'LITERAL_STRING' => 118,
			'OP24_LOGICAL_OR_XOR' => 209,
			'ENV' => 210,
			'LITERAL_NUMBER' => 117,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 217,
			'OP11_COMPARE_LT_GT' => 218,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARGV' => 244,
			"undef" => 106,
			"\@{" => 149,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 295,
			'OP08_MATH_ADD_SUB' => 211,
			'LPAREN' => 164,
			'WORD' => 284,
			'OP07_STRING_REPEAT' => 219,
			'MY' => 234,
			'OP23_LOGICAL_AND' => 221,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'ListElements' => 294,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'VarOrLitOrOpStrOrWord' => 223,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'HashEntry' => 220,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayLiteral' => 121,
			'ScalarVariable' => 286,
			'SubExpression' => 288,
			'ScalarLiteral' => 285,
			'ArrayReferenceLiteral' => 97,
			'OpStringOrWord' => 213,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'WordScoped' => 103,
			'HashEntries' => 283,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'SubExpressions' => 289,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ListElement' => 242,
			'TypeInner' => 240
		}
	},
	{#State 165
		ACTIONS => {
			";" => 296
		}
	},
	{#State 166
		DEFAULT => -164
	},
	{#State 167
		DEFAULT => -249
	},
	{#State 168
		ACTIONS => {
			'FHREF_SYMBOL' => 297
		}
	},
	{#State 169
		ACTIONS => {
			"INIT" => 48,
			"use constant" => -73,
			'USE' => 49,
			"our hashref \$properties" => -73
		},
		GOTOS => {
			'Include' => 299,
			'STAR-31' => 298
		}
	},
	{#State 170
		DEFAULT => -52
	},
	{#State 171
		ACTIONS => {
			")" => 300
		}
	},
	{#State 172
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'WORD' => 278,
			'TYPE_INTEGER' => 277
		},
		GOTOS => {
			'Type' => 301
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'ScalarLiteral' => 302
		}
	},
	{#State 174
		ACTIONS => {
			'MY' => 303
		}
	},
	{#State 175
		ACTIONS => {
			")" => 304
		}
	},
	{#State 176
		DEFAULT => -187
	},
	{#State 177
		ACTIONS => {
			'MY' => 305,
			'LPAREN_MY' => 306
		}
	},
	{#State 178
		DEFAULT => -189
	},
	{#State 179
		DEFAULT => -175
	},
	{#State 180
		DEFAULT => -188
	},
	{#State 181
		ACTIONS => {
			'LPAREN_MY' => 308,
			'LPAREN' => 307
		}
	},
	{#State 182
		ACTIONS => {
			'MY' => 309
		}
	},
	{#State 183
		ACTIONS => {
			'OP17_LIST_RANGE' => -221,
			'OP07_MATH_MULT_DIV_MOD' => -221,
			'OP24_LOGICAL_OR_XOR' => -221,
			"}" => -221,
			'OP11_COMPARE_LT_GT' => -221,
			'OP09_BITWISE_SHIFT' => -221,
			'OP16_LOGICAL_OR' => -221,
			'OP15_LOGICAL_AND' => -221,
			'OP21_LIST_COMMA' => -221,
			'OP03_MATH_INC_DEC' => 238,
			";" => -221,
			'COLON' => -221,
			'OP12_COMPARE_EQ_NE' => -221,
			'OP13_BITWISE_AND' => -221,
			'OP08_MATH_ADD_SUB' => -221,
			'OP02_METHOD_THINARROW' => 239,
			"]" => -221,
			'OP14_BITWISE_OR_XOR' => -221,
			'OP18_TERNARY' => -221,
			'OP08_STRING_CAT' => -221,
			")" => -221,
			'OP04_MATH_POW' => -221,
			'OP23_LOGICAL_AND' => -221,
			'OP07_STRING_REPEAT' => -221,
			'OP06_REGEX_BIND' => -221
		}
	},
	{#State 184
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 247,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			")" => 310,
			'OP08_STRING_CAT' => 258,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 185
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129
		},
		GOTOS => {
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 311,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137
		}
	},
	{#State 186
		DEFAULT => -251
	},
	{#State 187
		DEFAULT => -155
	},
	{#State 188
		ACTIONS => {
			'LPAREN' => 175
		}
	},
	{#State 189
		DEFAULT => -269
	},
	{#State 190
		DEFAULT => -247
	},
	{#State 191
		DEFAULT => -273
	},
	{#State 192
		ACTIONS => {
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 312,
			'ScalarLiteral' => 126,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191
		}
	},
	{#State 193
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136
		},
		GOTOS => {
			'Array' => 158,
			'SubExpression' => 228,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarLiteral' => 126,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 313
		}
	},
	{#State 194
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 228,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 314,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 195
		DEFAULT => -131
	},
	{#State 196
		DEFAULT => -130
	},
	{#State 197
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			")" => -144,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'LBRACE' => 108,
			'SELF' => 107,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133
		},
		GOTOS => {
			'SubExpressions' => 316,
			'HashReferenceLiteral' => 135,
			'OPTIONAL-42' => 315,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'Hash' => 146,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 228
		}
	},
	{#State 198
		ACTIONS => {
			")" => -148,
			'LBRACE' => 108,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'HashReference' => 317,
			'BracesEmpty' => 144,
			'HashReferenceVariable' => 191,
			'HashReferenceLiteral' => 135,
			'OPTIONAL-44' => 318
		}
	},
	{#State 199
		DEFAULT => -305
	},
	{#State 200
		DEFAULT => -292
	},
	{#State 201
		DEFAULT => -313
	},
	{#State 202
		DEFAULT => -238
	},
	{#State 203
		DEFAULT => -291
	},
	{#State 204
		DEFAULT => -307
	},
	{#State 205
		DEFAULT => -302
	},
	{#State 206
		DEFAULT => -304
	},
	{#State 207
		DEFAULT => -311
	},
	{#State 208
		DEFAULT => -303
	},
	{#State 209
		DEFAULT => -300
	},
	{#State 210
		DEFAULT => -266
	},
	{#State 211
		DEFAULT => -308
	},
	{#State 212
		DEFAULT => -312
	},
	{#State 213
		DEFAULT => -293
	},
	{#State 214
		DEFAULT => -309
	},
	{#State 215
		DEFAULT => -315
	},
	{#State 216
		ACTIONS => {
			"}" => 319
		}
	},
	{#State 217
		DEFAULT => -314
	},
	{#State 218
		DEFAULT => -306
	},
	{#State 219
		DEFAULT => -310
	},
	{#State 220
		DEFAULT => -261,
		GOTOS => {
			'STAR-59' => 320
		}
	},
	{#State 221
		DEFAULT => -301
	},
	{#State 222
		DEFAULT => -316
	},
	{#State 223
		ACTIONS => {
			'OP20_HASH_FATARROW' => 321
		}
	},
	{#State 224
		ACTIONS => {
			'OP07_STRING_REPEAT' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => -108,
			")" => -108,
			'OP18_TERNARY' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			"]" => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP13_BITWISE_AND' => -108,
			";" => -108,
			'COLON' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			"}" => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP17_LIST_RANGE' => -108
		}
	},
	{#State 225
		ACTIONS => {
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 322,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189
		}
	},
	{#State 226
		ACTIONS => {
			'COLON' => -227,
			'OP21_LIST_COMMA' => -227,
			'LBRACE' => 327,
			'OP11_COMPARE_LT_GT' => -227,
			'OP19_VARIABLE_ASSIGN_BY' => -227,
			'OP24_LOGICAL_OR_XOR' => -227,
			'OP06_REGEX_BIND' => -227,
			'OP07_STRING_REPEAT' => -227,
			'OP02_HASH_THINARROW' => 227,
			'OP23_LOGICAL_AND' => -227,
			'OP04_MATH_POW' => -227,
			'OP18_TERNARY' => -227,
			'OP08_MATH_ADD_SUB' => -227,
			'OP14_BITWISE_OR_XOR' => -227,
			"]" => -227,
			";" => -227,
			'OP12_COMPARE_EQ_NE' => -227,
			'OP03_MATH_INC_DEC' => -227,
			'OP16_LOGICAL_OR' => -227,
			'OP09_BITWISE_SHIFT' => -227,
			'OP15_LOGICAL_AND' => -227,
			'LBRACKET' => 323,
			"}" => -227,
			'OP07_MATH_MULT_DIV_MOD' => -227,
			'OP02_ARRAY_THINARROW' => 225,
			'OP17_LIST_RANGE' => -227,
			'OP19_VARIABLE_ASSIGN' => -227,
			'OP08_STRING_CAT' => -227,
			")" => -227,
			'OP20_HASH_FATARROW' => -227,
			'OP02_METHOD_THINARROW' => -227,
			'OP13_BITWISE_AND' => -227
		},
		GOTOS => {
			'VariableRetrievalArrow' => 325,
			'VariableRetrieval' => 324,
			'PLUS-52' => 326
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD' => 328,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'SubExpression' => 329,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'HashReference' => 166,
			'ArrayVariable' => 190
		}
	},
	{#State 228
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP21_LIST_COMMA' => -234,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -234,
			'OP17_LIST_RANGE' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			")" => -234,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP13_BITWISE_AND' => 257,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249
		},
		GOTOS => {
			'STAR-54' => 330
		}
	},
	{#State 229
		ACTIONS => {
			";" => 331
		}
	},
	{#State 230
		DEFAULT => -16
	},
	{#State 231
		DEFAULT => -133
	},
	{#State 232
		ACTIONS => {
			")" => 332
		}
	},
	{#State 233
		DEFAULT => -104
	},
	{#State 234
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'TYPE_INTEGER' => 277,
			'WORD' => 278
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 235
		ACTIONS => {
			"}" => 334
		}
	},
	{#State 236
		DEFAULT => -277
	},
	{#State 237
		ACTIONS => {
			'LBRACE' => 108,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'HashReferenceLiteral' => 135,
			'HashReference' => 335,
			'BracesEmpty' => 144,
			'HashReferenceVariable' => 191
		}
	},
	{#State 238
		DEFAULT => -105
	},
	{#State 239
		ACTIONS => {
			'LPAREN' => 336
		}
	},
	{#State 240
		ACTIONS => {
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136
		},
		GOTOS => {
			'ScalarVariable' => 183,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 337,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121
		}
	},
	{#State 241
		ACTIONS => {
			"]" => 338
		}
	},
	{#State 242
		DEFAULT => -241,
		GOTOS => {
			'STAR-56' => 339
		}
	},
	{#State 243
		DEFAULT => -244
	},
	{#State 244
		DEFAULT => -245
	},
	{#State 245
		DEFAULT => -237
	},
	{#State 246
		ACTIONS => {
			'TYPE_FHREF' => 340
		}
	},
	{#State 247
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167
		},
		GOTOS => {
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 341,
			'Array' => 158,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121
		}
	},
	{#State 248
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 342,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 249
		ACTIONS => {
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 343,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97
		}
	},
	{#State 250
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 344
		}
	},
	{#State 251
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132
		},
		GOTOS => {
			'HashReferenceLiteral' => 135,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'ScalarLiteral' => 126,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 345,
			'Array' => 158
		}
	},
	{#State 252
		ACTIONS => {
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 346,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121
		}
	},
	{#State 253
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD_SCOPED' => 29,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 347,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97
		}
	},
	{#State 254
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 348,
			'Array' => 158,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 255
		ACTIONS => {
			'LBRACE' => 108,
			'SELF' => 107,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 349,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189
		}
	},
	{#State 256
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 350,
			'Array' => 158,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 257
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 351,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'HashReference' => 166,
			'ArrayVariable' => 190
		}
	},
	{#State 258
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 352,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183
		}
	},
	{#State 259
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 353,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156
		}
	},
	{#State 260
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LBRACE' => 108,
			'SELF' => 107,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106
		},
		GOTOS => {
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'SubExpression' => 354,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135
		}
	},
	{#State 261
		ACTIONS => {
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168
		},
		GOTOS => {
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'ScalarLiteral' => 126,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 355
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 356,
			'Array' => 158,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'Hash' => 146,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'HashLiteral' => 105
		}
	},
	{#State 263
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => -116,
			"}" => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => -116,
			'COLON' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			";" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			"]" => -116,
			'OP08_MATH_ADD_SUB' => 249,
			'OP04_MATH_POW' => 251,
			")" => -116,
			'OP08_STRING_CAT' => 258,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => -116
		}
	},
	{#State 264
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			"}" => -127,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259,
			'COLON' => -127,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -127,
			'OP21_LIST_COMMA' => -127,
			'OP13_BITWISE_AND' => 257,
			'OP18_TERNARY' => -127,
			'OP14_BITWISE_OR_XOR' => 260,
			"]" => -127,
			'OP08_MATH_ADD_SUB' => 249,
			'OP04_MATH_POW' => 251,
			")" => -127,
			'OP08_STRING_CAT' => 258,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => -127
		}
	},
	{#State 265
		DEFAULT => -283
	},
	{#State 266
		ACTIONS => {
			";" => 357
		}
	},
	{#State 267
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP04_MATH_POW' => 251,
			")" => 358,
			'OP08_STRING_CAT' => 258,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261
		}
	},
	{#State 268
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			")" => 359,
			'OP08_STRING_CAT' => 258,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP11_COMPARE_LT_GT' => 259
		}
	},
	{#State 269
		DEFAULT => -171
	},
	{#State 270
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			";" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => 360,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP04_MATH_POW' => -100,
			'OP08_STRING_CAT' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP14_BITWISE_OR_XOR' => -100
		}
	},
	{#State 271
		ACTIONS => {
			'LBRACKET' => 132,
			'ARRAY_REF_SYMBOL' => 128
		},
		GOTOS => {
			'ArrayReference' => 361,
			'ArrayReferenceLiteral' => 97,
			'ArrayReferenceVariable' => 186,
			'BracketsEmpty' => 122
		}
	},
	{#State 272
		ACTIONS => {
			"}" => 362
		}
	},
	{#State 273
		DEFAULT => -255
	},
	{#State 274
		DEFAULT => -95
	},
	{#State 275
		ACTIONS => {
			'FHREF_SYMBOL' => 363
		}
	},
	{#State 276
		DEFAULT => -285
	},
	{#State 277
		DEFAULT => -286
	},
	{#State 278
		DEFAULT => -284
	},
	{#State 279
		ACTIONS => {
			'ARRAY_SYMBOL' => 366,
			'SCALAR_SYMBOL' => 365,
			'HASH_SYMBOL' => 364
		}
	},
	{#State 280
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 367,
			'Array' => 158,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 281
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 142,
			'FHREF_SYMBOL_IN' => 368,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'STDIN' => 370,
			'LBRACKET' => 132
		},
		GOTOS => {
			'HashLiteral' => 105,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'SubExpression' => 369,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'SubExpressionOrInput' => 371
		}
	},
	{#State 282
		ACTIONS => {
			'OP20_HASH_FATARROW' => -315,
			'FHREF_SYMBOL_BRACES' => 372
		}
	},
	{#State 283
		ACTIONS => {
			")" => 373
		}
	},
	{#State 284
		ACTIONS => {
			'LPAREN' => -281,
			'OP20_HASH_FATARROW' => -316,
			'OP02_METHOD_THINARROW_NEW' => -281
		}
	},
	{#State 285
		ACTIONS => {
			'OP08_STRING_CAT' => -220,
			")" => -220,
			'OP04_MATH_POW' => -220,
			'OP23_LOGICAL_AND' => -220,
			'OP06_REGEX_BIND' => -220,
			'OP07_STRING_REPEAT' => -220,
			'OP13_BITWISE_AND' => -220,
			'OP08_MATH_ADD_SUB' => -220,
			'OP14_BITWISE_OR_XOR' => -220,
			'OP18_TERNARY' => -220,
			'OP20_HASH_FATARROW' => -292,
			'OP11_COMPARE_LT_GT' => -220,
			'OP09_BITWISE_SHIFT' => -220,
			'OP16_LOGICAL_OR' => -220,
			'OP15_LOGICAL_AND' => -220,
			'OP21_LIST_COMMA' => -220,
			'OP12_COMPARE_EQ_NE' => -220,
			'OP17_LIST_RANGE' => -220,
			'OP07_MATH_MULT_DIV_MOD' => -220,
			'OP24_LOGICAL_OR_XOR' => -220
		}
	},
	{#State 286
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -221,
			'OP24_LOGICAL_OR_XOR' => -221,
			'OP17_LIST_RANGE' => -221,
			'OP12_COMPARE_EQ_NE' => -221,
			'OP21_LIST_COMMA' => -221,
			'OP03_MATH_INC_DEC' => 238,
			'OP16_LOGICAL_OR' => -221,
			'OP09_BITWISE_SHIFT' => -221,
			'OP15_LOGICAL_AND' => -221,
			'OP11_COMPARE_LT_GT' => -221,
			'OP18_TERNARY' => -221,
			'OP20_HASH_FATARROW' => -291,
			'OP02_METHOD_THINARROW' => 239,
			'OP08_MATH_ADD_SUB' => -221,
			'OP14_BITWISE_OR_XOR' => -221,
			'OP13_BITWISE_AND' => -221,
			'OP06_REGEX_BIND' => -221,
			'OP07_STRING_REPEAT' => -221,
			'OP23_LOGICAL_AND' => -221,
			'OP04_MATH_POW' => -221,
			'OP08_STRING_CAT' => -221,
			")" => -221
		}
	},
	{#State 287
		ACTIONS => {
			'OP20_HASH_FATARROW' => -313,
			'MY' => 246
		}
	},
	{#State 288
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP21_LIST_COMMA' => -234,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			'OP18_TERNARY' => 374,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			")" => -234
		},
		GOTOS => {
			'STAR-54' => 330
		}
	},
	{#State 289
		ACTIONS => {
			")" => 375
		}
	},
	{#State 290
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP08_STRING_CAT' => -117,
			'OP22_LOGICAL_NEG' => 138,
			")" => -117,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP20_HASH_FATARROW' => -307,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP13_BITWISE_AND' => -117,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			'OP12_COMPARE_EQ_NE' => -117,
			'ARRAY_REF_SYMBOL' => 128,
			'OP09_BITWISE_SHIFT' => -117,
			'OP16_LOGICAL_OR' => -117,
			"%{" => 129,
			'OP15_LOGICAL_AND' => -117,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP17_LIST_RANGE' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP23_LOGICAL_AND' => -117,
			'HASH_REF_SYMBOL' => 161,
			'OP07_STRING_REPEAT' => -117,
			'OP06_REGEX_BIND' => -117,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP04_MATH_POW' => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP18_TERNARY' => -117,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP21_LIST_COMMA' => -117,
			"\@{" => 149,
			"undef" => 106,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'OP11_COMPARE_LT_GT' => -117,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			'LITERAL_NUMBER' => 117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'LITERAL_STRING' => 118
		},
		GOTOS => {
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 263,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163
		}
	},
	{#State 291
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'OP20_HASH_FATARROW' => -302,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 264,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135
		}
	},
	{#State 292
		DEFAULT => -236
	},
	{#State 293
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'LBRACE' => 108,
			'SELF' => 107,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP20_HASH_FATARROW' => -311,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 376,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ScalarVariable' => 183
		}
	},
	{#State 294
		ACTIONS => {
			")" => 377
		}
	},
	{#State 295
		ACTIONS => {
			'FHREF_SYMBOL' => 297,
			'OP20_HASH_FATARROW' => -312
		}
	},
	{#State 296
		DEFAULT => -178
	},
	{#State 297
		DEFAULT => -103
	},
	{#State 298
		ACTIONS => {
			"our hashref \$properties" => 380,
			"use constant" => 65
		},
		GOTOS => {
			'Constant' => 379,
			'Properties' => 378
		}
	},
	{#State 299
		DEFAULT => -70
	},
	{#State 300
		ACTIONS => {
			";" => 381
		}
	},
	{#State 301
		ACTIONS => {
			"\$TYPED_" => 382
		}
	},
	{#State 302
		ACTIONS => {
			";" => 383
		}
	},
	{#State 303
		ACTIONS => {
			'TYPE_INTEGER' => 277,
			'WORD' => 278,
			'WORD_SCOPED' => 276
		},
		GOTOS => {
			'Type' => 384
		}
	},
	{#State 304
		DEFAULT => -150
	},
	{#State 305
		ACTIONS => {
			'TYPE_INTEGER' => 385
		}
	},
	{#State 306
		ACTIONS => {
			'TYPE_INTEGER' => 386
		}
	},
	{#State 307
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168
		},
		GOTOS => {
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 387,
			'Array' => 158,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121
		}
	},
	{#State 308
		ACTIONS => {
			'TYPE_INTEGER' => 277,
			'WORD' => 278,
			'WORD_SCOPED' => 276
		},
		GOTOS => {
			'Type' => 388
		}
	},
	{#State 309
		ACTIONS => {
			'WORD' => 278,
			'TYPE_INTEGER' => 277,
			'WORD_SCOPED' => 276
		},
		GOTOS => {
			'Type' => 389
		}
	},
	{#State 310
		DEFAULT => -126
	},
	{#State 311
		ACTIONS => {
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_STRING_REPEAT' => -100,
			")" => -100,
			'OP08_STRING_CAT' => -100,
			'OP04_MATH_POW' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'COLON' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			";" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP16_LOGICAL_OR' => -100,
			"}" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 312
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			")" => 390,
			'OP08_STRING_CAT' => 258,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP11_COMPARE_LT_GT' => 259
		}
	},
	{#State 313
		ACTIONS => {
			";" => 391
		}
	},
	{#State 314
		ACTIONS => {
			";" => 392
		}
	},
	{#State 315
		ACTIONS => {
			")" => 393
		}
	},
	{#State 316
		DEFAULT => -143
	},
	{#State 317
		DEFAULT => -147
	},
	{#State 318
		ACTIONS => {
			")" => 394
		}
	},
	{#State 319
		DEFAULT => -274
	},
	{#State 320
		ACTIONS => {
			")" => -262,
			'OP21_LIST_COMMA' => 395,
			"}" => -262
		},
		GOTOS => {
			'PAREN-58' => 396
		}
	},
	{#State 321
		ACTIONS => {
			'HASH_REF_SYMBOL' => -264,
			'MY' => 234,
			'OP10_NAMED_UNARY' => -264,
			'OP05_BITWISE_NEG_LPAREN' => -264,
			'WORD' => -264,
			'LPAREN' => -264,
			'OP22_LOGICAL_NEG' => -264,
			'OP05_MATH_NEG_LPAREN' => -264,
			'WORD_SCOPED' => -264,
			'OP01_NAMED' => -264,
			'CONSTANT_CALL_SCOPED' => -264,
			'OP01_CLOSE' => -264,
			'ARRAY_SYMBOL' => -264,
			'OP03_MATH_INC_DEC' => -264,
			"\@{" => -264,
			"undef" => -264,
			'WORD_UPPERCASE' => -264,
			'HASH_SYMBOL' => -264,
			'ARRAY_REF_SYMBOL' => -264,
			'OP05_LOGICAL_NEG' => -264,
			'SELF' => -264,
			'LBRACE' => -264,
			'SCALAR_SYMBOL' => -264,
			"%{" => -264,
			'LBRACKET' => -264,
			'OP01_OPEN' => -264,
			'LITERAL_NUMBER' => -264,
			'OP22_LOGICAL_NEG_LPAREN' => -264,
			'LITERAL_STRING' => -264
		},
		GOTOS => {
			'TypeInner' => 398,
			'OPTIONAL-60' => 397
		}
	},
	{#State 322
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP17_LIST_RANGE' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP13_BITWISE_AND' => 257,
			"]" => 399,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249
		}
	},
	{#State 323
		ACTIONS => {
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'LBRACE' => 108,
			'SELF' => 107,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 400,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126,
			'Hash' => 146,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135
		}
	},
	{#State 324
		DEFAULT => -225
	},
	{#State 325
		DEFAULT => -206
	},
	{#State 326
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -228,
			'OP14_BITWISE_OR_XOR' => -228,
			"]" => -228,
			'OP18_TERNARY' => -228,
			'OP23_LOGICAL_AND' => -228,
			'OP02_HASH_THINARROW' => 227,
			'OP07_STRING_REPEAT' => -228,
			'OP06_REGEX_BIND' => -228,
			'OP04_MATH_POW' => -228,
			'OP19_VARIABLE_ASSIGN_BY' => -228,
			'OP24_LOGICAL_OR_XOR' => -228,
			'OP21_LIST_COMMA' => -228,
			'COLON' => -228,
			'OP11_COMPARE_LT_GT' => -228,
			'LBRACE' => 327,
			'OP02_METHOD_THINARROW' => -228,
			'OP20_HASH_FATARROW' => -228,
			'OP13_BITWISE_AND' => -228,
			'OP19_VARIABLE_ASSIGN' => -228,
			'OP08_STRING_CAT' => -228,
			")" => -228,
			'LBRACKET' => 323,
			"}" => -228,
			'OP02_ARRAY_THINARROW' => 225,
			'OP17_LIST_RANGE' => -228,
			'OP07_MATH_MULT_DIV_MOD' => -228,
			'OP03_MATH_INC_DEC' => -228,
			";" => -228,
			'OP12_COMPARE_EQ_NE' => -228,
			'OP09_BITWISE_SHIFT' => -228,
			'OP16_LOGICAL_OR' => -228,
			'OP15_LOGICAL_AND' => -228
		},
		GOTOS => {
			'VariableRetrieval' => 401,
			'VariableRetrievalArrow' => 325
		}
	},
	{#State 327
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'WORD' => 403,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'SubExpression' => 402,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137
		}
	},
	{#State 328
		ACTIONS => {
			'LPAREN' => -281,
			'OP02_METHOD_THINARROW_NEW' => -281,
			"}" => 404
		}
	},
	{#State 329
		ACTIONS => {
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			"}" => 405,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253
		}
	},
	{#State 330
		ACTIONS => {
			'OP21_LIST_COMMA' => 407,
			";" => -235,
			")" => -235
		},
		GOTOS => {
			'PAREN-53' => 406
		}
	},
	{#State 331
		DEFAULT => -139
	},
	{#State 332
		ACTIONS => {
			";" => 408
		}
	},
	{#State 333
		ACTIONS => {
			"\$TYPED_" => 409
		}
	},
	{#State 334
		DEFAULT => -279
	},
	{#State 335
		ACTIONS => {
			"}" => 410
		}
	},
	{#State 336
		ACTIONS => {
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			")" => -146,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125
		},
		GOTOS => {
			'OPTIONAL-43' => 412,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'SubExpression' => 228,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 411,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166
		}
	},
	{#State 337
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP21_LIST_COMMA' => -243,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP11_COMPARE_LT_GT' => 259,
			"]" => -243,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			")" => -243,
			'OP08_STRING_CAT' => 258
		}
	},
	{#State 338
		DEFAULT => -252
	},
	{#State 339
		ACTIONS => {
			'OP21_LIST_COMMA' => 414,
			"]" => -242,
			")" => -242
		},
		GOTOS => {
			'PAREN-55' => 413
		}
	},
	{#State 340
		ACTIONS => {
			'FHREF_SYMBOL' => 415
		}
	},
	{#State 341
		ACTIONS => {
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => -119,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => -119,
			'OP04_MATH_POW' => 251,
			")" => -119,
			'OP08_STRING_CAT' => 258,
			"}" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			'COLON' => -119,
			";" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259
		}
	},
	{#State 342
		ACTIONS => {
			'OP21_LIST_COMMA' => -129,
			'COLON' => -129,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -129,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			"}" => -129,
			'OP17_LIST_RANGE' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			")" => -129,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP14_BITWISE_OR_XOR' => 260,
			"]" => -129,
			'OP08_MATH_ADD_SUB' => 249,
			'OP18_TERNARY' => -129,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 343
		ACTIONS => {
			'OP21_LIST_COMMA' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'COLON' => -113,
			";" => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP16_LOGICAL_OR' => -113,
			"}" => -113,
			'OP17_LIST_RANGE' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP23_LOGICAL_AND' => -113,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			")" => -113,
			'OP08_STRING_CAT' => -113,
			'OP04_MATH_POW' => 251,
			'OP14_BITWISE_OR_XOR' => -113,
			"]" => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP18_TERNARY' => -113,
			'OP13_BITWISE_AND' => -113
		}
	},
	{#State 344
		DEFAULT => -110
	},
	{#State 345
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP21_LIST_COMMA' => -106,
			";" => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'COLON' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			"}" => -106,
			'OP08_STRING_CAT' => -106,
			")" => -106,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP18_TERNARY' => -106
		}
	},
	{#State 346
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			"}" => -124,
			'OP11_COMPARE_LT_GT' => 259,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP21_LIST_COMMA' => -124,
			";" => -124,
			'COLON' => -124,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			"]" => -124,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP18_TERNARY' => -124,
			'OP08_STRING_CAT' => 258,
			")" => -124,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -124,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262
		}
	},
	{#State 347
		ACTIONS => {
			'OP17_LIST_RANGE' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			"}" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP21_LIST_COMMA' => -112,
			'COLON' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			";" => -112,
			'OP13_BITWISE_AND' => -112,
			"]" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP18_TERNARY' => -112,
			")" => -112,
			'OP08_STRING_CAT' => -112,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -112,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262
		}
	},
	{#State 348
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 247,
			'COLON' => -122,
			";" => -122,
			'OP21_LIST_COMMA' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => -122,
			'OP11_COMPARE_LT_GT' => 259,
			"}" => -122,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP17_LIST_RANGE' => -122,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => -122,
			'OP04_MATH_POW' => 251,
			")" => -122,
			'OP08_STRING_CAT' => 258,
			'OP18_TERNARY' => -122,
			"]" => -122,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 349
		ACTIONS => {
			'OP04_MATH_POW' => 251,
			")" => -123,
			'OP08_STRING_CAT' => 258,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => -123,
			'OP13_BITWISE_AND' => 257,
			'OP18_TERNARY' => -123,
			'OP14_BITWISE_OR_XOR' => 260,
			"]" => -123,
			'OP08_MATH_ADD_SUB' => 249,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => -123,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259,
			'OP12_COMPARE_EQ_NE' => 247,
			'COLON' => -123,
			";" => -123,
			'OP21_LIST_COMMA' => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => -123,
			"}" => -123
		}
	},
	{#State 350
		ACTIONS => {
			'OP21_LIST_COMMA' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'COLON' => -115,
			";" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP16_LOGICAL_OR' => -115,
			"}" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			")" => -115,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP14_BITWISE_OR_XOR' => -115,
			"]" => -115,
			'OP08_MATH_ADD_SUB' => 249,
			'OP18_TERNARY' => -115,
			'OP13_BITWISE_AND' => -115
		}
	},
	{#State 351
		ACTIONS => {
			'OP18_TERNARY' => -120,
			"]" => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => -120,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => -120,
			'OP04_MATH_POW' => 251,
			")" => -120,
			'OP08_STRING_CAT' => 258,
			"}" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP17_LIST_RANGE' => -120,
			'COLON' => -120,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => -120,
			'OP11_COMPARE_LT_GT' => 259
		}
	},
	{#State 352
		ACTIONS => {
			'OP08_STRING_CAT' => -114,
			")" => -114,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -114,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP13_BITWISE_AND' => -114,
			'OP08_MATH_ADD_SUB' => 249,
			"]" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP18_TERNARY' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			";" => -114,
			'COLON' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			"}" => -114
		}
	},
	{#State 353
		ACTIONS => {
			'OP15_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -118,
			'COLON' => -118,
			";" => -118,
			'OP21_LIST_COMMA' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP17_LIST_RANGE' => -118,
			"}" => -118,
			'OP04_MATH_POW' => 251,
			")" => -118,
			'OP08_STRING_CAT' => 258,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => -118,
			'OP13_BITWISE_AND' => -118,
			'OP18_TERNARY' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			"]" => -118,
			'OP08_MATH_ADD_SUB' => 249
		}
	},
	{#State 354
		ACTIONS => {
			'OP13_BITWISE_AND' => 257,
			"]" => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP08_MATH_ADD_SUB' => 249,
			'OP18_TERNARY' => -121,
			")" => -121,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -121,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP17_LIST_RANGE' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			"}" => -121,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP09_BITWISE_SHIFT' => 256,
			'OP21_LIST_COMMA' => -121,
			'COLON' => -121,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -121
		}
	},
	{#State 355
		ACTIONS => {
			'OP17_LIST_RANGE' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -128,
			"}" => -128,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP21_LIST_COMMA' => -128,
			'COLON' => -128,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -128,
			'OP13_BITWISE_AND' => 257,
			"]" => -128,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP18_TERNARY' => -128,
			")" => -128,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => -128,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250
		}
	},
	{#State 356
		ACTIONS => {
			'OP18_TERNARY' => -111,
			"]" => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP04_MATH_POW' => 251,
			")" => -111,
			'OP08_STRING_CAT' => -111,
			"}" => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'COLON' => -111,
			";" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP11_COMPARE_LT_GT' => -111
		}
	},
	{#State 357
		DEFAULT => -142
	},
	{#State 358
		DEFAULT => -107
	},
	{#State 359
		DEFAULT => -109
	},
	{#State 360
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD_SCOPED' => 29,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117
		},
		GOTOS => {
			'SubExpressions' => 416,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'SubExpression' => 228
		}
	},
	{#State 361
		ACTIONS => {
			"}" => 417
		}
	},
	{#State 362
		DEFAULT => -257
	},
	{#State 363
		ACTIONS => {
			";" => 418
		}
	},
	{#State 364
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420,
			";" => 419
		}
	},
	{#State 365
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 423,
			'OP19_VARIABLE_ASSIGN' => 421,
			";" => 422
		}
	},
	{#State 366
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 424,
			";" => 425
		}
	},
	{#State 367
		ACTIONS => {
			'OP13_BITWISE_AND' => 257,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			")" => -219,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -219
		}
	},
	{#State 368
		DEFAULT => -167
	},
	{#State 369
		ACTIONS => {
			'OP13_BITWISE_AND' => 257,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			")" => -166,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP17_LIST_RANGE' => 252,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP12_COMPARE_EQ_NE' => 247,
			";" => -166
		}
	},
	{#State 370
		DEFAULT => -168
	},
	{#State 371
		DEFAULT => -218
	},
	{#State 372
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'Array' => 158,
			'SubExpression' => 228,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpressions' => 426,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166
		}
	},
	{#State 373
		DEFAULT => -270
	},
	{#State 374
		ACTIONS => {
			'LBRACE' => 108,
			'SELF' => 107,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ScalarLiteral' => 126,
			'SubExpression' => 427,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 375
		DEFAULT => -231
	},
	{#State 376
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100
		}
	},
	{#State 377
		DEFAULT => -248
	},
	{#State 378
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 429
		}
	},
	{#State 379
		DEFAULT => -72
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 430
		}
	},
	{#State 381
		ACTIONS => {
			"}" => 431
		}
	},
	{#State 382
		ACTIONS => {
			'WORD_UPPERCASE' => 432
		}
	},
	{#State 383
		DEFAULT => -56
	},
	{#State 384
		ACTIONS => {
			"\$RETURN_TYPE" => 433
		}
	},
	{#State 385
		ACTIONS => {
			'SCALAR_SYMBOL' => 434
		}
	},
	{#State 386
		ACTIONS => {
			'SCALAR_SYMBOL' => 435
		}
	},
	{#State 387
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			")" => 436,
			'OP08_STRING_CAT' => 258
		}
	},
	{#State 388
		ACTIONS => {
			'SCALAR_SYMBOL' => 437
		}
	},
	{#State 389
		ACTIONS => {
			'SCALAR_SYMBOL' => 438
		}
	},
	{#State 390
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 439
		}
	},
	{#State 391
		DEFAULT => -136
	},
	{#State 392
		DEFAULT => -135
	},
	{#State 393
		DEFAULT => -152
	},
	{#State 394
		DEFAULT => -154
	},
	{#State 395
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 206,
			'WORD' => 222,
			'OP22_LOGICAL_NEG' => 205,
			'OP10_NAMED_UNARY' => 204,
			'OP01_PRINT' => 215,
			'OP07_STRING_REPEAT' => 219,
			'OP23_LOGICAL_AND' => 221,
			'OP01_CLOSE' => 212,
			'OP01_NAMED' => 207,
			'OP08_MATH_ADD_SUB' => 211,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 217,
			'SELF' => 107,
			'OP11_COMPARE_LT_GT' => 218,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'ENV' => 210,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 201
		},
		GOTOS => {
			'OpStringOrWord' => 213,
			'ScalarVariableOrSelf' => 112,
			'HashEntry' => 441,
			'ScalarLiteral' => 200,
			'VarOrLitOrOpStrOrWord' => 223,
			'ScalarVariable' => 203
		}
	},
	{#State 396
		DEFAULT => -260
	},
	{#State 397
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'Array' => 158,
			'SubExpression' => 442,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'HashReferenceLiteral' => 135
		}
	},
	{#State 398
		DEFAULT => -263
	},
	{#State 399
		DEFAULT => -203
	},
	{#State 400
		ACTIONS => {
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP11_COMPARE_LT_GT' => 259,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			"]" => 443,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250
		}
	},
	{#State 401
		DEFAULT => -224
	},
	{#State 402
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			"}" => 444,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => 261,
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260
		}
	},
	{#State 403
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -281,
			"}" => 445,
			'LPAREN' => -281
		}
	},
	{#State 404
		DEFAULT => -205
	},
	{#State 405
		DEFAULT => -204
	},
	{#State 406
		DEFAULT => -233
	},
	{#State 407
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128
		},
		GOTOS => {
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarLiteral' => 126,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 446,
			'Array' => 158,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 408
		DEFAULT => -138
	},
	{#State 409
		ACTIONS => {
			'OP01_OPEN' => 201,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP11_COMPARE_LT_GT' => 218,
			'OP01_NAMED_VOID' => 217,
			'OP08_MATH_ADD_SUB' => 211,
			'OP01_NAMED' => 207,
			'OP01_CLOSE' => 212,
			'OP23_LOGICAL_AND' => 221,
			'OP07_STRING_REPEAT' => 219,
			'OP01_PRINT' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP22_LOGICAL_NEG' => 205,
			'OP19_LOOP_CONTROL' => 206,
			'WORD' => 222
		},
		GOTOS => {
			'OpStringOrWord' => 447
		}
	},
	{#State 410
		DEFAULT => -280
	},
	{#State 411
		DEFAULT => -145
	},
	{#State 412
		ACTIONS => {
			")" => 448
		}
	},
	{#State 413
		DEFAULT => -240
	},
	{#State 414
		ACTIONS => {
			'MY' => 234,
			'OP01_QW' => 243,
			'ARGV' => 244
		},
		GOTOS => {
			'ListElement' => 449,
			'TypeInner' => 240
		}
	},
	{#State 415
		ACTIONS => {
			'OP21_LIST_COMMA' => 450
		}
	},
	{#State 416
		ACTIONS => {
			";" => 451
		}
	},
	{#State 417
		DEFAULT => -258
	},
	{#State 418
		DEFAULT => -217
	},
	{#State 419
		DEFAULT => -215
	},
	{#State 420
		ACTIONS => {
			'STDIN' => 370,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			"\@{" => 149,
			"undef" => 106,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SCALAR_SYMBOL' => 152,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY_SCOLON' => 455,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP01_NAMED_SCOLON' => 453,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP10_NAMED_UNARY' => 136,
			'FHREF_SYMBOL_IN' => 368,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'SubExpressionOrInput' => 452,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 369,
			'Array' => 158,
			'HashReferenceLiteral' => 135,
			'OpNamedScolonOrSubExpIn' => 454,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashLiteral' => 105
		}
	},
	{#State 421
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'FHREF_SYMBOL_IN' => 368,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'OP01_NAMED_SCOLON' => 453,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP10_NAMED_UNARY_SCOLON' => 455,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'STDIN' => 370,
			'SCALAR_SYMBOL' => 152,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			"undef" => 106,
			"\@{" => 149
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 369,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'SubExpressionOrInput' => 452,
			'ScalarLiteral' => 126,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'OpNamedScolonOrSubExpIn' => 456
		}
	},
	{#State 422
		DEFAULT => -210
	},
	{#State 423
		ACTIONS => {
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 457,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 424
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'WORD' => 27,
			'LPAREN' => 164,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY_SCOLON' => 455,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'STDIN' => 370,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SCALAR_SYMBOL' => 152,
			"\@{" => 149,
			"undef" => 106,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'FHREF_SYMBOL_IN' => 368,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_NAMED_SCOLON' => 453,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188
		},
		GOTOS => {
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 369,
			'Array' => 158,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'SubExpressionOrInput' => 452,
			'ScalarLiteral' => 126,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135,
			'OpNamedScolonOrSubExpIn' => 458
		}
	},
	{#State 425
		DEFAULT => -213
	},
	{#State 426
		ACTIONS => {
			")" => 459
		}
	},
	{#State 427
		ACTIONS => {
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'COLON' => 460,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262
		}
	},
	{#State 428
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'SubExpression' => 228,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'SubExpressions' => 461,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 429
		ACTIONS => {
			'LITERAL_NUMBER' => 466,
			'SUB' => 462
		},
		GOTOS => {
			'Method' => 463,
			'Subroutine' => 465,
			'SubroutineOrMethod' => 464
		}
	},
	{#State 430
		ACTIONS => {
			'LBRACE' => 467
		}
	},
	{#State 431
		DEFAULT => -55
	},
	{#State 432
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 468
		}
	},
	{#State 433
		ACTIONS => {
			"}" => 469
		}
	},
	{#State 434
		ACTIONS => {
			'LPAREN' => 470
		}
	},
	{#State 435
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 471
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 437
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 473
		}
	},
	{#State 438
		ACTIONS => {
			'LPAREN' => 474
		}
	},
	{#State 439
		DEFAULT => -182,
		GOTOS => {
			'STAR-48' => 475
		}
	},
	{#State 440
		ACTIONS => {
			'WORD_SCOPED' => 29,
			"for" => -173,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 148,
			"if" => 101,
			'OP10_NAMED_UNARY' => 136,
			'OP01_PRINT' => 102,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP01_NAMED_VOID_SCOLON' => 143,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 140,
			'OP01_OPEN' => 133,
			'OP01_NAMED_SCOLON' => 130,
			'LBRACKET' => 132,
			'POD' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'WORD_UPPERCASE' => 94,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_NAMED_VOID_LPAREN' => 124,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'MY' => 159,
			'HASH_REF_SYMBOL' => 161,
			"while" => -173,
			"foreach" => -173,
			'WORD' => 27,
			'LPAREN' => 164,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			"undef" => 106,
			"\@{" => 149,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 113,
			'SELF' => 107,
			'LBRACE' => 108,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'PAREN-45' => 127,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 95,
			'OPTIONAL-46' => 98,
			'ScalarVariable' => 131,
			'SubExpression' => 134,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Statement' => 139,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'LoopLabel' => 145,
			'Hash' => 146,
			'ArrayVariable' => 104,
			'HashLiteral' => 105,
			'HashReferenceVariable' => 111,
			'ScalarVariableOrSelf' => 112,
			'Operation' => 477,
			'ArrayReferenceVariable' => 155,
			'Operator' => 154,
			'Expression' => 153,
			'ArrayHashLiteralEmpty' => 156,
			'Conditional' => 115,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'PLUS-51' => 476,
			'OperatorVoid' => 160,
			'Variable' => 162,
			'Scalar' => 163,
			'HashDereference' => 120,
			'VariableModification' => 165,
			'ArrayLiteral' => 121,
			'BracketsEmpty' => 122,
			'VariableDeclaration' => 123,
			'HashReference' => 166
		}
	},
	{#State 441
		DEFAULT => -259
	},
	{#State 442
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257,
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP08_STRING_CAT' => 258,
			")" => -265,
			'OP04_MATH_POW' => 251,
			"}" => -265,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP21_LIST_COMMA' => -265,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP15_LOGICAL_AND' => 254
		}
	},
	{#State 443
		DEFAULT => -207
	},
	{#State 444
		DEFAULT => -208
	},
	{#State 445
		DEFAULT => -209
	},
	{#State 446
		ACTIONS => {
			";" => -232,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP21_LIST_COMMA' => -232,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			")" => -232,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 478
		}
	},
	{#State 448
		DEFAULT => -153
	},
	{#State 449
		DEFAULT => -239
	},
	{#State 450
		ACTIONS => {
			'LITERAL_STRING' => 479
		}
	},
	{#State 451
		DEFAULT => -140
	},
	{#State 452
		ACTIONS => {
			";" => 480
		}
	},
	{#State 453
		DEFAULT => -297
	},
	{#State 454
		DEFAULT => -216
	},
	{#State 455
		DEFAULT => -298
	},
	{#State 456
		DEFAULT => -211
	},
	{#State 457
		ACTIONS => {
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			"]" => 481,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253
		}
	},
	{#State 458
		DEFAULT => -214
	},
	{#State 459
		DEFAULT => -99
	},
	{#State 460
		ACTIONS => {
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'SELF' => 107,
			'LBRACE' => 108,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118
		},
		GOTOS => {
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'SubExpression' => 482,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122
		}
	},
	{#State 461
		ACTIONS => {
			")" => 483
		}
	},
	{#State 462
		ACTIONS => {
			'WORD' => 484
		}
	},
	{#State 463
		DEFAULT => -94
	},
	{#State 464
		DEFAULT => -74
	},
	{#State 465
		DEFAULT => -93
	},
	{#State 466
		ACTIONS => {
			";" => 485
		}
	},
	{#State 467
		ACTIONS => {
			'OP23_LOGICAL_AND' => 221,
			'OP10_NAMED_UNARY' => 204,
			'OP01_PRINT' => 215,
			'OP07_STRING_REPEAT' => 219,
			'OP19_LOOP_CONTROL' => 206,
			'WORD' => 222,
			'OP22_LOGICAL_NEG' => 205,
			'OP08_MATH_ADD_SUB' => 211,
			'OP01_NAMED' => 207,
			'OP01_CLOSE' => 212,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP11_COMPARE_LT_GT' => 218,
			'OP01_NAMED_VOID' => 217,
			"}" => 487,
			'OP01_OPEN' => 201,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP07_MATH_MULT_DIV_MOD' => 214
		},
		GOTOS => {
			'HashEntryProperties' => 488,
			'OpStringOrWord' => 486
		}
	},
	{#State 468
		DEFAULT => -290
	},
	{#State 469
		ACTIONS => {
			";" => 489
		}
	},
	{#State 470
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132
		},
		GOTOS => {
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashReferenceLiteral' => 135,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'SubExpression' => 490,
			'Array' => 158,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'ScalarLiteral' => 126,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 189
		}
	},
	{#State 471
		ACTIONS => {
			'OP01_OPEN' => 133,
			'OP01_NAMED_SCOLON' => 491,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'OP10_NAMED_UNARY_SCOLON' => 493,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 492,
			'OpNamedScolonOrSubExp' => 494,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 472
		DEFAULT => -193
	},
	{#State 473
		ACTIONS => {
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'OP01_OPEN' => 133,
			'STDIN' => 370,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'FHREF_SYMBOL_IN' => 368,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185
		},
		GOTOS => {
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 369,
			'SubExpressionOrInput' => 495,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 474
		ACTIONS => {
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'LBRACE' => 108,
			'SELF' => 107,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149
		},
		GOTOS => {
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'HashReferenceLiteral' => 135,
			'SubExpressions' => 496,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'ScalarVariable' => 183,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 228,
			'Array' => 158,
			'ScalarLiteral' => 126,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191
		}
	},
	{#State 475
		ACTIONS => {
			'HASH_REF_SYMBOL' => -185,
			'MY' => -185,
			'OP10_NAMED_UNARY_SCOLON' => -185,
			"elsif" => 499,
			'WORD' => -185,
			'LPAREN' => -185,
			"foreach" => -185,
			"while" => -185,
			'ARRAY_SYMBOL' => -185,
			'OP01_CLOSE' => -185,
			'OP19_LOOP_CONTROL_SCOLON' => -185,
			"\@{" => -185,
			"undef" => -185,
			'OP05_LOGICAL_NEG' => -185,
			'' => -185,
			'HASH_SYMBOL' => -185,
			'LBRACE' => -185,
			'SELF' => -185,
			'OP01_NAMED_VOID' => -185,
			'SCALAR_SYMBOL' => -185,
			'LITERAL_NUMBER' => -185,
			'LITERAL_STRING' => -185,
			"else" => 500,
			'OP10_NAMED_UNARY' => -185,
			'OP01_PRINT' => -185,
			"if" => -185,
			'OP19_LOOP_CONTROL' => -185,
			'OP05_BITWISE_NEG_LPAREN' => -185,
			'OP22_LOGICAL_NEG' => -185,
			'OP01_NAMED_VOID_SCOLON' => -185,
			'OP05_MATH_NEG_LPAREN' => -185,
			"for" => -185,
			'WORD_SCOPED' => -185,
			'OP01_NAMED' => -185,
			'CONSTANT_CALL_SCOPED' => -185,
			'OP01_NAMED_VOID_LPAREN' => -185,
			'OP03_MATH_INC_DEC' => -185,
			'WORD_UPPERCASE' => -185,
			'ARRAY_REF_SYMBOL' => -185,
			"%{" => -185,
			'LBRACKET' => -185,
			"}" => -185,
			'OP01_NAMED_SCOLON' => -185,
			'OP01_OPEN' => -185,
			'OP22_LOGICAL_NEG_LPAREN' => -185,
			'POD' => -185
		},
		GOTOS => {
			'OPTIONAL-50' => 498,
			'PAREN-49' => 501,
			'PAREN-47' => 497
		}
	},
	{#State 476
		ACTIONS => {
			'HASH_REF_SYMBOL' => 161,
			'MY' => 159,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'LPAREN' => 164,
			'WORD' => 27,
			"foreach" => -173,
			"while" => -173,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			"\@{" => 149,
			"undef" => 106,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'SELF' => 107,
			'LBRACE' => 108,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 113,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'OP10_NAMED_UNARY' => 136,
			'OP01_PRINT' => 102,
			"if" => 101,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 140,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_NAMED_VOID_SCOLON' => 143,
			'OP05_MATH_NEG_LPAREN' => 142,
			"for" => -173,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 148,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'WORD_UPPERCASE' => 94,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'LBRACKET' => 132,
			"}" => 503,
			'OP01_NAMED_SCOLON' => 130,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'POD' => 99
		},
		GOTOS => {
			'SubExpression' => 134,
			'ScalarVariable' => 131,
			'OPTIONAL-46' => 98,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 95,
			'ArrayDereference' => 96,
			'PAREN-45' => 127,
			'ScalarLiteral' => 126,
			'HashLiteral' => 105,
			'ArrayVariable' => 104,
			'Hash' => 146,
			'LoopLabel' => 145,
			'WordScoped' => 103,
			'BracesEmpty' => 144,
			'ArrayReference' => 137,
			'Statement' => 139,
			'HashReferenceLiteral' => 135,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'Conditional' => 115,
			'ArrayHashLiteral' => 157,
			'Operation' => 502,
			'Expression' => 153,
			'Operator' => 154,
			'ArrayReferenceVariable' => 155,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 111,
			'VariableDeclaration' => 123,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'VariableModification' => 165,
			'ArrayLiteral' => 121,
			'HashDereference' => 120,
			'Scalar' => 163,
			'OperatorVoid' => 160,
			'Variable' => 162
		}
	},
	{#State 477
		DEFAULT => -196
	},
	{#State 478
		DEFAULT => -287
	},
	{#State 479
		ACTIONS => {
			'OP21_LIST_COMMA' => 504
		}
	},
	{#State 480
		DEFAULT => -299
	},
	{#State 481
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 505
		}
	},
	{#State 482
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			")" => 506,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 483
		DEFAULT => -101
	},
	{#State 484
		ACTIONS => {
			'LBRACE' => 507
		}
	},
	{#State 485
		DEFAULT => -76
	},
	{#State 486
		ACTIONS => {
			'OP20_HASH_FATARROW' => 508
		}
	},
	{#State 487
		ACTIONS => {
			";" => 509
		}
	},
	{#State 488
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 510
		}
	},
	{#State 489
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'HASH_REF_SYMBOL' => -58,
			'MY' => -58,
			"while" => -58,
			'WORD' => -58,
			'LPAREN' => -58,
			"foreach" => -58,
			'ARRAY_SYMBOL' => -58,
			'OP01_CLOSE' => -58,
			"undef" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'LPAREN_MY' => 513,
			"\@{" => -58,
			'OP01_NAMED_VOID' => -58,
			'SCALAR_SYMBOL' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'HASH_SYMBOL' => -58,
			'LBRACE' => -58,
			'SELF' => -58,
			'LITERAL_STRING' => -58,
			'LITERAL_NUMBER' => -58,
			'OP01_PRINT' => -58,
			'OP10_NAMED_UNARY' => -58,
			"if" => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'WORD_SCOPED' => -58,
			"for" => -58,
			'OP01_NAMED' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'WORD_UPPERCASE' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP03_MATH_INC_DEC' => -58,
			"%{" => -58,
			'ARRAY_REF_SYMBOL' => -58,
			'OP01_OPEN' => -58,
			'LBRACKET' => -58,
			"}" => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'POD' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 511,
			'OPTIONAL-24' => 512
		}
	},
	{#State 490
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 514,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258
		}
	},
	{#State 491
		DEFAULT => -294
	},
	{#State 492
		ACTIONS => {
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP11_COMPARE_LT_GT' => 259,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			";" => 515,
			'OP12_COMPARE_EQ_NE' => 247
		}
	},
	{#State 493
		DEFAULT => -295
	},
	{#State 494
		ACTIONS => {
			'SCALAR_SYMBOL' => 516
		}
	},
	{#State 495
		ACTIONS => {
			")" => 517
		}
	},
	{#State 496
		ACTIONS => {
			")" => 518
		}
	},
	{#State 497
		DEFAULT => -181
	},
	{#State 498
		DEFAULT => -186
	},
	{#State 499
		ACTIONS => {
			'LPAREN' => 519
		}
	},
	{#State 500
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 520
		}
	},
	{#State 501
		DEFAULT => -184
	},
	{#State 502
		DEFAULT => -195
	},
	{#State 503
		DEFAULT => -197
	},
	{#State 504
		ACTIONS => {
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161
		},
		GOTOS => {
			'ArrayReference' => 137,
			'HashDereference' => 120,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'HashReferenceLiteral' => 135,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarLiteral' => 126,
			'ArrayHashLiteral' => 157,
			'ArrayHashLiteralEmpty' => 156,
			'SubExpression' => 521,
			'Array' => 158,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Expression' => 187,
			'Operator' => 154
		}
	},
	{#State 505
		ACTIONS => {
			"undef" => 522
		}
	},
	{#State 506
		DEFAULT => -125
	},
	{#State 507
		ACTIONS => {
			'LBRACE' => 523
		}
	},
	{#State 508
		ACTIONS => {
			'MY' => 524
		},
		GOTOS => {
			'TypeInnerProperties' => 525
		}
	},
	{#State 509
		DEFAULT => -83
	},
	{#State 510
		ACTIONS => {
			"}" => 527,
			'OP21_LIST_COMMA' => 526
		},
		GOTOS => {
			'PAREN-33' => 528
		}
	},
	{#State 511
		DEFAULT => -57
	},
	{#State 512
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 529
		}
	},
	{#State 513
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'TYPE_INTEGER' => 277,
			'WORD' => 278
		},
		GOTOS => {
			'Type' => 530
		}
	},
	{#State 514
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'SELF' => 107,
			'LBRACE' => 108,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100
		},
		GOTOS => {
			'HashLiteral' => 105,
			'HashReference' => 166,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'HashReferenceLiteral' => 135,
			'Array' => 158,
			'SubExpression' => 531,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'ScalarVariable' => 183,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126
		}
	},
	{#State 515
		DEFAULT => -296
	},
	{#State 516
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 532
		}
	},
	{#State 517
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 533
		}
	},
	{#State 518
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 534
		}
	},
	{#State 519
		ACTIONS => {
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 142,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP22_LOGICAL_NEG' => 138,
			'OP10_NAMED_UNARY' => 136,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'LBRACKET' => 132,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'SELF' => 107,
			'LBRACE' => 108,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125
		},
		GOTOS => {
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'ScalarLiteral' => 126,
			'Array' => 158,
			'SubExpression' => 535,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ScalarVariable' => 183,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashReferenceLiteral' => 135,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'HashReference' => 166,
			'Hash' => 146,
			'BracketsEmpty' => 122,
			'WordScoped' => 103
		}
	},
	{#State 520
		DEFAULT => -183
	},
	{#State 521
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP08_STRING_CAT' => 258,
			")" => -102,
			'OP04_MATH_POW' => 251,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			"]" => -102,
			'OP18_TERNARY' => -102,
			'OP13_BITWISE_AND' => 257,
			'OP21_LIST_COMMA' => -102,
			";" => -102,
			'COLON' => -102,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP15_LOGICAL_AND' => 254,
			"}" => -102,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 253
		}
	},
	{#State 522
		ACTIONS => {
			";" => 536
		}
	},
	{#State 523
		ACTIONS => {
			'MY' => 537
		}
	},
	{#State 524
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'TYPE_INTEGER' => 277,
			'WORD' => 278
		},
		GOTOS => {
			'Type' => 538
		}
	},
	{#State 525
		DEFAULT => -267
	},
	{#State 526
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 211,
			'OP01_NAMED' => 207,
			'OP01_CLOSE' => 212,
			'OP23_LOGICAL_AND' => 221,
			'OP01_PRINT' => 215,
			'OP10_NAMED_UNARY' => 204,
			'OP07_STRING_REPEAT' => 219,
			'WORD' => 222,
			'OP19_LOOP_CONTROL' => 206,
			'OP22_LOGICAL_NEG' => 205,
			'OP01_OPEN' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP11_COMPARE_LT_GT' => 218,
			'OP01_NAMED_VOID' => 217
		},
		GOTOS => {
			'HashEntryProperties' => 539,
			'OpStringOrWord' => 486
		}
	},
	{#State 527
		ACTIONS => {
			";" => 540
		}
	},
	{#State 528
		DEFAULT => -80
	},
	{#State 529
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			"while" => -173,
			"foreach" => -173,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'MY' => 159,
			'HASH_REF_SYMBOL' => 161,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP01_NAMED_VOID' => 113,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			"undef" => 106,
			"\@{" => 149,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 148,
			'WORD_SCOPED' => 29,
			"for" => -173,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP01_NAMED_VOID_SCOLON' => 143,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 140,
			"if" => 101,
			'OP01_PRINT' => 102,
			'OP10_NAMED_UNARY' => 136,
			'POD' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'OP01_OPEN' => 133,
			'OP01_NAMED_SCOLON' => 130,
			"}" => 542,
			'LBRACKET' => 132,
			"%{" => 129,
			'ARRAY_REF_SYMBOL' => 128,
			'WORD_UPPERCASE' => 94,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_NAMED_VOID_LPAREN' => 124
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'PAREN-45' => 127,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 95,
			'ArrayDereference' => 96,
			'OPTIONAL-46' => 98,
			'ScalarVariable' => 131,
			'SubExpression' => 134,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Statement' => 139,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'LoopLabel' => 145,
			'ArrayVariable' => 104,
			'Hash' => 146,
			'HashLiteral' => 105,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 111,
			'Operation' => 541,
			'Operator' => 154,
			'Expression' => 153,
			'ArrayReferenceVariable' => 155,
			'ArrayHashLiteral' => 157,
			'Conditional' => 115,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'OperatorVoid' => 160,
			'Variable' => 162,
			'Scalar' => 163,
			'HashDereference' => 120,
			'VariableModification' => 165,
			'ArrayLiteral' => 121,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'VariableDeclaration' => 123
		}
	},
	{#State 530
		ACTIONS => {
			'SCALAR_SYMBOL' => 543
		}
	},
	{#State 531
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			'OP23_LOGICAL_AND' => -124,
			'OP04_MATH_POW' => 251,
			")" => 544,
			'OP08_STRING_CAT' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP15_LOGICAL_AND' => 254,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP11_COMPARE_LT_GT' => 259
		}
	},
	{#State 532
		ACTIONS => {
			'OP10_NAMED_UNARY' => 136,
			'OP10_NAMED_UNARY_SCOLON' => 493,
			'HASH_REF_SYMBOL' => 161,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP22_LOGICAL_NEG' => 138,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'LPAREN' => 164,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			"undef" => 106,
			'WORD_UPPERCASE' => 188,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			'HASH_SYMBOL' => 109,
			'OP01_OPEN' => 133,
			'OP01_NAMED_SCOLON' => 491,
			'LBRACKET' => 132,
			'LITERAL_STRING' => 118,
			'LITERAL_NUMBER' => 117,
			'OP22_LOGICAL_NEG_LPAREN' => 100
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'OpNamedScolonOrSubExp' => 545,
			'ArrayDereference' => 96,
			'HashVariable' => 189,
			'ArrayReferenceLiteral' => 97,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 183,
			'Expression' => 187,
			'Operator' => 154,
			'ArrayReferenceVariable' => 186,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 492,
			'HashReferenceLiteral' => 135,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'HashReference' => 166,
			'Hash' => 146,
			'ArrayVariable' => 190,
			'HashLiteral' => 105
		}
	},
	{#State 533
		DEFAULT => -194
	},
	{#State 534
		DEFAULT => -192
	},
	{#State 535
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 247,
			'OP11_COMPARE_LT_GT' => 259,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP23_LOGICAL_AND' => 261,
			'OP07_STRING_REPEAT' => 262,
			'OP06_REGEX_BIND' => 250,
			")" => 546,
			'OP08_STRING_CAT' => 258,
			'OP04_MATH_POW' => 251,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 536
		DEFAULT => -212
	},
	{#State 537
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'TYPE_METHOD' => 547,
			'WORD' => 278,
			'TYPE_INTEGER' => 277
		},
		GOTOS => {
			'Type' => 384
		}
	},
	{#State 538
		ACTIONS => {
			"\$TYPED_" => 548
		}
	},
	{#State 539
		DEFAULT => -79
	},
	{#State 540
		DEFAULT => -82
	},
	{#State 541
		DEFAULT => -59
	},
	{#State 542
		DEFAULT => -61
	},
	{#State 543
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 549
		}
	},
	{#State 544
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 550
		}
	},
	{#State 545
		ACTIONS => {
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'OP03_MATH_INC_DEC' => 125,
			"\@{" => 149,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'SELF' => 107,
			'LBRACE' => 108,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 110,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142
		},
		GOTOS => {
			'ScalarVariable' => 131,
			'SubExpressionOrVarMod' => 553,
			'Expression' => 187,
			'ArrayReferenceVariable' => 155,
			'Operator' => 154,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'Array' => 158,
			'SubExpression' => 552,
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'ArrayDereference' => 96,
			'HashVariable' => 95,
			'HashReferenceVariable' => 111,
			'ScalarVariableOrSelf' => 112,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 104,
			'HashReference' => 166,
			'Hash' => 146,
			'HashLiteral' => 105,
			'Variable' => 162,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'Scalar' => 163,
			'BracesEmpty' => 144,
			'VariableModification' => 551,
			'ArrayLiteral' => 121
		}
	},
	{#State 546
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 554
		}
	},
	{#State 547
		ACTIONS => {
			"\$RETURN_TYPE" => 555
		}
	},
	{#State 548
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 218,
			'OP01_NAMED_VOID' => 217,
			'OP19_LOOP_CONTROL_SCOLON' => 208,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 214,
			'OP24_LOGICAL_OR_XOR' => 209,
			'OP01_OPEN' => 201,
			'OP19_LOOP_CONTROL' => 206,
			'WORD' => 222,
			'OP22_LOGICAL_NEG' => 205,
			'OP23_LOGICAL_AND' => 221,
			'OP10_NAMED_UNARY' => 204,
			'OP01_PRINT' => 215,
			'OP07_STRING_REPEAT' => 219,
			'OP01_NAMED' => 207,
			'OP01_CLOSE' => 212,
			'OP08_MATH_ADD_SUB' => 211
		},
		GOTOS => {
			'OpStringOrWord' => 556
		}
	},
	{#State 549
		ACTIONS => {
			'OP21_LIST_COMMA' => 558,
			")" => 559
		},
		GOTOS => {
			'PAREN-26' => 557
		}
	},
	{#State 550
		DEFAULT => -190
	},
	{#State 551
		DEFAULT => -170
	},
	{#State 552
		ACTIONS => {
			'OP17_LIST_RANGE' => 252,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP11_COMPARE_LT_GT' => 259,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP15_LOGICAL_AND' => 254,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_STRING_CAT' => 258,
			")" => -169,
			'OP04_MATH_POW' => 251,
			'OP23_LOGICAL_AND' => 261,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262
		}
	},
	{#State 553
		ACTIONS => {
			")" => 560
		}
	},
	{#State 554
		DEFAULT => -180
	},
	{#State 555
		ACTIONS => {
			"}" => 561
		}
	},
	{#State 556
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 562,
			'OP02_ARRAY_THINARROW' => 563
		}
	},
	{#State 557
		DEFAULT => -63
	},
	{#State 558
		ACTIONS => {
			'MY' => 564
		}
	},
	{#State 559
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 565
		}
	},
	{#State 560
		ACTIONS => {
			'LBRACE' => 440
		},
		GOTOS => {
			'CodeBlock' => 566
		}
	},
	{#State 561
		ACTIONS => {
			";" => 567
		}
	},
	{#State 562
		ACTIONS => {
			'OP01_NAMED' => 185,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_CLOSE' => 168,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 27,
			'LPAREN' => 164,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_MATH_NEG_LPAREN' => 142,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'LBRACE' => 108,
			'SELF' => 107,
			'SCALAR_SYMBOL' => 152,
			"%{" => 129,
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			"undef" => 106,
			'WORD_UPPERCASE' => 188
		},
		GOTOS => {
			'HashReferenceLiteral' => 135,
			'ArrayLiteral' => 121,
			'BracesEmpty' => 144,
			'Scalar' => 163,
			'HashDereference' => 120,
			'ArrayReference' => 137,
			'BracketsEmpty' => 122,
			'WordScoped' => 103,
			'HashLiteral' => 105,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'ScalarLiteral' => 126,
			'ScalarVariableOrSelf' => 112,
			'HashReferenceVariable' => 191,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'ArrayReferenceLiteral' => 97,
			'Expression' => 187,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'ScalarVariable' => 183,
			'SubExpression' => 568,
			'Array' => 158,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157
		}
	},
	{#State 563
		ACTIONS => {
			"\@{" => 149,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 188,
			"undef" => 106,
			'LBRACE' => 108,
			'SELF' => 107,
			'HASH_SYMBOL' => 109,
			'ARRAY_REF_SYMBOL' => 128,
			'OP05_LOGICAL_NEG' => 110,
			"%{" => 129,
			'SCALAR_SYMBOL' => 152,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY' => 136,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 164,
			'WORD' => 27,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_MATH_NEG_LPAREN' => 142,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168
		},
		GOTOS => {
			'ScalarLiteral' => 126,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 189,
			'ArrayDereference' => 96,
			'HashReferenceVariable' => 191,
			'ScalarVariableOrSelf' => 112,
			'ScalarVariable' => 183,
			'ArrayReferenceVariable' => 186,
			'Operator' => 154,
			'Expression' => 187,
			'ArrayHashLiteralEmpty' => 156,
			'ArrayHashLiteral' => 157,
			'SubExpression' => 569,
			'Array' => 158,
			'HashReferenceLiteral' => 135,
			'HashDereference' => 120,
			'Scalar' => 163,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'ArrayLiteral' => 121,
			'WordScoped' => 103,
			'BracketsEmpty' => 122,
			'ArrayVariable' => 190,
			'Hash' => 146,
			'HashReference' => 166,
			'HashLiteral' => 105
		}
	},
	{#State 564
		ACTIONS => {
			'TYPE_INTEGER' => 277,
			'WORD' => 278,
			'WORD_SCOPED' => 276
		},
		GOTOS => {
			'Type' => 570
		}
	},
	{#State 565
		ACTIONS => {
			"\@ARG;" => 571
		}
	},
	{#State 566
		DEFAULT => -191
	},
	{#State 567
		ACTIONS => {
			'LITERAL_NUMBER' => -85,
			'LITERAL_STRING' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'HASH_SYMBOL' => -85,
			'SELF' => -85,
			'LBRACE' => -85,
			'OP01_NAMED_VOID' => -85,
			'SCALAR_SYMBOL' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'LPAREN_MY' => 573,
			"\@{" => -85,
			"undef" => -85,
			'ARRAY_SYMBOL' => -85,
			'OP01_CLOSE' => -85,
			'WORD' => -85,
			'LPAREN' => -85,
			"foreach" => -85,
			"while" => -85,
			'HASH_REF_SYMBOL' => -85,
			'MY' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'POD' => -85,
			'LBRACKET' => -85,
			"}" => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP01_OPEN' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			"%{" => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'WORD_UPPERCASE' => -85,
			'OP01_NAMED' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			"for" => -85,
			'WORD_SCOPED' => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'OP01_PRINT' => -85,
			'OP10_NAMED_UNARY' => -85,
			"if" => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 572,
			'MethodArguments' => 574
		}
	},
	{#State 568
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 247,
			'OP21_LIST_COMMA' => -288,
			'OP16_LOGICAL_OR' => 255,
			'OP09_BITWISE_SHIFT' => 256,
			'OP15_LOGICAL_AND' => 254,
			'OP11_COMPARE_LT_GT' => 259,
			"}" => -288,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP17_LIST_RANGE' => 252,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			'OP08_MATH_ADD_SUB' => 249,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP13_BITWISE_AND' => 257
		}
	},
	{#State 569
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 253,
			'OP17_LIST_RANGE' => 252,
			'OP15_LOGICAL_AND' => 254,
			'OP09_BITWISE_SHIFT' => 256,
			'OP16_LOGICAL_OR' => 255,
			'OP11_COMPARE_LT_GT' => 259,
			'OP12_COMPARE_EQ_NE' => 247,
			'OP13_BITWISE_AND' => 257,
			"]" => 575,
			'OP14_BITWISE_OR_XOR' => 260,
			'OP08_MATH_ADD_SUB' => 249,
			'OP04_MATH_POW' => 251,
			'OP08_STRING_CAT' => 258,
			'OP06_REGEX_BIND' => 250,
			'OP07_STRING_REPEAT' => 262,
			'OP23_LOGICAL_AND' => 261
		}
	},
	{#State 570
		ACTIONS => {
			'SCALAR_SYMBOL' => 576
		}
	},
	{#State 571
		DEFAULT => -65
	},
	{#State 572
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 577
		}
	},
	{#State 573
		ACTIONS => {
			'TYPE_INTEGER' => 277,
			'WORD' => 278,
			'WORD_SCOPED' => 276
		},
		GOTOS => {
			'Type' => 578
		}
	},
	{#State 574
		DEFAULT => -84
	},
	{#State 575
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 579
		}
	},
	{#State 576
		DEFAULT => -62
	},
	{#State 577
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP01_CLOSE' => 168,
			"foreach" => -173,
			'LPAREN' => 164,
			'WORD' => 27,
			"while" => -173,
			'MY' => 159,
			'HASH_REF_SYMBOL' => 161,
			'OP10_NAMED_UNARY_SCOLON' => 119,
			'LITERAL_NUMBER' => 117,
			'LITERAL_STRING' => 118,
			'LBRACE' => 108,
			'SELF' => 107,
			'OP05_LOGICAL_NEG' => 110,
			'HASH_SYMBOL' => 109,
			'SCALAR_SYMBOL' => 152,
			'OP01_NAMED_VOID' => 113,
			"\@{" => 149,
			'OP19_LOOP_CONTROL_SCOLON' => 150,
			"undef" => 106,
			'CONSTANT_CALL_SCOPED' => 147,
			'OP01_NAMED' => 148,
			"for" => -173,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP19_LOOP_CONTROL' => 140,
			'OP05_MATH_NEG_LPAREN' => 142,
			'OP01_NAMED_VOID_SCOLON' => 143,
			"if" => 101,
			'OP10_NAMED_UNARY' => 136,
			'OP01_PRINT' => 102,
			'POD' => 99,
			'OP22_LOGICAL_NEG_LPAREN' => 100,
			"}" => 581,
			'OP01_NAMED_SCOLON' => 130,
			'LBRACKET' => 132,
			'OP01_OPEN' => 133,
			'ARRAY_REF_SYMBOL' => 128,
			"%{" => 129,
			'OP01_NAMED_VOID_LPAREN' => 124,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 94
		},
		GOTOS => {
			'Hash' => 146,
			'ArrayVariable' => 104,
			'HashLiteral' => 105,
			'WordScoped' => 103,
			'LoopLabel' => 145,
			'Statement' => 139,
			'ArrayReference' => 137,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 135,
			'SubExpression' => 134,
			'ScalarVariable' => 131,
			'ArrayReferenceLiteral' => 97,
			'HashVariable' => 95,
			'ArrayDereference' => 96,
			'OPTIONAL-46' => 98,
			'ScalarLiteral' => 126,
			'PAREN-45' => 127,
			'VariableDeclaration' => 123,
			'HashReference' => 166,
			'BracketsEmpty' => 122,
			'HashDereference' => 120,
			'Scalar' => 163,
			'VariableModification' => 165,
			'ArrayLiteral' => 121,
			'Variable' => 162,
			'OperatorVoid' => 160,
			'ArrayHashLiteral' => 157,
			'Conditional' => 115,
			'ArrayHashLiteralEmpty' => 156,
			'Array' => 158,
			'Operation' => 580,
			'ArrayReferenceVariable' => 155,
			'Operator' => 154,
			'Expression' => 153,
			'HashReferenceVariable' => 111,
			'ScalarVariableOrSelf' => 112
		}
	},
	{#State 578
		ACTIONS => {
			'SELF' => 582
		}
	},
	{#State 579
		ACTIONS => {
			"undef" => 583
		}
	},
	{#State 580
		DEFAULT => -86
	},
	{#State 581
		DEFAULT => -88
	},
	{#State 582
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 584
		}
	},
	{#State 583
		DEFAULT => -289
	},
	{#State 584
		ACTIONS => {
			'OP21_LIST_COMMA' => 586,
			")" => 585
		},
		GOTOS => {
			'PAREN-37' => 587
		}
	},
	{#State 585
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 588
		}
	},
	{#State 586
		ACTIONS => {
			'MY' => 589
		}
	},
	{#State 587
		DEFAULT => -90
	},
	{#State 588
		ACTIONS => {
			"\@ARG;" => 590
		}
	},
	{#State 589
		ACTIONS => {
			'WORD_SCOPED' => 276,
			'WORD' => 278,
			'TYPE_INTEGER' => 277
		},
		GOTOS => {
			'Type' => 591
		}
	},
	{#State 590
		DEFAULT => -92
	},
	{#State 591
		ACTIONS => {
			'SCALAR_SYMBOL' => 592
		}
	},
	{#State 592
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 9638 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9645 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9652 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9659 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9670 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9688 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9695 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9702 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9709 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9716 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9723 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9744 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9751 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9758 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9765 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9783 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9790 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9804 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9815 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9826 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9865 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9872 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9879 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9886 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9893 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9900 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9907 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9932 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9943 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9950 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9957 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9968 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9975 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9982 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9989 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9996 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10010 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10021 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10028 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10035 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10049 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10060 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10071 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10082 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10089 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10103 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10110 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10121 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10135 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10142 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10153 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10167 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10174 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10181 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10188 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10195 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10202 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10209 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10216 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10223 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10234 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10245 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10256 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10263 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10270 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10277 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10288 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10299 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10306 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10327 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10338 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10359 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10370 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10381 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10392 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10403 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10414 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10425 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10678 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10689 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10700 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10711 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10722 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10733 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10744 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10755 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10766 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10777 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10805 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10812 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10823 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10834 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10845 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10856 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10867 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10878 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10889 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10900 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10907 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10935 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10942 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10953 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10964 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10975 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10986 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10997 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11008 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11019 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11030 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11041 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11052 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11063 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11074 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11085 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11096 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11107 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_164
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11118 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_165
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11129 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11140 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_167
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11151 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_168
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11162 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_169
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11173 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_170
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11184 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11191 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11198 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11205 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11216 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11227 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11238 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_177
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11249 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_178
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11260 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_179
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11271 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11292 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11299 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11306 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11313 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_186
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11324 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_187
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11335 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_188
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11346 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_189
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11357 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_190
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11368 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_191
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11379 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_192
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11390 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_193
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11401 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_194
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11412 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11419 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11426 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_197
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11437 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_198
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11448 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_199
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11459 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_200
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11470 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_201
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11481 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_202
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11492 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_203
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11503 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_204
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11514 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_205
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11525 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_206
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11536 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_207
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11547 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_208
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11558 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_209
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11569 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_210
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11580 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_211
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11591 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_212
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11602 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_213
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11613 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_214
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11624 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_215
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11635 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_216
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11646 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_217
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11657 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_218
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11668 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_219
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11679 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_220
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11690 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_221
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11701 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_222
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11712 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_223
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11723 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 286 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11730 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 286 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11737 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_226
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11748 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_227
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11759 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_228
		 'ScalarVariable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11770 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_229
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11781 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_230
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11792 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteral_231
		 'ArrayHashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11803 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 289 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 289 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 289 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11824 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressions_235
		 'SubExpressions', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11835 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEmpty_236
		 'ArrayHashLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11846 lib/RPerl/Grammar.pm
	],
	[#Rule BracketsEmpty_237
		 'BracketsEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11857 lib/RPerl/Grammar.pm
	],
	[#Rule BracesEmpty_238
		 'BracesEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11868 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 293 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11875 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 293 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11882 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 293 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11889 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_242
		 'ListElements', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11900 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_243
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11911 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_244
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11922 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_245
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11933 lib/RPerl/Grammar.pm
	],
	[#Rule Array_246
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11944 lib/RPerl/Grammar.pm
	],
	[#Rule Array_247
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11955 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteral_248
		 'ArrayLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11966 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_249
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11977 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_250
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11988 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_251
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11999 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_252
		 'ArrayReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12010 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_253
		 'ArrayReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12021 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceVariable_254
		 'ArrayReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12032 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 302 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12039 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 302 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12046 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_257
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12057 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_258
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12068 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 303 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12075 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 303 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12082 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 303 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12089 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntries_262
		 'HashEntries', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12100 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12107 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12114 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_265
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12125 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_266
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12136 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_267
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12147 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_268
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12158 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_269
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12169 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteral_270
		 'HashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12180 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_271
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12191 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_272
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12202 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_273
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12213 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_274
		 'HashReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12224 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_275
		 'HashReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12235 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceVariable_276
		 'HashReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12246 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 1,
sub {
#line 313 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12253 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-61', 0,
sub {
#line 313 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12260 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_279
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12271 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_280
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12282 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_281
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12293 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_282
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12304 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_283
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12315 lib/RPerl/Grammar.pm
	],
	[#Rule Type_284
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12326 lib/RPerl/Grammar.pm
	],
	[#Rule Type_285
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12337 lib/RPerl/Grammar.pm
	],
	[#Rule Type_286
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12348 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_287
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12359 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_288
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12370 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_289
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12381 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_290
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12392 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_291
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12403 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_292
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12414 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_293
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12425 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_294
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12436 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_295
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12447 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_296
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12458 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_297
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12469 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_298
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12480 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_299
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12491 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_300
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12502 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_301
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12513 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_302
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12524 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_303
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12535 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_304
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12546 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_305
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12557 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_306
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12568 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_307
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12579 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_308
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12590 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_309
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12601 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_310
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12612 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_311
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12623 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_312
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12634 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_313
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12645 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_314
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12656 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_315
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12667 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_316
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12678 lib/RPerl/Grammar.pm
	]
],
#line 12681 lib/RPerl/Grammar.pm
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
         'SubExpression_164', 
         'SubExpression_165', 
         'SubExpressionOrInput_166', 
         'SubExpressionOrInput_167', 
         'SubExpressionOrInput_168', 
         'SubExpressionOrVarMod_169', 
         'SubExpressionOrVarMod_170', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_174', 
         'Statement_175', 
         'Statement_176', 
         'Statement_177', 
         'Statement_178', 
         'Statement_179', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_186', 
         'Loop_187', 
         'Loop_188', 
         'Loop_189', 
         'LoopFor_190', 
         'LoopFor_191', 
         'LoopForEach_192', 
         'LoopWhile_193', 
         'LoopWhile_194', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_197', 
         'Variable_198', 
         'Variable_199', 
         'Variable_200', 
         'Variable_201', 
         'Variable_202', 
         'VariableRetrievalArrow_203', 
         'VariableRetrievalArrow_204', 
         'VariableRetrievalArrow_205', 
         'VariableRetrieval_206', 
         'VariableRetrieval_207', 
         'VariableRetrieval_208', 
         'VariableRetrieval_209', 
         'VariableDeclaration_210', 
         'VariableDeclaration_211', 
         'VariableDeclaration_212', 
         'VariableDeclaration_213', 
         'VariableDeclaration_214', 
         'VariableDeclaration_215', 
         'VariableDeclaration_216', 
         'VariableDeclaration_217', 
         'VariableModification_218', 
         'VariableModification_219', 
         'Scalar_220', 
         'Scalar_221', 
         'ScalarLiteral_222', 
         'ScalarLiteral_223', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ScalarVariable_226', 
         'ScalarVariable_227', 
         'ScalarVariable_228', 
         'ScalarVariableOrSelf_229', 
         'ScalarVariableOrSelf_230', 
         'ArrayHashLiteral_231', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubExpressions_235', 
         'ArrayHashLiteralEmpty_236', 
         'BracketsEmpty_237', 
         'BracesEmpty_238', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_242', 
         'ListElement_243', 
         'ListElement_244', 
         'ListElement_245', 
         'Array_246', 
         'Array_247', 
         'ArrayLiteral_248', 
         'ArrayVariable_249', 
         'ArrayReference_250', 
         'ArrayReference_251', 
         'ArrayReferenceLiteral_252', 
         'ArrayReferenceLiteral_253', 
         'ArrayReferenceVariable_254', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_257', 
         'ArrayDereference_258', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashEntries_262', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_265', 
         'HashEntry_266', 
         'HashEntryProperties_267', 
         'Hash_268', 
         'Hash_269', 
         'HashLiteral_270', 
         'HashVariable_271', 
         'HashReference_272', 
         'HashReference_273', 
         'HashReferenceLiteral_274', 
         'HashReferenceLiteral_275', 
         'HashReferenceVariable_276', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_279', 
         'HashDereference_280', 
         'WordScoped_281', 
         'WordScoped_282', 
         'LoopLabel_283', 
         'Type_284', 
         'Type_285', 
         'Type_286', 
         'TypeInner_287', 
         'TypeInnerProperties_288', 
         'TypeInnerProperties_289', 
         'TypeInnerConstant_290', 
         'VarOrLitOrOpStrOrWord_291', 
         'VarOrLitOrOpStrOrWord_292', 
         'VarOrLitOrOpStrOrWord_293', 
         'OpNamedScolonOrSubExp_294', 
         'OpNamedScolonOrSubExp_295', 
         'OpNamedScolonOrSubExp_296', 
         'OpNamedScolonOrSubExpIn_297', 
         'OpNamedScolonOrSubExpIn_298', 
         'OpNamedScolonOrSubExpIn_299', 
         'OpStringOrWord_300', 
         'OpStringOrWord_301', 
         'OpStringOrWord_302', 
         'OpStringOrWord_303', 
         'OpStringOrWord_304', 
         'OpStringOrWord_305', 
         'OpStringOrWord_306', 
         'OpStringOrWord_307', 
         'OpStringOrWord_308', 
         'OpStringOrWord_309', 
         'OpStringOrWord_310', 
         'OpStringOrWord_311', 
         'OpStringOrWord_312', 
         'OpStringOrWord_313', 
         'OpStringOrWord_314', 
         'OpStringOrWord_315', 
         'OpStringOrWord_316', );
  $self;
}

#line 332 "lib/RPerl/Grammar.eyp"


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
SubroutineArguments_65 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type SCALAR_SYMBOL STAR-25 ')' OP19_VARIABLE_ASSIGN '@ARG;'
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
Expression_149 => 'RPerl::Operation::Expression::Operator',                                        # Expression -> Operator
Expression_150 => 'RPerl::Operation::Expression::ConstantCall',                                    # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_151 => 'RPerl::Operation::Expression::ConstantCall',                                    # Expression -> CONSTANT_CALL_SCOPED
Expression_152 => 'RPerl::Operation::Expression::SubroutineCall',                                  # Expression -> WordScoped LPAREN OPTIONAL-40 ')'
Expression_153 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                      # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-41 ')'
Expression_154 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',     # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-42 ')'
SubExpression_155 => 'RPerl::Operation::Expression',                                               # SubExpression -> Expression
SubExpression_156 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',            # SubExpression -> 'undef'
SubExpression_157 => 'RPerl::Operation::Expression::SubExpression::Literal',                       # SubExpression -> Literal
SubExpression_158 => 'RPerl::Operation::Expression::SubExpression::Variable',                      # SubExpression -> Variable
SubExpression_159 => 'RPerl::DataStructure::Array::Reference',                                     # SubExpression -> ArrayReference
SubExpression_160 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',              # SubExpression -> ArrayDereference
SubExpression_161 => 'RPerl::DataStructure::Hash::Reference',                                      # SubExpression -> HashReference
SubExpression_162 => 'RPerl::Operation::Expression::SubExpression::HashDereference',               # SubExpression -> HashDereference
SubExpression_163 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                   # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrInput_164 => 'RPerl::Operation::Expression::SubExpression',                         # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_165 => 'RPerl::InputOutput::FilehandleIn',                                    # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_166 => 'RPerl::InputOutput::Stdin',                                           # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_167 => 'RPerl::Operation::Expression::SubExpression',                        # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_168 => 'RPerl::Operation::Statement::VariableModification',                  # SubExpressionOrVarMod -> VariableModification
Statement_172 => 'RPerl::Operation::Statement::Conditional',                                       # Statement -> Conditional
Statement_173 => 'RPerl::Operation::Statement::Loop',                                              # Statement -> OPTIONAL-44 Loop
Statement_174 => 'RPerl::Operation::Statement::OperatorVoid',                                      # Statement -> OperatorVoid
Statement_175 => 'RPerl::Operation::Statement::VariableDeclaration',                               # Statement -> VariableDeclaration
Statement_176 => 'RPerl::Operation::Statement::VariableModification',                              # Statement -> VariableModification ';'
Statement_177 => 'RPerl::NonGenerator',                                                            # Statement -> POD
Conditional_184 => 'RPerl::Operation::Statement::Conditional',                                     # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-46 OPTIONAL-48
Loop_185 => 'RPerl::Operation::Statement::Loop::For',                                              # Loop -> LoopFor
Loop_186 => 'RPerl::Operation::Statement::Loop::ForEach',                                          # Loop -> LoopForEach
Loop_187 => 'RPerl::Operation::Statement::Loop::While',                                            # Loop -> LoopWhile
LoopFor_188 => 'RPerl::Operation::Statement::Loop::For',                                           # LoopFor -> 'for' MY TYPE_INTEGER SCALAR_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_189 => 'RPerl::Operation::Statement::Loop::For',                                           # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER SCALAR_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp SCALAR_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_190 => 'RPerl::Operation::Statement::Loop::ForEach',                                   # LoopForEach -> 'foreach' MY Type SCALAR_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_191 => 'RPerl::Operation::Statement::Loop::While',                                       # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_192 => 'RPerl::Operation::Statement::Loop::While',                                       # LoopWhile -> 'while' LPAREN_MY Type SCALAR_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_195 => 'RPerl::CodeBlock',                                                               # CodeBlock -> LBRACE PLUS-49 '}'
Variable_198 => 'RPerl::Operation::Expression::SubExpression::Variable',                           # Variable -> ScalarVariableOrSelf STAR-50
VariableRetrievalArrow_199 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',  # VariableRetrievalArrow -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrievalArrow_200 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',  # VariableRetrievalArrow -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrievalArrow_201 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',  # VariableRetrievalArrow -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_202 => 'RPerl::Operation::Statement::VariableDeclaration',                     # VariableDeclaration -> MY Type SCALAR_SYMBOL ';'
VariableDeclaration_203 => 'RPerl::Operation::Statement::VariableDeclaration',                     # VariableDeclaration -> MY Type SCALAR_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_204 => 'RPerl::Operation::Statement::VariableDeclaration',                     # VariableDeclaration -> MY Type SCALAR_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_205 => 'RPerl::Operation::Statement::VariableDeclaration',                     # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_206 => 'RPerl::Operation::Statement::VariableModification',                   # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_207 => 'RPerl::Operation::Statement::VariableModification',                   # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_211 => 'RPerl::DataStructure::Array::ListElements',                                   # ListElements -> ListElement STAR-52
ListElement_212 => 'RPerl::Operation::Expression::SubExpression',                                  # ListElement -> SubExpression
ListElement_213 => 'RPerl::Operation::Expression::SubExpression',                                  # ListElement -> TypeInner SubExpression
ListElement_214 => 'RPerl::DataStructure::Array::ListElement',                                     # ListElement -> OP01_QW
ListElement_215 => 'RPerl::DataStructure::Array::ListElement',                                     # ListElement -> ARGV
ArrayReference_218 => 'RPerl::DataStructure::Array::Reference',                                    # ArrayReference -> LBRACKET OPTIONAL-53 ']'
ArrayDereference_221 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # ArrayDereference -> '@{' Variable '}'
ArrayDereference_222 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # ArrayDereference -> '@{' OPTIONAL-54 ArrayReference '}'
HashEntry_225 => 'RPerl::DataStructure::Hash::Entry',                                              # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
HashEntry_226 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                   # HashEntry -> HashDereference
HashEntry_227 => 'RPerl::DataStructure::Hash::Entry',                                              # HashEntry -> ENV
HashEntryProperties_228 => 'RPerl::NonGenerator',                                                  # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_232 => 'RPerl::DataStructure::Hash::Reference',                                      # HashReference -> LBRACE HashEntry STAR-57 '}'
HashReference_233 => 'RPerl::DataStructure::Hash::Reference',                                      # HashReference -> LBRACE '}'
HashDereference_236 => 'RPerl::Operation::Expression::SubExpression::HashDereference',             # HashDereference -> '%{' Variable '}'
HashDereference_237 => 'RPerl::Operation::Expression::SubExpression::HashDereference',             # HashDereference -> '%{' OPTIONAL-58 HashReference '}'
WordScoped_238 => 'RPerl::NonGenerator',                                                           # WordScoped -> WORD
WordScoped_239 => 'RPerl::NonGenerator',                                                           # WordScoped -> WORD_SCOPED
LoopLabel_240 => 'RPerl::NonGenerator',                                                            # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_241 => 'RPerl::NonGenerator',                                                                 # Type -> WORD
Type_242 => 'RPerl::NonGenerator',                                                                 # Type -> WORD_SCOPED
Type_243 => 'RPerl::NonGenerator',                                                                 # Type -> TYPE_INTEGER
TypeInner_244 => 'RPerl::DataType::TypeInner',                                                     # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_245 => 'RPerl::NonGenerator',                                                  # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_246 => 'RPerl::NonGenerator',                                                  # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_247 => 'RPerl::NonGenerator',                                                    # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_248 => 'RPerl::Operation::Expression::SubExpression::Variable',                  # VariableOrLiteral -> Variable
VariableOrLiteral_249 => 'RPerl::Operation::Expression::SubExpression::Literal',                   # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_250 => 'RPerl::Operation::Expression::SubExpression::Variable',              # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_251 => 'RPerl::Operation::Expression::SubExpression::Literal',               # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_252 => 'RPerl::NonGenerator',                                                # VarOrLitOrOpStrOrWord -> OpStringOrWord
ScalarVariableOrSelf_253 => 'RPerl::NonGenerator',                                                   # ScalarVariableOrSelf -> SCALAR_SYMBOL
ScalarVariableOrSelf_254 => 'RPerl::NonGenerator',                                                   # ScalarVariableOrSelf -> SELF
Literal_255 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                     # Literal -> LITERAL_NUMBER
Literal_256 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                     # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_257 => 'RPerl::NonGenerator',                                                # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_258 => 'RPerl::NonGenerator',                                                # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_259 => 'RPerl::NonGenerator',                                                # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_260 => 'RPerl::NonGenerator',                                              # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_261 => 'RPerl::NonGenerator',                                              # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_262 => 'RPerl::NonGenerator',                                              # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_263 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_264 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_265 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_266 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_267 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_268 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_269 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_270 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_271 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_272 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_273 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_274 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP01_NAMED
OpStringOrWord_275 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_276 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP01_OPEN
OpStringOrWord_277 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_278 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> OP01_PRINT
OpStringOrWord_279 => 'RPerl::NonGenerator',                                                       # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 13214 lib/RPerl/Grammar.pm



1;
