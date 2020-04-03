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
    our $VERSION = 0.023_100;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|foreach|\$TYPED_|package|elsif|\@ARG\;|while|undef|INIT|else|for|if|\@\{|\%\{|\)|\;|\}|\])}gc and return ($1, $1);

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
  [ 'Operator_100' => 'Operator', [ 'OP01_QW' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpressions', ')' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'OP03_MATH_INC_DEC', 'ScalarVariable' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'ScalarVariable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP05_BITWISE_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP06_REGEX_BIND', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_114' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_115' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_116' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_117' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_118' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_119' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_120' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_121' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_122' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_123' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_124' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_125' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_126' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'ScalarVariableOrLiteral', 'COLON', 'ScalarVariableOrLiteral' ], 0 ],
  [ 'Operator_127' => 'Operator', [ 'OP22_LOGICAL_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_128' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_129' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_130' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'OperatorVoid_136' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-40', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_137' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_138' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_139' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-41', ')', ';' ], 0 ],
  [ 'OperatorVoid_140' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_141' => 'OperatorVoid', [ 'OP01_NAMED', 'SubExpression', 'OP21_LIST_COMMA', 'SubExpressions', ';' ], 0 ],
  [ 'OperatorVoid_142' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_143' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'SubExpressions' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [ 'HashReference' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-44', [  ], 0 ],
  [ 'Expression_150' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_151' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_152' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_153' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-42', ')' ], 0 ],
  [ 'Expression_154' => 'Expression', [ 'ScalarVariable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-43', ')' ], 0 ],
  [ 'Expression_155' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', 'OPTIONAL-44', ')' ], 0 ],
  [ 'SubExpression_156' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_157' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_158' => 'SubExpression', [ 'Scalar' ], 0 ],
  [ 'SubExpression_159' => 'SubExpression', [ 'ArrayHashLiteralEmpty' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'ArrayHashLiteral' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'Array' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_163' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_164' => 'SubExpression', [ 'Hash' ], 0 ],
  [ 'SubExpression_165' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_166' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'SubExpressions_170' => 'SubExpressions', [ 'SubExpression', 'STAR-46' ], 0 ],
  [ 'SubExpressionOrInput_171' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_172' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_173' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_174' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_175' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Statement_179' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_180' => 'Statement', [ 'OPTIONAL-48', 'Loop' ], 0 ],
  [ 'Statement_181' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_182' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_183' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ 'Statement_184' => 'Statement', [ 'POD' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'PAREN-51' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'Conditional_191' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-50', 'OPTIONAL-52' ], 0 ],
  [ 'Loop_192' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_193' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_194' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_195' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_196' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'SCALAR_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_197' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpressions', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_198' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_199' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'Operation' ], 0 ],
  [ 'CodeBlock_202' => 'CodeBlock', [ 'LBRACE', 'PLUS-53', '}' ], 0 ],
  [ 'Variable_203' => 'Variable', [ 'ScalarVariable' ], 0 ],
  [ 'Variable_204' => 'Variable', [ 'ArrayVariable' ], 0 ],
  [ 'Variable_205' => 'Variable', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'Variable_206' => 'Variable', [ 'HashVariable' ], 0 ],
  [ 'Variable_207' => 'Variable', [ 'HashReferenceVariable' ], 0 ],
  [ 'VariableRetrievalArrow_208' => 'VariableRetrievalArrow', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalArrow_209' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalArrow_210' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableRetrieval_211' => 'VariableRetrieval', [ 'VariableRetrievalArrow' ], 0 ],
  [ 'VariableRetrieval_212' => 'VariableRetrieval', [ 'LBRACKET', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_213' => 'VariableRetrieval', [ 'LBRACE', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_214' => 'VariableRetrieval', [ 'LBRACE', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_215' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_216' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_217' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_218' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_219' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_220' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_221' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_222' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_223' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_224' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ 'Scalar_225' => 'Scalar', [ 'ScalarLiteral' ], 0 ],
  [ 'Scalar_226' => 'Scalar', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarLiteral_227' => 'ScalarLiteral', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'ScalarLiteral_228' => 'ScalarLiteral', [ 'LITERAL_STRING' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'PLUS-54', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'VariableRetrieval' ], 0 ],
  [ 'ScalarVariable_231' => 'ScalarVariable', [ 'ScalarVariableOrSelf' ], 0 ],
  [ 'ScalarVariable_232' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow' ], 0 ],
  [ 'ScalarVariable_233' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow', 'PLUS-54' ], 0 ],
  [ 'ScalarVariableOrSelf_234' => 'ScalarVariableOrSelf', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarVariableOrSelf_235' => 'ScalarVariableOrSelf', [ 'SELF' ], 0 ],
  [ 'ArrayHashLiteral_236' => 'ArrayHashLiteral', [ 'LPAREN', 'ArrayHashLiteralEs', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ArrayHashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'ArrayHashLiteralEs_240' => 'ArrayHashLiteralEs', [ 'ArrayHashLiteralE', 'STAR-56' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ArrayLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'ArrayLiteralEs_244' => 'ArrayLiteralEs', [ 'ArrayLiteralE', 'STAR-58' ], 0 ],
  [ '_PAREN' => 'PAREN-59', [ 'OP21_LIST_COMMA', 'HashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [ 'STAR-60', 'PAREN-59' ], 0 ],
  [ '_STAR_LIST' => 'STAR-60', [  ], 0 ],
  [ 'HashLiteralEs_248' => 'HashLiteralEs', [ 'HashLiteralE', 'STAR-60' ], 0 ],
  [ 'ArrayLiteralE_249' => 'ArrayLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayLiteralE_250' => 'ArrayLiteralE', [ 'ListElement' ], 0 ],
  [ 'HashLiteralE_251' => 'HashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'HashLiteralE_252' => 'HashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralE_253' => 'ArrayHashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayHashLiteralE_254' => 'ArrayHashLiteralE', [ 'ListElement' ], 0 ],
  [ 'ArrayHashLiteralE_255' => 'ArrayHashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralEmpty_256' => 'ArrayHashLiteralEmpty', [ 'LPAREN', ')' ], 0 ],
  [ 'ArrayRefLiteralEmpty_257' => 'ArrayRefLiteralEmpty', [ 'LBRACKET', ']' ], 0 ],
  [ 'HashRefLiteralEmpty_258' => 'HashRefLiteralEmpty', [ 'LBRACE', '}' ], 0 ],
  [ 'ListElement_259' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-61', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [ 'STAR-62', 'PAREN-61' ], 0 ],
  [ '_STAR_LIST' => 'STAR-62', [  ], 0 ],
  [ 'Array_263' => 'Array', [ 'LPAREN_TYPE_INNER', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression', 'STAR-62', ')' ], 0 ],
  [ 'Array_264' => 'Array', [ 'ArrayVariable' ], 0 ],
  [ 'ArrayVariable_265' => 'ArrayVariable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'ArrayVariable_266' => 'ArrayVariable', [ 'ARGV' ], 0 ],
  [ 'ArrayReference_267' => 'ArrayReference', [ 'ArrayReferenceLiteral' ], 0 ],
  [ 'ArrayReference_268' => 'ArrayReference', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'ArrayReferenceLiteral_269' => 'ArrayReferenceLiteral', [ 'LBRACKET', 'ArrayLiteralEs', ']' ], 0 ],
  [ 'ArrayReferenceLiteral_270' => 'ArrayReferenceLiteral', [ 'ArrayRefLiteralEmpty' ], 0 ],
  [ 'ArrayReferenceVariable_271' => 'ArrayReferenceVariable', [ 'ARRAY_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [  ], 0 ],
  [ 'ArrayDereference_274' => 'ArrayDereference', [ '@{', 'ScalarVariable', '}' ], 0 ],
  [ 'ArrayDereference_275' => 'ArrayDereference', [ '@{', 'OPTIONAL-63', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [  ], 0 ],
  [ 'HashEntry_278' => 'HashEntry', [ 'ScaVarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-64', 'SubExpression' ], 0 ],
  [ 'HashEntryProperties_279' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ 'Hash_280' => 'Hash', [ 'HashVariable' ], 0 ],
  [ 'HashVariable_281' => 'HashVariable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'HashVariable_282' => 'HashVariable', [ 'ENV' ], 0 ],
  [ 'HashReference_283' => 'HashReference', [ 'HashReferenceLiteral' ], 0 ],
  [ 'HashReference_284' => 'HashReference', [ 'HashReferenceVariable' ], 0 ],
  [ 'HashReferenceLiteral_285' => 'HashReferenceLiteral', [ 'LBRACE', 'HashLiteralEs', '}' ], 0 ],
  [ 'HashReferenceLiteral_286' => 'HashReferenceLiteral', [ 'HashRefLiteralEmpty' ], 0 ],
  [ 'HashReferenceVariable_287' => 'HashReferenceVariable', [ 'HASH_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [  ], 0 ],
  [ 'HashDereference_290' => 'HashDereference', [ '%{', 'ScalarVariable', '}' ], 0 ],
  [ 'HashDereference_291' => 'HashDereference', [ '%{', 'OPTIONAL-65', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_292' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_293' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_294' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_295' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_296' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_297' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_298' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_299' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_300' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_301' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'ScalarVariableOrLiteral_302' => 'ScalarVariableOrLiteral', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarVariableOrLiteral_303' => 'ScalarVariableOrLiteral', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_304' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarVariable' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_305' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_306' => 'ScaVarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'OpNamedScolonOrSubExp_307' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_308' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_309' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_310' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_311' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_312' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_313' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_314' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_315' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_316' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_317' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_318' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_319' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_320' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_321' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_322' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_323' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_324' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_325' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_326' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_327' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_328' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_329' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  'Operator_130' => 130,
  '_PAREN' => 131,
  '_OPTIONAL' => 132,
  '_OPTIONAL' => 133,
  '_OPTIONAL' => 134,
  '_OPTIONAL' => 135,
  'OperatorVoid_136' => 136,
  'OperatorVoid_137' => 137,
  'OperatorVoid_138' => 138,
  'OperatorVoid_139' => 139,
  'OperatorVoid_140' => 140,
  'OperatorVoid_141' => 141,
  'OperatorVoid_142' => 142,
  'OperatorVoid_143' => 143,
  '_OPTIONAL' => 144,
  '_OPTIONAL' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  '_OPTIONAL' => 149,
  'Expression_150' => 150,
  'Expression_151' => 151,
  'Expression_152' => 152,
  'Expression_153' => 153,
  'Expression_154' => 154,
  'Expression_155' => 155,
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
  'SubExpression_166' => 166,
  '_PAREN' => 167,
  '_STAR_LIST' => 168,
  '_STAR_LIST' => 169,
  'SubExpressions_170' => 170,
  'SubExpressionOrInput_171' => 171,
  'SubExpressionOrInput_172' => 172,
  'SubExpressionOrInput_173' => 173,
  'SubExpressionOrVarMod_174' => 174,
  'SubExpressionOrVarMod_175' => 175,
  '_PAREN' => 176,
  '_OPTIONAL' => 177,
  '_OPTIONAL' => 178,
  'Statement_179' => 179,
  'Statement_180' => 180,
  'Statement_181' => 181,
  'Statement_182' => 182,
  'Statement_183' => 183,
  'Statement_184' => 184,
  '_PAREN' => 185,
  '_STAR_LIST' => 186,
  '_STAR_LIST' => 187,
  '_PAREN' => 188,
  '_OPTIONAL' => 189,
  '_OPTIONAL' => 190,
  'Conditional_191' => 191,
  'Loop_192' => 192,
  'Loop_193' => 193,
  'Loop_194' => 194,
  'LoopFor_195' => 195,
  'LoopFor_196' => 196,
  'LoopForEach_197' => 197,
  'LoopWhile_198' => 198,
  'LoopWhile_199' => 199,
  '_PLUS_LIST' => 200,
  '_PLUS_LIST' => 201,
  'CodeBlock_202' => 202,
  'Variable_203' => 203,
  'Variable_204' => 204,
  'Variable_205' => 205,
  'Variable_206' => 206,
  'Variable_207' => 207,
  'VariableRetrievalArrow_208' => 208,
  'VariableRetrievalArrow_209' => 209,
  'VariableRetrievalArrow_210' => 210,
  'VariableRetrieval_211' => 211,
  'VariableRetrieval_212' => 212,
  'VariableRetrieval_213' => 213,
  'VariableRetrieval_214' => 214,
  'VariableDeclaration_215' => 215,
  'VariableDeclaration_216' => 216,
  'VariableDeclaration_217' => 217,
  'VariableDeclaration_218' => 218,
  'VariableDeclaration_219' => 219,
  'VariableDeclaration_220' => 220,
  'VariableDeclaration_221' => 221,
  'VariableDeclaration_222' => 222,
  'VariableModification_223' => 223,
  'VariableModification_224' => 224,
  'Scalar_225' => 225,
  'Scalar_226' => 226,
  'ScalarLiteral_227' => 227,
  'ScalarLiteral_228' => 228,
  '_PLUS_LIST' => 229,
  '_PLUS_LIST' => 230,
  'ScalarVariable_231' => 231,
  'ScalarVariable_232' => 232,
  'ScalarVariable_233' => 233,
  'ScalarVariableOrSelf_234' => 234,
  'ScalarVariableOrSelf_235' => 235,
  'ArrayHashLiteral_236' => 236,
  '_PAREN' => 237,
  '_STAR_LIST' => 238,
  '_STAR_LIST' => 239,
  'ArrayHashLiteralEs_240' => 240,
  '_PAREN' => 241,
  '_STAR_LIST' => 242,
  '_STAR_LIST' => 243,
  'ArrayLiteralEs_244' => 244,
  '_PAREN' => 245,
  '_STAR_LIST' => 246,
  '_STAR_LIST' => 247,
  'HashLiteralEs_248' => 248,
  'ArrayLiteralE_249' => 249,
  'ArrayLiteralE_250' => 250,
  'HashLiteralE_251' => 251,
  'HashLiteralE_252' => 252,
  'ArrayHashLiteralE_253' => 253,
  'ArrayHashLiteralE_254' => 254,
  'ArrayHashLiteralE_255' => 255,
  'ArrayHashLiteralEmpty_256' => 256,
  'ArrayRefLiteralEmpty_257' => 257,
  'HashRefLiteralEmpty_258' => 258,
  'ListElement_259' => 259,
  '_PAREN' => 260,
  '_STAR_LIST' => 261,
  '_STAR_LIST' => 262,
  'Array_263' => 263,
  'Array_264' => 264,
  'ArrayVariable_265' => 265,
  'ArrayVariable_266' => 266,
  'ArrayReference_267' => 267,
  'ArrayReference_268' => 268,
  'ArrayReferenceLiteral_269' => 269,
  'ArrayReferenceLiteral_270' => 270,
  'ArrayReferenceVariable_271' => 271,
  '_OPTIONAL' => 272,
  '_OPTIONAL' => 273,
  'ArrayDereference_274' => 274,
  'ArrayDereference_275' => 275,
  '_OPTIONAL' => 276,
  '_OPTIONAL' => 277,
  'HashEntry_278' => 278,
  'HashEntryProperties_279' => 279,
  'Hash_280' => 280,
  'HashVariable_281' => 281,
  'HashVariable_282' => 282,
  'HashReference_283' => 283,
  'HashReference_284' => 284,
  'HashReferenceLiteral_285' => 285,
  'HashReferenceLiteral_286' => 286,
  'HashReferenceVariable_287' => 287,
  '_OPTIONAL' => 288,
  '_OPTIONAL' => 289,
  'HashDereference_290' => 290,
  'HashDereference_291' => 291,
  'WordScoped_292' => 292,
  'WordScoped_293' => 293,
  'LoopLabel_294' => 294,
  'Type_295' => 295,
  'Type_296' => 296,
  'Type_297' => 297,
  'TypeInner_298' => 298,
  'TypeInnerProperties_299' => 299,
  'TypeInnerProperties_300' => 300,
  'TypeInnerConstant_301' => 301,
  'ScalarVariableOrLiteral_302' => 302,
  'ScalarVariableOrLiteral_303' => 303,
  'ScaVarOrLitOrOpStrOrWord_304' => 304,
  'ScaVarOrLitOrOpStrOrWord_305' => 305,
  'ScaVarOrLitOrOpStrOrWord_306' => 306,
  'OpNamedScolonOrSubExp_307' => 307,
  'OpNamedScolonOrSubExp_308' => 308,
  'OpNamedScolonOrSubExp_309' => 309,
  'OpNamedScolonOrSubExpIn_310' => 310,
  'OpNamedScolonOrSubExpIn_311' => 311,
  'OpNamedScolonOrSubExpIn_312' => 312,
  'OpStringOrWord_313' => 313,
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
			'USE_RPERL' => -20,
			"## no critic qw(" => 2,
			'SHEBANG' => 5,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 6,
			'Critic' => 3,
			'OPTIONAL-9' => 1,
			'PLUS-2' => 9,
			'ModuleHeader' => 8,
			'CompileUnit' => 7,
			'Program' => 4
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 11
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-17' => 13
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
			'USE_RPERL' => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-3' => 15,
			'Critic' => 14
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'' => 16
		}
	},
	{#State 8
		ACTIONS => {
			"use parent -norequire, qw(" => 18,
			"use constant" => -27,
			'USE_EXPORTER' => -27,
			"INIT" => -27,
			"## no critic qw(" => -27,
			'SUB' => -27,
			'USE' => -27,
			"use parent qw(" => 20
		},
		GOTOS => {
			'STAR-11' => 21,
			'Class' => 17,
			'Package' => 22,
			'UseParent' => 19,
			'Module' => 23
		}
	},
	{#State 9
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 2,
			'USE_RPERL' => -20,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 24,
			'OPTIONAL-9' => 1,
			'Critic' => 3,
			'ModuleHeader' => 8
		}
	},
	{#State 10
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -41
	},
	{#State 13
		ACTIONS => {
			'WORD' => 27,
			")" => 26
		}
	},
	{#State 14
		DEFAULT => -6
	},
	{#State 15
		ACTIONS => {
			'USE_RPERL' => 28
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -78
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 30
		}
	},
	{#State 20
		DEFAULT => -77
	},
	{#State 21
		ACTIONS => {
			"## no critic qw(" => 2,
			"INIT" => -29,
			'USE_EXPORTER' => 33,
			'USE' => -29,
			'SUB' => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Exports' => 34,
			'OPTIONAL-12' => 35,
			'Critic' => 32
		}
	},
	{#State 22
		DEFAULT => -24
	},
	{#State 23
		DEFAULT => -1
	},
	{#State 24
		DEFAULT => -2
	},
	{#State 25
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 26
		DEFAULT => -42
	},
	{#State 27
		DEFAULT => -40
	},
	{#State 28
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 38
		}
	},
	{#State 29
		DEFAULT => -293
	},
	{#State 30
		ACTIONS => {
			")" => 39
		}
	},
	{#State 31
		DEFAULT => -292
	},
	{#State 32
		DEFAULT => -26
	},
	{#State 33
		ACTIONS => {
			'SUB' => -45,
			'OUR_EXPORT_OK' => -45,
			"our hashref \$properties" => -45,
			'USE' => -45,
			"use constant" => -45,
			"INIT" => -45,
			'OUR_EXPORT' => 42
		},
		GOTOS => {
			'OPTIONAL-19' => 40,
			'PAREN-18' => 41
		}
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
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 45
		}
	},
	{#State 38
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 46
		}
	},
	{#State 39
		ACTIONS => {
			";" => 47
		}
	},
	{#State 40
		ACTIONS => {
			'OUR_EXPORT_OK' => 50,
			"INIT" => -48,
			"our hashref \$properties" => -48,
			'USE' => -48,
			'SUB' => -48,
			"use constant" => -48
		},
		GOTOS => {
			'PAREN-20' => 49,
			'OPTIONAL-21' => 48
		}
	},
	{#State 41
		DEFAULT => -44
	},
	{#State 42
		ACTIONS => {
			'OP01_QW' => 51
		}
	},
	{#State 43
		ACTIONS => {
			'USE' => 54,
			"INIT" => 52,
			"use constant" => -33,
			'SUB' => -33
		},
		GOTOS => {
			'Include' => 53,
			'STAR-14' => 55
		}
	},
	{#State 44
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 57
		},
		GOTOS => {
			'OPTIONAL-16' => 58
		}
	},
	{#State 46
		ACTIONS => {
			'ARRAY_SYMBOL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"undef" => -11,
			'OP01_OPEN' => -11,
			'SCALAR_SYMBOL' => -11,
			"if" => -11,
			"use constant" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'ARGV' => -11,
			"for" => -11,
			'OP01_PRINT' => -11,
			'ENV' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			"%{" => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'WORD' => -11,
			"foreach" => -11,
			'LBRACKET' => -11,
			'HASH_SYMBOL' => -11,
			'MY' => -11,
			'POD' => -11,
			'OP10_NAMED_UNARY' => -11,
			"while" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_QW' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'SELF' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID' => -11,
			'LPAREN_TYPE_INNER' => -11,
			'LPAREN' => -11,
			"## no critic qw(" => 2,
			'WORD_SCOPED' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LITERAL_NUMBER' => -11,
			"INIT" => -11,
			'LBRACE' => -11,
			'SUB' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"\@{" => -11,
			'WORD_UPPERCASE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'HASH_REF_SYMBOL' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'USE' => -11,
			'ARRAY_REF_SYMBOL' => -11
		},
		GOTOS => {
			'STAR-5' => 59,
			'Critic' => 60
		}
	},
	{#State 47
		ACTIONS => {
			"INIT" => 52,
			'USE' => 54
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 48
		DEFAULT => -49
	},
	{#State 49
		DEFAULT => -47
	},
	{#State 50
		ACTIONS => {
			'OP01_QW' => 62
		}
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
			'WORD' => 31,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 65
		}
	},
	{#State 55
		ACTIONS => {
			'SUB' => 66,
			"use constant" => 69
		},
		GOTOS => {
			'PLUS-15' => 70,
			'Subroutine' => 68,
			'Constant' => 67
		}
	},
	{#State 56
		DEFAULT => -23
	},
	{#State 57
		DEFAULT => -37
	},
	{#State 58
		ACTIONS => {
			'OUR' => 71
		}
	},
	{#State 59
		ACTIONS => {
			'LITERAL_STRING' => -13,
			'ENV' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED' => -13,
			"foreach" => -13,
			'WORD' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"%{" => -13,
			'POD' => -13,
			'LBRACKET' => -13,
			'HASH_SYMBOL' => -13,
			'MY' => -13,
			'ARRAY_SYMBOL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"undef" => -13,
			'OP01_OPEN' => -13,
			"if" => -13,
			'SCALAR_SYMBOL' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'ARGV' => -13,
			"for" => -13,
			'OP01_PRINT' => -13,
			'LPAREN_TYPE_INNER' => -13,
			'LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			"INIT" => 52,
			'LBRACE' => -13,
			'WORD_SCOPED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_UPPERCASE' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'SUB' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"\@{" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'USE' => 54,
			'ARRAY_REF_SYMBOL' => -13,
			'HASH_REF_SYMBOL' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"while" => -13,
			'OP01_QW' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'SELF' => -13,
			'OP19_LOOP_CONTROL' => -13
		},
		GOTOS => {
			'Include' => 72,
			'STAR-6' => 73
		}
	},
	{#State 60
		DEFAULT => -8
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
			'WORD' => 31,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 76
		}
	},
	{#State 65
		ACTIONS => {
			'OP01_QW' => 77,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 78
		}
	},
	{#State 66
		ACTIONS => {
			'WORD' => 79
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		DEFAULT => -35
	},
	{#State 69
		ACTIONS => {
			'WORD_UPPERCASE' => 80
		}
	},
	{#State 70
		ACTIONS => {
			'LITERAL_NUMBER' => 82,
			'SUB' => 66
		},
		GOTOS => {
			'Subroutine' => 81
		}
	},
	{#State 71
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 83
		}
	},
	{#State 72
		DEFAULT => -10
	},
	{#State 73
		ACTIONS => {
			'ENV' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			'OP01_NAMED' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"%{" => -15,
			"foreach" => -15,
			'WORD' => -15,
			'LBRACKET' => -15,
			'HASH_SYMBOL' => -15,
			'MY' => -15,
			'POD' => -15,
			'ARRAY_SYMBOL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_OPEN' => -15,
			"undef" => -15,
			"if" => -15,
			'SCALAR_SYMBOL' => -15,
			"use constant" => 69,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'ARGV' => -15,
			"for" => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			'LPAREN_TYPE_INNER' => -15,
			'LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_NUMBER' => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'SUB' => -15,
			"\@{" => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'HASH_REF_SYMBOL' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"while" => -15,
			'OP01_QW' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'SELF' => -15,
			'OP01_CLOSE' => -15,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'Constant' => 84,
			'STAR-7' => 85
		}
	},
	{#State 74
		ACTIONS => {
			"use constant" => -69,
			"INIT" => -69,
			"our hashref \$properties" => -69,
			'USE' => -69,
			'USE_EXPORTER' => 33,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-29' => 87,
			'Critic' => 86,
			'Exports' => 88
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
		DEFAULT => -50
	},
	{#State 78
		ACTIONS => {
			";" => 90
		}
	},
	{#State 79
		ACTIONS => {
			'LBRACE' => 91
		}
	},
	{#State 80
		ACTIONS => {
			'OP20_HASH_FATARROW' => 92
		}
	},
	{#State 81
		DEFAULT => -34
	},
	{#State 82
		ACTIONS => {
			";" => 93
		}
	},
	{#State 83
		DEFAULT => -39
	},
	{#State 84
		DEFAULT => -12
	},
	{#State 85
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => 102,
			'SUB' => 66,
			"\@{" => 143,
			'WORD_UPPERCASE' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'OP01_NAMED_VOID' => 96,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP19_LOOP_CONTROL' => 149,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			"while" => -178,
			'OP01_QW' => 147,
			'OP01_NAMED_SCOLON' => 146,
			"%{" => 161,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			"foreach" => -178,
			'WORD' => 31,
			'LBRACKET' => 117,
			'MY' => 118,
			'HASH_SYMBOL' => 158,
			'POD' => 159,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 111,
			'ARGV' => 131,
			"for" => -178,
			'OP01_PRINT' => 129,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			"if" => 126,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122
		},
		GOTOS => {
			'HashReference' => 132,
			'WordScoped' => 170,
			'VariableDeclaration' => 169,
			'Scalar' => 130,
			'VariableModification' => 168,
			'PAREN-47' => 128,
			'Operation' => 127,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'OperatorVoid' => 164,
			'Hash' => 163,
			'PLUS-8' => 162,
			'HashVariable' => 119,
			'Subroutine' => 156,
			'SubExpression' => 116,
			'LoopLabel' => 157,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'ArrayReference' => 153,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Conditional' => 148,
			'OPTIONAL-48' => 107,
			'ArrayRefLiteralEmpty' => 105,
			'Variable' => 144,
			'ArrayDereference' => 145,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 101,
			'ScalarVariable' => 100,
			'HashReferenceVariable' => 141,
			'ArrayReferenceVariable' => 99,
			'Expression' => 136,
			'Statement' => 97,
			'Array' => 134,
			'Operator' => 95
		}
	},
	{#State 86
		DEFAULT => -66
	},
	{#State 87
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 171
		}
	},
	{#State 88
		DEFAULT => -68
	},
	{#State 89
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 173
		},
		GOTOS => {
			'OPTIONAL-23' => 172
		}
	},
	{#State 90
		DEFAULT => -54
	},
	{#State 91
		ACTIONS => {
			'LBRACE' => 174
		}
	},
	{#State 92
		ACTIONS => {
			'MY' => 175
		},
		GOTOS => {
			'TypeInnerConstant' => 176
		}
	},
	{#State 93
		DEFAULT => -36
	},
	{#State 94
		ACTIONS => {
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110
		},
		GOTOS => {
			'Expression' => 185,
			'SubExpression' => 179,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 95
		DEFAULT => -150
	},
	{#State 96
		ACTIONS => {
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'ARGV' => 131,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'SubExpressions' => 187,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 186,
			'Expression' => 185,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayDereference' => 145,
			'Hash' => 163
		}
	},
	{#State 97
		DEFAULT => -98
	},
	{#State 98
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 190,
			'OP01_NAMED_VOID' => 195,
			'OP01_NAMED' => 191,
			'OP23_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 204,
			'WORD' => 189,
			'OP11_COMPARE_LT_GT' => 193,
			'OP22_LOGICAL_NEG' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP01_OPEN' => 197,
			'OP10_NAMED_UNARY' => 192,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_MATH_ADD_SUB' => 203,
			'OP01_CLOSE' => 201,
			'OP19_LOOP_CONTROL' => 202,
			'OP01_PRINT' => 188
		},
		GOTOS => {
			'OpStringOrWord' => 200
		}
	},
	{#State 99
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP12_COMPARE_EQ_NE' => -268,
			")" => -268,
			'OP08_STRING_CAT' => -268,
			'OP14_BITWISE_OR_XOR' => -268,
			'OP06_REGEX_BIND' => -268,
			'OP11_COMPARE_LT_GT' => -268,
			'OP23_LOGICAL_AND' => -268,
			'OP07_STRING_REPEAT' => -268,
			'OP15_LOGICAL_AND' => -268,
			'OP07_MATH_MULT_DIV_MOD' => -268,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP18_TERNARY' => -268,
			'OP04_MATH_POW' => -268,
			'OP24_LOGICAL_OR_XOR' => -268,
			'OP08_MATH_ADD_SUB' => -268,
			'OP17_LIST_RANGE' => -268,
			'OP16_LOGICAL_OR' => -268,
			'OP09_BITWISE_SHIFT' => -268,
			'OP13_BITWISE_AND' => -268
		}
	},
	{#State 100
		ACTIONS => {
			'OP18_TERNARY' => -226,
			'OP03_MATH_INC_DEC' => 206,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP08_MATH_ADD_SUB' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP04_MATH_POW' => -226,
			'OP02_METHOD_THINARROW' => 207,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP17_LIST_RANGE' => -226,
			")" => -226,
			'OP08_STRING_CAT' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP19_VARIABLE_ASSIGN' => -203,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP23_LOGICAL_AND' => -226
		}
	},
	{#State 101
		ACTIONS => {
			'OP06_REGEX_BIND' => -264,
			'OP11_COMPARE_LT_GT' => -264,
			'OP07_STRING_REPEAT' => -264,
			'OP23_LOGICAL_AND' => -264,
			'OP15_LOGICAL_AND' => -264,
			'OP19_VARIABLE_ASSIGN' => -204,
			'OP12_COMPARE_EQ_NE' => -264,
			")" => -264,
			'OP08_STRING_CAT' => -264,
			'OP14_BITWISE_OR_XOR' => -264,
			'OP16_LOGICAL_OR' => -264,
			'OP17_LIST_RANGE' => -264,
			'OP09_BITWISE_SHIFT' => -264,
			'OP13_BITWISE_AND' => -264,
			'OP07_MATH_MULT_DIV_MOD' => -264,
			'OP18_TERNARY' => -264,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP24_LOGICAL_OR_XOR' => -264,
			'OP08_MATH_ADD_SUB' => -264,
			'OP04_MATH_POW' => -264
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			"%{" => 161,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARGV' => 131,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			")" => -135,
			'LITERAL_NUMBER' => 133,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151
		},
		GOTOS => {
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 186,
			'Operator' => 95,
			'SubExpressions' => 209,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'OPTIONAL-41' => 208,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 210,
			'COLON' => -294
		}
	},
	{#State 104
		ACTIONS => {
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 211,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113
		}
	},
	{#State 105
		DEFAULT => -270
	},
	{#State 106
		ACTIONS => {
			'OP18_TERNARY' => -118,
			'OP03_MATH_INC_DEC' => 121,
			'OP24_LOGICAL_OR_XOR' => -118,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			'ARRAY_SYMBOL' => 124,
			'OP09_BITWISE_SHIFT' => -118,
			'OP13_BITWISE_AND' => -118,
			'ARGV' => 131,
			"}" => -118,
			'OP01_NAMED' => 178,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP12_COMPARE_EQ_NE' => -118,
			'LITERAL_STRING' => 115,
			";" => -118,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'OP15_LOGICAL_AND' => -118,
			"%{" => 161,
			'WORD' => 31,
			'OP21_LIST_COMMA' => -118,
			'OP08_MATH_ADD_SUB' => -118,
			'OP04_MATH_POW' => -118,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			"]" => -118,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP16_LOGICAL_OR' => -118,
			'OP17_LIST_RANGE' => -118,
			")" => -118,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'OP08_STRING_CAT' => -118,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'OP11_COMPARE_LT_GT' => -118,
			'OP06_REGEX_BIND' => -118,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP07_STRING_REPEAT' => -118,
			'WORD_UPPERCASE' => 183,
			'OP23_LOGICAL_AND' => -118
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 212
		}
	},
	{#State 107
		ACTIONS => {
			"for" => 215,
			"foreach" => 214,
			"while" => 218
		},
		GOTOS => {
			'LoopForEach' => 217,
			'LoopWhile' => 216,
			'LoopFor' => 219,
			'Loop' => 213
		}
	},
	{#State 108
		DEFAULT => -152
	},
	{#State 109
		DEFAULT => -225
	},
	{#State 110
		ACTIONS => {
			'ARGV' => 131,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			"%{" => 161,
			'WORD' => 31,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135
		},
		GOTOS => {
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 220,
			'Expression' => 185,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 111
		ACTIONS => {
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125
		},
		GOTOS => {
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 221,
			'Expression' => 185,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 112
		DEFAULT => -159
	},
	{#State 113
		DEFAULT => -160
	},
	{#State 114
		DEFAULT => -282
	},
	{#State 115
		DEFAULT => -228
	},
	{#State 116
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP15_LOGICAL_AND' => 222,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP12_COMPARE_EQ_NE' => 229
		}
	},
	{#State 117
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			"%{" => 161,
			'WORD' => 31,
			'MY' => 242,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LBRACE' => 135,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			"]" => 241
		},
		GOTOS => {
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'TypeInner' => 245,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 243,
			'Expression' => 185,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'ListElement' => 239,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayLiteralE' => 244,
			'ArrayLiteralEs' => 240,
			'HashDereference' => 123
		}
	},
	{#State 118
		ACTIONS => {
			'TYPE_FHREF' => 248,
			'WORD' => 246,
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249
		},
		GOTOS => {
			'Type' => 247
		}
	},
	{#State 119
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -280,
			'OP19_VARIABLE_ASSIGN' => -206,
			'OP14_BITWISE_OR_XOR' => -280,
			'OP08_STRING_CAT' => -280,
			")" => -280,
			'OP23_LOGICAL_AND' => -280,
			'OP07_STRING_REPEAT' => -280,
			'OP11_COMPARE_LT_GT' => -280,
			'OP06_REGEX_BIND' => -280,
			'OP15_LOGICAL_AND' => -280,
			'OP07_MATH_MULT_DIV_MOD' => -280,
			'OP04_MATH_POW' => -280,
			'OP24_LOGICAL_OR_XOR' => -280,
			'OP08_MATH_ADD_SUB' => -280,
			'OP19_VARIABLE_ASSIGN_BY' => -206,
			'OP18_TERNARY' => -280,
			'OP17_LIST_RANGE' => -280,
			'OP16_LOGICAL_OR' => -280,
			'OP13_BITWISE_AND' => -280,
			'OP09_BITWISE_SHIFT' => -280
		}
	},
	{#State 120
		ACTIONS => {
			"}" => -231,
			'OP20_HASH_FATARROW' => -231,
			'OP17_LIST_RANGE' => -231,
			'OP02_HASH_THINARROW' => 253,
			'OP16_LOGICAL_OR' => -231,
			'OP09_BITWISE_SHIFT' => -231,
			'OP13_BITWISE_AND' => -231,
			"]" => -231,
			'OP02_METHOD_THINARROW' => -231,
			'OP07_MATH_MULT_DIV_MOD' => -231,
			'COLON' => -231,
			'OP03_MATH_INC_DEC' => -231,
			'OP19_VARIABLE_ASSIGN_BY' => -231,
			'OP18_TERNARY' => -231,
			'OP04_MATH_POW' => -231,
			'OP24_LOGICAL_OR_XOR' => -231,
			'OP08_MATH_ADD_SUB' => -231,
			'OP21_LIST_COMMA' => -231,
			'OP02_ARRAY_THINARROW' => 252,
			'OP06_REGEX_BIND' => -231,
			'OP11_COMPARE_LT_GT' => -231,
			'OP23_LOGICAL_AND' => -231,
			'OP07_STRING_REPEAT' => -231,
			'OP15_LOGICAL_AND' => -231,
			'OP19_VARIABLE_ASSIGN' => -231,
			";" => -231,
			'OP12_COMPARE_EQ_NE' => -231,
			")" => -231,
			'OP14_BITWISE_OR_XOR' => -231,
			'OP08_STRING_CAT' => -231
		},
		GOTOS => {
			'VariableRetrievalArrow' => 251
		}
	},
	{#State 121
		ACTIONS => {
			'SELF' => 151,
			'SCALAR_SYMBOL' => 125
		},
		GOTOS => {
			'ScalarVariable' => 254,
			'ScalarVariableOrSelf' => 120
		}
	},
	{#State 122
		DEFAULT => -138
	},
	{#State 123
		DEFAULT => -166
	},
	{#State 124
		DEFAULT => -265
	},
	{#State 125
		DEFAULT => -234
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 255
		}
	},
	{#State 127
		DEFAULT => -17
	},
	{#State 128
		DEFAULT => -177
	},
	{#State 129
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -133,
			'WORD_SCOPED' => -133,
			'LITERAL_NUMBER' => -133,
			'LBRACE' => -133,
			'LPAREN' => -133,
			'LPAREN_TYPE_INNER' => -133,
			'HASH_REF_SYMBOL' => -133,
			'OP22_LOGICAL_NEG' => -133,
			'ARRAY_REF_SYMBOL' => -133,
			"\@{" => -133,
			'WORD_UPPERCASE' => -133,
			'OP05_BITWISE_NEG_LPAREN' => -133,
			'OP10_NAMED_UNARY' => -133,
			'OP01_QW' => -133,
			'CONSTANT_CALL_SCOPED' => -133,
			'OP22_LOGICAL_NEG_LPAREN' => -133,
			'SELF' => -133,
			'OP01_CLOSE' => -133,
			'OP01_NAMED' => -133,
			'ENV' => -133,
			'OP05_LOGICAL_NEG' => -133,
			'LITERAL_STRING' => -133,
			'LBRACKET' => -133,
			'FHREF_SYMBOL_BRACES' => 259,
			'HASH_SYMBOL' => -133,
			"%{" => -133,
			'STDOUT_STDERR' => 258,
			'WORD' => -133,
			'OP03_MATH_INC_DEC' => -133,
			'ARRAY_SYMBOL' => -133,
			'OP01_OPEN' => -133,
			"undef" => -133,
			'SCALAR_SYMBOL' => -133,
			'ARGV' => -133
		},
		GOTOS => {
			'OPTIONAL-40' => 256,
			'PAREN-39' => 257
		}
	},
	{#State 130
		DEFAULT => -158
	},
	{#State 131
		DEFAULT => -266
	},
	{#State 132
		DEFAULT => -165
	},
	{#State 133
		DEFAULT => -227
	},
	{#State 134
		DEFAULT => -161
	},
	{#State 135
		ACTIONS => {
			'OP07_STRING_REPEAT' => 204,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP23_LOGICAL_AND' => 194,
			'WORD_UPPERCASE' => 183,
			'OP11_COMPARE_LT_GT' => 193,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 272,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP01_NAMED_VOID' => 195,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'OP01_CLOSE' => 270,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP19_LOOP_CONTROL' => 202,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 260,
			'OP08_MATH_ADD_SUB' => 203,
			'WORD' => 268,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'OP12_COMPARE_EQ_NE' => 190,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 265,
			'ARGV' => 131,
			"}" => 264,
			'OP01_PRINT' => 188,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP01_OPEN' => 273,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'HashLiteralEs' => 269,
			'ScalarLiteral' => 261,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 262,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'HashLiteralE' => 267,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'OpStringOrWord' => 274,
			'ArrayReference' => 153,
			'HashEntry' => 271,
			'Expression' => 185,
			'SubExpression' => 266,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 136
		ACTIONS => {
			'OP15_LOGICAL_AND' => -156,
			'OP11_COMPARE_LT_GT' => -156,
			'OP06_REGEX_BIND' => -156,
			'OP23_LOGICAL_AND' => -156,
			'OP07_STRING_REPEAT' => -156,
			'OP14_BITWISE_OR_XOR' => -156,
			'OP08_STRING_CAT' => -156,
			";" => 275,
			'OP12_COMPARE_EQ_NE' => -156,
			'OP09_BITWISE_SHIFT' => -156,
			'OP13_BITWISE_AND' => -156,
			'OP17_LIST_RANGE' => -156,
			'OP16_LOGICAL_OR' => -156,
			'OP18_TERNARY' => -156,
			'OP04_MATH_POW' => -156,
			'OP08_MATH_ADD_SUB' => -156,
			'OP24_LOGICAL_OR_XOR' => -156,
			'OP07_MATH_MULT_DIV_MOD' => -156
		}
	},
	{#State 137
		ACTIONS => {
			'MY' => 242,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 268,
			'OP01_NAMED' => 281,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP12_COMPARE_EQ_NE' => 190,
			'LITERAL_STRING' => 115,
			'OP01_PRINT' => 278,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP01_OPEN' => 273,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 272,
			'OP11_COMPARE_LT_GT' => 193,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP07_STRING_REPEAT' => 204,
			'WORD_UPPERCASE' => 183,
			'OP23_LOGICAL_AND' => 194,
			'LITERAL_NUMBER' => 133,
			")" => 276,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'OP01_NAMED_VOID' => 195,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP19_LOOP_CONTROL' => 202,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 270,
			'OP08_MATH_ADD_SUB' => 203,
			'OP10_NAMED_UNARY' => 260,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147
		},
		GOTOS => {
			'ScalarLiteral' => 261,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ListElement' => 283,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 262,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'Hash' => 163,
			'ArrayHashLiteralE' => 277,
			'ArrayDereference' => 145,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteralEs' => 280,
			'TypeInner' => 245,
			'ArrayHashLiteral' => 113,
			'Operator' => 95,
			'OpStringOrWord' => 274,
			'ArrayReference' => 153,
			'HashEntry' => 282,
			'Expression' => 185,
			'SubExpression' => 279,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 138
		DEFAULT => -287
	},
	{#State 139
		DEFAULT => -286
	},
	{#State 140
		ACTIONS => {
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 284,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145
		}
	},
	{#State 141
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -284,
			'OP06_REGEX_BIND' => -284,
			'OP07_STRING_REPEAT' => -284,
			'OP23_LOGICAL_AND' => -284,
			'OP15_LOGICAL_AND' => -284,
			'OP19_VARIABLE_ASSIGN' => -207,
			'OP12_COMPARE_EQ_NE' => -284,
			")" => -284,
			'OP08_STRING_CAT' => -284,
			'OP14_BITWISE_OR_XOR' => -284,
			'OP16_LOGICAL_OR' => -284,
			'OP17_LIST_RANGE' => -284,
			'OP09_BITWISE_SHIFT' => -284,
			'OP13_BITWISE_AND' => -284,
			'OP07_MATH_MULT_DIV_MOD' => -284,
			'OP18_TERNARY' => -284,
			'OP19_VARIABLE_ASSIGN_BY' => -207,
			'OP24_LOGICAL_OR_XOR' => -284,
			'OP08_MATH_ADD_SUB' => -284,
			'OP04_MATH_POW' => -284
		}
	},
	{#State 142
		DEFAULT => -271
	},
	{#State 143
		ACTIONS => {
			'SELF' => 151,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_REF_SYMBOL' => -273,
			'LBRACKET' => -273,
			'MY' => 242
		},
		GOTOS => {
			'OPTIONAL-63' => 287,
			'ScalarVariableOrSelf' => 120,
			'TypeInner' => 286,
			'ScalarVariable' => 285
		}
	},
	{#State 144
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 288,
			'OP19_VARIABLE_ASSIGN' => 289
		}
	},
	{#State 145
		DEFAULT => -163
	},
	{#State 146
		DEFAULT => -96
	},
	{#State 147
		DEFAULT => -100
	},
	{#State 148
		DEFAULT => -179
	},
	{#State 149
		ACTIONS => {
			'WORD_UPPERCASE' => 290
		},
		GOTOS => {
			'LoopLabel' => 291
		}
	},
	{#State 150
		DEFAULT => -267
	},
	{#State 151
		DEFAULT => -235
	},
	{#State 152
		ACTIONS => {
			'FHREF_SYMBOL' => 292
		}
	},
	{#State 153
		DEFAULT => -162
	},
	{#State 154
		ACTIONS => {
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110
		},
		GOTOS => {
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'Expression' => 185,
			'SubExpression' => 293,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153
		}
	},
	{#State 155
		DEFAULT => -283
	},
	{#State 156
		DEFAULT => -14
	},
	{#State 157
		ACTIONS => {
			'COLON' => 294
		}
	},
	{#State 158
		DEFAULT => -281
	},
	{#State 159
		DEFAULT => -184
	},
	{#State 160
		DEFAULT => -97
	},
	{#State 161
		ACTIONS => {
			'SELF' => 151,
			'SCALAR_SYMBOL' => 125,
			'MY' => 242,
			'HASH_REF_SYMBOL' => -289,
			'LBRACE' => -289
		},
		GOTOS => {
			'ScalarVariable' => 296,
			'TypeInner' => 295,
			'OPTIONAL-65' => 297,
			'ScalarVariableOrSelf' => 120
		}
	},
	{#State 162
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'ARRAY_SYMBOL' => 124,
			"if" => 126,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			"for" => -178,
			'OP01_PRINT' => 129,
			'ARGV' => 131,
			'OP01_NAMED' => 111,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 117,
			'MY' => 118,
			'HASH_SYMBOL' => 158,
			'POD' => 159,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			"%{" => 161,
			'WORD' => 31,
			"foreach" => -178,
			'OP01_NAMED_SCOLON' => 146,
			'OP10_NAMED_UNARY' => 106,
			"while" => -178,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP19_LOOP_CONTROL' => 149,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'' => -18,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'OP01_NAMED_VOID_LPAREN' => 102,
			"\@{" => 143,
			'WORD_UPPERCASE' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 104
		},
		GOTOS => {
			'OperatorVoid' => 164,
			'Hash' => 163,
			'HashVariable' => 119,
			'SubExpression' => 116,
			'LoopLabel' => 157,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'ArrayReference' => 153,
			'HashReference' => 132,
			'WordScoped' => 170,
			'VariableDeclaration' => 169,
			'Scalar' => 130,
			'PAREN-47' => 128,
			'VariableModification' => 168,
			'Operation' => 298,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'Variable' => 144,
			'ArrayDereference' => 145,
			'HashRefLiteralEmpty' => 139,
			'HashReferenceVariable' => 141,
			'ArrayVariable' => 101,
			'ScalarVariable' => 100,
			'ArrayReferenceVariable' => 99,
			'Statement' => 97,
			'Expression' => 136,
			'Array' => 134,
			'Operator' => 95,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'OPTIONAL-48' => 107,
			'Conditional' => 148,
			'ArrayRefLiteralEmpty' => 105
		}
	},
	{#State 163
		DEFAULT => -164
	},
	{#State 164
		DEFAULT => -181
	},
	{#State 165
		DEFAULT => -142
	},
	{#State 166
		ACTIONS => {
			'MY' => 299
		}
	},
	{#State 167
		DEFAULT => -157
	},
	{#State 168
		ACTIONS => {
			";" => 300
		}
	},
	{#State 169
		DEFAULT => -182
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 302,
			'OP02_METHOD_THINARROW_NEW' => 301
		}
	},
	{#State 171
		ACTIONS => {
			"our hashref \$properties" => -73,
			"INIT" => 52,
			'USE' => 54,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 304,
			'STAR-31' => 303
		}
	},
	{#State 172
		ACTIONS => {
			")" => 305
		}
	},
	{#State 173
		DEFAULT => -52
	},
	{#State 174
		ACTIONS => {
			'MY' => 306
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => 246,
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 176
		ACTIONS => {
			'LITERAL_NUMBER' => 133,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'ScalarLiteral' => 308
		}
	},
	{#State 177
		DEFAULT => -280
	},
	{#State 178
		ACTIONS => {
			'ARGV' => 131,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			"%{" => 161,
			'WORD' => 31,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135
		},
		GOTOS => {
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 309,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120
		}
	},
	{#State 179
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => 310,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => 222
		}
	},
	{#State 180
		DEFAULT => -268
	},
	{#State 181
		ACTIONS => {
			'OP23_LOGICAL_AND' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP15_LOGICAL_AND' => -226,
			";" => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP08_STRING_CAT' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			")" => -226,
			'OP17_LIST_RANGE' => -226,
			'OP16_LOGICAL_OR' => -226,
			"}" => -226,
			'OP13_BITWISE_AND' => -226,
			"]" => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP02_METHOD_THINARROW' => 207,
			'OP04_MATH_POW' => -226,
			'OP08_MATH_ADD_SUB' => -226,
			'OP21_LIST_COMMA' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP03_MATH_INC_DEC' => 206,
			'OP18_TERNARY' => -226
		}
	},
	{#State 182
		DEFAULT => -264
	},
	{#State 183
		ACTIONS => {
			'LPAREN' => 210
		}
	},
	{#State 184
		DEFAULT => -284
	},
	{#State 185
		DEFAULT => -156
	},
	{#State 186
		ACTIONS => {
			'OP18_TERNARY' => 223,
			'OP21_LIST_COMMA' => -169,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			")" => -169,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -169,
			'OP15_LOGICAL_AND' => 222,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235
		},
		GOTOS => {
			'STAR-46' => 311
		}
	},
	{#State 187
		ACTIONS => {
			";" => 312
		}
	},
	{#State 188
		DEFAULT => -328
	},
	{#State 189
		DEFAULT => -329
	},
	{#State 190
		DEFAULT => -318
	},
	{#State 191
		DEFAULT => -324
	},
	{#State 192
		DEFAULT => -320
	},
	{#State 193
		DEFAULT => -319
	},
	{#State 194
		DEFAULT => -314
	},
	{#State 195
		DEFAULT => -327
	},
	{#State 196
		DEFAULT => -322
	},
	{#State 197
		DEFAULT => -326
	},
	{#State 198
		DEFAULT => -316
	},
	{#State 199
		DEFAULT => -313
	},
	{#State 200
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 201
		DEFAULT => -325
	},
	{#State 202
		DEFAULT => -317
	},
	{#State 203
		DEFAULT => -321
	},
	{#State 204
		DEFAULT => -323
	},
	{#State 205
		DEFAULT => -315
	},
	{#State 206
		DEFAULT => -106
	},
	{#State 207
		ACTIONS => {
			'LPAREN' => 314
		}
	},
	{#State 208
		ACTIONS => {
			")" => 315
		}
	},
	{#State 209
		DEFAULT => -134
	},
	{#State 210
		ACTIONS => {
			")" => 316
		}
	},
	{#State 211
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => 317,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238
		}
	},
	{#State 212
		ACTIONS => {
			";" => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			")" => -117,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP07_STRING_REPEAT' => 226,
			'OP15_LOGICAL_AND' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => -117,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP08_MATH_ADD_SUB' => 227,
			"}" => -117,
			'OP17_LIST_RANGE' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => -117,
			"]" => -117
		}
	},
	{#State 213
		DEFAULT => -180
	},
	{#State 214
		ACTIONS => {
			'MY' => 318
		}
	},
	{#State 215
		ACTIONS => {
			'LPAREN_MY' => 320,
			'MY' => 319
		}
	},
	{#State 216
		DEFAULT => -194
	},
	{#State 217
		DEFAULT => -193
	},
	{#State 218
		ACTIONS => {
			'LPAREN' => 322,
			'LPAREN_MY' => 321
		}
	},
	{#State 219
		DEFAULT => -192
	},
	{#State 220
		ACTIONS => {
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => 323,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 221
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP18_TERNARY' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP21_LIST_COMMA' => 324,
			'OP04_MATH_POW' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_STRING_CAT' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			";" => -101
		}
	},
	{#State 222
		ACTIONS => {
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133
		},
		GOTOS => {
			'Expression' => 185,
			'SubExpression' => 325,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 223
		ACTIONS => {
			'LITERAL_NUMBER' => 133,
			'SCALAR_SYMBOL' => 125,
			'SELF' => 151,
			'LITERAL_STRING' => 115
		},
		GOTOS => {
			'ScalarVariableOrLiteral' => 328,
			'ScalarVariableOrSelf' => 120,
			'ScalarLiteral' => 326,
			'ScalarVariable' => 327
		}
	},
	{#State 224
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Expression' => 185,
			'SubExpression' => 329,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 225
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 330,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177
		}
	},
	{#State 226
		ACTIONS => {
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114
		},
		GOTOS => {
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'Expression' => 185,
			'SubExpression' => 331,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180
		}
	},
	{#State 227
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 332
		}
	},
	{#State 228
		ACTIONS => {
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 333,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182
		}
	},
	{#State 229
		ACTIONS => {
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 334
		}
	},
	{#State 230
		ACTIONS => {
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108
		},
		GOTOS => {
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 335,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 231
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'OP03_MATH_INC_DEC' => 121,
			"%{" => 161,
			'WORD' => 31,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178
		},
		GOTOS => {
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 336,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 232
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131
		},
		GOTOS => {
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 337,
			'Expression' => 185,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105
		}
	},
	{#State 233
		ACTIONS => {
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131
		},
		GOTOS => {
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Operator' => 95,
			'ArrayReference' => 153,
			'SubExpression' => 338,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150
		}
	},
	{#State 234
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 339
		}
	},
	{#State 235
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 340,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170
		}
	},
	{#State 236
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 341,
			'Expression' => 185,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182
		}
	},
	{#State 237
		ACTIONS => {
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			"%{" => 161,
			'WORD' => 31,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 342,
			'Expression' => 185
		}
	},
	{#State 238
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 343,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayDereference' => 145,
			'Hash' => 163
		}
	},
	{#State 239
		DEFAULT => -250
	},
	{#State 240
		ACTIONS => {
			"]" => 344
		}
	},
	{#State 241
		DEFAULT => -257
	},
	{#State 242
		ACTIONS => {
			'WORD_SCOPED' => 249,
			'TYPE_INTEGER' => 250,
			'WORD' => 246
		},
		GOTOS => {
			'Type' => 345
		}
	},
	{#State 243
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP21_LIST_COMMA' => -249,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			"]" => -249
		}
	},
	{#State 244
		DEFAULT => -243,
		GOTOS => {
			'STAR-58' => 346
		}
	},
	{#State 245
		ACTIONS => {
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			"%{" => 161,
			'WORD' => 31,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Expression' => 185,
			'SubExpression' => 347,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 246
		DEFAULT => -295
	},
	{#State 247
		ACTIONS => {
			'HASH_SYMBOL' => 348,
			'ARRAY_SYMBOL' => 350,
			'SCALAR_SYMBOL' => 349
		}
	},
	{#State 248
		ACTIONS => {
			'FHREF_SYMBOL' => 351
		}
	},
	{#State 249
		DEFAULT => -296
	},
	{#State 250
		DEFAULT => -297
	},
	{#State 251
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -232,
			";" => -232,
			'OP12_COMPARE_EQ_NE' => -232,
			'OP19_VARIABLE_ASSIGN' => -232,
			'OP15_LOGICAL_AND' => -232,
			'LBRACKET' => 353,
			'OP02_ARRAY_THINARROW' => 252,
			'OP24_LOGICAL_OR_XOR' => -232,
			'OP03_MATH_INC_DEC' => -232,
			'OP18_TERNARY' => -232,
			'OP07_MATH_MULT_DIV_MOD' => -232,
			'OP02_METHOD_THINARROW' => -232,
			'COLON' => -232,
			'OP13_BITWISE_AND' => -232,
			'OP09_BITWISE_SHIFT' => -232,
			'OP02_HASH_THINARROW' => 253,
			"}" => -232,
			'OP08_STRING_CAT' => -232,
			'LBRACE' => 355,
			")" => -232,
			'OP23_LOGICAL_AND' => -232,
			'OP07_STRING_REPEAT' => -232,
			'OP11_COMPARE_LT_GT' => -232,
			'OP06_REGEX_BIND' => -232,
			'OP04_MATH_POW' => -232,
			'OP08_MATH_ADD_SUB' => -232,
			'OP21_LIST_COMMA' => -232,
			'OP19_VARIABLE_ASSIGN_BY' => -232,
			"]" => -232,
			'OP17_LIST_RANGE' => -232,
			'OP16_LOGICAL_OR' => -232,
			'OP20_HASH_FATARROW' => -232
		},
		GOTOS => {
			'PLUS-54' => 356,
			'VariableRetrievalArrow' => 354,
			'VariableRetrieval' => 352
		}
	},
	{#State 252
		ACTIONS => {
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98
		},
		GOTOS => {
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 357,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123
		}
	},
	{#State 253
		ACTIONS => {
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 358,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 359,
			'Expression' => 185,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139
		}
	},
	{#State 254
		DEFAULT => -105
	},
	{#State 255
		ACTIONS => {
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 360,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132
		}
	},
	{#State 256
		ACTIONS => {
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ArrayReference' => 153,
			'SubExpressions' => 361,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 186,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ArrayDereference' => 145,
			'Hash' => 163
		}
	},
	{#State 257
		DEFAULT => -132
	},
	{#State 258
		DEFAULT => -131
	},
	{#State 259
		ACTIONS => {
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			"%{" => 161,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARGV' => 131,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 186,
			'Expression' => 185,
			'SubExpressions' => 362,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177
		}
	},
	{#State 260
		ACTIONS => {
			'OP15_LOGICAL_AND' => -118,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP01_NAMED' => 178,
			'OP12_COMPARE_EQ_NE' => -118,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP13_BITWISE_AND' => -118,
			'OP09_BITWISE_SHIFT' => -118,
			'ARGV' => 131,
			"}" => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP18_TERNARY' => -118,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP07_STRING_REPEAT' => -118,
			'WORD_UPPERCASE' => 183,
			'OP23_LOGICAL_AND' => -118,
			'OP11_COMPARE_LT_GT' => -118,
			'OP06_REGEX_BIND' => -118,
			"\@{" => 143,
			'LBRACE' => 135,
			'OP08_STRING_CAT' => -118,
			'LITERAL_NUMBER' => 133,
			")" => -118,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP01_CLOSE' => 152,
			'OP16_LOGICAL_OR' => -118,
			'OP17_LIST_RANGE' => -118,
			'SELF' => 151,
			'OP20_HASH_FATARROW' => -320,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP21_LIST_COMMA' => -118,
			'OP08_MATH_ADD_SUB' => -118,
			'OP04_MATH_POW' => -118,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 212,
			'Expression' => 185,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182
		}
	},
	{#State 261
		ACTIONS => {
			'OP20_HASH_FATARROW' => -305,
			"}" => -225,
			'OP16_LOGICAL_OR' => -225,
			'OP17_LIST_RANGE' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP13_BITWISE_AND' => -225,
			'OP07_MATH_MULT_DIV_MOD' => -225,
			'OP18_TERNARY' => -225,
			'OP21_LIST_COMMA' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP24_LOGICAL_OR_XOR' => -225,
			'OP04_MATH_POW' => -225,
			'OP06_REGEX_BIND' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP23_LOGICAL_AND' => -225,
			'OP15_LOGICAL_AND' => -225,
			'OP12_COMPARE_EQ_NE' => -225,
			")" => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP08_STRING_CAT' => -225
		}
	},
	{#State 262
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -226,
			'OP08_STRING_CAT' => -226,
			")" => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP04_MATH_POW' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP08_MATH_ADD_SUB' => -226,
			'OP21_LIST_COMMA' => -226,
			'OP03_MATH_INC_DEC' => 206,
			'OP18_TERNARY' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP02_METHOD_THINARROW' => 207,
			'OP13_BITWISE_AND' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP16_LOGICAL_OR' => -226,
			"}" => -226,
			'OP20_HASH_FATARROW' => -304
		}
	},
	{#State 263
		ACTIONS => {
			'OP20_HASH_FATARROW' => 363
		}
	},
	{#State 264
		DEFAULT => -258
	},
	{#State 265
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP20_HASH_FATARROW' => -324,
			'SELF' => 151,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158
		},
		GOTOS => {
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 309,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153
		}
	},
	{#State 266
		ACTIONS => {
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			"}" => -251,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -251,
			'OP24_LOGICAL_OR_XOR' => 224
		}
	},
	{#State 267
		DEFAULT => -247,
		GOTOS => {
			'STAR-60' => 364
		}
	},
	{#State 268
		ACTIONS => {
			'OP20_HASH_FATARROW' => -329,
			'LPAREN' => -292,
			'OP02_METHOD_THINARROW_NEW' => -292
		}
	},
	{#State 269
		ACTIONS => {
			"}" => 365
		}
	},
	{#State 270
		ACTIONS => {
			'OP20_HASH_FATARROW' => -325,
			'FHREF_SYMBOL' => 292
		}
	},
	{#State 271
		DEFAULT => -252
	},
	{#State 272
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'SELF' => 151,
			'OP20_HASH_FATARROW' => -315,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 284,
			'Expression' => 185
		}
	},
	{#State 273
		ACTIONS => {
			'MY' => 299,
			'OP20_HASH_FATARROW' => -326
		}
	},
	{#State 274
		DEFAULT => -306
	},
	{#State 275
		DEFAULT => -95
	},
	{#State 276
		DEFAULT => -256
	},
	{#State 277
		DEFAULT => -239,
		GOTOS => {
			'STAR-56' => 366
		}
	},
	{#State 278
		ACTIONS => {
			'OP20_HASH_FATARROW' => -328,
			'FHREF_SYMBOL_BRACES' => 367
		}
	},
	{#State 279
		ACTIONS => {
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -253,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			")" => -253,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226
		}
	},
	{#State 280
		ACTIONS => {
			")" => 368
		}
	},
	{#State 281
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'SELF' => 151,
			'OP20_HASH_FATARROW' => -324,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153,
			'SubExpression' => 369,
			'Expression' => 185,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 282
		DEFAULT => -255
	},
	{#State 283
		DEFAULT => -254
	},
	{#State 284
		ACTIONS => {
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => -128,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => -128,
			";" => -128,
			'OP12_COMPARE_EQ_NE' => 229,
			"]" => -128,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			"}" => -128,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -128,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 285
		ACTIONS => {
			"}" => 370
		}
	},
	{#State 286
		DEFAULT => -272
	},
	{#State 287
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 142,
			'LBRACKET' => 117
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 150,
			'ArrayReference' => 371,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayReferenceVariable' => 180
		}
	},
	{#State 288
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			"%{" => 161,
			'WORD' => 31,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 372,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145
		}
	},
	{#State 289
		ACTIONS => {
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'STDIN' => 376,
			'ARRAY_SYMBOL' => 124,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'FHREF_SYMBOL_IN' => 373,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashDereference' => 123,
			'SubExpressionOrInput' => 374,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 375,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95
		}
	},
	{#State 290
		DEFAULT => -294
	},
	{#State 291
		ACTIONS => {
			";" => 377
		}
	},
	{#State 292
		DEFAULT => -104
	},
	{#State 293
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP18_TERNARY' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP16_LOGICAL_OR' => -109,
			"}" => -109,
			"]" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			";" => -109,
			'OP12_COMPARE_EQ_NE' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP08_STRING_CAT' => -109,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP07_STRING_REPEAT' => -109,
			'OP06_REGEX_BIND' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP15_LOGICAL_AND' => -109
		}
	},
	{#State 294
		DEFAULT => -176
	},
	{#State 295
		DEFAULT => -288
	},
	{#State 296
		ACTIONS => {
			"}" => 378
		}
	},
	{#State 297
		ACTIONS => {
			'LBRACE' => 135,
			'HASH_REF_SYMBOL' => 138
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 139,
			'HashReferenceVariable' => 184,
			'HashReference' => 379,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 298
		DEFAULT => -16
	},
	{#State 299
		ACTIONS => {
			'TYPE_FHREF' => 380
		}
	},
	{#State 300
		DEFAULT => -183
	},
	{#State 301
		ACTIONS => {
			'LBRACE' => 135,
			")" => -149,
			'HASH_REF_SYMBOL' => 138
		},
		GOTOS => {
			'OPTIONAL-44' => 382,
			'HashReferenceVariable' => 184,
			'HashRefLiteralEmpty' => 139,
			'HashReferenceLiteral' => 155,
			'HashReference' => 381
		}
	},
	{#State 302
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			")" => -145,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'SubExpression' => 186,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'OPTIONAL-42' => 383,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Operator' => 95,
			'SubExpressions' => 384,
			'ArrayReference' => 153,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180
		}
	},
	{#State 303
		ACTIONS => {
			"our hashref \$properties" => 385,
			"use constant" => 69
		},
		GOTOS => {
			'Properties' => 386,
			'Constant' => 387
		}
	},
	{#State 304
		DEFAULT => -70
	},
	{#State 305
		ACTIONS => {
			";" => 388
		}
	},
	{#State 306
		ACTIONS => {
			'WORD' => 246,
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249
		},
		GOTOS => {
			'Type' => 389
		}
	},
	{#State 307
		ACTIONS => {
			"\$TYPED_" => 390
		}
	},
	{#State 308
		ACTIONS => {
			";" => 391
		}
	},
	{#State 309
		ACTIONS => {
			'OP06_REGEX_BIND' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP15_LOGICAL_AND' => -101,
			";" => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_STRING_CAT' => -101,
			"}" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 310
		DEFAULT => -110
	},
	{#State 311
		ACTIONS => {
			")" => -170,
			'OP21_LIST_COMMA' => 392,
			";" => -170
		},
		GOTOS => {
			'PAREN-45' => 393
		}
	},
	{#State 312
		DEFAULT => -140
	},
	{#State 313
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152
		},
		GOTOS => {
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 394,
			'Expression' => 185,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139
		}
	},
	{#State 314
		ACTIONS => {
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LBRACE' => 135,
			")" => -147,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110
		},
		GOTOS => {
			'ArrayReference' => 153,
			'SubExpressions' => 396,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 186,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'OPTIONAL-43' => 395,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 315
		ACTIONS => {
			";" => 397
		}
	},
	{#State 316
		DEFAULT => -151
	},
	{#State 317
		DEFAULT => -108
	},
	{#State 318
		ACTIONS => {
			'WORD_SCOPED' => 249,
			'TYPE_INTEGER' => 250,
			'WORD' => 246
		},
		GOTOS => {
			'Type' => 398
		}
	},
	{#State 319
		ACTIONS => {
			'TYPE_INTEGER' => 399
		}
	},
	{#State 320
		ACTIONS => {
			'TYPE_INTEGER' => 400
		}
	},
	{#State 321
		ACTIONS => {
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249,
			'WORD' => 246
		},
		GOTOS => {
			'Type' => 401
		}
	},
	{#State 322
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143
		},
		GOTOS => {
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'Expression' => 185,
			'SubExpression' => 402,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayReferenceVariable' => 180
		}
	},
	{#State 323
		DEFAULT => -127
	},
	{#State 324
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152
		},
		GOTOS => {
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'Expression' => 185,
			'SubExpression' => 186,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'SubExpressions' => 403,
			'Operator' => 95,
			'ArrayReference' => 153,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashDereference' => 123,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105
		}
	},
	{#State 325
		ACTIONS => {
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -123,
			'OP15_LOGICAL_AND' => -123,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -123,
			")" => -123,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			"}" => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP17_LIST_RANGE' => -123,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			"]" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => -123,
			'OP21_LIST_COMMA' => -123,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP04_MATH_POW' => 236
		}
	},
	{#State 326
		DEFAULT => -303
	},
	{#State 327
		DEFAULT => -302
	},
	{#State 328
		ACTIONS => {
			'COLON' => 404
		}
	},
	{#State 329
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP21_LIST_COMMA' => -130,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			"}" => -130,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			"]" => -130,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -130,
			")" => -130,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP15_LOGICAL_AND' => 222
		}
	},
	{#State 330
		ACTIONS => {
			'OP18_TERNARY' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP08_MATH_ADD_SUB' => -113,
			'OP04_MATH_POW' => 236,
			'OP07_MATH_MULT_DIV_MOD' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP13_BITWISE_AND' => -113,
			"]" => -113,
			"}" => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP17_LIST_RANGE' => -113,
			")" => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP08_STRING_CAT' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			";" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -113
		}
	},
	{#State 331
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -112,
			'OP13_BITWISE_AND' => -112,
			"]" => -112,
			"}" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP18_TERNARY' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP04_MATH_POW' => 236,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_STRING_REPEAT' => -112,
			'OP23_LOGICAL_AND' => -112,
			")" => -112,
			'OP08_STRING_CAT' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			";" => -112
		}
	},
	{#State 332
		ACTIONS => {
			"]" => -114,
			'OP13_BITWISE_AND' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP17_LIST_RANGE' => -114,
			"}" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP08_MATH_ADD_SUB' => -114,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP15_LOGICAL_AND' => -114,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -114,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP08_STRING_CAT' => -114,
			")" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			";" => -114
		}
	},
	{#State 333
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP21_LIST_COMMA' => -122,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP17_LIST_RANGE' => -122,
			"}" => -122,
			"]" => -122,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -122,
			'OP14_BITWISE_OR_XOR' => -122,
			'OP08_STRING_CAT' => 232,
			")" => -122,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -122,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => -122
		}
	},
	{#State 334
		ACTIONS => {
			'OP17_LIST_RANGE' => -120,
			'OP16_LOGICAL_OR' => -120,
			"}" => -120,
			"]" => -120,
			'OP13_BITWISE_AND' => -120,
			'OP09_BITWISE_SHIFT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => -120,
			";" => -120,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP08_STRING_CAT' => 232,
			")" => -120
		}
	},
	{#State 335
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -116,
			'OP13_BITWISE_AND' => -116,
			"]" => -116,
			"}" => -116,
			'OP17_LIST_RANGE' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP18_TERNARY' => -116,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -116,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP15_LOGICAL_AND' => -116,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP07_STRING_REPEAT' => 226,
			")" => -116,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => -116,
			";" => -116,
			'OP12_COMPARE_EQ_NE' => -116
		}
	},
	{#State 336
		ACTIONS => {
			")" => -121,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -121,
			'OP18_TERNARY' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP04_MATH_POW' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => -121,
			"]" => -121,
			"}" => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP17_LIST_RANGE' => -121
		}
	},
	{#State 337
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"]" => -115,
			'OP13_BITWISE_AND' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP17_LIST_RANGE' => -115,
			"}" => -115,
			'OP08_STRING_CAT' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			")" => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			";" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP06_REGEX_BIND' => 234
		}
	},
	{#State 338
		ACTIONS => {
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => -119,
			")" => -119,
			'OP12_COMPARE_EQ_NE' => -119,
			";" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -119,
			'OP11_COMPARE_LT_GT' => undef,
			'OP06_REGEX_BIND' => 234,
			'OP21_LIST_COMMA' => -119,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"]" => -119,
			'OP13_BITWISE_AND' => -119,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => -119,
			'OP17_LIST_RANGE' => -119,
			"}" => -119
		}
	},
	{#State 339
		DEFAULT => -111
	},
	{#State 340
		ACTIONS => {
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => -129,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => -129,
			";" => -129,
			'OP12_COMPARE_EQ_NE' => 229,
			"]" => -129,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			"}" => -129,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 341
		ACTIONS => {
			"}" => -107,
			'OP17_LIST_RANGE' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP13_BITWISE_AND' => -107,
			"]" => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP18_TERNARY' => -107,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			'OP06_REGEX_BIND' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP07_STRING_REPEAT' => -107,
			'OP15_LOGICAL_AND' => -107,
			";" => -107,
			'OP12_COMPARE_EQ_NE' => -107,
			")" => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP08_STRING_CAT' => -107
		}
	},
	{#State 342
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -125,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			"]" => -125,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => undef,
			"}" => -125,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => -125,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -125,
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -125,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234
		}
	},
	{#State 343
		ACTIONS => {
			"]" => -124,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => -124,
			'OP17_LIST_RANGE' => -124,
			"}" => -124,
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -124,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => -124,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -124,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => -124,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -124
		}
	},
	{#State 344
		DEFAULT => -269
	},
	{#State 345
		ACTIONS => {
			"\$TYPED_" => 405
		}
	},
	{#State 346
		ACTIONS => {
			"]" => -244,
			'OP21_LIST_COMMA' => 406
		},
		GOTOS => {
			'PAREN-57' => 407
		}
	},
	{#State 347
		ACTIONS => {
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => -259,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			"]" => -259,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP04_MATH_POW' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -259,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP18_TERNARY' => 223
		}
	},
	{#State 348
		ACTIONS => {
			";" => 408,
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 349
		ACTIONS => {
			";" => 412,
			'OP19_VARIABLE_ASSIGN' => 411,
			'OP02_ARRAY_THINARROW' => 410
		}
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413,
			";" => 414
		}
	},
	{#State 351
		ACTIONS => {
			";" => 415
		}
	},
	{#State 352
		DEFAULT => -230
	},
	{#State 353
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'HashReferenceLiteral' => 155,
			'SubExpression' => 416,
			'Expression' => 185,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109
		}
	},
	{#State 354
		DEFAULT => -211
	},
	{#State 355
		ACTIONS => {
			'ARGV' => 131,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 417,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133
		},
		GOTOS => {
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 418,
			'Expression' => 185,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 356
		ACTIONS => {
			'OP04_MATH_POW' => -233,
			'OP08_MATH_ADD_SUB' => -233,
			'OP21_LIST_COMMA' => -233,
			'OP19_VARIABLE_ASSIGN_BY' => -233,
			'OP17_LIST_RANGE' => -233,
			'OP16_LOGICAL_OR' => -233,
			'OP20_HASH_FATARROW' => -233,
			"]" => -233,
			'OP08_STRING_CAT' => -233,
			'LBRACE' => 355,
			")" => -233,
			'OP23_LOGICAL_AND' => -233,
			'OP07_STRING_REPEAT' => -233,
			'OP11_COMPARE_LT_GT' => -233,
			'OP06_REGEX_BIND' => -233,
			'OP07_MATH_MULT_DIV_MOD' => -233,
			'OP02_METHOD_THINARROW' => -233,
			'COLON' => -233,
			'OP24_LOGICAL_OR_XOR' => -233,
			'OP03_MATH_INC_DEC' => -233,
			'OP18_TERNARY' => -233,
			'OP02_HASH_THINARROW' => 253,
			"}" => -233,
			'OP13_BITWISE_AND' => -233,
			'OP09_BITWISE_SHIFT' => -233,
			";" => -233,
			'OP12_COMPARE_EQ_NE' => -233,
			'OP19_VARIABLE_ASSIGN' => -233,
			'OP14_BITWISE_OR_XOR' => -233,
			'OP02_ARRAY_THINARROW' => 252,
			'OP15_LOGICAL_AND' => -233,
			'LBRACKET' => 353
		},
		GOTOS => {
			'VariableRetrievalArrow' => 354,
			'VariableRetrieval' => 419
		}
	},
	{#State 357
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP13_BITWISE_AND' => 231,
			"]" => 420,
			'OP09_BITWISE_SHIFT' => 230
		}
	},
	{#State 358
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -292,
			"}" => 421,
			'LPAREN' => -292
		}
	},
	{#State 359
		ACTIONS => {
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP04_MATH_POW' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			"}" => 422
		}
	},
	{#State 360
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP12_COMPARE_EQ_NE' => 229,
			")" => 423,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP15_LOGICAL_AND' => 222
		}
	},
	{#State 361
		ACTIONS => {
			";" => 424
		}
	},
	{#State 362
		ACTIONS => {
			";" => 425
		}
	},
	{#State 363
		ACTIONS => {
			'ARGV' => -277,
			'OP03_MATH_INC_DEC' => -277,
			'ARRAY_SYMBOL' => -277,
			'SCALAR_SYMBOL' => -277,
			"undef" => -277,
			'OP01_OPEN' => -277,
			'LBRACKET' => -277,
			'HASH_SYMBOL' => -277,
			'MY' => 242,
			"%{" => -277,
			'WORD' => -277,
			'OP01_NAMED' => -277,
			'ENV' => -277,
			'OP05_LOGICAL_NEG' => -277,
			'LITERAL_STRING' => -277,
			'OP22_LOGICAL_NEG_LPAREN' => -277,
			'SELF' => -277,
			'OP01_CLOSE' => -277,
			'OP10_NAMED_UNARY' => -277,
			'OP01_QW' => -277,
			'CONSTANT_CALL_SCOPED' => -277,
			'HASH_REF_SYMBOL' => -277,
			'OP22_LOGICAL_NEG' => -277,
			'ARRAY_REF_SYMBOL' => -277,
			"\@{" => -277,
			'WORD_UPPERCASE' => -277,
			'OP05_BITWISE_NEG_LPAREN' => -277,
			'OP05_MATH_NEG_LPAREN' => -277,
			'WORD_SCOPED' => -277,
			'LITERAL_NUMBER' => -277,
			'LBRACE' => -277,
			'LPAREN_TYPE_INNER' => -277,
			'LPAREN' => -277
		},
		GOTOS => {
			'OPTIONAL-64' => 427,
			'TypeInner' => 426
		}
	},
	{#State 364
		ACTIONS => {
			"}" => -248,
			'OP21_LIST_COMMA' => 429
		},
		GOTOS => {
			'PAREN-59' => 428
		}
	},
	{#State 365
		DEFAULT => -285
	},
	{#State 366
		ACTIONS => {
			")" => -240,
			'OP21_LIST_COMMA' => 431
		},
		GOTOS => {
			'PAREN-55' => 430
		}
	},
	{#State 367
		ACTIONS => {
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166
		},
		GOTOS => {
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 186,
			'Expression' => 185,
			'Operator' => 95,
			'SubExpressions' => 432,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113
		}
	},
	{#State 368
		DEFAULT => -236
	},
	{#State 369
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP18_TERNARY' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP13_BITWISE_AND' => -101
		}
	},
	{#State 370
		DEFAULT => -274
	},
	{#State 371
		ACTIONS => {
			"}" => 434
		}
	},
	{#State 372
		ACTIONS => {
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 236,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -224,
			")" => -224,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232
		}
	},
	{#State 373
		DEFAULT => -172
	},
	{#State 374
		DEFAULT => -223
	},
	{#State 375
		ACTIONS => {
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -171,
			")" => -171,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232
		}
	},
	{#State 376
		DEFAULT => -173
	},
	{#State 377
		DEFAULT => -143
	},
	{#State 378
		DEFAULT => -290
	},
	{#State 379
		ACTIONS => {
			"}" => 435
		}
	},
	{#State 380
		ACTIONS => {
			'FHREF_SYMBOL' => 436
		}
	},
	{#State 381
		DEFAULT => -148
	},
	{#State 382
		ACTIONS => {
			")" => 437
		}
	},
	{#State 383
		ACTIONS => {
			")" => 438
		}
	},
	{#State 384
		DEFAULT => -144
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 439
		}
	},
	{#State 386
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 440
		}
	},
	{#State 387
		DEFAULT => -72
	},
	{#State 388
		ACTIONS => {
			"}" => 441
		}
	},
	{#State 389
		ACTIONS => {
			"\$RETURN_TYPE" => 442
		}
	},
	{#State 390
		ACTIONS => {
			'WORD_UPPERCASE' => 443
		}
	},
	{#State 391
		DEFAULT => -56
	},
	{#State 392
		ACTIONS => {
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Expression' => 185,
			'SubExpression' => 444,
			'HashReferenceLiteral' => 155,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123
		}
	},
	{#State 393
		DEFAULT => -168
	},
	{#State 394
		ACTIONS => {
			'OP15_LOGICAL_AND' => 222,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			")" => -262,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP21_LIST_COMMA' => -262,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP07_MATH_MULT_DIV_MOD' => 225
		},
		GOTOS => {
			'STAR-62' => 445
		}
	},
	{#State 395
		ACTIONS => {
			")" => 446
		}
	},
	{#State 396
		DEFAULT => -146
	},
	{#State 397
		DEFAULT => -139
	},
	{#State 398
		ACTIONS => {
			'SCALAR_SYMBOL' => 447
		}
	},
	{#State 399
		ACTIONS => {
			'SCALAR_SYMBOL' => 448
		}
	},
	{#State 400
		ACTIONS => {
			'SCALAR_SYMBOL' => 449
		}
	},
	{#State 401
		ACTIONS => {
			'SCALAR_SYMBOL' => 450
		}
	},
	{#State 402
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => 451,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238
		}
	},
	{#State 403
		ACTIONS => {
			";" => 452
		}
	},
	{#State 404
		ACTIONS => {
			'SCALAR_SYMBOL' => 125,
			'SELF' => 151,
			'LITERAL_STRING' => 115,
			'LITERAL_NUMBER' => 133
		},
		GOTOS => {
			'ScalarVariableOrLiteral' => 453,
			'ScalarVariableOrSelf' => 120,
			'ScalarLiteral' => 326,
			'ScalarVariable' => 327
		}
	},
	{#State 405
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_MATH_ADD_SUB' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP01_OPEN' => 197,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP10_NAMED_UNARY' => 192,
			'OP19_LOOP_CONTROL' => 202,
			'OP01_PRINT' => 188,
			'OP01_CLOSE' => 201,
			'OP01_NAMED' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP01_NAMED_VOID' => 195,
			'OP22_LOGICAL_NEG' => 205,
			'OP23_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 204,
			'WORD' => 189,
			'OP11_COMPARE_LT_GT' => 193
		},
		GOTOS => {
			'OpStringOrWord' => 454
		}
	},
	{#State 406
		ACTIONS => {
			'ARGV' => 131,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 31,
			"%{" => 161,
			'MY' => 242,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94
		},
		GOTOS => {
			'SubExpression' => 243,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'TypeInner' => 245,
			'ArrayHashLiteral' => 113,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'ArrayLiteralE' => 455,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ListElement' => 239,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 407
		DEFAULT => -242
	},
	{#State 408
		DEFAULT => -220
	},
	{#State 409
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 373,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_NAMED_SCOLON' => 458,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'STDIN' => 376,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 456,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154
		},
		GOTOS => {
			'OpNamedScolonOrSubExpIn' => 457,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 375,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'SubExpressionOrInput' => 459,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170
		}
	},
	{#State 410
		ACTIONS => {
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 460
		}
	},
	{#State 411
		ACTIONS => {
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'WORD' => 31,
			"%{" => 161,
			'OP10_NAMED_UNARY_SCOLON' => 456,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'STDIN' => 376,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'FHREF_SYMBOL_IN' => 373,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_NAMED_SCOLON' => 458,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'SubExpressionOrInput' => 459,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'OpNamedScolonOrSubExpIn' => 461,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 375
		}
	},
	{#State 412
		DEFAULT => -215
	},
	{#State 413
		ACTIONS => {
			'ARGV' => 131,
			'STDIN' => 376,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 31,
			"%{" => 161,
			'OP10_NAMED_UNARY_SCOLON' => 456,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'FHREF_SYMBOL_IN' => 373,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_NAMED_SCOLON' => 458,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133
		},
		GOTOS => {
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteralEmpty' => 112,
			'OpNamedScolonOrSubExpIn' => 462,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 375,
			'Expression' => 185,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'SubExpressionOrInput' => 459,
			'HashDereference' => 123
		}
	},
	{#State 414
		DEFAULT => -218
	},
	{#State 415
		DEFAULT => -222
	},
	{#State 416
		ACTIONS => {
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP13_BITWISE_AND' => 231,
			"]" => 463,
			'OP09_BITWISE_SHIFT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP04_MATH_POW' => 236,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP18_TERNARY' => 223,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228
		}
	},
	{#State 417
		ACTIONS => {
			"}" => 464,
			'LPAREN' => -292,
			'OP02_METHOD_THINARROW_NEW' => -292
		}
	},
	{#State 418
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			"}" => 465,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230
		}
	},
	{#State 419
		DEFAULT => -229
	},
	{#State 420
		DEFAULT => -208
	},
	{#State 421
		DEFAULT => -210
	},
	{#State 422
		DEFAULT => -209
	},
	{#State 423
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 466
		}
	},
	{#State 424
		DEFAULT => -136
	},
	{#State 425
		DEFAULT => -137
	},
	{#State 426
		DEFAULT => -276
	},
	{#State 427
		ACTIONS => {
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 468,
			'Expression' => 185,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 428
		DEFAULT => -246
	},
	{#State 429
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP01_OPEN' => 273,
			'SCALAR_SYMBOL' => 125,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'OP01_PRINT' => 188,
			'LITERAL_STRING' => 115,
			'OP12_COMPARE_EQ_NE' => 190,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 265,
			'WORD' => 268,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 260,
			'OP08_MATH_ADD_SUB' => 203,
			'OP01_CLOSE' => 270,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP19_LOOP_CONTROL' => 202,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'OP01_NAMED_VOID' => 195,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 183,
			'OP23_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 204,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP11_COMPARE_LT_GT' => 193,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 272,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138
		},
		GOTOS => {
			'ScalarVariable' => 262,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'Hash' => 163,
			'HashLiteralE' => 469,
			'ArrayDereference' => 145,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153,
			'OpStringOrWord' => 274,
			'SubExpression' => 266,
			'Expression' => 185,
			'HashEntry' => 271,
			'HashReferenceLiteral' => 155,
			'ScalarLiteral' => 261,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123
		}
	},
	{#State 430
		DEFAULT => -238
	},
	{#State 431
		ACTIONS => {
			'OP23_LOGICAL_AND' => 194,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP07_STRING_REPEAT' => 204,
			"\@{" => 143,
			'OP11_COMPARE_LT_GT' => 193,
			'OP22_LOGICAL_NEG' => 272,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP01_NAMED_VOID' => 195,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'OP01_CLOSE' => 270,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP19_LOOP_CONTROL' => 202,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 260,
			'OP08_MATH_ADD_SUB' => 203,
			'WORD' => 268,
			"%{" => 161,
			'LBRACKET' => 117,
			'MY' => 242,
			'HASH_SYMBOL' => 158,
			'LITERAL_STRING' => 115,
			'OP12_COMPARE_EQ_NE' => 190,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 265,
			'ARGV' => 131,
			'OP01_PRINT' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'ARRAY_SYMBOL' => 124,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP01_OPEN' => 273,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP03_MATH_INC_DEC' => 121
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 261,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ListElement' => 283,
			'HashReference' => 132,
			'Operator' => 95,
			'ArrayReference' => 153,
			'OpStringOrWord' => 274,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'TypeInner' => 245,
			'ArrayHashLiteralEmpty' => 112,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 279,
			'HashEntry' => 282,
			'ArrayReferenceVariable' => 180,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 262,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayDereference' => 145,
			'ArrayHashLiteralE' => 470,
			'Hash' => 163
		}
	},
	{#State 432
		ACTIONS => {
			")" => 471
		}
	},
	{#State 433
		ACTIONS => {
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'ARGV' => 131,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ArrayReferenceVariable' => 180,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'SubExpressions' => 472,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 186
		}
	},
	{#State 434
		DEFAULT => -275
	},
	{#State 435
		DEFAULT => -291
	},
	{#State 436
		ACTIONS => {
			'OP21_LIST_COMMA' => 473
		}
	},
	{#State 437
		DEFAULT => -155
	},
	{#State 438
		DEFAULT => -153
	},
	{#State 439
		ACTIONS => {
			'LBRACE' => 474
		}
	},
	{#State 440
		ACTIONS => {
			'SUB' => 478,
			'LITERAL_NUMBER' => 479
		},
		GOTOS => {
			'SubroutineOrMethod' => 476,
			'Method' => 475,
			'Subroutine' => 477
		}
	},
	{#State 441
		DEFAULT => -55
	},
	{#State 442
		ACTIONS => {
			"}" => 480
		}
	},
	{#State 443
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 481
		}
	},
	{#State 444
		ACTIONS => {
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => 222,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -167,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => -167,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP21_LIST_COMMA' => -167,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223
		}
	},
	{#State 445
		ACTIONS => {
			'OP21_LIST_COMMA' => 483,
			")" => 482
		},
		GOTOS => {
			'PAREN-61' => 484
		}
	},
	{#State 446
		DEFAULT => -154
	},
	{#State 447
		ACTIONS => {
			'LPAREN' => 485
		}
	},
	{#State 448
		ACTIONS => {
			'LPAREN' => 486
		}
	},
	{#State 449
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 487
		}
	},
	{#State 450
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 488
		}
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 489
		}
	},
	{#State 452
		DEFAULT => -141
	},
	{#State 453
		DEFAULT => -126
	},
	{#State 454
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 490
		}
	},
	{#State 455
		DEFAULT => -241
	},
	{#State 456
		DEFAULT => -311
	},
	{#State 457
		DEFAULT => -221
	},
	{#State 458
		DEFAULT => -310
	},
	{#State 459
		ACTIONS => {
			";" => 491
		}
	},
	{#State 460
		ACTIONS => {
			"]" => 492,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229
		}
	},
	{#State 461
		DEFAULT => -216
	},
	{#State 462
		DEFAULT => -219
	},
	{#State 463
		DEFAULT => -212
	},
	{#State 464
		DEFAULT => -214
	},
	{#State 465
		DEFAULT => -213
	},
	{#State 466
		DEFAULT => -187,
		GOTOS => {
			'STAR-50' => 493
		}
	},
	{#State 467
		ACTIONS => {
			'HASH_SYMBOL' => 158,
			'MY' => 118,
			'LBRACKET' => 117,
			'POD' => 159,
			"%{" => 161,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			"foreach" => -178,
			'WORD' => 31,
			'OP01_NAMED' => 111,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'OP01_PRINT' => 129,
			"for" => -178,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122,
			"if" => 126,
			'SCALAR_SYMBOL' => 125,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 103,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'OP01_NAMED_VOID' => 96,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP19_LOOP_CONTROL' => 149,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'OP01_NAMED_SCOLON' => 146,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			"while" => -178,
			'CONSTANT_CALL_SCOPED' => 108
		},
		GOTOS => {
			'Operator' => 95,
			'Array' => 134,
			'Statement' => 97,
			'Expression' => 136,
			'PLUS-53' => 494,
			'ArrayReferenceVariable' => 99,
			'HashRefLiteralEmpty' => 139,
			'ArrayVariable' => 101,
			'HashReferenceVariable' => 141,
			'ScalarVariable' => 100,
			'ArrayDereference' => 145,
			'Variable' => 144,
			'ArrayRefLiteralEmpty' => 105,
			'OPTIONAL-48' => 107,
			'Conditional' => 148,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'ArrayReference' => 153,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 116,
			'LoopLabel' => 157,
			'HashVariable' => 119,
			'Hash' => 163,
			'OperatorVoid' => 164,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Operation' => 495,
			'VariableModification' => 168,
			'Scalar' => 130,
			'PAREN-47' => 128,
			'VariableDeclaration' => 169,
			'WordScoped' => 170,
			'HashReference' => 132
		}
	},
	{#State 468
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			")" => -278,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP08_MATH_ADD_SUB' => 227,
			'OP21_LIST_COMMA' => -278,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			"}" => -278
		}
	},
	{#State 469
		DEFAULT => -245
	},
	{#State 470
		DEFAULT => -237
	},
	{#State 471
		DEFAULT => -99
	},
	{#State 472
		ACTIONS => {
			")" => 496
		}
	},
	{#State 473
		ACTIONS => {
			'LITERAL_STRING' => 497
		}
	},
	{#State 474
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 205,
			'OP23_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 204,
			'WORD' => 189,
			'OP11_COMPARE_LT_GT' => 193,
			'OP01_NAMED' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP01_NAMED_VOID' => 195,
			'OP19_LOOP_CONTROL' => 202,
			'OP01_PRINT' => 188,
			'OP01_CLOSE' => 201,
			"}" => 498,
			'OP08_MATH_ADD_SUB' => 203,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP10_NAMED_UNARY' => 192,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP01_OPEN' => 197
		},
		GOTOS => {
			'OpStringOrWord' => 500,
			'HashEntryProperties' => 499
		}
	},
	{#State 475
		DEFAULT => -94
	},
	{#State 476
		DEFAULT => -74
	},
	{#State 477
		DEFAULT => -93
	},
	{#State 478
		ACTIONS => {
			'WORD' => 501
		}
	},
	{#State 479
		ACTIONS => {
			";" => 502
		}
	},
	{#State 480
		ACTIONS => {
			";" => 503
		}
	},
	{#State 481
		DEFAULT => -301
	},
	{#State 482
		DEFAULT => -263
	},
	{#State 483
		ACTIONS => {
			'MY' => 242
		},
		GOTOS => {
			'TypeInner' => 245,
			'ListElement' => 504
		}
	},
	{#State 484
		DEFAULT => -261
	},
	{#State 485
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'SubExpressions' => 505,
			'ArrayReference' => 153,
			'Expression' => 185,
			'SubExpression' => 186,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 486
		ACTIONS => {
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			"%{" => 161,
			'WORD' => 31,
			'OP01_NAMED' => 178,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167
		},
		GOTOS => {
			'SubExpression' => 506,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 487
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'OP01_NAMED_SCOLON' => 509,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 507,
			"%{" => 161,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158
		},
		GOTOS => {
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'OpNamedScolonOrSubExp' => 508,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'HashReference' => 132,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 510,
			'Expression' => 185,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayDereference' => 145,
			'Hash' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139
		}
	},
	{#State 488
		ACTIONS => {
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'STDIN' => 376,
			'ARRAY_SYMBOL' => 124,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'FHREF_SYMBOL_IN' => 373,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106
		},
		GOTOS => {
			'Expression' => 185,
			'SubExpression' => 375,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashReferenceVariable' => 184,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'SubExpressionOrInput' => 511,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 489
		DEFAULT => -198
	},
	{#State 490
		DEFAULT => -298
	},
	{#State 491
		DEFAULT => -312
	},
	{#State 492
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 512
		}
	},
	{#State 493
		ACTIONS => {
			'OP01_QW' => -190,
			"while" => -190,
			"elsif" => 516,
			'CONSTANT_CALL_SCOPED' => -190,
			'OP10_NAMED_UNARY' => -190,
			'OP01_NAMED_SCOLON' => -190,
			'OP01_CLOSE' => -190,
			'OP22_LOGICAL_NEG_LPAREN' => -190,
			'SELF' => -190,
			'' => -190,
			'OP19_LOOP_CONTROL' => -190,
			'LPAREN_TYPE_INNER' => -190,
			'LPAREN' => -190,
			'OP01_NAMED_VOID' => -190,
			'LBRACE' => -190,
			'WORD_SCOPED' => -190,
			'OP05_MATH_NEG_LPAREN' => -190,
			'LITERAL_NUMBER' => -190,
			'WORD_UPPERCASE' => -190,
			'OP05_BITWISE_NEG_LPAREN' => -190,
			"\@{" => -190,
			'OP01_NAMED_VOID_LPAREN' => -190,
			'OP22_LOGICAL_NEG' => -190,
			'ARRAY_REF_SYMBOL' => -190,
			'HASH_REF_SYMBOL' => -190,
			"else" => 517,
			'ARRAY_SYMBOL' => -190,
			'SCALAR_SYMBOL' => -190,
			'OP19_LOOP_CONTROL_SCOLON' => -190,
			"undef" => -190,
			'OP01_OPEN' => -190,
			"if" => -190,
			'OP01_NAMED_VOID_SCOLON' => -190,
			'OP03_MATH_INC_DEC' => -190,
			"}" => -190,
			'ARGV' => -190,
			"for" => -190,
			'OP01_PRINT' => -190,
			'LITERAL_STRING' => -190,
			'ENV' => -190,
			'OP05_LOGICAL_NEG' => -190,
			'OP01_NAMED' => -190,
			'WORD' => -190,
			"foreach" => -190,
			"%{" => -190,
			'OP10_NAMED_UNARY_SCOLON' => -190,
			'POD' => -190,
			'LBRACKET' => -190,
			'HASH_SYMBOL' => -190,
			'MY' => -190
		},
		GOTOS => {
			'PAREN-49' => 513,
			'OPTIONAL-52' => 515,
			'PAREN-51' => 514
		}
	},
	{#State 494
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"if" => 126,
			'ARRAY_SYMBOL' => 124,
			'OP01_PRINT' => 129,
			"for" => -178,
			'ARGV' => 131,
			"}" => 519,
			'OP01_NAMED' => 111,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'POD' => 159,
			'MY' => 118,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"foreach" => -178,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			"%{" => 161,
			'OP01_NAMED_SCOLON' => 146,
			"while" => -178,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP19_LOOP_CONTROL' => 149,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP01_NAMED_VOID' => 96,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 103,
			"\@{" => 143,
			'OP01_NAMED_VOID_LPAREN' => 102
		},
		GOTOS => {
			'HashReferenceLiteral' => 155,
			'LoopLabel' => 157,
			'SubExpression' => 116,
			'ArrayReference' => 153,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'OperatorVoid' => 164,
			'Hash' => 163,
			'HashVariable' => 119,
			'HashDereference' => 123,
			'Operation' => 518,
			'ScalarVariableOrSelf' => 120,
			'WordScoped' => 170,
			'HashReference' => 132,
			'PAREN-47' => 128,
			'VariableModification' => 168,
			'Scalar' => 130,
			'VariableDeclaration' => 169,
			'Expression' => 136,
			'Statement' => 97,
			'Operator' => 95,
			'Array' => 134,
			'ArrayDereference' => 145,
			'Variable' => 144,
			'ArrayReferenceVariable' => 99,
			'ScalarVariable' => 100,
			'ArrayVariable' => 101,
			'HashReferenceVariable' => 141,
			'HashRefLiteralEmpty' => 139,
			'Conditional' => 148,
			'OPTIONAL-48' => 107,
			'ArrayRefLiteralEmpty' => 105,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109
		}
	},
	{#State 495
		DEFAULT => -201
	},
	{#State 496
		DEFAULT => -102
	},
	{#State 497
		ACTIONS => {
			'OP21_LIST_COMMA' => 520
		}
	},
	{#State 498
		ACTIONS => {
			";" => 521
		}
	},
	{#State 499
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 522
		}
	},
	{#State 500
		ACTIONS => {
			'OP20_HASH_FATARROW' => 523
		}
	},
	{#State 501
		ACTIONS => {
			'LBRACE' => 524
		}
	},
	{#State 502
		DEFAULT => -76
	},
	{#State 503
		ACTIONS => {
			'MY' => -58,
			'HASH_SYMBOL' => -58,
			'LBRACKET' => -58,
			'POD' => -58,
			"%{" => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'LPAREN_MY' => 526,
			"foreach" => -58,
			'WORD' => -58,
			'OP01_NAMED' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'ENV' => -58,
			'LITERAL_STRING' => -58,
			'OP01_PRINT' => -58,
			"for" => -58,
			'ARGV' => -58,
			"}" => -58,
			'OP03_MATH_INC_DEC' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			"undef" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'OP01_OPEN' => -58,
			'SCALAR_SYMBOL' => -58,
			"if" => -58,
			'ARRAY_SYMBOL' => -58,
			'HASH_REF_SYMBOL' => -58,
			'ARRAY_REF_SYMBOL' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			"\@{" => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'WORD_UPPERCASE' => -58,
			'LITERAL_NUMBER' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'WORD_SCOPED' => -58,
			'LBRACE' => -58,
			'OP01_NAMED_VOID' => -58,
			'LPAREN' => -58,
			'LPAREN_TYPE_INNER' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'SELF' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'OP01_CLOSE' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP10_NAMED_UNARY' => -58,
			"while" => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP01_QW' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 527,
			'SubroutineArguments' => 525
		}
	},
	{#State 504
		DEFAULT => -260
	},
	{#State 505
		ACTIONS => {
			")" => 528
		}
	},
	{#State 506
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 529,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234
		}
	},
	{#State 507
		DEFAULT => -308
	},
	{#State 508
		ACTIONS => {
			'SCALAR_SYMBOL' => 530
		}
	},
	{#State 509
		DEFAULT => -307
	},
	{#State 510
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => 531,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP15_LOGICAL_AND' => 222
		}
	},
	{#State 511
		ACTIONS => {
			")" => 532
		}
	},
	{#State 512
		ACTIONS => {
			"undef" => 533
		}
	},
	{#State 513
		DEFAULT => -186
	},
	{#State 514
		DEFAULT => -189
	},
	{#State 515
		DEFAULT => -191
	},
	{#State 516
		ACTIONS => {
			'LPAREN' => 534
		}
	},
	{#State 517
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 535
		}
	},
	{#State 518
		DEFAULT => -200
	},
	{#State 519
		DEFAULT => -202
	},
	{#State 520
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Expression' => 185,
			'SubExpression' => 536,
			'HashReferenceLiteral' => 155,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'HashReferenceVariable' => 184,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145
		}
	},
	{#State 521
		DEFAULT => -83
	},
	{#State 522
		ACTIONS => {
			'OP21_LIST_COMMA' => 538,
			"}" => 537
		},
		GOTOS => {
			'PAREN-33' => 539
		}
	},
	{#State 523
		ACTIONS => {
			'MY' => 541
		},
		GOTOS => {
			'TypeInnerProperties' => 540
		}
	},
	{#State 524
		ACTIONS => {
			'LBRACE' => 542
		}
	},
	{#State 525
		DEFAULT => -57
	},
	{#State 526
		ACTIONS => {
			'WORD_SCOPED' => 249,
			'TYPE_INTEGER' => 250,
			'WORD' => 246
		},
		GOTOS => {
			'Type' => 543
		}
	},
	{#State 527
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 544
		}
	},
	{#State 528
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 545
		}
	},
	{#State 529
		ACTIONS => {
			'ARGV' => 131,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'SubExpression' => 546,
			'Expression' => 185,
			'HashReferenceLiteral' => 155
		}
	},
	{#State 530
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 547
		}
	},
	{#State 531
		DEFAULT => -309
	},
	{#State 532
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 548
		}
	},
	{#State 533
		ACTIONS => {
			";" => 549
		}
	},
	{#State 534
		ACTIONS => {
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			"%{" => 161,
			'WORD' => 31,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158
		},
		GOTOS => {
			'Array' => 134,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Operator' => 95,
			'ArrayReference' => 153,
			'Expression' => 185,
			'SubExpression' => 550,
			'HashReferenceLiteral' => 155,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 180,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150
		}
	},
	{#State 535
		DEFAULT => -188
	},
	{#State 536
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			"}" => -103,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			"]" => -103,
			'OP12_COMPARE_EQ_NE' => 229,
			";" => -103,
			")" => -103,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP08_STRING_CAT' => 232,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => -103,
			'OP15_LOGICAL_AND' => 222
		}
	},
	{#State 537
		ACTIONS => {
			";" => 551
		}
	},
	{#State 538
		ACTIONS => {
			'OP01_PRINT' => 188,
			'OP19_LOOP_CONTROL' => 202,
			'OP01_CLOSE' => 201,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_MATH_ADD_SUB' => 203,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP10_NAMED_UNARY' => 192,
			'OP01_OPEN' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP22_LOGICAL_NEG' => 205,
			'OP11_COMPARE_LT_GT' => 193,
			'WORD' => 189,
			'OP07_STRING_REPEAT' => 204,
			'OP23_LOGICAL_AND' => 194,
			'OP01_NAMED' => 191,
			'OP01_NAMED_VOID' => 195,
			'OP12_COMPARE_EQ_NE' => 190
		},
		GOTOS => {
			'OpStringOrWord' => 500,
			'HashEntryProperties' => 552
		}
	},
	{#State 539
		DEFAULT => -80
	},
	{#State 540
		DEFAULT => -279
	},
	{#State 541
		ACTIONS => {
			'WORD' => 246,
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249
		},
		GOTOS => {
			'Type' => 553
		}
	},
	{#State 542
		ACTIONS => {
			'MY' => 554
		}
	},
	{#State 543
		ACTIONS => {
			'SCALAR_SYMBOL' => 555
		}
	},
	{#State 544
		ACTIONS => {
			'ARRAY_SYMBOL' => 124,
			'SCALAR_SYMBOL' => 125,
			"if" => 126,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP03_MATH_INC_DEC' => 121,
			"}" => 557,
			'ARGV' => 131,
			"for" => -178,
			'OP01_PRINT' => 129,
			'LITERAL_STRING' => 115,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'OP01_NAMED' => 111,
			"foreach" => -178,
			'WORD' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			"%{" => 161,
			'POD' => 159,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'MY' => 118,
			"while" => -178,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_NAMED_SCOLON' => 146,
			'OP01_CLOSE' => 152,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP19_LOOP_CONTROL' => 149,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'OP01_NAMED_VOID' => 96,
			'LBRACE' => 135,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 133,
			'WORD_UPPERCASE' => 103,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			"\@{" => 143,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142,
			'HASH_REF_SYMBOL' => 138
		},
		GOTOS => {
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'ArrayRefLiteralEmpty' => 105,
			'Conditional' => 148,
			'OPTIONAL-48' => 107,
			'ArrayReferenceVariable' => 99,
			'ScalarVariable' => 100,
			'HashReferenceVariable' => 141,
			'ArrayVariable' => 101,
			'HashRefLiteralEmpty' => 139,
			'Variable' => 144,
			'ArrayDereference' => 145,
			'Operator' => 95,
			'Array' => 134,
			'Expression' => 136,
			'Statement' => 97,
			'PAREN-47' => 128,
			'Scalar' => 130,
			'VariableModification' => 168,
			'VariableDeclaration' => 169,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ScalarVariableOrSelf' => 120,
			'HashDereference' => 123,
			'Operation' => 556,
			'HashVariable' => 119,
			'Hash' => 163,
			'OperatorVoid' => 164,
			'ArrayReference' => 153,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'HashReferenceLiteral' => 155,
			'LoopLabel' => 157,
			'SubExpression' => 116
		}
	},
	{#State 545
		DEFAULT => -197
	},
	{#State 546
		ACTIONS => {
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => -125,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 238,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => 558,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP15_LOGICAL_AND' => 222,
			'OP23_LOGICAL_AND' => -125,
			'OP07_STRING_REPEAT' => 226,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233
		}
	},
	{#State 547
		ACTIONS => {
			'ARRAY_SYMBOL' => 124,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			"undef" => 167,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'ENV' => 114,
			'OP05_LOGICAL_NEG' => 154,
			'LITERAL_STRING' => 115,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY_SCOLON' => 507,
			"%{" => 161,
			'WORD' => 31,
			'LBRACKET' => 117,
			'HASH_SYMBOL' => 158,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP01_NAMED_SCOLON' => 509,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'SELF' => 151,
			'OP01_CLOSE' => 152,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LITERAL_NUMBER' => 133,
			'LBRACE' => 135,
			"\@{" => 143,
			'WORD_UPPERCASE' => 183,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'HASH_REF_SYMBOL' => 138,
			'OP22_LOGICAL_NEG' => 140,
			'ARRAY_REF_SYMBOL' => 142
		},
		GOTOS => {
			'HashReference' => 132,
			'WordScoped' => 170,
			'ArrayReferenceLiteral' => 150,
			'ScalarLiteral' => 109,
			'Scalar' => 130,
			'HashDereference' => 123,
			'OpNamedScolonOrSubExp' => 559,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 510,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'Array' => 134,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Operator' => 95,
			'ArrayReference' => 153
		}
	},
	{#State 548
		DEFAULT => -199
	},
	{#State 549
		DEFAULT => -217
	},
	{#State 550
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			")" => 560,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP18_TERNARY' => 223,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231
		}
	},
	{#State 551
		DEFAULT => -82
	},
	{#State 552
		DEFAULT => -79
	},
	{#State 553
		ACTIONS => {
			"\$TYPED_" => 561
		}
	},
	{#State 554
		ACTIONS => {
			'TYPE_METHOD' => 562,
			'WORD' => 246,
			'WORD_SCOPED' => 249,
			'TYPE_INTEGER' => 250
		},
		GOTOS => {
			'Type' => 389
		}
	},
	{#State 555
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 563
		}
	},
	{#State 556
		DEFAULT => -59
	},
	{#State 557
		DEFAULT => -61
	},
	{#State 558
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 564
		}
	},
	{#State 559
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 121,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'ARGV' => 131,
			'OP01_NAMED' => 178,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			"%{" => 161,
			'WORD' => 31,
			'OP10_NAMED_UNARY' => 106,
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'LBRACE' => 135,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'Scalar' => 130,
			'VariableModification' => 565,
			'ScalarLiteral' => 109,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'ArrayDereference' => 145,
			'Variable' => 144,
			'Hash' => 163,
			'ArrayReferenceVariable' => 99,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 119,
			'ArrayVariable' => 101,
			'HashReferenceVariable' => 141,
			'ScalarVariable' => 100,
			'SubExpressionOrVarMod' => 567,
			'HashReferenceLiteral' => 155,
			'Expression' => 185,
			'SubExpression' => 566,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134
		}
	},
	{#State 560
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 568
		}
	},
	{#State 561
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 202,
			'OP01_PRINT' => 188,
			'OP01_CLOSE' => 201,
			'OP08_MATH_ADD_SUB' => 203,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP01_OPEN' => 197,
			'OP19_LOOP_CONTROL_SCOLON' => 198,
			'OP10_NAMED_UNARY' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 196,
			'OP22_LOGICAL_NEG' => 205,
			'WORD' => 189,
			'OP07_STRING_REPEAT' => 204,
			'OP23_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 193,
			'OP01_NAMED' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP01_NAMED_VOID' => 195
		},
		GOTOS => {
			'OpStringOrWord' => 569
		}
	},
	{#State 562
		ACTIONS => {
			"\$RETURN_TYPE" => 570
		}
	},
	{#State 563
		ACTIONS => {
			'OP21_LIST_COMMA' => 572,
			")" => 571
		},
		GOTOS => {
			'PAREN-26' => 573
		}
	},
	{#State 564
		DEFAULT => -195
	},
	{#State 565
		DEFAULT => -175
	},
	{#State 566
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			")" => -174,
			'OP23_LOGICAL_AND' => 235,
			'OP07_STRING_REPEAT' => 226,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP04_MATH_POW' => 236,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP08_MATH_ADD_SUB' => 227,
			'OP18_TERNARY' => 223,
			'OP17_LIST_RANGE' => 237,
			'OP16_LOGICAL_OR' => 238,
			'OP13_BITWISE_AND' => 231,
			'OP09_BITWISE_SHIFT' => 230
		}
	},
	{#State 567
		ACTIONS => {
			")" => 574
		}
	},
	{#State 568
		DEFAULT => -185
	},
	{#State 569
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 576,
			'OP02_ARRAY_THINARROW' => 575
		}
	},
	{#State 570
		ACTIONS => {
			"}" => 577
		}
	},
	{#State 571
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 578
		}
	},
	{#State 572
		ACTIONS => {
			'MY' => 579
		}
	},
	{#State 573
		DEFAULT => -63
	},
	{#State 574
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 580
		}
	},
	{#State 575
		ACTIONS => {
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP01_QW' => 147,
			'OP10_NAMED_UNARY' => 106,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LPAREN' => 137,
			'LPAREN_TYPE_INNER' => 98,
			'ARGV' => 131,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_OPEN' => 166,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117,
			'WORD' => 31,
			"%{" => 161,
			'OP01_NAMED' => 178,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 120,
			'ArrayRefLiteralEmpty' => 105,
			'HashDereference' => 123,
			'Scalar' => 130,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'HashReference' => 132,
			'ArrayReference' => 153,
			'Operator' => 95,
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'Array' => 134,
			'HashReferenceLiteral' => 155,
			'SubExpression' => 581,
			'Expression' => 185,
			'ArrayReferenceVariable' => 180,
			'HashRefLiteralEmpty' => 139,
			'HashVariable' => 177,
			'HashReferenceVariable' => 184,
			'ArrayVariable' => 182,
			'ScalarVariable' => 181,
			'ArrayDereference' => 145,
			'Hash' => 163
		}
	},
	{#State 576
		ACTIONS => {
			'OP01_QW' => 147,
			'CONSTANT_CALL_SCOPED' => 108,
			'OP10_NAMED_UNARY' => 106,
			'OP01_CLOSE' => 152,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'LBRACE' => 135,
			'LITERAL_NUMBER' => 133,
			'OP05_MATH_NEG_LPAREN' => 94,
			'WORD_SCOPED' => 29,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 183,
			"\@{" => 143,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			'HASH_REF_SYMBOL' => 138,
			"undef" => 167,
			'OP01_OPEN' => 166,
			'SCALAR_SYMBOL' => 125,
			'ARRAY_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 121,
			'ARGV' => 131,
			'LITERAL_STRING' => 115,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'OP01_NAMED' => 178,
			'WORD' => 31,
			"%{" => 161,
			'HASH_SYMBOL' => 158,
			'LBRACKET' => 117
		},
		GOTOS => {
			'SubExpression' => 582,
			'Expression' => 185,
			'HashReferenceLiteral' => 155,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayHashLiteral' => 113,
			'Array' => 134,
			'ArrayReference' => 153,
			'Operator' => 95,
			'Hash' => 163,
			'ArrayDereference' => 145,
			'HashVariable' => 177,
			'HashRefLiteralEmpty' => 139,
			'HashReferenceVariable' => 184,
			'ScalarVariable' => 181,
			'ArrayVariable' => 182,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 123,
			'ArrayRefLiteralEmpty' => 105,
			'ScalarVariableOrSelf' => 120,
			'HashReference' => 132,
			'ArrayReferenceLiteral' => 150,
			'WordScoped' => 170,
			'ScalarLiteral' => 109,
			'Scalar' => 130
		}
	},
	{#State 577
		ACTIONS => {
			";" => 583
		}
	},
	{#State 578
		ACTIONS => {
			"\@ARG;" => 584
		}
	},
	{#State 579
		ACTIONS => {
			'WORD' => 246,
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249
		},
		GOTOS => {
			'Type' => 585
		}
	},
	{#State 580
		DEFAULT => -196
	},
	{#State 581
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 229,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP11_COMPARE_LT_GT' => 233,
			'OP06_REGEX_BIND' => 234,
			'OP15_LOGICAL_AND' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 225,
			'OP08_MATH_ADD_SUB' => 227,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 236,
			'OP18_TERNARY' => 223,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP13_BITWISE_AND' => 231,
			"]" => 586,
			'OP09_BITWISE_SHIFT' => 230
		}
	},
	{#State 582
		ACTIONS => {
			'OP15_LOGICAL_AND' => 222,
			'OP06_REGEX_BIND' => 234,
			'OP11_COMPARE_LT_GT' => 233,
			'OP07_STRING_REPEAT' => 226,
			'OP23_LOGICAL_AND' => 235,
			'OP08_STRING_CAT' => 232,
			'OP14_BITWISE_OR_XOR' => 228,
			'OP12_COMPARE_EQ_NE' => 229,
			'OP09_BITWISE_SHIFT' => 230,
			'OP13_BITWISE_AND' => 231,
			"}" => -299,
			'OP16_LOGICAL_OR' => 238,
			'OP17_LIST_RANGE' => 237,
			'OP18_TERNARY' => 223,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP21_LIST_COMMA' => -299,
			'OP08_MATH_ADD_SUB' => 227,
			'OP04_MATH_POW' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 225
		}
	},
	{#State 583
		ACTIONS => {
			'WORD' => -85,
			"foreach" => -85,
			"%{" => -85,
			'LPAREN_MY' => 588,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'POD' => -85,
			'LBRACKET' => -85,
			'MY' => -85,
			'HASH_SYMBOL' => -85,
			'LITERAL_STRING' => -85,
			'ENV' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP01_NAMED' => -85,
			"}" => -85,
			'ARGV' => -85,
			"for" => -85,
			'OP01_PRINT' => -85,
			'ARRAY_SYMBOL' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_OPEN' => -85,
			"undef" => -85,
			'SCALAR_SYMBOL' => -85,
			"if" => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'WORD_UPPERCASE' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			"\@{" => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			'HASH_REF_SYMBOL' => -85,
			'LPAREN_TYPE_INNER' => -85,
			'LPAREN' => -85,
			'OP01_NAMED_VOID' => -85,
			'LBRACE' => -85,
			'WORD_SCOPED' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'LITERAL_NUMBER' => -85,
			'OP01_CLOSE' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'SELF' => -85,
			'OP19_LOOP_CONTROL' => -85,
			"while" => -85,
			'OP01_QW' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP01_NAMED_SCOLON' => -85
		},
		GOTOS => {
			'MethodArguments' => 587,
			'OPTIONAL-35' => 589
		}
	},
	{#State 584
		DEFAULT => -65
	},
	{#State 585
		ACTIONS => {
			'SCALAR_SYMBOL' => 590
		}
	},
	{#State 586
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 591
		}
	},
	{#State 587
		DEFAULT => -84
	},
	{#State 588
		ACTIONS => {
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249,
			'WORD' => 246
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
		DEFAULT => -62
	},
	{#State 591
		ACTIONS => {
			"undef" => 594
		}
	},
	{#State 592
		ACTIONS => {
			'SELF' => 595
		}
	},
	{#State 593
		ACTIONS => {
			'OP01_NAMED_SCOLON' => 146,
			'OP10_NAMED_UNARY' => 106,
			'CONSTANT_CALL_SCOPED' => 108,
			"while" => -178,
			'OP01_QW' => 147,
			'OP19_LOOP_CONTROL' => 149,
			'SELF' => 151,
			'OP22_LOGICAL_NEG_LPAREN' => 110,
			'OP01_CLOSE' => 152,
			'LITERAL_NUMBER' => 133,
			'WORD_SCOPED' => 29,
			'OP05_MATH_NEG_LPAREN' => 94,
			'LBRACE' => 135,
			'OP01_NAMED_VOID' => 96,
			'LPAREN_TYPE_INNER' => 98,
			'LPAREN' => 137,
			'HASH_REF_SYMBOL' => 138,
			'ARRAY_REF_SYMBOL' => 142,
			'OP22_LOGICAL_NEG' => 140,
			"\@{" => 143,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP05_BITWISE_NEG_LPAREN' => 104,
			'WORD_UPPERCASE' => 103,
			'OP03_MATH_INC_DEC' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122,
			"undef" => 167,
			'SCALAR_SYMBOL' => 125,
			"if" => 126,
			'OP19_LOOP_CONTROL_SCOLON' => 165,
			'OP01_OPEN' => 166,
			'ARRAY_SYMBOL' => 124,
			'OP01_PRINT' => 129,
			"for" => -178,
			'ARGV' => 131,
			"}" => 597,
			'OP01_NAMED' => 111,
			'OP05_LOGICAL_NEG' => 154,
			'ENV' => 114,
			'LITERAL_STRING' => 115,
			'HASH_SYMBOL' => 158,
			'MY' => 118,
			'LBRACKET' => 117,
			'POD' => 159,
			"%{" => 161,
			'OP10_NAMED_UNARY_SCOLON' => 160,
			'WORD' => 31,
			"foreach" => -178
		},
		GOTOS => {
			'ArrayHashLiteral' => 113,
			'ArrayHashLiteralEmpty' => 112,
			'ArrayReference' => 153,
			'LoopLabel' => 157,
			'SubExpression' => 116,
			'HashReferenceLiteral' => 155,
			'HashVariable' => 119,
			'OperatorVoid' => 164,
			'Hash' => 163,
			'ScalarVariableOrSelf' => 120,
			'Operation' => 596,
			'HashDereference' => 123,
			'VariableDeclaration' => 169,
			'VariableModification' => 168,
			'Scalar' => 130,
			'PAREN-47' => 128,
			'HashReference' => 132,
			'WordScoped' => 170,
			'Array' => 134,
			'Operator' => 95,
			'Expression' => 136,
			'Statement' => 97,
			'ArrayVariable' => 101,
			'ScalarVariable' => 100,
			'HashReferenceVariable' => 141,
			'HashRefLiteralEmpty' => 139,
			'ArrayReferenceVariable' => 99,
			'ArrayDereference' => 145,
			'Variable' => 144,
			'ArrayRefLiteralEmpty' => 105,
			'OPTIONAL-48' => 107,
			'Conditional' => 148,
			'ScalarLiteral' => 109,
			'ArrayReferenceLiteral' => 150
		}
	},
	{#State 594
		DEFAULT => -300
	},
	{#State 595
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 598
		}
	},
	{#State 596
		DEFAULT => -86
	},
	{#State 597
		DEFAULT => -88
	},
	{#State 598
		ACTIONS => {
			'OP21_LIST_COMMA' => 601,
			")" => 600
		},
		GOTOS => {
			'PAREN-37' => 599
		}
	},
	{#State 599
		DEFAULT => -90
	},
	{#State 600
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 602
		}
	},
	{#State 601
		ACTIONS => {
			'MY' => 603
		}
	},
	{#State 602
		ACTIONS => {
			"\@ARG;" => 604
		}
	},
	{#State 603
		ACTIONS => {
			'TYPE_INTEGER' => 250,
			'WORD_SCOPED' => 249,
			'WORD' => 246
		},
		GOTOS => {
			'Type' => 605
		}
	},
	{#State 604
		DEFAULT => -92
	},
	{#State 605
		ACTIONS => {
			'SCALAR_SYMBOL' => 606
		}
	},
	{#State 606
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 10248 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10255 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10262 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10269 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10280 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10291 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10298 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10305 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10312 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10319 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10326 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10333 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10347 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10354 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10361 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10368 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10375 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10386 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10393 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10400 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10407 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10414 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10425 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10436 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10447 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10454 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10461 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10468 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10475 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10482 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10489 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10496 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10503 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10510 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10517 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10542 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10553 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10560 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10567 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10578 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10585 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10592 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10599 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10606 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10613 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10620 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10631 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10638 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10645 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10652 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10659 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10670 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10681 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10699 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10713 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10720 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10731 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10738 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10745 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10752 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10763 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10791 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10798 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10805 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10812 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10819 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10826 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10833 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10844 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10855 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10866 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10873 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10880 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10887 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10898 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10909 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10916 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10937 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10948 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10955 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10969 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10980 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10991 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11002 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11013 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11024 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11035 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11046 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11057 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11068 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11079 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11090 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11101 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11112 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11123 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11134 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11145 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11156 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11167 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11178 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11189 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11200 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11211 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11222 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11233 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11244 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11255 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11266 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11277 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11288 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11299 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11310 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11321 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11332 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11343 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11354 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11365 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11376 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11387 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_130
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11398 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11405 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11419 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11433 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11444 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11455 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11466 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11477 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11488 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11499 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11510 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_143
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11521 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11563 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11574 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11585 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11596 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11607 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11618 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_155
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11629 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11640 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11651 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11662 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11673 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11684 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11695 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11706 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11717 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_164
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11728 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_165
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11739 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_166
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11750 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11757 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11764 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11771 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressions_170
		 'SubExpressions', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11782 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_171
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11793 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_172
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11804 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_173
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11815 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_174
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11826 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_175
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11837 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11844 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11858 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_179
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11869 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_180
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11880 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_181
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11891 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_182
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11902 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_183
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11913 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_184
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11924 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 5,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11945 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11966 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_191
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11977 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_192
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11988 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_193
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11999 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_194
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12010 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_195
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12021 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_196
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12032 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_197
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12043 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_198
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12054 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_199
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12065 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12079 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_202
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12090 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_203
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12101 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_204
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12112 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_205
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12123 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_206
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12134 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_207
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12145 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_208
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12156 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_209
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12167 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_210
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12178 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_211
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12189 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_212
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12200 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_213
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12211 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_214
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12222 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_215
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12233 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_216
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12244 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_217
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12255 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_218
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12266 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_219
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12277 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_220
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12288 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_221
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12299 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_222
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12310 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_223
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12321 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_224
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12332 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_225
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12343 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_226
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12354 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_227
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12365 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_228
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12376 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 293 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 293 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12390 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_231
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12401 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_232
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12412 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_233
		 'ScalarVariable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12423 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_234
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12434 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_235
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12445 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteral_236
		 'ArrayHashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12456 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 296 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12463 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 296 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12470 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 296 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12477 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEs_240
		 'ArrayHashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12488 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12495 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12502 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12509 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralEs_244
		 'ArrayLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12520 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-59', 2,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12527 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 2,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12534 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-60', 0,
sub {
#line 298 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12541 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralEs_248
		 'HashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12552 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_249
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12563 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_250
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12574 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_251
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12585 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_252
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12596 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_253
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12607 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_254
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12618 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_255
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12629 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEmpty_256
		 'ArrayHashLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12640 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayRefLiteralEmpty_257
		 'ArrayRefLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12651 lib/RPerl/Grammar.pm
	],
	[#Rule HashRefLiteralEmpty_258
		 'HashRefLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12662 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_259
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12673 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-61', 2,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12680 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12687 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12694 lib/RPerl/Grammar.pm
	],
	[#Rule Array_263
		 'Array', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12705 lib/RPerl/Grammar.pm
	],
	[#Rule Array_264
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12716 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_265
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12727 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_266
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12738 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_267
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12749 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_268
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12760 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_269
		 'ArrayReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12771 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_270
		 'ArrayReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12782 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceVariable_271
		 'ArrayReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 1,
sub {
#line 311 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 0,
sub {
#line 311 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12807 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_274
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12818 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_275
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12829 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 1,
sub {
#line 312 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 0,
sub {
#line 312 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12843 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_278
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12854 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_279
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12865 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_280
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12876 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_281
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12887 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_282
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12898 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_283
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12909 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_284
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12920 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_285
		 'HashReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12931 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_286
		 'HashReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12942 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceVariable_287
		 'HashReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12953 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 1,
sub {
#line 319 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12960 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 0,
sub {
#line 319 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12967 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_290
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12978 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_291
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12989 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_292
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13000 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_293
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13011 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_294
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13022 lib/RPerl/Grammar.pm
	],
	[#Rule Type_295
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13033 lib/RPerl/Grammar.pm
	],
	[#Rule Type_296
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13044 lib/RPerl/Grammar.pm
	],
	[#Rule Type_297
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13055 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_298
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13066 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_299
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13077 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_300
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13088 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_301
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13099 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_302
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13110 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_303
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13121 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_304
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13132 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_305
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13143 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_306
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13154 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_307
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13165 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_308
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13176 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_309
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13187 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_310
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13198 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_311
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13209 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_312
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13220 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_313
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13231 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_314
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13242 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_315
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13253 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_316
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13264 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_317
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13275 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_318
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13286 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_319
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13297 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_320
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13308 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_321
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13319 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_322
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13330 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_323
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13341 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_324
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13352 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_325
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13363 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_326
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13374 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_327
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13385 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_328
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13396 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_329
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13407 lib/RPerl/Grammar.pm
	]
],
#line 13410 lib/RPerl/Grammar.pm
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
         'Operator_130', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_136', 
         'OperatorVoid_137', 
         'OperatorVoid_138', 
         'OperatorVoid_139', 
         'OperatorVoid_140', 
         'OperatorVoid_141', 
         'OperatorVoid_142', 
         'OperatorVoid_143', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_150', 
         'Expression_151', 
         'Expression_152', 
         'Expression_153', 
         'Expression_154', 
         'Expression_155', 
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
         'SubExpression_166', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubExpressions_170', 
         'SubExpressionOrInput_171', 
         'SubExpressionOrInput_172', 
         'SubExpressionOrInput_173', 
         'SubExpressionOrVarMod_174', 
         'SubExpressionOrVarMod_175', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_179', 
         'Statement_180', 
         'Statement_181', 
         'Statement_182', 
         'Statement_183', 
         'Statement_184', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_191', 
         'Loop_192', 
         'Loop_193', 
         'Loop_194', 
         'LoopFor_195', 
         'LoopFor_196', 
         'LoopForEach_197', 
         'LoopWhile_198', 
         'LoopWhile_199', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_202', 
         'Variable_203', 
         'Variable_204', 
         'Variable_205', 
         'Variable_206', 
         'Variable_207', 
         'VariableRetrievalArrow_208', 
         'VariableRetrievalArrow_209', 
         'VariableRetrievalArrow_210', 
         'VariableRetrieval_211', 
         'VariableRetrieval_212', 
         'VariableRetrieval_213', 
         'VariableRetrieval_214', 
         'VariableDeclaration_215', 
         'VariableDeclaration_216', 
         'VariableDeclaration_217', 
         'VariableDeclaration_218', 
         'VariableDeclaration_219', 
         'VariableDeclaration_220', 
         'VariableDeclaration_221', 
         'VariableDeclaration_222', 
         'VariableModification_223', 
         'VariableModification_224', 
         'Scalar_225', 
         'Scalar_226', 
         'ScalarLiteral_227', 
         'ScalarLiteral_228', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ScalarVariable_231', 
         'ScalarVariable_232', 
         'ScalarVariable_233', 
         'ScalarVariableOrSelf_234', 
         'ScalarVariableOrSelf_235', 
         'ArrayHashLiteral_236', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayHashLiteralEs_240', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayLiteralEs_244', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashLiteralEs_248', 
         'ArrayLiteralE_249', 
         'ArrayLiteralE_250', 
         'HashLiteralE_251', 
         'HashLiteralE_252', 
         'ArrayHashLiteralE_253', 
         'ArrayHashLiteralE_254', 
         'ArrayHashLiteralE_255', 
         'ArrayHashLiteralEmpty_256', 
         'ArrayRefLiteralEmpty_257', 
         'HashRefLiteralEmpty_258', 
         'ListElement_259', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Array_263', 
         'Array_264', 
         'ArrayVariable_265', 
         'ArrayVariable_266', 
         'ArrayReference_267', 
         'ArrayReference_268', 
         'ArrayReferenceLiteral_269', 
         'ArrayReferenceLiteral_270', 
         'ArrayReferenceVariable_271', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_274', 
         'ArrayDereference_275', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_278', 
         'HashEntryProperties_279', 
         'Hash_280', 
         'HashVariable_281', 
         'HashVariable_282', 
         'HashReference_283', 
         'HashReference_284', 
         'HashReferenceLiteral_285', 
         'HashReferenceLiteral_286', 
         'HashReferenceVariable_287', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_290', 
         'HashDereference_291', 
         'WordScoped_292', 
         'WordScoped_293', 
         'LoopLabel_294', 
         'Type_295', 
         'Type_296', 
         'Type_297', 
         'TypeInner_298', 
         'TypeInnerProperties_299', 
         'TypeInnerProperties_300', 
         'TypeInnerConstant_301', 
         'ScalarVariableOrLiteral_302', 
         'ScalarVariableOrLiteral_303', 
         'ScaVarOrLitOrOpStrOrWord_304', 
         'ScaVarOrLitOrOpStrOrWord_305', 
         'ScaVarOrLitOrOpStrOrWord_306', 
         'OpNamedScolonOrSubExp_307', 
         'OpNamedScolonOrSubExp_308', 
         'OpNamedScolonOrSubExp_309', 
         'OpNamedScolonOrSubExpIn_310', 
         'OpNamedScolonOrSubExpIn_311', 
         'OpNamedScolonOrSubExpIn_312', 
         'OpStringOrWord_313', 
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
         'OpStringOrWord_329', );
  $self;
}

#line 338 "lib/RPerl/Grammar.eyp"


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


#line 13956 lib/RPerl/Grammar.pm



1;
