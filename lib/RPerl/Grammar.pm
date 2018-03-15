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
    our $VERSION = 0.013_000;

    use Carp;
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*|\s)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ parent\ \-norequire\,\ qw\(|our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|\$RETURN_TYPE|use\ constant|use\ strict\;|\$TYPED_|foreach|package|\@ARG\;|elsif|while|undef|else|INIT|for|if|\@\{|\%\{|\)|\]|\;|\})}gc and return ($1, $1);

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
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
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
			'SHEBANG' => 1,
			'USE_RPERL' => -20,
			"## no critic qw(" => 6,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 5,
			'Program' => 2,
			'Critic' => 4,
			'ModuleHeader' => 3,
			'CompileUnit' => 9,
			'PLUS-2' => 8,
			'PAREN-1' => 7
		}
	},
	{#State 1
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 10,
			'OPTIONAL-3' => 11
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"use parent -norequire, qw(" => 13,
			"INIT" => -27,
			'SUB' => -27,
			"use parent qw(" => 16,
			"## no critic qw(" => -27,
			'USE' => -27,
			"use constant" => -27,
			'USE_EXPORTER' => -27
		},
		GOTOS => {
			'UseParent' => 14,
			'Class' => 17,
			'STAR-11' => 12,
			'Module' => 15,
			'Package' => 18
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => 20,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 19
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 22
		},
		GOTOS => {
			'PLUS-17' => 21
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => -20,
			"## no critic qw(" => 6,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'Critic' => 4,
			'OPTIONAL-9' => 5,
			'PAREN-1' => 23,
			'ModuleHeader' => 3
		}
	},
	{#State 9
		ACTIONS => {
			'' => 24
		}
	},
	{#State 10
		DEFAULT => -6
	},
	{#State 11
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 12
		ACTIONS => {
			'SUB' => -29,
			"INIT" => -29,
			'USE' => -29,
			"use constant" => -29,
			"## no critic qw(" => 6,
			'USE_EXPORTER' => 29
		},
		GOTOS => {
			'OPTIONAL-12' => 26,
			'Critic' => 28,
			'Exports' => 27
		}
	},
	{#State 13
		DEFAULT => -78
	},
	{#State 14
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 31
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -77
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		DEFAULT => -24
	},
	{#State 19
		ACTIONS => {
			"package" => 33
		}
	},
	{#State 20
		DEFAULT => -21
	},
	{#State 21
		ACTIONS => {
			'WORD' => 35,
			")" => 34
		}
	},
	{#State 22
		DEFAULT => -41
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
		DEFAULT => -31,
		GOTOS => {
			'STAR-13' => 38
		}
	},
	{#State 27
		DEFAULT => -28
	},
	{#State 28
		DEFAULT => -26
	},
	{#State 29
		ACTIONS => {
			'SUB' => -45,
			"INIT" => -45,
			'OUR_EXPORT_OK' => -45,
			"our hashref \$properties" => -45,
			'OUR_EXPORT' => 41,
			"use constant" => -45,
			'USE' => -45
		},
		GOTOS => {
			'OPTIONAL-19' => 39,
			'PAREN-18' => 40
		}
	},
	{#State 30
		DEFAULT => -238
	},
	{#State 31
		DEFAULT => -237
	},
	{#State 32
		ACTIONS => {
			")" => 42
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 30
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
			"use constant" => -33,
			'USE' => 47,
			'SUB' => -33,
			"INIT" => 49
		},
		GOTOS => {
			'STAR-14' => 46,
			'Include' => 48
		}
	},
	{#State 39
		ACTIONS => {
			'SUB' => -48,
			"INIT" => -48,
			"use constant" => -48,
			'USE' => -48,
			"our hashref \$properties" => -48,
			'OUR_EXPORT_OK' => 50
		},
		GOTOS => {
			'OPTIONAL-21' => 51,
			'PAREN-20' => 52
		}
	},
	{#State 40
		DEFAULT => -44
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 53
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
			"while" => -11,
			"use constant" => -11,
			"\@{" => -11,
			"undef" => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED' => -11,
			'SUB' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"INIT" => -11,
			'LITERAL_NUMBER' => -11,
			'OP10_NAMED_UNARY_SCOLON' => -11,
			'OP01_NAMED_VOID' => -11,
			"%{" => -11,
			'LPAREN' => -11,
			'LBRACE' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_UPPERCASE' => -11,
			'LBRACKET' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_CLOSE' => -11,
			'OP05_BITWISE_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"if" => -11,
			'USE' => -11,
			"foreach" => -11,
			'OP01_NAMED_SCOLON' => -11,
			'WORD' => -11,
			'OP22_LOGICAL_NEG_LPAREN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 6,
			"for" => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'MY' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'SELF' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_OPEN' => -11
		},
		GOTOS => {
			'STAR-5' => 57,
			'Critic' => 56
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
			"use constant" => 61,
			'SUB' => 64
		},
		GOTOS => {
			'Constant' => 62,
			'PLUS-15' => 63,
			'Subroutine' => 60
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 65
		}
	},
	{#State 48
		DEFAULT => -30
	},
	{#State 49
		ACTIONS => {
			'LBRACE' => 66
		}
	},
	{#State 50
		ACTIONS => {
			'OP01_QW' => 67
		}
	},
	{#State 51
		DEFAULT => -49
	},
	{#State 52
		DEFAULT => -47
	},
	{#State 53
		ACTIONS => {
			";" => 68
		}
	},
	{#State 54
		ACTIONS => {
			'USE' => 47,
			"INIT" => 49
		},
		GOTOS => {
			'Include' => 69
		}
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
		DEFAULT => -8
	},
	{#State 57
		ACTIONS => {
			'OP01_PRINT' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'SELF' => -13,
			'VARIABLE_SYMBOL' => -13,
			'LITERAL_STRING' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'MY' => -13,
			"for" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_SCOLON' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP05_BITWISE_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"foreach" => -13,
			"if" => -13,
			'USE' => 47,
			'WORD_UPPERCASE' => -13,
			'LBRACKET' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LPAREN' => -13,
			'LBRACE' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			'SUB' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"INIT" => 49,
			'OP10_NAMED_UNARY_SCOLON' => -13,
			"\@{" => -13,
			"undef" => -13,
			'WORD_SCOPED' => -13,
			"while" => -13,
			"use constant" => -13
		},
		GOTOS => {
			'STAR-6' => 71,
			'Include' => 72
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
		DEFAULT => -35
	},
	{#State 61
		ACTIONS => {
			'WORD_UPPERCASE' => 74
		}
	},
	{#State 62
		DEFAULT => -32
	},
	{#State 63
		ACTIONS => {
			'LITERAL_NUMBER' => 76,
			'SUB' => 64
		},
		GOTOS => {
			'Subroutine' => 75
		}
	},
	{#State 64
		ACTIONS => {
			'WORD' => 77
		}
	},
	{#State 65
		ACTIONS => {
			'OP01_QW' => 79,
			";" => -51
		},
		GOTOS => {
			'OPTIONAL-22' => 78
		}
	},
	{#State 66
		ACTIONS => {
			'WORD' => 31,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 80
		}
	},
	{#State 67
		ACTIONS => {
			";" => 81
		}
	},
	{#State 68
		DEFAULT => -43
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
			'OP22_LOGICAL_NEG' => -15,
			'SELF' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_OPEN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_PRINT' => -15,
			'MY' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LITERAL_STRING' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for" => -15,
			"foreach" => -15,
			"if" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_BITWISE_NEG_LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'OP22_LOGICAL_NEG_LPAREN' => -15,
			'WORD' => -15,
			'OP01_NAMED_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'LBRACKET' => -15,
			'WORD_UPPERCASE' => -15,
			"%{" => -15,
			'OP10_NAMED_UNARY_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			'SUB' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			"use constant" => 61,
			"while" => -15,
			'WORD_SCOPED' => -15,
			"\@{" => -15,
			"undef" => -15
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
			'OP20_HASH_FATARROW' => 86
		}
	},
	{#State 75
		DEFAULT => -34
	},
	{#State 76
		ACTIONS => {
			";" => 87
		}
	},
	{#State 77
		ACTIONS => {
			'LBRACE' => 88
		}
	},
	{#State 78
		ACTIONS => {
			";" => 89
		}
	},
	{#State 79
		DEFAULT => -50
	},
	{#State 80
		ACTIONS => {
			'OP02_METHOD_THINARROW_IMP' => 90
		}
	},
	{#State 81
		DEFAULT => -46
	},
	{#State 82
		ACTIONS => {
			'USE' => -69,
			"use constant" => -69,
			"INIT" => -69,
			'USE_EXPORTER' => 29,
			"our hashref \$properties" => -69,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'OPTIONAL-29' => 91,
			'Exports' => 93,
			'Critic' => 92
		}
	},
	{#State 83
		DEFAULT => -12
	},
	{#State 84
		ACTIONS => {
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_NAMED_SCOLON' => 147,
			'OP01_NAMED_VOID_LPAREN' => 140,
			"if" => 138,
			"foreach" => -171,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"for" => -171,
			'OP05_LOGICAL_NEG' => 136,
			'VARIABLE_SYMBOL' => 133,
			'MY' => 129,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP01_OPEN' => 123,
			'OP01_PRINT' => 127,
			'OP03_MATH_INC_DEC' => 125,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP01_NAMED_VOID_SCOLON' => 122,
			"undef" => 115,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			"while" => -171,
			'OP01_NAMED_VOID' => 111,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'SUB' => 64,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			'OP01_NAMED' => 107,
			'LITERAL_NUMBER' => 106,
			"%{" => 102,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 99,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 96,
			'LBRACE' => 95
		},
		GOTOS => {
			'OperatorVoid' => 139,
			'PAREN-45' => 142,
			'LoopLabel' => 112,
			'Literal' => 113,
			'VariableDeclaration' => 145,
			'Expression' => 117,
			'Conditional' => 116,
			'HashDereference' => 146,
			'ArrayReference' => 135,
			'OPTIONAL-46' => 105,
			'VariableModification' => 109,
			'SubExpression' => 137,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'Subroutine' => 100,
			'PLUS-8' => 101,
			'Operation' => 134,
			'HashReference' => 103,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 124,
			'Statement' => 126
		}
	},
	{#State 85
		DEFAULT => -39
	},
	{#State 86
		ACTIONS => {
			'MY' => 149
		},
		GOTOS => {
			'TypeInnerConstant' => 148
		}
	},
	{#State 87
		DEFAULT => -36
	},
	{#State 88
		ACTIONS => {
			'LBRACE' => 150
		}
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
		DEFAULT => -71,
		GOTOS => {
			'STAR-30' => 153
		}
	},
	{#State 92
		DEFAULT => -66
	},
	{#State 93
		DEFAULT => -68
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'LoopLabel' => 155
		}
	},
	{#State 95
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 159,
			'OP01_NAMED_VOID' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP01_NAMED' => 175,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'LITERAL_NUMBER' => 106,
			'OP12_COMPARE_EQ_NE' => 161,
			'WORD' => 156,
			'OP01_CLOSE' => 158,
			"}" => 177,
			'OP07_STRING_REPEAT' => 166,
			'OP01_OPEN' => 165,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP01_PRINT' => 168,
			'OP22_LOGICAL_NEG' => 169,
			'OP19_LOOP_CONTROL' => 179,
			'SELF' => 119,
			'ENV' => 170,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP23_LOGICAL_AND' => 163,
			'OP10_NAMED_UNARY' => 162,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'OpStringOrWord' => 180,
			'Variable' => 164,
			'Literal' => 171,
			'VarOrLitOrOpStrOrWord' => 167,
			'HashEntry' => 172,
			'HashDereference' => 157
		}
	},
	{#State 96
		ACTIONS => {
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_PRINT' => 181,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP01_NAMED' => 185,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 183
		}
	},
	{#State 97
		DEFAULT => -151
	},
	{#State 98
		ACTIONS => {
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			"]" => -216,
			'OP10_NAMED_UNARY' => 130,
			'OP01_QW' => 189,
			'MY' => 195,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 191,
			'Variable' => 182,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ListElements' => 192,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'OPTIONAL-55' => 188,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113,
			'ListElement' => 194,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 99
		ACTIONS => {
			'COLON' => -239,
			'LPAREN' => 196
		}
	},
	{#State 100
		DEFAULT => -14
	},
	{#State 101
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 136,
			"for" => -171,
			"foreach" => -171,
			"if" => 138,
			'OP01_NAMED_VOID_LPAREN' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'' => -18,
			'WORD' => 31,
			'OP01_NAMED_SCOLON' => 147,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP01_OPEN' => 123,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_PRINT' => 127,
			'MY' => 129,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 107,
			'OP01_NAMED_VOID' => 111,
			"while" => -171,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'OP19_LOOP_CONTROL' => 94,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 99,
			"%{" => 102
		},
		GOTOS => {
			'Variable' => 124,
			'Statement' => 126,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Operation' => 197,
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 128,
			'VariableModification' => 109,
			'SubExpression' => 137,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'OPTIONAL-46' => 105,
			'Literal' => 113,
			'VariableDeclaration' => 145,
			'Conditional' => 116,
			'Expression' => 117,
			'HashDereference' => 146,
			'OperatorVoid' => 139,
			'PAREN-45' => 142,
			'LoopLabel' => 112
		}
	},
	{#State 102
		ACTIONS => {
			'LBRACE' => -234,
			'MY' => 195,
			'SELF' => 119,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'TypeInner' => 200,
			'Variable' => 198,
			'OPTIONAL-60' => 199
		}
	},
	{#State 103
		DEFAULT => -161
	},
	{#State 104
		DEFAULT => -97
	},
	{#State 105
		ACTIONS => {
			"foreach" => 205,
			"while" => 201,
			"for" => 204
		},
		GOTOS => {
			'LoopFor' => 206,
			'Loop' => 202,
			'LoopForEach' => 207,
			'LoopWhile' => 203
		}
	},
	{#State 106
		DEFAULT => -254
	},
	{#State 107
		ACTIONS => {
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'MY' => 195,
			'OP01_QW' => 189,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			"%{" => 102,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144
		},
		GOTOS => {
			'SubExpression' => 209,
			'Variable' => 182,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 208
		}
	},
	{#State 108
		DEFAULT => -141
	},
	{#State 109
		ACTIONS => {
			";" => 210
		}
	},
	{#State 110
		ACTIONS => {
			'LPAREN' => 212,
			'OP02_METHOD_THINARROW_NEW' => 211
		}
	},
	{#State 111
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			"%{" => 102,
			'ARGV' => 193,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'MY' => 195,
			'OP01_QW' => 189,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'TypeInner' => 190,
			'HashDereference' => 146,
			'ArrayReference' => 135,
			'ListElements' => 213,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'SubExpression' => 191,
			'Variable' => 182,
			'WordScoped' => 110
		}
	},
	{#State 112
		ACTIONS => {
			'COLON' => 214
		}
	},
	{#State 113
		DEFAULT => -157
	},
	{#State 114
		ACTIONS => {
			'VARIABLE_SYMBOL' => 133,
			'LBRACKET' => -219,
			'SELF' => 119,
			'MY' => 195
		},
		GOTOS => {
			'Variable' => 215,
			'TypeInner' => 217,
			'VariableSymbolOrSelf' => 128,
			'OPTIONAL-56' => 216
		}
	},
	{#State 115
		DEFAULT => -156
	},
	{#State 116
		DEFAULT => -172
	},
	{#State 117
		ACTIONS => {
			'OP13_BITWISE_AND' => -155,
			'OP15_LOGICAL_AND' => -155,
			'OP11_COMPARE_LT_GT' => -155,
			'OP12_COMPARE_EQ_NE' => -155,
			'OP09_BITWISE_SHIFT' => -155,
			'OP07_MATH_MULT_DIV_MOD' => -155,
			'OP08_MATH_ADD_SUB' => -155,
			'OP08_STRING_CAT' => -155,
			'OP23_LOGICAL_AND' => -155,
			'OP16_LOGICAL_OR' => -155,
			'OP06_REGEX_BIND' => -155,
			'OP14_BITWISE_OR_XOR' => -155,
			'OP17_LIST_RANGE' => -155,
			'OP24_LOGICAL_OR_XOR' => -155,
			'OP18_TERNARY' => -155,
			'OP07_STRING_REPEAT' => -155,
			'OP04_MATH_POW' => -155,
			";" => 218
		}
	},
	{#State 118
		ACTIONS => {
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136
		},
		GOTOS => {
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 219,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103
		}
	},
	{#State 119
		DEFAULT => -253
	},
	{#State 120
		DEFAULT => -149
	},
	{#State 121
		DEFAULT => -160
	},
	{#State 122
		DEFAULT => -137
	},
	{#State 123
		ACTIONS => {
			'MY' => 220
		}
	},
	{#State 124
		ACTIONS => {
			'OP15_LOGICAL_AND' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP02_METHOD_THINARROW' => 224,
			'OP09_BITWISE_SHIFT' => -158,
			'OP12_COMPARE_EQ_NE' => -158,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP08_STRING_CAT' => -158,
			'OP19_VARIABLE_ASSIGN' => 221,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP19_VARIABLE_ASSIGN_BY' => 222,
			'OP03_MATH_INC_DEC' => 223,
			'OP07_STRING_REPEAT' => -158,
			'OP18_TERNARY' => -158,
			'OP04_MATH_POW' => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP06_REGEX_BIND' => -158
		}
	},
	{#State 125
		ACTIONS => {
			'SELF' => 119,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'Variable' => 225
		}
	},
	{#State 126
		DEFAULT => -98
	},
	{#State 127
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -132,
			'OP01_NAMED' => -132,
			'LITERAL_NUMBER' => -132,
			'WORD' => -132,
			"\@{" => -132,
			"undef" => -132,
			'OP22_LOGICAL_NEG_LPAREN' => -132,
			'WORD_SCOPED' => -132,
			'FHREF_SYMBOL_BRACES' => 228,
			'OP01_CLOSE' => -132,
			'OP05_BITWISE_NEG_LPAREN' => -132,
			'OP01_OPEN' => -132,
			'LBRACKET' => -132,
			'CONSTANT_CALL_SCOPED' => -132,
			'WORD_UPPERCASE' => -132,
			'OP03_MATH_INC_DEC' => -132,
			'OP22_LOGICAL_NEG' => -132,
			'SELF' => -132,
			'LPAREN' => -132,
			'LBRACE' => -132,
			'ARGV' => -132,
			'VARIABLE_SYMBOL' => -132,
			'STDOUT_STDERR' => 227,
			"%{" => -132,
			'MY' => -132,
			'OP01_QW' => -132,
			'LITERAL_STRING' => -132,
			'OP10_NAMED_UNARY' => -132,
			'OP05_MATH_NEG_LPAREN' => -132
		},
		GOTOS => {
			'PAREN-39' => 226,
			'OPTIONAL-40' => 229
		}
	},
	{#State 128
		DEFAULT => -196,
		GOTOS => {
			'STAR-52' => 230
		}
	},
	{#State 129
		ACTIONS => {
			'WORD_SCOPED' => 232,
			'TYPE_FHREF' => 235,
			'WORD' => 234,
			'TYPE_INTEGER' => 233
		},
		GOTOS => {
			'Type' => 231
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP13_BITWISE_AND' => -117,
			'OP11_COMPARE_LT_GT' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP12_COMPARE_EQ_NE' => -117,
			'OP05_LOGICAL_NEG' => 136,
			")" => -117,
			'VARIABLE_SYMBOL' => 133,
			'OP06_REGEX_BIND' => -117,
			'LITERAL_STRING' => 132,
			"]" => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP07_STRING_REPEAT' => -117,
			'OP01_OPEN' => 123,
			'OP03_MATH_INC_DEC' => 125,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			";" => -117,
			"\@{" => 114,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP21_LIST_COMMA' => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP08_STRING_CAT' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			"%{" => 102,
			'OP16_LOGICAL_OR' => -117,
			'LBRACKET' => 98,
			'OP18_TERNARY' => -117,
			"}" => -117,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP04_MATH_POW' => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP17_LIST_RANGE' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			'WORD_UPPERCASE' => 184,
			'LPAREN' => 96,
			'LBRACE' => 95
		},
		GOTOS => {
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128,
			'Variable' => 182,
			'SubExpression' => 236,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184
		},
		GOTOS => {
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 237,
			'VariableSymbolOrSelf' => 128,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'Literal' => 113
		}
	},
	{#State 132
		DEFAULT => -255
	},
	{#State 133
		DEFAULT => -252
	},
	{#State 134
		DEFAULT => -17
	},
	{#State 135
		DEFAULT => -159
	},
	{#State 136
		ACTIONS => {
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119
		},
		GOTOS => {
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 238,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113
		}
	},
	{#State 137
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP23_LOGICAL_AND' => 244,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250
		}
	},
	{#State 138
		ACTIONS => {
			'LPAREN' => 256
		}
	},
	{#State 139
		DEFAULT => -174
	},
	{#State 140
		ACTIONS => {
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			")" => -134,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'MY' => 195,
			'OP01_QW' => 189,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97
		},
		GOTOS => {
			'ListElements' => 258,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 191,
			'OPTIONAL-41' => 257,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194,
			'Literal' => 113,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'HashReference' => 103,
			'Expression' => 186
		}
	},
	{#State 141
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'Variable' => 182,
			'SubExpression' => 259,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 142
		DEFAULT => -170
	},
	{#State 143
		ACTIONS => {
			'FHREF_SYMBOL' => 260
		}
	},
	{#State 144
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 261,
			'Variable' => 182,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 145
		DEFAULT => -175
	},
	{#State 146
		DEFAULT => -162
	},
	{#State 147
		DEFAULT => -96
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'Literal' => 262
		}
	},
	{#State 149
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD' => 234,
			'WORD_SCOPED' => 232
		},
		GOTOS => {
			'Type' => 263
		}
	},
	{#State 150
		ACTIONS => {
			'MY' => 264
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
			"our hashref \$properties" => -73,
			"use constant" => -73,
			'USE' => 47,
			"INIT" => 49
		},
		GOTOS => {
			'STAR-31' => 266,
			'Include' => 267
		}
	},
	{#State 154
		DEFAULT => -239
	},
	{#State 155
		ACTIONS => {
			";" => 268
		}
	},
	{#State 156
		DEFAULT => -278
	},
	{#State 157
		DEFAULT => -225
	},
	{#State 158
		DEFAULT => -274
	},
	{#State 159
		DEFAULT => -268
	},
	{#State 160
		DEFAULT => -271
	},
	{#State 161
		DEFAULT => -267
	},
	{#State 162
		DEFAULT => -269
	},
	{#State 163
		DEFAULT => -263
	},
	{#State 164
		DEFAULT => -249
	},
	{#State 165
		DEFAULT => -275
	},
	{#State 166
		DEFAULT => -272
	},
	{#State 167
		ACTIONS => {
			'OP20_HASH_FATARROW' => 269
		}
	},
	{#State 168
		DEFAULT => -277
	},
	{#State 169
		DEFAULT => -264
	},
	{#State 170
		DEFAULT => -226
	},
	{#State 171
		DEFAULT => -250
	},
	{#State 172
		DEFAULT => -230,
		GOTOS => {
			'STAR-59' => 270
		}
	},
	{#State 173
		DEFAULT => -276
	},
	{#State 174
		DEFAULT => -270
	},
	{#State 175
		DEFAULT => -273
	},
	{#State 176
		DEFAULT => -265
	},
	{#State 177
		DEFAULT => -232
	},
	{#State 178
		DEFAULT => -262
	},
	{#State 179
		DEFAULT => -266
	},
	{#State 180
		DEFAULT => -251
	},
	{#State 181
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 271
		}
	},
	{#State 182
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -158,
			'OP09_BITWISE_SHIFT' => -158,
			'OP02_METHOD_THINARROW' => 224,
			")" => -158,
			'OP08_MATH_ADD_SUB' => -158,
			'OP07_MATH_MULT_DIV_MOD' => -158,
			'OP08_STRING_CAT' => -158,
			'OP13_BITWISE_AND' => -158,
			'OP15_LOGICAL_AND' => -158,
			'OP11_COMPARE_LT_GT' => -158,
			'OP21_LIST_COMMA' => -158,
			";" => -158,
			'OP14_BITWISE_OR_XOR' => -158,
			'OP24_LOGICAL_OR_XOR' => -158,
			'OP17_LIST_RANGE' => -158,
			'OP03_MATH_INC_DEC' => 223,
			'OP07_STRING_REPEAT' => -158,
			'OP18_TERNARY' => -158,
			'OP04_MATH_POW' => -158,
			"}" => -158,
			"]" => -158,
			'OP23_LOGICAL_AND' => -158,
			'OP16_LOGICAL_OR' => -158,
			'OP06_REGEX_BIND' => -158
		}
	},
	{#State 183
		ACTIONS => {
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			")" => 272,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 184
		ACTIONS => {
			'LPAREN' => 196
		}
	},
	{#State 185
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'MY' => 195,
			'OP01_QW' => 189,
			"%{" => 102,
			'ARGV' => 193,
			'VARIABLE_SYMBOL' => 133,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 209,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'ListElement' => 273,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 186
		DEFAULT => -155
	},
	{#State 187
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 274,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 188
		ACTIONS => {
			"]" => 275
		}
	},
	{#State 189
		DEFAULT => -213
	},
	{#State 190
		ACTIONS => {
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144
		},
		GOTOS => {
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'Variable' => 182,
			'SubExpression' => 276,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146
		}
	},
	{#State 191
		ACTIONS => {
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			";" => -211,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP23_LOGICAL_AND' => 244,
			"]" => -211,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -211,
			'OP21_LIST_COMMA' => -211
		}
	},
	{#State 192
		DEFAULT => -215
	},
	{#State 193
		DEFAULT => -214
	},
	{#State 194
		DEFAULT => -209,
		GOTOS => {
			'STAR-54' => 277
		}
	},
	{#State 195
		ACTIONS => {
			'WORD' => 234,
			'WORD_SCOPED' => 232,
			'TYPE_INTEGER' => 233
		},
		GOTOS => {
			'Type' => 278
		}
	},
	{#State 196
		ACTIONS => {
			")" => 279
		}
	},
	{#State 197
		DEFAULT => -16
	},
	{#State 198
		ACTIONS => {
			"}" => 280
		}
	},
	{#State 199
		ACTIONS => {
			'LBRACE' => 95
		},
		GOTOS => {
			'HashReference' => 281
		}
	},
	{#State 200
		DEFAULT => -233
	},
	{#State 201
		ACTIONS => {
			'LPAREN_MY' => 283,
			'LPAREN' => 282
		}
	},
	{#State 202
		DEFAULT => -173
	},
	{#State 203
		DEFAULT => -186
	},
	{#State 204
		ACTIONS => {
			'LPAREN_MY' => 285,
			'MY' => 284
		}
	},
	{#State 205
		ACTIONS => {
			'MY' => 286
		}
	},
	{#State 206
		DEFAULT => -184
	},
	{#State 207
		DEFAULT => -185
	},
	{#State 208
		ACTIONS => {
			'OP21_LIST_COMMA' => 287
		}
	},
	{#State 209
		ACTIONS => {
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP04_MATH_POW' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			";" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP08_STRING_CAT' => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -211
		}
	},
	{#State 210
		DEFAULT => -176
	},
	{#State 211
		ACTIONS => {
			")" => -148,
			'LBRACE' => 95
		},
		GOTOS => {
			'HashReference' => 288,
			'OPTIONAL-44' => 289
		}
	},
	{#State 212
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			")" => -144,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP01_QW' => 189,
			'MY' => 195
		},
		GOTOS => {
			'SubExpression' => 191,
			'Variable' => 182,
			'WordScoped' => 110,
			'ListElements' => 291,
			'OPTIONAL-42' => 290,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'TypeInner' => 190,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194
		}
	},
	{#State 213
		ACTIONS => {
			";" => 292
		}
	},
	{#State 214
		DEFAULT => -169
	},
	{#State 215
		ACTIONS => {
			"}" => 293
		}
	},
	{#State 216
		ACTIONS => {
			'LBRACKET' => 98
		},
		GOTOS => {
			'ArrayReference' => 294
		}
	},
	{#State 217
		DEFAULT => -218
	},
	{#State 218
		DEFAULT => -95
	},
	{#State 219
		ACTIONS => {
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			")" => -127,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP21_LIST_COMMA' => -127,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			"}" => -127,
			'OP04_MATH_POW' => 253,
			";" => -127,
			'OP23_LOGICAL_AND' => -127,
			"]" => -127,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245
		}
	},
	{#State 220
		ACTIONS => {
			'TYPE_FHREF' => 295
		}
	},
	{#State 221
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'STDIN' => 297,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'FHREF_SYMBOL_IN' => 298,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'SubExpressionOrInput' => 299,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'SubExpression' => 296,
			'Variable' => 182,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 222
		ACTIONS => {
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114
		},
		GOTOS => {
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'SubExpression' => 300,
			'Variable' => 182,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 223
		DEFAULT => -105
	},
	{#State 224
		ACTIONS => {
			'LPAREN' => 301
		}
	},
	{#State 225
		DEFAULT => -104
	},
	{#State 226
		DEFAULT => -131
	},
	{#State 227
		DEFAULT => -130
	},
	{#State 228
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP01_QW' => 189,
			'MY' => 195
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194,
			'Literal' => 113,
			'TypeInner' => 190,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'ListElements' => 302,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 191,
			'WordScoped' => 110
		}
	},
	{#State 229
		ACTIONS => {
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP01_QW' => 189,
			'MY' => 195,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashDereference' => 146,
			'TypeInner' => 190,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'ListElement' => 194,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 191,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ListElements' => 303,
			'ArrayReference' => 135
		}
	},
	{#State 230
		ACTIONS => {
			"]" => -197,
			'OP23_LOGICAL_AND' => -197,
			'OP06_REGEX_BIND' => -197,
			'OP16_LOGICAL_OR' => -197,
			'OP02_ARRAY_THINARROW' => 304,
			";" => -197,
			'OP02_HASH_THINARROW' => 305,
			'OP17_LIST_RANGE' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'OP19_VARIABLE_ASSIGN_BY' => -197,
			'OP24_LOGICAL_OR_XOR' => -197,
			'OP14_BITWISE_OR_XOR' => -197,
			"}" => -197,
			'OP04_MATH_POW' => -197,
			'OP18_TERNARY' => -197,
			'OP07_STRING_REPEAT' => -197,
			'OP21_LIST_COMMA' => -197,
			'OP19_VARIABLE_ASSIGN' => -197,
			")" => -197,
			'OP09_BITWISE_SHIFT' => -197,
			'OP02_METHOD_THINARROW' => -197,
			'OP12_COMPARE_EQ_NE' => -197,
			'OP20_HASH_FATARROW' => -197,
			'OP08_STRING_CAT' => -197,
			'OP08_MATH_ADD_SUB' => -197,
			'OP07_MATH_MULT_DIV_MOD' => -197,
			'COLON' => -197,
			'OP11_COMPARE_LT_GT' => -197,
			'OP13_BITWISE_AND' => -197,
			'OP15_LOGICAL_AND' => -197
		},
		GOTOS => {
			'VariableRetrieval' => 306
		}
	},
	{#State 231
		ACTIONS => {
			'VARIABLE_SYMBOL' => 307
		}
	},
	{#State 232
		DEFAULT => -241
	},
	{#State 233
		DEFAULT => -242
	},
	{#State 234
		DEFAULT => -240
	},
	{#State 235
		ACTIONS => {
			'FHREF_SYMBOL' => 308
		}
	},
	{#State 236
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -116,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -116,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => -116,
			'OP15_LOGICAL_AND' => -116,
			'OP11_COMPARE_LT_GT' => -116,
			'OP21_LIST_COMMA' => -116,
			";" => -116,
			'OP14_BITWISE_OR_XOR' => -116,
			'OP17_LIST_RANGE' => -116,
			'OP24_LOGICAL_OR_XOR' => -116,
			'OP18_TERNARY' => -116,
			'OP07_STRING_REPEAT' => 243,
			"}" => -116,
			'OP04_MATH_POW' => 253,
			"]" => -116,
			'OP23_LOGICAL_AND' => -116,
			'OP16_LOGICAL_OR' => -116,
			'OP06_REGEX_BIND' => 245
		}
	},
	{#State 237
		ACTIONS => {
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			")" => 309,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP23_LOGICAL_AND' => 244,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252
		}
	},
	{#State 238
		ACTIONS => {
			'OP06_REGEX_BIND' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP23_LOGICAL_AND' => -108,
			"]" => -108,
			";" => -108,
			"}" => -108,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => -108,
			'OP07_STRING_REPEAT' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP17_LIST_RANGE' => -108,
			'OP14_BITWISE_OR_XOR' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP08_STRING_CAT' => -108,
			'OP08_MATH_ADD_SUB' => -108,
			'OP07_MATH_MULT_DIV_MOD' => -108,
			")" => -108,
			'OP09_BITWISE_SHIFT' => -108,
			'OP12_COMPARE_EQ_NE' => -108,
			'OP11_COMPARE_LT_GT' => -108,
			'OP13_BITWISE_AND' => -108,
			'OP15_LOGICAL_AND' => -108
		}
	},
	{#State 239
		ACTIONS => {
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'SubExpression' => 310,
			'Variable' => 182,
			'WordScoped' => 110
		}
	},
	{#State 240
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'VariableSymbolOrSelf' => 128,
			'Variable' => 182,
			'SubExpression' => 311,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120
		}
	},
	{#State 241
		ACTIONS => {
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144
		},
		GOTOS => {
			'SubExpression' => 312,
			'Variable' => 182,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 242
		ACTIONS => {
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 313,
			'Variable' => 182,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 243
		ACTIONS => {
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128,
			'SubExpression' => 314,
			'Variable' => 182,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120
		}
	},
	{#State 244
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143
		},
		GOTOS => {
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 315,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113
		}
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 316
		}
	},
	{#State 246
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 317,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113
		}
	},
	{#State 247
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'SubExpression' => 318,
			'Variable' => 182,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135
		}
	},
	{#State 248
		ACTIONS => {
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'Literal' => 113,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'SubExpression' => 319,
			'Variable' => 182
		}
	},
	{#State 249
		ACTIONS => {
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'Literal' => 113,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 320
		}
	},
	{#State 250
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 321,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 251
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125
		},
		GOTOS => {
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'SubExpression' => 322,
			'Variable' => 182,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146
		}
	},
	{#State 252
		ACTIONS => {
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'SubExpression' => 323,
			'Variable' => 182,
			'WordScoped' => 110
		}
	},
	{#State 253
		ACTIONS => {
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'SubExpression' => 324,
			'Variable' => 182,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135
		}
	},
	{#State 254
		ACTIONS => {
			'SELF' => 119,
			'LITERAL_NUMBER' => 106,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'VariableOrLiteral' => 326,
			'Literal' => 327,
			'Variable' => 325
		}
	},
	{#State 255
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 328,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 256
		ACTIONS => {
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 329,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113
		}
	},
	{#State 257
		ACTIONS => {
			")" => 330
		}
	},
	{#State 258
		DEFAULT => -133
	},
	{#State 259
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => 331,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253
		}
	},
	{#State 260
		DEFAULT => -103
	},
	{#State 261
		ACTIONS => {
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP23_LOGICAL_AND' => 244,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			")" => 332,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249
		}
	},
	{#State 262
		ACTIONS => {
			";" => 333
		}
	},
	{#State 263
		ACTIONS => {
			"\$TYPED_" => 334
		}
	},
	{#State 264
		ACTIONS => {
			'WORD_SCOPED' => 232,
			'WORD' => 234,
			'TYPE_INTEGER' => 233
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 265
		ACTIONS => {
			";" => 336
		}
	},
	{#State 266
		ACTIONS => {
			"our hashref \$properties" => 337,
			"use constant" => 61
		},
		GOTOS => {
			'Properties' => 338,
			'Constant' => 339
		}
	},
	{#State 267
		DEFAULT => -70
	},
	{#State 268
		DEFAULT => -142
	},
	{#State 269
		ACTIONS => {
			'OP01_CLOSE' => -223,
			'OP05_BITWISE_NEG_LPAREN' => -223,
			"undef" => -223,
			'WORD' => -223,
			"\@{" => -223,
			'WORD_SCOPED' => -223,
			'OP22_LOGICAL_NEG_LPAREN' => -223,
			'OP01_NAMED' => -223,
			'OP05_LOGICAL_NEG' => -223,
			'LITERAL_NUMBER' => -223,
			'LITERAL_STRING' => -223,
			'OP05_MATH_NEG_LPAREN' => -223,
			'OP10_NAMED_UNARY' => -223,
			'MY' => 195,
			"%{" => -223,
			'VARIABLE_SYMBOL' => -223,
			'LPAREN' => -223,
			'LBRACE' => -223,
			'OP22_LOGICAL_NEG' => -223,
			'SELF' => -223,
			'WORD_UPPERCASE' => -223,
			'OP03_MATH_INC_DEC' => -223,
			'OP01_OPEN' => -223,
			'LBRACKET' => -223,
			'CONSTANT_CALL_SCOPED' => -223
		},
		GOTOS => {
			'OPTIONAL-57' => 341,
			'TypeInner' => 340
		}
	},
	{#State 270
		ACTIONS => {
			"}" => 344,
			'OP21_LIST_COMMA' => 343
		},
		GOTOS => {
			'PAREN-58' => 342
		}
	},
	{#State 271
		ACTIONS => {
			'OP01_QW' => 189,
			'MY' => 195,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			"%{" => 102,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'ListElements' => 345,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 191,
			'ListElement' => 194,
			'VariableSymbolOrSelf' => 128,
			'Expression' => 186,
			'HashReference' => 103,
			'TypeInner' => 190,
			'HashDereference' => 146,
			'Literal' => 113
		}
	},
	{#State 272
		DEFAULT => -163
	},
	{#State 273
		ACTIONS => {
			'OP21_LIST_COMMA' => 346
		}
	},
	{#State 274
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			'OP08_STRING_CAT' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			")" => -100,
			'OP09_BITWISE_SHIFT' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_BIND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			"]" => -100,
			";" => -100,
			"}" => -100,
			'OP04_MATH_POW' => -100,
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP14_BITWISE_OR_XOR' => -100
		}
	},
	{#State 275
		DEFAULT => -217
	},
	{#State 276
		ACTIONS => {
			"]" => -212,
			'OP23_LOGICAL_AND' => 244,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			";" => -212,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP21_LIST_COMMA' => -212,
			")" => -212,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242
		}
	},
	{#State 277
		ACTIONS => {
			'OP21_LIST_COMMA' => 347,
			"]" => -210,
			";" => -210,
			")" => -210
		},
		GOTOS => {
			'PAREN-53' => 348
		}
	},
	{#State 278
		ACTIONS => {
			"\$TYPED_" => 349
		}
	},
	{#State 279
		DEFAULT => -150
	},
	{#State 280
		DEFAULT => -235
	},
	{#State 281
		ACTIONS => {
			"}" => 350
		}
	},
	{#State 282
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'Literal' => 113,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 351,
			'WordScoped' => 110
		}
	},
	{#State 283
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD_SCOPED' => 232,
			'WORD' => 234
		},
		GOTOS => {
			'Type' => 352
		}
	},
	{#State 284
		ACTIONS => {
			'TYPE_INTEGER' => 353
		}
	},
	{#State 285
		ACTIONS => {
			'TYPE_INTEGER' => 354
		}
	},
	{#State 286
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD_SCOPED' => 232,
			'WORD' => 234
		},
		GOTOS => {
			'Type' => 355
		}
	},
	{#State 287
		ACTIONS => {
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			"%{" => 102,
			'OP01_QW' => 189,
			'MY' => 195,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'Variable' => 182,
			'SubExpression' => 191,
			'WordScoped' => 110,
			'ListElements' => 356,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194
		}
	},
	{#State 288
		DEFAULT => -147
	},
	{#State 289
		ACTIONS => {
			")" => 357
		}
	},
	{#State 290
		ACTIONS => {
			")" => 358
		}
	},
	{#State 291
		DEFAULT => -143
	},
	{#State 292
		DEFAULT => -139
	},
	{#State 293
		DEFAULT => -220
	},
	{#State 294
		ACTIONS => {
			"}" => 359
		}
	},
	{#State 295
		ACTIONS => {
			'FHREF_SYMBOL' => 360
		}
	},
	{#State 296
		ACTIONS => {
			";" => -164,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -164,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241
		}
	},
	{#State 297
		DEFAULT => -166
	},
	{#State 298
		DEFAULT => -165
	},
	{#State 299
		DEFAULT => -205
	},
	{#State 300
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			")" => -206,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP23_LOGICAL_AND' => 244,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252,
			";" => -206
		}
	},
	{#State 301
		ACTIONS => {
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			")" => -146,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'ARGV' => 193,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP01_QW' => 189,
			'MY' => 195,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LBRACE' => 95,
			'LPAREN' => 96
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 103,
			'Expression' => 186,
			'TypeInner' => 190,
			'HashDereference' => 146,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194,
			'OPTIONAL-43' => 362,
			'SubExpression' => 191,
			'Variable' => 182,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ListElements' => 361,
			'ArrayDereference' => 121,
			'Operator' => 120
		}
	},
	{#State 302
		ACTIONS => {
			";" => 363
		}
	},
	{#State 303
		ACTIONS => {
			";" => 364
		}
	},
	{#State 304
		ACTIONS => {
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 365,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 367,
			"undef" => 115,
			"\@{" => 114,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 366
		}
	},
	{#State 306
		DEFAULT => -195
	},
	{#State 307
		ACTIONS => {
			";" => 368,
			'OP19_VARIABLE_ASSIGN' => 370,
			'OP02_ARRAY_THINARROW' => 369
		}
	},
	{#State 308
		ACTIONS => {
			";" => 371
		}
	},
	{#State 309
		DEFAULT => -109
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => -119,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => undef,
			")" => -119,
			'OP15_LOGICAL_AND' => -119,
			'OP13_BITWISE_AND' => -119,
			'OP11_COMPARE_LT_GT' => 241,
			'OP16_LOGICAL_OR' => -119,
			'OP06_REGEX_BIND' => 245,
			'OP23_LOGICAL_AND' => -119,
			"]" => -119,
			";" => -119,
			'OP18_TERNARY' => -119,
			'OP07_STRING_REPEAT' => 243,
			"}" => -119,
			'OP04_MATH_POW' => 253,
			'OP14_BITWISE_OR_XOR' => -119,
			'OP17_LIST_RANGE' => -119,
			'OP24_LOGICAL_OR_XOR' => -119
		}
	},
	{#State 311
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -112,
			'OP08_MATH_ADD_SUB' => -112,
			'OP08_STRING_CAT' => -112,
			'OP12_COMPARE_EQ_NE' => -112,
			'OP09_BITWISE_SHIFT' => -112,
			")" => -112,
			'OP15_LOGICAL_AND' => -112,
			'OP13_BITWISE_AND' => -112,
			'OP11_COMPARE_LT_GT' => -112,
			'OP21_LIST_COMMA' => -112,
			";" => -112,
			'OP18_TERNARY' => -112,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253,
			"}" => -112,
			'OP14_BITWISE_OR_XOR' => -112,
			'OP17_LIST_RANGE' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP16_LOGICAL_OR' => -112,
			'OP06_REGEX_BIND' => 245,
			"]" => -112,
			'OP23_LOGICAL_AND' => -112
		}
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => -118,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			")" => -118,
			'OP12_COMPARE_EQ_NE' => -118,
			'OP09_BITWISE_SHIFT' => 246,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -118,
			'OP13_BITWISE_AND' => -118,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => -118,
			'OP23_LOGICAL_AND' => -118,
			"]" => -118,
			";" => -118,
			"}" => -118,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => -118,
			'OP07_STRING_REPEAT' => 243,
			'OP17_LIST_RANGE' => -118,
			'OP24_LOGICAL_OR_XOR' => -118,
			'OP14_BITWISE_OR_XOR' => -118
		}
	},
	{#State 313
		ACTIONS => {
			")" => -120,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => -120,
			'OP15_LOGICAL_AND' => -120,
			'OP21_LIST_COMMA' => -120,
			";" => -120,
			'OP17_LIST_RANGE' => -120,
			'OP24_LOGICAL_OR_XOR' => -120,
			'OP14_BITWISE_OR_XOR' => -120,
			"}" => -120,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => -120,
			'OP07_STRING_REPEAT' => 243,
			'OP23_LOGICAL_AND' => -120,
			"]" => -120,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => -120
		}
	},
	{#State 314
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -111,
			'OP17_LIST_RANGE' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP07_STRING_REPEAT' => -111,
			'OP18_TERNARY' => -111,
			"}" => -111,
			'OP04_MATH_POW' => 253,
			";" => -111,
			'OP23_LOGICAL_AND' => -111,
			"]" => -111,
			'OP16_LOGICAL_OR' => -111,
			'OP06_REGEX_BIND' => 245,
			'OP15_LOGICAL_AND' => -111,
			'OP13_BITWISE_AND' => -111,
			'OP11_COMPARE_LT_GT' => -111,
			'OP12_COMPARE_EQ_NE' => -111,
			'OP09_BITWISE_SHIFT' => -111,
			")" => -111,
			'OP08_MATH_ADD_SUB' => -111,
			'OP07_MATH_MULT_DIV_MOD' => -111,
			'OP08_STRING_CAT' => -111,
			'OP21_LIST_COMMA' => -111
		}
	},
	{#State 315
		ACTIONS => {
			'OP23_LOGICAL_AND' => -128,
			"]" => -128,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP24_LOGICAL_OR_XOR' => -128,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			"}" => -128,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			";" => -128,
			'OP21_LIST_COMMA' => -128,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			")" => -128,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248
		}
	},
	{#State 316
		DEFAULT => -110
	},
	{#State 317
		ACTIONS => {
			'OP21_LIST_COMMA' => -115,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			")" => -115,
			'OP09_BITWISE_SHIFT' => -115,
			'OP12_COMPARE_EQ_NE' => -115,
			'OP11_COMPARE_LT_GT' => -115,
			'OP15_LOGICAL_AND' => -115,
			'OP13_BITWISE_AND' => -115,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => -115,
			'OP23_LOGICAL_AND' => -115,
			"]" => -115,
			";" => -115,
			"}" => -115,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => -115,
			'OP24_LOGICAL_OR_XOR' => -115,
			'OP17_LIST_RANGE' => -115,
			'OP14_BITWISE_OR_XOR' => -115
		}
	},
	{#State 318
		ACTIONS => {
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => -114,
			"]" => -114,
			'OP23_LOGICAL_AND' => -114,
			";" => -114,
			"}" => -114,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => -114,
			'OP17_LIST_RANGE' => -114,
			'OP24_LOGICAL_OR_XOR' => -114,
			'OP14_BITWISE_OR_XOR' => -114,
			'OP21_LIST_COMMA' => -114,
			'OP08_STRING_CAT' => -114,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			")" => -114,
			'OP12_COMPARE_EQ_NE' => -114,
			'OP09_BITWISE_SHIFT' => -114,
			'OP11_COMPARE_LT_GT' => -114,
			'OP15_LOGICAL_AND' => -114,
			'OP13_BITWISE_AND' => -114
		}
	},
	{#State 319
		ACTIONS => {
			'OP08_STRING_CAT' => -113,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => -113,
			")" => -113,
			'OP09_BITWISE_SHIFT' => -113,
			'OP12_COMPARE_EQ_NE' => -113,
			'OP11_COMPARE_LT_GT' => -113,
			'OP13_BITWISE_AND' => -113,
			'OP15_LOGICAL_AND' => -113,
			'OP21_LIST_COMMA' => -113,
			";" => -113,
			'OP04_MATH_POW' => 253,
			"}" => -113,
			'OP18_TERNARY' => -113,
			'OP07_STRING_REPEAT' => 243,
			'OP17_LIST_RANGE' => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			'OP14_BITWISE_OR_XOR' => -113,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => -113,
			"]" => -113,
			'OP23_LOGICAL_AND' => -113
		}
	},
	{#State 320
		ACTIONS => {
			'OP21_LIST_COMMA' => -122,
			'OP15_LOGICAL_AND' => -122,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			")" => -122,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			"]" => -122,
			'OP23_LOGICAL_AND' => -122,
			'OP16_LOGICAL_OR' => -122,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => -122,
			'OP24_LOGICAL_OR_XOR' => -122,
			'OP18_TERNARY' => -122,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253,
			"}" => -122,
			";" => -122
		}
	},
	{#State 321
		ACTIONS => {
			'OP21_LIST_COMMA' => -124,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -124,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP23_LOGICAL_AND' => -124,
			"]" => -124,
			'OP18_TERNARY' => -124,
			'OP07_STRING_REPEAT' => 243,
			'OP04_MATH_POW' => 253,
			"}" => -124,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -124,
			";" => -124
		}
	},
	{#State 322
		ACTIONS => {
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			"]" => -129,
			'OP23_LOGICAL_AND' => 244,
			'OP04_MATH_POW' => 253,
			"}" => -129,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => 252,
			";" => -129,
			'OP21_LIST_COMMA' => -129,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			")" => -129,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246
		}
	},
	{#State 323
		ACTIONS => {
			'OP21_LIST_COMMA' => -121,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			")" => -121,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP15_LOGICAL_AND' => -121,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP23_LOGICAL_AND' => -121,
			"]" => -121,
			'OP16_LOGICAL_OR' => -121,
			'OP06_REGEX_BIND' => 245,
			";" => -121,
			'OP14_BITWISE_OR_XOR' => -121,
			'OP24_LOGICAL_OR_XOR' => -121,
			'OP17_LIST_RANGE' => -121,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => -121,
			'OP04_MATH_POW' => 253,
			"}" => -121
		}
	},
	{#State 324
		ACTIONS => {
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP13_BITWISE_AND' => -106,
			'OP11_COMPARE_LT_GT' => -106,
			'OP08_MATH_ADD_SUB' => -106,
			'OP07_MATH_MULT_DIV_MOD' => -106,
			'OP08_STRING_CAT' => -106,
			'OP09_BITWISE_SHIFT' => -106,
			'OP12_COMPARE_EQ_NE' => -106,
			")" => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP06_REGEX_BIND' => -106,
			"]" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => -106,
			'OP07_STRING_REPEAT' => -106,
			'OP04_MATH_POW' => 253,
			"}" => -106,
			'OP14_BITWISE_OR_XOR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP17_LIST_RANGE' => -106,
			";" => -106
		}
	},
	{#State 325
		DEFAULT => -247
	},
	{#State 326
		ACTIONS => {
			'COLON' => 372
		}
	},
	{#State 327
		DEFAULT => -248
	},
	{#State 328
		ACTIONS => {
			'OP21_LIST_COMMA' => -123,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -123,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP23_LOGICAL_AND' => -123,
			"]" => -123,
			'OP16_LOGICAL_OR' => -123,
			'OP06_REGEX_BIND' => 245,
			";" => -123,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => -123,
			'OP17_LIST_RANGE' => -123,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => -123,
			'OP04_MATH_POW' => 253,
			"}" => -123
		}
	},
	{#State 329
		ACTIONS => {
			")" => 373,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP23_LOGICAL_AND' => 244,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243
		}
	},
	{#State 330
		ACTIONS => {
			";" => 374
		}
	},
	{#State 331
		DEFAULT => -107
	},
	{#State 332
		DEFAULT => -126
	},
	{#State 333
		DEFAULT => -56
	},
	{#State 334
		ACTIONS => {
			'WORD_UPPERCASE' => 375
		}
	},
	{#State 335
		ACTIONS => {
			"\$RETURN_TYPE" => 376
		}
	},
	{#State 336
		ACTIONS => {
			"}" => 377
		}
	},
	{#State 337
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 378
		}
	},
	{#State 338
		DEFAULT => -75,
		GOTOS => {
			'STAR-32' => 379
		}
	},
	{#State 339
		DEFAULT => -72
	},
	{#State 340
		DEFAULT => -222
	},
	{#State 341
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"\@{" => 114,
			'WORD' => 31,
			"undef" => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'Literal' => 113,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 380
		}
	},
	{#State 342
		DEFAULT => -229
	},
	{#State 343
		ACTIONS => {
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 162,
			'OP23_LOGICAL_AND' => 163,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ENV' => 170,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 169,
			'OP19_LOOP_CONTROL' => 179,
			'OP01_PRINT' => 168,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP07_STRING_REPEAT' => 166,
			'OP01_OPEN' => 165,
			'OP01_CLOSE' => 158,
			'WORD' => 156,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP01_NAMED' => 175,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'LITERAL_NUMBER' => 106,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP01_NAMED_VOID' => 173,
			'OP11_COMPARE_LT_GT' => 159
		},
		GOTOS => {
			'OpStringOrWord' => 180,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 157,
			'VarOrLitOrOpStrOrWord' => 167,
			'HashEntry' => 381,
			'Variable' => 164,
			'Literal' => 171
		}
	},
	{#State 344
		DEFAULT => -231
	},
	{#State 345
		ACTIONS => {
			")" => 382
		}
	},
	{#State 346
		ACTIONS => {
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			"%{" => 102,
			'MY' => 195,
			'OP01_QW' => 189,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95
		},
		GOTOS => {
			'ArrayReference' => 135,
			'ListElements' => 383,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'SubExpression' => 191,
			'Variable' => 182,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 194,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'TypeInner' => 190,
			'HashDereference' => 146
		}
	},
	{#State 347
		ACTIONS => {
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'MY' => 195,
			'OP01_QW' => 189,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'ARGV' => 193,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 191,
			'WordScoped' => 110,
			'VariableSymbolOrSelf' => 128,
			'ListElement' => 384,
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'TypeInner' => 190
		}
	},
	{#State 348
		DEFAULT => -208
	},
	{#State 349
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP01_NAMED' => 175,
			'OP11_COMPARE_LT_GT' => 159,
			'OP01_NAMED_VOID' => 173,
			'OP01_CLOSE' => 158,
			'WORD' => 156,
			'OP19_LOOP_CONTROL' => 179,
			'OP22_LOGICAL_NEG' => 169,
			'OP07_STRING_REPEAT' => 166,
			'OP01_OPEN' => 165,
			'OP01_PRINT' => 168,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP23_LOGICAL_AND' => 163,
			'OP10_NAMED_UNARY' => 162
		},
		GOTOS => {
			'OpStringOrWord' => 385
		}
	},
	{#State 350
		DEFAULT => -236
	},
	{#State 351
		ACTIONS => {
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => 386,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241
		}
	},
	{#State 352
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 355
		ACTIONS => {
			'VARIABLE_SYMBOL' => 390
		}
	},
	{#State 356
		ACTIONS => {
			";" => 391
		}
	},
	{#State 357
		DEFAULT => -154
	},
	{#State 358
		DEFAULT => -152
	},
	{#State 359
		DEFAULT => -221
	},
	{#State 360
		ACTIONS => {
			'OP21_LIST_COMMA' => 392
		}
	},
	{#State 361
		DEFAULT => -145
	},
	{#State 362
		ACTIONS => {
			")" => 393
		}
	},
	{#State 363
		DEFAULT => -136
	},
	{#State 364
		DEFAULT => -135
	},
	{#State 365
		ACTIONS => {
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			"]" => 394,
			'OP23_LOGICAL_AND' => 244,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249
		}
	},
	{#State 366
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			"}" => 395,
			'OP04_MATH_POW' => 253
		}
	},
	{#State 367
		ACTIONS => {
			"}" => 396,
			'LPAREN' => -237,
			'OP02_METHOD_THINARROW_NEW' => -237
		}
	},
	{#State 368
		DEFAULT => -201
	},
	{#State 369
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_STRING' => 132,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141
		},
		GOTOS => {
			'Literal' => 113,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'VariableSymbolOrSelf' => 128,
			'Variable' => 182,
			'SubExpression' => 397,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120
		}
	},
	{#State 370
		ACTIONS => {
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'FHREF_SYMBOL_IN' => 298,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'STDIN' => 297,
			'OP01_NAMED_SCOLON' => 400,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 398
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'SubExpressionOrInput' => 399,
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 182,
			'SubExpression' => 296,
			'OpNamedScolonOrSubExpIn' => 401,
			'WordScoped' => 110
		}
	},
	{#State 371
		DEFAULT => -204
	},
	{#State 372
		ACTIONS => {
			'SELF' => 119,
			'LITERAL_NUMBER' => 106,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133
		},
		GOTOS => {
			'Variable' => 325,
			'Literal' => 327,
			'VariableSymbolOrSelf' => 128,
			'VariableOrLiteral' => 402
		}
	},
	{#State 373
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 374
		DEFAULT => -138
	},
	{#State 375
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 405
		}
	},
	{#State 376
		ACTIONS => {
			"}" => 406
		}
	},
	{#State 377
		DEFAULT => -55
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 407
		}
	},
	{#State 379
		ACTIONS => {
			'LITERAL_NUMBER' => 411,
			'SUB' => 410
		},
		GOTOS => {
			'SubroutineOrMethod' => 412,
			'Subroutine' => 409,
			'Method' => 408
		}
	},
	{#State 380
		ACTIONS => {
			'OP23_LOGICAL_AND' => 244,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252,
			"}" => -224,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP21_LIST_COMMA' => -224,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248
		}
	},
	{#State 381
		DEFAULT => -228
	},
	{#State 382
		DEFAULT => -99
	},
	{#State 383
		ACTIONS => {
			")" => 413
		}
	},
	{#State 384
		DEFAULT => -207
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 414
		}
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 387
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 388
		ACTIONS => {
			'LPAREN' => 417
		}
	},
	{#State 389
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 418
		}
	},
	{#State 390
		ACTIONS => {
			'LPAREN' => 419
		}
	},
	{#State 391
		DEFAULT => -140
	},
	{#State 392
		ACTIONS => {
			'LITERAL_STRING' => 420
		}
	},
	{#State 393
		DEFAULT => -153
	},
	{#State 394
		DEFAULT => -198
	},
	{#State 395
		DEFAULT => -199
	},
	{#State 396
		DEFAULT => -200
	},
	{#State 397
		ACTIONS => {
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			"]" => 421,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 398
		DEFAULT => -260
	},
	{#State 399
		ACTIONS => {
			";" => 422
		}
	},
	{#State 400
		DEFAULT => -259
	},
	{#State 401
		DEFAULT => -202
	},
	{#State 402
		DEFAULT => -125
	},
	{#State 403
		DEFAULT => -179,
		GOTOS => {
			'STAR-48' => 423
		}
	},
	{#State 404
		ACTIONS => {
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'MY' => 129,
			'VARIABLE_SYMBOL' => 133,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_PRINT' => 127,
			'OP01_OPEN' => 123,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			"if" => 138,
			"foreach" => -171,
			'OP01_NAMED_VOID_LPAREN' => 140,
			'OP01_NAMED_SCOLON' => 147,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			'OP05_LOGICAL_NEG' => 136,
			"for" => -171,
			"%{" => 102,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP19_LOOP_CONTROL' => 94,
			'WORD_UPPERCASE' => 99,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			"while" => -171,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			'OP01_NAMED' => 107,
			'LITERAL_NUMBER' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP01_NAMED_VOID' => 111
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'Operation' => 425,
			'HashReference' => 103,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Variable' => 124,
			'Statement' => 126,
			'OperatorVoid' => 139,
			'LoopLabel' => 112,
			'PAREN-45' => 142,
			'PLUS-51' => 424,
			'Literal' => 113,
			'HashDereference' => 146,
			'Expression' => 117,
			'VariableDeclaration' => 145,
			'Conditional' => 116,
			'ArrayReference' => 135,
			'OPTIONAL-46' => 105,
			'SubExpression' => 137,
			'VariableModification' => 109,
			'WordScoped' => 110
		}
	},
	{#State 405
		DEFAULT => -246
	},
	{#State 406
		ACTIONS => {
			";" => 426
		}
	},
	{#State 407
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 159,
			'OP01_NAMED_VOID' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP01_NAMED' => 175,
			'WORD' => 156,
			'OP01_CLOSE' => 158,
			"}" => 429,
			'OP01_OPEN' => 165,
			'OP07_STRING_REPEAT' => 166,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP01_PRINT' => 168,
			'OP22_LOGICAL_NEG' => 169,
			'OP19_LOOP_CONTROL' => 179,
			'OP10_NAMED_UNARY' => 162,
			'OP23_LOGICAL_AND' => 163
		},
		GOTOS => {
			'HashEntryProperties' => 427,
			'OpStringOrWord' => 428
		}
	},
	{#State 408
		DEFAULT => -94
	},
	{#State 409
		DEFAULT => -93
	},
	{#State 410
		ACTIONS => {
			'WORD' => 430
		}
	},
	{#State 411
		ACTIONS => {
			";" => 431
		}
	},
	{#State 412
		DEFAULT => -74
	},
	{#State 413
		DEFAULT => -101
	},
	{#State 414
		DEFAULT => -243
	},
	{#State 415
		DEFAULT => -190
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'FHREF_SYMBOL_IN' => 298,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'STDIN' => 297,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187
		},
		GOTOS => {
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 296,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'SubExpressionOrInput' => 432
		}
	},
	{#State 417
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			"\@{" => 114,
			"undef" => 115,
			'WORD' => 31,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130
		},
		GOTOS => {
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128,
			'Variable' => 182,
			'SubExpression' => 433,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'ArrayDereference' => 121,
			'Operator' => 120
		}
	},
	{#State 418
		ACTIONS => {
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_NAMED_SCOLON' => 434,
			'OP10_NAMED_UNARY_SCOLON' => 437,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 435,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'OpNamedScolonOrSubExp' => 436,
			'ArrayReference' => 135,
			'HashReference' => 103,
			'Expression' => 186,
			'HashDereference' => 146,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 419
		ACTIONS => {
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'ARGV' => 193,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132,
			'OP01_QW' => 189,
			'MY' => 195
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 191,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'ListElements' => 438,
			'Expression' => 186,
			'HashReference' => 103,
			'HashDereference' => 146,
			'TypeInner' => 190,
			'Literal' => 113,
			'ListElement' => 194,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 420
		ACTIONS => {
			'OP21_LIST_COMMA' => 439
		}
	},
	{#State 421
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 440
		}
	},
	{#State 422
		DEFAULT => -261
	},
	{#State 423
		ACTIONS => {
			'WORD_SCOPED' => -182,
			"\@{" => -182,
			"undef" => -182,
			"while" => -182,
			'OP01_NAMED_VOID' => -182,
			'OP19_LOOP_CONTROL_SCOLON' => -182,
			'LITERAL_NUMBER' => -182,
			'OP01_NAMED' => -182,
			'OP10_NAMED_UNARY_SCOLON' => -182,
			"%{" => -182,
			'WORD_UPPERCASE' => -182,
			'CONSTANT_CALL_SCOPED' => -182,
			"}" => -182,
			'LBRACKET' => -182,
			'LBRACE' => -182,
			'LPAREN' => -182,
			'OP19_LOOP_CONTROL' => -182,
			'OP01_NAMED_SCOLON' => -182,
			'OP22_LOGICAL_NEG_LPAREN' => -182,
			'' => -182,
			'WORD' => -182,
			'OP05_BITWISE_NEG_LPAREN' => -182,
			'OP01_CLOSE' => -182,
			"foreach" => -182,
			"if" => -182,
			'OP01_NAMED_VOID_LPAREN' => -182,
			"for" => -182,
			"else" => 445,
			'OP05_LOGICAL_NEG' => -182,
			"elsif" => 444,
			'VARIABLE_SYMBOL' => -182,
			'OP05_MATH_NEG_LPAREN' => -182,
			'OP10_NAMED_UNARY' => -182,
			'LITERAL_STRING' => -182,
			'MY' => -182,
			'OP03_MATH_INC_DEC' => -182,
			'OP01_PRINT' => -182,
			'OP01_OPEN' => -182,
			'OP01_NAMED_VOID_SCOLON' => -182,
			'OP22_LOGICAL_NEG' => -182,
			'SELF' => -182
		},
		GOTOS => {
			'PAREN-49' => 442,
			'PAREN-47' => 441,
			'OPTIONAL-50' => 443
		}
	},
	{#State 424
		ACTIONS => {
			"undef" => 115,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			"while" => -171,
			'OP01_NAMED_VOID' => 111,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			"%{" => 102,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"}" => 446,
			'WORD_UPPERCASE' => 99,
			'OP19_LOOP_CONTROL' => 94,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'OP01_NAMED_SCOLON' => 147,
			'OP01_NAMED_VOID_LPAREN' => 140,
			"if" => 138,
			"foreach" => -171,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"for" => -171,
			'OP05_LOGICAL_NEG' => 136,
			'VARIABLE_SYMBOL' => 133,
			'MY' => 129,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'OP01_OPEN' => 123,
			'OP01_PRINT' => 127,
			'OP03_MATH_INC_DEC' => 125,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP01_NAMED_VOID_SCOLON' => 122
		},
		GOTOS => {
			'Statement' => 126,
			'Variable' => 124,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'HashReference' => 103,
			'Operation' => 447,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'VariableModification' => 109,
			'SubExpression' => 137,
			'OPTIONAL-46' => 105,
			'ArrayReference' => 135,
			'VariableDeclaration' => 145,
			'Conditional' => 116,
			'Expression' => 117,
			'HashDereference' => 146,
			'Literal' => 113,
			'PAREN-45' => 142,
			'LoopLabel' => 112,
			'OperatorVoid' => 139
		}
	},
	{#State 425
		DEFAULT => -193
	},
	{#State 426
		ACTIONS => {
			"if" => -58,
			"foreach" => -58,
			'OP01_NAMED_VOID_LPAREN' => -58,
			'OP05_BITWISE_NEG_LPAREN' => -58,
			'OP01_CLOSE' => -58,
			'OP22_LOGICAL_NEG_LPAREN' => -58,
			'WORD' => -58,
			'OP01_NAMED_SCOLON' => -58,
			'OP05_LOGICAL_NEG' => -58,
			"for" => -58,
			'MY' => -58,
			'OP10_NAMED_UNARY' => -58,
			'OP05_MATH_NEG_LPAREN' => -58,
			'LITERAL_STRING' => -58,
			'VARIABLE_SYMBOL' => -58,
			'OP22_LOGICAL_NEG' => -58,
			'SELF' => -58,
			'OP01_NAMED_VOID_SCOLON' => -58,
			'LPAREN_MY' => 448,
			'OP01_OPEN' => -58,
			'OP03_MATH_INC_DEC' => -58,
			'OP01_PRINT' => -58,
			"while" => -58,
			'WORD_SCOPED' => -58,
			"\@{" => -58,
			"undef" => -58,
			'OP10_NAMED_UNARY_SCOLON' => -58,
			'OP01_NAMED' => -58,
			'OP19_LOOP_CONTROL_SCOLON' => -58,
			'LITERAL_NUMBER' => -58,
			'OP01_NAMED_VOID' => -58,
			"%{" => -58,
			'OP19_LOOP_CONTROL' => -58,
			'LBRACE' => -58,
			'LPAREN' => -58,
			'CONSTANT_CALL_SCOPED' => -58,
			"}" => -58,
			'LBRACKET' => -58,
			'WORD_UPPERCASE' => -58
		},
		GOTOS => {
			'SubroutineArguments' => 449,
			'OPTIONAL-24' => 450
		}
	},
	{#State 427
		DEFAULT => -81,
		GOTOS => {
			'STAR-34' => 451
		}
	},
	{#State 428
		ACTIONS => {
			'OP20_HASH_FATARROW' => 452
		}
	},
	{#State 429
		ACTIONS => {
			";" => 453
		}
	},
	{#State 430
		ACTIONS => {
			'LBRACE' => 454
		}
	},
	{#State 431
		DEFAULT => -76
	},
	{#State 432
		ACTIONS => {
			")" => 455
		}
	},
	{#State 433
		ACTIONS => {
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 456,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245
		}
	},
	{#State 434
		DEFAULT => -256
	},
	{#State 435
		ACTIONS => {
			'OP23_LOGICAL_AND' => 244,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			";" => 457,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => 254,
			'OP07_STRING_REPEAT' => 243,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242
		}
	},
	{#State 436
		ACTIONS => {
			'VARIABLE_SYMBOL' => 458
		}
	},
	{#State 437
		DEFAULT => -257
	},
	{#State 438
		ACTIONS => {
			")" => 459
		}
	},
	{#State 439
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY' => 130,
			'OP05_MATH_NEG_LPAREN' => 131,
			'LITERAL_STRING' => 132
		},
		GOTOS => {
			'SubExpression' => 460,
			'Variable' => 182,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 440
		ACTIONS => {
			"undef" => 461
		}
	},
	{#State 441
		DEFAULT => -178
	},
	{#State 442
		DEFAULT => -181
	},
	{#State 443
		DEFAULT => -183
	},
	{#State 444
		ACTIONS => {
			'LPAREN' => 462
		}
	},
	{#State 445
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 463
		}
	},
	{#State 446
		DEFAULT => -194
	},
	{#State 447
		DEFAULT => -192
	},
	{#State 448
		ACTIONS => {
			'WORD' => 234,
			'WORD_SCOPED' => 232,
			'TYPE_INTEGER' => 233
		},
		GOTOS => {
			'Type' => 464
		}
	},
	{#State 449
		DEFAULT => -57
	},
	{#State 450
		DEFAULT => -60,
		GOTOS => {
			'STAR-25' => 465
		}
	},
	{#State 451
		ACTIONS => {
			"}" => 467,
			'OP21_LIST_COMMA' => 468
		},
		GOTOS => {
			'PAREN-33' => 466
		}
	},
	{#State 452
		ACTIONS => {
			'MY' => 470
		},
		GOTOS => {
			'TypeInnerProperties' => 469
		}
	},
	{#State 453
		DEFAULT => -83
	},
	{#State 454
		ACTIONS => {
			'LBRACE' => 471
		}
	},
	{#State 455
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 472
		}
	},
	{#State 456
		ACTIONS => {
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 187,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 182,
			'SubExpression' => 473,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 457
		DEFAULT => -258
	},
	{#State 458
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 474
		}
	},
	{#State 459
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 475
		}
	},
	{#State 460
		ACTIONS => {
			"]" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP17_LIST_RANGE' => 250,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253,
			"}" => -102,
			";" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP11_COMPARE_LT_GT' => 241,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => -102,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_STRING_CAT' => 247
		}
	},
	{#State 461
		ACTIONS => {
			";" => 476
		}
	},
	{#State 462
		ACTIONS => {
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 477,
			'Variable' => 182,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'HashDereference' => 146,
			'HashReference' => 103,
			'Expression' => 186,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 463
		DEFAULT => -180
	},
	{#State 464
		ACTIONS => {
			'VARIABLE_SYMBOL' => 478
		}
	},
	{#State 465
		ACTIONS => {
			"}" => 480,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 99,
			'OP19_LOOP_CONTROL' => 94,
			'LBRACE' => 95,
			'LPAREN' => 96,
			"%{" => 102,
			'OP01_NAMED_VOID' => 111,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			'OP01_NAMED' => 107,
			'LITERAL_NUMBER' => 106,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			"while" => -171,
			'OP01_OPEN' => 123,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_PRINT' => 127,
			'SELF' => 119,
			'OP22_LOGICAL_NEG' => 118,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'VARIABLE_SYMBOL' => 133,
			'MY' => 129,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			"for" => -171,
			'OP05_LOGICAL_NEG' => 136,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			'OP01_NAMED_SCOLON' => 147,
			"foreach" => -171,
			"if" => 138,
			'OP01_NAMED_VOID_LPAREN' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143
		},
		GOTOS => {
			'Literal' => 113,
			'VariableDeclaration' => 145,
			'Expression' => 117,
			'Conditional' => 116,
			'HashDereference' => 146,
			'OperatorVoid' => 139,
			'PAREN-45' => 142,
			'LoopLabel' => 112,
			'VariableModification' => 109,
			'SubExpression' => 137,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'OPTIONAL-46' => 105,
			'Operation' => 479,
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 128,
			'Variable' => 124,
			'Statement' => 126,
			'Operator' => 120,
			'ArrayDereference' => 121
		}
	},
	{#State 466
		DEFAULT => -80
	},
	{#State 467
		ACTIONS => {
			";" => 481
		}
	},
	{#State 468
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP01_NAMED' => 175,
			'OP11_COMPARE_LT_GT' => 159,
			'OP01_NAMED_VOID' => 173,
			'OP01_CLOSE' => 158,
			'WORD' => 156,
			'OP19_LOOP_CONTROL' => 179,
			'OP22_LOGICAL_NEG' => 169,
			'OP01_OPEN' => 165,
			'OP07_STRING_REPEAT' => 166,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP01_PRINT' => 168,
			'OP23_LOGICAL_AND' => 163,
			'OP10_NAMED_UNARY' => 162
		},
		GOTOS => {
			'OpStringOrWord' => 428,
			'HashEntryProperties' => 482
		}
	},
	{#State 469
		DEFAULT => -227
	},
	{#State 470
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD' => 234,
			'WORD_SCOPED' => 232
		},
		GOTOS => {
			'Type' => 483
		}
	},
	{#State 471
		ACTIONS => {
			'MY' => 484
		}
	},
	{#State 472
		DEFAULT => -191
	},
	{#State 473
		ACTIONS => {
			'OP23_LOGICAL_AND' => -124,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP24_LOGICAL_OR_XOR' => -124,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			'OP18_TERNARY' => -124,
			'OP07_STRING_REPEAT' => 243,
			")" => 485,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP11_COMPARE_LT_GT' => 241,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249
		}
	},
	{#State 474
		ACTIONS => {
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 123,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'OP05_LOGICAL_NEG' => 136,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 106,
			'OP10_NAMED_UNARY_SCOLON' => 437,
			'OP01_NAMED_SCOLON' => 434,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			"undef" => 115,
			'WORD' => 31,
			"\@{" => 114,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayDereference' => 121,
			'OpNamedScolonOrSubExp' => 486,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'SubExpression' => 435,
			'Variable' => 182,
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113
		}
	},
	{#State 475
		DEFAULT => -189
	},
	{#State 476
		DEFAULT => -203
	},
	{#State 477
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP09_BITWISE_SHIFT' => 246,
			")" => 487,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241
		}
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
		DEFAULT => -82
	},
	{#State 482
		DEFAULT => -79
	},
	{#State 483
		ACTIONS => {
			"\$TYPED_" => 489
		}
	},
	{#State 484
		ACTIONS => {
			'TYPE_METHOD' => 490,
			'TYPE_INTEGER' => 233,
			'WORD' => 234,
			'WORD_SCOPED' => 232
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 485
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 491
		}
	},
	{#State 486
		ACTIONS => {
			"%{" => 102,
			'VARIABLE_SYMBOL' => 133,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			"\@{" => 114,
			"undef" => 115,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 128,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'ArrayReference' => 135,
			'SubExpressionOrVarMod' => 494,
			'WordScoped' => 110,
			'Variable' => 124,
			'SubExpression' => 492,
			'VariableModification' => 493
		}
	},
	{#State 487
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 495
		}
	},
	{#State 488
		ACTIONS => {
			'OP21_LIST_COMMA' => 496,
			")" => 498
		},
		GOTOS => {
			'PAREN-26' => 497
		}
	},
	{#State 489
		ACTIONS => {
			'OP01_NAMED_VOID' => 173,
			'OP11_COMPARE_LT_GT' => 159,
			'OP01_NAMED' => 175,
			'OP19_LOOP_CONTROL_SCOLON' => 176,
			'OP12_COMPARE_EQ_NE' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 160,
			'OP08_MATH_ADD_SUB' => 174,
			'WORD' => 156,
			'OP01_CLOSE' => 158,
			'OP01_PRINT' => 168,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP01_OPEN' => 165,
			'OP07_STRING_REPEAT' => 166,
			'OP22_LOGICAL_NEG' => 169,
			'OP19_LOOP_CONTROL' => 179,
			'OP23_LOGICAL_AND' => 163,
			'OP10_NAMED_UNARY' => 162
		},
		GOTOS => {
			'OpStringOrWord' => 499
		}
	},
	{#State 490
		ACTIONS => {
			"\$RETURN_TYPE" => 500
		}
	},
	{#State 491
		DEFAULT => -187
	},
	{#State 492
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			")" => -167,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP08_STRING_CAT' => 247,
			'OP13_BITWISE_AND' => 242,
			'OP15_LOGICAL_AND' => 249,
			'OP11_COMPARE_LT_GT' => 241,
			'OP23_LOGICAL_AND' => 244,
			'OP16_LOGICAL_OR' => 255,
			'OP06_REGEX_BIND' => 245,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP04_MATH_POW' => 253
		}
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
		DEFAULT => -177
	},
	{#State 496
		ACTIONS => {
			'MY' => 502
		}
	},
	{#State 497
		DEFAULT => -63
	},
	{#State 498
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 503
		}
	},
	{#State 499
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 505,
			'OP19_VARIABLE_ASSIGN' => 504
		}
	},
	{#State 500
		ACTIONS => {
			"}" => 506
		}
	},
	{#State 501
		ACTIONS => {
			'LBRACE' => 404
		},
		GOTOS => {
			'CodeBlock' => 507
		}
	},
	{#State 502
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD' => 234,
			'WORD_SCOPED' => 232
		},
		GOTOS => {
			'Type' => 508
		}
	},
	{#State 503
		ACTIONS => {
			"\@ARG;" => 509
		}
	},
	{#State 504
		ACTIONS => {
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'WORD' => 31,
			"undef" => 115,
			"\@{" => 114,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'WORD_UPPERCASE' => 184,
			'OP03_MATH_INC_DEC' => 125,
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102
		},
		GOTOS => {
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'Literal' => 113,
			'VariableSymbolOrSelf' => 128,
			'WordScoped' => 110,
			'SubExpression' => 510,
			'Variable' => 182,
			'ArrayDereference' => 121,
			'Operator' => 120,
			'ArrayReference' => 135
		}
	},
	{#State 505
		ACTIONS => {
			'LITERAL_STRING' => 132,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'VARIABLE_SYMBOL' => 133,
			"%{" => 102,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'LPAREN' => 96,
			'LBRACE' => 95,
			'OP01_OPEN' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP03_MATH_INC_DEC' => 125,
			'WORD_UPPERCASE' => 184,
			'OP01_CLOSE' => 143,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			"undef" => 115,
			"\@{" => 114,
			'WORD' => 31,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 187,
			'OP05_LOGICAL_NEG' => 136,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'Variable' => 182,
			'SubExpression' => 511,
			'WordScoped' => 110,
			'ArrayReference' => 135,
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Literal' => 113,
			'HashDereference' => 146,
			'Expression' => 186,
			'HashReference' => 103,
			'VariableSymbolOrSelf' => 128
		}
	},
	{#State 506
		ACTIONS => {
			";" => 512
		}
	},
	{#State 507
		DEFAULT => -188
	},
	{#State 508
		ACTIONS => {
			'VARIABLE_SYMBOL' => 513
		}
	},
	{#State 509
		DEFAULT => -65
	},
	{#State 510
		ACTIONS => {
			'OP08_STRING_CAT' => 247,
			'OP08_MATH_ADD_SUB' => 248,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP21_LIST_COMMA' => -244,
			"}" => -244,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP17_LIST_RANGE' => 250,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255,
			'OP23_LOGICAL_AND' => 244
		}
	},
	{#State 511
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 246,
			'OP12_COMPARE_EQ_NE' => 239,
			'OP08_STRING_CAT' => 247,
			'OP07_MATH_MULT_DIV_MOD' => 240,
			'OP08_MATH_ADD_SUB' => 248,
			'OP11_COMPARE_LT_GT' => 241,
			'OP15_LOGICAL_AND' => 249,
			'OP13_BITWISE_AND' => 242,
			'OP17_LIST_RANGE' => 250,
			'OP24_LOGICAL_OR_XOR' => 251,
			'OP14_BITWISE_OR_XOR' => 252,
			'OP04_MATH_POW' => 253,
			'OP07_STRING_REPEAT' => 243,
			'OP18_TERNARY' => 254,
			"]" => 514,
			'OP23_LOGICAL_AND' => 244,
			'OP06_REGEX_BIND' => 245,
			'OP16_LOGICAL_OR' => 255
		}
	},
	{#State 512
		ACTIONS => {
			'MY' => -85,
			'OP10_NAMED_UNARY' => -85,
			'OP05_MATH_NEG_LPAREN' => -85,
			'LITERAL_STRING' => -85,
			'VARIABLE_SYMBOL' => -85,
			'OP22_LOGICAL_NEG' => -85,
			'SELF' => -85,
			'OP01_NAMED_VOID_SCOLON' => -85,
			'LPAREN_MY' => 516,
			'OP01_OPEN' => -85,
			'OP03_MATH_INC_DEC' => -85,
			'OP01_PRINT' => -85,
			"foreach" => -85,
			"if" => -85,
			'OP01_NAMED_VOID_LPAREN' => -85,
			'OP05_BITWISE_NEG_LPAREN' => -85,
			'OP01_CLOSE' => -85,
			'OP22_LOGICAL_NEG_LPAREN' => -85,
			'WORD' => -85,
			'OP01_NAMED_SCOLON' => -85,
			'OP05_LOGICAL_NEG' => -85,
			"for" => -85,
			"%{" => -85,
			'OP19_LOOP_CONTROL' => -85,
			'LBRACE' => -85,
			'LPAREN' => -85,
			"}" => -85,
			'CONSTANT_CALL_SCOPED' => -85,
			'LBRACKET' => -85,
			'WORD_UPPERCASE' => -85,
			"while" => -85,
			'WORD_SCOPED' => -85,
			"\@{" => -85,
			"undef" => -85,
			'OP10_NAMED_UNARY_SCOLON' => -85,
			'OP19_LOOP_CONTROL_SCOLON' => -85,
			'OP01_NAMED' => -85,
			'LITERAL_NUMBER' => -85,
			'OP01_NAMED_VOID' => -85
		},
		GOTOS => {
			'OPTIONAL-35' => 515,
			'MethodArguments' => 517
		}
	},
	{#State 513
		DEFAULT => -62
	},
	{#State 514
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 518
		}
	},
	{#State 515
		DEFAULT => -87,
		GOTOS => {
			'STAR-36' => 519
		}
	},
	{#State 516
		ACTIONS => {
			'TYPE_INTEGER' => 233,
			'WORD' => 234,
			'WORD_SCOPED' => 232
		},
		GOTOS => {
			'Type' => 520
		}
	},
	{#State 517
		DEFAULT => -84
	},
	{#State 518
		ACTIONS => {
			"undef" => 521
		}
	},
	{#State 519
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 136,
			"for" => -171,
			"if" => 138,
			"foreach" => -171,
			'OP01_NAMED_VOID_LPAREN' => 140,
			'OP05_BITWISE_NEG_LPAREN' => 141,
			'OP01_CLOSE' => 143,
			'OP22_LOGICAL_NEG_LPAREN' => 144,
			'WORD' => 31,
			'OP01_NAMED_SCOLON' => 147,
			'OP22_LOGICAL_NEG' => 118,
			'SELF' => 119,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP01_OPEN' => 123,
			'OP03_MATH_INC_DEC' => 125,
			'OP01_PRINT' => 127,
			'MY' => 129,
			'OP05_MATH_NEG_LPAREN' => 131,
			'OP10_NAMED_UNARY' => 130,
			'LITERAL_STRING' => 132,
			'VARIABLE_SYMBOL' => 133,
			'OP10_NAMED_UNARY_SCOLON' => 104,
			'OP01_NAMED' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 108,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED_VOID' => 111,
			"while" => -171,
			'WORD_SCOPED' => 30,
			"\@{" => 114,
			"undef" => 115,
			'OP19_LOOP_CONTROL' => 94,
			'LBRACE' => 95,
			'LPAREN' => 96,
			'CONSTANT_CALL_SCOPED' => 97,
			"}" => 522,
			'LBRACKET' => 98,
			'WORD_UPPERCASE' => 99,
			"%{" => 102
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayDereference' => 121,
			'Statement' => 126,
			'Variable' => 124,
			'VariableSymbolOrSelf' => 128,
			'HashReference' => 103,
			'Operation' => 523,
			'OPTIONAL-46' => 105,
			'ArrayReference' => 135,
			'WordScoped' => 110,
			'VariableModification' => 109,
			'SubExpression' => 137,
			'PAREN-45' => 142,
			'LoopLabel' => 112,
			'OperatorVoid' => 139,
			'VariableDeclaration' => 145,
			'Conditional' => 116,
			'Expression' => 117,
			'HashDereference' => 146,
			'Literal' => 113
		}
	},
	{#State 520
		ACTIONS => {
			'SELF' => 524
		}
	},
	{#State 521
		DEFAULT => -245
	},
	{#State 522
		DEFAULT => -88
	},
	{#State 523
		DEFAULT => -86
	},
	{#State 524
		DEFAULT => -91,
		GOTOS => {
			'STAR-38' => 525
		}
	},
	{#State 525
		ACTIONS => {
			'OP21_LIST_COMMA' => 528,
			")" => 526
		},
		GOTOS => {
			'PAREN-37' => 527
		}
	},
	{#State 526
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 529
		}
	},
	{#State 527
		DEFAULT => -90
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
			'WORD_SCOPED' => 232,
			'WORD' => 234,
			'TYPE_INTEGER' => 233
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
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
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
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7479 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
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
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
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
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-14', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
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
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7681 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
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
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
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
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 3,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
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
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-22', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7791 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
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
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7845 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-24', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
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
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
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
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
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
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-34', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
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
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8069 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 2,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-36', 0,
sub {
#line 211 "lib/RPerl/Grammar.eyp"
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
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 212 "lib/RPerl/Grammar.eyp"
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
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8540 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8547 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 232 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8554 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8561 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 233 "lib/RPerl/Grammar.eyp"
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
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8663 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 235 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8670 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8677 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8684 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 1,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-44', 0,
sub {
#line 236 "lib/RPerl/Grammar.eyp"
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
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8932 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 240 "lib/RPerl/Grammar.eyp"
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
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 9015 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9022 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9029 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 241 "lib/RPerl/Grammar.eyp"
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
#line 247 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-51', 1,
sub {
#line 247 "lib/RPerl/Grammar.eyp"
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
#line 251 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9167 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 251 "lib/RPerl/Grammar.eyp"
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
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9291 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 2,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9298 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-54', 0,
sub {
#line 256 "lib/RPerl/Grammar.eyp"
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
#line 258 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9367 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-55', 0,
sub {
#line 258 "lib/RPerl/Grammar.eyp"
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
#line 259 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-56', 0,
sub {
#line 259 "lib/RPerl/Grammar.eyp"
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
#line 260 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9428 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-57', 0,
sub {
#line 260 "lib/RPerl/Grammar.eyp"
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
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 9486 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 2,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 9493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-59', 0,
sub {
#line 262 "lib/RPerl/Grammar.eyp"
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
#line 263 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 9529 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-60', 0,
sub {
#line 263 "lib/RPerl/Grammar.eyp"
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

#line 284 "lib/RPerl/Grammar.eyp"


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
