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
    our $VERSION = 0.015_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|package|\$TYPED_|foreach|while|\@ARG\;|undef|elsif|else|INIT|for|if|\%\{|\@\{|\;|\]|\}|\))}gc and return ($1, $1);

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
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer|unsigned_integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G((?:[a-zA-Z]\w*)+(?:::[a-zA-Z]\w*)*::method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)(?:::[a-zA-Z]\w*)*(?:::[A-Z0-9_]*)\(\))/gc and return ('CONSTANT_CALL_SCOPED', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
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
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
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


#line 156 lib/RPerl/Grammar.pm

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
  [ '_PAREN' => 'PAREN-47', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'PAREN-49' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'Conditional_183' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-48', 'OPTIONAL-50' ], 0 ],
  [ 'Loop_184' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_185' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_186' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_187' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_188' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExp', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'OpNamedScolonOrSubExp', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_189' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_190' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_191' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'PLUS-51', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-51', [ 'Operation' ], 0 ],
  [ 'CodeBlock_194' => 'CodeBlock', [ 'LBRACE', 'PLUS-51', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'Variable_197' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-52' ], 0 ],
  [ 'VariableRetrieval_198' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_199' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_200' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_201' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_202' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'OpNamedScolonOrSubExpIn' ], 0 ],
  [ 'VariableDeclaration_203' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_204' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_205' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_206' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-53', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [ 'STAR-54', 'PAREN-53' ], 0 ],
  [ '_STAR_LIST' => 'STAR-54', [  ], 0 ],
  [ 'ListElements_210' => 'ListElements', [ 'ListElement', 'STAR-54' ], 0 ],
  [ 'ListElement_211' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_212' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_213' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_214' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-55', [  ], 0 ],
  [ 'ArrayReference_217' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-55', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-56', [  ], 0 ],
  [ 'ArrayDereference_220' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_221' => 'ArrayDereference', [ '@{', 'OPTIONAL-56', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-57', [  ], 0 ],
  [ 'HashEntry_224' => 'HashEntry', [ 'VarOrLitOrOpStrOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-57', 'SubExpression' ], 0 ],
  [ 'HashEntry_225' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntry_226' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_227' => 'HashEntryProperties', [ 'OpStringOrWord', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-58', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [ 'STAR-59', 'PAREN-58' ], 0 ],
  [ '_STAR_LIST' => 'STAR-59', [  ], 0 ],
  [ 'HashReference_231' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-59', '}' ], 0 ],
  [ 'HashReference_232' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-60', [  ], 0 ],
  [ 'HashDereference_235' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_236' => 'HashDereference', [ '%{', 'OPTIONAL-60', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_237' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_238' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_239' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_240' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_241' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_242' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_243' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_244' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_245' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'OpStringOrWord', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_246' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_247' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_248' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_249' => 'VarOrLitOrOpStrOrWord', [ 'Variable' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_250' => 'VarOrLitOrOpStrOrWord', [ 'Literal' ], 0 ],
  [ 'VarOrLitOrOpStrOrWord_251' => 'VarOrLitOrOpStrOrWord', [ 'OpStringOrWord' ], 0 ],
  [ 'VariableSymbolOrSelf_252' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_253' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_254' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_255' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'OpNamedScolonOrSubExp_256' => 'OpNamedScolonOrSubExp', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_257' => 'OpNamedScolonOrSubExp', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExp_258' => 'OpNamedScolonOrSubExp', [ 'SubExpression', ';' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_259' => 'OpNamedScolonOrSubExpIn', [ 'OP01_NAMED_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_260' => 'OpNamedScolonOrSubExpIn', [ 'OP10_NAMED_UNARY_SCOLON' ], 0 ],
  [ 'OpNamedScolonOrSubExpIn_261' => 'OpNamedScolonOrSubExpIn', [ 'SubExpressionOrInput', ';' ], 0 ],
  [ 'OpStringOrWord_262' => 'OpStringOrWord', [ 'OP24_LOGICAL_OR_XOR' ], 0 ],
  [ 'OpStringOrWord_263' => 'OpStringOrWord', [ 'OP23_LOGICAL_AND' ], 0 ],
  [ 'OpStringOrWord_264' => 'OpStringOrWord', [ 'OP22_LOGICAL_NEG' ], 0 ],
  [ 'OpStringOrWord_265' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OpStringOrWord_266' => 'OpStringOrWord', [ 'OP19_LOOP_CONTROL' ], 0 ],
  [ 'OpStringOrWord_267' => 'OpStringOrWord', [ 'OP12_COMPARE_EQ_NE' ], 0 ],
  [ 'OpStringOrWord_268' => 'OpStringOrWord', [ 'OP11_COMPARE_LT_GT' ], 0 ],
  [ 'OpStringOrWord_269' => 'OpStringOrWord', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'OpStringOrWord_270' => 'OpStringOrWord', [ 'OP08_MATH_ADD_SUB' ], 0 ],
  [ 'OpStringOrWord_271' => 'OpStringOrWord', [ 'OP07_MATH_MULT_DIV_MOD' ], 0 ],
  [ 'OpStringOrWord_272' => 'OpStringOrWord', [ 'OP07_STRING_REPEAT' ], 0 ],
  [ 'OpStringOrWord_273' => 'OpStringOrWord', [ 'OP01_NAMED' ], 0 ],
  [ 'OpStringOrWord_274' => 'OpStringOrWord', [ 'OP01_CLOSE' ], 0 ],
  [ 'OpStringOrWord_275' => 'OpStringOrWord', [ 'OP01_OPEN' ], 0 ],
  [ 'OpStringOrWord_276' => 'OpStringOrWord', [ 'OP01_NAMED_VOID' ], 0 ],
  [ 'OpStringOrWord_277' => 'OpStringOrWord', [ 'OP01_PRINT' ], 0 ],
  [ 'OpStringOrWord_278' => 'OpStringOrWord', [ 'WORD' ], 0 ],
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
  '_PAREN' => 177,
  '_STAR_LIST' => 178,
  '_STAR_LIST' => 179,
  '_PAREN' => 180,
  '_OPTIONAL' => 181,
  '_OPTIONAL' => 182,
  'Conditional_183' => 183,
  'Loop_184' => 184,
  'Loop_185' => 185,
  'Loop_186' => 186,
  'LoopFor_187' => 187,
  'LoopFor_188' => 188,
  'LoopForEach_189' => 189,
  'LoopWhile_190' => 190,
  'LoopWhile_191' => 191,
  '_PLUS_LIST' => 192,
  '_PLUS_LIST' => 193,
  'CodeBlock_194' => 194,
  '_STAR_LIST' => 195,
  '_STAR_LIST' => 196,
  'Variable_197' => 197,
  'VariableRetrieval_198' => 198,
  'VariableRetrieval_199' => 199,
  'VariableRetrieval_200' => 200,
  'VariableDeclaration_201' => 201,
  'VariableDeclaration_202' => 202,
  'VariableDeclaration_203' => 203,
  'VariableDeclaration_204' => 204,
  'VariableModification_205' => 205,
  'VariableModification_206' => 206,
  '_PAREN' => 207,
  '_STAR_LIST' => 208,
  '_STAR_LIST' => 209,
  'ListElements_210' => 210,
  'ListElement_211' => 211,
  'ListElement_212' => 212,
  'ListElement_213' => 213,
  'ListElement_214' => 214,
  '_OPTIONAL' => 215,
  '_OPTIONAL' => 216,
  'ArrayReference_217' => 217,
  '_OPTIONAL' => 218,
  '_OPTIONAL' => 219,
  'ArrayDereference_220' => 220,
  'ArrayDereference_221' => 221,
  '_OPTIONAL' => 222,
  '_OPTIONAL' => 223,
  'HashEntry_224' => 224,
  'HashEntry_225' => 225,
  'HashEntry_226' => 226,
  'HashEntryProperties_227' => 227,
  '_PAREN' => 228,
  '_STAR_LIST' => 229,
  '_STAR_LIST' => 230,
  'HashReference_231' => 231,
  'HashReference_232' => 232,
  '_OPTIONAL' => 233,
  '_OPTIONAL' => 234,
  'HashDereference_235' => 235,
  'HashDereference_236' => 236,
  'WordScoped_237' => 237,
  'WordScoped_238' => 238,
  'LoopLabel_239' => 239,
  'Type_240' => 240,
  'Type_241' => 241,
  'Type_242' => 242,
  'TypeInner_243' => 243,
  'TypeInnerProperties_244' => 244,
  'TypeInnerProperties_245' => 245,
  'TypeInnerConstant_246' => 246,
  'VariableOrLiteral_247' => 247,
  'VariableOrLiteral_248' => 248,
  'VarOrLitOrOpStrOrWord_249' => 249,
  'VarOrLitOrOpStrOrWord_250' => 250,
  'VarOrLitOrOpStrOrWord_251' => 251,
  'VariableSymbolOrSelf_252' => 252,
  'VariableSymbolOrSelf_253' => 253,
  'Literal_254' => 254,
  'Literal_255' => 255,
  'OpNamedScolonOrSubExp_256' => 256,
  'OpNamedScolonOrSubExp_257' => 257,
  'OpNamedScolonOrSubExp_258' => 258,
  'OpNamedScolonOrSubExpIn_259' => 259,
  'OpNamedScolonOrSubExpIn_260' => 260,
  'OpNamedScolonOrSubExpIn_261' => 261,
  'OpStringOrWord_262' => 262,
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
			'SHEBANG' => 2,
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Program' => 1,
			'ModuleHeader' => 6,
			'PAREN-1' => 4,
			'PLUS-2' => 7,
			'OPTIONAL-9' => 9,
			'Critic' => 8,
			'CompileUnit' => 5
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 3,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 10,
			'Critic' => 11
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-17' => 13
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'' => 14
		}
	},
	{#State 6
		ACTIONS => {
			"use constant" => -27,
			'USE' => -27,
			"INIT" => -27,
			'SUB' => -27,
			"use parent -norequire, qw(" => 19,
			"use parent qw(" => 20,
			'USE_EXPORTER' => -27,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'Package' => 21,
			'Class' => 16,
			'Module' => 15,
			'UseParent' => 18,
			'STAR-11' => 17
		}
	},
	{#State 7
		ACTIONS => {
			"package" => -20,
			'' => -5,
			'USE_RPERL' => -20,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 8,
			'OPTIONAL-9' => 9,
			'PAREN-1' => 22,
			'ModuleHeader' => 6
		}
	},
	{#State 8
		DEFAULT => -19
	},
	{#State 9
		ACTIONS => {
			'USE_RPERL' => 23,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 24
		}
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
		DEFAULT => -41
	},
	{#State 13
		ACTIONS => {
			")" => 27,
			'WORD' => 26
		}
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -25
	},
	{#State 17
		ACTIONS => {
			'USE_EXPORTER' => 28,
			"use constant" => -29,
			'SUB' => -29,
			"## no critic qw(" => 3,
			"INIT" => -29,
			'USE' => -29
		},
		GOTOS => {
			'Exports' => 31,
			'Critic' => 30,
			'OPTIONAL-12' => 29
		}
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'WORD' => 34
		},
		GOTOS => {
			'WordScoped' => 33
		}
	},
	{#State 19
		DEFAULT => -78
	},
	{#State 20
		DEFAULT => -77
	},
	{#State 21
		DEFAULT => -24
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		DEFAULT => -21
	},
	{#State 24
		ACTIONS => {
			"package" => 35
		}
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
		DEFAULT => -40
	},
	{#State 27
		DEFAULT => -42
	},
	{#State 28
		ACTIONS => {
			"use constant" => -45,
			'OUR_EXPORT' => 40,
			'OUR_EXPORT_OK' => -45,
			"our hashref \$properties" => -45,
			"INIT" => -45,
			'USE' => -45,
			'SUB' => -45
		},
		GOTOS => {
			'PAREN-18' => 38,
			'OPTIONAL-19' => 39
		}
	},
	{#State 29
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 41
		}
	},
	{#State 30
		DEFAULT => -26
	},
	{#State 31
		DEFAULT => -28
	},
	{#State 32
		DEFAULT => -238
	},
	{#State 33
		ACTIONS => {
			")" => 42
		}
	},
	{#State 34
		DEFAULT => -237
	},
	{#State 35
		ACTIONS => {
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 43
		}
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
		DEFAULT => -44
	},
	{#State 39
		ACTIONS => {
			'SUB' => -48,
			"our hashref \$properties" => -48,
			'USE' => -48,
			"INIT" => -48,
			'OUR_EXPORT_OK' => 46,
			"use constant" => -48
		},
		GOTOS => {
			'PAREN-20' => 47,
			'OPTIONAL-21' => 48
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 49
		}
	},
	{#State 41
		ACTIONS => {
			"INIT" => 53,
			'USE' => 52,
			'SUB' => -33,
			"use constant" => -33
		},
		GOTOS => {
			'STAR-14' => 51,
			'Include' => 50
		}
	},
	{#State 42
		ACTIONS => {
			";" => 54
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55
		}
	},
	{#State 44
		ACTIONS => {
			'USE_RPERL_AFTER' => 56,
			'OUR' => -38
		},
		GOTOS => {
			'OPTIONAL-16' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_PRINT' => -11,
			'WORD_SCOPED' => -11,
			"## no critic qw(" => 3,
			"for" => -11,
			'LBRACE' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			"use constant" => -11,
			'LITERAL_STRING' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"INIT" => -11,
			'USE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			"if" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"\@{" => -11,
			'LPAREN' => -11,
			"%{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			"foreach" => -11,
			'OP01_CLOSE' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"while" => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID' => -11,
			'LBRACKET' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'SELF' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_SCOLON' => -11,
			'SUB' => -11,
			'VARIABLE_SYMBOL' => -11,
			'MY' => -11
		},
		GOTOS => {
			'STAR-5' => 58,
			'Critic' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'OP01_QW' => 60
		}
	},
	{#State 47
		DEFAULT => -47
	},
	{#State 48
		DEFAULT => -49
	},
	{#State 49
		ACTIONS => {
			";" => 61
		}
	},
	{#State 50
		DEFAULT => -30
	},
	{#State 51
		ACTIONS => {
			"use constant" => 64,
			'SUB' => 62
		},
		GOTOS => {
			'PLUS-15' => 66,
			'Constant' => 65,
			'Subroutine' => 63
		}
	},
	{#State 52
		ACTIONS => {
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 67
		}
	},
	{#State 53
		ACTIONS => {
			'LBRACE' => 68
		}
	},
	{#State 54
		ACTIONS => {
			"INIT" => 53,
			'USE' => 52
		},
		GOTOS => {
			'Include' => 69
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
		DEFAULT => -37
	},
	{#State 57
		ACTIONS => {
			'OUR' => 71
		}
	},
	{#State 58
		ACTIONS => {
			'SUB' => -13,
			'VARIABLE_SYMBOL' => -13,
			'MY' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'SELF' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"while" => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			'LBRACKET' => -13,
			'OP01_CLOSE' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			"foreach" => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"undef" => -13,
			'LITERAL_NUMBER' => -13,
			"\@{" => -13,
			'LPAREN' => -13,
			"if" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'LITERAL_STRING' => -13,
			"INIT" => 53,
			'USE' => 52,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			'OP01_NAMED' => -13,
			'OP01_OPEN' => -13,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"use constant" => -13,
			'WORD_SCOPED' => -13,
			"for" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_PRINT' => -13
		},
		GOTOS => {
			'STAR-6' => 73,
			'Include' => 72
		}
	},
	{#State 59
		DEFAULT => -8
	},
	{#State 60
		ACTIONS => {
			";" => 74
		}
	},
	{#State 61
		DEFAULT => -43
	},
	{#State 62
		ACTIONS => {
			'WORD' => 75
		}
	},
	{#State 63
		DEFAULT => -35
	},
	{#State 64
		ACTIONS => {
			'WORD_UPPERCASE' => 76
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			'SUB' => 62,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Subroutine' => 77
		}
	},
	{#State 67
		ACTIONS => {
			";" => -51,
			'OP01_QW' => 80
		},
		GOTOS => {
			'OPTIONAL-22' => 79
		}
	},
	{#State 68
		ACTIONS => {
			'WORD' => 34,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'WordScoped' => 81
		}
	},
	{#State 69
		DEFAULT => -67,
		GOTOS => {
			'STAR-28' => 82
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
			"%{" => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"\@{" => -15,
			'LPAREN' => -15,
			"if" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			'LBRACE' => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			"use constant" => 64,
			'OP01_OPEN' => -15,
			'WORD_SCOPED' => -15,
			"for" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_PRINT' => -15,
			'VARIABLE_SYMBOL' => -15,
			'SUB' => -15,
			'MY' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			'SELF' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"while" => -15,
			'OP10_NAMED_UNARY' => -15,
			'LBRACKET' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_CLOSE' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			"foreach" => -15
		},
		GOTOS => {
			'Constant' => 84,
			'STAR-7' => 85
		}
	},
	{#State 74
		DEFAULT => -46
	},
	{#State 75
		ACTIONS => {
			'LBRACE' => 86
		}
	},
	{#State 76
		ACTIONS => {
			'OP20_HASH_FATARROW' => 87
		}
	},
	{#State 77
		DEFAULT => -34
	},
	{#State 78
		ACTIONS => {
			";" => 88
		}
	},
	{#State 79
		ACTIONS => {
			";" => 89
		}
	},
	{#State 80
		DEFAULT => -50
	},
	{#State 81
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 90
		}
	},
	{#State 82
		ACTIONS => {
			"use constant" => -69,
			'USE_EXPORTER' => 28,
			"## no critic qw(" => 3,
			'USE' => -69,
			"our hashref \$properties" => -69,
			"INIT" => -69
		},
		GOTOS => {
			'Exports' => 93,
			'Critic' => 91,
			'OPTIONAL-29' => 92
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
			'OP01_NAMED_VOID_SCOLON' => 147,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'MY' => 142,
			'VARIABLE_SYMBOL' => 139,
			'SUB' => 62,
			'OP01_NAMED_SCOLON' => 136,
			'WORD_UPPERCASE' => 137,
			"foreach" => -171,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LBRACKET' => 128,
			'OP01_NAMED_VOID' => 129,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			"while" => -171,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP10_NAMED_UNARY' => 127,
			'OP01_CLOSE' => 124,
			'OP05_LOGICAL_NEG' => 121,
			"if" => 119,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 114,
			"%{" => 108,
			'LPAREN' => 106,
			"\@{" => 105,
			"for" => -171,
			'WORD_SCOPED' => 32,
			'OP01_PRINT' => 104,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 94,
			'LBRACE' => 95
		},
		GOTOS => {
			'HashDereference' => 103,
			'Operation' => 130,
			'LoopLabel' => 133,
			'OPTIONAL-46' => 134,
			'VariableModification' => 135,
			'ArrayReference' => 132,
			'VariableDeclaration' => 97,
			'PLUS-8' => 122,
			'Subroutine' => 123,
			'Operator' => 100,
			'HashReference' => 115,
			'Statement' => 118,
			'WordScoped' => 117,
			'Conditional' => 143,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 120,
			'OperatorVoid' => 138,
			'SubExpression' => 112,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 141,
			'PAREN-45' => 107
		}
	},
	{#State 86
		ACTIONS => {
			'LBRACE' => 148
		}
	},
	{#State 87
		ACTIONS => {
			'MY' => 149
		},
		GOTOS => {
			'TypeInnerConstant' => 150
		}
	},
	{#State 88
		DEFAULT => -36
	},
	{#State 89
		DEFAULT => -54
	},
	{#State 90
		ACTIONS => {
			'OP01_QW' => 152,
			")" => -53
		},
		GOTOS => {
			'OPTIONAL-23' => 151
		}
	},
	{#State 91
		DEFAULT => -66
	},
	{#State 92
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 153
		}
	},
	{#State 93
		DEFAULT => -68
	},
	{#State 94
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'MY' => 156,
			"undef" => 113,
			'LITERAL_NUMBER' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'SubExpression' => 161,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'TypeInner' => 158,
			'ListElement' => 160
		}
	},
	{#State 95
		ACTIONS => {
			'OP01_NAMED_VOID' => 184,
			'WORD' => 185,
			'OP10_NAMED_UNARY' => 187,
			'OP22_LOGICAL_NEG' => 188,
			'OP24_LOGICAL_OR_XOR' => 180,
			'LITERAL_STRING' => 99,
			'OP01_OPEN' => 177,
			'OP01_CLOSE' => 183,
			'OP01_NAMED' => 178,
			'OP23_LOGICAL_AND' => 176,
			"}" => 171,
			'OP01_PRINT' => 172,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP19_LOOP_CONTROL' => 168,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'ENV' => 181,
			'OP07_STRING_REPEAT' => 167,
			'OP11_COMPARE_LT_GT' => 164,
			'SELF' => 144
		},
		GOTOS => {
			'OpStringOrWord' => 186,
			'VarOrLitOrOpStrOrWord' => 179,
			'VariableSymbolOrSelf' => 145,
			'HashEntry' => 182,
			'Literal' => 170,
			'Variable' => 165,
			'HashDereference' => 173
		}
	},
	{#State 96
		DEFAULT => -97
	},
	{#State 97
		DEFAULT => -175
	},
	{#State 98
		ACTIONS => {
			'MY' => 189
		}
	},
	{#State 99
		DEFAULT => -255
	},
	{#State 100
		DEFAULT => -149
	},
	{#State 101
		ACTIONS => {
			'SELF' => 144,
			'VARIABLE_SYMBOL' => 139
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 190
		}
	},
	{#State 102
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139
		},
		GOTOS => {
			'SubExpression' => 191,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132
		}
	},
	{#State 103
		DEFAULT => -162
	},
	{#State 104
		ACTIONS => {
			'OP01_OPEN' => -132,
			'OP01_CLOSE' => -132,
			'LBRACE' => -132,
			'FHREF_SYMBOL_BRACES' => 192,
			'OP01_NAMED' => -132,
			'OP01_QW' => -132,
			'WORD' => -132,
			'LBRACKET' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP10_NAMED_UNARY' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'LITERAL_STRING' => -132,
			'OP05_MATH_NEG_LPAREN' => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'WORD_SCOPED' => -132,
			'LPAREN' => -132,
			'ARGV' => -132,
			"\@{" => -132,
			'WORD_UPPERCASE' => -132,
			"undef" => -132,
			'LITERAL_NUMBER' => -132,
			'MY' => -132,
			"%{" => -132,
			'VARIABLE_SYMBOL' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'STDOUT_STDERR' => 194,
			'OP05_LOGICAL_NEG' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'SELF' => -132
		},
		GOTOS => {
			'PAREN-39' => 195,
			'OPTIONAL-40' => 193
		}
	},
	{#State 105
		ACTIONS => {
			'MY' => 156,
			'LBRACKET' => -219,
			'SELF' => 144,
			'VARIABLE_SYMBOL' => 139
		},
		GOTOS => {
			'TypeInner' => 197,
			'OPTIONAL-56' => 198,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 196
		}
	},
	{#State 106
		ACTIONS => {
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_PRINT' => 200,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP01_NAMED' => 201,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 199
		}
	},
	{#State 107
		DEFAULT => -170
	},
	{#State 108
		ACTIONS => {
			'SELF' => 144,
			'VARIABLE_SYMBOL' => 139,
			'MY' => 156,
			'LBRACE' => -234
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 202,
			'OPTIONAL-60' => 204,
			'TypeInner' => 203
		}
	},
	{#State 109
		DEFAULT => -157
	},
	{#State 110
		DEFAULT => -141
	},
	{#State 111
		DEFAULT => -254
	},
	{#State 112
		ACTIONS => {
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP18_TERNARY' => 208,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => 205
		}
	},
	{#State 113
		DEFAULT => -156
	},
	{#State 114
		ACTIONS => {
			'WORD_UPPERCASE' => 222
		},
		GOTOS => {
			'LoopLabel' => 223
		}
	},
	{#State 115
		DEFAULT => -161
	},
	{#State 116
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'SubExpression' => 224,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Expression' => 157,
			'Literal' => 109
		}
	},
	{#State 117
		ACTIONS => {
			'LPAREN' => 225,
			'OP02_METHOD_THINARROW_NEW' => 226
		}
	},
	{#State 118
		DEFAULT => -98
	},
	{#State 119
		ACTIONS => {
			'LPAREN' => 227
		}
	},
	{#State 120
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP04_MATH_POW' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 228,
			'OP08_STRING_CAT' => -158,
			'OP03_MATH_INC_DEC' => 231,
			'OP18_TERNARY' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP19_VARIABLE_ASSIGN' => 229,
			'OP02_METHOD_THINARROW' => 230,
			'OP13_BITWISE_AND' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP17_LIST_RANGE' => -158
		}
	},
	{#State 121
		ACTIONS => {
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144
		},
		GOTOS => {
			'SubExpression' => 232,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 122
		ACTIONS => {
			"foreach" => -171,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LBRACKET' => 128,
			'OP01_NAMED_VOID' => 129,
			'WORD' => 34,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"while" => -171,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'OP01_CLOSE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 147,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'MY' => 142,
			'VARIABLE_SYMBOL' => 139,
			'OP01_NAMED_SCOLON' => 136,
			'WORD_UPPERCASE' => 137,
			"for" => -171,
			'WORD_SCOPED' => 32,
			'OP01_PRINT' => 104,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 94,
			'' => -18,
			'LBRACE' => 95,
			'OP05_LOGICAL_NEG' => 121,
			"if" => 119,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 114,
			"%{" => 108,
			'LPAREN' => 106,
			"\@{" => 105
		},
		GOTOS => {
			'Operation' => 233,
			'HashDereference' => 103,
			'VariableModification' => 135,
			'OPTIONAL-46' => 134,
			'LoopLabel' => 133,
			'ArrayReference' => 132,
			'VariableDeclaration' => 97,
			'Operator' => 100,
			'WordScoped' => 117,
			'Statement' => 118,
			'HashReference' => 115,
			'Variable' => 120,
			'VariableSymbolOrSelf' => 145,
			'Conditional' => 143,
			'OperatorVoid' => 138,
			'SubExpression' => 112,
			'Expression' => 141,
			'PAREN-45' => 107,
			'Literal' => 109,
			'ArrayDereference' => 140
		}
	},
	{#State 123
		DEFAULT => -14
	},
	{#State 124
		ACTIONS => {
			'FHREF_SYMBOL' => 234
		}
	},
	{#State 125
		ACTIONS => {
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'MY' => 156,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			")" => -134,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'HashReference' => 115,
			'WordScoped' => 117,
			'OPTIONAL-41' => 235,
			'HashDereference' => 103,
			'ListElements' => 238,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 236,
			'TypeInner' => 158,
			'ListElement' => 237
		}
	},
	{#State 126
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98
		},
		GOTOS => {
			'SubExpression' => 239,
			'Literal' => 109,
			'Expression' => 157,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP06_REGEX_BIND' => -117,
			'OP18_TERNARY' => -117,
			'OP01_CLOSE' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP13_BITWISE_AND' => -117,
			'VARIABLE_SYMBOL' => 139,
			"]" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP21_LIST_COMMA' => -117,
			'WORD_UPPERCASE' => 155,
			'SELF' => 144,
			";" => -117,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP09_BITWISE_SHIFT' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'LITERAL_STRING' => 99,
			'OP08_STRING_CAT' => -117,
			'OP04_MATH_POW' => -117,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 163,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP16_LOGICAL_OR' => -117,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'WORD_SCOPED' => 32,
			'OP23_LOGICAL_AND' => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP05_MATH_NEG_LPAREN' => 102,
			")" => -117,
			"}" => -117,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"\@{" => 105,
			'OP07_STRING_REPEAT' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'LPAREN' => 106,
			'OP11_COMPARE_LT_GT' => -117,
			'OP05_LOGICAL_NEG' => 121,
			'OP17_LIST_RANGE' => -117,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'SubExpression' => 240,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157
		}
	},
	{#State 128
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			"\@{" => 105,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 155,
			"undef" => 113,
			'MY' => 156,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			"]" => -216,
			'VARIABLE_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'OPTIONAL-55' => 241,
			'HashDereference' => 103,
			'ListElements' => 242,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 236,
			'ListElement' => 237,
			'TypeInner' => 158
		}
	},
	{#State 129
		ACTIONS => {
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'MY' => 156,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'SubExpression' => 236,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'TypeInner' => 158,
			'ListElement' => 237,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'HashDereference' => 103,
			'ListElements' => 243,
			'HashReference' => 115,
			'WordScoped' => 117
		}
	},
	{#State 130
		DEFAULT => -17
	},
	{#State 131
		ACTIONS => {
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 244,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103
		}
	},
	{#State 132
		DEFAULT => -159
	},
	{#State 133
		ACTIONS => {
			'COLON' => 245
		}
	},
	{#State 134
		ACTIONS => {
			"foreach" => 251,
			"for" => 248,
			"while" => 250
		},
		GOTOS => {
			'LoopForEach' => 252,
			'LoopFor' => 247,
			'Loop' => 249,
			'LoopWhile' => 246
		}
	},
	{#State 135
		ACTIONS => {
			";" => 253
		}
	},
	{#State 136
		DEFAULT => -96
	},
	{#State 137
		ACTIONS => {
			'COLON' => -239,
			'LPAREN' => 254
		}
	},
	{#State 138
		DEFAULT => -174
	},
	{#State 139
		DEFAULT => -252
	},
	{#State 140
		DEFAULT => -160
	},
	{#State 141
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP04_MATH_POW' => -155,
			'OP08_STRING_CAT' => -155,
			'OP18_TERNARY' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP13_BITWISE_AND' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP07_STRING_REPEAT' => -155,
			";" => 255,
			'OP09_BITWISE_SHIFT' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP17_LIST_RANGE' => -155
		}
	},
	{#State 142
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD' => 260,
			'TYPE_FHREF' => 258,
			'WORD_SCOPED' => 257
		},
		GOTOS => {
			'Type' => 259
		}
	},
	{#State 143
		DEFAULT => -172
	},
	{#State 144
		DEFAULT => -253
	},
	{#State 145
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 261
		}
	},
	{#State 146
		DEFAULT => -151
	},
	{#State 147
		DEFAULT => -137
	},
	{#State 148
		ACTIONS => {
			'MY' => 262
		}
	},
	{#State 149
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD_SCOPED' => 257,
			'WORD' => 260
		},
		GOTOS => {
			'Type' => 263
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL_NUMBER' => 111,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Literal' => 264
		}
	},
	{#State 151
		ACTIONS => {
			")" => 265
		}
	},
	{#State 152
		DEFAULT => -52
	},
	{#State 153
		ACTIONS => {
			'USE' => 52,
			"our hashref \$properties" => -73,
			"INIT" => 53,
			"use constant" => -73
		},
		GOTOS => {
			'Include' => 267,
			'STAR-31' => 266
		}
	},
	{#State 154
		DEFAULT => -214
	},
	{#State 155
		ACTIONS => {
			'LPAREN' => 254
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 260,
			'WORD_SCOPED' => 257,
			'TYPE_INTEGER' => 256
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 157
		DEFAULT => -155
	},
	{#State 158
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111
		},
		GOTOS => {
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 269
		}
	},
	{#State 159
		DEFAULT => -213
	},
	{#State 160
		ACTIONS => {
			'OP21_LIST_COMMA' => 270
		}
	},
	{#State 161
		ACTIONS => {
			'OP21_LIST_COMMA' => -211,
			'OP15_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			'OP08_STRING_CAT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP23_LOGICAL_AND' => -100
		}
	},
	{#State 162
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP04_MATH_POW' => -158,
			'OP03_MATH_INC_DEC' => 231,
			'OP08_STRING_CAT' => -158,
			'OP06_REGEX_BIND' => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP18_TERNARY' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			"}" => -158,
			'OP13_BITWISE_AND' => -158,
			'OP02_METHOD_THINARROW' => 230,
			"]" => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP21_LIST_COMMA' => -158,
			'OP07_STRING_REPEAT' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			";" => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP17_LIST_RANGE' => -158
		}
	},
	{#State 163
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139
		},
		GOTOS => {
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'SubExpression' => 271,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109
		}
	},
	{#State 164
		DEFAULT => -268
	},
	{#State 165
		DEFAULT => -249
	},
	{#State 166
		DEFAULT => -271
	},
	{#State 167
		DEFAULT => -272
	},
	{#State 168
		DEFAULT => -266
	},
	{#State 169
		DEFAULT => -265
	},
	{#State 170
		DEFAULT => -250
	},
	{#State 171
		DEFAULT => -232
	},
	{#State 172
		DEFAULT => -277
	},
	{#State 173
		DEFAULT => -225
	},
	{#State 174
		DEFAULT => -270
	},
	{#State 175
		DEFAULT => -267
	},
	{#State 176
		DEFAULT => -263
	},
	{#State 177
		DEFAULT => -275
	},
	{#State 178
		DEFAULT => -273
	},
	{#State 179
		ACTIONS => {
			'OP20_HASH_FATARROW' => 272
		}
	},
	{#State 180
		DEFAULT => -262
	},
	{#State 181
		DEFAULT => -226
	},
	{#State 182
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 273
		}
	},
	{#State 183
		DEFAULT => -274
	},
	{#State 184
		DEFAULT => -276
	},
	{#State 185
		DEFAULT => -278
	},
	{#State 186
		DEFAULT => -251
	},
	{#State 187
		DEFAULT => -269
	},
	{#State 188
		DEFAULT => -264
	},
	{#State 189
		ACTIONS => {
			'TYPE_FHREF' => 274
		}
	},
	{#State 190
		DEFAULT => -104
	},
	{#State 191
		ACTIONS => {
			'OP15_LOGICAL_AND' => 205,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP13_BITWISE_AND' => 206,
			'OP17_LIST_RANGE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP18_TERNARY' => 208,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP08_MATH_ADD_SUB' => 219,
			")" => 275,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => 221
		}
	},
	{#State 192
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP01_OPEN' => 98,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"undef" => 113,
			'MY' => 156,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LPAREN' => 106,
			"\@{" => 105,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 155
		},
		GOTOS => {
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 236,
			'TypeInner' => 158,
			'ListElement' => 237,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashReference' => 115,
			'WordScoped' => 117,
			'ListElements' => 276,
			'HashDereference' => 103
		}
	},
	{#State 193
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'MY' => 156,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101
		},
		GOTOS => {
			'SubExpression' => 236,
			'Literal' => 109,
			'Expression' => 157,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'ListElement' => 237,
			'TypeInner' => 158,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'ListElements' => 277,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115
		}
	},
	{#State 194
		DEFAULT => -130
	},
	{#State 195
		DEFAULT => -131
	},
	{#State 196
		ACTIONS => {
			"}" => 278
		}
	},
	{#State 197
		DEFAULT => -218
	},
	{#State 198
		ACTIONS => {
			'LBRACKET' => 128
		},
		GOTOS => {
			'ArrayReference' => 279
		}
	},
	{#State 199
		ACTIONS => {
			'OP17_LIST_RANGE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP13_BITWISE_AND' => 206,
			'OP12_COMPARE_EQ_NE' => 220,
			")" => 280,
			'OP08_MATH_ADD_SUB' => 219,
			'OP23_LOGICAL_AND' => 221,
			'OP18_TERNARY' => 208,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216
		}
	},
	{#State 200
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 281
		}
	},
	{#State 201
		ACTIONS => {
			"undef" => 113,
			'MY' => 156,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LPAREN' => 106,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP01_OPEN' => 98,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'TypeInner' => 158,
			'ListElement' => 282,
			'SubExpression' => 161,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157
		}
	},
	{#State 202
		ACTIONS => {
			"}" => 283
		}
	},
	{#State 203
		DEFAULT => -233
	},
	{#State 204
		ACTIONS => {
			'LBRACE' => 95
		},
		GOTOS => {
			'HashReference' => 284
		}
	},
	{#State 205
		ACTIONS => {
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144
		},
		GOTOS => {
			'SubExpression' => 285,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162
		}
	},
	{#State 206
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106
		},
		GOTOS => {
			'SubExpression' => 286,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 207
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155
		},
		GOTOS => {
			'SubExpression' => 287,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132
		}
	},
	{#State 208
		ACTIONS => {
			'SELF' => 144,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_STRING' => 99,
			'LITERAL_NUMBER' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 288,
			'Literal' => 289,
			'VariableOrLiteral' => 290
		}
	},
	{#State 209
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 291
		}
	},
	{#State 210
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106
		},
		GOTOS => {
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 292,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103
		}
	},
	{#State 211
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146
		},
		GOTOS => {
			'Expression' => 157,
			'Literal' => 109,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'SubExpression' => 293,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 212
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Expression' => 157,
			'Literal' => 109,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'SubExpression' => 294
		}
	},
	{#State 213
		ACTIONS => {
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 295
		}
	},
	{#State 214
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128
		},
		GOTOS => {
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 296,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 215
		ACTIONS => {
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'SubExpression' => 297,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162
		}
	},
	{#State 216
		ACTIONS => {
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP01_OPEN' => 98,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131
		},
		GOTOS => {
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 298
		}
	},
	{#State 217
		ACTIONS => {
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'SubExpression' => 299,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140
		}
	},
	{#State 218
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 300,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 219
		ACTIONS => {
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'Expression' => 157,
			'Literal' => 109,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'SubExpression' => 301,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 220
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146
		},
		GOTOS => {
			'SubExpression' => 302,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162
		}
	},
	{#State 221
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 303
		}
	},
	{#State 222
		DEFAULT => -239
	},
	{#State 223
		ACTIONS => {
			";" => 304
		}
	},
	{#State 224
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => 208,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP23_LOGICAL_AND' => 221,
			")" => 305,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220
		}
	},
	{#State 225
		ACTIONS => {
			")" => -144,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'ARGV' => 154,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'MY' => 156,
			'LITERAL_NUMBER' => 111
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'OPTIONAL-42' => 307,
			'SubExpression' => 236,
			'ListElement' => 237,
			'TypeInner' => 158,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ListElements' => 306
		}
	},
	{#State 226
		ACTIONS => {
			")" => -148,
			'LBRACE' => 95
		},
		GOTOS => {
			'OPTIONAL-44' => 309,
			'HashReference' => 308
		}
	},
	{#State 227
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 310
		}
	},
	{#State 228
		ACTIONS => {
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 311,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 229
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP01_OPEN' => 98,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'FHREF_SYMBOL_IN' => 312,
			'OP05_LOGICAL_NEG' => 121,
			'STDIN' => 315,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139
		},
		GOTOS => {
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'SubExpressionOrInput' => 313,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 314
		}
	},
	{#State 230
		ACTIONS => {
			'LPAREN' => 316
		}
	},
	{#State 231
		DEFAULT => -105
	},
	{#State 232
		ACTIONS => {
			'OP23_LOGICAL_AND' => -108,
			"}" => -108,
			")" => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP06_REGEX_BIND' => -108,
			'OP18_TERNARY' => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			";" => -108,
			'OP17_LIST_RANGE' => -108,
			'OP13_BITWISE_AND' => -108,
			"]" => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			'OP15_LOGICAL_AND' => -108,
			'OP21_LIST_COMMA' => -108
		}
	},
	{#State 233
		DEFAULT => -16
	},
	{#State 234
		DEFAULT => -103
	},
	{#State 235
		ACTIONS => {
			")" => 317
		}
	},
	{#State 236
		ACTIONS => {
			";" => -211,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			"]" => -211,
			'OP15_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -211,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP23_LOGICAL_AND' => 221,
			")" => -211,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP18_TERNARY' => 208
		}
	},
	{#State 237
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 318
		}
	},
	{#State 238
		DEFAULT => -133
	},
	{#State 239
		ACTIONS => {
			"}" => -127,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -127,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => -127,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP17_LIST_RANGE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			";" => -127,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP21_LIST_COMMA' => -127,
			'OP15_LOGICAL_AND' => 205,
			'OP13_BITWISE_AND' => 206,
			"]" => -127
		}
	},
	{#State 240
		ACTIONS => {
			'OP23_LOGICAL_AND' => -116,
			'OP12_COMPARE_EQ_NE' => -116,
			")" => -116,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => -116,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP16_LOGICAL_OR' => -116,
			";" => -116,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => -116,
			'OP17_LIST_RANGE' => -116,
			"]" => -116,
			'OP13_BITWISE_AND' => -116,
			'OP21_LIST_COMMA' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211
		}
	},
	{#State 241
		ACTIONS => {
			"]" => 319
		}
	},
	{#State 242
		DEFAULT => -215
	},
	{#State 243
		ACTIONS => {
			";" => 320
		}
	},
	{#State 244
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 212,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			")" => 321
		}
	},
	{#State 245
		DEFAULT => -169
	},
	{#State 246
		DEFAULT => -186
	},
	{#State 247
		DEFAULT => -184
	},
	{#State 248
		ACTIONS => {
			'LPAREN_MY' => 323,
			'MY' => 322
		}
	},
	{#State 249
		DEFAULT => -173
	},
	{#State 250
		ACTIONS => {
			'LPAREN' => 325,
			'LPAREN_MY' => 324
		}
	},
	{#State 251
		ACTIONS => {
			'MY' => 326
		}
	},
	{#State 252
		DEFAULT => -185
	},
	{#State 253
		DEFAULT => -176
	},
	{#State 254
		ACTIONS => {
			")" => 327
		}
	},
	{#State 255
		DEFAULT => -95
	},
	{#State 256
		DEFAULT => -242
	},
	{#State 257
		DEFAULT => -241
	},
	{#State 258
		ACTIONS => {
			'FHREF_SYMBOL' => 328
		}
	},
	{#State 259
		ACTIONS => {
			'VARIABLE_SYMBOL' => 329
		}
	},
	{#State 260
		DEFAULT => -240
	},
	{#State 261
		ACTIONS => {
			'OP04_MATH_POW' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP08_STRING_CAT' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP18_TERNARY' => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			'OP02_ARRAY_THINARROW' => 330,
			'OP16_LOGICAL_OR' => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			"}" => -197,
			'OP08_MATH_ADD_SUB' => -197,
			'OP12_COMPARE_EQ_NE' => -197,
			")" => -197,
			"]" => -197,
			'OP02_METHOD_THINARROW' => -197,
			'OP13_BITWISE_AND' => -197,
			'OP07_MATH_MULT_DIV_MOD' => -197,
			'OP07_STRING_REPEAT' => -197,
			'OP02_HASH_THINARROW' => 332,
			'OP21_LIST_COMMA' => -197,
			'OP15_LOGICAL_AND' => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP11_COMPARE_LT_GT' => -197,
			";" => -197,
			'COLON' => -197,
			'OP17_LIST_RANGE' => -197
		},
		GOTOS => {
			'VariableRetrieval' => 331
		}
	},
	{#State 262
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD_SCOPED' => 257,
			'WORD' => 260
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 263
		ACTIONS => {
			"\$TYPED_" => 334
		}
	},
	{#State 264
		ACTIONS => {
			";" => 335
		}
	},
	{#State 265
		ACTIONS => {
			";" => 336
		}
	},
	{#State 266
		ACTIONS => {
			"use constant" => 64,
			"our hashref \$properties" => 338
		},
		GOTOS => {
			'Constant' => 339,
			'Properties' => 337
		}
	},
	{#State 267
		DEFAULT => -70
	},
	{#State 268
		ACTIONS => {
			"\$TYPED_" => 340
		}
	},
	{#State 269
		ACTIONS => {
			'OP15_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -212,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			"]" => -212,
			'OP13_BITWISE_AND' => 206,
			'OP17_LIST_RANGE' => 212,
			";" => -212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP18_TERNARY' => 208,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			")" => -212,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => 221
		}
	},
	{#State 270
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'MY' => 156,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144
		},
		GOTOS => {
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'HashDereference' => 103,
			'ListElements' => 341,
			'WordScoped' => 117,
			'HashReference' => 115,
			'SubExpression' => 236,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'ListElement' => 237,
			'TypeInner' => 158
		}
	},
	{#State 271
		ACTIONS => {
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			")" => -100,
			'OP08_MATH_ADD_SUB' => -100,
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => -100,
			'OP08_STRING_CAT' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP18_TERNARY' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100
		}
	},
	{#State 272
		ACTIONS => {
			'WORD_SCOPED' => -223,
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'WORD' => -223,
			'LBRACKET' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'OP10_NAMED_UNARY' => -223,
			'LITERAL_STRING' => -223,
			'OP22_LOGICAL_NEG' => -223,
			'OP01_OPEN' => -223,
			'LBRACE' => -223,
			'OP01_CLOSE' => -223,
			'OP01_NAMED' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'CONSTANT_CALL_SCOPED' => -223,
			'SELF' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			'MY' => 156,
			"undef" => -223,
			'LITERAL_NUMBER' => -223,
			"%{" => -223,
			'VARIABLE_SYMBOL' => -223,
			'LPAREN' => -223,
			'WORD_UPPERCASE' => -223,
			"\@{" => -223
		},
		GOTOS => {
			'OPTIONAL-57' => 343,
			'TypeInner' => 342
		}
	},
	{#State 273
		ACTIONS => {
			'OP21_LIST_COMMA' => 344,
			"}" => 345
		},
		GOTOS => {
			'PAREN-58' => 346
		}
	},
	{#State 274
		ACTIONS => {
			'FHREF_SYMBOL' => 347
		}
	},
	{#State 275
		DEFAULT => -109
	},
	{#State 276
		ACTIONS => {
			";" => 348
		}
	},
	{#State 277
		ACTIONS => {
			";" => 349
		}
	},
	{#State 278
		DEFAULT => -220
	},
	{#State 279
		ACTIONS => {
			"}" => 350
		}
	},
	{#State 280
		DEFAULT => -163
	},
	{#State 281
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'MY' => 156,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 236,
			'ListElement' => 237,
			'TypeInner' => 158,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'ListElements' => 351,
			'HashDereference' => 103
		}
	},
	{#State 282
		ACTIONS => {
			'OP21_LIST_COMMA' => 352
		}
	},
	{#State 283
		DEFAULT => -235
	},
	{#State 284
		ACTIONS => {
			"}" => 353
		}
	},
	{#State 285
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP16_LOGICAL_OR' => -122,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -122,
			'OP12_COMPARE_EQ_NE' => 220,
			"}" => -122,
			'OP13_BITWISE_AND' => 206,
			"]" => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP21_LIST_COMMA' => -122,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			";" => -122,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => -122
		}
	},
	{#State 286
		ACTIONS => {
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP18_TERNARY' => -120,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			'OP23_LOGICAL_AND' => -120,
			"}" => -120,
			")" => -120,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			"]" => -120,
			'OP13_BITWISE_AND' => -120,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP21_LIST_COMMA' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -120,
			'OP17_LIST_RANGE' => -120
		}
	},
	{#State 287
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -115,
			'OP09_BITWISE_SHIFT' => -115,
			";" => -115,
			'OP17_LIST_RANGE' => -115,
			'OP13_BITWISE_AND' => -115,
			"]" => -115,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP21_LIST_COMMA' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP23_LOGICAL_AND' => -115,
			"}" => -115,
			")" => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP08_MATH_ADD_SUB' => 219,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP16_LOGICAL_OR' => -115,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => -115,
			'OP18_TERNARY' => -115
		}
	},
	{#State 288
		DEFAULT => -247
	},
	{#State 289
		DEFAULT => -248
	},
	{#State 290
		ACTIONS => {
			'COLON' => 354
		}
	},
	{#State 291
		DEFAULT => -110
	},
	{#State 292
		ACTIONS => {
			"]" => -112,
			'OP13_BITWISE_AND' => -112,
			'OP21_LIST_COMMA' => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP07_STRING_REPEAT' => 211,
			";" => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_STRING_CAT' => -112,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => -112,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP23_LOGICAL_AND' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			")" => -112,
			'OP08_MATH_ADD_SUB' => -112,
			"}" => -112
		}
	},
	{#State 293
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP08_STRING_CAT' => -111,
			'OP04_MATH_POW' => 216,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP18_TERNARY' => -111,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			")" => -111,
			'OP08_MATH_ADD_SUB' => -111,
			"}" => -111,
			'OP13_BITWISE_AND' => -111,
			"]" => -111,
			'OP15_LOGICAL_AND' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			";" => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			'OP17_LIST_RANGE' => -111
		}
	},
	{#State 294
		ACTIONS => {
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -124,
			'OP13_BITWISE_AND' => 206,
			"]" => -124,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -124,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP18_TERNARY' => -124,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => -124,
			"}" => -124,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -124,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => -124
		}
	},
	{#State 295
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP16_LOGICAL_OR' => -118,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => -118,
			'OP18_TERNARY' => -118,
			'OP23_LOGICAL_AND' => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			")" => -118,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -118,
			'OP13_BITWISE_AND' => -118,
			"]" => -118,
			'OP21_LIST_COMMA' => -118,
			'OP15_LOGICAL_AND' => -118,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			";" => -118,
			'OP11_COMPARE_LT_GT' => undef,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => -118
		}
	},
	{#State 296
		ACTIONS => {
			'OP23_LOGICAL_AND' => -123,
			'OP12_COMPARE_EQ_NE' => 220,
			")" => -123,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -123,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP18_TERNARY' => -123,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => -123,
			";" => -123,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => -123,
			"]" => -123,
			'OP13_BITWISE_AND' => 206,
			'OP21_LIST_COMMA' => -123,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211
		}
	},
	{#State 297
		ACTIONS => {
			'OP17_LIST_RANGE' => -121,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP21_LIST_COMMA' => -121,
			'OP15_LOGICAL_AND' => -121,
			"]" => -121,
			'OP13_BITWISE_AND' => 206,
			"}" => -121,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -121,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => -121,
			'OP18_TERNARY' => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP06_REGEX_BIND' => 209,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => -121
		}
	},
	{#State 298
		ACTIONS => {
			")" => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP06_REGEX_BIND' => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => -106,
			'OP17_LIST_RANGE' => -106,
			";" => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP13_BITWISE_AND' => -106,
			"]" => -106
		}
	},
	{#State 299
		ACTIONS => {
			'OP13_BITWISE_AND' => -114,
			"]" => -114,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			";" => -114,
			'OP17_LIST_RANGE' => -114,
			'OP08_STRING_CAT' => -114,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP16_LOGICAL_OR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => -114,
			'OP23_LOGICAL_AND' => -114,
			"}" => -114,
			")" => -114,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => -114
		}
	},
	{#State 300
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			"]" => -129,
			'OP21_LIST_COMMA' => -129,
			'OP15_LOGICAL_AND' => 205,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			";" => -129,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -129,
			'OP12_COMPARE_EQ_NE' => 220,
			"}" => -129
		}
	},
	{#State 301
		ACTIONS => {
			'OP17_LIST_RANGE' => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			";" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP21_LIST_COMMA' => -113,
			'OP15_LOGICAL_AND' => -113,
			"]" => -113,
			'OP13_BITWISE_AND' => -113,
			"}" => -113,
			'OP08_MATH_ADD_SUB' => -113,
			")" => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP23_LOGICAL_AND' => -113,
			'OP18_TERNARY' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => -113,
			'OP08_STRING_CAT' => -113,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => -113
		}
	},
	{#State 302
		ACTIONS => {
			"]" => -119,
			'OP13_BITWISE_AND' => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP21_LIST_COMMA' => -119,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			";" => -119,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => -119,
			'OP24_LOGICAL_OR_XOR' => -119,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => -119,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => -119,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP23_LOGICAL_AND' => -119,
			'OP12_COMPARE_EQ_NE' => undef,
			")" => -119,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -119
		}
	},
	{#State 303
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			")" => -128,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP15_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -128,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP13_BITWISE_AND' => 206,
			"]" => -128,
			'OP17_LIST_RANGE' => 212,
			";" => -128,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207
		}
	},
	{#State 304
		DEFAULT => -142
	},
	{#State 305
		DEFAULT => -107
	},
	{#State 306
		DEFAULT => -143
	},
	{#State 307
		ACTIONS => {
			")" => 355
		}
	},
	{#State 308
		DEFAULT => -147
	},
	{#State 309
		ACTIONS => {
			")" => 356
		}
	},
	{#State 310
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			")" => 357,
			'OP23_LOGICAL_AND' => 221,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP17_LIST_RANGE' => 212,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 205,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP13_BITWISE_AND' => 206
		}
	},
	{#State 311
		ACTIONS => {
			'OP18_TERNARY' => 208,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -206,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 205,
			'OP13_BITWISE_AND' => 206,
			'OP17_LIST_RANGE' => 212,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -206
		}
	},
	{#State 312
		DEFAULT => -165
	},
	{#State 313
		DEFAULT => -205
	},
	{#State 314
		ACTIONS => {
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_MATH_ADD_SUB' => 219,
			")" => -164,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => 221,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => 205,
			'OP13_BITWISE_AND' => 206,
			'OP17_LIST_RANGE' => 212,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			";" => -164
		}
	},
	{#State 315
		DEFAULT => -166
	},
	{#State 316
		ACTIONS => {
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			")" => -146,
			'MY' => 156,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'ARGV' => 154,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 236,
			'TypeInner' => 158,
			'ListElement' => 237,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'OPTIONAL-43' => 358,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'ListElements' => 359
		}
	},
	{#State 317
		ACTIONS => {
			";" => 360
		}
	},
	{#State 318
		ACTIONS => {
			")" => -210,
			'OP21_LIST_COMMA' => 362,
			"]" => -210,
			";" => -210
		},
		GOTOS => {
			'PAREN-53' => 361
		}
	},
	{#State 319
		DEFAULT => -217
	},
	{#State 320
		DEFAULT => -139
	},
	{#State 321
		DEFAULT => -126
	},
	{#State 322
		ACTIONS => {
			'TYPE_INTEGER' => 363
		}
	},
	{#State 323
		ACTIONS => {
			'TYPE_INTEGER' => 364
		}
	},
	{#State 324
		ACTIONS => {
			'WORD_SCOPED' => 257,
			'WORD' => 260,
			'TYPE_INTEGER' => 256
		},
		GOTOS => {
			'Type' => 365
		}
	},
	{#State 325
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 366,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103
		}
	},
	{#State 326
		ACTIONS => {
			'WORD' => 260,
			'WORD_SCOPED' => 257,
			'TYPE_INTEGER' => 256
		},
		GOTOS => {
			'Type' => 367
		}
	},
	{#State 327
		DEFAULT => -150
	},
	{#State 328
		ACTIONS => {
			";" => 368
		}
	},
	{#State 329
		ACTIONS => {
			";" => 369,
			'OP02_ARRAY_THINARROW' => 370,
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 330
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Literal' => 109,
			'Expression' => 157,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'SubExpression' => 372
		}
	},
	{#State 331
		DEFAULT => -195
	},
	{#State 332
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD' => 374,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163
		},
		GOTOS => {
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'SubExpression' => 373,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157
		}
	},
	{#State 333
		ACTIONS => {
			"\$RETURN_TYPE" => 375
		}
	},
	{#State 334
		ACTIONS => {
			'WORD_UPPERCASE' => 376
		}
	},
	{#State 335
		DEFAULT => -56
	},
	{#State 336
		ACTIONS => {
			"}" => 377
		}
	},
	{#State 337
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 378
		}
	},
	{#State 338
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 339
		DEFAULT => -72
	},
	{#State 340
		ACTIONS => {
			'OP23_LOGICAL_AND' => 176,
			'OP01_PRINT' => 172,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP01_NAMED_VOID' => 184,
			'WORD' => 185,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP22_LOGICAL_NEG' => 188,
			'OP10_NAMED_UNARY' => 187,
			'OP01_OPEN' => 177,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 183,
			'OP11_COMPARE_LT_GT' => 164,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			'OP19_LOOP_CONTROL' => 168,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 166
		},
		GOTOS => {
			'OpStringOrWord' => 380
		}
	},
	{#State 341
		ACTIONS => {
			";" => 381
		}
	},
	{#State 342
		DEFAULT => -222
	},
	{#State 343
		ACTIONS => {
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 382,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103
		}
	},
	{#State 344
		ACTIONS => {
			'SELF' => 144,
			'OP11_COMPARE_LT_GT' => 164,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'OP19_LOOP_CONTROL' => 168,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			'ENV' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP23_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP01_PRINT' => 172,
			'OP10_NAMED_UNARY' => 187,
			'OP22_LOGICAL_NEG' => 188,
			'LITERAL_STRING' => 99,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP01_NAMED_VOID' => 184,
			'WORD' => 185,
			'OP01_CLOSE' => 183,
			'OP01_NAMED' => 178,
			'OP01_OPEN' => 177
		},
		GOTOS => {
			'HashDereference' => 173,
			'OpStringOrWord' => 186,
			'VariableSymbolOrSelf' => 145,
			'VarOrLitOrOpStrOrWord' => 179,
			'Variable' => 165,
			'Literal' => 170,
			'HashEntry' => 383
		}
	},
	{#State 345
		DEFAULT => -231
	},
	{#State 346
		DEFAULT => -229
	},
	{#State 347
		ACTIONS => {
			'OP21_LIST_COMMA' => 384
		}
	},
	{#State 348
		DEFAULT => -136
	},
	{#State 349
		DEFAULT => -135
	},
	{#State 350
		DEFAULT => -221
	},
	{#State 351
		ACTIONS => {
			")" => 385
		}
	},
	{#State 352
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP01_OPEN' => 98,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'LITERAL_NUMBER' => 111,
			'MY' => 156,
			"undef" => 113,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LPAREN' => 106,
			'ARGV' => 154,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'ListElements' => 386,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'SubExpression' => 236,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'ListElement' => 237,
			'TypeInner' => 158
		}
	},
	{#State 353
		DEFAULT => -236
	},
	{#State 354
		ACTIONS => {
			'LITERAL_STRING' => 99,
			'SELF' => 144,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Literal' => 289,
			'Variable' => 288,
			'VariableOrLiteral' => 387
		}
	},
	{#State 355
		DEFAULT => -152
	},
	{#State 356
		DEFAULT => -154
	},
	{#State 357
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 358
		ACTIONS => {
			")" => 390
		}
	},
	{#State 359
		DEFAULT => -145
	},
	{#State 360
		DEFAULT => -138
	},
	{#State 361
		DEFAULT => -208
	},
	{#State 362
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP01_OPEN' => 98,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_QW' => 159,
			'OP01_NAMED' => 163,
			'OP05_LOGICAL_NEG' => 121,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'MY' => 156,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154
		},
		GOTOS => {
			'TypeInner' => 158,
			'ListElement' => 391,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 236,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 365
		ACTIONS => {
			'VARIABLE_SYMBOL' => 394
		}
	},
	{#State 366
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => 205,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP23_LOGICAL_AND' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			")" => 395,
			'OP08_MATH_ADD_SUB' => 219
		}
	},
	{#State 367
		ACTIONS => {
			'VARIABLE_SYMBOL' => 396
		}
	},
	{#State 368
		DEFAULT => -204
	},
	{#State 369
		DEFAULT => -201
	},
	{#State 370
		ACTIONS => {
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106
		},
		GOTOS => {
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 397
		}
	},
	{#State 371
		ACTIONS => {
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY_SCOLON' => 399,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_SCOPED' => 32,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'OP01_NAMED_SCOLON' => 401,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			'FHREF_SYMBOL_IN' => 312,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'STDIN' => 315,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144
		},
		GOTOS => {
			'SubExpressionOrInput' => 398,
			'OpNamedScolonOrSubExpIn' => 400,
			'SubExpression' => 314,
			'Expression' => 157,
			'Literal' => 109,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145
		}
	},
	{#State 372
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			"]" => 402,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP18_TERNARY' => 208,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209
		}
	},
	{#State 373
		ACTIONS => {
			'OP23_LOGICAL_AND' => 221,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => 403,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP18_TERNARY' => 208,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210
		}
	},
	{#State 374
		ACTIONS => {
			'LPAREN' => -237,
			"}" => 404,
			'OP02_METHOD_THINARROW_NEW' => -237
		}
	},
	{#State 375
		ACTIONS => {
			"}" => 405
		}
	},
	{#State 376
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 377
		DEFAULT => -55
	},
	{#State 378
		ACTIONS => {
			'SUB' => 408,
			'LITERAL_NUMBER' => 411
		},
		GOTOS => {
			'SubroutineOrMethod' => 410,
			'Method' => 409,
			'Subroutine' => 407
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 412
		}
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 381
		DEFAULT => -140
	},
	{#State 382
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP21_LIST_COMMA' => -224,
			'OP15_LOGICAL_AND' => 205,
			'OP23_LOGICAL_AND' => 221,
			"}" => -224,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208
		}
	},
	{#State 383
		DEFAULT => -228
	},
	{#State 384
		ACTIONS => {
			'LITERAL_STRING' => 414
		}
	},
	{#State 385
		DEFAULT => -99
	},
	{#State 386
		ACTIONS => {
			")" => 415
		}
	},
	{#State 387
		DEFAULT => -125
	},
	{#State 388
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			"if" => 119,
			'OP05_LOGICAL_NEG' => 121,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'OP19_LOOP_CONTROL' => 114,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_PRINT' => 104,
			'WORD_SCOPED' => 32,
			"for" => -171,
			'LBRACE' => 95,
			'OP01_NAMED' => 94,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'LITERAL_STRING' => 99,
			'OP03_MATH_INC_DEC' => 101,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP01_NAMED_VOID_SCOLON' => 147,
			'WORD_UPPERCASE' => 137,
			'OP01_NAMED_SCOLON' => 136,
			'VARIABLE_SYMBOL' => 139,
			'MY' => 142,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			"foreach" => -171,
			'OP01_CLOSE' => 124,
			'OP10_NAMED_UNARY' => 127,
			"while" => -171,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP22_LOGICAL_NEG' => 126,
			'OP01_NAMED_VOID' => 129,
			'WORD' => 34,
			'LBRACKET' => 128
		},
		GOTOS => {
			'PLUS-51' => 417,
			'SubExpression' => 112,
			'ArrayDereference' => 140,
			'Expression' => 141,
			'Literal' => 109,
			'PAREN-45' => 107,
			'OperatorVoid' => 138,
			'VariableSymbolOrSelf' => 145,
			'Conditional' => 143,
			'Variable' => 120,
			'HashReference' => 115,
			'WordScoped' => 117,
			'Statement' => 118,
			'Operator' => 100,
			'VariableDeclaration' => 97,
			'LoopLabel' => 133,
			'OPTIONAL-46' => 134,
			'VariableModification' => 135,
			'ArrayReference' => 132,
			'Operation' => 416,
			'HashDereference' => 103
		}
	},
	{#State 389
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 418
		}
	},
	{#State 390
		DEFAULT => -153
	},
	{#State 391
		DEFAULT => -207
	},
	{#State 392
		ACTIONS => {
			'LPAREN' => 419
		}
	},
	{#State 393
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 420
		}
	},
	{#State 394
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421
		}
	},
	{#State 395
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 422
		}
	},
	{#State 396
		ACTIONS => {
			'LPAREN' => 423
		}
	},
	{#State 397
		ACTIONS => {
			'OP17_LIST_RANGE' => 212,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP15_LOGICAL_AND' => 205,
			'OP13_BITWISE_AND' => 206,
			"]" => 424,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			'OP23_LOGICAL_AND' => 221,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP18_TERNARY' => 208,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => 218
		}
	},
	{#State 398
		ACTIONS => {
			";" => 425
		}
	},
	{#State 399
		DEFAULT => -260
	},
	{#State 400
		DEFAULT => -202
	},
	{#State 401
		DEFAULT => -259
	},
	{#State 402
		DEFAULT => -198
	},
	{#State 403
		DEFAULT => -199
	},
	{#State 404
		DEFAULT => -200
	},
	{#State 405
		ACTIONS => {
			";" => 426
		}
	},
	{#State 406
		DEFAULT => -246
	},
	{#State 407
		DEFAULT => -93
	},
	{#State 408
		ACTIONS => {
			'WORD' => 427
		}
	},
	{#State 409
		DEFAULT => -94
	},
	{#State 410
		DEFAULT => -74
	},
	{#State 411
		ACTIONS => {
			";" => 428
		}
	},
	{#State 412
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 164,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			'OP19_LOOP_CONTROL' => 168,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP23_LOGICAL_AND' => 176,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 175,
			"}" => 430,
			'OP01_PRINT' => 172,
			'OP22_LOGICAL_NEG' => 188,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP10_NAMED_UNARY' => 187,
			'WORD' => 185,
			'OP01_NAMED_VOID' => 184,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 183,
			'OP01_OPEN' => 177
		},
		GOTOS => {
			'HashEntryProperties' => 429,
			'OpStringOrWord' => 431
		}
	},
	{#State 413
		DEFAULT => -243
	},
	{#State 414
		ACTIONS => {
			'OP21_LIST_COMMA' => 432
		}
	},
	{#State 415
		DEFAULT => -101
	},
	{#State 416
		DEFAULT => -193
	},
	{#State 417
		ACTIONS => {
			"while" => -171,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP01_NAMED_VOID' => 129,
			'OP01_CLOSE' => 124,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			"foreach" => -171,
			'VARIABLE_SYMBOL' => 139,
			'MY' => 142,
			'OP01_NAMED_SCOLON' => 136,
			'WORD_UPPERCASE' => 137,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_NAMED_VOID_SCOLON' => 147,
			'LITERAL_STRING' => 99,
			'OP03_MATH_INC_DEC' => 101,
			'OP01_NAMED' => 94,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'OP01_OPEN' => 98,
			'WORD_SCOPED' => 32,
			"for" => -171,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_PRINT' => 104,
			"}" => 434,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"undef" => 113,
			'OP19_LOOP_CONTROL' => 114,
			"\@{" => 105,
			'LPAREN' => 106,
			"if" => 119,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Conditional' => 143,
			'Variable' => 120,
			'HashReference' => 115,
			'Statement' => 118,
			'WordScoped' => 117,
			'SubExpression' => 112,
			'ArrayDereference' => 140,
			'PAREN-45' => 107,
			'Expression' => 141,
			'Literal' => 109,
			'OperatorVoid' => 138,
			'LoopLabel' => 133,
			'VariableModification' => 135,
			'OPTIONAL-46' => 134,
			'ArrayReference' => 132,
			'Operation' => 433,
			'HashDereference' => 103,
			'Operator' => 100,
			'VariableDeclaration' => 97
		}
	},
	{#State 418
		ACTIONS => {
			"\@{" => -182,
			'LPAREN' => -182,
			"%{" => -182,
			'OP19_LOOP_CONTROL' => -182,
			"undef" => -182,
			'LITERAL_NUMBER' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			"if" => -182,
			'OP05_LOGICAL_NEG' => -182,
			'LBRACE' => -182,
			'' => -182,
			'OP01_NAMED' => -182,
			'OP01_OPEN' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			'LITERAL_STRING' => -182,
			'OP03_MATH_INC_DEC' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			"}" => -182,
			'OP01_PRINT' => -182,
			'WORD_SCOPED' => -182,
			"for" => -182,
			"elsif" => 435,
			'WORD_UPPERCASE' => -182,
			'OP01_NAMED_SCOLON' => -182,
			"else" => 438,
			'VARIABLE_SYMBOL' => -182,
			'MY' => -182,
			'CONSTANT_CALL_SCOPED' => -182,
			'SELF' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'OP01_CLOSE' => -182,
			'OP10_NAMED_UNARY' => -182,
			'OP22_LOGICAL_NEG' => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			"while" => -182,
			'OP01_NAMED_VOID' => -182,
			'WORD' => -182,
			'LBRACKET' => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			"foreach" => -182
		},
		GOTOS => {
			'PAREN-49' => 439,
			'OPTIONAL-50' => 436,
			'PAREN-47' => 437
		}
	},
	{#State 419
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34
		},
		GOTOS => {
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'SubExpression' => 440
		}
	},
	{#State 420
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY_SCOLON' => 444,
			'OP01_OPEN' => 98,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP01_NAMED_SCOLON' => 441,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103,
			'OpNamedScolonOrSubExp' => 443,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 442
		}
	},
	{#State 421
		ACTIONS => {
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'FHREF_SYMBOL_IN' => 312,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'STDIN' => 315,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_OPEN' => 98,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'HashDereference' => 103,
			'WordScoped' => 117,
			'HashReference' => 115,
			'SubExpression' => 314,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpressionOrInput' => 445
		}
	},
	{#State 422
		DEFAULT => -190
	},
	{#State 423
		ACTIONS => {
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'MY' => 156,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'ARGV' => 154,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_QW' => 159,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98
		},
		GOTOS => {
			'Variable' => 162,
			'ArrayReference' => 132,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ListElements' => 446,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 236,
			'ListElement' => 237,
			'TypeInner' => 158
		}
	},
	{#State 424
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 447
		}
	},
	{#State 425
		DEFAULT => -261
	},
	{#State 426
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			'SELF' => -58,
			'MY' => -58,
			'VARIABLE_SYMBOL' => -58,
			'WORD_UPPERCASE' => -58,
			'OP01_NAMED_SCOLON' => -58,
			"foreach" => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'WORD' => -58,
			'OP01_NAMED_VOID' => -58,
			'LBRACKET' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP22_LOGICAL_NEG' => -58,
			"while" => -58,
			'OP01_CLOSE' => -58,
			'OP05_LOGICAL_NEG' => -58,
			"if" => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP19_LOOP_CONTROL' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			"undef" => -58,
			'LITERAL_NUMBER' => -58,
			"%{" => -58,
			'LPAREN' => -58,
			'LPAREN_MY' => 448,
			"\@{" => -58,
			"for" => -58,
			'WORD_SCOPED' => -58,
			"}" => -58,
			'OP01_PRINT' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'LITERAL_STRING' => -58,
			'OP01_OPEN' => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'LBRACE' => -58,
			'OP01_NAMED' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 450,
			'OPTIONAL-24' => 449
		}
	},
	{#State 427
		ACTIONS => {
			'LBRACE' => 451
		}
	},
	{#State 428
		DEFAULT => -76
	},
	{#State 429
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 452
		}
	},
	{#State 430
		ACTIONS => {
			";" => 453
		}
	},
	{#State 431
		ACTIONS => {
			'OP20_HASH_FATARROW' => 454
		}
	},
	{#State 432
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'LPAREN' => 106,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127
		},
		GOTOS => {
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 455
		}
	},
	{#State 433
		DEFAULT => -192
	},
	{#State 434
		DEFAULT => -194
	},
	{#State 435
		ACTIONS => {
			'LPAREN' => 456
		}
	},
	{#State 436
		DEFAULT => -183
	},
	{#State 437
		DEFAULT => -178
	},
	{#State 438
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 457
		}
	},
	{#State 439
		DEFAULT => -181
	},
	{#State 440
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 458
		}
	},
	{#State 441
		DEFAULT => -256
	},
	{#State 442
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP18_TERNARY' => 208,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP23_LOGICAL_AND' => 221,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			";" => 459,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212
		}
	},
	{#State 443
		ACTIONS => {
			'VARIABLE_SYMBOL' => 460
		}
	},
	{#State 444
		DEFAULT => -257
	},
	{#State 445
		ACTIONS => {
			")" => 461
		}
	},
	{#State 446
		ACTIONS => {
			")" => 462
		}
	},
	{#State 447
		ACTIONS => {
			"undef" => 463
		}
	},
	{#State 448
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD' => 260,
			'WORD_SCOPED' => 257
		},
		GOTOS => {
			'Type' => 464
		}
	},
	{#State 449
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 465
		}
	},
	{#State 450
		DEFAULT => -57
	},
	{#State 451
		ACTIONS => {
			'LBRACE' => 466
		}
	},
	{#State 452
		ACTIONS => {
			'OP21_LIST_COMMA' => 468,
			"}" => 467
		},
		GOTOS => {
			'PAREN-33' => 469
		}
	},
	{#State 453
		DEFAULT => -83
	},
	{#State 454
		ACTIONS => {
			'MY' => 471
		},
		GOTOS => {
			'TypeInnerProperties' => 470
		}
	},
	{#State 455
		ACTIONS => {
			")" => -102,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			"}" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP17_LIST_RANGE' => 212,
			";" => -102,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			"]" => -102,
			'OP13_BITWISE_AND' => 206
		}
	},
	{#State 456
		ACTIONS => {
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32
		},
		GOTOS => {
			'SubExpression' => 472,
			'ArrayDereference' => 140,
			'Operator' => 100,
			'Literal' => 109,
			'Expression' => 157,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117
		}
	},
	{#State 457
		DEFAULT => -180
	},
	{#State 458
		ACTIONS => {
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 106,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP10_NAMED_UNARY' => 127,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103,
			'Literal' => 109,
			'Expression' => 157,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 473
		}
	},
	{#State 459
		DEFAULT => -258
	},
	{#State 460
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 474
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 462
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 476
		}
	},
	{#State 463
		ACTIONS => {
			";" => 477
		}
	},
	{#State 464
		ACTIONS => {
			'VARIABLE_SYMBOL' => 478
		}
	},
	{#State 465
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			"if" => 119,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP19_LOOP_CONTROL' => 114,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			"%{" => 108,
			'LPAREN' => 106,
			"\@{" => 105,
			"for" => -171,
			'WORD_SCOPED' => 32,
			"}" => 480,
			'OP01_PRINT' => 104,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 101,
			'LITERAL_STRING' => 99,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'LBRACE' => 95,
			'OP01_NAMED' => 94,
			'OP01_NAMED_VOID_SCOLON' => 147,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'MY' => 142,
			'VARIABLE_SYMBOL' => 139,
			'WORD_UPPERCASE' => 137,
			'OP01_NAMED_SCOLON' => 136,
			"foreach" => -171,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD' => 34,
			'OP01_NAMED_VOID' => 129,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 127,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"while" => -171,
			'OP22_LOGICAL_NEG' => 126,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'WordScoped' => 117,
			'Statement' => 118,
			'HashReference' => 115,
			'Variable' => 120,
			'VariableSymbolOrSelf' => 145,
			'Conditional' => 143,
			'OperatorVoid' => 138,
			'SubExpression' => 112,
			'Literal' => 109,
			'Expression' => 141,
			'PAREN-45' => 107,
			'ArrayDereference' => 140,
			'Operation' => 479,
			'HashDereference' => 103,
			'VariableModification' => 135,
			'OPTIONAL-46' => 134,
			'LoopLabel' => 133,
			'ArrayReference' => 132,
			'VariableDeclaration' => 97,
			'Operator' => 100
		}
	},
	{#State 466
		ACTIONS => {
			'MY' => 481
		}
	},
	{#State 467
		ACTIONS => {
			";" => 482
		}
	},
	{#State 468
		ACTIONS => {
			'OP23_LOGICAL_AND' => 176,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 175,
			'OP01_PRINT' => 172,
			'OP22_LOGICAL_NEG' => 188,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP10_NAMED_UNARY' => 187,
			'OP01_NAMED_VOID' => 184,
			'WORD' => 185,
			'OP01_NAMED' => 178,
			'OP01_CLOSE' => 183,
			'OP01_OPEN' => 177,
			'OP11_COMPARE_LT_GT' => 164,
			'OP19_LOOP_CONTROL_SCOLON' => 169,
			'OP19_LOOP_CONTROL' => 168,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 166
		},
		GOTOS => {
			'HashEntryProperties' => 483,
			'OpStringOrWord' => 431
		}
	},
	{#State 469
		DEFAULT => -80
	},
	{#State 470
		DEFAULT => -227
	},
	{#State 471
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD_SCOPED' => 257,
			'WORD' => 260
		},
		GOTOS => {
			'Type' => 484
		}
	},
	{#State 472
		ACTIONS => {
			'OP23_LOGICAL_AND' => 221,
			")" => 485,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP18_TERNARY' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211
		}
	},
	{#State 473
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			")" => 486,
			'OP23_LOGICAL_AND' => -124,
			'OP18_TERNARY' => -124,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP08_STRING_CAT' => 217,
			'OP04_MATH_POW' => 216,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP13_BITWISE_AND' => 206
		}
	},
	{#State 474
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LPAREN' => 106,
			'OP01_NAMED_SCOLON' => 441,
			"\@{" => 105,
			'WORD_UPPERCASE' => 155,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP10_NAMED_UNARY_SCOLON' => 444,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 163,
			'LBRACE' => 95,
			'OP01_CLOSE' => 124
		},
		GOTOS => {
			'SubExpression' => 442,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'HashDereference' => 103,
			'OpNamedScolonOrSubExp' => 487,
			'HashReference' => 115,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'ArrayReference' => 132,
			'Variable' => 162
		}
	},
	{#State 475
		DEFAULT => -191
	},
	{#State 476
		DEFAULT => -189
	},
	{#State 477
		DEFAULT => -203
	},
	{#State 478
		DEFAULT => -64,
		GOTOS => {
			'STAR-27' => 488
		}
	},
	{#State 479
		DEFAULT => -59
	},
	{#State 480
		DEFAULT => -61
	},
	{#State 481
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD_SCOPED' => 257,
			'TYPE_METHOD' => 489,
			'WORD' => 260
		},
		GOTOS => {
			'Type' => 333
		}
	},
	{#State 482
		DEFAULT => -82
	},
	{#State 483
		DEFAULT => -79
	},
	{#State 484
		ACTIONS => {
			"\$TYPED_" => 490
		}
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 491
		}
	},
	{#State 486
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 492
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 95,
			'OP01_CLOSE' => 124,
			'OP01_NAMED' => 163,
			'OP01_OPEN' => 98,
			'OP10_NAMED_UNARY' => 127,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 126,
			'WORD' => 34,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 139,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'CONSTANT_CALL_SCOPED' => 146,
			'SELF' => 144,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'SubExpression' => 495,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Expression' => 157,
			'Literal' => 109,
			'VariableModification' => 493,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 120,
			'ArrayReference' => 132,
			'SubExpressionOrVarMod' => 494,
			'HashDereference' => 103,
			'HashReference' => 115,
			'WordScoped' => 117
		}
	},
	{#State 488
		ACTIONS => {
			")" => 496,
			'OP21_LIST_COMMA' => 498
		},
		GOTOS => {
			'PAREN-26' => 497
		}
	},
	{#State 489
		ACTIONS => {
			"\$RETURN_TYPE" => 499
		}
	},
	{#State 490
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP01_PRINT' => 172,
			'OP23_LOGICAL_AND' => 176,
			'OP01_CLOSE' => 183,
			'OP01_NAMED' => 178,
			'OP01_OPEN' => 177,
			'OP10_NAMED_UNARY' => 187,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP22_LOGICAL_NEG' => 188,
			'WORD' => 185,
			'OP01_NAMED_VOID' => 184,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP19_LOOP_CONTROL' => 168,
			'OP19_LOOP_CONTROL_SCOLON' => 169
		},
		GOTOS => {
			'OpStringOrWord' => 500
		}
	},
	{#State 491
		DEFAULT => -177
	},
	{#State 492
		DEFAULT => -187
	},
	{#State 493
		DEFAULT => -168
	},
	{#State 494
		ACTIONS => {
			")" => 501
		}
	},
	{#State 495
		ACTIONS => {
			'OP23_LOGICAL_AND' => 221,
			")" => -167,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP18_TERNARY' => 208,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP06_REGEX_BIND' => 209,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207,
			'OP17_LIST_RANGE' => 212,
			'OP13_BITWISE_AND' => 206,
			'OP15_LOGICAL_AND' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211
		}
	},
	{#State 496
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 502
		}
	},
	{#State 497
		DEFAULT => -63
	},
	{#State 498
		ACTIONS => {
			'MY' => 503
		}
	},
	{#State 499
		ACTIONS => {
			"}" => 504
		}
	},
	{#State 500
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 505,
			'OP02_ARRAY_THINARROW' => 506
		}
	},
	{#State 501
		ACTIONS => {
			'LBRACE' => 388
		},
		GOTOS => {
			'CodeBlock' => 507
		}
	},
	{#State 502
		ACTIONS => {
			"\@ARG;" => 508
		}
	},
	{#State 503
		ACTIONS => {
			'WORD_SCOPED' => 257,
			'WORD' => 260,
			'TYPE_INTEGER' => 256
		},
		GOTOS => {
			'Type' => 509
		}
	},
	{#State 504
		ACTIONS => {
			";" => 510
		}
	},
	{#State 505
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 101,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Expression' => 157,
			'Literal' => 109,
			'Operator' => 100,
			'ArrayDereference' => 140,
			'SubExpression' => 511,
			'ArrayReference' => 132,
			'Variable' => 162,
			'VariableSymbolOrSelf' => 145,
			'WordScoped' => 117,
			'HashReference' => 115,
			'HashDereference' => 103
		}
	},
	{#State 506
		ACTIONS => {
			'VARIABLE_SYMBOL' => 139,
			"%{" => 108,
			'LITERAL_NUMBER' => 111,
			"undef" => 113,
			'WORD_UPPERCASE' => 155,
			"\@{" => 105,
			'LPAREN' => 106,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 126,
			'LITERAL_STRING' => 99,
			'OP10_NAMED_UNARY' => 127,
			'OP03_MATH_INC_DEC' => 101,
			'LBRACKET' => 128,
			'WORD' => 34,
			'OP01_NAMED' => 163,
			'OP01_CLOSE' => 124,
			'LBRACE' => 95,
			'OP01_OPEN' => 98,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'WORD_SCOPED' => 32,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Operator' => 100,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 157,
			'SubExpression' => 512,
			'VariableSymbolOrSelf' => 145,
			'Variable' => 162,
			'ArrayReference' => 132,
			'HashReference' => 115,
			'WordScoped' => 117,
			'HashDereference' => 103
		}
	},
	{#State 507
		DEFAULT => -188
	},
	{#State 508
		DEFAULT => -65
	},
	{#State 509
		ACTIONS => {
			'VARIABLE_SYMBOL' => 513
		}
	},
	{#State 510
		ACTIONS => {
			'VARIABLE_SYMBOL' => -85,
			'MY' => -85,
			'WORD_UPPERCASE' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'SELF' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			"while" => -85,
			'WORD' => -85,
			'OP01_NAMED_VOID' => -85,
			'LBRACKET' => -85,
			'OP01_CLOSE' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			"foreach" => -85,
			"%{" => -85,
			'OP19_LOOP_CONTROL' => -85,
			"undef" => -85,
			'LITERAL_NUMBER' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			"\@{" => -85,
			'LPAREN_MY' => 514,
			'LPAREN' => -85,
			"if" => -85,
			'OP05_LOGICAL_NEG' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'LITERAL_STRING' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'LBRACE' => -85,
			'OP01_NAMED' => -85,
			'OP01_OPEN' => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'WORD_SCOPED' => -85,
			"for" => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'OP01_PRINT' => -85,
			"}" => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 516,
			'MethodArguments' => 515
		}
	},
	{#State 511
		ACTIONS => {
			'OP18_TERNARY' => 208,
			'OP06_REGEX_BIND' => 209,
			'OP16_LOGICAL_OR' => 214,
			'OP14_BITWISE_OR_XOR' => 215,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP24_LOGICAL_OR_XOR' => 218,
			"}" => -244,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP08_MATH_ADD_SUB' => 219,
			'OP23_LOGICAL_AND' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP07_STRING_REPEAT' => 211,
			'OP15_LOGICAL_AND' => 205,
			'OP21_LIST_COMMA' => -244,
			'OP13_BITWISE_AND' => 206,
			'OP17_LIST_RANGE' => 212,
			'OP11_COMPARE_LT_GT' => 213,
			'OP09_BITWISE_SHIFT' => 207
		}
	},
	{#State 512
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 215,
			'OP16_LOGICAL_OR' => 214,
			'OP06_REGEX_BIND' => 209,
			'OP18_TERNARY' => 208,
			'OP24_LOGICAL_OR_XOR' => 218,
			'OP04_MATH_POW' => 216,
			'OP08_STRING_CAT' => 217,
			'OP08_MATH_ADD_SUB' => 219,
			'OP12_COMPARE_EQ_NE' => 220,
			'OP23_LOGICAL_AND' => 221,
			'OP15_LOGICAL_AND' => 205,
			'OP07_STRING_REPEAT' => 211,
			'OP07_MATH_MULT_DIV_MOD' => 210,
			'OP13_BITWISE_AND' => 206,
			"]" => 517,
			'OP17_LIST_RANGE' => 212,
			'OP09_BITWISE_SHIFT' => 207,
			'OP11_COMPARE_LT_GT' => 213
		}
	},
	{#State 513
		DEFAULT => -62
	},
	{#State 514
		ACTIONS => {
			'TYPE_INTEGER' => 256,
			'WORD_SCOPED' => 257,
			'WORD' => 260
		},
		GOTOS => {
			'Type' => 518
		}
	},
	{#State 515
		DEFAULT => -84
	},
	{#State 516
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 519
		}
	},
	{#State 517
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 520
		}
	},
	{#State 518
		ACTIONS => {
			'SELF' => 521
		}
	},
	{#State 519
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 121,
			"if" => 119,
			'LPAREN' => 106,
			"\@{" => 105,
			"undef" => 113,
			'LITERAL_NUMBER' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 114,
			"%{" => 108,
			"}" => 522,
			'OP01_PRINT' => 104,
			'OP05_MATH_NEG_LPAREN' => 102,
			"for" => -171,
			'WORD_SCOPED' => 32,
			'OP10_NAMED_UNARY_SCOLON' => 96,
			'OP01_OPEN' => 98,
			'OP01_NAMED' => 94,
			'LBRACE' => 95,
			'OP03_MATH_INC_DEC' => 101,
			'LITERAL_STRING' => 99,
			'OP01_NAMED_VOID_SCOLON' => 147,
			'SELF' => 144,
			'CONSTANT_CALL_SCOPED' => 146,
			'OP01_NAMED_SCOLON' => 136,
			'WORD_UPPERCASE' => 137,
			'MY' => 142,
			'VARIABLE_SYMBOL' => 139,
			"foreach" => -171,
			'OP22_LOGICAL_NEG_LPAREN' => 131,
			'OP01_CLOSE' => 124,
			'LBRACKET' => 128,
			'OP01_NAMED_VOID' => 129,
			'WORD' => 34,
			'OP01_NAMED_VOID_LPAREN' => 125,
			"while" => -171,
			'OP22_LOGICAL_NEG' => 126,
			'OP10_NAMED_UNARY' => 127
		},
		GOTOS => {
			'HashReference' => 115,
			'Statement' => 118,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 145,
			'Conditional' => 143,
			'Variable' => 120,
			'OperatorVoid' => 138,
			'ArrayDereference' => 140,
			'Literal' => 109,
			'Expression' => 141,
			'PAREN-45' => 107,
			'SubExpression' => 112,
			'HashDereference' => 103,
			'Operation' => 523,
			'ArrayReference' => 132,
			'LoopLabel' => 133,
			'OPTIONAL-46' => 134,
			'VariableModification' => 135,
			'VariableDeclaration' => 97,
			'Operator' => 100
		}
	},
	{#State 520
		ACTIONS => {
			"undef" => 524
		}
	},
	{#State 521
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 525
		}
	},
	{#State 522
		DEFAULT => -88
	},
	{#State 523
		DEFAULT => -86
	},
	{#State 524
		DEFAULT => -245
	},
	{#State 525
		ACTIONS => {
			")" => 527,
			'OP21_LIST_COMMA' => 528
		},
		GOTOS => {
			'PAREN-37' => 526
		}
	},
	{#State 526
		DEFAULT => -90
	},
	{#State 527
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 529
		}
	},
	{#State 528
		ACTIONS => {
			'MY' => 530
		}
	},
	{#State 529
		ACTIONS => {
			"\@ARG;" => 531
		}
	},
	{#State 530
		ACTIONS => {
			'WORD_SCOPED' => 257,
			'WORD' => 260,
			'TYPE_INTEGER' => 256
		},
		GOTOS => {
			'Type' => 532
		}
	},
	{#State 531
		DEFAULT => -92
	},
	{#State 532
		ACTIONS => {
			'VARIABLE_SYMBOL' => 533
		}
	},
	{#State 533
		DEFAULT => -89
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7479 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7593 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7663 lib/RPerl/Grammar.pm
	],
	[#Rule Package_36
		 'Package', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7674 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule Header_39
		 'Header', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7713 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_42
		 'Critic', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7724 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 3,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule Exports_49
		 'Exports', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7805 lib/RPerl/Grammar.pm
	],
	[#Rule Include_54
		 'Include', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule Include_55
		 'Include', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7827 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_56
		 'Constant', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7845 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7866 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_61
		 'Subroutine', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7877 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 4,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7898 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_65
		 'SubroutineArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7979 lib/RPerl/Grammar.pm
	],
	[#Rule Class_76
		 'Class', 13,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 7990 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_77
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8001 lib/RPerl/Grammar.pm
	],
	[#Rule UseParent_78
		 'UseParent', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8012 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8033 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_82
		 'Properties', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8044 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_83
		 'Properties', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8055 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8069 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule Method_88
		 'Method', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8094 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 4,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8115 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_92
		 'MethodArguments', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8126 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_93
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8137 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineOrMethod_94
		 'SubroutineOrMethod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8148 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_95
		 'Operation', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8159 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_96
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8170 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_97
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_98
		 'Operation', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8192 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8203 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8214 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8225 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8236 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8247 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8258 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8269 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8280 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8291 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8302 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8313 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8346 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_114
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8368 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_115
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8379 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_116
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8390 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_117
		 'Operator', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8401 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_118
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8412 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_119
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8423 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_120
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8434 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_121
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8445 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_122
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8456 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_123
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8467 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_124
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8478 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_125
		 'Operator', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8489 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_126
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8500 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_127
		 'Operator', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8511 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_128
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8522 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_129
		 'Operator', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8533 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 1,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8547 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 231 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8554 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8561 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8568 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_135
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8579 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_136
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8590 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_137
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8601 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_138
		 'OperatorVoid', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8612 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_139
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8623 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_140
		 'OperatorVoid', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8634 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_141
		 'OperatorVoid', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8645 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_142
		 'OperatorVoid', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8663 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 234 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8670 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8677 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8684 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8698 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_149
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8709 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_150
		 'Expression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8720 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_151
		 'Expression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8731 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_152
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8742 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_153
		 'Expression', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8753 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_154
		 'Expression', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8764 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_155
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8775 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_156
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8786 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_157
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8797 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_158
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8808 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_159
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8819 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_160
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8830 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_161
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8841 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_162
		 'SubExpression', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8852 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_163
		 'SubExpression', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8863 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_164
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8874 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_165
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8885 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_166
		 'SubExpressionOrInput', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8896 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_167
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8907 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_168
		 'SubExpressionOrVarMod', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8918 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8932 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 239 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8939 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_172
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8950 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_173
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8961 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_174
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8972 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_175
		 'Statement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8983 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_176
		 'Statement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 8994 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 5,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9015 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9022 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9029 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9036 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_183
		 'Conditional', 7,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9047 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_184
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9058 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_185
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9069 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_186
		 'Loop', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9080 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_187
		 'LoopFor', 10,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9091 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_188
		 'LoopFor', 12,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9102 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_189
		 'LoopForEach', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9113 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_190
		 'LoopWhile', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9124 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_191
		 'LoopWhile', 8,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9135 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 2,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 246 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9149 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_194
		 'CodeBlock', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9160 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9167 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 250 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9174 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_197
		 'Variable', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9185 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_198
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9196 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_199
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9207 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_200
		 'VariableRetrieval', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9218 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_201
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9229 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_202
		 'VariableDeclaration', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9240 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_203
		 'VariableDeclaration', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9251 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_204
		 'VariableDeclaration', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9262 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_205
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9273 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_206
		 'VariableModification', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9284 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-53', 2,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9291 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 255 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9305 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_210
		 'ListElements', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9316 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_211
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9327 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_212
		 'ListElement', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9338 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_213
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9349 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_214
		 'ListElement', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9360 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 1,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9367 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 257 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9374 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_217
		 'ArrayReference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9385 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 1,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9399 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_220
		 'ArrayDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9410 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_221
		 'ArrayDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9421 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 1,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9435 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_224
		 'HashEntry', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9446 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_225
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9457 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_226
		 'HashEntry', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9468 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_227
		 'HashEntryProperties', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9479 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-58', 2,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 261 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9500 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_231
		 'HashReference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9511 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_232
		 'HashReference', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9522 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 1,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9529 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9536 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_235
		 'HashDereference', 3,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9547 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_236
		 'HashDereference', 4,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9558 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_237
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9569 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_238
		 'WordScoped', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9580 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_239
		 'LoopLabel', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9591 lib/RPerl/Grammar.pm
	],
	[#Rule Type_240
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9602 lib/RPerl/Grammar.pm
	],
	[#Rule Type_241
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9613 lib/RPerl/Grammar.pm
	],
	[#Rule Type_242
		 'Type', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9624 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_243
		 'TypeInner', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9635 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_244
		 'TypeInnerProperties', 6,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9646 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_245
		 'TypeInnerProperties', 9,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9657 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_246
		 'TypeInnerConstant', 5,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9668 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_247
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9679 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_248
		 'VariableOrLiteral', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9690 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_249
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9701 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_250
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9712 lib/RPerl/Grammar.pm
	],
	[#Rule VarOrLitOrOpStrOrWord_251
		 'VarOrLitOrOpStrOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9723 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_252
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9734 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_253
		 'VariableSymbolOrSelf', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9745 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_254
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9756 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_255
		 'Literal', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9767 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_256
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9778 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_257
		 'OpNamedScolonOrSubExp', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9789 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExp_258
		 'OpNamedScolonOrSubExp', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9800 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_259
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9811 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_260
		 'OpNamedScolonOrSubExpIn', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9822 lib/RPerl/Grammar.pm
	],
	[#Rule OpNamedScolonOrSubExpIn_261
		 'OpNamedScolonOrSubExpIn', 2,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9833 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_262
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9844 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_263
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9855 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_264
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9866 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_265
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9877 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_266
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9888 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_267
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9899 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_268
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9910 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_269
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9921 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_270
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9932 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_271
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9943 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_272
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9954 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_273
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9965 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_274
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9976 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_275
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9987 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_276
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 9998 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_277
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10009 lib/RPerl/Grammar.pm
	],
	[#Rule OpStringOrWord_278
		 'OpStringOrWord', 1,
sub {
#line 24 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ], line_number => ($self->{TOKENLINE} + 1) }, $name;
}
#line 10020 lib/RPerl/Grammar.pm
	]
],
#line 10023 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_183', 
         'Loop_184', 
         'Loop_185', 
         'Loop_186', 
         'LoopFor_187', 
         'LoopFor_188', 
         'LoopForEach_189', 
         'LoopWhile_190', 
         'LoopWhile_191', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_194', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_197', 
         'VariableRetrieval_198', 
         'VariableRetrieval_199', 
         'VariableRetrieval_200', 
         'VariableDeclaration_201', 
         'VariableDeclaration_202', 
         'VariableDeclaration_203', 
         'VariableDeclaration_204', 
         'VariableModification_205', 
         'VariableModification_206', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_210', 
         'ListElement_211', 
         'ListElement_212', 
         'ListElement_213', 
         'ListElement_214', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_217', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_220', 
         'ArrayDereference_221', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_224', 
         'HashEntry_225', 
         'HashEntry_226', 
         'HashEntryProperties_227', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_231', 
         'HashReference_232', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_235', 
         'HashDereference_236', 
         'WordScoped_237', 
         'WordScoped_238', 
         'LoopLabel_239', 
         'Type_240', 
         'Type_241', 
         'Type_242', 
         'TypeInner_243', 
         'TypeInnerProperties_244', 
         'TypeInnerProperties_245', 
         'TypeInnerConstant_246', 
         'VariableOrLiteral_247', 
         'VariableOrLiteral_248', 
         'VarOrLitOrOpStrOrWord_249', 
         'VarOrLitOrOpStrOrWord_250', 
         'VarOrLitOrOpStrOrWord_251', 
         'VariableSymbolOrSelf_252', 
         'VariableSymbolOrSelf_253', 
         'Literal_254', 
         'Literal_255', 
         'OpNamedScolonOrSubExp_256', 
         'OpNamedScolonOrSubExp_257', 
         'OpNamedScolonOrSubExp_258', 
         'OpNamedScolonOrSubExpIn_259', 
         'OpNamedScolonOrSubExpIn_260', 
         'OpNamedScolonOrSubExpIn_261', 
         'OpStringOrWord_262', 
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
         'OpStringOrWord_278', );
  $self;
}

