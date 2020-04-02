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
    our $VERSION = 0.022_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|\$RETURN_TYPE|use\ strict\;|\$TYPED_|foreach|package|while|\@ARG\;|undef|elsif|INIT|else|for|if|\@\{|\%\{|\}|\;|\)|\])}gc and return ($1, $1);

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
			"## no critic qw(" => 4,
			'USE_RPERL' => -20,
			"package" => -20,
			'SHEBANG' => 1
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 3,
			'Program' => 2,
			'CompileUnit' => 7,
			'Critic' => 9,
			'PAREN-1' => 8,
			'PLUS-2' => 6
		}
	},
	{#State 1
		ACTIONS => {
			"## no critic qw(" => 4,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 10
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => 13,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 12
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 15
		},
		GOTOS => {
			'PLUS-17' => 14
		}
	},
	{#State 5
		ACTIONS => {
			'SUB' => -27,
			"## no critic qw(" => -27,
			"INIT" => -27,
			"use parent qw(" => 20,
			"use constant" => -27,
			'USE_EXPORTER' => -27,
			'USE' => -27,
			"use parent -norequire, qw(" => 21
		},
		GOTOS => {
			'UseParent' => 18,
			'Class' => 16,
			'Module' => 17,
			'STAR-11' => 22,
			'Package' => 19
		}
	},
	{#State 6
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 4,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'ModuleHeader' => 5,
			'Critic' => 9,
			'PAREN-1' => 23
		}
	},
	{#State 7
		ACTIONS => {
			'' => 24
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			"package" => 26
		}
	},
	{#State 13
		DEFAULT => -21
	},
	{#State 14
		ACTIONS => {
			")" => 28,
			'WORD' => 27
		}
	},
	{#State 15
		DEFAULT => -41
	},
	{#State 16
		DEFAULT => -25
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		DEFAULT => -77
	},
	{#State 21
		DEFAULT => -78
	},
	{#State 22
		ACTIONS => {
			'USE' => -29,
			"use constant" => -29,
			'USE_EXPORTER' => 32,
			"INIT" => -29,
			"## no critic qw(" => 4,
			'SUB' => -29
		},
		GOTOS => {
			'Critic' => 34,
			'OPTIONAL-12' => 33,
			'Exports' => 35
		}
	},
	{#State 23
		DEFAULT => -2
	},
	{#State 24
		DEFAULT => 0
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 26
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 27
		DEFAULT => -40
	},
	{#State 28
		DEFAULT => -42
	},
	{#State 29
		ACTIONS => {
			")" => 39
		}
	},
	{#State 30
		DEFAULT => -292
	},
	{#State 31
		DEFAULT => -293
	},
	{#State 32
		ACTIONS => {
			'OUR_EXPORT' => 41,
			"use constant" => -45,
			"INIT" => -45,
			'USE' => -45,
			'SUB' => -45,
			'OUR_EXPORT_OK' => -45,
			"our hashref \$properties" => -45
		},
		GOTOS => {
			'PAREN-18' => 40,
			'OPTIONAL-19' => 42
		}
	},
	{#State 33
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 43
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		DEFAULT => -28
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
		DEFAULT => -44
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 48
		}
	},
	{#State 42
		ACTIONS => {
			"INIT" => -48,
			"use constant" => -48,
			'USE' => -48,
			'SUB' => -48,
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 51
		},
		GOTOS => {
			'PAREN-20' => 49,
			'OPTIONAL-21' => 50
		}
	},
	{#State 43
		ACTIONS => {
			'USE' => 54,
			"INIT" => 55,
			"use constant" => -33,
			'SUB' => -33
		},
		GOTOS => {
			'STAR-14' => 53,
			'Include' => 52
		}
	},
	{#State 44
		ACTIONS => {
			'OP01_NAMED_VOID' => -11,
			'WORD_SCOPED' => -11,
			'HASH_SYMBOL' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"if" => -11,
			'USE' => -11,
			'ARRAY_REF_SYMBOL' => -11,
			'OP01_QW' => -11,
			"%{" => -11,
			'WORD_UPPERCASE' => -11,
			'HASH_REF_SYMBOL' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			"use constant" => -11,
			"for" => -11,
			'WORD' => -11,
			'POD' => -11,
			'SUB' => -11,
			"undef" => -11,
			'ARGV' => -11,
			'SELF' => -11,
			'ARRAY_SYMBOL' => -11,
			'LPAREN_TYPE_INNER' => -11,
			'OP01_PRINT' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'MY' => -11,
			"while" => -11,
			'LPAREN' => -11,
			'OP01_OPEN' => -11,
			'SCALAR_SYMBOL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED' => -11,
			"## no critic qw(" => 4,
			"\@{" => -11,
			'ENV' => -11,
			'LBRACE' => -11,
			'OP10_NAMED_UNARY' => -11,
			"INIT" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LBRACKET' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"foreach" => -11
		},
		GOTOS => {
			'Critic' => 56,
			'STAR-5' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'OUR' => -38,
			'USE_RPERL_AFTER' => 58
		},
		GOTOS => {
			'OPTIONAL-16' => 59
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
			'USE' => 54,
			"INIT" => 55
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 48
		ACTIONS => {
			";" => 62
		}
	},
	{#State 49
		DEFAULT => -47
	},
	{#State 50
		DEFAULT => -49
	},
	{#State 51
		ACTIONS => {
			'OP01_QW' => 63
		}
	},
	{#State 52
		DEFAULT => -30
	},
	{#State 53
		ACTIONS => {
			"use constant" => 67,
			'SUB' => 64
		},
		GOTOS => {
			'PLUS-15' => 65,
			'Subroutine' => 66,
			'Constant' => 68
		}
	},
	{#State 54
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 69
		}
	},
	{#State 55
		ACTIONS => {
			'LBRACE' => 70
		}
	},
	{#State 56
		DEFAULT => -8
	},
	{#State 57
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -13,
			"foreach" => -13,
			'LITERAL_STRING' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_CLOSE' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			"INIT" => 55,
			'OP05_LOGICAL_NEG' => -13,
			'LBRACE' => -13,
			'OP10_NAMED_UNARY' => -13,
			"\@{" => -13,
			'ENV' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED' => -13,
			'OP01_OPEN' => -13,
			'LPAREN' => -13,
			'SCALAR_SYMBOL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'MY' => -13,
			"while" => -13,
			"undef" => -13,
			'ARGV' => -13,
			'SELF' => -13,
			'LPAREN_TYPE_INNER' => -13,
			'ARRAY_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'SUB' => -13,
			"for" => -13,
			"use constant" => -13,
			'POD' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			"%{" => -13,
			'WORD_UPPERCASE' => -13,
			'HASH_REF_SYMBOL' => -13,
			'ARRAY_REF_SYMBOL' => -13,
			'OP01_QW' => -13,
			'WORD_SCOPED' => -13,
			'OP01_NAMED_VOID' => -13,
			'HASH_SYMBOL' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"if" => -13,
			'USE' => 54
		},
		GOTOS => {
			'STAR-6' => 72,
			'Include' => 71
		}
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
		DEFAULT => -23
	},
	{#State 61
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 62
		DEFAULT => -43
	},
	{#State 63
		ACTIONS => {
			";" => 75
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 76
		}
	},
	{#State 65
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'SUB' => 64
		},
		GOTOS => {
			'Subroutine' => 78
		}
	},
	{#State 66
		DEFAULT => -35
	},
	{#State 67
		ACTIONS => {
			'WORD_UPPERCASE' => 79
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			'OP01_QW' => 81,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 80
		}
	},
	{#State 70
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 82
		}
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'SUB' => -15,
			'WORD' => -15,
			'POD' => -15,
			"for" => -15,
			"use constant" => 67,
			'MY' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"while" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LPAREN_TYPE_INNER' => -15,
			'ARRAY_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			'ARGV' => -15,
			"undef" => -15,
			'SELF' => -15,
			'OP01_QW' => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'HASH_SYMBOL' => -15,
			"if" => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'HASH_REF_SYMBOL' => -15,
			"%{" => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LBRACKET' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LPAREN' => -15,
			'OP01_OPEN' => -15,
			'SCALAR_SYMBOL' => -15,
			'LBRACE' => -15,
			'OP10_NAMED_UNARY' => -15,
			'ENV' => -15,
			"\@{" => -15
		},
		GOTOS => {
			'STAR-7' => 84,
			'Constant' => 83
		}
	},
	{#State 73
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 85
		}
	},
	{#State 74
		ACTIONS => {
			"## no critic qw(" => 4,
			"our hashref \$properties" => -69,
			"INIT" => -69,
			"use constant" => -69,
			'USE_EXPORTER' => 32,
			'USE' => -69
		},
		GOTOS => {
			'OPTIONAL-29' => 86,
			'Exports' => 87,
			'Critic' => 88
		}
	},
	{#State 75
		DEFAULT => -46
	},
	{#State 76
		ACTIONS => {
			'LBRACE' => 89
		}
	},
	{#State 77
		ACTIONS => {
			";" => 90
		}
	},
	{#State 78
		DEFAULT => -34
	},
	{#State 79
		ACTIONS => {
			'OP20_HASH_FATARROW' => 91
		}
	},
	{#State 80
		ACTIONS => {
			";" => 92
		}
	},
	{#State 81
		DEFAULT => -50
	},
	{#State 82
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 93
		}
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		ACTIONS => {
			'WORD_UPPERCASE' => 133,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP01_NAMED_SCOLON' => 128,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_VOID' => 138,
			"if" => 101,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'OP01_PRINT' => 143,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			"while" => -178,
			'MY' => 139,
			'CONSTANT_CALL_SCOPED' => 140,
			"for" => -178,
			'POD' => 107,
			'WORD' => 30,
			'SUB' => 64,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED_VOID_SCOLON' => 158,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED' => 157,
			'OP19_LOOP_CONTROL' => 113,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			"foreach" => -178,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167
		},
		GOTOS => {
			'ArrayVariable' => 130,
			'Operator' => 129,
			'Statement' => 127,
			'LoopLabel' => 97,
			'PAREN-47' => 131,
			'ArrayRefLiteralEmpty' => 99,
			'ArrayHashLiteral' => 102,
			'VariableModification' => 137,
			'Array' => 136,
			'ArrayHashLiteralEmpty' => 104,
			'PLUS-8' => 144,
			'ArrayDereference' => 105,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'Variable' => 109,
			'Conditional' => 108,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'Scalar' => 156,
			'OperatorVoid' => 154,
			'HashReferenceVariable' => 153,
			'Expression' => 115,
			'VariableDeclaration' => 114,
			'HashReference' => 112,
			'OPTIONAL-48' => 116,
			'HashDereference' => 159,
			'ArrayReferenceVariable' => 165,
			'ScalarVariable' => 123,
			'SubExpression' => 164,
			'HashVariable' => 122,
			'ScalarLiteral' => 163,
			'Operation' => 161,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'Subroutine' => 170
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 171
		}
	},
	{#State 87
		DEFAULT => -68
	},
	{#State 88
		DEFAULT => -66
	},
	{#State 89
		ACTIONS => {
			'LBRACE' => 172
		}
	},
	{#State 90
		DEFAULT => -36
	},
	{#State 91
		ACTIONS => {
			'MY' => 174
		},
		GOTOS => {
			'TypeInnerConstant' => 173
		}
	},
	{#State 92
		DEFAULT => -54
	},
	{#State 93
		ACTIONS => {
			")" => -53,
			'OP01_QW' => 176
		},
		GOTOS => {
			'OPTIONAL-23' => 175
		}
	},
	{#State 94
		DEFAULT => -227
	},
	{#State 95
		ACTIONS => {
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'WORD' => 30,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'SubExpression' => 181,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150
		}
	},
	{#State 96
		DEFAULT => -287
	},
	{#State 97
		ACTIONS => {
			'COLON' => 186
		}
	},
	{#State 98
		DEFAULT => -100
	},
	{#State 99
		DEFAULT => -270
	},
	{#State 100
		DEFAULT => -97
	},
	{#State 101
		ACTIONS => {
			'LPAREN' => 187
		}
	},
	{#State 102
		DEFAULT => -160
	},
	{#State 103
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP10_NAMED_UNARY' => 188,
			'OP07_STRING_REPEAT' => 197,
			'OP12_COMPARE_EQ_NE' => 198,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 200,
			'OP23_LOGICAL_AND' => 190,
			'OP01_NAMED_VOID' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP01_OPEN' => 191,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP22_LOGICAL_NEG' => 201,
			'OP01_PRINT' => 204,
			'OP01_CLOSE' => 195,
			'OP11_COMPARE_LT_GT' => 196,
			'OP08_MATH_ADD_SUB' => 199,
			'WORD' => 205
		},
		GOTOS => {
			'OpStringOrWord' => 194
		}
	},
	{#State 104
		DEFAULT => -159
	},
	{#State 105
		DEFAULT => -163
	},
	{#State 106
		DEFAULT => -286
	},
	{#State 107
		DEFAULT => -184
	},
	{#State 108
		DEFAULT => -179
	},
	{#State 109
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 206,
			'OP19_VARIABLE_ASSIGN' => 207
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_UPPERCASE' => 185,
			")" => -118,
			'OP16_LOGICAL_OR' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			";" => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP07_STRING_REPEAT' => -118,
			'OP06_REGEX_BIND' => -118,
			'WORD' => 30,
			'OP08_MATH_ADD_SUB' => -118,
			'SELF' => 147,
			"undef" => 146,
			'OP13_BITWISE_AND' => -118,
			'ARGV' => 145,
			'OP09_BITWISE_SHIFT' => -118,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'OP17_LIST_RANGE' => -118,
			'CONSTANT_CALL_SCOPED' => 140,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			"}" => -118,
			'OP01_NAMED' => 183,
			'OP23_LOGICAL_AND' => -118,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'OP08_STRING_CAT' => -118,
			'LBRACE' => 152,
			"]" => -118,
			'OP05_LOGICAL_NEG' => 169,
			'OP11_COMPARE_LT_GT' => -118,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP18_TERNARY' => -118,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP21_LIST_COMMA' => -118,
			'OP22_LOGICAL_NEG' => 160,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP04_MATH_POW' => -118
		},
		GOTOS => {
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 208,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112
		}
	},
	{#State 111
		ACTIONS => {
			'LBRACKET' => -273,
			'ARRAY_REF_SYMBOL' => -273,
			'MY' => 212,
			'SCALAR_SYMBOL' => 119,
			'SELF' => 147
		},
		GOTOS => {
			'TypeInner' => 209,
			'ScalarVariableOrSelf' => 126,
			'ScalarVariable' => 210,
			'OPTIONAL-63' => 211
		}
	},
	{#State 112
		DEFAULT => -165
	},
	{#State 113
		ACTIONS => {
			'WORD_UPPERCASE' => 213
		},
		GOTOS => {
			'LoopLabel' => 214
		}
	},
	{#State 114
		DEFAULT => -182
	},
	{#State 115
		ACTIONS => {
			'OP23_LOGICAL_AND' => -156,
			'OP07_MATH_MULT_DIV_MOD' => -156,
			'OP24_LOGICAL_OR_XOR' => -156,
			'OP08_STRING_CAT' => -156,
			";" => 215,
			'OP15_LOGICAL_AND' => -156,
			'OP07_STRING_REPEAT' => -156,
			'OP12_COMPARE_EQ_NE' => -156,
			'OP16_LOGICAL_OR' => -156,
			'OP06_REGEX_BIND' => -156,
			'OP11_COMPARE_LT_GT' => -156,
			'OP08_MATH_ADD_SUB' => -156,
			'OP17_LIST_RANGE' => -156,
			'OP14_BITWISE_OR_XOR' => -156,
			'OP04_MATH_POW' => -156,
			'OP13_BITWISE_AND' => -156,
			'OP18_TERNARY' => -156,
			'OP09_BITWISE_SHIFT' => -156
		}
	},
	{#State 116
		ACTIONS => {
			"foreach" => 222,
			"while" => 221,
			"for" => 216
		},
		GOTOS => {
			'Loop' => 218,
			'LoopWhile' => 217,
			'LoopForEach' => 220,
			'LoopFor' => 219
		}
	},
	{#State 117
		DEFAULT => -142
	},
	{#State 118
		ACTIONS => {
			'MY' => 223
		}
	},
	{#State 119
		DEFAULT => -234
	},
	{#State 120
		ACTIONS => {
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 238,
			'LBRACE' => 152,
			'OP01_OPEN' => 237,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP01_NAMED' => 228,
			'OP19_LOOP_CONTROL' => 189,
			'OP23_LOGICAL_AND' => 190,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 233,
			'OP05_LOGICAL_NEG' => 169,
			'OP11_COMPARE_LT_GT' => 196,
			'OP01_CLOSE' => 239,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'WORD_UPPERCASE' => 185,
			")" => 224,
			'OP12_COMPARE_EQ_NE' => 198,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP07_STRING_REPEAT' => 197,
			'OP01_NAMED_VOID' => 203,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'OP01_PRINT' => 226,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'MY' => 212,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 225,
			'OP08_MATH_ADD_SUB' => 199
		},
		GOTOS => {
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashEntry' => 230,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'TypeInner' => 236,
			'Expression' => 179,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'ArrayRefLiteralEmpty' => 99,
			'ArrayHashLiteralE' => 229,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'SubExpression' => 235,
			'HashVariable' => 178,
			'ScalarLiteral' => 234,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 241,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayHashLiteralEs' => 232,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ListElement' => 231,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'OpStringOrWord' => 240
		}
	},
	{#State 121
		DEFAULT => -228
	},
	{#State 122
		ACTIONS => {
			'OP07_STRING_REPEAT' => -280,
			'OP24_LOGICAL_OR_XOR' => -280,
			'OP15_LOGICAL_AND' => -280,
			'OP08_STRING_CAT' => -280,
			'OP12_COMPARE_EQ_NE' => -280,
			'OP19_VARIABLE_ASSIGN' => -206,
			")" => -280,
			'OP16_LOGICAL_OR' => -280,
			'OP23_LOGICAL_AND' => -280,
			'OP07_MATH_MULT_DIV_MOD' => -280,
			'OP04_MATH_POW' => -280,
			'OP14_BITWISE_OR_XOR' => -280,
			'OP17_LIST_RANGE' => -280,
			'OP09_BITWISE_SHIFT' => -280,
			'OP18_TERNARY' => -280,
			'OP13_BITWISE_AND' => -280,
			'OP08_MATH_ADD_SUB' => -280,
			'OP11_COMPARE_LT_GT' => -280,
			'OP06_REGEX_BIND' => -280,
			'OP19_VARIABLE_ASSIGN_BY' => -206
		}
	},
	{#State 123
		ACTIONS => {
			'OP23_LOGICAL_AND' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP08_STRING_CAT' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			")" => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP19_VARIABLE_ASSIGN' => -203,
			'OP06_REGEX_BIND' => -226,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP08_MATH_ADD_SUB' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP04_MATH_POW' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP18_TERNARY' => -226,
			'OP02_METHOD_THINARROW' => 242,
			'OP09_BITWISE_SHIFT' => -226,
			'OP03_MATH_INC_DEC' => 243
		}
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			"]" => 246,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD' => 30,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 212,
			'OP05_MATH_NEG_LPAREN' => 141
		},
		GOTOS => {
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'SubExpression' => 245,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159,
			'ArrayLiteralE' => 247,
			'ArrayReferenceLiteral' => 149,
			'ArrayLiteralEs' => 248,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ListElement' => 244,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'TypeInner' => 236,
			'Expression' => 179
		}
	},
	{#State 125
		ACTIONS => {
			'FHREF_SYMBOL' => 249
		}
	},
	{#State 126
		ACTIONS => {
			'OP23_LOGICAL_AND' => -231,
			'COLON' => -231,
			'OP07_MATH_MULT_DIV_MOD' => -231,
			"}" => -231,
			'OP15_LOGICAL_AND' => -231,
			";" => -231,
			'OP24_LOGICAL_OR_XOR' => -231,
			'OP08_STRING_CAT' => -231,
			'OP20_HASH_FATARROW' => -231,
			"]" => -231,
			'OP07_STRING_REPEAT' => -231,
			'OP02_HASH_THINARROW' => 251,
			")" => -231,
			'OP16_LOGICAL_OR' => -231,
			'OP19_VARIABLE_ASSIGN' => -231,
			'OP12_COMPARE_EQ_NE' => -231,
			'OP19_VARIABLE_ASSIGN_BY' => -231,
			'OP06_REGEX_BIND' => -231,
			'OP08_MATH_ADD_SUB' => -231,
			'OP11_COMPARE_LT_GT' => -231,
			'OP02_ARRAY_THINARROW' => 252,
			'OP14_BITWISE_OR_XOR' => -231,
			'OP17_LIST_RANGE' => -231,
			'OP04_MATH_POW' => -231,
			'OP02_METHOD_THINARROW' => -231,
			'OP18_TERNARY' => -231,
			'OP13_BITWISE_AND' => -231,
			'OP03_MATH_INC_DEC' => -231,
			'OP21_LIST_COMMA' => -231,
			'OP09_BITWISE_SHIFT' => -231
		},
		GOTOS => {
			'VariableRetrievalArrow' => 250
		}
	},
	{#State 127
		DEFAULT => -98
	},
	{#State 128
		DEFAULT => -96
	},
	{#State 129
		DEFAULT => -150
	},
	{#State 130
		ACTIONS => {
			'OP23_LOGICAL_AND' => -264,
			'OP07_MATH_MULT_DIV_MOD' => -264,
			'OP07_STRING_REPEAT' => -264,
			'OP24_LOGICAL_OR_XOR' => -264,
			'OP08_STRING_CAT' => -264,
			'OP15_LOGICAL_AND' => -264,
			'OP12_COMPARE_EQ_NE' => -264,
			'OP19_VARIABLE_ASSIGN' => -204,
			")" => -264,
			'OP16_LOGICAL_OR' => -264,
			'OP11_COMPARE_LT_GT' => -264,
			'OP08_MATH_ADD_SUB' => -264,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP06_REGEX_BIND' => -264,
			'OP04_MATH_POW' => -264,
			'OP14_BITWISE_OR_XOR' => -264,
			'OP17_LIST_RANGE' => -264,
			'OP09_BITWISE_SHIFT' => -264,
			'OP13_BITWISE_AND' => -264,
			'OP18_TERNARY' => -264
		}
	},
	{#State 131
		DEFAULT => -177
	},
	{#State 132
		ACTIONS => {
			'HASH_REF_SYMBOL' => -289,
			'SCALAR_SYMBOL' => 119,
			'SELF' => 147,
			'MY' => 212,
			'LBRACE' => -289
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 126,
			'OPTIONAL-65' => 255,
			'TypeInner' => 253,
			'ScalarVariable' => 254
		}
	},
	{#State 133
		ACTIONS => {
			'LPAREN' => 256,
			'COLON' => -294
		}
	},
	{#State 134
		DEFAULT => -271
	},
	{#State 135
		DEFAULT => -281
	},
	{#State 136
		DEFAULT => -161
	},
	{#State 137
		ACTIONS => {
			";" => 257
		}
	},
	{#State 138
		ACTIONS => {
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'SubExpression' => 259,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'Expression' => 179,
			'SubExpressions' => 258,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => 264,
			'WORD_SCOPED' => 262,
			'TYPE_INTEGER' => 260,
			'TYPE_FHREF' => 261
		},
		GOTOS => {
			'Type' => 263
		}
	},
	{#State 140
		DEFAULT => -152
	},
	{#State 141
		ACTIONS => {
			'WORD' => 30,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152
		},
		GOTOS => {
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarLiteral' => 163,
			'SubExpression' => 265,
			'HashVariable' => 178,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156
		}
	},
	{#State 142
		DEFAULT => -265
	},
	{#State 143
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -133,
			'CONSTANT_CALL_SCOPED' => -133,
			'SELF' => -133,
			'ARGV' => -133,
			"undef" => -133,
			'FHREF_SYMBOL_BRACES' => 266,
			'ARRAY_SYMBOL' => -133,
			'LPAREN_TYPE_INNER' => -133,
			'WORD' => -133,
			'OP22_LOGICAL_NEG_LPAREN' => -133,
			'LITERAL_NUMBER' => -133,
			'STDOUT_STDERR' => 269,
			'WORD_UPPERCASE' => -133,
			"%{" => -133,
			'HASH_REF_SYMBOL' => -133,
			'ARRAY_REF_SYMBOL' => -133,
			'OP01_QW' => -133,
			'WORD_SCOPED' => -133,
			'HASH_SYMBOL' => -133,
			'OP22_LOGICAL_NEG' => -133,
			'OP03_MATH_INC_DEC' => -133,
			'LITERAL_STRING' => -133,
			'OP01_CLOSE' => -133,
			'LBRACKET' => -133,
			'OP05_BITWISE_NEG_LPAREN' => -133,
			'OP05_LOGICAL_NEG' => -133,
			'OP10_NAMED_UNARY' => -133,
			'LBRACE' => -133,
			"\@{" => -133,
			'ENV' => -133,
			'OP01_NAMED' => -133,
			'LPAREN' => -133,
			'SCALAR_SYMBOL' => -133,
			'OP01_OPEN' => -133
		},
		GOTOS => {
			'OPTIONAL-40' => 267,
			'PAREN-39' => 268
		}
	},
	{#State 144
		ACTIONS => {
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 158,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			"foreach" => -178,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			"%{" => 132,
			'WORD_UPPERCASE' => 133,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP01_NAMED_SCOLON' => 128,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_VOID' => 138,
			'WORD_SCOPED' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			'HASH_SYMBOL' => 135,
			"if" => 101,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_PRINT' => 143,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 139,
			"while" => -178,
			"for" => -178,
			'' => -18,
			'WORD' => 30,
			'POD' => 107
		},
		GOTOS => {
			'Array' => 136,
			'VariableModification' => 137,
			'ArrayHashLiteral' => 102,
			'ArrayRefLiteralEmpty' => 99,
			'LoopLabel' => 97,
			'PAREN-47' => 131,
			'Statement' => 127,
			'Operator' => 129,
			'ArrayVariable' => 130,
			'ArrayReferenceLiteral' => 149,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'OPTIONAL-48' => 116,
			'HashReference' => 112,
			'VariableDeclaration' => 114,
			'Expression' => 115,
			'HashReferenceVariable' => 153,
			'Scalar' => 156,
			'OperatorVoid' => 154,
			'Hash' => 150,
			'Conditional' => 108,
			'HashReferenceLiteral' => 151,
			'Variable' => 109,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'Operation' => 270,
			'SubExpression' => 164,
			'HashVariable' => 122,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 123,
			'ArrayReferenceVariable' => 165,
			'HashDereference' => 159
		}
	},
	{#State 145
		DEFAULT => -266
	},
	{#State 146
		DEFAULT => -157
	},
	{#State 147
		DEFAULT => -235
	},
	{#State 148
		DEFAULT => -162
	},
	{#State 149
		DEFAULT => -267
	},
	{#State 150
		DEFAULT => -164
	},
	{#State 151
		DEFAULT => -283
	},
	{#State 152
		ACTIONS => {
			'OP07_STRING_REPEAT' => 197,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP24_LOGICAL_OR_XOR' => 202,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'OP12_COMPARE_EQ_NE' => 198,
			'WORD_UPPERCASE' => 185,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_VOID' => 203,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP01_PRINT' => 204,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'OP08_MATH_ADD_SUB' => 199,
			'WORD' => 225,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 238,
			'ENV' => 155,
			"\@{" => 111,
			'OP23_LOGICAL_AND' => 190,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 274,
			"}" => 272,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'LPAREN' => 120,
			'OP01_OPEN' => 237,
			'SCALAR_SYMBOL' => 119,
			'OP22_LOGICAL_NEG' => 233,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 239,
			'LBRACKET' => 124,
			'OP11_COMPARE_LT_GT' => 196,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'HashEntry' => 275,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'HashLiteralE' => 276,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'SubExpression' => 273,
			'ScalarLiteral' => 234,
			'HashVariable' => 178,
			'ScalarVariable' => 241,
			'ArrayReferenceVariable' => 180,
			'HashLiteralEs' => 271,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'OpStringOrWord' => 240,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 153
		ACTIONS => {
			'OP17_LIST_RANGE' => -284,
			'OP14_BITWISE_OR_XOR' => -284,
			'OP04_MATH_POW' => -284,
			'OP18_TERNARY' => -284,
			'OP13_BITWISE_AND' => -284,
			'OP09_BITWISE_SHIFT' => -284,
			'OP19_VARIABLE_ASSIGN_BY' => -207,
			'OP06_REGEX_BIND' => -284,
			'OP11_COMPARE_LT_GT' => -284,
			'OP08_MATH_ADD_SUB' => -284,
			'OP08_STRING_CAT' => -284,
			'OP24_LOGICAL_OR_XOR' => -284,
			'OP15_LOGICAL_AND' => -284,
			'OP07_STRING_REPEAT' => -284,
			'OP16_LOGICAL_OR' => -284,
			")" => -284,
			'OP19_VARIABLE_ASSIGN' => -207,
			'OP12_COMPARE_EQ_NE' => -284,
			'OP23_LOGICAL_AND' => -284,
			'OP07_MATH_MULT_DIV_MOD' => -284
		}
	},
	{#State 154
		DEFAULT => -181
	},
	{#State 155
		DEFAULT => -282
	},
	{#State 156
		DEFAULT => -158
	},
	{#State 157
		ACTIONS => {
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'SubExpression' => 277,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashDereference' => 159,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184
		}
	},
	{#State 158
		DEFAULT => -138
	},
	{#State 159
		DEFAULT => -166
	},
	{#State 160
		ACTIONS => {
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'WORD' => 30,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125
		},
		GOTOS => {
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'SubExpression' => 278,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159
		}
	},
	{#State 161
		DEFAULT => -17
	},
	{#State 162
		ACTIONS => {
			'SELF' => 147,
			'SCALAR_SYMBOL' => 119
		},
		GOTOS => {
			'ScalarVariable' => 279,
			'ScalarVariableOrSelf' => 126
		}
	},
	{#State 163
		DEFAULT => -225
	},
	{#State 164
		ACTIONS => {
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP07_STRING_REPEAT' => 291,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP09_BITWISE_SHIFT' => 286
		}
	},
	{#State 165
		ACTIONS => {
			'OP06_REGEX_BIND' => -268,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP11_COMPARE_LT_GT' => -268,
			'OP08_MATH_ADD_SUB' => -268,
			'OP17_LIST_RANGE' => -268,
			'OP14_BITWISE_OR_XOR' => -268,
			'OP04_MATH_POW' => -268,
			'OP18_TERNARY' => -268,
			'OP13_BITWISE_AND' => -268,
			'OP09_BITWISE_SHIFT' => -268,
			'OP23_LOGICAL_AND' => -268,
			'OP07_MATH_MULT_DIV_MOD' => -268,
			'OP24_LOGICAL_OR_XOR' => -268,
			'OP15_LOGICAL_AND' => -268,
			'OP08_STRING_CAT' => -268,
			'OP07_STRING_REPEAT' => -268,
			'OP12_COMPARE_EQ_NE' => -268,
			")" => -268,
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP16_LOGICAL_OR' => -268
		}
	},
	{#State 166
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 297,
			'LPAREN' => 298
		}
	},
	{#State 167
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'WORD' => 30,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'SubExpression' => 299,
			'ScalarLiteral' => 163,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 168
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 30,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			"%{" => 132,
			")" => -135,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 259,
			'HashDereference' => 159,
			'OPTIONAL-41' => 300,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'SubExpressions' => 301,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184
		}
	},
	{#State 169
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111,
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132
		},
		GOTOS => {
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'HashDereference' => 159,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 302,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 170
		DEFAULT => -14
	},
	{#State 171
		ACTIONS => {
			"our hashref \$properties" => -73,
			"INIT" => 55,
			"use constant" => -73,
			'USE' => 54
		},
		GOTOS => {
			'STAR-31' => 304,
			'Include' => 303
		}
	},
	{#State 172
		ACTIONS => {
			'MY' => 305
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'ScalarLiteral' => 306
		}
	},
	{#State 174
		ACTIONS => {
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262,
			'WORD' => 264
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 175
		ACTIONS => {
			")" => 308
		}
	},
	{#State 176
		DEFAULT => -52
	},
	{#State 177
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -226,
			'OP08_MATH_ADD_SUB' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP03_MATH_INC_DEC' => 243,
			'OP21_LIST_COMMA' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP18_TERNARY' => -226,
			'OP02_METHOD_THINARROW' => 242,
			'OP04_MATH_POW' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			"}" => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP16_LOGICAL_OR' => -226,
			")" => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			"]" => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP15_LOGICAL_AND' => -226,
			";" => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP08_STRING_CAT' => -226
		}
	},
	{#State 178
		DEFAULT => -280
	},
	{#State 179
		DEFAULT => -156
	},
	{#State 180
		DEFAULT => -268
	},
	{#State 181
		ACTIONS => {
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_STRING_REPEAT' => 291,
			")" => 309,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286
		}
	},
	{#State 182
		DEFAULT => -284
	},
	{#State 183
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'WORD' => 30
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'SubExpression' => 310,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 184
		DEFAULT => -264
	},
	{#State 185
		ACTIONS => {
			'LPAREN' => 256
		}
	},
	{#State 186
		DEFAULT => -176
	},
	{#State 187
		ACTIONS => {
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'SubExpression' => 311,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105
		}
	},
	{#State 188
		DEFAULT => -320
	},
	{#State 189
		DEFAULT => -317
	},
	{#State 190
		DEFAULT => -314
	},
	{#State 191
		DEFAULT => -326
	},
	{#State 192
		DEFAULT => -322
	},
	{#State 193
		DEFAULT => -316
	},
	{#State 194
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 195
		DEFAULT => -325
	},
	{#State 196
		DEFAULT => -319
	},
	{#State 197
		DEFAULT => -323
	},
	{#State 198
		DEFAULT => -318
	},
	{#State 199
		DEFAULT => -321
	},
	{#State 200
		DEFAULT => -324
	},
	{#State 201
		DEFAULT => -315
	},
	{#State 202
		DEFAULT => -313
	},
	{#State 203
		DEFAULT => -327
	},
	{#State 204
		DEFAULT => -328
	},
	{#State 205
		DEFAULT => -329
	},
	{#State 206
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98
		},
		GOTOS => {
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 313,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104
		}
	},
	{#State 207
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 315,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'STDIN' => 317,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'SubExpressionOrInput' => 314,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'SubExpression' => 316,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 208
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -117,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => -117,
			'OP18_TERNARY' => -117,
			'OP23_LOGICAL_AND' => -117,
			"}" => -117,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"]" => -117,
			'OP07_STRING_REPEAT' => 291,
			'OP24_LOGICAL_OR_XOR' => -117,
			";" => -117,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP16_LOGICAL_OR' => -117,
			")" => -117
		}
	},
	{#State 209
		DEFAULT => -272
	},
	{#State 210
		ACTIONS => {
			"}" => 318
		}
	},
	{#State 211
		ACTIONS => {
			'LBRACKET' => 124,
			'ARRAY_REF_SYMBOL' => 134
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReferenceVariable' => 180,
			'ArrayRefLiteralEmpty' => 99,
			'ArrayReference' => 319
		}
	},
	{#State 212
		ACTIONS => {
			'WORD' => 264,
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262
		},
		GOTOS => {
			'Type' => 320
		}
	},
	{#State 213
		DEFAULT => -294
	},
	{#State 214
		ACTIONS => {
			";" => 321
		}
	},
	{#State 215
		DEFAULT => -95
	},
	{#State 216
		ACTIONS => {
			'LPAREN_MY' => 323,
			'MY' => 322
		}
	},
	{#State 217
		DEFAULT => -194
	},
	{#State 218
		DEFAULT => -180
	},
	{#State 219
		DEFAULT => -192
	},
	{#State 220
		DEFAULT => -193
	},
	{#State 221
		ACTIONS => {
			'LPAREN' => 324,
			'LPAREN_MY' => 325
		}
	},
	{#State 222
		ACTIONS => {
			'MY' => 326
		}
	},
	{#State 223
		ACTIONS => {
			'TYPE_FHREF' => 327
		}
	},
	{#State 224
		DEFAULT => -256
	},
	{#State 225
		ACTIONS => {
			'LPAREN' => -292,
			'OP02_METHOD_THINARROW_NEW' => -292,
			'OP20_HASH_FATARROW' => -329
		}
	},
	{#State 226
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 328,
			'OP20_HASH_FATARROW' => -328
		}
	},
	{#State 227
		ACTIONS => {
			'OP20_HASH_FATARROW' => 329
		}
	},
	{#State 228
		ACTIONS => {
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP20_HASH_FATARROW' => -324,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 330,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99
		}
	},
	{#State 229
		DEFAULT => -239,
		GOTOS => {
			'STAR-56' => 331
		}
	},
	{#State 230
		DEFAULT => -255
	},
	{#State 231
		DEFAULT => -254
	},
	{#State 232
		ACTIONS => {
			")" => 332
		}
	},
	{#State 233
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'WORD' => 30,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP20_HASH_FATARROW' => -315,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'SubExpression' => 278,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184
		}
	},
	{#State 234
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -225,
			"}" => -225,
			'OP23_LOGICAL_AND' => -225,
			'OP12_COMPARE_EQ_NE' => -225,
			")" => -225,
			'OP16_LOGICAL_OR' => -225,
			'OP15_LOGICAL_AND' => -225,
			'OP24_LOGICAL_OR_XOR' => -225,
			'OP08_STRING_CAT' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP20_HASH_FATARROW' => -305,
			'OP06_REGEX_BIND' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			'OP18_TERNARY' => -225,
			'OP13_BITWISE_AND' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP21_LIST_COMMA' => -225,
			'OP17_LIST_RANGE' => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP04_MATH_POW' => -225
		}
	},
	{#State 235
		ACTIONS => {
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP21_LIST_COMMA' => -253,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP07_STRING_REPEAT' => 291,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			")" => -253,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295
		}
	},
	{#State 236
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'WORD' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118
		},
		GOTOS => {
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 333,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 237
		ACTIONS => {
			'MY' => 223,
			'OP20_HASH_FATARROW' => -326
		}
	},
	{#State 238
		ACTIONS => {
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			"}" => -118,
			'OP01_NAMED' => 183,
			'OP23_LOGICAL_AND' => -118,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP08_STRING_CAT' => -118,
			'LBRACE' => 152,
			'OP11_COMPARE_LT_GT' => -118,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP18_TERNARY' => -118,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP21_LIST_COMMA' => -118,
			'OP22_LOGICAL_NEG' => 160,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP04_MATH_POW' => -118,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'OP16_LOGICAL_OR' => -118,
			")" => -118,
			'WORD_UPPERCASE' => 185,
			'OP12_COMPARE_EQ_NE' => -118,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP20_HASH_FATARROW' => -320,
			'OP07_STRING_REPEAT' => -118,
			'OP06_REGEX_BIND' => -118,
			'WORD' => 30,
			'OP08_MATH_ADD_SUB' => -118,
			'SELF' => 147,
			'OP13_BITWISE_AND' => -118,
			'ARGV' => 145,
			"undef" => 146,
			'LPAREN_TYPE_INNER' => 103,
			'OP09_BITWISE_SHIFT' => -118,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'OP17_LIST_RANGE' => -118,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 208,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105
		}
	},
	{#State 239
		ACTIONS => {
			'OP20_HASH_FATARROW' => -325,
			'FHREF_SYMBOL' => 249
		}
	},
	{#State 240
		DEFAULT => -306
	},
	{#State 241
		ACTIONS => {
			'OP06_REGEX_BIND' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP08_MATH_ADD_SUB' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP18_TERNARY' => -226,
			'OP02_METHOD_THINARROW' => 242,
			'OP21_LIST_COMMA' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP03_MATH_INC_DEC' => 243,
			'OP17_LIST_RANGE' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP04_MATH_POW' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			"}" => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			")" => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP08_STRING_CAT' => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP20_HASH_FATARROW' => -304
		}
	},
	{#State 242
		ACTIONS => {
			'LPAREN' => 334
		}
	},
	{#State 243
		DEFAULT => -106
	},
	{#State 244
		DEFAULT => -250
	},
	{#State 245
		ACTIONS => {
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			"]" => -249,
			'OP07_STRING_REPEAT' => 291,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -249,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293
		}
	},
	{#State 246
		DEFAULT => -257
	},
	{#State 247
		DEFAULT => -243,
		GOTOS => {
			'STAR-58' => 335
		}
	},
	{#State 248
		ACTIONS => {
			"]" => 336
		}
	},
	{#State 249
		DEFAULT => -104
	},
	{#State 250
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -232,
			")" => -232,
			'OP19_VARIABLE_ASSIGN' => -232,
			'OP16_LOGICAL_OR' => -232,
			'OP02_HASH_THINARROW' => 251,
			'OP20_HASH_FATARROW' => -232,
			'OP07_STRING_REPEAT' => -232,
			'OP24_LOGICAL_OR_XOR' => -232,
			";" => -232,
			'OP15_LOGICAL_AND' => -232,
			'OP09_BITWISE_SHIFT' => -232,
			'OP13_BITWISE_AND' => -232,
			'OP17_LIST_RANGE' => -232,
			'OP02_ARRAY_THINARROW' => 252,
			'OP08_MATH_ADD_SUB' => -232,
			'OP19_VARIABLE_ASSIGN_BY' => -232,
			'OP06_REGEX_BIND' => -232,
			"]" => -232,
			'LBRACE' => 339,
			'OP08_STRING_CAT' => -232,
			"}" => -232,
			'OP07_MATH_MULT_DIV_MOD' => -232,
			'COLON' => -232,
			'OP23_LOGICAL_AND' => -232,
			'OP21_LIST_COMMA' => -232,
			'OP03_MATH_INC_DEC' => -232,
			'OP02_METHOD_THINARROW' => -232,
			'OP18_TERNARY' => -232,
			'OP04_MATH_POW' => -232,
			'OP14_BITWISE_OR_XOR' => -232,
			'OP11_COMPARE_LT_GT' => -232,
			'LBRACKET' => 337
		},
		GOTOS => {
			'PLUS-54' => 338,
			'VariableRetrieval' => 341,
			'VariableRetrievalArrow' => 340
		}
	},
	{#State 251
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'WORD' => 343,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 342,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166
		}
	},
	{#State 252
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD' => 30,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'SubExpression' => 344,
			'ScalarLiteral' => 163,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166
		}
	},
	{#State 253
		DEFAULT => -288
	},
	{#State 254
		ACTIONS => {
			"}" => 345
		}
	},
	{#State 255
		ACTIONS => {
			'HASH_REF_SYMBOL' => 96,
			'LBRACE' => 152
		},
		GOTOS => {
			'HashReferenceVariable' => 182,
			'HashReference' => 346,
			'HashReferenceLiteral' => 151,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 256
		ACTIONS => {
			")" => 347
		}
	},
	{#State 257
		DEFAULT => -183
	},
	{#State 258
		ACTIONS => {
			";" => 348
		}
	},
	{#State 259
		ACTIONS => {
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -169,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			";" => -169,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP07_STRING_REPEAT' => 291,
			")" => -169,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295
		},
		GOTOS => {
			'STAR-46' => 349
		}
	},
	{#State 260
		DEFAULT => -297
	},
	{#State 261
		ACTIONS => {
			'FHREF_SYMBOL' => 350
		}
	},
	{#State 262
		DEFAULT => -296
	},
	{#State 263
		ACTIONS => {
			'SCALAR_SYMBOL' => 351,
			'ARRAY_SYMBOL' => 352,
			'HASH_SYMBOL' => 353
		}
	},
	{#State 264
		DEFAULT => -295
	},
	{#State 265
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			")" => 354,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290
		}
	},
	{#State 266
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'WORD' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135
		},
		GOTOS => {
			'Expression' => 179,
			'SubExpressions' => 355,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'HashVariable' => 178,
			'SubExpression' => 259,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104
		}
	},
	{#State 267
		ACTIONS => {
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'SubExpression' => 259,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashDereference' => 159,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'SubExpressions' => 356,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184
		}
	},
	{#State 268
		DEFAULT => -132
	},
	{#State 269
		DEFAULT => -131
	},
	{#State 270
		DEFAULT => -16
	},
	{#State 271
		ACTIONS => {
			"}" => 357
		}
	},
	{#State 272
		DEFAULT => -258
	},
	{#State 273
		ACTIONS => {
			'OP07_STRING_REPEAT' => 291,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			'OP23_LOGICAL_AND' => 296,
			"}" => -251,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP21_LIST_COMMA' => -251,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 274
		ACTIONS => {
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP20_HASH_FATARROW' => -324,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'WORD' => 30
		},
		GOTOS => {
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 310,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105
		}
	},
	{#State 275
		DEFAULT => -252
	},
	{#State 276
		DEFAULT => -247,
		GOTOS => {
			'STAR-60' => 358
		}
	},
	{#State 277
		ACTIONS => {
			'OP06_REGEX_BIND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP21_LIST_COMMA' => 359,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP04_MATH_POW' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			";" => -101,
			'OP08_STRING_CAT' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_STRING_REPEAT' => -101
		}
	},
	{#State 278
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			")" => -128,
			";" => -128,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP08_STRING_CAT' => 284,
			'OP07_STRING_REPEAT' => 291,
			"]" => -128,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP21_LIST_COMMA' => -128,
			'OP09_BITWISE_SHIFT' => 286,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293
		}
	},
	{#State 279
		DEFAULT => -105
	},
	{#State 280
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 360
		}
	},
	{#State 281
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'WORD' => 30,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'SubExpression' => 361,
			'ScalarLiteral' => 163
		}
	},
	{#State 282
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'SELF' => 147,
			'SCALAR_SYMBOL' => 119,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 126,
			'ScalarVariable' => 364,
			'ScalarLiteral' => 363,
			'ScalarVariableOrLiteral' => 362
		}
	},
	{#State 283
		ACTIONS => {
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'SubExpression' => 365,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159
		}
	},
	{#State 284
		ACTIONS => {
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111
		},
		GOTOS => {
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'ArrayReferenceLiteral' => 149,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 366,
			'HashDereference' => 159
		}
	},
	{#State 285
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 367,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112
		}
	},
	{#State 286
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'WORD' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 368,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 287
		ACTIONS => {
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 369,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151
		}
	},
	{#State 288
		ACTIONS => {
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'SubExpression' => 370,
			'ScalarLiteral' => 163,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 289
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 371,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166
		}
	},
	{#State 290
		ACTIONS => {
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167
		},
		GOTOS => {
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'SubExpression' => 372,
			'ScalarLiteral' => 163,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 291
		ACTIONS => {
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160
		},
		GOTOS => {
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'HashDereference' => 159,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 373,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 292
		ACTIONS => {
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 374,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 293
		ACTIONS => {
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 375,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150
		}
	},
	{#State 294
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'WORD' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 376,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 295
		ACTIONS => {
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'SubExpression' => 377,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'WORD' => 30,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 378
		}
	},
	{#State 297
		ACTIONS => {
			'LBRACE' => 152,
			'HASH_REF_SYMBOL' => 96,
			")" => -149
		},
		GOTOS => {
			'HashReference' => 380,
			'HashReferenceLiteral' => 151,
			'HashRefLiteralEmpty' => 106,
			'HashReferenceVariable' => 182,
			'OPTIONAL-44' => 379
		}
	},
	{#State 298
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'WORD' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			")" => -145,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135
		},
		GOTOS => {
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'SubExpressions' => 381,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'OPTIONAL-42' => 382,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'SubExpression' => 259,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159
		}
	},
	{#State 299
		ACTIONS => {
			")" => 383,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 300
		ACTIONS => {
			")" => 384
		}
	},
	{#State 301
		DEFAULT => -134
	},
	{#State 302
		ACTIONS => {
			")" => -109,
			'OP16_LOGICAL_OR' => -109,
			'OP12_COMPARE_EQ_NE' => -109,
			'OP07_STRING_REPEAT' => -109,
			"]" => -109,
			'OP15_LOGICAL_AND' => -109,
			";" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_STRING_CAT' => -109,
			"}" => -109,
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP13_BITWISE_AND' => -109,
			'OP18_TERNARY' => -109,
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP06_REGEX_BIND' => -109
		}
	},
	{#State 303
		DEFAULT => -70
	},
	{#State 304
		ACTIONS => {
			"our hashref \$properties" => 387,
			"use constant" => 67
		},
		GOTOS => {
			'Properties' => 386,
			'Constant' => 385
		}
	},
	{#State 305
		ACTIONS => {
			'WORD' => 264,
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262
		},
		GOTOS => {
			'Type' => 388
		}
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
			";" => 391
		}
	},
	{#State 309
		DEFAULT => -127
	},
	{#State 310
		ACTIONS => {
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP07_STRING_REPEAT' => -101,
			"]" => -101,
			'OP08_STRING_CAT' => -101,
			";" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			")" => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP04_MATH_POW' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101
		}
	},
	{#State 311
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 286,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP16_LOGICAL_OR' => 289,
			")" => 392,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296
		}
	},
	{#State 312
		ACTIONS => {
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'SubExpression' => 393,
			'ScalarLiteral' => 163,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159
		}
	},
	{#State 313
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -224,
			'OP16_LOGICAL_OR' => 289,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			";" => -224,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296
		}
	},
	{#State 314
		DEFAULT => -223
	},
	{#State 315
		DEFAULT => -172
	},
	{#State 316
		ACTIONS => {
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP09_BITWISE_SHIFT' => 286,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			";" => -171,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			")" => -171,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295
		}
	},
	{#State 317
		DEFAULT => -173
	},
	{#State 318
		DEFAULT => -274
	},
	{#State 319
		ACTIONS => {
			"}" => 394
		}
	},
	{#State 320
		ACTIONS => {
			"\$TYPED_" => 395
		}
	},
	{#State 321
		DEFAULT => -143
	},
	{#State 322
		ACTIONS => {
			'TYPE_INTEGER' => 396
		}
	},
	{#State 323
		ACTIONS => {
			'TYPE_INTEGER' => 397
		}
	},
	{#State 324
		ACTIONS => {
			'WORD' => 30,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 398,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150
		}
	},
	{#State 325
		ACTIONS => {
			'WORD' => 264,
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262
		},
		GOTOS => {
			'Type' => 399
		}
	},
	{#State 326
		ACTIONS => {
			'WORD' => 264,
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262
		},
		GOTOS => {
			'Type' => 400
		}
	},
	{#State 327
		ACTIONS => {
			'FHREF_SYMBOL' => 401
		}
	},
	{#State 328
		ACTIONS => {
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'SubExpressions' => 402,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 259,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 329
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -277,
			'OP05_BITWISE_NEG_LPAREN' => -277,
			'LBRACKET' => -277,
			'OP01_CLOSE' => -277,
			'OP03_MATH_INC_DEC' => -277,
			'LITERAL_STRING' => -277,
			'OP22_LOGICAL_NEG' => -277,
			'LPAREN' => -277,
			'OP01_OPEN' => -277,
			'SCALAR_SYMBOL' => -277,
			'OP01_NAMED' => -277,
			"\@{" => -277,
			'ENV' => -277,
			'OP10_NAMED_UNARY' => -277,
			'LBRACE' => -277,
			'WORD' => -277,
			'LPAREN_TYPE_INNER' => -277,
			'ARRAY_SYMBOL' => -277,
			'SELF' => -277,
			'ARGV' => -277,
			"undef" => -277,
			'CONSTANT_CALL_SCOPED' => -277,
			'MY' => 212,
			'OP05_MATH_NEG_LPAREN' => -277,
			'HASH_SYMBOL' => -277,
			'WORD_SCOPED' => -277,
			'OP01_QW' => -277,
			'ARRAY_REF_SYMBOL' => -277,
			'HASH_REF_SYMBOL' => -277,
			'WORD_UPPERCASE' => -277,
			"%{" => -277,
			'OP22_LOGICAL_NEG_LPAREN' => -277,
			'LITERAL_NUMBER' => -277
		},
		GOTOS => {
			'OPTIONAL-64' => 403,
			'TypeInner' => 404
		}
	},
	{#State 330
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			")" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP04_MATH_POW' => -101
		}
	},
	{#State 331
		ACTIONS => {
			'OP21_LIST_COMMA' => 406,
			")" => -240
		},
		GOTOS => {
			'PAREN-55' => 407
		}
	},
	{#State 332
		DEFAULT => -236
	},
	{#State 333
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP21_LIST_COMMA' => -259,
			'OP09_BITWISE_SHIFT' => 286,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP07_STRING_REPEAT' => 291,
			"]" => -259,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -259,
			'OP16_LOGICAL_OR' => 289
		}
	},
	{#State 334
		ACTIONS => {
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			")" => -147,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD' => 30,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'HashReference' => 112,
			'SubExpressions' => 409,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'OPTIONAL-43' => 408,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 259
		}
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 411,
			"]" => -244
		},
		GOTOS => {
			'PAREN-57' => 410
		}
	},
	{#State 336
		DEFAULT => -269
	},
	{#State 337
		ACTIONS => {
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'SubExpression' => 412,
			'HashVariable' => 178,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159
		}
	},
	{#State 338
		ACTIONS => {
			'OP07_STRING_REPEAT' => -233,
			'OP20_HASH_FATARROW' => -233,
			'OP02_HASH_THINARROW' => 251,
			";" => -233,
			'OP15_LOGICAL_AND' => -233,
			'OP24_LOGICAL_OR_XOR' => -233,
			'OP19_VARIABLE_ASSIGN' => -233,
			")" => -233,
			'OP16_LOGICAL_OR' => -233,
			'OP12_COMPARE_EQ_NE' => -233,
			'OP02_ARRAY_THINARROW' => 252,
			'OP17_LIST_RANGE' => -233,
			'OP09_BITWISE_SHIFT' => -233,
			'OP13_BITWISE_AND' => -233,
			'OP08_MATH_ADD_SUB' => -233,
			'OP19_VARIABLE_ASSIGN_BY' => -233,
			'OP06_REGEX_BIND' => -233,
			"]" => -233,
			'LBRACE' => 339,
			'OP08_STRING_CAT' => -233,
			'OP23_LOGICAL_AND' => -233,
			"}" => -233,
			'OP07_MATH_MULT_DIV_MOD' => -233,
			'COLON' => -233,
			'OP04_MATH_POW' => -233,
			'OP14_BITWISE_OR_XOR' => -233,
			'OP03_MATH_INC_DEC' => -233,
			'OP21_LIST_COMMA' => -233,
			'OP02_METHOD_THINARROW' => -233,
			'OP18_TERNARY' => -233,
			'LBRACKET' => 337,
			'OP11_COMPARE_LT_GT' => -233
		},
		GOTOS => {
			'VariableRetrievalArrow' => 340,
			'VariableRetrieval' => 413
		}
	},
	{#State 339
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'WORD' => 414,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31
		},
		GOTOS => {
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashVariable' => 178,
			'SubExpression' => 415,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177
		}
	},
	{#State 340
		DEFAULT => -211
	},
	{#State 341
		DEFAULT => -230
	},
	{#State 342
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP09_BITWISE_SHIFT' => 286,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			"}" => 416,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292
		}
	},
	{#State 343
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -292,
			"}" => 417,
			'LPAREN' => -292
		}
	},
	{#State 344
		ACTIONS => {
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			"]" => 418,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295
		}
	},
	{#State 345
		DEFAULT => -290
	},
	{#State 346
		ACTIONS => {
			"}" => 419
		}
	},
	{#State 347
		DEFAULT => -151
	},
	{#State 348
		DEFAULT => -140
	},
	{#State 349
		ACTIONS => {
			";" => -170,
			'OP21_LIST_COMMA' => 420,
			")" => -170
		},
		GOTOS => {
			'PAREN-45' => 421
		}
	},
	{#State 350
		ACTIONS => {
			";" => 422
		}
	},
	{#State 351
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 424,
			";" => 423,
			'OP19_VARIABLE_ASSIGN' => 425
		}
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 426,
			";" => 427
		}
	},
	{#State 353
		ACTIONS => {
			";" => 429,
			'OP19_VARIABLE_ASSIGN' => 428
		}
	},
	{#State 354
		DEFAULT => -110
	},
	{#State 355
		ACTIONS => {
			";" => 430
		}
	},
	{#State 356
		ACTIONS => {
			";" => 431
		}
	},
	{#State 357
		DEFAULT => -285
	},
	{#State 358
		ACTIONS => {
			"}" => -248,
			'OP21_LIST_COMMA' => 433
		},
		GOTOS => {
			'PAREN-59' => 432
		}
	},
	{#State 359
		ACTIONS => {
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarLiteral' => 163,
			'SubExpression' => 259,
			'HashVariable' => 178,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'SubExpressions' => 434,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184
		}
	},
	{#State 360
		DEFAULT => -111
	},
	{#State 361
		ACTIONS => {
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -130,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			"]" => -130,
			'OP07_STRING_REPEAT' => 291,
			'OP15_LOGICAL_AND' => 292,
			";" => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP08_STRING_CAT' => 284,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -130,
			'OP16_LOGICAL_OR' => 289,
			'OP23_LOGICAL_AND' => 296,
			"}" => -130,
			'OP07_MATH_MULT_DIV_MOD' => 295
		}
	},
	{#State 362
		ACTIONS => {
			'COLON' => 435
		}
	},
	{#State 363
		DEFAULT => -303
	},
	{#State 364
		DEFAULT => -302
	},
	{#State 365
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP06_REGEX_BIND' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP13_BITWISE_AND' => -107,
			'OP18_TERNARY' => -107,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP17_LIST_RANGE' => -107,
			"}" => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP16_LOGICAL_OR' => -107,
			")" => -107,
			'OP12_COMPARE_EQ_NE' => -107,
			'OP07_STRING_REPEAT' => -107,
			"]" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			";" => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP08_STRING_CAT' => -107
		}
	},
	{#State 366
		ACTIONS => {
			'OP23_LOGICAL_AND' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -115,
			";" => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP08_STRING_CAT' => -115,
			"]" => -115,
			'OP07_STRING_REPEAT' => 291,
			'OP16_LOGICAL_OR' => -115,
			")" => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => -115,
			'OP08_MATH_ADD_SUB' => 285,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP21_LIST_COMMA' => -115
		}
	},
	{#State 367
		ACTIONS => {
			'OP16_LOGICAL_OR' => -114,
			")" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			";" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP08_STRING_CAT' => -114,
			'OP07_STRING_REPEAT' => 291,
			"]" => -114,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114,
			'OP18_TERNARY' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => -114,
			'OP11_COMPARE_LT_GT' => -114
		}
	},
	{#State 368
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => -116,
			'OP17_LIST_RANGE' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => -116,
			'OP18_TERNARY' => -116,
			'OP09_BITWISE_SHIFT' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -116,
			";" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => -116,
			"]" => -116,
			'OP07_STRING_REPEAT' => 291,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP16_LOGICAL_OR' => -116,
			")" => -116
		}
	},
	{#State 369
		ACTIONS => {
			'OP16_LOGICAL_OR' => -121,
			")" => -121,
			'OP12_COMPARE_EQ_NE' => 290,
			";" => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP08_STRING_CAT' => 284,
			"]" => -121,
			'OP07_STRING_REPEAT' => 291,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -121,
			'OP23_LOGICAL_AND' => -121,
			'OP13_BITWISE_AND' => -121,
			'OP18_TERNARY' => -121,
			'OP21_LIST_COMMA' => -121,
			'OP09_BITWISE_SHIFT' => 286,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP17_LIST_RANGE' => -121,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285
		}
	},
	{#State 370
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => -125,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -125,
			'OP23_LOGICAL_AND' => -125,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -125,
			";" => -125,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP08_STRING_CAT' => 284,
			"]" => -125,
			'OP07_STRING_REPEAT' => 291,
			'OP16_LOGICAL_OR' => 289,
			")" => -125,
			'OP12_COMPARE_EQ_NE' => 290
		}
	},
	{#State 371
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -124,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => -124,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => -124,
			"}" => -124,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => -124,
			'OP16_LOGICAL_OR' => -124,
			")" => -124,
			'OP12_COMPARE_EQ_NE' => 290,
			"]" => -124,
			'OP07_STRING_REPEAT' => 291,
			'OP15_LOGICAL_AND' => 292,
			";" => -124,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => -124
		}
	},
	{#State 372
		ACTIONS => {
			"]" => -120,
			'OP07_STRING_REPEAT' => 291,
			'OP24_LOGICAL_OR_XOR' => -120,
			";" => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP08_STRING_CAT' => 284,
			")" => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -120,
			"}" => -120,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP17_LIST_RANGE' => -120,
			'OP21_LIST_COMMA' => -120,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => -120,
			'OP18_TERNARY' => -120,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 373
		ACTIONS => {
			'OP21_LIST_COMMA' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP18_TERNARY' => -112,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP06_REGEX_BIND' => 280,
			")" => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			"]" => -112,
			'OP07_STRING_REPEAT' => -112,
			'OP15_LOGICAL_AND' => -112,
			";" => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_STRING_CAT' => -112,
			"}" => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP23_LOGICAL_AND' => -112
		}
	},
	{#State 374
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => -123,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -123,
			'OP18_TERNARY' => -123,
			'OP13_BITWISE_AND' => 287,
			'OP23_LOGICAL_AND' => -123,
			"}" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP07_STRING_REPEAT' => 291,
			"]" => -123,
			'OP08_STRING_CAT' => 284,
			";" => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP15_LOGICAL_AND' => -123,
			'OP16_LOGICAL_OR' => -123,
			")" => -123,
			'OP12_COMPARE_EQ_NE' => 290
		}
	},
	{#State 375
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => undef,
			'OP06_REGEX_BIND' => 280,
			'OP21_LIST_COMMA' => -119,
			'OP09_BITWISE_SHIFT' => 286,
			'OP18_TERNARY' => -119,
			'OP13_BITWISE_AND' => -119,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP17_LIST_RANGE' => -119,
			"}" => -119,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => -119,
			'OP12_COMPARE_EQ_NE' => -119,
			'OP16_LOGICAL_OR' => -119,
			")" => -119,
			'OP07_STRING_REPEAT' => 291,
			"]" => -119,
			'OP08_STRING_CAT' => 284,
			";" => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP15_LOGICAL_AND' => -119
		}
	},
	{#State 376
		ACTIONS => {
			'OP17_LIST_RANGE' => -122,
			'OP14_BITWISE_OR_XOR' => -122,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => -122,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -122,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			";" => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => -122,
			'OP07_STRING_REPEAT' => 291,
			"]" => -122,
			")" => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -122
		}
	},
	{#State 377
		ACTIONS => {
			'OP13_BITWISE_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP16_LOGICAL_OR' => -113,
			")" => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			";" => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP08_STRING_CAT' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			"]" => -113,
			'OP07_STRING_REPEAT' => 291,
			'OP07_MATH_MULT_DIV_MOD' => -113,
			"}" => -113,
			'OP23_LOGICAL_AND' => -113
		}
	},
	{#State 378
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP21_LIST_COMMA' => -129,
			'OP09_BITWISE_SHIFT' => 286,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -129,
			'OP23_LOGICAL_AND' => -129,
			")" => -129,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			";" => -129,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => -129,
			"]" => -129,
			'OP07_STRING_REPEAT' => 291
		}
	},
	{#State 379
		ACTIONS => {
			")" => 436
		}
	},
	{#State 380
		DEFAULT => -148
	},
	{#State 381
		DEFAULT => -144
	},
	{#State 382
		ACTIONS => {
			")" => 437
		}
	},
	{#State 383
		DEFAULT => -108
	},
	{#State 384
		ACTIONS => {
			";" => 438
		}
	},
	{#State 385
		DEFAULT => -72
	},
	{#State 386
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 439
		}
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 440
		}
	},
	{#State 388
		ACTIONS => {
			"\$RETURN_TYPE" => 441
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
			"}" => 443
		}
	},
	{#State 392
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 445
		}
	},
	{#State 393
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP21_LIST_COMMA' => -262,
			'OP09_BITWISE_SHIFT' => 286,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			")" => -262,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			'OP07_STRING_REPEAT' => 291
		},
		GOTOS => {
			'STAR-62' => 446
		}
	},
	{#State 394
		DEFAULT => -275
	},
	{#State 395
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP10_NAMED_UNARY' => 188,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP01_NAMED_VOID' => 203,
			'OP01_OPEN' => 191,
			'OP23_LOGICAL_AND' => 190,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 200,
			'OP01_PRINT' => 204,
			'OP22_LOGICAL_NEG' => 201,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 196,
			'WORD' => 205,
			'OP01_CLOSE' => 195
		},
		GOTOS => {
			'OpStringOrWord' => 447
		}
	},
	{#State 396
		ACTIONS => {
			'SCALAR_SYMBOL' => 448
		}
	},
	{#State 397
		ACTIONS => {
			'SCALAR_SYMBOL' => 449
		}
	},
	{#State 398
		ACTIONS => {
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP16_LOGICAL_OR' => 289,
			")" => 450,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP09_BITWISE_SHIFT' => 286,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 399
		ACTIONS => {
			'SCALAR_SYMBOL' => 451
		}
	},
	{#State 400
		ACTIONS => {
			'SCALAR_SYMBOL' => 452
		}
	},
	{#State 401
		ACTIONS => {
			'OP21_LIST_COMMA' => 453
		}
	},
	{#State 402
		ACTIONS => {
			")" => 454
		}
	},
	{#State 403
		ACTIONS => {
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111
		},
		GOTOS => {
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'SubExpression' => 455,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 404
		DEFAULT => -276
	},
	{#State 405
		ACTIONS => {
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD' => 30,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160
		},
		GOTOS => {
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 259,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'Expression' => 179,
			'SubExpressions' => 456,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136
		}
	},
	{#State 406
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'OP11_COMPARE_LT_GT' => 196,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 239,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 233,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 237,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 274,
			'OP23_LOGICAL_AND' => 190,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 238,
			'OP08_MATH_ADD_SUB' => 199,
			'WORD' => 225,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_PRINT' => 204,
			'OP05_MATH_NEG_LPAREN' => 141,
			'MY' => 212,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_VOID' => 203,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			"%{" => 132,
			'OP12_COMPARE_EQ_NE' => 198,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP07_STRING_REPEAT' => 197,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'HashVariable' => 178,
			'SubExpression' => 235,
			'ScalarLiteral' => 234,
			'ScalarVariable' => 241,
			'ArrayReferenceVariable' => 180,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ListElement' => 231,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'OpStringOrWord' => 240,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'HashEntry' => 230,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'ArrayHashLiteralE' => 457,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'TypeInner' => 236,
			'HashReference' => 112
		}
	},
	{#State 407
		DEFAULT => -238
	},
	{#State 408
		ACTIONS => {
			")" => 458
		}
	},
	{#State 409
		DEFAULT => -146
	},
	{#State 410
		DEFAULT => -242
	},
	{#State 411
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'WORD' => 30,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'MY' => 212,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ListElement' => 244,
			'ArrayReferenceLiteral' => 149,
			'ArrayLiteralE' => 459,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'SubExpression' => 245,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'TypeInner' => 236,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156
		}
	},
	{#State 412
		ACTIONS => {
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			"]" => 460,
			'OP07_STRING_REPEAT' => 291,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP09_BITWISE_SHIFT' => 286
		}
	},
	{#State 413
		DEFAULT => -229
	},
	{#State 414
		ACTIONS => {
			"}" => 461,
			'LPAREN' => -292,
			'OP02_METHOD_THINARROW_NEW' => -292
		}
	},
	{#State 415
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP07_STRING_REPEAT' => 291,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => 462
		}
	},
	{#State 416
		DEFAULT => -209
	},
	{#State 417
		DEFAULT => -210
	},
	{#State 418
		DEFAULT => -208
	},
	{#State 419
		DEFAULT => -291
	},
	{#State 420
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'ENV' => 155,
			"\@{" => 111,
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'SubExpression' => 463,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106
		}
	},
	{#State 421
		DEFAULT => -168
	},
	{#State 422
		DEFAULT => -222
	},
	{#State 423
		DEFAULT => -215
	},
	{#State 424
		ACTIONS => {
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160
		},
		GOTOS => {
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 464,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166
		}
	},
	{#State 425
		ACTIONS => {
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'FHREF_SYMBOL_IN' => 315,
			'HASH_SYMBOL' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 467,
			'WORD_SCOPED' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP01_NAMED_SCOLON' => 465,
			'LITERAL_NUMBER' => 94,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'STDIN' => 317,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155
		},
		GOTOS => {
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'OpNamedScolonOrSubExpIn' => 468,
			'SubExpressionOrInput' => 466,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'ArrayReferenceLiteral' => 149,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'SubExpression' => 316,
			'ScalarLiteral' => 163,
			'HashDereference' => 159
		}
	},
	{#State 426
		ACTIONS => {
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'FHREF_SYMBOL_IN' => 315,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 467,
			'HASH_SYMBOL' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 465,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'STDIN' => 317,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155
		},
		GOTOS => {
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'SubExpression' => 316,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'SubExpressionOrInput' => 466,
			'OpNamedScolonOrSubExpIn' => 469,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179
		}
	},
	{#State 427
		DEFAULT => -218
	},
	{#State 428
		ACTIONS => {
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'STDIN' => 317,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'WORD' => 30,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'FHREF_SYMBOL_IN' => 315,
			'WORD_SCOPED' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 467,
			'HASH_SYMBOL' => 135,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 465,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96
		},
		GOTOS => {
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'SubExpressionOrInput' => 466,
			'ArrayRefLiteralEmpty' => 99,
			'OpNamedScolonOrSubExpIn' => 470,
			'Expression' => 179,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'SubExpression' => 316,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashDereference' => 159
		}
	},
	{#State 429
		DEFAULT => -220
	},
	{#State 430
		DEFAULT => -137
	},
	{#State 431
		DEFAULT => -136
	},
	{#State 432
		DEFAULT => -246
	},
	{#State 433
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 239,
			'LBRACKET' => 124,
			'OP11_COMPARE_LT_GT' => 196,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 233,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP23_LOGICAL_AND' => 190,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 274,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 237,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 238,
			"\@{" => 111,
			'ENV' => 155,
			'OP08_MATH_ADD_SUB' => 199,
			'WORD' => 225,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP01_PRINT' => 204,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'OP01_NAMED_VOID' => 203,
			'WORD_SCOPED' => 31,
			'OP07_STRING_REPEAT' => 197,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP24_LOGICAL_OR_XOR' => 202,
			'HASH_REF_SYMBOL' => 96,
			'OP12_COMPARE_EQ_NE' => 198,
			"%{" => 132,
			'WORD_UPPERCASE' => 185
		},
		GOTOS => {
			'Hash' => 150,
			'HashEntry' => 275,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'ScaVarOrLitOrOpStrOrWord' => 227,
			'HashLiteralE' => 471,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashVariable' => 178,
			'ScalarLiteral' => 234,
			'SubExpression' => 273,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 241,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'OpStringOrWord' => 240,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 434
		ACTIONS => {
			";" => 472
		}
	},
	{#State 435
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 121,
			'SELF' => 147,
			'SCALAR_SYMBOL' => 119
		},
		GOTOS => {
			'ScalarLiteral' => 363,
			'ScalarVariableOrLiteral' => 473,
			'ScalarVariable' => 364,
			'ScalarVariableOrSelf' => 126
		}
	},
	{#State 436
		DEFAULT => -155
	},
	{#State 437
		DEFAULT => -153
	},
	{#State 438
		DEFAULT => -139
	},
	{#State 439
		ACTIONS => {
			'LITERAL_NUMBER' => 477,
			'SUB' => 474
		},
		GOTOS => {
			'Method' => 478,
			'Subroutine' => 475,
			'SubroutineOrMethod' => 476
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 479
		}
	},
	{#State 441
		ACTIONS => {
			"}" => 480
		}
	},
	{#State 442
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 481
		}
	},
	{#State 443
		DEFAULT => -55
	},
	{#State 444
		ACTIONS => {
			"for" => -178,
			'POD' => 107,
			'WORD' => 30,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP01_PRINT' => 143,
			'OP05_MATH_NEG_LPAREN' => 141,
			'MY' => 139,
			'CONSTANT_CALL_SCOPED' => 140,
			"while" => -178,
			'OP01_NAMED_VOID' => 138,
			'WORD_SCOPED' => 31,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			'HASH_SYMBOL' => 135,
			"if" => 101,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			"%{" => 132,
			'WORD_UPPERCASE' => 133,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP01_NAMED_SCOLON' => 128,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			"foreach" => -178,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 158,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED' => 157,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Conditional' => 108,
			'Variable' => 109,
			'HashReferenceVariable' => 153,
			'OperatorVoid' => 154,
			'Scalar' => 156,
			'HashReference' => 112,
			'VariableDeclaration' => 114,
			'Expression' => 115,
			'OPTIONAL-48' => 116,
			'HashDereference' => 159,
			'Operation' => 483,
			'HashVariable' => 122,
			'SubExpression' => 164,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 123,
			'ArrayReferenceVariable' => 165,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'Operator' => 129,
			'Statement' => 127,
			'ArrayVariable' => 130,
			'LoopLabel' => 97,
			'PAREN-47' => 131,
			'ArrayRefLiteralEmpty' => 99,
			'Array' => 136,
			'VariableModification' => 137,
			'ArrayHashLiteral' => 102,
			'PLUS-53' => 482,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 445
		DEFAULT => -187,
		GOTOS => {
			'STAR-50' => 484
		}
	},
	{#State 446
		ACTIONS => {
			")" => 487,
			'OP21_LIST_COMMA' => 485
		},
		GOTOS => {
			'PAREN-61' => 486
		}
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 488
		}
	},
	{#State 448
		ACTIONS => {
			'LPAREN' => 489
		}
	},
	{#State 449
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 490
		}
	},
	{#State 450
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 491
		}
	},
	{#State 451
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 492
		}
	},
	{#State 452
		ACTIONS => {
			'LPAREN' => 493
		}
	},
	{#State 453
		ACTIONS => {
			'LITERAL_STRING' => 494
		}
	},
	{#State 454
		DEFAULT => -99
	},
	{#State 455
		ACTIONS => {
			"}" => -278,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP16_LOGICAL_OR' => 289,
			")" => -278,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP07_STRING_REPEAT' => 291,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -278,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288
		}
	},
	{#State 456
		ACTIONS => {
			")" => 495
		}
	},
	{#State 457
		DEFAULT => -237
	},
	{#State 458
		DEFAULT => -154
	},
	{#State 459
		DEFAULT => -241
	},
	{#State 460
		DEFAULT => -212
	},
	{#State 461
		DEFAULT => -214
	},
	{#State 462
		DEFAULT => -213
	},
	{#State 463
		ACTIONS => {
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -167,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP07_STRING_REPEAT' => 291,
			'OP15_LOGICAL_AND' => 292,
			";" => -167,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -167,
			'OP16_LOGICAL_OR' => 289,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295
		}
	},
	{#State 464
		ACTIONS => {
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP07_STRING_REPEAT' => 291,
			"]" => 496,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 465
		DEFAULT => -310
	},
	{#State 466
		ACTIONS => {
			";" => 497
		}
	},
	{#State 467
		DEFAULT => -311
	},
	{#State 468
		DEFAULT => -216
	},
	{#State 469
		DEFAULT => -219
	},
	{#State 470
		DEFAULT => -221
	},
	{#State 471
		DEFAULT => -245
	},
	{#State 472
		DEFAULT => -141
	},
	{#State 473
		DEFAULT => -126
	},
	{#State 474
		ACTIONS => {
			'WORD' => 498
		}
	},
	{#State 475
		DEFAULT => -93
	},
	{#State 476
		DEFAULT => -74
	},
	{#State 477
		ACTIONS => {
			";" => 499
		}
	},
	{#State 478
		DEFAULT => -94
	},
	{#State 479
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP10_NAMED_UNARY' => 188,
			"}" => 501,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP01_NAMED_VOID' => 203,
			'OP01_OPEN' => 191,
			'OP23_LOGICAL_AND' => 190,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 200,
			'OP01_PRINT' => 204,
			'OP22_LOGICAL_NEG' => 201,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 196,
			'WORD' => 205,
			'OP01_CLOSE' => 195
		},
		GOTOS => {
			'OpStringOrWord' => 500,
			'HashEntryProperties' => 502
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
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_UPPERCASE' => 133,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'OP01_NAMED_VOID' => 138,
			'WORD_SCOPED' => 31,
			"if" => 101,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			'HASH_SYMBOL' => 135,
			'OP05_MATH_NEG_LPAREN' => 141,
			"while" => -178,
			'MY' => 139,
			'CONSTANT_CALL_SCOPED' => 140,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'OP01_PRINT' => 143,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			"for" => -178,
			'WORD' => 30,
			'POD' => 107,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 157,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 158,
			"}" => 505,
			'OP22_LOGICAL_NEG' => 160,
			"foreach" => -178,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayRefLiteralEmpty' => 99,
			'ArrayHashLiteral' => 102,
			'VariableModification' => 137,
			'Array' => 136,
			'ArrayVariable' => 130,
			'Operator' => 129,
			'Statement' => 127,
			'PAREN-47' => 131,
			'LoopLabel' => 97,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashDereference' => 159,
			'ScalarVariable' => 123,
			'ArrayReferenceVariable' => 165,
			'HashVariable' => 122,
			'ScalarLiteral' => 163,
			'SubExpression' => 164,
			'Operation' => 504,
			'Expression' => 115,
			'VariableDeclaration' => 114,
			'HashReference' => 112,
			'OPTIONAL-48' => 116,
			'Variable' => 109,
			'HashReferenceLiteral' => 151,
			'Conditional' => 108,
			'Hash' => 150,
			'OperatorVoid' => 154,
			'Scalar' => 156,
			'HashReferenceVariable' => 153
		}
	},
	{#State 483
		DEFAULT => -201
	},
	{#State 484
		ACTIONS => {
			'HASH_REF_SYMBOL' => -190,
			'WORD_UPPERCASE' => -190,
			"%{" => -190,
			'OP01_NAMED_SCOLON' => -190,
			'OP22_LOGICAL_NEG_LPAREN' => -190,
			'LITERAL_NUMBER' => -190,
			"if" => -190,
			'HASH_SYMBOL' => -190,
			'OP10_NAMED_UNARY_SCOLON' => -190,
			'WORD_SCOPED' => -190,
			'OP01_NAMED_VOID' => -190,
			'OP01_QW' => -190,
			'ARRAY_REF_SYMBOL' => -190,
			"else" => 510,
			'OP01_PRINT' => -190,
			'ARRAY_SYMBOL' => -190,
			'LPAREN_TYPE_INNER' => -190,
			'SELF' => -190,
			"undef" => -190,
			'ARGV' => -190,
			"while" => -190,
			'MY' => -190,
			'CONSTANT_CALL_SCOPED' => -190,
			'OP05_MATH_NEG_LPAREN' => -190,
			'POD' => -190,
			'WORD' => -190,
			'' => -190,
			"for" => -190,
			"\@{" => -190,
			'ENV' => -190,
			"elsif" => 509,
			'OP10_NAMED_UNARY' => -190,
			'LBRACE' => -190,
			'OP01_NAMED_VOID_SCOLON' => -190,
			'OP19_LOOP_CONTROL_SCOLON' => -190,
			"}" => -190,
			'OP01_OPEN' => -190,
			'LPAREN' => -190,
			'SCALAR_SYMBOL' => -190,
			'OP01_NAMED' => -190,
			'OP19_LOOP_CONTROL' => -190,
			'OP03_MATH_INC_DEC' => -190,
			'LITERAL_STRING' => -190,
			"foreach" => -190,
			'OP22_LOGICAL_NEG' => -190,
			'OP05_LOGICAL_NEG' => -190,
			'OP05_BITWISE_NEG_LPAREN' => -190,
			'OP01_NAMED_VOID_LPAREN' => -190,
			'LBRACKET' => -190,
			'OP01_CLOSE' => -190
		},
		GOTOS => {
			'PAREN-49' => 508,
			'OPTIONAL-52' => 506,
			'PAREN-51' => 507
		}
	},
	{#State 485
		ACTIONS => {
			'MY' => 212
		},
		GOTOS => {
			'ListElement' => 511,
			'TypeInner' => 236
		}
	},
	{#State 486
		DEFAULT => -261
	},
	{#State 487
		DEFAULT => -263
	},
	{#State 488
		DEFAULT => -298
	},
	{#State 489
		ACTIONS => {
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'WORD' => 30,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147
		},
		GOTOS => {
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'ArrayReferenceLiteral' => 149,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'ScalarLiteral' => 163,
			'SubExpression' => 512,
			'HashVariable' => 178,
			'HashDereference' => 159
		}
	},
	{#State 490
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 514,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_SYMBOL' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 516,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'SubExpression' => 513,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'OpNamedScolonOrSubExp' => 515
		}
	},
	{#State 491
		DEFAULT => -198
	},
	{#State 492
		ACTIONS => {
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'STDIN' => 317,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'FHREF_SYMBOL_IN' => 315,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			'WORD' => 30,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ScalarLiteral' => 163,
			'SubExpression' => 316,
			'HashVariable' => 178,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'SubExpressionOrInput' => 517,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156
		}
	},
	{#State 493
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'ENV' => 155,
			"\@{" => 111,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'WORD' => 30,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_REF_SYMBOL' => 96,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95
		},
		GOTOS => {
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'SubExpressions' => 518,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'HashDereference' => 159,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'SubExpression' => 259,
			'ScalarLiteral' => 163,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 494
		ACTIONS => {
			'OP21_LIST_COMMA' => 519
		}
	},
	{#State 495
		DEFAULT => -102
	},
	{#State 496
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 520
		}
	},
	{#State 497
		DEFAULT => -312
	},
	{#State 498
		ACTIONS => {
			'LBRACE' => 521
		}
	},
	{#State 499
		DEFAULT => -76
	},
	{#State 500
		ACTIONS => {
			'OP20_HASH_FATARROW' => 522
		}
	},
	{#State 501
		ACTIONS => {
			";" => 523
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
			'OP01_QW' => -58,
			'ARRAY_REF_SYMBOL' => -58,
			"if" => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'HASH_SYMBOL' => -58,
			'OP01_NAMED_VOID' => -58,
			'WORD_SCOPED' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'LITERAL_NUMBER' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'LPAREN_MY' => 527,
			'HASH_REF_SYMBOL' => -58,
			'WORD_UPPERCASE' => -58,
			"%{" => -58,
			'WORD' => -58,
			'POD' => -58,
			"for" => -58,
			"while" => -58,
			'MY' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP01_PRINT' => -58,
			'ARRAY_SYMBOL' => -58,
			'LPAREN_TYPE_INNER' => -58,
			'SELF' => -58,
			"undef" => -58,
			'ARGV' => -58,
			'OP01_NAMED' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			"}" => -58,
			'LPAREN' => -58,
			'SCALAR_SYMBOL' => -58,
			'OP01_OPEN' => -58,
			'OP10_NAMED_UNARY' => -58,
			'LBRACE' => -58,
			"\@{" => -58,
			'ENV' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP01_CLOSE' => -58,
			'LBRACKET' => -58,
			'OP05_LOGICAL_NEG' => -58,
			"foreach" => -58,
			'OP22_LOGICAL_NEG' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'LITERAL_STRING' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 526,
			'SubroutineArguments' => 525
		}
	},
	{#State 504
		DEFAULT => -200
	},
	{#State 505
		DEFAULT => -202
	},
	{#State 506
		DEFAULT => -191
	},
	{#State 507
		DEFAULT => -189
	},
	{#State 508
		DEFAULT => -186
	},
	{#State 509
		ACTIONS => {
			'LPAREN' => 528
		}
	},
	{#State 510
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 529
		}
	},
	{#State 511
		DEFAULT => -260
	},
	{#State 512
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 530,
			'OP04_MATH_POW' => 283,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_STRING_REPEAT' => 291,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289
		}
	},
	{#State 513
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP06_REGEX_BIND' => 280,
			'OP04_MATH_POW' => 283,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP07_STRING_REPEAT' => 291,
			'OP24_LOGICAL_OR_XOR' => 281,
			";" => 531,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289
		}
	},
	{#State 514
		DEFAULT => -307
	},
	{#State 515
		ACTIONS => {
			'SCALAR_SYMBOL' => 532
		}
	},
	{#State 516
		DEFAULT => -308
	},
	{#State 517
		ACTIONS => {
			")" => 533
		}
	},
	{#State 518
		ACTIONS => {
			")" => 534
		}
	},
	{#State 519
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'SubExpression' => 535,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashDereference' => 159,
			'ArrayReferenceLiteral' => 149,
			'WordScoped' => 166,
			'HashRefLiteralEmpty' => 106,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'Hash' => 150,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'ArrayVariable' => 184,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179
		}
	},
	{#State 520
		ACTIONS => {
			"undef" => 536
		}
	},
	{#State 521
		ACTIONS => {
			'LBRACE' => 537
		}
	},
	{#State 522
		ACTIONS => {
			'MY' => 538
		},
		GOTOS => {
			'TypeInnerProperties' => 539
		}
	},
	{#State 523
		DEFAULT => -83
	},
	{#State 524
		ACTIONS => {
			"}" => 542,
			'OP21_LIST_COMMA' => 541
		},
		GOTOS => {
			'PAREN-33' => 540
		}
	},
	{#State 525
		DEFAULT => -57
	},
	{#State 526
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 543
		}
	},
	{#State 527
		ACTIONS => {
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262,
			'WORD' => 264
		},
		GOTOS => {
			'Type' => 544
		}
	},
	{#State 528
		ACTIONS => {
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'SELF' => 147,
			"undef" => 146,
			'ARGV' => 145,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30
		},
		GOTOS => {
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'ScalarLiteral' => 163,
			'HashVariable' => 178,
			'SubExpression' => 545,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'ArrayReferenceLiteral' => 149,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102
		}
	},
	{#State 529
		DEFAULT => -188
	},
	{#State 530
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP01_NAMED' => 183,
			"\@{" => 111,
			'ENV' => 155,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 152,
			'WORD' => 30,
			'SELF' => 147,
			'ARGV' => 145,
			"undef" => 146,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_UPPERCASE' => 185,
			"%{" => 132,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95
		},
		GOTOS => {
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'ArrayVariable' => 184,
			'HashReferenceVariable' => 182,
			'Scalar' => 156,
			'HashReference' => 112,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'Array' => 136,
			'ArrayHashLiteral' => 102,
			'HashDereference' => 159,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 546,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'ArrayReferenceLiteral' => 149
		}
	},
	{#State 531
		DEFAULT => -309
	},
	{#State 532
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 547
		}
	},
	{#State 533
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 548
		}
	},
	{#State 534
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 549
		}
	},
	{#State 535
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP21_LIST_COMMA' => -103,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -103,
			'OP16_LOGICAL_OR' => 289,
			";" => -103,
			'OP15_LOGICAL_AND' => 292,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_STRING_REPEAT' => 291,
			"]" => -103
		}
	},
	{#State 536
		ACTIONS => {
			";" => 550
		}
	},
	{#State 537
		ACTIONS => {
			'MY' => 551
		}
	},
	{#State 538
		ACTIONS => {
			'WORD' => 264,
			'TYPE_INTEGER' => 260,
			'WORD_SCOPED' => 262
		},
		GOTOS => {
			'Type' => 552
		}
	},
	{#State 539
		DEFAULT => -279
	},
	{#State 540
		DEFAULT => -80
	},
	{#State 541
		ACTIONS => {
			'OP01_PRINT' => 204,
			'OP22_LOGICAL_NEG' => 201,
			'WORD' => 205,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 196,
			'OP01_CLOSE' => 195,
			'OP12_COMPARE_EQ_NE' => 198,
			'OP10_NAMED_UNARY' => 188,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP07_STRING_REPEAT' => 197,
			'OP01_OPEN' => 191,
			'OP01_NAMED_VOID' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP01_NAMED' => 200,
			'OP19_LOOP_CONTROL' => 189,
			'OP23_LOGICAL_AND' => 190
		},
		GOTOS => {
			'HashEntryProperties' => 553,
			'OpStringOrWord' => 500
		}
	},
	{#State 542
		ACTIONS => {
			";" => 554
		}
	},
	{#State 543
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			"foreach" => -178,
			'OP22_LOGICAL_NEG' => 160,
			"}" => 555,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 158,
			'SCALAR_SYMBOL' => 119,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED' => 157,
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 30,
			'POD' => 107,
			"for" => -178,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_PRINT' => 143,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'MY' => 139,
			'CONSTANT_CALL_SCOPED' => 140,
			"while" => -178,
			'OP05_MATH_NEG_LPAREN' => 141,
			'HASH_SYMBOL' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			"if" => 101,
			'WORD_SCOPED' => 31,
			'OP01_NAMED_VOID' => 138,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 133,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 95
		},
		GOTOS => {
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'ArrayVariable' => 130,
			'Statement' => 127,
			'Operator' => 129,
			'PAREN-47' => 131,
			'LoopLabel' => 97,
			'ArrayRefLiteralEmpty' => 99,
			'ArrayHashLiteral' => 102,
			'VariableModification' => 137,
			'Array' => 136,
			'HashDereference' => 159,
			'ArrayReferenceVariable' => 165,
			'ScalarVariable' => 123,
			'HashVariable' => 122,
			'ScalarLiteral' => 163,
			'SubExpression' => 164,
			'Operation' => 556,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'Variable' => 109,
			'Conditional' => 108,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'OperatorVoid' => 154,
			'Scalar' => 156,
			'HashReferenceVariable' => 153,
			'Expression' => 115,
			'VariableDeclaration' => 114,
			'HashReference' => 112,
			'OPTIONAL-48' => 116
		}
	},
	{#State 544
		ACTIONS => {
			'SCALAR_SYMBOL' => 557
		}
	},
	{#State 545
		ACTIONS => {
			'OP23_LOGICAL_AND' => 296,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP08_STRING_CAT' => 284,
			'OP07_STRING_REPEAT' => 291,
			'OP16_LOGICAL_OR' => 289,
			")" => 558,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP09_BITWISE_SHIFT' => 286
		}
	},
	{#State 546
		ACTIONS => {
			")" => 559,
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP07_STRING_REPEAT' => 291,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => -125,
			'OP09_BITWISE_SHIFT' => 286,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => -125,
			'OP04_MATH_POW' => 283,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP06_REGEX_BIND' => 280
		}
	},
	{#State 547
		ACTIONS => {
			"\@{" => 111,
			'ENV' => 155,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP01_NAMED' => 183,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_SCOLON' => 514,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP10_NAMED_UNARY_SCOLON' => 516,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'LPAREN_TYPE_INNER' => 103,
			'ARRAY_SYMBOL' => 142,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'WORD' => 30
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'SubExpression' => 513,
			'ScalarLiteral' => 163,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'Scalar' => 156,
			'OpNamedScolonOrSubExp' => 560,
			'HashReferenceVariable' => 182
		}
	},
	{#State 548
		DEFAULT => -199
	},
	{#State 549
		DEFAULT => -197
	},
	{#State 550
		DEFAULT => -217
	},
	{#State 551
		ACTIONS => {
			'WORD_SCOPED' => 262,
			'TYPE_INTEGER' => 260,
			'TYPE_METHOD' => 561,
			'WORD' => 264
		},
		GOTOS => {
			'Type' => 388
		}
	},
	{#State 552
		ACTIONS => {
			"\$TYPED_" => 562
		}
	},
	{#State 553
		DEFAULT => -79
	},
	{#State 554
		DEFAULT => -82
	},
	{#State 555
		DEFAULT => -61
	},
	{#State 556
		DEFAULT => -59
	},
	{#State 557
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 563
		}
	},
	{#State 558
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 564
		}
	},
	{#State 559
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 565
		}
	},
	{#State 560
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'LITERAL_NUMBER' => 94,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			'ENV' => 155,
			"\@{" => 111,
			'OP01_NAMED' => 183,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'HashDereference' => 159,
			'ScalarVariable' => 123,
			'ArrayReferenceVariable' => 165,
			'ScalarLiteral' => 163,
			'SubExpression' => 566,
			'HashVariable' => 122,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ScalarVariableOrSelf' => 126,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'Variable' => 109,
			'ArrayVariable' => 130,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150,
			'Scalar' => 156,
			'SubExpressionOrVarMod' => 567,
			'HashReferenceVariable' => 153,
			'ArrayRefLiteralEmpty' => 99,
			'Expression' => 179,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'VariableModification' => 568,
			'Array' => 136
		}
	},
	{#State 561
		ACTIONS => {
			"\$RETURN_TYPE" => 569
		}
	},
	{#State 562
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 202,
			'OP10_NAMED_UNARY' => 188,
			'OP19_LOOP_CONTROL_SCOLON' => 193,
			'OP01_NAMED_VOID' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 192,
			'OP01_OPEN' => 191,
			'OP23_LOGICAL_AND' => 190,
			'OP19_LOOP_CONTROL' => 189,
			'OP01_NAMED' => 200,
			'OP01_PRINT' => 204,
			'OP22_LOGICAL_NEG' => 201,
			'OP08_MATH_ADD_SUB' => 199,
			'OP11_COMPARE_LT_GT' => 196,
			'WORD' => 205,
			'OP01_CLOSE' => 195
		},
		GOTOS => {
			'OpStringOrWord' => 570
		}
	},
	{#State 563
		ACTIONS => {
			")" => 573,
			'OP21_LIST_COMMA' => 571
		},
		GOTOS => {
			'PAREN-26' => 572
		}
	},
	{#State 564
		DEFAULT => -185
	},
	{#State 565
		DEFAULT => -195
	},
	{#State 566
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP08_MATH_ADD_SUB' => 285,
			'OP11_COMPARE_LT_GT' => 293,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP09_BITWISE_SHIFT' => 286,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP12_COMPARE_EQ_NE' => 290,
			")" => -174,
			'OP16_LOGICAL_OR' => 289,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_STRING_REPEAT' => 291
		}
	},
	{#State 567
		ACTIONS => {
			")" => 574
		}
	},
	{#State 568
		DEFAULT => -175
	},
	{#State 569
		ACTIONS => {
			"}" => 575
		}
	},
	{#State 570
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 577,
			'OP19_VARIABLE_ASSIGN' => 576
		}
	},
	{#State 571
		ACTIONS => {
			'MY' => 578
		}
	},
	{#State 572
		DEFAULT => -63
	},
	{#State 573
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 579
		}
	},
	{#State 574
		ACTIONS => {
			'LBRACE' => 444
		},
		GOTOS => {
			'CodeBlock' => 580
		}
	},
	{#State 575
		ACTIONS => {
			";" => 581
		}
	},
	{#State 576
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'HASH_REF_SYMBOL' => 96,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'WORD_SCOPED' => 31,
			'HASH_SYMBOL' => 135,
			'OP05_MATH_NEG_LPAREN' => 141,
			'CONSTANT_CALL_SCOPED' => 140,
			"undef" => 146,
			'ARGV' => 145,
			'SELF' => 147,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'LPAREN' => 120,
			'SCALAR_SYMBOL' => 119,
			'OP22_LOGICAL_NEG' => 160,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'HashDereference' => 159,
			'ScalarVariable' => 177,
			'ArrayReferenceVariable' => 180,
			'HashVariable' => 178,
			'SubExpression' => 582,
			'ScalarLiteral' => 163,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceLiteral' => 149,
			'ArrayVariable' => 184,
			'HashReferenceLiteral' => 151,
			'Operator' => 129,
			'Hash' => 150,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'ArrayHashLiteral' => 102,
			'Array' => 136
		}
	},
	{#State 577
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 185,
			'ARRAY_REF_SYMBOL' => 134,
			'OP01_QW' => 98,
			'HASH_SYMBOL' => 135,
			'WORD_SCOPED' => 31,
			'CONSTANT_CALL_SCOPED' => 140,
			'OP05_MATH_NEG_LPAREN' => 141,
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'WORD' => 30,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 111,
			'ENV' => 155,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'LPAREN' => 120,
			'OP22_LOGICAL_NEG' => 160,
			'LITERAL_STRING' => 121,
			'OP03_MATH_INC_DEC' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'OP01_CLOSE' => 125,
			'LBRACKET' => 124,
			'OP05_LOGICAL_NEG' => 169
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 149,
			'ArrayReference' => 148,
			'ScalarVariableOrSelf' => 126,
			'HashRefLiteralEmpty' => 106,
			'WordScoped' => 166,
			'ArrayReferenceVariable' => 180,
			'ScalarVariable' => 177,
			'HashVariable' => 178,
			'ScalarLiteral' => 163,
			'SubExpression' => 583,
			'ArrayHashLiteralEmpty' => 104,
			'ArrayDereference' => 105,
			'HashDereference' => 159,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'Expression' => 179,
			'ArrayRefLiteralEmpty' => 99,
			'HashReference' => 112,
			'Scalar' => 156,
			'HashReferenceVariable' => 182,
			'ArrayVariable' => 184,
			'Operator' => 129,
			'HashReferenceLiteral' => 151,
			'Hash' => 150
		}
	},
	{#State 578
		ACTIONS => {
			'WORD' => 264,
			'WORD_SCOPED' => 262,
			'TYPE_INTEGER' => 260
		},
		GOTOS => {
			'Type' => 584
		}
	},
	{#State 579
		ACTIONS => {
			"\@ARG;" => 585
		}
	},
	{#State 580
		DEFAULT => -196
	},
	{#State 581
		ACTIONS => {
			"\@{" => -85,
			'ENV' => -85,
			'OP10_NAMED_UNARY' => -85,
			'LBRACE' => -85,
			'SCALAR_SYMBOL' => -85,
			'LPAREN' => -85,
			'OP01_OPEN' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			"}" => -85,
			'OP01_NAMED' => -85,
			'OP19_LOOP_CONTROL' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'LITERAL_STRING' => -85,
			'OP22_LOGICAL_NEG' => -85,
			"foreach" => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'LBRACKET' => -85,
			'OP01_CLOSE' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'WORD_UPPERCASE' => -85,
			"%{" => -85,
			'LPAREN_MY' => 587,
			'HASH_REF_SYMBOL' => -85,
			'LITERAL_NUMBER' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'WORD_SCOPED' => -85,
			'OP01_NAMED_VOID' => -85,
			"if" => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'HASH_SYMBOL' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			'OP01_QW' => -85,
			'SELF' => -85,
			"undef" => -85,
			'ARGV' => -85,
			'OP01_PRINT' => -85,
			'ARRAY_SYMBOL' => -85,
			'LPAREN_TYPE_INNER' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			"while" => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'MY' => -85,
			"for" => -85,
			'WORD' => -85,
			'POD' => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 588,
			'MethodArguments' => 586
		}
	},
	{#State 582
		ACTIONS => {
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285,
			'OP13_BITWISE_AND' => 287,
			'OP18_TERNARY' => 282,
			'OP21_LIST_COMMA' => -299,
			'OP09_BITWISE_SHIFT' => 286,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP17_LIST_RANGE' => 288,
			'OP04_MATH_POW' => 283,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			"}" => -299,
			'OP23_LOGICAL_AND' => 296,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP16_LOGICAL_OR' => 289,
			'OP08_STRING_CAT' => 284,
			'OP15_LOGICAL_AND' => 292,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP07_STRING_REPEAT' => 291
		}
	},
	{#State 583
		ACTIONS => {
			'OP16_LOGICAL_OR' => 289,
			'OP12_COMPARE_EQ_NE' => 290,
			'OP08_STRING_CAT' => 284,
			'OP24_LOGICAL_OR_XOR' => 281,
			'OP15_LOGICAL_AND' => 292,
			'OP07_STRING_REPEAT' => 291,
			"]" => 589,
			'OP07_MATH_MULT_DIV_MOD' => 295,
			'OP23_LOGICAL_AND' => 296,
			'OP18_TERNARY' => 282,
			'OP13_BITWISE_AND' => 287,
			'OP09_BITWISE_SHIFT' => 286,
			'OP17_LIST_RANGE' => 288,
			'OP14_BITWISE_OR_XOR' => 294,
			'OP04_MATH_POW' => 283,
			'OP06_REGEX_BIND' => 280,
			'OP11_COMPARE_LT_GT' => 293,
			'OP08_MATH_ADD_SUB' => 285
		}
	},
	{#State 584
		ACTIONS => {
			'SCALAR_SYMBOL' => 590
		}
	},
	{#State 585
		DEFAULT => -65
	},
	{#State 586
		DEFAULT => -84
	},
	{#State 587
		ACTIONS => {
			'WORD_SCOPED' => 262,
			'TYPE_INTEGER' => 260,
			'WORD' => 264
		},
		GOTOS => {
			'Type' => 591
		}
	},
	{#State 588
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 592
		}
	},
	{#State 589
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 593
		}
	},
	{#State 590
		DEFAULT => -62
	},
	{#State 591
		ACTIONS => {
			'SELF' => 594
		}
	},
	{#State 592
		ACTIONS => {
			'ARRAY_SYMBOL' => 142,
			'LPAREN_TYPE_INNER' => 103,
			'OP01_PRINT' => 143,
			'ARGV' => 145,
			"undef" => 146,
			'SELF' => 147,
			'MY' => 139,
			'CONSTANT_CALL_SCOPED' => 140,
			"while" => -178,
			'OP05_MATH_NEG_LPAREN' => 141,
			'WORD' => 30,
			'POD' => 107,
			"for" => -178,
			'HASH_REF_SYMBOL' => 96,
			"%{" => 132,
			'WORD_UPPERCASE' => 133,
			'OP22_LOGICAL_NEG_LPAREN' => 95,
			'OP01_NAMED_SCOLON' => 128,
			'LITERAL_NUMBER' => 94,
			'OP10_NAMED_UNARY_SCOLON' => 100,
			'HASH_SYMBOL' => 135,
			"if" => 101,
			'OP01_NAMED_VOID' => 138,
			'WORD_SCOPED' => 31,
			'OP01_QW' => 98,
			'ARRAY_REF_SYMBOL' => 134,
			'OP03_MATH_INC_DEC' => 162,
			'LITERAL_STRING' => 121,
			"foreach" => -178,
			'OP22_LOGICAL_NEG' => 160,
			'OP05_LOGICAL_NEG' => 169,
			'OP05_BITWISE_NEG_LPAREN' => 167,
			'LBRACKET' => 124,
			'OP01_CLOSE' => 125,
			'OP01_NAMED_VOID_LPAREN' => 168,
			'ENV' => 155,
			"\@{" => 111,
			'LBRACE' => 152,
			'OP10_NAMED_UNARY' => 110,
			"}" => 596,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'OP01_NAMED_VOID_SCOLON' => 158,
			'LPAREN' => 120,
			'OP01_OPEN' => 118,
			'SCALAR_SYMBOL' => 119,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED' => 157
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 99,
			'ArrayHashLiteral' => 102,
			'Array' => 136,
			'VariableModification' => 137,
			'ArrayVariable' => 130,
			'Operator' => 129,
			'Statement' => 127,
			'PAREN-47' => 131,
			'LoopLabel' => 97,
			'ArrayReference' => 148,
			'HashRefLiteralEmpty' => 106,
			'ArrayReferenceLiteral' => 149,
			'ArrayDereference' => 105,
			'ArrayHashLiteralEmpty' => 104,
			'VariableDeclaration' => 114,
			'Expression' => 115,
			'HashReference' => 112,
			'OPTIONAL-48' => 116,
			'Variable' => 109,
			'Hash' => 150,
			'HashReferenceLiteral' => 151,
			'Conditional' => 108,
			'OperatorVoid' => 154,
			'Scalar' => 156,
			'HashReferenceVariable' => 153,
			'ScalarVariableOrSelf' => 126,
			'WordScoped' => 166,
			'HashDereference' => 159,
			'SubExpression' => 164,
			'HashVariable' => 122,
			'ScalarLiteral' => 163,
			'ScalarVariable' => 123,
			'ArrayReferenceVariable' => 165,
			'Operation' => 595
		}
	},
	{#State 593
		ACTIONS => {
			"undef" => 597
		}
	},
	{#State 594
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 598
		}
	},
	{#State 595
		DEFAULT => -86
	},
	{#State 596
		DEFAULT => -88
	},
	{#State 597
		DEFAULT => -300
	},
	{#State 598
		ACTIONS => {
			'OP21_LIST_COMMA' => 600,
			")" => 599
		},
		GOTOS => {
			'PAREN-37' => 601
		}
	},
	{#State 599
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 602
		}
	},
	{#State 600
		ACTIONS => {
			'MY' => 603
		}
	},
	{#State 601
		DEFAULT => -90
	},
	{#State 602
		ACTIONS => {
			"\@ARG;" => 604
		}
	},
	{#State 603
		ACTIONS => {
			'WORD' => 264,
			'WORD_SCOPED' => 262,
			'TYPE_INTEGER' => 260
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
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11405 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 248 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11419 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 249 "lib/RPerl/Grammar.eyp"
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
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 252 "lib/RPerl/Grammar.eyp"
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
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11757 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11764 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
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
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11844 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
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
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11945 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
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
#line 264 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 264 "lib/RPerl/Grammar.eyp"
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
#line 317 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12680 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 2,
sub {
#line 317 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12687 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-62', 0,
sub {
#line 317 "lib/RPerl/Grammar.eyp"
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
#line 329 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 0,
sub {
#line 329 "lib/RPerl/Grammar.eyp"
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
#line 334 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 0,
sub {
#line 334 "lib/RPerl/Grammar.eyp"
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
#line 351 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12960 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 0,
sub {
#line 351 "lib/RPerl/Grammar.eyp"
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

#line 370 "lib/RPerl/Grammar.eyp"


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
