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
    our $VERSION = 0.020_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|foreach|\$TYPED_|package|while|undef|elsif|\@ARG\;|INIT|else|for|if|\%\{|\@\{|\{|\)|\;|\}|\[|\])}gc and return ($1, $1);

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
      /\G(\\\@(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('ARRAY_SYMBOL_REF', $1);
      /\G(\%(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('HASH_SYMBOL', $1);
      /\G(\\\%(?:[a-zA-Z_]\w*)?[a-z]\w*(::[a-zA-Z_]\w*)*)/gc and return ('HASH_SYMBOL_REF', $1);
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
  [ 'Constant_56' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
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
  [ 'LoopFor_188' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_189' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'SCALAR_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_190' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'SCALAR_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_191' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_192' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'PLUS-51', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'Operation' ], 0 ],
  [ 'CodeBlock_195' => 'CodeBlock', [ 'LBRACE', 'PLUS-51', '}' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'PLUS-52', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-52', [ 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'PLUS-54', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'VariableRetrieval' ], 0 ],
  [ 'Variable_202' => 'Variable', [ 'ScalarSymbolOrSelf' ], 0 ],
  [ 'Variable_203' => 'Variable', [ 'ScalarSymbolOrSelf', 'VariableRetrievalArrow' ], 0 ],
  [ 'Variable_204' => 'Variable', [ 'ScalarSymbolOrSelf', 'VariableRetrievalArrow', 'PLUS-52' ], 0 ],
  [ 'Variable_205' => 'Variable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'Variable_206' => 'Variable', [ 'ARRAY_SYMBOL', 'VariableRetrievalArray' ], 0 ],
  [ 'Variable_207' => 'Variable', [ 'ARRAY_SYMBOL', 'VariableRetrievalArray', 'PLUS-53' ], 0 ],
  [ 'Variable_208' => 'Variable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'Variable_209' => 'Variable', [ 'HASH_SYMBOL', 'VariableRetrievalHash' ], 0 ],
  [ 'Variable_210' => 'Variable', [ 'HASH_SYMBOL', 'VariableRetrievalHash', 'PLUS-54' ], 0 ],
  [ 'VariableRetrievalArrow_211' => 'VariableRetrievalArrow', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalArrow_212' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalArrow_213' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableRetrievalArray_214' => 'VariableRetrievalArray', [ '[', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalHash_215' => 'VariableRetrievalHash', [ '{', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalHash_216' => 'VariableRetrievalHash', [ '{', 'WORD', '}' ], 0 ],
  [ 'VariableRetrieval_217' => 'VariableRetrieval', [ 'VariableRetrievalArrow' ], 0 ],
  [ 'VariableRetrieval_218' => 'VariableRetrieval', [ 'VariableRetrievalArray' ], 0 ],
  [ 'VariableRetrieval_219' => 'VariableRetrieval', [ 'VariableRetrievalHash' ], 0 ],
  [ 'VariableDeclaration_220' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_221' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_222' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_223' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_224' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_225' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', '[', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_226' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_227' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_228' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_229' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_230' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'ListElements_234' => 'ListElements', [ 'ListElement', 'STAR-56' ], 0 ],
  [ 'ListElement_235' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_236' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_237' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_238' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'ArrayReference_241' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-57', ']' ], 0 ],
  [ 'ArrayReference_242' => 'ArrayReference', [ 'ARRAY_SYMBOL_REF' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-58', [  ], 0 ],
  [ 'ArrayDereference_245' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_246' => 'ArrayDereference', [ '@{', 'OPTIONAL-58', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'HashEntry_249' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-59', 'SubExpression' ], 0 ],
  [ 'HashEntry_250' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_251' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_252' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'HashReference_256' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-61', '}' ], 0 ],
  [ 'HashReference_257' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ 'HashReference_258' => 'HashReference', [ 'HASH_SYMBOL_REF' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-62', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-62', [  ], 0 ],
  [ 'HashDereference_261' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_262' => 'HashDereference', [ '%{', 'OPTIONAL-62', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_263' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_264' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_265' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_266' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_267' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_268' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_269' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_270' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_271' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_272' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_273' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_274' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_275' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_276' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_277' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'ScalarSymbolOrSelf_278' => 'ScalarSymbolOrSelf', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarSymbolOrSelf_279' => 'ScalarSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_280' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_281' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_282' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_283' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_284' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_285' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_286' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_287' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_288' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_289' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_290' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_291' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_292' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_293' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_294' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_295' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_296' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_297' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_298' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_299' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_300' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_301' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_302' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_303' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_304' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PLUS_LIST' => 196,
  '_PLUS_LIST' => 197,
  '_PLUS_LIST' => 198,
  '_PLUS_LIST' => 199,
  '_PLUS_LIST' => 200,
  '_PLUS_LIST' => 201,
  'Variable_202' => 202,
  'Variable_203' => 203,
  'Variable_204' => 204,
  'Variable_205' => 205,
  'Variable_206' => 206,
  'Variable_207' => 207,
  'Variable_208' => 208,
  'Variable_209' => 209,
  'Variable_210' => 210,
  'VariableRetrievalArrow_211' => 211,
  'VariableRetrievalArrow_212' => 212,
  'VariableRetrievalArrow_213' => 213,
  'VariableRetrievalArray_214' => 214,
  'VariableRetrievalHash_215' => 215,
  'VariableRetrievalHash_216' => 216,
  'VariableRetrieval_217' => 217,
  'VariableRetrieval_218' => 218,
  'VariableRetrieval_219' => 219,
  'VariableDeclaration_220' => 220,
  'VariableDeclaration_221' => 221,
  'VariableDeclaration_222' => 222,
  'VariableDeclaration_223' => 223,
  'VariableDeclaration_224' => 224,
  'VariableDeclaration_225' => 225,
  'VariableDeclaration_226' => 226,
  'VariableDeclaration_227' => 227,
  'VariableDeclaration_228' => 228,
  'VariableModification_229' => 229,
  'VariableModification_230' => 230,
  '_PAREN' => 231,
  '_STAR_LIST' => 232,
  '_STAR_LIST' => 233,
  'ListElements_234' => 234,
  'ListElement_235' => 235,
  'ListElement_236' => 236,
  'ListElement_237' => 237,
  'ListElement_238' => 238,
  '_OPTIONAL' => 239,
  '_OPTIONAL' => 240,
  'ArrayReference_241' => 241,
  'ArrayReference_242' => 242,
  '_OPTIONAL' => 243,
  '_OPTIONAL' => 244,
  'ArrayDereference_245' => 245,
  'ArrayDereference_246' => 246,
  '_OPTIONAL' => 247,
  '_OPTIONAL' => 248,
  'HashEntry_249' => 249,
  'HashEntry_250' => 250,
  'HashEntry_251' => 251,
  'HashEntryProperties_252' => 252,
  '_PAREN' => 253,
  '_STAR_LIST' => 254,
  '_STAR_LIST' => 255,
  'HashReference_256' => 256,
  'HashReference_257' => 257,
  'HashReference_258' => 258,
  '_OPTIONAL' => 259,
  '_OPTIONAL' => 260,
  'HashDereference_261' => 261,
  'HashDereference_262' => 262,
  'WordScoped_263' => 263,
  'WordScoped_264' => 264,
  'LoopLabel_265' => 265,
  'Type_266' => 266,
  'Type_267' => 267,
  'Type_268' => 268,
  'TypeInner_269' => 269,
  'TypeInnerProperties_270' => 270,
  'TypeInnerProperties_271' => 271,
  'TypeInnerConstant_272' => 272,
  'VariableOrLiteral_273' => 273,
  'VariableOrLiteral_274' => 274,
  'VarOrLitOrOpStrOrWord_275' => 275,
  'VarOrLitOrOpStrOrWord_276' => 276,
  'VarOrLitOrOpStrOrWord_277' => 277,
  'ScalarSymbolOrSelf_278' => 278,
  'ScalarSymbolOrSelf_279' => 279,
  'Literal_280' => 280,
  'Literal_281' => 281,
  'OpNamedScolonOrSubExp_282' => 282,
  'OpNamedScolonOrSubExp_283' => 283,
  'OpNamedScolonOrSubExp_284' => 284,
  'OpNamedScolonOrSubExpIn_285' => 285,
  'OpNamedScolonOrSubExpIn_286' => 286,
  'OpNamedScolonOrSubExpIn_287' => 287,
  'OpStringOrWord_288' => 288,
  'OpStringOrWord_289' => 289,
  'OpStringOrWord_290' => 290,
  'OpStringOrWord_291' => 291,
  'OpStringOrWord_292' => 292,
  'OpStringOrWord_293' => 293,
  'OpStringOrWord_294' => 294,
  'OpStringOrWord_295' => 295,
  'OpStringOrWord_296' => 296,
  'OpStringOrWord_297' => 297,
  'OpStringOrWord_298' => 298,
  'OpStringOrWord_299' => 299,
  'OpStringOrWord_300' => 300,
  'OpStringOrWord_301' => 301,
  'OpStringOrWord_302' => 302,
  'OpStringOrWord_303' => 303,
  'OpStringOrWord_304' => 304,
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
	'[' => { ISSEMANTIC => 0 },
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
	'{' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ARGV => { ISSEMANTIC => 1 },
	ARRAY_SYMBOL => { ISSEMANTIC => 1 },
	ARRAY_SYMBOL_REF => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	ENV => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_IN => { ISSEMANTIC => 1 },
	HASH_SYMBOL => { ISSEMANTIC => 1 },
	HASH_SYMBOL_REF => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 7,
			'SHEBANG' => 6,
			"package" => -20,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'CompileUnit' => 1,
			'OPTIONAL-9' => 2,
			'ModuleHeader' => 5,
			'Program' => 4,
			'Critic' => 3,
			'PAREN-1' => 9,
			'PLUS-2' => 8
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => 11,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 12
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
			'SUB' => -27,
			'USE' => -27,
			"use parent qw(" => 17,
			"## no critic qw(" => -27,
			"INIT" => -27,
			"use parent -norequire, qw(" => 13,
			"use constant" => -27,
			'USE_EXPORTER' => -27
		},
		GOTOS => {
			'Class' => 19,
			'UseParent' => 14,
			'Module' => 15,
			'STAR-11' => 16,
			'Package' => 18
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 21,
			'OPTIONAL-3' => 20
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 23
		},
		GOTOS => {
			'PLUS-17' => 22
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 7,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 24,
			'Critic' => 3,
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 2
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 13
		DEFAULT => -78
	},
	{#State 14
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			"INIT" => -29,
			'SUB' => -29,
			'USE' => -29,
			"use constant" => -29,
			"## no critic qw(" => 7,
			'USE_EXPORTER' => 31
		},
		GOTOS => {
			'Exports' => 29,
			'Critic' => 32,
			'OPTIONAL-12' => 30
		}
	},
	{#State 17
		DEFAULT => -77
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		DEFAULT => -25
	},
	{#State 20
		ACTIONS => {
			'USE_RPERL' => 33
		}
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		ACTIONS => {
			'WORD' => 35,
			")" => 34
		}
	},
	{#State 23
		DEFAULT => -41
	},
	{#State 24
		DEFAULT => -2
	},
	{#State 25
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 26
		DEFAULT => -263
	},
	{#State 27
		DEFAULT => -264
	},
	{#State 28
		ACTIONS => {
			")" => 37
		}
	},
	{#State 29
		DEFAULT => -28
	},
	{#State 30
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 31
		ACTIONS => {
			'SUB' => -45,
			'OUR_EXPORT' => 41,
			'USE' => -45,
			"INIT" => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT_OK' => -45,
			"use constant" => -45
		},
		GOTOS => {
			'PAREN-18' => 39,
			'OPTIONAL-19' => 40
		}
	},
	{#State 32
		DEFAULT => -26
	},
	{#State 33
		ACTIONS => {
			"use strict;" => 42
		},
		GOTOS => {
			'Header' => 43
		}
	},
	{#State 34
		DEFAULT => -42
	},
	{#State 35
		DEFAULT => -40
	},
	{#State 36
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		ACTIONS => {
			";" => 45
		}
	},
	{#State 38
		ACTIONS => {
			"use constant" => -33,
			"INIT" => 48,
			'SUB' => -33,
			'USE' => 46
		},
		GOTOS => {
			'STAR-14' => 47,
			'Include' => 49
		}
	},
	{#State 39
		DEFAULT => -44
	},
	{#State 40
		ACTIONS => {
			'USE' => -48,
			'OUR_EXPORT_OK' => 50,
			"INIT" => -48,
			'SUB' => -48,
			"our hashref \$properties" => -48,
			"use constant" => -48
		},
		GOTOS => {
			'PAREN-20' => 51,
			'OPTIONAL-21' => 52
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 53
		}
	},
	{#State 42
		ACTIONS => {
			"use warnings;" => 54
		}
	},
	{#State 43
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 55
		}
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 42
		},
		GOTOS => {
			'Header' => 56
		}
	},
	{#State 45
		ACTIONS => {
			"INIT" => 48,
			'USE' => 46
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 46
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 58
		}
	},
	{#State 47
		ACTIONS => {
			'SUB' => 59,
			"use constant" => 63
		},
		GOTOS => {
			'Constant' => 61,
			'PLUS-15' => 62,
			'Subroutine' => 60
		}
	},
	{#State 48
		ACTIONS => {
			'LBRACE' => 64
		}
	},
	{#State 49
		DEFAULT => -30
	},
	{#State 50
		ACTIONS => {
			'OP01_QW' => 65
		}
	},
	{#State 51
		DEFAULT => -47
	},
	{#State 52
		DEFAULT => -49
	},
	{#State 53
		ACTIONS => {
			";" => 66
		}
	},
	{#State 54
		ACTIONS => {
			'USE_RPERL_AFTER' => 68,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 67
		}
	},
	{#State 55
		ACTIONS => {
			'OP01_OPEN' => -11,
			'LITERAL_STRING' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LBRACKET' => -11,
			"while" => -11,
			'LPAREN' => -11,
			'OP01_NAMED_SCOLON' => -11,
			"## no critic qw(" => 7,
			'SUB' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'MY' => -11,
			'OP01_CLOSE' => -11,
			"\@{" => -11,
			'OP10_NAMED_UNARY' => -11,
			"if" => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'SELF' => -11,
			'WORD_UPPERCASE' => -11,
			'HASH_SYMBOL' => -11,
			'WORD' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_PRINT' => -11,
			'SCALAR_SYMBOL' => -11,
			"%{" => -11,
			'USE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'HASH_SYMBOL_REF' => -11,
			'ARRAY_SYMBOL_REF' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_SCOPED' => -11,
			'ARRAY_SYMBOL' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"use constant" => -11,
			'POD' => -11,
			"for" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"INIT" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"foreach" => -11,
			"undef" => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'Critic' => 70,
			'STAR-5' => 69
		}
	},
	{#State 56
		DEFAULT => -23
	},
	{#State 57
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 71
		}
	},
	{#State 58
		ACTIONS => {
			'OP01_QW' => 73,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 72
		}
	},
	{#State 59
		ACTIONS => {
			'WORD' => 74
		}
	},
	{#State 60
		DEFAULT => -35
	},
	{#State 61
		DEFAULT => -32
	},
	{#State 62
		ACTIONS => {
			'LITERAL_NUMBER' => 76,
			'SUB' => 59
		},
		GOTOS => {
			'Subroutine' => 75
		}
	},
	{#State 63
		ACTIONS => {
			'WORD_UPPERCASE' => 77
		}
	},
	{#State 64
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 78
		}
	},
	{#State 65
		ACTIONS => {
			";" => 79
		}
	},
	{#State 66
		DEFAULT => -43
	},
	{#State 67
		ACTIONS => {
			'OUR' => 80
		}
	},
	{#State 68
		DEFAULT => -37
	},
	{#State 69
		ACTIONS => {
			'ARRAY_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'ARRAY_SYMBOL_REF' => -13,
			'HASH_SYMBOL_REF' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED' => -13,
			"foreach" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13,
			"undef" => -13,
			"for" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'POD' => -13,
			"use constant" => -13,
			'LITERAL_NUMBER' => -13,
			"INIT" => 48,
			'OP01_NAMED_SCOLON' => -13,
			'LPAREN' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'SUB' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			'OP01_OPEN' => -13,
			"while" => -13,
			'LBRACKET' => -13,
			'OP01_PRINT' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'HASH_SYMBOL' => -13,
			'WORD' => -13,
			'WORD_UPPERCASE' => -13,
			'SELF' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'USE' => 46,
			"%{" => -13,
			'SCALAR_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			"\@{" => -13,
			'OP01_CLOSE' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			"if" => -13
		},
		GOTOS => {
			'STAR-6' => 82,
			'Include' => 81
		}
	},
	{#State 70
		DEFAULT => -8
	},
	{#State 71
		ACTIONS => {
			"use constant" => -69,
			'USE_EXPORTER' => 31,
			"## no critic qw(" => 7,
			"our hashref \$properties" => -69,
			"INIT" => -69,
			'USE' => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 84,
			'Critic' => 85,
			'Exports' => 83
		}
	},
	{#State 72
		ACTIONS => {
			";" => 86
		}
	},
	{#State 73
		DEFAULT => -50
	},
	{#State 74
		ACTIONS => {
			'LBRACE' => 87
		}
	},
	{#State 75
		DEFAULT => -34
	},
	{#State 76
		ACTIONS => {
			";" => 88
		}
	},
	{#State 77
		ACTIONS => {
			'OP20_HASH_FATARROW' => 89
		}
	},
	{#State 78
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 90
		}
	},
	{#State 79
		DEFAULT => -46
	},
	{#State 80
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 91
		}
	},
	{#State 81
		DEFAULT => -10
	},
	{#State 82
		ACTIONS => {
			'LPAREN' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'MY' => -15,
			'SUB' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP01_OPEN' => -15,
			'LITERAL_STRING' => -15,
			"while" => -15,
			'LBRACKET' => -15,
			'HASH_SYMBOL' => -15,
			'WORD' => -15,
			'OP01_PRINT' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD_UPPERCASE' => -15,
			'SELF' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'SCALAR_SYMBOL' => -15,
			"%{" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_CLOSE' => -15,
			"\@{" => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"if" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'ARRAY_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'HASH_SYMBOL_REF' => -15,
			'ARRAY_SYMBOL_REF' => -15,
			'OP01_NAMED' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID' => -15,
			'LBRACE' => -15,
			"undef" => -15,
			'POD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for" => -15,
			"use constant" => 63,
			'LITERAL_NUMBER' => -15
		},
		GOTOS => {
			'STAR-7' => 93,
			'Constant' => 92
		}
	},
	{#State 83
		DEFAULT => -68
	},
	{#State 84
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 94
		}
	},
	{#State 85
		DEFAULT => -66
	},
	{#State 86
		DEFAULT => -54
	},
	{#State 87
		ACTIONS => {
			'LBRACE' => 95
		}
	},
	{#State 88
		DEFAULT => -36
	},
	{#State 89
		ACTIONS => {
			'MY' => 97
		},
		GOTOS => {
			'TypeInnerConstant' => 96
		}
	},
	{#State 90
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 98
		},
		GOTOS => {
			'OPTIONAL-23' => 99
		}
	},
	{#State 91
		DEFAULT => -39
	},
	{#State 92
		DEFAULT => -12
	},
	{#State 93
		ACTIONS => {
			'MY' => 106,
			'SUB' => 59,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'OP01_NAMED_SCOLON' => 108,
			'LPAREN' => 109,
			"while" => -171,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP19_LOOP_CONTROL' => 120,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP01_PRINT' => 125,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'SELF' => 129,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"if" => 113,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP01_NAMED' => 138,
			'LBRACE' => 151,
			"undef" => 152,
			"foreach" => -171,
			'OP22_LOGICAL_NEG' => 153,
			'OP01_NAMED_VOID' => 155,
			'LITERAL_NUMBER' => 146,
			'OP05_LOGICAL_NEG' => 149,
			"for" => -171,
			'POD' => 150
		},
		GOTOS => {
			'LoopLabel' => 143,
			'Variable' => 105,
			'VariableDeclaration' => 139,
			'HashDereference' => 141,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-46' => 136,
			'Operation' => 131,
			'VariableModification' => 101,
			'PLUS-8' => 154,
			'Expression' => 157,
			'Subroutine' => 158,
			'Operator' => 130,
			'WordScoped' => 156,
			'SubExpression' => 122,
			'ArrayDereference' => 115,
			'Conditional' => 148,
			'OperatorVoid' => 117,
			'Literal' => 147,
			'PAREN-45' => 110,
			'Statement' => 111,
			'ArrayReference' => 114
		}
	},
	{#State 94
		ACTIONS => {
			"use constant" => -73,
			"INIT" => 48,
			"our hashref \$properties" => -73,
			'USE' => 46
		},
		GOTOS => {
			'STAR-31' => 159,
			'Include' => 160
		}
	},
	{#State 95
		ACTIONS => {
			'MY' => 161
		}
	},
	{#State 96
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 146
		},
		GOTOS => {
			'Literal' => 162
		}
	},
	{#State 97
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'WORD_SCOPED' => 164,
			'WORD' => 165
		},
		GOTOS => {
			'Type' => 163
		}
	},
	{#State 98
		DEFAULT => -52
	},
	{#State 99
		ACTIONS => {
			")" => 167
		}
	},
	{#State 100
		ACTIONS => {
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'MY' => 178,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 140,
			"]" => -240,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG' => 153,
			"undef" => 152,
			'ARGV' => 169,
			'LBRACE' => 151
		},
		GOTOS => {
			'Variable' => 177,
			'SubExpression' => 175,
			'TypeInner' => 171,
			'ListElement' => 170,
			'HashDereference' => 141,
			'Expression' => 172,
			'OPTIONAL-57' => 179,
			'Operator' => 130,
			'WordScoped' => 156,
			'Literal' => 147,
			'ListElements' => 174,
			'ArrayReference' => 114,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 101
		ACTIONS => {
			";" => 180
		}
	},
	{#State 102
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'HashDereference' => 141,
			'SubExpression' => 181,
			'Variable' => 177,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 103
		DEFAULT => -281
	},
	{#State 104
		ACTIONS => {
			'MY' => 182
		}
	},
	{#State 105
		ACTIONS => {
			'OP18_TERNARY' => -158,
			'OP02_METHOD_THINARROW' => 186,
			'OP04_MATH_POW' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP19_VARIABLE_ASSIGN' => 183,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP13_BITWISE_AND' => -158,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP03_MATH_INC_DEC' => 184,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP08_STRING_CAT' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 185,
			'OP15_LOGICAL_AND' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP16_LOGICAL_OR' => -158
		}
	},
	{#State 106
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'TYPE_FHREF' => 187,
			'WORD' => 165,
			'WORD_SCOPED' => 164
		},
		GOTOS => {
			'Type' => 188
		}
	},
	{#State 107
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			"undef" => 152,
			'ARGV' => 169,
			'LBRACE' => 151,
			'OP22_LOGICAL_NEG' => 153,
			'OP01_NAMED' => 173,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP10_NAMED_UNARY' => 116,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			")" => -134,
			'MY' => 178,
			'LPAREN' => 109
		},
		GOTOS => {
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 175,
			'ListElement' => 170,
			'TypeInner' => 171,
			'Variable' => 177,
			'OPTIONAL-41' => 190,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147,
			'ListElements' => 189
		}
	},
	{#State 108
		DEFAULT => -96
	},
	{#State 109
		ACTIONS => {
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_NAMED' => 191,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'LBRACE' => 151,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP01_PRINT' => 192,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'HashDereference' => 141,
			'SubExpression' => 193,
			'Variable' => 177,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 110
		DEFAULT => -170
	},
	{#State 111
		DEFAULT => -98
	},
	{#State 112
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'LBRACKET' => 100,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'SubExpression' => 194,
			'HashDereference' => 141,
			'Variable' => 177,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 114
		DEFAULT => -159
	},
	{#State 115
		DEFAULT => -160
	},
	{#State 116
		ACTIONS => {
			")" => -117,
			'OP08_MATH_ADD_SUB' => -117,
			";" => -117,
			'LPAREN' => 109,
			'OP15_LOGICAL_AND' => -117,
			'OP08_STRING_CAT' => -117,
			'LBRACKET' => 100,
			'OP11_COMPARE_LT_GT' => -117,
			'LITERAL_STRING' => 103,
			'OP16_LOGICAL_OR' => -117,
			'OP01_OPEN' => 104,
			'OP23_LOGICAL_AND' => -117,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP18_TERNARY' => -117,
			'OP04_MATH_POW' => -117,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP17_LIST_RANGE' => -117,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'CONSTANT_CALL_SCOPED' => 140,
			"]" => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP03_MATH_INC_DEC' => 145,
			'OP21_LIST_COMMA' => -117,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			"undef" => 152,
			'OP14_BITWISE_OR_XOR' => -117,
			"}" => -117,
			'LBRACE' => 151,
			'OP06_REGEX_BIND' => -117,
			'OP22_LOGICAL_NEG' => 153,
			'OP07_STRING_REPEAT' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'LITERAL_NUMBER' => 146,
			'OP13_BITWISE_AND' => -117,
			'OP05_LOGICAL_NEG' => 149
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 196
		}
	},
	{#State 117
		DEFAULT => -174
	},
	{#State 118
		ACTIONS => {
			'MY' => 178,
			'SCALAR_SYMBOL' => 123,
			'HASH_SYMBOL' => 127,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 129,
			'LBRACKET' => -244,
			'ARRAY_SYMBOL_REF' => -244
		},
		GOTOS => {
			'OPTIONAL-58' => 198,
			'ScalarSymbolOrSelf' => 132,
			'TypeInner' => 197,
			'Variable' => 199
		}
	},
	{#State 119
		ACTIONS => {
			'FHREF_SYMBOL' => 200
		}
	},
	{#State 120
		ACTIONS => {
			'WORD_UPPERCASE' => 202
		},
		GOTOS => {
			'LoopLabel' => 201
		}
	},
	{#State 121
		DEFAULT => -141
	},
	{#State 122
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP08_MATH_ADD_SUB' => 214,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204
		}
	},
	{#State 123
		DEFAULT => -278
	},
	{#State 124
		ACTIONS => {
			'HASH_SYMBOL_REF' => -260,
			'SELF' => 129,
			'ARRAY_SYMBOL' => 142,
			'HASH_SYMBOL' => 127,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => -260,
			'MY' => 178
		},
		GOTOS => {
			'TypeInner' => 220,
			'Variable' => 222,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-62' => 221
		}
	},
	{#State 125
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'OP01_CLOSE' => -132,
			"\@{" => -132,
			'OP10_NAMED_UNARY' => -132,
			'FHREF_SYMBOL_BRACES' => 223,
			"%{" => -132,
			'SCALAR_SYMBOL' => -132,
			'SELF' => -132,
			'WORD_UPPERCASE' => -132,
			'HASH_SYMBOL' => -132,
			'WORD' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'LBRACKET' => -132,
			'LITERAL_STRING' => -132,
			'OP01_OPEN' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'MY' => -132,
			'LPAREN' => -132,
			'LITERAL_NUMBER' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'OP01_QW' => -132,
			"undef" => -132,
			'ARGV' => -132,
			'LBRACE' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'OP01_NAMED' => -132,
			'HASH_SYMBOL_REF' => -132,
			'ARRAY_SYMBOL_REF' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'STDOUT_STDERR' => 225,
			'OP03_MATH_INC_DEC' => -132,
			'WORD_SCOPED' => -132,
			'ARRAY_SYMBOL' => -132
		},
		GOTOS => {
			'PAREN-39' => 226,
			'OPTIONAL-40' => 224
		}
	},
	{#State 126
		ACTIONS => {
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'LBRACE' => 151,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'SubExpression' => 227,
			'HashDereference' => 141,
			'Variable' => 177,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 127
		ACTIONS => {
			'OP07_STRING_REPEAT' => -208,
			'OP17_LIST_RANGE' => -208,
			'OP06_REGEX_BIND' => -208,
			'OP02_METHOD_THINARROW' => -208,
			'OP04_MATH_POW' => -208,
			'OP18_TERNARY' => -208,
			'COLON' => -208,
			'OP14_BITWISE_OR_XOR' => -208,
			'OP07_MATH_MULT_DIV_MOD' => -208,
			"}" => -208,
			'OP13_BITWISE_AND' => -208,
			"{" => 228,
			'OP24_LOGICAL_OR_XOR' => -208,
			'OP19_VARIABLE_ASSIGN' => -208,
			'OP20_HASH_FATARROW' => -208,
			'OP21_LIST_COMMA' => -208,
			'OP08_STRING_CAT' => -208,
			'OP03_MATH_INC_DEC' => -208,
			'OP12_COMPARE_EQ_NE' => -208,
			'OP15_LOGICAL_AND' => -208,
			'OP09_BITWISE_SHIFT' => -208,
			'OP19_VARIABLE_ASSIGN_BY' => -208,
			"]" => -208,
			";" => -208,
			'OP08_MATH_ADD_SUB' => -208,
			")" => -208,
			'OP23_LOGICAL_AND' => -208,
			'OP16_LOGICAL_OR' => -208,
			'OP11_COMPARE_LT_GT' => -208
		},
		GOTOS => {
			'VariableRetrievalHash' => 229
		}
	},
	{#State 128
		ACTIONS => {
			'LPAREN' => 230,
			'COLON' => -265
		}
	},
	{#State 129
		DEFAULT => -279
	},
	{#State 130
		DEFAULT => -149
	},
	{#State 131
		DEFAULT => -17
	},
	{#State 132
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -202,
			'OP07_MATH_MULT_DIV_MOD' => -202,
			"}" => -202,
			'COLON' => -202,
			'OP18_TERNARY' => -202,
			'OP04_MATH_POW' => -202,
			'OP02_METHOD_THINARROW' => -202,
			'OP06_REGEX_BIND' => -202,
			'OP17_LIST_RANGE' => -202,
			'OP07_STRING_REPEAT' => -202,
			'OP19_VARIABLE_ASSIGN' => -202,
			'OP24_LOGICAL_OR_XOR' => -202,
			'OP13_BITWISE_AND' => -202,
			")" => -202,
			'OP02_ARRAY_THINARROW' => 231,
			";" => -202,
			'OP08_MATH_ADD_SUB' => -202,
			"]" => -202,
			'OP19_VARIABLE_ASSIGN_BY' => -202,
			'OP09_BITWISE_SHIFT' => -202,
			'OP15_LOGICAL_AND' => -202,
			'OP03_MATH_INC_DEC' => -202,
			'OP12_COMPARE_EQ_NE' => -202,
			'OP21_LIST_COMMA' => -202,
			'OP20_HASH_FATARROW' => -202,
			'OP08_STRING_CAT' => -202,
			'OP02_HASH_THINARROW' => 233,
			'OP11_COMPARE_LT_GT' => -202,
			'OP16_LOGICAL_OR' => -202,
			'OP23_LOGICAL_AND' => -202
		},
		GOTOS => {
			'VariableRetrievalArrow' => 232
		}
	},
	{#State 133
		DEFAULT => -242
	},
	{#State 134
		DEFAULT => -161
	},
	{#State 135
		DEFAULT => -258
	},
	{#State 136
		ACTIONS => {
			"for" => 239,
			"foreach" => 240,
			"while" => 234
		},
		GOTOS => {
			'LoopFor' => 237,
			'LoopWhile' => 238,
			'Loop' => 235,
			'LoopForEach' => 236
		}
	},
	{#State 137
		DEFAULT => -97
	},
	{#State 138
		ACTIONS => {
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 178,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LBRACE' => 151,
			'ARGV' => 169,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129
		},
		GOTOS => {
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'Variable' => 177,
			'ListElement' => 241,
			'SubExpression' => 242,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 139
		DEFAULT => -175
	},
	{#State 140
		DEFAULT => -151
	},
	{#State 141
		DEFAULT => -162
	},
	{#State 142
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -205,
			"[" => 244,
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP13_BITWISE_AND' => -205,
			'COLON' => -205,
			'OP14_BITWISE_OR_XOR' => -205,
			'OP07_MATH_MULT_DIV_MOD' => -205,
			"}" => -205,
			'OP04_MATH_POW' => -205,
			'OP02_METHOD_THINARROW' => -205,
			'OP18_TERNARY' => -205,
			'OP06_REGEX_BIND' => -205,
			'OP07_STRING_REPEAT' => -205,
			'OP17_LIST_RANGE' => -205,
			'OP11_COMPARE_LT_GT' => -205,
			'OP16_LOGICAL_OR' => -205,
			'OP23_LOGICAL_AND' => -205,
			";" => -205,
			'OP08_MATH_ADD_SUB' => -205,
			")" => -205,
			"]" => -205,
			'OP15_LOGICAL_AND' => -205,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP09_BITWISE_SHIFT' => -205,
			'OP08_STRING_CAT' => -205,
			'OP21_LIST_COMMA' => -205,
			'OP20_HASH_FATARROW' => -205,
			'OP12_COMPARE_EQ_NE' => -205,
			'OP03_MATH_INC_DEC' => -205
		},
		GOTOS => {
			'VariableRetrievalArray' => 243
		}
	},
	{#State 143
		ACTIONS => {
			'COLON' => 245
		}
	},
	{#State 144
		DEFAULT => -137
	},
	{#State 145
		ACTIONS => {
			'SCALAR_SYMBOL' => 123,
			'ARRAY_SYMBOL' => 142,
			'HASH_SYMBOL' => 127,
			'SELF' => 129
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'Variable' => 246
		}
	},
	{#State 146
		DEFAULT => -280
	},
	{#State 147
		DEFAULT => -157
	},
	{#State 148
		DEFAULT => -172
	},
	{#State 149
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'LBRACE' => 151,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 247,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 150
		DEFAULT => -177
	},
	{#State 151
		ACTIONS => {
			'SCALAR_SYMBOL' => 123,
			"}" => 272,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			"%{" => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP19_LOOP_CONTROL' => 261,
			'OP01_NAMED_VOID' => 269,
			'SELF' => 129,
			'WORD' => 258,
			'OP22_LOGICAL_NEG' => 271,
			'HASH_SYMBOL' => 127,
			'OP01_PRINT' => 257,
			'OP07_STRING_REPEAT' => 270,
			'OP24_LOGICAL_OR_XOR' => 267,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 255,
			'OP10_NAMED_UNARY' => 256,
			'OP08_MATH_ADD_SUB' => 251,
			'ENV' => 252,
			'OP12_COMPARE_EQ_NE' => 263,
			'ARRAY_SYMBOL' => 142,
			'OP11_COMPARE_LT_GT' => 250,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 262,
			'OP01_OPEN' => 248,
			'OP23_LOGICAL_AND' => 249
		},
		GOTOS => {
			'HashDereference' => 264,
			'HashEntry' => 266,
			'Literal' => 268,
			'Variable' => 254,
			'VarOrLitOrOpStrOrWord' => 265,
			'OpStringOrWord' => 253,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 152
		DEFAULT => -156
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'LBRACKET' => 100,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 273,
			'Variable' => 177
		}
	},
	{#State 154
		ACTIONS => {
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP03_MATH_INC_DEC' => 145,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'CONSTANT_CALL_SCOPED' => 140,
			'POD' => 150,
			"for" => -171,
			'OP05_LOGICAL_NEG' => 149,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG' => 153,
			"foreach" => -171,
			'OP01_NAMED_VOID' => 155,
			'LBRACE' => 151,
			"undef" => 152,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'' => -18,
			"while" => -171,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP01_NAMED_SCOLON' => 108,
			'MY' => 106,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 116,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"if" => 113,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP01_PRINT' => 125,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 128,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP19_LOOP_CONTROL' => 120,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123
		},
		GOTOS => {
			'Literal' => 147,
			'Statement' => 111,
			'PAREN-45' => 110,
			'ArrayReference' => 114,
			'ArrayDereference' => 115,
			'Conditional' => 148,
			'OperatorVoid' => 117,
			'SubExpression' => 122,
			'Operator' => 130,
			'Expression' => 157,
			'WordScoped' => 156,
			'Operation' => 274,
			'VariableModification' => 101,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-46' => 136,
			'Variable' => 105,
			'VariableDeclaration' => 139,
			'HashDereference' => 141,
			'LoopLabel' => 143
		}
	},
	{#State 155
		ACTIONS => {
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'LBRACE' => 151,
			'ARGV' => 169,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 178,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ArrayReference' => 114,
			'ListElements' => 275,
			'Literal' => 147,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'ListElement' => 170,
			'HashDereference' => 141,
			'TypeInner' => 171,
			'SubExpression' => 175,
			'Variable' => 177
		}
	},
	{#State 156
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 277,
			'LPAREN' => 276
		}
	},
	{#State 157
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP04_MATH_POW' => -155,
			'OP18_TERNARY' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			";" => 278,
			'OP08_STRING_CAT' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP09_BITWISE_SHIFT' => -155
		}
	},
	{#State 158
		DEFAULT => -14
	},
	{#State 159
		ACTIONS => {
			"use constant" => 63,
			"our hashref \$properties" => 279
		},
		GOTOS => {
			'Constant' => 281,
			'Properties' => 280
		}
	},
	{#State 160
		DEFAULT => -70
	},
	{#State 161
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'WORD_SCOPED' => 164,
			'WORD' => 165
		},
		GOTOS => {
			'Type' => 282
		}
	},
	{#State 162
		ACTIONS => {
			";" => 283
		}
	},
	{#State 163
		ACTIONS => {
			"\$TYPED_" => 284
		}
	},
	{#State 164
		DEFAULT => -267
	},
	{#State 165
		DEFAULT => -266
	},
	{#State 166
		DEFAULT => -268
	},
	{#State 167
		ACTIONS => {
			";" => 285
		}
	},
	{#State 168
		DEFAULT => -237
	},
	{#State 169
		DEFAULT => -238
	},
	{#State 170
		DEFAULT => -233,
		GOTOS => {
			'STAR-56' => 286
		}
	},
	{#State 171
		ACTIONS => {
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'LBRACE' => 151,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 287,
			'Variable' => 177,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 172
		DEFAULT => -155
	},
	{#State 173
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'SubExpression' => 288,
			'HashDereference' => 141,
			'Variable' => 177
		}
	},
	{#State 174
		DEFAULT => -239
	},
	{#State 175
		ACTIONS => {
			'OP21_LIST_COMMA' => -235,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			"]" => -235,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -235,
			")" => -235,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206
		}
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 230
		}
	},
	{#State 177
		ACTIONS => {
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			";" => -158,
			"]" => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			'OP03_MATH_INC_DEC' => 184,
			'OP21_LIST_COMMA' => -158,
			'OP08_STRING_CAT' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			"}" => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP18_TERNARY' => -158,
			'OP02_METHOD_THINARROW' => 186,
			'OP04_MATH_POW' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP13_BITWISE_AND' => -158
		}
	},
	{#State 178
		ACTIONS => {
			'WORD_SCOPED' => 164,
			'WORD' => 165,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 289
		}
	},
	{#State 179
		ACTIONS => {
			"]" => 290
		}
	},
	{#State 180
		DEFAULT => -176
	},
	{#State 181
		ACTIONS => {
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			")" => 291,
			'OP08_MATH_ADD_SUB' => 214,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 182
		ACTIONS => {
			'TYPE_FHREF' => 292
		}
	},
	{#State 183
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'STDIN' => 296,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'FHREF_SYMBOL_IN' => 295,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'SubExpressionOrInput' => 294,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 293,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 184
		DEFAULT => -105
	},
	{#State 185
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Variable' => 177,
			'SubExpression' => 297,
			'HashDereference' => 141
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 298
		}
	},
	{#State 187
		ACTIONS => {
			'FHREF_SYMBOL' => 299
		}
	},
	{#State 188
		ACTIONS => {
			'SCALAR_SYMBOL' => 302,
			'HASH_SYMBOL' => 301,
			'ARRAY_SYMBOL' => 300
		}
	},
	{#State 189
		DEFAULT => -133
	},
	{#State 190
		ACTIONS => {
			")" => 303
		}
	},
	{#State 191
		ACTIONS => {
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'ARGV' => 169,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176
		},
		GOTOS => {
			'Variable' => 177,
			'ListElement' => 304,
			'HashDereference' => 141,
			'TypeInner' => 171,
			'SubExpression' => 242,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'Literal' => 147,
			'ArrayReference' => 114,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 192
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 305
		}
	},
	{#State 193
		ACTIONS => {
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			")" => 306,
			'OP08_MATH_ADD_SUB' => 214,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212
		}
	},
	{#State 194
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP11_COMPARE_LT_GT' => 217,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			")" => 307,
			'OP08_MATH_ADD_SUB' => 214
		}
	},
	{#State 195
		ACTIONS => {
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'SubExpression' => 308,
			'HashDereference' => 141,
			'Variable' => 177,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 196
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			"]" => -116,
			";" => -116,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP09_BITWISE_SHIFT' => 209,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP13_BITWISE_AND' => -116,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => -116,
			'OP06_REGEX_BIND' => 205
		}
	},
	{#State 197
		DEFAULT => -243
	},
	{#State 198
		ACTIONS => {
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133
		},
		GOTOS => {
			'ArrayReference' => 309
		}
	},
	{#State 199
		ACTIONS => {
			"}" => 310
		}
	},
	{#State 200
		DEFAULT => -103
	},
	{#State 201
		ACTIONS => {
			";" => 311
		}
	},
	{#State 202
		DEFAULT => -265
	},
	{#State 203
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'LBRACE' => 151,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119
		},
		GOTOS => {
			'SubExpression' => 312,
			'HashDereference' => 141,
			'Variable' => 177,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'ArrayReference' => 114,
			'Literal' => 147,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134
		}
	},
	{#State 204
		ACTIONS => {
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LBRACKET' => 100,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 313,
			'Variable' => 177,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 205
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 314
		}
	},
	{#State 206
		ACTIONS => {
			'LBRACE' => 151,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'SubExpression' => 315,
			'HashDereference' => 141,
			'Variable' => 177,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156
		}
	},
	{#State 207
		ACTIONS => {
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 316,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Literal' => 147,
			'ArrayReference' => 114,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 208
		ACTIONS => {
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129
		},
		GOTOS => {
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 317,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Literal' => 147,
			'ArrayReference' => 114,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 209
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Variable' => 177,
			'SubExpression' => 318,
			'HashDereference' => 141,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172
		}
	},
	{#State 210
		ACTIONS => {
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'Variable' => 177,
			'SubExpression' => 319,
			'HashDereference' => 141,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 211
		ACTIONS => {
			'HASH_SYMBOL' => 127,
			'ARRAY_SYMBOL' => 142,
			'LITERAL_STRING' => 103,
			'SELF' => 129,
			'LITERAL_NUMBER' => 146,
			'SCALAR_SYMBOL' => 123
		},
		GOTOS => {
			'VariableOrLiteral' => 321,
			'Literal' => 320,
			'Variable' => 322,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 212
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'LBRACE' => 151,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'HashDereference' => 141,
			'SubExpression' => 323,
			'Variable' => 177,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 213
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'Variable' => 177,
			'SubExpression' => 324,
			'HashDereference' => 141,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 214
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Literal' => 147,
			'ArrayReference' => 114,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'Variable' => 177,
			'SubExpression' => 325,
			'HashDereference' => 141
		}
	},
	{#State 215
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'LBRACE' => 151,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'HashDereference' => 141,
			'SubExpression' => 326,
			'Variable' => 177
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Variable' => 177,
			'SubExpression' => 327,
			'HashDereference' => 141
		}
	},
	{#State 217
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'LBRACE' => 151,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 328,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130
		}
	},
	{#State 218
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Variable' => 177,
			'SubExpression' => 329,
			'HashDereference' => 141,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130
		}
	},
	{#State 219
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LBRACKET' => 100
		},
		GOTOS => {
			'HashDereference' => 141,
			'SubExpression' => 330,
			'Variable' => 177,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'ArrayReference' => 114,
			'Literal' => 147,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134
		}
	},
	{#State 220
		DEFAULT => -259
	},
	{#State 221
		ACTIONS => {
			'LBRACE' => 151,
			'HASH_SYMBOL_REF' => 135
		},
		GOTOS => {
			'HashReference' => 331
		}
	},
	{#State 222
		ACTIONS => {
			"}" => 332
		}
	},
	{#State 223
		ACTIONS => {
			'ARGV' => 169,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'Variable' => 177,
			'HashDereference' => 141,
			'TypeInner' => 171,
			'SubExpression' => 175,
			'ListElement' => 170,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'ListElements' => 333,
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115
		}
	},
	{#State 224
		ACTIONS => {
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'ARGV' => 169,
			'LBRACE' => 151,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 178,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LBRACKET' => 100
		},
		GOTOS => {
			'ListElement' => 170,
			'SubExpression' => 175,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'Variable' => 177,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'ArrayReference' => 114,
			'Literal' => 147,
			'ListElements' => 334,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 225
		DEFAULT => -130
	},
	{#State 226
		DEFAULT => -131
	},
	{#State 227
		ACTIONS => {
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			")" => 335,
			'OP08_MATH_ADD_SUB' => 214,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 228
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 337,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 336
		}
	},
	{#State 229
		ACTIONS => {
			"{" => 228,
			'OP07_MATH_MULT_DIV_MOD' => -209,
			'COLON' => -209,
			'OP18_TERNARY' => -209,
			'OP04_MATH_POW' => -209,
			'OP02_METHOD_THINARROW' => -209,
			'OP17_LIST_RANGE' => -209,
			'OP02_HASH_THINARROW' => 233,
			'OP11_COMPARE_LT_GT' => -209,
			'OP16_LOGICAL_OR' => -209,
			'OP23_LOGICAL_AND' => -209,
			'OP02_ARRAY_THINARROW' => 231,
			")" => -209,
			";" => -209,
			'OP08_MATH_ADD_SUB' => -209,
			'OP15_LOGICAL_AND' => -209,
			'OP20_HASH_FATARROW' => -209,
			'OP08_STRING_CAT' => -209,
			'OP19_VARIABLE_ASSIGN' => -209,
			"[" => 244,
			'OP24_LOGICAL_OR_XOR' => -209,
			'OP13_BITWISE_AND' => -209,
			"}" => -209,
			'OP14_BITWISE_OR_XOR' => -209,
			'OP06_REGEX_BIND' => -209,
			'OP07_STRING_REPEAT' => -209,
			"]" => -209,
			'OP19_VARIABLE_ASSIGN_BY' => -209,
			'OP09_BITWISE_SHIFT' => -209,
			'OP03_MATH_INC_DEC' => -209,
			'OP12_COMPARE_EQ_NE' => -209,
			'OP21_LIST_COMMA' => -209
		},
		GOTOS => {
			'PLUS-54' => 342,
			'VariableRetrieval' => 341,
			'VariableRetrievalArrow' => 338,
			'VariableRetrievalHash' => 339,
			'VariableRetrievalArray' => 340
		}
	},
	{#State 230
		ACTIONS => {
			")" => 343
		}
	},
	{#State 231
		ACTIONS => {
			'LBRACKET' => 100,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126
		},
		GOTOS => {
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 344,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 232
		ACTIONS => {
			"{" => 228,
			'COLON' => -203,
			'OP07_MATH_MULT_DIV_MOD' => -203,
			'OP02_METHOD_THINARROW' => -203,
			'OP04_MATH_POW' => -203,
			'OP18_TERNARY' => -203,
			'OP17_LIST_RANGE' => -203,
			'OP02_HASH_THINARROW' => 233,
			'OP11_COMPARE_LT_GT' => -203,
			'OP16_LOGICAL_OR' => -203,
			'OP23_LOGICAL_AND' => -203,
			'OP08_MATH_ADD_SUB' => -203,
			";" => -203,
			'OP02_ARRAY_THINARROW' => 231,
			")" => -203,
			'OP15_LOGICAL_AND' => -203,
			'OP20_HASH_FATARROW' => -203,
			'OP08_STRING_CAT' => -203,
			'OP24_LOGICAL_OR_XOR' => -203,
			"[" => 244,
			'OP19_VARIABLE_ASSIGN' => -203,
			'OP13_BITWISE_AND' => -203,
			'OP14_BITWISE_OR_XOR' => -203,
			"}" => -203,
			'OP06_REGEX_BIND' => -203,
			'OP07_STRING_REPEAT' => -203,
			"]" => -203,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP09_BITWISE_SHIFT' => -203,
			'OP21_LIST_COMMA' => -203,
			'OP03_MATH_INC_DEC' => -203,
			'OP12_COMPARE_EQ_NE' => -203
		},
		GOTOS => {
			'VariableRetrieval' => 346,
			'VariableRetrievalHash' => 339,
			'VariableRetrievalArray' => 340,
			'PLUS-52' => 345,
			'VariableRetrievalArrow' => 338
		}
	},
	{#State 233
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'HASH_SYMBOL' => 127,
			'WORD' => 347,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118
		},
		GOTOS => {
			'HashDereference' => 141,
			'SubExpression' => 348,
			'Variable' => 177,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'ArrayReference' => 114,
			'Literal' => 147,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 234
		ACTIONS => {
			'LPAREN' => 349,
			'LPAREN_MY' => 350
		}
	},
	{#State 235
		DEFAULT => -173
	},
	{#State 236
		DEFAULT => -186
	},
	{#State 237
		DEFAULT => -185
	},
	{#State 238
		DEFAULT => -187
	},
	{#State 239
		ACTIONS => {
			'MY' => 352,
			'LPAREN_MY' => 351
		}
	},
	{#State 240
		ACTIONS => {
			'MY' => 353
		}
	},
	{#State 241
		ACTIONS => {
			'OP21_LIST_COMMA' => 354
		}
	},
	{#State 242
		ACTIONS => {
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP21_LIST_COMMA' => -235,
			'OP08_STRING_CAT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			";" => -100,
			")" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 243
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -206,
			'COLON' => -206,
			'OP18_TERNARY' => -206,
			'OP02_METHOD_THINARROW' => -206,
			'OP04_MATH_POW' => -206,
			'OP17_LIST_RANGE' => -206,
			"{" => 228,
			'OP02_ARRAY_THINARROW' => 231,
			")" => -206,
			'OP08_MATH_ADD_SUB' => -206,
			";" => -206,
			'OP15_LOGICAL_AND' => -206,
			'OP20_HASH_FATARROW' => -206,
			'OP08_STRING_CAT' => -206,
			'OP02_HASH_THINARROW' => 233,
			'OP11_COMPARE_LT_GT' => -206,
			'OP16_LOGICAL_OR' => -206,
			'OP23_LOGICAL_AND' => -206,
			'OP14_BITWISE_OR_XOR' => -206,
			"}" => -206,
			'OP06_REGEX_BIND' => -206,
			'OP07_STRING_REPEAT' => -206,
			'OP19_VARIABLE_ASSIGN' => -206,
			"[" => 244,
			'OP24_LOGICAL_OR_XOR' => -206,
			'OP13_BITWISE_AND' => -206,
			"]" => -206,
			'OP19_VARIABLE_ASSIGN_BY' => -206,
			'OP09_BITWISE_SHIFT' => -206,
			'OP12_COMPARE_EQ_NE' => -206,
			'OP03_MATH_INC_DEC' => -206,
			'OP21_LIST_COMMA' => -206
		},
		GOTOS => {
			'VariableRetrievalHash' => 339,
			'VariableRetrievalArray' => 340,
			'PLUS-53' => 355,
			'VariableRetrievalArrow' => 338,
			'VariableRetrieval' => 356
		}
	},
	{#State 244
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ArrayReference' => 114,
			'Literal' => 147,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'HashDereference' => 141,
			'SubExpression' => 357,
			'Variable' => 177
		}
	},
	{#State 245
		DEFAULT => -169
	},
	{#State 246
		DEFAULT => -104
	},
	{#State 247
		ACTIONS => {
			'OP18_TERNARY' => -108,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			"}" => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			")" => -108,
			";" => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP08_STRING_CAT' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP16_LOGICAL_OR' => -108
		}
	},
	{#State 248
		DEFAULT => -301
	},
	{#State 249
		DEFAULT => -289
	},
	{#State 250
		DEFAULT => -294
	},
	{#State 251
		DEFAULT => -296
	},
	{#State 252
		DEFAULT => -251
	},
	{#State 253
		DEFAULT => -277
	},
	{#State 254
		DEFAULT => -275
	},
	{#State 255
		DEFAULT => -300
	},
	{#State 256
		DEFAULT => -295
	},
	{#State 257
		DEFAULT => -303
	},
	{#State 258
		DEFAULT => -304
	},
	{#State 259
		DEFAULT => -297
	},
	{#State 260
		DEFAULT => -291
	},
	{#State 261
		DEFAULT => -292
	},
	{#State 262
		DEFAULT => -299
	},
	{#State 263
		DEFAULT => -293
	},
	{#State 264
		DEFAULT => -250
	},
	{#State 265
		ACTIONS => {
			'OP20_HASH_FATARROW' => 358
		}
	},
	{#State 266
		DEFAULT => -255,
		GOTOS => {
			'STAR-61' => 359
		}
	},
	{#State 267
		DEFAULT => -288
	},
	{#State 268
		DEFAULT => -276
	},
	{#State 269
		DEFAULT => -302
	},
	{#State 270
		DEFAULT => -298
	},
	{#State 271
		DEFAULT => -290
	},
	{#State 272
		DEFAULT => -257
	},
	{#State 273
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			"}" => -127,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP23_LOGICAL_AND' => -127,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP21_LIST_COMMA' => -127,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			"]" => -127,
			")" => -127,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -127
		}
	},
	{#State 274
		DEFAULT => -16
	},
	{#State 275
		ACTIONS => {
			";" => 360
		}
	},
	{#State 276
		ACTIONS => {
			"undef" => 152,
			'LBRACE' => 151,
			'ARGV' => 169,
			'OP22_LOGICAL_NEG' => 153,
			'LITERAL_NUMBER' => 146,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			")" => -144,
			'MY' => 178,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102
		},
		GOTOS => {
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'Variable' => 177,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'ListElement' => 170,
			'SubExpression' => 175,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-42' => 362,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ListElements' => 361,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 277
		ACTIONS => {
			'HASH_SYMBOL_REF' => 135,
			")" => -148,
			'LBRACE' => 151
		},
		GOTOS => {
			'HashReference' => 364,
			'OPTIONAL-44' => 363
		}
	},
	{#State 278
		DEFAULT => -95
	},
	{#State 279
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 280
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 366
		}
	},
	{#State 281
		DEFAULT => -72
	},
	{#State 282
		ACTIONS => {
			"\$RETURN_TYPE" => 367
		}
	},
	{#State 283
		DEFAULT => -56
	},
	{#State 284
		ACTIONS => {
			'WORD_UPPERCASE' => 368
		}
	},
	{#State 285
		ACTIONS => {
			"}" => 369
		}
	},
	{#State 286
		ACTIONS => {
			"]" => -234,
			";" => -234,
			")" => -234,
			'OP21_LIST_COMMA' => 371
		},
		GOTOS => {
			'PAREN-55' => 370
		}
	},
	{#State 287
		ACTIONS => {
			'OP21_LIST_COMMA' => -236,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			"]" => -236,
			";" => -236,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -236,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206
		}
	},
	{#State 288
		ACTIONS => {
			'OP07_STRING_REPEAT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP04_MATH_POW' => -100,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP08_STRING_CAT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			"]" => -100,
			";" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			")" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP11_COMPARE_LT_GT' => -100
		}
	},
	{#State 289
		ACTIONS => {
			"\$TYPED_" => 372
		}
	},
	{#State 290
		DEFAULT => -241
	},
	{#State 291
		DEFAULT => -107
	},
	{#State 292
		ACTIONS => {
			'FHREF_SYMBOL' => 373
		}
	},
	{#State 293
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			";" => -164,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -164
		}
	},
	{#State 294
		DEFAULT => -229
	},
	{#State 295
		DEFAULT => -165
	},
	{#State 296
		DEFAULT => -166
	},
	{#State 297
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -230,
			")" => -230,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209
		}
	},
	{#State 298
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP10_NAMED_UNARY' => 116,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			")" => -146,
			'MY' => 178,
			'LPAREN' => 109,
			'LITERAL_NUMBER' => 146,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			"undef" => 152,
			'ARGV' => 169,
			'LBRACE' => 151,
			'OP22_LOGICAL_NEG' => 153,
			'OP01_NAMED' => 173,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145
		},
		GOTOS => {
			'OPTIONAL-43' => 374,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147,
			'ListElements' => 375,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'SubExpression' => 175,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'ListElement' => 170,
			'Variable' => 177
		}
	},
	{#State 299
		ACTIONS => {
			";" => 376
		}
	},
	{#State 300
		ACTIONS => {
			"[" => 378,
			";" => 377,
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 301
		ACTIONS => {
			";" => 381,
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 302
		ACTIONS => {
			";" => 383,
			'OP02_ARRAY_THINARROW' => 382,
			'OP19_VARIABLE_ASSIGN' => 384
		}
	},
	{#State 303
		ACTIONS => {
			";" => 385
		}
	},
	{#State 304
		ACTIONS => {
			'OP21_LIST_COMMA' => 386
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'OP10_NAMED_UNARY' => 116,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'ARGV' => 169,
			'LBRACE' => 151,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 178,
			'LPAREN' => 109,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145
		},
		GOTOS => {
			'Variable' => 177,
			'SubExpression' => 175,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'ListElement' => 170,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'ListElements' => 387,
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134
		}
	},
	{#State 306
		DEFAULT => -163
	},
	{#State 307
		DEFAULT => -126
	},
	{#State 308
		ACTIONS => {
			")" => 388,
			'OP08_MATH_ADD_SUB' => 214,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207
		}
	},
	{#State 309
		ACTIONS => {
			"}" => 389
		}
	},
	{#State 310
		DEFAULT => -245
	},
	{#State 311
		DEFAULT => -142
	},
	{#State 312
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP13_BITWISE_AND' => 207,
			'OP14_BITWISE_OR_XOR' => -121,
			"}" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP18_TERNARY' => -121,
			'OP04_MATH_POW' => 210,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => -121,
			'OP07_STRING_REPEAT' => 204,
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => -121,
			'OP23_LOGICAL_AND' => -121,
			")" => -121,
			";" => -121,
			'OP08_MATH_ADD_SUB' => 214,
			"]" => -121,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => -121,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -121
		}
	},
	{#State 313
		ACTIONS => {
			'OP18_TERNARY' => -111,
			'OP04_MATH_POW' => 210,
			"}" => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP06_REGEX_BIND' => 205,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP13_BITWISE_AND' => -111,
			"]" => -111,
			")" => -111,
			'OP08_MATH_ADD_SUB' => -111,
			";" => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP08_STRING_CAT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP16_LOGICAL_OR' => -111
		}
	},
	{#State 314
		DEFAULT => -110
	},
	{#State 315
		ACTIONS => {
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			"}" => -129,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -129,
			")" => -129,
			";" => -129,
			'OP08_MATH_ADD_SUB' => 214,
			"]" => -129,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 316
		ACTIONS => {
			'OP18_TERNARY' => -120,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP17_LIST_RANGE' => -120,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP13_BITWISE_AND' => -120,
			"]" => -120,
			")" => -120,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -120,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP21_LIST_COMMA' => -120,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => -120,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => -120,
			'OP16_LOGICAL_OR' => -120
		}
	},
	{#State 317
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -119,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => -119,
			"]" => -119,
			")" => -119,
			";" => -119,
			'OP08_MATH_ADD_SUB' => 214,
			'OP23_LOGICAL_AND' => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP11_COMPARE_LT_GT' => 217,
			'OP17_LIST_RANGE' => -119,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => -119,
			'OP04_MATH_POW' => 210,
			"}" => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP13_BITWISE_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119
		}
	},
	{#State 318
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP18_TERNARY' => -115,
			'OP04_MATH_POW' => 210,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => -115,
			'OP07_STRING_REPEAT' => 204,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP13_BITWISE_AND' => -115,
			")" => -115,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -115,
			"]" => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP23_LOGICAL_AND' => -115
		}
	},
	{#State 319
		ACTIONS => {
			'OP23_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP08_STRING_CAT' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			"]" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			";" => -106,
			")" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -106,
			"}" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106
		}
	},
	{#State 320
		DEFAULT => -274
	},
	{#State 321
		ACTIONS => {
			'COLON' => 390
		}
	},
	{#State 322
		DEFAULT => -273
	},
	{#State 323
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP08_STRING_CAT' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP15_LOGICAL_AND' => -112,
			"]" => -112,
			")" => -112,
			'OP08_MATH_ADD_SUB' => -112,
			";" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => -112,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			"}" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112
		}
	},
	{#State 324
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP13_BITWISE_AND' => 207,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -124,
			"}" => -124,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_BIND' => 205,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => -124,
			'OP16_LOGICAL_OR' => 219,
			"]" => -124,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -124,
			")" => -124,
			'OP21_LIST_COMMA' => -124,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209
		}
	},
	{#State 325
		ACTIONS => {
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => -113,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP08_STRING_CAT' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			"]" => -113,
			";" => -113,
			'OP08_MATH_ADD_SUB' => -113,
			")" => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP11_COMPARE_LT_GT' => -113
		}
	},
	{#State 326
		ACTIONS => {
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => -114,
			'OP07_STRING_REPEAT' => 204,
			"}" => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP18_TERNARY' => -114,
			'OP04_MATH_POW' => 210,
			'OP13_BITWISE_AND' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP08_STRING_CAT' => -114,
			'OP21_LIST_COMMA' => -114,
			")" => -114,
			";" => -114,
			'OP08_MATH_ADD_SUB' => 214,
			"]" => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP11_COMPARE_LT_GT' => -114
		}
	},
	{#State 327
		ACTIONS => {
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => -122,
			'OP14_BITWISE_OR_XOR' => 203,
			"}" => -122,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -122,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -122,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -122,
			")" => -122,
			"]" => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 328
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 214,
			";" => -118,
			")" => -118,
			"]" => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP16_LOGICAL_OR' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -118,
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP13_BITWISE_AND' => -118
		}
	},
	{#State 329
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP13_BITWISE_AND' => 207,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			"}" => -128,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => -128,
			'OP16_LOGICAL_OR' => 219,
			"]" => -128,
			";" => -128,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -128,
			'OP21_LIST_COMMA' => -128,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209
		}
	},
	{#State 330
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => -123,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => -123,
			"}" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP23_LOGICAL_AND' => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP11_COMPARE_LT_GT' => 217,
			'OP21_LIST_COMMA' => -123,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			"]" => -123,
			";" => -123,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -123
		}
	},
	{#State 331
		ACTIONS => {
			"}" => 391
		}
	},
	{#State 332
		DEFAULT => -261
	},
	{#State 333
		ACTIONS => {
			";" => 392
		}
	},
	{#State 334
		ACTIONS => {
			";" => 393
		}
	},
	{#State 335
		DEFAULT => -109
	},
	{#State 336
		ACTIONS => {
			"}" => 394,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP08_MATH_ADD_SUB' => 214,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218
		}
	},
	{#State 337
		ACTIONS => {
			"}" => 395,
			'OP02_METHOD_THINARROW_NEW' => -263,
			'LPAREN' => -263
		}
	},
	{#State 338
		DEFAULT => -217
	},
	{#State 339
		DEFAULT => -219
	},
	{#State 340
		DEFAULT => -218
	},
	{#State 341
		DEFAULT => -201
	},
	{#State 342
		ACTIONS => {
			'OP07_STRING_REPEAT' => -210,
			'OP06_REGEX_BIND' => -210,
			'OP14_BITWISE_OR_XOR' => -210,
			"}" => -210,
			'OP13_BITWISE_AND' => -210,
			'OP24_LOGICAL_OR_XOR' => -210,
			"[" => 244,
			'OP19_VARIABLE_ASSIGN' => -210,
			'OP21_LIST_COMMA' => -210,
			'OP03_MATH_INC_DEC' => -210,
			'OP12_COMPARE_EQ_NE' => -210,
			'OP09_BITWISE_SHIFT' => -210,
			'OP19_VARIABLE_ASSIGN_BY' => -210,
			"]" => -210,
			'OP17_LIST_RANGE' => -210,
			'OP02_METHOD_THINARROW' => -210,
			'OP04_MATH_POW' => -210,
			'OP18_TERNARY' => -210,
			'COLON' => -210,
			'OP07_MATH_MULT_DIV_MOD' => -210,
			"{" => 228,
			'OP20_HASH_FATARROW' => -210,
			'OP08_STRING_CAT' => -210,
			'OP15_LOGICAL_AND' => -210,
			'OP08_MATH_ADD_SUB' => -210,
			";" => -210,
			'OP02_ARRAY_THINARROW' => 231,
			")" => -210,
			'OP23_LOGICAL_AND' => -210,
			'OP16_LOGICAL_OR' => -210,
			'OP11_COMPARE_LT_GT' => -210,
			'OP02_HASH_THINARROW' => 233
		},
		GOTOS => {
			'VariableRetrievalArrow' => 338,
			'VariableRetrievalArray' => 340,
			'VariableRetrievalHash' => 339,
			'VariableRetrieval' => 396
		}
	},
	{#State 343
		DEFAULT => -150
	},
	{#State 344
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 214,
			"]" => 397,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207
		}
	},
	{#State 345
		ACTIONS => {
			"{" => 228,
			'COLON' => -204,
			'OP07_MATH_MULT_DIV_MOD' => -204,
			'OP04_MATH_POW' => -204,
			'OP02_METHOD_THINARROW' => -204,
			'OP18_TERNARY' => -204,
			'OP17_LIST_RANGE' => -204,
			'OP02_HASH_THINARROW' => 233,
			'OP11_COMPARE_LT_GT' => -204,
			'OP16_LOGICAL_OR' => -204,
			'OP23_LOGICAL_AND' => -204,
			'OP08_MATH_ADD_SUB' => -204,
			";" => -204,
			'OP02_ARRAY_THINARROW' => 231,
			")" => -204,
			'OP15_LOGICAL_AND' => -204,
			'OP08_STRING_CAT' => -204,
			'OP20_HASH_FATARROW' => -204,
			"[" => 244,
			'OP24_LOGICAL_OR_XOR' => -204,
			'OP19_VARIABLE_ASSIGN' => -204,
			'OP13_BITWISE_AND' => -204,
			'OP14_BITWISE_OR_XOR' => -204,
			"}" => -204,
			'OP06_REGEX_BIND' => -204,
			'OP07_STRING_REPEAT' => -204,
			"]" => -204,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP09_BITWISE_SHIFT' => -204,
			'OP21_LIST_COMMA' => -204,
			'OP03_MATH_INC_DEC' => -204,
			'OP12_COMPARE_EQ_NE' => -204
		},
		GOTOS => {
			'VariableRetrievalArrow' => 338,
			'VariableRetrievalHash' => 339,
			'VariableRetrievalArray' => 340,
			'VariableRetrieval' => 398
		}
	},
	{#State 346
		DEFAULT => -197
	},
	{#State 347
		ACTIONS => {
			'LPAREN' => -263,
			'OP02_METHOD_THINARROW_NEW' => -263,
			"}" => 399
		}
	},
	{#State 348
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 214,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			"}" => 400,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207
		}
	},
	{#State 349
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123
		},
		GOTOS => {
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Variable' => 177,
			'SubExpression' => 401,
			'HashDereference' => 141,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114
		}
	},
	{#State 350
		ACTIONS => {
			'WORD' => 165,
			'WORD_SCOPED' => 164,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 402
		}
	},
	{#State 351
		ACTIONS => {
			'TYPE_INTEGER' => 403
		}
	},
	{#State 352
		ACTIONS => {
			'TYPE_INTEGER' => 404
		}
	},
	{#State 353
		ACTIONS => {
			'WORD_SCOPED' => 164,
			'WORD' => 165,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 405
		}
	},
	{#State 354
		ACTIONS => {
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'ARGV' => 169,
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129
		},
		GOTOS => {
			'HashDereference' => 141,
			'ListElement' => 170,
			'TypeInner' => 171,
			'SubExpression' => 175,
			'Variable' => 177,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'ArrayReference' => 114,
			'ListElements' => 406,
			'Literal' => 147,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134
		}
	},
	{#State 355
		ACTIONS => {
			"]" => -207,
			'OP21_LIST_COMMA' => -207,
			'OP03_MATH_INC_DEC' => -207,
			'OP12_COMPARE_EQ_NE' => -207,
			'OP09_BITWISE_SHIFT' => -207,
			'OP19_VARIABLE_ASSIGN_BY' => -207,
			"[" => 244,
			'OP24_LOGICAL_OR_XOR' => -207,
			'OP19_VARIABLE_ASSIGN' => -207,
			'OP13_BITWISE_AND' => -207,
			"}" => -207,
			'OP14_BITWISE_OR_XOR' => -207,
			'OP07_STRING_REPEAT' => -207,
			'OP06_REGEX_BIND' => -207,
			'OP11_COMPARE_LT_GT' => -207,
			'OP02_HASH_THINARROW' => 233,
			'OP23_LOGICAL_AND' => -207,
			'OP16_LOGICAL_OR' => -207,
			";" => -207,
			'OP08_MATH_ADD_SUB' => -207,
			")" => -207,
			'OP02_ARRAY_THINARROW' => 231,
			'OP20_HASH_FATARROW' => -207,
			'OP08_STRING_CAT' => -207,
			'OP15_LOGICAL_AND' => -207,
			"{" => 228,
			'OP02_METHOD_THINARROW' => -207,
			'OP04_MATH_POW' => -207,
			'OP18_TERNARY' => -207,
			'COLON' => -207,
			'OP07_MATH_MULT_DIV_MOD' => -207,
			'OP17_LIST_RANGE' => -207
		},
		GOTOS => {
			'VariableRetrievalArrow' => 338,
			'VariableRetrievalArray' => 340,
			'VariableRetrievalHash' => 339,
			'VariableRetrieval' => 407
		}
	},
	{#State 356
		DEFAULT => -199
	},
	{#State 357
		ACTIONS => {
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP11_COMPARE_LT_GT' => 217,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP08_MATH_ADD_SUB' => 214,
			"]" => 408,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210
		}
	},
	{#State 358
		ACTIONS => {
			'OP01_OPEN' => -248,
			'OP01_NAMED' => -248,
			'LITERAL_STRING' => -248,
			'HASH_SYMBOL_REF' => -248,
			'OP05_BITWISE_NEG_LPAREN' => -248,
			'ARRAY_SYMBOL_REF' => -248,
			'LBRACKET' => -248,
			'LPAREN' => -248,
			'OP03_MATH_INC_DEC' => -248,
			'WORD_SCOPED' => -248,
			'ARRAY_SYMBOL' => -248,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => -248,
			'OP01_CLOSE' => -248,
			"\@{" => -248,
			'OP10_NAMED_UNARY' => -248,
			'OP05_LOGICAL_NEG' => -248,
			'OP22_LOGICAL_NEG_LPAREN' => -248,
			'LITERAL_NUMBER' => -248,
			'WORD_UPPERCASE' => -248,
			'SELF' => -248,
			'OP22_LOGICAL_NEG' => -248,
			'WORD' => -248,
			'HASH_SYMBOL' => -248,
			'OP05_MATH_NEG_LPAREN' => -248,
			"%{" => -248,
			"undef" => -248,
			'SCALAR_SYMBOL' => -248,
			'LBRACE' => -248
		},
		GOTOS => {
			'TypeInner' => 409,
			'OPTIONAL-59' => 410
		}
	},
	{#State 359
		ACTIONS => {
			"}" => 413,
			'OP21_LIST_COMMA' => 412
		},
		GOTOS => {
			'PAREN-60' => 411
		}
	},
	{#State 360
		DEFAULT => -139
	},
	{#State 361
		DEFAULT => -143
	},
	{#State 362
		ACTIONS => {
			")" => 414
		}
	},
	{#State 363
		ACTIONS => {
			")" => 415
		}
	},
	{#State 364
		DEFAULT => -147
	},
	{#State 365
		ACTIONS => {
			'LBRACE' => 416
		}
	},
	{#State 366
		ACTIONS => {
			'SUB' => 418,
			'LITERAL_NUMBER' => 419
		},
		GOTOS => {
			'Subroutine' => 420,
			'Method' => 421,
			'SubroutineOrMethod' => 417
		}
	},
	{#State 367
		ACTIONS => {
			"}" => 422
		}
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 369
		DEFAULT => -55
	},
	{#State 370
		DEFAULT => -232
	},
	{#State 371
		ACTIONS => {
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'ARGV' => 169,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LPAREN' => 109,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LBRACKET' => 100
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'TypeInner' => 171,
			'HashDereference' => 141,
			'ListElement' => 424,
			'SubExpression' => 175,
			'Variable' => 177
		}
	},
	{#State 372
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 251,
			'OP12_COMPARE_EQ_NE' => 263,
			'OP11_COMPARE_LT_GT' => 250,
			'OP01_OPEN' => 248,
			'OP01_NAMED' => 262,
			'OP23_LOGICAL_AND' => 249,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP19_LOOP_CONTROL' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP01_NAMED_VOID' => 269,
			'WORD' => 258,
			'OP22_LOGICAL_NEG' => 271,
			'OP07_STRING_REPEAT' => 270,
			'OP01_PRINT' => 257,
			'OP24_LOGICAL_OR_XOR' => 267,
			'OP01_CLOSE' => 255,
			'OP10_NAMED_UNARY' => 256
		},
		GOTOS => {
			'OpStringOrWord' => 425
		}
	},
	{#State 373
		ACTIONS => {
			'OP21_LIST_COMMA' => 426
		}
	},
	{#State 374
		ACTIONS => {
			")" => 427
		}
	},
	{#State 375
		DEFAULT => -145
	},
	{#State 376
		DEFAULT => -228
	},
	{#State 377
		DEFAULT => -223
	},
	{#State 378
		ACTIONS => {
			'LBRACKET' => 100,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'LBRACE' => 151,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127
		},
		GOTOS => {
			'ArrayReference' => 114,
			'Literal' => 147,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'SubExpression' => 428,
			'HashDereference' => 141,
			'Variable' => 177,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156
		}
	},
	{#State 379
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'FHREF_SYMBOL_IN' => 295,
			'OP05_LOGICAL_NEG' => 149,
			'LBRACE' => 151,
			"undef" => 152,
			'OP22_LOGICAL_NEG' => 153,
			'ARRAY_SYMBOL_REF' => 133,
			'STDIN' => 296,
			'HASH_SYMBOL_REF' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 432,
			'OP01_NAMED' => 173,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED_SCOLON' => 429,
			'LPAREN' => 109
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'SubExpressionOrInput' => 431,
			'Literal' => 147,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'OpNamedScolonOrSubExpIn' => 430,
			'SubExpression' => 293,
			'HashDereference' => 141,
			'Variable' => 177
		}
	},
	{#State 380
		ACTIONS => {
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP10_NAMED_UNARY' => 116,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_NAMED_SCOLON' => 429,
			'LPAREN' => 109,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LBRACKET' => 100,
			'OP22_LOGICAL_NEG' => 153,
			"undef" => 152,
			'LBRACE' => 151,
			'OP05_LOGICAL_NEG' => 149,
			'FHREF_SYMBOL_IN' => 295,
			'LITERAL_NUMBER' => 146,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP10_NAMED_UNARY_SCOLON' => 432,
			'OP01_NAMED' => 173,
			'ARRAY_SYMBOL_REF' => 133,
			'STDIN' => 296,
			'HASH_SYMBOL_REF' => 135
		},
		GOTOS => {
			'Literal' => 147,
			'SubExpressionOrInput' => 431,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 293,
			'OpNamedScolonOrSubExpIn' => 433,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130
		}
	},
	{#State 381
		DEFAULT => -226
	},
	{#State 382
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'LBRACKET' => 100
		},
		GOTOS => {
			'Variable' => 177,
			'SubExpression' => 434,
			'HashDereference' => 141,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115
		}
	},
	{#State 383
		DEFAULT => -220
	},
	{#State 384
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LPAREN' => 109,
			'OP01_NAMED_SCOLON' => 429,
			'FHREF_SYMBOL_IN' => 295,
			'LITERAL_NUMBER' => 146,
			'OP05_LOGICAL_NEG' => 149,
			"undef" => 152,
			'LBRACE' => 151,
			'OP22_LOGICAL_NEG' => 153,
			'OP01_NAMED' => 173,
			'OP10_NAMED_UNARY_SCOLON' => 432,
			'STDIN' => 296,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Literal' => 147,
			'SubExpressionOrInput' => 431,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'Variable' => 177,
			'SubExpression' => 293,
			'HashDereference' => 141,
			'OpNamedScolonOrSubExpIn' => 435,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172
		}
	},
	{#State 385
		DEFAULT => -138
	},
	{#State 386
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACE' => 151,
			'ARGV' => 169,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP10_NAMED_UNARY' => 116,
			'OP01_QW' => 168,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'LBRACKET' => 100
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'HashDereference' => 141,
			'TypeInner' => 171,
			'ListElement' => 170,
			'SubExpression' => 175,
			'Variable' => 177,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ArrayReference' => 114,
			'ListElements' => 436,
			'Literal' => 147
		}
	},
	{#State 387
		ACTIONS => {
			")" => 437
		}
	},
	{#State 388
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 439
		}
	},
	{#State 389
		DEFAULT => -246
	},
	{#State 390
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'SCALAR_SYMBOL' => 123,
			'HASH_SYMBOL' => 127,
			'ARRAY_SYMBOL' => 142,
			'LITERAL_STRING' => 103,
			'SELF' => 129
		},
		GOTOS => {
			'Variable' => 322,
			'Literal' => 320,
			'VariableOrLiteral' => 440,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 391
		DEFAULT => -262
	},
	{#State 392
		DEFAULT => -136
	},
	{#State 393
		DEFAULT => -135
	},
	{#State 394
		DEFAULT => -215
	},
	{#State 395
		DEFAULT => -216
	},
	{#State 396
		DEFAULT => -200
	},
	{#State 397
		DEFAULT => -211
	},
	{#State 398
		DEFAULT => -196
	},
	{#State 399
		DEFAULT => -213
	},
	{#State 400
		DEFAULT => -212
	},
	{#State 401
		ACTIONS => {
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_MATH_ADD_SUB' => 214,
			")" => 441,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP11_COMPARE_LT_GT' => 217,
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206
		}
	},
	{#State 402
		ACTIONS => {
			'SCALAR_SYMBOL' => 442
		}
	},
	{#State 403
		ACTIONS => {
			'SCALAR_SYMBOL' => 443
		}
	},
	{#State 404
		ACTIONS => {
			'SCALAR_SYMBOL' => 444
		}
	},
	{#State 405
		ACTIONS => {
			'SCALAR_SYMBOL' => 445
		}
	},
	{#State 406
		ACTIONS => {
			";" => 446
		}
	},
	{#State 407
		DEFAULT => -198
	},
	{#State 408
		DEFAULT => -214
	},
	{#State 409
		DEFAULT => -247
	},
	{#State 410
		ACTIONS => {
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'SubExpression' => 447,
			'HashDereference' => 141,
			'Variable' => 177,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 411
		DEFAULT => -254
	},
	{#State 412
		ACTIONS => {
			'OP01_NAMED' => 262,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 248,
			'OP23_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 250,
			'ARRAY_SYMBOL' => 142,
			'OP12_COMPARE_EQ_NE' => 263,
			'OP08_MATH_ADD_SUB' => 251,
			'ENV' => 252,
			'OP01_CLOSE' => 255,
			'OP10_NAMED_UNARY' => 256,
			'OP24_LOGICAL_OR_XOR' => 267,
			'LITERAL_NUMBER' => 146,
			'OP01_NAMED_VOID' => 269,
			'SELF' => 129,
			'OP01_PRINT' => 257,
			'OP07_STRING_REPEAT' => 270,
			'WORD' => 258,
			'OP22_LOGICAL_NEG' => 271,
			'HASH_SYMBOL' => 127,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP19_LOOP_CONTROL' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'HashDereference' => 264,
			'VarOrLitOrOpStrOrWord' => 265,
			'HashEntry' => 448,
			'Literal' => 268,
			'OpStringOrWord' => 253,
			'Variable' => 254
		}
	},
	{#State 413
		DEFAULT => -256
	},
	{#State 414
		DEFAULT => -152
	},
	{#State 415
		DEFAULT => -154
	},
	{#State 416
		ACTIONS => {
			'OP01_NAMED' => 262,
			'OP01_OPEN' => 248,
			'OP23_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 250,
			'OP12_COMPARE_EQ_NE' => 263,
			'OP08_MATH_ADD_SUB' => 251,
			'OP01_CLOSE' => 255,
			'OP10_NAMED_UNARY' => 256,
			'OP24_LOGICAL_OR_XOR' => 267,
			'OP01_NAMED_VOID' => 269,
			'OP22_LOGICAL_NEG' => 271,
			'WORD' => 258,
			'OP07_STRING_REPEAT' => 270,
			'OP01_PRINT' => 257,
			"}" => 450,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP19_LOOP_CONTROL' => 261
		},
		GOTOS => {
			'OpStringOrWord' => 449,
			'HashEntryProperties' => 451
		}
	},
	{#State 417
		DEFAULT => -74
	},
	{#State 418
		ACTIONS => {
			'WORD' => 452
		}
	},
	{#State 419
		ACTIONS => {
			";" => 453
		}
	},
	{#State 420
		DEFAULT => -93
	},
	{#State 421
		DEFAULT => -94
	},
	{#State 422
		ACTIONS => {
			";" => 454
		}
	},
	{#State 423
		DEFAULT => -272
	},
	{#State 424
		DEFAULT => -231
	},
	{#State 425
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 455
		}
	},
	{#State 426
		ACTIONS => {
			'LITERAL_STRING' => 456
		}
	},
	{#State 427
		DEFAULT => -153
	},
	{#State 428
		ACTIONS => {
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			"]" => 457,
			'OP08_MATH_ADD_SUB' => 214,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 429
		DEFAULT => -285
	},
	{#State 430
		DEFAULT => -224
	},
	{#State 431
		ACTIONS => {
			";" => 458
		}
	},
	{#State 432
		DEFAULT => -286
	},
	{#State 433
		DEFAULT => -227
	},
	{#State 434
		ACTIONS => {
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			"]" => 459,
			'OP08_MATH_ADD_SUB' => 214,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217
		}
	},
	{#State 435
		DEFAULT => -221
	},
	{#State 436
		ACTIONS => {
			")" => 460
		}
	},
	{#State 437
		DEFAULT => -99
	},
	{#State 438
		ACTIONS => {
			'OP01_NAMED_VOID' => 155,
			'OP22_LOGICAL_NEG' => 153,
			"foreach" => -171,
			"undef" => 152,
			'LBRACE' => 151,
			'POD' => 150,
			'OP05_LOGICAL_NEG' => 149,
			"for" => -171,
			'LITERAL_NUMBER' => 146,
			'OP03_MATH_INC_DEC' => 145,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'WORD_UPPERCASE' => 128,
			'SELF' => 129,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP01_PRINT' => 125,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP19_LOOP_CONTROL' => 120,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			"if" => 113,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LPAREN' => 109,
			'OP01_NAMED_SCOLON' => 108,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'MY' => 106,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LBRACKET' => 100,
			"while" => -171
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 157,
			'PLUS-51' => 462,
			'SubExpression' => 122,
			'OperatorVoid' => 117,
			'Conditional' => 148,
			'ArrayDereference' => 115,
			'ArrayReference' => 114,
			'Statement' => 111,
			'PAREN-45' => 110,
			'Literal' => 147,
			'LoopLabel' => 143,
			'HashDereference' => 141,
			'VariableDeclaration' => 139,
			'Variable' => 105,
			'OPTIONAL-46' => 136,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'VariableModification' => 101,
			'Operation' => 461
		}
	},
	{#State 439
		DEFAULT => -180,
		GOTOS => {
			'STAR-48' => 463
		}
	},
	{#State 440
		DEFAULT => -125
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 464
		}
	},
	{#State 442
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 465
		}
	},
	{#State 443
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 466
		}
	},
	{#State 444
		ACTIONS => {
			'LPAREN' => 467
		}
	},
	{#State 445
		ACTIONS => {
			'LPAREN' => 468
		}
	},
	{#State 446
		DEFAULT => -140
	},
	{#State 447
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -249,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP21_LIST_COMMA' => -249,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_MATH_ADD_SUB' => 214
		}
	},
	{#State 448
		DEFAULT => -253
	},
	{#State 449
		ACTIONS => {
			'OP20_HASH_FATARROW' => 469
		}
	},
	{#State 450
		ACTIONS => {
			";" => 470
		}
	},
	{#State 451
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 471
		}
	},
	{#State 452
		ACTIONS => {
			'LBRACE' => 472
		}
	},
	{#State 453
		DEFAULT => -76
	},
	{#State 454
		ACTIONS => {
			'LITERAL_NUMBER' => -58,
			'POD' => -58,
			"for" => -58,
			'OP05_LOGICAL_NEG' => -58,
			'LBRACE' => -58,
			"}" => -58,
			"undef" => -58,
			'OP22_LOGICAL_NEG' => -58,
			"foreach" => -58,
			'OP01_NAMED_VOID' => -58,
			'HASH_SYMBOL_REF' => -58,
			'ARRAY_SYMBOL_REF' => -58,
			'OP01_NAMED' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'ARRAY_SYMBOL' => -58,
			'WORD_SCOPED' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			"if" => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP01_CLOSE' => -58,
			"\@{" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'OP19_LOOP_CONTROL' => -58,
			"%{" => -58,
			'SCALAR_SYMBOL' => -58,
			'HASH_SYMBOL' => -58,
			'LPAREN_MY' => 475,
			'WORD' => -58,
			'OP01_PRINT' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'SELF' => -58,
			'WORD_UPPERCASE' => -58,
			"while" => -58,
			'LBRACKET' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP01_OPEN' => -58,
			'LITERAL_STRING' => -58,
			'MY' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'LPAREN' => -58,
			'OP01_NAMED_SCOLON' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 474,
			'OPTIONAL-24' => 473
		}
	},
	{#State 455
		DEFAULT => -269
	},
	{#State 456
		ACTIONS => {
			'OP21_LIST_COMMA' => 476
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 477
		}
	},
	{#State 458
		DEFAULT => -287
	},
	{#State 459
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 478
		}
	},
	{#State 460
		DEFAULT => -101
	},
	{#State 461
		DEFAULT => -194
	},
	{#State 462
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP01_NAMED' => 138,
			'LBRACE' => 151,
			"}" => 479,
			"undef" => 152,
			"foreach" => -171,
			'OP22_LOGICAL_NEG' => 153,
			'OP01_NAMED_VOID' => 155,
			'LITERAL_NUMBER' => 146,
			'OP05_LOGICAL_NEG' => 149,
			"for" => -171,
			'POD' => 150,
			'MY' => 106,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'OP01_NAMED_SCOLON' => 108,
			'LPAREN' => 109,
			"while" => -171,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP19_LOOP_CONTROL' => 120,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP01_PRINT' => 125,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'WORD_UPPERCASE' => 128,
			'SELF' => 129,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"if" => 113,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119
		},
		GOTOS => {
			'SubExpression' => 122,
			'Operator' => 130,
			'Expression' => 157,
			'WordScoped' => 156,
			'ArrayReference' => 114,
			'Literal' => 147,
			'PAREN-45' => 110,
			'Statement' => 111,
			'OperatorVoid' => 117,
			'ArrayDereference' => 115,
			'Conditional' => 148,
			'HashDereference' => 141,
			'VariableDeclaration' => 139,
			'Variable' => 105,
			'LoopLabel' => 143,
			'VariableModification' => 101,
			'Operation' => 480,
			'OPTIONAL-46' => 136,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132
		}
	},
	{#State 463
		ACTIONS => {
			'POD' => -183,
			'OP05_LOGICAL_NEG' => -183,
			"for" => -183,
			'LITERAL_NUMBER' => -183,
			"else" => 485,
			'OP22_LOGICAL_NEG' => -183,
			"foreach" => -183,
			'OP01_NAMED_VOID' => -183,
			'LBRACE' => -183,
			"}" => -183,
			"undef" => -183,
			'HASH_SYMBOL_REF' => -183,
			'ARRAY_SYMBOL_REF' => -183,
			'OP01_NAMED' => -183,
			'OP10_NAMED_UNARY_SCOLON' => -183,
			'OP03_MATH_INC_DEC' => -183,
			'OP01_NAMED_VOID_SCOLON' => -183,
			'ARRAY_SYMBOL' => -183,
			'WORD_SCOPED' => -183,
			'CONSTANT_CALL_SCOPED' => -183,
			'OP10_NAMED_UNARY' => -183,
			'OP01_CLOSE' => -183,
			"\@{" => -183,
			'OP22_LOGICAL_NEG_LPAREN' => -183,
			"if" => -183,
			'HASH_SYMBOL' => -183,
			'WORD' => -183,
			'OP05_MATH_NEG_LPAREN' => -183,
			'OP01_PRINT' => -183,
			'SELF' => -183,
			'WORD_UPPERCASE' => -183,
			'OP19_LOOP_CONTROL_SCOLON' => -183,
			'OP19_LOOP_CONTROL' => -183,
			"elsif" => 481,
			"%{" => -183,
			'SCALAR_SYMBOL' => -183,
			'OP05_BITWISE_NEG_LPAREN' => -183,
			'LITERAL_STRING' => -183,
			'OP01_OPEN' => -183,
			'' => -183,
			"while" => -183,
			'LBRACKET' => -183,
			'LPAREN' => -183,
			'OP01_NAMED_SCOLON' => -183,
			'MY' => -183,
			'OP01_NAMED_VOID_LPAREN' => -183
		},
		GOTOS => {
			'OPTIONAL-50' => 482,
			'PAREN-49' => 483,
			'PAREN-47' => 484
		}
	},
	{#State 464
		DEFAULT => -191
	},
	{#State 465
		ACTIONS => {
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'FHREF_SYMBOL_IN' => 295,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'LBRACE' => 151,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'STDIN' => 296,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ArrayReference' => 114,
			'SubExpressionOrInput' => 486,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'Variable' => 177,
			'HashDereference' => 141,
			'SubExpression' => 293
		}
	},
	{#State 466
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 490,
			'LPAREN' => 109,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP10_NAMED_UNARY_SCOLON' => 487,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LBRACKET' => 100,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			'LBRACE' => 151,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'OpNamedScolonOrSubExp' => 489,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'SubExpression' => 488,
			'HashDereference' => 141,
			'Variable' => 177
		}
	},
	{#State 467
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LBRACKET' => 100,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109
		},
		GOTOS => {
			'Literal' => 147,
			'ArrayReference' => 114,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Variable' => 177,
			'SubExpression' => 491,
			'HashDereference' => 141,
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130
		}
	},
	{#State 468
		ACTIONS => {
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_QW' => 168,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'LBRACE' => 151,
			'ARGV' => 169,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'LITERAL_STRING' => 103,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'MY' => 178,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109
		},
		GOTOS => {
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'Variable' => 177,
			'SubExpression' => 175,
			'TypeInner' => 171,
			'ListElement' => 170,
			'HashDereference' => 141,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'Literal' => 147,
			'ListElements' => 492,
			'ArrayReference' => 114
		}
	},
	{#State 469
		ACTIONS => {
			'MY' => 493
		},
		GOTOS => {
			'TypeInnerProperties' => 494
		}
	},
	{#State 470
		DEFAULT => -83
	},
	{#State 471
		ACTIONS => {
			"}" => 495,
			'OP21_LIST_COMMA' => 496
		},
		GOTOS => {
			'PAREN-33' => 497
		}
	},
	{#State 472
		ACTIONS => {
			'LBRACE' => 498
		}
	},
	{#State 473
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 499
		}
	},
	{#State 474
		DEFAULT => -57
	},
	{#State 475
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'WORD' => 165,
			'WORD_SCOPED' => 164
		},
		GOTOS => {
			'Type' => 500
		}
	},
	{#State 476
		ACTIONS => {
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'LBRACE' => 151,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'LBRACKET' => 100
		},
		GOTOS => {
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147,
			'Operator' => 130,
			'Expression' => 172,
			'WordScoped' => 156,
			'SubExpression' => 501,
			'HashDereference' => 141,
			'Variable' => 177
		}
	},
	{#State 477
		ACTIONS => {
			"undef" => 502
		}
	},
	{#State 478
		ACTIONS => {
			"undef" => 503
		}
	},
	{#State 479
		DEFAULT => -195
	},
	{#State 480
		DEFAULT => -193
	},
	{#State 481
		ACTIONS => {
			'LPAREN' => 504
		}
	},
	{#State 482
		DEFAULT => -184
	},
	{#State 483
		DEFAULT => -182
	},
	{#State 484
		DEFAULT => -179
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 505
		}
	},
	{#State 486
		ACTIONS => {
			")" => 506
		}
	},
	{#State 487
		DEFAULT => -283
	},
	{#State 488
		ACTIONS => {
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			";" => 507,
			'OP08_MATH_ADD_SUB' => 214,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219
		}
	},
	{#State 489
		ACTIONS => {
			'SCALAR_SYMBOL' => 508
		}
	},
	{#State 490
		DEFAULT => -282
	},
	{#State 491
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP08_MATH_ADD_SUB' => 214,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP17_LIST_RANGE' => 509,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205
		}
	},
	{#State 492
		ACTIONS => {
			")" => 510
		}
	},
	{#State 493
		ACTIONS => {
			'WORD_SCOPED' => 164,
			'WORD' => 165,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 511
		}
	},
	{#State 494
		DEFAULT => -252
	},
	{#State 495
		ACTIONS => {
			";" => 512
		}
	},
	{#State 496
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 271,
			'WORD' => 258,
			'OP01_PRINT' => 257,
			'OP07_STRING_REPEAT' => 270,
			'OP01_NAMED_VOID' => 269,
			'OP19_LOOP_CONTROL' => 261,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP10_NAMED_UNARY' => 256,
			'OP01_CLOSE' => 255,
			'OP24_LOGICAL_OR_XOR' => 267,
			'OP12_COMPARE_EQ_NE' => 263,
			'OP08_MATH_ADD_SUB' => 251,
			'OP23_LOGICAL_AND' => 249,
			'OP01_NAMED' => 262,
			'OP01_OPEN' => 248,
			'OP11_COMPARE_LT_GT' => 250
		},
		GOTOS => {
			'HashEntryProperties' => 513,
			'OpStringOrWord' => 449
		}
	},
	{#State 497
		DEFAULT => -80
	},
	{#State 498
		ACTIONS => {
			'MY' => 514
		}
	},
	{#State 499
		ACTIONS => {
			'POD' => 150,
			'OP05_LOGICAL_NEG' => 149,
			"for" => -171,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG' => 153,
			"foreach" => -171,
			'OP01_NAMED_VOID' => 155,
			'LBRACE' => 151,
			"}" => 516,
			"undef" => 152,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP10_NAMED_UNARY' => 116,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"if" => 113,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'OP01_PRINT' => 125,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SELF' => 129,
			'WORD_UPPERCASE' => 128,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP19_LOOP_CONTROL' => 120,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"while" => -171,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP01_NAMED_SCOLON' => 108,
			'MY' => 106,
			'OP01_NAMED_VOID_LPAREN' => 107
		},
		GOTOS => {
			'VariableDeclaration' => 139,
			'Variable' => 105,
			'HashDereference' => 141,
			'LoopLabel' => 143,
			'Operation' => 515,
			'VariableModification' => 101,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-46' => 136,
			'SubExpression' => 122,
			'Operator' => 130,
			'Expression' => 157,
			'WordScoped' => 156,
			'Literal' => 147,
			'PAREN-45' => 110,
			'Statement' => 111,
			'ArrayReference' => 114,
			'ArrayDereference' => 115,
			'Conditional' => 148,
			'OperatorVoid' => 117
		}
	},
	{#State 500
		ACTIONS => {
			'SCALAR_SYMBOL' => 517
		}
	},
	{#State 501
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP08_MATH_ADD_SUB' => 214,
			";" => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			"}" => -102,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204
		}
	},
	{#State 502
		ACTIONS => {
			";" => 518
		}
	},
	{#State 503
		ACTIONS => {
			";" => 519
		}
	},
	{#State 504
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'LPAREN' => 109,
			'LBRACKET' => 100,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'LBRACE' => 151,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 118,
			'OP01_CLOSE' => 119
		},
		GOTOS => {
			'WordScoped' => 156,
			'Expression' => 172,
			'Operator' => 130,
			'HashDereference' => 141,
			'SubExpression' => 520,
			'Variable' => 177,
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 505
		DEFAULT => -181
	},
	{#State 506
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 521
		}
	},
	{#State 507
		DEFAULT => -284
	},
	{#State 508
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 522
		}
	},
	{#State 509
		ACTIONS => {
			'LBRACKET' => 100,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126
		},
		GOTOS => {
			'ScalarSymbolOrSelf' => 132,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'Literal' => 147,
			'ArrayReference' => 114,
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'Variable' => 177,
			'SubExpression' => 523,
			'HashDereference' => 141
		}
	},
	{#State 510
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 524
		}
	},
	{#State 511
		ACTIONS => {
			"\$TYPED_" => 525
		}
	},
	{#State 512
		DEFAULT => -82
	},
	{#State 513
		DEFAULT => -79
	},
	{#State 514
		ACTIONS => {
			'WORD_SCOPED' => 164,
			'WORD' => 165,
			'TYPE_METHOD' => 526,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 282
		}
	},
	{#State 515
		DEFAULT => -59
	},
	{#State 516
		DEFAULT => -61
	},
	{#State 517
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 527
		}
	},
	{#State 518
		DEFAULT => -225
	},
	{#State 519
		DEFAULT => -222
	},
	{#State 520
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP18_TERNARY' => 211,
			'OP04_MATH_POW' => 210,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP17_LIST_RANGE' => 213,
			'OP07_STRING_REPEAT' => 204,
			'OP06_REGEX_BIND' => 205,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			")" => 528,
			'OP08_MATH_ADD_SUB' => 214,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216
		}
	},
	{#State 521
		DEFAULT => -192
	},
	{#State 522
		ACTIONS => {
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			"%{" => 124,
			"undef" => 152,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP05_LOGICAL_NEG' => 149,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 146,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'OP01_NAMED_SCOLON' => 490,
			'LPAREN' => 109,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP03_MATH_INC_DEC' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP10_NAMED_UNARY_SCOLON' => 487,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'HASH_SYMBOL_REF' => 135,
			'LBRACKET' => 100
		},
		GOTOS => {
			'WordScoped' => 156,
			'Operator' => 130,
			'Expression' => 172,
			'SubExpression' => 488,
			'HashDereference' => 141,
			'Variable' => 177,
			'OpNamedScolonOrSubExp' => 529,
			'ScalarSymbolOrSelf' => 132,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 523
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => -124,
			")" => 530,
			'OP08_MATH_ADD_SUB' => 214,
			'OP09_BITWISE_SHIFT' => 209,
			'OP15_LOGICAL_AND' => 216,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP08_STRING_CAT' => 215,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP13_BITWISE_AND' => 207,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP18_TERNARY' => -124,
			'OP04_MATH_POW' => 210,
			'OP06_REGEX_BIND' => 205,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 204
		}
	},
	{#State 524
		DEFAULT => -190
	},
	{#State 525
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 263,
			'OP08_MATH_ADD_SUB' => 251,
			'OP01_OPEN' => 248,
			'OP01_NAMED' => 262,
			'OP23_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 250,
			'OP01_NAMED_VOID' => 269,
			'OP07_STRING_REPEAT' => 270,
			'OP01_PRINT' => 257,
			'WORD' => 258,
			'OP22_LOGICAL_NEG' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP19_LOOP_CONTROL_SCOLON' => 260,
			'OP19_LOOP_CONTROL' => 261,
			'OP01_CLOSE' => 255,
			'OP10_NAMED_UNARY' => 256,
			'OP24_LOGICAL_OR_XOR' => 267
		},
		GOTOS => {
			'OpStringOrWord' => 531
		}
	},
	{#State 526
		ACTIONS => {
			"\$RETURN_TYPE" => 532
		}
	},
	{#State 527
		ACTIONS => {
			'OP21_LIST_COMMA' => 534,
			")" => 535
		},
		GOTOS => {
			'PAREN-26' => 533
		}
	},
	{#State 528
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 536
		}
	},
	{#State 529
		ACTIONS => {
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 153,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			'SCALAR_SYMBOL' => 123,
			"undef" => 152,
			"%{" => 124,
			'LBRACE' => 151,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'ARRAY_SYMBOL' => 142,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'Literal' => 147,
			'VariableModification' => 538,
			'SubExpressionOrVarMod' => 539,
			'ArrayReference' => 114,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'Variable' => 105,
			'SubExpression' => 537,
			'HashDereference' => 141,
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156
		}
	},
	{#State 530
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 540
		}
	},
	{#State 531
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 542,
			'OP02_ARRAY_THINARROW' => 541
		}
	},
	{#State 532
		ACTIONS => {
			"}" => 543
		}
	},
	{#State 533
		DEFAULT => -63
	},
	{#State 534
		ACTIONS => {
			'MY' => 544
		}
	},
	{#State 535
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 545
		}
	},
	{#State 536
		DEFAULT => -178
	},
	{#State 537
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP11_COMPARE_LT_GT' => 217,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP08_MATH_ADD_SUB' => 214,
			")" => -167,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209
		}
	},
	{#State 538
		DEFAULT => -168
	},
	{#State 539
		ACTIONS => {
			")" => 546
		}
	},
	{#State 540
		DEFAULT => -188
	},
	{#State 541
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'LBRACE' => 151,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			"undef" => 152,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP22_LOGICAL_NEG' => 153,
			'OP05_MATH_NEG_LPAREN' => 126,
			'WORD_UPPERCASE' => 176,
			'SELF' => 129,
			'LBRACKET' => 100,
			'HASH_SYMBOL_REF' => 135,
			'ARRAY_SYMBOL_REF' => 133,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED' => 173,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'LPAREN' => 109
		},
		GOTOS => {
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 547,
			'Variable' => 177,
			'ArrayDereference' => 115,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 542
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 173,
			'HASH_SYMBOL_REF' => 135,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'ARRAY_SYMBOL_REF' => 133,
			'LBRACKET' => 100,
			'LPAREN' => 109,
			'OP03_MATH_INC_DEC' => 145,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP01_CLOSE' => 119,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 116,
			'OP05_LOGICAL_NEG' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			'LITERAL_NUMBER' => 146,
			'SELF' => 129,
			'WORD_UPPERCASE' => 176,
			'OP22_LOGICAL_NEG' => 153,
			'WORD' => 26,
			'HASH_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 126,
			"undef" => 152,
			"%{" => 124,
			'SCALAR_SYMBOL' => 123,
			'LBRACE' => 151
		},
		GOTOS => {
			'Expression' => 172,
			'Operator' => 130,
			'WordScoped' => 156,
			'HashDereference' => 141,
			'SubExpression' => 548,
			'Variable' => 177,
			'HashReference' => 134,
			'ArrayDereference' => 115,
			'ScalarSymbolOrSelf' => 132,
			'ArrayReference' => 114,
			'Literal' => 147
		}
	},
	{#State 543
		ACTIONS => {
			";" => 549
		}
	},
	{#State 544
		ACTIONS => {
			'WORD_SCOPED' => 164,
			'WORD' => 165,
			'TYPE_INTEGER' => 166
		},
		GOTOS => {
			'Type' => 550
		}
	},
	{#State 545
		ACTIONS => {
			"\@ARG;" => 551
		}
	},
	{#State 546
		ACTIONS => {
			'LBRACE' => 438
		},
		GOTOS => {
			'CodeBlock' => 552
		}
	},
	{#State 547
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP13_BITWISE_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP14_BITWISE_OR_XOR' => 203,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP06_REGEX_BIND' => 205,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP11_COMPARE_LT_GT' => 217,
			'OP16_LOGICAL_OR' => 219,
			'OP23_LOGICAL_AND' => 218,
			'OP08_MATH_ADD_SUB' => 214,
			"]" => 553,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208
		}
	},
	{#State 548
		ACTIONS => {
			'OP13_BITWISE_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 206,
			'OP07_STRING_REPEAT' => 204,
			'OP17_LIST_RANGE' => 213,
			'OP06_REGEX_BIND' => 205,
			'OP04_MATH_POW' => 210,
			'OP18_TERNARY' => 211,
			'OP14_BITWISE_OR_XOR' => 203,
			"}" => -270,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP23_LOGICAL_AND' => 218,
			'OP16_LOGICAL_OR' => 219,
			'OP11_COMPARE_LT_GT' => 217,
			'OP21_LIST_COMMA' => -270,
			'OP08_STRING_CAT' => 215,
			'OP12_COMPARE_EQ_NE' => 208,
			'OP15_LOGICAL_AND' => 216,
			'OP09_BITWISE_SHIFT' => 209,
			'OP08_MATH_ADD_SUB' => 214
		}
	},
	{#State 549
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP19_LOOP_CONTROL' => -85,
			"%{" => -85,
			'SCALAR_SYMBOL' => -85,
			'WORD' => -85,
			'LPAREN_MY' => 555,
			'HASH_SYMBOL' => -85,
			'OP01_PRINT' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'WORD_UPPERCASE' => -85,
			'SELF' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			"if" => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP01_CLOSE' => -85,
			"\@{" => -85,
			'MY' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'LPAREN' => -85,
			'OP01_NAMED_SCOLON' => -85,
			"while" => -85,
			'LBRACKET' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'LITERAL_STRING' => -85,
			'OP01_OPEN' => -85,
			'LBRACE' => -85,
			"}" => -85,
			"undef" => -85,
			'OP22_LOGICAL_NEG' => -85,
			"foreach" => -85,
			'OP01_NAMED_VOID' => -85,
			'LITERAL_NUMBER' => -85,
			'POD' => -85,
			"for" => -85,
			'OP05_LOGICAL_NEG' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'ARRAY_SYMBOL' => -85,
			'WORD_SCOPED' => -85,
			'HASH_SYMBOL_REF' => -85,
			'ARRAY_SYMBOL_REF' => -85,
			'OP01_NAMED' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 556,
			'MethodArguments' => 554
		}
	},
	{#State 550
		ACTIONS => {
			'SCALAR_SYMBOL' => 557
		}
	},
	{#State 551
		DEFAULT => -65
	},
	{#State 552
		DEFAULT => -189
	},
	{#State 553
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 558
		}
	},
	{#State 554
		DEFAULT => -84
	},
	{#State 555
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'WORD' => 165,
			'WORD_SCOPED' => 164
		},
		GOTOS => {
			'Type' => 559
		}
	},
	{#State 556
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 560
		}
	},
	{#State 557
		DEFAULT => -62
	},
	{#State 558
		ACTIONS => {
			"undef" => 561
		}
	},
	{#State 559
		ACTIONS => {
			'SELF' => 562
		}
	},
	{#State 560
		ACTIONS => {
			"if" => 113,
			'OP22_LOGICAL_NEG_LPAREN' => 112,
			"\@{" => 118,
			'OP01_CLOSE' => 119,
			'OP10_NAMED_UNARY' => 116,
			'SCALAR_SYMBOL' => 123,
			"%{" => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP19_LOOP_CONTROL' => 120,
			'SELF' => 129,
			'WORD_UPPERCASE' => 128,
			'OP05_MATH_NEG_LPAREN' => 126,
			'OP01_PRINT' => 125,
			'HASH_SYMBOL' => 127,
			'WORD' => 26,
			'LBRACKET' => 100,
			"while" => -171,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 102,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'MY' => 106,
			'OP01_NAMED_SCOLON' => 108,
			'LPAREN' => 109,
			'LITERAL_NUMBER' => 146,
			"for" => -171,
			'OP05_LOGICAL_NEG' => 149,
			'POD' => 150,
			"}" => 563,
			"undef" => 152,
			'LBRACE' => 151,
			'OP01_NAMED_VOID' => 155,
			"foreach" => -171,
			'OP22_LOGICAL_NEG' => 153,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP01_NAMED' => 138,
			'ARRAY_SYMBOL_REF' => 133,
			'HASH_SYMBOL_REF' => 135,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 27,
			'ARRAY_SYMBOL' => 142,
			'OP01_NAMED_VOID_SCOLON' => 144,
			'OP03_MATH_INC_DEC' => 145
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Conditional' => 148,
			'OperatorVoid' => 117,
			'Literal' => 147,
			'Statement' => 111,
			'PAREN-45' => 110,
			'ArrayReference' => 114,
			'Expression' => 157,
			'Operator' => 130,
			'WordScoped' => 156,
			'SubExpression' => 122,
			'HashReference' => 134,
			'ScalarSymbolOrSelf' => 132,
			'OPTIONAL-46' => 136,
			'Operation' => 564,
			'VariableModification' => 101,
			'LoopLabel' => 143,
			'Variable' => 105,
			'VariableDeclaration' => 139,
			'HashDereference' => 141
		}
	},
	{#State 561
		DEFAULT => -271
	},
	{#State 562
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 565
		}
	},
	{#State 563
		DEFAULT => -88
	},
	{#State 564
		DEFAULT => -86
	},
	{#State 565
		ACTIONS => {
			'OP21_LIST_COMMA' => 566,
			")" => 568
		},
		GOTOS => {
			'PAREN-37' => 567
		}
	},
	{#State 566
		ACTIONS => {
			'MY' => 569
		}
	},
	{#State 567
		DEFAULT => -90
	},
	{#State 568
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 570
		}
	},
	{#State 569
		ACTIONS => {
			'TYPE_INTEGER' => 166,
			'WORD_SCOPED' => 164,
			'WORD' => 165
		},
		GOTOS => {
			'Type' => 571
		}
	},
	{#State 570
		ACTIONS => {
			"\@ARG;" => 572
		}
	},
	{#State 571
		ACTIONS => {
			'SCALAR_SYMBOL' => 573
		}
	},
	{#State 572
		DEFAULT => -92
	},
	{#State 573
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 8491 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8498 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8505 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8512 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8523 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8548 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8555 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8562 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8569 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8576 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8583 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8590 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8597 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8604 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8611 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8618 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8643 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8657 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8668 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8679 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8690 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8697 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8704 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8711 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8718 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8725 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8732 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8739 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8746 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8753 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8760 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8778 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8785 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8796 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8803 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8810 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8821 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8828 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8835 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8842 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8849 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8856 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8863 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8874 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8881 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8888 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8895 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8902 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8913 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8924 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8935 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8942 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8949 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8956 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 213 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8963 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8974 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8981 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8988 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8995 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9020 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9027 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9034 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9041 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9048 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9062 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9069 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9076 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9087 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9098 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9109 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9116 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9130 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9141 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9152 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9159 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9173 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9180 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9191 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9198 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9205 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9212 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9223 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9234 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9245 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9256 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9267 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9278 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9289 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9300 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9311 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9322 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9509 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9520 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9531 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9542 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9553 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9564 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9575 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9586 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9597 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9608 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9619 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9630 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9637 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9644 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9651 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9665 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9676 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9687 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9698 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9709 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9720 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9731 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9742 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9753 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9760 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9767 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9774 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9781 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9788 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9795 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9806 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9817 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9828 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9839 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9850 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9861 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9872 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9883 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9894 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9905 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9916 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9927 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9938 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9949 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9960 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9971 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9982 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9993 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10004 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_168
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10015 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10022 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10029 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10036 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10047 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10058 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10069 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10080 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10091 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_177
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10102 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10109 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10116 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10123 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10130 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10137 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10144 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_184
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10155 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10166 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_186
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10177 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_187
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10188 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_188
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10199 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_189
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10210 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_190
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10221 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_191
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10232 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_192
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10243 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10250 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10257 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_195
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10268 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 2,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10275 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-52', 1,
sub {
#line 267 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10282 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 268 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10289 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 268 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10296 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 269 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10303 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 269 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10310 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_202
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10321 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_203
		 'Variable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10332 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_204
		 'Variable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10343 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_205
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10354 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_206
		 'Variable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10365 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_207
		 'Variable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10376 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_208
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10387 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_209
		 'Variable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10398 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_210
		 'Variable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10409 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_211
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10420 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_212
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10431 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_213
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10442 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArray_214
		 'VariableRetrievalArray', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10453 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalHash_215
		 'VariableRetrievalHash', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10464 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalHash_216
		 'VariableRetrievalHash', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10475 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_217
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10486 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_218
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10497 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_219
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10508 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_220
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10519 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_221
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10530 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_222
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10541 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_223
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10552 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_224
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10563 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_225
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10574 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_226
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10585 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_227
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10596 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_228
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10607 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_229
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10618 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_230
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10629 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 281 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 281 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10643 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 281 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10650 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_234
		 'ListElements', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10661 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_235
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10672 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_236
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10683 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_237
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10694 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_238
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10705 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 283 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10712 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 283 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10719 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_241
		 'ArrayReference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10730 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_242
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 1,
sub {
#line 284 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10748 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-58', 0,
sub {
#line 284 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10755 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_245
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10766 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_246
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 285 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 285 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10791 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_249
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10802 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_250
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10813 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_251
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10824 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_252
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10835 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 287 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10842 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 287 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10849 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 287 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10856 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_256
		 'HashReference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10867 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_257
		 'HashReference', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10878 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_258
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10889 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-62', 1,
sub {
#line 288 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10896 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-62', 0,
sub {
#line 288 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10903 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_261
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10914 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_262
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10925 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_263
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10936 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_264
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10947 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_265
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10958 lib/RPerl/Grammar.pm
	],
	[#Rule Type_266
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10969 lib/RPerl/Grammar.pm
	],
	[#Rule Type_267
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10980 lib/RPerl/Grammar.pm
	],
	[#Rule Type_268
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10991 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_269
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11002 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_270
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11013 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_271
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11024 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_272
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11035 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_273
		 'VariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11046 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_274
		 'VariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11057 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_275
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11068 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_276
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11079 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_277
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11090 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarSymbolOrSelf_278
		 'ScalarSymbolOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11101 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarSymbolOrSelf_279
		 'ScalarSymbolOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11112 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_280
		 'Literal', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11123 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_281
		 'Literal', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11134 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_282
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11145 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_283
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11156 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_284
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11167 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_285
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11178 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_286
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11189 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_287
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11200 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_288
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11211 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_289
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11222 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_290
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11233 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_291
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11244 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_292
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11255 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_293
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11266 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_294
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11277 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_295
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11288 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_296
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11299 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_297
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11310 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_298
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11321 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_299
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11332 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_300
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11343 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_301
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11354 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_302
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11365 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_303
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11376 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_304
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11387 lib/RPerl/Grammar.pm
	]
],
#line 11390 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Variable_202', 
         'Variable_203', 
         'Variable_204', 
         'Variable_205', 
         'Variable_206', 
         'Variable_207', 
         'Variable_208', 
         'Variable_209', 
         'Variable_210', 
         'VariableRetrievalArrow_211', 
         'VariableRetrievalArrow_212', 
         'VariableRetrievalArrow_213', 
         'VariableRetrievalArray_214', 
         'VariableRetrievalHash_215', 
         'VariableRetrievalHash_216', 
         'VariableRetrieval_217', 
         'VariableRetrieval_218', 
         'VariableRetrieval_219', 
         'VariableDeclaration_220', 
         'VariableDeclaration_221', 
         'VariableDeclaration_222', 
         'VariableDeclaration_223', 
         'VariableDeclaration_224', 
         'VariableDeclaration_225', 
         'VariableDeclaration_226', 
         'VariableDeclaration_227', 
         'VariableDeclaration_228', 
         'VariableModification_229', 
         'VariableModification_230', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_234', 
         'ListElement_235', 
         'ListElement_236', 
         'ListElement_237', 
         'ListElement_238', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_241', 
         'ArrayReference_242', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_245', 
         'ArrayDereference_246', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_249', 
         'HashEntry_250', 
         'HashEntry_251', 
         'HashEntryProperties_252', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_256', 
         'HashReference_257', 
         'HashReference_258', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_261', 
         'HashDereference_262', 
         'WordScoped_263', 
         'WordScoped_264', 
         'LoopLabel_265', 
         'Type_266', 
         'Type_267', 
         'Type_268', 
         'TypeInner_269', 
         'TypeInnerProperties_270', 
         'TypeInnerProperties_271', 
         'TypeInnerConstant_272', 
         'VariableOrLiteral_273', 
         'VariableOrLiteral_274', 
         'VarOrLitOrOpStrOrWord_275', 
         'VarOrLitOrOpStrOrWord_276', 
         'VarOrLitOrOpStrOrWord_277', 
         'ScalarSymbolOrSelf_278', 
         'ScalarSymbolOrSelf_279', 
         'Literal_280', 
         'Literal_281', 
         'OpNamedScolonOrSubExp_282', 
         'OpNamedScolonOrSubExp_283', 
         'OpNamedScolonOrSubExp_284', 
         'OpNamedScolonOrSubExpIn_285', 
         'OpNamedScolonOrSubExpIn_286', 
         'OpNamedScolonOrSubExpIn_287', 
         'OpStringOrWord_288', 
         'OpStringOrWord_289', 
         'OpStringOrWord_290', 
         'OpStringOrWord_291', 
         'OpStringOrWord_292', 
         'OpStringOrWord_293', 
         'OpStringOrWord_294', 
         'OpStringOrWord_295', 
         'OpStringOrWord_296', 
         'OpStringOrWord_297', 
         'OpStringOrWord_298', 
         'OpStringOrWord_299', 
         'OpStringOrWord_300', 
         'OpStringOrWord_301', 
         'OpStringOrWord_302', 
         'OpStringOrWord_303', 
         'OpStringOrWord_304', );
  $self;
}

#line 309 "lib/RPerl/Grammar.eyp"


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
Variable_198 => 'RPerl::Operation::Expression::SubExpression::Variable',                           # Variable -> ScalarSymbolOrSelf STAR-50
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
ScalarSymbolOrSelf_253 => 'RPerl::NonGenerator',                                                   # ScalarSymbolOrSelf -> SCALAR_SYMBOL
ScalarSymbolOrSelf_254 => 'RPerl::NonGenerator',                                                   # ScalarSymbolOrSelf -> SELF
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


#line 11911 lib/RPerl/Grammar.pm



1;
