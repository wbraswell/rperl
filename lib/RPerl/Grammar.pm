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
    our $VERSION = 0.024_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|\$TYPED_|foreach|package|while|undef|elsif|\@ARG\;|INIT|else|for|\@\{|if|\%\{|\)|\;|\}|\])}gc and return ($1, $1);

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
  [ '_PLUS_LIST' => 'PLUS-55', [ 'PLUS-55', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-55', [ 'VariableRetrieval' ], 0 ],
  [ 'ScalarVariable_233' => 'ScalarVariable', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarVariable_234' => 'ScalarVariable', [ 'SCALAR_SYMBOL', 'PLUS-54' ], 0 ],
  [ 'ScalarVariable_235' => 'ScalarVariable', [ 'SELF' ], 0 ],
  [ 'ScalarVariable_236' => 'ScalarVariable', [ 'SELF', 'VariableRetrievalArrow' ], 0 ],
  [ 'ScalarVariable_237' => 'ScalarVariable', [ 'SELF', 'VariableRetrievalArrow', 'PLUS-55' ], 0 ],
  [ 'ArrayHashLiteral_238' => 'ArrayHashLiteral', [ 'LPAREN', 'ArrayHashLiteralEs', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-56', [ 'OP21_LIST_COMMA', 'ArrayHashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [ 'STAR-57', 'PAREN-56' ], 0 ],
  [ '_STAR_LIST' => 'STAR-57', [  ], 0 ],
  [ 'ArrayHashLiteralEs_242' => 'ArrayHashLiteralEs', [ 'ArrayHashLiteralE', 'STAR-57' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'ArrayLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'ArrayLiteralEs_246' => 'ArrayLiteralEs', [ 'ArrayLiteralE', 'STAR-59' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ 'OP21_LIST_COMMA', 'HashLiteralE' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'HashLiteralEs_250' => 'HashLiteralEs', [ 'HashLiteralE', 'STAR-61' ], 0 ],
  [ 'ArrayLiteralE_251' => 'ArrayLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayLiteralE_252' => 'ArrayLiteralE', [ 'ListElement' ], 0 ],
  [ 'HashLiteralE_253' => 'HashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'HashLiteralE_254' => 'HashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralE_255' => 'ArrayHashLiteralE', [ 'SubExpression' ], 0 ],
  [ 'ArrayHashLiteralE_256' => 'ArrayHashLiteralE', [ 'ListElement' ], 0 ],
  [ 'ArrayHashLiteralE_257' => 'ArrayHashLiteralE', [ 'HashEntry' ], 0 ],
  [ 'ArrayHashLiteralEmpty_258' => 'ArrayHashLiteralEmpty', [ 'LPAREN', ')' ], 0 ],
  [ 'ArrayRefLiteralEmpty_259' => 'ArrayRefLiteralEmpty', [ 'LBRACKET', ']' ], 0 ],
  [ 'HashRefLiteralEmpty_260' => 'HashRefLiteralEmpty', [ 'LBRACE', '}' ], 0 ],
  [ 'ListElement_261' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-62', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [ 'STAR-63', 'PAREN-62' ], 0 ],
  [ '_STAR_LIST' => 'STAR-63', [  ], 0 ],
  [ 'Array_265' => 'Array', [ 'LPAREN_TYPE_INNER', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression', 'STAR-63', ')' ], 0 ],
  [ 'Array_266' => 'Array', [ 'ArrayVariable' ], 0 ],
  [ 'ArrayVariable_267' => 'ArrayVariable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'ArrayVariable_268' => 'ArrayVariable', [ 'ARGV' ], 0 ],
  [ 'ArrayReference_269' => 'ArrayReference', [ 'ArrayReferenceLiteral' ], 0 ],
  [ 'ArrayReference_270' => 'ArrayReference', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'ArrayReferenceLiteral_271' => 'ArrayReferenceLiteral', [ 'LBRACKET', 'ArrayLiteralEs', ']' ], 0 ],
  [ 'ArrayReferenceLiteral_272' => 'ArrayReferenceLiteral', [ 'ArrayRefLiteralEmpty' ], 0 ],
  [ 'ArrayReferenceVariable_273' => 'ArrayReferenceVariable', [ 'ARRAY_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-64', [  ], 0 ],
  [ 'ArrayDereference_276' => 'ArrayDereference', [ '@{', 'ScalarVariable', '}' ], 0 ],
  [ 'ArrayDereference_277' => 'ArrayDereference', [ '@{', 'OPTIONAL-64', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-65', [  ], 0 ],
  [ 'HashEntry_280' => 'HashEntry', [ 'ScaVarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-65', 'SubExpression' ], 0 ],
  [ 'HashEntryProperties_281' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ 'Hash_282' => 'Hash', [ 'HashVariable' ], 0 ],
  [ 'HashVariable_283' => 'HashVariable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'HashVariable_284' => 'HashVariable', [ 'ENV' ], 0 ],
  [ 'HashReference_285' => 'HashReference', [ 'HashReferenceLiteral' ], 0 ],
  [ 'HashReference_286' => 'HashReference', [ 'HashReferenceVariable' ], 0 ],
  [ 'HashReferenceLiteral_287' => 'HashReferenceLiteral', [ 'LBRACE', 'HashLiteralEs', '}' ], 0 ],
  [ 'HashReferenceLiteral_288' => 'HashReferenceLiteral', [ 'HashRefLiteralEmpty' ], 0 ],
  [ 'HashReferenceVariable_289' => 'HashReferenceVariable', [ 'HASH_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-66', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-66', [  ], 0 ],
  [ 'HashDereference_292' => 'HashDereference', [ '%{', 'ScalarVariable', '}' ], 0 ],
  [ 'HashDereference_293' => 'HashDereference', [ '%{', 'OPTIONAL-66', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_294' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_295' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_296' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_297' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_298' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_299' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_300' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_301' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_302' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_303' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'ScalarVariableOrLiteral_304' => 'ScalarVariableOrLiteral', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarVariableOrLiteral_305' => 'ScalarVariableOrLiteral', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_306' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarVariable' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_307' => 'ScaVarOrLitOrOpStrOrWord', [ 'ScalarLiteral' ], 0 ],
  [ 'ScaVarOrLitOrOpStrOrWord_308' => 'ScaVarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'OpNamedScolonOrSubExp_309' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_310' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_311' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_312' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_313' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_314' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_315' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_316' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_317' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_318' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_319' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_320' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_321' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_322' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_323' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_324' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_325' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_326' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_327' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_328' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_329' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_330' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_331' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PLUS_LIST' => 231,
  '_PLUS_LIST' => 232,
  'ScalarVariable_233' => 233,
  'ScalarVariable_234' => 234,
  'ScalarVariable_235' => 235,
  'ScalarVariable_236' => 236,
  'ScalarVariable_237' => 237,
  'ArrayHashLiteral_238' => 238,
  '_PAREN' => 239,
  '_STAR_LIST' => 240,
  '_STAR_LIST' => 241,
  'ArrayHashLiteralEs_242' => 242,
  '_PAREN' => 243,
  '_STAR_LIST' => 244,
  '_STAR_LIST' => 245,
  'ArrayLiteralEs_246' => 246,
  '_PAREN' => 247,
  '_STAR_LIST' => 248,
  '_STAR_LIST' => 249,
  'HashLiteralEs_250' => 250,
  'ArrayLiteralE_251' => 251,
  'ArrayLiteralE_252' => 252,
  'HashLiteralE_253' => 253,
  'HashLiteralE_254' => 254,
  'ArrayHashLiteralE_255' => 255,
  'ArrayHashLiteralE_256' => 256,
  'ArrayHashLiteralE_257' => 257,
  'ArrayHashLiteralEmpty_258' => 258,
  'ArrayRefLiteralEmpty_259' => 259,
  'HashRefLiteralEmpty_260' => 260,
  'ListElement_261' => 261,
  '_PAREN' => 262,
  '_STAR_LIST' => 263,
  '_STAR_LIST' => 264,
  'Array_265' => 265,
  'Array_266' => 266,
  'ArrayVariable_267' => 267,
  'ArrayVariable_268' => 268,
  'ArrayReference_269' => 269,
  'ArrayReference_270' => 270,
  'ArrayReferenceLiteral_271' => 271,
  'ArrayReferenceLiteral_272' => 272,
  'ArrayReferenceVariable_273' => 273,
  '_OPTIONAL' => 274,
  '_OPTIONAL' => 275,
  'ArrayDereference_276' => 276,
  'ArrayDereference_277' => 277,
  '_OPTIONAL' => 278,
  '_OPTIONAL' => 279,
  'HashEntry_280' => 280,
  'HashEntryProperties_281' => 281,
  'Hash_282' => 282,
  'HashVariable_283' => 283,
  'HashVariable_284' => 284,
  'HashReference_285' => 285,
  'HashReference_286' => 286,
  'HashReferenceLiteral_287' => 287,
  'HashReferenceLiteral_288' => 288,
  'HashReferenceVariable_289' => 289,
  '_OPTIONAL' => 290,
  '_OPTIONAL' => 291,
  'HashDereference_292' => 292,
  'HashDereference_293' => 293,
  'WordScoped_294' => 294,
  'WordScoped_295' => 295,
  'LoopLabel_296' => 296,
  'Type_297' => 297,
  'Type_298' => 298,
  'Type_299' => 299,
  'TypeInner_300' => 300,
  'TypeInnerProperties_301' => 301,
  'TypeInnerProperties_302' => 302,
  'TypeInnerConstant_303' => 303,
  'ScalarVariableOrLiteral_304' => 304,
  'ScalarVariableOrLiteral_305' => 305,
  'ScaVarOrLitOrOpStrOrWord_306' => 306,
  'ScaVarOrLitOrOpStrOrWord_307' => 307,
  'ScaVarOrLitOrOpStrOrWord_308' => 308,
  'OpNamedScolonOrSubExp_309' => 309,
  'OpNamedScolonOrSubExp_310' => 310,
  'OpNamedScolonOrSubExp_311' => 311,
  'OpNamedScolonOrSubExpIn_312' => 312,
  'OpNamedScolonOrSubExpIn_313' => 313,
  'OpNamedScolonOrSubExpIn_314' => 314,
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
  'OpStringOrWord_331' => 331,
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
			"package" => -20,
			'USE_RPERL' => -20,
			'SHEBANG' => 9,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Program' => 1,
			'Critic' => 3,
			'PAREN-1' => 5,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 2,
			'CompileUnit' => 8,
			'PLUS-2' => 6
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 10
		},
		GOTOS => {
			'OPTIONAL-10' => 11
		}
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			"INIT" => -27,
			"## no critic qw(" => -27,
			"use parent qw(" => 14,
			"use parent -norequire, qw(" => 13,
			'USE' => -27,
			"use constant" => -27,
			'USE_EXPORTER' => -27,
			'SUB' => -27
		},
		GOTOS => {
			'Module' => 16,
			'UseParent' => 18,
			'STAR-11' => 15,
			'Package' => 17,
			'Class' => 12
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 3,
			'ModuleHeader' => 4,
			'PAREN-1' => 19,
			'OPTIONAL-9' => 2
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-17' => 21
		}
	},
	{#State 8
		ACTIONS => {
			'' => 22
		}
	},
	{#State 9
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 24,
			'OPTIONAL-3' => 23
		}
	},
	{#State 10
		DEFAULT => -21
	},
	{#State 11
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		DEFAULT => -78
	},
	{#State 14
		DEFAULT => -77
	},
	{#State 15
		ACTIONS => {
			"use constant" => -29,
			"## no critic qw(" => 7,
			"INIT" => -29,
			'USE' => -29,
			'SUB' => -29,
			'USE_EXPORTER' => 29
		},
		GOTOS => {
			'Exports' => 27,
			'OPTIONAL-12' => 28,
			'Critic' => 26
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -24
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 30
		}
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => -41
	},
	{#State 21
		ACTIONS => {
			")" => 33,
			'WORD' => 34
		}
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		ACTIONS => {
			'USE_RPERL' => 35
		}
	},
	{#State 24
		DEFAULT => -6
	},
	{#State 25
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 26
		DEFAULT => -26
	},
	{#State 27
		DEFAULT => -28
	},
	{#State 28
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'OUR_EXPORT' => 40,
			"INIT" => -45,
			'OUR_EXPORT_OK' => -45,
			'SUB' => -45,
			'USE' => -45,
			"our hashref \$properties" => -45,
			"use constant" => -45
		},
		GOTOS => {
			'PAREN-18' => 38,
			'OPTIONAL-19' => 39
		}
	},
	{#State 30
		ACTIONS => {
			")" => 41
		}
	},
	{#State 31
		DEFAULT => -294
	},
	{#State 32
		DEFAULT => -295
	},
	{#State 33
		DEFAULT => -42
	},
	{#State 34
		DEFAULT => -40
	},
	{#State 35
		ACTIONS => {
			"use strict;" => 42
		},
		GOTOS => {
			'Header' => 43
		}
	},
	{#State 36
		ACTIONS => {
			";" => 44
		}
	},
	{#State 37
		ACTIONS => {
			'USE' => 48,
			"INIT" => 45,
			"use constant" => -33,
			'SUB' => -33
		},
		GOTOS => {
			'Include' => 46,
			'STAR-14' => 47
		}
	},
	{#State 38
		DEFAULT => -44
	},
	{#State 39
		ACTIONS => {
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 50,
			"use constant" => -48,
			"INIT" => -48,
			'USE' => -48,
			'SUB' => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 49,
			'PAREN-20' => 51
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 52
		}
	},
	{#State 41
		ACTIONS => {
			";" => 53
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
			'LBRACE' => 57
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			"use constant" => 61,
			'SUB' => 62
		},
		GOTOS => {
			'Subroutine' => 60,
			'Constant' => 58,
			'PLUS-15' => 59
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 63
		}
	},
	{#State 49
		DEFAULT => -49
	},
	{#State 50
		ACTIONS => {
			'OP01_QW' => 64
		}
	},
	{#State 51
		DEFAULT => -47
	},
	{#State 52
		ACTIONS => {
			";" => 65
		}
	},
	{#State 53
		ACTIONS => {
			'USE' => 48,
			"INIT" => 45
		},
		GOTOS => {
			'Include' => 66
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
			'LBRACKET' => -11,
			'POD' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'LPAREN' => -11,
			'LBRACE' => -11,
			'HASH_REF_SYMBOL' => -11,
			'WORD_SCOPED' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'MY' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LPAREN_TYPE_INNER' => -11,
			'OP01_NAMED' => -11,
			'OP01_QW' => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'ARGV' => -11,
			'SUB' => -11,
			"for" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"%{" => -11,
			'HASH_SYMBOL' => -11,
			"use constant" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'ARRAY_REF_SYMBOL' => -11,
			"INIT" => -11,
			"## no critic qw(" => 7,
			'OP05_LOGICAL_NEG' => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_NUMBER' => -11,
			"foreach" => -11,
			'WORD' => -11,
			'USE' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'ENV' => -11,
			'SELF' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"while" => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"undef" => -11,
			'OP01_PRINT' => -11,
			'OP10_NAMED_UNARY' => -11,
			'ARRAY_SYMBOL' => -11,
			'SCALAR_SYMBOL' => -11,
			"if" => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'OP01_NAMED_SCOLON' => -11
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
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 71
		}
	},
	{#State 58
		DEFAULT => -32
	},
	{#State 59
		ACTIONS => {
			'LITERAL_NUMBER' => 72,
			'SUB' => 62
		},
		GOTOS => {
			'Subroutine' => 73
		}
	},
	{#State 60
		DEFAULT => -35
	},
	{#State 61
		ACTIONS => {
			'WORD_UPPERCASE' => 74
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 75
		}
	},
	{#State 63
		ACTIONS => {
			";" => -51,
			'OP01_QW' => 77
		},
		GOTOS => {
			'OPTIONAL-22' => 76
		}
	},
	{#State 64
		ACTIONS => {
			";" => 78
		}
	},
	{#State 65
		DEFAULT => -43
	},
	{#State 66
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 79
		}
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
			"undef" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'ARRAY_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'SCALAR_SYMBOL' => -13,
			"if" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'USE' => 48,
			'ENV' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'WORD' => -13,
			"foreach" => -13,
			'LITERAL_NUMBER' => -13,
			"\@{" => -13,
			'SELF' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"while" => -13,
			"%{" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"for" => -13,
			"use constant" => -13,
			'HASH_SYMBOL' => -13,
			'ARGV' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'SUB' => -13,
			"INIT" => 45,
			'OP05_LOGICAL_NEG' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'ARRAY_REF_SYMBOL' => -13,
			'LPAREN' => -13,
			'HASH_REF_SYMBOL' => -13,
			'LBRACE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'POD' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED' => -13,
			'LPAREN_TYPE_INNER' => -13,
			'OP01_OPEN' => -13,
			'OP01_QW' => -13,
			'WORD_SCOPED' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_STRING' => -13,
			'OP03_MATH_INC_DEC' => -13
		},
		GOTOS => {
			'Include' => 82,
			'STAR-6' => 81
		}
	},
	{#State 70
		DEFAULT => -8
	},
	{#State 71
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 83
		}
	},
	{#State 72
		ACTIONS => {
			";" => 84
		}
	},
	{#State 73
		DEFAULT => -34
	},
	{#State 74
		ACTIONS => {
			'OP20_HASH_FATARROW' => 85
		}
	},
	{#State 75
		ACTIONS => {
			'LBRACE' => 86
		}
	},
	{#State 76
		ACTIONS => {
			";" => 87
		}
	},
	{#State 77
		DEFAULT => -50
	},
	{#State 78
		DEFAULT => -46
	},
	{#State 79
		ACTIONS => {
			"our hashref \$properties" => -69,
			"## no critic qw(" => 7,
			"use constant" => -69,
			'USE' => -69,
			"INIT" => -69,
			'USE_EXPORTER' => 29
		},
		GOTOS => {
			'Critic' => 88,
			'Exports' => 90,
			'OPTIONAL-29' => 89
		}
	},
	{#State 80
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 91
		}
	},
	{#State 81
		ACTIONS => {
			'ARRAY_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_PRINT' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"if" => -15,
			'SCALAR_SYMBOL' => -15,
			'ENV' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"foreach" => -15,
			'WORD' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_UPPERCASE' => -15,
			"\@{" => -15,
			"while" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'SELF' => -15,
			"use constant" => 61,
			'HASH_SYMBOL' => -15,
			"%{" => -15,
			"for" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'SUB' => -15,
			'ARGV' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'HASH_REF_SYMBOL' => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'POD' => -15,
			'LBRACKET' => -15,
			'OP01_OPEN' => -15,
			'OP01_QW' => -15,
			'OP01_NAMED' => -15,
			'LPAREN_TYPE_INNER' => -15,
			'MY' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15
		},
		GOTOS => {
			'STAR-7' => 93,
			'Constant' => 92
		}
	},
	{#State 82
		DEFAULT => -10
	},
	{#State 83
		ACTIONS => {
			'OP01_QW' => 94,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 95
		}
	},
	{#State 84
		DEFAULT => -36
	},
	{#State 85
		ACTIONS => {
			'MY' => 96
		},
		GOTOS => {
			'TypeInnerConstant' => 97
		}
	},
	{#State 86
		ACTIONS => {
			'LBRACE' => 98
		}
	},
	{#State 87
		DEFAULT => -54
	},
	{#State 88
		DEFAULT => -66
	},
	{#State 89
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 99
		}
	},
	{#State 90
		DEFAULT => -68
	},
	{#State 91
		DEFAULT => -39
	},
	{#State 92
		DEFAULT => -12
	},
	{#State 93
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_NAMED_VOID' => 156,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'MY' => 112,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 153,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LBRACKET' => 162,
			'POD' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'OP19_LOOP_CONTROL' => 149,
			'ARGV' => 106,
			'SUB' => 62,
			"for" => -178,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'SELF' => 131,
			"while" => -178,
			'OP01_NAMED_VOID_LPAREN' => 172,
			"\@{" => 130,
			'WORD_UPPERCASE' => 175,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"foreach" => -178,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SCALAR_SYMBOL' => 165,
			"if" => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 164,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			"undef" => 170,
			'OP01_PRINT' => 166,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167
		},
		GOTOS => {
			'ArrayReference' => 105,
			'Hash' => 104,
			'VariableDeclaration' => 103,
			'HashReference' => 147,
			'OperatorVoid' => 144,
			'Expression' => 101,
			'ArrayHashLiteralEmpty' => 142,
			'Variable' => 141,
			'VariableModification' => 163,
			'Statement' => 116,
			'WordScoped' => 161,
			'Subroutine' => 157,
			'HashVariable' => 115,
			'HashReferenceVariable' => 114,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'HashDereference' => 129,
			'LoopLabel' => 168,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 127,
			'SubExpression' => 125,
			'ScalarVariable' => 122,
			'Array' => 123,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'Operation' => 139,
			'Conditional' => 140,
			'ArrayReferenceVariable' => 174,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'PLUS-8' => 132,
			'PAREN-47' => 173,
			'OPTIONAL-48' => 171
		}
	},
	{#State 94
		DEFAULT => -52
	},
	{#State 95
		ACTIONS => {
			")" => 176
		}
	},
	{#State 96
		ACTIONS => {
			'WORD_SCOPED' => 179,
			'WORD' => 178,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 180
		}
	},
	{#State 97
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 154
		},
		GOTOS => {
			'ScalarLiteral' => 181
		}
	},
	{#State 98
		ACTIONS => {
			'MY' => 182
		}
	},
	{#State 99
		ACTIONS => {
			'USE' => 48,
			"INIT" => 45,
			"our hashref \$properties" => -73,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 183,
			'STAR-31' => 184
		}
	},
	{#State 100
		ACTIONS => {
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154
		},
		GOTOS => {
			'SubExpression' => 193,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 101
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -156,
			'OP13_BITWISE_AND' => -156,
			";" => 194,
			'OP17_LIST_RANGE' => -156,
			'OP07_MATH_MULT_DIV_MOD' => -156,
			'OP12_COMPARE_EQ_NE' => -156,
			'OP09_BITWISE_SHIFT' => -156,
			'OP08_STRING_CAT' => -156,
			'OP24_LOGICAL_OR_XOR' => -156,
			'OP14_BITWISE_OR_XOR' => -156,
			'OP16_LOGICAL_OR' => -156,
			'OP18_TERNARY' => -156,
			'OP07_STRING_REPEAT' => -156,
			'OP11_COMPARE_LT_GT' => -156,
			'OP04_MATH_POW' => -156,
			'OP23_LOGICAL_AND' => -156,
			'OP06_REGEX_BIND' => -156,
			'OP15_LOGICAL_AND' => -156
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 195,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190
		}
	},
	{#State 103
		DEFAULT => -182
	},
	{#State 104
		DEFAULT => -164
	},
	{#State 105
		DEFAULT => -162
	},
	{#State 106
		DEFAULT => -268
	},
	{#State 107
		DEFAULT => -150
	},
	{#State 108
		DEFAULT => -158
	},
	{#State 109
		ACTIONS => {
			'MY' => 196
		}
	},
	{#State 110
		ACTIONS => {
			'OP07_STRING_REPEAT' => 199,
			'OP22_LOGICAL_NEG' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP23_LOGICAL_AND' => 205,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP19_LOOP_CONTROL' => 206,
			'OP10_NAMED_UNARY' => 209,
			'OP01_PRINT' => 200,
			'OP01_NAMED' => 202,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_OPEN' => 211,
			'OP01_NAMED_VOID' => 203,
			'OP01_CLOSE' => 212,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'WORD' => 198,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 197
		},
		GOTOS => {
			'OpStringOrWord' => 208
		}
	},
	{#State 111
		ACTIONS => {
			'FHREF_SYMBOL' => 215
		}
	},
	{#State 112
		ACTIONS => {
			'TYPE_FHREF' => 216,
			'TYPE_INTEGER' => 177,
			'WORD_SCOPED' => 179,
			'WORD' => 178
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 113
		DEFAULT => -138
	},
	{#State 114
		ACTIONS => {
			'OP13_BITWISE_AND' => -286,
			'OP08_MATH_ADD_SUB' => -286,
			")" => -286,
			'OP08_STRING_CAT' => -286,
			'OP24_LOGICAL_OR_XOR' => -286,
			'OP09_BITWISE_SHIFT' => -286,
			'OP12_COMPARE_EQ_NE' => -286,
			'OP14_BITWISE_OR_XOR' => -286,
			'OP16_LOGICAL_OR' => -286,
			'OP17_LIST_RANGE' => -286,
			'OP19_VARIABLE_ASSIGN' => -207,
			'OP07_MATH_MULT_DIV_MOD' => -286,
			'OP19_VARIABLE_ASSIGN_BY' => -207,
			'OP11_COMPARE_LT_GT' => -286,
			'OP18_TERNARY' => -286,
			'OP07_STRING_REPEAT' => -286,
			'OP15_LOGICAL_AND' => -286,
			'OP06_REGEX_BIND' => -286,
			'OP23_LOGICAL_AND' => -286,
			'OP04_MATH_POW' => -286
		}
	},
	{#State 115
		ACTIONS => {
			'OP04_MATH_POW' => -282,
			'OP23_LOGICAL_AND' => -282,
			'OP06_REGEX_BIND' => -282,
			'OP15_LOGICAL_AND' => -282,
			'OP07_STRING_REPEAT' => -282,
			'OP18_TERNARY' => -282,
			'OP11_COMPARE_LT_GT' => -282,
			'OP19_VARIABLE_ASSIGN_BY' => -206,
			'OP07_MATH_MULT_DIV_MOD' => -282,
			'OP19_VARIABLE_ASSIGN' => -206,
			'OP17_LIST_RANGE' => -282,
			'OP16_LOGICAL_OR' => -282,
			'OP14_BITWISE_OR_XOR' => -282,
			'OP09_BITWISE_SHIFT' => -282,
			'OP12_COMPARE_EQ_NE' => -282,
			'OP08_STRING_CAT' => -282,
			")" => -282,
			'OP24_LOGICAL_OR_XOR' => -282,
			'OP08_MATH_ADD_SUB' => -282,
			'OP13_BITWISE_AND' => -282
		}
	},
	{#State 116
		DEFAULT => -98
	},
	{#State 117
		DEFAULT => -184
	},
	{#State 118
		DEFAULT => -152
	},
	{#State 119
		DEFAULT => -272
	},
	{#State 120
		DEFAULT => -225
	},
	{#State 121
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'SubExpression' => 218,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147
		}
	},
	{#State 122
		ACTIONS => {
			'OP15_LOGICAL_AND' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP04_MATH_POW' => -226,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP11_COMPARE_LT_GT' => -226,
			'OP18_TERNARY' => -226,
			'OP07_STRING_REPEAT' => -226,
			'OP02_METHOD_THINARROW' => 219,
			'OP24_LOGICAL_OR_XOR' => -226,
			")" => -226,
			'OP08_STRING_CAT' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP19_VARIABLE_ASSIGN' => -203,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP03_MATH_INC_DEC' => 220,
			'OP13_BITWISE_AND' => -226,
			'OP08_MATH_ADD_SUB' => -226
		}
	},
	{#State 123
		DEFAULT => -161
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 221
		}
	},
	{#State 125
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226
		}
	},
	{#State 126
		DEFAULT => -285
	},
	{#State 127
		ACTIONS => {
			'OP04_MATH_POW' => -266,
			'OP23_LOGICAL_AND' => -266,
			'OP15_LOGICAL_AND' => -266,
			'OP06_REGEX_BIND' => -266,
			'OP07_STRING_REPEAT' => -266,
			'OP18_TERNARY' => -266,
			'OP11_COMPARE_LT_GT' => -266,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP07_MATH_MULT_DIV_MOD' => -266,
			'OP19_VARIABLE_ASSIGN' => -204,
			'OP17_LIST_RANGE' => -266,
			'OP16_LOGICAL_OR' => -266,
			'OP14_BITWISE_OR_XOR' => -266,
			'OP09_BITWISE_SHIFT' => -266,
			'OP12_COMPARE_EQ_NE' => -266,
			")" => -266,
			'OP24_LOGICAL_OR_XOR' => -266,
			'OP08_STRING_CAT' => -266,
			'OP08_MATH_ADD_SUB' => -266,
			'OP13_BITWISE_AND' => -266
		}
	},
	{#State 128
		ACTIONS => {
			'WORD_UPPERCASE' => 187,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'LITERAL_NUMBER' => 138,
			'OP09_BITWISE_SHIFT' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP17_LIST_RANGE' => -118,
			'ENV' => 134,
			'SELF' => 131,
			'OP21_LIST_COMMA' => -118,
			";" => -118,
			'OP13_BITWISE_AND' => -118,
			"\@{" => 130,
			"undef" => 170,
			'OP06_REGEX_BIND' => -118,
			'OP15_LOGICAL_AND' => -118,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SCALAR_SYMBOL' => 165,
			"}" => -118,
			'OP07_STRING_REPEAT' => -118,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP18_TERNARY' => -118,
			'LBRACKET' => 162,
			'OP16_LOGICAL_OR' => -118,
			'CONSTANT_CALL_SCOPED' => 118,
			")" => -118,
			'OP08_STRING_CAT' => -118,
			'LPAREN' => 160,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			"]" => -118,
			'OP01_QW' => 150,
			'OP08_MATH_ADD_SUB' => -118,
			'OP01_OPEN' => 109,
			'ARGV' => 106,
			'OP23_LOGICAL_AND' => -118,
			'OP05_MATH_NEG_LPAREN' => 146,
			'OP04_MATH_POW' => -118,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP11_COMPARE_LT_GT' => -118,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 239,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191
		}
	},
	{#State 129
		DEFAULT => -166
	},
	{#State 130
		ACTIONS => {
			'MY' => 243,
			'ARRAY_REF_SYMBOL' => -275,
			'LBRACKET' => -275,
			'SCALAR_SYMBOL' => 165,
			'SELF' => 131
		},
		GOTOS => {
			'OPTIONAL-64' => 242,
			'ScalarVariable' => 241,
			'TypeInner' => 240
		}
	},
	{#State 131
		ACTIONS => {
			'OP02_HASH_THINARROW' => 245,
			'OP15_LOGICAL_AND' => -235,
			'OP06_REGEX_BIND' => -235,
			'OP23_LOGICAL_AND' => -235,
			'OP04_MATH_POW' => -235,
			'OP19_VARIABLE_ASSIGN_BY' => -235,
			'OP11_COMPARE_LT_GT' => -235,
			"}" => -235,
			'OP18_TERNARY' => -235,
			'OP07_STRING_REPEAT' => -235,
			'OP02_METHOD_THINARROW' => -235,
			")" => -235,
			'OP08_STRING_CAT' => -235,
			'OP24_LOGICAL_OR_XOR' => -235,
			'OP12_COMPARE_EQ_NE' => -235,
			'OP09_BITWISE_SHIFT' => -235,
			'OP14_BITWISE_OR_XOR' => -235,
			'OP16_LOGICAL_OR' => -235,
			'OP17_LIST_RANGE' => -235,
			'OP19_VARIABLE_ASSIGN' => -235,
			'COLON' => -235,
			'OP07_MATH_MULT_DIV_MOD' => -235,
			";" => -235,
			'OP21_LIST_COMMA' => -235,
			'OP03_MATH_INC_DEC' => -235,
			'OP13_BITWISE_AND' => -235,
			'OP20_HASH_FATARROW' => -235,
			"]" => -235,
			'OP02_ARRAY_THINARROW' => 246,
			'OP08_MATH_ADD_SUB' => -235
		},
		GOTOS => {
			'VariableRetrievalArrow' => 244
		}
	},
	{#State 132
		ACTIONS => {
			"\@{" => 130,
			"while" => -178,
			'OP01_NAMED_VOID_LPAREN' => 172,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"foreach" => -178,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED_SCOLON' => 164,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			"if" => 124,
			'' => -18,
			'SCALAR_SYMBOL' => 165,
			'OP01_PRINT' => 166,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			"undef" => 170,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 153,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'MY' => 112,
			'OP01_NAMED_VOID' => 156,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'WORD_SCOPED' => 32,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'POD' => 117,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"for" => -178,
			"%{" => 148,
			'OP19_LOOP_CONTROL' => 149,
			'ARGV' => 106
		},
		GOTOS => {
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'SubExpression' => 125,
			'Array' => 123,
			'ScalarVariable' => 122,
			'ArrayVariable' => 127,
			'HashReferenceLiteral' => 126,
			'LoopLabel' => 168,
			'HashDereference' => 129,
			'OPTIONAL-48' => 171,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 174,
			'ArrayReferenceLiteral' => 135,
			'PAREN-47' => 173,
			'Conditional' => 140,
			'Operation' => 247,
			'ArrayHashLiteralEmpty' => 142,
			'Variable' => 141,
			'OperatorVoid' => 144,
			'Expression' => 101,
			'HashReference' => 147,
			'VariableDeclaration' => 103,
			'ArrayReference' => 105,
			'Hash' => 104,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'HashVariable' => 115,
			'HashReferenceVariable' => 114,
			'VariableModification' => 163,
			'Statement' => 116,
			'WordScoped' => 161
		}
	},
	{#State 133
		ACTIONS => {
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'SubExpression' => 248,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123
		}
	},
	{#State 134
		DEFAULT => -284
	},
	{#State 135
		DEFAULT => -269
	},
	{#State 136
		DEFAULT => -288
	},
	{#State 137
		DEFAULT => -97
	},
	{#State 138
		DEFAULT => -227
	},
	{#State 139
		DEFAULT => -17
	},
	{#State 140
		DEFAULT => -179
	},
	{#State 141
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 249,
			'OP19_VARIABLE_ASSIGN_BY' => 250
		}
	},
	{#State 142
		DEFAULT => -159
	},
	{#State 143
		DEFAULT => -273
	},
	{#State 144
		DEFAULT => -181
	},
	{#State 145
		DEFAULT => -283
	},
	{#State 146
		ACTIONS => {
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'WORD_SCOPED' => 32,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 251,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147
		}
	},
	{#State 147
		DEFAULT => -165
	},
	{#State 148
		ACTIONS => {
			'SELF' => 131,
			'SCALAR_SYMBOL' => 165,
			'MY' => 243,
			'HASH_REF_SYMBOL' => -291,
			'LBRACE' => -291
		},
		GOTOS => {
			'OPTIONAL-66' => 253,
			'ScalarVariable' => 254,
			'TypeInner' => 252
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_UPPERCASE' => 256
		},
		GOTOS => {
			'LoopLabel' => 255
		}
	},
	{#State 150
		DEFAULT => -100
	},
	{#State 151
		DEFAULT => -160
	},
	{#State 152
		DEFAULT => -163
	},
	{#State 153
		ACTIONS => {
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'ARGV' => 106,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 257,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142
		}
	},
	{#State 154
		DEFAULT => -228
	},
	{#State 155
		ACTIONS => {
			'SCALAR_SYMBOL' => 165,
			'SELF' => 131
		},
		GOTOS => {
			'ScalarVariable' => 258
		}
	},
	{#State 156
		ACTIONS => {
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131
		},
		GOTOS => {
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Array' => 123,
			'SubExpressions' => 260,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 259,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'WordScoped' => 161
		}
	},
	{#State 157
		DEFAULT => -14
	},
	{#State 158
		DEFAULT => -289
	},
	{#State 159
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 264,
			'ARRAY_REF_SYMBOL' => 143,
			'OP11_COMPARE_LT_GT' => 213,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 206,
			"%{" => 148,
			'OP23_LOGICAL_AND' => 205,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'WORD_SCOPED' => 32,
			'OP01_NAMED_VOID' => 203,
			'OP01_CLOSE' => 262,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_NAMED' => 271,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 261,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_QW' => 150,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'SCALAR_SYMBOL' => 165,
			"}" => 275,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP07_STRING_REPEAT' => 199,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 266,
			'ARRAY_SYMBOL' => 167,
			'OP01_PRINT' => 200,
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'OP12_COMPARE_EQ_NE' => 207,
			'WORD' => 273,
			'LITERAL_NUMBER' => 138,
			'OP24_LOGICAL_OR_XOR' => 197,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133
		},
		GOTOS => {
			'HashEntry' => 274,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashLiteralEs' => 270,
			'WordScoped' => 161,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 267,
			'HashLiteralE' => 272,
			'SubExpression' => 268,
			'Expression' => 188,
			'ScalarVariable' => 269,
			'Array' => 123,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'ArrayVariable' => 191,
			'OpStringOrWord' => 265,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104
		}
	},
	{#State 160
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 264,
			'ARRAY_REF_SYMBOL' => 143,
			'OP11_COMPARE_LT_GT' => 213,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 206,
			"%{" => 148,
			'OP23_LOGICAL_AND' => 205,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'WORD_SCOPED' => 32,
			'MY' => 243,
			'OP01_NAMED_VOID' => 203,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 262,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_NAMED' => 280,
			'LPAREN_TYPE_INNER' => 110,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_OPEN' => 261,
			'OP01_QW' => 150,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			")" => 277,
			'LPAREN' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP07_STRING_REPEAT' => 199,
			"undef" => 170,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 266,
			'OP01_PRINT' => 284,
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'WORD' => 273,
			'OP12_COMPARE_EQ_NE' => 207,
			'LITERAL_NUMBER' => 138,
			'OP24_LOGICAL_OR_XOR' => 197,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133
		},
		GOTOS => {
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReference' => 147,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'ListElement' => 279,
			'ArrayHashLiteralE' => 283,
			'OpStringOrWord' => 265,
			'SubExpression' => 278,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 269,
			'ScalarLiteral' => 267,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayHashLiteralEs' => 276,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'TypeInner' => 281,
			'HashEntry' => 282,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107
		}
	},
	{#State 161
		ACTIONS => {
			'LPAREN' => 286,
			'OP02_METHOD_THINARROW_NEW' => 285
		}
	},
	{#State 162
		ACTIONS => {
			'SELF' => 131,
			"\@{" => 130,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'MY' => 243,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			"]" => 290,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'ArrayLiteralEs' => 291,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'ArrayLiteralE' => 287,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashVariable' => 190,
			'TypeInner' => 281,
			'HashReferenceVariable' => 189,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ListElement' => 288,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'SubExpression' => 289,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123
		}
	},
	{#State 163
		ACTIONS => {
			";" => 292
		}
	},
	{#State 164
		DEFAULT => -96
	},
	{#State 165
		ACTIONS => {
			'OP20_HASH_FATARROW' => -233,
			'OP13_BITWISE_AND' => -233,
			'OP21_LIST_COMMA' => -233,
			";" => -233,
			'OP17_LIST_RANGE' => -233,
			'OP09_BITWISE_SHIFT' => -233,
			'OP12_COMPARE_EQ_NE' => -233,
			'OP24_LOGICAL_OR_XOR' => -233,
			'OP14_BITWISE_OR_XOR' => -233,
			'OP18_TERNARY' => -233,
			'OP07_STRING_REPEAT' => -233,
			"}" => -233,
			'OP06_REGEX_BIND' => -233,
			'OP15_LOGICAL_AND' => -233,
			'OP08_MATH_ADD_SUB' => -233,
			'OP02_ARRAY_THINARROW' => 246,
			"]" => -233,
			'OP03_MATH_INC_DEC' => -233,
			'OP19_VARIABLE_ASSIGN' => -233,
			'LBRACE' => 294,
			'OP07_MATH_MULT_DIV_MOD' => -233,
			'COLON' => -233,
			")" => -233,
			'OP08_STRING_CAT' => -233,
			'OP16_LOGICAL_OR' => -233,
			'LBRACKET' => 293,
			'OP02_METHOD_THINARROW' => -233,
			'OP11_COMPARE_LT_GT' => -233,
			'OP19_VARIABLE_ASSIGN_BY' => -233,
			'OP04_MATH_POW' => -233,
			'OP23_LOGICAL_AND' => -233,
			'OP02_HASH_THINARROW' => 245
		},
		GOTOS => {
			'PLUS-54' => 297,
			'VariableRetrievalArrow' => 296,
			'VariableRetrieval' => 295
		}
	},
	{#State 166
		ACTIONS => {
			'ARRAY_SYMBOL' => -133,
			'OP10_NAMED_UNARY' => -133,
			"undef" => -133,
			'OP22_LOGICAL_NEG_LPAREN' => -133,
			'SCALAR_SYMBOL' => -133,
			'OP05_BITWISE_NEG_LPAREN' => -133,
			'ENV' => -133,
			'LITERAL_NUMBER' => -133,
			'WORD' => -133,
			'WORD_UPPERCASE' => -133,
			"\@{" => -133,
			'SELF' => -133,
			'HASH_SYMBOL' => -133,
			'OP05_MATH_NEG_LPAREN' => -133,
			"%{" => -133,
			'STDOUT_STDERR' => 301,
			'ARGV' => -133,
			'OP05_LOGICAL_NEG' => -133,
			'ARRAY_REF_SYMBOL' => -133,
			'OP22_LOGICAL_NEG' => -133,
			'HASH_REF_SYMBOL' => -133,
			'LBRACE' => -133,
			'LPAREN' => -133,
			'FHREF_SYMBOL_BRACES' => 298,
			'LBRACKET' => -133,
			'CONSTANT_CALL_SCOPED' => -133,
			'OP01_QW' => -133,
			'OP01_OPEN' => -133,
			'LPAREN_TYPE_INNER' => -133,
			'OP01_NAMED' => -133,
			'LITERAL_STRING' => -133,
			'OP01_CLOSE' => -133,
			'OP03_MATH_INC_DEC' => -133,
			'WORD_SCOPED' => -133
		},
		GOTOS => {
			'PAREN-39' => 299,
			'OPTIONAL-40' => 300
		}
	},
	{#State 167
		DEFAULT => -267
	},
	{#State 168
		ACTIONS => {
			'COLON' => 302
		}
	},
	{#State 169
		DEFAULT => -142
	},
	{#State 170
		DEFAULT => -157
	},
	{#State 171
		ACTIONS => {
			"for" => 304,
			"foreach" => 309,
			"while" => 305
		},
		GOTOS => {
			'LoopFor' => 308,
			'Loop' => 307,
			'LoopWhile' => 306,
			'LoopForEach' => 303
		}
	},
	{#State 172
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			")" => -135,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'SubExpression' => 259,
			'Array' => 123,
			'SubExpressions' => 310,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'OPTIONAL-41' => 311
		}
	},
	{#State 173
		DEFAULT => -177
	},
	{#State 174
		ACTIONS => {
			'OP15_LOGICAL_AND' => -270,
			'OP06_REGEX_BIND' => -270,
			'OP04_MATH_POW' => -270,
			'OP23_LOGICAL_AND' => -270,
			'OP11_COMPARE_LT_GT' => -270,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP18_TERNARY' => -270,
			'OP07_STRING_REPEAT' => -270,
			'OP09_BITWISE_SHIFT' => -270,
			'OP12_COMPARE_EQ_NE' => -270,
			")" => -270,
			'OP24_LOGICAL_OR_XOR' => -270,
			'OP08_STRING_CAT' => -270,
			'OP14_BITWISE_OR_XOR' => -270,
			'OP16_LOGICAL_OR' => -270,
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP17_LIST_RANGE' => -270,
			'OP07_MATH_MULT_DIV_MOD' => -270,
			'OP13_BITWISE_AND' => -270,
			'OP08_MATH_ADD_SUB' => -270
		}
	},
	{#State 175
		ACTIONS => {
			'LPAREN' => 312,
			'COLON' => -296
		}
	},
	{#State 176
		ACTIONS => {
			";" => 313
		}
	},
	{#State 177
		DEFAULT => -299
	},
	{#State 178
		DEFAULT => -297
	},
	{#State 179
		DEFAULT => -298
	},
	{#State 180
		ACTIONS => {
			"\$TYPED_" => 314
		}
	},
	{#State 181
		ACTIONS => {
			";" => 315
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => 178,
			'WORD_SCOPED' => 179,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 316
		}
	},
	{#State 183
		DEFAULT => -70
	},
	{#State 184
		ACTIONS => {
			"use constant" => 61,
			"our hashref \$properties" => 317
		},
		GOTOS => {
			'Properties' => 319,
			'Constant' => 318
		}
	},
	{#State 185
		ACTIONS => {
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131
		},
		GOTOS => {
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 320,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120
		}
	},
	{#State 186
		DEFAULT => -270
	},
	{#State 187
		ACTIONS => {
			'LPAREN' => 312
		}
	},
	{#State 188
		DEFAULT => -156
	},
	{#State 189
		DEFAULT => -286
	},
	{#State 190
		DEFAULT => -282
	},
	{#State 191
		DEFAULT => -266
	},
	{#State 192
		ACTIONS => {
			'OP13_BITWISE_AND' => -226,
			'OP03_MATH_INC_DEC' => 220,
			'OP21_LIST_COMMA' => -226,
			";" => -226,
			'OP08_MATH_ADD_SUB' => -226,
			"]" => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			")" => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP08_STRING_CAT' => -226,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP11_COMPARE_LT_GT' => -226,
			"}" => -226,
			'OP02_METHOD_THINARROW' => 219,
			'OP07_STRING_REPEAT' => -226,
			'OP18_TERNARY' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP06_REGEX_BIND' => -226,
			'OP04_MATH_POW' => -226,
			'OP23_LOGICAL_AND' => -226
		}
	},
	{#State 193
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -109,
			'OP17_LIST_RANGE' => -109,
			'OP14_BITWISE_OR_XOR' => -109,
			'OP16_LOGICAL_OR' => -109,
			")" => -109,
			'OP08_STRING_CAT' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP09_BITWISE_SHIFT' => -109,
			'OP12_COMPARE_EQ_NE' => -109,
			"]" => -109,
			'OP08_MATH_ADD_SUB' => -109,
			'OP21_LIST_COMMA' => -109,
			";" => -109,
			'OP13_BITWISE_AND' => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => -109,
			'OP06_REGEX_BIND' => -109,
			'OP07_STRING_REPEAT' => -109,
			'OP18_TERNARY' => -109,
			'OP11_COMPARE_LT_GT' => -109,
			"}" => -109
		}
	},
	{#State 194
		DEFAULT => -95
	},
	{#State 195
		ACTIONS => {
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP24_LOGICAL_OR_XOR' => -128,
			")" => -128,
			'OP08_STRING_CAT' => 236,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -128,
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -128,
			";" => -128,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -128,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			"}" => -128,
			'OP11_COMPARE_LT_GT' => 230
		}
	},
	{#State 196
		ACTIONS => {
			'TYPE_FHREF' => 321
		}
	},
	{#State 197
		DEFAULT => -315
	},
	{#State 198
		DEFAULT => -331
	},
	{#State 199
		DEFAULT => -325
	},
	{#State 200
		DEFAULT => -330
	},
	{#State 201
		DEFAULT => -318
	},
	{#State 202
		DEFAULT => -326
	},
	{#State 203
		DEFAULT => -329
	},
	{#State 204
		DEFAULT => -324
	},
	{#State 205
		DEFAULT => -316
	},
	{#State 206
		DEFAULT => -319
	},
	{#State 207
		DEFAULT => -320
	},
	{#State 208
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 322
		}
	},
	{#State 209
		DEFAULT => -322
	},
	{#State 210
		DEFAULT => -323
	},
	{#State 211
		DEFAULT => -328
	},
	{#State 212
		DEFAULT => -327
	},
	{#State 213
		DEFAULT => -321
	},
	{#State 214
		DEFAULT => -317
	},
	{#State 215
		DEFAULT => -104
	},
	{#State 216
		ACTIONS => {
			'FHREF_SYMBOL' => 323
		}
	},
	{#State 217
		ACTIONS => {
			'SCALAR_SYMBOL' => 325,
			'ARRAY_SYMBOL' => 326,
			'HASH_SYMBOL' => 324
		}
	},
	{#State 218
		ACTIONS => {
			'OP08_STRING_CAT' => 236,
			")" => 327,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234
		}
	},
	{#State 219
		ACTIONS => {
			'LPAREN' => 328
		}
	},
	{#State 220
		DEFAULT => -106
	},
	{#State 221
		ACTIONS => {
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARGV' => 106
		},
		GOTOS => {
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 329,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190
		}
	},
	{#State 222
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134
		},
		GOTOS => {
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'SubExpression' => 330,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120
		}
	},
	{#State 223
		ACTIONS => {
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106
		},
		GOTOS => {
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 331,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 224
		ACTIONS => {
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109
		},
		GOTOS => {
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 332,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186
		}
	},
	{#State 225
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110
		},
		GOTOS => {
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 333,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108
		}
	},
	{#State 226
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 334
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL_STRING' => 154,
			'LITERAL_NUMBER' => 138,
			'SCALAR_SYMBOL' => 165,
			'SELF' => 131
		},
		GOTOS => {
			'ScalarVariableOrLiteral' => 335,
			'ScalarLiteral' => 337,
			'ScalarVariable' => 336
		}
	},
	{#State 228
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185
		},
		GOTOS => {
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'SubExpression' => 338,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123
		}
	},
	{#State 229
		ACTIONS => {
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109
		},
		GOTOS => {
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'WordScoped' => 161,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 339,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105
		}
	},
	{#State 230
		ACTIONS => {
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155
		},
		GOTOS => {
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 340,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 231
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162
		},
		GOTOS => {
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 341,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120
		}
	},
	{#State 232
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 342,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142
		}
	},
	{#State 233
		ACTIONS => {
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 343,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'Scalar' => 108
		}
	},
	{#State 234
		ACTIONS => {
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 344,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107
		}
	},
	{#State 235
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167
		},
		GOTOS => {
			'SubExpression' => 345,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashDereference' => 129,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 236
		ACTIONS => {
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155
		},
		GOTOS => {
			'SubExpression' => 346,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135
		}
	},
	{#State 237
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SELF' => 131,
			"\@{" => 130,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133
		},
		GOTOS => {
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 347,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152
		}
	},
	{#State 238
		ACTIONS => {
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 348,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190
		}
	},
	{#State 239
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP08_STRING_CAT' => 236,
			")" => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP16_LOGICAL_OR' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			";" => -117,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -117,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => -117,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -117,
			"}" => -117,
			'OP11_COMPARE_LT_GT' => -117,
			'OP18_TERNARY' => -117,
			'OP07_STRING_REPEAT' => 234
		}
	},
	{#State 240
		DEFAULT => -274
	},
	{#State 241
		ACTIONS => {
			"}" => 349
		}
	},
	{#State 242
		ACTIONS => {
			'LBRACKET' => 162,
			'ARRAY_REF_SYMBOL' => 143
		},
		GOTOS => {
			'ArrayReference' => 350,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'ArrayRefLiteralEmpty' => 119
		}
	},
	{#State 243
		ACTIONS => {
			'WORD' => 178,
			'WORD_SCOPED' => 179,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 351
		}
	},
	{#State 244
		ACTIONS => {
			'COLON' => -236,
			'OP07_MATH_MULT_DIV_MOD' => -236,
			'LBRACE' => 294,
			'OP19_VARIABLE_ASSIGN' => -236,
			'LBRACKET' => 293,
			'OP16_LOGICAL_OR' => -236,
			'OP08_STRING_CAT' => -236,
			")" => -236,
			"]" => -236,
			'OP08_MATH_ADD_SUB' => -236,
			'OP02_ARRAY_THINARROW' => 246,
			'OP03_MATH_INC_DEC' => -236,
			'OP23_LOGICAL_AND' => -236,
			'OP04_MATH_POW' => -236,
			'OP02_HASH_THINARROW' => 245,
			'OP02_METHOD_THINARROW' => -236,
			'OP19_VARIABLE_ASSIGN_BY' => -236,
			'OP11_COMPARE_LT_GT' => -236,
			'OP17_LIST_RANGE' => -236,
			'OP14_BITWISE_OR_XOR' => -236,
			'OP24_LOGICAL_OR_XOR' => -236,
			'OP09_BITWISE_SHIFT' => -236,
			'OP12_COMPARE_EQ_NE' => -236,
			";" => -236,
			'OP21_LIST_COMMA' => -236,
			'OP13_BITWISE_AND' => -236,
			'OP20_HASH_FATARROW' => -236,
			'OP15_LOGICAL_AND' => -236,
			'OP06_REGEX_BIND' => -236,
			'OP07_STRING_REPEAT' => -236,
			'OP18_TERNARY' => -236,
			"}" => -236
		},
		GOTOS => {
			'PLUS-55' => 353,
			'VariableRetrieval' => 352,
			'VariableRetrievalArrow' => 296
		}
	},
	{#State 245
		ACTIONS => {
			'WORD_UPPERCASE' => 187,
			'WORD' => 355,
			'LITERAL_NUMBER' => 138,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'ARGV' => 106,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'SubExpression' => 354,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120
		}
	},
	{#State 246
		ACTIONS => {
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 356,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 247
		DEFAULT => -16
	},
	{#State 248
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			")" => 357,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222
		}
	},
	{#State 249
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'FHREF_SYMBOL_IN' => 359,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'STDIN' => 358,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'SELF' => 131,
			"\@{" => 130,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170
		},
		GOTOS => {
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'SubExpressionOrInput' => 360,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 361,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'WordScoped' => 161,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190
		}
	},
	{#State 250
		ACTIONS => {
			'SELF' => 131,
			"\@{" => 130,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148
		},
		GOTOS => {
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 362,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190
		}
	},
	{#State 251
		ACTIONS => {
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			")" => 363,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231
		}
	},
	{#State 252
		DEFAULT => -290
	},
	{#State 253
		ACTIONS => {
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashRefLiteralEmpty' => 136,
			'HashReference' => 364,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 254
		ACTIONS => {
			"}" => 365
		}
	},
	{#State 255
		ACTIONS => {
			";" => 366
		}
	},
	{#State 256
		DEFAULT => -296
	},
	{#State 257
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP21_LIST_COMMA' => 367,
			";" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP08_STRING_CAT' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP04_MATH_POW' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_BIND' => -101
		}
	},
	{#State 258
		DEFAULT => -105
	},
	{#State 259
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			";" => -169,
			'OP21_LIST_COMMA' => -169,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			")" => -169,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232
		},
		GOTOS => {
			'STAR-46' => 368
		}
	},
	{#State 260
		ACTIONS => {
			";" => 369
		}
	},
	{#State 261
		ACTIONS => {
			'MY' => 196,
			'OP20_HASH_FATARROW' => -328
		}
	},
	{#State 262
		ACTIONS => {
			'OP20_HASH_FATARROW' => -327,
			'FHREF_SYMBOL' => 215
		}
	},
	{#State 263
		ACTIONS => {
			'OP20_HASH_FATARROW' => 370
		}
	},
	{#State 264
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			"\@{" => 130,
			'OP20_HASH_FATARROW' => -317,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187
		},
		GOTOS => {
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'SubExpression' => 195,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108
		}
	},
	{#State 265
		DEFAULT => -308
	},
	{#State 266
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'OP11_COMPARE_LT_GT' => -118,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_MATH_NEG_LPAREN' => 146,
			'OP23_LOGICAL_AND' => -118,
			'OP04_MATH_POW' => -118,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP08_MATH_ADD_SUB' => -118,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP07_MATH_MULT_DIV_MOD' => -118,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'OP16_LOGICAL_OR' => -118,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP08_STRING_CAT' => -118,
			")" => -118,
			'OP07_STRING_REPEAT' => -118,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP18_TERNARY' => -118,
			'SCALAR_SYMBOL' => 165,
			"}" => -118,
			'OP06_REGEX_BIND' => -118,
			"undef" => 170,
			'OP15_LOGICAL_AND' => -118,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"\@{" => 130,
			'SELF' => 131,
			'OP21_LIST_COMMA' => -118,
			'OP13_BITWISE_AND' => -118,
			'OP20_HASH_FATARROW' => -322,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP17_LIST_RANGE' => -118,
			'ENV' => 134,
			'OP14_BITWISE_OR_XOR' => -118,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP09_BITWISE_SHIFT' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'WORD' => 31
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 239,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 267
		ACTIONS => {
			'OP17_LIST_RANGE' => -225,
			'OP07_MATH_MULT_DIV_MOD' => -225,
			")" => -225,
			'OP08_STRING_CAT' => -225,
			'OP24_LOGICAL_OR_XOR' => -225,
			'OP09_BITWISE_SHIFT' => -225,
			'OP12_COMPARE_EQ_NE' => -225,
			'OP16_LOGICAL_OR' => -225,
			'OP14_BITWISE_OR_XOR' => -225,
			'OP08_MATH_ADD_SUB' => -225,
			'OP21_LIST_COMMA' => -225,
			'OP20_HASH_FATARROW' => -307,
			'OP13_BITWISE_AND' => -225,
			'OP23_LOGICAL_AND' => -225,
			'OP04_MATH_POW' => -225,
			'OP15_LOGICAL_AND' => -225,
			'OP06_REGEX_BIND' => -225,
			'OP18_TERNARY' => -225,
			'OP07_STRING_REPEAT' => -225,
			'OP11_COMPARE_LT_GT' => -225,
			"}" => -225
		}
	},
	{#State 268
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -253,
			'OP08_MATH_ADD_SUB' => 228,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => -253,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234
		}
	},
	{#State 269
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -226,
			'OP03_MATH_INC_DEC' => 220,
			'OP21_LIST_COMMA' => -226,
			'OP13_BITWISE_AND' => -226,
			'OP20_HASH_FATARROW' => -306,
			'OP07_MATH_MULT_DIV_MOD' => -226,
			'OP17_LIST_RANGE' => -226,
			'OP14_BITWISE_OR_XOR' => -226,
			'OP16_LOGICAL_OR' => -226,
			'OP08_STRING_CAT' => -226,
			")" => -226,
			'OP24_LOGICAL_OR_XOR' => -226,
			'OP09_BITWISE_SHIFT' => -226,
			'OP12_COMPARE_EQ_NE' => -226,
			'OP02_METHOD_THINARROW' => 219,
			'OP07_STRING_REPEAT' => -226,
			'OP18_TERNARY' => -226,
			"}" => -226,
			'OP11_COMPARE_LT_GT' => -226,
			'OP23_LOGICAL_AND' => -226,
			'OP04_MATH_POW' => -226,
			'OP15_LOGICAL_AND' => -226,
			'OP06_REGEX_BIND' => -226
		}
	},
	{#State 270
		ACTIONS => {
			"}" => 371
		}
	},
	{#State 271
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"\@{" => 130,
			'SELF' => 131,
			'OP20_HASH_FATARROW' => -326,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'WordScoped' => 161,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'SubExpression' => 320,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188
		}
	},
	{#State 272
		DEFAULT => -249,
		GOTOS => {
			'STAR-61' => 372
		}
	},
	{#State 273
		ACTIONS => {
			'OP20_HASH_FATARROW' => -331,
			'OP02_METHOD_THINARROW_NEW' => -294,
			'LPAREN' => -294
		}
	},
	{#State 274
		DEFAULT => -254
	},
	{#State 275
		DEFAULT => -260
	},
	{#State 276
		ACTIONS => {
			")" => 373
		}
	},
	{#State 277
		DEFAULT => -258
	},
	{#State 278
		ACTIONS => {
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -255,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP08_STRING_CAT' => 236,
			")" => -255,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235
		}
	},
	{#State 279
		DEFAULT => -256
	},
	{#State 280
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP20_HASH_FATARROW' => -326,
			'SELF' => 131,
			"\@{" => 130,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121
		},
		GOTOS => {
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 374,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142
		}
	},
	{#State 281
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187
		},
		GOTOS => {
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 375,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 282
		DEFAULT => -257
	},
	{#State 283
		DEFAULT => -241,
		GOTOS => {
			'STAR-57' => 376
		}
	},
	{#State 284
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 377,
			'OP20_HASH_FATARROW' => -330
		}
	},
	{#State 285
		ACTIONS => {
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			")" => -149
		},
		GOTOS => {
			'HashReferenceVariable' => 189,
			'HashReferenceLiteral' => 126,
			'HashReference' => 378,
			'HashRefLiteralEmpty' => 136,
			'OPTIONAL-44' => 379
		}
	},
	{#State 286
		ACTIONS => {
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			")" => -145,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'SubExpression' => 259,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpressions' => 381,
			'Array' => 123,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'Scalar' => 108,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'OPTIONAL-42' => 380,
			'WordScoped' => 161
		}
	},
	{#State 287
		DEFAULT => -245,
		GOTOS => {
			'STAR-59' => 382
		}
	},
	{#State 288
		DEFAULT => -252
	},
	{#State 289
		ACTIONS => {
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -251,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -251,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238
		}
	},
	{#State 290
		DEFAULT => -259
	},
	{#State 291
		ACTIONS => {
			"]" => 383
		}
	},
	{#State 292
		DEFAULT => -183
	},
	{#State 293
		ACTIONS => {
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'WordScoped' => 161,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'SubExpression' => 384,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105
		}
	},
	{#State 294
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 385,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'WordScoped' => 161,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 386
		}
	},
	{#State 295
		DEFAULT => -230
	},
	{#State 296
		DEFAULT => -211
	},
	{#State 297
		ACTIONS => {
			'OP21_LIST_COMMA' => -234,
			";" => -234,
			'OP13_BITWISE_AND' => -234,
			'OP20_HASH_FATARROW' => -234,
			'OP17_LIST_RANGE' => -234,
			'OP14_BITWISE_OR_XOR' => -234,
			'OP24_LOGICAL_OR_XOR' => -234,
			'OP09_BITWISE_SHIFT' => -234,
			'OP12_COMPARE_EQ_NE' => -234,
			'OP07_STRING_REPEAT' => -234,
			'OP18_TERNARY' => -234,
			"}" => -234,
			'OP15_LOGICAL_AND' => -234,
			'OP06_REGEX_BIND' => -234,
			"]" => -234,
			'OP02_ARRAY_THINARROW' => 246,
			'OP08_MATH_ADD_SUB' => -234,
			'OP03_MATH_INC_DEC' => -234,
			'COLON' => -234,
			'OP07_MATH_MULT_DIV_MOD' => -234,
			'LBRACE' => 294,
			'OP19_VARIABLE_ASSIGN' => -234,
			'LBRACKET' => 293,
			'OP16_LOGICAL_OR' => -234,
			")" => -234,
			'OP08_STRING_CAT' => -234,
			'OP02_METHOD_THINARROW' => -234,
			'OP19_VARIABLE_ASSIGN_BY' => -234,
			'OP11_COMPARE_LT_GT' => -234,
			'OP23_LOGICAL_AND' => -234,
			'OP04_MATH_POW' => -234,
			'OP02_HASH_THINARROW' => 245
		},
		GOTOS => {
			'VariableRetrieval' => 387,
			'VariableRetrievalArrow' => 296
		}
	},
	{#State 298
		ACTIONS => {
			'SELF' => 131,
			"\@{" => 130,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146
		},
		GOTOS => {
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 259,
			'Array' => 123,
			'SubExpressions' => 388,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142
		}
	},
	{#State 299
		DEFAULT => -132
	},
	{#State 300
		ACTIONS => {
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143
		},
		GOTOS => {
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'SubExpression' => 259,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpressions' => 389,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108
		}
	},
	{#State 301
		DEFAULT => -131
	},
	{#State 302
		DEFAULT => -176
	},
	{#State 303
		DEFAULT => -193
	},
	{#State 304
		ACTIONS => {
			'LPAREN_MY' => 391,
			'MY' => 390
		}
	},
	{#State 305
		ACTIONS => {
			'LPAREN' => 393,
			'LPAREN_MY' => 392
		}
	},
	{#State 306
		DEFAULT => -194
	},
	{#State 307
		DEFAULT => -180
	},
	{#State 308
		DEFAULT => -192
	},
	{#State 309
		ACTIONS => {
			'MY' => 394
		}
	},
	{#State 310
		DEFAULT => -134
	},
	{#State 311
		ACTIONS => {
			")" => 395
		}
	},
	{#State 312
		ACTIONS => {
			")" => 396
		}
	},
	{#State 313
		ACTIONS => {
			"}" => 397
		}
	},
	{#State 314
		ACTIONS => {
			'WORD_UPPERCASE' => 398
		}
	},
	{#State 315
		DEFAULT => -56
	},
	{#State 316
		ACTIONS => {
			"\$RETURN_TYPE" => 399
		}
	},
	{#State 317
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 400
		}
	},
	{#State 318
		DEFAULT => -72
	},
	{#State 319
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 401
		}
	},
	{#State 320
		ACTIONS => {
			'OP13_BITWISE_AND' => -101,
			";" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			"]" => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			"}" => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP04_MATH_POW' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 321
		ACTIONS => {
			'FHREF_SYMBOL' => 402
		}
	},
	{#State 322
		ACTIONS => {
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'SubExpression' => 403,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147
		}
	},
	{#State 323
		ACTIONS => {
			";" => 404
		}
	},
	{#State 324
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 405,
			";" => 406
		}
	},
	{#State 325
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407,
			'OP02_ARRAY_THINARROW' => 408,
			";" => 409
		}
	},
	{#State 326
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410,
			";" => 411
		}
	},
	{#State 327
		DEFAULT => -127
	},
	{#State 328
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			")" => -147,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'SubExpression' => 259,
			'Array' => 123,
			'SubExpressions' => 413,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'OPTIONAL-43' => 412,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135
		}
	},
	{#State 329
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			")" => 414,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234
		}
	},
	{#State 330
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			"}" => -116,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -116,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => -116,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -116,
			'OP13_BITWISE_AND' => -116,
			";" => -116,
			'OP21_LIST_COMMA' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP09_BITWISE_SHIFT' => -116,
			")" => -116,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -116
		}
	},
	{#State 331
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -120,
			'OP13_BITWISE_AND' => -120,
			";" => -120,
			'OP21_LIST_COMMA' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -120,
			'OP16_LOGICAL_OR' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP09_BITWISE_SHIFT' => 222,
			")" => -120,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -120,
			"}" => -120,
			'OP11_COMPARE_LT_GT' => 230,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP06_REGEX_BIND' => 226
		}
	},
	{#State 332
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP08_STRING_CAT' => 236,
			")" => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -125,
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -125,
			";" => -125,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -125,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP18_TERNARY' => -125,
			'OP07_STRING_REPEAT' => 234,
			"}" => -125,
			'OP11_COMPARE_LT_GT' => 230
		}
	},
	{#State 333
		ACTIONS => {
			'OP23_LOGICAL_AND' => -121,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => -121,
			'OP06_REGEX_BIND' => 226,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -121,
			"}" => -121,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			")" => -121,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			"]" => -121,
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -121,
			";" => -121,
			'OP13_BITWISE_AND' => -121
		}
	},
	{#State 334
		DEFAULT => -111
	},
	{#State 335
		ACTIONS => {
			'COLON' => 415
		}
	},
	{#State 336
		DEFAULT => -304
	},
	{#State 337
		DEFAULT => -305
	},
	{#State 338
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -114,
			"}" => -114,
			'OP18_TERNARY' => -114,
			'OP07_STRING_REPEAT' => 234,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => -114,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114,
			";" => -114,
			'OP21_LIST_COMMA' => -114,
			'OP08_MATH_ADD_SUB' => -114,
			"]" => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP08_STRING_CAT' => -114,
			")" => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 237
		}
	},
	{#State 339
		ACTIONS => {
			'OP13_BITWISE_AND' => -107,
			";" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP08_MATH_ADD_SUB' => -107,
			"]" => -107,
			'OP12_COMPARE_EQ_NE' => -107,
			'OP09_BITWISE_SHIFT' => -107,
			'OP08_STRING_CAT' => -107,
			")" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP14_BITWISE_OR_XOR' => -107,
			'OP17_LIST_RANGE' => -107,
			'OP07_MATH_MULT_DIV_MOD' => -107,
			"}" => -107,
			'OP11_COMPARE_LT_GT' => -107,
			'OP18_TERNARY' => -107,
			'OP07_STRING_REPEAT' => -107,
			'OP06_REGEX_BIND' => -107,
			'OP15_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -107
		}
	},
	{#State 340
		ACTIONS => {
			'OP17_LIST_RANGE' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			")" => -119,
			'OP08_STRING_CAT' => 236,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP16_LOGICAL_OR' => -119,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -119,
			'OP13_BITWISE_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			";" => -119,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -119,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => -119,
			'OP18_TERNARY' => -119,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => undef,
			"}" => -119
		}
	},
	{#State 341
		ACTIONS => {
			'OP18_TERNARY' => -122,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => -122,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP06_REGEX_BIND' => 226,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -122,
			'OP13_BITWISE_AND' => 225,
			";" => -122,
			'OP21_LIST_COMMA' => -122,
			'OP17_LIST_RANGE' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_STRING_CAT' => 236,
			")" => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP14_BITWISE_OR_XOR' => -122
		}
	},
	{#State 342
		ACTIONS => {
			"]" => -130,
			'OP08_MATH_ADD_SUB' => 228,
			";" => -130,
			'OP21_LIST_COMMA' => -130,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			")" => -130,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			"}" => -130,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226
		}
	},
	{#State 343
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -123,
			'OP13_BITWISE_AND' => 225,
			";" => -123,
			'OP21_LIST_COMMA' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			")" => -123,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -123,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => -123,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -123,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => -123
		}
	},
	{#State 344
		ACTIONS => {
			'OP15_LOGICAL_AND' => -112,
			'OP06_REGEX_BIND' => 226,
			'OP23_LOGICAL_AND' => -112,
			'OP04_MATH_POW' => 229,
			"}" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP07_STRING_REPEAT' => -112,
			'OP18_TERNARY' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP16_LOGICAL_OR' => -112,
			")" => -112,
			'OP08_STRING_CAT' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP17_LIST_RANGE' => -112,
			";" => -112,
			'OP21_LIST_COMMA' => -112,
			'OP13_BITWISE_AND' => -112,
			"]" => -112,
			'OP08_MATH_ADD_SUB' => -112
		}
	},
	{#State 345
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -124,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => -124,
			'OP23_LOGICAL_AND' => -124,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			"]" => -124,
			'OP08_MATH_ADD_SUB' => 228,
			";" => -124,
			'OP21_LIST_COMMA' => -124,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -124,
			'OP16_LOGICAL_OR' => -124,
			'OP14_BITWISE_OR_XOR' => 231,
			")" => -124,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222
		}
	},
	{#State 346
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			"]" => -115,
			'OP13_BITWISE_AND' => -115,
			";" => -115,
			'OP21_LIST_COMMA' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			")" => -115,
			'OP08_STRING_CAT' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -115,
			"}" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP06_REGEX_BIND' => 226
		}
	},
	{#State 347
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			"}" => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => -113,
			'OP06_REGEX_BIND' => 226,
			"]" => -113,
			'OP08_MATH_ADD_SUB' => -113,
			";" => -113,
			'OP21_LIST_COMMA' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => -113,
			'OP17_LIST_RANGE' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			")" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP08_STRING_CAT' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP09_BITWISE_SHIFT' => -113
		}
	},
	{#State 348
		ACTIONS => {
			'OP23_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			"}" => -129,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			")" => -129,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			"]" => -129,
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -129,
			";" => -129,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 349
		DEFAULT => -276
	},
	{#State 350
		ACTIONS => {
			"}" => 416
		}
	},
	{#State 351
		ACTIONS => {
			"\$TYPED_" => 417
		}
	},
	{#State 352
		DEFAULT => -232
	},
	{#State 353
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -237,
			'OP11_COMPARE_LT_GT' => -237,
			'OP19_VARIABLE_ASSIGN_BY' => -237,
			'OP04_MATH_POW' => -237,
			'OP23_LOGICAL_AND' => -237,
			'OP02_HASH_THINARROW' => 245,
			'OP02_ARRAY_THINARROW' => 246,
			'OP08_MATH_ADD_SUB' => -237,
			"]" => -237,
			'OP03_MATH_INC_DEC' => -237,
			'OP19_VARIABLE_ASSIGN' => -237,
			'LBRACE' => 294,
			'OP07_MATH_MULT_DIV_MOD' => -237,
			'COLON' => -237,
			")" => -237,
			'OP08_STRING_CAT' => -237,
			'OP16_LOGICAL_OR' => -237,
			'LBRACKET' => 293,
			'OP18_TERNARY' => -237,
			'OP07_STRING_REPEAT' => -237,
			"}" => -237,
			'OP06_REGEX_BIND' => -237,
			'OP15_LOGICAL_AND' => -237,
			'OP20_HASH_FATARROW' => -237,
			'OP13_BITWISE_AND' => -237,
			'OP21_LIST_COMMA' => -237,
			";" => -237,
			'OP17_LIST_RANGE' => -237,
			'OP09_BITWISE_SHIFT' => -237,
			'OP12_COMPARE_EQ_NE' => -237,
			'OP24_LOGICAL_OR_XOR' => -237,
			'OP14_BITWISE_OR_XOR' => -237
		},
		GOTOS => {
			'VariableRetrievalArrow' => 296,
			'VariableRetrieval' => 418
		}
	},
	{#State 354
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => 419
		}
	},
	{#State 355
		ACTIONS => {
			"}" => 420,
			'OP02_METHOD_THINARROW_NEW' => -294,
			'LPAREN' => -294
		}
	},
	{#State 356
		ACTIONS => {
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => 421,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238
		}
	},
	{#State 357
		DEFAULT => -108
	},
	{#State 358
		DEFAULT => -173
	},
	{#State 359
		DEFAULT => -172
	},
	{#State 360
		DEFAULT => -223
	},
	{#State 361
		ACTIONS => {
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			")" => -171,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			";" => -171,
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228
		}
	},
	{#State 362
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			";" => -224,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP24_LOGICAL_OR_XOR' => 232,
			")" => -224,
			'OP08_STRING_CAT' => 236,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226
		}
	},
	{#State 363
		DEFAULT => -110
	},
	{#State 364
		ACTIONS => {
			"}" => 422
		}
	},
	{#State 365
		DEFAULT => -292
	},
	{#State 366
		DEFAULT => -143
	},
	{#State 367
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110
		},
		GOTOS => {
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'SubExpression' => 259,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpressions' => 423,
			'Array' => 123,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105
		}
	},
	{#State 368
		ACTIONS => {
			";" => -170,
			")" => -170,
			'OP21_LIST_COMMA' => 425
		},
		GOTOS => {
			'PAREN-45' => 424
		}
	},
	{#State 369
		DEFAULT => -140
	},
	{#State 370
		ACTIONS => {
			'WORD_UPPERCASE' => -279,
			'WORD' => -279,
			'LITERAL_NUMBER' => -279,
			'ENV' => -279,
			'OP05_BITWISE_NEG_LPAREN' => -279,
			'SELF' => -279,
			"\@{" => -279,
			"undef" => -279,
			'OP10_NAMED_UNARY' => -279,
			'ARRAY_SYMBOL' => -279,
			'SCALAR_SYMBOL' => -279,
			'OP22_LOGICAL_NEG_LPAREN' => -279,
			'CONSTANT_CALL_SCOPED' => -279,
			'LBRACKET' => -279,
			'LPAREN' => -279,
			'LBRACE' => -279,
			'HASH_REF_SYMBOL' => -279,
			'WORD_SCOPED' => -279,
			'MY' => 243,
			'OP03_MATH_INC_DEC' => -279,
			'OP01_CLOSE' => -279,
			'LITERAL_STRING' => -279,
			'OP01_NAMED' => -279,
			'LPAREN_TYPE_INNER' => -279,
			'OP01_OPEN' => -279,
			'OP01_QW' => -279,
			'ARGV' => -279,
			"%{" => -279,
			'OP05_MATH_NEG_LPAREN' => -279,
			'HASH_SYMBOL' => -279,
			'OP22_LOGICAL_NEG' => -279,
			'ARRAY_REF_SYMBOL' => -279,
			'OP05_LOGICAL_NEG' => -279
		},
		GOTOS => {
			'OPTIONAL-65' => 427,
			'TypeInner' => 426
		}
	},
	{#State 371
		DEFAULT => -287
	},
	{#State 372
		ACTIONS => {
			"}" => -250,
			'OP21_LIST_COMMA' => 428
		},
		GOTOS => {
			'PAREN-60' => 429
		}
	},
	{#State 373
		DEFAULT => -238
	},
	{#State 374
		ACTIONS => {
			'OP07_STRING_REPEAT' => -101,
			'OP18_TERNARY' => -101,
			'OP11_COMPARE_LT_GT' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => -101,
			'OP06_REGEX_BIND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_MATH_ADD_SUB' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			")" => -101,
			'OP08_STRING_CAT' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'OP12_COMPARE_EQ_NE' => -101
		}
	},
	{#State 375
		ACTIONS => {
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP08_STRING_CAT' => 236,
			")" => -261,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP21_LIST_COMMA' => -261,
			'OP13_BITWISE_AND' => 225,
			"]" => -261,
			'OP08_MATH_ADD_SUB' => 228
		}
	},
	{#State 376
		ACTIONS => {
			'OP21_LIST_COMMA' => 432,
			")" => -242
		},
		GOTOS => {
			'PAREN-56' => 431
		}
	},
	{#State 377
		ACTIONS => {
			'SELF' => 131,
			"\@{" => 130,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148
		},
		GOTOS => {
			'SubExpression' => 259,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpressions' => 433,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 378
		DEFAULT => -148
	},
	{#State 379
		ACTIONS => {
			")" => 434
		}
	},
	{#State 380
		ACTIONS => {
			")" => 435
		}
	},
	{#State 381
		DEFAULT => -144
	},
	{#State 382
		ACTIONS => {
			"]" => -246,
			'OP21_LIST_COMMA' => 437
		},
		GOTOS => {
			'PAREN-58' => 436
		}
	},
	{#State 383
		DEFAULT => -271
	},
	{#State 384
		ACTIONS => {
			'OP13_BITWISE_AND' => 225,
			"]" => 438,
			'OP08_MATH_ADD_SUB' => 228,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229
		}
	},
	{#State 385
		ACTIONS => {
			'LPAREN' => -294,
			'OP02_METHOD_THINARROW_NEW' => -294,
			"}" => 439
		}
	},
	{#State 386
		ACTIONS => {
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => 440,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 387
		DEFAULT => -229
	},
	{#State 388
		ACTIONS => {
			";" => 441
		}
	},
	{#State 389
		ACTIONS => {
			";" => 442
		}
	},
	{#State 390
		ACTIONS => {
			'TYPE_INTEGER' => 443
		}
	},
	{#State 391
		ACTIONS => {
			'TYPE_INTEGER' => 444
		}
	},
	{#State 392
		ACTIONS => {
			'WORD' => 178,
			'WORD_SCOPED' => 179,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 445
		}
	},
	{#State 393
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134
		},
		GOTOS => {
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'SubExpression' => 446,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 394
		ACTIONS => {
			'WORD_SCOPED' => 179,
			'WORD' => 178,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 447
		}
	},
	{#State 395
		ACTIONS => {
			";" => 448
		}
	},
	{#State 396
		DEFAULT => -151
	},
	{#State 397
		DEFAULT => -55
	},
	{#State 398
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 449
		}
	},
	{#State 399
		ACTIONS => {
			"}" => 450
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 451
		}
	},
	{#State 401
		ACTIONS => {
			'SUB' => 455,
			'LITERAL_NUMBER' => 452
		},
		GOTOS => {
			'SubroutineOrMethod' => 454,
			'Subroutine' => 453,
			'Method' => 456
		}
	},
	{#State 402
		ACTIONS => {
			'OP21_LIST_COMMA' => 457
		}
	},
	{#State 403
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -264,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			")" => -264,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233
		},
		GOTOS => {
			'STAR-63' => 458
		}
	},
	{#State 404
		DEFAULT => -222
	},
	{#State 405
		ACTIONS => {
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 459,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 461,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'STDIN' => 358,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'FHREF_SYMBOL_IN' => 359,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158
		},
		GOTOS => {
			'OpNamedScolonOrSubExpIn' => 460,
			'SubExpressionOrInput' => 462,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 361,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161
		}
	},
	{#State 406
		DEFAULT => -220
	},
	{#State 407
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => 461,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 459,
			'SCALAR_SYMBOL' => 165,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'FHREF_SYMBOL_IN' => 359,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'STDIN' => 358,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143
		},
		GOTOS => {
			'SubExpression' => 361,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'SubExpressionOrInput' => 462,
			'OpNamedScolonOrSubExpIn' => 463,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135
		}
	},
	{#State 408
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'ARGV' => 106,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121
		},
		GOTOS => {
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 464,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108
		}
	},
	{#State 409
		DEFAULT => -215
	},
	{#State 410
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'WORD_SCOPED' => 32,
			'FHREF_SYMBOL_IN' => 359,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'ARGV' => 106,
			'STDIN' => 358,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 461,
			'SELF' => 131,
			"\@{" => 130,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP01_NAMED_SCOLON' => 459,
			'OP22_LOGICAL_NEG_LPAREN' => 121
		},
		GOTOS => {
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 361,
			'SubExpressionOrInput' => 462,
			'OpNamedScolonOrSubExpIn' => 465,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135
		}
	},
	{#State 411
		DEFAULT => -218
	},
	{#State 412
		ACTIONS => {
			")" => 466
		}
	},
	{#State 413
		DEFAULT => -146
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 468
		}
	},
	{#State 415
		ACTIONS => {
			'SELF' => 131,
			'SCALAR_SYMBOL' => 165,
			'LITERAL_STRING' => 154,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'ScalarVariable' => 336,
			'ScalarLiteral' => 337,
			'ScalarVariableOrLiteral' => 469
		}
	},
	{#State 416
		DEFAULT => -277
	},
	{#State 417
		ACTIONS => {
			'OP01_NAMED' => 202,
			'OP01_OPEN' => 211,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_CLOSE' => 212,
			'OP01_NAMED_VOID' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'OP24_LOGICAL_OR_XOR' => 197,
			'WORD' => 198,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP07_STRING_REPEAT' => 199,
			'OP22_LOGICAL_NEG' => 214,
			'OP11_COMPARE_LT_GT' => 213,
			'OP23_LOGICAL_AND' => 205,
			'OP19_LOOP_CONTROL' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP01_PRINT' => 200,
			'OP10_NAMED_UNARY' => 209
		},
		GOTOS => {
			'OpStringOrWord' => 470
		}
	},
	{#State 418
		DEFAULT => -231
	},
	{#State 419
		DEFAULT => -209
	},
	{#State 420
		DEFAULT => -210
	},
	{#State 421
		DEFAULT => -208
	},
	{#State 422
		DEFAULT => -293
	},
	{#State 423
		ACTIONS => {
			";" => 471
		}
	},
	{#State 424
		DEFAULT => -168
	},
	{#State 425
		ACTIONS => {
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106
		},
		GOTOS => {
			'SubExpression' => 472,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 426
		DEFAULT => -278
	},
	{#State 427
		ACTIONS => {
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130
		},
		GOTOS => {
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 473,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186
		}
	},
	{#State 428
		ACTIONS => {
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_QW' => 150,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_OPEN' => 261,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 271,
			'OP01_CLOSE' => 262,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_NAMED_VOID' => 203,
			'WORD_SCOPED' => 32,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			'OP23_LOGICAL_AND' => 205,
			"%{" => 148,
			'OP19_LOOP_CONTROL' => 206,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP11_COMPARE_LT_GT' => 213,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 264,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'LITERAL_NUMBER' => 138,
			'OP24_LOGICAL_OR_XOR' => 197,
			'WORD' => 273,
			'OP12_COMPARE_EQ_NE' => 207,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'OP01_PRINT' => 200,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 266,
			"undef" => 170,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP07_STRING_REPEAT' => 199,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'SubExpression' => 268,
			'Array' => 123,
			'ScalarVariable' => 269,
			'Expression' => 188,
			'ScalarLiteral' => 267,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'HashLiteralE' => 474,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'OpStringOrWord' => 265,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashEntry' => 274,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186
		}
	},
	{#State 429
		DEFAULT => -248
	},
	{#State 430
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31
		},
		GOTOS => {
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 259,
			'SubExpressions' => 475,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'ArrayHashLiteral' => 151
		}
	},
	{#State 431
		DEFAULT => -240
	},
	{#State 432
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'OP01_NAMED_VOID' => 203,
			'MY' => 243,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 262,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 261,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_QW' => 150,
			'OP01_NAMED' => 271,
			'LPAREN_TYPE_INNER' => 110,
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 206,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'OP23_LOGICAL_AND' => 205,
			'ARRAY_REF_SYMBOL' => 143,
			'OP11_COMPARE_LT_GT' => 213,
			'OP22_LOGICAL_NEG' => 264,
			'OP05_LOGICAL_NEG' => 100,
			'WORD' => 273,
			'OP12_COMPARE_EQ_NE' => 207,
			'LITERAL_NUMBER' => 138,
			'OP24_LOGICAL_OR_XOR' => 197,
			'WORD_UPPERCASE' => 187,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 266,
			'OP01_PRINT' => 200,
			"undef" => 170,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP07_STRING_REPEAT' => 199
		},
		GOTOS => {
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'ListElement' => 279,
			'ArrayHashLiteralE' => 476,
			'OpStringOrWord' => 265,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'ScaVarOrLitOrOpStrOrWord' => 263,
			'HashReferenceLiteral' => 126,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 269,
			'SubExpression' => 278,
			'ScalarLiteral' => 267,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashReferenceVariable' => 189,
			'TypeInner' => 281,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'HashEntry' => 282
		}
	},
	{#State 433
		ACTIONS => {
			")" => 477
		}
	},
	{#State 434
		DEFAULT => -155
	},
	{#State 435
		DEFAULT => -153
	},
	{#State 436
		DEFAULT => -244
	},
	{#State 437
		ACTIONS => {
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'MY' => 243,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121
		},
		GOTOS => {
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'SubExpression' => 289,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'ListElement' => 288,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'HashReferenceVariable' => 189,
			'TypeInner' => 281,
			'HashVariable' => 190,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayLiteralE' => 478,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186
		}
	},
	{#State 438
		DEFAULT => -212
	},
	{#State 439
		DEFAULT => -214
	},
	{#State 440
		DEFAULT => -213
	},
	{#State 441
		DEFAULT => -137
	},
	{#State 442
		DEFAULT => -136
	},
	{#State 443
		ACTIONS => {
			'SCALAR_SYMBOL' => 479
		}
	},
	{#State 444
		ACTIONS => {
			'SCALAR_SYMBOL' => 480
		}
	},
	{#State 445
		ACTIONS => {
			'SCALAR_SYMBOL' => 481
		}
	},
	{#State 446
		ACTIONS => {
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			")" => 482,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222
		}
	},
	{#State 447
		ACTIONS => {
			'SCALAR_SYMBOL' => 483
		}
	},
	{#State 448
		DEFAULT => -139
	},
	{#State 449
		DEFAULT => -303
	},
	{#State 450
		ACTIONS => {
			";" => 484
		}
	},
	{#State 451
		ACTIONS => {
			'OP01_PRINT' => 200,
			'OP10_NAMED_UNARY' => 209,
			'OP19_LOOP_CONTROL' => 206,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP23_LOGICAL_AND' => 205,
			"}" => 485,
			'OP11_COMPARE_LT_GT' => 213,
			'OP22_LOGICAL_NEG' => 214,
			'OP07_STRING_REPEAT' => 199,
			'OP24_LOGICAL_OR_XOR' => 197,
			'WORD' => 198,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'OP01_CLOSE' => 212,
			'OP01_NAMED_VOID' => 203,
			'OP01_OPEN' => 211,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_NAMED' => 202
		},
		GOTOS => {
			'HashEntryProperties' => 486,
			'OpStringOrWord' => 487
		}
	},
	{#State 452
		ACTIONS => {
			";" => 488
		}
	},
	{#State 453
		DEFAULT => -93
	},
	{#State 454
		DEFAULT => -74
	},
	{#State 455
		ACTIONS => {
			'WORD' => 489
		}
	},
	{#State 456
		DEFAULT => -94
	},
	{#State 457
		ACTIONS => {
			'LITERAL_STRING' => 490
		}
	},
	{#State 458
		ACTIONS => {
			'OP21_LIST_COMMA' => 491,
			")" => 493
		},
		GOTOS => {
			'PAREN-62' => 492
		}
	},
	{#State 459
		DEFAULT => -312
	},
	{#State 460
		DEFAULT => -221
	},
	{#State 461
		DEFAULT => -313
	},
	{#State 462
		ACTIONS => {
			";" => 494
		}
	},
	{#State 463
		DEFAULT => -216
	},
	{#State 464
		ACTIONS => {
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228,
			"]" => 495,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238
		}
	},
	{#State 465
		DEFAULT => -219
	},
	{#State 466
		DEFAULT => -154
	},
	{#State 467
		ACTIONS => {
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 153,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'OP01_NAMED_VOID' => 156,
			'MY' => 112,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'POD' => 117,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"for" => -178,
			"%{" => 148,
			'OP19_LOOP_CONTROL' => 149,
			'ARGV' => 106,
			"\@{" => 130,
			'OP01_NAMED_VOID_LPAREN' => 172,
			"while" => -178,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"foreach" => -178,
			'WORD_UPPERCASE' => 175,
			'OP01_NAMED_SCOLON' => 164,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			"if" => 124,
			'SCALAR_SYMBOL' => 165,
			'OP01_PRINT' => 166,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP19_LOOP_CONTROL_SCOLON' => 169
		},
		GOTOS => {
			'OPTIONAL-48' => 171,
			'Conditional' => 140,
			'Operation' => 497,
			'PAREN-47' => 173,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 174,
			'ArrayReferenceLiteral' => 135,
			'Array' => 123,
			'ScalarVariable' => 122,
			'SubExpression' => 125,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'HashDereference' => 129,
			'LoopLabel' => 168,
			'ArrayVariable' => 127,
			'HashReferenceLiteral' => 126,
			'HashReferenceVariable' => 114,
			'HashVariable' => 115,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'WordScoped' => 161,
			'VariableModification' => 163,
			'Statement' => 116,
			'PLUS-53' => 496,
			'Expression' => 101,
			'OperatorVoid' => 144,
			'Variable' => 141,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashReference' => 147,
			'VariableDeclaration' => 103
		}
	},
	{#State 468
		DEFAULT => -187,
		GOTOS => {
			'STAR-50' => 498
		}
	},
	{#State 469
		DEFAULT => -126
	},
	{#State 470
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 499
		}
	},
	{#State 471
		DEFAULT => -141
	},
	{#State 472
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			")" => -167,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -167,
			";" => -167,
			'OP13_BITWISE_AND' => 225,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230
		}
	},
	{#State 473
		ACTIONS => {
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			"}" => -280,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP24_LOGICAL_OR_XOR' => 232,
			")" => -280,
			'OP08_STRING_CAT' => 236,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -280,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 474
		DEFAULT => -247
	},
	{#State 475
		ACTIONS => {
			")" => 500
		}
	},
	{#State 476
		DEFAULT => -239
	},
	{#State 477
		DEFAULT => -99
	},
	{#State 478
		DEFAULT => -243
	},
	{#State 479
		ACTIONS => {
			'LPAREN' => 501
		}
	},
	{#State 480
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 502
		}
	},
	{#State 481
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 503
		}
	},
	{#State 482
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 504
		}
	},
	{#State 483
		ACTIONS => {
			'LPAREN' => 505
		}
	},
	{#State 484
		ACTIONS => {
			"undef" => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'ARRAY_SYMBOL' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP01_PRINT' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'SCALAR_SYMBOL' => -58,
			"}" => -58,
			"if" => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'ENV' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'WORD_UPPERCASE' => -58,
			'WORD' => -58,
			"foreach" => -58,
			'LITERAL_NUMBER' => -58,
			'LPAREN_MY' => 508,
			"\@{" => -58,
			'SELF' => -58,
			"while" => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			"%{" => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			"for" => -58,
			'HASH_SYMBOL' => -58,
			'ARGV' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'ARRAY_REF_SYMBOL' => -58,
			'LPAREN' => -58,
			'HASH_REF_SYMBOL' => -58,
			'LBRACE' => -58,
			'POD' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'LBRACKET' => -58,
			'OP01_NAMED' => -58,
			'LPAREN_TYPE_INNER' => -58,
			'OP01_OPEN' => -58,
			'OP01_QW' => -58,
			'WORD_SCOPED' => -58,
			'MY' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP01_NAMED_VOID' => -58,
			'OP01_CLOSE' => -58,
			'LITERAL_STRING' => -58,
			'OP03_MATH_INC_DEC' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 506,
			'SubroutineArguments' => 507
		}
	},
	{#State 485
		ACTIONS => {
			";" => 509
		}
	},
	{#State 486
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 510
		}
	},
	{#State 487
		ACTIONS => {
			'OP20_HASH_FATARROW' => 511
		}
	},
	{#State 488
		DEFAULT => -76
	},
	{#State 489
		ACTIONS => {
			'LBRACE' => 512
		}
	},
	{#State 490
		ACTIONS => {
			'OP21_LIST_COMMA' => 513
		}
	},
	{#State 491
		ACTIONS => {
			'MY' => 243
		},
		GOTOS => {
			'ListElement' => 514,
			'TypeInner' => 281
		}
	},
	{#State 492
		DEFAULT => -263
	},
	{#State 493
		DEFAULT => -265
	},
	{#State 494
		DEFAULT => -314
	},
	{#State 495
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 515
		}
	},
	{#State 496
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 113,
			'MY' => 112,
			'OP01_NAMED_VOID' => 156,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 153,
			'LPAREN_TYPE_INNER' => 110,
			'POD' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 149,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			"for" => -178,
			'OP01_NAMED_VOID_LPAREN' => 172,
			"while" => -178,
			'SELF' => 131,
			"\@{" => 130,
			'WORD' => 31,
			"foreach" => -178,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 175,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			"}" => 516,
			"if" => 124,
			'SCALAR_SYMBOL' => 165,
			'OP01_NAMED_SCOLON' => 164,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP01_PRINT' => 166,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			"undef" => 170
		},
		GOTOS => {
			'Variable' => 141,
			'ArrayHashLiteralEmpty' => 142,
			'Expression' => 101,
			'OperatorVoid' => 144,
			'HashReference' => 147,
			'VariableDeclaration' => 103,
			'Hash' => 104,
			'ArrayReference' => 105,
			'Scalar' => 108,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'HashReferenceVariable' => 114,
			'HashVariable' => 115,
			'WordScoped' => 161,
			'VariableModification' => 163,
			'Statement' => 116,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'Array' => 123,
			'ScalarVariable' => 122,
			'SubExpression' => 125,
			'ArrayVariable' => 127,
			'HashReferenceLiteral' => 126,
			'LoopLabel' => 168,
			'HashDereference' => 129,
			'OPTIONAL-48' => 171,
			'PAREN-47' => 173,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 174,
			'Conditional' => 140,
			'Operation' => 517
		}
	},
	{#State 497
		DEFAULT => -201
	},
	{#State 498
		ACTIONS => {
			'OP01_OPEN' => -190,
			'OP01_QW' => -190,
			'OP01_NAMED' => -190,
			'LPAREN_TYPE_INNER' => -190,
			'MY' => -190,
			'OP01_NAMED_VOID_SCOLON' => -190,
			'OP01_NAMED_VOID' => -190,
			'OP01_CLOSE' => -190,
			'LITERAL_STRING' => -190,
			'OP03_MATH_INC_DEC' => -190,
			'WORD_SCOPED' => -190,
			'LBRACE' => -190,
			'HASH_REF_SYMBOL' => -190,
			'LPAREN' => -190,
			'CONSTANT_CALL_SCOPED' => -190,
			'POD' => -190,
			'LBRACKET' => -190,
			'OP05_LOGICAL_NEG' => -190,
			'ARRAY_REF_SYMBOL' => -190,
			'OP22_LOGICAL_NEG' => -190,
			"elsif" => 521,
			'HASH_SYMBOL' => -190,
			"%{" => -190,
			"for" => -190,
			'OP05_MATH_NEG_LPAREN' => -190,
			'ARGV' => -190,
			'OP19_LOOP_CONTROL' => -190,
			"\@{" => -190,
			'OP01_NAMED_VOID_LPAREN' => -190,
			"while" => -190,
			'SELF' => -190,
			'ENV' => -190,
			'OP05_BITWISE_NEG_LPAREN' => -190,
			"else" => 522,
			'OP10_NAMED_UNARY_SCOLON' => -190,
			'WORD' => -190,
			"foreach" => -190,
			'LITERAL_NUMBER' => -190,
			'WORD_UPPERCASE' => -190,
			'OP01_NAMED_SCOLON' => -190,
			'OP22_LOGICAL_NEG_LPAREN' => -190,
			"}" => -190,
			"if" => -190,
			'' => -190,
			'SCALAR_SYMBOL' => -190,
			'ARRAY_SYMBOL' => -190,
			'OP10_NAMED_UNARY' => -190,
			'OP01_PRINT' => -190,
			"undef" => -190,
			'OP19_LOOP_CONTROL_SCOLON' => -190
		},
		GOTOS => {
			'OPTIONAL-52' => 519,
			'PAREN-49' => 520,
			'PAREN-51' => 518
		}
	},
	{#State 499
		DEFAULT => -300
	},
	{#State 500
		DEFAULT => -102
	},
	{#State 501
		ACTIONS => {
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			"\@{" => 130,
			'SELF' => 131,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167
		},
		GOTOS => {
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'SubExpression' => 523,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 502
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP01_NAMED_SCOLON' => 526,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'OP10_NAMED_UNARY_SCOLON' => 525,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 524,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'OpNamedScolonOrSubExp' => 527,
			'HashVariable' => 190,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108
		}
	},
	{#State 503
		ACTIONS => {
			'ARGV' => 106,
			'STDIN' => 358,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'FHREF_SYMBOL_IN' => 359,
			'WORD_SCOPED' => 32,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SELF' => 131,
			"\@{" => 130
		},
		GOTOS => {
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'SubExpression' => 361,
			'SubExpressionOrInput' => 528,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152
		}
	},
	{#State 504
		DEFAULT => -198
	},
	{#State 505
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARGV' => 106,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118
		},
		GOTOS => {
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpressions' => 529,
			'SubExpression' => 259,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'WordScoped' => 161,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'Scalar' => 108
		}
	},
	{#State 506
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 530
		}
	},
	{#State 507
		DEFAULT => -57
	},
	{#State 508
		ACTIONS => {
			'TYPE_INTEGER' => 177,
			'WORD_SCOPED' => 179,
			'WORD' => 178
		},
		GOTOS => {
			'Type' => 531
		}
	},
	{#State 509
		DEFAULT => -83
	},
	{#State 510
		ACTIONS => {
			'OP21_LIST_COMMA' => 534,
			"}" => 532
		},
		GOTOS => {
			'PAREN-33' => 533
		}
	},
	{#State 511
		ACTIONS => {
			'MY' => 535
		},
		GOTOS => {
			'TypeInnerProperties' => 536
		}
	},
	{#State 512
		ACTIONS => {
			'LBRACE' => 537
		}
	},
	{#State 513
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'SELF' => 131,
			"\@{" => 130,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134
		},
		GOTOS => {
			'ScalarVariable' => 192,
			'Expression' => 188,
			'Array' => 123,
			'SubExpression' => 538,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Operator' => 107,
			'Scalar' => 108,
			'WordScoped' => 161,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136
		}
	},
	{#State 514
		DEFAULT => -262
	},
	{#State 515
		ACTIONS => {
			"undef" => 539
		}
	},
	{#State 516
		DEFAULT => -202
	},
	{#State 517
		DEFAULT => -200
	},
	{#State 518
		DEFAULT => -189
	},
	{#State 519
		DEFAULT => -191
	},
	{#State 520
		DEFAULT => -186
	},
	{#State 521
		ACTIONS => {
			'LPAREN' => 540
		}
	},
	{#State 522
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 541
		}
	},
	{#State 523
		ACTIONS => {
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP17_LIST_RANGE' => 542,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231
		}
	},
	{#State 524
		ACTIONS => {
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_MATH_ADD_SUB' => 228,
			";" => 543,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 525
		DEFAULT => -310
	},
	{#State 526
		DEFAULT => -309
	},
	{#State 527
		ACTIONS => {
			'SCALAR_SYMBOL' => 544
		}
	},
	{#State 528
		ACTIONS => {
			")" => 545
		}
	},
	{#State 529
		ACTIONS => {
			")" => 546
		}
	},
	{#State 530
		ACTIONS => {
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 149,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			"for" => -178,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_LOGICAL_NEG' => 100,
			'POD' => 117,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'MY' => 112,
			'OP01_NAMED_VOID' => 156,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 153,
			'LPAREN_TYPE_INNER' => 110,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'OP01_PRINT' => 166,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			"undef" => 170,
			"}" => 547,
			"if" => 124,
			'SCALAR_SYMBOL' => 165,
			'OP01_NAMED_SCOLON' => 164,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'WORD' => 31,
			"foreach" => -178,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 175,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 137,
			"while" => -178,
			'OP01_NAMED_VOID_LPAREN' => 172,
			'SELF' => 131,
			"\@{" => 130
		},
		GOTOS => {
			'OPTIONAL-48' => 171,
			'Conditional' => 140,
			'Operation' => 548,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 174,
			'ArrayReferenceLiteral' => 135,
			'PAREN-47' => 173,
			'SubExpression' => 125,
			'Array' => 123,
			'ScalarVariable' => 122,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'HashDereference' => 129,
			'LoopLabel' => 168,
			'ArrayVariable' => 127,
			'HashReferenceLiteral' => 126,
			'HashVariable' => 115,
			'HashReferenceVariable' => 114,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Statement' => 116,
			'VariableModification' => 163,
			'WordScoped' => 161,
			'OperatorVoid' => 144,
			'Expression' => 101,
			'ArrayHashLiteralEmpty' => 142,
			'Variable' => 141,
			'ArrayReference' => 105,
			'Hash' => 104,
			'VariableDeclaration' => 103,
			'HashReference' => 147
		}
	},
	{#State 531
		ACTIONS => {
			'SCALAR_SYMBOL' => 549
		}
	},
	{#State 532
		ACTIONS => {
			";" => 550
		}
	},
	{#State 533
		DEFAULT => -80
	},
	{#State 534
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 204,
			'WORD' => 198,
			'OP12_COMPARE_EQ_NE' => 207,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP01_NAMED' => 202,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_OPEN' => 211,
			'OP01_NAMED_VOID' => 203,
			'OP01_CLOSE' => 212,
			'OP23_LOGICAL_AND' => 205,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP19_LOOP_CONTROL' => 206,
			'OP10_NAMED_UNARY' => 209,
			'OP01_PRINT' => 200,
			'OP07_STRING_REPEAT' => 199,
			'OP22_LOGICAL_NEG' => 214,
			'OP11_COMPARE_LT_GT' => 213
		},
		GOTOS => {
			'OpStringOrWord' => 487,
			'HashEntryProperties' => 551
		}
	},
	{#State 535
		ACTIONS => {
			'TYPE_INTEGER' => 177,
			'WORD_SCOPED' => 179,
			'WORD' => 178
		},
		GOTOS => {
			'Type' => 552
		}
	},
	{#State 536
		DEFAULT => -281
	},
	{#State 537
		ACTIONS => {
			'MY' => 553
		}
	},
	{#State 538
		ACTIONS => {
			'OP23_LOGICAL_AND' => -103,
			'OP04_MATH_POW' => 229,
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			"}" => -103,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			")" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_STRING_CAT' => 236,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			"]" => -103,
			'OP08_MATH_ADD_SUB' => 228,
			'OP21_LIST_COMMA' => -103,
			";" => -103,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 539
		ACTIONS => {
			";" => 554
		}
	},
	{#State 540
		ACTIONS => {
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'WORD_SCOPED' => 32,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			"\@{" => 130,
			'SELF' => 131,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashReferenceVariable' => 189,
			'HashVariable' => 190,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashDereference' => 129,
			'Hash' => 104,
			'ArrayReference' => 105,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ScalarLiteral' => 120,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123,
			'SubExpression' => 555
		}
	},
	{#State 541
		DEFAULT => -188
	},
	{#State 542
		ACTIONS => {
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayVariable' => 191,
			'HashReference' => 147,
			'HashReferenceLiteral' => 126,
			'SubExpression' => 556,
			'Array' => 123,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142
		}
	},
	{#State 543
		DEFAULT => -311
	},
	{#State 544
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 557
		}
	},
	{#State 545
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 558
		}
	},
	{#State 546
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 559
		}
	},
	{#State 547
		DEFAULT => -61
	},
	{#State 548
		DEFAULT => -59
	},
	{#State 549
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 560
		}
	},
	{#State 550
		DEFAULT => -82
	},
	{#State 551
		DEFAULT => -79
	},
	{#State 552
		ACTIONS => {
			"\$TYPED_" => 561
		}
	},
	{#State 553
		ACTIONS => {
			'WORD_SCOPED' => 179,
			'TYPE_METHOD' => 562,
			'WORD' => 178,
			'TYPE_INTEGER' => 177
		},
		GOTOS => {
			'Type' => 316
		}
	},
	{#State 554
		DEFAULT => -217
	},
	{#State 555
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP08_STRING_CAT' => 236,
			")" => 563,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP11_COMPARE_LT_GT' => 230,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233
		}
	},
	{#State 556
		ACTIONS => {
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => -125,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => -125,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			")" => 564,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => -125,
			'OP08_MATH_ADD_SUB' => 228,
			'OP13_BITWISE_AND' => 225
		}
	},
	{#State 557
		ACTIONS => {
			'SELF' => 131,
			"\@{" => 130,
			'WORD_UPPERCASE' => 187,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'OP10_NAMED_UNARY_SCOLON' => 525,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 526,
			"undef" => 170,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'ARGV' => 106,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'HashRefLiteralEmpty' => 136,
			'WordScoped' => 161,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'OpNamedScolonOrSubExp' => 565,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'Hash' => 104,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'SubExpression' => 524,
			'Expression' => 188,
			'ScalarVariable' => 192,
			'Array' => 123
		}
	},
	{#State 558
		DEFAULT => -199
	},
	{#State 559
		DEFAULT => -197
	},
	{#State 560
		ACTIONS => {
			")" => 567,
			'OP21_LIST_COMMA' => 566
		},
		GOTOS => {
			'PAREN-26' => 568
		}
	},
	{#State 561
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP22_LOGICAL_NEG' => 214,
			'OP07_STRING_REPEAT' => 199,
			'OP10_NAMED_UNARY' => 209,
			'OP01_PRINT' => 200,
			'OP19_LOOP_CONTROL_SCOLON' => 201,
			'OP19_LOOP_CONTROL' => 206,
			'OP23_LOGICAL_AND' => 205,
			'OP01_NAMED_VOID' => 203,
			'OP01_CLOSE' => 212,
			'OP01_OPEN' => 211,
			'OP08_MATH_ADD_SUB' => 210,
			'OP01_NAMED' => 202,
			'OP12_COMPARE_EQ_NE' => 207,
			'WORD' => 198,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 204
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
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 571
		}
	},
	{#State 564
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 572
		}
	},
	{#State 565
		ACTIONS => {
			"\@{" => 130,
			'SELF' => 131,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'WORD_UPPERCASE' => 187,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			"undef" => 170,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'WORD_SCOPED' => 32,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'LPAREN' => 160,
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'HASH_SYMBOL' => 145,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'ARGV' => 106
		},
		GOTOS => {
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'Scalar' => 108,
			'HashVariable' => 115,
			'HashReferenceVariable' => 114,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 174,
			'HashRefLiteralEmpty' => 136,
			'VariableModification' => 573,
			'SubExpressionOrVarMod' => 574,
			'WordScoped' => 161,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'Variable' => 141,
			'SubExpression' => 575,
			'Expression' => 188,
			'ScalarVariable' => 122,
			'Array' => 123,
			'HashReferenceLiteral' => 126,
			'HashReference' => 147,
			'ArrayVariable' => 127,
			'ArrayReference' => 105,
			'HashDereference' => 129,
			'Hash' => 104
		}
	},
	{#State 566
		ACTIONS => {
			'MY' => 576
		}
	},
	{#State 567
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 577
		}
	},
	{#State 568
		DEFAULT => -63
	},
	{#State 569
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 579,
			'OP19_VARIABLE_ASSIGN' => 578
		}
	},
	{#State 570
		ACTIONS => {
			"}" => 580
		}
	},
	{#State 571
		DEFAULT => -185
	},
	{#State 572
		DEFAULT => -195
	},
	{#State 573
		DEFAULT => -175
	},
	{#State 574
		ACTIONS => {
			")" => 581
		}
	},
	{#State 575
		ACTIONS => {
			'OP08_STRING_CAT' => 236,
			")" => -174,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => 225,
			'OP08_MATH_ADD_SUB' => 228,
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234
		}
	},
	{#State 576
		ACTIONS => {
			'TYPE_INTEGER' => 177,
			'WORD' => 178,
			'WORD_SCOPED' => 179
		},
		GOTOS => {
			'Type' => 582
		}
	},
	{#State 577
		ACTIONS => {
			"\@ARG;" => 583
		}
	},
	{#State 578
		ACTIONS => {
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'LPAREN' => 160,
			'CONSTANT_CALL_SCOPED' => 118,
			'LBRACKET' => 162,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'OP01_NAMED' => 185,
			'LPAREN_TYPE_INNER' => 110,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			'OP01_CLOSE' => 111,
			'WORD_SCOPED' => 32,
			'HASH_SYMBOL' => 145,
			"%{" => 148,
			'OP05_MATH_NEG_LPAREN' => 146,
			'ARGV' => 106,
			'OP05_LOGICAL_NEG' => 100,
			'ARRAY_REF_SYMBOL' => 143,
			'OP22_LOGICAL_NEG' => 102,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			'WORD_UPPERCASE' => 187,
			"\@{" => 130,
			'SELF' => 131,
			'OP10_NAMED_UNARY' => 128,
			'ARRAY_SYMBOL' => 167,
			"undef" => 170,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'SCALAR_SYMBOL' => 165
		},
		GOTOS => {
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'Scalar' => 108,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'WordScoped' => 161,
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceVariable' => 186,
			'ArrayReferenceLiteral' => 135,
			'SubExpression' => 584,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188,
			'ScalarLiteral' => 120,
			'ArrayRefLiteralEmpty' => 119,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayReference' => 105,
			'Hash' => 104,
			'HashDereference' => 129,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126
		}
	},
	{#State 579
		ACTIONS => {
			'LBRACKET' => 162,
			'CONSTANT_CALL_SCOPED' => 118,
			'LPAREN' => 160,
			'HASH_REF_SYMBOL' => 158,
			'LBRACE' => 159,
			'WORD_SCOPED' => 32,
			'OP01_CLOSE' => 111,
			'OP03_MATH_INC_DEC' => 155,
			'LITERAL_STRING' => 154,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_NAMED' => 185,
			'OP01_QW' => 150,
			'OP01_OPEN' => 109,
			'ARGV' => 106,
			'OP05_MATH_NEG_LPAREN' => 146,
			"%{" => 148,
			'HASH_SYMBOL' => 145,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143,
			'OP05_LOGICAL_NEG' => 100,
			'WORD_UPPERCASE' => 187,
			'LITERAL_NUMBER' => 138,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'ENV' => 134,
			'SELF' => 131,
			"\@{" => 130,
			"undef" => 170,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'SCALAR_SYMBOL' => 165,
			'OP22_LOGICAL_NEG_LPAREN' => 121
		},
		GOTOS => {
			'HashRefLiteralEmpty' => 136,
			'ArrayReferenceLiteral' => 135,
			'ArrayReferenceVariable' => 186,
			'WordScoped' => 161,
			'Scalar' => 108,
			'Operator' => 107,
			'ArrayHashLiteral' => 151,
			'ArrayDereference' => 152,
			'HashVariable' => 190,
			'HashReferenceVariable' => 189,
			'HashReference' => 147,
			'ArrayVariable' => 191,
			'HashReferenceLiteral' => 126,
			'Hash' => 104,
			'HashDereference' => 129,
			'ArrayReference' => 105,
			'ScalarLiteral' => 120,
			'ArrayHashLiteralEmpty' => 142,
			'ArrayRefLiteralEmpty' => 119,
			'SubExpression' => 585,
			'Array' => 123,
			'ScalarVariable' => 192,
			'Expression' => 188
		}
	},
	{#State 580
		ACTIONS => {
			";" => 586
		}
	},
	{#State 581
		ACTIONS => {
			'LBRACE' => 467
		},
		GOTOS => {
			'CodeBlock' => 587
		}
	},
	{#State 582
		ACTIONS => {
			'SCALAR_SYMBOL' => 588
		}
	},
	{#State 583
		DEFAULT => -65
	},
	{#State 584
		ACTIONS => {
			'OP06_REGEX_BIND' => 226,
			'OP15_LOGICAL_AND' => 233,
			'OP04_MATH_POW' => 229,
			'OP23_LOGICAL_AND' => 238,
			"}" => -301,
			'OP11_COMPARE_LT_GT' => 230,
			'OP07_STRING_REPEAT' => 234,
			'OP18_TERNARY' => 227,
			'OP16_LOGICAL_OR' => 235,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP09_BITWISE_SHIFT' => 222,
			'OP08_STRING_CAT' => 236,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP17_LIST_RANGE' => 224,
			'OP13_BITWISE_AND' => 225,
			'OP21_LIST_COMMA' => -301,
			'OP08_MATH_ADD_SUB' => 228
		}
	},
	{#State 585
		ACTIONS => {
			'OP15_LOGICAL_AND' => 233,
			'OP06_REGEX_BIND' => 226,
			'OP23_LOGICAL_AND' => 238,
			'OP04_MATH_POW' => 229,
			'OP11_COMPARE_LT_GT' => 230,
			'OP18_TERNARY' => 227,
			'OP07_STRING_REPEAT' => 234,
			'OP24_LOGICAL_OR_XOR' => 232,
			'OP08_STRING_CAT' => 236,
			'OP09_BITWISE_SHIFT' => 222,
			'OP12_COMPARE_EQ_NE' => 223,
			'OP14_BITWISE_OR_XOR' => 231,
			'OP16_LOGICAL_OR' => 235,
			'OP17_LIST_RANGE' => 224,
			'OP07_MATH_MULT_DIV_MOD' => 237,
			'OP13_BITWISE_AND' => 225,
			"]" => 589,
			'OP08_MATH_ADD_SUB' => 228
		}
	},
	{#State 586
		ACTIONS => {
			'OP01_QW' => -85,
			'OP01_OPEN' => -85,
			'LPAREN_TYPE_INNER' => -85,
			'OP01_NAMED' => -85,
			'LITERAL_STRING' => -85,
			'OP01_CLOSE' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'MY' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP01_NAMED_VOID' => -85,
			'WORD_SCOPED' => -85,
			'HASH_REF_SYMBOL' => -85,
			'LBRACE' => -85,
			'LPAREN' => -85,
			'LBRACKET' => -85,
			'POD' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP05_LOGICAL_NEG' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'HASH_SYMBOL' => -85,
			"for" => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			"%{" => -85,
			'OP19_LOOP_CONTROL' => -85,
			'ARGV' => -85,
			"\@{" => -85,
			'LPAREN_MY' => 591,
			"while" => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'SELF' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'ENV' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'LITERAL_NUMBER' => -85,
			'WORD' => -85,
			"foreach" => -85,
			'WORD_UPPERCASE' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			"}" => -85,
			"if" => -85,
			'SCALAR_SYMBOL' => -85,
			'OP01_PRINT' => -85,
			'OP10_NAMED_UNARY' => -85,
			'ARRAY_SYMBOL' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			"undef" => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 590,
			'MethodArguments' => 592
		}
	},
	{#State 587
		DEFAULT => -196
	},
	{#State 588
		DEFAULT => -62
	},
	{#State 589
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 593
		}
	},
	{#State 590
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 594
		}
	},
	{#State 591
		ACTIONS => {
			'TYPE_INTEGER' => 177,
			'WORD' => 178,
			'WORD_SCOPED' => 179
		},
		GOTOS => {
			'Type' => 595
		}
	},
	{#State 592
		DEFAULT => -84
	},
	{#State 593
		ACTIONS => {
			"undef" => 596
		}
	},
	{#State 594
		ACTIONS => {
			'OP10_NAMED_UNARY_SCOLON' => 137,
			'ENV' => 134,
			'OP05_BITWISE_NEG_LPAREN' => 133,
			'WORD_UPPERCASE' => 175,
			"foreach" => -178,
			'WORD' => 31,
			'LITERAL_NUMBER' => 138,
			"\@{" => 130,
			'SELF' => 131,
			"while" => -178,
			'OP01_NAMED_VOID_LPAREN' => 172,
			"undef" => 170,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			'ARRAY_SYMBOL' => 167,
			'OP10_NAMED_UNARY' => 128,
			'OP01_PRINT' => 166,
			'OP22_LOGICAL_NEG_LPAREN' => 121,
			'OP01_NAMED_SCOLON' => 164,
			'SCALAR_SYMBOL' => 165,
			"if" => 124,
			"}" => 597,
			'LPAREN' => 160,
			'LBRACE' => 159,
			'HASH_REF_SYMBOL' => 158,
			'CONSTANT_CALL_SCOPED' => 118,
			'POD' => 117,
			'LBRACKET' => 162,
			'OP01_NAMED' => 153,
			'LPAREN_TYPE_INNER' => 110,
			'OP01_OPEN' => 109,
			'OP01_QW' => 150,
			'WORD_SCOPED' => 32,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'MY' => 112,
			'OP01_NAMED_VOID' => 156,
			'OP01_CLOSE' => 111,
			'LITERAL_STRING' => 154,
			'OP03_MATH_INC_DEC' => 155,
			"%{" => 148,
			"for" => -178,
			'OP05_MATH_NEG_LPAREN' => 146,
			'HASH_SYMBOL' => 145,
			'ARGV' => 106,
			'OP19_LOOP_CONTROL' => 149,
			'OP05_LOGICAL_NEG' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'ARRAY_REF_SYMBOL' => 143
		},
		GOTOS => {
			'ArrayReferenceVariable' => 174,
			'ArrayReferenceLiteral' => 135,
			'HashRefLiteralEmpty' => 136,
			'PAREN-47' => 173,
			'Operation' => 598,
			'Conditional' => 140,
			'OPTIONAL-48' => 171,
			'HashReferenceLiteral' => 126,
			'ArrayVariable' => 127,
			'LoopLabel' => 168,
			'HashDereference' => 129,
			'ArrayRefLiteralEmpty' => 119,
			'ScalarLiteral' => 120,
			'SubExpression' => 125,
			'ScalarVariable' => 122,
			'Array' => 123,
			'Statement' => 116,
			'VariableModification' => 163,
			'WordScoped' => 161,
			'ArrayDereference' => 152,
			'ArrayHashLiteral' => 151,
			'Operator' => 107,
			'Scalar' => 108,
			'HashVariable' => 115,
			'HashReferenceVariable' => 114,
			'HashReference' => 147,
			'VariableDeclaration' => 103,
			'Hash' => 104,
			'ArrayReference' => 105,
			'ArrayHashLiteralEmpty' => 142,
			'Variable' => 141,
			'OperatorVoid' => 144,
			'Expression' => 101
		}
	},
	{#State 595
		ACTIONS => {
			'SELF' => 599
		}
	},
	{#State 596
		DEFAULT => -302
	},
	{#State 597
		DEFAULT => -88
	},
	{#State 598
		DEFAULT => -86
	},
	{#State 599
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 600
		}
	},
	{#State 600
		ACTIONS => {
			'OP21_LIST_COMMA' => 601,
			")" => 603
		},
		GOTOS => {
			'PAREN-37' => 602
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
			'OP19_VARIABLE_ASSIGN' => 605
		}
	},
	{#State 604
		ACTIONS => {
			'TYPE_INTEGER' => 177,
			'WORD_SCOPED' => 179,
			'WORD' => 178
		},
		GOTOS => {
			'Type' => 606
		}
	},
	{#State 605
		ACTIONS => {
			"\@ARG;" => 607
		}
	},
	{#State 606
		ACTIONS => {
			'SCALAR_SYMBOL' => 608
		}
	},
	{#State 607
		DEFAULT => -92
	},
	{#State 608
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 10253 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10260 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10267 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10274 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10285 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10296 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10310 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10317 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10324 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10331 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10338 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10359 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10366 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10373 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10380 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10391 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10398 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10405 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10419 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10430 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10441 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10452 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10459 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10466 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10473 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10480 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10487 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10494 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10501 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10508 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10515 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10522 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10533 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10547 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10558 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10565 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10572 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10583 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10590 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10597 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10604 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10611 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10618 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10625 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10636 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10643 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10664 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10675 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10686 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10697 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10704 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10711 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10718 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 214 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10725 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10736 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10743 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10750 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10757 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10768 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10775 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10782 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10789 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10796 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10838 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10849 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10860 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10871 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10878 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10885 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 218 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10892 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10903 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10928 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10935 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 220 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10942 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10953 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10960 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10974 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10985 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10996 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11007 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11018 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11029 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11040 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11051 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11062 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11073 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11084 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11095 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11106 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11117 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11128 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11139 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11150 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11161 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11172 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11183 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11194 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11205 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11216 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11227 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11238 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11249 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11260 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11271 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11282 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11293 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11304 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11315 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11326 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11337 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11348 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_130
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11403 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11410 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11417 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11424 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11431 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11438 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11449 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11460 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11471 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11482 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11493 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11504 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11515 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_143
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11526 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11533 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 244 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11547 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11554 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11561 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11568 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11579 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11590 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11601 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11612 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11623 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_155
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11634 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11645 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11656 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11667 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11678 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11689 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11700 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11711 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11722 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_164
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11733 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_165
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11744 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_166
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11755 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11762 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11769 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11776 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressions_170
		 'SubExpressions', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11787 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_171
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11798 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_172
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11809 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_173
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11820 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_174
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11831 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_175
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11842 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11849 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11856 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11863 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_179
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11874 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_180
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11885 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_181
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11896 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_182
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11907 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_183
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11918 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_184
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11929 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 5,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11950 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11964 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11971 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_191
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11982 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_192
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11993 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_193
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12004 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_194
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12015 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_195
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12026 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_196
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12037 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_197
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12048 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_198
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12059 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_199
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12070 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12077 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12084 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_202
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12095 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_203
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12106 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_204
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12117 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_205
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12128 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_206
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12139 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_207
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12150 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_208
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12161 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_209
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12172 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_210
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12183 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_211
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12194 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_212
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12205 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_213
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12216 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_214
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12227 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_215
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12238 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_216
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12249 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_217
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12260 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_218
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12271 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_219
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12282 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_220
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12293 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_221
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12304 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_222
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12315 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_223
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12326 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_224
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12337 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_225
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12348 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_226
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12359 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_227
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12370 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_228
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12381 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12388 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12395 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 2,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12402 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-55', 1,
sub {
#line 300 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12409 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_233
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12420 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_234
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12431 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_235
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12442 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_236
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12453 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_237
		 'ScalarVariable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12464 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteral_238
		 'ArrayHashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12475 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-56', 2,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12482 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 2,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12489 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-57', 0,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12496 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEs_242
		 'ArrayHashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12507 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12514 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12521 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 306 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12528 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralEs_246
		 'ArrayLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12539 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 307 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12546 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 307 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12553 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 307 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12560 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralEs_250
		 'HashLiteralEs', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12571 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_251
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12582 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralE_252
		 'ArrayLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12593 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_253
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12604 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteralE_254
		 'HashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12615 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_255
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12626 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_256
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12637 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralE_257
		 'ArrayHashLiteralE', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12648 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEmpty_258
		 'ArrayHashLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12659 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayRefLiteralEmpty_259
		 'ArrayRefLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12670 lib/RPerl/Grammar.pm
	],
	[#Rule HashRefLiteralEmpty_260
		 'HashRefLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12681 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_261
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12692 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-62', 2,
sub {
#line 315 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12699 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 2,
sub {
#line 315 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12706 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-63', 0,
sub {
#line 315 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12713 lib/RPerl/Grammar.pm
	],
	[#Rule Array_265
		 'Array', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12724 lib/RPerl/Grammar.pm
	],
	[#Rule Array_266
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12735 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_267
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12746 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_268
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12757 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_269
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12768 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_270
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12779 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_271
		 'ArrayReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12790 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_272
		 'ArrayReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12801 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceVariable_273
		 'ArrayReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 1,
sub {
#line 320 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-64', 0,
sub {
#line 320 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12826 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_276
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12837 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_277
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 1,
sub {
#line 321 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12855 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-65', 0,
sub {
#line 321 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12862 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_280
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12873 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_281
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12884 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_282
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12895 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_283
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12906 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_284
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12917 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_285
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12928 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_286
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12939 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_287
		 'HashReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12950 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_288
		 'HashReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12961 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceVariable_289
		 'HashReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12972 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-66', 1,
sub {
#line 328 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-66', 0,
sub {
#line 328 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12986 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_292
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12997 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_293
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13008 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_294
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13019 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_295
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13030 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_296
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13041 lib/RPerl/Grammar.pm
	],
	[#Rule Type_297
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13052 lib/RPerl/Grammar.pm
	],
	[#Rule Type_298
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13063 lib/RPerl/Grammar.pm
	],
	[#Rule Type_299
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13074 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_300
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13085 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_301
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13096 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_302
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13107 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_303
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13118 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_304
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13129 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrLiteral_305
		 'ScalarVariableOrLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13140 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_306
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13151 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_307
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13162 lib/RPerl/Grammar.pm
	],
	[#Rule ScaVarOrLitOrOpStrOrWord_308
		 'ScaVarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13173 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_309
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13184 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_310
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13195 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_311
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13206 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_312
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13217 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_313
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13228 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_314
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13239 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_315
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13250 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_316
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13261 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_317
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13272 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_318
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13283 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_319
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13294 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_320
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13305 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_321
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13316 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_322
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13327 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_323
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13338 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_324
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13349 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_325
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13360 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_326
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13371 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_327
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13382 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_328
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13393 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_329
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13404 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_330
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13415 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_331
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13426 lib/RPerl/Grammar.pm
	]
],
#line 13429 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ScalarVariable_233', 
         'ScalarVariable_234', 
         'ScalarVariable_235', 
         'ScalarVariable_236', 
         'ScalarVariable_237', 
         'ArrayHashLiteral_238', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayHashLiteralEs_242', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayLiteralEs_246', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashLiteralEs_250', 
         'ArrayLiteralE_251', 
         'ArrayLiteralE_252', 
         'HashLiteralE_253', 
         'HashLiteralE_254', 
         'ArrayHashLiteralE_255', 
         'ArrayHashLiteralE_256', 
         'ArrayHashLiteralE_257', 
         'ArrayHashLiteralEmpty_258', 
         'ArrayRefLiteralEmpty_259', 
         'HashRefLiteralEmpty_260', 
         'ListElement_261', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Array_265', 
         'Array_266', 
         'ArrayVariable_267', 
         'ArrayVariable_268', 
         'ArrayReference_269', 
         'ArrayReference_270', 
         'ArrayReferenceLiteral_271', 
         'ArrayReferenceLiteral_272', 
         'ArrayReferenceVariable_273', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_276', 
         'ArrayDereference_277', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_280', 
         'HashEntryProperties_281', 
         'Hash_282', 
         'HashVariable_283', 
         'HashVariable_284', 
         'HashReference_285', 
         'HashReference_286', 
         'HashReferenceLiteral_287', 
         'HashReferenceLiteral_288', 
         'HashReferenceVariable_289', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_292', 
         'HashDereference_293', 
         'WordScoped_294', 
         'WordScoped_295', 
         'LoopLabel_296', 
         'Type_297', 
         'Type_298', 
         'Type_299', 
         'TypeInner_300', 
         'TypeInnerProperties_301', 
         'TypeInnerProperties_302', 
         'TypeInnerConstant_303', 
         'ScalarVariableOrLiteral_304', 
         'ScalarVariableOrLiteral_305', 
         'ScaVarOrLitOrOpStrOrWord_306', 
         'ScaVarOrLitOrOpStrOrWord_307', 
         'ScaVarOrLitOrOpStrOrWord_308', 
         'OpNamedScolonOrSubExp_309', 
         'OpNamedScolonOrSubExp_310', 
         'OpNamedScolonOrSubExp_311', 
         'OpNamedScolonOrSubExpIn_312', 
         'OpNamedScolonOrSubExpIn_313', 
         'OpNamedScolonOrSubExpIn_314', 
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
         'OpStringOrWord_330', 
         'OpStringOrWord_331', );
  $self;
}

#line 347 "lib/RPerl/Grammar.eyp"


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


#line 13977 lib/RPerl/Grammar.pm



1;
