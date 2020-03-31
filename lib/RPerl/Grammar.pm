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

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|foreach|\$TYPED_|package|undef|\@ARG\;|elsif|while|else|INIT|for|\@\{|\%\{|if|\}|\)|\]|\;)}gc and return ($1, $1);

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
      /\G(croak\(|exit\(|return\s*\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
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
  [ 'SubExpression_159' => 'SubExpression', [ 'Array' ], 0 ],
  [ 'SubExpression_160' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_161' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_162' => 'SubExpression', [ 'Hash' ], 0 ],
  [ 'SubExpression_163' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_164' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'SubExpressions_168' => 'SubExpressions', [ 'SubExpression', 'STAR-46' ], 0 ],
  [ 'SubExpressionOrInput_169' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_170' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_171' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_172' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_173' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'PAREN-47' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'Statement_177' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_178' => 'Statement', [ 'OPTIONAL-48', 'Loop' ], 0 ],
  [ 'Statement_179' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_180' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_181' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ 'Statement_182' => 'Statement', [ 'POD' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [ 'PAREN-51' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-52', [  ], 0 ],
  [ 'Conditional_189' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-50', 'OPTIONAL-52' ], 0 ],
  [ 'Loop_190' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_191' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_192' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_193' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_194' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'SCALAR_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_195' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'SCALAR_SYMBOL', 'LPAREN', 'SubExpressions', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_196' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_197' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'PLUS-53', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-53', [ 'Operation' ], 0 ],
  [ 'CodeBlock_200' => 'CodeBlock', [ 'LBRACE', 'PLUS-53', '}' ], 0 ],
  [ 'Variable_201' => 'Variable', [ 'ScalarVariable' ], 0 ],
  [ 'Variable_202' => 'Variable', [ 'ArrayVariable' ], 0 ],
  [ 'Variable_203' => 'Variable', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'Variable_204' => 'Variable', [ 'HashVariable' ], 0 ],
  [ 'Variable_205' => 'Variable', [ 'HashReferenceVariable' ], 0 ],
  [ 'VariableRetrievalArrow_206' => 'VariableRetrievalArrow', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrievalArrow_207' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrievalArrow_208' => 'VariableRetrievalArrow', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableRetrieval_209' => 'VariableRetrieval', [ 'VariableRetrievalArrow' ], 0 ],
  [ 'VariableRetrieval_210' => 'VariableRetrieval', [ 'LBRACKET', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_211' => 'VariableRetrieval', [ 'LBRACE', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_212' => 'VariableRetrieval', [ 'LBRACE', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_213' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_214' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_215' => 'VariableDeclaration', [ 'MY', 'Type', 'SCALAR_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_216' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_217' => 'VariableDeclaration', [ 'MY', 'Type', 'ARRAY_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_218' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_219' => 'VariableDeclaration', [ 'MY', 'Type', 'HASH_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_220' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_221' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_222' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ 'Scalar_223' => 'Scalar', [ 'ScalarLiteral' ], 0 ],
  [ 'Scalar_224' => 'Scalar', [ 'ScalarVariable' ], 0 ],
  [ 'ScalarLiteral_225' => 'ScalarLiteral', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'ScalarLiteral_226' => 'ScalarLiteral', [ 'LITERAL_STRING' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'PLUS-54', 'VariableRetrieval' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-54', [ 'VariableRetrieval' ], 0 ],
  [ 'ScalarVariable_229' => 'ScalarVariable', [ 'ScalarVariableOrSelf' ], 0 ],
  [ 'ScalarVariable_230' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow' ], 0 ],
  [ 'ScalarVariable_231' => 'ScalarVariable', [ 'ScalarVariableOrSelf', 'VariableRetrievalArrow', 'PLUS-54' ], 0 ],
  [ 'ScalarVariableOrSelf_232' => 'ScalarVariableOrSelf', [ 'SCALAR_SYMBOL' ], 0 ],
  [ 'ScalarVariableOrSelf_233' => 'ScalarVariableOrSelf', [ 'SELF' ], 0 ],
  [ 'ArrayHashLiteralEmpty_234' => 'ArrayHashLiteralEmpty', [ 'LPAREN', ')' ], 0 ],
  [ 'BracketsEmpty_235' => 'BracketsEmpty', [ 'LBRACKET', ']' ], 0 ],
  [ 'BracesEmpty_236' => 'BracesEmpty', [ 'LBRACE', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-55', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [ 'STAR-56', 'PAREN-55' ], 0 ],
  [ '_STAR_LIST' => 'STAR-56', [  ], 0 ],
  [ 'ListElements_240' => 'ListElements', [ 'ListElement', 'STAR-56' ], 0 ],
  [ 'ListElement_241' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_242' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_243' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_244' => 'ListElement', [ 'ARGV' ], 0 ],
  [ 'Array_245' => 'Array', [ 'ArrayLiteralNonEmpty' ], 0 ],
  [ 'Array_246' => 'Array', [ 'ArrayVariable' ], 0 ],
  [ '_PAREN' => 'PAREN-57', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [ 'STAR-58', 'PAREN-57' ], 0 ],
  [ '_STAR_LIST' => 'STAR-58', [  ], 0 ],
  [ 'ArrayLiteralNonEmpty_250' => 'ArrayLiteralNonEmpty', [ 'LPAREN', 'ListElements', ')' ], 0 ],
  [ 'ArrayLiteralNonEmpty_251' => 'ArrayLiteralNonEmpty', [ 'LPAREN_TYPE_INNER', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression', 'STAR-58', ')' ], 0 ],
  [ 'ArrayVariable_252' => 'ArrayVariable', [ 'ARRAY_SYMBOL' ], 0 ],
  [ 'ArrayReference_253' => 'ArrayReference', [ 'ArrayReferenceLiteral' ], 0 ],
  [ 'ArrayReference_254' => 'ArrayReference', [ 'ArrayReferenceVariable' ], 0 ],
  [ 'ArrayReferenceLiteral_255' => 'ArrayReferenceLiteral', [ 'LBRACKET', 'ListElements', ']' ], 0 ],
  [ 'ArrayReferenceLiteral_256' => 'ArrayReferenceLiteral', [ 'BracketsEmpty' ], 0 ],
  [ 'ArrayReferenceVariable_257' => 'ArrayReferenceVariable', [ 'ARRAY_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-59', [  ], 0 ],
  [ 'ArrayDereference_260' => 'ArrayDereference', [ '@{', 'ScalarVariable', '}' ], 0 ],
  [ 'ArrayDereference_261' => 'ArrayDereference', [ '@{', 'OPTIONAL-59', 'ArrayReference', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-60', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [ 'STAR-61', 'PAREN-60' ], 0 ],
  [ '_STAR_LIST' => 'STAR-61', [  ], 0 ],
  [ 'HashEntries_265' => 'HashEntries', [ 'HashEntry', 'STAR-61' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-62', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-62', [  ], 0 ],
  [ 'HashEntry_268' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-62', 'SubExpression' ], 0 ],
  [ 'HashEntry_269' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_270' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ 'Hash_271' => 'Hash', [ 'HashLiteral' ], 0 ],
  [ 'Hash_272' => 'Hash', [ 'HashVariable' ], 0 ],
  [ 'HashLiteral_273' => 'HashLiteral', [ 'LPAREN', 'HashEntries', ')' ], 0 ],
  [ 'HashVariable_274' => 'HashVariable', [ 'HASH_SYMBOL' ], 0 ],
  [ 'HashReference_275' => 'HashReference', [ 'HashReferenceLiteral' ], 0 ],
  [ 'HashReference_276' => 'HashReference', [ 'HashReferenceVariable' ], 0 ],
  [ 'HashReferenceLiteral_277' => 'HashReferenceLiteral', [ 'LBRACE', 'HashEntries', '}' ], 0 ],
  [ 'HashReferenceLiteral_278' => 'HashReferenceLiteral', [ 'BracesEmpty' ], 0 ],
  [ 'HashReferenceVariable_279' => 'HashReferenceVariable', [ 'HASH_REF_SYMBOL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-63', [  ], 0 ],
  [ 'HashDereference_282' => 'HashDereference', [ '%{', 'ScalarVariable', '}' ], 0 ],
  [ 'HashDereference_283' => 'HashDereference', [ '%{', 'OPTIONAL-63', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_284' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_285' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_286' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_287' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_288' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_289' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_290' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_291' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_292' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_293' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_294' => 'VarOrLitOrOpStrOrWord', [ 'ScalarVariable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_295' => 'VarOrLitOrOpStrOrWord', [ 'ScalarLiteral' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_296' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'OpNamedScolonOrSubExp_297' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_298' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_299' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_300' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_301' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_302' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_303' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_304' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_305' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_306' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_307' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_308' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_309' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_310' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_311' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_312' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_313' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_314' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_315' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_316' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_317' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_318' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_319' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PAREN' => 165,
  '_STAR_LIST' => 166,
  '_STAR_LIST' => 167,
  'SubExpressions_168' => 168,
  'SubExpressionOrInput_169' => 169,
  'SubExpressionOrInput_170' => 170,
  'SubExpressionOrInput_171' => 171,
  'SubExpressionOrVarMod_172' => 172,
  'SubExpressionOrVarMod_173' => 173,
  '_PAREN' => 174,
  '_OPTIONAL' => 175,
  '_OPTIONAL' => 176,
  'Statement_177' => 177,
  'Statement_178' => 178,
  'Statement_179' => 179,
  'Statement_180' => 180,
  'Statement_181' => 181,
  'Statement_182' => 182,
  '_PAREN' => 183,
  '_STAR_LIST' => 184,
  '_STAR_LIST' => 185,
  '_PAREN' => 186,
  '_OPTIONAL' => 187,
  '_OPTIONAL' => 188,
  'Conditional_189' => 189,
  'Loop_190' => 190,
  'Loop_191' => 191,
  'Loop_192' => 192,
  'LoopFor_193' => 193,
  'LoopFor_194' => 194,
  'LoopForEach_195' => 195,
  'LoopWhile_196' => 196,
  'LoopWhile_197' => 197,
  '_PLUS_LIST' => 198,
  '_PLUS_LIST' => 199,
  'CodeBlock_200' => 200,
  'Variable_201' => 201,
  'Variable_202' => 202,
  'Variable_203' => 203,
  'Variable_204' => 204,
  'Variable_205' => 205,
  'VariableRetrievalArrow_206' => 206,
  'VariableRetrievalArrow_207' => 207,
  'VariableRetrievalArrow_208' => 208,
  'VariableRetrieval_209' => 209,
  'VariableRetrieval_210' => 210,
  'VariableRetrieval_211' => 211,
  'VariableRetrieval_212' => 212,
  'VariableDeclaration_213' => 213,
  'VariableDeclaration_214' => 214,
  'VariableDeclaration_215' => 215,
  'VariableDeclaration_216' => 216,
  'VariableDeclaration_217' => 217,
  'VariableDeclaration_218' => 218,
  'VariableDeclaration_219' => 219,
  'VariableDeclaration_220' => 220,
  'VariableModification_221' => 221,
  'VariableModification_222' => 222,
  'Scalar_223' => 223,
  'Scalar_224' => 224,
  'ScalarLiteral_225' => 225,
  'ScalarLiteral_226' => 226,
  '_PLUS_LIST' => 227,
  '_PLUS_LIST' => 228,
  'ScalarVariable_229' => 229,
  'ScalarVariable_230' => 230,
  'ScalarVariable_231' => 231,
  'ScalarVariableOrSelf_232' => 232,
  'ScalarVariableOrSelf_233' => 233,
  'ArrayHashLiteralEmpty_234' => 234,
  'BracketsEmpty_235' => 235,
  'BracesEmpty_236' => 236,
  '_PAREN' => 237,
  '_STAR_LIST' => 238,
  '_STAR_LIST' => 239,
  'ListElements_240' => 240,
  'ListElement_241' => 241,
  'ListElement_242' => 242,
  'ListElement_243' => 243,
  'ListElement_244' => 244,
  'Array_245' => 245,
  'Array_246' => 246,
  '_PAREN' => 247,
  '_STAR_LIST' => 248,
  '_STAR_LIST' => 249,
  'ArrayLiteralNonEmpty_250' => 250,
  'ArrayLiteralNonEmpty_251' => 251,
  'ArrayVariable_252' => 252,
  'ArrayReference_253' => 253,
  'ArrayReference_254' => 254,
  'ArrayReferenceLiteral_255' => 255,
  'ArrayReferenceLiteral_256' => 256,
  'ArrayReferenceVariable_257' => 257,
  '_OPTIONAL' => 258,
  '_OPTIONAL' => 259,
  'ArrayDereference_260' => 260,
  'ArrayDereference_261' => 261,
  '_PAREN' => 262,
  '_STAR_LIST' => 263,
  '_STAR_LIST' => 264,
  'HashEntries_265' => 265,
  '_OPTIONAL' => 266,
  '_OPTIONAL' => 267,
  'HashEntry_268' => 268,
  'HashEntry_269' => 269,
  'HashEntryProperties_270' => 270,
  'Hash_271' => 271,
  'Hash_272' => 272,
  'HashLiteral_273' => 273,
  'HashVariable_274' => 274,
  'HashReference_275' => 275,
  'HashReference_276' => 276,
  'HashReferenceLiteral_277' => 277,
  'HashReferenceLiteral_278' => 278,
  'HashReferenceVariable_279' => 279,
  '_OPTIONAL' => 280,
  '_OPTIONAL' => 281,
  'HashDereference_282' => 282,
  'HashDereference_283' => 283,
  'WordScoped_284' => 284,
  'WordScoped_285' => 285,
  'LoopLabel_286' => 286,
  'Type_287' => 287,
  'Type_288' => 288,
  'Type_289' => 289,
  'TypeInner_290' => 290,
  'TypeInnerProperties_291' => 291,
  'TypeInnerProperties_292' => 292,
  'TypeInnerConstant_293' => 293,
  'VarOrLitOrOpStrOrWord_294' => 294,
  'VarOrLitOrOpStrOrWord_295' => 295,
  'VarOrLitOrOpStrOrWord_296' => 296,
  'OpNamedScolonOrSubExp_297' => 297,
  'OpNamedScolonOrSubExp_298' => 298,
  'OpNamedScolonOrSubExp_299' => 299,
  'OpNamedScolonOrSubExpIn_300' => 300,
  'OpNamedScolonOrSubExpIn_301' => 301,
  'OpNamedScolonOrSubExpIn_302' => 302,
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
  'OpStringOrWord_317' => 317,
  'OpStringOrWord_318' => 318,
  'OpStringOrWord_319' => 319,
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
			"## no critic qw(" => 9,
			'SHEBANG' => 4,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'PLUS-2' => 5,
			'Critic' => 3,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 2,
			'ModuleHeader' => 7,
			'CompileUnit' => 1,
			'Program' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 9,
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 3,
			'PAREN-1' => 13,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 7
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => -27,
			'SUB' => -27,
			"use parent qw(" => 18,
			"use constant" => -27,
			"INIT" => -27,
			'USE_EXPORTER' => -27,
			'USE' => -27,
			"use parent -norequire, qw(" => 16
		},
		GOTOS => {
			'Package' => 19,
			'STAR-11' => 20,
			'UseParent' => 15,
			'Module' => 17,
			'Class' => 14
		}
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => 22,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 21
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 24
		},
		GOTOS => {
			'PLUS-17' => 23
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		DEFAULT => -25
	},
	{#State 15
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		DEFAULT => -78
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		DEFAULT => -77
	},
	{#State 19
		DEFAULT => -24
	},
	{#State 20
		ACTIONS => {
			"## no critic qw(" => 9,
			'SUB' => -29,
			'USE_EXPORTER' => 31,
			'USE' => -29,
			"use constant" => -29,
			"INIT" => -29
		},
		GOTOS => {
			'OPTIONAL-12' => 32,
			'Exports' => 29,
			'Critic' => 30
		}
	},
	{#State 21
		ACTIONS => {
			"package" => 33
		}
	},
	{#State 22
		DEFAULT => -21
	},
	{#State 23
		ACTIONS => {
			'WORD' => 35,
			")" => 34
		}
	},
	{#State 24
		DEFAULT => -41
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 26
		DEFAULT => -285
	},
	{#State 27
		ACTIONS => {
			")" => 38
		}
	},
	{#State 28
		DEFAULT => -284
	},
	{#State 29
		DEFAULT => -28
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		ACTIONS => {
			'SUB' => -45,
			"our hashref \$properties" => -45,
			"INIT" => -45,
			"use constant" => -45,
			'OUR_EXPORT' => 41,
			'OUR_EXPORT_OK' => -45,
			'USE' => -45
		},
		GOTOS => {
			'PAREN-18' => 39,
			'OPTIONAL-19' => 40
		}
	},
	{#State 32
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 42
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 43
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
			"use warnings;" => 44
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
			";" => 46
		}
	},
	{#State 39
		DEFAULT => -44
	},
	{#State 40
		ACTIONS => {
			'SUB' => -48,
			'USE' => -48,
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 49,
			"INIT" => -48,
			"use constant" => -48
		},
		GOTOS => {
			'OPTIONAL-21' => 47,
			'PAREN-20' => 48
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 50
		}
	},
	{#State 42
		ACTIONS => {
			"use constant" => -33,
			"INIT" => 51,
			'USE' => 54,
			'SUB' => -33
		},
		GOTOS => {
			'STAR-14' => 53,
			'Include' => 52
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55
		}
	},
	{#State 44
		ACTIONS => {
			'USE_RPERL_AFTER' => 57,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_STRING' => -11,
			'ARRAY_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'SCALAR_SYMBOL' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_NAMED_VOID' => -11,
			'LBRACE' => -11,
			"INIT" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_PRINT' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'LBRACKET' => -11,
			"%{" => -11,
			'SUB' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LPAREN_TYPE_INNER' => -11,
			'WORD' => -11,
			"for" => -11,
			'SELF' => -11,
			'OP01_CLOSE' => -11,
			'USE' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED' => -11,
			"\@{" => -11,
			'OP22_LOGICAL_NEG' => -11,
			"## no critic qw(" => 9,
			"use constant" => -11,
			"undef" => -11,
			'MY' => -11,
			"if" => -11,
			'POD' => -11,
			'HASH_SYMBOL' => -11,
			'WORD_UPPERCASE' => -11,
			"foreach" => -11,
			'LPAREN' => -11,
			'OP01_OPEN' => -11,
			'ARRAY_REF_SYMBOL' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'WORD_SCOPED' => -11,
			"while" => -11,
			'HASH_REF_SYMBOL' => -11
		},
		GOTOS => {
			'Critic' => 58,
			'STAR-5' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'USE' => 54,
			"INIT" => 51
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 47
		DEFAULT => -49
	},
	{#State 48
		DEFAULT => -47
	},
	{#State 49
		ACTIONS => {
			'OP01_QW' => 61
		}
	},
	{#State 50
		ACTIONS => {
			";" => 62
		}
	},
	{#State 51
		ACTIONS => {
			'LBRACE' => 63
		}
	},
	{#State 52
		DEFAULT => -30
	},
	{#State 53
		ACTIONS => {
			'SUB' => 65,
			"use constant" => 64
		},
		GOTOS => {
			'Constant' => 67,
			'PLUS-15' => 66,
			'Subroutine' => 68
		}
	},
	{#State 54
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 69
		}
	},
	{#State 55
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 70
		}
	},
	{#State 56
		ACTIONS => {
			'OUR' => 71
		}
	},
	{#State 57
		DEFAULT => -37
	},
	{#State 58
		DEFAULT => -8
	},
	{#State 59
		ACTIONS => {
			"if" => -13,
			"foreach" => -13,
			'WORD_UPPERCASE' => -13,
			'LPAREN' => -13,
			'POD' => -13,
			'HASH_SYMBOL' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_OPEN' => -13,
			'ARRAY_REF_SYMBOL' => -13,
			"while" => -13,
			'HASH_REF_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'WORD' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED' => -13,
			'SELF' => -13,
			"for" => -13,
			'OP01_CLOSE' => -13,
			'USE' => 54,
			'OP22_LOGICAL_NEG' => -13,
			"\@{" => -13,
			"undef" => -13,
			"use constant" => -13,
			'MY' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT' => -13,
			'LBRACKET' => -13,
			"%{" => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'SUB' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'LPAREN_TYPE_INNER' => -13,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'ARRAY_SYMBOL' => -13,
			'SCALAR_SYMBOL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"INIT" => 51,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13
		},
		GOTOS => {
			'STAR-6' => 73,
			'Include' => 72
		}
	},
	{#State 60
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 74
		}
	},
	{#State 61
		ACTIONS => {
			";" => 75
		}
	},
	{#State 62
		DEFAULT => -43
	},
	{#State 63
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 76
		}
	},
	{#State 64
		ACTIONS => {
			'WORD_UPPERCASE' => 77
		}
	},
	{#State 65
		ACTIONS => {
			'WORD' => 78
		}
	},
	{#State 66
		ACTIONS => {
			'LITERAL_NUMBER' => 80,
			'SUB' => 65
		},
		GOTOS => {
			'Subroutine' => 79
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
			";" => -51,
			'OP01_QW' => 82
		},
		GOTOS => {
			'OPTIONAL-22' => 81
		}
	},
	{#State 70
		DEFAULT => -23
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
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'SUB' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LPAREN_TYPE_INNER' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'LBRACKET' => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			'LBRACE' => -15,
			'LITERAL_STRING' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'ARRAY_SYMBOL' => -15,
			'SCALAR_SYMBOL' => -15,
			'OP01_OPEN' => -15,
			'ARRAY_REF_SYMBOL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_SCOPED' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			"while" => -15,
			'HASH_REF_SYMBOL' => -15,
			"if" => -15,
			'POD' => -15,
			'HASH_SYMBOL' => -15,
			"foreach" => -15,
			'WORD_UPPERCASE' => -15,
			'LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"\@{" => -15,
			"undef" => -15,
			"use constant" => 64,
			'MY' => -15,
			'WORD' => -15,
			'SELF' => -15,
			"for" => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED' => -15
		},
		GOTOS => {
			'STAR-7' => 84,
			'Constant' => 85
		}
	},
	{#State 74
		ACTIONS => {
			'USE_EXPORTER' => 31,
			"## no critic qw(" => 9,
			"use constant" => -69,
			"INIT" => -69,
			"our hashref \$properties" => -69,
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
			'OP02_METHOD_THINARROW_IMP' => 89
		}
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
		DEFAULT => -34
	},
	{#State 80
		ACTIONS => {
			";" => 92
		}
	},
	{#State 81
		ACTIONS => {
			";" => 93
		}
	},
	{#State 82
		DEFAULT => -50
	},
	{#State 83
		DEFAULT => -39
	},
	{#State 84
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'HASH_REF_SYMBOL' => 145,
			"while" => -176,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			"if" => 148,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 112,
			"foreach" => -176,
			'HASH_SYMBOL' => 109,
			'POD' => 110,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'MY' => 99,
			"undef" => 100,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 137,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			"for" => -176,
			'OP05_MATH_NEG_LPAREN' => 125,
			'SUB' => 65,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP01_PRINT' => 127,
			'OP03_MATH_INC_DEC' => 164,
			"%{" => 167,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP01_NAMED_SCOLON' => 130,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			'OP01_NAMED_VOID_SCOLON' => 151,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'OP01_NAMED_VOID' => 116,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 121,
			'ARRAY_SYMBOL' => 120
		},
		GOTOS => {
			'OperatorVoid' => 134,
			'Subroutine' => 101,
			'ArrayReferenceVariable' => 135,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'Array' => 104,
			'ArrayReference' => 132,
			'PAREN-47' => 97,
			'ScalarLiteral' => 96,
			'OPTIONAL-48' => 133,
			'Variable' => 98,
			'ScalarVariableOrSelf' => 146,
			'VariableDeclaration' => 108,
			'HashReferenceLiteral' => 147,
			'LoopLabel' => 111,
			'SubExpression' => 150,
			'HashVariable' => 141,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'Operation' => 118,
			'HashReference' => 119,
			'Statement' => 157,
			'ArrayReferenceLiteral' => 114,
			'ScalarVariable' => 152,
			'Expression' => 115,
			'WordScoped' => 154,
			'PLUS-8' => 117,
			'ArrayDereference' => 165,
			'ArrayVariable' => 126,
			'Scalar' => 129,
			'Conditional' => 159,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 122,
			'HashLiteral' => 161,
			'Operator' => 124,
			'VariableModification' => 163
		}
	},
	{#State 85
		DEFAULT => -12
	},
	{#State 86
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 169
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
			'OP01_QW' => 170,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 171
		}
	},
	{#State 90
		ACTIONS => {
			'MY' => 173
		},
		GOTOS => {
			'TypeInnerConstant' => 172
		}
	},
	{#State 91
		ACTIONS => {
			'LBRACE' => 174
		}
	},
	{#State 92
		DEFAULT => -36
	},
	{#State 93
		DEFAULT => -54
	},
	{#State 94
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => -259,
			'LBRACKET' => -259,
			'MY' => 178,
			'SELF' => 136,
			'SCALAR_SYMBOL' => 155
		},
		GOTOS => {
			'OPTIONAL-59' => 177,
			'ScalarVariableOrSelf' => 146,
			'TypeInner' => 176,
			'ScalarVariable' => 175
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'SubExpression' => 181,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119
		}
	},
	{#State 96
		DEFAULT => -223
	},
	{#State 97
		DEFAULT => -175
	},
	{#State 98
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 189,
			'OP19_VARIABLE_ASSIGN' => 188
		}
	},
	{#State 99
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'TYPE_INTEGER' => 194,
			'TYPE_FHREF' => 193,
			'WORD' => 190
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 100
		DEFAULT => -156
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		DEFAULT => -256
	},
	{#State 103
		DEFAULT => -158
	},
	{#State 104
		DEFAULT => -159
	},
	{#State 105
		ACTIONS => {
			'FHREF_SYMBOL' => 195
		}
	},
	{#State 106
		DEFAULT => -141
	},
	{#State 107
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'LBRACE' => 153
		},
		GOTOS => {
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'Array' => 104,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'BracesEmpty' => 144,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 196
		}
	},
	{#State 108
		DEFAULT => -180
	},
	{#State 109
		DEFAULT => -274
	},
	{#State 110
		DEFAULT => -182
	},
	{#State 111
		ACTIONS => {
			'COLON' => 197
		}
	},
	{#State 112
		ACTIONS => {
			'LPAREN' => 198,
			'COLON' => -286
		}
	},
	{#State 113
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'SubExpression' => 199,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'BracesEmpty' => 144,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179
		}
	},
	{#State 114
		DEFAULT => -253
	},
	{#State 115
		ACTIONS => {
			'OP04_MATH_POW' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP08_STRING_CAT' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP07_STRING_REPEAT' => -155,
			";" => 200,
			'OP17_LIST_RANGE' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP13_BITWISE_AND' => -155
		}
	},
	{#State 116
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'SubExpression' => 202,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'SubExpressions' => 201,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 117
		ACTIONS => {
			"if" => 148,
			'POD' => 110,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 112,
			"foreach" => -176,
			'LPAREN' => 149,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			"while" => -176,
			'HASH_REF_SYMBOL' => 145,
			'WORD' => 28,
			'SELF' => 136,
			"for" => -176,
			'OP01_CLOSE' => 105,
			'OP01_NAMED' => 137,
			'LITERAL_NUMBER' => 138,
			"\@{" => 94,
			'' => -18,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'MY' => 99,
			'OP01_PRINT' => 127,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'OP01_NAMED_SCOLON' => 130,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 121,
			'SCALAR_SYMBOL' => 155,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED_VOID_SCOLON' => 151,
			'OP01_NAMED_VOID' => 116,
			'LBRACE' => 153
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 141,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 147,
			'VariableDeclaration' => 108,
			'ScalarVariableOrSelf' => 146,
			'SubExpression' => 150,
			'LoopLabel' => 111,
			'PAREN-47' => 97,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'Variable' => 98,
			'OPTIONAL-48' => 133,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 135,
			'OperatorVoid' => 134,
			'Array' => 104,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Hash' => 123,
			'HashReferenceVariable' => 122,
			'HashDereference' => 158,
			'Conditional' => 159,
			'VariableModification' => 163,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 126,
			'ArrayReferenceLiteral' => 114,
			'WordScoped' => 154,
			'Expression' => 115,
			'ScalarVariable' => 152,
			'Operation' => 203,
			'HashReference' => 119,
			'Statement' => 157
		}
	},
	{#State 118
		DEFAULT => -17
	},
	{#State 119
		DEFAULT => -163
	},
	{#State 120
		DEFAULT => -252
	},
	{#State 121
		ACTIONS => {
			'WORD_UPPERCASE' => 205
		},
		GOTOS => {
			'LoopLabel' => 204
		}
	},
	{#State 122
		ACTIONS => {
			'OP07_STRING_REPEAT' => -276,
			'OP16_LOGICAL_OR' => -276,
			'OP09_BITWISE_SHIFT' => -276,
			'OP19_VARIABLE_ASSIGN' => -205,
			'OP04_MATH_POW' => -276,
			'OP11_COMPARE_LT_GT' => -276,
			'OP08_STRING_CAT' => -276,
			")" => -276,
			'OP07_MATH_MULT_DIV_MOD' => -276,
			'OP19_VARIABLE_ASSIGN_BY' => -205,
			'OP12_COMPARE_EQ_NE' => -276,
			'OP23_LOGICAL_AND' => -276,
			'OP06_REGEX_BIND' => -276,
			'OP13_BITWISE_AND' => -276,
			'OP08_MATH_ADD_SUB' => -276,
			'OP17_LIST_RANGE' => -276,
			'OP14_BITWISE_OR_XOR' => -276,
			'OP15_LOGICAL_AND' => -276,
			'OP24_LOGICAL_OR_XOR' => -276
		}
	},
	{#State 123
		DEFAULT => -162
	},
	{#State 124
		DEFAULT => -149
	},
	{#State 125
		ACTIONS => {
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 206,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'BracesEmpty' => 144
		}
	},
	{#State 126
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -202,
			'OP07_MATH_MULT_DIV_MOD' => -246,
			'OP12_COMPARE_EQ_NE' => -246,
			'OP23_LOGICAL_AND' => -246,
			'OP08_MATH_ADD_SUB' => -246,
			'OP13_BITWISE_AND' => -246,
			'OP06_REGEX_BIND' => -246,
			'OP17_LIST_RANGE' => -246,
			'OP14_BITWISE_OR_XOR' => -246,
			'OP24_LOGICAL_OR_XOR' => -246,
			'OP15_LOGICAL_AND' => -246,
			'OP16_LOGICAL_OR' => -246,
			'OP07_STRING_REPEAT' => -246,
			'OP09_BITWISE_SHIFT' => -246,
			'OP19_VARIABLE_ASSIGN' => -202,
			'OP04_MATH_POW' => -246,
			'OP11_COMPARE_LT_GT' => -246,
			'OP08_STRING_CAT' => -246,
			")" => -246
		}
	},
	{#State 127
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => -132,
			'OP01_OPEN' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'WORD_SCOPED' => -132,
			'HASH_REF_SYMBOL' => -132,
			'FHREF_SYMBOL_BRACES' => 208,
			'HASH_SYMBOL' => -132,
			'LPAREN' => -132,
			'WORD_UPPERCASE' => -132,
			'OP22_LOGICAL_NEG' => -132,
			"\@{" => -132,
			'STDOUT_STDERR' => 209,
			"undef" => -132,
			'WORD' => -132,
			'OP01_CLOSE' => -132,
			'SELF' => -132,
			'LITERAL_NUMBER' => -132,
			'OP01_NAMED' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'LPAREN_TYPE_INNER' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP10_NAMED_UNARY' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			"%{" => -132,
			'LBRACKET' => -132,
			'OP05_LOGICAL_NEG' => -132,
			'LBRACE' => -132,
			'SCALAR_SYMBOL' => -132,
			'ARRAY_SYMBOL' => -132,
			'LITERAL_STRING' => -132
		},
		GOTOS => {
			'OPTIONAL-40' => 210,
			'PAREN-39' => 207
		}
	},
	{#State 128
		ACTIONS => {
			"\@{" => 94,
			'OP11_COMPARE_LT_GT' => -117,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'OP04_MATH_POW' => -117,
			"}" => -117,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP09_BITWISE_SHIFT' => -117,
			'OP01_NAMED' => 183,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'OP16_LOGICAL_OR' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'OP17_LIST_RANGE' => -117,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			";" => -117,
			'COLON' => -117,
			'WORD_UPPERCASE' => 187,
			'OP23_LOGICAL_AND' => -117,
			"]" => -117,
			'LPAREN' => 149,
			'HASH_SYMBOL' => 109,
			")" => -117,
			'OP08_STRING_CAT' => -117,
			'OP05_LOGICAL_NEG' => 113,
			'OP21_LIST_COMMA' => -117,
			'LBRACE' => 153,
			'OP18_TERNARY' => -117,
			'OP07_STRING_REPEAT' => -117,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP13_BITWISE_AND' => -117,
			'OP06_REGEX_BIND' => -117,
			'OP03_MATH_INC_DEC' => 164,
			'OP08_MATH_ADD_SUB' => -117,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'CONSTANT_CALL_SCOPED' => 166
		},
		GOTOS => {
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'SubExpression' => 211
		}
	},
	{#State 129
		DEFAULT => -157
	},
	{#State 130
		DEFAULT => -96
	},
	{#State 131
		DEFAULT => -97
	},
	{#State 132
		DEFAULT => -160
	},
	{#State 133
		ACTIONS => {
			"while" => 212,
			"foreach" => 216,
			"for" => 217
		},
		GOTOS => {
			'LoopFor' => 218,
			'LoopWhile' => 213,
			'LoopForEach' => 214,
			'Loop' => 215
		}
	},
	{#State 134
		DEFAULT => -179
	},
	{#State 135
		ACTIONS => {
			'OP17_LIST_RANGE' => -254,
			'OP14_BITWISE_OR_XOR' => -254,
			'OP24_LOGICAL_OR_XOR' => -254,
			'OP15_LOGICAL_AND' => -254,
			'OP19_VARIABLE_ASSIGN_BY' => -203,
			'OP07_MATH_MULT_DIV_MOD' => -254,
			'OP23_LOGICAL_AND' => -254,
			'OP12_COMPARE_EQ_NE' => -254,
			'OP08_MATH_ADD_SUB' => -254,
			'OP06_REGEX_BIND' => -254,
			'OP13_BITWISE_AND' => -254,
			'OP04_MATH_POW' => -254,
			'OP11_COMPARE_LT_GT' => -254,
			'OP08_STRING_CAT' => -254,
			")" => -254,
			'OP16_LOGICAL_OR' => -254,
			'OP07_STRING_REPEAT' => -254,
			'OP09_BITWISE_SHIFT' => -254,
			'OP19_VARIABLE_ASSIGN' => -203
		}
	},
	{#State 136
		DEFAULT => -233
	},
	{#State 137
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'LPAREN' => 149,
			"%{" => 167,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155
		},
		GOTOS => {
			'SubExpression' => 219,
			'Scalar' => 129,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132
		}
	},
	{#State 138
		DEFAULT => -225
	},
	{#State 139
		DEFAULT => -257
	},
	{#State 140
		ACTIONS => {
			'MY' => 220
		}
	},
	{#State 141
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => -204,
			'OP09_BITWISE_SHIFT' => -272,
			'OP07_STRING_REPEAT' => -272,
			'OP16_LOGICAL_OR' => -272,
			")" => -272,
			'OP11_COMPARE_LT_GT' => -272,
			'OP08_STRING_CAT' => -272,
			'OP04_MATH_POW' => -272,
			'OP13_BITWISE_AND' => -272,
			'OP06_REGEX_BIND' => -272,
			'OP08_MATH_ADD_SUB' => -272,
			'OP12_COMPARE_EQ_NE' => -272,
			'OP23_LOGICAL_AND' => -272,
			'OP07_MATH_MULT_DIV_MOD' => -272,
			'OP19_VARIABLE_ASSIGN_BY' => -204,
			'OP15_LOGICAL_AND' => -272,
			'OP24_LOGICAL_OR_XOR' => -272,
			'OP14_BITWISE_OR_XOR' => -272,
			'OP17_LIST_RANGE' => -272
		}
	},
	{#State 142
		DEFAULT => -245
	},
	{#State 143
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			")" => -134,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'SubExpression' => 202,
			'OPTIONAL-41' => 221,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'SubExpressions' => 222,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 144
		DEFAULT => -278
	},
	{#State 145
		DEFAULT => -279
	},
	{#State 146
		ACTIONS => {
			")" => -229,
			'OP11_COMPARE_LT_GT' => -229,
			'OP08_STRING_CAT' => -229,
			'OP21_LIST_COMMA' => -229,
			"}" => -229,
			'OP04_MATH_POW' => -229,
			'OP20_HASH_FATARROW' => -229,
			'OP18_TERNARY' => -229,
			'OP19_VARIABLE_ASSIGN' => -229,
			'OP09_BITWISE_SHIFT' => -229,
			'OP07_STRING_REPEAT' => -229,
			'OP16_LOGICAL_OR' => -229,
			'OP15_LOGICAL_AND' => -229,
			'OP24_LOGICAL_OR_XOR' => -229,
			'OP14_BITWISE_OR_XOR' => -229,
			'OP02_HASH_THINARROW' => 223,
			'OP02_METHOD_THINARROW' => -229,
			'OP02_ARRAY_THINARROW' => 225,
			'OP17_LIST_RANGE' => -229,
			";" => -229,
			'COLON' => -229,
			'OP13_BITWISE_AND' => -229,
			'OP06_REGEX_BIND' => -229,
			'OP08_MATH_ADD_SUB' => -229,
			'OP03_MATH_INC_DEC' => -229,
			'OP23_LOGICAL_AND' => -229,
			"]" => -229,
			'OP12_COMPARE_EQ_NE' => -229,
			'OP07_MATH_MULT_DIV_MOD' => -229,
			'OP19_VARIABLE_ASSIGN_BY' => -229
		},
		GOTOS => {
			'VariableRetrievalArrow' => 224
		}
	},
	{#State 147
		DEFAULT => -275
	},
	{#State 148
		ACTIONS => {
			'LPAREN' => 226
		}
	},
	{#State 149
		ACTIONS => {
			"\@{" => 94,
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 237,
			"undef" => 100,
			'MY' => 178,
			'ARGV' => 238,
			'WORD' => 252,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 253,
			'SELF' => 136,
			'OP01_CLOSE' => 239,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP01_OPEN' => 254,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_QW' => 255,
			'ENV' => 256,
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			'OP23_LOGICAL_AND' => 242,
			'HASH_SYMBOL' => 109,
			")" => 243,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED_VOID' => 228,
			'LBRACE' => 153,
			'ARRAY_SYMBOL' => 120,
			'OP07_STRING_REPEAT' => 247,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 229,
			'SCALAR_SYMBOL' => 155,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 231,
			'OP01_PRINT' => 233,
			'OP08_MATH_ADD_SUB' => 232,
			'OP03_MATH_INC_DEC' => 164,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'CONSTANT_CALL_SCOPED' => 166
		},
		GOTOS => {
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReference' => 132,
			'ScalarLiteral' => 235,
			'SubExpression' => 257,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'VarOrLitOrOpStrOrWord' => 246,
			'HashReference' => 119,
			'Expression' => 186,
			'ScalarVariable' => 245,
			'WordScoped' => 154,
			'TypeInner' => 244,
			'HashEntries' => 227,
			'ArrayReferenceLiteral' => 114,
			'ListElements' => 250,
			'OpStringOrWord' => 249,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'Scalar' => 129,
			'HashEntry' => 230,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ListElement' => 248
		}
	},
	{#State 150
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP17_LIST_RANGE' => 270,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP04_MATH_POW' => 273,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262
		}
	},
	{#State 151
		DEFAULT => -137
	},
	{#State 152
		ACTIONS => {
			'OP07_STRING_REPEAT' => -224,
			'OP16_LOGICAL_OR' => -224,
			'OP09_BITWISE_SHIFT' => -224,
			'OP19_VARIABLE_ASSIGN' => -201,
			'OP04_MATH_POW' => -224,
			'OP11_COMPARE_LT_GT' => -224,
			'OP08_STRING_CAT' => -224,
			")" => -224,
			'OP07_MATH_MULT_DIV_MOD' => -224,
			'OP19_VARIABLE_ASSIGN_BY' => -201,
			'OP12_COMPARE_EQ_NE' => -224,
			'OP23_LOGICAL_AND' => -224,
			'OP06_REGEX_BIND' => -224,
			'OP13_BITWISE_AND' => -224,
			'OP03_MATH_INC_DEC' => 275,
			'OP08_MATH_ADD_SUB' => -224,
			'OP17_LIST_RANGE' => -224,
			'OP02_METHOD_THINARROW' => 274,
			'OP14_BITWISE_OR_XOR' => -224,
			'OP15_LOGICAL_AND' => -224,
			'OP24_LOGICAL_OR_XOR' => -224
		}
	},
	{#State 153
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 277,
			"}" => 279,
			'OP01_NAMED_VOID' => 228,
			'WORD' => 283,
			'OP07_STRING_REPEAT' => 247,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 229,
			'SELF' => 136,
			'OP01_CLOSE' => 276,
			'SCALAR_SYMBOL' => 155,
			'OP01_NAMED' => 284,
			'LITERAL_NUMBER' => 138,
			'OP01_OPEN' => 285,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'ENV' => 256,
			'OP01_PRINT' => 281,
			'OP08_MATH_ADD_SUB' => 232,
			'OP10_NAMED_UNARY' => 282,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP23_LOGICAL_AND' => 242
		},
		GOTOS => {
			'VarOrLitOrOpStrOrWord' => 246,
			'ScalarVariable' => 286,
			'HashEntry' => 230,
			'HashEntries' => 280,
			'ScalarLiteral' => 278,
			'OpStringOrWord' => 249,
			'ScalarVariableOrSelf' => 146
		}
	},
	{#State 154
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 287,
			'LPAREN' => 288
		}
	},
	{#State 155
		DEFAULT => -232
	},
	{#State 156
		DEFAULT => -226
	},
	{#State 157
		DEFAULT => -98
	},
	{#State 158
		DEFAULT => -164
	},
	{#State 159
		DEFAULT => -177
	},
	{#State 160
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28
		},
		GOTOS => {
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'SubExpression' => 289,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161
		}
	},
	{#State 161
		DEFAULT => -271
	},
	{#State 162
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 277,
			'OP11_COMPARE_LT_GT' => 236,
			'OP01_NAMED_VOID' => 228,
			'WORD' => 283,
			'OP01_NAMED' => 284,
			'OP19_LOOP_CONTROL' => 229,
			'OP07_STRING_REPEAT' => 247,
			'OP01_CLOSE' => 276,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP01_OPEN' => 285,
			'OP10_NAMED_UNARY' => 282,
			'OP08_MATH_ADD_SUB' => 232,
			'OP01_PRINT' => 281,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP07_MATH_MULT_DIV_MOD' => 251
		},
		GOTOS => {
			'OpStringOrWord' => 290
		}
	},
	{#State 163
		ACTIONS => {
			";" => 291
		}
	},
	{#State 164
		ACTIONS => {
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136
		},
		GOTOS => {
			'ScalarVariable' => 292,
			'ScalarVariableOrSelf' => 146
		}
	},
	{#State 165
		DEFAULT => -161
	},
	{#State 166
		DEFAULT => -151
	},
	{#State 167
		ACTIONS => {
			'LBRACE' => -281,
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136,
			'HASH_REF_SYMBOL' => -281,
			'MY' => 178
		},
		GOTOS => {
			'ScalarVariable' => 295,
			'OPTIONAL-63' => 293,
			'TypeInner' => 294,
			'ScalarVariableOrSelf' => 146
		}
	},
	{#State 168
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'OP01_QW' => 255,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"]" => 297,
			'WORD_UPPERCASE' => 187,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'MY' => 178,
			'ARGV' => 238,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LBRACKET' => 168,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120
		},
		GOTOS => {
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'TypeInner' => 244,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayLiteralNonEmpty' => 142,
			'ListElement' => 248,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'ListElements' => 298,
			'SubExpression' => 296
		}
	},
	{#State 169
		ACTIONS => {
			"use constant" => -73,
			"INIT" => 51,
			'USE' => 54,
			"our hashref \$properties" => -73
		},
		GOTOS => {
			'STAR-31' => 300,
			'Include' => 299
		}
	},
	{#State 170
		DEFAULT => -52
	},
	{#State 171
		ACTIONS => {
			")" => 301
		}
	},
	{#State 172
		ACTIONS => {
			'LITERAL_STRING' => 156,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'ScalarLiteral' => 302
		}
	},
	{#State 173
		ACTIONS => {
			'WORD' => 190,
			'TYPE_INTEGER' => 194,
			'WORD_SCOPED' => 191
		},
		GOTOS => {
			'Type' => 303
		}
	},
	{#State 174
		ACTIONS => {
			'MY' => 304
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 305
		}
	},
	{#State 176
		DEFAULT => -258
	},
	{#State 177
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'LBRACKET' => 168
		},
		GOTOS => {
			'BracketsEmpty' => 102,
			'ArrayReferenceLiteral' => 114,
			'ArrayReferenceVariable' => 182,
			'ArrayReference' => 306
		}
	},
	{#State 178
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'TYPE_INTEGER' => 194,
			'WORD' => 190
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 179
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -224,
			'OP23_LOGICAL_AND' => -224,
			"]" => -224,
			'OP12_COMPARE_EQ_NE' => -224,
			'OP08_MATH_ADD_SUB' => -224,
			'OP03_MATH_INC_DEC' => 275,
			'OP13_BITWISE_AND' => -224,
			'OP06_REGEX_BIND' => -224,
			";" => -224,
			'COLON' => -224,
			'OP17_LIST_RANGE' => -224,
			'OP02_METHOD_THINARROW' => 274,
			'OP14_BITWISE_OR_XOR' => -224,
			'OP24_LOGICAL_OR_XOR' => -224,
			'OP15_LOGICAL_AND' => -224,
			'OP16_LOGICAL_OR' => -224,
			'OP07_STRING_REPEAT' => -224,
			'OP09_BITWISE_SHIFT' => -224,
			'OP18_TERNARY' => -224,
			"}" => -224,
			'OP04_MATH_POW' => -224,
			'OP21_LIST_COMMA' => -224,
			'OP08_STRING_CAT' => -224,
			'OP11_COMPARE_LT_GT' => -224,
			")" => -224
		}
	},
	{#State 180
		DEFAULT => -272
	},
	{#State 181
		ACTIONS => {
			"]" => -127,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'COLON' => -127,
			";" => -127,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP18_TERNARY' => -127,
			'OP21_LIST_COMMA' => -127,
			"}" => -127,
			'OP04_MATH_POW' => 273,
			")" => -127,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272
		}
	},
	{#State 182
		DEFAULT => -254
	},
	{#State 183
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28
		},
		GOTOS => {
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'SubExpression' => 308,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'Array' => 104
		}
	},
	{#State 184
		DEFAULT => -276
	},
	{#State 185
		DEFAULT => -246
	},
	{#State 186
		DEFAULT => -155
	},
	{#State 187
		ACTIONS => {
			'LPAREN' => 198
		}
	},
	{#State 188
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'STDIN' => 309,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'FHREF_SYMBOL_IN' => 310,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 311,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Array' => 104,
			'SubExpressionOrInput' => 312,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114
		}
	},
	{#State 189
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'SubExpression' => 313,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114
		}
	},
	{#State 190
		DEFAULT => -287
	},
	{#State 191
		DEFAULT => -288
	},
	{#State 192
		ACTIONS => {
			'ARRAY_SYMBOL' => 316,
			'SCALAR_SYMBOL' => 314,
			'HASH_SYMBOL' => 315
		}
	},
	{#State 193
		ACTIONS => {
			'FHREF_SYMBOL' => 317
		}
	},
	{#State 194
		DEFAULT => -289
	},
	{#State 195
		DEFAULT => -103
	},
	{#State 196
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => 318
		}
	},
	{#State 197
		DEFAULT => -174
	},
	{#State 198
		ACTIONS => {
			")" => 319
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => -108,
			"}" => -108,
			'OP04_MATH_POW' => 273,
			")" => -108,
			'OP08_STRING_CAT' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP18_TERNARY' => -108,
			'OP17_LIST_RANGE' => -108,
			'COLON' => -108,
			";" => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			"]" => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP08_MATH_ADD_SUB' => -108
		}
	},
	{#State 200
		DEFAULT => -95
	},
	{#State 201
		ACTIONS => {
			";" => 320
		}
	},
	{#State 202
		ACTIONS => {
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP17_LIST_RANGE' => 270,
			";" => -167,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			")" => -167,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP21_LIST_COMMA' => -167,
			'OP04_MATH_POW' => 273,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263
		},
		GOTOS => {
			'STAR-46' => 321
		}
	},
	{#State 203
		DEFAULT => -16
	},
	{#State 204
		ACTIONS => {
			";" => 322
		}
	},
	{#State 205
		DEFAULT => -286
	},
	{#State 206
		ACTIONS => {
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP17_LIST_RANGE' => 270,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => 323,
			'OP04_MATH_POW' => 273
		}
	},
	{#State 207
		DEFAULT => -131
	},
	{#State 208
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 153,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'WORD' => 28,
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164
		},
		GOTOS => {
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'SubExpression' => 202,
			'HashVariable' => 180,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'SubExpressions' => 324,
			'WordScoped' => 154
		}
	},
	{#State 209
		DEFAULT => -130
	},
	{#State 210
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 202,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'SubExpressions' => 325,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96
		}
	},
	{#State 211
		ACTIONS => {
			'OP17_LIST_RANGE' => -116,
			";" => -116,
			'COLON' => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => -116,
			"]" => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -116,
			'OP08_MATH_ADD_SUB' => 264,
			"}" => -116,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -116,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => -116,
			")" => -116,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => -116,
			'OP09_BITWISE_SHIFT' => 262,
			'OP18_TERNARY' => -116
		}
	},
	{#State 212
		ACTIONS => {
			'LPAREN' => 327,
			'LPAREN_MY' => 326
		}
	},
	{#State 213
		DEFAULT => -192
	},
	{#State 214
		DEFAULT => -191
	},
	{#State 215
		DEFAULT => -178
	},
	{#State 216
		ACTIONS => {
			'MY' => 328
		}
	},
	{#State 217
		ACTIONS => {
			'MY' => 330,
			'LPAREN_MY' => 329
		}
	},
	{#State 218
		DEFAULT => -190
	},
	{#State 219
		ACTIONS => {
			'OP21_LIST_COMMA' => 331,
			'OP04_MATH_POW' => -100,
			'OP08_STRING_CAT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP13_BITWISE_AND' => -100
		}
	},
	{#State 220
		ACTIONS => {
			'TYPE_FHREF' => 332
		}
	},
	{#State 221
		ACTIONS => {
			")" => 333
		}
	},
	{#State 222
		DEFAULT => -133
	},
	{#State 223
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 335,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156
		},
		GOTOS => {
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'Scalar' => 129,
			'SubExpression' => 334,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144
		}
	},
	{#State 224
		ACTIONS => {
			'OP21_LIST_COMMA' => -230,
			'LBRACE' => 336,
			'OP20_HASH_FATARROW' => -230,
			")" => -230,
			'OP08_STRING_CAT' => -230,
			'OP07_STRING_REPEAT' => -230,
			'OP18_TERNARY' => -230,
			'OP02_HASH_THINARROW' => 223,
			'OP12_COMPARE_EQ_NE' => -230,
			'LBRACKET' => 337,
			'OP07_MATH_MULT_DIV_MOD' => -230,
			'OP03_MATH_INC_DEC' => -230,
			'OP08_MATH_ADD_SUB' => -230,
			'OP13_BITWISE_AND' => -230,
			'OP06_REGEX_BIND' => -230,
			'OP04_MATH_POW' => -230,
			"}" => -230,
			'OP11_COMPARE_LT_GT' => -230,
			'OP09_BITWISE_SHIFT' => -230,
			'OP16_LOGICAL_OR' => -230,
			'OP19_VARIABLE_ASSIGN' => -230,
			'OP02_METHOD_THINARROW' => -230,
			'OP02_ARRAY_THINARROW' => 225,
			'COLON' => -230,
			";" => -230,
			'OP17_LIST_RANGE' => -230,
			'OP24_LOGICAL_OR_XOR' => -230,
			'OP15_LOGICAL_AND' => -230,
			'OP14_BITWISE_OR_XOR' => -230,
			"]" => -230,
			'OP23_LOGICAL_AND' => -230,
			'OP19_VARIABLE_ASSIGN_BY' => -230
		},
		GOTOS => {
			'PLUS-54' => 340,
			'VariableRetrieval' => 338,
			'VariableRetrievalArrow' => 339
		}
	},
	{#State 225
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'LPAREN' => 149,
			"%{" => 167,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'SubExpression' => 341,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102
		}
	},
	{#State 226
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 153,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'WORD' => 28,
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164
		},
		GOTOS => {
			'Scalar' => 129,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 342,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186
		}
	},
	{#State 227
		ACTIONS => {
			")" => 343
		}
	},
	{#State 228
		DEFAULT => -317
	},
	{#State 229
		DEFAULT => -307
	},
	{#State 230
		DEFAULT => -264,
		GOTOS => {
			'STAR-61' => 344
		}
	},
	{#State 231
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP17_LIST_RANGE' => -117,
			'WORD_SCOPED' => 26,
			'OP24_LOGICAL_OR_XOR' => -117,
			'OP15_LOGICAL_AND' => -117,
			'ARRAY_REF_SYMBOL' => 139,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP01_OPEN' => 140,
			'LPAREN' => 149,
			'OP23_LOGICAL_AND' => -117,
			'WORD_UPPERCASE' => 187,
			'HASH_SYMBOL' => 109,
			"undef" => 100,
			'OP04_MATH_POW' => -117,
			'OP11_COMPARE_LT_GT' => -117,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP09_BITWISE_SHIFT' => -117,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP16_LOGICAL_OR' => -117,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'WORD' => 28,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP12_COMPARE_EQ_NE' => -117,
			"%{" => 167,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'OP08_MATH_ADD_SUB' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP06_REGEX_BIND' => -117,
			'OP21_LIST_COMMA' => -117,
			'LBRACE' => 153,
			'OP20_HASH_FATARROW' => -310,
			")" => -117,
			'OP05_LOGICAL_NEG' => 113,
			'OP08_STRING_CAT' => -117,
			'SCALAR_SYMBOL' => 155,
			'OP07_STRING_REPEAT' => -117,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP18_TERNARY' => -117
		},
		GOTOS => {
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 211,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186
		}
	},
	{#State 232
		DEFAULT => -311
	},
	{#State 233
		ACTIONS => {
			'OP20_HASH_FATARROW' => -318,
			'FHREF_SYMBOL_BRACES' => 345
		}
	},
	{#State 234
		DEFAULT => -308
	},
	{#State 235
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -223,
			'OP08_STRING_CAT' => -223,
			")" => -223,
			'OP04_MATH_POW' => -223,
			'OP20_HASH_FATARROW' => -295,
			'OP21_LIST_COMMA' => -223,
			'OP18_TERNARY' => -223,
			'OP07_STRING_REPEAT' => -223,
			'OP16_LOGICAL_OR' => -223,
			'OP09_BITWISE_SHIFT' => -223,
			'OP14_BITWISE_OR_XOR' => -223,
			'OP15_LOGICAL_AND' => -223,
			'OP24_LOGICAL_OR_XOR' => -223,
			'OP17_LIST_RANGE' => -223,
			'OP13_BITWISE_AND' => -223,
			'OP06_REGEX_BIND' => -223,
			'OP08_MATH_ADD_SUB' => -223,
			'OP07_MATH_MULT_DIV_MOD' => -223,
			'OP12_COMPARE_EQ_NE' => -223,
			'OP23_LOGICAL_AND' => -223
		}
	},
	{#State 236
		DEFAULT => -309
	},
	{#State 237
		ACTIONS => {
			'OP20_HASH_FATARROW' => -305,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'SubExpression' => 181,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'BracesEmpty' => 144
		}
	},
	{#State 238
		DEFAULT => -244
	},
	{#State 239
		ACTIONS => {
			'OP20_HASH_FATARROW' => -315,
			'FHREF_SYMBOL' => 195
		}
	},
	{#State 240
		DEFAULT => -306
	},
	{#State 241
		DEFAULT => -303
	},
	{#State 242
		DEFAULT => -304
	},
	{#State 243
		DEFAULT => -234
	},
	{#State 244
		ACTIONS => {
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'SubExpression' => 346,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114
		}
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_BIND' => -224,
			'OP13_BITWISE_AND' => -224,
			'OP03_MATH_INC_DEC' => 275,
			'OP08_MATH_ADD_SUB' => -224,
			'OP07_MATH_MULT_DIV_MOD' => -224,
			'OP23_LOGICAL_AND' => -224,
			'OP12_COMPARE_EQ_NE' => -224,
			'OP14_BITWISE_OR_XOR' => -224,
			'OP15_LOGICAL_AND' => -224,
			'OP24_LOGICAL_OR_XOR' => -224,
			'OP17_LIST_RANGE' => -224,
			'OP02_METHOD_THINARROW' => 274,
			'OP18_TERNARY' => -224,
			'OP07_STRING_REPEAT' => -224,
			'OP16_LOGICAL_OR' => -224,
			'OP09_BITWISE_SHIFT' => -224,
			'OP11_COMPARE_LT_GT' => -224,
			'OP08_STRING_CAT' => -224,
			")" => -224,
			'OP04_MATH_POW' => -224,
			'OP20_HASH_FATARROW' => -294,
			'OP21_LIST_COMMA' => -224
		}
	},
	{#State 246
		ACTIONS => {
			'OP20_HASH_FATARROW' => 347
		}
	},
	{#State 247
		DEFAULT => -313
	},
	{#State 248
		DEFAULT => -239,
		GOTOS => {
			'STAR-56' => 348
		}
	},
	{#State 249
		DEFAULT => -296
	},
	{#State 250
		ACTIONS => {
			")" => 349
		}
	},
	{#State 251
		DEFAULT => -312
	},
	{#State 252
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -284,
			'OP20_HASH_FATARROW' => -319,
			'LPAREN' => -284
		}
	},
	{#State 253
		ACTIONS => {
			'OP20_HASH_FATARROW' => -314,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'Array' => 104,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'SubExpression' => 350,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180
		}
	},
	{#State 254
		ACTIONS => {
			'MY' => 220,
			'OP20_HASH_FATARROW' => -316
		}
	},
	{#State 255
		DEFAULT => -243
	},
	{#State 256
		DEFAULT => -269
	},
	{#State 257
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP18_TERNARY' => 351,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -241,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => -241
		}
	},
	{#State 258
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 352
		}
	},
	{#State 259
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			"%{" => 167,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 153,
			"undef" => 100,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 353,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96
		}
	},
	{#State 260
		ACTIONS => {
			'LBRACE' => 153,
			"undef" => 100,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'SubExpression' => 354,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96
		}
	},
	{#State 261
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'WORD' => 28
		},
		GOTOS => {
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'Scalar' => 129,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 355,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'BracesEmpty' => 144
		}
	},
	{#State 262
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 356
		}
	},
	{#State 263
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153
		},
		GOTOS => {
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'Scalar' => 129,
			'SubExpression' => 357,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154
		}
	},
	{#State 264
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95
		},
		GOTOS => {
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'Array' => 104,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'BracesEmpty' => 144,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 358
		}
	},
	{#State 265
		ACTIONS => {
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'SubExpression' => 359,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'Scalar' => 129,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102
		}
	},
	{#State 266
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 153,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'WORD' => 28,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'SubExpression' => 360,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103
		}
	},
	{#State 267
		ACTIONS => {
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'LBRACE' => 153,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145
		},
		GOTOS => {
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'SubExpression' => 361,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'BracesEmpty' => 144
		}
	},
	{#State 268
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			"%{" => 167,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'WORD' => 28
		},
		GOTOS => {
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'SubExpression' => 362,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129
		}
	},
	{#State 269
		ACTIONS => {
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'SubExpression' => 363,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 270
		ACTIONS => {
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140
		},
		GOTOS => {
			'SubExpression' => 364,
			'Scalar' => 129,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132
		}
	},
	{#State 271
		ACTIONS => {
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'LBRACE' => 153,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145
		},
		GOTOS => {
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'SubExpression' => 365,
			'Scalar' => 129,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147
		}
	},
	{#State 272
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 366,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'BracesEmpty' => 144,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132
		}
	},
	{#State 273
		ACTIONS => {
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			"%{" => 167,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 367,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104
		}
	},
	{#State 274
		ACTIONS => {
			'LPAREN' => 368
		}
	},
	{#State 275
		DEFAULT => -105
	},
	{#State 276
		DEFAULT => -315
	},
	{#State 277
		DEFAULT => -305
	},
	{#State 278
		DEFAULT => -295
	},
	{#State 279
		DEFAULT => -236
	},
	{#State 280
		ACTIONS => {
			"}" => 369
		}
	},
	{#State 281
		DEFAULT => -318
	},
	{#State 282
		DEFAULT => -310
	},
	{#State 283
		DEFAULT => -319
	},
	{#State 284
		DEFAULT => -314
	},
	{#State 285
		DEFAULT => -316
	},
	{#State 286
		DEFAULT => -294
	},
	{#State 287
		ACTIONS => {
			'LBRACE' => 153,
			'HASH_REF_SYMBOL' => 145,
			")" => -148
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashReference' => 370,
			'OPTIONAL-44' => 371,
			'HashReferenceLiteral' => 147,
			'HashReferenceVariable' => 184
		}
	},
	{#State 288
		ACTIONS => {
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28,
			'LBRACE' => 153,
			"undef" => 100,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			")" => -144,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125
		},
		GOTOS => {
			'HashVariable' => 180,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'SubExpression' => 202,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'SubExpressions' => 372,
			'OPTIONAL-42' => 373,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Array' => 104
		}
	},
	{#State 289
		ACTIONS => {
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP17_LIST_RANGE' => 270,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => 374,
			'OP04_MATH_POW' => 273
		}
	},
	{#State 290
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 375
		}
	},
	{#State 291
		DEFAULT => -181
	},
	{#State 292
		DEFAULT => -104
	},
	{#State 293
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'LBRACE' => 153
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashReferenceLiteral' => 147,
			'HashReferenceVariable' => 184,
			'HashReference' => 376
		}
	},
	{#State 294
		DEFAULT => -280
	},
	{#State 295
		ACTIONS => {
			"}" => 377
		}
	},
	{#State 296
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			")" => -241,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -241,
			'OP04_MATH_POW' => 273,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP23_LOGICAL_AND' => 271,
			"]" => -241,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP17_LIST_RANGE' => 270
		}
	},
	{#State 297
		DEFAULT => -235
	},
	{#State 298
		ACTIONS => {
			"]" => 378
		}
	},
	{#State 299
		DEFAULT => -70
	},
	{#State 300
		ACTIONS => {
			"our hashref \$properties" => 380,
			"use constant" => 64
		},
		GOTOS => {
			'Constant' => 379,
			'Properties' => 381
		}
	},
	{#State 301
		ACTIONS => {
			";" => 382
		}
	},
	{#State 302
		ACTIONS => {
			";" => 383
		}
	},
	{#State 303
		ACTIONS => {
			"\$TYPED_" => 384
		}
	},
	{#State 304
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'TYPE_INTEGER' => 194,
			'WORD' => 190
		},
		GOTOS => {
			'Type' => 385
		}
	},
	{#State 305
		DEFAULT => -260
	},
	{#State 306
		ACTIONS => {
			"}" => 386
		}
	},
	{#State 307
		ACTIONS => {
			"\$TYPED_" => 387
		}
	},
	{#State 308
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_STRING_CAT' => -100,
			")" => -100,
			'OP04_MATH_POW' => -100,
			"}" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP18_TERNARY' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'COLON' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			"]" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100
		}
	},
	{#State 309
		DEFAULT => -171
	},
	{#State 310
		DEFAULT => -170
	},
	{#State 311
		ACTIONS => {
			'OP04_MATH_POW' => 273,
			")" => -169,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP17_LIST_RANGE' => 270,
			";" => -169,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264
		}
	},
	{#State 312
		DEFAULT => -221
	},
	{#State 313
		ACTIONS => {
			'OP04_MATH_POW' => 273,
			")" => -222,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			";" => -222,
			'OP17_LIST_RANGE' => 270,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258
		}
	},
	{#State 314
		ACTIONS => {
			";" => 389,
			'OP02_ARRAY_THINARROW' => 390,
			'OP19_VARIABLE_ASSIGN' => 388
		}
	},
	{#State 315
		ACTIONS => {
			";" => 391,
			'OP19_VARIABLE_ASSIGN' => 392
		}
	},
	{#State 316
		ACTIONS => {
			";" => 394,
			'OP19_VARIABLE_ASSIGN' => 393
		}
	},
	{#State 317
		ACTIONS => {
			";" => 395
		}
	},
	{#State 318
		DEFAULT => -107
	},
	{#State 319
		DEFAULT => -150
	},
	{#State 320
		DEFAULT => -139
	},
	{#State 321
		ACTIONS => {
			")" => -168,
			'OP21_LIST_COMMA' => 397,
			";" => -168
		},
		GOTOS => {
			'PAREN-45' => 396
		}
	},
	{#State 322
		DEFAULT => -142
	},
	{#State 323
		DEFAULT => -109
	},
	{#State 324
		ACTIONS => {
			";" => 398
		}
	},
	{#State 325
		ACTIONS => {
			";" => 399
		}
	},
	{#State 326
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'WORD' => 190,
			'TYPE_INTEGER' => 194
		},
		GOTOS => {
			'Type' => 400
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'WORD' => 28,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95
		},
		GOTOS => {
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'Array' => 104,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'BracesEmpty' => 144,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 401
		}
	},
	{#State 328
		ACTIONS => {
			'TYPE_INTEGER' => 194,
			'WORD' => 190,
			'WORD_SCOPED' => 191
		},
		GOTOS => {
			'Type' => 402
		}
	},
	{#State 329
		ACTIONS => {
			'TYPE_INTEGER' => 403
		}
	},
	{#State 330
		ACTIONS => {
			'TYPE_INTEGER' => 404
		}
	},
	{#State 331
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120
		},
		GOTOS => {
			'SubExpression' => 202,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'BracesEmpty' => 144,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'Array' => 104,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'SubExpressions' => 405,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132
		}
	},
	{#State 332
		ACTIONS => {
			'FHREF_SYMBOL' => 406
		}
	},
	{#State 333
		ACTIONS => {
			";" => 407
		}
	},
	{#State 334
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP17_LIST_RANGE' => 270,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP04_MATH_POW' => 273,
			"}" => 408,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272
		}
	},
	{#State 335
		ACTIONS => {
			"}" => 409,
			'LPAREN' => -284,
			'OP02_METHOD_THINARROW_NEW' => -284
		}
	},
	{#State 336
		ACTIONS => {
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 410,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94
		},
		GOTOS => {
			'SubExpression' => 411,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'BracesEmpty' => 144,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132
		}
	},
	{#State 337
		ACTIONS => {
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'LBRACE' => 153,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107
		},
		GOTOS => {
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'BracesEmpty' => 144,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 412,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'Array' => 104
		}
	},
	{#State 338
		DEFAULT => -228
	},
	{#State 339
		DEFAULT => -209
	},
	{#State 340
		ACTIONS => {
			")" => -231,
			'OP08_STRING_CAT' => -231,
			'OP21_LIST_COMMA' => -231,
			'LBRACE' => 336,
			'OP20_HASH_FATARROW' => -231,
			'OP18_TERNARY' => -231,
			'OP07_STRING_REPEAT' => -231,
			'OP02_HASH_THINARROW' => 223,
			'OP06_REGEX_BIND' => -231,
			'OP13_BITWISE_AND' => -231,
			'OP08_MATH_ADD_SUB' => -231,
			'OP03_MATH_INC_DEC' => -231,
			'LBRACKET' => 337,
			'OP12_COMPARE_EQ_NE' => -231,
			'OP07_MATH_MULT_DIV_MOD' => -231,
			'OP11_COMPARE_LT_GT' => -231,
			'OP04_MATH_POW' => -231,
			"}" => -231,
			'OP19_VARIABLE_ASSIGN' => -231,
			'OP09_BITWISE_SHIFT' => -231,
			'OP16_LOGICAL_OR' => -231,
			'OP15_LOGICAL_AND' => -231,
			'OP24_LOGICAL_OR_XOR' => -231,
			'OP14_BITWISE_OR_XOR' => -231,
			'OP02_ARRAY_THINARROW' => 225,
			'OP02_METHOD_THINARROW' => -231,
			'OP17_LIST_RANGE' => -231,
			'COLON' => -231,
			";" => -231,
			"]" => -231,
			'OP23_LOGICAL_AND' => -231,
			'OP19_VARIABLE_ASSIGN_BY' => -231
		},
		GOTOS => {
			'VariableRetrieval' => 413,
			'VariableRetrievalArrow' => 339
		}
	},
	{#State 341
		ACTIONS => {
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP04_MATH_POW' => 273,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			"]" => 414,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP17_LIST_RANGE' => 270
		}
	},
	{#State 342
		ACTIONS => {
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => 415,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268
		}
	},
	{#State 343
		DEFAULT => -273
	},
	{#State 344
		ACTIONS => {
			'OP21_LIST_COMMA' => 416,
			"}" => -265,
			")" => -265
		},
		GOTOS => {
			'PAREN-60' => 417
		}
	},
	{#State 345
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'SubExpressions' => 418,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'SubExpression' => 202,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124
		}
	},
	{#State 346
		ACTIONS => {
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			"]" => -242,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -242,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => -242,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262
		}
	},
	{#State 347
		ACTIONS => {
			'LITERAL_NUMBER' => -267,
			'OP01_NAMED' => -267,
			'OP01_CLOSE' => -267,
			'SCALAR_SYMBOL' => -267,
			'ARRAY_SYMBOL' => -267,
			'SELF' => -267,
			'LITERAL_STRING' => -267,
			'WORD' => -267,
			'MY' => 178,
			"undef" => -267,
			'LBRACE' => -267,
			'OP05_LOGICAL_NEG' => -267,
			"\@{" => -267,
			'OP22_LOGICAL_NEG' => -267,
			"%{" => -267,
			'LPAREN' => -267,
			'WORD_UPPERCASE' => -267,
			'LBRACKET' => -267,
			'HASH_SYMBOL' => -267,
			'CONSTANT_CALL_SCOPED' => -267,
			'OP10_NAMED_UNARY' => -267,
			'OP03_MATH_INC_DEC' => -267,
			'HASH_REF_SYMBOL' => -267,
			'LPAREN_TYPE_INNER' => -267,
			'WORD_SCOPED' => -267,
			'OP05_BITWISE_NEG_LPAREN' => -267,
			'OP05_MATH_NEG_LPAREN' => -267,
			'ARRAY_REF_SYMBOL' => -267,
			'OP01_OPEN' => -267,
			'OP22_LOGICAL_NEG_LPAREN' => -267
		},
		GOTOS => {
			'OPTIONAL-62' => 420,
			'TypeInner' => 419
		}
	},
	{#State 348
		ACTIONS => {
			'OP21_LIST_COMMA' => 422,
			"]" => -240,
			")" => -240
		},
		GOTOS => {
			'PAREN-55' => 421
		}
	},
	{#State 349
		DEFAULT => -250
	},
	{#State 350
		ACTIONS => {
			'OP07_STRING_REPEAT' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP18_TERNARY' => -100,
			'OP04_MATH_POW' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP08_STRING_CAT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 351
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'SubExpression' => 424,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'BracesEmpty' => 144
		}
	},
	{#State 352
		DEFAULT => -110
	},
	{#State 353
		ACTIONS => {
			'OP17_LIST_RANGE' => -112,
			'COLON' => -112,
			";" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			"]" => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP04_MATH_POW' => 273,
			"}" => -112,
			")" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP08_STRING_CAT' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => -112,
			'OP18_TERNARY' => -112
		}
	},
	{#State 354
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -111,
			"]" => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -111,
			";" => -111,
			'COLON' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP18_TERNARY' => -111,
			'OP04_MATH_POW' => 273,
			"}" => -111,
			'OP21_LIST_COMMA' => -111,
			'OP08_STRING_CAT' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			")" => -111
		}
	},
	{#State 355
		ACTIONS => {
			"]" => -122,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => -122,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'COLON' => -122,
			";" => -122,
			'OP17_LIST_RANGE' => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => -122,
			'OP07_STRING_REPEAT' => 260,
			'OP18_TERNARY' => -122,
			'OP21_LIST_COMMA' => -122,
			"}" => -122,
			'OP04_MATH_POW' => 273,
			")" => -122,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267
		}
	},
	{#State 356
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP14_BITWISE_OR_XOR' => -115,
			'COLON' => -115,
			";" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -115,
			'OP23_LOGICAL_AND' => -115,
			"]" => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			")" => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -115,
			'OP04_MATH_POW' => 273,
			"}" => -115,
			'OP18_TERNARY' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP07_STRING_REPEAT' => 260
		}
	},
	{#State 357
		ACTIONS => {
			")" => -123,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -123,
			"}" => -123,
			'OP04_MATH_POW' => 273,
			'OP18_TERNARY' => -123,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => -123,
			'OP07_STRING_REPEAT' => 260,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'COLON' => -123,
			";" => -123,
			'OP17_LIST_RANGE' => -123,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP12_COMPARE_EQ_NE' => 266,
			"]" => -123,
			'OP23_LOGICAL_AND' => -123,
			'OP07_MATH_MULT_DIV_MOD' => 259
		}
	},
	{#State 358
		ACTIONS => {
			"]" => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP06_REGEX_BIND' => 258,
			'COLON' => -113,
			";" => -113,
			'OP17_LIST_RANGE' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP16_LOGICAL_OR' => -113,
			'OP07_STRING_REPEAT' => 260,
			'OP18_TERNARY' => -113,
			'OP21_LIST_COMMA' => -113,
			'OP04_MATH_POW' => 273,
			"}" => -113,
			")" => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP08_STRING_CAT' => -113
		}
	},
	{#State 359
		ACTIONS => {
			'OP18_TERNARY' => -120,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => -120,
			'OP07_STRING_REPEAT' => 260,
			")" => -120,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP21_LIST_COMMA' => -120,
			'OP04_MATH_POW' => 273,
			"}" => -120,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -120,
			"]" => -120,
			'OP23_LOGICAL_AND' => -120,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'COLON' => -120,
			";" => -120,
			'OP17_LIST_RANGE' => -120
		}
	},
	{#State 360
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => -119,
			'OP18_TERNARY' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP04_MATH_POW' => 273,
			"}" => -119,
			")" => -119,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			"]" => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP13_BITWISE_AND' => -119,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => -119,
			'COLON' => -119,
			";" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP14_BITWISE_OR_XOR' => -119
		}
	},
	{#State 361
		ACTIONS => {
			'OP18_TERNARY' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP07_STRING_REPEAT' => 260,
			")" => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP08_STRING_CAT' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP04_MATH_POW' => 273,
			"}" => -114,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => -114,
			'OP06_REGEX_BIND' => 258,
			"]" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP23_LOGICAL_AND' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'COLON' => -114,
			";" => -114,
			'OP17_LIST_RANGE' => -114
		}
	},
	{#State 362
		ACTIONS => {
			")" => -129,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -129,
			'OP04_MATH_POW' => 273,
			"}" => -129,
			'OP18_TERNARY' => -129,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP17_LIST_RANGE' => 270,
			'COLON' => -129,
			";" => -129,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP12_COMPARE_EQ_NE' => 266,
			"]" => -129,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259
		}
	},
	{#State 363
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 259,
			"]" => -121,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => -121,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => -121,
			";" => -121,
			'COLON' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP15_LOGICAL_AND' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => -121,
			'OP09_BITWISE_SHIFT' => 262,
			'OP18_TERNARY' => -121,
			"}" => -121,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -121,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => -121
		}
	},
	{#State 364
		ACTIONS => {
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP18_TERNARY' => -124,
			"}" => -124,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -124,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => -124,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			"]" => -124,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => -124,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			";" => -124,
			'COLON' => -124,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP15_LOGICAL_AND' => 261
		}
	},
	{#State 365
		ACTIONS => {
			")" => -128,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -128,
			"}" => -128,
			'OP04_MATH_POW' => 273,
			'OP18_TERNARY' => -128,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'COLON' => -128,
			";" => -128,
			'OP17_LIST_RANGE' => 270,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP23_LOGICAL_AND' => -128,
			"]" => -128,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259
		}
	},
	{#State 366
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => -118,
			"]" => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP14_BITWISE_OR_XOR' => -118,
			'COLON' => -118,
			";" => -118,
			'OP17_LIST_RANGE' => -118,
			'OP18_TERNARY' => -118,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => -118,
			'OP07_STRING_REPEAT' => 260,
			")" => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -118,
			"}" => -118,
			'OP04_MATH_POW' => 273
		}
	},
	{#State 367
		ACTIONS => {
			")" => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP08_STRING_CAT' => -106,
			'OP21_LIST_COMMA' => -106,
			"}" => -106,
			'OP04_MATH_POW' => 273,
			'OP18_TERNARY' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP17_LIST_RANGE' => -106,
			'COLON' => -106,
			";" => -106,
			'OP13_BITWISE_AND' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			"]" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106
		}
	},
	{#State 368
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			")" => -146,
			'LBRACE' => 153,
			"undef" => 100
		},
		GOTOS => {
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'Scalar' => 129,
			'SubExpression' => 202,
			'HashVariable' => 180,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'OPTIONAL-43' => 426,
			'SubExpressions' => 425,
			'WordScoped' => 154
		}
	},
	{#State 369
		DEFAULT => -277
	},
	{#State 370
		DEFAULT => -147
	},
	{#State 371
		ACTIONS => {
			")" => 427
		}
	},
	{#State 372
		DEFAULT => -143
	},
	{#State 373
		ACTIONS => {
			")" => 428
		}
	},
	{#State 374
		DEFAULT => -126
	},
	{#State 375
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'WORD' => 28
		},
		GOTOS => {
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 429,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186
		}
	},
	{#State 376
		ACTIONS => {
			"}" => 430
		}
	},
	{#State 377
		DEFAULT => -282
	},
	{#State 378
		DEFAULT => -255
	},
	{#State 379
		DEFAULT => -72
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 431
		}
	},
	{#State 381
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 432
		}
	},
	{#State 382
		ACTIONS => {
			"}" => 433
		}
	},
	{#State 383
		DEFAULT => -56
	},
	{#State 384
		ACTIONS => {
			'WORD_UPPERCASE' => 434
		}
	},
	{#State 385
		ACTIONS => {
			"\$RETURN_TYPE" => 435
		}
	},
	{#State 386
		DEFAULT => -261
	},
	{#State 387
		ACTIONS => {
			'OP10_NAMED_UNARY' => 282,
			'OP08_MATH_ADD_SUB' => 232,
			'OP01_PRINT' => 281,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP23_LOGICAL_AND' => 242,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP01_OPEN' => 285,
			'WORD' => 283,
			'OP01_NAMED' => 284,
			'OP19_LOOP_CONTROL' => 229,
			'OP07_STRING_REPEAT' => 247,
			'OP01_CLOSE' => 276,
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 277,
			'OP01_NAMED_VOID' => 228
		},
		GOTOS => {
			'OpStringOrWord' => 436
		}
	},
	{#State 388
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'STDIN' => 309,
			'HASH_REF_SYMBOL' => 145,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'FHREF_SYMBOL_IN' => 310,
			'OP10_NAMED_UNARY_SCOLON' => 438,
			'OP01_NAMED_SCOLON' => 437,
			"%{" => 167,
			'LBRACKET' => 168
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'SubExpression' => 311,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'OpNamedScolonOrSubExpIn' => 439,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'Array' => 104,
			'SubExpressionOrInput' => 440,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 389
		DEFAULT => -213
	},
	{#State 390
		ACTIONS => {
			'LPAREN' => 149,
			"%{" => 167,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'WORD' => 28,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94
		},
		GOTOS => {
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'SubExpression' => 441,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180
		}
	},
	{#State 391
		DEFAULT => -218
	},
	{#State 392
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'STDIN' => 309,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'HASH_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"%{" => 167,
			'LBRACKET' => 168,
			'FHREF_SYMBOL_IN' => 310,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY_SCOLON' => 438,
			'OP01_NAMED_SCOLON' => 437,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156
		},
		GOTOS => {
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'SubExpression' => 311,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'OpNamedScolonOrSubExpIn' => 442,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'SubExpressionOrInput' => 440
		}
	},
	{#State 393
		ACTIONS => {
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'WORD' => 28,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'STDIN' => 309,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'OP01_NAMED_SCOLON' => 437,
			'OP10_NAMED_UNARY_SCOLON' => 438,
			'CONSTANT_CALL_SCOPED' => 166,
			'FHREF_SYMBOL_IN' => 310,
			'LBRACKET' => 168,
			"%{" => 167
		},
		GOTOS => {
			'SubExpression' => 311,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Array' => 104,
			'SubExpressionOrInput' => 440,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'OpNamedScolonOrSubExpIn' => 443,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114
		}
	},
	{#State 394
		DEFAULT => -216
	},
	{#State 395
		DEFAULT => -220
	},
	{#State 396
		DEFAULT => -166
	},
	{#State 397
		ACTIONS => {
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94
		},
		GOTOS => {
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 444,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'Array' => 104,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154
		}
	},
	{#State 398
		DEFAULT => -136
	},
	{#State 399
		DEFAULT => -135
	},
	{#State 400
		ACTIONS => {
			'SCALAR_SYMBOL' => 445
		}
	},
	{#State 401
		ACTIONS => {
			")" => 446,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP04_MATH_POW' => 273,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP17_LIST_RANGE' => 270,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259
		}
	},
	{#State 402
		ACTIONS => {
			'SCALAR_SYMBOL' => 447
		}
	},
	{#State 403
		ACTIONS => {
			'SCALAR_SYMBOL' => 448
		}
	},
	{#State 404
		ACTIONS => {
			'SCALAR_SYMBOL' => 449
		}
	},
	{#State 405
		ACTIONS => {
			";" => 450
		}
	},
	{#State 406
		ACTIONS => {
			'OP21_LIST_COMMA' => 451
		}
	},
	{#State 407
		DEFAULT => -138
	},
	{#State 408
		DEFAULT => -207
	},
	{#State 409
		DEFAULT => -208
	},
	{#State 410
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -284,
			"}" => 452,
			'LPAREN' => -284
		}
	},
	{#State 411
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			"}" => 453,
			'OP04_MATH_POW' => 273,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267
		}
	},
	{#State 412
		ACTIONS => {
			'OP17_LIST_RANGE' => 270,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			"]" => 454,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260
		}
	},
	{#State 413
		DEFAULT => -227
	},
	{#State 414
		DEFAULT => -206
	},
	{#State 415
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 455
		}
	},
	{#State 416
		ACTIONS => {
			'WORD' => 283,
			'OP19_LOOP_CONTROL' => 229,
			'LITERAL_STRING' => 156,
			'OP07_STRING_REPEAT' => 247,
			'SELF' => 136,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 276,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 284,
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 277,
			'OP01_NAMED_VOID' => 228,
			'OP01_PRINT' => 281,
			'OP08_MATH_ADD_SUB' => 232,
			'OP10_NAMED_UNARY' => 282,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP01_OPEN' => 285,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP24_LOGICAL_OR_XOR' => 241,
			'ENV' => 256
		},
		GOTOS => {
			'ScalarLiteral' => 278,
			'OpStringOrWord' => 249,
			'ScalarVariableOrSelf' => 146,
			'HashEntry' => 457,
			'VarOrLitOrOpStrOrWord' => 246,
			'ScalarVariable' => 286
		}
	},
	{#State 417
		DEFAULT => -263
	},
	{#State 418
		ACTIONS => {
			")" => 458
		}
	},
	{#State 419
		DEFAULT => -266
	},
	{#State 420
		ACTIONS => {
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD' => 28,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'LBRACE' => 153
		},
		GOTOS => {
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'SubExpression' => 459,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142
		}
	},
	{#State 421
		DEFAULT => -238
	},
	{#State 422
		ACTIONS => {
			'WORD' => 28,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'MY' => 178,
			'ARGV' => 238,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 187,
			'LPAREN' => 149,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP01_QW' => 255,
			'HASH_REF_SYMBOL' => 145,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ListElement' => 460,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'SubExpression' => 296,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'TypeInner' => 244,
			'Array' => 104,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 423
		ACTIONS => {
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183
		},
		GOTOS => {
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'SubExpressions' => 461,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 202
		}
	},
	{#State 424
		ACTIONS => {
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP04_MATH_POW' => 273,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'COLON' => 462,
			'OP17_LIST_RANGE' => 270,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271
		}
	},
	{#State 425
		DEFAULT => -145
	},
	{#State 426
		ACTIONS => {
			")" => 463
		}
	},
	{#State 427
		DEFAULT => -154
	},
	{#State 428
		DEFAULT => -152
	},
	{#State 429
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -249,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => -249
		},
		GOTOS => {
			'STAR-58' => 464
		}
	},
	{#State 430
		DEFAULT => -283
	},
	{#State 431
		ACTIONS => {
			'LBRACE' => 465
		}
	},
	{#State 432
		ACTIONS => {
			'SUB' => 466,
			'LITERAL_NUMBER' => 468
		},
		GOTOS => {
			'Subroutine' => 470,
			'Method' => 469,
			'SubroutineOrMethod' => 467
		}
	},
	{#State 433
		DEFAULT => -55
	},
	{#State 434
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 471
		}
	},
	{#State 435
		ACTIONS => {
			"}" => 472
		}
	},
	{#State 436
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 473
		}
	},
	{#State 437
		DEFAULT => -300
	},
	{#State 438
		DEFAULT => -301
	},
	{#State 439
		DEFAULT => -214
	},
	{#State 440
		ACTIONS => {
			";" => 474
		}
	},
	{#State 441
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			"]" => 475,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP17_LIST_RANGE' => 270,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP04_MATH_POW' => 273
		}
	},
	{#State 442
		DEFAULT => -219
	},
	{#State 443
		DEFAULT => -217
	},
	{#State 444
		ACTIONS => {
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP17_LIST_RANGE' => 270,
			";" => -165,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			")" => -165,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP21_LIST_COMMA' => -165,
			'OP04_MATH_POW' => 273,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263
		}
	},
	{#State 445
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 476
		}
	},
	{#State 446
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 477
		}
	},
	{#State 447
		ACTIONS => {
			'LPAREN' => 478
		}
	},
	{#State 448
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 479
		}
	},
	{#State 449
		ACTIONS => {
			'LPAREN' => 480
		}
	},
	{#State 450
		DEFAULT => -140
	},
	{#State 451
		ACTIONS => {
			'LITERAL_STRING' => 481
		}
	},
	{#State 452
		DEFAULT => -212
	},
	{#State 453
		DEFAULT => -211
	},
	{#State 454
		DEFAULT => -210
	},
	{#State 455
		DEFAULT => -185,
		GOTOS => {
			'STAR-50' => 482
		}
	},
	{#State 456
		ACTIONS => {
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 112,
			"foreach" => -176,
			'HASH_SYMBOL' => 109,
			'POD' => 110,
			"if" => 148,
			'HASH_REF_SYMBOL' => 145,
			"while" => -176,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP01_NAMED' => 137,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			"for" => -176,
			'SELF' => 136,
			'WORD' => 28,
			'MY' => 99,
			"undef" => 100,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"%{" => 167,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			'OP01_NAMED_SCOLON' => 130,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'OP01_PRINT' => 127,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'SCALAR_SYMBOL' => 155,
			'OP19_LOOP_CONTROL' => 121,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'LBRACE' => 153,
			'OP01_NAMED_VOID' => 116,
			'OP01_NAMED_VOID_SCOLON' => 151,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'Scalar' => 129,
			'ArrayVariable' => 126,
			'ArrayDereference' => 165,
			'VariableModification' => 163,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Conditional' => 159,
			'HashReferenceVariable' => 122,
			'HashDereference' => 158,
			'Hash' => 123,
			'Statement' => 157,
			'Operation' => 484,
			'HashReference' => 119,
			'WordScoped' => 154,
			'ScalarVariable' => 152,
			'Expression' => 115,
			'ArrayReferenceLiteral' => 114,
			'PLUS-53' => 483,
			'LoopLabel' => 111,
			'SubExpression' => 150,
			'ScalarVariableOrSelf' => 146,
			'VariableDeclaration' => 108,
			'HashReferenceLiteral' => 147,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 141,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'OperatorVoid' => 134,
			'ArrayReferenceVariable' => 135,
			'Variable' => 98,
			'OPTIONAL-48' => 133,
			'PAREN-47' => 97,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132
		}
	},
	{#State 457
		DEFAULT => -262
	},
	{#State 458
		DEFAULT => -99
	},
	{#State 459
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP17_LIST_RANGE' => 270,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => -268,
			"}" => -268,
			'OP04_MATH_POW' => 273,
			'OP21_LIST_COMMA' => -268,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262
		}
	},
	{#State 460
		DEFAULT => -237
	},
	{#State 461
		ACTIONS => {
			")" => 485
		}
	},
	{#State 462
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138
		},
		GOTOS => {
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'HashVariable' => 180,
			'SubExpression' => 486,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ArrayReference' => 132,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182
		}
	},
	{#State 463
		DEFAULT => -153
	},
	{#State 464
		ACTIONS => {
			'OP21_LIST_COMMA' => 489,
			")" => 487
		},
		GOTOS => {
			'PAREN-57' => 488
		}
	},
	{#State 465
		ACTIONS => {
			'OP01_PRINT' => 281,
			'OP08_MATH_ADD_SUB' => 232,
			'OP10_NAMED_UNARY' => 282,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP01_OPEN' => 285,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP24_LOGICAL_OR_XOR' => 241,
			'WORD' => 283,
			'OP01_CLOSE' => 276,
			'OP19_LOOP_CONTROL' => 229,
			'OP07_STRING_REPEAT' => 247,
			'OP01_NAMED' => 284,
			'OP22_LOGICAL_NEG' => 277,
			'OP11_COMPARE_LT_GT' => 236,
			"}" => 490,
			'OP01_NAMED_VOID' => 228
		},
		GOTOS => {
			'OpStringOrWord' => 492,
			'HashEntryProperties' => 491
		}
	},
	{#State 466
		ACTIONS => {
			'WORD' => 493
		}
	},
	{#State 467
		DEFAULT => -74
	},
	{#State 468
		ACTIONS => {
			";" => 494
		}
	},
	{#State 469
		DEFAULT => -94
	},
	{#State 470
		DEFAULT => -93
	},
	{#State 471
		DEFAULT => -293
	},
	{#State 472
		ACTIONS => {
			";" => 495
		}
	},
	{#State 473
		DEFAULT => -290
	},
	{#State 474
		DEFAULT => -302
	},
	{#State 475
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 496
		}
	},
	{#State 476
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 153,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'WORD' => 28,
			'HASH_REF_SYMBOL' => 145,
			'STDIN' => 309,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			"%{" => 167,
			'LPAREN' => 149,
			'FHREF_SYMBOL_IN' => 310,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164
		},
		GOTOS => {
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'SubExpressionOrInput' => 497,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'Scalar' => 129,
			'SubExpression' => 311,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144
		}
	},
	{#State 477
		DEFAULT => -196
	},
	{#State 478
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 100,
			'LBRACE' => 153,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			"%{" => 167,
			'LPAREN' => 149,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162
		},
		GOTOS => {
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'SubExpression' => 202,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'SubExpressions' => 498,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104
		}
	},
	{#State 479
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'LBRACE' => 153,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP01_NAMED_SCOLON' => 499,
			'OP10_NAMED_UNARY_SCOLON' => 500,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107
		},
		GOTOS => {
			'SubExpression' => 501,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'HashVariable' => 180,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'Array' => 104,
			'OpNamedScolonOrSubExp' => 502,
			'ArrayReferenceVariable' => 182,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96
		}
	},
	{#State 480
		ACTIONS => {
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'LPAREN' => 149,
			"%{" => 167,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28,
			'LBRACE' => 153,
			"undef" => 100,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'SubExpression' => 503,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'BracesEmpty' => 144,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'Array' => 104,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179
		}
	},
	{#State 481
		ACTIONS => {
			'OP21_LIST_COMMA' => 504
		}
	},
	{#State 482
		ACTIONS => {
			"else" => 509,
			'LITERAL_STRING' => -188,
			'ARRAY_SYMBOL' => -188,
			'OP19_LOOP_CONTROL' => -188,
			'SCALAR_SYMBOL' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'OP01_NAMED_VOID_SCOLON' => -188,
			'OP01_NAMED_VOID' => -188,
			'LBRACE' => -188,
			'OP01_PRINT' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'OP10_NAMED_UNARY' => -188,
			"elsif" => 505,
			'OP10_NAMED_UNARY_SCOLON' => -188,
			'OP01_NAMED_SCOLON' => -188,
			'CONSTANT_CALL_SCOPED' => -188,
			'LBRACKET' => -188,
			"%{" => -188,
			'OP22_LOGICAL_NEG_LPAREN' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'LPAREN_TYPE_INNER' => -188,
			'WORD' => -188,
			'SELF' => -188,
			"for" => -188,
			'OP01_CLOSE' => -188,
			'LITERAL_NUMBER' => -188,
			'OP01_NAMED' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'' => -188,
			"\@{" => -188,
			"}" => -188,
			"undef" => -188,
			'MY' => -188,
			"if" => -188,
			'POD' => -188,
			'HASH_SYMBOL' => -188,
			'WORD_UPPERCASE' => -188,
			"foreach" => -188,
			'LPAREN' => -188,
			'OP01_OPEN' => -188,
			'ARRAY_REF_SYMBOL' => -188,
			'OP19_LOOP_CONTROL_SCOLON' => -188,
			'OP01_NAMED_VOID_LPAREN' => -188,
			'WORD_SCOPED' => -188,
			'OP05_BITWISE_NEG_LPAREN' => -188,
			"while" => -188,
			'HASH_REF_SYMBOL' => -188
		},
		GOTOS => {
			'PAREN-51' => 506,
			'PAREN-49' => 508,
			'OPTIONAL-52' => 507
		}
	},
	{#State 483
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED_VOID_SCOLON' => 151,
			'LBRACE' => 153,
			'OP01_NAMED_VOID' => 116,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 121,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP03_MATH_INC_DEC' => 164,
			'OP01_PRINT' => 127,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP01_NAMED_SCOLON' => 130,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			"%{" => 167,
			'LBRACKET' => 168,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"}" => 511,
			'MY' => 99,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			"for" => -176,
			'SELF' => 136,
			'OP01_NAMED' => 137,
			'LITERAL_NUMBER' => 138,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			"while" => -176,
			"if" => 148,
			'HASH_SYMBOL' => 109,
			'POD' => 110,
			'LPAREN' => 149,
			"foreach" => -176,
			'WORD_UPPERCASE' => 112
		},
		GOTOS => {
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'VariableDeclaration' => 108,
			'LoopLabel' => 111,
			'SubExpression' => 150,
			'HashVariable' => 141,
			'ArrayLiteralNonEmpty' => 142,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 135,
			'OperatorVoid' => 134,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'Array' => 104,
			'ArrayReference' => 132,
			'PAREN-47' => 97,
			'ScalarLiteral' => 96,
			'OPTIONAL-48' => 133,
			'Variable' => 98,
			'ArrayDereference' => 165,
			'ArrayVariable' => 126,
			'Scalar' => 129,
			'Conditional' => 159,
			'HashDereference' => 158,
			'HashReferenceVariable' => 122,
			'Hash' => 123,
			'HashLiteral' => 161,
			'Operator' => 124,
			'VariableModification' => 163,
			'Operation' => 510,
			'HashReference' => 119,
			'Statement' => 157,
			'ArrayReferenceLiteral' => 114,
			'Expression' => 115,
			'ScalarVariable' => 152,
			'WordScoped' => 154
		}
	},
	{#State 484
		DEFAULT => -199
	},
	{#State 485
		DEFAULT => -101
	},
	{#State 486
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP17_LIST_RANGE' => 270,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			")" => 512,
			'OP04_MATH_POW' => 273,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262
		}
	},
	{#State 487
		DEFAULT => -251
	},
	{#State 488
		DEFAULT => -248
	},
	{#State 489
		ACTIONS => {
			"%{" => 167,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'HASH_SYMBOL' => 109,
			'OP01_QW' => 255,
			'HASH_REF_SYMBOL' => 145,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP01_CLOSE' => 105,
			'SELF' => 136,
			'WORD' => 28,
			'ARGV' => 238,
			'MY' => 178,
			"undef" => 100,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94
		},
		GOTOS => {
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'Array' => 104,
			'TypeInner' => 244,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'ArrayReferenceLiteral' => 114,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 296,
			'HashReferenceVariable' => 184,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashVariable' => 180,
			'ListElement' => 513,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'BracesEmpty' => 144
		}
	},
	{#State 490
		ACTIONS => {
			";" => 514
		}
	},
	{#State 491
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 515
		}
	},
	{#State 492
		ACTIONS => {
			'OP20_HASH_FATARROW' => 516
		}
	},
	{#State 493
		ACTIONS => {
			'LBRACE' => 517
		}
	},
	{#State 494
		DEFAULT => -76
	},
	{#State 495
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -58,
			'OP05_LOGICAL_NEG' => -58,
			'OP01_NAMED_VOID' => -58,
			'LBRACE' => -58,
			'ARRAY_SYMBOL' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'LITERAL_STRING' => -58,
			'SCALAR_SYMBOL' => -58,
			'LPAREN_MY' => 520,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'LPAREN_TYPE_INNER' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'OP01_PRINT' => -58,
			'LBRACKET' => -58,
			"%{" => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'OP22_LOGICAL_NEG' => -58,
			"\@{" => -58,
			"undef" => -58,
			'MY' => -58,
			"}" => -58,
			'WORD' => -58,
			'OP01_NAMED' => -58,
			'LITERAL_NUMBER' => -58,
			"for" => -58,
			'SELF' => -58,
			'OP01_CLOSE' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'OP01_OPEN' => -58,
			'ARRAY_REF_SYMBOL' => -58,
			"while" => -58,
			'HASH_REF_SYMBOL' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'WORD_SCOPED' => -58,
			"if" => -58,
			"foreach" => -58,
			'WORD_UPPERCASE' => -58,
			'LPAREN' => -58,
			'POD' => -58,
			'HASH_SYMBOL' => -58
		},
		GOTOS => {
			'OPTIONAL-24' => 518,
			'SubroutineArguments' => 519
		}
	},
	{#State 496
		ACTIONS => {
			"undef" => 521
		}
	},
	{#State 497
		ACTIONS => {
			")" => 522
		}
	},
	{#State 498
		ACTIONS => {
			")" => 523
		}
	},
	{#State 499
		DEFAULT => -297
	},
	{#State 500
		DEFAULT => -298
	},
	{#State 501
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			";" => 524,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272
		}
	},
	{#State 502
		ACTIONS => {
			'SCALAR_SYMBOL' => 525
		}
	},
	{#State 503
		ACTIONS => {
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP04_MATH_POW' => 273,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP17_LIST_RANGE' => 526,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271
		}
	},
	{#State 504
		ACTIONS => {
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164
		},
		GOTOS => {
			'SubExpression' => 527,
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'BracesEmpty' => 144,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'Array' => 104,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96
		}
	},
	{#State 505
		ACTIONS => {
			'LPAREN' => 528
		}
	},
	{#State 506
		DEFAULT => -187
	},
	{#State 507
		DEFAULT => -189
	},
	{#State 508
		DEFAULT => -184
	},
	{#State 509
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 529
		}
	},
	{#State 510
		DEFAULT => -198
	},
	{#State 511
		DEFAULT => -200
	},
	{#State 512
		DEFAULT => -125
	},
	{#State 513
		DEFAULT => -247
	},
	{#State 514
		DEFAULT => -83
	},
	{#State 515
		ACTIONS => {
			"}" => 532,
			'OP21_LIST_COMMA' => 530
		},
		GOTOS => {
			'PAREN-33' => 531
		}
	},
	{#State 516
		ACTIONS => {
			'MY' => 533
		},
		GOTOS => {
			'TypeInnerProperties' => 534
		}
	},
	{#State 517
		ACTIONS => {
			'LBRACE' => 535
		}
	},
	{#State 518
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 536
		}
	},
	{#State 519
		DEFAULT => -57
	},
	{#State 520
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'WORD' => 190,
			'TYPE_INTEGER' => 194
		},
		GOTOS => {
			'Type' => 537
		}
	},
	{#State 521
		ACTIONS => {
			";" => 538
		}
	},
	{#State 522
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 539
		}
	},
	{#State 523
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 540
		}
	},
	{#State 524
		DEFAULT => -299
	},
	{#State 525
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 541
		}
	},
	{#State 526
		ACTIONS => {
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'SELF' => 136,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'LPAREN' => 149,
			"%{" => 167
		},
		GOTOS => {
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'BracesEmpty' => 144,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'SubExpression' => 542,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165
		}
	},
	{#State 527
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP18_TERNARY' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 273,
			"}" => -102,
			")" => -102,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			"]" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'COLON' => -102,
			";" => -102,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => 269
		}
	},
	{#State 528
		ACTIONS => {
			'LBRACE' => 153,
			"undef" => 100,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 113,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'WORD' => 28,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'LPAREN_TYPE_INNER' => 162,
			'HASH_REF_SYMBOL' => 145,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'ARRAY_REF_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 125,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'LPAREN' => 149,
			"%{" => 167,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128
		},
		GOTOS => {
			'ScalarVariableOrSelf' => 146,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'HashReferenceLiteral' => 147,
			'Scalar' => 129,
			'SubExpression' => 543,
			'HashDereference' => 158,
			'Hash' => 123,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'BracesEmpty' => 144,
			'ArrayReferenceVariable' => 182,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'Array' => 104,
			'ArrayReference' => 132,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'WordScoped' => 154
		}
	},
	{#State 529
		DEFAULT => -186
	},
	{#State 530
		ACTIONS => {
			'OP01_NAMED_VOID' => 228,
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 277,
			'OP01_NAMED' => 284,
			'OP01_CLOSE' => 276,
			'OP07_STRING_REPEAT' => 247,
			'OP19_LOOP_CONTROL' => 229,
			'WORD' => 283,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP01_OPEN' => 285,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP23_LOGICAL_AND' => 242,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP10_NAMED_UNARY' => 282,
			'OP01_PRINT' => 281,
			'OP08_MATH_ADD_SUB' => 232
		},
		GOTOS => {
			'HashEntryProperties' => 544,
			'OpStringOrWord' => 492
		}
	},
	{#State 531
		DEFAULT => -80
	},
	{#State 532
		ACTIONS => {
			";" => 545
		}
	},
	{#State 533
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'TYPE_INTEGER' => 194,
			'WORD' => 190
		},
		GOTOS => {
			'Type' => 546
		}
	},
	{#State 534
		DEFAULT => -270
	},
	{#State 535
		ACTIONS => {
			'MY' => 547
		}
	},
	{#State 536
		ACTIONS => {
			'POD' => 110,
			'HASH_SYMBOL' => 109,
			'WORD_UPPERCASE' => 112,
			"foreach" => -176,
			'LPAREN' => 149,
			"if" => 148,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			"while" => -176,
			'HASH_REF_SYMBOL' => 145,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'SELF' => 136,
			"for" => -176,
			'OP01_CLOSE' => 105,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 137,
			'WORD' => 28,
			"}" => 549,
			"undef" => 100,
			'MY' => 99,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'OP01_NAMED_SCOLON' => 130,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			'CONSTANT_CALL_SCOPED' => 166,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP03_MATH_INC_DEC' => 164,
			'OP01_PRINT' => 127,
			'OP10_NAMED_UNARY' => 128,
			'LPAREN_TYPE_INNER' => 162,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP19_LOOP_CONTROL' => 121,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SCALAR_SYMBOL' => 155,
			'OP01_NAMED_VOID' => 116,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED_VOID_SCOLON' => 151
		},
		GOTOS => {
			'Scalar' => 129,
			'ArrayVariable' => 126,
			'ArrayDereference' => 165,
			'VariableModification' => 163,
			'Operator' => 124,
			'HashLiteral' => 161,
			'HashDereference' => 158,
			'HashReferenceVariable' => 122,
			'Hash' => 123,
			'Conditional' => 159,
			'Statement' => 157,
			'HashReference' => 119,
			'Operation' => 548,
			'WordScoped' => 154,
			'Expression' => 115,
			'ScalarVariable' => 152,
			'ArrayReferenceLiteral' => 114,
			'LoopLabel' => 111,
			'SubExpression' => 150,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'VariableDeclaration' => 108,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 141,
			'Array' => 104,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 135,
			'OperatorVoid' => 134,
			'Variable' => 98,
			'OPTIONAL-48' => 133,
			'ScalarLiteral' => 96,
			'PAREN-47' => 97,
			'ArrayReference' => 132
		}
	},
	{#State 537
		ACTIONS => {
			'SCALAR_SYMBOL' => 550
		}
	},
	{#State 538
		DEFAULT => -215
	},
	{#State 539
		DEFAULT => -197
	},
	{#State 540
		DEFAULT => -195
	},
	{#State 541
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			"undef" => 100,
			'LBRACE' => 153,
			'WORD' => 28,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP01_NAMED_SCOLON' => 499,
			'OP10_NAMED_UNARY_SCOLON' => 500
		},
		GOTOS => {
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 179,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 182,
			'OpNamedScolonOrSubExp' => 551,
			'Array' => 104,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 180,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'SubExpression' => 501
		}
	},
	{#State 542
		ACTIONS => {
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP09_BITWISE_SHIFT' => 262,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => 552,
			'OP04_MATH_POW' => 273,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP08_MATH_ADD_SUB' => 264,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => -124,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 543
		ACTIONS => {
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP23_LOGICAL_AND' => 271,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			")" => 553,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262
		}
	},
	{#State 544
		DEFAULT => -79
	},
	{#State 545
		DEFAULT => -82
	},
	{#State 546
		ACTIONS => {
			"\$TYPED_" => 554
		}
	},
	{#State 547
		ACTIONS => {
			'TYPE_METHOD' => 555,
			'WORD_SCOPED' => 191,
			'WORD' => 190,
			'TYPE_INTEGER' => 194
		},
		GOTOS => {
			'Type' => 385
		}
	},
	{#State 548
		DEFAULT => -59
	},
	{#State 549
		DEFAULT => -61
	},
	{#State 550
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 556
		}
	},
	{#State 551
		ACTIONS => {
			'LPAREN_TYPE_INNER' => 162,
			'WORD_SCOPED' => 26,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'HASH_REF_SYMBOL' => 145,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			'OP05_MATH_NEG_LPAREN' => 125,
			'HASH_SYMBOL' => 109,
			'CONSTANT_CALL_SCOPED' => 166,
			"%{" => 167,
			'LPAREN' => 149,
			'LBRACKET' => 168,
			'WORD_UPPERCASE' => 187,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'LBRACE' => 153,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'LITERAL_STRING' => 156,
			'ARRAY_SYMBOL' => 120,
			'SELF' => 136,
			'OP01_NAMED' => 183,
			'LITERAL_NUMBER' => 138,
			'WORD' => 28
		},
		GOTOS => {
			'SubExpression' => 557,
			'Scalar' => 129,
			'HashReferenceLiteral' => 147,
			'ArrayVariable' => 126,
			'ArrayDereference' => 165,
			'ScalarVariableOrSelf' => 146,
			'BracesEmpty' => 144,
			'VariableModification' => 559,
			'Operator' => 124,
			'HashLiteral' => 161,
			'ArrayLiteralNonEmpty' => 142,
			'HashVariable' => 141,
			'HashDereference' => 158,
			'HashReferenceVariable' => 122,
			'Hash' => 123,
			'SubExpressionOrVarMod' => 558,
			'Array' => 104,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'ArrayReferenceVariable' => 135,
			'Variable' => 98,
			'WordScoped' => 154,
			'Expression' => 186,
			'ScalarVariable' => 152,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132
		}
	},
	{#State 552
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 560
		}
	},
	{#State 553
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 561
		}
	},
	{#State 554
		ACTIONS => {
			'OP01_NAMED_VOID' => 228,
			'OP11_COMPARE_LT_GT' => 236,
			'OP22_LOGICAL_NEG' => 277,
			'OP01_CLOSE' => 276,
			'OP07_STRING_REPEAT' => 247,
			'OP19_LOOP_CONTROL' => 229,
			'OP01_NAMED' => 284,
			'WORD' => 283,
			'OP01_OPEN' => 285,
			'OP24_LOGICAL_OR_XOR' => 241,
			'OP19_LOOP_CONTROL_SCOLON' => 240,
			'OP07_MATH_MULT_DIV_MOD' => 251,
			'OP23_LOGICAL_AND' => 242,
			'OP12_COMPARE_EQ_NE' => 234,
			'OP08_MATH_ADD_SUB' => 232,
			'OP01_PRINT' => 281,
			'OP10_NAMED_UNARY' => 282
		},
		GOTOS => {
			'OpStringOrWord' => 562
		}
	},
	{#State 555
		ACTIONS => {
			"\$RETURN_TYPE" => 563
		}
	},
	{#State 556
		ACTIONS => {
			")" => 564,
			'OP21_LIST_COMMA' => 566
		},
		GOTOS => {
			'PAREN-26' => 565
		}
	},
	{#State 557
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 262,
			'OP07_STRING_REPEAT' => 260,
			'OP16_LOGICAL_OR' => 263,
			'OP04_MATH_POW' => 273,
			")" => -172,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258,
			'OP08_MATH_ADD_SUB' => 264,
			'OP17_LIST_RANGE' => 270,
			'OP15_LOGICAL_AND' => 261,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP14_BITWISE_OR_XOR' => 269
		}
	},
	{#State 558
		ACTIONS => {
			")" => 567
		}
	},
	{#State 559
		DEFAULT => -173
	},
	{#State 560
		DEFAULT => -193
	},
	{#State 561
		DEFAULT => -183
	},
	{#State 562
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 568,
			'OP19_VARIABLE_ASSIGN' => 569
		}
	},
	{#State 563
		ACTIONS => {
			"}" => 570
		}
	},
	{#State 564
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 571
		}
	},
	{#State 565
		DEFAULT => -63
	},
	{#State 566
		ACTIONS => {
			'MY' => 572
		}
	},
	{#State 567
		ACTIONS => {
			'LBRACE' => 456
		},
		GOTOS => {
			'CodeBlock' => 573
		}
	},
	{#State 568
		ACTIONS => {
			'HASH_REF_SYMBOL' => 145,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'OP05_MATH_NEG_LPAREN' => 125,
			'ARRAY_REF_SYMBOL' => 139,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP01_OPEN' => 140,
			"%{" => 167,
			'LPAREN' => 149,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			"undef" => 100,
			'LBRACE' => 153,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'SCALAR_SYMBOL' => 155,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'ARRAY_SYMBOL' => 120,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'Array' => 104,
			'BracketsEmpty' => 102,
			'ArrayHashLiteralEmpty' => 103,
			'HashReference' => 119,
			'ArrayReferenceVariable' => 182,
			'BracesEmpty' => 144,
			'ArrayLiteralNonEmpty' => 142,
			'Operator' => 124,
			'HashLiteral' => 161,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'HashVariable' => 180,
			'SubExpression' => 574,
			'Scalar' => 129,
			'ScalarVariableOrSelf' => 146,
			'ArrayVariable' => 185,
			'ArrayDereference' => 165,
			'HashReferenceLiteral' => 147
		}
	},
	{#State 569
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			'LBRACE' => 153,
			"undef" => 100,
			'WORD' => 28,
			'OP01_CLOSE' => 105,
			'SCALAR_SYMBOL' => 155,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'SELF' => 136,
			'LITERAL_NUMBER' => 138,
			'OP01_NAMED' => 183,
			'ARRAY_REF_SYMBOL' => 139,
			'OP01_OPEN' => 140,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'OP05_MATH_NEG_LPAREN' => 125,
			'LPAREN_TYPE_INNER' => 162,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			'HASH_REF_SYMBOL' => 145,
			'OP03_MATH_INC_DEC' => 164,
			'OP10_NAMED_UNARY' => 128,
			'CONSTANT_CALL_SCOPED' => 166,
			'HASH_SYMBOL' => 109,
			'LPAREN' => 149,
			"%{" => 167,
			'WORD_UPPERCASE' => 187,
			'LBRACKET' => 168
		},
		GOTOS => {
			'ArrayLiteralNonEmpty' => 142,
			'HashLiteral' => 161,
			'Operator' => 124,
			'HashDereference' => 158,
			'HashReferenceVariable' => 184,
			'Hash' => 123,
			'HashVariable' => 180,
			'BracesEmpty' => 144,
			'Scalar' => 129,
			'ArrayDereference' => 165,
			'ArrayVariable' => 185,
			'ScalarVariableOrSelf' => 146,
			'HashReferenceLiteral' => 147,
			'SubExpression' => 575,
			'ArrayReferenceLiteral' => 114,
			'ScalarLiteral' => 96,
			'ArrayReference' => 132,
			'WordScoped' => 154,
			'ScalarVariable' => 179,
			'Expression' => 186,
			'BracketsEmpty' => 102,
			'HashReference' => 119,
			'ArrayHashLiteralEmpty' => 103,
			'ArrayReferenceVariable' => 182,
			'Array' => 104
		}
	},
	{#State 570
		ACTIONS => {
			";" => 576
		}
	},
	{#State 571
		ACTIONS => {
			"\@ARG;" => 577
		}
	},
	{#State 572
		ACTIONS => {
			'TYPE_INTEGER' => 194,
			'WORD' => 190,
			'WORD_SCOPED' => 191
		},
		GOTOS => {
			'Type' => 578
		}
	},
	{#State 573
		DEFAULT => -194
	},
	{#State 574
		ACTIONS => {
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP09_BITWISE_SHIFT' => 262,
			'OP04_MATH_POW' => 273,
			'OP08_STRING_CAT' => 267,
			'OP11_COMPARE_LT_GT' => 272,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			"]" => 579,
			'OP08_MATH_ADD_SUB' => 264,
			'OP06_REGEX_BIND' => 258,
			'OP13_BITWISE_AND' => 265,
			'OP17_LIST_RANGE' => 270,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261
		}
	},
	{#State 575
		ACTIONS => {
			'OP21_LIST_COMMA' => -291,
			'OP04_MATH_POW' => 273,
			"}" => -291,
			'OP11_COMPARE_LT_GT' => 272,
			'OP08_STRING_CAT' => 267,
			'OP09_BITWISE_SHIFT' => 262,
			'OP16_LOGICAL_OR' => 263,
			'OP07_STRING_REPEAT' => 260,
			'OP17_LIST_RANGE' => 270,
			'OP24_LOGICAL_OR_XOR' => 268,
			'OP15_LOGICAL_AND' => 261,
			'OP14_BITWISE_OR_XOR' => 269,
			'OP12_COMPARE_EQ_NE' => 266,
			'OP23_LOGICAL_AND' => 271,
			'OP07_MATH_MULT_DIV_MOD' => 259,
			'OP08_MATH_ADD_SUB' => 264,
			'OP13_BITWISE_AND' => 265,
			'OP06_REGEX_BIND' => 258
		}
	},
	{#State 576
		ACTIONS => {
			'SCALAR_SYMBOL' => -85,
			'LITERAL_STRING' => -85,
			'ARRAY_SYMBOL' => -85,
			'OP19_LOOP_CONTROL' => -85,
			'LBRACE' => -85,
			'OP01_NAMED_VOID' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP05_LOGICAL_NEG' => -85,
			"%{" => -85,
			'LBRACKET' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP01_PRINT' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'LPAREN_TYPE_INNER' => -85,
			'LPAREN_MY' => 580,
			'OP05_MATH_NEG_LPAREN' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'LITERAL_NUMBER' => -85,
			'OP01_NAMED' => -85,
			'OP01_CLOSE' => -85,
			"for" => -85,
			'SELF' => -85,
			'WORD' => -85,
			'MY' => -85,
			"undef" => -85,
			"}" => -85,
			"\@{" => -85,
			'OP22_LOGICAL_NEG' => -85,
			'LPAREN' => -85,
			'WORD_UPPERCASE' => -85,
			"foreach" => -85,
			'HASH_SYMBOL' => -85,
			'POD' => -85,
			"if" => -85,
			'HASH_REF_SYMBOL' => -85,
			"while" => -85,
			'WORD_SCOPED' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'ARRAY_REF_SYMBOL' => -85,
			'OP01_OPEN' => -85
		},
		GOTOS => {
			'MethodArguments' => 582,
			'OPTIONAL-35' => 581
		}
	},
	{#State 577
		DEFAULT => -65
	},
	{#State 578
		ACTIONS => {
			'SCALAR_SYMBOL' => 583
		}
	},
	{#State 579
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 584
		}
	},
	{#State 580
		ACTIONS => {
			'WORD' => 190,
			'TYPE_INTEGER' => 194,
			'WORD_SCOPED' => 191
		},
		GOTOS => {
			'Type' => 585
		}
	},
	{#State 581
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 586
		}
	},
	{#State 582
		DEFAULT => -84
	},
	{#State 583
		DEFAULT => -62
	},
	{#State 584
		ACTIONS => {
			"undef" => 587
		}
	},
	{#State 585
		ACTIONS => {
			'SELF' => 588
		}
	},
	{#State 586
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 125,
			'OP22_LOGICAL_NEG_LPAREN' => 160,
			'LPAREN_TYPE_INNER' => 162,
			'OP10_NAMED_UNARY' => 128,
			'OP03_MATH_INC_DEC' => 164,
			'OP01_PRINT' => 127,
			'LBRACKET' => 168,
			"%{" => 167,
			'OP10_NAMED_UNARY_SCOLON' => 131,
			'OP01_NAMED_SCOLON' => 130,
			'CONSTANT_CALL_SCOPED' => 166,
			'OP01_NAMED_VOID_SCOLON' => 151,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED_VOID' => 116,
			'LBRACE' => 153,
			'ARRAY_SYMBOL' => 120,
			'LITERAL_STRING' => 156,
			'OP19_LOOP_CONTROL' => 121,
			'SCALAR_SYMBOL' => 155,
			'OP19_LOOP_CONTROL_SCOLON' => 106,
			'OP01_NAMED_VOID_LPAREN' => 143,
			'OP01_OPEN' => 140,
			'ARRAY_REF_SYMBOL' => 139,
			"while" => -176,
			'HASH_REF_SYMBOL' => 145,
			'OP05_BITWISE_NEG_LPAREN' => 107,
			'WORD_SCOPED' => 26,
			"if" => 148,
			'WORD_UPPERCASE' => 112,
			"foreach" => -176,
			'LPAREN' => 149,
			'POD' => 110,
			'HASH_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 94,
			"undef" => 100,
			'MY' => 99,
			"}" => 590,
			'WORD' => 28,
			'OP01_NAMED' => 137,
			'LITERAL_NUMBER' => 138,
			'SELF' => 136,
			"for" => -176,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'OPTIONAL-48' => 133,
			'Variable' => 98,
			'ArrayReference' => 132,
			'ScalarLiteral' => 96,
			'PAREN-47' => 97,
			'Array' => 104,
			'ArrayReferenceVariable' => 135,
			'OperatorVoid' => 134,
			'ArrayHashLiteralEmpty' => 103,
			'BracketsEmpty' => 102,
			'BracesEmpty' => 144,
			'HashVariable' => 141,
			'ArrayLiteralNonEmpty' => 142,
			'LoopLabel' => 111,
			'SubExpression' => 150,
			'HashReferenceLiteral' => 147,
			'ScalarVariableOrSelf' => 146,
			'VariableDeclaration' => 108,
			'Expression' => 115,
			'ScalarVariable' => 152,
			'WordScoped' => 154,
			'ArrayReferenceLiteral' => 114,
			'Statement' => 157,
			'HashReference' => 119,
			'Operation' => 589,
			'VariableModification' => 163,
			'Conditional' => 159,
			'Hash' => 123,
			'HashDereference' => 158,
			'HashReferenceVariable' => 122,
			'HashLiteral' => 161,
			'Operator' => 124,
			'ArrayVariable' => 126,
			'ArrayDereference' => 165,
			'Scalar' => 129
		}
	},
	{#State 587
		DEFAULT => -292
	},
	{#State 588
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 591
		}
	},
	{#State 589
		DEFAULT => -86
	},
	{#State 590
		DEFAULT => -88
	},
	{#State 591
		ACTIONS => {
			")" => 594,
			'OP21_LIST_COMMA' => 592
		},
		GOTOS => {
			'PAREN-37' => 593
		}
	},
	{#State 592
		ACTIONS => {
			'MY' => 595
		}
	},
	{#State 593
		DEFAULT => -90
	},
	{#State 594
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 596
		}
	},
	{#State 595
		ACTIONS => {
			'WORD_SCOPED' => 191,
			'WORD' => 190,
			'TYPE_INTEGER' => 194
		},
		GOTOS => {
			'Type' => 597
		}
	},
	{#State 596
		ACTIONS => {
			"\@ARG;" => 598
		}
	},
	{#State 597
		ACTIONS => {
			'SCALAR_SYMBOL' => 599
		}
	},
	{#State 598
		DEFAULT => -92
	},
	{#State 599
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 9967 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9974 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9981 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9988 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9999 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10010 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10024 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10031 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10045 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10066 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10080 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10087 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10094 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10105 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10112 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10126 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10133 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10144 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10155 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10173 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10215 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10222 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10229 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10236 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10247 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10254 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10261 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10272 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10279 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10286 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10297 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10304 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10311 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10318 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10325 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10332 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10339 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10350 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10357 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10371 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10378 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10389 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10400 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10411 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10418 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10425 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10432 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 215 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10439 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10450 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10457 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10464 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 216 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10471 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10482 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10489 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10496 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10503 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10510 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10531 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10538 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10545 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 217 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10552 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10563 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10574 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10585 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10592 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10599 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 219 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10606 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10617 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10628 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 10635 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10642 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10649 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 221 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10656 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10667 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 10674 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 10681 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 222 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 10688 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10699 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10710 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10721 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10732 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10743 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10754 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10765 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10776 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10787 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10798 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10809 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10820 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10831 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10842 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10853 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10864 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10875 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10886 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10897 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10908 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10919 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10930 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10941 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10952 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10963 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10974 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10985 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10996 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11007 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11018 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11029 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11040 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11051 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11062 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11073 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11084 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11095 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11106 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11113 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11120 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 242 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11127 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11134 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 243 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11141 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11152 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11163 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11174 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11185 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11196 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11207 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11218 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11229 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11236 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 245 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11243 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11250 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11257 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11264 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11271 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11282 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11293 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11304 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11315 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11326 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11337 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11348 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11359 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11370 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11381 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11392 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11403 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11414 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11425 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11436 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_164
		 'SubExpression', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11447 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11454 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11461 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11468 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressions_168
		 'SubExpressions', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11479 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_169
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11490 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_170
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11501 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_171
		 'SubExpressionOrInput', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11512 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_172
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11523 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_173
		 'SubExpressionOrVarMod', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11534 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 253 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11555 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_177
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11566 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_178
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11577 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_179
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11588 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_180
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11599 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_181
		 'Statement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11610 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_182
		 'Statement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11621 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 5,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11642 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 11649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 1,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-52', 0,
sub {
#line 254 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 11663 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_189
		 'Conditional', 7,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11674 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_190
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11685 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_191
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11696 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_192
		 'Loop', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11707 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_193
		 'LoopFor', 10,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11718 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_194
		 'LoopFor', 12,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11729 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_195
		 'LoopForEach', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11740 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_196
		 'LoopWhile', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11751 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_197
		 'LoopWhile', 8,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11762 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 2,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 11769 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-53', 1,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 11776 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_200
		 'CodeBlock', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11787 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_201
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11798 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_202
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11809 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_203
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11820 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_204
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11831 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_205
		 'Variable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11842 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_206
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11853 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_207
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11864 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrievalArrow_208
		 'VariableRetrievalArrow', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11875 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_209
		 'VariableRetrieval', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11886 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_210
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11897 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_211
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11908 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_212
		 'VariableRetrieval', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11919 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_213
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11930 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_214
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11941 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_215
		 'VariableDeclaration', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11952 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_216
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11963 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_217
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11974 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_218
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11985 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_219
		 'VariableDeclaration', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 11996 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_220
		 'VariableDeclaration', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12007 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_221
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12018 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_222
		 'VariableModification', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12029 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_223
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12040 lib/RPerl/Grammar.pm
	],
	[#Rule Scalar_224
		 'Scalar', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12051 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_225
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12062 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarLiteral_226
		 'ScalarLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12073 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 2,
sub {
#line 290 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12080 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-54', 1,
sub {
#line 290 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12087 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_229
		 'ScalarVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12098 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_230
		 'ScalarVariable', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12109 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariable_231
		 'ScalarVariable', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12120 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_232
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12131 lib/RPerl/Grammar.pm
	],
	[#Rule ScalarVariableOrSelf_233
		 'ScalarVariableOrSelf', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12142 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayHashLiteralEmpty_234
		 'ArrayHashLiteralEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12153 lib/RPerl/Grammar.pm
	],
	[#Rule BracketsEmpty_235
		 'BracketsEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12164 lib/RPerl/Grammar.pm
	],
	[#Rule BracesEmpty_236
		 'BracesEmpty', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12175 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-55', 2,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12182 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 2,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12189 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-56', 0,
sub {
#line 297 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12196 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_240
		 'ListElements', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12207 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_241
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12218 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_242
		 'ListElement', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12229 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_243
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12240 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_244
		 'ListElement', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12251 lib/RPerl/Grammar.pm
	],
	[#Rule Array_245
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12262 lib/RPerl/Grammar.pm
	],
	[#Rule Array_246
		 'Array', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12273 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-57', 2,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12280 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 2,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12287 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-58', 0,
sub {
#line 305 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12294 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralNonEmpty_250
		 'ArrayLiteralNonEmpty', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12305 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayLiteralNonEmpty_251
		 'ArrayLiteralNonEmpty', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12316 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayVariable_252
		 'ArrayVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12327 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_253
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12338 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_254
		 'ArrayReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12349 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_255
		 'ArrayReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12360 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceLiteral_256
		 'ArrayReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12371 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReferenceVariable_257
		 'ArrayReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12382 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 1,
sub {
#line 311 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12389 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-59', 0,
sub {
#line 311 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12396 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_260
		 'ArrayDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12407 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_261
		 'ArrayDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12418 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-60', 2,
sub {
#line 312 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 12425 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 2,
sub {
#line 312 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 12432 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-61', 0,
sub {
#line 312 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12439 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntries_265
		 'HashEntries', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12450 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-62', 1,
sub {
#line 314 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12457 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-62', 0,
sub {
#line 314 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12464 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_268
		 'HashEntry', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12475 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_269
		 'HashEntry', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12486 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_270
		 'HashEntryProperties', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12497 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_271
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12508 lib/RPerl/Grammar.pm
	],
	[#Rule Hash_272
		 'Hash', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12519 lib/RPerl/Grammar.pm
	],
	[#Rule HashLiteral_273
		 'HashLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12530 lib/RPerl/Grammar.pm
	],
	[#Rule HashVariable_274
		 'HashVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12541 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_275
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12552 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_276
		 'HashReference', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12563 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_277
		 'HashReferenceLiteral', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12574 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceLiteral_278
		 'HashReferenceLiteral', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12585 lib/RPerl/Grammar.pm
	],
	[#Rule HashReferenceVariable_279
		 'HashReferenceVariable', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12596 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 1,
sub {
#line 322 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 12603 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-63', 0,
sub {
#line 322 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 12610 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_282
		 'HashDereference', 3,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12621 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_283
		 'HashDereference', 4,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12632 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_284
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12643 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_285
		 'WordScoped', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12654 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_286
		 'LoopLabel', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12665 lib/RPerl/Grammar.pm
	],
	[#Rule Type_287
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12676 lib/RPerl/Grammar.pm
	],
	[#Rule Type_288
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12687 lib/RPerl/Grammar.pm
	],
	[#Rule Type_289
		 'Type', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12698 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_290
		 'TypeInner', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12709 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_291
		 'TypeInnerProperties', 6,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12720 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_292
		 'TypeInnerProperties', 9,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12731 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_293
		 'TypeInnerConstant', 5,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12742 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_294
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12753 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_295
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12764 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_296
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12775 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_297
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12786 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_298
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12797 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_299
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12808 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_300
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12819 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_301
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12830 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_302
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12841 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_303
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12852 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_304
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12863 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_305
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12874 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_306
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12885 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_307
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12896 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_308
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12907 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_309
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12918 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_310
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12929 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_311
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12940 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_312
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12951 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_313
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12962 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_314
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12973 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_315
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12984 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_316
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 12995 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_317
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13006 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_318
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13017 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_319
		 'OpStringOrWord', 1,
sub {
#line 25 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 13028 lib/RPerl/Grammar.pm
	]
],
#line 13031 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubExpressions_168', 
         'SubExpressionOrInput_169', 
         'SubExpressionOrInput_170', 
         'SubExpressionOrInput_171', 
         'SubExpressionOrVarMod_172', 
         'SubExpressionOrVarMod_173', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_177', 
         'Statement_178', 
         'Statement_179', 
         'Statement_180', 
         'Statement_181', 
         'Statement_182', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_189', 
         'Loop_190', 
         'Loop_191', 
         'Loop_192', 
         'LoopFor_193', 
         'LoopFor_194', 
         'LoopForEach_195', 
         'LoopWhile_196', 
         'LoopWhile_197', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_200', 
         'Variable_201', 
         'Variable_202', 
         'Variable_203', 
         'Variable_204', 
         'Variable_205', 
         'VariableRetrievalArrow_206', 
         'VariableRetrievalArrow_207', 
         'VariableRetrievalArrow_208', 
         'VariableRetrieval_209', 
         'VariableRetrieval_210', 
         'VariableRetrieval_211', 
         'VariableRetrieval_212', 
         'VariableDeclaration_213', 
         'VariableDeclaration_214', 
         'VariableDeclaration_215', 
         'VariableDeclaration_216', 
         'VariableDeclaration_217', 
         'VariableDeclaration_218', 
         'VariableDeclaration_219', 
         'VariableDeclaration_220', 
         'VariableModification_221', 
         'VariableModification_222', 
         'Scalar_223', 
         'Scalar_224', 
         'ScalarLiteral_225', 
         'ScalarLiteral_226', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ScalarVariable_229', 
         'ScalarVariable_230', 
         'ScalarVariable_231', 
         'ScalarVariableOrSelf_232', 
         'ScalarVariableOrSelf_233', 
         'ArrayHashLiteralEmpty_234', 
         'BracketsEmpty_235', 
         'BracesEmpty_236', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_240', 
         'ListElement_241', 
         'ListElement_242', 
         'ListElement_243', 
         'ListElement_244', 
         'Array_245', 
         'Array_246', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ArrayLiteralNonEmpty_250', 
         'ArrayLiteralNonEmpty_251', 
         'ArrayVariable_252', 
         'ArrayReference_253', 
         'ArrayReference_254', 
         'ArrayReferenceLiteral_255', 
         'ArrayReferenceLiteral_256', 
         'ArrayReferenceVariable_257', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_260', 
         'ArrayDereference_261', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashEntries_265', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_268', 
         'HashEntry_269', 
         'HashEntryProperties_270', 
         'Hash_271', 
         'Hash_272', 
         'HashLiteral_273', 
         'HashVariable_274', 
         'HashReference_275', 
         'HashReference_276', 
         'HashReferenceLiteral_277', 
         'HashReferenceLiteral_278', 
         'HashReferenceVariable_279', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_282', 
         'HashDereference_283', 
         'WordScoped_284', 
         'WordScoped_285', 
         'LoopLabel_286', 
         'Type_287', 
         'Type_288', 
         'Type_289', 
         'TypeInner_290', 
         'TypeInnerProperties_291', 
         'TypeInnerProperties_292', 
         'TypeInnerConstant_293', 
         'VarOrLitOrOpStrOrWord_294', 
         'VarOrLitOrOpStrOrWord_295', 
         'VarOrLitOrOpStrOrWord_296', 
         'OpNamedScolonOrSubExp_297', 
         'OpNamedScolonOrSubExp_298', 
         'OpNamedScolonOrSubExp_299', 
         'OpNamedScolonOrSubExpIn_300', 
         'OpNamedScolonOrSubExpIn_301', 
         'OpNamedScolonOrSubExpIn_302', 
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
         'OpStringOrWord_316', 
         'OpStringOrWord_317', 
         'OpStringOrWord_318', 
         'OpStringOrWord_319', );
  $self;
}

#line 341 "lib/RPerl/Grammar.eyp"


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


#line 13567 lib/RPerl/Grammar.pm



1;