#line 283 "lib/RPerl/Grammar.eyp"


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
Operator_100 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_102 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
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
Operator_117 => 'RPerl::Operation::Expression::Operator::NamedUnary',                       # Operator -> OP10_NAMED_UNARY
Operator_118 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',     # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_119 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',           # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_120 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                     # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_121 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                   # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_122 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_123 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_124 => 'RPerl::Operation::Expression::Operator::List::Range',                      # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_125 => 'RPerl::Operation::Expression::Operator::Ternary',                          # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_126 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG_LPAREN SubExpression ')'
Operator_127 => 'RPerl::Operation::Expression::Operator::Logical::Negation',                # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_128 => 'RPerl::Operation::Expression::Operator::Logical::And',                     # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_129 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',                   # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_135 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_136 => 'RPerl::Operation::Statement::OperatorVoid::Print',                     # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_137 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_138 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_139 => 'RPerl::Operation::Statement::OperatorVoid::Named',                     # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_140 => 'RPerl::Operation::Expression::Operator::Named',                        # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_141 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_142 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',               # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
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
Conditional_183 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-46 OPTIONAL-48
Loop_184 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_185 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_186 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_187 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_188 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExp VARIABLE_SYMBOL OP11_COMPARE_LT_GT OpNamedScolonOrSubExp SubExpressionOrVarMod ')' CodeBlock
LoopForEach_189 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_190 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_191 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_194 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-49 '}'
Variable_197 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-50
VariableRetrieval_198 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_199 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_200 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_201 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_202 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
VariableDeclaration_203 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_204 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_205 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_206 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_210 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-52
ListElement_211 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_212 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_213 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_214 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_217 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-53 ']'
ArrayDereference_220 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_221 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-54 ArrayReference '}'
HashEntry_224 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-55 SubExpression
HashEntry_225 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntry_226 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
HashEntryProperties_227 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> OpStringOrWord OP20_HASH_FATARROW TypeInnerProperties
HashReference_231 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-57 '}'
HashReference_232 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_235 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_236 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-58 HashReference '}'
WordScoped_237 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_238 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_239 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_240 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_241 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_242 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_243 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
TypeInnerProperties_244 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_245 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_246 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_247 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_248 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VarOrLitOrOpStrOrWord_249 => 'RPerl::Operation::Expression::SubExpression::Variable',           # VarOrLitOrOpStrOrWord -> Variable
VarOrLitOrOpStrOrWord_250 => 'RPerl::Operation::Expression::SubExpression::Literal',            # VarOrLitOrOpStrOrWord -> Literal
VarOrLitOrOpStrOrWord_251 => 'RPerl::NonGenerator',                                             # VarOrLitOrOpStrOrWord -> OpStringOrWord
VariableSymbolOrSelf_252 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_253 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_254 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_255 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
OpNamedScolonOrSubExp_256 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExp_257 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExp_258 => 'RPerl::NonGenerator',                                             # OpNamedScolonOrSubExp -> SubExpression ';'
OpNamedScolonOrSubExpIn_259 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
OpNamedScolonOrSubExpIn_260 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
OpNamedScolonOrSubExpIn_261 => 'RPerl::NonGenerator',                                           # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
OpStringOrWord_262 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP24_LOGICAL_OR_XOR
OpStringOrWord_263 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP23_LOGICAL_AND
OpStringOrWord_264 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP22_LOGICAL_NEG
OpStringOrWord_265 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL_SCOLON
OpStringOrWord_266 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP19_LOOP_CONTROL
OpStringOrWord_267 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP12_COMPARE_EQ_NE
OpStringOrWord_268 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP11_COMPARE_LT_GT
OpStringOrWord_269 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP10_NAMED_UNARY
OpStringOrWord_270 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP08_MATH_ADD_SUB
OpStringOrWord_271 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_MATH_MULT_DIV_MOD
OpStringOrWord_272 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP07_STRING_REPEAT
OpStringOrWord_273 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED
OpStringOrWord_274 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_CLOSE
OpStringOrWord_275 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_OPEN
OpStringOrWord_276 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_NAMED_VOID
OpStringOrWord_277 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> OP01_PRINT
OpStringOrWord_278 => 'RPerl::NonGenerator',                                                    # OpStringOrWord -> WORD
};

    1;
}


=for None

=cut


#line 10517 lib/RPerl/Grammar.pm



1;
