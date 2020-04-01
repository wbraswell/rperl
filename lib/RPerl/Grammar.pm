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

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|\$TYPED_|package|foreach|undef|elsif|while|\@ARG\;|else|INIT|for|if|\@\{|\%\{|\}|\;|\]|\))}gc and return ($1, $1);

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
      /\G(\(\s*my\s+(?:[a-z_]\w*|[A-Z]\w*[a-z]\w*|(?:[a-zA-Z_]\w*)?(?:::[a-zA-Z_]\w*)+|integer|unsigned_integer)\s+\$TYPED_)/gc and return ('LPAREN_TYPE_INNER', $1);
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


#line 162 lib/RPerl/Grammar.pm

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
  [ 'Operator_125' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'ScalarVariableOrLiteral', 'COLON', 'ScalarVariableOrLiteral' ], 0 ],
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
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'SubExpressions_169' => 'SubExpressions', [ 'SubExpression', 'STAR-46' ], 0 ],
  [ 'SubExpressionOrInput_170' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_171' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_172' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_173' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_174' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Statement_178' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_179' => 'Statement', [ 'OPTIONAL-48', 'Loop' ], 0 ],
  [ 'Statement_180' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_181' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_182' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ 'Statement_183' => 'Statement', [ 'POD' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'PAREN-51' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'Conditional_190' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-50', 'OPTIONAL-52' ], 0 ],
  [ 'Loop_191' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_192' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_193' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_194' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_195' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'SCALAR_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_196' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpressions', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_197' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_198' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'Operation' ], 0 ],
  [ 'CodeBlock_201' => 'CodeBlock', [ 'LBRACE', 'PLUS-53', '}' ], 0 ],
  [ 'Variable_202' => 'Variable', [ 'ScalarVariable' ], 0 ],
  [ 'Variable_203' => 'Variable', [ 'ArrayVariable' ], 0 ],
  [ 'Variable_204' => 'Variable', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'Variable_205' => 'Variable', [ 'HashVariable' ], 0 ],
  [ 'Variable_206' => 'Variable', [ 'HashReferenceVariable' ], 0 ],
  [ 'VariableRetrievalArrow_207' => 'VariableRetrievalArrow', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalArrow_208' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalArrow_209' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableRetrieval_210' => 'VariableRetrieval', [ 'VariableRetrievalArrow' ], 0 ],
  [ 'VariableRetrieval_211' => 'VariableRetrieval', [ 'LBRACKET', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_212' => 'VariableRetrieval', [ 'LBRACE', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_213' => 'VariableRetrieval', [ 'LBRACE', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_214' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_215' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_216' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_217' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_218' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_219' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_220' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_221' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_222' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_223' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ 'Scalar_224' => 'Scalar', [ 'ScalarLiteral' ], 0 ],
  [ 'Scalar_225' => 'Scalar', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarLiteral_226' => 'ScalarLiteral', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'ScalarLiteral_227' => 'ScalarLiteral', [ 'LITERAL_STRING' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'PLUS-54', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'VariableRetrieval' ], 0 ],
  [ 'ScalarVariable_230' => 'ScalarVariable', [ 'ScalarVariableOrSelf' ], 0 ],
  [ 'ScalarVariable_231' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow' ], 0 ],
  [ 'ScalarVariable_232' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow', 'PLUS-54' ], 0 ],
  [ 'ScalarVariableOrSelf_233' => 'ScalarVariableOrSelf', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarVariableOrSelf_234' => 'ScalarVariableOrSelf', [ 'SELF' ], 0 ],
  [ 'ArrayHashLiteral_235' => 'ArrayHashLiteral', [ 'LPAREN', 'ArrayHashLiteralEs', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ArrayHashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'ArrayHashLiteralEs_239' => 'ArrayHashLiteralEs', [ 'ArrayHashLiteralE', 'STAR-56' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ArrayLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'ArrayLiteralEs_243' => 'ArrayLiteralEs', [ 'ArrayLiteralE', 'STAR-58' ], 0 ],
  [ '_PAREN' => 'PAREN-59', [ 'OP21_LIST_COMMA', 'HashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [ 'STAR-60', 'PAREN-59' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [  ], 0 ],
  [ 'HashLiteralEs_247' => 'HashLiteralEs', [ 'HashLiteralE', 'STAR-60' ], 0 ],
  [ 'ArrayLiteralE_248' => 'ArrayLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayLiteralE_249' => 'ArrayLiteralE', [ 'ListElement' ], 0 ],
  [ 'HashLiteralE_250' => 'HashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'HashLiteralE_251' => 'HashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralE_252' => 'ArrayHashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayHashLiteralE_253' => 'ArrayHashLiteralE', [ 'ListElement' ], 0 ],
  [ 'ArrayHashLiteralE_254' => 'ArrayHashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralEmpty_255' => 'ArrayHashLiteralEmpty', [ 'LPAREN', ')' ], 0 ],
  [ 'BracketsEmpty_256' => 'BracketsEmpty', [ 'LBRACKET', ']' ], 0 ],
  [ 'BracesEmpty_257' => 'BracesEmpty', [ 'LBRACE', '}' ], 0 ],
  [ 'ListElement_258' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_259' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_260' => 'ListElement', [ 'ARGV' ], 0 ],
  [ 'Array_261' => 'Array', [ 'ArrayLiteralNonEmpty' ], 0 ],
  [ 'Array_262' => 'Array', [ 'ArrayVariable' ], 0 ],
  [ '_PAREN' => 'PAREN-61', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [ 'STAR-62', 'PAREN-61' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [  ], 0 ],
  [ 'ArrayLiteralNonEmpty_266' => 'ArrayLiteralNonEmpty', [ 'LPAREN_TYPE_INNER', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression', 'STAR-62', ')' ], 0 ],
  [ 'ArrayVariable_267' => 'ArrayVariable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'ArrayReference_268' => 'ArrayReference', [ 'ArrayReferenceLiteral' ], 0 ],
  [ 'ArrayReference_269' => 'ArrayReference', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'ArrayReferenceLiteral_270' => 'ArrayReferenceLiteral', [ 'LBRACKET', 'ArrayLiteralEs', ']' ], 0 ],
  [ 'ArrayReferenceLiteral_271' => 'ArrayReferenceLiteral', [ 'BracketsEmpty' ], 0 ],
  [ 'ArrayReferenceVariable_272' => 'ArrayReferenceVariable', [ 'ARRAY_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [  ], 0 ],
  [ 'ArrayDereference_275' => 'ArrayDereference', [ '@{', 'ScalarVariable', '}' ], 0 ],
  [ 'ArrayDereference_276' => 'ArrayDereference', [ '@{', 'OPTIONAL-63', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [  ], 0 ],
  [ 'HashEntry_279' => 'HashEntry', [ 'ScaVarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-64', 'SubExpression' ], 0 ],
  [ 'HashEntry_280' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_281' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ 'Hash_282' => 'Hash', [ 'HashVariable' ], 0 ],
  [ 'HashVariable_283' => 'HashVariable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'HashReference_284' => 'HashReference', [ 'HashReferenceLiteral' ], 0 ],
  [ 'HashReference_285' => 'HashReference', [ 'HashReferenceVariable' ], 0 ],
  [ 'HashReferenceLiteral_286' => 'HashReferenceLiteral', [ 'LBRACE', 'HashLiteralEs', '}' ], 0 ],
  [ 'HashReferenceLiteral_287' => 'HashReferenceLiteral', [ 'BracesEmpty' ], 0 ],
  [ 'HashReferenceVariable_288' => 'HashReferenceVariable', [ 'HASH_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [  ], 0 ],
  [ 'HashDereference_291' => 'HashDereference', [ '%{', 'ScalarVariable', '}' ], 0 ],
  [ 'HashDereference_292' => 'HashDereference', [ '%{', 'OPTIONAL-65', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_293' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_294' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_295' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_296' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_297' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_298' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_299' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_300' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_301' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_302' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'ScalarVariableOrLiteral_303' => 'ScalarVariableOrLiteral', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarVariableOrLiteral_304' => 'ScalarVariableOrLiteral', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_305' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarVariable' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_306' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_307' => 'ScaVarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'OpNamedScolonOrSubExp_308' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_309' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_310' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_311' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_312' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_313' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_314' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_315' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_316' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_317' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_318' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_319' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_320' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_321' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_322' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_323' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_324' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_325' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_326' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_327' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_328' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_329' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_330' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PAREN' => 166,
  '_STAR_LIST' => 167,
  '_STAR_LIST' => 168,
  'SubExpressions_169' => 169,
  'SubExpressionOrInput_170' => 170,
  'SubExpressionOrInput_171' => 171,
  'SubExpressionOrInput_172' => 172,
  'SubExpressionOrVarMod_173' => 173,
  'SubExpressionOrVarMod_174' => 174,
  '_PAREN' => 175,
  '_OPTIONAL' => 176,
  '_OPTIONAL' => 177,
  'Statement_178' => 178,
  'Statement_179' => 179,
  'Statement_180' => 180,
  'Statement_181' => 181,
  'Statement_182' => 182,
  'Statement_183' => 183,
  '_PAREN' => 184,
  '_STAR_LIST' => 185,
  '_STAR_LIST' => 186,
  '_PAREN' => 187,
  '_OPTIONAL' => 188,
  '_OPTIONAL' => 189,
  'Conditional_190' => 190,
  'Loop_191' => 191,
  'Loop_192' => 192,
  'Loop_193' => 193,
  'LoopFor_194' => 194,
  'LoopFor_195' => 195,
  'LoopForEach_196' => 196,
  'LoopWhile_197' => 197,
  'LoopWhile_198' => 198,
  '_PLUS_LIST' => 199,
  '_PLUS_LIST' => 200,
  'CodeBlock_201' => 201,
  'Variable_202' => 202,
  'Variable_203' => 203,
  'Variable_204' => 204,
  'Variable_205' => 205,
  'Variable_206' => 206,
  'VariableRetrievalArrow_207' => 207,
  'VariableRetrievalArrow_208' => 208,
  'VariableRetrievalArrow_209' => 209,
  'VariableRetrieval_210' => 210,
  'VariableRetrieval_211' => 211,
  'VariableRetrieval_212' => 212,
  'VariableRetrieval_213' => 213,
  'VariableDeclaration_214' => 214,
  'VariableDeclaration_215' => 215,
  'VariableDeclaration_216' => 216,
  'VariableDeclaration_217' => 217,
  'VariableDeclaration_218' => 218,
  'VariableDeclaration_219' => 219,
  'VariableDeclaration_220' => 220,
  'VariableDeclaration_221' => 221,
  'VariableModification_222' => 222,
  'VariableModification_223' => 223,
  'Scalar_224' => 224,
  'Scalar_225' => 225,
  'ScalarLiteral_226' => 226,
  'ScalarLiteral_227' => 227,
  '_PLUS_LIST' => 228,
  '_PLUS_LIST' => 229,
  'ScalarVariable_230' => 230,
  'ScalarVariable_231' => 231,
  'ScalarVariable_232' => 232,
  'ScalarVariableOrSelf_233' => 233,
  'ScalarVariableOrSelf_234' => 234,
  'ArrayHashLiteral_235' => 235,
  '_PAREN' => 236,
  '_STAR_LIST' => 237,
  '_STAR_LIST' => 238,
  'ArrayHashLiteralEs_239' => 239,
  '_PAREN' => 240,
  '_STAR_LIST' => 241,
  '_STAR_LIST' => 242,
  'ArrayLiteralEs_243' => 243,
  '_PAREN' => 244,
  '_STAR_LIST' => 245,
  '_STAR_LIST' => 246,
  'HashLiteralEs_247' => 247,
  'ArrayLiteralE_248' => 248,
  'ArrayLiteralE_249' => 249,
  'HashLiteralE_250' => 250,
  'HashLiteralE_251' => 251,
  'ArrayHashLiteralE_252' => 252,
  'ArrayHashLiteralE_253' => 253,
  'ArrayHashLiteralE_254' => 254,
  'ArrayHashLiteralEmpty_255' => 255,
  'BracketsEmpty_256' => 256,
  'BracesEmpty_257' => 257,
  'ListElement_258' => 258,
  'ListElement_259' => 259,
  'ListElement_260' => 260,
  'Array_261' => 261,
  'Array_262' => 262,
  '_PAREN' => 263,
  '_STAR_LIST' => 264,
  '_STAR_LIST' => 265,
  'ArrayLiteralNonEmpty_266' => 266,
  'ArrayVariable_267' => 267,
  'ArrayReference_268' => 268,
  'ArrayReference_269' => 269,
  'ArrayReferenceLiteral_270' => 270,
  'ArrayReferenceLiteral_271' => 271,
  'ArrayReferenceVariable_272' => 272,
  '_OPTIONAL' => 273,
  '_OPTIONAL' => 274,
  'ArrayDereference_275' => 275,
  'ArrayDereference_276' => 276,
  '_OPTIONAL' => 277,
  '_OPTIONAL' => 278,
  'HashEntry_279' => 279,
  'HashEntry_280' => 280,
  'HashEntryProperties_281' => 281,
  'Hash_282' => 282,
  'HashVariable_283' => 283,
  'HashReference_284' => 284,
  'HashReference_285' => 285,
  'HashReferenceLiteral_286' => 286,
  'HashReferenceLiteral_287' => 287,
  'HashReferenceVariable_288' => 288,
  '_OPTIONAL' => 289,
  '_OPTIONAL' => 290,
  'HashDereference_291' => 291,
  'HashDereference_292' => 292,
  'WordScoped_293' => 293,
  'WordScoped_294' => 294,
  'LoopLabel_295' => 295,
  'Type_296' => 296,
  'Type_297' => 297,
  'Type_298' => 298,
  'TypeInner_299' => 299,
  'TypeInnerProperties_300' => 300,
  'TypeInnerProperties_301' => 301,
  'TypeInnerConstant_302' => 302,
  'ScalarVariableOrLiteral_303' => 303,
  'ScalarVariableOrLiteral_304' => 304,
  'ScaVarOrLitOrOpStrOrWord_305' => 305,
  'ScaVarOrLitOrOpStrOrWord_306' => 306,
  'ScaVarOrLitOrOpStrOrWord_307' => 307,
  'OpNamedScolonOrSubExp_308' => 308,
  'OpNamedScolonOrSubExp_309' => 309,
  'OpNamedScolonOrSubExp_310' => 310,
  'OpNamedScolonOrSubExpIn_311' => 311,
  'OpNamedScolonOrSubExpIn_312' => 312,
  'OpNamedScolonOrSubExpIn_313' => 313,
  'OpStringOrWord_314' => 314,
  'OpStringOrWord_315' => 315,
  'OpStringOrWord_316' => 316,
  'OpStringOrWord_317' => 317,
  'OpStringOrWord_318' => 318,
  'OpStringOrWord_319' => 319,
  'OpStringOrWord_320' => 320,
  'OpStringOrWord_321' => 321,
  'OpStringOrWord_322' => 322,
  'OpStringOrWord_323' => 323,
  'OpStringOrWord_324' => 324,
  'OpStringOrWord_325' => 325,
  'OpStringOrWord_326' => 326,
  'OpStringOrWord_327' => 327,
  'OpStringOrWord_328' => 328,
  'OpStringOrWord_329' => 329,
  'OpStringOrWord_330' => 330,
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
	LPAREN_TYPE_INNER => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 1,
			"package" => -20,
			'USE_RPERL' => -20,
			'SHEBANG' => 2
		},
		GOTOS => {
			'ModuleHeader' => 8,
			'Program' => 5,
			'PAREN-1' => 6,
			'Critic' => 7,
			'PLUS-2' => 4,
			'CompileUnit' => 3,
			'OPTIONAL-9' => 9
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-17' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 13,
			'Critic' => 12
		}
	},
	{#State 3
		ACTIONS => {
			'' => 14
		}
	},
	{#State 4
		ACTIONS => {
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 7,
			'PAREN-1' => 15,
			'ModuleHeader' => 8,
			'OPTIONAL-9' => 9
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => -27,
			'USE' => -27,
			"use constant" => -27,
			"use parent -norequire, qw(" => 19,
			'SUB' => -27,
			'USE_EXPORTER' => -27,
			"use parent qw(" => 20,
			"INIT" => -27
		},
		GOTOS => {
			'Module' => 21,
			'UseParent' => 18,
			'STAR-11' => 22,
			'Package' => 17,
			'Class' => 16
		}
	},
	{#State 9
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 24
		},
		GOTOS => {
			'OPTIONAL-10' => 23
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 11
		DEFAULT => -41
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			'USE_RPERL' => 27
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -2
	},
	{#State 16
		DEFAULT => -25
	},
	{#State 17
		DEFAULT => -24
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 30
		}
	},
	{#State 19
		DEFAULT => -78
	},
	{#State 20
		DEFAULT => -77
	},
	{#State 21
		DEFAULT => -1
	},
	{#State 22
		ACTIONS => {
			'SUB' => -29,
			'USE' => -29,
			"INIT" => -29,
			"use constant" => -29,
			"## no critic qw(" => 1,
			'USE_EXPORTER' => 32
		},
		GOTOS => {
			'Exports' => 33,
			'Critic' => 34,
			'OPTIONAL-12' => 31
		}
	},
	{#State 23
		ACTIONS => {
			"package" => 35
		}
	},
	{#State 24
		DEFAULT => -21
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
		DEFAULT => -293
	},
	{#State 29
		DEFAULT => -294
	},
	{#State 30
		ACTIONS => {
			")" => 38
		}
	},
	{#State 31
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 39
		}
	},
	{#State 32
		ACTIONS => {
			'USE' => -45,
			"use constant" => -45,
			"our hashref \$properties" => -45,
			'SUB' => -45,
			'OUR_EXPORT_OK' => -45,
			"INIT" => -45,
			'OUR_EXPORT' => 40
		},
		GOTOS => {
			'OPTIONAL-19' => 42,
			'PAREN-18' => 41
		}
	},
	{#State 33
		DEFAULT => -28
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 43
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
			'SUB' => -33,
			'USE' => 48,
			"use constant" => -33,
			"INIT" => 50
		},
		GOTOS => {
			'Include' => 49,
			'STAR-14' => 47
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 51
		}
	},
	{#State 41
		DEFAULT => -44
	},
	{#State 42
		ACTIONS => {
			"our hashref \$properties" => -48,
			'SUB' => -48,
			'OUR_EXPORT_OK' => 53,
			"INIT" => -48,
			'USE' => -48,
			"use constant" => -48
		},
		GOTOS => {
			'PAREN-20' => 54,
			'OPTIONAL-21' => 52
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55
		}
	},
	{#State 44
		ACTIONS => {
			"undef" => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'POD' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'USE' => -11,
			'OP01_NAMED_VOID' => -11,
			'LBRACE' => -11,
			'LBRACKET' => -11,
			'MY' => -11,
			'WORD_UPPERCASE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'HASH_SYMBOL' => -11,
			'LPAREN' => -11,
			'OP01_OPEN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'ARRAY_REF_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'SUB' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'ARRAY_SYMBOL' => -11,
			"while" => -11,
			"if" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			"use constant" => -11,
			'LITERAL_NUMBER' => -11,
			'HASH_REF_SYMBOL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LPAREN_TYPE_INNER' => -11,
			"INIT" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'SELF' => -11,
			"for" => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"%{" => -11,
			'WORD_SCOPED' => -11,
			"## no critic qw(" => 1,
			'SCALAR_SYMBOL' => -11,
			"\@{" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"foreach" => -11,
			'WORD' => -11,
			'OP01_NAMED_SCOLON' => -11
		},
		GOTOS => {
			'STAR-5' => 56,
			'Critic' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'USE_RPERL_AFTER' => 58,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'USE' => 48,
			"INIT" => 50
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 47
		ACTIONS => {
			"use constant" => 63,
			'SUB' => 65
		},
		GOTOS => {
			'PLUS-15' => 62,
			'Constant' => 64,
			'Subroutine' => 61
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 66
		}
	},
	{#State 49
		DEFAULT => -30
	},
	{#State 50
		ACTIONS => {
			'LBRACE' => 67
		}
	},
	{#State 51
		ACTIONS => {
			";" => 68
		}
	},
	{#State 52
		DEFAULT => -49
	},
	{#State 53
		ACTIONS => {
			'OP01_QW' => 69
		}
	},
	{#State 54
		DEFAULT => -47
	},
	{#State 55
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 70
		}
	},
	{#State 56
		ACTIONS => {
			'LBRACE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED_VOID' => -13,
			'USE' => 48,
			'LITERAL_STRING' => -13,
			'WORD_UPPERCASE' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'LBRACKET' => -13,
			'MY' => -13,
			'OP01_PRINT' => -13,
			"undef" => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED' => -13,
			'POD' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'ARRAY_REF_SYMBOL' => -13,
			'ARRAY_SYMBOL' => -13,
			'SUB' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'HASH_SYMBOL' => -13,
			'LPAREN' => -13,
			'LITERAL_NUMBER' => -13,
			"use constant" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LPAREN_TYPE_INNER' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'HASH_REF_SYMBOL' => -13,
			"if" => -13,
			"while" => -13,
			'OP22_LOGICAL_NEG' => -13,
			"\@{" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'WORD_SCOPED' => -13,
			'SCALAR_SYMBOL' => -13,
			'OP01_NAMED_SCOLON' => -13,
			"foreach" => -13,
			'WORD' => -13,
			'SELF' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"INIT" => 50,
			"for" => -13,
			"%{" => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 72,
			'Include' => 71
		}
	},
	{#State 57
		DEFAULT => -8
	},
	{#State 58
		DEFAULT => -37
	},
	{#State 59
		ACTIONS => {
			'OUR' => 73
		}
	},
	{#State 60
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 61
		DEFAULT => -35
	},
	{#State 62
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'SUB' => 65
		},
		GOTOS => {
			'Subroutine' => 76
		}
	},
	{#State 63
		ACTIONS => {
			'WORD_UPPERCASE' => 77
		}
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		ACTIONS => {
			'WORD' => 78
		}
	},
	{#State 66
		ACTIONS => {
			";" => -51,
			'OP01_QW' => 79
		},
		GOTOS => {
			'OPTIONAL-22' => 80
		}
	},
	{#State 67
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 81
		}
	},
	{#State 68
		DEFAULT => -43
	},
	{#State 69
		ACTIONS => {
			";" => 82
		}
	},
	{#State 70
		DEFAULT => -23
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'LBRACE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_STRING' => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LBRACKET' => -15,
			'MY' => -15,
			'OP01_PRINT' => -15,
			"undef" => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED' => -15,
			'POD' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'ARRAY_SYMBOL' => -15,
			'SUB' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'HASH_SYMBOL' => -15,
			'LPAREN' => -15,
			'LITERAL_NUMBER' => -15,
			'OP10_NAMED_UNARY' => -15,
			"use constant" => 63,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LPAREN_TYPE_INNER' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'HASH_REF_SYMBOL' => -15,
			"if" => -15,
			"while" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"\@{" => -15,
			'WORD_SCOPED' => -15,
			'SCALAR_SYMBOL' => -15,
			'OP01_NAMED_SCOLON' => -15,
			"foreach" => -15,
			'WORD' => -15,
			'SELF' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"for" => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"%{" => -15
		},
		GOTOS => {
			'STAR-7' => 83,
			'Constant' => 84
		}
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		ACTIONS => {
			'USE' => -69,
			"use constant" => -69,
			"INIT" => -69,
			"## no critic qw(" => 1,
			'USE_EXPORTER' => 32,
			"our hashref \$properties" => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 88,
			'Exports' => 87,
			'Critic' => 86
		}
	},
	{#State 75
		ACTIONS => {
			";" => 89
		}
	},
	{#State 76
		DEFAULT => -34
	},
	{#State 77
		ACTIONS => {
			'OP20_HASH_FATARROW' => 90
		}
	},
	{#State 78
		ACTIONS => {
			'LBRACE' => 91
		}
	},
	{#State 79
		DEFAULT => -50
	},
	{#State 80
		ACTIONS => {
			";" => 92
		}
	},
	{#State 81
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 93
		}
	},
	{#State 82
		DEFAULT => -46
	},
	{#State 83
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 138,
			'SUB' => 65,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP01_NAMED_VOID_SCOLON' => 150,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID' => 148,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'MY' => 146,
			'WORD_UPPERCASE' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 154,
			'OP01_PRINT' => 111,
			'OP01_NAMED_VOID_LPAREN' => 153,
			'POD' => 151,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			"foreach" => -177,
			'WORD' => 28,
			'OP01_NAMED_SCOLON' => 114,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'SELF' => 123,
			"for" => -177,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			"while" => -177,
			"if" => 133,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'Expression' => 134,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'SubExpression' => 95,
			'BracketsEmpty' => 96,
			'PAREN-47' => 97,
			'OPTIONAL-48' => 140,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'Conditional' => 100,
			'Operation' => 102,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'Subroutine' => 105,
			'ArrayReference' => 107,
			'Variable' => 108,
			'Scalar' => 109,
			'HashReferenceVariable' => 110,
			'OperatorVoid' => 152,
			'WordScoped' => 112,
			'Operator' => 115,
			'ArrayLiteralNonEmpty' => 117,
			'LoopLabel' => 158,
			'HashVariable' => 118,
			'Statement' => 121,
			'ArrayReferenceVariable' => 124,
			'ScalarVariable' => 125,
			'VariableModification' => 160,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'VariableDeclaration' => 164,
			'PLUS-8' => 165,
			'ArrayVariable' => 131,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132
		}
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -66
	},
	{#State 87
		DEFAULT => -68
	},
	{#State 88
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 169
		}
	},
	{#State 89
		DEFAULT => -36
	},
	{#State 90
		ACTIONS => {
			'MY' => 171
		},
		GOTOS => {
			'TypeInnerConstant' => 170
		}
	},
	{#State 91
		ACTIONS => {
			'LBRACE' => 172
		}
	},
	{#State 92
		DEFAULT => -54
	},
	{#State 93
		ACTIONS => {
			'OP01_QW' => 173,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 174
		}
	},
	{#State 94
		ACTIONS => {
			'SCALAR_SYMBOL' => 157,
			'SELF' => 123
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 167,
			'ScalarVariable' => 175
		}
	},
	{#State 95
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => 181
		}
	},
	{#State 96
		DEFAULT => -271
	},
	{#State 97
		DEFAULT => -176
	},
	{#State 98
		DEFAULT => -163
	},
	{#State 99
		DEFAULT => -159
	},
	{#State 100
		DEFAULT => -178
	},
	{#State 101
		DEFAULT => -283
	},
	{#State 102
		DEFAULT => -17
	},
	{#State 103
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'ARGV' => 201,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'MY' => 209,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'LITERAL_STRING' => 149,
			'OP01_QW' => 203,
			'LBRACE' => 106,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'HASH_REF_SYMBOL' => 127,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			"]" => 204,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayLiteralE' => 197,
			'ScalarVariable' => 194,
			'ArrayLiteralEs' => 198,
			'ListElement' => 199,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 200,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132,
			'TypeInner' => 207,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162
		}
	},
	{#State 104
		DEFAULT => -284
	},
	{#State 105
		DEFAULT => -14
	},
	{#State 106
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 230,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP19_LOOP_CONTROL' => 229,
			'OP23_LOGICAL_AND' => 228,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_PRINT' => 221,
			"undef" => 113,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_NAMED' => 236,
			'OP01_CLOSE' => 235,
			'OP07_STRING_REPEAT' => 233,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID' => 232,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'SELF' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP12_COMPARE_EQ_NE' => 222,
			"\@{" => 116,
			'ENV' => 213,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'WORD' => 210,
			'OP11_COMPARE_LT_GT' => 226,
			'OP22_LOGICAL_NEG' => 225,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 218,
			"}" => 217,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215
		},
		GOTOS => {
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'SubExpression' => 219,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashLiteralEs' => 211,
			'ScalarVariable' => 214,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'OpStringOrWord' => 223,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'HashEntry' => 231,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 216,
			'HashLiteralE' => 234,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202
		}
	},
	{#State 107
		DEFAULT => -161
	},
	{#State 108
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 238,
			'OP19_VARIABLE_ASSIGN' => 237
		}
	},
	{#State 109
		DEFAULT => -157
	},
	{#State 110
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -285,
			'OP06_REGEX_BIND' => -285,
			")" => -285,
			'OP15_LOGICAL_AND' => -285,
			'OP19_VARIABLE_ASSIGN' => -206,
			'OP16_LOGICAL_OR' => -285,
			'OP14_BITWISE_OR_XOR' => -285,
			'OP07_MATH_MULT_DIV_MOD' => -285,
			'OP23_LOGICAL_AND' => -285,
			'OP17_LIST_RANGE' => -285,
			'OP07_STRING_REPEAT' => -285,
			'OP09_BITWISE_SHIFT' => -285,
			'OP08_STRING_CAT' => -285,
			'OP08_MATH_ADD_SUB' => -285,
			'OP11_COMPARE_LT_GT' => -285,
			'OP24_LOGICAL_OR_XOR' => -285,
			'OP04_MATH_POW' => -285,
			'OP13_BITWISE_AND' => -285,
			'OP18_TERNARY' => -285,
			'OP19_VARIABLE_ASSIGN_BY' => -206
		}
	},
	{#State 111
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			"%{" => -132,
			'STDOUT_STDERR' => 240,
			'SELF' => -132,
			'WORD' => -132,
			'WORD_SCOPED' => -132,
			'SCALAR_SYMBOL' => -132,
			"\@{" => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'HASH_REF_SYMBOL' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'LPAREN_TYPE_INNER' => -132,
			'OP10_NAMED_UNARY' => -132,
			'LITERAL_NUMBER' => -132,
			'FHREF_SYMBOL_BRACES' => 241,
			'HASH_SYMBOL' => -132,
			'LPAREN' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'OP01_OPEN' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'ARRAY_SYMBOL' => -132,
			'ARRAY_REF_SYMBOL' => -132,
			"undef" => -132,
			'OP01_NAMED' => -132,
			'OP01_CLOSE' => -132,
			'LBRACKET' => -132,
			'WORD_UPPERCASE' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'LITERAL_STRING' => -132,
			'LBRACE' => -132
		},
		GOTOS => {
			'PAREN-39' => 242,
			'OPTIONAL-40' => 239
		}
	},
	{#State 112
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 243,
			'LPAREN' => 244
		}
	},
	{#State 113
		DEFAULT => -156
	},
	{#State 114
		DEFAULT => -96
	},
	{#State 115
		DEFAULT => -149
	},
	{#State 116
		ACTIONS => {
			'LBRACKET' => -274,
			'MY' => 209,
			'SELF' => 123,
			'ARRAY_REF_SYMBOL' => -274,
			'SCALAR_SYMBOL' => 157
		},
		GOTOS => {
			'OPTIONAL-63' => 247,
			'ScalarVariable' => 245,
			'TypeInner' => 246,
			'ScalarVariableOrSelf' => 167
		}
	},
	{#State 117
		DEFAULT => -261
	},
	{#State 118
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -282,
			'OP18_TERNARY' => -282,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP13_BITWISE_AND' => -282,
			'OP04_MATH_POW' => -282,
			'OP08_STRING_CAT' => -282,
			'OP07_STRING_REPEAT' => -282,
			'OP17_LIST_RANGE' => -282,
			'OP09_BITWISE_SHIFT' => -282,
			'OP08_MATH_ADD_SUB' => -282,
			'OP11_COMPARE_LT_GT' => -282,
			'OP07_MATH_MULT_DIV_MOD' => -282,
			'OP14_BITWISE_OR_XOR' => -282,
			'OP16_LOGICAL_OR' => -282,
			'OP23_LOGICAL_AND' => -282,
			'OP12_COMPARE_EQ_NE' => -282,
			'OP15_LOGICAL_AND' => -282,
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP06_REGEX_BIND' => -282,
			")" => -282
		}
	},
	{#State 119
		ACTIONS => {
			'HASH_REF_SYMBOL' => -290,
			'MY' => 209,
			'LBRACE' => -290,
			'SELF' => 123,
			'SCALAR_SYMBOL' => 157
		},
		GOTOS => {
			'ScalarVariable' => 249,
			'TypeInner' => 248,
			'OPTIONAL-65' => 250,
			'ScalarVariableOrSelf' => 167
		}
	},
	{#State 120
		ACTIONS => {
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96,
			'HashVariable' => 195,
			'SubExpression' => 251,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205
		}
	},
	{#State 121
		DEFAULT => -98
	},
	{#State 122
		DEFAULT => -97
	},
	{#State 123
		DEFAULT => -234
	},
	{#State 124
		ACTIONS => {
			'OP23_LOGICAL_AND' => -269,
			'OP07_MATH_MULT_DIV_MOD' => -269,
			'OP16_LOGICAL_OR' => -269,
			'OP14_BITWISE_OR_XOR' => -269,
			'OP19_VARIABLE_ASSIGN' => -204,
			'OP15_LOGICAL_AND' => -269,
			")" => -269,
			'OP06_REGEX_BIND' => -269,
			'OP12_COMPARE_EQ_NE' => -269,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP18_TERNARY' => -269,
			'OP04_MATH_POW' => -269,
			'OP13_BITWISE_AND' => -269,
			'OP24_LOGICAL_OR_XOR' => -269,
			'OP11_COMPARE_LT_GT' => -269,
			'OP08_MATH_ADD_SUB' => -269,
			'OP08_STRING_CAT' => -269,
			'OP09_BITWISE_SHIFT' => -269,
			'OP07_STRING_REPEAT' => -269,
			'OP17_LIST_RANGE' => -269
		}
	},
	{#State 125
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -225,
			'OP19_VARIABLE_ASSIGN_BY' => -202,
			'OP18_TERNARY' => -225,
			'OP04_MATH_POW' => -225,
			'OP13_BITWISE_AND' => -225,
			'OP08_STRING_CAT' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP17_LIST_RANGE' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP07_MATH_MULT_DIV_MOD' => -225,
			'OP03_MATH_INC_DEC' => 253,
			'OP16_LOGICAL_OR' => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP23_LOGICAL_AND' => -225,
			'OP12_COMPARE_EQ_NE' => -225,
			'OP19_VARIABLE_ASSIGN' => -202,
			'OP15_LOGICAL_AND' => -225,
			'OP06_REGEX_BIND' => -225,
			")" => -225,
			'OP02_METHOD_THINARROW' => 252
		}
	},
	{#State 126
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 260,
			'OP07_STRING_REPEAT' => 233,
			'OP01_PRINT' => 221,
			'OP11_COMPARE_LT_GT' => 226,
			'OP01_CLOSE' => 258,
			'OP01_NAMED' => 257,
			'OP08_MATH_ADD_SUB' => 220,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'OP10_NAMED_UNARY' => 255,
			'OP01_NAMED_VOID' => 232,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP01_OPEN' => 256,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'WORD' => 254,
			'OP19_LOOP_CONTROL' => 229,
			'OP23_LOGICAL_AND' => 228
		},
		GOTOS => {
			'OpStringOrWord' => 259
		}
	},
	{#State 127
		DEFAULT => -288
	},
	{#State 128
		DEFAULT => -141
	},
	{#State 129
		DEFAULT => -224
	},
	{#State 130
		ACTIONS => {
			'OP13_BITWISE_AND' => -117,
			'OP10_NAMED_UNARY' => 130,
			"]" => -117,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'OP24_LOGICAL_OR_XOR' => -117,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			"}" => -117,
			'OP11_COMPARE_LT_GT' => -117,
			'OP22_LOGICAL_NEG' => 168,
			";" => -117,
			'OP08_STRING_CAT' => -117,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP16_LOGICAL_OR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'WORD' => 28,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			")" => -117,
			'SELF' => 123,
			'OP12_COMPARE_EQ_NE' => -117,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 149,
			'OP04_MATH_POW' => -117,
			'OP18_TERNARY' => -117,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP01_NAMED' => 206,
			'OP08_MATH_ADD_SUB' => -117,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP17_LIST_RANGE' => -117,
			'OP07_STRING_REPEAT' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'ARRAY_REF_SYMBOL' => 139,
			'OP23_LOGICAL_AND' => -117,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'OP06_REGEX_BIND' => -117,
			'HASH_SYMBOL' => 101,
			'OP15_LOGICAL_AND' => -117,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP21_LIST_COMMA' => -117
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 261,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137
		}
	},
	{#State 131
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -262,
			'OP16_LOGICAL_OR' => -262,
			'OP14_BITWISE_OR_XOR' => -262,
			'OP23_LOGICAL_AND' => -262,
			'OP12_COMPARE_EQ_NE' => -262,
			'OP15_LOGICAL_AND' => -262,
			'OP19_VARIABLE_ASSIGN' => -203,
			")" => -262,
			'OP06_REGEX_BIND' => -262,
			'OP24_LOGICAL_OR_XOR' => -262,
			'OP18_TERNARY' => -262,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP13_BITWISE_AND' => -262,
			'OP04_MATH_POW' => -262,
			'OP08_STRING_CAT' => -262,
			'OP17_LIST_RANGE' => -262,
			'OP07_STRING_REPEAT' => -262,
			'OP09_BITWISE_SHIFT' => -262,
			'OP08_MATH_ADD_SUB' => -262,
			'OP11_COMPARE_LT_GT' => -262
		}
	},
	{#State 132
		DEFAULT => -162
	},
	{#State 133
		ACTIONS => {
			'LPAREN' => 262
		}
	},
	{#State 134
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			";" => 263,
			'OP08_STRING_CAT' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP04_MATH_POW' => -155,
			'OP18_TERNARY' => -155
		}
	},
	{#State 135
		DEFAULT => -267
	},
	{#State 136
		DEFAULT => -158
	},
	{#State 137
		DEFAULT => -165
	},
	{#State 138
		ACTIONS => {
			'WORD_UPPERCASE' => 265
		},
		GOTOS => {
			'LoopLabel' => 264
		}
	},
	{#State 139
		DEFAULT => -272
	},
	{#State 140
		ACTIONS => {
			"while" => 268,
			"foreach" => 267,
			"for" => 271
		},
		GOTOS => {
			'LoopFor' => 272,
			'LoopWhile' => 270,
			'LoopForEach' => 266,
			'Loop' => 269
		}
	},
	{#State 141
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116
		},
		GOTOS => {
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'BracketsEmpty' => 96,
			'SubExpression' => 273,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161
		}
	},
	{#State 142
		ACTIONS => {
			'MY' => 274
		}
	},
	{#State 143
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP22_LOGICAL_NEG' => 225,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 218,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'SELF' => 123,
			")" => 282,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP12_COMPARE_EQ_NE' => 222,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'ENV' => 213,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'WORD' => 210,
			'OP01_PRINT' => 275,
			"undef" => 113,
			'OP01_CLOSE' => 235,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_NAMED' => 281,
			'OP07_STRING_REPEAT' => 233,
			'LBRACE' => 106,
			'OP01_QW' => 203,
			'OP01_NAMED_VOID' => 232,
			'LITERAL_STRING' => 149,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'MY' => 209,
			'OP01_OPEN' => 230,
			'OP05_LOGICAL_NEG' => 141,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP19_LOOP_CONTROL' => 229,
			'OP23_LOGICAL_AND' => 228,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'ARGV' => 201,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'ArrayDereference' => 132,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'ScalarLiteral' => 216,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayVariable' => 196,
			'ArrayHashLiteralEs' => 279,
			'OpStringOrWord' => 223,
			'ScalarVariable' => 214,
			'ArrayReferenceVariable' => 193,
			'Operator' => 115,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'WordScoped' => 112,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'HashEntry' => 280,
			'TypeInner' => 207,
			'ArrayReference' => 107,
			'BracketsEmpty' => 96,
			'ArrayHashLiteralE' => 278,
			'ListElement' => 277,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'SubExpression' => 276
		}
	},
	{#State 144
		ACTIONS => {
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 283,
			'HashVariable' => 195,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'Array' => 161,
			'HashReference' => 162,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 145
		ACTIONS => {
			'LPAREN' => 284,
			'COLON' => -295
		}
	},
	{#State 146
		ACTIONS => {
			'WORD' => 289,
			'TYPE_FHREF' => 286,
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287
		},
		GOTOS => {
			'Type' => 285
		}
	},
	{#State 147
		DEFAULT => -287
	},
	{#State 148
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116
		},
		GOTOS => {
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'SubExpression' => 290,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96,
			'SubExpressions' => 291
		}
	},
	{#State 149
		DEFAULT => -227
	},
	{#State 150
		DEFAULT => -137
	},
	{#State 151
		DEFAULT => -183
	},
	{#State 152
		DEFAULT => -180
	},
	{#State 153
		ACTIONS => {
			")" => -134,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'SubExpressions' => 293,
			'OPTIONAL-41' => 292,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 154
		ACTIONS => {
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Array' => 161,
			'HashReference' => 162,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'WordScoped' => 112,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 294,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 155
		ACTIONS => {
			'FHREF_SYMBOL' => 295
		}
	},
	{#State 156
		DEFAULT => -151
	},
	{#State 157
		DEFAULT => -233
	},
	{#State 158
		ACTIONS => {
			'COLON' => 296
		}
	},
	{#State 159
		ACTIONS => {
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155
		},
		GOTOS => {
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'SubExpression' => 297,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96
		}
	},
	{#State 160
		ACTIONS => {
			";" => 298
		}
	},
	{#State 161
		DEFAULT => -160
	},
	{#State 162
		DEFAULT => -164
	},
	{#State 163
		DEFAULT => -226
	},
	{#State 164
		DEFAULT => -181
	},
	{#State 165
		ACTIONS => {
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'OP01_NAMED_SCOLON' => 114,
			'WORD' => 28,
			"foreach" => -177,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			"for" => -177,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			"while" => -177,
			"if" => 133,
			'OP22_LOGICAL_NEG' => 168,
			'OP19_LOOP_CONTROL' => 138,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'' => -18,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'LBRACE' => 106,
			'OP01_NAMED_VOID' => 148,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID_SCOLON' => 150,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 145,
			'MY' => 146,
			'LBRACKET' => 103,
			'OP01_PRINT' => 111,
			'OP01_NAMED' => 154,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'POD' => 151,
			'OP01_NAMED_VOID_LPAREN' => 153
		},
		GOTOS => {
			'SubExpression' => 95,
			'Expression' => 134,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Conditional' => 100,
			'Hash' => 98,
			'OPTIONAL-48' => 140,
			'ArrayHashLiteral' => 99,
			'BracketsEmpty' => 96,
			'PAREN-47' => 97,
			'Variable' => 108,
			'ArrayReference' => 107,
			'Operation' => 299,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'HashReferenceVariable' => 110,
			'Scalar' => 109,
			'OperatorVoid' => 152,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 118,
			'LoopLabel' => 158,
			'Operator' => 115,
			'ArrayReferenceVariable' => 124,
			'ScalarVariable' => 125,
			'Statement' => 121,
			'VariableDeclaration' => 164,
			'ArrayVariable' => 131,
			'VariableModification' => 160,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132
		}
	},
	{#State 166
		DEFAULT => -268
	},
	{#State 167
		ACTIONS => {
			'OP21_LIST_COMMA' => -230,
			'COLON' => -230,
			'OP12_COMPARE_EQ_NE' => -230,
			'OP02_ARRAY_THINARROW' => 302,
			'OP19_VARIABLE_ASSIGN' => -230,
			'OP15_LOGICAL_AND' => -230,
			")" => -230,
			'OP06_REGEX_BIND' => -230,
			'OP02_METHOD_THINARROW' => -230,
			'OP07_MATH_MULT_DIV_MOD' => -230,
			'OP03_MATH_INC_DEC' => -230,
			'OP16_LOGICAL_OR' => -230,
			'OP14_BITWISE_OR_XOR' => -230,
			'OP23_LOGICAL_AND' => -230,
			'OP20_HASH_FATARROW' => -230,
			'OP08_STRING_CAT' => -230,
			";" => -230,
			'OP09_BITWISE_SHIFT' => -230,
			'OP07_STRING_REPEAT' => -230,
			'OP17_LIST_RANGE' => -230,
			'OP02_HASH_THINARROW' => 301,
			'OP11_COMPARE_LT_GT' => -230,
			'OP08_MATH_ADD_SUB' => -230,
			"}" => -230,
			'OP24_LOGICAL_OR_XOR' => -230,
			'OP19_VARIABLE_ASSIGN_BY' => -230,
			'OP18_TERNARY' => -230,
			'OP13_BITWISE_AND' => -230,
			'OP04_MATH_POW' => -230,
			"]" => -230
		},
		GOTOS => {
			'VariableRetrievalArrow' => 300
		}
	},
	{#State 168
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130
		},
		GOTOS => {
			'WordScoped' => 112,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 303,
			'HashVariable' => 195,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137
		}
	},
	{#State 169
		ACTIONS => {
			"our hashref \$properties" => -73,
			"use constant" => -73,
			"INIT" => 50,
			'USE' => 48
		},
		GOTOS => {
			'STAR-31' => 304,
			'Include' => 305
		}
	},
	{#State 170
		ACTIONS => {
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'ScalarLiteral' => 306
		}
	},
	{#State 171
		ACTIONS => {
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 172
		ACTIONS => {
			'MY' => 308
		}
	},
	{#State 173
		DEFAULT => -52
	},
	{#State 174
		ACTIONS => {
			")" => 309
		}
	},
	{#State 175
		DEFAULT => -104
	},
	{#State 176
		ACTIONS => {
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 310,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 177
		ACTIONS => {
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28
		},
		GOTOS => {
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 311,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'WordScoped' => 112
		}
	},
	{#State 178
		ACTIONS => {
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 312,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayDereference' => 132,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 179
		ACTIONS => {
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 313,
			'HashVariable' => 195,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132
		}
	},
	{#State 180
		ACTIONS => {
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 314,
			'HashVariable' => 195,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'Array' => 161,
			'HashReference' => 162,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 181
		ACTIONS => {
			'LITERAL_STRING' => 149,
			'SCALAR_SYMBOL' => 157,
			'SELF' => 123,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'ScalarVariableOrLiteral' => 315,
			'ScalarVariable' => 316,
			'ScalarLiteral' => 317,
			'ScalarVariableOrSelf' => 167
		}
	},
	{#State 182
		ACTIONS => {
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126
		},
		GOTOS => {
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'SubExpression' => 318,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'WordScoped' => 112
		}
	},
	{#State 183
		ACTIONS => {
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103
		},
		GOTOS => {
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'WordScoped' => 112,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205,
			'SubExpression' => 319,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99
		}
	},
	{#State 184
		ACTIONS => {
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 320,
			'HashVariable' => 195,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 185
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 321,
			'BracketsEmpty' => 96,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'WordScoped' => 112
		}
	},
	{#State 186
		ACTIONS => {
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 322,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 187
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96,
			'SubExpression' => 323,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205
		}
	},
	{#State 188
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 324,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 189
		ACTIONS => {
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135
		},
		GOTOS => {
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 325,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193
		}
	},
	{#State 190
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 326
		}
	},
	{#State 191
		ACTIONS => {
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'SubExpression' => 327,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'ScalarVariable' => 194,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'BracketsEmpty' => 96
		}
	},
	{#State 192
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113
		},
		GOTOS => {
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 328
		}
	},
	{#State 193
		DEFAULT => -269
	},
	{#State 194
		ACTIONS => {
			")" => -225,
			'OP06_REGEX_BIND' => -225,
			'OP02_METHOD_THINARROW' => 252,
			'OP15_LOGICAL_AND' => -225,
			'OP12_COMPARE_EQ_NE' => -225,
			'OP21_LIST_COMMA' => -225,
			'OP23_LOGICAL_AND' => -225,
			'OP16_LOGICAL_OR' => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP03_MATH_INC_DEC' => 253,
			'OP07_MATH_MULT_DIV_MOD' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP17_LIST_RANGE' => -225,
			'OP08_STRING_CAT' => -225,
			";" => -225,
			'OP04_MATH_POW' => -225,
			'OP13_BITWISE_AND' => -225,
			"]" => -225,
			'OP18_TERNARY' => -225,
			'OP24_LOGICAL_OR_XOR' => -225,
			"}" => -225
		}
	},
	{#State 195
		DEFAULT => -282
	},
	{#State 196
		DEFAULT => -262
	},
	{#State 197
		DEFAULT => -242,
		GOTOS => {
			'STAR-58' => 329
		}
	},
	{#State 198
		ACTIONS => {
			"]" => 330
		}
	},
	{#State 199
		DEFAULT => -249
	},
	{#State 200
		ACTIONS => {
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			"]" => -248,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP21_LIST_COMMA' => -248,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 201
		DEFAULT => -260
	},
	{#State 202
		DEFAULT => -285
	},
	{#State 203
		DEFAULT => -259
	},
	{#State 204
		DEFAULT => -256
	},
	{#State 205
		DEFAULT => -155
	},
	{#State 206
		ACTIONS => {
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 331,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 207
		ACTIONS => {
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120
		},
		GOTOS => {
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 332,
			'ArrayLiteralNonEmpty' => 117
		}
	},
	{#State 208
		ACTIONS => {
			'LPAREN' => 284
		}
	},
	{#State 209
		ACTIONS => {
			'WORD' => 289,
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 210
		ACTIONS => {
			'LPAREN' => -293,
			'OP20_HASH_FATARROW' => -330,
			'OP02_METHOD_THINARROW_NEW' => -293
		}
	},
	{#State 211
		ACTIONS => {
			"}" => 334
		}
	},
	{#State 212
		DEFAULT => -323
	},
	{#State 213
		DEFAULT => -280
	},
	{#State 214
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -225,
			'OP21_LIST_COMMA' => -225,
			")" => -225,
			'OP06_REGEX_BIND' => -225,
			'OP02_METHOD_THINARROW' => 252,
			'OP15_LOGICAL_AND' => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP16_LOGICAL_OR' => -225,
			'OP03_MATH_INC_DEC' => 253,
			'OP07_MATH_MULT_DIV_MOD' => -225,
			'OP20_HASH_FATARROW' => -305,
			'OP23_LOGICAL_AND' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP17_LIST_RANGE' => -225,
			'OP08_STRING_CAT' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP24_LOGICAL_OR_XOR' => -225,
			"}" => -225,
			'OP13_BITWISE_AND' => -225,
			'OP04_MATH_POW' => -225,
			'OP18_TERNARY' => -225
		}
	},
	{#State 215
		DEFAULT => -317
	},
	{#State 216
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -224,
			"}" => -224,
			'OP04_MATH_POW' => -224,
			'OP13_BITWISE_AND' => -224,
			'OP18_TERNARY' => -224,
			'OP09_BITWISE_SHIFT' => -224,
			'OP07_STRING_REPEAT' => -224,
			'OP17_LIST_RANGE' => -224,
			'OP08_STRING_CAT' => -224,
			'OP11_COMPARE_LT_GT' => -224,
			'OP08_MATH_ADD_SUB' => -224,
			'OP16_LOGICAL_OR' => -224,
			'OP14_BITWISE_OR_XOR' => -224,
			'OP07_MATH_MULT_DIV_MOD' => -224,
			'OP20_HASH_FATARROW' => -306,
			'OP23_LOGICAL_AND' => -224,
			'OP12_COMPARE_EQ_NE' => -224,
			'OP21_LIST_COMMA' => -224,
			'OP06_REGEX_BIND' => -224,
			")" => -224,
			'OP15_LOGICAL_AND' => -224
		}
	},
	{#State 217
		DEFAULT => -257
	},
	{#State 218
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'LBRACKET' => 103,
			'OP18_TERNARY' => -117,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP04_MATH_POW' => -117,
			'OP07_STRING_REPEAT' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'OP23_LOGICAL_AND' => -117,
			'ARRAY_REF_SYMBOL' => 139,
			'OP21_LIST_COMMA' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP06_REGEX_BIND' => -117,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			"}" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'HASH_REF_SYMBOL' => 127,
			'LITERAL_NUMBER' => 163,
			'OP13_BITWISE_AND' => -117,
			'OP10_NAMED_UNARY' => 130,
			'OP08_STRING_CAT' => -117,
			'OP22_LOGICAL_NEG' => 168,
			'OP11_COMPARE_LT_GT' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'WORD' => 28,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP20_HASH_FATARROW' => -321,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP12_COMPARE_EQ_NE' => -117,
			'SELF' => 123,
			")" => -117
		},
		GOTOS => {
			'SubExpression' => 261,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202
		}
	},
	{#State 219
		ACTIONS => {
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP21_LIST_COMMA' => -250,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_STRING_CAT' => 179,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			"}" => -250,
			'OP24_LOGICAL_OR_XOR' => 187
		}
	},
	{#State 220
		DEFAULT => -322
	},
	{#State 221
		DEFAULT => -329
	},
	{#State 222
		DEFAULT => -319
	},
	{#State 223
		DEFAULT => -307
	},
	{#State 224
		DEFAULT => -314
	},
	{#State 225
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'OP20_HASH_FATARROW' => -316,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96,
			'SubExpression' => 303,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205
		}
	},
	{#State 226
		DEFAULT => -320
	},
	{#State 227
		ACTIONS => {
			'OP20_HASH_FATARROW' => 335
		}
	},
	{#State 228
		DEFAULT => -315
	},
	{#State 229
		DEFAULT => -318
	},
	{#State 230
		ACTIONS => {
			'MY' => 274,
			'OP20_HASH_FATARROW' => -327
		}
	},
	{#State 231
		DEFAULT => -251
	},
	{#State 232
		DEFAULT => -328
	},
	{#State 233
		DEFAULT => -324
	},
	{#State 234
		DEFAULT => -246,
		GOTOS => {
			'STAR-60' => 336
		}
	},
	{#State 235
		ACTIONS => {
			'OP20_HASH_FATARROW' => -326,
			'FHREF_SYMBOL' => 295
		}
	},
	{#State 236
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'OP20_HASH_FATARROW' => -325,
			'SCALAR_SYMBOL' => 157
		},
		GOTOS => {
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 331,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193
		}
	},
	{#State 237
		ACTIONS => {
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'FHREF_SYMBOL_IN' => 338,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'STDIN' => 339,
			"%{" => 119
		},
		GOTOS => {
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 340,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'WordScoped' => 112,
			'Scalar' => 109,
			'SubExpressionOrInput' => 337,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147
		}
	},
	{#State 238
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149
		},
		GOTOS => {
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 341,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'WordScoped' => 112
		}
	},
	{#State 239
		ACTIONS => {
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'SubExpressions' => 342,
			'BracketsEmpty' => 96,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132
		}
	},
	{#State 240
		DEFAULT => -130
	},
	{#State 241
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149
		},
		GOTOS => {
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 290,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'SubExpressions' => 343,
			'BracketsEmpty' => 96
		}
	},
	{#State 242
		DEFAULT => -131
	},
	{#State 243
		ACTIONS => {
			")" => -148,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127
		},
		GOTOS => {
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'OPTIONAL-44' => 344,
			'HashReference' => 345,
			'HashReferenceVariable' => 202
		}
	},
	{#State 244
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			")" => -144,
			'LPAREN' => 143,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'SubExpression' => 290,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'SubExpressions' => 347,
			'OPTIONAL-42' => 346,
			'ScalarVariable' => 194,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'Array' => 161,
			'HashReference' => 162,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'ArrayDereference' => 132,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112
		}
	},
	{#State 245
		ACTIONS => {
			"}" => 348
		}
	},
	{#State 246
		DEFAULT => -273
	},
	{#State 247
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'LBRACKET' => 103
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 166,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'ArrayReference' => 349
		}
	},
	{#State 248
		DEFAULT => -289
	},
	{#State 249
		ACTIONS => {
			"}" => 350
		}
	},
	{#State 250
		ACTIONS => {
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127
		},
		GOTOS => {
			'HashReference' => 351,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'HashReferenceVariable' => 202
		}
	},
	{#State 251
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP06_REGEX_BIND' => 190,
			")" => 352,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => 181,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP08_STRING_CAT' => 179
		}
	},
	{#State 252
		ACTIONS => {
			'LPAREN' => 353
		}
	},
	{#State 253
		DEFAULT => -105
	},
	{#State 254
		DEFAULT => -330
	},
	{#State 255
		DEFAULT => -321
	},
	{#State 256
		DEFAULT => -327
	},
	{#State 257
		DEFAULT => -325
	},
	{#State 258
		DEFAULT => -326
	},
	{#State 259
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 354
		}
	},
	{#State 260
		DEFAULT => -316
	},
	{#State 261
		ACTIONS => {
			";" => -116,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -116,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => -116,
			"}" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP13_BITWISE_AND' => -116,
			"]" => -116,
			'OP04_MATH_POW' => 191,
			'OP21_LIST_COMMA' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_BIND' => 190,
			")" => -116,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP23_LOGICAL_AND' => -116
		}
	},
	{#State 262
		ACTIONS => {
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 355,
			'HashVariable' => 195,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137
		}
	},
	{#State 263
		DEFAULT => -95
	},
	{#State 264
		ACTIONS => {
			";" => 356
		}
	},
	{#State 265
		DEFAULT => -295
	},
	{#State 266
		DEFAULT => -192
	},
	{#State 267
		ACTIONS => {
			'MY' => 357
		}
	},
	{#State 268
		ACTIONS => {
			'LPAREN_MY' => 359,
			'LPAREN' => 358
		}
	},
	{#State 269
		DEFAULT => -179
	},
	{#State 270
		DEFAULT => -193
	},
	{#State 271
		ACTIONS => {
			'LPAREN_MY' => 360,
			'MY' => 361
		}
	},
	{#State 272
		DEFAULT => -191
	},
	{#State 273
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP06_REGEX_BIND' => -108,
			")" => -108,
			"}" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP18_TERNARY' => -108,
			'OP04_MATH_POW' => 191,
			"]" => -108,
			'OP13_BITWISE_AND' => -108,
			";" => -108,
			'OP08_STRING_CAT' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP11_COMPARE_LT_GT' => -108
		}
	},
	{#State 274
		ACTIONS => {
			'TYPE_FHREF' => 362
		}
	},
	{#State 275
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 363,
			'OP20_HASH_FATARROW' => -329
		}
	},
	{#State 276
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -252,
			'OP21_LIST_COMMA' => -252,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192
		}
	},
	{#State 277
		DEFAULT => -253
	},
	{#State 278
		DEFAULT => -238,
		GOTOS => {
			'STAR-56' => 364
		}
	},
	{#State 279
		ACTIONS => {
			")" => 365
		}
	},
	{#State 280
		DEFAULT => -254
	},
	{#State 281
		ACTIONS => {
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'OP20_HASH_FATARROW' => -325,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119
		},
		GOTOS => {
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 366,
			'HashVariable' => 195,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132,
			'WordScoped' => 112
		}
	},
	{#State 282
		DEFAULT => -255
	},
	{#State 283
		ACTIONS => {
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189,
			'OP12_COMPARE_EQ_NE' => 185,
			")" => 367,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182
		}
	},
	{#State 284
		ACTIONS => {
			")" => 368
		}
	},
	{#State 285
		ACTIONS => {
			'ARRAY_SYMBOL' => 370,
			'SCALAR_SYMBOL' => 369,
			'HASH_SYMBOL' => 371
		}
	},
	{#State 286
		ACTIONS => {
			'FHREF_SYMBOL' => 372
		}
	},
	{#State 287
		DEFAULT => -298
	},
	{#State 288
		DEFAULT => -297
	},
	{#State 289
		DEFAULT => -296
	},
	{#State 290
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 179,
			";" => -168,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 189,
			'OP21_LIST_COMMA' => -168,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -168
		},
		GOTOS => {
			'STAR-46' => 373
		}
	},
	{#State 291
		ACTIONS => {
			";" => 374
		}
	},
	{#State 292
		ACTIONS => {
			")" => 375
		}
	},
	{#State 293
		DEFAULT => -133
	},
	{#State 294
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			";" => -100,
			'OP08_STRING_CAT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP21_LIST_COMMA' => 376,
			'OP06_REGEX_BIND' => -100,
			'OP15_LOGICAL_AND' => -100
		}
	},
	{#State 295
		DEFAULT => -103
	},
	{#State 296
		DEFAULT => -175
	},
	{#State 297
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => 377,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192
		}
	},
	{#State 298
		DEFAULT => -182
	},
	{#State 299
		DEFAULT => -16
	},
	{#State 300
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -231,
			'OP13_BITWISE_AND' => -231,
			"]" => -231,
			"}" => -231,
			'OP24_LOGICAL_OR_XOR' => -231,
			'OP11_COMPARE_LT_GT' => -231,
			'OP08_STRING_CAT' => -231,
			";" => -231,
			'OP02_HASH_THINARROW' => 301,
			'OP20_HASH_FATARROW' => -231,
			'OP07_MATH_MULT_DIV_MOD' => -231,
			'OP16_LOGICAL_OR' => -231,
			'OP14_BITWISE_OR_XOR' => -231,
			")" => -231,
			'OP02_METHOD_THINARROW' => -231,
			'OP12_COMPARE_EQ_NE' => -231,
			'LBRACE' => 381,
			'OP18_TERNARY' => -231,
			'OP04_MATH_POW' => -231,
			'LBRACKET' => 382,
			'OP08_MATH_ADD_SUB' => -231,
			'OP09_BITWISE_SHIFT' => -231,
			'OP07_STRING_REPEAT' => -231,
			'OP17_LIST_RANGE' => -231,
			'OP23_LOGICAL_AND' => -231,
			'OP03_MATH_INC_DEC' => -231,
			'OP19_VARIABLE_ASSIGN' => -231,
			'OP15_LOGICAL_AND' => -231,
			'OP06_REGEX_BIND' => -231,
			'OP21_LIST_COMMA' => -231,
			'COLON' => -231,
			'OP02_ARRAY_THINARROW' => 302
		},
		GOTOS => {
			'VariableRetrieval' => 379,
			'PLUS-54' => 380,
			'VariableRetrievalArrow' => 378
		}
	},
	{#State 301
		ACTIONS => {
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 384,
			'ARRAY_SYMBOL' => 135,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 383,
			'HashVariable' => 195,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132
		}
	},
	{#State 302
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106
		},
		GOTOS => {
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 385,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162
		}
	},
	{#State 303
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			";" => -127,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			"]" => -127,
			'OP04_MATH_POW' => 191,
			"}" => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -127,
			'OP21_LIST_COMMA' => -127,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177
		}
	},
	{#State 304
		ACTIONS => {
			"our hashref \$properties" => 388,
			"use constant" => 63
		},
		GOTOS => {
			'Constant' => 386,
			'Properties' => 387
		}
	},
	{#State 305
		DEFAULT => -70
	},
	{#State 306
		ACTIONS => {
			";" => 389
		}
	},
	{#State 307
		ACTIONS => {
			"\$TYPED_" => 390
		}
	},
	{#State 308
		ACTIONS => {
			'WORD' => 289,
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287
		},
		GOTOS => {
			'Type' => 391
		}
	},
	{#State 309
		ACTIONS => {
			";" => 392
		}
	},
	{#State 310
		ACTIONS => {
			'OP15_LOGICAL_AND' => 180,
			")" => -123,
			'OP06_REGEX_BIND' => 190,
			'OP21_LIST_COMMA' => -123,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => -123,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			";" => -123,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -123,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -123,
			'OP04_MATH_POW' => 191,
			"]" => -123,
			'OP13_BITWISE_AND' => 186,
			"}" => -123,
			'OP24_LOGICAL_OR_XOR' => -123
		}
	},
	{#State 311
		ACTIONS => {
			'OP18_TERNARY' => -121,
			'OP04_MATH_POW' => 191,
			"]" => -121,
			'OP13_BITWISE_AND' => 186,
			"}" => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			";" => -121,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -121,
			'OP09_BITWISE_SHIFT' => 183,
			'OP23_LOGICAL_AND' => -121,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP15_LOGICAL_AND' => -121,
			")" => -121,
			'OP06_REGEX_BIND' => 190,
			'OP21_LIST_COMMA' => -121,
			'OP12_COMPARE_EQ_NE' => 185
		}
	},
	{#State 312
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -112,
			"}" => -112,
			"]" => -112,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -112,
			'OP08_STRING_CAT' => -112,
			";" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP21_LIST_COMMA' => -112,
			")" => -112,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => -112
		}
	},
	{#State 313
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -114,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => -114,
			";" => -114,
			"]" => -114,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -114,
			'OP18_TERNARY' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			"}" => -114,
			")" => -114,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 178
		}
	},
	{#State 314
		ACTIONS => {
			'OP06_REGEX_BIND' => 190,
			")" => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP17_LIST_RANGE' => -122,
			'OP07_STRING_REPEAT' => 192,
			'OP09_BITWISE_SHIFT' => 183,
			";" => -122,
			'OP08_STRING_CAT' => 179,
			"]" => -122,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			"}" => -122
		}
	},
	{#State 315
		ACTIONS => {
			'COLON' => 393
		}
	},
	{#State 316
		DEFAULT => -303
	},
	{#State 317
		DEFAULT => -304
	},
	{#State 318
		ACTIONS => {
			'OP23_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP15_LOGICAL_AND' => -113,
			")" => -113,
			'OP06_REGEX_BIND' => 190,
			'OP21_LIST_COMMA' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP18_TERNARY' => -113,
			"]" => -113,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -113,
			"}" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			";" => -113,
			'OP08_STRING_CAT' => -113,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -113,
			'OP09_BITWISE_SHIFT' => -113
		}
	},
	{#State 319
		ACTIONS => {
			"]" => -115,
			'OP13_BITWISE_AND' => -115,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			"}" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			";" => -115,
			'OP23_LOGICAL_AND' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			")" => -115,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP21_LIST_COMMA' => -115
		}
	},
	{#State 320
		ACTIONS => {
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => -124,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -124,
			")" => -124,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => -124,
			"}" => -124,
			'OP04_MATH_POW' => 191,
			"]" => -124,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => -124,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 192,
			'OP09_BITWISE_SHIFT' => 183,
			";" => -124,
			'OP08_STRING_CAT' => 179,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188
		}
	},
	{#State 321
		ACTIONS => {
			'OP23_LOGICAL_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP06_REGEX_BIND' => 190,
			")" => -119,
			'OP21_LIST_COMMA' => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP18_TERNARY' => -119,
			"]" => -119,
			'OP13_BITWISE_AND' => -119,
			'OP04_MATH_POW' => 191,
			"}" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			";" => -119,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -119,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 322
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -120,
			")" => -120,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => -120,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => -120,
			'OP08_STRING_CAT' => 179,
			";" => -120,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => -120,
			"}" => -120,
			"]" => -120,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -120,
			'OP18_TERNARY' => -120
		}
	},
	{#State 323
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			";" => -129,
			"]" => -129,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP24_LOGICAL_OR_XOR' => -129,
			"}" => -129,
			'OP06_REGEX_BIND' => 190,
			")" => -129,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -129,
			'OP23_LOGICAL_AND' => 189,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178
		}
	},
	{#State 324
		ACTIONS => {
			")" => -118,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP21_LIST_COMMA' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => -118,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			";" => -118,
			'OP04_MATH_POW' => 191,
			"]" => -118,
			'OP13_BITWISE_AND' => -118,
			'OP18_TERNARY' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			"}" => -118
		}
	},
	{#State 325
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP08_STRING_CAT' => 179,
			";" => -128,
			"]" => -128,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP24_LOGICAL_OR_XOR' => -128,
			"}" => -128,
			")" => -128,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178
		}
	},
	{#State 326
		DEFAULT => -110
	},
	{#State 327
		ACTIONS => {
			")" => -106,
			'OP06_REGEX_BIND' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP17_LIST_RANGE' => -106,
			'OP08_STRING_CAT' => -106,
			";" => -106,
			"]" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106
		}
	},
	{#State 328
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -111,
			"}" => -111,
			"]" => -111,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -111,
			'OP18_TERNARY' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			";" => -111,
			'OP08_STRING_CAT' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP06_REGEX_BIND' => 190,
			")" => -111,
			'OP15_LOGICAL_AND' => -111
		}
	},
	{#State 329
		ACTIONS => {
			"]" => -243,
			'OP21_LIST_COMMA' => 394
		},
		GOTOS => {
			'PAREN-57' => 395
		}
	},
	{#State 330
		DEFAULT => -270
	},
	{#State 331
		ACTIONS => {
			'OP08_STRING_CAT' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP04_MATH_POW' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP15_LOGICAL_AND' => -100,
			")" => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100
		}
	},
	{#State 332
		ACTIONS => {
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_STRING_CAT' => 179,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP24_LOGICAL_OR_XOR' => 187,
			"]" => -258,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -258,
			'OP06_REGEX_BIND' => 190,
			")" => -258,
			'OP15_LOGICAL_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 333
		ACTIONS => {
			"\$TYPED_" => 396
		}
	},
	{#State 334
		DEFAULT => -286
	},
	{#State 335
		ACTIONS => {
			'OP10_NAMED_UNARY' => -278,
			'LITERAL_STRING' => -278,
			'LITERAL_NUMBER' => -278,
			'LBRACE' => -278,
			'MY' => 209,
			'HASH_REF_SYMBOL' => -278,
			'LBRACKET' => -278,
			'LPAREN_TYPE_INNER' => -278,
			'OP05_BITWISE_NEG_LPAREN' => -278,
			'WORD_UPPERCASE' => -278,
			'OP05_MATH_NEG_LPAREN' => -278,
			'OP01_CLOSE' => -278,
			'OP01_NAMED' => -278,
			"undef" => -278,
			'OP22_LOGICAL_NEG' => -278,
			'SCALAR_SYMBOL' => -278,
			'ARRAY_REF_SYMBOL' => -278,
			'WORD_SCOPED' => -278,
			"\@{" => -278,
			'CONSTANT_CALL_SCOPED' => -278,
			'OP03_MATH_INC_DEC' => -278,
			'WORD' => -278,
			'ARRAY_SYMBOL' => -278,
			'LPAREN' => -278,
			'HASH_SYMBOL' => -278,
			'SELF' => -278,
			'OP01_OPEN' => -278,
			'OP05_LOGICAL_NEG' => -278,
			"%{" => -278,
			'OP22_LOGICAL_NEG_LPAREN' => -278
		},
		GOTOS => {
			'OPTIONAL-64' => 398,
			'TypeInner' => 397
		}
	},
	{#State 336
		ACTIONS => {
			"}" => -247,
			'OP21_LIST_COMMA' => 400
		},
		GOTOS => {
			'PAREN-59' => 399
		}
	},
	{#State 337
		DEFAULT => -222
	},
	{#State 338
		DEFAULT => -171
	},
	{#State 339
		DEFAULT => -172
	},
	{#State 340
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			")" => -170,
			'OP06_REGEX_BIND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 189,
			";" => -170,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186
		}
	},
	{#State 341
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			")" => -223,
			'OP06_REGEX_BIND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 179,
			";" => -223,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 342
		ACTIONS => {
			";" => 401
		}
	},
	{#State 343
		ACTIONS => {
			";" => 402
		}
	},
	{#State 344
		ACTIONS => {
			")" => 403
		}
	},
	{#State 345
		DEFAULT => -147
	},
	{#State 346
		ACTIONS => {
			")" => 404
		}
	},
	{#State 347
		DEFAULT => -143
	},
	{#State 348
		DEFAULT => -275
	},
	{#State 349
		ACTIONS => {
			"}" => 405
		}
	},
	{#State 350
		DEFAULT => -291
	},
	{#State 351
		ACTIONS => {
			"}" => 406
		}
	},
	{#State 352
		DEFAULT => -126
	},
	{#State 353
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			")" => -146
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'SubExpressions' => 407,
			'ScalarVariable' => 194,
			'OPTIONAL-43' => 408,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'SubExpression' => 290,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayDereference' => 132,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'Array' => 161,
			'HashReference' => 162,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 354
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149
		},
		GOTOS => {
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'BracketsEmpty' => 96,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 205,
			'SubExpression' => 409,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117
		}
	},
	{#State 355
		ACTIONS => {
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_STRING_CAT' => 179,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP06_REGEX_BIND' => 190,
			")" => 410,
			'OP15_LOGICAL_AND' => 180,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 356
		DEFAULT => -142
	},
	{#State 357
		ACTIONS => {
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 411
		}
	},
	{#State 358
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106
		},
		GOTOS => {
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 412,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 289,
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287
		},
		GOTOS => {
			'Type' => 413
		}
	},
	{#State 360
		ACTIONS => {
			'TYPE_INTEGER' => 414
		}
	},
	{#State 361
		ACTIONS => {
			'TYPE_INTEGER' => 415
		}
	},
	{#State 362
		ACTIONS => {
			'FHREF_SYMBOL' => 416
		}
	},
	{#State 363
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130
		},
		GOTOS => {
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'Expression' => 205,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'BracketsEmpty' => 96,
			'SubExpressions' => 417
		}
	},
	{#State 364
		ACTIONS => {
			")" => -239,
			'OP21_LIST_COMMA' => 419
		},
		GOTOS => {
			'PAREN-55' => 418
		}
	},
	{#State 365
		DEFAULT => -235
	},
	{#State 366
		ACTIONS => {
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP04_MATH_POW' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP08_STRING_CAT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => -100
		}
	},
	{#State 367
		DEFAULT => -107
	},
	{#State 368
		DEFAULT => -150
	},
	{#State 369
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421,
			'OP02_ARRAY_THINARROW' => 423,
			";" => 422
		}
	},
	{#State 370
		ACTIONS => {
			";" => 425,
			'OP19_VARIABLE_ASSIGN' => 424
		}
	},
	{#State 371
		ACTIONS => {
			";" => 427,
			'OP19_VARIABLE_ASSIGN' => 426
		}
	},
	{#State 372
		ACTIONS => {
			";" => 428
		}
	},
	{#State 373
		ACTIONS => {
			")" => -169,
			'OP21_LIST_COMMA' => 429,
			";" => -169
		},
		GOTOS => {
			'PAREN-45' => 430
		}
	},
	{#State 374
		DEFAULT => -139
	},
	{#State 375
		ACTIONS => {
			";" => 431
		}
	},
	{#State 376
		ACTIONS => {
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208
		},
		GOTOS => {
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'WordScoped' => 112,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracketsEmpty' => 96,
			'SubExpressions' => 432,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'ArrayLiteralNonEmpty' => 117
		}
	},
	{#State 377
		DEFAULT => -109
	},
	{#State 378
		DEFAULT => -210
	},
	{#State 379
		DEFAULT => -229
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => 381,
			'OP18_TERNARY' => -232,
			'OP04_MATH_POW' => -232,
			'LBRACKET' => 382,
			'OP08_MATH_ADD_SUB' => -232,
			'OP09_BITWISE_SHIFT' => -232,
			'OP07_STRING_REPEAT' => -232,
			'OP17_LIST_RANGE' => -232,
			'OP23_LOGICAL_AND' => -232,
			'OP03_MATH_INC_DEC' => -232,
			'OP19_VARIABLE_ASSIGN' => -232,
			'OP15_LOGICAL_AND' => -232,
			'OP06_REGEX_BIND' => -232,
			'OP21_LIST_COMMA' => -232,
			'COLON' => -232,
			'OP02_ARRAY_THINARROW' => 302,
			'OP19_VARIABLE_ASSIGN_BY' => -232,
			"]" => -232,
			'OP13_BITWISE_AND' => -232,
			"}" => -232,
			'OP24_LOGICAL_OR_XOR' => -232,
			'OP11_COMPARE_LT_GT' => -232,
			'OP08_STRING_CAT' => -232,
			";" => -232,
			'OP02_HASH_THINARROW' => 301,
			'OP20_HASH_FATARROW' => -232,
			'OP07_MATH_MULT_DIV_MOD' => -232,
			'OP16_LOGICAL_OR' => -232,
			'OP14_BITWISE_OR_XOR' => -232,
			")" => -232,
			'OP02_METHOD_THINARROW' => -232,
			'OP12_COMPARE_EQ_NE' => -232
		},
		GOTOS => {
			'VariableRetrieval' => 433,
			'VariableRetrievalArrow' => 378
		}
	},
	{#State 381
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'WORD' => 434,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206
		},
		GOTOS => {
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 435,
			'BracketsEmpty' => 96,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194
		}
	},
	{#State 382
		ACTIONS => {
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119
		},
		GOTOS => {
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 436,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115
		}
	},
	{#State 383
		ACTIONS => {
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			"}" => 437,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 384
		ACTIONS => {
			"}" => 438,
			'OP02_METHOD_THINARROW_NEW' => -293,
			'LPAREN' => -293
		}
	},
	{#State 385
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP18_TERNARY' => 181,
			"]" => 439,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176
		}
	},
	{#State 386
		DEFAULT => -72
	},
	{#State 387
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 440
		}
	},
	{#State 388
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 441
		}
	},
	{#State 389
		DEFAULT => -56
	},
	{#State 390
		ACTIONS => {
			'WORD_UPPERCASE' => 442
		}
	},
	{#State 391
		ACTIONS => {
			"\$RETURN_TYPE" => 443
		}
	},
	{#State 392
		ACTIONS => {
			"}" => 444
		}
	},
	{#State 393
		ACTIONS => {
			'LITERAL_STRING' => 149,
			'SCALAR_SYMBOL' => 157,
			'LITERAL_NUMBER' => 163,
			'SELF' => 123
		},
		GOTOS => {
			'ScalarVariable' => 316,
			'ScalarVariableOrLiteral' => 445,
			'ScalarLiteral' => 317,
			'ScalarVariableOrSelf' => 167
		}
	},
	{#State 394
		ACTIONS => {
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'ARGV' => 201,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP01_QW' => 203,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'MY' => 209,
			'LBRACKET' => 103,
			'SELF' => 123,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'WORD' => 28,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 200,
			'ArrayLiteralNonEmpty' => 117,
			'BracketsEmpty' => 96,
			'ListElement' => 199,
			'ScalarVariable' => 194,
			'Hash' => 98,
			'ArrayLiteralE' => 446,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'TypeInner' => 207,
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112
		}
	},
	{#State 395
		DEFAULT => -241
	},
	{#State 396
		ACTIONS => {
			'OP23_LOGICAL_AND' => 228,
			'OP19_LOOP_CONTROL' => 229,
			'WORD' => 254,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP01_OPEN' => 256,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP10_NAMED_UNARY' => 255,
			'OP01_NAMED_VOID' => 232,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP01_CLOSE' => 258,
			'OP01_NAMED' => 257,
			'OP08_MATH_ADD_SUB' => 220,
			'OP11_COMPARE_LT_GT' => 226,
			'OP01_PRINT' => 221,
			'OP22_LOGICAL_NEG' => 260,
			'OP07_STRING_REPEAT' => 233
		},
		GOTOS => {
			'OpStringOrWord' => 447
		}
	},
	{#State 397
		DEFAULT => -277
	},
	{#State 398
		ACTIONS => {
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 448,
			'HashVariable' => 195,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayVariable' => 196,
			'ArrayReference' => 107
		}
	},
	{#State 399
		DEFAULT => -245
	},
	{#State 400
		ACTIONS => {
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 230,
			'ARRAY_REF_SYMBOL' => 139,
			'OP23_LOGICAL_AND' => 228,
			'OP19_LOOP_CONTROL' => 229,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			"undef" => 113,
			'OP01_NAMED' => 236,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_CLOSE' => 235,
			'OP01_PRINT' => 221,
			'OP07_STRING_REPEAT' => 233,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID' => 232,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'SELF' => 123,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ENV' => 213,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP11_COMPARE_LT_GT' => 226,
			'OP22_LOGICAL_NEG' => 225,
			'OP10_NAMED_UNARY' => 218,
			'LITERAL_NUMBER' => 163,
			'OP24_LOGICAL_OR_XOR' => 224,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'HashVariable' => 195,
			'SubExpression' => 219,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 214,
			'OpStringOrWord' => 223,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'HashEntry' => 231,
			'HashReference' => 162,
			'Array' => 161,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 216,
			'WordScoped' => 112,
			'HashLiteralE' => 449,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132
		}
	},
	{#State 401
		DEFAULT => -135
	},
	{#State 402
		DEFAULT => -136
	},
	{#State 403
		DEFAULT => -154
	},
	{#State 404
		DEFAULT => -152
	},
	{#State 405
		DEFAULT => -276
	},
	{#State 406
		DEFAULT => -292
	},
	{#State 407
		DEFAULT => -145
	},
	{#State 408
		ACTIONS => {
			")" => 450
		}
	},
	{#State 409
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -265,
			'OP21_LIST_COMMA' => -265,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184
		},
		GOTOS => {
			'STAR-62' => 451
		}
	},
	{#State 410
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 452
		}
	},
	{#State 411
		ACTIONS => {
			'SCALAR_SYMBOL' => 454
		}
	},
	{#State 412
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 189,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			")" => 455,
			'OP06_REGEX_BIND' => 190,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188
		}
	},
	{#State 413
		ACTIONS => {
			'SCALAR_SYMBOL' => 456
		}
	},
	{#State 414
		ACTIONS => {
			'SCALAR_SYMBOL' => 457
		}
	},
	{#State 415
		ACTIONS => {
			'SCALAR_SYMBOL' => 458
		}
	},
	{#State 416
		ACTIONS => {
			'OP21_LIST_COMMA' => 459
		}
	},
	{#State 417
		ACTIONS => {
			")" => 460
		}
	},
	{#State 418
		DEFAULT => -237
	},
	{#State 419
		ACTIONS => {
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP01_OPEN' => 230,
			'OP05_LOGICAL_NEG' => 141,
			'OP03_MATH_INC_DEC' => 94,
			'ARGV' => 201,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'OP23_LOGICAL_AND' => 228,
			'OP19_LOOP_CONTROL' => 229,
			'OP07_STRING_REPEAT' => 233,
			'OP01_NAMED' => 236,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_CLOSE' => 235,
			"undef" => 113,
			'OP01_PRINT' => 221,
			'MY' => 209,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID' => 232,
			'OP01_QW' => 203,
			'LBRACE' => 106,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'SELF' => 123,
			'WORD' => 210,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'ENV' => 213,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP22_LOGICAL_NEG' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'HASH_REF_SYMBOL' => 127,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP10_NAMED_UNARY' => 218,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 276,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 214,
			'ArrayHashLiteralE' => 461,
			'ListElement' => 277,
			'BracketsEmpty' => 96,
			'OpStringOrWord' => 223,
			'TypeInner' => 207,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'ScalarLiteral' => 216,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162,
			'HashEntry' => 280,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132
		}
	},
	{#State 420
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'SubExpressions' => 462,
			'BracketsEmpty' => 96
		}
	},
	{#State 421
		ACTIONS => {
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'STDIN' => 339,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'FHREF_SYMBOL_IN' => 338,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG' => 168,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 464,
			'OP01_NAMED_SCOLON' => 465,
			'WORD' => 28,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'OpNamedScolonOrSubExpIn' => 463,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 340,
			'HashVariable' => 195,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'SubExpressionOrInput' => 466,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'Array' => 161,
			'HashReference' => 162,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'ArrayReference' => 107,
			'ArrayVariable' => 196
		}
	},
	{#State 422
		DEFAULT => -214
	},
	{#State 423
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 467,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132
		}
	},
	{#State 424
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 464,
			'WORD' => 28,
			'OP01_NAMED_SCOLON' => 465,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			'HASH_REF_SYMBOL' => 127,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'STDIN' => 339,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'FHREF_SYMBOL_IN' => 338,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106
		},
		GOTOS => {
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'SubExpressionOrInput' => 466,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'OpNamedScolonOrSubExpIn' => 468,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 340,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115
		}
	},
	{#State 425
		DEFAULT => -217
	},
	{#State 426
		ACTIONS => {
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 208,
			'LBRACKET' => 103,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'STDIN' => 339,
			'ARRAY_REF_SYMBOL' => 139,
			'FHREF_SYMBOL_IN' => 338,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'OP22_LOGICAL_NEG' => 168,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 464,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			'OP01_NAMED_SCOLON' => 465,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayDereference' => 132,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'SubExpressionOrInput' => 466,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'WordScoped' => 112,
			'HashReference' => 162,
			'Array' => 161,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'BracketsEmpty' => 96,
			'OpNamedScolonOrSubExpIn' => 469,
			'ScalarVariable' => 194,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Expression' => 205,
			'HashVariable' => 195,
			'SubExpression' => 340,
			'ArrayLiteralNonEmpty' => 117
		}
	},
	{#State 427
		DEFAULT => -219
	},
	{#State 428
		DEFAULT => -221
	},
	{#State 429
		ACTIONS => {
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113,
			'OP22_LOGICAL_NEG' => 168,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135
		},
		GOTOS => {
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'WordScoped' => 112,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 470,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96
		}
	},
	{#State 430
		DEFAULT => -167
	},
	{#State 431
		DEFAULT => -138
	},
	{#State 432
		ACTIONS => {
			";" => 471
		}
	},
	{#State 433
		DEFAULT => -228
	},
	{#State 434
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -293,
			'LPAREN' => -293,
			"}" => 472
		}
	},
	{#State 435
		ACTIONS => {
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			"}" => 473,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP12_COMPARE_EQ_NE' => 185
		}
	},
	{#State 436
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP13_BITWISE_AND' => 186,
			"]" => 474,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => 181,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179
		}
	},
	{#State 437
		DEFAULT => -208
	},
	{#State 438
		DEFAULT => -209
	},
	{#State 439
		DEFAULT => -207
	},
	{#State 440
		ACTIONS => {
			'SUB' => 475,
			'LITERAL_NUMBER' => 478
		},
		GOTOS => {
			'Method' => 476,
			'SubroutineOrMethod' => 477,
			'Subroutine' => 479
		}
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 480
		}
	},
	{#State 442
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 481
		}
	},
	{#State 443
		ACTIONS => {
			"}" => 482
		}
	},
	{#State 444
		DEFAULT => -55
	},
	{#State 445
		DEFAULT => -125
	},
	{#State 446
		DEFAULT => -240
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 483
		}
	},
	{#State 448
		ACTIONS => {
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			"}" => -279,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -279,
			'OP21_LIST_COMMA' => -279,
			'OP12_COMPARE_EQ_NE' => 185
		}
	},
	{#State 449
		DEFAULT => -244
	},
	{#State 450
		DEFAULT => -153
	},
	{#State 451
		ACTIONS => {
			'OP21_LIST_COMMA' => 484,
			")" => 486
		},
		GOTOS => {
			'PAREN-61' => 485
		}
	},
	{#State 452
		DEFAULT => -186,
		GOTOS => {
			'STAR-50' => 487
		}
	},
	{#State 453
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 150,
			'OP01_NAMED_VOID' => 148,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LBRACKET' => 103,
			'MY' => 146,
			'WORD_UPPERCASE' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			"undef" => 113,
			'OP01_NAMED' => 154,
			'OP01_CLOSE' => 155,
			'OP01_PRINT' => 111,
			'OP01_NAMED_VOID_LPAREN' => 153,
			'POD' => 151,
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 138,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'OP05_MATH_NEG_LPAREN' => 159,
			'LPAREN_TYPE_INNER' => 126,
			"while" => -177,
			"if" => 133,
			'OP22_LOGICAL_NEG' => 168,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			"foreach" => -177,
			'WORD' => 28,
			'OP01_NAMED_SCOLON' => 114,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			"for" => -177,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 117,
			'LoopLabel' => 158,
			'HashVariable' => 118,
			'Operator' => 115,
			'ArrayReferenceVariable' => 124,
			'ScalarVariable' => 125,
			'PLUS-53' => 489,
			'Statement' => 121,
			'ArrayVariable' => 131,
			'VariableDeclaration' => 164,
			'VariableModification' => 160,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'SubExpression' => 95,
			'Expression' => 134,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'ArrayHashLiteral' => 99,
			'OPTIONAL-48' => 140,
			'Hash' => 98,
			'Conditional' => 100,
			'PAREN-47' => 97,
			'BracketsEmpty' => 96,
			'ArrayReference' => 107,
			'Variable' => 108,
			'Operation' => 488,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'Scalar' => 109,
			'HashReferenceVariable' => 110,
			'OperatorVoid' => 152
		}
	},
	{#State 454
		ACTIONS => {
			'LPAREN' => 490
		}
	},
	{#State 455
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 491
		}
	},
	{#State 456
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 493
		}
	},
	{#State 458
		ACTIONS => {
			'LPAREN' => 494
		}
	},
	{#State 459
		ACTIONS => {
			'LITERAL_STRING' => 495
		}
	},
	{#State 460
		DEFAULT => -99
	},
	{#State 461
		DEFAULT => -236
	},
	{#State 462
		ACTIONS => {
			")" => 496
		}
	},
	{#State 463
		DEFAULT => -215
	},
	{#State 464
		DEFAULT => -312
	},
	{#State 465
		DEFAULT => -311
	},
	{#State 466
		ACTIONS => {
			";" => 497
		}
	},
	{#State 467
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			"]" => 498,
			'OP18_TERNARY' => 181,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_STRING_CAT' => 179
		}
	},
	{#State 468
		DEFAULT => -218
	},
	{#State 469
		DEFAULT => -220
	},
	{#State 470
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP18_TERNARY' => 181,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP08_STRING_CAT' => 179,
			";" => -166,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -166,
			'OP06_REGEX_BIND' => 190,
			")" => -166,
			'OP15_LOGICAL_AND' => 180
		}
	},
	{#State 471
		DEFAULT => -140
	},
	{#State 472
		DEFAULT => -213
	},
	{#State 473
		DEFAULT => -212
	},
	{#State 474
		DEFAULT => -211
	},
	{#State 475
		ACTIONS => {
			'WORD' => 499
		}
	},
	{#State 476
		DEFAULT => -94
	},
	{#State 477
		DEFAULT => -74
	},
	{#State 478
		ACTIONS => {
			";" => 500
		}
	},
	{#State 479
		DEFAULT => -93
	},
	{#State 480
		ACTIONS => {
			'WORD' => 254,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP19_LOOP_CONTROL' => 229,
			'OP23_LOGICAL_AND' => 228,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP01_OPEN' => 256,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			"}" => 503,
			'OP01_NAMED_VOID' => 232,
			'OP10_NAMED_UNARY' => 255,
			'OP07_STRING_REPEAT' => 233,
			'OP22_LOGICAL_NEG' => 260,
			'OP11_COMPARE_LT_GT' => 226,
			'OP01_CLOSE' => 258,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_NAMED' => 257,
			'OP01_PRINT' => 221
		},
		GOTOS => {
			'HashEntryProperties' => 502,
			'OpStringOrWord' => 501
		}
	},
	{#State 481
		DEFAULT => -302
	},
	{#State 482
		ACTIONS => {
			";" => 504
		}
	},
	{#State 483
		DEFAULT => -299
	},
	{#State 484
		ACTIONS => {
			'MY' => 209,
			'ARGV' => 201,
			'OP01_QW' => 203
		},
		GOTOS => {
			'TypeInner' => 207,
			'ListElement' => 505
		}
	},
	{#State 485
		DEFAULT => -264
	},
	{#State 486
		DEFAULT => -266
	},
	{#State 487
		ACTIONS => {
			"undef" => -189,
			'OP01_CLOSE' => -189,
			'OP01_NAMED' => -189,
			'OP01_PRINT' => -189,
			"elsif" => 510,
			'OP01_NAMED_VOID_LPAREN' => -189,
			'POD' => -189,
			'OP01_NAMED_VOID_SCOLON' => -189,
			'OP01_NAMED_VOID' => -189,
			'LITERAL_STRING' => -189,
			'LBRACE' => -189,
			'LBRACKET' => -189,
			'MY' => -189,
			'WORD_UPPERCASE' => -189,
			'OP05_BITWISE_NEG_LPAREN' => -189,
			'HASH_SYMBOL' => -189,
			'LPAREN' => -189,
			'OP01_OPEN' => -189,
			'OP05_LOGICAL_NEG' => -189,
			'ARRAY_REF_SYMBOL' => -189,
			'OP19_LOOP_CONTROL' => -189,
			'' => -189,
			'OP03_MATH_INC_DEC' => -189,
			'ARRAY_SYMBOL' => -189,
			"if" => -189,
			"while" => -189,
			'OP22_LOGICAL_NEG' => -189,
			'OP10_NAMED_UNARY' => -189,
			'LITERAL_NUMBER' => -189,
			'OP19_LOOP_CONTROL_SCOLON' => -189,
			'HASH_REF_SYMBOL' => -189,
			'OP05_MATH_NEG_LPAREN' => -189,
			"}" => -189,
			"else" => 507,
			'LPAREN_TYPE_INNER' => -189,
			'SELF' => -189,
			'OP10_NAMED_UNARY_SCOLON' => -189,
			"for" => -189,
			'OP22_LOGICAL_NEG_LPAREN' => -189,
			"%{" => -189,
			'WORD_SCOPED' => -189,
			'SCALAR_SYMBOL' => -189,
			"\@{" => -189,
			'CONSTANT_CALL_SCOPED' => -189,
			"foreach" => -189,
			'WORD' => -189,
			'OP01_NAMED_SCOLON' => -189
		},
		GOTOS => {
			'OPTIONAL-52' => 508,
			'PAREN-51' => 506,
			'PAREN-49' => 509
		}
	},
	{#State 488
		DEFAULT => -200
	},
	{#State 489
		ACTIONS => {
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 138,
			'OP01_NAMED_VOID_LPAREN' => 153,
			'POD' => 151,
			"undef" => 113,
			'OP01_NAMED' => 154,
			'OP01_CLOSE' => 155,
			'OP01_PRINT' => 111,
			'LBRACKET' => 103,
			'MY' => 146,
			'WORD_UPPERCASE' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP01_NAMED_VOID_SCOLON' => 150,
			'OP01_NAMED_VOID' => 148,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			"for" => -177,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'SELF' => 123,
			"foreach" => -177,
			'WORD' => 28,
			'OP01_NAMED_SCOLON' => 114,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			"while" => -177,
			"if" => 133,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'HASH_REF_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 159,
			"}" => 511,
			'LPAREN_TYPE_INNER' => 126,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'Statement' => 121,
			'ArrayReferenceVariable' => 124,
			'ScalarVariable' => 125,
			'Operator' => 115,
			'ArrayLiteralNonEmpty' => 117,
			'LoopLabel' => 158,
			'HashVariable' => 118,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'VariableModification' => 160,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarLiteral' => 129,
			'VariableDeclaration' => 164,
			'ArrayVariable' => 131,
			'BracketsEmpty' => 96,
			'PAREN-47' => 97,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'OPTIONAL-48' => 140,
			'Conditional' => 100,
			'Expression' => 134,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'SubExpression' => 95,
			'Scalar' => 109,
			'HashReferenceVariable' => 110,
			'OperatorVoid' => 152,
			'WordScoped' => 112,
			'Operation' => 512,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'Variable' => 108
		}
	},
	{#State 490
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163
		},
		GOTOS => {
			'SubExpressions' => 513,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 290,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayVariable' => 196,
			'ArrayReference' => 107
		}
	},
	{#State 491
		DEFAULT => -197
	},
	{#State 492
		ACTIONS => {
			"%{" => 119,
			'STDIN' => 339,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'FHREF_SYMBOL_IN' => 338,
			'WORD_SCOPED' => 29,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106
		},
		GOTOS => {
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'SubExpressionOrInput' => 514,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'Array' => 161,
			'HashReference' => 162,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 340,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115
		}
	},
	{#State 493
		ACTIONS => {
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 518,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'OP01_NAMED_SCOLON' => 517,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP22_LOGICAL_NEG' => 168,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126
		},
		GOTOS => {
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'OpNamedScolonOrSubExp' => 516,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 515,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161
		}
	},
	{#State 494
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113
		},
		GOTOS => {
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 193,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 519,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'WordScoped' => 112,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'Scalar' => 109,
			'HashReferenceVariable' => 202,
			'ArrayDereference' => 132,
			'ArrayReference' => 107,
			'ArrayVariable' => 196,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104
		}
	},
	{#State 495
		ACTIONS => {
			'OP21_LIST_COMMA' => 520
		}
	},
	{#State 496
		DEFAULT => -101
	},
	{#State 497
		DEFAULT => -313
	},
	{#State 498
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 521
		}
	},
	{#State 499
		ACTIONS => {
			'LBRACE' => 522
		}
	},
	{#State 500
		DEFAULT => -76
	},
	{#State 501
		ACTIONS => {
			'OP20_HASH_FATARROW' => 523
		}
	},
	{#State 502
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 524
		}
	},
	{#State 503
		ACTIONS => {
			";" => 525
		}
	},
	{#State 504
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -58,
			"if" => -58,
			"while" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'HASH_REF_SYMBOL' => -58,
			'LPAREN_TYPE_INNER' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			"}" => -58,
			'OP10_NAMED_UNARY' => -58,
			'LITERAL_NUMBER' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			"%{" => -58,
			"for" => -58,
			'SELF' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'WORD' => -58,
			"foreach" => -58,
			'OP01_NAMED_SCOLON' => -58,
			'SCALAR_SYMBOL' => -58,
			'WORD_SCOPED' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			"\@{" => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'POD' => -58,
			'OP01_CLOSE' => -58,
			'OP01_NAMED' => -58,
			"undef" => -58,
			'OP01_PRINT' => -58,
			'MY' => -58,
			'LBRACKET' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'WORD_UPPERCASE' => -58,
			'OP01_NAMED_VOID' => -58,
			'LITERAL_STRING' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'LBRACE' => -58,
			'LPAREN_MY' => 526,
			'LPAREN' => -58,
			'HASH_SYMBOL' => -58,
			'OP01_OPEN' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'ARRAY_SYMBOL' => -58,
			'ARRAY_REF_SYMBOL' => -58,
			'OP19_LOOP_CONTROL' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 528,
			'SubroutineArguments' => 527
		}
	},
	{#State 505
		DEFAULT => -263
	},
	{#State 506
		DEFAULT => -188
	},
	{#State 507
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 529
		}
	},
	{#State 508
		DEFAULT => -190
	},
	{#State 509
		DEFAULT => -185
	},
	{#State 510
		ACTIONS => {
			'LPAREN' => 530
		}
	},
	{#State 511
		DEFAULT => -201
	},
	{#State 512
		DEFAULT => -199
	},
	{#State 513
		ACTIONS => {
			")" => 531
		}
	},
	{#State 514
		ACTIONS => {
			")" => 532
		}
	},
	{#State 515
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP08_STRING_CAT' => 179,
			";" => 533,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP18_TERNARY' => 181,
			'OP13_BITWISE_AND' => 186,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176
		}
	},
	{#State 516
		ACTIONS => {
			'SCALAR_SYMBOL' => 534
		}
	},
	{#State 517
		DEFAULT => -308
	},
	{#State 518
		DEFAULT => -309
	},
	{#State 519
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => 535,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => 181,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP06_REGEX_BIND' => 190,
			'OP15_LOGICAL_AND' => 180,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 520
		ACTIONS => {
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113
		},
		GOTOS => {
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'BracketsEmpty' => 96,
			'SubExpression' => 536,
			'HashVariable' => 195,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205,
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161
		}
	},
	{#State 521
		ACTIONS => {
			"undef" => 537
		}
	},
	{#State 522
		ACTIONS => {
			'LBRACE' => 538
		}
	},
	{#State 523
		ACTIONS => {
			'MY' => 539
		},
		GOTOS => {
			'TypeInnerProperties' => 540
		}
	},
	{#State 524
		ACTIONS => {
			"}" => 542,
			'OP21_LIST_COMMA' => 541
		},
		GOTOS => {
			'PAREN-33' => 543
		}
	},
	{#State 525
		DEFAULT => -83
	},
	{#State 526
		ACTIONS => {
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 544
		}
	},
	{#State 527
		DEFAULT => -57
	},
	{#State 528
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 545
		}
	},
	{#State 529
		DEFAULT => -187
	},
	{#State 530
		ACTIONS => {
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'ARRAY_REF_SYMBOL' => 139,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'SELF' => 123,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			"undef" => 113
		},
		GOTOS => {
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 546,
			'HashVariable' => 195
		}
	},
	{#State 531
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 547
		}
	},
	{#State 532
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 548
		}
	},
	{#State 533
		DEFAULT => -310
	},
	{#State 534
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 549
		}
	},
	{#State 535
		ACTIONS => {
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_NAMED' => 206,
			'OP01_CLOSE' => 155,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 135,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123
		},
		GOTOS => {
			'WordScoped' => 112,
			'ArrayDereference' => 132,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarVariable' => 194,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'BracketsEmpty' => 96,
			'HashVariable' => 195,
			'SubExpression' => 550,
			'ArrayLiteralNonEmpty' => 117,
			'HashDereference' => 137,
			'Operator' => 115,
			'ArrayHashLiteralEmpty' => 136,
			'Expression' => 205
		}
	},
	{#State 536
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			")" => -102,
			'OP06_REGEX_BIND' => 190,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			"]" => -102,
			'OP13_BITWISE_AND' => 186,
			";" => -102,
			'OP08_STRING_CAT' => 179,
			'OP17_LIST_RANGE' => 184,
			'OP07_STRING_REPEAT' => 192,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188
		}
	},
	{#State 537
		ACTIONS => {
			";" => 551
		}
	},
	{#State 538
		ACTIONS => {
			'MY' => 552
		}
	},
	{#State 539
		ACTIONS => {
			'TYPE_INTEGER' => 287,
			'WORD_SCOPED' => 288,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 553
		}
	},
	{#State 540
		DEFAULT => -281
	},
	{#State 541
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'WORD' => 254,
			'OP19_LOOP_CONTROL' => 229,
			'OP23_LOGICAL_AND' => 228,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP01_OPEN' => 256,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'OP10_NAMED_UNARY' => 255,
			'OP01_NAMED_VOID' => 232,
			'OP22_LOGICAL_NEG' => 260,
			'OP07_STRING_REPEAT' => 233,
			'OP01_PRINT' => 221,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_NAMED' => 257,
			'OP01_CLOSE' => 258,
			'OP11_COMPARE_LT_GT' => 226
		},
		GOTOS => {
			'HashEntryProperties' => 554,
			'OpStringOrWord' => 501
		}
	},
	{#State 542
		ACTIONS => {
			";" => 555
		}
	},
	{#State 543
		DEFAULT => -80
	},
	{#State 544
		ACTIONS => {
			'SCALAR_SYMBOL' => 556
		}
	},
	{#State 545
		ACTIONS => {
			'MY' => 146,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 145,
			'OP01_NAMED_VOID' => 148,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID_SCOLON' => 150,
			'LBRACE' => 106,
			'OP01_NAMED_VOID_LPAREN' => 153,
			'POD' => 151,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 154,
			"undef" => 113,
			'OP01_PRINT' => 111,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 138,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'LPAREN_TYPE_INNER' => 126,
			"}" => 558,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG' => 168,
			"if" => 133,
			"while" => -177,
			'WORD' => 28,
			"foreach" => -177,
			'OP01_NAMED_SCOLON' => 114,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			"for" => -177,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 122
		},
		GOTOS => {
			'PAREN-47' => 97,
			'BracketsEmpty' => 96,
			'ArrayHashLiteral' => 99,
			'OPTIONAL-48' => 140,
			'Hash' => 98,
			'Conditional' => 100,
			'ArrayHashLiteralEmpty' => 136,
			'HashDereference' => 137,
			'Expression' => 134,
			'SubExpression' => 95,
			'OperatorVoid' => 152,
			'Scalar' => 109,
			'HashReferenceVariable' => 110,
			'WordScoped' => 112,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'Operation' => 557,
			'ArrayReference' => 107,
			'Variable' => 108,
			'Statement' => 121,
			'ScalarVariable' => 125,
			'ArrayReferenceVariable' => 124,
			'Operator' => 115,
			'LoopLabel' => 158,
			'HashVariable' => 118,
			'ArrayLiteralNonEmpty' => 117,
			'ArrayDereference' => 132,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'VariableModification' => 160,
			'VariableDeclaration' => 164,
			'ArrayVariable' => 131
		}
	},
	{#State 546
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP15_LOGICAL_AND' => 180,
			")" => 559,
			'OP06_REGEX_BIND' => 190,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 547
		DEFAULT => -196
	},
	{#State 548
		DEFAULT => -198
	},
	{#State 549
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 517,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_SCOPED' => 29,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP10_NAMED_UNARY_SCOLON' => 518,
			'SELF' => 123,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'LITERAL_NUMBER' => 163,
			'LBRACE' => 106,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP22_LOGICAL_NEG' => 168,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			"undef" => 113
		},
		GOTOS => {
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'BracesEmpty' => 147,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayReferenceVariable' => 193,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'OpNamedScolonOrSubExp' => 560,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 515,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115
		}
	},
	{#State 550
		ACTIONS => {
			'OP23_LOGICAL_AND' => -124,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP06_REGEX_BIND' => 190,
			")" => 561,
			'OP15_LOGICAL_AND' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP18_TERNARY' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_MATH_ADD_SUB' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 192,
			'OP08_STRING_CAT' => 179
		}
	},
	{#State 551
		DEFAULT => -216
	},
	{#State 552
		ACTIONS => {
			'TYPE_METHOD' => 562,
			'TYPE_INTEGER' => 287,
			'WORD_SCOPED' => 288,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 391
		}
	},
	{#State 553
		ACTIONS => {
			"\$TYPED_" => 563
		}
	},
	{#State 554
		DEFAULT => -79
	},
	{#State 555
		DEFAULT => -82
	},
	{#State 556
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 564
		}
	},
	{#State 557
		DEFAULT => -59
	},
	{#State 558
		DEFAULT => -61
	},
	{#State 559
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 565
		}
	},
	{#State 560
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130
		},
		GOTOS => {
			'BracketsEmpty' => 96,
			'Hash' => 98,
			'ArrayHashLiteral' => 99,
			'ArrayReferenceVariable' => 124,
			'SubExpressionOrVarMod' => 566,
			'ScalarVariable' => 125,
			'Expression' => 205,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'HashDereference' => 137,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 568,
			'HashVariable' => 118,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ScalarVariableOrSelf' => 167,
			'HashReferenceVariable' => 110,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'VariableModification' => 567,
			'Array' => 161,
			'HashReference' => 162,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'ArrayReference' => 107,
			'Variable' => 108,
			'ArrayVariable' => 131
		}
	},
	{#State 561
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 569
		}
	},
	{#State 562
		ACTIONS => {
			"\$RETURN_TYPE" => 570
		}
	},
	{#State 563
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP19_LOOP_CONTROL_SCOLON' => 215,
			'OP10_NAMED_UNARY' => 255,
			'OP01_NAMED_VOID' => 232,
			'OP22_LOGICAL_NEG' => 260,
			'OP07_STRING_REPEAT' => 233,
			'OP11_COMPARE_LT_GT' => 226,
			'OP01_NAMED' => 257,
			'OP08_MATH_ADD_SUB' => 220,
			'OP01_CLOSE' => 258,
			'OP01_PRINT' => 221,
			'WORD' => 254,
			'OP07_MATH_MULT_DIV_MOD' => 212,
			'OP23_LOGICAL_AND' => 228,
			'OP19_LOOP_CONTROL' => 229,
			'OP12_COMPARE_EQ_NE' => 222,
			'OP01_OPEN' => 256
		},
		GOTOS => {
			'OpStringOrWord' => 571
		}
	},
	{#State 564
		ACTIONS => {
			")" => 572,
			'OP21_LIST_COMMA' => 573
		},
		GOTOS => {
			'PAREN-26' => 574
		}
	},
	{#State 565
		DEFAULT => -184
	},
	{#State 566
		ACTIONS => {
			")" => 575
		}
	},
	{#State 567
		DEFAULT => -174
	},
	{#State 568
		ACTIONS => {
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			")" => -173,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP16_LOGICAL_OR' => 176,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP23_LOGICAL_AND' => 189
		}
	},
	{#State 569
		DEFAULT => -194
	},
	{#State 570
		ACTIONS => {
			"}" => 576
		}
	},
	{#State 571
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 578,
			'OP19_VARIABLE_ASSIGN' => 577
		}
	},
	{#State 572
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 579
		}
	},
	{#State 573
		ACTIONS => {
			'MY' => 580
		}
	},
	{#State 574
		DEFAULT => -63
	},
	{#State 575
		ACTIONS => {
			'LBRACE' => 453
		},
		GOTOS => {
			'CodeBlock' => 581
		}
	},
	{#State 576
		ACTIONS => {
			";" => 582
		}
	},
	{#State 577
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'ARRAY_SYMBOL' => 135,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 94,
			'CONSTANT_CALL_SCOPED' => 156,
			"\@{" => 116,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG' => 168,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'WORD_UPPERCASE' => 208,
			'OP05_MATH_NEG_LPAREN' => 159,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LPAREN_TYPE_INNER' => 126,
			'HASH_REF_SYMBOL' => 127,
			'LBRACKET' => 103,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 149
		},
		GOTOS => {
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194,
			'BracketsEmpty' => 96,
			'ArrayLiteralNonEmpty' => 117,
			'SubExpression' => 583,
			'HashVariable' => 195,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'WordScoped' => 112,
			'HashReferenceVariable' => 202,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'Scalar' => 109,
			'ArrayDereference' => 132,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'BracesEmpty' => 147,
			'ScalarLiteral' => 129,
			'HashReferenceLiteral' => 104,
			'HashReference' => 162,
			'Array' => 161
		}
	},
	{#State 578
		ACTIONS => {
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'WORD_SCOPED' => 29,
			'SCALAR_SYMBOL' => 157,
			'ARRAY_REF_SYMBOL' => 139,
			'ARRAY_SYMBOL' => 135,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 141,
			'OP01_OPEN' => 142,
			'SELF' => 123,
			'HASH_SYMBOL' => 101,
			'LPAREN' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 163,
			'LITERAL_STRING' => 149,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 159,
			'WORD_UPPERCASE' => 208,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'LBRACKET' => 103,
			'HASH_REF_SYMBOL' => 127,
			"undef" => 113,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 206,
			'OP22_LOGICAL_NEG' => 168
		},
		GOTOS => {
			'BracesEmpty' => 147,
			'HashReferenceLiteral' => 104,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'ArrayVariable' => 196,
			'ArrayReference' => 107,
			'HashReferenceVariable' => 202,
			'Scalar' => 109,
			'ArrayReferenceLiteral' => 166,
			'ScalarVariableOrSelf' => 167,
			'ArrayDereference' => 132,
			'WordScoped' => 112,
			'Expression' => 205,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Operator' => 115,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 195,
			'SubExpression' => 584,
			'BracketsEmpty' => 96,
			'ArrayReferenceVariable' => 193,
			'ArrayHashLiteral' => 99,
			'Hash' => 98,
			'ScalarVariable' => 194
		}
	},
	{#State 579
		ACTIONS => {
			"\@ARG;" => 585
		}
	},
	{#State 580
		ACTIONS => {
			'WORD' => 289,
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287
		},
		GOTOS => {
			'Type' => 586
		}
	},
	{#State 581
		DEFAULT => -195
	},
	{#State 582
		ACTIONS => {
			'WORD_SCOPED' => -85,
			'SCALAR_SYMBOL' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			"\@{" => -85,
			"foreach" => -85,
			'WORD' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'SELF' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			"for" => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			"%{" => -85,
			'OP10_NAMED_UNARY' => -85,
			'LITERAL_NUMBER' => -85,
			'HASH_REF_SYMBOL' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			"}" => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'LPAREN_TYPE_INNER' => -85,
			"if" => -85,
			"while" => -85,
			'OP22_LOGICAL_NEG' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'ARRAY_SYMBOL' => -85,
			'HASH_SYMBOL' => -85,
			'LPAREN' => -85,
			'OP01_OPEN' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP01_NAMED_VOID' => -85,
			'LITERAL_STRING' => -85,
			'LBRACE' => -85,
			'LPAREN_MY' => 588,
			'LBRACKET' => -85,
			'MY' => -85,
			'WORD_UPPERCASE' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			"undef" => -85,
			'OP01_CLOSE' => -85,
			'OP01_NAMED' => -85,
			'OP01_PRINT' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'POD' => -85
		},
		GOTOS => {
			'MethodArguments' => 587,
			'OPTIONAL-35' => 589
		}
	},
	{#State 583
		ACTIONS => {
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP21_LIST_COMMA' => -300,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 186,
			"}" => -300,
			'OP24_LOGICAL_OR_XOR' => 187,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 584
		ACTIONS => {
			'OP15_LOGICAL_AND' => 180,
			'OP06_REGEX_BIND' => 190,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP23_LOGICAL_AND' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 178,
			'OP14_BITWISE_OR_XOR' => 177,
			'OP16_LOGICAL_OR' => 176,
			'OP08_MATH_ADD_SUB' => 182,
			'OP11_COMPARE_LT_GT' => 188,
			'OP08_STRING_CAT' => 179,
			'OP07_STRING_REPEAT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 181,
			'OP04_MATH_POW' => 191,
			"]" => 590,
			'OP13_BITWISE_AND' => 186,
			'OP24_LOGICAL_OR_XOR' => 187
		}
	},
	{#State 585
		DEFAULT => -65
	},
	{#State 586
		ACTIONS => {
			'SCALAR_SYMBOL' => 591
		}
	},
	{#State 587
		DEFAULT => -84
	},
	{#State 588
		ACTIONS => {
			'WORD_SCOPED' => 288,
			'TYPE_INTEGER' => 287,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 592
		}
	},
	{#State 589
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 593
		}
	},
	{#State 590
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 594
		}
	},
	{#State 591
		DEFAULT => -62
	},
	{#State 592
		ACTIONS => {
			'SELF' => 595
		}
	},
	{#State 593
		ACTIONS => {
			'WORD' => 28,
			"foreach" => -177,
			'OP01_NAMED_SCOLON' => 114,
			'SCALAR_SYMBOL' => 157,
			'WORD_SCOPED' => 29,
			"\@{" => 116,
			'CONSTANT_CALL_SCOPED' => 156,
			'OP22_LOGICAL_NEG_LPAREN' => 120,
			"%{" => 119,
			"for" => -177,
			'SELF' => 123,
			'OP10_NAMED_UNARY_SCOLON' => 122,
			'HASH_REF_SYMBOL' => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 128,
			'LPAREN_TYPE_INNER' => 126,
			'OP05_MATH_NEG_LPAREN' => 159,
			"}" => 597,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_NUMBER' => 163,
			'OP22_LOGICAL_NEG' => 168,
			"if" => 133,
			"while" => -177,
			'OP03_MATH_INC_DEC' => 94,
			'ARRAY_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 138,
			'LPAREN' => 143,
			'HASH_SYMBOL' => 101,
			'OP01_OPEN' => 142,
			'OP05_LOGICAL_NEG' => 141,
			'MY' => 146,
			'LBRACKET' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 144,
			'WORD_UPPERCASE' => 145,
			'OP01_NAMED_VOID' => 148,
			'LITERAL_STRING' => 149,
			'OP01_NAMED_VOID_SCOLON' => 150,
			'LBRACE' => 106,
			'OP01_NAMED_VOID_LPAREN' => 153,
			'POD' => 151,
			'OP01_CLOSE' => 155,
			'OP01_NAMED' => 154,
			"undef" => 113,
			'OP01_PRINT' => 111
		},
		GOTOS => {
			'SubExpression' => 95,
			'Expression' => 134,
			'HashDereference' => 137,
			'ArrayHashLiteralEmpty' => 136,
			'Conditional' => 100,
			'ArrayHashLiteral' => 99,
			'OPTIONAL-48' => 140,
			'Hash' => 98,
			'PAREN-47' => 97,
			'BracketsEmpty' => 96,
			'Variable' => 108,
			'ArrayReference' => 107,
			'Operation' => 596,
			'HashReferenceLiteral' => 104,
			'BracesEmpty' => 147,
			'WordScoped' => 112,
			'HashReferenceVariable' => 110,
			'Scalar' => 109,
			'OperatorVoid' => 152,
			'ArrayLiteralNonEmpty' => 117,
			'HashVariable' => 118,
			'LoopLabel' => 158,
			'Operator' => 115,
			'ArrayReferenceVariable' => 124,
			'ScalarVariable' => 125,
			'Statement' => 121,
			'VariableDeclaration' => 164,
			'ArrayVariable' => 131,
			'VariableModification' => 160,
			'ScalarLiteral' => 129,
			'HashReference' => 162,
			'Array' => 161,
			'ScalarVariableOrSelf' => 167,
			'ArrayReferenceLiteral' => 166,
			'ArrayDereference' => 132
		}
	},
	{#State 594
		ACTIONS => {
			"undef" => 598
		}
	},
	{#State 595
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 599
		}
	},
	{#State 596
		DEFAULT => -86
	},
	{#State 597
		DEFAULT => -88
	},
	{#State 598
		DEFAULT => -301
	},
	{#State 599
		ACTIONS => {
			'OP21_LIST_COMMA' => 601,
			")" => 600
		},
		GOTOS => {
			'PAREN-37' => 602
		}
	},
	{#State 600
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 603
		}
	},
	{#State 601
		ACTIONS => {
			'MY' => 604
		}
	},
	{#State 602
		DEFAULT => -90
	},
	{#State 603
		ACTIONS => {
			"\@ARG;" => 605
		}
	},
	{#State 604
		ACTIONS => {
			'TYPE_INTEGER' => 287,
			'WORD_SCOPED' => 288,
			'WORD' => 289
		},
		GOTOS => {
			'Type' => 606
		}
	},
	{#State 605
		DEFAULT => -92
	},
	{#State 606
		ACTIONS => {
			'SCALAR_SYMBOL' => 607
		}
	},
	{#State 607
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 10093 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10100 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10107 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10114 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10125 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10136 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10143 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10178 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10185 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10206 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10213 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10220 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10231 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10238 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10245 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10252 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10259 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10270 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10281 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10306 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10313 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10327 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10334 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10341 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10348 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10355 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10362 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10373 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10380 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10387 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10398 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10405 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10412 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10423 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10444 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10451 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10465 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10476 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10483 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10490 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10497 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10504 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10515 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10526 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10544 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10551 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10558 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10565 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10576 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10583 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10590 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10597 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10608 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10615 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10622 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10629 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10636 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10643 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10650 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10657 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10664 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10671 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10678 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10689 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10700 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10711 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10718 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10725 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10732 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10743 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10754 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10761 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10768 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10775 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10782 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10793 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10800 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10807 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10814 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10825 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10836 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10847 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10858 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10869 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10880 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10891 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10902 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10913 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10924 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10935 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10946 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10957 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10968 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10979 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10990 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11001 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11012 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11023 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11034 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11045 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11056 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11067 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11078 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11089 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11100 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11111 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11122 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11133 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11144 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11155 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11166 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11177 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11188 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11199 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11210 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11221 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11232 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11239 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11246 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11253 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11260 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11267 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11278 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11289 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11300 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11311 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11322 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11333 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11344 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11355 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11362 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11369 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11376 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11383 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11390 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11397 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11408 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11419 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11430 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11441 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11452 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11463 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11474 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11485 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11496 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11507 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11518 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11529 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11540 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11551 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11562 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_164
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11573 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_165
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11584 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11591 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11598 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11605 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressions_169
		 'SubExpressions', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11616 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_170
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11627 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_171
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11638 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_172
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11649 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_173
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11660 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_174
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11671 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11678 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11685 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11692 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_178
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11703 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_179
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11714 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_180
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11725 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_181
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11736 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_182
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11747 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_183
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11758 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 5,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11772 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11779 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11786 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11800 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_190
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11811 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_191
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11822 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_192
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11833 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_193
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11844 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_194
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11855 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_195
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11866 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_196
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11877 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_197
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11888 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_198
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11899 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 265 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11906 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 265 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11913 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_201
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11924 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_202
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11935 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_203
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11946 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_204
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11957 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_205
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11968 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_206
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11979 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_207
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11990 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_208
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12001 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_209
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12012 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_210
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12023 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_211
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12034 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_212
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12045 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_213
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12056 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_214
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12067 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_215
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12078 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_216
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12089 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_217
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12100 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_218
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12111 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_219
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12122 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_220
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12133 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_221
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12144 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_222
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12155 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_223
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12166 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_224
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12177 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_225
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12188 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_226
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12199 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_227
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12210 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 292 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12217 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 292 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12224 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_230
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12235 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_231
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12246 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_232
		 'ScalarVariable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12257 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_233
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12268 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_234
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12279 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteral_235
		 'ArrayHashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12290 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12297 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12304 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12311 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEs_239
		 'ArrayHashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12322 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 299 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12329 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 299 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12336 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 299 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12343 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralEs_243
		 'ArrayLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12354 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-59', 2,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12361 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 2,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12368 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 0,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12375 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralEs_247
		 'HashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12386 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_248
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12397 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_249
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12408 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_250
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12419 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_251
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12430 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_252
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12441 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_253
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12452 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_254
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12463 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEmpty_255
		 'ArrayHashLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12474 lib/RPerl/Grammar.pm
	],
	[#Rule BracketsEmpty_256
		 'BracketsEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12485 lib/RPerl/Grammar.pm
	],
	[#Rule BracesEmpty_257
		 'BracesEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12496 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_258
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12507 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_259
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12518 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_260
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12529 lib/RPerl/Grammar.pm
	],
	[#Rule Array_261
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12540 lib/RPerl/Grammar.pm
	],
	[#Rule Array_262
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12551 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 326 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12558 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 326 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12565 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 326 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12572 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralNonEmpty_266
		 'ArrayLiteralNonEmpty', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12583 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_267
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12594 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_268
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12605 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_269
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12616 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_270
		 'ArrayReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12627 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_271
		 'ArrayReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12638 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceVariable_272
		 'ArrayReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 1,
sub {
#line 337 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 0,
sub {
#line 337 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12663 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_275
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12674 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_276
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12685 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 1,
sub {
#line 342 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 0,
sub {
#line 342 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12699 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_279
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12710 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_280
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12721 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_281
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12732 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_282
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12743 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_283
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12754 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_284
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12765 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_285
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12776 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_286
		 'HashReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12787 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_287
		 'HashReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12798 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceVariable_288
		 'HashReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12809 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 1,
sub {
#line 363 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12816 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 0,
sub {
#line 363 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12823 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_291
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12834 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_292
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12845 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_293
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12856 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_294
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12867 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_295
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12878 lib/RPerl/Grammar.pm
	],
	[#Rule Type_296
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12889 lib/RPerl/Grammar.pm
	],
	[#Rule Type_297
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12900 lib/RPerl/Grammar.pm
	],
	[#Rule Type_298
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12911 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_299
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12922 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_300
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12933 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_301
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12944 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_302
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12955 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_303
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12966 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_304
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12977 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_305
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12988 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_306
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12999 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_307
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13010 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_308
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13021 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_309
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13032 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_310
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13043 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_311
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13054 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_312
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13065 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_313
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13076 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_314
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13087 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_315
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13098 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_316
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13109 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_317
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13120 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_318
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13131 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_319
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13142 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_320
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13153 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_321
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13164 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_322
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13175 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_323
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13186 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_324
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13197 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_325
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13208 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_326
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13219 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_327
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13230 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_328
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13241 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_329
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13252 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_330
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13263 lib/RPerl/Grammar.pm
	]
],
#line 13266 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubExpressions_169', 
         'SubExpressionOrInput_170', 
         'SubExpressionOrInput_171', 
         'SubExpressionOrInput_172', 
         'SubExpressionOrVarMod_173', 
         'SubExpressionOrVarMod_174', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_178', 
         'Statement_179', 
         'Statement_180', 
         'Statement_181', 
         'Statement_182', 
         'Statement_183', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_190', 
         'Loop_191', 
         'Loop_192', 
         'Loop_193', 
         'LoopFor_194', 
         'LoopFor_195', 
         'LoopForEach_196', 
         'LoopWhile_197', 
         'LoopWhile_198', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_201', 
         'Variable_202', 
         'Variable_203', 
         'Variable_204', 
         'Variable_205', 
         'Variable_206', 
         'VariableRetrievalArrow_207', 
         'VariableRetrievalArrow_208', 
         'VariableRetrievalArrow_209', 
         'VariableRetrieval_210', 
         'VariableRetrieval_211', 
         'VariableRetrieval_212', 
         'VariableRetrieval_213', 
         'VariableDeclaration_214', 
         'VariableDeclaration_215', 
         'VariableDeclaration_216', 
         'VariableDeclaration_217', 
         'VariableDeclaration_218', 
         'VariableDeclaration_219', 
         'VariableDeclaration_220', 
         'VariableDeclaration_221', 
         'VariableModification_222', 
         'VariableModification_223', 
         'Scalar_224', 
         'Scalar_225', 
         'ScalarLiteral_226', 
         'ScalarLiteral_227', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ScalarVariable_230', 
         'ScalarVariable_231', 
         'ScalarVariable_232', 
         'ScalarVariableOrSelf_233', 
         'ScalarVariableOrSelf_234', 
         'ArrayHashLiteral_235', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayHashLiteralEs_239', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayLiteralEs_243', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashLiteralEs_247', 
         'ArrayLiteralE_248', 
         'ArrayLiteralE_249', 
         'HashLiteralE_250', 
         'HashLiteralE_251', 
         'ArrayHashLiteralE_252', 
         'ArrayHashLiteralE_253', 
         'ArrayHashLiteralE_254', 
         'ArrayHashLiteralEmpty_255', 
         'BracketsEmpty_256', 
         'BracesEmpty_257', 
         'ListElement_258', 
         'ListElement_259', 
         'ListElement_260', 
         'Array_261', 
         'Array_262', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayLiteralNonEmpty_266', 
         'ArrayVariable_267', 
         'ArrayReference_268', 
         'ArrayReference_269', 
         'ArrayReferenceLiteral_270', 
         'ArrayReferenceLiteral_271', 
         'ArrayReferenceVariable_272', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_275', 
         'ArrayDereference_276', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_279', 
         'HashEntry_280', 
         'HashEntryProperties_281', 
         'Hash_282', 
         'HashVariable_283', 
         'HashReference_284', 
         'HashReference_285', 
         'HashReferenceLiteral_286', 
         'HashReferenceLiteral_287', 
         'HashReferenceVariable_288', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_291', 
         'HashDereference_292', 
         'WordScoped_293', 
         'WordScoped_294', 
         'LoopLabel_295', 
         'Type_296', 
         'Type_297', 
         'Type_298', 
         'TypeInner_299', 
         'TypeInnerProperties_300', 
         'TypeInnerProperties_301', 
         'TypeInnerConstant_302', 
         'ScalarVariableOrLiteral_303', 
         'ScalarVariableOrLiteral_304', 
         'ScaVarOrLitOrOpStrOrWord_305', 
         'ScaVarOrLitOrOpStrOrWord_306', 
         'ScaVarOrLitOrOpStrOrWord_307', 
         'OpNamedScolonOrSubExp_308', 
         'OpNamedScolonOrSubExp_309', 
         'OpNamedScolonOrSubExp_310', 
         'OpNamedScolonOrSubExpIn_311', 
         'OpNamedScolonOrSubExpIn_312', 
         'OpNamedScolonOrSubExpIn_313', 
         'OpStringOrWord_314', 
         'OpStringOrWord_315', 
         'OpStringOrWord_316', 
         'OpStringOrWord_317', 
         'OpStringOrWord_318', 
         'OpStringOrWord_319', 
         'OpStringOrWord_320', 
         'OpStringOrWord_321', 
         'OpStringOrWord_322', 
         'OpStringOrWord_323', 
         'OpStringOrWord_324', 
         'OpStringOrWord_325', 
         'OpStringOrWord_326', 
         'OpStringOrWord_327', 
         'OpStringOrWord_328', 
         'OpStringOrWord_329', 
         'OpStringOrWord_330', );
  $self;
}

#line 382 "lib/RPerl/Grammar.eyp"


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
Operator_125 => 'RPerl::Operation::Expression::Operator::Ternary',                           # Operator -> SubExpression OP18_TERNARY ScalarVariableOrLiteral COLON ScalarVariableOrLiteral
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
HashEntry_225 => 'RPerl::DataStructure::Hash::Entry',                                              # HashEntry -> ScaVarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
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
ScalarVariableOrLiteral_248 => 'RPerl::Operation::Expression::SubExpression::Variable',                  # ScalarVariableOrLiteral -> Variable
ScalarVariableOrLiteral_249 => 'RPerl::Operation::Expression::SubExpression::Literal',                   # ScalarVariableOrLiteral -> Literal
ScaVarOrLitOrOpStrOrWord_250 => 'RPerl::Operation::Expression::SubExpression::Variable',              # ScaVarOrLitOrOpStrOrWord -> Variable
ScaVarOrLitOrOpStrOrWord_251 => 'RPerl::Operation::Expression::SubExpression::Literal',               # ScaVarOrLitOrOpStrOrWord -> Literal
ScaVarOrLitOrOpStrOrWord_252 => 'RPerl::NonGenerator',                                                # ScaVarOrLitOrOpStrOrWord -> OpStringOrWord
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


#line 13813 lib/RPerl/Grammar.pm



1;
